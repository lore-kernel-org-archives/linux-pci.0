Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010067.outbound.protection.outlook.com [52.101.69.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC6C3932C3;
	Thu,  6 Aug 2026 18:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786041876; cv=fail; b=ji41w9fzT/sv/igmV+5TF8YlpfCE+EgO4afyYhA4NAVmFxo/JTa4uCCfxYfbHwB3ONfzb8Kxx9sdrPVlh2jVFJYKUGir60Yj+IPL053zWyTgHz5VHDApvcRbSNM0vskeImZFK2iCho8OS8hyfRcY+e1hxCLPQADxNPrK72ls3X4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786041876; c=relaxed/simple;
	bh=2vrd8uQ7UBUipTJjTAnoD90VX6TugDO4nzxsnMjaVWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HhfV8XQhYxjNYGlKEzD10qFAYpsivukFszgXLWtj7mQ+gs9B2yaGloOU8rlEhRziVfUZF9WARRuMRAypAwlQGfpqndYlu2NgdmGxn2MqDffoi0nvV8yyo+4yWrF0j4Oa2d3spRkCry77avNhC5UwwHqjsBCgX5QfX7U4t7/yud4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=EZd0eIdQ; arc=fail smtp.client-ip=52.101.69.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EZd0eIdQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZGIazv8P5mf4yiISPqv8v/DJAnuMVHe/8XWGPPjg09PSATBPW4XNJywEE0HmXlpRvYIkRAMHpKOmz7zShzgfZdgI6ufuuu0Wl9QSdQzjuqSTSuZF0cE40Elbn0fhhUYC1S4ueJbNQttDPlEWdbxGqCp15bx1a0yzYVIYhbJtWlk+LYDxUwGz5DuEV5MfUNXYcCle7ZjoF9hrkjDtdBsbYBlVlDqt70+R5ibdpxFeboWToNu34R8VENxOC77C4Kilk548mTVfP6suGdw3G0XZgrEIMTYT1CJGn8kqfoWbs2kJgrwP0V5Y4Ei+tJWA+6OqRJYBTHxU+9enyZovHfGP9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIAz4+4a3yXra0spQ7Hl6yw8eqM7q5MQtBgU/jBJ0B8=;
 b=zL1jvrqsJMnYOkrN/EV1sIqdXjH24xwTQYClsfKKPhmyc8MEm15heUVArz3vyr1pHMu+4JdoV9vU4Oj5fRLXEpzq3Y2JzafFgdmoeMbkBSfrvh5Hor/usVau/8OaIzh/4EC2X7d1/xau3tYOFfNyss1TiuMbzdKU5OkaWj+S8wFapQGThpa76GEXjF5nSpwxUR7rZ65uSFK4mja3m0fyilc9JDjrX/CgX4meM8LSMxWiPgp+A9Q6V5D6HdOSMu/ILj+uV15oJ/q24VwABWxizvQp28i2ziUIeZhaofgwE2R5h5UJqvwm7ap6rF7DhTfnpY/J1IHirz6SCIteP0lEEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIAz4+4a3yXra0spQ7Hl6yw8eqM7q5MQtBgU/jBJ0B8=;
 b=EZd0eIdQvzs28LUSw/sq7BoALj+Q8QMDdUL7WadvBGHq53XNKRa5Fg4fYS8PJNVrEbQHCGPYtj6TTV0UzANXxtTBjca4/5UB4GhM/PnuayAWiFX2PumJTOy7pDOZnIcKxBa5xid5ZGNYeAkjQXUk9RwOnHqRLNZqtpRoQPgXtLZFxPf74Adw8QoOBOfFyk0QkHR40oP1X1i5C0AiIBy0q87t7XR4YuGSLHhLm+huc5KoCPSK1kRAAkkgnjHiPHRFRdZzLKAWkOFjUUjpG3cyf7fi3UqkHl9d5vBXK8DqOMT03TB+o+23hwOKJxalYaab6oUkrGcrawRD4I/x+Fm/mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB10589.eurprd04.prod.outlook.com (2603:10a6:800:25f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 18:44:31 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 18:44:31 +0000
Date: Thu, 6 Aug 2026 14:44:22 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: alexandre.belloni@bootlin.com, Frank.Li@nxp.com, akhilrajeev@nvidia.com,
	mukesh.savaliya@oss.qualcomm.com, rafael@kernel.org,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH V4 13/14] i3c: mipi-i3c-hci: Factor out i3c_hci_sysdev()
Message-ID: <anTWBk_Z4p9FhkOg@lizhi-Precision-Tower-5810>
References: <20260806131857.119830-1-adrian.hunter@intel.com>
 <20260806131857.119830-14-adrian.hunter@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806131857.119830-14-adrian.hunter@intel.com>
X-ClientProxiedBy: PH7P220CA0071.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32c::33) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB10589:EE_
X-MS-Office365-Filtering-Correlation-Id: 39acf51b-8f9c-47b9-fa83-08def3eac089
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|19092799006|22082099003|18002099003|11063799006|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	Yt2/JJ7VxfLOCzcTBnZe0lbSatoeBZSeZZR796YwjgMDgoxlqKdRT3gyc7bWLVrCIV15QKZt3P8WwQAVE9mlcHNPwi9zz/vRdWJBkh9I3JM9ttiiGXNS5tflK0N+YmGh3UHQpq542FHjzHCM5Djg+jq23ObwxN0z1mSbW6NcDwelEYn847m1lrTE0iOtsdfO+YvSuoW2WlccBvUKdIQyjbiqj0JWsEW15+k3zSJKo1GEf9Sy0nMj2839dyrAWjFqY8ZXqVzDgkOQ00/Nj47+ox7ppy+QO5nIDQqjaP1/dgFMRGWXpszdIgy6sg1m7GBxrKd72Ulyc1yVyno096QxqprVZ0p3oElEHXTlJwwvhocxTYPLYYnq6DwDongecBqD4xE4zRKZswBcrSZJ1MRi+o6OgrabKdEB4WujXChunyxByYSOtsMRK78yZ3o87SZX50HrfjxZqMfTDBoZEnj00EcAYGy4jNAqaJxw9CTzF51APVw3+XL9vT/rfvwcsoJWJkPjMcDloR6FdBzVPEZLb97lOCvPC3hN7u2KJZks6H41iZIB3kLkz2LascY/hARj1SOBNcWi1DvWebLFCTEjq2dLk7eMBjvz8alpqnpgElo6hT1uubULNOG6dO8xuetRVWvtDHoiIQ6it4RGPvjN7RH5xB7owEaOHudvIIEps5E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(19092799006)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MHGaMqGSBm+NBN2XV+qg6In39/6pRi6IN2wM0x51IE2XtAEXpcXr+wP6478Q?=
 =?us-ascii?Q?0eOISyz6ZFou5D7C3axBUvzR8/onfLVydEa3Xkun4s2zJ6szeqFLXmt7iGtx?=
 =?us-ascii?Q?pO65EuR0c6V2nYPpxucVSNw0AQTW1hH7PTQWx0epjMhwDT33yhVTB3mBLbyI?=
 =?us-ascii?Q?lXxkALI4uf9DofaRElJ13G6P7c+HgP4US+zcp9vb8spMVtr2GEKCL96VL1h2?=
 =?us-ascii?Q?eHlm4nYZTgZKAJHj534dw6nQ+lH723SwafOUaUv52m0CNuUoqpXaYqPCIObT?=
 =?us-ascii?Q?ShOvhRnaQXZ4dv4ToQ/p+P837umo7ZIbStTw+mqeM+qj40cBPIQ46GIl/n8M?=
 =?us-ascii?Q?YTCCtS574ABjT31Bh3bdNp2OJMoaHuETvFJhTjEzYN3CwIr4gkHCJYFjHpAB?=
 =?us-ascii?Q?YPgfxJ/BOk6eRP9JjK+wc/w+0+XfB+Uuz1bjuIdG3xhlBpewkkElaY5CpVTA?=
 =?us-ascii?Q?a3qoc9KpIldFCzyncZWpCNpbexv9YIbk4F+WNbxWmLAwX+QfypA7J+wAiIUh?=
 =?us-ascii?Q?PFxo3jayy717LbgZJa1TsnjoVzUzGkP7qDTv3xQ4eJ8uJbvsgz+VP7JyGihN?=
 =?us-ascii?Q?UVf7dRzLiFLDNSvnUHc8+JGcYd5UlXeqG9RLQtpMSRfKQeqkTIq04yxHUcDV?=
 =?us-ascii?Q?+twdv5TpQ0ADWyql/6/eTa9VEEozy11BumQy50E1tGZnLHfckBq/yIH9xBgt?=
 =?us-ascii?Q?59YlzMF1P/LFl5ZlvIm51sLwT4epW0BeL80JVQpVxb9CE4N0PIML7BF/hkDu?=
 =?us-ascii?Q?2QnVcA5DikXBwDHdbAPkWgHs+BytF+NSkhpjMkp2aR9iLhFh/9m+lSZ7W//I?=
 =?us-ascii?Q?rj4zzEUeo1vhL2HH9NT6S4GnT9ijtxK1p8Tuicyl5XHB9otIj/PYBfFyAo/d?=
 =?us-ascii?Q?w6pnT1ugn7hkV0H1kpriLNAW1V6ynzRo1yxUNshci76DoBJ7IZAWQZO+vt8k?=
 =?us-ascii?Q?LVOgYhKI4ZrGHLOJk1PSbgZ1ca1VXeJD5FZCS0mzx0xKYlg6ky8jqan7VUjH?=
 =?us-ascii?Q?/bzuM3BGCtNBjhv/KpGfJNISsC7BevKMedPPrGL2qLsTvaacmg0F0KY4AmGn?=
 =?us-ascii?Q?hEGfpDEbjz9JT1DYL6A5nNeqIyPQ850I/VygfShLTBZ533nNAbYNCuu7mD/7?=
 =?us-ascii?Q?1BBv+G4doUPhqpB5quKAvItAuv2SoGzaNPdDTjZ/ZTafOVJtsVXpEGXdTzLx?=
 =?us-ascii?Q?6+X3YoIdruFr8v9VoeOpfMB2yJuTTtulZPxnz+TbMLsgx4aWyOireY+X5ZTG?=
 =?us-ascii?Q?5nMWMiI7dWP3eBZta7HrZAx1/XqjA3v4KIoSdnZyT1FjWKhbBdzK8QeUBUyB?=
 =?us-ascii?Q?UT9CRBwGpPBenoaz+SCejeIvjG1xL9dHdocoQJkqMejAQgm6EetggKLFlFtL?=
 =?us-ascii?Q?qcaH1mvguyZWVs1nXnE9N4Wpv+2gUYAa8BCoKcBfPM5kimUocughgNGWw8Vp?=
 =?us-ascii?Q?Bd9OJfs6o7bJo4kb/6EfovMVx5ZMipnInBZ9xzPMHkQ8O3clxOrJPnNwBdaN?=
 =?us-ascii?Q?uW/gDq6+KTzyLwJ/IbMOUXOUmtixULudmHYCgGbBw5RGtH16KugEg0gFXFwA?=
 =?us-ascii?Q?cWiGn2GlSmCFxtuLNTEqo9QjCGDgChmyB+keWEziT83fQmPbP7PLG95Hzzov?=
 =?us-ascii?Q?jCK8PYjkIw99cXnrEgs+NTUes6pPvM1fKNsSOZaplIPrv9g6kmHElKLPt/6o?=
 =?us-ascii?Q?Ypj29A5+zpxvsGZOVqDU8W9wFFyxBKJa4ZBZkxs+gI5T9/F3SO3YFCTCPvMm?=
 =?us-ascii?Q?H9CvwyQcD217dpwGXuO0YwmJW6JdvoP9TXT2ObvG5c68Jd92BbPu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39acf51b-8f9c-47b9-fa83-08def3eac089
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 18:44:31.2904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLZy2xcGXZt0Y43Xb4N40qi9FItv8VOw0ZKloCFYiPziLIgOyCXroaF8kMHnO/HFZ8HPs3tNwReX/dUYf3I2rKsIePsLsf4t9zy7SDAcY80JtzZFOeLYM3f2DU3YLWxy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10589

