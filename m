Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012000.outbound.protection.outlook.com [52.101.48.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B58552CCC2;
	Tue, 22 Sep 2026 08:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066399; cv=fail; b=dUW8NDKTblDEFvtQl9pP/BT/PdkELn6cwep+4HpgCtwAREqwcH4jkLo3IUes8SOFpvfMRAmWlvaW1xUbnnwAbQ5upsR3kXetIwp3pzYm0VnY+Pxqeb+7FIyBS+49Tw3xc2OR/LvdH/CHCIWInEfaTUrzzTr9++s9+pXAmw934jM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066399; c=relaxed/simple;
	bh=hDZsdtDE9RWHLL+QUVBOZhcCERPe0oNYEGN8I17DPQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I5D7QiKEjJUYHeOrnimZuTut6DO8Ywcn7rzbOsC7yL/3l1Zx6g9v7bjU1AMnw25Jhzsf07FqwqktLrBH6tFstemy2ua7jtfH54+hDlbMP1lvN+HoKkUoR14V3wIsfbraWc5lqv3ZqcKTWP21P1j7wmF4C5mmBumg00CF1ZKEcG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tcLcPAJJ; arc=fail smtp.client-ip=52.101.48.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tcLcPAJJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FuUTk8Fchq3PjSilneXLhN4aDyf8Z9BqAJW0F4cZf88ZJ7ZpbaP87h0yKfVrk4qEvGXE7bwoQAqnOTFy5DXT+AbkJ7N/IG4Ssf5qu3DHfTHKavSnlBDtYijUt7bOwPH05wnpXmnImMyIbrYHzVf/k9fDXzkahzvlE+ZDWU7uvLMttk4+IXN9xvz4tLpgbd5abfRVU2CbxeircR4zJb/wBtWFetk1aqpnRPSrdEQjgnI9DvO1QH2oGQywd1aT1YE3pEXIhyrfQAYQgYazsEZ6HM4iUYecQMcvMTUeEyBugpJScYig4xHf/RH9C6nmkOLCg4GmRmI3z0ojZQRvc2uPUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtbwWEzh7J4Fn2GgwKjBjrDzLsiupggCMQMiACek9xI=;
 b=L+jkFADkl3t4a5KtOAKkKmHrKL3HKrqGWOReI+6E+Ca48FOyYFbzmirmAfPiQa6nccpFx5S6TxbNUeI4OfY/Q+MD7t67Nced74mjvXnKpKZe5ZQXVHKBgFZiY1KuEVEbMJuiy0cAT+3ZeK4LPA5j9sWB1c0QIHhi8ILzNgen3hMC8uJKE5C5ZFBzyhXx/QyB9gMGE5BXhkSNoi6GB8CG0NLZVRlIyU9FyvqOIke4d4a8wGDpKKntA6JSacC8iK4IbJTIIrTa+VREbfz6cgsQg4fw2ShNLtXFIB+pHV11AVBEflbECjtpvafjSdb0tSNg72iTj6UZkefPdnlL4yme6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtbwWEzh7J4Fn2GgwKjBjrDzLsiupggCMQMiACek9xI=;
 b=tcLcPAJJJAcj1zthXCHv4xBRSpPEUQ3fLxnLRZ1MvNukwiYdEPWVno3ZvKLfddsfQ6xTTGlzbcTjAQvmTdJSSgcSLOV2F97xaWiU8FOe4CYc4qgX8M6E4RGoCx+qy7I9XuaOqPo9WPv+zsejw2Pv4k5q7Ft1SlMtxnC/rEBwFyTN+qu5aer0cC6C4Yuvkp5TwkcEg7qydbmEZqYP/e207tYT4U3LsekJTlKVkAYvpASopvekvVqWly6fKr78sxbSIhmrz2rN4ozV8Odpzttg/teR0VQVeLZ8DL+If4txZn6Ho0cs+k0sGlgC+AAuCKZJWY72qTIxYP3+uOSMFEPdNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by CHAPR12MB999223.namprd12.prod.outlook.com
 (2603:10b6:610:301::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 08:39:52 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 08:39:52 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v13 10/15] cxl: Add CXL Device Reset sequencing
Date: Tue, 22 Sep 2026 08:39:19 +0000
Message-ID: <20260922083924.2451158-11-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922083924.2451158-1-smadhavan@nvidia.com>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0122.namprd03.prod.outlook.com
 (2603:10b6:303:8c::7) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|CHAPR12MB999223:EE_
X-MS-Office365-Filtering-Correlation-Id: d392a2ba-ec8f-4137-c863-08df188511d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|921020|6133799003|3023799007|10067099003|5023799004|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	je4O6/3Em0CVLFpWTpwLu+KI+2K2PVlng2ye/KTytzpa+Brf5nRztz/hsdq+P7/+27ggaerRvPbrhK+g9wW2IbFqPcDGzligvUuJcVibbRQQil7vG5+B8dOkepbFDGca64nE59WxZDs09GEUtcvy8wUsXQ6DyQTvh68XypqKuYA78D1boQkuFOb427X8POflksQDrekxLAOw+7Mr4t4yqKMoz9I3Ev2/0wzX6uc/YvC/XrLrI0lddzfLwA3iKMtFW2/nOGPOtXW7VmkuNF9iFzphqJ/ETqEZruw+10E/755XXiq1dRIFlPPthjxEzC3clsOQk9SvkRLEXPwRJefPM5mW4mEb1JQzgE/c5NBlqSyzFkWfpK/Od/nIyGKCS7Q3UClJ7RLd1AAUOHzaiSJtmMpdIVkbEOEgOiJmGe8fioCijdpnDdHlIdavGCJDtuXrcFDeBJTF8RnOkgUBJLrdHSgUdGB25ZxCiXd6J2X83LP2UxM35iQ9skB9HB0UwrUe8T/9QkVUnwaqW7gE0s7OkANWQvyeqkpCNqHgelNi7Wd9j7dszhdlH7m3dxgXKQ6mRaJuNjxhXaXS/Nu8QH4Z8lwOwDJZjH3UF+82PIF5TXDUvJGuM3i8jIl1Cb9rpT3PmIip1IpbpcIVyeI2EZXVXHY4+aw1HrLRn1C0/V5WcIQyGJyxkUPUhibQbS8Tcwpq6psa2+arUzZvMYKXn8NZ4Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(921020)(6133799003)(3023799007)(10067099003)(5023799004)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L7IsVj6t5+WFjro8Zynp5rbKhajXMTkhtD+JbpuvoBRHHoNJEdg6f7Dz5xyA?=
 =?us-ascii?Q?s6uY9hRcJFA5JddPt4VU/V2RvkA28JoSnAoHZeRj+1lzWDxUMScC90GIYZsv?=
 =?us-ascii?Q?0D4B54wYE2VS47jWx8ir7rURm0MWFkcrO37fG5+9LHVsOnoBi1gJjQVXZUXZ?=
 =?us-ascii?Q?AqsOLjbM4dGO7VR0ufSr8VMVlnZoutobe+1/5gIEYFikLs5VOmZJbNm5Nwp9?=
 =?us-ascii?Q?NWKGxFUSSh4WfEPVjZz3v/KDY0P06i7cCJymCH0SUIekuSOF4KqSQzuDn7fq?=
 =?us-ascii?Q?56Js9JyzUeRxFrm6r66lZtjvPs6HPBjUY5PdTQ1uOw8M+hr+VUWZIChtLrSr?=
 =?us-ascii?Q?Yql1T7dESKuh+l1o5lHr4rs6KAXLugRdtmJqz5NBsDGLzYgnUj6g5gOuxErD?=
 =?us-ascii?Q?dcCzJf/inSJfA+90nTujgnXKJ58c+7MtYchndK7ux9ZR9FUG/lAbcPxyi7I6?=
 =?us-ascii?Q?/hT7wvPWRFNUAsCbUi4onRkT4pKbHFaGKcy1WcOdzB7Q6oKiNlK66GpJngqy?=
 =?us-ascii?Q?8MKA1HB2OpU1Z8vpWbogfwngj0nSXrzAV278Fjmtrw3K7FQV1GowamY9QKIO?=
 =?us-ascii?Q?XlOoKLYxCfCKd8Ed7/iI5gFeoK8G8Nj5g/SUC6UsemSjAgom1HPMsKGSbj1+?=
 =?us-ascii?Q?sKVeouh5jHfOrojyfGVgraYuHVFO+inbwej74HD2xq3YQKACQxEdp9N5z0Z7?=
 =?us-ascii?Q?leIzpG/FQ5S7JIN1Ru0Z+2aFXYwqiLLXpMYrWYCpaB0SlVnrm3KOQDaPPLCw?=
 =?us-ascii?Q?Hf2fIoVkRlcFGmFUm8LjpBtI0slHROW8MIsB0Dxq2JGCy8900+JPqMg5wmsD?=
 =?us-ascii?Q?uyERXTgYcG6LVGF2dzLYsGDD44pO+r12fjn+Ip8UKQ5oqJylWIrWlWMdiO1e?=
 =?us-ascii?Q?UjlK4rqstKmOIWorNGyFxzs40xx+4tE2L5NpvKiFvB8jZ0Mb0ShYA3AG8pan?=
 =?us-ascii?Q?q3VhETJ6oAnINn19HvaijxsUFjSsKLTZNLuXoq4Uc1tgOBv8V8DBi58Hpfaf?=
 =?us-ascii?Q?9NvI0Ynx4xK7PTFyxL+ras9GXa1IuZ6Yaf67PrZlu5M+op01/b7zYcX2gKkJ?=
 =?us-ascii?Q?QpDVRFQhTzQhVRov16w4sSC3CY339VKGajv9GPB9CxuHRlAA0zQ349KnZV95?=
 =?us-ascii?Q?qFSknjVwFPityEaHirovk4o588TE1853WaNZAnFFJ9e7/qKyvnO+h7M4id6Q?=
 =?us-ascii?Q?/fhZaitqcYfj3AbHjC/ufxuwgzCzCTHEbCSNyTS5CSs94mjDO7It8eGL+Z8b?=
 =?us-ascii?Q?HHnnKajFuyP5/IcOKbDuxRZ58QeMBZvRWxr0jpi0mCdUFw0RmQOyQkanmQGG?=
 =?us-ascii?Q?wB+HZzXdy8Qn/McxUIoRe2KqGvlHnX9q2HPHuKEjO21+768RYt/EsMWwlVTC?=
 =?us-ascii?Q?joLW1P/7PPYayZWuTMn3ltzGCrQ0NoGTkE+KQvHl8ClWHXtwjx6U+Z5xcSuG?=
 =?us-ascii?Q?yET1yb5LTkZ6YZ2KuEcvAstuXJuRgnPpBBzB/t49qR3bkGdmxB1wwq9m83rT?=
 =?us-ascii?Q?ZHCVVop/pS1j7qoDkAChjVanz73YzyhE5qN2p93i7A1AykL5ODbbhbZn98xd?=
 =?us-ascii?Q?jQYsnXzCD7W5XrvL//wBjfZtBOOqQj7lV6rN6paBIsNMkjnA9Ry6WHct0eAj?=
 =?us-ascii?Q?rjJGmP5//sLwLIkv5PBF4Ipm89pXVDurwE8OdKcusTfAyBRhnLhMnuDVW3TT?=
 =?us-ascii?Q?1hNGzS2XIxHDsXkrAdbccM1JHbhC/VviQTYXuMKjgdzF3S7NnZhaOKXzmiAO?=
 =?us-ascii?Q?m6cTo/WAyw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d392a2ba-ec8f-4137-c863-08df188511d7
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 08:39:51.9510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uTfDIAeeIJevoFaudPMjklffEBfLQ721wzMnpUPWJmIpbGZxFsUlSKIdPoqsuNQESJyVos1YBhGsJi30YQDycA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999223

Implement CXL Device Reset for eligible Type 2 devices: disable CXL.cache,
perform supported writeback, drain transactions, prepare the IOMMU,
initiate reset with Memory Clear enabled, and wait for completion.

Observe the 100 ms post-reset quiet period before polling Status2, and
treat an all-ones read as not ready. Treat Control2 command bits as
transient state, restore cache policy on exit, preserve the primary error,
and abort when IOMMU preparation fails.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/resource.c   | 229 ++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h             |   7 ++
 include/uapi/linux/pci_regs.h |  14 +++
 3 files changed, 250 insertions(+)

diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
index b5f8c28e613f..57eec77cbb21 100644
--- a/drivers/cxl/core/resource.c
+++ b/drivers/cxl/core/resource.c
@@ -8,6 +8,8 @@
 #include <linux/export.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
+#include <linux/iommu.h>
+#include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
@@ -419,3 +421,230 @@ void pci_cxl_hdm_cache_release(struct pci_dev *pdev)
 	pdev->hdm = NULL;
 	kfree(info);
 }
