Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E8D379C28
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 16:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786034841; cv=fail; b=uDJyhYW44hsVpeV1/nJndDykPt/V3sPLHnWh1GkhJjO2z7ml6s72pFi4ArOsXoBtcH9J5uHs/HHsKVsNcVz+x9RVIoh/XLAvRqcJosi5I+heVQJrgT4CD3zVwMcPBAdbTju5ZUWgfvjrXBckNJvUCcx/OqFHJDUDwY0jgOe4cG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786034841; c=relaxed/simple;
	bh=KxR492NqnvaUS38YWFMpxHiZw2tPew8liS8vXmIAFqI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EHyilI8DrTonmwil+tddPXDyNdA0LeUQkAzu2Nz1K3EqVj3+C+zm0+CDrvQDWMeLlCKuZLSFCuf3dG9P3JzZEj0+BSXr7w/7fr5+97N+tNrGqrw4OxYDG3RMS2LlONhNtq4wvVk6sGZIPEVOmQYhcnqvgmjTKJsW22JJKKvbSzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ifo5xm+8; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ifo5xm+8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786034838; x=1817570838;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KxR492NqnvaUS38YWFMpxHiZw2tPew8liS8vXmIAFqI=;
  b=ifo5xm+8zxOg+caMMWKzDBPDU2LJ9rjhD4m6XyU3dkrUMyp1Ly4KLDH+
   Ekv+hJyrWq4cd/66jTXOuo8wMeFF59DEWB55zo2ozyG9BKf7OX7cETUU8
   I2YWQqc8LFrAoKmJvKHNEeR0PDl02IsxeVe88NLB3krrQBBl1Mwd4SGii
   Un4oz+v2GHJl7XWKCjCTxf7JhjTIk5xnrdt/1YF5tShhKYPVFmebejOtg
   84jjzCzLQR8vpVOQl3j0aSWFeP5CYLNFUnZW0HAUXfYSpTzOK+6H1j3+7
   AzA5C8vhS9torJ8SGLnPPNEyE8L/gERW0rdYmdDMmpgTbbsTYdDaxlwRj
   Q==;
X-CSE-ConnectionGUID: 63Gsl7S3SjiGlAKe9dpjsQ==
X-CSE-MsgGUID: FApq9plbTxOzZwsunIRZ4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="98146231"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="98146231"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 09:47:10 -0700
X-CSE-ConnectionGUID: jdbWYpLtR62qteBKiN+QOg==
X-CSE-MsgGUID: dVTkJ2JHTwCR1nXr2I2NQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="267295709"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 09:47:07 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 09:47:06 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 6 Aug 2026 09:47:06 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.58) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 09:47:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yOVqY0cyPib4SkPGXE9tMZkmR6y65P2hVqeLuGas6dF42LZAH/9iMBKpUEH6naa1qEImnYJf/KqbEgS54LEFwMdCreupxHmfOYPGc5jLhIUo8Ni5WkhgWl2rpoe56mT5pvCo/nSIIcg1g4Bx4XAjQXAahv+DbpcuPdIYNamEwxGwiqOE0s/hNnoEUydbUueYnWZlryD2et5hH2+jl+aiYYuh4yx8Igu9lReKASgDmJvnSZCkOg8nqaKLS5sbeD7fRl6LXRUe0NkRU6muFghu8l3itJxY4nQTZG3AQGeGSSUnyh328D1WKNOFpizNM8A3Wc49Tcz7ScuudOVo2uXcoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPOqMvBwtDdSOMO1FRHbR3CirWtBqoaKUduNxsmE6Yc=;
 b=AkquOwN7LRHWq5ypeemH8nv9f7SABnFBAkSz2oeCIwYsgcH14HzdJwcIzAB6Nmb9yODHlsofMHMuhsOiXYamfA30wjTd3q1gvbpXef7F9EAFUYqq/JqyU0V7HG2umDDNY68/w2xVaaQh4NDxLf6UKqVGQeAJ5haL4S1fbSRM0145zkfF7FtkfKBVl8qHG3lYnFAPiMiSZp7sajW4x53rxYjhosTCIXDKkCr8FBHTMPpxQEZLSlC2+6PdMd1f7r7+JJ2qxvxLOCjPYBhdwQolFnoZB08pdFIicz4lB6Vck/CvRBrZ4zJftlg3An1ufj6cu1W4E24wqmCOYKVzJBM54Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by BL4PR11MB8869.namprd11.prod.outlook.com (2603:10b6:208:5a8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Thu, 6 Aug
 2026 16:47:03 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 16:47:03 +0000
Message-ID: <a36226d9-0f1a-45d7-80fb-39d22ce6aff7@intel.com>
Date: Thu, 6 Aug 2026 19:46:59 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 01/14] i3c: master: Fix recursive locking during device
 registration
