Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:59058 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756950AbbJITWt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 9 Oct 2015 15:22:49 -0400
Date: Fri, 9 Oct 2015 19:22:48 +0000 (UTC)
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
	Martin Mares <mj@ucw.cz>
Subject: Re: [RFC PATCHv2] x86/pci: Initial commit for new VMD device
 driver
In-Reply-To: <20151009180910.GB16112@localhost>
Message-ID: <alpine.LNX.2.00.1510091855080.27742@localhost.lm.intel.com>
References: <1443721454-25467-1-git-send-email-keith.busch@intel.com> <20151006231412.GF29420@localhost> <alpine.LNX.2.00.1510062331220.23840@localhost.lm.intel.com> <20151008134702.GK27633@localhost> <alpine.LNX.2.00.1510082115120.27742@localhost.lm.intel.com>
 <20151009180910.GB16112@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 9 Oct 2015, Bjorn Helgaas wrote:
>> Given that domain_nr is a 32-bit integer, APCI's _SEG is only 16 bits,
>> and the pci domain is purely a software construct, do you see any problem
>> if we start these 'special' domains at 0x10000? I've tested this in
>> the driver and lspci + setpci with the single line update in pciutils'
>> lib/pci.h, and it all seems to work just fine.
>
> If you make the kernel start using domain numbers that don't fit in 16
> bits, what happens if you run the old lspci on a new kernel?

If VMD is enabled and enumerated by the driver with this proposal,
older versions of pciutils will not work; lspci will exit with error
status for being unable to find the sysfs entry for devices in that
domain since the upper bits are truncated in the down cast.

Assuming we can change pciutils to use 'int' for domain, and have a
driver for this new device merged in the near future, I'm not too worried
about users and distros with older utils. I don't think this a device
someone could turn on by accident, so their shouldn't be any fallout if
I properly communicate the dependencies to those who do want to enable it.
