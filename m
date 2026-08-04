Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7825834027B;
	Tue,  4 Aug 2026 02:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785809783; cv=fail; b=MDeEt35qvQ81NY/OKMH7moqABmwEB8ioFcJL4oPRqm033cIfJaZeGZa4X2YIIXEFIMe18B/fBcGJf3o0k5BFv2RnvV0zZ9CDZBw0rfF4sMxNsDrQKad7SeG2z4oD9ipYRjzggMbyEV+TcPULIXyBs1bhiVP3S27F37GbM+mln04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785809783; c=relaxed/simple;
	bh=mpQS/8d2i7TyvC23fSyplAjayERB3axLSySwdEheTDE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VPOZHXT5uizvGa8zJwrA4VQsoI0/HvzHR8aGfo953kEOvabdYYn+vhqGm58I+vLLJWU1+1PVAj8Yb9z2ckN/Y9vmCothHSH/vJiHvukdKt4SazcrqVvFvGQ9Q4Brakp+shGs4P2oGg9oNE/frrOYufuvhS+mA4r2YCh5vUDzbdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZOt3yt5H; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZOt3yt5H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785809781; x=1817345781;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mpQS/8d2i7TyvC23fSyplAjayERB3axLSySwdEheTDE=;
  b=ZOt3yt5HAT2aQgZfIFB7lIhs1c21gMdo1/iZp0i15tlZbeYyD5b9iCp0
   cf39U0GwKu0sC9JwDYou9uDdYzcJ+dczQVPjGEBqBjbX0WbXGfMJkW3y/
   EtyHTkfgA+chXlsJSMTpb5VUu66RXlZStOKhGhilAz+bEG+QfWVW0bAPS
   c+iaILPppcC3DNtY1zcmAZtHrJifZ7kXz4yoUdxBu6PR8dR5YdT9MCKCk
   MB9TnJz54ndBkGFTezb3t33a0vVMid7A9eixfcxBGrGw5i3FAserhAdbM
   IXGFbm4sEDzMG4YqdGaBazSWW62ITPClfocVe/SoFk7Aw+ayk3vlS2C4a
   w==;
