Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7586635DA6C;
	Fri,  9 Oct 2026 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570195; cv=fail; b=PZqIxj+AkgfYURdBpvepUNgcaPl77S7SfRHCIOEs4iumKDp6iA99cUgaIS5Wyy/qOPwFCr+Ys0Jd6/P+2Y0u3ORuj/uGxrzW+gU9NCNsJt8H3Vf9+ym/js3g0ipK6B2lNBtTZ/WUgtMy8DKX41KRx3X73cHVQSMbbEY79sKNUk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570195; c=relaxed/simple;
	bh=XTnWa2YLUJcFLwcbI97X1gzOwEQOKwTxklK6dvcZgww=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fp36HKxvjcaQp+Lh+qYqYZ0zqohtG22eDC4PnB9W0DRUu9Ic2EZdYhcwhJ48XkzxUc7dGXMK18lhdfaEchD2goGGOQgOJzQqyO/IS/wR9EIaTmiHnFYnPs5K1APuslOfPa23d9zMJufBMM6TUePejlQ9FJBArQPh06yeC8RYkGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dNHkViYB; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dNHkViYB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791570194; x=1823106194;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XTnWa2YLUJcFLwcbI97X1gzOwEQOKwTxklK6dvcZgww=;
  b=dNHkViYB13y2Wi3W7HJp+kbJU2yuSNXa7OBNpM5W6z2gzUzrV4vJaOiF
   cmba87DLoX3snpq8V5eGFyvVlKZyr5D/ojcVoLUc9ox2udWgS4YtMJlEI
   tQFZbvoc1z4umV9B4kriLR9yWwBZxGMooWybV4MhX6Mzsv3WN40Upjh47
   m9zmeRXECRXImNpFwU1XDw6gIm7fQQldj8uVpYQiqx/4bTAJ6E+QHkvfc
   uD2a+xekFwg/0DYYKyvUqhTkvc7w4nJZeP3M+67cUrCeq5oFsMqrC6mN4
   P086NWnt/MZfRA7hq7uB3aZvSOGJr/WtQYkF5xsrzO1ufb0O4Q/0wN2iP
   A==;
X-CSE-ConnectionGUID: M8isxy1nQUCnlViQIJMVLw==
X-CSE-MsgGUID: 4Y+OuAKAQ2aqCqB2raiJEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="377363"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="377363"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 11:23:13 -0700
X-CSE-ConnectionGUID: tUyqIYx5T7+lzFmXCSHtyg==
X-CSE-MsgGUID: vpIVDsIQQqSUsw2SFDCv+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="2111276"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 11:23:12 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 11:23:12 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 11:23:12 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.53) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 11:23:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rsPhROnXFrrIapdWi8aenDGFfyEZ+IbXV9jTUnqKT0uGukKOdSl9k2DgVBaS6NTJkF1rQviCjwT5w1FtohJ7qRin9oYZLrsSLkS9KI720T5HzVDnD8SEE8kePS7NnmVTB2NVvho4TRFyhdlJJHwX1eXVPJh7YYseyzS2PMN5c9RUhjyrpSgoQPseKIBNnJKOApZ4PilgnRigVSx4ox72bIEN0rhW1syhrgacnqnhH3VaJvg1CZl7xu8tUBUWDkkttPInC85V4INccpX0MX9Cq9BDn0oi3Gp7Z6L6RELt6cvdT759R1EXWhke/Eb3mNgpYLW2DL60oZXUuxTshibjOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8mUJxSiQTM9wfJptVx3+/W3J89HjrdIwdqWo77TAoE=;
 b=bFJSMzgvOcMIWKjeaxARJ6WjuIbB2AcMqyWEuK9BzhfcAyOxQAAcuWmhNfACQvq65n8z0A5sCJ0bZD4/UCAQxrII9hdz7/0xAsfbhagakHwVFnZgjHu5mN6oIFEdv5Vgf2cYzpJjb+YI7wNbFoYIhrfCDYxro8Vyey5hJpMepP/8jnWT0Q/uZp1Hx69dzUNP81oEDQqwVnCtJ0vXe/RtV4hH5Be23KIcpRME1ROZbcwRbhh6Tcx1duiJdhHdLCpmoPbAYoomQf2V4rqq5WIwUY4MTwQ9+vhJBgXckPDql/NNj9UB/zb3tk1jalb85h6kQrxJGQKT4qTtMfSTz9OhDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH0PR11MB7493.namprd11.prod.outlook.com (2603:10b6:510:284::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 9 Oct
 2026 18:23:01 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 18:23:00 +0000
Date: Fri, 9 Oct 2026 11:22:57 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Koichiro Den <den@valinux.co.jp>
CC: Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Ira
 Weiny" <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Richard Cheng
	<icheng@nvidia.com>, Terry Bowman <terry.bowman@amd.com>, Alejandro Lucero
	<alucerop@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/3] cxl/port: Convert PCIe link latency to nanoseconds
