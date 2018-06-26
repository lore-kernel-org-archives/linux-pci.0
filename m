Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:41576 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751026AbeFZGsk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Jun 2018 02:48:40 -0400
Received: by mail-qt0-f195.google.com with SMTP id y20-v6so14232584qto.8
        for <linux-pci@vger.kernel.org>; Mon, 25 Jun 2018 23:48:39 -0700 (PDT)
Subject: Re: [PATCH v2] PCI: controller: Move PCI_DOMAINS selection to arch
 Kconfig
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Guenter Roeck <linux@roeck-us.net>
References: <20180619112105.14457-1-lorenzo.pieralisi@arm.com>
 <30bb8a16-f829-a5a4-265f-2d1112d8d0bf@siemens.com>
 <20180621165400.GB14519@e107981-ln.cambridge.arm.com>
 <5e9b0aa4-ded1-725d-c401-49c13b7d5f9d@broadcom.com>
 <1529683148.2729.6.camel@intel.com> <20180625092758.GA6412@red-moon>
From: Scott Branden <scott.branden@broadcom.com>
Message-ID: <1cf91447-6e17-a7cb-c827-210835179db9@broadcom.com>
Date: Mon, 25 Jun 2018 23:48:11 -0700
MIME-Version: 1.0
In-Reply-To: <20180625092758.GA6412@red-moon>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,


