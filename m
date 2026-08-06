Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013015.outbound.protection.outlook.com [52.101.83.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600464CA267;
	Thu,  6 Aug 2026 19:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786043210; cv=fail; b=KIlS0RXzBJ62Pwe0zNF+Facx8hosQ2FJg1buFn34lqZ8OK8ogw0WcFg2TvNmg/HD3fz4TbZu4ivgD2Khi2+X4CIiyoOfSXYy1tzgUo5DU5+bxkmjUIeFmJ5DKXc7/K0IBEuXHE+cC/e7sEV1knw4HCpJbt0YEhuiWNbcGbu17UM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786043210; c=relaxed/simple;
	bh=402Is7P35Z0nqAvWO2Qmqm2QchONW+t75ulSUKwp9HY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RLgU1Tl0T4hrH4dlyH6xbtHYSVhdy29n4yJRhGbX71sKiX4CtkJcXxADd+XIrq20Yk8Wfv1N+Sfaigvx9m8GM4gmHK1FaXFfBqbGhr9kHY4MfOgLEJAkBb+MzP9dFkwG0k1eT1KJu/TvxLzufC3yY+kl0o4ph5c/cLMX8xrZcFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=GhBxx5Km; arc=fail smtp.client-ip=52.101.83.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GhBxx5Km"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dcjOU5lNJU6Dz41cUqv2+ajNA48i3u23VxdkODnnQRG5Nta7CWfOTh0coSz0GM5XsYuGDOIiwBGPcq4TvnuPxXOCjM29Od+/J9dYqcIwr9e4oZrnf6QQW4f8BXYmRdVw2K1Pjqx467gzy1CpBqGuRSTlmnYJp0NCwcQiRNm9gI6X84FO5AB/y3L6cMl9z6lCkpeAZH0MqklOPKVeH2d8rDVuqVOvjij1+G/2E5iyl3P0hAGY5oJRb3qIkDXoXcey8onI4rkqI60ye5TLPL1S6D/fbIYWKTb9JUrFatdM+Iw5Nsmk10bi6+eFZxFqlUD6osflUR6E4aZlgkwDLdHOSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSLG7OD4PRrgAIQlDOBajeta5g6AzcJRWZ72KTSa0Uc=;
 b=efO5sihZN+B0xKdvnGLapLFfBvV+pjtpIvLta/XivZ10f9kvYy17aII9fToEqSZ8vdJ4qTyN+mkmpgVP+93UwbA8UAdXgdQCPwcOGO5+sr7fsOjh5C0ilDn8TTFNZPZmYKzyyop2CvRu1UDX4KRGn8P4xHtSPjsZI4SE7KupW5Nh/fQlIEZytPvw4JwsJAKfSHFk53cO94B9HcdhNj7ZyRgY0FhIdgVSeGrqpwSAJribyrv7jGAp4xc0xqlskVRYW2695i6EP/pTJv1x9zHK07ds7wx+9MNoK5AtRngba87ATxots5hP380nsFkU/ksinZSZP0BjX0gGYNXSUsi40w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSLG7OD4PRrgAIQlDOBajeta5g6AzcJRWZ72KTSa0Uc=;
 b=GhBxx5Km4ef5lgOKiJh0vadTN+4DPnAcuZQ2Q5+NJIM61m142faFpi3LjxIxLGxlkO8g7qWMkSSLxpmkcaHX8YLz77JQN2vTtz8A3PKe5gclgsz/SRTbLziZlS4kYCwLmI4Hq2v8QIrUwSPskjrkn8pQOZSfWb2JIVBfy7YkEYfcOMK36u4R9L0HSH8QQ3iBQcK41zgh2tExh9HgiwbBYAJqI+KOb6mncoyIvj1XDmIRLCZKXev7YGzVbuoKmRF+2Ys0qEAJLeecDgB8SHJHP8qVn+xIdi78I7lP2WMAuX6lNkm9jtGHfKSL1W+7/FVAW0hFUTLF81dfqUR5ZWes7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GVXPR04MB10432.eurprd04.prod.outlook.com (2603:10a6:150:1e0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Thu, 6 Aug
 2026 19:06:40 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 19:06:39 +0000
Date: Thu, 6 Aug 2026 14:06:30 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, dmaengine@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/5] dmaengine: dw-edma: Add DMA_SG support
Message-ID: <anTbNsOQ02V6umXf@SMW015318>
References: <20260803-dma_multi_sg-v2-0-c12bb05e42d6@oss.qualcomm.com>
 <20260803-dma_multi_sg-v2-2-c12bb05e42d6@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803-dma_multi_sg-v2-2-c12bb05e42d6@oss.qualcomm.com>
X-ClientProxiedBy: SN7P222CA0026.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::24) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GVXPR04MB10432:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b6b48e2-b1f2-49ff-c59c-08def3edd85d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|19092799006|366016|1800799024|6133799003|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3HuFoE0cHHp9oceiKlRZOEi0RzLI6xtpV/+HE2+pv6MYPhtq4ZncrvFriKEBPCPnR7BfN86Np4LcHeXII0zsYssVZQC6Ya7H2G/cR4qP69eeoC7iPlHr3hrKmz50wUWlShMu4sKjCaTmz6f5YtB6FDGkDdbvU7yP2EaFuuj+Ym2zxiBJ6+yzVXmAsTd7nSqZHesE+PW5Np7iNiorSspwONxwINuvIrz88+YAU8q0e1smwl2EpxoFdTBxt63yskh1WuxfpVxiqNp1H/6cmcKb1+f4NY/RyxbqplAJ9EyH8Bgh5WcX/tbSe7TV8/aWxt/KgDXhMfDuGiRv8AVlfo+FpNP52oCcIClbQPnCKBQYlgo5YxkgE+kVMC0pXFJaTrYDI1qKSwKKoHVMmMYRAHTqbRKVqESe7K4zVjpuDPtx8KnRElW5ysVN6tqyAbMdBQl6ibHXK8Rz9QT45LUyvzDGOYjt+hrXXq0S1j1MIsiFRrlihTS/im5oQdkFycZ+DjxEOLMMO7Jb1ueIvqZQA5dwoDFaR6wF36R4Ux+p+bA+wjHnzF5fbz9jzaozZiOwf0IB0U5fnjklcho9hllzgFdW4++N4/QzZ7EtX9r2TkK4HnsdkGhl5af63mlJC45eDdjCwYEh2QIz7sqCvExZ71H2sdf/kkqZUczZWFY9zGsJycE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(19092799006)(366016)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kdvM8TCPFYc5YTAab6bIwmYKCxnmBqEGxnSFKgWdfuFzQdpouiI9Umayphyv?=
 =?us-ascii?Q?nSiqMm48iXtxESubme+vCAexpnU3wmD3wXJprw7Eg4tXGh5nmlOzlt6FU7W1?=
 =?us-ascii?Q?AWa68knnHp9e65O2yVz17KYs9XPMCpQme8quOOb++DTr1lXP5aHkSRz+ht4+?=
 =?us-ascii?Q?ITXzDb8NQyi0WOZTbJo9Fc6KhgBqXM3OR4mZcXnpkF2ybG/+r1pPoqgyHRrJ?=
 =?us-ascii?Q?FqnpGrkDtXJJf5KSsxPrZCiKlDxrHtGi1jPlflmLnmfs2CAfJCLklQ/DbsGQ?=
 =?us-ascii?Q?lqKVjysVEADJygzGKjNJOonsJoodifW/bafos6cTY/7pZB3DWfDDMfGa5me3?=
 =?us-ascii?Q?4nFgGiauUMoFNBP0HzjGpL7Vu3Ad02OeGw4SKlqKH99yep92YrRTw7RdCAiI?=
 =?us-ascii?Q?2FAs4p0m9bpUWwTnEWkIrfN4J2sfVJr7yLQs1MQRQK7RElfvUFjfasBm1IRK?=
 =?us-ascii?Q?BAcgNcPgb2wZouetmnUpP/SJEj8z5j6J0XoHcW+ehwD7CaLEA1SGQ82X47BQ?=
 =?us-ascii?Q?hwgWsRg4IoCEsf54G81RxOM3PTyQWEsnO5sa/ms/6TnEYFpCZs0kIzK8QhYm?=
 =?us-ascii?Q?75UCw/Nmi2K2WReSwvTqqjierPq9qRwdkZBUjNkXtXeifAQEwf7oZVBLTLL9?=
 =?us-ascii?Q?JecP8oHt+F7Du1ETlGvVAnK7AyTEbZu0ZMId0e9Hka7pQCMhS0MB7mfe91/V?=
 =?us-ascii?Q?azIr8MPAFP9vKdcMIGJkAwP/FVH8iJLNh7uF7jBHqXACb5GV8rlL18q//I84?=
 =?us-ascii?Q?WraUxCiqTkOl4ZkMEd/DhhKl6XVScP08Zo4A0qcNGzIaH9qSpZwVMCh5CMHS?=
 =?us-ascii?Q?aFHvYU9pnG5uh93XhL0JOGllo/EASlpA5qBmGuJlv+e8Yb/Moo33ZvLEpOyo?=
 =?us-ascii?Q?J7weXgBKr4p5LaHVSD9m4EKXpiiOsSbH8OHq7plTEerZ8H6gQ+ns+9TEQoTA?=
 =?us-ascii?Q?oGYEkV7KKwiFxjkVk30fkpyzwHXoZWF1t7VcuCYGm9M21zpt8e2+LeDa8amy?=
 =?us-ascii?Q?/AYflIv4KHcv7vRkLNKppSAo1mTpNrc8B2ETPrY7veAqsFNbcDSY8WkUSUNr?=
 =?us-ascii?Q?gTqUNVyMexLUT0oCgTOj51WsB57MZ1PjusWfcyQcx9yG/xvDSZHugsQm8dLC?=
 =?us-ascii?Q?WaUN6pbeGoZ3KgQ7d1ARkGMZV1tzi672i9es5jaFAe5mMjpkV+22j+AGcIzK?=
 =?us-ascii?Q?TwxvtW6C7QomrrSE8zDtBL9PnPQIarAOrmlwH3/bt5dxfnuu8XmAxWpVNULF?=
 =?us-ascii?Q?TaDM+7Qw/Dz6OS/PpKpXqXlURExtzhg8jx5Kd4FSEgZfgUu5J/FH45/G4zyZ?=
 =?us-ascii?Q?4vLr+jTbdYxb8DiTz7hHNHZN3Sunrupnnz94tLicljOgNHzvuW+G3YGiL6Oh?=
 =?us-ascii?Q?z/ZRdy69TLXXh1D1TzjieFjZnm/QkNS8TDiC40r66jv5i6Oa8bNiXyyuHvDQ?=
 =?us-ascii?Q?/tPmiWsZ1CFM7yaM+h+OLtDsgvSG1Z7oE/dglLSPXFFQ0VnFnbAgpOIf37dP?=
 =?us-ascii?Q?ipQvt8nbDCWjS80wVZG2ZF7BQispdO/i1YuBoQKgcC7m76Wjt4l28Sb+YvyT?=
 =?us-ascii?Q?v2J6OZajUEN9pgGVs2fwGYWbwZJ4VUTlDFie60UaSHgH5tfuXvtJHTPjHN05?=
 =?us-ascii?Q?YvysYj0TX3iL2Vnh0U6P/ItE+rXoMcDC9mKeJOEHE9soFvdoiXyHLDdrplpD?=
 =?us-ascii?Q?lh/fIGpu53MWgLtEQShMhbFG+pITwQojWcNPjjrh/YFTNa2vo3/0E0DtQzR8?=
 =?us-ascii?Q?BCKed+KyDbWddTNPVR0vbWhZFhlBlTzEV4m4md+cnmtjgf4UjFBF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b6b48e2-b1f2-49ff-c59c-08def3edd85d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 19:06:39.8827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQbSxJBirmvSA2KN/TJF0/l467e5x21IT0GBEtwwOVy3HSjKdgsEtXeA0SD9exx5cz5juwMT1Cl1lWYfI+MuxggMB7lX9q8MTjAKh8qox+HA7+3VVMkZYdX50hj8qH8y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10432

