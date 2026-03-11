Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E940F318EC7
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 19:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773257742; cv=fail; b=K5Fg+lhGEKZJlrSzqlJzyTXV9byOZIuRFDSyjDS9KTcbRoLmm8Lw2Qv3iHm/krTcZ2zU73NS8yEEhMYhhzdrhJ07TcugUf5h/qViVXacaO3IWeNousTOHHP6EGo11Leu12ReOsZlCdNHxOX2aQ4IGz5XWNmUAt3mHF4ku761T0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773257742; c=relaxed/simple;
	bh=duDGYDGg3crn9+K9r1pBSGeKIgzgEUpKawJHG4gk+4Y=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=A/8G2tUQuCgrjEGsK49wuAe3hhmIh2PLVFw/0j5y6iwO57/m21wIRadXqskAyEKZ0UUTMf+x2SaDRtshAIBEQuch7JBdxSDsJU+ZSk1glhTGAb/hq0FkHjpwHICXu3PPehG9y45Ey6hAmh78cE8iKOOTM/ZnmZhgqOb+sSkS/nM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AXrwgC/q; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AXrwgC/q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773257739; x=1804793739;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=duDGYDGg3crn9+K9r1pBSGeKIgzgEUpKawJHG4gk+4Y=;
  b=AXrwgC/qg/c/P31+1+6susA11SBLEuZjDmSMRV9KvG3/8NlDWGP5uD6w
   wcVqyZhDIivFOf39YfGr3VW/kNxVLwrSEvupxfiyDzNwYeIW8SmfJtXxu
   QnFlFmT4bw57ErXYj5DIE9JJbPXnDdog90CHKoL8/9iD3GKkFMXRZGioL
   HmKM+ppDMfOHU0ajlHXbyuPiCjn20ZzS5HtVWxG0Rq3LW/Dnkf/L/QyPY
   9Eqq4waao2ZZqKdg7TWuCWKern6YE27gEQHKNDotMv7kbW4XWyD1BU3US
   fCoEDiSOaMUPMOgDuk056QWkUQyV8SKGOAQX+El6OqStxscVClagWloSp
   Q==;
