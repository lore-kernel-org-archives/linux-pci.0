Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] PCI: mediatek: Clear IRQ status after IRQ
 dispatched to avoid reentry
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        honghui.zhang@mediatek.com
Cc: bhelgaas@google.com, matthias.bgg@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        ryder.lee@mediatek.com, hongkun.cao@mediatek.com,
        youlin.pei@mediatek.com, yong.wu@mediatek.com,
        yt.shen@mediatek.com, sean.wang@mediatek.com,
        xinping.qian@mediatek.com
References: <1514336394-17747-1-git-send-email-honghui.zhang@mediatek.com>
 <1514336394-17747-2-git-send-email-honghui.zhang@mediatek.com>
 <20180104184040.GE12239@red-moon>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <88c84a3e-17ea-08f2-e5fc-4799b41de267@arm.com>
Date: Thu, 4 Jan 2018 19:04:01 +0000
MIME-Version: 1.0
In-Reply-To: <20180104184040.GE12239@red-moon>
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/01/18 18:40, Lorenzo Pieralisi wrote:
> [+Marc]
> 
> On Wed, Dec 27, 2017 at 08:59:53AM +0800, honghui.zhang@mediatek.com wrote:
>> From: Honghui Zhang <honghui.zhang@mediatek.com>
>>
>> There maybe a same IRQ reentry scenario after IRQ received in current
>> IRQ handle flow:
>> 	EP device		PCIe host driver	EP driver
>> 1. issue an IRQ
>> 			2. received IRQ
>> 			3. clear IRQ status
>> 			4. dispatch IRQ
>> 						5. clear IRQ source
>> The IRQ status was not successfully cleared at step 2 since the IRQ
>> source was not cleared yet. So the PCIe host driver may receive the
>> same IRQ after step 5. Then there's an IRQ reentry occurred.
>> Even worse, if the reentry IRQ was not an IRQ that EP driver expected,
>> it may not handle the IRQ. Then we may run into the infinite loop from
>> step 2 to step 4.
>> Clear the IRQ status after IRQ have been dispatched to avoid the IRQ
>> reentry.
>> This patch also fix another INTx IRQ issue by initialize the iterate
>> before the loop. If an INTx IRQ re-occurred while we are dispatching
>> the INTx IRQ, then iterate may start from PCI_NUM_INTX + INTX_SHIFT
>> instead of INTX_SHIFT for the second time entering the
>> for_each_set_bit_from() loop.
> 
> This looks like two different issues that should be fixed with two
> patches.
> 
>> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
>> Acked-by: Ryder Lee <ryder.lee@mediatek.com>
>> ---
>>  drivers/pci/host/pcie-mediatek.c | 11 ++++++-----
>>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> For the sake of uniformity, I first want to understand why this
> driver does not call:
> 
> chained_irq_enter/exit()
> 
> in the primary handler (mtk_pcie_intr_handler()).
> 
> With the GIC as a primary interrupt controller we have not
> even figured out how current code can actually work without
> calling the chained_* API.
> 
> I want to come up with a consistent handling of IRQ domains for
> all host bridges and any discrepancy should be explained.

That's because this driver is a huge hack, see below:

> 
>> diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
>> index db93efd..fc29a9a 100644
>> --- a/drivers/pci/host/pcie-mediatek.c
>> +++ b/drivers/pci/host/pcie-mediatek.c
>> @@ -601,15 +601,16 @@ static irqreturn_t mtk_pcie_intr_handler(int irq, void *data)

This function is not a chained irqchip, but an interrupt handler...

>>  	struct mtk_pcie_port *port = (struct mtk_pcie_port *)data;
>>  	unsigned long status;
>>  	u32 virq;
>> -	u32 bit = INTX_SHIFT;
>> +	u32 bit;
>>  
>>  	while ((status = readl(port->base + PCIE_INT_STATUS)) & INTX_MASK) {
>> +		bit = INTX_SHIFT;
>>  		for_each_set_bit_from(bit, &status, PCI_NUM_INTX + INTX_SHIFT) {
>> -			/* Clear the INTx */
>> -			writel(1 << bit, port->base + PCIE_INT_STATUS);
>>  			virq = irq_find_mapping(port->irq_domain,
>>  						bit - INTX_SHIFT);
>>  			generic_handle_irq(virq);

and nonetheless, this calls into generic_handle_irq(). That's a complete
violation of the interrupt layering. Maybe there is a good reason for
it, but I'd like to know which one.

Which means that all of the ack/mask has to be done outside of the
irqchip framework too... Disgusting.

>> +			/* Clear the INTx */
>> +			writel(1 << bit, port->base + PCIE_INT_STATUS);
> 
> I think that these masking/acking should actually be done through
> the irq_chip hooks (see for instance pci-ftpci100.c) - that would
> make this kind of bugs much easier to prevent (because the IRQ
> layer does the sequencing for you).

+1.

> Marc (CC'ed) has a more comprehensive view on this than me - I would
> like to get to a point where all host bridges uses a consistent
> approach for chained IRQ handling and I hope this bug fix can be
> a starting point.

+1 again. We definitely need to come up with some form of common
approach for all these host drivers, and maybe turn that into a library...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
