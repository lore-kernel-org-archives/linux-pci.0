Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.73
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794058237;
	b=LoHWBGm59vPLH1yyG3ngSErQnaCVr0t1Pl9RgMy6Fghmz8Z4sGN4Osjbn3acUlMBRlaf
	 IMfTq8YyEizmJxY6uHTNxH6HAo8Yb7bRmzoKowEaXyLN1LVL21VpgHGMY2Umj3OW9LnY5
	 91K7W1QCeH6wqF8wlay1lR54e9rz+Hq7NnySYMnfqpUyIITISuKFE9ym+V5wt4Jw/ceOP
	 Df2PUQrV4TbP8iK2ZSrPp/MGAPtMnNHMT3Qmg9yH4gXoRAZT7KWGL2PWMB9HQDMgvXa5t
	 tTv8+UPSUQBKopf2z3xbJL+unUDiiU58PFP9JWI5BoTWacV/HrbYNn6DpXXVCVK62ng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794058237;
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
	bh=eUTL3M5tKCKWs/hQp4mWsZ+CBR99MAcuJ4TxMVst98A=;
	b=kEqzQ/cLuak8K8CAcEwumxnP3lKg6yAD0RKwOdT2u3IQsaAfsuk6afCOJx4PGO4uOXpw
	 7zGPNRcMWkIO+s8ED668Y0S2kT8Ea4vdU4CDOUWj9sxyI3b7/Hns4QQ41sXt/KIL/2h3P
	 IXF6QFLsFJRQst1dsquShQCrZha4ysU9srH52feqohfRoAc6MfMEq3+JAO1XlwT819MvL
	 XIbRwVHGan6VF93DWAgUn+z6o+AhW/saqObpW1hXaHfz0zxxOeool2hCIJoJFp3PNME1F
	 43vvWZH75BY347uykAKQZTVtMLwqQTEdHbV7DEZC8yyasisV6SDGEy69mBkXRJzZyNQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=Ri2tnSVJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.73
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020073.outbound.protection.outlook.com [52.101.229.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D33606D805;
	Sat,  7 Nov 2026 13:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9D33606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=Ri2tnSVJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YOhIE+RbR7lOq58vWUnrj16Sw91vVckCcfD+CBhRE/8reHEGXWM3ILsbGTkBiVhxLAA9+cT1SkAM057mLdArSizgH1XEiUSW04a1RAb3j4BQjdZQPNF79bJ8pck1DUqqcWLTdUYd4GiECBGXogDDRJBCZ4OLkMTNXEZ+hEO952yFCV0z4DyJW43xhQFG1UC9KpZMQF1kdivre0CRbe03ZLFFc0PIqyV7WqRgXzSvxA8rziklZNONr9YTQDhK2jD6AW9Prrh5rtijXq+NOWoWuLBMmjKpbW0UQtGVLQoWYmweM4sC5mHrrNaydeQJMiXjlMVK/vfEswgF1BCnw2mnwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUTL3M5tKCKWs/hQp4mWsZ+CBR99MAcuJ4TxMVst98A=;
 b=DViHNhL14wO6X+5IQYUPGiJZMeWbL2KRouDnGG+JD3t90uXj1kDX9B2cBemrSq0Lq/njMoB1SiOsQUtGpL3oZUhmOeW4+JhTCjOj0lHLmlS6+RWCSnKWVntrhWQQbr1RD5ZpYFfQ9/IlOEY/B5wvou0KwTdZ0lw+0yjGEdMzwS6QkW7TsgWOHLcKpRXxMgCfR/U6S6zQkZhepWUbJhPuMGnXlpBhWsKTWO/ZoQgIIFnaw2Y1IaPMvI1blpUW4NUKp358MNCsBTJNviyUkWAynYK8ScuNYOVu2bF39ciSBBn6wbO1jkrMc+1tA/nx5EovqHs9IXvRmftxccCQkC/FfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUTL3M5tKCKWs/hQp4mWsZ+CBR99MAcuJ4TxMVst98A=;
 b=Ri2tnSVJ6gYk4BHx9mKcmbtLHBODlwAew/CPVzpbGPy85j1w6vOr18fS7/N/GuuhgS2c+sHn3sWSJMyaA//VYbePzNlZ9OK+6vTQOE5n4cfhQVa7Vk8/XVqm843FiiDpo5iiFRultOtBx4/0q9Rsmb0V3mROKXqMOv8Y23GkKW4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB4518.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2fb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 13:30:34 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0592.010; Sat, 7 Nov 2026
 13:30:34 +0000
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
Subject: [PATCH v8 5/7] dmaengine: dw-edma: Use HDMA watermark interrupts as LL progress
Date: Sat,  7 Nov 2026 22:30:25 +0900
Message-ID: <20261107133027.364237-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261107133027.364237-1-den@valinux.co.jp>
References: <20261107133027.364237-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0092.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::10) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS9P286MB4518:EE_
X-MS-Office365-Filtering-Correlation-Id: aad28d78-d4ac-49df-1b07-08df3cd34d30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|10070799003|366016|22082099003|18002099003|10067099003|56012099006|261026121527099003|261028144727099003|261102123227099003|261021121427099003|261022105027099003|261021123027099003|261009223027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	p/gUbMiKUlQKEjgp3CVk8cM+TmxxZvXKWS3uZeTurxLh8JyN55SssWLEo+SR0oBRXjtWASCHZJF4lZ4XA/bh8YT/h60sTTze5ouqJ2OeBxEJgjM0HrDgLAq2kXuNG/45MBQCoJuSJVIjaKXyrZ6uv1KdPKaoiYVSldnwevARSijw9jcq/7Ihwch78AXN4v4/Acs12earfUpLCXUgxOFOfm1spmncQDTm6mo1U2GrQcMG6p4FooRq4MB0C+YWcCoFk1B2IRRzvMAN/9HyP99Tb86o2qENxO55ygNlNBL/y41MN5xVCTlaAtcBtf8/I3AjTCaSx3z1/yD70klsS5ezGqxNoCeiYM+K8WAh9/FA026xZF4bMvfSMrySydMu/EWzMMJruB/Dug16+vvCDnE4z7fEuTiqsX/tymuh64UhUsTsrBzXpRC9UnECbNUIyQOntS6lqVIdHMrnYNMemJmIjexhqnO90yZyxkhR8aen6F0SrcDgKP5ePHgWhlAabO8gG5+IK5KcG1Amd0gaDeYhIqIqCVPV9CuMz+aOa/McykY8a4D8epifQtIU1Fl5rJ+SnIf0MBBVO8MEdqUGfR0WneRltzs5nNS1lk9WC3CLPT4123fIYX4nQw3yfWE5owApsaQw56KqusoL5Q8C2aFB4ibskIZzqhncLXjOzYCDVAA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(10070799003)(366016)(22082099003)(18002099003)(10067099003)(56012099006)(261026121527099003)(261028144727099003)(261102123227099003)(261021121427099003)(261022105027099003)(261021123027099003)(261009223027099003)(261026140227099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O5g1a1uI4Ow0wEK3e5T3/6CWOycZ3jRV7uJwIvP/qwDTF+JUAcUEVxXaq/WA?=
 =?us-ascii?Q?gyCATYVT4qQC7576UMQl1n9LQq1uz9iZ0RBFoxM1tBg7tbFREJJe2ANgjKqr?=
 =?us-ascii?Q?MKQsqa7UqF9g/srqEx7Y23279TqmIIIEWUmsBEYZOjlou8rSwjCjI9LzIE2H?=
 =?us-ascii?Q?aazPqp7HULpw/nkGphwGHqEB1bFIyaMrNdhN6jDd6XK9syNlTkJhtHrXW/4K?=
 =?us-ascii?Q?5FePFfhKQTkHxfsRaMw8yIHolQWmwlxK53OlvyLkSiHO8TbqJtZQJSrSCiCf?=
 =?us-ascii?Q?rxVxoVE3Hjyd2J04F+QnBoFFfzKXdgFUebYY/OGUkkAroglxLzqovd5QJU30?=
 =?us-ascii?Q?sOO/V058x3QXNSJF1YRc0b/lmT7DbdikkvtZUEczQ4SJloZVnQ6rtnH0OPaS?=
 =?us-ascii?Q?eAmMKF/FGw6v2AqEm5ScPbKZ4ieuPUuxVOBLgKRBnGc/qCdne93+04TJkfYI?=
 =?us-ascii?Q?ffmQl3kX65lEz6zWTXFeNx12JU6VL/BNQ1NoKBjpXIJPTF+bfAs+lzeMlvws?=
 =?us-ascii?Q?uCKwsQhe5ho42v91+7gQY7zKIL8fb2i9TKT45M45P3EKLMPm3SNcghDgRe3y?=
 =?us-ascii?Q?9bHqJgU1UK+zmLKEkG3WfgKuH4zK3WLTwnZn3rinQpBvwB/PU/FyN6mV+gdF?=
 =?us-ascii?Q?JtiNekUX/o8+ZYBD3trCBoE9q8cX5wQJrS8Ys0SrAq8od9GHspf9mkAtAceo?=
 =?us-ascii?Q?DBo8XCRSziHdjQ3CM+YpLu+cvxocevJIbnbBvYHQb4cv8hFnPmCTTU4X1rYj?=
 =?us-ascii?Q?1i9tuQT+ttk8lEPJpYnWBMXKbE9FTZBHyy/rlirBGSsOuLoGksNNoJpO63we?=
 =?us-ascii?Q?w906x6r+659QXznoIKvNpruXnl7XTeLA4Yjw7Ot/QIhV/HV6YoqCDXjfrDjq?=
 =?us-ascii?Q?uFDmTannIk5c95/9rcuhtuJ3ilH90tD9zi55WINaxlQhrW8199oI53/JmAhd?=
 =?us-ascii?Q?MP0vtO50EpYgxBBx0eU4AC6m+zdclIl5TQ5cr7iEH17VEwjYeZCexJiumo+S?=
 =?us-ascii?Q?qjTvOm0XK0UHoM2xPGAcc+VHuxi6CtUi3DXw4rTMu6fdZguiV6WDmTv20FAT?=
 =?us-ascii?Q?a9ayvHUnmnhs1lPTq0sI3ncoDqgUjmu8MKe9Dy/n08AHZ5HEDt66bWpUkxPi?=
 =?us-ascii?Q?PmNP0ybT/I35WQze8Ev5TceIfOoIZXl4weNQA4HlNsuZFjrp31Nt5SPutraK?=
 =?us-ascii?Q?a43VZ4xTf5bNmowPGj/2gERegBscLUICQdKSOUpPiuTbcFLeMUEKQq5gsf8x?=
 =?us-ascii?Q?OgiSHSYYREc/U6I7VuI73jaDpiXN5JBdvnEVwxfOKlzlCK2qOks5nzNNQpPZ?=
 =?us-ascii?Q?cxp4hnPTJJxsgkwpN5VA/QxX0JuoX3PV5XrwneSXYAgP7OH67DZV+hAQEJ2V?=
 =?us-ascii?Q?lN4QPMsA7Ubl8f0vvpXmlzDuRI/xPwzgO3ZL/0Exjz6J+MRskf318ODr0pMM?=
 =?us-ascii?Q?+8fq6E8VSonZ7G0ib53V20mkSR8cJ47NgQBUCISJJoWiu8Hx+/Y9T9sMCctE?=
 =?us-ascii?Q?JaM/oSCFy9dxyGJbnuwZQOmZFYDYLk/lhHVJETTaUU61sT2h31uDy+UEDCnB?=
 =?us-ascii?Q?SgPuTrleAKvXshrvftVpDcqpEtYgx2Wj18W02y8QBaypz14ylaQ1DHe2C6oV?=
 =?us-ascii?Q?sMfc/kwnGsSWh/ZFLSiNYJG2vkSQsF6ZL4DC6fS+ggZEkZysL1sY1GveEKGV?=
 =?us-ascii?Q?FKjoVGKakZaYde2UlbAmpa20QE5zis6pQpDads/y+rs/2mhWdzJFEhDEdIHJ?=
 =?us-ascii?Q?lX0LP5yihDHliaIDVqO8JDfdwaKUR/WCV0Fo+Wxtcc/cH+8eUbOB?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: aad28d78-d4ac-49df-1b07-08df3cd34d30
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 13:30:34.1335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fnOaIo6kdlOyoUDkNvU2EA4lV2CFjOgCYgT1qZ48i3G6s2YN1TzYrQzjWEoJBurokl425UID9jqbpE0yxLnOWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4518

While HDMA is running, DMA_LLP is updated only at watermark events.
Enable watermark interrupts to track progress without waiting for the
channel to stop.

Set the watermark bits on entries that request an interrupt, configure
local or remote delivery, and pass events to the LL progress handler.
Unmask local watermark interrupts only for LL channels in local IRQ mode.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes from v7:
  - Pick up Frank's Reviewed-by.

 drivers/dma/dw-edma/dw-hdma-v0-core.c | 62 ++++++++++++++++++++++-----
 drivers/dma/dw-edma/dw-hdma-v0-regs.h |  1 +
 2 files changed, 52 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index aa430219d0af..0cccd0003a1b 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -58,7 +58,8 @@ static u32 dw_hdma_v0_core_int_setup(struct dw_edma_chan *chan, u32 val)
 {
 	val &= ~(HDMA_V0_LOCAL_ABORT_INT_EN | HDMA_V0_REMOTE_ABORT_INT_EN |
 		 HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_REMOTE_STOP_INT_EN |
-		 HDMA_V0_ABORT_INT_MASK | HDMA_V0_STOP_INT_MASK);
+		 HDMA_V0_ABORT_INT_MASK | HDMA_V0_WATERMARK_INT_MASK |
+		 HDMA_V0_STOP_INT_MASK);
 
 	/*
 	 * HDMA_INT_STATUS.STOP and .ABORT are latched only when LSIE and
@@ -68,6 +69,9 @@ static u32 dw_hdma_v0_core_int_setup(struct dw_edma_chan *chan, u32 val)
 	 */
 	val |= HDMA_V0_LOCAL_ABORT_INT_EN | HDMA_V0_LOCAL_STOP_INT_EN;
 
+	if (chan->non_ll || chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE)
+		val |= HDMA_V0_WATERMARK_INT_MASK;
+
 	if (chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE)
 		val |= HDMA_V0_REMOTE_ABORT_INT_EN |
 		       HDMA_V0_REMOTE_STOP_INT_EN |
@@ -81,10 +85,12 @@ static void dw_hdma_v0_core_ch_off(struct dw_edma *dw, enum dw_edma_dir dir,
 				   u16 id)
 {
 	SET_CH_32(dw, dir, id, int_setup,
-		  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
+		  HDMA_V0_STOP_INT_MASK | HDMA_V0_WATERMARK_INT_MASK |
+		  HDMA_V0_ABORT_INT_MASK);
 	SET_CH_32(dw, dir, id, ch_en, 0);
 	SET_CH_32(dw, dir, id, int_clear,
-		  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
+		  HDMA_V0_STOP_INT_MASK | HDMA_V0_WATERMARK_INT_MASK |
+		  HDMA_V0_ABORT_INT_MASK);
 }
 
 static void dw_hdma_v0_core_off(struct dw_edma *dw)
@@ -95,18 +101,26 @@ static void dw_hdma_v0_core_off(struct dw_edma *dw)
 	dir = EDMA_DIR_WRITE;
 	for (id = 0; id < dw->wr_ch_cnt; id++) {
 		SET_CH_32(dw, dir, id, int_setup,
-			  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
+			  HDMA_V0_STOP_INT_MASK |
+			  HDMA_V0_WATERMARK_INT_MASK |
+			  HDMA_V0_ABORT_INT_MASK);
 		SET_CH_32(dw, dir, id, int_clear,
-			  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
+			  HDMA_V0_STOP_INT_MASK |
+			  HDMA_V0_WATERMARK_INT_MASK |
+			  HDMA_V0_ABORT_INT_MASK);
 		SET_CH_32(dw, dir, id, ch_en, 0);
 	}
 
 	dir = EDMA_DIR_READ;
 	for (id = 0; id < dw->rd_ch_cnt; id++) {
 		SET_CH_32(dw, dir, id, int_setup,
-			  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
+			  HDMA_V0_STOP_INT_MASK |
+			  HDMA_V0_WATERMARK_INT_MASK |
+			  HDMA_V0_ABORT_INT_MASK);
 		SET_CH_32(dw, dir, id, int_clear,
-			  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
+			  HDMA_V0_STOP_INT_MASK |
+			  HDMA_V0_WATERMARK_INT_MASK |
+			  HDMA_V0_ABORT_INT_MASK);
 		SET_CH_32(dw, dir, id, ch_en, 0);
 	}
 }
