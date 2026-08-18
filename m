Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3023F0A86
	for <linux-pci@vger.kernel.org>; Tue, 18 Aug 2026 18:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787079472; cv=none; b=fT4SLiQvZkRXL5UFR5mdgmPUgDrWltXBWmZhAhNoCXQ/8bRJFM26iRYGPkAIdCuRtg9iTGY6AlBj20em0ZFZ3bjCkuDhmrgv0+mdGvmwJ00h3ZTJPqifJRlFM76P7kjB2JtSXo4JOuMeVeCv0f5JxrszvCV+RBb9IORT2yr9Ddo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787079472; c=relaxed/simple;
	bh=FBvz3DMe1SYorsdm0txbZONMzssuvhVD51eKcHY0y9A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=axbK6YHmn1TJn/d40dttvS+eYZKAZ/rP5kI1REe7HulUuT4w2y0MvPRMeGX1e9WpUK8WEXQIQc/vKipnNBBNzp8mH5CV2U8Rkydx9Au/PuwcUZ7/pQmGt6agppijIRNYEMw54XngANbcF6jAaIpa/XGxpycaB3wWxMqRlaqqFFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=By0C+as5; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="By0C+as5"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cab3e9cd922so68210a12.0
        for <linux-pci@vger.kernel.org>; Tue, 18 Aug 2026 11:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787079469; x=1787684269; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kcOBjZWRSKI4YZixqvB1F24ONl66ORi7/qHcmwzFTBw=;
        b=By0C+as52VDUfRigcGYznB7wrohDxGBpo3B0RBI9so3zozOVP5jTGZ6JGNBaM4cZC4
         U/7E0Wult/0FhvrBa7L+rvWzrp8GwJ1fmiu0GbKIlDp1oHAveCLHlrzDQL9W91fKOGiy
         CxNxnPw8uRh4ArdAdddOFioEfd6/LtOSVZgWlJm91M+VMAdnRNiZqmuxq9BOOYsk2C78
         nEqzb8DnT1V2MGWQ2EBXB0pkGBktqUw0jjFTJsXe9utI9U9GHOZRA4Vy0HkgMwOg9Lhr
         c0y5pzByTzAGn6pG8sC5vTeyqYD63Vo6RBqwT2qBLxJuoHS0uk5rAPoRogPGhmz67CPT
         oQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787079469; x=1787684269;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kcOBjZWRSKI4YZixqvB1F24ONl66ORi7/qHcmwzFTBw=;
        b=YbNYtb4djHxhmhbNCdW8wMdFuGNrfpplb0+Xfq9s/KHeNAEzL62tJ3B8r370c5EovV
         zkDc+0XnhxFiFVQ7EL73S3qomOUSawNssb7ABpumepCBHJZ/0AAhToyT//wahtKfshNm
         Z6jiWVUmkf26FMe7HNHV0HLYesm0PtW+I51ri1yZ4MYSRRUgAVJi3iz3M2f6JFwTw2pt
         3xeU+L/QJ+xypMKDVoRKBTVlvGJwloyFKCkPEJzx4R9ruBE2j36WZiVU8EfjGDy4RqQ/
         oQTqHUUpzQgOAQ9O8NGRypudDSUhi+NUmh5dNOgHEw1WCJctFInBreHd9DvMg1zckma/
         gVVg==
X-Forwarded-Encrypted: i=1; AHgh+RoJe/6EShxGCmg8cPAaYpaRucb1wRKjUOv0ANIBcYvfyR8lVScLjpCaD2VrdB8gF60nYqnLSmLSpkw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp0OqLYzd1XFT8LsjFs7+wwZPE0c8TKonip3JKlw9fIYZ6b+RF
	9LYBSTet5R52vcdSXyt5ZW0flFVVMArQUEnd3RbJBX7uNcmE+PpsD4ZHa5TQJrxMEcWrP4v/SSv
	bmHh7qLyNT3pN/F1mbNmm3QUjN1rS/LnJcg==
X-Received: from pgct23.prod.google.com ([2002:a05:6a02:5297:b0:c82:7761:9936])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:939f:b0:3cb:8280:71f8 with SMTP id adf61e73a8af0-3cc71c93b1bmr45418568637.18.1787079468988;
 Tue, 18 Aug 2026 11:57:48 -0700 (PDT)
Date: Tue, 18 Aug 2026 18:57:48 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Change-Id: 20260818-pcie-lmt-3044d586aaec
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Message-ID: <20260818-pcie-lmt-v1-1-13716f446594@google.com>
Subject: [PATCH] PCI/pcie: Add PCIe Lane Margining at Receiver (LMR) support
From: Priyank Rathod <rathodpriyank@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Priyank Rathod <rathodpriyank@google.com>
Content-Type: text/plain; charset="utf-8"

