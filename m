Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011063.outbound.protection.outlook.com [52.101.65.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEC0423780;
	Thu,  3 Sep 2026 21:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788470451; cv=fail; b=uzV6FzXxcqwB9Wrfu0nK6xefhxulLAKaOQWZltojfdqnMk85HKme9QOheVU2VL8hdmelFaS11d/dO4cLOVx1zelJkxwo1eW2+qk6L1LaryUU94qQ5MTg3437UxAL6EiIPN2r8faSRjPXnHuYQt8ogukXhWggVAufRlz7E7JDhJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788470451; c=relaxed/simple;
	bh=SuC3skfd1oLvMAab1Y27syl+khErwkeWBkCW6fP3sOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aFXdtdfC+jo9vXUZj0JKLppYBFBuFMoj9WZBRVDwxePf2JWCKTl5PH//1PEAJleYFPKGNh8tFD6Gra9RVLL+9oEgUL7yBHAaPXi13EkXDdHhxv+E+vpBqOmaH4eszMIYpfHYU6n8q4qRrEziszmzJsHJJ+cxT6tdtaYsxAi5sp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=wgUQVOgT; arc=fail smtp.client-ip=52.101.65.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wgUQVOgT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XE507DgZ5P7A0Joah3LbJ1kZ4gvEwVZvvgYlu+VZYBh9bN/S/J00A+XrpObfj7CkZawdprHyIFQagHB4m/SGjTqLNO5apgScIWhXNrQgMrCEWAP+m2Pi9ttIZM7vsk9brbEeljdsilhQ5kDvU+WIrjbl0JHnP6hgc4eJknZ/vH6lXTdBIMgowNebcgZ5ISW7NB4CI7tYVTLWd7FpUoBsKOxsLRya/IWKBhWcOlHVItj5S4M1McHVufJeUyzeUuoE+SZ8ikNf4cgyc4RLMjbE3CTmfpMcDhOftJ0VOIXKPIzcvl+GZmjBPJVTW0yXhcx8C4DmarY4Dt5KH3BNZ1fFzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQqEAaHmF8nxLxp+w8h6/pB5bzKo4yAB8sfyRmP8NHw=;
 b=U82YTYJ9PHmvbcSDIn7zvO2fPYRMp5zPjWSr09nse17mt7eszltE0DnOesYUvU94Hv6GbKYeP3/F39y4hcQPbWTs4qEoK9RvUVXxOjoEXha7H+FBUoKD+wFsrEieuCjHgeUyENyFM6fsjV5m5853YiofoVa26XhRW9n+jHIh/HRd8mS5CjMUu6YdQX5oEUh6Sp6LFk9a9A2qbuokNU4Hkm4OMAMB2NCoMgpdNtsOivQGPXm3EOswebl6b2OH1ZCC8aRUOEp1EFS+zl5y6MfBZ42oxgMuhmJapTtF3++3VI+mTKzSOVLngjVuS6Q9GTeO4B3UpjReOloxSAdoH9dlpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQqEAaHmF8nxLxp+w8h6/pB5bzKo4yAB8sfyRmP8NHw=;
 b=wgUQVOgTO8ueeBmyK9sqf8x3whB38XqfDG8+3Z5W6dp3Cd/Sv1Hqb/eAalbjY6l+9h4m3fcHitOtOnJg0b/fAy4RmVuPu1IA5svodE75MfDQDZVix2VEHpjXOi2P+ZHAxdG+DewBYeYinl8GNROtQ8AKKCFh+skFRnqPx1wYG+8FqnXCjBYbx/j+REmb0WN20DQw4MPAHmaI+jMIpFXrVfeywvGkVksPGQ/ZQozuKbUxM/WVLLic1PS61ac+dhyUhmXrdepFRu0B/5VUSOptxgDVi6Q3K/dObDKU8e583NEAxRTQcWrFELV7oG5A+8W9NsdSbAlGKuSOG3PUUAtyhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PAXPR04MB9229.eurprd04.prod.outlook.com (2603:10a6:102:2bd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 21:20:41 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 21:20:41 +0000
Date: Thu, 3 Sep 2026 16:20:26 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v3 4/7] PCI: endpoint: pci-epf-vntb: Export endpoint DMA
 channels
Message-ID: <apnkmrQIY7uBZ4Yt@SMW015318>
References: <20260831182657.329614-1-den@valinux.co.jp>
 <20260831182657.329614-5-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831182657.329614-5-den@valinux.co.jp>
X-ClientProxiedBy: PH7PR17CA0044.namprd17.prod.outlook.com
 (2603:10b6:510:323::15) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PAXPR04MB9229:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c115f7f-faeb-44e9-7c57-08df0a0134f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|19092799006|6133799003|10067099003|5023799004|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tnlwIgtTpIL4dplwRYrbZIRZPg7J0V3gTSsIXtlc+8R7SEi84dfD2gOEW4TLJ9nCsALvb/PzGWTZAYhQajMz/b5GJXITdx2++ssaTbIXRHygQKb1rert7Plg2xW6QGX3JoYjqQ6lv1tZVijUbEtJi1xx1R9+/HPv/HGcscw7Va5IZJs1YF1FtIqClvrSM1m6PmGlHl9OJDexuZRZX6UftNwN1zJu22ebDJFJobnHSTZRd827OfaHrJr2FiNzJxe7qtOYFCDWmVVbAeKXlIqaXlxgIq1A1LljFCom7B/gv8/dgVh6PrsWH7jVVe61DmNnNwnvOY4KdvLJ6Z6jADkxEgj91J6/4fFO7kjGBy7veYOuuSUEBp3DjSU8SLmT2YtBqqRt5Dw+darCLC0R0QR0n0iXyTcVCHarrUdhXYo33eGvG4Jx1X4yAMQpcPgcrfTgg9xWQ9zS5XXgphJ0OE6fR7ulZ4+ntp+KvW513i/u8wvamqIBuDz5eZvnSz6FNLBbP5F4oR6Fist4/ESoJR9LjdO8lCEfBcMIGBBTv/v6Y4pWUS1sUObUximrkRtDHzb6KOt7kwWtnbrGaBz+bGI4P+XWW3YeJ47JQvis3F1sBIR7CJPJWy9LedkVRqO8BZ5xsgW+1ooJ5Q1JYKHESY5e4WLKmDuRznPTSco3mfQ4M7c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(19092799006)(6133799003)(10067099003)(5023799004)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zJpo2j6JXJIAliugRrz57MEY002pV6d2RgOu2xRL4vZQ6euH0DhcUVSXJZI/?=
 =?us-ascii?Q?MrHgEwtWFlu93Qo5TK6G3skmLBnoN6oziiI0B+jAzmNZxJ+lGop3LgucMV99?=
 =?us-ascii?Q?IMwRoVYPqNoLwxDkh4lqsf3ErZYWLdd460dTWnjK6JZ5RJpEvS4yktqKQRAh?=
 =?us-ascii?Q?JtWY2UlWURqto+tgBl9xL7422oGRHwNcLi8Fuso8tCZ8joQZae2MIDGIZKli?=
 =?us-ascii?Q?eOli1bwAlyk4RPKQmxx8VFa6O2TNuixXtECsYe66ff/cka8dxLaA6Axm6M4A?=
 =?us-ascii?Q?pO1cx+TnQZL6vDozjvllnsiExATvTReDEINXP6BEbhABOgb2emmD7zV4UYHp?=
 =?us-ascii?Q?T0BDSCvmPO0tY6ECpkZ3J+T2DCkFQObXX2BC42BDgaMtbvU9QdTYtpR5u1Z1?=
 =?us-ascii?Q?q+88n0CoWqqcwN6C5TNjnVHXTcEriZ+1YDxJlyZ2rAfllnsmhAVC1F4R/n5e?=
 =?us-ascii?Q?kZ7NSnc+oE0tF3AktuFzbXqhcwzIssiiDTWcoLcetgKLWpBMXpThY+UUlbWL?=
 =?us-ascii?Q?Cev8G0yvk+r9jyXx1WxZMkHcHb5tQ6VlQ+laEbFwgqmKpHdHlKBxa1nC1rlt?=
 =?us-ascii?Q?/uhoFx32twCi2iiTlIT6TeMstjp272m+/NB82O3hci37Vjx5gnjGg7SbYhbx?=
 =?us-ascii?Q?eOqPtlruttH42SdGzzFwZNOf09hTyZpWj7E4OEXlHRaOKB++T5MQZR8WqEo2?=
 =?us-ascii?Q?mCkHxnI5bnu8q+sH9XzK5Wnu8RiZxx+0KBNkJifTDBYVR6ksFp5Cedb4lOIf?=
 =?us-ascii?Q?QOfxmkbTLE/6t04oHtsrgH4LXI9jOFcwpVSJMrV4kLc2FGQ3ngmNnA6zQsa5?=
 =?us-ascii?Q?k4liJxcHGPO/THUOMMj5aNGsIfJKHtOxL6jQUEWOIdVRbgiyd1wFUOiKknKw?=
 =?us-ascii?Q?dYJTHCmtboixWB0BxqeUvEDNnKsKFYNGLjIerDJtW0sGOi0TCVAVZ5vlpHf3?=
 =?us-ascii?Q?zqEwYzhOSfAk8KcWNlgKEkEjULt4ZrJ7zfblLnup8/bVYILCnZynXaskJe98?=
 =?us-ascii?Q?7iGgk/GRMfX9ynwUt8p9iuvASF93tm4P3FnyYR1Oejl3vGOW2OGmxQ/lRp7j?=
 =?us-ascii?Q?rwK1VF9XDsdIIUEWATfWsWbI6Tw0zSlypBF29pwzOEBd8OS7WM4//cWzfrof?=
 =?us-ascii?Q?ySKEIfvgDlnDzCpv+FRMDV0p8yWaxxDcWjD6mDHKKSZvBVb14KmSULPP99Sz?=
 =?us-ascii?Q?Hm0z+q3oEsbWl3pcDQOxssy/UwCRIU1fvkYmPrlfxYDK7dNA7dxaGx6mKIl9?=
 =?us-ascii?Q?TnPT2AL36ucVqOlTr7iFVUAviyIZrfz4ZsbQ4YqjIgihQ+Hxq1kCF8Uo6zxN?=
 =?us-ascii?Q?dd8c3L2WulgXnE4XMzmmi83R4QUwEE4d7KroBuycojiNl+iIWoSuWzpkx8e2?=
 =?us-ascii?Q?tGs8PbAMD6kXZ/Kg1p0WQ3PN2ppcWBeznV9iGtXzp/7TeD984qRKH8V8Y0ql?=
 =?us-ascii?Q?+eNdH2kWpv4AUv1saI7YLPTqEerw98iD7T/yC7dlTsdrJTlxJnyjYC0keQKK?=
 =?us-ascii?Q?ybAC4BSxpDYSsF0HkriEZslmOGBwPMPgLby2zUStyRngYOMfoiGDfP0+t6mJ?=
 =?us-ascii?Q?S1IDyPQKwyZzyNJvLnxng2LbsTBo2uAeHliD5KRoiJ9xE2iNg+oRoKH5C93K?=
 =?us-ascii?Q?aLXK0GaCoFWr3ZRChSQLG36eUTPWvoVS+oUI4GvDoCLyayyli8aP0XugJ8S/?=
 =?us-ascii?Q?He7rHaTBLxyFGglb45LGcV4qmPvQNpIq2xLdMfrDCIuEJUksVDgqEH7SBEFP?=
 =?us-ascii?Q?E8xCVqoyqs929fFoCXOcFz0zh1aSrED8rDCtehFLpUDIna1O8FBe?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c115f7f-faeb-44e9-7c57-08df0a0134f6
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 21:20:41.3233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XpCLFxkIVLWvbHmm0Uhp9y+gNzsJX7N0zP/PYu/DoXUP/vILRO8tZsg+7x7KUxSGntLh0fytMFe+1Cx/6oNTXPnOaJxp9OGx2OHq66lXYqvCCpUJr5QrGwdI0o4Y0k2N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9229

On Tue, Sep 01, 2026 at 03:26:54AM +0900, Koichiro Den wrote:
> An RC may use endpoint-local DMA read channels to transfer data directly
> to an endpoint DMA address once both sides agree to use them. Quiescing
> an unrolled eDMA channel disables its whole direction, so reserve the
> complete read direction and route its interrupts to the RC when dma_bar
> is configured.
>
> Describe the controller and per-channel descriptor memory in a private
> control-region extension.
>
> Add a dma_bar configfs attribute. An explicit BAR selection enables DMA
> export; leaving it unassigned keeps the feature disabled.
>
> Keep resources already assigned to a BAR in place, and map the rest
> through the selected dma_bar.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes in v3:
>   - Use dma_bar as the opt-in and drop use_dma and automatic BAR selection.
>   - Split DMA/MW BAR sharing and the documentation into separate patches.
>   - Avoid mixing cleanup helpers with goto-based error paths. (Sashiko)
>   - Use pci_epf_assign_bar_space() and back only uncovered BAR ranges.
>     (Sashiko)
>
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 575 +++++++++++++++++-
>  1 file changed, 567 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index d12d134ce553..1842493c33b0 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -39,8 +39,12 @@
>  #include <linux/atomic.h>
>  #include <linux/bitops.h>
>  #include <linux/delay.h>
> +#include <linux/dma/edma.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmaengine.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> +#include <linux/overflow.h>
>  #include <linux/slab.h>
>
>  #include <linux/pci-ep-msi.h>
> @@ -56,6 +60,8 @@ static struct workqueue_struct *kpcintb_workqueue;
>  #define COMMAND_TEARDOWN_MW		4
>  #define COMMAND_LINK_UP			5
>  #define COMMAND_LINK_DOWN		6
> +#define COMMAND_CONFIGURE_DMA		7
> +#define COMMAND_TEARDOWN_DMA		8
>
>  #define COMMAND_STATUS_OK		1
>  #define COMMAND_STATUS_ERROR		2
> @@ -69,6 +75,10 @@ static struct workqueue_struct *kpcintb_workqueue;
>  #define MSIX_ENABLE			BIT(16)
>  #define MAX_MW				4
>
> +#define EPF_NTB_DMA_MAGIC		0x414d444e /* "NDMA": NTB DMA */
> +#define EPF_NTB_DMA_REVISION		1
> +#define EPF_NTB_DMA_TYPE_DW_EDMA	1
> +
>  /* Limit per-work execution to avoid monopolizing kworker on doorbell storms. */
>  #define VNTB_PEER_DB_WORK_BUDGET	5
>
> @@ -79,6 +89,7 @@ enum epf_ntb_bar {
>  	BAR_MW2,
>  	BAR_MW3,
>  	BAR_MW4,
> +	BAR_DMA,
>  	VNTB_BAR_NUM,
>  };
>
> @@ -91,6 +102,30 @@ enum epf_irq_slot {
>  #define MIN_DB_COUNT			(EPF_IRQ_DB_START + 1)
>  #define MAX_DB_COUNT			32
>
> +/* Private wire extension consumed by ntb_hw_epf. */
> +struct epf_ntb_dma_region_ctrl {
> +	u32 bar;
> +	u32 offset;
> +	u32 size;
> +} __packed;
> +
> +struct epf_ntb_dma_chan_ctrl {
> +	struct epf_ntb_dma_region_ctrl desc;
> +	u32 desc_addr_lo;
> +	u32 desc_addr_hi;
> +} __packed;
> +
> +struct epf_ntb_dma_ctrl {
> +	u32 magic;
> +	u16 revision;
> +	u16 length;
> +	u32 type;
> +	/* BAR range occupied by resources without a fixed BAR assignment. */
> +	struct epf_ntb_dma_region_ctrl submap;
> +	struct epf_ntb_dma_region_ctrl reg;
> +	struct epf_ntb_dma_chan_ctrl chan[EDMA_MAX_RD_CH];
> +} __packed;
> +
>  /*
>   * +--------------------------------------------------+ Base
>   * |                                                  |
> @@ -129,8 +164,21 @@ struct epf_ntb_ctrl {
>  	u32 db_entry_size;
>  	u32 db_data[MAX_DB_COUNT];
>  	u32 db_offset[MAX_DB_COUNT];
> +	struct epf_ntb_dma_ctrl dma;

I suggest move magic and revision to here intead of dma, in case we need
add more in future.

It is not good without version informaiton in this struct since historical
reason.

>  } __packed;
>
> +struct epf_ntb_dma {
> +	struct epf_ntb_dma_ctrl ctrl;
> +	struct dma_chan *dchan[EDMA_MAX_RD_CH];
> +	void *bar_scratch;
> +	dma_addr_t bar_scratch_phys;
> +	size_t bar_scratch_size;
> +	struct pci_epf_bar_submap submap[EDMA_MAX_RD_CH + 2];
> +	struct pci_epf_bar_submap *reg_submap;
> +	unsigned int num_submap;
> +	u16 rd_ch_cnt;
> +};
> +
>  struct epf_ntb {
>  	struct ntb_dev ntb;
>  	struct pci_epf *epf;
> @@ -159,6 +207,7 @@ struct epf_ntb {
>  	enum pci_barno epf_ntb_bar[VNTB_BAR_NUM];
>
>  	struct epf_ntb_ctrl *reg;
> +	struct epf_ntb_dma *dma;
>
>  	u32 *epf_db;
>
> @@ -211,7 +260,8 @@ static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
>  {
>  	int i;
>
> -	for (i = 0; i < VNTB_BAR_NUM; i++) {
> +	/* BAR_DMA is checked separately because it may share an MW BAR. */
> +	for (i = 0; i < BAR_DMA; i++) {
>  		if (ntb->epf_ntb_bar[i] == barno)
>  			return true;
>  	}
> @@ -219,6 +269,404 @@ static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
>  	return false;
>  }
>
> +static int epf_ntb_dma_validate_bar(struct epf_ntb *ntb,
> +				    const struct pci_epc_features *features)
> +{
> +	enum pci_barno barno = ntb->epf_ntb_bar[BAR_DMA];
> +
> +	if (epf_ntb_is_bar_used(ntb, barno) ||
> +	    pci_epc_get_next_free_bar(features, barno) != barno)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +struct epf_ntb_dma_filter {
> +	struct device *dev;
> +	int chan_id;
> +};
> +
> +static bool epf_ntb_dma_filter(struct dma_chan *chan, void *data)
> +{
> +	struct epf_ntb_dma_filter *filter = data;
> +
> +	return chan->device->dev == filter->dev &&
> +	       chan->chan_id == filter->chan_id;
> +}
> +
> +static int epf_ntb_dma_add_region(struct epf_ntb_dma *dma,
> +				  const struct pci_epc_aux_resource *resource,
> +				  dma_addr_t target_addr,
> +				  enum pci_barno barno, size_t align, u32 *next,
> +				  struct epf_ntb_dma_region_ctrl *region)
> +{
> +	struct pci_epf_bar_submap *submap;
> +	resource_size_t delta, map_size, size;
> +	dma_addr_t base;
> +
> +	if (!resource->size || resource->size > U32_MAX)
> +		return -EINVAL;
> +
> +	region->size = resource->size;
> +	if (resource->bar != NO_BAR) {
> +		if (resource->bar < BAR_0 || resource->bar > BAR_5 ||
> +		    resource->bar_offset > U32_MAX)
> +			return -EINVAL;
> +
> +		region->bar = resource->bar;
> +		region->offset = resource->bar_offset;
> +		return 0;
> +	}
> +	submap = &dma->submap[dma->num_submap];
> +
> +	/*
> +	 * Meet the EPC alignment requirement by mapping an aligned superset
> +	 * and advertising the resource after any leading padding.
> +	 */
> +	base = ALIGN_DOWN(target_addr, align);
> +	delta = target_addr - base;
> +	if (check_add_overflow(delta, resource->size, &size))
> +		return -EOVERFLOW;
> +	map_size = ALIGN(size, align);
> +	if (map_size < size || map_size > U32_MAX - *next)
> +		return -EOVERFLOW;
> +
> +	submap->phys_addr = base;
> +	submap->size = map_size;
> +	region->bar = barno;
> +	region->offset = *next + delta;
> +	*next += map_size;
> +	dma->num_submap++;
> +
> +	return 0;
> +}
> +
> +/* DW eDMA */
> +
> +static int epf_ntb_dw_edma_claim(struct device *dev, int chan_id,
> +				 struct dma_chan **dchan)
> +{
> +	enum dw_edma_ch_irq_mode mode = DW_EDMA_CH_IRQ_REMOTE;
> +	struct epf_ntb_dma_filter filter = {
> +		.dev = dev,
> +		.chan_id = chan_id,
> +	};
> +	struct dma_slave_config config = {
> +		.peripheral_config = &mode,
> +		.peripheral_size = sizeof(mode),
> +	};
> +	dma_cap_mask_t mask;
> +	struct dma_chan *chan;
> +	int ret;
> +
> +	dma_cap_zero(mask);
> +	dma_cap_set(DMA_SLAVE, mask);
> +	chan = dma_request_channel(mask, epf_ntb_dma_filter, &filter);
> +	if (!chan)
> +		return -EBUSY;
> +
> +	ret = dmaengine_slave_config(chan, &config);
> +	if (ret) {
> +		dma_release_channel(chan);
> +		return ret;
> +	}
> +
> +	*dchan = chan;
> +
> +	return 0;
> +}
> +
> +static void epf_ntb_dw_edma_release_channels(struct epf_ntb *ntb,
> +					     struct epf_ntb_dma *dma,
> +					     bool quiesce)
> +{
> +	unsigned int i;
> +	int ret;
> +
> +	if (quiesce) {
> +		/*
> +		 * RC programming has stopped and this EPF owns the complete read
> +		 * direction, so one termination quiesces the direction.
> +		 */
> +		ret = dmaengine_terminate_sync(dma->dchan[0]);
> +		if (ret)
> +			dev_warn(&ntb->epf->dev,
> +				 "failed to terminate remote DMA: %d\n", ret);
> +	}
> +
> +	for (i = 0; i < dma->rd_ch_cnt; i++) {
> +		if (!dma->dchan[i])
> +			continue;
> +
> +		dma_release_channel(dma->dchan[i]);
> +	}
> +}
> +
> +static const struct pci_epc_aux_resource *
> +epf_ntb_dw_edma_find_desc(const struct pci_epc_aux_resource *resources,
> +			  unsigned int count, u16 chan_id)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < count; i++)
> +		if (resources[i].type == PCI_EPC_AUX_DMA_DESC_MEM &&
> +		    resources[i].u.dma_desc.chan_id == chan_id)
> +			return &resources[i];
> +
> +	return NULL;
> +}
> +
> +static int
> +epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
> +			struct epf_ntb_dma *dma,
> +			const struct pci_epc_aux_resource *ctrl,
> +			const struct pci_epc_aux_resource *resources,
> +			unsigned int count)
> +{
> +	const struct pci_epc_features *features;
> +	const struct pci_epc_aux_resource *desc[EDMA_MAX_RD_CH];
> +	enum pci_barno barno = ntb->epf_ntb_bar[BAR_DMA];
> +	struct device *dma_dev;
> +	bool needs_submap;
> +	unsigned int i;
> +	size_t align;
> +	u32 next = 0;
> +	int ret;
> +
> +	if (ctrl->u.dma_ctrl.reg_layout_data != EDMA_MF_EDMA_UNROLL)
> +		return -EOPNOTSUPP;
> +	if (ctrl->u.dma_ctrl.ep_to_rc_ch_cnt > EDMA_MAX_WR_CH ||
> +	    !ctrl->u.dma_ctrl.rc_to_ep_ch_cnt ||
> +	    ctrl->u.dma_ctrl.rc_to_ep_ch_cnt > EDMA_MAX_RD_CH)
> +		return -EINVAL;

this should never happen, it should validate at export resources side.

> +
> +	dma->rd_ch_cnt = ctrl->u.dma_ctrl.rc_to_ep_ch_cnt;

You export all channel to RC? suppose you only need export necessary one.

I need more time to understand this patch.

Frank
> +
> +	features = pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no,
> +					ntb->epf->vfunc_no);
> +	if (!features)
> +		return -EOPNOTSUPP;
> +
> +	align = features->align ?: 1;
> +	if (!is_power_of_2(align))
> +		return -EINVAL;
> +
> +	needs_submap = ctrl->bar == NO_BAR;
> +	/* DW eDMA static IDs place read channels after all write channels. */
> +	for (i = 0; i < dma->rd_ch_cnt; i++) {
> +		u16 chan_id = ctrl->u.dma_ctrl.ep_to_rc_ch_cnt + i;
> +`
> +		desc[i] = epf_ntb_dw_edma_find_desc(resources, count, chan_id);
> +		if (!desc[i])
> +			return -EINVAL;
> +		needs_submap |= desc[i]->bar == NO_BAR;
> +	}
> +	if (needs_submap) {
> +		if (!features->subrange_mapping ||
> +		    !features->dynamic_inbound_mapping)
> +			return -EOPNOTSUPP;
> +		ret = epf_ntb_dma_validate_bar(ntb, features);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	dma->ctrl.magic = EPF_NTB_DMA_MAGIC;
> +	dma->ctrl.revision = EPF_NTB_DMA_REVISION;
> +	dma->ctrl.type = EPF_NTB_DMA_TYPE_DW_EDMA;
> +	dma->ctrl.submap.bar = U32_MAX;
> +	dma->ctrl.length = offsetof(struct epf_ntb_dma_ctrl,
> +				    chan[dma->rd_ch_cnt]);
> +
> +	if (ctrl->bar == NO_BAR)
> +		dma->reg_submap = &dma->submap[dma->num_submap];
> +	ret = epf_ntb_dma_add_region(dma, ctrl, ctrl->phys_addr,
> +				     barno, align, &next, &dma->ctrl.reg);
> +	if (ret)
> +		return ret;
> +	for (i = 0; i < dma->rd_ch_cnt; i++) {
> +		struct epf_ntb_dma_chan_ctrl *chan = &dma->ctrl.chan[i];
> +		dma_addr_t dma_addr = desc[i]->u.dma_desc.dma_addr;
> +
> +		ret = epf_ntb_dma_add_region(dma, desc[i], dma_addr, barno,
> +					     align, &next,
> +					     &chan->desc);
> +		if (ret)
> +			return ret;
> +		chan->desc_addr_lo = lower_32_bits(dma_addr);
> +		chan->desc_addr_hi = upper_32_bits(dma_addr);
> +	}
> +	if (dma->num_submap) {
> +		dma->ctrl.submap.bar = barno;
> +		dma->ctrl.submap.size = next;
> +	}
> +
> +	dma_dev = ntb->epf->epc->dev.parent;
> +	for (i = 0; i < dma->rd_ch_cnt; i++) {
> +		u16 chan_id = ctrl->u.dma_ctrl.ep_to_rc_ch_cnt + i;
> +
> +		ret = epf_ntb_dw_edma_claim(dma_dev, chan_id, &dma->dchan[i]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +/* Common endpoint DMA */
> +
> +static void epf_ntb_dma_release_channels(struct epf_ntb *ntb,
> +					 struct epf_ntb_dma *dma,
> +					 bool quiesce)
> +{
> +	switch (dma->ctrl.type) {
> +	case EPF_NTB_DMA_TYPE_DW_EDMA:
> +		epf_ntb_dw_edma_release_channels(ntb, dma, quiesce);
> +		break;
> +	}
> +}
> +
> +static int epf_ntb_dma_collect(struct epf_ntb *ntb)
> +{
> +	const struct pci_epc_aux_resource *ctrl = NULL;
> +	struct device *dma_dev;
> +	dma_addr_t dma_addr;
> +	unsigned int i;
> +	int count, ret;
> +
> +	if (ntb->epf_ntb_bar[BAR_DMA] == NO_BAR)
> +		return 0;
> +
> +	count = pci_epc_get_aux_resources_count(ntb->epf->epc,
> +						ntb->epf->func_no,
> +						ntb->epf->vfunc_no);
> +	if (count <= 0)
> +		return count ?: -ENODEV;
> +
> +	struct pci_epc_aux_resource *resources __free(kfree) =
> +		kcalloc(count, sizeof(*resources), GFP_KERNEL);
> +	if (!resources)
> +		return -ENOMEM;
> +
> +	ret = pci_epc_get_aux_resources(ntb->epf->epc, ntb->epf->func_no,
> +					ntb->epf->vfunc_no, resources, count);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < count; i++) {
> +		if (resources[i].type != PCI_EPC_AUX_DMA_CTRL_MMIO)
> +			continue;
> +		if (ctrl)
> +			return -EINVAL;
> +		ctrl = &resources[i];
> +	}
> +	if (!ctrl)
> +		return -ENODEV;
> +
> +	struct epf_ntb_dma *dma __free(kfree) =
> +		kzalloc(sizeof(*dma), GFP_KERNEL);
> +	if (!dma)
> +		return -ENOMEM;
> +
> +	switch (ctrl->u.dma_ctrl.reg_layout) {
> +	case PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA:
> +		ret = epf_ntb_dw_edma_collect(ntb, dma, ctrl, resources, count);
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +	if (ret) {
> +		epf_ntb_dma_release_channels(ntb, dma, false);
> +		return ret;
> +	}
> +
> +	/*
> +	 * CTRL_MMIO carries a CPU physical address, while DMA_DESC_MEM already
> +	 * carries an endpoint DMA address. Convert only the former.
> +	 */
> +	if (dma->reg_submap) {
> +		dma_dev = ntb->epf->epc->dev.parent;
> +		dma_addr = dma_map_resource(dma_dev,
> +					    dma->reg_submap->phys_addr,
> +					    dma->reg_submap->size,
> +					    DMA_BIDIRECTIONAL, 0);
> +		if (dma_mapping_error(dma_dev, dma_addr)) {
> +			epf_ntb_dma_release_channels(ntb, dma, false);
> +			return -EIO;
> +		}
> +		dma->reg_submap->phys_addr = dma_addr;
> +	}
> +
> +	ntb->dma = no_free_ptr(dma);
> +
> +	return 0;
> +}
> +
> +static void epf_ntb_dma_release(struct epf_ntb *ntb, bool quiesce)
> +{
> +	struct epf_ntb_dma *dma = ntb->dma;
> +	struct device *dev;
> +
> +	if (!dma)
> +		return;
> +
> +	epf_ntb_dma_release_channels(ntb, dma, quiesce);
> +	dev = ntb->epf->epc->dev.parent;
> +	if (dma->reg_submap)
> +		dma_unmap_resource(dev, dma->reg_submap->phys_addr,
> +				   dma->reg_submap->size, DMA_BIDIRECTIONAL, 0);
> +	if (dma->bar_scratch)
> +		dma_free_coherent(dev, dma->bar_scratch_size,
> +				  dma->bar_scratch, dma->bar_scratch_phys);
> +	kfree(dma);
> +	ntb->dma = NULL;
> +}
> +
> +static int epf_ntb_dma_set_bar(struct epf_ntb *ntb, bool active)
> +{
> +	struct pci_epf_bar_submap *old_submap;
> +	struct epf_ntb_dma *dma = ntb->dma;
> +	struct pci_epf_bar *bar;
> +	unsigned int old_num_submap;
> +	int restore, ret;
> +
> +	bar = &ntb->epf->bar[ntb->epf_ntb_bar[BAR_DMA]];
> +	old_submap = bar->submap;
> +	old_num_submap = bar->num_submap;
> +	bar->submap = active ? dma->submap : NULL;
> +	bar->num_submap = active ? dma->num_submap : 0;
> +
> +	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
> +			      ntb->epf->vfunc_no, bar);
> +	if (!ret)
> +		return 0;
> +
> +	/* A failed dynamic update may have already removed the old mapping. */
> +	bar->submap = old_submap;
> +	bar->num_submap = old_num_submap;
> +	restore = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
> +				  ntb->epf->vfunc_no, bar);
> +	if (restore)
> +		dev_warn(&ntb->epf->dev,
> +			 "failed to restore DMA BAR mapping: %d\n", restore);
> +
> +	return ret;
> +}
> +
> +static int epf_ntb_dma_set_active(struct epf_ntb *ntb, bool active)
> +{
> +	struct epf_ntb_dma *dma = ntb->dma;
> +	struct pci_epf_bar *bar;
> +
> +	if (!dma || !dma->num_submap)
> +		return 0;
> +
> +	bar = &ntb->epf->bar[ntb->epf_ntb_bar[BAR_DMA]];
> +	if (active == !!bar->num_submap)
> +		return 0;
> +
> +	return epf_ntb_dma_set_bar(ntb, active);
> +}
> +
>  /**
>   * epf_ntb_configure_mw() - Configure the Outbound Address Space for VHOST
>   *   to access the memory window of HOST
> @@ -339,6 +787,13 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
>  		epf_ntb_teardown_mw(ntb, argument);
>  		ctrl->command_status = COMMAND_STATUS_OK;
>  		break;
> +	case COMMAND_CONFIGURE_DMA:
> +	case COMMAND_TEARDOWN_DMA:
> +		ret = epf_ntb_dma_set_active(ntb,
> +					     command == COMMAND_CONFIGURE_DMA);
> +		ctrl->command_status = ret ? COMMAND_STATUS_ERROR :
> +					     COMMAND_STATUS_OK;
> +		break;
>  	case COMMAND_LINK_UP:
>  		ntb->linkup = true;
>  		ret = epf_ntb_link_up(ntb, true);
> @@ -459,9 +914,8 @@ static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
>   *   region
>   * @ntb: NTB device that facilitates communication between HOST and VHOST
>   *
> - * Allocate the Local Memory mentioned in the above diagram. The size of
> - * CONFIG REGION is sizeof(struct epf_ntb_ctrl) and size of SCRATCHPAD REGION
> - * is obtained from "spad-count" configfs entry.
> + * Allocate the control and scratchpad regions, omitting the optional DMA
> + * extension when no channels are exported.
>   *
>   * Returns: Zero for success, or an error code in case of failure
>   */
> @@ -481,7 +935,9 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
>  	barno = ntb->epf_ntb_bar[BAR_CONFIG];
>  	spad_count = ntb->spad_count;
>
> -	ctrl_size = ALIGN(sizeof(struct epf_ntb_ctrl), sizeof(u32));
> +	ctrl_size = ntb->dma ? sizeof(struct epf_ntb_ctrl) :
> +			       offsetof(struct epf_ntb_ctrl, dma);
> +	ctrl_size = ALIGN(ctrl_size, sizeof(u32));
>  	spad_size = 2 * spad_count * sizeof(u32);
>
>  	base = pci_epf_alloc_space(epf, ctrl_size + spad_size,
> @@ -507,6 +963,9 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
>  		ntb->reg->db_offset[i] = 0;
>  	}
>
> +	if (ntb->dma)
> +		ctrl->dma = ntb->dma->ctrl;
> +
>  	return 0;
>  }
>
> @@ -738,6 +1197,83 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
>
>  static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws);
>
> +static int epf_ntb_dma_bar_init(struct epf_ntb *ntb)
> +{
> +	const struct pci_epc_features *features;
> +	struct epf_ntb_dma *dma = ntb->dma;
> +	struct device *dev = ntb->epf->epc->dev.parent;
> +	struct pci_epf_bar *bar;
> +	enum pci_barno barno;
> +	size_t backing_size;
> +	u32 mapped_size;
> +	int ret;
> +
> +	features = pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no,
> +					ntb->epf->vfunc_no);
> +	if (!features)
> +		return -EOPNOTSUPP;
> +
> +	barno = ntb->epf_ntb_bar[BAR_DMA];
> +	mapped_size = dma->ctrl.submap.size;
> +	/*
> +	 * Submaps cannot be installed until the host assigns the BAR address.
> +	 * Use address 0 for the temporary BAR Match Mode mapping, as is done
> +	 * for regular vNTB MW BARs.
> +	 */
> +	ret = pci_epf_assign_bar_space(ntb->epf, mapped_size, barno, features,
> +				       PRIMARY_INTERFACE, 0);
> +	if (ret)
> +		return ret;
> +
> +	bar = &ntb->epf->bar[barno];
> +	if (bar->size > U32_MAX)
> +		return -EOVERFLOW;
> +
> +	backing_size = bar->size - mapped_size;
> +	if (backing_size) {
> +		/* Back the BAR tail added by the power-of-two size rounding. */
> +		dma->bar_scratch = dma_alloc_coherent(dev, backing_size,
> +						      &dma->bar_scratch_phys,
> +						      GFP_KERNEL);
> +		if (!dma->bar_scratch)
> +			return -ENOMEM;
> +		dma->bar_scratch_size = backing_size;
> +		if (!IS_ALIGNED(dma->bar_scratch_phys, features->align ?: 1))
> +			return -EINVAL;
> +
> +		dma->submap[dma->num_submap++] = (struct pci_epf_bar_submap) {
> +			.phys_addr = dma->bar_scratch_phys,
> +			.size = backing_size,
> +		};
> +	}
> +
> +	return pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
> +			       ntb->epf->vfunc_no, bar);
> +}
> +
> +static void epf_ntb_dma_bar_clear(struct epf_ntb *ntb)
> +{
> +	struct epf_ntb_dma *dma = ntb->dma;
> +	struct pci_epf_bar *bar;
> +	enum pci_barno barno;
> +
> +	if (!dma || !dma->num_submap)
> +		return;
> +
> +	barno = ntb->epf_ntb_bar[BAR_DMA];
> +	bar = &ntb->epf->bar[barno];
> +	pci_epc_clear_bar(ntb->epf->epc, ntb->epf->func_no,
> +			  ntb->epf->vfunc_no, bar);
> +	bar->submap = NULL;
> +	bar->num_submap = 0;
> +	bar->phys_addr = 0;
> +	bar->addr = NULL;
> +	bar->size = 0;
> +	bar->mem_size = 0;
> +	bar->barno = 0;
> +	bar->flags = 0;
> +}
> +
>  /**
>   * epf_ntb_db_bar_clear() - Clear doorbell BAR and free memory
>   *   allocated in peer's outbound address space
> @@ -877,7 +1413,8 @@ static int epf_ntb_find_bar(struct epf_ntb *ntb,
>  		 * Verify if the BAR found is not already assigned
>  		 * through the provided configuration
>  		 */
> -		if (!epf_ntb_is_bar_used(ntb, barno))
> +		if (ntb->epf_ntb_bar[BAR_DMA] != barno &&
> +		    !epf_ntb_is_bar_used(ntb, barno))
>  			ntb->epf_ntb_bar[bar] = barno;
>
>  		barno += 1;
> @@ -976,11 +1513,19 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
>  		goto err_mw_bar_init;
>  	}
>
> +	if (ntb->dma && ntb->dma->num_submap) {
> +		ret = epf_ntb_dma_bar_init(ntb);
> +		if (ret) {
> +			dev_err(dev, "DMA BAR init failed\n");
> +			goto err_dma_bar_init;
> +		}
> +	}
> +
>  	if (vfunc_no <= 1) {
>  		ret = pci_epc_write_header(epc, func_no, vfunc_no, epf->header);
>  		if (ret) {
>  			dev_err(dev, "Configuration header write failed\n");
> -			goto err_write_header;
> +			goto err_dma_bar_init;
>  		}
>  	}
>
> @@ -992,7 +1537,8 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
>
>  	return 0;
>
> -err_write_header:
> +err_dma_bar_init:
> +	epf_ntb_dma_bar_clear(ntb);
>  	epf_ntb_mw_bar_clear(ntb, ntb->num_mws);
>  err_mw_bar_init:
>  	epf_ntb_db_bar_clear(ntb);
> @@ -1015,6 +1561,7 @@ static void epf_ntb_epc_cleanup(struct epf_ntb *ntb)
>  	disable_delayed_work_sync(&ntb->cmd_handler);
>  	disable_work_sync(&ntb->peer_db_work);
>  	atomic64_set(&ntb->peer_db_pending, 0);
> +	epf_ntb_dma_bar_clear(ntb);
>  	epf_ntb_mw_bar_clear(ntb, ntb->num_mws);
>  	epf_ntb_db_bar_clear(ntb);
>  	epf_ntb_config_sspad_bar_clear(ntb);
> @@ -1221,10 +1768,13 @@ EPF_NTB_BAR_R(mw3_bar, BAR_MW3)
>  EPF_NTB_BAR_W(mw3_bar, BAR_MW3)
>  EPF_NTB_BAR_R(mw4_bar, BAR_MW4)
>  EPF_NTB_BAR_W(mw4_bar, BAR_MW4)
> +EPF_NTB_BAR_R(dma_bar, BAR_DMA)
> +EPF_NTB_BAR_W(dma_bar, BAR_DMA)
>
>  CONFIGFS_ATTR(epf_ntb_, spad_count);
>  CONFIGFS_ATTR(epf_ntb_, db_count);
>  CONFIGFS_ATTR(epf_ntb_, num_mws);
> +CONFIGFS_ATTR(epf_ntb_, dma_bar);
>  CONFIGFS_ATTR(epf_ntb_, mw1);
>  CONFIGFS_ATTR(epf_ntb_, mw2);
>  CONFIGFS_ATTR(epf_ntb_, mw3);
> @@ -1243,6 +1793,7 @@ static struct configfs_attribute *epf_ntb_attrs[] = {
>  	&epf_ntb_attr_spad_count,
>  	&epf_ntb_attr_db_count,
>  	&epf_ntb_attr_num_mws,
> +	&epf_ntb_attr_dma_bar,
>  	&epf_ntb_attr_mw1,
>  	&epf_ntb_attr_mw2,
>  	&epf_ntb_attr_mw3,
> @@ -1743,6 +2294,12 @@ static int epf_ntb_bind(struct pci_epf *epf)
>  		return ret;
>  	}
>
> +	ret = epf_ntb_dma_collect(ntb);
> +	if (ret) {
> +		dev_err(dev, "Failed to prepare NTB DMA export\n");
> +		return ret;
> +	}
> +
>  	ret = epf_ntb_config_spad_bar_alloc(ntb);
>  	if (ret) {
>  		dev_err(dev, "Failed to allocate BAR memory\n");
> @@ -1779,6 +2336,7 @@ static int epf_ntb_bind(struct pci_epf *epf)
>  	epf_ntb_epc_cleanup(ntb);
>  err_bar_alloc:
>  	epf_ntb_config_spad_bar_free(ntb);
> +	epf_ntb_dma_release(ntb, false);
>
>  	return ret;
>  }
> @@ -1795,6 +2353,7 @@ static void epf_ntb_unbind(struct pci_epf *epf)
>
>  	epf_ntb_epc_cleanup(ntb);
>  	epf_ntb_config_spad_bar_free(ntb);
> +	epf_ntb_dma_release(ntb, true);
>
>  	pci_unregister_driver(&vntb_pci_driver);
>  }
> --
> 2.51.0
>
