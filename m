Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:57188 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494Ab1KJHma (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2011 02:42:30 -0500
Message-ID: <4EBB8058.6090500@jp.fujitsu.com>
Date: Thu, 10 Nov 2011 16:42:16 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai.lu@oracle.com>
CC: Jesse Barnes <jbarnes@virtuousgeek.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: [PATCH 2/2] pciehp: wait 100 ms after Link Training check
References: <4EB88238.4050409@oracle.com> <4EB8F434.6090003@jp.fujitsu.com> <4EB94A51.6070809@oracle.com> <4EB9A50D.1040302@oracle.com> <4EBB7F9B.8050703@jp.fujitsu.com>
In-Reply-To: <4EBB7F9B.8050703@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If the port supports Link speeds greater than 5.0 GT/s, we must wait
for 100 ms after Link training completes before sending configuration
request.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
---
 drivers/pci/hotplug/pciehp_hpc.c |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: linux-3.1/drivers/pci/hotplug/pciehp_hpc.c
===================================================================
--- linux-3.1.orig/drivers/pci/hotplug/pciehp_hpc.c
+++ linux-3.1/drivers/pci/hotplug/pciehp_hpc.c
@@ -302,6 +302,14 @@ int pciehp_check_link_status(struct cont
 		return retval;
 	}
 
+	/*
+	 * If the port supports Link speeds greater than 5.0 GT/s, we
+	 * must wait for 100 ms after Link training completes before
+	 * sending configuration request.
+	 */
+	if (ctrl->pcie->port->subordinate->max_bus_speed > PCIE_SPEED_5_0GT)
+		msleep(100);
+
 	pcie_update_link_speed(ctrl->pcie->port->subordinate, lnk_status);
 
 	return retval;
