Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.79
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793808766;
	b=kwI+Ko+TVldNrNIgZfw4hZKeeK1YpEQIu+72YYW34icMXRmqMkhU2ZvO/uXF8C5ACPEF
	 LhR3SZ2H3bxYTIC4fy71DBweRRq7+wUn/bG1Qnp8WPpfGC9yr0G90GkNnS/rwWsYKOa3d
	 C7gUxb8FZbfRD8A+nNo1/T4gyBdns0KX/rZmdO2IJTebe59AKP1QCyL9mSjZ93b/jJPsd
	 A8RzMOLXLosnZ2efWHdXwCEafLDExEsFsg39t0MEMmIkTxFdJG7XUfA72SlaczuYgUrCX
	 dvznx8z01VQjG/SOChltcJANmjLaUGII/CghoH3U8JW6O1hHdE8sEktX1FCBlcIMuhA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793808766;
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
	bh=RKJj1ALq2DFWBAhH4IPrO+9Ti18i6mGNTZK3j6KvOx8=;
	b=J8pPlvtNfzH8lOmOqnXg8M+o5TGeLwgw9MYkHF12FuCHg1WsE8gEwrEVoeClDw1e5Zf8
	 tXfSeSh8clYoFVSHOyrq3rOUk54ZP5C4pQYyVgEhBvlsgLqictYLdH+eR9XhQHwb4nMR2
	 YOW5i2Oub/rlFw4Pa0lNDKyYulhptB4+ZCMIWFrvIqNRqepXHDXVZ7DmRe5wmJLfd6o2w
	 l9vF754Gn1315wEDseX5V0hoPbzO+A3V6/QdySLSjwqKgLEZNp12Ln9V9aYrkMryG9lRn
	 +cWHYs9KFlX/Hv+pvbdGLpqGpVyUgP8f5P38x0+j09ZEStjsBPkfOXqBhDsjVmH2WZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b="aI97V/rU";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.79
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020079.outbound.protection.outlook.com [52.101.228.79])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1725606D808;
	Wed,  4 Nov 2026 16:12:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1725606D808
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=aI97V/rU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SRPG1GxUb+/ycI8LBr15pj2Ai5n+hTtao9UXb/orWl9Z5Yg6QW97ztcSg8mVtY0MjTVHK6c8LgDzk4kW7wEfJ/GC9Ej3YnqxBqrbXP1hMCnRW57X1SJ4pGuUBFhSQHELWRODvWtlO09celyRrDrJDCTRiS3di+OyRBVtj3h6LrfiQyAt1K3AaBXRSagUFwaEf8LUm46Cjf5WdJ0RetABGEZD5HNc3mz0qgCwF5FHD+/3JfycZHc7JqqF37Ap0XjbmksPoFxF18r1fG/FmDvDL+z8GSnV62poD+Etn3Oxunm/tJvrm76rWUa93Lw1tpWj+OhEVHR3IvxdvMMePqtLGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKJj1ALq2DFWBAhH4IPrO+9Ti18i6mGNTZK3j6KvOx8=;
 b=ssfpsvC3De6ieTE/wt8hRMRpBkCljxnqjObLphzNbPRzEkxdhuy3b7Sj8dopVjUgSEb4P7c0wHFzpSbkjs05qYc5l80H8kgcs1q/99ZAuRA83sj6BRQiyLpEQ/kcaMMzEQXq6Dras8GqbB9Spih4zMs6fSltPFoaj1A7IEbTQ4AEiOsMn/e3ww05dmT6thhuhkOY54hOuYy9O17JlKk6olTfRm3B9Zdmj4IC7jgkGb10jeTWxPh2TigZfLNmjQIcrmzVpoP39hnMwv3GBeVFWPxiuuCc7b2r8ulx7ABb/CjK8MKwjDhQaFoJ24kSjzrRCaLG/JZPiy7IlXivTz+f/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKJj1ALq2DFWBAhH4IPrO+9Ti18i6mGNTZK3j6KvOx8=;
 b=aI97V/rUlKadUeE0sE4u6QsGKV6VuPlsW7hygFnAn76uNHHpt/oc1dzCspzBFppKTpB5RLBrTgI0/hbNnsUP4J5snq/9maZlgaobkq4e3Xzf4voJcLn8vHDmSpLfN5pVSHgR7HURZulMlitAvEIUIjJQRaB6IFEg1nORmelPuVA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB6678.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:417::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 16:12:36 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 16:12:36 +0000
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
Subject: [PATCH v7 4/7] dmaengine: dw-edma: Reclaim LL entries from hardware progress
Date: Thu,  5 Nov 2026 01:12:24 +0900
Message-ID: <20261104161227.1742005-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261104161227.1742005-1-den@valinux.co.jp>
References: <20261104161227.1742005-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0150.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::19) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS9P286MB6678:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d0fed21-ed2c-4abf-9816-08df3a8e712a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|23010399003|1800799024|366016|5023799004|261022105027099003|56012099006|261021121427099003|261021123027099003|261022075727099003|261009223027099003|261102123227099003|261026135527099003|261028144727099003|261026121527099003|261026140227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	3VLdQS2adv1vDO0bNj2Xw5R1yo936nt+0cTSOdd3SXxInKoX3I8ZQ7cumnmITzvwlmoFlC3muFaN1MqpoLbIOxm3fQl44exv6KUU65aZKtlFE6zaF8nyQ3LaRh6X3x7ZcIxBLHW0PXEHzsH1VV4ua9i1hBX7GWK2lJubkxLxZHPE/5yA1LoslleH8YrliEPmWKKpOxwMex6OOFMjGlPOuWxBnh9pQPchGT+scylaXb6bZ11Qq4DcA/Rf6uL61muR6PTNkO9hinaYcKyTk1Lx2B2uXPbRUIw8fkL9k0xsHdCiPf+k2pB6R7JfFBpXJv90XPjcTr7uD3wdD4k2SwwYdsqz1+hImIJ/ODKX1McGeV62Vj+4YL3mmZougvgX9Deql5NS7HW0ROsXxLfNLng0zkEWNXg/fBHv0XVoBYgFcW+Qgo8dcDnZ6+wiv1hdSOr+Ayn2G3+meJd4JBH2/YIY726wJUBIHgUFoH04ZzkBg/KYl0eZzsYDEmPeWFHk49CLPIM+I3gtA9OcdwULtS6PiVBBLHafyrRc1PKTWHuogJ5CYXRSQyA0rj/yurP0YT/opqMnHFddhBXY96D4zFEhgom1gqnjhEzLha030TX8+nLdlQyvyRlhZRX0ST6NxyZ8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(23010399003)(1800799024)(366016)(5023799004)(261022105027099003)(56012099006)(261021121427099003)(261021123027099003)(261022075727099003)(261009223027099003)(261102123227099003)(261026135527099003)(261028144727099003)(261026121527099003)(261026140227099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8VoQh0iER8jz/SWzaGrpE/32VQSU0kBYPQsfytVCxvpiD0+V0r5KQ0SdwZrF?=
 =?us-ascii?Q?BnKBGp4Py2riJfxzaYQKdDa4fd8ThRQva0HtoJqRIwS8j6+zoThATUd0KbNM?=
 =?us-ascii?Q?nL80K+tleu8h9K0rG3iGsYOwEi7c+RkKdCDJEiNdeptEC0OeRRjXamra6+q8?=
 =?us-ascii?Q?Y6004J0T1MyaL6BzPGsl0dyGTd5ChMsmtKVxyE6RxoMz6mu1ApilRfM5feaC?=
 =?us-ascii?Q?yNcLmbb4O2ZdxyL7UDGJI+GoBdEGWXRtPS24a6sufyToSf92YaSQ6yE1oqXy?=
 =?us-ascii?Q?qLLFu5kNzyu8xq/CFMRmY5p+Q46AtJROnp4FbsNbmNyNNUo7WaC3qHfKGMta?=
 =?us-ascii?Q?+xYYLVEN7WjZbnCnLPWMGzEcUsJaQJgIyUEjLqnj+UW3cg2ka1Sna5934bIE?=
 =?us-ascii?Q?QrT2ARt3FH0hC7aChD0Bo3A8j0uorYxF2EcOMRJv9+QfRgEjf5wbuKhNG2Je?=
 =?us-ascii?Q?4elDk8A9tFjua5q8PuM2RvWPmyPiE+ENrfl3HJtYpxwCqhpeZ6xb5Xovco1c?=
 =?us-ascii?Q?HE/zx0fyy3m68vjsMyKPuTv0QoAoiH6leUlYsdf/n++pv+2q/J/XrfxUBroQ?=
 =?us-ascii?Q?S4ykDBA3yPTf/rCYP0dLNGm8PTJI6kRER6HotU1d2NYIfz85n6rkmVmT1OzE?=
 =?us-ascii?Q?auFBKfFeZEbeGOQNFGiiv5K58QBJr8VfiqlDMgbLw0u1NZ7GRj9esFgs6XX1?=
 =?us-ascii?Q?NH3IOLqdwj2RgdByRRCbBq6z7nEe5iQOmkUEw8HxzwtCH3EB5SyzEBk0c7e1?=
 =?us-ascii?Q?t7CZbOtQZMTVtsgkkdkeLuXFifGYkPnK2nE6jy6t1iz0UWL+d3/TP6547K1q?=
 =?us-ascii?Q?0c2YiDoaqslZz71mqUSOeRkESU0hO6xJoc980IxsGKqq0a+lPU5D3I7NjtlV?=
 =?us-ascii?Q?IuV7qDRbiWX4EZxskVcMhI5cJccVekm/kJmot27uah7od51A/xdH8ZFAIlR1?=
 =?us-ascii?Q?/gXmy9r1rSxi+spufQMQ647W0l8IrVB5qadfZRtbabX4O9Bz9D5F5uDmnNaF?=
 =?us-ascii?Q?Lmh6RJ4VWYXafBV4lAYurzO8K2A+68iXXVqOgmIcSTZZI1gMylHILRYCHZju?=
 =?us-ascii?Q?zfbcqH9lcfV+eMkH9KCIvaTDuhM4jOs3eTxtEAinb1jbFqbS65TBBT0TzA/a?=
 =?us-ascii?Q?VdAgSYlxdZAuKEydjQdZueYxD1jKqnsiKF4EufVMS1jf4dCRC6DAR2qONb8Z?=
 =?us-ascii?Q?Orp7jPFNRXtZUCMKz8QRivIw+MI8NJiUgXmH1dxAOpKr6901KV+hZObdKPNK?=
 =?us-ascii?Q?aMnQtL0GgbCv6VuRU7zpHetzLdUytr1Z62BvOn2WA/Tsqo3A4ScZIHvAeFmj?=
 =?us-ascii?Q?refwFtjwD1yA1HOugnQTEB3sGoLI53p2cUvijutZEmV78iwda8LA05QcE5zf?=
 =?us-ascii?Q?C7OK2ALmWxDodwaMX6UecH3QTuNPfqrcRKKeICQ7vYF9neX/OXzwUAJzCRXx?=
 =?us-ascii?Q?Z+B8Sn4N15tt8dKHU3WcmMy/7tBjTUJMi3MTNcqPypTcuma/zU1z2R2B2HYp?=
 =?us-ascii?Q?sBENUF073uNRAuEFAv7dqt1IREzvwu3UBpT+V1BuAIHgkYlj551nzET8lUUq?=
 =?us-ascii?Q?FRZsCf3+LyLArTw5N83GUqkwkQ8jP6Zo7zl9Y7isgrsQhhKg5AVkexcdD3z+?=
 =?us-ascii?Q?/eYcHvI+ihkqXl9qEMzI/IZ5BlHXn6SKVvx9cunDaa1TvSlXrDKm2L3mY50e?=
 =?us-ascii?Q?vWgqG4FXHZQzS5dbiCny01ELb/BqWwTFBqE3kz/vyisbJ60CbzdKkS5yF1nM?=
 =?us-ascii?Q?YgDL3Aq7cEg4C8vcOID3YhLUCCK9cWjpAPaO1uI7WPJUmX0N2HTY?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0fed21-ed2c-4abf-9816-08df3a8e712a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 16:12:36.8939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RMVcJ5OXJTZGbt3BteEjdeWSubrO/MSG5RI8v5I/tvOHr+Z1TY6AHUSAwQK/nJeSRq1Yjw5jjrM06Wzu0qTjOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6678

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
  the channel stops. Keep unfinished work for resume.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes from v6:
  - Handle STOP before consuming LL entries (Sashiko).
  - Use modulo, assert vc.lock, and share descriptor completion code
    (Frank).
  - (*) Restart stopped channels during termination. Tests under DMA
    load exposed the missing restart. In fact, v5 patch 19 had similar
    handling and I mistakenly dropped that logic while doing major
    v5->v6 reconstruction/simplification:
    https://lore.kernel.org/r/20260812155721.2807506-20-den@valinux.co.jp/
  - Substantially reword/polish the commit message.
  - Link to v6:
    https://lore.kernel.org/r/20261030150742.2586776-3-den@valinux.co.jp/

Note on (*): A channel can still report STOPPED just after a doorbell.
Another doorbell in this window may trigger the class B stall observed
on R-Car S4 [1]. That stall appears specific to S4 or its DWC IP
revision, and IMHO should not block this series any longer.

[1] https://lore.kernel.org/all/tkyu5rsxfa7i6rxxw6qxmmwke5qnlxptwx4j2s24fhftsmmf26@gamef2ec4wwm/

 drivers/dma/dw-edma/dw-edma-core.c | 156 +++++++++++++++++++++++++----
 1 file changed, 134 insertions(+), 22 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index e2f7af5969c6..e2f2a535d5ad 100644
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
@@ -161,17 +154,80 @@ static bool dw_edma_ll_stopped(struct dw_edma_chan *chan)
 	       !dw_edma_core_ch_transfer_size(chan);
 }
 
