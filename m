Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:61744 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753235AbbJGQEW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 7 Oct 2015 12:04:22 -0400
Date: Wed, 7 Oct 2015 16:04:07 +0000 (UTC)
From: Keith Busch <keith.busch@intel.com>
To: Keith Busch <keith.busch@intel.com>
cc: Bjorn Helgaas <helgaas@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org, Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCHv2] x86/pci: Initial commit for new VMD device
 driver
In-Reply-To: <alpine.LNX.2.00.1510062331220.23840@localhost.lm.intel.com>
Message-ID: <alpine.LNX.2.00.1510071546080.23840@localhost.lm.intel.com>
References: <1443721454-25467-1-git-send-email-keith.busch@intel.com> <20151006231412.GF29420@localhost> <alpine.LNX.2.00.1510062331220.23840@localhost.lm.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 6 Oct 2015, Keith Busch wrote:
> On Tue, 6 Oct 2015, Bjorn Helgaas wrote:
>>> +	resource_list_for_each_entry(entry, &resources) {
>>> +		struct resource *source, *resource = entry->res;
>>> +
>>> +		if (!i) {
>>> +			resource->start = 0;
>>> +			resource->end = (resource_size(
>>> +					&vmd->dev->resource[0]) >> 20) - 1;
>>> +			resource->flags = IORESOURCE_BUS | 
>>> IORESOURCE_PCI_FIXED;
>> 
>> I thought BAR0 was CFGBAR.  I missed the connection to a bus number
>> aperture.
>
> Right, BAR0 is the CFGBAR and is the device's aperture to access its
> domain's config space.

It's a new day, I'll try a new explanation on what this is about. The size
of the CFGBAR determines how many bus numbers can be reached through the
device's config space aperture. We are not setting the bus resource to
BAR0; just determining the bus resource ending based on BAR0's size. We
expect the bar to be 256M to access config space for 256 buses:

   8 functions * 32 devices * 256 buses * 4k config space per function = 256M

If the BAR wasn't provided 256M for any reason, we reduce the number of
bus resources this domain can provide.
