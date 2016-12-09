Return-Path: <SRS0=bp2I=XY=arm.com=marc.zyngier@kernel.org>
Return-Path: <SRS0=bp2I=XY=arm.com=marc.zyngier@kernel.org>
Subject: Re: ATH9 driver issues on ARM64
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 Bjorn Helgaas <helgaas@kernel.org>
References: <8520D5D51A55D047800579B094147198263A7222@XAP-PVEXMBX02.xlnx.xilinx.com>
 <20161208145608.GA19822@bhelgaas-glaptop.roam.corp.google.com>
 <8520D5D51A55D047800579B094147198263A72F5@XAP-PVEXMBX02.xlnx.xilinx.com>
 <48ec7cdf-5a5f-bd4a-3ba2-a7bb294e161f@arm.com>
 <8520D5D51A55D047800579B094147198263A77C5@XAP-PVEXMBX02.xlnx.xilinx.com>
 <6a718bb8-f827-8b7f-ac10-f924cbc5e463@arm.com>
 <8520D5D51A55D047800579B094147198263A79AC@XAP-PVEXMBX02.xlnx.xilinx.com>
 <d8bc6283-8b37-76d6-8ff1-0847ee015380@arm.com>
 <8520D5D51A55D047800579B094147198263A7F11@XAP-PVEXMBX02.xlnx.xilinx.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "Janusz.Dziedzic@tieto.com" <Janusz.Dziedzic@tieto.com>,
 "rmanohar@qti.qualcomm.com" <rmanohar@qti.qualcomm.com>,
 Kalle Valo <kvalo@codeaurora.org>,
 "ath9k-devel@qca.qualcomm.com" <ath9k-devel@qca.qualcomm.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <634133ba-f77e-bc80-751d-b77a7816dec4@arm.com>
Date: Fri, 9 Dec 2016 11:24:00 +0000
MIME-Version: 1.0
In-Reply-To: <8520D5D51A55D047800579B094147198263A7F11@XAP-PVEXMBX02.xlnx.xilinx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 09/12/16 11:04, Bharat Kumar Gogada wrote:
>> On 09/12/16 02:07, Bharat Kumar Gogada wrote:
>>>> On 08/12/16 18:33, Bharat Kumar Gogada wrote:
>>>>>> On 08/12/16 15:29, Bharat Kumar Gogada wrote:
>>>>>>> 218:         61          0          0          0     GICv2  81 Level     mmc0
>>>>>>> 219:          0          0          0          0     GICv2 187 Level     arm-smmu global
>> fault
>>>>>>> 220:        471          0          0          0     GICv2  53 Level     xuartps
>>>>>>> 223:          0          0          0          0     GICv2 154 Level     fd4c0000.dma
>>>>>>> 224:          3          0          0          0     dummy   1 Edge      ath9k
>>>>>>
>>>>>> What is this "dummy" controller? And if that's supposed to be a
>>>>>> legacy interrupt from the PCI device, it has the wrong trigger.
>>>>>
>>>>> Yes it is for legacy interrupt, wrong trigger means ?
>>>>
>>>> Aren't legacy interrupts supposed to be *level* triggered, and not edge?
>>>>
>>> Yes agreed.
>>> For legacy interrupts im using irq_set_chained_handler_and_data so the
>>> irq line between bridge and GIC Will not be shown here. The above how
>>> is virq for legacy, which is given by kernel, not sure why its state is set to edge.
>>
>> Well, you should try and find out. Edge triggering for legacy interrupts is a real
>> bug, and I don't think it has anything to do with arm64 (despite what the subject
>> says).
>>
> Thanks Marc. Here is the ARM32 bit log for cat /proc/interrupts, 
> Here also it shows edge but still scan works successfully.

Because it works doesn't mean it is right.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
