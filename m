Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47689 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932722AbbJHNrH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 8 Oct 2015 09:47:07 -0400
Date: Thu, 8 Oct 2015 08:47:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org, Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCHv2] x86/pci: Initial commit for new VMD device driver
Message-ID: <20151008134702.GK27633@localhost>
References: <1443721454-25467-1-git-send-email-keith.busch@intel.com>
 <20151006231412.GF29420@localhost>
 <alpine.LNX.2.00.1510062331220.23840@localhost.lm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.2.00.1510062331220.23840@localhost.lm.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 07, 2015 at 12:21:02AM +0000, Keith Busch wrote:
> Hi Bjorn,
> 
> Thanks for the feedback. Much of the issues you mentioned look pretty
> straight forward to resolve, and will fix of for the next revision.
> 
> I have some immediate follow up comments to two issues you brought up:
> 
> On Tue, 6 Oct 2015, Bjorn Helgaas wrote:
> >>+static int vmd_find_free_domain(void)
> >>+{
> >>+	int domain = -1;
> >>+	struct pci_bus *bus = NULL;
> >>+
> >>+	while ((bus = pci_find_next_bus(bus)) != NULL)
> >>+		domain = max_t(int, domain, pci_domain_nr(bus));
> >>+	if (domain < 0)
> >>+		return -ENODEV;
> >>+	return domain + 1;
> >>+}
> >
> >The PCI core should own domain number allocation.  We have a little
> >bit of generic domain support, e.g., pci_get_new_domain_nr().  On x86,
> >I think that is compiled-in, but currently not used -- currently x86
> >only uses _SEG from ACPI.  How would you handle collisions between a
> >domain number assigned here (or via pci_get_new_domain_nr()) and a
> >hot-added host bridge where _SEG uses the same domain?
> 
> Thank you for bringing this up as I hadn't thought much about it and may
> have misunderstood the meaning of _SEG. AIUI, it is used to identify a
> logical grouping. The OS does not need to use the same identifier for
> the domain, so we there's no need to collide if we can assign the domain
> of a a new _SEG to the next available domain_nr.

Yes, I guess it would be possible to decouple _SEG and Linux PCI
domain numbers.  It's *convenient* to have them the same, so dmesg and
lspci output matches _SEG directly, but I guess you could argue that's
not essential.

I think we'd have to maintain a mapping from domain back to _SEG to
deal with firmware interfaces that expect _SEG, e.g., ia64 PAL calls.

> On pci_get_new_domain_nr(), can we make this use something like an
> ida instead of an atomic? I think we'd like to put domains back into
> the available pool if someone unbinds it. I imagine someone will test
> unbinding/rebinding these devices in a loop for a while, and will file
> a bug after the atomic increments to 64k. :)

I assume you're talking about the "ID to pointer translation service"
in lib/idr.c.  That looks like it would make sense to me.

If we add such a mapping, it would be nice if we could attempt to
allocate a domain equal to _SEG, and only fall back to a different
domain if that fails.  Then the mapping would be invisible in the
common case of all host bridges being present at boot.

Bjorn
