Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751846AbdLDWdO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Dec 2017 17:33:14 -0500
Date: Mon, 4 Dec 2017 16:33:11 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Dave Jones <davej@codemonkey.org.uk>,
        Fengguang Wu <fengguang.wu@intel.com>,
        linux-kernel@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH v2] PCI: Remove sysfs resource mmap warning
Message-ID: <20171204223311.GA24974@bhelgaas-glaptop.roam.corp.google.com>
References: <20171130163557.19488.80756.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171130163557.19488.80756.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 30, 2017 at 10:35:57AM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> When a process uses sysfs and tries to mmap more space than is available in
> a PCI BAR, we emit a warning and a backtrace.  The mmap fails anyway, so
> the backtrace is mainly for debugging.  But in general we don't emit kernel
> messages when syscalls return failure.
> 
> The similar procfs mmap path simply fails the mmap with no warning.  Remove
> the sysfs warning.
> 
> Reported-by: Fengguang Wu <fengguang.wu@intel.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Applied to pci/resource for v4.16.

> ---
>  drivers/pci/pci-sysfs.c |    9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 06c7f0b85cd2..ccc0e28c6678 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1216,14 +1216,9 @@ static int pci_mmap_resource(struct kobject *kobj, struct bin_attribute *attr,
>  	if (res->flags & IORESOURCE_MEM && iomem_is_exclusive(res->start))
>  		return -EINVAL;
>  
> -	if (!pci_mmap_fits(pdev, bar, vma, PCI_MMAP_SYSFS)) {
> -		WARN(1, "process \"%s\" tried to map 0x%08lx bytes at page 0x%08lx on %s BAR %d (start 0x%16Lx, size 0x%16Lx)\n",
> -			current->comm, vma->vm_end-vma->vm_start, vma->vm_pgoff,
> -			pci_name(pdev), bar,
> -			(u64)pci_resource_start(pdev, bar),
> -			(u64)pci_resource_len(pdev, bar));
> +	if (!pci_mmap_fits(pdev, bar, vma, PCI_MMAP_SYSFS))
>  		return -EINVAL;
> -	}
> +
>  	mmap_type = res->flags & IORESOURCE_MEM ? pci_mmap_mem : pci_mmap_io;
>  
>  	return pci_mmap_resource_range(pdev, bar, vma, mmap_type, write_combine);
> 
