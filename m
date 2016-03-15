Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH 1/4] acpi,pci,irq: reduce resource requirements
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1457484079-18202-1-git-send-email-okaya@codeaurora.org>
 <20160314185251.GA19703@localhost> <56E7211F.3070203@codeaurora.org>
 <20160314210147.GA11459@localhost> <56E73232.9030704@codeaurora.org>
 <20160315014843.GA16967@localhost> <56E7733B.4050308@codeaurora.org>
 <20160315023632.GA23940@localhost>
Cc: linux-acpi@vger.kernel.org, timur@codeaurora.org,
	cov@codeaurora.org, linux-pci@vger.kernel.org,
	ravikanth.nalla@hpe.com, lenb@kernel.org, harish.k@hpe.com,
	ashwin.reghunandanan@hpe.com, bhelgaas@google.com,
	rjw@rjwysocki.net, linux-kernel@vger.kernel.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <56E80F19.7010503@codeaurora.org>
Date: Tue, 15 Mar 2016 09:33:13 -0400
MIME-Version: 1.0
In-Reply-To: <20160315023632.GA23940@localhost>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 3/14/2016 10:36 PM, Bjorn Helgaas wrote:
> On Mon, Mar 14, 2016 at 10:28:11PM -0400, Sinan Kaya wrote:
>> On 3/14/2016 9:48 PM, Bjorn Helgaas wrote:
>>
>> Yes. I was talking about PCIe on ARM64. 
>>
>>> If you go to Fry's and buy a conventional PCI card, it is going to
>>> pull INTA# low to assert an interrupt.  It doesn't matter whether you
>>> put it in an x86 system or an arm64 system.
>>
>> I don't see INTA# of the PCIe card at the system level. The PCIe wire 
>> interrupt gets converted to the system level interrupt by the PCIe controller.
> 
> That's why I said *conventional PCI*.  If you have a conventional PCI
> device below either a conventional PCI host controller or a PCIe-to-PCI
> bridge, there are real INTx wires, not virtual wires, and they are
> level/low.  But I think you pointed out the key below (that the
> Interrupt resource in a PNP0C0F device encodes the trigger type).
> 
>>>>> I pasted the code here again. It looks like you want to validate that
>>>>> PCI interrupts are always level low. 
>>> I don't really care whether PCI interrupts are always level low.  What
>>> matters is that the PCI interrupt line matches the configuration of
>>> the interrupt controller input.
>>>
>>
>> Agreed. But the interrupt controller configuration is system specific. How would
>> you check interrupt line against what the interrupt controller requires
>> on each architecture as this is common code?
>>
>>
>>> If the PCI interrupt can be a different type, e.g., level high, and
>>> there's a way to discover that, we can check that against the
>>> interrupt controller configuration.
>>>
>>> This is all in the context of conventional PCI, and we're probably
>>> talking about arm64 PCIe systems, not conventional PCI. 
>>
>> INTx interrupts are TLP messages on PCIe as you already know. There is no INTA 
>> interrupt wire.
> 
> Yes, that's why I mentioned PCIe sec 2.2.8.1 below.
> 
>> "6.1.2. PCI Compatible INTx Emulation" section of the PCIe spec describes
>> INTx emulation on PCIe.
>>  ...
>>
>>> I'm not sure what an Interrupt Link device means in PCIe.  I suppose it would have
>>> to connect an INTx virtual wire to a system interrupt?  The PCIe spec
>>> says this sort of mapping is system implementation specific (r3.0, sec
>>> 2.2.8.1).
>>
>> The INTx messages are converted to the system interrupt by the PCIe controller.
>> The interrupt type between the PCIe controller and the ARM GIC interrupt 
>> controller is dictated by the ARM GIC Interrupt Controller Specification for
>> ARM64.
>>
>> Here is what ACPI table looks like for reference
>>
>> 	Name(_PRT, Package(){
>> 		Package(){0x0FFFF, 0, \_SB.LN0A, 0},  // Slot 0, INTA
>> 		Package(){0x0FFFF, 1, \_SB.LN0B, 0},  // Slot 0, INTB
>> 		Package(){0x0FFFF, 2, \_SB.LN0C, 0},  // Slot 0, INTC
>> 		Package(){0x0FFFF, 3, \_SB.LN0D, 0}   // Slot 0, INTD
>> 	}) 
>>
>> Device(LN0A){
>> 	Name(_HID, EISAID("PNP0C0F")) // PCI interrupt link
>> 	Name(_UID, 1)
>> 	Name(_PRS, ResourceTemplate(){
>> 	Interrupt(ResourceProducer, Level, ActiveHigh, Exclusive, , ,) {0x123}
>> 	})
> 
> I forgot that the link already include the trigger mode in it.  Maybe we
> can check for that instead of assuming level/low.
> 

Let me explore this area.

> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
