Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011023.outbound.protection.outlook.com [40.107.130.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4329399340;
	Fri, 28 Aug 2026 19:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787943608; cv=fail; b=a5A9aC0YPll8LAqR6uNWItRkKyO5uu5T0tKbgkbb8JPjdTOBZ5sz2JVFsElXwcJSF3nubpPLdj2Ka0n8cDXZvATlv4Cua2rQ+1L3VRUz11vlWcf0bJJoPPX0VGbEcUNaa9KiEXyEZCfBZmzM/VNPwVRh+WTXQwhtbJhL9OSnm7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787943608; c=relaxed/simple;
	bh=zzsx/P4pJS8LjrVjT5D3ZDDqW/GYE/LR2i1fenarSBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m1gDZcOXDqSwUIGKQSextLntBxR+h14uvb4IQHrNhTNvqYITtsONUMh8GO7l9Vi8G0POcE/tC3Vj+hyXyp4AOoQY5un5hCJBMo7B30HRcDVkfhNOpvwZ95HQuEga+Ry7ekbvUeEYETz03gbOQuZMGVlZeiM3itFSbUou7NI5Ykg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=p5GEkKI0; arc=fail smtp.client-ip=40.107.130.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="p5GEkKI0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pe+0k+M/EOOtmkiZ36cP7heZHH8kFaZWrWmkeZzyQlTBF4JVcnbsn52PtSctOCtWX4l2ZnFlzMv+iCSIFJiqvhLlwiv4a20wiwCN3cuBzPn3fl+eEu1fvYC+0QJ5HS9ARIR55/Pf6lSV4FEYsEVNcZ+uwomLGXbA374dkvPAPPdeDBT4b3BP9cIvqClqObNv5jN1fRbidSMh6pQH0RDm0X2N0nsJ0Re61LZYfloozi1E0pw0GA4xO7eV28ICRcQ3FS01qRkcLjq7qN5bSK0/UV2aKkzQ7R5pM1e7TSOblen4vSNbPQrqmB8OaZJ0mQwQ1D4QtsV9TPGM525ZUIK9Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7a8Frwt7fRSoggP5XPZhlkbQ9VLqkYuzUoQl3MsMhKI=;
 b=F82ue6jgcmjYfHIfLKsLhqTteYgwBOMkU0rajbcbH5AeWGBHORuU/d0py30cc2VtnA5NmbEPejVniCW/Rc09K6gjPtlmjDsc92LMPPyzJUohnjTQh5uegiLNwS3i2Emx3IwTFxnCIQL5r4Br6StQPv4gL5mkdZS4wqN3InnKUI1XtDaDbLMufSKNXtmMiO0cZ8EK3mlMKSSP0qyLYpdl7bChwLtn1CwjHCrtQwE1FaF6F+HIdS7IgpNJ5Ff7oHOh8QVAQMtbLfHDr1Kg33xgVP3ZTwT30kVwHJOqVOcm/jsu8Rm8JfKgl/yI+ulYhPAgrXv7Nty2pFjO3W+FZ7axQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7a8Frwt7fRSoggP5XPZhlkbQ9VLqkYuzUoQl3MsMhKI=;
 b=p5GEkKI0pnRxUGvfA/O8pbk0OHzgJeu9lAQ4TAftR/AZ1oiv+RjgM6BBcUbnj5vU9WOYziMmo658arcnXEmoWjqiJoOu1+WtHoINcvmIyAXLdGrtkfruncJbv2vHYE4fMwCOKcxhq+hoUwSnwdP0hSE5FovWaX/Q+ba+HNoWciN0NJW9MzZZ2InOouAJJwAwkEt+L5xA/pea0QiYNHO9B7gpaz5ecRn1GCSpB9++Ayr5JhCxjw2B1o4s+JgeRAoMMUgr8NyNmbnWOrVw1U0o8CuW3173wV22+OHicVWFpUBFTKDsr7AuGJglYMXshOfrW6s/ltPEgbbjl4pZcGURfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA1PR04MB11261.eurprd04.prod.outlook.com (2603:10a6:102:4eb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 18:59:58 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 18:59:58 +0000
Date: Fri, 28 Aug 2026 13:59:48 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v2 3/5] PCI: endpoint: pci-epf-vntb: Move
 epf_ntb_is_bar_used() up
Message-ID: <apHapBrZ9cdGYA7u@SMW015318>
References: <20260828170932.2735807-1-den@valinux.co.jp>
 <20260828170932.2735807-4-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828170932.2735807-4-den@valinux.co.jp>
X-ClientProxiedBy: CY3P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:930:fb::8) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA1PR04MB11261:EE_
X-MS-Office365-Filtering-Correlation-Id: 589030b6-ac0f-4bdb-3042-08df05368e5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|19092799006|6133799003|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Gg3hzvnEa/WDzUOJu1qdcDttjW08GBaNsiSkUuUlU6SVFa8rL0aFqUoNDDE/FQfBZCErx1Hq6655O7a+Wmjtk+HBkXV6JHwr4Q2CleklrpjcY5exb8FAiGN6ejn1omrBHMBjSHM9DfSWOLNfT9eQUsJBv7971Og0YbKtKpsepE6C0A7E0LWfKchKyY5m98x7Bh/Y43ukBj11Bp6ROg6hafH+DUDLkVAK/CmO262t8TL3Ojl99hOVfa4vKWnAraLgVdwppx0zhzEUWUUJnU7E32Hic9eGi8q/MYXuYcx0N72Lb23M3GTSwQtkKYtptWHk/yos/zfGzFtFWqImUsxzyI6MnBLTi8oJaak/dwT71iaGgforfAelRFnY3L11Z54d7PVH/wPdsbmvVRG26OWRAcFiaFfyblH3Idid5dtg2lUhXuFYZwEgHNcFEKy2sui61htSLs+DIgbX6ouf6tjQO3M0vCOY5EbO+RZ2LOWSNVIXmuNJwebtckroue2mtONi88WPgk5kyEEF2yCyuXdVlAvn0/3SqRAgbEYo6b/Tu+ziu6iP8yfv/2xeZLgXRu1oo8/9nAcTa0/ivzA64PMD4HZfJGOxmOvIROR2k+nuf0oYFF/ihCJfnwtkqUNjCGW3lpjICkddl4jz7VhfeBOa0qypYpWNlQ/wJxkRUtvWnh4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(19092799006)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DNEa/7fy5JHL+94nBFo8PHuuWLyEwcQM7+IU4g7kh9Oi4IPTKwLaKEoPqXPA?=
 =?us-ascii?Q?GtzQnejcz8gNx9HrnZ2F/AIxItGQdrKtunqqwD56leAoK+s87i4wq+RzRih9?=
 =?us-ascii?Q?n9dvM0/eNYh59/a+GiepsTdxr5i0ZESE6Y6e0zRcrt0PdYa4Gh2x/tUsZGWc?=
 =?us-ascii?Q?XJP8WM44m++gNfjQbTcJEpoLHX0UmLTpP3ks239SI5qO3WkRlcx4P4OSNehZ?=
 =?us-ascii?Q?uGmonTJEDfoNDuVLI2TDNulO+PiNBcuNgmZmrQ2ndd8rvutptNW/CRUevxZH?=
 =?us-ascii?Q?ZQz0VMUOWUidbmw4A/kXVa6xxJ9tEZeV3cGng94kaoE2oYYJY7wzv51mp1XH?=
 =?us-ascii?Q?EixcqGDtSnf7DyiBB7lmM/jP7bBFadMPuuyS4dTIf3paxL4IXF2KQzCXV1Zm?=
 =?us-ascii?Q?JYcMQ9bVloBHbz9t2ABVAKlCtb/xbTlJEdT4O3Vy6BzoFiriebbyBVmr2CpN?=
 =?us-ascii?Q?zZw4QuQI/7YQPc83DUIrxM3l86YRTm57lEWbJeQtxO9F7EGVhFnWJw+IzU4S?=
 =?us-ascii?Q?R8KGYzeJfG8oB/Pfo7hQhFaBcM/V4xreQtaH7tEkw27QFVsf0fl1c9Gy2iZZ?=
 =?us-ascii?Q?0kk4bY+3P9B6FygQCqbmyw+o68mMaAP/5oQyFUMAcL6YVe0yNnPtKbzGvnUc?=
 =?us-ascii?Q?rLLWTj9aNMIhVaTZwA7ZuiGAqny4m9G/6CEZC6lKEVX7CmXH0Bm8RVSIVluL?=
 =?us-ascii?Q?peEbjtqvChwlVHZV2sWt4yodumFL1z5n1vnznggitWuKbS1vE3JYS8hQQQHr?=
 =?us-ascii?Q?QInQ0XNUr1vJr+zzBa7SqvCgZwwHArUbBMftFH6K/gBS4w6EetP+XbtERItQ?=
 =?us-ascii?Q?V/Dx8ktnXvISYVMuRRSKAUmeElkcqnAtpuuQ6Hy0WIfIbDFfY54sagvdVEcU?=
 =?us-ascii?Q?BlaUgbkiDycE00w0XZKXcPGO6LzDma0Z8Ofyb+M+vtOtqfWNduTU0JQgvrD7?=
 =?us-ascii?Q?JwH2C5vsqy0r7CGNu/AHkK5q0WnVq4d130S1DYdFlGWCZPbHhtG4IL0+FO5e?=
 =?us-ascii?Q?wmOCCoiaEov4vupYUaIbaJ7YDg7br4F79WGNfRdXaCPceS/9ORodUKuApIWW?=
 =?us-ascii?Q?o2Pt/vocS2i0a38WmrxCrxJn1GtIp4BxSfwXOoCDSZsFsxrihthZFCcl3NSk?=
 =?us-ascii?Q?+ihR/sMOFIFEPQDr3DDOVMPseadS/D28rtVtVafjark6t1j5WD0/ZJVQLhBw?=
 =?us-ascii?Q?4XBHwh8ul5ajlPr+Dh4GfcvvZbHpmLNQ9gAXuFu5LcVKGYD5RMUVXOckub5V?=
 =?us-ascii?Q?c4mRLQGvmWsPZiXnPmebJUq4Vs/3+IfTIDMtlXWGsGkA3UiEtYY0wULa1NwK?=
 =?us-ascii?Q?46dRjsJH+uamExakx0HCxJvkrtrrwjoZ71aYcDNjNkS+/sIbfWZYKQ9QSPwW?=
 =?us-ascii?Q?BkxwFJhmKh2uH9yQv0TdmIo8Dt+FfZTe+ZxoBsXEtI60hZs/MAvs/eqg2+if?=
 =?us-ascii?Q?CwHpdC1/nYjGUfQTFsCHKwy1biHofHGlM4xZ+F8VwNe1oWFAA3H5AmwZ36eM?=
 =?us-ascii?Q?D1ulOhyzXljSMqDj3NBa5DxDkrKkSgu8uJwNHsiPw+h4rJqiyUeApqQEL0lD?=
 =?us-ascii?Q?w1Jymhpv+PMFgLZUCiywLkws0jXKIT//TJrBT3NgQBvdzWpILXS2KT6yQAbW?=
 =?us-ascii?Q?K1bwtMOCUOxKBeSvIaDGuOVLqdOaMoXH7SM6nBGGnD6rnGapNtqB7UsKkQKT?=
 =?us-ascii?Q?S3LU4YZmrFFFr1SLDx3qecE9l+UMpVotmiqKHRz3gcXW4tF4Xm0+28b4HazO?=
 =?us-ascii?Q?bo8WS1U2dAiBloC7P3R8AGSFR2sey3k8mFF97QAgsreKxyE7EvaJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 589030b6-ac0f-4bdb-3042-08df05368e5d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 18:59:58.7382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pXK2lj6cMrA0rT24tUJdReb4btKQ9FTMHTFbhzaAfygDr19LsKn5rrnFS7hn3KVYIgi17fZcPegdmsGndTBqv4yeqcfrckntl82YIoaYWhB1uOwaQu1vFvOIfjDU/LFF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11261

