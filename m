Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.103
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794058236;
	b=ZHSBFowIckNVqf7D6HBLEpVQnzwPQLKW3axdXquFGvheBgKpDPwSeFFReJT/u+8sYY5J
	 1aTZZhuFMI55vKQZppkZs4klhEtPwq0EjRc9b8sDdxgFBqZeyllAn6/QEI34nFz6+hxMc
	 RZDwM94X+mCNJnB4PW+qASAVgr6qfVBJAHQ1NfYCTNeTNSA3QyU4sdoaTPbHZtT5TkbqX
	 1T5+IE06VHiRZcdv1lbbyEOYPACo3SQ+6r5eYv6RhTJsNfASjjcC43yb18z4POrYyMPzo
	 aEEfTyBRR4YWBN8cBa6PJCqK1lwmRw6DNSZueSSXa/7JIwP4yo+8zREfMmIe7o460mQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794058236;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ee8AvcID/M2vSUAv3F6wgQ+oG/ZQP6CQd1bM6ftItMc=;
	b=lr7ehpjKUyxWAHI+GThdFMzy4BJAIHYUHT7RsTz8mo0Oqb9+H3gglR2F2k4VAeSAZV3M
	 yp++72AY8u4QYA7wiL9fyqF5wUGQwrciL7AqnVL/ekThCC/0nH8u32lwenmvvDHVfEBny
	 3joNH3sBPin5QduBjJS/PiOVAdTGzoSDVWA7PWpFTrBbMG/+7Bc9WvC67Ajix7pxy5p4x
	 3ylQtEKlPAb9iXdvRlXSOUWfx5hS/2HnrNtLutUvOSL8HTUeRQXQVvQDubf+nev9MCvrl
	 r3Lw4ouCjjX1vhXG2QxCnf3kNBBBtOok4SmD28Q2tl/fPv9YAiGYwgQi80e37H9Hvzg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=BWea7uUY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.103
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021103.outbound.protection.outlook.com [52.101.125.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2506F606D804;
	Sat,  7 Nov 2026 13:30:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2506F606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=BWea7uUY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwcaHw0oQNuuohPimTKF72+bKN9rWLHAlzswtSISNH9jBgEk3JF4M3oSryhgPrd0Ux9hyFa+rMz/v7sO59TclW6p3mvZASse/SGBEJBHJZnOqmpN4zpC++aeQxi9xKHyEOh1h+3KmNPxpo8S4pwzHkq9HeJ6DShvP1Pf0CTJz5IZYHtEkQbZ81tLLAwDJMVpxxLlTY7m5fl74GuOL644WHrrDYFjCgiKhiw+nl7OSiUNuzlLt9dmNxIjKAq+ZPv+MhcmTm28gRVXcfKjoZp6UKT4jJEG+udBy4/hFbBJnRxbRLj27lZ20ZvbJtGEHIMv9Z/p5lUm7y0SCq6TqpPnzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ee8AvcID/M2vSUAv3F6wgQ+oG/ZQP6CQd1bM6ftItMc=;
 b=LUnrUl4THyyeVckG3Ve3ekMFHc2xHIqDo/Pd0WS2UtD2ok0dj6N8Eb5mlHlDNfDhbI3L5HGdBJri9giBdCtDVvryH0/5i+SVqIHUigk1A0oBTejhcTnpYV0eNixLfpttCQDFydX+jwAnv5A5a93UJUIeYij3CYTLQonBGbSvQ1LvqYflma4PvIRV7Q9+6iYfqWo/Pl0HRc8etj67PjOgLbeIM8KqE9HJW177ucfMX7tSMyWaiar0HdOzwt/9/awysliqwMbvI0vT9qqYGZEq31zdiMKD54YkhnFis6Cm6X6+FkRWSoFlTBRgRLAJSSdoEotFIvvqAiAA0Yaji3KtmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ee8AvcID/M2vSUAv3F6wgQ+oG/ZQP6CQd1bM6ftItMc=;
 b=BWea7uUYr3uyVYdAZUAn8eZp1CMx3DKDfTgTzQtXgtiVsFfatEQ8kXqtt5fdWdV0kSkyUaZoycrXU3ohH4hFaiw4LgdOF5bl4JzrzCrP0FEb79dGbMOT1qeRYc86OoFniY7g75DuK77R3wXvVXiFNv+u756YLWMqnb8HoQSoI9E=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY4P286MB7206.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:366::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 13:30:33 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0592.010; Sat, 7 Nov 2026
 13:30:33 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Niklas Cassel <cassel@kernel.org>,
	Devendra K Verma <devverma@amd.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v8 4/7] dmaengine: dw-edma: Reclaim LL entries from hardware progress
