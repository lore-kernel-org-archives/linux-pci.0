Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757773AbcJXWwq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Oct 2016 18:52:46 -0400
Date: Mon, 24 Oct 2016 17:52:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ray Jui <ray.jui@broadcom.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        Alex Barba <alex.barba@broadcom.com>,
        Oza Oza <oza.oza@broadcom.com>, Ray Jui <rjui@broadcom.com>
Subject: Re: [PATCH 00/12] Additional iProc PCIe host support/fixes
Message-ID: <20161024225238.GA27451@localhost>
References: <1477347432-17656-1-git-send-email-ray.jui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1477347432-17656-1-git-send-email-ray.jui@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Ray,

On Mon, Oct 24, 2016 at 03:17:00PM -0700, Ray Jui wrote:
> This patch series contains various changes and fixes to the iProc PCIe
> host driver. It also adds support for the next generation of PAXB and
> PAXC based host controllers
> 
> This patch series was developed based on v4.9-rc1 and tested on both NS2
> SVK and Cygnus wireless audio platform
> 
> repo: https://github.com/Broadcom/arm64-linux.git
> branch: iproc-pcie-v1
> 
> Ray Jui (12):
>   PCI: iproc: Improve core register population
>   PCI: iproc: Do not reset PAXC when initializing the driver
>   PCI: iproc: Add BCMA type
>   PCI: iproc: Fix exception with multi-function devices
>   PCI: iproc: Update iProc PCIe DT binding
>   PCI: iproc: Add PAXC v2 support
>   PCI: iproc: Update iProc PCIe DT binding
>   PCI: iproc: Making outbound mapping code more generic
>   PCI: iproc: Update iProc PCIe DT binding
>   PCI: iproc: Add inbound DMA mapping support
>   PCI: iproc: Update iProc PCIe DT binding
>   PCI: iproc: Add support for the next-gen PAXB controller

I'll look at these more soon, but there are four patches above with
identical titles ("PCI: iproc: Update iProc PCIe DT binding").  The
"iProc PCIe" part is a little redundant; can you remove that and
instead include a hint about what each patch is about, e.g.,
"add optional dma-ranges", "remove outbound window properties", etc?

>  .../devicetree/bindings/pci/brcm,iproc-pcie.txt    |  43 +-
>  drivers/pci/host/pcie-iproc-bcma.c                 |   1 +
>  drivers/pci/host/pcie-iproc-msi.c                  |   1 +
>  drivers/pci/host/pcie-iproc-platform.c             |  19 +-
>  drivers/pci/host/pcie-iproc.c                      | 942 ++++++++++++++++++---
>  drivers/pci/host/pcie-iproc.h                      |  45 +-
>  6 files changed, 916 insertions(+), 135 deletions(-)
> 
> -- 
> 2.1.4
> 
