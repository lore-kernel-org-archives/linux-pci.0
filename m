Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011040.outbound.protection.outlook.com [40.93.194.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C617372B57;
	Mon,  5 Oct 2026 07:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791183818; cv=fail; b=I9fbmMJUrcCIWrAjkPvl2u0jJm1FVHZiG9XFHnd5q8V9R221BfYcYGYgjwrfJCBJ8yoIz8eZu694lC4PzBfXiTpCJgWL3Ri8CTevNCG/KvsEYZ4LRU2LGr20qvZubuLdARg/fBUxBbCgE7aipf6vpBA4Q0jVajEZID95aYDyk8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791183818; c=relaxed/simple;
	bh=dL52sWe91oFcDi9v3YXuT6Atvf5Zgv75lgCoKeAV+kw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pMCkgGUZQ6499UlkoYolZXS7DyHiyFZG7BB8DdW9x4LD0ZQ2eKh36ZwZIx/6yHHty2HInyDTKMBCLtxhxTrF00/UpD3IrG88MoKkEn5XlnY6/9rD4S6EKjBCRj1HC0I6UZ0G6dbcUl9396qNJm4I2rHoSzTBtTwkRmfEIB1nmZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XRlDvbRr; arc=fail smtp.client-ip=40.93.194.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XRlDvbRr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I3bGwl7ckilUefaFn9+YEEyCVvWeWurRc49u7D8FS95azcoYqfPskSjOe7Si3j881t9XK5STuLdudeFvwFngWCI1H6yICK/Qg39u9VDP1Ij3TyyYpLwWMRjvFWEBRSagTKDEb+i0mS1BIBDTMGAH6EYQ0tVDNAAzqVCz3RQUWH0ZJaoFHIwuDzIlyi/+byH+KSe4hOLtQLwd/QR40v228j5VyIgZthbMK11RYMFGhtLP7yOA8/eZSJfFnROEPhQ7ZNDYRLmNq39knfLrCBU4UhHFHQnQpoGgbHNkxY2GEndsN0Wu8Lr2wTHDHsh4ms1jtSS+IkijZV6/Yjhnq2JEuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0OQlskoArvrWrac6VAf0XEjOXPXHdsDx3DDPso3QLE=;
 b=Ezc17gqJy2uxTHYwj959YjS4ntcfGzzays3lCyqZvC45x+6NtI/31yWZoO3fYHUFBOVYmckwm0X83LpwjYo/ReuO2gl7lmgiHh7FsJ7x6aFzNfi6yekFJ+8RLtb6OWDIa294WEFSEM1bByFRDs1jKtFBeYaG2Mc3dK3CfOcMpn9LkSC+c2sJEicVL8q44wGbhk9KlE7IcFOJLZQQZJ1zO1+3ZOwN+zijwwNtFTM53s9QlZGcl7S48IWu3Zws9vL6xG9EAXbH/BRJi0cYkBOfs1BkfcKFOW0C/FG0aEWRx+G+5ZvUZq85qS0i6Y0yzm/gNYfLFyIuO+hyDbUX8JgYvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0OQlskoArvrWrac6VAf0XEjOXPXHdsDx3DDPso3QLE=;
 b=XRlDvbRrVWRmhjXhm3MegG51mD6cHqZs0TiWGF4EY1VqQZfqDxqT8bmK8VRwZYEpnuVwNR5m9TBOA6v6HMnhrAOGbJabRBNYnzziqOfOOUPLc90LjgEGNSdpKVY8CUWcqEN6e05Ulcu98a5eEJ9Cuhq1KR5tTY+q/MvDUwLly8QI0MZ5I+3kzHCnwhcb9wU+xQ4Z3I5N3uK8l1OwpZAfHk4jqadAn0nkrdlvLBN79nr3A9iQXXJ4xNKpJgED4xP5gdvyPOD6zlj6FFubUoLQaTTqGY0ntpWKsDKehs5dFgbeuhcqLDes7bZlbAWtYqCNjTSreAfXKBXUkF7AdbF+Wg==
Received: from SJ0P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::22)
 by CY3PR12MB9630.namprd12.prod.outlook.com (2603:10b6:930:101::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Mon, 5 Oct
 2026 07:03:30 +0000
Received: from BY1PEPF00026958.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::58) by SJ0P220CA0014.outlook.office365.com
 (2603:10b6:a03:41b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 07:03:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF00026958.mail.protection.outlook.com (10.167.244.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 5 Oct 2026 07:03:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 00:03:10 -0700
Received: from NV-9TMPJL3.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 00:03:05 -0700
From: Ankit Agrawal <ankita@nvidia.com>
To: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>, <jgg@nvidia.com>,
	<aneesh.kumar@kernel.org>, <aik@amd.com>, <yilun.xu@linux.intel.com>,
	<iweiny@kernel.org>, <ming.li@zohomail.com>, <icheng@nvidia.com>,
	<bhelgaas@google.com>, <smadhavan@nvidia.com>, <ankita@nvidia.com>,
	<ilpo.jarvinen@linux.intel.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<andriy.shevchenko@linux.intel.com>, <linux-coco@lists.linux.dev>
Subject: [RFC PATCH 1/4] PCI/TSM: Create MMIO descriptors via TDISP Report
Date: Mon, 5 Oct 2026 09:02:49 +0200
Message-ID: <20261005070252.84810-2-ankita@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005070252.84810-1-ankita@nvidia.com>
References: <20261005070252.84810-1-ankita@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026958:EE_|CY3PR12MB9630:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e867dfd-60ab-467a-e1f2-08df22aec316
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700016|1800799024|376014|23010399003|13003099007|18002099003|22082099003|6133799003|10067099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	Zvb5jgTp3vmtpu9I/9yo3O9OpE75qUkTQ13B9NiEdrteBGYdSdgoEepOlnnSCfEaM+sQizmzVIysc+gwYn4jUHqvk8Y6tclkmU/r7d6PC1/cvZyclGrnduCSEwK+nRvA8wokF7CNX6BFmmyyNzjf+Q625kkrPinvdpCikru5XxnDnxtVdbeIemdnbphrHkz7l9qL5dVtPssZVVicy1QDM+z83QZSenmBCdgQ99GDaoIenMDmFY3N3/LJWJVAAvZn3BoPal1DgJx7WrgCjXPN0EY47TbQkT31d5O1f2LRd2VZNyK4NGtqz2TZY3C12rh8UnSVv8QPYZf9yFu+gOmr1TkrGiVrV4U4FxgBNpaAlWunam5xwPy1GDc+nZhZZcaWtNBtIrpke4Tf3XqILCnrvyg4UF4jaI9QvFA9cBgv/LFzywyLymdGbJrBfhHjj69IFP6dgwQEYdO3yX1dIqjqeYwH+3e4oOqL5l0gEXeliLoJc+m1id+BZPz+iOWrt4UR6GQcl/B/VdwA0XIFO/BVtqQjuYr4v/lMBIAHDeKiZiftMoDqgZ+CXihHQYikDzN0kCsfc6I8kBov362BqA/yRiKFWywqjT4BbjbaRIfll+MPp1gxTRrh+njonWeKRbPiuoHcMeQFV+bvEhR1JCxdWAZ8XtqSeDJH4diAS4vxv7NXJU1DE+qojv/ZCYblEjG+HXDbDv0lvkfEzJ5bVvlIkw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700016)(1800799024)(376014)(23010399003)(13003099007)(18002099003)(22082099003)(6133799003)(10067099003)(3023799007)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5Sp3weGB6tp2ZbNCOhvkndCvT9ZLoMkzV6LT/RBBKAqtFvJTjWSP5ORFEQ3kOmFdkH3ZVPs6PmEgkEuKsCiRKhTAy4pubM7NPt5elS73ynLmbtY/igzM3rwW7z7YCo56akLueDFqMlMqPXHcTXN4j8sdM+QA9R4aKjSXhgyRX8te442wwa6lGon1vmFGOEjvwQEVjY2vpsHlSkJL1Hv8gDZ8a8WpStXXD2Uzi5pCC/G5Lj5AvwVv8NxJfFyM9cD9iGP9o2xgWiToi0xXmNlz8BZ6KCILhSG+I+3sD7QFNacU3GMrKd9jtO1weEOBLALLpyNwzlDbz7y/G2hc5tIHc9eRoXiJYkfYCIxPkg+xtv2ONDAZ9f4EmcoI72o5yerr3X+60VaqCwovOCu9pYHNrMGcDAK+9XSMn04J7LZSrpNAFKABv/Gbxz9/eOr8SY3Y
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 07:03:30.1356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e867dfd-60ab-467a-e1f2-08df22aec316
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF00026958.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9630

After pci_tsm_bind() and pci_tsm_lock() the low level TSM driver is
expected to populate the TDISP GET_DEVICE_INTERFACE_REPORT response
payload for the device.

Add pci_tsm_mmio_alloc()/pci_tsm_mmio_free() to parse that report into
a set of encrypted MMIO ranges, and pci_tsm_mmio_setup()/
pci_tsm_mmio_teardown() to mark those ranges as encrypted in iomem via
a new encrypted_iomem_resource tree (IORES_DESC_ENCRYPTED). With those
descriptors the TSM driver can use pci_tsm_mmio_setup() to inform
ioremap() how to map the device per the device expectations. The VM
is expected to validate the interface with the relying party before
accepting the device for operation.

pci_tsm_mmio_alloc() also recovers the obfuscated starting address for
each encrypted MMIO range, since the VM is never disclosed the HPA
that correlates to the GPA of the device's MMIO. The obfuscated
address is BAR aligned.

Based on an original patch by Aneesh Kumar K.V [1], and cherry-picked
from Dan Williams' upstream commit [2]. Major functional differences
from Dan's posting is due to the lack of evidence-store infrastructure
yet (device_evidence / DEVICE_EVIDENCE_TYPE_REPORT). The
pci_tsm_mmio_alloc() takes the raw report bytes directly from the caller
instead of pulling them from a device evidence store.

Link: https://lore.kernel.org/linux-coco/20251117140007.122062-8-aneesh.kumar@kernel.org/ [1]
Link: https://lore.kernel.org/all/20260705220819.2472765-15-djbw@kernel.org/ [2]

Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
Assisted-by: Claude:sonnet-5
---
 drivers/pci/tsm.c       | 236 ++++++++++++++++++++++++++++++++++++++++
 include/linux/ioport.h  |   2 +
 include/linux/pci-tsm.h |  33 ++++++
 kernel/resource.c       |   8 ++
 4 files changed, 279 insertions(+)

diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
index 5fdcd7f2e820..c8cfe89b6224 100644
--- a/drivers/pci/tsm.c
+++ b/drivers/pci/tsm.c
@@ -9,11 +9,16 @@
 #define dev_fmt(fmt) "PCI/TSM: " fmt
 
 #include <linux/bitfield.h>
+#include <linux/overflow.h>
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
 #include <linux/pci-tsm.h>
+#include <linux/range.h>
+#include <linux/sizes.h>
+#include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/tsm.h>
+#include <linux/unaligned.h>
 #include <linux/xarray.h>
 #include "pci.h"
 
@@ -898,3 +903,234 @@ int pci_tsm_doe_transfer(struct pci_dev *pdev, u8 type, const void *req,
 		       resp, resp_sz);
 }
 EXPORT_SYMBOL_GPL(pci_tsm_doe_transfer);
