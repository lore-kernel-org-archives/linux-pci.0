Return-Path: <keith.busch@intel.com>
Return-Path: <keith.busch@intel.com>
Date: Mon, 15 Aug 2016 15:23:16 -0400
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] pci: Add ignore indicator quirk for devices
Message-ID: <20160815192316.GB18083@localhost.localdomain>
References: <1470687542-30155-1-git-send-email-keith.busch@intel.com>
 <1470687542-30155-2-git-send-email-keith.busch@intel.com>
 <20160815174002.GB9790@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160815174002.GB9790@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 15, 2016 at 12:40:02PM -0500, Bjorn Helgaas wrote:
> On Mon, Aug 08, 2016 at 02:19:02PM -0600, Keith Busch wrote:
> > +/*
> > + * The PCIe slot capabilities for Intel compatible Hot-swap backplane advertise
> > + * attention and power indicators, but will do the wrong thing if used in a
> > + * standard way. Ignore these.
> > + */
> 
> Hmm.  So I guess you're saying these devices are defective?  Is there
> an erratum we can reference?
> 
> What exactly does "do the wrong thing" mean?  These are indicators, so
> the only thing we really do is turn them on and off.  I think we do
> that with pcie_write_cmd_nowait(), and all the synchronization there
> is a little messy.  Maybe we got that wrong somehow?
> 
> It's hard to believe something as simple as controlling an LED is
> broken.  If it *is* broken, I would think the breakage would be
> platform-dependent, not just device-dependent, i.e., I would suspect
> something wrong with motherboard wiring or firmware.

This is actually a "feature". The devices listed in the patch re-purpose
the spec defined capability and control bits for Attention and Power
indicators. The control values match IBPI (International Blinking Pattern
Interpretation) rather than the spec definition.

Since these operate in a non-standard way, we'd just as soon not let
the kernel know about them (an incorrect LED pattern will definitely
occur). The LEDs are to be set from user space by 'ledmon' instead.

Had I my way, the hardware wouldn't advertise the capability in the
first place. I rarely get my way, so I instead get to publicly defend
the quirk. :)
