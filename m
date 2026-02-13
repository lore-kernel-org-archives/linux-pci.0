Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013044.outbound.protection.outlook.com [40.107.159.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72F6187346;
	Fri, 13 Feb 2026 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770996767; cv=fail; b=qsZELOsopFHJYDpWT7+8YqQ7JMEmwZRs1vo54MymCpwhEh0vtiHi2uM/DCXitoS4rjZHd6yp4UyV5nqEDerP3PEnM6mO/R+/PEoxZmv9kyy3UE60v8FOnhj+x+wWvz1IM/ve3qE3qyAXsJsmfGYF4EJ1bmWmh0ySXJXsOpauTp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770996767; c=relaxed/simple;
	bh=2QPvqLUalfNGFsZ3mjDho6+5SZm5p4jJVKQjnUON8Sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CXZ70x4UInqWh3IN1QW0uf/mlM5J9V9jUrDz16cmRD8OSvMbpMBemnX1SRKj39fEXzg8lYf5KkDLlFU2vRv6OABHjNoU8b8QhHW3alXsxCWlGp8PJK9nyQEBO9lhazVfRn2cCN9l9tTVOb1r7g+v3xjUnOXKOQ0nbz+wTWdByYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AsnhDBox; arc=fail smtp.client-ip=40.107.159.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AsnhDBox"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=StNtTyJanPHzC1G+w0U/G4NsOVzqMqZzjybIhzCp7W5xTPxdf1UsYFC5LAQfxs2iUmxYVmZK6PhW3l5J9WXJz7esX5euzoLY0o82UxXwluHYOnVIHLOccYs3jw0NcMvDTvZDsYmxhrv1JGNnJC37HW0BfXHZqiO/XvvOCeFV6pX6BGPkNMlAavmcSsOG9qcksmT7Z8NVucQ3tUeglW1bI0TAv+1F70+hDWWXYeTaVgeVf5Y5gQ96+ZrUT1z+1zhKkFAJhMVyQqNG8MlNbhB+gASVIhzneC/jZYZI3b3Hr8yDliTSE/JaPJD2yfwkBvlYRVGZI9xN+UkNDgytXgw8fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwOAfyTpye1FiF6MO8YUN4PsBmvrnoGb71p5mSQFpxg=;
 b=KX5gwYxPOHBy/0FDRZ6s47fQV0D6xBg9XJLqZx6w/VICs5DsmT0ABRZfVjwv4hzlJM7yOfSKZl/T18I4rW7h5y7zcace+I02OMUtc5SltLaCEXpRr88JJJJgnpKB4bYrUkKCvd73LWHSSirAe+xaDUCBKkAzcUKykqCOYQFw1gzHCT8x3jnrRUUfgU3fnJQaYMWttnX6+3fT7byQwuwuXt6RIFZPEYpgGg0ljT2RMju6iJfgh3oVKOJF1X/0s4mkD7dBF4liXpb2X+1QB2yvNcP9teDOky9/wqnWQjk0NRHZfpHBdHcWJCuYnf2dETAP4rHb+n5AUr5hZtEmp5cqNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwOAfyTpye1FiF6MO8YUN4PsBmvrnoGb71p5mSQFpxg=;
 b=AsnhDBoxLTSwDaoVBtOwQQYHTFUCQozhNR2srylCkLhRyM9+DEvPUxVcH76zr1pZAk0K1m/C0ZmfWL6rssPkmXzEwuK6dH85f+BUnFhTiSYtJz95lZ21L04zSdHiNpmjpG2DL17RVg8JrnOFGaQblPksRKp1fXW4KtN4RI0mImQXEA8/PuiZ6PnMumu5mb4BgaSEuUdxF+ynes6rHQ6qWg71cmIplO2hziPIGeEJO60ldYHCj102IwyoGdnDsHpt61vJHZSUylnFvWmEMKecJxgXsKSlkWFEGAclT/VGveojytK52DMOZOT/LnIQgboSaasEXIuLc8czuJYIg2dhbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DB9PR04MB8218.eurprd04.prod.outlook.com (2603:10a6:10:24a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Fri, 13 Feb
 2026 15:32:42 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 15:32:41 +0000
Date: Fri, 13 Feb 2026 10:32:33 -0500
From: Frank Li <Frank.li@nxp.com>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: hongxing.zhu@nxp.com, l.stach@pengutronix.de, bhelgaas@google.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	s.hauer@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev,
	kernel@pengutronix.de, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 04/12] PCI: imx6: Add support for parsing the reset
 property in new Root Port binding
Message-ID: <aY9EESNDhZ5ZvtL0@lizhi-Precision-Tower-5810>
References: <20260213040852.3340547-1-sherry.sun@nxp.com>
 <20260213040852.3340547-5-sherry.sun@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213040852.3340547-5-sherry.sun@nxp.com>
X-ClientProxiedBy: PH0PR07CA0072.namprd07.prod.outlook.com
 (2603:10b6:510:f::17) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DB9PR04MB8218:EE_
X-MS-Office365-Filtering-Correlation-Id: 62bcf291-bfca-499c-d243-08de6b15207b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aMw6AXgGwPYNE733RFWDS0ZBnZYNMQB1JQg7S7cjLphoTzkfQZCEOmg9YFpD?=
 =?us-ascii?Q?kVKwXk5gbPrgYOjMEP6cLwEbKPtyGPLsSO2tkxg7iD3uV4ib+FgXCB40RDd/?=
 =?us-ascii?Q?1to4IMgdyFS5HM9W9hceLTgEyc+DL+04eX2R82dOPYO5UcE+YWj1k6VEuNwx?=
 =?us-ascii?Q?sEHvJRGh1/B9igP9uNZDotnA372Bkb3gNfxYYSHbe5j0TpI6E6C+TtG2gOEy?=
 =?us-ascii?Q?cVlNM6paYKzuL/RHJ3cEgtj95A/2qpTGkS5WztIRQftjfVN7tWqpz4HBGXky?=
 =?us-ascii?Q?9/GG2kLKImeiqj9gXMZh5NEUtunSfv4LJegQMOH8x0Q87wEriPfWYXbfakmH?=
 =?us-ascii?Q?98uXOFaOYd9ZNQxuALRkMFaaqFwrtoM8kdi9UIT/qHxLUfjg41T18mp38jPf?=
 =?us-ascii?Q?deAU/b0XyXHTKqD7LJTdPGR7bzeI7oZWygyO1eBW3x7tWP0lzg8hKFkMP3Nz?=
 =?us-ascii?Q?jTuYL3le1AVui42tKOYhStRx2pzOI0irFSpOHwjtmdQL2TliUTrKHGHa2qYe?=
 =?us-ascii?Q?Lf8d6ZtDCs8SkfyGxdHltgJjvOlb33vr21c2ePvABIk8l4e4BnATzEz2qM0n?=
 =?us-ascii?Q?WLOky38J5SMi+3XCjGZfkhikboG8jhMpQoorFxQ03CZF26f5p2fOgIy4FKTP?=
 =?us-ascii?Q?O6iL5jjwGqprKYiI2uAsyt2TbHFYV3OzbkyuGiv8euoArxOCP1TwFFRGCyG2?=
 =?us-ascii?Q?WGZQyAFLCKGzdVkzLuLQIaILrTfZvFw6wvJHa5I30Pf/kxAFWkCaPADdeQbC?=
 =?us-ascii?Q?mJZwgjFYleymtsvmS+JqyArdaKd/0eivRK0Z2JBowe+1jZ3nR4LNuIcyQSmu?=
 =?us-ascii?Q?GKKp8jrjvKnXCt9Bdv1BQt0rOi3aFwv1vwc9U2anIMtsV82oWTZrHF9qM6kq?=
 =?us-ascii?Q?wCO70wslUKjZcgHekBzxNuJQyRz9pbt4v8HL25nM82u2jmzv2BLMhvWy76Md?=
 =?us-ascii?Q?tudZzFCNstbxCwqjQrdGamgu6ZBUR3osOn9ykBXh2VZoyGlY9o1BScf34Fks?=
 =?us-ascii?Q?GYNQEyoL2MWf5II9ZLxtGUOB2TyzYbudYEz4AvxI2/CDo+zcHK8C/j27fltu?=
 =?us-ascii?Q?YjObMCdhGpaDYHagF3xnINiOIxjCke9n5m+wki4c+Kag2xeP6qZSTuFoRFzq?=
 =?us-ascii?Q?41w3qQ02HAAZW0JJ5FIdPVV27kJbeJwBE0W+OKoPgBQ9O9zN/p9y9kf1fN+V?=
 =?us-ascii?Q?5lnDuDaGKI9tMoerZfx1iN+vk3ojTmr51a7FRmYaAgB/Q8BlgwNNIuAN3LJq?=
 =?us-ascii?Q?dvMawF52sd8c3by//IajNS2fBsbVOzg5VKn45s6kTqJkEC+x2ez42fnFySev?=
 =?us-ascii?Q?N6xKlfurva6onzGumjvIxWZvBEQMOKkRsvGazBWrKs4EHOxnvpdQPZuwUqJm?=
 =?us-ascii?Q?w+27EJuI9lryyHrrq1LmFMxPteH0to1ijjcBFZX+qXOOR2Co2FfUmgySGB+d?=
 =?us-ascii?Q?LeMycq/CeNo0OZ5iNjUgzwXaoBT0ElG8QpjMlpXcF0LheOEp6/fBcjG2Ex4d?=
 =?us-ascii?Q?nEsL/NHRQU6IJGkIORk9hF4nr56MJ8P8CgMk786nFGCj3IseEqAhk01Ni0we?=
 =?us-ascii?Q?ZEEuiqzVGK17Kq0d3nN14bucUZOPgjfoqEqcrr+rSgD8zIowCNYfYiPGyVqR?=
 =?us-ascii?Q?GZpJKyal1fhbGY1agMhfg9Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(52116014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dsBWrEBSnlCatr8ty5vbn8Vio7p6hxaDdEjisBACQM3qldvcLMOMBw9WlShe?=
 =?us-ascii?Q?Wa6WMMfcshF2nYGO6s1AvKrCbUhO8/jgMz4Nt/ZN0HQgfd/WB+om+25hvj4e?=
 =?us-ascii?Q?7uGow4NhC1Q4mdw/09SKPiIScqa+Vh4rUy/FPJ7yS0X5VYehT4w+KO95zNYV?=
 =?us-ascii?Q?G/whFg/tEbexMCDaK7D6kZZgEoQ0OBrTvpJwOJrtuaQOfcGZlbM1wpMPlukr?=
 =?us-ascii?Q?VHQfrL1L1L+NUzkRV7fBgKNzaHxYI+nkbUtlCQFRVvwfXKRMmQ58oCBzRrSm?=
 =?us-ascii?Q?jeojY2qUcz3YIUqDv+M/FYKNX1aDWS3Z9hpxpIxjLb9a+ePOb93NZShhQom7?=
 =?us-ascii?Q?Bj5ZyI5r7zLaIMWC0Xr1gp3fVPu2nmDbqiyB2FXxxahrD12ow2QP2bxF9BSe?=
 =?us-ascii?Q?686qLPiux8oRQL6Iw+CbW8z+VACiHoxBf+6q3z9xZF9aFyLzXN+Hip84ReKP?=
 =?us-ascii?Q?yKAZ/7yRMK2IB2A7BpaMoEzlfPpx1mz+AO8hWRlEJkovjqxiwdlpCt30tKUh?=
 =?us-ascii?Q?0W4GDDJxzkxmcl8fsp82GAHFZb4kQtB+YVVbKt1Gf4vAn1NStxbGBhPAoI6a?=
 =?us-ascii?Q?mJd1IOIbnGvLi02bsNVjkXiSvvcBnQDouOq+H6Sr4p64TDScMSrpTvEw3eZo?=
 =?us-ascii?Q?/TBqoLYf5n+vjr7eFyF9zbeWl6pD2EUGi/UGr+uwsEy6sJAV9pksejfbMU7Q?=
 =?us-ascii?Q?Ro+MVymKq//xtIuOSP7MoNGJOyL6+ETf471d8UWzGfswoz2rPXhi7UI7jZyK?=
 =?us-ascii?Q?yPWLmuxZBxXdCY2iBAzNv2K4RebD9ddLiapEOXXOYPm8yk/FnmSxPRLBHrrx?=
 =?us-ascii?Q?Cc0FBgOcG2wNF2q6G29qsvxXK3GFDTzsppeCPgKbBSdYBEaO64u5Y1TaMpHS?=
 =?us-ascii?Q?NyLeJvNB5tHfUO1PR2RFG09eppZxRVcf6xuGodkjBA1tnEHOCz4jdwNS5NLN?=
 =?us-ascii?Q?DqWELkz2LUjC50ge4nwhHI0aF8duTgizqL9wF5Z8TWl/Kq4vwjNQNiBA3NWo?=
 =?us-ascii?Q?e6mkawR9iiDh0mKRaEoGGGb91OtEZKrmcbxLIpfee8x9eAXIkFQ0S2tBce5h?=
 =?us-ascii?Q?YKsI1xx5AEni+arL8UWmKuh+joBVIXlv4mxKoYQQc4KgqFpBzUJM4hC9Fgom?=
 =?us-ascii?Q?5/7WXYRRK67bMQbudwfj9fRhZkX3few4vvTBtPZsHYkQxm3mUsFd05pyzoUJ?=
 =?us-ascii?Q?kclu6Gtp/a374QNJbVQq/QSlOKPr4s46rGUZmmw6VruGwq08NgYQujPVT/gh?=
 =?us-ascii?Q?dLpEL1bvG8hYgfEv7nItLkH0wPJcd9QKgLq8K+i1DRZOaIMxzBlVqW2t5y+M?=
 =?us-ascii?Q?+8sEuEWjwIhARovsmOJBGLERjHQiI81iaX87jx9EREhbljRIGAF/9V/43MdZ?=
 =?us-ascii?Q?xJzqu0Zw5uilhWGZm4IfhZWUYz8F8dznb+eMU05A3NwBq6al/4LWudBTL69v?=
 =?us-ascii?Q?9PAwLGPoc9AamcW67NNna6+wss0PS0xihS2EVtFB3jPcZaDXfKxkWc92maP7?=
 =?us-ascii?Q?eOhxvyk43pHnHZxqlkz87I/idc2R4E8lj2dS7gYlHVbYiM+UFak7fSYfSMqB?=
 =?us-ascii?Q?lNiajQkv+TQF1gg9iydNDTX3Es1kTgHea7JvlB7/OBH8TKRKPP4KfbfLZXHH?=
 =?us-ascii?Q?RtRuCZdGwSe3O6Qh8Q36vWBiFwWPRxbAMaK8pHPiWziHUKXDaopcocYqMfYd?=
 =?us-ascii?Q?jFqfcP7mNGwVYrweFNwbwuLXaWP7q82KLWHsltIiqNYa5vMc73EyiSqyURLP?=
 =?us-ascii?Q?ouCVxULIkA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62bcf291-bfca-499c-d243-08de6b15207b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 15:32:41.8018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pI4JsNbXlI2ElCpm6hU8NR9BKwbK1zhkitwyyKbCq24bhEUCtPcTatWzxeb6ynGDG1/wIvs6A4Ru9RdJYO1Q/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8218

On Fri, Feb 13, 2026 at 12:08:44PM +0800, Sherry Sun wrote:
> The current DT binding for pci-imx6 specifies the 'reset-gpios' property
> in the host bridge node. However, the PERST# signal logically belongs to
> individual Root Ports rather than the host bridge itself. This becomes
> important when supporting PCIe KeyE connector and PCI power control
> framework for pci-imx6 driver, which requires properties to be specified
> in Root Port nodes.
>
> Add support for parsing 'reset-gpios' from Root Port child nodes using
> the common helper pci_host_common_parse_ports(). The parsed reset GPIOs
> are stored in the bridge's ports list and accessed during core reset
> operations. Pre-allocate pci_host_bridge in imx_pcie_probe() for RC mode
> to enable early Root Port parsing.
>
> To maintain DT backwards compatibility, fallback to the legacy method of
> parsing the host bridge node if the reset property is not present in the
> Root Port node.
>
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 81 ++++++++++++++++++++++-----
>  1 file changed, 67 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index a5b8d0b71677..75afd56dad50 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -34,6 +34,7 @@
>  #include <linux/pm_runtime.h>
>
>  #include "../../pci.h"
> +#include "../pci-host-common.h"
>  #include "pcie-designware.h"
>
>  #define IMX8MQ_GPR_PCIE_REF_USE_PAD		BIT(9)
> @@ -150,7 +151,6 @@ struct imx_lut_data {
>
>  struct imx_pcie {
>  	struct dw_pcie		*pci;
> -	struct gpio_desc	*reset_gpiod;
>  	struct clk_bulk_data	*clks;
>  	int			num_clks;
>  	bool			supports_clkreq;
> @@ -897,29 +897,40 @@ static int imx95_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
>
>  static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
>  {
> +	struct dw_pcie *pci = imx_pcie->pci;
> +	struct pci_host_bridge *bridge = pci->pp.bridge;
> +	struct pci_host_port *port;
> +
>  	reset_control_assert(imx_pcie->pciephy_reset);
>
>  	if (imx_pcie->drvdata->core_reset)
>  		imx_pcie->drvdata->core_reset(imx_pcie, true);
>
>  	/* Some boards don't have PCIe reset GPIO. */
> -	gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 1);
> +	if (bridge)
> +		list_for_each_entry(port, &bridge->ports, list)
> +			gpiod_set_value_cansleep(port->reset, 1);
>  }
>
>  static int imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
>  {
> +	struct dw_pcie *pci = imx_pcie->pci;
> +	struct pci_host_bridge *bridge = pci->pp.bridge;
> +	struct pci_host_port *port;
> +
>  	reset_control_deassert(imx_pcie->pciephy_reset);
>
>  	if (imx_pcie->drvdata->core_reset)
>  		imx_pcie->drvdata->core_reset(imx_pcie, false);
>
>  	/* Some boards don't have PCIe reset GPIO. */
> -	if (imx_pcie->reset_gpiod) {
> -		msleep(100);
> -		gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 0);
> -		/* Wait for 100ms after PERST# deassertion (PCIe r5.0, 6.6.1) */
> -		msleep(100);
> -	}
> +	if (bridge)
> +		list_for_each_entry(port, &bridge->ports, list)
> +			if (port->reset) {
> +				msleep(PCIE_T_PVPERL_MS);
> +				gpiod_set_value_cansleep(port->reset, 0);
> +				msleep(PCIE_RESET_CONFIG_WAIT_MS);
> +			}
>
>  	return 0;
>  }
> @@ -1642,11 +1653,39 @@ static const struct dev_pm_ops imx_pcie_pm_ops = {
>  				  imx_pcie_resume_noirq)
>  };
>
> +static int imx_pcie_parse_legacy_binding(struct imx_pcie *pcie)
> +{
> +	struct device *dev = pcie->pci->dev;
> +	struct pci_host_bridge *bridge = pcie->pci->pp.bridge;
> +	struct pci_host_port *port;
> +	struct gpio_desc *reset;
> +
> +	if (!bridge) {
> +		dev_err(dev, "Bridge not allocated yet\n");
> +		return -EINVAL;
> +	}
> +
> +	reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(reset))
> +		return PTR_ERR(reset);
> +
> +	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> +	if (!port)
> +		return -ENOMEM;
> +
> +	port->reset = reset;
> +	INIT_LIST_HEAD(&port->list);
> +	list_add_tail(&port->list, &bridge->ports);
> +
> +	return 0;
> +}
> +
>  static int imx_pcie_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct dw_pcie *pci;
>  	struct imx_pcie *imx_pcie;
> +	struct pci_host_bridge *bridge;
>  	struct device_node *np;
>  	struct device_node *node = dev->of_node;
>  	int i, ret, domain;
> @@ -1688,12 +1727,26 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  			return PTR_ERR(imx_pcie->phy_base);
>  	}
>
> -	/* Fetch GPIOs */
> -	imx_pcie->reset_gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> -	if (IS_ERR(imx_pcie->reset_gpiod))
> -		return dev_err_probe(dev, PTR_ERR(imx_pcie->reset_gpiod),
> -				     "unable to get reset gpio\n");
> -	gpiod_set_consumer_name(imx_pcie->reset_gpiod, "PCIe reset");
> +	/* For RC mode, allocate bridge early so we can parse Root Ports. */
> +	if (imx_pcie->drvdata->mode != DW_PCIE_EP_TYPE) {
> +		bridge = devm_pci_alloc_host_bridge(dev, 0);
> +		if (!bridge)
> +			return -ENOMEM;
> +
> +		pci->pp.bridge = bridge;
> +
> +		/* Parse Root Port nodes */
> +		ret = pci_host_common_parse_ports(bridge);
> +		if (ret) {
> +			if (ret != -ENOENT)
> +				return dev_err_probe(dev, ret, "Failed to parse Root Port\n");
> +
> +			/* Fallback to legacy binding for DT backwards compatibility */
> +			ret = imx_pcie_parse_legacy_binding(imx_pcie);
> +			if (ret)
> +				return dev_err_probe(dev, ret, "Unable to get reset gpio\n");
> +		}
> +	}

if parse in dwc or in devm_pci_alloc_host_bridge(), needn't these code
here.

Frank
>
>  	/* Fetch clocks */
>  	imx_pcie->num_clks = devm_clk_bulk_get_all(dev, &imx_pcie->clks);
> --
> 2.37.1
>