To: <sashiko-reviews@lists.linux.dev>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	<linux-pci@vger.kernel.org>, <Frank.Li@kernel.org>,
	<linux-i3c@lists.infradead.org>
References: <20260806131857.119830-1-adrian.hunter@intel.com>
 <20260806131857.119830-2-adrian.hunter@intel.com>
 <20260806133914.EDA761F000E9@smtp.kernel.org>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260806133914.EDA761F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0294.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::13) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|BL4PR11MB8869:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fc37602-d73e-449b-5193-08def3da5795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|11063799006|56012099006|10067099003|6133799003|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: UPzHwX0Imt4ZPJ/fRUQoOojFuxIUPSBBOpzQQkvQw9aUPxfctAI5fpdWGhmMefzM4XT7POsyGm5o+FOoJkxU/Lf6gca7H+3fx1h9B/DSul8LG9gqAkHNdW8XmBXG1jUkQOu4on8WVmSVfSXJC3PpsUQP9qw3/xjxn7m84WSTQv1FNVXQD1E7tbb/Ed8R3zzed0miKQ/97Ky8im8wAbLLjwx2LT+s+Mz95lMSxs9TwXmH74EPwODpnllgZXeM1YkRGWvS5Btq19Zv45OtDLQSqPHHLjE6MHuJMtnrF13h8yk5aILmnP71w43IfrsTcgDP93AL9sTCGYeESQE/WaoOGXrHfX1/dM7w0cXW1sXnhFLIPmAnxYdQR3v4HoxHdryuo3OORjDL1fYoghcRgPT+ghe61w/V5bQ9MLiQPkHsLAwdkQ1m+3wUv5EDhjo9fCj8Ulg7eiRVlN6sptFwVBWPf3QkGg/MjN59wJNvcqSEq4C8zr7VZu+qtkAd6vN32TbDBSb8k/fpvv8HTUx95saBp6j1DblOjnvIWLr4i36EGU2nZFoCqmYbwapru1BDRmeWXfq6RTeTKDXpCDJHSrbCva0gT2KrBlYnjaASmYJZ3eZnmDtZOTmV4eOaB1Sr3L8hAQDBOTAdanp0O9f2lIsEQva9WVhqzL8lIdxo1yuWjYA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emtZNi8wRStwR3JKam5KSGR5RDN1TFpITVllUVRabG93Zkt5amdKcWxGU1hS?=
 =?utf-8?B?N2hsdmJBS3Ird0haYzRsQUFwZmhDODlUZklLQnMzZU1FbFVGWWxHbXEydmpt?=
 =?utf-8?B?L2lndlRIZHlub1d0OEpJdVJRSWhZYVhqNnRnUm1YdXRSRHZaM3BXMmNSVE15?=
 =?utf-8?B?REJkd3dmY2lwek1CSzdPS3RkUW8raU84M3Y5Y2ZMR3BxYXhacHhEeWlPZnVO?=
 =?utf-8?B?d0U5TjU5YVMvZ1g2WXdLL1dHRjU0TVNWVER1NThNNlhKWTN5Ums0SW8xYkkz?=
 =?utf-8?B?WTd6UEJzK2V5SnFaVjNMUGpnVFprTmhhbHh3bm5WTTNZZCtvSVlqcnBFT3Y2?=
 =?utf-8?B?VVZTbGQwR1FvK3ZPajVheGpEREdaQkR6MktRMnVvdm11WHFwODlBYzlqSFRW?=
 =?utf-8?B?dm55WWN1TGZRdHZkc2R2cW5OcGtYSXRQc2llVXJuZE1IdUxBWms4UklGNkll?=
 =?utf-8?B?MUNMZUI0WGRvOElkUUp1SVpZb241VzVBaDk1aEhnUXJ4TVRjL1k0bWZnd2Fv?=
 =?utf-8?B?QlRUYnQ2andIazNBaG5EVkU3K1lobGp2enVJRFNPVGU0L3FwM09yMXhYQjZp?=
 =?utf-8?B?QlZ1NnE2WkcrTFdTNURMR0pRNDRnS1lENmhjYnBZK0dESmcwajBRMm81cXA0?=
 =?utf-8?B?M3ZCYVdMRWRVNE1uYjE5T0JGSjFYTVVTWVBYVGRFR2ZnRk1OS0hNTTRCeTIv?=
 =?utf-8?B?QWZEelNGU2w2UU9EUndWUG83ckdMS1V6OGcrNk5KeFIyZjJNWWRGL1JZdWdR?=
 =?utf-8?B?UFVjeEFIY0QxWFhRdy8zemFYcFRiRVdnc0RwRXFMTFhXcC81UXczTUh2bmlF?=
 =?utf-8?B?VVU2OVVmMUhROWhlUVJmZTYwYkFXczFkVnhTblk0eUpLTG4rQXVRTGhLd1pK?=
 =?utf-8?B?N3pZUy9XNEpCY1pEcTJxTmZleDQzMjUrQlJ2RTAzQ3g1L2loaXc2TXU1QWxv?=
 =?utf-8?B?dDB1ZjdiclhsYmpDYWhQM0xXNFJHRndNTERKbXhCVHA3OFZ5TVVJVVZmZVMz?=
 =?utf-8?B?TFdjUU5wQWRRNDJsLzhUOG1kMHlqT3VqRHRMZFN5NkJCN1JHdy95S0JCTUhm?=
 =?utf-8?B?bThZdldYblJ2S2VGTnlTY3BxcEZwalVxNUZoOE1ZMENyVnN0NkVUaDdaekJB?=
 =?utf-8?B?dHhGcjR5TTViOGFTYXRRTlpObFMvekRWdHFKb05tRFd5c1RWQ3lyUVhlVjVo?=
 =?utf-8?B?RDVydHY0RjhtZmlvUFlpbGRXVWNLS001Y1dKUGpvM1lEcEZKUGxxVDFXeFJm?=
 =?utf-8?B?dGJxbzhLS2J4anJTSG56SVlOWVJQUi9GbUlZRW9hZ2FlekNWb0lrZ3ZGNUVq?=
 =?utf-8?B?UTVUZzVYSzBGeEYrb0pNd2JHT2tubHpqOFVEWUV1S05EZnJtZ3NyQ2VYbUta?=
 =?utf-8?B?WTZuNHFmeTA3RHFweWY4YTZyM0sycHFVS0VtTllaVzYzQVptOGttMkdibjJL?=
 =?utf-8?B?U0Joc1dRTjBqY3d0TTdBbTFwZ080MGZjS2FGVTZvTkZLZWVpMVBJakFLUkll?=
 =?utf-8?B?TmRnSzM4SGFrTlZHYzg3MHYvSU1xSkVIZXgxdXUwNXV3NUJqVTZidDd3ZGNJ?=
 =?utf-8?B?Q3IxZHVXeGpUaC9xVFBpL1N0QWhnZUZNQkdoM3ovdTNibTRXMGdCenJPUSs3?=
 =?utf-8?B?c3UyMDl5TjVzLysrdmF0czVaeVhpbnkvZnBPMUlHRUNZL3pmdk5lVzVCVlFZ?=
 =?utf-8?B?elJEQy82MWZBcWRQVGFrSk8xK2ZadkZuRzI0MFgzZVBUSDR4Rld5NUZVMFg0?=
 =?utf-8?B?QjJkQklBNS9kZW9RY2srcS9Rd0pDK2xYczVkejVicXZRQ0lwcFk4VVI5dVE3?=
 =?utf-8?B?SThWVTVUNm14czI3QUw5NEZHa3N2UWRkSGRhME5OSG9uUTRudld3bUIycXhk?=
 =?utf-8?B?RzFGMlZQTjFQMVJuUXBJUmVrSkZwbUZLTW9rZVJwWHRUZGYyaG9ZRTZFU1JG?=
 =?utf-8?B?VmhDZ25jNXl6TGpoQTA3NnFpS3pFR2VmUjlONHYyV0pmcmdMT3VJdGlYcDBs?=
 =?utf-8?B?UW1aQ0k2ZEtsZnFRbkg3ZHRBZTJTSGxmV1doYkVvWitUSDBIWU9RdXE4YkZS?=
 =?utf-8?B?dkpxeVk4bW5uaTViaUJzaDU3dFJjVnNjNWpWcG9FYzZ5UUYwZ2lpU1drbWw2?=
 =?utf-8?B?VDlFNW9jVDIwRWx0aFQ4cExMSXpMZnR5ZEh5Y1BzUi8vYWpqTkg2YVllVXUx?=
 =?utf-8?B?WVpqYmw5SzYxaUdHanJpZFZMQS9mbUZOaUhUWmoxN0tnUHZLUVNFNFFnVy8y?=
 =?utf-8?B?YkM1aWkwN3JIM3NabU1uMW9td0UzZjhQRjhXL3pTUSt0dktSY3c3dThuc0dG?=
 =?utf-8?B?Y2FmY3ZXczJvSjI4Tk14cGswUU53dFplZXU3bjhwY0dQUnQzV0JxTnhua3py?=
 =?utf-8?Q?4VsxQSuy5YVz5bHs=3D?=
