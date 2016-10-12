Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755725AbcJLQE2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 12:04:28 -0400
Date: Wed, 12 Oct 2016 11:04:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/6] PCI: armada: Cleanups
Message-ID: <20161012160424.GK4308@localhost>
References: <20161012131957.26736.14194.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161012131957.26736.14194.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 12, 2016 at 08:25:11AM -0500, Bjorn Helgaas wrote:
>   - Remove platform drvdata because it appears unused (we called
>     platform_set_drvdata() but not platform_get_drvdata()).
> 
>   - Remove redundant struct members.
> 
>   - Use generic DesignWare accessors when possible.
> 
>   - Pass device-specific struct to internal functions for consistency.
> 
> Nothing here should change the behavior of the driver.
> 
> Changes from v1:
>   I dropped the following patches because they were a lot of churn for
>   questionable benefit:
>     PCI: armada: Name private struct pointer "armada8k" consistently
>     PCI: armada: Add register accessors
> 
> ---
> 
> Bjorn Helgaas (6):
>       PCI: armada: Remove unused platform data
>       PCI: armada: Add local base pointer
>       PCI: armada: Remove redundant struct armada8k_pcie.base
>       PCI: armada: Use generic DesignWare accessors
>       PCI: armada: Pass device-specific struct to internal functions
>       PCI: armada: Reorder struct armada8k_pcie
> 
> 
>  drivers/pci/host/pcie-armada8k.c |   78 ++++++++++++++++++--------------------

I applied these to pci/host-armada for v4.9.  I hope to ask Linus to
pull them tomorrow, so if you see any issues, let me know soon.
