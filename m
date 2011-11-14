Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:21025 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752305Ab1KNTub (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 14 Nov 2011 14:50:31 -0500
Message-ID: <4EC170E8.4070600@redhat.com>
Date: Mon, 14 Nov 2011 14:50:00 -0500
From: Prarit Bhargava <prarit@redhat.com>
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: Don Dutile <ddutile@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	James Paradis <jparadis@redhat.com>, linux-pci@vger.kernel.org,
	mstowe@redhat.com, matthew wilcox <matthew.wilcox@linux.intel.com>,
	jbarnes@virtuousgeek.org
Subject: Re: [PATCH] pci: Workaround Stratus broken PCIE hierarchy
References: <bd3514f0-1a80-45ac-a08e-b327a367b276@zmail15.collab.prod.int.phx2.redhat.com> <4EBD73C8.8070407@redhat.com> <CAErSpo5eZ=4yqnMFpFjTOqGvK6p4mOmsppJbodeGe+vkjfKdbw@mail.gmail.com> <4EBD8714.30401@redhat.com> <4EC12962.2040105@redhat.com> <20111114181418.GE4387@parisc-linux.org>
In-Reply-To: <20111114181418.GE4387@parisc-linux.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 11/14/2011 01:14 PM, Matthew Wilcox wrote:
> On Mon, Nov 14, 2011 at 09:44:50AM -0500, Prarit Bhargava wrote:
>> On 11/11/2011 03:35 PM, Don Dutile wrote:
>>  We should make it work automatically, either with
>>>> some sort of machine-dependent quirk, or (preferably) with a change to
>>>> the generic algorithm so it can handle these "broken" topologies along
>>>> with all the correct ones.
>>
>> The problem is when I'm examining "this" PCIE bridge I have no knowledge of the remaining hierarchy below it.  In order to find the broken topology we need to do a two pass enumeration (NO.) or minimally query all possible devices immediately connected to it.  If we do that then what is the purpose of the only_one_child() check?
> 
> We have enough information to do this quirk.
> 
> pci_scan_slot calls pci_scan_single_device() for the devfn 0.
> We can look at the device we found and quirk the parent device.
> Something like this ...
> 
>  int pci_scan_slot(struct pci_bus *bus, int devfn)
> [...]
>  	dev = pci_scan_single_device(bus, devfn);
> 	if (!dev)
> 		return 0;
> 	if (!dev->is_added)
> 		nr++;
> +	/* Quirk to fix NEC/Stratus broken PCIe topologies */
> +	if ((dev->pcie_type == PCI_EXP_TYPE_DOWNSTREAM) &&
> +	    (bus->self->pcie_type == PCI_EXP_TYPE_DOWNSTREAM))
> +		bus->self->pcie_type = PCI_EXP_TYPE_UPSTREAM;

I'm undoubtedly missing something obvious here, or I'm being dense.

This only works if there is a single Down bridge connected to a single Down bridge.  What Stratus/NEC has is a single Up bridge (02:00.0) connected to a Up bridge (03:00.0) and a Down bridge (03:01.0), which we know to be illegal in PCIE.  So the scan of the first bridge, 03:00.0 works and no fixup is done.  The code still misses the second bridge, 03:01.0.

Again -- I'm likely not seeing the bigger picture here or I'm missing something obvious why your patch works ... care to explain in detail?

> 
> As an aside, I'm quite shocked that this patch has been in the kernel
> for almost two years and this is the first time anybody's tested it on
> one of these systems.
> 

Heh ... we recently have asked some of our partners to monitor upstream more closely to avoid last minute "gotchyas" exactly like this one.

P.
