Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:55965 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbeG3NaI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Jul 2018 09:30:08 -0400
Date: Mon, 30 Jul 2018 13:55:24 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Christoph Hellwig <hch@lst.de>
cc: linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: call dma_debug_add_bus for pci_bus_type in common
 code
In-Reply-To: <20180730073842.16092-1-hch@lst.de>
Message-ID: <alpine.DEB.2.21.1807301355030.2518@nanos.tec.linutronix.de>
References: <20180730073842.16092-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 30 Jul 2018, Christoph Hellwig wrote:

> There is nothing arch specific about PCI or dma-debug, so move this
> call to common code just after registering the bus type.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Thomas Gleixner <tglx@linutronix.de>
