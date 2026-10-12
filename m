Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141DE4BF94B
	for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 17:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791826641; cv=none; b=W/OKeGkVVn8vsyPnfEF7++fXlYwWIEu5ju35ru2TvZiTqEnc9JG1WDQ51i6HI3aVo+m3UGd1oFKPVsCBgAcj5uvTaOmJM0PrGzTq9QEf+qLAafzhB2lLAyqsEmJ7N8uaOBE17aIpCzuBMA+4er8MCVGIdF1bw+Gl5S1qMmoHNcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791826641; c=relaxed/simple;
	bh=L0s0q/2gCal90dJdRnVCm2Y4bXSwIRZ/tfdB9ixK3TM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X7imBhGQEBggfZXh73nqVBkZaKdtrye+v3ccW/FwRq4pTSlibAKlIWDJ5TMscAgCU/aRhb05CYvD5Z6aS0lrdxzGBHtfQnxXosDi86tf8b2s0n+yMjPt022dYLOnRkDEkLEdqViJokjfJmWLO60dHLOT9/a5jhutIPfQz8cP+4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WSnuOO7/; arc=none smtp.client-ip=74.125.82.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WSnuOO7/"
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1383723dfddso1502502c88.0
        for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 10:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791826635; x=1792431435; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1+FDQnBrZ5hgAxhmNfMWaiFnGNCO1wl1eUb3Dlpm7u8=;
        b=WSnuOO7/Yf5S9K9iRnObMUi9x9rqyC/VZPx7dmjIdV3Z5k7G9GpeGkGtR4ul90iJiQ
         +9dwlu3FSfe9ltAZha+FsNh1K3QjnCoDeTdrgY6uwTkzFvVU1ZL6gFTMJsgxnGuVYkAm
         omMGTNGSM1O5ss4JXdtzqeSMQUEs0qW+VEHmN01EHoydzEO07bgTm78cKXSWLFg6A5tV
         JbhXXsCFc3AjkznG4OWgtwjc1pOW6Yxm7ItGEgxmeLYXD8VjLVyHnbFOqQn7rVh2rvzW
         YMtcT/KRtVyLGt1LXfQg/m08NWPBfdV9a79ID7dWcFmiUzHI0kxfBC+VTQ+S9QUb6ayl
         r2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791826635; x=1792431435;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1+FDQnBrZ5hgAxhmNfMWaiFnGNCO1wl1eUb3Dlpm7u8=;
        b=0/WzlRhf3bGAWukZeku7BiuBZ5rt/KJeLclazMtDQE+Diy3QQbUVsyV27EOBf5hTIw
         CErxTNTWU9jVdAEWtKrXU4QQt95evoYJmyIs4pE7q0+golWjFbyjE+cUd2gm3agcYVxe
         SDMzmdJDmpjYyuLyA2psLqioQM/mtonGLGJa0Y40Czl/siZtDL+5BGCPwi2VM67m9Atc
         R3/Ah3sPWy4KTuU/KbhExS37Y1Pjy4tg9FSuSIRzp/hOZC1sD39wy+ctUGUZsz2UG+2p
         P90YNu+D4iYnZ0LVQzhAslMrv7WS+AhaSW2Uva8cBlbKgreBpLhbhNk8TurW4F/Vvm0S
         OKjA==
X-Forwarded-Encrypted: i=1; AKwUvBz1qM0rqNM1o0Tu7tZJUlTg44Sd5a+zBj+CHweQL9IB8ZW/HGlKc4xsQBgJ76amaHn5CJ8jRSl65nY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIOdm11FN0e71/LEqv7rdCbR7MMp2AUp+BrLtI9vkItNajdY7FT
	zBxKdC+BAtIa/VuLX4rWedFe3KKnMBp25aVxYeQwJSVNCKHf+lV1LTUxIEfqL5PoMiYKYMYjjld
	DpsStEum1dbBeEXIg+c0i+qj2mhIGe6v4nA==
X-Received: from dlbqs3.prod.google.com ([2002:a05:7023:d03:b0:15b:db09:535])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:f503:b0:16a:f5cd:365 with SMTP id a92af1059eb24-16af5cd03a3mr13923456c88.5.1791826634479;
 Mon, 12 Oct 2026 10:37:14 -0700 (PDT)
Date: Mon, 12 Oct 2026 10:36:35 -0700
In-Reply-To: <20261012-pcie-link-endpoints-v7-0-36aba9c91f10@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261012-pcie-link-endpoints-v7-0-36aba9c91f10@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20261012-pcie-link-endpoints-v7-1-36aba9c91f10@google.com>
Subject: [PATCH v7 1/2] PCI/LMR: Add Lane Margining at the Receiver debugfs interface
From: Priyank Rathod <rathodpriyank@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "=?utf-8?q?Ilpo_J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Manivannan Sadhasivam <mani@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, linux-pci@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Priyank Rathod <rathodpriyank@google.com>
Content-Type: text/plain; charset="utf-8"

Lane Margining at the Receiver moves the sampling point of a receiver
away from its normal setting, in time or in voltage, while the link
stays up, and reports the errors the receiver sees.  It is available
on links running at 16.0 GT/s or faster, through the Lane Margining at
the Receiver Extended Capability.

Add a debugfs directory, pcie_lmr_<device>, for each Downstream Port
and each Function 0 below a Downstream Port that has the capability.

Writing 1 to 'enable' starts a margining session on the link.  ASPM is
turned off with pci_disable_link_state(), Hardware Autonomous Width
Disable and Hardware Autonomous Speed Disable are set on both ends,
both ends are kept runtime resumed, and the port's Margining Ready bit
is awaited.  Writing 0, or removing either end of the link, ends the
session and undoes these steps.  Only one session can be active on a
link.

During a session, 'receiver' selects the receiver, laneN/margin_timing
and laneN/margin_voltage issue Step Margin commands, laneN/caps shows
the parameters the receiver reports, and laneN/status shows the
response to the last step command, including the error count.  Before
each command, the link is checked against the state the session
started in: speed, width, Margining Ready, ASPM still off, and no
system suspend since.

