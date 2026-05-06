Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507112EAD15;
	Wed,  6 May 2026 05:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778046897; cv=fail; b=YhcYXRjtxMQV6CckGNptalxknWgt3AZle4RiQssicUSlv/pQjEBPRjkW+xAnr6Mn7R0DqcQm2zCWg+wHNRZwvR/Iw+dy9aew4Ne4Of1hAK2vv4zJTqSf6vmahJGe6qkwXHt4ZTlcCmFCZwegD6u+BeXzNa8nLqIt0Xfcred4KEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778046897; c=relaxed/simple;
	bh=x/TWHnZ6dd6H1wBs7bragJNxSgBPrQl3U5QTYJ9Oe9Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GyzzlQhOobe6/JeIRmYUqZpfahRmjY47aU12mkUlp60BdJz52g9Sp74FpI9kut78RZXMzaFz1dwt3IF39VVwyASnfLPSVXJgcd8j16wX5+siJZYXVUuxJAoV+81HNdAzmxGRqHMXyKF/Xdh9mTfBOTHZF78imBXCmVy/YFJujNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z+kAQZ/f; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z+kAQZ/f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778046896; x=1809582896;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=x/TWHnZ6dd6H1wBs7bragJNxSgBPrQl3U5QTYJ9Oe9Y=;
  b=Z+kAQZ/f1H5wWKr2dm4C4xvGe9ifyaOQNj53YgJhCURlf3VqIao5U48n
   es6Lx6xy2p9yfQQ4lpT0pbgSGoy5q6Fg1NCvlZGAc7QtsFNzTA+0BTPG7
   BJMb7Fv3ep9FWuhqCude0+LZsxoPdSe7ZenM8hUSgP1x4K6y343tjjy+B
   iOIn7k3eSjJby2KXGA/DZ3UP9E2Q/3id2/muz29BEAJp2ixzwhMN34DeG
   EZxDsyyHYjA3hhIh2PpU+gVGv38n9esjoRXW04CD0GrDl2TO9zFEYX0gu
   sXRR+vOAJcywcBW8QVkVpHzf/r0bHcgiDg7lyfqg34hRVzs6AK9jk7jB5
   g==;
X-CSE-ConnectionGUID: S7mA+e3GTdCR0TmEEj8b+A==
X-CSE-MsgGUID: XSYeSfzHQleitvjLw2OPtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78982475"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="78982475"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 22:54:56 -0700
X-CSE-ConnectionGUID: Vwo54S+/TnacQaOJcXdqwQ==
X-CSE-MsgGUID: 1NeHiBU3S6mxwYA0vrPEmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="231638768"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 22:54:55 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 22:54:55 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 22:54:55 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.54) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 22:54:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PAlkkNIsjsJO3Ga6C+6W2wuiaf3NJtwTxCTbDzAdqlSilVFP43p0DNYqV5OrfajuqhHZ+Q5/IsD6wWHFi14NT8yRSX/EFMpdRdenpUG4tJJe6s8JvvbgPu5mNcK8qTHpTEhpWgCrw6JaA8kz2SrQ1WeI+k+3ylXW08PT3nSky1pYNjULGx6iCdZ1r6oruQRzzW77P+XnUV414S4awCYq0iay0dUTYHneboRnPZUBEqNhUOlgYUrBW75EfNJBqbXqKtCfUkAD8pr6IZba0uOpM6kz4+dQldZqeNOQc7p+vn4STB353nbN5PNh6SGFev2ckUDTV/+2L+XgM6nGhnAE8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9DLOSdw/dhNesz/xXpUI13VAPsNHth0rf8FwVomicY=;
 b=MM+X/Or12LRy+ljwHTf7T5ns8/IqDSNCSEKyX2d4WEJrKPoepKwU2KJg/8+eWe9LMowNguPO/Rqjpd7KwNGwdLedmaB3AgSPzh8YB3+lQv9Jz226W9QVG+gM6ZERae2lxoxBrAPafciWKJvaU36cdK5J7dd86Ev8+hAyCZvWYLmskDpEMjmVTysMrPKQGMUHb+1qfiIh4JBUIOhIBk02gunITfMqRQKjVDNyhCbfGUEBa+UvufV9VfOcH6IOzB/2vFnwLgJdIR9H7K/ZmcNoOKF9g2gIgtSODkBrqc7L+bZggZ6Lgk+m/kkM2deVdlW97ICTJbyxGTZ6PXsRvx+6VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA1PR11MB6370.namprd11.prod.outlook.com (2603:10b6:208:3ae::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 05:54:52 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%8]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 05:54:52 +0000
