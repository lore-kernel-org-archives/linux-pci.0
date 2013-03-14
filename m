Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rs140.luxsci.com ([74.205.78.114]:34543 "EHLO rs140.luxsci.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752129Ab3CNVKv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 14 Mar 2013 17:10:51 -0400
Message-ID: <51423CCA.3030000@firmworks.com>
Date: Thu, 14 Mar 2013 11:10:34 -1000
From: Mitch Bradley <wmb@firmworks.com>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@avionic-design.de>
CC: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
References: <20130312213006.GA23717@avionic-0098.mockup.avionic-design.de> <20130312220854.GA23112@obsidianresearch.com> <20130313081815.GD25940@avionic-0098.mockup.avionic-design.de> <20130313170205.GB24042@obsidianresearch.com> <20130313192628.GA28714@avionic-0098.mockup.avionic-design.de> <5140E85A.3040900@firmworks.com> <20130313220235.GA29895@avionic-0098.mockup.avionic-design.de> <20130313222102.GA28336@obsidianresearch.com> <20130314090120.GA2224@avionic-0098.mockup.avionic-design.de> <20130314172555.GA14048@obsidianresearch.com> <20130314203858.GA4539@avionic-0098.mockup.avionic-design.de>
In-Reply-To: <20130314203858.GA4539@avionic-0098.mockup.avionic-design.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 3/14/2013 10:38 AM, Thierry Reding wrote:
> On Thu, Mar 14, 2013 at 11:25:55AM -0600, Jason Gunthorpe wrote:
>> [trimm'd the cc list]
>>
>> On Thu, Mar 14, 2013 at 10:01:20AM +0100, Thierry Reding wrote:
>>
>>> It turns out that this works with the Tegra driver because it uses the
>>> new of_pci_process_ranges() function and simply overwrites earlier
>>> matches by subsequent ones.
>>>
>>> 	ranges = <0x82000000 0 0 0x80000000 0 0x00001000   /* port 0 registers */
>>> 		  0x82000000 0 0 0x80001000 0 0x00001000   /* port 1 registers */
>>> 		  0x81000000 0 0 0x82000000 0 0x00010000   /* downstream I/O */
>>> 		  0x82000000 0 0 0xa0000000 0 0x10000000   /* non-prefetchable memory */
>>> 		  0xc2000000 0 0 0xb0000000 0 0x10000000>; /* prefetchable memory */
>>
>> Okay.. There is still something funny here, the 3rd dword of the child
>> address should not be 0 in every line and there shouldn't be overlaps
>> in the child address space.
>>
>> I'm assuming 0x80000000, 0xa0000000 and 0xb0000000 are real CPU physical
>> addresses?
> 
> Yes.
> 
>> Then it should probably look like:
>>
>> ranges = <0x82000000 0 0x80000000  0x80000000  0 0x00001000   /* port 0 registers */
>> 	  0x82000000 0 0x80001000  0x80001000  0 0x00001000   /* port 1 registers */
>> 	  0x81000000 0          0  0x82000000  0 0x00010000   /* downstream I/O */
>> 	  0x82000000 0 0xa0000000  0xa0000000  0 0x10000000   /* non-prefetchable memory */
>> 	  0xc2000000 0 0xb0000000  0xb0000000  0 0x10000000>; /* prefetchable memory */
>>
>> Which says 'access to CPU address 0xa0000000 produces a PCI-E memory TLP with
>> address 0xa0000000' - this is the 'normal' case, I assume that is what
>> happens on tegra?
>>
>> It also says 'access to CPU address 0x82000000 produces a PCI-E IO TLP
>> with address 0' - this translation is something Linux typically
>> expects..
>>
>> Then you'd go on to have:
>>
>>                pci@1,0 {
>>                         device_type = "pci";
>>                         assigned-addresses = <0x82000000 0 0x80000000  0 0x1000>;
>>                         reg = <0x000800 0 0 0 0>;
>>                }
>>                pci@2,0 {
>>                         device_type = "pci";
>>                         assigned-addresses = <0x82000000 0 0x80001000  0 0x1000>;
>>                         reg = <0x001000 0 0 0 0>;
>>                }
>>
>> Notice I've made the upper dw of assigned-addresses's size 0 and
>> included the full 3dw from the appropriate ranges line.
> 
> Okay, that all makes sense.
> 
>>> So the above will actually work along with the corresponding root-port
>>> "assigned-addresses" properties. I still don't like it much because I
>>> don't think it accurately reflects the hardware. 
>>
>> There are lots of valid ways to model the same HW :(
>>
>> Bear in mind, for the PCI case - the OF PCI bindings model the HW
>> through the eyes of the abstractions in the PCI specification. That is
>> to say, they are not supposed to be an exact representation of the on
>> chip architecture.
> 
> That seems to be at odds with most other uses of DT that I've come
> across. Generally the guideline seems to be to describe hardware
> irrespective of the underlying implementation and leave it up to the
> driver to translate the DT description into something the OS can use.

This can be a gray area where one just has to make a judgement call.
You can think of the hardware at various levels of abstraction and
sometimes it is not obvious where to draw the line.  "Tell the truth"
tends to be more stable in the long run, but can be more work in the
short run, and it can be hard to predict the future well enough to
choose the optimum approach.

> 
>> Perhaps this would be clearer if you used 'pcie-root-complex' as the
>> name of the top level node?
> 
> Perhaps. I'm not sure.
> 
>>> same kludgy, non-spec conformant smack that my original proposal had
>>> because it uses assigned-addresses for something it wasn't intended
>>> to.
>>
>> Yes, only the top level 'reg' method avoids going outside any specs.
> 
> Yes. It has a couple of other disadvantages, though, so if what we've
> been discussing here is in any way acceptable I'd rather go with that
> solution, even if I'm not entirely happy about it either.
> 
> Thierry
> 
