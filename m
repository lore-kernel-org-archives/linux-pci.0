Return-Path: <SRS0=Lhk4=5F=sigmadesigns.com=marc_gonzalez@kernel.org>
Return-Path: <SRS0=Lhk4=5F=sigmadesigns.com=marc_gonzalez@kernel.org>
Subject: Re: [PATCH v4 1/2] PCI: Add tango MSI controller support
To: Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>
CC: Bjorn Helgaas <helgaas@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Liviu Dudau
	<liviu.dudau@arm.com>, David Laight <david.laight@aculab.com>, linux-pci
	<linux-pci@vger.kernel.org>, Linux ARM
	<linux-arm-kernel@lists.infradead.org>, Thibaud Cornic
	<thibaud_cornic@sigmadesigns.com>, Phuong Nguyen
	<phuong_nguyen@sigmadesigns.com>, LKML <linux-kernel@vger.kernel.org>, Mason
	<slash.tmp@free.fr>
References: <d054300a-5891-0a25-8726-2be6b1beff6c@sigmadesigns.com>
 <1f6b50c7-4887-838e-8c7d-c014d82b6d8e@sigmadesigns.com>
 <8ee14bdc-a272-d483-bc2b-d1840aaebb24@arm.com>
From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Message-ID: <0a8abf10-bf0b-88ae-64c5-5ad1815cbec6@sigmadesigns.com>
Date: Wed, 31 May 2017 09:32:12 +0200
MIME-Version: 1.0
In-Reply-To: <8ee14bdc-a272-d483-bc2b-d1840aaebb24@arm.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 25/05/2017 10:37, Marc Zyngier wrote:

> On 20/04/17 15:28, Marc Gonzalez wrote:
>
>> The MSI controller in Tango supports 256 message-signaled interrupts,
>> and a single doorbell address.
>>
>> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
>> ---
>>  drivers/pci/host/pcie-tango.c | 232 +++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++
>>  1 file changed, 232 insertions(+)
>>
>> diff --git a/drivers/pci/host/pcie-tango.c b/drivers/pci/host/pcie-tango=
.c
>> new file mode 100644
>> index 000000000000..ada8d35066ab
>> --- /dev/null
>> +++ b/drivers/pci/host/pcie-tango.c
>=20
> As Bjorn mentioned elsewhere, the ordering of the patch is backward.
> Please have the PCIe host controller driver in the first patch, then the
> MSI stuff. Otherwise, it is impossible to see how the various bits are
> wired.

Done.

> And please have a separate patch the the DT binding, which needs
> separate Acks from the DT folks.

Done.

>> @@ -0,0 +1,232 @@
>> +#include <linux/irqchip/chained_irq.h>
>> +#include <linux/irqdomain.h>
>> +#include <linux/pci-ecam.h>
>> +#include <linux/delay.h>
>> +#include <linux/msi.h>
>> +
>> +#define MSI_MAX 256
>> +
>> +struct tango_pcie {
>> +=09DECLARE_BITMAP(bitmap, MSI_MAX);
>> +=09spinlock_t lock;
>> +=09void __iomem *mux;
>> +=09void __iomem *msi_status;
>> +=09void __iomem *msi_enable;
>> +=09phys_addr_t msi_doorbell;
>=20
> Init of these three fields should be in this patch.

Done.

>> +=09struct irq_domain *irq_dom;
>> +=09struct irq_domain *msi_dom;
>> +=09int irq;
>> +};
>> +
>> +/*** MSI CONTROLLER SUPPORT ***/
>> +
>> +static void dispatch(struct tango_pcie *pcie, unsigned long status, int=
 base)
