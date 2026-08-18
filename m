Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFA730498E
	for <linux-pci@vger.kernel.org>; Tue, 18 Aug 2026 21:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787088028; cv=none; b=SVk9zmuJuepNbgpFoiVwHK0X4pR/m9luNp47zUtDh5Y2TvGks1HyA77fPz01rd2gLeJt1CeWnWqN1t2XshdBLGdV+urHwC925KNhRyCdd/dddQk2yiPSRTu5rVtfTgwhH5bPcSKxhAUTmRDOfMP8tTEWBS4c6LrIB797YPkPQKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787088028; c=relaxed/simple;
	bh=pW9Qs9aUS1h8cFLtZnYHdUf3p6jTvzA5apcgMyWBzzk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DYXFM3LKWdydUu2ODWmA81wL8M3eYtSvgI78uXeYz5meQSmw3pEM4BUkaYdQDqZH40j8Giu65XwamMHP4MUiyulZiJSgig1Orzpp/vDm2gSmQWDi/JPjC4vO7OdNr+DxqeiZwdhbTeWRYoLbTUYBYut5PLYAP9bJkQouO2YYjVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v0ubOIOo; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v0ubOIOo"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d55d8cd938so4659755ad.1
        for <linux-pci@vger.kernel.org>; Tue, 18 Aug 2026 14:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787088025; x=1787692825; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cVftKQgWVV3P+kSdkxoDei8sWP4x+M/B27WDdsVWEhQ=;
        b=v0ubOIOouHmdazo7RWtcPn2LcmgwJ5JXpRiPiriZm2J3jErwfrxOF5UCRFEq67sUeY
         s09eiy9JVN0Ybf2qrMFY504vCfxTUOyQWI8BNTBWqznsDNpvoGTnlfJ7P6c3A6Y9qP2Y
         6OoRGAks1PhXBEE9sS5BJcJkoHvNk026JAfWIol7usW7kgxGl2ENo5H5dA3qKl2Jv/QC
         M6dbSHG/kV9xU6bfNO8IwK+gJb2V4rCXFAEGa+fDNGe3gRagxtczXAu/lKXI+UJ3+4tC
         WlSyNN6xwla4MKKx95VTlDwIv/fRWoOufC+HpYY4+vAiZo05U7ZR0l0px5qnYLs7sM/T
         SRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787088025; x=1787692825;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cVftKQgWVV3P+kSdkxoDei8sWP4x+M/B27WDdsVWEhQ=;
        b=Fi/xxOap486UyOlVavDgknLqt4TEv0dT3rX7sdr/ho1ZPnhJwe8JhM18SNlVrWSm12
         2+MQhN+QXte/7fFoPBG4MBSG+aa1cA0qj0YXhtu3+fuZLstY2h8offUCaJccouXueQaV
         HJea/9ALHY04TNS6C2geaXjVWgtlqJ+iDd43NvTW5EQ4lo+EKau9jgY2GoQIuZ8X9Hrt
         skvRKyk41TDwUy9UPilUhM9I0Dxhj3Pp7cfAtYda+2v0u1qcg+gAoSFQeTbIVGUToNFG
         k0mj2f1f/jVvu4iSzvvkcZjjb/t1W7kk0wYUA7EcZXMiQlrUIkOGdNQwVFtI/SStSYQI
         99SQ==
X-Forwarded-Encrypted: i=1; AHgh+RqeFEnX62bSt03ZLLuxsZvKQT1Iw2b2prisvYCLKDlblIJgpKgpuYmqe5jcWNHTqi/zihWqi2jeG+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhIF7UtwStC4RTMcBEev1SaMCiU6ZTJ1v/nbMP3ygBWjyCfc3L
	pfQUUQ5Fe9I4au3b4xOxomn3zkq47KtrbgfDfwoMzP6RFOyQWt08qxbnQaV/qe2HR2BNjtUcd4y
	6Z+Lmx6D0t85f9/deicWvrWelypPVPk+1uQ==
X-Received: from pllw5.prod.google.com ([2002:a17:902:7b85:b0:2ca:c162:e758])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ec82:b0:2ca:e19c:97b with SMTP id d9443c01a7336-2d5f6a5ba01mr12863705ad.5.1787088024698;
 Tue, 18 Aug 2026 14:20:24 -0700 (PDT)
Date: Tue, 18 Aug 2026 21:20:24 +0000
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
Message-ID: <20260818-pcie-lmt-v4-1-eb17a6d755fa@google.com>
Subject: [PATCH v4] PCI/pcie: Add PCIe Lane Margining at Receiver (LMR) support
From: Priyank Rathod <rathodpriyank@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Priyank Rathod <rathodpriyank@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

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
Per PCIe Base Specification r6.0, section 8.4.4 ("Lane Margining at Receive=
r"),
PCIe devices operating at 16.0 GT/s (Gen 4) or higher data rates support th=
e
Lane Margining at Receiver Extended Capability (ID 0x27), and it is mandato=
ry
for receivers operating at 64.0 GT/s (Gen 6) or higher data rates.

Lane Margining allows system software to evaluate high-speed link signal
integrity and margins by measuring timing and voltage steps for each physic=
al
lane and receiver independently.

This series introduces kernel driver support, debugfs controls, and a
kselftest automation script for PCIe Lane Margining at Receiver (LMR/LMT).

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
1. How to Enable & Configure
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
Enable the Kconfig option under PCI support:
  CONFIG_PCIE_LMR=3Dy (or =3Dm)
  (Depends on CONFIG_PCI and CONFIG_DEBUG_FS)

Upon boot or device hotplug on Gen4+ links (>=3D 16.0 GT/s), the driver pro=
bes
Extended Capability ID 0x27 and exposes per-device debugfs interfaces:
  /sys/kernel/debug/pci/pcie_lmr_<domain>:<bus>:<dev>.<func>/

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
2. How to Use the Debugfs Interface (Manual Margining)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
Inspect device-wide margining capabilities and port status:
  # Inspect root device LMR capabilities & status
  cat /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/capabilities
  cat /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/port_status

Enable active Lane Margining on the device:
  # Enable Lane Margining state machine
  echo 1 > /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/enable

Inspect and step individual lanes (e.g. lane0):
  # Select target receiver (0 =3D local receiver, 1..6 =3D retimers/link pa=
rtners)
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

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
3. How to Run Automated Kselftests Using the Test Script
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
An automated kselftest script is included to test capability reads, receive=
r
selection, and margining commands across all enumerated LMR devices:

  # Run directly as root
  sudo ./tools/testing/selftests/pcie_lmt/pcie_lmt.sh

