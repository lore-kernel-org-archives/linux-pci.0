Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6964FB9A5
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 13:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417752; cv=none; b=AXiTOOg4hmP7IZ+qHe2I7EWnHHYqDZsZwCUC80t6iHVhpPhJt5VnPrx+F4qf3cA1PBx0AWw+fH4Eimep2HDeqjppgTNl8IYVztztMok78TmEMo5WEHjecGUDxT5unULHhcqJS5UUEG1GjX9GfCUL8TF/aQtWJMXE6TcvRnInc+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417752; c=relaxed/simple;
	bh=sg5TBl+tLDWPpz188ir3OEN5D80w8rBVK8A/+m0jbrU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RJdsvg/r9u+un2sWB11a+jZ4KkQpTswIMogLe41lwu8kS8p/zLGEPmDnu39oroD6X0gKOnDvmyK6dwkiJxg7wYadCuKxpC6An3l0UDsZwJMRIgfDsTMavds5zcAPzt6bUm0zO3TSVMe8bwwhi6r/o+KR7tGNy+AQxUfq5n+CeWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTPQw3q/; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTPQw3q/"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so4509590eec.0
        for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 06:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792417748; x=1793022548; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bEztdDDpFj8E/NzlIg6MGNFZJjN+6g55tMmgBsxZpdQ=;
        b=WTPQw3q/2ch6+c57GMFUxG/qzPWOCimZ08ObKn9oBcYnX7BHvP3yWFXtzb91Lzfeo3
         WYt5cRJYCyU/NnAGltvT/Bvk0e2QSHn4rVaFuz95899SFkfTk9xzdPxuN0GRHMLTriTh
         WiLi8xHO6LESczroYzQN4p5Ly+gcmJiEOPga9hJCuhBg0HvvbuB86xrQ16w1fG9GKG5z
         eYiZUgCOLJe0QqbEZC2N73LcU5cEAJSVJlnMHsjz5ZVU3fOT9XYMnzPF1BY/Mbjd0soc
         KHJtgpHVQlF189KEudjiQFjsl5OcFRcXqfdv+YDH+DHmqDVw9P4T1IwDh/yoXmOyUYAb
         Fv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792417748; x=1793022548;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bEztdDDpFj8E/NzlIg6MGNFZJjN+6g55tMmgBsxZpdQ=;
        b=m2QvOcRXlPOLxLX6BCKyi6JcHgtd2LwfDuxxZa8x0QcUhH5a26Jk8ZK+zEYNX7+Aj/
         sBd3LFoKW/Fub9e3KLB89S6cJMJFCJstXRPxuZml03bD2AAaA/VsTELypn4cGnUL2zGh
         RifcStAet+w8zrUAOTm7mi8U+B7GJS8E7GV0TkGl3LwGX1GxVZTy6PTJU278b871p/6d
         34qdGJJLSSnFsScc44JiLsDHUeY4H/cd8SZuRZaYQUi0QELgP++3hy5gytcRnzw35yjK
         3W6S7a65UyUndhBdqtmgCS+ZW5qXUAr/17BI26UBD4QTyUhTnR682MY+0V6XBz6Q9JWm
         VMqw==
X-Forwarded-Encrypted: i=1; AKwUvBwTUiRguoMxxLbSc9oHDCTkTFzzjLfDWU0Tow1lM+ls1LVkvc2mivM1pEo/pPSIi8T3CpRKimmPyJ8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJCq+xXTsefXupoGAp6tSTDzfEORaA+Timpwkccw0JRPTEROq0D
	t4jiGtEfrcMFGNHpHAFWIT9vblZkUcWaXUNN+ykMtkE8Lagm02/SWfb4
