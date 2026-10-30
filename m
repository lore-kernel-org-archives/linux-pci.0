Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.82
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793372875;
	b=pvThVbd0ub66R/lG2NVuMnUVY+Djg96wnRslhw16rWjUOweZM7T0YXZJ+dxVLn0RM7Jg
	 Uy0dNv99/6wqgGruD6kCvAojyEn0oWc4FzKcRSRaioZIxYhGQeUqQSpGHoM9vDGO4b6Yh
	 JJHfW7x0q7YmOYBkJh0gq1lczPnL+cGjgxLYFNCebJghzOYVbXNUzL3EWqkzLhyGG1/HI
	 wCq7SwdBjP7dI0b1E+lRc6yO8Wb1RfP0rY5Q3YVrXVY8x+ipkKpqYMLj4EiggSBFuYFJK
	 kf7FwwuhfDAg2p/8ZUxbV+eg4Olo8QqPh2JeUWtc45eL0eooTqOsvwQeg7t+DT3IS8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793372875;
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
	bh=GMXM1apcpE4/d9REZuIG/H/TEai5OXsLAxNRRzLIJpg=;
	b=xlguJgLNcWIyQY4UPMIvLyhD8uWte+AQH5BWoKYlaVPGYydX5ErgUUjOy1DMzSR5BNHp
	 njQ8C+HRweuyGNd7DKMTPR+buUOtd3AK33borvucFja9IL+U78XpcsgKphHQsW/D4gA3d
	 7scBy/O+POhsoTD6PxRG2usQiO60El4xWYs8XTBXcuTNos4xt6ikyrJSL5WekwDHxISqZ
	 tWyWqV0wcYd1PVZCUMyfEQxuiCHA3hc6EqvDmhnf04nfgTbhiKxtsJLrPzjWsBEdyZ18Z
	 6sm7rRm9H5M8nK0nzMh4S127sek+YQmwkQG7aD3lh9Agv2TQFefgEHf2wNhs7KvlEqQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=h2rn+ono;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.82
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020082.outbound.protection.outlook.com [52.101.229.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5E5606A323;
	Fri, 30 Oct 2026 15:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A5E5606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=h2rn+ono
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+fnmp+DpaUUmzPYyScTj3NXeqSWzcM9DSkqOqRma6viU9XFDpe0fpKdewe//AvnR2bVhGBaGjNP+t2kdrozDNwy7ZEQwfHWaJVWELsVoA7MH5gM6jzNbLYccr/tt7cA8XhxZrGGl49MRvbxuMRmRY2EWenmB89mvEJIQ0Hjm/r6ud0weLjxuc09o1pqiM7LADbeapaqLk14fyzMRW5jxvgdYVqiUa2pHfx7/1jm8pLWtgtELjSxN2wDIOquy1i29AOtwdY1DV7SOxPo5GEErOJ7AGxnh5ammxqLzCm6/9eUZiQBNCUkSZc2bNTDfIh1jzmpz3hgNaR2B/i+Xy9DfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMXM1apcpE4/d9REZuIG/H/TEai5OXsLAxNRRzLIJpg=;
 b=ZdKm6APOIgLv//TO7ZwzyCtasVBE2nZKxqSqGqWvlgXL3S1zj9csKoLB4EPDy6FLN4AtvJsCkPWGsYHfFPAt4UaK3YYazyH/cuFlFVhPoSyyXxa+ZlC6H66PHJBCZCZLMKSNuB9XQI4LyxJUhO5DChAmsRt8YGhfUhXcx+9VyP+yw/y+j/haiN3AgqIUF1v+8Ysu4WEq2HzAV1pE01m+pBZabd7t/rQ3kM4NxH9bcMbpQSQHIF1RBmXFSskatkSwCU8uGy0XyKhI3s5gKGze9yFHOShqT9IVvxgiOQWS1KAWnDl1CVFNKNm5SJFfJW6d9zVyBmOacDSP2qIPUexc8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMXM1apcpE4/d9REZuIG/H/TEai5OXsLAxNRRzLIJpg=;
 b=h2rn+onoNU1qLp6COVYne74a/tOuJK/4+NviF20FUkrJAAqGM8u+arkFBlH6qRYtOtCHNX9vMK1hbqwO7JW6EyrD6/+SaYZLqYDeHXaTvwFrOUdeq0oQEt9Qobn5BUKeRyUcqD6KZO0f/bMhWPstC4sL0t4Am7P9MfARSHR7Uv0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS3P286MB2389.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:150::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 15:07:51 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 15:07:51 +0000
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
Subject: [PATCH v6 1/5] dmaengine: dw-edma: Add a channel transfer size operation
Date: Sat, 31 Oct 2026 00:07:38 +0900
Message-ID: <20261030150742.2586776-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261030150742.2586776-1-den@valinux.co.jp>
References: <20261030150742.2586776-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0127.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::9) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS3P286MB2389:EE_
X-MS-Office365-Filtering-Correlation-Id: a2ddbc01-3955-4b57-34c2-08df36979142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|376014|7416014|1800799024|366016|56012099006|261009223027099003|261026135527099003|261026121527099003|261021121427099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	zdh559dxPSSCZlVS2ASn8QjN/zyH1EZRiBplx+NNsJ5VCIHkdNAP2KtzjNJxn1IwlQEu7dmG/7SJ5mDOTigi6zqXqIRSBzVJJzJZ2DlWlAHPpmuhSLY6APb5kcZEz+bn1EnY3j5omCxRGQaAt2ALVdC6wG9gjYamQlHZR12lR/E1+/POrnGqtxFrU4ycUmSJm44C+OzCH4I2G5jwocJeaA45YPPoPBZ2LZ4qXuEpKy8LR9gr/ctNGTzLP2Lt6vh3DkGfO1+bcTOevbYS5FojwZ5KLkZX3T/q+MJfFlFezhmzu9oYpTgt6W/vEmZUFQdN2R724uGKD5aBx8NMm2oDfXAZfS5KibYuDUCQkcxA4DZ12B2ZXYZtox1wDdtVYcdzdF6IqwHxcC4AK7ppXo+BLxPV2+n/YpgaHL/I52sONiM9q10bu5VtJrvH8fqKjrAzR5D/qVUGgJH1xzrag0Ql9FLR0Y+TNOFZSqMWhvn900I5ebukDe2TZjNTQXtwXayU3KI8tVz/mxm8qeKY3HVe7DEFfRlOTNwi6qRG4vxXmuH/PLqvfK8H6nWrLHMnd9if55bzvGGXB7F7VRTdg9pW0wRSKoEKRjEjxZbXPcO5ouo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(7416014)(1800799024)(366016)(56012099006)(261009223027099003)(261026135527099003)(261026121527099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a5v2d3nLznXEr1AsFdqIuP8M2i707GarAUvtjEOdw5YpAjzlvPplnPm8Opvh?=
 =?us-ascii?Q?J5jzR60ifowDTSlzUhIZPzwJ1e8WTTU3v/Er2VEPEm4z+qeA1tUALdFzDfIC?=
 =?us-ascii?Q?9b5Xhi4oiQXOfVkAUuLiytzWPcDjgCq3iAtERrSDqF04Wc6EBVLIfVvnbm6E?=
 =?us-ascii?Q?mPOfLOM4eU9JCkNniaA+Thilulb73VfnBXgGmPSRc5eLZc4y8H6c34rxYYXe?=
 =?us-ascii?Q?O64ylea+7tXMzZUEvjjON7YQsZBrqG7vLQed4Rmp4+D21ybeOn/mERCbbnSv?=
 =?us-ascii?Q?+EuayiUVdX+ZPerbxkFpEKuzb1o5yPJ8ujC3K8K/EvfiEgub+iPeVB5JsUTr?=
 =?us-ascii?Q?xvU/jkEuZH+p9f6foNHsiSSVOawP+LG1vy5yttL/Q3rfBk+8pXvAQQhWlG0M?=
 =?us-ascii?Q?KdRAelrmhnALvzaQkd9CnMkCWhXLPM0i0RdvW9d0Ezn8CR3Dd82xyjsWJqfz?=
 =?us-ascii?Q?eQaplHreMQr7x365Y/8E9QPPnmvSGWb8m2SmSM24Co+Fdi3IuirCip5FGsB8?=
 =?us-ascii?Q?W+Az8WhfZJgJLljyv4kIanF/9X6H6keCAAJjsDHxCp4IQXS6l2v6hbaDOsdG?=
 =?us-ascii?Q?HMzE7hccvyGJf51B0fHs1nitkWn1wOnMRSMdhNNWOD2UrhZyA0l5M80xqYNS?=
 =?us-ascii?Q?DSCMSke4sK+ZIeRRqjy0yRpxQEMd5lzjg7SSDY8AsQ2xRMlDvF+lc66DrW03?=
 =?us-ascii?Q?NgN81CPUvoLE5J2HuVj7iwyfQqwpch2PV8NlhKR/rdpYdXZHgE6frZy2joNr?=
 =?us-ascii?Q?8ZF7D3ic65qjV70drviRncj3nypx5tdcuk8gja4gNvwM9l4Qyg5irQWyrtfv?=
 =?us-ascii?Q?TY6Yvlm39uFSnTr1JUEyiYVm9C13sOrAmRQnZGuYIw5+G/w7td/9iEovgsjS?=
 =?us-ascii?Q?CihUA1c0hAFsw8P2caKpQ1pH6CVjUKH8CS+ZXdNCtlbEqsDtverOeaVOjars?=
 =?us-ascii?Q?UEEeNDuedt9SqdHgg9LBsY1eyC9fwj5+wSIn2JoRZxoWL+Wyrty3QFEZgMQT?=
 =?us-ascii?Q?OUMCzlkSk2F+ke12Nxj62WFpOd0Mph1BYWxOWPNAqiDApQ1XDWBcXRrUhJ91?=
 =?us-ascii?Q?0oeQn+9EYIjVbKorjESvzXc6AGXnzUaa7b4yl/61m0Y4JS4UA91UKKgXTTCM?=
 =?us-ascii?Q?Vk1AkFZjwP4ie2gUFQqoifNYA/0LYxFYhohtGT0kW7Tm9W7c9t3Kg8GuQ9XZ?=
 =?us-ascii?Q?Sd++kEELXumSrp2zrU/4oBhXNG7Gsjnjka0AZWq+2g+2aEr12DTUQ8nqbYUa?=
 =?us-ascii?Q?klHkCwlkIX1u2rzY+5J/k+pw/YfUkb1eEwnKoxC4dO8cVRBXhNgKf3pfl8bz?=
 =?us-ascii?Q?79DSjuiQOHn4jtb/6FnLJNXl4nV5xkOCg+nJ4DGb5FhEQsqpeCW7ROM7LDFi?=
 =?us-ascii?Q?gRtKBeHi9ZV0X9WUT4DMrkT7goTpCxqKmXU9kDNsdSV3zueUo2TKtVNLgeGp?=
 =?us-ascii?Q?1lSLqxcP8FW4jhG26IadJE2DjfzN4h8tA9Tpzb2B6e7BCjj+aXRkoykARKrx?=
 =?us-ascii?Q?jEaBqB4VS8rfEfpJomAMlC/U+6UsvTuoyCQvYF8hCs/gwgeOkaAH6dGqd/bi?=
 =?us-ascii?Q?sBtys4Qndi5O72KYlnzVRreagMAJ3GC+t3UXT/SJQLbF5wpu+sz7c2qKZ7j+?=
 =?us-ascii?Q?2Oc7UfpuQHgU8SNxOwhuTaDfPJ4IRcSRzdgea9c+Z4gPobZA8rue8JrCuNT1?=
 =?us-ascii?Q?PQIiwdFB35aS6+M5MaAnwQi8NJHGpyXUt5ISQJ8/kbMVoERwrsiE+rGQg/zH?=
 =?us-ascii?Q?wH5XSR8RIhkNATUeW+OWzG20w/AGyo/FjDpNXYob4+5iktkAS0rn?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ddbc01-3955-4b57-34c2-08df36979142
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 15:07:51.6102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +UJ51Y8Dyoptm63m2J6Xcl4MpTCpWlrCqG2UTGDzDqVWGNSzJiWFbumnjw4g9ILkF1G7a8QQwIjvNIqKfGQSxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2389

Expose the channel transfer size through a core operation for eDMA and
HDMA. LL progress handling will use it to check for a stopped channel
with no payload left to transfer.

PCI Express DM Controller Databook 6.10a-lca06, section 7.3.4,
"Detecting the End of the HDMA Transfer", documents this polling method:

  STATUS field of the HDMA Write/Read Channel Status register
  (HDMA_STATUS_OFF_[WR|RD]CH_i) is Stopped, and the HDMA Transfer Size
  register is 0x0.

The same condition applies to eDMA as well.

No functional change on its own.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Split from v5 patch 13:
https://lore.kernel.org/r/20260812155721.2807506-14-den@valinux.co.jp/

v5 used native HDMA's STOP event directly, so it did not need an HDMA
transfer-size callback. v6 uses channel status and transfer size to
identify stopped channels on both backends, so add the HDMA callback too.

 drivers/dma/dw-edma/dw-edma-core.h    | 6 ++++++
 drivers/dma/dw-edma/dw-edma-v0-core.c | 6 ++++++
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 6 ++++++
 3 files changed, 18 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 76fd5a41a707..84a811bdcb6d 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -163,6 +163,7 @@ struct dw_edma_core_ops {
 	int (*ch_quiesce)(struct dw_edma_chan *chan);
 	u16 (*ch_count)(struct dw_edma *dw, enum dw_edma_dir dir);
 	enum dma_status (*ch_status)(struct dw_edma_chan *chan);
+	u32 (*ch_transfer_size)(struct dw_edma_chan *chan);
 	irqreturn_t (*handle_int)(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 				  dw_edma_handler_t handler);
 	void (*non_ll_start)(struct dw_edma_chan *chan, struct dw_edma_burst *child);
@@ -262,6 +263,11 @@ enum dma_status dw_edma_core_ch_status(struct dw_edma_chan *chan)
 	return chan->dw->core->ch_status(chan);
 }
 
+static inline u32 dw_edma_core_ch_transfer_size(struct dw_edma_chan *chan)
+{
+	return chan->dw->core->ch_transfer_size(chan);
+}
+
 static inline irqreturn_t
 dw_edma_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 			dw_edma_handler_t handler)
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index c053cb4c2844..fa8be85c7ac1 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -318,6 +318,11 @@ static enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan)
 		return DMA_ERROR;
 }
 
