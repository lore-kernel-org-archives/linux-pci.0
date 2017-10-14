Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pu1apc01on0136.outbound.protection.outlook.com ([104.47.126.136]:63712
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753528AbdJNDBr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Oct 2017 23:01:47 -0400
From: Dexuan Cui <decui@microsoft.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Josh Poulson <jopoulso@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Simon Xiao <sixiao@microsoft.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        "Mihai Costache (Cloudbase Solutions SRL)" <v-micos@microsoft.com>,
        Jork Loeser <Jork.Loeser@microsoft.com>
Subject: [PATCH] PCI: hv: fix "spurious APIC interrupt" due to new vector
 reservation mode
Date: Sat, 14 Oct 2017 03:01:22 +0000
Message-ID: <KL1P15301MB0006E6E2D1AF8F6E27686DD0BF490@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Last month the vector management code was reworked, and as a result of the
changes, e.g. commit 22d0b12f3560 ("genirq/irqdomain: Add force
reactivation flag to irq domains"), commit 4900be83602b ("x86/vector/msi:
Switch to global reservation mode") etc, now we must add this new flag
MSI_FLAG_MUST_REACTIVATE when calling pci_msi_create_irq_domain() on x86,
otherwise Hyper-V PCIe pass-through can't work, and we get:
"spurious APIC interrupt through vector ff on CPU#0, should never happen",
this is because no valid MSI/MSI-X vector is allocated.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
---

Currently the "reservation mode" patchset has not been in Linus's tree yet,=
 so
today's mainline hasn't shown the issue, but today's linux-next has shown t=
he
issue (PCIe pass-through on Hyper-V can't work).

I think any caller of pci_msi_create_irq_domain() that runs on x86 needs to
be updated, but besides pci-hyper I'm not sure which callers run on x86.

 drivers/pci/host/pci-hyperv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 0fe3ea1..35a7683 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -1196,7 +1196,8 @@ static int hv_pcie_init_irq_domain(struct hv_pcibus_d=
evice *hbus)
 	hbus->msi_info.ops =3D &hv_msi_ops;
 	hbus->msi_info.flags =3D (MSI_FLAG_USE_DEF_DOM_OPS |
 		MSI_FLAG_USE_DEF_CHIP_OPS | MSI_FLAG_MULTI_PCI_MSI |
-		MSI_FLAG_PCI_MSIX);
+		MSI_FLAG_PCI_MSIX |
+		MSI_FLAG_MUST_REACTIVATE);
 	hbus->msi_info.handler =3D handle_edge_irq;
 	hbus->msi_info.handler_name =3D "edge";
 	hbus->msi_info.data =3D hbus;
--=20
2.7.4
