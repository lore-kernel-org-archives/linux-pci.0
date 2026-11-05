Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793865721;
	b=4QCITEDciV7x7VRQsJbDjENBk3f9c8umuo6YN968HPjXir6dlLxo8sRZL93yFAjiM5Wz
	 XpOuN91DZh+PpS8lfukJaB7nZlpZosFkOZGWOM+8oO4AkgNQoiH4m2+CvP1MYm3ubzE+o
	 3HjAUuFfVJmRr5vSTDabCaNpFV6ULMhUBejGHni8ED2GHUuM9YS4Gt/eAHgRrPnKUkl0x
	 BKLaLC4tgsiccuGGey8abtZ1tJKVxKt0xeWIIMHinQhRFsd37JPhnXnQ9rgiQbNub5HEI
	 N+3ZIk2buAaB2Ff/2VKUhcXufvRT9jDPE72mll5YMgYgJAJe9GW95hRpLGXcbOO7Ovg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793865721;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MPraXOhlsseIQOqL/YviCqeB6CAAfjoz8e4cH9OLU3I=;
	b=5EFrpShvQFFZ0xQWRv2NRMaLJoo33xti8Nzp4PVsJ+2WRHTvhtPkg8P5k9M2xK6ESNAh
	 iEINn5qAlUnECWEqzIuRYzwiOdLv8Xoq7uJ1S+lsMsB+rnZI+L6Ynuusk59AyX+NHWtHD
	 K1XCM4FSkjmMrRHUBNqkG6itSuv8Ixiz1yNmPE611SX0IaB1bvSaWrSJB+yejB5sS1Muj
	 EnmTdKugVO8Cpl/uzCbgaA0SRtTLRFuuPd2+pstfXtVunOCJkSzLyJ0B8VWmAHOzhgzjn
	 gYMb0qpuVN+Poep48jlSv1p6wC+F5eNyZT/LmbaRgl7vz50wN5WK7ib5re/nKUaTV0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ceY/W+gF";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B21606A31B
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 08:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ceY/W+gF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9415B1F000C1;
	Thu,  5 Nov 2026 08:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793865720;
	bh=MPraXOhlsseIQOqL/YviCqeB6CAAfjoz8e4cH9OLU3I=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ceY/W+gF0JpV+zBNXrt9h7m4W3S8fOrIKpvClY27f0Z5D+SsW7Y3GVrenoWyQ7YR0
	 xinbrfO9k+afHYywrk9jtJO61Aga3ZUDwtIkxl3Eq66KkiJ6UuJzYzWXz70MnN6Cxn
	 VqxPY6LYxDTCGiB7qKOTKp6EceBhOOtjD4hULOWhvczYTda2CEqCOJLi+jipuTOjy1
	 bsC0BjFx4kYAkIULn3kAHfEW+o9UHMIUGSpayOanLPlMFKOCcZR+rrgw3U4WVyAkbu
	 YGEGEbdvfQCFai0du6xG05Sp8VkYRt9tpQCIVnCAF/YjAoqqun/DTKe12XA0xOqiLu
	 R/iJiTbtenFTA==
Message-ID: <sashiko-outbox-198703@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: switchtec: Fix PCI device reference leak on probe
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yige Jiang" <yigejiang86@gmail.com>, linux-pci@vger.kernel.org
In-Reply-To: <rc-review-20261105-vc-149-07fa7f0c8a18@gmail.com>
References: <rc-review-20261105-vc-149-07fa7f0c8a18@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 08:02:00 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> stdev_create() takes a pci_dev reference for stdev->pdev. When a
> later step of switchtec_pci_probe() fails, err_put drops stdev->dev
> but omits the PCI device reference. stdev_release() only frees
> stdev, so the PCI device remains pinned after the failed probe.
>=20
> Return the PCI device reference before putting stdev->dev, matching
> the existing cleanup in stdev_create() and switchtec_pci_remove().
>=20
> Fixes: df25461119d9 ("PCI: switchtec: Fix stdev_release() crash after sur=
prise hot remove")
> Signed-off-by: Yige Jiang <yigejiang86@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/rc-review-20261105-=
vc-149-07fa7f0c8a18@gmail.com?part=3D1