+static u32 dw_edma_v0_core_ch_transfer_size(struct dw_edma_chan *chan)
+{
+	return GET_CH_32(chan->dw, chan->dir, chan->id, transfer_size);
+}
+
 static void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan)
 {
 	struct dw_edma *dw = chan->dw;
@@ -665,6 +670,7 @@ static const struct dw_edma_core_ops dw_edma_v0_core = {
 	.ch_quiesce = dw_edma_v0_core_ch_quiesce,
 	.ch_count = dw_edma_v0_core_ch_count,
 	.ch_status = dw_edma_v0_core_ch_status,
+	.ch_transfer_size = dw_edma_v0_core_ch_transfer_size,
 	.handle_int = dw_edma_v0_core_handle_int,
 	.ll_data = dw_edma_v0_core_ll_data,
 	.ll_link = dw_edma_v0_core_ll_link,
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index d42cb4ad49a2..aa430219d0af 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -156,6 +156,11 @@ static enum dma_status dw_hdma_v0_core_ch_status(struct dw_edma_chan *chan)
 		return DMA_ERROR;
 }
 
+static u32 dw_hdma_v0_core_ch_transfer_size(struct dw_edma_chan *chan)
+{
+	return GET_CH_32(chan->dw, chan->dir, chan->id, transfer_size);
+}
+
 static void dw_hdma_v0_core_clear_done_int(struct dw_edma_chan *chan)
 {
 	struct dw_edma *dw = chan->dw;
@@ -425,6 +430,7 @@ static const struct dw_edma_core_ops dw_hdma_v0_core = {
 	.ch_quiesce = dw_hdma_v0_core_ch_quiesce,
 	.ch_count = dw_hdma_v0_core_ch_count,
 	.ch_status = dw_hdma_v0_core_ch_status,
+	.ch_transfer_size = dw_hdma_v0_core_ch_transfer_size,
 	.handle_int = dw_hdma_v0_core_handle_int,
 	.non_ll_start = dw_hdma_v0_core_non_ll_start,
 	.ll_data = dw_hdma_v0_core_ll_data,
-- 
2.54.0

