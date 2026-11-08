Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794148177;
	b=2vzOjCiPurJUL9Os0iNqOWbq2uFVbkSwjOZ+gR2qhCOww0TpWlnj5V1my0xMGIuO2PRZ
	 YGkgEF09g/JWuk03unaahu5T6muOswMPDr6xnNPhsvbMJwNadk9f1ugTCVEN9oPK/HPV/
	 Rwd+GqVZ/xdqkl3mgMEqxORkQJnFlVj2/2KI9d4Q1MGAUPtzCIlHX1irUpp+Ko2yW+yME
	 qJ+km1/1GuAPoijEbITaEF4m0kpPjiab9or51I9PpNTli1kpbZVL5R/vLvaJ1O3jaTn2l
	 oz5MEXRPVEfP9/9Nlhy/LT78epyhqyK/gpIXOK0zCxvB4poqnN7yuqfMmK35EyRISkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794148177;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CkrkWtVRWAYfjMr2/KmaUuRw+CjrhoQ3eegXGEoE7+o=;
	b=lTzWoNf36854/WXScFf35dU+ORbV8i90lv6azZI8UxIIb7Ap8PQZqd7ayPRv343hbFWU
	 M2/UXryoW2sQcQ6gqECy5kSDqS8a6d1oVeqDTCMv2PKW+zvoyHX3GD0RTN6X/BHb2sAOd
	 5NYLIQCZ1gA4XsGt9hUBtuDO2ogD/uZQjPoCz9yGod8T4ySV6EkZYkxcXTtTHTQ1bLq4C
	 pvPG0ML7tPSvBy+DiW+v+G9yZvyR50pQ6wXy7qlkt7ngScvT/NBWVnNm94Mujn3Fo8+O3
	 RPsk1SIK7i1UPAKCQfzI3p9IxULtQ9BEq1jaNgK/gQpsfR/qP35MVLv1z8/F9T5ykuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gYc/SdCy";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB62606A31C
	for <linux-pci@vger.kernel.org>; Sun,  8 Nov 2026 14:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gYc/SdCy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88A11F008A2;
	Sun,  8 Nov 2026 14:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794148176;
	bh=CkrkWtVRWAYfjMr2/KmaUuRw+CjrhoQ3eegXGEoE7+o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gYc/SdCy1meVX1ag/OJeJDovCLArMKbtUaKfecXDJbY61x5p7nQZ0WthtnlMXc15b
	 irZQeR7nWL8OUNCkyve9hMeKsM0M5njMhzY3fb9oYvZfXgU4msj7zZJaDgvfbkBEQ7
	 /5R0a2gxbOXc2zzDz0XSwNDKfw43VEfSGA3rm2ATnKK20uokO0hDDKw3EJkoMI71iN
	 HEjYFjYCff9+yJy8N9YrWX8dPfGSxGUjbgMp1kWFKNb6Z8vaD422mwbIqaYYTiOO4Q
	 0QYINbV41S9EPiDYKHA5iIrr6QDPoTcVXOLWgadtTgpN65cMowhUjSCswvZCwTVzvB
	 imRG/AsoeWgHw==
Message-ID: <sashiko-outbox-203805@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/7] arm64: dts: apple: t8122: Add PCIe device nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Janne Grunau" <j@jannau.net>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261108-apple-m3-pcie-v2-5-0e5ffec71da4@jannau.net>
References: <20261108-apple-m3-pcie-v2-0-0e5ffec71da4@jannau.net>
 <20261108-apple-m3-pcie-v2-5-0e5ffec71da4@jannau.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 14:29:36 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-apple-m3-p=
cie-v2-0-0e5ffec71da4@jannau.net?part=3D5