X-Exchange-RoutingPolicyChecked: eNfQTtZyd0/U09rBVeV7s/jcRZknDbiHmR0zR/BOOyAJTdrh8URLAKJRa8/x/v1qMABgZ5cmH1ufoN+eG/TfK9YcQ3XmKYd0SEWkT/zMpvpoV2LvsFl8pYwZEbNbmhdVGJWzelopoApMarUrCTpxsOYBivSaIaHZbs3i/1sdVggYu/DrjI0P/sp6cbjdeTHtRABcII5QN0IdQ9CYjSwBj7SpOzEhJBiXfRUoqzHoQGvonfIb+qWrNeiz65/hsmHsXypgtZopkpHLfxaMEuvSgfHQow011S4RD+CjUAIXuGkQ78gFZrRLeBnjA4KcvdCkPyoBaNpTOeTozjxaJnS15g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc37602-d73e-449b-5193-08def3da5795
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 16:47:03.3443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1IX/DL3RvZrq0evKA721KN7zRvSibop1WvWOzpsPxN5Ro3v3m/S5O4xs6zdcWSHKn4p4FQsYLfA8bCP2tCfYBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8869
X-OriginatorOrg: intel.com

On 06/08/2026 16:39, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] Dropping the bus maintenance lock around device_register() exposes the I3C device descriptor to concurrent Use-After-Free.
> 
> Pre-existing issues:
> - [High] Unbalanced fwnode reference count decrement in i3c_device_release() leads to Use-After-Free.
> --
> 
> --- Patch [1]: [PATCH V4 01/14] i3c: master: Fix recursive locking during device registration ---
> commit b31a8482aa2ea710ccc853d0c74b77edebb131ff
> Author: Adrian Hunter <adrian.hunter@intel.com>
> Date:   Thu Aug 6 13:18:44 2026 +0000
> 
>     i3c: master: Fix recursive locking during device registration
> 
> This commit addresses a recursive locking lockdep warning by decoupling
> device creation from registration. It collects newly populated devices into a
> temporary list under the maintenance lock, then releases the lock prior to
> invoking device_register() to prevent probe deadlocks. Finally, the lock is
> re-acquired to clean up any devices that failed registration.
> 
>> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
>> --- a/drivers/i3c/master.c
>> +++ b/drivers/i3c/master.c
>> @@ -2104,25 +2113,37 @@ i3c_master_register_new_i3c_devs(struct i3c_master_controller *master)
> 
> [ ... ]
> 
>> +		list_add_tail(&desc->dev->node, &i3c_unreg_devs);
>> +	}
>> +
>> +	i3c_bus_maintenance_unlock(&master->bus);
>> +
>> +	list_for_each_entry_safe(i3cdev, tmp, &i3c_unreg_devs, node) {
>> +		ret = device_register(&i3cdev->dev);
> 
> [Severity: High]
> Does dropping the bus maintenance lock around device_register() expose the
> I3C device descriptor to a concurrent use-after-free?
> 
> During registration, the driver core can call subsystem functions like
> i3c_device_match(), which read i3cdev->desc locklessly:
> 
> drivers/i3c/master.c:i3c_device_match() {
>     ...
>     if (i3cdev->desc && i3cdev->desc->boardinfo)
>         static_addr_method = i3cdev->desc->boardinfo->static_addr_method;

The fix is in patch 7 "i3c: master: Fix potential UAF in i3c_device_match()"

>     ...
> }
> 
> Concurrently, an I3C Hot-Join or sysfs-triggered Dynamic Address Assignment
> (DAA) could execute i3c_master_do_daa(), take the i3c_bus_maintenance_lock,
> and call __i3c_master_add_i3c_dev_locked(). If DAA detects the device as a
> duplicate, it replaces the descriptor and frees the old one:
> 
> drivers/i3c/master.c:__i3c_master_add_i3c_dev_locked() {
>     ...
>     i3c_master_detach_i3c_dev(olddev);
>     i3c_master_free_i3c_dev(olddev);
>     ...
> }
> 
> If the registering thread is actively evaluating i3cdev->desc when this
> happens, will it lead to memory corruption when reading fields like
> desc->boardinfo?
> 
>> +		if (ret)
>> +			dev_err(&master->dev, "Failed to add I3C device (err = %d)\n", ret);
>> +		else
>> +			list_del_init(&i3cdev->node);
>> +	}
>> +
>> +	i3c_bus_maintenance_lock(&master->bus);
>> +
>> +	list_for_each_entry_safe(i3cdev, tmp, &i3c_unreg_devs, node) {
>> +		list_del(&i3cdev->node);
>> +		desc = i3cdev->desc;
>> +		i3cdev->desc = NULL;
>> +		put_device(&i3cdev->dev);
> 
> [Severity: High]
> This is a pre-existing issue, but does this error path cause an unbalanced
> fwnode reference count decrement leading to a use-after-free?
> 
> During device initialization, device_set_node() assigns the fwnode without
> incrementing its reference count:
> 
> drivers/i3c/master.c:i3c_master_register_new_i3c_devs() {
>     ...
>     if (desc->boardinfo)
>         device_set_node(&desc->dev->dev, desc->boardinfo->fwnode);
>     ...
> }
> 
> However, when put_device() is called here on registration failure,
> the release function unconditionally drops a reference:
> 
> drivers/i3c/master.c:i3c_device_release() {
>     ...
>     fwnode_handle_put(dev->fwnode);
>     ...
> }
> 
> Since the device object never acquired a reference to the boardinfo's fwnode,
> will repeated registration failures or unbind operations drop the refcount
> below zero, eventually prematurely freeing the fwnode?
> 
>> +		desc->dev = NULL;
>>  	}
>> +
>> +	i3c_bus_maintenance_unlock(&master->bus);
>>  }
> 

