Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753068AbcJLQCx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 12:02:53 -0400
Date: Wed, 12 Oct 2016 11:01:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Simon Horman <horms@verge.net.au>,
        linux-renesas-soc@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/5] PCI: rcar: Cleanups
Message-ID: <20161012160155.GE4308@localhost>
References: <20161012125631.24785.91272.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161012125631.24785.91272.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 12, 2016 at 07:58:35AM -0500, Bjorn Helgaas wrote:
>   - Add local "dev" pointers to reduce repetition of things like
>     "&pdev->dev".
> 
>   - Remove platform drvdata because it appears unused (we called
>     platform_set_drvdata() but not platform_get_drvdata()).
> 
>   - Remove unused arguments and #defines.
> 
> Nothing here should change the behavior of the driver.
> 
> Changes from v1:
>   I dropped the following patches because they were a lot of churn for
>   questionable benefit:
>     PCI: rcar: Rename accessors
>     PCI: rcar: Name private struct pointer "rcar" consistently
>     PCI: rcar: Swap order of rcar_writel() reg/val arguments
>     PCI: rcar-gen2: Name private struct pointer "rcar" consistently
>     PCI: rcar-gen2: Add register accessors
> 
> ---
> 
> Bjorn Helgaas (5):
>       PCI: rcar: Add local struct device pointers
>       PCI: rcar: Remove unused platform data
>       PCI: rcar: Remove unused rcar_pcie_get_resources() platform_device arg
>       PCI: rcar: Remove DRV_NAME macro
>       PCI: rcar-gen2: Add local struct device pointers

I applied these to pci/host-rcar for v4.9.  I hope to ask Linus to
pull them tomorrow, so if you see any issues, let me know soon.
