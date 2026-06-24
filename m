Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011030.outbound.protection.outlook.com [52.101.62.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F320D2DE70D;
	Wed, 24 Jun 2026 14:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782311606; cv=fail; b=LlfI0h0mFxoXzHG8ec65yv+q2p/AZPbDBqw1H0s3/b1/LQrICyL2/Z7lzk9vMMh094ojvxa5aNzi+sKGNhIJVYwYvX0HEopXCfcdX/ZZ1Q2o7by4ZQrguQQ/xJVK4HAwnz/j7TNt1dE4VxrgRtseX3FKy0B4EPxyR0yfW4mUEmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782311606; c=relaxed/simple;
	bh=hSFEiXkFlQoEqaV6ptRKBT/SjXsrtRBR0TLgdQ4NgVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Hc0a6k4Q//xdfRagjD/v9lqrLVO6BHNILRy1B+GeMtgzepjEf12FRxgKd9goMaxBjNnokT/ia45QWaa+1GORH/ivGdIY3qf1zbswqONUiPJH8FcI8pWPEa8k2kYdFRq5lLDRqdOsUxMRs3QGoQ21ChtHSH4mAg4+7VJKRLdz+Ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DtSVygiV; arc=fail smtp.client-ip=52.101.62.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DtSVygiV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dv0P1qI8pM0lfj8Cv/1On67+bhOjTScS6CBl5pZm51K6oseha4LfDfG8cChtWJWrAwJwkdRdYU90HXrBI5O2D98AN7fIxobzLTN5dCPhPJnTfqcWSFeCnD25BNnIDyIlTgGlGvaIHVIybC5HcXHv4dY9hto5tyuETGuIeEUazLiGIBfmGfFbgObe7b0ufiPqjalQkuJdVEqiNOjAy7Du+5KTA/wXR+pxFTApLPJbDJmcRPrZEUBOkCrdK8FwDymdB0+FhwPZ5dQTQJF0XCYzaVqBXreQvxBh3MsUuPh3oNksezRtiUuAgsWqjLwEYsImawKQXJr0lDafwkzyoT0KCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3jxhU9hI8NRA64aISPTQOrdcz3lAfxz8OF33PTl3Bco=;
 b=PXJ+uLkRGh148w3HKorUs+uDvoSTOMZF9nIYX0TxYlYOLsuZJWiYb7DJWPSx95Sm6gyVehmeoDyEz2NpBnNqvqaiG36SEZ01oKBaDxaapn9jOuvKmEUsQvp4LKOMGAsMIWbRxArk7lw4ewg+Gt65L/HCg0VrIgOdOunRk3btW1t0O1ZnxHb0SEqZ8RDRPf5zowgn1+BOvS95FJxPirz2dRILR/Xto2Vod3cBiRMWkGBUAp6n9xx7dCXH0TR0mTmrMhj3IUYqxwILAnMOvHCrJCAZhecTw2w1d6v79Pcz0U8jbIpy8Tv7JLTYdtYRT5ja1ng7kLBA/4A6Q/aZtuMpSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jxhU9hI8NRA64aISPTQOrdcz3lAfxz8OF33PTl3Bco=;
 b=DtSVygiV+6gKNCpHd3MrWNoQQKI5aMMhVbvtFy/yKMX4YDrFDGJKFJjAFijqn52Typ3rEwCPggwJd2JlWJ6QKBffHJbyVI9HSKzi1msypPGNknHdTbQoP19tTm64bbPnR9V/SOTlYAOwCyQ2Cer6MFQ3fi+9GkRK0x1CeIHNRHdrgompPXAyU7ijVBf8EV2xT4ZkeK7erEjkXFamwYXzaGUllBWvNIiMbXLUho+Q41eDdmPbuI0at8FFaeGtvEhdr/GkTUaI75YPr1gWfNq//6CuUrBXdKsv/JyawrhWXihDNuk9yWxPYizS/xs6wXCSJsAP7e+0dl75L0kM+YnGCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW2PR12MB2380.namprd12.prod.outlook.com (2603:10b6:907:4::32)
 by IA1PR12MB6044.namprd12.prod.outlook.com (2603:10b6:208:3d4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Wed, 24 Jun
 2026 14:33:19 +0000
Received: from MW2PR12MB2380.namprd12.prod.outlook.com
 ([fe80::90d:c5c:6a5e:94a5]) by MW2PR12MB2380.namprd12.prod.outlook.com
 ([fe80::90d:c5c:6a5e:94a5%6]) with mapi id 15.21.0159.013; Wed, 24 Jun 2026
 14:33:19 +0000
Date: Wed, 24 Jun 2026 22:33:09 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>, 
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, vsethi@nvidia.com, alwilliamson@nvidia.com, 
	Dan Williams <danwilliams@nvidia.com>, Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>, 
	Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, 
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v7 05/11] cxl: Add CXL Device Reset helper
Message-ID: <ajvp6riIYkNYIiVs@MWDK4CY14F>
References: <20260623032453.3404772-1-smadhavan@nvidia.com>
 <20260623032453.3404772-6-smadhavan@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623032453.3404772-6-smadhavan@nvidia.com>
X-ClientProxiedBy: SI2PR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:4:197::18) To MW2PR12MB2380.namprd12.prod.outlook.com
 (2603:10b6:907:4::32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2380:EE_|IA1PR12MB6044:EE_
X-MS-Office365-Filtering-Correlation-Id: bce2122e-d4f7-43c5-1853-08ded1fd87d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|22082099003|18002099003|4143699003|5023799004|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	SMALstwLa+g6iPiWubTHKHAeqMJgSJP1XL0e38y7hvF+BoNApFHjyKp3P5DuhWL6h9jeTVrfCpiD/D0/qr5cFxj814Nlv9Bss+93nj7NHtmiQZwyMUKhxB18h0Y7vppceEY2pb9xIaClnSZrDi1mg/xGL5DY74XKEOm+7q/of13d7zEFiK+9rRz/OYzzy41sdjldmYB3dymq/1H17d1VHtlmuAo5/fbOAhPZVymMMRdI/WW4CYOLy0y2waLYsNDgRTow7Gsl5SkgNWIUT0JxsErktb2asAqrOqLYYVtM5ITYuVImBnrw5L1Kg12eLu83BSonXpwIHzRDSP96d4Ex3WZWiyt3dDFlanjZbfmhvbFkH3Vv8EGnBkDjW2UDPnJUaejewwcyT+Ty/VVJqS2CewiWRwbeMz+6//oSmHfd+zuHksXh6Hf89j6ms3rZyHP2bMXT6ujpDcTjsfIIITaEc317VJTADT+r+aFbHIs6M6OIdOvTVIks4OswM3ocj/ZR/ZMrueZL6gFsL2bwVnHOB1xKxs3EeghTyKXbW0xPmB0R+AXTK6KanWkfUAX7KR2CoUWNfatf3Kn/vaRTPUwPGfG1NKcPIyNpK08F86KDY3Gv4XWHGM/oVJN13UiNolP0w2s1lZyrxMRegUVNbGs6YVP9zNJvFUD0LyHAr4UWeFk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2380.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(22082099003)(18002099003)(4143699003)(5023799004)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?opX3+h/V2gymQ1IZFV0vQozy85hOXEEi5GgdsXHJ+FtSfcc3t9vrDM9R9xf9?=
 =?us-ascii?Q?5l5D88uKWUx3WS3gSl6/9aIy11MqyM9d5qPt4y9cV9WINdEBqBvCe70N7nOE?=
 =?us-ascii?Q?X5brF5O3QyvAP3YxW8qZu3b6DvLYSbSFD1krY5oi0doeGve/Vlsq3VsAvZk/?=
 =?us-ascii?Q?r5vJDRenIcNAXZUXgWfsSyMS1lAhWjUSOao1+0L0Bjzbzg6s3UeBbWJc1UwG?=
 =?us-ascii?Q?pHvegeaDJ3BQu9jD+2WPPJQTfPwbwmyjpH3Zw7YRH+ans9IaUENz7Hg15R2m?=
 =?us-ascii?Q?QPxRTdw1zQYf7S5HZ8A02E3SOKcOldr6qPdXYBMo91uKygLs41wzmzlJJfCB?=
 =?us-ascii?Q?KrI0hnAiXYmsUTV5zcrAyh3NuFLRWDawW5K19UDctzuXCWXoiZD3Fox8/ydR?=
 =?us-ascii?Q?ViR85T29kutlR0mhoSMLP28l5jGGZoRJQ9QZBRHh9lML1AozMowjR7oAt8RY?=
 =?us-ascii?Q?RJECbrrDLk39fPwVmR5T++x3s4P6wb5i9ACR6DtEu9QfVrK9h8bXWZAu6HM2?=
 =?us-ascii?Q?+V5Jv3rBjcv3oEAbG0vW4QuyGfCxqslEcybK5PrhZt7sP9yNB4vlj4nEfv29?=
 =?us-ascii?Q?l8WaAbfp9agDY6+NTO4aS9uuKXs+AQsimkEmXwSK00HHUFQuODHCUEY8jJbV?=
 =?us-ascii?Q?DjIPYm1yKhqCdiSwUHBSrhnWhDmQuBlUaPbOdtvSiOMw7XqYQH0oAneA3rl5?=
 =?us-ascii?Q?svtyLOi74QS495nA0F6SbSqhVDzj9haOxIEbmJ8tbJZUK4OKDXC8nH+Vh0Od?=
 =?us-ascii?Q?eJu4jPOj5Ab3ZIg+5QkF5IlTt5N26qVSOSLsY3WBYUSpLWkLunHoWDQiEO69?=
 =?us-ascii?Q?sKoZDXMxiYMZm2UPW43jAVqDWAmLyqoSj+MKmZOX9cC9fxYU2+zDVHuskSte?=
 =?us-ascii?Q?iSLM22SQpvv4G+z9bWlYDCLdqeqYoidNtSG3syDOikuhoQRUARz5UHYqoyH2?=
 =?us-ascii?Q?jj4wrWYEv5yt6UF8/IlOz7rAxU3XwCIbdu4iLfEnrC4P1dPT0xQG/hg6GVrg?=
 =?us-ascii?Q?fiAD57NpD4z4A13tZaZgXK+zoQ6NNrYF+/r6sZc9jBrJjN+L8c00wC9B2ntq?=
 =?us-ascii?Q?pir/ry6gdr2Fzqlke4hszXqPMG3M15fCHKQhwMzbb38ytPpFMFD/vZw8GZK4?=
 =?us-ascii?Q?a3M2PDaEZcQ4cyP5T0ouXVrEM/e8i+nwTNr3W4ffj1nXC9Vp8YVDZSXvlnTl?=
 =?us-ascii?Q?WnKGDPGTvcRBDH30RMHhHzHSVa3MeoMlWcgjVFfh5LPbbrhz32Fea0vdsqe5?=
 =?us-ascii?Q?i2EJH0NOjI68Zm6yWfUrDmLZ2U0rKFQz0d6RvNQued/Blyip67048mc1gqPd?=
 =?us-ascii?Q?Xql7AFxwfm1afGbjLe1CZ9aVQgdbaM/wXynEMJkVYYJNj6LazrIJiOgw6rag?=
 =?us-ascii?Q?o2I1aJxIJ4I7xd97HaYNRTiSoRosafDJ9zviS+tZUGpZGZmpAz1pQUynrrHN?=
 =?us-ascii?Q?gccWyd7jT/OKdGcoCgh4jCy4Qbq0OMyjhSArI0cJDJtKTAfGOYOkDn13S13C?=
 =?us-ascii?Q?jJHIcTD05OpnFhNZfCv7s+X4lMyh3fU0W6KGlRMaxKEY6m7fZI/1XSitEaay?=
 =?us-ascii?Q?nAoGuETgbDw+htzURKATDX4Ta/UyWX9E/t2lZobYXoT1pfJ7UUFGkn9X4Kag?=
 =?us-ascii?Q?L/bx301/rvtytlAUd02yQO/GwvXx86Zjj5Sa2aCqmI3MSLnqkQcOw1EdV8c6?=
 =?us-ascii?Q?JdBBLiJEQCxEjnAyjBXRYrhUEKyBG3XvgvoiMEXElmShB/Zhgl0RjQRlmHnK?=
 =?us-ascii?Q?Il4eh3guNg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bce2122e-d4f7-43c5-1853-08ded1fd87d6
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2380.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 14:33:18.3955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X7emadCwnfSZZ1rwCZV1HSm6PkXWQBqY94C5d2Mf0lXzkRM68wl/Ri0STsYUs86L/rHPNJsVtc+Uz+B2WCH+YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6044

On Tue, Jun 23, 2026 at 03:24:47AM +0800, Srirangan Madhavan wrote:
> Add an internal CXL Device Reset helper for Type 2 functions that advertise
> CXL Reset in the CXL Device DVSEC. The helper disables CXL.cache, performs
> cache writeback when supported, initiates reset with Memory Clear disabled,
> waits for completion, and re-enables CXL.cache on exit.
> 
> Leave the helper unregistered until range validation and reset-scope
> coordination are in place.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/reset.c      | 221 ++++++++++++++++++++++++++++++++++
>  include/cxl/cxl.h             |   7 ++
>  include/uapi/linux/pci_regs.h |  14 +++
>  3 files changed, 242 insertions(+)
> 
> diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
> index fc52d3abdb5b..fdfcc9e825e0 100644
> --- a/drivers/cxl/core/reset.c
> +++ b/drivers/cxl/core/reset.c
> @@ -7,6 +7,8 @@
>  #include <linux/export.h>
>  #include <linux/io.h>
>  #include <linux/ioport.h>
> +#include <linux/iommu.h>
> +#include <linux/jiffies.h>
>  #include <linux/kernel.h>
>  #include <linux/pci.h>
>  #include <linux/slab.h>
> @@ -318,3 +320,222 @@ int pci_cxl_hdm_init(struct pci_dev *pdev)
>  	cxl_pci_hdm_unmap(pdev, &regs, &map);
>  	return rc;
>  }
> +
> +/*
> + * CXL r4.0 sec 9.7.2 defines the reset completion timeout encodings.
> + * Sec 9.7.3 leaves config-space access behavior undefined for 100 ms after
> + * initiating CXL Reset, then limits software to CXL Status2 access until
> + * reset completion, timeout, or error.
> + */
> +#define CXL_RESET_RRS_WAIT_MS 100
> +#define CXL_RESET_STATUS_POLL_MS 20
> +static const u32 cxl_reset_timeout_ms[] = {
> +	10, 100, 1000, 10000, 100000,
> +};
> +
> +#define CXL_CACHE_WBI_TIMEOUT_US 100000
> +#define CXL_CACHE_WBI_POLL_US 100
> +
> +static int cxl_reset_dvsec(struct pci_dev *pdev)
> +{
> +	int dvsec, rc;
> +	u16 cap;
> +
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_DEVICE);
> +	if (!dvsec)
> +		return -ENOTTY;
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +
> +	if ((cap & (PCI_DVSEC_CXL_CACHE_CAPABLE |
> +		    PCI_DVSEC_CXL_MEM_CAPABLE)) !=
> +	    (PCI_DVSEC_CXL_CACHE_CAPABLE | PCI_DVSEC_CXL_MEM_CAPABLE))
> +		return -ENOTTY;
> +
> +	if (!(cap & PCI_DVSEC_CXL_RST_CAPABLE))
> +		return -ENOTTY;
> +
> +	return dvsec;
> +}
> +
> +static int cxl_reset_update_ctrl2(struct pci_dev *pdev, int dvsec, u16 set,
> +				  u16 clear)
> +{
> +	u16 ctrl2;
> +	int rc;
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, &ctrl2);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +
> +	ctrl2 |= set;
> +	ctrl2 &= ~clear;
> +
> +	rc = pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, ctrl2);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +
> +	return 0;
> +}
> +
> +static int cxl_reset_enable_cache(struct pci_dev *pdev, int dvsec)
> +{
> +	return cxl_reset_update_ctrl2(pdev, dvsec, 0,
> +				      PCI_DVSEC_CXL_DISABLE_CACHING);
> +}
> +
> +static int cxl_reset_disable_cache(struct pci_dev *pdev, int dvsec, u16 cap)
> +{
> +	int remaining_us = CXL_CACHE_WBI_TIMEOUT_US;
> +	u16 status2;
> +	int rc, rc2;
> +
> +	rc = cxl_reset_update_ctrl2(pdev, dvsec,
> +				    PCI_DVSEC_CXL_DISABLE_CACHING, 0);
> +	if (rc)
> +		return rc;
> +
> +	if (!(cap & PCI_DVSEC_CXL_CACHE_WBI_CAPABLE))
> +		return 0;
> +
> +	rc = cxl_reset_update_ctrl2(pdev, dvsec,
> +				    PCI_DVSEC_CXL_INIT_CACHE_WBI, 0);
> +	if (rc)
> +		goto err_enable_cache;
> +
> +	do {
> +		usleep_range(CXL_CACHE_WBI_POLL_US, CXL_CACHE_WBI_POLL_US + 1);
> +		remaining_us -= CXL_CACHE_WBI_POLL_US;
> +
> +		rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
> +					  &status2);
> +		if (rc) {
> +			rc = pcibios_err_to_errno(rc);
> +			goto err_enable_cache;
> +		}
> +	} while (!(status2 & PCI_DVSEC_CXL_CACHE_INV) && remaining_us > 0);
> +
> +	if (!(status2 & PCI_DVSEC_CXL_CACHE_INV)) {
> +		rc = -ETIMEDOUT;
> +		goto err_enable_cache;
> +	}
> +
> +	return 0;
> +
> +err_enable_cache:
> +	/*
> +	 * DISABLE_CACHING can be rolled back here. INIT_CACHE_WBI is
> +	 * self-clearing on completion, so leave any in-flight writeback alone.
> +	 */
> +	rc2 = cxl_reset_enable_cache(pdev, dvsec);
> +	if (rc2)
> +		pci_warn(pdev, "failed to re-enable CXL caching: %d\n", rc2);
> +	return rc;
> +}
> +
> +static int cxl_reset_wait_done(struct pci_dev *pdev, int dvsec, u16 cap)
> +{
> +	unsigned long deadline;
> +	u32 timeout_ms;
> +	u16 status2;
> +	int idx, rc;
> +
> +	idx = FIELD_GET(PCI_DVSEC_CXL_RST_TIMEOUT, cap);
> +	if (idx >= ARRAY_SIZE(cxl_reset_timeout_ms)) {
> +		int last = ARRAY_SIZE(cxl_reset_timeout_ms) - 1;
> +
> +		pci_warn(pdev,
> +			 "unknown CXL reset timeout encoding %d; using %u ms\n",
> +			 idx, cxl_reset_timeout_ms[last]);
> +		idx = last;
> +	}
> +
> +	timeout_ms = max_t(u32, cxl_reset_timeout_ms[idx],
> +			   CXL_RESET_RRS_WAIT_MS);
> +	deadline = jiffies + msecs_to_jiffies(timeout_ms);
> +	msleep(CXL_RESET_RRS_WAIT_MS);
> +
> +	do {
> +		rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
> +					  &status2);
> +		if (rc)
> +			return pcibios_err_to_errno(rc);
> +
> +		if (status2 & PCI_DVSEC_CXL_RST_ERR)
> +			return -EIO;
> +

I think this returns -EIO for a reset that actually succeeds.

During the post-reset RRS window the Status2 read comes back 0xffff.
0xffff has bit 2 set, so it's taken as RST_ERR and we bail on the very
first poll. A transient config-read error is likewise treated as fatal instead
of being retried.

I would suggest to skip all-ones reads as "not ready" and keep polling until
the deadline, only act on RST_ERR and RST_DONE from a valid read.

Best regards,
Richard Cheng

> +		if (status2 & PCI_DVSEC_CXL_RST_DONE)
> +			return 0;
> +
> +		if (time_after_eq(jiffies, deadline))
> +			return -ETIMEDOUT;
> +
> +		msleep(CXL_RESET_STATUS_POLL_MS);
> +	} while (true);
> +}
> +
> +static int cxl_reset_execute(struct pci_dev *pdev, int dvsec)
> +{
> +	bool cache_disabled = false;
> +	u16 cap;
> +	int rc;
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +
> +	if (!pci_wait_for_pending_transaction(pdev))
> +		pci_err(pdev, "timed out waiting for pending transactions\n");
> +
> +	rc = pci_dev_reset_iommu_prepare(pdev);
> +	if (rc) {
> +		pci_err(pdev, "failed to stop IOMMU for CXL reset: %d\n", rc);
> +		return rc;
> +	}
> +
> +	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
> +	if (rc)
> +		goto out;
> +	cache_disabled = true;
> +
> +	rc = cxl_reset_update_ctrl2(pdev, dvsec, PCI_DVSEC_CXL_INIT_CXL_RST,
> +				    PCI_DVSEC_CXL_RST_MEM_CLR_EN);
> +	if (rc)
> +		goto out;
> +
> +	rc = cxl_reset_wait_done(pdev, dvsec, cap);
> +	if (rc)
> +		goto out;
> +
> +out:
> +	if (cache_disabled) {
> +		int rc2;
> +
> +		rc2 = cxl_reset_enable_cache(pdev, dvsec);
> +		if (rc2 && rc)
> +			pci_warn(pdev, "failed to re-enable CXL caching: %d\n",
> +				 rc2);
> +		else if (rc2)
> +			rc = rc2;
> +	}
> +
> +	pci_dev_reset_iommu_done(pdev);
> +	return rc;
> +}
> +
> +int cxl_reset_function(struct pci_dev *pdev, bool probe)
> +{
> +	int dvsec;
> +
> +	dvsec = cxl_reset_dvsec(pdev);
> +	if (dvsec < 0)
> +		return dvsec;
> +
> +	if (probe)
> +		return 0;
> +
> +	return cxl_reset_execute(pdev, dvsec);
> +}
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index e3087b7517e8..1fe606f15733 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -9,6 +9,7 @@
>  #include <linux/node.h>
>  #include <linux/ioport.h>
>  #include <linux/range.h>
> +#include <linux/errno.h>
>  #include <cxl/mailbox.h>
>  
>  /**
> @@ -137,11 +138,17 @@ struct cxl_hdm_info {
>  int cxl_commit(struct cxl_decoder_settings *settings, void __iomem *hdm);
>  #ifdef CONFIG_CXL_HDM
>  int pci_cxl_hdm_init(struct pci_dev *pdev);
> +int cxl_reset_function(struct pci_dev *pdev, bool probe);
>  #else
>  static inline int pci_cxl_hdm_init(struct pci_dev *pdev)
>  {
>  	return -ENOTTY;
>  }
> +
> +static inline int cxl_reset_function(struct pci_dev *pdev, bool probe)
> +{
> +	return -ENOTTY;
> +}
>  #endif
>  
>  struct cxl_reg_map {
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 14f634ab9350..194ae56b4404 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1349,10 +1349,24 @@
>  /* CXL r4.0, 8.1.3: PCIe DVSEC for CXL Device */
>  #define PCI_DVSEC_CXL_DEVICE				0
>  #define  PCI_DVSEC_CXL_CAP				0xA
> +#define   PCI_DVSEC_CXL_CACHE_CAPABLE			_BITUL(0)
>  #define   PCI_DVSEC_CXL_MEM_CAPABLE			_BITUL(2)
>  #define   PCI_DVSEC_CXL_HDM_COUNT			__GENMASK(5, 4)
> +#define   PCI_DVSEC_CXL_CACHE_WBI_CAPABLE		_BITUL(6)
> +#define   PCI_DVSEC_CXL_RST_CAPABLE			_BITUL(7)
> +#define   PCI_DVSEC_CXL_RST_TIMEOUT			__GENMASK(10, 8)
> +#define   PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE		_BITUL(11)
>  #define  PCI_DVSEC_CXL_CTRL				0xC
>  #define   PCI_DVSEC_CXL_MEM_ENABLE			_BITUL(2)
> +#define  PCI_DVSEC_CXL_CTRL2				0x10
> +#define   PCI_DVSEC_CXL_DISABLE_CACHING			_BITUL(0)
> +#define   PCI_DVSEC_CXL_INIT_CACHE_WBI			_BITUL(1)
> +#define   PCI_DVSEC_CXL_INIT_CXL_RST			_BITUL(2)
> +#define   PCI_DVSEC_CXL_RST_MEM_CLR_EN			_BITUL(3)
> +#define  PCI_DVSEC_CXL_STATUS2				0x12
> +#define   PCI_DVSEC_CXL_CACHE_INV			_BITUL(0)
> +#define   PCI_DVSEC_CXL_RST_DONE			_BITUL(1)
> +#define   PCI_DVSEC_CXL_RST_ERR			_BITUL(2)
>  #define  PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i)		(0x18 + (i * 0x10))
>  #define  PCI_DVSEC_CXL_RANGE_SIZE_LOW(i)		(0x1C + (i * 0x10))
>  #define   PCI_DVSEC_CXL_MEM_INFO_VALID			_BITUL(0)
> -- 
> 2.43.0
> 
