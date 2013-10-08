Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49]:65062 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754063Ab3JHRUj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Oct 2013 13:20:39 -0400
Received: by mail-bk0-f49.google.com with SMTP id r7so3287633bkg.8
        for <linux-pci@vger.kernel.org>; Tue, 08 Oct 2013 10:20:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <525438F6.3090600@gmail.com>
References: <20131008144211.GA25231@e102652-lin.cambridge.arm.com>
	<CAErSpo5=sUJDZGm+zHw+b1h_a1YYbaGBshAutAoPBZYUCRbYkw@mail.gmail.com>
	<525438F6.3090600@gmail.com>
Date: Tue, 8 Oct 2013 18:20:37 +0100
Message-ID: <CAPcvp5Fvf5nkYXWviz8cKnOsMd0nOBJXrBXgMrDKCXkSP5L-Hw@mail.gmail.com>
Subject: Re: [RFC] Architecture independent pcibios?
From: Andrew Murray <amurray@embedded-bits.co.uk>
To: Rob Herring <robherring2@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
	Michal Simek <monstr@monstr.eu>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Grant Likely <grant.likely@linaro.org>,
	devicetree@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 8 October 2013 17:55, Rob Herring <robherring2@gmail.com> wrote:
> On 10/08/2013 11:32 AM, Bjorn Helgaas wrote:
>> [+cc Grant, Rob, devicetree list]
>>
>> On Tue, Oct 8, 2013 at 8:42 AM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
>>> Hello,
>>>
>>> I am working on adding PCIe support for a new architecture and looking
>>> at various existing implementations of pcibios functions I've realised
>>> that some architectures share a lot of common code. As I don't like to
>>> repeat the pattern again without any good reasons, I am wondering if
>>> there is any appetite for carving out those common functions into
>>> a generic place under drivers/pci/pcibios.c where they can be reused.
>>>
>>> Things that I am specifically looking at are pcibios_{alloc,free}_controller,
>>> pci_process_bridge_OF_ranges and anything that will make adding support
>>> for PCI/PCIe in a new architecture easier. Candidates for promoting
>>> to a generic place are the functions found in both powerpc and microblaze
>>> as they seem to be mostly identical, they support DT bindings and are
>>> 64bits ready.
>>
>> I'm very much in favor of unifying code to reduce duplication across
>> architectures.
>>
>> In general, the pcibios_*() interfaces are things used by the PCI core
>> (drivers/pci) but implemented by the architecture.  The specific cases
>> you mentioned are not actually used by the PCI core, so my inclination
>> would be to name them something else and possibly put them somewhere
>> other than drivers/pci.
>>
>> I wonder if pci_process_bridge_OF_ranges() would fit somewhere in
>> drivers/of?  The implementations I looked at are mostly concerned with
>> parsing OF resources, and they don't have much to do with PCI
>> directly.
>
> This was being done until Ben weighed in:
>
> https://lkml.org/lkml/2013/5/4/103
>
> Rob
>

Some of this work made it into the kernel...

The OF parts of pci_process_bridge_OF_ranges was split into
of_pci_range_parser and for_each_of_pci_range [1].

I then refactored some of the pci_process_bridge_OF_ranges functions
to use this parser, this was accepted by Microblaze [2] and has been
recently acked by Ralf for MIPS but not made it upstream yet [3]. I
think I submitted a patch for PowerPC at one point, but not sure what
happened to that.

[1] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=29b635c00f3ebcdaf7a52c4948f6d948ad3757d3
[2] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=4f7b6de437544cd1e2e210919cb58cbe5cc3c393
[3] http://www.linux-mips.org/archives/linux-mips/2013-09/msg00125.html

I'd like to get involved, but don't have any time at the moment.

Thanks,

Andrew Murray
