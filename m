Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D6E429CD8;
	Thu, 23 Jul 2026 09:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784799931; cv=none; b=k4btDoiIFdwfjnSQYTzj7isii0glGonfmqiYXA9WpygGdG1pdgThJF7FW0qsvSxf52XesQQhOPH+KPiiMCS/CS74ZPb4qtX+GYn6H2rGCIaNtD5vQm4YuS2jr2W9HkVNzXwvEYJ9w/IbOSffXWA6eVyCv4GDkUKWDC2oCfEp2Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784799931; c=relaxed/simple;
	bh=PgQpUlQftVX3rh7+gQVJlc6DwlvZgrKeakcYFm4FEIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C5uWyNm66FqzlDRRrmPs32Y0aB2x5nPjNO8/uoH7wbP2dQRxM8/eq9covcax8jZrUKwYLUAGHRm5hp7RNxkBUlrkCkwl2aJGoSoHDZiOWq3Sztr2olVQx3A55z1FhthxCvXhqjAEBGYiQ+SaCMgNexorWMQZTvDXMX8sjfUqiEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hynvdo0e; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hynvdo0e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784799929; x=1816335929;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PgQpUlQftVX3rh7+gQVJlc6DwlvZgrKeakcYFm4FEIo=;
  b=hynvdo0eo1rBHTx0Jm1pciOx4325yfpjpZiujuL2TXmCIbOxYaO7r98O
   kTzQUOSI7eAkLY3JPTgzX+sovPLDUbz2GL60VKNPSgQ7BUhVt7ZMCCJ+C
   kb6yjw9toROwW7i7smE9OygPDu3E/095Rh7U2nYWEmZaaIKD2rpAXXwDL
   z55LCyw03BYO9GG4HjOjAinWrBJehkSIhF7/JznbrlUAQ/6G/+ekK/vUi
   LhbdUiSxRenWuBagzA7Ek/Myd16q9iBcaugvRxXrlCerrbMEBw8tvc5Ue
   bigw/8fJqH8Bvyr+gTdduV9Mf7Qzbj2eZ7ap9dnL+nnT7qAcFHUCw3EGi
   w==;
X-CSE-ConnectionGUID: Z4KQorIhRviyWAdE6MGvUQ==
X-CSE-MsgGUID: j4wmZQtnRtK2IcXJxK5SQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96592947"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="96592947"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 02:45:27 -0700
X-CSE-ConnectionGUID: 3jixgTVfTXyVeojYQPQ/bw==
X-CSE-MsgGUID: mxGgf67GRC6ZI4fShUgvig==
X-ExtLoop1: 1
Received: from weba0957.iind.intel.com (HELO WEBA0932.iind.intel.com) ([10.224.186.34])
  by fmviesa003.fm.intel.com with ESMTP; 23 Jul 2026 02:45:23 -0700
From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-pci@vger.kernel.org,
	luiz.dentz@gmail.com,
	bhelgaas@google.com,
	ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	kiran.k@intel.com,
	alex@shazbot.org,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Subject: [PATCH v5] Bluetooth: btintel_pcie: Add vendor_reset PCI sysfs for PLDR
Date: Thu, 23 Jul 2026 15:14:43 +0530
Message-ID: <20260723094443.855492-1-chandrashekar.devegowda@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612012832.2395034-1-chandrashekar.devegowda@intel.com>
References: <20260612012832.2395034-1-chandrashekar.devegowda@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a read-write sysfs entry at /sys/bus/pci/devices/<BDF>/vendor_reset
to allow userspace to trigger PLDR (Product Level Device Reset).
Reading the attribute displays supported reset types. Writing
integer 0 triggers PLDR. Any other input is rejected with
-EINVAL and a warning log.

Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
---
Changes in v5:
  - Renamed sysfs from vendor_rst to vendor_reset (reviewer feedback)
  - Switched from device_create_file() to driver dev_groups for
    automatic race-free sysfs lifecycle management
  - Added ABI doc at Documentation/ABI/testing/sysfs-bus-pci-drivers-btintel_pcie
  - Added WiFi impact description to ABI documentation
  - Added MAINTAINERS F: entry for ABI doc

Changes in v4:
  - Rebased on latest bluetooth-next to fix CI apply failure
  - v4: https://lore.kernel.org/all/20260722012158.813793-1-chandrashekar.devegowda@intel.com/

Changes in v3:
  - Dropped reset_type parameter approach from hdev->reset()
  - Directly call btintel_pcie_request_reset() instead of manual
    flag manipulation and schedule_work()
  - Accept only integer 0 for PLDR trigger
  - Handle schedule_work() failure: release pci_dev_get refcount
    and clear RECOVERY_IN_PROGRESS flag
  - Fix remove ordering: device_remove_file before disable_work_sync
  - v3: https://lore.kernel.org/all/20260722001434.804931-1-chandrashekar.devegowda@intel.com/

