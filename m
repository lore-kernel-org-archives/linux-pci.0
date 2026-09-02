Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013024.outbound.protection.outlook.com [40.93.196.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28E446C821;
	Wed,  2 Sep 2026 13:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356461; cv=fail; b=dEsoLEB5oElV10Wiy5siH6paKR2yMLY/yeYcgmKnmv73NI9Au4tAMzoxxvs8s3ZHQC9Bl2etlt21OHSuUFENHwPkomL1mQdNtT9DLXLUvdz3kozznIWSGu+JPX4qFpFVjg6yMNcN8wzayJp5ex8SIex7DsspaPMxwaJdkHu4F/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356461; c=relaxed/simple;
	bh=1fvNQBNfYTLj7zhCAAcfOAKV9GR/XMVUPZ9YRjSInhM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ovx+uQ5PLdDl/WtWy/92W3Om4LSc8Znu/f1QeMA8YlKLjZIk7XmPx0t/BJ461fhTLuqPV9WNRBIuDX3qjWccCnFKCllZl2rYNI/TRPWxTBthhv+VhMSuBsMOdhTg/QnmycPRj3BBjp1QIPjIbHCfGjFaSRAAqV/SuiH9+kiQBXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kwU7Ia17; arc=fail smtp.client-ip=40.93.196.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kwU7Ia17"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M9y3r+DoeVhaY9jhxADp/hq15wyYRN1wDiGdkeIEKB1oq7RNKNAeDTBEaLp8cW/SnZ+OMPCrQH7z1fBHYE1bBnabjGDBt/z7syijwz7yxk7GylYq1fFykDIthJsIPal2hfwdSVTtDvzKWkdtMPGUevIAkti9RGsAyK2VE8RVzmUbV5PZmaJrEtYUIMW30wjRPMfTp0qlaKWkovyQtpI2oIr59qVhr2LYcYt/4bCPJiiv5BL9rUyy12Ct2a8lnXXp4EiWTiuPkPPgKOFTh+B/MYWnjxC7Ih04wi1Z75pAHvcb1a++VMbo+vEBkHkwxAvn+bq74glrv+7MCbvTR0++VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/U2KNM2z5N7eV55XR/rtUWnPfKVFwTjVb+V7ej/rI2Q=;
 b=VxaPXlsDUYaYG8YTSP2SgaeeZXVS/VPQlKQleGcNpptgfIvZGqraea3lga3exsRjXHO3GDa4W2jFIrwYDAN9wK4qnctH0MSK5SzBfdf8ExxwRm4uoB7gjkNxSazLGK52YXQ5zREonj/qsYWM1lmvgr9yz+O3/8SU7rWdtPFh8W2iOEZWuPreEq1KEzeXcPdLrl/+iEJ0M3tA8OFApTlfRTWZbiBFWdSw5K5+x9XO8tHpRHcvETzSLz/0aerP7wC9V4sNlAD7lXS9PYJrrTIJj2F7BDYhVdJyTNoSTBmUocGLpdEmfuhsHlSUlcOYaHKgbk69+WcFZV23XyQ+mWWyqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/U2KNM2z5N7eV55XR/rtUWnPfKVFwTjVb+V7ej/rI2Q=;
 b=kwU7Ia17N0TjgoRaX46z+A8NosG+oGm/5liGrnOSJlEZ0XymO0taWq+lT09Szl9hcvxdvUwgu2HP8usjloZdgR5Kv7HHbmJHcPhHqi8FHvlVmez+Ru7sWsXBzxqKhNQfZJ5DgZWExgvQG81nGzo9CwB09k0kdiFEXughOsCAry8=
Received: from SJ0PR03CA0274.namprd03.prod.outlook.com (2603:10b6:a03:39e::9)
 by DS0PR12MB8271.namprd12.prod.outlook.com (2603:10b6:8:fb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.10; Wed, 2 Sep 2026 13:40:53 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::19) by SJ0PR03CA0274.outlook.office365.com
 (2603:10b6:a03:39e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Wed, 2
 Sep 2026 13:40:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 13:40:52 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 08:40:52 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>, "Rafael J .
 Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	<linux-cxl@vger.kernel.org>
CC: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, "Hanjun
 Guo" <guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	"Shuai Xue" <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, Ira
 Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Shuah Khan
	<skhan@linuxfoundation.org>, Ben Cheatham <Benjamin.Cheatham@amd.com>,
	Richard Cheng <icheng@nvidia.com>, Robert Richter <rrichter@amd.com>, "Lukas
 Wunner" <lukas@wunner.de>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v20 6/9] PCI: Cache PCI DSN into pci_dev->dsn during probe
Date: Wed, 2 Sep 2026 08:39:30 -0500
Message-ID: <20260902133933.2992457-7-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902133933.2992457-1-terry.bowman@amd.com>
References: <20260902133933.2992457-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|DS0PR12MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: 81d9a686-9d85-4cd1-443f-08df08f7ced5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|7416014|10067099003|6133799003|18002099003|22082099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	R5N2/jzgHBPiSAP5kceentFBXMhifUKUc2I78HwJF/o8MeZazJRox0BdffVwA+Ea9xln9K6LMgxI1TUU/Fmv1opwy0iTINwRFf8IFq3aDBgspRkR+QQ40nZOrEUl9NJxhbRNIuFVPTwozEBEG50LLxKy+r/1ifWG2PvBvCyrBiGks4wyRGUCpF8AaiRKWKFXVUtep6OUtOGvLMbVFKQBiTwHisE1LOQryL4GsAImMFCcMjBMyj6BU7ekDE9qvk5fBPnynapOs3q7c9ew2/1Imy09rAf6zJSmSkTXmkjC9T+jMPdc1Tu/JCIw1vW3yOHuwcEu/rQGMBtEDUXLegaHi5Qr6679gna7d63rriU8SsL9yjA8Pc08GrLgS4bFdn+BLbHPTOmLvXDmk7F5I3v5nKvjjYOwnwLi8Y8JAFOiT2eIVamZlDCJAoKEy2lc/QHOhB1Z+Js7xL+haiLZDcNg0z2YzV2F+DYsRsmfaiwq5aBHv10IiSkb5izoaYWtvg99TlNAU7WZuA4eN/90H3EVPQz1yVrPmcyY2Mu+6R9Wh6jj7ZjjvAYDhAMy41VfkULY048XE1iSOA/EYnmJkA5YXAK4U+7BgxQPxLCiGpU5TB6pm5Gpeww3pXLq9PjFIls0dbXP2QpfSSbac0piQEWl5KrUtuWzzRmn1MFWGbO3Byz1aFJ/6NqTOXQIPrurYQZdcmIg1Fo3oqh3OJ6+x0e9P+4/7mNwuLisbFeDHyIV6QsmlEeoRt4UqdZ48nNYtZyb
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(7416014)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lwwzUSw2j/j8tXqOXPS4GIyjzuh0FWFx+6YWbyzvIg5AfZX3McIHaKJWOBrgtJzmmAWxbHdZjnBY3a1V1keTt5QyjmYFDnDCCkjKhr3q09xIk7AjBD4a4RPZB9ySjj0jk9m1i9mJOuz4dDgd9hZIHMZ9ZgW5iQb0KNv6nQWptPmOz1+Qy97O5+oHeuzyo71QbLebpjV/G1LkgIMyV4/D1M+DYkANweuAzlLmCy52k0Z+cKTy0Cm2sfORSC5EatngEaLy5rFwtsekKsj2zJNmQ8oFnQd6B3jZIRMOk5BmLpGyw5W/Ra3oTNJMKZBGkINBHFQHY5V6RUoevbE5pMZnJfYh55s4h47jirxu8ffnO2D2ECKA+WtWSUTBnkhCFCE5R/Qi1UBXgU6gjDzC0GigiVEAWJnkARs4wJhNl+y5zg7/FKn0s/MmjslFsEagXU7+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 13:40:52.9250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d9a686-9d85-4cd1-443f-08df08f7ced5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8271

Subsequent CXL error-reporting code paths need to log the PCI Device
Serial Number (DSN) as part of trace events emitted from interrupt or
panic context. Computing the DSN there via pci_get_dsn() requires PCI
configuration space reads, which are slow, can fail when the link is
down or frozen, and may not be safe in some contexts.

Add a u64 dsn field to struct pci_dev and populate it from pci_get_dsn()
during pci_init_capabilities() at probe time via pci_dsn_init(). Only
write dev->dsn when the read succeeds. The zero initial value from
pci_dev allocation already represents 'no DSN available.'

Remove the now-redundant dsn member from the pciehp struct controller
along with its kernel-doc. Drop the pci_get_slot()/pci_dev_put() pairs
in pciehp_configure_device() and pcie_init() that existed solely to
read the DSN into ctrl->dsn. Use pdev->dsn in pciehp_device_replaced()
for the device-replacement comparison.

pci_get_dsn() is not modified because it remains a pure config-space read
with no side effects on pci_dev. The cache is written exclusively by
pci_dsn_init() at probe time.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>

---

Changes in v19 -> v20:
- Change 2 space to 1 space in comment block in pci_dsn_init
- Add Reviewed-by from Alison Schofield

Changes in v18 -> v19:
- Update pciehp hotplug to use cached DSN.
- Swapped order in series with
("cxl: Add port and dport identifiers to CXL AER trace events ")
- Update function documentation for pci_dsn_init()

Changes in v17->v18:
- New commit.
---
 drivers/cxl/pci.c                |  2 +-
 drivers/pci/hotplug/pciehp.h     |  4 ----
 drivers/pci/hotplug/pciehp_hpc.c |  7 +------
 drivers/pci/hotplug/pciehp_pci.c |  4 ----
 drivers/pci/probe.c              | 17 +++++++++++++++++
 include/linux/pci.h              |  1 +
 6 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 1e7be77ded634..c4cd5fa960362 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -802,7 +802,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (!dvsec)
 		pci_warn(pdev, "Device DVSEC not present, skip CXL.mem init\n");
 
-	mds = cxl_memdev_state_create(&pdev->dev, pci_get_dsn(pdev), dvsec);
+	mds = cxl_memdev_state_create(&pdev->dev, pdev->dsn, dvsec);
 	if (IS_ERR(mds))
 		return PTR_ERR(mds);
 	cxlds = &mds->cxlds;
diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index debc79b0adfb2..30aad3b66bab9 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -46,9 +46,6 @@ extern int pciehp_poll_time;
 /**
  * struct controller - PCIe hotplug controller
  * @pcie: pointer to the controller's PCIe port service device
- * @dsn: cached copy of Device Serial Number of Function 0 in the hotplug slot
- *	(PCIe r6.2 sec 7.9.3); used to determine whether a hotplugged device
- *	was replaced with a different one during system sleep
  * @slot_cap: cached copy of the Slot Capabilities register
  * @inband_presence_disabled: In-Band Presence Detect Disable supported by
  *	controller and disabled per spec recommendation (PCIe r5.0, appendix I
@@ -90,7 +87,6 @@ extern int pciehp_poll_time;
  */
 struct controller {
 	struct pcie_device *pcie;
-	u64 dsn;
 
 	u32 slot_cap;				/* capabilities and quirks */
 	unsigned int inband_presence_disabled:1;
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 4c62140a3cb44..5336e9c9003ae 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -587,7 +587,7 @@ bool pciehp_device_replaced(struct controller *ctrl)
 	     reg != (pdev->subsystem_vendor | (pdev->subsystem_device << 16))))
 		return true;
 
-	if (pci_get_dsn(pdev) != ctrl->dsn)
+	if (pci_get_dsn(pdev) != pdev->dsn)
 		return true;
 
 	return false;
@@ -1085,11 +1085,6 @@ struct controller *pcie_init(struct pcie_device *dev)
 		}
 	}
 
