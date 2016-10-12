Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:32940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753126AbcJLQHV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 12:07:21 -0400
Date: Wed, 12 Oct 2016 11:07:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Pratyush Anand <pratyush.anand@gmail.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/4] PCI: spear: Cleanups
Message-ID: <20161012160711.GT4308@localhost>
References: <20161012140058.30368.94283.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161012140058.30368.94283.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 12, 2016 at 09:04:20AM -0500, Bjorn Helgaas wrote:
>   - Remove unused constants.  There's some documentation value in these,
>     but they're only marginally useful to people without the spec, and
>     I think it's preferable to rely on the spec directly to avoid
>     transcription errors.
> 
>   - Pass device-specific struct to internal functions for consistency.
> 
>   - Tidy up usage of local struct device pointers.
> 
> Nothing here should change the behavior of the driver.
> 
> Changes from v1:
>   I dropped the following patch because it was lot of churn for
>   questionable benefit:
>     PCI: spear: Name private struct pointer "spear13xx" consistently
> 
> ---
> 
> Bjorn Helgaas (4):
>       PCI: spear: Remove unused constants
>       PCI: spear: Pass device-specific struct to internal functions
>       PCI: spear: Reorder struct spear13xx_pcie
>       PCI: spear: Clean up struct device usage
> 
> 
>  drivers/pci/host/pcie-spear13xx.c |  108 +++++++------------------------------
>  1 file changed, 20 insertions(+), 88 deletions(-)

I applied these to pci/host-spear for v4.9.  I hope to ask Linus to
pull them tomorrow, so if you see any issues, let me know soon.
