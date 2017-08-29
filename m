Return-Path: <SRS0=XMcr=77=sigmadesigns.com=marc_gonzalez@kernel.org>
Return-Path: <SRS0=XMcr=77=sigmadesigns.com=marc_gonzalez@kernel.org>
Subject: [PATCH v11 3/3] PCI: tango: Add MSI controller support
From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>
CC: linux-pci <linux-pci@vger.kernel.org>, Linux ARM
	<linux-arm-kernel@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>, Thibaud Cornic
	<thibaud_cornic@sigmadesigns.com>, Mason <slash.tmp@free.fr>
References: <f10055cc-4430-ff30-f892-3d3d6f24354c@sigmadesigns.com>
Message-ID: <7217503d-5996-f43f-ee56-1b7719d8ac8a@sigmadesigns.com>
Date: Tue, 29 Aug 2017 16:32:35 +0200
MIME-Version: 1.0
In-Reply-To: <f10055cc-4430-ff30-f892-3d3d6f24354c@sigmadesigns.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

The MSI controller in Tango supports 256 message-signaled interrupts
and a single doorbell address.

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
Changes from v10 to v11
* Discover msi_doorbell in probe by parsing dma-ranges
---
 drivers/pci/host/pcie-tango.c | 205 ++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 202 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-tango.c b/drivers/pci/host/pcie-tango.c
index 6bbb81f06a53..e23f7383ac33 100644
--- a/drivers/pci/host/pcie-tango.c
+++ b/drivers/pci/host/pcie-tango.c
@@ -1,12 +1,172 @@
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
 #include <linux/pci-ecam.h>
 #include <linux/delay.h>
-#include <linux/of.h>
+#include <linux/msi.h>
+#include <linux/of_address.h>
+
+#define MSI_MAX=09=09=09256
=20
 #define SMP8759_MUX=09=090x48
 #define SMP8759_TEST_OUT=090x74
+#define SMP8759_DOORBELL=090x7c
+#define SMP8759_STATUS=09=090x80
+#define SMP8759_ENABLE=09=090xa0
=20
 struct tango_pcie {
-=09void __iomem *base;
+=09DECLARE_BITMAP(used_msi, MSI_MAX);
+=09u64=09=09=09msi_doorbell;
+=09spinlock_t=09=09used_msi_lock;
+=09void __iomem=09=09*base;
+=09struct irq_domain=09*dom;
+};
+
+static void tango_msi_isr(struct irq_desc *desc)
+{
+=09struct irq_chip *chip =3D irq_desc_get_chip(desc);
+=09struct tango_pcie *pcie =3D irq_desc_get_handler_data(desc);
+=09unsigned long status, base, virq, idx, pos =3D 0;
+
+=09chained_irq_enter(chip, desc);
+=09spin_lock(&pcie->used_msi_lock);
+
+=09while ((pos =3D find_next_bit(pcie->used_msi, MSI_MAX, pos)) < MSI_MAX)=
 {
+=09=09base =3D round_down(pos, 32);
+=09=09status =3D readl_relaxed(pcie->base + SMP8759_STATUS + base / 8);
+=09=09for_each_set_bit(idx, &status, 32) {
+=09=09=09virq =3D irq_find_mapping(pcie->dom, base + idx);
+=09=09=09generic_handle_irq(virq);
+=09=09}
+=09=09pos =3D base + 32;
+=09}
+
+=09spin_unlock(&pcie->used_msi_lock);
+=09chained_irq_exit(chip, desc);
+}
+
+static void tango_ack(struct irq_data *d)
+{
+=09struct tango_pcie *pcie =3D d->chip_data;
+=09u32 offset =3D (d->hwirq / 32) * 4;
+=09u32 bit =3D BIT(d->hwirq % 32);
+
+=09writel_relaxed(bit, pcie->base + SMP8759_STATUS + offset);
+}
+
+static void update_msi_enable(struct irq_data *d, bool unmask)
+{
+=09unsigned long flags;
+=09struct tango_pcie *pcie =3D d->chip_data;
+=09u32 offset =3D (d->hwirq / 32) * 4;
+=09u32 bit =3D BIT(d->hwirq % 32);
+=09u32 val;
+
+=09spin_lock_irqsave(&pcie->used_msi_lock, flags);
+=09val =3D readl_relaxed(pcie->base + SMP8759_ENABLE + offset);
+=09val =3D unmask ? val | bit : val & ~bit;
+=09writel_relaxed(val, pcie->base + SMP8759_ENABLE + offset);
+=09spin_unlock_irqrestore(&pcie->used_msi_lock, flags);
+}
+
+static void tango_mask(struct irq_data *d)
+{
+=09update_msi_enable(d, false);
+}
+
+static void tango_unmask(struct irq_data *d)
+{
+=09update_msi_enable(d, true);
+}
+
+static int tango_set_affinity(struct irq_data *d, const struct cpumask *ma=
sk,
+=09=09=09      bool force)
+{
+=09return -EINVAL;
+}
+
+static void tango_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
+{
+=09struct tango_pcie *pcie =3D d->chip_data;
+=09msg->address_lo =3D lower_32_bits(pcie->msi_doorbell);
+=09msg->address_hi =3D upper_32_bits(pcie->msi_doorbell);
+=09msg->data =3D d->hwirq;
+}
+
+static struct irq_chip tango_chip =3D {
+=09.irq_ack=09=09=3D tango_ack,
+=09.irq_mask=09=09=3D tango_mask,
+=09.irq_unmask=09=09=3D tango_unmask,
+=09.irq_set_affinity=09=3D tango_set_affinity,
+=09.irq_compose_msi_msg=09=3D tango_compose_msi_msg,
+};
+
+static void msi_ack(struct irq_data *d)
+{
+=09irq_chip_ack_parent(d);
+}
+
+static void msi_mask(struct irq_data *d)
+{
+=09pci_msi_mask_irq(d);
+=09irq_chip_mask_parent(d);
+}
+
+static void msi_unmask(struct irq_data *d)
+{
+=09pci_msi_unmask_irq(d);
+=09irq_chip_unmask_parent(d);
+}
+
+static struct irq_chip msi_chip =3D {
+=09.name =3D "MSI",
+=09.irq_ack =3D msi_ack,
+=09.irq_mask =3D msi_mask,
+=09.irq_unmask =3D msi_unmask,
+};
+
+static struct msi_domain_info msi_dom_info =3D {
+=09.flags=09=3D MSI_FLAG_PCI_MSIX
+=09=09| MSI_FLAG_USE_DEF_DOM_OPS
+=09=09| MSI_FLAG_USE_DEF_CHIP_OPS,
+=09.chip=09=3D &msi_chip,
+};
+
+static int tango_irq_domain_alloc(struct irq_domain *dom, unsigned int vir=
q,
+=09=09=09=09  unsigned int nr_irqs, void *args)
+{
+=09struct tango_pcie *pcie =3D dom->host_data;
+=09unsigned long flags;
+=09int pos;
+
+=09spin_lock_irqsave(&pcie->used_msi_lock, flags);
+=09pos =3D find_first_zero_bit(pcie->used_msi, MSI_MAX);
+=09if (pos >=3D MSI_MAX) {
+=09=09spin_unlock_irqrestore(&pcie->used_msi_lock, flags);
+=09=09return -ENOSPC;
+=09}
+=09__set_bit(pos, pcie->used_msi);
+=09spin_unlock_irqrestore(&pcie->used_msi_lock, flags);
+=09irq_domain_set_info(dom, virq, pos, &tango_chip,
+=09=09=09pcie, handle_edge_irq, NULL, NULL);
+
+=09return 0;
+}
+
+static void tango_irq_domain_free(struct irq_domain *dom, unsigned int vir=
q,
+=09=09=09=09  unsigned int nr_irqs)
+{
+=09unsigned long flags;
+=09struct irq_data *d =3D irq_domain_get_irq_data(dom, virq);
+=09struct tango_pcie *pcie =3D d->chip_data;
+
+=09spin_lock_irqsave(&pcie->used_msi_lock, flags);
+=09__clear_bit(d->hwirq, pcie->used_msi);
+=09spin_unlock_irqrestore(&pcie->used_msi_lock, flags);
+}
+
+static const struct irq_domain_ops dom_ops =3D {
+=09.alloc=09=3D tango_irq_domain_alloc,
+=09.free=09=3D tango_irq_domain_free,
 };