X-Gm-Gg: AYBFou3/LPoZN+lWP+BoRoj/DToPLYxkSi24V4pUEqiZa5koVksJNZdlNXbfGeOHVIc
	CPtwXW30HFAyxnKiOa9SYf00GSd0t3aPxIu7plDPfr1YbkK2NahSbWUswE41Q0EMviuZ7EtR+Gi
	LAL8gIX/56s+G1Mz1EM4B9ybpMKyZvD6sQE4wV1P5/xp0P3YvUHJJXwMrAvf3WlMFRotJ0O89gX
	oKJZcw0VZl7/AEfcQjqQzv+YW4eQW3UAfWlgvB04eGswOosv8AA+zvXH40qNxJRHV9zT8yOKjcv
	+d1G0QGKN0taHEyTpvOPtW/kr+M5se9lklB6m/ilSWz7XTEEgj1QrVDyDyqFsJH99EXFED+zXi5
	7JSZ/1wXYOOYkqJPBAbCa9sLFw6OscxxtsEHDafQkkQdtVmSyecNdgAdUbnfZLf4m3uPOGcD/nT
	5+L7+BuTsPf+C3R0NoXt7RGCNOGh8j/daYHStOmWRaovu1nlvsJ2Xz7GW3mtufL3qxNv1kl0jBp
	HgkuT/K
X-Received: by 2002:a05:7300:2406:b0:360:ab79:e0a6 with SMTP id 5a478bee46e88-361a264577dmr12085103eec.28.1792417748271;
        Mon, 19 Oct 2026 06:49:08 -0700 (PDT)
Received: from maclinux ([2803:c600:9110:8ba5:1c75:eeaa:b22f:20dc])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36081fa5a6esm33611831eec.16.2026.10.19.06.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:49:07 -0700 (PDT)
From: =?UTF-8?q?Francisco=20Beltr=C3=A1n=20Millal=C3=A9n?= <fbeltranmillalen@gmail.com>
To: mika.westerberg@linux.intel.com
Cc: andreas.noever@gmail.com,
	westeri@kernel.org,
	YehezkelShB@gmail.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	helgaas@kernel.org,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	lukas@wunner.de,
	d@rrell.co
Subject: [PATCH] thunderbolt: Call SXFP() on Apple systems with Alpine Ridge when suspending
Date: Mon, 19 Oct 2026 10:48:51 -0300
Message-ID: <20261019134851.7496-1-fbeltranmillalen@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Apple systems with Alpine Ridge, suspending to RAM with a device
connected to a Type-C port leaves the PCIe link to the upstream port of
the controller down on resume, and the ports are lost until reboot.
Calling the SXFP(0) ACPI method under the NHI before entering sleep
avoids that, so do it from suspend_late of the software connection
manager.

The firmware can set bit 26 of plug events CS_20 when it resumes the
NHI. While it is set SXFP(0) turns the router off and it does not come
back on resume, so clear the bit first and skip SXFP(0) if that fails.

Assisted-by: LLM
Signed-off-by: Francisco Beltrán Millalén <fbeltranmillalen@gmail.com>
---
This replaces "PCI: Extend Apple Thunderbolt power quirk to Alpine
Ridge":
https://lore.kernel.org/all/20260924132815.24430-1-fbeltranmillalen@gmail.com/

As discussed there, both parts now live in drivers/thunderbolt, and
nothing changes in drivers/pci.  I asked Bjorn to drop the PCI version,
so the two should not be applied together.

Without SXFP(0) the ports were lost in 15 of 15 cycles with a device
attached (details in the old thread).  It runs from suspend_late
because from suspend_noirq it did not help: by then the bridges below
the controller were already inaccessible.

I tested it on a MacBookPro14,3, which has two Alpine Ridge controllers
(two domains), with the software connection manager.  The kernel was
6.18.49 with a backport of this patch.  The backport uses
&nhi->pdev->dev in place of nhi->dev and adds a module parameter to
switch it on, and the PCI quirk was switched off.  That kernel also
carried my PCI save/restore series and a local change equivalent to
the ACPICA fix mentioned below.  I have not run this patch without
them.

- With a USB 3 disk on a Type-C port: 7 suspend/resume cycles,
  sleeping from 30 seconds to 30 minutes.  The disk was still there
  after each of them, and every time I checked, it could be read and
  both upstream port links were at 8 GT/s x4.
- With nothing connected: 3 cycles, both domains came back.  Plugging
  the disk in afterwards worked normally.
