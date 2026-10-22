Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792683711;
	b=wnh3X7ztqJMFMpccfNZa7nJzWXVwKRj2YHHeGxbRwinCab2ox5XLfQocuUk/GYyhPKpy
	 L7yMTRTp6yCnj8EB1/tPR5n4kdLrqey5khtob1Qjex1TONepMCiTKGr7ywXL2IRAtLpeF
	 8+IpQbQwQ4O23xDS5Nun8PMZ+Dx7Xa9Wa92Y9bOV0DklWIYBDb0Eh/GGR5hHlPBEmWCrv
	 s6AfnorD6MfTh+4JFXA8Ud3Cgf8ryOOEByHbICqcHCHWf3wMTfbwQ+yf1HFR/ic/Qv9xw
	 laYz9ra3zz/W7/N4DOqpRE002wQi0LlpBXnpmqjiV2FwQPz/yVJow6kmpEr02YBF48Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792683711;
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
	bh=Avl2LkyW5D67y04fWOTLBuBJzw/7OeIeW8X3zWSDbAI=;
	b=5U/z5IYo/zBXwkJBRkzeRZ8fcWaF88lYc51MTNE2NRB0qLxWFxlbOmd0u6D468bwqZ1Q
	 SN6Z0OTj8a+IDLTZM6TEd4/G5drX/WODV3+0agANaEG68uYmd1nYaipFIhxA2wE2DvH/7
	 hm8zAcKI8nYdPqIR9rfuMgoT5eLTgF0LMsrIi3KKAigC9+qmPzRR2lSMVo42hv7+A1gGt
	 I4G1jBHR+rhhB2S9n7A0ygcckfas+cy0XlniATrlIaF7Do9jb/RiDADsPba7boa5Zg7sI
	 N8aDBFdgIlPMiqPnt0e4WG5DzLktTU/k6H+4BOsDKk1rhIC9xQY+kObYq8OlyM6CfYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=IsGGCw4s;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.16
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013016.outbound.protection.outlook.com [52.101.72.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC55E606A319;
	Thu, 22 Oct 2026 15:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC55E606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=IsGGCw4s
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4JB/vXsMpdHulmaO9baPz2BLv+gmxEVezlXMztBiqLbdTpHqAOskmSryBwZdKk0dNC/NwF4Su9slL8Fp7yUvspks8uPynWlx1vXq6hWx00eRE6HPqDeNv3WUoYKKl1QHxHuqFSc/UoXLbE9BXdvI0b9MbLg54f+FHzM/PCt+BpMQow74yoyySSoc7XWQ6vioztYPxLk9nTvGKgNiUA0I+9/vXBpeuqvb7HHj2Mzljx3fskYuR/Sr6UDfjRF3r3mqsV3hvAzvHvV9wK21ZisQUj8y0DosiEtdSCFmpfIf57toiBe+9JKOAf377h77QkI6Z5uAQKVi62t1lnEyFGimw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Avl2LkyW5D67y04fWOTLBuBJzw/7OeIeW8X3zWSDbAI=;
 b=TZYXbYaoo9E5xVcjYj60xFTWUeCVyf2stSM7gRH37oUQd17K2hgumOJtaiUJxtAjWJMAzkcWXVDXAU2L26JCICMunZAuNhwTY1ALIkg5zIRpKwUCtv/lZhykMhlPgg6/60Umnjz1AuACFn0r+G/oASr7owzbBQc2V48toC/CZOIHGcwzvB8ZMHySc2J2vBFRBb9QFKEIF4pnrgprqy8dvVy2mrLsb/oVZ4T8XszkR8APEEkNkPj+JdP2cdPJ+IKh+RfPjXKPrOaf7wWtRFbm3B3k3KYTD7IhC8YegBUG3hTDd8vzjSTZVRFqnJoQ1fRqKzHoguBiS0G/bAqfLdFOVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Avl2LkyW5D67y04fWOTLBuBJzw/7OeIeW8X3zWSDbAI=;
 b=IsGGCw4sWqj+LZNaHdUxFCqfQm8DQ2agXU5/pam2qMIlBIeaX8AMdcCw4aw3UCZAYD586pwUi50uHkKEvu4xyEpzI+U/OjwDsG5dL/RvN5sB43XVHdZet1g4Rt8GhT9A2ZD+KmhNQM7PT8JDpjX4zSFdwr3kDLV86misQbx7iUAv7DhE8cNHT74xV0ruAbJczCSZ+w8DeBTB3okiCwWivZauSUlEUf6lt5S6DLyucgv7diwOLr2F80eyGfsin8LDgXTb2Z6Cn2q8JglvDAFmxACsRtzzLZXmP4bZcdxDZG0VMJTr5jKXgB3QTNM5yImNR91TPE6owVsj/j66v5ZyFg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by OSKPR04MB11341.eurprd04.prod.outlook.com (2603:10a6:e10:98::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 15:41:47 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 15:41:47 +0000
Date: Thu, 22 Oct 2026 10:41:36 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Frank Li <Frank.Li@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>, Niklas Cassel <cassel@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v8 06/10] PCI: endpoint: pci-epf-vntb: Allow DMA and MW
 to share a BAR
Message-ID: <atousD6l53-VzTIT@SMW015318>
References: <20261022082230.3164834-1-den@valinux.co.jp>
 <20261022082230.3164834-7-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022082230.3164834-7-den@valinux.co.jp>
X-ClientProxiedBy: DS7P220CA0093.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:25a::17) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|OSKPR04MB11341:EE_
X-MS-Office365-Filtering-Correlation-Id: 5983e063-3f86-45d6-9a6f-08df3052fb4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|1800799024|7416014|376014|366016|6133799003|18002099003|22082099003|3023799007|4143699003|11063799006|261009223027099003|261021123027099003|261021121427099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	7NIqPJlyyOv2uEQxo7J5RYNSSQ1sr56RDlPKfOVaMBIRm8X1xQRMs5T6fHTgcS9j8tThqoh4hY6aU4GbVRy7C1WCphiw2NxfnTKS7wcDur34jp+cy6xwsf6MDfrN/NCrZbKzG45KPax/uYraTrQU1mZujOJa2WZv1lZPl1Lt4fJw81bEbHPzJeWSVnulclCAgxFwDZQUu5awu18y7dmavsNgoY4+ScdBD5nt2nQUXxcBpS19MXHjKCTlf+BkWfahz9qdzAORquaIKc+hH2rKTcdCZaRtMYFj2G4eiubo1cWQmdfXsDeZBNsqEAjajmTFNfH2zSO8hBXL+0OBH0dmjjkBUFcfZHGQPadGFKrLH8D25hQrmfLQwbZDi1bub0uM3AF9AJqM2DFeTT53qocTAvT8SNVgfQRCGXrGgaqfjSR9AaMqtxq70bI+qEQvyVJBjsQZnScdwp2QXHmJdWIq1NmlKnXlnDkjjGVDvpY9EsbkGr9aT1yJJVNiG7qEr5t8NKVrQM1Gs4rSkROH/DNnT0Rex0GnDq4qEMHS3eibbsfp5Rd3Ld/NvCs5ga2CPMxOLkfqLvbCJKrgXfApjnDNgZRnv/606iZQGZviYWpJC1YZqdkebY0h+Y+6kRgq3Dda
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(7416014)(376014)(366016)(6133799003)(18002099003)(22082099003)(3023799007)(4143699003)(11063799006)(261009223027099003)(261021123027099003)(261021121427099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U2m3tbWqirWFJKA8blyiqh9WCYqsOZwMzhOQNYykDLfxKtWikPDd8enru143?=
 =?us-ascii?Q?myAyMcH8RCYLmnA+DM0OaIZyK+zyo/PdvJTM56mWnotSIyC5QBXpy46E7xKN?=
 =?us-ascii?Q?3KmsQdJvY8R26kqp12tesYuewOnM7rzORC92ut4SslwdNQSGr03QHRWbaZ+6?=
 =?us-ascii?Q?8Iw/q0ufNq8NcU/dYAL+VPljD1jGeH6/nCYyYkPbZqap55As+PKivU0cFexF?=
 =?us-ascii?Q?k7meLvEvABZWjfs24DQCX5mVIsshIShCHv0MEIJK/hRSjKgTIPwIzVRrq/cc?=
 =?us-ascii?Q?9RpQ7/pV//YpQfpx9el6zTGHCUiGP8SH3o8KjtVya73Oi2uc9RP4xy77sTOd?=
 =?us-ascii?Q?cGYmJibs6ySr//o9UglBsB/CMpL7SCQU5dNLCzAlV4a7ClV/m9rlZFIiTXe5?=
 =?us-ascii?Q?II8pEJLIJ75BbBODzNn7F8gV/hgch5zXNOmz9AHNzrrNKvT7MRINMrrShtwN?=
 =?us-ascii?Q?sPYtFpUF2Pw44hgaB/j3CFyqMxMBuP7qrktWGgrCpDWebBMBD/wPcrx6EMAZ?=
 =?us-ascii?Q?QH368BcdDp7i5dw6WY+9rQqlfNAToKcZXwR51o0gq0aUej3bntlVAqPItkW+?=
 =?us-ascii?Q?FD0+wQ3Zcz2fcozJgmijmvkrv7tDTBIZQVlOWqG4cVv2nt829g/BTMtatcdV?=
 =?us-ascii?Q?AMm/RoA2hZNnP7nXSAyf/wKHX7q0d9g1Jzts8wIynLn93lIL+B8ojFDlnV2w?=
 =?us-ascii?Q?Z03jjqzP4xYFev0WkNkJA6p87g3ZRwXo7CQTjgn7i4Jw2LKTjg9yM1DkW0mz?=
 =?us-ascii?Q?FPOdDlCtQpWiRSInx91gD5eZUqNgwTVdP9eF634I+9RYpdpx0A6sREZFhopi?=
 =?us-ascii?Q?hqV7AeZkfFu9p48O7259sRAoBQAAhD2IR/GI/4+m594pCobAPyDXZjs8np5M?=
 =?us-ascii?Q?F9ff1y09TfJVfwZEMhvnDK0rhmKqnU70eb80/J1llLbcSx26uBvPDR+g8Pci?=
 =?us-ascii?Q?bKNPZ/6iwz9IdQQxnzLFddgihyJZQWOHqD/gsrKfdG5B7i2Rp5d0ILw2bNoK?=
 =?us-ascii?Q?jINXYPSWmpDO3vqjv8x/dLxzyK6IiEGo7eVRu6BQeWV23dkvp6WujiM7EoAS?=
 =?us-ascii?Q?ZbbvGnJJVXX8+beiJrJEtFsoV4J/AxpTCaI+jGcyix/y1fWMtUD9nM3i03UM?=
 =?us-ascii?Q?GufMlvHECpyGCIzmspJ/OESU6oD8eMa0B/KEClkGQOyoNavNewEWs4eRm91H?=
 =?us-ascii?Q?fFtA5HHUiSlS/VrSS7+w0USpk0xw10ztGz1iUCWDk0jh5R2isqRTLjl85RqL?=
 =?us-ascii?Q?gV138DxIAKPBd8Jch4wu1z3syNMAUyt0A2xvpUUKau4ZHcnLWepphBjFrxTN?=
 =?us-ascii?Q?AlM4ld1H1K8sj+3qDF3GZ4tw0WTT7DFtUZBkzUt9NLBuJjy/P6S2PY69N9Dx?=
 =?us-ascii?Q?EwRDxUnv7301wBW4MB08pP59qnZ5XSI6psQxwWCMXpXpAlEpFNvBE1Iwgtnq?=
 =?us-ascii?Q?xgj9QYkGRJ+XmW9gI0fGMJegDtIt89NLTbdOoHo9G1r1X6nnwWwZ2uzeUSLR?=
 =?us-ascii?Q?7cXPzPLsEzmfJiDjU5nl1jtw0lc1GWihW2Y8E9Q3deLArIa10g/uZKt7V5Ck?=
 =?us-ascii?Q?NT5LmENgK/VEom3JYtQkA6WIslWjEhZ4ZdqbJdq3LAgtfoa9pDDTsJYLGNCP?=
 =?us-ascii?Q?JI3QS0ug7Pqc5zBw87Oep474fjRaAffhFiwgATMvVw7ot0P6oTitEqBJy6Ws?=
 =?us-ascii?Q?Wn6qeC51E+8zd5yeo71CsmW2GnTr7uC4GzVZQsxWf8KufEU6DJW/UbEXNQva?=
 =?us-ascii?Q?YYveyJM8/w8wtOCg6UEik2kc2PiD2IaZlXgen5kDrH/O66lX2deq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5983e063-3f86-45d6-9a6f-08df3052fb4d
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 15:41:47.3081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dFHJ7zzFI/T3KWyKpkDk3r/Wuan61SJMyvQdIO7iXaiu/VZb3lB/tL2GqAHvmV+6VJ2NmqCjEYJWX4uXEhzGV5P6bLyv7XTIj4r6RZKrBv4ayZ67VlP+g/OS9lgLko9V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11341

On Thu, Oct 22, 2026 at 05:22:26PM +0900, Koichiro Den wrote:
> Some endpoint configurations have no spare BAR for DMA resources. Allow
> dma_bar to select an MW BAR and place the DMA ranges after that MW.
>
> DMA submaps have fixed BAR offsets, so a shared MW translation must
> cover its configured size. Report that size as the translation alignment
> and require it to be a power of two.
>
> Older hosts treat the whole BAR as an MW. Fall back to that layout when
> LINK_UP does not advertise MW/DMA boundary support, so that NTB keeps
> working without DMA: the enumerated BAR size is kept, the MW spans the
> whole BAR and the DMA submaps are removed.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes since v7:
>   - Fall back to exposing the whole shared BAR as an MW for hosts without
>     MW/DMA boundary support, instead of rejecting LINK_UP. (Frank)
>   - Share BAR update and rollback code between DMA submaps and fallback.
>   - Link to v7: https://lore.kernel.org/r/20261021042229.2280937-7-den@valinux.co.jp/
>
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 220 ++++++++++++++----
>  include/linux/pci-epf-ntb.h                   |   3 +
>  2 files changed, 178 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index ac83af54122f..2f41a37a2e9d 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -84,15 +84,17 @@ enum epf_irq_slot {
>  #define MIN_DB_COUNT			(EPF_IRQ_DB_START + 1)
>
>  struct epf_ntb_dma {
> +	struct mutex lock; /* Serialize DMA submap and MW updates */
>  	struct epf_ntb_dma_ctrl ctrl;
>  	struct dma_chan *dchan[EDMA_MAX_RD_CH];
>  	void *bar_scratch;
>  	dma_addr_t bar_scratch_phys;
>  	size_t bar_scratch_size;
> -	struct pci_epf_bar_submap submap[EDMA_MAX_RD_CH + 2];
> +	struct pci_epf_bar_submap submap[EDMA_MAX_RD_CH + 3];
>  	struct pci_epf_bar_submap *reg_submap;
>  	unsigned int num_submap;
>  	u16 rd_ch_cnt;
> +	bool mw_fallback; /* The MW spans the whole shared BAR */
>  };
>
>  struct epf_ntb {
> @@ -229,6 +231,22 @@ static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
>  	return false;
>  }
>
> +static u64 epf_ntb_dma_bar_offset(struct epf_ntb *ntb, enum pci_barno barno)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < ntb->num_mws; i++)
> +		if (ntb->epf_ntb_bar[BAR_MW1 + i] == barno)
> +			return ntb->mws_size[i];
> +
> +	return 0;
> +}
> +
> +static bool epf_ntb_dma_shares_bar(struct epf_ntb *ntb, enum pci_barno barno)
> +{
> +	return ntb->dma && ntb->epf_ntb_bar[BAR_DMA] == barno;
> +}
> +
>  struct epf_ntb_dma_filter {
>  	struct device *dev;
>  	int chan_id;
> @@ -353,6 +371,7 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
>  	unsigned int i;
>  	size_t align;
>  	u32 next = 0;
> +	u64 offset;
>  	int ret;
>
>  	if (ctrl->u.dma_ctrl.reg_layout_data != EDMA_MF_EDMA_UNROLL)
> @@ -371,10 +390,31 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
>  	if (!is_power_of_2(align))
>  		return -EINVAL;
>
> -	if (epf_ntb_is_bar_used(ntb, barno) ||
> -	    pci_epc_get_next_free_bar(features, barno) != barno)
> +	if (barno == ntb->epf_ntb_bar[BAR_CONFIG] ||
> +	    barno == ntb->epf_ntb_bar[BAR_DB])
>  		return -EINVAL;
>
> +	offset = epf_ntb_dma_bar_offset(ntb, barno);
> +	if (!offset &&
> +	    (epf_ntb_is_bar_used(ntb, barno) ||
> +	     pci_epc_get_next_free_bar(features, barno) != barno))
> +		return -EINVAL;
> +	if (offset > U32_MAX)
> +		return -EOVERFLOW;
> +	if (offset && !is_power_of_2(offset))
> +		return -EINVAL;
> +	dma->ctrl.submap.offset = offset;
> +	next = offset;
> +	if (next) {
> +		/*
> +		 * submap[0] covers the MW prefix. Keep its temporary
> +		 * target at address 0 until the MW translation is
> +		 * installed.
> +		 */
> +		dma->submap[0].size = next;
> +		dma->num_submap = 1;
> +	}
> +
>  	dma->ctrl.magic = EPF_NTB_DMA_MAGIC;
>  	dma->ctrl.revision = EPF_NTB_DMA_REVISION;
>  	dma->ctrl.type = EPF_NTB_DMA_TYPE_DW_EDMA;
> @@ -408,7 +448,7 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
>  		chan->desc_addr_lo = lower_32_bits(dma_addr);
>  		chan->desc_addr_hi = upper_32_bits(dma_addr);
>  	}
> -	dma->ctrl.submap.size = next;
> +	dma->ctrl.submap.size = next - dma->ctrl.submap.offset;
>
>  	dma_dev = ntb->epf->epc->dev.parent;
>  	for (i = 0; i < dma->rd_ch_cnt; i++) {
> @@ -481,6 +521,8 @@ static int epf_ntb_dma_collect(struct epf_ntb *ntb)
>  	if (!dma)
>  		return -ENOMEM;
>
> +	mutex_init(&dma->lock);
> +
>  	switch (ctrl->u.dma_ctrl.reg_layout) {
>  	case PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA:
>  		ret = epf_ntb_dw_edma_collect(ntb, dma, ctrl, resources, count);
> @@ -551,7 +593,7 @@ static int epf_ntb_dma_bar_init(struct epf_ntb *ntb)
>  		return -EOPNOTSUPP;
>
>  	barno = ntb->epf_ntb_bar[BAR_DMA];
> -	mapped_size = dma->ctrl.submap.size;
> +	mapped_size = dma->ctrl.submap.offset + dma->ctrl.submap.size;
>  	/*
>  	 * Submaps cannot be installed until the host assigns the BAR address.
>  	 * Use address 0 for the temporary BAR Match Mode mapping, as is done
> @@ -607,23 +649,29 @@ static void epf_ntb_dma_bar_clear(struct epf_ntb *ntb)
>  	memset(bar, 0, sizeof(*bar));
>  }
>
> -static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
> +static int epf_ntb_dma_set_bar_locked(struct epf_ntb *ntb, bool use_submap,
> +				      const dma_addr_t *mw_addr)
>  {
> -	struct pci_epf_bar_submap *old_submap;
>  	struct epf_ntb_dma *dma = ntb->dma;
> -	unsigned int old_num_submap;
> -	struct pci_epf_bar *bar;
> +	struct pci_epf_bar *bar, old_bar;
> +	dma_addr_t old_mw_addr;
>  	int restore, ret;
>
> -	if (!dma)
> -		return 0;
> +	lockdep_assert_held(&dma->lock);
>
>  	bar = &ntb->epf->bar[ntb->epf_ntb_bar[BAR_DMA]];
> -
> -	old_submap = bar->submap;
> -	old_num_submap = bar->num_submap;
> -	bar->submap = dma->submap;
> -	bar->num_submap = dma->num_submap;
> +	old_bar = *bar;
> +	old_mw_addr = dma->submap[0].phys_addr;
> +	if (use_submap) {
> +		if (mw_addr)
> +			dma->submap[0].phys_addr = *mw_addr;
> +		bar->submap = dma->submap;
> +		bar->num_submap = dma->num_submap;
> +	} else {
> +		bar->submap = NULL;
> +		bar->num_submap = 0;
> +		bar->phys_addr = mw_addr ? *mw_addr : 0;
> +	}
>
>  	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
>  			      ntb->epf->vfunc_no, bar);
> @@ -631,8 +679,8 @@ static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
>  		return 0;
>
>  	/* A failed dynamic update may have already removed the old mapping. */
> -	bar->submap = old_submap;
> -	bar->num_submap = old_num_submap;
> +	dma->submap[0].phys_addr = old_mw_addr;
> +	*bar = old_bar;
>  	restore = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
>  				  ntb->epf->vfunc_no, bar);
>  	if (restore)
> @@ -642,6 +690,51 @@ static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
>  	return ret;
>  }
>
> +static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
> +{
> +	struct epf_ntb_dma *dma = ntb->dma;
> +
> +	if (!dma)
> +		return 0;
> +
> +	guard(mutex)(&dma->lock);
> +
> +	return epf_ntb_dma_set_bar_locked(ntb, true, NULL);
> +}
> +
> +static int epf_ntb_dma_link_up(struct epf_ntb *ntb, u32 argument)
> +{
> +	struct epf_ntb_dma *dma = ntb->dma;
> +	struct pci_epf_bar *bar;
> +	bool fallback;
> +	int ret;
> +
> +	if (!dma || !dma->ctrl.submap.offset)
> +		return 0;
> +
> +	fallback = !(argument & EPF_NTB_LINK_UP_DMA_MW_SUPPORTED);
> +
> +	guard(mutex)(&dma->lock);
> +
> +	if (fallback == dma->mw_fallback)
> +		return 0;
> +
> +	if (fallback) {
> +		dev_warn(&ntb->epf->dev,
> +			 "Host does not support MW/DMA BAR sharing, exposing the whole BAR as an MW\n");
> +		/* Replace installed DMA submaps until the MW is set up. */
> +		bar = &ntb->epf->bar[ntb->epf_ntb_bar[BAR_DMA]];
> +		if (bar->num_submap) {
> +			ret = epf_ntb_dma_set_bar_locked(ntb, false, NULL);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +	dma->mw_fallback = fallback;
> +
> +	return 0;
> +}
> +
>  /**
>   * epf_ntb_configure_mw() - Configure the Outbound Address Space for VHOST
>   *   to access the memory window of HOST
> @@ -780,7 +873,9 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
>  					     EPF_NTB_COMMAND_STATUS_OK;
>  		break;
>  	case EPF_NTB_COMMAND_LINK_UP:
> -		ret = epf_ntb_set_link_enabled(ntb, true);
> +		ret = epf_ntb_dma_link_up(ntb, argument);
> +		if (!ret)
> +			ret = epf_ntb_set_link_enabled(ntb, true);
>  		if (ret < 0)
>  			ctrl->command_status = EPF_NTB_COMMAND_STATUS_ERROR;
>  		else
> @@ -1269,6 +1364,7 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
>   */
>  static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
>  {
> +	bool shared;
>  	int ret = 0;
>  	int i;
>  	u64 size;
> @@ -1278,22 +1374,25 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
>  	for (i = 0; i < ntb->num_mws; i++) {
>  		size = ntb->mws_size[i];
>  		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
> -
> -		ntb->epf->bar[barno].barno = barno;
> -		ntb->epf->bar[barno].size = size;
> -		ntb->epf->bar[barno].addr = NULL;
> -		ntb->epf->bar[barno].phys_addr = 0;
> -		ntb->epf->bar[barno].flags |= upper_32_bits(size) ?
> -				PCI_BASE_ADDRESS_MEM_TYPE_64 :
> -				PCI_BASE_ADDRESS_MEM_TYPE_32;
> -
> -		ret = pci_epc_set_bar(ntb->epf->epc,
> -				      ntb->epf->func_no,
> -				      ntb->epf->vfunc_no,
> -				      &ntb->epf->bar[barno]);
> -		if (ret) {
> -			dev_err(dev, "MW set failed\n");
> -			goto err_alloc_mem;
> +		shared = epf_ntb_dma_shares_bar(ntb, barno);
> +
> +		if (!shared) {
> +			ntb->epf->bar[barno].barno = barno;
> +			ntb->epf->bar[barno].size = size;
> +			ntb->epf->bar[barno].addr = NULL;
> +			ntb->epf->bar[barno].phys_addr = 0;
> +			ntb->epf->bar[barno].flags |= upper_32_bits(size) ?
> +					PCI_BASE_ADDRESS_MEM_TYPE_64 :
> +					PCI_BASE_ADDRESS_MEM_TYPE_32;
> +
> +			ret = pci_epc_set_bar(ntb->epf->epc,
> +					      ntb->epf->func_no,
> +					      ntb->epf->vfunc_no,
> +					      &ntb->epf->bar[barno]);
> +			if (ret) {
> +				dev_err(dev, "MW set failed\n");
> +				goto err_alloc_mem;
> +			}
>  		}
>
>  		/* Allocate EPC outbound memory windows to vpci vntb device */
> @@ -1310,10 +1409,11 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
>  	return ret;
>
>  err_set_bar:
> -	pci_epc_clear_bar(ntb->epf->epc,
> -			  ntb->epf->func_no,
> -			  ntb->epf->vfunc_no,
> -			  &ntb->epf->bar[barno]);
> +	if (!shared)
> +		pci_epc_clear_bar(ntb->epf->epc,
> +				  ntb->epf->func_no,
> +				  ntb->epf->vfunc_no,
> +				  &ntb->epf->bar[barno]);
>  err_alloc_mem:
>  	epf_ntb_mw_bar_clear(ntb, i);
>  	return ret;
> @@ -1331,10 +1431,11 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
>
>  	for (i = 0; i < num_mws; i++) {
>  		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
> -		pci_epc_clear_bar(ntb->epf->epc,
> -				  ntb->epf->func_no,
> -				  ntb->epf->vfunc_no,
> -				  &ntb->epf->bar[barno]);
> +		if (!epf_ntb_dma_shares_bar(ntb, barno))
> +			pci_epc_clear_bar(ntb->epf->epc,
> +					  ntb->epf->func_no,
> +					  ntb->epf->vfunc_no,
> +					  &ntb->epf->bar[barno]);
>
>  		pci_epc_mem_free_addr(ntb->epf->epc,
>  				      ntb->vpci_mw_phy[i],
> @@ -1936,6 +2037,21 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
>  	dev = &ndev->dev;
>  	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
>  	epf_bar = &ntb->epf->bar[barno];
> +	if (epf_ntb_dma_shares_bar(ntb, barno)) {
> +		guard(mutex)(&ntb->dma->lock);
> +
> +		if (ntb->dma->mw_fallback) {
> +			if (size > epf_bar->size)
> +				return -EINVAL;
> +		} else if (size != ntb->mws_size[idx]) {
> +			/* DMA submaps start after the configured MW size. */
> +			return -EINVAL;
> +		}
> +
> +		return epf_ntb_dma_set_bar_locked(ntb, !ntb->dma->mw_fallback,
> +						  &addr);
> +	}
> +
>  	epf_bar->phys_addr = addr;
>  	epf_bar->barno = barno;
>  	epf_bar->size = size;
> @@ -2134,15 +2250,29 @@ static int vntb_epf_mw_get_align(struct ntb_dev *ndev, int pidx, int idx,
>  			resource_size_t *size_max)
>  {
>  	struct epf_ntb *ntb = ntb_ndev(ndev);
> +	enum pci_barno barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
> +	resource_size_t salign = 1;
> +	u64 size = ntb->mws_size[idx];
> +
> +	if (epf_ntb_dma_shares_bar(ntb, barno)) {
> +		if (ntb->dma->mw_fallback)
> +			size = ntb->epf->bar[barno].size;
> +		else
> +			/*
> +			 * DMA submaps start after the configured MW size.
> +			 * Use size_align to require a full-size MW translation.
> +			 */
> +			salign = size;
> +	}
>
>  	if (addr_align)
>  		*addr_align = SZ_4K;
>
>  	if (size_align)
> -		*size_align = 1;
> +		*size_align = salign;
>
>  	if (size_max)
> -		*size_max = ntb->mws_size[idx];
> +		*size_max = size;
>
>  	return 0;
>  }
> diff --git a/include/linux/pci-epf-ntb.h b/include/linux/pci-epf-ntb.h
> index 5cc0f0badae0..8131ed4c6ac9 100644
> --- a/include/linux/pci-epf-ntb.h
> +++ b/include/linux/pci-epf-ntb.h
> @@ -24,6 +24,9 @@
>  #define EPF_NTB_DB_COUNT_MASK			GENMASK(15, 0)
>  #define EPF_NTB_MSIX_ENABLE			BIT(16)
>
> +/* LINK_UP argument: the host honors the MW/DMA BAR boundary. */
> +#define EPF_NTB_LINK_UP_DMA_MW_SUPPORTED		BIT(0)
> +
>  #define EPF_NTB_COMMAND_STATUS_OK		1
>  #define EPF_NTB_COMMAND_STATUS_ERROR		2
>
> --
> 2.54.0
>
