Return-Path: <keith.busch@intel.com>
Return-Path: <keith.busch@intel.com>
Date: Tue, 23 Aug 2016 18:10:43 -0400
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, g@localhost.localdomain
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH v2] vmd: Fix infinite loop executing irq's
Message-ID: <20160823221042.GA11049@localhost.localdomain>
References: <1470671271-22465-1-git-send-email-keith.busch@intel.com>
 <20160823213605.GC5838@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160823213605.GC5838@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 23, 2016 at 04:36:05PM -0500, Bjorn Helgaas wrote:
> On Mon, Aug 08, 2016 at 09:47:51AM -0600, Keith Busch wrote:
> > We can't initialize the list head on deletion as this causes the node
> > to point to itself, looping infinitely if the vmd IRQ handler happened
> > to be servicing that node.
> > 
> > The list initialization was trying fix a bug from multiple calls to
> > disable the same IRQ. We can fix this instead by having the vmd driver
> > track if the interrupt is enabled.
> > 
> > Signed-off-by: Keith Busch <keith.busch@intel.com>
> > Cc: Jon Derrick <jonathan.derrick@intel.com>
> > Reported-by: Grzegorz Koczot <grzegorz.koczot@intel.com>
> > Tested-by: Miroslaw Drost <miroslaw.drost@intel.com>
> 
> I assume you want
> 
>   Fixes: 97e923063575 ("x86/PCI: VMD: Initialize list item in IRQ disable")
> 
> and you want this in for-linus so it goes in v4.8 instead of v4.9.
> 
> I did that for you, so let me know if it's not right.

Yes, that was our intention. Thank you for setting the "Fixes" and
staging for 4.8.
