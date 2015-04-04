Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:38656 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171AbbDDDex (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 3 Apr 2015 23:34:53 -0400
MIME-Version: 1.0
In-Reply-To: <20150403205201.GF10892@google.com>
References: <1427857069-6789-1-git-send-email-yinghai@kernel.org>
	<1427857069-6789-2-git-send-email-yinghai@kernel.org>
	<20150403193234.GD10892@google.com>
	<20150403205201.GF10892@google.com>
Date: Fri, 3 Apr 2015 20:34:52 -0700
Message-ID: <CAE9FiQVqAEvoLDRZMcNFki0gLMQiyQd2VYivjAh1teRGeuNwBw@mail.gmail.com>
Subject: Re: [PATCH 1/3] PCI: Introduce pci_bus_addr_t
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Miller <davem@davemloft.net>,
	David Ahern <david.ahern@oracle.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Russell King <linux@arm.linux.org.uk>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 3, 2015 at 1:52 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> [+cc Sam (commented on previous versions), Russell, linux-arm-kernel, Ralf,
> linux-mips, Ben, linuxppc-dev, x86]
>
> On Fri, Apr 03, 2015 at 02:32:34PM -0500, Bjorn Helgaas wrote:
>> On Tue, Mar 31, 2015 at 07:57:47PM -0700, Yinghai Lu wrote:
>> > David Ahern found commit d63e2e1f3df9 ("sparc/PCI: Clip bridge windows
>> > to fit in upstream windows") broke booting on sparc/T5-8.
>> >
>> > In the boot log, there is
>> >   pci 0000:06:00.0: reg 0x184: can't handle BAR above 4GB (bus address
>> >   0x110204000)
>> > but that only could happen when dma_addr_t is 32-bit.
>> >
>> > According to David Miller, all DMA occurs behind an IOMMU and these
>> > IOMMUs only support 32-bit addressing, therefore dma_addr_t is
>> > 32-bit on sparc64.
>> >
>> > Let's introduce pci_bus_addr_t instead of using dma_addr_t,
>> > and pci_bus_addr_t will be 64-bit on 64-bit platform or X86_PAE.
>> >
>> > Fixes: commit d63e2e1f3df9 ("sparc/PCI: Clip bridge windows to fit in upstream windows")
>> > Fixes: commit 23b13bc76f35 ("PCI: Fail safely if we can't handle BARs larger than 4GB")
>> > Link: http://lkml.kernel.org/r/CAE9FiQU1gJY1LYrxs+ma5LCTEEe4xmtjRG0aXJ9K_Tsu+m9Wuw@mail.gmail.com
>> > Reported-by: David Ahern <david.ahern@oracle.com>
>> > Tested-by: David Ahern <david.ahern@oracle.com>
>> > Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>> > Cc: <stable@vger.kernel.org> #3.19
>> > ---
>> >  drivers/pci/Kconfig |  4 ++++
>> >  drivers/pci/bus.c   | 10 +++++-----
>> >  drivers/pci/probe.c | 12 ++++++------
>> >  include/linux/pci.h | 12 +++++++++---
>> >  4 files changed, 24 insertions(+), 14 deletions(-)
>> >
>> > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
>> > index 7a8f1c5..6a5a269 100644
>> > --- a/drivers/pci/Kconfig
>> > +++ b/drivers/pci/Kconfig
>> > @@ -1,6 +1,10 @@
>> >  #
>> >  # PCI configuration
>> >  #
>> > +config PCI_BUS_ADDR_T_64BIT
>> > +   def_bool y if (64BIT || X86_PAE)
>> > +   depends on PCI
>>
>> We're going to use pci_bus_addr_t in some places where we previously used
>> dma_addr_t, which means pci_bus_addr_t should be at least as large as
>> dma_addr_t.  Can you enforce that directly, e.g., with something like this?
>>
>>     def_bool y if (ARCH_DMA_ADDR_T_64BIT || 64BIT || X86_PAE)

then should use

def_bool y if (ARCH_DMA_ADDR_T_64BIT || 64BIT)

Thanks

Yinghai
