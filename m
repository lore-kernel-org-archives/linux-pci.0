Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020110.outbound.protection.outlook.com [52.101.228.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C847390615;
	Wed, 13 May 2026 02:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778640576; cv=fail; b=UU700Zhq7bbvRe5jHHb14GXap1OK9ZfXdyKQoxa9U1J3JDKriDgrZedfL3TBCTOZUHj/809/YKv2vOWK+qCW+v//UnkkWRVZmSBaA68dJBvyQHQAW/4QgzhTSGjE6/+HEtJeZitQOLi5Y9953XwPbI2ZOO5JiQY3VNPIO0aU8Zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778640576; c=relaxed/simple;
	bh=L3jQN2j07GKVazjjZcyq0CAP10ookS37OayAdU/YDQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H+4j++zM5ejjojb46XFS2Uu9Drq3Ts8B3SLYoh9SgN8OPohaNTM6xz+vMaeyF8sUQztt/00E9nPGn5c3duAK7pt163TjJQ2SCYfSjnW8kepqWkr3TEHC1H8qnJhkBU+3kuObSh8ZlkOAngYBcR7/+IaPJeTTr/IP3SJnybPcQZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=aBo8iWEg; arc=fail smtp.client-ip=52.101.228.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="aBo8iWEg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5hwC4WPGmYns/Z+T6iPOO2sSD1brQn2ywi3FGhrHDNoRoqQF7sBNiLRw8F19jEo2HSsSOAw8cVEJ8VNR+fX+LadTCuiQv9OEwsUrCCGv/fHcV459BkqBpgLtMsgSvuzF6dGu4k4DjPi1FiiHyBd06Q7vwmjHZP7OOTCqJSZ0Q9pEBfUYhGRERue732D8OGDnABg/0OjU0fh5knmpZsnNxlP6p8qE3iWGld4i19Yjk27bmqzzGM28XiUWI0u9YVUEanRsFjmUR0xF/h2/JuCvhqBGo+YmNuf40t62wmkHAQlL5cAR5uJ5OZ0uz3Va6RnsS+uh0MTA2yAr/2CHuP5kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5wEAfqKp+ipzvLV3mheEvZJjn+hOW+cGgltKLiiAVQY=;
 b=fYef3Y0mWpITjGRm8LhlYrD69wI066Hx1UXp8FX2k5wZaRlD0Ieuw79uDA5+AsFcpctmewYpTme0nzi88nT+Ib1OBTPKZbKQTZWnApU5yI+8HhoLnKSr1E/31I3P2CDPLNbzAQaXkuKQd6LzfP0udcdj7HDlvO6YOgf++J6iJrgjJvB/QD9W6SbyI1uoC/0x1cynIaFIpveSjFvBQfzF3ami+yw/YT5aAmCRHqAGaGsWwPSayQNc9+EiAW2aD72QL8LVRCEdYNMb+CYTZmcC1UuC0n3dNatfVpbaJlAzLQwssUkQco59brGbvBuFZG1E2cvcd1MWrXCYaKJOuvlo5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5wEAfqKp+ipzvLV3mheEvZJjn+hOW+cGgltKLiiAVQY=;
 b=aBo8iWEgzeIlPKKPiphrXlTWIxJbWX+wOGkus4uggkM96dWXf61H97mUcGlwjaSlMTVEePqkKv+Ilg1jPQTXq4h23YLVYTl3CCZAGtmOvz7fEsYsKp5h4v/7CUbEMrNHcf+onHBuxJLAMM7NCsr+bzmQQzDWfcwMbodSB5dhb/k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB5170.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:161::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 02:49:28 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9846.025; Wed, 13 May 2026
 02:49:28 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v4 02/12] PCI: endpoint: pci-epf-vntb: Defer pci_epc_raise_irq() out of atomic context
