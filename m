Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48871EFF8D
	for <linux-pci@vger.kernel.org>; Tue, 18 Aug 2026 20:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787086176; cv=none; b=D4b5+GHzZW5qXjeJq3rSlY4u1kaR+LnrLjd6qKMin7Qf604dROfp+QxQWaGet5j4qv1fO+SndrazYq2He3evKuvGHC+J6t++KUsbdIOD0X/jdO/nXISvsU+xwQE8KiAaeqZGametXw0NULug7b3eZdjt95iT6//MPfRmLOs8dHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787086176; c=relaxed/simple;
	bh=00bNb5qccRAdmbg9ywrYcoZzGXEAw4n1xcAK2kzPncE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pP4/eWpmw/jLum9ZX4moGPsiGe3jNfApsCdlcJt1f/ioGGNsEkzGO9MExjCC+DxUrjjoZtp2HNKt6ANNZ2yseJ0kbrJdaaKpovdaVILCJTvyG7BKqSDT95Xm9cAHxPPet4SzWvEIYbB+pMvsowA83A1YqB3Giay4L2fl+eteReE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Eiy+oye2; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Eiy+oye2"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ce7dff6253so15220135ad.1
        for <linux-pci@vger.kernel.org>; Tue, 18 Aug 2026 13:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787086173; x=1787690973; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xpQEWHrWyuCj7pt4ALYpnbwLwnSVthqhsZdKyPvhMxQ=;
        b=Eiy+oye2OA/yWXKspbdVA7CsC2TaMz4ZEYzT8Vv2gMUYhq5ze28+twjyUzUq1S/YZ6
         SJYZ/wC53tCncjIDpRLzuJ35IKHMKA3sTZKrtgAmw1C1JVwtIGXob95Do3XUFfOtz8m3
         WT7ut8mqjUiVB4mlAHFdA39MAzyhU5rpA1/JBx0f6c55hjvXEXjVASlBIla52yfKfV6e
         2LvpuhPkv8ekwWf68Xtv0kn+EqJcSHrTIh2QDrJiKlkOmZyQ349XmX4l2UrLLkJhYE+R
         vIJdFqUDeYKQlMMeGujgHwlLlygxnEpQRCkANwA2OdwEBktmQER1Zq3I0IMw7KT05RdJ
         Thag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787086173; x=1787690973;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xpQEWHrWyuCj7pt4ALYpnbwLwnSVthqhsZdKyPvhMxQ=;
        b=E2gzz+eyIaNQkzFxsmC4OJF7hE0qoWJowvOc0suzqlFWpu3ix2G+EPTLwKgeo8b1SM
         Yqz9GfUc2lkx5EltrIrxiBGtQYjVHLsiBBQzzlSTlQujjrdeBmQeLTBh23PFsTQqHqmw
         J5ok+nl0I+kVCnq6cOqF/bolrtqyJWTyqtNI2BdmVXsggzksKVz1ecyVLdhGIV5rDxvd
         U+d3GPUk25lbQPlBGhn+sbmd1sq4QYtN2q7JAMYwWKAPHdNGlENSqzbogvtB4s4/Gx/2
         1WSvmM1MAT10pwYCQtZodUB4GSqmYKAXkqjZTKKS+3Bh5FrT+s5i3W1zU3e5dPt4DpzB
         i+Kg==
X-Forwarded-Encrypted: i=1; AHgh+RrLFEq3IZZqEPrbWleRksAH4DWjGcnc9kErNet14fTUf+XZ861s7e2L0mVmSXcu5z+kGWwn/vLiCdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbmIsLT3tk9bHXNjqhgZqW1WBVHM8bN5KrhGAb9HPJWCI0RghQ
	mvGro2OhB2NFfWPjYiGzMJQJ2gZDBHfSzSu2gtTEB3qrtfMqJvv3FsNlRsQBWQrhFM74FoWwPbr
	EtF6ZgpHE92WKJcqbJ0fM11w41OL8+yhf5w==
X-Received: from pgbcp7.prod.google.com ([2002:a05:6a02:4007:b0:cbe:4197:83b8])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:1583:b0:3b4:661d:8405 with SMTP id adf61e73a8af0-3ccfcc24ba2mr1553510637.4.1787086172746;
 Tue, 18 Aug 2026 13:49:32 -0700 (PDT)
