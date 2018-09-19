Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:17439 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728339AbeISXC2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Sep 2018 19:02:28 -0400
Date: Wed, 19 Sep 2018 11:25:27 -0600
From: Keith Busch <keith.busch@intel.com>
To: Sinan Kaya <okaya@kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 11/12] PCI/AER: Use managed resource allocations
Message-ID: <20180919172526.GB28310@localhost.localdomain>
References: <20180918235848.26694-1-keith.busch@intel.com>
 <20180918235848.26694-12-keith.busch@intel.com>
 <5b3f6bf5-2511-6a71-3410-a4f4ced4fb8c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5b3f6bf5-2511-6a71-3410-a4f4ced4fb8c@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 19, 2018 at 12:29:15PM -0400, Sinan Kaya wrote:
> On 9/18/2018 7:58 PM, Keith Busch wrote:
> >   	if (status) {
> >   		dev_printk(KERN_DEBUG, device, "request AER IRQ %d failed\n",
> >   			   dev->irq);
> > -		aer_remove(dev);
> >   		return status;
> >   	}
> 
> Don't we still need to call aer_remove() here?
> 
> Old code would call aer_disable_rootport(rpc) via aer_remove() on IRQ allocation
> failure. We are no longer doing this.

We need to call aer_disable_rootport only if aer_enable_rootport was
called, but that happens *after* irq allocation.
