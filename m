Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6741F192E;
	Tue,  7 Apr 2026 09:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775554222; cv=none; b=fOtHIbB/aKMudX2oiwVU728dRexbx5VgtIn6BoXbM1ilShQk2GG5xvlZTAcl2+4xYOINdAHJNtfNjjCFGYih8YJaIqSAbOS43D92tElB7iZeYMeMZxiJAZe+I3lNhNXxnCqNrZ1dKxjMqrbpo2PA17x9HcL10ZhEG9xRstXzn5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775554222; c=relaxed/simple;
	bh=qsH2UKICGVyaL6ToSCRVv2k4Aumdx9Cw0tu2ZW+ohX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hq2KaDczvxGiTAbn65rjg86liZji5WbAxmZIM7RWrKF7M4snZ28JERZkn8qW0ZAAL7NsWxfNWn/U2M6F/dBlkR4HZuEDpDbs5abL/eAcKLhTi4/RGKqFhneEqvBzHEkRk8Zyt4n4DbHyiQC5DTI4cG2spZnhf3U2jMEHMvVnjBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VG9FskOZ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VG9FskOZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775554220; x=1807090220;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qsH2UKICGVyaL6ToSCRVv2k4Aumdx9Cw0tu2ZW+ohX0=;
  b=VG9FskOZIlNi3rf7H1bVcLswjQrf5yEREZec2x0lRCyV5/qprfh4HaGt
   qR2+tFIYd9CEamIH5vLNj9JCo8anbJm1C/cgpsH/7Zf28/ToNOfoWmk7o
   9ydrDq3zq48cqi4qb7Agzuy/HTmZU+FqhavKFNjfjkRW25SvSZDQIpyN7
   Zj4Kgz7TkGQN7LnkZU+MNc8s6dhioags57yCHcL5AMpSUzWhXWdvJhKvL
   0sU7Tem+qGA5cBnTFQVB8R8RRs/aSRELLpGWEkz8EadGYdYregT3y7x+x
   RGT+Rye5o7ceB93UW9AIDbQ1IHQBXHmVwZG44sUKQ9oYakP12LnaVhJDI
   A==;
X-CSE-ConnectionGUID: HT+YZUI/S3e3dfQDCWXOTA==
X-CSE-MsgGUID: sILv88x4RC+VoxsD9ePhpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="101967001"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="101967001"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 02:30:20 -0700
X-CSE-ConnectionGUID: EHykXMblQ/mZaoTDnwXANQ==
X-CSE-MsgGUID: 3Pk5KUnORgut0vsVwFORuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="232157672"
Received: from weba0957.iind.intel.com (HELO WEBA0932.iind.intel.com) ([10.224.186.34])
  by orviesa003.jf.intel.com with ESMTP; 07 Apr 2026 02:30:17 -0700
From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-pci@vger.kernel.org,
	bhelgaas@google.com,
	ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Subject: [PATCH v2] Bluetooth: btintel_pcie: Support Product level reset
Date: Tue,  7 Apr 2026 14:59:40 +0530
Message-ID: <20260407092940.1272507-1-chandrashekar.devegowda@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When driver encounters a TOP exception, ACPI methods will be called
for Product level reset since Wifi and BT share the same TOP. BT driver
will first reprobe the wifi driver and then reprobe BT.

Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
---

Notes:
    v2: Incorporated review comments.
    
    Tested by:
    1) Simulating TOP exception: sudo hcitool cmd 3f 4d 0A 00
       And verified that the device went through PLDR by checking the ACPI
       debug logs.
    2) Toggle of sysfs attribute for BT reset for FLR i.e
       echo 1 > /sys/class/bluetooth/hci0/reset

 drivers/bluetooth/btintel.c      |   8 +-
 drivers/bluetooth/btintel.h      |   7 ++
 drivers/bluetooth/btintel_pcie.c | 164 +++++++++++++++++++++++++++++--
 drivers/bluetooth/btintel_pcie.h |   6 ++
 4 files changed, 173 insertions(+), 12 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index dcaaa4ca02b9..c068a1d5ce81 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -67,9 +67,10 @@ static struct {
 	u32        fw_build_num;
 } coredump_info;
 
-static const guid_t btintel_guid_dsm =
+const guid_t btintel_guid_dsm =
 	GUID_INIT(0xaa10f4e0, 0x81ac, 0x4233,
 		  0xab, 0xf6, 0x3b, 0x2a, 0xc5, 0x0e, 0x28, 0xd9);
