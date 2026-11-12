Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794522086;
	b=mard0fPXai7LxGzHQIUZIVjBqcPSXqNLr9/TZQ9loxxb/YN9vVJ+Heg0FhbJJlDMztmX
	 vutNIVLfRCw85bN4wAR4NuZYsyowvKp+W7A7X5cBeC9vbNsuUYpDrmLnCztpCBA0TpgPA
	 7lhSiwzCh1TYP33ErSkUnENIpzqZ4VoLBVTn3jeGeQg+DTjjT9mlUvyDzUOY7gFUqnRIF
	 6ykXNdw0D21oRvkblOg0ZpMAF8PGr3jN9mpjqaG4Z24GPmrBebACd6GwKnd8r5FN+6/U2
	 TX2/uN/ZVvLYl7gE0EIXDg3BFXQHmCfJ9lEi3X8LTcNuE2XGA6Swr3U+1+puhM84eyg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794522086;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=epOOZ55TBlEFIxpZK3cV+vPwePakMfX+XZgi2OwxRCE=;
	b=YRyz2sXLxcFsNvx20fE6xozfOEM6rPYCh8wRfukqr2LNue1uKXSbvIgDz9NGCShxsnCY
	 kmSgrDT7IOW1T+3RA0pRH1bcpUBAx3mDYYqwAY1U1mbmCDrmWu0Lzmg50qL03WY42SLn1
	 xRURmanfHm6TqTP2lL4J1bo1jj/zK/okGyqvijzcZ57MzNYa/KEglfm3jC/uKDvMLVgCO
	 FCQvoXVtBLlFp6DgSyQpo9Ji68SGjsAuGGPwna8n5r59apSztj5odnVMnVMC7jBpSI40V
	 bg+QvOy0fImzWaIXR7G55MxeT7rpN84OGK1ApXu0ew8RTQ83TjX3NrU7HNDZv2fbfHA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=JJ5A+ON4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.10
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010010.outbound.protection.outlook.com [52.101.84.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF354606A31C;
	Thu, 12 Nov 2026 22:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF354606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=JJ5A+ON4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dp7691cY1xEb/8FZDc6bpnPscNCW7uiP+NPeUxxqYGsBygCn5j6ph8E+Uq7DpEYEgxpcvNxVA1zdTV7+VSBKEj6JQ+pBpXcLyfYQ9xLejgcdBJCgq29OAKAX5tOn/I5x7PhnXgbkjT+hyMzdXK3MMupZ20snP314hYmOY2Uyd8VENykwGt+TePuAMacKFeEwtL5BZYY925qkXgajEay48U5bG5eTDS0zOiHzoMS3C1fC3RdOd7DRjXoGHqoqst0TramgpLOC2a3c9fO9Vwgsk9wpIBXhpg6XzKnZ2YgQF6K5nunFbRhSNn47LKtzWvUK/frc+0mvEEW42z7VMdGwrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epOOZ55TBlEFIxpZK3cV+vPwePakMfX+XZgi2OwxRCE=;
 b=oJ7wv0r4+i/40Va7QjQ0fLBhIMTWPwnnd3yjJaXwHgw4EvY0PdsfL9fCDAkSbaVNiVcY4yxSZ9wwqbiVmFQ4nkl3zOHbhesNFC5mUg3X7D8XLrzB2Y+xhkZ92197qc11w37LEfzu6M8DflSPE2yAdw8emHRmcJsR8/PpIc/NoZz1Gva9stGjeB1Ghm5EqPb4WO9ojyerh3v8JbR3dW0dqTZoVmN1bnEckrE38XyHBRW3RwcMzoT5bLLGwWAiNoDhFV6WuF4u3m05hYGJv9mbn8razftailxMB0A/NZ7uYOl4SaYUIUAI71PVKeJcL4+ZjuWRjbl1WMIkTXz9nonAYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epOOZ55TBlEFIxpZK3cV+vPwePakMfX+XZgi2OwxRCE=;
 b=JJ5A+ON4DfzsJqMcj5XUVUos+IAkdYxR5LmXhY3Lf8YC0QekQkjGTTWCaTXDzadZV3i4vC2KlUajWgOxY/ar/6KGc4Gq5Elpluawn2J63/CEtj8HqtRhs/yX/yVz6ZbUwZClHwVSbLCyeoFz2SXrb9P+/DDlxerhthqnhbY2rUZn7rfa0320NCvH37mW+7vi8eyRZ2md5ziJK0gKm3RqwcozN3WokyKNkCziA62x+1CDhzxzjmy/sxvaK2DSzkgc/cLUSF91+fhLi8H5TqtFxh97828gnuLJJib+F7/DtkjzTF8BJXAU/68jg3p7UnA89p9zCxmdPFRlsWZdSuqQdw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by MI9PR04MB027399.eurprd04.prod.outlook.com (2603:10a6:290:ba::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 22:17:58 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 22:17:58 +0000
Date: Thu, 12 Nov 2026 16:17:49 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: nathan.lynch@amd.com
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Rientjes <rientjes@google.com>, John.Kariuki@amd.com,
	Jonathan Cameron <jic23@kernel.org>,
	Kinsey Ho <kinseyho@google.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	PradeepVineshReddy.Kodamati@amd.com,
	Shivank Garg <shivankg@amd.com>,
	Stephen Bates <Stephen.Bates@amd.com>,
	Tycho Andersen <tycho@kernel.org>, Wei Huang <wei.huang2@amd.com>,
	Wei Xu <weixugc@google.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 10/25] dmaengine: sdxi: Install administrative context
Message-ID: <avY7BExEEGO-itcR@SMW015318>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-10-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-sdxi-base-v4-10-3668ccc7aab8@amd.com>
X-ClientProxiedBy: MR1P264CA0210.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:56::10) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|MI9PR04MB027399:EE_
X-MS-Office365-Filtering-Correlation-Id: ec2c6124-978b-45fb-a568-08df410ace67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014|23010399003|22082099003|18002099003|6133799003|4143699003|11063799006|261102123227099003|261026121527099003|261021121427099003|56012099006|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	I1Vh7UCI3mgL2p0ptao+Z5Cq5JzVJfHI++RldaVt3v71hYwXaw6tyJioMQQ7Z85z8sRRxXfxp8dsWAjb25GOfJcZH2mqSCRU6zTGnHXJkzaNv916TFDZxWK1TX7KtFqg/srkijKr6UiXXts3eVuAZap1mTtNTbFpDpRYJFAiGE80ruEP19BA7F4LTdWgO2L+RFcaI3mfjNO/9BkcBcbNqfR0swP2eztqH5pvgxPuSIS3GmH+pEPhPYKbH4ILupAPL8tsYnifGlNUGlO/qyTQLtVTreqSus6tqXQex9oTU/YcwpEO7QKzFCBrS7JXfzW+HqPbPbk38fayogmg8Ks9gpLIBuhOj65hHe5qVTZ7+58HqLmDnZG0fZgikyJ2Sj4L7aXAoJIN5pY9/PzVJUbc3VEgVs0YxoFQxLIOWouZeKKs5eOyzeD3ctROT/wNjvRYm9Rd7Ms3siaMgO/noTJD9JiNEXRWSfFA5S+mio9SEGM4tSSZITe3PStF+9zp49Vo0POMYK6mG7S5bYhQ1HMqg4fthDIrFrvOt+YPDbTp+kaL3rvCK3fQ7VolOrwt5YZaZfIezH+OgukY+Z/lbPlIBEV4d5wbaIRzEklezWQ5j+jBYobnmpnV5WfXoxDMgBP/NV7NDJuqpo3I95ukUBZSZmH2xFPYkY1wTQbtYSuHYwk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(23010399003)(22082099003)(18002099003)(6133799003)(4143699003)(11063799006)(261102123227099003)(261026121527099003)(261021121427099003)(56012099006)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uX0yb//VD1X4JSlAZ8lRAH/6kmfMKxD0gcFQtDGYnUHB2OnORMJXk45irTTl?=
 =?us-ascii?Q?39S0Rqeope5JTQC8H3nZz6nUF0jOQRjcGDcurSMaeLktz/LBeQ+DgPoqIsTr?=
 =?us-ascii?Q?bRgoa3XqMZFaG2Q9d+ZTA6LcmZHbyjMYJT3mze+dxmJ43jLiFiUVTof3tJ52?=
 =?us-ascii?Q?19HX9P5imH9MiFgd3u1htVV33a8yQuX/Qp7HKzenKDRFb4Ii4ASIhMOm+KQe?=
 =?us-ascii?Q?eVF7hkL87gVoAPpJeNSpXM1mWtfbBT63B2Pc/Npyhe8tULm0cF5URjHwZdZU?=
 =?us-ascii?Q?LjmnR15CFYvlA+RL2CIPhtuAV2xuvdSxiXH8kMMdwR7N99YhnMik6C1VLACG?=
 =?us-ascii?Q?pAKO3BdrxEJrJ09/Ha+Fx7BCrda3U3YSj+O4BL1M3JOiA1YFcs4cq3c8iscr?=
 =?us-ascii?Q?CoLktR+t/83FSsF/ynXtXb7R7ssMHkdjx5370BK4J46WgF1F97W+lY7m5Dt5?=
 =?us-ascii?Q?DXjUHA10HKV9C3hLyPY1Jlj0jABIrZQVLbezYd2cf85uCAbNWONhkoaozBmt?=
 =?us-ascii?Q?mhvJKQLWrD23ASKM0zblk8pzcmMGNJZkePApsJWOqFxZy8cxrNzcyT8L70R+?=
 =?us-ascii?Q?u8UXoV4fLVzROnYU1kULyIeFjok+mnhZCWethNrLGEy6DaIPWSij8hGsplER?=
 =?us-ascii?Q?A4Tu5jsqjma7VXEWK3yHzagVENVbko4UZxQRfdRITli1eEXER0q0UZXoh427?=
 =?us-ascii?Q?e1+3fvfxf6w/+/2iG7jKlyj87tg/we1wIi7ayaQGbF3KRNC5NS4Q2bXIqYM6?=
 =?us-ascii?Q?bYF9umqqIfrVvuXgdKYDZfmfRW58Il3UJusgEf8OiSbZ6HiS7O2cfj7tyhjP?=
 =?us-ascii?Q?N8cwqv5xj16bRrEVhi4NhBRNs/SQmhkima0dPFeG7xPEYwf0pOuQ9MRdGcnN?=
 =?us-ascii?Q?HH3x937vJrNlGBlxsnCsjs6WBVycQx4K7MpmE0yS4gJabkSi0jufwiXYlEKN?=
 =?us-ascii?Q?W7o6I3u8Bv8/q5CcD0TSUOw46CYGo1byFB1zxIM5K355R4fO12AWqi4DKNZ9?=
 =?us-ascii?Q?FnLnrUKl8IIkV8cVASkTjQFyqu/uEXX/fkAea38OuJPTrR18BOCDo96+TTEe?=
 =?us-ascii?Q?9MTLIiGz3jxg6J0txSIFxR2ZoUgCn+XErVaHI7bC7+pVKXRRnSvgBZzCukLV?=
 =?us-ascii?Q?svWoG1gA/RXpCYNQAm3HikA8OS3zZDfMhxXh/Nq14R/InlcCSr8PRpGRecmu?=
 =?us-ascii?Q?fvlZP8d0+vRw4jKuO1av8UMWm31m+NHW87FzxQLnCfaz/3edjJbWRAw4Zkkx?=
 =?us-ascii?Q?i4QqUpfFmyFvU0CdilSX+Mut75/tmLMSOH2WsC1IEpnVZZMdSBZhQWi60ZHs?=
 =?us-ascii?Q?RcCTT8KglcxWfFOexzba9/kFwLacNdXT8Bz0n8QMhfVCsJby8l1mv9wYJUSS?=
 =?us-ascii?Q?cZAgoS2OrjE0vsGn0OTmWy3gwU5AdzGhL8ADEwl3uTN2lKho2582PYSOQHRt?=
 =?us-ascii?Q?1b5eQpquO28QX6gpj1CE/CSHWQJ9r+2Xg0k5wyEESkU3ZKzRLBMxTEKPRMDp?=
 =?us-ascii?Q?f9AjUJ86zJd4xLX2Zve5NRL5KjOciZYwXni+2YqH1e6XEhuTDrYaVJid/2qx?=
 =?us-ascii?Q?Ss4fFwGJfdhKETj0yO/a/2pIBs34cB9kz4QajUQBjBLgll167gUL5pxTikJj?=
 =?us-ascii?Q?l80hxO01AnhLi5Y3GRqqcXE9ldNETmoojE2zLd58Ft7/kMg4UcvirQEIjy4I?=
 =?us-ascii?Q?LRuHxccPoB9pYx6OOFTuwYynT9HOGJ+cjT6p0HPMQQ7Rm7vuE/jI3dSrGD1I?=
 =?us-ascii?Q?J9UQdchGYSeM+5b7jOI+mrxKPG5jfzMBIAXYA93V/jN+RD+YVV1t?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec2c6124-978b-45fb-a568-08df410ace67
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 22:17:58.0096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cx4IOaHUyx3ymXmbtQsZ+hAmb9C+lAQLvq7SiI5rDGUcxtU7cD+JuVaiwi+Z7YFsawWUvogzz1Qk6ZVW1R89klx3ysVV9dMgoPiW3yht7Tei/EJK3w38qFtGbvKVWmcs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR04MB027399

