Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792596190;
	b=exTD2zvpxCdy+Dkr3TM7mxG3P+hNCj9UB4nie4bzWwi0uh9IV/PyjNOySVz6Jp9jzqVF
	 5Cp5uqcVhe4tl+co64ft2FBR8S4lCtTj9iayTXVkIwS4C/j+Kzg779GQQjLa2M8sJjPz4
	 HNqF1RbiQ5zmQcqTVan1NCCScJ5ufzjU6d1CXRYwaeX/qbCtP5yAvAmoM8qhuoZ/INPLd
	 oIuWX5NK8EBnUKxebLqXOIgKUPWQqXUyXn/25dCLc2EjeG+utlVQSl9NOr+zzXoT2a758
	 Oe2wygX4U2JFrGn050YfbeZfokbHFdmJmzkjOYvPFH2KBrkCra126e5maTogCsZ2AxA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792596190;
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
	bh=b3sx1Wa/IWmO/k5EHUlA6PHTx9NBELLiOwmLtr+Zh6k=;
	b=GwXQofDtkyc0QiesmITUJu/PqsffwGHnubctGhnx9ZMejthoyFuH355cpIS2KFl8FV/b
	 +oFdZaWANiRmKLJSZT+YkFanKuCNhl3FocFRq5/kqL6KHgVKnDF6OarmZonaHMOPitbVL
	 I3CDczRoj3Y5QYW2KD+mwNoVPGig+RNiHAOPWssQPLhC0mIOrKrrF+LEh23FlZBZgUoVv
	 zS/Zj1HIdku6Cxixo+IaB4PB7Fhyij8M0WQ37ke5nCBXNAvWxFKcWsNYmPXUf9vkLKx4J
	 lFqdXAVdzjpU9wacWRJHqCehKBNAjS1e2aBmOLyBEBy61JdnOkFMnZ6Gx8M8174vxew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=XdYKe3LO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.34
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011034.outbound.protection.outlook.com [52.101.65.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139C4606A31A;
	Wed, 21 Oct 2026 15:23:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 139C4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=XdYKe3LO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ES7AIqjvPwal1t2EZ2oAVoqOYZRskE+zv9bywUVVsQFzqX0cy1B4/w4TLVqP8Vc3xIIKX7gyNusTKQ6kAqHhy9TOy2TF5iQvhqkE3ER4/L9uw39SWoe0CO+WwhJjkA2q9XvLiIjbT3cJhb6ENw9XpDreLwobpmQQbw2V5SH9B7f501Pmm3SyZ2tfh+lSv5nBySq8PUWncz9KH0nFBT53Jyvq0gtU/xawHLwN2zDizeNN+5C1qZcG6/mtsrmYckAoyFkklKDKyGQs/lhRS+1/2VM3P1TnzA28gX2Fouh++OFRPbkOD6UTvU22UFQ27rSf8hEdzq8r7gqQWhY1nd/zzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3sx1Wa/IWmO/k5EHUlA6PHTx9NBELLiOwmLtr+Zh6k=;
 b=cBNUUJ7R3czWF018EAAiv1V2xqFBN8FDzBcinTLEkjkxjDY+3dIybdAj8nex+0A95JJ6Xi4hU9VtncjWb0m5HwTyvwVKGKvQ77+5XrWa74QN3X9rPzoBn5nHfhn33KY6+WRWEyepMvZfcK5E4ML+WO6oTc2v2CXbcW1ZYezvShv+rexGyeSRddM8FRvmX5zCPOPC+ZrbC6NmoukWLPIaGOzG7hfZgHtojQQrIhk/QM8DBmoK6qwgu/fk0QgK8Kdsb5ui6nfG9YTug7T25RnZ5tlY2TGsKriz+Y3EbrrxzDPp5i+XN63VWGOtgb9Dsd0EKa5ytEzrRWs59v3yhUgb2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3sx1Wa/IWmO/k5EHUlA6PHTx9NBELLiOwmLtr+Zh6k=;
 b=XdYKe3LOSdGkvkHK4eD84al6fshRaNYel4E/iOTQQGd37RS4OIKdrB2H9zk8tCdIVGFJQjAFDd/8vZxcEyxw6rYtYEMMDdfyLZdv3GlVR84AavzosbcCfJkkdN2pspupUW2mIFuYqaVZnzmk5x+g/ORq9Lk7j+9PPYgf0rRnsOZ3mijHgXpr5fevIKUVsKV0d9qO0y3i2JXBWn1frheUoRTai5z/R0kTbAnaZVJAw9a/ebgAnvaMbLNo3KkhIG6UCi4NG56Y2h82RUaRcCNvc3ftDLjTVPkqjb5t/0RbZrjTyldDXriHxDoy24IMR6oD/sF7QBzbzkXTNf15jfm8lw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GVXPR04MB10492.eurprd04.prod.outlook.com (2603:10a6:150:1e0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 15:23:03 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 15:23:03 +0000
Date: Wed, 21 Oct 2026 10:22:53 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org, robh@kernel.org,
	thierry.reding@kernel.org, jonathanh@nvidia.com, kishon@kernel.org,
	Frank.Li@kernel.org, vidyas@nvidia.com, cassel@kernel.org,
	den@valinux.co.jp, marco.crivellari@suse.com,
	andriy.shevchenko@linux.intel.com, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/10] PCI: tegra194: Do not skip no-link Root Port
 remove cleanup
Message-ID: <atjYzaiMudKQz2TO@SMW015318>
References: <20261021061349.1265704-1-mmaddireddy@nvidia.com>
 <20261021061349.1265704-5-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021061349.1265704-5-mmaddireddy@nvidia.com>
X-ClientProxiedBy: DS7P220CA0094.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:25a::14) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|GVXPR04MB10492:EE_
X-MS-Office365-Filtering-Correlation-Id: c7774b22-bfeb-4494-84d8-08df2f8732be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|19092799006|23010399003|1800799024|261009223027099003|10067099003|56012099006|18002099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	sSRpfeyA6BJx04TUsA21TTNeXQEUY5QBuDqrF07ufAaGSpp0skA+RJj+7jfe7PkOiF+x/uabVyEzC3Dok1mGw4U3LukJxY4VLUvqoUzQ2PZKiPydqXjw+Af4gKZTRylCTDi1NhVXDp0V4leaAiUJcrkMagtdBNkYuWfjNjD5J9z0ytMIy00s0NaHv8mCDG8yw5si0XoBpJm2h+wjM/l7dvYZUIcK76jO7J3Vxp73XZ6cQHk1OdSrh7ZA0gQctrarbxLcBTgj6rDRKMnLOjqr7Rt7r9BWX5UyfFyiKS6fNb7he+3GfT6cpVJd/2PlWoK8hWta3UgLFwIOtkNFCsPzEVatKdQCWfbzHP3YDD5A35wBgJf1KXaal3f5IPC1erNLbysIN86JtqhLDT3V+2OHlS95Lr0hdRy6R/pyOeG2QI4fYFlzZinHi+gjrYpX7MzLRcDCZvurZmAmpK6CK34HlC5nDNpnD/HuxLpDzcT6wWK2HSDHMep+xFMB1rroKjee1NsdK5lwkaYrzNGk5gk/fbm+sQQSkjvekbDyJ94Mz9qZKWDxR8IshwpCU6aMBe7Wrxo/HcZZvfaGrG7qhmOnIeZ6V9FTgAbB5Z5x1s7k8MGBk2rz4TgrBlT4EgbHoElZekmYcy/rR6l5pp77kZ39uck3RFoww7DQ7+w4w3gfN40=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(19092799006)(23010399003)(1800799024)(261009223027099003)(10067099003)(56012099006)(18002099003)(22082099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CRlC0Z/CUvibg3CDnzmoea/GbV4VTGhNvphFleyeKOxlTkQM0JV4d3TALqFU?=
 =?us-ascii?Q?q8XMG2DqQp/8k/XQuNiMCDF39wRRTNiRYmfY5n8kvDhzRdxkbxc+SsV+sHKl?=
 =?us-ascii?Q?t8JVBK5oOTd85EXockHCz4GS1qJKPHRqLSG+nl0qIjofxh2lbECZ+2ECkeM7?=
 =?us-ascii?Q?daoNcGeT3HY9pWNQNQ+uIVs26EUwbl0po/PaVBBwiFnUGwZV9GQtF1DOuxGE?=
 =?us-ascii?Q?j7FAfXuS5hOegGE0iOzccbDMkPOyVk2NMNZX9A9yjGBZMCSc+3cCfy43bCtM?=
 =?us-ascii?Q?dQCQbYMoNEUsnQqN0BN0HUToRUc3aWxBG4338XoftD1AWA+gRJYXjiSCZYo2?=
 =?us-ascii?Q?LQd69TSMfdPV1cSWkksRAoNXle8pHLadqnv/GFULDrzPaJF3S18of1/dFpVj?=
 =?us-ascii?Q?4a0nHv+Hl2cDHW3ftQCDHA+B6ViA3vBEJuJP+sicTTlYoJF8Lj7EKoWH5IEl?=
 =?us-ascii?Q?9RxUfRmW7MtRH3tPtECU3TJfwDd10yg2BbxZhHpFjKJnhjWlcKV+oYci5WwA?=
 =?us-ascii?Q?p341s3Yr5FSgyi9NaYLyUw3Akyld+3CTRWaehnGOAqmxWvp+jWZOl6Kp2tMF?=
 =?us-ascii?Q?QK42XK3ooluhv19TqtqNSf1Zo4ZleXMKsBOIJbDKGEP+jVBUUV3uOQAQFVfZ?=
 =?us-ascii?Q?cqTQzXA9IuvqeV9u18myecUcQ4dD3VPW9inS/A5D51f1+JPI0nm5XOKcWasd?=
 =?us-ascii?Q?sab6MI8ktJpuocYzqngvyetFkLdBVXNwYwRgZkAHmCtCjtb1xSdh2ZARuSiZ?=
 =?us-ascii?Q?tRzTpNuv2Io49y1KAzX5SkLncs5H4cY1jveBaVQQRJDnb4zRkryOGDLqSdFQ?=
 =?us-ascii?Q?WSV2JyRsaNXcYGqekzFY+dA1u0L8bcWXU88vY+eaO8+4t9JHWxJFHYQdnAY5?=
 =?us-ascii?Q?SOmDGAmAnL7vIhhZ2NvfUyL0w+rI7FL6rTkWrLyHIEz6oOIypB1OGbj0tHoN?=
 =?us-ascii?Q?8y2Uscvf4VrwSpgOD6h4gvG7vXFx4lSts+AN0J1dyaxZ2+lDXOT9URLqTQUj?=
 =?us-ascii?Q?mx9g4v1W7+iXJfiA9KA0LKmQ5CRdXnAXXiEm0m14Iovrh4lgHudtZ5GBlhQK?=
 =?us-ascii?Q?2iOw/oYqDhU1hBhZVHDsGNibfSoYHim4gfxXprr1gxlJHB24aM8/bYxRyDi/?=
 =?us-ascii?Q?0DCGcbn5+2M+q6m0FUJ7QMOnJvfSrOP7koPzXkystzTwViLgo7/uzSElhH8w?=
 =?us-ascii?Q?zkwJgIqsYLWR8uN5L1qZHeGQu87llidAt5ipe2PZLFmy2CKl4GbNFrtZnTAw?=
 =?us-ascii?Q?/2Nf9rhmHTEmgQsyqDhukV6VrZcTLY+B9HTtVSAV7n6Dseb2Gip51Et6aT5e?=
 =?us-ascii?Q?vAev6A0lWbBYFqaHqhFhlCUDTHuqjXMgPZxIUfheDrYQlYmaZoyQMnxZnVbe?=
 =?us-ascii?Q?K+qExlwz4zwznxLUlCXUXjA3hlbMT+/zvZM2uPd+iVmlt+MrI+udnVUWgPT1?=
 =?us-ascii?Q?Da0lg7pwd+j8b6fK/Q+YWLd+ShhdfgTXI4Oxx4ktTd586KJKpNcKTma8fFy6?=
 =?us-ascii?Q?YCCWaSxxQD2eO/gtevhSwOt1JIjvvaDd4NTAYoB4HFeW3kmfpkg2urpEahta?=
 =?us-ascii?Q?lwqpiYbUcJuQb6BU8tVJyIeQLx+/TB9E59FLqYRwFMTzaV0pPZpMXDm4nhZT?=
 =?us-ascii?Q?cjCc6my0dI6Omb5vOu4B2UBRitr+IES0zGLipDqEB/l1P8VYnVkl3sV+CH7A?=
 =?us-ascii?Q?y0OdMPv49KfiRJyZrEqRtnFDM/yv1LfYO2qCRS9SdHK2M5M8trcrMdfzWK44?=
 =?us-ascii?Q?WxL2bNAciXnKDFd/i0BdP2I8pULMLIb117A2ashj4dhSwwOAPFiN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7774b22-bfeb-4494-84d8-08df2f8732be
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 15:23:03.0183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GxPLgkecFFadpQAbC6qP58/aUBQaaWcyaGnA97/LW+qsvO00Jk8Xl/NClkauForVVZk29iFbLHBYt93EyOTi+lp1N687qfAe6lNlDAy0gNwUM1yP0tUHND2c3okv41Dn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10492

On Wed, Oct 21, 2026 at 11:43:43AM +0530, Manikanta Maddireddy wrote:
> tegra_pcie_config_rp() deinitializes the controller and disables runtime PM
> when link training fails, then probe treats -ENOMEDIUM as success so the
> driver can remain bound without a link.
>
> remove() returned immediately when the Root Port link was down. That skips
> common cleanup such as tegra_bpmp_put() and deasserting the refclk-select
> GPIO. Keep link-dependent controller teardown conditional, but always run
> common remove cleanup.
>
> Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes V1 -> V2: None
>
>  drivers/pci/controller/dwc/pcie-tegra194.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 0f895c766a71..fb8084cef38b 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -2352,19 +2352,19 @@ static void tegra_pcie_dw_remove(struct platform_device *pdev)
>  	struct dw_pcie_ep *ep = &pcie->pci.ep;
>
>  	if (pcie->of_data->mode == DW_PCIE_RC_TYPE) {
> -		if (!pcie->link_state)
> -			return;
> -
> -		debugfs_remove_recursive(pcie->debugfs);
> -		tegra_pcie_deinit_controller(pcie);
> -		pm_runtime_put_sync(pcie->dev);
> +		if (pcie->link_state) {
> +			debugfs_remove_recursive(pcie->debugfs);
> +			tegra_pcie_deinit_controller(pcie);
> +			pm_runtime_put_sync(pcie->dev);
> +			pm_runtime_disable(pcie->dev);
> +		}
>  	} else {
>  		disable_irq(pcie->pex_rst_irq);
>  		pex_ep_event_pex_rst_assert(pcie);
>  		dw_pcie_ep_deinit(ep);
> +		pm_runtime_disable(pcie->dev);
>  	}
>
> -	pm_runtime_disable(pcie->dev);
>  	tegra_bpmp_put(pcie->bpmp);
>  	if (pcie->pex_refclk_sel_gpiod)
>  		gpiod_set_value(pcie->pex_refclk_sel_gpiod, 0);
> --
> 2.34.1
>
