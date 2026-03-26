Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB23D2DB79C
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 13:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774533511; cv=none; b=XGkl9GVysb0Nrojs5qkZBk0+DJc6lCVpF4DYXAMaTkNAWeZaC/bPpKUUdFEI4QvePA5M4/2x+fpCyptLqNM/ZdmnlYx+TijJYOpU4tQ7KF4P0pGCgAa9o8NrCqlWfr1nh8mffXl9myik+DqlwLKhPVa7d5DJm+5i9ky6Y8/X3oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774533511; c=relaxed/simple;
	bh=bwKpo+h+1YNhTkdtpFXRSdC3nrXN73Z59nOz6H8nqjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9AXPZ0Gj20Zy6YZoZ6J6GKglmVUdp2Tuth/2RI6UsqFk5US9fglgjK9MyvjHhM9528++fIyT8Pa7dvzJhFIz1O6q+iCYVXY9ae43wdkXpVvrKeZ/imgCS6s7ecdEUs9QaFo4UvKkirjF0mBkPD1pTyRc6fNFTpvpHJkvKTT9VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PCRiZXca; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCRiZXca"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-482f454be5bso19699345e9.0
        for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 06:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774533508; x=1775138308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0zd3ZQIZuQFrMIPWhXq9R8lB2J+Gk3qkwxiGtuo23gc=;
        b=PCRiZXcaOJErzHGQ0PXPj7/4L9TEnK0XtkaG+FNfgqJQRCngQROtCLX81CKCgkUXXN
         MK6btfBjY9i1QcP4WmTMRbDa7+L0i4FlBNR50Wr/vGw+QnZmm1McfKCNbPct4unrQq2j
         QVPPTmSn32LUAKYyaXqepm9BG+PVqRAOzG0ItrXhrd0CBIooQt2a2IdTUwlW/TCfqf7s
         csFhXc/X+ZePN95uDD/PTVdhmn1bCa5AKmcvJRFFzz2AXwfyvoRWEGbUKaP/EUP/nW0B
         8ThG882wRuC6laBA0WxttVJKRxDuyfb9sD6tI8hzZqLjUJeNiw0roMwOlUJdt0CKorYa
         I1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774533508; x=1775138308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zd3ZQIZuQFrMIPWhXq9R8lB2J+Gk3qkwxiGtuo23gc=;
        b=iFV5KK5wvFpbi90GOGrgpUT7xHkmBKLrJQgrCKyzKUfqFHj7JE3vCiWCrQ93rN+01h
         YdrTojYnGRAqIXcwizNQv+v5bQyxMt6whtfWZkv5GziEp5WhISpGc84TSivfb5WwrFb2
         fe3owTqlRl6bmjOe3Uf+7oCAAb2iib30Bhy2qnTrpLnYM9V4M6DZgFWb3evcQs/Ci8b4
         MWOhSHYVs5FRrMionPskB6wNXk8DrpB4HLKdlOv5peWVCsGhdGOXPS9u/pSVnPrnquX2
         L/Bs4UfSI8mB3B/pnMuGBV0VJJ/OEqszjRIQwuBYRl0JKlcbmXGoM9S2sf9udg6TgrjH
         uwIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDlVvXKvIXgXmLqCKLfjfcj5cnBXMVoalWTiAlzbD1clqAD8rZp5e3SjrRFG7tQpgp4FfgkE0niyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YycNEMiYJh3/68YhJrjcq9O/Ij58BwyN1h+1SWTOyCr0J5j2Pws
	gWkXO1XLtA8SMoOf/ymadLYe3u0ZZktm16fwRFReSpSaTgLp6o0dBUWC
X-Gm-Gg: ATEYQzxjIUbmMA4zywUq7MiyyaC2HCgU/awQcbMEJb9iAFQ98sGfWc0FJzXWRj2333r
	WvC9JQR3j2NaYZVerz1MjLH9AW3YyicZpDNeYBU1L61Z0h1lacDz1cwf28IPOSV8ekJqYnkfYq3
	vN2syTektAg26+zDhA+5942szCmvZYP8j0VkrQXvneH5feCnKyYLeGtjeVAN8+kGEwG+ZRlj5h+
	2ZWeipnYupp7XFNRUUGCM2NqoYZBbhfF+B9ZdP7hhyyxzHSktG2eG+Lkxg7+xF9NBh27GTSnLxJ
	2q4Bq8cyhkJwuMMMAQMaIIZswHR+EaEwJl0YC90J4J8aIzcBdO/d1SwlLn1+FpHew4EYnmd3baP
	M/FNDxCMpDaxP5PaTBN9vkZbA190dW9aNCJSCsTKZ2/PlTPge8lqQkNVCHtUm0MbJ+tSf8NVAIS
	bz3TOO1Tw3uf2EnYLVewZf4cEjvz21J26E/kZN6X+a8Jd7Ymdta7eKib+E+Cmxo6KZ1dCxKs2Ja
	u9Hkzd36Ur7NA==