@@ -168,6 +182,14 @@ static void dw_hdma_v0_core_clear_done_int(struct dw_edma_chan *chan)
 	SET_CH_32(dw, chan->dir, chan->id, int_clear, HDMA_V0_STOP_INT_MASK);
 }
 
+static void dw_hdma_v0_core_clear_watermark_int(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->dw;
+
+	SET_CH_32(dw, chan->dir, chan->id, int_clear,
+		  HDMA_V0_WATERMARK_INT_MASK);
+}
+
 static void dw_hdma_v0_core_clear_abort_int(struct dw_edma_chan *chan)
 {
 	struct dw_edma *dw = chan->dw;
@@ -208,17 +230,23 @@ dw_hdma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 			continue;
 
 		val = dw_hdma_v0_core_status_int(chan);
-		if (FIELD_GET(HDMA_V0_STOP_INT_MASK, val)) {
+
+		if (FIELD_GET(HDMA_V0_STOP_INT_MASK, val))
 			dw_hdma_v0_core_clear_done_int(chan);
-			handler(chan, DW_EDMA_IRQ_STOP);
+		if (FIELD_GET(HDMA_V0_WATERMARK_INT_MASK, val))
+			dw_hdma_v0_core_clear_watermark_int(chan);
 
+		if (FIELD_GET(HDMA_V0_STOP_INT_MASK, val)) {
+			handler(chan, DW_EDMA_IRQ_STOP);
+			ret = IRQ_HANDLED;
+		} else if (FIELD_GET(HDMA_V0_WATERMARK_INT_MASK, val)) {
+			handler(chan, DW_EDMA_IRQ_PROGRESS);
 			ret = IRQ_HANDLED;
 		}
 
 		if (FIELD_GET(HDMA_V0_ABORT_INT_MASK, val)) {
 			dw_hdma_v0_core_clear_abort_int(chan);
 			handler(chan, DW_EDMA_IRQ_ABORT);
-
 			ret = IRQ_HANDLED;
 		}
 	}
@@ -275,7 +303,7 @@ static void dw_hdma_v0_core_ch_enable(struct dw_edma_chan *chan)
 
 	/* Enable engine */
 	SET_CH_32(dw, chan->dir, chan->id, ch_en, BIT(0));
-	/* Interrupt unmask - stop, abort */
+	/* Interrupt unmask - stop, watermark, abort */
 	tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup);
 	tmp = dw_hdma_v0_core_int_setup(chan, tmp);
 	SET_CH_32(dw, chan->dir, chan->id, int_setup, tmp);