=20
 static int smp8759_config_read(struct pci_bus *bus, unsigned int devfn,
@@ -76,7 +236,11 @@ static int tango_pcie_probe(struct platform_device *pde=
v)
 =09struct device *dev =3D &pdev->dev;
 =09struct tango_pcie *pcie;
 =09struct resource *res;
-=09int ret;
+=09struct fwnode_handle *fwnode =3D of_node_to_fwnode(dev->of_node);
+=09struct irq_domain *msi_dom, *irq_dom;
+=09struct of_pci_range_parser parser;
+=09struct of_pci_range range;
+=09int virq, offset;
=20
 =09dev_warn(dev, "simultaneous PCI config and MMIO accesses may cause data=
 corruption\n");
 =09add_taint(TAINT_CRAP, LOCKDEP_STILL_OK);
@@ -95,6 +259,41 @@ static int tango_pcie_probe(struct platform_device *pde=
v)
 =09if (!tango_pcie_link_up(pcie))
 =09=09return -ENODEV;
=20
+=09if (of_pci_dma_range_parser_init(&parser, dev->of_node) < 0)
+=09=09return -ENOENT;
+
+=09if (of_pci_range_parser_one(&parser, &range) =3D=3D NULL)
+=09=09return -ENOENT;
+
+=09range.pci_addr +=3D range.size;
+=09pcie->msi_doorbell =3D range.pci_addr + res->start + SMP8759_DOORBELL;
+
+=09for (offset =3D 0; offset < MSI_MAX / 8; offset +=3D 4)
+=09=09writel_relaxed(0, pcie->base + SMP8759_ENABLE + offset);
+
+=09virq =3D platform_get_irq(pdev, 1);
+=09if (virq <=3D 0) {
+=09=09dev_err(dev, "Failed to map IRQ\n");
+=09=09return -ENXIO;
+=09}
+
+=09irq_dom =3D irq_domain_create_linear(fwnode, MSI_MAX, &dom_ops, pcie);
+=09if (!irq_dom) {
+=09=09dev_err(dev, "Failed to create IRQ domain\n");
+=09=09return -ENOMEM;
+=09}
+
+=09msi_dom =3D pci_msi_create_irq_domain(fwnode, &msi_dom_info, irq_dom);
+=09if (!msi_dom) {
+=09=09dev_err(dev, "Failed to create MSI domain\n");
+=09=09irq_domain_remove(irq_dom);
+=09=09return -ENOMEM;
+=09}
+
+=09pcie->dom =3D irq_dom;
+=09spin_lock_init(&pcie->used_msi_lock);
+=09irq_set_chained_handler_and_data(virq, tango_msi_isr, pcie);
+
 =09return pci_host_common_probe(pdev, &smp8759_ecam_ops);
 }
=20
--=20
2.11.0
