Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792597004;
	b=YwnMAH6FgUs8z5MeoxFEoyltDeAYVlRB8VX/vPThVYyx5TxIH0IPH5EyoAgaolmKzKiu
	 jR4R9TqD1FeiaHgzPONEbjaNRykWA+9F8c7CHfXofSV2toSUfA6Xl7WeMfHyczY0p9de+
	 3qx7RO6h2wrDAhQWiHbd2arLc0s0YOrYu5yprfu9HSiFcPMs6apzdkh5SJbUg9l64Xmbb
	 DJ+POjV/cEjre0p6zr1zUQoXEkImDuVkOcEPrshtDdmeNmLMqQFHV47963kZ4NSxr4BEO
	 MFiNdmpeTFg/R3/B5AMT0CDkB8hBNlWP3k3Ax2emlFf/k1UElnLflevEVYBJp6/hxWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792597004;
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
	bh=/cYx6V5JxbLM5HSBVYXqCgcFFkpkeuOHN8lbXSLgZZU=;
	b=sYXU69+FTpcXOmiDR26cph0tttmKWOxQXKvOWG9U0epBgFscB6uh/lqEVGQ8S9Ati462
	 p5l76tZBJgJIAfDZn/OH68m8Xjv2OVEjdiLhRDzGLukTuwxoRH68mlr5A7zfSDQGK4eoE
	 WPcuXEgQRXrMhuKjTDG9LRjsRHmhSS8p+HzRH7PXZZTOySuYYH8+imi6RMsHBh0XtUfM8
	 7vVYcjxVIgXibhpblMstKeysaunNQeJb6cYGX9HU61FRhWFPkPrsF6F0mJhdzHyENnkxK
	 5AHX6NmmTwgpuVOEA0mWC5zlPwc6R7idW5D/EBMbXGI1Jb1KqL93cZjN2zbTQLeOjgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=kdcy2ohG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.32
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010032.outbound.protection.outlook.com [52.101.84.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51513606A319;
	Wed, 21 Oct 2026 15:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51513606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=kdcy2ohG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uk6RpqUh8FDl+onIui+3SP7Or777PGpWoeXzKKVeIySntzoiaGmfNiut8NSDGydpSutoJ+2W/0hGvj1UdURBaRxgVuMTz4cQ8S1lLh78WVKP/axQb8k2KpiGqT3dJcQotmADOK/IULfGOxTFfHmoKiEJAhPYqybYFCvS4DNzG892oSmqc5FRKhkmBCzM8TfPsz4/ScHtEWyEJuSMzBufkD2IPub2p6PjBlT1asNWZJ+2B9LCoCKpL8BHtEKSFEbTUmx2rqmI/m49YbeJenV0ZGYAlxH/Iyeael+vTDcqUnih1a1uZuWZ4VhF1vAsR3ToxMwwGDeIjQ9jqWmhn+DeOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/cYx6V5JxbLM5HSBVYXqCgcFFkpkeuOHN8lbXSLgZZU=;
 b=w5mf5hDRyZngiT4x+fTxEe3TT9QyVEO32SLvQ9zdwZibBjM2gYNX06rTVTRsdXNbLCf5NNtG8jF4iIl+klxOPyCpdRM2zMPSfvUWYmuniDSpK31xX1IP3q8536zX/rrm0Q1Bw6EHEcLVMAAGCEPn/HQYtgXOst17ZzBHCLvmjJNTXMoINH85MmlJQYKtXl9iWKVpJ1ULcwfFGm5WMhZ0FfNAlVYb11SXZGhsoyoOST38kNX6bQy8aGfX8SFsa99DGkI/NJcgyxLhB1nAETptWp47mMBmcNBaB5rC5u4TsPx/8b5ieS/2wWqpzUMhbCkTcD2fzL7gQgIMSR1Ee/E47Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cYx6V5JxbLM5HSBVYXqCgcFFkpkeuOHN8lbXSLgZZU=;
 b=kdcy2ohGDha0uj6t4l0CLRGDzdZ7nWlw8o/dAIYs9t/ash80ebLRo9rhjFsnzjcAL217HTIP1s4cH3xRzdDx5/lm5s1jZSiVDfxjO6AMJPM7L/zrTvcPiWWRbg2G/4CelCNrlx9ZqMppPLThczp5lRv+WkgOSL8NPy5MADWhBeuAkkBCwnJns8Gb4xipgczicdXGga44uOWRJzsjFLxM6NpDaXE65CLnyTC45/TMdu2V74htb4v8xhLwBiq2AVjR8J2UuDMv5K/6HkJXnGbcdlujXq4jjh/xm8qfb+bIK7unJiE+SuxtfGWCQSoVkh1GKHRlz6JX3gMhjJPNw3wqiA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DB9PR04MB12452.eurprd04.prod.outlook.com (2603:10a6:10:609::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 15:36:41 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 15:36:41 +0000
Date: Wed, 21 Oct 2026 10:36:32 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org, robh@kernel.org,
	thierry.reding@kernel.org, jonathanh@nvidia.com, kishon@kernel.org,
	Frank.Li@kernel.org, vidyas@nvidia.com, cassel@kernel.org,
	den@valinux.co.jp, marco.crivellari@suse.com,
	andriy.shevchenko@linux.intel.com, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/10] PCI: tegra194: Guard Endpoint PLL-off error path
Message-ID: <atjcAJX0vddRTR4N@SMW015318>
References: <20261021061349.1265704-1-mmaddireddy@nvidia.com>
 <20261021061349.1265704-9-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021061349.1265704-9-mmaddireddy@nvidia.com>
X-ClientProxiedBy: SA9PR13CA0044.namprd13.prod.outlook.com
 (2603:10b6:806:22::19) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DB9PR04MB12452:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ada79c0-5d93-420d-cc9a-08df2f891a9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|23010399003|1800799024|366016|6133799003|261009223027099003|56012099006|10067099003|18002099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	nqiBdoiEtXk1qJbA74NkAESYUGAYEiOZSPBZCHecaFrAG+h+Mx3b+fVZ4pq39O2FPOKKSvUz5mZom9yq5ln5GBnkX5FERTQEd3vWsHKjVs0w3tz6oD83A+aN7IOqliSWoEZg757IPN9DqMRr6yHsMj1lZctbMu5jrswEKuC6Zf79ikIHqaUJ6tKRhQpwF1PrtlrGj/h4lN2rYMrCpo9HWXTn2MG+uyRpiNKdaqOnxMSC0R/ppt6cuFzK4iEjEzHuJTE/pkhVUB2VXlbVOc3OcvFZzs1B600Z3kNfqmQahvpSQonU7AseD95yib+YLRnuRhpAn2yuTBEEcL8wbmehjjCM+CL1aAMU1iyACgeCkwTgLzOeTmUnE5YmfVu5mDTZbaQYC6tpOiD8zs/+wyo8cryFwJVY79uZVpOulM81A+j1ekVzcqWwDhJYfNoznIf88XtxHDHW4MXBJd0VNe3cfIH/+3XKgMht8IH8R22WFsX2GgEBzc0Ry8+0n/wjMxv7PtHVDHO/8gF/oDyfVixCRY3S4jXwMxcWlp1kqkGMdpO6mpPmfGbGIIbhCX8zOjPCZ97ub6MwErKmb0gl7BK6jJp6b/Hz4LB5wCXfAPFeeSHbpKgLKvTdNRGVxJavyKgQcGEgn6gMcSxVbp4Y2k0DnMl5LDgF3g2nQy9ZF6l7xVk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(23010399003)(1800799024)(366016)(6133799003)(261009223027099003)(56012099006)(10067099003)(18002099003)(22082099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HcRYsd51zXvTqyzAYgqGkh+RqqU2zKo56QbK3QphfoGrs3AUduYAH3MUEBVE?=
 =?us-ascii?Q?AxQEVGIXu5MEgQQXBGXlJ42BHMT1i6j7Glc6zqoWi+9XM1rBIv7CplzqF8v1?=
 =?us-ascii?Q?fZ8Uj4US2ktP98RdfI0OSRrNhsGKaoj6En96r2ZCMXV3RmWowf1Bu5IaL+jl?=
 =?us-ascii?Q?oGSBgCupUw06TAh61t3kDepDvSNZtQZwjQ5l+r2QYprhppfoDE74IgkIreQ9?=
 =?us-ascii?Q?ePkNZQQdNzFiF7ZUmic0LLvTCg/Ec0kABujPMStz5/GtCAhq7IIvUCRpBjGO?=
 =?us-ascii?Q?EkPfyQtObCdS2k2QoWi2DebCvTtXO+9gbEU08FFlPQQef8SSOMXnIozPbxN2?=
 =?us-ascii?Q?OE+fRmCOHoytpdfnhsy7/yB8U7WGaXtsZC4gRd8djKFujCJ6XSFAauzoo6xd?=
 =?us-ascii?Q?cp1QI1SMn4wj1J1OW0nbvicN/NCMF9x3Ml/ua6n4uNqjj36xa0ftnK8ml5Bz?=
 =?us-ascii?Q?b7pm8pC+w0EjhQP7OdWQ+FVRdIixidnkKzOXcjxWCljjb9Ug00pGihUzbkJ5?=
 =?us-ascii?Q?TcZCNucdWpei2xbdr6SxCu9pLOav+aR7mbBB6sbiqELgsk98jg9Y0Q4KFvuB?=
 =?us-ascii?Q?gZQmub1MrAdCi7JaKOBB5i7pRhjnpvIxhzy7AIHDJMSvdzR3+atsNfCNpnVa?=
 =?us-ascii?Q?bMoAzjgr8CZ2V3x28C3OFXMKzsuti7yq9GnzGOtOuVwdIrgOk4Xb54moPs6g?=
 =?us-ascii?Q?8F/9N9Klc5u94zjk0rxlP/LKjj1TR2uQHCMNEHNgMCfGgKVGKArDa+CeexJB?=
 =?us-ascii?Q?lc3oGtQb44mKbY3pxC1M4G8o8VeTPq9IUyDuYtOPL/FLdl40GfHIksIgf6Ym?=
 =?us-ascii?Q?FYCsi21Cnd8jZj+HpoRS0UBMqpujMhZtGgtXVYLY5hJElBBfu9pP3jeWhwvY?=
 =?us-ascii?Q?1L7gcXOuS+Qeqe587xeHp57ZUiGu3nTwHz6ps8hqDzlJ30q+fwRjDuRe5D7P?=
 =?us-ascii?Q?66f+P58O6iCPljzY7g6bahapHEb0I1ZHei+mTgkAmO+z6ONhiFYp9wSy2Au/?=
 =?us-ascii?Q?DSkjqjTbKecaF7+wtNbKlYGcURJl8JD5mUQ0DJNVdwwPuUalV1zRmpqxTj3s?=
 =?us-ascii?Q?xMyCp/xyPq6lC79TNHJhy74PnjJArcEYhiNsHjbxODfX90Ul0L9JvMZ2AWId?=
 =?us-ascii?Q?hUrUjVLuyLI5SyMypWVY7l6e143VLmi6JZs+fnYuyzExswwhQqJEKd6/XVhK?=
 =?us-ascii?Q?dmESzCHSgkwtHmPaOKpfsHwhvjcfBqZWXUnPFhm8/xFuikR8ptkDnSdhw5BW?=
 =?us-ascii?Q?mTLbHNLHcp/qv5upm3UMERDRfuryAn1lq8ci9C/RM3THQNzTGZCE8Oa/248N?=
 =?us-ascii?Q?ru3tUws1xMJM4nAijgiabwxrZ2+m2QGQBepvGUkVMOPCX29i0kgVgDc98WnY?=
 =?us-ascii?Q?4LKzl6lrOr9nXUKKra34fSZxenglyoDRj90Zaj4AWmw3XG+oHSHiZ4oaGLTI?=
 =?us-ascii?Q?/CFgKg0MZWV0Cnv79BSMhAMDHWayMt1mCjl71/X+wTv/kHPLQcygkmB3Dv3f?=
 =?us-ascii?Q?BYUOk1wOWAAkGWkbNIBy+f8xTT2Zgen22QUXNpxMvdmixMuTiwmSu00B7v4O?=
 =?us-ascii?Q?elOOkgeg/FCbRJDtdEELKy/0Q6/CfXtTSWkvpgXVlms79SwZuldk3WNQaiRk?=
 =?us-ascii?Q?XNjC0VC/CkPrbNOgDObC7lA6Wgxwssdu/W1lcbdxNiZnrIfG3OyVamcW5uCX?=
 =?us-ascii?Q?A7B96WmgjrpSf9R7/kL8IWPTlX49qnXrPJEVkWVJrgKDHde+uvrYl/NTC5bQ?=
 =?us-ascii?Q?xE5hGVG9byckBWK7NqGXOchqxOsEiV1X/tX6QFJruh527JMKu9SU?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ada79c0-5d93-420d-cc9a-08df2f891a9c
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 15:36:41.5423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0bSKE8iMoKsAn/9q04Mq7XGw+jpaC80hLP0Neu2ZVQI31ep2q/2l9nqXCEokWxDY8yvGPjUJ5omaDUdfxbPtXl4RrQF7CQl8d7hxWurFoSr6HOTWewa0vQG/AYfqEX6g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB12452

On Wed, Oct 21, 2026 at 11:43:47AM +0530, Manikanta Maddireddy wrote:
> The Endpoint PERST# deassert path initializes the external-refclk PLL only
> when enable_ext_refclk is set, but the error unwind always sent the PLL-off
> request.
>
> Guard the PLL-off request with enable_ext_refclk so Tegra234 Endpoint
> configurations that did not enable the PLL do not send a spurious BPMP
> PLL-off command.
>
> Fixes: a54e19073718 ("PCI: tegra194: Add Tegra234 PCIe support")
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes V1 -> V2: None
>
>  drivers/pci/controller/dwc/pcie-tegra194.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 0e6224b6751d..de14a23f9a4d 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1973,7 +1973,8 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
>  fail_core_apb_rst:
>  	clk_disable_unprepare(pcie->core_clk);
>  fail_core_clk_enable:
> -	tegra_pcie_bpmp_set_pll_state(pcie, false);
> +	if (pcie->enable_ext_refclk)
> +		tegra_pcie_bpmp_set_pll_state(pcie, false);
>  fail_pll_init:
>  	tegra_pcie_bpmp_set_ctrl_state(pcie, false);
>  fail_set_ctrl_state:
> --
> 2.34.1
>
