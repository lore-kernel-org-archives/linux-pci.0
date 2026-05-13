Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D4221D596
	for <linux-pci@vger.kernel.org>; Wed, 13 May 2026 19:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778701329; cv=none; b=DuWCPOd+xV0LtkY3WVvvy1ZGt1NM1n5LSqM+/PChs4y/N6dKgd/rVif5PhJ9vtUYB7rtTa9iuRuDXjqK1F5emXPGrDPKhJkBrQQde+3lr5eOmid7Vx2U1BHeJ+dGyimec8Q80i0ddE6+LW4VCrK5R/kTD82cxYAueIVJu8fkfe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778701329; c=relaxed/simple;
	bh=4IWZlBOSn+Z6r/IfyA2lKcF6t5lTlG9a4vOiTSH2jEo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KvtsXo83NgwRSkcMZEOabYPQauM4zrtzh7CERQY+dmGv9zPtD7LVlX7DVaSxiLjxZ2ySSeELu+lY9Syx3b2jGiKQcB21UCpigrrwSZ0W7S7LFcMpGNAd7Nirp7xPVRE6ZCc6UShARVvymHGmI5GvxPgxNamt8nR4+AAJKZL0YP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BwlzHYFV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwlzHYFV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F076FC19425;
	Wed, 13 May 2026 19:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778701329;
	bh=4IWZlBOSn+Z6r/IfyA2lKcF6t5lTlG9a4vOiTSH2jEo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=BwlzHYFVBN7rg+CNv3VapwHekOZuYFqnXX5PX0peERThNYi9Rbk3/BhbCoUazJniE
	 WnPNPbBaAEJi2/hRnLrLQC3w5PVqjR9v/g6gQwAr1rxGV4DRkjo2FY1i95mN/Ssu58
	 /bMM3+LWkUKMm/lrR/uHLD7x7GGrSUzzgJm8Ou/NCGuD0EO4SDiJetNDRxCCSvutiC
	 2bYpnQTaNVAVuPylOta9xqWQmrZ4rMf+uUZNECL4M39JgM9ek/DLBqswfx1qLheb3V
	 Zre1/foz7YMcZzccYX7J1IpRJ+jmVxe5XptWSmwSMB6jpZ+/uP9Cs5nuJW0rEqWqtU
	 sWn17tF8qtEmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/sysfs: Check IORESOURCE_DISABLED in resource mmap
 handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ravi Kumar Bandi" <ravib@amazon.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260512084315.32564-1-ravib@amazon.com>
References: <20260512084315.32564-1-ravib@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 19:42:08 +0000
Message-Id: <20260513194208.F076FC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] IORESOURCE_DISABLED is an enumeration/allocation flag, not a dynam=
ic operational state flag.
- [High] The patch fails to check for IORESOURCE_UNSET, leaving a path to m=
ap physical address 0.
- [Medium] The check was omitted from the legacy procfs mmap interface and =
sysfs I/O port read/write handlers.
--

commit b337c28a9b32f2246e39d66b4dc57399f253f527
Author: Ravi Kumar Bandi <ravib@amazon.com>
PCI/sysfs: Check IORESOURCE_DISABLED in resource mmap handler

This commit attempts to block userspace from mapping PCI BAR resources of
disabled or soft-unplugged devices. It does so by adding a check for the
IORESOURCE_DISABLED flag in the sysfs pci_mmap_resource() handler.

> pci_mmap_resource() does not check IORESOURCE_DISABLED before mapping
> a PCI BAR resource into userspace. This allows new mmaps to succeed
> even after a device has been marked disabled or soft-unplugged by the
> driver to prevent further access.

Is IORESOURCE_DISABLED actually set dynamically when a device is disabled
or soft-unplugged by the driver?

Looking at the PCI core, IORESOURCE_DISABLED appears to be an allocation
flag used when a resource cannot be assigned structurally (such as a
64-bit BAR on a 32-bit system). It doesn't seem to be dynamically set
by pci_disable_device() or soft-unplug paths like
pci_stop_and_remove_bus_device().

If the flag is never set during a soft-unplug, will this check successfully
prevent the post-removal mmaps as intended?

> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index d37860841260c..61ae259f8ca80 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1089,6 +1089,9 @@ static int pci_mmap_resource(struct kobject *kobj, =
const struct bin_attribute *a
>  	if (ret)
>  		return ret;
> =20
> +	if (res->flags & IORESOURCE_DISABLED)
> +		return -ENODEV;
> +

Should this also check for IORESOURCE_UNSET?

When the PCI core fails to assign an address to a resource, it sets
IORESOURCE_UNSET and sets the resource start address to 0. Since the size
remains non-zero, the sysfs files are still created and exposed.

Without checking IORESOURCE_UNSET, could pci_mmap_resource_range() add
pci_resource_start() >> PAGE_SHIFT (which is 0) to vma->vm_pgoff, allowing
userspace to inadvertently map physical address 0 (System RAM/BIOS) instead
of an MMIO region?

Additionally, does this protection need to be extended to other interfaces?

Even with this check in sysfs mmap, userspace might still bypass it using
the legacy procfs mmap interface via proc_bus_pci_mmap().

Furthermore, for I/O port BARs (IORESOURCE_IO), the sysfs read and write
callbacks (pci_read_resource_io and pci_write_resource_io) directly execute
inb/outb instructions without verifying if the resource is disabled. Could
an application holding an open file descriptor continue raw hardware
accesses and bypass this protection?

>  	if (res->flags & IORESOURCE_MEM && iomem_is_exclusive(res->start))
>  		return -EINVAL;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512084315.3256=
4-1-ravib@amazon.com?part=3D1
