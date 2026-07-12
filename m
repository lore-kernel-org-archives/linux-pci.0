Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7569F3A7D7A
	for <linux-pci@vger.kernel.org>; Sun, 12 Jul 2026 12:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783858529; cv=fail; b=fHZJPDYIGIfUM4LqjvMxCpzaLURatlGww0CmOXlmudZw9vPvu48GZvlw8kGPuQXWyhgsiZnjNo5ON/k+KjMW2o9Ny3bxvRiiIJcj3bmGOwinIX+jfdEgyLuUX2em5GBkkmMqh/OpVz2PB5OKfW9XrUCd9EcSbwYK9XvuD0LpUgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783858529; c=relaxed/simple;
	bh=ZLj/cvhCNwo1NlX4HRjNEx2AmRhAqhiZMcY9qfG3tok=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hpb23O8KG7dfBqh+qlj66+MTfPukVvwZRkMQEE/c27DEg/ouGEdCNGxDRx9DbY1j1f8SABb2BpGeWSXnH5De7iq/gfmAqjhJZOSLBpwqVoXgj3OytYBUxuaYhDenQmT5P+3xzeSl2A+bhjpSNTICnDXvuCLE1Y2LPb0pTocaQjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TzdJmT9y; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TzdJmT9y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783858527; x=1815394527;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZLj/cvhCNwo1NlX4HRjNEx2AmRhAqhiZMcY9qfG3tok=;
  b=TzdJmT9yw65tOVUvQP7M4Icam1md1U+y6skmLC4+hNmWwdZH6bJQHUxf
   9vg+P1URfBlZuGig3pCVeQi5fBPzkB9RUSMwzyamVEtOtEOd+BFIwRjlf
   rv5MqvLlD5PsBRQqEUgjAebyHRctoQUigPAUDFIKpFWI8rZzlkO/uLKrl
   lY68niAUJUNosYEAXxGomL+wDwwziNifbDBF7EHqZIrY5zgXH2wanKnhp
   RDgnSHfXP9FZ4irLVKYjKwGwTCLIgacXVStl4XEsU9d5tEkfCRzpKCDwk
   T6zjDVrBo7ZXH4CW7wOgCaL4iDn5Fb9Q32G9zo2NkygZQlQ2s5QY5F8Lk
   g==;
