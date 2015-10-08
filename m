Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:30354 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755491AbbJHVdM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 8 Oct 2015 17:33:12 -0400
Date: Thu, 8 Oct 2015 21:33:10 +0000 (UTC)
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org
Subject: Re: [RFC PATCHv2] x86/pci: Initial commit for new VMD device
 driver
In-Reply-To: <20151008134702.GK27633@localhost>
Message-ID: <alpine.LNX.2.00.1510082115120.27742@localhost.lm.intel.com>
References: <1443721454-25467-1-git-send-email-keith.busch@intel.com> <20151006231412.GF29420@localhost> <alpine.LNX.2.00.1510062331220.23840@localhost.lm.intel.com> <20151008134702.GK27633@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 8 Oct 2015, Bjorn Helgaas wrote:
> On Wed, Oct 07, 2015 at 12:21:02AM +0000, Keith Busch wrote:
>> Thank you for bringing this up as I hadn't thought much about it and may
>> have misunderstood the meaning of _SEG. AIUI, it is used to identify a
>> logical grouping. The OS does not need to use the same identifier for
>> the domain, so we there's no need to collide if we can assign the domain
>> of a a new _SEG to the next available domain_nr.
>
> Yes, I guess it would be possible to decouple _SEG and Linux PCI
> domain numbers.  It's *convenient* to have them the same, so dmesg and
> lspci output matches _SEG directly, but I guess you could argue that's
> not essential.
>
> I think we'd have to maintain a mapping from domain back to _SEG to
> deal with firmware interfaces that expect _SEG, e.g., ia64 PAL calls.

It looks like there are lots of assumptions in the kernel that segment
and domain are the same thing. I don't have the necessary h/w to test
any changes here to verify the mappings are handled correctly, so I'm
apprehensive to start changing this much code that I can't test.

Given that domain_nr is a 32-bit integer, APCI's _SEG is only 16 bits,
and the pci domain is purely a software construct, do you see any problem
if we start these 'special' domains at 0x10000? I've tested this in
the driver and lspci + setpci with the single line update in pciutils'
lib/pci.h, and it all seems to work just fine.
