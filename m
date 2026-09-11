Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DAF25B092
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 13:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789132409; cv=none; b=TeD96QvAEGT88iRA3WVYEOUUVoGnJjV/Std8m041EJRLdX3dgXzX4dpjwbYfI5MA4wOzO+Rgf7K1Ey3cLyfqLlTN+L2KJzxKBJnKT6AgAGfkqNvj/b4zCT5Dnaqef9tQ8RcjbVKmWhZwS9JdJBQ/Vw5U0+p8JzlKIzB7YrJa/QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789132409; c=relaxed/simple;
	bh=Snx4cbRkNZOf+ntOBTkIxeyKF9fJ7Y/8mc96BEhznmc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k89deYsgn/MO/CmNg355qC01kVwjfbnGaRDX2pVzMrPRazjoJnvRer95RnKGR9NqtCRLEC9PX1C+m5DBZfLpCz8rOc8l3VLROBGWhXIwWF27g5SjPXnK4PPr2n+zFxVVF6Ih+ykq/6ty67/KkCgIZ/docaUunrO1yOSURt2simM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cm50UUHJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cm50UUHJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB9E1F000FF;
	Fri, 11 Sep 2026 13:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789132407;
	bh=WJ1NbtLSq9oInuFIX5jjqPEkg/uaoYbT6Fr+YKpEC5Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cm50UUHJ8/HCtGOf9ROw6hsCBW8mHOJeWr79gYGZqiSyAQNiaeUkmSL8HDa+/lywy
	 AYJ6g2jRdQ9R7T3fiauM1rW/+TgQB1KleTXsqvJ488XeqwWOaKdPUAWCgSWZOcZyf8
	 UHMQH+OnW2t8pz3Dxzq/HSl7bhucmoo0+L8r0pyNQsgO+WcjwwM4XqDbCoYRjZvoBu
	 Gd5l1Bd2pQPSQ1Zq74eFWnAk9UCt2JenyrnCnIYoJ+oyCyweeuPorJtHKOhlCn4Pnx
	 BaOikvLCQWj7oMG6/xcHzpYEtnLlnxjAHETzD37435AUkXBw5pysrOfoWxKBN7PXEI
	 yUi6R/lduWHHA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/3] iommu: create device sysfs links outside
 iommu_probe_device_lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pavol Sakac" <sakacpav@amazon.de>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260911125907.67105-2-sakacpav@amazon.de>
References: <20260911-vfopt-s2-v1-0-fff3db7e01c2@amazon.de>
 <20260911125907.67105-2-sakacpav@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 13:13:27 +0000
Message-Id: <20260911131327.8DB9E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Early success return on `dev->iommu_group` allows concurrent probe=
s to bypass synchronization, leading to Use-After-Free if publication fails.
--

commit 4fb83220aac8b0e212834d62f2d81e2c473af4b4
Author: Pavol Sakac <sakacpav@amazon.de>

iommu: create device sysfs links outside iommu_probe_device_lock

This patch optimizes parallel device probes by moving sysfs link publication
out of the iommu_probe_device_lock. It introduces a mechanism where devices
are added to the group first, and later passes attempt to establish the
sysfs links outside the lock.

> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 5f92981d9f345..a5e3327aeacaf 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -710,19 +711,68 @@ static int __iommu_probe_device(struct device *dev,=
 struct list_head *group_list
>  int iommu_probe_device(struct device *dev)
>  {
>  	const struct iommu_ops *ops;
> +	struct group_device *gdev, *own;
> +	struct iommu_group *group;
>  	int ret;
> =20
>  	mutex_lock(&iommu_probe_device_lock);
> +	/* Already probed; publication belongs to the creating call. */
> +	if (dev->iommu_group) {
> +		mutex_unlock(&iommu_probe_device_lock);
> +		goto probe_finalize;
> +	}

[Severity: High]
Could this early return allow a concurrent thread to bypass synchronization
and proceed to finalize the device while the primary thread is still
executing publication steps?

If two threads concurrently call iommu_probe_device() for the same device
without device_lock() held, Thread B could see dev->iommu_group already
set by Thread A and jump straight to probe_finalize.

[ ... ]

> +probe_finalize:
>  	ops =3D dev_iommu_ops(dev);
>  	if (ops->probe_finalize)
>  		ops->probe_finalize(dev);

[Severity: High]
If Thread B jumps to probe_finalize, could it dereference dev->iommu
via dev_iommu_ops(dev) while Thread A executes the err_remove_device path?

[ ... ]

> +err_remove_device:
> +	/* Retried probes early-exit on membership; failure must undo it. */
> +	own =3D NULL;
> +	for_each_group_device(group, gdev) {
> +		if (gdev->dev =3D=3D dev) {
> +			own =3D gdev;
> +			break;
> +		}
> +	}
> +	if (own) {
> +		list_del(&own->list);
> +		__iommu_group_free_device(group, own);
> +		iommu_deinit_device(dev);
> +	}

[Severity: High]
Does calling iommu_deinit_device(dev) free dev->iommu here in Thread A,
leading to a use-after-free when Thread B accesses it in probe_finalize?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-vfopt-s2-v=
1-0-fff3db7e01c2@amazon.de?part=3D2