On Thu, Aug 06, 2026 at 04:18:56PM +0300, Adrian Hunter wrote:
> The MIPI I3C HCI driver needs to identify the underlying system device
> used for DMA mapping and PM operations. The logic for determining that
> device is currently embedded in the DMA implementation.
>
> Factor this code out into i3c_hci_sysdev() so it can be shared by other
> parts of the driver and keep the device-selection logic in one place.
>
> The explanatory comment moves with the code, reworked as kernel-doc now
> that it documents a function rather than an inline block.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
>
> Changes in V4:
>
> 	Reworked the comment that moves with the code into kernel-doc,
> 	and mentioned that in the commit message.
>
> Changes in V2 and V3:
>
> 	None
>
>
>  drivers/i3c/master/mipi-i3c-hci/core.c | 16 ++++++++++++++++
>  drivers/i3c/master/mipi-i3c-hci/dma.c  | 15 +--------------
>  drivers/i3c/master/mipi-i3c-hci/hci.h  |  2 ++
>  3 files changed, 19 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
> index cfe9b5390b56..f95da427d7a9 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/core.c
> +++ b/drivers/i3c/master/mipi-i3c-hci/core.c
> @@ -15,6 +15,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/iopoll.h>
>  #include <linux/module.h>
> +#include <linux/pci.h>
>  #include <linux/platform_data/mipi-i3c-hci.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> @@ -117,6 +118,21 @@ static inline struct i3c_hci *to_i3c_hci(struct i3c_master_controller *m)
>  	return container_of(m, struct i3c_hci, master);
>  }
>
> +/**
> + * i3c_hci_sysdev() - Get the device to use for DMA
> + * @dev: Device the HCI controller is bound to
> + *
> + * When an IOMMU is enabled, DMA API calls must use the device that IOMMU
> + * setup was done for.  Under PCI enumeration that is the PCI device, not
> + * the "mipi-i3c-hci" platform device below it.
> + *
> + * Return: @dev's parent if it is a PCI device, otherwise @dev.
> + */
> +struct device *i3c_hci_sysdev(struct device *dev)
> +{
> +	return dev->parent && dev_is_pci(dev->parent) ? dev->parent : dev;
> +}
> +
>  static void i3c_hci_set_master_dyn_addr(struct i3c_hci *hci)
>  {
>  	reg_write(MASTER_DEVICE_ADDR,
> diff --git a/drivers/i3c/master/mipi-i3c-hci/dma.c b/drivers/i3c/master/mipi-i3c-hci/dma.c
> index 0672ed1132f8..7c2b20474130 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/dma.c
> +++ b/drivers/i3c/master/mipi-i3c-hci/dma.c
> @@ -15,7 +15,6 @@
>  #include <linux/errno.h>
>  #include <linux/i3c/master.h>
>  #include <linux/io.h>
> -#include <linux/pci.h>
>
>  #include "hci.h"
>  #include "cmd.h"
> @@ -301,23 +300,11 @@ static int hci_dma_init(struct i3c_hci *hci)
>  {
>  	struct hci_rings_data *rings;
>  	struct hci_rh_data *rh;
> -	struct device *sysdev;
>  	u32 regval;
>  	unsigned int i, nr_rings, xfers_sz, resps_sz;
>  	unsigned int ibi_status_ring_sz, ibi_data_ring_sz;
>  	int ret;
>
> -	/*
> -	 * Set pointer to a physical device that does DMA and has IOMMU setup
> -	 * done for it in case of enabled IOMMU and use it with the DMA API.
> -	 * Here such device is either
> -	 * "mipi-i3c-hci" platform device (OF/ACPI enumeration) parent or
> -	 * grandparent (PCI enumeration).
> -	 */
> -	sysdev = hci->master.dev.parent;
> -	if (sysdev->parent && dev_is_pci(sysdev->parent))
> -		sysdev = sysdev->parent;
> -
>  	regval = rhs_reg_read(CONTROL);
>  	nr_rings = FIELD_GET(MAX_HEADER_COUNT_CAP, regval);
>  	dev_dbg(&hci->master.dev, "%d DMA rings available\n", nr_rings);
> @@ -332,7 +319,7 @@ static int hci_dma_init(struct i3c_hci *hci)
>  		return -ENOMEM;
>  	hci->io_data = rings;
>  	rings->total = nr_rings;
> -	rings->sysdev = sysdev;
> +	rings->sysdev = i3c_hci_sysdev(hci->master.dev.parent);
>
>  	for (i = 0; i < rings->total; i++) {
>  		u32 offset = rhs_reg_read(RHn_OFFSET(i));
> diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
> index b3d9803b1968..b8d2a3d680f8 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/hci.h
> +++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
> @@ -184,6 +184,8 @@ void amd_set_resp_buf_thld(struct i3c_hci *hci);
>  void i3c_hci_sync_irq_inactive(struct i3c_hci *hci);
>  int i3c_hci_process_xfer(struct i3c_hci *hci, struct hci_xfer *xfer, int n);
>
> +struct device *i3c_hci_sysdev(struct device *dev);
> +
>  #define DEFAULT_AUTOSUSPEND_DELAY_MS 1000
>
>  int i3c_hci_rpm_suspend(struct device *dev);
> --
> 2.53.0
>
