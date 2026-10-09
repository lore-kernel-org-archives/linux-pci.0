Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021123.outbound.protection.outlook.com [40.107.74.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3673E8340;
	Fri,  9 Oct 2026 05:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791522019; cv=fail; b=BBDjq7UYPIgFuL2suj1gInBE6TmXDP8mnx8n0757mwV9neHEYs3X6XH2kQohtcdYERtayYAQsxMtdY0vu0lZeiovo7FT/v0GYIcGKWvF8UXH5w/Jka6dD5c8P1r6+KOK0kZLZo4OhRbci0fzrJrI9oT2VZwSd70arAO9xwGa9Og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791522019; c=relaxed/simple;
	bh=5JAEgK2kpozDOvTJMYw+jWb7Llqkk5fjCUzWRYjn2Xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KjWaNLNXMDegbWSsBJ84IX39Rn2jHGSyrmL51cVijGMlQi2cOOCfFEejWgmgAplXV5cAPIVXJPwEp3OHnIvdwo0msxfeG2sKNHlS2WnXCZANZoKjLbSr60xalvCzVJY7F5FXCiWjQrV9k1ib7oFbrz3ptgoXmfBzI6fM+uY6I5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=vmWBQkNd; arc=fail smtp.client-ip=40.107.74.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="vmWBQkNd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YoJmRl1ESwi1Qh4WAgfSQwzoVGEJBmCRLDF6bEMLPRuRgwNw1Ok727q6WkV4oSL9IbUyM2OtMH3JgJM5W53M6XzC4sjx8XclOy18Ez43irvzLHeAb4uglxitDmyNcOLgulunvb8Jvsowow2c+vPapNtWC0f7T+Yv5teN2gkBUKFvWvoVVXhrWmPgkdHXNjctjVc3Cy8GWkX5UjYZCZELWIbV4G3MNcf0v8Tk88zb3fn0op/aZtSYmsSVdv1QclKS68J9k1nk9Mx9KWPgfI1hgOeR1o2bwGbWg9OVth9mXEVKAG0w4YPBUjZflE3BGkg+wF7TmP05dtH1T7YL47lflg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNtq0nYURnCnD+R0SEXEEczm98SF97jFWc7JSPZGFI8=;
 b=WrsJyfPKxgzKj0O5/DIOgiBJXLUDrMjDmNgbHIUCER8nDHPkhprG+j7ssdWmqN4d6LeW67CE7bPWuBiH5unMau91Ymy4fZMjSvNPdyTfCcDIDBqgZm+mAh5qcDWdA0ACRlkIocuGL9ZhqzwhV4KLcYFTZnAS+INzhpEicnbfKdEW0ikG237jLyXn3rkaEqGUQdVKDWYaLe4FEiOtyktrryVDMNz0Hv5e/3hGLRVl1P92JVM/GEq4WUXsBsy4bj6+5+CaKoDaJoRDp06wS3fbjrAWpiodGYm0bJK/b/ocqlZzyF7zjwRfcs80a0jfhMGSpPx8u5tdYP6tiRdbbB7unQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNtq0nYURnCnD+R0SEXEEczm98SF97jFWc7JSPZGFI8=;
 b=vmWBQkNdql9Gw/gX7sv8Vd2NIWDwQTvuffRea+xpD4Akx9Y0+jKZI8MPdz9bna/1D1x+GokEFJz6prXj+TGMbllP206ugp1RO/BFp+kepevKkEwgOMihywzo/53Q4li4FKPx0waJ32fxOe1n0Y8YfcZYe0sO5rmqboRDny2hFwY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSOP286MB4369.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:309::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 05:00:10 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 05:00:10 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v5 6/7] NTB: ntb_hw_epf: Discover vNTB-embedded DMA