On 18-06-25 02:27 AM, Lorenzo Pieralisi wrote:
> On Fri, Jun 22, 2018 at 11:59:08PM +0800, Ley Foon Tan wrote:
>> On Thu, 2018-06-21 at 22:08 -0700, Scott Branden wrote:
>>>
>>> On 18-06-21 09:54 AM, Lorenzo Pieralisi wrote:
>>>>
>>>> On Wed, Jun 20, 2018 at 10:07:33AM +0200, Jan Kiszka wrote:
>>>>>
>>>>> On 2018-06-19 13:21, Lorenzo Pieralisi wrote:
>>>>>>
>>>>>> Commit 51bc085d6454 ("PCI: Improve host drivers compile test
>>>>>> coverage")
>>>>>> added configuration options to allow PCI host controller
>>>>>> drivers to be
>>>>>> compile tested on all architectures.
>>>>>>
>>>>>> Some host controller drivers (eg PCIE_ALTERA) config entries
>>>>>> select
>>>>>> the PCI_DOMAINS config option to enable PCI domains management
>>>>>> in
>>>>>> the kernel. Now that host controller drivers can be compiled on
>>>>>> all architectures, this triggers build regressions on arches
>>>>>> that
>>>>>> do not implement the PCI_DOMAINS required API (ie
>>>>>> pci_domain_nr()):
>>>>>>
>>>>>> drivers/ata/pata_ali.c: In function 'ali_init_chipset':
>>>>>> drivers/ata/pata_ali.c:469:38: error:
>>>>>>           implicit declaration of function 'pci_domain_nr';
>>>>>>                                             did you mean
>>>>>> 'pci_iomap_wc'?
>>>>>>
>>>>>> Furthemore, some software configurations (ie Jailhouse) require
>>>>>> a
>>>>>> PCI_DOMAINS enabled kernel to configure multiple host
>>>>>> controllers
>>>>>> without having an explicit dependency on the ARM platform on
>>>>>> which
>>>>>> they run.
>>>>>>
>>>>>> Make PCI_DOMAINS a visible configuration option on ARM so that
>>>>>> software
>>>>>> configurations that need it can manually select it and move the
>>>>>> PCI_DOMAINS selection from PCI controllers configuration file
>>>>>> to ARM
>>>>>> sub-arch config entries that currently require it, fixing the
>>>>>> issue.
>>>>>>
>>>>>> Fixes: 51bc085d6454 ("PCI: Improve host drivers compile test
>>>>>> coverage")
>>>>>> Link: https://lkml.kernel.org/r/20180612170229.GA10141@roeck-us
>>>>>> .net
>>>>>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>>>>>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>>>>> Cc: Scott Branden <scott.branden@broadcom.com>
>>>>>> Cc: Will Deacon <will.deacon@arm.com>
>>>>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>>>>>> Cc: Rob Herring <robh@kernel.org>
>>>>>> Cc: Russell King <linux@armlinux.org.uk>
>>>>>> Cc: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>> Cc: Guenter Roeck <linux@roeck-us.net>
>>>>>> Cc: Ley Foon Tan <lftan@altera.com>
>>>>>> ---
>>>>>> v1 -> v2
>>>>>>      - Removed ARCH_VIRT PCI_DOMAINS selection
>>>>>>      - Added PCI_DOMAINS visible config option
>>>>>>
>>>>>> v1: https://marc.info/?l=linux-pci&m=152932092612352&w=2
>>>>>>
>>>>>>    arch/arm/Kconfig               | 8 +++++++-
>>>>>>    arch/arm/mach-bcm/Kconfig      | 1 +
>>>>>>    arch/arm/mach-socfpga/Kconfig  | 1 +
>>>>>>    drivers/pci/controller/Kconfig | 3 ---
>>>>>>    4 files changed, 9 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>>>>>> index 54eeb8d00bc6..843edfd000be 100644
>>>>>> --- a/arch/arm/Kconfig
>>>>>> +++ b/arch/arm/Kconfig
>>>>>> @@ -1245,8 +1245,14 @@ config PCI
>>>>>>        VESA. If you have PCI, say Y, otherwise N.
>>>>>>
>>>>>>    config PCI_DOMAINS
>>>>>> -   bool
>>>>>> +   bool "Support for multiple PCI domains"
>>>>>>      depends on PCI
>>>>>> +   help
>>>>>> +     Enable PCI domains kernel management. Say Y if your
>>>>>> machine
>>>>>> +     has a PCI bus hierarchy that requires more than one PCI
>>>>>> +     domain (aka segment) to be correctly managed. Say N
>>>>>> otherwise.
>>>>>> +
>>>>>> +     If you don't know what to do here, say N.
>>>>>>
>>>>>>    config PCI_DOMAINS_GENERIC
>>>>>>      def_bool PCI_DOMAINS
>>>>>> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-
>>>>>> bcm/Kconfig
>>>>>> index c46a728df44e..25aac6ee2ab1 100644
>>>>>> --- a/arch/arm/mach-bcm/Kconfig
>>>>>> +++ b/arch/arm/mach-bcm/Kconfig
>>>>>> @@ -20,6 +20,7 @@ config ARCH_BCM_IPROC
>>>>>>      select GPIOLIB
>>>>>>      select ARM_AMBA
>>>>>>      select PINCTRL
>>>>>> +   select PCI_DOMAINS if PCI
>>>>>>      help
>>>>>>        This enables support for systems based on Broadcom IPROC
>>>>>> architected SoCs.
>>>>>>        The IPROC complex contains one or more ARM CPUs along
>>>>>> with common
>>>>>> diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-
>>>>>> socfpga/Kconfig
>>>>>> index d0f62eacf59d..4adb901dd5eb 100644
>>>>>> --- a/arch/arm/mach-socfpga/Kconfig
>>>>>> +++ b/arch/arm/mach-socfpga/Kconfig
>>>>>> @@ -10,6 +10,7 @@ menuconfig ARCH_SOCFPGA
>>>>>>      select HAVE_ARM_SCU
>>>>>>      select HAVE_ARM_TWD if SMP
>>>>>>      select MFD_SYSCON
>>>>>> +   select PCI_DOMAINS if PCI
>>>>>>
>>>>>>    if ARCH_SOCFPGA
>>>>>>    config SOCFPGA_SUSPEND
>>>>>> diff --git a/drivers/pci/controller/Kconfig
>>>>>> b/drivers/pci/controller/Kconfig
>>>>>> index 18fa09b3ac8f..cc9fa02d32a0 100644
>>>>>> --- a/drivers/pci/controller/Kconfig
>>>>>> +++ b/drivers/pci/controller/Kconfig
>>>>>> @@ -96,7 +96,6 @@ config PCI_HOST_GENERIC
>>>>>>      depends on OF
>>>>>>      select PCI_HOST_COMMON
>>>>>>      select IRQ_DOMAIN
>>>>>> -   select PCI_DOMAINS
>>>>>>      help
>>>>>>        Say Y here if you want to support a simple generic PCI
>>>>>> host
>>>>>>        controller, such as the one emulated by kvmtool.
>>>>>> @@ -138,7 +137,6 @@ config PCI_VERSATILE
>>>>>>
>>>>>>    config PCIE_IPROC
>>>>>>      tristate
>>>>>> -   select PCI_DOMAINS
>>>>>>      help
>>>>>>        This enables the iProc PCIe core controller support for
>>>>>> Broadcom's
>>>>>>        iProc family of SoCs. An appropriate bus interface driver
>>>>>> needs
>>>>>> @@ -176,7 +174,6 @@ config PCIE_IPROC_MSI
>>>>>>    config PCIE_ALTERA
>>>>>>      bool "Altera PCIe controller"
>>>>>>      depends on ARM || NIOS2 || COMPILE_TEST
>>>>>> -   select PCI_DOMAINS
>>>>>>      help
>>>>>>        Say Y here if you want to enable PCIe controller support
>>>>>> on Altera
>>>>>>        FPGA.
>>>>>>
>>>>> Acked-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> Thanks a lot. Scott, Ley Foon, does it work for you ? I would like
>>>> to ask Bjorn to send it asap since the build on sparc is still
>>>> broken.
>>> Change will have to be made for arm64 for ARCH_BCM_IPROC as well.
>> Yes, need to add it to arm64 too. Others are okay.
> On arm64 CONFIG_PCI_DOMAINS defaults to CONFIG_PCI so there is no need
> to select it, if that's all you need changed there is nothing to
> change and this patch is read to be merged.
I see that now: arm64 is doing things properly.  The same should be done 
for arm: default to CONFIG_PCI so there is no need to select it.
I didn't like the change to have select to begin with.
>
> Lorenzo