Or run via the kselftest Makefile harness:
  make -C tools/testing/selftests TARGETS=3Dpcie_lmt run_tests

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

Changes in v4:
  - Added Sample Multiple Receivers (Bit 5) concurrency verification in mar=
gin_lane_timing_write() and margin_lane_voltage_write() per PCIe r6.0 sec 8=
.4.4, returning -EBUSY if another lane on the same receiver is already marg=
ined when simultaneous lane margining is not supported.
  - Added active operating link speed verification (PCI_EXP_LNKSTA_CLS >=3D=
 16.0 GT/s) in margin_enable_write() before enabling LMR, as LMR commands a=
re physically undefined on links operating at Gen1/Gen2/Gen3 speeds.
  - Added fast-path hardware NAK detection in pci_lmr_run_cmd() to return -=
EOPNOTSUPP immediately if a receiver echoes MTYPE =3D=3D NO_CMD (0x7) after=
 command issuance rather than waiting 150ms for a timeout.
  - Added pci_reset_lmr() hooked into __pci_reset_function_locked() to sync=
hronize software state and demargin on FLR or Secondary Bus Reset.
  - Comprehensive NULL pointer checks and array/lane/receiver bounds checks=
 added across all internal helpers and debugfs write handlers.

Changes in v2:
  - Fixed NO_CMD (0x7) clearing in pci_lmr_run_cmd() before issuing new com=
mands per PCIe r6.0 sec 8.4.4.
  - Protected plane->rx updates with mdev->lock in margin_lane_receiver_wri=
te().
  - Corrected Margining Port Capabilities bit definition to PCI_LMR_PORT_CA=
P_USES_SW_READY (0x0001) in <uapi/linux/pci_regs.h>.
  - Updated kselftest script (pcie_lmt.sh) to locate LMR debugfs entries.
  - Validated integer bounds against LMR_MAX_TIMING_STEP / LMR_MAX_VOLTAGE_=
STEP before narrowing u8 cast.
  - Moved mdev->enabled checks inside mutex_lock(&mdev->lock) to eliminate =
TOCTOU races.
  - Checked return values of all pci_read_config_word() calls, propagating =
-EIO on failure.
  - Eliminated dead store of cap in margin_enable_write().
  - Explicitly checked speed =3D=3D PCIE_SPEED_64_0GT in pci_lmr_init() to =
avoid misidentifying PCI_SPEED_UNKNOWN (0xFF) as Gen6.
---
 drivers/pci/pci-driver.c                     |   1 +
 drivers/pci/pci.c                            |   4 +-
 drivers/pci/pci.h                            |  12 +
 drivers/pci/pcie/Kconfig                     |  12 +
 drivers/pci/pcie/Makefile                    |   1 +
 drivers/pci/pcie/margin.c                    | 957 +++++++++++++++++++++++=
++++
 drivers/pci/probe.c                          |   1 +
 drivers/pci/remove.c                         |   1 +
 include/linux/pci.h                          |   6 +
 include/uapi/linux/pci_regs.h                |  18 +
 tools/testing/selftests/Makefile             |   1 +
 tools/testing/selftests/pcie_lmt/Makefile    |   3 +
 tools/testing/selftests/pcie_lmt/pcie_lmt.sh | 105 +++
 13 files changed, 1121 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index f36778e62ac1..17544a7023fc 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -821,6 +821,7 @@ static int pci_pm_suspend(struct device *dev)
 	 * since Coffee Lake, to enter a lower-power PM state.
 	 */
 	pci_suspend_ptm(pci_dev);
+	pci_suspend_lmr(pci_dev);
=20
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_suspend(dev, PMSG_SUSPEND);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 77b17b13ee61..dc9724cb7b4d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5145,8 +5145,10 @@ int __pci_reset_function_locked(struct pci_dev *dev)
 		method =3D &pci_reset_fn_methods[m];
 		pci_dbg(dev, "reset via %s\n", method->name);
 		rc =3D method->reset_fn(dev, PCI_RESET_DO_RESET);
-		if (!rc)
+		if (!rc) {
+			pci_reset_lmr(dev);
 			return 0;
+		}
=20
 		pci_dbg(dev, "%s failed with %d\n", method->name, rc);
 		if (rc !=3D -ENOTTY)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4469e1a77f3c..6322a81f9e50 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1023,6 +1023,18 @@ static inline void pci_no_tph(void) { }
 static inline void pci_tph_init(struct pci_dev *dev) { }
 #endif
