Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FFC1FC101;
	Mon, 13 Apr 2026 04:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776054087; cv=none; b=UgCQAOSQMRj9x3l/g9PEHFaHSiwUnvMM0/Ba8+aqV40Xb2PRDZDyylwJvkD6MdU+85jjrSYtg1lT3z7IBBG+4p1TnhNYnXvHPQKEGjy2I3LsbC7rnMsBn7YB54WUgwunZmna8goxHH7dKm8LNGNqyE//I/8zjuXHk6JnTqm7UZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776054087; c=relaxed/simple;
	bh=UtN5VR7f7/sbMFgJdiW0S0QgBD6DLDOiO3rbJHn3Wxc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jKjFKlAr5Eu1/IE9mNAdNLd4rX/FBZavBlg0ydkDwPdMYW5ajNc/iK0WpITRdPrYRfCO6u+vJuXQHz6MBaHajEUGdUlnxH9UBPjPFX57j3zBtOHNUSnsnzsy7A+9oPRvzPHh9/SCG6iHXXq2kCqlbJVm1ZfttB9aawuwHMvo3Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jqsHJqar; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jqsHJqar"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776054082; x=1807590082;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UtN5VR7f7/sbMFgJdiW0S0QgBD6DLDOiO3rbJHn3Wxc=;
  b=jqsHJqarGwM8clyCmcWiopUXft81HwK4+skNYZK2x1vyzOIglvA4jneq
   3zbwG4FzxW6ZtOgeHFqocb+BBAvpdbjDkfqXh9veX/vTyzkj3TCkZMZAx
   Axihu/VhKaqC0ZVNgCHFuo/q2srUMI+1ZDCCvmmXh1NMQgjWLCbuMjjE3
   ZhwOCjwcSy+03VepBh9UhB6PpdVkpyjSXMAib+Ndm0U5+AAZAKSdVTd8b
   7LJbAlxZQLNYpLKubyCYvPvXOnZZlhRhxGjKwLv61feLJv0Mx7yxJnxqd
   WAlAeX9Bx/z2nW3epSNu4m+gi0djCczWl3Jon2AoeimnWOWa4qHPwHPVX
   w==;
X-CSE-ConnectionGUID: D7QrvodlQbeUwaACvgs9DQ==
X-CSE-MsgGUID: qI3cQM5OQUSvzYZZYSI3aQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="76868676"
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; 
   d="scan'208";a="76868676"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2026 21:21:20 -0700
X-CSE-ConnectionGUID: Qt62IfLjQtaPEtRFxNByoA==
X-CSE-MsgGUID: 7lRhtuWETGCBZtuEsWAZnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; 
   d="scan'208";a="234598292"
Received: from weba0957.iind.intel.com (HELO WEBA0932.iind.intel.com) ([10.224.186.34])
  by fmviesa005.fm.intel.com with ESMTP; 12 Apr 2026 21:21:18 -0700
From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-pci@vger.kernel.org,
	bhelgaas@google.com,
	ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Subject: [PATCH v3] Bluetooth: btintel_pcie: Support Product level reset
Date: Mon, 13 Apr 2026 09:50:40 +0530
Message-ID: <20260413042041.1318723-1-chandrashekar.devegowda@intel.com>
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
    v3: incorporated review comments
     - Embedded reset_work in btintel_pcie_data instead of dynamic
       btintel_pcie_removal allocation to fix use-after-free race
       between reset work and concurrent driver unbind
     - Added cancel_work_sync in btintel_pcie_remove() with
       current_work() guard to avoid deadlock in PLDR reprobe path
     - Removed struct btintel_pcie_removal
     - Renamed btintel_pcie_removal_work to btintel_pcie_reset_work
    v2: incorporated review comments

 drivers/bluetooth/btintel.c      |  10 +-
 drivers/bluetooth/btintel.h      |   7 ++
 drivers/bluetooth/btintel_pcie.c | 203 ++++++++++++++++++++++++++-----
 drivers/bluetooth/btintel_pcie.h |   7 ++
 4 files changed, 192 insertions(+), 35 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index dcaaa4ca02b9..5e9cac090bd8 100644
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
@@ -2632,14 +2633,14 @@ static int btintel_acpi_reset_method(struct hci_dev *hdev)
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 
 	status = acpi_evaluate_object(ACPI_HANDLE(GET_HCIDEV_DEV(hdev)), "_PRR", NULL, &buffer);
