Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020083.outbound.protection.outlook.com [52.101.228.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8593ACA4A;
	Fri, 27 Feb 2026 08:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772182214; cv=fail; b=V3UqjmrJRPAwy2IGEwStFdcc1no5JWYv2ZWx9bEYt9oJyNODNs864kZgL77aTQ5f0rBwdhOh0I1xbVcJgyJMVmPmEAX8H8l9xiP8VgJggeXHEbmFWsap8cXWAzrJ68a/1BPAXGmfjNprOpqcAMFp1d9ntnec73Te6GZG4XtYu7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772182214; c=relaxed/simple;
	bh=wAoOOVMQj8CrrjPzoxGKBFi+aSfFshwo/KLq5WscSZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sVpxP/jR/rzf8Z6k8oHBnnkofjNeTK/rsFTzXgnWxwK0KEc5P17OrHVV54YPt4FUg4T1zKAqboJ3eEwHaqI5PS8cOJ6qsjTWHfnzPyXohBJmpsnL8tiToNfOdERny3Ymsd3/m42n6z6wEvmkqGVxcmrePbmcUifBb3gNNbzZ72Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=IaALhS3K; arc=fail smtp.client-ip=52.101.228.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="IaALhS3K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c3kh9zr9GSyxbx+Wlbao+U2CoOWvj+TfivLw+SjL5yL0iIVjiydSfx4WRa3V+vGBEHw1NRQJ2/sIsyLJ5S0fA8p0QU1wECPM+pKhXFr7wBYMXvCqqJn3K8t7hziE4W/3k1x+C9AN8a/DWodVfh0Prpy/LSerMlupS58a9W4WYYdc8gyfjssZW8ZhCkRVFriiYLv4qTXLAqUsPB7EGRwZKV/B1KIQbuApWmD2ePCYhti08XSTDs/DvJcIOUH3hMWKJ5Zwdgrz6eud08zWpsIzONtZJiBSHBwcQUkGRlPB0BA3ffgVMM3Onj1pnpVeZq+qWLbVv4BFG2/Rh9h3alu1Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAOSlCR/UmZZ7EDJ4IWpNUE9fH5lpJZnoSJ9BbhIoIc=;
 b=DqogXBTjdG460HQo/D0Vo7Mcd5u24DL7iftQwSBHbAsRvwDHe+9ja2+WjgHhDvfIc+oSE8Fpx0xaRIo6bYdcX5fH3LhozPThoijkZdgZExwZga+jRtAhaTrL85iAcW4QZ01gk8jNv38s8Hard+F9bHGHMIXavuvOD8IH4U+bZnhzjdJ4CfPmee7tBnDNqpufi4La05TSE8ONx495xVK2fEAHFyWmq2Dh5I9z9BHk34vAMONjIictj9GT/hlNGdJItQsTXIPI4uBt95uR2rztrSloTUJLu0Qxztplw2880E3LGvzU/k3nyzCIG5lh+ayNxSp9fYwz1b+FXhd3FOK3Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAOSlCR/UmZZ7EDJ4IWpNUE9fH5lpJZnoSJ9BbhIoIc=;
 b=IaALhS3KYKzBRQeAITPPdyJjw36epEcbsglF346Q/Bo1XGJSksJiWbod47RTpqfJG0dWNV14P7em9ubrohnHtQsJ9OSPcBXGsw+xkwCbSqcHluPjVudhtg++i5f+DgOs1PZIHQ5LRRfK0GfFM5FT5PuAMWDmvl5J1EZN1HndBa4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS3P286MB2135.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:196::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Fri, 27 Feb
 2026 08:50:04 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9654.013; Fri, 27 Feb 2026
 08:50:04 +0000
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
Subject: [PATCH v2 08/10] NTB: epf: Report 0-based doorbell vector via ntb_db_event()
Date: Fri, 27 Feb 2026 17:49:53 +0900
Message-ID: <20260227084955.3184017-9-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260227084955.3184017-1-den@valinux.co.jp>
References: <20260227084955.3184017-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0208.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS3P286MB2135:EE_
X-MS-Office365-Filtering-Correlation-Id: eb714525-5ff8-45de-b4ff-08de75dd33b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|7416014|1800799024|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	XEj7U16//tg8Oh1X2+KcWKm1T7inMX+6E2w7uW6SdGF25U1VMjEozd6nPNiviEl0Qqw0Pn7RPPELTdPGJOxISkpadMWtidnkGVvI+JqZ6sodaVV1OtJscDsZjP37Tss2KqzP0nyLVGHH6P/WlyL0znsgbLIdG1/z1g4Mz6k77tXdp6yKwoXJITinNEZRcdsXFoUyP0AXzYcGCTYGFnF02TEUqg/BMSmMBhS+QWnir6U6s/uOocqMpPQLMgHwEde5+01NSobrySTxP+Q2R5GTZpi5pDAbdyAkvXIJ+nsINP+UqlR88jTReRX+l8yMDoq4qviN+6iR6i21TVHSCUkTEQC06HJpiIfTIDGvdGvHHyxo2SQsHzrNfSrnpnokq3wiLtx5G/WCjRcX5dII/QWscERFWIY8h0Npd0Hvk9uAqa0MZHaEuPz12PSJszDXz+upIV6vn4r17xK2nu7QyYpjexC7w3aPpaEn+C6DgRHzXXGRI0KNFDqAFcgE8qvfjmYuiqtOjnlwgQxlcm1LCNKuqEECgmr0PNsz4fa3xG0OsiMW/+yXJ7hbZl+Mh0IMC7MEWHB0+lRLg9u/YueUfcZ4eUI4KFpgQy35GBqZKLYVhQBp8a1Tel/58NB16SYbhEJuNO7UzG70fY2Gz3Ad/UEA/zxIwYSdWHNo8J7olWvXiF5vk6xhOrpQFDAruYxc1IdxHlvWuicIIAaRqd2l0l2wuXgKCuhVJzqRm5ptnL/T8+fv0Xj1StERDi8QiSGpPEjN8d5AUa3v/sGqM8Yzu9gNyw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(1800799024)(376014)(921020)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DQdIk3mjx/tAYxwbbPExnAK2sujwHJMeP7TzZgKzxuP5Wq7mFmsI+apvQiZB?=
 =?us-ascii?Q?4srgEJ6azDm7lJA66nwvmRzCJqeSucxb42TinTnt//+Ewo0GZgBtx7WYbDtT?=
 =?us-ascii?Q?fT66kMvZBq8T3e5lKPArOVrWsSTm2MEs5TrSQQkeurYpgxcRecOaf/QG5WTA?=
 =?us-ascii?Q?Sws7EJKkK4ezDYeVZqIrt//3FQhP5wR1vpTehafwGGFuCLfhs9nWTyYVY2el?=
 =?us-ascii?Q?+xqEDgOb29I/BcL7R6C7CZz8WtIPDPhAGt/kFwiMoo0NH7H/xHxHXdp3GQxd?=
 =?us-ascii?Q?F2rl6nNNT7CjeA+ICKwOZd2XpG/ic3eVMyBUz1WjM+tDOR6EeMqUaA+L1pm/?=
 =?us-ascii?Q?ZIHAWqGSQg2jmUtPh6cT48Mio62GarAxoxfKqvOEmTx+5BJ7JriXfL9KOi4+?=
 =?us-ascii?Q?VwHrnkibZueolczp725DIdQpxtgPIrK/6Y2J7fA9N1+Cv7pfxh1prvFuambT?=
 =?us-ascii?Q?kexLZj5cmbRRWLRJoiMxFXecxJs8OTgOGAls9ru+/BjfWuIYia+MeQF6PDji?=
 =?us-ascii?Q?iSbY31IUHOwnQeKTGdEmF8mWwiyf3r3ORb68hD4sLL1gwTGEc4PIw/iTZxk/?=
 =?us-ascii?Q?MUWUJV/dAHKFhootxWgg+ORnuazrd8SXjunqLt5xrJF4cDAveCtiRSvQLNnE?=
 =?us-ascii?Q?d9tNw7ovtpd+Y2pSLwzx7r1HO4dC0lsxRoWm0X/+j4eKPqqfITIbfczSYAM4?=
 =?us-ascii?Q?UWmroRB5YFWxWUjLxyiqH4aZ/+DLBEhghzRolN3J70K09L0iJIb7sGkovNhZ?=
 =?us-ascii?Q?C542sZ0a2ZN553Dpw2BvV9hFqfY1/6IQN+AJoHJRSmD7Q+YGwnxSj3QHOO8o?=
 =?us-ascii?Q?cbfwqbZ2FUaDTSWD+VEVCpZ3QcqLBdIyREGMtgrfpxZnqaEHg7UjjBI4+Uz7?=
 =?us-ascii?Q?1Beqegzs8m36+AVfLt8QJQHCY0f2F/xlwcWq02b9swuEBXDHC1IKBcpLN3y1?=
 =?us-ascii?Q?gXB2W+rjhCOjAkPZrbNkhm133Ebju1JxsMIWLq1EaNvP7eEHL0SZ789dCLsT?=
 =?us-ascii?Q?cpWkwMsmyQZCKkNmLvW2WJfs4kF/zXEII3PCPwumF2IuvpgH8cwiGewx47nN?=
 =?us-ascii?Q?bht5ueje8J+Fvyl4Lq30LhdlQdT6gzyaB9IzD7vHE1spjdWe1hXuKlsdDGda?=
 =?us-ascii?Q?VJd01Gz15gXONtcrVxbbGq9Acqq394AqxICkm/wlhXm87gws6RQBn9+7kHSf?=
 =?us-ascii?Q?sJodzek5/dpmK37G+N2ff16YrkQVWuRxoL5ab6vxy6/614fKtFV+VtURgD5x?=
 =?us-ascii?Q?XGKOcIJF3vBKRb5ihyot6oHsuMUUtdrmjBpUxnSnzBMCIOwqGrjAqRNZqJhV?=
 =?us-ascii?Q?PzFI6ORwnZUL6rch6UopIL9DkPZoKkaD4mShzsJFrSg6xCQfjTh/kc0B1bCU?=
 =?us-ascii?Q?FH+y2qXdJMk0WPMQTShrVDK1Z8hrEOXRvMq2il+T/fD1nl/FjX76OvOL2KF7?=
 =?us-ascii?Q?PSwlqKE9dp4cV1xN0FhcKHmfHzmjukZJT/iUtnRoPE2JRRkdLKjvXPsb7hhG?=
 =?us-ascii?Q?ScNQAgA3fH0jlNUav5xFXfnPUwn6KANcBFRI1du7Ib8PWo83zWp67FWY2jsq?=
 =?us-ascii?Q?JNrr2/be8JCka6LE8UYz/LPQN+yjH/1eGsgSK7ecqdnYurIUE/45vfFw7FSy?=
 =?us-ascii?Q?VkTFW9La1EMyAX69x74nyaocJzzy35GNIY8V72x+6ImpJ8r8byz2pbad2JTh?=
 =?us-ascii?Q?iPPLATSx3N4EaqTBCAsVCzuRWVnaUGzy5eMggg8REUJjM7Jy5+XAPSNay7nA?=
 =?us-ascii?Q?ujST5uOcwiDXYOqGljWHGYL1Seou7LcPl4ZYTmRaNMDFwvlmgLxm?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: eb714525-5ff8-45de-b4ff-08de75dd33b3
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 08:50:04.9273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c1E3y3jG/hPUK0UOFfebM90YVBlZmuNBqloZU2lC5Wd8cd37T9VUNVFNPkBCn1YX5XO9MBldbEy6lLtV2zbosA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2135

ntb_db_event() expects the vector number to be relative to the first
doorbell vector starting at 0.

Vector 0 is reserved for link events in the EPF driver, so doorbells
start at vector 1. However, both supported peers (ntb_hw_epf with
pci-epf-ntb, and pci-epf-vntb) have historically skipped vector 1 and
started doorbells at vector 2.

Pass (irq_no - 2) to ntb_db_event() so doorbells are reported as 0..N-1.
If irq_no == 1 is ever observed, treat it as DB#0 and emit a warning, as
this would indicate an unexpected change in the slot layout.

Fixes: 812ce2f8d14e ("NTB: Add support for EPF PCI Non-Transparent Bridge")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Suggested-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v1:
  - No functional changes.
  - Addressed review comments (enum epf_irq_slot introduced).

 drivers/ntb/hw/epf/ntb_hw_epf.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index 07dc97d3270b..67cdc5d729d5 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -81,6 +81,12 @@ enum epf_ntb_bar {
 	NTB_BAR_NUM,
 };
 
+enum epf_irq_slot {
+	EPF_IRQ_LINK = 0,
+	EPF_IRQ_RESERVED_DB, /* Historically skipped slot */
+	EPF_IRQ_DB_START,
+};
+
 #define NTB_EPF_MAX_MW_COUNT	(NTB_BAR_NUM - BAR_MW1)
 
 struct ntb_epf_dev {
@@ -333,10 +339,15 @@ static irqreturn_t ntb_epf_vec_isr(int irq, void *dev)
 	irq_no = irq - pci_irq_vector(ndev->ntb.pdev, 0);
 	ndev->db_val = irq_no + 1;
 
-	if (irq_no == 0)
+	if (irq_no == EPF_IRQ_LINK) {
 		ntb_link_event(&ndev->ntb);
-	else
-		ntb_db_event(&ndev->ntb, irq_no);
+	} else if (irq_no == EPF_IRQ_RESERVED_DB) {
+		dev_warn_ratelimited(ndev->dev,
+				     "Unexpected irq_no 1 received. Treat it as DB#0.\n");
+		ntb_db_event(&ndev->ntb, 0);
+	} else {
+		ntb_db_event(&ndev->ntb, irq_no - EPF_IRQ_DB_START);
+	}
 
 	return IRQ_HANDLED;
 }
-- 
2.51.0

