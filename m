Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753068AbcJLQG0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 12:06:26 -0400
Date: Wed, 12 Oct 2016 11:06:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Murali Karicheri <m-karicheri2@ti.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/6] PCI: keystone: Cleanups
Message-ID: <20161012160622.GQ4308@localhost>
References: <20161012134953.29306.24609.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161012134953.29306.24609.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 12, 2016 at 08:53:00AM -0500, Bjorn Helgaas wrote:
>   - Add local "dev" pointers to reduce repetition of things like
>     "&pdev->dev".
> 
>   - Use generic DesignWare accessors when possible.
> 
>   - Pass device-specific struct instead of register addresses to IRQ and
>     DBI functions.
> 
>   - Add app register accessors to encapsulate usage of va_app_base.
> 
> Nothing here should change the behavior of the driver.
> 
> Changes from v1:
>   Added local struct device pointers.
>   I dropped the following patch because it was a lot of churn for
>   questionable benefit:
>     PCI: keystone: Name private struct pointer "keystone" consistently
> 
> ---
> 
> Bjorn Helgaas (6):
>       PCI: keystone: Add local struct device pointers
>       PCI: keystone: Use generic DesignWare accessors
>       PCI: keystone: Pass keystone_pcie, not address, to IRQ functions
>       PCI: keystone: Pass keystone_pcie, not va_app_base, to DBI functions
>       PCI: keystone: Add app register accessors
>       PCI: keystone: Reorder struct keystone_pcie
> 
> 
>  drivers/pci/host/pci-keystone-dw.c |  123 ++++++++++++++++++++----------------
>  drivers/pci/host/pci-keystone.c    |   28 ++++----
>  drivers/pci/host/pci-keystone.h    |    9 +--
>  3 files changed, 88 insertions(+), 72 deletions(-)

I applied these to pci/host-keystone for v4.9.  I hope to ask Linus to
pull them tomorrow, so if you see any issues, let me know soon.
