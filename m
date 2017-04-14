Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:43871 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751554AbdDNRgv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Apr 2017 13:36:51 -0400
Date: Fri, 14 Apr 2017 19:36:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] genirq: return the irq name from free_irq
Message-ID: <20170414173649.GA26228@lst.de>
References: <20170413070643.32165-1-hch@lst.de> <20170413070643.32165-3-hch@lst.de> <alpine.DEB.2.20.1704141920560.2327@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.20.1704141920560.2327@nanos>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 14, 2017 at 07:28:42PM +0200, Thomas Gleixner wrote:
> On Thu, 13 Apr 2017, Christoph Hellwig wrote:
> 
> > This allows callers to get back at them instead of having to store
> > it in another variable.
> 
> Alternatively you tell the irq code to free it for you. Patch below.

Yes, this should work to.  But I think having the same layer free
something they allocated again is a tad cleaner in terms of layering.

If you prefer this version I can respin the series.