X-CSE-ConnectionGUID: PPOTePKDRnSxVYVtzjgXAA==
X-CSE-MsgGUID: kyI7hFXpQVS5ErZKIodHRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95093773"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="95093773"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 05:15:26 -0700
X-CSE-ConnectionGUID: Gk3fpUb2QROHlWn7UDGIKw==
X-CSE-MsgGUID: YilvZeSDQH6FaBBq/zTEkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="248937662"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 05:15:27 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 12 Jul 2026 05:15:26 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Sun, 12 Jul 2026 05:15:26 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.64) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 12 Jul 2026 05:15:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJyW0gn9yrPfGUd+wDP0bs2DuG2lZj2cp4sQfCHOOlBnHRu1Ih8CoVtjek/0kDM7kBzKv720YC2FxorM0M64xeXNSQ5mppZUAExnIXNloJn4bk7azcd2kbkWm9PVplzy6vWSrzESnXzFulOj1NiNeBdlLIc62ihYcqnJ9vN5R/C10Xp/rCfL1FhFrGd80R/G86LHWb7Fcms00cIZjRYDfrneOYtm6RQG3Z+lp5QtHTWIp9b5+xtzx341mA3ZCiZt3VHA13+PtrsJDUFbpmscqdrvmgpPL0TCtvmZM2xYTBB3oLPd2b9LmFRfFTq7HDSX3eOsMt3MzEqAdYVV1QfAQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wuikHmU8kcMu+LLshpAYz2CbgbIQPawk7QXJDaxXmt4=;
 b=SPU29I5TtWowKFJyXyppPXZ/6ta8Y0FtuIkJMGIX2P15zEVd+mq6QQ+Eny4hLamRSZ7cHIExhBtBeoVxKFI104ONYcRRCdSFbXPfJCVuG1aXFmVQn/D4a4Ew3SM8y50Ri8rH6jWlB4zJEW5l8eAkusA8pOfp0gVM0CXNtwpnzNMlxJ2nw30wflrlJ8Z8gT3dGwjeqO+R6+aes2WOWs4iGz5+3HZ6Lp/z5efEaDC8yiLgKHftCO4U1U2HsHyW12dYIE5Kf8jhRzEveW2pF79dXd31qnoPKnOrSnyTfNZRwBVH4xKesJeOubUjRjZpONJloWeY0bw/FelTaH2M3XouaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5214.namprd11.prod.outlook.com (2603:10b6:a03:2df::22)
 by DS0PR11MB7880.namprd11.prod.outlook.com (2603:10b6:8:f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Sun, 12 Jul
 2026 12:15:20 +0000
Received: from SJ0PR11MB5214.namprd11.prod.outlook.com
 ([fe80::5926:3836:4212:8640]) by SJ0PR11MB5214.namprd11.prod.outlook.com
 ([fe80::5926:3836:4212:8640%4]) with mapi id 15.21.0181.019; Sun, 12 Jul 2026
 12:15:20 +0000
Date: Sun, 12 Jul 2026 20:15:11 +0800
From: Philip Li <philip.li@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: kernel test robot <lkp@intel.com>, <linux-pci@vger.kernel.org>,
	"Manivannan Sadhasivam" <mani@kernel.org>, Marek Vasut
	<marek.vasut+renesas@mailbox.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
	<kwilczynski@kernel.org>
Subject: Re: [pci:controller/dwc-rcar-gen4] BUILD SUCCESS
 6bd0f589488396d14c4d9e4f030954ccc2ee4f93
Message-ID: <alOFT25GfG2Spj16@rli9-mobl>
References: <202607110222.SU1ivW18-lkp@intel.com>
 <20260710185046.GA979125@bhelgaas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260710185046.GA979125@bhelgaas>
X-ClientProxiedBy: SI3PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:295::9) To SJ0PR11MB5214.namprd11.prod.outlook.com
 (2603:10b6:a03:2df::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5214:EE_|DS0PR11MB7880:EE_
X-MS-Office365-Filtering-Correlation-Id: f3d4111b-8eb5-4a4f-dff3-08dee00f3dc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|22082099003|18002099003|4143699003|11063799006|13003099007|56012099006;
X-Microsoft-Antispam-Message-Info: 7PitQI7F70Hk2TFu6zS8P59WtDJdysKhqVfcaXglO5uRhqYqe72FjYTj7yrYpI9TcazMjBBZtqbaAZLEglxm2SQfjjTl6k8c88uJ1JOC+bli/1wjOSOn05UOKBW1enA42WGUv8uRO/ezYJSU9GSMYVOwXK7vJ6aKUGk0yuK0nNpH26bMzZ1h7NqVU4N38AjtQTNpZKgaUg8PMq6XWCu+HdM3sDo1+enfuRm1vS17Q3JQdYkvrYOQVqRj0UORebrba8d9MTamLlMo22ldOqhccvzpwAi73OzRdQ2VAAkIgMAc8AXKAr8G4DGoDQFy5U+41mH+DispOpjv+E4he/RjLY/j7C0I15ZSJBN0uJsuKcunjzZIj7jcmD95Rrwhk98HZdQYhwtvNH56icn9TYDQLdYGoXwf9gFlnwnL2J5H3uhlyIVw9G6LYvdwBzre/lYJ9oYt1GeWE7yuk1KF3Xd4Z/7ixupBTp8p+gBiZ3hCAIZUzhE4ZA5Q16v2j+bcIwsg+Tn4mW2FI+GERsDuU4amfDEF/SiEAWHERP3hFiCNuE8+o/jFfLk4IVUW5QKXuQCY73EHWVdPYUPP9K3Jz8tMO75wwfp6DsskdUiRcUPZpzOH7awlwGJ8tcw6dzthbmnxxAAl2YjtsSCUWwySPObVkjwygXTd+gPN2FYqIIDd24s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5214.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(13003099007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d3JPlkL98KS6DAhkV743bIOkWcARjJc6MJvPfSQRUJdx08bDcJyzYAznySPN?=
 =?us-ascii?Q?rPS+9zfbtNN6Urzo2vas/DQRrKD9HonbcWCjz4QIDNhUmlAaDZ8DR13rYEwu?=
 =?us-ascii?Q?h77s8Z94BjZWNboiXfjHq4I/goiWO5aV00uU4fQOHN95c1HUHYyfWEMf3IXh?=
 =?us-ascii?Q?MjLS+0nhWZHGNKR32fqu7fMogAFVCgQipKMEOKX+qJv6WKdOUeaH5W65EWvp?=
 =?us-ascii?Q?BjU/vttCDyc3rzo8qosN1YL7758+N9m6jPq/gQfxtC5wZpf1wMVkp1HyUuTg?=
 =?us-ascii?Q?oE5KPgxtM5xdweW49QHXHgIGx/TSSRTlzsj46yf5Fz6yfogw12gxv58jYZ5x?=
 =?us-ascii?Q?2dzoaizx31dR+ebCbG1qnJafr7WrKQxJT/JYh/XKJsQfHX0rEVlx7pY/S6yi?=
 =?us-ascii?Q?bvUDqXc++mKATTDE6T8t45rpbRj89FnhF8p+nTJbsSpN/DZWGjkLpLSJZ8u9?=
 =?us-ascii?Q?FtqKc6HkbQ0Moy3arFJ2zTkIxvyfgInYv4Cs3GbKoL8SGI2+1wxNKztggNxi?=
 =?us-ascii?Q?5eFLmOaiQETwIE3OsblLEIdvpUCmv+xMj7rgtwMrg9XHW++803/KnhkbDF4e?=
 =?us-ascii?Q?NHIgFnkcA3whcLXDUv9O9UVcArJFmWRxoMHJN2vW1kLWG613HTUQXdtp30Uj?=
 =?us-ascii?Q?6nu1wSpf4H/E/kGE10sImD/Ovvj9eZVPwPohT0PDwyOu9UcJbGBgmBNDwIBa?=
 =?us-ascii?Q?Pg3ZNWBBmHCagSZrvNSuFryNro56eynyTh/1JC0BjiJPPLmeWJnbs5JP40Gj?=
 =?us-ascii?Q?Hqby+wnVsa+mWll9CeqOwqBF+p2QxJ7SiQhVxqx4f+DpuFPuKPBx44HbTMkj?=
 =?us-ascii?Q?NeeDXn4o05AZVJ+LG+AFn3i5hC8rpWt2MzDuWTxRan23Wrce8a56a0qhWOdZ?=
 =?us-ascii?Q?wHX7Qa/Dj8KjZLtVt2MifqGw8r50oPdzg9VGgVZu56f45WxSpH/5JjLyrFdx?=
 =?us-ascii?Q?b0v6n12NRmEZuxUCeMa2AiucJtiB1Gd34ZSBdymkm9bAmfP8AmNpp5fWF4of?=
 =?us-ascii?Q?hWhDWFa8j/S5kRlrpMftHD62/7Uhk+fruvpouakg8ZaXBcKVSGWFgJGP3ylL?=
 =?us-ascii?Q?v0JDUh3lNCieE6Rky0sjh+sviAs6mzQR442DzW1jARU/DosSFu2gKE1AJeAY?=
 =?us-ascii?Q?1vGmHkfI1eiDWfJLXJXPPxhsWPMYUdpk/jc2hZ3gnP4c0kb+pNr1ZDp1k2A5?=
 =?us-ascii?Q?R7Te6frzKdGzymR5QZFQevbhkRN/NCmhv1gR3DQ3hwdOXcyD34Nz7ypScOLb?=
 =?us-ascii?Q?K4zGLL+7F3JhimPwJQGnXmNaSS/31DNG0WCzL+Zf3PxPT2AkIWxKJ5QD5bcn?=
 =?us-ascii?Q?bnYIax27o7pkqyhzmD6taiNr4YE4ko1uyLFfk7OwEVq6hJTVXnom2LBjaXMx?=
 =?us-ascii?Q?66KyOeee1Ir4+AhmrdOEGBSLJdBgDEP8xKRHqhP/vlzHRiHKFF/YEtyHHEj1?=
 =?us-ascii?Q?hKoQpVcaScSVfjD12za62kO2CpRYvTL0SRR7FS1qEmdlhnucnwUPYLiNOEWX?=
 =?us-ascii?Q?wKv0CLWra6VZlbPa7+Q6tNAbZEZLC4ViW0GGRQhlYjKJ8PobS/7meQFyNm+/?=
 =?us-ascii?Q?gzpIZFsUAwpb0saKQSTtRE7/cw1JwiftjDMG83RkA6jHZJYb517Ibv8uk17M?=
 =?us-ascii?Q?b7X331CGdEIy9jTsZA3BtN+/mZpFMP3R8YP8O3gNCUoQJlC3tqOZXl6BGF82?=
 =?us-ascii?Q?1KYN5aYDGxGXO7Di+Q6Guk7Co8MpnzfiIzl45CfgnNJEfQkcfrSDVF99OSKl?=
 =?us-ascii?Q?tOApo5fHTg=3D=3D?=
X-Exchange-RoutingPolicyChecked: MmDe/7pyeGSFrpFI1XD2XPpjpH2CKRAks1k2qdZ806O1I28ugmf5nkCvpqSK43ytRpJSRs8mq7jlDqRgBu3N68NRvDFMFJqzVmM6y6tU6F5tQEB7Oe4ZkI/xjLaT/OEQUJl6OritU1u5EowrKH70Wf0RShvw+qGaka6XDslmHGiI9nOeLw++mdIcRhjJJJkIKyjN7P60q4GL79t8RjsI4cXZWBA+fOJAMm+hoFWLkdcziBhBjwI5ff7f22HHkOfGw1DyIjF5DaL9ac7pVk/NsHPYCrrgeqdRFsrHBpok6B5gAzdtLGYwjPPWdO6MdodB0Ts6HrDI7ae56UClZLLIXw==
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d4111b-8eb5-4a4f-dff3-08dee00f3dc4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5214.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2026 12:15:19.9802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Mp7bI9A7STaY55/7n/AzQtuALpyMEO4oPtdJ5KniWaVEr/8P+lawiJ8Vw9gQTbT9v5GvfmwcV/teNeIE6bxXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7880
X-OriginatorOrg: intel.com

On Fri, Jul 10, 2026 at 01:50:46PM -0500, Bjorn Helgaas wrote:
> On Sat, Jul 11, 2026 at 02:32:33AM +0800, kernel test robot wrote:
> > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-rcar-gen4
> > branch HEAD: 6bd0f589488396d14c4d9e4f030954ccc2ee4f93  irqchip/gic-v3: Add Renesas R-Car Gen4 erratum workaround
> 
> I don't think this "BUILD SUCCESS" is accurate.  On x86_64, defconfig
> plus all PCI drivers enabled, building this same commit:

Sorry about the confusion, it reports below error in an another commit. Then the HEAD
of controller/dwc-rcar-gen4 is rebased. The bot considers the error on new HEAD is not
a new one and is introduced already.

I will think of how to add more connection of these build results to avoid confusion.

  [pci:controller/dwc-rcar-gen4] BUILD REGRESSION 14e8394423ffd4fd28884ec8b4d5ba15be6e7e0d

  tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-rcar-gen4
  branch HEAD: 14e8394423ffd4fd28884ec8b4d5ba15be6e7e0d  irqchip/gic-v3: Add Renesas R-Car Gen4 erratum workaround

  Error/Warning (recently discovered and may have been fixed):

      https://lore.kernel.org/oe-kbuild-all/202607100310.iQw5m9Uo-lkp@intel.com
      https://lore.kernel.org/oe-kbuild-all/202607100424.xo06gLTB-lkp@intel.com

      include/linux/irqchip/arm-gic-v3.h:605:10: fatal error: 'asm/arch_gicv3.h' file not found
      include/linux/irqchip/arm-gic-v3.h:605:10: fatal error: asm/arch_gicv3.h: No such file or directory

Thanks

> 
>   01:42:29 ~/linux (controller/dwc-rcar-gen4)$ git --no-pager show -s --pretty=format:"%h (\"%s\")%n"
>   6bd0f5894883 ("irqchip/gic-v3: Add Renesas R-Car Gen4 erratum workaround")
> 
>   01:42:32 ~/linux (controller/dwc-rcar-gen4)$ make drivers/pci/
>     DESCEND objtool
>     CC      drivers/pci/controller/dwc/pcie-rcar-gen4.o
>   In file included from drivers/pci/controller/dwc/pcie-rcar-gen4.c:16:
>   ./include/linux/irqchip/arm-gic-v3.h:605:10: fatal error: asm/arch_gicv3.h: No such file or directory
>     605 | #include <asm/arch_gicv3.h>
> 	|          ^~~~~~~~~~~~~~~~~~
> 