>> +{
>> +=09unsigned int pos, virq;
>> +
>> +=09for_each_set_bit(pos, &status, 32) {
>> +=09=09virq =3D irq_find_mapping(pcie->irq_dom, base + pos);
>> +=09=09generic_handle_irq(virq);
>> +=09}
>> +}
>> +
>> +static void tango_msi_isr(struct irq_desc *desc)
>> +{
>> +=09struct irq_chip *chip =3D irq_desc_get_chip(desc);
>> +=09struct tango_pcie *pcie =3D irq_desc_get_handler_data(desc);
>> +=09unsigned int status, base, pos =3D 0;
>> +
>> +=09chained_irq_enter(chip, desc);
>> +
>> +=09while ((pos =3D find_next_bit(pcie->bitmap, MSI_MAX, pos)) < MSI_MAX=
) {
>> +=09=09base =3D round_down(pos, 32);
>> +=09=09status =3D readl_relaxed(pcie->msi_status + base / 8);
>> +=09=09dispatch(pcie, status, base);
>=20
> Just inline dispatch here.

Done.

>> +=09=09pos =3D base + 32;
>> +=09}
>> +
>> +=09chained_irq_exit(chip, desc);
>> +}
>> +
>> +static void tango_ack(struct irq_data *data)
>> +{
>> +=09u32 bit =3D BIT(data->hwirq);
>=20
> How does this work when hwirq is >=3D 32 (from what I gather, it can rang=
e
> from 0 to 255...).

It blows up. Fixed now.

>> +=09struct tango_pcie *pcie =3D irq_data_get_irq_chip_data(data);
>> +
>> +=09writel_relaxed(bit, pcie->msi_status);
>> +}
>> +
>> +static void update_msi_enable(struct irq_data *data, bool unmask)
>> +{
>> +=09unsigned long flags;
>> +=09u32 val, bit =3D BIT(data->hwirq % 32);
>> +=09int byte_offset =3D (data->hwirq / 32) * 4;
>> +=09struct tango_pcie *pcie =3D data->chip_data;
>> +
>> +=09spin_lock_irqsave(&pcie->lock, flags);
>> +=09val =3D readl_relaxed(pcie->msi_enable + byte_offset);
>=20
> As I already mentioned in one of the previous series, this is a fairly
> pointless MMIO access. You could maintain a SW version of the enable
> register, update that copy and write it.
>=20
> But that's only a performance optimization, and it won't affect the
> behaviour. Your call.

Thanks for pointing it out.
I'll implement the optimization in a future patch.

>> +=09val =3D unmask ? val | bit : val & ~bit;
>> +=09writel_relaxed(val, pcie->msi_enable + byte_offset);
>> +=09spin_unlock_irqrestore(&pcie->lock, flags);
>> +}
>> +
>> +static void tango_mask(struct irq_data *data)
>> +{
>> +=09update_msi_enable(data, false);
>> +}
>> +
>> +static void tango_unmask(struct irq_data *data)
>> +{
>> +=09update_msi_enable(data, true);
>> +}
>> +
>> +static int tango_set_affinity(struct irq_data *data,
>> +=09=09const struct cpumask *mask, bool force)
>> +{
>> +=09return -EINVAL;
>> +}
>> +
>> +static void tango_compose_msi_msg(struct irq_data *data, struct msi_msg=
 *msg)
