Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793878916;
	b=zy/iLo1cD7U1IYJsZs8zS1IDbQGw6rER3PZQsdTLy/GoYDRU7dLO3pFX0ZvjeLwXpmld
	 lOuESstvtAmwYkPscUQLYHsdswVQphnlN3gH+BsMEltCEukskxuv2D4tZwohfJdptxE6G
	 sH56Xv77kYPxLIQR92mz0Wkjq1rYxUAtj+zHXITQw7OVWHKTTZKDF8HrmQ/9J+n+Rvhum
	 oPqcGX2Ng7wDc0aybC+CRjgsGhKydCF7yFWkk1lBqsJF3yq/9Z0IF4LgO38wTk2igoQAr
	 gsRSMRmzZ2qkEwJWA2UpFpjYCUz7IySkc2aTbAHiFi6/nd7tpqvyyaXf913krmjxY+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793878916;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XwU9mv6N6c9Jp0vEJSA9TBTjerk9M7aAog9wC7vhQ44=;
	b=B9HX9G88jsoDW/zBR/cwaob+f5WLu88GHrFwhvlUB4PKY1pZVfruN6qClpI/Tanx7ZRa
	 A13b/uUlxp2rnsZ7SNvkIANSIaDZB0/z+eyr+VZG6hFxTE52M1rTB/6GPFnuWqnAAwVr8
	 yutZZjbHgT8yH7b+A/ZMgeqLLkaXKiHiUzjgfsta/CH73TcJ1YzSAjnyC5kJ6jF2P7HLq
	 vLt7XJvE2N9+bUZQZGk9u5ZhxTE1XDF9cMEfifX/8poQiuFHOtN4dBqXDun3yb8Lw+a5h
	 lZnaL3nN2MI9gI9S3/a7jwANH6GG0gLupSf4RYmIY8Ayq7PRauSptQz+gKG3RE3wjRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VYHKSwqW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ACA606A32E
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 11:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VYHKSwqW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4E51F0093A;
	Thu,  5 Nov 2026 11:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793878914;
	bh=XwU9mv6N6c9Jp0vEJSA9TBTjerk9M7aAog9wC7vhQ44=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VYHKSwqWZ/WF2MrYUjNOtFCrsAyk6TM8EbhZVONzlaDtytZAEkg8/C7L3xHiql7/k
	 Nme9O04bHN81FlKoQ0/JnSyrnJdSEWSydeqdsTKAfVpvzbr1JKvlIQ9BbjB9Nw3sMY
	 xFCwWwh6R7O3CFDA93GlZ1crosoTXTDBVwF7jUHFQ3Th2AVMiofht21gMetiuTNAzn
	 oeP+g+FWp0C9UE70QsSkTgEg+Jt7hkjdv/7QE+0kV4yybBIg0O7w7/LJqTZjFzBk/T
	 KHe+jfHUez+ZO4lOe7BH3Bl50xWiuP07ORGu5PAyZ3wDelY3Mwrt8xOBxo2vhbC/3H
	 z8eY2CCXAzhTA==
Message-ID: <sashiko-outbox-198968@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/7] arm64: dts: apple: t8122: Add PCIe device nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Janne Grunau" <j@jannau.net>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261105-apple-m3-pcie-v1-5-e00a72a604f8@jannau.net>
References: <20261105-apple-m3-pcie-v1-0-e00a72a604f8@jannau.net>
 <20261105-apple-m3-pcie-v1-5-e00a72a604f8@jannau.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 11:41:54 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Alyssa Milburn <amilburn@zall.org>
>=20
> Add the PCIe controller, its ports, IOMMUs and clock request pins to the
> base M3 Pro .dtsi file.
>=20
> Add PCIe devices for WiFi, Bluetooth, Ethernet, SD-Card reader and USB
> xHCI to device trees and enable their ports and IOMMU if necessary.
> The bootloader will fill MAC addresses and calibration data properties
> in their device nodes.
>=20
> Signed-off-by: Alyssa Milburn <amilburn@zall.org>
> Co-developed-by: Michael Reeves <michael.reeves077@gmail.com>
> Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
> Signed-off-by: Janne Grunau <j@jannau.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-apple-m3-p=
cie-v1-0-e00a72a604f8@jannau.net?part=3D5

