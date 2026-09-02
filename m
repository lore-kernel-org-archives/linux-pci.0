Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013017.outbound.protection.outlook.com [40.107.201.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429053E7BAD;
	Wed,  2 Sep 2026 07:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334123; cv=fail; b=K/ex7ndaluo8R9c8lHhYanys8RRG1rrD3Xgjiof3qDnT6/hmXJOi1aZWh2b9SZfBHoVdISgiVICr3b4rps/hhzT4HMr2sUXNz7IImjgYOtmTTHIicaDeSYkYxnuGL4u6UHM76iPCO3fXy0qX8Z2iR7aqzZtBYJQSgCdPpFdX1KY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334123; c=relaxed/simple;
	bh=kQI1V/sW461V5IN8hES5i/ncuJafWTNgN76okgIJs6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hjrKOyjZWeGMwatvold2lFzzcAnlprHgHHnuu0vbyUEwdwRapcqhI8HeQ0WKYiGgCxZWOEpYqOeAQsdD7SWCMOyWI/Zh4QIf5qBERPbn0uTe5EHEWXzt63ZReJs/kxPQoF0GF/6At9O/kNyW+wREGSdL2WyjjLsCr0ReXIHeFs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cAYQLOD6; arc=fail smtp.client-ip=40.107.201.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cAYQLOD6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VNzhubp/49M0SzLfQPd9HLkl2QTLjL0/gVjqGHbOPrbka3ahv9AyQTmaUr7Ek7dPeCBYRtSSwh8+tAIrBvASpbLn7U5FpuHiqfxLeevc4hCR4QarWD+Ln3ivQ0NNTwM5CAj8HsQqpfQ52i7AKJd+tDCQoFI0G1at28tsU+xNr4O7xS3zF3sMPJoPnnUG5wtMcl7soheQ0dRZa/x1cDx0yzEdOZtK4mBfI16OVUyhl5zCT0Ytjt4djWTSKruXdu+dHs9YluH8picMnDFPzioMerPoNTwtUEGQrNiGs0ElrmkB+4l//2LHFB8ksi1HsSb6L9tXTWnT6ZccA27eLaOCxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2ZyhWkYxehhABWmsKABpHbRAFMYS7KhZrLGkKrUh7g=;
 b=saWQicE/RL9nStvrrATsxHuTJKoxvBEc35ZTwX6uOmUisEByFDWyWaUCi9uyx2oiLemrSDf9lTmfN2LCpYwCogMlbxTI5cupn3fD3cRFXSX3M/912AErh0kl4fzivO/JN2ynkmhndO3FYOZHy2CKzDSaJg5anLrav31engxkQxoV/U+W71L13DpSfOxWQdbTCTPK+ZG8eQdFIEGp50YeF8zn6SVmPcN3bZdspQwZBkFi1NsKRwjE42Fuz3J2rcZP9h7xY0aL52bu4sRYIm3bybtMgMX3dQPfuC280UTJlhi5XylRH+OBshQOMUlJBugyTqcllZvW+FicdCB0ohkNbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2ZyhWkYxehhABWmsKABpHbRAFMYS7KhZrLGkKrUh7g=;
 b=cAYQLOD6UZWBBYmasxcx7d9OaARvhOu1YOQ0KyWodCNMg/6lSdWXapZ5HcFRCajIQlpUOS93C+xQhFG0b1yrdcAGO75LlPY/sVYhnO4CQgbKoZq6dB21EmhTBp3B2STIdT4T80YemRNGn27JqgJeEM2PR4mhcdsAdtLmyVx7uPwlvQOQBfVQLdakQz06UQHirQEmCc5RHyEASZPizjI3fGxwzwx+szC1bvJ8NBz6eizp1px20ckyi2FpYwZjNTOkF/r6NRV/y+xCEOYMjrF2sLoQJCcptF0c6PBzWJ6gv+nSXxpX4w4kGSanh0iKFc31ldhswBE0tkbn7BmCK0shUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by PH9PR12MB498472.namprd12.prod.outlook.com (2603:10b6:510:42c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 07:28:32 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 07:28:32 +0000
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
Subject: [PATCH v11 09/12] cxl: Restore CXL HDM state after PCI reset
Date: Wed,  2 Sep 2026 07:28:01 +0000
Message-ID: <20260902072804.665639-10-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902072804.665639-1-smadhavan@nvidia.com>
References: <20260902072804.665639-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:303:16d::6) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|PH9PR12MB498472:EE_
X-MS-Office365-Filtering-Correlation-Id: 64de2047-8087-4920-fcdd-08df08c3ca74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|366016|376014|1800799024|921020|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tx2To1rXx0af3pXNo0V46p8ktKHove06Q8Shw5kdC++cMdjY28q3YvH9/mANp/QVwCmi9uF4d6sZN/06a4j1FaExEMfwS71p41y4+HZPYaQ6p4S3FuFCtHwmoY3klnoXJy2XT+X5/1FO0GihgPl2h9/71qgpEdPlg9iRRBIrkPBFEEtD/M075dF5L8vxhS9Ukb+w8pa9QojCHoRig/SEsn8ygTN7KgqnqO0mkQemGfW8Aan8unCQAl29IY0evOBzZV679HUZGm+e+vxha5J0zUZ8a+vIbmpxbqDOEbGg/zuTj2XzNdR0t5XqQnHdXPM5dLr5cXVn5EO6bG1gRPGWvCDxtajDBt+1qwmx/vCsYXSNBIMJOouWeYRH74nbP8woRZjVxrpFUkKsLKLMo2deLhylU7YI7cekgpyj0gs0tPI75S2Gm0ED2jFqWroR8JQLdfxozK1sv1/EVdB/WjfG/wcQpTu15114dX8aeYLUjPAm+TdkbORjo03CzuRItwDvr77IdaLK1idZA0/eRuxGU6AzrEgBT/UXX0l3hcHMF/LBeMX3aw+XbZJGy2Itcq+I3Br8+4Q2HGgZuMAW8mBsxEd95xD6ikBM4wzwc1n1Hvl0L/dsoKpUUYRiUlrZ4R8tNpDrSPhjYVcJ+f1jRz1rIqvbES963JPf1Zcl0PKCt0e9m4DiBn/uIkvRH/gk8WiXDrkVN4NFAFgl7UQeKFyd9Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(376014)(1800799024)(921020)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ipFJ/jjV8R0sTFBfFF7w0ro2WwoGv6Ac+HWbcFUNLxXG7lxsNSb8f0sCH1g6?=
 =?us-ascii?Q?hoqdqFh18eJ926Ch6hOqx/JkekoEiVvSeL8HrNhA1wUc83d1H+MxOMJ9S/UV?=
 =?us-ascii?Q?Gtu+mxEWl9zFBgoUh4JKUQDGZHQbpIf9hjX1tEAEm+OnqzFqNo3TD7WFHZUa?=
 =?us-ascii?Q?eLcTEFsej0uhdZDlkkK10FjFkqejS1Bw8K7LDRwYTzMOsJd75/BFJjjPLoLU?=
 =?us-ascii?Q?bpoam7KRDaBIutkgbk0pJGbR+M680JJL+lX7Bgh7WUlQJN6Sz2uF3dqzoTNU?=
 =?us-ascii?Q?k6wOtggldzrKgqq+cOzlQ7+yLRMmhKQgpCU5X+kbHJuO3EDfWFJoegOX3HfR?=
 =?us-ascii?Q?oXgrXVugEMGireZ0zUikgD/cPIbRC25sLCSL1Px7YsGDxVEqpO49jG91AfNr?=
 =?us-ascii?Q?as2e+ONht3YayhkT9Ywlfh6uMpVX5marbQbYu13aEDHB2E7xEsJ+63K0+QAE?=
 =?us-ascii?Q?4ugaSKsRpvGtMJ3p9v+exYjXhzWjaD3uAhWkgov7Rwfk1lGfF1WcD6OmEd1q?=
 =?us-ascii?Q?w/k2C5f0d612vq7R40QMtke5JhjHIC7mDD0njEKz1nUNrZ6/AhRqyQWaiTHe?=
 =?us-ascii?Q?KRNrOhi8v+jH63tzPzfbfF8Ucoaiz8wjyC4dFEIWgVzeriqXBE55NTbf5N6p?=
 =?us-ascii?Q?N948oYG5xeArXp/wbaRPRZS4mlxw+qXlStRjVgQ3a7IesJ9wXBwpk+m+se64?=
 =?us-ascii?Q?ZBT1A/BMMTCCR6PpBjcHobvEy1pG8dUIQhwB9O5RecojShqOaP51v8tiXpIb?=
 =?us-ascii?Q?MBhtnr2CWrPg//SWmh5/eqkRIRZy0z0NTtHhWeZ4WHAySyHhU5n0G89z8vf/?=
 =?us-ascii?Q?IoYXKOZ/55EMuvhh4h5OP9JA2g1mgzOFlWsF/4dolw2KKTfVFRJkfhS7cG/k?=
 =?us-ascii?Q?emSRMgHODn1VhJYq6Gr3bwIidB3W2eXdnxztA851V1TAcKSj2+EuWccoJD1R?=
 =?us-ascii?Q?DS6XNniCHTeiBsfnP7Avw6+Oq2SNN6KDoYGwla9BdWUfQNAmc4ChlM+2IETD?=
 =?us-ascii?Q?YS0Va+AHsikjPoL+iaHQMXCXSn57PTYOFpfzRnQ4RPeXI2UPGqjVtW2txY5E?=
 =?us-ascii?Q?NFVZxEF0zXzaWnPnc43AyyOfGrnmRKt6Ri7FzxgwBStCkPPOjoqcZUQA9KSJ?=
 =?us-ascii?Q?3XhNyL3fzLHB8wbzu0J7zBMBfdXs4tGHR1zV1ahZE5eZy4UYwebDCraKgmXI?=
 =?us-ascii?Q?oApxOWX0q4X43WEVNXEzRIJjDn9eNgFn4kPlQA9VEMKBOXLdpdQJAvqBy3ll?=
 =?us-ascii?Q?hgufCXosvzWxg8K5T3li4C7pC+osn4h0EUgDKWiFAc+tiCk3T+Y687W2vhjw?=
 =?us-ascii?Q?FkLgEP2N3lFZDBlMOAVmsh8m9l3ZA9Uycnp910+j9EFjXMIzAy+LkDcFiVHZ?=
 =?us-ascii?Q?Tc4XhBfPaFYvQhw9Pawq8TYI4Wr1W4pnP+m6aTrI5iXjZWuVq7y+o+iKg810?=
 =?us-ascii?Q?xOehJCnxIq+T2SPzgoP9UdireA+SKIFAkyW5Z+XJq7Y9Mju46o1HMuIB6Lyb?=
 =?us-ascii?Q?LcSyJDxCoJea9jC++z4M2ZOdrikly6md9Ih/MWFE7wpD8EpByQD+WrCYVv2N?=
 =?us-ascii?Q?++vDNAokDtMwgPFeYx33vpqGt3bYJ2EZdnfBEwEgsqCH5x32vQLGtdySE4MG?=
 =?us-ascii?Q?Z62D9prNgQ7gu8kwdL1WuVz2pwPw1qDQu3nf1jljaRr08eNsKheigzEiDj+H?=
 =?us-ascii?Q?7ixz3nZTrVx/KJ3K7ExKfqiyYy83DoU6GoPZiDNG7tyUAc9M0PboJrpUeF0C?=
 =?us-ascii?Q?TaQpZqAy9A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64de2047-8087-4920-fcdd-08df08c3ca74
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 07:28:31.9467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RnwO2n31p7kKNl9wey9BkGw402fgAdo7VOoAQskMXXLtDAmh/7VkgEGuuSLyX3bsmZTJq9IQi34i0JbgM1Un4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR12MB498472

After CXL reset, restore PCI config state enough to reach HDM MMIO,
restore cached global and per-decoder HDM state, and then run the normal
PCI restore callbacks.

Keep the target IOMMU reset block active until HDM restore completes so
Bus Master Enable cannot reopen DMA before decoder state is valid.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/resource.c | 362 ++++++++++++++++++++++++++++++++++--
 1 file changed, 347 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
index 79227ce70169..fe330b825c0b 100644
--- a/drivers/cxl/core/resource.c
+++ b/drivers/cxl/core/resource.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/memregion.h>
+#include <linux/overflow.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 
@@ -83,6 +84,26 @@ static int cxld_await_commit(void __iomem *hdm, int id)
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
 static int setup_hw_decoder(void __iomem *hdm,
 			    struct cxl_decoder_settings *settings)
 {
@@ -273,6 +294,31 @@ static void __iomem *cxl_pci_hdm_map(struct pci_dev *pdev,
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
@@ -285,6 +331,40 @@ static void cxl_pci_hdm_read_decoder_state(struct cxl_hdm_decoder_state *state,
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
@@ -501,6 +581,220 @@ void pci_cxl_hdm_init(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL_FOR_MODULES(pci_cxl_hdm_init, "cxl_core");
 
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
+		rc = cxl_commit_start(hdm, settings);
+	if (!rc)
+		rc = cxl_commit_wait(hdm, settings);
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
+		/* Flush posted HDM writes before PCI_COMMAND can restore BME. */
+		readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
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
@@ -528,6 +822,34 @@ struct cxl_hdm_range_context {
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
@@ -934,26 +1256,21 @@ static int cxl_reset_wait_done(struct pci_dev *pdev, int dvsec, u16 cap)
 	} while (true);
 }
 
-static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
+static int cxl_reset_execute(struct pci_dev *pdev, bool *target_prepared,
+			     bool *reset_initiated, int dvsec, u16 cap)
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
-	if (!rc)
+	rc = cxl_pci_target_reset_prepare(pdev, target_prepared);
+	if (!rc) {
 		rc = cxl_reset_initiate(pdev, dvsec);
+		if (!rc)
+			*reset_initiated = true;
+	}
 	if (!rc)
 		rc = cxl_reset_wait_done(pdev, dvsec, cap);
 
@@ -963,14 +1280,14 @@ static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
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
+	bool reset_initiated = false;
 	int dvsec;
 	int rc;
 	u16 cap;
@@ -993,9 +1310,24 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
 	scoped_guard(rwsem_write, &cxl_rwsem.region) {
 		rc = cxl_hdm_ranges_prepare(&range_ctx, pdev);
 		if (!rc)
-			rc = cxl_reset_execute(pdev, dvsec, cap);
+			rc = cxl_reset_execute(pdev, &target_prepared,
+					       &reset_initiated, dvsec, cap);
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
+		} else if (reset_initiated) {
+			cxl_reset_save_disabled_state(pdev);
+		}
 		cxl_hdm_range_context_destroy(&range_ctx);
 	}
 
+	cxl_pci_target_reset_done(pdev, &target_prepared);
 	return rc;
 }
-- 
2.43.0