Date: Wed, 13 May 2026 11:49:13 +0900
Message-ID: <20260513024923.451765-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260513024923.451765-1-den@valinux.co.jp>
References: <20260513024923.451765-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0229.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB5170:EE_
X-MS-Office365-Filtering-Correlation-Id: acbd5524-1daa-42ea-23fb-08deb09a4086
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	SgXZMQl5iMA8Zu7pBt15aCoE2K+tc5LdaPxeQmiIq4fHJ55wb2ktNnMGjxdCFMiiLv3IP01UaGNuHyngylK+HMbggzPtF4xMMfQqh2wxj+aot0nuz+dtN7uZQn0LAtKO6lWPuFeFfLvKR0U/OywNlWzP7Cr6jJ8A4Y4r4O15c3Gad9Vi+VShupsInw/zHZ0NY8Am8aRVqQCtcS7u6dVezJj6E9adHysJFStawpVzASpSc3aewtR50O+xfRniLelg/IzFyxTLog14tKx6DBnmMfA6vcq786xEXBsc1y4TOpV9P6YkbAnKjmyzoY3cw/lE7aGg4rq51ZOtmbcccys8LCITjhgz6RAJw4iawJq/C+/Dt5npcQxs3/gM+1vI9qyg7HpzS9bTPj8egNPOJBCIj4yz0sa+oWThBjRQPRtvRBbHJ4mkFWEY16hDTme3u/czzof4XKuRGoLDIZLujlN+Tgaoq5BttGt6RjVrQ131xLD2m788raSrdLJUClzCweJ2PKLcS20nbS6xIpMMycHpNQ7GiJ8TVtW29UdVz1GNCIaGKVL8VCRdpuzWzphQjrueSUMzQ16Hfi55Uolja3WZ9d2H6XyHEws3IcngtSQ9eibB9b8uBOX25ydXCwSReBFjAZp2c7nj9Ku/igfL2W4EHazTv9JnNm3zqdpHYtEqhO7jRue/+t2dXzVkMrq1Gr21i9XJAP9qCb8lThDkxRRqGr+euCEsreLEDS7sEZ4nXCs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sArsUXbPIxceqm1skmJrEUs8JvTkWYBrAumS2Yk8jrVlBHG+q+dMNbp8A+GU?=
 =?us-ascii?Q?HCDV3enIANXhMv36zvZZZK6vRhatJsIVK/oTZFHrtz9Fjflhh3a4EZ+ZjS/K?=
 =?us-ascii?Q?851IL3IItsEhxmTstLiFbn4/7JSjKLB+Jou4Fj/gtOVFt5cwT1anQVDB+bNO?=
 =?us-ascii?Q?YvVM1E5iT/LjZi0eOCV48WxKeY3D/2yGKfMSN+P2EV3WKytsCpuYRjBKqeWo?=
 =?us-ascii?Q?JwR/oXhOTbvcjUwzbrMTwvelYAG2hqRDwV82N73xcNjrxQL3b0cJSxWMvhMf?=
 =?us-ascii?Q?6fzV1VyaZ42Jpu+ZdhnD47/C7vSI10ZkhhgLH+Vdiz2da3S1FhvPcvbxS7aS?=
 =?us-ascii?Q?m6Ve8BU5Tf8bOgbEDzql5P4lTOYLOy3ouycFfypENzXP36WRJzykLFJIsDxi?=
 =?us-ascii?Q?uHwDs5uRndUZxtjlql7Tys7nTDn/kyAOtUZqr3RynQhWdBcCilz2muo6G5EX?=
 =?us-ascii?Q?tcEklQCNrZcyqbsb8vmHzsJ9L3MUilVqsVj0/xDdNi+9YNygYEYTpjy0NoHk?=
 =?us-ascii?Q?HYQOSc8QeYfw6gnaFszIul2/N6RiDPylcSTs0YFgRqqbgeXrXy2azdXcyTI+?=
 =?us-ascii?Q?QSBWoxNC7f2SdNjgZgcqD7H/LwvtJypreglCwJ3ifGD01zdtNNr/Gf9aCWNP?=
 =?us-ascii?Q?QM7d3d38wxoPRodgLzFyClal6Z1umy+LndyCVBwiikPBVMoNqC4sOAdKcAOc?=
 =?us-ascii?Q?LSo3kg9Fdru8DeBPGnPuxRoUZ6BySz3iB5e2OIt1K/K37KansPaILTKGPK1H?=
 =?us-ascii?Q?5m+g8J3ZlZXWHMQd7PTqS/l8xboPUNt24mwPl3iAA7qYT9UtsAioJwPme/xy?=
 =?us-ascii?Q?S2JZGcvS0xn0dddb1gUmHuK9QkY70dQeU+ei1/4CvqJMKy2dWbnzGrK5Ispj?=
 =?us-ascii?Q?NsKPuReDRLDUoQ6fYc0ZEzftYw7rnm5x3LY+9IOWYNeE4Rr2cPoKhk8Hhebr?=
 =?us-ascii?Q?bcAlKuACG3URAg00r6LeMltfJ/HnGW92KkfVfgjMUcpGXvOflI4goZEo0V6N?=
 =?us-ascii?Q?fI/HqJx/5EzpbzZYAv5UbEgXScl0VbozTVqX71ucEw4holVXlRIwYcLY535F?=
 =?us-ascii?Q?g6CBIlwgZL2/2dw9NgHcKOjbgh+gVvPNwzXWsAGY7NAlq3jZaOF3CD8/TlAa?=
 =?us-ascii?Q?RxEwQqiLiimNLeGd0v6Y9+DdXJlhH5PSKSQdZZZgtLNm7wLUxGS8AtEgLJwS?=
 =?us-ascii?Q?vP6IgKaI2/G5cfE9MzYtu6UcmBhVdVbjghuI5SGMPoIUc5hJaJYRMG8GAhGS?=
 =?us-ascii?Q?ZvNNQpFfoqrAjfYBnA7mprer+abYwTj1FVJD5SrINqwBgcSoUezc/RHoC83Z?=
 =?us-ascii?Q?xPZwetbfoK1BdETC0DTSStl8WCahk8EKtySFz/XXd50cdKw2snozqsb/AiU0?=
 =?us-ascii?Q?oZ1YvFqfaol//L6V/JNq8ATWUgFBdUb5NA8hHu22nXnizU6QUU9JmQ5menUF?=
 =?us-ascii?Q?aunhDYvncJfS/qvrT7caoX42DX+uQzdZrFPlrXh55eH5vf4VNBt6Q1mRRzxw?=
 =?us-ascii?Q?09ha4vL17A2dKmHaR1vTljcy5yS5kkdjUXhIe5zGoGoLe9oXiNDhplDvs++l?=
 =?us-ascii?Q?N2syiWCq7VZdnBRc/LRRZ67a95N8W6MwQnJjHYamkgUdsG5LLAbIF6RyOzCf?=
 =?us-ascii?Q?iGvikDffeqHqoCItIiLDI0rDkI9nnU1GoOqcTpCAM3wLlMneQw+ebyyIChmt?=
 =?us-ascii?Q?HS46sMgh8fyZwbgms/jJj/Iv0hOkmv7nO8vPXqhGLOYEI6OebBFvabXEMfym?=
 =?us-ascii?Q?LbR2u6mGq2WmqxXUDqBOOA5nsV8iyn+gUCaFubwxSb/zsYlGXTx3?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: acbd5524-1daa-42ea-23fb-08deb09a4086
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 02:49:28.7965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /D7jQlYkHRWOCF1BLRqn/13uTKX3KCBWUspsGIraznSYQDdVCSwtSjfQzVLKZrUanOC1+TZuvruKJeJ/ZDPJTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB5170

