Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53872 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754142AbcGKPuK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 11 Jul 2016 11:50:10 -0400
Subject: Re: PCIe MSI address is not written at pci_enable_msi_range call
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <8520D5D51A55D047800579B094147198258B80DE@XAP-PVEXMBX01.xlnx.xilinx.com>
 <57835D35.1000901@arm.com>
 <8520D5D51A55D047800579B094147198258B81DF@XAP-PVEXMBX01.xlnx.xilinx.com>
 <5783733C.70702@arm.com>
 <8520D5D51A55D047800579B094147198258B823D@XAP-PVEXMBX01.xlnx.xilinx.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	nofooter <nofooter@xilinx.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <5783C02F.7030901@arm.com>
Date: Mon, 11 Jul 2016 16:50:07 +0100
MIME-Version: 1.0
In-Reply-To: <8520D5D51A55D047800579B094147198258B823D@XAP-PVEXMBX01.xlnx.xilinx.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/07/16 11:51, Bharat Kumar Gogada wrote:
>>> Hi Marc,
>>>
>>> Thanks for the reply.
>>>
>>> From PCIe Spec:
>>> MSI Enable Bit:
>>> If 1 and the MSI-X Enable bit in the MSI-X Message
>>> Control register (see Section 6.8.2.3) is 0, the
>>> function is permitted to use MSI to request service
>>> and is prohibited from using its INTx# pin.
>>>
>>> From Endpoint perspective, MSI Enable = 1 indicates MSI can be used
>> which means MSI address and data fields are available/programmed.
>>>
>>> In our SoC whenever MSI Enable goes from 0 --> 1 the hardware latches
>> onto MSI address and MSI data values.
>>>
>>> With current MSI implementation in kernel, our SoC is latching on to
>> incorrect address and data values, as address/data
>>> are updated much later than MSI Enable bit.
>>
>> Interesting. It looks like we're doing something wrong in the MSI flow.
>> Can you confirm that this is limited to MSI and doesn't affect MSI-X?
>>
> I think it's the same issue irrespective of MSI or MSI-X as we are
> enabling these interrupts before providing the  vectors.
> 
> So we always have a hole when MSI/MSI-X is 1, and software driver has
> not registered the irq, and End Point may raise an interrupt (may be
> due to error) in this point of time.

Looking at the MSI-X part of the code, there is this:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/msi.c#n764

which hints that it may not be possible to do otherwise. Damned if you
do, damned if you don't.

	M.
-- 
Jazz is not dead. It just smells funny...
