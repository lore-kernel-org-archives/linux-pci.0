Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754879AbcJLQ0i (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 12:26:38 -0400
Date: Wed, 12 Oct 2016 11:00:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ley Foon Tan <lftan@altera.com>, linux-pci@vger.kernel.org,
        rfi@lists.rocketboards.org
Subject: Re: [PATCH v2 0/6] PCI: altera: Cleanups
Message-ID: <20161012160053.GB4308@localhost>
References: <20161012123804.23240.96181.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161012123804.23240.96181.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 12, 2016 at 07:46:59AM -0500, Bjorn Helgaas wrote:
>   - Add local "dev" pointers to reduce repetition of things like
>     "&pdev->dev".
> 
>   - Remove platform drvdata because it appears unused (we called
>     platform_set_drvdata() but not platform_get_drvdata()).
> 
>   - Removed an unnecessary platform_get_resource() return value check.
> 
>   - Rework TLB_CFG_DW0 and TLP_CFG_DW1 to make the code prettier.
> 
> Nothing here should change the behavior of the driver.
> 
> Changes from v1:
>   I dropped the following patches because they were a lot of churn for
>   questionable benefit:
>     PCI: altera: Name private struct pointer "altera" consistently
>     PCI: altera: Rename _altera_pcie_cfg_read() to altera_raw_cfg_read()
>     PCI: altera: Rename CRA accessors
>     PCI: altera: Swap order of altera_cra_writel() reg/val arguments
> 
> ---
> 
> Bjorn Helgaas (6):
>       PCI: altera: Add local struct device pointers
>       PCI: altera: Remove unused platform data
>       PCI: altera: Remove redundant platform_get_resource() return value check
>       PCI: altera: Rename altera_pcie_valid_config() to altera_pcie_valid_device()
>       PCI: altera: Simplify TLB_CFG_DW0 usage
>       PCI: altera: Simplify TLP_CFG_DW1 usage

I applied these to pci/host-altera for v4.9.  I hope to ask Linus to
pull them tomorrow, so if you see any issues, let me know soon.
