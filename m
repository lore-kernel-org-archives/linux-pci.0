Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755855AbcJLQFx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 12:05:53 -0400
Date: Wed, 12 Oct 2016 11:05:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Zhou Wang <wangzhou1@hisilicon.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/8] PCI: hisi: Cleanups
Message-ID: <20161012160548.GO4308@localhost>
References: <20161012133904.28562.74066.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161012133904.28562.74066.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 12, 2016 at 08:42:27AM -0500, Bjorn Helgaas wrote:
>   - Add local "dev" pointers to reduce repetition of things like
>     "&pdev->dev".
> 
>   - Remove platform drvdata because it appears unused (we called
>     platform_set_drvdata() but not platform_get_drvdata()).
> 
>   - Name private struct pointer consistently within driver.
> 
>   - Remove redundant struct members.
> 
>   - Use generic DesignWare accessors when possible.
> 
>   - Pass device-specific struct to internal functions for consistency.
> 
>   - Include register block base in PCIE_SYS_STATE4 address to simplify
>     users.
> 
> Nothing here should change the behavior of the driver.
> 
> Changes from v1:
>   I dropped the following patches because they were a lot of churn for
>   questionable benefit:
>     PCI: hisi: Rename APB accessors
>     PCI: hisi: Rename config accessors
>     PCI: hisi: Name private struct pointer "hisi" consistently
>       (Instead of renaming *all* the pointers, I only renamed enough to
>       make them consistent within this file.)
>     PCI: hisi: Swap order of hisi_apb_writel() reg/val arguments
> 
> ---
> 
> Bjorn Helgaas (8):
>       PCI: hisi: Add local struct device pointers
>       PCI: hisi: Remove unused platform data
>       PCI: hisi: Name private struct pointer "hisi_pcie" consistently
>       PCI: hisi: Remove redundant struct hisi_pcie.reg_base
>       PCI: hisi: Use generic DesignWare accessors
>       PCI: hisi: Include register block base in PCIE_SYS_STATE4 address
>       PCI: hisi: Pass device-specific struct to internal functions
>       PCI: hisi: Reorder struct hisi_pcie
> 
> 
>  drivers/pci/host/pcie-hisi.c |   86 +++++++++++++++++-------------------------
>  1 file changed, 35 insertions(+), 51 deletions(-)

I applied these to pci/host-hisi for v4.9.  I hope to ask Linus to
pull them tomorrow, so if you see any issues, let me know soon.
