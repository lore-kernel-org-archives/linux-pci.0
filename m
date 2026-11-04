Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793820665;
	b=ZpevuqP9EA+xNIRj6vGuax7szN8zPT7HSOYHGbrATkeLymi7fFZ9LaDTgwlX0LLsLzuP
	 D8cDMauQ04CFRFh7ilI4ZPWBVqObOn30JGmhGAlAfbp4CyvCDYnP5OtId23hb3R1s/FuX
	 KhRL8xSlc9cPQArU/yP89tZuDYh5JtgnfQSwB8nS4sDZxCwwZRVPFY8SHyNMbcP7EUKeV
	 Me4fkpCQ2VBnPXkmWT6mGG0NagRz0sQWDtc2JIdQ+mQ8jJum8q0oAMA4yYxtmEzh0eExt
	 IbwMaxOfR2ffQ/mDmfe+ajHzm2K0Ccu2KTWtn7xQ3CzzzlXc8Jh5zXQTTW3zYnaNbYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793820665;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jwx3QhLwc/9g/mbfZdLzSkTJBx3y+ljzvZd+xPIji84=;
	b=TzqPJ0XkJ/tiGsUTjOvoWSY8lnMjv1o5dJS11kqPGcyTR0tmuZ+F9mhUcEFvGZoSOxHz
	 0kmDAw0mwERRyPYjFsAIUGek0Apvqdw3Cox7OzXkcYd7WF3JEosYyXKMxJIGAV2V1cFOK
	 3HFhHmA9nM2NiCUAfRFxN9NvEe7abeoTR8gHcnG5WtLbdDxlO8ujU6YjVlfFDR+FR5+BF
	 ilWS8+9CFJXVDrYZss3gA0LTLPmNgKoLY0Oz2bA2aR7jineJuisawqOBSNT0TrNMAZPEc
	 9BHCAfTuWdzp8RIVOeJf+qP5ERZB25YNj5ukiuqYUa+FP3CiIHaNqQYWxIOvJktmsvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RasBxywd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A81609766D
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 19:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RasBxywd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0821F000C1;
	Wed,  4 Nov 2026 19:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793820664;
	bh=jwx3QhLwc/9g/mbfZdLzSkTJBx3y+ljzvZd+xPIji84=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RasBxywdInPZILflN+SEZmrcD8GSlVtCR7Kc2/wmDMZ7v5roHdHlZ07oYCTR89BGU
	 Jc+vSjZazQ8MnX3IeJwCzmzbD/sor7WTql/r7r02DVCnWzGt0CQ9H/YPoial19onM3
	 AEJayICf3uZxN6k4ML+7BNueGiGmLPkolm02bUULzfRCNW3Ma+zI1sosz9Sfat9RI4
	 LTHRZabrL1AD+K2M9+zoGlouWrzPcmAF8vZSp+s03vgVL001J7YMcede4snwdrR57+
	 p96KqpdqeyPQdvC+RyYD/ZQPhCes09vmCMW6bX6ttEdd+o7miMy4IiWUKR2hJ4DQG8
	 nxeEXXMFyQ3uw==
Message-ID: <sashiko-outbox-197953@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/10] PCI: dw-rockchip: Add helper function for DDL
 indicator
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261104-rockchip-pcie-system-suspend-v7-6-6ae6875939a2@collabora.com>
References: <20261104-rockchip-pcie-system-suspend-v7-0-6ae6875939a2@collabora.com>
 <20261104-rockchip-pcie-system-suspend-v7-6-6ae6875939a2@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 19:31:03 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Remove code duplication and improve readability by introducing a new
> function to setup the DLL indicator.
>=20
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-rockchip-p=
cie-system-suspend-v7-0-6ae6875939a2@collabora.com?part=3D6

