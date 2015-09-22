Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <65590637.5YmBIDOvTf@wuerfel>
References: <1442906367-10935-1-git-send-email-lftan@altera.com>
	<1442906367-10935-2-git-send-email-lftan@altera.com>
	<65590637.5YmBIDOvTf@wuerfel>
Date: Tue, 22 Sep 2015 18:53:50 +0800
Message-ID: <CAFiDJ59EeokEJVXCY7DEmDRp0hnd3he3f2fwjO-2tNN5VXrBgQ@mail.gmail.com>
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

On Tue, Sep 22, 2015 at 4:18 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 22 September 2015 15:19:26 Ley Foon Tan wrote:
>> +
>> +config PCI_SYSCALL
>> +     def_bool PCI
>
> IIRC, PCI_SYSCALL is deprecated and you should just leave that
> turned off.
>
> In any case, you enable the syscalls here but don't assign a
> system call number, so that is rather pointless. I
You are right. I can remove it if it is deprecated .
>
> I might be missing something though. Bjorn?
>
>> @@ -14,7 +14,7 @@
>>  #include <linux/types.h>
>>  #include <asm/pgtable-bits.h>
>>
>> -/* PCI is not supported in nios2, set this to 0. */
>> +/* PCI I/O space is not supported, set this to 0. */
>>  #define IO_SPACE_LIMIT 0
>>
>>  #define readb_relaxed(addr)  readb(addr)
>
> It might be useful to enable this, just in case someone connects
> a PCI host bridge that does support I/O space.
>
> Which host bridge do you use? Are you sure there is no I/O space?
> Most of them use a set of translation windows to set up a mapping
> between bus address (memory, config and io space) and physical
> (mmio) space.
I'm using Altera PCIe IP. But, you are right. We should enable this,
because it shouldn't limited to support Altera PCIe only.
BTW, any rule/requirement for the IO_SPACE_LIMIT?
And PCIBIOS_MIN_IO should be non-zero if we enable IO_SPACE_LIMIT?

>
>> diff --git a/arch/nios2/include/asm/pci.h b/arch/nios2/include/asm/pci.h
>> new file mode 100644
>> index 0000000..f2cba05
>> --- /dev/null
>> +++ b/arch/nios2/include/asm/pci.h
>
> What happens if you use the asm-generic header? If there is something
> missing in it, we can try to get it to do the right things.
All the defines in arch/nios2/include/asm/pci.h are required by PCI framework.
It will trigger undefined symbols/define error if without them. Seem
all architectures must provide all these defines.
So, we can consider to add default defines for these in asm-generic.

Regards
Ley Foon
