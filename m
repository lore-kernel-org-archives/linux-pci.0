Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020137.outbound.protection.outlook.com [52.101.229.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C4729E0FD;
	Mon, 23 Mar 2026 03:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774235769; cv=fail; b=jAfnRAeEssQnQiBdApCaUUOlBAxP/bGOsOKeSr+UZioo8HJZ1S8h/G3rgm1H7bJapX3clA5sFzUnEKLkEDHXotLnazRATmHquGsd9WoZ56uqPBYdSWCMYmRLUzMglSEPISZy0V0hzJfH7zcKe6y2ef9JFybSNGG6p4+UZlU4wfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774235769; c=relaxed/simple;
	bh=hMCUmGm7TvHAwG74RKci5sY4s9mrKvxC9t9NWJHl5rI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FVmif82Qhg9BBWyfKF511P0TMySxdvH7UcfujrOe7G7eIII4ZEDsk3WAM74emF6vxTdLy2sqAksmT8LArfZDyvqzYvZCPIIdcQE3cW4WwwcrzYRYRHfs7fYc5uK0Rpdiwfo/j6KgKK038r+LDouKnQvUbCbPSlb8FjVnJ87KaAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=GEdnELx3; arc=fail smtp.client-ip=52.101.229.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="GEdnELx3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cpu6kMVNXrPXeO+0pxC6R6rrFgkqzFwOV5cCXc2Cag7Mwji3HcqnRox8n0pdGUHnXtvowoOlKazFrp2OTFln/nhqkh8hHIGac5LZ2bG4LNGhb//8pYaUJmMpIuMiVtnts9VOC4s8P4RC3g5wWLrHGbJX1A3wYXdnfJiUhJqWDdOcnef+eSOOiuX5UWCptPERx5AX6Lq4PEgHDTY505fHWHKx+Gwz7HZeYriGr6tiTcXsNqemguKT9foDQZS37wK6oSCWzJxw7Kfe1PhnhJQK6e2D02gQmV1PmeaAeazrOPwOQe1xdzpo6PketV6GZ5F2dQzzS01+7BL4Q6zRlsysaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OQzAPgOcT9MI38nJJGsNc+zXxs30Z6AeOqM6Q9gNdE=;
 b=xnOM2scqz1jqHseuAjz/fJKP02VzCm4cukK74M2wuWkOmcQegKFa4KO7YYHa0PCy0cRVCf3zo2xNyDGv0mcAn51aEomUQOpNGprluoayd8pxy7Wf16UMk24AVMsRGgZwfGAVlktl5peSuMqXfWu+RiLcs+ygUDO6qVqHa3q+5dzJPoNF0BPOGPrM5NASUgOjen1BTiFeTpvaXkCJYT579asKgbnGOmOnvK33zBbPOS4iyzTLRILlW7+6vrV8PmHmrfJl0WHC+DRYNtvjTwK/QtacJWmuSLqgw9ayX/yuCGxbQdAPxsN/NggfzNPasP3hObltUTYkCQ8dExTEP7KA2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OQzAPgOcT9MI38nJJGsNc+zXxs30Z6AeOqM6Q9gNdE=;
 b=GEdnELx3iUDo0QJsDlFDrf3xl/uH+UU4BsM/XXo2uu84GTddJOueORc1q/aeJr97bKMliuF80gqGqjRfhvniEzitQirzlGxpwGQmfMsj70yzLLZVpNsuT/dzLJiWUfaCa7A8CJALaRT4HVaIqdQT/GnGwQlCmfxXoGp13udhxHk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:468::22)
 by TYWP286MB2385.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:16c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 03:16:03 +0000
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71]) by OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71%3]) with mapi id 15.20.9723.022; Mon, 23 Mar 2026
 03:16:03 +0000
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
Subject: [PATCH v3 05/10] PCI: endpoint: pci-epf-vntb: Implement db_vector_count/mask for doorbells
Date: Mon, 23 Mar 2026 12:15:39 +0900
Message-ID: <20260323031544.2598111-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260323031544.2598111-1-den@valinux.co.jp>
References: <20260323031544.2598111-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0178.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::9) To OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:468::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOP286MB7730:EE_|TYWP286MB2385:EE_
X-MS-Office365-Filtering-Correlation-Id: 94aeb237-3959-42f4-e36c-08de888a83fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	y4SHyNPIX5GMPfAwCUKteHOpgzLko7XKAmRKO0BNflVEuSz+rnFKSpkmA1lykomIpPUlRCQKhj6m0WaH7wkMtahvY+an7pYooWWp5ZLHXRiEO3I6b+/IOr3yVfeDMcdG/RQNDSdUhE80s4tmrCN3s9xqeCPkYt94KPdxTOhEq5Tmxr4vUYpVUFSSMpsQl6HUFU7BVx/QrkvfYrXYur/kALsNcT7D+gggB/KxUU01EzopmmMHR497O5g6ZIynqJRd3AQhuLrxE0qKE2LqaOw4/EbukKiXIkNE6bpdA8NhUY8w4HC9QnM4XGx8x0CBmq/USsi+334zuFHAlzxuR/bpzKi39VSM9bwWqHp/2ve3eZFVStGzuEazqkQMWbBB8VyvNfLbkDNOwjfPelb+UodheHpR1wOkLF4HiUmpPnECjEb50R1iHhcwsV2OrlwcQ4nhUZU4fUSyW6C6eNYGQD5jDqPJf66hkfCSK2tezwR48EzWhfH/pphTJoRPclmKKhOkVOFvp5kCVsORvr/QX0YiPj0i9hlD9UI3InRD4elZp8VFtRHvKRMOroO9MeGupEPDxu/hLagWYwuud88GkAI/ZBoGO0EAT5LwpW+k22/qZ3RgHHfAGkghJkWRQjiz2YpIyRI6heOFHSQJI7o87xXIU81FtJASzk9nKHRid0mtKuHDuP8M7LgHEzm/W14bbnbAOApdhj3X7B5wiYhBz0kvDP/0SsBLdd3bkJXHWlxAMmW4gjMESJJTo1PoilVCJEe+9lUWp/PMvCgK5fZXbAKQAg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y1q7QpxKi4jyGzOnU6QYXhWu29k1R40y+fMEOkyITaXHhj8o8X2OtCXEOKsg?=
 =?us-ascii?Q?Uy4i5ULI+CGK8bOYuT+OGWUO8GugvWqqYPiBCUyKbOq034J05l46cDP7pe/d?=
 =?us-ascii?Q?HrFeJUXGLQZhkC8O60zN4FYldMivNXk5PTNKo6TpnuZ+Iys9G/hRYRZnbLQb?=
 =?us-ascii?Q?v2sgIE+IlBFDr1uuhIWvyp3cUzOEo1KNfcXmbY4kZLJxCve2PWFd0eYo5Wt2?=
 =?us-ascii?Q?pS6U2HsnAcGWLNr+f89gQHDhZZT/wmLXteYwDOjJe+YqJ6HPhD34Uyw2xFLw?=
 =?us-ascii?Q?EU4h1W1nyhq5UIu0gudzrFDr131ZE5dtFalnmoNxExMnx+ec/+dQ5PZEdIk5?=
 =?us-ascii?Q?E57EvJ27utHcszJ9thgLnfW+gKHPjGqUVEO0hauPm6ceRHZ/KyzChquMHn53?=
 =?us-ascii?Q?O5CiX+Xj12EaCPRC4aG/+lY2CoYmaEi0g2Xdpeh7Hp3ToRdyPUoBu1AweaCO?=
 =?us-ascii?Q?OsvY5d7aEHj5CFbklkAxYDO/QCJz5WGvQc3fk36AeyXzwWmIzMnTD84lEWGM?=
 =?us-ascii?Q?wj+JXFfuRiWuyPvWqLWRSEGq3H1MVIqNPEx6v/TbxHULszqXgVf4y1lljKTh?=
 =?us-ascii?Q?VLAk7ftz1qaVmdSaxQzHdC+9SlNFNeeHt51UZtbPVP1Vet96Jq8+FVZ4K40n?=
 =?us-ascii?Q?6UV6fRvSSIKDVBAOya/UJh+Dzh753B+eMsaqnSM+28eC6Ot/Th8mzgS48K7v?=
 =?us-ascii?Q?saABuRDFr9b602FKye73wVkmTK/4b0rhL+vaztdD1/D/GJI/3DcgpHkANw6L?=
 =?us-ascii?Q?SV59kqob+UARsh6HdSbRJkLTL7EI0wDec1IPgMFYav3+PzF3T5mhJpi9nQ3s?=
 =?us-ascii?Q?vdwgEWw7v03HD5dsTjwl+8Nn0kA7En8yXz/H02vPYr/auxamSxXM3MDQKO5R?=
 =?us-ascii?Q?ykHFBYFTohrTOqUjBnmym2xhv+4v5DLu+WdyLzrvpreiz/THe7AV3Ke2HFJ2?=
 =?us-ascii?Q?bRSCbQME4xMc0VfRi9c24l6XYVbMn8k9rZ+JiN4WCippibVUdXdt5ONYfd2U?=
 =?us-ascii?Q?gVYVj/50W7le8oiOtAhXPmnZ8By7CN4ZvgzuQI6TlNpZtwbNPtzzbFMn/aZM?=
 =?us-ascii?Q?+SbEPBXp3L6vD+0V7AtlyYr11ZzEt1oi15g1Zytsp+CgwQvD3lL8sgXkNVTx?=
 =?us-ascii?Q?VTwEsBI556GBlCvaxqHWhLTeoAJiCXhip/xvA0wkVszAKlsB9VgRRxkJqUfu?=
 =?us-ascii?Q?sC0P/P11eD7NJ+aUTZtFzvEZl+BnzxUVrRwBIEEFeYw6LQJyfO52cp6X9jWQ?=
 =?us-ascii?Q?2IzpHN3HAI2bGiCv+2L+5Ji2PE1hBaOeXFMjZbfz73JZJnMhit45PIJG9WMX?=
 =?us-ascii?Q?9wHuLsez/fy8eygbAoRQyjsdMTvLMcpsVHwTN4otCWYCsZ4nVwR9hrvcOeVe?=
 =?us-ascii?Q?E38u/crumbaEL5UCOqp+FK/uxXtuLxATEPT4Sl/8DL1OzY5S5eZoummhrrsT?=
 =?us-ascii?Q?s+SLsuo1RZyaT95SjUk5Javm9As/cuBPPtbHK5U03OLv2euw0zr6Emjlqw0Q?=
 =?us-ascii?Q?tJZJ1W22Q7D1cNowP2UiKdmHKjbcWS7mEWnuQUT/F4hVPYvaoUJ1tDJCsEWg?=
 =?us-ascii?Q?k/nYaLnX8y60Tbp9hI6Z/aoUTiQXIU0DE8F3HgzE13UXn/hzs3NR9hF2ijwV?=
 =?us-ascii?Q?HfZsrvnv1ke409EQFi6LWP0u8p5V4PqLryd4sC/P22S+VcMJ6DqLLTwkdJly?=
 =?us-ascii?Q?R1e5vfvvId9VJytXe5fkeyzFUzhxnQVrlZw0CNklMRlQwYGzbolWTZNp5Mmt?=
 =?us-ascii?Q?U1YKOmhBUhX00IjiVqAvkYACSwlcONUqi2a2xvzWGnVScz7wVLdR?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 94aeb237-3959-42f4-e36c-08de888a83fe
