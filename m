Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013057.outbound.protection.outlook.com [40.107.162.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC33254B03;
	Wed, 22 Jul 2026 15:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784733748; cv=fail; b=jcbMoP5nnWpZmn8TzoYmMxL3r7OJeEAecAzjK/5lzWsSiJDbContCHr+j/sQD+WBjDoztHUf7wwdO8RrhL4L7A+meoqcOmZNVnoEYpTqWa6ThbcY+PTVvvBoiAGoXv6QrkOnAmzI6ZbEhH1XRyX67LUZKQyU+0TW1SsGCFBo1Qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784733748; c=relaxed/simple;
	bh=dQ2Rmni/BxkGAYCiik8OljEu1+ofKgcJ7vBMgIVb+mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qp4faDl34+71hgJs+rspnE5DcKr/iSubliPWfEs1R6UCtOeqwI50wbHpX50YyQ5vlvUEHCbvH4dUrcZfkcWJtSoGStKGAgMYhqNNt6u/P2jjfsf4aZtS6350/O+39Vod+uKL8eMOFlq27i3qRw0lRAe0n1iyHWFC0szLhg/ZJ+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=J9ggi8cb; arc=fail smtp.client-ip=40.107.162.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="J9ggi8cb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fyVAC+SjOYg+31u/pdBO/ZOFQ3MJxKPMDa6MhjLq94JPzgRnZPcslV51voAeAhZ9CGbJfe2cxF/BaUW3CjUYifoid9K8dZ1jzPH5Iu54Lv3ZvibSYZqWzaFx8G5hkZRYipjBJ5Jb8oQW0K9X9Vau49kQKvENjbXSIOLoqU4Ed76dxT7T5xED/pMAIbcEsQtsS/jjxgKjlsKexm4+6MgCZDGpK7p5DeUW7x0tikX3BMj11RX0EhEW8+IAdQDhTscwSS8v7gkq69MNwL0WBkYQRwP9cucelebFSyUQQsJeGc0iscIpZdSU9OA096Iqd2KwPmCEt2AQpQCqCx9Vk8chPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPoH1RHGzfZ7k8jDruBCnxR5QrAzhYdS8XC0nr6KJy8=;
 b=XpglDFK2n2DMBCHiUpjWDACDjAEkYyWyBSm6R5wUNsvJCoINX2bJirlyNjtP+zzE4o2zK8RVkUhvImd6uvjsCo6FxhJ5CXyzBY6skdQNxTJqlKZzCpVdQqOy7T3GAi6AsqwyhX/A6xkmFC1vQKCY1AJAbzJdt/j26ZsdLMOQ6kW79AdaMdMRVtQlvRY30YDEW2sJPbmc2q+EcglxO2M9pqALV0t77TVR0AHx5IJ01eJxv1xjqEFCJ/OBXXiYEwvxpxr0ClbSKZOBHXIH4mC9zc8bBF5mtaEpMPYqZvz1MeubEv+bbXD39G7JuiKHgYqjmUT1xVVoRqscoKq/BOK3pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPoH1RHGzfZ7k8jDruBCnxR5QrAzhYdS8XC0nr6KJy8=;
 b=J9ggi8cbKePufHOFJf13i4AqqriRHGDa1jznDROr0oAaLhwv2I+dqVk0daZz3sCe64kzvXaz0n/LMg0Ki0GgjskiGX7BtrX7xyDk7GROXZ4fkbSk3hbPbmcPUdyqT3rroe1bccRwtGxjN+qyXL9Jq42V6Knr9JWnReX/rN4fkHAzBqiAfn4b90VEt+LokZ9ka3xxK9s234MZ/FJDr+KEK5Xl+oZ0eshklzUXVvaH2VNUpDJwJCfZUQ82LU4LIsX710GScIXEjX0I1JATrEUvHmIdqaljKjrldK83zXLsHJYH4xgCWOv17wH0L4iys9Hwh5EsT62jnWWcsjuUL2ZWDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM0PR04MB6850.eurprd04.prod.outlook.com (2603:10a6:208:180::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 15:22:17 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 15:22:17 +0000
Date: Wed, 22 Jul 2026 10:22:08 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Devendra K Verma <devverma@amd.com>, Koichiro Den <den@valinux.co.jp>
Cc: mani@kernel.org, vkoul@kernel.org, frank.li@kernel.org,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com
Subject: Re: [PATCH v1 3/3] dmaengine: dw-edma: Add changes to support
 Channel Separation
Message-ID: <amDgIC0ZNGnGibzK@SMW015318>
References: <20260722111640.1146212-1-devverma@amd.com>
 <20260722111640.1146212-4-devverma@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722111640.1146212-4-devverma@amd.com>
X-ClientProxiedBy: SA9PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:806:20::15) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM0PR04MB6850:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f016f79-62bc-4731-0010-08dee80503b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|19092799006|22082099003|18002099003|10067099003|56012099006|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	vyk/p3YM7RY2PFn0AmL03/8ruLJ2t2Go2xByLagmQaMLwm+YUdObOSlJnjsp2o+5c8mUa2GS+JW2iVG4HUHJ+P3lc1+gQUcjzBGerVIGTlAxTVD2uoK20K3VboMe52qOkQVrcJVDWrOTlFwwSm5c40WXkgxzH0ZT2WyXqQ51i8QuQbmjYJeaeStf0G1zK9butBUHQYy2scFz23CoEjH6TNclOUIb9rv3vWXj8gSczbu2CjidxuZJDTo6+yE9Zkcb80tQzxFTv4FIH7VSYHz8JUKwn/dddCq+RNP1pEgz3gdsiY0wSxtUXFnaJ8rXwtdcpQ7WXuL8W5xX4yQDSgt7oOC8SfE3vU1IR9MQ0TepQwsVRfpSVl7Y9hGOB+t8AREU40XtZezdkQ8Wr1JyQFUMY7gJE2J0OqO59uAmFI8CGbb+vg5q3tKWDCzFGYCLTmVhqqnRzpV76JL1jXBScIB2F4G2osuTS8agwEOIXWzljG+ChEuiihWFRvrvthsjwYgfjja+MwzP6W27QbzRYXStWIXLUVTiabnxe2WvCQ3oRuR+XOpqT/RgubJ82sCkam3xd6tIG4j/T5aOgj3vILima+NgouAKpEz/BWSDbP5x/NHGs5ep60vA6LPSA2u1ZFm8YnptFweZUEHLuS/FNiS9g2J08sbnVgBUs23NOwC/QVw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(19092799006)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8cH4g/p6R6YpVq5sGPduSQo4V/JDHXBtctunD087sfAXWKCMFpOwtOVKkvKm?=
 =?us-ascii?Q?FEPwAkepAzO9GIfhAwy1yAKCGWHaC8lky3EsIXzWBKFFexbAOwD/Oe7KyZI6?=
 =?us-ascii?Q?8CSefNHoeKz42NwgdGuobHQYMDRG8oIHps7fh3ayt4LhtagZyJUOgh84Fq24?=
 =?us-ascii?Q?4ho8DNniKwkwXPfjp5lF/6ve6y8MsvLsvSB6eLWYwxAZ1HmEi/2+gigbIQYN?=
 =?us-ascii?Q?Cw5J54quddPMgteO4UFXJm1f7537vP5qF/vCuu7M/F4va8sfArUS1tzB28qk?=
 =?us-ascii?Q?Z8gWb98QdF437ImnH9KNFhVUCaCyzJhzco4cGkMeganHVRzBVQJ4rKW6Vp0k?=
 =?us-ascii?Q?QYlzC8DnIyYh3d+DokQ96sQ+P9ID3Ti3rYp0hiC+h/1ti1H+egMY5sO8XjDT?=
 =?us-ascii?Q?FBIGriZlzVfGQ/94xE8JeZ2nS55P7IJeCIlEBuR1QqTfxEOac8EWbIZQoexF?=
 =?us-ascii?Q?wAt+daSvSG2XAQDnuWrs06lJdmiZd/X4Eyl+fNz+9YWCBN6kDV4cVgTpK6Pn?=
 =?us-ascii?Q?oTZ1qeoWIKCBbNrFQOP4JnL2gThby4Zhq6lufXIds/qwdhhe+JWfWXjtqFNm?=
 =?us-ascii?Q?CA/Lbz7LT82vp3tZC5SIdZVUFH2jCsjxRQjJBprlS+G+/I3dRt3jCg6kchHf?=
 =?us-ascii?Q?ElGHv/ybFvSvbF53Cf3x0WePe8SMBVAiJ3ymFc9QzQBAwfRzGLV3km1mafO+?=
 =?us-ascii?Q?2AcQ53UQC5NM1mAqMZQQMQS7hVFPy8eolxcbTKxlDp6x4xGiu2vf14Nueog+?=
 =?us-ascii?Q?C8+k452wZAujQPOUSmbmza6Otpzubt1QQcuQOzaY4TTEgqiuTWwvBLA9onTX?=
 =?us-ascii?Q?ZMWrcXT5E/VqWh9jvSxALJBNRpJc7BQUw1fRCDRfxtU2TLUbmERDZ6bIdnT9?=
 =?us-ascii?Q?SwmZRaUs/GN4bW8iXtX92NKa85G/PYQMmVQ77dOK8ZtSj8Ua8+XA0JD9cx+6?=
 =?us-ascii?Q?MygUp7YbnRqJf2zfxGbUFzDC0NZ4H5PHZ70C2JDFvf85g4IrRqvQCyLAfBhy?=
 =?us-ascii?Q?DQFu4jt9pTT8/azmVuSfre1MFsMPPT2KPNt6FH9Q7p39fJIqijo3MuJ4jsni?=
 =?us-ascii?Q?+YvqBg3HLbxh5cTWGeJDiPMjxUkQ4/m7h7RgbdOX8tbBAnWyGxo1XkCbdgQZ?=
 =?us-ascii?Q?pz5Hi61Gs5WiMk0ZhGb3sSraoTpvwfgiu9Xik+gE7kG8qaqXyZ7xjnYzBOJd?=
 =?us-ascii?Q?jO3QSulx6faA6b2H3N1zLMnVdff7jASFjOh/T45Ut1A48uFfqbWgtVpc0tCH?=
 =?us-ascii?Q?8ub72WUtsdmSLIb/2Iei9ffDCb7RHLqakvKFo8RQKkzlKnLYubAw5R3/kUr3?=
 =?us-ascii?Q?bVZueKw2E2vI318xh+gGIJAsETk1rFeH81GdYbAqvPlAnUZOg5hoA7JVl/uR?=
 =?us-ascii?Q?o/0AMY9wS5nmg7+jg0AuOqEpUQnSWcA9SFuRI90ohDQwK4ko4QxPQeQ3R0Mi?=
 =?us-ascii?Q?OZPSJpKZ+lskyd11+/hUnxdUX4J2ZvxKzgQ5EaxXMgUxtEEVjT2Ad5KOBLPN?=
 =?us-ascii?Q?CLEG/KI4DBm0BGbRTQXwHlDPOc/QLKUC1/uOO4ZuoFjsHtgszrG+FuStbRSl?=
 =?us-ascii?Q?fbyouuwkmyob0dwTan0TQIjnP5qK5wPed97Ckbk+kYw23ymRXndRHva8urgD?=
 =?us-ascii?Q?8N4aVPOUoexjBicxN1W+0zXeQSt9o0XdgZP1LyZD4EvlzGAakPmq2BAOs9+7?=
 =?us-ascii?Q?BMAOMPDyhZMCb9jjhtAKtseQjdgRq1OjkIeGulx+NnWWkdFGLCI0vFnigmQD?=
 =?us-ascii?Q?qijAV68jNg1l0tSNo6WakhqcPnrPp69gBqC4jtE3oftZuNUOBNgh?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f016f79-62bc-4731-0010-08dee80503b6
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 15:22:16.9683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eanOQHDAnkvHV8qucsE/Q8IACiVuhOaW+PsCJDmTaU1XknkhOBbQE+UclSnvLNFy7/NhiaUduv96ej6+CTawDlc0jPFCO9KOdwq3UhN9LE4h1UW3Ij4o+L59JJIDUAUY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6850

On Wed, Jul 22, 2026 at 04:46:40PM +0530, Devendra K Verma wrote:

Add Koichiro Den, who did many work with this edma driver recently

> Following changes are made:
> o In 'struct dw_hdma_v0_ch_regs', it is assumed the channel
>   separation as 256-bytes which is default, but if an IP is

channel register space size?

>   configured for a different size of channel separation then
>   user can retrieve it using the supported VSEC (0x6).
>   Modified the struct to work with the channel separation
>   supported by IP.
>   CPM6 supports channel separation, default is 512.


> o Changes in macros / functions where address of the channel
>   is accessed based on channel index and direction. It enables
>   the calculation of the channel reg base address based on
>   the selected channel separation.
> o Struct removed - dw_hdma_v0_ch, dw_hdma_v0_regs
> o Functions removed - __dw_regs()

Can you summary change and purpose? such as

Support difference channel register space size for difference IP. Previous
use fix default value 256, CMP6 support difference register space size,
which default value is 512.

Update channel register base address caluator method by use ch_space_sze
and remove unused dw_hdma_v0_ch, dw_hdma_v0_regs.

You can rephrase.

>
> Signed-off-by: Devendra K Verma <devverma@amd.com>
> ---
>  drivers/dma/dw-edma/dw-edma-pcie.c       |  4 ++++
>  drivers/dma/dw-edma/dw-hdma-v0-core.c    | 23 ++++++++++++++---------
>  drivers/dma/dw-edma/dw-hdma-v0-debugfs.c | 17 ++++++-----------
>  drivers/dma/dw-edma/dw-hdma-v0-regs.h    | 10 ----------
>  include/linux/dma/edma.h                 |  1 +
>  5 files changed, 25 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 6295d01ba2f7..ca2a4be2f3a5 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -113,6 +113,7 @@ static const struct dw_edma_pcie_data snps_edda_data = {
>  	.irqs				= 1,
>  	.wr_ch_cnt			= 2,
>  	.rd_ch_cnt			= 2,
> +	.ch_sep_sz			= 256,
>  };
>
>  static const struct dw_edma_pcie_data xilinx_mdb_data = {
> @@ -126,6 +127,7 @@ static const struct dw_edma_pcie_data xilinx_mdb_data = {
>  	.irqs				= 1,
>  	.wr_ch_cnt			= 8,
>  	.rd_ch_cnt			= 8,
> +	.ch_sep_sz			= 256,
>  };
>
>  static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
> @@ -139,6 +141,7 @@ static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
>  	.irqs				= 1,
>  	.wr_ch_cnt			= 8,
>  	.rd_ch_cnt			= 8,
> +	.ch_sep_sz			= 512,
>  };
>
>  static void dw_edma_set_chan_region_offset(struct dw_edma_pcie_data *pdata,
> @@ -443,6 +446,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	chip->nr_irqs = nr_irqs;
>  	chip->ops = &dw_edma_pcie_plat_ops;
>  	chip->cfg_non_ll = non_ll;
> +	chip->ch_sep_sz = vsec_data->ch_sep_sz;


This blocks PCI endpoint DMA, this driver is not only used by this.
EPC controller will not set this value, so ch_sep_sz will be 0 for EPC
controller.

Frank

>
>  	chip->ll_wr_cnt = vsec_data->wr_ch_cnt;
>  	chip->ll_rd_cnt = vsec_data->rd_ch_cnt;
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index 632abb8b481c..3f27a93c4d8c 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -23,18 +23,23 @@ enum dw_hdma_control {
>  	DW_HDMA_V0_LLE					= BIT(9),
>  };
>
> -static inline struct dw_hdma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
> -{
> -	return dw->chip->reg_base;
> -}
> -
>  static inline struct dw_hdma_v0_ch_regs __iomem *
>  __dw_ch_regs(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch)
>  {
> -	if (dir == EDMA_DIR_WRITE)
> -		return &(__dw_regs(dw)->ch[ch].wr);
> -	else
> -		return &(__dw_regs(dw)->ch[ch].rd);
> +	u32 ch_base;
> +
> +	/*
> +	 * For Write, the channel register index starts at
> +	 * wr_base(ch_idx) = (2 * ch_idx) * ch_sep_sz
> +	 *
> +	 * For Read channel,
> +	 * rd_base(ch_idx) = (2 * ch_idx + 1) * ch_sep_sz
> +	 */
> +	ch_base = 2 * ch;
> +	if (dir == EDMA_DIR_READ)
> +		ch_base += 1;
> +
> +	return dw->chip->reg_base + (ch_base * dw->chip->ch_sep_sz);
>  }
>
>  #define SET_CH_32(dw, dir, ch, name, value) \
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
> index dcdc57fe976c..33128685bbd9 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
> @@ -13,22 +13,17 @@
>  #include "dw-hdma-v0-regs.h"
>  #include "dw-edma-core.h"
>
> -#define REGS_ADDR(dw, name)						       \
> -	({								       \
> -		struct dw_hdma_v0_regs __iomem *__regs = (dw)->chip->reg_base; \
> -									       \
> -		(void __iomem *)&__regs->name;				       \
> -	})
> -
>  #define REGS_CH_ADDR(dw, name, _dir, _ch)				       \
>  	({								       \
> -		struct dw_hdma_v0_ch_regs __iomem *__ch_regs;		       \
> +		struct dw_hdma_v0_ch_regs __iomem *__ch_regs;                  \
> +		off_t __off = (dw)->chip->ch_sep_sz;			       \
>  									       \
> -		if (_dir == EDMA_DIR_READ)				       \
> -			__ch_regs = REGS_ADDR(dw, ch[_ch].rd);		       \
> +		if ((_dir) == EDMA_DIR_READ)				       \
> +			__off *= (2 * (_ch) + 1);			       \
>  		else							       \
> -			__ch_regs = REGS_ADDR(dw, ch[_ch].wr);		       \
> +			__off *= (2 * (_ch));				       \
>  									       \
> +		__ch_regs = ((dw)->chip->reg_base + __off);		       \
>  		(void __iomem *)&__ch_regs->name;			       \
>  	})
>
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> index 7759ba9b4850..2475b8d96133 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> @@ -84,16 +84,6 @@ struct dw_hdma_v0_ch_regs {
>  		};
>  	} msi_abort;
>  	u32 msi_msgdata;			/* 0x00a8 */
> -	u32 padding_2[21];			/* 0x00ac..0x00fc */
> -} __packed;
> -
> -struct dw_hdma_v0_ch {
> -	struct dw_hdma_v0_ch_regs wr;		/* 0x0000 */
> -	struct dw_hdma_v0_ch_regs rd;		/* 0x0100 */
> -} __packed;
> -
> -struct dw_hdma_v0_regs {
> -	struct dw_hdma_v0_ch ch[HDMA_V0_MAX_NR_CH];	/* 0x0000..0x0fa8 */
>  } __packed;
>
>  struct dw_hdma_v0_lli {
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index 1fafd5b0e315..a6c5728f03d3 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -104,6 +104,7 @@ struct dw_edma_chip {
>
>  	struct dw_edma		*dw;
>  	bool			cfg_non_ll;
> +	u32			ch_sep_sz;
>  };
>
>  /* Export to the platform drivers */
> --
> 2.43.0
>
