Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012024.outbound.protection.outlook.com [40.107.209.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE713C1989;
	Fri, 26 Jun 2026 22:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782511748; cv=fail; b=OI6gFl00cLzYrh8kIWzcD2umloGhm+o5u4kZg/mMdZoRIsIyzHIltP2R0NeIcQGJl9JwGIdj8drRVHA0wXNgMbkBMTpRDAf12+DqxkE/2lthNEwvyFauNoTJwvyxcm7PQHihU07azMkTAqWxNSeP4REqr9imV2WKhgJruf2EFs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782511748; c=relaxed/simple;
	bh=nbKnskuh+g1fv3KBdo00c2mzrvXdBj6RqaNBnIczvZA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e/rZpsr/zL4MurKlbEsSRVU+ihz7S8wDPQXrmaeKzQrrng3n59tgEyUzmCtLmeAJsYVfYSDv/2WhS7eiUK++HcRFUElbuA0knjWCjDh7HiKKZN1OBANKqazk9uF28yCraiCpcnrbWFkscW6drGtloJIB8XA5pTTk8VhsAsD0A6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DvX6dxGr; arc=fail smtp.client-ip=40.107.209.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DvX6dxGr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXIYarYJKA0lLNPsWtnFZCtOBP+dexLIPaBGWacWzobkFYSSD9BtcKNfxJt6H1xYF6geJjbaE/3LblSboh5GrEa5MM7q+CURHhuASLMW7yFqLcJtgq44LpV2Gjjmt7jI1kplsF3DszkmcC8uDaf/tTJ/zndb7vXH1EKzweIHYtsu7Yjq06iQDh5G/bYHJqgALlwY/AlwtmJ+26k2YgSijxTWTixobAipNHt5x37U5J7GiwUaczs22qAqG3o3ZC+FRIuaT2wW/5GqY2CQq+2Na45t+9UIqZ/SAUMyYRdtCbP3p6+/2chTa9NZLR5vJi8M83aHmeGKbC6raAD3Jcj0kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILxN/7OJhx3Veb5cvnYNs/gR7JnklLz1pl3wME55vIY=;
 b=V/BS/GvSZ7Ij5WM/T2mn1lwmLiDv4Zb/oknRgw5PxEKm2p9f0viKC3PIAvOCiq6E6RgUh9OG2kijPSIojqXOkij5aCzgBqBgz8AXpymCZYsa5f//KVjX5TJ4Qi8P5eHQqvGN1567LUdFkBsfq/Vfkab1a0Z8qaQezF0bNNLrkydZpvh1OgaJmyOyPtkA8Hc4D5BZKjAodCyHeGKJJnnY3+vo+AAquNlMh3odNADv3MKFgs6qG4b0Ij+NNAMsn8ddWCIGKIC4LG53OsDAv7Zmi8/XTnHVxHloRzqKrlpByXxSmAWieqYqw36PUV4uWGFJIu4nQFfPrCz1POugaa6l/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILxN/7OJhx3Veb5cvnYNs/gR7JnklLz1pl3wME55vIY=;
 b=DvX6dxGrFvZhbwVZ9ucwUM3mMiHAM33lmJb3kpM+nSLL/x1khDhCIkEXnim6wfsqKk3uEry66GHha6ZanIRbfIoORhpJjSmqNjlm55jVGghBSOlb1y4ehO34aIwmyKCdWwvwHI7a4Ra6sf7sakXdo9hNp0qL0ixx65pGgOlm1xtYhqjPcut6aUk65Mz75w998hsgGh6sAZ01OYC42Pj2yHvRGudkcDgsfK6nQ2orWKOhMCYREomkjMbyPg47rOZjJufI9D1bejl9pHcsn/f6pRyXiDHl/hvY+8bmZd75zPwmorMxnhUWSkHVylDQgWMcSAJJXUfmjC5nfe+XWshTzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by CY8PR12MB7292.namprd12.prod.outlook.com (2603:10b6:930:53::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Fri, 26 Jun
 2026 22:09:01 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%6]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 22:09:01 +0000
Date: Fri, 26 Jun 2026 16:08:58 -0600
From: Alex Williamson <alwilliamson@nvidia.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>, Dave Jiang
 <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny
 <ira.weiny@intel.com>, Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, vsethi@nvidia.com,
 Dan Williams <danwilliams@nvidia.com>, Sai Yashwanth Reddy Kancherla
 <skancherla@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, Manish Honap
 <mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, Richard Cheng
 <icheng@nvidia.com>, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v7 10/11] PCI/cxl: Expose CXL Reset as a PCI reset
 method
