Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013053.outbound.protection.outlook.com [52.101.83.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECAD49C4C8;
	Wed,  2 Sep 2026 16:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788365779; cv=fail; b=GLop95A10xvHb7oCXaHGKPJinvoCUisGSkNTCIJSdhEIVn/rHzD1FuSQXf/tTjlEFUDujwN3oSEeDdYDzrWbE2NWJx/ypTOh3zUM1o2MWCFXJaT5QKAnq4NJIynSto0Mjo8Ci1yCRiXaKF5mjnORkAp/HRT4yk3PncC2PNlTZ48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788365779; c=relaxed/simple;
	bh=RRaFJZZKQ72dhjK/WyXJ8amI7R6GCo57aWTngpubPss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Rvg9pdk+KR214r824UGyxAXfUVBpzJaxxdXAme1jGv4VOjYs0WPWvHdhHVpmFqfiTEcrDnnqaMSWZNyS2xxzlPDDkK1wLVSeiHryXyDIQC94FXlgCciu8/Y0PSG/h4JQ4EiqYS/plyJDAva0er66KVDdCE5+hz4A4aw0K8RUxFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=sTwCjsHO; arc=fail smtp.client-ip=52.101.83.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sTwCjsHO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wk8xSEMK74paenfqkete0TDOHDjBzRaRHVO8a3LkL5CXJ1/3/D6YyIPZMLgRX0vI5Phmlt+N5K1gxeKcuu2HzgmBi4o5dBfYdzT+XOPE+iFZObj3UlkCjbjUir+sj5oB0s/eXIACtsx0yikMfXW4eHW6QufEmeUpocqOPaXU1oBW8Nv3iEISbZixs8xUHBR5GfMK1AmmSQ8ZuapwKJE0V+FeCOOch9DIlbzx9HJ/fBNOVGhDKWAKPZuk2y0baDSIexjQY6Gs1HX9kTle/Vy+0l92i07KwtzqqgR+n1fUHbVwcotW+fKYM9sb3wi2gmMqce6OtoQHVWrGSfsGX0ZUuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8bVWrBUuGbEGN133G14709PlW7LDPG1xyYT6Z8U2Fg=;
 b=qqT6ggGX0uwS4gvH0BSS3L7QLWXJCe29GunuR/OPiM6fpcirkmyktqOXq1SC1wHfg7t8BGWEOqvk161q6jNhCtMNZbEKZsGw0JRuhDIg2qp2QHMoX2wBkxIzkuY8CbXwHyt8eIUQfO9fAL5tq8fOds0RwH3yiRAOMcb3bDHTDN8gNCjdk/279BRQH6fJJbKhpLeJoLSDts4qs2IkOBbqS4AbKjwIt1W5j2xCbSa8B2T9yl0FcKscT7PIrhtP+KBPx4rB1xX0nBw7R8gcw3XVhgAw4jnRvrKX4V141eOF6PWwxJh7/zIujsJfZaIShkpW8Ky6KsqTuUbN8eUSHeDzNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8bVWrBUuGbEGN133G14709PlW7LDPG1xyYT6Z8U2Fg=;
 b=sTwCjsHOC06NfmJqFFlnsNnPPAXinzUFc9+8RKWBp6EKfix/YtbB/TZLqfP1IGKu1y+Wm2Vrf1URllLbEijwRbZ4MpaDuJo8LalNEKIq9kgkfTGn8KAYrWmyO4f0sWwOtkmBofF572yvLj/r88qjdB+IwgRuMT7Tfes9vjIX4hy3WzNh1oswNsiubjlbT9h+M23rQ+TpNVJgYAWKJACOJ++4l/Fa/CJTfF3S5S6q5yRk/n6iS7oIUYGTABMstyWYe5qVPQV2mrBAv7hfMihop3UIUImsUiIZWb1eD2Y/sGcsZLPNe1BTijxybrxeacTveD6t56DQ4fTIPBM+brUfZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB9PR04MB11560.eurprd04.prod.outlook.com (2603:10a6:10:608::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 16:16:12 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 16:16:11 +0000
Date: Wed, 2 Sep 2026 11:16:00 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Zhijian Han <hanzhijian1991@gmail.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, sashiko-bot@kernel.org
Subject: Re: [PATCH v4] PCI: imx6: fix resource leaks in probe error paths
Message-ID: <aphLwOms66BNB_db@SMW015318>
References: <20260824150454.3511203-1-hanzhijian1991@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824150454.3511203-1-hanzhijian1991@gmail.com>
X-ClientProxiedBy: PH8PR15CA0014.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::17) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB9PR04MB11560:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fabeda4-64c9-44bb-b131-08df090d80da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|1800799024|7416014|23010399003|366016|11063799006|10067099003|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Ra7A1gRUolqzCwAWzadTUXdf7lgsZkHJJRHvOvNrkkZiSu7CmV7AtgQal6KnW9fH83MJ4dETfz201tennmCve9dnE6Cs3WyQ7A52xASveuuXws5N6Zoh87KFMP48wnXbbvsXnKoAjVTCoaw1lGzgZT03ey+oHCTh1NLqX6r78qY9vldWrUc7271cWVWGfXHv4AxVHNn0YhTADevXqANHw+HxLeGGrkSM0k03wgdYRVfuTof1CBjjjqAVW6oeRrGD5FmgqFETJMW3cjaaQSqvWBIHB56cMXdbqSI0Qi22Qe7jBIsySWob0WWqyap0wkTnLh1wQy/udE1h6UnAdqG+njsQh4w8oTgQGqCeRFYDViOmm9c9dzb27ne0f3Ak246j4C24uhcWY/wY9HkOhDsipbxihCeOeVBAofxjAVNHZfRcwLFFyXkUMPPhXj5OTfJDcNisQiVH7RGZnAMPA7Wy2Ed6j/ijJN8dZNKo6R8v6EN6bwQcPEcGJsSB/qZ7kVHkLYoTONpBvfaPPsIPPAqgaWlVxesOr4JPeqtLoVHYGNLQWL1ga0UFjq+T96jW7diowOd9Cu93KorSnYIz+1QnLilIm3uhPpgEpPbb0RCrr15IlaR00iTtXcUE0srheUtyd39cpvjObuTMSrGKmJRKDgDiTMi84YuCzKx0PLJ5ghc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(7416014)(23010399003)(366016)(11063799006)(10067099003)(5023799004)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QhaaqCWvtCUBEJQlQ6EgV5UZe+yFEuTmW13SYC3+JkkCxIoI9JQP/riDOOHV?=
 =?us-ascii?Q?gErWvpt9H8T0GT3DkUd51VnDPO8tOfXYxjsqEJchAMFLwcvl0YDZDd1QLU/i?=
 =?us-ascii?Q?UsnaMWrT9A3196L1rbDro1oYSLiJt0PbYZx3gc7XwAPCSbfiXxXc+JSGeplv?=
 =?us-ascii?Q?5A0cMVs2gaan3KS+dI5ej4lOsRkhmHC0Is0i44xZR9H3zaSdu3S6X3Dtj/Mk?=
 =?us-ascii?Q?NuHxFiL83oxUDPtnuwAkISPO+hzHC0y84MYKWCMGuEDZIn3Ifwus4UPXux5i?=
 =?us-ascii?Q?Cb75JZNHgyIad7udHFG075shNStqteq4Kpm5vSxNCpzi7MZAQj0iL/dwJWuE?=
 =?us-ascii?Q?HPjCQpBPRF2BefoJGh8kPNqGEgAed+jGMz36ZCiCPxFEdYibqO2F9mdKKu8f?=
 =?us-ascii?Q?7co1jrWL2T9FY3knu89hVGqzKQKK9UM9qNhxa/qLL8Qezie1D+6aHEBNnYUO?=
 =?us-ascii?Q?8+ne+GqYHHH/L4ORy2xlqrj5cMx9cayhVAEXNzLpVOdTaupdzkKFZOIs/pJX?=
 =?us-ascii?Q?oG7IfmrFSS9Q4BhZ8cNegcFvZ04YKU1kCaZJ1IHxr0QHCBU8E4drCmkW86o4?=
 =?us-ascii?Q?93NIniUBebOxYddmV5bDF2Wla1d12nsegOY/2nkFTl0g8ariPDBmGHHUJabC?=
 =?us-ascii?Q?du7GBqJTSID+0xOy693wfqM8soyXdHKBMO0WgcofvFnriQMiXIusHKp1bEn+?=
 =?us-ascii?Q?2jesGvwtS8ZyYnWsK61mnTctE5XFo5fzbPB1uoCnEktKbjpwrV9uwh5RULDd?=
 =?us-ascii?Q?FI2vf7j2S/MeiVOOLBl9AVzZJrWgRjVwi/cS66MsQmay8j9XRop9sBITB7yI?=
 =?us-ascii?Q?iT+WtEeC+nt9hV4TuGoFLrZmMHPq3EflbARHx/wua7Fxbh6C+UqKrje6Lsiu?=
 =?us-ascii?Q?fKwhM5eDQ8WW8wqTZMVs/WBOKPMJ7PhMfkovuSwcmjsPEqpzVdEn+hVN72G2?=
 =?us-ascii?Q?PJ9WR6rl4QG5ZphBjq0GruEmR5Qd8T/vmMNNa4uEmREmc6Zqasrg8A98O3F8?=
 =?us-ascii?Q?pUN+U6T569xWLr8R1lNvmpGrRlGZ3JayOQehCrn+F19zyTFX5+T1tnXxv166?=
 =?us-ascii?Q?UJ75ImsawjfGHMRXM3EVBc8pNKYk1RWM6S8PcTJ1OJYUhiSFaMIg9pwTLbZZ?=
 =?us-ascii?Q?CTvibNb/FyidTz98ptCUkSlp3quA4AQSxnw4cTzcNfketEqtLyFzPDqBbS6h?=
 =?us-ascii?Q?tPtqH8g3EW4Fr33ZGy8gD/YOAP1hHglHHZS8C80JNYtm1f3H0KuWMMrmC0xI?=
 =?us-ascii?Q?C9RBI3KP8e5C0Xz7ofU86CGfErBVQ7SXTv2Ke1FxZUPIs63PhT+Xt9wr3Sn7?=
 =?us-ascii?Q?AZJBjfJg1osFOfYvLzkwKjBkl+hPqI5y9rONT17KkrKBZ4hV2G8muPTE0qkN?=
 =?us-ascii?Q?zHDcVWou3FUojTuOfL+dELCV3S3faY2tdahslBpNfPmWyesjLrQdcYYXJ99m?=
 =?us-ascii?Q?Ckj7aL7tBzOlvPzrj3RMg9GdXBQyGNkKKfUs8zQz1LhezCOAJy67PvLtBLoP?=
 =?us-ascii?Q?eSYC/dwIqO/6vfatmlv+Yn1aSiCidZmtb8d1A1qj5qpcGn0v38PBigrvl8pO?=
 =?us-ascii?Q?Z9JNV7ZN5aRC10Cm0xdmOUnwyVfyc9t0Zye6uy6kcXD4BJWwT0VImCqrhuER?=
 =?us-ascii?Q?qn74bfjVA6wzi/lboZ40CsmPN4TMBVVOnyj+bI6/r8SPIsohSPa50zb1O0xR?=
 =?us-ascii?Q?ovTVcEX8qFpsCiwJC3RQ05HiEUbD8RCjkjA9M35Gb/bo7ZMBood3B/RRyL9Y?=
 =?us-ascii?Q?KR4oy1UobNy1+jN1I3YLho93w3pOct+Vp1YkGK5V0iuevJgSwkKE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fabeda4-64c9-44bb-b131-08df090d80da
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 16:16:11.4767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IhKGpkBu0iY5OXBtzEW/sNbFQgsj9ArE/3RUsmfeOpg7ljo7X7zfQlobtSmrM6EdWGG6CVGVfmj3+BI7V6aYWUclqBfs+FyAs97zoXvdMKsfFX0fAEt65uIliEarznH0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11560

On Mon, Aug 24, 2026 at 11:04:54PM +0800, Zhijian Han wrote:
> [You don't often get email from hanzhijian1991@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> imx_pcie_probe() leaks both pwrctrl devices and power domains on failure:
>
> - imx_pcie_attach_pd() attaches the "pcie" and "pcie_phy" power domains
>   and adds device links to them, but nothing detaches the domains on
>   probe failure or deferral, so they leak.
>
> - A failure of devm_pm_runtime_set_active_enabled() returns directly
>   without destroying the pwrctrl devices.
>
> - A partial failure inside imx_pcie_attach_pd() leaks the power domains
>   that were already attached.
>
> Add imx_pcie_detach_pd() to detach the power domains in reverse order of
> acquisition and call it from the probe error paths.  Add
> DL_FLAG_AUTOREMOVE_CONSUMER to the device links so the driver core
> removes them automatically when probe fails, instead of tracking and
> deleting them manually.
>
> Reported-by: sashiko-bot@kernel.org
> Link: https://lore.kernel.org/all/20260822013640.182C01F000E9@smtp.kernel.org/
> Fixes: 2c5768344f88 ("PCI: imx6: Move pci_pwrctrl_create_devices() to imx_pcie_probe()")
> Signed-off-by: Zhijian Han <hanzhijian1991@gmail.com>
> ---
> Changes in v4:
> - Use DL_FLAG_AUTOREMOVE_CONSUMER so the driver core removes the device
>   links automatically, instead of tracking and deleting them manually
> - Add a Fixes tag
>
>  drivers/pci/controller/dwc/pci-imx6.c | 37 +++++++++++++++++++++------
>  1 file changed, 29 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 39790e66b..0b4209365 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -639,6 +639,18 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
>  }
>  #endif
>
> +static void imx_pcie_detach_pd(struct imx_pcie *imx_pcie)
> +{
> +       if (!IS_ERR_OR_NULL(imx_pcie->pd_pcie_phy)) {
> +               dev_pm_domain_detach(imx_pcie->pd_pcie_phy, true);
> +               imx_pcie->pd_pcie_phy = NULL;
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
> @@ -655,24 +667,30 @@ static int imx_pcie_attach_pd(struct device *dev)
>         if (!imx_pcie->pd_pcie)
>                 return 0;
>         link = device_link_add(dev, imx_pcie->pd_pcie,
> -                       DL_FLAG_STATELESS |
>                         DL_FLAG_PM_RUNTIME |
> -                       DL_FLAG_RPM_ACTIVE);
> +                       DL_FLAG_RPM_ACTIVE |
> +                       DL_FLAG_AUTOREMOVE_CONSUMER);
>         if (!link) {
>                 dev_err(dev, "Failed to add device_link to pcie pd\n");
> +               imx_pcie_detach_pd(imx_pcie);
>                 return -EINVAL;
>         }
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
> -                       DL_FLAG_STATELESS |
>                         DL_FLAG_PM_RUNTIME |
> -                       DL_FLAG_RPM_ACTIVE);
> +                       DL_FLAG_RPM_ACTIVE |
> +                       DL_FLAG_AUTOREMOVE_CONSUMER);
>         if (!link) {
>                 dev_err(dev, "Failed to add device_link to pcie_phy pd\n");
> +               imx_pcie_detach_pd(imx_pcie);
>                 return -EINVAL;
>         }
>
> @@ -1956,8 +1974,10 @@ static int imx_pcie_probe(struct platform_device *pdev)
>                 return ret;
>
>         ret = pci_pwrctrl_create_devices(dev);
> -       if (ret)
> +       if (ret) {
> +               imx_pcie_detach_pd(imx_pcie);

use devm_add_action_or_reset() to do tear down.

Frank

>                 return dev_err_probe(dev, ret, "failed to create pwrctrl devices\n");
> +       }
>
>         pci->use_parent_dt_ranges = true;
>         if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE) {
> @@ -1975,7 +1995,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
>                         pm_runtime_no_callbacks(dev);
>                         ret = devm_pm_runtime_set_active_enabled(dev);
>                         if (ret < 0)
> -                               return ret;
> +                               goto err_pwrctrl_destroy;
>                 }
>
>                 if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_SKIP_L23_READY))
> @@ -2001,6 +2021,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
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
