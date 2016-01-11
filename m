Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:52686 "EHLO
	nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759332AbcAKTTr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jan 2016 14:19:47 -0500
Date: Mon, 11 Jan 2016 20:19:44 +0100
From: Martin Mares <mj@ucw.cz>
To: Keith Busch <keith.busch@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org, Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCHv5 7/7] pciutils: Allow 32-bit domains
Message-ID: <mj+md-20160111.191047.47129.nikam@ucw.cz>
References: <1449523949-21898-1-git-send-email-keith.busch@intel.com>
 <1449523949-21898-8-git-send-email-keith.busch@intel.com>
 <mj+md-20160103.140612.56316.camelot@ucw.cz>
 <20160104222949.GA32608@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160104222949.GA32608@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi!

> On Sun, Jan 03, 2016 at 03:11:24PM +0100, Martin Mares wrote:
> > This is definitely not enough. Try grepping the source for "domain" :-)
> >
> > At least the following places need updating, too:
> > 
> >   o  struct pci_filter and operations on it
> 
> Not sure I follow. struct pci_filter's domain was already a 32-bit int.

Yes, but it has to encode a "don't care" value, too.

However, if 17 bits are sufficient, then let us define that the domain
number is currently 31-bit and keep -1 as "don't care".

In any case, it would be nice to make the sysfs back-end check
that the number provided by the kernel fits in 31 bits.

> >   o  Format strings for printing domains at various places
> 
> Are you wanting a %04x for 16 bit domains and %08x for 32 bit ones? The
> %04x specifier still works with 32-bit values.

After some more thought, keeping %04x will be better.

> >   o  ABI compability ... changing a field in the middle of struct pci_dev
> >      (or pci_filter) is going to break ABI, so you either need to change the
> >      structures in a backward-compatible way, or to use ABI versioning.
> 
> It looks like there's a 16-bit gap after device_class. Would it be
> acceptable place the domain's upper 16 bits in there to keep ABI
> compatibility?

This would mean that all new programs supporting 32-bit domains
would have to combine both fields to get the full domain number.

I think we can just rename the 16-bit field to domain_16 (where only the
lower 16 bits will be stored) and add a new 32-bit domain field at the end of
the public part of the structure. Since the structures are always allocated by
libpci, that will work. Old programs will fail silently on machines with
large domain numbers, but that is hopefully acceptable.

Also, we should add a new version of some basic function call,
for example pci_init, so that new programs will require a new version
of the ABI.

				Martin
