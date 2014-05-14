Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 8bytes.org ([85.214.48.195]:45483 "EHLO mail.8bytes.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753435AbaENKXO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 14 May 2014 06:23:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.8bytes.org (Postfix) with SMTP id BAE1712B1F9
	for <linux-pci@vger.kernel.org>; Wed, 14 May 2014 12:23:12 +0200 (CEST)
Date: Wed, 14 May 2014 12:23:07 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	linux-kernel@vger.kernel.org,
	James Bottomley <jbottomley@parallels.com>,
	linux-pci@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v3 0/4] Clean up DMA API docs and dma_addr_t usage
Message-ID: <20140514102307.GD6026@8bytes.org>
References: <20140508204257.17877.4639.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140508204257.17877.4639.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 08, 2014 at 02:48:47PM -0600, Bjorn Helgaas wrote:
> Maybe the third time's a charm :)
> 
> This cleans up some DMA-API documentation and makes a minor no-op change to
> the dma_declare_coherent_memory() prototype.
> 
> Changes from v2:
>   - Added description of CPU virtual/physical and bus addresses in
>     DMA-API-HOWTO
>   - Added comments to sh/PCI (Dreamcast) update
>   - Dropped IOMMU interface dma_addr_t changes
> 
> I didn't add Arnd's and Greg's acks to patch 1 because of all the new
> address description text I added.
> 
> ---
> 
> Bjorn Helgaas (4):
>       DMA-API: Clarify physical/bus address distinction
>       DMA-API: Change dma_declare_coherent_memory() CPU address to phys_addr_t
>       sh/PCI: Pass GAPSPCI_DMA_BASE CPU & bus address to dma_declare_coherent_memory()
>       iommu/exynos: Remove unnecessary "&" from function pointers

Applied patches 1-3 to my core branch and patch 4 to the arm/exynos
branch. Patch 3 doesn't really belong into my tree, please let me know
if there are any objections against it being there and I'll drop it.


	Joerg