On Sat, Aug 29, 2026 at 02:09:30AM +0900, Koichiro Den wrote:
> Move epf_ntb_is_bar_used() up so later BAR selection code can call it
> without a forward declaration. No functional change.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 40 +++++++++----------
>  1 file changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index c3caec927d74..d12d134ce553 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -199,6 +199,26 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
>  	return 0;
>  }
>
> +/**
> + * epf_ntb_is_bar_used() - Check if a bar is used in the ntb configuration
> + * @ntb: NTB device that facilitates communication between HOST and VHOST
> + * @barno: Checked bar number
> + *
> + * Returns: true if used, false if free.
> + */
> +static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
> +				enum pci_barno barno)
> +{
> +	int i;
> +
> +	for (i = 0; i < VNTB_BAR_NUM; i++) {
> +		if (ntb->epf_ntb_bar[i] == barno)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  /**
>   * epf_ntb_configure_mw() - Configure the Outbound Address Space for VHOST
>   *   to access the memory window of HOST
> @@ -830,26 +850,6 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
>  	}
>  }
>
> -/**
> - * epf_ntb_is_bar_used() - Check if a bar is used in the ntb configuration
> - * @ntb: NTB device that facilitates communication between HOST and VHOST
> - * @barno: Checked bar number
> - *
> - * Returns: true if used, false if free.
> - */
> -static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
> -				enum pci_barno barno)
> -{
> -	int i;
> -
> -	for (i = 0; i < VNTB_BAR_NUM; i++) {
> -		if (ntb->epf_ntb_bar[i] == barno)
> -			return true;
> -	}
> -
> -	return false;
> -}
> -
>  /**
>   * epf_ntb_find_bar() - Assign BAR number when no configuration is provided
>   * @ntb: NTB device that facilitates communication between HOST and VHOST
> --
> 2.51.0
>