Message-ID: <askxAanS6O37vOwF@aschofie-mobl2.lan>
References: <20261009045452.1107921-1-den@valinux.co.jp>
 <20261009045452.1107921-2-den@valinux.co.jp>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261009045452.1107921-2-den@valinux.co.jp>
X-ClientProxiedBy: BY3PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:a03:217::11) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH0PR11MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: ed525e22-952f-4481-c1cc-08df263259cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|22082099003|18002099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Zoa56c6dBmNgiUoX8ifYMSevvKet/0O4js9Wb8qUUhh6WKkPJXQ+vGpDoQIDdDdt1V8OEEWzDS3FbcmWq0GaaRJ5fqgXT5cnZC/2lsmPnJsh7mdmlyUkGYafQ4rb8FWyi0aWzev/yBK3y44hS/KImfTRKpHNJ4c3HtblTfZqj6WZQHhoZO8sneTJk0jfM+B0pGNrjJnyBRHCmcezeBq/VErmXqoMRe/k5Kd8spoobB/gPNucb1+o8GWubiYS5sKvO1uCIEfQGA6JXkTiR+9hSpauK2qpe9NiK5EfR9EyMIOZ0SqxGPFh3PyLgkH2vlmBc1cgzqfWRLJU7smB+wEQjdm+f/7gLgqae2QP+AKyejIWi1+Ig4up4uM9BqJ33WZKNiLvXUU3WytTd8eJtJISMhIsdcQ4fknGW1QCwyYBE2zNrBFacEhEK4M3CTbqohElATKxGLl0+BpjOcDxv5WNkE6K9vYL0VPS+c99BC/SZwChnS7lz75K6napSQehsohkuP8tSNfnjfFDJFiVnSsMW2jRA1KiB3Yzf/BOvPrWYWEcn5LsvVit/Cb1mMYc+gxvcxtTTKUc0GWaCeFslxF/aqhcEDUJaosOrUW2QuzkKgTLf2JAu6QrqpqRWrNu+EnKc9O8CkBUJzi2qrs1ZCDchWM6a7zd8AHE/LghZbhU2JQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GmeJLqScfOCqnK7PYIEO+zceqRnQYE1b6npAl6XViYORIsFjtUh0d9NxcTAS?=
 =?us-ascii?Q?eDRv2Wmd1mARRtyG42oRnk9WzCaWN8F126AsbtDBCZY1P4FdfmyCmKOsEMGj?=
 =?us-ascii?Q?jI5sIeidzQrMd1edvwpeKl6dGK2GT43OaM3iPSyDaPKygNi3/s5Q46spqAEz?=
 =?us-ascii?Q?8B2mVt7qcgcbv97qqp+TTPoZVdHBIO0cYTcMPYNhUCtBgLHFi/XW5DcrQA7n?=
 =?us-ascii?Q?1AD3I5ePZgxE2ZXcn+nFgQfM5/aXvUMHC03alHGSqbnPF6eXoi3yFanl2YpS?=
 =?us-ascii?Q?TgRrSlHYYUCHGezlOIoZmmU1WSvCSvvdjTMi1D5YNSnKeQWe+3GDKf+cCUVA?=
 =?us-ascii?Q?F99IEm/KBz04QlDw3GkgPmdwGW8gPeqSEPVBsCUqG5BMYt46VahToWz7GTDT?=
 =?us-ascii?Q?LZkSNSKBzO8r2cYZlKtK84gOatt3/4Y6g326bDIIGOad6vbpaEVhtoLpjFBa?=
 =?us-ascii?Q?JgI1pi4irVRxxVJEKqP7/HDirOe60oV7fOv0EPi3I+gg4j+gpntYHgYNu797?=
 =?us-ascii?Q?YYDFzuRWjptClJE0noAkN6N97Ps2NsTl5gUh0ejtn2G4P8bi/8u16h4WDH7J?=
 =?us-ascii?Q?M2stHuT5FCyVcEwM8zPGTqTmyne5McqC0WDlM8/iyeuetXlnuayFv+5TQ4V9?=
 =?us-ascii?Q?FnNT99un83yWK2AVYEP3T0L+XZBD1rWaTtLUWpAnIdJHEaHRv6lbq7MX4tJl?=
 =?us-ascii?Q?9CZ4uaXNOzhSisn7n7YeCgTtjXqIP6crnamsS3o95bOVsrdgYdDgP16l7PgP?=
 =?us-ascii?Q?jaT6nDk96j5Eu3aZlwJEeBsEs4LwB3aMl0+a1Z8tfQd1srnCGNVRYNVyAHxF?=
 =?us-ascii?Q?4EtQKe9x5iuDPNw2cR0TaRNVT1KXNCJl43elW63WMS2WtQsSaJg1wy2C0jlS?=
 =?us-ascii?Q?ZKwoqC3Z4aqWh0FkYLuoyxE+SYjk+Ex8AVOOGcNis9TNqTMB7l8UVxKdcLgS?=
 =?us-ascii?Q?MAqSgfs3G689E4jBKilyY2YR1N01sRlv+P1C9Jij+Xn9J7tFjxyUgUPJUTUO?=
 =?us-ascii?Q?LUivU0DSxR31ztmHrBlIeIAuYR7X4sM3Iw1FXQI8yDk0z4ss9G3Iqb1J9y7w?=
 =?us-ascii?Q?gMQ6cg+w+XFzaC4t3MmTGfzl8TT3rIRYKxq6A1BHQUoBP63gsd3b5oyyKDwt?=
 =?us-ascii?Q?bWXEr6XbRxQuqpfbXIsIwzV78tuu+VNFLAwfmo2bCQ+0gL6mIyaU6PsKxx5X?=
 =?us-ascii?Q?9LdPxaF1iK+7g7dRCGsh1vZODBK8mc7LFxuZvjfgODDeqFFmALsktU3V210b?=
 =?us-ascii?Q?MmlPservsNVCp3UaNYID0fPHCgGVLKAMoSfC8FSRlmINg/n+wKIhFpVwR48r?=
 =?us-ascii?Q?+7RjAak5tx0t4/vt+nwPtI1JNpaR+FWUJSbags+HribHfb6tFT4xOrq/s5ow?=
 =?us-ascii?Q?rqLyQ6Ekm8koTuKZSlILZpuu7D6lD7TH/QPp2tYu9mdkUZ8phNA98/mf42FT?=
 =?us-ascii?Q?fxLdCxk6+C9rw34aL7Yxmj3tGXIU1M0RuUtJq90X/rhEy2EXG7NtISd+xTxU?=
 =?us-ascii?Q?V+i4H7OJ7c/nSh8t31gkHNMcjVg4ogQd2DcATzhyKdQmhVw4M/tqqXIZruac?=
 =?us-ascii?Q?Jgl3Sm0Tdc++1WEuSaKCS5uxCQ9vJbnIJuHrOjt5D4azKRGIO1DDchpuqBtu?=
 =?us-ascii?Q?jS+IIbyOY+dEnBbzGhL8GMZq9F0IxQxxdKpwDoWzt2hnBO2YDSXUyd7aGb/O?=
 =?us-ascii?Q?Ote6osMAmAAD+4I2Os/18i8uNBqdp+ND0fojvooNIgL00w0OBhsydS5IrkVR?=
 =?us-ascii?Q?Sp1F+P1RddHEfEAEjCjJ1986KEyMP60=3D?=
