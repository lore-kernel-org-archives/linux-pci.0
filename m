Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5408024.XroFc5QNep@wuerfel>
References: <1442906367-10935-1-git-send-email-lftan@altera.com>
	<65590637.5YmBIDOvTf@wuerfel>
	<CAFiDJ59EeokEJVXCY7DEmDRp0hnd3he3f2fwjO-2tNN5VXrBgQ@mail.gmail.com>
	<5408024.XroFc5QNep@wuerfel>
Date: Tue, 29 Sep 2015 11:12:24 +0800
Message-ID: <CAFiDJ5_jkEqdAY=TtKOg6=GzT8i4qAFdnSH_z1RsoPVU2Vfr1Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] nios2: Add architectural support for PCIe
From: Ley Foon Tan <lftan@altera.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linux-Arch <linux-arch@vger.kernel.org>,
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 22, 2015 at 7:42 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 22 September 2015 18:53:50 Ley Foon Tan wrote:
>> On Tue, Sep 22, 2015 at 4:18 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Tuesday 22 September 2015 15:19:26 Ley Foon Tan wrote:
>> > I might be missing something though. Bjorn?
>> >
>> >> @@ -14,7 +14,7 @@
>> >>  #include <linux/types.h>
>> >>  #include <asm/pgtable-bits.h>
>> >>
>> >> -/* PCI is not supported in nios2, set this to 0. */
>> >> +/* PCI I/O space is not supported, set this to 0. */
>> >>  #define IO_SPACE_LIMIT 0
>> >>
>> >>  #define readb_relaxed(addr)  readb(addr)
>> >
>> > It might be useful to enable this, just in case someone connects
>> > a PCI host bridge that does support I/O space.
>> >
>> > Which host bridge do you use? Are you sure there is no I/O space?
>> > Most of them use a set of translation windows to set up a mapping
>> > between bus address (memory, config and io space) and physical
>> > (mmio) space.
>>
>> I'm using Altera PCIe IP. But, you are right. We should enable this,
>> because it shouldn't limited to support Altera PCIe only.
>> BTW, any rule/requirement for the IO_SPACE_LIMIT?
>
> If you want to allow just one PCI host bridge, set it to 0xffff, otherwise
> use 0xfffff (for up to 16 bridges)
Okay, will set it to 0xffff.
>
>> And PCIBIOS_MIN_IO should be non-zero if we enable IO_SPACE_LIMIT?
>
> If you define pcibios_align_resource() as an empty function, that can
> remain zero as well, it's only meant to stay out of the way of ISA
> devices.
Okay.
>
>> >> diff --git a/arch/nios2/include/asm/pci.h b/arch/nios2/include/asm/pci.h
>> >> new file mode 100644
>> >> index 0000000..f2cba05
>> >> --- /dev/null
>> >> +++ b/arch/nios2/include/asm/pci.h
>> >
>> > What happens if you use the asm-generic header? If there is something
>> > missing in it, we can try to get it to do the right things.
>> All the defines in arch/nios2/include/asm/pci.h are required by PCI framework.
>> It will trigger undefined symbols/define error if without them. Seem
>> all architectures must provide all these defines.
>> So, we can consider to add default defines for these in asm-generic.
>
> I think that would be good, yes. We probably picked defaults for the
> asm-generic version that are enough to build with CONFIG_PCI disabled,
> but there are useful defaults for the other case as well.
>
> Most architectures that use the file don't support PCI, so you can just
> add stuff inside of #ifdef CONFIG_PCI. For the remaining 13 architectures
> (git grep -l generic/pci.h  | wc), see whether there are conflicts first.
> The normal way would be to have the arch specific definition come before
> the #include, and then do something like
>
> #ifndef pci_proc_domain
> #define pci_proc_domain pci_proc_domain
> static inline int pci_proc_domain(struct pci_bus *bus)
> {
> #ifdef CONFIG_PCI_DOMAINS_GENERIC
>         return pci_domain_nr(bus);
> #else
>         return 1;
> }
> #endif

Okay, will try add them to asm-generic.
Do you prefer to send it as separate patch or can be part of this patchset?
Thanks.

Regards
Ley Foon
