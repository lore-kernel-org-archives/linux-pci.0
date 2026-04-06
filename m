Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020111.outbound.protection.outlook.com [52.101.229.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B97338936;
	Mon,  6 Apr 2026 15:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775491057; cv=fail; b=BXNTQSXsYtFwFMN/UegCcgy4TdhW2KVLrJpDpHJbBrQ3x5HMMoEXEtLIR7koEGnmzaNK4uvnkFnXihssOBkVeHZG23+qNEDzZaxBECo3QvDYBriGUQ127bqkQalNnS8J5iOZMUHbhU/kgzK7kcNUDdPnBKDRBQz/w2vJgOrBzSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775491057; c=relaxed/simple;
	bh=dlVnbhX8PxGnedfMNDpDYZosmRi6VsKB2pbJC0JUfqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sjZHB+tIrbkpTEmSLbi728BfZ3a463bqthCy8LRp7L2XN12nmPtvTLsPJPtKKNurlx1FlEDB2UzgG1KZFUuh4OoTPiDUtZkK0mlNJ/9FjlP1PBO3Oi6ZG2np9F35ckw0v6wEKQrNbQY7voMgBKPAln5lXjELKOj8mLF8jZhFIeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=HMb1IXKb; arc=fail smtp.client-ip=52.101.229.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="HMb1IXKb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zVVunOv4DnKJD9rrdsUBMoDuEb2aQGmMJ7dgOeQLEeRVDeUkhytSJIfTE5c8BLlVQGPQkeokzP/QmaHEhWcIHCjpFJxrIlkcV6nlh5HY7vE0YmzdG+1nUwpcBcwAMh9hHU+FrM45rXpmhUkQMqrE5JLRtuf9fT1oByS+ZJgypxmBFXM1xLML+7/Os6NbCLCnY5AhZdG293UKUYAW/KyoQ2yNaElCdSVMLYkZLcGmp+9vvWOCUqOzxfZHvBBqXID6Q0cynHbt7WyMiaGAMw9eRetpFnvOJNxtAAcbjVT+2OBMRiAGDww7SWaAtZkm43RtlPuoH7ovqRvMpP7WSNDk2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zdv0PXxOcHbw+RGn7yNzlRw8lKljXPhJ7YMgz3q8sHU=;
 b=LxdKXVkjNaDXlsEjrc5rABLjGsNghB9Wy7GRxLn/r+KnAP/VA67eL1ZzBddq7sDWh3u0WX5g/rx/HXCGowbNjkLiyxjavo75pHoPwLZsVT97N5vW9RYeLGG2kyQdfT2MLPl9oSHfMFofgfPgiFu8U4zn9Wm1v6eGDLE0mfCSnqlGUbSPAlDF7AY6yq8u1f2eHjCRqsXBq3/BdI6we6r+NJS7I4UcO7Fv/m/HgyY2WeF7/rH7kA/A9ORrSDlidUtPvYR+PeFi6/bf6kDK7SbMZEUrJDQnhP2NumKSOs+snvo2aWBZv3yD7vdxd2132HJN2JCdsIvAuLrrnmi9wDt2Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zdv0PXxOcHbw+RGn7yNzlRw8lKljXPhJ7YMgz3q8sHU=;
 b=HMb1IXKbKGPfYZfc8uyskIp0iD1l8avGItwwXlvT2UYuSHDR9CnAevjRdwUWcxOKl962umS5A72l/mQKjIxMnYM73f4SjrtNq+JR57i/7Tx03iY8wmZ3VK12aso/2wGgo3XI1iBGkXyAEV9X4UrX4eL3ON9F0Nb1rqPA7NC/ulo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB4187.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:10b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 15:57:26 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 15:57:26 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v13 6/7] PCI: endpoint: pci-epf-test: Reuse pre-exposed doorbell targets