Date: Sat,  7 Nov 2026 22:30:24 +0900
Message-ID: <20261107133027.364237-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261107133027.364237-1-den@valinux.co.jp>
References: <20261107133027.364237-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0272.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::18) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY4P286MB7206:EE_
X-MS-Office365-Filtering-Correlation-Id: 842c1b71-c203-4fce-7944-08df3cd34cb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|10070799003|366016|376014|7416014|261102123227099003|261009223027099003|261022105027099003|261022075727099003|261021123027099003|261028144727099003|261021121427099003|261026121527099003|261026140227099003|5023799004|56012099006|6133799003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	UYQG4MFOTMYDq6IebRuD+aB9jHAeA/oBz3LlzTuC1tZsI1wpIWH9JnEemCASAjbO/OLaZVsTL9QOQNDyHhezGak30VoozeSh+5u9ovVuyguCPQgt2Ract0DuW2xD+EAicr5kZ1uXJ2gZU3JpRzWaK6gHnbJOy6AeT/uhRQo94dLIsleLZc7zrCrKV+7qpyIL5k9eo8tOg6KQurOpQLJzvBz0bLm/mO7NvJmNvxsWiBU9/tAfnPQfBALf5mxpvv8YjdEZbukxJ7+XSFhJeuoO2Xluj8zM5tezXWUZlybTDyf9xTJYnrZNNSvLAElhq4C3nVk1iTjRvrQUXjanQmI9sFCBN++ctHQqNSZQcw+6ye3h3yYoCeSVxlbb7DxPo96gtJ+nM7+5om5ADiaRLmTyX2FJ0L04NRvM14R4TNWCpJUVlm2wA7JQ5kesG6m+cuyHBErVGurRlvtc9eQYTG6XOp4BMedl4knwrIevAruvLW5En/WMGB10YNby0gqbHf+ee7F/3k1oxE7eGQbqlyksch3CsuxLXCIwJEZyijPm34pNTL6LyELn59MqDwPZa/6zZlqMPbpHEV2adiXaX8sOtIUIqY1qiw2MJRxmjvHV4N6egGvcUiv2pOGJRVNRuTwCvFp2erDfvQCrNcqoYWEa7FnlSb4nik4RjfzZ7YlVIIs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(10070799003)(366016)(376014)(7416014)(261102123227099003)(261009223027099003)(261022105027099003)(261022075727099003)(261021123027099003)(261028144727099003)(261021121427099003)(261026121527099003)(261026140227099003)(5023799004)(56012099006)(6133799003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HdtUiulgb8rGcVZgkwaFXhSc3Ptu5CRpO5ufZ+IMPJJlS7yORfWRBRwgnF1J?=
 =?us-ascii?Q?A5OAv4Bd7yOFSomuOQsH/KeSNfu/La+/REWPeREiHfPQLmH1zdGCfRsEHLPG?=
 =?us-ascii?Q?JX4DrliestIhvdcHUnAZRvToU2UQxy9BhqBzTvKj+Cepx+NkrgGnxVnfpRGw?=
 =?us-ascii?Q?IRFN4fq+9JtQOhmtph9zggH4VKJTqEXmFjJgZtH4rjOjCOUuLr2WmsxxIBpr?=
 =?us-ascii?Q?zBYCWhLguuV4W3hbrDwyrwG7PzGwqQrNqQaTtyuHhdKFLr6N5K9dbZzc5xvI?=
 =?us-ascii?Q?907eHPR6o4Zgl6U9arM5hVM/AMq9FvfSmvC4vKr2bZChaLNWhw5oMrRDNNqJ?=
 =?us-ascii?Q?FFpsu7HNWeXhvWObzxMrz8xUD477mJsNHKX481ok6y0V5GeJDEKYdO8/GDC4?=
 =?us-ascii?Q?+h7Hn5+AmKlECftg4GHeU5tT4oMuzUsA/wW+dIgy8os5ztrKe37jEvhMb6oq?=
 =?us-ascii?Q?bX9TLUdCFDHNyWDTXW0RRKQqMDpRMQ0tmNgCTHN6xy1b9Sxhh8gc1+0ZdIS+?=
 =?us-ascii?Q?XOGEEbY4xGB0BUBVv5tizP3rK7rAU7q7/oMT/rzA6bgPMTYLuSoE5Dy6bp/c?=
 =?us-ascii?Q?JwIwZUatH8kSjQu2N4dfUo3BH1DZKU+3V2gkFk/mkv3Yxc4KfLnC+tdGvV0n?=
 =?us-ascii?Q?cMLhtJj+DhqSZRlwaU9jJx4M0eKRHIWM7T9zZqWeFbf3KR44EK2oTCidodem?=
 =?us-ascii?Q?M5tqcp4I8DGqO5Vn0FWI+tuu4iQ6oyYR/73pLf6rKbZKbwDpPCSP/dDR4T1E?=
 =?us-ascii?Q?1djYjGueOAzICgOzOu/p1VaXA7OyT6mO77XYXgQNI8WB4u1m2BWEsuwEeLrm?=
 =?us-ascii?Q?EEr5J4IuKq6dy6jH8/XrGHwrK3TGd+CVrna2cK4aaHL8JJHZPygXtpiWdljx?=
 =?us-ascii?Q?juTPh16/tuDe7zcpsRtiEKn0L7s1FxSNJnzPuDCflwWv/UUY7zlz4lQsR8+m?=
 =?us-ascii?Q?+D4SAKYpD7Aukqps6ONQmjptKoleao130v3KyeDzr8fOYt9dAm2wvvylsz6R?=
 =?us-ascii?Q?qxH1+oAaQDq8t3DP49yWI3M3SXRXd1i+GvlaxM6lnG+ZzjmWWnx+NPkUg//C?=
 =?us-ascii?Q?4ceADB9Ey/WZ41nzc+qTrqlG9E6zZGHPJMbZRYA8e609Ge3gU74C64QqCiwj?=
 =?us-ascii?Q?WLEGuA6sWEBuYVS6mcveQZZv22ZwZMmwPRMYdVS8c9ubwNAveCrS1GP+/I1V?=
 =?us-ascii?Q?w7i3XkYA48n6Zh3YK/ko5tFVlpb6o1TXMT3aL4CIHjX9uANRoJ+0/VkMyAUz?=
 =?us-ascii?Q?fnIjaZccVrG5GbI7CFpu9ilddOHta/MiIkKamULVn99HAA2TEnopk5SGl8KV?=
 =?us-ascii?Q?W974g8ASLjKgxg4KQQ/6vayTJ4ZZaVoXu1YY8GEOGHziiosl4sEz8N4vi6h/?=
 =?us-ascii?Q?rMCuUdv3cgRuGsuan/E5I9UU5SmZ9RWlMTQnX25DMu1mImkMhsHYRxI9a4gW?=
 =?us-ascii?Q?bXsZqAUsrXwmOILGaHPouZlVix8h67IBt5C31/fQwzlIiWCEuQnAv/4N7bBP?=
 =?us-ascii?Q?Z+QYZL6XigNa5rhvO3EPwc6+arL8DsWAXWA5V87ASq76u5/p6QrAv9L0h731?=
 =?us-ascii?Q?qqjdFcvRuDgIFsj2HwiHTUBu3jHdrDSOK+MbLD7BJEyPVRul0VDn+/buDqQV?=
 =?us-ascii?Q?AWp1pm0rbgLmEK5dMzYhp/NIn/5ymc9cqMLjInFOUKyzIOucnuc9zY6NfIE4?=
 =?us-ascii?Q?CiTQHw5zYOJe7z5ExpZzlpyYmjE/TmHkBwObeDEzVyjDbSd4cE9pPLfhiH49?=
 =?us-ascii?Q?7kcQZYBjh+m35OF7hs6VXcEq8HGFu1JruwcRhXKdyXxOoJRE1spO?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 842c1b71-c203-4fce-7944-08df3cd34cb4
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 13:30:33.3194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQ+G6vUdXpwwxJxNSMz7Amky4hbPMuMJunhP0hKya+uIZewidk8lSeb3RuteIIbjeusvanX60TVmmasYP2gOXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7206

With dynamic appends, a DONE interrupt no longer means that all
published LL entries have completed. Prepare for this by using LLP to
advance ll_done and complete descriptors in issue order.

Reclaim completed entries and refill the ring as space becomes
available. Restart a stopped channel when published work remains. This
also allows descriptors larger than the ring to run in batches.

Hardware can keep running while the driver handles an interrupt, and
LLP does not always track payload completion. Use the following
exclusive completion boundaries, where idx is the raw LLP entry index
and prev(idx) is the previous data entry in the ring:

  State/event          Meaning of raw LLP               Boundary
  -------------------  -------------------------------  ---------
  eDMA/HDMA stopped    Next entry to process             idx

  eDMA running         Observed to advance before        prev(idx)
                       payload completion

  HDMA watermark       Inclusive LLE recycling limit     prev(idx)

A stopped sample requires CS=STOPPED and a zero transfer size.

While running, HDMA updates LLP only at watermark events. Its documented
recycling limit translates to an exclusive boundary of next(idx).
However, tests using that boundary for dmaengine completion reported
IOMMU faults on HDMA 6.30a SpacemiT K3. Use prev(idx) for both engines
while running to keep the handling simple and conservative. Entries held
back by this rule are eventually reclaimed on later progress or a
confirmed stop, where idx gives the exact boundary.

Handle termination and pause as follows:
- On termination, stop publishing new entries and drain those already
  published, restarting the channel if needed. Terminate descriptors
  without callbacks, as in the non-LL path.
- On pause, stop publishing new entries and enter the paused state once
  the channel stops. Keep unfinished work for resume. Reclaim delayed
  completions without restarting the channel.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes from v7:
  - Read LLP before checking for a stop, and use the same sample for
    completion and termination (Sashiko).
  - Reclaim delayed completions while paused without restarting the
    channel (spotted during code inspection, not observed in hardware
    testing).

@Frank: Dropped your R-b due to the changes; would appreciate another
look.

 drivers/dma/dw-edma/dw-edma-core.c | 160 +++++++++++++++++++++++++----
 1 file changed, 140 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 346ec8ee631d..1d13a25663ef 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -53,13 +53,6 @@ dw_edma_alloc_desc(struct dw_edma_chan *chan, size_t nburst)
 {
 	struct dw_edma_desc *desc;
 
-	/*
-	 * For now, a descriptor that does not fit would stall the channel
-	 * forever: reject it up front.
-	 */
-	if (!chan->non_ll && nburst > chan->ll_max - 1)
-		return NULL;
-
 	desc = kzalloc_flex(*desc, burst, nburst, GFP_NOWAIT);
 	if (unlikely(!desc))
 		return NULL;
@@ -181,18 +174,83 @@ static int dw_edma_ll_read_idx(struct dw_edma_chan *chan, bool *stopped)
 	return idx;
 }
 
+/* Return the first entry we cannot reclaim yet. */
+static int dw_edma_ll_boundary(struct dw_edma_chan *chan, int idx,
+			       bool stopped)
+{
+	if (idx < 0 || (u32)idx > chan->ll_max)
+		return -EINVAL;
+
+	/* After a stop, LLP points past the completed entries. */
+	if (stopped)
+		return idx == chan->ll_max ? 0 : idx;
+
+	/*
+	 * DMA_LLP can advance before payload completion. Keep the boundary
+	 * one entry behind it, wrapping at the start of the ring.
+	 */
+	return (idx + chan->ll_max - 1) % chan->ll_max;
+}
+
 static bool dw_edma_ll_drained(struct dw_edma_chan *chan)
 {
 	bool stopped;
 	int idx;
 
 	idx = dw_edma_ll_read_idx(chan, &stopped);
-	if (idx == chan->ll_max)
-		idx = 0;
+	idx = dw_edma_ll_boundary(chan, idx, true);
 
 	return stopped && idx >= 0 && (u32)idx == chan->ll_head;
 }
 
+static void dw_edma_ll_consume(struct dw_edma_chan *chan, int idx,
+			       bool stopped)
+{
+	struct virt_dma_desc *vd, *_vd;
+	u32 done, used;
+
+	lockdep_assert_held(&chan->vc.lock);
+
+	idx = dw_edma_ll_boundary(chan, idx, stopped);
+	if (idx < 0)
+		return;
+
+	done = dw_edma_core_get_ll_dist(chan, chan->ll_done, idx);
+	used = dw_edma_core_get_used_num(chan);
+
+	if (!done || done > used)
+		return;
+
+	/*
+	 * LLP may still point to the first pending entry. Subtracting one
+	 * can wrap the index and falsely mark all pending entries complete.
+	 * Reclaim them all only after the channel has stopped.
+	 */
+	if (!stopped && done == used)
+		return;
+
+	chan->ll_done = idx;
+
+	/* Match reclaimed entries to descriptors in issue order. */
+	list_for_each_entry_safe(vd, _vd, &chan->vc.desc_issued, node) {
+		struct dw_edma_desc *desc = vd2dw_edma_desc(vd);
+		u32 consumed = min_t(u32, done,
+				     desc->start_burst - desc->done_burst);
+
+		if (!consumed)
+			break;
+
+		desc->done_burst += consumed;
+		done -= consumed;
+		if (desc->done_burst != desc->nburst)
+			break;
+
+		dw_edma_complete_vdesc(vd, DMA_TRANS_NOERROR);
+	}
+
+	WARN_ON_ONCE(done);
+}
+
 static void dw_edma_core_ll_start(struct dw_edma_desc *desc)
 {
 	struct dw_edma_chan *chan = desc->chan;
@@ -221,7 +279,6 @@ static void dw_edma_core_ll_start(struct dw_edma_desc *desc)
 		}
 	}
 
