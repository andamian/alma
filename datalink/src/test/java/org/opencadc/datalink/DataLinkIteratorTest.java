
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

import alma.asdm.domain.Deliverable;
import alma.asdm.domain.DeliverableInfo;
import alma.asdm.domain.identifiers.Uid;
import alma.asdm.service.DataPacker;

import java.net.URL;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import org.junit.Test;
import org.junit.Assert;

import ca.nrc.cadc.util.PropertiesReader;

import static org.mockito.Mockito.*;


public class DataLinkIteratorTest {

    @Test
    public void runThrough() throws Exception {
        System.setProperty(PropertiesReader.CONFIG_DIR_SYSTEM_PROPERTY, "src/test/resources");

        final DeliverableInfo PROJECT = new DeliverableInfo("2016.1.0001.S", Deliverable.PROJECT);

        final DeliverableInfo SGOUS = new DeliverableInfo("uid://C1/C10/C100", Deliverable.SGOUS);
        PROJECT.addSubDeliverable(SGOUS);

        final DeliverableInfo GOUS = new DeliverableInfo("uid://C2/C20/C200", Deliverable.GOUS);
        SGOUS.addSubDeliverable(GOUS);

        final DeliverableInfo MOUS1 = new DeliverableInfo("uid___C3_C30_C300", Deliverable.MOUS);
        final DeliverableInfo MOUS2 = new DeliverableInfo("uid___C31_C301_C3001", Deliverable.MOUS);
        GOUS.addSubDeliverable(MOUS1);
        GOUS.addSubDeliverable(MOUS2);

        final DeliverableInfo README = new DeliverableInfo("member.uid___C3_C30_C300",
                                                           Deliverable.PIPELINE_AUXILIARY_README);
        MOUS1.addSubDeliverable(README);

        final DeliverableInfo RAW1 = new DeliverableInfo("uid://C4/C40/C400", Deliverable.ASDM);
        RAW1.setDisplayName("2016.1.00001.S_uid___C4_C40_C400.asdm.sdm.tar");
        MOUS1.addSubDeliverable(RAW1);

        final DeliverableInfo PRODUCT1 = new DeliverableInfo("2016.1.00001.S_uid___C3_C30_C300_001_of_001.tar",
                                                             Deliverable.PIPELINE_PRODUCT_TARFILE);
        MOUS1.addSubDeliverable(PRODUCT1);

        final DeliverableInfo FITS1 = new DeliverableInfo("2016.1.00001.S_uid___C3_C30_C300_001_of_001.fits",
                                                          Deliverable.PIPELINE_PRODUCT);
        PRODUCT1.addSubDeliverable(FITS1);

        final DeliverableInfo FITSGZ = new DeliverableInfo("2016.1.00001.S_uid___C3_C30_C300_001_of_001.fits.gz",
                                                           Deliverable.PIPELINE_PRODUCT);
        PRODUCT1.addSubDeliverable(FITSGZ);

        final DeliverableInfo RAW2 = new DeliverableInfo("uid://C4/C40/C400", Deliverable.ASDM);
        RAW2.setDisplayName("2016.2.00002.S_uid___C4_C40_C400.asdm.sdm.tar");
        MOUS2.addSubDeliverable(RAW2);

        final DeliverableInfo PRODUCT2 = new DeliverableInfo("2016.2.00002.S_uid___C31_C301_C3001_001_of_001.tar",
                                                             Deliverable.PIPELINE_PRODUCT_TARFILE);
        MOUS2.addSubDeliverable(PRODUCT2);

        final DeliverableInfo FITS2 = new DeliverableInfo("2016.2.00002.S_uid___C31_C301_C3001_001_of_001.fits",
                                                          Deliverable.PIPELINE_PRODUCT);
        PRODUCT2.addSubDeliverable(FITS2);


        final DataPacker mockDataPacker = mock(DataPacker.class);
        final DataLinkURLBuilder dataLinkURLBuilder =
                new DataLinkURLBuilder(new URL("https://myhost.com/mydatalink/sync"));
        final Iterator<String> dataSetIDIterator =
                Arrays.asList("uid___C3_C30_C300", "uid___C31_C301_C3001").iterator();

        when(mockDataPacker.expand(new Uid("uid___C3_C30_C300"), false)).thenReturn(PROJECT);
        when(mockDataPacker.expand(new Uid("uid___C31_C301_C3001"), false)).thenReturn(PROJECT);

        final Set<String> resultDataLinkIDs = new TreeSet<>();
        final List<DataLink> expectedDataLinks = new ArrayList<>();
        final Set<String> expectedDataLinkIDs = new TreeSet<>();
        final DataLinkIterator testSubject = new DataLinkIterator(dataLinkURLBuilder, dataSetIDIterator,
                                                                  mockDataPacker);

        while (testSubject.hasNext()) {
            final DataLink resultDataLink = testSubject.next();
            resultDataLinkIDs.add(resultDataLink.getID());
        }

        expectedDataLinks.addAll(testSubject.createDataLinks(README));
        expectedDataLinks.addAll(testSubject.createDataLinks(RAW1));
        expectedDataLinks.addAll(testSubject.createDataLinks(PRODUCT1));
        expectedDataLinks.addAll(testSubject.createDataLinks(RAW2));
        expectedDataLinks.addAll(testSubject.createDataLinks(PRODUCT2));

        for (final DataLink dataLink : expectedDataLinks) {
            expectedDataLinkIDs.add(dataLink.getID());
        }

        verify(mockDataPacker, times(1)).expand(new Uid("uid___C3_C30_C300"), false);
        verify(mockDataPacker, times(1)).expand(new Uid("uid___C31_C301_C3001"), false);

        // DataLink has no equals() method, so we'll need to dive down into the URLs of each DataLink.
        Assert.assertArrayEquals("Wrong returned DataLink IDs.", expectedDataLinkIDs.toArray(),
                                 resultDataLinkIDs.toArray());
    }

