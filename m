Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853ED3ACF16
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 02:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788490118; cv=none; b=kthN/EKRRri5Mulv5GEyeQtTt03mIkG9NsCwXlTbMZZBZ1vn707s5WfuqA1opkuXFB72EUwCuDZhHSMSRwUqt17UFJLUoqyuVQ4z6UhJEOmKI1PUQ3ofTN0W7AXQ5/EeUQBUaRAYkPOK0HUzQv/BwTMFMGd9jFA/FgW2g+7EdH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788490118; c=relaxed/simple;
	bh=Kxq935JJP/CqltM1DhVvplI6qCbPwrGJHYtpMz+H1y0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kZUv2PcTht65BiXjc0dddFLsI5MuJ9u5x+LpFslOyx6QakNESosn9EwcymrY72JtPWQFvCO1fMjTVeexF2DWi9YAmnys5n4pD7LjL4/gQtwfFx1HYYwJYcqRHGVUp/IAqP8mT9vfxvWu/2d7uV0xRvDje+qxZI54VeXzjV4h0YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A0hhgVE5; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A0hhgVE5"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cfc52ddc55so8442405ad.3
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2026 19:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788490113; x=1789094913; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=52EZ7jnHXHpIgst2AUL8Hf/DzD4ZmTivxGlVuAX/kx8=;
        b=A0hhgVE5vQdmVjDc8ncQIaZveZmc6HvZt5gmQgqQjYarI5YDfjmjsAGasj8y/haZk1
         CDkU/vOlyEdVzXpVl2vkY2V0JxUadUpdXYkvPPl+zveYkA4Hx3a2TfCJN6BxGzvzBlG1
         EstzmzsMRRgNX8qHGTULnc1TLIqcczHORWGctNblJCIoevhruXpxGq/cDJ4r/X7PT6YU
         6xD/S9Kau7BkDxFj4oNuKX3UPAPV/i9euHRxMewP69P1BXVIBsc7jnAZAmiqvKdIV444
         Aczee9heR6Nl+7cimgRfrqEbsoQzQfiqaR/FYCiozj4e7jTH3Nr8gmnSAgYG4r5i+wY7
         FTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788490113; x=1789094913;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=52EZ7jnHXHpIgst2AUL8Hf/DzD4ZmTivxGlVuAX/kx8=;
        b=TH8lxQmcknrPF4U/2AKWHrH1lcdu8O9HpN8qdoXNYscmUCcVR5nhHig3GV4kgBTwA7
         cb7t29FTE6kdqDemtb1BitWvHjGKVEmEtgokeeSsSX2qqat55Lh9UFqLcyVPBBvFqLPy
         KwK1mURttKwhr/H5XkwV5BTTRRt7zd96Z/ZKTnvQqQzAF80uDBO8Slb4QIcRfHmGuI5D
         5drdpD9FR/754o4XMy1Ry+DA8AO+nHtM8kYYrsAV0ICx0jC39MYFebbB3fW1T2Niqda4
         TmM3qsOWT84jc5mPE9iGh98omyw+8EoMMb2MSiIcRkqhpcbc3+MrwmVxo2cB5jg1xExz
         APHw==
X-Forwarded-Encrypted: i=1; AKwUvBx7e7NIn8sHrEPbP7Z5u01a3UjMg4MUcAGjHkszeD7v8YftlYfXyUQwgA+Hh91CFijOhNFXZQ0nVhw=@vger.kernel.org
X-Gm-Message-State: AFuF++mCgbdJg0IslYqjGi3H7ZWCll/rrfxn82qcoxLHTja+Wib9O52n
	5cIanQy8llSOB2WWDwu/9PEwvxzm8gQ8ggp3EWjcg+dweWKM25Oq5pe4/joMwLKT1USaKNadvH/
	nLKiZ/zSgtWhlKEXOSh7YlR0za+J5EQQ/ww==
X-Received: from pjbbg9.prod.google.com ([2002:a17:90b:d89:b0:398:c7c7:ede1])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5246:b0:39a:e983:d4bd with SMTP id 98e67ed59e1d1-39b262a3cf7mr5364343a91.24.1788490112065;
 Thu, 03 Sep 2026 19:48:32 -0700 (PDT)
Date: Fri, 04 Sep 2026 02:48:30 +0000
In-Reply-To: <20260904-pcie-link-endpoints-v2-0-16fcb301a3e4@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260904-pcie-link-endpoints-v2-0-16fcb301a3e4@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260904-pcie-link-endpoints-v2-3-16fcb301a3e4@google.com>
Subject: [PATCH v2 3/3] PCI/pcie: Add PCIe Lane Margining at Receiver (LMR) support
From: Priyank Rathod <rathodpriyank@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: "=?utf-8?q?Ilpo_J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Priyank Rathod <rathodpriyank@google.com>, 
	sashiko-bot@kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org
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
  - Add MAINTAINERS entry for PCIe Lane Margining at Receiver (LMR).

Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
---
 Documentation/PCI/index.rst                  |    1 +
 Documentation/PCI/pcie-lmr.rst               |  174 +++
 MAINTAINERS                                  |    8 +
 drivers/pci/pci.h                            |    8 +
 drivers/pci/pcie/Kconfig                     |   12 +
 drivers/pci/pcie/Makefile                    |    1 +
 drivers/pci/pcie/margin.c                    | 1592 ++++++++++++++++++++++++++
 drivers/pci/probe.c                          |    1 +
 drivers/pci/remove.c                         |    2 +-
 include/linux/pci.h                          |    6 +
 include/uapi/linux/pci_regs.h                |   18 +
 tools/testing/selftests/Makefile             |    1 +
 tools/testing/selftests/pcie_lmt/Makefile    |    3 +
 tools/testing/selftests/pcie_lmt/pcie_lmt.sh |  287 +++++
 14 files changed, 2113 insertions(+), 1 deletion(-)

diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
index 5d720d2a415e..9170c98cbf3f 100644
--- a/Documentation/PCI/index.rst
+++ b/Documentation/PCI/index.rst
@@ -20,3 +20,4 @@ PCI Bus Subsystem
    controller/index
    boot-interrupts
    tph
+   pcie-lmr
diff --git a/Documentation/PCI/pcie-lmr.rst b/Documentation/PCI/pcie-lmr.rst
new file mode 100644
index 000000000000..7f7bb242551e
--- /dev/null
+++ b/Documentation/PCI/pcie-lmr.rst
@@ -0,0 +1,174 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================================================
+PCI Express Lane Margining at Receiver (LMR) Subsystem
+=======================================================
+
+:Author: Priyank Rathod <rathodpriyank@google.com>
+:Copyright: 2026 Google LLC
+
+Overview
+========
+
+Lane Margining at Receiver (LMR), specified in the PCI Express Base
+Specification (Revision 7.0 sec 7.7.11 & sec 8.4.4),
+allows system software to evaluate high-speed link physical signal integrity and
+eye margins. LMR measures available timing (jitter/phase) and voltage margin
+offsets for each physical lane and receiver independently while the link is
+operating in active L0 state.
+
+Lane Margining Extended Capability (ID 0x27) is optional for links operating at
+16.0 GT/s (PCIe Gen 4) and 32.0 GT/s (Gen 5), and is mandatory for receivers
+operating at 64.0 GT/s (Gen 6) and higher.
+
+Target Receivers
+================
+
+Each physical lane can margin up to 7 distinct receivers per PCIe link:
+
+* **Receiver 0 (Local Receiver)**: The receiver in the immediate link partner.
+* **Receivers 1 to 6 (Retimers)**: Retimer pseudo-ports along the physical link
+  (up to 3 retimers, each with upstream and downstream pseudo-ports).
+* **Receiver 7**: Reserved per PCIe Base Specification.
+
+Kernel Configuration
+====================
+
+Enable the kernel configuration option under PCI support:
+
+.. code-block:: none
+
+   CONFIG_PCIE_LMR=y (or =m)
+
+Dependencies:
+* ``CONFIG_PCI``
+* ``CONFIG_DEBUG_FS``
+
+Debugfs Interface Guide
+=======================
+
+When an LMR-capable device is enumerated on a Gen4+ link, the kernel exposes
+per-device control and status files under debugfs:
+
+.. code-block:: none
+
+   /sys/kernel/debug/pci/pcie_lmr_<domain>:<bus>:<dev>.<func>/
+
+Device-Level Attributes
+-----------------------
+
+* ``capabilities`` (read-only):
+  Displays the 16-bit Margining Port Capabilities register and whether the
+  device uses the Software Ready handshake bit.
+
+* ``port_status`` (read-only):
+  Displays the Margining Port Status register, indicating Margining Ready and
+  SW Ready states.
+
+* ``enable`` (read-write):
+  Enables (``1``) or disables (``0``) Lane Margining on the device.
+  Enabling margining locks the link into D0, prevents runtime PM suspend,
+  disables ASPM L0s/L1, disables hardware autonomous link width/speed changes,
+  and verifies that the link is operating at >= 16.0 GT/s.
+  Disabling margining restores ASPM, hardware autonomous width/speed settings,
+  and runtime PM, and returns all lanes to nominal (normal) operating settings.
+
+Lane-Level Attributes
+---------------------
+
+For each physical lane (``lane0``, ``lane1``, ...):
+
+* ``receiver`` (read-write):
+  Gets or sets the active target receiver number (``0`` for local receiver,
+  ``1..6`` for retimers). Switching receivers automatically clears previous
+  offsets back to normal settings per PCIe single-receiver margining requirements.
+
+* ``caps`` (read-only):
+  Reports the target receiver's margining capabilities (PCIe Base Specification
+  Revision 7.0 Table 4-77 and Table 8-13):
+  - Voltage Margining support (supported vs unsupported)
+  - Independent Left/Right Timing Margining support (independent vs symmetric)
+  - Independent Up/Down Voltage Margining support (independent vs symmetric)
+  - Error Sampler vs Main Sampler (independent error sampler vs intrusive main sampler)
+  - Sample Reporting Method (sampling rate vs sample count)
+
+* ``num_timing_steps`` (read-only):
+  Maximum timing margin steps supported by the receiver (0..63).
+
+* ``num_voltage_steps`` (read-only):
+  Maximum voltage margin steps supported by the receiver (0..127).
+
+* ``margin_timing`` (read-write):
+  Applies timing margin step offset (+/-). Writing ``0`` clears timing margin
+  back to nominal.
+
+* ``margin_voltage`` (read-write):
+  Applies voltage margin step offset (+/-). Writing ``0`` clears voltage margin
+  back to nominal.
+
+Manual Margining Example
+========================
+
+1. Inspect device capabilities and status:
+
+.. code-block:: sh
+
+   cat /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/capabilities
+   cat /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/port_status
+
+2. Enable Lane Margining mode:
+
+.. code-block:: sh
+
+   echo 1 > /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/enable
+
+3. Configure target receiver and inspect step limits on lane 0:
+
+.. code-block:: sh
+
+   echo 0 > /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/receiver
+   cat /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/caps
+   cat /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/num_timing_steps
+   cat /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/num_voltage_steps
+
+4. Apply timing and voltage margin steps:
+
+.. code-block:: sh
+
+   # Step timing margin +2 steps
+   echo 2 > /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/margin_timing
+
+   # Step voltage margin +1 step
+   echo 1 > /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/margin_voltage
+
+5. Reset margins back to nominal:
+
+.. code-block:: sh
+
+   echo 0 > /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/margin_timing
+   echo 0 > /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/margin_voltage
+
+6. Disable Lane Margining when complete:
+
+.. code-block:: sh
+
+   echo 0 > /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/enable
+
+Automated Testing via Kselftest
+===============================
+
+The kernel includes an automated kselftest script under
+``tools/testing/selftests/pcie_lmt/pcie_lmt.sh`` to probe, validate, and exercise
+debugfs controls across all enumerated LMR devices.
+
+Run directly as root:
+
+.. code-block:: sh
+
+   sudo ./tools/testing/selftests/pcie_lmt/pcie_lmt.sh
+
+Or run via the kselftest test harness:
+
+.. code-block:: sh
+
+   make -C tools/testing/selftests TARGETS=pcie_lmt run_tests
diff --git a/MAINTAINERS b/MAINTAINERS
index 3a19da74d00c..312cd68a66be 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21293,6 +21293,14 @@ F:	Documentation/devicetree/bindings/pci/qcom,sa8255p-pcie-ep.yaml
 F:	drivers/pci/controller/dwc/pcie-qcom-common.c
 F:	drivers/pci/controller/dwc/pcie-qcom-ep.c
 
