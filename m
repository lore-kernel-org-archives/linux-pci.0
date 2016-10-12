Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753645AbcJLQFB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 12:05:01 -0400
Date: Wed, 12 Oct 2016 11:04:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, linux-pci@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH v2 0/7] PCI: dra7xx: Cleanups
Message-ID: <20161012160457.GM4308@localhost>
References: <20161012133112.27714.93244.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161012133112.27714.93244.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 12, 2016 at 08:32:31AM -0500, Bjorn Helgaas wrote:
>   - Add local "dev" pointers to reduce repetition of things like
>     "&pdev->dev".
> 
>   - Remove redundant struct members.
> 
>   - Use generic DesignWare accessors when possible.
> 
>   - Pass device-specific struct to internal functions for consistency.
> 
>   - Move struct pcie_port setup to probe function for consistency.
> 
> Nothing here should change the behavior of the driver.
> 
> Changes from v1:
>   I dropped the following patches because they were a lot of churn for
>   questionable benefit:
>     PCI: dra7xx: Rename accessors
>     PCI: dra7xx: Name private struct pointer "dra7xx" consistently
> 
> ---
> 
> Bjorn Helgaas (7):
>       PCI: dra7xx: Add local struct device pointers
>       PCI: dra7xx: Remove redundant struct device pointer from dra7xx_pcie
>       PCI: dra7xx: Set drvdata at end of probe function
>       PCI: dra7xx: Use generic DesignWare accessors
>       PCI: dra7xx: Pass device-specific struct to internal functions
>       PCI: dra7xx: Move struct pcie_port setup to probe function
>       PCI: dra7xx: Reorder struct dra7xx_pcie
> 
> 
>  drivers/pci/host/pci-dra7xx.c |  103 ++++++++++++++++++-----------------------
>  1 file changed, 45 insertions(+), 58 deletions(-)

I applied these to pci/host-dra7xx for v4.9.  I hope to ask Linus to
pull them tomorrow, so if you see any issues, let me know soon.