Date: Fri,  9 Oct 2026 13:59:48 +0900
Message-ID: <20261009045949.1109871-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261009045949.1109871-1-den@valinux.co.jp>
References: <20261009045949.1109871-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6PR01CA0011.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::18) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSOP286MB4369:EE_
X-MS-Office365-Filtering-Correlation-Id: b2123212-6aa9-4a03-184e-08df25c231e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|23010399003|7416014|376014|1800799024|56012099006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	mAzC9npMNjYUKqYaC00yXlkqSK/2VvpVoaOOoeSDUN4HGBnaZSXoV12xfWchlCLTYYC8jKrNeGlbDxhxL3bSnBcUFDcZsBkxuug89NBjfmnopNoUcjICTzBBTAIdBOpdgIQc9XlFdbif/qgFJrvu9GXoWU0iDTAfOeqYIcI7x/ovCqYF+UBmXulhjzZwUNpnoSxjmpcqKqZDDjKb/jcsLU6N6NJsfotAEJDJPzjbAaH9cI18TqpFVCr+T80VtuQOucD5fYCS3wjQXCeeFSXcMr0LYLlQ56pVQMfzwPgEt6POqKxhyeomqkMljidiSOfVWe9LANsKju2LBW/BuCReJ22zg5TKmiDGs0kBSoHcPHEp8HG9mPGTbUNyKmGl2OF4W8tg/6HOZSfUg136XjvbWvtFLbNT/WFr3XyV6v3AtcIpIKhb31mFmCj5WW0bfelGe/yf17vyqYwUvvR9Rl74ki9lqeLFFXn22Ef4jYM72yrVQ6TAD32Js8VWr/IT2M2+JCBV0TMGWo8d6BCy3bMmBS5el89D93ITeyjZFEf5b/go7sE0xzqSuGMXfKHMWApDPWtWEV0XbFLAdDPCodWm/Kh3K22WJIYW0pfiV21aTqNZPbQ5ybi0Uy8wBsrdSzT9n4GL3V8O+dIl1eGLFuPB0DarXBdkb1ekLRK1jw5dEno=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(23010399003)(7416014)(376014)(1800799024)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xfd+I1JCVbRRaygj41UIDSfvzeqpXGptif1AnF5IiADDYYiBE2jvEZWBhD7A?=
 =?us-ascii?Q?6382aWLmrpQwapY0cd2fgHWWoBtOfdgnWa/yFX2eYKYAKKv6L2UIxpplktWt?=
 =?us-ascii?Q?thdN+94zdgXgXI+PDvVVcD8dNx0+a17TbCoFO6XoKIR2JKlUs/meNJHrbEsG?=
 =?us-ascii?Q?oG1PE3Tx6pWkgu0SHZiUpf64K625Mn1rXv0fp8fTXuideqBicOh/adbU0KyC?=
 =?us-ascii?Q?sUJB7s3+UEYqZR2x3hTlUVaGatKH4I97LiuuVtHVbsNshGyHMaW6IaIEtQiD?=
 =?us-ascii?Q?ew4ygktl6MngIwkXQt7NFQdRoFoUpE6tNW64s15I55MXOEZ5UN0MKjqblr+1?=
 =?us-ascii?Q?p2KIlHodtq8ixFV4Z6JiSNJsI0fsF9NydGG6eYeCrH5gRqA4fcXBNisVk15D?=
 =?us-ascii?Q?TDQwBeOALjpSxrU5qhyxFPDYBdaecfQ9PTJ5Aiv4tuBN6+XRLOfKedPa4xu/?=
 =?us-ascii?Q?02pq7aUAY/E+J7POTrfCMzUY9+V4NBHucwq+6ZXf4gDVtJ0gKsFq8ibBVOQP?=
 =?us-ascii?Q?iIZDQGGBCoTFbagVY3+YQ7sPngSf41M/YHXtXTbiqg+XDoVRCmG9YZQSSl6Z?=
 =?us-ascii?Q?PPZQbPDi2yOdCOay91300STl6BtXg7C3TXng8LGG+KmVipaylXz6Lq3JXpuF?=
 =?us-ascii?Q?VB0WZOlQGB/jmD0FH90cRbvV1+6zaQGzDIeqbQBLw03wRk4UrOoZQRUNcK9h?=
 =?us-ascii?Q?x5FIe5m1LTUopPIrJ8/50X7OSzcaKsIiTH/oqXAoIRfxN00/UydmkKFjBvjX?=
 =?us-ascii?Q?yW1yf/M60UoghuLCeX2EGUbDSUWIFJxV+6dFh2V57QvFxKxKNzY3COYkepM3?=
 =?us-ascii?Q?BMLsrJt9lwBQUK9U6tspK+qEC/aDsHaPTJUDRLI20VQTl80SsZok8zu1BGfN?=
 =?us-ascii?Q?3PaFmrPtVAqrwv8e73uSN5eJhOE6bMFqF4lry6LFoePGlv0yfuqFhRmYHlk7?=
 =?us-ascii?Q?iqJVFYxWMwAw46aMldsmHdO3tS9sEgS5POvzvF/8BXW+rCXluxaimx+iBxtz?=
 =?us-ascii?Q?XKhlaXeTwoE+PAYA+aNJ4ey0RfDsKGz6+J+4CxUciOqwZtXMnxaYOKn20VC3?=
 =?us-ascii?Q?Opd5VYxYnYINaoVdApUpivYju7DokuVroV9tjh9nfnorTbz7BtaL0z57ltBF?=
 =?us-ascii?Q?n/pTVpTSykWKmVVEH2/BaqVpPa9HFvFX8wqeYo8MKOtEzSgpgJFOUyhIHvrw?=
 =?us-ascii?Q?Q6P0yKuzkLBppHQGwzbiIUeRb0IGB9RnVaFdDx7YaF6NBrLrvMcs0EW1gaOq?=
 =?us-ascii?Q?M4WYG46vvkZj9RAoiY/DU5bdu0WdcbBphBm2E/VfeqN9riaETehRZmQulnPX?=
 =?us-ascii?Q?AOxA1bzhDdI0b9B/Uc23sdntBcOktPJsiJ0hgKMaY/xfLVuAFC7lIgI5XRmp?=
 =?us-ascii?Q?ifRwbwbEqUTtSmV1bAg95s5vPm8kYPWjCC7jMD8KBvcMkUGDleENERbn4ruV?=
 =?us-ascii?Q?V6Z55KRMSquxwHpN7uYOpg/FwWFFVHZceVXo+HbXJU4xqogWuu0PhIljw+ID?=
 =?us-ascii?Q?whAKsTPduT0/j0jt+rAGIrzhqtfkAo1AXHu/yFdBbjXNYGyQkE5n+mTKPpfv?=
 =?us-ascii?Q?xfjZ+fxOtCQAIPCANvdZwVTsEAp1A4mf/NtwN3ZaHp8F48VVrar0vEB/mbtp?=
 =?us-ascii?Q?OlBVFX9+NUuL1IrTcBgL7Lv/iHETiVYUWVwuSeD93btZTHuZNEsZceXm+dqS?=
 =?us-ascii?Q?3C0zao0Xu69uJQXeNUCTNEQfF+gKv+3zY6Z07Heta3NWfmzPN1wxF3Kul4Ah?=
 =?us-ascii?Q?kdEx3cCajyFEJDHItAKvyRUwjDl5orOetbKpFhrYE8qsHqG9KaIO?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b2123212-6aa9-4a03-184e-08df25c231e1
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 05:00:10.1517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tVU+4h24buVixJk4SH92cF6IHBNrKg7NKr3ANl8kDLhLXczqqn8MAwYJbXYdJYhVrW/N1glhRAYy5CDQZv9RDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOP286MB4369

