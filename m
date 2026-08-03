Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020085.outbound.protection.outlook.com [52.101.229.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EB842C4FE;
	Mon,  3 Aug 2026 18:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785780289; cv=fail; b=g/mYwbgnpIR/w7Ly92Gg5bMp9LATCmewABHdbxcJOdHbcGq/jqJ0o6Of4nhRJ2tBPSOIV6PUuJ4DQpHbziiUI2i/ULLo+CRMkpZ5T4YRjqZeTI7wpMJV3uVlgZxZXmoXb41c8Z5aOSGHv0RkEoYpEZbhNvo4cCEmcxJMqB7i4HU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785780289; c=relaxed/simple;
	bh=LWgRiusVL2z7eyIi+LDgmdq9+zgxtNnTqjfQ7ovSPY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sNzXi4o+5L/Li1teKLo/kcl4blnkGy5vosXutYzrgCbZo4Be2GEO9i7cE2JYoRl5opqSKH8amp+OZVC7i7m9ESyPrNQwfmZGFJazTphH7VMQJE8xXP4mnr4mvW3K++uZuiOzVVDd6rh9klkJC5spxrpAocikJiN9xCCyhsMl1pE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=q2x8VnSm; arc=fail smtp.client-ip=52.101.229.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="q2x8VnSm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fnZdBAWfXQ23M557oDNIN/SQR7yU32R/N07hhqAuBfv3L70eApRkIIRK+L3Y08+URRhzEu1IM4+owSnBAgj22aCwzK8qb0BcGSkJNlx/Cjs4eAPifVoSoseS0ny9pL/MjQlMMWGsk7sn8DLcYzZ+V91+Gp9Ksnx0YSG1fLFvjMQaEbmcnVvvgZMCX46ddfeWnZ9bIFk1OctpjOOUT4SVB0ltF4gGhXpBAorhtzvDJq/2n1PfAm8Z12Wb/++aJwyXnVAp29RudBn160J/6DT2TiKL5Ia+R19Sx82arjetXNUTHEI7aIYO23OEZvAVbULBYfvUTUMiTKCZ/G+DZ+lzzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7mdFiGYhAkRSEPQ14+pjfyy233mBm8d2YChGpELC94=;
 b=tk30loEX+W6I9cDaDXsfwpg9H4ELRyz4jj2ae9NlhNn/Z21ey/VbfVdkuwtA5vUe0YTXJYoU8FgUXQ8ipDBFHfj5IzBqVPvsFSLBPQbmOIQB/XMTgIbE7SY+6MwGvedtZMnwO9XNrv648bQycAubGDToBdCkAkVRxZeO8eQW28BG6gZWHNQNpcOjKNTvzUDWj9bvn5aMmduYDKxQC0ftLsMeUDDjISB1340RPiarSyAOcrrcnBZ+pdyZxn2CqGq6lH0IKrNUpdMWOrXH3+BvRGo42vLMrJOdum4Qt+3zeeVIxm/0SU61tRNIGJKTQZL6hlZuMKj6xOl6/lv5BOWqjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7mdFiGYhAkRSEPQ14+pjfyy233mBm8d2YChGpELC94=;
 b=q2x8VnSm0PkXnc2u9AfpZPO0j0ptedENlMIm6dkMcdcY3D544Zt32ehEznFPt4ztdUsGD0lWdkvAs0KgLANI46hR18ZbUchCt/18yP66lOytvyuxQ6YxAdiKz+ekikuG0QJQ188WCj4CRBzpKoGTjQcTlJJtmuDJGUsof1EkxKI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB5249.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:115::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 18:04:43 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 18:04:43 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Jerome Brunet <jbrunet@baylibre.com>
Cc: linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH 02/11] NTB: epf: Parse a versioned packed MW layout
Date: Tue,  4 Aug 2026 03:04:29 +0900
Message-ID: <20260803180439.1963864-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260803180439.1963864-1-den@valinux.co.jp>
References: <20260803180439.1963864-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0060.jpnprd01.prod.outlook.com
 (2603:1096:405:370::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB5249:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d84609d-4959-4364-f673-08def189b206
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|10070799003|921020|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	75p4YpPoqhaLwgZgsxJ/tqkQPY1HZ1ZaIs4n3BCp1PX2wjCkWkJzwc2GeugsuycPGxbp05ZixcUMQqTcyQZH8mrvOq/xO+E0Qia8xnOXAv3xVvc2XIWuFN3dtVesqwylMzI2Wys/zi6mgT7fZl6Och57RD+ZI0qUcBFUOolP/W3cB3wowxpmaFBByc2GiZuyPXxa8Ws2AR+2NXbxcMPgwnxmq13X/uDmUsAw67mq+ouXODyg0UlwcBr8OCe2oFrC5e4WuVi6GMnshacxrrIjNi+vb3ftpCVN+EQHJEL/gSWbfTmvkL0xXPBedNEFJQRBKcV+IGgMUJ0hanuSKAplEoMWyOB7zw1b0G4rehMZ2NnmbnAGO/bcG9eFapLvdR2yF19QvmBVgKL4SW1Rh9lmqh5aDnIBK3Ab0CmnAhwN9h1I2lNWWu3h8l36sBBh2ytlf6sYhSnyigzzlrbQ3O5ZUmZcdhQqZoZ9LAt8ygn41up0MwI8iAAhM93YQjnxqDv1W3hHefgBeEGWrMiw/rZJghA0UHAPFbsPUUHwRAz90WIYU2vZ8IE/pMUjTNnuxtqDbNlQsHzmtrLipqKg/Y+t5cttDTkf6scmOfPWRHouj3iSjP8XE1R0JYFi/QoQi4nzJvHYnCSxMhXrqAhbiMZ8IMCznOR146sVzXKqIJeNKH4oYhooiA1KS5K8VIr8YM5uYchu0Z1+spRXF/6zI4q2Mw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(10070799003)(921020)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k4ESECBA278sL7SQwQ3I/qIYqjvLiND8veLL82uXLWg3aF+6r6ktdbWEIDGH?=
 =?us-ascii?Q?S8bMCkaUVW2d5fzitmolijLX+B5z11Z+DhCBK0MPiLO+ojTdbyDTMNPQbh8U?=
 =?us-ascii?Q?GHbOHgjTsVSDO9BIN7LzWwXWQv+oRdZq+2drDo3zLhAXRLGPdzM+O02lfUho?=
 =?us-ascii?Q?fleXq6xtY3w5nBUmMS8MTB2d9GxCphVKlu4C0Z7i6hxouFqTqb4kVnY2T7dI?=
 =?us-ascii?Q?RQ277VOA8Ul1NnP4xW0J0R1Vi+kgbi6eFNZJ360oZrA6APgTaoeSfrqpvEtd?=
 =?us-ascii?Q?Lvg70DiPTLTqcznQJCcygvHpq0jv3pHm7b1Q0CaLQAbCkcz9ji5OUvt2+3ea?=
 =?us-ascii?Q?7PXtYTTCFPjmqXMUzRsd9ntpE/4Lv9rlag7krdP3A9Ax9wXA6qK9mWd2GQ89?=
 =?us-ascii?Q?TtKdDHLO1ppwCEzu9cXFcY37KsidNBAXqHLyV33AOjGkBl7ckJWyaRHofG3b?=
 =?us-ascii?Q?ivEn/xmhp6v1RxeX4LhEOuoex+L9h0LycJ2CYXwLPRtJCSxi4WuK3J84BLbB?=
 =?us-ascii?Q?prmjeFB7HFG//7DwJDzIxVHVS8VilO6lD0aRrh4kOx60nidVBZMIJhLrmyHp?=
 =?us-ascii?Q?7xAiqV9lzSNhXQXqAY30uNbq40aLZpRgm9elSqk6a02VffFa7gtFmbY4WB5g?=
 =?us-ascii?Q?TvdRAHu0HVw7bhR0vtHJRv0+qXclQ56nEjouAUpWUEDyXaaNsRL6XJX1mAeF?=
 =?us-ascii?Q?gkjEd7Pg6XoN6abWHqFG4YvG2cy0N9v+q17XP/Bd+NylS4vZe5lJfcZsMZbG?=
 =?us-ascii?Q?m14gxFYTXNH0CBRftlcWu8aQkIYxjnjSJAwf/WzmsPjfG44apyE0KsIKCJ7I?=
 =?us-ascii?Q?8vPERmysJ7TLXqzM1x1OYRRlfFYuQTtSfcISh7+p3K73rYcEpyDv1nHG+H/i?=
 =?us-ascii?Q?F/5BGUhdzOfYcAOQlWwUnTXqqMTuMoxbGPaI1hjI8IbT32i2Q0DY929AQ2PU?=
 =?us-ascii?Q?j+J2AWTZcYHykkXNp3krmkf3cjmP5tCJFPVhIicy2B8dOWzbvl84fLqtWgxi?=
 =?us-ascii?Q?x53SlTRxNLiswVHgsRnAfRezhihPJ1TRnRumEowq7iFtjq2oE+bAQuQU0085?=
 =?us-ascii?Q?jpsn+xl00h9QQa5LQGjSGJUmtMve9EvXxys6GV2XKeq3vf5/Uk5xXvND+STc?=
 =?us-ascii?Q?sGEt4GJUEZNOMTSpVCUMs/jGF4holWExZKE0ATlNmSMfemj9sq/O9mURvUnu?=
 =?us-ascii?Q?I7/OsgOZOl2/kLRUATGVijdvA+DQoX6j4rwcRqAdevGdRqke43/oSpyBxqTX?=
 =?us-ascii?Q?TC4KFugRzhPP0n6bhPK0PRBsJEZbOXcsuyKRT4XJx1usSVkck799Zm3HpY3i?=
 =?us-ascii?Q?cNnITfwLEw5oDZad70Z6wjJNAd7SEvvsiKocDtHq0qFtCHZBxmW7JAwnR+ft?=
 =?us-ascii?Q?CZk+c10yWAHWkPWjFTSAKd4o8/5YlwxN6Vkb7r3ILes43dCf0lj8B013MrqX?=
 =?us-ascii?Q?9BbfBY33j6EAGx7V10PF5QWX0/qAuMHoOD9E/CDCBAABH7+8L4rnCfdbsfNr?=
 =?us-ascii?Q?HjUaOMK9FMBSR/bvny/W3rxPdAY0JG62VUOQ0JQ0KyrmvRA1NKlrfESb3zgu?=
 =?us-ascii?Q?AlnHgYEmafUDo2aTfbuaHT/GJqnLZhHN8qA9T2id87plcO9o/trNxQwl+a3X?=
 =?us-ascii?Q?HdpHquxqJ+gtCLWPWtw/5SUYtgKnwgoKS8q1F/Xnr/pVJNxI/YMx6CLu5ZbP?=
 =?us-ascii?Q?/FYW6YNvPXUiiXl3YxnW5rwtB4/qPfBTpWVi+8vv9vQvQ7D4JSKNqFSOCs+W?=
 =?us-ascii?Q?OG8CcMG5Deahso+rB0pdN+zQsHEiF5s9G5bXD6AIIfZi17O3fgjT?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d84609d-4959-4364-f673-08def189b206
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 18:04:43.3335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JPC6QbKVXDSlr7sUiTaLbXLzIhee+GZ3dwJOJY+MQqgMK6eV6komJDphkqfT054BfS6L61FvpPM+1JuUzMzS4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5249

The legacy control layout cannot describe multiple logical MWs sharing
one BAR. Treat a zero version as legacy; version 1 describes all MWs as
one packed group using a BAR number and aggregate size. Derive the
equal-sized logical MWs from the existing MW count.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c | 102 ++++++++++++++++++++++++++++----
 1 file changed, 90 insertions(+), 12 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index c47607d4f8a7..46f37c2dea7b 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -31,18 +31,22 @@
 #define NTB_EPF_LINK_STATUS	0x0A
 #define LINK_STATUS_UP		BIT(0)
 
-#define NTB_EPF_TOPOLOGY	0x0C
+#define NTB_EPF_CTRL_VERSION	0x0C
+#define NTB_EPF_CTRL_V1		1
 #define NTB_EPF_LOWER_ADDR	0x10
 #define NTB_EPF_UPPER_ADDR	0x14
 #define NTB_EPF_LOWER_SIZE	0x18
 #define NTB_EPF_UPPER_SIZE	0x1C
 #define NTB_EPF_MW_COUNT	0x20
-#define NTB_EPF_MW1_OFFSET	0x24
+#define NTB_EPF_MW1_OFFSET	0x24	/* v0 only */
 #define NTB_EPF_SPAD_OFFSET	0x28
 #define NTB_EPF_SPAD_COUNT	0x2C
 #define NTB_EPF_DB_ENTRY_SIZE	0x30
 #define NTB_EPF_DB_DATA(n)	(0x34 + (n) * 4)
 #define NTB_EPF_DB_OFFSET(n)	(0xB4 + (n) * 4)
+/* v1 only */
+#define NTB_EPF_MW_BAR		0x134
+#define NTB_EPF_MW_GROUP_SIZE	0x138
 
 /*
  * Legacy doorbell slot layout when paired with pci-epf-*ntb:
@@ -88,7 +92,8 @@ enum epf_irq_slot {
 	EPF_IRQ_DB_START,
 };
 
-#define NTB_EPF_MAX_MW_COUNT	(NTB_BAR_NUM - BAR_MW1)
+#define NTB_EPF_LEGACY_MAX_MW_COUNT	(NTB_BAR_NUM - BAR_MW1)
+#define NTB_EPF_MAX_MW_COUNT		16
 
 struct ntb_epf_dev;
 
@@ -105,9 +110,12 @@ struct ntb_epf_dev {
 
 	const enum pci_barno *barno_map;
 
+	u32 ctrl_version;
 	unsigned int mw_count;
 	unsigned int spad_count;
 	unsigned int db_count;
+	u32 mw_bar;
+	u32 mw_size;
 
 	void __iomem *ctrl_reg;
 	void __iomem *db_reg;
@@ -171,6 +179,9 @@ static int ntb_epf_mw_to_bar(struct ntb_epf_dev *ndev, int idx)
 		return -EINVAL;
 	}
 
+	if (ndev->ctrl_version >= NTB_EPF_CTRL_V1)
+		return ndev->mw_bar;
+
 	return ndev->barno_map[BAR_MW1 + idx];
 }
 
@@ -211,8 +222,37 @@ static int ntb_epf_mw_get_align(struct ntb_dev *ntb, int pidx, int idx,
 	if (size_align)
 		*size_align = 1;
 
-	if (size_max)
-		*size_max = pci_resource_len(ndev->ntb.pdev, bar);
+	if (size_max) {
+		if (ndev->ctrl_version >= NTB_EPF_CTRL_V1)
+			*size_max = ndev->mw_size;
+		else
+			*size_max = pci_resource_len(ndev->ntb.pdev, bar);
+	}
+
+	return 0;
+}
+
+static int ntb_epf_mw_get_trans_group(struct ntb_dev *ntb, int pidx, int idx,
+				      int *gidx, int *gcount)
+{
+	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
+	struct device *dev = ndev->dev;
+
+	if (pidx != NTB_DEF_PEER_IDX) {
+		dev_err(dev, "Unsupported Peer ID %d\n", pidx);
+		return -EINVAL;
+	}
+
+	if (idx < 0 || idx >= ndev->mw_count) {
+		dev_err(dev, "Unsupported Memory Window index %d\n", idx);
+		return -EINVAL;
+	}
+
+	if (gidx)
+		*gidx = ndev->ctrl_version >= NTB_EPF_CTRL_V1 ? 0 : idx;
+	if (gcount)
+		*gcount = ndev->ctrl_version >= NTB_EPF_CTRL_V1 ?
+			  ndev->mw_count : 1;
 
 	return 0;
 }
@@ -520,21 +560,27 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
 				    phys_addr_t *base, resource_size_t *size)
 {
 	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
-	u32 offset = 0;
+	resource_size_t offset = 0;
 	int bar;
 
-	if (idx == 0)
-		offset = readl(ndev->ctrl_reg + NTB_EPF_MW1_OFFSET);
-
 	bar = ntb_epf_mw_to_bar(ndev, idx);
 	if (bar < 0)
 		return bar;
 
+	if (ndev->ctrl_version >= NTB_EPF_CTRL_V1)
+		offset = (resource_size_t)idx * ndev->mw_size;
+	else if (idx == 0)
+		offset = readl(ndev->ctrl_reg + NTB_EPF_MW1_OFFSET);
+
 	if (base)
 		*base = pci_resource_start(ndev->ntb.pdev, bar) + offset;
 
-	if (size)
-		*size = pci_resource_len(ndev->ntb.pdev, bar) - offset;
+	if (size) {
+		if (ndev->ctrl_version >= NTB_EPF_CTRL_V1)
+			*size = ndev->mw_size;
+		else
+			*size = pci_resource_len(ndev->ntb.pdev, bar) - offset;
+	}
 
 	return 0;
 }
@@ -601,6 +647,7 @@ static const struct ntb_dev_ops ntb_epf_ops = {
 	.db_vector_count	= ntb_epf_db_vector_count,
 	.db_vector_mask		= ntb_epf_db_vector_mask,
 	.db_set_mask		= ntb_epf_db_set_mask,
+	.mw_get_trans_group	= ntb_epf_mw_get_trans_group,
 	.mw_set_trans		= ntb_epf_mw_set_trans,
 	.mw_clear_trans		= ntb_epf_mw_clear_trans,
 	.peer_mw_get_addr	= ntb_epf_peer_mw_get_addr,
@@ -629,14 +676,45 @@ static inline void ntb_epf_init_struct(struct ntb_epf_dev *ndev,
 static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
 {
 	struct device *dev = ndev->dev;
+	resource_size_t bar_len;
+	u32 group_size;
 	int ret;
 
+	ndev->ctrl_version = readl(ndev->ctrl_reg + NTB_EPF_CTRL_VERSION);
 	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_MW_COUNT);
-	if (ndev->mw_count > NTB_EPF_MAX_MW_COUNT) {
+
+	if (ndev->ctrl_version && ndev->ctrl_version != NTB_EPF_CTRL_V1) {
+		dev_err(dev, "Unsupported control region version: %u\n",
+			ndev->ctrl_version);
+		return -EINVAL;
+	}
+
+	if ((!ndev->ctrl_version &&
+	     ndev->mw_count > NTB_EPF_LEGACY_MAX_MW_COUNT) ||
+	    ndev->mw_count > NTB_EPF_MAX_MW_COUNT) {
 		dev_err(dev, "Unsupported MW count: %u\n", ndev->mw_count);
 		return -EINVAL;
 	}
 
+	if (ndev->ctrl_version >= NTB_EPF_CTRL_V1) {
+		ndev->mw_bar = readl(ndev->ctrl_reg + NTB_EPF_MW_BAR);
+		group_size = readl(ndev->ctrl_reg + NTB_EPF_MW_GROUP_SIZE);
+
+		if (ndev->mw_count < 2 || ndev->mw_bar > BAR_5 ||
+		    !group_size || group_size % ndev->mw_count) {
+			dev_err(dev, "Invalid packed MW layout\n");
+			return -EINVAL;
+		}
+
+		ndev->mw_size = group_size / ndev->mw_count;
+		bar_len = pci_resource_len(ndev->ntb.pdev, ndev->mw_bar);
+		if (!IS_ALIGNED(ndev->mw_size, SZ_4K) || group_size != bar_len) {
+			dev_err(dev, "Packed MW layout does not match BAR%u\n",
+				ndev->mw_bar);
+			return -EINVAL;
+		}
+	}
+
 	/* One Link interrupt and rest doorbell interrupt */
 	ret = ntb_epf_init_isr(ndev, NTB_EPF_MIN_DB_COUNT + 1,
 			       NTB_EPF_MAX_DB_COUNT + 1);
-- 
2.51.0