Date: Tue, 5 May 2026 22:54:48 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
CC: <linux-cxl@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	"Jonathan Cameron" <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, "Dan Williams" <dan.j.williams@intel.com>, Bjorn
 Helgaas <bhelgaas@google.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/2] cxl/core: Recover from PM Init failure via
 cxl_reset_bus_function()
Message-ID: <afrXqPvcCTnSuMaT@aschofie-mobl2.lan>
References: <20260428182454.464655-1-fabio.m.de.francesco@linux.intel.com>
 <20260428182454.464655-3-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260428182454.464655-3-fabio.m.de.francesco@linux.intel.com>
X-ClientProxiedBy: BY3PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:a03:254::24) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA1PR11MB6370:EE_
X-MS-Office365-Filtering-Correlation-Id: e90bda79-f063-4324-b3b8-08deab33fdf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: F/fGMTdVxUkmgDEyyh9fdrr41z5M8v52EnRkiEWn8aLgYJ/XpBPwH1dPuDVVHsyEHcR7I9PymfOdybukL1qOz1mNL4BRhxyF29mfA8rHnnR8DBTmB+01GkAs5EDHwUUs7ob0zWZgtNFMHNOqFsnr5qffDvqbsNGK3kd3m6Q1EWFhGZWEBQJ0TgAFp463DVkuOLdRzSyfFFFoocekHVfnkbgVGBq2vZ8b4HVfYps0+fEYyLa7C3sONq0HGVVWtP5gveepKCfGzo62Pt6rTtgk5lFAr7Cb07DbflDqu/E5kMVgVBjz1apgwzKV2PzosN1rkgb8eOc4AvVwVB4YbbuuQL/3dqg3Ev8aq9vs8WkMCazHeTS274mFLKYPh13P8cZTOgqRKthK0BJlsgqB2eBpGlgx+4jFzCkQU9kBmN+3Yiq37OZztrrgwx1/AjWV/1WS1sAtBjl4mXQ4LwOSrFa7PnOa8MUrVi9bNE2jbEyDlAvVC/BP253yUaIlrtkiJ2z392dBzXrHwIcgcdOIB5yNK+EpXp/ciDbZPI18oUWXC0rZmDGiV9tblLSNnryoyBpe9Te7Svp3iWAjdQty1SwO/tgmKHq2TZpUJ8qlS5YB21TgFRKPOKXFpj9axB6l9acupb/wqvElQ90gF0W29pwoKm18q+sqCYHcDRbD9FB+KsQU4C166Jv42jYoeeIP8j45
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qIvCyx21tHQzXy2+MBllN2zXhzZiZX/hd2w99JJGrLrql59pQTUj2sIX8G/z?=
 =?us-ascii?Q?a0ticTNRuQHEj7R4GwDXwJ2QtD5E4oO/Lf1MPdzllPowmjEXgqN4U0UB34zE?=
 =?us-ascii?Q?TmN516B3IwhNyuxf2S2cDBv1EBaEh+2wBrjJDic/Pr96X03JfPEUulCEqFZs?=
 =?us-ascii?Q?tT2NT22HcWEhLKmA7fUetLxLCsppm99zLcdLJ0q/i2n+nEz4CstZe42PiXh/?=
 =?us-ascii?Q?Ja0cziy9eKObxX0trdpveOWyUSwgUAG5eDpy8CWqaNrw2gdip91DYXpQ4NBb?=
 =?us-ascii?Q?eN5Ab40+eDlfs0d/KTVEomx+MCOMgwT5MAe/fZ05WUE5jn2LecSS9pt85Rzc?=
 =?us-ascii?Q?+yZk8MD169c3JoD4vOpN50ILxVvUdy3VB0RAzSkmFFiW3Mq/YUKYmRUlTwgO?=
 =?us-ascii?Q?C1cRaOilAYle0pofWzK59bc/nFD8U2sJ5sH5xZt4n3Mnkw7Rvw/MAwiTeJLt?=
 =?us-ascii?Q?+zhs4KllGLsvNo1XxXHVLeYYQUv9GGK85OqjujcNVnHjD+og/b/TXIc19JJU?=
 =?us-ascii?Q?+9dwLVc83dpeoLdPrJgbGDaxGxRmzX/8j7dVPBlQuJ1y/c3ZeMymvNAKvhV3?=
 =?us-ascii?Q?ieMy4Igp9N9VnENDb5PQ7v8OOF4rvtEruewE9gkE2PFu006Lqsqf8Bxfr1rv?=
 =?us-ascii?Q?dZxf2TuEF+VUbRktnHixY93j5iMlR+mW1+Xvj8LOXhr/Zqdaw6Zo3m5uiyoP?=
 =?us-ascii?Q?MHUc+B/OCpX16zgKaK34O/U1pE5i3aFLrpTc+3yOIOfjzZsvlIlE13h6Yxs+?=
 =?us-ascii?Q?6BoVj3EHYrqFuc2K19o6lKAnvwfjriz2M8+9NpHoC8mW6o5IGTQtjkw85/ga?=
 =?us-ascii?Q?z57Z3CTmUZ6oHzVK0xmsgxDGq1v2jXyZkW9+fZQVyuPsjy1NbiKbW4vU6J5g?=
 =?us-ascii?Q?8fUC48RWneiwnUgTjUIaQDJbBYs2tcAJSWbvknndjEgGS2rkHWod31YiTzSF?=
 =?us-ascii?Q?5/IobIItir9P0OUgpwmu2gLUU1atEwtq170PsnIkcCiSiqbRbxi4N/ghys4W?=
 =?us-ascii?Q?EIbgOrEaNNIPPgpO3Bt2VlFbzWmPSnKath/VyfDzqd84daU1VIBNkFeeIoQO?=
 =?us-ascii?Q?XqwIYNp1JnaBoyoD0BlinS4gBH/SIX4d6y9gHtt0VFMlHpHVclutDBWdVauy?=
 =?us-ascii?Q?a19yvZUfcsuQY2VH8NLu7vV4JyZFUqWCvAC48rRtClnOVw8psIznt5mMdOaE?=
 =?us-ascii?Q?U7RoLf+D9awgeDS0k7ODytAa5PQ1USIXxgdgAcISBRPtbKeR4BGZ9ySbhWSn?=
 =?us-ascii?Q?a1ieAbyU++lD5jIhHPK2xMJp2exT919oSwOBKH099Swk7F/+lXRX479Gn3S/?=
 =?us-ascii?Q?enRN+T0NGwVL//uSh23kx88qMq3BW0SNJO9MKSy+kGFoAzDHJWzFGkUQuU/x?=
 =?us-ascii?Q?C4NYeuNaqK1ZfhWTl1Av0n5dnse/elwiZIrifx6urmzIixIp0s4Su74DcQ3Y?=
 =?us-ascii?Q?B7rXkEsQWeXaNBwUTKo3dPBSYMC1RI99ZPm+cRDrGdisW25MRviGosmB6RY5?=
 =?us-ascii?Q?oH9crlRytmiMLHSW4DYFoxt+aCIF4TuyY9RVbkDqOfmH1u+RfOSGSrib4mw3?=
 =?us-ascii?Q?slXvXZNiEsfxmMUN3j06BLzjELT+Gi+IeinhwkX4BWJxR8iBBZQ3+fUBcSVZ?=
 =?us-ascii?Q?YqMF2wuGpz1pLlqxsbib/ELlkNDsYSFsvsQzXPSRUAHUNfVk7n5Qe4SSrmYN?=
 =?us-ascii?Q?TFLvONsA/P03+txyJ8ehhjHV1siIcizRR+HlOm12UdN75PEqSkXvPxc+6FhL?=
 =?us-ascii?Q?lh3vP8nRe2ajxyX/hSuq6TIDoBspAGM=3D?=