-static bool dw_edma_ll_drained(struct dw_edma_chan *chan)
+/* Return the first entry we cannot reclaim yet. */
+static int dw_edma_ll_boundary(struct dw_edma_chan *chan, int idx,
+			       bool stopped)
 {
-	int idx = dw_edma_core_ll_cur_idx(chan);
+	if (idx < 0 || (u32)idx > chan->ll_max)
+		return -EINVAL;
+
+	/* After a stop, LLP points past the completed entries. */
+	if (stopped)
+		return idx == chan->ll_max ? 0 : idx;
 
-	if (idx == chan->ll_max)
-		idx = 0;
+	/*
+	 * DMA_LLP can advance before payload completion. Keep the boundary
+	 * one entry behind it, wrapping at the start of the ring.
+	 */
+	return (idx + chan->ll_max - 1) % chan->ll_max;
+}
+
+static bool dw_edma_ll_drained(struct dw_edma_chan *chan)
+{
+	int idx = dw_edma_ll_boundary(chan, dw_edma_core_ll_cur_idx(chan), true);
 
 	return idx >= 0 && (u32)idx == chan->ll_head &&
 	       dw_edma_ll_stopped(chan);
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
@@ -200,7 +256,6 @@ static void dw_edma_core_ll_start(struct dw_edma_desc *desc)
 		}
 	}
 
