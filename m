Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.79
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793808768;
	b=l8luvQVZiQeaxTEUEjQFno/qVyaejeos6s8r1pC4QnkZTUY6fBviFDmNKQVaoBSAceY4
	 Y2ovgb0adRdjhQ4RdciSIucucVgPnwTm19ti6/WzlJ1YV1okT84JKOpqN77o477fDo5/G
	 e6MVAcztSXN5OW1zbgb7YMQa5pW7mgmVpNyZsQ+HyjqNs0FtBt3Yc9Hv6IfzxG2BukEWh
	 4Ws4JYXjh0A2xKH26Rmy8ZqYNKwCJI09VxzQJGgrhbjkl86b5HtFY4x3Z6t/DTrnHmAAZ
	 Uwnt6/XXKzF+fF0XjlkrKC6AwvXlCtwp5AMrfZ2zayENgACivMCK2sid6Ub04JXK+uw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793808768;
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
	bh=YU53m1mU498nNRBmH9uyTjFATOSHL0/fjoDU5/4Ww1M=;
	b=B7F5khO9ekWmjHdFA+tqbhybm7FxjL8G5A5NDfLQeaqQzGSLpoP0wGtnXlP/QNQOdXj/
	 5hRaQdyFSVeO9BAnpBOEjeeeHk2YBGhxWnJuKH2tAfxymRHU/q+k52utr/gYa6xBU6dJi
	 8gBYmGwj/r/nqCRUEV2b+l/+FzA0Du7Q+Afh7gYvWd7QjXiJMSE7aRcgQVwy9BhAjOOfm
	 aoIze+oTvqJa0KnLUHYWa7tAPT630miqum0kSZPPUAdemylFg6QxETitmW69xYiS8SEAe
	 PgiM/WAgDOOY8wB2p3WoOosmS7w9JLuBxmz797Y5PWaPYwh1+SamcMjFjfWXd0umYgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=lpRR7hBy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.79
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020079.outbound.protection.outlook.com [52.101.228.79])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DEA606D819;
	Wed,  4 Nov 2026 16:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1DEA606D819
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=lpRR7hBy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SHltnhHm0dpA/qeESSmJPM2V65lvCJTLUPh34Oqgv4adva5dOwjkUfWK9yQt8Gv7Hhy3jBk4EWzKIa4P6I7O7XZ4AKgB3OtVwo7ZnjL97htO/trq4rNJ4bVW2Wp9JIQRYhWZvqsg/12Hr+ul0gNPTdUFWnS85zYi5XxYGKv1YwNymiIEbeWk3uCF+qj7H5fRMbq4yBucwbP8zpubN2Lcv2ftxE6arvdGyTuV5jZKRGQnTaTKdMFIn5A0BzzLPcQvLxzESuL7snJbHMvPxpHKo0g/Bib7XHYGEJACZns+IZRLiLgMtKQXhF0rwbh5nVOWZ/gWSMaM4dC3KX2xPqVEIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YU53m1mU498nNRBmH9uyTjFATOSHL0/fjoDU5/4Ww1M=;
 b=uwLsW3kW1+eI0n/aHPjhbxdcsgenVj6xgW9vAG9T55FHAB+AiBkJTtOK9IDUakXRSQ9CziMSgnYHbp7pPRyp65HhUyCtr5eHbSUUonUII4J+Y1uKy3rqWN6BVJX1WL6eD2laDY+xTHYf2vYAHWLauDFzVHUKQjGNm9aUIo/TXZKZXAfBzxGOOPoM8lDkWu0eCzkLodgNysmqXBXiHgb5MuVRMeeUfaEXhvWzVYxtvHejylKNPO6hoDlClouCi0u5TJxKP3/PUOtoRriP9QAkLXKaxpKOp5QwNuOS73Lau1PrZo9vnk8XEW+3USVuz+hsigBDA7Ja9zGuggIJFM96Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YU53m1mU498nNRBmH9uyTjFATOSHL0/fjoDU5/4Ww1M=;
 b=lpRR7hBy0IUmWAG9t7nU7cJnqJjNCzBhR/UZ9KElUcHfzlP0GmAe0H3w/dQHzZYTF6WiMaIf1tXE5V3HbxVsDBx+f9iSjrd+Y/+VyO/YKw3I9eT5HAW0i2UCzZJ6qgG3tEITqLr4XfCTrFRERhtEMhoXwzQtWZshPP81ihdfAvQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB6678.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:417::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 16:12:39 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 16:12:39 +0000
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
Subject: [PATCH v7 7/7] dmaengine: dw-edma: Add trace support
Date: Thu,  5 Nov 2026 01:12:27 +0900
Message-ID: <20261104161227.1742005-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261104161227.1742005-1-den@valinux.co.jp>
References: <20261104161227.1742005-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0029.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::16) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: a4abe857-98ca-42e1-a151-08df3a8e729c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|23010399003|1800799024|366016|56012099006|261021121427099003|261009223027099003|261102123227099003|261026135527099003|261026121527099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	QH5XlXqA2PbVwDObIqf0p0dKYKbMtWhW2B2yRsXfbHsSAn7D6CYPNkzs536WJxJuOOt4NCFTjvNw25m6lCiwjTIwQhxo4IwA1gQP8hETRI77TFrJQ6U2rG4hfncPT+0bya8FiytCzmuvcpHIsugHycZQJQOnlcWu4hx9oggFWln5g3e0/zsUHReEyV9JySXLKH3Pcq9yYyZl5lgr/Fn0bbHVT2BKKdaoNLlWKEta4gL6pvRFBAB4qNlabRS5TJUVCGrl8yw/7JQEdZsR+N4H6kxf0miZvT0TrnhaB2qR2+YJo43OECxvP7ZPi5J5czOTzfEbNs80SGbCB1rrZM5WJYk5mxlut2Zg6/vrREX7FwfaUiWEc4C7fsRHUc5xHemcgQNKrr1PgAMa8eoAyJIGuGl+PmEE9YipxHm7ID5k9FdTonOIPh9Stw+MrS6FgWBk5cITZMEz0UtYXAAQJ9W8fSDkh1+AAgq5U/dNb71pM//ZBA4+2tq2BnpkXotowWX+cBuuVuo3VtbSeDDMk4VSyS7GInM/RCev4zbml4uY8FGJ/pFq9w4DBnbrMAWI1+vfxv64nMnd/JR3i/R74xccl9LBUyBm6sEao2YYDCrIa2dL3VPnjxPOudiIquC97SGZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(23010399003)(1800799024)(366016)(56012099006)(261021121427099003)(261009223027099003)(261102123227099003)(261026135527099003)(261026121527099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K+t3rg6v34ivGl1U3WKBLiEVIDWY0JMNfGiDo+Yn8Jzdkq2c6fWkP0Ep2NfL?=
 =?us-ascii?Q?nQ9fr5DxS/PdmTt9WsP5q5ue+nt9NlRcCDuR530BhXSL8jU8APORW091/9Mo?=
 =?us-ascii?Q?W8g13g8bIdF3Krc+kZgd9IFTyu5+aRcG7gVIWDeeGgwbTEjUjd8Zs0uNw8Gl?=
 =?us-ascii?Q?CEH+c1R0T/2jiQt5nfKvNP51SspVMpYt1WKWcjkMWxtewiFNm6bxqYFh9XdN?=
 =?us-ascii?Q?/xM59Y7lT6F3LLc/uX64j8yXSQLrd1weHoYXslFwOM1dV7iMr8OfYWC+cZ/2?=
 =?us-ascii?Q?Z/1stcQtUsD2XSX3lZJI/a8jpZGCP4mKFEv85jDH9m5zs9mnc4fvPsnM8pSy?=
 =?us-ascii?Q?JdBKj7knAqWRrhU6jelVq0/6ED5z+RrrnPGMOT/DxM0JAHpaDAx0gFDnxPLK?=
 =?us-ascii?Q?waD440eY3qn4IzwIQ2pTr4Wycz52pdQaHAJXSOd0PxSGKCvJMztRJhxqJ/XY?=
 =?us-ascii?Q?p8hstOEOUH/uWM02WRkvdJksWW5i0ujw/fda8WaqHJ5zq5COAqUS4EWiSZYt?=
 =?us-ascii?Q?2nejml2lr02joKSkB+WqjCR6vN4o5TTko22k6dxXruMuILVbB6/IMh+CYgsU?=
 =?us-ascii?Q?ZQ6Jc6iJp3ZE2aDlKlU6nxa/+4V1yYzZyeN2Eupnfw80ZKuaCeZT2hCPfBid?=
 =?us-ascii?Q?y1wcdTwzPqr4pxcnwLJyIN6ZNU4Tzx9/zWpRxXW2747YwnHR6r8ETYQB3Omi?=
 =?us-ascii?Q?3ZfwXU0No/Ys1oEnDMUq5Dg3Tmp910SJHIxArecgl+7XN3A3V4a/hTuz+wii?=
 =?us-ascii?Q?UdmXBimVmVZMeq4mpWpcuh2IuXZBR0xLukIRku9cqemPj9/MxMz85sn+Ipxh?=
 =?us-ascii?Q?R2CV9VlaKH9ztQ9TFq0uHGkfqG1DuZcj/M7HfPX2MwU4I7Gdis6hO3c3nzKY?=
 =?us-ascii?Q?od9RSJ5BYl8B9FmpD/B2zwIijHLPTWHTVcYoZdGtDhVG+c8Cbvrc6xdu1RhG?=
 =?us-ascii?Q?QzBH0/at9NbCOYJIs4nfL9v2b8mRc3hAz3fsAKwFNSdumy8YzOCERMl1Yflz?=
 =?us-ascii?Q?IHpy8AeqRPZvAPBWenXhSSpVKcPdHCCO7HLxccPYvM6bCtQkYeIlQI37R6gI?=
 =?us-ascii?Q?+2XjCh8E4caoLy+zaytQsaHyNrY9iekCNP5FdrbyCQBbXhXnoEoClHnjJ1sF?=
 =?us-ascii?Q?7heIe/NZSw/YVFYOCUAcPTHLGU5yWeWiOkk2OJ/kuuR/5o/2hf6zdGpdCQQ6?=
 =?us-ascii?Q?WDWdV4F7ENYzwUvk+pHwE8p2ijx7aVCoYAGSYkpvKqR7tvSlgNZ01WggBaxT?=
 =?us-ascii?Q?X6Y5D1CoaAsMJnWIV5Uil4lGoKB92/oFKJiQmA/b6jD9BkytwrjZvarWdTGX?=
 =?us-ascii?Q?tFK0BT6+g1dS/YbxZCECkVyaQNJ4rtDgQGVuL5fj0LxbyeOicTVLY/re1LAW?=
 =?us-ascii?Q?jBuEoisttp2eDpJceHIE+hWGo1tcuAoeqXVKKFfPLNy9o6469S8t1BJZd8ef?=
 =?us-ascii?Q?ZEXzh9ehNu24b6u2EuYcJQSP3I/xk4m8rt/P96+SELvkVEg8HVxxeKffui72?=
 =?us-ascii?Q?uaj+L7Rp0KCyrKno1vVTVzune4tchnwW3mldFvcKRnqSBqGUOE3LOXyjX4Hw?=
 =?us-ascii?Q?DPmKd98GUfQvBJfrEC9iEcQMzdBCKETrA3+Z3jhJgOOWZ8AXEMvyTxUOcaTK?=
 =?us-ascii?Q?k1NVKZjHOrH0j8X6P/XP0SG2zorYRYZ8lO3x0HQ2/V0EZ1JYnNar3z8Csf5c?=
 =?us-ascii?Q?NvnOgcNNd1rZSNJHBaR4Rmshu8Dcya/WupwqOjvCcX+k/ma1kWV6gR1PsERE?=
 =?us-ascii?Q?BPbR+z4obGPcFRLSRWbQO/vO/lsoia70sNwsdl1veY/wyVq//kpP?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a4abe857-98ca-42e1-a151-08df3a8e729c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 16:12:39.3358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 511rda9+Ijmm9oqXGaHyRdQtrjWP/y4rfPXlMQzYOR+obfFJPkVUFYpP8v0YpbmWxJVOBERkYz0+dJEQJokpSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6678

