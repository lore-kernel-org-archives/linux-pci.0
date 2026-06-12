Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41B1272816;
	Fri, 12 Jun 2026 01:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781227771; cv=none; b=beYqrre4T7Z1Iw6JI54v/dWf9mexgPfXJVz4uGnJanoc64krSjFlwYjaGpXOnHv+Rxu++TBwkf1qlc9Y4cVLzCVyFe+cttpfNewVLVkQe00oIMQFocQFzNWue6ewNfR8XoG2rPwUWqwKCppXy+DBHfNAx43Xoy6KcuwbMj8MDlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781227771; c=relaxed/simple;
	bh=Idl2qeP8tXLjPiTx8vGfl5Px9g3Q5WcrL+Av4/+yGQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gG3JK/ejjOrpnfxnL4VvbcormxyqR1iEE+XVsVtykKu7pV0ryEVwg+jCPWaozsVU1MQlNeo9utuXcSZm125ltI3IV1Cf6RpfhOcgBecsYMN9AVYAVG6T1C7nBvp2SKPT0STFkVbPCvLA9Sfy8GNByxNRcVjaJFSkvDiAnb3vMgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iue+a0aK; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iue+a0aK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781227769; x=1812763769;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Idl2qeP8tXLjPiTx8vGfl5Px9g3Q5WcrL+Av4/+yGQA=;
  b=iue+a0aKj3BsZ7fFuQ8PculfilXEWgjfiJReUSy0+Gt9/NFDP2D63Brr
   +iK6glrIBwF5ywdwhT/zl+KK4fMsoCAud585I5tE91hGR/oNf2cnpdBFR
   YNcsnBZks6omqIyyZYItXAE753DK4/BKTgNCdEdc7D/eIUoTAiBPHhROK
   MpRRKwimjW8+C/EVfBdo1jaoWGVBslEslubrGHjpzxuPewE6Y9/zSQ2gT
   dSHg2GL7QwqzlL7tPm/jfTd0iAPIohwRAaKAsOx8q14QBl/x7om7HZW5w
   /eGLoEohRlhVGpTtgJiaFwmrO1WjWskV8wDawqf2Q1xpQ72iMqHHWja31
   Q==;
X-CSE-ConnectionGUID: Xhxb5K4kTYmlYQHZ6eFDag==
X-CSE-MsgGUID: M6UIqABLSnuzyIjMiVMy8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="93165721"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="93165721"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 18:29:28 -0700
X-CSE-ConnectionGUID: AZ7a3nFgRXuW9omm2EpXqg==
X-CSE-MsgGUID: SLPWeGkOQ2uDf+QMX0IoFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="251767089"
Received: from weba0957.iind.intel.com (HELO WEBA0932.iind.intel.com) ([10.224.186.34])
  by fmviesa005.fm.intel.com with ESMTP; 11 Jun 2026 18:29:24 -0700
From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-pci@vger.kernel.org,
	bhelgaas@google.com,
	ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Subject: [PATCH v1 1/2] Bluetooth: hci_core: Add reset_type parameter to hdev->reset() callback
Date: Fri, 12 Jun 2026 06:58:29 +0530
Message-ID: <20260612012832.2395034-1-chandrashekar.devegowda@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a u8 reset_type parameter to the hdev->reset() callback to allow
userspace to select the reset method via sysfs. Writing 1 to
/sys/class/bluetooth/hci0/reset triggers a Product Level Device
Reset (PLDR), while any other value triggers a Function Level Reset
(FLR).

The reset_type values are:
  0 - Function Level Reset (FLR)
  1 - Product Level Device Reset (PLDR)

Internal callers (command timeout, suspend/resume, coredump)
default to FLR (0).

All drivers implementing the reset callback are updated to accept
the new parameter:
  - btusb: btusb_intel_reset, btusb_qca_reset, btusb_rtl_reset
  - hci_qca: qca_reset
  - btmtksdio: btmtksdio_reset
  - btmtk: btmtk_reset_sync
  - btnxpuart: nxp_reset
  - btintel_pcie: btintel_pcie_reset (maps to Intel PRR types)

Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
---
 Documentation/ABI/stable/sysfs-class-bluetooth |  6 +++++-
 drivers/bluetooth/btintel_pcie.c               | 17 +++++++++++------
 drivers/bluetooth/btmtk.c                      |  6 +++---
 drivers/bluetooth/btmtk.h                      |  4 ++--
 drivers/bluetooth/btmtksdio.c                  |  2 +-
 drivers/bluetooth/btnxpuart.c                  |  2 +-
 drivers/bluetooth/btusb.c                      |  6 +++---
 drivers/bluetooth/hci_qca.c                    |  2 +-
 include/net/bluetooth/hci_core.h               |  2 +-
 net/bluetooth/hci_core.c                       |  2 +-
 net/bluetooth/hci_sysfs.c                      | 10 ++++++++--
 11 files changed, 37 insertions(+), 22 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-class-bluetooth b/Documentation/ABI/stable/sysfs-class-bluetooth
