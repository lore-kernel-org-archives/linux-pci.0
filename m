Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012055.outbound.protection.outlook.com [52.101.53.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F2D4B8DFC;
	Tue,  4 Aug 2026 19:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785871852; cv=fail; b=JJOuFqn8fcBkeJxsC7PoTuASiMhe/FJrh33r/dZ39TlGUUm3sio2CqbaFLoaL3yVHtngifAeZgqHflecGAIK2KlgW70VT7r4k6z8ikJXKVDOs3h89FPSqxQ7u5gVT7tphGevdzX+cVxnL1MyQpTArcOPq5duIPkcpQs0bBHyWfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785871852; c=relaxed/simple;
	bh=w/Ryz2K6AE8GSieKMQ+EbgrF7yytaHlBnDG8L2odzUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cDWulSVszN3BfxumBG8Wl+pyIkAZmYvUxPkM0d0xsky0bVMY8ZPX4rfKJlAE/70h+zeJeC/Jnor05h1AyqNqR5KuytUuLX5jtaLy4v1VlvQ8cIcick3Bi+33M443DzQBLAHMnjO8h99bPlgaYiKY28QV0DNR6X0ZxW907CK5Gqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SS6d+yot; arc=fail smtp.client-ip=52.101.53.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SS6d+yot"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/01BewsOUyho2Q8wTn0XwB4C/tzTvp9INFT5266DSKALDW7hSqfRAiBVRiHxBhfb1eyseiqeODOwqyXUWVkRPxdRUzAYZAqBjTNbowaKFkO8UvMnIrBjT7SCIyJKig4oYV+dPk2GwozsW+Z/Xm8c8OjbG6fvBo5/2vR99Rue1BNTkVLHSk6GDyDUzb8nC/zOK2mSKyI/6YectF1LNvEOR9s18OiK+W9Jt9oZ2w+O+4xofqog3gLgGj4mWipsIQxh0X0HndELvaCbobw5EBnoZ1UqEIxQoICVFcm6viP/kchh6Cvw4Si6XQp14N+8KYKpI5RK60akplXBL5NYrDeTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0WJGmn+RlzjCryjO7Pt4vPbGH+b6Ged+7QC/8OwYcM=;
 b=weAIjTy/y/qNWA22Syc72Lrmb+Sgu/9nT/dVImFWRKMk2z7G8q3dm+0W3qQQx7L/GZWC+kHuIsR48XazJpDEWcA+KkhgoLPJReqxUbjoBRi4Y1onXE9AdCxUCnDEd5KvEZwpERjaI2bf0+h+JqMW2mwpjgNQKhVNIWwfkRUEWVZ7JNKJxxe1aCQbjBO+ftzEmlIHoKwqOfYFIshB8ednkBk2kQ4day3LHZdetyCOF6++Ysg8FMsoZ46RXsVmj/OIQ36p2OcrjGFcNXs+z3NBwygUjjvvioS8EWtSQhsYUWZ2j1OcZb+SymrN8EsejxpSGVQJbUHefbdhHmrShgWiAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0WJGmn+RlzjCryjO7Pt4vPbGH+b6Ged+7QC/8OwYcM=;
 b=SS6d+yotbLqyR6+KrSVvZ6jWXzSth4pQyMctziC1cSBmta28gR8gQYiTCfqeLSHJ4VX3F72L/TtONHpXxqfRddT53hPBuZHxNNalIbWhQS2l7KFK0U5S0OlQv26mOum9gQQ+6gN3p8RFtpF5a9+jVU1xc59Rt4WBN9V65NU5/k5ay5Wr1cMgRaTAwUfzP4jiO+69U96q84Rygvm6fZVWhXffSm3+EbqA62KxHylW5K59sHPYn5k8Xi9qLgcLJCNW7bDTYNxv1NLop39b3hLh58RnIbTNsp4G0t9s2lXY6TEtkR+/ApzyYAnfgTV9+mQ6LGBzUgZQhgLc5vya0/VYlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by PH7PR12MB7161.namprd12.prod.outlook.com (2603:10b6:510:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 19:30:42 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 19:30:39 +0000
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
Subject: [PATCH v10 09/12] cxl: Restore CXL HDM state after PCI reset
Date: Tue,  4 Aug 2026 19:29:55 +0000
Message-ID: <20260804192958.1823952-10-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804192958.1823952-1-smadhavan@nvidia.com>
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:a03:505::27) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|PH7PR12MB7161:EE_
X-MS-Office365-Filtering-Correlation-Id: a28f673b-db1a-45a8-41a5-08def25eddbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|18002099003|22082099003|921020|6133799003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	jMvR8I/zwCno/qYa14/PFiGwIMijTwu1G89EcHeMuFuApsjf75dB8CDjEHXcincwqjo+S+qfewNztJNlp4xkw0GZk7CerLE6rnwAWUvB611GFv7YhLwPi8w+56UBfpjNveDJDxqvZofBRby+2yMjmW17m/pclkBTxFSAJ6AyXWQv4DfcMSbAeFL+0ZmDQYX47wC8ELzfxA1tnyV3m1V9d8tTBtawOwdTMLaC0VG65h3lzkAy6WtrS+Qeuzy8/Rp2xi7KcraMszb60uXn0sD8QS2MDyDXK8uis6YiXCtY6XSafsKtaaPGf+pTycsqSCX+qJ1fdspz8PH4j6I0bHO3zw+gzFaYzZdcMz6p8z2G38hr6LWS19ymdyScs+oCK7gIgh1gF3m6wYu/ktdz05wjQHKIaMGewRwLTcGMTsieYJiBu2iz12orEu/GKbN+iwf5WzOYPO+ANcLaESdBeFfrbIniLe3bdvu3Ifa1DXLFDkSzV2JTrk9qn8u893y2hCmqOSLL9V2+zhiDsmTm8EwYCNJsWQ5DaPnp9cCE7cIHtugNEHAwyf4VRxFX43ASHMuIrqkNpL6Vv/p8aOU6TUC7nxp4KAgb2HBBzOeu2GktUjJrW8z6BbECHk/IjY08cF2rnvOJpxCa6PUnSk9HgFw0DAohXhU6Q6MeoAp/0bdwEVqsErkvqOUD3m5W9P156fsZ0vWYTYNLuejzjHnyWhj9DA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(18002099003)(22082099003)(921020)(6133799003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uO7lv7Pb4bLHsQWykYcKRq3Ca1jc+Km9jN1I0Pz9396qZi2rs2+41dW/0LUO?=
 =?us-ascii?Q?7mifg6FCQ5+qE+1BP2HXAhj6P/dVydz0qCSo6nCp7NtFBtMb6XVgzKFMc7E1?=
 =?us-ascii?Q?CR7EAJNPmQsPEPcHXxUI9xcWay5cYPgaZXRnHfHy0cwkZ5zpEHygPOQcSA/I?=
 =?us-ascii?Q?QACs7IaEsaLgxrqcgm/HeNcPzpBU+S+/1t3hPCZpMe2U99RqG2Bw8wlGpQo8?=
 =?us-ascii?Q?X/jOrAs2N+HAvuDYLsWpM7t97UlwGLIHSlNavuBsw9y21Jy5FicFr630/hV/?=
 =?us-ascii?Q?GvOL7vxTftVgsHI3EgFKss8J1e2pgmZroNnkASIX2bZX2RJ9/eFBSwGfFCu9?=
 =?us-ascii?Q?4hVW8fjbyqRDmXuvK6Yx51RTZz6YlROsUljw2L9caJzJbZgNrK7yJMmFXkD8?=
 =?us-ascii?Q?7G6hxnRb4xGOEOUOQhzu0YxEiszefdisj524duaGcnxkmFaeabnX0uqsD6ON?=
 =?us-ascii?Q?cNsJJm0wLOcSjXDvS6fXZLuJQbG2Lxfqu2MdIY0ygIwHtBy8eMhpJENHZDeW?=
 =?us-ascii?Q?3zf3SSgkzshDP6IzkNZV37JabHViERIu+wj/pPC2WvKIi3IFPnT3xAY/HJFO?=
 =?us-ascii?Q?DXaFO3KciqlOtHlz99Cbmii475Sc+wqDjAjGFNnIKRPRlxhoUTffgUzIphP/?=
 =?us-ascii?Q?hOFR5CFtgHGZwUe2tQldvu7uVNBjNGQhhAFFB/zjqAb6tX6bdVE10y1s5/Do?=
 =?us-ascii?Q?A4nd73HqV57Xyl6unbqmTMhHJeIk1dAZyjuSpx2k0wIGDHGnW3vkuX3SwAwM?=
 =?us-ascii?Q?LtBAOUNQkJINBB/vLz1wB8CRN0GZJJ5I7Un4+PTFemF56xegcuK9dzQYOHpe?=
 =?us-ascii?Q?DWImTvCyVOzum7C3ItZGA4rJFSRfa7m/pJ3Miga6F9v67GBrMlI5rdDDEE8b?=
 =?us-ascii?Q?Y+b++8LUIFyCs1ENxZbrlf1L2mZSJDYzKzoekCdyqMWNO6As60Kgbwlqt5Yl?=
 =?us-ascii?Q?Em5i8f6RKwjwJ21T3qq4IY3YU8NKA0dQKb5zkHS6TFMhBxjFQplW+QeSmgoX?=
 =?us-ascii?Q?P5qkecJNxiLhgMbUQJv1MWc+QECT7J9h7oAdjRjR1CFc3Qh4RYiJEoTTe1MN?=
 =?us-ascii?Q?WiCj0avfCEbxn3UY6eHjcUDKZa9/9oHNpB7pI3p1suq278lVx+/GM6xVdvBZ?=
 =?us-ascii?Q?l/v3ot3KbjLKR3MKtnyFTrwcndF+0LZPTKZkofjunA3iEW05FG4nSYiohr5s?=
 =?us-ascii?Q?xCkxm5CPfV/mxQ6AWuqqewLSIIrxrRMfag5PNEUuQTw7W+KWZ+wSZilzUZvE?=
 =?us-ascii?Q?nvPjYBGJiCJ04q+PCt3J9UtuliTMtqB97J33+E6iGzSy5fGZNvL683O9SEdb?=
 =?us-ascii?Q?emoJkL5AeIdIbMzONRtZPe1fisPG5cclp8diwMr11q2yKnNdkpBbzMQiuwDH?=
 =?us-ascii?Q?cOenP0hdE9MgKN0edg77CmrizCxlSbAsk0QbmCDBb/Fs+cjpmklfU1vjvlgB?=
 =?us-ascii?Q?J0uJwk5PHhgmy4+iiTgq7/iHcunIxTCqm2l8jD+681JEYWRj9LBa2AnfaDnb?=
 =?us-ascii?Q?ueo9nQWG5BJq+Z+J0fErBlX/5P9ZQ4HcWL8iFx/7qRWmq0kL/GrfLuL5gkUy?=
 =?us-ascii?Q?MKWKxpeAALgxIRI9YiognWe/LfFFCgWRCJ7FI7WU1MREkl9UZN/kasnMD4uV?=
 =?us-ascii?Q?gmzHA2uhI1Lg4o+FiiG8YRqF1qmoX2EiAg321sUzGxGdQcGivsDcRaO8av/F?=
 =?us-ascii?Q?jJjrh/dI929u6v/xLxrFya3YA4Qw13qtN57kfdbhEEpJ2YFOvqmMzV26/zuN?=
 =?us-ascii?Q?Vhhg5KrQ2g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a28f673b-db1a-45a8-41a5-08def25eddbe
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 19:30:39.6374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JzpxU0Fxa25kXjTJQydDJfwElxk/YYIXDZbYOc9FzwU4OVlIBvR64hKrKm1UbC3cUgH7klb6m2fuTcpmA4eQvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7161

After CXL reset, restore PCI config state enough to reach HDM MMIO,
restore cached global and per-decoder HDM state, and then run the normal
PCI restore callbacks.

Keep the target IOMMU reset block active until HDM restore completes so
Bus Master Enable cannot reopen DMA before decoder state is valid.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/resource.c | 351 ++++++++++++++++++++++++++++++++++--
 1 file changed, 337 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
index 464ca9bdae05..ba0a26276477 100644
--- a/drivers/cxl/core/resource.c
+++ b/drivers/cxl/core/resource.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/memregion.h>
+#include <linux/overflow.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 
@@ -82,6 +83,26 @@ static int cxld_await_commit(void __iomem *hdm, int id)
 	return -ETIMEDOUT;
 }
 
+static int cxld_await_uncommit(void __iomem *hdm, int id)
+{
+	u32 ctrl;
+	int i;
+
+	for (i = 0; i < COMMIT_TIMEOUT_MS; i++) {
+		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMIT_ERROR, ctrl)) {
+			ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
+			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+			return -EIO;
+		}
+		if (!FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
+			return 0;
+		fsleep(1000);
+	}
+
+	return -ETIMEDOUT;
+}
+
 static int setup_hw_decoder(struct cxl_decoder_settings *settings,
 			    void __iomem *hdm)
 {
@@ -286,6 +307,31 @@ static void __iomem *cxl_pci_hdm_map(struct pci_dev *pdev,
 	return hdm;
 }
 
+static void __iomem *cxl_pci_hdm_ioremap_current(struct pci_dev *pdev,
+						 int bar,
+						 resource_size_t offset,
+						 resource_size_t size)
+{
+	resource_size_t hdm_start, bar_len;
+	void __iomem *hdm;
+
+	if (bar < 0 || bar >= PCI_STD_NUM_BARS || !size)
+		return ERR_PTR(-EINVAL);
+
+	bar_len = pci_resource_len(pdev, bar);
+	if (!bar_len || offset > bar_len || size > bar_len - offset)
+		return ERR_PTR(-ENODEV);
+
+	hdm_start = pci_resource_start(pdev, bar) + offset;
+	hdm = ioremap(hdm_start, size);
+	if (!hdm) {
+		pci_err(pdev, "failed to remap CXL HDM decoder registers\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return hdm;
+}
+
 static void cxl_pci_hdm_read_decoder_state(struct cxl_hdm_decoder_state *state,
 					   void __iomem *hdm, int id)
 {
@@ -298,6 +344,40 @@ static void cxl_pci_hdm_read_decoder_state(struct cxl_hdm_decoder_state *state,
 	state->target_high = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(id));
 }
 
+static int cxl_hdm_enable_mem(struct pci_dev *pdev, u16 *command,
+			      bool *restore_command)
+{
+	int rc;
+
+	*restore_command = false;
+
+	rc = pci_read_config_word(pdev, PCI_COMMAND, command);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+
+	if (*command & PCI_COMMAND_MEMORY)
+		return 0;
+
+	rc = pci_write_config_word(pdev, PCI_COMMAND,
+				   *command | PCI_COMMAND_MEMORY);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+
+	*restore_command = true;
+	return 0;
+}
+
+static int cxl_hdm_restore_command(struct pci_dev *pdev, u16 command)
+{
+	int rc;
+
+	rc = pci_write_config_word(pdev, PCI_COMMAND, command);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+
+	return 0;
+}
+
 static int cxl_pci_hdm_read_decoder(struct pci_dev *pdev,
 				    struct cxl_hdm_decoder_state *state,
 				    struct cxl_decoder_settings *settings,
@@ -488,6 +568,218 @@ void pci_cxl_hdm_init(struct pci_dev *pdev)
 		pci_dbg(pdev, "CXL HDM cache init failed: %d\n", rc);
 }
 
+static int cxl_hdm_decoder_uncommit(struct pci_dev *pdev, void __iomem *hdm,
+				    int id)
+{
+	u32 ctrl;
+	int rc;
+
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+	if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK) {
+		if (ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED) {
+			pci_dbg(pdev,
+				"CXL HDM decoder %d retained locked committed state\n",
+				id);
+			return -EBUSY;
+		}
+
+		pci_err(pdev, "CXL HDM decoder %d is locked and uncommitted\n",
+			id);
+		return -EIO;
+	}
+
+	if (!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED))
+		return 0;
+
+	ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
+	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+
+	rc = cxld_await_uncommit(hdm, id);
+	if (rc)
+		pci_err(pdev, "CXL HDM decoder %d uncommit failed: %d\n",
+			id, rc);
+
+	return rc;
+}
+
+static void cxl_restore_hdm_decoder_state(struct cxl_hdm_decoder_state *state,
+					  void __iomem *hdm, int id)
+{
+	u32 ctrl = state->ctrl;
+
+	ctrl &= ~(CXL_HDM_DECODER0_CTRL_COMMIT |
+		  CXL_HDM_DECODER0_CTRL_COMMITTED |
+		  CXL_HDM_DECODER0_CTRL_COMMIT_ERROR |
+		  CXL_HDM_DECODER0_CTRL_LOCK);
+
+	writel(state->base_high, hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
+	writel(state->base_low, hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
+	writel(state->size_high, hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
+	writel(state->size_low, hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
+	writel(state->target_high, hdm + CXL_HDM_DECODER0_TL_HIGH(id));
+	writel(state->target_low, hdm + CXL_HDM_DECODER0_TL_LOW(id));
+	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+}
+
+static int cxl_restore_hdm_decoder(struct pci_dev *pdev,
+				   struct cxl_hdm_decoder_state *state,
+				   struct cxl_decoder_settings *settings,
+				   void __iomem *hdm)
+{
+	int rc;
+
+	rc = cxl_hdm_decoder_uncommit(pdev, hdm, settings->id);
+	if (rc == -EBUSY)
+		return 0;
+	if (rc)
+		return rc;
+
+	cxl_restore_hdm_decoder_state(state, hdm, settings->id);
+
+	if (!(settings->flags & CXL_DECODER_F_ENABLE))
+		return 0;
+
+	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
+		rc = cxl_commit_start(settings, hdm);
+	if (!rc)
+		rc = cxl_commit_wait(settings, hdm);
+	if (rc)
+		pci_err(pdev, "CXL HDM decoder %d restore failed: %d\n",
+			settings->id, rc);
+
+	return rc;
+}
+
+static struct cxl_hdm_info *cxl_snapshot_hdm(struct pci_dev *pdev)
+{
+	struct cxl_hdm_info *snap;
+	struct cxl_hdm_info *info;
+	size_t state_sz;
+
+	guard(rwsem_read)(&cxl_rwsem.dpa);
+
+	info = pdev->hdm;
+	if (!info)
+		return NULL;
+	if (info->decoder_count < 0 ||
+	    info->decoder_count > CXL_HDM_DECODER_MAX_COUNT ||
+	    (info->decoder_count && !info->decoder_state))
+		return ERR_PTR(-EINVAL);
+
+	state_sz = array_size(info->decoder_count, sizeof(*info->decoder_state));
+	snap = kzalloc(size_add(sizeof(*snap), state_sz), GFP_KERNEL);
+	if (!snap)
+		return ERR_PTR(-ENOMEM);
+
+	*snap = *info;
+	snap->decoder_state = (void *)(snap + 1);
+	memcpy(snap->decoder_state, info->decoder_state, state_sz);
+
+	return snap;
+}
+
+static void cxl_restore_pci_state_for_hdm_restore(struct pci_dev *pdev,
+						  u16 *command)
+{
+	u32 saved_config = pdev->saved_config_space[PCI_COMMAND / 4];
+
+	pdev->saved_config_space[PCI_COMMAND / 4] &= ~PCI_COMMAND_MASTER;
+	pdev->saved_config_space[PCI_COMMAND / 4] |= PCI_COMMAND_INTX_DISABLE;
+	pci_restore_state(pdev);
+	pdev->saved_config_space[PCI_COMMAND / 4] = saved_config;
+	*command = saved_config & 0xffff;
+}
+
+static int cxl_restore_hdm(struct pci_dev *pdev)
+{
+	struct cxl_hdm_info *snap = cxl_snapshot_hdm(pdev);
+	bool restore_command = false;
+	void __iomem *hdm;
+	int first_rc = 0;
+	u16 command;
+	int rc;
+
+	if (!snap)
+		return 0;
+	if (IS_ERR(snap))
+		return PTR_ERR(snap);
+
+	rc = cxl_hdm_enable_mem(pdev, &command, &restore_command);
+	if (rc) {
+		kfree(snap);
+		return rc;
+	}
+
+	hdm = cxl_pci_hdm_ioremap_current(pdev, snap->hdm_bar,
+					  snap->hdm_offset, snap->hdm_size);
+	if (IS_ERR(hdm)) {
+		first_rc = PTR_ERR(hdm);
+	} else {
+		/*
+		 * Restore global HDM control before per-decoder commit. PCI
+		 * config memory decoding is enabled for MMIO access, but bus
+		 * mastering remains disabled until HDM restore completes.
+		 */
+		writel(snap->global_ctrl, hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+
+		for (int i = 0; i < snap->decoder_count; i++) {
+			rc = cxl_restore_hdm_decoder(pdev,
+						     &snap->decoder_state[i],
+						     &snap->settings[i], hdm);
+			if (rc && !first_rc)
+				first_rc = rc;
+		}
+
+		iounmap(hdm);
+	}
+
+	if (restore_command) {
+		rc = cxl_hdm_restore_command(pdev, command);
+		if (rc && !first_rc)
+			first_rc = rc;
+	}
+
+	kfree(snap);
+	return first_rc;
+}
+
+static void cxl_reset_save_disabled_state(struct pci_dev *pdev)
+{
+	int rc;
+
+	rc = pci_write_config_word(pdev, PCI_COMMAND, PCI_COMMAND_INTX_DISABLE);
+	if (rc) {
+		pci_warn(pdev, "failed to keep device disabled after CXL reset restore failure: %d\n",
+			 pcibios_err_to_errno(rc));
+		return;
+	}
+
+	rc = pci_save_state(pdev);
+	if (rc)
+		pci_warn(pdev, "failed to save disabled state after CXL reset restore failure: %d\n",
+			 rc);
+}
+
+static int cxl_reset_save_restored_state(struct pci_dev *pdev, u16 command)
+{
+	int rc;
+
+	rc = cxl_hdm_restore_command(pdev, command);
+	if (rc) {
+		cxl_reset_save_disabled_state(pdev);
+		return rc;
+	}
+
+	rc = pci_save_state(pdev);
+	if (rc) {
+		pci_warn(pdev, "failed to save restored state after CXL reset: %d\n",
+			 rc);
+		cxl_reset_save_disabled_state(pdev);
+	}
+
+	return rc;
+}
+
 /*
  * CXL r4.0 sec 9.7.2 defines the reset completion timeout encodings.
  * Sec 9.7.3 leaves config-space access behavior undefined for 100 ms after
@@ -514,6 +806,34 @@ struct cxl_hdm_range_context {
 	struct list_head ranges;
 };
 
+static void cxl_pci_target_reset_done(struct pci_dev *pdev,
+				      bool *target_prepared)
+{
+	if (!*target_prepared)
+		return;
+
+	pci_dev_reset_iommu_done(pdev);
+	*target_prepared = false;
+}
+
+static int cxl_pci_target_reset_prepare(struct pci_dev *pdev,
+					bool *target_prepared)
+{
+	int rc;
+
+	if (!pci_wait_for_pending_transaction(pdev))
+		pci_err(pdev, "timed out waiting for pending transactions\n");
+
+	rc = pci_dev_reset_iommu_prepare(pdev);
+	if (rc) {
+		pci_err(pdev, "failed to stop IOMMU for CXL reset: %d\n", rc);
+		return rc;
+	}
+
+	*target_prepared = true;
+	return 0;
+}
+
 static void cxl_hdm_range_context_init(struct cxl_hdm_range_context *ctx)
 {
 	INIT_LIST_HEAD(&ctx->ranges);
@@ -934,24 +1254,16 @@ static int cxl_reset_wait_done(struct pci_dev *pdev, int dvsec, u16 cap)
 	} while (true);
 }
 
-static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
+static int cxl_reset_execute(struct pci_dev *pdev, bool *target_prepared,
+			     int dvsec, u16 cap)
 {
-	bool target_prepared = false;
 	int rc, rc2;
 
 	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
 	if (rc)
 		return rc;
 
-	if (!pci_wait_for_pending_transaction(pdev))
-		pci_err(pdev, "timed out waiting for pending transactions\n");
-
-	rc = pci_dev_reset_iommu_prepare(pdev);
-	if (rc)
-		pci_err(pdev, "failed to stop IOMMU for CXL reset: %d\n", rc);
-	else
-		target_prepared = true;
-
+	rc = cxl_pci_target_reset_prepare(pdev, target_prepared);
 	if (!rc)
 		rc = cxl_reset_initiate(pdev, dvsec);
 	if (!rc)
@@ -963,14 +1275,13 @@ static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
 	else if (rc2)
 		rc = rc2;
 
-	if (target_prepared)
-		pci_dev_reset_iommu_done(pdev);
 	return rc;
 }
 
 int cxl_reset_function(struct pci_dev *pdev, bool probe)
 {
 	struct cxl_hdm_range_context range_ctx;
+	bool target_prepared = false;
 	int dvsec;
 	int rc;
 	u16 cap;
@@ -993,9 +1304,21 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
 	scoped_guard(rwsem_write, &cxl_rwsem.region) {
 		rc = cxl_hdm_ranges_prepare(&range_ctx, pdev);
 		if (!rc)
-			rc = cxl_reset_execute(pdev, dvsec, cap);
+			rc = cxl_reset_execute(pdev, &target_prepared, dvsec, cap);
+		if (!rc) {
+			u16 command;
+
+			cxl_restore_pci_state_for_hdm_restore(pdev, &command);
+			rc = cxl_restore_hdm(pdev);
+			if (rc)
+				cxl_reset_save_disabled_state(pdev);
+			else
+				rc = cxl_reset_save_restored_state(pdev,
+								  command);
+		}
 		cxl_hdm_range_context_destroy(&range_ctx);
 	}
 
+	cxl_pci_target_reset_done(pdev, &target_prepared);
 	return rc;
 }
-- 
2.43.0

