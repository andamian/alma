
/*
 ************************************************************************
 *******************  CANADIAN ASTRONOMY DATA CENTRE  *******************
 **************  CENTRE CANADIEN DE DONNÉES ASTRONOMIQUES  **************
 *
 *  (c) 2019.                            (c) 2019.
 *  Government of Canada                 Gouvernement du Canada
 *  National Research Council            Conseil national de recherches
 *  Ottawa, Canada, K1A 0R6              Ottawa, Canada, K1A 0R6
 *  All rights reserved                  Tous droits réservés
 *
 *  NRC disclaims any warranties,        Le CNRC dénie toute garantie
 *  expressed, implied, or               énoncée, implicite ou légale,
 *  statutory, of any kind with          de quelque nature que ce
 *  respect to the software,             soit, concernant le logiciel,
 *  including without limitation         y compris sans restriction
 *  any warranty of merchantability      toute garantie de valeur
 *  or fitness for a particular          marchande ou de pertinence
 *  purpose. NRC shall not be            pour un usage particulier.
 *  liable in any event for any          Le CNRC ne pourra en aucun cas
 *  damages, whether direct or           être tenu responsable de tout
 *  indirect, special or general,        dommage, direct ou indirect,
 *  consequential or incidental,         particulier ou général,
 *  arising from the use of the          accessoire ou fortuit, résultant
 *  software.  Neither the name          de l'utilisation du logiciel. Ni
 *  of the National Research             le nom du Conseil National de
 *  Council of Canada nor the            Recherches du Canada ni les noms
 *  names of its contributors may        de ses  participants ne peuvent
 *  be used to endorse or promote        être utilisés pour approuver ou
 *  products derived from this           promouvoir les produits dérivés
 *  software without specific prior      de ce logiciel sans autorisation
 *  written permission.                  préalable et particulière
 *                                       par écrit.
 *
 *  This file is part of the             Ce fichier fait partie du projet
 *  OpenCADC project.                    OpenCADC.
 *
 *  OpenCADC is free software:           OpenCADC est un logiciel libre ;
 *  you can redistribute it and/or       vous pouvez le redistribuer ou le
 *  modify it under the terms of         modifier suivant les termes de
 *  the GNU Affero General Public        la “GNU Affero General Public
 *  License as published by the          License” telle que publiée
 *  Free Software Foundation,            par la Free Software Foundation
 *  either version 3 of the              : soit la version 3 de cette
 *  License, or (at your option)         licence, soit (à votre gré)
 *  any later version.                   toute version ultérieure.
 *
 *  OpenCADC is distributed in the       OpenCADC est distribué
 *  hope that it will be useful,         dans l’espoir qu’il vous
 *  but WITHOUT ANY WARRANTY;            sera utile, mais SANS AUCUNE
 *  without even the implied             GARANTIE : sans même la garantie
 *  warranty of MERCHANTABILITY          implicite de COMMERCIALISABILITÉ
 *  or FITNESS FOR A PARTICULAR          ni d’ADÉQUATION À UN OBJECTIF
 *  PURPOSE.  See the GNU Affero         PARTICULIER. Consultez la Licence
 *  General Public License for           Générale Publique GNU Affero
 *  more details.                        pour plus de détails.
 *
 *  You should have received             Vous devriez avoir reçu une
 *  a copy of the GNU Affero             copie de la Licence Générale
 *  General Public License along         Publique GNU Affero avec
 *  with OpenCADC.  If not, see          OpenCADC ; si ce n’est
 *  <http://www.gnu.org/licenses/>.      pas le cas, consultez :
 *                                       <http://www.gnu.org/licenses/>.
 *
 *
 ************************************************************************
 */

package org.opencadc.datalink;

import ca.nrc.cadc.auth.AuthMethod;
import ca.nrc.cadc.reg.Standards;
import ca.nrc.cadc.reg.client.RegistryClient;
import ca.nrc.cadc.util.StringUtil;
import ca.nrc.cadc.vosi.AvailabilityPlugin;
import ca.nrc.cadc.vosi.AvailabilityStatus;

import java.net.MalformedURLException;
import java.net.URI;
import java.net.URL;

import org.opencadc.alma.AlmaProperties;


public class DataLinkAvailabilityPlugin implements AvailabilityPlugin {
    private String applicationName;
    private String state;

    /**
     * Set application name. The appName is a string unique to this
     * application.
     *
     * @param appName unique application name
     */
    @Override
    public void setAppName(String appName) {
        this.applicationName = appName;
    }

    /**
     * Get the current status.
     *
     * @return current status
     */
    @Override
    public AvailabilityStatus getStatus() {
        boolean available = true;
        final StringBuilder message = new StringBuilder(String.format("%s state:", applicationName));
        final AlmaProperties almaProperties = new AlmaProperties();
        try {
            final URL baseURL = getDataLinkBaseURL(almaProperties);
            final URL sodaURL = getSodaBaseURL(almaProperties);
            message.append(StringUtil.hasText(state)
                           ? state
                           : String.format("ACTIVE\nBase URL: %s\nSODA URL:%s\n", baseURL.toExternalForm(),
                                           sodaURL.toExternalForm()));
        } catch (Exception e) {
            available = false;
            message.append(String.format("INACTIVE: %s", e.getMessage()));
        }
        return new AvailabilityStatus(available, null, null, null, message.toString());
    }

    public static URL getDataLinkBaseURL(final AlmaProperties almaProperties) throws MalformedURLException {
        return lookupBaseURL(almaProperties.getDataLinkServiceURI(), Standards.DATALINK_LINKS_10);
    }

    public static URL getSodaBaseURL(final AlmaProperties almaProperties) throws MalformedURLException {
        return lookupBaseURL(almaProperties.getSodaServiceURI(), Standards.SODA_SYNC_10);
    }

    private static URL lookupBaseURL(final URI configuredURI, final URI standardsID)
            throws MalformedURLException {
        if (configuredURI.getScheme().equals("ivo")) {
            final RegistryClient registryClient = new RegistryClient();
            // Attempt to load the URI as a resource URI from the Registry.

            return registryClient.getServiceURL(configuredURI, standardsID, AuthMethod.ANON);
        } else {
            // Fallback and assume the URI is an absolute one.
            return configuredURI.toURL();
        }
    }

    /**
     * The AvailabilityServlet supports a POST with state=??? that it will pass
     * on to the WebService. This can be used to implement state-changes in the
     * service, e.g. disabling or enabling features.
     *
     * @param state requested state
     */
    @Override
    public void setState(String state) {
        this.state = state;
    }

    /**
     * A very lightweight method that can be called every few seconds to test if a service is (probably) working.
     * This method is to be implemented by all services.
     *
     * @return true if successful, false otherwise
     */
    @Override
    public boolean heartbeat() {
        return true;
    }
}