index 36be02471174..8f485fa02a47 100644
--- a/Documentation/ABI/stable/sysfs-class-bluetooth
+++ b/Documentation/ABI/stable/sysfs-class-bluetooth
@@ -3,7 +3,11 @@ Date:		14-Jan-2025
 KernelVersion:	6.13
 Contact:	linux-bluetooth@vger.kernel.org
 Description: 	This write-only attribute allows users to trigger the vendor reset
-		method on the Bluetooth device when arbitrary data is written.
+		method on the Bluetooth device. The value written selects the
+		reset type:
+		  0 - Function Level Reset (FLR)
+		  1 - Product Level Device Reset (PLDR)
+		Writing any value other than 1 defaults to FLR.
 		The reset may or may not be done through the device transport
 		(e.g., UART/USB), and can also be done through an out-of-band
 		approach such as GPIO.
diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 9e39327dc1fe..d3a03cf96421 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2486,7 +2486,7 @@ static void btintel_pcie_inc_recovery_count(struct pci_dev *pdev,
 }
 
 static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data);
-static void btintel_pcie_reset(struct hci_dev *hdev);
+static void btintel_pcie_reset(struct hci_dev *hdev, u8 reset_type);
 
 static int btintel_pcie_acpi_reset_method(struct btintel_pcie_data *data)
 {
@@ -2680,7 +2680,7 @@ static void btintel_pcie_reset_work(struct work_struct *wk)
 	pci_unlock_rescan_remove();
 }
 
-static void btintel_pcie_reset(struct hci_dev *hdev)
+static void btintel_pcie_reset(struct hci_dev *hdev, u8 reset_type)
 {
 	struct btintel_pcie_data *data;
 
@@ -2692,6 +2692,12 @@ static void btintel_pcie_reset(struct hci_dev *hdev)
 	if (test_and_set_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &data->flags))
 		return;
 
+	data->reset_type = (reset_type == 1) ?
+			    BTINTEL_PCIE_IOSF_PRR_PLDR : BTINTEL_PCIE_IOSF_PRR_FLR;
+
+	bt_dev_info(hdev, "Reset triggered: %s",
+		    data->reset_type == BTINTEL_PCIE_IOSF_PRR_PLDR ? "PLDR" : "FLR");
+
 	pci_dev_get(data->pdev);
 	schedule_work(&data->reset_work);
 }
@@ -2729,7 +2735,7 @@ static void btintel_pcie_hw_error(struct hci_dev *hdev, u8 code)
 		return;
 	}
 	btintel_pcie_inc_recovery_count(pdev, &hdev->dev);
-	btintel_pcie_reset(hdev);
+	btintel_pcie_reset(hdev, (code == 0x13) ? 1 : 0);
 }
 
 static bool btintel_pcie_wakeup(struct hci_dev *hdev)
@@ -3111,8 +3117,7 @@ static int btintel_pcie_resume(struct device *dev)
 	if (data->pm_sx_event == PM_EVENT_FREEZE ||
 	    data->pm_sx_event == PM_EVENT_HIBERNATE) {
 		set_bit(BTINTEL_PCIE_CORE_HALTED, &data->flags);
-		data->reset_type = BTINTEL_PCIE_IOSF_PRR_FLR;
-		btintel_pcie_reset(data->hdev);
+		btintel_pcie_reset(data->hdev, 0);
 		return 0;
 	}
 
@@ -3143,7 +3148,7 @@ static int btintel_pcie_resume(struct device *dev)
 			queue_work(data->coredump_workqueue, &data->coredump_work);
 		}
 		set_bit(BTINTEL_PCIE_CORE_HALTED, &data->flags);
-		btintel_pcie_reset(data->hdev);
+		btintel_pcie_reset(data->hdev, 0);
 	}
 	return err;
 }
diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 02a96342e964..641f62912f63 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -104,7 +104,7 @@ static void btmtk_coredump_notify(struct hci_dev *hdev, int state)
 	case HCI_DEVCOREDUMP_ABORT:
 	case HCI_DEVCOREDUMP_DONE:
 		data->cd_info.state = HCI_DEVCOREDUMP_IDLE;
-		btmtk_reset_sync(hdev);
+		btmtk_reset_sync(hdev, 0);
 		break;
 	}
 }
@@ -384,7 +384,7 @@ int btmtk_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 }
 EXPORT_SYMBOL_GPL(btmtk_set_bdaddr);
 
