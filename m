Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2E333FE15;
	Wed, 10 Jun 2026 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105472; cv=none; b=J+H6lZuWO2avsUdSfA5DLoOnuWJz5lfZLadBo9hzJt6Rb9jty57wDk2M/htVoMkUKlvSoKgSrH61yIjHD3MuYsC6Qo2d4VvYZacfcfZ2jl8mGh5kYFsDyBnSDwLJPfETpw9OSIBduqb+HFX7EVY3HFKjI9BYo65bqCDRf3oW5N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105472; c=relaxed/simple;
	bh=wlqMR6ql6lJLXz7l5FjWb7Dktc7ZQRcSJ3J5Z2xjjM4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HQaZRNggf71eYxH2X0LAAGhTA9v3FLVrEOUvruJ95ko3ikiLNYP+h2G4gnSv25sK68GNyjyndySxeuFdALkd4NBw2mUN4YSBPs1lmk7yfZOd9WoIahiH+u7fJDIiuI56d/CiTPkvXDfAJrt1RcO8jJLHkaoU+Mfgsx+RhUV/WDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3DDENyf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3DDENyf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B771F00893;
	Wed, 10 Jun 2026 15:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781105470;
	bh=DuYr8zJ9wqBSZ3/6oyj3O6t2ftqCYkpRs1QIiTwfWbU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h3DDENyf4glJiJ6nmR+oIcdNlWJuGe0rzvU9KZlOo6ETxC1qfXjroX2R1uhUj40DZ
	 yVMg8A0GrVc3VleLTj/jjlCfizgxLqLPLjwgvl8wuZhFPwd3EdozkNh22Fp0pINBuw
	 dPK4uTkWvl9r1oVuitrjRGx5lL3FkWxlxnjxaXAXvc3Z7ouZw2b/nTrgdYYiHao4UP
	 NqTQNrdh4xbrHWjUhiJmw3kZAGGfyilbOGKMYTBPA81sjcBHT1yMHWybl7uyZhyRGP
	 FvIr9ngS6QWC88KxXOgvWwnfy7lzjXdvHFkrkP8Or636vB+Y4Y4nQOdcwyoFX0NwX4
	 2S3l2ytKVUC0w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/5] vfio: Add UAPI for ZONE_DEVICE-backed P2P
 registration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260610151853.3608948-2-praan@google.com>
References: <20260610151853.3608948-2-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 15:31:09 +0000
Message-Id: <20260610153110.47B771F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Dynamic creation of ZONE_DEVICE pages for VFIO-assigned BARs intro=
duces intractable lifetime synchronization issues, leading to Denial of Ser=
vice.
- [Low] The newly introduced `VFIO_DEVICE_FEATURE_P2P_REGISTER` macro lacks=
 a corresponding UAPI structure to specify the target PCI BAR index.
--

commit c98c2e1f824821a8273fbcf6834c8210ddf76e75
Author: Pranjal Shrivastava <praan@google.com>

vfio: Add UAPI for ZONE_DEVICE-backed P2P registration
   =20
Introduce VFIO_DEVICE_FEATURE_P2P_REGISTER to the VFIO_DEVICE_FEATURE
ioctl. This feature allows a privileged userspace process to register
a specific PCI BAR with the kernel's PCI P2P DMA provider framework.

> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 5de618a3a5eee..adbac3f965eb4 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
[ ... ]
> +/**
> + * Upon VFIO_DEVICE_FEATURE_SET register a PCI BAR with the kernel
> + * P2P DMA subsystem (pci-p2pdma).
> + *
> + * Once a BAR is registered, it will be added to the device's P2P
> + * pool and can be allocated via the standard sysfs p2pmem/allocate
> + * interface.
> + *
> + * Note: Standard VFIO mmap() of the BAR will be blocked once it is
> + * registered for native P2P.
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +#define VFIO_DEVICE_FEATURE_P2P_REGISTER 13

[Severity: High]
Does this feature introduce a regression with lifetime synchronization
issues?

When VFIO_DEVICE_FEATURE_P2P_REGISTER is used, ZONE_DEVICE pages are
manufactured for the PCI BAR via devm_memremap_pages(). These pages can be
mapped into userspace using the sysfs p2pmem/allocate interface.

If userspace pins these pages via get_user_pages() (e.g., through an
O_DIRECT read, io_uring, or passing them to another device), the page
reference counts are elevated. If the VFIO device is subsequently unbound
or the file descriptor is closed while the pin is active, the driver
teardown triggers:

vfio_pci_zap_bars()
  -> pci_p2pdma_remove_resource()
    -> devm_memunmap_pages()

The unmap path kills the percpu refcount and waits synchronously via
wait_for_completion() for all references to drop. Because the pages remain
pinned by GUP, the references will never reach zero, causing the kernel
thread to hang indefinitely.

This blocks driver unbinding and holds global locks (such as
vdev->memory_lock and driver core locks), causing a denial of service.

[Severity: Low]
Does this UAPI addition lack a corresponding structure to specify the target
PCI BAR index?

The implementation in vfio_pci_core_feature_p2p_register() appears to
silently assume a primitive u32 payload when calling
copy_from_user(&bar_index, arg, sizeof(bar_index)), creating a mismatch
between documented UAPI and actual kernel expectations.

Standard VFIO UAPI practices require explicit, strongly-typed structures
(e.g., struct vfio_device_feature_p2p_register { __u32 bar_index; };) to
accompany feature macros so that the ABI is well-documented and safe for
userspace developers to consume.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610151853.3608=
948-1-praan@google.com?part=3D1
