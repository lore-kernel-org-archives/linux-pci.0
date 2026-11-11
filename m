Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794363483;
	b=XSk2jvleFhGcf9gVzZ0qPYqiLh3SA0Ps5qkCWSXZlLG1tUwI8HnybxV5sCsbkjebx6Ox
	 2TLFcWPNyKP3AHlHVHZ0y5/f2GNZIncjH42J8Tah7KzIhf7uUmiMfvEIHLDDCwxMorNWT
	 RB/ceJTBBvbPszRnwK59r6Xsg5V56Tn2PmgW6gZK4HI7yaF5V75GRRgaUeE83e0DBQphE
	 imzb5akp9olglvGhPyis6uEkGAc/8N7QVd22qt4R8hLQdLqFdoTaISXePTQaFvKyl5TW5
	 D5zsygbJe02sllxLF2UE9qsibfH78Y/V+/JTdekay7OvjQvHaQGIWnf9jNhqXB/NIUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794363483;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KciehyaHcyjRA/0EwuWkFj2vKpQU1D4YWFxmm7Y+bhA=;
	b=OeXLwodx0WEEJv81OvDiLWc7gmR25yv6jC8kB9HUGElSVawsdueEGecrgChSeVWhlC0i
	 6vEkta3NFdXtZy9lVAlDWRf8rFq5YwoFDERP1XnQ66q2YBHf3gOPcCV+INj/fHiCSQU7p
	 aDSyje1us3y0dsfIKPHipYM8AwNmqOtNbv7c8w+Lw65vubRPS/cjGMfAGlEEIxzhZvxg3
	 3EWZYwEfVhhfhzox+6kgOLl3idCRyEycSCkUy3NqdW3HLBmHxhysc8N0owwEu95GiniNT
	 2N8CJuhUzuGULVDRZRruz6N69CexFnXke/uySiNbW32BEYUuTYSZkb4gFgtD0Kc0jCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I38io5c7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A98606A31C
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 02:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I38io5c7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48CF41F0089F;
	Wed, 11 Nov 2026 02:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794363482;
	bh=KciehyaHcyjRA/0EwuWkFj2vKpQU1D4YWFxmm7Y+bhA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I38io5c75yu4iDPNmGhrY6LbFR6DvdXEFuuq7LQArkqnkrx1nbCATeQPqrudmiPWm
	 fnUgOm9udpPYA0b3V2m7t3Wj3lrRpaYRX6GquSv47/267mG1QqAat8KKWvvrPADZk9
	 agbo+NEtZIBEEaXcYIrYWMVF5czxZLqExaescjOee5ah1Q3rIW/wTroEalORq3GCuC
	 AO/wdwKNnH0IG9mmNOg64wWPez15XXM0wKOKsFp46J6/GyhBSYvzRpNRtfseQk887/
	 BYio0Q/1I5XySdr2RTksYWz/YLCLIeiWFpqHPU9HUwu2k8yIiJR6IlcGgaLSGken4M
	 iRT25lavR46iQ==
Message-ID: <sashiko-outbox-208077@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/3] PCI: Cache bridge firmware secondary bus number
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261110-vfct-regression-v5-1-f49fae981bf3@amd.com>
References: <20261110-vfct-regression-v5-0-f49fae981bf3@amd.com>
 <20261110-vfct-regression-v5-1-f49fae981bf3@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 02:18:01 +0000
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
- [Medium] PCI: unconfigured secondary bus 0 cached as valid in
  pci_scan_bridge_extend()
--

commit fd23152db632066be6cd9884f50d5722e11a3151
Author: Mario Limonciello <mario.limonciello@amd.com>

PCI: Cache bridge firmware secondary bus number

This commit caches a bridge's firmware-assigned secondary bus number on
struct pci_dev during pass 0 of bridge scanning so devices enumerated in
pass 1 can still access the original bus number after renumbering.

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 27008e2ea5afc..14b3dd7dac271 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1418,6 +1418,10 @@ static int pci_scan_bridge_extend(struct pci_bus *=
bus, struct pci_dev *dev,
> =20
>  	pci_dbg(dev, "scanning [bus %02x-%02x] behind bridge, pass %d\n",
>  		secondary, subordinate, pass);
> +	if (!pass && !dev->fw_sec_busnr_valid) {
> +		dev->fw_sec_busnr =3D secondary;
> +		dev->fw_sec_busnr_valid =3D true;
> +	}

[Severity: Medium]
Does this mark dev->fw_sec_busnr_valid as true even when secondary is 0
(unconfigured by firmware or hot-plugged) or 0xff (failed config read)?

Bus 0 is the root bus and is never a valid secondary bus behind a bridge.
When firmware leaves a bridge unconfigured for pass 1 to assign, this caches
dev->fw_sec_busnr =3D 0 with dev->fw_sec_busnr_valid =3D true, so consumers
checking bridge->fw_sec_busnr_valid will use bus 0 instead of falling back
to pdev->bus->number.

Note that simply gating this assignment on secondary > 0 && secondary < 0xff
would leave dev->fw_sec_busnr_valid false on an initially unconfigured
bridge, allowing a later rescan to cache the runtime-assigned bus number, so
tracking whether pass 0 has already run may need to be separate from whether
fw_sec_busnr is valid.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-vfct-regre=
ssion-v5-0-f49fae981bf3@amd.com?part=3D1
