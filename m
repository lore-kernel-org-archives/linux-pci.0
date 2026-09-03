Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020104.outbound.protection.outlook.com [52.101.229.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24324499BA;
	Thu,  3 Sep 2026 08:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423910; cv=fail; b=K1ygGdlmLJ/yf3ehPqv3SGp3yBErezJAN7QLu/h5CBC/FjGd3Hba/LagH6qLG8nJPcFwjJRy1EimzhpS6G2aIocVyw14qQZGi3M/ht+vP6v9pZ9oIDXKKDZb35cG0/JQCZ3o2QVUchyvsyMG94D2plX4m9bVq+GPgOCS8xS5DQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423910; c=relaxed/simple;
	bh=GwJLU6cdOHjS2AMd0Hm6yDuAuzasaaDZCvz6BL2Q4Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p7/9DmmdaASPgidf+vJwKIHRHri/thSaqWSsrNAWt3x5gpgjNbPu4Uuu3C3hLrPiOU/+O0uDjQEjoWPN5zkz5j/BNeANuhhIMIumdZ+k9NKh7tLM3bYQ7VRv8qpYGvotKhLL3zR27NceZ7XRF9myoC5OPsox9bPdd1UQ9DlDceg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=F1NLK8P7; arc=fail smtp.client-ip=52.101.229.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="F1NLK8P7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uB0RUGUZLBa5Zaup8UClgLo/fGsW+3R4Y3wNfxCt3fGbpeT7oDDYhY5i+Y0bYKaTgmMufzLPVNLB8kT6sUNK/aKJw3TinMvo3eGp1bjwaIaYs/Vvtb+27dFv1WMxcL7gbY5vg6ngit7bHZ7U2yF8X555zbW40aU2Tv/hxBT9MIN1IAAI0f3KhdKfvoqpgBlJcTRsD3ufKWxCDF3/Op0wGzO5xonV1nff9W90yf4vR59i4Oo33vRLGtuG5tYTUUhF49UPRK2JKcs8fHaBCrc9rcgqHbmdKPRlZet0/1S5ktyXhHIcR7qe4bYcC7nJAzWtYxL8+X7/O4FGezuJoLUpFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8FYFsEkATCvQzRmXdGmwyluIkWVgdlWAwd712t5F9M=;
 b=o31u1hZowjzO1/T+OmRFhpUbQ+1HW7ttKNfFiRkGiQg9M0UxN564VDl7WcVn3fifm+rccWXV6wJICwFLyhIDeGGqaqG9t6sknrOS7BVSh+vnc2qjpoKYa3hnC6RRgKYNS/PBIrsGgLwGT+mMFQgRqYztXyItxo5MfjqpGwX4DKDCdxY/itzXpLa+GaPRsD7cmbkv3W20tpzYLX7Khye9xfntHdEW8KlQmtFzW0QYUyqCNHx/ZVQ3n4BCUYxV08bZ7hxtyVOmQu6SnsiBkyxJXbhZC7E3AJcXKdwQrT87gpGUY/2g72fmSveyAYNC1HBdcPu5EGfJe+jPkuBBD/6KNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8FYFsEkATCvQzRmXdGmwyluIkWVgdlWAwd712t5F9M=;
 b=F1NLK8P7wuvO475aeYEfOg0NzsZM0mlFkavPsUiKPuuObjH7/cPjvxON5iIKrPCc8IXXMwnWfo5CKBXlQKZojpIm37c3p1YxBcuIGzVkRGZysC0cdl06unq70weWNLwTDrRbTCEHRcHjSvlAwBNi/bcfBNrgPpH708EcFibPQCc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB6382.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:41c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 08:25:03 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 08:25:03 +0000
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
Subject: [PATCH v4 6/7] NTB: ntb_hw_epf: Discover vNTB-embedded DMA
Date: Thu,  3 Sep 2026 17:23:26 +0900
Message-ID: <20260903082327.2345602-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260903082327.2345602-1-den@valinux.co.jp>
References: <20260903082327.2345602-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0130.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: de3d03f1-494c-495d-8c8d-08df0994da55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|7416014|10070799003|366016|6133799003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3IYwGJuWObkHjjk4/iidJeL8/yxl6dGB8jfEM/MgOMGY7q6W9tUh/GIoIbBIxsVjLKR/LclSt9/O54R8vKTWh1WjztdRGhNzNparDpNFKkNfgssi6GUktYQ2nEufgXEl5BmbHl0I5Kw6BmO+G558xbCLDzo0TxyK3sxywv/v0JMQLwBDkOnzR7Xqr4P947huITQmY75Sj8xAffcm4oexeUIJAYRbdRVs75NhrbxLPAj2Z4bSdkfeNW6gQSTSmd9oARe3K2ZuvuR6uRbsJhx1RPcy+gZk2ASqnMrdZ5IKVSeXD5mQsrR6/56uSv4jEoRNci8SaU9Ykhg0TD79+Kewe+klY8nfTLdLgx6UigtwnDcDR7ZM3nHSmaqtMBtCytzu+OAvFdBrHbjWqo3bRnwYyUK9xIPe92/jt0cVChjuTFCwYpIvKBLR7tKUsXamoIFh7JPpuNX+XTtqn/BPYi21joyUyCuFxupIQR7MxQ4eGQon+Y/VIE4REwx02QqFZGrwDwM9lotUfKBextIj6fBpEmvTrsLveWWGQwmXZQ8bwE4SHEUUGdE/QFCqdFgDDqPOPbQ9+yjA8s0M4TPqEAEU3vST9gUuOd9LFDSp8gxNQ5sEgeJU1wWLhQvc0ZqRleY9wPtKcCaQdRfRQ9SsAw21Zs2Tvw8uFpK8NQ64G94u9mU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(7416014)(10070799003)(366016)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2cMhwvZYXDCEzQBak8N33EQR4ZU3g5T4voyUotCAtgP+dpHhyVggV1HaERso?=
 =?us-ascii?Q?+kxjVJe/xDIgAUOZ1VPHYTyN/mpdA4FpgbOIYOF8EcsYz0BD7za2K+KdtR0w?=
 =?us-ascii?Q?MvQ8zqPcxgtO3R1uDORP9LPXY4LJYBk7it75+J+JLZ03pQU+efYKRDvFpQEy?=
 =?us-ascii?Q?9x758u+Yn96Pmx4uv7Hd99NSU0eex2kqtEI88/oc5KVLZ2AgU0hRpUOyNJVs?=
 =?us-ascii?Q?N+bvVnHLYGLBCswhaoubV2H7kDj44Zak9dsa0EGYblM8Z2yqP6TovNiL04sy?=
 =?us-ascii?Q?+NscHzr230vZCQ18mA5adhy+wzJt//g8Va3xAmf0sl3qOkayKWg0yM07e2Ip?=
 =?us-ascii?Q?l4hIEzFcVd3FnCI7SkeVOXOofWpSZZ6Wy93QCEvKr/e50cc1i5e5hR6qcMCG?=
 =?us-ascii?Q?7WlSTdTaKyjoa2hB0M+21KGKR9TJ80Yhk1ynZ4RufEb48w8CTONMSlePeFZb?=
 =?us-ascii?Q?JksH02L7N8CcOoT9DE3AJTOmq6ZaJQusU73SrU6aFA5IeVszu4sRp0Przds2?=
 =?us-ascii?Q?QbDdIpZ56ijDo8P83ZoMHIPUzTwQqi0B7tYEjenZipy4XZYL1Ewz7HZ7KOjN?=
 =?us-ascii?Q?JskDXc/ZImu8/M5Sg654nvu6oLUt3vLa3CAzRBkf4idWvbE8BmphgJeXyNUo?=
 =?us-ascii?Q?89VqzB3oXwK/3d0h1HyZc5mP+NA3WJE9J7G6XLlEMAbvZ5tTsoPgp9JdLQCd?=
 =?us-ascii?Q?mrpN1yZ0NGrRafJzfRHBZjWl618bKgbDqen7mSIuxDiJKw+giVu6Lj6yRct2?=
 =?us-ascii?Q?+9Ia73qXqLKmiQtIyAO8kGYk0JlCsSYpaLYNxsznyE7TNDo0lJOm4nYyicc2?=
 =?us-ascii?Q?XWx86ydRmIr983/E6MhtZfECh2qtXWRS5e/QuCR8zcRPLbokA57O7eSOC32+?=
 =?us-ascii?Q?dg4o1kxXfeUii+p8Kb2WMd+XKljJYvI58OG4gTLW9TBG8ByWq4kJMhu5+s36?=
 =?us-ascii?Q?YzjZdFQ5ltDblK0DUmoTzCQ2WbtRvs6zo1nbwmFxYgIVEZ2Fue+eRew308+y?=
 =?us-ascii?Q?DlXDrrCkQEaezjBIPlFBYmJeiBSBaWzE8EMuFiREwMjSDFxTrd6EyMMtNmND?=
 =?us-ascii?Q?bwXFNOLvGQ++lHCJeIzMYBWuEnLa+VpnrOzV+8p/gbP0NXShrs6IGNSmV12X?=
 =?us-ascii?Q?l+cWSNiEMOPUN1RXsiaXY1eQDe85UOd4KHQYoipJ+44nWqlDy93HJfF8Ikuh?=
 =?us-ascii?Q?zfBMf/IANPNfF6rkx7UkYFb7vdqpSvUfzZV/5ZBvT2/ifYVOBb7SChZdy5Ab?=
 =?us-ascii?Q?Te8FGjVA8yZBXwhd4KyN05ogxCxv4xw7EdDKo1phB1AEFrVKZUPqo9KmqPRO?=
 =?us-ascii?Q?OYh7NHXs8Xhrd8HKQZEto7i55V4+38K5rUmrm+MVvhno6BVoPOSCyZJj+2N8?=
 =?us-ascii?Q?AS8hZD1UacqbIdV4dKpCb4afg69kp9Ja8DdriaFnpQ0cBNHNT7p6Tms+5uJ2?=
 =?us-ascii?Q?rLLluJe1QR7OcWqhQLjlUD8Avo/gVn7HpoeyNL3R3sq4qgk+G+bD/R4DXCe7?=
 =?us-ascii?Q?13orbMzkyy8QcpBccce0pk6vIjFDWcSjn+v6vstywGQDZUMzzlbz+Dg6+D6h?=
 =?us-ascii?Q?LamE9MS7lFKPaLfaoVWbP0kG2k1xrsdIku001NOPzbhaGPOaLDcBHmmanRSz?=
 =?us-ascii?Q?tb62G0GZG33hF12qaFauv0S/3fsHFSDEUgKVa4y1r2/M7KhpS8tJR5t/rStl?=
 =?us-ascii?Q?CjzyjOvUjuJ7a7XKzFtqmg+KrlKlFD5V0VipE6mgi3g6sUdynovp3JtizkGT?=
 =?us-ascii?Q?DCoeJEWE2aktZAUaVqcM9I9TuIYFlEOAWUVY32yDtB/4Ix3olspx?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: de3d03f1-494c-495d-8c8d-08df0994da55
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 08:25:03.3971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FECc3NLmvia3ZqB5kaD7/D6f9LAqCE+AGPsbe0aAIj1bFA10yB6Jg5ZsmS/5FGQaG94FrgzFWeycN1DQ1mx31w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6382

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
Changes in v4:
  - Do not ask the endpoint to remove DMA BAR submaps during local
    teardown. They remain valid until EPF unbind. (Sashiko)
  - Rename CONFIGURE_DMA to SETUP_DMA_BAR to distinguish this bind-lifetime
    BAR setup from CONFIGURE_MW's outbound mapping.
  - Accept fewer DMA IRQs than advertised channels, or continue without DMA
    if no DMA IRQ is available. (Sashiko)
  - Continue without DMA when the advertised type is unsupported or DW eDMA
    is unavailable. (Sashiko)

 drivers/ntb/hw/epf/ntb_hw_epf.c | 366 ++++++++++++++++++++++++++++++--
 1 file changed, 353 insertions(+), 13 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index c47607d4f8a7..2072dd942eee 100644
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
@@ -97,6 +125,25 @@ struct ntb_epf_irq_ctx {
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
@@ -108,6 +155,8 @@ struct ntb_epf_dev {
 	unsigned int mw_count;
 	unsigned int spad_count;
 	unsigned int db_count;
+	struct ntb_epf_dma dma;
+	struct ntb_epf_dw_edma dw_edma;
 
 	void __iomem *ctrl_reg;
 	void __iomem *db_reg;
@@ -162,6 +211,240 @@ static int ntb_epf_send_command(struct ntb_epf_dev *ndev, u32 command,
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
+	/* Install BAR submaps before mapping the advertised DMA regions. */
+	ret = ntb_epf_send_command(ndev, CMD_SETUP_DMA_BAR, 0);
+	if (ret)
+		return ret;
+
+	ret = ntb_epf_dw_edma_map_region(pdev, &edma->reg);
+	if (ret)
+		return ret;
+	for (i = 0; i < chip->ll_rd_cnt; i++) {
+		ret = ntb_epf_dw_edma_map_region(pdev, &edma->ll[i]);
+		if (ret)
+			goto err_iounmap;
+		chip->ll_region_rd[i].vaddr.io = edma->ll[i].vaddr;
+	}
+
+	chip->dev = ndev->dev;
+	chip->nr_irqs = ndev->dma.nr_irqs;
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
+	return ret;
+}
+
+static void ntb_epf_dw_edma_deinit(struct ntb_epf_dev *ndev)
+{
+	struct ntb_epf_dw_edma *edma = &ndev->dw_edma;
+
+	dw_edma_remove(&edma->chip);
+	ntb_epf_dw_edma_unmap_regions(ndev);
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
@@ -174,6 +457,25 @@ static int ntb_epf_mw_to_bar(struct ntb_epf_dev *ndev, int idx)
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
@@ -212,7 +514,7 @@ static int ntb_epf_mw_get_align(struct ntb_dev *ntb, int pidx, int idx,
 		*size_align = 1;
 
 	if (size_max)
-		*size_max = pci_resource_len(ndev->ntb.pdev, bar);
+		*size_max = ntb_epf_mw_size(ndev, idx, bar);
 
 	return 0;
 }
@@ -373,16 +675,20 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
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
@@ -390,8 +696,17 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
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
@@ -403,7 +718,7 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
 	}
 
 	ret = ntb_epf_send_command(ndev, CMD_CONFIGURE_DOORBELL,
-				   argument | irq);
+				   argument | ntb_irqs);
 	if (ret) {
 		dev_err(dev, "Failed to configure doorbell\n");
 		goto err_free_irq;
@@ -486,7 +801,7 @@ static int ntb_epf_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
 	if (bar < 0)
 		return bar;
 
-	mw_size = pci_resource_len(ntb->pdev, bar);
+	mw_size = ntb_epf_mw_size(ndev, idx, bar);
 
 	if (size > mw_size) {
 		dev_err(dev, "Size:%pa is greater than the MW size %pa\n",
@@ -520,21 +835,20 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
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
@@ -630,12 +944,29 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
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
@@ -785,6 +1116,12 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
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
@@ -794,6 +1131,8 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
 	return 0;
 
 err_register_dev:
+	ntb_epf_dma_deinit(ndev);
+err_dma_init:
 	ntb_epf_cleanup_isr(ndev);
 
 err_init_dev:
@@ -807,6 +1146,7 @@ static void ntb_epf_pci_remove(struct pci_dev *pdev)
 	struct ntb_epf_dev *ndev = pci_get_drvdata(pdev);
 
 	ntb_unregister_device(&ndev->ntb);
+	ntb_epf_dma_deinit(ndev);
 	ntb_epf_cleanup_isr(ndev);
 	ntb_epf_deinit_pci(ndev);
 }
-- 
2.51.0