Date: Tue,  7 Apr 2026 00:57:16 +0900
Message-ID: <20260406155717.880246-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260406155717.880246-1-den@valinux.co.jp>
References: <20260406155717.880246-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0065.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:371::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB4187:EE_
X-MS-Office365-Filtering-Correlation-Id: f085b6c2-a810-4804-87df-08de93f53305
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|7416014|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	/aZnCGKYWg9w7+S8iQmeywok2+ONGH5jC1+MavrD/w33SLy99+nss9yUDnjcX8bNoVOW95L11UxXLf19A7tLnoUkVNv0LYJvjX5mPUcJlqWmBJoKHTR6j8jsnZ1Bf+bveplRZf6lIgdZAJZkhHLoxmLF8AlTXY+WreRk+QdYUB3Q4CL6+lUZ12X3XA1QjSDdhWzlhyKWli7PvqW/BYoZWdB5WrMReX/JnD8mUAo6BR1p+rP//FQbciCkgbo+E6VOmMToLZQkMIMaAFo7SfI8UZpbzNHCClCLSIFOETbENE48cKDm+qA/Quhp2tA1CV5/m+IK1toMnC/6I4zCGtNonXRbYYThpFOt6xuwCsKCFs4UlfGhqtqyOmCgEqWe7sX4ZucNDPba72dpJKA93+i9HaiwePqjgPAtyF/EIEoQhJzzlUq1jD/ZSN2klaV/k9Mw1ma32wZ9v1nTiDbRXNLznXnnVOFMvyekHClJ3HCPt9rZterlX7zPV2rmAWsi8XA9hLqpbQ/fVFDqxarF0bf1LqzIckrmDZYyh/FcfL/B1+ozsy8l5MyHPQpVPRT3IG9Q7UtHft8Sy4kJjXgH4dTkD7i+J7HCYSaNq0V3XM/B5OiDNFbirrURj8AOwo6OfOyNUtsGZKhos4zTGJ3hbFKJR/GzclKGZs5eGIfkZi2GLdTlXf2PJLSAtLHGFWze4iGa2MY8G++XkqEtjIBD0oW7W9dLmZdbwGtl0iPXe2vCg0nGuyM6A5MpeIBZ4zidz5NDxCVjmX0FLaD15QbOSvKUvw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(7416014)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xMVTisX8nHFtptXKwASx+3b6fOMgL8aeMZ6egPmd5nEKkAXZBdMnQmF3FrKj?=
 =?us-ascii?Q?TcxNnt5sQJZX2xUBk7zuUs45Fv4tJq64IY4Zt5Cb9XsROZu05Cewudr5/EBv?=
 =?us-ascii?Q?y3N7Qrazbe+uTdTqpaprgguhBvsHgoWd5zRqGOGgFRpnka8nMyN1Wbei89ZE?=
 =?us-ascii?Q?E0TratiniUKgFKJEEQZKh6q0twTdZsWBuLjVUSaBXse66rTXQ9qGM6WjvkL+?=
 =?us-ascii?Q?Haj9YTwdK7g6YAGRtb0g4mLEcP6baIeZnf0jzVRvYoygQ9oF6fx4ZcOw0tdc?=
 =?us-ascii?Q?9soFmwF/yveOrGTpAkyjVTUjXDDPP2qINJTTSARDZdf3rGrNyDEpkzzBEINk?=
 =?us-ascii?Q?MlBQtALV2dMkI4453ICEgLHnI6aS6bi1rATRIDUF5BeVUkEt+gORdtNhwSd3?=
 =?us-ascii?Q?uFsEGVJS6kPbN7jJ3Xr45ZRFohyWLdmoMGVwIDJkIEVqTliQLfkE7CN0VDTc?=
 =?us-ascii?Q?Y1ydjiLiZu6QJpqPog/+p27vp4ASLMJ9G466YHEp9BZDohuiLsq1PbQncOzj?=
 =?us-ascii?Q?aObV85KUG8AFUiKZPI0OypDwd5kkI/bWtvJau7NAebsOosw6ArpgsmFypDPd?=
 =?us-ascii?Q?6gv/nVfd9p5y1SDUBceT1KIPgAjHLshxplyRaovG8402siOzGkJ78+35RC7e?=
 =?us-ascii?Q?dbHICL283LcMnEHcU2XHEU7nkg7GTMe8SDfEWBT0p57CeshnkThqbqsucnFJ?=
 =?us-ascii?Q?rQoPtT9xzdut5kXSG4QFZrBhoqS68XJIN7S1B4DpOGlidzZbMBC4XxvQLuPW?=
 =?us-ascii?Q?6a//s2zj2un4w7uzCNsDMqk3bP9CtcArkB2wod6q2tttuVJMc63eomFCSxkX?=
 =?us-ascii?Q?VGLnEYkPLSY1opymKz4vtB5i99A3gEUCZDCunlLx9Yj4fmF0nYASKjDawQm0?=
 =?us-ascii?Q?SQOBWGWfTcPLiCqjJi2X07pQZC/hD+qKu4VBSbVZ16Psq9QXSsJ8hs9MgCuK?=
 =?us-ascii?Q?NHb76dxEDQkMDp2/GQ9w1OB7eD6WA5g9yA1vU8zrJFwTiRanqpiyst1ohVhT?=
 =?us-ascii?Q?+r7V5wNmxQq7oPIT52IHxt+Q6mIp2vcDyJvjM4Dd7mU7efXfk/a6otYZ2hSg?=
 =?us-ascii?Q?WfMuwis0fL9b1JhLqZMKeli8d/C5ItKFW1osMw+7SrWORg2LFtqUfpNPbkng?=
 =?us-ascii?Q?sPKDIZ3DxtaW+6So8ZqrycPwOhpDoKOTmLRDrG5sJw76chJD00tEXtwhBF//?=
 =?us-ascii?Q?g7t4qcwYn3OFl6C4/9t/Gt4lNZxR1j271DF+vnNhi2SGq0SOh2TzYlgxAeEt?=
 =?us-ascii?Q?FvCwEN5vcw6VYH7DmADYe8xIgpqdIVQUcs1EJcYQ4INsdmGSQ6MbRPKhGZlI?=
 =?us-ascii?Q?/Brw4XAq8uNPytzni8tG8HyonWLvJ3Ki/p8SXSeNSjxG6nV9P4Fu5UzEmasq?=
 =?us-ascii?Q?8d6dIJ8FShAnv3dfYiT9P5616kn6jeOgsShEKuruR4YPBXknCV7hoc0/28z7?=
 =?us-ascii?Q?rHxV1QT578fCtQ3Tc1FtiUKABKmb/x1GRYrRgpYUd7zjp83AZFbmyss28wwq?=
 =?us-ascii?Q?eq31TtdOihWt4stoG+mL+KvyO03SZgN3SBEr+F73IzlKsS3vhZznMzL9Mv59?=
 =?us-ascii?Q?VXfXMaO38/2EpjBXw9R8A2uIci7M2AnJZMHyWyuwsebUNs1t5SgbB9UFD5A8?=
 =?us-ascii?Q?JBQw6MFy01v0X/cWgxL5zExzxmd37H6G2hg/3fS3osfyYfGUDVVIKdKTSFtN?=
 =?us-ascii?Q?nagUva//s8T+cWaP347vyII8ZOhaV1Gnfs4PquaXBUcQgNjj1FLP7wyUjx9M?=
 =?us-ascii?Q?s9e1G6oyu99scw1WEP8rzlQjfH1J46aIQoDY05JJp0eWI9RRIaCs?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f085b6c2-a810-4804-87df-08de93f53305
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 15:57:26.6015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wuV8HGyY1Qe56hM8/FjLKAaeHkIFGZ0iQWu3FUWope27fVBzxDBt1AOFWXV25wXV8NqIGtV2rKzh1ZGU5cIyTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4187

