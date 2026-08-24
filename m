Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011032.outbound.protection.outlook.com [52.101.65.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529A143E06C;
	Mon, 24 Aug 2026 14:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582581; cv=fail; b=Z/4Jxam6nIZCQYr9dnf9KEEpZXwEgQakclJWZpE2BLQ5k39q9Q7yQkizbkxkH3qpHxQO6vUJTtxwf9VbBWiAQlffrCpxwwO1J7YHBHLUB7S+KudX0znRh4MLFOm9lvko+5aK0vYu+zVM9d06kJnfUFs55eht4d4CUFRMSqYy89E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582581; c=relaxed/simple;
	bh=ZPqt+5Teifi0fMdFIi5ruhZkHaYDLdNkE30FdBXlCY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I7vOodZ+5SieFrr1/srVALq6Jm/w5NeH3oSqgnlUt/IVMiNBNSfAs+v+i/i9j7joY1pLS76Y/C1BY5U2NKR0OajbE56m1xYxgMLgNwUntH0f237WO6kG6ECgQUnz7IOlXmMRkXLmctYAQMoo7inYK5o3R4GmvEVbdUMjbvgO4ZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=rcb0HRKI; arc=fail smtp.client-ip=52.101.65.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rcb0HRKI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ym5DBhf4ps6GNqMUV5TNuIRijnhh3225Hc+mZzhMqNjCriyN4gN580dVk3tIKKWVg/dXHJEGysYpjRIg22xiHvEAjuzzU+lq/a/aqUQ3J+v06uPLMeWi/MbtD+5GH3CtSICKhccMJrTBGbKUBv25VPc1c+IHPAKihJlBKsakGjNqPTE+rK1zNyRnq54SCEP9rOcoAF0uSSEofGI7Y+NW5KG5jKRnfCBXr0bmsUze8RUUqqmK5/CI6tqC+mJZPVTw4XkAfxEGfIisjW+3hheu0E7bqKdVQrQPIfzNQ6eImsFRVBME9chNn5xOH3vx07OPfDY2B6tqWjXFweejRMy6Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NjmnLV5qB77Tsj6doZm6DEwgkKdO+sEKD32VcXcqX8=;
 b=tDFG+Z+dHM0AwMg9QcQbkFt0G/yWk9kmY/3LVkLMrJ98xbnM4gziqlnJI5CYlL5Z3vDGSQ3I29nQyKjrjZ90HA1qXn9cHFzb1qJxHC1DnwJlti22yyD0Gl6Xs3kA7Jpm2Hb48cvryixz/iFRg1BKlgcpNF+IBuzVrzPNgOsu94mk7lrok9XxhTD0d6PmZTyDLL+Dvkr98TNh4C+32y2WhD2Swplt5P6PePeiRN7DNVGTL8LhGSqiMpTuTHaESBKDYGwYZdi4dyAyWXI/AP+0DKfNo2LVSMR0a2AZY+sarAPSL8sKTdu2U7yJYfDxgNJ/Ou9eB1hDySXktR3CA1PQmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NjmnLV5qB77Tsj6doZm6DEwgkKdO+sEKD32VcXcqX8=;
 b=rcb0HRKI2W935bTqYndxh5Hp+HsQR5Bi2soE0LZV8jJdJAhixNI0NvNH2gnGQ4vXRojEWENpWRTSHPGo4IFM8dWTK67sx5dfAUQMD/CYMXvFDF/gAWd8+66UIe1GGAmEzJg+Gqi5v8hcCw5b9UDytjUiC5d3dl7bIKuTmI1DUAyfYyXRqiOXieWj4MvaxoDv/KsVb5CNOQBl0DQa+ybhJJrRpoM7wLOnudz/XthQIukF7hBYWyOeeIdEgqh6F6K4Hyw+L+Z739RDev42gtML6Gq09Dg3xo/+7Z7dUn+nF+P1OYGWU2FQLT8hE66STTT0ONwfOPeh/Ey29f3Wi6/vhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB9PR04MB9475.eurprd04.prod.outlook.com (2603:10a6:10:367::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 14:42:50 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 14:42:49 +0000
Date: Mon, 24 Aug 2026 09:42:39 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: hanzhijian <hanzhijian1991@gmail.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI: imx6: fix resource leaks in probe error paths
Message-ID: <aoxYX03-mFUVZN_g@SMW015318>
References: <20260823071129.2980059-1-hanzhijian1991@gmail.com>
 <20260824075512.3386898-1-hanzhijian1991@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824075512.3386898-1-hanzhijian1991@gmail.com>
X-ClientProxiedBy: PH8P221CA0063.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::15) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB9PR04MB9475:EE_
X-MS-Office365-Filtering-Correlation-Id: 10d61ca0-44be-4ffc-dd26-08df01edf85b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|23010399003|7416014|376014|22082099003|18002099003|11063799006|5023799004|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	iIE3Vh4sYzLGmV+pq+aePr9CyAwD3JedJMwPeD8tnSNQihmRn/7Se96RNVV/Zm0VoT3R4r2aFhpJz1N0itGSlUDJCNYzT6A1xZ7v1FL6S8cek9M6BcWcEfng7P3tPFdCioWTNtZUIZkxDJphcMlzZli0vzFqOVKO5oIEFepg5+LHYn/kpevOQSrijuRr19/45llPKo1mJP0s+MvllhX0kwsu5Mly0gsMc29dQDHR+Xmc7F80g5rIuw+7fEsuESBKOdHbd1mBF0SYwaFY8qpf0g227d9yA7NCgHcIUfu2m1c89Yuj4BZ7H0mP4KpAc9UE66j5NkSa9pE6JEjOw9tCA4u3iAyGYH6hJj9phDaaFdm1xiXIKL18Quh1G2fv+nASXtQpiuf6KbRcLp+ILcWKdCPJNcfo5Ea4lApSiNasBh/sjZnZWHXzCHlQrvt8gM+sfFzE1XF99fxsqAUuYOzMjFnNcO1zhgwFNmv5LS5DKhkvnPWuqFz8BW2pdfmTeo/E/U4qmgm+VBLoFO+DnnQsjPezqjrcQkcpLY8Y7TQRTCRPbC+NdC3xb/iu77Za5SZLNQ3S9LLzJ4GFccCxthwILKPRRCdcWfie30s+cqtsB727t5YY89Et+Qukgc4qDWaZyO8Etk1TkRHE5ncW5tDeMW35GN1mEdMeiG3LHaAIF+0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(23010399003)(7416014)(376014)(22082099003)(18002099003)(11063799006)(5023799004)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6SKqdqmKEWPuxcJZglbmuBtbZ1PbsVoM/9EFTtlUge1fh6BtxNII7536x2ko?=
 =?us-ascii?Q?hRtX502xxp29VukPwEV+vDR7ZhQt/ALQXLhMCbjx4baNZzdfEzBpPUqLQ8Vi?=
 =?us-ascii?Q?3lp9vB/Snb1NjfLcpk7Y35bUD2tuf9vuHb+KMB4bLl0M60CIbnqJBpPZIyNd?=
 =?us-ascii?Q?d6EunFi82U3HQkjJi0c9eiBGnsX83cotmlC29z/ErQ37DPbn8Zq2DV0jeX1x?=
 =?us-ascii?Q?VufgSzy2EKNFq3pLouT2uQKoOzsuo1rn4+wHP4QfQ6EDOzrpkQEuyeaYV0en?=
 =?us-ascii?Q?TxUvsp4OBWKmbzDhjw9R/6BTPqgJXr8zTMQDWXjoF5AFhtblrCd9IpdiH8L5?=
 =?us-ascii?Q?o/a2172XRsqoZwlj4i7mGCnpXuQvSOnC83mrHoi23nNM9nUiyiGaP/AgntoB?=
 =?us-ascii?Q?oo0BZ6J4Ae9cXydCl0UZBCetsf2+ksRTsSILr+KhMPUPKMccTk43NezKZSvc?=
 =?us-ascii?Q?wW8DbyGdoPieLBF8T8Rwul37NcLHM9zNsROm/4RREWJm1dXWjNeZYb5USJHX?=
 =?us-ascii?Q?0IClvDpNMZI0L7eZIxAMp6Qy1Utos8AVtnBaCmPNc7U6J2K1cIse0fts+Rms?=
 =?us-ascii?Q?4rFDEgYXjywxYU0RKMcB3IWrfjveKZn2H0ikdiZ2Ue8Pl3JlSwl4o1NDv2zV?=
 =?us-ascii?Q?TB07tJTYWPdVMoVu8aQ6qlCJLk8a8lJHEhmKn2G9u10AB+pds81htjD9WXyd?=
 =?us-ascii?Q?TEdvL+UCkmiFu8X7skJDLb7xRnkKy09l6jKg28G1zFKVCyBUh0sxJlAfpYEI?=
 =?us-ascii?Q?mrGsVTt8b14RFB36Ac+IsBRkEjwfqb+V1/Ss4nafpbrw4NcD1yGEngrVF+ku?=
 =?us-ascii?Q?de9tT5UfNY+hkforqcMf/cgsPks7xrbRDbUsXAXVBJvJ+Kxirr0Pso/yxp4O?=
 =?us-ascii?Q?rf36IM2rKBpKo9LX2lJTrugRXE8rSkDsUJWioWS/cODjIx8pUMZ6leqFJi0v?=
 =?us-ascii?Q?IPd8yVmWDK9G1I0DMz7i1kLl0df+YUqPUT/U0+RBoQpdoGyLn3FKl4PjX0sp?=
 =?us-ascii?Q?oOsA8ym7OIffAu4aiFL7z3mXhV0Wq01/yWMrOHXRrx8BazavwItwsJmOEUDN?=
 =?us-ascii?Q?dIAjv/p0OH5/di70YZe1Ie9DJJvRpq+C39kgsZ9FzbyRA6hvniJYLe/nFwj0?=
 =?us-ascii?Q?HRIlp82OE+NFG0jMtf92h8npPi8s3Xna1m/JEfEbXvx/PIeJJlNEFdpCdrIP?=
 =?us-ascii?Q?zbPa6iMxc9Am72T0ohj2iv9PP9AyaUrM9ZRrndkrCRqNstwKQ1RFA07dA4gw?=
 =?us-ascii?Q?aOlBnsxFL3EYFWQUOLTX8mwPGlk3NOF5pKoka4QkT5E60Igojy1d1vRSIBUU?=
 =?us-ascii?Q?bABvm4bF5koVXNZytUXLJ99xupkfcp+HXMmCx8Ude2hrBox/H9XxSrNaTVcI?=
 =?us-ascii?Q?YwHWCF0D5DJpg1xoWS7M5v3w6kRASZ8RdmhyUY292dU1wORfsvcW63baLkrc?=
 =?us-ascii?Q?fuVU8Za81z6ut2KgK90Ej34yiG02WMETKl/Fx6nNy+GLKftoaPA8jto+Q4Sc?=
 =?us-ascii?Q?sLhWns47H/nrz4bfuPZToRRzuIBuKRY4h6dxVJA5g5MBsU+wx+vByJVZFwJT?=
 =?us-ascii?Q?yxCV+12eK7r6zOvZsMPGy0RR57x0Vx5QSpdn4PBACvwOao3bPuuQC3nz5SEs?=
 =?us-ascii?Q?APeH10tbY5uf4nhPwC82bghmiEwEiEFQD7aFOv3oLu5iPxiJuCcYx+DUxXmE?=
 =?us-ascii?Q?O4h7ksDjsghklCYrg75Ot5/PUJ3wBHYgHDIEjvx0UTgJfIxXTN2SqILb9v8z?=
 =?us-ascii?Q?I6XwZMZGWRbNm6yrX0hwmWuicdvYCFvBLrBKi5B9lA43CcXLE+aw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d61ca0-44be-4ffc-dd26-08df01edf85b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 14:42:49.8068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rdYAH5u0c2gbB5g0+9q0yJWdKZclpTEvQWbOoy2neHIylgD/pEaHCuqHklMPqxDntsQ688hFCxdkhYqC8LT1x3+hMF1SwoCdxIF25Jh8a7T4iCDcB07/W3yvc+Jj+d2R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9475

On Mon, Aug 24, 2026 at 03:55:12PM +0800, hanzhijian wrote:

Don't post new version patch at old thread.

>
> imx_pcie_probe() leaks both pwrctrl devices and power domains on
> failure:
>
> - imx_pcie_attach_pd() attaches the "pcie" and "pcie_phy" power domains
>   and creates device links to them, but the device links are only kept
>   in a local variable and nothing detaches the domains on probe failure
>   or deferral, so all of them leak.
>
> - A failure of devm_pm_runtime_set_active_enabled() returns directly
>   without destroying the pwrctrl devices.
>
> - A partial failure inside imx_pcie_attach_pd() leaks the power domains
>   and device links that were already attached.
>
> Save the device links, add imx_pcie_detach_pd() to release the power
> domains and device links in reverse order of acquisition, call it from
> the probe error paths, and make imx_pcie_attach_pd() release everything
> it has attached so far on failure.
>
> Reported-by: sashiko-bot@kernel.org
> Link: https://lore.kernel.org/all/20260822013640.182C01F000E9@smtp.kernel.org/
> Signed-off-by: hanzhijian <hanzhijian1991@gmail.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 42 ++++++++++++++++++++++++---
>  1 file changed, 38 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 39790e66b..467006d83 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -182,6 +182,9 @@ struct imx_pcie {
>         struct device           *pd_pcie;
>         /* power domain for pcie phy */
>         struct device           *pd_pcie_phy;
> +       /* device links for the power domains */
> +       struct device_link      *pd_link;
> +       struct device_link      *pd_phy_link;
>         struct phy              *phy;
>         const struct imx_pcie_drvdata *drvdata;
>
> @@ -639,6 +642,26 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
>  }
>  #endif
>
> +static void imx_pcie_detach_pd(struct imx_pcie *imx_pcie)
> +{
> +       if (imx_pcie->pd_phy_link) {
> +               device_link_del(imx_pcie->pd_phy_link);
> +               imx_pcie->pd_phy_link = NULL;
> +       }
> +       if (!IS_ERR_OR_NULL(imx_pcie->pd_pcie_phy)) {
> +               dev_pm_domain_detach(imx_pcie->pd_pcie_phy, true);
> +               imx_pcie->pd_pcie_phy = NULL;
> +       }
> +       if (imx_pcie->pd_link) {
> +               device_link_del(imx_pcie->pd_link);
> +               imx_pcie->pd_link = NULL;
> +       }
> +       if (!IS_ERR_OR_NULL(imx_pcie->pd_pcie)) {
> +               dev_pm_domain_detach(imx_pcie->pd_pcie, true);
> +               imx_pcie->pd_pcie = NULL;
> +       }
> +}
> +
>  static int imx_pcie_attach_pd(struct device *dev)
>  {
>         struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
> @@ -660,12 +683,18 @@ static int imx_pcie_attach_pd(struct device *dev)
>                         DL_FLAG_RPM_ACTIVE);
>         if (!link) {
>                 dev_err(dev, "Failed to add device_link to pcie pd\n");
> +               imx_pcie_detach_pd(imx_pcie);
>                 return -EINVAL;
>         }
> +       imx_pcie->pd_link = link;
>
>         imx_pcie->pd_pcie_phy = dev_pm_domain_attach_by_name(dev, "pcie_phy");
> -       if (IS_ERR(imx_pcie->pd_pcie_phy))
> -               return PTR_ERR(imx_pcie->pd_pcie_phy);
> +       if (IS_ERR(imx_pcie->pd_pcie_phy)) {
> +               int ret = PTR_ERR(imx_pcie->pd_pcie_phy);
> +
> +               imx_pcie_detach_pd(imx_pcie);
> +               return ret;
> +       }
>
>         link = device_link_add(dev, imx_pcie->pd_pcie_phy,
>                         DL_FLAG_STATELESS |

Does DL_FLAG_AUTOREMOVE_CONSUMER work?

Frank

> @@ -673,8 +702,10 @@ static int imx_pcie_attach_pd(struct device *dev)
>                         DL_FLAG_RPM_ACTIVE);
>         if (!link) {
>                 dev_err(dev, "Failed to add device_link to pcie_phy pd\n");
> +               imx_pcie_detach_pd(imx_pcie);
>                 return -EINVAL;
>         }
> +       imx_pcie->pd_phy_link = link;
>
>         return 0;
>  }
> @@ -1956,8 +1987,10 @@ static int imx_pcie_probe(struct platform_device *pdev)
>                 return ret;
>
>         ret = pci_pwrctrl_create_devices(dev);
> -       if (ret)
> +       if (ret) {
> +               imx_pcie_detach_pd(imx_pcie);
>                 return dev_err_probe(dev, ret, "failed to create pwrctrl devices\n");
> +       }
>
>         pci->use_parent_dt_ranges = true;
>         if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE) {
> @@ -1975,7 +2008,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
>                         pm_runtime_no_callbacks(dev);
>                         ret = devm_pm_runtime_set_active_enabled(dev);
>                         if (ret < 0)
> -                               return ret;
> +                               goto err_pwrctrl_destroy;
>                 }
>
>                 if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_SKIP_L23_READY))
> @@ -2001,6 +2034,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  err_pwrctrl_destroy:
>         if (ret != -EPROBE_DEFER)
>                 pci_pwrctrl_destroy_devices(dev);
> +       imx_pcie_detach_pd(imx_pcie);
>         return ret;
>  }
>
> --
> 2.43.0
>
>