- One suspend with pm_test set to "platform".  It goes through
  suspend_late and the noirq phase and returns without entering S3, so
  it is the closest I could get to a suspend aborted after SXFP(0).
  Both domains stayed up and the disk kept working.  SXFP(0) powers
  down the xHCI on the side with nothing connected, and it came back
  as well.

About bit 26: here the firmware sets it only with a fix for ACPICA
PCI_Config regions under a bridge that has no bus number yet (the
problem that open-acpica PRs #1235 and #1236 address).  Without that
fix the bit read as clear in my tests, and the patch only calls
SXFP(0), as the PCI version did.  With the fix, calling SXFP(0) with
the bit set left the controller with the disk dead after resume in all
3 cycles I tried.  Clearing the bit just before SXFP(0) gave 15 good
cycles out of 15 in earlier tests (by hand, from a test module and
from a modified PCI quirk; 12 of them with the disk attached), plus the
cycles above.

If the bit cannot be cleared, SXFP(0) is skipped.  With a device
connected, both choices lose the ports until the machine is powered
off, so I chose the one that does nothing to the controller.  I have
not tested that error path.

As with the PCI version, a device plugged in while the system is
suspended does not wake it.  I measured that with the PCI version and
the bit cleared; this patch makes the same call.

Not tested:
- Real Thunderbolt devices, only the USB 3 disk behind the
  controller's xHCI.
- Other Alpine Ridge variants.  Only the router ID of this machine is
  matched.
- An NHI that is runtime suspended when the system suspends.  Here
  both NHIs were always active at that point.  If one is runtime
  suspended, the PM core may skip its suspend_late (direct_complete),
  and then SXFP(0) is not called.

 drivers/thunderbolt/acpi.c    | 83 +++++++++++++++++++++++++++++++++++++++++++
 drivers/thunderbolt/domain.c  |  5 +++
 drivers/thunderbolt/nhi.c     |  8 +++++
 drivers/thunderbolt/tb.c      |  7 ++++
 drivers/thunderbolt/tb.h      |  5 +++
 drivers/thunderbolt/tb_regs.h |  8 +++++
 6 files changed, 116 insertions(+)

diff --git a/drivers/thunderbolt/acpi.c b/drivers/thunderbolt/acpi.c
index 53546bc477a5..6a61120b75f0 100644
--- a/drivers/thunderbolt/acpi.c
+++ b/drivers/thunderbolt/acpi.c
@@ -7,7 +7,9 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/platform_data/x86/apple.h>
 #include <linux/pm_runtime.h>
+#include <linux/suspend.h>
 
 #include "tb.h"
 
@@ -279,6 +281,87 @@ int tb_acpi_power_off_retimers(struct tb_port *port)
 	return tb_acpi_retimer_set_power(port, false);
 }
 