A vNTB PCI function can now expose endpoint-local DMA channels to its
host. Decode the extension and register the advertised channels before
the NTB device, so clients of that NTB device can use the DMA
functionality in the same PCI function. Endpoints without the extension,
or hosts without support for its DMA type or with no DMA IRQ available,
continue without DMA.

Only DW eDMA is supported for now. Dispatch on the advertised DMA type
and keep type-specific setup in local helpers. Support for another
implementation can add a new case and its own helpers.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v5:
  - Simplify the implementation by using pcim_iomap_range()
  - Drop the unrelated MW size-limit change for pci-epf-ntb bridges.

 drivers/ntb/hw/epf/ntb_hw_epf.c | 336 ++++++++++++++++++++++++++++++--
 1 file changed, 323 insertions(+), 13 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index c47607d4f8a7..7faa40d1ae00 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -8,6 +8,7 @@
 
 #include <linux/atomic.h>
 #include <linux/delay.h>
+#include <linux/dma/edma.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
@@ -20,6 +21,7 @@
 #define CMD_TEARDOWN_MW		4
 #define CMD_LINK_UP		5
 #define CMD_LINK_DOWN		6
+#define CMD_SETUP_DMA_BAR	7
 
 #define NTB_EPF_ARGUMENT	0x4
 #define MSIX_ENABLE		BIT(16)
