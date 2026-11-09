Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794232336;
	b=nadXExEAaxoAvmCN3kZZydiISWYpoOU1rcJjTjbz4St6QwlIU4hdMzHd1nlE3aVowzAJ
	 2XgnZ151nt3qbj6sNjVFMl3JhMhnX+9xCqvsP/htnhzMecQewwlhjwMXkGqt9HcsNUHZu
	 7qq6W9rfLgM2GxNaSYAHleuNIia3uclSbB1rZf5C7wNzLw4HkQGVf7HgFutSbDuG12g59
	 c++jmD0EFRKzy/QSVb+Sy1W3tqAGe/QCQjjHptk4l23UrX20k4pRwaT2n9+AowuTj8q94
	 j2EZmRrnpLM0QFKerLkmgA8z+pKWd22CGk/+IDfnRD00bwo5co7jfTpCboIMli+jbzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794232336;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=4e/BNGcSvSyhNYkpXjIvVYtuD2SjRJs9/QVk/S0oRG0=;
	b=ravepj6uYCmOX2FWNrnUh/6NvJ7y+w0zfT7XZuz1woIOiYT113QaL1WbK1tEcCn4r8Yk
	 c8DlHxCMijZzvJrPDSs971a9tXUsJgg4piqXoQLm0NCV+zhu8VogvsvHJ/srvPoREsDPo
	 0bTIfkNIXLnz39QaZGH+jtMlkXEVySiDyvMnW9fGxLgrrUdgZro7ZJUW2nJrN6XbdJCB6
	 xGXqDTeCoJDoCrRSVxwbDM8ldMxNGTdDJYoBaTtWHyreKt07uFDsnWQcyvwP3uA/gol/w
	 CynrJXWhbLwI2ERZdGISXFny53pwO21P1/WbawF9u5GG74u1F7c4tCpM9R5t+3zgTRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QbiRlqit;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488E8606A31C;
	Mon,  9 Nov 2026 13:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QbiRlqit
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2178B1F0089F;
	Mon,  9 Nov 2026 13:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794232335;
	bh=4e/BNGcSvSyhNYkpXjIvVYtuD2SjRJs9/QVk/S0oRG0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=QbiRlqitBWmGFtvvdwMCQdtXvtoBxbUEYI8MmZdz7OaNj7ucWA4PPI3utBg8vaxfz
	 ZYoI8ZfYw0uekZRkw9CPtikAYZI2ZVTDHdGzyon+CCuaMbUZ4Upq0XWbOszIc9lyIa
	 I/iRURpyryFpzo+OxsVX6j7ORaYOB+JhivwOI2i3RXMiNcCPSROP/zAY3PjNfoctfc
	 MF5lf4RpEvcHvEe+OsIpdH5YQzp9fYdRG0DcnCuSi8lp7v5eXyvIQDem4IVoKM6bUM
	 N8fqcwQi15a+qPoDjAzbSIIABlwOgjFy78iFbtN1/zGaeaZGIeGf+kkDzdZmdWlhs3
	 MA8zvXTfVfQaQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Yu Yang via B4 Relay <devnull+yuyang.kylinos.cn@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Brett
 Creeley <brett.creeley@amd.com>, Shannon Nelson <sln@onemain.com>,
 linux-kernel@vger.kernel.org, Yu Yang <yuyang@kylinos.cn>
