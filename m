Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <55B7C2D0.8080107@arm.com>
References: <1438080345-7233-1-git-send-email-lftan@altera.com>
	<1438080345-7233-5-git-send-email-lftan@altera.com>
	<55B7C2D0.8080107@arm.com>
Date: Wed, 29 Jul 2015 16:52:23 +0800
Message-ID: <CAFiDJ59kb=tDbnktmdF5r1_ShUfwvpxDQUtWV8LieS5Y=iVi4w@mail.gmail.com>
Subject: Re: [PATCH 4/6] pci: altera: Add Altera PCIe MSI driver
From: Ley Foon Tan <lftan@altera.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Dinh Nguyen <dinguyen@opensource.altera.com>,
	devicetree@vger.kernel.org,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	linux-pci@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 29, 2015 at 1:58 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Hi Ley,
>
> On 28/07/15 11:45, Ley Foon Tan wrote:
>> This patch adds Altera PCIe MSI driver. This soft IP supports configurable
>> number of vectors, which is a dts parameter.
>
> Can't you read this configuration from the HW?
No, we can't read from HW.


>>
>> Signed-off-by: Ley Foon Tan <lftan@altera.com>
>> ---
>>  drivers/pci/host/Kconfig           |   7 +
>>  drivers/pci/host/Makefile          |   1 +
>>  drivers/pci/host/pcie-altera-msi.c | 318 +++++++++++++++++++++++++++++++++++++
>>  3 files changed, 326 insertions(+)
>>  create mode 100644 drivers/pci/host/pcie-altera-msi.c
>>
>> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
>> index af19039..a8b87fd 100644
>> --- a/drivers/pci/host/Kconfig
>> +++ b/drivers/pci/host/Kconfig
>> @@ -154,4 +154,11 @@ config PCIE_ALTERA
>>         Say Y here if you want to enable PCIe controller support for Altera
>>         SoCFPGA family of SoCs.
>>
>> +config PCIE_ALTERA_MSI
>> +     bool "Altera PCIe MSI feature"
>> +     depends on PCI_MSI && PCIE_ALTERA
>
> What is the dependency with PCIE_ALTERA? Isn't that module standalone?
Theoretically it can work with other PCIe hosts. Will remove depends
PCIE_ALTERA.


>> +struct altera_msi {
>> +     DECLARE_BITMAP(used, MAX_MSI_VECTORS);
>> +     struct mutex            lock;   /* proctect used variable */
>> +     struct platform_device  *pdev;
>> +     struct irq_domain               *msi_domain;
>> +     void __iomem            *csr_base;
>> +     void __iomem            *vector_base;
>> +     u32                     vector_phy;
>
> This should be a phys_addr_t. Not everything is 32bit.
Noted.

>
>> +     u32                     num_of_vectors;
>> +     int                     irq;
>> +};
>> +
>> +static inline void msi_writel(struct altera_msi *msi, u32 value, u32 reg)
>> +{
>> +     writel(value, msi->csr_base + reg);
>
> You should be able to use the relaxed accessors.
Noted.

>
>> +}
>> +
>> +static inline u32 msi_readl(struct altera_msi *msi, u32 reg)
>> +{
>> +     return readl(msi->csr_base + reg);
>
> Same here.
Noted.


>> +             status = msi_readl(msi, MSI_STATUS);
>> +             if (!status)
>> +                     break;
>> +
>> +             do {
>> +                     offset = find_first_bit(&status, num_of_vectors);
>> +                     /* Dummy read from vector to clear the interrupt */
>> +                     readl(msi->vector_base + (offset * sizeof(u32)));
>
> readl_relaxed
Noted.

>
>> +
>> +                     irq = irq_find_mapping(msi->msi_domain->parent, offset);
>
> This would tend to indicate that you don't really need to store the
> msi_domain pointer, but the inner_domain pointer instead.
Will store the inner_domain pointer. But, I think we still need
msi_domain for irq_domain_remove.
Or do we have any way to retrieve msi_domain from inner_domain?

>
>> +                     if (irq) {
>> +                             if (test_bit(offset, msi->used))
>> +                                     generic_handle_irq(irq);
>> +                             else
>> +                                     dev_info(&msi->pdev->dev, "unhandled MSI\n");
>> +                     } else
>> +                             dev_info(&msi->pdev->dev, "unexpected MSI\n");
>> +
>> +                     /* Clear the bit from status and repeat without reading
>> +                      * again status register. */
>> +                     clear_bit(offset, &status);
>> +                     processed++;
>> +             } while (status);
>> +     } while (1);
>> +
>> +     return processed > 0 ? IRQ_HANDLED : IRQ_NONE;
>
> This shouldn't be a simple interrupt interrupt handler, but instead a
> chained irqchip. See pci-xgene-msi.c for an example of such a thing.
Noted, will change to use chained irqchip.

