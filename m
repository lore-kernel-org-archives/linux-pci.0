Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72625409275
	for <linux-pci@vger.kernel.org>; Thu,  1 Oct 2026 16:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790871003; cv=none; b=YWesSpLamYOGhxUaxxTv4xF5cWxNKVHp2zdV/N20o7+fwIyQtAyScttCp0oT7OLh6kLvjXUYyzu2cegCdStvPd8viPQ5Rc20B9Zw64N4DNGkfRsi6Z2a0AlO0scH4aNAYi9mO7hw+p/NqHmUjURZgrmdRqw7W1bEImCuUf7QvHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790871003; c=relaxed/simple;
	bh=zHMEn9mBt336/JVgb7iB54AgdSDZLc1kqjy1o9LE44g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WgrCzxW5PqWw6JgKYiqLVTGK0fFGtYhED1S4GYJrjQOQy5AkhOZyd1PYnTeYB+XCvZM6fxbtgbLlRLqrm7EAO7iXA0sptiue8EcAvgcSuKxP5iSWHTiX7JIc5mdVC7B/hN5fh+6ohHM/fXyzkcCiWUrzqzgQZ5BbqvEG5j4E+kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPkshFlW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPkshFlW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1379B1F000FF;
	Thu,  1 Oct 2026 16:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790871002;
	bh=f1sm/bW1O3VudyW6w95/8ZT5b8IRkhDV3r3OVOVHT74=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HPkshFlWnGiTV7t3whxVPNuVjenN7edaS6kQNBl22nyxKAt0OsHIRoXZk2QCUo4Yd
	 +gkxOIVwDWfRiUuB0DniEXw73WcftOvIDaYHCuZ6m+IRY0BvqYnOXY+Nrm8k94/E50
	 vLGjxVT1/gnoOOBLnSMVwH/xNWSzhF3lyxtUzK84cG/WrLT07fZhJi6PVCeCCKi5C+
	 ub8p20AyAyu1M6T6n3KDUe0jNHC9fGCapQ/CHeqyLu0VqW8lxGTLnAOa5nLbTm1ULu
	 8jlLeleltvKimEw9sNEYJI2QKX7P6ijAJ/oPa8r6SuiVGslB8k4cssMUIpuYGrYWOb
	 9NZk/I0no91Bw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 2/3] PCI: Add per-device debugfs directories
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Huang" <wei.huang2@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261001155551.4182899-3-wei.huang2@amd.com>
References: <20261001155551.4182899-1-wei.huang2@amd.com>
 <20261001155551.4182899-3-wei.huang2@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 16:10:00 +0000
Message-Id: <20261001161002.1379B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] PCI: system-wide stall during hotplug due to global pci_debugfs_lo=
ck held over debugfs removal
- [Medium] PCI: speculative resource leak due to unpoisoned debugfs pointer=
 on teardown
--

commit 64859f6a500632327edcd41b730592212c9d3478
Author: Wei Huang <wei.huang2@amd.com>

PCI: Add per-device debugfs directories

This commit adds per-device debugfs directories owned by the PCI core,
using pci_dev_debugfs_dir() to create them on demand and pci_destroy_dev()
to recursively remove them.

> diff --git a/drivers/pci/debugfs.c b/drivers/pci/debugfs.c
> new file mode 100644
> index 0000000000000..682fb614d7cfb
> --- /dev/null
> +++ b/drivers/pci/debugfs.c

[ ... ]

> +void pci_dev_debugfs_remove(struct pci_dev *dev)
> +{
> +	guard(mutex)(&pci_debugfs_lock);
> +
> +	debugfs_remove_recursive(dev->debugfs);

[Severity: High]
Does holding the global pci_debugfs_lock during debugfs_remove_recursive()
risk a system-wide stall?

If a userspace process is actively reading a debugfs file, the removal will
block for SRCU synchronization. Because the global lock is held via
guard(mutex) for the entire function scope, any concurrent
pci_dev_debugfs_dir() or pci_dev_debugfs_remove() calls on unrelated PCI
devices will then block indefinitely during hotplug and removal operations.

Could the dentry be extracted under the lock and removed outside of it?

> +	dev->debugfs =3D NULL;

[Severity: Medium]
Can a concurrent runtime sysfs operation mistakenly recreate this debugfs
directory after removal?

This sets the pointer to NULL while the device is still exposed to the
system. As seen in pci_destroy_dev(), pci_dev_debugfs_remove() is called
prior to device_del(). If a concurrent operation calls pci_dev_debugfs_dir()
and sees NULL, it might recreate the directory and permanently leak it after
the device is finally deleted.

Should the pointer be explicitly poisoned with ERR_PTR(-ENODEV) instead
of set to NULL to prevent recreation?

> +}

> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index e711ac1d4e38a..e10139117d578 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c

[ ... ]

> @@ -37,6 +37,7 @@ static void pci_destroy_dev(struct pci_dev *dev)
>  	platform_pci_remove_wake(dev);
>  	pci_doe_sysfs_teardown(dev);
>  	pci_npem_remove(dev);
> +	pci_dev_debugfs_remove(dev);
> =20
>  	/*
>  	 * While device is in D0 drop the device from TSM link operations
>  	 * including unbind and disconnect (IDE + SPDM teardown).
>  	 */
>  	pci_tsm_destroy(dev);
> =20
>  	device_del(&dev->dev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001155551.4182=
899-1-wei.huang2@amd.com?part=3D2
