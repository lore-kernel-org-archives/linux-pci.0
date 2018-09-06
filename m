Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:27641 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730272AbeIFU2q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Sep 2018 16:28:46 -0400
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        "D . J . Bernstein" <djb@cr.yp.to>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH 08/10] PCI/PME: Implement runtime PM callbacks
Date: Thu,  6 Sep 2018 18:50:18 +0300
Message-Id: <20180906155020.51700-9-mika.westerberg@linux.intel.com>
In-Reply-To: <20180906155020.51700-1-mika.westerberg@linux.intel.com>
References: <20180906155020.51700-1-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Basically we need to do the same steps than what we do when system sleep
is entered and disable PME interrupt when the root port is runtime
suspended. This prevents spurious wakeups immediately when the port is
transitioned into D3cold.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/pcie/pme.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
index 3ed67676ea2a..62fe122f030a 100644
--- a/drivers/pci/pcie/pme.c
+++ b/drivers/pci/pcie/pme.c
@@ -432,6 +432,31 @@ static void pcie_pme_remove(struct pcie_device *srv)
 	kfree(get_service_data(srv));
 }
 
+static int pcie_pme_runtime_suspend(struct pcie_device *srv)
+{
+	struct pcie_pme_service_data *data = get_service_data(srv);
+
+	spin_lock_irq(&data->lock);
+	pcie_pme_interrupt_enable(srv->port, false);
+	pcie_clear_root_pme_status(srv->port);
+	data->noirq = true;
+	spin_unlock_irq(&data->lock);
+
+	return 0;
+}
+
+static int pcie_pme_runtime_resume(struct pcie_device *srv)
+{
+	struct pcie_pme_service_data *data = get_service_data(srv);
+
+	spin_lock_irq(&data->lock);
+	pcie_pme_interrupt_enable(srv->port, true);
+	data->noirq = false;
+	spin_unlock_irq(&data->lock);
+
+	return 0;
+}
+
 static struct pcie_port_service_driver pcie_pme_driver = {
 	.name		= "pcie_pme",
 	.port_type	= PCI_EXP_TYPE_ROOT_PORT,
@@ -439,6 +464,8 @@ static struct pcie_port_service_driver pcie_pme_driver = {
 
 	.probe		= pcie_pme_probe,
 	.suspend	= pcie_pme_suspend,
+	.runtime_suspend = pcie_pme_runtime_suspend,
+	.runtime_resume	= pcie_pme_runtime_resume,
 	.resume		= pcie_pme_resume,
 	.remove		= pcie_pme_remove,
 };
-- 
2.18.0