+PCIE LANE MARGINING AT RECEIVER (LMR)
+M:	Priyank Rathod <rathodpriyank@google.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/PCI/pcie-lmr.rst
+F:	drivers/pci/pcie/margin.c
+F:	tools/testing/selftests/pcie_lmt/
+
 PCMCIA SUBSYSTEM
 M:	Dominik Brodowski <linux@dominikbrodowski.net>
 S:	Odd Fixes
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ba3c3fddddc2..0d84b693bc47 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1071,6 +1071,14 @@ static inline void pci_no_tph(void) { }
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
index 000000000000..1dde5aa928c7
--- /dev/null
+++ b/drivers/pci/pcie/margin.c
@@ -0,0 +1,1592 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI Express Lane Margining at Receiver
+ *
+ * Copyright (C) 2026 Google LLC
+ * Author: Priyank Rathod <rathodpriyank@google.com>
+ *
+ * Lane Margining at Receiver (PCIe Base Specification Revision 7.0,
+ * sec 7.7.11 & sec 8.4.4) allows system software to determine the voltage
+ * and timing margins of each physical lane on a PCIe link. The Extended
+ * Capability (ID 0x27) is available for receivers operating at 16.0 GT/s
+ * (Gen4) or higher data rates, and is mandatory for receivers operating at
+ * 64.0 GT/s (Gen6) or higher data rates.
+ *
+ * This driver implements:
+ *   - Probing Extended Capability ID 0x27 and Margining Port Capabilities.
+ *   - Managing ASPM L0s/L1 link states during active margining with
+ *     temporary inhibition (pci_aspm_inhibit).
+ *   - PCIe Base Specification NO_CMD (0x7) clearing handshake per receiver
+ *     and lane.
+ *   - Caching receiver capabilities & step counts to avoid side-effects
+ *     when setting to normal settings.
+ *   - Handling Symmetric vs Independent Left/Right & Up/Down margin steps.
+ *   - Runtime PM protection (D0 enforcement) during active margining.
+ *   - Exposing per-device debugfs interfaces under /sys/kernel/debug/pci/.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/jiffies.h>
+#include <linux/kstrtox.h>
+#include <linux/minmax.h>
+#include <linux/mutex.h>
+#include <linux/overflow.h>
+#include <linux/pci.h>
+#include <linux/pm_runtime.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+#include <linux/sprintf.h>
+#include <linux/string_choices.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+
+#include "../pci.h"
+
+/*
+ * Margining Type (MTYPE) field encodings (bits 5:3) in Margining Lane Control
+ * and Margining Lane Status registers per PCIe Base Specification
+ * Revision 7.0:
+ * - Section 7.7.11 "Lane Margining at the Receiver Extended Capability
+ *   (ID 0x27)" (Margining Lane Control & Margining Lane Status Registers)
+ * - Section 4.2.18.2 "Margin Command and Response Flow"
+ *   (Table 4-77 "Margin Commands and Corresponding Responses")
+ *
+ * Encodings:
+ *   001b (0x1) - Report Margin Control Capabilities
+ *   010b (0x2) - Set Margining Parameters (Go to Normal Settings,
+ *                Clear Error Log)
+ *   011b (0x3) - Step Margin Timing
+ *   100b (0x4) - Step Margin Voltage
+ *   111b (0x7) - No Command
+ *   (000b, 101b-110b are Reserved)
+ */
+#define LMR_TYPE_REPORT_CAPS		0x1	/* Report Capabilities */
+#define LMR_TYPE_SET_PARAMS		0x2	/* Set Margining Parameters */
+#define LMR_TYPE_TIMING			0x3	/* Step Margin Timing */
+#define LMR_TYPE_VOLTAGE		0x4	/* Step Margin Voltage */
+#define LMR_TYPE_NO_CMD			0x7	/* No Command */
+
+/* Command Payloads per PCIe Base Specification Revision 7.0 Table 4-77 */
+#define LMR_PAYLOAD_REPORT_CAPS		0x88	/* Report Capabilities */
+#define LMR_PAYLOAD_REPORT_VOLT_STEPS	0x89	/* Report Voltage Steps */
+#define LMR_PAYLOAD_REPORT_TIM_STEPS	0x8A	/* Report Timing Steps */
+#define LMR_PAYLOAD_GO_TO_NORMAL	0x0F	/* Go to Normal Settings */
+#define LMR_PAYLOAD_CLEAR_ERROR_LOG	0x55	/* Clear Error Log */
+#define LMR_PAYLOAD_NO_CMD		0x9C	/* No Command */
+
+/* LMR command timing parameters */
+#define LMR_CMD_TIMEOUT_MS              150
+#define LMR_CMD_SLEEP_MIN_US            100
+#define LMR_CMD_SLEEP_MAX_US            250
+#define LMR_ENABLE_TIMEOUT_MS           150
+#define LMR_ENABLE_SLEEP_MIN_US         1000
+#define LMR_ENABLE_SLEEP_MAX_US         2000
+
+/*
+ * LMR parameter limits per PCIe Base Specification Revision 7.0:
+ * - Max lanes (32): sec 7.7.11 & Table 8-13 (MMaxLanes max 31)
+ * - Receiver numbers 0..6: Table 4-76 (assignment) & Table 4-77 (valid for
+ *   commands)
+ * - Max timing step (63): sec 4.2.18.1.2, Table 4-77 (8Ah), & Table 8-13
+ * - Max voltage step (127): sec 4.2.18.1.2, Table 4-77 (89h), & Table 8-13
+ */
+#define LMR_MAX_LANES			32
+#define LMR_MAX_RX_NUM			6
+#define LMR_MAX_TIMING_STEP		63
+#define LMR_MAX_VOLTAGE_STEP		127
+
+/* LMR PCIe generation numbers and helper */
+#define LMR_GEN6                        6
+#define LMR_GEN5                        5
+#define LMR_GEN4                        4
+
+#define LMR_SPEED_TO_GEN(speed) \
+	((speed) >= PCIE_SPEED_64_0GT ? LMR_GEN6 : \
+	 (speed) >= PCIE_SPEED_32_0GT ? LMR_GEN5 : \
+	 LMR_GEN4)
+
+/* LMR lane register stride */
+#define LMR_LANE_REG_STRIDE             4
+
+/* LMR receivers */
+#define LMR_RX_LOCAL                    0
+
+/*
+ * Margining Payload field masks for Step Margin Timing and Step Margin Voltage
+ * per PCIe Base Specification Revision 7.0 sec 4.2.18.1.2
+ * ("Margin Payload for Step Margin Commands"):
+ *
+ * Step Margin Timing Payload:
+ *   Bit 7:    Reserved (must be 0b)
+ *   Bit 6:    Direction (0 = Right/Up, 1 = Left/Down)
+ *   Bits 5:0: Margin Step (0..63)
+ *
+ * Step Margin Voltage Payload:
+ *   Bit 7:    Direction (0 = Right/Up, 1 = Left/Down)
+ *   Bits 6:0: Margin Step (0..127)
+ */
+#define LMR_TIMING_STEP_MASK		GENMASK(5, 0)
+#define LMR_TIMING_DIR_MASK		BIT(6)
+#define LMR_VOLTAGE_STEP_MASK		GENMASK(6, 0)
+#define LMR_VOLTAGE_DIR_MASK		BIT(7)
+
+/*
+ * Margin Payload step direction field encodings per PCIe Base Specification
+ * Revision 7.0 sec 4.2.18.1.2 ("Margin Payload for Step Margin Commands"):
+ *
+ * For timing:
+ *   Bit 6: 0b = Right of normal setting (also 0b for symmetric margining)
+ *          1b = Left of normal setting (when MIndLeftRightTiming is Set)
+ * For voltage:
+ *   Bit 7: 0b = Up from normal setting (also 0b for symmetric margining)
+ *          1b = Down from normal setting (when MIndUpDownVoltage is Set)
+ */
+#define LMR_STEP_DIR_RIGHT_OR_UP	0
+#define LMR_STEP_DIR_LEFT_OR_DOWN	1
+
+/*
+ * Report Margin Control Capabilities (Command 88h) response payload bit fields
+ * per PCIe Base Specification Revision 7.0 Table 4-77 & Table 8-13:
+ *   Bit 0:   MVoltageSupported (1 = Voltage margining supported;
+ *            0 = Not supported)
+ *   Bit 1:   MIndUpDownVoltage (1 = Independent Up/Down voltage supported;
+ *            0 = Symmetric)
+ *   Bit 2:   MIndLeftRightTiming (1 = Independent Left/Right timing
+ *            supported; 0 = Symmetric)
+ *   Bit 3:   MSampleReportingMethod (1 = Sampling rate supported;
+ *            0 = Sample count supported)
+ *   Bit 4:   MIndErrorSampler (1 = Independent error sampler;
+ *            0 = Main data sampler)
+ *   Bit 5:   MSampleMultipleReceivers (1 = Multiple receivers can be sampled
+ *            concurrently; 0 = Only one receiver at a time)
+ *   Bits 7:6: Reserved
+ */
+#define LMR_CAP_VOLTAGE_SUPPORTED	BIT(0)
+#define LMR_CAP_IND_UP_DOWN_VOLTAGE	BIT(1)
+#define LMR_CAP_IND_LEFT_RIGHT_TIMING	BIT(2)
+#define LMR_CAP_SAMPLE_REPORT_METHOD	BIT(3)
+#define LMR_CAP_IND_ERROR_SAMPLER	BIT(4)
+#define LMR_CAP_SAMPLE_MULTIPLE_RECEIVERS BIT(5)
+
+/*
+ * Step Margin Execution Status (Bits 7:6 of response payload per PCIe Base
+ * Specification Revision 7.0 sec 4.2.18.1.1 "Step Margin Execution Status"):
+ * 00b: Too many errors - Receiver autonomously went back to default settings
+ * 01b: Set up for margin in progress
+ * 10b: Margining in progress
+ * 11b: NAK - Unsupported Lane Margining command was issued
+ */
+#define LMR_STS_EXEC_MASK		GENMASK(7, 6)
+#define LMR_STS_EXEC_TOO_MANY_ERR	0x0
+#define LMR_STS_EXEC_SETUP_IN_PROGRESS	0x1
+#define LMR_STS_EXEC_IN_PROGRESS	0x2
+#define LMR_STS_EXEC_NAK		0x3
+#define LMR_STS_ERR_CNT_MASK		GENMASK(5, 0)
+
+/**
+ * struct pci_margin_rx_info - Cached Lane Margining receiver capabilities
+ * @caps_cached: True if receiver capabilities and step limits are cached
+ * @caps: Margining capabilities byte reported by receiver
+ * @num_timing_steps: Maximum timing margin steps supported by receiver
+ * @num_voltage_steps: Maximum voltage margin steps supported by receiver
+ */
+struct pci_margin_rx_info {
+	bool caps_cached;
+	u8 caps;
+	u8 num_timing_steps;
+	u8 num_voltage_steps;
+};
+
+/**
+ * struct pci_margin_lane - Per-lane margining state
+ * @mdev: Parent LMR margin device
+ * @lane: Physical lane index (0..num_lanes - 1)
+ * @rx: Selected target receiver number (0 = local, 1..6 = retimers)
+ * @timing_val: Current applied timing margin step offset (+/-)
+ * @voltage_val: Current applied voltage margin step offset (+/-)
+ * @rx_info: Cached receiver capabilities per receiver number
+ */
+struct pci_margin_lane {
+	struct pci_margin_dev *mdev;
+	int lane;
+	u8 rx;
+	int timing_val;
+	int voltage_val;
+	struct pci_margin_rx_info rx_info[LMR_MAX_RX_NUM + 1];
+};
+
+/**
+ * struct pci_margin_dev - PCIe Lane Margining device instance
+ * @dev: Underlying PCI device
+ * @partner: Connected link partner device across the PCIe link
+ * @cap: Extended capability offset (PCI_EXT_CAP_ID_LMR)
+ * @debugfs: Root debugfs dentry for this device
+ * @lock: Mutex protecting LMR hardware access, active margining enablement,
+ *        target receiver selection, and lane margining steps
+ * @enabled: True if Lane Margining is currently enabled
+ * @aspm_inhibited: True if ASPM is temporarily inhibited for active margining
+ * @autonomous_saved: True if original autonomous width/speed configuration
+ *                    has been saved
+ * @saved_dsp_lnkctl_valid: True if Downstream Port Link Control was saved
+ * @saved_dsp_lnkctl2_valid: True if Downstream Port Link Control 2 was saved
+ * @saved_usp_lnkctl_valid: True if Upstream Port Link Control was saved
+ * @saved_usp_lnkctl2_valid: True if Upstream Port Link Control 2 was saved
+ * @saved_dsp_lnkctl: Saved Link Control register bits for Downstream Port
+ * @saved_dsp_lnkctl2: Saved Link Control 2 register bits for Downstream Port
+ * @saved_usp_lnkctl: Saved Link Control register bits for Upstream Port
+ * @saved_usp_lnkctl2: Saved Link Control 2 register bits for Upstream Port
+ * @num_lanes: Number of lanes on the link
+ * @lanes: Flexible array of per-lane state structures
+ */
+struct pci_margin_dev {
+	struct pci_dev *dev;
+	struct pci_dev *partner;
+	u16 cap;
+	struct dentry *debugfs;
+	struct mutex lock;
+	bool enabled;
+	bool aspm_inhibited;
+	bool autonomous_saved;
+	bool saved_dsp_lnkctl_valid;
+	bool saved_dsp_lnkctl2_valid;
+	bool saved_usp_lnkctl_valid;
+	bool saved_usp_lnkctl2_valid;
+	u16 saved_dsp_lnkctl;
+	u16 saved_dsp_lnkctl2;
+	u16 saved_usp_lnkctl;
+	u16 saved_usp_lnkctl2;
+	int num_lanes;
+	struct pci_margin_lane lanes[] __counted_by(num_lanes);
+};
+
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+static DEFINE_MUTEX(pci_debugfs_root_lock);
+static struct dentry *pci_debugfs_root_dir;
+
+static struct dentry *get_pci_debugfs_root(void)
+{
+	mutex_lock(&pci_debugfs_root_lock);
+	if (!pci_debugfs_root_dir)
+		pci_debugfs_root_dir = debugfs_lookup("pci", NULL);
+	if (!pci_debugfs_root_dir)
+		pci_debugfs_root_dir = debugfs_create_dir("pci", NULL);
+	mutex_unlock(&pci_debugfs_root_lock);
+	return pci_debugfs_root_dir;
+}
+#endif
+
+/*
+ * pci_lmr_get_ports() - Identify Downstream and Upstream Port link partners
+ * using the already tracked mdev->dev and mdev->partner devices.
+ *
+ * For Root Ports and Switch Downstream Ports, @dev is the Downstream Port and
+ * @partner is the Upstream Port. For Endpoints and Switch Upstream Ports,
+ * @partner is the Downstream Port and @dev is the Upstream Port.
+ *
+ * Context: Called with mdev->lock held and partner already established.
+ * Does NOT acquire pci_bus_sem, preventing lock inversion deadlocks with
+ * device_lock.
+ */
+static void pci_lmr_get_ports(struct pci_margin_dev *mdev,
+			      struct pci_dev **downstream_port,
+			      struct pci_dev **upstream_port)
+{
+	struct pci_dev *dev = mdev->dev;
+	struct pci_dev *partner = mdev->partner;
+
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
+	    pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM) {
+		*downstream_port = dev;
+		*upstream_port = partner;
+	} else {
+		*downstream_port = partner;
+		*upstream_port = dev;
+	}
+}
+
+
+
+/*
+ * Helpers to manage Autonomous Width/Speed transitions per PCIe Base
+ * Specification Revision 7.0:
+ * - Section 7.5.3.7 "Link Control Register" (Hardware Autonomous Width
+ *   Disable, bit 9)
+ * - Section 7.5.3.17 "Link Control 2 Register" (Hardware Autonomous Speed
+ *   Disable, bit 5)
+ * - Section 4.2.18.4 "Receiver Margin Testing Requirements"
+ * - Section 8.4.4 "Lane Margining at the Receiver - Electrical Requirements"
+ *
+ * Both Downstream Port and Upstream Port must save and set Hardware Autonomous
+ * Width Disable and Hardware Autonomous Speed Disable bits during margining to
+ * guarantee that the link remains in a stable active L0 state.
+ */
+static void pci_lmr_disable_autonomous(struct pci_margin_dev *mdev)
+{
+	struct pci_dev *downstream_port, *upstream_port;
+	u16 lnkctl, lnkctl2;
+	int ret;
+
+	if (mdev->autonomous_saved)
+		return;
+
+	pci_lmr_get_ports(mdev, &downstream_port, &upstream_port);
+
+	/* 1. Downstream Component (upstream_port): Save and Disable FIRST */
+	if (upstream_port && pci_is_pcie(upstream_port) &&
+	    !pci_dev_is_disconnected(upstream_port) &&
+	    upstream_port->current_state == PCI_D0) {
+		ret = pcie_capability_read_word(upstream_port, PCI_EXP_LNKCTL, &lnkctl);
+		if (ret == PCIBIOS_SUCCESSFUL && !PCI_POSSIBLE_ERROR(lnkctl)) {
+			mdev->saved_usp_lnkctl = lnkctl;
+			mdev->saved_usp_lnkctl_valid = true;
+			pcie_capability_set_word(upstream_port, PCI_EXP_LNKCTL,
+						 PCI_EXP_LNKCTL_HAWD);
+		}
+
+		ret = pcie_capability_read_word(upstream_port, PCI_EXP_LNKCTL2, &lnkctl2);
+		if (ret == PCIBIOS_SUCCESSFUL && !PCI_POSSIBLE_ERROR(lnkctl2)) {
+			mdev->saved_usp_lnkctl2 = lnkctl2;
+			mdev->saved_usp_lnkctl2_valid = true;
+			pcie_capability_set_word(upstream_port, PCI_EXP_LNKCTL2,
+						 PCI_EXP_LNKCTL2_HASD);
+		}
+	}
+
+	/* 2. Upstream Component (downstream_port): Save and Disable SECOND */
+	if (downstream_port && pci_is_pcie(downstream_port) &&
+	    !pci_dev_is_disconnected(downstream_port) &&
+	    downstream_port->current_state == PCI_D0) {
+		ret = pcie_capability_read_word(downstream_port, PCI_EXP_LNKCTL, &lnkctl);
+		if (ret == PCIBIOS_SUCCESSFUL && !PCI_POSSIBLE_ERROR(lnkctl)) {
+			mdev->saved_dsp_lnkctl = lnkctl;
+			mdev->saved_dsp_lnkctl_valid = true;
+			pcie_capability_set_word(downstream_port, PCI_EXP_LNKCTL,
+						 PCI_EXP_LNKCTL_HAWD);
+		}
+
+		ret = pcie_capability_read_word(downstream_port, PCI_EXP_LNKCTL2, &lnkctl2);
+		if (ret == PCIBIOS_SUCCESSFUL && !PCI_POSSIBLE_ERROR(lnkctl2)) {
+			mdev->saved_dsp_lnkctl2 = lnkctl2;
+			mdev->saved_dsp_lnkctl2_valid = true;
+			pcie_capability_set_word(downstream_port, PCI_EXP_LNKCTL2,
+						 PCI_EXP_LNKCTL2_HASD);
+		}
+	}
+
+	mdev->autonomous_saved = mdev->saved_usp_lnkctl_valid ||
+				 mdev->saved_usp_lnkctl2_valid ||
+				 mdev->saved_dsp_lnkctl_valid ||
+				 mdev->saved_dsp_lnkctl2_valid;
+}
+
+static void pci_lmr_restore_autonomous(struct pci_margin_dev *mdev)
+{
+	struct pci_dev *downstream_port, *upstream_port;
+
+	if (!mdev->autonomous_saved)
+		return;
+
+	pci_lmr_get_ports(mdev, &downstream_port, &upstream_port);
+
+	/*
+	 * PCIe Base Specification Revision 7.0 sec 7.5.3.7 & Table 7-24:
+	 * 1. Upstream Component (downstream_port) restored FIRST.
+	 */
+	if (downstream_port && pci_is_pcie(downstream_port) &&
+	    !pci_dev_is_disconnected(downstream_port) &&
+	    downstream_port->current_state == PCI_D0) {
+		if (mdev->saved_dsp_lnkctl_valid)
+			pcie_capability_clear_and_set_word(
+				downstream_port, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_HAWD,
+				mdev->saved_dsp_lnkctl & PCI_EXP_LNKCTL_HAWD);
+		if (mdev->saved_dsp_lnkctl2_valid)
+			pcie_capability_clear_and_set_word(
+				downstream_port, PCI_EXP_LNKCTL2, PCI_EXP_LNKCTL2_HASD,
+				mdev->saved_dsp_lnkctl2 & PCI_EXP_LNKCTL2_HASD);
+	}
+
+	/*
+	 * 2. Downstream Component (upstream_port) restored SECOND.
+	 */
+	if (upstream_port && pci_is_pcie(upstream_port) &&
+	    !pci_dev_is_disconnected(upstream_port) &&
+	    upstream_port->current_state == PCI_D0) {
+		if (mdev->saved_usp_lnkctl_valid)
+			pcie_capability_clear_and_set_word(
+				upstream_port, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_HAWD,
+				mdev->saved_usp_lnkctl & PCI_EXP_LNKCTL_HAWD);
+		if (mdev->saved_usp_lnkctl2_valid)
+			pcie_capability_clear_and_set_word(
+				upstream_port, PCI_EXP_LNKCTL2, PCI_EXP_LNKCTL2_HASD,
+				mdev->saved_usp_lnkctl2 & PCI_EXP_LNKCTL2_HASD);
+	}
+
+	mdev->saved_dsp_lnkctl_valid = false;
+	mdev->saved_dsp_lnkctl2_valid = false;
+	mdev->saved_usp_lnkctl_valid = false;
+	mdev->saved_usp_lnkctl2_valid = false;
+	mdev->autonomous_saved = false;
+}
+
+static inline u8 pci_lmr_sts_payload(u16 sts)
+{
+	return FIELD_GET(PCI_LMR_LANE_STS_PAYLOAD, sts);
+}
+
+/*
+ * pci_lmr_get_active_lanes() - Determine the current number of active lanes
+ * based on Negotiated Link Width (NLW) in Link Status Register.
+ *
+ * Per PCIe Base Specification Revision 7.0 sec 8.4.4, only active lanes
+ * respond to margining commands. Inactive lanes do not assert Margining Ready,
+ * causing command timeouts.
+ *
+ * If the link is down (NLW == 0 or configuration read fails), returns 0 to
+ * prevent 150 ms per-lane timeout stalls on inactive/down hardware.
+ */
+static int pci_lmr_get_active_lanes(struct pci_margin_dev *mdev)
+{
+	struct pci_dev *dev = mdev->dev;
+	u16 lnksta;
+	int ret, nlw;
+
+	ret = pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
+	if (ret == PCIBIOS_SUCCESSFUL && !PCI_POSSIBLE_ERROR(lnksta)) {
+		nlw = FIELD_GET(PCI_EXP_LNKSTA_NLW, lnksta);
+		if (nlw > 0 && nlw <= mdev->num_lanes)
+			return nlw;
+	}
+	return 0;
+}
+
+/*
+ * pci_lmr_run_cmd() - Issue LMR command to Lane Control and wait for Status.
+ * Must be called with mdev->lock held.
+ */
+static int pci_lmr_run_cmd(struct pci_margin_dev *mdev, int lane, u8 rx, u8 type,
+			   u8 usage, u8 payload, u16 *status_val)
+{
+	struct pci_dev *dev;
+	u16 lmr, ctrl_offset, sts_offset;
+	u16 ctrl, sts;
+	unsigned long timeout;
+	int ret;
+
+	if (!mdev || lane < 0 || lane >= mdev->num_lanes || rx > LMR_MAX_RX_NUM)
+		return -EINVAL;
+
+	if (lane >= pci_lmr_get_active_lanes(mdev))
+		return -ENODEV;
+
+	dev = mdev->dev;
+	lmr = mdev->cap;
+	ctrl_offset = lmr + PCI_LMR_LANE_CTRL + LMR_LANE_REG_STRIDE * lane;
+	sts_offset = lmr + PCI_LMR_LANE_STS + LMR_LANE_REG_STRIDE * lane;
+
+	/*
+	 * Per PCIe Base Specification Revision 7.0 sec 4.2.18.2 & Table 4-77,
+	 * software must issue NO_CMD (0x7) with payload 0x9C targeting the
+	 * specific receiver (rx) to clear MTYPE in Lane Status before issuing
+	 * a subsequent command.
+	 */
+	if (type != LMR_TYPE_NO_CMD) {
+		ctrl = FIELD_PREP(PCI_LMR_LANE_CTRL_RX_NUM, rx) |
+		       FIELD_PREP(PCI_LMR_LANE_CTRL_MTYPE, LMR_TYPE_NO_CMD) |
+		       FIELD_PREP(PCI_LMR_LANE_CTRL_USAGE, 0) |
+		       FIELD_PREP(PCI_LMR_LANE_CTRL_PAYLOAD,
+				  LMR_PAYLOAD_NO_CMD);
+
+		ret = pci_write_config_word(dev, ctrl_offset, ctrl);
+		if (ret != PCIBIOS_SUCCESSFUL)
+			return pcibios_err_to_errno(ret);
+
+		timeout = jiffies + msecs_to_jiffies(LMR_CMD_TIMEOUT_MS);
+		while (1) {
+			ret = pci_read_config_word(dev, sts_offset, &sts);
+			if (ret != PCIBIOS_SUCCESSFUL)
+				return pcibios_err_to_errno(ret);
+			if (PCI_POSSIBLE_ERROR(sts))
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
+	ret = pci_write_config_word(dev, ctrl_offset, ctrl);
+	if (ret != PCIBIOS_SUCCESSFUL)
+		return pcibios_err_to_errno(ret);
+
+	timeout = jiffies + msecs_to_jiffies(LMR_CMD_TIMEOUT_MS);
+	while (1) {
+		ret = pci_read_config_word(dev, sts_offset, &sts);
+		if (ret != PCIBIOS_SUCCESSFUL)
+			return pcibios_err_to_errno(ret);
+		if (PCI_POSSIBLE_ERROR(sts))
+			return -ENODEV;
+
+		if (FIELD_GET(PCI_LMR_LANE_STS_MTYPE, sts) == type &&
+		    FIELD_GET(PCI_LMR_LANE_STS_RX_NUM, sts) == rx) {
+			if (status_val)
+				*status_val = sts;
+			return 0;
+		}
+
+		if (time_after(jiffies, timeout)) {
+			/*
+			 * Per PCIe Base Specification Revision 7.0 sec 4.2.18.2
+			 * & Table 4-77, if receiver echoes NO_CMD (0x7) after
+			 * command issuance, it indicates NAK.
+			 */
+			if (FIELD_GET(PCI_LMR_LANE_STS_MTYPE, sts) == LMR_TYPE_NO_CMD &&
+			    FIELD_GET(PCI_LMR_LANE_STS_RX_NUM, sts) == rx)
+				return -EOPNOTSUPP;
+			break;
+		}
+
+		usleep_range(LMR_CMD_SLEEP_MIN_US, LMR_CMD_SLEEP_MAX_US);
+	}
+
+	return -ETIMEDOUT;
+}
+
+/*
+ * pci_lmr_clear_to_normal_lane() - Clear lane margin back to normal settings
+ * per PCIe Base Specification Revision 7.0 sec 4.2.18.2 & Table 4-77.
+ * Issues Set Margining Parameters (MTYPE 010b) with "Go to Normal Settings"
+ * (Payload 0x0F).
+ */
+static int pci_lmr_clear_to_normal_lane(struct pci_margin_lane *plane)
+{
+	u16 sts;
+	int ret;
+
+	if (!plane || !plane->mdev)
+		return -EINVAL;
+
+	if (plane->lane >= pci_lmr_get_active_lanes(plane->mdev)) {
+		plane->timing_val = 0;
+		plane->voltage_val = 0;
+		return 0;
+	}
+
+	ret = pci_lmr_run_cmd(plane->mdev, plane->lane, plane->rx,
+			      LMR_TYPE_SET_PARAMS, 0, LMR_PAYLOAD_GO_TO_NORMAL,
+			      &sts);
+	plane->timing_val = 0;
+	plane->voltage_val = 0;
+	return ret;
+}
+
+static int pci_lmr_cache_rx_info(struct pci_margin_lane *plane, u8 rx)
+{
+	struct pci_margin_rx_info *info;
+	u16 sts;
+	int ret;
+
+	if (!plane || rx > LMR_MAX_RX_NUM)
+		return -EINVAL;
+
+	info = &plane->rx_info[rx];
+
+	if (info->caps_cached)
+		return 0;
+
+	/* Issuing REPORT_CAPS aborts active margin; clear to normal settings */
+	ret = pci_lmr_clear_to_normal_lane(plane);
+	if (ret)
+		return ret;
+
+	/* Report Capabilities: MTYPE 001b, Payload 0x88 */
+	ret = pci_lmr_run_cmd(plane->mdev, plane->lane, rx,
+			      LMR_TYPE_REPORT_CAPS, 0, LMR_PAYLOAD_REPORT_CAPS,
+			      &sts);
+	if (ret)
+		return ret;
+	info->caps = pci_lmr_sts_payload(sts);
+
+	/* Report Timing Steps: MTYPE 001b, Payload 0x8A */
+	ret = pci_lmr_run_cmd(plane->mdev, plane->lane, rx,
+			      LMR_TYPE_REPORT_CAPS, 0,
+			      LMR_PAYLOAD_REPORT_TIM_STEPS, &sts);
+	if (ret)
+		return ret;
+	info->num_timing_steps = FIELD_GET(LMR_TIMING_STEP_MASK, pci_lmr_sts_payload(sts));
+
+	/*
+	 * Report Voltage Steps: MTYPE 001b, Payload 0x89.
+	 * Only query if receiver supports voltage margining. Per PCIe Base
+	 * Specification Revision 7.0 Table 4-77, receivers lacking voltage
+	 * margining support (MVoltageSupported = 0b) will NAK this command.
+	 */
+	if (info->caps & LMR_CAP_VOLTAGE_SUPPORTED) {
+		ret = pci_lmr_run_cmd(plane->mdev, plane->lane, rx,
+				      LMR_TYPE_REPORT_CAPS, 0,
+				      LMR_PAYLOAD_REPORT_VOLT_STEPS, &sts);
+		if (ret)
+			return ret;
+		info->num_voltage_steps = FIELD_GET(LMR_VOLTAGE_STEP_MASK,
+						    pci_lmr_sts_payload(sts));
+	} else {
+		info->num_voltage_steps = 0;
+	}
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
+	int ret;
+
+	/*
+	 * Wake the hardware and hold the PM reference before accessing
+	 * registers
+	 */
+	ret = pm_runtime_resume_and_get(&dev->dev);
+	if (ret < 0)
+		return ret;
+
+	ret = pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_CAP, &cap);
+	pm_runtime_put_sync(&dev->dev);
+
+	if (ret != PCIBIOS_SUCCESSFUL)
+		return pcibios_err_to_errno(ret);
+
+	seq_printf(s, "Port Capabilities: %#06x\n", cap);
+	seq_printf(s, "  Uses SW Ready: %s\n",
+		   str_yes_no(cap & PCI_LMR_PORT_CAP_USES_SW_READY));
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(margin_caps);
+
+static int margin_port_status_show(struct seq_file *s, void *v)
+{
+	struct pci_margin_dev *mdev = s->private;
+	struct pci_dev *dev = mdev->dev;
+	u16 sts;
+	int ret;
+
+	/*
+	 * Wake the hardware and hold the PM reference before accessing
+	 * registers
+	 */
+	ret = pm_runtime_resume_and_get(&dev->dev);
+	if (ret < 0)
+		return ret;
+
+	ret = pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &sts);
+	pm_runtime_put_sync(&dev->dev);
+
+	if (ret != PCIBIOS_SUCCESSFUL)
+		return pcibios_err_to_errno(ret);
+
+	seq_printf(s, "Port Status: %#06x\n", sts);
+	seq_printf(s, "  Margining Ready: %s\n",
+		   str_yes_no(sts & PCI_LMR_PORT_STS_MARGIN_READY));
+	seq_printf(s, "  SW Ready: %s\n",
+		   str_yes_no(sts & PCI_LMR_PORT_STS_SW_READY));
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(margin_port_status);
+
+static int margin_enable_show(struct seq_file *s, void *v)
+{
+	struct pci_margin_dev *mdev = s->private;
+
+	guard(mutex)(&mdev->lock);
+	seq_printf(s, "%d\n", mdev->enabled);
+	return 0;
+}
+
+static void pci_lmr_disable_locked(struct pci_margin_dev *mdev)
+{
+	struct pci_dev *dev;
+	int active_lanes, i, ret;
+	u16 sts;
+
+	if (!mdev)
+		return;
+
+	lockdep_assert_held(&mdev->lock);
+
+	if (!mdev->enabled)
+		return;
+
+	dev = mdev->dev;
+	active_lanes = pci_lmr_get_active_lanes(mdev);
+
+	for (i = 0; i < active_lanes; i++)
+		pci_lmr_clear_to_normal_lane(&mdev->lanes[i]);
+
+	for (i = active_lanes; i < mdev->num_lanes; i++) {
+		mdev->lanes[i].timing_val = 0;
+		mdev->lanes[i].voltage_val = 0;
+	}
+
+	ret = pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &sts);
+	if (ret == PCIBIOS_SUCCESSFUL) {
+		sts &= ~PCI_LMR_PORT_STS_SW_READY;
+		pci_write_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, sts);
+	}
+
+	if (mdev->aspm_inhibited) {
+		pci_aspm_inhibit_locked(dev, false);
+		mdev->aspm_inhibited = false;
+	}
+
+	pci_lmr_restore_autonomous(mdev);
+
+	if (mdev->partner) {
+		pm_runtime_put_sync(&mdev->partner->dev);
+		pci_dev_put(mdev->partner);
+		mdev->partner = NULL;
+	}
+
+	pm_runtime_put_sync(&dev->dev);
+	mdev->enabled = false;
+}
+
+static int pci_lmr_enable_locked(struct pci_margin_dev *mdev,
+				 struct pci_dev *downstream_port,
+				 struct pci_dev *upstream_port)
+{
+	struct pci_dev *dev = mdev->dev;
+	struct pci_dev *partner = NULL;
+	unsigned long timeout;
+	u16 sts, cap, lnksta;
+	int active_lanes, ret, i;
+
+	lockdep_assert_held(&mdev->lock);
+
+	/*
+	 * Ensure device is powered (D0) before reading configuration
+	 * registers
+	 */
+	ret = pm_runtime_resume_and_get(&dev->dev);
+	if (ret < 0)
+		return ret;
+
+	partner = (dev == downstream_port) ? upstream_port : downstream_port;
+
+	/* Prevent concurrent LMR on both ends of the same link */
+	if (partner && partner->lmr && partner->lmr->enabled) {
+		ret = -EBUSY;
+		goto err_rpm;
+	}
+
+	if (partner) {
+		ret = pm_runtime_resume_and_get(&partner->dev);
+		if (ret < 0)
+			goto err_rpm;
+		mdev->partner = pci_dev_get(partner);
+	}
+
+	/*
+	 * PCIe Base Specification Revision 7.0 sec 8.4.4: LMR is physically
+	 * undefined below 16.0 GT/s. Even if a device supports Gen4+, if the
+	 * link is currently trained and operating at Gen1..Gen3 speeds
+	 * (< 16.0 GT/s) in Link Status Register (sec 7.5.3.8, Current Link
+	 * Speed), reject margining.
+	 */
+	ret = pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
+	if (ret) {
+		ret = pcibios_err_to_errno(ret);
+		goto err_partner_rpm;
+	}
+	if (PCI_POSSIBLE_ERROR(lnksta) ||
+	    (lnksta & PCI_EXP_LNKSTA_CLS) < PCI_EXP_LNKSTA_CLS_16_0GB) {
+		ret = -EOPNOTSUPP;
+		goto err_partner_rpm;
+	}
+
+	active_lanes = FIELD_GET(PCI_EXP_LNKSTA_NLW, lnksta);
+	if (active_lanes == 0 || active_lanes > mdev->num_lanes)
+		active_lanes = mdev->num_lanes;
+
+	ret = pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_CAP, &cap);
+	if (ret != PCIBIOS_SUCCESSFUL) {
+		ret = pcibios_err_to_errno(ret);
+		goto err_partner_rpm;
+	}
+
+	/* Disable Autonomous Width and Speed transitions */
+	pci_lmr_disable_autonomous(mdev);
+
+	/*
+	 * Inhibit ASPM during margining via the ASPM driver API so the link
+	 * remains continuously in L0. pci_bus_sem is held by caller.
+	 */
+	ret = pci_aspm_inhibit_locked(dev, true);
+	if (ret && ret != -EPERM)
+		goto err_autonomous;
+	if (!ret)
+		mdev->aspm_inhibited = true;
+
+	if (cap & PCI_LMR_PORT_CAP_USES_SW_READY) {
+		ret = pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &sts);
+		if (ret != PCIBIOS_SUCCESSFUL) {
+			ret = pcibios_err_to_errno(ret);
+			goto err_aspm;
+		}
+		sts |= PCI_LMR_PORT_STS_SW_READY;
+		pci_write_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, sts);
+	}
+
+	timeout = jiffies + msecs_to_jiffies(LMR_ENABLE_TIMEOUT_MS);
+	while (1) {
+		ret = pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &sts);
+		if (ret != PCIBIOS_SUCCESSFUL) {
+			ret = pcibios_err_to_errno(ret);
+			goto err_sw_ready;
+		}
+		if (PCI_POSSIBLE_ERROR(sts)) {
+			ret = -ENODEV;
+			goto err_sw_ready;
+		}
+		if (sts & PCI_LMR_PORT_STS_MARGIN_READY)
+			break;
+		if (time_after(jiffies, timeout)) {
+			ret = -ETIMEDOUT;
+			goto err_sw_ready;
+		}
+		usleep_range(LMR_ENABLE_SLEEP_MIN_US, LMR_ENABLE_SLEEP_MAX_US);
+	}
+
+	/* Cache capabilities for configured receiver on all active lanes */
+	for (i = 0; i < active_lanes; i++) {
+		ret = pci_lmr_cache_rx_info(&mdev->lanes[i], mdev->lanes[i].rx);
+		if (ret)
+			goto err_sw_ready;
+	}
+	mdev->enabled = true;
+	return 0;
+
+err_sw_ready:
+	if (cap & PCI_LMR_PORT_CAP_USES_SW_READY) {
+		u16 clean_sts;
+		int clean_ret;
+
+		clean_ret = pci_read_config_word(
+			dev, mdev->cap + PCI_LMR_PORT_STS, &clean_sts);
+		if (clean_ret == PCIBIOS_SUCCESSFUL) {
+			clean_sts &= ~PCI_LMR_PORT_STS_SW_READY;
+			pci_write_config_word(dev, mdev->cap + PCI_LMR_PORT_STS,
+					      clean_sts);
+		}
+	}
+err_aspm:
+	if (mdev->aspm_inhibited) {
+		pci_aspm_inhibit_locked(dev, false);
+		mdev->aspm_inhibited = false;
+	}
+err_autonomous:
+	pci_lmr_restore_autonomous(mdev);
+err_partner_rpm:
+	if (mdev->partner) {
+		pm_runtime_put_sync(&mdev->partner->dev);
+		pci_dev_put(mdev->partner);
+		mdev->partner = NULL;
+	}
+err_rpm:
+	pm_runtime_put_sync(&dev->dev);
+	return ret;
+}
+
+static ssize_t margin_enable_write(struct file *file,
+				   const char __user *user_buf, size_t count,
+				   loff_t *ppos)
+{
+	struct seq_file *s = file->private_data;
+	struct pci_margin_dev *mdev = s->private;
+	struct pci_dev *dev = mdev->dev;
+	struct pci_dev *downstream_port = NULL, *upstream_port = NULL;
+	bool enable;
+	int ret;
+
+	ret = kstrtobool_from_user(user_buf, count, &enable);
+	if (ret)
+		return ret;
+
+	if (enable) {
+		ret = pcie_get_link_endpoints(dev, &downstream_port, &upstream_port);
+		if (ret)
+			return ret;
+	} else {
+		struct pci_dev *partner;
+
+		/*
+		 * When disabling LMR, always operate on the link partner that
+		 * was saved when LMR was enabled (mdev->partner). If a hot-swap
+		 * occurred while LMR was active, pcie_get_link_endpoints()
+		 * would resolve to the newly connected device, causing
+		 * pci_lmr_disable_locked() to restore registers on the old
+		 * partner without holding its device_lock.
+		 */
+		mutex_lock(&mdev->lock);
+		if (!mdev->enabled) {
+			mutex_unlock(&mdev->lock);
+			return count;
+		}
+		partner = mdev->partner;
+		if (partner)
+			pci_dev_get(partner);
+		mutex_unlock(&mdev->lock);
+
+		if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
+		    pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM) {
+			downstream_port = pci_dev_get(dev);
+			upstream_port = partner;
+		} else {
+			downstream_port = partner;
+			upstream_port = pci_dev_get(dev);
+		}
+	}
+
+	/*
+	 * Canonical PCI locking hierarchy:
+	 *   pci_bus_sem -> Downstream Port (parent) -> Upstream Port (child) -> mdev->lock.
+	 * Holding pci_bus_sem allows pci_aspm_inhibit_locked() to safely execute
+	 * without lock inversion deadlocks.
+	 */
+	down_read(&pci_bus_sem);
+	if (downstream_port)
+		pci_dev_lock(downstream_port);
+	if (upstream_port && upstream_port != downstream_port)
+		pci_dev_lock(upstream_port);
+
+	mutex_lock(&mdev->lock);
+
+	if (mdev->enabled == enable) {
+		ret = count;
+	} else if (!enable) {
+		pci_lmr_disable_locked(mdev);
+		ret = count;
+	} else {
+		ret = pci_lmr_enable_locked(mdev, downstream_port, upstream_port);
+		if (!ret)
+			ret = count;
+	}
+
+	mutex_unlock(&mdev->lock);
+
+	if (upstream_port && upstream_port != downstream_port)
+		pci_dev_unlock(upstream_port);
+	if (downstream_port)
+		pci_dev_unlock(downstream_port);
+	up_read(&pci_bus_sem);
+
+	pcie_put_link_endpoints(downstream_port, upstream_port);
+
+	return ret;
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
+	guard(mutex)(&plane->mdev->lock);
+	seq_printf(s, "%d\n", plane->rx);
+	return 0;
+}
+
+static ssize_t margin_lane_receiver_write(struct file *file, const char __user *user_buf,
+					  size_t count, loff_t *ppos)
+{
+	struct seq_file *s = file->private_data;
+	struct pci_margin_lane *plane = s->private;
+	struct pci_margin_dev *mdev = plane->mdev;
+	int ret;
+	u8 rx;
+
+	ret = kstrtou8_from_user(user_buf, count, 0, &rx);
+	if (ret)
+		return ret;
+
+	/*
+	 * Valid receiver numbers are 0..6 per PCIe Base Specification
+	 * Revision 7.0 sec 4.2.18.1 & Table 4-76; 7 is reserved.
+	 */
+	if (rx > LMR_MAX_RX_NUM)
+		return -EINVAL;
+
+	guard(mutex)(&mdev->lock);
+	if (plane->rx == rx)
+		return count;
+
+	if (mdev->enabled) {
+		/*
+		 * Clear previous receiver to normal settings per
+		 * single-receiver rule
+		 */
+		ret = pci_lmr_clear_to_normal_lane(plane);
+		if (ret)
+			return ret;
+		ret = pci_lmr_cache_rx_info(plane, rx);
+		if (ret)
+			return ret;
+	}
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
+	struct pci_margin_rx_info *info;
+	int ret;
+	u8 val;
+
+	guard(mutex)(&mdev->lock);
+	if (!mdev->enabled)
+		return -EBUSY;
+
+	ret = pci_lmr_cache_rx_info(plane, plane->rx);
+	if (ret)
+		return ret;
+
+	info = &plane->rx_info[plane->rx];
+	val = info->caps;
+	seq_printf(s, "Lane %d Rx %d Capabilities: %#02x\n", plane->lane, plane->rx, val);
+	seq_printf(s, "  Voltage Supported: %s\n",
+		   str_yes_no(val & LMR_CAP_VOLTAGE_SUPPORTED));
+	seq_printf(s, "  Left/Right: %s\n",
+		   (val & LMR_CAP_IND_LEFT_RIGHT_TIMING) ? "independent" : "symmetric");
+	seq_printf(s, "  Up/Down: %s\n",
+		   (val & LMR_CAP_IND_UP_DOWN_VOLTAGE) ? "independent" : "symmetric");
+	seq_printf(s, "  Error Sampler: %s\n",
+		   (val & LMR_CAP_IND_ERROR_SAMPLER) ? "independent" :
+						       "main sampler");
+	seq_printf(s, "  Sample Reporting: %s\n",
+		   (val & LMR_CAP_SAMPLE_REPORT_METHOD) ? "rate" : "count");
+	seq_printf(s, "  Sample Multiple Receivers: %s\n",
+		   str_yes_no(val & LMR_CAP_SAMPLE_MULTIPLE_RECEIVERS));
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(margin_lane_caps);
+
+static int margin_lane_steps_show(struct seq_file *s, u8 type)
+{
+	struct pci_margin_lane *plane = s->private;
+	struct pci_margin_dev *mdev = plane->mdev;
+	struct pci_margin_rx_info *info;
+	int ret;
+
+	guard(mutex)(&mdev->lock);
+	if (!mdev->enabled)
+		return -EBUSY;
+
+	ret = pci_lmr_cache_rx_info(plane, plane->rx);
+	if (ret)
+		return ret;
+
+	info = &plane->rx_info[plane->rx];
+	seq_printf(s, "%d\n", (type == LMR_TYPE_VOLTAGE) ?
+		   info->num_voltage_steps : info->num_timing_steps);
+	return 0;
+}
+
+static int margin_lane_timing_steps_show(struct seq_file *s, void *v)
+{
+	return margin_lane_steps_show(s, LMR_TYPE_TIMING);
+}
+DEFINE_SHOW_ATTRIBUTE(margin_lane_timing_steps);
+
+static int margin_lane_voltage_steps_show(struct seq_file *s, void *v)
+{
+	return margin_lane_steps_show(s, LMR_TYPE_VOLTAGE);
+}
+DEFINE_SHOW_ATTRIBUTE(margin_lane_voltage_steps);
+
+/*
+ * pci_lmr_check_sample_multiple_rx() - Check multi-receiver concurrency.
+ * Per PCIe Base Specification Revision 7.0 sec 4.2.18.2 & sec 8.4.4:
+ * "For Receivers where MIndErrorSampler is 0b, at most one such Receiver is
+ * permitted to be margined at a time. However, margining may be performed on
+ * multiple Lanes simultaneously, as long as it is within the maximum number of
+ * Lanes the device supports."
+ *
+ * If the target receiver uses an independent error sampler (MIndErrorSampler
+ * == 1b), margining will not produce errors in the live data stream, and
+ * multiple receivers may be margined concurrently. If MIndErrorSampler is 0b
+ * (main data sampler), software must ensure that no other receiver on any lane
+ * is currently margined.
+ */
+static bool pci_lmr_check_sample_multiple_rx(struct pci_margin_dev *mdev,
+					     struct pci_margin_lane *plane)
+{
+	struct pci_margin_rx_info *info = &plane->rx_info[plane->rx];
+	int i;
+
+	/*
+	 * If receiver has an independent error sampler or supports sampling
+	 * multiple receivers concurrently, concurrent margining is permitted.
+	 */
+	if ((info->caps & LMR_CAP_IND_ERROR_SAMPLER) ||
+	    (info->caps & LMR_CAP_SAMPLE_MULTIPLE_RECEIVERS))
+		return true;
+
+	for (i = 0; i < mdev->num_lanes; i++) {
+		struct pci_margin_lane *other = &mdev->lanes[i];
+		struct pci_margin_rx_info *other_info;
+
+		if (i == plane->lane)
+			continue;
+
+		other_info = &other->rx_info[other->rx];
+		/*
+		 * For receivers using the main data sampler without multiple
+		 * receiver sampling capability, reject only if another lane is
+		 * actively margining a DIFFERENT receiver that ALSO does not
+		 * support concurrent multi-receiver sampling.
+		 */
+		if (other->rx != plane->rx &&
+		    !(other_info->caps & (LMR_CAP_IND_ERROR_SAMPLER |
+					  LMR_CAP_SAMPLE_MULTIPLE_RECEIVERS)) &&
+		    (other->timing_val != 0 || other->voltage_val != 0))
+			return false;
+	}
+	return true;
+}
+
+static ssize_t margin_lane_step_write(struct file *file, const char __user *user_buf,
+				      size_t count, u8 type)
+{
+	struct seq_file *s = file->private_data;
+	struct pci_margin_lane *plane = s->private;
+	struct pci_margin_dev *mdev = plane->mdev;
+	struct pci_margin_rx_info *info;
+	u8 step, dir, payload;
+	int max_step, val, ret;
+	u16 sts;
+	u8 caps;
+
+	ret = kstrtoint_from_user(user_buf, count, 0, &val);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&mdev->lock);
+	if (!mdev->enabled)
+		return -EBUSY;
+
+	/*
+	 * Reject step operations if the target lane exceeds the currently
+	 * negotiated/active link width (e.g. down-trained link).
+	 */
+	ret = pcie_capability_read_word(mdev->dev, PCI_EXP_LNKSTA, &sts);
+	if (ret == PCIBIOS_SUCCESSFUL) {
+		u16 nlw = FIELD_GET(PCI_EXP_LNKSTA_NLW, sts);
+
+		if (nlw > 0 && plane->lane >= nlw)
+			return -ENODEV;
+	}
+
+	if (val == 0) {
+		/*
+		 * Step this specific axis to 0 without resetting the orthogonal
+		 * axis
+		 */
+		if (type == LMR_TYPE_TIMING) {
+			if (plane->voltage_val == 0) {
+				ret = pci_lmr_clear_to_normal_lane(plane);
+			} else {
+				ret = pci_lmr_run_cmd(mdev, plane->lane, plane->rx,
+						      LMR_TYPE_TIMING, 0, 0, &sts);
+				if (!ret)
+					plane->timing_val = 0;
+			}
+		} else {
+			if (plane->timing_val == 0) {
+				ret = pci_lmr_clear_to_normal_lane(plane);
+			} else {
+				ret = pci_lmr_run_cmd(mdev, plane->lane, plane->rx,
+						      LMR_TYPE_VOLTAGE, 0, 0, &sts);
+				if (!ret)
+					plane->voltage_val = 0;
+			}
+		}
+		return ret ? ret : count;
+	}
+
+	ret = pci_lmr_cache_rx_info(plane, plane->rx);
+	if (ret)
+		return ret;
+
+	if (!pci_lmr_check_sample_multiple_rx(mdev, plane))
+		return -EBUSY;
+
+	info = &plane->rx_info[plane->rx];
+	caps = info->caps;
+
+	switch (type) {
+	case LMR_TYPE_TIMING:
+		if (val < -LMR_MAX_TIMING_STEP || val > LMR_MAX_TIMING_STEP)
+			return -EINVAL;
+		if (val < 0) {
+			if (!(caps & LMR_CAP_IND_LEFT_RIGHT_TIMING))
+				return -EINVAL;
+			step = -val;
+			dir = LMR_STEP_DIR_LEFT_OR_DOWN;
+		} else {
+			step = val;
+			dir = LMR_STEP_DIR_RIGHT_OR_UP;
+		}
+		max_step = info->num_timing_steps;
+		if (step > max_step)
+			return -EINVAL;
+
+		payload = FIELD_PREP(LMR_TIMING_DIR_MASK, dir) |
+			  FIELD_PREP(LMR_TIMING_STEP_MASK, step);
+		ret = pci_lmr_run_cmd(mdev, plane->lane, plane->rx,
+				      LMR_TYPE_TIMING, 0, payload, &sts);
+		if (ret)
+			return ret;
+		if (FIELD_GET(LMR_STS_EXEC_MASK, pci_lmr_sts_payload(sts)) ==
+		    LMR_STS_EXEC_NAK)
+			return -EOPNOTSUPP;
+		if (FIELD_GET(LMR_STS_EXEC_MASK, pci_lmr_sts_payload(sts)) ==
+		    LMR_STS_EXEC_TOO_MANY_ERR) {
+			plane->timing_val = 0;
+			plane->voltage_val = 0;
+			return -EIO;
+		}
+		plane->timing_val = val;
+		break;
+
+	case LMR_TYPE_VOLTAGE:
+		if (!(caps & LMR_CAP_VOLTAGE_SUPPORTED))
+			return -EOPNOTSUPP;
+		if (val < -LMR_MAX_VOLTAGE_STEP || val > LMR_MAX_VOLTAGE_STEP)
+			return -EINVAL;
+		if (val < 0) {
+			if (!(caps & LMR_CAP_IND_UP_DOWN_VOLTAGE))
+				return -EINVAL;
+			step = -val;
+			dir = LMR_STEP_DIR_LEFT_OR_DOWN;
+		} else {
+			step = val;
+			dir = LMR_STEP_DIR_RIGHT_OR_UP;
+		}
+		max_step = info->num_voltage_steps;
+		if (step > max_step)
+			return -EINVAL;
+
+		payload = FIELD_PREP(LMR_VOLTAGE_DIR_MASK, dir) |
+			  FIELD_PREP(LMR_VOLTAGE_STEP_MASK, step);
+		ret = pci_lmr_run_cmd(mdev, plane->lane, plane->rx,
+				      LMR_TYPE_VOLTAGE, 0, payload, &sts);
+		if (ret)
+			return ret;
+		if (FIELD_GET(LMR_STS_EXEC_MASK, pci_lmr_sts_payload(sts)) ==
+		    LMR_STS_EXEC_NAK)
+			return -EOPNOTSUPP;
+		if (FIELD_GET(LMR_STS_EXEC_MASK, pci_lmr_sts_payload(sts)) ==
+		    LMR_STS_EXEC_TOO_MANY_ERR) {
+			plane->timing_val = 0;
+			plane->voltage_val = 0;
+			return -EIO;
+		}
+		plane->voltage_val = val;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static ssize_t margin_lane_timing_write(struct file *file, const char __user *user_buf,
+					size_t count, loff_t *ppos)
+{
+	return margin_lane_step_write(file, user_buf, count, LMR_TYPE_TIMING);
+}
+
+static int margin_lane_step_show(struct seq_file *s, u8 type)
+{
+	struct pci_margin_lane *plane = s->private;
+
+	guard(mutex)(&plane->mdev->lock);
+	seq_printf(s, "%d\n", (type == LMR_TYPE_VOLTAGE) ?
+		   plane->voltage_val : plane->timing_val);
+	return 0;
+}
+
+static int margin_lane_timing_show(struct seq_file *s, void *v)
+{
+	return margin_lane_step_show(s, LMR_TYPE_TIMING);
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
+					 size_t count, loff_t *ppos)
+{
+	return margin_lane_step_write(file, user_buf, count, LMR_TYPE_VOLTAGE);
+}
+
+static int margin_lane_voltage_show(struct seq_file *s, void *v)
+{
+	return margin_lane_step_show(s, LMR_TYPE_VOLTAGE);
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
+	scnprintf(dirname, sizeof(dirname), "pcie_lmr_%s", dev_name(&dev->dev));
+	mdev->debugfs = debugfs_create_dir(dirname, parent);
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
+		scnprintf(lane_name, sizeof(lane_name), "lane%d", i);
+		lane_dir = debugfs_create_dir(lane_name, mdev->debugfs);
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
+	u32 lnkcap;
+	u16 lmr;
+	int num_lanes, ret, i;
+
+	if (WARN_ON_ONCE(!dev) || !pci_is_pcie(dev))
+		return;
+
+	/*
+	 * Per PCIe Base Specification Revision 7.0 sec 7.7.11:
+	 * For devices associated with an Upstream Port (Endpoints,
+	 * Legacy Endpoints, and Switch Upstream Ports), the Lane Margining
+	 * Extended Capability must be implemented in Function 0 (and only
+	 * Function 0).
+	 */
+	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ENDPOINT ||
+	     pci_pcie_type(dev) == PCI_EXP_TYPE_LEG_END ||
+	     pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM) &&
+	    PCI_FUNC(dev->devfn) != 0)
+		return;
+
+	speed = pcie_get_speed_cap(dev);
+	if (speed < PCIE_SPEED_16_0GT || speed == PCI_SPEED_UNKNOWN)
+		return;
+
+	lmr = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_LMR);
+	if (!lmr) {
+		if (speed >= PCIE_SPEED_64_0GT)
+			pci_warn(dev,
+				 "Missing Lane Margining at Receiver Capability (mandatory for Gen6+)\n");
+		else
+			pci_dbg(dev,
+				"Optional Lane Margining at Receiver Capability not found\n");
+		return;
+	}
+
+	/*
+	 * Determine link width: read Maximum Link Width (MLW) from Link
+	 * Capabilities. Sizing data structures and debugfs interfaces to MLW
+	 * ensures all lanes can be margined if the link up-trains dynamically.
+	 * Dynamic Negotiated Link Width (NLW) is queried at runtime via
+	 * pci_lmr_get_active_lanes().
+	 */
+	ret = pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
+	if (ret != PCIBIOS_SUCCESSFUL)
+		return;
+	num_lanes = FIELD_GET(PCI_EXP_LNKCAP_MLW, lnkcap);
+	if (num_lanes == 0 || num_lanes > LMR_MAX_LANES) {
+		pci_warn(dev, "Invalid link width %d for LMR\n", num_lanes);
+		return;
+	}
+
+	dev->lmr_cap = lmr;
+
+	mdev = kzalloc(struct_size(mdev, lanes, num_lanes), GFP_KERNEL);
+	if (!mdev)
+		return;
+
+	mdev->num_lanes = num_lanes;
+	mdev->dev = dev;
+	mdev->cap = lmr;
+	mutex_init(&mdev->lock);
+
+	for (i = 0; i < num_lanes; i++) {
+		mdev->lanes[i].mdev = mdev;
+		mdev->lanes[i].lane = i;
+		mdev->lanes[i].rx = LMR_RX_LOCAL;
+	}
+
+	dev->lmr = mdev;
+	pci_margin_debugfs_init(mdev);
+
+	pci_dbg(dev, "Lane Margining at Receiver (Gen%u) Capability detected\n",
+		LMR_SPEED_TO_GEN(speed));
+}
+
+void pci_lmr_exit(struct pci_dev *dev)
+{
+	struct pci_margin_dev *mdev;
+	struct pci_dev *partner;
+	struct pci_dev *downstream_port, *upstream_port;
+
+	if (!dev || !dev->lmr)
+		return;
+
+	mdev = dev->lmr;
+
+	/*
+	 * 1. Tear down user-facing debugfs files FIRST to prevent concurrent
+	 *    access. debugfs_remove_recursive() flushes active file operations.
+	 */
+	pci_margin_debugfs_remove(mdev);
+
+	/*
+	 * 2. Acquire locks in canonical PCI hierarchy:
+	 *    pci_bus_sem -> Downstream Port (parent) -> Upstream Port (child) -> mdev->lock.
+	 *
+	 * Both ends of the link must hold their device_lock during teardown
+	 * because pci_lmr_disable_locked() restores autonomous width and speed
+	 * registers on both ports.
+	 */
+	mutex_lock(&mdev->lock);
+	partner = mdev->partner;
+	if (partner)
+		pci_dev_get(partner);
+	mutex_unlock(&mdev->lock);
+
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
+	    pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM) {
+		downstream_port = dev;
+		upstream_port = partner;
+	} else {
+		downstream_port = partner;
+		upstream_port = dev;
+	}
+
+	down_read(&pci_bus_sem);
+	if (downstream_port)
+		pci_dev_lock(downstream_port);
+	if (upstream_port && upstream_port != downstream_port)
+		pci_dev_lock(upstream_port);
+
+	mutex_lock(&mdev->lock);
+	dev->lmr = NULL;
+	if (mdev->enabled)
+		pci_lmr_disable_locked(mdev);
+	mutex_unlock(&mdev->lock);
+
+	if (upstream_port && upstream_port != downstream_port)
+		pci_dev_unlock(upstream_port);
+	if (downstream_port)
+		pci_dev_unlock(downstream_port);
+	up_read(&pci_bus_sem);
+
+	pci_dev_put(partner);
+
+	/* 3. Safe to destroy structures */
+	mutex_destroy(&mdev->lock);
+	kfree(mdev);
+}
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 27008e2ea5af..98c84fdb0a97 100644
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
index e711ac1d4e38..f78f0c654011 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -37,12 +37,12 @@ static void pci_destroy_dev(struct pci_dev *dev)
 	platform_pci_remove_wake(dev);
 	pci_doe_sysfs_teardown(dev);
 	pci_npem_remove(dev);
