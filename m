Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012047.outbound.protection.outlook.com [52.101.66.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2749C4E0214;
	Mon, 12 Oct 2026 20:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791835503; cv=fail; b=KW1h0r+4PqgCALDnbbzYhsLevltUerDCLcCAKPMipQdKZ5/OxMORWDTYcQSP9LqbmYLva6GrMiGHAusCjwv64EAAMmU/KFu0dmqeuEudlHqwe4NydEsbak96WmqQbYAalxswiZU2XD6C485OgZcayasNv8yiAh4sEAcgroeQPww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791835503; c=relaxed/simple;
	bh=CLT5+LLzCBF3PwIfPsKiQhYredwbQtWfjvH7XKxgP6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UYjcb07jnW4HXxNPKHk1/cZCdi411+TnwRvWAlexsMASHEtBz3ns7f80FOIx6/G4GLku8RLlZlKUfEZGeCq55MSXzf68rOrMNRPmpoZbQhE4vqmOuc2pcbBgqkAGM4zShXkORoCvCfyzcHikEHT/fqFmmcOrLi2w27Rn4g7omlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Suq02A0O; arc=fail smtp.client-ip=52.101.66.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Suq02A0O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dsExGblsR62oWwYe8cRK+J3441ExulUaz4ox/exYChDg7REKGVgBjKSGjJ+k2CfYrf4UTMMK/KGHkaKdbv8MvNBPeyRUOy4M9HPDbkRTNf/e17LEbFj0gqaGttES/iC65gpXguR+dURvmzTUwZgyOWDa+3B7y7D1+DEOaTyYc7w7r6+/zT90TlWaN2jVnt7evwki+h8O6IHtdjGt1vjUgQb27fYqre5oy3R7nvfM5IG902vpCQlWKAw9luVlHxWdCpB1MAt0Zi+KvLWepHLAqoei/m6QUhuy7afhYSRvNIx2cZegw2Oxd3NnstJdon6kkdLicYXXO6bK1KuRg1Luhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhOvTHjs1xZrRZ9eAUFd4rcU0g3kFmZuMu0qcmpiQqA=;
 b=kUFNStlTf8Ncfs4S1YFWxNMi8cBQDf95fyrKmFAapksKIph+FjKjWnXV0cnjYiuV6mb5KEZi2er3/Qjnl1gxbogEZc0LGv00hU5Pt8jNrDVo7NijZg811HdePHQ00r97k0Yw3QurJnxqp9Y0eiPG94ciRqK2JjnwKBsb+oNTxQjSUvmOJyWff311M7ycNh/8A3DlfarTsA/rjitvcUyzaoL/lnrGkcTpEkChQhKn2gF/07gU4aFJhw5nWRlLwMVVjKn8mlzVhmZPiEaiNel04ublOK4eZQlG8OtUNM0sqkcGNfUgxP7Q3EimtSAVcCyC46BOmEMxtWZmxPOOES+RcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhOvTHjs1xZrRZ9eAUFd4rcU0g3kFmZuMu0qcmpiQqA=;
 b=Suq02A0OINSQfEIMYXabjd0wb0y/+3YKcdz3J2rFzbhvxVGoezVmLf6i0onXiY9MxGeQhkvpVonXIcg/HphAqaLgxnNTLB1z0HTO1NsysinirVZrevfPWmqR2jW4Vfaatwxa/PNRNcVjlVGkUdJfrx+P7D7w6wnxLE46+0cCk7+B2JzG8YkZ7HQFULx7uOFs0oycHh4UYKCB5ggvmfzZkl5vmmrI59sAtnU2vxeeD4Nw7TuYkOtMy1+nebayNiSfKCaq3YPMi1CdD1cCo2e1ZGDZ93jJZxn5JduZ4iZDtTKeGrGkZ1o3PH9EmEf64e71w7dQmIJVAk8jP8o7dkRwRg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB9PR04MB8170.eurprd04.prod.outlook.com (2603:10a6:10:24b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 20:04:56 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0496.021; Mon, 12 Oct 2026
 20:04:56 +0000
Date: Mon, 12 Oct 2026 15:04:46 -0500
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
Subject: Re: [PATCH v5 6/7] NTB: ntb_hw_epf: Discover vNTB-embedded DMA
Message-ID: <as09Xp_EMjPDdk4x@SMW015318>
References: <20261009045949.1109871-1-den@valinux.co.jp>
 <20261009045949.1109871-7-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009045949.1109871-7-den@valinux.co.jp>
X-ClientProxiedBy: CYZPR19CA0019.namprd19.prod.outlook.com
 (2603:10b6:930:8e::28) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB9PR04MB8170:EE_
X-MS-Office365-Filtering-Correlation-Id: 23b85514-cc4f-4c1f-3de2-08df289c1633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|19092799006|56012099006|11063799006|4143699003|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	bCUgIwaCADzGKqtyGSdVZ/OQi9UQivGfRM+dKxs/tQaZD857mJ6h8wVlCoohLdsZ0CLUEI8rs/SGpsfjDDm2I0pezHJwILuUcH23U4z8h/8IjcQ6NSnF2aR6DZzO2l95K/pwaVK04Pv//xxbIniHvFVUiL8V8KVcJG+YYXecx3wCSym1IUIIk7mltDSK8wUqOzwEO785HFuMIazZOG3LTyfSJmKyNoEVPS/U6OTu41oqffwgG9tr6IIJOrY5W5WbgEcCXH0K80aEEWIOCi5hDOdGwPyfYZUrOSikQKX7sqSNIGoLhRRVI5Wkt4AF9X2O2e2ADY6vQbzrSESXJ1fnYumY9yJsQ+a3VduC2AQIJuhzTM7gFcYeC3SQF+v5P5zA4nZlPc4UpCu/U2Skzzs9qHzavrDbXRCwiyZC9rZ+zj2HWcoszFcdu1z7oWk7IYS4abbQ3N7rvR3BFVYvP7jg7yMVb741oe8ADuXADjpceiAMulZQAvljHtKl6FgchXg9tjwXOoQqWC2e+9YA8m2xdRB3WaRajG94PGr2xdwYC35m10nVPp1oU+fAUEC6QXYVoDnvF3gyp+7N9b+WwZkqNhSjCEqxJ7O5PKPnb8vleG+ZSroF2rPpB//9YDwBCAXE99VXxpX9G0mWnGzracxL1N5okmMcIQB06ECzzFhrhmM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(19092799006)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k0WX9/b8E5M7mF0ux0YbTJMkqI6QRaOF/m5nbj/mgNP4PyIez6gZ/OQfufqc?=
 =?us-ascii?Q?UmM/kuJl//nh4x/IOnURy4daI+mdO/EzC6kCCWWqQiOJcLsZE0wUlqOb2Qgz?=
 =?us-ascii?Q?x8YpSgv4rfA4C/5Y2qEKfVqYEcbdqbmXJZIda+7dL1BSeHgWfU6QclN9T3NU?=
 =?us-ascii?Q?cTQphrSHWi3MRq1njse9zeD+VqZevKDqzqrfXFN/h7s22Hj5ZZcXjSAQBqic?=
 =?us-ascii?Q?Z18CO3FsxPbmbnA2X7wNU/2KpAScklQO3X7cEhuk/YvR6OhDOUlDUEbp3BBX?=
 =?us-ascii?Q?wdvlNJtvypwTw50x1YxlWoOIuP5eNSD7q2eXCvSBZrTdXRMNeD4cTgyUdzIE?=
 =?us-ascii?Q?Cp6FbNGY6dA5e7ZFRIW6ReNjQEqQrBQ/bYBbTzD+2ohntdi7i+SrkmGFvwX7?=
 =?us-ascii?Q?qGSpbDQSjHJ0Y+OvD9p6sLUMaC6WRlKPxJ4C8pYBngtKh6viPH56QOq0gRaB?=
 =?us-ascii?Q?BWkJLppUx8AdXTNoRERwgvBi3/uKRYm2mWi2V0QZy8VdlkMHi9NakaXpG1rw?=
 =?us-ascii?Q?Hw+P9ClC1I2Y7xhS5+natBfmnEG/PPpPrPzKWlqZLKknCOkfCE3manlSFVcQ?=
 =?us-ascii?Q?WvCkRzWP0yZ+rdj/vyQkmfrxShaJLekUrXc8n13bmz+Py6GVN+sI7Afd08Cl?=
 =?us-ascii?Q?wgZRaXfGmq4uHd+sLtENWOnuGUrB77XmWgBFDsc24gafctpVFvBMn1x9FXa5?=
 =?us-ascii?Q?FDfJfHJhX8Sbhp5COVvQ/Ys/9q+fkzV7srl7cMkmCHlpTyOfufyYz7WwLu/7?=
 =?us-ascii?Q?2kEWfnNCJVT016cOB2DdQRtuiEqbnLivhaAsi+B8ynn+hNE71CQzcF6/GXq9?=
 =?us-ascii?Q?c58V4gmndKC5LV8ONYFmxIZCEprNBUjw/ytJ9YVe8o9e3bwZfoCf+bVE0z4L?=
 =?us-ascii?Q?lci8ivHbj7SsOT5ISFEDrMR+Ot9bQYe9KK0GN9a4jS31Tv2zULslIbcF8tyH?=
 =?us-ascii?Q?ADKzXG9hwutMOa/Z3kcpsLwf+SSsO14qgkyGTDs6tJvnuBmpATRAj+HPDstV?=
 =?us-ascii?Q?UQz4RvLZMsKrsPFOYXTTU+lkThEPkCvvi6i7loSCJJ7j3ZZU0PLNnCdojdr/?=
 =?us-ascii?Q?vpUvdljgRRjgHc/dD+cKpsa5oIHGwZIJO2AXEWteGJDA154XVLmGooo5kRSw?=
 =?us-ascii?Q?hWPNQmBhc60AahCDj6IB12sZcEEqWWxkzJTZg1JQKrWqidZ+BzFu4WwjUbk0?=
 =?us-ascii?Q?iM7tswk0AIXMGVhRnrgwmbj+izkI09CK444fS83GJGjkzOgkf2e2BV+wEQc5?=
 =?us-ascii?Q?ApeHUegVjsaDP1PypP9J3sXeP++UwKRMGqs4uJepLYmhApvPYiB9YlCCe7z6?=
 =?us-ascii?Q?AcjcIdtcQBBgpIvGsMyAOE7tcU77YkKMP8DceS34XYNqWnAO6BeqbovkAAsc?=
 =?us-ascii?Q?qfcjHwacQbzO0Uve6TrbZM/knKv06PhrU7frTowOYikRnlhNp0JbDeZWi45I?=
 =?us-ascii?Q?tufdoz71oVF7R3M1lQSz0bEdoczKHHflHTT8yF7d2ETIYOWq+BBArsNkVIks?=
 =?us-ascii?Q?UElpCShCc1M4xBPqsaPRcDZSaGCc2e682b+hK04Npi/SIQfZiRUE4uWDzU6c?=
 =?us-ascii?Q?4X6Po0luvZOOnR5FxNXVv2bLOFENTuEjSDmnTnYjpiiHgQ+yonSHkAIeUlJO?=
 =?us-ascii?Q?ZBWOwZbB/hilFYFxo/OatFAMoKmf9RsQkZJdKfpjFy7bgt5Df+lK+XQvZ6ly?=
 =?us-ascii?Q?1yOyw/VnZXgVqTpZ3h3RLTZdDUwNZ1RGPKsN4ivKNFCIM1V0O+R7cyTIszQq?=
 =?us-ascii?Q?DWqcwPnQc7XshNjUhh3SPRYjl+/fTsn2Sz4TxLGv5XYWeqVAwlxg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b85514-cc4f-4c1f-3de2-08df289c1633
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 20:04:56.5356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PAURih4Lj7OZj/O3vcTGojik0Ag6R/fe+pX1DIj1gZsTmIlquOiFHswMc/wZ/VUMIeipWTuWMYrX1dKba2/LxBgsC11oegBif0bJ1Z6HmNDBTHYlnzPMq0jRSW2EqnMU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8170

On Fri, Oct 09, 2026 at 01:59:48PM +0900, Koichiro Den wrote:
> A vNTB PCI function can now expose endpoint-local DMA channels to its
> host. Decode the extension and register the advertised channels before
> the NTB device, so clients of that NTB device can use the DMA
> functionality in the same PCI function. Endpoints without the extension,
> or hosts without support for its DMA type or with no DMA IRQ available,
> continue without DMA.
>
> Only DW eDMA is supported for now. Dispatch on the advertised DMA type
> and keep type-specific setup in local helpers. Support for another
> implementation can add a new case and its own helpers.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes in v5:
>   - Simplify the implementation by using pcim_iomap_range()
>   - Drop the unrelated MW size-limit change for pci-epf-ntb bridges.
>
>  drivers/ntb/hw/epf/ntb_hw_epf.c | 336 ++++++++++++++++++++++++++++++--
>  1 file changed, 323 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> index c47607d4f8a7..7faa40d1ae00 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -8,6 +8,7 @@
>
>  #include <linux/atomic.h>
>  #include <linux/delay.h>
> +#include <linux/dma/edma.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/slab.h>
> @@ -20,6 +21,7 @@
>  #define CMD_TEARDOWN_MW		4
>  #define CMD_LINK_UP		5
>  #define CMD_LINK_DOWN		6
> +#define CMD_SETUP_DMA_BAR	7
>
>  #define NTB_EPF_ARGUMENT	0x4
>  #define MSIX_ENABLE		BIT(16)
> @@ -44,6 +46,32 @@
>  #define NTB_EPF_DB_DATA(n)	(0x34 + (n) * 4)
>  #define NTB_EPF_DB_OFFSET(n)	(0xB4 + (n) * 4)
>
> +/* Private DMA wire extension produced by pci-epf-vntb. */
> +#define NTB_EPF_DMA_BASE	0x134
> +#define NTB_EPF_DMA_MAGIC	(NTB_EPF_DMA_BASE + 0x00)
> +#define NTB_EPF_DMA_REV_LEN	(NTB_EPF_DMA_BASE + 0x04)
> +#define NTB_EPF_DMA_TYPE	(NTB_EPF_DMA_BASE + 0x08)
> +#define NTB_EPF_DMA_REGION_BAR(base)	((base) + 0x00)
> +#define NTB_EPF_DMA_REGION_OFFSET(base)	((base) + 0x04)
> +#define NTB_EPF_DMA_REGION_SIZE(base)	((base) + 0x08)
> +#define NTB_EPF_DMA_REGION_SIZEOF	0x0C
> +#define NTB_EPF_DMA_SUBMAP_BASE	(NTB_EPF_DMA_BASE + 0x0C)
> +#define NTB_EPF_DMA_COMMON_SIZE	0x18
> +#define NTB_EPF_DMA_REG_BASE	(NTB_EPF_DMA_BASE + NTB_EPF_DMA_COMMON_SIZE)
> +#define NTB_EPF_DMA_CHAN_BASE	(NTB_EPF_DMA_REG_BASE + \
> +					 NTB_EPF_DMA_REGION_SIZEOF)
> +#define NTB_EPF_DMA_CHAN_SIZE	0x14
> +#define NTB_EPF_DMA_CHAN_DESC_BASE(n)	(NTB_EPF_DMA_CHAN_BASE + \
> +					 (n) * NTB_EPF_DMA_CHAN_SIZE + 0x00)
> +#define NTB_EPF_DMA_CHAN_DESC_ADDR_LO(n)	(NTB_EPF_DMA_CHAN_BASE + \
> +					 (n) * NTB_EPF_DMA_CHAN_SIZE + 0x0C)
> +#define NTB_EPF_DMA_CHAN_DESC_ADDR_HI(n)	(NTB_EPF_DMA_CHAN_BASE + \
> +					 (n) * NTB_EPF_DMA_CHAN_SIZE + 0x10)
> +