Message-ID: <20260626160858.79d28857@nvidia.com>
In-Reply-To: <20260623032453.3404772-11-smadhavan@nvidia.com>
References: <20260623032453.3404772-1-smadhavan@nvidia.com>
	<20260623032453.3404772-11-smadhavan@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR15CA0011.namprd15.prod.outlook.com
 (2603:10b6:930:14::23) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|CY8PR12MB7292:EE_
X-MS-Office365-Filtering-Correlation-Id: 84a39a73-c963-4424-d4a4-08ded3cf86e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|7416014|4143699003|18002099003|22082099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	7IFmN/j5YSFdGDs4Yfk9VtKhc46J8siDB3H2qQtcXCZeMwggdrEnxf9oWNCqrD+ykwFIH5G0fku2kq+8MGlzFX6g7Lnx98bss8KGBv83+YcXpt0kRXCuvkJpa5r+sIuyKcYCGAjXeFidqR3E2kM+ytDo6yB7xaj6VhUMdBwmQcGUWouUsO9qfrOGHRy2oDm6qIJicmpCHBxVycNjU/rlRt8wdM/p/8+OhC5Vvqu77J4GUvChU6GpOwMrLhis1Yadu47XmYX3x9hCoMMAD9DMySB+ARLl5SDvuY9bZ8mzAiJJNv8VIsVXfteN9n5Z+/mYsINmY35pPh8/7iVt9f+K2o2H+MYV27iEWNN+HEYFgt5Ha867yygvYsubw2Bvny1gMDJ6qQnK8amAFNXjUywTbNb+BcsC1MwOytqVbMolMd5azeqRNC7PfoftrFSHqrJc7+UBgwtKnL6RSU0EAt0VyX4HGdBkZodVp4pTtpfbvKlspZovk98UjlB7kWbN8TF8+wWBsGEAPxPFSpJsESIkj3tF9w59FianmLVeYZXnN7mdAE6bB8exDr1o1QXsDi955ZOphrkAofthBXoQdEGQKsnF3CrAY/rdBCpljlNYPy1Q69yM0mKE/6EEXNcu/H9mLuyULTHHYuUFh/Ob15Hfz6b692qfJwzkThfDFxgq9Gc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(7416014)(4143699003)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PCiQHq/peCoKpQl7ytvyIJyLnE/BIKjMhDLasXMa6WyVaEKmzY+NQqrBoeKP?=
 =?us-ascii?Q?SmAjogxtIx3lXt0njONJkP5cZCedY/4ylZtpfLnm8zS4qNQhkjJ5E8B7ZXpg?=
 =?us-ascii?Q?O9PFOT6bzCu+3D/EwTETA1JVLDh8RoskZjH/ulumjSwWZDuxQJyfze3jJkqj?=
 =?us-ascii?Q?U3K2H6z367ePr3oLV99CN/NYPVZa1gVGNVZqBpVjGN7eIApgMiRnWz5IOzhH?=
 =?us-ascii?Q?p6kLZmUowFP09HObdJ0INsJ0mrtqJ1YGTyuOvw9N7P25TGv2kP9pIQxP3GXG?=
 =?us-ascii?Q?kmPBduplUUR8nURjW2t1qBQTdc68w8VqjduPzbWxN+eSZxS2r7GlMR0EvAeK?=
 =?us-ascii?Q?3nqXXMP1iwUt+B1uLIVHC8fLii3gAx3wL5L64tNpaapqj6+odNvif+3ZG9sk?=
 =?us-ascii?Q?gTfogrBI4tr5lfCr3srh7SkwVcAuYxFw+Hc3yron3CWt+3P0dtAAjxDx31Xs?=
 =?us-ascii?Q?ZEX7lNcyJ2laydfMInavtO8mg+u1G0Jtbx2T78A3BNQcoPpps+zEeu89dmHU?=
 =?us-ascii?Q?imXuH+aHvYLQnkxB5ypIKdBcoGyiQlCUtlyHIDABbwCzrCC0rocNAeVq6sPE?=
 =?us-ascii?Q?Iy+NttpXiJR11v5WwlcECejOKQpP2SnJIEDN1UZbX8jdZ3PMTuckIqYQh102?=
 =?us-ascii?Q?MP1QSOzay7JsQQ+hscnVa6NcZn2zi+WEj80V7Ks7EUt3UYSzUYu4YxnSfpmv?=
 =?us-ascii?Q?m3uJ4oi5PK0FBSgg5YpT/+L0AzIBofoBS4UDIFKnicHX+9xGd/CIEUTggu1F?=
 =?us-ascii?Q?15oSkW+vxBBvlF3cw+ay3hIWAYCPPAsvuqD/G/Ap1Hjm4Qg6EooYlpQrZKq8?=
 =?us-ascii?Q?jr9kx8MB1ZjbqsgSMXR6AN3gCROQXNN2QpgZCWDl9GEZCHjxwsnuGoWCcJOW?=
 =?us-ascii?Q?0f8+98N1TLj2sSBAEMfny53zoqU9V/0Gw9f3Bhgojf9Zt56BiA5U992RrEVn?=
 =?us-ascii?Q?duty5TmNmikReu3QDJackbwPV9Lt0ISeDHD7yqm0i7MI5B0Jh9w8ptWXvhq4?=
 =?us-ascii?Q?JoIlJq3JkQHAv5QulBW5uuPkcyBDXCe1yuD/p/2dVVmEddZhd94gZHdOICKw?=
 =?us-ascii?Q?mlLxF+2/55BhN3okMTl+5yheSIsWMLj7rmIVM2aC/TFmWDSI9gpKSOY5yK+C?=
 =?us-ascii?Q?okfEd37y42bgcDu05rTfR10qU3dh2uAY7lT3GgEAqMYfXphy3KVx+BgF4n9N?=
 =?us-ascii?Q?xCIBB91/kkV8FpWeEaAEXhFCKyjsENk6pcMn3rHhsY6tgzrl+ldvJZ4CmSCw?=
 =?us-ascii?Q?9lnADWgVQcXa+XkQDWRkSGvrvZsXxUCu1RCDaz0KQ/LVgcjfIopJ+MzWzcHO?=
 =?us-ascii?Q?bm0omI/NiG680nBykhIktQm42XE4d3DTuFxNVYiLeBMB9b0kCaxUcM0bD9Oe?=
 =?us-ascii?Q?txJT2z7euXRiGKK7sdTfEvaPSHnrzIE/bAlJd6s7RRAWwPW97EH2nGvLZsbJ?=
 =?us-ascii?Q?91jtH8BsBpz8nWFDpwnYzUhi0xzZlPFE6HGjymTkEIzcqFcUb7HDK/rTcL2R?=
 =?us-ascii?Q?w2kdIm9l3v+aBPhD/HBjPX95YTpYloFwzJMcm73utWmzB7mcyCjcbWWGmWPh?=
 =?us-ascii?Q?+pELq2q8mki5sQMGvJvB2McIfwmvGECUfWunTRiuxyrVqGvff7yqAlWB4+6j?=
 =?us-ascii?Q?r9YH9M9WmMoAC6qsaT+3pLYxusazJkVBCZrU2UFM2oJWptMW0ZbDwMMW6kuN?=
 =?us-ascii?Q?xgn8IAORMDG4PzO0QOjHBOZbDydKU0mrBcCFxy86NAJcwI286PYK2lXYov7I?=
 =?us-ascii?Q?l7z7MDfxsA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a39a73-c963-4424-d4a4-08ded3cf86e4
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 22:09:00.9502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wnQmP+NcSmQwR6bbp1K8zNR1VYjsD6rxVAy+F5fmk7zVjKM1P0vxZLR7EfoTUmNysmFyGseME6Dl5/UKKLnglg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7292