-	desc->done_burst = desc->start_burst;
 	desc->start_burst = i;
 }
 
@@ -309,6 +364,52 @@ static void dw_edma_core_ch_maybe_doorbell(struct dw_edma_chan *chan)
 	dw_edma_core_ch_doorbell(chan);
 }
 
+/* Must be called with vc.lock held. */
+static void dw_edma_ll_advance(struct dw_edma_chan *chan, bool event)
+{
+	bool stopped;
+
+	lockdep_assert_held(&chan->vc.lock);
+
+	/* Terminate without scheduling completion callbacks. */
+	if (chan->request == EDMA_REQ_STOP) {
+		if (dw_edma_ll_drained(chan))
+			dw_edma_finish_termination(chan);
+		else if (dw_edma_ll_stopped(chan))
+			/* A newly appended tail may have missed the last stop. */
+			dw_edma_core_ch_doorbell(chan);
+		return;
+	}
+
+	stopped = dw_edma_ll_stopped(chan);
+	/*
+	 * HDMA updates LLP at watermark events while running. Use running
+	 * samples only when processing an LL interrupt.
+	 */
+	if (stopped || event)
+		dw_edma_ll_consume(chan, dw_edma_core_ll_cur_idx(chan),
+				   stopped);
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
@@ -493,6 +594,8 @@ static int dw_edma_device_terminate_all(struct dma_chan *dchan)
 		err = -EPERM;
 	} else {
 		dw_edma_set_request(chan, EDMA_REQ_STOP);
+		if (!chan->non_ll)
+			dw_edma_ll_advance(chan, false);
 	}
 	if (chan->status == EDMA_ST_IDLE)
 		dw_edma_set_request(chan, EDMA_REQ_NONE);