>> +{
>> +=09struct tango_pcie *pcie =3D irq_data_get_irq_chip_data(data);
>> +
>> +=09msg->address_lo =3D lower_32_bits(pcie->msi_doorbell);
>> +=09msg->address_hi =3D upper_32_bits(pcie->msi_doorbell);
>> +=09msg->data =3D data->hwirq;
>> +}
>> +
>> +static struct irq_chip tango_chip =3D {
>> +=09.irq_ack=09=09=3D tango_ack,
>> +=09.irq_mask=09=09=3D tango_mask,
>> +=09.irq_unmask=09=09=3D tango_unmask,
>> +=09.irq_set_affinity=09=3D tango_set_affinity,
>> +=09.irq_compose_msi_msg=09=3D tango_compose_msi_msg,
>> +};
>> +
>> +static void msi_ack(struct irq_data *data)
>> +{
>> +=09irq_chip_ack_parent(data);
>> +}
>> +
>> +static void msi_mask(struct irq_data *data)
>> +{
>> +=09pci_msi_mask_irq(data);
>> +=09irq_chip_mask_parent(data);
>> +}
>> +
>> +static void msi_unmask(struct irq_data *data)
>> +{
>> +=09pci_msi_unmask_irq(data);
>> +=09irq_chip_unmask_parent(data);
>> +}
>> +
>> +static struct irq_chip msi_chip =3D {
>> +=09.name =3D "MSI",
>> +=09.irq_ack =3D msi_ack,
>> +=09.irq_mask =3D msi_mask,
>> +=09.irq_unmask =3D msi_unmask,
>> +};
>> +
>> +static struct msi_domain_info msi_dom_info =3D {
>> +=09.flags=09=3D MSI_FLAG_PCI_MSIX
>> +=09=09| MSI_FLAG_USE_DEF_DOM_OPS
>> +=09=09| MSI_FLAG_USE_DEF_CHIP_OPS,
>> +=09.chip=09=3D &msi_chip,
>> +};
>> +
>> +static int find_free_msi(struct irq_domain *dom, unsigned int virq)
>> +{
>> +=09unsigned int pos;
>> +=09struct tango_pcie *pcie =3D dom->host_data;
>> +
>> +=09pos =3D find_first_zero_bit(pcie->bitmap, MSI_MAX);
>> +=09if (pos >=3D MSI_MAX)
>> +=09=09return -ENOSPC;
>> +=09__set_bit(pos, pcie->bitmap);
>> +
>> +=09irq_domain_set_info(dom, virq, pos, &tango_chip, pcie,
>> +=09=09=09handle_edge_irq, NULL, NULL);
>> +
>> +=09return 0;
>> +}
>> +
>> +static int tango_irq_domain_alloc(struct irq_domain *dom,
>> +=09=09unsigned int virq, unsigned int nr_irqs, void *args)
>> +{
>> +=09int err;
>> +=09unsigned long flags;
>> +=09struct tango_pcie *pcie =3D dom->host_data;
>> +
>> +=09spin_lock_irqsave(&pcie->lock, flags);
>> +=09err =3D find_free_msi(dom, virq);
>=20
> Just inline find_free_msi here. it is not called from anywhere else, and
> seeing the locking close to the use of the bitmap is definitely better.

Done.

>> +=09spin_unlock_irqrestore(&pcie->lock, flags);
>> +
>> +=09return err;
>> +}
>> +
>> +static void tango_irq_domain_free(struct irq_domain *dom,
>> +=09=09unsigned int virq, unsigned int nr_irqs)
>> +{
>> +=09unsigned long flags;
>> +=09struct irq_data *data =3D irq_domain_get_irq_data(dom, virq);
>> +=09struct tango_pcie *pcie =3D irq_data_get_irq_chip_data(data);
>> +
>> +=09spin_lock_irqsave(&pcie->lock, flags);
>> +=09__clear_bit(data->hwirq, pcie->bitmap);
>> +=09spin_unlock_irqrestore(&pcie->lock, flags);
>> +}
>> +
>> +static const struct irq_domain_ops irq_dom_ops =3D {
>> +=09.alloc=09=3D tango_irq_domain_alloc,
>> +=09.free=09=3D tango_irq_domain_free,
>> +};
>> +
>> +static int tango_msi_remove(struct platform_device *pdev)
>> +{
>> +=09struct tango_pcie *pcie =3D platform_get_drvdata(pdev);
>> +
>> +=09irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
>> +=09irq_domain_remove(pcie->msi_dom);
>> +=09irq_domain_remove(pcie->irq_dom);
>> +
>> +=09return 0;
>> +}
>> +
>> +static int tango_msi_probe(struct platform_device *pdev, struct tango_p=
cie *pcie)
>> +{
>> +=09int i, virq;
>> +=09struct irq_domain *msi_dom, *irq_dom;
>> +=09struct fwnode_handle *fwnode =3D of_node_to_fwnode(pdev->dev.of_node=
);
>> +
>> +=09spin_lock_init(&pcie->lock);
>> +=09for (i =3D 0; i < MSI_MAX / 32; ++i)
>> +=09=09writel_relaxed(0, pcie->msi_enable + i * 4);
>> +
>> +=09irq_dom =3D irq_domain_create_linear(fwnode, MSI_MAX, &irq_dom_ops, =
pcie);
>> +=09if (!irq_dom) {
>> +=09=09pr_err("Failed to create IRQ domain\n");
>> +=09=09return -ENOMEM;
>> +=09}
>> +
>> +=09msi_dom =3D pci_msi_create_irq_domain(fwnode, &msi_dom_info, irq_dom=
);
>> +=09if (!msi_dom) {
>> +=09=09pr_err("Failed to create MSI domain\n");
>> +=09=09irq_domain_remove(irq_dom);
>> +=09=09return -ENOMEM;
>> +=09}
>> +
>> +=09virq =3D platform_get_irq(pdev, 1);
>> +=09if (virq <=3D 0) {
>> +=09=09pr_err("Failed to map IRQ\n");
>> +=09=09irq_domain_remove(msi_dom);
>> +=09=09irq_domain_remove(irq_dom);
>> +=09=09return -ENXIO;
>> +=09}
>=20
> Maybe start the probe with this. No need to start allocating data
> structures if the DT is wrong.

Done.
