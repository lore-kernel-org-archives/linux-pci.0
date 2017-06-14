Return-Path: <SRS0=ZFNK=5T=sigmadesigns.com=marc_gonzalez@kernel.org>
Return-Path: <SRS0=ZFNK=5T=sigmadesigns.com=marc_gonzalez@kernel.org>
Subject: [PATCH v8 3/3] PCI: Add tango MSI controller support
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
 <49b4138d-0030-1e8c-6a14-0e9151b63d24@sigmadesigns.com>
 <1588fa00-92c6-046d-ccfc-9a2deae61486@arm.com>
 <08d84ce3-5345-dc69-bbc3-37372a3df22b@sigmadesigns.com>
 <870f833b-6bff-b3b1-6591-7d46e374de66@sigmadesigns.com>
 <a714b871-dd6c-4db0-3539-aabf7274938a@arm.com>
From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Message-ID: <cea7a50c-0d09-37be-7b84-f6d652a4bc28@sigmadesigns.com>
Date: Wed, 14 Jun 2017 13:06:20 +0200
MIME-Version: 1.0
In-Reply-To: <a714b871-dd6c-4db0-3539-aabf7274938a@arm.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

The MSI controller in Tango supports 256 message-signaled interrupts,
and a single doorbell address.

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
Changes from v7 to v8
o Reorganize tango_irq_domain_alloc() so as not to call irq_domain_set_info=
()
  with pcie->used_msi_lock held =3D> Bug diagnosed by LOCKDEP
---
 drivers/pci/host/pcie-tango.c | 226 ++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 226 insertions(+)

diff --git a/drivers/pci/host/pcie-tango.c b/drivers/pci/host/pcie-tango.c
index 67aaadcc1c5e..5c47a4cc03e3 100644
--- a/drivers/pci/host/pcie-tango.c
+++ b/drivers/pci/host/pcie-tango.c
@@ -1,16 +1,229 @@
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
 #include <linux/pci-ecam.h>
 #include <linux/delay.h>
+#include <linux/msi.h>
 #include <linux/of.h>
=20
 #define MSI_MAX 256
=20
 #define SMP8759_MUX=09=090x48
 #define SMP8759_TEST_OUT=090x74
+#define SMP8759_STATUS=09=090x80
+#define SMP8759_ENABLE=09=090xa0
+#define SMP8759_DOORBELL=090xa002e07c
=20
 struct tango_pcie {
+=09DECLARE_BITMAP(used_msi, MSI_MAX);
+=09spinlock_t used_msi_lock;
 =09void __iomem *mux;
+=09void __iomem *msi_status;
+=09void __iomem *msi_enable;
+=09phys_addr_t msi_doorbell;
+=09struct irq_domain *irq_dom;
+=09struct irq_domain *msi_dom;
+=09int irq;
 };
=20
+/*** MSI CONTROLLER SUPPORT ***/
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
+=09=09status =3D readl_relaxed(pcie->msi_status + base / 8);
+=09=09for_each_set_bit(idx, &status, 32) {
+=09=09=09virq =3D irq_find_mapping(pcie->irq_dom, base + idx);
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
+=09writel_relaxed(bit, pcie->msi_status + offset);
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
+=09val =3D readl_relaxed(pcie->msi_enable + offset);
+=09val =3D unmask ? val | bit : val & ~bit;
+=09writel_relaxed(val, pcie->msi_enable + offset);
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
+static int tango_set_affinity(struct irq_data *d,
+=09=09const struct cpumask *mask, bool force)
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
+static int tango_irq_domain_alloc(struct irq_domain *dom,
+=09=09unsigned int virq, unsigned int nr_irqs, void *args)
+{
+=09int pos;
+=09unsigned long flags;
+=09struct tango_pcie *pcie =3D dom->host_data;
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
+static void tango_irq_domain_free(struct irq_domain *dom,
+=09=09unsigned int virq, unsigned int nr_irqs)
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
+static const struct irq_domain_ops irq_dom_ops =3D {
+=09.alloc=09=3D tango_irq_domain_alloc,
+=09.free=09=3D tango_irq_domain_free,
+};
+
+static int tango_msi_remove(struct platform_device *pdev)
+{
+=09struct tango_pcie *pcie =3D platform_get_drvdata(pdev);
+
+=09irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
+=09irq_domain_remove(pcie->msi_dom);
+=09irq_domain_remove(pcie->irq_dom);
+
+=09return 0;
+}
+
+static int tango_msi_probe(struct platform_device *pdev, struct tango_pcie=
 *pcie)
+{
+=09int i, virq;
+=09struct irq_domain *msi_dom, *irq_dom;
+=09struct fwnode_handle *fwnode =3D of_node_to_fwnode(pdev->dev.of_node);
+
+=09spin_lock_init(&pcie->used_msi_lock);
+=09for (i =3D 0; i < MSI_MAX / 32; ++i)
+=09=09writel_relaxed(0, pcie->msi_enable + i * 4);
+
+=09virq =3D platform_get_irq(pdev, 1);
+=09if (virq <=3D 0) {
+=09=09pr_err("Failed to map IRQ\n");
+=09=09return -ENXIO;
+=09}
+
+=09irq_dom =3D irq_domain_create_linear(fwnode, MSI_MAX, &irq_dom_ops, pci=
e);
+=09if (!irq_dom) {
+=09=09pr_err("Failed to create IRQ domain\n");
+=09=09return -ENOMEM;
+=09}
+
+=09msi_dom =3D pci_msi_create_irq_domain(fwnode, &msi_dom_info, irq_dom);
+=09if (!msi_dom) {
+=09=09pr_err("Failed to create MSI domain\n");
+=09=09irq_domain_remove(irq_dom);
+=09=09return -ENOMEM;
+=09}
+
+=09pcie->irq_dom =3D irq_dom;
+=09pcie->msi_dom =3D msi_dom;
+=09pcie->irq =3D virq;
+
+=09irq_set_chained_handler_and_data(virq, tango_msi_isr, pcie);
+
+=09return 0;
+}
+
 /*** HOST BRIDGE SUPPORT ***/
=20
 static int smp8759_config_read(struct pci_bus *bus,
@@ -88,6 +301,9 @@ static int tango_check_pcie_link(void __iomem *test_out)
 static int smp8759_init(struct tango_pcie *pcie, void __iomem *base)
 {
 =09pcie->mux=09=09=3D base + SMP8759_MUX;
+=09pcie->msi_status=09=3D base + SMP8759_STATUS;
+=09pcie->msi_enable=09=3D base + SMP8759_ENABLE;
+=09pcie->msi_doorbell=09=3D SMP8759_DOORBELL;
=20
 =09return tango_check_pcie_link(base + SMP8759_TEST_OUT);
 }
@@ -121,11 +337,21 @@ static int tango_pcie_probe(struct platform_device *p=
dev)
 =09if (ret)
 =09=09return ret;
=20
+=09ret =3D tango_msi_probe(pdev, pcie);
+=09if (ret)
+=09=09return ret;
+
 =09return pci_host_common_probe(pdev, &smp8759_ecam_ops);
 }
=20
+static int tango_pcie_remove(struct platform_device *pdev)
+{
+=09return tango_msi_remove(pdev);
+}
+
 static struct platform_driver tango_pcie_driver =3D {
 =09.probe=09=3D tango_pcie_probe,
+=09.remove=09=3D tango_pcie_remove,
 =09.driver=09=3D {
 =09=09.name =3D KBUILD_MODNAME,
 =09=09.of_match_table =3D tango_pcie_ids,
--=20
2.11.0
