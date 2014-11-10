Return-Path: <linux-kernel-owner@vger.kernel.org>
From: <suravee.suthikulpanit@amd.com>
To: <bhelgaas@google.com>
CC: <liviu.dudau@arm.com>, <lorenzo.pieralisi@arm.com>,
	<will.deacon@arm.com>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH 2/2] PCI: generic: Add set_msi_parent callback
Date: Mon, 10 Nov 2014 13:24:40 -0600
Message-ID: <1415647480-3320-3-git-send-email-suravee.suthikulpanit@amd.com>
In-Reply-To: <1415647480-3320-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1415647480-3320-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

This patch implement set_msi_parent callback for PCI generic host controller.

Cc: Bjorn Helgass <bhelgaas@google.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 drivers/pci/host/pci-host-generic.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
index 036ab1b..f9bb97a 100644
--- a/drivers/pci/host/pci-host-generic.c
+++ b/drivers/pci/host/pci-host-generic.c
@@ -42,6 +42,7 @@ struct gen_pci {
 	struct pci_host_bridge			host;
 	struct gen_pci_cfg_windows		cfg;
 	struct list_head			resources;
+	struct msi_chip				*mchip;
 };
 
 #ifdef CONFIG_ARM
@@ -128,9 +129,19 @@ static int gen_pci_config_write(struct pci_bus *bus, unsigned int devfn,
 	return PCIBIOS_SUCCESSFUL;
 }
 
+static int gen_pci_set_msi_parent(struct pci_bus *bus)
+{
+	struct gen_pci *pci = bus_to_gen_pci(bus);
+
+	bus->msi = pci->mchip;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
 static struct pci_ops gen_pci_ops = {
 	.read	= gen_pci_config_read,
 	.write	= gen_pci_config_write,
+	.set_msi_parent = gen_pci_set_msi_parent,
 };
 
 static const struct of_device_id gen_pci_of_match[] = {
@@ -313,6 +324,9 @@ static int gen_pci_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	pci->mchip = of_pci_find_msi_chip_by_node(of_parse_phandle(np,
+						  "msi-parent", 0));
+
 #ifdef CONFIG_ARM
 	pci_common_init_dev(dev, &hw);
 #else
-- 
1.9.3

