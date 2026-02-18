Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011000.outbound.protection.outlook.com [52.101.65.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F75C2DEA64;
	Wed, 18 Feb 2026 17:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771434457; cv=fail; b=XfX6t+ovYJ9sbFyCkyPdIOfYwAaftJqbHtQIsdv1YjBQOVlKjmHoHEWJ3n9hrsStyp/q7wIpOpQpH8jxsgk96a1aYweZUzz6xNTMWAN9ZbuxS8VtQHObIuUYmsZZh8hcuIM/SnVOIpPrUrDYBtQqnDVND2gUqt9zwTCxW3P6JEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771434457; c=relaxed/simple;
	bh=EK1qhSuGPpuE6ZrmJ8kr7Yt6c89AtbePSoxQnUuPYVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YPxCl7v/RNN46MNk0FCUpDj47YzJeUmQ9GsOtezHUJZ4Wu25E+1RUG83vd9WVw8KV63CJ7J/lyRqNZxLiE5bhbYiJXmDjrNfI9e0y1oqUMOxlW1aqscrONlF/DPvXp8U5FTgzq7YXJfope1iQX98xmUeo1GmpqQk+WHJB9vK9Fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=n7ghfgp4; arc=fail smtp.client-ip=52.101.65.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="n7ghfgp4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CwwsFyjATOOYponlEsCH/bIOnCpYWltY9QN72VSWEUDfamj2SbxOHssoqCoKk00uOszkeISGK79ERmxzkcMikuGhC4eny0Pi1rDC5gk7ZHcubZG2Jf0yXX8PrLch0SmUp/0nvXs2EE57N6JlbpsDBM0AyC1orHCYFqRPtV91YnuLa2wKtzY96xWT7Z2GDa/0MGUJmtci1GVWoapvU0GSyS1WNEhL9gbANIAKr8uz182l7C6pxf2Sv67qSPJVOFxYF3wBI3lLmTskEu3nfiAg/Jv1hWkj1qqTXuclXjptco7INKm28rJPHzy3bwJnpwA1KMhlGj0Ryao5ai+/4E/q/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTR4BRlXiVB7CPiiHWDzIhixwrmtoY8YxIip3Qhgfu0=;
 b=NOHCyj7jKcSuCRjMrEoUWNKVXPla/8rKOqQnJoRGIaiSKTb1fB26gGNV8tNcXdQ7fMrJW1MPheES6nI4sYwTd1kyNSRIhxqsjr97Mh5kZhkJCuueP/O4Qx3WhlFaiFMo/TZ+Pd5OfK0OMlLbBjx/OLdC4qduTU/FwvK27y9BxAYza8JKfLNzZ8tHJmhEqa+KfZXQNUoDIvctItPZuf1H/Ehytq5Whh/TpjLcRY4HuwSr/2XoQvIM0u1P299vfMnmQY8VDr0OVf7CPcPkSETu6g6i9mYMjDfgDowpzyUrfpZE6ocupcTsuWr4NnxSZ1H16yzBt4/+tN3dF+aw7j4UFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTR4BRlXiVB7CPiiHWDzIhixwrmtoY8YxIip3Qhgfu0=;
 b=n7ghfgp4lF+UYe8+bFJisF3324ZNqn0CrIPSWsX4tjmz1IYRXjaFnUg3mCDhwppPHROhUcpP5GykujZPL8d/4sXWO0JJmBhO0nD72p8Vlmv7bBTbuoDVHqDecZ1FpcPWUdkpznvpR8T4V/qE1DkhPzNiVQceIVdTnUi5bbgS3EwVnNly6eDvR2RQ0Ryqjo0HS/hzY3hCb0h/LuVo/A3wvuAFKpMewg+9yyxTq8if0ACTjbcB3NI315vQf/wxd0tBufsjdwWW9VRtZ/K8yqpQnxgW120fwoLsSEcRYrUEiUZrDGrg3wGGJYum4ui/bfxTPEMGmVBb9Sn5u6/JZPyD6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU4PR04MB10864.eurprd04.prod.outlook.com (2603:10a6:10:589::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 17:07:34 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 17:07:34 +0000
Date: Wed, 18 Feb 2026 12:07:25 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, bhelgaas@google.com, robh@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2] PCI: dwc: Proceed with system suspend even if the
 endpoint doesn't respond with PME_TO_Ack message
Message-ID: <aZXxzRyPDHScj6R_@lizhi-Precision-Tower-5810>
References: <20260217113142.9140-1-manivannan.sadhasivam@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217113142.9140-1-manivannan.sadhasivam@oss.qualcomm.com>
X-ClientProxiedBy: SJ0PR03CA0051.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::26) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DU4PR04MB10864:EE_
X-MS-Office365-Filtering-Correlation-Id: bb6e6d01-f4dd-48f5-0407-08de6f103572
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|52116014|19092799006|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?52mKoHDx+9cAaxDYrCBlzP2TShpwq//r1UcHMTOOxRclFrFp4ZSZziletw6e?=
 =?us-ascii?Q?yp8cEz0ygbE75zbmyL/+3OYgIR6nWf4qmD6stu1ulRagPApaAe58O3eu2DYm?=
 =?us-ascii?Q?DpEllUSo96rZGc+FkF1QJI+ckhqER/lFGLcGaL3SR57KE1UKyTm4KmyBJIQW?=
 =?us-ascii?Q?MHvqg/F0/zZ3Jer/njaGGcZg9BorM7hm0sGaSfFHUAC7imupIAtObTzanQY3?=
 =?us-ascii?Q?XDif9DaWmqYclK5fc4COjDQ/2bxUAGOv6VgCUNN+EupiB75exJ0uJclul0FL?=
 =?us-ascii?Q?hPdPsuqNel8xSHdEA0sLnVrb/A2qWZswzFOJHz7B0sx+wfktRZhhPx0sOkbG?=
 =?us-ascii?Q?t0VDC+URUYUUryORoO/ixzK+QqJkwSUQJ/+hU4DEIvAU+c+/Dg0V9esd5IGj?=
 =?us-ascii?Q?aXEqvMTWIjiMrfGrCv4vVvCdTgsyU1grC9WqskZgU3/CPiufHYq8Y2wChG5M?=
 =?us-ascii?Q?+ox9GFAk81s3Y2Fty6i3q644yZrlAXzoS34KUyn5eRm3Q2h53WVf14FWmAeM?=
 =?us-ascii?Q?jcpwswBgt6xO1DHRkuVu3i1AvrUISnkdXrnNTrNbSrpws871EbOVQlN+YYiX?=
 =?us-ascii?Q?156kqS4BjzGefiHpcJtaGCuw47NHz1yweOskJq90VZPmKJU+fr7iXEjUCrhg?=
 =?us-ascii?Q?WbkLyrm5qXSKpDuT9KCMYH9uzGFvfcNljewcuVEjKmu7zfxk0CSpdbAVJKsJ?=
 =?us-ascii?Q?0CHOBQJyYXNCVPo5GzZjL49pphRIRnYuM+s0EzEReyEZ5jNhduMAZlIJ2/9L?=
 =?us-ascii?Q?of7BEQv+UuRged7mJBOmDxbkY46DTRCdeUKBZP6V1/iSDmCa/SOJO1dXU9hv?=
 =?us-ascii?Q?i6RCtORXgmJsNsVO4ySESN06eFA/Ad5qxJtJDprKjDXh0G73upwxP4CibI0s?=
 =?us-ascii?Q?R1/HH3YcFvirsKGzitq7tvMS5O7qwU2UjUpQphfOA2g1IXwOiSkz+FoiPPTH?=
 =?us-ascii?Q?S3tN16S2dVOV3fIRaZ8SHzLc+7nPlwdEB5mojfmbebWU+p2zZG3s2WmVOQ0C?=
 =?us-ascii?Q?tH5/uVGVGuYtqVlmW9YI0PcVkuMs+ScuqPxhk0+MCXkbKQfSsliuj47FwoGe?=
 =?us-ascii?Q?LZ15l34BlLfTtUERXt1s16R47iR11cDmYHIuQYQgZaP2i3jfEmSCehUvfTW0?=
 =?us-ascii?Q?Zi62cQp/VWLZSo0pTGo+8HUnxcKPdHZTFVYsIiHoDEHzDBeRzhYk7j3yDTQP?=
 =?us-ascii?Q?LoJOZegoXV8h4MUrbXJjg8YZtcDNcjWv2FpDZiD80oSiZOZbu9kLvL0YpuZw?=
 =?us-ascii?Q?gAcphj+dWNTHqRpNDUwVdv1c3Si0b5t1pkXFbBhun0gxlmInhOmhw0EDAj6o?=
 =?us-ascii?Q?ZVxCHaXwwnLOLiWGqyl9YKpe+QmeqfjrVHqsYAkqHD263KdLWyRW0CMGHgsU?=
 =?us-ascii?Q?2oEXeJ2XKX4K+jUEVjt0g2exqX/Ey/E8YOEdIc8aiVU5QL74L6AZ3o+1zIj6?=
 =?us-ascii?Q?8jpjl0z8XdS44cIenx5YpGN5uekHn166YwuZ9GDHbHCGiz45uunT/BuSVvWe?=
 =?us-ascii?Q?oSQC92iWXy9crtrQ+iPyna3dk5lL7+85IC8dpQ96F/ZqtuoBqD8mPRnzhYJc?=
 =?us-ascii?Q?hJsm+NJq46rksvEqVp2G0hcsWkSMIsa7dVXE5rfCLlmXhwuFfL5u1uHxf0wb?=
 =?us-ascii?Q?ltAkuGTBCzhQSocT87AIT3U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(52116014)(19092799006)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jLlAWIf2EFtvgKGKvCdFoM6TBFEx66aeNANUSTPiUDGtCC9gtsGl9aY8Tyjm?=
 =?us-ascii?Q?KZqJwek7SEt8XShlBhhFq5LFVWF/2w/GJL7PIUGsjbE49Gy2ondZVWOcdlId?=
 =?us-ascii?Q?ka4AXe1ZFPBW5RXYTwp5ipnP4PEpaqWIwpcGz6RibRX6xL6bKfgf+q9WBP2N?=
 =?us-ascii?Q?BkLp62KYV34urGqq8/IveBSViYhe0mUEvHHkG6Xt7KV6U2m2ss642SwLpfEm?=
 =?us-ascii?Q?K4vS3ZZWIUyrJo7synWcpmGnelQp3yvIWiMDWSUpzBk8HaXVAniYcJJCeFw0?=
 =?us-ascii?Q?XjeDefqAREXfYeaItVCisjnwE3qkOIhtOrgJHG/J3cjrBfUJQQ7Up2P93S8n?=
 =?us-ascii?Q?vqu095jo4Vnk1/CzkEWrNfYxniYZZLsUSYdD/kmAhYNVjDcGRzxmorjFfc33?=
 =?us-ascii?Q?n5ZG4QvxhfM8P+RCES/Sh7sGHVaJt5+XN5KAch7fHbR1Fqvf8ihJtgbNgYdw?=
 =?us-ascii?Q?a8fAFqu9lrSJSGZx60QUz0pYre7L+o9jTQhEkbSaW2h/3t57fOVuId0uBl02?=
 =?us-ascii?Q?dJawvPFVksnACG6diUgogi8riPW/+Dn6amBfCWmY88XG3p+Tf+nClyW4QDNF?=
 =?us-ascii?Q?9XCRDNQ4jCryze27WdKaV1rl5uTP8sHDkmZyB0YMflbew1cpqkaeps0iPfXo?=
 =?us-ascii?Q?rC8MgU13z/kaw0RmWO8KubTwBonGgvHaAdF3zmz6nKig528ENG/KJcaSsvcu?=
 =?us-ascii?Q?H3FGP8UXSrnopedtu4RQPOLYdBGU1V5/1vHEaX8s6CLF5d+GX2LWLAcUc2c5?=
 =?us-ascii?Q?xSjpM07L3lFVF4gztShavrklDtrvsb8JAWZBxfQPtATzRAIRNpCF/yjanKJF?=
 =?us-ascii?Q?9ICrCCGSXkBIT7M7u123hAK3q86HGiRfdY3XLRDR/nsN0xMgrCRP0Pqsx/Gb?=
 =?us-ascii?Q?4zsmnMc86E3sy3iX7ehdB31WsQLz70rvTOLScnv0mxi21VMxtiN9rHEH4MV1?=
 =?us-ascii?Q?8XALaTlNdWISqddN4HpHQP92Yhn1n4loTSxU2hLJkvGaNvTMdz+GY9gWzU2k?=
 =?us-ascii?Q?2Gw2qKoGEWvSYchXdGjvPTSAK/Fuavkc5D0lAjRNuoo6SRlLWJZ8UrgtHt4B?=
 =?us-ascii?Q?QxCHFxeRT6thQB+RLYO6mkm30T23P8gUUSwdVuM3alTyZWFmvSZlJjSNL17s?=
 =?us-ascii?Q?AS5DZwrIRBQyT2NLTPlDvzTuwdufP2tAUM34S1FdYqGr2VY4fZxZqbFEjedJ?=
 =?us-ascii?Q?sYvhS9idj6c11FUc+oKgtWvhG1Le2XUwE7bkyF+UJGQ28dUxJxL7CNujRVNU?=
 =?us-ascii?Q?5nLOBAoi88gSTGrymy4ic05Hspf6qht69HCO/YOWC5iImmkdn5VMLGOur2lB?=
 =?us-ascii?Q?IFaUEvWWtxMuxBhZKBFtvyzQnGGpjRYI41Zg1W0+fs06id4tBa+OHUhkebQ9?=
 =?us-ascii?Q?qh+4DZ+b5wh1Uk38XN5mmgEttiXE36cRyhuDK/Td68s4pO9W1GtuPMKjrOYw?=
 =?us-ascii?Q?85/igv+YoPQbxepzJXny9O2vZA4JSLUm4w67BKHnte9m42uMD32M9VFHo8w8?=
 =?us-ascii?Q?U4t2D7qhU1MRKaHGX9kLC7hDCz3J0pqh4k5QxoeFLdpVEQaOYj2j1RAjX9Ke?=
 =?us-ascii?Q?6yhlWmnWW9DZDSohQjgczI0DI2t9EhMI8SbKmILiGVSHpiySO6jhGUt37iZC?=
 =?us-ascii?Q?wlBe/PhN5CIKBiWFwD+ZEoEPR6FqPqTxxIlewC/F60mV+5UBZc161fdh3R/I?=
 =?us-ascii?Q?FEmUJbkYZ5YONPY9zP6uNt3ssXCswZAg3I8am3DJRABqFb3/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb6e6d01-f4dd-48f5-0407-08de6f103572
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 17:07:34.1512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: skelCLVFD12bVyl9IKZTVj/tIs773+o05glATMPHjL8E2oly88BLLQhC7Kty9a2UHI5JBoCHC01nIh3RSlb+VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10864

On Tue, Feb 17, 2026 at 05:01:42PM +0530, Manivannan Sadhasivam wrote:
> PCIe spec r7.0, sec 5.3.3.2.1, recommends proceeding with L2/L3 sequence
> even if one or devices do not respond with PME_TO_Ack message after 10ms
> timeout.
>
> So just print a warning if the timeout happens and proceed with the system
> suspend.
>
> Reported-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> Changes in v2:
>
> * Added 'ret = 0' to avoid failing callers
>
>  drivers/pci/controller/dwc/pcie-designware-host.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 6ae6189e9b8a..ba183fc3e77c 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -1256,9 +1256,13 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  				PCIE_PME_TO_L2_TIMEOUT_US/10,
>  				PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
>  	if (ret) {
> -		/* Only log message when LTSSM isn't in DETECT or POLL */
> -		dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
> -		return ret;
> +		/*
> +		 * Failure is non-fatal since spec r7.0, sec 5.3.3.2.1,
> +		 * recommends proceeding with L2/L3 sequence even if one or more
> +		 * devices do not respond with PME_TO_Ack after 10ms timeout.
> +		 */
> +		dev_warn(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
> +		ret = 0;
>  	}
>
>  	/*
> --
> 2.51.0
>
