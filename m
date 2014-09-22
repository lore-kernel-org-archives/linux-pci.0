Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:42695 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754847AbaIVUtx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Sep 2014 16:49:53 -0400
Received: by mail-ie0-f174.google.com with SMTP id rd18so2972971iec.19
        for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2014 13:49:53 -0700 (PDT)
Date: Mon, 22 Sep 2014 14:49:48 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] PCI: Remove dead code after DMA alias work
Message-ID: <20140922204948.GH1880@google.com>
References: <20140917163930.21584.69496.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140917163930.21584.69496.stgit@gimli.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 17, 2014 at 10:41:01AM -0600, Alex Williamson wrote:
> v1: inopportune DNS failure blocked patches, resending
> 
> Now that IOMMU drivers have completed the DMA alias transition,
> remove the left behind dead code.  Thanks,
> 
> Alex
> 
> ---
> 
> Alex Williamson (2):
>       PCI: Remove pci_get_dma_source()
>       PCI: Remove pci_find_upstream_pcie_bridge()

Applied to pci/virtualization for v3.18, thanks!

>  drivers/pci/quirks.c |   51 --------------------------------------------------
>  drivers/pci/search.c |   34 ---------------------------------
>  include/linux/pci.h  |   16 ----------------
>  3 files changed, 101 deletions(-)
