Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38558 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750736AbcBEB5k (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Feb 2016 20:57:40 -0500
Date: Thu, 4 Feb 2016 19:57:34 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH] x86, pci: Add quirk for unsizeable Broadwell EP bar
Message-ID: <20160205015734.GA29929@localhost>
References: <1452896279-22034-1-git-send-email-andi@firstfloor.org>
 <20160204174155.GB19957@localhost>
 <20160204185442.GA4875@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160204185442.GA4875@tassilo.jf.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 04, 2016 at 10:54:42AM -0800, Andi Kleen wrote:
> > It sounds like these devices have some device-specific register where
> > BAR 0 is supposed to be?  Setting IORESOURCE_PCI_FIXED doesn't seem
> > like the right solution to me.  Even if we set that, the core still
> 
> There is no actually functional register on these locations that has any side
> effects.
> 
> > believes this resource corresponds to some address space consumed by
> > the device.  I think we will still try to size the BAR and decode its
> > type.  I think it will still show up via lspci.  That's all
> > meaningless.
> 
> But would actually anything use it?

You mean, would anything actually use the lspci output?  I don't know,
but why would we want it to print garbage?

And the kernel certainly uses the struct resource.  Setting
IORESOURCE_PCI_FIXED is not a way of saying "please ignore this
resource."

Bjorn
