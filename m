Return-Path: <SRS0=TnGP=5S=sigmadesigns.com=marc_gonzalez@kernel.org>
Return-Path: <SRS0=TnGP=5S=sigmadesigns.com=marc_gonzalez@kernel.org>
Subject: Re: [PATCH v6 3/3] PCI: Add tango MSI controller support
To: Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>
CC: Bjorn Helgaas <helgaas@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Liviu Dudau
	<liviu.dudau@arm.com>, David Laight <david.laight@aculab.com>, linux-pci
	<linux-pci@vger.kernel.org>, Linux ARM
	<linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>,
	Mason <slash.tmp@free.fr>
References: <741766e5-cff2-db5f-d40b-6866e08fd966@sigmadesigns.com>
 <e868f9b8-39e3-4501-a8c6-64bd28a4be8b@sigmadesigns.com>
 <9975fa6c-f426-519b-6b3e-a2d102d36fd5@arm.com>
 <82d6bf37-96b9-cd9d-134b-f01638fa2b1b@sigmadesigns.com>
 <d39b5b3a-48be-7aaa-b7dd-28d4ae1d2083@arm.com>
From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Message-ID: <49b4138d-0030-1e8c-6a14-0e9151b63d24@sigmadesigns.com>
Date: Tue, 13 Jun 2017 16:47:18 +0200
MIME-Version: 1.0
In-Reply-To: <d39b5b3a-48be-7aaa-b7dd-28d4ae1d2083@arm.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 13/06/2017 16:22, Marc Zyngier wrote:
> On 13/06/17 15:01, Marc Gonzalez wrote:
>> The MSI controller in Tango supports 256 message-signaled interrupts,
>> and a single doorbell address.
>>
>> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
>> ---
>> Changes from v5 to v6
>> o Rename 'used' bitmap to 'used_msi'
>> o Rename 'lock' spinlock to 'used_msi_lock'
>> o Take lock in interrupt handler
>> o Remove irq_dom in error path
>> ---
>>  drivers/pci/host/pcie-tango.c | 225 +++++++++++++++++++++++++++++++++++=
+++++++
>>  1 file changed, 225 insertions(+)
>>
>> diff --git a/drivers/pci/host/pcie-tango.c b/drivers/pci/host/pcie-tango=
.c
>> index 67aaadcc1c5e..b06446b23bc8 100644
>> --- a/drivers/pci/host/pcie-tango.c
>> +++ b/drivers/pci/host/pcie-tango.c
>> @@ -1,16 +1,228 @@
>> +#include <linux/irqchip/chained_irq.h>
>> +#include <linux/irqdomain.h>
>>  #include <linux/pci-ecam.h>
>>  #include <linux/delay.h>
>> +#include <linux/msi.h>
>>  #include <linux/of.h>
>> =20
>>  #define MSI_MAX 256
>> =20
>>  #define SMP8759_MUX=09=090x48
>>  #define SMP8759_TEST_OUT=090x74
>> +#define SMP8759_STATUS=09=090x80
>> +#define SMP8759_ENABLE=09=090xa0
>> +#define SMP8759_DOORBELL=090xa002e07c
>> =20
>>  struct tango_pcie {
>> +=09DECLARE_BITMAP(used_msi, MSI_MAX);
>> +=09spinlock_t used_msi_lock;
>>  =09void __iomem *mux;
>> +=09void __iomem *msi_status;
>> +=09void __iomem *msi_enable;
>> +=09phys_addr_t msi_doorbell;
>> +=09struct irq_domain *irq_dom;
>> +=09struct irq_domain *msi_dom;
>> +=09int irq;
>>  };
>> =20
>> +/*** MSI CONTROLLER SUPPORT ***/
>> +
>> +static void tango_msi_isr(struct irq_desc *desc)
>> +{
>> +=09struct irq_chip *chip =3D irq_desc_get_chip(desc);
>> +=09struct tango_pcie *pcie =3D irq_desc_get_handler_data(desc);
>> +=09unsigned long flags, status, base, virq, idx, pos =3D 0;
>> +
>> +=09chained_irq_enter(chip, desc);
>> +=09spin_lock_irqsave(&pcie->used_msi_lock, flags);
>=20
> You're already in interrupt context, so there is no need to disable
> interrupts any further. spin_lock() should do the trick

Thanks for the hint.

I am confused, because Documentation/locking/spinlocks.txt states:

> If you have a case where you have to protect a data structure across
> several CPU's and you want to use spinlocks you can potentially use
> cheaper versions of the spinlocks. IFF you know that the spinlocks are
> never used in interrupt handlers, you can use the non-irq versions:
>=20
> =09spin_lock(&lock);
> =09...
> =09spin_unlock(&lock);
>=20
> (and the equivalent read-write versions too, of course). The spinlock wil=
l
> guarantee the same kind of exclusive access, and it will be much faster.
> This is useful if you know that the data in question is only ever
> manipulated from a "process context", ie no interrupts involved.
>=20
> The reasons you mustn't use these versions if you have interrupts that
> play with the spinlock is that you can get deadlocks:
>=20
> =09spin_lock(&lock);
> =09...
> =09=09<- interrupt comes in:
> =09=09=09spin_lock(&lock);
>=20
> where an interrupt tries to lock an already locked variable. This is ok i=
f
> the other interrupt happens on another CPU, but it is _not_ ok if the
> interrupt happens on the same CPU that already holds the lock, because th=
e
> lock will obviously never be released (because the interrupt is waiting
> for the lock, and the lock-holder is interrupted by the interrupt and wil=
l
> not continue until the interrupt has been processed).
>=20
> (This is also the reason why the irq-versions of the spinlocks only need
> to disable the _local_ interrupts - it's ok to use spinlocks in interrupt=
s
> on other CPU's, because an interrupt on another CPU doesn't interrupt the
> CPU that holds the lock, so the lock-holder can continue and eventually
> releases the lock).

Isn't this saying that it is not safe to call spin_lock() from
the interrupt handler? (Sorry if I misunderstood.)

Regards.