@@ -44,6 +46,32 @@
 #define NTB_EPF_DB_DATA(n)	(0x34 + (n) * 4)
 #define NTB_EPF_DB_OFFSET(n)	(0xB4 + (n) * 4)
 
+/* Private DMA wire extension produced by pci-epf-vntb. */
+#define NTB_EPF_DMA_BASE	0x134
+#define NTB_EPF_DMA_MAGIC	(NTB_EPF_DMA_BASE + 0x00)
+#define NTB_EPF_DMA_REV_LEN	(NTB_EPF_DMA_BASE + 0x04)
+#define NTB_EPF_DMA_TYPE	(NTB_EPF_DMA_BASE + 0x08)
+#define NTB_EPF_DMA_REGION_BAR(base)	((base) + 0x00)
+#define NTB_EPF_DMA_REGION_OFFSET(base)	((base) + 0x04)
+#define NTB_EPF_DMA_REGION_SIZE(base)	((base) + 0x08)
+#define NTB_EPF_DMA_REGION_SIZEOF	0x0C
+#define NTB_EPF_DMA_SUBMAP_BASE	(NTB_EPF_DMA_BASE + 0x0C)
+#define NTB_EPF_DMA_COMMON_SIZE	0x18
+#define NTB_EPF_DMA_REG_BASE	(NTB_EPF_DMA_BASE + NTB_EPF_DMA_COMMON_SIZE)
+#define NTB_EPF_DMA_CHAN_BASE	(NTB_EPF_DMA_REG_BASE + \
+					 NTB_EPF_DMA_REGION_SIZEOF)
+#define NTB_EPF_DMA_CHAN_SIZE	0x14
+#define NTB_EPF_DMA_CHAN_DESC_BASE(n)	(NTB_EPF_DMA_CHAN_BASE + \
+					 (n) * NTB_EPF_DMA_CHAN_SIZE + 0x00)
+#define NTB_EPF_DMA_CHAN_DESC_ADDR_LO(n)	(NTB_EPF_DMA_CHAN_BASE + \
+					 (n) * NTB_EPF_DMA_CHAN_SIZE + 0x0C)
+#define NTB_EPF_DMA_CHAN_DESC_ADDR_HI(n)	(NTB_EPF_DMA_CHAN_BASE + \
+					 (n) * NTB_EPF_DMA_CHAN_SIZE + 0x10)
+
+#define NTB_EPF_DMA_MAGIC_VALUE	0x414d444e /* "NDMA": NTB DMA */
+#define NTB_EPF_DMA_REVISION	1
+#define NTB_EPF_DMA_TYPE_DW_EDMA	1
+
 /*
  * Legacy doorbell slot layout when paired with pci-epf-*ntb:
  *
@@ -97,6 +125,24 @@ struct ntb_epf_irq_ctx {
 	unsigned int irq_no;
 };
 
+struct ntb_epf_dma_region {
+	unsigned int bar;
+	resource_size_t offset;
+	resource_size_t size;
+};
+
+struct ntb_epf_dw_edma {
+	struct dw_edma_chip chip;
+	struct ntb_epf_dma_region reg;
+	struct ntb_epf_dma_region ll[EDMA_MAX_RD_CH];
+};
+
+struct ntb_epf_dma {
+	struct ntb_epf_dma_region submap;
+	unsigned int nr_irqs;
+	u32 type;
+};
+
 struct ntb_epf_dev {
 	struct ntb_dev ntb;
 	struct device *dev;
@@ -108,6 +154,8 @@ struct ntb_epf_dev {
 	unsigned int mw_count;
 	unsigned int spad_count;
 	unsigned int db_count;
+	struct ntb_epf_dma dma;
+	struct ntb_epf_dw_edma dw_edma;
 
 	void __iomem *ctrl_reg;
 	void __iomem *db_reg;
@@ -162,6 +210,212 @@ static int ntb_epf_send_command(struct ntb_epf_dev *ndev, u32 command,
 	return ret;
 }
 
+static bool ntb_epf_dma_region_parse(struct ntb_epf_dev *ndev, u32 base,
+				     bool optional,
+				     struct ntb_epf_dma_region *region)
+{
+	resource_size_t bar_len;
+	u32 bar, offset, size;
+
+	bar = readl(ndev->ctrl_reg + NTB_EPF_DMA_REGION_BAR(base));
+	offset = readl(ndev->ctrl_reg + NTB_EPF_DMA_REGION_OFFSET(base));
+	size = readl(ndev->ctrl_reg + NTB_EPF_DMA_REGION_SIZE(base));
+	region->bar = bar;
+	region->offset = offset;
+	region->size = size;
+	if (!size)
+		return optional && bar == U32_MAX && !offset;
+	if (bar > BAR_5)
+		return false;
+
+	bar_len = pci_resource_len(ndev->ntb.pdev, bar);
+	if (offset > bar_len || size > bar_len - offset)
+		return false;
+
+	return true;
+}
+
+/* DW eDMA */
+
+static int ntb_epf_dw_edma_parse(struct ntb_epf_dev *ndev, u32 length)
+{
+	struct ntb_epf_dw_edma *edma = &ndev->dw_edma;
+	struct dw_edma_chip *chip = &edma->chip;
+	u32 count, chan_offset;
+	unsigned int i;
+
+	chan_offset = NTB_EPF_DMA_CHAN_BASE - NTB_EPF_DMA_BASE;
+	if (length < chan_offset + NTB_EPF_DMA_CHAN_SIZE ||
+	    (length - chan_offset) % NTB_EPF_DMA_CHAN_SIZE)
+		return -EINVAL;
+
+	count = (length - chan_offset) / NTB_EPF_DMA_CHAN_SIZE;
+	if (count > EDMA_MAX_RD_CH)
+		return -EINVAL;
+
+	if (!ntb_epf_dma_region_parse(ndev, NTB_EPF_DMA_REG_BASE, false,
+				      &edma->reg) ||
+	    !IS_ALIGNED(edma->reg.offset, sizeof(u32)))
+		return -EINVAL;
+
+	chip->mf = EDMA_MF_EDMA_UNROLL;
+	chip->ll_rd_cnt = count;
+	chip->func_no = PCI_FUNC(ndev->ntb.pdev->devfn);
+
+	for (i = 0; i < count; i++) {
+		u64 paddr;
+
+		if (!ntb_epf_dma_region_parse(ndev,
+					      NTB_EPF_DMA_CHAN_DESC_BASE(i),
+					      false, &edma->ll[i]) ||
+		    !IS_ALIGNED(edma->ll[i].offset, sizeof(u32)))
+			return -EINVAL;
+
+		paddr = readl(ndev->ctrl_reg +
+			      NTB_EPF_DMA_CHAN_DESC_ADDR_LO(i));
+		paddr |= (u64)readl(ndev->ctrl_reg +
+				    NTB_EPF_DMA_CHAN_DESC_ADDR_HI(i)) << 32;
+		if (paddr == U64_MAX)
+			return -EINVAL;
+
+		chip->ll_region_rd[i].sz = edma->ll[i].size;
+		chip->ll_region_rd[i].paddr = paddr;
+	}
+	ndev->dma.nr_irqs = count;
+
+	return 0;
+}
+
+static int ntb_epf_dw_edma_irq_vector(struct device *dev, unsigned int nr)
+{
+	struct ntb_epf_dev *ndev = dev_get_drvdata(dev);
+
+	/* DMA vectors follow the NTB link and doorbell vector block. */
+	return pci_irq_vector(ndev->ntb.pdev, ndev->db_count + 1 + nr);
+}
+
+static const struct dw_edma_plat_ops ntb_epf_dw_edma_ops = {
+	.irq_vector = ntb_epf_dw_edma_irq_vector,
+};
+
+static void __iomem *
+ntb_epf_dw_edma_map_region(struct pci_dev *pdev,
+			   const struct ntb_epf_dma_region *region)
+{
+	return pcim_iomap_range(pdev, region->bar, region->offset, region->size);
+}
+
+static int ntb_epf_dw_edma_init(struct ntb_epf_dev *ndev)
+{
+	struct ntb_epf_dw_edma *edma = &ndev->dw_edma;
+	struct dw_edma_chip *chip = &edma->chip;
+	struct pci_dev *pdev = ndev->ntb.pdev;
+	unsigned int i;
+	int ret;
+
+	/* Install BAR submaps before mapping the advertised DMA regions. */
+	ret = ntb_epf_send_command(ndev, CMD_SETUP_DMA_BAR, 0);
+	if (ret)
+		return ret;
+
+	chip->reg_base = ntb_epf_dw_edma_map_region(pdev, &edma->reg);
+	if (IS_ERR(chip->reg_base))
+		return PTR_ERR(chip->reg_base);
+	for (i = 0; i < chip->ll_rd_cnt; i++) {
+		chip->ll_region_rd[i].vaddr.io =
+			ntb_epf_dw_edma_map_region(pdev, &edma->ll[i]);
+		if (IS_ERR(chip->ll_region_rd[i].vaddr.io))
+			return PTR_ERR(chip->ll_region_rd[i].vaddr.io);
+	}
+
+	chip->dev = ndev->dev;
+	chip->nr_irqs = ndev->dma.nr_irqs;
+	chip->ops = &ntb_epf_dw_edma_ops;
+	chip->flags = DW_EDMA_CHIP_PARTIAL;
+
+	return dw_edma_probe(chip);
+}
+
+static void ntb_epf_dw_edma_deinit(struct ntb_epf_dev *ndev)
+{
+	dw_edma_remove(&ndev->dw_edma.chip);
+}
+
+/* Common endpoint DMA */
+
+static int ntb_epf_dma_parse(struct ntb_epf_dev *ndev)
+{
+	u32 magic, rev_len, length, type;
+	u32 spad_off;
+	int ret;
+
+	/*
+	 * Legacy endpoints place scratchpads where this extension would begin.
+	 * Once the extension is present, malformed metadata is fatal.
+	 */
+	spad_off = readl(ndev->ctrl_reg + NTB_EPF_SPAD_OFFSET);
+	if (spad_off < NTB_EPF_DMA_BASE + NTB_EPF_DMA_COMMON_SIZE)
+		return 0;
+
+	magic = readl(ndev->ctrl_reg + NTB_EPF_DMA_MAGIC);
+	if (!magic)
+		return 0;
+	if (magic == U32_MAX)
+		return -EIO;
+	if (magic != NTB_EPF_DMA_MAGIC_VALUE)
+		return -EINVAL;
+
+	rev_len = readl(ndev->ctrl_reg + NTB_EPF_DMA_REV_LEN);
+	length = upper_16_bits(rev_len);
+	if (lower_16_bits(rev_len) != NTB_EPF_DMA_REVISION ||
+	    length < NTB_EPF_DMA_COMMON_SIZE ||
+	    spad_off < NTB_EPF_DMA_BASE + length)
+		return -EINVAL;
+	if (!ntb_epf_dma_region_parse(ndev, NTB_EPF_DMA_SUBMAP_BASE, true,
+				      &ndev->dma.submap))
+		return -EINVAL;
+
+	type = readl(ndev->ctrl_reg + NTB_EPF_DMA_TYPE);
+	if (type == U32_MAX)
+		return -EIO;
+
+	switch (type) {
+	case NTB_EPF_DMA_TYPE_DW_EDMA:
+		if (!IS_REACHABLE(CONFIG_DW_EDMA))
+			break;
+		ret = ntb_epf_dw_edma_parse(ndev, length);
+		if (!ret)
+			ndev->dma.type = type;
+		return ret;
+	default:
+		break;
+	}
+
+	dev_warn(ndev->dev,
+		 "Endpoint DMA type %u unavailable, continuing without DMA\n",
+		 type);
+	return 0;
+}
+
+static int ntb_epf_dma_init(struct ntb_epf_dev *ndev)
+{
+	switch (ndev->dma.type) {
+	case NTB_EPF_DMA_TYPE_DW_EDMA:
+		return ntb_epf_dw_edma_init(ndev);
+	default:
+		return 0;
+	}
+}
+
+static void ntb_epf_dma_deinit(struct ntb_epf_dev *ndev)
+{
+	switch (ndev->dma.type) {
+	case NTB_EPF_DMA_TYPE_DW_EDMA:
+		ntb_epf_dw_edma_deinit(ndev);
+		break;
+	}
+}
+
 static int ntb_epf_mw_to_bar(struct ntb_epf_dev *ndev, int idx)
 {
 	struct device *dev = ndev->dev;
@@ -174,6 +428,23 @@ static int ntb_epf_mw_to_bar(struct ntb_epf_dev *ndev, int idx)
 	return ndev->barno_map[BAR_MW1 + idx];
 }
 