    @Test
    public void runThroughFiltering() throws Exception {
        System.setProperty(PropertiesReader.CONFIG_DIR_SYSTEM_PROPERTY, "src/test/resources");

        final DeliverableInfo PROJECT = new DeliverableInfo("2016.1.0001.S", Deliverable.PROJECT);
        final DeliverableInfo SGOUS = new DeliverableInfo("uid://C1/C10/C100", Deliverable.SGOUS);
        PROJECT.addSubDeliverable(SGOUS);

        final DeliverableInfo GOUS = new DeliverableInfo("uid://C2/C20/C200", Deliverable.GOUS);
        SGOUS.addSubDeliverable(GOUS);
        final DeliverableInfo MOUS = new DeliverableInfo("uid___C3_C30_C300", Deliverable.MOUS);
        GOUS.addSubDeliverable(MOUS);

        final DeliverableInfo README = new DeliverableInfo("member.uid___C3_C30_C300",
                                                           Deliverable.PIPELINE_AUXILIARY_README);
        MOUS.addSubDeliverable(README);
        final DeliverableInfo RAW = new DeliverableInfo("uid://C454/C4545/C5454", Deliverable.ASDM);
        RAW.setDisplayName("2016.1.00001.S_uid___C544_C4545_C5454.asdm.sdm.tar");
        MOUS.addSubDeliverable(RAW);
        final DeliverableInfo PRODUCT = new DeliverableInfo("2016.1.00001.S_uid___C3_C30_C300_001_of_001.tar",
                                                            Deliverable.PIPELINE_PRODUCT_TARFILE);
        MOUS.addSubDeliverable(PRODUCT);

        final DeliverableInfo FITS = new DeliverableInfo("2016.1.00001.S_uid___C3_C30_C300_001_of_001.fits",
                                                         Deliverable.PIPELINE_PRODUCT);
        PRODUCT.addSubDeliverable(FITS);

        final DeliverableInfo FITSGZ = new DeliverableInfo("2016.1.00001.S_uid___C3_C30_C300_001_of_001.fits.gz",
                                                           Deliverable.PIPELINE_PRODUCT);
        PRODUCT.addSubDeliverable(FITSGZ);

        final DataPacker mockDataPacker = mock(DataPacker.class);
        final DataLinkURLBuilder dataLinkURLBuilder =
                new DataLinkURLBuilder(new URL("https://myhost.com/mydatalink/sync"));
        final Iterator<String> dataSetIDIterator =
                Collections.singletonList("2016.1.00001.S_uid___C3_C30_C300_001_of_001.tar").iterator();

        when(mockDataPacker.expand(new Uid("uid___C3_C30_C300"), false)).thenReturn(PROJECT);

        final Set<String> resultDataLinkIDs = new TreeSet<>();
        final List<DataLink> expectedDataLinks = new ArrayList<>();
        final Set<String> expectedDataLinkIDs = new TreeSet<>();
        final DataLinkIterator testSubject = new DataLinkIterator(dataLinkURLBuilder, dataSetIDIterator,
                                                                  mockDataPacker);

        while (testSubject.hasNext()) {
            final DataLink nextResultDataLink = testSubject.next();
            resultDataLinkIDs.add(nextResultDataLink.getID());
        }

        expectedDataLinks.addAll(testSubject.createDataLinks(FITS));
        expectedDataLinks.addAll(testSubject.createDataLinks(FITSGZ));

        for (final DataLink dataLink : expectedDataLinks) {
            expectedDataLinkIDs.add(dataLink.getID());
        }

        verify(mockDataPacker, times(1)).expand(new Uid("uid___C3_C30_C300"), false);

        // DataLink has no equals() method, so we'll need to dive down into the URLs of each DataLink.
        Assert.assertArrayEquals("Wrong returned DataLink IDs.", expectedDataLinkIDs.toArray(),
                                 resultDataLinkIDs.toArray());
    }