=20
+#ifdef CONFIG_PCIE_LMR
+void pci_lmr_init(struct pci_dev *dev);
+void pci_lmr_exit(struct pci_dev *dev);
+void pci_suspend_lmr(struct pci_dev *dev);
+void pci_reset_lmr(struct pci_dev *dev);
+#else
+static inline void pci_lmr_init(struct pci_dev *dev) { }
+static inline void pci_lmr_exit(struct pci_dev *dev) { }
+static inline void pci_suspend_lmr(struct pci_dev *dev) { }
+static inline void pci_reset_lmr(struct pci_dev *dev) { }
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
=20
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
@@ -13,4 +13,5 @@ obj-$(CONFIG_PCIEAER_INJECT)	+=3D aer_inject.o
 obj-$(CONFIG_PCIE_PME)		+=3D pme.o
 obj-$(CONFIG_PCIE_DPC)		+=3D dpc.o
 obj-$(CONFIG_PCIE_PTM)		+=3D ptm.o
+obj-$(CONFIG_PCIE_LMR)		+=3D margin.o
 obj-$(CONFIG_PCIE_EDR)		+=3D edr.o
diff --git a/drivers/pci/pcie/margin.c b/drivers/pci/pcie/margin.c
new file mode 100644
index 000000000000..e9e195744d5a
--- /dev/null
+++ b/drivers/pci/pcie/margin.c
@@ -0,0 +1,957 @@
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
+ *   - Probing Extended Capability ID 0x27 and Margining Port Capabilities=
.
+ *   - Managing ASPM L0s/L1 link states during active margining per spec.
+ *   - PCIe r6.0 NO_CMD (0x7) clearing handshake per receiver and lane.
+ *   - Caching receiver capabilities & step counts to avoid DEMARGIN side-=
effects.
+ *   - Handling Symmetric vs Independent Left/Right & Up/Down margin steps=
.
+ *   - Exposing per-device debugfs interfaces under /sys/kernel/debug/pci/=
.
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
+		pci_debugfs_root_dir =3D debugfs_lookup("pci", NULL);
+	if (!pci_debugfs_root_dir)
+		pci_debugfs_root_dir =3D debugfs_create_dir("pci", NULL);
+	return pci_debugfs_root_dir;
+}
+#endif
+
+/*
+ * pci_lmr_run_cmd() - Issue LMR command to Lane Control and wait for Stat=
us.
+ * Must be called with mdev->lock held.
+ */
+static int pci_lmr_run_cmd(struct pci_dev *dev, int lane, u8 rx, u8 type,
+			   u8 usage, u8 payload, u16 *status_val)
+{
+	u16 lmr, ctrl_offset, sts_offset;
+	u16 ctrl, sts;
+	unsigned long timeout;
+
+	if (!dev || !dev->lmr || lane < 0 || lane >=3D dev->lmr->num_lanes ||
+	    rx > LMR_MAX_RX_NUM)
+		return -EINVAL;
+
+	lmr =3D dev->lmr_cap;
+	ctrl_offset =3D lmr + PCI_LMR_LANE_CTRL + LMR_LANE_REG_STRIDE * lane;
+	sts_offset =3D lmr + PCI_LMR_LANE_STS + LMR_LANE_REG_STRIDE * lane;
+
+	/*
+	 * Per PCIe Base Spec r6.0 sec 8.4.4, software must issue NO_CMD (0x7)
+	 * targeting the specific receiver (rx) to clear MTYPE in Lane Status
+	 * before issuing a subsequent command.
+	 */
+	if (type !=3D LMR_TYPE_NO_CMD) {
+		ctrl =3D FIELD_PREP(PCI_LMR_LANE_CTRL_RX_NUM, rx) |
+		       FIELD_PREP(PCI_LMR_LANE_CTRL_MTYPE, LMR_TYPE_NO_CMD) |
+		       FIELD_PREP(PCI_LMR_LANE_CTRL_USAGE, 0) |
+		       FIELD_PREP(PCI_LMR_LANE_CTRL_PAYLOAD, 0);
+
+		pci_write_config_word(dev, ctrl_offset, ctrl);
+
+		timeout =3D jiffies + msecs_to_jiffies(LMR_CMD_TIMEOUT_MS);
+		while (1) {
+			if (pci_read_config_word(dev, sts_offset, &sts))
+				return -EIO;
+			if (sts =3D=3D 0xFFFF)
+				return -ENODEV;
+			if (FIELD_GET(PCI_LMR_LANE_STS_MTYPE, sts) =3D=3D LMR_TYPE_NO_CMD &&
+			    FIELD_GET(PCI_LMR_LANE_STS_RX_NUM, sts) =3D=3D rx)
+				break;
+			if (time_after(jiffies, timeout))
+				return -ETIMEDOUT;
+			usleep_range(LMR_CMD_SLEEP_MIN_US, LMR_CMD_SLEEP_MAX_US);
+		}
+	}
+
+	ctrl =3D FIELD_PREP(PCI_LMR_LANE_CTRL_RX_NUM, rx) |
+	       FIELD_PREP(PCI_LMR_LANE_CTRL_MTYPE, type) |
+	       FIELD_PREP(PCI_LMR_LANE_CTRL_USAGE, usage) |
+	       FIELD_PREP(PCI_LMR_LANE_CTRL_PAYLOAD, payload);
+
+	pci_write_config_word(dev, ctrl_offset, ctrl);
+
+	timeout =3D jiffies + msecs_to_jiffies(LMR_CMD_TIMEOUT_MS);
+	while (1) {
+		if (pci_read_config_word(dev, sts_offset, &sts))
+			return -EIO;
+		if (sts =3D=3D 0xFFFF)
+			return -ENODEV;
+
+		if (FIELD_GET(PCI_LMR_LANE_STS_MTYPE, sts) =3D=3D type &&
+		    FIELD_GET(PCI_LMR_LANE_STS_RX_NUM, sts) =3D=3D rx) {
+			if (status_val)
+				*status_val =3D sts;
+			return 0;
+		}
+
+		/*
+		 * Per PCIe Base Spec r6.0 sec 8.4.4, if receiver echoes NO_CMD (0x7)
+		 * after a command was sent, it indicates command rejection/NAK.
+		 */
+		if (FIELD_GET(PCI_LMR_LANE_STS_MTYPE, sts) =3D=3D LMR_TYPE_NO_CMD &&
+		    FIELD_GET(PCI_LMR_LANE_STS_RX_NUM, sts) =3D=3D rx)
+			return -EOPNOTSUPP;
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
+	if (!plane || !plane->mdev)
+		return -EINVAL;
+
+	if (plane->timing_val =3D=3D 0 && plane->voltage_val =3D=3D 0)
+		return 0;
+
+	ret =3D pci_lmr_run_cmd(plane->mdev->dev, plane->lane, plane->rx,
+			      LMR_TYPE_DEMARGIN, 0, 0, &sts);
+	if (!ret) {
+		plane->timing_val =3D 0;
+		plane->voltage_val =3D 0;
+	}
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
+	info =3D &plane->rx_info[rx];
+
+	if (info->caps_cached)
+		return 0;
+
+	/* Issuing REPORT_CAPS aborts any active margin per PCIe spec */
+	pci_lmr_demargin_lane(plane);
+
+	ret =3D pci_lmr_run_cmd(plane->mdev->dev, plane->lane, rx,
+			      LMR_TYPE_REPORT_CAPS, 0, 0, &sts);
+	if (ret)
+		return ret;
+	info->caps =3D FIELD_GET(PCI_LMR_LANE_STS_PAYLOAD, sts);
+
+	ret =3D pci_lmr_run_cmd(plane->mdev->dev, plane->lane, rx,
+			      LMR_TYPE_REPORT_TIMING_STEPS, 0, 0, &sts);
+	if (ret)
+		return ret;
+	info->num_timing_steps =3D FIELD_GET(PCI_LMR_LANE_STS_PAYLOAD, sts) & LMR=
_STEPS_MASK;
+
+	ret =3D pci_lmr_run_cmd(plane->mdev->dev, plane->lane, rx,
+			      LMR_TYPE_REPORT_VOLTAGE_STEPS, 0, 0, &sts);
+	if (ret)
+		return ret;
+	info->num_voltage_steps =3D FIELD_GET(PCI_LMR_LANE_STS_PAYLOAD, sts) & LM=
R_STEPS_MASK;
+
+	info->caps_cached =3D true;
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+
+static int margin_caps_show(struct seq_file *s, void *v)
+{
+	struct pci_margin_dev *mdev =3D s->private;
+	struct pci_dev *dev =3D mdev->dev;
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
+	struct pci_margin_dev *mdev =3D s->private;
+	struct pci_dev *dev =3D mdev->dev;
+	u16 sts;
+
+	if (pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &sts))
+		return -EIO;
+	seq_printf(s, "Port Status: %#06x\n", sts);
+	seq_printf(s, "  Margining Ready: %s\n",
+		   (sts & PCI_LMR_PORT_STS_MARGIN_READY) ? "yes" : "no");
+	seq_printf(s, "  SW Ready: %s\n", (sts & PCI_LMR_PORT_STS_SW_READY) ? "ye=
s" : "no");
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(margin_port_status);
+
+static int margin_enable_show(struct seq_file *s, void *v)
+{
+	struct pci_margin_dev *mdev =3D s->private;
+	bool enabled;
+
+	mutex_lock(&mdev->lock);
+	enabled =3D mdev->enabled;
+	mutex_unlock(&mdev->lock);
+
+	seq_printf(s, "%d\n", enabled);
+	return 0;
+}
+
+static ssize_t margin_enable_write(struct file *file, const char __user *u=
ser_buf,
+			       size_t count, loff_t *ppos)
+{
+	struct pci_margin_dev *mdev =3D ((struct seq_file *)file->private_data)->=
private;
+	struct pci_dev *dev =3D mdev->dev;
+	unsigned long timeout;
+	bool enable;
+	int ret, i;
+	u16 sts, cap;
+
+	ret =3D kstrtobool_from_user(user_buf, count, &enable);
+	if (ret)
+		return ret;
+
+	mutex_lock(&mdev->lock);
+
+	if (mdev->enabled =3D=3D enable)
+		goto out;
+
+	if (enable) {
+		u16 lnksta;
+
+		/* PCIe r6.0 sec 8.4.4: LMR is physically undefined below 16.0 GT/s (Gen=
4) */
+		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
+		if ((lnksta & PCI_EXP_LNKSTA_CLS) < PCI_EXP_LNKSTA_CLS_16_0GB) {
+			ret =3D -EOPNOTSUPP;
+			goto out;
+		}
+
+		if (pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_CAP, &cap)) {
+			ret =3D -EIO;
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
+				ret =3D -EIO;
+				goto out;
+			}
+			sts |=3D PCI_LMR_PORT_STS_SW_READY;
+			pci_write_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, sts);
+		}
+
+		timeout =3D jiffies + msecs_to_jiffies(LMR_ENABLE_TIMEOUT_MS);
+		while (1) {
+			if (pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &sts)) {
+				ret =3D -EIO;
+				goto out;
+			}
+			if (sts =3D=3D 0xFFFF) {
+				ret =3D -ENODEV;
+				goto out;
+			}
+			if (sts & PCI_LMR_PORT_STS_MARGIN_READY)
+				break;
+			if (time_after(jiffies, timeout)) {
+				ret =3D -ETIMEDOUT;
+				if (cap & PCI_LMR_PORT_CAP_USES_SW_READY) {
+					sts &=3D ~PCI_LMR_PORT_STS_SW_READY;
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
+		for (i =3D 0; i < mdev->num_lanes; i++) {
+			mdev->lanes[i].rx =3D LMR_RX_LOCAL;
+			pci_lmr_cache_rx_info(&mdev->lanes[i], LMR_RX_LOCAL);
+		}
+		mdev->enabled =3D true;
+	} else {
+		/* Demargin all lanes before clearing SW_READY */
+		for (i =3D 0; i < mdev->num_lanes; i++)
+			pci_lmr_demargin_lane(&mdev->lanes[i]);
+
+		if (pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &sts) =3D=3D=
 0) {
+			sts &=3D ~PCI_LMR_PORT_STS_SW_READY;
+			pci_write_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, sts);
+		}
+		mdev->enabled =3D false;
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
+static const struct file_operations margin_enable_fops =3D {
+	.open =3D margin_enable_open,
+	.read =3D seq_read,
+	.write =3D margin_enable_write,
+	.llseek =3D seq_lseek,
+	.release =3D single_release,
+};
+
+static int margin_lane_receiver_show(struct seq_file *s, void *v)
+{
+	struct pci_margin_lane *plane =3D s->private;
+	int rx;
+
+	mutex_lock(&plane->mdev->lock);
+	rx =3D plane->rx;
+	mutex_unlock(&plane->mdev->lock);
+
+	seq_printf(s, "%d\n", rx);
+	return 0;
+}
+
+static ssize_t margin_lane_receiver_write(struct file *file, const char __=
user *user_buf,
+				      size_t count, loff_t *ppos)
+{
+	struct pci_margin_lane *plane =3D ((struct seq_file *)file->private_data)=
->private;
+	struct pci_margin_dev *mdev =3D plane->mdev;
+	int ret;
+	int rx;
+
+	ret =3D kstrtoint_from_user(user_buf, count, 0, &rx);
+	if (ret)
+		return ret;
+
+	if (rx < 0 || rx > LMR_MAX_RX_NUM)
+		return -EINVAL;
+
+	mutex_lock(&mdev->lock);
+	if (plane->rx =3D=3D rx)
+		goto out;
+
+	if (mdev->enabled) {
+		/* Demargin previous receiver per single-receiver spec rule */
+		pci_lmr_demargin_lane(plane);
+		ret =3D pci_lmr_cache_rx_info(plane, rx);
+		if (ret)
+			goto out;
+	}
+
+	plane->rx =3D rx;
+out:
+	mutex_unlock(&mdev->lock);
+	return ret ? ret : count;
+}
+
+static int margin_lane_receiver_open(struct inode *inode, struct file *fil=
e)
+{
+	return single_open(file, margin_lane_receiver_show, inode->i_private);
+}
+
+static const struct file_operations margin_lane_receiver_fops =3D {
+	.open =3D margin_lane_receiver_open,
+	.read =3D seq_read,
+	.write =3D margin_lane_receiver_write,
+	.llseek =3D seq_lseek,
+	.release =3D single_release,
+};
+
+static int margin_lane_caps_show(struct seq_file *s, void *v)
+{
+	struct pci_margin_lane *plane =3D s->private;
+	struct pci_margin_dev *mdev =3D plane->mdev;
+	struct pci_margin_rx_info *info;
+	int ret =3D 0;
+	u8 val;
+
+	mutex_lock(&mdev->lock);
+	if (!mdev->enabled) {
+		ret =3D -EACCES;
+		goto out;
+	}
+
+	ret =3D pci_lmr_cache_rx_info(plane, plane->rx);
+	if (ret)
+		goto out;
+
+	info =3D &plane->rx_info[plane->rx];
+	val =3D info->caps;
+	seq_printf(s, "Lane %d Rx %d Capabilities: %#02x\n", plane->lane, plane->=
rx, val);
+	seq_printf(s, "  Margining H/V: %s\n", (val & LMR_CAP_MARGIN_HV) ? "both"=
 : "either");
+	seq_printf(s, "  Margining eV/iV: %s\n",
+		   (val & LMR_CAP_MARGIN_EV_IV) ? "both (close & open)" : "one (close on=
ly)");
+	seq_printf(s, "  Left/Right: %s\n", (val & LMR_CAP_IND_LEFT_RIGHT_TIMING)=
 ? "both" : "one");
+	seq_printf(s, "  Up/Down: %s\n", (val & LMR_CAP_IND_UP_DOWN_VOLTAGE) ? "b=
oth" : "one");
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
+	struct pci_margin_lane *plane =3D s->private;
+	struct pci_margin_dev *mdev =3D plane->mdev;
+	struct pci_margin_rx_info *info;
+	int ret =3D 0;
+
+	mutex_lock(&mdev->lock);
+	if (!mdev->enabled) {
+		ret =3D -EACCES;
+		goto out;
+	}
+
+	ret =3D pci_lmr_cache_rx_info(plane, plane->rx);
+	if (!ret) {
+		info =3D &plane->rx_info[plane->rx];
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
+	struct pci_margin_lane *plane =3D s->private;
+	struct pci_margin_dev *mdev =3D plane->mdev;
+	struct pci_margin_rx_info *info;
+	int ret =3D 0;
+
+	mutex_lock(&mdev->lock);
+	if (!mdev->enabled) {
+		ret =3D -EACCES;
+		goto out;
+	}
+
+	ret =3D pci_lmr_cache_rx_info(plane, plane->rx);
+	if (!ret) {
+		info =3D &plane->rx_info[plane->rx];
+		seq_printf(s, "%d\n", info->num_voltage_steps);
+	}
+out:
+	mutex_unlock(&mdev->lock);
+	return ret;
+}
+DEFINE_SHOW_ATTRIBUTE(margin_lane_voltage_steps);
+
+static bool pci_lmr_check_sample_multiple_rx(struct pci_margin_dev *mdev,
+					     struct pci_margin_lane *plane)
+{
+	struct pci_margin_rx_info *info =3D &plane->rx_info[plane->rx];
+	int i;
+
+	if (info->caps & LMR_CAP_SAMPLE_MULTIPLE_RX)
+		return true;
+
+	for (i =3D 0; i < mdev->num_lanes; i++) {
+		struct pci_margin_lane *other =3D &mdev->lanes[i];
+
+		if (i =3D=3D plane->lane)
+			continue;
+		if (other->rx =3D=3D plane->rx &&
+		    (other->timing_val !=3D 0 || other->voltage_val !=3D 0))
+			return false;
+	}
+	return true;
+}
+
+static ssize_t margin_lane_timing_write(struct file *file, const char __us=
er *user_buf,
+				    size_t count, loff_t *ppos)
+{
+	struct pci_margin_lane *plane =3D ((struct seq_file *)file->private_data)=
->private;
+	struct pci_margin_dev *mdev =3D plane->mdev;
+	struct pci_margin_rx_info *info;
+	int val, ret;
+	u8 step, dir;
+	u16 sts;
+	u8 caps;
+
+	ret =3D kstrtoint_from_user(user_buf, count, 0, &val);
+	if (ret)
+		return ret;
+
+	if (val > LMR_MAX_TIMING_STEP || val < -LMR_MAX_TIMING_STEP)
+		return -EINVAL;
+
+	mutex_lock(&mdev->lock);
+	if (!mdev->enabled) {
+		ret =3D -EACCES;
+		goto out;
+	}
+
+	if (val =3D=3D 0) {
+		ret =3D pci_lmr_demargin_lane(plane);
+		goto out;
+	}
+
+	ret =3D pci_lmr_cache_rx_info(plane, plane->rx);
+	if (ret)
+		goto out;
+
+	if (!pci_lmr_check_sample_multiple_rx(mdev, plane)) {
+		ret =3D -EBUSY;
+		goto out;
+	}
+
+	info =3D &plane->rx_info[plane->rx];
+	caps =3D info->caps;
+
+	if (val < 0) {
+		step =3D -val;
+		if (!(caps & LMR_CAP_IND_LEFT_RIGHT_TIMING)) {
+			/* Symmetric margining requires dir=3D1 per spec */
+			ret =3D -EINVAL;
+			goto out;
+		}
+		dir =3D LMR_STEP_DIR_DECREASE;
+	} else {
+		step =3D val;
+		dir =3D LMR_STEP_DIR_INCREASE;
+	}
+
+	if (step > info->num_timing_steps) {
+		ret =3D -EINVAL;
+		goto out;
+	}
+
+	ret =3D pci_lmr_run_cmd(mdev->dev, plane->lane, plane->rx,
+			      LMR_TYPE_TIMING, 0,
+			      (step & LMR_TIMING_STEP_MASK) | (dir << LMR_TIMING_DIR_SHIFT), &s=
ts);
+	if (ret)
+		goto out;
+
+	/* Record actual step count applied by hardware */
+	step =3D FIELD_GET(PCI_LMR_LANE_STS_PAYLOAD, sts) & LMR_TIMING_STEP_MASK;
+	plane->timing_val =3D (dir =3D=3D LMR_STEP_DIR_DECREASE) ? -step : step;
+
+out:
+	mutex_unlock(&mdev->lock);
+	return ret ? ret : count;
+}
+
+static int margin_lane_timing_show(struct seq_file *s, void *v)
+{
+	struct pci_margin_lane *plane =3D s->private;
+	int timing_val;
+
+	mutex_lock(&plane->mdev->lock);
+	timing_val =3D plane->timing_val;
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
+static const struct file_operations margin_lane_timing_fops =3D {
+	.open =3D margin_lane_timing_open,
+	.read =3D seq_read,
+	.write =3D margin_lane_timing_write,
+	.llseek =3D seq_lseek,
+	.release =3D single_release,
+};
+
+static ssize_t margin_lane_voltage_write(struct file *file, const char __u=
ser *user_buf,
+				     size_t count, loff_t *ppos)
+{
+	struct pci_margin_lane *plane =3D ((struct seq_file *)file->private_data)=
->private;
+	struct pci_margin_dev *mdev =3D plane->mdev;
+	struct pci_margin_rx_info *info;
+	int val, ret;
+	u8 step, dir;
+	u16 sts;
+	u8 caps;
+
+	ret =3D kstrtoint_from_user(user_buf, count, 0, &val);
+	if (ret)
+		return ret;
+
+	if (val > LMR_MAX_VOLTAGE_STEP || val < -LMR_MAX_VOLTAGE_STEP)
+		return -EINVAL;
+
+	mutex_lock(&mdev->lock);
+	if (!mdev->enabled) {
+		ret =3D -EACCES;
+		goto out;
+	}
+
+	if (val =3D=3D 0) {
+		ret =3D pci_lmr_demargin_lane(plane);
+		goto out;
+	}
+
+	ret =3D pci_lmr_cache_rx_info(plane, plane->rx);
+	if (ret)
+		goto out;
+
+	if (!pci_lmr_check_sample_multiple_rx(mdev, plane)) {
+		ret =3D -EBUSY;
+		goto out;
+	}
+
+	info =3D &plane->rx_info[plane->rx];
+	caps =3D info->caps;
+
+	if (val < 0) {
+		step =3D -val;
+		if (!(caps & LMR_CAP_IND_UP_DOWN_VOLTAGE)) {
+			/* Symmetric voltage margining requires dir=3D1 per spec */
+			ret =3D -EINVAL;
+			goto out;
+		}
+		dir =3D 0;
+	} else {
+		step =3D val;
+		dir =3D 1;
+	}
+
+	if (step > info->num_voltage_steps) {
+		ret =3D -EINVAL;
+		goto out;
+	}
+
+	ret =3D pci_lmr_run_cmd(mdev->dev, plane->lane, plane->rx,
+			      LMR_TYPE_VOLTAGE, 0,
+			      (step & LMR_VOLTAGE_STEP_MASK) |
+			      (dir << LMR_VOLTAGE_DIR_SHIFT), &sts);
+	if (ret)
+		goto out;
+
+	step =3D FIELD_GET(PCI_LMR_LANE_STS_PAYLOAD, sts) & LMR_VOLTAGE_STEP_MASK=
;
+	plane->voltage_val =3D (dir =3D=3D 0) ? -step : step;
+
+out:
+	mutex_unlock(&mdev->lock);
+	return ret ? ret : count;
+}
+
+static int margin_lane_voltage_show(struct seq_file *s, void *v)
+{
+	struct pci_margin_lane *plane =3D s->private;
+	int voltage_val;
+
+	mutex_lock(&plane->mdev->lock);
+	voltage_val =3D plane->voltage_val;
+	mutex_unlock(&plane->mdev->lock);
+
+	seq_printf(s, "%d\n", voltage_val);
+	return 0;
+}
+
+static int margin_lane_voltage_open(struct inode *inode, struct file *file=
)
+{
+	return single_open(file, margin_lane_voltage_show, inode->i_private);
+}
+
+static const struct file_operations margin_lane_voltage_fops =3D {
+	.open =3D margin_lane_voltage_open,
+	.read =3D seq_read,
+	.write =3D margin_lane_voltage_write,
+	.llseek =3D seq_lseek,
+	.release =3D single_release,
+};
+
+static void pci_margin_debugfs_init(struct pci_margin_dev *mdev)
+{
+	struct pci_dev *dev =3D mdev->dev;
+	struct dentry *parent;
+	char dirname[64];
+	int i;
+
+	parent =3D get_pci_debugfs_root();
+	snprintf(dirname, sizeof(dirname), "pcie_lmr_%s", dev_name(&dev->dev));
+	mdev->debugfs =3D debugfs_create_dir(dirname, parent);
+	if (!mdev->debugfs)
+		return;
+
+	debugfs_create_file("capabilities", 0444, mdev->debugfs, mdev, &margin_ca=
ps_fops);
+	debugfs_create_file("port_status", 0444, mdev->debugfs, mdev, &margin_por=
t_status_fops);
+	debugfs_create_file("enable", 0644, mdev->debugfs, mdev, &margin_enable_f=
ops);
+
+	for (i =3D 0; i < mdev->num_lanes; i++) {
+		struct pci_margin_lane *plane =3D &mdev->lanes[i];
+		struct dentry *lane_dir;
+		char lane_name[16];
+
+		snprintf(lane_name, sizeof(lane_name), "lane%d", i);
+		lane_dir =3D debugfs_create_dir(lane_name, mdev->debugfs);
+		if (!lane_dir)
+			continue;
+
+		debugfs_create_file("receiver", 0644, lane_dir, plane, &margin_lane_rece=
iver_fops);
+		debugfs_create_file("caps", 0444, lane_dir, plane, &margin_lane_caps_fop=
s);
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
+static inline void pci_margin_debugfs_init(struct pci_margin_dev *mdev) { =
}
+static inline void pci_margin_debugfs_remove(struct pci_margin_dev *mdev) =
{ }
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
+	speed =3D pcie_get_speed_cap(dev);
+
+	lmr =3D pci_find_ext_capability(dev, PCI_EXT_CAP_ID_LMR);
+	if (!lmr) {
+		if (speed =3D=3D PCIE_SPEED_64_0GT)
+			pci_warn(dev,
+				 "Missing Lane Margining at Receiver Capability (mandatory for Gen6+)\=
n");
+		else if (speed >=3D PCIE_SPEED_16_0GT && speed !=3D PCI_SPEED_UNKNOWN)
+			pci_dbg(dev,
+				"Optional Lane Margining at Receiver Capability not found\n");
+		return;
+	}
+
+	if (speed < PCIE_SPEED_16_0GT && speed !=3D PCI_SPEED_UNKNOWN)
+		return;
+
+	dev->lmr_cap =3D lmr;
+
+	mdev =3D kzalloc_obj(*mdev, GFP_KERNEL);
+	if (!mdev)
+		return;
+
+	mdev->dev =3D dev;
+	mdev->cap =3D lmr;
+	mutex_init(&mdev->lock);
+
+	pcie_capability_read_word(dev, PCI_EXP_LNKCAP, &lnkcap);
+	mdev->num_lanes =3D FIELD_GET(PCI_EXP_LNKCAP_MLW, lnkcap);
+
+	if (mdev->num_lanes =3D=3D 0 || mdev->num_lanes > LMR_MAX_LANES) {
+		pci_warn(dev, "Invalid link width %d for LMR\n", mdev->num_lanes);
+		goto err_free_mdev;
+	}
+
+	mdev->lanes =3D kcalloc(mdev->num_lanes, sizeof(*mdev->lanes), GFP_KERNEL=
);
+	if (!mdev->lanes)
+		goto err_free_mdev;
+
+	for (i =3D 0; i < mdev->num_lanes; i++) {
+		mdev->lanes[i].mdev =3D mdev;
+		mdev->lanes[i].lane =3D i;
+		mdev->lanes[i].rx =3D LMR_RX_LOCAL;
+	}
+
+	pci_margin_debugfs_init(mdev);
+
+	dev->lmr =3D mdev;
+
+	pci_info(dev, "Lane Margining at Receiver (Gen%u) Capability detected\n",
+		 speed =3D=3D PCIE_SPEED_64_0GT ? LMR_GEN6 :
+		 speed =3D=3D PCIE_SPEED_32_0GT ? LMR_GEN5 :
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
+	struct pci_margin_dev *mdev =3D dev->lmr;
+	int i;
+
+	if (!mdev)
+		return;
+
+	mutex_lock(&mdev->lock);
+	if (mdev->enabled) {
+		for (i =3D 0; i < mdev->num_lanes; i++)
+			pci_lmr_demargin_lane(&mdev->lanes[i]);
+	}
+	mutex_unlock(&mdev->lock);
+
+	pci_margin_debugfs_remove(mdev);
+	mutex_destroy(&mdev->lock);
+	kfree(mdev->lanes);
+	kfree(mdev);
+	dev->lmr =3D NULL;
+}
+
+void pci_suspend_lmr(struct pci_dev *dev)
+{
+	struct pci_margin_dev *mdev =3D dev->lmr;
+	int i;
+	u16 sts;
+
+	if (!mdev)
+		return;
+
+	mutex_lock(&mdev->lock);
+	if (mdev->enabled) {
+		for (i =3D 0; i < mdev->num_lanes; i++)
+			pci_lmr_demargin_lane(&mdev->lanes[i]);
+
+		if (pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &sts) =3D=3D=
 0) {
+			sts &=3D ~PCI_LMR_PORT_STS_SW_READY;
+			pci_write_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, sts);
+		}
+		mdev->enabled =3D false;
+	}
+	mutex_unlock(&mdev->lock);
+}
+
+void pci_reset_lmr(struct pci_dev *dev)
+{
+	pci_suspend_lmr(dev);
+}
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index dd0abbc63e18..352b95568ebf 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2666,6 +2666,7 @@ static void pci_init_capabilities(struct pci_dev *dev=
)
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
=20
 	pci_doe_sysfs_teardown(dev);
 	pci_npem_remove(dev);
+	pci_lmr_exit(dev);
=20
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
=20
+/* Lane Margining at Receiver */
+#define PCI_LMR_PORT_CAP		0x04	/* Margining Port Capabilities */
+#define  PCI_LMR_PORT_CAP_USES_SW_READY	0x0001	/* Margining Uses Software =
Ready */
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
=20
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Mak=
efile
index 8a4b6ddc68df..6990d999388a 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -91,6 +91,7 @@ TARGETS +=3D net/tcp_ao
 TARGETS +=3D nolibc
 TARGETS +=3D pci_endpoint
 TARGETS +=3D pcie_bwctrl
+TARGETS +=3D pcie_lmt
 TARGETS +=3D perf_events
 TARGETS +=3D pidfd
 TARGETS +=3D pid_namespace
diff --git a/tools/testing/selftests/pcie_lmt/Makefile b/tools/testing/self=
tests/pcie_lmt/Makefile
new file mode 100644
index 000000000000..36ac85937d78
--- /dev/null
+++ b/tools/testing/selftests/pcie_lmt/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+TEST_PROGS =3D pcie_lmt.sh
+include ../lib.mk
diff --git a/tools/testing/selftests/pcie_lmt/pcie_lmt.sh b/tools/testing/s=
elftests/pcie_lmt/pcie_lmt.sh
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
+TESTNAME=3D"pcie_lmt"
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=3D4
+retval=3D0
+skipmsg=3D"skip all tests:"
+
+if [ $UID !=3D 0 ]; then
+	echo "$skipmsg must be run as root" >&2
+	exit $ksft_skip
+fi
+
+DEBUGFS=3D$(mount -t debugfs | head -1 | awk '{ print $3 }')
+if [ -z "$DEBUGFS" ]; then
+	if [ -d "/sys/kernel/debug" ]; then
+		DEBUGFS=3D"/sys/kernel/debug"
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
+LMR_DEVS=3D$(ls -d $DEBUGFS/pci/pcie_lmr_* $DEBUGFS/pcie_lmr_* 2>/dev/null=
 || true)
+if [ -z "$LMR_DEVS" ]; then
+	echo "$skipmsg no PCIe LMR devices found in $DEBUGFS/" >&2
+	exit $ksft_skip
+fi
+
+cleanup_dev()
+{
+	local dev=3D"$1"
+	echo 0 > "$dev/enable" 2>/dev/null || true
+}
+
+echo "$TESTNAME: testing PCIe LMR debugfs entries"
+
+for dev in $LMR_DEVS; do
+	dev_name=3D$(basename "$dev")
+	echo "$TESTNAME: probing device $dev_name"
+
+	if [ ! -r "$dev/capabilities" ] || [ ! -r "$dev/port_status" ] ||
+	   [ ! -r "$dev/enable" ] || [ ! -w "$dev/enable" ]; then
+		echo "$TESTNAME: $dev_name missing mandatory root attributes"
+		retval=3D1
+		continue
+	fi
+
+	caps=3D$(cat "$dev/capabilities")
+	status=3D$(cat "$dev/port_status")
+	echo "  $dev_name: capabilities read OK"
+	echo "  $dev_name: port_status read OK"
+
+	trap 'cleanup_dev "$dev"' EXIT
+
+	if ! echo 1 > "$dev/enable" 2>/dev/null; then
+		echo "  $dev_name: margining not ready by hardware (skipping active lane=
s)"
+		continue
+	fi
+
+	echo "  $dev_name: margining enabled OK"
+
+	for lane_dir in $(ls -d "$dev"/lane* 2>/dev/null || true); do
+		lane=3D$(basename "$lane_dir")
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
--=20
Priyank Rathod <rathodpriyank@google.com>
