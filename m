Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.82
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793372884;
	b=HTZvxb6dr1G8WMOGkSRih9IfjpR/Xm6I4ZdA88QvAaXXwshWDMkWsPU6l4dCC5v9ApPA
	 98iekV8F4AzaR0KVY0b7/4dFgcjsmFvrsKIUQywUXsO3CCMUdbNpJy2Y5k8YrZk7zCT7g
	 hvbEz8Oc5RqBwruphImE0fmx598WLFVO6I19kp7XFlBOjspUlk1kUxQlKxR9DlRfPIu75
	 rKXtjVZcffVRsN2Itfz2bVxo+eCua+oS4yTsXC4RyrSFC2FltbeeCLRZbT1BQ4Xpchz3J
	 BKlKtcunsKhS8x/8nOAT4m3n6s50h9K50x8nGz9otqkUYPhAlfV3rxjHVlFZqW00WCQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793372884;
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
	bh=MErFWj1ajQwST9qYyk/vBLjOoKZmuN7mnEQpppbbc7A=;
	b=kD/f+XyqujFh7iQVq/Yk0rVoO+/cAl9SdANyWwE5R/g28UizEC15mmlUpI35SWTl1Cad
	 14ZDXh4h9tZ1GIvN2iT3mTdU8yaODTJkF4Gm/i+qlZfoikBYX17/QU7VNdrQmRkseRQ/u
	 FyCd+Ia53XKs3veZFMIYJZMoqvNp5eq5iqJ6brv6P5gV5hMc4e+j2o3fIPYg1YMeanV6A
	 KG0yXU4GAU185AgaIloekTBQpI6vYIdQ6sRvTtu1yvXWvvDMd2V45AWfdrJxwufTS7XVl
	 JadF+C0NqFlrMPkIG3KG1GoJT5AX+mxgD2InFHEW6kdXqFiayzuU/lUPVJtA1votOVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b="M+Jp/wgH";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.82
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020082.outbound.protection.outlook.com [52.101.229.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80A660A2633;
	Fri, 30 Oct 2026 15:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C80A660A2633
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=M+Jp/wgH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LcH0gEp8nN1pFaDjzGYxhwTQ97w+H8qpp2+0eipYke32m46IbV3+26ZdHEmR0bKAnS6PbUaD86oRMjY3bltigddgJZSQNRWsDzMGmu6NomK7/ySsF7ZA8KY3TTjittDrar6eHYcbxy8dRmUTGSmuoSgZmkWI8XjlHfiA1hOZxSSP/RqHMJz/Qw3g3qARQmAQGfYAYFnZN86l0DroCU3WdmZ4p9onH0cHb0I2ot4yH7C9z2sLQSE9svazCAaFqfXxXwH48YAqK5+0R4ZUs222Gb3fVlhzmhjZyAbx9ErysleqIZ62yZ1aw7y6upob2Q6JB/VquXNVeLlgMjGzWNCAsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MErFWj1ajQwST9qYyk/vBLjOoKZmuN7mnEQpppbbc7A=;
 b=PBZ83NqWT9THySQN0Va0nHB1oNjADiTCgKBu4B6LI7Ji8zdbzup42fMcw7u1ZxyHZDbVKosPCpbw5W75zaFQbOg4Ktog3qAml2/j2w1jKN0LzOOysOat0pBBlYeVrhN28b+6KcrefUP7JORBK+9R4FYGjY+oaQ2AjR2VgEv5lXE0LpClgWrjzS0M0nnrVoW768o7R1Hg0VODY/Ssz9PmemZx3G2uR0hJmM/fbOSPORht56hbeNUUCOAXVM+OfPG0eoMQIGhRiejyIXBBj5yJo5u01TBqSDlb9ki5HNVJNrolh9OmRH11IovPOC8PhnpL4QChM1L6nUDHT5Wttru6cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MErFWj1ajQwST9qYyk/vBLjOoKZmuN7mnEQpppbbc7A=;
 b=M+Jp/wgHVjUR4jMb1RoT3w8DbpH8SJfRMXQWoS5Kit1OzYm07ke8AcTkSZQDgfZhDy07gOoCfnSg2ohBo3IFu3j+6786rHjSiLZGJmaVI7iK46teWyNAtQ8+6g4Sapci7vJxKF2IH2V6HcdEXXgVO3z3Kvfyey18wZdQ5sRsIUQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS3P286MB2389.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:150::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 15:07:56 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 15:07:56 +0000
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
Subject: [PATCH v6 5/5] dmaengine: dw-edma: Add trace support
Date: Sat, 31 Oct 2026 00:07:42 +0900
Message-ID: <20261030150742.2586776-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261030150742.2586776-1-den@valinux.co.jp>
References: <20261030150742.2586776-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0013.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:26f::19) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 0015aceb-78b2-4843-a211-08df3697937e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|376014|7416014|1800799024|366016|56012099006|261009223027099003|261026135527099003|261026121527099003|261021123027099003|261021121427099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EeV+hKFl8hdIi0HrIphZDfbZc3gRzJp1YMzqEs6+44XicOeShIFwETdq5Q8k76LSiNjyiB2C7JssqP0FQUzEfkYRyLxNNz8OWyEBrtuAs7WczK6J1ILipwN8a4FRi2tK+imiUGK2WhGNN8x8eUCgOu6U3YfHgAb3LRlEqhD2hd3+kwc6hhG6k4IgWeDf/u5bJPQiu7eKnPyEaNFybnD8/AelyMZjqTUecA95m/oxCyHuJL8rFU6u0E5islHlD7ur+hDQmU+7103Y6Tn1SpPts2Q3KIBBZb6z0D55llLKQCfbiE5G9LA2/JxSu7HMhJ4TKMbONMpIT8Ap3fN3YeA899vlKLHTh6HVOjwB3+Gus9kOej6y27VHJtrgoWhf2OLuSvOytu8h5FQbeu0/iFR3IksEyC9K16zgFhPhCya7Gcd8NKqwvGTf5c8fSgVi5Ors4wWT9vcJvzNeCQ9Kumz46jDMdCFN8iSk373sTcHEvP/8VK7AEIIJY9w2WYd20VP6oBNAd7N9ZGSE9QKiV6LVgD7Qp5/jL8vSG81e2geH3SDG5YJ7gorf94RME5QNJCqP6Kpg5e37LW6hlojU8C3caZl8RekpAIQVTBSHfkHWS3lFfMGlPzYWbmo+ABSbR2DO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(7416014)(1800799024)(366016)(56012099006)(261009223027099003)(261026135527099003)(261026121527099003)(261021123027099003)(261021121427099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lXIqPyJFHmCXTVFlizkQmQihLP2hb+BrBlcCnx6uRbo/JTPEFujf4wRcuVxQ?=
 =?us-ascii?Q?rGO3QHkpPktT/TvCW89R73e4QorNyJNWlr/TbxeHfcYtENuybEClyN8PGxKC?=
 =?us-ascii?Q?tKyh7r0El4tI3QVX9Bn8GNGytM8v+8Ea0NwGShb5PrqR9tfzElweVfbbnnLi?=
 =?us-ascii?Q?QYwK7V45Q6hrLuMluZQPSZenzpHxY74LD3BB7FQhDe35iL8hPnqrEpSxH1Nf?=
 =?us-ascii?Q?eEuI8v7obIJu1BqKe7O1P6DX8DjRYBQC8gwcDb5EcDNYRvo4vkDTtJdHxEeK?=
 =?us-ascii?Q?eV7C8qre+sAmyUaBecq/PMpgQcZxE3N9ud6MB9XCAL9Slzk2ct4O8jX3+el9?=
 =?us-ascii?Q?SAfEVyexYZ1HoXzaAt/huAZb2f68tv2SpB2ZbfQnEwy3Vn+B5mPuxcXoJMBK?=
 =?us-ascii?Q?rdtaVw8KHk36jideBCKjClGr+5V6CqI3sQqOtexrBcLbeWLA5UfUgkl0n7jt?=
 =?us-ascii?Q?FkzqLrctPF26RPKP0fyALXxlT6czNwbN2ie2bSrt7dkKVVMheEewXhTLbdiL?=
 =?us-ascii?Q?+shWFmN2GnEmBXctglZB7XkkJM6Lhf9hGTS6NzB1RXBvUt09j3i11vumtbLw?=
 =?us-ascii?Q?zVTpfEnuTMEEJAT63V05sXSWRn7kxP203DrTM2opL2dg92iQrol6QCh57oqz?=
 =?us-ascii?Q?7AkeYgPF2DPl0ixs1GpcF+/Dyxyp9gG0PttdeM8TC2o3+3FPG6ZjwOTWzgdh?=
 =?us-ascii?Q?6cxYypwrjzEv/fIR3EyU4YqAgU+HbKWxwuTrSOM84rEx4B7ApTNaKSEfvFTS?=
 =?us-ascii?Q?AiBISPAjNVIGwndL25k0Gu1txMOv8v63E9trgL+YE8ZnnDDlr5zL5KCTpNHV?=
 =?us-ascii?Q?Tg5NYI0Cz1pgU3E1bx7OZEtIGtjk+X0qyRvMNDL2UU+Nl+avKO7eAGEepGQu?=
 =?us-ascii?Q?mGKjirCLafF5O4MCAlQkCHoDeesftvxKq01/BPHohsaAGyj0XX28edgZvTdL?=
 =?us-ascii?Q?OnffFSYIqYLCm7kSkW25IkRbKE28N3rGOyj1qgEoDXaBk9BAeVHcZ+DIlxpg?=
 =?us-ascii?Q?BMrrHinWeKXL5x6TC5y0dM5PPty1lnmdQIa2EIERB8t5pBVwYLEBil8/W1ql?=
 =?us-ascii?Q?qAURZIk9ifCOuVWEjVWh+7/9AHNIAnxWfUqqS8vhMNtl7J52r1h7TRWdsWLm?=
 =?us-ascii?Q?+oNmC7GCZ0gaQcUVBwpsifmyqoxsgm8KfAcSn/X9wXY+JtHzCMmdLR8VBnvu?=
 =?us-ascii?Q?7Hc8whzXsx2GJc8R2MAHaT6ddmZ8o5YCkytCfggMK7aq+QpLoTYgF9214UoN?=
 =?us-ascii?Q?1xRJMAHGHg9/UyLiPjUrJubfpD9cnNQ0awtMqLKV/ilhm1AM0wW1VjgqmI9f?=
 =?us-ascii?Q?PIGBekfKfJDvnEN4jXrrFr11QO1GDW1ECuKAiY8el170GrtKXQccdA7ZT0XJ?=
 =?us-ascii?Q?Qq2wV6OZrPxpUb2QZE4AHq9hJqo5n43Z0Ie5+8gZen+uUSZIizAAmBhPjC8a?=
 =?us-ascii?Q?0BBEFjPml6BVrPgEe8gDpbHFJn+RZyxCKSPdd3EniRQsU27EQktIzdU29pkU?=
 =?us-ascii?Q?qmSzOXqsYs6A4tjEQErwwHy+PRyChN1uw7viNZP5FRAuXAu7iANxGvEPEs5n?=
 =?us-ascii?Q?Dl0I+VUVbFxexdp42yyOo81A6c4SnC3hmTR+iHao5GXEWNM5zL1rqjcepZ9q?=
 =?us-ascii?Q?eSOt0VtJGmDSRbipdVzJZLg3MXz9JdCCrXE38YmfZ+qkJ8qTmgR9IWMMFsQE?=
 =?us-ascii?Q?9Y1u1WrjBw4hskU2nu1bTGlYe4tmpdR1/xpd3WD8UWEYxoF1vymBgZtFf/p6?=
 =?us-ascii?Q?h8iKiwlo0kqmJYB0ZHKYvs0pH/CWyJ+5HN3cRnirUSLdO+mEiJnH?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 0015aceb-78b2-4843-a211-08df3697937e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 15:07:55.3616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubAISvXrILmmZvkmhDgeX945PJ3A0hVJHEImczFGr8Sa3TKKvdhJQtoN9xBtSdQlYp4CkN5MyP6vbwaKlvBCuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2389

From: Frank Li <Frank.Li@nxp.com>

Add tracepoints for LL publication, descriptor append and completion,
and doorbells. Record channel and ring indices to help diagnose stalls.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Co-developed-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Reworked v5 patch 24:
https://lore.kernel.org/r/20260812155721.2807506-25-den@valinux.co.jp/

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
index 3e23d177a579..be8816528b2e 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -219,6 +219,7 @@ static void dw_edma_ll_consume(struct dw_edma_chan *chan, int idx,
 
 		dw_hdma_set_callback_result(vd, DMA_TRANS_NOERROR);
 		list_del(&vd->node);
+		trace_edma_complete_desc(desc);
 		vchan_cookie_complete(vd);
 	}
 
@@ -245,6 +246,12 @@ static void dw_edma_core_ll_start(struct dw_edma_desc *desc)
 				     chan->ll_head, chan->cb,
 				     i == desc->nburst - 1 || free == 1);
 
