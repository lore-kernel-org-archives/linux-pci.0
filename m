Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v2 2/8] pci: Add hotplug_slot_ops.reset_slot()
To: bhelgaas@google.com, linux-pci@vger.kernel.org
From: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-kernel@vger.kernel.org
Date: Tue, 07 May 2013 20:57:47 -0600
Message-ID: <20130508025747.30771.89956.stgit@bling.home>
In-Reply-To: <20130508025339.30771.61937.stgit@bling.home>
References: <20130508025339.30771.61937.stgit@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This optional callback allows htoplug controllers to perform slot
specific resets.  These may be necessary in cases where a normal
secondary bus reset can interact with controller logic and expose
spurious hotplugs.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 include/linux/pci_hotplug.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
index 45fc162..0d3a604 100644
--- a/include/linux/pci_hotplug.h
+++ b/include/linux/pci_hotplug.h
@@ -63,6 +63,9 @@ enum pcie_link_width {
  * @get_adapter_status: Called to get see if an adapter is present in the slot or not.
  *	If this field is NULL, the value passed in the struct hotplug_slot_info
  *	will be used when this value is requested by a user.
+ * @reset_slot: Optional interface to allow override of a bus reset for the
+ *	slot for cases where a secondary bus reset can result in spurious
+ *	hotplug events or where a slot can be reset independent of the bus.
  *
  * The table of function pointers that is passed to the hotplug pci core by a
  * hotplug pci driver.  These functions are called by the hotplug pci core when
@@ -80,6 +83,7 @@ struct hotplug_slot_ops {
 	int (*get_attention_status)	(struct hotplug_slot *slot, u8 *value);
 	int (*get_latch_status)		(struct hotplug_slot *slot, u8 *value);
 	int (*get_adapter_status)	(struct hotplug_slot *slot, u8 *value);
+	int (*reset_slot)		(struct hotplug_slot *slot, int probe);
 };
 
 /**