@@ -336,6 +364,11 @@ static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
 	/* MSI done addr - low, high */
 	SET_CH_32(dw, chan->dir, chan->id, msi_stop.lsb, chan->msi.address_lo);
 	SET_CH_32(dw, chan->dir, chan->id, msi_stop.msb, chan->msi.address_hi);
+	/* MSI watermark addr - low, high */
+	SET_CH_32(dw, chan->dir, chan->id, msi_watermark.lsb,
+		  chan->msi.address_lo);
+	SET_CH_32(dw, chan->dir, chan->id, msi_watermark.msb,
+		  chan->msi.address_hi);
 	/* MSI abort addr - low, high */
 	SET_CH_32(dw, chan->dir, chan->id, msi_abort.lsb, chan->msi.address_lo);
 	SET_CH_32(dw, chan->dir, chan->id, msi_abort.msb, chan->msi.address_hi);
@@ -355,6 +388,13 @@ dw_hdma_v0_core_ll_data(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
 	if (cb)
 		control |= DW_HDMA_V0_CB;
 
+	if (irq) {
+		control |= DW_HDMA_V0_LWIE;
+
+		if (chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE)
+			control |= DW_HDMA_V0_RWIE;
+	}
+
 	dw_hdma_v0_write_ll_data(chan, idx, control, burst->sz, burst->sar,
 				 burst->dar);
 }
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
index b88226cdd791..e240ffb3dea7 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
+++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
@@ -18,6 +18,7 @@
 #define HDMA_V0_LOCAL_STOP_INT_EN		BIT(4)
 #define HDMA_V0_REMOTE_STOP_INT_EN		BIT(3)
 #define HDMA_V0_ABORT_INT_MASK			BIT(2)
+#define HDMA_V0_WATERMARK_INT_MASK		BIT(1)
 #define HDMA_V0_STOP_INT_MASK			BIT(0)
 #define HDMA_V0_LINKLIST_EN			BIT(0)
 #define HDMA_V0_CONSUMER_CYCLE_STAT		BIT(1)
-- 
2.54.0