+		trace_edma_fill_ll(chan, chan->ll_head,
+				   desc->vd.tx.cookie,
+				   desc->burst[i].sar,
+				   desc->burst[i].dar, desc->burst[i].sz,
+				   chan->cb);
+
 		chan->ll_head++;
 
 		if (chan->ll_head == chan->ll_max) {
@@ -298,6 +305,7 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 		if (!chan->ll_valid)
 			dw_edma_core_reset_ll(chan);
 
+		trace_edma_append_desc(desc);
 		dw_edma_core_start(desc);
 		ret = 1;
 	}
@@ -361,6 +369,7 @@ static void dw_edma_core_ll_sync(struct dw_edma_chan *chan)
 static void dw_edma_core_ch_doorbell(struct dw_edma_chan *chan)
 {
 	dw_edma_core_ll_sync(chan);
+	trace_edma_doorbell(chan);
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
index 000000000000..653b36acff15
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
+DECLARE_EVENT_CLASS(edma_desc_info,
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
+DEFINE_EVENT(edma_desc_info, edma_append_desc,
+	TP_PROTO(struct dw_edma_desc *desc),
+	TP_ARGS(desc)
+);
+
+DEFINE_EVENT(edma_desc_info, edma_complete_desc,
+	TP_PROTO(struct dw_edma_desc *desc),
+	TP_ARGS(desc)
+);
+
+TRACE_EVENT(edma_doorbell,
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
+TRACE_EVENT(edma_fill_ll,
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