+static int tb_acpi_apple_clear_bit26(struct tb_switch *sw)
+{
+	unsigned int offset = sw->cap_plug_events + TB_PLUG_EVENTS_CS_20;
+	u32 val;
+	int ret;
+
+	guard(mutex)(&sw->tb->lock);
+
+	ret = tb_sw_read(sw, &val, TB_CFG_SWITCH, offset, 1);
+	if (ret)
+		return ret;
+	if (!(val & TB_PLUG_EVENTS_CS_20_BIT26))
+		return 0;
+
+	tb_sw_dbg(sw, "ACPI: clearing bit 26 of plug events CS_20 (%#x)\n", val);
+	val &= ~TB_PLUG_EVENTS_CS_20_BIT26;
+	ret = tb_sw_write(sw, &val, TB_CFG_SWITCH, offset, 1);
+	if (ret)
+		return ret;
+
+	ret = tb_sw_read(sw, &val, TB_CFG_SWITCH, offset, 1);
+	if (ret)
+		return ret;
+
+	return val & TB_PLUG_EVENTS_CS_20_BIT26 ? -EIO : 0;
+}
+
+/**
+ * tb_acpi_apple_sxfp() - Call SXFP(0) on Apple systems with Alpine Ridge
+ * @tb: Domain that is being suspended
+ *
+ * On Apple systems with Alpine Ridge the PCIe link to the upstream port
+ * of the controller does not come up on resume from system sleep if a
+ * device is connected, unless SXFP(0) under the NHI is called before
+ * entering it.
+ *
+ * The firmware can set bit 26 of plug events CS_20 when it resumes the
+ * NHI. While it is set SXFP(0) turns the router off and it does not
+ * come back on resume, so clear the bit first and only call SXFP(0) if
+ * it reads back as clear.
+ *
+ * Call only when entering system sleep. Does nothing on other systems.
+ */
+void tb_acpi_apple_sxfp(struct tb *tb)
+{
+	struct tb_switch *sw = tb->root_switch;
+	acpi_handle handle, sxfp;
+	acpi_status status;
+
+	if (!x86_apple_machine)
+		return;
+	/* Firmware powers the controller back on only if it was involved */
+	if (!pm_suspend_via_firmware())
+		return;
+	if (!sw || tb->nhi->going_away)
+		return;
+	if (sw->config.vendor_id != PCI_VENDOR_ID_INTEL ||
+	    sw->config.device_id != PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_4C_BRIDGE)
+		return;
+
+	handle = ACPI_HANDLE(tb->nhi->dev);
+	if (!handle || ACPI_FAILURE(acpi_get_handle(handle, "SXFP", &sxfp)))
+		return;
+
+	if (!sw->cap_plug_events) {
+		tb_sw_warn(sw, "ACPI: plug events capability not found, not calling SXFP\n");
+		return;
+	}
+
+	if (tb_acpi_apple_clear_bit26(sw)) {
+		tb_sw_warn(sw, "ACPI: failed to clear bit 26 of plug events CS_20, not calling SXFP\n");
+		return;
+	}
+
+	tb_sw_dbg(sw, "ACPI: calling SXFP\n");
+	status = acpi_execute_simple_method(sxfp, NULL, 0);
+	if (ACPI_FAILURE(status))
+		tb_sw_warn(sw, "ACPI: SXFP failed: %s\n",
+			   acpi_format_exception(status));
+}
+
 static bool tb_acpi_bus_match(struct device *dev)
 {
 	return tb_is_switch(dev) || tb_is_usb4_port_device(dev);
diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
index 12c88509a54f..06a23dd0fc70 100644
--- a/drivers/thunderbolt/domain.c
+++ b/drivers/thunderbolt/domain.c
@@ -569,6 +569,11 @@ int tb_domain_suspend(struct tb *tb)
 	return tb->cm_ops->suspend ? tb->cm_ops->suspend(tb) : 0;
 }
 
+int tb_domain_suspend_late(struct tb *tb)
+{
+	return tb->cm_ops->suspend_late ? tb->cm_ops->suspend_late(tb) : 0;
+}
+
 int tb_domain_freeze_noirq(struct tb *tb)
 {
 	int ret = 0;
diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index 6d2be7734a00..f35852ab41e8 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -1163,6 +1163,13 @@ static int nhi_suspend(struct device *dev)
 	return tb_domain_suspend(tb);
 }
 