-void btmtk_reset_sync(struct hci_dev *hdev)
+void btmtk_reset_sync(struct hci_dev *hdev, u8 reset_type)
 {
 	struct btmtk_data *reset_work = hci_get_priv(hdev);
 	int err;
@@ -1403,7 +1403,7 @@ int btmtk_usb_setup(struct hci_dev *hdev)
 		if (err < 0) {
 			/* retry once if setup firmware error */
 			if (!test_and_set_bit(BTMTK_FIRMWARE_DL_RETRY, &btmtk_data->flags))
-				btmtk_reset_sync(hdev);
+				btmtk_reset_sync(hdev, 0);
 			bt_dev_err(hdev, "Failed to set up firmware (%d)", err);
 			return err;
 		}
diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index c83c24897c95..5cda42444e94 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -196,7 +196,7 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
 int btmtk_setup_firmware(struct hci_dev *hdev, const char *fwname,
 			 wmt_cmd_sync_func_t wmt_cmd_sync);
 
-void btmtk_reset_sync(struct hci_dev *hdev);
+void btmtk_reset_sync(struct hci_dev *hdev, u8 reset_type);
 
 int btmtk_register_coredump(struct hci_dev *hdev, const char *name,
 			    u32 fw_version);
@@ -244,7 +244,7 @@ static inline int btmtk_setup_firmware(struct hci_dev *hdev, const char *fwname,
 	return -EOPNOTSUPP;
 }
 
-static inline void btmtk_reset_sync(struct hci_dev *hdev)
+static inline void btmtk_reset_sync(struct hci_dev *hdev, u8 reset_type)
 {
 }
 
diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index c6f80c419e90..3c4401ce1e00 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -1269,7 +1269,7 @@ static int btmtksdio_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	return 0;
 }
 
-static void btmtksdio_reset(struct hci_dev *hdev)
+static void btmtksdio_reset(struct hci_dev *hdev, u8 reset_type)
 {
 	struct btmtksdio_dev *bdev = hci_get_drvdata(hdev);
 	u32 status;
diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index e7036a48ce48..e2416b48116c 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1539,7 +1539,7 @@ static bool nxp_wakeup(struct hci_dev *hdev)
 	return false;
 }
 
-static void nxp_reset(struct hci_dev *hdev)
+static void nxp_reset(struct hci_dev *hdev, u8 reset_type)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
 
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 08c0a99a62c5..d701c7d82cad 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1043,7 +1043,7 @@ static void btusb_reset(struct hci_dev *hdev)
 	usb_queue_reset_device(data->intf);
 }
 
-static void btusb_intel_reset(struct hci_dev *hdev)
+static void btusb_intel_reset(struct hci_dev *hdev, u8 reset_type)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
 	struct gpio_desc *reset_gpio = data->reset_gpio;
@@ -1121,7 +1121,7 @@ static inline void btusb_rtl_alloc_devcoredump(struct hci_dev *hdev,
 	}
 }
 
-static void btusb_rtl_reset(struct hci_dev *hdev)
+static void btusb_rtl_reset(struct hci_dev *hdev, u8 reset_type)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
 	struct gpio_desc *reset_gpio = data->reset_gpio;
@@ -1165,7 +1165,7 @@ static void btusb_rtl_hw_error(struct hci_dev *hdev, u8 code)
 	btusb_rtl_alloc_devcoredump(hdev, &hdr, NULL, 0);
 }
 
-static void btusb_qca_reset(struct hci_dev *hdev)
+static void btusb_qca_reset(struct hci_dev *hdev, u8 reset_type)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
 	struct gpio_desc *reset_gpio = data->reset_gpio;
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 244447195619..02b4afe77669 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1693,7 +1693,7 @@ static void qca_hw_error(struct hci_dev *hdev, u8 code)
 	clear_bit(QCA_HW_ERROR_EVENT, &qca->flags);
 }
 
-static void qca_reset(struct hci_dev *hdev)
+static void qca_reset(struct hci_dev *hdev, u8 reset_type)
 {
 	struct hci_uart *hu = hci_get_drvdata(hdev);
 	struct qca_data *qca = hu->priv;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 7e15da47fe3a..00421352fcb5 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -650,7 +650,7 @@ struct hci_dev {
 	int (*post_init)(struct hci_dev *hdev);
 	int (*set_diag)(struct hci_dev *hdev, bool enable);
 	int (*set_bdaddr)(struct hci_dev *hdev, const bdaddr_t *bdaddr);
-	void (*reset)(struct hci_dev *hdev);
+	void (*reset)(struct hci_dev *hdev, u8 reset_type);
 	bool (*wakeup)(struct hci_dev *hdev);
 	int (*set_quality_report)(struct hci_dev *hdev, bool enable);
 	int (*get_data_path_id)(struct hci_dev *hdev, __u8 *data_path);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5ba9fe8261ec..360b329ae6da 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1435,7 +1435,7 @@ static void hci_cmd_timeout(struct work_struct *work)
 	}
 
 	if (hdev->reset)
-		hdev->reset(hdev);
+		hdev->reset(hdev, 0);
 
 	atomic_set(&hdev->cmd_cnt, 1);
 	queue_work(hdev->workqueue, &hdev->cmd_work);
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 8957ce7c21b7..a4fe329158cf 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -97,8 +97,14 @@ static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
 {
 	struct hci_dev *hdev = to_hci_dev(dev);
 
-	if (hdev->reset)
-		hdev->reset(hdev);
+	if (hdev->reset) {
+		int val;
+
+		if (kstrtoint(buf, 10, &val) || val != 1)
+			hdev->reset(hdev, 0);
+		else
+			hdev->reset(hdev, 1);
+	}
 
 	return count;
 }
-- 
2.43.0

