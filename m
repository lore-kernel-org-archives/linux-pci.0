Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012071.outbound.protection.outlook.com [52.101.53.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADBE331EA4;
	Tue, 23 Jun 2026 03:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782185121; cv=fail; b=CyjU5o/X/GzHuYD+UNva2BtO/6ggfw6RhFcvODBzlnM0ThyJ8eGSnz6Yd6N2VaO+KnUVAAmvoeJmHYkP4nK4HGbuZ5D8kYdGw9NHwpmvvee5ufwRIC3RjbqSn8E5/tLBUtfLdxLA2oYgHQ8IZVVu+VH5wes876kCYJ6/42BSiLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782185121; c=relaxed/simple;
	bh=Vpdaz5iJ3H1ErDOFLAL5Unwhf4VK5SFSVjVnXgOFpg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cAAkOw6r8tbHhbW1NQBEmpMzkPwOM6O0p+0k0zr5dJsJ1mRSNmQBz4eFm9qVvEcT4UgJotqLc/j93vtZwUMqo/jqqJfOPGnTX8EQgYzq5iW2J5yoYZw9X2gmaQ3ibEFXfukmAvn0Jwwg5I0i7RKsqKbJtlFiiAb/9VJJM5rD6ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VYXuDWDi; arc=fail smtp.client-ip=52.101.53.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VYXuDWDi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=arZDi+7ZyhmspEr7nTtWI24lzgbuzNhbr0yXIWl5fV1S8qLplkZIDMK1OptOo32sJfROTzMEAGNwq4spqHbjBcd9gPqZAsyQg5YAPgv4NBTxkxZohdOBnatwkHhBmaxKn7VKV4BHRoJNQoYRJtZgjPugtv8UY2GI0B2uWjlyq4Ser7DZEM07Yt7s/duESU5JftYWJYG9/daJnSkwc3w73jUdajEB9nLSFfziaijb/7pHWw8+RnuOyqPV2HKvnFZS9PjYVl4vJuCRGZ4YKMdcV5c8cKc+MbRGhf2nW+QsShDprtOArp2sLmPNFzQyWoAhiCKZW7OcL/T8+LHqojCaFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYlAcLAcAb+SMCIx7y/jOxtnFXrnjIRhq4rvU5an+i4=;
 b=iETfvmNVf7nJwgmIdF57Z851WWifHZhatHpLEfO0N28CCxf/sstDlUjabAwUvwE3Xqa/PseEVxAHoozs8wheAgwoRbE2yryrXHWTFoJqSjdDl1CePgftH1XeMHOZt3HiOYm25nlOYw+QkI7eS60idXzdj8wjLlRp0HTD6gs4G4U5HbV0OAamrtCon8HVKoBpsIrbdwnPUaJc+rtVsKZMrZ5SdhcEcZ/q+BHyqkJ8zxFeSL0/wP/9Wm6yxftmP0Z0J6vxFq74q2O43l+RoqXibayi2usS3JGHojcrY0kCQHLZ4hqijTJr8lsbgfXySSQVTdK5Lo0LNeSiai0n3quB4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYlAcLAcAb+SMCIx7y/jOxtnFXrnjIRhq4rvU5an+i4=;
 b=VYXuDWDi+/36r3ddj/CZqzaB9stG5VKfcNoImY0Pao1/SBkseiyFAuRSARVNBM2AWTS7bDGnI2ON8JjS35tE4MAZ9MBD6x5hiB4al8AM9JXvgI1Tql6UrGb/CJ5JxWIef/4dQoPFDodPIoiEqNPkRtaHLgL1R5PaA+9t6+GXMOONGIuPsD9+/rDFdVmnV8BCNcgHKHRhuFePVySyF0TExwOky7QkoCH23CCTPqpUAZE0z5Lb0ZXKS3yud28ez1aMImj7RD1JnaFuhWXzBdV0YUT0uEQrWBfvt2CCkyhnK4TH0+zUgKYgJYqSNHnTA2qXrsH1pl4i1RHOBBy3KW2p3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by LV3PR12MB9144.namprd12.prod.outlook.com (2603:10b6:408:19d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 23 Jun
 2026 03:25:14 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 03:25:14 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <djbw@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Dan Williams <danwilliams@nvidia.com>,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v7 07/11] PCI/cxl: Discover the CXL reset scope
Date: Tue, 23 Jun 2026 03:24:49 +0000
Message-ID: <20260623032453.3404772-8-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260623032453.3404772-1-smadhavan@nvidia.com>
References: <20260623032453.3404772-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::23) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|LV3PR12MB9144:EE_
X-MS-Office365-Filtering-Correlation-Id: c9f7b3e7-7486-43da-1421-08ded0d70a1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|366016|376014|1800799024|6133799003|11063799006|56012099006|22082099003|18002099003|5023799004|921020;
X-Microsoft-Antispam-Message-Info:
	wDGiQeJg+kdkzRWGwbVPxkcq9O3KcjKRL4CN7CERbbFBYG3gK2wWw9BGdhNcbS1NB8wKCrx9RLzb2Oc1pLJzPtAHm/UWcvqgWzLmHhhdcYZf1rK8EtRcNKb54YUzNdTwSR9tkItIXlExAH8Jtve+mvDage4EVnMw2pKapp1CjrfAtTj25IXm9fecPn2Nf2MvPqxCoXpWV1trOHH9EhiGmFvPhh0oHh4Ax3BoxSGzJG+G480+lV3+ftbZxYzYnLlNTI2OjkE8JWKUT9Vrokhb09/SP3AOm9q9akiO45xJZdzqevMHSgHk5v2Luj4gxz4exSTstsU5cb5reDYg2x8DmTiX/6JyKo1Jq0I7WHxLUcskJeGZzTEKOQt0Awte86KS4jKYSDJElCS0t1d5KkvblLt/4dPA5lYI+3Xw4r2sOSIwy/51seNy6uUl8G3IAkR5lnnKs9WK25jVy+F+pBAhbvhoSPTcgocd3pgN50OLgXG5AGRdnBOoMtvzMlKy++fRA3q3pm2Mm9/FK9qmt9huXuO5opu/dp0VR/piemrka3K8M9calnksJElR5YM+PNPXgR6RObm7avbeg0jMqtUOblhNsBorKKK6xbb2lMTzFZmbDddKL9lO9za2yMpARY4utLlRMsgzvh4dNzvI6AZYrwNPdtw1qaK95Eqmd7QXTFvdIzygQTFBBL8shwjizOBoMAS4CeFfkzoi5OyK8r9gWA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(376014)(1800799024)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003)(5023799004)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PA5CcQ9+KqM/XQgDKrjLTAs+5pMLQZJR66O0uoAFHB4szOXnihkszRJxc8fH?=
 =?us-ascii?Q?3+J9mHt4nlk2hAc4t7qq6a/0FXFRFCNH6v3zc1Ud6AQ0n/SdPCYkKSjXhsMR?=
 =?us-ascii?Q?kkujwuEUfJaGZ6Bt6r2ZigDBvrbJ/umEuQDPBAmie10HUg1nPCJxkq5gS0Xl?=
 =?us-ascii?Q?FJUr4ZclxChZRAotsX5TfQ/4gqArbYbmK2KtZQCjQflfQyHIP634j+ChBv+V?=
 =?us-ascii?Q?To5X6J9noO6usQbNN+e0g27Cd4TFQdR3drBoVdf5HPLwWgRWfZ97C0tszIuB?=
 =?us-ascii?Q?EcZUk2A+2nb2uokFTeZlKtBVUQvdpU7U8rZ9z0OpRRPTcv2t2KbevtGyAM6h?=
 =?us-ascii?Q?WqywC8qI7G9duqab9Zfp+mCcMw43ZgEGjKz2yiQgKcWJD31GP865KPAYv1i0?=
 =?us-ascii?Q?KEN/WTyd3bgzGnIWs9uIPvuAtGagiFKy6Ep7PkleD70TQn2Zx+7jQV/ozUl1?=
 =?us-ascii?Q?kJZiwH2a9j3tSTPTOvWRcXOFK2VR/uPKzhqH0CDLfk2RWoC2h7DcAV5nzaso?=
 =?us-ascii?Q?BZvMSn2OSDIcPFc/n/15/fpTrJyvqcutcT5XOBv0LLxMH6kr/MrAyVsrO0/g?=
 =?us-ascii?Q?n93wkiyHnwIWsEZbMk1WISOjpEwTPfav5di3c+NK2sbXPB5buOPGdCXXPzXz?=
 =?us-ascii?Q?FL4X/X5W2GCzL7VJT+zL0cc+xy6E7wV9cGf4vi9li4lySzLx0DzfvT080Y90?=
 =?us-ascii?Q?oZYVVpdc4MC3GJ5npyDYtAUZJtGGT0bsLX8P0DvcCe3+l6VrcfuNC6fJ32fm?=
 =?us-ascii?Q?aMVDSh6QVEEckOpMAm7fZVxntegp6Z7XUTzyogOo0Z4WFWmC2Z+x0yFUOnB7?=
 =?us-ascii?Q?z5n1fJfV5EcNJqpew7HCQn/XnjVYgrSG7HioB8SK2f9OQB69Gcy2cb8c+ed6?=
 =?us-ascii?Q?9S2OxAHk3DhCkwerha5HPzSqhoOX01s554flEpaPLwzfRyy+A4qifFKw69cT?=
 =?us-ascii?Q?si0Tv5DmCeKEJ/PTPk5TKgxMRrzdum2g9O2FbBR0ev0fuGpfuNe0nXSv/T/w?=
 =?us-ascii?Q?Q3ZUQDjVdXNn3sEXJ/hGIGAPFh7X2KyKFI+wIwyH/7tr057x1APdjrioXXmv?=
 =?us-ascii?Q?x3BsqduUVKpWQSDqcwvHY/psv+NQLizR89nF/W/4Jav2cwonDVSW/lCH+DsC?=
 =?us-ascii?Q?EwutN0EytZ9sorond3iReQFuuMScHdq3B/qYHHNzpLsir9VKtdhn7ckMqm0+?=
 =?us-ascii?Q?Mv+Kq+VbYwpgZXkdvN31ONgnC3kztIe6vIzw73Ouumab4d090RnbW6W+Lbkf?=
 =?us-ascii?Q?DIBIp/JUzmyPmzWt491iddk33XrabQMlXEEae5Q+prCkRCPUcWaejXX4IR2t?=
 =?us-ascii?Q?Erf9IjllWKTx8508VkrRRj6zsK7TYiBBFX9cqZa0IJaHz4oou1IQR0QS2agh?=
 =?us-ascii?Q?uG/8gTPjWSNPoANrvWh9BUUQB4K5O1+jGVmOWMHkz0zfHsOLtfCL4AxbUVVa?=
 =?us-ascii?Q?j8u9h/SnEpOGBect4Y2w0eyil2xRsk6iDsBKNrMD27qYHFvpWH7p0Ui5G7wq?=
 =?us-ascii?Q?DschxmkILxUIf66WnzkJK93xjIuFPqVNbwuFCDA8tZ73jRlnQku0Np0h9HNM?=
 =?us-ascii?Q?lqTrLXoHpPIeGVjkUcF7MPfHbHErUxTp5JYdR1WtdXPWh05EuDVpoyGz4+Jf?=
 =?us-ascii?Q?CTc+vG+dhEgzJzs5wiV6AGmpWb4G5whrLBg5loxaAKV66T4pNrt1DODWiOj1?=
 =?us-ascii?Q?pN01ypDydlwBypYiSKj05CH1Bx09TREvYjHvZe1ROawVuBFzeBaQmZgh8IZT?=
 =?us-ascii?Q?otu8Y0Xr4w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f7b3e7-7486-43da-1421-08ded0d70a1e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 03:25:14.0843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JUijfmj4gjTdWVGRpXbV+AKnad/TSYRiF5EEs8yGGlA0+Tksx/kQR3i2cnBNyFX3wkifvJmMI8jdyUTkHTR/JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9144