+
+/*
+ * CXL r4.0 sec 9.7.2 defines the reset completion timeout encodings.
+ * Sec 9.7.3 leaves config-space access behavior undefined for 100 ms after
+ * initiating CXL Reset, then limits software to CXL Status2 access until
+ * reset completion, timeout, or error.
+ */
+#define CXL_RESET_RRS_WAIT_MS 100
+#define CXL_RESET_STATUS_POLL_MS 20
+static const u32 cxl_reset_timeout_ms[] = {
+	10, 100, 1000, 10000, 100000,
+};
+
+#define CXL_CACHE_WBI_TIMEOUT_US 100000
+#define CXL_CACHE_WBI_POLL_US 100
+
+#define CXL_RESET_CTRL2_CMD_MASK \
+	(PCI_DVSEC_CXL_INIT_CACHE_WBI | PCI_DVSEC_CXL_INIT_CXL_RST)
+
+static int cxl_reset_update_ctrl2_no_replay(struct pci_dev *pdev, int dvsec,
+					    u16 set, u16 clear)
+{
+	u16 ctrl2;
+	int rc;
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, &ctrl2);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+	if (PCI_POSSIBLE_ERROR(ctrl2))
+		return -ENODEV;
+
+	/*
+	 * INIT_CACHE_WBI and INIT_CXL_RST are commands. Do not replay a command
+	 * that remains set in the value read back while updating persistent
+	 * Control2 state.
+	 */
+	ctrl2 &= ~CXL_RESET_CTRL2_CMD_MASK;
+	ctrl2 &= ~clear;
+	ctrl2 |= set;
+
+	rc = pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, ctrl2);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+
+	return 0;
+}
+
+static int cxl_reset_wait_cache_wbi(struct pci_dev *pdev, int dvsec)
+{
+	unsigned long deadline;
+	u16 status2;
+	int rc;
+
+	rc = cxl_reset_update_ctrl2_no_replay(pdev, dvsec,
+					      PCI_DVSEC_CXL_INIT_CACHE_WBI, 0);
+	if (rc)
+		return rc;
+
+	deadline = jiffies + usecs_to_jiffies(CXL_CACHE_WBI_TIMEOUT_US);
+	while (time_before(jiffies, deadline)) {
+		usleep_range(CXL_CACHE_WBI_POLL_US,
+			     CXL_CACHE_WBI_POLL_US * 2);
+
+		rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
+					  &status2);
+		if (rc)
+			return pcibios_err_to_errno(rc);
+		if (PCI_POSSIBLE_ERROR(status2))
+			return -ENODEV;
+		if (status2 & PCI_DVSEC_CXL_CACHE_INV)
+			return 0;
+	}
+
+	/* Do not miss completion concurrent with the polling deadline. */
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
+				  &status2);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+	if (PCI_POSSIBLE_ERROR(status2))
+		return -ENODEV;
+	if (status2 & PCI_DVSEC_CXL_CACHE_INV)
+		return 0;
+
+	return -ETIMEDOUT;
+}
+
+static int cxl_reset_disable_cache(struct pci_dev *pdev, int dvsec, u16 cap)
+{
+	int rc;
+
+	rc = cxl_reset_update_ctrl2_no_replay(pdev, dvsec,
+					      PCI_DVSEC_CXL_DISABLE_CACHING, 0);
+	if (rc || !(cap & PCI_DVSEC_CXL_CACHE_WBI_CAPABLE))
+		return rc;
+
+	return cxl_reset_wait_cache_wbi(pdev, dvsec);
+}
+
+static int cxl_reset_wait_done(struct pci_dev *pdev, int dvsec, u16 cap)
+{
+	unsigned long deadline;
+	u32 timeout_ms;
+	u16 status2;
+	int idx, rc;
+
+	idx = FIELD_GET(PCI_DVSEC_CXL_RST_TIMEOUT, cap);
+	if (idx >= ARRAY_SIZE(cxl_reset_timeout_ms)) {
+		int last = ARRAY_SIZE(cxl_reset_timeout_ms) - 1;
+
+		pci_warn(pdev,
+			 "unknown CXL reset timeout encoding %d; using %u ms\n",
+			 idx, cxl_reset_timeout_ms[last]);
+		idx = last;
+	}
+
+	timeout_ms = max_t(u32, cxl_reset_timeout_ms[idx],
+			   CXL_RESET_RRS_WAIT_MS);
+	msleep(CXL_RESET_RRS_WAIT_MS);
+	deadline = jiffies + msecs_to_jiffies(timeout_ms -
+					      CXL_RESET_RRS_WAIT_MS);
+
+	for (;;) {
+		rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
+					  &status2);
+		if (rc || status2 == U16_MAX)
+			goto not_ready;
+		if (status2 & PCI_DVSEC_CXL_RST_ERR)
+			return -EIO;
+		if (status2 & PCI_DVSEC_CXL_RST_DONE)
+			return 0;
+
+not_ready:
+		if (time_after_eq(jiffies, deadline))
+			return -ETIMEDOUT;
+
+		msleep(CXL_RESET_STATUS_POLL_MS);
+	}
+}
+
+static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
+{
+	int rc, rc2;
+
+	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
+	if (rc)
+		goto out_enable_cache;
+
+	if (!pci_wait_for_pending_transaction(pdev)) {
+		pci_err(pdev, "timed out waiting for pending transactions\n");
+		rc = -ETIMEDOUT;
+		goto out_enable_cache;
+	}
+
+	rc = pci_dev_reset_iommu_prepare(pdev);
+	if (rc) {
+		pci_err(pdev, "failed to stop IOMMU for CXL reset: %d\n", rc);
+		goto out_enable_cache;
+	}
+
+	/* Clear Memory Clear again even if this command write reports failure. */
+	rc = cxl_reset_update_ctrl2_no_replay(pdev, dvsec,
+					      PCI_DVSEC_CXL_INIT_CXL_RST |
+					      PCI_DVSEC_CXL_RST_MEM_CLR_EN, 0);
+	if (rc)
+		goto out_clear_memory;
+
+	rc = cxl_reset_wait_done(pdev, dvsec, cap);
+
+out_clear_memory:
+	rc2 = cxl_reset_update_ctrl2_no_replay(
+		pdev, dvsec, 0, PCI_DVSEC_CXL_RST_MEM_CLR_EN);
+	if (rc2)
+		pci_err(pdev, "failed to clear CXL Reset Memory Clear: %d\n",
+			rc2);
+	rc = rc ?: rc2;
+
+	pci_dev_reset_iommu_done(pdev);
+
+out_enable_cache:
+	/*
+	 * DISABLE_CACHING was the first preparation step. Restore the original
+	 * cache policy last, after reset exclusion has ended.
+	 */
+	rc2 = cxl_reset_update_ctrl2_no_replay(
+		pdev, dvsec, 0, PCI_DVSEC_CXL_DISABLE_CACHING);
+	if (rc2)
+		pci_err(pdev, "failed to re-enable CXL caching: %d\n", rc2);
+	rc = rc ?: rc2;
+
+	return rc;
+}
+
+int cxl_reset_function(struct pci_dev *pdev, bool probe)
+{
+	int dvsec, rc;
+	u16 cap, ctrl;
+
+	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_DEVICE);
+	if (!dvsec)
+		return -ENOTTY;
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+	if (PCI_POSSIBLE_ERROR(cap))
+		return -ENODEV;
+	if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE) ||
+	    !(cap & PCI_DVSEC_CXL_MEM_CAPABLE) ||
+	    !(cap & PCI_DVSEC_CXL_RST_CAPABLE) ||
+	    !(cap & PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE))
+		return -ENOTTY;
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL, &ctrl);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+	if (PCI_POSSIBLE_ERROR(ctrl))
+		return -ENODEV;
+	if (!(ctrl & PCI_DVSEC_CXL_CACHE_ENABLE) ||
+	    !(ctrl & PCI_DVSEC_CXL_MEM_ENABLE))
+		return -ENOTTY;
+
+	if (probe)
+		return 0;
+
+	return cxl_reset_execute(pdev, dvsec, cap);
+}
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 4bad41e74f74..a07dbf7463c0 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -6,6 +6,7 @@
 #define __CXL_CXL_H__
 
 #include <linux/device.h>
