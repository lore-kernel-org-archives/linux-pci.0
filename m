Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:35487 "EHLO theia.8bytes.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751573AbbJFKWT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 6 Oct 2015 06:22:19 -0400
Date: Tue, 6 Oct 2015 12:22:16 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc: iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Sebastian Ott <sebott@linux.vnet.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] iommu/s390: add iommu api for s390 pci devices
Message-ID: <20151006102216.GB20886@8bytes.org>
References: <1440682383-27688-1-git-send-email-gerald.schaefer@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1440682383-27688-1-git-send-email-gerald.schaefer@de.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 27, 2015 at 03:33:03PM +0200, Gerald Schaefer wrote:
> This adds an IOMMU API implementation for s390 PCI devices.
> 
> Reviewed-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
> Signed-off-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
> ---
>  MAINTAINERS                     |   7 +
>  arch/s390/Kconfig               |   1 +
>  arch/s390/include/asm/pci.h     |   4 +
>  arch/s390/include/asm/pci_dma.h |   5 +-
>  arch/s390/pci/pci_dma.c         |  37 +++--
>  drivers/iommu/Kconfig           |   7 +
>  drivers/iommu/Makefile          |   1 +
>  drivers/iommu/s390-iommu.c      | 337 ++++++++++++++++++++++++++++++++++++++++
>  8 files changed, 386 insertions(+), 13 deletions(-)
>  create mode 100644 drivers/iommu/s390-iommu.c

Applied, thanks.
