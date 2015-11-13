Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33153 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932108AbbKMAIt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Nov 2015 19:08:49 -0500
Received: by pabfh17 with SMTP id fh17so80470708pab.0
        for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2015 16:08:48 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
	bhelgaas@google.com, grant.likely@linaro.org,
	robherring2@gmail.com, panto@antoniou-consulting.com,
	frowand.list@gmail.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 39/50] powerpc/powernv: Fundamental reset in pnv_pci_reset_secondary_bus()
In-Reply-To: <1446642770-4681-40-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com> <1446642770-4681-40-git-send-email-gwshan@linux.vnet.ibm.com>
Date: Fri, 13 Nov 2015 11:08:29 +1100
Message-ID: <87fv0azrpe.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--=-=-=
Content-Type: text/plain

Gavin Shan <gwshan@linux.vnet.ibm.com> writes:

>  void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
>  {
> -	pnv_eeh_bridge_reset(dev, EEH_RESET_HOT);
> +	int option, freset = 0;
> +
> +	if (dev->subordinate)
> +		pci_walk_bus(dev->subordinate,
> +			     pnv_pci_dev_reset_type, &freset);
> +
> +	option = freset ? EEH_RESET_FUNDAMENTAL : EEH_RESET_HOT;
> +	pnv_eeh_bridge_reset(dev, option);

According to the skiboot sources, fundamental reset isn't supported on
p5ioc2. As far as I can tell from your corresponding skiboot patches,
this is still the case after they are applied. Do we need a fallback to
EEH_RESET_HOT in this case? Otherwise there will be no reset performed
at all.

Likewise, if the FUNDAMENTAL reset fails for any reason, should we fall
back to a HOT reset?

Regards,
Daniel

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJWRSn9AAoJEPC3R3P2I92F3RUP/jc0/8Sbqd6/Z5ujsQAyKqwK
T+k5ZQ9rXRJzgM4V0ZnIhhTtAPQmmX0WrJgRRJ1lO+JXoNnsxeSrCtvaIfDaHpMt
24Ax64agoITWe7txLk7Jk+MUflWePSpD4SxpTwAeJdB/izJs++K1OLWTP3iAul9t
yTJPTMiKZT+cfnJ0DNVtDppIt3iNXyPgOF6x/99SBSTPAc4FBoTjvHO4eqPv14fU
a5LDPbG0q2HykRveRpt5Tj25DoxrbumLEg0ZrvPet7AgAhyFZ4oFd9Eu4Y0YycL+
y55706qPAkU2tA37oOvkgsLsXyec3lb6nhY55XkhKZ2rfxunYpN49qWLIFKrtA+7
6tD/Pjj9eskJRNLvgBcT8vFU539boegpvUQ/MF9W7VhtWVw7nB9yJAKhDw+hH4/Y
/g9s+U3l0JBRvzk2vs34cQ/0YEFd8+5CIyHyrNbTqeqcWk3j01E8JgUXEYpr1BI+
Dil/2vuP2yJFwAYdYtEI4MAB3KvlCs87m/iEvTrfU1w/d3HzsfRAVRof7+NcaSkk
o2+9AT0OFQOnj0GKcH9XqQHK8+J3Yx2d342aojWfAu40HbcVy10J57t1zzX3cEW6
4CrHvAEQ/wqcYSbISUZtirv2VkgxZbg8cR5ZOGEGGvNLM/x1rqeHCV+wuXIhjFz+
GEmyhs00IB78K7wi2pv8
=sJAY
-----END PGP SIGNATURE-----
--=-=-=--
