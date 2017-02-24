Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:35793 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751625AbdBXAJr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Feb 2017 19:09:47 -0500
From: Logan Gunthorpe <logang@deltatee.com>
To: Keith Busch <keith.busch@intel.com>,
        Myron Stowe <myron.stowe@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Wei Zhang <wzhang@fb.com>
Cc: Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <stephen.bates@microsemi.com>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Logan Gunthorpe <logang@deltatee.com>
Date: Thu, 23 Feb 2017 17:07:24 -0700
Message-Id: <1487894844-2721-5-git-send-email-logang@deltatee.com>
In-Reply-To: <1487894844-2721-1-git-send-email-logang@deltatee.com>
References: <1487894844-2721-1-git-send-email-logang@deltatee.com>
Subject: [PATCH v3 4/4] switchtec: Add IOCTLs to the Switchtec driver
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch introduces a couple of special IOCTLs which are provided to:

* Inform userspace of firmware partition locations
* Pass event counts and allow userspace to wait on events
* Translate between PFF numbers used by the switch to
  port numbers.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Stephen Bates <stephen.bates@microsemi.com>
Tested-by: Krishna Dhulipala <krishnad@fb.com>
Reviewed-by: Wei Zhang <wzhang@fb.com>
Reviewed-by: Jens Axboe <axboe@fb.com>
---
 Documentation/ioctl/ioctl-number.txt |   1 +
 Documentation/switchtec.txt          |  27 ++
 MAINTAINERS                          |   1 +
 drivers/pci/switch/switchtec.c       | 467 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/switchtec_ioctl.h | 132 ++++++++++
 5 files changed, 628 insertions(+)
 create mode 100644 include/uapi/linux/switchtec_ioctl.h

diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/ioctl-number.txt
index 81c7f2b..032b33c 100644
--- a/Documentation/ioctl/ioctl-number.txt
+++ b/Documentation/ioctl/ioctl-number.txt
@@ -191,6 +191,7 @@ Code  Seq#(hex)	Include File		Comments
 'W'	00-1F	linux/watchdog.h	conflict!
 'W'	00-1F	linux/wanrouter.h	conflict!		(pre 3.9)
 'W'	00-3F	sound/asound.h		conflict!
+'W'	40-5F   drivers/pci/switch/switchtec.c
 'X'	all	fs/xfs/xfs_fs.h		conflict!
 		and fs/xfs/linux-2.6/xfs_ioctl32.h
 		and include/linux/falloc.h
diff --git a/Documentation/switchtec.txt b/Documentation/switchtec.txt
index 4bced4c..a0a9c7b 100644
--- a/Documentation/switchtec.txt
+++ b/Documentation/switchtec.txt
@@ -51,3 +51,30 @@ The char device has the following semantics:
 
 * The poll call will also be supported for userspace applications that
   need to do other things while waiting for the command to complete.
+
+The following IOCTLs are also supported by the device:
+
+* SWITCHTEC_IOCTL_FLASH_INFO - Retrieve firmware length and number
+  of partitions in the device.
+
+* SWITCHTEC_IOCTL_FLASH_PART_INFO - Retrieve address and lengeth for
+  any specified partition in flash.
+
+* SWITCHTEC_IOCTL_EVENT_SUMMARY - Read a structure of bitmaps
+  indicating all uncleared events.
+
+* SWITCHTEC_IOCTL_EVENT_CTL - Get the current count, clear and set flags
+  for any event. This ioctl takes in a switchtec_ioctl_event_ctl struct
+  with the event_id, index and flags set (index being the partition or PFF
+  number for non-global events). It returns whether the event has
+  occurred, the number of times and any event specific data. The flags
+  can be used to clear the count or enable and disable actions to
+  happen when the event occurs.
+  By using the SWITCHTEC_IOCTL_EVENT_FLAG_EN_POLL flag,
+  you can set an event to trigger a poll command to return with
+  POLLPRI. In this way, userspace can wait for events to occur.
+
+* SWITCHTEC_IOCTL_PFF_TO_PORT and SWITCHTEC_IOCTL_PORT_TO_PFF convert
+  between PCI Function Framework number (used by the event system)
+  and Switchtec Logic Port ID and Partition number (which is more
+  user friendly).
diff --git a/MAINTAINERS b/MAINTAINERS
index 6fed938..c1a9a30 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9515,6 +9515,7 @@ S:	Maintained
 F:	Documentation/switchtec.txt
 F:	Documentation/ABI/testing/sysfs-class-switchtec
 F:	drivers/pci/switch/switchtec*