pci-epf-test advertises the doorbell target to the RC as a BAR number
and an offset, and the RC rings the doorbell with a single DWORD MMIO
write.

Some doorbell backends may report that the doorbell target is already
exposed via a platform-owned fixed BAR (db_msg[0].bar/offset). In that
case, reuse the pre-exposed window and do not reprogram the BAR with
pci_epc_set_bar().

Also honor db_msg[0].irq_flags when requesting the doorbell IRQ, and
only restore the original BAR mapping on disable if pci-epf-test
programmed it.

Tested-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 84 +++++++++++++------
 1 file changed, 57 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 14e61ebe1f11..b6c865b0883d 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -93,6 +93,7 @@ struct pci_epf_test {
 	bool			dma_private;
 	const struct pci_epc_features *epc_features;
 	struct pci_epf_bar	db_bar;
+	bool			db_bar_programmed;
 	size_t			bar_size[PCI_STD_NUM_BARS];
 };
 
@@ -732,7 +733,9 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
 {
 	u32 status = le32_to_cpu(reg->status);
 	struct pci_epf *epf = epf_test->epf;
+	struct pci_epf_doorbell_msg *db;
 	struct pci_epc *epc = epf->epc;
+	unsigned long irq_flags;
 	struct msi_msg *msg;
 	enum pci_barno bar;
 	size_t offset;
@@ -742,13 +745,28 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
 	if (ret)
 		goto set_status_err;
 
-	msg = &epf->db_msg[0].msg;
-	bar = pci_epc_get_next_free_bar(epf_test->epc_features, epf_test->test_reg_bar + 1);
-	if (bar < BAR_0)
-		goto err_doorbell_cleanup;
+	db = &epf->db_msg[0];
+	msg = &db->msg;
+	epf_test->db_bar_programmed = false;
+
+	if (db->bar != NO_BAR) {
+		/*
+		 * The doorbell target is already exposed via a platform-owned
+		 * fixed BAR
+		 */
+		bar = db->bar;
+		offset = db->offset;
+	} else {
+		bar = pci_epc_get_next_free_bar(epf_test->epc_features,
+						epf_test->test_reg_bar + 1);
+		if (bar < BAR_0)
+			goto err_doorbell_cleanup;
+	}
+
+	irq_flags = epf->db_msg[0].irq_flags | IRQF_ONESHOT;
 
 	ret = request_threaded_irq(epf->db_msg[0].virq, NULL,
-				   pci_epf_test_doorbell_handler, IRQF_ONESHOT,
+				   pci_epf_test_doorbell_handler, irq_flags,
 				   "pci-ep-test-doorbell", epf_test);
 	if (ret) {
 		dev_err(&epf->dev,
@@ -760,22 +778,30 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
 	reg->doorbell_data = cpu_to_le32(msg->data);
 	reg->doorbell_bar = cpu_to_le32(bar);
 
-	msg = &epf->db_msg[0].msg;
-	ret = pci_epf_align_inbound_addr(epf, bar, ((u64)msg->address_hi << 32) | msg->address_lo,
-					 &epf_test->db_bar.phys_addr, &offset);
+	if (db->bar == NO_BAR) {
+		ret = pci_epf_align_inbound_addr(epf, bar,
+						 ((u64)msg->address_hi << 32) |
+						 msg->address_lo,
+						 &epf_test->db_bar.phys_addr,
+						 &offset);
 
-	if (ret)
-		goto err_free_irq;
+		if (ret)
+			goto err_free_irq;
+	}
 
 	reg->doorbell_offset = cpu_to_le32(offset);
 
-	epf_test->db_bar.barno = bar;
-	epf_test->db_bar.size = epf->bar[bar].size;
-	epf_test->db_bar.flags = epf->bar[bar].flags;
+	if (db->bar == NO_BAR) {
+		epf_test->db_bar.barno = bar;
+		epf_test->db_bar.size = epf->bar[bar].size;
+		epf_test->db_bar.flags = epf->bar[bar].flags;
 
-	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf_test->db_bar);
-	if (ret)
-		goto err_free_irq;
+		ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf_test->db_bar);
+		if (ret)
+			goto err_free_irq;
+
+		epf_test->db_bar_programmed = true;
+	}
 
 	status |= STATUS_DOORBELL_ENABLE_SUCCESS;
 	reg->status = cpu_to_le32(status);
@@ -805,17 +831,21 @@ static void pci_epf_test_disable_doorbell(struct pci_epf_test *epf_test,
 	free_irq(epf->db_msg[0].virq, epf_test);
 	pci_epf_test_doorbell_cleanup(epf_test);
 
-	/*
-	 * The doorbell feature temporarily overrides the inbound translation
-	 * to point to the address stored in epf_test->db_bar.phys_addr, i.e.,
-	 * it calls set_bar() twice without ever calling clear_bar(), as
-	 * calling clear_bar() would clear the BAR's PCI address assigned by
-	 * the host. Thus, when disabling the doorbell, restore the inbound
-	 * translation to point to the memory allocated for the BAR.
-	 */
-	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf->bar[bar]);
-	if (ret)
-		goto set_status_err;
+	if (epf_test->db_bar_programmed) {
+		/*
+		 * The doorbell feature temporarily overrides the inbound translation
+		 * to point to the address stored in epf_test->db_bar.phys_addr, i.e.,
+		 * it calls set_bar() twice without ever calling clear_bar(), as
+		 * calling clear_bar() would clear the BAR's PCI address assigned by
+		 * the host. Thus, when disabling the doorbell, restore the inbound
+		 * translation to point to the memory allocated for the BAR.
+		 */
+		ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf->bar[bar]);
+		if (ret)
+			goto set_status_err;
+
+		epf_test->db_bar_programmed = false;
+	}
 
 	status |= STATUS_DOORBELL_DISABLE_SUCCESS;
 	reg->status = cpu_to_le32(status);
-- 
2.51.0