From: Frank Li <Frank.Li@nxp.com>

Add tracepoints for LL publication, descriptor append and completion,
and doorbells. Record channel and ring indices to help diagnose stalls.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Co-developed-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes from v6:
  - Use the dw_edma_ prefix for the event class and tracepoints (Sashiko).
  - Link to v6: https://lore.kernel.org/r/20261030150742.2586776-6-den@valinux.co.jp/

 drivers/dma/dw-edma/Makefile        |   2 +
 drivers/dma/dw-edma/dw-edma-core.c  |   9 +++
 drivers/dma/dw-edma/dw-edma-core.h  |   2 +
 drivers/dma/dw-edma/dw-edma-trace.c |   4 +
 drivers/dma/dw-edma/dw-edma-trace.h | 117 ++++++++++++++++++++++++++++
 5 files changed, 134 insertions(+)
 create mode 100644 drivers/dma/dw-edma/dw-edma-trace.c
 create mode 100644 drivers/dma/dw-edma/dw-edma-trace.h

diff --git a/drivers/dma/dw-edma/Makefile b/drivers/dma/dw-edma/Makefile
index 83ab58f87760..5f395fa1ede4 100644
--- a/drivers/dma/dw-edma/Makefile
+++ b/drivers/dma/dw-edma/Makefile
@@ -1,8 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 
+CFLAGS_dw-edma-trace.o		:= -I$(src)
 obj-$(CONFIG_DW_EDMA)		+= dw-edma.o
 dw-edma-$(CONFIG_DEBUG_FS)	:= dw-edma-v0-debugfs.o	\
 				   dw-hdma-v0-debugfs.o