X-Received: by 2002:a05:600c:c10e:b0:477:9890:9ab8 with SMTP id 5b1f17b1804b1-48722b93132mr18945175e9.3.1774533507897;
        Thu, 26 Mar 2026 06:58:27 -0700 (PDT)
Received: from orome (p200300e41f249a00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f24:9a00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4872090368dsm23955005e9.5.2026.03.26.06.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 06:58:26 -0700 (PDT)
Date: Thu, 26 Mar 2026 14:58:23 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thierry Reding <thierry.reding@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, 
	Michal Simek <michal.simek@amd.com>, Kevin Xie <kevin.xie@starfivetech.com>, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Use standard wait times for PCIe link monitoring
Message-ID: <acU7P2Lr261N_oeW@orome>
References: <20260320224821.2571373-1-thierry.reding@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kgzjz264htyclzzs"
Content-Disposition: inline
In-Reply-To: <20260320224821.2571373-1-thierry.reding@kernel.org>


--kgzjz264htyclzzs
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] PCI: Use standard wait times for PCIe link monitoring
MIME-Version: 1.0

On Fri, Mar 20, 2026 at 11:48:21PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> Instead of defining the wait values for each driver, use common values
> defined in the core pci.h header file. Note that most drivers don't use
> the millisecond waits, but rather usleep_range(), so add these commonly
> used values to the header so that all drivers can use them.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v2:
> - fix build for Cadence
>=20
>  .../pci/controller/cadence/pcie-cadence-host-common.c    | 6 ++++--
>  drivers/pci/controller/cadence/pcie-cadence-lga-regs.h   | 5 -----
>  drivers/pci/controller/mobiveil/pcie-mobiveil.c          | 4 ++--
>  drivers/pci/controller/mobiveil/pcie-mobiveil.h          | 5 -----
>  drivers/pci/controller/pci-aardvark.c                    | 7 ++-----
>  drivers/pci/controller/pcie-xilinx-nwl.c                 | 9 ++-------
>  drivers/pci/controller/plda/pcie-starfive.c              | 9 ++-------
>  drivers/pci/pci.h                                        | 2 ++
>  8 files changed, 14 insertions(+), 33 deletions(-)

Hi Bjorn,

I need to pick this up into the Tegra264 PCIe series to satisfy a build
dependency, so please ignore this version.

Thanks,
Thierry

--kgzjz264htyclzzs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmnFO38ACgkQ3SOs138+
s6Ejzg//b1ISEm87CFzQdPDmHjuOxfwqmFSCcUXqqwAoFdboAFa+pSWHmt/P/4M6
aH8QDcmKbomEYXqp6cT0+qh3cQ0jR4SK477yQWXnnyd7l1Zo+0gaS+wAd7D0qlIo
8SGsiqrYHMskxyzHonqi/WlPp8ntptmki1UJPmaireF9Aqt1+INyxMl0AqzE1Q9o
A+RdP3myC+r0VVyYSDRHwnD96oMYiSAN9Mmex+ScJHT4PNPht9f8hiw2V7J6Nrsu
VYoGifdsPjN8qgFleEE1Li7FO48WbIajLAansPrywpZO+OP8HyPbgPnKoyPk2e2Y
6o/nVCLjtM4DqejBorOG5vmZb/iZsibmlANVwDZb0uNZQV1CYnzZWc2783SdKDzl
fdvaVX1kYud7vZESMa8FLIxovmvSGXjbTgceTFW6Nz5trugd3D5eKNULcbXhSoTr
oahO9xJYmM67zQcwDsNtAO/jfLzW35OljAlEQ9FhBuiE4AymV/3druUpMFtHLGlj
SFfhOZzzOEFFMxV/qlylMEUuKsCXmAeVr7LTNhO12av78ySw8S3BjooYHYQ2lbwY
QnkLXEg4K8ofs63dW8lAaNLA8uVhQBP7J9NEkcVMGZyHZlgjGiTb0rX1dvlv6uKy
gBA+CQD5oucocGDLURMM+hQ4gIbsG+jbR/vQP1hS0n5rRMPBRlg=
=gKFs
-----END PGP SIGNATURE-----

--kgzjz264htyclzzs--
