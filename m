Return-Path: <SRS0=S67v=5S=arm.com=marc.zyngier@kernel.org>
Return-Path: <SRS0=S67v=5S=arm.com=marc.zyngier@kernel.org>
Subject: Re: [PATCH v6 3/3] PCI: Add tango MSI controller support
To: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
 Thomas Gleixner <tglx@linutronix.de>
References: <741766e5-cff2-db5f-d40b-6866e08fd966@sigmadesigns.com>
 <e868f9b8-39e3-4501-a8c6-64bd28a4be8b@sigmadesigns.com>
 <9975fa6c-f426-519b-6b3e-a2d102d36fd5@arm.com>
 <82d6bf37-96b9-cd9d-134b-f01638fa2b1b@sigmadesigns.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, David Laight <david.laight@aculab.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, Mason <slash.tmp@free.fr>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <d39b5b3a-48be-7aaa-b7dd-28d4ae1d2083@arm.com>
Date: Tue, 13 Jun 2017 15:22:39 +0100
MIME-Version: 1.0
In-Reply-To: <82d6bf37-96b9-cd9d-134b-f01638fa2b1b@sigmadesigns.com>
Content-Type: text/plain; charset=iso-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 13/06/17 15:01, Marc Gonzalez wrote:
> The MSI controller in Tango supports 256 message-signaled interrupts,
> and a single doorbell address.
> 
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> ---
> Changes from v5 to v6
> o Rename 'used' bitmap to 'used_msi'
> o Rename 'lock' spinlock to 'used_msi_lock'
> o Take lock in interrupt handler
> o Remove irq_dom in error path
> ---
>  drivers/pci/host/pcie-tango.c | 225 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 225 insertions(+)
> 
> diff --git a/drivers/pci/host/pcie-tango.c b/drivers/pci/host/pcie-tango.c
> index 67aaadcc1c5e..b06446b23bc8 100644
> --- a/drivers/pci/host/pcie-tango.c
> +++ b/drivers/pci/host/pcie-tango.c
> @@ -1,16 +1,228 @@
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/irqdomain.h>
>  #include <linux/pci-ecam.h>
>  #include <linux/delay.h>
> +#include <linux/msi.h>
>  #include <linux/of.h>
>  
>  #define MSI_MAX 256
>  
>  #define SMP8759_MUX		0x48
>  #define SMP8759_TEST_OUT	0x74
> +#define SMP8759_STATUS		0x80
> +#define SMP8759_ENABLE		0xa0
> +#define SMP8759_DOORBELL	0xa002e07c
>  
>  struct tango_pcie {
> +	DECLARE_BITMAP(used_msi, MSI_MAX);
> +	spinlock_t used_msi_lock;
>  	void __iomem *mux;
> +	void __iomem *msi_status;
> +	void __iomem *msi_enable;
> +	phys_addr_t msi_doorbell;
> +	struct irq_domain *irq_dom;
> +	struct irq_domain *msi_dom;
> +	int irq;
>  };
>  
> +/*** MSI CONTROLLER SUPPORT ***/
> +
> +static void tango_msi_isr(struct irq_desc *desc)
> +{
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	struct tango_pcie *pcie = irq_desc_get_handler_data(desc);
> +	unsigned long flags, status, base, virq, idx, pos = 0;
> +
> +	chained_irq_enter(chip, desc);
> +	spin_lock_irqsave(&pcie->used_msi_lock, flags);

You're already in interrupt context, so there is no need to disable
interrupts any further. spin_lock() should do the trick

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