X-CSE-ConnectionGUID: EmL/8RDFTLikDQy7+jaWWg==
X-CSE-MsgGUID: lUQPbO7ER6my1MAo3p82lA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="111909253"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="111909253"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 19:16:20 -0700
X-CSE-ConnectionGUID: XG+ldGDsRh29NJ6s1IYxmg==
X-CSE-MsgGUID: pZPJs8toRLWwwiJ4DDH+Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="258714336"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 19:16:20 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 19:16:19 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 3 Aug 2026 19:16:19 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.3) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 19:16:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EU4oOtlkkAkt6I7bUULnI6yKpsAf9NVEtn6lMZmZHGTRckSKojI/kwEX9twf4+dnZNG1rZ42Gxf/aW5AXCeZpMJb8xdPIsFKbxL19HuIlwTEnXgRv1mBxN7ofaHOFR1kEfpn0scLVF5whSo40eYeqYMGwX8K85zxE1/nW2RLOLdm7gErwpPgvOFvqyBieTYuLy4rW2NJMoq2twNo6lsHlM7vmuCiy1z6OJBNGzvAb3kX+lrfhUuUyna0cJVJaNroNNzpAEzoqveHBPybeW/hodQykutiFqMCUFigwkyxwA4zDWns5FqW7N3EUxrjOjcmScQy7RJen83grood/EiVKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1lJ7Z3rCsZzE20/A0y0kdUXu/lAk0zVkgqJDRGDxywk=;
 b=xklrC7FotUPo7UvP3azw51316q8h3avd9CZZO46gr2LBZN9XN0puIoARX9aL+DgDpNcQokEmuEUi0oRChZm+bj3n1BOPmch95yXP/saG93MKbyXmdC9kLgbIz+89oUYzEqazMMjlG/CTS4b1qiUmy+hxOvbm5bkw8oalYxrsg/VvRn/PvwQiwbKgxy3b0ghI+8lJ52fB23wBfd9/Wn9hDljgDtvLWFT3eZCPG2Z35KLeoF/Ht5wGLlKcxNa5yYXezNP1c/g7yFXuyVX/0a1T5VFc2LoMr/ZEV5WPfROIk4rpOxENxF4HZwZBjLt60+VeDcKAtYAw7r9dPRJFw70Egw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA1PR11MB8173.namprd11.prod.outlook.com (2603:10b6:208:44e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 02:16:16 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 02:16:16 +0000
Date: Mon, 3 Aug 2026 19:16:11 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Bjorn Helgaas <bhelgaas@google.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	<linux-cxl@vger.kernel.org>, Tony Luck <tony.luck@intel.com>, Borislav Petkov
	<bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown
	<lenb@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Shuah Khan <skhan@linuxfoundation.org>, Ben Cheatham
	<Benjamin.Cheatham@amd.com>, Richard Cheng <icheng@nvidia.com>, "Robert
 Richter" <rrichter@amd.com>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v19 08/14] cxl/ras: Handle RCH correctable and
 uncorrectable errors in one pass
Message-ID: <anFLa2WhDu86QRG7@aschofie-mobl2.lan>
References: <20260803221810.3685703-1-terry.bowman@amd.com>
 <20260803221810.3685703-9-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260803221810.3685703-9-terry.bowman@amd.com>
X-ClientProxiedBy: SJ0PR05CA0146.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::31) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA1PR11MB8173:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ccc445d-f9db-497a-000b-08def1ce5d4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: U8irBoy0eMslsfubN43CHlGQyRyevWgT/UlnqaEVf+9rWDFErEEibm2U+vKQdEeOIO3IGCs65CqUzlnRWkpRB9fnRs8bQcor/9Kmxok4p5UuKf7GTHQlcGrHslfGGo1Foab+/7gLg4GXu9vAxKCBIiqvraNeKELvZ69593yQOlE2Bk2aXAllMwj4OC4a45UkFGfUQMHaDOKR+i7TTXPMXIzuDrkWSnPf2xWEiGJPGgawM7gvXX9owoVFMUjwswAONUNpOkkHVCwa/UC2Z49Kv2D3F3OySiXF/8uhmthz86Sv3I67MZhvE9V2XTpbli+cG+8wgBi7DsE/GoTG6TO4DxAelbhTpr0V+O0EM/biXhf5YEp+e9kwedz9Fz9/OU5+hUxkUgbsf7Cl8EyjjkFcsFFMOU3CnRPl7vvg24FACdPqDHa4N49NkKKvmPNhma9sGkEDQKJaZrWzOvyrvKu6Zn354dQ4f0HD3pfusHDZE3VsuUHVNP1sxhOxSo5zzBlxRWDDCAImVj7DRzC4aQUZ7CiQWkVI/rQOz7m75zt0PkQ5JQ2QzHYCsI0mVbcZynP98S0i5ATx613iiuFhspH7eS/VZqKOX31N8BhKJ2TMk6/UzqfI8GNNFH4V+hdBppAkl2eBifWjxFqwJyA1ZbSaSlgqWu8vU0oSZL+qICgpeq4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4+xZr1psRIuAa9r9zisiDunaLAcN+zCDhfrud2PxPLZok+XvhE7OIIVcDXNJ?=
 =?us-ascii?Q?DmbcHhCVZkKWI9FWMywCgJC5zmI+I/+HFXWEo3pvAq+a/FXY60Ql+skI9PAX?=
 =?us-ascii?Q?ns8BHv6D8ZR2BbPxODy3u+nG7hocq5/i0IImy/7IIdScxMkGgMJ9bZPuDNip?=
 =?us-ascii?Q?YKNMuKI5yn+lM6XbwOYx7mQ+i5NRXL3aYNeE8Uw8X3kpK3AkF6mzrhTdOvDS?=
 =?us-ascii?Q?+keclheniC1tf1D88gvnQ4wB50Fpk1k0/+CWeUThVvqBPIh7P+SzQlbGw9OX?=
 =?us-ascii?Q?oVYCNI4wDFxMxVOmGgwKaqfpKWf5w6CRnH3SwmCtp9OX3N4LEaAMG6jEfnHb?=
 =?us-ascii?Q?9hBTovVT+YOfUtOMEAqjTersFWNpP/8I6beORRJJtNs1/MTgptw8GXR+43rS?=
 =?us-ascii?Q?KrTVIEd1+CE7DJHxDjBWydk0IOgjs121y/gQiEbW+A+sp6cOVsAGnKb7mYQf?=
 =?us-ascii?Q?61qONs2ghODxLReX1HLVf6B9lVehAIfBtwpc5lI/lFktkI6TIWZQePMGMZOP?=
 =?us-ascii?Q?NvmyMjoK89zUTgajsbOrI+Isp95pNbHEbY1bK2wkVhULPECTEFBD7ooNAeiw?=
 =?us-ascii?Q?E94DO5sitQmB5LspRLZrTHUs2H2ZK6xL2Bih2b3SzvxC59rSrvEw1YNoiXhq?=
 =?us-ascii?Q?eAho449k/rUJml+IpM5noiiacDSCIm8b4rKezb/TZbgqZNx9xNLnSstYaBnY?=
 =?us-ascii?Q?fzeaRClQhUUi/1vTJmrshFrH4FkFkwLzrlRSBbwpheO6X0pkdbpNTVwwtnbe?=
 =?us-ascii?Q?AhKt+RX4lvfz7Oee2qsot7T8BH14xpRqfvyskftsDiwnyXjrAGc7+1EXcRDE?=
 =?us-ascii?Q?BddBQT7aNbowIPKL8q50o7vq5A5zQIqWLWhHRoXOY/UYEoAQIEYP9BC37FQL?=
 =?us-ascii?Q?1ER8xJFaCLHnCCVFhqZWQAdolXf4iSglg2w1Ue7RJGaEjlc63HFw8x0/Cexp?=
 =?us-ascii?Q?8cTxSlU9r3YyOFbV6ZRpkSXHXbCwQwGkffaD6PJQv3+bLQyjbxHBqLGkKWtU?=
 =?us-ascii?Q?03KuSH/3d1FlOtcM8VZ81/brmKiTkrdd55zBw+jF70RJDNmnglkjW0HMuCTe?=
 =?us-ascii?Q?5/ds/corIwVAt0auxngG10oVG0NHIiHK8SFTgMAjUp3IEQ/k6oygInN2xTYW?=
 =?us-ascii?Q?AYSDqXqtelL2VbjlkDNIPOjY15KugravhRd/kUcIqN8bodApCremAw2MK4Nf?=
 =?us-ascii?Q?rRQhSeim0KgKRMF56N2stFsIys0Ch8GV+diqhHeAcBt4d3hklA7G6+Xj6rW7?=
 =?us-ascii?Q?oqyJRYVut63ixu92vl5eRe4Tt6ymLTPGr/93WoVN68nogg3UEdd7em54GIjS?=
 =?us-ascii?Q?WLqzzXuNw2tIZRdIklC/AouuMxaSvfbEYqKK+2lVG00OQHvzuqAiD3VqlAwL?=
 =?us-ascii?Q?RDZbbtlDWR5q3P/BOEZg+c+vGxq7ZwfA/1mqqAefKbUBB0qwuyt86w1Yp/h6?=
 =?us-ascii?Q?/MaG8u5EhcKQxyzR4Di+M4R/hGKa06N/ylNDJmae193wNHhtc9oj/Hq2Gj7v?=
 =?us-ascii?Q?QENwCAWmIps9HPvGdJHqGbmjnnb8XvCv1nnVE7roC0AHLnoLUW1WbyxfumcR?=
 =?us-ascii?Q?O6lZ5NUR0bOiPAWMSt2vJxjRk/Q7+2iDNNCHvgpW7dKdG+cdoBhFwZv97HoH?=
 =?us-ascii?Q?bF/q7JU6LE2NbpDSoO0vjmLyurYTIkOBHRmQ2INq7G9wDadSzh0Pz3aoOXbI?=
 =?us-ascii?Q?UohYDtsvpvZspGAWA2nzlJxmzyzPjP4RNNASPQAD23w5NZButz6h7k2AdCNx?=
 =?us-ascii?Q?A9eWldxxWi4khOE3xIuSCx4xInlkzx4=3D?=
