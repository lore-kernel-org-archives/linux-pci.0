Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.108
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794058239;
	b=QUqb4LmIOLNX9TmjH+qzRhvmrZ9fupFAvR8WwzSk7Spuj7+OrMnIqXmJjVXZX3r9L+gA
	 ucAlLRHPjPd/JDL+tRKX9zlTaaCaoAR/arGiS802LW/r4dMmd0Ti/68Yzl+ux6CHNCsCt
	 pEDD4lovzIYnNIUDg1xipoRBFw0oqod8miKhS7kUt4+oke0oO2uGHDRDeYFZAF5LHPMii
	 8CPoc8bJd+fATCVehG/Eb/7HednFSdCiwoFX2JxzeiaUcRCyZpQUnib9MGYDZguN3HUjm
	 0LMEW0PAMmR8o6hmGm9MtsWzlCkn2Jp7eSGXSwInmaFwBL1y09GLKLhBeflINugPzJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794058239;
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
	bh=CfjTeteyRJKsnipb9hCVblBCo0qAO0bCdmqldpmNcR0=;
	b=NVb/0YBsw549RHKP9Kvjaf1BaBBoVS54Gx8MnX8BLzaHOBvBl83nUrl/ntETbwP0TzMn
	 HSSEbk8fnIlBryl2GedlEdEd2xNIWLGpvC+H7g+n/fZgLQaQYkjNcyvt0mrqLrAu3qK7R
	 khf+5OsCgy4liQxyzvzEaZvUHh9l5WqO8MeRpOqPzBJOZiSoHc3E6dyAkWaD0KZsnqxen
	 S7RyqrhabxhLe8t7xRGwLV8TWjJiRq1y4GdCtKilp24l3B0Sds1Z1o/JXZznQOskRaWkG
	 akLrZuC0D7mDGo9cQkCNE6Ku0DFTa5bgAA6N3A/OBRgJbAg6Ygg5sN5V31nIdDZkBNA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=TROq1HlC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.108
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020108.outbound.protection.outlook.com [52.101.229.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81920606A332;
	Sat,  7 Nov 2026 13:30:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81920606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=TROq1HlC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHb6y7476IFDhQka3pyOJ3XkDEq0/udS+vfFYCCJEgDUWOuYDP7mrt9UnFCQ4ka6SH/onPk2dhsQ54f8KFAu0Lq/xeG8+q7o9laNRGPb1BM+UfmB1bv0Fpazihk4secKkHi+dFF3UghQaXHW3mdFzbW1gsvw42pFatR4yJRqx5EbVHW6r56Ym7Zdvh8C3rgE6LAQLrNv1hhZBsVJOvMRkKLrOXDOP9EwcsFoOcGLG26qTzBv5R00AT5Wgc3PKn8hPCESzbj5X1jnPo82xZviVn3JAIoAzEA0OMiN9IRFEZacr4rqz9ftAwMQx+2HtORQAdQd1Hk/uskK+s3+cy5DRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CfjTeteyRJKsnipb9hCVblBCo0qAO0bCdmqldpmNcR0=;
 b=O0mQp5BhsIdJdilWxzwpydkO1s9oRiEmhWamVGCG0CmfghdUiFAItcf1ta2tzYGHZOkYFs3qw1d+8H9yosm1VSDuyxxIi1MuS2DvdQCoQm4BbSEHRxgCHsNJXwNhF+r5HMcmjp/3xPSGXHsZuWQ3dW8Phml8cTseLaz8gLNr/b91XIxd3n0exZ8BZy3VrhseaPL6kTbmG97kgX+E4FRYALXNDWSCTBzEyRrrgqIhY2VD0dO+jnUhKPYYilIxmgCOAvL/ZKq9sbkP7bJUCESHgY4vdu40mU4crtiqdNw29B4/mBznCpxzmwRKWRn45adsYGXYryKp6CDqFoiz+QVSKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfjTeteyRJKsnipb9hCVblBCo0qAO0bCdmqldpmNcR0=;
 b=TROq1HlCD5ltoFINJCuSjIN1p7lpV9e2Jq31LaX0IrF2DCt7oOoh6U/pd5hBVtyKeaTjHIxjZGSvvEE6APzmjU4oQEkFihCODmCpblgDdu48VKvftV61GDRGFnGuxanZvhIhzCFJvGzBDrvqxt+ywvpeN9T/rwg7pzw7XVyO13A=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYWP286MB3222.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2d0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 13:30:35 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0592.010; Sat, 7 Nov 2026
 13:30:35 +0000
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
Subject: [PATCH v8 7/7] dmaengine: dw-edma: Add trace support
Date: Sat,  7 Nov 2026 22:30:27 +0900
Message-ID: <20261107133027.364237-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261107133027.364237-1-den@valinux.co.jp>
References: <20261107133027.364237-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0114.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37c::12) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYWP286MB3222:EE_
X-MS-Office365-Filtering-Correlation-Id: 6455c126-e84c-47ab-a1df-08df3cd34e1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|10070799003|22082099003|18002099003|10067099003|261102123227099003|261026121527099003|261009223027099003|261021121427099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	s5GhFnfRg7weoxF/RLeirYN4phfJoUhGEQBiQdBMqbTbMd++f97AuQMKL0/c4Sr8x9VrSrT2pYQfJmJda/IOfG3hTnfvHH3CayaYyxAH12pmPhpCLfFwbAR+rvb3e28FmVktOBuYH4Q5DSA8h3+uknbzyATulLbi4h4MqCtXEnX6ahmJUv8nbYcY0g0Wg7LNSc2rWNQt8r4evj6AJbTob8giu53ieLuCNPAtClZgYvMiNYgYiwaqPJ89MIDqh4s9EWeyzO+uNbce9ja4qwMN9JpGOjgPjAm30Ctz9fD5MhfEh0vYieIrt9eCr2yLiSKM170bTeFlTn+dl9WN0UfmjmiXN3w6ffMl1i05XHaHM7f1FYJ5cc7gKnlTW1x8b+zq9ykcHiz7XFBDEA+Q6+wpDB2JYYrdxTh7XQ9ADUmqQLgOri6BEeZsxGFtYMEydDx1M+OsCD1K7ChMfJ0GsDh1dyNpYpbl4JtfipdPi7tTkI3AAdDvJZ1iuHY23xZ22mpXgX4InoWcVn5HK9kLBrxuntOotjMOuJNzfFAfKmkY455jnW4Y8mZ5kGbygDJomWanUHR84eLvol9MLuEsC6oEDSRpk8dNK0ON7Ss5tjvYi7xhN6MGocybSsEF2A9Xm0FlaFBVOtokBo23kWK6pXjMzTSHY1u6+ObyP8azegL16XE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10070799003)(22082099003)(18002099003)(10067099003)(261102123227099003)(261026121527099003)(261009223027099003)(261021121427099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s97dKdEs8jSVCunTs4IJa82cSt4scwC/pJ+jUxKDsYm2JgdkOSCkgcXQFZnZ?=
 =?us-ascii?Q?ATAlW1ver4FGbLBBEWgm8E5Hp05OAaj3DGAxhuy2GbWLCVKmsWOW3jQCMQFv?=
 =?us-ascii?Q?ctE3i/Behld/EORSYYpfrFc+FSXQjjA2njXFjgfcGgHxoxkoVuSb5Qkb01zx?=
 =?us-ascii?Q?zO+o5kai9CZ375vVaHn6gxs8rwv3jFiEBuBOXJ0gf4aBMoNl76+amgAADqfD?=
 =?us-ascii?Q?H4XY63wd60/LCWAmWNf4CoWtPZ8xOwb1x9qra+ifC5lGwBxxve7wv+Mxsb8o?=
 =?us-ascii?Q?s2tZ7VoLHk6TXN6iqg8b6WIMy7TMS/mPZIx+QDLTjRnx6BhiEYlHQCuaqyae?=
 =?us-ascii?Q?FUekL0Bj+J6Uig3qwvvMtxTRjfSPboz++yi/0KDhRYwGZf/bkqWeLhmSdegV?=
 =?us-ascii?Q?A3U/hyaFC0Xtli+3LB/uOStoFURkMsi/FUB2taAQhWBSB8zsU9fd1lO7Raip?=
 =?us-ascii?Q?tV/6Xy4tE7PKlXGKzygeGNOuKWM/f4bJsMmn/wet+UjVbYAAtT/5mfQUZBII?=
 =?us-ascii?Q?pB/D6eOOY9HkD0dAe8LIipdPJwpWFWcvTE/lv/xOZ9MUfU0pHLrwwoIbCz67?=
 =?us-ascii?Q?RACPS4r3J087umwKo9+dM22bkcGP/bZF0UfSqMoB+Rl/lPdAMgI0yE9ET5N7?=
 =?us-ascii?Q?C4CEKuP3kzUsUxjjA3pGRXz1KH1/cuwIvgKIqX4WOdv9f2b99PefBaS1nuC0?=
 =?us-ascii?Q?LsS8km9+uTs67C2Z1Y5+hISQTMrHFFYrIzTFc4QHK6EK7B2/7NqKNJO/VZtY?=
 =?us-ascii?Q?JgUHZjHk/FPG0XW30bwOBQGNQprgziViyKcgEcyOsBRYBWpLfQubFRYbwQKe?=
 =?us-ascii?Q?4hWthXA5EORDshspMf9TZDgy+ymseZA4Da08FhLlmaAVaDjKa6VsLs4vk8lB?=
 =?us-ascii?Q?NRHoRtsIGeqkHFQMsJYwfAA3K+4Ubm2+vt0JkN27BXVJBSr1iPmrWZ5o3EMJ?=
 =?us-ascii?Q?lQZNSbDJXGat7vYOh7mnDOvrIp01OEJA6bBgBttovDc+ZSDCrGycXf1bSIhQ?=
 =?us-ascii?Q?1u3EqaZ0+EBMON9cU7mO5hE4pNqzmPzP/jH2siUWWDv9C6mgFqo7y5L01WX9?=
 =?us-ascii?Q?dI3Tmfx4xXPdZnqW8NbHu6gyPdMu1FYrnMRIZoJEHAAwbjM66AMfRSFtxmgQ?=
 =?us-ascii?Q?7Gut2FCSSnGwBKuVUqT2sj9c0jhO9fA1G06uM1pmdYnoJvrJeJeAmJJfa3vp?=
 =?us-ascii?Q?a1FwvT70PELXYMZ+zweUey+YmNnj06298bh9Nj+LDfD91jGf0ND+fR6DXs8c?=
 =?us-ascii?Q?gs+X5yV5WOeqFcMpmU/T/G562s+hisnPyy3mjYcx0107xRb/GxSUPNBMkgE7?=
 =?us-ascii?Q?//iKWrm8/SoFnIYb0aq/U6vY6fBUUP854f/PKEb/XX6vgYRRnlps+KpT9Ub5?=
 =?us-ascii?Q?llhXUu2+3D3M7rmx4qRzJfH0dnzMoVaxTIgrTyVaQWrKur0VF+If5tsYYvxn?=
 =?us-ascii?Q?q4UhXnckyxH1AgXSlsm6Edk6Mjq4JtxhWZIWnY82ha9BcsZwK2asZrmY+5eH?=
 =?us-ascii?Q?rIWF90mTfF+dhwjT7xFOswX81lRbHgfMhFQRcUDOWVbnPGaJSL1iPj9U9Xau?=
 =?us-ascii?Q?3xtWTP+QoHJomgLczh17Ii/bg0UNsMaa4fFccyD9Wz37KJvsXI6TLTX9/Jl/?=
 =?us-ascii?Q?FjhvXlNiwzB2xu9F6njF8qgErS8SaZdLPoLPlC0u1hS71WXO0xWREE1iP6VN?=
 =?us-ascii?Q?FRTlGFyYs9LF2GCehJRm6scFltiWLawMGWTQNuR2IoxTqJsSqJrd3i+itPne?=
 =?us-ascii?Q?BDYcyF7GhHW2ETGbidPkHEpxz8ZWtprrPBjc0CPYU2ZIMq68LB66?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6455c126-e84c-47ab-a1df-08df3cd34e1c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 13:30:35.6793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CKREj+NSHIUzDC2/bKAxE+aGAT3OtR2soE6TYoml2p9MuL8LEdKa/GHQ1hvy4fNCaXFgdxrMBtNihIGFrDhU3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3222

From: Frank Li <Frank.Li@nxp.com>

Add tracepoints for LL publication, descriptor append and completion,
and doorbells. Record channel and ring indices to help diagnose stalls.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Co-developed-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes from v7:
  - No changes.

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
index bcf4fca34591..94cdf7fb6370 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -259,6 +259,7 @@ static void dw_edma_ll_consume(struct dw_edma_chan *chan, int idx,
 		if (desc->done_burst != desc->nburst)
 			break;
 
+		trace_dw_edma_complete_desc(desc);
 		dw_edma_complete_vdesc(vd, DMA_TRANS_NOERROR);
 	}
 
@@ -285,6 +286,12 @@ static void dw_edma_core_ll_start(struct dw_edma_desc *desc)
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
@@ -338,6 +345,7 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 		if (!chan->ll_valid)
 			dw_edma_core_reset_ll(chan);
 
+		trace_dw_edma_append_desc(desc);
 		dw_edma_core_start(desc);
 		ret = 1;
 	}
@@ -401,6 +409,7 @@ static void dw_edma_core_ll_sync(struct dw_edma_chan *chan)
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

