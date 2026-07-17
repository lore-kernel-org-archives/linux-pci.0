Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6066035E1B8;
	Fri, 17 Jul 2026 22:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784327712; cv=none; b=G5qfmeKGaIId+2CIYCuVxA3GJlstByRzPWUg/xXQcd6ppnIf4AQdnk3PiJt0oZQu0Kng1KZk7qN1pBLLNGQrEGyh8Oa4lAqA7zQcMPzjJdpgmr68ZeAv5JdnTvcsFWRcxOh1UwzRw1FXaFvYqE5lzbwniLr+7aZ0WC4pKfG5PdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784327712; c=relaxed/simple;
	bh=CTDMyaO0UFRm6Tk93rldwsTy21lX6xtZs6n7J1JOre0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aC3jgaV7yM1Bsge/E3DWdbmSaSAsJBKUS5PRX51CTSVRFodsPfjuCc87NbfGUIPQpeuVB4gpAhZlsZTgUTXyx1Y8m35jARdZOg6rvfevEY5J044BAO/U1dzioEZeKG7Izcbkvca5vF9vljQ9HfFciGXkuu6DpvYOuRSLRa3Z7aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZubLR9Mu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZubLR9Mu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030751F000E9;
	Fri, 17 Jul 2026 22:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784327711;
	bh=n9s9nFWYwfUjr8ZsDMB1zApupe/nMtqeXxexvtYNlwA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZubLR9MufAfzMqYd/7hbcwQ1TpDILcOg3wX++uIGKdLzbKeNhDIp0mYzjXNMbfcdN
	 uLc6Ob1er9nPbsU0Rfo8Pca/0hUmTRIvZm1a/O8qI5BO/0be/sQjM0J2EDyMEJ5RG5
	 AVyHQKf3J1abkwnUymCsZmJYP74KALcs9hISIK4+vS4H0V0oKpkaBdgf3kL3DaNS10
	 M+bPXPA8dJIO6wJltlIcMEgnByDDZnIJGlOsVrnr7DT1DkWVAhqtdGtS/ZByHf+NFA
	 o8NZpKfB88PtznAvDX264Ovs6AK/Pj9yNPO+kqhrF5CiOnL9FHziUfmruJz6yeOtSv
	 sg+NMay+tPQ4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 5/6] dmaengine: ioat: use sysfs_emit() in per-channel
 sysfs show()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: linux-pci@vger.kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260717221001.361421-6-logang@deltatee.com>
References: <20260717221001.361421-1-logang@deltatee.com>
 <20260717221001.361421-6-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 22:35:10 +0000
Message-Id: <20260717223511.030751F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `.release` callback in `ioat_ktype` leads to Use-After-Fre=
e during device teardown.
--

--- Patch [5]: [PATCH v1 5/6] dmaengine: ioat: use sysfs_emit() in per-chan=
nel sysfs show() ---
commit 92c0d5a2427ebf1a54399ad0e602ee20f0d12130
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: ioat: use sysfs_emit() in per-channel sysfs show()

Convert the sprintf() calls in the per-channel sysfs attribute show()
functions to sysfs_emit().

> diff --git a/drivers/dma/ioat/sysfs.c b/drivers/dma/ioat/sysfs.c
> index e796ddb5383f8..976134df81084 100644
> --- a/drivers/dma/ioat/sysfs.c
> +++ b/drivers/dma/ioat/sysfs.c

[ ... ]

[Severity: High]
This is a pre-existing issue, but does ioat_ktype need a .release callback?

Looking at drivers/dma/ioat/sysfs.c:ioat_ktype:

const struct kobj_type ioat_ktype =3D {
	.sysfs_ops =3D &ioat_sysfs_ops,
	.default_groups =3D ioat_groups,
};

Without a .release callback, doesn't this break the kobject reference count=
ing
lifecycle?  If a user space process keeps a sysfs file open (like ring_size)
while the device is hot-unplugged or the driver is unbound, release_ioatdma=
()
frees the ioatdma_chan structures directly.

When the user space process later closes the sysfs file and the kobject
reference count drops to zero, the kernel will attempt to access the kobject
embedded in the already-freed ioatdma_chan memory.  Can this cause a
use-after-free during device teardown?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717221001.3614=
21-1-logang@deltatee.com?part=3D5
