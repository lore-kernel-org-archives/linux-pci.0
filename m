Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011012.outbound.protection.outlook.com [52.101.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4086926ED59
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 20:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772050987; cv=fail; b=RydGYUg63B3Ao5Q1zP3sLWr9LleiLV2tb22NSvlBUNEGNnLJhbF+hC9nejFm/hMia5R6tvc53Odj3NAMSWrb/B6hKhe4FjFaVhL3GoSP0+rmSqOXH2fqyvgagfUGQHp0ubC5YpeCp6wlP8WutbuvBdrVewlK5UZRhawi0GZmiQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772050987; c=relaxed/simple;
	bh=jhrxdHOeSIPFd9S5BA5a7LiIhI+EoBA++aVN5lkAufc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aso0SlYpWbifSaYfjw365VtY8Gqsfh9rwryXCgzk7tXUnoPesdnbM9kYkLlJt2Kj3pF/t13ZT6ObP6fFw7LMtUeUHO+4O6btI8aC+zypxX04voURdWrz+CLrWwfcynUF198Q1h+pGJ2HxQEiqe1lrCnpA3pLpf4IY1DUJ/4396w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AqNXG907; arc=fail smtp.client-ip=52.101.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AqNXG907"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yS73X8hDiWUTjL8aiMtoesOfaWdu4xggIS4Vtfc+osCN3GwJrbB1E2STTiJtGYVpndjaROYwVwBiCIBfx+R+dep/aX8b8bMRjB/Jd1FTOisJRHMhpFYQWxMN4nprMjT6OAV9Ng2Fr58f82GrIOt7V/vAkypZqp94Vk3q5lYQZPPyf0cCalMPcMmUWEIseHNwqNW750Yw7l77UFuh20y1eaQTicLp6+52+yMRg3eNh/6dOoehqxYRpEW7v0kCpEjP0+xmMl27WXSCxuGSnC64ac9i0HlzMMp8wvrM9EYJpNA+Asc2Re6z+qncKj9O8tUf/oazUOc3z7i8w5oPPaSmxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z68qyzMbpRMDnRGfFffPx1JOZPjAhaMOKOlMNeFF7TI=;
 b=hoqob8R7k3aE02Y8vVGwXz84Bki2ZHy0KbCVnISy54UfxSFiSxiT6XUDn2PP94c+wdJ5km06LfUYWMMC6Ju4N8i5brDEVbyrBl2CBWBlNAdeYWaL4Rgst9lGm7+f8h6SgWxn3K+7ttMCsTY8gVsdbSudRC8NVt0cETaXp/Myjug4d4CCRIDpstA2c8NWJDYvDc3TXfoVqQzafbFbcxppHtJiLFAvNy/3bA4tR7CYa9SA6/VO2tJ20QyKDTzRoN48uKUKOsqaMl9bGs97jRQpXPw+HaC+ExnegiF7X9v/Q0pQ7PgzceX3IODBIzdu3on/TW0N23q6nf7RoSjUwbVwMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z68qyzMbpRMDnRGfFffPx1JOZPjAhaMOKOlMNeFF7TI=;
 b=AqNXG907OVnXGse1y1EV37AYbhQszV6Xb57nPaOwQyvMbUvwnyW7ygYp+me/8kbi7Vdn6bfRjbYppsHf5fxojaQg91bPVptaaCQZPcjCGD/ECwpS0v+XrwLYfup7hargp//Cryqlh+DuYqZE56vgbv77aMOiYDUN40Ijv951BOmtWkLlhS2PQ0oaRjgFUOhaqDsX0H4cBuEPKUd8d9wdS4Daz2BlSMzgPAh/mQc2jX1l39tKTyfFzuaoppXV/J57pfpms5B+IXXW8NHpOtToFA+DzWKk+gnK9GKJDm8fwKTb6yHVI4bjqzb7BSklYOCItgTxMi5idDGQQGsUcswemQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM0PR04MB7172.eurprd04.prod.outlook.com (2603:10a6:208:192::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Wed, 25 Feb
 2026 20:23:03 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 20:23:03 +0000
Date: Wed, 25 Feb 2026 15:22:57 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Koichiro Den <den@valinux.co.jp>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/9] PCI: endpoint: Describe reserved subregions
 within BARs
Message-ID: <aZ9aId4t6UWLMkFs@lizhi-Precision-Tower-5810>
References: <20260225170324.4033466-11-cassel@kernel.org>
 <20260225170324.4033466-13-cassel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225170324.4033466-13-cassel@kernel.org>
X-ClientProxiedBy: SN7PR04CA0115.namprd04.prod.outlook.com
 (2603:10b6:806:122::30) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM0PR04MB7172:EE_
