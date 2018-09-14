Return-Path: <SRS0=PQBU=L4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CC2FC6182
	for <linux-pci@archiver.kernel.org>; Fri, 14 Sep 2018 00:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E35E420853
	for <linux-pci@archiver.kernel.org>; Fri, 14 Sep 2018 00:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E35E420853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbeINFRS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 14 Sep 2018 01:17:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42204 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726826AbeINFRR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Sep 2018 01:17:17 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8E04WkD108995
        for <linux-pci@vger.kernel.org>; Thu, 13 Sep 2018 20:05:30 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mg24gr0vc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Thu, 13 Sep 2018 20:05:30 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <sbobroff@linux.ibm.com>;
        Fri, 14 Sep 2018 01:05:28 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 14 Sep 2018 01:05:24 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8E05NN765274050
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Sep 2018 00:05:24 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B67F4C04A;
        Fri, 14 Sep 2018 03:05:14 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4C034C040;
        Fri, 14 Sep 2018 03:05:13 +0100 (BST)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 14 Sep 2018 03:05:13 +0100 (BST)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 174F0A0120;
        Fri, 14 Sep 2018 10:05:21 +1000 (AEST)
Date:   Fri, 14 Sep 2018 10:05:20 +1000
From:   Sam Bobroff <sbobroff@linux.ibm.com>
To:     Russell Currey <ruscur@russell.cc>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, oohall@gmail.com
Subject: Re: [PATCH] MAINTAINERS: Add PPC contacts for PCI core error handling
References: <153677132617.23091.12307288405707171077.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180912165846.GH118330@bhelgaas-glaptop.roam.corp.google.com>
 <94b8929d44af6dd965600b7d159458312d500582.camel@russell.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <94b8929d44af6dd965600b7d159458312d500582.camel@russell.cc>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-TM-AS-GCONF: 00
x-cbid: 18091400-4275-0000-0000-000002BA1780
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091400-4276-0000-0000-000037C35266
Message-Id: <20180914000520.GA7655@tungsten.ozlabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-13_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809140000
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
Message-ID: <20180914000520.IjjccWl_YYzhhURVBkHazJkr8JU9-RGhjFpcFki8aBI@z>


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 13, 2018 at 12:26:55PM +1000, Russell Currey wrote:
> On Wed, 2018-09-12 at 11:58 -0500, Bjorn Helgaas wrote:
> > On Wed, Sep 12, 2018 at 11:55:26AM -0500, Bjorn Helgaas wrote:
> > > From: Bjorn Helgaas <bhelgaas@google.com>
> > >=20
> > > The original PCI error recovery functionality was for the powerpc-spe=
cific
> > > IBM EEH feature.  PCIe subsequently added some similar features, incl=
uding
> > > AER and DPC, that can be used on any architecture.
> > >=20
> > > We want the generic PCI core error handling support to work with all =
of
> > > these features.  Driver error recovery callbacks should be independen=
t of
> > > which feature the platform provides.
> > >=20
> > > Add the generic PCI core error recovery files to the powerpc EEH
> > > MAINTAINERS entry so the powerpc folks will be copied on changes to t=
he
> > > generic PCI error handling strategy.
> >=20
> > I really want to make sure the powerpc folks are plugged into any PCI c=
ore
> > error handling discussions.  Please let me know if there's a better way
> > than this patch, or if there are other people who should be added.
>=20
> I think this patch is definitely a good idea.
>=20
> Alongside this (whether you want to include it in your patch or not, Bjor=
n),
> Sam Bobroff should replace myself as maintainer.  He's been very active i=
n fixing,
> reworking and reviewing in EEH land and will probably do a better job of =
keeping
> his finger on the pulse of the generic PCI error handling code than I did.
>=20
> - Russell

That's fine with me. You can add me or let me know if I should send a
patch.

Sam.

>=20
> >=20
> > > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > > ---
> > >  MAINTAINERS |    4 ++++
> > >  1 file changed, 4 insertions(+)
> > >=20
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 7e10ba65bfe4..d6699597fd89 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -11202,6 +11202,10 @@ PCI ENHANCED ERROR HANDLING (EEH) FOR POWERPC
> > >  M:	Russell Currey <ruscur@russell.cc>
> > >  L:	linuxppc-dev@lists.ozlabs.org
> > >  S:	Supported
> > > +F:	Documentation/PCI/pci-error-recovery.txt
> > > +F:	drivers/pci/pcie/aer.c
> > > +F:	drivers/pci/pcie/dpc.c
> > > +F:	drivers/pci/pcie/err.c
> > >  F:	Documentation/powerpc/eeh-pci-error-recovery.txt
> > >  F:	arch/powerpc/kernel/eeh*.c
> > >  F:	arch/powerpc/platforms/*/eeh*.c
> > >=20
>=20

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEELWWF8pdtWK5YQRohMX8w6AQl/iIFAlua+zEACgkQMX8w6AQl
/iKOcQf+JdfQFAngmcHC2C0vnnnEQQqLURa4IOJ1v4MhPTFoPBNoAaFuXXTeCC/L
6UEq5ZWULO+9LjgcDrXyzB30dFLv3o+Vdy/atZqogaiAFdFn77IQoO2IQJkZyA1v
oS1Vd5YbepFuJyxSX1lSlV5aljuUQkcc7QRQ93w3j/j6KsRqJiyjCpI782ANZFtY
CvomFGtSfdQgEVC/4VfXSIs4ZSbvB8LmprXWnIVmPTuw7gnkVJGpLACmmsLcwuvf
bRZmVvveTvoyfVzJV9PCifKLJhojr1mfgtIbmQ9UWdWfjELnvKle9zAnilrppBmL
+iPh3HV5N0DSOfeYraEGzM5F7DQO0A==
=fTc4
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--

