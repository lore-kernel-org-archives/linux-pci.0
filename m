Return-Path: <SRS0=fw3j=4P=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCFEC4BA3B
	for <linux-pci@archiver.kernel.org>; Thu, 27 Feb 2020 11:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B8224697
	for <linux-pci@archiver.kernel.org>; Thu, 27 Feb 2020 11:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbgB0L4e (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 27 Feb 2020 06:56:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:51474 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728893AbgB0L4e (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Feb 2020 06:56:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 20EDFAD81;
        Thu, 27 Feb 2020 11:56:32 +0000 (UTC)
Message-ID: <7b18ea13c4c5b4a291bf9d5ea6603d3a934ea105.camel@suse.de>
Subject: Re: [PATCH] pci: brcmstb: Fix build on 32bit ARM platforms with
 older compilers
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>
Date:   Thu, 27 Feb 2020 12:56:30 +0100
In-Reply-To: <20200227115146.24515-1-m.szyprowski@samsung.com>
References: <CGME20200227115151eucas1p22ff7409009d917addcc7e20f523c9051@eucas1p2.samsung.com>
         <20200227115146.24515-1-m.szyprowski@samsung.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-7amc1oclgjqFS8I7Y744"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-7amc1oclgjqFS8I7Y744
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-02-27 at 12:51 +0100, Marek Szyprowski wrote:
> Some older compilers have no implementation for the helper for 64-bit
> unsigned division/modulo, so linking pcie-brcmstb driver causes the
> "undefined reference to `__aeabi_uldivmod'" error.
>=20
> *rc_bar2_size is always a power of two, because it is calculated as:
> "1ULL << fls64(entry->res->end - entry->res->start)", so the modulo
> operation in the subsequent check can be replaced by a simple logical
> AND with a proper mask.
>=20
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Thanks!
Nicolas


--=-7amc1oclgjqFS8I7Y744
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl5Xrm4ACgkQlfZmHno8
x/7tZQf/dMFAYcOBhzFTZmFEMIfMkuXU9giUcGSfumSa0v3JAaCqEQwo7r2xoj3/
kfcJKW9ly/JVmht9Xu/uVZQ0k1RWxfcMS4pKSZHn+AGL2sGDWyRoLEAtybNtzjBr
6szjLBdHWiIIll4GdM5oHnGQHn+Sh2tcGDY+EtDtJFtazTL5pU30JuPob/i1fTWE
bBvRdqusbNg4deJ/l1aE5pK5O2HjTOyV/8k7lnfwMRq+U90Bt3W1mKO77tyCWWlx
jXF50TwlWBW1aepYUtQTomqN9FIjYaF9rdmAwtMIL/Xlyq122SyU3XN2zZ9+FbWc
gJMzVpo12RQ8aou54F/ZqPJnMjQF1A==
=whFO
-----END PGP SIGNATURE-----

--=-7amc1oclgjqFS8I7Y744--