Per PCIe Base Specification r6.0, sec 8.4.4 ("Lane Margining at
Receiver"), PCIe devices operating at 16.0 GT/s (Gen 4) or higher data
rates support the Lane Margining at Receiver Extended Capability
(ID 0x27), and it is mandatory for receivers operating at 64.0 GT/s
(Gen 6) or higher data rates. Lane Margining allows software to
evaluate high-speed link margins by measuring timing and voltage steps
for each individual physical lane and receiver.

Add driver and debugfs support for PCIe Lane Margining at Receiver:

  - Add Lane Margining at Receiver Extended Capability register
    definitions (PCI_EXT_CAP_ID_LMR, PCI_LMR_PORT_CAP, PCI_LMR_PORT_STS,
    PCI_LMR_LANE_CTRL, PCI_LMR_LANE_STS) to <uapi/linux/pci_regs.h>.
  - Add Kconfig option CONFIG_PCIE_LMR (under drivers/pci/pcie/Kconfig)
    dependent on DEBUG_FS.
  - Implement drivers/pci/pcie/margin.c to probe the capability on Gen4+
    links and expose per-device debugfs entries under:
      /sys/kernel/debug/pci/pcie_lmr_<pci_dev_name>/
    providing control over margining enablement, receiver selection, and
    execution of timing/voltage margin step commands. Distinguish
    between missing mandatory LMR capability on Gen6+ vs optional on
    Gen4/Gen5.
  - Hook pci_lmr_init() into pci_init_capabilities() during device probe
    in drivers/pci/probe.c and pci_lmr_exit() into drivers/pci/remove.c.
  - Add kselftest script under tools/testing/selftests/pcie_lmt/pcie_lmt.sh
    to test debugfs capability reads, enablement, and stepping.

Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
---
Per PCIe Base Specification r6.0, section 8.4.4 ("Lane Margining at Receiver"),
PCIe devices operating at 16.0 GT/s (Gen 4) or higher data rates support the
Lane Margining at Receiver Extended Capability (ID 0x27), and it is mandatory
for receivers operating at 64.0 GT/s (Gen 6) or higher data rates.

Lane Margining allows system software to evaluate high-speed link signal
integrity and margins by measuring timing and voltage steps for each physical
lane and receiver independently.

This series introduces kernel driver support, debugfs controls, and a
kselftest automation script for PCIe Lane Margining at Receiver (LMR/LMT).

==============================================================================
1. How to Enable & Configure
==============================================================================
Enable the Kconfig option under PCI support:
  CONFIG_PCIE_LMR=y (or =m)
  (Depends on CONFIG_PCI and CONFIG_DEBUG_FS)

Upon boot or device hotplug on Gen4+ links (>= 16.0 GT/s), the driver probes
Extended Capability ID 0x27 and exposes per-device debugfs interfaces:
  /sys/kernel/debug/pci/pcie_lmr_<domain>:<bus>:<dev>.<func>/

==============================================================================
2. How to Use the Debugfs Interface (Manual Margining)
==============================================================================
Inspect device-wide margining capabilities and port status:
  # Inspect root device LMR capabilities & status
  cat /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/capabilities
  cat /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/port_status

Enable active Lane Margining on the device:
  # Enable Lane Margining state machine
  echo 1 > /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/enable

Inspect and step individual lanes (e.g. lane0):
  # Select target receiver (0 = local receiver, 1..6 = retimers/link partners)
  echo 0 > /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/receiver

  # Check available timing and voltage steps for this receiver
  cat /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/caps
  cat /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/num_timing_steps
  cat /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/num_voltage_steps

  # Step timing margin or voltage margin offset
  echo 2 > /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/margin_timing
  echo 1 > /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/margin_voltage

  # Reset margin offset back to nominal (0)
  echo 0 > /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/margin_timing
  echo 0 > /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/margin_voltage

Disable Lane Margining when finished:
  echo 0 > /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/enable

==============================================================================
3. How to Run Automated Kselftests Using the Test Script
==============================================================================
An automated kselftest script is included to test capability reads, receiver
selection, and margining commands across all enumerated LMR devices:

  # Run directly as root
  sudo ./tools/testing/selftests/pcie_lmt/pcie_lmt.sh

Or run via the kselftest Makefile harness:
  make -C tools/testing/selftests TARGETS=pcie_lmt run_tests

Sample script output on an LMR-capable device:
  pcie_lmt: testing PCIe LMR debugfs entries
  pcie_lmt: probing device pcie_lmr_0000:01:00.0
    pcie_lmr_0000:01:00.0: capabilities read OK
    pcie_lmr_0000:01:00.0: port_status read OK
    pcie_lmr_0000:01:00.0: margining enabled OK
    pcie_lmr_0000:01:00.0: testing lane0
    pcie_lmr_0000:01:00.0: testing lane1
    pcie_lmr_0000:01:00.0: margining disabled OK
  pcie_lmt [PASS]
---
 drivers/pci/pci.h                            |   8 +
 drivers/pci/pcie/Kconfig                     |  12 +
 drivers/pci/pcie/Makefile                    |   1 +
 drivers/pci/pcie/margin.c                    | 673 +++++++++++++++++++++++++++
 drivers/pci/probe.c                          |   1 +
 drivers/pci/remove.c                         |   1 +
 include/linux/pci.h                          |   6 +
 include/uapi/linux/pci_regs.h                |  19 +
 tools/testing/selftests/Makefile             |   1 +
 tools/testing/selftests/pcie_lmt/Makefile    |   3 +
 tools/testing/selftests/pcie_lmt/pcie_lmt.sh | 105 +++++
 11 files changed, 830 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4469e1a77f3c..c3449c6a5b79 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1023,6 +1023,14 @@ static inline void pci_no_tph(void) { }
 static inline void pci_tph_init(struct pci_dev *dev) { }
 #endif
 
+#ifdef CONFIG_PCIE_LMR
+void pci_lmr_init(struct pci_dev *dev);
+void pci_lmr_exit(struct pci_dev *dev);
+#else
+static inline void pci_lmr_init(struct pci_dev *dev) { }
+static inline void pci_lmr_exit(struct pci_dev *dev) { }
+#endif
+
 #ifdef CONFIG_PCIE_PTM
 void pci_ptm_init(struct pci_dev *dev);
 void pci_save_ptm_state(struct pci_dev *dev);
diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 207c2deae35f..3b021ca2fe84 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -137,6 +137,18 @@ config PCIE_PTM
 	  This is only useful if you have devices that support PTM, but it
 	  is safe to enable even if you don't.
 
+config PCIE_LMR
+	bool "PCI Express Lane Margining at Receiver Support"
+	depends on DEBUG_FS
+	help
+	  This enables the PCI Express Lane Margining at Receiver support.
+	  Lane Margining allows software to determine the voltage and
+	  timing margin of each lane on a PCIe link (16.0 GT/s and above).
+	  The margining data is exposed via debugfs.
+
+	  This is only useful if you have devices that support lane
+	  margining, but it is safe to enable even if you don't.
+
 config PCIE_EDR
 	bool "PCI Express Error Disconnect Recover support"
 	depends on PCIE_DPC && ACPI
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index b0b43a18c304..aac45ae0402e 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -13,4 +13,5 @@ obj-$(CONFIG_PCIEAER_INJECT)	+= aer_inject.o
 obj-$(CONFIG_PCIE_PME)		+= pme.o
 obj-$(CONFIG_PCIE_DPC)		+= dpc.o
 obj-$(CONFIG_PCIE_PTM)		+= ptm.o
+obj-$(CONFIG_PCIE_LMR)		+= margin.o
 obj-$(CONFIG_PCIE_EDR)		+= edr.o
diff --git a/drivers/pci/pcie/margin.c b/drivers/pci/pcie/margin.c
new file mode 100644
index 000000000000..a1ccd473a407
--- /dev/null
+++ b/drivers/pci/pcie/margin.c
@@ -0,0 +1,673 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI Express Lane Margining at Receiver
+ *
+ * Copyright (C) 2026 Google LLC
+ * Author: Priyank Rathod <rathodpriyank@google.com>
+ *
+ * Lane Margining at Receiver (PCIe r6.0, sec 8.4.4) allows the software
+ * to determine the voltage and timing margins of each lane on the PCIe
+ * link. The extended capability (ID 0x27) is available for receivers
+ * operating at 16.0 GT/s (Gen4) or higher data rates, and is mandatory
+ * for receivers operating at 64.0 GT/s (Gen6) or higher data rates.
+ *
+ * This implementation exposes per-device debugfs entries to read the margining
+ * capabilities and issues margining commands through custom file_ops.
+ */
+
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/mutex.h>
+#include <linux/delay.h>
+#include <linux/jiffies.h>
+#include <linux/seq_file.h>
+#include <linux/bitfield.h>
+#include <linux/debugfs.h>
+
+#include "../pci.h"
+
+/* Margin type encodings per the PCIe spec */
+#define LMR_TYPE_DEMARGIN               0x0
+#define LMR_TYPE_REPORT_CAPS            0x1
+#define LMR_TYPE_REPORT_VOLTAGE_STEPS   0x2
+#define LMR_TYPE_REPORT_TIMING_STEPS    0x3
+#define LMR_TYPE_TIMING                 0x4
+#define LMR_TYPE_VOLTAGE                0x5
+#define LMR_TYPE_NO_CMD                 0x7
+
+/* LMR command timing parameters */
+#define LMR_CMD_TIMEOUT_MS              100
+#define LMR_CMD_SLEEP_MIN_US            100
+#define LMR_CMD_SLEEP_MAX_US            200
+#define LMR_ENABLE_TIMEOUT_MS           100
+#define LMR_ENABLE_SLEEP_MIN_US         1000
+#define LMR_ENABLE_SLEEP_MAX_US         2000
+
+/* LMR limits */
+#define LMR_MAX_LANES                   32
+#define LMR_MAX_RX_NUM                  6
+#define LMR_MAX_TIMING_STEP             63
+#define LMR_MAX_VOLTAGE_STEP            127
+
+/* LMR PCIe generation numbers */
+#define LMR_GEN6                        6
+#define LMR_GEN5                        5
+#define LMR_GEN4                        4
+
+/* LMR lane register stride */
+#define LMR_LANE_REG_STRIDE             4
+
+/* LMR receivers and directions */
+#define LMR_RX_LOCAL                    0
+#define LMR_STEP_DIR_INCREASE           1
+#define LMR_STEP_DIR_DECREASE           0
+
+/* LMR step & direction encoding masks */
+#define LMR_STEPS_MASK                  0x7F
+#define LMR_TIMING_STEP_MASK            0x3F
+#define LMR_TIMING_DIR_SHIFT            6
+#define LMR_VOLTAGE_STEP_MASK           0x7F
+#define LMR_VOLTAGE_DIR_SHIFT           7
+
+/* LMR capabilities report bit fields */
+#define LMR_CAP_MARGIN_HV               BIT(0)
+#define LMR_CAP_MARGIN_EV_IV            BIT(1)
+#define LMR_CAP_IND_LEFT_RIGHT_TIMING   BIT(2)
+#define LMR_CAP_IND_UP_DOWN_VOLTAGE     BIT(3)
+#define LMR_CAP_ERROR_SAMPLER           BIT(4)
+#define LMR_CAP_SAMPLE_MULTIPLE_RX      BIT(5)
+
+struct pci_margin_lane {
+	struct pci_margin_dev *mdev;
+	int lane;
+	u8 rx;
+	int timing_val;
+	int voltage_val;
+};
+
+struct pci_margin_dev {
+	struct pci_dev *dev;
+	u16 cap;
+	struct dentry *debugfs;
+	struct mutex lock;
+	int num_lanes;
+	struct pci_margin_lane *lanes;
+	bool enabled;
+};
+
+static int pci_lmr_run_cmd(struct pci_dev *dev, int lane, u8 rx, u8 type,
+			   u8 usage, u8 payload, u16 *status_val)
+{
+	u16 lmr = dev->lmr_cap;
+	u16 ctrl_offset = lmr + PCI_LMR_LANE_CTRL + LMR_LANE_REG_STRIDE * lane;
+	u16 sts_offset = lmr + PCI_LMR_LANE_STS + LMR_LANE_REG_STRIDE * lane;
+	u16 ctrl, sts;
+	unsigned long timeout;
+
+	ctrl = FIELD_PREP(PCI_LMR_LANE_CTRL_RX_NUM, rx) |
+	       FIELD_PREP(PCI_LMR_LANE_CTRL_MTYPE, type) |
+	       FIELD_PREP(PCI_LMR_LANE_CTRL_USAGE, usage) |
+	       FIELD_PREP(PCI_LMR_LANE_CTRL_PAYLOAD, payload);
+
+	pci_write_config_word(dev, ctrl_offset, ctrl);
+
+	timeout = jiffies + msecs_to_jiffies(LMR_CMD_TIMEOUT_MS);
+	while (1) {
+		pci_read_config_word(dev, sts_offset, &sts);
+		if (sts == 0xFFFF)
+			return -ENODEV;
+
+		if (FIELD_GET(PCI_LMR_LANE_STS_MTYPE, sts) == type) {
+			if (status_val)
+				*status_val = sts;
+			return 0;
+		}
+
+		if (time_after(jiffies, timeout))
+			break;
+
+		usleep_range(LMR_CMD_SLEEP_MIN_US, LMR_CMD_SLEEP_MAX_US);
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int pci_lmr_run_cmd_locked(struct pci_margin_dev *mdev, int lane, u8 rx,
+				  u8 type, u8 usage, u8 payload, u16 *status_val)
+{
+	int ret;
+
+	if (!mdev->enabled)
+		return -EACCES;
+
+	mutex_lock(&mdev->lock);
+	ret = pci_lmr_run_cmd(mdev->dev, lane, rx, type, usage, payload, status_val);
+	mutex_unlock(&mdev->lock);
+
+	return ret;
+}
+
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+
+static int margin_caps_show(struct seq_file *s, void *v)
+{
+	struct pci_margin_dev *mdev = s->private;
+	struct pci_dev *dev = mdev->dev;
+	u16 cap;
+
+	pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_CAP, &cap);
+	seq_printf(s, "Port Capabilities: %#06x\n", cap);
+	seq_printf(s, "  Margining Ready: %s\n",
+		   (cap & PCI_LMR_PORT_CAP_MARGIN_READY) ? "yes" : "no");
+	seq_printf(s, "  SW Ready Required: %s\n",
+		   (cap & PCI_LMR_PORT_CAP_SW_READY) ? "yes" : "no");
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(margin_caps);
+
+static int margin_port_status_show(struct seq_file *s, void *v)
+{
+	struct pci_margin_dev *mdev = s->private;
+	struct pci_dev *dev = mdev->dev;
+	u16 sts;
+
+	pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &sts);
+	seq_printf(s, "Port Status: %#06x\n", sts);
+	seq_printf(s, "  Margining Ready: %s\n",
+		   (sts & PCI_LMR_PORT_STS_MARGIN_READY) ? "yes" : "no");
+	seq_printf(s, "  SW Ready: %s\n", (sts & PCI_LMR_PORT_STS_SW_READY) ? "yes" : "no");
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(margin_port_status);
+
+static int margin_enable_show(struct seq_file *s, void *v)
+{
+	struct pci_margin_dev *mdev = s->private;
+
+	seq_printf(s, "%d\n", mdev->enabled);
+	return 0;
+}
+
+static ssize_t margin_enable_write(struct file *file, const char __user *user_buf,
+			       size_t count, loff_t *ppos)
+{
+	struct pci_margin_dev *mdev = ((struct seq_file *)file->private_data)->private;
+	struct pci_dev *dev = mdev->dev;
+	unsigned long timeout;
+	bool enable;
+	int ret, i;
+	u16 sts, cap;
+
+	ret = kstrtobool_from_user(user_buf, count, &enable);
+	if (ret)
+		return ret;
+
+	mutex_lock(&mdev->lock);
+
+	if (mdev->enabled == enable)
+		goto out;
+
+	if (enable) {
+		pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_CAP, &cap);
+
+		pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &sts);
+		sts |= PCI_LMR_PORT_STS_SW_READY;
+		pci_write_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, sts);
+
+		timeout = jiffies + msecs_to_jiffies(LMR_ENABLE_TIMEOUT_MS);
+		while (1) {
+			pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &sts);
+			if (sts == 0xFFFF) {
+				ret = -ENODEV;
+				goto out;
+			}
+			if (sts & PCI_LMR_PORT_STS_MARGIN_READY)
+				break;
+			if (time_after(jiffies, timeout)) {
+				ret = -ETIMEDOUT;
+				sts &= ~PCI_LMR_PORT_STS_SW_READY;
+				pci_write_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, sts);
+				goto out;
+			}
+			usleep_range(LMR_ENABLE_SLEEP_MIN_US, LMR_ENABLE_SLEEP_MAX_US);
+		}
+		mdev->enabled = true;
+	} else {
+		pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &sts);
+		sts &= ~PCI_LMR_PORT_STS_SW_READY;
+		pci_write_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, sts);
+
+		for (i = 0; i < mdev->num_lanes; i++) {
+			mdev->lanes[i].timing_val = 0;
+			mdev->lanes[i].voltage_val = 0;
+		}
+		mdev->enabled = false;
+	}
+
+out:
+	mutex_unlock(&mdev->lock);
+	return ret ? ret : count;
+}
+
+static int margin_enable_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, margin_enable_show, inode->i_private);
+}
+
+static const struct file_operations margin_enable_fops = {
+	.open = margin_enable_open,
+	.read = seq_read,
+	.write = margin_enable_write,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static int margin_lane_receiver_show(struct seq_file *s, void *v)
+{
+	struct pci_margin_lane *plane = s->private;
+
+	seq_printf(s, "%d\n", plane->rx);
+	return 0;
+}
+
+static ssize_t margin_lane_receiver_write(struct file *file, const char __user *user_buf,
+				      size_t count, loff_t *ppos)
+{
+	struct pci_margin_lane *plane = ((struct seq_file *)file->private_data)->private;
+	u8 rx;
+	int ret;
+
+	ret = kstrtou8_from_user(user_buf, count, 0, &rx);
+	if (ret)
+		return ret;
+
+	if (rx > LMR_MAX_RX_NUM)
+		return -EINVAL;
+
+	plane->rx = rx;
+	return count;
+}
+
+static int margin_lane_receiver_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, margin_lane_receiver_show, inode->i_private);
+}
+
+static const struct file_operations margin_lane_receiver_fops = {
+	.open = margin_lane_receiver_open,
+	.read = seq_read,
+	.write = margin_lane_receiver_write,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static int margin_lane_caps_show(struct seq_file *s, void *v)
+{
+	struct pci_margin_lane *plane = s->private;
+	struct pci_margin_dev *mdev = plane->mdev;
+	u16 sts;
+	int ret;
+	u8 val;
+
+	ret = pci_lmr_run_cmd_locked(mdev, plane->lane, plane->rx,
+				     LMR_TYPE_REPORT_CAPS, 0, 0, &sts);
+	if (ret)
+		return ret;
+
+	val = FIELD_GET(PCI_LMR_LANE_STS_PAYLOAD, sts);
+	seq_printf(s, "Lane %d Rx %d Capabilities: %#02x\n", plane->lane, plane->rx, val);
+	seq_printf(s, "  Margining H/V: %s\n", (val & LMR_CAP_MARGIN_HV) ? "both" : "either");
+	seq_printf(s, "  Margining eV/iV: %s\n",
+		   (val & LMR_CAP_MARGIN_EV_IV) ? "both (close & open)" : "one (close only)");
+	seq_printf(s, "  Left/Right: %s\n", (val & LMR_CAP_IND_LEFT_RIGHT_TIMING) ? "both" : "one");
+	seq_printf(s, "  Up/Down: %s\n", (val & LMR_CAP_IND_UP_DOWN_VOLTAGE) ? "both" : "one");
+	seq_printf(s, "  Error Sampler: %s\n",
+		   (val & LMR_CAP_ERROR_SAMPLER) ? "yes" : "no (main sampler)");
+	seq_printf(s, "  Sample Multiple Receivers: %s\n",
+		   (val & LMR_CAP_SAMPLE_MULTIPLE_RX) ? "yes" : "no");
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(margin_lane_caps);
+
+static int margin_lane_timing_steps_show(struct seq_file *s, void *v)
+{
+	struct pci_margin_lane *plane = s->private;
+	struct pci_margin_dev *mdev = plane->mdev;
+	u16 sts;
+	int ret;
+	u8 val;
+
+	ret = pci_lmr_run_cmd_locked(mdev, plane->lane, plane->rx,
+				     LMR_TYPE_REPORT_TIMING_STEPS, 0, 0, &sts);
+	if (ret)
+		return ret;
+
+	val = FIELD_GET(PCI_LMR_LANE_STS_PAYLOAD, sts) & LMR_STEPS_MASK;
+	seq_printf(s, "%d\n", val);
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(margin_lane_timing_steps);
+
+static int margin_lane_voltage_steps_show(struct seq_file *s, void *v)
+{
+	struct pci_margin_lane *plane = s->private;
+	struct pci_margin_dev *mdev = plane->mdev;
+	u16 sts;
+	int ret;
+	u8 val;
+
+	ret = pci_lmr_run_cmd_locked(mdev, plane->lane, plane->rx,
+				     LMR_TYPE_REPORT_VOLTAGE_STEPS, 0, 0, &sts);
+	if (ret)
+		return ret;
+
+	val = FIELD_GET(PCI_LMR_LANE_STS_PAYLOAD, sts) & LMR_STEPS_MASK;
+
+	seq_printf(s, "%d\n", val);
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(margin_lane_voltage_steps);
+
+static ssize_t margin_lane_timing_write(struct file *file, const char __user *user_buf,
+				    size_t count, loff_t *ppos)
+{
+	struct pci_margin_lane *plane = ((struct seq_file *)file->private_data)->private;
+	struct pci_margin_dev *mdev = plane->mdev;
+	int val, ret;
+	u8 step, dir;
+	u16 sts;
+	u8 caps;
+
+	ret = kstrtoint_from_user(user_buf, count, 0, &val);
+	if (ret)
+		return ret;
+
+	if (!mdev->enabled)
+		return -EACCES;
+
+	mutex_lock(&mdev->lock);
+
+	if (val == 0) {
+		ret = pci_lmr_run_cmd(mdev->dev, plane->lane, plane->rx,
+				      LMR_TYPE_DEMARGIN, 0, 0, &sts);
+		if (ret)
+			goto out;
+		plane->timing_val = 0;
+		plane->voltage_val = 0;
+		goto out;
+	}
+
+	ret = pci_lmr_run_cmd(mdev->dev, plane->lane, plane->rx, LMR_TYPE_REPORT_CAPS, 0, 0, &sts);
+	if (ret)
+		goto out;
+	caps = FIELD_GET(PCI_LMR_LANE_STS_PAYLOAD, sts);
+
+	if (val < 0) {
+		step = -val;
+		dir = LMR_STEP_DIR_DECREASE;
+	} else {
+		step = val;
+		dir = LMR_STEP_DIR_INCREASE;
+		if (!(caps & LMR_CAP_IND_LEFT_RIGHT_TIMING)) {
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
+	if (step > LMR_MAX_TIMING_STEP) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = pci_lmr_run_cmd(mdev->dev, plane->lane, plane->rx,
+			      LMR_TYPE_TIMING, 0,
+			      (step & LMR_TIMING_STEP_MASK) | (dir << LMR_TIMING_DIR_SHIFT), &sts);
+	if (ret)
+		goto out;
+
+	plane->timing_val = val;
+
+out:
+	mutex_unlock(&mdev->lock);
+	return ret ? ret : count;
+}
+
+static int margin_lane_timing_show(struct seq_file *s, void *v)
+{
+	struct pci_margin_lane *plane = s->private;
+
+	seq_printf(s, "%d\n", plane->timing_val);
+	return 0;
+}
+
+static int margin_lane_timing_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, margin_lane_timing_show, inode->i_private);
+}
+
+static const struct file_operations margin_lane_timing_fops = {
+	.open = margin_lane_timing_open,
+	.read = seq_read,
+	.write = margin_lane_timing_write,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static ssize_t margin_lane_voltage_write(struct file *file, const char __user *user_buf,
+				     size_t count, loff_t *ppos)
+{
+	struct pci_margin_lane *plane = ((struct seq_file *)file->private_data)->private;
+	struct pci_margin_dev *mdev = plane->mdev;
+	int val, ret;
+	u8 step, dir;
+	u16 sts;
+	u8 caps;
+
+	ret = kstrtoint_from_user(user_buf, count, 0, &val);
+	if (ret)
+		return ret;
+
+	if (!mdev->enabled)
+		return -EACCES;
+
+	mutex_lock(&mdev->lock);
+
+	if (val == 0) {
+		ret = pci_lmr_run_cmd(mdev->dev, plane->lane, plane->rx,
+				      LMR_TYPE_DEMARGIN, 0, 0, &sts);
+		if (ret)
+			goto out;
+		plane->timing_val = 0;
+		plane->voltage_val = 0;
+		goto out;
+	}
+
+	ret = pci_lmr_run_cmd(mdev->dev, plane->lane, plane->rx, LMR_TYPE_REPORT_CAPS, 0, 0, &sts);
+	if (ret)
+		goto out;
+	caps = FIELD_GET(PCI_LMR_LANE_STS_PAYLOAD, sts);
+
+	if (val < 0) {
+		step = -val;
+		dir = 0;
+	} else {
+		step = val;
+		dir = 1;
+		if (!(caps & LMR_CAP_IND_UP_DOWN_VOLTAGE)) {
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
+	if (step > LMR_MAX_VOLTAGE_STEP) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = pci_lmr_run_cmd(mdev->dev, plane->lane, plane->rx,
+			      LMR_TYPE_VOLTAGE, 0,
+			      (step & LMR_VOLTAGE_STEP_MASK) |
+			      (dir << LMR_VOLTAGE_DIR_SHIFT), &sts);
+	if (ret)
+		goto out;
+
+	plane->voltage_val = val;
+
+out:
+	mutex_unlock(&mdev->lock);
+	return ret ? ret : count;
+}
+
+static int margin_lane_voltage_show(struct seq_file *s, void *v)
+{
+	struct pci_margin_lane *plane = s->private;
+
+	seq_printf(s, "%d\n", plane->voltage_val);
+	return 0;
+}
+
+static int margin_lane_voltage_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, margin_lane_voltage_show, inode->i_private);
+}
+
+static const struct file_operations margin_lane_voltage_fops = {
+	.open = margin_lane_voltage_open,
+	.read = seq_read,
+	.write = margin_lane_voltage_write,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static void pci_margin_debugfs_init(struct pci_margin_dev *mdev)
+{
+	struct pci_dev *dev = mdev->dev;
+	char dirname[64];
+	int i;
+
+	snprintf(dirname, sizeof(dirname), "pcie_lmr_%s", dev_name(&dev->dev));
+	mdev->debugfs = debugfs_create_dir(dirname, NULL);
+	if (!mdev->debugfs)
+		return;
+
+	debugfs_create_file("capabilities", 0444, mdev->debugfs, mdev, &margin_caps_fops);
+	debugfs_create_file("port_status", 0444, mdev->debugfs, mdev, &margin_port_status_fops);
+	debugfs_create_file("enable", 0644, mdev->debugfs, mdev, &margin_enable_fops);
+
+	for (i = 0; i < mdev->num_lanes; i++) {
+		struct pci_margin_lane *plane = &mdev->lanes[i];
+		struct dentry *lane_dir;
+		char lane_name[16];
+
+		snprintf(lane_name, sizeof(lane_name), "lane%d", i);
+		lane_dir = debugfs_create_dir(lane_name, mdev->debugfs);
+		if (!lane_dir)
+			continue;
+
+		debugfs_create_file("receiver", 0644, lane_dir, plane, &margin_lane_receiver_fops);
+		debugfs_create_file("caps", 0444, lane_dir, plane, &margin_lane_caps_fops);
+		debugfs_create_file("num_timing_steps", 0444, lane_dir, plane,
+				    &margin_lane_timing_steps_fops);
+		debugfs_create_file("num_voltage_steps", 0444, lane_dir, plane,
+				    &margin_lane_voltage_steps_fops);
+		debugfs_create_file("margin_timing", 0644, lane_dir, plane,
+				    &margin_lane_timing_fops);
+		debugfs_create_file("margin_voltage", 0644, lane_dir, plane,
+				    &margin_lane_voltage_fops);
+	}
+}
+
+static void pci_margin_debugfs_remove(struct pci_margin_dev *mdev)
+{
+	debugfs_remove_recursive(mdev->debugfs);
+}
+
+#else
+static inline void pci_margin_debugfs_init(struct pci_margin_dev *mdev) { }
+static inline void pci_margin_debugfs_remove(struct pci_margin_dev *mdev) { }
+#endif
+
+void pci_lmr_init(struct pci_dev *dev)
+{
+	struct pci_margin_dev *mdev;
+	enum pci_bus_speed speed;
+	u16 lmr;
+	u16 lnkcap;
+	int i;
+
+	if (!pci_is_pcie(dev))
+		return;
+
+	speed = pcie_get_speed_cap(dev);
+
+	lmr = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_LMR);
+	if (!lmr) {
+		if (speed >= PCIE_SPEED_64_0GT)
+			pci_warn(dev,
+				 "Missing Lane Margining at Receiver Capability (mandatory for Gen6+)\n");
+		else if (speed >= PCIE_SPEED_16_0GT)
+			pci_dbg(dev,
+				"Optional Lane Margining at Receiver Capability not found\n");
+		return;
+	}
+
+	if (speed < PCIE_SPEED_16_0GT && speed != PCI_SPEED_UNKNOWN)
+		return;
+
+	dev->lmr_cap = lmr;
+
+	mdev = kzalloc_obj(*mdev, GFP_KERNEL);
+	if (!mdev)
+		return;
+
+	mdev->dev = dev;
+	mdev->cap = lmr;
+	mutex_init(&mdev->lock);
+
+	pcie_capability_read_word(dev, PCI_EXP_LNKCAP, &lnkcap);
+	mdev->num_lanes = FIELD_GET(PCI_EXP_LNKCAP_MLW, lnkcap);
+
+	if (mdev->num_lanes == 0 || mdev->num_lanes > LMR_MAX_LANES) {
+		pci_warn(dev, "Invalid link width %d for LMR\n", mdev->num_lanes);
+		goto err_free_mdev;
+	}
+
+	mdev->lanes = kcalloc(mdev->num_lanes, sizeof(*mdev->lanes), GFP_KERNEL);
+	if (!mdev->lanes)
+		goto err_free_mdev;
+
+	for (i = 0; i < mdev->num_lanes; i++) {
+		mdev->lanes[i].mdev = mdev;
+		mdev->lanes[i].lane = i;
+		mdev->lanes[i].rx = LMR_RX_LOCAL;
+	}
+
+	pci_margin_debugfs_init(mdev);
+
+	dev->lmr = mdev;
+
+	pci_info(dev, "Lane Margining at Receiver (Gen%u) Capability detected\n",
+		 speed >= PCIE_SPEED_64_0GT ? LMR_GEN6 :
+		 speed >= PCIE_SPEED_32_0GT ? LMR_GEN5 :
+		 LMR_GEN4);
+	return;
+
+err_free_mdev:
+	mutex_destroy(&mdev->lock);
+	kfree(mdev);
+}
+
+void pci_lmr_exit(struct pci_dev *dev)
+{
+	struct pci_margin_dev *mdev = dev->lmr;
+
+	if (!mdev)
+		return;
+
+	pci_margin_debugfs_remove(mdev);
+	mutex_destroy(&mdev->lock);
+	kfree(mdev->lanes);
+	kfree(mdev);
+	dev->lmr = NULL;
+}
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index dd0abbc63e18..352b95568ebf 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2666,6 +2666,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_pasid_init(dev);		/* Process Address Space ID */
 	pci_acs_init(dev);		/* Access Control Services */
 	pci_ptm_init(dev);		/* Precision Time Measurement */
+	pci_lmr_init(dev);		/* Lane Margining at Receiver */
 	pci_aer_init(dev);		/* Advanced Error Reporting */
 	pci_dpc_init(dev);		/* Downstream Port Containment */
 	pci_rcec_init(dev);		/* Root Complex Event Collector */
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index d8bffa21498a..6fba29040e44 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -36,6 +36,7 @@ static void pci_destroy_dev(struct pci_dev *dev)
 
 	pci_doe_sysfs_teardown(dev);
 	pci_npem_remove(dev);
+	pci_lmr_exit(dev);
 
 	/*
 	 * While device is in D0 drop the device from TSM link operations
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 64b308b6e61c..ef1275f4c5b6 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -349,6 +349,8 @@ struct rcec_ea;
  *			number resources to allow for hierarchy expansion.
  * @is_pciehp:		PCIe Hot-Plug Capable bridge.
  */
+struct pci_margin_dev;
+
 struct pci_dev {
 	struct list_head bus_list;	/* Node in per-bus list */
 	struct pci_bus	*bus;		/* Bus this device is on */
@@ -528,6 +530,10 @@ struct pci_dev {
 	atomic_t	ptm_enable_cnt;
 	u8		ptm_granularity;
 #endif
+#ifdef CONFIG_PCIE_LMR
+	u16			lmr_cap;	/* Lane Margining Capability */
+	struct pci_margin_dev	*lmr;
+#endif
 #ifdef CONFIG_PCI_MSI
 	void __iomem	*msix_base;
 	raw_spinlock_t	msi_lock;
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index facaa324bd86..a13c09f8d6df 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -757,6 +757,7 @@
 #define PCI_EXT_CAP_ID_VF_REBAR 0x24	/* VF Resizable BAR */
 #define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
 #define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer 16.0 GT/s */
+#define PCI_EXT_CAP_ID_LMR	0x27	/* Lane Margining at Receiver */
 #define PCI_EXT_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management */
 #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
 #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
@@ -1181,6 +1182,24 @@
 #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_MASK		0x000000F0
 #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_SHIFT	4
 
+/* Lane Margining at Receiver */
+#define PCI_LMR_PORT_CAP		0x04	/* Margining Port Capabilities */
+#define  PCI_LMR_PORT_CAP_MARGIN_READY	0x0001	/* Margining Ready */
+#define  PCI_LMR_PORT_CAP_SW_READY	0x0002	/* Margining SW Ready */
+#define PCI_LMR_PORT_STS		0x06	/* Margining Port Status */
+#define  PCI_LMR_PORT_STS_MARGIN_READY	0x0001	/* Margining Ready */
+#define  PCI_LMR_PORT_STS_SW_READY	0x0002	/* Margining SW Ready */
+#define PCI_LMR_LANE_CTRL		0x08	/* Margining Lane Control */
+#define  PCI_LMR_LANE_CTRL_RX_NUM	0x0007	/* Receiver Number */
+#define  PCI_LMR_LANE_CTRL_MTYPE	0x0038	/* Margining Type */
+#define  PCI_LMR_LANE_CTRL_USAGE	0x0040	/* Margining Usage Model */
+#define  PCI_LMR_LANE_CTRL_PAYLOAD	0xFF00	/* Margining Payload */
+#define PCI_LMR_LANE_STS		0x0A	/* Margining Lane Status */
+#define  PCI_LMR_LANE_STS_RX_NUM	0x0007	/* Receiver Number */
+#define  PCI_LMR_LANE_STS_MTYPE		0x0038	/* Margining Type */
+#define  PCI_LMR_LANE_STS_USAGE		0x0040	/* Margining Usage Model */
+#define  PCI_LMR_LANE_STS_PAYLOAD	0xFF00	/* Margining Payload */
+
 /* Physical Layer 32.0 GT/s */
 #define PCI_PL_32GT_LE_CTRL	0x20	/* Lane Equalization Control Register */
 
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 8a4b6ddc68df..6990d999388a 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -91,6 +91,7 @@ TARGETS += net/tcp_ao
 TARGETS += nolibc
 TARGETS += pci_endpoint
 TARGETS += pcie_bwctrl
+TARGETS += pcie_lmt
 TARGETS += perf_events
 TARGETS += pidfd
 TARGETS += pid_namespace
diff --git a/tools/testing/selftests/pcie_lmt/Makefile b/tools/testing/selftests/pcie_lmt/Makefile
new file mode 100644
index 000000000000..36ac85937d78
--- /dev/null
+++ b/tools/testing/selftests/pcie_lmt/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+TEST_PROGS = pcie_lmt.sh
+include ../lib.mk
diff --git a/tools/testing/selftests/pcie_lmt/pcie_lmt.sh b/tools/testing/selftests/pcie_lmt/pcie_lmt.sh
new file mode 100755
index 000000000000..d57a6e8f3a23
--- /dev/null
+++ b/tools/testing/selftests/pcie_lmt/pcie_lmt.sh
@@ -0,0 +1,105 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2026 Google LLC
+# Author: Priyank Rathod <rathodpriyank@google.com>
+#
+# Kselftest for PCIe Lane Margining at Receiver (LMR / LMT)
+# Tests the debugfs interface exposed by drivers/pci/pcie/margin.c
+# (/sys/kernel/debug/pci/pcie_lmr_<pci_dev_name>/)
+
+set -e
+
+TESTNAME="pcie_lmt"
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+retval=0
+skipmsg="skip all tests:"
+
+if [ $UID != 0 ]; then
+	echo "$skipmsg must be run as root" >&2
+	exit $ksft_skip
+fi
+
+DEBUGFS=$(mount -t debugfs | head -1 | awk '{ print $3 }')
+if [ -z "$DEBUGFS" ]; then
+	if [ -d "/sys/kernel/debug" ]; then
+		DEBUGFS="/sys/kernel/debug"
+	else
+		echo "$skipmsg debugfs is not mounted" >&2
+		exit $ksft_skip
+	fi
+fi
+
+if [ ! -d "$DEBUGFS/pci" ]; then
+	echo "$skipmsg debugfs pci directory ($DEBUGFS/pci) not found" >&2
+	exit $ksft_skip
+fi
+
+LMR_DEVS=$(ls -d $DEBUGFS/pci/pcie_lmr_* 2>/dev/null || true)
+if [ -z "$LMR_DEVS" ]; then
+	echo "$skipmsg no PCIe LMR devices found in $DEBUGFS/pci/" >&2
+	exit $ksft_skip
+fi
+
+cleanup_dev()
+{
+	local dev="$1"
+	echo 0 > "$dev/enable" 2>/dev/null || true
+}
+
+echo "$TESTNAME: testing PCIe LMR debugfs entries"
+
+for dev in $LMR_DEVS; do
+	dev_name=$(basename "$dev")
+	echo "$TESTNAME: probing device $dev_name"
+
+	if [ ! -r "$dev/capabilities" ] || [ ! -r "$dev/port_status" ] ||
+	   [ ! -r "$dev/enable" ] || [ ! -w "$dev/enable" ]; then
+		echo "$TESTNAME: $dev_name missing mandatory root attributes"
+		retval=1
+		continue
+	fi
+
+	caps=$(cat "$dev/capabilities")
+	status=$(cat "$dev/port_status")
+	echo "  $dev_name: capabilities read OK"
+	echo "  $dev_name: port_status read OK"
+
+	trap 'cleanup_dev "$dev"' EXIT
+
+	if ! echo 1 > "$dev/enable" 2>/dev/null; then
+		echo "  $dev_name: margining not ready by hardware (skipping active lanes)"
+		continue
+	fi
+
+	echo "  $dev_name: margining enabled OK"
+
+	for lane_dir in $(ls -d "$dev"/lane* 2>/dev/null || true); do
+		lane=$(basename "$lane_dir")
+		echo "  $dev_name: testing $lane"
+
+		# Test setting receiver (Rx 0 is always local receiver)
+		echo 0 > "$lane_dir/receiver"
+		cat "$lane_dir/caps" > /dev/null
+		cat "$lane_dir/num_timing_steps" > /dev/null
+		cat "$lane_dir/num_voltage_steps" > /dev/null
+
+		# Test resetting timing and voltage margin
+		echo 0 > "$lane_dir/margin_timing"
+		echo 0 > "$lane_dir/margin_voltage"
+	done
+
+	echo 0 > "$dev/enable"
+	trap - EXIT
+	echo "  $dev_name: margining disabled OK"
+done
+
+if [ $retval -eq 0 ]; then
+	echo "$TESTNAME [PASS]"
+else
+	echo "$TESTNAME [FAIL]"
+fi
+
+exit $retval

---
base-commit: 0f23d56f17fdfc7db69d51f64c8b91bbab947aa9
change-id: 20260818-pcie-lmt-3044d586aaec

Best regards,
-- 
Priyank Rathod <rathodpriyank@google.com>