X-Exchange-RoutingPolicyChecked: UhgEz8y8au+pNQJKistNdTraK07k5AEnDQ6NcBlLaVv4jTXRqkZouJ/iej38e6YgO6nYS38G7kXKiofscV6jhvQzDafoT5uQ9SxSz1QmJAxpSVz5OxGChKtnCR8IRS/Vdu9WiH0R/etmzlDAT8C6oe54IntsEB9BHvKw+7yKWay9HB8N7aZ4Y135vMFkkjrU/hx135ulfUKA/MQkl5HNYsBEnqUr3dPoOZ2manHEc3UfDM93WPgaGtELucglLPvhhSDhrfshn/LmEJrpqauhlgDfYSg7J1EsVrBUvXQ/lZ5mL/+m+fmsNXUmUWbbpBfUpAHZWM6gSLHHOmF2IhnJtA==
X-MS-Exchange-CrossTenant-Network-Message-Id: e90bda79-f063-4324-b3b8-08deab33fdf3
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 05:54:52.7453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ISYTXcoiplPYP1x8tbb7/CQ3WKkvFzv6Qj31qNu2cIKriPu0BzErfxbMce3+Io9Hwz+aguKh+KQMBN7cBnGDduRpRdvoabNg1o5jB4ZSHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6370
X-OriginatorOrg: intel.com