X-CSE-ConnectionGUID: DrpJTQPkTqGWBtqwwCEaXA==
X-CSE-MsgGUID: 12WpmoPiRtq6wtknU9a3/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="78232058"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="78232058"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 12:35:38 -0700
X-CSE-ConnectionGUID: WMS7PYIiTwiji6kEYZDrkw==
X-CSE-MsgGUID: 0xcSHL+5TzeI5ovVQCGz+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="225034331"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 12:35:38 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 12:35:37 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 12:35:37 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.37) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 12:35:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YGN7XOIatelnTPPkgGQfm+5nKJKICoMKUKITGJfwv2OVnf87DgchISjG+F26BSnZmyowuQzzupqAvRtLIaoS+A9EoFK27NlQazg30zxa8GlwS48Ktn5arVXULUBzNY2HJoshP67t/8Y+nWbyaPIM8ecfbz8s6sxfjzBYW03wX78PjdZJXN7r70Or05rtvOUJaf1f0CgU/6miHYOYQxcAvtt0KdreRSjjCLdTM+jojibeez2vT98wM+8qt6jqMuQCSPnaicHQdTRW0jBTBHl/UlBVE1zs03y8rO21AFEcEBpOU4c6TtiQmRvSu+bOiKbY9WzuTo+HEUhbdnWZzfNndg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pouzZFZ2+5GgjftKdGACsKNNtEeV/0xkEAvcoaHXf3Q=;
 b=F96d7rL3nn4XXszry/5f7OShNLYKUukgby2acuaMRkIpBWiUJqWiT+VzRtU8ykD/JCkVafXVb7w/GKvAm4xF+dsvU4HySGAwgvfmPd1ObjMLD30mZ/nS+ifRe4xsVElibIjZUjn31usnx9fivXoXZjB8ErMYy8jETiOGXHWZfOQw+6fmtGTjPj2YviP6lboporLjH4CUHR+19t2JjtVCF+C9C0MCBY94L8kydkq1bs2SitGdUTa0h2gB99U+dA52fViWJ7fhEVGOMCO4gI8fACAGCJ2z1FEofJUtnbs4KYDNpqO1ncWC8HriYWEQdMS+zl8gifTJ3uVCNTxRqW/FhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB7775.namprd11.prod.outlook.com (2603:10b6:208:3f3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Wed, 11 Mar
 2026 19:35:32 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 19:35:32 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 11 Mar 2026 12:35:29 -0700
To: Bjorn Helgaas <helgaas@kernel.org>, Keith Busch <kbusch@meta.com>
CC: <linux-pci@vger.kernel.org>, <dan.j.williams@intel.com>,
	<alex@shazbot.org>, <ilpo.jarvinen@linux.intel.com>, Keith Busch
	<kbusch@kernel.org>
Message-ID: <69b1c401a109b_21321009f@dwillia2-mobl4.notmuch>
In-Reply-To: <20260309205009.GA582379@bhelgaas>
References: <20260217160836.2709885-3-kbusch@meta.com>
 <20260309205009.GA582379@bhelgaas>
Subject: Re: [PATCHv5 2/3] PCI: allow all bus devices to use the same slot
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0036.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: e6c3053a-f158-4b54-aa03-08de7fa55bd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 6VZbjSul403GDr8b3ZIXUNHrOJaeAfPLPOG/m0WhDBsE+Yh2Xogcy/93NvLcdhEKOA6kG7g/MJ12j4AO4yyb5TWkNZR8M9Ivh2CBC6JbWLmrEX5KxCadC0a4uJPyIHerGxcATYbot0+YBWisGmnE6Z0hsAKVIwez2AVuWvd6rITTZVYmABrUI0rkrNoXEnPKE31FZRIGTdbzDDuhfcr9CGkt0V/Cc9216o3pa+q5cnOS2kk9cz3myVm9lw0JfLs7Q86OzPAw9IlOVfXegWrHev5WQs2em2jaa5+oc44i5IhIyxRoLr2QSqxX+aiDJNYETOwNgoVps2oGdFPOF8qJXHSBcVWjbS98wUd1BnIMtINjmUVP/EXNyQhpuY6KvVmMFEgBSdk8z2EgT+l/SAkcjf3x+1aSZHgb2z0kbFZO/wT7NTRSJlqtjxcoI/C0h2VkuqryJt/j/pOFeYdzrs8a9osoukBXBVQ7BxKDfFrGLZfZwQFpxoSthAjMpimyb+hTABNPqdZaxwQTMrcv0GVNmuox2g6nYCig3tDXZ9rePc1pWqmQSOijxtqyvQomHuhSrgM2aW1Qk9V4y6NBgYJCF01mC4Ya+r+RgSBLmNZHewGJkHdZ+jNBY9MybPPERpE/B2Nbvu02Pi29hIfyLnnDn5pBYh/4LOvgfWB0zHLlXvhguuQfcPcBD7z/xbBjSRvMnSGh/TntsvhoMVy+mQroS7bsvbv/5FCqMqyp/Lefj2g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXJhaFNPQTFibTNFbGpWTDRlL2ZHS3B6NEhibWJVNHRZRDNqMWlTbWc3UndL?=
 =?utf-8?B?cGdtdnNmZVNmdXZpU1EzRGFWeENKMW9CT1FOb0hxemQyeVIyYU1HYWh0MHZL?=
 =?utf-8?B?UWprNUVjREZhbTY4V0xrbFllM0R3NytqWFBpNW0yajY1UjdIRlNEb2RoTGdH?=
 =?utf-8?B?UnNYK3JpVnJ1QUUwUEhPSy80emVERWJmb1BkQUZNUG54T1o4SUhQck91UnFX?=
 =?utf-8?B?SjJyODNRMnNoYzd0cTdXdVE5b0EyM3JSTDI2UG1Uc1YrYlE4cnBuUVJiWmF5?=
 =?utf-8?B?K28zeEpNL0l3U3JtM3ZkTXVVMmhyek9QSnpxMXAyUnJPRnRvWTFCNGpaOWh2?=
 =?utf-8?B?U0pwZzFNVE16WDVyMXFNZDlSaE94eHI0anVubEdpZCs1VU83Q29oNW1WMlZz?=
 =?utf-8?B?cnV5TEpNK1pKN2wyNTZmcTZsL3hnSDdZWHNBRXExWGlINmdJTCtmdThONUdV?=
 =?utf-8?B?ZVlyQS9lU1BCYzNSRFRkbFM3QWE0Slh4ODUzTjZ0TVpoV0cydThOa3c0TlEx?=
 =?utf-8?B?WUt1RHBqb3IwbC9iSSt2clRKS3BiZVlxSEtFUDUvaXkvcHFuZ2Z5aXhacW1y?=
 =?utf-8?B?SHF3bnRZcFE2M0ZTODJ1K1JHOTF3WWNhMkhZeEo1NGd2ampEUjdJcmcramRL?=
 =?utf-8?B?WktxNlhTREJkc3BuZGVRNDVLWDlPbG9lSFA4QzhmMDROTnJPalpyUnN3OW04?=
 =?utf-8?B?OVhKdGNSMlFuTU5WU3A5bW9YNVRwWnZ0SDVwL0VxRHV3bFdvQWZIZ3BQaVFR?=
 =?utf-8?B?aUJ3N0tVZDYyTklCRnRTaXpOSmZRdC9VeElpdzhSVnkvVlVQcTc2U09CUXZH?=
 =?utf-8?B?ZXdEYXlQVFlPc3NwdTl4SExYM1hVZ1k5cEZCWkhoNTBBRHNsanFOV3YwWmk5?=
 =?utf-8?B?d1B6ajA3Q2ZramJrYUE2M1c1bU1JYXB1T0ZPY2NpbWVucWZrTURSV2dtK0Fk?=
 =?utf-8?B?Tmt1MnhZVE10YTlBTzR3MlA2Z0dWbkNDQ2IzSFZFZlJJT3VFRnpEVVd1SHh4?=
 =?utf-8?B?bTlod2JManZUdTRZS2xFQTRSamlYYlh5cGNxS0ZrY2J3bFBVdUxtT0VqdG5X?=
 =?utf-8?B?YWFscks2NzhkdkFOUURES01PRFhBN0k5aTVETXlqRCtRVUlWYnBxWGxReWpX?=
 =?utf-8?B?SmlRSEF0MlNid1djam51cEhabUF6Y1RZOU1hZnVKMXVLMHZROGg0WW5DL1dR?=
 =?utf-8?B?THUycXhaQWY3SXhPTVN4ZEZlaXQ3ampIQ0dITHJ0Y3A3cFpLeStuQ0Z2ZG1l?=
 =?utf-8?B?dDNBZmpUSGpSbnQ2dTRKQ1p4MG9LbldndHlXMFdVbVhRTmY0MEdRUzZwS3g4?=
 =?utf-8?B?WVZlZXVjWS8zaWRMQlZoSmVVM3BuSGk0TGhoSWRucWdCM0VOUys3V0VFMG1R?=
 =?utf-8?B?N2ZUTWJGek9pOXZ6aFc3MWlUWi9vcXNUM0F5RnVlbWl2dGVsQVlIbkpIRFNk?=
 =?utf-8?B?dW5HSWRsSGh5UDhTMDVRbXFNWkMvQnA1UVhQQVlSV1FBTm9pZkRsUElwRHk4?=
 =?utf-8?B?UU9EV3pGYThaREN4NUFPMm5oNEdNdHJwVWl1MmtEWk9YbEtaU2pkN1dwZnFy?=
 =?utf-8?B?NE5hQ1JZMk1wVlZBMDRVblNSb08xT2VNdUluZnJPd0psa0Z2akRGMkpwUzB5?=
 =?utf-8?B?T3RvWm5pOU1STjlZN0Q4WmQvQjVxRmN4RWZxNHRJWkREbHFqQjVoR0lHNEpa?=
 =?utf-8?B?VUZPYStIanczdERJYUdtMTZrR2JERmNKdE5Kd2FZbGhaODdzZGF6Qk9WeGNI?=
 =?utf-8?B?aU0xZXh0bFVqSjcySGd1aCtxRHkzNDR0YU1rNEM4WWw1OTNlR2N1Z083RmVj?=
 =?utf-8?B?R280WHIyZG5NSk1TWXBXQ3NCYWQ0YmhYWU5LMHFycnl4YWd2ZWk2VjQzbE9u?=
 =?utf-8?B?R2Q2WUh3S2ZIclhLcklnYS9nUlA4RzYwNkFSeE1rckEraFF6QlRibVVUdDFF?=
 =?utf-8?B?dVhuL0UzMUxSSFY0aUNOc1h5dk5NYVFnNkk4bHVJeW11U08zaWttK2JYdVEv?=
 =?utf-8?B?Y3FHak53TUdJSy8yVy9Bb1JSS0ZoRzhpMUxiNmxsNDVNYzJhdWdyMG5pZVBN?=
 =?utf-8?B?ZkQ5SkZBcXpXSGI0dVIza3poV2JNZHFGQnJNL290MTRqejIySjRlNzBmdE9l?=
 =?utf-8?B?WFgxNWdIQVVZajRKUmQzV3R6NW5yWTEvQ0pmdlZzNWpEV3kvVXlvdFVPSG9z?=
 =?utf-8?B?cWJyK0NrRnY1b2J0c3h4OWlGb2g0aE1hSjU0b21ZSXBiYkMrZWFOc0JKK3lK?=
 =?utf-8?B?MzNXTlRQUy9HNDRSM3lUZUFBaTJ5OFNCUXB0YVM5d0ZMNzlScnpsUVhCeG5t?=
 =?utf-8?B?Tk5kVWtFRlp0T0FJSHdWUGJNZXYzWkt5akdFcXdCR2xKcmU2cFJDZldkTEJo?=
 =?utf-8?Q?YqeJ8cLIbIyc3Wgs=3D?=
X-Exchange-RoutingPolicyChecked: sksit34Q4yIRbpwMdFh5JMdVfxmfTvBTThmVLliv4FgPsKsxDhb/7u39SCZcYqbXNM/ITk374PJGRk/Y2VjafoWmJ3TpxZcLn9sLAipEEsHbhUaRFsFlpwhId00rQt/o1n8ym6XuDF19baG9zzxBy53Lsp/tEE4QbQJZB7yBrBqTNB7xEZ5OHO5mtSyCbrTcx1dPNjMqLSncHyvACXxZcPo7qilICNfUm+iLmWDBMB+7reYKEGoo94bJZ+22Pen2iCx2I97Dj9SfjPNdymHNVstyStTQxepUTD2OxV7ytgIrNMQiVyy7NYSEvFwz5fmzof1hcmLG8v4HTV3Gf/gIsg==
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c3053a-f158-4b54-aa03-08de7fa55bd4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 19:35:32.2083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: trE3ukySgWPmn+GryxuzUFqYFSLZdObSNdsbsqvEbISgjLiETQRh2ANP8a+SEsYfQjw7L3Rf8p4GWqQ2k4XPrp49ROMo3jp3XglgkRV8EwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7775
X-OriginatorOrg: intel.com

Bjorn Helgaas wrote:
> On Tue, Feb 17, 2026 at 08:08:35AM -0800, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > A pcie hotplug slot applies to the entire subordinate bus. Thus, pciehp
> > only allocates a single hotplug_slot for the bridge to that bus. The pci
> > slot, though, would only match to functions on device 0, meaning all
> > device beyond that are not matched to any slot even though they share
> > it. A slot reset will break all the missing devices because the handling
> > skips them.
> 
> I tweaked this a bit to (a) refer to the "secondary" bus instead of
> "subordinate" to avoid confusion with the PCI "subordinate" term
> ("pci_dev->subordinate" already has this confusion but is harder to
> fix), and (b) mention ARI, which I think is what causes the problem
> you're solving:
[..]
> Let me know if I got any of this wrong.

Looks good to me and matches my understanding of what Keith is fixing.