-
 	/*
 	 * While device is in D0 drop the device from TSM link operations
 	 * including unbind and disconnect (IDE + SPDM teardown).
 	 */
 	pci_tsm_destroy(dev);
+	pci_lmr_exit(dev);
 
 	device_del(&dev->dev);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b0ce8ee8d622..fbb85ad124b5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -353,6 +353,8 @@ struct rcec_ea;
  *			number resources to allow for hierarchy expansion.
  * @is_pciehp:		PCIe Hot-Plug Capable bridge.
  */
+struct pci_margin_dev;
+
 struct pci_dev {
 	struct list_head bus_list;	/* Node in per-bus list */
 	struct pci_bus	*bus;		/* Bus this device is on */
@@ -532,6 +534,10 @@ struct pci_dev {
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
index 2d960626750e..f762540b500e 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -93,6 +93,7 @@ TARGETS += net/tcp_ao
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
index 000000000000..9ea292f0009d
--- /dev/null
+++ b/tools/testing/selftests/pcie_lmt/pcie_lmt.sh
@@ -0,0 +1,287 @@
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
+TESTNAME="pcie_lmt"
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+retval=0
+skipmsg="skip all tests:"
+
+# Rejection test: must be run as root
+if [ "$UID" -ne 0 ]; then
+	echo "$skipmsg must be run as root" >&2
+	exit $ksft_skip
+fi
+
+SCRIPT_PATH=$(realpath "$0" 2>/dev/null || echo "$0")
+
+# Test non-root user execution rejection via subshell if unprivileged user exists
+test_non_root_rejection()
+{
+	local non_root_cmd=""
+	local exit_code=0
+
+	if command -v runuser >/dev/null 2>&1 && id nobody >/dev/null 2>&1; then
+		non_root_cmd="runuser -u nobody --"
+	elif command -v su >/dev/null 2>&1 && id nobody >/dev/null 2>&1; then
+		non_root_cmd="su -s /bin/bash nobody -c"
+	fi
+
+	if [ -n "$non_root_cmd" ]; then
+		$non_root_cmd "$SCRIPT_PATH" >/dev/null 2>&1 || exit_code=$?
+		if [ "$exit_code" -eq "$ksft_skip" ]; then
+			echo "$TESTNAME: non-root user execution rejection test [PASS]"
+		else
+			echo "$TESTNAME: non-root run got $exit_code (exp $ksft_skip) [FAIL]" >&2
+			retval=1
+		fi
+	else
+		echo "$TESTNAME: skipping non-root subshell test (no unprivileged user/su)"
+	fi
+}
+
+test_non_root_rejection
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
+assert_write_fail()
+{
+	local file="$1"
+	local val="$2"
+	local desc="$3"
+	local fname
+
+	fname=$(basename "$file")
+	if (echo "$val" > "$file") 2>/dev/null; then
+		echo "    FAIL: $desc ('$val' -> $fname succeeded, expected fail)" >&2
+		retval=1
+	else
+		echo "    PASS: $desc rejected correctly"
+	fi
+}
+
+assert_write_success()
+{
+	local file="$1"
+	local val="$2"
+	local desc="$3"
+	local fname
+
+	fname=$(basename "$file")
+	if ! (echo "$val" > "$file") 2>/dev/null; then
+		echo "    FAIL: $desc ('$val' -> $fname failed, expected success)" >&2
+		retval=1
+	else
+		echo "    PASS: $desc succeeded correctly"
+	fi
+}
+
+assert_read_fail()
+{
+	local file="$1"
+	local desc="$2"
+
+	if cat "$file" >/dev/null 2>&1; then
+		echo "    FAIL: $desc (reading $(basename "$file") succeeded, expected failure)" >&2
+		retval=1
+	else
+		echo "    PASS: $desc rejected correctly"
+	fi
+}
+
+assert_read_success()
+{
+	local file="$1"
+	local desc="$2"
+
+	if ! cat "$file" >/dev/null 2>&1; then
+		echo "    FAIL: $desc (reading $(basename "$file") failed, expected success)" >&2
+		retval=1
+	else
+		echo "    PASS: $desc succeeded correctly"
+	fi
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
+		echo "$TESTNAME: $dev_name missing mandatory root attributes" >&2
+		retval=1
+		continue
+	fi
+
+	assert_read_success "$dev/capabilities" "$dev_name: capabilities read"
+	assert_read_success "$dev/port_status" "$dev_name: port_status read"
+
+	# Negative test: write to read-only root files
+	echo "  $dev_name: testing read-only root attributes"
+	assert_write_fail "$dev/capabilities" "0" "write to read-only capabilities"
+	assert_write_fail "$dev/port_status" "0" "write to read-only port_status"
+
+	# Negative test: operations while margining is disabled
+	echo "  $dev_name: testing operations while disabled"
+	for lane_dir in $(ls -d "$dev"/lane* 2>/dev/null || true); do
+		lane=$(basename "$lane_dir")
+		assert_write_fail "$lane_dir/margin_timing" "1" \
+			"$lane: timing step while disabled"
+		assert_write_fail "$lane_dir/margin_voltage" "1" \
+			"$lane: voltage step while disabled"
+		assert_read_fail "$lane_dir/caps" \
+			"$lane: read caps while disabled"
+		assert_read_fail "$lane_dir/num_timing_steps" \
+			"$lane: read timing steps while disabled"
+		assert_read_fail "$lane_dir/num_voltage_steps" \
+			"$lane: read voltage steps while disabled"
+		break
+	done
+
+	# Negative test: invalid enable inputs
+	echo "  $dev_name: testing invalid enable inputs"
+	assert_write_fail "$dev/enable" "invalid" "enable invalid string"
+	assert_write_fail "$dev/enable" "2" "enable invalid numeric '2'"
+	assert_write_fail "$dev/enable" "-1" "enable negative numeric '-1'"
+	assert_write_fail "$dev/enable" "999" "enable out-of-bounds '999'"
+	assert_write_fail "$dev/enable" "" "enable empty string"
+
+	trap 'cleanup_dev "$dev"' EXIT INT TERM
+
+	if ! echo 1 > "$dev/enable" 2>/dev/null; then
+		echo "  $dev_name: margining not ready by hardware (skipping active lanes)"
+		trap - EXIT INT TERM
+		continue
+	fi
+
+	echo "  $dev_name: margining enabled OK"
+
+	for lane_dir in $(ls -d "$dev"/lane* 2>/dev/null || true); do
+		lane=$(basename "$lane_dir")
+		echo "  $dev_name: testing $lane (active)"
+
+		# Negative test: write to read-only lane attributes
+		assert_write_fail "$lane_dir/caps" "0" \
+			"$lane: write to read-only caps"
+		assert_write_fail "$lane_dir/num_timing_steps" "0" \
+			"$lane: write to read-only num_timing_steps"
+		assert_write_fail "$lane_dir/num_voltage_steps" "0" \
+			"$lane: write to read-only num_voltage_steps"
+
+		# Negative test: invalid receiver numbers (valid: 0..6, 7 reserved)
+		assert_write_fail "$lane_dir/receiver" "7" "$lane: receiver 7 (reserved)"
+		assert_write_fail "$lane_dir/receiver" "8" "$lane: receiver 8 (> 6)"
+		assert_write_fail "$lane_dir/receiver" "255" "$lane: receiver 255"
+		assert_write_fail "$lane_dir/receiver" "-1" "$lane: negative receiver -1"
+		assert_write_fail "$lane_dir/receiver" "invalid" "$lane: non-numeric receiver"
+
+		# Set valid receiver 0 (local receiver)
+		assert_write_success "$lane_dir/receiver" "0" "$lane: set receiver 0 (local)"
+
+		# Read capabilities and step limits
+		assert_read_success "$lane_dir/caps" "$lane: read caps"
+		assert_read_success "$lane_dir/num_timing_steps" "$lane: read num_timing_steps"
+		assert_read_success "$lane_dir/num_voltage_steps" "$lane: read num_voltage_steps"
+
+		caps_raw=$(cat "$lane_dir/caps" 2>/dev/null || true)
+		num_timing=$(cat "$lane_dir/num_timing_steps" 2>/dev/null || echo 0)
+		num_voltage=$(cat "$lane_dir/num_voltage_steps" 2>/dev/null || echo 0)
+
+		# Negative test: out-of-bounds timing steps (spec limit: 0..63)
+		assert_write_fail "$lane_dir/margin_timing" "9999" \
+			"$lane: timing step 9999 (out of range)"
+		assert_write_fail "$lane_dir/margin_timing" "-9999" \
+			"$lane: timing step -9999 (out of range)"
+		assert_write_fail "$lane_dir/margin_timing" "64" \
+			"$lane: timing step 64 (> spec max 63)"
+		assert_write_fail "$lane_dir/margin_timing" "-64" \
+			"$lane: timing step -64 (< spec min -63)"
+		assert_write_fail "$lane_dir/margin_timing" "invalid" \
+			"$lane: non-numeric timing step"
+
+		if [ -n "$num_timing" ] && [ "$num_timing" -ge 0 ] 2>/dev/null; then
+			assert_write_fail "$lane_dir/margin_timing" "$((num_timing + 1))" \
+				"$lane: timing step > receiver limit ($num_timing)"
+		fi
+
+		# Negative test: negative timing on symmetric receiver
+		if echo "$caps_raw" | grep -q "Left/Right: symmetric"; then
+			assert_write_fail "$lane_dir/margin_timing" "-1" \
+				"$lane: negative timing on symmetric receiver"
+		fi
+
+		# Negative test: out-of-bounds voltage steps (spec limit: 0..127)
+		assert_write_fail "$lane_dir/margin_voltage" "9999" \
+			"$lane: voltage step 9999 (out of range)"
+		assert_write_fail "$lane_dir/margin_voltage" "-9999" \
+			"$lane: voltage step -9999 (out of range)"
+		assert_write_fail "$lane_dir/margin_voltage" "128" \
+			"$lane: voltage step 128 (> spec max 127)"
+		assert_write_fail "$lane_dir/margin_voltage" "-128" \
+			"$lane: voltage step -128 (< spec min -127)"
+		assert_write_fail "$lane_dir/margin_voltage" "invalid" \
+			"$lane: non-numeric voltage step"
+
+		if echo "$caps_raw" | grep -q "Voltage Supported: No"; then
+			assert_write_fail "$lane_dir/margin_voltage" "1" \
+				"$lane: voltage step on unsupported receiver"
+		else
+			if [ -n "$num_voltage" ] && [ "$num_voltage" -ge 0 ] 2>/dev/null; then
+				assert_write_fail "$lane_dir/margin_voltage" \
+					"$((num_voltage + 1))" \
+					"$lane: voltage step > receiver limit ($num_voltage)"
+			fi
+			if echo "$caps_raw" | grep -q "Up/Down: symmetric"; then
+				assert_write_fail "$lane_dir/margin_voltage" "-1" \
+					"$lane: negative voltage on symmetric receiver"
+			fi
+		fi
+
+		# Positive test: reset timing and voltage margin to 0 (nominal settings)
+		assert_write_success "$lane_dir/margin_timing" "0" "$lane: reset timing to 0"
+		assert_write_success "$lane_dir/margin_voltage" "0" "$lane: reset voltage to 0"
+	done
+
+	# Cleanly disable margining
+	echo 0 > "$dev/enable"
+	trap - EXIT INT TERM
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

-- 
2.55.0.1003.g10538fe699-goog