On Tue, Apr 28, 2026 at 08:24:35PM +0200, Fabio M. De Francesco wrote:
> CXL r4.0 sec 8.1.5.1 Implementation Note describes a scenario in which a
> Secondary Bus Reset, a Link Down, or Downstream Port Containment on a
> CXL Downstream Port prevents Port PM Init from completing when ACS
> Source Validation is enabled.
> 
> During CXL enumeration, for each CXL Downstream Port in a memdev's
> ancestry, check whether PM Init has completed. If it has not, invoke
> cxl_reset_bus_function() which is exported for use by CXL.

Hi Fabio, Not a full review yet, but that !! caught my eye, so...

> 
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
>  drivers/cxl/core/pci.c        | 30 ++++++++++++++++++++++++++++++
>  drivers/cxl/core/port.c       | 22 ++++++++++++++++++++++
>  drivers/cxl/cxlpci.h          |  3 +++
>  drivers/pci/pci.c             |  3 ++-
>  include/linux/pci.h           |  1 +
>  include/uapi/linux/pci_regs.h |  2 ++
>  6 files changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index d1f487b3d809..de6a317df650 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -926,3 +926,33 @@ int cxl_port_get_possible_dports(struct cxl_port *port)
>  
>  	return ctx.count;
>  }
> +
> +/**
> + * cxl_port_pm_init_is_complete - check the downstream port's PM Init Complete
> + * @pdev: downstream port
> + *
> + * Read the Port Power Management Initialization Complete bit in the
> + * Downstream Port's CXL DVSEC Port Extended Status register.
> + *
> + * Return: false only when the bit is observably clear. Return true when PM
> + * init is complete, when @pdev is not a CXL port (no Port DVSEC), or when
> + * the status register cannot be read.
> + */
> +bool cxl_port_pm_init_is_complete(struct pci_dev *pdev)
> +{
> +	u16 status;
> +	u16 dvsec;
> +	int rc;
> +
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_PORT);
> +	if (!dvsec)
> +		return true;
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_PORT_EXT_STATUS,
> +				  &status);
> +	if (rc || PCI_POSSIBLE_ERROR(status))
> +		return true;
> +
> +	return !!FIELD_GET(PCI_DVSEC_CXL_PORT_EXT_STATUS_PM_INIT_COMP, status);
> +}

The !! seems unnecessary here since this is already a single bit FIELD_GET(),
ie. result is 0 or 1.

I also wouldn't mind this being extra reader friendly like below,
but I'm happy if you just get rid of the !!

bool complete;

complete = FIELD_GET(....);

return complete;