-	desc->done_burst = desc->start_burst;
 	desc->start_burst = i;
 }
 
@@ -330,6 +387,61 @@ static void dw_edma_core_ch_maybe_doorbell(struct dw_edma_chan *chan)
 	dw_edma_core_ch_doorbell(chan);
 }
 
+/* Must be called with vc.lock held. */
+static void dw_edma_ll_advance(struct dw_edma_chan *chan, bool event)
+{
+	bool stopped;
+	int idx;
+
+	lockdep_assert_held(&chan->vc.lock);
+
+	idx = dw_edma_ll_read_idx(chan, &stopped);
+
+	/* Terminate without scheduling completion callbacks. */
+	if (chan->request == EDMA_REQ_STOP) {
+		if (!stopped)
+			return;
+
+		idx = dw_edma_ll_boundary(chan, idx, true);
+		if (idx >= 0 && (u32)idx == chan->ll_head)
+			dw_edma_finish_termination(chan);
+		else
+			/* A newly appended tail may have missed the last stop. */
+			dw_edma_core_ch_doorbell(chan);
+		return;
+	}
+
+	/*
+	 * HDMA updates LLP at watermark events while running. Use running
+	 * samples only when processing an LL interrupt.
+	 */
+	if (stopped || event)
+		dw_edma_ll_consume(chan, idx, stopped);
+
+	/* An interrupt may arrive after we have entered PAUSE. */
+	if (chan->status == EDMA_ST_PAUSE)
+		return;
+
+	if (chan->request == EDMA_REQ_PAUSE) {
+		if (!stopped)
+			return;
+
+		dw_edma_set_request(chan, EDMA_REQ_NONE);
+		chan->status = EDMA_ST_PAUSE;
+		return;
+	}
+
+	dw_edma_start_transfer(chan);
+	if (!dw_edma_ll_pending(chan)) {
+		chan->status = EDMA_ST_IDLE;
+		return;
+	}
+
+	chan->status = EDMA_ST_BUSY;
+	if (stopped)
+		dw_edma_core_ch_doorbell(chan);
+}
+
 static void dw_edma_device_caps(struct dma_chan *dchan,
 				struct dma_slave_caps *caps)
 {
@@ -514,6 +626,8 @@ static int dw_edma_device_terminate_all(struct dma_chan *dchan)
 		err = -EPERM;
 	} else {
 		dw_edma_set_request(chan, EDMA_REQ_STOP);
+		if (!chan->non_ll)
+			dw_edma_ll_advance(chan, false);
 	}
 	if (chan->status == EDMA_ST_IDLE)
 		dw_edma_set_request(chan, EDMA_REQ_NONE);
