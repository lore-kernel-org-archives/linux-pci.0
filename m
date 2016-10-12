Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754567AbcJLQDF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 12:03:05 -0400
Date: Wed, 12 Oct 2016 11:03:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Duc Dang <dhdang@apm.com>, Tanmay Inamdar <tinamdar@apm.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/4] PCI: xgene: Cleanups
Message-ID: <20161012160300.GH4308@localhost>
References: <20161012130508.25368.95560.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161012130508.25368.95560.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 12, 2016 at 08:07:35AM -0500, Bjorn Helgaas wrote:
>   - Add local "dev" pointers to reduce repetition of things like
>     "&pdev->dev".
> 
>   - Remove platform drvdata because it appears unused (we called
>     platform_set_drvdata() but not platform_get_drvdata()).
> 
>   - Pass the struct xgene_pcie_port pointer, not addresses, to setup
>     functions to enable simplifications.
> 
>   - Add register accessors to encapsulate usage of port->csr_base a bit.
> 
> Nothing here should change the behavior of the driver.
> 
> Changes from v1:
>   I dropped the following patch because it was a lot of churn for
>   questionable benefit:
>     PCI: xgene: Name private struct pointer "xgene" consistently
> 
> ---
> 
> Bjorn Helgaas (4):
>       PCI: xgene: Add local struct device pointers
>       PCI: xgene: Remove unused platform data
>       PCI: xgene: Pass struct xgene_pcie_port to setup functions
>       PCI: xgene: Add register accessors

I applied these to pci/host-xgene for v4.9.  I hope to ask Linus to
pull them tomorrow, so if you see any issues, let me know soon.
