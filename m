Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932125AbcJLQGn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 12:06:43 -0400
Date: Wed, 12 Oct 2016 11:06:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Minghuan Lian <minghuan.Lian@freescale.com>,
        Mingkai Hu <mingkai.hu@freescale.com>,
        Roy Zang <tie-fei.zang@freescale.com>,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 0/7] PCI: layerscape: Cleanups
Message-ID: <20161012160639.GR4308@localhost>
References: <20161012135413.29815.75484.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161012135413.29815.75484.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 12, 2016 at 08:57:22AM -0500, Bjorn Helgaas wrote:
>   - Add local "dev" pointers to reduce repetition of things like
>     "&pdev->dev".
> 
>   - Remove platform drvdata because it appears unused (we called
>     platform_set_drvdata() but not platform_get_drvdata()).
> 
>   - Remove redundant struct members.
> 
>   - Pass device-specific struct to internal functions for consistency.
> 
>   - Move struct pcie_port setup to probe function for consistency.
> 
>   - Remove unused ls_add_pcie_port() platform_device argument.
> 
> Nothing here should change the behavior of the driver.
> 
> Changes from v1:
>   I dropped the following patch because it was a lot of churn for
>   questionable benefit:
>     PCI: layerscape: Name private struct pointer "ls" consistently
> 
> ---
> 
> Bjorn Helgaas (7):
>       PCI: layerscape: Add local struct device pointers
>       PCI: layerscape: Remove unused platform data
>       PCI: layerscape: Remove redundant struct ls_pcie.dbi
>       PCI: layerscape: Pass device-specific struct to internal functions
>       PCI: layerscape: Move struct pcie_port setup to probe function
>       PCI: layerscape: Remove unused ls_add_pcie_port() platform_device arg
>       PCI: layerscape: Reorder struct ls_pcie
> 
> 
>  drivers/pci/host/pci-layerscape.c |   65 +++++++++++++++++++------------------
>  1 file changed, 33 insertions(+), 32 deletions(-)

I applied these to pci/host-layerscape for v4.9.  I hope to ask Linus to
pull them tomorrow, so if you see any issues, let me know soon.
