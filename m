Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727329AbeIRCW4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Sep 2018 22:22:56 -0400
Date: Mon, 17 Sep 2018 15:53:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <keith.busch@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sinan Kaya <okaya@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v2] PCI hotplug Eq v2
Message-ID: <20180917205354.GB54859@bhelgaas-glaptop.roam.corp.google.com>
References: <1535667120-3002-1-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1535667120-3002-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 30, 2018 at 04:11:59PM -0600, Jon Derrick wrote:
> Hi Bjorn,
> 
> Sorry for the delay on this one and pushing it after RC1.
> Feel free to queue it up for 4.20 if it looks fine.
> 
> I've added comments to the git log and source explaining why
> calculate_iosize was left unchanged. Basically I could not
> synthesize a condition where it would have affected the topology.

In other words, the only reason you didn't change the
calculate_iosize() path was because you couldn't test it?

I appreciate your desire to avoid untested changes, but I think it's
very important to preserve and even improve the symmetry between
calculate_memsize() and calculate_iosize().  For example, it's not
obvious why the order is different here:

  calculate_iosize():
    size = ALIGN(size + size1, align);
    if (size < old_size)
      size = old_size;

  calculate_memsize():
    if (size < old_size)
      size = old_size;
    size = ALIGN(size + size1, align);

So I don't want to diverge them further unless there's a real
functional reason why we need to handle I/O port space differently
than MMIO space.

You've tested the MMIO path, and I'm willing to take the risk of
doing the same thing in the I/O port path.

Bjorn
