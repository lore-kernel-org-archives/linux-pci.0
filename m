Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:30414 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752657AbbJGAVD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 6 Oct 2015 20:21:03 -0400
Date: Wed, 7 Oct 2015 00:21:02 +0000 (UTC)
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Keith Busch <keith.busch@intel.com>,
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
In-Reply-To: <20151006231412.GF29420@localhost>
Message-ID: <alpine.LNX.2.00.1510062331220.23840@localhost.lm.intel.com>
References: <1443721454-25467-1-git-send-email-keith.busch@intel.com> <20151006231412.GF29420@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Thanks for the feedback. Much of the issues you mentioned look pretty
straight forward to resolve, and will fix of for the next revision.

I have some immediate follow up comments to two issues you brought up:

On Tue, 6 Oct 2015, Bjorn Helgaas wrote:
>> +static int vmd_find_free_domain(void)
>> +{
>> +	int domain = -1;
>> +	struct pci_bus *bus = NULL;
>> +
>> +	while ((bus = pci_find_next_bus(bus)) != NULL)
>> +		domain = max_t(int, domain, pci_domain_nr(bus));
>> +	if (domain < 0)
>> +		return -ENODEV;
>> +	return domain + 1;
>> +}
>
> The PCI core should own domain number allocation.  We have a little
> bit of generic domain support, e.g., pci_get_new_domain_nr().  On x86,
> I think that is compiled-in, but currently not used -- currently x86
> only uses _SEG from ACPI.  How would you handle collisions between a
> domain number assigned here (or via pci_get_new_domain_nr()) and a
> hot-added host bridge where _SEG uses the same domain?

Thank you for bringing this up as I hadn't thought much about it and may
have misunderstood the meaning of _SEG. AIUI, it is used to identify a
logical grouping. The OS does not need to use the same identifier for
the domain, so we there's no need to collide if we can assign the domain
of a a new _SEG to the next available domain_nr.

On pci_get_new_domain_nr(), can we make this use something like an
ida instead of an atomic? I think we'd like to put domains back into
the available pool if someone unbinds it. I imagine someone will test
unbinding/rebinding these devices in a loop for a while, and will file
a bug after the atomic increments to 64k. :)

>> +	resource_list_for_each_entry(entry, &resources) {
>> +		struct resource *source, *resource = entry->res;
>> +
>> +		if (!i) {
>> +			resource->start = 0;
>> +			resource->end = (resource_size(
>> +					&vmd->dev->resource[0]) >> 20) - 1;
>> +			resource->flags = IORESOURCE_BUS | IORESOURCE_PCI_FIXED;
>
> I thought BAR0 was CFGBAR.  I missed the connection to a bus number
> aperture.

Right, BAR0 is the CFGBAR and is the device's aperture to access its
domain's config space. Based on your comment, I assume that's not
a bus resource, though it seems to work with the posted code. :)