>
>> +}
>> +
>> +static struct irq_chip altera_msi_irq_chip = {
>> +     .name = "Altera PCIe MSI",
>> +     .irq_enable = pci_msi_unmask_irq,
>> +     .irq_disable = pci_msi_mask_irq,
>> +     .irq_mask = pci_msi_mask_irq,
>> +     .irq_unmask = pci_msi_unmask_irq,
>> +};
>> +
>> +static struct msi_domain_info altera_msi_domain_info = {
>> +     .flags  = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
>
> So you don't support MSIX? That's a bit weird.
Yes, this MSI IP doesn't support it.


>
>> +     .chip   = &altera_msi_irq_chip,
>> +};
>> +
>> +static void altera_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>> +{
>> +     struct altera_msi *msi = irq_data_get_irq_chip_data(data);
>> +     u32 mask;
>> +
>> +     msg->address_lo = msi->vector_phy + (data->hwirq * sizeof(u32));
>
> Each MSI has a separate doorbell? Interesting... Please use
> lower_32_bits on the above expression.
Correct. Will change to lower_32_bits.

>
>> +     /* 32 bit address only */
>> +     msg->address_hi = 0;
>
> So this HW will never be used in a 64bit platform? Oddly enough, I
> cannot believe it. Please use upper_32_bits() as the complement of the
> above. At least, we'll be future proof.
It can be used in 64 bits platform. Will change to use upper_32_bits() .

>
>> +     msg->data = data->hwirq;
>> +
>> +     mask = msi_readl(msi, MSI_INTMASK);
>> +     mask |= 1 << data->hwirq;
>> +     msi_writel(msi, mask, MSI_INTMASK);
>> +     dev_dbg(&msi->pdev->dev, "msi#%d address_lo 0x%x\n", (int)data->hwirq,
>> +             msg->address_lo);
>> +}
>> +
>> +static int altera_msi_set_affinity(struct irq_data *irq_data,
>> +                              const struct cpumask *mask, bool force)
>> +{
>> +      return irq_set_affinity(irq_data->hwirq, mask);
>
> There is no way this can be right. irq_data->hwirq can *never* be passed
> as a Linux IRQ. This really should be the IRQ to the GIC.
>
> Which raises another issue: as you only have a single interrupt to the
> GIC, changing the affinity of a single MSI is going to affect all the
> other MSIs as well. This doesn't seem like a desirable behaviour.
Do we must provide '.irq_set_affinity" callback to msi domain? I have
tried set it to NULL,
but kernel got the NULL pointer deference error from msi_domain_set_affinity().
Recently, I saw this new patch for pci-tegra.c from [1], it doesn't
set the ".irq_set_affinity".
Just wonder how it can work.

Do you have any recommendation way for this?

[1] https://git.kernel.org/cgit/linux/kernel/git/maz/arm-platforms.git/commit/drivers/pci/host?h=irq/gsi-irq-domain-v2&id=17c22fc4e60e6ad54c7e3b73868cbc057360fa63

>> +}
>> +
>> +static struct irq_chip altera_msi_bottom_irq_chip = {
>> +     .name                   = "Altera MSI",
>> +     .irq_compose_msi_msg    = altera_compose_msi_msg,
>> +     .irq_set_affinity       = altera_msi_set_affinity,
>> +};
>> +
>> +static int altera_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>> +                               unsigned int nr_irqs, void *args)
>> +{
>> +     struct altera_msi *msi = domain->host_data;
>> +     int bit;
>> +
>> +     mutex_lock(&msi->lock);
>> +
>> +     bit = find_first_zero_bit(msi->used, msi->num_of_vectors);
>> +     if (bit < msi->num_of_vectors)
>> +             set_bit(bit, msi->used);
>> +     else
>> +             bit = -ENOSPC;
>
> You can loose the "else" clause...
Okay. Will remove it.

>
>> +
>> +     mutex_unlock(&msi->lock);
>> +
>> +     if (bit < 0)
>> +             return bit;
>
> ... and test for bit >= msi->num_of_vectors, returning -ENOSPC if out of
> vectors.
Noted.


>> +int altera_msi_probe(struct platform_device *pdev)
>> +{
>> +     struct altera_msi *msi;
>> +     struct device_node *np = pdev->dev.of_node;
>> +     struct resource *res;
>> +     int ret;
>> +
>> +     msi = devm_kzalloc(&pdev->dev, sizeof(struct altera_msi),
>> +             GFP_KERNEL);
>> +     if (!msi)
>> +             return -ENOMEM;
>> +
>> +     mutex_init(&msi->lock);
>> +     msi->pdev = pdev;
>> +
>> +     res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "csr");
>> +     msi->csr_base = devm_ioremap_resource(&pdev->dev, res);
>> +     if (IS_ERR(msi->csr_base)) {
>> +             dev_err(&pdev->dev, "get csr resource failed\n");
>> +             return -EADDRNOTAVAIL;
>
> You're being quite creative when it comes to error codes. I'd expect
> this to be used for networking (pci-tegra also uses it, which is even
> more disturbing). I'd be more confident with an -ENOMEM.
Okay, will change it to -ENOMEM.

>
>> +     }
>> +
>> +     res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>> +                     "vector_slave");
>> +     msi->vector_base = devm_ioremap_resource(&pdev->dev, res);
>> +     if (IS_ERR(msi->vector_base)) {
>> +             dev_err(&pdev->dev, "get vector slave resource failed\n");
>> +             return -EADDRNOTAVAIL;
>> +     }
>> +
>> +     msi->vector_phy = res->start;
>> +
>> +     if (of_property_read_u32(np, "num-vectors", &msi->num_of_vectors)) {
>> +             dev_err(&pdev->dev, "failed to parse the number of vectors\n");
>> +             return -EINVAL;
>> +     }
>
> Since this is a configurable IP, you should have a register telling you
> the number of configured MSI, shouldn't you? Or is the HW really, really
> dumb?
Too bad we can't read it from HW.

>
>> +
>> +     ret = altera_allocate_domains(msi);
>> +     if (ret)
>> +             return ret;
>> +
>> +     msi->irq = platform_get_irq(pdev, 0);
>> +     if (msi->irq <= 0) {
>> +             dev_err(&pdev->dev, "failed to map IRQ: %d\n", msi->irq);
>> +             ret = -ENODEV;
>> +             goto err;
>> +     }
>> +
>> +     ret = devm_request_irq(&pdev->dev, msi->irq, altera_msi_isr, 0,
>> +                             altera_msi_irq_chip.name, msi);
>> +     if (ret) {
>> +             dev_err(&pdev->dev, "failed to request IRQ: %d\n", ret);
>> +             goto err;
>> +     }
>
> Turn this into a call to irq_set_chained_handler.
Noted.


>
>> +
>> +     platform_set_drvdata(pdev, msi);
>> +
>> +     return 0;
>> +
>> +err:
>> +     irq_domain_remove(msi->msi_domain);
>
> You're leaking the inner domain here.
Noted. Will change to altera_msi_remove() instead and eventually it
will remove inner_domain and msi_domain.


Thanks for reviewing.

Regards
Ley Foon
