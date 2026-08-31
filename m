Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020088.outbound.protection.outlook.com [52.101.229.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBF443B498;
	Mon, 31 Aug 2026 18:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788200835; cv=fail; b=c4LlSEAgq9o+eepnc4fOAhjqtGt4pPBqlcNSZ0JKQE8Har1U45xTvwKDNlHWTaKvMvH7XQVT+JDgfk7b+AS+OtQIxHJ3qzxaNRfdR3M/ph1bmdp8SCRT9AHCezFJs/FPSDeg6Zn1M1NPMlXWCaRyTMO3ajq9cAJj8bzq68z8/FA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788200835; c=relaxed/simple;
	bh=e8uwGqNIyGFwlmGSg7YHpW2e7yBlmpdIlIn9c+iybG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NUESXFYXalQnCb30IgeXjDPmpKeBzWq73vVDyr50a0G2meQAWSue37HditCl+92wBBtV2CST1nv2k24Sl7ehFfhzO73uVFh1yT/o0bsQZ1FIEuLfGth+dKZj724OnhcLRaE4tfGQ7YHwlS0QzfXhKoMnlxEmQAYsj+2nVaknkdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=O149j221; arc=fail smtp.client-ip=52.101.229.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="O149j221"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LChkwiG9gcUN7wLgvJxme0udeF2CcYVteAbx+X8zKos8ErGtH+7NuKjWM6nWfiKndu8vOhwdnKHx1YwGx9K3RoQTUxn68E3p/0YK2hffrtbA3aXxpABgqch/CTlPVV+nfBY6hTVbTroxv+G2KGmsu8nw9f3YRqUS+alRd9GkeNdtnb4SQp2FFDEBD/Z/AlwsagUPn6LOGYvzdFev4EYbCs3vVKtzplD76sslzqKFqMk1bT9mQv0TKqLNyu/8l2KmoaQ32ViEOhvxCl6BeY4K5WeuLmel6SZgISUXlwktyyF1DVocw5qsdb3b50EiPg1AyTNirPM9ACwzBphgQzfaOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3cMXIMp7vohMQZCWXg3zsoxGrhGnXkde7QUWuslutHc=;
 b=HGqoGgJLDKWqF2AXa1SILsD7rDvfz++V3KlnxmVGrqJ+7WbtvTX5B4peumZ9dF+3RR3lQAqbHmqVHynieu2nrDq/BiwfDwIXqxf5JSlqjz9+cm+x6HXIXH2sbMpqMVNF9PEhEOIVEcpTHJzOPLKWeMPd0nPyvGD7I/65EgrOK20gZq62T7ZcgfpvgqJbhBESQ4s1l4DQsaSy/og4p6ucyMLTmjsgHkCK0jd1zNwXCS4YlLvk2awCZEzznzz2YVPjog1gOVWWcMoJNMXfQXFwOVM+YrB55Qf6lnfqwZ4BVRbmi/ZJMOOjGlP0kOK8CYWuB545FQ+tV4WUmEXaIOI/uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cMXIMp7vohMQZCWXg3zsoxGrhGnXkde7QUWuslutHc=;
 b=O149j22115gjWBm4kOvGntpDMJJXhsjYCJ5ia8ub+mKUlqHY817MN/W4F8+c6o50YVTslXEnxkIQxIGeF+pvSB1SKYL4Zf4/r2/D0C+1fNgWjjSeZmrkwNROPTy/mQvPJGhBZjKfJmqx83EPPUkQ0EYHX9lCg/W9W6MWTH9ffCY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB1802.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:11c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:27:05 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 18:27:05 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
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
Subject: [PATCH v3 6/7] NTB: ntb_hw_epf: Discover vNTB-embedded DMA
Date: Tue,  1 Sep 2026 03:26:56 +0900
Message-ID: <20260831182657.329614-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260831182657.329614-1-den@valinux.co.jp>
References: <20260831182657.329614-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0353.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB1802:EE_
X-MS-Office365-Filtering-Correlation-Id: df55917c-258d-4ca1-6f80-08df078d75a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|1800799024|10070799003|366016|376014|22082099003|18002099003|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	CZzGzJK5G39h/3M7D06iym5icvuOcTOHRLXWdmMVI+fiRRUGkH2efEWBAVvHlQVXNDgWxAqkY3i7K9f4mwxeSsbYSodGrc4PoTdGNusYdhRNkFhPnHK5Ha2F6KOCBFVGIBWHBnYPfp6/WlyoYOck16W+AZAvTcVymy4CJlOuYFNVqe20hPmCE52Ue9/YGMgN3D6y45Sac3YRJpVqKAuLws61sPgsDjOGzgcQmxrt40qJ+C26v7GwgPSCxK4MpmhkeMlUo3RPWpW6P/OrJKsSSNotO0bFSzCHorEK5PRgC/MODapQ7t4143lGmdaKZnZVbK154xnCEQYzPnVa0+13Qu1gSzKaZUhRqgPdgA3COTl3z+gGzqfwjF5hX6tv85yvYIJHx8Xht8IKkw6DtvjmPZB1DVGT1BI3jatJG0+Twam+VP23YHhSOnj37wovtncvN+GZI6qquHmqQCVPWF8aAa49FmdOQXGouaA5L+sSUHtOnBfGpRKZ75iaoF/co5vWtvIXfAK9vW9qU6CfpgAv+iRC38DInwKMoFqu4di2knSXIaLpHATcZkQFqzrLLfIIB7xjU8lA6WYZkahoklV9aTPVLBCo5YTICdRpzcZVApUBhBwRbE4v1O+yhtEjVt8iN1H0rK4ucqbUpi9C+5CTNCyL1/clTTBb5mVzsq+ftFQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(1800799024)(10070799003)(366016)(376014)(22082099003)(18002099003)(56012099006)(6133799003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?puOe7qRQP5VAWX0ayp92SAAwlXo7K5ysv6I8dzxmusX4kmLxkgyDB5o4+PQZ?=
 =?us-ascii?Q?xPKAqliqipCTmoU6WUMBxGC99+LGWse7BYsE7wMxguOIGQxrP8R2juqrUvjh?=
 =?us-ascii?Q?Ys7umG1TJD59ugS4v6aD4FHv/z5hoF9rUYalBTni6y6Sand63z0b2YGyZve1?=
 =?us-ascii?Q?KcR02hJXj6+elBbdqZ6PkbkpcurFlQ5SCAFjqVsb6XyeekFWl6CLkNVYvx5t?=
 =?us-ascii?Q?Z1/6uXJkJ30viSc8bwA28IQeTJv9ugtcqjDkNL8w+wh541is9IbN45sbgCAa?=
 =?us-ascii?Q?rd6PWXzQsIXaQmBBxKJM9062LuNaU84xktiNLdHf5YOgeQ+nPbKqGxYBpC4O?=
 =?us-ascii?Q?0e2mdC0L49TzXv/D2TRAXC/HuZRtNq3JFu5U3jzsA4SFy3zOGdNr80Nwx5uo?=
 =?us-ascii?Q?inBYpqM8/yaw2LGI/dzzFmLkM+v6QJxLPSUhd4k09+EMAPu/NK3Hn9IjMDBD?=
 =?us-ascii?Q?l+AADoP8QDDgWwqTUzapMyjoZGpUSRbK0QL5zGk4xm2Up4bb6xzPXi4hKJn0?=
 =?us-ascii?Q?iLUXkMySg1ZXLXwGEPzt30RKcx8g3sXFjoItfSu2XCS4yEt2sWI9vaaRvTAs?=
 =?us-ascii?Q?Zn7F0OoVhhiqvcdQ8ns7NOR26Xp1oFqtc7UL6JCj1l/qEY7MeMw/cyRaf+aM?=
 =?us-ascii?Q?RsnXfJRkBI+qKFfQIwSCmse17XfAM+kcUUKlu3ShYnL/+KJeZiwWaGGLDt15?=
 =?us-ascii?Q?MlgfEVWNkitwmjl3xkphf1haBkycEwRbPCssuqpwqpva/5en2fzLh1Ik6faZ?=
 =?us-ascii?Q?oPFqCeUwEVabmsMwTWI5d8uZH5ikO5qh6M2jswu+Acm0majLIkVTQhgwskKw?=
 =?us-ascii?Q?xGPjDC4ClcaOENdb6Y9LboQi9icgsTFhWWbqSFTWcLOcY5hPUKx7PLuaDxgf?=
 =?us-ascii?Q?uqK7zcnoKyuUzwkbs074Y6p3unhncXbveSdavPomQHTL+fSvWlTxXeUqLmf4?=
 =?us-ascii?Q?CMb610ykmA91qljoPWXg9Weg7LNrnXCjObEMrxagzZ+GincotA/xMmK+qTFd?=
 =?us-ascii?Q?8/wVubliSeBgboE+tvUO1/R1gMb3GnYZCtYKJISjfS/RIDJk/jeHogVTn/fB?=
 =?us-ascii?Q?U6vMSuWTfOf/GrDm+Lphag5gyo+9SO8jT02s5OLerJ9Qb8CVPTqJNINU1On1?=
 =?us-ascii?Q?WLuQcDXqT4AEs2Hb0Chc3qE3qwLCOwZh/WoLWiJlKwsLtG04CUwBL7e9Xj7p?=
 =?us-ascii?Q?XxDH1cyEL1vwmWiIfZ51dWFS5nI2I2ECt+vNoRr3ZzzCAviC5mZtBeo3d/NL?=
 =?us-ascii?Q?Gdyq8xpGteEwwMsS/VhRUJLQgdK5iir/Lo/7kkbPYAbk32XTVv3gkPeduRfA?=
 =?us-ascii?Q?R7Mh4aYzxDmZn5lEoIZxwtwdPTetvhuj/s80huecxF0mJjpXy2XfW5aadegl?=
 =?us-ascii?Q?9J/VJfV/cre8htOrqatjeB0fAXrgmOW6kP5yqDS107QrEPk09LHP5xI1txfC?=
 =?us-ascii?Q?3yP0I2pBJeNusBQCZL0k3RMDbKajVczZ6sGV/ok7SRClm7QASKlZCvGnkvNO?=
 =?us-ascii?Q?80aDGtMH9OWa0hvzqJjdL4KL7E2aV8Ib0w/QFOKDE3sH2wrfqHN7fv/6l4GI?=
 =?us-ascii?Q?rcFHV93qf/pr4+RFEtK/nP7O0rNPD7lV82dMmDzfNbeHAKAVULFe1HsZjNpk?=
 =?us-ascii?Q?Xru7wWIqc7uqBD8BrTGLVvYd7WtdkR26fGYPxqGEok6uIm+bu+xC00iJY3j3?=
 =?us-ascii?Q?R0vII6pB+R1AfSEzX2IArOvN6JuRPBbAlz/VjCVaRbASC+NnMpwBEbBbp8Zl?=
 =?us-ascii?Q?SsZ3KXK1E05py7k1UYNZKw8myX9aSgngUtfjeeZvFpIst6KrB9o+?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: df55917c-258d-4ca1-6f80-08df078d75a3
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:27:05.5852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t/56cdCn7i1WJ6DWfPXitwGS4sb+ab7yDksdce9uYtLr56iIQcvKuY5hE3DRH/rGJk+Dk53Jr7pDmm8uqFKuyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1802

A vNTB PCI function can now expose endpoint-local DMA channels to its
host. Decode the extension and register the advertised channels before
the NTB device, so clients of that NTB device can use the DMA
functionality in the same PCI function. Endpoints without the extension
keep the existing path.

Only DW eDMA is supported for now. Dispatch on the advertised DMA type
and keep type-specific setup in local helpers. Support for another
implementation can add a new case and its own helpers.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Validate DW eDMA register and linked-list offsets before mapping them.
    (Sashiko)

 drivers/ntb/hw/epf/ntb_hw_epf.c | 362 ++++++++++++++++++++++++++++++--
 1 file changed, 350 insertions(+), 12 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index c47607d4f8a7..16cde97d4bde 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -8,6 +8,7 @@
 
 #include <linux/atomic.h>
 #include <linux/delay.h>
+#include <linux/dma/edma.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
@@ -20,6 +21,8 @@
 #define CMD_TEARDOWN_MW		4
 #define CMD_LINK_UP		5
 #define CMD_LINK_DOWN		6
+#define CMD_CONFIGURE_DMA	7
+#define CMD_TEARDOWN_DMA	8
 
 #define NTB_EPF_ARGUMENT	0x4
 #define MSIX_ENABLE		BIT(16)
@@ -44,6 +47,32 @@
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
@@ -97,6 +126,25 @@ struct ntb_epf_irq_ctx {
 	unsigned int irq_no;
 };
 
+struct ntb_epf_dma_region {
+	unsigned int bar;
+	resource_size_t offset;
+	resource_size_t size;
+	void __iomem *vaddr;
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
@@ -108,6 +156,8 @@ struct ntb_epf_dev {
 	unsigned int mw_count;
 	unsigned int spad_count;
 	unsigned int db_count;
+	struct ntb_epf_dma dma;
+	struct ntb_epf_dw_edma dw_edma;
 
 	void __iomem *ctrl_reg;
 	void __iomem *db_reg;
@@ -162,6 +212,245 @@ static int ntb_epf_send_command(struct ntb_epf_dev *ndev, u32 command,
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
+	chip->nr_irqs = count;
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
+static int ntb_epf_dw_edma_map_region(struct pci_dev *pdev,
+				      struct ntb_epf_dma_region *region)
+{
+	region->vaddr = pci_iomap_range(pdev, region->bar, region->offset,
+					region->size);
+	return region->vaddr ? 0 : -ENOMEM;
+}
+
+static void ntb_epf_dw_edma_unmap_regions(struct ntb_epf_dev *ndev)
+{
+	struct ntb_epf_dw_edma *edma = &ndev->dw_edma;
+	struct pci_dev *pdev = ndev->ntb.pdev;
+	unsigned int i;
+
+	for (i = 0; i < edma->chip.ll_rd_cnt; i++) {
+		if (!edma->ll[i].vaddr)
+			continue;
+		pci_iounmap(pdev, edma->ll[i].vaddr);
+	}
+	if (edma->reg.vaddr)
+		pci_iounmap(pdev, edma->reg.vaddr);
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
+	/* Install the endpoint BAR submaps before mapping the advertised regions. */
+	ret = ntb_epf_send_command(ndev, CMD_CONFIGURE_DMA, 0);
+	if (ret)
+		return ret;
+
+	ret = ntb_epf_dw_edma_map_region(pdev, &edma->reg);
+	if (ret)
+		goto err_teardown;
+	for (i = 0; i < chip->ll_rd_cnt; i++) {
+		ret = ntb_epf_dw_edma_map_region(pdev, &edma->ll[i]);
+		if (ret)
+			goto err_iounmap;
+		chip->ll_region_rd[i].vaddr.io = edma->ll[i].vaddr;
+	}
+
+	chip->dev = ndev->dev;
+	chip->ops = &ntb_epf_dw_edma_ops;
+	chip->flags = DW_EDMA_CHIP_PARTIAL;
+	chip->reg_base = edma->reg.vaddr;
+
+	ret = dw_edma_probe(chip);
+	if (ret)
+		goto err_iounmap;
+
+	return 0;
+
+err_iounmap:
+	ntb_epf_dw_edma_unmap_regions(ndev);
+err_teardown:
+	ntb_epf_send_command(ndev, CMD_TEARDOWN_DMA, 0);
+	return ret;
+}
+
+static void ntb_epf_dw_edma_deinit(struct ntb_epf_dev *ndev)
+{
+	struct ntb_epf_dw_edma *edma = &ndev->dw_edma;
+	int ret;
+
+	dw_edma_remove(&edma->chip);
+	ntb_epf_dw_edma_unmap_regions(ndev);
+
+	ret = ntb_epf_send_command(ndev, CMD_TEARDOWN_DMA, 0);
+	if (ret)
+		dev_warn(ndev->dev, "Failed to teardown endpoint DMA\n");
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
+		ret = ntb_epf_dw_edma_parse(ndev, length);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	if (!ret)
+		ndev->dma.type = type;
+
+	return ret;
+}
+
+static int ntb_epf_dma_init(struct ntb_epf_dev *ndev)
+{
+	switch (ndev->dma.type) {
+	case 0:
+		return 0;
+	case NTB_EPF_DMA_TYPE_DW_EDMA:
+		return ntb_epf_dw_edma_init(ndev);
+	default:
+		return -EOPNOTSUPP;
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
@@ -174,6 +463,25 @@ static int ntb_epf_mw_to_bar(struct ntb_epf_dev *ndev, int idx)
 	return ndev->barno_map[BAR_MW1 + idx];
 }
 
+static resource_size_t ntb_epf_mw_offset(struct ntb_epf_dev *ndev, int idx)
+{
+	return !idx ? readl(ndev->ctrl_reg + NTB_EPF_MW1_OFFSET) : 0;
+}
+
+static resource_size_t ntb_epf_mw_size(struct ntb_epf_dev *ndev, int idx,
+				       int bar)
+{
+	resource_size_t offset, end;
+
+	offset = ntb_epf_mw_offset(ndev, idx);
+	end = pci_resource_len(ndev->ntb.pdev, bar);
+	/* The DMA submap offset marks the end of an MW sharing this BAR. */
+	if (ndev->dma.submap.size && ndev->dma.submap.bar == bar)
+		end = min(end, ndev->dma.submap.offset);
+
+	return offset < end ? end - offset : 0;
+}
+
 static int ntb_epf_mw_count(struct ntb_dev *ntb, int pidx)
 {
 	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
@@ -212,7 +520,7 @@ static int ntb_epf_mw_get_align(struct ntb_dev *ntb, int pidx, int idx,
 		*size_align = 1;
 
 	if (size_max)
-		*size_max = pci_resource_len(ndev->ntb.pdev, bar);
+		*size_max = ntb_epf_mw_size(ndev, idx, bar);
 
 	return 0;
 }
@@ -373,15 +681,19 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
 {
 	struct pci_dev *pdev = ndev->ntb.pdev;
 	struct device *dev = ndev->dev;
+	unsigned int dma_irqs = ndev->dma.nr_irqs;
+	unsigned int ntb_irqs;
 	u32 argument = MSIX_ENABLE;
 	int irq;
 	int ret;
 	int i;
 
-	irq = pci_alloc_irq_vectors(pdev, msi_min, msi_max, PCI_IRQ_MSIX);
+	irq = pci_alloc_irq_vectors(pdev, msi_min + dma_irqs,
+				    msi_max + dma_irqs, PCI_IRQ_MSIX);
 	if (irq < 0) {
 		dev_dbg(dev, "Failed to get MSIX interrupts\n");
-		irq = pci_alloc_irq_vectors(pdev, msi_min, msi_max,
+		irq = pci_alloc_irq_vectors(pdev, msi_min + dma_irqs,
+					    msi_max + dma_irqs,
 					    PCI_IRQ_MSI);
 		if (irq < 0) {
 			dev_err(dev, "Failed to get MSI interrupts\n");
@@ -390,8 +702,9 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
 		argument &= ~MSIX_ENABLE;
 	}
 
-	ndev->db_count = irq - 1;
-	for (i = 0; i < irq; i++) {
+	ntb_irqs = irq - dma_irqs;
+	ndev->db_count = ntb_irqs - 1;
+	for (i = 0; i < ntb_irqs; i++) {
 		ndev->irq_ctx[i].ndev = ndev;
 		ndev->irq_ctx[i].irq_no = i;
 		ret = request_irq(pci_irq_vector(pdev, i), ntb_epf_vec_isr,
@@ -403,7 +716,7 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
 	}
 
 	ret = ntb_epf_send_command(ndev, CMD_CONFIGURE_DOORBELL,
-				   argument | irq);
+				   argument | ntb_irqs);
 	if (ret) {
 		dev_err(dev, "Failed to configure doorbell\n");
 		goto err_free_irq;
@@ -486,7 +799,7 @@ static int ntb_epf_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
 	if (bar < 0)
 		return bar;
 
-	mw_size = pci_resource_len(ntb->pdev, bar);
+	mw_size = ntb_epf_mw_size(ndev, idx, bar);
 
 	if (size > mw_size) {
 		dev_err(dev, "Size:%pa is greater than the MW size %pa\n",
@@ -520,21 +833,20 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
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
+		*size = ntb_epf_mw_size(ndev, idx, bar);
 
 	return 0;
 }
@@ -630,12 +942,29 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
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
+			    !ntb_epf_mw_size(ndev, i, bar)) {
+				dev_err(dev, "Invalid DMA/MW boundary\n");
+				return -EINVAL;
+			}
+		}
+	}
 
 	/* One Link interrupt and rest doorbell interrupt */
 	ret = ntb_epf_init_isr(ndev, NTB_EPF_MIN_DB_COUNT + 1,
@@ -785,6 +1114,12 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
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
@@ -794,6 +1129,8 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
 	return 0;
 
 err_register_dev:
+	ntb_epf_dma_deinit(ndev);
+err_dma_init:
 	ntb_epf_cleanup_isr(ndev);
 
 err_init_dev:
@@ -807,6 +1144,7 @@ static void ntb_epf_pci_remove(struct pci_dev *pdev)
 	struct ntb_epf_dev *ndev = pci_get_drvdata(pdev);
 
 	ntb_unregister_device(&ndev->ntb);
+	ntb_epf_dma_deinit(ndev);
 	ntb_epf_cleanup_isr(ndev);
 	ntb_epf_deinit_pci(ndev);
 }
-- 
2.51.0