X-MS-Exchange-CrossTenant-AuthSource: OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 03:16:03.6046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NFVkwUM+O/h+rDjQIvOhF/FjwIy/a3XnFlI8PfEbL730ZjyhXadeDVv35MuGBzcKFo3d38jK3dc2aNXSsJyURA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2385

Implement .db_vector_count and .db_vector_mask so ntb core/clients can map
doorbell events to per-vector work and avoid the thundering-herd behavior.

pci-epf-vntb reserves two slots in db_count: slot 0 for link events and
slot 1 which is historically unused. Therefore the number of doorbell
vectors is (db_count - 2).

Report vectors as 0..N-1 and return BIT_ULL(db_vector) for the
corresponding doorbell bit. While at it, use vntb_epf_db_vector_mask()
to simplify vntb_epf_db_valid_mask().

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 36 +++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index d91033ab8e03..d83a9be1113f 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1266,12 +1266,42 @@ static int vntb_epf_peer_mw_count(struct ntb_dev *ntb)
 	return ntb_ndev(ntb)->num_mws;
 }
 
+static int vntb_epf_db_vector_count(struct ntb_dev *ntb)
+{
+	struct epf_ntb *ndev = ntb_ndev(ntb);
+
+	/*
+	 * ndev->db_count is the total number of doorbell slots exposed to
+	 * the peer, including:
+	 *   - slot #0 reserved for link events
+	 *   - slot #1 historically unused (kept for protocol compatibility)
+	 *
+	 * Report only usable per-vector doorbell interrupts.
+	 */
+	if (ndev->db_count < EPF_IRQ_DB_START)
+		return 0;
+
+	return ndev->db_count - EPF_IRQ_DB_START;
+}
+
 static u64 vntb_epf_db_valid_mask(struct ntb_dev *ntb)
 {
-	if (ntb_ndev(ntb)->db_count < EPF_IRQ_DB_START)
+	return BIT_ULL(vntb_epf_db_vector_count(ntb)) - 1;
+}
+
+static u64 vntb_epf_db_vector_mask(struct ntb_dev *ntb, int db_vector)
+{
+	int nr_vec;
+
+	/*
+	 * Doorbell vectors are numbered [0 .. nr_vec - 1], where nr_vec
+	 * excludes the two reserved slots described above.
+	 */
+	nr_vec = vntb_epf_db_vector_count(ntb);
+	if (db_vector < 0 || db_vector >= nr_vec)
 		return 0;
 
-	return BIT_ULL(ntb_ndev(ntb)->db_count - EPF_IRQ_DB_START) - 1;
+	return BIT_ULL(db_vector);
 }
 
 static int vntb_epf_db_set_mask(struct ntb_dev *ntb, u64 db_bits)
@@ -1508,6 +1538,8 @@ static const struct ntb_dev_ops vntb_epf_ops = {
 	.spad_count		= vntb_epf_spad_count,
 	.peer_mw_count		= vntb_epf_peer_mw_count,
 	.db_valid_mask		= vntb_epf_db_valid_mask,
+	.db_vector_count	= vntb_epf_db_vector_count,
+	.db_vector_mask		= vntb_epf_db_vector_mask,
 	.db_set_mask		= vntb_epf_db_set_mask,
 	.mw_set_trans		= vntb_epf_mw_set_trans,
 	.mw_clear_trans		= vntb_epf_mw_clear_trans,
-- 
2.51.0

