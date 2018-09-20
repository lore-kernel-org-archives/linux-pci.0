Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC31ECE561
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 04:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF67214C2
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 04:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF67214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbeITKD1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 06:03:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37634 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726014AbeITKD1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Sep 2018 06:03:27 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8K4JV4o053874
        for <linux-pci@vger.kernel.org>; Thu, 20 Sep 2018 00:22:04 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mm16eeeuw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Thu, 20 Sep 2018 00:22:04 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <sbobroff@linux.ibm.com>;
        Thu, 20 Sep 2018 05:22:02 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 20 Sep 2018 05:21:57 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8K4Lu3461931694
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Sep 2018 04:21:57 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8CCC952050;
        Thu, 20 Sep 2018 07:21:41 +0100 (BST)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id E777F52054;
        Thu, 20 Sep 2018 07:21:40 +0100 (BST)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 08548A0205;
        Thu, 20 Sep 2018 14:21:54 +1000 (AEST)
Date:   Thu, 20 Sep 2018 14:21:53 +1000
From:   Sam Bobroff <sbobroff@linux.ibm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Russell Currey <ruscur@russell.cc>,
        linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add PPC contacts for PCI core error handling
References: <153677132617.23091.12307288405707171077.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180918215854.GH13616@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <20180918215854.GH13616@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-TM-AS-GCONF: 00
x-cbid: 18092004-0012-0000-0000-000002AB3B84
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092004-0013-0000-0000-000020DF9C15
Message-Id: <20180920042153.GA28551@tungsten.ozlabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-20_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809200045
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 18, 2018 at 04:58:54PM -0500, Bjorn Helgaas wrote:
> On Wed, Sep 12, 2018 at 11:55:26AM -0500, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >=20
> > The original PCI error recovery functionality was for the powerpc-speci=
fic
> > IBM EEH feature.  PCIe subsequently added some similar features, includ=
ing
> > AER and DPC, that can be used on any architecture.
> >=20
> > We want the generic PCI core error handling support to work with all of
> > these features.  Driver error recovery callbacks should be independent =
of
> > which feature the platform provides.
> >=20
> > Add the generic PCI core error recovery files to the powerpc EEH
> > MAINTAINERS entry so the powerpc folks will be copied on changes to the
> > generic PCI error handling strategy.
> >=20
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>=20
> I applied the following to for-linus for v4.19.  Russell, if you want
> to be removed, let me know and I'll do that.

Cheers!

Acked-by: Sam Bobroff <sbobroff@linux.ibm.com>

> commit 3fed0e04026c
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Wed Sep 12 11:55:26 2018 -0500
>=20
>     MAINTAINERS: Update PPC contacts for PCI core error handling
>    =20
>     The original PCI error recovery functionality was for the powerpc-spe=
cific
>     IBM EEH feature.  PCIe subsequently added some similar features, incl=
uding
>     AER and DPC, that can be used on any architecture.
>    =20
>     We want the generic PCI core error handling support to work with all =
of
>     these features.  Driver error recovery callbacks should be independen=
t of
>     which feature the platform provides.
>    =20
>     Add the generic PCI core error recovery files to the powerpc EEH
>     MAINTAINERS entry so the powerpc folks will be copied on changes to t=
he
>     generic PCI error handling strategy.
>    =20
>     Add Sam and Oliver as maintainers for this area.
>    =20
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4ece30f15777..f23244003836 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11203,8 +11203,14 @@ F:	tools/pci/
> =20
>  PCI ENHANCED ERROR HANDLING (EEH) FOR POWERPC
>  M:	Russell Currey <ruscur@russell.cc>
> +M:	Sam Bobroff <sbobroff@linux.ibm.com>
> +M:	Oliver O'Halloran <oliveroh@au1.ibm.com>
>  L:	linuxppc-dev@lists.ozlabs.org
>  S:	Supported
> +F:	Documentation/PCI/pci-error-recovery.txt
> +F:	drivers/pci/pcie/aer.c
> +F:	drivers/pci/pcie/dpc.c
> +F:	drivers/pci/pcie/err.c
>  F:	Documentation/powerpc/eeh-pci-error-recovery.txt
>  F:	arch/powerpc/kernel/eeh*.c
>  F:	arch/powerpc/platforms/*/eeh*.c
>=20

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEELWWF8pdtWK5YQRohMX8w6AQl/iIFAlujIFkACgkQMX8w6AQl
/iIeyAf9EQwpT4DIACletswv4K//3NA6uBrzgk+Q9+8feDaHqcyGyWcmfaB1sUna
VWeJuf/ItC3k87VBcD0AQK7H0g8Vl5dzKJ5vCMk1T6Zb7Xi7ByYXuydTgF+CGmNW
G8+pAsTjVGcud28E4/qnVKCw52kSP8qBaA9Ap1MfMEKJ1uYrUdGIuWjOGHsIESHq
P7+w1NpQgxiB/m0kpVfjmhMLw52u2RyFePgnEBseynZXHuPUcnldmh7cT5YvJ002
dCboGzTsMJHhb8AKBnyLXzypU5Hb/cStq9/CdEWJutGPsTVAV88PyYwgQpq3huHt
EG75dY8whbFJb3681f8MJjnl2wxzmw==
=tPu3
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--