On Tue, Nov 03, 2026 at 08:49:51PM -0600, Nathan Lynch via B4 Relay wrote:
> From: Nathan Lynch <nathan.lynch@amd.com>
>
> Serialize the context control block, akey table, and L1 entry for the
> admin context, making its descriptor ring, write index, and context
> status block visible to the SDXI implementation once it is activated.
>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/sdxi/context.c | 149 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/dma/sdxi/context.h |   7 +++
>  drivers/dma/sdxi/hw.h      |  15 +++++
>  drivers/dma/sdxi/sdxi.h    |   9 +++
>  4 files changed, 180 insertions(+)
>
> diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
> index 4132618ae17a..ebce30dc462a 100644
> --- a/drivers/dma/sdxi/context.c
> +++ b/drivers/dma/sdxi/context.c
> @@ -7,16 +7,22 @@
>
>  #define pr_fmt(fmt)     "SDXI: " fmt
>
> +#include <linux/align.h>
> +#include <linux/bitfield.h>
>  #include <linux/bug.h>
>  #include <linux/cleanup.h>
>  #include <linux/device/devres.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/dmapool.h>
>  #include <linux/errno.h>
> +#include <linux/iommu.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
> +#include <asm/barrier.h>
> +#include <asm/rwonce.h>
>
>  #include "context.h"
> +#include "hw.h"
>  #include "sdxi.h"
>  #include "submission.h"
>
> @@ -79,6 +85,139 @@ static struct sdxi_cxt *sdxi_alloc_cxt(struct sdxi_dev *sdxi)
>  	return_ptr(cxt);
>  }
>
> +struct sdxi_cxt_ctl_cfg {
> +	dma_addr_t ds_ring_ptr;
> +	dma_addr_t cxt_sts_ptr;
> +	dma_addr_t write_index_ptr;
> +	u32 ds_ring_sz;
> +	u8 qos;
> +	u8 csa;
> +	bool se;
> +};
> +
> +static int configure_cxt_ctl(struct sdxi_cxt_ctl *ctl, const struct sdxi_cxt_ctl_cfg *cfg)
> +{
> +	u64 ds_ring_ptr, cxt_sts_ptr, write_index_ptr;
> +
> +	write_index_ptr = FIELD_PREP(SDXI_CXT_CTL_WRITE_INDEX_PTR,
> +				     cfg->write_index_ptr >> WRT_INDEX_PTR_SHIFT);
> +	cxt_sts_ptr = FIELD_PREP(SDXI_CXT_CTL_CXT_STS_PTR,
> +				 cfg->cxt_sts_ptr >> CXT_STATUS_PTR_SHIFT);
> +
> +	*ctl = (typeof(*ctl)) {
> +		.ds_ring_sz      = cpu_to_le32(cfg->ds_ring_sz),
> +		.cxt_sts_ptr     = cpu_to_le64(cxt_sts_ptr),
> +		.write_index_ptr = cpu_to_le64(write_index_ptr),
> +	};
> +
> +	ds_ring_ptr = FIELD_PREP(SDXI_CXT_CTL_VL, 1) |
> +		      FIELD_PREP(SDXI_CXT_CTL_QOS, cfg->qos) |
> +		      FIELD_PREP(SDXI_CXT_CTL_SE, cfg->se) |
> +		      FIELD_PREP(SDXI_CXT_CTL_CSA, cfg->csa) |
> +		      FIELD_PREP(SDXI_CXT_CTL_DS_RING_PTR,
> +				 cfg->ds_ring_ptr >> DESC_RING_BASE_PTR_SHIFT);
> +	/* Ensure other fields are visible before hw sees vl=1. */
> +	dma_wmb();
> +	WRITE_ONCE(ctl->ds_ring_ptr, cpu_to_le64(ds_ring_ptr));
> +
> +	return 0;
> +}
> +
> +/*
> + * Logical representation of CXT_L1_ENT subfields.
> + */
> +struct sdxi_cxt_L1_cfg {
> +	dma_addr_t cxt_ctl_ptr;
> +	dma_addr_t akey_ptr;
> +	u32 cxt_pasid;
> +	u32 opb_000_enb;
> +	u16 max_buffer;
> +	u8 akey_sz;
> +	bool ka;
> +	bool pv;
> +};
> +
> +static int configure_L1_entry(struct sdxi_cxt_L1_ent *ent,
> +			      const struct sdxi_cxt_L1_cfg *cfg)
> +{
> +	u64 cxt_ctl_ptr, akey_ptr;
> +	u32 misc0;
> +
> +	if (WARN_ON_ONCE(!IS_ALIGNED(cfg->cxt_ctl_ptr, SZ_64)))
> +		return -EFAULT;
> +	if (WARN_ON_ONCE(!IS_ALIGNED(cfg->akey_ptr, SZ_4K)))
> +		return -EFAULT;
> +
> +	akey_ptr = FIELD_PREP(SDXI_CXT_L1_ENT_AKEY_SZ, cfg->akey_sz) |
> +		   FIELD_PREP(SDXI_CXT_L1_ENT_AKEY_PTR,
> +			      cfg->akey_ptr >> L1_CXT_AKEY_PTR_SHIFT);
> +
> +	misc0 = FIELD_PREP(SDXI_CXT_L1_ENT_PASID, cfg->cxt_pasid) |
> +		FIELD_PREP(SDXI_CXT_L1_ENT_MAX_BUFFER, cfg->max_buffer);
> +
> +	*ent = (typeof(*ent)) {
> +		.akey_ptr    = cpu_to_le64(akey_ptr),
> +		.misc0       = cpu_to_le32(misc0),
> +		.opb_000_enb = cpu_to_le32(cfg->opb_000_enb),
> +	};
> +
> +	cxt_ctl_ptr = FIELD_PREP(SDXI_CXT_L1_ENT_VL, 1) |
> +		      FIELD_PREP(SDXI_CXT_L1_ENT_KA, cfg->ka) |
> +		      FIELD_PREP(SDXI_CXT_L1_ENT_PV, cfg->pv) |
> +		      FIELD_PREP(SDXI_CXT_L1_ENT_CXT_CTL_PTR,
> +				 cfg->cxt_ctl_ptr >> L1_CXT_CTRL_PTR_SHIFT);
> +	/* Ensure other fields are visible before hw sees vl=1. */
> +	dma_wmb();
> +	WRITE_ONCE(ent->cxt_ctl_ptr, cpu_to_le64(cxt_ctl_ptr));
> +
> +	return 0;
> +}
> +
> +/* Publish the context control block and L1 entry to hardware. */
> +static int sdxi_publish_cxt(const struct sdxi_cxt *cxt)
> +{
> +	struct sdxi_cxt_ctl_cfg ctl_cfg;
> +	struct sdxi_cxt_L1_cfg L1_cfg;
> +	struct sdxi_cxt_L1_ent *ent;
> +	u8 l1_idx;
> +	int err;
> +
> +	if (WARN_ONCE(cxt->id > cxt->sdxi->max_cxtid,
> +		      "can't install cxt with id %u (limit %u)",
> +		      cxt->id, cxt->sdxi->max_cxtid))
> +		return -EINVAL;
> +
> +	ctl_cfg = (typeof(ctl_cfg)) {
> +		.se              = 1,
> +		.csa             = 1,
> +		.ds_ring_ptr     = sdxi_sq_ring_dma(cxt->sq),
> +		.ds_ring_sz      = cxt->sq->count,
> +		.cxt_sts_ptr     = sdxi_sq_cxt_sts_dma(cxt->sq),
> +		.write_index_ptr = sdxi_sq_write_index_dma(cxt->sq),
> +	};
> +
> +	err = configure_cxt_ctl(cxt->cxt_ctl, &ctl_cfg);
> +	if (err)
> +		return err;
> +
> +	l1_idx = ID_TO_L1_INDEX(cxt->id);
> +
> +	ent = &cxt->sdxi->L1_table->entry[l1_idx];
> +
> +	L1_cfg = (typeof(L1_cfg)) {
> +		.ka          = 1,
> +		.pv          = 0,
> +		.cxt_ctl_ptr = cxt->cxt_ctl_dma,
> +		.akey_sz     = akey_table_order(cxt->akey_table),
> +		.akey_ptr    = cxt->akey_table_dma,
> +		.cxt_pasid   = IOMMU_NO_PASID,
> +		.max_buffer  = cxt->sdxi->max_buffer,
> +		.opb_000_enb = cxt->sdxi->op_grp_cap,
> +	};
> +
> +	return configure_L1_entry(ent, &L1_cfg);
> +}
> +
>  static void free_admin_cxt(void *ptr)
>  {
>  	struct sdxi_dev *sdxi = ptr;
> @@ -88,13 +227,23 @@ static void free_admin_cxt(void *ptr)
>
>  int sdxi_admin_cxt_init(struct sdxi_dev *sdxi)
>  {
> +	int err;
> +	struct sdxi_sq *sq;
> +
>  	struct sdxi_cxt *cxt __free(sdxi_cxt) = sdxi_alloc_cxt(sdxi);
>  	if (!cxt)
>  		return -ENOMEM;
>
> +	sq = cxt->sq;
> +	/* SDXI 1.0 4.1.8.4.b: Set CXT_STS.state to CXTV_RUN. */
> +	sq->cxt_sts.state = FIELD_PREP(SDXI_CXT_STS_STATE, CXTV_RUN);
>  	cxt->id = SDXI_ADMIN_CXT_ID;
>  	cxt->sq->doorbell = sdxi->dbs + cxt->id * sdxi->db_stride;
>
> +	err = sdxi_publish_cxt(cxt);
> +	if (err)
> +		return err;
> +
>  	sdxi->admin_cxt = no_free_ptr(cxt);
>
>  	return devm_add_action_or_reset(sdxi->dev, free_admin_cxt, sdxi);
> diff --git a/drivers/dma/sdxi/context.h b/drivers/dma/sdxi/context.h
> index 873ad49c3c86..ae1584d00b54 100644
> --- a/drivers/dma/sdxi/context.h
> +++ b/drivers/dma/sdxi/context.h
> @@ -18,6 +18,13 @@ struct sdxi_akey_table {
>  	struct sdxi_akey_ent entry[SZ_4K / sizeof(struct sdxi_akey_ent)];
>  };
>
> +/* For encoding the akey table size in CXT_L1_ENT's akey_sz. */
> +static inline u8 akey_table_order(const struct sdxi_akey_table *tbl)
> +{
> +	static_assert(sizeof(*tbl) == SZ_4K);
> +	return 0;
> +}
> +
>  struct sdxi_cxt {
>  	struct sdxi_dev *sdxi;
>  	u16 id;
> diff --git a/drivers/dma/sdxi/hw.h b/drivers/dma/sdxi/hw.h
> index d1917dad243f..b333e091c583 100644
> --- a/drivers/dma/sdxi/hw.h
> +++ b/drivers/dma/sdxi/hw.h
> @@ -34,8 +34,16 @@ static_assert(sizeof(struct sdxi_cxt_L2_table) == 4096);
>  /* SDXI 1.0 Table 3-3: Context Level 1 Table Entry (CXT_L1_ENT) */
>  struct sdxi_cxt_L1_ent {
>  	__le64 cxt_ctl_ptr;
> +#define SDXI_CXT_L1_ENT_VL             BIT_ULL(0)
> +#define SDXI_CXT_L1_ENT_KA             BIT_ULL(1)
> +#define SDXI_CXT_L1_ENT_PV             BIT_ULL(2)
> +#define SDXI_CXT_L1_ENT_CXT_CTL_PTR    GENMASK_ULL(63, 6)
>  	__le64 akey_ptr;
> +#define SDXI_CXT_L1_ENT_AKEY_SZ        GENMASK_ULL(3, 0)
> +#define SDXI_CXT_L1_ENT_AKEY_PTR       GENMASK_ULL(63, 12)
>  	__le32 misc0;
> +#define SDXI_CXT_L1_ENT_PASID          GENMASK(19, 0)
> +#define SDXI_CXT_L1_ENT_MAX_BUFFER     GENMASK(23, 20)
>  	__le32 opb_000_enb;
>  	__u8 rsvd_0[8];
>  } __packed __aligned(32);
> @@ -51,10 +59,17 @@ static_assert(sizeof(struct sdxi_cxt_L1_table) == 4096);
>  /* SDXI 1.0 Table 3-4: Context Control (CXT_CTL) */
>  struct sdxi_cxt_ctl {
>  	__le64 ds_ring_ptr;
> +#define SDXI_CXT_CTL_VL             BIT_ULL(0)
> +#define SDXI_CXT_CTL_QOS            GENMASK_ULL(3, 2)
> +#define SDXI_CXT_CTL_SE             BIT_ULL(4)
> +#define SDXI_CXT_CTL_CSA            BIT_ULL(5)
> +#define SDXI_CXT_CTL_DS_RING_PTR    GENMASK_ULL(63, 6)
>  	__le32 ds_ring_sz;
>  	__u8 rsvd_0[4];
>  	__le64 cxt_sts_ptr;
> +#define SDXI_CXT_CTL_CXT_STS_PTR    GENMASK_ULL(63, 4)
>  	__le64 write_index_ptr;
> +#define SDXI_CXT_CTL_WRITE_INDEX_PTR GENMASK_ULL(63, 3)
>  	__u8 rsvd_1[32];
>  } __packed __aligned(64);
>  static_assert(sizeof(struct sdxi_cxt_ctl) == 64);
> diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
> index b7d754132268..525473029987 100644
> --- a/drivers/dma/sdxi/sdxi.h
> +++ b/drivers/dma/sdxi/sdxi.h
> @@ -15,6 +15,15 @@
>
>  #include "mmio.h"
>
> +#define ID_TO_L1_INDEX(id)	((id) & 0x7F)
> +
> +#define DESC_RING_BASE_PTR_SHIFT	6
> +#define CXT_STATUS_PTR_SHIFT		4
> +#define WRT_INDEX_PTR_SHIFT		3
> +
> +#define L1_CXT_CTRL_PTR_SHIFT		6
> +#define L1_CXT_AKEY_PTR_SHIFT		12
> +
>  struct sdxi_dev;
>
>  /**
>
> --
> 2.56.0
>
>
