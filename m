Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.135
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794058235;
	b=duTkhgkRP+G9UQP0dCQnB54NtsGhw+nd0ukmwZLKE59mZog8qsJ+BMUaE//4UHtq/hzs
	 lzHzImjWRq44rFW6NSh3pQm3lo1ZePkP7NH4tSoWYaJr/AiET/mT0VzoLDwr+oxE6/F/F
	 PYk+6Xj/LrqOEUMkDTDgAHy9aNAAMQ954OpzRWaDlTs2dF5fS6aPoLcS11pHBj5yTDC52
	 tHZL0YtqQUfPfg52tzcO0DRhZYkfvwblowkgG7SvGuGPGl5zf5C/fAIdbQ3S35iKa7waY
	 2iHFKqAJzD73NL1qxAXfnBcHKRQ8uCmGZsEHl0rK9KBbCzq0WfeuaP/HafhWTw4ktgg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794058235;
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
	bh=/P/+DmCTrLU5Pw+nTaV4w+qH9EATz3dsofkyNM8H32c=;
	b=zxvaAXzzbvnUJkxAbBKyEMgVosSy+rLhHuMy5RwntZqYVv488Cnn48XSF3bhcNsGlJDN
	 3FO8bqVMbpi3sFvSTLv6oi3Mp9xdAPF9NE77xgFymmLDWxXOsDLtnwZF1XCoV0pYcLcH4
	 GlE0q6L9KUK4PUqddQzAOvP8lTDPjRFdBA2+McvPYTzKLoB9Sk+RJ7pEDBsLn0DP4LRuX
	 ly6XUS7m+tsON99RicmU+yTN9ZC5NWWqLY7fb/Vx/Nc59t32qu5W638ghHRgLexygsouM
	 Ol/jeDEjuQkrfzVEChu9IV8yXfX+OOP+JRrKw104NhNCTJzh8WN7aYZ3eC0R6VHVXFQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=GMul4P1V;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.135
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021135.outbound.protection.outlook.com [40.107.74.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81900606A32D;
	Sat,  7 Nov 2026 13:30:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81900606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=GMul4P1V
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sa6fWJYtepRorVYTKB8BM6PT3Xwnj2mFvJRcdZTsgWglbufiS1MF+55/YwY+SPg7otqOm1XcB4AuUsOuHvQlsqH4C+SDcwNMdkWoQPa08SRg3aYi8Wr8yYwKZzh9dzWKtarQIedFFBeAEn9cMBo6tkvKNTcL9o9OOTBZ8ikgAYJzghZnZJ3inn9Y4fk5g4ayja7DzLNK4O/xG+mToJnXcBFjRFkOkgR53VhFzNeCaukq0FOF3wLkB+1+FXCadmvdUhga5kXK77XWZGdNPCpYB4OQ++xBL17Wzl1dbRQVXkrcwt5hYDRBGqZ63qZIJxcgsO28L2WZ+IChWSjvCLGg3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/P/+DmCTrLU5Pw+nTaV4w+qH9EATz3dsofkyNM8H32c=;
 b=vtt8B7BJY1Vzt4Vr0GpMVsEG/C8BoloATsmHipnsV9Wg9M4Azfhsg1ymmYggjrv6WfXuaEvOpN5PVcC8+Z78ppv3UsRpCfWMq7+IU0Ebj8+vL4h95G0rux+xcthmNCdxvEjoTq0nxf0Dtg0NAf70YXSpGHGMXfCodIeBCjnvM3MRkmJCL5HmAs+eMEpDq2P7GCKItOaWyXDNSJ1jcIwn6iTHvHHaQ5LQUexc/vTdvwcHMhp9SbPgP82SacImG6tua8/ZzDia/TdIgZixSyAfchSbTaM6owK9DJrFgZiSh1EOwyLngLwsjlIYwkFJzv8TNGy4+Ejz7aY6uDgGkakjHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/P/+DmCTrLU5Pw+nTaV4w+qH9EATz3dsofkyNM8H32c=;
 b=GMul4P1VmUy9gF6wCPnnjSHGIxqwC5HbyLyxtLp53onM4NhMQjnpQ52YbVdNHvFWF2x73I2bbR+lnrpLyx4c+h+KZ4OJSioOBxyCWtrMAUNlbrC/1Ic/nwhjsGln/GcFkBI4QDBb9oEK5/BpMclqAo1Kri+jvO4/A3HCuAfg8qQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY4P286MB5504.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:25c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 13:30:31 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0592.010; Sat, 7 Nov 2026
 13:30:31 +0000
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
Subject: [PATCH v8 2/7] dmaengine: dw-edma: Avoid resetting an LL on stale stopped status
Date: Sat,  7 Nov 2026 22:30:22 +0900
Message-ID: <20261107133027.364237-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261107133027.364237-1-den@valinux.co.jp>
References: <20261107133027.364237-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P301CA0030.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3ba::17) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY4P286MB5504:EE_
X-MS-Office365-Filtering-Correlation-Id: aacf0368-493d-4022-633e-08df3cd34bba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|10070799003|1800799024|366016|18002099003|22082099003|10067099003|261026140227099003|56012099006|261102123227099003|261028144727099003|261022105027099003|261021121427099003|261009223027099003|261021123027099003|261026121527099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	jAs+xLytDx4cV2raHSlNa+IitTF0z6z7Y1IVqvUAwn8/xRGKFaWYeYwwC4lW/bPKTTwIYHm1lQhTSheeldIH6P9WS8hnS5/sWeOGvt6rH17reaLnSTV37CSllBzLHo3Um1Dzf/9xVd1bZwtVFBmDictURR9r/tZz1LhF4Nn1WDzDU5Fc0jolkiBMtxE9qkTqFcfyQFfZM4HH8z6rPd5cZ4VAdqd/H2Cn5ieTr/DLXuNK0+pMsomjHxCPwQEAaHLbp6E7G3dM5h5XSLVbqo26FXtZ5abAawDXDgQQbK5QoXN04HlaJ4yIar5fZotgD9pEKpx4Cezs5Vt/3LYup0hbkPTVWbxkaOVquZzpaMTerInioMFr9N0YLc/356ZWDJ7rvhKCP4UAnTsnO6L9x8WHtZ43kWkVvSxicXjJbsQrtLnBCv1hUzg21kpgrzm5zn5mz8fHMCJjv7qFuxkjynW1pdRp+XD569Ojug7faRLKIYvEqU3M56WUzTkeCAWv1JfgjKHkNbW+GHc85Kx4pEoSJj5eCOYft5/mioITwiIvYsWgc/SREm4qww3nfAuzqA5jy7d0/bstbF0Ab9pL22VIorRNv+TtQy/qFN0bZd0R7odCjsw+JPReNseDHO0jf3GswMSBRCtrpRyK5IabXnPmUClEJYMEOESSRABeMY6TUMI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(10070799003)(1800799024)(366016)(18002099003)(22082099003)(10067099003)(261026140227099003)(56012099006)(261102123227099003)(261028144727099003)(261022105027099003)(261021121427099003)(261009223027099003)(261021123027099003)(261026121527099003)(261022075727099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OiGuF0kWAoCOii8m6S2xvvwc3zBVWq3+aK/xac10RjLYe9hjGzCYH6STe/yw?=
 =?us-ascii?Q?U2k8a8YWoFXDMB5BkbWLSPRMo2gxFHHARY5bgxIMgvUMPG90WjuQWbyzCEfU?=
 =?us-ascii?Q?QRFPa/j7PhcmNY2+L7Vy5d6CuVtHkWPDIHJ20iDtwe41x7X1/uHYuBAxUom5?=
 =?us-ascii?Q?Ioxvz6rWQQInW3JegAAEDWTjEOHo3V34uP7T5N9vGfQkJZtH0XomFjN0hRVC?=
 =?us-ascii?Q?d/WmsvKuiaH2RsIHIdtS8ps3zcbHijk1dTrhnmOBZNFRqb9Rz1SqGflTDHAL?=
 =?us-ascii?Q?3kmsa71MmeSYAoZojBYET7TtjuIvGKxkZ/GCWDAtgGLOFeOZ4uaQjFFjeiqc?=
 =?us-ascii?Q?elotgE2d1yxc/Q7hl3fC5i6VTjN4ND5SqA1LmShRc8EglPGzJx/QqS1v3Fc9?=
 =?us-ascii?Q?2e9ZisXNVDsZwrHhtgcCcvIWP+/RVv6syTzLpIj9YsTTFE4PJE9edH1jsAE7?=
 =?us-ascii?Q?uqwI8H2zKmnwQbpWVC77Ppmsqc2vLuu410aaqT+MnVIpVOCOAWL1UOYjRS6u?=
 =?us-ascii?Q?IebjNKKMGfRgrRsLgtrQx+/VtHv/nBoCHZbf5u/XELR/KDlcwPKXonVlW3Ul?=
 =?us-ascii?Q?EP5MR49pYgjVwTL+sR4kQFtKXNlMcGfl7PzWf28Dza+HDRbyngo+H6sMl18k?=
 =?us-ascii?Q?ZJtIyFCIfpSpK8C1gkZrzdu4OIo1QabnTBanOSgWyWj1iAbz34iw8kYaZRqU?=
 =?us-ascii?Q?YG8RLqPEAg+mVB2/hFR2IasTjMK/OUA6GVrbWHMX9wrptB49U2wWVUycu3Ru?=
 =?us-ascii?Q?U6x/r0gJQZDekQg86IRINmunqb6qsl3SpazdeliOcPL3UJY1DtOQ8CRETbmD?=
 =?us-ascii?Q?0/x0S+z03cICOXyoIKGqSEIUm6car3zxEYYEPGbQ5P52wp4dzT91fLl33c93?=
 =?us-ascii?Q?EAsIifjeWTON4FpREzHFiX9D8rl+vOI/ozOJGYSvR2/pAngsYSS6/47rtMnp?=
 =?us-ascii?Q?rq0QvGzsh40XT1s70oZ78uPx6R97JKaU32HxPYaLnLhouMJBKrBEvoO1TPHw?=
 =?us-ascii?Q?hQwulJODYJs7dIetp6TqXKfVKZ/8TZoHYls1CZ/jPodn1pZYsd72k/VTf4vJ?=
 =?us-ascii?Q?KOf1d5YGTNqJ8RRB8jLpQI1tZMac9XfE/Ny5y4B+mMqKYOfVDCenw5XePnuX?=
 =?us-ascii?Q?Pvjw2/yFnxQyBAQsGv8xgWQeKNNtRiwwalCJODMHpxLXI7jFMWrMQHOmCtp0?=
 =?us-ascii?Q?eajC8tHHMKbLYs337gRYS2nmu4jfGCdALsppLDPmFfxZiPUnJL9p3kkp1k6C?=
 =?us-ascii?Q?LVculwVeLl/JqS13iMC+BkLKTYxKvbrUaA3K3pCNVck8GgAMhkJ9sH8rhueB?=
 =?us-ascii?Q?42t8/Y07HTNWEOMUnMPqdXfpvHtonne6EcO+/12KxxZaKBY0TVGwNrJmSAxD?=
 =?us-ascii?Q?0MZfZ/4aXx/EJTnc/jzjDCCslVvdQy0PhzoYLVG+JwWR61zI3mm530zzg0gf?=
 =?us-ascii?Q?dug8eBHG6lNnh8NZiDgY0fEWA1/YDNkZDZMlr/O1kZlL3RW0QFqyqiYuNsfH?=
 =?us-ascii?Q?lTvaAjj0O32q/dXUm0lsCdaEHOBpulOrSpr8EQT77ZwPI+rQj1MlEQkwvowu?=
 =?us-ascii?Q?v6UQ3SczOFC+oN1gnSXTlKAGQArYHLGJkgJQXcge6sZoud5t8V5trTYZba78?=
 =?us-ascii?Q?WHxykicAEXlNNv0bJNF/LiNm/6YZJ0EziVLSVPCe8sNRk87ZI2WH9uS50X6L?=
 =?us-ascii?Q?vEc+nQ9pwWu0i9ZzaJh+KWF88QhsycRs0kH6YzR2Zm6MtcfyR/FQslO2q31l?=
 =?us-ascii?Q?Go7pe9gvHYK3GP8ZIvsQxrsJqCSbUd/zdZVj/bX2tE5nNg47oU7M?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: aacf0368-493d-4022-633e-08df3cd34bba
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 13:30:31.6813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5XhZ9KYFzbJJlkk50IeWNQilUlTEsnq+IqEvB4/Vud6+67QFCMV/vaO1MMLUOw4SDbVJJgQLtec9xg3IAD91vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB5504

CS can still report STOPPED briefly after a doorbell write, before the
DMA engine starts consuming the published LL entries. Finishing
termination relying solely on that value can reset the ring while a
transfer is about to start, leaving hardware and software ring positions
out of sync and stalling subsequent transfers.

Require LLP to reach the published tail, on top of the standard criteria
(ie. CS=STOPPED and zero transfer size) before
dw_edma_finish_termination(). Non-LL mode behavior is unchanged.

Cc: stable@vger.kernel.org
Fixes: db79c4e264ef ("dmaengine: dw-edma: Make DMA link list work as a circular buffer")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes from v7:
  - Resample LLP and stop status if stopped to catch progress made after
    the first LLP read (follow-up to Sashiko's review).

@Frank: Dropped your R-b due to the change; would appreciate another
look.

 drivers/dma/dw-edma/dw-edma-core.c | 45 ++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index b08bb31657c9..0c8b9545a5ba 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -146,6 +146,44 @@ static bool dw_edma_ll_pending(struct dw_edma_chan *chan)
 	return chan->ll_head != chan->ll_done;
 }
 
+static bool dw_edma_ll_stopped(struct dw_edma_chan *chan)
+{
+	return dw_edma_core_ch_status(chan) == DMA_COMPLETE &&
+	       !dw_edma_core_ch_transfer_size(chan);
+}
+
+static int dw_edma_ll_read_idx(struct dw_edma_chan *chan, bool *stopped)
+{
+	int idx;
+
+	/* Sample LLP first in case the engine starts between the reads. */
+	idx = dw_edma_core_ll_cur_idx(chan);
+	*stopped = dw_edma_ll_stopped(chan);
+	if (*stopped) {
+		/*
+		 * Re-read once to catch the final LLP if the channel remains
+		 * stopped. If it restarts, later interrupts will report
+		 * further progress.
+		 */
+		idx = dw_edma_core_ll_cur_idx(chan);
+		*stopped = dw_edma_ll_stopped(chan);
+	}
+
+	return idx;
+}
+
+static bool dw_edma_ll_drained(struct dw_edma_chan *chan)
+{
+	bool stopped;
+	int idx;
+
+	idx = dw_edma_ll_read_idx(chan, &stopped);
+	if (idx == chan->ll_max)
+		idx = 0;
+
+	return stopped && idx >= 0 && (u32)idx == chan->ll_head;
+}
+
 static void dw_edma_core_ll_start(struct dw_edma_desc *desc)
 {
 	struct dw_edma_chan *chan = desc->chan;
@@ -455,7 +493,9 @@ static int dw_edma_device_terminate_all(struct dma_chan *dchan)
 		dw_edma_finish_termination(chan);
 	} else if (chan->status == EDMA_ST_IDLE) {
 		dw_edma_finish_termination(chan);
-	} else if (dw_edma_core_ch_status(chan) == DMA_COMPLETE) {
+	} else if (chan->non_ll ?
+		   dw_edma_core_ch_status(chan) == DMA_COMPLETE :
+		   dw_edma_ll_drained(chan)) {
 		/*
 		 * The channel is in a false BUSY state, probably didn't
 		 * receive or lost an interrupt
@@ -790,7 +830,8 @@ static void dw_edma_done_interrupt_locked(struct dw_edma_chan *chan)
 		if (!vd)
 			break;
 
-		dw_edma_finish_termination(chan);
+		if (chan->non_ll || dw_edma_ll_drained(chan))
+			dw_edma_finish_termination(chan);
 		break;
 
 	default:
-- 
2.54.0

