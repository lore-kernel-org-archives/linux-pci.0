Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:32610 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751938AbcADW3v (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 4 Jan 2016 17:29:51 -0500
Date: Mon, 4 Jan 2016 22:29:49 +0000
From: Keith Busch <keith.busch@intel.com>
To: Martin Mares <mj@ucw.cz>
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
Message-ID: <20160104222949.GA32608@localhost.localdomain>
References: <1449523949-21898-1-git-send-email-keith.busch@intel.com>
 <1449523949-21898-8-git-send-email-keith.busch@intel.com>
 <mj+md-20160103.140612.56316.camelot@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <mj+md-20160103.140612.56316.camelot@ucw.cz>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi, thanks for the feedback. I've a few follow up questions.

On Sun, Jan 03, 2016 at 03:11:24PM +0100, Martin Mares wrote:
> This is definitely not enough. Try grepping the source for "domain" :-)
>
> At least the following places need updating, too:
> 
>   o  struct pci_filter and operations on it

Not sure I follow. struct pci_filter's domain was already a 32-bit int.
 
>   o  Format strings for printing domains at various places

Are you wanting a %04x for 16 bit domains and %08x for 32 bit ones? The
%04x specifier still works with 32-bit values.

We just need a bit so this new h/w can't collide with ACPI _SEG defined
domains. I don't know of any real need for the full 32-bits; we'd do
fine using only 17 bits, so thought the leading 0's wasn't useful.

>   o  ABI compability ... changing a field in the middle of struct pci_dev
>      (or pci_filter) is going to break ABI, so you either need to change the
>      structures in a backward-compatible way, or to use ABI versioning.

It looks like there's a 16-bit gap after device_class. Would it be
acceptable place the domain's upper 16 bits in there to keep ABI
compatibility?

> Also, we should decide on what type the domain should have -- currently, some
> places use "int", others use u16, and your patch introduces int32_t. I would
> prefer u32 myself, but especially in the filters we should be careful about
> how to encode "any domain".

I left it as a signed int to allow a negative number for "any", and that's
also what the linux kernel uses.
