Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932462AbcKNWIK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Nov 2016 17:08:10 -0500
Date: Mon, 14 Nov 2016 16:08:01 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ray Jui <ray.jui@broadcom.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        Alex Barba <alex.barba@broadcom.com>,
        Oza Oza <oza.oza@broadcom.com>
Subject: Re: [PATCH v2 00/12] Additional iProc PCIe host support/fixes
Message-ID: <20161114220801.GG9868@bhelgaas-glaptop.roam.corp.google.com>
References: <1477960721-17649-1-git-send-email-ray.jui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1477960721-17649-1-git-send-email-ray.jui@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 31, 2016 at 05:38:29PM -0700, Ray Jui wrote:
> This patch series contains various changes and fixes to the iProc PCIe
> host driver. It also adds support for the next generation of PAXB and
> PAXC based host controllers
> 
> This patch series was developed based on v4.9-rc1 and tested on both NS2
> SVK and Cygnus wireless audio platform
> 
> repo: https://github.com/Broadcom/arm64-linux.git
> branch: iproc-pcie-v2
> 
> Changes from v1:
>  - Fixed varioues typos in the commit message
>  - Improved various DT binding patch titles with more specific information
> 
> Ray Jui (12):
>   PCI: iproc: Improve core register population
>   PCI: iproc: Do not reset PAXC when initializing the driver
>   PCI: iproc: Add BCMA type
>   PCI: iproc: Fix exception with multi-function devices
>   PCI: iproc: Added PAXCv2 related binding
>   PCI: iproc: Add PAXC v2 support
>   PCI: iproc: Remove redundant outbound properties
>   PCI: iproc: Making outbound mapping code more generic
>   PCI: iproc: Add optional dma-ranges
>   PCI: iproc: Add inbound DMA mapping support
>   PCI: iproc: Add PAXBv2 binding info
>   PCI: iproc: Add support for the next-gen PAXB controller
> 
>  .../devicetree/bindings/pci/brcm,iproc-pcie.txt    |  43 +-
>  drivers/pci/host/pcie-iproc-bcma.c                 |   1 +
>  drivers/pci/host/pcie-iproc-msi.c                  |   1 +
>  drivers/pci/host/pcie-iproc-platform.c             |  19 +-
>  drivers/pci/host/pcie-iproc.c                      | 942 ++++++++++++++++++---
>  drivers/pci/host/pcie-iproc.h                      |  45 +-
>  6 files changed, 916 insertions(+), 135 deletions(-)

Applied to pci/host-iproc for v4.10, thanks!
