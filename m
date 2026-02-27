Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020083.outbound.protection.outlook.com [52.101.228.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EA43B52EB;
	Fri, 27 Feb 2026 08:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772182223; cv=fail; b=t3gCZe/u0qnR3z4GghFwhTKtJKNerFO8bUWv0NLd+LaUdWFD8Bd6A2gfi8m4lUBMJ+/W0Wzs62fROVvwrpJBgkS+9X4XdCWbiWZgylCJcPsLwfBRulAMm+4l/An4jHiEp6sXD5cu/AOP4IJ70gKhhdkyrq50pBCsGayUSZo6bFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772182223; c=relaxed/simple;
	bh=iO/H4BZzoFJK/UO/XPwynW8qSCdHHF+NpLFWaqQ0phQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OvU7RR79Oz0bYNKKHjUPkqI+cfKDz4dE58HAmE8hiWmSjivtby2Uz+dC1+e5GdUWIgcTKXOEt6HI5gxFpmNPdprkmPnlyOBLQLfZ55YJCUjQl/rZopROP2uWJqNpulgxazBVFSeF8wF1/Ypt7+UNW9eKP6hlnoqpRHK0ck5pMfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=OC/Xb6Mf; arc=fail smtp.client-ip=52.101.228.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="OC/Xb6Mf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ExryMa+JPUyRmmvrhM1FuooRtKrySJtvt//giqahlsPHYtGlgUqZkVIaOGPIXF8s5xBPyqOxPB2yLzqqtbAN797ko84ih7cplTRNqhQCyetZWxD7xM2IlX+owJkwUi8nbEio4o0/6L5ETMCIDIaEAu+Uvq5P/hM3wgFsKkuZI+Subbknk2gn+JF92ysIg629IFwrWeNZiKDDlM0cNrr+KAFCW/d27B02qnCfw4aGTiA7MgrWZe35huwHPHCw+/h8v8vDvuckmmdo1iccLfD4jT3JY5idXABeTT1rR2/XiazarGurbY0kWBiNBkprDkMr2Gwv5Q6lKdnj+YFRqaW3Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfplpCk/VF7NcyCUzLJQVxioV5wsV/Wo8RMNwCx5IJw=;
 b=Q3vrXs0sUNr4LSTUTvcHvs+gmv5vxRpNM+2cggXDSoS/MAnOqfOXHP1+btR/EzWL+8C06fhuwxb5xE4FPyEAg2yvuGpNB0deoQ8HcuqWNZgHGPh6wGx1OBcntb6uayMR3cZt53LxuJJeYEiYLPyypuHbOpv6EN1CKstNh3382BmdWchbtjNdNVGKqaHMtN5gWzROgeGMZXot3zge04RjIH4pfxKtaE5gV/1VdUrdrwBOnGoJJdNdn4kDtP2HhE5prZMS43zyUOMzSP3fHBhMt0uztBNxQ9CIS3Lqjxp0wuxxpy4d4YkShQxnQtD5Q8T5k+iPJYSTQyYCRTGTbPh+1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfplpCk/VF7NcyCUzLJQVxioV5wsV/Wo8RMNwCx5IJw=;
 b=OC/Xb6Mf9P8MVKY2NnoRVxCjzoIzHjQ+XBgfY2vN6j5tisZJTVSAfi2cU47kzXJPictpgj9DM6L29Hq2yZmPztxfo+9NL/oRyJpDaJ9FUW91C5ICv1XEwqixc9FLipnrlUS47CHhh3z+MmsiyKCYmPEwC/nDRzcHPrWTyNnweD4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS3P286MB2135.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:196::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Fri, 27 Feb
 2026 08:50:05 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9654.013; Fri, 27 Feb 2026
 08:50:05 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank.Li@nxp.com,
	dave.jiang@intel.com,
	kishon@kernel.org,
	jdmason@kudzu.us,
	mani@kernel.org,
	allenbh@gmail.com,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	jbrunet@baylibre.com,
	lpieralisi@kernel.org
Cc: linux-pci@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/10] NTB: epf: Fix doorbell bitmask handling in db_read/db_clear
Date: Fri, 27 Feb 2026 17:49:54 +0900
Message-ID: <20260227084955.3184017-10-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260227084955.3184017-1-den@valinux.co.jp>
References: <20260227084955.3184017-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0063.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS3P286MB2135:EE_
X-MS-Office365-Filtering-Correlation-Id: af4105b5-51ef-44b3-9037-08de75dd3428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|7416014|1800799024|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	hfalpOeMduKu056xtl+EWviQ1PUdvMxudbH24+nSV9tvVpa2osYlhvv2C4EaFeGQ2BnkEB6HHP5dfWj2V36xLw73/G2Hpu/av+qWPoQfvnXCDwfPw5Lz+c2ordVqyb10zKbR6uFNhwqi7blTKUiV7uAjW1Cw2lLt4hOImgQ8KF5YP8zFrWdHMr0HBEGujzCRtdxM+eLJ+TA+DmgLTcPtBr3ZtVTUdFkV7OBUhfHGjDxVf8L2p1PHJeWTlSJeSWnaMZXIWEUsvyq7AwWLUvIObL+4p8uiDiVemCthGfrCdxr+PQFYtYd/Ztq4DiNBTlDfIe4R2Rcx8CyvdtX8MwVk6KzKrmzhMZXwlCrOeGTEa+iB3AfDxSByIFs5ZcuCglxwWcpyMkYhb63ItiPLn0Hbsj/AaytJhyda73I5RnoVH6MfdUOYcMexn0+MpPR2uclg1u+ItiFJX0l1Oa7PP+zW84NYpTmFsZezEhfiB1yMbq7Ar4/je/SqWyjEoMtDi6TZN8kcf1QjCg+lWAia04Q1YyIQWZdop9XXUmYlLtxRsF4AqecSimSg0oley0zwt12g39vzoDmDyBbRAqaQcLsekF5eLr90Fl+oFwtg8JU9Hz2/UnxzKexGk8yJPUAszxA+aLW5vXGDS7ebXJTjyIt5LN/Rse2ski21AuoFSeTH0xG+irF+EJdKJkm2C5RwGLqbMzkF0ibM+ipIHk2lakttCrKFg7oqqhlAUTUJHMLfN8FxbS/BBiqw50rZe9ovzPc73pLF80aMI6P7aLr4QxmpyA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(1800799024)(376014)(921020)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CsQZI4NTT8uWaT9M8RB65FnfdRr9ZWnQXbW06wV/IIGAdJPaU8yBTEkUz5qV?=
 =?us-ascii?Q?TtFFl+/tjAdDIDAQNk9avKL+xwZvyDdaXsdyRf+NYltENUalV3gEt9rJzjVo?=
 =?us-ascii?Q?9ckkXv3ws3YOl6AttjnYnldy8Kx1gOpk8T4vkn0YpffzX/7Oht//yFRQuON8?=
 =?us-ascii?Q?wH8UaomOfCaH+prK0md7TpJmZQQzRc6iKocKpPCB/oD97AJ7g6Gsz378mmqI?=
 =?us-ascii?Q?j8SHkLeCliVBxy5N1X9TPDnJjcTSvlzRG3VCD/q4heXfRdYlv/GId8c76CO7?=
 =?us-ascii?Q?8RbZzZ6v8lQroJ7VY1WoIaRfb+4s7HCMlb5WhRWL3tPtFQ0qXSQ3ITlD/Blb?=
 =?us-ascii?Q?nDNXFZSmSduR2pyufoJgLI1piJ4Cv1vb1y+QzxAhHaYKrMu3GGEJgtYZDrGC?=
 =?us-ascii?Q?lq8vF7jEUxhM0f+Z2l5pwiLgMAs9LXy8zqkN0MUgrfxXte8SESvUbFMG4awR?=
 =?us-ascii?Q?8oUWfA7vG5evsD0XE5iunZ/c9wpPZI+wMLpJH3Im6b5xdk+a06aQpEmoyjrz?=
 =?us-ascii?Q?3NxRTuqGXuaHsfylspLt5tbM8byf7qRHfpah8UI+7b1N55qYBN2tifzi8Pmp?=
 =?us-ascii?Q?iJwKqIcTHQMHGiWwxbjl2C474P0Mi+pwiaFJ0aHj0PhBbaK0D2q1tQVvNUH3?=
 =?us-ascii?Q?MhJvH4yv9IkBPsHZOCIEjcFGG7mQss+urSBVhX7V+P7C+pwfcff2wf0nr46Z?=
 =?us-ascii?Q?Gi13K3iltLE+UixX/4qAd5tYAe8mjgmU5wh89xjtnhguSLnwW+0nDYxKriI2?=
 =?us-ascii?Q?iyqnDf56BIbQJk+lX9GkS/rdAjOKH13DmqrNjtlU7yJTmZvs82clIKPOXFFg?=
 =?us-ascii?Q?2TE5QrrgMFPHFg38TSiMTcrDnJqClX4VwuaqLY8kd4UYZzRXfk5geX4uwN56?=
 =?us-ascii?Q?60ttDgYI5mFPeC4RHG7nDfyjz85AGCTL4+0TMCp1sIRTIrzJI60NlFwYJNv4?=
 =?us-ascii?Q?jkVFH559s5DvuJfDe9/7mukY2ocyZynjhCBjdYISqZdu53WjBTyRbuQDr3hF?=
 =?us-ascii?Q?Q97J4uja88My2OW5L0ZGrDVu4sIpKmVivsMT6zB4xPOJDmjqz6BqRX/3Q5Av?=
 =?us-ascii?Q?5c/uT/2zPKOFAUYZ+94Kn7/UNjXZDOMd9+NNxD6rDHK9iFq+v9hdkeZ30wER?=
 =?us-ascii?Q?5zUZDYhM+ll5il7rUYRNVFShZHrSZBs9Q6aT+2epTBuPZ88OuKN5SgoCTc+9?=
 =?us-ascii?Q?z9jMqd8KS4hOja6l0Wi91Ej9l7yOdFKUBqrMMGUyoYu5w7YldM4nWDkIyn6R?=
 =?us-ascii?Q?9VQdlU3TyeSNyfm79R0OPJU1ozT5LFEbzZRKLhGOoU+dcIU5KvlM6QPFg5K+?=
 =?us-ascii?Q?80Mn1hMPXTctnhayKqT2aVlyvm2+MRuqcc0yV1+hUkJikup7DF6GVXWSxoAX?=
 =?us-ascii?Q?WUnoav2tb+I93CWiVS2ej/sNOXn7Zh/bO7aIO3mo+gSKb+qAx+jbOhszDPiq?=
 =?us-ascii?Q?8i1O539uAB4L21yf3mY8httKmDzEVFQl9bpCEQRZn+cLgnlAMh2AEvhh0fyI?=
 =?us-ascii?Q?wcGYr13Pi+GZSDRopKrJ4U+lRJDSsLJdagpQ4u64qdMx6MLkiWfsrsvmmoep?=
 =?us-ascii?Q?mtBFBWa68BgQHvn9AM1pIrAWWRRSXUkuT/c5mJjehONWeD5tr8BtVBjloaZp?=
 =?us-ascii?Q?SKEBDT7+Hel67GFugfm/geCXUBYTYHO2OJpzRO9683ntUkz+s8zXH3NYpVqx?=
 =?us-ascii?Q?fnmP4iFsxaPyNKFhFXbOBM8qaxXNSTw2QcH6xszxthWfU72nR102/+FH1zgn?=
 =?us-ascii?Q?L+MPwLeu3sXs/fI4RmsPum2AR1WBh38SevdlNSVY2BmwiK3yLTHo?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: af4105b5-51ef-44b3-9037-08de75dd3428
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 08:50:05.7033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LgjjqXXCnhwf0HA8Pw53pqcZxypFtVLt8xL56j676Gg4M3h3eAp92vX85oYpq3Oyn4Xdw/VfIkSR+8e2/JtM2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2135

