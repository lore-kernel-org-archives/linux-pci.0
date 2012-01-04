Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:30652 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281Ab2ADXuF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jan 2012 18:50:05 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH] PCI: DEVICE_COUNT_RESOURCE should be equal to PCI_NUM_RESOURCES
Date: Wed,  4 Jan 2012 15:49:45 -0800
Message-Id: <1325720985-6051-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Save some bytes for device resource array.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 include/linux/pci.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/include/linux/pci.h
===================================================================
--- linux-2.6.orig/include/linux/pci.h
+++ linux-2.6/include/linux/pci.h
@@ -111,7 +111,7 @@ enum {
 	PCI_NUM_RESOURCES,
 
 	/* preserve this for compatibility */
-	DEVICE_COUNT_RESOURCE
+	DEVICE_COUNT_RESOURCE = PCI_NUM_RESOURCES,
 };
 
 typedef int __bitwise pci_power_t;
