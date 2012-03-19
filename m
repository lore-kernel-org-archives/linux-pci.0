Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>, x86 <x86@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org
Subject: [PATCH -v3 26/47] PCI, ACPI: Make acpi_pci_root_remove remove pci root bus too
Date: Sun, 18 Mar 2012 22:46:15 -0700
Message-Id: <1332135996-13860-27-git-send-email-yinghai@kernel.org>
In-Reply-To: <1332135996-13860-1-git-send-email-yinghai@kernel.org>
References: <1332135996-13860-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It will call new added pci_stop_and_remove_bus() to stop/remove pci root bus.

Also checking if that pci_root_bus get removed already in bus remove in /sys

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/pci_root.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 7aff631..b38e347 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -643,10 +643,24 @@ static int acpi_pci_root_remove(struct acpi_device *device, int type)
 {
 	struct acpi_pci_root *root = acpi_driver_data(device);
 
+	/* that root bus could be removed already */
+	if (!pci_find_bus(root->segment, root->secondary.start)) {
+		dev_printk(KERN_DEBUG, &device->dev,
+		  "freeing acpi_pci_root, but pci root bus was removed before");
+		goto out;
+	}
+
 	device_set_run_wake(root->bus->bridge, false);
 	pci_acpi_remove_bus_pm_notifier(device);
 
+	dev_printk(KERN_DEBUG, &device->dev,
+		"freeing acpi_pci_root, will remove pci root bus at first");
+	pci_stop_and_remove_bus(root->bus);
+
+out:
+	list_del(&root->node);
 	kfree(root);
+
 	return 0;
 }
 
-- 
1.7.7