+static resource_size_t ntb_epf_mw_offset(struct ntb_epf_dev *ndev, int idx)
+{
+	return !idx ? readl(ndev->ctrl_reg + NTB_EPF_MW1_OFFSET) : 0;
+}
+
+static resource_size_t ntb_epf_mw_size(struct ntb_epf_dev *ndev, int bar)
+{
+	resource_size_t end;
+
+	end = pci_resource_len(ndev->ntb.pdev, bar);
+	/* The DMA submap offset marks the end of an MW sharing this BAR. */
+	if (ndev->dma.submap.size && ndev->dma.submap.bar == bar)
+		end = min(end, ndev->dma.submap.offset);
+
+	return end;
+}
+
 static int ntb_epf_mw_count(struct ntb_dev *ntb, int pidx)
 {
 	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
@@ -212,7 +483,7 @@ static int ntb_epf_mw_get_align(struct ntb_dev *ntb, int pidx, int idx,
 		*size_align = 1;
 
 	if (size_max)
-		*size_max = pci_resource_len(ndev->ntb.pdev, bar);
+		*size_max = ntb_epf_mw_size(ndev, bar);
 
 	return 0;
 }
@@ -373,16 +644,20 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
 {
 	struct pci_dev *pdev = ndev->ntb.pdev;
 	struct device *dev = ndev->dev;
+	unsigned int dma_max = ndev->dma.nr_irqs;
+	unsigned int dma_min;
 	u32 argument = MSIX_ENABLE;
+	unsigned int ntb_irqs;
 	int irq;
 	int ret;
 	int i;
 
-	irq = pci_alloc_irq_vectors(pdev, msi_min, msi_max, PCI_IRQ_MSIX);
+	irq = pci_alloc_irq_vectors(pdev, msi_min,
+				    msi_max + dma_max, PCI_IRQ_MSIX);
 	if (irq < 0) {
 		dev_dbg(dev, "Failed to get MSIX interrupts\n");
-		irq = pci_alloc_irq_vectors(pdev, msi_min, msi_max,
-					    PCI_IRQ_MSI);
+		irq = pci_alloc_irq_vectors(pdev, msi_min,
+					    msi_max + dma_max, PCI_IRQ_MSI);
 		if (irq < 0) {
 			dev_err(dev, "Failed to get MSI interrupts\n");
 			return irq;
@@ -390,8 +665,17 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
 		argument &= ~MSIX_ENABLE;
 	}
 
-	ndev->db_count = irq - 1;
-	for (i = 0; i < irq; i++) {
+	dma_min = dma_max && irq > msi_min;
+	/* Reserve one shared DMA IRQ when available, then give the rest to NTB. */
+	ntb_irqs = min_t(unsigned int, irq - dma_min, msi_max);
+	ndev->dma.nr_irqs = irq - ntb_irqs;
+	if (dma_max && !ndev->dma.nr_irqs) {
+		dev_warn(dev,
+			 "No IRQ available for endpoint DMA, continuing without DMA\n");
+		ndev->dma.type = 0;
+	}
+	ndev->db_count = ntb_irqs - 1;
+	for (i = 0; i < ntb_irqs; i++) {
 		ndev->irq_ctx[i].ndev = ndev;
 		ndev->irq_ctx[i].irq_no = i;
 		ret = request_irq(pci_irq_vector(pdev, i), ntb_epf_vec_isr,
@@ -403,7 +687,7 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
 	}
 
 	ret = ntb_epf_send_command(ndev, CMD_CONFIGURE_DOORBELL,
-				   argument | irq);
+				   argument | ntb_irqs);
 	if (ret) {
 		dev_err(dev, "Failed to configure doorbell\n");
 		goto err_free_irq;
@@ -486,7 +770,7 @@ static int ntb_epf_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
 	if (bar < 0)
 		return bar;
 
-	mw_size = pci_resource_len(ntb->pdev, bar);
+	mw_size = ntb_epf_mw_size(ndev, bar);
 
 	if (size > mw_size) {
 		dev_err(dev, "Size:%pa is greater than the MW size %pa\n",
@@ -520,21 +804,20 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
 				    phys_addr_t *base, resource_size_t *size)
 {
 	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
-	u32 offset = 0;
+	resource_size_t offset;
 	int bar;
 
-	if (idx == 0)
-		offset = readl(ndev->ctrl_reg + NTB_EPF_MW1_OFFSET);
-
 	bar = ntb_epf_mw_to_bar(ndev, idx);
 	if (bar < 0)
 		return bar;
 
+	offset = ntb_epf_mw_offset(ndev, idx);
+
 	if (base)
 		*base = pci_resource_start(ndev->ntb.pdev, bar) + offset;
 
 	if (size)
-		*size = pci_resource_len(ndev->ntb.pdev, bar) - offset;
+		*size = ntb_epf_mw_size(ndev, bar) - offset;
 
 	return 0;
 }
@@ -630,12 +913,30 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
 {
 	struct device *dev = ndev->dev;
 	int ret;
+	int i;
 
 	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_MW_COUNT);
 	if (ndev->mw_count > NTB_EPF_MAX_MW_COUNT) {
 		dev_err(dev, "Unsupported MW count: %u\n", ndev->mw_count);
 		return -EINVAL;
 	}
+	ret = ntb_epf_dma_parse(ndev);
+	if (ret) {
+		dev_err(dev, "Invalid endpoint DMA layout\n");
+		return ret;
+	}
+	if (ndev->dma.submap.size) {
+		for (i = 0; i < ndev->mw_count; i++) {
+			int bar = ntb_epf_mw_to_bar(ndev, i);
+
+			if (bar == ndev->dma.submap.bar &&
+			    ntb_epf_mw_size(ndev, bar) <=
+			    ntb_epf_mw_offset(ndev, i)) {
+				dev_err(dev, "Invalid DMA/MW boundary\n");
+				return -EINVAL;
+			}
+		}
+	}
 
 	/* One Link interrupt and rest doorbell interrupt */
 	ret = ntb_epf_init_isr(ndev, NTB_EPF_MIN_DB_COUNT + 1,
@@ -785,6 +1086,12 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
 		goto err_init_dev;
 	}
 
+	ret = ntb_epf_dma_init(ndev);
+	if (ret) {
+		dev_err(dev, "Failed to initialize endpoint DMA\n");
+		goto err_dma_init;
+	}
+
 	ret = ntb_register_device(&ndev->ntb);
 	if (ret) {
 		dev_err(dev, "Failed to register NTB device\n");
@@ -794,6 +1101,8 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
 	return 0;
 
 err_register_dev:
+	ntb_epf_dma_deinit(ndev);
+err_dma_init:
 	ntb_epf_cleanup_isr(ndev);
 
 err_init_dev:
@@ -807,6 +1116,7 @@ static void ntb_epf_pci_remove(struct pci_dev *pdev)
 	struct ntb_epf_dev *ndev = pci_get_drvdata(pdev);
 
 	ntb_unregister_device(&ndev->ntb);
+	ntb_epf_dma_deinit(ndev);
 	ntb_epf_cleanup_isr(ndev);
 	ntb_epf_deinit_pci(ndev);
 }
-- 
2.51.0