The EPF driver currently stores the incoming doorbell as a vector number
(irq_no + 1) in db_val and db_clear() clears all bits unconditionally.
This breaks db_read()/db_clear() semantics when multiple doorbells are
used.

Store doorbells as a bitmask (BIT_ULL(vector)) and make
db_clear(db_bits) clear only the specified bits. Use atomic64 operations
as db_val is updated from interrupt context.

Fixes: 812ce2f8d14e ("NTB: Add support for EPF PCI Non-Transparent Bridge")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Suggested-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v1:
  - No functional changes.
  - Addressed review comments from Dave (enum use).

 drivers/ntb/hw/epf/ntb_hw_epf.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index 67cdc5d729d5..741d30821390 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -6,6 +6,7 @@
  * Author: Kishon Vijay Abraham I <kishon@ti.com>
  */
 
+#include <linux/atomic.h>
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -108,7 +109,7 @@ struct ntb_epf_dev {
 	unsigned int self_spad;
 	unsigned int peer_spad;
 
-	int db_val;
+	atomic64_t db_val;
 	u64 db_valid_mask;
 };
 
@@ -337,15 +338,16 @@ static irqreturn_t ntb_epf_vec_isr(int irq, void *dev)
 	int irq_no;
 
 	irq_no = irq - pci_irq_vector(ndev->ntb.pdev, 0);
