Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:52418 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754986Ab3JHQzW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Oct 2013 12:55:22 -0400
Message-ID: <525438F6.3090600@gmail.com>
Date: Tue, 08 Oct 2013 11:55:18 -0500
From: Rob Herring <robherring2@gmail.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Liviu Dudau <Liviu.Dudau@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
	Michal Simek <monstr@monstr.eu>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Grant Likely <grant.likely@linaro.org>,
	devicetree@vger.kernel.org
Subject: Re: [RFC] Architecture independent pcibios?
References: <20131008144211.GA25231@e102652-lin.cambridge.arm.com> <CAErSpo5=sUJDZGm+zHw+b1h_a1YYbaGBshAutAoPBZYUCRbYkw@mail.gmail.com>
In-Reply-To: <CAErSpo5=sUJDZGm+zHw+b1h_a1YYbaGBshAutAoPBZYUCRbYkw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/08/2013 11:32 AM, Bjorn Helgaas wrote:
> [+cc Grant, Rob, devicetree list]
> 
> On Tue, Oct 8, 2013 at 8:42 AM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
>> Hello,
>>
>> I am working on adding PCIe support for a new architecture and looking
>> at various existing implementations of pcibios functions I've realised
>> that some architectures share a lot of common code. As I don't like to
>> repeat the pattern again without any good reasons, I am wondering if
>> there is any appetite for carving out those common functions into
>> a generic place under drivers/pci/pcibios.c where they can be reused.
>>
>> Things that I am specifically looking at are pcibios_{alloc,free}_controller,
>> pci_process_bridge_OF_ranges and anything that will make adding support
>> for PCI/PCIe in a new architecture easier. Candidates for promoting
>> to a generic place are the functions found in both powerpc and microblaze
>> as they seem to be mostly identical, they support DT bindings and are
>> 64bits ready.
> 
> I'm very much in favor of unifying code to reduce duplication across
> architectures.
> 
> In general, the pcibios_*() interfaces are things used by the PCI core
> (drivers/pci) but implemented by the architecture.  The specific cases
> you mentioned are not actually used by the PCI core, so my inclination
> would be to name them something else and possibly put them somewhere
> other than drivers/pci.
> 
> I wonder if pci_process_bridge_OF_ranges() would fit somewhere in
> drivers/of?  The implementations I looked at are mostly concerned with
> parsing OF resources, and they don't have much to do with PCI
> directly.

This was being done until Ben weighed in:

https://lkml.org/lkml/2013/5/4/103

Rob

> pcibios_alloc_controller() is implemented by microblaze, powerpc, and
> xtensa.  Each of those arches defines its own "struct pci_controller",
> so it won't be completely trivial to unify this.  I tried to start
> some unification with the "struct pci_host_bridge" in the core, but
> haven't made much progress there.
> 
> Bjorn
> 

