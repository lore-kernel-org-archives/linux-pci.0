Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793903906;
	b=VH6XpNdpgsDCZda1fm6KSvuxYR/x4+1hupaY4TWFnNaCmz8sA+t8jCSSlI4vYVmpol22
	 cuIEIU9tbcXCXXiQYmqz3zC5f9jUczoZ5tzPVfZm+EmUB0m6d1orIXIlhoyFNZeA39Rw9
	 VX2OZMr8r1MwhgSdvApMX40q8Ar4ntIjV6qB3Kk7vVUUkFLlzFZ9mNrDQyAe4sMEMY/nE
	 aJ13iwgXKJZS07mqGBhTESKRnx5IyxgkKuHH9OSDFz4RlJpBM7+XemDTCS2d5HbmZ45Ke
	 2ozu2Kt1Lrn82qTbtAKxt9hlhXzwX/qZmyxgdjidF60HNyPGo0h7E/1+KoDnMb+x0Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793903906;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZmOnOAk/J7pb8jfu/qCGY9EywU7Usgv6MEs/VE8Vb9Y=;
	b=BuAwxEiT/zolkzKuICV0HH1I+aPcUHJYxeLwZ1/s2Y2cwJp1QU0bl/+6ZNTnyo6+1Ur6
	 6OTRP8dDZZuuerNE6kOxjQzEwQq0CVIVt3ecZuRpqiJfBhLBt/zIYSLZc2QMmtj2Gs5Hh
	 bWgbUb8d5EgXat4ZdIMG0mibTrPwRDTR/igYDk3vggtSYL1u0HDa+uiDyoghQ/f7CV+cN
	 wxZnmAPQ9LD5LZnhr88ROaF55c1ZpKz+26fbuYBYVUWj3RxgeyTZbGvhOKf9iTDkLIk+o
	 oGTP/axJDk3HhXAX5WlSe7iOvQcI9saEY7/CpSdNg+lJOkfO2Dfy9dBPLibjjdk0WXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SkGjuuda;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4A4606A31B
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 18:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SkGjuuda
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B901F0093A;
	Thu,  5 Nov 2026 18:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793903905;
	bh=ZmOnOAk/J7pb8jfu/qCGY9EywU7Usgv6MEs/VE8Vb9Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SkGjuudaU7+YdWLhE4HOQVx3dn8AJeFWrNZIqepDDiLOZIDZHCjnK/v4dIWyh37Ay
	 qLz424sTLXI4DU0enU+MDx3SgT8fki+4U3+tCQxyen7QB0mvPQuedliRFCdI9yLsG8
	 PJVkXfgh45j88wwbhFTstrCK+m5l/SoI9IAwwaqXzWWqx0WidZ3GFcpdslGTJGsJ7Z
	 UW1OAcK2+LoDDLai/3qg9RKA6PrBved2MUjM6okUPAidjgB6NjVeacADHy/L8CsDkZ
	 gFlxe/a0CLMLpnsgWkBsOnph0C5C9SrlNbvznxPVhiUlhsLsGCemXuUDX3BlBO9+t7
	 Hfws6XsF6EtLw==
Message-ID: <sashiko-outbox-199782@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] genirq: Add disable_irq_noflush()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Keith Busch" <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261105182706.3700908-2-kbusch@meta.com>
References: <20261105182706.3700908-1-kbusch@meta.com>
 <20261105182706.3700908-2-kbusch@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 18:38:24 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Keith Busch <kbusch@kernel.org>
>=20
> Drivers that switch between interrupt and polled completions don't need
> the mask write flushed to the device; the disabled state already
> keeps their handler from running and a late interrupt is replayed on
> enable. Add an optional irq_chip::irq_mask_noflush() callback, falling
> back to irq_mask(), and disable_irq_noflush() to mask through it right
> away rather than lazily.
>=20
> Suggested-by: Thomas Gleixner <tglx@kernel.org>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105182706.3700=
908-1-kbusch@meta.com?part=3D1