-	pdev = pci_get_slot(subordinate, PCI_DEVFN(0, 0));
-	if (pdev)
-		ctrl->dsn = pci_get_dsn(pdev);
-	pci_dev_put(pdev);
-
 	return ctrl;
 }
 
diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index 65e50bee1a8c0..ad12515a4a121 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -72,10 +72,6 @@ int pciehp_configure_device(struct controller *ctrl)
 	pci_bus_add_devices(parent);
 	down_read_nested(&ctrl->reset_lock, ctrl->depth);
 
-	dev = pci_get_slot(parent, PCI_DEVFN(0, 0));
-	ctrl->dsn = pci_get_dsn(dev);
-	pci_dev_put(dev);
-
  out:
 	pci_unlock_rescan_remove();
 	return ret;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 27008e2ea5afc..2f71bee732c36 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2638,6 +2638,22 @@ void pcie_report_downtraining(struct pci_dev *dev)
 	__pcie_print_link_status(dev, false);
 }
 
+/*
+ * Cache the Device Serial Number for use in contexts where config-space reads
+ * are unsafe (interrupt, panic). Process-context callers that need a fresh
+ * value (e.g. hotplug device replacement) call pci_get_dsn() and compare it
+ * against this cached pdev->dsn to detect a changed device. Note pdev->dsn
+ * is 0 for devices without the DSN capability, so such a comparison cannot
+ * distinguish a replacement.
+ */
+static void pci_dsn_init(struct pci_dev *dev)
+{
+	u64 dsn = pci_get_dsn(dev);
+
+	if (dsn)
+		dev->dsn = dsn;
+}
+
 static void pci_imm_ready_init(struct pci_dev *dev)
 {
 	u16 status;
@@ -2674,6 +2690,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_rebar_init(dev);		/* Resizable BAR */
 	pci_dev3_init(dev);		/* Device 3 capabilities */
 	pci_ide_init(dev);		/* Link Integrity and Data Encryption */
+	pci_dsn_init(dev);		/* Serial number */
 
 	pcie_report_downtraining(dev);
 	pci_init_reset_methods(dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d31a8d107b1ef..a7fea52c8f46e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -390,6 +390,7 @@ struct pci_dev {
 	unsigned long	*dma_alias_mask;/* Mask of enabled devfn aliases */
 
 	struct pci_driver *driver;	/* Driver bound to this device */
+	u64		dsn;		/* PCI Device Serial Number */
 	u64		dma_mask;	/* Mask of the bits of bus address this
 					   device implements.  Normally this is
 					   0xffffffff.  You only need to change
-- 
2.34.1

