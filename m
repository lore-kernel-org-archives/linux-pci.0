Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:63150 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932384Ab2FOQdi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 15 Jun 2012 12:33:38 -0400
Received: by lahd3 with SMTP id d3so2203631lah.19
        for <linux-pci@vger.kernel.org>; Fri, 15 Jun 2012 09:33:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAL-B5D1GEMd9TPMqbYBqDuzs5U2jo7ByRg73Z=dPsPcgTSyJJA@mail.gmail.com>
References: <1338749305-22558-1-git-send-email-sebastian@breakpoint.cc>
 <1338749305-22558-8-git-send-email-sebastian@breakpoint.cc> <CAL-B5D1GEMd9TPMqbYBqDuzs5U2jo7ByRg73Z=dPsPcgTSyJJA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 15 Jun 2012 10:33:15 -0600
Message-ID: <CAErSpo77vyUaGTzVNwFGzTHsOapYNFRy_KOvNnXo=jdU2kYLbA@mail.gmail.com>
Subject: Re: [PATCH 7/9] mips: move PCI fixup hooks from __init to __devinit
To: Myron Stowe <myron.stowe@gmail.com>
Cc: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
	linux-pci@vger.kernel.org, linux-kbuild@vger.kernel.org,
	Michal Marek <mmarek@suse.cz>,
	Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 14, 2012 at 10:39 AM, Myron Stowe <myron.stowe@gmail.com> wrote:
