Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020092.outbound.protection.outlook.com [52.101.229.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E016D29BDB1;
	Tue, 24 Feb 2026 13:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771940111; cv=fail; b=F/fOrOG/o6jhvO7EECMlMi32CacBHY66kD1fBoiyBeScZa1CjblKSNtiU7dOfZGOdsif7FZhRVrEuIWoRH40K07cysirmt1J/CKcVufXuEE7RTz67zgfVhuKHvj3Au9A+H4sZtqQn7IsAeyF0pYBJCh0Ue3ZL382vuwiJFOHU6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771940111; c=relaxed/simple;
	bh=I9Z/8ss2CU50VfLHeGBbu+/SCobLx9deMBue+IFAq9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uKM9L/cRTEJzJrPxPuR6GoXlckQ+vE1GS3yhbpHUqjxq15SHQXJUBEK7uSfblhU3nQXfQcPiU09EyBc5F/9LhiyA9elSQe+YSN2HLIDpJr4P5ckhWwgagj33hreQ7mDe4Dz4ku8lzCc1HuUfr03VWsbtoO9R7zoLm9hXgo2LTFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=G3fpCH9W; arc=fail smtp.client-ip=52.101.229.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="G3fpCH9W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H9JFwb2rk+y9VHFeqAluQlp2bCyRNoeLTtXXdca8DRbIGaBCh9/elTemmByef8o3Qt91L3jQOkE45H3Jq9o7QNaTzdKzQ5yQ3oXR6OY4LeuPMYpCRFImx4GfVBRprG2E5IWd/TXTVjtkhnILn6aJQdgyrcFNZpRN0TW7+KT7ipOxSF/agLEvTeUOHq6qKbur/wTavg5IG1Jql4EFOyX8kDXNqWRx6JHqWzu5GjyRr5fl1HBtNBJmRnE1GIss+4YKfxK85u9+Dd87fgOYFrgB4JrIktg13PQ7fUizvT+pZKGtCMoSHqB9oUgJgJ9fDpoJDy1cVJoOzXQkMpZpQtgqaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk+/EUdqC4zmnwR0mMYN/EubQjxILcaL3wNAsHr1vbg=;
 b=UfYNGJG23RSDdkcwU6ODs/OeRVkBs6URLXNZlEVYBNHyGsbHDDuJgdxJY+jyvnNJcHvFDpYFkMwQBX34WCQrhXt9eHZ82UbjRYqAmv4q/q34qfXU2arUS9Lh+cZX7iAs9A3Y1pTNyK5U5akJq1idi7OXqHlJRZD+mxEGDGohzJGZwJLqbPTjrnR6vBOsDq5JIPGpt0HrTTwFLALW43b6HVjV5ATC+6gxfpu7O4faBZbL7urLqsEwH2bo0V9gqR2VtQX38DhDITH1w2U2eyiap58wqFynnMjaa+J6IUGpuah+kaLL/kULAv5p7t2Y6c+LdTDUfK8lAnRKKLfBptzjiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk+/EUdqC4zmnwR0mMYN/EubQjxILcaL3wNAsHr1vbg=;
 b=G3fpCH9W45LsEu9nSrxfena/2osSqDjE++iEjYlLGd3c3KgQvVS64jg9zZEvBYDaKm73YMQcpirEcuWmZBZoe7LlU80mGtYY46unrO4uALwf1Ojw7YozYoXj9Y2v/ugZwiUzbrnEidBv3c/claOkmvSoB6D+mcV3b4wjQhRBV9M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB6278.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:410::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 13:35:07 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 13:35:07 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank.Li@nxp.com,
	kishon@kernel.org,
	jdmason@kudzu.us,
	mani@kernel.org,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	jbrunet@baylibre.com,
	lpieralisi@kernel.org
Cc: linux-pci@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] PCI: endpoint: pci-epf-vntb: Implement db_vector_count/mask for doorbells
Date: Tue, 24 Feb 2026 22:34:54 +0900
Message-ID: <20260224133459.1741537-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260224133459.1741537-1-den@valinux.co.jp>
References: <20260224133459.1741537-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0075.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: 24a3de3f-2d4c-4642-97d0-08de73a98646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZFnfTRMUfzeJ7jHrwTSdA+664WF2iwI/xucSlTr51Gt9FOiLVg/rlFNZqFsB?=
 =?us-ascii?Q?ls/KgxaB5WkuRe93b94xIC1vWUcVdOD/ifoSKHjMUtXEkcTa0m9NnKMMPrx7?=
 =?us-ascii?Q?8PGAAXeFMBVwzW0k7MVGRGoCF9mHfOxEH4XitnEYahRp06cFfZVWbMD5urLt?=
 =?us-ascii?Q?8aRBVps/ofzKtdRT9W4rkyGYFye9dn4a2SCyUdPnEW4qzlWvEDOCVWih2QYU?=
 =?us-ascii?Q?isoaflWGbXTHwqhNYBke16wqHgnM1FD1hU/RxxXDjYu0+91Z4bAcqFvXcrC7?=
 =?us-ascii?Q?OCLzE1Mkvo10bc9XFTnzvufxWTIF5nnWYid2o1aOrnniLihDrzTnA0j2TW/m?=
 =?us-ascii?Q?lKxZiKexcilWHX74jlPuSFeTRttPZ2zDHPrCUD52M7ebQ+o8vkUMveB/S93j?=
 =?us-ascii?Q?I8Z0mAh8YjNewfJGkwdMDrgX6ga1CZoENPvd9nEuirXG/VEMMUS/UZIYqjUq?=
 =?us-ascii?Q?1gc6UuO1jjRLPpIr01KCdkLkdzOcmOv+f0N1NqROgnH5WtdfU+u4Pjvxvfyl?=
 =?us-ascii?Q?hmc7bzHbHbh9fhLMSG2FesDxygMy1Rz7HDwax5P9fR93N/s4UvvSXt6FAK3V?=
 =?us-ascii?Q?QZOiBXDphX89lrZTDgActSiFPuYlh0PpPCJONp2DyxbRCZn4VYd0T53GUvp7?=
 =?us-ascii?Q?F8R8KZn5Qow6JqLu6whNwWQLufJxlAKYFkcOuNc0uk7mrFZ8lO4kXO63NadO?=
 =?us-ascii?Q?hIQaE57oAQJL40ry3HWNNrTIRlOsHvY6//kTtU08hzMAULYSSgriYS2/w4V5?=
 =?us-ascii?Q?R806Tn0yxbbt8qJJfPZ8pCN87bFkFqGNBaQ88PnEHXuCI3P7OoY7QwutYBtf?=
 =?us-ascii?Q?qoMVEtucA3cN3ufPc5GpmSk+/Np9HbbgfPjyA/T+cXqsxEK3jT+SXd+nxDWT?=
 =?us-ascii?Q?Z5ii+7WrXn3RFP750wwS6h32i5Mrx5xS9ucHLL1mjza1zyDhcbRNH3rrSr8M?=
 =?us-ascii?Q?LROJo9FcIuDpaQ/lxWqqG2tu5BNzGEOMz8nOm/bXG+H6g4PIUhrtrLrLc/z5?=
 =?us-ascii?Q?IiUu/QsdFpYjGDz0P7+17iBJWOQaL7CZDBFvzriAvsz+xlXmSyyLzIy9g2Do?=
 =?us-ascii?Q?w4/+SEFbGz6ENdfMnL05YecPhydUQxW+n9bvDtBDZamdyAW7DXfnaKg8FT9s?=
 =?us-ascii?Q?0MW4hj8sAVDAt0UpY21oec1SQBzsTemLZCXUSXyaRmM6XBP+pC5cxUAYtpg2?=
 =?us-ascii?Q?Ab7GQa/oQSNFgchHPhaPtKbxSqhjzaM4lFyTtBDpzrfQNZxpccr5zNNH8JXa?=
 =?us-ascii?Q?LMN89TbDrU9PWUwtyFjpKaAgFGFJnPbrG9lBV1DR0HIq7YWIwFnwfS75xRyM?=
 =?us-ascii?Q?TA6hU1T+eDhsIJ46LCqflw78aAGJBmjzYOLNqVMikH28ojCdwmjf8kWhE1Az?=
 =?us-ascii?Q?xMi3c4meK3MqrSYZ25E5NCQmtQnOuaAtbtRmv7n8jEylmhDlBzkfWKoA80z1?=
 =?us-ascii?Q?5G00XFMGiR7rRbAzOU1lr9YCnEEx566TP//gz6SfLmuWMUhJbU9dpIbwEhd3?=
 =?us-ascii?Q?jBsMrQtOvhJOBeZDLDJ8aT0veaei4XPA0QKBUFq8cZD8gCEngLPalm7Fi8kE?=
 =?us-ascii?Q?4f7WPvGKCUCQNU9m8O9no0c3xM2LRivEd7TREuI/k9rkaDhM725Usn89smtt?=
 =?us-ascii?Q?4w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sA3XFpGolefcXPVJYPju4Lj3ntcU3vV5JHx7wR5hV/sZy+dxHTFLgiW4uAQI?=
 =?us-ascii?Q?5XHVzCE4bp8DRPggopy4eNnw+oKWKPHNjhcmLXPUh0OK229UjeKDu8xtZdG8?=
 =?us-ascii?Q?N6oARElQ6Ts5a4+sv4bRP//affihJXOXFimtCWlX+VsF2ijqlzGqsY13Tevd?=
 =?us-ascii?Q?ytOCqoo6aTF8jsLs3kFSZE477PnWajO4/fQL/RR42KNhe3CKm1F31CmNe9X/?=
 =?us-ascii?Q?d2iTQ7nqpE6SHS/Xu4TRpsbDbD2e99ZzecHIVSGi91P/5iJMpK2AG3RPdrQn?=
 =?us-ascii?Q?hCkpxtClC8cW//Mv2UmHhWzrYyUSfRKgyuyIBUYezGfz6gkDciF7GxePzWwC?=
 =?us-ascii?Q?GFpb5k2fVHTokp1fNN4eFUJBve0GXUtlBm0qtNOWT+EP2SbGxo23RlgSMRL5?=
 =?us-ascii?Q?SOkWezLLTRQoJ+LT/D/445oD57GjBb7VxucLhS/XlExTUusxfEN6LYc5lvs8?=
 =?us-ascii?Q?54n+hL1DlexNIa26uSUoaPcqfkdGmG31Lbf2byRkNbPodO+GZEwrEjQXZlDV?=
 =?us-ascii?Q?x+4XVY9BPysPN50qugOjkiRaH2TAz3WmXxW4opnsh0mzTByuFWv+4AqFqynD?=
 =?us-ascii?Q?BGRUqhAkhdVmu8yg/nw4tAHqIP1Ztq9XwnmKdBnDHTb/c0peIpoQhjaQE9gz?=
 =?us-ascii?Q?p+1lq77Tauu/yx9AGszQNJFLhytYmek6bFyRH05J8H25CFP2PntHHSO5RLJT?=
 =?us-ascii?Q?mRcs8+fhrohjQjjrxdwHpw6xaNUo8YdR1t5D8hDyXfx20c8ky7n1ur3B72Mo?=
 =?us-ascii?Q?PYriEkADwNyp8BmKZwIXJvXunGjPJqSd97Ywyk83D2mPMtchgJppVjuLZbBZ?=
 =?us-ascii?Q?x2QrDx+8zN765HPj2JudmNOu+GMWkh/2iTFaY8s/UpNXB1cUyPIoK8kUBTEz?=
 =?us-ascii?Q?7zMLHNsK2My44hR2Do9zZl/n0ci8fxHFc37uOvlV9zpkqDPsG+DE3lgj4qXD?=
 =?us-ascii?Q?NCADkjqzkZIP0xGN1o9GV79EQEy2ujy+DqHcbR7IZVckxlbsTbOqMJFo9Vzf?=
 =?us-ascii?Q?Wryn36oMDUnAedaZuX2wMPAItY03fxS1gjTIiVFfl6vW5N0Qht+zm4YOq0rQ?=
 =?us-ascii?Q?YZTBi8wcFDZw/MrCuV/wLGVho1vP+LTy0Ra2YIpe9mJcd8QfVL7czfurP9kZ?=
 =?us-ascii?Q?/uYquli5nxmB1uR+b4U6dMxDmoLpHCZN1iEKH5xROsrkCIXtjQnwdqpB8z9n?=
 =?us-ascii?Q?oz0AUWgaNL2MOivmKyr5AH1WojUHQAMmKFbBG+j68sTOWrySZiMHLaSnlyAl?=
 =?us-ascii?Q?u8lVYcAWmdYLvvjCwCcLmU0R9S2ydtI8INwznirDhAAHR1SGgXiEoRibcKlB?=
 =?us-ascii?Q?UH1QGn1CTFFTQ7MgHsQ9pjln+qwhzjGE2zbXl2h6657mmjc4twd+XYi5VlFE?=
 =?us-ascii?Q?foUlnusyxumJYNOBK0Azbmlx5vd33jKZH6ZfhpAu6b2bFwvuhUv7QlmVkGkK?=
 =?us-ascii?Q?7V7MQMYcAY1FGgpYjl1cZrOL+ySmarfCK3+/WJYDgHJy1eSwWO7ikL70l9to?=
 =?us-ascii?Q?Di1KtuQuzBrlzcc/mbk4L1lWPZfnjSThKmtX7sfhsbwgq3r3xNWAoXZD97ha?=
 =?us-ascii?Q?ndkgX9jL/TE62s/2yszFoFySH7JJso2/d9Qbt9Sec1wvTP9L6iiFFnJRuAcY?=
 =?us-ascii?Q?SRrUKzBcLe+F8CSs5C684Ip3uGb4nc+EvNeyejEXRHRcEk408YdhbBnGoOx/?=
 =?us-ascii?Q?9OazUDmSpQKqkVSbZ7OcC6mUotiB+QPOgpeYX8fm8sVtdqA5BqZo04ZhBOIs?=
 =?us-ascii?Q?iTkzE4rxm0X/FJO+6z1O4Qy/0linS1lM+s1gkp3YMMZzFuJxRaS7?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 24a3de3f-2d4c-4642-97d0-08de73a98646
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 13:35:07.3191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ffHXQ2L6Yl7Z3ETdmgSgTp/glWAarkJR/7te8FJn781qqiMFC2didujzEZqu7cpyApbr3wwhw//g64OyPBJdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6278