The NTB .peer_db_set() callback may be invoked from atomic context.
pci-epf-vntb currently calls pci_epc_raise_irq() directly, but
pci_epc_raise_irq() may sleep (it takes epc->lock).

Avoid sleeping in atomic context by coalescing doorbell bits into an
atomic64 pending mask and raising MSIs from a work item. Limit the
amount of work per run to avoid monopolizing the workqueue under a
doorbell storm.

Clear stale pending bits before enabling the work item and after disabling
it during cleanup. Also mask requested doorbells against the currently
valid doorbell mask before queueing work, and iterate the pending u64 with
__ffs64() so high doorbell bits are handled correctly.

Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v3:
  - Clear peer_db_pending before enabling and after disabling the work item.
  - Mask peer_db_set() requests with db_valid_mask before queueing work.
  - Replace ffs() iteration with u64-safe __ffs64() iteration.
  - Not pick Frank's Reviewed-by tag for v3 02/10 due to the added behavior.

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 112 +++++++++++++-----
 1 file changed, 85 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 668d25abc7f2..cc0b356973f3 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -37,6 +37,7 @@
  */
 
 #include <linux/atomic.h>
+#include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -69,6 +70,9 @@ static struct workqueue_struct *kpcintb_workqueue;
 #define MAX_DB_COUNT			32
 #define MAX_MW				4
 
