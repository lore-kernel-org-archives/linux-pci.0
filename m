Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38016 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933649AbeEWRs0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 May 2018 13:48:26 -0400
Received: by mail-pl0-f66.google.com with SMTP id c11-v6so13477114plr.5
        for <linux-pci@vger.kernel.org>; Wed, 23 May 2018 10:48:26 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: bhelgaas@google.com, kys@microsoft.com, haiyangz@microsoft.com,
        lorenzo.pieralisi@arm.com
Cc: devel@linuxdriverproject.org, linux-pci@vger.kernel.org,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: [PATCH 2/3] PCI: hv: convert remove_lock to refcount
Date: Wed, 23 May 2018 10:11:13 -0700
Message-Id: <20180523171114.5136-3-sthemmin@microsoft.com>
In-Reply-To: <20180523171114.5136-1-sthemmin@microsoft.com>
References: <20180523171114.5136-1-sthemmin@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use refcount instead of atomic for the reference counting
on bus. Refcount is safer because it handles overflow correctly.

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 505453e23c22..19eb47f58ccb 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -433,7 +433,7 @@ enum hv_pcibus_state {
 struct hv_pcibus_device {
 	struct pci_sysdata sysdata;
 	enum hv_pcibus_state state;
-	atomic_t remove_lock;
+	refcount_t remove_lock;
 	struct hv_device *hdev;
 	resource_size_t low_mmio_space;
 	resource_size_t high_mmio_space;
@@ -2441,12 +2441,12 @@ static int hv_send_resources_released(struct hv_device *hdev)
 
 static void get_hvpcibus(struct hv_pcibus_device *hbus)
 {
-	atomic_inc(&hbus->remove_lock);
+	refcount_inc(&hbus->remove_lock);
 }
 
 static void put_hvpcibus(struct hv_pcibus_device *hbus)
 {
-	if (atomic_dec_and_test(&hbus->remove_lock))
+	if (refcount_dec_and_test(&hbus->remove_lock))
 		complete(&hbus->remove_event);
 }
 
@@ -2490,7 +2490,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 			       hdev->dev_instance.b[8] << 8;
 
 	hbus->hdev = hdev;
-	atomic_inc(&hbus->remove_lock);
+	refcount_set(&hbus->remove_lock, 1);
 	INIT_LIST_HEAD(&hbus->children);
 	INIT_LIST_HEAD(&hbus->dr_list);
 	INIT_LIST_HEAD(&hbus->resources_for_children);
-- 
2.17.0
