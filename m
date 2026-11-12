Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794511171;
	b=pp/tqkhx+nBFPAla6Q3UfCVgstHWsZ5iRVCBt7cMqZyfMsJhytQYgbwi2PJ3i9hTsDOq
	 coq5uW3IWBOGr/1vjYHV0JS6ckuT3+fyhi1SAo6ESgOj+Y7HS1v8MDc13FUsw5JLLw5Zt
	 Xu31pE260hAWiUn/0jo0PQt8Oi+2GgHMdD+xnG4Tl/nQ49xCvtxQowf4FLT5RkFGXjSdi
	 M+gMJEtltZEW84ByPsXsJOQNsUJM4YL2bXDJhu3zR8AzXXI6IC/EkPt0z2IH+JVo4d5Mw
	 kMF4OP8YMILWb9isSCDc40s7F8+qfVu5+lkIVQpIhCFQbfLmkYB+x1qSj5dv5kCUbUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794511171;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=87cOKyFFe1xlFgnZ098M/mlDaX4pjjNDjp1tFUEXfOg=;
	b=Erg5Czlp6D2cS4apQNdGLWIITb4NxY/gwn8gPjRliYx07fwDeuRQen4HIzkfK5oXHTC2
	 yWMx0XEDv7AXefCNH2MPwVDVYd8QL4BS2gOfTTHSGIzRJwOgXGaBxCTOGpMREzjc1o89T
	 3VocSASID/s1psLqk6pjnRwthu4KmOBobB/xPicQdzBYbjYFNgMpydpTvthjgNSbHnuYs
	 J2/uf+7HtqZRYCZX/dJBjxIjmhYG9cYCER6SEXLhPhoBPPl9coqKSQOE4Eky6rMLCiO1j
	 aMBqZW8oqRMpqfTzE2gtccDmmjHA0cQVU/rt7K0n/VUUC6iPin674QOax2GW3cz212A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cf3mZdhS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506D3606A31C
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 19:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cf3mZdhS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F8F1F000C4;
	Thu, 12 Nov 2026 19:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794511170;
	bh=87cOKyFFe1xlFgnZ098M/mlDaX4pjjNDjp1tFUEXfOg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cf3mZdhSmiSnPNjO8oQZd/p6m8RASyaCTMIkdSXedZ94Zvu1gEHLwzo3HbAhpwYZ/
	 OYnkvqXWh6dqgkmiBZlLdVRj00m6yADM0RWDtTmOfBwkwOisvrCCvgzuO7VAjoHhxn
	 ktzU21VuMWZMXRLXuvX3IbJnrtJ4IoHIKXqlDwYpXGa/qRBg7+ILjBWVtpurOJBiYV
	 znPNqTlbYnMod5AUc4Ag9gfU3cVql376m6GFAtb3lkEVHXo8+AnUHAoIGjHU61NRCM
	 Sn0KlERA+ccJr8XKgFs2hLXzyIZdUKajj+KfSHITo3H+VHk0r+iiO1WBIEaCguUyvl
	 7UsPBmkZRIv1Q==
Message-ID: <sashiko-outbox-211756@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] PCI/PM: Avoid D3cold for HP Spectre x360
 Convertible 15-ch0xx PCIe Ports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <superm1@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261112-superm1-kbz-222179-v3-2-f20b5ac06b6d@kernel.org>
References: <20261112-superm1-kbz-222179-v3-0-f20b5ac06b6d@kernel.org>
 <20261112-superm1-kbz-222179-v3-2-f20b5ac06b6d@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 19:19:30 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] PCI/PM: undocumented HP ZBook 15 G4 entry added to
  bridge_d3_blacklist
--

commit 3a39b259ab0d752d9836cb09fe7994c45196ce7c
Author: Mario Limonciello <superm1@kernel.org>

PCI/PM: Avoid D3cold for HP Spectre x360 Convertible 15-ch0xx PCIe Ports

This commit adds DMI quirks to bridge_d3_blacklist to disable D3 power
management for PCIe ports on affected HP laptops.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 17ec7f065682d..bced3a0e3e853 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3039,6 +3039,24 @@ static const struct dmi_system_id bridge_d3_blackl=
ist[] =3D {
>  			DMI_MATCH(DMI_BOARD_NAME, "314D"),
>  		},
>  	},
> +	{
> +		/*
> +		 * Changing power state of root port dGPU is connected fails
> +		 * https://gitlab.freedesktop.org/drm/amd/-/work_items/3389
> +		 */
> +		.ident =3D "HP Spectre x360 Convertible 15-ch0xx",
> +		.matches =3D {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
> +			DMI_MATCH(DMI_BOARD_NAME, "83BB"),
> +		},
> +	},
> +	{
> +		.ident =3D "HP ZBook 15 G4",
> +		.matches =3D {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
> +			DMI_MATCH(DMI_BOARD_NAME, "8275"),
> +		},
> +	},

[Severity: Medium]
Was the "HP ZBook 15 G4" entry included in bridge_d3_blacklist[] by
accident?  The commit message only describes the HP Spectre x360
Convertible 15-ch0xx, and unlike the other entries in this table there
is no comment explaining why PCIe port D3 must be disabled on board
8275.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-superm1-kb=
z-222179-v3-0-f20b5ac06b6d@kernel.org?part=3D2