legacy use two sets define. Can we use common header files for both epf
drivers.

In ntb_hw_epf.c, it use readl(), in pci_endpont_vntb.c use direct memory
access.

Can use offsetof() to avoid these define? we can move more after common
head created.

Frank

> +#define NTB_EPF_DMA_MAGIC_VALUE	0x414d444e /* "NDMA": NTB DMA */
> +#define NTB_EPF_DMA_REVISION	1
> +#define NTB_EPF_DMA_TYPE_DW_EDMA	1
> +
>  /*
>   * Legacy doorbell slot layout when paired with pci-epf-*ntb:
>   *
> @@ -97,6 +125,24 @@ struct ntb_epf_irq_ctx {
>  	unsigned int irq_no;
>  };
>
> +struct ntb_epf_dma_region {
> +	unsigned int bar;
> +	resource_size_t offset;
> +	resource_size_t size;
> +};
> +
> +struct ntb_epf_dw_edma {
> +	struct dw_edma_chip chip;
> +	struct ntb_epf_dma_region reg;
> +	struct ntb_epf_dma_region ll[EDMA_MAX_RD_CH];
> +};
> +
> +struct ntb_epf_dma {
> +	struct ntb_epf_dma_region submap;
> +	unsigned int nr_irqs;
> +	u32 type;
> +};
> +
>  struct ntb_epf_dev {
>  	struct ntb_dev ntb;
>  	struct device *dev;
> @@ -108,6 +154,8 @@ struct ntb_epf_dev {
>  	unsigned int mw_count;
>  	unsigned int spad_count;
>  	unsigned int db_count;
> +	struct ntb_epf_dma dma;
> +	struct ntb_epf_dw_edma dw_edma;
>
>  	void __iomem *ctrl_reg;
>  	void __iomem *db_reg;
> @@ -162,6 +210,212 @@ static int ntb_epf_send_command(struct ntb_epf_dev *ndev, u32 command,
>  	return ret;
>  }
>
> +static bool ntb_epf_dma_region_parse(struct ntb_epf_dev *ndev, u32 base,
> +				     bool optional,
> +				     struct ntb_epf_dma_region *region)
> +{
> +	resource_size_t bar_len;
> +	u32 bar, offset, size;
> +
> +	bar = readl(ndev->ctrl_reg + NTB_EPF_DMA_REGION_BAR(base));
> +	offset = readl(ndev->ctrl_reg + NTB_EPF_DMA_REGION_OFFSET(base));
> +	size = readl(ndev->ctrl_reg + NTB_EPF_DMA_REGION_SIZE(base));
> +	region->bar = bar;
> +	region->offset = offset;
> +	region->size = size;
> +	if (!size)
> +		return optional && bar == U32_MAX && !offset;
> +	if (bar > BAR_5)
> +		return false;
> +
> +	bar_len = pci_resource_len(ndev->ntb.pdev, bar);
> +	if (offset > bar_len || size > bar_len - offset)
> +		return false;
> +
> +	return true;
> +}
> +
> +/* DW eDMA */
> +
> +static int ntb_epf_dw_edma_parse(struct ntb_epf_dev *ndev, u32 length)
> +{
> +	struct ntb_epf_dw_edma *edma = &ndev->dw_edma;
> +	struct dw_edma_chip *chip = &edma->chip;
> +	u32 count, chan_offset;
> +	unsigned int i;
> +
> +	chan_offset = NTB_EPF_DMA_CHAN_BASE - NTB_EPF_DMA_BASE;
> +	if (length < chan_offset + NTB_EPF_DMA_CHAN_SIZE ||
> +	    (length - chan_offset) % NTB_EPF_DMA_CHAN_SIZE)
> +		return -EINVAL;
> +
> +	count = (length - chan_offset) / NTB_EPF_DMA_CHAN_SIZE;
> +	if (count > EDMA_MAX_RD_CH)
> +		return -EINVAL;
> +
> +	if (!ntb_epf_dma_region_parse(ndev, NTB_EPF_DMA_REG_BASE, false,
> +				      &edma->reg) ||
> +	    !IS_ALIGNED(edma->reg.offset, sizeof(u32)))
> +		return -EINVAL;
> +
> +	chip->mf = EDMA_MF_EDMA_UNROLL;
> +	chip->ll_rd_cnt = count;
> +	chip->func_no = PCI_FUNC(ndev->ntb.pdev->devfn);
> +
> +	for (i = 0; i < count; i++) {
> +		u64 paddr;
> +
> +		if (!ntb_epf_dma_region_parse(ndev,
> +					      NTB_EPF_DMA_CHAN_DESC_BASE(i),
> +					      false, &edma->ll[i]) ||
> +		    !IS_ALIGNED(edma->ll[i].offset, sizeof(u32)))
> +			return -EINVAL;
> +
> +		paddr = readl(ndev->ctrl_reg +
> +			      NTB_EPF_DMA_CHAN_DESC_ADDR_LO(i));
> +		paddr |= (u64)readl(ndev->ctrl_reg +
Frank> +				    NTB_EPF_DMA_CHAN_DESC_ADDR_HI(i)) << 32;
> +		if (paddr == U64_MAX)
> +			return -EINVAL;
> +
> +		chip->ll_region_rd[i].sz = edma->ll[i].size;
> +		chip->ll_region_rd[i].paddr = paddr;
> +	}
> +	ndev->dma.nr_irqs = count;
> +
> +	return 0;
> +}
> +
> +static int ntb_epf_dw_edma_irq_vector(struct device *dev, unsigned int nr)
> +{
> +	struct ntb_epf_dev *ndev = dev_get_drvdata(dev);
> +
> +	/* DMA vectors follow the NTB link and doorbell vector block. */
> +	return pci_irq_vector(ndev->ntb.pdev, ndev->db_count + 1 + nr);
> +}
> +
> +static const struct dw_edma_plat_ops ntb_epf_dw_edma_ops = {
> +	.irq_vector = ntb_epf_dw_edma_irq_vector,
> +};
> +
> +static void __iomem *
> +ntb_epf_dw_edma_map_region(struct pci_dev *pdev,
> +			   const struct ntb_epf_dma_region *region)
> +{
> +	return pcim_iomap_range(pdev, region->bar, region->offset, region->size);
> +}
> +
> +static int ntb_epf_dw_edma_init(struct ntb_epf_dev *ndev)
> +{
> +	struct ntb_epf_dw_edma *edma = &ndev->dw_edma;
> +	struct dw_edma_chip *chip = &edma->chip;
> +	struct pci_dev *pdev = ndev->ntb.pdev;
> +	unsigned int i;
> +	int ret;
> +
> +	/* Install BAR submaps before mapping the advertised DMA regions. */
> +	ret = ntb_epf_send_command(ndev, CMD_SETUP_DMA_BAR, 0);
> +	if (ret)
> +		return ret;
> +
> +	chip->reg_base = ntb_epf_dw_edma_map_region(pdev, &edma->reg);
> +	if (IS_ERR(chip->reg_base))
> +		return PTR_ERR(chip->reg_base);
> +	for (i = 0; i < chip->ll_rd_cnt; i++) {
> +		chip->ll_region_rd[i].vaddr.io =
> +			ntb_epf_dw_edma_map_region(pdev, &edma->ll[i]);
> +		if (IS_ERR(chip->ll_region_rd[i].vaddr.io))
> +			return PTR_ERR(chip->ll_region_rd[i].vaddr.io);
> +	}
> +
> +	chip->dev = ndev->dev;
> +	chip->nr_irqs = ndev->dma.nr_irqs;
> +	chip->ops = &ntb_epf_dw_edma_ops;
> +	chip->flags = DW_EDMA_CHIP_PARTIAL;
> +
> +	return dw_edma_probe(chip);
> +}
> +
> +static void ntb_epf_dw_edma_deinit(struct ntb_epf_dev *ndev)
> +{
> +	dw_edma_remove(&ndev->dw_edma.chip);
> +}
> +
> +/* Common endpoint DMA */
> +
> +static int ntb_epf_dma_parse(struct ntb_epf_dev *ndev)
> +{
> +	u32 magic, rev_len, length, type;
> +	u32 spad_off;
> +	int ret;
> +
> +	/*
> +	 * Legacy endpoints place scratchpads where this extension would begin.
> +	 * Once the extension is present, malformed metadata is fatal.
> +	 */
> +	spad_off = readl(ndev->ctrl_reg + NTB_EPF_SPAD_OFFSET);
> +	if (spad_off < NTB_EPF_DMA_BASE + NTB_EPF_DMA_COMMON_SIZE)
> +		return 0;
> +
> +	magic = readl(ndev->ctrl_reg + NTB_EPF_DMA_MAGIC);
> +	if (!magic)
> +		return 0;
> +	if (magic == U32_MAX)
> +		return -EIO;
> +	if (magic != NTB_EPF_DMA_MAGIC_VALUE)
> +		return -EINVAL;
> +
> +	rev_len = readl(ndev->ctrl_reg + NTB_EPF_DMA_REV_LEN);
> +	length = upper_16_bits(rev_len);
> +	if (lower_16_bits(rev_len) != NTB_EPF_DMA_REVISION ||
> +	    length < NTB_EPF_DMA_COMMON_SIZE ||
> +	    spad_off < NTB_EPF_DMA_BASE + length)
> +		return -EINVAL;
> +	if (!ntb_epf_dma_region_parse(ndev, NTB_EPF_DMA_SUBMAP_BASE, true,
> +				      &ndev->dma.submap))
> +		return -EINVAL;
> +
> +	type = readl(ndev->ctrl_reg + NTB_EPF_DMA_TYPE);
> +	if (type == U32_MAX)
> +		return -EIO;
> +
> +	switch (type) {
> +	case NTB_EPF_DMA_TYPE_DW_EDMA:
> +		if (!IS_REACHABLE(CONFIG_DW_EDMA))
> +			break;
> +		ret = ntb_epf_dw_edma_parse(ndev, length);
> +		if (!ret)
> +			ndev->dma.type = type;
> +		return ret;
> +	default:
> +		break;
> +	}
> +
> +	dev_warn(ndev->dev,
> +		 "Endpoint DMA type %u unavailable, continuing without DMA\n",
> +		 type);
> +	return 0;
> +}
> +
> +static int ntb_epf_dma_init(struct ntb_epf_dev *ndev)
> +{
> +	switch (ndev->dma.type) {
> +	case NTB_EPF_DMA_TYPE_DW_EDMA:
> +		return ntb_epf_dw_edma_init(ndev);
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static void ntb_epf_dma_deinit(struct ntb_epf_dev *ndev)
> +{
> +	switch (ndev->dma.type) {
> +	case NTB_EPF_DMA_TYPE_DW_EDMA:
> +		ntb_epf_dw_edma_deinit(ndev);
> +		break;
> +	}
> +}
> +
>  static int ntb_epf_mw_to_bar(struct ntb_epf_dev *ndev, int idx)
>  {
>  	struct device *dev = ndev->dev;
> @@ -174,6 +428,23 @@ static int ntb_epf_mw_to_bar(struct ntb_epf_dev *ndev, int idx)
>  	return ndev->barno_map[BAR_MW1 + idx];
>  }
>
> +static resource_size_t ntb_epf_mw_offset(struct ntb_epf_dev *ndev, int idx)
> +{
> +	return !idx ? readl(ndev->ctrl_reg + NTB_EPF_MW1_OFFSET) : 0;
> +}
> +
> +static resource_size_t ntb_epf_mw_size(struct ntb_epf_dev *ndev, int bar)
> +{
> +	resource_size_t end;
> +
> +	end = pci_resource_len(ndev->ntb.pdev, bar);
> +	/* The DMA submap offset marks the end of an MW sharing this BAR. */
> +	if (ndev->dma.submap.size && ndev->dma.submap.bar == bar)
> +		end = min(end, ndev->dma.submap.offset);
> +
> +	return end;
> +}
> +
>  static int ntb_epf_mw_count(struct ntb_dev *ntb, int pidx)
>  {
>  	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
> @@ -212,7 +483,7 @@ static int ntb_epf_mw_get_align(struct ntb_dev *ntb, int pidx, int idx,
>  		*size_align = 1;
>
>  	if (size_max)
> -		*size_max = pci_resource_len(ndev->ntb.pdev, bar);
> +		*size_max = ntb_epf_mw_size(ndev, bar);
>
>  	return 0;
>  }
> @@ -373,16 +644,20 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
>  {
>  	struct pci_dev *pdev = ndev->ntb.pdev;
>  	struct device *dev = ndev->dev;
> +	unsigned int dma_max = ndev->dma.nr_irqs;
> +	unsigned int dma_min;
>  	u32 argument = MSIX_ENABLE;
> +	unsigned int ntb_irqs;
>  	int irq;
>  	int ret;
>  	int i;
>
> -	irq = pci_alloc_irq_vectors(pdev, msi_min, msi_max, PCI_IRQ_MSIX);
> +	irq = pci_alloc_irq_vectors(pdev, msi_min,
> +				    msi_max + dma_max, PCI_IRQ_MSIX);
>  	if (irq < 0) {
>  		dev_dbg(dev, "Failed to get MSIX interrupts\n");
> -		irq = pci_alloc_irq_vectors(pdev, msi_min, msi_max,
> -					    PCI_IRQ_MSI);
> +		irq = pci_alloc_irq_vectors(pdev, msi_min,
> +					    msi_max + dma_max, PCI_IRQ_MSI);
>  		if (irq < 0) {
>  			dev_err(dev, "Failed to get MSI interrupts\n");
>  			return irq;
> @@ -390,8 +665,17 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
>  		argument &= ~MSIX_ENABLE;
>  	}
>
> -	ndev->db_count = irq - 1;
> -	for (i = 0; i < irq; i++) {
> +	dma_min = dma_max && irq > msi_min;
> +	/* Reserve one shared DMA IRQ when available, then give the rest to NTB. */
> +	ntb_irqs = min_t(unsigned int, irq - dma_min, msi_max);
> +	ndev->dma.nr_irqs = irq - ntb_irqs;
> +	if (dma_max && !ndev->dma.nr_irqs) {
> +		dev_warn(dev,
> +			 "No IRQ available for endpoint DMA, continuing without DMA\n");
> +		ndev->dma.type = 0;
> +	}
> +	ndev->db_count = ntb_irqs - 1;
> +	for (i = 0; i < ntb_irqs; i++) {
>  		ndev->irq_ctx[i].ndev = ndev;
>  		ndev->irq_ctx[i].irq_no = i;
>  		ret = request_irq(pci_irq_vector(pdev, i), ntb_epf_vec_isr,
> @@ -403,7 +687,7 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
>  	}
>
>  	ret = ntb_epf_send_command(ndev, CMD_CONFIGURE_DOORBELL,
> -				   argument | irq);
> +				   argument | ntb_irqs);
>  	if (ret) {
>  		dev_err(dev, "Failed to configure doorbell\n");
>  		goto err_free_irq;
> @@ -486,7 +770,7 @@ static int ntb_epf_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
>  	if (bar < 0)
>  		return bar;
>
> -	mw_size = pci_resource_len(ntb->pdev, bar);
> +	mw_size = ntb_epf_mw_size(ndev, bar);
>
>  	if (size > mw_size) {
>  		dev_err(dev, "Size:%pa is greater than the MW size %pa\n",
> @@ -520,21 +804,20 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
>  				    phys_addr_t *base, resource_size_t *size)
>  {
>  	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
> -	u32 offset = 0;
> +	resource_size_t offset;
>  	int bar;
>
> -	if (idx == 0)
> -		offset = readl(ndev->ctrl_reg + NTB_EPF_MW1_OFFSET);
> -
>  	bar = ntb_epf_mw_to_bar(ndev, idx);
>  	if (bar < 0)
>  		return bar;
>
> +	offset = ntb_epf_mw_offset(ndev, idx);
> +
>  	if (base)
>  		*base = pci_resource_start(ndev->ntb.pdev, bar) + offset;
>
>  	if (size)
> -		*size = pci_resource_len(ndev->ntb.pdev, bar) - offset;
> +		*size = ntb_epf_mw_size(ndev, bar) - offset;
>
>  	return 0;
>  }
> @@ -630,12 +913,30 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
>  {
>  	struct device *dev = ndev->dev;
>  	int ret;
> +	int i;
>
>  	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_MW_COUNT);
>  	if (ndev->mw_count > NTB_EPF_MAX_MW_COUNT) {
>  		dev_err(dev, "Unsupported MW count: %u\n", ndev->mw_count);
>  		return -EINVAL;
>  	}
> +	ret = ntb_epf_dma_parse(ndev);
> +	if (ret) {
> +		dev_err(dev, "Invalid endpoint DMA layout\n");
> +		return ret;
> +	}
> +	if (ndev->dma.submap.size) {
> +		for (i = 0; i < ndev->mw_count; i++) {
> +			int bar = ntb_epf_mw_to_bar(ndev, i);
> +
> +			if (bar == ndev->dma.submap.bar &&
> +			    ntb_epf_mw_size(ndev, bar) <=
> +			    ntb_epf_mw_offset(ndev, i)) {
> +				dev_err(dev, "Invalid DMA/MW boundary\n");
> +				return -EINVAL;
> +			}
> +		}
> +	}
>
>  	/* One Link interrupt and rest doorbell interrupt */
>  	ret = ntb_epf_init_isr(ndev, NTB_EPF_MIN_DB_COUNT + 1,
> @@ -785,6 +1086,12 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
>  		goto err_init_dev;
>  	}
>
> +	ret = ntb_epf_dma_init(ndev);
> +	if (ret) {
> +		dev_err(dev, "Failed to initialize endpoint DMA\n");
> +		goto err_dma_init;
> +	}
> +
>  	ret = ntb_register_device(&ndev->ntb);
>  	if (ret) {
>  		dev_err(dev, "Failed to register NTB device\n");
> @@ -794,6 +1101,8 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
>  	return 0;
>
>  err_register_dev:
> +	ntb_epf_dma_deinit(ndev);
> +err_dma_init:
>  	ntb_epf_cleanup_isr(ndev);
>
>  err_init_dev:
> @@ -807,6 +1116,7 @@ static void ntb_epf_pci_remove(struct pci_dev *pdev)
>  	struct ntb_epf_dev *ndev = pci_get_drvdata(pdev);
>
>  	ntb_unregister_device(&ndev->ntb);
> +	ntb_epf_dma_deinit(ndev);
>  	ntb_epf_cleanup_isr(ndev);
>  	ntb_epf_deinit_pci(ndev);
>  }
> --
> 2.51.0
>