Implement .db_vector_count and .db_vector_mask so ntb core/clients can map
doorbell events to per-vector work and avoid the thundering-herd behavior.

pci-epf-vntb reserves two slots in db_count: slot 0 for link events and
slot 1 which is historically unused. Therefore the number of doorbell
vectors is (db_count - 2).

Report vectors as 0..N-1 and return BIT_ULL(db_vector) for the
corresponding doorbell bit. While at it, use vntb_epf_db_vector_mask()
to simplify vntb_epf_db_valid_mask().

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 36 +++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 2eb3db035644..b651c54d6bef 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1267,12 +1267,42 @@ static int vntb_epf_peer_mw_count(struct ntb_dev *ntb)
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
+	if (ndev->db_count < 2)
+		return 0;
+
+	return ndev->db_count - 2;
+}
+
 static u64 vntb_epf_db_valid_mask(struct ntb_dev *ntb)
 {
-	if (ntb_ndev(ntb)->db_count < 2)
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
 
-	return BIT_ULL(ntb_ndev(ntb)->db_count - 2) - 1;
+	return BIT_ULL(db_vector);
 }
 
 static int vntb_epf_db_set_mask(struct ntb_dev *ntb, u64 db_bits)
@@ -1512,6 +1542,8 @@ static const struct ntb_dev_ops vntb_epf_ops = {
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