Date: Tue, 18 Aug 2026 20:49:32 +0000
In-Reply-To: <20260818-pcie-lmt-v1-1-13716f446594@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260818-pcie-lmt-v1-1-13716f446594@google.com>
X-Change-Id: 20260818-pcie-lmt-3044d586aaec
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Message-ID: <20260818-pcie-lmt-v3-1-d5df983a5d53@google.com>
Subject: [PATCH v3] PCI/pcie: Add PCIe Lane Margining at Receiver (LMR) support
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

To: Bjorn Helgaas <bhelgaas@google.com>
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Priyank Rathod <rathodpriyank@google.com>

Changes in v2:
  - Fixed NO_CMD (0x7) clearing in pci_lmr_run_cmd() before issuing new commands per PCIe r6.0 sec 8.4.4.
  - Protected plane->rx updates with mdev->lock in margin_lane_receiver_write().
  - Corrected Margining Port Capabilities bit definition to PCI_LMR_PORT_CAP_USES_SW_READY (0x0001) in <uapi/linux/pci_regs.h>.
  - Updated kselftest script (pcie_lmt.sh) to locate LMR debugfs entries.
  - Validated integer bounds against LMR_MAX_TIMING_STEP / LMR_MAX_VOLTAGE_STEP before narrowing u8 cast.
  - Moved mdev->enabled checks inside mutex_lock(&mdev->lock) to eliminate TOCTOU races.
  - Checked return values of all pci_read_config_word() calls, propagating -EIO on failure.
  - Eliminated dead store of cap in margin_enable_write().
  - Explicitly checked speed == PCIE_SPEED_64_0GT in pci_lmr_init() to avoid misidentifying PCI_SPEED_UNKNOWN (0xFF) as Gen6.
---
 drivers/pci/pci-driver.c                     |   1 +
 drivers/pci/pci.h                            |  10 +
 drivers/pci/pcie/Kconfig                     |  12 +
 drivers/pci/pcie/Makefile                    |   1 +
 drivers/pci/pcie/margin.c                    | 890 +++++++++++++++++++++++++++
 drivers/pci/probe.c                          |   1 +
 drivers/pci/remove.c                         |   1 +
 include/linux/pci.h                          |   6 +
 include/uapi/linux/pci_regs.h                |  18 +
 tools/testing/selftests/Makefile             |   1 +
 tools/testing/selftests/pcie_lmt/Makefile    |   3 +
 tools/testing/selftests/pcie_lmt/pcie_lmt.sh | 105 ++++
 12 files changed, 1049 insertions(+)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index f36778e62ac1..17544a7023fc 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -821,6 +821,7 @@ static int pci_pm_suspend(struct device *dev)
 	 * since Coffee Lake, to enter a lower-power PM state.
 	 */
 	pci_suspend_ptm(pci_dev);
+	pci_suspend_lmr(pci_dev);
 
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_suspend(dev, PMSG_SUSPEND);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4469e1a77f3c..1f5fcc806f22 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1023,6 +1023,16 @@ static inline void pci_no_tph(void) { }
 static inline void pci_tph_init(struct pci_dev *dev) { }
 #endif
 