On Tue, 23 Jun 2026 03:24:52 +0000
Srirangan Madhavan <smadhavan@nvidia.com> wrote:
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 360f2aaee10c..b1ec20126390 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -33,6 +33,7 @@
>  #include <asm/dma.h>
>  #include <linux/aer.h>
>  #include <linux/bitfield.h>
> +#include <cxl/cxl.h>
>  #include "pci.h"
>  
>  DEFINE_MUTEX(pci_slot_mutex);
> @@ -5081,6 +5082,7 @@ const struct pci_reset_fn_method pci_reset_fn_methods[] = {
>  	{ pci_dev_acpi_reset, .name = "acpi" },
>  	{ pcie_reset_flr, .name = "flr" },
>  	{ pci_af_flr, .name = "af_flr" },
> +	{ cxl_reset_function, .name = "cxl_reset" },
>  	{ pci_pm_reset, .name = "pm" },
>  	{ pci_reset_bus_function, .name = "bus" },
>  	{ cxl_reset_bus_function, .name = "cxl_bus" },

Follow-on to the previous comments, for a device supporting cxl.mem
and/or cxl.cache, cxl_reset is the best option, perhaps with the
exception of device specific or acpi.  Why isn't this placed above FLR?

If we decide cxl.io scoped function resets should not be exposed for
cxl.cache/mem devices this might be moot as we'll filter through to
cxl_reset anyway.  Thanks,

Alex