+/* Limit per-work execution to avoid monopolizing kworker on doorbell storms. */
+#define VNTB_PEER_DB_WORK_BUDGET	5
+
 enum epf_ntb_bar {
 	BAR_CONFIG,
 	BAR_DB,
@@ -129,6 +133,8 @@ struct epf_ntb {
 	u32 spad_count;
 	u64 mws_size[MAX_MW];
 	atomic64_t db;
+	atomic64_t peer_db_pending;
+	struct work_struct peer_db_work;
 	u32 vbus_number;
 	u16 vntb_pid;
 	u16 vntb_vid;
@@ -972,6 +978,9 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
 	INIT_DELAYED_WORK(&ntb->cmd_handler, epf_ntb_cmd_handler);
 	queue_work(kpcintb_workqueue, &ntb->cmd_handler.work);
 
+	atomic64_set(&ntb->peer_db_pending, 0);
+	enable_work(&ntb->peer_db_work);
+
 	return 0;
 
 err_write_header:
@@ -995,6 +1004,8 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
 static void epf_ntb_epc_cleanup(struct epf_ntb *ntb)
 {
 	disable_delayed_work_sync(&ntb->cmd_handler);
+	disable_work_sync(&ntb->peer_db_work);
+	atomic64_set(&ntb->peer_db_pending, 0);
 	epf_ntb_mw_bar_clear(ntb, ntb->num_mws);
 	epf_ntb_db_bar_clear(ntb);
 	epf_ntb_config_sspad_bar_clear(ntb);
@@ -1409,41 +1420,84 @@ static int vntb_epf_peer_spad_write(struct ntb_dev *ndev, int pidx, int idx, u32
 	return 0;
 }
 
+static void vntb_epf_peer_db_work(struct work_struct *work)
+{
+	struct epf_ntb *ntb = container_of(work, struct epf_ntb, peer_db_work);
+	struct pci_epf *epf = ntb->epf;
+	unsigned int budget = VNTB_PEER_DB_WORK_BUDGET;
+	u8 func_no, vfunc_no;
+	unsigned int db_bit;
+	u32 interrupt_num;
+	u64 db_bits;
+	int ret;
+
+	if (!epf || !epf->epc)
+		return;
+
+	func_no = epf->func_no;
+	vfunc_no = epf->vfunc_no;
+
+	/*
+	 * Drain doorbells from peer_db_pending in snapshots (atomic64_xchg()).
+	 * Limit the number of snapshots handled per run so we don't monopolize
+	 * the workqueue under a doorbell storm.
+	 */
+	while (budget--) {
+		db_bits = atomic64_xchg(&ntb->peer_db_pending, 0);
+		if (!db_bits)
+			return;
+
+		while (db_bits) {
+			/*
+			 * pci_epc_raise_irq() for MSI expects a 1-based
+			 * interrupt number. db_bit is zero-based, so add 3 to
+			 * preserve the historical slot offset.
+			 *
+			 * Legacy mapping (kept for compatibility):
+			 *
+			 *   MSI #1 : link event (reserved)
+			 *   MSI #2 : unused (historical offset)
+			 *   MSI #3 : doorbell bit 0 (DB#0)
+			 *   MSI #4 : doorbell bit 1 (DB#1)
+			 *   ...
+			 *
+			 * Do not change this mapping to avoid breaking
+			 * interoperability with older peers.
+			 */
+			db_bit = __ffs64(db_bits);
+			interrupt_num = db_bit + 3;
+			db_bits &= ~BIT_ULL(db_bit);
+
+			ret = pci_epc_raise_irq(epf->epc, func_no, vfunc_no,
+						PCI_IRQ_MSI, interrupt_num);
+			if (ret)
+				dev_err(&ntb->ntb.dev,
+					"Failed to raise IRQ for interrupt_num %u: %d\n",
+					interrupt_num, ret);
+		}
+	}
+
+	if (atomic64_read(&ntb->peer_db_pending))
+		queue_work(kpcintb_workqueue, &ntb->peer_db_work);
+}
+
 static int vntb_epf_peer_db_set(struct ntb_dev *ndev, u64 db_bits)
 {
-	u32 interrupt_num = ffs(db_bits) + 1;
 	struct epf_ntb *ntb = ntb_ndev(ndev);
-	u8 func_no, vfunc_no;
-	int ret;
 
-	func_no = ntb->epf->func_no;
-	vfunc_no = ntb->epf->vfunc_no;
+	db_bits &= vntb_epf_db_valid_mask(ndev);
+	if (!db_bits)
+		return 0;
 
 	/*
-	 * pci_epc_raise_irq() for MSI expects a 1-based interrupt number.
-	 * ffs() returns a 1-based index (bit 0 -> 1). interrupt_num has already
-	 * been computed as ffs(db_bits) + 1 above. Adding one more +1 when
-	 * calling pci_epc_raise_irq() therefore results in:
-	 *
-	 *   doorbell bit 0 -> MSI #3
-	 *
-	 * Legacy mapping (kept for compatibility):
-	 *
-	 *   MSI #1 : link event (reserved)
-	 *   MSI #2 : unused (historical offset)
-	 *   MSI #3 : doorbell bit 0 (DB#0)
-	 *   MSI #4 : doorbell bit 1 (DB#1)
-	 *   ...
-	 *
-	 * Do not change this mapping to avoid breaking interoperability with
-	 * older peers.
+	 * .peer_db_set() may be called from atomic context. pci_epc_raise_irq()
+	 * can sleep (it takes epc->lock), so defer MSI raising to process
+	 * context. Doorbell requests are coalesced in peer_db_pending.
 	 */
-	ret = pci_epc_raise_irq(ntb->epf->epc, func_no, vfunc_no,
-				PCI_IRQ_MSI, interrupt_num + 1);
-	if (ret)
-		dev_err(&ntb->ntb.dev, "Failed to raise IRQ\n");
+	atomic64_or(db_bits, &ntb->peer_db_pending);
+	queue_work(kpcintb_workqueue, &ntb->peer_db_work);
 
-	return ret;
+	return 0;
 }
 
 static u64 vntb_epf_db_read(struct ntb_dev *ndev)
@@ -1690,6 +1744,10 @@ static int epf_ntb_probe(struct pci_epf *epf,
 	ntb->epf = epf;
 	ntb->vbus_number = 0xff;
 
+	INIT_WORK(&ntb->peer_db_work, vntb_epf_peer_db_work);
+	disable_work(&ntb->peer_db_work);
+	atomic64_set(&ntb->peer_db_pending, 0);
+
 	/* Initially, no bar is assigned */
 	for (i = 0; i < VNTB_BAR_NUM; i++)
 		ntb->epf_ntb_bar[i] = NO_BAR;
-- 
2.51.0

