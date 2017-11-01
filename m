Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sg2apc01on0111.outbound.protection.outlook.com ([104.47.125.111]:33504
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755207AbdKAUbJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Nov 2017 16:31:09 -0400
From: Dexuan Cui <decui@microsoft.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Jake Oshins <jakeo@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
CC: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Jork Loeser <Jork.Loeser@microsoft.com>,
        "Chris Valean (Cloudbase Solutions SRL)" <v-chvale@microsoft.com>,
        "Adrian Suhov (Cloudbase Solutions SRL)" <v-adsuho@microsoft.com>,
        Simon Xiao <sixiao@microsoft.com>,
        'Eyal Mizrachi' <eyalmi@mellanox.com>,
        "Jack Morgenstein" <jackm@mellanox.com>,
        Armen Guezalian <armeng@mellanox.com>,
        Firas Mahameed <firas@mellanox.com>,
        Tziporet Koren <tziporet@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>
Subject: [PATCH] PCI: hv: use effective affinity mask
Date: Wed, 1 Nov 2017 20:30:53 +0000
Message-ID: <PS1P15301MB00112EE79DE499E8B2BA338BBF5F0@PS1P15301MB0011.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


The effective_affinity_mask is always set when an interrupt is assigned in
__assign_irq_vector() -> apic->cpu_mask_to_apicid(), e.g. for struct apic
apic_physflat: -> default_cpu_mask_to_apicid() ->
irq_data_update_effective_affinity(), but it looks d->common->affinity
remains all-1's before the user space or the kernel changes it later.

In the early allocation/initialization phase of an irq, we should use the
effective_affinity_mask, otherwise Hyper-V may not deliver the interrupt
to the expected cpu. Without the patch, if we assign 7 Mellanox ConnectX-3
VFs to a 32-vCPU VM, one of the VFs may fail to receive interrupts.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: Jake Oshins <jakeo@microsoft.com>
Cc: Jork Loeser <jloeser@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
---

Please consider this for v4.14, if it's not too late.

 drivers/pci/host/pci-hyperv.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 5ccb47d..8b5f66d 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -879,7 +879,7 @@ static void hv_irq_unmask(struct irq_data *data)
 	int cpu;
 	u64 res;
=20
-	dest =3D irq_data_get_affinity_mask(data);
+	dest =3D irq_data_get_effective_affinity_mask(data);
 	pdev =3D msi_desc_to_pci_dev(msi_desc);
 	pbus =3D pdev->bus;
 	hbus =3D container_of(pbus->sysdata, struct hv_pcibus_device, sysdata);
@@ -1042,6 +1042,7 @@ static void hv_compose_msi_msg(struct irq_data *data,=
 struct msi_msg *msg)
 	struct hv_pci_dev *hpdev;
 	struct pci_bus *pbus;
 	struct pci_dev *pdev;
+	struct cpumask *dest;
 	struct compose_comp_ctxt comp;
 	struct tran_int_desc *int_desc;
 	struct {
@@ -1056,6 +1057,7 @@ static void hv_compose_msi_msg(struct irq_data *data,=
 struct msi_msg *msg)
 	int ret;
=20
 	pdev =3D msi_desc_to_pci_dev(irq_data_get_msi_desc(data));
+	dest =3D irq_data_get_effective_affinity_mask(data);
 	pbus =3D pdev->bus;
 	hbus =3D container_of(pbus->sysdata, struct hv_pcibus_device, sysdata);
 	hpdev =3D get_pcichild_wslot(hbus, devfn_to_wslot(pdev->devfn));
@@ -1081,14 +1083,14 @@ static void hv_compose_msi_msg(struct irq_data *dat=
a, struct msi_msg *msg)
 	switch (pci_protocol_version) {
 	case PCI_PROTOCOL_VERSION_1_1:
 		size =3D hv_compose_msi_req_v1(&ctxt.int_pkts.v1,
-					irq_data_get_affinity_mask(data),
+					dest,
 					hpdev->desc.win_slot.slot,
 					cfg->vector);
 		break;
=20
 	case PCI_PROTOCOL_VERSION_1_2:
 		size =3D hv_compose_msi_req_v2(&ctxt.int_pkts.v2,
-					irq_data_get_affinity_mask(data),
+					dest,
 					hpdev->desc.win_slot.slot,
 					cfg->vector);
 		break;
--=20
2.7.4