@@ -798,7 +912,7 @@ dw_edma_device_prep_interleaved_dma(struct dma_chan *dchan,
 	return dw_edma_device_transfer(&xfer, dw_edma_device_get_config(dchan, NULL));
 }
 
-/* Must be called with vc.lock held. */
+/* Non-LL completion; vc.lock must be held. */
 static void dw_edma_done_interrupt_locked(struct dw_edma_chan *chan)
 {
 	struct dw_edma_desc *desc;
@@ -817,11 +931,8 @@ static void dw_edma_done_interrupt_locked(struct dw_edma_chan *chan)
 			break;
 
 		desc = vd2dw_edma_desc(vd);
-		if (desc->start_burst >= desc->nburst) {
+		if (desc->start_burst >= desc->nburst)
 			dw_edma_complete_vdesc(vd, DMA_TRANS_NOERROR);
-			if (!chan->non_ll)
-				chan->ll_done = chan->ll_head;
-		}
 
 		if (chan->request == EDMA_REQ_PAUSE) {
 			dw_edma_set_request(chan, EDMA_REQ_NONE);
@@ -837,14 +948,12 @@ static void dw_edma_done_interrupt_locked(struct dw_edma_chan *chan)
 		if (!vd)
 			break;
 
-		if (chan->non_ll || dw_edma_ll_drained(chan))
-			dw_edma_finish_termination(chan);
+		dw_edma_finish_termination(chan);
 		break;
 
 	default:
 		break;
 	}
-	dw_edma_core_ch_maybe_doorbell(chan);
 }
 
 static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
@@ -856,6 +965,13 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 }
 
+static void dw_edma_ll_interrupt(struct dw_edma_chan *chan)
+{
+	guard(spinlock_irqsave)(&chan->vc.lock);
+
+	dw_edma_ll_advance(chan, true);
+}
+
 static void dw_edma_abort_interrupt(struct dw_edma_chan *chan)
 {
 	struct virt_dma_desc *vd;
@@ -884,8 +1000,12 @@ static void dw_edma_irq_work(struct work_struct *work)
 	do {
 		events = atomic_xchg(&chan->irq_pending, 0);
 
-		if (events & DW_EDMA_DEFERRED_DONE)
-			dw_edma_done_interrupt(chan);
+		if (events & DW_EDMA_DEFERRED_DONE) {
+			if (chan->non_ll)
+				dw_edma_done_interrupt(chan);
+			else
+				dw_edma_ll_interrupt(chan);
+		}
 		if (events & DW_EDMA_DEFERRED_ABORT)
 			dw_edma_abort_interrupt(chan);
 	} while (atomic_read(&chan->irq_pending));
-- 
2.54.0

