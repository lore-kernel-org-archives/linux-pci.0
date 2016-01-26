Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-cys01nam02on0043.outbound.protection.outlook.com ([104.47.37.43]:47474
	"EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932659AbcAZPVy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 26 Jan 2016 10:21:54 -0500
Subject: Re: [PATCH V2 3/5] PCI: xilinx: Modifying AXI PCIe Host Bridge driver
 to work on both Zynq and Microblaze
To: Arnd Bergmann <arnd@arndb.de>,
	Michal Simek <michal.simek@xilinx.com>
References: <1452620173-4905-1-git-send-email-bharatku@xilinx.com>
 <4734542.KZZp0TeeeM@wuerfel> <56A74370.4090000@xilinx.com>
 <2270955.TlqP7HlQk4@wuerfel>
CC: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	<bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
	<paul.burton@imgtec.com>, <yinghai@kernel.org>,
	<wangyijing@huawei.com>, <robh@kernel.org>,
	<russell.joyce@york.ac.uk>, <sorenb@xilinx.com>,
	<jiang.liu@linux.intel.com>, <pawel.moll@arm.com>,
	<mark.rutland@arm.com>, <ijc+devicetree@hellion.org.uk>,
	<galak@codeaurora.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	"Bharat Kumar Gogada" <bharatku@xilinx.com>,
	Ravi Kiran Gummaluri <rgummal@xilinx.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <56A78EFF.1010503@xilinx.com>
Date: Tue, 26 Jan 2016 16:21:35 +0100
MIME-Version: 1.0
In-Reply-To: <2270955.TlqP7HlQk4@wuerfel>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 26.1.2016 13:11, Arnd Bergmann wrote:
> On Tuesday 26 January 2016 10:59:12 Michal Simek wrote:
>>>> diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
>>>> index 3e3757f..1981948 100644
>>>> --- a/drivers/pci/host/pcie-xilinx.c
>>>> +++ b/drivers/pci/host/pcie-xilinx.c
>>>> @@ -92,7 +92,12 @@
>>>>  #define ECAM_DEV_NUM_SHIFT          12
>>>>  
>>>>  /* Number of MSI IRQs */
>>>> -#define XILINX_NUM_MSI_IRQS         128
>>>> +#define XILINX_NUM_MSI_IRQS 128
>>>> +#ifdef CONFIG_ARM
>>>> +#define TOT_NR_IRQS         XILINX_NUM_MSI_IRQS
>>>> +#else
>>>> +#define TOT_NR_IRQS         (NR_IRQS + XILINX_NUM_MSI_IRQS)
>>>> +#endif
>>>
>>> Something looks wrong here in the microblaze variant. What does NR_IRQS
>>> have to do with it?
>>
>> Arnd: What was the story regarding NR_IRQS?
>> I remember some discussion about it but just forget.
>>
>> Default value in include/asm-generic/irq.h is 64.
>> Current value is 32 because microblaze primary interrupt controller is
>> axi_intc core which has up to 32 input lines.
> 
> The value in asm-generic is completely arbitrary, it's just something
> that happens to work for a number of the simpler architectures.
> 
> Traditionally, there is a a fixed NR_IRQS which defines the maximum
> number of interrupts that can be used, and each irqchip has a fixed
> start offset below that number.
> 
> On modern systems, you have CONFIG_SPARSE_IRQ, which lets an irqchip
> allocate its own interrupts, without an upper limit. This is more
> flexible and avoids preallocating space for all irq_desc instances,
> so it saves memory.

ok. That was the story. I will look if there is any issue to enable
SPARSE_IRQ for Microblaze.

I also need to move intc driver out of arch.

Thanks,
Michal