X-Exchange-RoutingPolicyChecked: rfs6rTssJP16omFdMzzLaZR8fDm0h0CbB+hyf94fpvmX7QIFvC3PIRXcEfYZzw5YhqFu8WZP+GeLrkDIwJuoB1hENJFFW1Hfm1d3rg27uSR/SvCgNGpPVTeXaKSR7tMVr7Djz8rng0UI0AkCUIKvYsh6AxIsv88ENto5fjk+vmIl6lV6xKCOuiJDBMzkUBQjtlmL00I4c+XqK6CYilO6YiiNo72MpdhBdMRwTE4TjJLWJj83mcfhArhlJdprM9cTUUhuWI5Jj/io7dUzM5NcjO+S4K5DNG1UBGi+tVrTFew0JtOHBwc97HNVBW1mjk8UOwmzIn3H0LMNoKoQlWd3fA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ccc445d-f9db-497a-000b-08def1ce5d4b
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 02:16:16.5773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/kRq71o6uw+pnyO3GzysduJpJgMuWfgwlsoaF6IGPx1YIDOTsIvNFvT81vpSOKq5HpnfGV07+3qGGY8MbbyjqXw2Q06rJndnZgdQ1K2ZFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8173
X-OriginatorOrg: intel.com

On Mon, Aug 03, 2026 at 05:18:04PM -0500, Terry Bowman wrote:
> cxl_rch_get_aer_info() reads and clears both the correctable and
> uncorrectable AER status registers in a single pass. The previous
> severity decode returned after the first matching class, so when a
> correctable and an uncorrectable error were logged simultaneously the
> correctable event was cleared in hardware but never traced or handled.
> 
> Handle both classes independently: dispatch cxl_handle_cor_ras() when
> correctable status is set and cxl_do_recovery() when uncorrectable
> status is set. Remove the now-unused cxl_rch_get_aer_severity() helper
> and decode the uncorrectable severity inline.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
