Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:59674 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753646Ab3DHGoa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 8 Apr 2013 02:44:30 -0400
Message-ID: <1365403141.31207.16.camel@pasglop>
Subject: Re: [PATCH 3/3] powerpc: Set default VGA device
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Brian King <brking@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>,
	klebers <klebers@linux.vnet.ibm.com>, sparclinux@vger.kernel.org
Date: Mon, 08 Apr 2013 08:39:01 +0200
In-Reply-To: <20130408052124.GA9550@concordia>
References: <201304042158.r34LwGPg010714@d03av02.boulder.ibm.com>
	 <CAErSpo4LsJjRkw6UektwqW8m1NXdU6BTjhTDA9eORM3z3qDcdA@mail.gmail.com>
	 <20130408052124.GA9550@concordia>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2013-04-08 at 15:21 +1000, Michael Ellerman wrote:

> Looking at x86, ia64 and ours, there's a fair bit of difference.
> 
> x86/ia64 both walk up the parents checking PCI_BRIDGE_CTL_VGA, which
> powerpc doesn't (though maybe it should?).

Unclear for several reasons.

That bit indicates that the bridge forwards the hard coded legacy VGA IO
ports and memory aperture. These are not necessary to get modern video
cards going. Only if legacy modes are used.

On x86, that tends to be the case (is it always even with EFI
nowadays ?).

On other architectures that is not necessarily the case. The firmware
can (and will) initialize the card using MMIO entirely and even if
possible disabling the legacy stuff, which means that turning those bits
on in the bridge is also unnecessary.

In fact, on such setups, the isn't really a concept of a "primary" video
card to begin with.

On the other hand, that also means that a video card initialized like
that is pretty much out of the grasp of the vga arbiter which has no
effect on it either.

Also be careful that while it may be relevant on x86, the VGA fwd bit is
not on the PCIe root complex on IBM machines.

Finally, P8 has no IO space at all...

> x86/ia64 set IORESOURCE_ROM_SHADOW, which powerpc doesn't.
> 
> ia64 doesn't call vga_set_default_device(), x86 and powerpc do.
> 
> So we'll merge this and maybe someone can tease out the common bits, but
> personally I don't see that there's an obvious chunk of generic logic.

Cheers,
Ben.


