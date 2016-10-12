Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753771AbcJLQGK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 12:06:10 -0400
Date: Wed, 12 Oct 2016 11:06:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Richard Zhu <Richard.Zhu@freescale.com>,
        Lucas Stach <l.stach@pengutronix.de>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/8] PCI: imx6: Cleanups
Message-ID: <20161012160605.GP4308@localhost>
References: <20161012134335.28919.64137.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161012134335.28919.64137.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 12, 2016 at 08:47:32AM -0500, Bjorn Helgaas wrote:
>   - Add local "dev" pointers to reduce repetition of things like
>     "&pdev->dev".
> 
>   - Clean up redundant dev->of_node usage.
> 
>   - Remove redundant struct members.
> 
>   - Pass struct imx6_pcie pointer rather than register address to PHY
>     accessors.  This enables use of the generic DesignWare accessors.
> 
>   - Use generic DesignWare accessors when possible.
> 
>   - Pass device-specific struct to internal functions for consistency.
> 
>   - Remove unused return values.
> 
> Nothing here should change the behavior of the driver.
> 
> Changes from v1:
>   I dropped the following patches because they were a lot of churn for
>   questionable benefit:
>     PCI: imx6: Name private struct pointer "imx6" consistently
>     PCI: imx6: Name PHY accessors consistently with other i.MX6 accessors
>     PCI: imx6: Add register accessors
> 
> ---
> 
> Bjorn Helgaas (8):
>       PCI: imx6: Add local struct device pointers
>       PCI: imx6: Remove redundant of_node pointer
>       PCI: imx6: Removed unused struct imx6_pcie.mem_base
>       PCI: imx6: Pass struct imx6_pcie to PHY accessors
>       PCI: imx6: Pass device-specific struct to internal functions
>       PCI: imx6: Use generic DesignWare accessors
>       PCI: imx6: Reorder struct imx6_pcie
>       PCI: imx6: Remove unused return values
> 
> 
>  drivers/pci/host/pci-imx6.c |  250 ++++++++++++++++++++++---------------------
>  1 file changed, 126 insertions(+), 124 deletions(-)

I applied these to pci/host-imx6 for v4.9.  I hope to ask Linus to
pull them tomorrow, so if you see any issues, let me know soon.
