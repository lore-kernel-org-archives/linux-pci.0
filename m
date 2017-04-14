Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:42806 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751993AbdDNRxW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2017 13:53:22 -0400
Date: Fri, 14 Apr 2017 19:53:19 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Christoph Hellwig <hch@lst.de>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] genirq: return the irq name from free_irq
In-Reply-To: <20170414173649.GA26228@lst.de>
Message-ID: <alpine.DEB.2.20.1704141951590.2327@nanos>
References: <20170413070643.32165-1-hch@lst.de> <20170413070643.32165-3-hch@lst.de> <alpine.DEB.2.20.1704141920560.2327@nanos> <20170414173649.GA26228@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 14 Apr 2017, Christoph Hellwig wrote:

> On Fri, Apr 14, 2017 at 07:28:42PM +0200, Thomas Gleixner wrote:
> > On Thu, 13 Apr 2017, Christoph Hellwig wrote:
> > 
> > > This allows callers to get back at them instead of having to store
> > > it in another variable.
> > 
> > Alternatively you tell the irq code to free it for you. Patch below.
> 
> Yes, this should work to.  But I think having the same layer free
> something they allocated again is a tad cleaner in terms of layering.

Fair enough. Was just a thought.

Bjorn, please route it through PCI alltogether.

For the whole series:

    Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Thanks,

	tglx