    @Test
    public void createDataLinks() throws Exception {
        System.setProperty(PropertiesReader.CONFIG_DIR_SYSTEM_PROPERTY, "src/test/resources");

        final DataLinkIterator testSubject =
                new DataLinkIterator(new DataLinkURLBuilder(new URL("https://myhost.com/datalink/do")), null, null);

        final DeliverableInfo deliverableInfoOne = new DeliverableInfo("uid___C7_C8_C9.tar",
                                                                       Deliverable.PIPELINE_PRODUCT);
        final List<DataLink> dataLinksOne = testSubject.createDataLinks(deliverableInfoOne);
        Assert.assertEquals("Should have one element.", 1, dataLinksOne.size());
        final DataLink datalinkOne = dataLinksOne.get(0);

        Assert.assertArrayEquals("Wrong semantics.", new DataLink.Term[] {DataLink.Term.PKG, DataLink.Term.THIS},
                                 datalinkOne.getSemantics().toArray());


        final DeliverableInfo deliverableInfoTwo = new DeliverableInfo("uid__C8_C9_C100.aux.tar",
                                                                       Deliverable.PIPELINE_AUXILIARY_TARFILE);
        final List<DataLink> dataLinksTwo = testSubject.createDataLinks(deliverableInfoTwo);
        Assert.assertEquals("Should contain two elements.", 2, dataLinksTwo.size());
        final DataLink datalinkTwo = dataLinksTwo.get(0);

        Assert.assertArrayEquals("Wrong semantics.", new DataLink.Term[] {DataLink.Term.PKG, DataLink.Term.AUXILIARY},
                                 datalinkTwo.getSemantics().toArray());

        final DataLink datalinkTwoPointOne = testSubject.createDataLinks(deliverableInfoTwo).get(1);

        Assert.assertArrayEquals("Wrong semantics.",
                                 new DataLink.Term[] {DataLink.Term.DATALINK, DataLink.Term.AUXILIARY},
                                 datalinkTwoPointOne.getSemantics().toArray());


        final DeliverableInfo deliverableInfoThree = new DeliverableInfo("README.aux.txt",
                                                                         Deliverable.PIPELINE_AUXILIARY_README);
        final List<DataLink> dataLinksThree = testSubject.createDataLinks(deliverableInfoThree);
        Assert.assertEquals("Should have one element.", 1, dataLinksThree.size());
        final DataLink datalinkThree = dataLinksThree.get(0);

        Assert.assertArrayEquals("Wrong semantics.", new DataLink.Term[] {DataLink.Term.AUXILIARY},
                                 datalinkThree.getSemantics().toArray());


        final DeliverableInfo deliverableInfoFour = new DeliverableInfo("uid__C5_C6.science.fits",
                                                                        Deliverable.PIPELINE_PRODUCT);
        final List<DataLink> dataLinksFour = testSubject.createDataLinks(deliverableInfoFour);
        Assert.assertEquals("Should have one element.", 1, dataLinksFour.size());
        final DataLink datalinkFour = dataLinksFour.get(0);

        Assert.assertArrayEquals("Wrong semantics.", new DataLink.Term[] {DataLink.Term.THIS},
                                 datalinkFour.getSemantics().toArray());

        final DeliverableInfo deliverableInfoFive = new DeliverableInfo("uid__C5_C6_C7.tar",
                                                                        Deliverable.PIPELINE_PRODUCT_TARFILE);
        final List<DataLink> dataLinksFive = testSubject.createDataLinks(deliverableInfoFive);
        Assert.assertEquals("Should have two elements.", 2, dataLinksFive.size());
        final DataLink datalinkFive = dataLinksFive.get(0);

        Assert.assertArrayEquals("Wrong semantics.", new DataLink.Term[] {DataLink.Term.PKG, DataLink.Term.THIS},
                                 datalinkFive.getSemantics().toArray());
    }
}