@@ -777,7 +880,7 @@ dw_edma_device_prep_interleaved_dma(struct dma_chan *dchan,
 	return dw_edma_device_transfer(&xfer, dw_edma_device_get_config(dchan, NULL));
 }
 
-/* Must be called with vc.lock held. */
+/* Non-LL completion; vc.lock must be held. */
 static void dw_edma_done_interrupt_locked(struct dw_edma_chan *chan)
 {
 	struct dw_edma_desc *desc;
@@ -796,11 +899,8 @@ static void dw_edma_done_interrupt_locked(struct dw_edma_chan *chan)
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
@@ -816,14 +916,12 @@ static void dw_edma_done_interrupt_locked(struct dw_edma_chan *chan)
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
@@ -835,6 +933,16 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 }
 
+static void dw_edma_ll_interrupt(struct dw_edma_chan *chan)
+{
+	guard(spinlock_irqsave)(&chan->vc.lock);
+
+	if (chan->status == EDMA_ST_PAUSE)
+		return;
+
+	dw_edma_ll_advance(chan, true);
+}
+
 static void dw_edma_abort_interrupt(struct dw_edma_chan *chan)
 {
 	struct virt_dma_desc *vd;
@@ -863,8 +971,12 @@ static void dw_edma_irq_work(struct work_struct *work)
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

