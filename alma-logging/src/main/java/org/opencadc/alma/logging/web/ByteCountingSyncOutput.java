/*
 ************************************************************************
 *******************  CANADIAN ASTRONOMY DATA CENTRE  *******************
 **************  CENTRE CANADIEN DE DONNÉES ASTRONOMIQUES  **************
 *
 *  (c) 2022.                            (c) 2022.
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

package org.opencadc.alma.logging.web;

import ca.nrc.cadc.io.ByteCountOutputStream;
import ca.nrc.cadc.rest.SyncOutput;

import java.io.IOException;
import java.io.OutputStream;
import java.net.URI;
import java.util.Date;

public class ByteCountingSyncOutput extends SyncOutput {
    private final SyncOutput syncOutput;
    private ByteCountOutputStream byteCountOutputStream;

    public ByteCountingSyncOutput(final SyncOutput syncOutput) {
        super(null);

        this.syncOutput = syncOutput;
    }

    /**
     * Get the output stream.
     * ** Calling this method no longer commits the request. **
     *
     * @return the output stream for writing the response
     * @throws IOException fail to open output stream
     */
    @Override
    public OutputStream getOutputStream() throws IOException {
        return getByteCountOutputStream();
    }

    /**
     * Check is the output stream is open. If true, the header has been committed and additional
     * calls to setHeader will be ignored.
     *
     * @return true if response header committed and output stream has been opened
     */
    @Override
    public boolean isOpen() {
        return this.syncOutput.isOpen();
    }

    /**
     * Compatibility with cadc-uws-server API that is in use.
     *
     * @param code HTTP status code
     * @deprecated
     */
    @Override
    public void setResponseCode(int code) {
        this.syncOutput.setCode(code);
    }

    /**
     * Set HTTP response code.
     *
     * @param code HTTP response code
     */
    @Override
    public void setCode(int code) {
        this.syncOutput.setCode(code);
    }

    /**
     * Set (or replace) an HTTP header.
     *
     * @param key   HTTP header name
     * @param value HTTP header value
     */
    @Override
    public void setHeader(String key, Object value) {
        this.syncOutput.setHeader(key, value);
    }

    /**
     * Add an HTTP header.
     *
     * @param key   HTTP header name
     * @param value HTTP header value
     */
    @Override
    public void addHeader(String key, Object value) {
        this.syncOutput.addHeader(key, value);
    }

    /**
     * Set the Digest HTTP header.
     *
     * @param uri The Digest uri.
     */
    @Override
    public void setDigest(URI uri) {
        this.syncOutput.setDigest(uri);
    }

    /**
     * Set the LastModified HTTP header.
     *
     * @param date The LastModified date.
     */
    @Override
    public void setLastModified(Date date) {
        this.syncOutput.setLastModified(date);
    }

    /**
     * Obtain a ByteCountOutputStream over the response stream.
     * @return  ByteCountOutputStream instance.  Never null.
     * @throws IOException  If any I/O errors prevent this from happening.
     */
    public ByteCountOutputStream getByteCountOutputStream() throws IOException {
        if (this.byteCountOutputStream == null) {
            this.byteCountOutputStream = new ByteCountOutputStream(this.syncOutput.getOutputStream());
        }

        return this.byteCountOutputStream;
    }
}