On Mon, Aug 03, 2026 at 04:01:44PM +0530, Sumit Kumar wrote:
> [You don't often get email from sumit.kumar@oss.qualcomm.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Synopsys DesignWare eDMA supports a linked-list mode where each list item
> carries independent source and destination addresses, letting multiple
> independent memory transfers be described in one linked list and submitted
> to the hardware as a single DMA transaction. The IP processes list items
> strictly in order, so paired scatter-gather entries are never reordered.
>
> Implement the DMA_SG capability by adding a new EDMA_XFER_DUAL_SG transfer
> type and a corresponding struct dw_edma_dual_sg carrying the paired source
> and destination SG lists. dw_edma_device_transfer() walks both lists in
> lockstep, building a single hardware linked-list; a per-entry length
> mismatch or premature list end fails the whole request.

It is not as simple as it.  for example, if you want to transfer 9k data
from src to dest

src virtual addr 0x1004,        dest 0xA0001008

when map_sg, src's sg maybe

0x1000  .. 4k   offset 4,
0x9000  .. 4k   offset 0
0xA000  .. 4k   offset 0

or
0x1000 .. 8k  offset 4
0xA000 .. 4k  offset 0

which totally depend on physical address allocation although most likely
first case happen

dest sg
0xA001000 .. 4k offset 8
0xA008000 .. 4k offset 0
0xA00E000 .. 4k offset 0

descriptors
1 	transfer 4k-8
2       transfer tail 4 byte
3 	transfer 4k-8
4       transfer tail 4 byte
...

the start address of src and dest is highly possible differences. So it
is very hard to match your requirement, both sg's structure is the same.

Frank

>
> The transfer direction is inferred from the channel hardware polarity
> (EDMA_DIR_READ/WRITE), not from dma_slave_config.direction: for local eDMA
> (DW_EDMA_CHIP_LOCAL) read channels handle DEV_TO_MEM and write channels
> handle MEM_TO_DEV; for remote eDMA the mapping is inverted. PCIe bus
> addresses are translated via dw_edma_get_pci_address() for the remote side
> of each transfer. dmaengine_slave_config() must still be called before
> dmaengine_prep_dma_sg() because dw_edma_device_transfer() gates transfers
> on chan->configured, even though the direction field itself is unused by
> the DMA_SG path.
>
> Signed-off-by: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
> ---
>  drivers/dma/dw-edma/dw-edma-core.c | 87 +++++++++++++++++++++++++++++++++++---
>  drivers/dma/dw-edma/dw-edma-core.h | 10 ++++-
>  2 files changed, 90 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 1f893dc54c7938a9c45bafd975a4f99fdc0acb38..9fbfa5ad65b5421b164d2ab9883233225e0269e4 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -372,6 +372,7 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
>         struct dw_edma_chan *chan = dchan2dw_edma_chan(xfer->dchan);
>         enum dma_transfer_direction dir = xfer->direction;
>         struct scatterlist *sg = NULL;
> +       struct scatterlist *dst_sg = NULL;
>         struct dw_edma_burst *burst;
>         struct dw_edma_desc *desc;
>         u64 src_addr, dst_addr;
> @@ -429,6 +430,9 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
>                         return NULL;
>                 if (!xfer->xfer.il->src_inc || !xfer->xfer.il->dst_inc)
>                         return NULL;
> +       } else if (xfer->type == EDMA_XFER_DUAL_SG) {
> +               if (xfer->xfer.dual_sg.len < 1)
> +                       return NULL;
>         } else {
>                 return NULL;
>         }
> @@ -441,16 +445,27 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
>                 dst_addr = config->dst_addr;
>         }
>
> -       if (dir == DMA_DEV_TO_MEM)
> -               src_addr = dw_edma_get_pci_address(chan, (phys_addr_t)src_addr);
> -       else
> -               dst_addr = dw_edma_get_pci_address(chan, (phys_addr_t)dst_addr);
> +       /*
> +        * DUAL_SG translates each src/dst sg entry individually below
> +        * (see the burst->sar/burst->dar assignment), so it is exempt
> +        * from the single up-front translation used by other types.
> +        */
> +       if (xfer->type != EDMA_XFER_DUAL_SG) {
> +               if (dir == DMA_DEV_TO_MEM)
> +                       src_addr = dw_edma_get_pci_address(chan, (phys_addr_t)src_addr);
> +               else
> +                       dst_addr = dw_edma_get_pci_address(chan, (phys_addr_t)dst_addr);
> +       }
>
>         if (xfer->type == EDMA_XFER_CYCLIC) {
>                 cnt = xfer->xfer.cyclic.cnt;
>         } else if (xfer->type == EDMA_XFER_SCATTER_GATHER) {
>                 cnt = xfer->xfer.sg.len;
>                 sg = xfer->xfer.sg.sgl;
> +       } else if (xfer->type == EDMA_XFER_DUAL_SG) {
> +               cnt = xfer->xfer.dual_sg.len;
> +               sg = xfer->xfer.dual_sg.src_sgl;
> +               dst_sg = xfer->xfer.dual_sg.dst_sgl;
>         } else if (xfer->type == EDMA_XFER_INTERLEAVED) {
>                 cnt = xfer->xfer.il->numf * xfer->xfer.il->frame_size;
>                 fsz = xfer->xfer.il->frame_size;
> @@ -463,12 +478,23 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
>         for (i = 0; i < cnt; i++) {
>                 if (xfer->type == EDMA_XFER_SCATTER_GATHER && !sg)
>                         break;
> +               /*
> +                * DUAL_SG walks the source and destination lists in lockstep;
> +                * a premature end or a per-entry length mismatch would leave
> +                * the descriptor partially built, so fail the whole request.
> +                */
> +               if (xfer->type == EDMA_XFER_DUAL_SG &&
> +                   (!sg || !dst_sg || sg_dma_len(sg) != sg_dma_len(dst_sg))) {
> +                       kfree(desc);
> +                       return NULL;
> +               }
>
>                 burst = desc->burst + i;
>
>                 if (xfer->type == EDMA_XFER_CYCLIC)
>                         burst->sz = xfer->xfer.cyclic.len;
> -               else if (xfer->type == EDMA_XFER_SCATTER_GATHER)
> +               else if (xfer->type == EDMA_XFER_SCATTER_GATHER ||
> +                        xfer->type == EDMA_XFER_DUAL_SG)
>                         burst->sz = sg_dma_len(sg);
>                 else if (xfer->type == EDMA_XFER_INTERLEAVED)
>                         burst->sz = xfer->xfer.il->sgl[i % fsz].size;
> @@ -492,6 +518,9 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
>                                  */
>                         } else if (xfer->type == EDMA_XFER_INTERLEAVED) {
>                                 burst->dar = dst_addr;
> +                       } else if (xfer->type == EDMA_XFER_DUAL_SG) {
> +                               burst->sar = dw_edma_get_pci_address(chan, sg_dma_address(sg));
> +                               burst->dar = sg_dma_address(dst_sg);
>                         }
>                 } else {
>                         burst->dar = dst_addr;
> @@ -507,13 +536,19 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
>                                  * and destination addresses are increased
>                                  * by the same portion (data length)
>                                  */
> -                       }  else if (xfer->type == EDMA_XFER_INTERLEAVED) {
> +                       } else if (xfer->type == EDMA_XFER_INTERLEAVED) {
>                                 burst->sar = src_addr;
> +                       } else if (xfer->type == EDMA_XFER_DUAL_SG) {
> +                               burst->sar = sg_dma_address(sg);
> +                               burst->dar = dw_edma_get_pci_address(chan, sg_dma_address(dst_sg));
>                         }
>                 }
>
>                 if (xfer->type == EDMA_XFER_SCATTER_GATHER) {
>                         sg = sg_next(sg);
> +               } else if (xfer->type == EDMA_XFER_DUAL_SG) {
> +                       sg = sg_next(sg);
> +                       dst_sg = sg_next(dst_sg);
>                 } else if (xfer->type == EDMA_XFER_INTERLEAVED) {
>                         struct dma_interleaved_template *il = xfer->xfer.il;
>                         struct data_chunk *dc = &il->sgl[i % fsz];
> @@ -613,6 +648,44 @@ static void dw_hdma_set_callback_result(struct virt_dma_desc *vd,
>         res->residue = residue;
>  }
>
> +static struct dma_async_tx_descriptor *
> +dw_edma_device_prep_dma_sg(struct dma_chan *dchan,
> +                          struct scatterlist *dst_sg, unsigned int dst_nents,
> +                          struct scatterlist *src_sg, unsigned int src_nents,
> +                          unsigned long flags)
> +{
> +       struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> +       struct dw_edma_transfer xfer;
> +       enum dma_transfer_direction dir;
> +
> +       if (src_nents != dst_nents || !src_nents)
> +               return NULL;
> +
> +       if (!src_sg || !dst_sg)
> +               return NULL;
> +
> +       /* Determine direction from channel configuration */
> +       if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL)
> +               dir = (chan->dir == EDMA_DIR_READ) ? DMA_DEV_TO_MEM : DMA_MEM_TO_DEV;
> +       else
> +               dir = (chan->dir == EDMA_DIR_WRITE) ? DMA_DEV_TO_MEM : DMA_MEM_TO_DEV;
> +
> +       xfer.dchan = dchan;
> +       xfer.direction = dir;
> +       xfer.xfer.dual_sg.src_sgl = src_sg;
> +       xfer.xfer.dual_sg.dst_sgl = dst_sg;
> +       xfer.xfer.dual_sg.len = src_nents;
> +       xfer.flags = flags;
> +       xfer.type = EDMA_XFER_DUAL_SG;
> +
> +       /*
> +        * dw_edma_device_transfer() rejects unconfigured channels, so
> +        * dmaengine_slave_config() must have been called on this channel
> +        * beforehand even though the direction field is unused here.
> +        */
> +       return dw_edma_device_transfer(&xfer, dw_edma_device_get_config(dchan, NULL));
> +}
> +
>  static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
>  {
>         struct dw_edma_desc *desc;
> @@ -997,6 +1070,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
>         dma_cap_set(DMA_CYCLIC, dma->cap_mask);
>         dma_cap_set(DMA_PRIVATE, dma->cap_mask);
>         dma_cap_set(DMA_INTERLEAVE, dma->cap_mask);
> +       dma_cap_set(DMA_SG, dma->cap_mask);
>         dma->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
>         dma->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
>         dma->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
> @@ -1017,6 +1091,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
>         dma->device_prep_config_sg = dw_edma_device_prep_config_sg;
>         dma->device_prep_dma_cyclic = dw_edma_device_prep_dma_cyclic;
>         dma->device_prep_interleaved_dma = dw_edma_device_prep_interleaved_dma;
> +       dma->device_prep_dma_sg = dw_edma_device_prep_dma_sg;
>
>         dma_set_max_seg_size(dma->dev, U32_MAX);
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> index f6a5ad31756723e6fd72f7d9d903a1204e25c0b0..e3219ae96d84f528fb7d77dbe3a0b3d7c1264f05 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-core.h
> @@ -38,7 +38,8 @@ enum dw_edma_status {
>  enum dw_edma_xfer_type {
>         EDMA_XFER_SCATTER_GATHER = 0,
>         EDMA_XFER_CYCLIC,
> -       EDMA_XFER_INTERLEAVED
> +       EDMA_XFER_INTERLEAVED,
> +       EDMA_XFER_DUAL_SG,
>  };
>
>  struct dw_edma_chan;
> @@ -151,6 +152,12 @@ struct dw_edma_sg {
>         unsigned int                    len;
>  };
>
> +struct dw_edma_dual_sg {
> +       struct scatterlist              *src_sgl;
> +       struct scatterlist              *dst_sgl;
> +       unsigned int                    len;
> +};
> +
>  struct dw_edma_cyclic {
>         dma_addr_t                      paddr;
>         size_t                          len;
> @@ -163,6 +170,7 @@ struct dw_edma_transfer {
>                 struct dw_edma_sg               sg;
>                 struct dw_edma_cyclic           cyclic;
>                 struct dma_interleaved_template *il;
> +               struct dw_edma_dual_sg          dual_sg;
>         } xfer;
>         enum dma_transfer_direction     direction;
>         unsigned long                   flags;
>
> --
> 2.34.1
>