> On Sun, Jun 3, 2012 at 12:48 PM, Sebastian Andrzej Siewior
> <sebastian@breakpoint.cc> wrote:
>> The fixups are executed once the pci-device is found which is during
>> boot process so __init seems fine as long as the platform does not
>> support hotplug.
>> However it is possible to remove the PCI bus at run time and have it
>> rediscovered again via "echo 1 > /sys/bus/pci/rescan" and this will call
>> the fixups again.
>>
>> Cc: Ralf Baechle <ralf@linux-mips.org>
>> Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
>> ---
>>  arch/mips/mti-malta/malta-pci.c |    2 +-
>>  arch/mips/pci/fixup-fuloong2e.c |   12 ++++++------
>>  arch/mips/pci/fixup-lemote2f.c  |   12 ++++++------
>>  arch/mips/pci/fixup-malta.c     |    4 ++--
>>  arch/mips/pci/fixup-sb1250.c    |    6 +++---
>>  arch/mips/pci/ops-tx4927.c      |    2 +-
>>  arch/mips/pci/pci-ip27.c        |    2 +-
>>  arch/mips/txx9/generic/pci.c    |    2 +-
>>  8 files changed, 21 insertions(+), 21 deletions(-)
>>
>> diff --git a/arch/mips/mti-malta/malta-pci.c b/arch/mips/mti-malta/malta-pci.c
>> index bf80921..b663402 100644
>> --- a/arch/mips/mti-malta/malta-pci.c
>> +++ b/arch/mips/mti-malta/malta-pci.c
>> @@ -253,7 +253,7 @@ void __init mips_pcibios_init(void)
>>  }
>>
>>  /* Enable PCI 2.1 compatibility in PIIX4 */
>> -static void __init quirk_dlcsetup(struct pci_dev *dev)
>> +static void __devinit quirk_dlcsetup(struct pci_dev *dev)
>>  {
>>        u8 odlc, ndlc;
>>        (void) pci_read_config_byte(dev, 0x82, &odlc);
>> diff --git a/arch/mips/pci/fixup-fuloong2e.c b/arch/mips/pci/fixup-fuloong2e.c
>> index d5d4c01..0857ab8 100644
>> --- a/arch/mips/pci/fixup-fuloong2e.c
>> +++ b/arch/mips/pci/fixup-fuloong2e.c
>> @@ -48,7 +48,7 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
>>        return 0;
>>  }
>>
>> -static void __init loongson2e_nec_fixup(struct pci_dev *pdev)
>> +static void __devinit loongson2e_nec_fixup(struct pci_dev *pdev)
>>  {
>>        unsigned int val;
>>
>> @@ -60,7 +60,7 @@ static void __init loongson2e_nec_fixup(struct pci_dev *pdev)
>>        pci_write_config_dword(pdev, 0xe4, 1 << 5);
>>  }
>>
>> -static void __init loongson2e_686b_func0_fixup(struct pci_dev *pdev)
>> +static void __devinit loongson2e_686b_func0_fixup(struct pci_dev *pdev)
>>  {
>>        unsigned char c;
>>
>> @@ -135,7 +135,7 @@ static void __init loongson2e_686b_func0_fixup(struct pci_dev *pdev)
>>        printk(KERN_INFO"via686b fix: ISA bridge done\n");
>>  }
>>
>> -static void __init loongson2e_686b_func1_fixup(struct pci_dev *pdev)
>> +static void __devinit loongson2e_686b_func1_fixup(struct pci_dev *pdev)
>>  {
>>        printk(KERN_INFO"via686b fix: IDE\n");
>>
>> @@ -168,19 +168,19 @@ static void __init loongson2e_686b_func1_fixup(struct pci_dev *pdev)
>>        printk(KERN_INFO"via686b fix: IDE done\n");
>>  }
>>
>> -static void __init loongson2e_686b_func2_fixup(struct pci_dev *pdev)
>> +static void __devinit loongson2e_686b_func2_fixup(struct pci_dev *pdev)
>>  {
>>        /* irq routing */
>>        pci_write_config_byte(pdev, PCI_INTERRUPT_LINE, 10);
>>  }
>>
>> -static void __init loongson2e_686b_func3_fixup(struct pci_dev *pdev)
>> +static void __devinit loongson2e_686b_func3_fixup(struct pci_dev *pdev)
>>  {
>>        /* irq routing */
>>        pci_write_config_byte(pdev, PCI_INTERRUPT_LINE, 11);
>>  }
>>
>> -static void __init loongson2e_686b_func5_fixup(struct pci_dev *pdev)
>> +static void __devinit loongson2e_686b_func5_fixup(struct pci_dev *pdev)
>>  {
>>        unsigned int val;
>>        unsigned char c;
>> diff --git a/arch/mips/pci/fixup-lemote2f.c b/arch/mips/pci/fixup-lemote2f.c
>> index 4b9768d..a7b917dcf 100644
>> --- a/arch/mips/pci/fixup-lemote2f.c
>> +++ b/arch/mips/pci/fixup-lemote2f.c
>> @@ -96,21 +96,21 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
>>  }
>>
>>  /* CS5536 SPEC. fixup */
>> -static void __init loongson_cs5536_isa_fixup(struct pci_dev *pdev)
>> +static void __devinit loongson_cs5536_isa_fixup(struct pci_dev *pdev)
>>  {
>>        /* the uart1 and uart2 interrupt in PIC is enabled as default */
>>        pci_write_config_dword(pdev, PCI_UART1_INT_REG, 1);
>>        pci_write_config_dword(pdev, PCI_UART2_INT_REG, 1);
>>  }
>>
>> -static void __init loongson_cs5536_ide_fixup(struct pci_dev *pdev)
>> +static void __devinit loongson_cs5536_ide_fixup(struct pci_dev *pdev)
>>  {
>>        /* setting the mutex pin as IDE function */
>>        pci_write_config_dword(pdev, PCI_IDE_CFG_REG,
>>                               CS5536_IDE_FLASH_SIGNATURE);
>>  }
>>
>> -static void __init loongson_cs5536_acc_fixup(struct pci_dev *pdev)
>> +static void __devinit loongson_cs5536_acc_fixup(struct pci_dev *pdev)
>>  {
>>        /* enable the AUDIO interrupt in PIC  */
>>        pci_write_config_dword(pdev, PCI_ACC_INT_REG, 1);
>> @@ -118,14 +118,14 @@ static void __init loongson_cs5536_acc_fixup(struct pci_dev *pdev)
>>        pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 0xc0);
>>  }
>>
>> -static void __init loongson_cs5536_ohci_fixup(struct pci_dev *pdev)
>> +static void __devinit loongson_cs5536_ohci_fixup(struct pci_dev *pdev)
>>  {
>>        /* enable the OHCI interrupt in PIC */
>>        /* THE OHCI, EHCI, UDC, OTG are shared with interrupt in PIC */
>>        pci_write_config_dword(pdev, PCI_OHCI_INT_REG, 1);
>>  }
>>
>> -static void __init loongson_cs5536_ehci_fixup(struct pci_dev *pdev)
>> +static void __devinit loongson_cs5536_ehci_fixup(struct pci_dev *pdev)
>>  {
>>        u32 hi, lo;
>>
>> @@ -137,7 +137,7 @@ static void __init loongson_cs5536_ehci_fixup(struct pci_dev *pdev)
>>        pci_write_config_dword(pdev, PCI_EHCI_FLADJ_REG, 0x2000);
>>  }
>>
>> -static void __init loongson_nec_fixup(struct pci_dev *pdev)
>> +static void __devinit loongson_nec_fixup(struct pci_dev *pdev)
>>  {
>>        unsigned int val;
>>
>> diff --git a/arch/mips/pci/fixup-malta.c b/arch/mips/pci/fixup-malta.c
>> index 0f48498..59cfbc8 100644
>> --- a/arch/mips/pci/fixup-malta.c
>> +++ b/arch/mips/pci/fixup-malta.c
>> @@ -49,7 +49,7 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
>>        return 0;
>>  }
>>
>> -static void __init malta_piix_func0_fixup(struct pci_dev *pdev)
>> +static void __devinit malta_piix_func0_fixup(struct pci_dev *pdev)
>>  {
>>        unsigned char reg_val;
>>        static int piixirqmap[16] __initdata = {  /* PIIX PIRQC[A:D] irq mappings */
>
> Doesn't the above line also need changed to __devinitdata if the
> function itself is being
> changed from __init to __devinit?

I think so.  And pci_irq[] and piixirqmap[] also need to be moved,
since they're referenced by __devinit code.  I fixed these, audited
all the other patches, and updated the "next" branch.

Bjorn