+F:	include/uapi/linux/switchtec_ioctl.h
 
 PCI DRIVER FOR NVIDIA TEGRA
 M:	Thierry Reding <thierry.reding@gmail.com>
diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index c09d335..04d35f4 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -13,6 +13,8 @@
  *
  */
 
+#include <linux/switchtec_ioctl.h>
+
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/fs.h>
@@ -755,6 +757,417 @@ static unsigned int switchtec_dev_poll(struct file *filp, poll_table *wait)
 	return ret;
 }
 
+static int ioctl_flash_info(struct switchtec_dev *stdev,
+			    struct switchtec_ioctl_flash_info __user *uinfo)
+{
+	struct switchtec_ioctl_flash_info info = {0};
+	struct flash_info_regs __iomem *fi = stdev->mmio_flash_info;
+
+	info.flash_length = ioread32(&fi->flash_length);
+	info.num_partitions = SWITCHTEC_IOCTL_NUM_PARTITIONS;
+
+	if (copy_to_user(uinfo, &info, sizeof(info)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static void set_fw_info_part(struct switchtec_ioctl_flash_part_info *info,
+			     struct partition_info __iomem *pi)
+{
+	info->address = ioread32(&pi->address);
+	info->length = ioread32(&pi->length);
+}
+
+static int ioctl_flash_part_info(struct switchtec_dev *stdev,
+	struct switchtec_ioctl_flash_part_info __user *uinfo)
+{
+	struct switchtec_ioctl_flash_part_info info = {0};
+	struct flash_info_regs __iomem *fi = stdev->mmio_flash_info;
+	u32 active_addr = -1;
+
+	if (copy_from_user(&info, uinfo, sizeof(info)))
+		return -EFAULT;
+
+	switch (info.flash_partition) {
+	case SWITCHTEC_IOCTL_PART_CFG0:
+		active_addr = ioread32(&fi->active_cfg);
+		set_fw_info_part(&info, &fi->cfg0);
+		break;
+	case SWITCHTEC_IOCTL_PART_CFG1:
+		active_addr = ioread32(&fi->active_cfg);
+		set_fw_info_part(&info, &fi->cfg1);
+		break;
+	case SWITCHTEC_IOCTL_PART_IMG0:
+		active_addr = ioread32(&fi->active_img);
+		set_fw_info_part(&info, &fi->img0);
+		break;
+	case SWITCHTEC_IOCTL_PART_IMG1:
+		active_addr = ioread32(&fi->active_img);
+		set_fw_info_part(&info, &fi->img1);
+		break;
+	case SWITCHTEC_IOCTL_PART_NVLOG:
+		set_fw_info_part(&info, &fi->nvlog);
+		break;
+	case SWITCHTEC_IOCTL_PART_VENDOR0:
+		set_fw_info_part(&info, &fi->vendor[0]);
+		break;
+	case SWITCHTEC_IOCTL_PART_VENDOR1:
+		set_fw_info_part(&info, &fi->vendor[1]);
+		break;
+	case SWITCHTEC_IOCTL_PART_VENDOR2:
+		set_fw_info_part(&info, &fi->vendor[2]);
+		break;
+	case SWITCHTEC_IOCTL_PART_VENDOR3:
+		set_fw_info_part(&info, &fi->vendor[3]);
+		break;
+	case SWITCHTEC_IOCTL_PART_VENDOR4:
+		set_fw_info_part(&info, &fi->vendor[4]);
+		break;
+	case SWITCHTEC_IOCTL_PART_VENDOR5:
+		set_fw_info_part(&info, &fi->vendor[5]);
+		break;
+	case SWITCHTEC_IOCTL_PART_VENDOR6:
+		set_fw_info_part(&info, &fi->vendor[6]);
+		break;
+	case SWITCHTEC_IOCTL_PART_VENDOR7:
+		set_fw_info_part(&info, &fi->vendor[7]);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (info.address == active_addr)
+		info.active = 1;
+
+	if (copy_to_user(uinfo, &info, sizeof(info)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int ioctl_event_summary(struct switchtec_dev *stdev,
+	struct switchtec_user *stuser,
+	struct switchtec_ioctl_event_summary __user *usum)
+{
+	struct switchtec_ioctl_event_summary s = {0};
+	int i;
+	u32 reg;
+
+	s.global = ioread32(&stdev->mmio_sw_event->global_summary);
+	s.part_bitmap = ioread32(&stdev->mmio_sw_event->part_event_bitmap);
+	s.local_part = ioread32(&stdev->mmio_part_cfg->part_event_summary);
+
+	for (i = 0; i < stdev->partition_count; i++) {
+		reg = ioread32(&stdev->mmio_part_cfg_all[i].part_event_summary);
+		s.part[i] = reg;
+	}
+
+	for (i = 0; i < SWITCHTEC_MAX_PFF_CSR; i++) {
+		reg = ioread16(&stdev->mmio_pff_csr[i].vendor_id);
+		if (reg != MICROSEMI_VENDOR_ID)
+			break;
+
+		reg = ioread32(&stdev->mmio_pff_csr[i].pff_event_summary);
+		s.pff[i] = reg;
+	}
+
+	if (copy_to_user(usum, &s, sizeof(s)))
+		return -EFAULT;
+
+	stuser->event_cnt = atomic_read(&stdev->event_cnt);
+
+	return 0;
+}
+
+static u32 __iomem *global_ev_reg(struct switchtec_dev *stdev,
+				  size_t offset, int index)
+{
+	return (void __iomem *)stdev->mmio_sw_event + offset;
+}
+
+static u32 __iomem *part_ev_reg(struct switchtec_dev *stdev,
+				size_t offset, int index)
+{
+	return (void __iomem *)&stdev->mmio_part_cfg_all[index] + offset;
+}
+
+static u32 __iomem *pff_ev_reg(struct switchtec_dev *stdev,
+			       size_t offset, int index)
+{
+	return (void __iomem *)&stdev->mmio_pff_csr[index] + offset;
+}
+
+#define EV_GLB(i, r)[i] = {offsetof(struct sw_event_regs, r), global_ev_reg}
+#define EV_PAR(i, r)[i] = {offsetof(struct part_cfg_regs, r), part_ev_reg}
+#define EV_PFF(i, r)[i] = {offsetof(struct pff_csr_regs, r), pff_ev_reg}
+
+const struct event_reg {
+	size_t offset;
+	u32 __iomem *(*map_reg)(struct switchtec_dev *stdev,
+				size_t offset, int index);
+} event_regs[] = {
+	EV_GLB(SWITCHTEC_IOCTL_EVENT_STACK_ERROR, stack_error_event_hdr),
+	EV_GLB(SWITCHTEC_IOCTL_EVENT_PPU_ERROR, ppu_error_event_hdr),
+	EV_GLB(SWITCHTEC_IOCTL_EVENT_ISP_ERROR, isp_error_event_hdr),
+	EV_GLB(SWITCHTEC_IOCTL_EVENT_SYS_RESET, sys_reset_event_hdr),
+	EV_GLB(SWITCHTEC_IOCTL_EVENT_FW_EXC, fw_exception_hdr),
+	EV_GLB(SWITCHTEC_IOCTL_EVENT_FW_NMI, fw_nmi_hdr),
+	EV_GLB(SWITCHTEC_IOCTL_EVENT_FW_NON_FATAL, fw_non_fatal_hdr),
+	EV_GLB(SWITCHTEC_IOCTL_EVENT_FW_FATAL, fw_fatal_hdr),
+	EV_GLB(SWITCHTEC_IOCTL_EVENT_TWI_MRPC_COMP, twi_mrpc_comp_hdr),
+	EV_GLB(SWITCHTEC_IOCTL_EVENT_TWI_MRPC_COMP_ASYNC,
+	       twi_mrpc_comp_async_hdr),
+	EV_GLB(SWITCHTEC_IOCTL_EVENT_CLI_MRPC_COMP, cli_mrpc_comp_hdr),
+	EV_GLB(SWITCHTEC_IOCTL_EVENT_CLI_MRPC_COMP_ASYNC,
+	       cli_mrpc_comp_async_hdr),
+	EV_GLB(SWITCHTEC_IOCTL_EVENT_GPIO_INT, gpio_interrupt_hdr),
+	EV_PAR(SWITCHTEC_IOCTL_EVENT_PART_RESET, part_reset_hdr),
+	EV_PAR(SWITCHTEC_IOCTL_EVENT_MRPC_COMP, mrpc_comp_hdr),
+	EV_PAR(SWITCHTEC_IOCTL_EVENT_MRPC_COMP_ASYNC, mrpc_comp_async_hdr),
+	EV_PAR(SWITCHTEC_IOCTL_EVENT_DYN_PART_BIND_COMP, dyn_binding_hdr),
+	EV_PFF(SWITCHTEC_IOCTL_EVENT_AER_IN_P2P, aer_in_p2p_hdr),
+	EV_PFF(SWITCHTEC_IOCTL_EVENT_AER_IN_VEP, aer_in_vep_hdr),
+	EV_PFF(SWITCHTEC_IOCTL_EVENT_DPC, dpc_hdr),
+	EV_PFF(SWITCHTEC_IOCTL_EVENT_CTS, cts_hdr),
+	EV_PFF(SWITCHTEC_IOCTL_EVENT_HOTPLUG, hotplug_hdr),
+	EV_PFF(SWITCHTEC_IOCTL_EVENT_IER, ier_hdr),
+	EV_PFF(SWITCHTEC_IOCTL_EVENT_THRESH, threshold_hdr),
+	EV_PFF(SWITCHTEC_IOCTL_EVENT_POWER_MGMT, power_mgmt_hdr),
+	EV_PFF(SWITCHTEC_IOCTL_EVENT_TLP_THROTTLING, tlp_throttling_hdr),
+	EV_PFF(SWITCHTEC_IOCTL_EVENT_FORCE_SPEED, force_speed_hdr),
+	EV_PFF(SWITCHTEC_IOCTL_EVENT_CREDIT_TIMEOUT, credit_timeout_hdr),
+	EV_PFF(SWITCHTEC_IOCTL_EVENT_LINK_STATE, link_state_hdr),
+};
+
+static u32 __iomem *event_hdr_addr(struct switchtec_dev *stdev,
+				   int event_id, int index)
+{
+	size_t off;
+
+	if (event_id < 0 || event_id >= SWITCHTEC_IOCTL_MAX_EVENTS)
+		return ERR_PTR(-EINVAL);
+
+	off = event_regs[event_id].offset;
+
+	if (event_regs[event_id].map_reg == part_ev_reg) {
+		if (index == SWITCHTEC_IOCTL_EVENT_LOCAL_PART_IDX)
+			index = stdev->partition;
+		else if (index < 0 || index >= stdev->partition_count)
+			return ERR_PTR(-EINVAL);
+	} else if (event_regs[event_id].map_reg == pff_ev_reg) {
+		if (index < 0 || index >= stdev->pff_csr_count)
+			return ERR_PTR(-EINVAL);
+	}
+
+	return event_regs[event_id].map_reg(stdev, off, index);
+}
+
+static int event_ctl(struct switchtec_dev *stdev,
+		     struct switchtec_ioctl_event_ctl *ctl)
+{
+	int i;
+	u32 __iomem *reg;
+	u32 hdr;
+
+	reg = event_hdr_addr(stdev, ctl->event_id, ctl->index);
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
+
+	hdr = ioread32(reg);
+	for (i = 0; i < ARRAY_SIZE(ctl->data); i++)
+		ctl->data[i] = ioread32(&reg[i + 1]);
+
+	ctl->occurred = hdr & SWITCHTEC_EVENT_OCCURRED;
+	ctl->count = (hdr >> 5) & 0xFF;
+
+	if (!(ctl->flags & SWITCHTEC_IOCTL_EVENT_FLAG_CLEAR))
+		hdr &= ~SWITCHTEC_EVENT_CLEAR;
+	if (ctl->flags & SWITCHTEC_IOCTL_EVENT_FLAG_EN_POLL)
+		hdr |= SWITCHTEC_EVENT_EN_IRQ;
+	if (ctl->flags & SWITCHTEC_IOCTL_EVENT_FLAG_DIS_POLL)
+		hdr &= ~SWITCHTEC_EVENT_EN_IRQ;
+	if (ctl->flags & SWITCHTEC_IOCTL_EVENT_FLAG_EN_LOG)
+		hdr |= SWITCHTEC_EVENT_EN_LOG;
+	if (ctl->flags & SWITCHTEC_IOCTL_EVENT_FLAG_DIS_LOG)
+		hdr &= ~SWITCHTEC_EVENT_EN_LOG;
+	if (ctl->flags & SWITCHTEC_IOCTL_EVENT_FLAG_EN_CLI)
+		hdr |= SWITCHTEC_EVENT_EN_CLI;
+	if (ctl->flags & SWITCHTEC_IOCTL_EVENT_FLAG_DIS_CLI)
+		hdr &= ~SWITCHTEC_EVENT_EN_CLI;
+	if (ctl->flags & SWITCHTEC_IOCTL_EVENT_FLAG_EN_FATAL)
+		hdr |= SWITCHTEC_EVENT_FATAL;
+	if (ctl->flags & SWITCHTEC_IOCTL_EVENT_FLAG_DIS_FATAL)
+		hdr &= ~SWITCHTEC_EVENT_FATAL;
+
+	if (ctl->flags)
+		iowrite32(hdr, reg);
+
+	ctl->flags = 0;
+	if (hdr & SWITCHTEC_EVENT_EN_IRQ)
+		ctl->flags |= SWITCHTEC_IOCTL_EVENT_FLAG_EN_POLL;
+	if (hdr & SWITCHTEC_EVENT_EN_LOG)
+		ctl->flags |= SWITCHTEC_IOCTL_EVENT_FLAG_EN_LOG;
+	if (hdr & SWITCHTEC_EVENT_EN_CLI)
+		ctl->flags |= SWITCHTEC_IOCTL_EVENT_FLAG_EN_CLI;
+	if (hdr & SWITCHTEC_EVENT_FATAL)
+		ctl->flags |= SWITCHTEC_IOCTL_EVENT_FLAG_EN_FATAL;
+
+	return 0;
+}
+
+static int ioctl_event_ctl(struct switchtec_dev *stdev,
+	struct switchtec_ioctl_event_ctl __user *uctl)
+{
+	int ret;
+	int nr_idxs;
+	struct switchtec_ioctl_event_ctl ctl;
+
+	if (copy_from_user(&ctl, uctl, sizeof(ctl)))
+		return -EFAULT;
+
+	if (ctl.event_id > SWITCHTEC_IOCTL_MAX_EVENTS)
+		return -EINVAL;
+
+	if (ctl.flags & SWITCHTEC_IOCTL_EVENT_FLAG_UNUSED)
+		return -EINVAL;
+
+	if (ctl.index == SWITCHTEC_IOCTL_EVENT_IDX_ALL) {
+		if (event_regs[ctl.event_id].map_reg == global_ev_reg)
+			nr_idxs = 1;
+		else if (event_regs[ctl.event_id].map_reg == part_ev_reg)
+			nr_idxs = stdev->partition_count;
+		else if (event_regs[ctl.event_id].map_reg == pff_ev_reg)
+			nr_idxs = stdev->pff_csr_count;
+		else
+			return -EINVAL;
+
+		for (ctl.index = 0; ctl.index < nr_idxs; ctl.index++) {
+			ret = event_ctl(stdev, &ctl);
+			if (ret < 0)
+				return ret;
+		}
+	} else {
+		ret = event_ctl(stdev, &ctl);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (copy_to_user(uctl, &ctl, sizeof(ctl)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int ioctl_pff_to_port(struct switchtec_dev *stdev,
+			     struct switchtec_ioctl_pff_port *up)
+{
+	int i, part;
+	u32 reg;
+	struct part_cfg_regs *pcfg;
+	struct switchtec_ioctl_pff_port p;
+
+	if (copy_from_user(&p, up, sizeof(p)))
+		return -EFAULT;
+
+	p.port = -1;
+	for (part = 0; part < stdev->partition_count; part++) {
+		pcfg = &stdev->mmio_part_cfg_all[part];
+		p.partition = part;
+
+		reg = ioread32(&pcfg->usp_pff_inst_id);
+		if (reg == p.pff) {
+			p.port = 0;
+			break;
+		}
+
+		reg = ioread32(&pcfg->vep_pff_inst_id);
+		if (reg == p.pff) {
+			p.port = SWITCHTEC_IOCTL_PFF_VEP;
+			break;
+		}
+
+		for (i = 0; i < ARRAY_SIZE(pcfg->dsp_pff_inst_id); i++) {
+			reg = ioread32(&pcfg->dsp_pff_inst_id[i]);
+			if (reg != p.pff)
+				continue;
+
+			p.port = i + 1;
+			break;
+		}
+
+		if (p.port != -1)
+			break;
+	}
+
+	if (copy_to_user(up, &p, sizeof(p)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int ioctl_port_to_pff(struct switchtec_dev *stdev,
+			     struct switchtec_ioctl_pff_port *up)
+{
+	struct switchtec_ioctl_pff_port p;
+	struct part_cfg_regs *pcfg;
+
+	if (copy_from_user(&p, up, sizeof(p)))
+		return -EFAULT;
+
+	if (p.partition == SWITCHTEC_IOCTL_EVENT_LOCAL_PART_IDX)
+		pcfg = stdev->mmio_part_cfg;
+	else if (p.partition < stdev->partition_count)
+		pcfg = &stdev->mmio_part_cfg_all[p.partition];
+	else
+		return -EINVAL;
+
+	switch (p.port) {
+	case 0:
+		p.pff = ioread32(&pcfg->usp_pff_inst_id);
+		break;
+	case SWITCHTEC_IOCTL_PFF_VEP:
+		p.pff = ioread32(&pcfg->vep_pff_inst_id);
+		break;
+	default:
+		if (p.port > ARRAY_SIZE(pcfg->dsp_pff_inst_id))
+			return -EINVAL;
+		p.pff = ioread32(&pcfg->dsp_pff_inst_id[p.port - 1]);
+		break;
+	}
+
+	if (copy_to_user(up, &p, sizeof(p)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long switchtec_dev_ioctl(struct file *filp, unsigned int cmd,
+				unsigned long arg)
+{
+	struct switchtec_user *stuser = filp->private_data;
+	struct switchtec_dev *stdev = stuser->stdev;
+
+	void __user *argp = (void __user *)arg;
+
+	switch (cmd) {
+	case SWITCHTEC_IOCTL_FLASH_INFO:
+		return ioctl_flash_info(stdev, argp);
+	case SWITCHTEC_IOCTL_FLASH_PART_INFO:
+		return ioctl_flash_part_info(stdev, argp);
+	case SWITCHTEC_IOCTL_EVENT_SUMMARY:
+		return ioctl_event_summary(stdev, stuser, argp);
+	case SWITCHTEC_IOCTL_EVENT_CTL:
+		return ioctl_event_ctl(stdev, argp);
+	case SWITCHTEC_IOCTL_PFF_TO_PORT:
+		return ioctl_pff_to_port(stdev, argp);
+	case SWITCHTEC_IOCTL_PORT_TO_PFF:
+		return ioctl_port_to_pff(stdev, argp);
+	default:
+		return -ENOTTY;
+	}
+}
+
 static const struct file_operations switchtec_fops = {
 	.owner = THIS_MODULE,
 	.open = switchtec_dev_open,
@@ -762,6 +1175,8 @@ static const struct file_operations switchtec_fops = {
 	.write = switchtec_dev_write,
 	.read = switchtec_dev_read,
 	.poll = switchtec_dev_poll,
+	.unlocked_ioctl = switchtec_dev_ioctl,
+	.compat_ioctl = switchtec_dev_ioctl,
 };
 
 static void stdev_release(struct device *dev)
@@ -842,11 +1257,52 @@ static struct switchtec_dev *stdev_create(struct pci_dev *pdev)
 	return ERR_PTR(rc);
 }
 
+static int mask_event(struct switchtec_dev *stdev, int eid, int idx)
+{
+	size_t off = event_regs[eid].offset;
+	u32 __iomem *hdr_reg;
+	u32 hdr;
+
+	hdr_reg = event_regs[eid].map_reg(stdev, off, idx);
+	hdr = ioread32(hdr_reg);
+
+	if (!(hdr & SWITCHTEC_EVENT_OCCURRED && hdr & SWITCHTEC_EVENT_EN_IRQ))
+		return 0;
+
+	dev_dbg(&stdev->dev, "%s: %d %d %x\n", __func__, eid, idx, hdr);
+	hdr &= ~(SWITCHTEC_EVENT_EN_IRQ | SWITCHTEC_EVENT_OCCURRED);
+	iowrite32(hdr, hdr_reg);
+
+	return 1;
+}
+
+static int mask_all_events(struct switchtec_dev *stdev, int eid)
+{
+	int idx;
+	int count = 0;
+
+	if (event_regs[eid].map_reg == part_ev_reg) {
+		for (idx = 0; idx < stdev->partition_count; idx++)
+			count += mask_event(stdev, eid, idx);
+	} else if (event_regs[eid].map_reg == pff_ev_reg) {
+		for (idx = 0; idx < stdev->pff_csr_count; idx++) {
+			if (!stdev->pff_local[idx])
+				continue;
+			count += mask_event(stdev, eid, idx);
+		}
+	} else {
+		count += mask_event(stdev, eid, 0);
+	}
+
+	return count;
+}
+
 static irqreturn_t switchtec_event_isr(int irq, void *dev)
 {
 	struct switchtec_dev *stdev = dev;
 	u32 reg;
 	irqreturn_t ret = IRQ_NONE;
+	int eid, event_count = 0;
 
 	reg = ioread32(&stdev->mmio_part_cfg->mrpc_comp_hdr);
 	if (reg & SWITCHTEC_EVENT_OCCURRED) {
@@ -856,6 +1312,17 @@ static irqreturn_t switchtec_event_isr(int irq, void *dev)
 		iowrite32(reg, &stdev->mmio_part_cfg->mrpc_comp_hdr);
 	}
 
+	for (eid = 0; eid < SWITCHTEC_IOCTL_MAX_EVENTS; eid++)
+		event_count += mask_all_events(stdev, eid);
+
+	if (event_count) {
+		atomic_inc(&stdev->event_cnt);
+		wake_up_interruptible(&stdev->event_wq);
+		dev_dbg(&stdev->dev, "%s: %d events\n", __func__,
+			event_count);
+		return IRQ_HANDLED;
+	}
+
 	return ret;
 }
 
diff --git a/include/uapi/linux/switchtec_ioctl.h b/include/uapi/linux/switchtec_ioctl.h
new file mode 100644
index 0000000..3e824e1
--- /dev/null
+++ b/include/uapi/linux/switchtec_ioctl.h
@@ -0,0 +1,132 @@
+/*
+ * Microsemi Switchtec PCIe Driver
+ * Copyright (c) 2017, Microsemi Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ */
+
+#ifndef _UAPI_LINUX_SWITCHTEC_IOCTL_H
+#define _UAPI_LINUX_SWITCHTEC_IOCTL_H
+
+#include <linux/types.h>
+
+#define SWITCHTEC_IOCTL_PART_CFG0	0
+#define SWITCHTEC_IOCTL_PART_CFG1	1
+#define SWITCHTEC_IOCTL_PART_IMG0	2
+#define SWITCHTEC_IOCTL_PART_IMG1	3
+#define SWITCHTEC_IOCTL_PART_NVLOG	4
+#define SWITCHTEC_IOCTL_PART_VENDOR0	5
+#define SWITCHTEC_IOCTL_PART_VENDOR1	6
+#define SWITCHTEC_IOCTL_PART_VENDOR2	7
+#define SWITCHTEC_IOCTL_PART_VENDOR3	8
+#define SWITCHTEC_IOCTL_PART_VENDOR4	9
+#define SWITCHTEC_IOCTL_PART_VENDOR5	10
+#define SWITCHTEC_IOCTL_PART_VENDOR6	11
+#define SWITCHTEC_IOCTL_PART_VENDOR7	12
+#define SWITCHTEC_IOCTL_NUM_PARTITIONS	13
+
+struct switchtec_ioctl_flash_info {
+	__u64 flash_length;
+	__u32 num_partitions;
+	__u32 padding;
+};
+
+struct switchtec_ioctl_flash_part_info {
+	__u32 flash_partition;
+	__u32 address;
+	__u32 length;
+	__u32 active;
+};
+
+struct switchtec_ioctl_event_summary {
+	__u64 global;
+	__u64 part_bitmap;
+	__u32 local_part;
+	__u32 padding;
+	__u32 part[48];
+	__u32 pff[48];
+};
+
+#define SWITCHTEC_IOCTL_EVENT_STACK_ERROR		0
+#define SWITCHTEC_IOCTL_EVENT_PPU_ERROR			1
+#define SWITCHTEC_IOCTL_EVENT_ISP_ERROR			2
+#define SWITCHTEC_IOCTL_EVENT_SYS_RESET			3
+#define SWITCHTEC_IOCTL_EVENT_FW_EXC			4
+#define SWITCHTEC_IOCTL_EVENT_FW_NMI			5
+#define SWITCHTEC_IOCTL_EVENT_FW_NON_FATAL		6
+#define SWITCHTEC_IOCTL_EVENT_FW_FATAL			7
+#define SWITCHTEC_IOCTL_EVENT_TWI_MRPC_COMP		8
+#define SWITCHTEC_IOCTL_EVENT_TWI_MRPC_COMP_ASYNC	9
+#define SWITCHTEC_IOCTL_EVENT_CLI_MRPC_COMP		10
+#define SWITCHTEC_IOCTL_EVENT_CLI_MRPC_COMP_ASYNC	11
+#define SWITCHTEC_IOCTL_EVENT_GPIO_INT			12
+#define SWITCHTEC_IOCTL_EVENT_PART_RESET		13
+#define SWITCHTEC_IOCTL_EVENT_MRPC_COMP			14
+#define SWITCHTEC_IOCTL_EVENT_MRPC_COMP_ASYNC		15
+#define SWITCHTEC_IOCTL_EVENT_DYN_PART_BIND_COMP	16
+#define SWITCHTEC_IOCTL_EVENT_AER_IN_P2P		17
+#define SWITCHTEC_IOCTL_EVENT_AER_IN_VEP		18
+#define SWITCHTEC_IOCTL_EVENT_DPC			19
+#define SWITCHTEC_IOCTL_EVENT_CTS			20
+#define SWITCHTEC_IOCTL_EVENT_HOTPLUG			21
+#define SWITCHTEC_IOCTL_EVENT_IER			22
+#define SWITCHTEC_IOCTL_EVENT_THRESH			23
+#define SWITCHTEC_IOCTL_EVENT_POWER_MGMT		24
+#define SWITCHTEC_IOCTL_EVENT_TLP_THROTTLING		25
+#define SWITCHTEC_IOCTL_EVENT_FORCE_SPEED		26
+#define SWITCHTEC_IOCTL_EVENT_CREDIT_TIMEOUT		27
+#define SWITCHTEC_IOCTL_EVENT_LINK_STATE		28
+#define SWITCHTEC_IOCTL_MAX_EVENTS			29
+
+#define SWITCHTEC_IOCTL_EVENT_LOCAL_PART_IDX -1
+#define SWITCHTEC_IOCTL_EVENT_IDX_ALL -2
+
+#define SWITCHTEC_IOCTL_EVENT_FLAG_CLEAR     (1 << 0)
+#define SWITCHTEC_IOCTL_EVENT_FLAG_EN_POLL   (1 << 1)
+#define SWITCHTEC_IOCTL_EVENT_FLAG_EN_LOG    (1 << 2)
+#define SWITCHTEC_IOCTL_EVENT_FLAG_EN_CLI    (1 << 3)
+#define SWITCHTEC_IOCTL_EVENT_FLAG_EN_FATAL  (1 << 4)
+#define SWITCHTEC_IOCTL_EVENT_FLAG_DIS_POLL  (1 << 5)
+#define SWITCHTEC_IOCTL_EVENT_FLAG_DIS_LOG   (1 << 6)
+#define SWITCHTEC_IOCTL_EVENT_FLAG_DIS_CLI   (1 << 7)
+#define SWITCHTEC_IOCTL_EVENT_FLAG_DIS_FATAL (1 << 8)
+#define SWITCHTEC_IOCTL_EVENT_FLAG_UNUSED    (~0x1ff)
+
+struct switchtec_ioctl_event_ctl {
+	__u32 event_id;
+	__s32 index;
+	__u32 flags;
+	__u32 occurred;
+	__u32 count;
+	__u32 data[5];
+};
+
+#define SWITCHTEC_IOCTL_PFF_VEP 100
+struct switchtec_ioctl_pff_port {
+	__u32 pff;
+	__u32 partition;
+	__u32 port;
+};
+
+#define SWITCHTEC_IOCTL_FLASH_INFO \
+	_IOR('W', 0x40, struct switchtec_ioctl_flash_info)
+#define SWITCHTEC_IOCTL_FLASH_PART_INFO \
+	_IOWR('W', 0x41, struct switchtec_ioctl_flash_part_info)
+#define SWITCHTEC_IOCTL_EVENT_SUMMARY \
+	_IOR('W', 0x42, struct switchtec_ioctl_event_summary)
+#define SWITCHTEC_IOCTL_EVENT_CTL \
+	_IOWR('W', 0x43, struct switchtec_ioctl_event_ctl)
+#define SWITCHTEC_IOCTL_PFF_TO_PORT \
+	_IOWR('W', 0x44, struct switchtec_ioctl_pff_port)
+#define SWITCHTEC_IOCTL_PORT_TO_PFF \
+	_IOWR('W', 0x45, struct switchtec_ioctl_pff_port)
+
+#endif
-- 
2.1.4