+static int nhi_suspend_late(struct device *dev)
+{
+	struct tb *tb = dev_get_drvdata(dev);
+
+	return tb_domain_suspend_late(tb);
+}
+
 static void nhi_complete(struct device *dev)
 {
 	struct tb *tb = dev_get_drvdata(dev);
@@ -1422,6 +1429,7 @@ const struct dev_pm_ops nhi_pm_ops = {
 	.thaw_noirq = nhi_thaw_noirq,
 	.restore_noirq = nhi_resume_noirq,
 	.suspend = nhi_suspend,
+	.suspend_late = nhi_suspend_late,
 	.poweroff_noirq = nhi_poweroff_noirq,
 	.poweroff = nhi_suspend,
 	.complete = nhi_complete,
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 7e39b067e5ff..7b73b8c9accb 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -3108,6 +3108,12 @@ static int tb_suspend_noirq(struct tb *tb)
 	return 0;
 }
 
+static int tb_suspend_late(struct tb *tb)
+{
+	tb_acpi_apple_sxfp(tb);
+	return 0;
+}
+
 static void tb_restore_children(struct tb_switch *sw)
 {
 	struct tb_port *port;
@@ -3310,6 +3316,7 @@ static const struct tb_cm_ops tb_cm_ops = {
 	.deinit = tb_deinit,
 	.suspend_noirq = tb_suspend_noirq,
 	.resume_noirq = tb_resume_noirq,
+	.suspend_late = tb_suspend_late,
 	.freeze_noirq = tb_freeze_noirq,
 	.thaw_noirq = tb_thaw_noirq,
 	.complete = tb_complete,
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index e86845762e22..4820a363f43f 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -481,6 +481,7 @@ struct tb_path {
  * @suspend_noirq: Connection manager specific suspend_noirq
  * @resume_noirq: Connection manager specific resume_noirq
  * @suspend: Connection manager specific suspend
+ * @suspend_late: Connection manager specific suspend_late
  * @freeze_noirq: Connection manager specific freeze_noirq
  * @thaw_noirq: Connection manager specific thaw_noirq
  * @complete: Connection manager specific complete
@@ -515,6 +516,7 @@ struct tb_cm_ops {
 	int (*suspend_noirq)(struct tb *tb);
 	int (*resume_noirq)(struct tb *tb);
 	int (*suspend)(struct tb *tb);
+	int (*suspend_late)(struct tb *tb);
 	int (*freeze_noirq)(struct tb *tb);
 	int (*thaw_noirq)(struct tb *tb);
 	void (*complete)(struct tb *tb);
@@ -779,6 +781,7 @@ void tb_domain_remove(struct tb *tb);
 int tb_domain_suspend_noirq(struct tb *tb);
 int tb_domain_resume_noirq(struct tb *tb);
 int tb_domain_suspend(struct tb *tb);
+int tb_domain_suspend_late(struct tb *tb);
 int tb_domain_freeze_noirq(struct tb *tb);
 int tb_domain_thaw_noirq(struct tb *tb);
 void tb_domain_complete(struct tb *tb);
@@ -1524,6 +1527,7 @@ int tb_acpi_init(void);
 void tb_acpi_exit(void);
 int tb_acpi_power_on_retimers(struct tb_port *port);
 int tb_acpi_power_off_retimers(struct tb_port *port);
+void tb_acpi_apple_sxfp(struct tb *tb);
 #else
 static inline bool tb_acpi_add_links(struct tb_nhi *nhi) { return false; }
 
@@ -1537,6 +1541,7 @@ static inline int tb_acpi_init(void) { return 0; }
 static inline void tb_acpi_exit(void) { }
 static inline int tb_acpi_power_on_retimers(struct tb_port *port) { return 0; }
 static inline int tb_acpi_power_off_retimers(struct tb_port *port) { return 0; }
+static inline void tb_acpi_apple_sxfp(struct tb *tb) { }
 #endif
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
index 92d893634d2b..e28a9bfbfefa 100644
--- a/drivers/thunderbolt/tb_regs.h
+++ b/drivers/thunderbolt/tb_regs.h
@@ -577,6 +577,14 @@ struct tb_regs_hop {
 #define TB_PLUG_EVENTS_PCIE_CMD_TIMEOUT_MASK	BIT(31)
 #define TB_PLUG_EVENTS_PCIE_CMD_RD_DATA		0x1d
 
+/*
+ * Alpine Ridge on Apple systems (VSC_CS_20). The firmware can set bit
+ * 26 when it resumes the NHI. While it is set SXFP(0) turns the router
+ * off and it does not come back on resume.
+ */
+#define TB_PLUG_EVENTS_CS_20			0x14
+#define TB_PLUG_EVENTS_CS_20_BIT26		BIT(26)
+
 /* CP Low Power registers */
 #define TB_LOW_PWR_C1_CL1			0x1
 #define TB_LOW_PWR_C1_CL1_OBJ_MASK		GENMASK(4, 1)
