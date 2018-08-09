Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35657 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730419AbeHIRXN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Aug 2018 13:23:13 -0400
Received: by mail-qt0-f195.google.com with SMTP id r21-v6so6842116qtm.2
        for <linux-pci@vger.kernel.org>; Thu, 09 Aug 2018 07:57:57 -0700 (PDT)
Subject: Re: [RFC] ARM64, PCIe, annd ACPI
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Tomasz Nowicki <tn@semihalf.com>,
        Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
References: <89484aa0-08c4-0cff-500d-407d21e2f5fd@broadcom.com>
 <20180808093822.GA25150@e107981-ln.cambridge.arm.com>
 <a32a8761-f49f-f0cf-928b-0c323c2b540e@broadcom.com>
 <20180809085923.GA13428@e107981-ln.cambridge.arm.com>
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <9b5b5918-1492-df65-5b63-678b4a35ecb9@broadcom.com>
Date: Thu, 9 Aug 2018 07:57:52 -0700
MIME-Version: 1.0
In-Reply-To: <20180809085923.GA13428@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

On 8/9/2018 1:59 AM, Lorenzo Pieralisi wrote:
> On Wed, Aug 08, 2018 at 11:49:46AM -0700, Ray Jui wrote:
>>
>>
>> On 8/8/2018 2:38 AM, Lorenzo Pieralisi wrote:
>>> On Tue, Aug 07, 2018 at 05:10:15PM -0700, Ray Jui wrote:
>>>> Hi Lorenzo/Bjorn,
>>>>
>>>> I have a question on PCIe controller APCI support on ARM64 based systems.
>>>>
>>>> If my understanding of the implementation of "pci_acpi_scan_root" under
>>>> "arch/arm64/kernel/pci.c" is correct, it appears
>>>> "pci_acpi_setup_ecam_mapping" is called within "pci_acpi_scan_root".
>>>>
>>>> Does that mean for a PCIe host controller on ARM64 to support ACPI, it needs
>>>> to support ECAM and MMIO based access to the configuration space registers?
>>>>
>>>> If the above statement is true, does it imply that any PCIe controller on
>>>> ARM64 that does not support MMIO based access to the config space register
>>>> cannot have ACPI support?
>>>
>>> Yes and it is not just MMIO, config space must be ECAM compliant as described
>>> in the PCI firmware specification and enforced here:
>>>
>>> http://infocenter.arm.com/help/topic/com.arm.doc.den0029b/Server_Base_System_Architecture_v5_0_ARM_DEN_0029B.pdf
>>>
>>
>> Okay, got it, the SBSA spec makes it very clear that the PCIe controller
>> needs to support ECAM.
>>
>>> In short: what's in the mainline (+ adequate PCI controller firmware
>>> configuration) must be sufficient to bootstrap your PCI subsystem in
>>> ACPI, it is a very simple litmus test and we won't add anything that
>>> deviates from that to the mainline kernel ARM64 ACPI PCI code support.
>>>
>>
>> It sounds like I'll have to look into ways to work around this at the driver
>> level as Bjorn pointed out with some other examples.
> 
> As I said ARM64 ACPI PCI kernel support is in the mainline today and I
> am not willing to merge any more MCFG quirks at driver level - the
> information is out there, it is public and must be followed, either
> designers do that or no ACPI PCI support on your platform, sorry.
> 
> Lorenzo
> 

I just want to make sure I interpret this properly. This means if the 
PCIe controller hardware does not support ECAM, there's pretty much no 
way around it with SW based workaround going forward with mainline kernel?

What about for the PCIe controller that was designed a few years back?

Thanks,

Ray