The kernel does not run margining sweeps or interpret the results;
that is left to user space.

Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
---
 Documentation/PCI/index.rst    |    1 +
 Documentation/PCI/pcie-lmr.rst |  162 +++++
 MAINTAINERS                    |    7 +
 drivers/pci/pci.h              |    8 +
 drivers/pci/pcie/Kconfig       |   11 +
 drivers/pci/pcie/Makefile      |    1 +
 drivers/pci/pcie/margin.c      | 1551 ++++++++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c            |    1 +
 drivers/pci/remove.c           |    1 +
 include/uapi/linux/pci_regs.h  |   18 +
 10 files changed, 1761 insertions(+)

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
index 000000000000..760a30862674
--- /dev/null
+++ b/Documentation/PCI/pcie-lmr.rst
@@ -0,0 +1,162 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+====================================
+PCIe Lane Margining at the Receiver
+====================================
+
+Lane Margining at the Receiver lets software move the sampling point of a
+receiver away from its normal setting, in time or in voltage, while the link
+stays up, and read back the number of errors the receiver sees.  It is
+available on links running at 16.0 GT/s or faster, through the Lane Margining
+at the Receiver Extended Capability.
+
+With ``CONFIG_PCIE_LMR``, the kernel exposes the margining commands of each
+port that has the capability in debugfs.  The kernel does not run margining
+sweeps or interpret results; user-space tools do that.
+
+debugfs layout
+==============
+
+There is one directory per port that has the capability::
+
+  /sys/kernel/debug/pcie_lmr_<domain:bus:dev.fn>/
+      enable
+      receiver
+      port
+      lane0/
+          caps
+          margin_timing
+          margin_voltage
+          status
+      lane1/
+      ...
+
+The capability is used on Downstream Ports, and on Function 0 of the device
+below a Downstream Port.  There is one ``laneN`` directory for each lane of
+the port's Maximum Link Width.
+
+``enable``
+  Write 1 to start a margining session on the link, 0 to end it.  Both are
+  accepted when the port is already in that state.  Reads return 1 while a
+  session started on this port is active, and 0 otherwise.
+
+  Starting a session turns off the ASPM states that are enabled on the link,
+  sets Hardware Autonomous Width Disable and Hardware Autonomous Speed Disable
+  on both ends, keeps both ends runtime resumed, and waits for Margining
+  Ready.  Ending the session undoes these steps and returns every lane that
+  was margined to normal settings.
+
+  Only one session can be active on a link at a time.  A session is ended by
+  writing 0 to ``enable`` in the directory where it was started.
+
+``receiver``
+  The Receiver Number (1 to 6) that commands are sent to.  A Downstream Port
+  reaches receiver 1 (its own receiver) and, when retimers are present,
+  receivers 2 and 3 for the first retimer and 4 and 5 for the second.
+  Function 0 below a Downstream Port reaches only receiver 6 (its own
+  receiver).  A session starts with receiver 1 or 6.  Selecting another
+  receiver first returns the lanes margined by the current one to normal
+  settings.
+
+``port``
+  Margining Port Capabilities and Status bits: ``uses_driver_software``,
+  ``margining_ready`` and ``software_ready``.  This file can be read without a
+  session.
+
+``laneN/caps``
+  The parameters the selected receiver reports for the lane, one ``key:
+  value`` pair per line.  The values are read from the receiver the first time
+  the file is read or a step is written in a session, and again after the
+  receiver changes.  ``max_lanes`` is the number of lanes that can be margined
+  at the same time.
+
+``laneN/margin_timing``, ``laneN/margin_voltage``
+  Write a number of steps to move the sampling point of the selected receiver
+  on this lane.  Negative values move left or down and are accepted only when
+  the receiver supports independent left/right timing or up/down voltage
+  margining.  Writing 0 returns the lane to normal settings; because that
+  clears both offsets, the other offset is then applied again.  Reads return
+  the offset that was last applied.
+
+``laneN/status``
+  The receiver's response to the last step command on this lane, as
+  ``<timing|voltage> <setup|margining|too_many_errors|nak> <error count>``,
+  or ``idle`` when the last command was not a step command.  Reading this
+  file does not send a command.
+
+All files are only accessible to root.
+
+Example
+=======
+
+Measure one timing step to the right on lane 0, from a Downstream Port::
+
+  # cd /sys/kernel/debug/pcie_lmr_0000:00:01.1
+  # echo 1 > enable
+  # cat lane0/caps
+  receiver: 1
+  ...
+  # echo 1 > lane0/margin_timing
+  # sleep 1; cat lane0/status
+  timing margining 0
+  # echo 0 > lane0/margin_timing
+  # echo 0 > enable
+
+Errors
+======
+
+Reads and writes return these errors in addition to the usual parsing errors:
+
+=================  ===========================================================
+``-ENOTCONN``      No session is active on this port.
+``-EBUSY``         Another session is active on the link, the port or its
+                   link partner is being probed, removed or reset (try again),
+                   too many lanes are margined already, or ASPM was found
+                   enabled on the link.
+``-ENODEV``        The link partner is missing or was removed, or the device
+                   does not respond.
+``-ENOLINK``       The link is down.
+``-EOPNOTSUPP``    The link runs below 16.0 GT/s, the receiver does not
+                   support voltage margining, or it answered a step command
+                   with a NAK.
+``-ERANGE``        The step count is larger than the receiver supports.
+``-EINVAL``        A negative step that the receiver does not support, or a
+                   receiver number that is not reachable from this port.
+``-EIO``           The receiver reported too many errors immediately on a step
+                   command and was returned to normal settings, or the link
+                   changed speed or width, lost Margining Ready, or went
+                   through system suspend since the session started.
+``-ETIMEDOUT``     Margining Software Ready is not set, Margining Ready was
+                   not set within the timeout, or the receiver did not respond
+                   to a command (for example on an inactive lane).
+=================  ===========================================================
+
+Limitations
+===========
+
+- ASPM is turned off and back on with ``pci_disable_link_state()`` and
+  ``pci_force_enable_link_state()``, like drivers that need ASPM off for a
+  while.  This round trip is not exact:
+
+  - If another driver disables an ASPM state during a session, ending the
+    session turns it back on.
+  - The ASPM default for the link becomes the set of states that were enabled
+    when the session started.
+  - Disabling L1 also disables the L1 substates, so substates that were
+    disabled at the start stay disabled.
+  - Without OS control of ASPM, the states are turned off but cannot be turned
+    back on, and stay off until reboot.
+
+  If nothing was enabled when the session started, the ASPM API is not called
+  at all.  Before each command the ASPM Control field of both ends is checked,
+  so a session does not continue if ASPM was turned back on, for example
+  through the ``link/*_aspm`` files in sysfs.
+
+- Receivers lose their margining state over system suspend.  Commands on a
+  session that was active before a suspend fail with ``-EIO``.
+
+- One receiver is margined at a time.  The error count limit is the
+  receiver's default; the kernel does not set it.
+
+- Another program writing the Lane Margining registers directly, such as
+  ``pcilmr`` or ``setpci``, will interfere with a session.
diff --git a/MAINTAINERS b/MAINTAINERS
index 8df569bbf3a9..cc0fdf2ff7e9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21292,6 +21292,13 @@ F:	Documentation/devicetree/bindings/pci/qcom,sa8255p-pcie-ep.yaml
 F:	drivers/pci/controller/dwc/pcie-qcom-common.c
 F:	drivers/pci/controller/dwc/pcie-qcom-ep.c
 
+PCIE LANE MARGINING AT THE RECEIVER (LMR)
+M:	Priyank Rathod <rathodpriyank@google.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/PCI/pcie-lmr.rst
+F:	drivers/pci/pcie/margin.c
+
 PCMCIA SUBSYSTEM
 M:	Dominik Brodowski <linux@dominikbrodowski.net>
 S:	Odd Fixes
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a002fe1a3f4c..363f065c8af2 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -772,6 +772,14 @@ static inline void pci_tsm_init(struct pci_dev *pdev) { }
 static inline void pci_tsm_destroy(struct pci_dev *pdev) { }
 #endif
 
+#ifdef CONFIG_PCIE_LMR
+void pci_lmr_init(struct pci_dev *dev);
+void pci_lmr_exit(struct pci_dev *dev);
+#else
+static inline void pci_lmr_init(struct pci_dev *dev) { }
+static inline void pci_lmr_exit(struct pci_dev *dev) { }
+#endif
+
 /**
  * pci_dev_set_io_state - Set the new error state if possible.
  *
diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 207c2deae35f..b307460fa97c 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -146,3 +146,14 @@ config PCIE_EDR
 	  the PCI Firmware Specification r3.2.  Enable this if you want to
 	  support hybrid DPC model which uses both firmware and OS to
 	  implement DPC.
+
+config PCIE_LMR
+	bool "PCI Express Lane Margining at the Receiver support"
+	depends on PCIEASPM && DEBUG_FS
+	help
+	  This option exposes the Lane Margining at the Receiver Extended
+	  Capability in debugfs (see Documentation/PCI/pcie-lmr.rst), so
+	  that user space can measure the timing and voltage margin of
+	  links running at 16.0 GT/s or faster.
+
+	  If unsure, say N.
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index b0b43a18c304..f7216f6a3bac 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -14,3 +14,4 @@ obj-$(CONFIG_PCIE_PME)		+= pme.o
 obj-$(CONFIG_PCIE_DPC)		+= dpc.o
 obj-$(CONFIG_PCIE_PTM)		+= ptm.o
 obj-$(CONFIG_PCIE_EDR)		+= edr.o
+obj-$(CONFIG_PCIE_LMR)		+= margin.o
diff --git a/drivers/pci/pcie/margin.c b/drivers/pci/pcie/margin.c
new file mode 100644
index 000000000000..4a6f4d5884f2
--- /dev/null
+++ b/drivers/pci/pcie/margin.c
@@ -0,0 +1,1551 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCIe Lane Margining at the Receiver
+ *
+ * Copyright (C) 2026 Google LLC
+ * Author: Priyank Rathod <rathodpriyank@google.com>
+ *
+ * Lane Margining at the Receiver moves the sampling point of a receiver
+ * away from its normal setting, in time or in voltage, while the link
+ * stays up, and reports the errors the receiver sees.  It is available
+ * on links running at 16.0 GT/s or faster.
+ *
+ * This file exposes the margining commands of the Lane Margining at the
+ * Receiver Extended Capability in debugfs, one directory per port that
+ * has the capability.  It does not run sweeps or interpret results;
+ * that is left to user space.
+ *
+ * Commands always go through the capability of the port that owns the
+ * debugfs directory.  Receiver 1 (the Downstream Port) and the retimer
+ * receivers 2-5 are reached through the Downstream Port, and receiver 6
+ * (the Upstream Port) through Function 0 of the device below it.  A
+ * session selects one receiver, and only one session can be active on a
+ * link at a time.
+ *
+ * Locking, outermost first:
+ *
+ *   device_lock() of both ends of the link, with pci_dev_trylock(),
+ *   only in pci_lmr_start()
+ *     port->lock, one port at a time
+ *       pci_lmr_mutex (leaf lock)
+ *       pci_bus_sem (read) -> aspm_lock -> pcie_cap_lock in the ASPM API
+ *
+ * pci_lmr_find_partner() and runtime PM calls are made outside all of
+ * the locks above.  port->active is changed only with both port->lock
+ * and pci_lmr_mutex held, so holding either one is enough to read it.
+ */
+
+#include <linux/atomic.h>
+#include <linux/bitfield.h>
+#include <linux/cleanup.h>
+#include <linux/debugfs.h>
+#include <linux/iopoll.h>
+#include <linux/kref.h>
+#include <linux/kstrtox.h>
+#include <linux/limits.h>
+#include <linux/list.h>
+#include <linux/math.h>
+#include <linux/minmax.h>
+#include <linux/mutex.h>
+#include <linux/notifier.h>
+#include <linux/overflow.h>
+#include <linux/pci.h>
+#include <linux/pm_runtime.h>
+#include <linux/reboot.h>
+#include <linux/rwsem.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+#include <linux/sprintf.h>
+#include <linux/suspend.h>
+
+#include "../pci.h"
+
+/* Margin Type values in Margining Lane Control and Status */
+#define LMR_TYPE_REPORT		1	/* Access Retimer/Receiver parameters */
+#define LMR_TYPE_SET		2	/* Set margining parameters */
+#define LMR_TYPE_TIMING		3	/* Step Margin Timing */
+#define LMR_TYPE_VOLTAGE	4	/* Step Margin Voltage */
+#define LMR_TYPE_NO_CMD		7	/* No Command */
+
+/* Margin Payload values for LMR_TYPE_REPORT */
+#define LMR_REPORT_CAPS		0x88	/* Margin Control Capabilities */
+#define LMR_REPORT_VOLT_STEPS	0x89	/* MNumVoltageSteps */
+#define LMR_REPORT_TIM_STEPS	0x8a	/* MNumTimingSteps */
+#define LMR_REPORT_TIM_OFFSET	0x8b	/* MMaxTimingOffset */
+#define LMR_REPORT_VOLT_OFFSET	0x8c	/* MMaxVoltageOffset */
+#define LMR_REPORT_MAX_LANES	0x90	/* MMaxLanes */
+
+/* Margin Payload values for LMR_TYPE_SET and LMR_TYPE_NO_CMD */
+#define LMR_SET_NORMAL		0x0f	/* Go to Normal Settings */
+#define LMR_NO_CMD		0x9c	/* No Command */
+
+/* Report Margin Control Capabilities response */
+#define LMR_CAP_VOLTAGE		BIT(0)	/* MVoltageSupported */
+#define LMR_CAP_IND_UP_DOWN	BIT(1)	/* MIndUpDownVoltage */
+#define LMR_CAP_IND_LEFT_RIGHT	BIT(2)	/* MIndLeftRightTiming */
+#define LMR_CAP_SAMPLE_RATE	BIT(3)	/* MSampleReportingMethod */
+#define LMR_CAP_IND_ERR_SAMPLER	BIT(4)	/* MIndErrorSampler */
+
+/* Fields of the other Report responses */
+#define LMR_RPT_TIM_STEPS	GENMASK(5, 0)
+#define LMR_RPT_VOLT_STEPS	GENMASK(6, 0)
+#define LMR_RPT_OFFSET		GENMASK(6, 0)
+#define LMR_RPT_MAX_LANES	GENMASK(4, 0)
+
+/* Step Margin command payload */
+#define LMR_STEP_TIM		GENMASK(5, 0)
+#define LMR_STEP_TIM_LEFT	BIT(6)
+#define LMR_STEP_VOLT		GENMASK(6, 0)
+#define LMR_STEP_VOLT_DOWN	BIT(7)
+
+/* Step Margin response payload */
+#define LMR_STEP_ERR_COUNT	GENMASK(5, 0)
+#define LMR_STEP_STATUS		GENMASK(7, 6)
+#define  LMR_STEP_TOO_MANY_ERR	0
+#define  LMR_STEP_SETUP		1
+#define  LMR_STEP_MARGINING	2
+#define  LMR_STEP_NAK		3
+
+#define LMR_RX_DP		1	/* Downstream Port receiver */
+#define LMR_RX_UP		6	/* Upstream Port receiver */
+
+#define LMR_MAX_WIDTH		32
+#define LMR_POLL_US		1000
+#define LMR_TIMEOUT_US		(100 * USEC_PER_MSEC)
+
+/**
+ * struct pci_lmr_rx - Parameters reported by the selected receiver
+ * @valid: The fields below were read after the receiver was selected
+ * @caps: Report Margin Control Capabilities response
+ * @timing_steps: MNumTimingSteps
+ * @max_timing_offset: MMaxTimingOffset
+ * @voltage_steps: MNumVoltageSteps
+ * @max_voltage_offset: MMaxVoltageOffset
+ * @max_lanes: Number of lanes that can be margined at once (MMaxLanes + 1)
+ */
+struct pci_lmr_rx {
+	bool valid;
+	u8 caps;
+	u8 timing_steps;
+	u8 max_timing_offset;
+	u8 voltage_steps;
+	u8 max_voltage_offset;
+	u8 max_lanes;
+};
+
+/**
+ * struct pci_lmr_lane - One lane of a margining port
+ * @port: Port the lane belongs to
+ * @lane: Lane number
+ * @touched: A step command was issued since the receiver was selected
+ * @timing: Current timing offset in steps, negative to the left
+ * @voltage: Current voltage offset in steps, negative down
+ * @rx: Receiver parameters for this lane
+ */
+struct pci_lmr_lane {
+	struct pci_lmr_port *port;
+	unsigned int lane;
+	bool touched;
+	int timing;
+	int voltage;
+	struct pci_lmr_rx rx;
+};
+
+/**
+ * struct pci_lmr_port - A port that has the Lane Margining capability
+ * @node: Entry in pci_lmr_ports
+ * @kref: Reference count on this struct
+ * @dev: Device that has the capability (holds a reference)
+ * @dport: Downstream Port of the link; @dev itself on the Downstream Port side
+ *	   (holds a reference)
+ * @cap: Offset of the capability
+ * @downstream: @dev is the Downstream Port of its link
+ * @dir: debugfs directory
+ * @lock: Serializes margining commands and protects the session fields
+ * @active: A margining session is active; see the locking notes above
+ * @partner: Other end of the link while a session is up (holds a reference)
+ * @receiver: Receiver selected for the session
+ * @retimers: Number of retimers detected when the session started
+ * @lnksta: Speed and width fields of the Downstream Port's Link Status
+ * @aspm: ASPM states that were enabled when the session started
+ * @clkpm: CLKREQ# was enabled when the session started
+ * @dp_hawd: HAWD bit of the Downstream Port's Link Control at session start
+ * @dp_hasd: HASD bit of the Downstream Port's Link Control 2 at session start
+ * @up_hawd: HAWD bit of the Upstream Port's Link Control at session start
+ * @up_hasd: HASD bit of the Upstream Port's Link Control 2 at session start
+ * @pm_gen: Value of pci_lmr_pm_gen when the session started
+ * @nr_lanes: Maximum Link Width of @dev
+ * @lanes: Per-lane state
+ */
+struct pci_lmr_port {
+	struct list_head node;
+	struct kref kref;
+	struct pci_dev *dev;
+	struct pci_dev *dport;
+	u16 cap;
+	bool downstream;
+	struct dentry *dir;
+	struct mutex lock;		/* See the kernel-doc above */
+	bool active;
+	struct pci_dev *partner;
+	u8 receiver;
+	u8 retimers;
+	u16 lnksta;
+	u32 aspm;
+	bool clkpm;
+	u16 dp_hawd;
+	u16 dp_hasd;
+	u16 up_hawd;
+	u16 up_hasd;
+	unsigned int pm_gen;
+	unsigned int nr_lanes;
+	struct pci_lmr_lane lanes[] __counted_by(nr_lanes);
+};
+
+static DEFINE_MUTEX(pci_lmr_mutex);
+static LIST_HEAD(pci_lmr_ports);	/* Protected by pci_lmr_mutex */
+static bool pci_lmr_rebooting;		/* Protected by pci_lmr_mutex */
+static atomic_t pci_lmr_pm_gen = ATOMIC_INIT(0);
+
+/* The two ends of the link; only valid while @port->partner is set */
+static struct pci_dev *pci_lmr_dp(struct pci_lmr_port *port)
+{
+	return port->downstream ? port->dev : port->partner;
+}
+
+static struct pci_dev *pci_lmr_up(struct pci_lmr_port *port)
+{
+	return port->downstream ? port->partner : port->dev;
+}
+
+static u8 pci_lmr_default_rx(struct pci_lmr_port *port)
+{
+	return port->downstream ? LMR_RX_DP : LMR_RX_UP;
+}
+
+static u16 pci_lmr_lane_sts(struct pci_lmr_port *port, unsigned int lane)
+{
+	int pos = port->cap + PCI_LMR_LANE_STS + lane * PCI_LMR_LANE_STRIDE;
+	u16 sts;
+
+	if (pci_read_config_word(port->dev, pos, &sts))
+		return (u16)PCI_ERROR_RESPONSE;
+
+	return sts;
+}
+
+/*
+ * Write @cmd to Margining Lane Control and wait until the bits of
+ * Margining Lane Status selected by @match are equal to those of @cmd.
+ */
+static int pci_lmr_write_wait(struct pci_lmr_port *port, unsigned int lane,
+			      u16 cmd, u16 match, u16 *sts)
+{
+	int pos = port->cap + PCI_LMR_LANE_CTRL + lane * PCI_LMR_LANE_STRIDE;
+	u16 val;
+	int ret;
+
+	ret = pci_write_config_word(port->dev, pos, cmd);
+	if (ret)
+		return pcibios_err_to_errno(ret);
+
+	ret = read_poll_timeout(pci_lmr_lane_sts, val,
+				PCI_POSSIBLE_ERROR(val) ||
+				(val & match) == (cmd & match),
+				LMR_POLL_US, LMR_TIMEOUT_US, false, port, lane);
+	if (PCI_POSSIBLE_ERROR(val))
+		return -ENODEV;
+	if (ret)
+		return ret;
+
+	if (sts)
+		*sts = val;
+
+	return 0;
+}
+
+static u16 pci_lmr_word(u8 rx, u8 type, u8 payload)
+{
+	return FIELD_PREP(PCI_LMR_LANE_RX, rx) |
+	       FIELD_PREP(PCI_LMR_LANE_TYPE, type) |
+	       FIELD_PREP(PCI_LMR_LANE_PAYLOAD, payload);
+}
+
+static int pci_lmr_no_cmd(struct pci_lmr_port *port, unsigned int lane)
+{
+	u16 cmd = pci_lmr_word(0, LMR_TYPE_NO_CMD, LMR_NO_CMD);
+	u16 match = PCI_LMR_LANE_RX | PCI_LMR_LANE_TYPE | PCI_LMR_LANE_PAYLOAD;
+
+	return pci_lmr_write_wait(port, lane, cmd, match, NULL);
+}
+
+/*
+ * Send one command to the selected receiver on @lane and return the
+ * payload of its response.  A No Command is written first, as pcilmr
+ * does, so the response cannot be confused with the one to an earlier
+ * command.
+ */
+static int pci_lmr_cmd(struct pci_lmr_port *port, unsigned int lane,
+		       u8 type, u8 payload, u8 *resp)
+{
+	u16 cmd, match, sts;
+	int ret;
+
+	lockdep_assert_held(&port->lock);
+
+	ret = pci_lmr_no_cmd(port, lane);
+	if (ret)
+		return ret;
+
+	cmd = pci_lmr_word(port->receiver, type, payload);
+	match = PCI_LMR_LANE_RX | PCI_LMR_LANE_TYPE;
+	if (type == LMR_TYPE_SET)
+		match |= PCI_LMR_LANE_PAYLOAD;
+
+	ret = pci_lmr_write_wait(port, lane, cmd, match, &sts);
+	if (ret)
+		return ret;
+
+	if (resp)
+		*resp = FIELD_GET(PCI_LMR_LANE_PAYLOAD, sts);
+
+	return 0;
+}
+
+/* Go to Normal Settings returns both the timing and the voltage offset to 0 */
+static int pci_lmr_go_normal(struct pci_lmr_lane *l)
+{
+	int ret;
+
+	ret = pci_lmr_cmd(l->port, l->lane, LMR_TYPE_SET, LMR_SET_NORMAL, NULL);
+	if (ret)
+		return ret;
+
+	l->timing = 0;
+	l->voltage = 0;
+
+	return pci_lmr_no_cmd(l->port, l->lane);
+}
+
+/* Return the lanes that may still be margined to normal settings */
+static int pci_lmr_reset_lanes(struct pci_lmr_port *port)
+{
+	unsigned int i;
+	int ret, err = 0;
+
+	for (i = 0; i < port->nr_lanes; i++) {
+		struct pci_lmr_lane *l = &port->lanes[i];
+
+		if (!l->touched)
+			continue;
+
+		ret = pci_lmr_go_normal(l);
+		if (!ret) {
+			l->touched = false;
+			continue;
+		}
+
+		err = err ?: ret;
+		if (ret == -ENODEV)
+			break;
+		pci_warn(port->dev, "LMR: failed to reset lane %u (%d)\n",
+			 i, ret);
+	}
+
+	return err;
+}
+
+static void pci_lmr_forget_rx(struct pci_lmr_port *port)
+{
+	unsigned int i;
+
+	for (i = 0; i < port->nr_lanes; i++) {
+		port->lanes[i].touched = false;
+		port->lanes[i].timing = 0;
+		port->lanes[i].voltage = 0;
+		port->lanes[i].rx.valid = false;
+	}
+}
+
+static int pci_lmr_report(struct pci_lmr_lane *l, u8 payload, u8 *val)
+{
+	return pci_lmr_cmd(l->port, l->lane, LMR_TYPE_REPORT, payload, val);
+}
+
+static int pci_lmr_get_rx(struct pci_lmr_lane *l)
+{
+	struct pci_lmr_rx rx = {};
+	u8 val;
+	int ret;
+
+	if (l->rx.valid)
+		return 0;
+
+	ret = pci_lmr_report(l, LMR_REPORT_CAPS, &rx.caps);
+	if (ret)
+		return ret;
+
+	ret = pci_lmr_report(l, LMR_REPORT_TIM_STEPS, &val);
+	if (ret)
+		return ret;
+	rx.timing_steps = FIELD_GET(LMR_RPT_TIM_STEPS, val);
+
+	ret = pci_lmr_report(l, LMR_REPORT_TIM_OFFSET, &val);
+	if (ret)
+		return ret;
+	rx.max_timing_offset = FIELD_GET(LMR_RPT_OFFSET, val);
+
+	if (rx.caps & LMR_CAP_VOLTAGE) {
+		ret = pci_lmr_report(l, LMR_REPORT_VOLT_STEPS, &val);
+		if (ret)
+			return ret;
+		rx.voltage_steps = FIELD_GET(LMR_RPT_VOLT_STEPS, val);
+
+		ret = pci_lmr_report(l, LMR_REPORT_VOLT_OFFSET, &val);
+		if (ret)
+			return ret;
+		rx.max_voltage_offset = FIELD_GET(LMR_RPT_OFFSET, val);
+	}
+
+	ret = pci_lmr_report(l, LMR_REPORT_MAX_LANES, &val);
+	if (ret)
+		return ret;
+	rx.max_lanes = FIELD_GET(LMR_RPT_MAX_LANES, val) + 1;
+
+	ret = pci_lmr_no_cmd(l->port, l->lane);
+	if (ret)
+		return ret;
+
+	rx.valid = true;
+	l->rx = rx;
+
+	return 0;
+}
+
+/*
+ * Before each margining command, check that the link is still in the
+ * state the session was set up in.
+ */
+static int pci_lmr_check(struct pci_lmr_port *port)
+{
+	struct pci_dev *dp, *up;
+	u16 dp_ctl, up_ctl, lnksta, sts;
+
+	lockdep_assert_held(&port->lock);
+
+	if (!port->active)
+		return -ENOTCONN;
+
+	dp = pci_lmr_dp(port);
+	up = pci_lmr_up(port);
+	if (!pci_dev_is_added(port->partner) ||
+	    pci_dev_is_disconnected(dp) || pci_dev_is_disconnected(up))
+		return -ENODEV;
+
+	/* Margining state is lost over system suspend */
+	if (atomic_read(&pci_lmr_pm_gen) != port->pm_gen)
+		return -EIO;
+
+	if (pcie_capability_read_word(dp, PCI_EXP_LNKCTL, &dp_ctl) ||
+	    pcie_capability_read_word(up, PCI_EXP_LNKCTL, &up_ctl) ||
+	    pcie_capability_read_word(dp, PCI_EXP_LNKSTA, &lnksta) ||
+	    pci_read_config_word(port->dev, port->cap + PCI_LMR_PORT_STS, &sts))
+		return -ENODEV;
+
+	if (PCI_POSSIBLE_ERROR(dp_ctl) || PCI_POSSIBLE_ERROR(up_ctl) ||
+	    PCI_POSSIBLE_ERROR(lnksta) || PCI_POSSIBLE_ERROR(sts))
+		return -ENODEV;
+
+	/* ASPM was turned back on, e.g. through sysfs */
+	if ((dp_ctl | up_ctl) & PCI_EXP_LNKCTL_ASPMC)
+		return -EBUSY;
+
+	if ((lnksta & (PCI_EXP_LNKSTA_CLS | PCI_EXP_LNKSTA_NLW)) !=
+	    port->lnksta)
+		return -EIO;
+
+	if (!(sts & PCI_LMR_PORT_STS_MARGIN_READY))
+		return -EIO;
+
+	return 0;
+}
+
+static bool pci_lmr_margined(struct pci_lmr_lane *l)
+{
+	return l->timing || l->voltage;
+}
+
+/*
+ * A receiver that reaches its error limit while dwelling on a step stops
+ * margining and returns to normal settings on its own.  Check for that
+ * before using the recorded offsets.
+ */
+static int pci_lmr_sync_lane(struct pci_lmr_lane *l)
+{
+	struct pci_lmr_port *port = l->port;
+	u8 type, payload;
+	u16 sts;
+
+	if (!pci_lmr_margined(l))
+		return 0;
+
+	sts = pci_lmr_lane_sts(port, l->lane);
+	if (PCI_POSSIBLE_ERROR(sts))
+		return -ENODEV;
+
+	type = FIELD_GET(PCI_LMR_LANE_TYPE, sts);
+	payload = FIELD_GET(PCI_LMR_LANE_PAYLOAD, sts);
+	if (FIELD_GET(PCI_LMR_LANE_RX, sts) == port->receiver &&
+	    (type == LMR_TYPE_TIMING || type == LMR_TYPE_VOLTAGE) &&
+	    FIELD_GET(LMR_STEP_STATUS, payload) == LMR_STEP_TOO_MANY_ERR)
+		return pci_lmr_go_normal(l);
+
+	return 0;
+}
+
+/*
+ * The receiver limits how many lanes can be margined at once.  Count
+ * the lanes that are margined now and use the smallest limit any of
+ * them, or @l, reported.
+ */
+static int pci_lmr_lane_limit(struct pci_lmr_lane *l)
+{
+	struct pci_lmr_port *port = l->port;
+	unsigned int i, count = 0, limit = l->rx.max_lanes;
+	int ret;
+
+	for (i = 0; i < port->nr_lanes; i++) {
+		struct pci_lmr_lane *o = &port->lanes[i];
+
+		if (o == l)
+			continue;
+
+		ret = pci_lmr_sync_lane(o);
+		if (ret)
+			return ret;
+
+		if (!pci_lmr_margined(o))
+			continue;
+
+		count++;
+		limit = min(limit, o->rx.max_lanes);
+	}
+
+	return count + 1 > limit ? -EBUSY : 0;
+}
+
+static int pci_lmr_check_steps(struct pci_lmr_lane *l, bool timing, int steps)
+{
+	struct pci_lmr_rx *rx = &l->rx;
+	unsigned int max;
+	bool ind;
+
+	if (timing) {
+		max = rx->timing_steps;
+		ind = rx->caps & LMR_CAP_IND_LEFT_RIGHT;
+	} else {
+		if (!(rx->caps & LMR_CAP_VOLTAGE))
+			return -EOPNOTSUPP;
+		max = rx->voltage_steps;
+		ind = rx->caps & LMR_CAP_IND_UP_DOWN;
+	}
+
+	if (steps < 0 && !ind)
+		return -EINVAL;
+
+	if (steps < -(int)max || steps > (int)max)
+		return -ERANGE;
+
+	return 0;
+}
+
+/*
+ * Issue a Step Margin command with a non-zero offset.  A NAK leaves the
+ * receiver as it was.  When the receiver reports too many errors, it is
+ * sent to normal settings, so that software and hardware agree.
+ */
+static int pci_lmr_send_step(struct pci_lmr_lane *l, bool timing, int steps)
+{
+	unsigned int mag = abs(steps);
+	u8 type, payload, resp;
+	int ret;
+
+	if (timing) {
+		type = LMR_TYPE_TIMING;
+		payload = FIELD_PREP(LMR_STEP_TIM, mag);
+		if (steps < 0)
+			payload |= LMR_STEP_TIM_LEFT;
+	} else {
+		type = LMR_TYPE_VOLTAGE;
+		payload = FIELD_PREP(LMR_STEP_VOLT, mag);
+		if (steps < 0)
+			payload |= LMR_STEP_VOLT_DOWN;
+	}
+
+	l->touched = true;
+	ret = pci_lmr_cmd(l->port, l->lane, type, payload, &resp);
+	if (ret)
+		return ret;
+
+	switch (FIELD_GET(LMR_STEP_STATUS, resp)) {
+	case LMR_STEP_NAK:
+		return -EOPNOTSUPP;
+	case LMR_STEP_TOO_MANY_ERR:
+		ret = pci_lmr_go_normal(l);
+		return ret ?: -EIO;
+	default:
+		break;
+	}
+
+	if (timing)
+		l->timing = steps;
+	else
+		l->voltage = steps;
+
+	return 0;
+}
+
+static int pci_lmr_step(struct pci_lmr_lane *l, bool timing, int steps)
+{
+	struct pci_lmr_port *port = l->port;
+	int other, ret;
+
+	ret = pci_lmr_check(port);
+	if (ret)
+		return ret;
+
+	ret = pci_lmr_get_rx(l);
+	if (ret)
+		return ret;
+
+	ret = pci_lmr_check_steps(l, timing, steps);
+	if (ret)
+		return ret;
+
+	ret = pci_lmr_sync_lane(l);
+	if (ret)
+		return ret;
+
+	if (steps) {
+		if (!pci_lmr_margined(l)) {
+			ret = pci_lmr_lane_limit(l);
+			if (ret)
+				return ret;
+		}
+		return pci_lmr_send_step(l, timing, steps);
+	}
+
+	/*
+	 * A Step Margin command with a payload of 0 does not move the
+	 * receiver back.  Go to Normal Settings does, but for both offsets,
+	 * so the other offset has to be applied again afterwards.
+	 */
+	other = timing ? l->voltage : l->timing;
+	ret = pci_lmr_go_normal(l);
+	if (ret)
+		return ret;
+
+	if (other)
+		return pci_lmr_send_step(l, !timing, other);
+
+	return 0;
+}
+
+static void pci_lmr_aspm_restore(struct pci_lmr_port *port)
+{
+	int state = port->aspm;
+
+	if (!state)
+		return;
+
+	if (port->clkpm)
+		state |= PCIE_LINK_STATE_CLKPM;
+
+	pci_force_enable_link_state(pci_lmr_up(port), state);
+}
+
+/*
+ * Turn off the ASPM states that are enabled on the link, using the
+ * same calls as drivers that need ASPM off for a while.  Clock PM is
+ * not passed to pci_disable_link_state(), because nothing but the sysfs
+ * clkpm file clears a Clock PM disable again.  pcie_aspm_enabled() does
+ * not report Clock PM, so it is added back on restore if CLKREQ# was
+ * enabled.
+ */
+static int pci_lmr_aspm_off(struct pci_lmr_port *port)
+{
+	struct pci_dev *dp = pci_lmr_dp(port), *up = pci_lmr_up(port);
+	u16 dp_ctl, up_ctl;
+	int ret;
+
+	ret = pcie_capability_read_word(up, PCI_EXP_LNKCTL, &up_ctl);
+	if (ret || PCI_POSSIBLE_ERROR(up_ctl))
+		return -ENODEV;
+
+	port->clkpm = up_ctl & PCI_EXP_LNKCTL_CLKREQ_EN;
+	port->aspm = pcie_aspm_enabled(up);
+	if (port->aspm) {
+		ret = pci_disable_link_state(up, port->aspm);
+		if (ret)
+			return ret;
+	}
+
+	/* ASPM may also have been left on by firmware */
+	if (pcie_capability_read_word(dp, PCI_EXP_LNKCTL, &dp_ctl) ||
+	    pcie_capability_read_word(up, PCI_EXP_LNKCTL, &up_ctl) ||
+	    PCI_POSSIBLE_ERROR(dp_ctl) || PCI_POSSIBLE_ERROR(up_ctl)) {
+		ret = -ENODEV;
+		goto restore;
+	}
+
+	if ((dp_ctl | up_ctl) & PCI_EXP_LNKCTL_ASPMC) {
+		ret = -EBUSY;
+		goto restore;
+	}
+
+	return 0;
+
+restore:
+	pci_lmr_aspm_restore(port);
+	return ret;
+}
+
+/*
+ * Hardware must not change the link speed or width on its own while a
+ * receiver is margined.  Set HAWD and HASD on both ends, the Upstream
+ * Port first, and restore them in the opposite order.  The PCI core
+ * serializes updates to Link Control and Link Control 2 with each
+ * device's pcie_cap_lock.
+ */
+static int pci_lmr_autonomous_off(struct pci_lmr_port *port)
+{
+	struct pci_dev *dp = pci_lmr_dp(port), *up = pci_lmr_up(port);
+	u16 dp_ctl, dp_ctl2, up_ctl, up_ctl2;
+
+	if (pcie_capability_read_word(dp, PCI_EXP_LNKCTL, &dp_ctl) ||
+	    pcie_capability_read_word(dp, PCI_EXP_LNKCTL2, &dp_ctl2) ||
+	    pcie_capability_read_word(up, PCI_EXP_LNKCTL, &up_ctl) ||
+	    pcie_capability_read_word(up, PCI_EXP_LNKCTL2, &up_ctl2))
+		return -ENODEV;
+
+	if (PCI_POSSIBLE_ERROR(dp_ctl) || PCI_POSSIBLE_ERROR(dp_ctl2) ||
+	    PCI_POSSIBLE_ERROR(up_ctl) || PCI_POSSIBLE_ERROR(up_ctl2))
+		return -ENODEV;
+
+	port->dp_hawd = dp_ctl & PCI_EXP_LNKCTL_HAWD;
+	port->dp_hasd = dp_ctl2 & PCI_EXP_LNKCTL2_HASD;
+	port->up_hawd = up_ctl & PCI_EXP_LNKCTL_HAWD;
+	port->up_hasd = up_ctl2 & PCI_EXP_LNKCTL2_HASD;
+
+	pcie_capability_set_word(up, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_HAWD);
+	pcie_capability_set_word(up, PCI_EXP_LNKCTL2, PCI_EXP_LNKCTL2_HASD);
+	pcie_capability_set_word(dp, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_HAWD);
+	pcie_capability_set_word(dp, PCI_EXP_LNKCTL2, PCI_EXP_LNKCTL2_HASD);
+
+	return 0;
+}
+
+static void pci_lmr_autonomous_restore(struct pci_lmr_port *port)
+{
+	struct pci_dev *dp = pci_lmr_dp(port), *up = pci_lmr_up(port);
+
+	if (!pci_dev_is_disconnected(dp)) {
+		pcie_capability_clear_and_set_word(dp, PCI_EXP_LNKCTL,
+						   PCI_EXP_LNKCTL_HAWD,
+						   port->dp_hawd);
+		pcie_capability_clear_and_set_word(dp, PCI_EXP_LNKCTL2,
+						   PCI_EXP_LNKCTL2_HASD,
+						   port->dp_hasd);
+	}
+
+	if (!pci_dev_is_disconnected(up)) {
+		pcie_capability_clear_and_set_word(up, PCI_EXP_LNKCTL,
+						   PCI_EXP_LNKCTL_HAWD,
+						   port->up_hawd);
+		pcie_capability_clear_and_set_word(up, PCI_EXP_LNKCTL2,
+						   PCI_EXP_LNKCTL2_HASD,
+						   port->up_hasd);
+	}
+}
+
+static u16 pci_lmr_port_sts(struct pci_lmr_port *port)
+{
+	u16 sts;
+
+	if (pci_read_config_word(port->dev, port->cap + PCI_LMR_PORT_STS, &sts))
+		return (u16)PCI_ERROR_RESPONSE;
+
+	return sts;
+}
+
+static int pci_lmr_wait_ready(struct pci_lmr_port *port)
+{
+	u16 sts;
+	int ret;
+
+	ret = read_poll_timeout(pci_lmr_port_sts, sts,
+				PCI_POSSIBLE_ERROR(sts) ||
+				(sts & PCI_LMR_PORT_STS_MARGIN_READY),
+				LMR_POLL_US, LMR_TIMEOUT_US, false, port);
+	if (PCI_POSSIBLE_ERROR(sts))
+		return -ENODEV;
+
+	return ret;
+}
+
+/* Read the link state the session depends on, from the Downstream Port */
+static int pci_lmr_read_link(struct pci_lmr_port *port)
+{
+	struct pci_dev *dp = pci_lmr_dp(port);
+	u16 lnksta, lnksta2;
+
+	if (pcie_capability_read_word(dp, PCI_EXP_LNKSTA, &lnksta) ||
+	    pcie_capability_read_word(dp, PCI_EXP_LNKSTA2, &lnksta2) ||
+	    PCI_POSSIBLE_ERROR(lnksta) || PCI_POSSIBLE_ERROR(lnksta2))
+		return -ENODEV;
+
+	if (!FIELD_GET(PCI_EXP_LNKSTA_NLW, lnksta))
+		return -ENOLINK;
+
+	/* Lane Margining at the Receiver is defined for 16.0 GT/s and up */
+	if ((lnksta & PCI_EXP_LNKSTA_CLS) < PCI_EXP_LNKSTA_CLS_16_0GB)
+		return -EOPNOTSUPP;
+
+	port->lnksta = lnksta & (PCI_EXP_LNKSTA_CLS | PCI_EXP_LNKSTA_NLW);
+	port->retimers = !!(lnksta2 & PCI_EXP_LNKSTA2_RETIMER) +
+			 !!(lnksta2 & PCI_EXP_LNKSTA2_2RETIMERS);
+
+	return 0;
+}
+
+/*
+ * Find the device at the other end of the link and take a reference.
+ * On the Downstream Port side that is Function 0 on the secondary bus.
+ * The bus is looked up on the parent's list of child buses instead of
+ * through ->subordinate, which is cleared only after the bus has been
+ * removed from that list.
+ */
+static struct pci_dev *pci_lmr_find_partner(struct pci_lmr_port *port)
+{
+	struct pci_dev *dev = port->dev, *partner = NULL, *pdev;
+	struct pci_bus *bus;
+
+	if (!port->downstream)
+		return pci_dev_get(port->dport);
+
+	guard(rwsem_read)(&pci_bus_sem);
+	list_for_each_entry(bus, &dev->bus->children, node) {
+		if (bus->self != dev)
+			continue;
+		list_for_each_entry(pdev, &bus->devices, bus_list) {
+			if (pdev->devfn == 0) {
+				partner = pci_dev_get(pdev);
+				break;
+			}
+		}
+		break;
+	}
+
+	return partner;
+}
+
+/* Set up both ends of the link for margining */
+static int pci_lmr_setup(struct pci_lmr_port *port)
+{
+	u16 cap, sts;
+	int ret;
+
+	ret = pci_lmr_read_link(port);
+	if (ret)
+		return ret;
+
+	if (pci_read_config_word(port->dev, port->cap + PCI_LMR_PORT_CAP,
+				 &cap) ||
+	    pci_read_config_word(port->dev, port->cap + PCI_LMR_PORT_STS,
+				 &sts) ||
+	    PCI_POSSIBLE_ERROR(cap) || PCI_POSSIBLE_ERROR(sts))
+		return -ENODEV;
+
+	if ((cap & PCI_LMR_PORT_CAP_USES_SW_READY) &&
+	    !(sts & PCI_LMR_PORT_STS_SW_READY))
+		return -ETIMEDOUT;
+
+	ret = pci_lmr_aspm_off(port);
+	if (ret)
+		return ret;
+
+	ret = pci_lmr_autonomous_off(port);
+	if (ret)
+		goto aspm;
+
+	ret = pci_lmr_wait_ready(port);
+	if (ret)
+		goto autonomous;
+
+	return 0;
+
+autonomous:
+	pci_lmr_autonomous_restore(port);
+aspm:
+	pci_lmr_aspm_restore(port);
+	return ret;
+}
+
+static void pci_lmr_set_active(struct pci_lmr_port *port, bool active)
+{
+	lockdep_assert_held(&port->lock);
+	lockdep_assert_held(&pci_lmr_mutex);
+
+	port->active = active;
+}
+
+static int pci_lmr_activate(struct pci_lmr_port *port, struct pci_dev *partner)
+{
+	struct pci_lmr_port *p;
+	int ret;
+
+	guard(mutex)(&port->lock);
+
+	scoped_guard(mutex, &pci_lmr_mutex) {
+		if (pci_lmr_rebooting || port->active)
+			return -EBUSY;
+
+		list_for_each_entry(p, &pci_lmr_ports, node)
+			if (p->dport == port->dport && p->active)
+				return -EBUSY;
+
+		if (!pci_dev_is_added(port->dev) || !pci_dev_is_added(partner))
+			return -ENODEV;
+	}
+
+	port->partner = partner;
+	port->receiver = pci_lmr_default_rx(port);
+	port->pm_gen = atomic_read(&pci_lmr_pm_gen);
+	pci_lmr_forget_rx(port);
+
+	ret = pci_lmr_setup(port);
+	if (ret) {
+		port->partner = NULL;
+		return ret;
+	}
+
+	/*
+	 * Removal clears the added flag before pci_destroy_dev() calls
+	 * pci_lmr_exit().  Checking both flags under pci_lmr_mutex when
+	 * marking the session active guarantees that pci_lmr_exit() will
+	 * see the session if removal starts afterwards.
+	 */
+	scoped_guard(mutex, &pci_lmr_mutex) {
+		if (pci_lmr_rebooting)
+			ret = -EBUSY;
+		else if (!pci_dev_is_added(port->dev) ||
+			 !pci_dev_is_added(partner))
+			ret = -ENODEV;
+		else
+			pci_lmr_set_active(port, true);
+	}
+	if (!ret)
+		return 0;
+
+	pci_lmr_autonomous_restore(port);
+	if (pci_dev_is_added(port->dev) && pci_dev_is_added(partner))
+		pci_lmr_aspm_restore(port);
+	port->partner = NULL;
+	return ret;
+}
+
+static int pci_lmr_start(struct pci_lmr_port *port)
+{
+	struct pci_dev *partner, *dp, *up;
+	int ret;
+
+	partner = pci_lmr_find_partner(port);
+	if (!partner)
+		return -ENODEV;
+
+	dp = port->downstream ? port->dev : partner;
+	up = port->downstream ? partner : port->dev;
+
+	ret = pm_runtime_resume_and_get(&dp->dev);
+	if (ret)
+		goto put_partner;
+	ret = pm_runtime_resume_and_get(&up->dev);
+	if (ret)
+		goto put_dp;
+
+	/*
+	 * Probe, remove and reset hold the device lock and may wait for a
+	 * lock taken further down this path, so never wait for it here.
+	 */
+	ret = -EBUSY;
+	if (!pci_dev_trylock(dp))
+		goto put_up;
+	if (!pci_dev_trylock(up))
+		goto unlock_dp;
+
+	ret = pci_lmr_activate(port, partner);
+	if (ret)
+		goto unlock;
+
+	pci_dev_unlock(up);
+	pci_dev_unlock(dp);
+
+	/* The session keeps the partner reference and runtime PM usage */
+	return 0;
+
+unlock:
+	pci_dev_unlock(up);
+unlock_dp:
+	pci_dev_unlock(dp);
+put_up:
+	pm_runtime_put_sync(&up->dev);
+put_dp:
+	pm_runtime_put_sync(&dp->dev);
+put_partner:
+	pci_dev_put(partner);
+	return ret;
+}
+
+/*
+ * End the session on @port and return its partner, whose reference and
+ * runtime PM usage the caller drops.  When one end of the link is being
+ * removed, the ASPM state of the link is left alone: the link state is
+ * about to be freed.
+ */
+static struct pci_dev *pci_lmr_teardown(struct pci_lmr_port *port)
+{
+	struct pci_dev *partner = port->partner;
+	bool removing;
+
+	lockdep_assert_held(&port->lock);
+
+	if (!port->active)
+		return NULL;
+
+	removing = !pci_dev_is_added(port->dev) || !pci_dev_is_added(partner);
+
+	if (!pci_dev_is_disconnected(port->dev))
+		pci_lmr_reset_lanes(port);
+	pci_lmr_autonomous_restore(port);
+	if (!removing)
+		pci_lmr_aspm_restore(port);
+
+	pci_lmr_forget_rx(port);
+	scoped_guard(mutex, &pci_lmr_mutex) {
+		port->partner = NULL;
+		pci_lmr_set_active(port, false);
+	}
+
+	return partner;
+}
+
+static void pci_lmr_release(struct pci_lmr_port *port, struct pci_dev *partner)
+{
+	pm_runtime_put_sync(&partner->dev);
+	pm_runtime_put_sync(&port->dev->dev);
+	pci_dev_put(partner);
+}
+
+static int pci_lmr_stop(struct pci_lmr_port *port)
+{
+	struct pci_dev *ended;
+
+	scoped_guard(mutex, &port->lock)
+		ended = pci_lmr_teardown(port);
+	if (ended)
+		pci_lmr_release(port, ended);
+
+	return 0;
+}
+
+static void pci_lmr_port_free(struct kref *kref)
+{
+	struct pci_lmr_port *port = container_of(kref, struct pci_lmr_port, kref);
+
+	pci_dev_put(port->dport);
+	pci_dev_put(port->dev);
+	mutex_destroy(&port->lock);
+	kfree(port);
+}
+
+static void pci_lmr_port_put(struct pci_lmr_port *port)
+{
+	kref_put(&port->kref, pci_lmr_port_free);
+}
+
+static struct pci_lmr_port *pci_lmr_find_port(struct pci_dev *dev)
+{
+	struct pci_lmr_port *port;
+
+	lockdep_assert_held(&pci_lmr_mutex);
+
+	list_for_each_entry(port, &pci_lmr_ports, node)
+		if (port->dev == dev)
+			return port;
+
+	return NULL;
+}
+
+/*
+ * Find an active session, involving @dev at either end of its link or
+ * on any port if @dev is NULL, and return its port with a reference.
+ */
+static struct pci_lmr_port *pci_lmr_find_session(struct pci_dev *dev)
+{
+	struct pci_lmr_port *port;
+
+	lockdep_assert_held(&pci_lmr_mutex);
+
+	list_for_each_entry(port, &pci_lmr_ports, node) {
+		if (!port->active)
+			continue;
+		if (!dev || port->dev == dev || port->partner == dev) {
+			kref_get(&port->kref);
+			return port;
+		}
+	}
+
+	return NULL;
+}
+
+static void pci_lmr_end_sessions(struct pci_dev *dev)
+{
+	struct pci_lmr_port *p;
+	struct pci_dev *ended;
+
+	for (;;) {
+		scoped_guard(mutex, &pci_lmr_mutex)
+			p = pci_lmr_find_session(dev);
+		if (!p)
+			break;
+
+		scoped_guard(mutex, &p->lock)
+			ended = pci_lmr_teardown(p);
+		if (ended)
+			pci_lmr_release(p, ended);
+		pci_lmr_port_put(p);
+	}
+}
+
+/**
+ * pci_lmr_exit - End margining on a device that is being removed
+ * @dev: PCI device
+ *
+ * Called from pci_destroy_dev() for every device.  Removes the debugfs
+ * directory of @dev, waiting for file operations in progress, and ends
+ * every session that involves @dev, whichever end of the link hosts it.
+ */
+void pci_lmr_exit(struct pci_dev *dev)
+{
+	struct pci_lmr_port *port;
+
+	scoped_guard(mutex, &pci_lmr_mutex)
+		port = pci_lmr_find_port(dev);
+
+	if (port)
+		debugfs_remove(port->dir);
+
+	pci_lmr_end_sessions(dev);
+
+	if (!port)
+		return;
+
+	scoped_guard(mutex, &pci_lmr_mutex)
+		list_del(&port->node);
+	pci_lmr_port_put(port);
+}
+
+static int enable_show(struct seq_file *s, void *unused)
+{
+	struct pci_lmr_port *port = s->private;
+
+	guard(mutex)(&port->lock);
+	seq_printf(s, "%d\n", port->active);
+
+	return 0;
+}
+
+static ssize_t enable_write(struct file *file, const char __user *ubuf,
+			    size_t count, loff_t *ppos)
+{
+	struct seq_file *s = file->private_data;
+	struct pci_lmr_port *port = s->private;
+	bool enable;
+	int ret;
+
+	ret = kstrtobool_from_user(ubuf, count, &enable);
+	if (ret)
+		return ret;
+
+	if (enable) {
+		scoped_guard(mutex, &port->lock)
+			if (port->active)
+				return count;
+		ret = pci_lmr_start(port);
+	} else {
+		ret = pci_lmr_stop(port);
+	}
+
+	return ret ?: count;
+}
+DEFINE_SHOW_STORE_ATTRIBUTE(enable);
+
+static int receiver_show(struct seq_file *s, void *unused)
+{
+	struct pci_lmr_port *port = s->private;
+
+	guard(mutex)(&port->lock);
+	seq_printf(s, "%u\n", port->active ? port->receiver :
+		   pci_lmr_default_rx(port));
+
+	return 0;
+}
+
+static bool pci_lmr_rx_valid(struct pci_lmr_port *port, u8 rx)
+{
+	if (!port->downstream)
+		return rx == LMR_RX_UP;
+
+	/* Each retimer has two receivers, numbered from 2 */
+	return rx >= LMR_RX_DP && rx <= LMR_RX_DP + 2 * port->retimers;
+}
+
+static ssize_t receiver_write(struct file *file, const char __user *ubuf,
+			      size_t count, loff_t *ppos)
+{
+	struct seq_file *s = file->private_data;
+	struct pci_lmr_port *port = s->private;
+	u8 rx;
+	int ret;
+
+	ret = kstrtou8_from_user(ubuf, count, 10, &rx);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&port->lock);
+
+	ret = pci_lmr_check(port);
+	if (ret)
+		return ret;
+
+	if (!pci_lmr_rx_valid(port, rx))
+		return -EINVAL;
+
+	if (rx == port->receiver)
+		return count;
+
+	/* Leave no lane margined by the old receiver */
+	ret = pci_lmr_reset_lanes(port);
+	if (ret)
+		return ret;
+
+	pci_lmr_forget_rx(port);
+	port->receiver = rx;
+
+	return count;
+}
+DEFINE_SHOW_STORE_ATTRIBUTE(receiver);
+
+static int port_show(struct seq_file *s, void *unused)
+{
+	struct pci_lmr_port *port = s->private;
+	struct pci_dev *dev = port->dev;
+	u16 cap, sts;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(&dev->dev);
+	if (ret)
+		return ret;
+
+	if (pci_read_config_word(dev, port->cap + PCI_LMR_PORT_CAP, &cap) ||
+	    pci_read_config_word(dev, port->cap + PCI_LMR_PORT_STS, &sts) ||
+	    PCI_POSSIBLE_ERROR(cap) || PCI_POSSIBLE_ERROR(sts))
+		ret = -ENODEV;
+
+	pm_runtime_put(&dev->dev);
+	if (ret)
+		return ret;
+
+	seq_printf(s, "uses_driver_software: %d\n",
+		   !!(cap & PCI_LMR_PORT_CAP_USES_SW_READY));
+	seq_printf(s, "margining_ready: %d\n",
+		   !!(sts & PCI_LMR_PORT_STS_MARGIN_READY));
+	seq_printf(s, "software_ready: %d\n",
+		   !!(sts & PCI_LMR_PORT_STS_SW_READY));
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(port);
+
+static int caps_show(struct seq_file *s, void *unused)
+{
+	struct pci_lmr_lane *l = s->private;
+	struct pci_lmr_port *port = l->port;
+	struct pci_lmr_rx *rx = &l->rx;
+	int ret;
+
+	guard(mutex)(&port->lock);
+
+	ret = pci_lmr_check(port);
+	if (ret)
+		return ret;
+
+	ret = pci_lmr_get_rx(l);
+	if (ret)
+		return ret;
+
+	seq_printf(s, "receiver: %u\n", port->receiver);
+	seq_printf(s, "capabilities: %#04x\n", rx->caps);
+	seq_printf(s, "voltage_supported: %d\n",
+		   !!(rx->caps & LMR_CAP_VOLTAGE));
+	seq_printf(s, "independent_up_down_voltage: %d\n",
+		   !!(rx->caps & LMR_CAP_IND_UP_DOWN));
+	seq_printf(s, "independent_left_right_timing: %d\n",
+		   !!(rx->caps & LMR_CAP_IND_LEFT_RIGHT));
+	seq_printf(s, "sample_reporting_method: %s\n",
+		   rx->caps & LMR_CAP_SAMPLE_RATE ? "rate" : "count");
+	seq_printf(s, "independent_error_sampler: %d\n",
+		   !!(rx->caps & LMR_CAP_IND_ERR_SAMPLER));
+	seq_printf(s, "timing_steps: %u\n", rx->timing_steps);
+	seq_printf(s, "max_timing_offset: %u\n", rx->max_timing_offset);
+	seq_printf(s, "voltage_steps: %u\n", rx->voltage_steps);
+	seq_printf(s, "max_voltage_offset: %u\n", rx->max_voltage_offset);
+	seq_printf(s, "max_lanes: %u\n", rx->max_lanes);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(caps);
+
+static ssize_t pci_lmr_step_write(struct file *file, const char __user *ubuf,
+				  size_t count, bool timing)
+{
+	struct seq_file *s = file->private_data;
+	struct pci_lmr_lane *l = s->private;
+	int steps, ret;
+
+	ret = kstrtoint_from_user(ubuf, count, 10, &steps);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&l->port->lock);
+
+	ret = pci_lmr_step(l, timing, steps);
+
+	return ret ?: count;
+}
+
+static int margin_timing_show(struct seq_file *s, void *unused)
+{
+	struct pci_lmr_lane *l = s->private;
+
+	guard(mutex)(&l->port->lock);
+	seq_printf(s, "%d\n", l->timing);
+
+	return 0;
+}
+
+static ssize_t margin_timing_write(struct file *file, const char __user *ubuf,
+				   size_t count, loff_t *ppos)
+{
+	return pci_lmr_step_write(file, ubuf, count, true);
+}
+DEFINE_SHOW_STORE_ATTRIBUTE(margin_timing);
+
+static int margin_voltage_show(struct seq_file *s, void *unused)
+{
+	struct pci_lmr_lane *l = s->private;
+
+	guard(mutex)(&l->port->lock);
+	seq_printf(s, "%d\n", l->voltage);
+
+	return 0;
+}
+
+static ssize_t margin_voltage_write(struct file *file, const char __user *ubuf,
+				    size_t count, loff_t *ppos)
+{
+	return pci_lmr_step_write(file, ubuf, count, false);
+}
+DEFINE_SHOW_STORE_ATTRIBUTE(margin_voltage);
+
+static const char * const pci_lmr_step_status[] = {
+	[LMR_STEP_TOO_MANY_ERR]	= "too_many_errors",
+	[LMR_STEP_SETUP]	= "setup",
+	[LMR_STEP_MARGINING]	= "margining",
+	[LMR_STEP_NAK]		= "nak",
+};
+
+/* Show the receiver's response to the last step command, if any */
+static int status_show(struct seq_file *s, void *unused)
+{
+	struct pci_lmr_lane *l = s->private;
+	struct pci_lmr_port *port = l->port;
+	u8 type, payload;
+	u16 sts;
+
+	guard(mutex)(&port->lock);
+
+	if (!port->active)
+		return -ENOTCONN;
+
+	if (atomic_read(&pci_lmr_pm_gen) != port->pm_gen)
+		return -EIO;
+
+	sts = pci_lmr_lane_sts(port, l->lane);
+	if (PCI_POSSIBLE_ERROR(sts))
+		return -ENODEV;
+
+	type = FIELD_GET(PCI_LMR_LANE_TYPE, sts);
+	payload = FIELD_GET(PCI_LMR_LANE_PAYLOAD, sts);
+	if (FIELD_GET(PCI_LMR_LANE_RX, sts) != port->receiver ||
+	    (type != LMR_TYPE_TIMING && type != LMR_TYPE_VOLTAGE)) {
+		seq_puts(s, "idle\n");
+		return 0;
+	}
+
+	seq_printf(s, "%s %s %u\n",
+		   type == LMR_TYPE_TIMING ? "timing" : "voltage",
+		   pci_lmr_step_status[FIELD_GET(LMR_STEP_STATUS, payload)],
+		   (unsigned int)FIELD_GET(LMR_STEP_ERR_COUNT, payload));
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(status);
+
+static void pci_lmr_debugfs_init(struct pci_lmr_port *port)
+{
+	char name[32];
+	unsigned int i;
+
+	snprintf(name, sizeof(name), "pcie_lmr_%s", pci_name(port->dev));
+	port->dir = debugfs_create_dir(name, NULL);
+
+	debugfs_create_file("enable", 0600, port->dir, port, &enable_fops);
+	debugfs_create_file("receiver", 0600, port->dir, port, &receiver_fops);
+	debugfs_create_file("port", 0400, port->dir, port, &port_fops);
+
+	for (i = 0; i < port->nr_lanes; i++) {
+		struct pci_lmr_lane *l = &port->lanes[i];
+		struct dentry *dir;
+
+		snprintf(name, sizeof(name), "lane%u", i);
+		dir = debugfs_create_dir(name, port->dir);
+
+		debugfs_create_file("caps", 0400, dir, l, &caps_fops);
+		debugfs_create_file("margin_timing", 0600, dir, l,
+				    &margin_timing_fops);
+		debugfs_create_file("margin_voltage", 0600, dir, l,
+				    &margin_voltage_fops);
+		debugfs_create_file("status", 0400, dir, l, &status_fops);
+	}
+}
+
+/**
+ * pci_lmr_init - Set up margining for a device that has the capability
+ * @dev: PCI device
+ *
+ * The capability is used on Downstream Ports and on Function 0 of the
+ * device below a Downstream Port.
+ */
+void pci_lmr_init(struct pci_dev *dev)
+{
+	struct pci_lmr_port *port;
+	struct pci_dev *dport;
+	unsigned int i, width;
+	u32 lnkcap;
+	u16 cap;
+
+	if (!pci_is_pcie(dev) || dev->is_virtfn)
+		return;
+
+	if (pcie_downstream_port(dev)) {
+		dport = dev;
+	} else {
+		if (dev->devfn != 0)
+			return;
+		dport = pci_upstream_bridge(dev);
+		if (!dport || !pci_is_pcie(dport) ||
+		    !pcie_downstream_port(dport))
+			return;
+	}
+
+	cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_LMR);
+	if (!cap)
+		return;
+
+	if (pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap))
+		return;
+
+	width = FIELD_GET(PCI_EXP_LNKCAP_MLW, lnkcap);
+	if (!width || width > LMR_MAX_WIDTH)
+		return;
+
+	port = kzalloc(struct_size(port, lanes, width), GFP_KERNEL);
+	if (!port)
+		return;
+
+	port->nr_lanes = width;
+	kref_init(&port->kref);
+	port->dev = pci_dev_get(dev);
+	port->dport = pci_dev_get(dport);
+	port->cap = cap;
+	port->downstream = dport == dev;
+	mutex_init(&port->lock);
+	for (i = 0; i < width; i++) {
+		port->lanes[i].port = port;
+		port->lanes[i].lane = i;
+	}
+
+	pci_lmr_debugfs_init(port);
+
+	guard(mutex)(&pci_lmr_mutex);
+	list_add_tail(&port->node, &pci_lmr_ports);
+}
+
+/*
+ * Receivers lose their margining state over system suspend.  Commands
+ * on a session that was active before a suspend fail with -EIO, and the
+ * session has to be stopped and started again.
+ */
+static int pci_lmr_pm_notify(struct notifier_block *nb, unsigned long action,
+			     void *data)
+{
+	switch (action) {
+	case PM_SUSPEND_PREPARE:
+	case PM_HIBERNATION_PREPARE:
+	case PM_POST_SUSPEND:
+	case PM_POST_HIBERNATION:
+	case PM_POST_RESTORE:
+		atomic_inc(&pci_lmr_pm_gen);
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block pci_lmr_pm_nb = {
+	.notifier_call = pci_lmr_pm_notify,
+};
+
+/* End active margining sessions before reboot or kexec */
+static int pci_lmr_reboot_notify(struct notifier_block *nb,
+				 unsigned long action, void *data)
+{
+	scoped_guard(mutex, &pci_lmr_mutex)
+		pci_lmr_rebooting = true;
+
+	pci_lmr_end_sessions(NULL);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block pci_lmr_reboot_nb = {
+	.notifier_call = pci_lmr_reboot_notify,
+};
+
+static int __init pci_lmr_pm_init(void)
+{
+	register_reboot_notifier(&pci_lmr_reboot_nb);
+	return register_pm_notifier(&pci_lmr_pm_nb);
+}
+late_initcall(pci_lmr_pm_init);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 24be091e424a..f087ac6346d8 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2681,6 +2681,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_rebar_init(dev);		/* Resizable BAR */
 	pci_dev3_init(dev);		/* Device 3 capabilities */
 	pci_ide_init(dev);		/* Link Integrity and Data Encryption */
+	pci_lmr_init(dev);		/* Lane Margining at the Receiver */
 
 	pcie_report_downtraining(dev);
 	pci_init_reset_methods(dev);
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index e711ac1d4e38..c858386beff3 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -37,6 +37,7 @@ static void pci_destroy_dev(struct pci_dev *dev)
 	platform_pci_remove_wake(dev);
 	pci_doe_sysfs_teardown(dev);
 	pci_npem_remove(dev);
+	pci_lmr_exit(dev);
 
 	/*
 	 * While device is in D0 drop the device from TSM link operations
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index facaa324bd86..47daa1cebe0e 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -711,6 +711,8 @@
 #define  PCI_EXP_LNKCTL2_TX_MARGIN	0x0380 /* Transmit Margin */
 #define  PCI_EXP_LNKCTL2_HASD		0x0020 /* HW Autonomous Speed Disable */
 #define PCI_EXP_LNKSTA2		0x32	/* Link Status 2 */
+#define  PCI_EXP_LNKSTA2_RETIMER	0x0040 /* Retimer Presence Detected */
+#define  PCI_EXP_LNKSTA2_2RETIMERS	0x0080 /* Two Retimers Presence Detected */
 #define  PCI_EXP_LNKSTA2_FLIT		0x0400 /* Flit Mode Status */
 #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	0x34	/* end of v2 EPs w/ link */
 #define PCI_EXP_SLTCAP2		0x34	/* Slot Capabilities 2 */
@@ -757,6 +759,7 @@
 #define PCI_EXT_CAP_ID_VF_REBAR 0x24	/* VF Resizable BAR */
 #define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
 #define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer 16.0 GT/s */
+#define PCI_EXT_CAP_ID_LMR	0x27	/* Lane Margining at the Receiver */
 #define PCI_EXT_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management */
 #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
 #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
@@ -1181,6 +1184,21 @@
 #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_MASK		0x000000F0
 #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_SHIFT	4
 
+/* Lane Margining at the Receiver */
+#define PCI_LMR_PORT_CAP		0x04	/* Port Capabilities */
+#define  PCI_LMR_PORT_CAP_USES_SW_READY	0x0001	/* Uses Driver Software */
+#define PCI_LMR_PORT_STS		0x06	/* Port Status */
+#define  PCI_LMR_PORT_STS_MARGIN_READY	0x0001	/* Margining Ready */
+#define  PCI_LMR_PORT_STS_SW_READY	0x0002	/* Margining Software Ready */
+#define PCI_LMR_LANE_CTRL		0x08	/* Lane Control, lane 0 */
+#define PCI_LMR_LANE_STS		0x0a	/* Lane Status, lane 0 */
+#define PCI_LMR_LANE_STRIDE		4	/* Lane N at +4*N */
+/* Fields of both Margining Lane Control and Margining Lane Status */
+#define  PCI_LMR_LANE_RX		0x0007	/* Receiver Number */
+#define  PCI_LMR_LANE_TYPE		0x0038	/* Margin Type */
+#define  PCI_LMR_LANE_USAGE		0x0040	/* Usage Model */
+#define  PCI_LMR_LANE_PAYLOAD		0xff00	/* Margin Payload */
+
 /* Physical Layer 32.0 GT/s */
 #define PCI_PL_32GT_LE_CTRL	0x20	/* Lane Equalization Control Register */
 

-- 
2.56.0.385.gd3acb90ef8-goog

