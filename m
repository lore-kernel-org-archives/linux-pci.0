Return-Path: <SRS0=/7fE=SK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B05C282CE
	for <linux-pci@archiver.kernel.org>; Mon,  8 Apr 2019 06:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 644DE20833
	for <linux-pci@archiver.kernel.org>; Mon,  8 Apr 2019 06:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfDHGgD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Apr 2019 02:36:03 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:47288 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfDHGgD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Apr 2019 02:36:03 -0400
X-IronPort-AV: E=Sophos;i="5.60,324,1549954800"; 
   d="scan'208";a="29649301"
Received: from unknown (HELO smtp.microsemi.com) ([208.19.100.22])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Apr 2019 23:35:57 -0700
Received: from AVMBX3.microsemi.net (10.100.34.33) by AVMBX2.microsemi.net
 (10.100.34.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 7 Apr 2019
 23:35:56 -0700
Received: from server1.microsemi.net (10.188.116.154) by avmbx3.microsemi.net
 (10.100.34.33) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sun, 7 Apr 2019 23:35:53 -0700
From:   Wesley Sheng <wesley.sheng@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <logang@deltatee.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <wesleyshenggit@sina.com>, <wesley.sheng@microchip.com>,
        <kelvin.cao@microchip.com>
Subject: [PATCH 1/2] switchtec: Fix false maximum supported PCIe function number issue
Date:   Mon, 8 Apr 2019 22:34:47 +0800
Message-ID: <1554734088-5755-2-git-send-email-wesley.sheng@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554734088-5755-1-git-send-email-wesley.sheng@microchip.com>
References: <1554734088-5755-1-git-send-email-wesley.sheng@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The hardware supports up to 255 PFFs and the driver only supports 48, so
this patch updates the driver to support them all.
To be backward compatible, a new ioctl and corresponding data
structure are created, while keep the deprecated one.

Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
---
 drivers/pci/switch/switchtec.c       | 39 +++++++++++++++++++++++++-----------
 include/linux/switchtec.h            |  2 +-
 include/uapi/linux/switchtec_ioctl.h | 13 +++++++++++-
 3 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index e22766c..7df9a69 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -658,19 +658,25 @@ static int ioctl_flash_part_info(struct switchtec_dev *stdev,
 
 static int ioctl_event_summary(struct switchtec_dev *stdev,
 	struct switchtec_user *stuser,
-	struct switchtec_ioctl_event_summary __user *usum)
+	struct switchtec_ioctl_event_summary __user *usum,
+	size_t size)
 {
-	struct switchtec_ioctl_event_summary s = {0};
+	struct switchtec_ioctl_event_summary *s;
 	int i;
 	u32 reg;
+	int ret = 0;
 
-	s.global = ioread32(&stdev->mmio_sw_event->global_summary);
-	s.part_bitmap = ioread32(&stdev->mmio_sw_event->part_event_bitmap);
-	s.local_part = ioread32(&stdev->mmio_part_cfg->part_event_summary);
+	s = kzalloc(sizeof(*s), GFP_KERNEL);
+	if (!s)
+		return -ENOMEM;
+
+	s->global = ioread32(&stdev->mmio_sw_event->global_summary);
+	s->part_bitmap = ioread32(&stdev->mmio_sw_event->part_event_bitmap);
+	s->local_part = ioread32(&stdev->mmio_part_cfg->part_event_summary);
 
 	for (i = 0; i < stdev->partition_count; i++) {
 		reg = ioread32(&stdev->mmio_part_cfg_all[i].part_event_summary);
-		s.part[i] = reg;
+		s->part[i] = reg;
 	}
 
 	for (i = 0; i < SWITCHTEC_MAX_PFF_CSR; i++) {
@@ -679,15 +685,19 @@ static int ioctl_event_summary(struct switchtec_dev *stdev,
 			break;
 
 		reg = ioread32(&stdev->mmio_pff_csr[i].pff_event_summary);
-		s.pff[i] = reg;
+		s->pff[i] = reg;
 	}
 
-	if (copy_to_user(usum, &s, sizeof(s)))
-		return -EFAULT;
+	if (copy_to_user(usum, s, size)) {
+		ret = -EFAULT;
+		goto error_case;
+	}
 
 	stuser->event_cnt = atomic_read(&stdev->event_cnt);
 
-	return 0;
+error_case:
+	kfree(s);
+	return ret;
 }
 
 static u32 __iomem *global_ev_reg(struct switchtec_dev *stdev,
@@ -977,8 +987,9 @@ static long switchtec_dev_ioctl(struct file *filp, unsigned int cmd,
 	case SWITCHTEC_IOCTL_FLASH_PART_INFO:
 		rc = ioctl_flash_part_info(stdev, argp);
 		break;
-	case SWITCHTEC_IOCTL_EVENT_SUMMARY:
-		rc = ioctl_event_summary(stdev, stuser, argp);
+	case SWITCHTEC_IOCTL_EVENT_SUMMARY_LEGACY:
+		rc = ioctl_event_summary(stdev, stuser, argp,
+					 sizeof(struct switchtec_ioctl_event_summary_legacy));
 		break;
 	case SWITCHTEC_IOCTL_EVENT_CTL:
 		rc = ioctl_event_ctl(stdev, argp);
@@ -989,6 +1000,10 @@ static long switchtec_dev_ioctl(struct file *filp, unsigned int cmd,
 	case SWITCHTEC_IOCTL_PORT_TO_PFF:
 		rc = ioctl_port_to_pff(stdev, argp);
 		break;
+	case SWITCHTEC_IOCTL_EVENT_SUMMARY:
+		rc = ioctl_event_summary(stdev, stuser, argp,
+					 sizeof(struct switchtec_ioctl_event_summary));
+		break;
 	default:
 		rc = -ENOTTY;
 		break;
diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
index 52a079b..0cfc34a 100644
--- a/include/linux/switchtec.h
+++ b/include/linux/switchtec.h
@@ -20,7 +20,7 @@
 #include <linux/cdev.h>
 
 #define SWITCHTEC_MRPC_PAYLOAD_SIZE 1024
-#define SWITCHTEC_MAX_PFF_CSR 48
+#define SWITCHTEC_MAX_PFF_CSR 255
 
 #define SWITCHTEC_EVENT_OCCURRED BIT(0)
 #define SWITCHTEC_EVENT_CLEAR    BIT(0)
diff --git a/include/uapi/linux/switchtec_ioctl.h b/include/uapi/linux/switchtec_ioctl.h
index 4f4daf8..c912b5a 100644
--- a/include/uapi/linux/switchtec_ioctl.h
+++ b/include/uapi/linux/switchtec_ioctl.h
@@ -50,7 +50,7 @@ struct switchtec_ioctl_flash_part_info {
 	__u32 active;
 };
 
-struct switchtec_ioctl_event_summary {
+struct switchtec_ioctl_event_summary_legacy {
 	__u64 global;
 	__u64 part_bitmap;
 	__u32 local_part;
@@ -59,6 +59,15 @@ struct switchtec_ioctl_event_summary {
 	__u32 pff[48];
 };
 
+struct switchtec_ioctl_event_summary {
+	__u64 global;
+	__u64 part_bitmap;
+	__u32 local_part;
+	__u32 padding;
+	__u32 part[48];
+	__u32 pff[255];
+};
+
 #define SWITCHTEC_IOCTL_EVENT_STACK_ERROR		0
 #define SWITCHTEC_IOCTL_EVENT_PPU_ERROR			1
 #define SWITCHTEC_IOCTL_EVENT_ISP_ERROR			2
@@ -127,6 +136,8 @@ struct switchtec_ioctl_pff_port {
 	_IOWR('W', 0x41, struct switchtec_ioctl_flash_part_info)
 #define SWITCHTEC_IOCTL_EVENT_SUMMARY \
 	_IOR('W', 0x42, struct switchtec_ioctl_event_summary)
+#define SWITCHTEC_IOCTL_EVENT_SUMMARY_LEGACY \
+	_IOR('W', 0x42, struct switchtec_ioctl_event_summary_legacy)
 #define SWITCHTEC_IOCTL_EVENT_CTL \
 	_IOWR('W', 0x43, struct switchtec_ioctl_event_ctl)
 #define SWITCHTEC_IOCTL_PFF_TO_PORT \
-- 
2.7.4

