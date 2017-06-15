Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:58782 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750727AbdFOUMe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Jun 2017 16:12:34 -0400
From: Logan Gunthorpe <logang@deltatee.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Logan Gunthorpe <logang@deltatee.com>
Date: Thu, 15 Jun 2017 14:12:23 -0600
Message-Id: <20170615201224.5371-2-logang@deltatee.com>
In-Reply-To: <20170615201224.5371-1-logang@deltatee.com>
References: <20170615201224.5371-1-logang@deltatee.com>
Subject: [PATCH 1/2] switchtec: running status flag to fw partition info ioctl
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This flag lets userspace know which firmware partitions are actually
currently in use as opposed to just active. (Active meaning they will
be in use for the next reboot, where as running means they are currently
in use.)

If an old kernel is in use, or the firmware doesn't support these
fields, the new flag will not be set in the output.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
---
 drivers/pci/switch/switchtec.c       | 22 ++++++++++++++++++++--
 include/uapi/linux/switchtec_ioctl.h |  3 +++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index f6a63406c76e..5cf59af989f4 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -120,6 +120,13 @@ struct sw_event_regs {
 	u32 reserved16[4];
 } __packed;
 
+enum {
+	SWITCHTEC_CFG0_RUNNING = 0x04,
+	SWITCHTEC_CFG1_RUNNING = 0x05,
+	SWITCHTEC_IMG0_RUNNING = 0x03,
+	SWITCHTEC_IMG1_RUNNING = 0x07,
+};
+
 struct sys_info_regs {
 	u32 device_id;
 	u32 device_version;
@@ -129,7 +136,9 @@ struct sys_info_regs {
 	u32 table_format_version;
 	u32 partition_id;
 	u32 cfg_file_fmt_version;
-	u32 reserved2[58];
+	u16 cfg_running;
+	u16 img_running;
+	u32 reserved2[57];
 	char vendor_id[8];
 	char product_id[16];
 	char product_revision[4];
@@ -807,6 +816,7 @@ static int ioctl_flash_part_info(struct switchtec_dev *stdev,
 {
 	struct switchtec_ioctl_flash_part_info info = {0};
 	struct flash_info_regs __iomem *fi = stdev->mmio_flash_info;
+	struct sys_info_regs __iomem *si = stdev->mmio_sys_info;
 	u32 active_addr = -1;
 
 	if (copy_from_user(&info, uinfo, sizeof(info)))
@@ -816,18 +826,26 @@ static int ioctl_flash_part_info(struct switchtec_dev *stdev,
 	case SWITCHTEC_IOCTL_PART_CFG0:
 		active_addr = ioread32(&fi->active_cfg);
 		set_fw_info_part(&info, &fi->cfg0);
+		if (ioread16(&si->cfg_running) == SWITCHTEC_CFG0_RUNNING)
+			info.active |= SWITCHTEC_IOCTL_PART_RUNNING;
 		break;
 	case SWITCHTEC_IOCTL_PART_CFG1:
 		active_addr = ioread32(&fi->active_cfg);
 		set_fw_info_part(&info, &fi->cfg1);
+		if (ioread16(&si->cfg_running) == SWITCHTEC_CFG1_RUNNING)
+			info.active |= SWITCHTEC_IOCTL_PART_RUNNING;
 		break;
 	case SWITCHTEC_IOCTL_PART_IMG0:
 		active_addr = ioread32(&fi->active_img);
 		set_fw_info_part(&info, &fi->img0);
+		if (ioread16(&si->img_running) == SWITCHTEC_IMG0_RUNNING)
+			info.active |= SWITCHTEC_IOCTL_PART_RUNNING;
 		break;
 	case SWITCHTEC_IOCTL_PART_IMG1:
 		active_addr = ioread32(&fi->active_img);
 		set_fw_info_part(&info, &fi->img1);
+		if (ioread16(&si->img_running) == SWITCHTEC_IMG1_RUNNING)
+			info.active |= SWITCHTEC_IOCTL_PART_RUNNING;
 		break;
 	case SWITCHTEC_IOCTL_PART_NVLOG:
 		set_fw_info_part(&info, &fi->nvlog);
@@ -861,7 +879,7 @@ static int ioctl_flash_part_info(struct switchtec_dev *stdev,
 	}
 
 	if (info.address == active_addr)
-		info.active = 1;
+		info.active |= SWITCHTEC_IOCTL_PART_ACTIVE;
 
 	if (copy_to_user(uinfo, &info, sizeof(info)))
 		return -EFAULT;
diff --git a/include/uapi/linux/switchtec_ioctl.h b/include/uapi/linux/switchtec_ioctl.h
index 3e824e1a6495..5e392968bad2 100644
--- a/include/uapi/linux/switchtec_ioctl.h
+++ b/include/uapi/linux/switchtec_ioctl.h
@@ -39,6 +39,9 @@ struct switchtec_ioctl_flash_info {
 	__u32 padding;
 };
 
+#define SWITCHTEC_IOCTL_PART_ACTIVE  1
+#define SWITCHTEC_IOCTL_PART_RUNNING 2
+
 struct switchtec_ioctl_flash_part_info {
 	__u32 flash_partition;
 	__u32 address;
-- 
2.11.0