+
+static void mmio_teardown(struct pci_tsm_mmio *mmio, int nr)
+{
+	while (nr--) {
+		struct resource *res = pci_tsm_mmio_resource(mmio, nr);
+
+		/*
+		 * Entries past the point where pci_tsm_mmio_setup() stopped
+		 * (or that were never run through setup() at all, e.g. a
+		 * caller that only wants the resolved range from
+		 * pci_tsm_mmio_alloc()) were never insert_resource()'d, so
+		 * res->parent is NULL. remove_resource() dereferences
+		 * res->parent unconditionally.
+		 */
+		if (res->parent)
+			remove_resource(res);
+	}
+}
+
+/**
+ * pci_tsm_mmio_setup() - mark device MMIO as encrypted in iomem
+ * @pdev: device owner of MMIO resources
+ * @mmio: container of an array of resources to mark encrypted
+ */
+int pci_tsm_mmio_setup(struct pci_dev *pdev, struct pci_tsm_mmio *mmio)
+{
+	int i;
+
+	device_lock_assert(&pdev->dev);
+	if (pdev->dev.driver)
+		return -EBUSY;
+
+	for (i = 0; i < mmio->nr; i++) {
+		struct resource *res = pci_tsm_mmio_resource(mmio, i);
+		int j;
+
+		if (resource_size(res) == 0 || !(res->flags & IORESOURCE_MEM))
+			break;
+
+		/* Only require the caller to set the range, init remainder */
+		*res = DEFINE_RES_NAMED_DESC(res->start, resource_size(res),
+					     pci_name(pdev), IORESOURCE_MEM,
+					     IORES_DESC_ENCRYPTED);
+
+		for (j = 0; j < PCI_NUM_RESOURCES; j++)
+			if (resource_contains(pci_resource_n(pdev, j), res))
+				break;
+
+		/* Request is outside of device MMIO */
+		if (j >= PCI_NUM_RESOURCES)
+			break;
+
+		if (insert_resource(&encrypted_iomem_resource, res) != 0)
+			break;
+	}
+
+	if (i >= mmio->nr)
+		return 0;
+
+	mmio_teardown(mmio, i);
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(pci_tsm_mmio_setup);
+
+void pci_tsm_mmio_teardown(struct pci_tsm_mmio *mmio)
+{
+	mmio_teardown(mmio, mmio->nr);
+}
+EXPORT_SYMBOL_GPL(pci_tsm_mmio_teardown);
+
+/*
+ * PCIe ECN TEE Device Interface Security Protocol (TDISP)
+ *
+ * Device Interface Report data object layout as defined by PCIe r7.0 section
+ * 11.3.11
+ */
+#define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_MSIX_TABLE BIT(0)
+#define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_MSIX_PBA BIT(1)
+#define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_IS_NON_TEE BIT(2)
+#define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_IS_UPDATABLE BIT(3)
+#define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_RANGE_ID GENMASK(31, 16)
+
+/* An interface report 'pfn' is 4K in size */
+struct pci_tsm_devif_mmio {
+	__le64 phys;
+	__le32 nr_pfns;
+	__le32 attributes;
+};
+
+struct pci_tsm_devif_report {
+	__le16 interface_info;
+	__le16 reserved;
+	__le16 msi_x_message_control;
+	__le16 lnr_control;
+	__le32 tph_control;
+	__le32 mmio_range_count;
+	struct pci_tsm_devif_mmio mmio[];
+};
+
+/**
+ * pci_tsm_mmio_alloc() - allocate encrypted MMIO range descriptor
+ * @pdev: device owner of MMIO ranges
+ * @report: raw TDISP Device Interface Report bytes (PCIe r7.0 section
+ *	    11.3.11), e.g. as returned by GET_DEVICE_INTERFACE_REPORT
+ * @report_len: length of @report in bytes
+ *
+ * Return: the encrypted MMIO range descriptor on success, NULL on failure
+ *
+ * Unlike upstream, @report is supplied directly by the caller rather than
+ * pulled from a device evidence store, which this tree does not yet have.
+ */
+struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_dev *pdev,
+					const void *report, size_t report_len)
+{
+	const struct pci_tsm_devif_report *devif_report = report;
+	u64 reporting_bar_base, last_reporting_end;
+	u32 mmio_range_count;
+	int last_bar = -1;
+	int i;
+
+	if (report_len < sizeof(*devif_report))
+		return NULL;
+
+	mmio_range_count = __le32_to_cpu(devif_report->mmio_range_count);
+
+	/* check that the report is self-consistent on mmio entries */
+	if (report_len < struct_size(devif_report, mmio, mmio_range_count))
+		return NULL;
+
+	/* create pci_tsm_mmio descriptors from the report data */
+	struct pci_tsm_mmio *mmio __free(kfree) =
+		kzalloc_flex(*mmio, mmio, mmio_range_count);
+	if (!mmio)
+		return NULL;
+
+	for (i = 0; i < mmio_range_count; i++) {
+		u64 range_off;
+		struct range range;
+		const struct pci_tsm_devif_mmio *mmio_data = &devif_report->mmio[i];
+		struct pci_tsm_mmio_entry *entry =
+			pci_tsm_mmio_entry(mmio, mmio->nr);
+		u64 tsm_offset = __le64_to_cpu(mmio_data->phys);
+		u64 size = (u64)__le32_to_cpu(mmio_data->nr_pfns) * SZ_4K;
+		u32 attr = __le32_to_cpu(mmio_data->attributes);
+		int bar = FIELD_GET(PCI_TSM_DEVIF_REPORT_MMIO_ATTR_RANGE_ID,
+				    attr);
+
+		if (bar >= PCI_STD_NUM_BARS ||
+		    !(pci_resource_flags(pdev, bar) & IORESOURCE_MEM) ||
+		    (pci_resource_flags(pdev, bar) & IORESOURCE_UNSET)) {
+			pci_dbg(pdev, "Invalid reporting bar ID %d\n", bar);
+			return NULL;
+		}
+
+		if (last_bar > bar) {
+			pci_dbg(pdev, "Reporting bar ID not in ascending order\n");
+			return NULL;
+		}
+
+		if (last_bar < bar) {
+			resource_size_t mask = pci_resource_len(pdev, bar) - 1;
+
+			/* Transition to a new bar */
+			last_bar = bar;
+
+			/*
+			 * Determine the obfuscated base of the BAR. BAR
+			 * offsets are never obfuscated.
+			 */
+			reporting_bar_base = tsm_offset & ~mask;
+		} else if (tsm_offset < last_reporting_end) {
+			pci_dbg(pdev, "Reporting ranges within BAR not in ascending order\n");
+			return NULL;
+		}
+
+		/* Per spec the tsm_offset never results in overflow / underflow */
+		last_reporting_end = tsm_offset + size;
+		if (last_reporting_end < tsm_offset) {
+			pci_dbg(pdev, "Reporting range overflow\n");
+			return NULL;
+		}
+
+		range_off = tsm_offset - reporting_bar_base;
+		if (pci_resource_len(pdev, bar) < range_off + size) {
+			pci_dbg(pdev, "Reporting range larger than BAR size\n");
+			return NULL;
+		}
+
+		range.start = pci_resource_start(pdev, bar) + range_off;
+		range.end = range.start + size - 1;
+
+		/* Only record the TEE ranges for later consideration by ioremap() */
+		if (FIELD_GET(PCI_TSM_DEVIF_REPORT_MMIO_ATTR_IS_NON_TEE,
+			      attr)) {
+			pci_dbg(pdev, "Skipping non-TEE range, BAR%d %pra\n",
+				bar, &range);
+			continue;
+		}
+
+		entry->res.start = range.start;
+		entry->res.end = range.end;
+		entry->res.flags = IORESOURCE_MEM;
+		entry->tsm_offset = tsm_offset;
+		mmio->nr++;
+	}
+
+	return_ptr(mmio);
+}
+EXPORT_SYMBOL_GPL(pci_tsm_mmio_alloc);
+
+/**
+ * pci_tsm_mmio_free() - free a pci_tsm_mmio instance
+ * @pdev: device owner of MMIO ranges
+ * @mmio: instance to free
+ *
+ * Returns 0 if @mmio was idle on entry, -EBUSY otherwise
+ */
+int pci_tsm_mmio_free(struct pci_dev *pdev, struct pci_tsm_mmio *mmio)
+{
+	for (int i = 0; i < mmio->nr; i++) {
+		struct resource *res = pci_tsm_mmio_resource(mmio, i);
+
+		if (dev_WARN_ONCE(&pdev->dev, resource_assigned(res),
+				  "MMIO resource still assigned %pr\n", res))
+			return -EBUSY;
+	}
+	kfree(mmio);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_tsm_mmio_free);
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index f7930b3dfd0a..122f1eefb4b9 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -144,6 +144,7 @@ enum {
 	IORES_DESC_RESERVED			= 7,
 	IORES_DESC_SOFT_RESERVED		= 8,
 	IORES_DESC_CXL				= 9,
+	IORES_DESC_ENCRYPTED			= 10,
 };
 
 /*
@@ -240,6 +241,7 @@ struct resource_constraint {
 extern struct resource ioport_resource;
 extern struct resource iomem_resource;
 extern struct resource soft_reserve_resource;
+extern struct resource encrypted_iomem_resource;
 
 extern struct resource *request_resource_conflict(struct resource *root, struct resource *new);
 extern int request_resource(struct resource *root, struct resource *new);
diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
index a6435aba03f9..e54ad057fa8e 100644
--- a/include/linux/pci-tsm.h
+++ b/include/linux/pci-tsm.h
@@ -199,6 +199,34 @@ enum pci_tsm_req_scope {
 	PCI_TSM_REQ_DEBUG_WRITE = 3,
 };
 
+/**
+ * struct pci_tsm_mmio_entry - an encrypted MMIO range
+ * @res: MMIO address range (typically Guest Physical Address, GPA)
+ * @tsm_offset: Host Physical Address, HPA obfuscation offset added by the TSM.
+ *		Translates report addresses to GPA.
+ */
+struct pci_tsm_mmio_entry {
+	struct resource res;
+	u64 tsm_offset;
+};
+
+struct pci_tsm_mmio {
+	int nr;
+	struct pci_tsm_mmio_entry mmio[];
+};
+
+static inline struct pci_tsm_mmio_entry *
+pci_tsm_mmio_entry(struct pci_tsm_mmio *mmio, int idx)
+{
+	return &mmio->mmio[idx];
+}
+
+static inline struct resource *pci_tsm_mmio_resource(struct pci_tsm_mmio *mmio,
+						     int idx)
+{
+	return &mmio->mmio[idx].res;
+}
+
 #ifdef CONFIG_PCI_TSM
 int pci_tsm_register(struct tsm_dev *tsm_dev);
 void pci_tsm_unregister(struct tsm_dev *tsm_dev);