+dw-edma-$(CONFIG_TRACING)	+= dw-edma-trace.o
 dw-edma-objs			:= dw-edma-core.o	\
 				   dw-edma-v0-core.o	\
 				   dw-hdma-v0-core.o $(dw-edma-y)
diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 69b5488282de..db850ceea82e 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -236,6 +236,7 @@ static void dw_edma_ll_consume(struct dw_edma_chan *chan, int idx,
 		if (desc->done_burst != desc->nburst)
 			break;
 
+		trace_dw_edma_complete_desc(desc);
 		dw_edma_complete_vdesc(vd, DMA_TRANS_NOERROR);
 	}
 
@@ -262,6 +263,12 @@ static void dw_edma_core_ll_start(struct dw_edma_desc *desc)
 				     chan->ll_head, chan->cb,
 				     i == desc->nburst - 1 || free == 1);
 
+		trace_dw_edma_fill_ll(chan, chan->ll_head,
+				      desc->vd.tx.cookie,
+				      desc->burst[i].sar,
+				      desc->burst[i].dar, desc->burst[i].sz,
+				      chan->cb);
+
 		chan->ll_head++;
 
 		if (chan->ll_head == chan->ll_max) {
@@ -315,6 +322,7 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 		if (!chan->ll_valid)
 			dw_edma_core_reset_ll(chan);
 
+		trace_dw_edma_append_desc(desc);
 		dw_edma_core_start(desc);
 		ret = 1;
 	}
