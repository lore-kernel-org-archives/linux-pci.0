Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46059 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933144AbeEWRs1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 May 2018 13:48:27 -0400
Received: by mail-pf0-f194.google.com with SMTP id c10-v6so10844996pfi.12
        for <linux-pci@vger.kernel.org>; Wed, 23 May 2018 10:48:27 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: bhelgaas@google.com, kys@microsoft.com, haiyangz@microsoft.com,
        lorenzo.pieralisi@arm.com
Cc: devel@linuxdriverproject.org, linux-pci@vger.kernel.org,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: [PATCH 3/3] PCI: hv: use list_for_each_entry
Date: Wed, 23 May 2018 10:11:14 -0700
Message-Id: <20180523171114.5136-4-sthemmin@microsoft.com>
In-Reply-To: <20180523171114.5136-1-sthemmin@microsoft.com>
References: <20180523171114.5136-1-sthemmin@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There are several places where list_for_each_entry could be
used to simplify the code.

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 19eb47f58ccb..afc30dee6001 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -1279,7 +1279,6 @@ static u64 get_bar_size(u64 bar_val)
  */
 static void survey_child_resources(struct hv_pcibus_device *hbus)
 {
-	struct list_head *iter;
 	struct hv_pci_dev *hpdev;
 	resource_size_t bar_size = 0;
 	unsigned long flags;
@@ -1305,8 +1304,7 @@ static void survey_child_resources(struct hv_pcibus_device *hbus)
 	 * for a child device are a power of 2 in size and aligned in memory,
 	 * so it's sufficient to just add them up without tracking alignment.
 	 */
-	list_for_each(iter, &hbus->children) {
-		hpdev = container_of(iter, struct hv_pci_dev, list_entry);
+	list_for_each_entry(hpdev, &hbus->children, list_entry) {
 		for (i = 0; i < 6; i++) {
 			if (hpdev->probed_bar[i] & PCI_BASE_ADDRESS_SPACE_IO)
 				dev_err(&hbus->hdev->device,
@@ -1359,7 +1357,6 @@ static void prepopulate_bars(struct hv_pcibus_device *hbus)
 	resource_size_t low_base = 0;
 	resource_size_t bar_size;
 	struct hv_pci_dev *hpdev;
-	struct list_head *iter;
 	unsigned long flags;
 	u64 bar_val;
 	u32 command;
@@ -1381,9 +1378,7 @@ static void prepopulate_bars(struct hv_pcibus_device *hbus)
 
 	/* Pick addresses for the BARs. */
 	do {
-		list_for_each(iter, &hbus->children) {
-			hpdev = container_of(iter, struct hv_pci_dev,
-					     list_entry);
+		list_for_each_entry(hpdev, &hbus->children, list_entry) {
 			for (i = 0; i < 6; i++) {
 				bar_val = hpdev->probed_bar[i];
 				if (bar_val == 0)
@@ -1637,7 +1632,6 @@ static void pci_devices_present_work(struct work_struct *work)
 {
 	u32 child_no;
 	bool found;
-	struct list_head *iter;
 	struct pci_function_description *new_desc;
 	struct hv_pci_dev *hpdev;
 	struct hv_pcibus_device *hbus;
@@ -1674,10 +1668,8 @@ static void pci_devices_present_work(struct work_struct *work)
 
 	/* First, mark all existing children as reported missing. */
 	spin_lock_irqsave(&hbus->device_list_lock, flags);
-	list_for_each(iter, &hbus->children) {
-			hpdev = container_of(iter, struct hv_pci_dev,
-					     list_entry);
-			hpdev->reported_missing = true;
+	list_for_each_entry(hpdev, &hbus->children, list_entry) {
+		hpdev->reported_missing = true;
 	}
 	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
 
@@ -1687,11 +1679,8 @@ static void pci_devices_present_work(struct work_struct *work)
 		new_desc = &dr->func[child_no];
 
 		spin_lock_irqsave(&hbus->device_list_lock, flags);
-		list_for_each(iter, &hbus->children) {
-			hpdev = container_of(iter, struct hv_pci_dev,
-					     list_entry);
-			if ((hpdev->desc.win_slot.slot ==
-			     new_desc->win_slot.slot) &&
+		list_for_each_entry(hpdev, &hbus->children, list_entry) {
+			if ((hpdev->desc.win_slot.slot == new_desc->win_slot.slot) &&
 			    (hpdev->desc.v_id == new_desc->v_id) &&
 			    (hpdev->desc.d_id == new_desc->d_id) &&
 			    (hpdev->desc.ser == new_desc->ser)) {
@@ -1713,9 +1702,7 @@ static void pci_devices_present_work(struct work_struct *work)
 	spin_lock_irqsave(&hbus->device_list_lock, flags);
 	do {
 		found = false;
-		list_for_each(iter, &hbus->children) {
-			hpdev = container_of(iter, struct hv_pci_dev,
-					     list_entry);
+		list_for_each_entry(hpdev, &hbus->children, list_entry) {
 			if (hpdev->reported_missing) {
 				found = true;
 				put_pcichild(hpdev);
-- 
2.17.0
