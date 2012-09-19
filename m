Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>, x86 <x86@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 38/40] ACPI, PCI: Skip extra pci_enable_bridges for non hot-add root
Date: Wed, 19 Sep 2012 11:54:52 -0700
Message-Id: <1348080894-23412-39-git-send-email-yinghai@kernel.org>
In-Reply-To: <1348080894-23412-1-git-send-email-yinghai@kernel.org>
References: <CAE9FiQWFcVNKMnV1qaHchwCXfZuMpyxf_f7GQy3FZid9YuLD3w@mail.gmail.com>
 <1348080894-23412-1-git-send-email-yinghai@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Pre-installed will be handled later, need to skip the one only for hot-added
roots.

Otherwise will get anonying failing message about can not reserve, irq ...

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/acpi/pci_root.c    |    3 ++-
 drivers/acpi/pci_root_hp.c |    1 +
 include/acpi/acpi_bus.h    |    1 +
 3 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 670511f..6151d83 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -645,7 +645,8 @@ static int acpi_pci_root_start(struct acpi_device *device)
 			driver->add(root);
 
 	/* need to after hot-added ioapic is registered */
-	pci_enable_bridges(root->bus);
+	if (root->hot_added)
+		pci_enable_bridges(root->bus);
 
 	pci_bus_add_devices(root->bus);
 	mutex_unlock(&acpi_pci_root_lock);
diff --git a/drivers/acpi/pci_root_hp.c b/drivers/acpi/pci_root_hp.c
index e573298..1f60533 100644
--- a/drivers/acpi/pci_root_hp.c
+++ b/drivers/acpi/pci_root_hp.c
@@ -86,6 +86,7 @@ static void acpi_root_configure_bridge(struct acpi_device *device)
 
 	pcibios_resource_survey_bus(root->bus);
 	pci_assign_unassigned_bus_resources(root->bus);
+	root->hot_added = true;
 }
 
 static void handle_root_bridge_insertion(acpi_handle handle)
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index bde976e..47de196 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -406,6 +406,7 @@ struct acpi_pci_root {
 
 	u32 osc_support_set;	/* _OSC state of support bits */
 	u32 osc_control_set;	/* _OSC state of control bits */
+	bool hot_added;
 	phys_addr_t mcfg_addr;
 };
 
-- 
1.7.7

