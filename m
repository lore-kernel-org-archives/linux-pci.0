Return-Path: <SRS0=Ezzj=GD=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=Ezzj=GD=huawei.com=liudongdong3@kernel.org>
Subject: Re: [RFC PATCH] ARM64/PCI: Set dev->irq=0 before calling
 acpi_pci_irq_enable()
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1520650692-62705-1-git-send-email-liudongdong3@huawei.com>
 <20180313001830.GA60197@bhelgaas-glaptop.roam.corp.google.com>
CC: <lorenzo.pieralisi@arm.com>, <linux-pci@vger.kernel.org>,
	<linuxarm@huawei.com>, <charles.chenxin@huawei.com>,
	<linux-acpi@vger.kernel.org>, "Rafael J. Wysocki"
	<rafael.j.wysocki@intel.com>
From: Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <f5d23376-42d1-7fec-dc1c-45e419acb678@huawei.com>
Date: Tue, 13 Mar 2018 19:20:10 +0800
MIME-Version: 1.0
In-Reply-To: <20180313001830.GA60197@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn

Many thanks for your review.

在 2018/3/13 8:18, Bjorn Helgaas 写道:
> [+cc Rafael, linux-acpi]
>
> On Sat, Mar 10, 2018 at 10:58:12AM +0800, Dongdong Liu wrote:
>> The init value of dev->irq is from PCI_INTERRUPT_LINE register.The default
>> value of dev->irq usually is 255 before calling acpi_pci_irq_enable().
>> This will cause a problem When the platform does not support INTx well.
>> For example, we do not config _PRT on our HIP07 platform, we met irq 255
>> confilict.
>
> s/confilict/conflict/
>
> arm64 calls acpi_pci_irq_enable() in the probe() path instead of in
> the pci_enable_device() path.  I can't remember the reason, and
> unfortunately we didn't add a comment explaining why arm64 has to be
> different.
>
> PCI_INTERRUPT_LINE is used only by software and has no effect on the
> hardware.  If it contains 255 when Linux boots, that means firmware
> must have set it to that value.
>
> We need some comment here about why we should always ignore what
> firmware put there on arm64.  It needs to explain why this is
> different on arm64 than it is on x86 and ia64.  The changelog above
> basically says "we need this to make it work", but that's not very
> informative or convincing.

PCI 3.0, Section 6.2.4,
Interrupt Line
Values in this register are system architecture specific.

For x86 based PCs, the values in this register correspond to IRQ
numbers (0-15) of the standard dual 8259 configuration. The value
255 is defined as meaning "unknown" or "no connection" to the interrupt
controller. Values between 15 and 254 are reserved.

It seems the value of Interrupt Line is not defined on ARM64.
X86 has converted the irq 255 to IRQ_NOTCONNECTED in acpi_pci_irq_valid(),
but ARM64 does not, so it will not have irq 255 conflict on X86, but
ARM64 may have the issue if the BIOS does not provide _PRT.

static inline bool acpi_pci_irq_valid(struct pci_dev *dev, u8 pin)
{
#ifdef CONFIG_X86
	/*
	 * On x86 irq line 0xff means "unknown" or "no connection"
	 * (PCI 3.0, Section 6.2.4, footnote on page 223).
	 */
	if (dev->irq == 0xff) {
		dev->irq = IRQ_NOTCONNECTED;
		dev_warn(&dev->dev, "PCI INT %c: not connected\n",
			 pin_name(pin));
		return false;
	}
#endif
	return true;
}

>
> It sounds like you're saying HIP07 doesn't provide _PRT?  Per the PCI
> Firmware Spec, r3.0, sec 4.4, _PRT is required under all PCI host
> bridges.  So I think you're saying HIP07 doesn't comply with the spec,

Yes, It does not support to use _PRT on the Hip07.

> but the workaround here applies to *all* arm64 platforms.  That
> doesn't seem right.

Yes, it seems the Interrupt Line register is useless on ARM64
from current code.

>
> On x86, I think if the _PRT doesn't tell us where an interrupt pin is
> routed, we fall back to looking at PCI_INTERRUPT_LINE.  But here
> you seem to be saying "there's no _PRT" *and* "there's no useful
> information in PCI_INTERRUPT_LINE".
>
> Maybe I'm not understanding what you're saying.

The irq 255 conflict issue can be resolved by BIOS to set PCI device's
Interrupt Line register from 255(0xff) to 0.
or modify the code as below if ARM64 has the same meaning with X86 about
Interrupt Line register.
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -390,7 +390,7 @@ static inline int acpi_isa_register_gsi(struct pci_dev *dev)

  static inline bool acpi_pci_irq_valid(struct pci_dev *dev, u8 pin)
  {
-#ifdef CONFIG_X86
+#if defined(CONFIG_X86) || defined(CONFIG_ARM64)
         /*
          * On x86 irq line 0xff means "unknown" or "no connection"
          * (PCI 3.0, Section 6.2.4, footnote on page 223).


Thanks,
Dongdong
>
>> The error message is as below.
>> snd_hda_intel 000d:33:00.1: PCI INT B: no GSI
>> snd_hda_intel 000d:33:00.1: enabling device (0000 -> 0002)
>> snd_hda_intel 000d:33:00.1: Force to snoop mode by module option
>> snd_hda_intel 000d:33:00.1: Device has broken 64-bit MSI but arch tried to
>> assign one above 4G
>> genirq: Flags mismatch irq 255. 00000001 (enahisic2i0-tx1) vs. 00000081
>> (snd_hda_intel:card0)
>> hns-nic HISI00C2:00 enahisic2i0: request irq(255) fail
>>
>> enahisic2i0-tx1: this device is a platform device.
>> snd_hda_intel:card0: this device is a PCI device.
>>
>> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
>> ---
>>  arch/arm64/kernel/pci.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
>> index 0e2ea1c..6a77bef 100644
>> --- a/arch/arm64/kernel/pci.c
>> +++ b/arch/arm64/kernel/pci.c
>> @@ -28,8 +28,11 @@
>>   */
>>  int pcibios_alloc_irq(struct pci_dev *dev)
>>  {
>> -	if (!acpi_disabled)
>> +	if (!acpi_disabled) {
>> +		dev->irq = 0;
>>  		acpi_pci_irq_enable(dev);
>> +	}
>> +
>>
>>  	return 0;
>>  }
>> --
>> 1.9.1
>>
>
> .
>