Subject: Re: [PATCH] PCI/MSI: Skip address mask check for MSI-X entries
In-Reply-To: <20261109-pci-fix-msix-alloc-failure-v1-1-6370c0b84354@kylinos.cn>
References: <20261109-pci-fix-msix-alloc-failure-v1-1-6370c0b84354@kylinos.cn>
Date: Mon, 09 Nov 2026 14:52:12 +0100
Message-ID: <87mrriun77.ffs@fw13>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Nov 09 2026 at 17:24, Yu Yang via B4 Relay wrote:
> From: Yu Yang <yuyang@kylinos.cn>
>
> The AHCI controller on Zhaoxin ZX-200 platforms supports only 32-bit
> MSI addresses, but its MSI-X capability uses 64-bit message addresses.
> pci_msi_init() therefore sets dev->msi_addr_mask to DMA_BIT_MASK(32)
> based on the MSI capability.
>
> msi_verify_entries() is shared between the MSI and MSI-X setup paths.
> When the irq domain assigns an MSI-X message address above 4GB, the
> 32-bit mask inherited from the MSI capability causes MSI-X setup to
> fail with -EIO:
>
>   ahci 0000:09:0f.0: arch assigned 64-bit MSI address 0x8002a030040
>   above device MSI address mask 0xffffffff.
>   ...
>   ahci: probe of 0000:09:0f.0 failed with error -22.
>
> MSI-X table entries have a 64-bit message address field, so the 32-bit
> limit derived from the MSI capability does not apply to them.

That's just wrong. The limitation is not about the size of the address
field. The limitation is about the ability of the platform/device to
handle DMA to addresses above 4G.

There are devices/platforms out there which have such limitiations.

> Platforms that use msi_addr_mask to constrain MSI-X allocation, e.g.
> powerpc pseries/powernv and ionic on PPC64, already allocate addresses
> that satisfy the mask, so the verification is redundant for MSI-X.

The core cannot rely on random implementation details of drivers and
architecture code. It fails gracefully when the provided address limit
is violated to prevent hard to diagnose subsequent failures.

Coming back to your AHCI controller. That's broken to begin with. Assume
that MSI-X is not supported then MSI setup would fail the same way. You
don't notice because MSI-X is always enabled on x86 platforms.

Something like the uncompiled below should work. You get the idea.

Thanks,

        tglx
---
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -430,6 +430,9 @@ int __pci_enable_msi_range(struct pci_de
 	if (!pci_msi_supported(dev, minvec) || dev->current_state != PCI_D0)
 		return -EINVAL;
 
+	if (dev->pci_msi_broken)
+		return -ENOTSUPP;
+
 	/* Check whether driver already requested MSI-X IRQs */
 	if (dev->msix_enabled) {
 		pci_info(dev, "can't enable MSI (MSI-X already enabled)\n");
--- a/drivers/pci/msi/pcidev_msi.c
+++ b/drivers/pci/msi/pcidev_msi.c
@@ -23,6 +23,14 @@ void pci_msi_init(struct pci_dev *dev)
 				      ctrl & ~PCI_MSI_FLAGS_ENABLE);
 	}
 
+	/*
+	 * PCI/MSI support on some devices is broken and would end up
+	 * restricting the MSI address mask which in turn breaks MSI-X support
+	 * on the device.
+	 */
+	if (dev->pci_msi__broken)
+		return;
+
 	if (!(ctrl & PCI_MSI_FLAGS_64BIT))
 		dev->msi_addr_mask = DMA_BIT_MASK(32);
 }
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6449,6 +6449,12 @@ static void nvidia_ion_ahci_fixup(struct
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0ab8, nvidia_ion_ahci_fixup);
 
+static void zhaoxin_ahci_fixup(struct pci_dev *pdev)
+{
+	pdev->pci_msi_broken = 1;
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ZHAOZIN, 0x????, zhaoxin_ahci_fixup);
+
 static void rom_bar_overlap_defect(struct pci_dev *dev)
 {
 	pci_info(dev, "working around ROM BAR overlap defect\n");
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -515,6 +515,7 @@ struct pci_dev {
 	unsigned int	rom_bar_overlap:1;	/* ROM BAR disable broken */
 	unsigned int	rom_attr_enabled:1;	/* Display of ROM attribute enabled? */
 	unsigned int	non_mappable_bars:1;	/* BARs can't be mapped by CPU or peers */
+	unsigned int	pci_msi_broken:1,	/* PCI/MSI support broken. PCI/MSI-X still works */
 	pci_dev_flags_t dev_flags;
 	atomic_t	enable_cnt;	/* pci_enable_device has been called */
 
