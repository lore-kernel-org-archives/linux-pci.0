Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:45368 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751958AbeF1LUi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Jun 2018 07:20:38 -0400
Date: Thu, 28 Jun 2018 12:22:17 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "Busch, Keith" <keith.busch@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Bauer, Scott" <scott.bauer@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH] PCI/VMD: White list for fast interrupt handlers
Message-ID: <20180628112208.GA8914@red-moon>
References: <20180508160022.30954-1-keith.busch@intel.com>
 <20180509043828.GA9413@infradead.org>
 <20180509152652.GA823@localhost.localdomain>
 <1526053159.7581.15.camel@intel.com>
 <1527275472.24363.8.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1527275472.24363.8.camel@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 25, 2018 at 07:11:14PM +0000, Derrick, Jonathan wrote:
> +Lorenzo
> 
> On Fri, 2018-05-11 at 09:39 -0600, Jonathan Derrick wrote:
> > On Wed, 2018-05-09 at 09:26 -0600, Keith Busch wrote:
> > > On Tue, May 08, 2018 at 09:38:28PM -0700, Christoph Hellwig wrote:
> > > > On Tue, May 08, 2018 at 10:00:22AM -0600, Keith Busch wrote:
> > > > > Devices with slow interrupt handlers are significantly harming
> > > > > performance
> > > > > when their interrupt vector is shared with a fast device. This
> > > > > patch
> > > > > creates a class code white list for devices with known fast
> > > > > interrupt
> > > > > handlers, and all other devices will share a single vector so
> > > > > they don't
> > > > > interfere with performance.
> > > > > 
> > > > > At the moment, only the NVM Express class code is on the list,
> > > > > but more
> > > > > may be added if VMD users desire to use other low-latency
> > > > > devices
> > > > > in
> > > > > these domains.
> > > > 
> > > > I think this is far too much of a hack.   Just don't use VMD if
> > > > your
> > > > care about performance.
> > > 
> > > I'm not aware of an easier way you can direct-assign an entire PCIe
> > > domain
> > > to a virtual machine. :)
> > 
> > It's fine with me
> > 
> > Acked-by: Jon Derrick: <jonathan.derrick@intel.com>
> 
> 
> We've seen this actually fix an issue with one vendor's multi-function
> switch.
> I'd like to see it get into 4.18 if possible

Sorry for the delay in getting back to this.

It seems like Christoph is not too happy about this patch, it is your
code so I would apply it unless there is a cleaner alternative so please
do let me know.

Thanks,
Lorenzo
