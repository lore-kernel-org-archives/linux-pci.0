Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36021 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161926AbbKTDPC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 19 Nov 2015 22:15:02 -0500
Received: by pacdm15 with SMTP id dm15so101597003pac.3
        for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2015 19:15:01 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, aik@ozlabs.ru,
	linux-pci@vger.kernel.org, panto@antoniou-consulting.com,
	Gavin Shan <gwshan@linux.vnet.ibm.com>,
	grant.likely@linaro.org, robherring2@gmail.com,
	bhelgaas@google.com, frowand.list@gmail.com
Subject: Re: [PATCH v7 20/50] powerpc/powernv: Improve DMA32 segment calculation
In-Reply-To: <1446642770-4681-21-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com> <1446642770-4681-21-git-send-email-gwshan@linux.vnet.ibm.com>
Date: Fri, 20 Nov 2015 14:14:48 +1100
Message-ID: <877fldwedz.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> +	total_weight =3D pnv_pci_ioda_total_dma_weight(phb);
> +	weight =3D pnv_pci_ioda_pe_dma_weight(pe);
> +	if (!total_weight || !weight)
> +		return;
> +
> +	segs =3D (weight * phb->ioda.dma32_count) / total_weight;
> +	if (!segs)
> +		segs =3D 1;

I'm a little bit concerned about rounding here. Having said that I've
also lost track of dma32_count: if it's big then rounding won't
matter. What's a typical dma32_count?

> +
> +	/*
> +	 * Allocate continuous DMA32 segments. We begin with the expected
Very much a nit pick, but I think you mean s/continuous/contiguous/.

> +	 * number of segments. With one more attempt, the number of DMA32
> +	 * segments to be allocated is decreased by one until one segment
> +	 * is allocated successfully.
> +	 */
> +	while (segs) {
> +		found =3D false;
> +		for (base =3D 0; base <=3D phb->ioda.dma32_count - segs; base++) {
> +			for (i =3D base; i < base + segs; i++) {
> +				if (phb->ioda.dma32_segmap[i] !=3D
> +				    IODA_INVALID_PE)
> +					break;
> +			}
> +
> +			if (i >=3D base + segs) {
How would `i' ever be greater than base + segs? Should the test just
be 'if (i =3D=3D base + segs) {'=20
> +				found =3D true;
> +				break;
> +			}
> +		}

Regards,
Daniel

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJWTpAoAAoJEPC3R3P2I92FZSAP+QHwd81bGja1fkxHlgO/EZNc
7iO8Zhi53J6iWCHZ3Kbu5D1k379l1+ouWiOBzIsxa1MbmVsWHn0xIrieGgyuS++6
jI6V2s1kOTaAImRBFYS8Zk80K2AGbm9//FXNwI/8crX44F+O/KgfDw9XRyV/YvFp
BRmn+M1LjDkJqne9n4+2/NweevwKk8UtlqReoZbY+WLxtHhEGTs7WusT+Ii0lkQ5
EjFCdOysnWr7oybiaJGkMf7k1oU/H3+yrgTYKjQedEi5nqpa7y8NNBlvVUIKDPzm
gx7tT/SPlB57rETODf62+dLIsHjNAhzGkiUb4w/3bHutXsaRTckwdPyOZs8vz6RD
5VAsVU9McxYWLf0k+lFbwO65xQoiBJeblUjjr0c1228959oensKMQ3CL4ezWLA1r
AY0CrKkCq+1bvFsJDWbVarnKuVenVdnekR5U2mCyV4Ns7Z53WWDmWSik1rFyF/bp
OM4gGi8Uue9w4gXwmQJ3veBxZQ+ruFPozY6S4IM1m9nwnBUiLc5w7U/Ui5g71Vj2
9PGGWWbDABGQzUIkQSNxZ4DUoGRnhlfFSIXHLAfKsQ160zQ72bOtPHKlQmHLvVJ9
AkANhLLtbs6pAEr/McWIMvl/yM+4hc+bdg2gxCcoOOp/xnnWNw/40OOr5byVhWg0
eS8k32r6Mmwch17rvnKb
=OjyT
-----END PGP SIGNATURE-----
--=-=-=--