Changes in v2:
  - Added reset_type parameter to hdev->reset() callback (1/2)
  - vendor_rst sysfs used reset_type to select PLDR (2/2)
  - v2: https://lore.kernel.org/all/20260618085016.9173-1-chandrashekar.devegowda@intel.com/

Changes in v1:
  - Initial implementation
  - v1: https://lore.kernel.org/all/20260612012832.2395034-1-chandrashekar.devegowda@intel.com/
 .../sysfs-bus-pci-drivers-btintel_pcie        | 15 +++++++
 MAINTAINERS                                   |  1 +
 drivers/bluetooth/btintel_pcie.c              | 43 ++++++++++++++++++-
 3 files changed, 58 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-pci-drivers-btintel_pcie

diff --git a/Documentation/ABI/testing/sysfs-bus-pci-drivers-btintel_pcie b/Documentation/ABI/testing/sysfs-bus-pci-drivers-btintel_pcie
new file mode 100644
index 000000000000..cceec6ac96bc
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-pci-drivers-btintel_pcie
@@ -0,0 +1,15 @@
+What:		/sys/bus/pci/devices/<BDF>/vendor_reset
+Date:		22-Jul-2026
+KernelVersion:	6.17
+Contact:	linux-bluetooth@vger.kernel.org
+Description:	This read-write attribute allows userspace to trigger a
+		Product Level Device Reset (PLDR) on Intel PCIe Bluetooth
+		controllers. Reading the attribute displays the supported
+		reset type. Writing integer 0 triggers PLDR. Any other
+		input is rejected with -EINVAL.
+
+		PLDR resets the entire on-chip platform shared between
+		Bluetooth and WiFi. This means any driver attached to
+		the WiFi device that shares hardware with this Bluetooth
+		device will be released, the platform will be reset, and
+		both the Bluetooth and WiFi devices will be re-probed.
diff --git a/MAINTAINERS b/MAINTAINERS
index eb8cdcc76324..39d390f1ceb4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4625,6 +4625,7 @@ S:	Supported
 W:	http://www.bluez.org/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git
+F:	Documentation/ABI/testing/sysfs-bus-pci-drivers-btintel_pcie
 F:	Documentation/devicetree/bindings/net/bluetooth/
 F:	drivers/bluetooth/
 
diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 2e28847263ab..b3d3219e4ebd 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2781,7 +2781,10 @@ static void btintel_pcie_request_reset(struct btintel_pcie_data *data,
 	data->reset_type = type;
 
 	pci_dev_get(data->pdev);
-	schedule_work(&data->reset_work);
+	if (!schedule_work(&data->reset_work)) {
+		pci_dev_put(data->pdev);
+		clear_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &data->flags);
+	}
 }
 
 static void btintel_pcie_hci_reset(struct hci_dev *hdev)
@@ -2791,6 +2794,43 @@ static void btintel_pcie_hci_reset(struct hci_dev *hdev)
 	btintel_pcie_request_reset(data, BTINTEL_PCIE_IOSF_PRR_FLR);
 }
 
+static ssize_t vendor_reset_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	unsigned int val;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct btintel_pcie_data *data = pci_get_drvdata(pdev);
+
+	if (!data || !data->hdev)
+		return -ENODEV;
+
+	if (kstrtouint(buf, 10, &val) || val != 0) {
+		bt_dev_warn(data->hdev, "PLDR rejected: invalid input");
+		return -EINVAL;
+	}
+
+	bt_dev_info(data->hdev, "PLDR triggered via sysfs");
+	btintel_pcie_request_reset(data, BTINTEL_PCIE_IOSF_PRR_PLDR);
+
+	return count;
+}
+
+static ssize_t vendor_reset_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "0 - PLDR\n");
+}
+
+static DEVICE_ATTR_RW(vendor_reset);
+
+static struct attribute *btintel_pcie_attrs[] = {
+	&dev_attr_vendor_reset.attr,
+	NULL,
+};
+
+ATTRIBUTE_GROUPS(btintel_pcie);
+
 static void btintel_pcie_hw_error(struct hci_dev *hdev, u8 code)
 {
 	struct btintel_pcie_dev_recovery *rec;
@@ -3251,6 +3291,7 @@ static struct pci_driver btintel_pcie_driver = {
 	.probe = btintel_pcie_probe,
 	.remove = btintel_pcie_remove,
 	.driver.pm = pm_sleep_ptr(&btintel_pcie_pm_ops),
+	.driver.dev_groups = btintel_pcie_groups,
 #ifdef CONFIG_DEV_COREDUMP
 	.driver.coredump = btintel_pcie_coredump
 #endif
-- 
2.43.0

