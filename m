Return-Path: <SRS0=Q3uD=3E=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEC0C33CB1
	for <linux-pci@archiver.kernel.org>; Wed, 15 Jan 2020 09:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2931F2467D
	for <linux-pci@archiver.kernel.org>; Wed, 15 Jan 2020 09:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgAOJIV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 15 Jan 2020 04:08:21 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8722 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729021AbgAOJIV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jan 2020 04:08:21 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B32F37BC9A0FAD2AD672;
        Wed, 15 Jan 2020 17:08:19 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Wed, 15 Jan 2020 17:08:10 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC:     <f.fangjian@huawei.com>
Subject: [PATCH 4/6] PCI: Improve and rename PCIE_SPEED2STR macro
Date:   Wed, 15 Jan 2020 17:04:21 +0800
Message-ID: <1579079063-5668-5-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1579079063-5668-1-git-send-email-yangyicong@hisilicon.com>
References: <1579079063-5668-1-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use pci_bus_speed_strings[] array to refactor PCIE_SPEED2STR macro.
Rename PCIE_SPEED2STR with PCI_SPEED2STR as it's also used to
decode non-PCIe speeds. Modify bus_speed_read() and
__pcie_print_link_status() with PCI_SPEED2STR macro.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---

I don't add a boundary check in PCI_SPEED2STR macro because:
1. we cannot get the array size of an extern one using ARRAY_SIZE
2. It is the *speed* should be check valid or not when assigned,
rather than checking it here. Actually we do make it valid when
assigned, the speed is either a valid value or PCI_SPEED_UNKNOWN.
And it's ensured in pcie_get_speed_cap(), pci_set_bus_speed()
when probe, and pcie_link_speed[] array. Please check again for
sure.

 drivers/pci/pci-sysfs.c |  2 +-
 drivers/pci/pci.c       |  6 +++---
 drivers/pci/pci.h       | 10 +++-------
 drivers/pci/slot.c      | 10 +++-------
 4 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 13f766d..f4eafbc 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -156,7 +156,7 @@ static ssize_t max_link_speed_show(struct device *dev,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);

-	return sprintf(buf, "%s\n", PCIE_SPEED2STR(pcie_get_speed_cap(pdev)));
+	return sprintf(buf, "%s\n", PCI_SPEED2STR(pcie_get_speed_cap(pdev)));
 }
 static DEVICE_ATTR_RO(max_link_speed);

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e87196c..dce32ce 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5868,14 +5868,14 @@ void __pcie_print_link_status(struct pci_dev *dev, bool verbose)
 	if (bw_avail >= bw_cap && verbose)
 		pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth (%s x%d link)\n",
 			 bw_cap / 1000, bw_cap % 1000,
-			 PCIE_SPEED2STR(speed_cap), width_cap);
+			 PCI_SPEED2STR(speed_cap), width_cap);
 	else if (bw_avail < bw_cap)
 		pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth, limited by %s x%d link at %s (capable of %u.%03u Gb/s with %s x%d link)\n",
 			 bw_avail / 1000, bw_avail % 1000,
-			 PCIE_SPEED2STR(speed), width,
+			 PCI_SPEED2STR(speed), width,
 			 limiting_dev ? pci_name(limiting_dev) : "<unknown>",
 			 bw_cap / 1000, bw_cap % 1000,
-			 PCIE_SPEED2STR(speed_cap), width_cap);
+			 PCI_SPEED2STR(speed_cap), width_cap);
 }

 /**
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 5fb1d76..5e1f810 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -291,13 +291,9 @@ struct pci_bus *pci_bus_get(struct pci_bus *bus);
 void pci_bus_put(struct pci_bus *bus);

 /* PCIe link information */
-#define PCIE_SPEED2STR(speed) \
-	((speed) == PCIE_SPEED_32_0GT ? "32 GT/s" : \
-	 (speed) == PCIE_SPEED_16_0GT ? "16 GT/s" : \
-	 (speed) == PCIE_SPEED_8_0GT ? "8 GT/s" : \
-	 (speed) == PCIE_SPEED_5_0GT ? "5 GT/s" : \
-	 (speed) == PCIE_SPEED_2_5GT ? "2.5 GT/s" : \
-	 "Unknown speed")
+#define PCI_SPEED2STR(speed) \
+	((speed) == PCI_SPEED_UNKNOWN ? "Unknown speed" : \
+	 pci_bus_speed_strings[speed])

 /* PCIe speed to Mb/s reduced by encoding overhead */
 #define PCIE_SPEED2MBS_ENC(speed) \
diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index 140dafb..871d598 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -51,14 +51,10 @@ static ssize_t address_read_file(struct pci_slot *slot, char *buf)

 static ssize_t bus_speed_read(enum pci_bus_speed speed, char *buf)
 {
-	const char *speed_string;
+	if (speed <= PCI_SPEED_133MHz_PCIX_533)
+		return sprintf(buf, "%s\n", PCI_SPEED2STR(speed));

-	if (speed == PCI_SPEED_UNKNOWN)
-		speed_string = "Unknown";
-	else
-		speed_string = pci_bus_speed_strings[speed];
-
-	return sprintf(buf, "%s\n", speed_string);
+	return sprintf(buf, "%s PCIe\n", PCI_SPEED2STR(speed));
 }

 static ssize_t max_speed_read_file(struct pci_slot *slot, char *buf)
--
2.8.1