X-MS-Office365-Filtering-Correlation-Id: 021f2cad-4f30-4526-e567-08de74abad44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	quVZm6EeTkOIqkg9SmXFQdy28XlBd43D7DaT21QtPgoVugVIKYlNR+97qqVlwhPhI/QTJIv3Y/SoTYrFvlkW/kuAieSb7Z2/oCBEdSc7PRzEcNuDumWilxRCPLZgJvrgdsnCOSrWtWEIjUvrzpkRKVULnh7DtJYyxlrpMnuOt0px8ZN0AU7rQMHPhjlPJBCa5MinnBuKkJ+cfT6qC9M30gd6CJGIPayXZbvjA6WulU95A6inXnr63ppbIXFgzO9BeWrzFknvn6UhqqpY6SHQUMnPwa673x+tfjUxj/Q78icUOCbli092ccPSNquSWVby3fHjPHLCv03+VGn8AmwPPeACIWKC6MW68alLR7CtUCwFyrfmWNabWZkUWBPuEoVIi3yxwbLXzAyh0et+Uxl5twaBubDsXcFQOrlc0Ib5FbH560tASSvrc4NJlU2ul+MWrDfp1928fWZLa+B61dNL54qTPckXpsHnYg6Nb4SYPLuP9J1UbdniFVQrVlWaXkMI/BDohmcdKXQJUWCp71Kuk0KWRZ1Sg5N0Lv9BbO7T2GHNkI9kEM5tJQGgvphfHE6Jjst8ZfnRE/mFMLDJH41o3FILlG0CHBCGBwnoqGxCaUG6Fvdo6+ekeL/GKwx/QIXrsKDisDLyjOnE4LOV7YWDxeqOAsQZNAcQ2XMvBO7faD0IAEK8Prj74LqSYhJrOHvINm4hdZdNODwQ/zrmldXybJ3+um9YLq853+Vq6A1Td4pn6iA9fDFAr+jIxIipfqd0MrWe4w4PWOVNAzjswwKgc4pg6s/KyySVSdBZH/Yfj2A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?daZLqjAsHCuuapA8V1epEwu5YFaTinKDMlz/HR6isj5XAwjz3G36WAU51UGX?=
 =?us-ascii?Q?2laBpttvID/tF24ctev7hFUkYiIYpevI7MMjyiOpNwVUvag1x67PRH6v+8xg?=
 =?us-ascii?Q?MtTqIb26q5Z/bCnI7yq+UvcoAGMn89R0DrtjLdlLgrjRoDp/oWqT898SpmZY?=
 =?us-ascii?Q?m3uxy61fASssnTyPwJd6zBVbZXuJgeMQT9UZQZadhIaNfnQ4H4KZuMfrPI0E?=
 =?us-ascii?Q?4DcC74nKjX8b/G0Ms7fU5S6WMNyHpbHSQaAsVFkdPlxoIPCegbmuMF1Enzp7?=
 =?us-ascii?Q?SDvfqrSKlXuxun5/AYNsXOslGwI/mn8DmSlRHhEgwAmjEDO9yaK0McHwb1qW?=
 =?us-ascii?Q?0vsxDzWaH5nZ+HJ2ZZzCGAKDDvVH61/E2aZKCSZ0U5oIbQJbD1mJD0RnFFTd?=
 =?us-ascii?Q?zIXQjwMJp8YCsqZhyLax0mtdJmUQH8v9Y94l56d2mXPkTdBwM6lOQYpIQIIe?=
 =?us-ascii?Q?N54gMydmcfmRd+jepNk+zOlo0vF8SifDVLia+Zlwyu/R79JbZ6+dqFoZcKHw?=
 =?us-ascii?Q?j0ByKr9w9uwvaRTwRFOQfD+tZoMfdXwcqOZUWfR/SJ699jKg4VCtkya8EqTk?=
 =?us-ascii?Q?YK7XiZI//sSGOtjgspj7LODk3lKYNuXOKLmcqMXGyBu+EeaJUjAoIiLVeok6?=
 =?us-ascii?Q?gmBJES0dv9+yOF3PgSxjzzzud79xSmjPngQ1S23t/l7kz21FUgzEyoJTjQyP?=
 =?us-ascii?Q?k0AdSMoSgiuELVKJ3rHeDhUd+7wQtxhAcklJWyOfc7CZLRJM+yodSL73kKh9?=
 =?us-ascii?Q?aC+DUZzBCJ2gA28MCUPDrqYr4QaVS1euXr6UPOKO167ijb8mHOwj8sPi6351?=
 =?us-ascii?Q?oT9LfTFblDyHMgznUUozB+H0QRlq+w8l2Nsk37SPXy/gUgJT0h2WTlWt4F7P?=
 =?us-ascii?Q?q3PdLjyWCJrvWGLwb7AhuTwmKXcoccR3z9rCC6FGGGqYP92lWQcCr5C3a11m?=
 =?us-ascii?Q?uWGvVpDuO1VMD87b3Nb2ISkYbnMPPqRFlsDhJxyegGfmBdolFAHdgY8BdaEe?=
 =?us-ascii?Q?dTjaIz40V4uGdHvdiHuI+AF6ThkKVilFeBtxH/YzlMPsZQu8Zs7MsWJ2W9Gf?=
 =?us-ascii?Q?NQOdGmujXj0WKjREq7HU0hUsM+etZSNGUZO2ErSPhD0oz4H+sibhavaB5Lp9?=
 =?us-ascii?Q?8u3QRRDpujuAKXviUo2g1jNiN2q1CDTHthwCGPs75MJ0IhcutvuCPirtPGFS?=
 =?us-ascii?Q?xpEfs6KZeWkdpzI9T+d/kmGABjmzyIXwQ1aQ/GfK42dTY2S89uAlSq6URnD8?=
 =?us-ascii?Q?Dz3boV4avCYr82Vydxu6ShqH+q9ySfjSxmc67tX8nEr6x67Cp2T+D+UzzC68?=
 =?us-ascii?Q?osbQjtKSDZSuLhNzBwvaXnLrMKaij6kh4MDqcvqVRUKkC2N/n38KTTXBVkmT?=
 =?us-ascii?Q?At0fpZCjk0GJEwckREMtZp+vwTaTFeprEOQGak6LAagKYHZn193s6buXZ7Ag?=
 =?us-ascii?Q?6PcqdsMnlYn8H5ZdE6CWeQX2FN3ot/7jSqm+SSFfe/a+9WlwiPsTODGgj1mY?=
 =?us-ascii?Q?mUXnGVmwyhumwNAAhw0rxvAJeSZCWvj2hdDrZvXQPZ1kJc/2O22pPPVyfr0N?=
 =?us-ascii?Q?kevYy2q4U3kovSvTUOkUWcVIdtk8n2rrNQGhMoNS0wgTuHLTcUqYPDsvK4aj?=
 =?us-ascii?Q?1Qme3zP9Z+YENGz5QJd1uhEEe7ehHO2mwsHTh+JXoQ691+Q69M0ne3Y9HOoq?=
 =?us-ascii?Q?3+pTyFoYq8anNqpqqx4bVGb+JEKbrWZ4GCo7wGXz6Q5L/65MYZXGM02JlHc9?=
 =?us-ascii?Q?Zc4kqVqkbg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 021f2cad-4f30-4526-e567-08de74abad44
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 20:23:03.1215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QyBWFOSwpI4V5zS/ujOvCuhMmTwuMyVcXA/ZBcrRnVGZSWsgVvfYrJd1j9VMnLR6N9t920Uj5478B9qZoIuVHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7172