+EXPORT_SYMBOL_GPL(btintel_guid_dsm);
 
 int btintel_check_bdaddr(struct hci_dev *hdev)
 {
@@ -2624,7 +2625,7 @@ static void btintel_set_ppag(struct hci_dev *hdev, struct intel_version_tlv *ver
 	kfree_skb(skb);
 }
 
-static int btintel_acpi_reset_method(struct hci_dev *hdev)
+int btintel_acpi_reset_method(struct hci_dev *hdev)
 {
 	int ret = 0;
 	acpi_status status;
@@ -2632,7 +2633,7 @@ static int btintel_acpi_reset_method(struct hci_dev *hdev)
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 
 	status = acpi_evaluate_object(ACPI_HANDLE(GET_HCIDEV_DEV(hdev)), "_PRR", NULL, &buffer);
-	if (ACPI_FAILURE(status)) {
+	if (ACPI_FAILURE(status) || !buffer.pointer) {
 		bt_dev_err(hdev, "Failed to run _PRR method");
 		ret = -ENODEV;
 		return ret;
@@ -2663,6 +2664,7 @@ static int btintel_acpi_reset_method(struct hci_dev *hdev)
 	kfree(buffer.pointer);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(btintel_acpi_reset_method);
 
 static void btintel_set_dsm_reset_method(struct hci_dev *hdev,
 					 struct intel_version_tlv *ver_tlv)
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 0e9ca99aaaae..70d812ad36a2 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -79,6 +79,8 @@ struct intel_tlv {
 #define BTINTEL_HWID_SCP2	0x20	/* Scorpius Peak2 - Nova Lake */
 #define BTINTEL_HWID_BZRIW	0x22	/* BlazarIW - Wildcat Lake */
 
+extern const guid_t btintel_guid_dsm;
+
 struct intel_version_tlv {
 	u32	cnvi_top;
 	u32	cnvr_top;
@@ -289,6 +291,7 @@ int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 int btintel_shutdown_combined(struct hci_dev *hdev);
 void btintel_hw_error(struct hci_dev *hdev, u8 code);
 void btintel_print_fseq_info(struct hci_dev *hdev);
+int btintel_acpi_reset_method(struct hci_dev *hdev);
 #else
 
 static inline int btintel_check_bdaddr(struct hci_dev *hdev)
@@ -422,4 +425,8 @@ static inline void btintel_hw_error(struct hci_dev *hdev, u8 code)
 static inline void btintel_print_fseq_info(struct hci_dev *hdev)
 {
 }
+static inline int btintel_acpi_reset_method(struct hci_dev *hdev)
+{
+	return -ENODEV;
+}
 #endif
diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 05f82bc3f0d7..d45341cc4db6 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -15,6 +15,7 @@
 #include <linux/wait.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/acpi.h>
 
 #include <linux/unaligned.h>
 #include <linux/devcoredump.h>
@@ -100,6 +101,22 @@ enum {
 	BTINTEL_PCIE_D3
 };
 
+enum {
+	BTINTEL_PCIE_DSM_SET_RESET_TIMING = 1,
+	BTINTEL_PCIE_DSM_GET_RESET_TIMING = 2,
+	BTINTEL_PCIE_DSM_BT_PLDR_CONFIG = 3,
+	BTINTEL_PCIE_DSM_GET_RESET_TYPE = 4,
+	BTINTEL_PCIE_DSM_DYNAMIC_PLDR = 5,
+	BTINTEL_PCIE_DSM_GET_RESET_METHOD = 6,
+	BTINTEL_PCIE_DSM_SET_PLDR_DELAY = 7,
+};
+
+enum btintel_dsm_internal_product_reset_mode {
+	BTINTEL_PCIE_DSM_PLDR_MODE_EN_PROD_RESET	= BIT(0),
+	BTINTEL_PCIE_DSM_PLDR_MODE_EN_WIFI_FLR		= BIT(1),
+	BTINTEL_PCIE_DSM_PLDR_MODE_EN_BT_OFF_ON		= BIT(2),
+};
+
 /* Structure for dbgc fragment buffer
  * @buf_addr_lsb: LSB of the buffer's physical address
  * @buf_addr_msb: MSB of the buffer's physical address
@@ -126,6 +143,11 @@ struct btintel_pcie_dbgc_ctxt {
 	struct btintel_pcie_dbgc_ctxt_buf bufs[BTINTEL_PCIE_DBGC_BUFFER_COUNT];
 };
 
+/* structure for reset and recovery
+ * @pdev: The pci_dev for controller
+ * @work: work struct for reset
+ * @reset type: Reset can be FLR or PLDR
+ */
 struct btintel_pcie_removal {
 	struct pci_dev *pdev;
 	struct work_struct work;
@@ -2254,6 +2276,113 @@ static void btintel_pcie_inc_recovery_count(struct pci_dev *pdev,
 }
 
 static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data);
+static void btintel_pcie_reset(struct hci_dev *hdev);
+
+static int btintel_pcie_acpi_reset_method(struct btintel_pcie_data *data)
+{
+	union acpi_object *obj, argv4;
+	acpi_handle handle;
+	int ret;
+	struct pldr_mode {
+		__le16	cmd_type;
+		__le16	cmd_payload;
+	} __packed;
+
+	/* set 1 for _PRR mode
+	 * Product Reset (PLDR Abort flow)
+	 */
+	static const struct pldr_mode mode = {
+		.cmd_type = 1,
+		.cmd_payload = BTINTEL_PCIE_DSM_PLDR_MODE_EN_PROD_RESET |
+			       BTINTEL_PCIE_DSM_PLDR_MODE_EN_WIFI_FLR,
+	};
+	struct hci_dev *hdev = data->hdev;
+
+	handle = ACPI_HANDLE(GET_HCIDEV_DEV(data->hdev));
+	if (!handle) {
+		bt_dev_err(data->hdev, "No support for bluetooth device in ACPI firmware");
+		return -EACCES;
+	}
+
+	if (!acpi_has_method(handle, "_PRR")) {
+		bt_dev_err(data->hdev, "No support for _PRR ACPI method, cold boot");
+		return -ENODEV;
+	}
+
+	argv4.buffer.type = ACPI_TYPE_BUFFER;
+	argv4.buffer.length = sizeof(mode);
+	argv4.buffer.pointer = (void *)&mode;
+
+	obj = acpi_evaluate_dsm(handle, &btintel_guid_dsm, 0,
+				BTINTEL_PCIE_DSM_DYNAMIC_PLDR, &argv4);
+	if (!obj) {
+		bt_dev_err(data->hdev, "Failed to call dsm to set reset method");
+		return -EIO;
+	}
+	ACPI_FREE(obj);
+
+	pci_dev_lock(data->pdev);
+	pci_save_state(data->pdev);
+	ret = btintel_acpi_reset_method(hdev);
+	if (ret)
+		bt_dev_err(data->hdev, "ACPI _PRR reset failed (%d), PLDR incomplete",
+			   ret);
+	pci_restore_state(data->pdev);
+	pci_dev_unlock(data->pdev);
+	return ret;
+}
+
+static void btintel_pcie_perform_pldr(struct btintel_pcie_removal *removal)
+{
+	struct pci_dev *pdev = removal->pdev;
+	struct pci_dev *wifi = NULL;
+	struct pci_bus *bus;
+	struct btintel_pcie_data *data;
+	int ret;
+	/* on integrated we have to look up by ID (same bus) */
+	static const struct pci_device_id wifi_device_ids[] = {
+	#define WIFI_DEV(_id) { PCI_DEVICE(PCI_VENDOR_ID_INTEL, _id) }
+		WIFI_DEV(0xA840), /* LNL */
+		WIFI_DEV(0xE440), /* PTL-P */
+		WIFI_DEV(0xE340), /* PTL-H */
+		WIFI_DEV(0xD340), /* NVL-H */
+		WIFI_DEV(0x6E70), /* NVL-S */
+		WIFI_DEV(0x4D40), /* WCL */
+		WIFI_DEV(0xD240), /* RZL-H */
+		WIFI_DEV(0x6C40), /* RZL-M */
+		{}
+	};
+	struct pci_dev *tmp = NULL;
+
+	data = pci_get_drvdata(pdev);
+
+	bus = pdev->bus;
+	if (!bus)
+		return;
+
+	list_for_each_entry(tmp, &bus->devices, bus_list) {
+		if (pci_match_id(wifi_device_ids, tmp)) {
+			wifi = pci_dev_get(tmp);
+			break;
+		}
+	}
+
+	if (wifi)
+		device_release_driver(&wifi->dev);
+
+	ret = btintel_pcie_acpi_reset_method(data);
+
+	if (wifi) {
+		if (device_reprobe(&wifi->dev))
+			BT_ERR("WiFi reprobe failed for BDF:%s", pci_name(wifi));
+		pci_dev_put(wifi);
+	}
+
+	if (!ret) {
+		if (device_reprobe(&pdev->dev))
+			BT_ERR("BT reprobe failed for BDF:%s", pci_name(pdev));
+	}
+}
 
 static void btintel_pcie_removal_work(struct work_struct *wk)
 {
@@ -2266,9 +2395,13 @@ static void btintel_pcie_removal_work(struct work_struct *wk)
 	pci_lock_rescan_remove();
 
 	if (!pdev->bus)
-		goto error;
+		goto out;
 
 	data = pci_get_drvdata(pdev);
+	if (!data) {
+		BT_WARN("PCI driver data is NULL, aborting removal work");
+		goto out;
+	}
 
 	btintel_pcie_disable_interrupts(data);
 	btintel_pcie_synchronize_irqs(data);
@@ -2276,12 +2409,16 @@ static void btintel_pcie_removal_work(struct work_struct *wk)
 	flush_work(&data->rx_work);
 
 	bt_dev_dbg(data->hdev, "Release bluetooth interface");
+	if (data->reset_type == BTINTEL_PCIE_IOSF_PRR_PLDR) {
+		btintel_pcie_perform_pldr(removal);
+		goto out;
+	}
 	btintel_pcie_release_hdev(data);
 
 	err = pci_reset_function(pdev);
 	if (err) {
 		BT_ERR("Failed resetting the pcie device (%d)", err);
-		goto error;
+		goto out;
 	}
 
 	btintel_pcie_enable_interrupts(data);
@@ -2291,7 +2428,7 @@ static void btintel_pcie_removal_work(struct work_struct *wk)
 	if (err) {
 		BT_ERR("Failed to enable bluetooth hardware after reset (%d)",
 		       err);
-		goto error;
+		goto out;
 	}
 
 	btintel_pcie_reset_ia(data);
@@ -2301,9 +2438,9 @@ static void btintel_pcie_removal_work(struct work_struct *wk)
 	err = btintel_pcie_setup_hdev(data);
 	if (err) {
 		BT_ERR("Failed registering hdev (%d)", err);
-		goto error;
+		goto out;
 	}
-error:
+out:
 	pci_dev_put(pdev);
 	pci_unlock_rescan_remove();
 	kfree(removal);
@@ -2339,15 +2476,19 @@ static void btintel_pcie_hw_error(struct hci_dev *hdev, u8 code)
 	struct pci_dev *pdev = dev_data->pdev;
 	time64_t retry_window;
 
-	if (code == 0x13) {
-		bt_dev_err(hdev, "Encountered top exception");
-		return;
-	}
+	btintel_pcie_dump_debug_registers(hdev);
 
 	data = btintel_pcie_get_recovery(pdev, &hdev->dev);
 	if (!data)
 		return;
 
+	if (code == 0x13)
+		dev_data->reset_type = BTINTEL_PCIE_IOSF_PRR_PLDR;
+	else
+		dev_data->reset_type = BTINTEL_PCIE_IOSF_PRR_FLR;
+
+	bt_dev_err(hdev, "Encountered exception err:0x%x triggering: %s", code,
+		   dev_data->reset_type == BTINTEL_PCIE_IOSF_PRR_PLDR ? "PLDR" : "FLR");
 	retry_window = ktime_get_boottime_seconds() - data->last_error;
 
 	if (retry_window < BTINTEL_PCIE_RESET_WINDOW_SECS &&
@@ -2503,6 +2644,10 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
 
 	data->boot_stage_cache = 0x00;
 	data->img_resp_cache = 0x00;
+	/* FLR can be invoked by echoing to debugfs path, so explicitly
+	 * initialized
+	 */
+	data->reset_type = BTINTEL_PCIE_IOSF_PRR_FLR;
 
 	err = btintel_pcie_config_pcie(pdev, data);
 	if (err)
@@ -2701,6 +2846,7 @@ static int btintel_pcie_resume(struct device *dev)
 	if (data->pm_sx_event == PM_EVENT_FREEZE ||
 	    data->pm_sx_event == PM_EVENT_HIBERNATE) {
 		set_bit(BTINTEL_PCIE_CORE_HALTED, &data->flags);
+		data->reset_type = BTINTEL_PCIE_IOSF_PRR_FLR;
 		btintel_pcie_reset(data->hdev);
 		return 0;
 	}
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index e3d941ffef4a..856673fb2bd7 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -144,6 +144,11 @@ enum msix_mbox_int_causes {
 	BTINTEL_PCIE_CSR_MBOX_STATUS_MBOX4 = BIT(3), /* cause MBOX4 */
 };
 
+enum btintel_pcie_reset_type {
+	BTINTEL_PCIE_IOSF_PRR_FLR = 0,
+	BTINTEL_PCIE_IOSF_PRR_PLDR = 1,
+};
+
 #define BTINTEL_PCIE_MSIX_NON_AUTO_CLEAR_CAUSE	BIT(7)
 
 /* Minimum and Maximum number of MSI-X Vector
@@ -514,6 +519,7 @@ struct btintel_pcie_data {
 	struct txq	txq;
 	struct rxq	rxq;
 	u32	alive_intr_ctxt;
+	enum btintel_pcie_reset_type	reset_type;
 	struct btintel_pcie_dbgc	dbgc;
 	struct btintel_pcie_dump_header dmp_hdr;
 	u8	pm_sx_event;
-- 
2.43.0