+#ifdef CONFIG_PCIE_LMR
+void pci_lmr_init(struct pci_dev *dev);
+void pci_lmr_exit(struct pci_dev *dev);
+void pci_suspend_lmr(struct pci_dev *dev);
+#else
+static inline void pci_lmr_init(struct pci_dev *dev) { }
+static inline void pci_lmr_exit(struct pci_dev *dev) { }
+static inline void pci_suspend_lmr(struct pci_dev *dev) { }
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
index 000000000000..4124bde1490e
--- /dev/null
+++ b/drivers/pci/pcie/margin.c
@@ -0,0 +1,890 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI Express Lane Margining at Receiver
+ *
+ * Copyright (C) 2026 Google LLC
+ * Author: Priyank Rathod <rathodpriyank@google.com>
+ *
+ * Lane Margining at Receiver (PCIe Base Specification r6.0, sec 8.4.4)
+ * allows system software to determine the voltage and timing margins of
+ * each physical lane on a PCIe link. The Extended Capability (ID 0x27)
+ * is available for receivers operating at 16.0 GT/s (Gen4) or higher data
+ * rates, and is mandatory for receivers operating at 64.0 GT/s (Gen6) or
+ * higher data rates.
+ *
+ * This driver implements:
+ *   - Probing Extended Capability ID 0x27 and Margining Port Capabilities.
+ *   - Managing ASPM L0s/L1 link states during active margining per spec.
+ *   - PCIe r6.0 NO_CMD (0x7) clearing handshake per receiver and lane.
+ *   - Caching receiver capabilities & step counts to avoid DEMARGIN side-effects.
+ *   - Handling Symmetric vs Independent Left/Right & Up/Down margin steps.
+ *   - Exposing per-device debugfs interfaces under /sys/kernel/debug/pci/.
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
+/* Margin type encodings per PCIe Base Spec r6.0 sec 8.4.4 */
+#define LMR_TYPE_DEMARGIN               0x0
+#define LMR_TYPE_REPORT_CAPS            0x1
+#define LMR_TYPE_REPORT_VOLTAGE_STEPS   0x2
+#define LMR_TYPE_REPORT_TIMING_STEPS    0x3
+#define LMR_TYPE_TIMING                 0x4
+#define LMR_TYPE_VOLTAGE                0x5
+#define LMR_TYPE_NO_CMD                 0x7
+
+/* LMR command timing parameters */
+#define LMR_CMD_TIMEOUT_MS              150
+#define LMR_CMD_SLEEP_MIN_US            100
+#define LMR_CMD_SLEEP_MAX_US            250
+#define LMR_ENABLE_TIMEOUT_MS           150
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
+struct pci_margin_rx_info {
+	bool caps_cached;
+	u8 caps;
+	u8 num_timing_steps;
+	u8 num_voltage_steps;
+};
+
+struct pci_margin_lane {
+	struct pci_margin_dev *mdev;
+	int lane;
+	u8 rx;
+	int timing_val;
+	int voltage_val;
+	struct pci_margin_rx_info rx_info[LMR_MAX_RX_NUM + 1];
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
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+static struct dentry *pci_debugfs_root_dir;
+
+static struct dentry *get_pci_debugfs_root(void)
+{
+	if (!pci_debugfs_root_dir)
+		pci_debugfs_root_dir = debugfs_lookup("pci", NULL);
+	if (!pci_debugfs_root_dir)
+		pci_debugfs_root_dir = debugfs_create_dir("pci", NULL);
+	return pci_debugfs_root_dir;
+}
+#endif
+
+/*
+ * pci_lmr_run_cmd() - Issue LMR command to Lane Control and wait for Status.
+ * Must be called with mdev->lock held.
+ */
+static int pci_lmr_run_cmd(struct pci_dev *dev, int lane, u8 rx, u8 type,
+			   u8 usage, u8 payload, u16 *status_val)
+{
+	u16 lmr = dev->lmr_cap;
+	u16 ctrl_offset = lmr + PCI_LMR_LANE_CTRL + LMR_LANE_REG_STRIDE * lane;
+	u16 sts_offset = lmr + PCI_LMR_LANE_STS + LMR_LANE_REG_STRIDE * lane;
+	u16 ctrl, sts;
+	unsigned long timeout;
+
+	/*
+	 * Per PCIe Base Spec r6.0 sec 8.4.4, software must issue NO_CMD (0x7)
+	 * targeting the specific receiver (rx) to clear MTYPE in Lane Status
+	 * before issuing a subsequent command.
+	 */
+	if (type != LMR_TYPE_NO_CMD) {
+		ctrl = FIELD_PREP(PCI_LMR_LANE_CTRL_RX_NUM, rx) |
+		       FIELD_PREP(PCI_LMR_LANE_CTRL_MTYPE, LMR_TYPE_NO_CMD) |
+		       FIELD_PREP(PCI_LMR_LANE_CTRL_USAGE, 0) |
+		       FIELD_PREP(PCI_LMR_LANE_CTRL_PAYLOAD, 0);
+
+		pci_write_config_word(dev, ctrl_offset, ctrl);
+
+		timeout = jiffies + msecs_to_jiffies(LMR_CMD_TIMEOUT_MS);
+		while (1) {
+			if (pci_read_config_word(dev, sts_offset, &sts))
+				return -EIO;
+			if (sts == 0xFFFF)
+				return -ENODEV;
+			if (FIELD_GET(PCI_LMR_LANE_STS_MTYPE, sts) == LMR_TYPE_NO_CMD &&
+			    FIELD_GET(PCI_LMR_LANE_STS_RX_NUM, sts) == rx)
+				break;
+			if (time_after(jiffies, timeout))
+				return -ETIMEDOUT;
+			usleep_range(LMR_CMD_SLEEP_MIN_US, LMR_CMD_SLEEP_MAX_US);
+		}
+	}
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
+		if (pci_read_config_word(dev, sts_offset, &sts))
+			return -EIO;
+		if (sts == 0xFFFF)
+			return -ENODEV;
+
+		if (FIELD_GET(PCI_LMR_LANE_STS_MTYPE, sts) == type &&
+		    FIELD_GET(PCI_LMR_LANE_STS_RX_NUM, sts) == rx) {
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
+static int pci_lmr_demargin_lane(struct pci_margin_lane *plane)
+{
+	u16 sts;
+	int ret;
+
+	if (plane->timing_val == 0 && plane->voltage_val == 0)
+		return 0;
+
+	ret = pci_lmr_run_cmd(plane->mdev->dev, plane->lane, plane->rx,
+			      LMR_TYPE_DEMARGIN, 0, 0, &sts);
+	if (!ret) {
+		plane->timing_val = 0;
+		plane->voltage_val = 0;
+	}
+	return ret;
+}
+
+static int pci_lmr_cache_rx_info(struct pci_margin_lane *plane, u8 rx)
+{
+	struct pci_margin_rx_info *info = &plane->rx_info[rx];
+	u16 sts;
+	int ret;
+
+	if (info->caps_cached)
+		return 0;
+
+	/* Issuing REPORT_CAPS aborts any active margin per PCIe spec */
+	pci_lmr_demargin_lane(plane);
+
+	ret = pci_lmr_run_cmd(plane->mdev->dev, plane->lane, rx,
+			      LMR_TYPE_REPORT_CAPS, 0, 0, &sts);
+	if (ret)
+		return ret;
+	info->caps = FIELD_GET(PCI_LMR_LANE_STS_PAYLOAD, sts);
+
+	ret = pci_lmr_run_cmd(plane->mdev->dev, plane->lane, rx,
+			      LMR_TYPE_REPORT_TIMING_STEPS, 0, 0, &sts);
+	if (ret)
+		return ret;
+	info->num_timing_steps = FIELD_GET(PCI_LMR_LANE_STS_PAYLOAD, sts) & LMR_STEPS_MASK;
+
+	ret = pci_lmr_run_cmd(plane->mdev->dev, plane->lane, rx,
+			      LMR_TYPE_REPORT_VOLTAGE_STEPS, 0, 0, &sts);
+	if (ret)
+		return ret;
+	info->num_voltage_steps = FIELD_GET(PCI_LMR_LANE_STS_PAYLOAD, sts) & LMR_STEPS_MASK;
+
+	info->caps_cached = true;
+	return 0;
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
+	if (pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_CAP, &cap))
+		return -EIO;
+	seq_printf(s, "Port Capabilities: %#06x\n", cap);
+	seq_printf(s, "  Uses SW Ready: %s\n",
+		   (cap & PCI_LMR_PORT_CAP_USES_SW_READY) ? "yes" : "no");
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
+	if (pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &sts))
+		return -EIO;
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
+	bool enabled;
+
+	mutex_lock(&mdev->lock);
+	enabled = mdev->enabled;
+	mutex_unlock(&mdev->lock);
+
+	seq_printf(s, "%d\n", enabled);
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
+		if (pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_CAP, &cap)) {
+			ret = -EIO;
+			goto out;
+		}
+
+		/*
+		 * PCIe Base Spec r6.0: Link must be maintained in L0 during
+		 * active margining. Disable ASPM L0s/L1.
+		 */
+		pci_disable_link_state(dev, PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1);
+
+		if (cap & PCI_LMR_PORT_CAP_USES_SW_READY) {
+			if (pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &sts)) {
+				ret = -EIO;
+				goto out;
+			}
+			sts |= PCI_LMR_PORT_STS_SW_READY;
+			pci_write_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, sts);
+		}
+
+		timeout = jiffies + msecs_to_jiffies(LMR_ENABLE_TIMEOUT_MS);
+		while (1) {
+			if (pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &sts)) {
+				ret = -EIO;
+				goto out;
+			}
+			if (sts == 0xFFFF) {
+				ret = -ENODEV;
+				goto out;
+			}
+			if (sts & PCI_LMR_PORT_STS_MARGIN_READY)
+				break;
+			if (time_after(jiffies, timeout)) {
+				ret = -ETIMEDOUT;
+				if (cap & PCI_LMR_PORT_CAP_USES_SW_READY) {
+					sts &= ~PCI_LMR_PORT_STS_SW_READY;
+					pci_write_config_word(dev,
+							      mdev->cap + PCI_LMR_PORT_STS,
+							      sts);
+				}
+				goto out;
+			}
+			usleep_range(LMR_ENABLE_SLEEP_MIN_US, LMR_ENABLE_SLEEP_MAX_US);
+		}
+
+		/* Cache capabilities for local receiver on all lanes */
+		for (i = 0; i < mdev->num_lanes; i++) {
+			mdev->lanes[i].rx = LMR_RX_LOCAL;
+			pci_lmr_cache_rx_info(&mdev->lanes[i], LMR_RX_LOCAL);
+		}
+		mdev->enabled = true;
+	} else {
+		/* Demargin all lanes before clearing SW_READY */
+		for (i = 0; i < mdev->num_lanes; i++)
+			pci_lmr_demargin_lane(&mdev->lanes[i]);
+
+		if (pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &sts) == 0) {
+			sts &= ~PCI_LMR_PORT_STS_SW_READY;
+			pci_write_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, sts);
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
+	int rx;
+
+	mutex_lock(&plane->mdev->lock);
+	rx = plane->rx;
+	mutex_unlock(&plane->mdev->lock);
+
+	seq_printf(s, "%d\n", rx);
+	return 0;
+}
+
+static ssize_t margin_lane_receiver_write(struct file *file, const char __user *user_buf,
+				      size_t count, loff_t *ppos)
+{
+	struct pci_margin_lane *plane = ((struct seq_file *)file->private_data)->private;
+	struct pci_margin_dev *mdev = plane->mdev;
+	int ret;
+	int rx;
+
+	ret = kstrtoint_from_user(user_buf, count, 0, &rx);
+	if (ret)
+		return ret;
+
+	if (rx < 0 || rx > LMR_MAX_RX_NUM)
+		return -EINVAL;
+
+	mutex_lock(&mdev->lock);
+	if (plane->rx == rx)
+		goto out;
+
+	if (mdev->enabled) {
+		/* Demargin previous receiver per single-receiver spec rule */
+		pci_lmr_demargin_lane(plane);
+		ret = pci_lmr_cache_rx_info(plane, rx);
+		if (ret)
+			goto out;
+	}
+
+	plane->rx = rx;
+out:
+	mutex_unlock(&mdev->lock);
+	return ret ? ret : count;
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
+	struct pci_margin_rx_info *info;
+	int ret = 0;
+	u8 val;
+
+	mutex_lock(&mdev->lock);
+	if (!mdev->enabled) {
+		ret = -EACCES;
+		goto out;
+	}
+
+	ret = pci_lmr_cache_rx_info(plane, plane->rx);
+	if (ret)
+		goto out;
+
+	info = &plane->rx_info[plane->rx];
+	val = info->caps;
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
+out:
+	mutex_unlock(&mdev->lock);
+	return ret;
+}
+DEFINE_SHOW_ATTRIBUTE(margin_lane_caps);
+
+static int margin_lane_timing_steps_show(struct seq_file *s, void *v)
+{
+	struct pci_margin_lane *plane = s->private;
+	struct pci_margin_dev *mdev = plane->mdev;
+	struct pci_margin_rx_info *info;
+	int ret = 0;
+
+	mutex_lock(&mdev->lock);
+	if (!mdev->enabled) {
+		ret = -EACCES;
+		goto out;
+	}
+
+	ret = pci_lmr_cache_rx_info(plane, plane->rx);
+	if (!ret) {
+		info = &plane->rx_info[plane->rx];
+		seq_printf(s, "%d\n", info->num_timing_steps);
+	}
+out:
+	mutex_unlock(&mdev->lock);
+	return ret;
+}
+DEFINE_SHOW_ATTRIBUTE(margin_lane_timing_steps);
+
+static int margin_lane_voltage_steps_show(struct seq_file *s, void *v)
+{
+	struct pci_margin_lane *plane = s->private;
+	struct pci_margin_dev *mdev = plane->mdev;
+	struct pci_margin_rx_info *info;
+	int ret = 0;
+
+	mutex_lock(&mdev->lock);
+	if (!mdev->enabled) {
+		ret = -EACCES;
+		goto out;
+	}
+
+	ret = pci_lmr_cache_rx_info(plane, plane->rx);
+	if (!ret) {
+		info = &plane->rx_info[plane->rx];
+		seq_printf(s, "%d\n", info->num_voltage_steps);
+	}
+out:
+	mutex_unlock(&mdev->lock);
+	return ret;
+}
+DEFINE_SHOW_ATTRIBUTE(margin_lane_voltage_steps);
+
+static ssize_t margin_lane_timing_write(struct file *file, const char __user *user_buf,
+				    size_t count, loff_t *ppos)
+{
+	struct pci_margin_lane *plane = ((struct seq_file *)file->private_data)->private;
+	struct pci_margin_dev *mdev = plane->mdev;
+	struct pci_margin_rx_info *info;
+	int val, ret;
+	u8 step, dir;
+	u16 sts;
+	u8 caps;
+
+	ret = kstrtoint_from_user(user_buf, count, 0, &val);
+	if (ret)
+		return ret;
+
+	if (val > LMR_MAX_TIMING_STEP || val < -LMR_MAX_TIMING_STEP)
+		return -EINVAL;
+
+	mutex_lock(&mdev->lock);
+	if (!mdev->enabled) {
+		ret = -EACCES;
+		goto out;
+	}
+
+	if (val == 0) {
+		ret = pci_lmr_demargin_lane(plane);
+		goto out;
+	}
+
+	ret = pci_lmr_cache_rx_info(plane, plane->rx);
+	if (ret)
+		goto out;
+
+	info = &plane->rx_info[plane->rx];
+	caps = info->caps;
+
+	if (val < 0) {
+		step = -val;
+		if (!(caps & LMR_CAP_IND_LEFT_RIGHT_TIMING)) {
+			/* Symmetric margining requires dir=1 per spec */
+			ret = -EINVAL;
+			goto out;
+		}
+		dir = LMR_STEP_DIR_DECREASE;
+	} else {
+		step = val;
+		dir = LMR_STEP_DIR_INCREASE;
+	}
+
+	if (step > info->num_timing_steps) {
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
+	/* Record actual step count applied by hardware */
+	step = FIELD_GET(PCI_LMR_LANE_STS_PAYLOAD, sts) & LMR_TIMING_STEP_MASK;
+	plane->timing_val = (dir == LMR_STEP_DIR_DECREASE) ? -step : step;
+
+out:
+	mutex_unlock(&mdev->lock);
+	return ret ? ret : count;
+}
+
+static int margin_lane_timing_show(struct seq_file *s, void *v)
+{
+	struct pci_margin_lane *plane = s->private;
+	int timing_val;
+
+	mutex_lock(&plane->mdev->lock);
+	timing_val = plane->timing_val;
+	mutex_unlock(&plane->mdev->lock);
+
+	seq_printf(s, "%d\n", timing_val);
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
+	struct pci_margin_rx_info *info;
+	int val, ret;
+	u8 step, dir;
+	u16 sts;
+	u8 caps;
+
+	ret = kstrtoint_from_user(user_buf, count, 0, &val);
+	if (ret)
+		return ret;
+
+	if (val > LMR_MAX_VOLTAGE_STEP || val < -LMR_MAX_VOLTAGE_STEP)
+		return -EINVAL;
+
+	mutex_lock(&mdev->lock);
+	if (!mdev->enabled) {
+		ret = -EACCES;
+		goto out;
+	}
+
+	if (val == 0) {
+		ret = pci_lmr_demargin_lane(plane);
+		goto out;
+	}
+
+	ret = pci_lmr_cache_rx_info(plane, plane->rx);
+	if (ret)
+		goto out;
+
+	info = &plane->rx_info[plane->rx];
+	caps = info->caps;
+
+	if (val < 0) {
+		step = -val;
+		if (!(caps & LMR_CAP_IND_UP_DOWN_VOLTAGE)) {
+			/* Symmetric voltage margining requires dir=1 per spec */
+			ret = -EINVAL;
+			goto out;
+		}
+		dir = 0;
+	} else {
+		step = val;
+		dir = 1;
+	}
+
+	if (step > info->num_voltage_steps) {
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
+	step = FIELD_GET(PCI_LMR_LANE_STS_PAYLOAD, sts) & LMR_VOLTAGE_STEP_MASK;
+	plane->voltage_val = (dir == 0) ? -step : step;
+
+out:
+	mutex_unlock(&mdev->lock);
+	return ret ? ret : count;
+}
+
+static int margin_lane_voltage_show(struct seq_file *s, void *v)
+{
+	struct pci_margin_lane *plane = s->private;
+	int voltage_val;
+
+	mutex_lock(&plane->mdev->lock);
+	voltage_val = plane->voltage_val;
+	mutex_unlock(&plane->mdev->lock);
+
+	seq_printf(s, "%d\n", voltage_val);
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
+	struct dentry *parent;
+	char dirname[64];
+	int i;
+
+	parent = get_pci_debugfs_root();
+	snprintf(dirname, sizeof(dirname), "pcie_lmr_%s", dev_name(&dev->dev));
+	mdev->debugfs = debugfs_create_dir(dirname, parent);
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
+		if (speed == PCIE_SPEED_64_0GT)
+			pci_warn(dev,
+				 "Missing Lane Margining at Receiver Capability (mandatory for Gen6+)\n");
+		else if (speed >= PCIE_SPEED_16_0GT && speed != PCI_SPEED_UNKNOWN)
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
+		 speed == PCIE_SPEED_64_0GT ? LMR_GEN6 :
+		 speed == PCIE_SPEED_32_0GT ? LMR_GEN5 :
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
+	int i;
+
+	if (!mdev)
+		return;
+
+	mutex_lock(&mdev->lock);
+	if (mdev->enabled) {
+		for (i = 0; i < mdev->num_lanes; i++)
+			pci_lmr_demargin_lane(&mdev->lanes[i]);
+	}
+	mutex_unlock(&mdev->lock);
+
+	pci_margin_debugfs_remove(mdev);
+	mutex_destroy(&mdev->lock);
+	kfree(mdev->lanes);
+	kfree(mdev);
+	dev->lmr = NULL;
+}
+
+void pci_suspend_lmr(struct pci_dev *dev)
+{
+	struct pci_margin_dev *mdev = dev->lmr;
+	int i;
+	u16 sts;
+
+	if (!mdev)
+		return;
+
+	mutex_lock(&mdev->lock);
+	if (mdev->enabled) {
+		for (i = 0; i < mdev->num_lanes; i++)
+			pci_lmr_demargin_lane(&mdev->lanes[i]);
+
+		if (pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &sts) == 0) {
+			sts &= ~PCI_LMR_PORT_STS_SW_READY;
+			pci_write_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, sts);
+		}
+		mdev->enabled = false;
+	}
+	mutex_unlock(&mdev->lock);
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
index facaa324bd86..90cbe310e62f 100644
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
@@ -1181,6 +1182,23 @@
 #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_MASK		0x000000F0
 #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_SHIFT	4
 
+/* Lane Margining at Receiver */
+#define PCI_LMR_PORT_CAP		0x04	/* Margining Port Capabilities */
+#define  PCI_LMR_PORT_CAP_USES_SW_READY	0x0001	/* Margining Uses Software Ready */
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
index 000000000000..22c00c2b8956
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
+	# Allow searching debugfs root or pci directory
+	:
+fi
+
+LMR_DEVS=$(ls -d $DEBUGFS/pci/pcie_lmr_* $DEBUGFS/pcie_lmr_* 2>/dev/null || true)
+if [ -z "$LMR_DEVS" ]; then
+	echo "$skipmsg no PCIe LMR devices found in $DEBUGFS/" >&2
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
