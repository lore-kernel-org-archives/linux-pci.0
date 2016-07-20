Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41781 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751527AbcGTMTh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 20 Jul 2016 08:19:37 -0400
Subject: Re: PCIe MSI address is not written at pci_enable_msi_range call
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <8520D5D51A55D047800579B094147198258B80DE@XAP-PVEXMBX01.xlnx.xilinx.com>
 <57835D35.1000901@arm.com>
 <8520D5D51A55D047800579B094147198258B81DF@XAP-PVEXMBX01.xlnx.xilinx.com>
 <5785133A.6070908@arm.com>
 <8520D5D51A55D047800579B094147198258B8909@XAP-PVEXMBX01.xlnx.xilinx.com>
 <5785F8DC.4060100@arm.com>
 <8520D5D51A55D047800579B094147198258B896E@XAP-PVEXMBX01.xlnx.xilinx.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	nofooter <nofooter@xilinx.com>,
	Thomas Gleixner <tglx@linutronix.de>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <578F6C56.2090805@arm.com>
Date: Wed, 20 Jul 2016 13:19:34 +0100
MIME-Version: 1.0
In-Reply-To: <8520D5D51A55D047800579B094147198258B896E@XAP-PVEXMBX01.xlnx.xilinx.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

+tglx

On 13/07/16 09:33, Bharat Kumar Gogada wrote:
>> Subject: Re: PCIe MSI address is not written at pci_enable_msi_range call
>>
>> On 13/07/16 07:22, Bharat Kumar Gogada wrote:
>>>> Subject: Re: PCIe MSI address is not written at pci_enable_msi_range
>>>> call
>>>>
>>>> On 11/07/16 10:33, Bharat Kumar Gogada wrote:
>>>>> Hi Marc,
>>>>>
>>>>> Thanks for the reply.
>>>>>
>>>>> From PCIe Spec:
>>>>> MSI Enable Bit:
>>>>> If 1 and the MSI-X Enable bit in the MSI-X Message Control register
>>>>> (see Section 6.8.2.3) is 0, the function is permitted to use MSI to
>>>>> request service and is prohibited from using its INTx# pin.
>>>>>
>>>>> From Endpoint perspective, MSI Enable = 1 indicates MSI can be used
>>>> which means MSI address and data fields are available/programmed.
>>>>>
>>>>> In our SoC whenever MSI Enable goes from 0 --> 1 the hardware
>>>>> latches
>>>> onto MSI address and MSI data values.
>>>>>
>>>>> With current MSI implementation in kernel, our SoC is latching on to
>>>>> incorrect address and data values, as address/data are updated much
>>>>> later
>>>> than MSI Enable bit.
>>>>
>>>> As a side question, how does setting the affinity work on this
>>>> end-point if this involves changing the address programmed in the MSI
>> registers?
>>>> Do you expect the enabled bit to be toggled to around the write?
>>>>
>>>
>>> Yes,
>>
>> Well, that's pretty annoying, as this will not work either. But maybe your MSI
>> controller has a single doorbell? You haven't mentioned which HW that is...
>>
> The MSI address/data is located in config space, in our SoC for the logic behind PCIe
> to become aware of new address/data  MSI enable transition is used (0 to 1).
> The logic cannot keep polling these registers in configuration space as it would consume power.
> 
> So the logic uses the transition in MSI enable to latch on to address/data.

A couple of additional questions:

Does your HW support MSI masking? And if it does, does it resample the
address/data on unmask?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