X-Exchange-RoutingPolicyChecked: Whb9annBXlMIaXikUhred26a9/BeIxHuvEuUh2ZHMgf0FgGvL2lpcrwaulUd6epM04RxRIccCieJ8jQ2/bYuNKGVVadhsZCS07xNSqEiHSPZ3SI/JAKTecQqoaHuXm0OV490IapO2kTyAEPLgxNP0nQWLrPwk1yRKAWIHpbWvn4bmdRYjrO3e4xklOVzpf+1MijnL/sgO7App8amLozJYepQs8yTBlqTmGTxNYTQKpx8HiQb/xYBwpzuaHYtQgCMrCkw6qvWG1pfOKm5OMG0JAgnFvF92MjCteBw3ZwZ84+A6vScpT2ii6Ht8asf4EORNGm3IzhmRMgGiu9OglL8Tg==
X-MS-Exchange-CrossTenant-Network-Message-Id: ed525e22-952f-4481-c1cc-08df263259cf
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 18:23:00.9110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y2ygtWOrsiItr/cmmzfamHJqYO3Bd0Z7WNru9uyjOwNlWeRBsEK5WEjQKOldWSIRSm2mfFJTK9eMAXkp3lF4NavpKJ40cqt8Yt9R5Oz1OwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7493
X-OriginatorOrg: intel.com

On Fri, Oct 09, 2026 at 01:54:50PM +0900, Koichiro Den wrote:
> Commit 51293c565cf4 ("cxl: Fix incorrect region perf data calculation")
> converted CDAT latencies to nanoseconds and removed the conversion in
> cxl_region_perf_data_calculate(), but left PCIe link latencies in
> picoseconds.
> 
> This inflates the FlitLatency contribution to region and node latencies
> by a factor of 1000, exposing incorrect values in sysfs. The resulting
> abstract distances can incorrectly reverse the memory tier ordering of
> nodes.
> 
> Convert the FlitLatency contribution to nanoseconds before adding it to
> the access coordinates, rounding up as cdat_normalize() does.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

