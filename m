Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50136 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754385AbeF1QcS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Jun 2018 12:32:18 -0400
Date: Thu, 28 Jun 2018 17:32:11 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Keith Busch <keith.busch@intel.com>
Cc: "Derrick, Jonathan" <jonathan.derrick@intel.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Bauer, Scott" <scott.bauer@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH] PCI/VMD: White list for fast interrupt handlers
Message-ID: <20180628163211.GA19843@e107981-ln.cambridge.arm.com>
References: <20180508160022.30954-1-keith.busch@intel.com>
 <20180509043828.GA9413@infradead.org>
 <20180509152652.GA823@localhost.localdomain>
 <1526053159.7581.15.camel@intel.com>
 <1527275472.24363.8.camel@intel.com>
 <20180628112208.GA8914@red-moon>
 <20180628140240.GA12793@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180628140240.GA12793@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 28, 2018 at 08:02:40AM -0600, Keith Busch wrote:
> On Thu, Jun 28, 2018 at 12:22:17PM +0100, Lorenzo Pieralisi wrote:
> > On Fri, May 25, 2018 at 07:11:14PM +0000, Derrick, Jonathan wrote:
> > > We've seen this actually fix an issue with one vendor's multi-function
> > > switch. I'd like to see it get into 4.18 if possible
> > 
> > Sorry for the delay in getting back to this.
> > 
> > It seems like Christoph is not too happy about this patch, it is your
> > code so I would apply it unless there is a cleaner alternative so please
> > do let me know.
> 
> VMD hardware really relies on the host software to bring all the logic,
> and it was intended to prioritize PCIe attached storage. The patch just
> captures that intention, so yes please, let's queue this up.
> 
> I understands Christoph's lack of enthusiasm for this, but at least this
> isn't a PCIe HBA with proprietary interfaces and firmware. :)

Applied to pci/vmd with a slightly updated changelog, thanks.

Lorenzo