-	if (ACPI_FAILURE(status)) {
+	if (ACPI_FAILURE(status) || !buffer.pointer) {
 		bt_dev_err(hdev, "Failed to run _PRR method");
 		ret = -ENODEV;
 		return ret;
 	}
 	p = buffer.pointer;
 
-	if (p->package.count != 1 || p->type != ACPI_TYPE_PACKAGE) {
+	if (p->type != ACPI_TYPE_PACKAGE || p->package.count != 1) {
 		bt_dev_err(hdev, "Invalid arguments");
 		ret = -EINVAL;
 		goto exit_on_error;
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
index 05f82bc3f0d7..df073873ec99 100644
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
@@ -126,11 +143,6 @@ struct btintel_pcie_dbgc_ctxt {
 	struct btintel_pcie_dbgc_ctxt_buf bufs[BTINTEL_PCIE_DBGC_BUFFER_COUNT];
 };
 
-struct btintel_pcie_removal {
-	struct pci_dev *pdev;
-	struct work_struct work;
-};
-
 static LIST_HEAD(btintel_pcie_recovery_list);
 static DEFINE_SPINLOCK(btintel_pcie_recovery_lock);
 
@@ -2254,21 +2266,132 @@ static void btintel_pcie_inc_recovery_count(struct pci_dev *pdev,
 }
 
 static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data);
+static void btintel_pcie_reset(struct hci_dev *hdev);
 
-static void btintel_pcie_removal_work(struct work_struct *wk)
+static int btintel_pcie_acpi_reset_method(struct btintel_pcie_data *data)
 {
-	struct btintel_pcie_removal *removal =
-		container_of(wk, struct btintel_pcie_removal, work);
-	struct pci_dev *pdev = removal->pdev;
-	struct btintel_pcie_data *data;
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
+		.cmd_type = cpu_to_le16(1),
+		.cmd_payload = cpu_to_le16(BTINTEL_PCIE_DSM_PLDR_MODE_EN_PROD_RESET |
+			       BTINTEL_PCIE_DSM_PLDR_MODE_EN_WIFI_FLR),
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
+static void btintel_pcie_perform_pldr(struct btintel_pcie_data *data)
+{
+	struct pci_dev *pdev = data->pdev;
+	struct pci_dev *wifi = NULL;
+	struct pci_bus *bus;
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
+	/* Wi-Fi is fully unbound before the reset and fully reprobed after
+	 * the normal PCI probe path handles all state setup from scratch.
+	 * BT needs pci_save_state()/pci_restore_state() because the BT driver
+	 * is still partially attached when the _PRR runs (it hasn't been unbound yet).
+	 * The PCI device needs to remain minimally functional so that
+	 * device_reprobe(&pdev->dev) can work afterward
+	 */
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
+
+static void btintel_pcie_reset_work(struct work_struct *wk)
+{
+	struct btintel_pcie_data *data =
+		container_of(wk, struct btintel_pcie_data, reset_work);
+	struct pci_dev *pdev = data->pdev;
 	int err;
 
 	pci_lock_rescan_remove();
 
 	if (!pdev->bus)
-		goto error;
+		goto out;
 
-	data = pci_get_drvdata(pdev);
+	if (!data)
+		goto out;
 
 	btintel_pcie_disable_interrupts(data);
 	btintel_pcie_synchronize_irqs(data);
@@ -2276,12 +2399,21 @@ static void btintel_pcie_removal_work(struct work_struct *wk)
 	flush_work(&data->rx_work);
 
 	bt_dev_dbg(data->hdev, "Release bluetooth interface");
+	if (data->reset_type == BTINTEL_PCIE_IOSF_PRR_PLDR) {
+		/* This function holds pci_lock_rescan_remove(), which acquires
+		 * pci_rescan_remove_lock. This mutex serializes against PCI device
+		 * addition/removal (hotplug), so no device can be added to or
+		 * removed from the bus list while this code runs.
+		 */
+		btintel_pcie_perform_pldr(data);
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
@@ -2291,7 +2423,7 @@ static void btintel_pcie_removal_work(struct work_struct *wk)
 	if (err) {
 		BT_ERR("Failed to enable bluetooth hardware after reset (%d)",
 		       err);
-		goto error;
+		goto out;
 	}
 
 	btintel_pcie_reset_ia(data);
@@ -2301,17 +2433,15 @@ static void btintel_pcie_removal_work(struct work_struct *wk)
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
-	kfree(removal);
 }
 
 static void btintel_pcie_reset(struct hci_dev *hdev)
 {
-	struct btintel_pcie_removal *removal;
 	struct btintel_pcie_data *data;
 
 	data = hci_get_drvdata(hdev);
@@ -2322,14 +2452,8 @@ static void btintel_pcie_reset(struct hci_dev *hdev)
 	if (test_and_set_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &data->flags))
 		return;
 
-	removal = kzalloc_obj(*removal, GFP_ATOMIC);
-	if (!removal)
-		return;
-
-	removal->pdev = data->pdev;
-	INIT_WORK(&removal->work, btintel_pcie_removal_work);
-	pci_dev_get(removal->pdev);
-	schedule_work(&removal->work);
+	pci_dev_get(data->pdev);
+	schedule_work(&data->reset_work);
 }
 
 static void btintel_pcie_hw_error(struct hci_dev *hdev, u8 code)
@@ -2339,15 +2463,19 @@ static void btintel_pcie_hw_error(struct hci_dev *hdev, u8 code)
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
@@ -2500,10 +2628,14 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
 
 	skb_queue_head_init(&data->rx_skb_q);
 	INIT_WORK(&data->rx_work, btintel_pcie_rx_work);
+	INIT_WORK(&data->reset_work, btintel_pcie_reset_work);
 
 	data->boot_stage_cache = 0x00;
 	data->img_resp_cache = 0x00;
-
+	/* FLR can be invoked by echoing to debugfs path, so explicitly
+	 * initialized
+	 */
+	data->reset_type = BTINTEL_PCIE_IOSF_PRR_FLR;
 	err = btintel_pcie_config_pcie(pdev, data);
 	if (err)
 		goto exit_error;
@@ -2552,6 +2684,14 @@ static void btintel_pcie_remove(struct pci_dev *pdev)
 
 	data = pci_get_drvdata(pdev);
 
+	/* Cancel pending reset work. Skip only when remove() is called from
+	 * within the reset work itself (PLDR device_reprobe path) to avoid
+	 * deadlock. current_work() returns the work_struct of the caller if
+	 * we are in a workqueue context.
+	 */
+	if (current_work() != &data->reset_work)
+		cancel_work_sync(&data->reset_work);
+
 	btintel_pcie_disable_interrupts(data);
 
 	btintel_pcie_synchronize_irqs(data);
@@ -2701,6 +2841,7 @@ static int btintel_pcie_resume(struct device *dev)
 	if (data->pm_sx_event == PM_EVENT_FREEZE ||
 	    data->pm_sx_event == PM_EVENT_HIBERNATE) {
 		set_bit(BTINTEL_PCIE_CORE_HALTED, &data->flags);
+		data->reset_type = BTINTEL_PCIE_IOSF_PRR_FLR;
 		btintel_pcie_reset(data->hdev);
 		return 0;
 	}
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index e3d941ffef4a..2a4d15da773d 100644
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
@@ -503,6 +508,7 @@ struct btintel_pcie_data {
 	struct workqueue_struct	*workqueue;
 	struct sk_buff_head	rx_skb_q;
 	struct work_struct	rx_work;
+	struct work_struct      reset_work;
 
 	struct dma_pool	*dma_pool;
 	dma_addr_t	dma_p_addr;
@@ -514,6 +520,7 @@ struct btintel_pcie_data {
 	struct txq	txq;
 	struct rxq	rxq;
 	u32	alive_intr_ctxt;
+	enum btintel_pcie_reset_type	reset_type;
 	struct btintel_pcie_dbgc	dbgc;
 	struct btintel_pcie_dump_header dmp_hdr;
 	u8	pm_sx_event;
-- 
2.43.0