@@ -378,6 +386,7 @@ static void dw_edma_core_ll_sync(struct dw_edma_chan *chan)
 static void dw_edma_core_ch_doorbell(struct dw_edma_chan *chan)
 {
 	dw_edma_core_ll_sync(chan);
+	trace_dw_edma_doorbell(chan);
 	dw_edma_core_do_ch_doorbell(chan);
 }
 
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 84a811bdcb6d..769c0c08a711 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -154,6 +154,8 @@ struct dw_edma {
 	const struct dw_edma_core_ops	*core;
 };
 
+#include "dw-edma-trace.h"
+
 typedef void (*dw_edma_handler_t)(struct dw_edma_chan *chan,
 				  unsigned int events);
 
diff --git a/drivers/dma/dw-edma/dw-edma-trace.c b/drivers/dma/dw-edma/dw-edma-trace.c
new file mode 100644
index 000000000000..2620ad61a943
--- /dev/null
+++ b/drivers/dma/dw-edma/dw-edma-trace.c
@@ -0,0 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define CREATE_TRACE_POINTS
+#include "dw-edma-core.h"
diff --git a/drivers/dma/dw-edma/dw-edma-trace.h b/drivers/dma/dw-edma/dw-edma-trace.h
new file mode 100644
index 000000000000..0b199ab30b9a
--- /dev/null
+++ b/drivers/dma/dw-edma/dw-edma-trace.h
@@ -0,0 +1,117 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright 2023 NXP.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM dw_edma
+
+#if !defined(__LINUX_DW_EDMA_TRACE) || defined(TRACE_HEADER_MULTI_READ)
+#define __LINUX_DW_EDMA_TRACE
+
+#include <linux/types.h>
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(dw_edma_desc_info,
+	TP_PROTO(struct dw_edma_desc *desc),
+	TP_ARGS(desc),
+	TP_STRUCT__entry(
+		__field(size_t, nburst)
+		__field(size_t, start_burst)
+		__field(dma_cookie_t, cookie)
+		__field(u32, id)
+		__field(u8, dir)
+	),
+	TP_fast_assign(
+		__entry->nburst = desc->nburst;
+		__entry->start_burst = desc->start_burst;
+		__entry->id = desc->chan->id;
+		__entry->dir = desc->chan->dir;
+		__entry->cookie = desc->vd.tx.cookie;
+	),
+	TP_printk("chan %u%c desc %d nburst %zu start_burst %zu",
+		__entry->id,
+		__entry->dir ? 'R' : 'W',
+		__entry->cookie,
+		__entry->nburst,
+		__entry->start_burst)
+);
+
+DEFINE_EVENT(dw_edma_desc_info, dw_edma_append_desc,
+	TP_PROTO(struct dw_edma_desc *desc),
+	TP_ARGS(desc)
+);
+
+DEFINE_EVENT(dw_edma_desc_info, dw_edma_complete_desc,
+	TP_PROTO(struct dw_edma_desc *desc),
+	TP_ARGS(desc)
+);
+
+TRACE_EVENT(dw_edma_doorbell,
+	TP_PROTO(struct dw_edma_chan *chan),
+	TP_ARGS(chan),
+	TP_STRUCT__entry(
+		__field(u32, id)
+		__field(u8, dir)
+		__field(u32, done)
+		__field(u32, head)
+	),
+	TP_fast_assign(
+		__entry->id = chan->id;
+		__entry->dir = chan->dir;
+		__entry->done = chan->ll_done;
+		__entry->head = chan->ll_head;
+	),
+	TP_printk("chan %u%c done %u head %u",
+		__entry->id,
+		__entry->dir ? 'R' : 'W',
+		__entry->done,
+		__entry->head)
+);
+
+TRACE_EVENT(dw_edma_fill_ll,
+	TP_PROTO(struct dw_edma_chan *chan, u32 idx, dma_cookie_t cookie, u64 src,
+		 u64 dest, u32 sz, bool flag),
+	TP_ARGS(chan, idx, cookie, src, dest, sz, flag),
+	TP_STRUCT__entry(
+		__field(u32, idx)
+		__field(u64, src)
+		__field(u64, dest)
+		__field(u32, sz)
+		__field(u32, id)
+		__field(dma_cookie_t, cookie)
+		__field(bool, flag)
+		__field(u8, dir)
+	),
+	TP_fast_assign(
+		__entry->idx = idx;
+		__entry->src = src;
+		__entry->dest = dest;
+		__entry->sz = sz;
+		__entry->id = chan->id;
+		__entry->dir = chan->dir;
+		__entry->cookie = cookie;
+		__entry->flag = flag;
+	),
+	TP_printk("chan %u%c %d [%u] %c src: %08llx dest: %08llx sz: %04x",
+		__entry->id,
+		__entry->dir ? 'R' : 'W',
+		__entry->cookie,
+		__entry->idx,
+		__entry->flag ? 'C' : 'c',
+		__entry->src,
+		__entry->dest,
+		__entry->sz)
+);
+
+#endif
+
+/* This part must be outside the header guard. */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE dw-edma-trace
+
+#include <trace/define_trace.h>
-- 
2.54.0