Add reset context support to discover same-scope CXL functions before
reset. Use the Non-CXL Function Map, ARI/devfn rules, and CXL.cache/mem
capability bits to identify participating siblings, then hold references
until the reset context is destroyed.

If the Function Map cannot be read, warn and treat all candidate siblings
as CXL functions.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/reset.c      | 180 +++++++++++++++++++++++++++++++++-
 include/uapi/linux/pci_regs.h |   1 +
 2 files changed, 180 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
index 786d1060e40d..1ae714a3595c 100644
--- a/drivers/cxl/core/reset.c
+++ b/drivers/cxl/core/reset.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2026 NVIDIA Corporation. All rights reserved. */
+#include <linux/bitmap.h>
 #include <linux/delay.h>
 #include <linux/bug.h>
 #include <linux/bitfield.h>
@@ -338,6 +339,25 @@ static const u32 cxl_reset_timeout_ms[] = {
 #define CXL_CACHE_WBI_TIMEOUT_US 100000
 #define CXL_CACHE_WBI_POLL_US 100
 
+/* CXL r4.0 sec 8.1.4 defines 256 bits of Non-CXL Function Map. */
+#define CXL_RESET_MAX_FUNCTIONS 256
+#define CXL_RESET_FUNCTION_MAP_REGS (CXL_RESET_MAX_FUNCTIONS / 32)
+#define CXL_RESET_SIBLINGS_INIT 8
+
+struct cxl_reset_context {
+	struct pci_dev *target;
+	struct pci_dev **siblings;
+	int nr_siblings;
+	int sibling_capacity;
+};
+
+struct cxl_reset_walk_context {
+	struct cxl_reset_context *ctx;
+	DECLARE_BITMAP(non_cxl_func_map, CXL_RESET_MAX_FUNCTIONS);
+	bool ari;
+	int rc;
+};
+
 struct cxl_hdm_range {
 	struct list_head list;
 	struct pci_dev *pdev;
@@ -349,6 +369,157 @@ struct cxl_hdm_range_context {
 	struct list_head ranges;
 };
 
+static void cxl_reset_context_init(struct cxl_reset_context *ctx,
+				   struct pci_dev *pdev)
+{
+	*ctx = (struct cxl_reset_context) {
+		.target = pdev,
+	};
+}
+
+static void cxl_reset_context_destroy(struct cxl_reset_context *ctx)
+{
+	for (int i = 0; i < ctx->nr_siblings; i++)
+		pci_dev_put(ctx->siblings[i]);
+	kfree(ctx->siblings);
+}
+
+static void cxl_reset_read_non_cxl_func_map(struct pci_dev *pdev,
+					    unsigned long *map)
+{
+	u32 words[CXL_RESET_FUNCTION_MAP_REGS];
+	int dvsec, reg;
+
+	bitmap_zero(map, CXL_RESET_MAX_FUNCTIONS);
+
+	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_FUNCTION_MAP);
+	if (!dvsec)
+		return;
+
+	for (reg = 0; reg < CXL_RESET_FUNCTION_MAP_REGS; reg++) {
+		int rc;
+
+		rc = pci_read_config_dword(pdev,
+					   dvsec + PCI_DVSEC_CXL_FUNCTION_MAP_REG +
+					   reg * sizeof(u32), &words[reg]);
+		if (rc) {
+			pci_warn(pdev,
+				 "failed to read Non-CXL Function Map; treating all siblings as CXL\n");
+			bitmap_zero(map, CXL_RESET_MAX_FUNCTIONS);
+			return;
+		}
+	}
+
+	bitmap_from_arr32(map, words, CXL_RESET_MAX_FUNCTIONS);
+}
+
+static int cxl_reset_func_map_bit(struct pci_dev *sibling, bool ari)
+{
+	if (ari)
+		return sibling->devfn;
+
+	/*
+	 * Without ARI, the Function Map is organized as 32 device slots per
+	 * conventional 3-bit function number.
+	 */
+	return PCI_FUNC(sibling->devfn) * 32 + PCI_SLOT(sibling->devfn);
+}
+
+static int cxl_reset_has_cache_or_mem(struct pci_dev *pdev)
+{
+	int dvsec, rc;
+	u16 cap;
+
+	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_DEVICE);
+	if (!dvsec)
+		return 0;
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap);
+	if (rc) {
+		rc = pcibios_err_to_errno(rc);
+		pci_warn(pdev,
+			 "failed to read CXL capability; cannot determine reset scope: %d\n",
+			 rc);
+		return rc;
+	}
+
+	return !!(cap & (PCI_DVSEC_CXL_CACHE_CAPABLE |
+			 PCI_DVSEC_CXL_MEM_CAPABLE));
+}
+
+static int cxl_reset_add_sibling(struct cxl_reset_context *ctx,
+				 struct pci_dev *sibling)
+{
+	if (ctx->nr_siblings >= ctx->sibling_capacity) {
+		int capacity = ctx->sibling_capacity ?: CXL_RESET_SIBLINGS_INIT;
+		struct pci_dev **siblings;
+
+		if (capacity > INT_MAX / 2)
+			return -ENOMEM;
+		if (ctx->sibling_capacity)
+			capacity *= 2;
+
+		siblings = krealloc_array(ctx->siblings, capacity,
+					  sizeof(*siblings), GFP_KERNEL);
+		if (!siblings)
+			return -ENOMEM;
+
+		ctx->siblings = siblings;
+		ctx->sibling_capacity = capacity;
+	}
+
+	ctx->siblings[ctx->nr_siblings++] = pci_dev_get(sibling);
+	return 0;
+}
+
+static int cxl_reset_collect_sibling(struct pci_dev *sibling, void *data)
+{
+	struct cxl_reset_walk_context *wctx = data;
+	struct cxl_reset_context *ctx = wctx->ctx;
+	struct pci_dev *pdev = ctx->target;
+	int fn, rc;
+
+	if (sibling == pdev)
+		return 0;
+
+	if (sibling->bus != pdev->bus)
+		return 0;
+
+	if (!wctx->ari && PCI_SLOT(sibling->devfn) != PCI_SLOT(pdev->devfn))
+		return 0;
+
+	fn = cxl_reset_func_map_bit(sibling, wctx->ari);
+	if (test_bit(fn, wctx->non_cxl_func_map))
+		return 0;
+
+	rc = cxl_reset_has_cache_or_mem(sibling);
+	if (rc < 0) {
+		wctx->rc = rc;
+		return rc;
+	}
+	if (!rc)
+		return 0;
+
+	wctx->rc = cxl_reset_add_sibling(ctx, sibling);
+	return wctx->rc;
+}
+
+static int cxl_reset_collect_siblings(struct cxl_reset_context *ctx)
+{
+	struct pci_dev *pdev = ctx->target;
+	struct cxl_reset_walk_context wctx = {
+		.ctx = ctx,
+		.ari = pci_ari_enabled(pdev->bus),
+	};
+
+	cxl_reset_read_non_cxl_func_map(pdev, wctx.non_cxl_func_map);
+	pci_walk_bus(pdev->bus, cxl_reset_collect_sibling, &wctx);
+
+	return wctx.rc;
+}
+
 static void cxl_hdm_range_context_init(struct cxl_hdm_range_context *ctx)
 {
 	INIT_LIST_HEAD(&ctx->ranges);
@@ -755,6 +926,7 @@ static int cxl_reset_execute(struct pci_dev *pdev, int dvsec)
 int cxl_reset_function(struct pci_dev *pdev, bool probe)
 {
 	struct cxl_hdm_range_context range_ctx;
+	struct cxl_reset_context ctx;
 	int dvsec;
 	int rc;
 
@@ -765,14 +937,20 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
 	if (probe)
 		return 0;
 
+	cxl_reset_context_init(&ctx, pdev);
 	cxl_hdm_range_context_init(&range_ctx);
 
+	rc = cxl_reset_collect_siblings(&ctx);
+	if (rc)
+		goto out;
+
 	scoped_guard(rwsem_write, &cxl_rwsem.region) {
 		rc = cxl_hdm_ranges_prepare(&range_ctx, pdev);
 		if (!rc)
 			rc = cxl_reset_execute(pdev, dvsec);
 	}
-
+out:
 	cxl_hdm_range_context_destroy(&range_ctx);
+	cxl_reset_context_destroy(&ctx);
 	return rc;
 }
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 194ae56b4404..7fc1d34fcce7 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1380,6 +1380,7 @@
 
 /* CXL r4.0, 8.1.4: Non-CXL Function Map DVSEC */
 #define PCI_DVSEC_CXL_FUNCTION_MAP			2
+#define  PCI_DVSEC_CXL_FUNCTION_MAP_REG			0x0C
 
 /* CXL r4.0, 8.1.5: Extensions DVSEC for Ports */
 #define PCI_DVSEC_CXL_PORT				3
-- 
2.43.0

