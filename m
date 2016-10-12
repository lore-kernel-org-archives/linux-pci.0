Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754567AbcJLQDn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 12:03:43 -0400
Date: Wed, 12 Oct 2016 11:03:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Michal Simek <michal.simek@xilinx.com>,
        =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/5] PCI: xilinx: Cleanups
Message-ID: <20161012160334.GI4308@localhost>
References: <20161012130819.25793.17542.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161012130819.25793.17542.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 12, 2016 at 08:10:30AM -0500, Bjorn Helgaas wrote:
>   - Add local "dev" pointers to reduce repetition of things like
>     "&pdev->dev".
> 
>   - Remove platform drvdata because it appears unused (we called
>     platform_set_drvdata() but not platform_get_drvdata()).
> 
>   - Remove unused xilinx_pcie_assign_msi() argument.
> 
> Nothing here should change the behavior of the driver.
> 
> Changes from v1:
>   Added "PCI: xilinx: Removed unused xilinx_pcie_assign_msi() argument"
>   I dropped the following patches because they were a lot of churn for
>   questionable benefit:
>     PCI: xilinx: Name private struct pointer "xilinx" consistently
>     PCI: xilinx: Rename accessors
>     PCI: xilinx: Swap order of xilinx_writel() reg/val arguments
>     PCI: xilinx-nwl: Name private struct pointer "nwl" consistently
>     PCI: xilinx-nwl: Swap order of nwl_bridge_writel() reg/val arguments
> 
> ---
> 
> Bjorn Helgaas (5):
>       PCI: xilinx: Add local struct device pointers
>       PCI: xilinx: Remove unused platform data
>       PCI: xilinx: Removed unused xilinx_pcie_assign_msi() argument
>       PCI: xilinx-nwl: Add local struct device pointers
>       PCI: xilinx-nwl: Remove unused platform data

I applied these to pci/host-xilinx for v4.9.  I hope to ask Linus to
pull them tomorrow, so if you see any issues, let me know soon.