-	ndev->db_val = irq_no + 1;
 
 	if (irq_no == EPF_IRQ_LINK) {
 		ntb_link_event(&ndev->ntb);
 	} else if (irq_no == EPF_IRQ_RESERVED_DB) {
 		dev_warn_ratelimited(ndev->dev,
 				     "Unexpected irq_no 1 received. Treat it as DB#0.\n");
+		atomic64_or(BIT_ULL(0), &ndev->db_val);
 		ntb_db_event(&ndev->ntb, 0);
 	} else {
+		atomic64_or(BIT_ULL(irq_no - EPF_IRQ_DB_START), &ndev->db_val);
 		ntb_db_event(&ndev->ntb, irq_no - EPF_IRQ_DB_START);
 	}
 
@@ -530,7 +532,7 @@ static u64 ntb_epf_db_read(struct ntb_dev *ntb)
 {
 	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
 
-	return ndev->db_val;
+	return atomic64_read(&ndev->db_val);
 }
 
 static int ntb_epf_db_clear_mask(struct ntb_dev *ntb, u64 db_bits)
@@ -542,7 +544,7 @@ static int ntb_epf_db_clear(struct ntb_dev *ntb, u64 db_bits)
 {
 	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
 
-	ndev->db_val = 0;
+	atomic64_and(~db_bits, &ndev->db_val);
 
 	return 0;
 }
-- 
2.51.0

