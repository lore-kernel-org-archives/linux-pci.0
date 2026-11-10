Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794343983;
	b=y0k4X/i1sjbRmUCpheQWQzcfgPpZ/95JfSjvGZLrwWC69pV6eYO30EPKgaAJZKtcki6H
	 gojLhPDQ8YCjU85vjzHy8nBa0HYpF3S0MvNOWznBwGEe4nrdhCzDnwHLH60QzhiBeu2j9
	 +w7X8H8vr9x8RmaghPMYsMAUx+fYIN8pX1qicJ0C/RFEkGYG8tXGs6F0YGn6ZVDAVu1Jt
	 liTq1lUPHhpFfn4M+JoBnjwTn3R/HoKSvjfk48r0aAxKUDqnlWn0wU9D/jf4BwrEELfG1
	 8N1B8gQI168pvb6zY+peYICQjrujyuoUak9EQq6xkGytdXZYxPukEKDq/Kzg4Y/QetA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343983;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Z6yu+inKoBr53d1upcJnBpQIlcYwONwZCCYAnqUDxd4=;
	b=5LI6Mp3tVaJSXO3en5zaxyqOFN22dbblxdM6jWyZiULT7aNpt0aG6KQz4rB4DOHfzSTU
	 5PwAQEEZOtNdhbq18/6iGGFBPIFv2bW/7aHIWSUjUHEQdgX60GTnjTVU8zPbVTIKcWB1w
	 yWga2CrM/Uh/0Zb2xEauLjeH2+vYK42fyu5YCtV/hSwtPfqsu+u4Fcp8jZ4e74F2UmRjh
	 oDoBn2NzLnZhyUlPOcpaxu1ytKFuTnt2g6dVkR09/PGzhiWPx2negVd8n6H3xh3iiwng7
	 V6elvohY41zO0DBAULwsCng6Qfe4WbK3XkkSnNLlKGP6p1KEE/JlmHNEQyOcD/JTCEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U3FR3V0h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD727606A31C
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 20:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U3FR3V0h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BB21F0089F;
	Tue, 10 Nov 2026 20:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794343982;
	bh=Z6yu+inKoBr53d1upcJnBpQIlcYwONwZCCYAnqUDxd4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U3FR3V0h/F+VfrNo86dG2D645nYZhbrVLTbCqmFKEurE6OV8BjVFK5i9AM/ZeHc+D
	 lM2bDjntchey7SH/En1qvAYzOL6OFDmfd6xfEaDis5tzZS9CT1/zZybNc2wgB6cTo2
	 7Cfz8INvCGJDtwzDCJHVaQojO7xQtmVWtXUfYRROemXB2BWJmK46B/cK6fsz5SaEw9
	 Wf2Xvy+bFIZZ/a1dr1ixMTEGVsNshzYGXIWjG/UOsSeg/RG1Oxeyve6HRBD4buhe0a
	 tpxVgAEAV6Nh+aJeiX1lO8Bh7pEw+fKTGJixaqcNeYyjm1uk8P27NkhmGw5ip59K/3
	 sOdd/zsXf+Cbg==
Message-ID: <sashiko-outbox-207734@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] PCI/PM: Avoid D3cold for HP Spectre x360
 Convertible 15-ch0xx PCIe Ports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <superm1@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261110-superm1-kbz-222179-v2-2-5605e6ce6454@kernel.org>
References: <20261110-superm1-kbz-222179-v2-0-5605e6ce6454@kernel.org>
 <20261110-superm1-kbz-222179-v2-2-5605e6ce6454@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 20:53:01 +0000
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
- [Medium] PCI/PM: undocumented HP ZBook 15 G4 quirk with wrong
  DMI_BOARD_NAME match
--

commit bf5c6b82503708661539d00aefb0a2e0f06652af
Author: Mario Limonciello <superm1@kernel.org>

PCI/PM: Avoid D3cold for HP Spectre x360 Convertible 15-ch0xx PCIe Ports

This commit adds DMI blacklist entries to bridge_d3_blacklist[] to prevent
PCIe ports from being put into D3cold on affected HP laptops.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 17ec7f065682d..6bd84b9809c8d 100644
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
> +			DMI_MATCH(DMI_BOARD_NAME, "HP ZBook 15 G4"),
> +		},
> +	},

[Severity: Medium]
Can this HP ZBook 15 G4 entry ever match a target machine when checking
DMI_BOARD_NAME against "HP ZBook 15 G4"?

On HP systems, DMI_BOARD_NAME is a 4-character hex board ID (like "83BB"
above, or "8275" on the HP ZBook 15 G4), while "HP ZBook 15 G4" is the
DMI_PRODUCT_NAME string.  Also, this entry is not mentioned in the commit
message or explained with a comment like the other entries in
bridge_d3_blacklist[]; was it included by mistake, or should it match
DMI_PRODUCT_NAME (or the hex board ID) and be documented?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-superm1-kb=
z-222179-v2-0-5605e6ce6454@kernel.org?part=3D2
