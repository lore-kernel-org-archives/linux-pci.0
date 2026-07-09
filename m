Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A9C1B4223;
	Thu,  9 Jul 2026 01:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783559911; cv=none; b=sZ10H6uxqa33Fj24G9zZ8IiEhBioFCaIeQX5h+9YrzHq9sQn02XeXBBNabQcgKQc7Ej3ToCzHS8H8mi9n3meQmCFzIqON0j1ewJfDxGUuriHLzK0tIAMhz8C60m9k9Uf2TEnT24CaLFOsfjVgT2VPNqhJTU15P4cuS2veGDv8iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783559911; c=relaxed/simple;
	bh=5bKQR/p3q+ukR9/LwjmWORHu1qZh9GjIDqGTkQbIs8A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EOTJ4KOISoYLCdLtsLq3U3z7bRkY4ypc2hBz4FvC8sVvUdgsgxIfp443Ep04/fEkL1DPXFMmsYqzps0fRcRT2MRdR6xNownTtzK1sl4E64E2+zxM9pWAAcUiqI4uSG1r4EcFM2u8sO2NpFi2o0nieHyFidaaq3R5rg3wAHJqW4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwXb9vI/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwXb9vI/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD481F000E9;
	Thu,  9 Jul 2026 01:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783559910;
	bh=bNzyeVpAcKUJni5BYJx6rFOwbz9l4557hI1UsuB+WNQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JwXb9vI//DCXv5tMEtEA8ZRQvYnIUuZ4blZZMHhmXvyuAfFcY4avM79lkexqR+8GZ
	 +GRl1UzlSsx7yF61oisu+AMjUh6JUbv34d9GRXc2PhdNdzO2lbhj+KOe+jcNkz0+YM
	 xylzLIGu+257TxAD8GsYbJOnychUs7lTsByLFX0liUE/M1kiPrsIxdDHdvCn1LxzQQ
	 BXzdm9qDF4FCrwxlNTnvuDw9zac3ZcGH2i02ivzci/3W/I44cSP68eE9ymuiGOF/VJ
	 S6Cb4nMiaovaxtZzrLR5a7DLz3wwhZPwacVJ+3iJQpDDafbCWiox8bBqY38t6C9eWW
	 8i16+qF85GLrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 03/11] cxl: Share HDM decoder decode logic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260709010304.680422-4-smadhavan@nvidia.com>
References: <20260709010304.680422-1-smadhavan@nvidia.com>
 <20260709010304.680422-4-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 01:18:29 +0000
Message-Id: <20260709011829.CAD481F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds stack read leaking kernel memory to userspace via de=
coder target maps when processing decoders with more than 8 interleave ways.
- [High] Endianness bug when extracting 8-bit Target IDs via a 64-bit union=
, leading to broken routing on big-endian architectures.
--

--- Patch [3]: [PATCH v9 03/11] cxl: Share HDM decoder decode logic ---
commit 0c55ebf0416f52a7748df44eabd5450eb7aba244
Author: Srirangan Madhavan <smadhavan@nvidia.com>

cxl: Share HDM decoder decode logic

This commit moves HDM decoder register decoding into a shared helper functi=
on.
It consolidates the validation of base, size, interleave, target type, and
enable state to simplify early PCI HDM cache setup.

> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 83cda63f76a5a..e9e00c68a0ad9 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -952,6 +952,7 @@ static int init_hdm_decoder(struct cxl_port *port, st=
ruct cxl_decoder *cxld,
>  	u32 remainder;
>  	int i, rc;
>  	u32 ctrl;
> +	struct cxl_decoder_settings settings;
>  	union {
>  		u64 value;
>  		unsigned char target_id[8];
>  	} target_list;

[ ... ]

> @@ -1036,32 +1030,11 @@ static int init_hdm_decoder(struct cxl_port *port=
, struct cxl_decoder *cxld,
[ ... ]
>  	if (!cxled) {
> -		lo =3D readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
> -		hi =3D readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
> -		target_list.value =3D (hi << 32) + lo;
> -		cxld->targets =3D target_list.value;
>  		for (i =3D 0; i < cxld->interleave_ways; i++)
>  			cxld->target_map[i] =3D target_list.target_id[i];

[Severity: High]
This isn't a bug introduced by this patch, but does this loop cause an
out-of-bounds stack read if cxld->interleave_ways is greater than 8?

The target_list union is only 8 bytes wide, but CXL decoders can have up to=
 16
interleave ways. This would result in reading uninitialized stack memory in=
to
the target_map array.

[Severity: High]
This is a pre-existing issue, but can using a union to map a 64-bit integer
to a byte array lead to endianness issues here?

On big-endian CPUs, target_list.value would store the bytes in reverse order
compared to little-endian CPUs, causing the loop to map memory to the wrong
routing targets.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709010304.6804=
22-1-smadhavan@nvidia.com?part=3D3
