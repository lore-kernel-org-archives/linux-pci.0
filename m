Return-Path: <SRS0=S67v=5S=arm.com=marc.zyngier@kernel.org>
Return-Path: <SRS0=S67v=5S=arm.com=marc.zyngier@kernel.org>
Subject: Re: [PATCH v6 3/3] PCI: Add tango MSI controller support
To: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
 Thomas Gleixner <tglx@linutronix.de>
References: <741766e5-cff2-db5f-d40b-6866e08fd966@sigmadesigns.com>
 <e868f9b8-39e3-4501-a8c6-64bd28a4be8b@sigmadesigns.com>
 <9975fa6c-f426-519b-6b3e-a2d102d36fd5@arm.com>
 <82d6bf37-96b9-cd9d-134b-f01638fa2b1b@sigmadesigns.com>
 <d39b5b3a-48be-7aaa-b7dd-28d4ae1d2083@arm.com>
 <49b4138d-0030-1e8c-6a14-0e9151b63d24@sigmadesigns.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, David Laight <david.laight@aculab.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, Mason <slash.tmp@free.fr>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <1588fa00-92c6-046d-ccfc-9a2deae61486@arm.com>
Date: Tue, 13 Jun 2017 17:53:49 +0100
MIME-Version: 1.0
In-Reply-To: <49b4138d-0030-1e8c-6a14-0e9151b63d24@sigmadesigns.com>
Content-Type: text/plain; charset=iso-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 13/06/17 15:47, Marc Gonzalez wrote:
> On 13/06/2017 16:22, Marc Zyngier wrote:
>> On 13/06/17 15:01, Marc Gonzalez wrote:
>>> The MSI controller in Tango supports 256 message-signaled interrupts,
>>> and a single doorbell address.
>>>
>>> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
>>> ---
>>> Changes from v5 to v6
>>> o Rename 'used' bitmap to 'used_msi'
>>> o Rename 'lock' spinlock to 'used_msi_lock'
>>> o Take lock in interrupt handler
>>> o Remove irq_dom in error path
>>> ---
>>>  drivers/pci/host/pcie-tango.c | 225 ++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 225 insertions(+)
>>>
>>> diff --git a/drivers/pci/host/pcie-tango.c b/drivers/pci/host/pcie-tango.c
>>> index 67aaadcc1c5e..b06446b23bc8 100644
>>> --- a/drivers/pci/host/pcie-tango.c
>>> +++ b/drivers/pci/host/pcie-tango.c
>>> @@ -1,16 +1,228 @@
>>> +#include <linux/irqchip/chained_irq.h>
>>> +#include <linux/irqdomain.h>
>>>  #include <linux/pci-ecam.h>
>>>  #include <linux/delay.h>
>>> +#include <linux/msi.h>
>>>  #include <linux/of.h>
>>>  
>>>  #define MSI_MAX 256
>>>  
>>>  #define SMP8759_MUX		0x48
>>>  #define SMP8759_TEST_OUT	0x74
>>> +#define SMP8759_STATUS		0x80
>>> +#define SMP8759_ENABLE		0xa0
>>> +#define SMP8759_DOORBELL	0xa002e07c
>>>  
>>>  struct tango_pcie {
>>> +	DECLARE_BITMAP(used_msi, MSI_MAX);
>>> +	spinlock_t used_msi_lock;
>>>  	void __iomem *mux;
>>> +	void __iomem *msi_status;
>>> +	void __iomem *msi_enable;
>>> +	phys_addr_t msi_doorbell;
>>> +	struct irq_domain *irq_dom;
>>> +	struct irq_domain *msi_dom;
>>> +	int irq;
>>>  };
>>>  
>>> +/*** MSI CONTROLLER SUPPORT ***/
>>> +
>>> +static void tango_msi_isr(struct irq_desc *desc)
>>> +{
>>> +	struct irq_chip *chip = irq_desc_get_chip(desc);
>>> +	struct tango_pcie *pcie = irq_desc_get_handler_data(desc);
>>> +	unsigned long flags, status, base, virq, idx, pos = 0;
>>> +
>>> +	chained_irq_enter(chip, desc);
>>> +	spin_lock_irqsave(&pcie->used_msi_lock, flags);
>>
>> You're already in interrupt context, so there is no need to disable
>> interrupts any further. spin_lock() should do the trick
> 
> Thanks for the hint.
> 
> I am confused, because Documentation/locking/spinlocks.txt states:
> 
>> If you have a case where you have to protect a data structure across
>> several CPU's and you want to use spinlocks you can potentially use
>> cheaper versions of the spinlocks. IFF you know that the spinlocks are
>> never used in interrupt handlers, you can use the non-irq versions:
>>
>> 	spin_lock(&lock);
>> 	...
>> 	spin_unlock(&lock);
>>
>> (and the equivalent read-write versions too, of course). The spinlock will
>> guarantee the same kind of exclusive access, and it will be much faster.
>> This is useful if you know that the data in question is only ever
>> manipulated from a "process context", ie no interrupts involved.
>>
>> The reasons you mustn't use these versions if you have interrupts that
>> play with the spinlock is that you can get deadlocks:
>>
>> 	spin_lock(&lock);
>> 	...
>> 		<- interrupt comes in:
>> 			spin_lock(&lock);
>>
>> where an interrupt tries to lock an already locked variable. This is ok if
>> the other interrupt happens on another CPU, but it is _not_ ok if the
>> interrupt happens on the same CPU that already holds the lock, because the
>> lock will obviously never be released (because the interrupt is waiting
>> for the lock, and the lock-holder is interrupted by the interrupt and will
>> not continue until the interrupt has been processed).
>>
>> (This is also the reason why the irq-versions of the spinlocks only need
>> to disable the _local_ interrupts - it's ok to use spinlocks in interrupts
>> on other CPU's, because an interrupt on another CPU doesn't interrupt the
>> CPU that holds the lock, so the lock-holder can continue and eventually
>> releases the lock).
> 
> Isn't this saying that it is not safe to call spin_lock() from
> the interrupt handler? (Sorry if I misunderstood.)

It is saying exactly the opposite.

If you take a spinlock and can be interrupted by an interrupt that takes
the same spinlock, then you must use the irq-safe version *outside of
the interrupt handler*. That's because Linux interrupts are not
preemptible (well, in general -- it is different with RT, but let's not
get there). If you're guaranteed that no interrupt handler will take
this spinlock, then you don't have to use the irq-safe version.

	M.
-- 
Jazz is not dead. It just smells funny...
