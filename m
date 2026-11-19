Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116587;
	b=hjaFzmANIoR13Pgb1682VO0bmAMME1e0bj7RHiF53B9alX2A6EAphySHow9OFwz7soLX
	 JwbhbmMhe/LOGd+qMHe/j97rS1J7yBCIMmx11UkY8T2J/Xmn0drhmVrdEnfbWHCGU2KBQ
	 wpcAf/X23qG2sm1YKXBtY0zM5mwB3EF5uJ5mRy95ZVJk9jiCvYNYB7v9XkuFCIpwDXVP8
	 M49WDIC6LFfnQXKMp1tXaKRdtdJnKCQzS+LBcF/fCpl+OFDP4lh/XWIDrMv21yFRJIu0C
	 aKHSCPvLoHkvPomjL/yVcmCccGf3+sALuzf9TWshZJYyMHjHxWzZyzNRulpLO/L/KZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116587;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=p49w4P0QqR+6WACKqqBS/3kDfuAemnMkll2QmY+wr5k=;
	b=FLWvJA1s3/H7LTzsv6RtAVqxC/tkYGIsg/eF5gbOxsiQZ0CVHxGyTKic/ex4MCKAW4Ob
	 nfVTG+n+78eDbys+/QVsz+Q153+fYo/pjCYIxzpT0y9koMyzE3z/6xWB1hGWbpTZbBy7Y
	 VzlTxc6ODC3iOknKEa0KmE5IVy0O6cCeJ+OWPt2lYYDI82oSLeBx3cT2enDx7GxhDc2bd
	 uWiKjbGPaGQa0ImXDLcD8dINo3inejF12mEwMwOqdix68a4YZ1Jx9toWUBN0ghMDWis0+
	 tIZV1JFYyf+tZ/aYGmUuAZYxzXP8QzIcFDufQ4hWUjhdlBtkRnedwfoPqLR3XbaGjYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bChD8MtJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888A160A6F4F;
	Thu, 19 Nov 2026 19:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bChD8MtJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338531F000C6;
	Thu, 19 Nov 2026 19:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116587;
	bh=p49w4P0QqR+6WACKqqBS/3kDfuAemnMkll2QmY+wr5k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bChD8MtJifE4L/tV9i2Z6JVBmNjVO2jD18cL2cT4GIy0QbNFDx8jOXixrHvZMBQj4
	 pzkWQP72IcylmvQIhN/fGwYHheFX5hM8xxj0JoEScxRdtbmnS1jKi/qHYQK1WRz+PF
	 OSMQfSg82HdjwLO5q/jLmqyWA0n6RcfM6V5qj5TS5IN76g8umqxxkZrgiRulOCZl/A
	 HQeDqoeNcChe6jbM6ztqvR6T+74kFYzKvxeDZUGFzZjKzA84HZxV68JH8qnjhLv9cS
	 4czlCh0sH12rN3An4pbmdJ6Ig0ouc1/msnvbNX/ia55DfdsUPWTbyfBowBkiwRJmjg
	 Ysd+bGlH8EYtw==
Message-ID: <sashiko-outbox-223913@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 27/31] iommu: Use device trust for DMA restrictions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261118-device-trust-core-v3-27-d655875c4bfb@nvidia.com>
References: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
 <20261118-device-trust-core-v3-27-d655875c4bfb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:29:46 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> PCI-specific untrusted checks exclude devices classified as adversaries
> through generic policy. Their DMA protections should depend on the select=
ed
> trust policy rather than the source of that classification.
>=20
> Use policy for early domain selection and active trust for DMA bouncing.
> This removes the remaining need for PCI's duplicate untrusted flag.
> Changes to IOMMU domains after authorization remain separate work.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-device-tru=
st-core-v3-0-d655875c4bfb@nvidia.com?part=3D27