On Wed, Feb 25, 2026 at 06:03:25PM +0100, Niklas Cassel wrote:
> From: Koichiro Den <den@valinux.co.jp>
>
> Some endpoint controllers expose platform-owned, fixed register windows
> within a BAR that EPF drivers must not reprogram (e.g. a BAR marked
> BAR_RESERVED). Even in that case, EPF drivers may need to reference a
> well-defined subset of that BAR, e.g. to reuse an integrated DMA
> controller MMIO window as a doorbell target.
>
> Introduce struct pci_epc_bar_rsvd_region and extend struct
> pci_epc_bar_desc so EPC drivers can advertise such fixed subregions in a
> controller-agnostic way.
>
> No functional change for existing users.
>
> Tested-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  include/linux/pci-epc.h | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index c22f8a6cf9a3..f7f48f43d370 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -203,6 +203,30 @@ enum pci_epc_bar_type {
>  	BAR_64BIT_UPPER,
>  };
>
> +/**
> + * enum pci_epc_bar_rsvd_region_type - type of a fixed subregion behind a BAR
> + * @PCI_EPC_BAR_RSVD_DMA_CTRL_MMIO: Integrated DMA controller MMIO window
> + *
> + * BARs marked BAR_RESERVED are owned by the SoC/EPC hardware and must not be
> + * reprogrammed by EPF drivers. Some of them still expose fixed subregions that
> + * EPFs may want to reference (e.g. embedded doorbell fallback).
> + */
> +enum pci_epc_bar_rsvd_region_type {
> +	PCI_EPC_BAR_RSVD_DMA_CTRL_MMIO = 0,
> +};
> +
> +/**
> + * struct pci_epc_bar_rsvd_region - fixed subregion behind a BAR
> + * @type: reserved region type
> + * @offset: offset within the BAR aperture
> + * @size: size of the reserved region
> + */
> +struct pci_epc_bar_rsvd_region {
> +	enum pci_epc_bar_rsvd_region_type	type;
> +	resource_size_t				offset;
> +	resource_size_t				size;
> +};
> +
>  /**
>   * struct pci_epc_bar_desc - hardware description for a BAR
>   * @type: the type of the BAR
> @@ -216,11 +240,15 @@ enum pci_epc_bar_type {
>   *		(If BARx is a 64-bit BAR that an EPF driver is not allowed to
>   *		touch, then both BARx and BARx+1 must be set to type
>   *		BAR_RESERVED.)
> + * @nr_rsvd_regions: number of fixed subregions described for BAR_RESERVED
> + * @rsvd_regions: fixed subregions behind BAR_RESERVED
>   */
>  struct pci_epc_bar_desc {
>  	enum pci_epc_bar_type type;
>  	u64 fixed_size;
>  	bool only_64bit;
> +	u8 nr_rsvd_regions;
> +	const struct pci_epc_bar_rsvd_region *rsvd_regions;
>  };
>
>  /**
> --
> 2.53.0
>