@@ -216,6 +244,11 @@ void pci_tsm_tdi_constructor(struct pci_dev *pdev, struct pci_tdi *tdi,
 ssize_t pci_tsm_guest_req(struct pci_dev *pdev, enum pci_tsm_req_scope scope,
 			  sockptr_t req_in, size_t in_len, sockptr_t req_out,
 			  size_t out_len, u64 *tsm_code);
+int pci_tsm_mmio_setup(struct pci_dev *pdev, struct pci_tsm_mmio *mmio);
+void pci_tsm_mmio_teardown(struct pci_tsm_mmio *mmio);
+struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_dev *pdev,
+					const void *report, size_t report_len);
+int pci_tsm_mmio_free(struct pci_dev *pdev, struct pci_tsm_mmio *mmio);
 #else
 static inline int pci_tsm_register(struct tsm_dev *tsm_dev)
 {
diff --git a/kernel/resource.c b/kernel/resource.c
index cfc1a00e86aa..5500f7828b2d 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -56,6 +56,14 @@ struct resource soft_reserve_resource = {
 	.flags	= IORESOURCE_MEM,
 };
 
+struct resource encrypted_iomem_resource = {
+	.name	= "Encrypted MMIO",
+	.start	= 0,
+	.end	= -1,
+	.desc	= IORES_DESC_ENCRYPTED,
+	.flags	= IORESOURCE_MEM,
+};
+
 static DEFINE_RWLOCK(resource_lock);
 
 /*
-- 
2.43.0