+#include <linux/errno.h>
 #include <linux/node.h>
 #include <linux/ioport.h>
 #include <linux/range.h>
@@ -201,6 +202,7 @@ struct cxl_register_map {
 #ifdef CONFIG_CXL_RESET
 void pci_cxl_hdm_cache_init(struct pci_dev *pdev);
 void pci_cxl_hdm_cache_release(struct pci_dev *pdev);
+int cxl_reset_function(struct pci_dev *pdev, bool probe);
 #else
 static inline void pci_cxl_hdm_cache_init(struct pci_dev *pdev)
 {
@@ -209,6 +211,11 @@ static inline void pci_cxl_hdm_cache_init(struct pci_dev *pdev)
 static inline void pci_cxl_hdm_cache_release(struct pci_dev *pdev)
 {
 }
+
+static inline int cxl_reset_function(struct pci_dev *pdev, bool probe)
+{
+	return -ENOTTY;
+}
 #endif
 
 /**
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index facaa324bd86..7224857c7b30 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1352,8 +1352,22 @@
 #define   PCI_DVSEC_CXL_CACHE_CAPABLE			_BITUL(0)
 #define   PCI_DVSEC_CXL_MEM_CAPABLE			_BITUL(2)
 #define   PCI_DVSEC_CXL_HDM_COUNT			__GENMASK(5, 4)
+#define   PCI_DVSEC_CXL_CACHE_WBI_CAPABLE		_BITUL(6)
+#define   PCI_DVSEC_CXL_RST_CAPABLE			_BITUL(7)
+#define   PCI_DVSEC_CXL_RST_TIMEOUT			__GENMASK(10, 8)
+#define   PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE		_BITUL(11)
 #define  PCI_DVSEC_CXL_CTRL				0xC
+#define   PCI_DVSEC_CXL_CACHE_ENABLE			_BITUL(0)
 #define   PCI_DVSEC_CXL_MEM_ENABLE			_BITUL(2)
+#define  PCI_DVSEC_CXL_CTRL2				0x10
+#define   PCI_DVSEC_CXL_DISABLE_CACHING			_BITUL(0)
+#define   PCI_DVSEC_CXL_INIT_CACHE_WBI			_BITUL(1)
+#define   PCI_DVSEC_CXL_INIT_CXL_RST			_BITUL(2)
+#define   PCI_DVSEC_CXL_RST_MEM_CLR_EN			_BITUL(3)
+#define  PCI_DVSEC_CXL_STATUS2				0x12
+#define   PCI_DVSEC_CXL_CACHE_INV			_BITUL(0)
+#define   PCI_DVSEC_CXL_RST_DONE			_BITUL(1)
+#define   PCI_DVSEC_CXL_RST_ERR				_BITUL(2)
 #define  PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i)		(0x18 + (i * 0x10))
 #define  PCI_DVSEC_CXL_RANGE_SIZE_LOW(i)		(0x1C + (i * 0x10))
 #define   PCI_DVSEC_CXL_MEM_INFO_VALID			_BITUL(0)
-- 
2.43.0

