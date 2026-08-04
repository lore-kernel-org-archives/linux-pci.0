Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7783CB562
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 15:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785858676; cv=fail; b=UUfdmKSO83myEA576Y4vt5NszMLYgMbG7aNzJGXCcaa2elrVVI/xyi9+8rMbIeeKFwcIXg9fsZf+9GxoZnE2lE0RZKXabRt130rHJrwDZgQGLLmMRE0AxC18ndVoXIDZNfI77T0ic2YNv+/VXqHOAqoeXVUf0wRAom0zJcDR/CQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785858676; c=relaxed/simple;
	bh=XTn8IlSa+A+jkdtVQW7KyvrclD+Lxx4pQbjm3wKh3mo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DaO4/dGILfP4cvXLuHTf+gAqeU/JlRTrDqQaPj4FrP/JbdcVNm7GW8CqttuPjqmI97eTt9++TjB/L8QiYmWAEYNwM5rKRAwSH8LVQj7xn6NK1t0OAy0n9iuxvO6MloCcCEEVethcatHyoW0Pnxipdr4o+Kb+3PhGJt/gM2ZcqN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=StbDLutu; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="StbDLutu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785858673; x=1817394673;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XTn8IlSa+A+jkdtVQW7KyvrclD+Lxx4pQbjm3wKh3mo=;
  b=StbDLutu3f2vmnSraG4Bz0cfidSGER5puYyQ4uiyUxMTjrIoFe3unlCC
   zNJR5Y/G29i27rhS+CJRuTEi0yQmerCCGvWpa8uMMcaZdtRnzc7x5qrWY
   yyhLFsSaB7Ju4WCYakfID1JlwLpHUKFcFJ2ayRKCKxVqNue3RCclp+wHs
   0uOWPRp6W2VAy6N87wiSka/rITxAcoBVY35UhTvZ1SStJEI+00Wym6ADS
   YaFyN2KedkNcA8N+uoO8TSyeXP6j+9NJRZ1odE0PuZ/quC6m9lcU8fyV6
   QEnaaD1ivakNcEXCbV3OdF3QGzwFw7fyYDZimjRP6/cPItN6G085sUyEg
   g==;
X-CSE-ConnectionGUID: qwSFLE7lRniB6tfMmxzHhA==
X-CSE-MsgGUID: 2X0jiPuRRkyHI6IXBt/9ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86182106"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="86182106"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 08:51:07 -0700
X-CSE-ConnectionGUID: i0rmANfGSpGeBr59IedRzA==
X-CSE-MsgGUID: LfrJTHJXS7Ofxk/pSmtAYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="265366626"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 08:51:07 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 08:51:06 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 4 Aug 2026 08:51:06 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.3) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 08:51:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQy89lMya9467vjLcy0vZx9ukOZbCAfutLVY7oWlI0Bxvkxlk2TOCXLD2r/3scPTlMEwXdciCc8cPYq+fnj+HMZdoKJCWTlMAYzVQxI2torKMZT9DC3wSsQcv0GK9x8FgZAOaCSvNsb25bUcAFK9DMhBz68h7CZvOihk2Dp9ux2S8D+3PsyOwbqMdtL7+2qW6hce3nSYd/S2mhK8fCx178zdAlYV36EaxqgjYFnof2gRSxJuL0koxVDCMSc4m5IqciJ4TCh+0BbBVVFmyvL4kU5je7IdULSHEteJOiWcqZEyJC27AeyRQh1lJS00YWNfVRvlNMjPA9uk6Hr+AApwhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCkR/P+F5cE2I12cm6AxGxQZpvJ6RXJ5GdIZCWwKPKk=;
 b=ooaaa0+Wh3H9V498Rajl41azgQlTEYumRJBOtmrxA1+b74oi3TgBL/5qy9Qqdds6Z/zuAgLEMNGkfxxQqgTTcdvKwfhChJedjlze9Z5zlCk6E9DHSROfaPttsv3OOMlXZknX87M4gua10foQ2FtNZ8m79ooiKAfxoUCnmae5/UqGxMu/sJkhF5unVIdDfnFp0hvvJbhI2uPJ0SO69sE2oexwSj8Rwo8cqOlL95No4GFJoGTTctTRsJEfdK9StrzZ4l4YJd59RCocyDCZKjNcxZZR/NE/BecCxilNkVEYMKcXzBwCEu0hBVa5VMEvr72c7R0FV0z1nqATlep13eb+Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH7PR11MB6833.namprd11.prod.outlook.com (2603:10b6:510:1ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 15:51:02 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0292.013; Tue, 4 Aug 2026
 15:51:02 +0000
Message-ID: <31bc5433-0edb-452d-aa32-bfb2f891f155@intel.com>
Date: Tue, 4 Aug 2026 18:50:57 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 04/14] i3c: master: Fix use-after-free of master->this
To: <sashiko-reviews@lists.linux.dev>
CC: <Frank.Li@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>,
	<linux-i3c@lists.infradead.org>, <linux-pci@vger.kernel.org>
References: <20260804133810.184905-1-adrian.hunter@intel.com>
 <20260804133810.184905-5-adrian.hunter@intel.com>
 <20260804141015.8B9641F000E9@smtp.kernel.org>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260804141015.8B9641F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0150.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::7) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH7PR11MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: 716d2b9e-caf3-4fa5-b471-08def2402f69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|4143699003|18002099003|22082099003|3023799007|6133799003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: C35fHBxT0GCxpsKCrpsbPyhz7mUazpQt4WX3D+CdUEuqSdWU//jy32FvW1gEf1W5Y3Y30m28UotCGMiVFACZxXV3V4yfJ3KsBQnylM64ojeil56XamHDV+BUSsunhgmnou3PTwAaFbvkDBhYPlL7+9BbZUgoU3PreDlG+n/RNqdE/Bgip3SDrUYs/Sewwa0cMPBtXl5YSvPueFazws8DVaPdgB1HoCNn7T6IPOFY49n1cbdad/khyOXAUyatCxOt6UtPJ7JiF5J01pKLEtFYKkm9xpChKeYP61wz6d5ZnB5EMGg7hbsbIEI+RKeP6dRTe36XgDUM2Kw/AMRPjT6v/A9aOCqGuXGIrTbPWVDJrFN8abCMDsZyq4oQqkx8mddAcMqiwkrqryKSAQ3FHXsa2LBaazgLWB+awYBwr/ybPUPkqHRwcw9s7HCW1b2gQzan9jgPXKRQQOQV+meEck4mfbfPR473dNNE3IfhLfGRdP0NVS1j1N8wTE4T9n0yso97GAEkiwpNeufwt3uCfp24ndQdxIGJ601rEES1kdPRZ61JV/knvaip714A3HiamoferfZ/2TkvEQTpP+09s+DhLG4U5oZFoi/TXXaj5chRPE4CJ4limqag3/yB3UOIw0vMZ/zTmweRoscfs1OmJ3o8eKfmFAVJIrghQCtz/5LgxAg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(4143699003)(18002099003)(22082099003)(3023799007)(6133799003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXpNWi9zVUc3dUo0SEZMSVd4UEQ2STZJellnMjB3dWpZalZ3bllaNmgxRTFR?=
 =?utf-8?B?REJiTThjbGZaS2NOZTlvSTlsY250aHNsUWNscXdPaTZWRnpEZmhZVGQ4bUYx?=
 =?utf-8?B?akJabzlhYnNIMUFuQ1AwREM5YWtRNXVOcFRnTk1ZbkU4Rm9Ga3FTNEgyNXU1?=
 =?utf-8?B?ODJhTXR0THJ0ZTI3WFpnOTNmMWN5M2picEJ5bTJMV2paaEFpMTFldm05Wllr?=
 =?utf-8?B?dktobUFoZW44TVgyTnNDMUF0eGdrQ0FTOURNQmhrRlRmeE1pZW0vQllSaTAr?=
 =?utf-8?B?c3JmOUdjcWtWSnM3TVhzSHpNbi9uQTBVQ2pscnBNWU5FYjdrMmVFSnZXRFJt?=
 =?utf-8?B?T3ZvT25XTmFsZmNwemtYSEdOcmRueUhkZkhkNytFQW9yVXI1aEdTdHlHbGpi?=
 =?utf-8?B?N1lUQVlmUzRWeWF4OHVraUVqQlVoRGxNQ2QwbXRtWVhDck42VHRhZWtlR3Y0?=
 =?utf-8?B?cDR1cXp5UENlcVRvdndRUHlVTkNlY2dyUWtTbGxWcTlUZ243a1JzWXBQUndY?=
 =?utf-8?B?RDhIdWNYY25CbC9HcE1ZWnhpek9yMUdWd0dRRzRsLzB6Z2xhNU9yUXN5OElU?=
 =?utf-8?B?Y01vR1RVMVpjVkQydWpaakM2NXVmOVpGS0RtU2h6OVh6Vk81WXFpRUR0eUxJ?=
 =?utf-8?B?ci9GZldiRUt3R2FEVE1ST2k2MER4WkFMOStBcGYxYVM3anp5NHJpOGR5YTZO?=
 =?utf-8?B?ckMzZnNsdzI3eUZianlyZzlHNVhQMW42UzNIYzlNRXdQUTlkY1QrOUU3Z0k4?=
 =?utf-8?B?cmJraG40VVUrYm50THRGT013TER4VElzR3drb09yY2JIMVg4K3hTNll0ZzRM?=
 =?utf-8?B?QmJyY2NwRUVLU0pDSkdxNnEwcndiUFN3ZERQZVMwQjNqQktScGJoVm9XeHJW?=
 =?utf-8?B?RnZzMlpJanV4dktmckJlcCtxVXZNU3lOdDBkNE1rYnZBeXlrc2pobVllRHBW?=
 =?utf-8?B?eGdVbkY2WVhCMHhVZzgwTnhkSHUxdnhqOGU1RnZNV1NuOTBPNWd4TUd4NUdW?=
 =?utf-8?B?bnUwcmtBbmFrZGhVSG5sUGF2eGN0eWZBd21zczFpa3RMbVJCemtLQTVXN1lt?=
 =?utf-8?B?WW04NVoyWkI3K2RKK0EyOEdNTlRCWUJCemhjQzdTVmhYMGttRXAvM1B3dEh6?=
 =?utf-8?B?VEZsSE9QeW84anRtTlFMRGdhNnNyRzdhaDdCNVNVanpVYVRLWURkZks1VTBy?=
 =?utf-8?B?QzNDanNkNktDOTE5VElyUUJ3aUhwaFlMY09BRmtqbGt2dEx5K2ZnemRpQzZo?=
 =?utf-8?B?WnJicHNIc0lPcnYwb2pqZG1DMVdDMWE3TUEva2hqdFVQQnoyektvSmdxZGxG?=
 =?utf-8?B?VHp4a3NGaW1NZWlHS1psdWlTODJSaGZPUnUvaUxkU2t6c0hPS1pvbE9ja3Iw?=
 =?utf-8?B?K0ErVWhPYnZSbnMwV0JPak5HU1I5WENXUEVXalpGRnJsc3F6ZXI5RTl4a2Rs?=
 =?utf-8?B?dTRiSS9qSEdKOVNMamV4SnNJdXdYQmhoZEtRUE9YcTZhWm5VV0MvODdvbllV?=
 =?utf-8?B?aWVkR3g3RG1kWGc2OWt5eEU3NFYray9ZT2pXSWhXcXRlK1loNWR0ZlEzOURm?=
 =?utf-8?B?N0JuVHUrcjdMeGxRc2VHd3djWU5saFlOVnhHL0NJKzF3TjlQaUhvODBvODR3?=
 =?utf-8?B?b2dkLzg5WGRzc1plYXdyeUJVU2pDeUZQZ3Mvdk43d013Q1RuWERmeURENXgx?=
 =?utf-8?B?S2lxMXdOcFRJLzB4WE9rSzIyWHRpZFRCM1F4aTg2TmNLS1NpSVBLNjRpZWhr?=
 =?utf-8?B?VGFnbUp4QTVON0s3Q3JVdHdoWTdkc3NMWm9Vc3liczJ5eTRQWkM5Z01xcjYz?=
 =?utf-8?B?RG9OWVNrbEJVUW13cERZQ2xIYWJBcUgrMml1ZmRXcmE0dG1DNTNhZEYweFZZ?=
 =?utf-8?B?SjF2VzhHNVZqcVVqbTlFbGd1T3ZiM1Y0VC9yOEVFRThFS0lqSytrQk4yQ3Yx?=
 =?utf-8?B?VWJzb08yMUdGRnRBRi94VFRXY3ZES2orWk5ob2JwU2hlTllaV2FrV2gySkhS?=
 =?utf-8?B?a2pMdkdMcHUwVkNLbkR2UkRZcjg3RzNSUXRITWxOREtCK1RETCtUcFZ1M2d2?=
 =?utf-8?B?TlRGWEtwZTBwU2QxOGlVdHZpU2Nwem1ZeGl0UU9BeEYwMnpBM0FEQUZQbk1C?=
 =?utf-8?B?V1Fjd05BbEl6aHhGTGJHNzlIaTBKV1lNRFo4L1l0TWVpdDVNWVpXbnM2dFdy?=
 =?utf-8?B?YkNZS1Y5L1lUWHhDMlpuNUd1WUlRZFQ0NU12SWVzN1RDc3RQQ3ZETnk2NXV6?=
 =?utf-8?B?T0hKazViL0dTTmh4ZmNJTVYvYWR1SC9PeGUyU3ZjTzlrcWo2aDhjeDlDaGx2?=
 =?utf-8?B?WWpXVzVvZExaQ2tFaEFlejBRaHZmOGdXRlpkTzJPRHBwL2ZneS9PU2hvOG9u?=
 =?utf-8?Q?KeZwX6HdPA3KkMR0=3D?=
X-Exchange-RoutingPolicyChecked: sTvtQVEE5ZOyJRrAh66d2qGqm6MDh32qWlRddhIJPmIQDqYyGVpfdPAJPRUnRQB3crnqyc467G780O1sljIlBig/HzZd6H4vgxVVBJ0iwG30yj/CVBR4g2vgS6czjLjD2TT6a34//FhmiX0DikslD7cJIVp+NYtBbFo/t1BiLOSTIWb9bfxiPasTvn0PC6cm0vJIHSdBchXoY0u3PyhkOQcpvv8XqsZPaUhrEtKig7yBMRZ4mNfKXwxV6bwgzk1OVdIEHni/KS/YF+vGdgDKtaLl5pC1ZhWnrkWeYUo3lPR0ZGjGYnzCNRx5iDgwxZxsiVpNcz06fl1kYdKvxPK3aQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 716d2b9e-caf3-4fa5-b471-08def2402f69
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 15:51:02.2677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cZE66H8BOVbMqXEa9sSUaC/91kwZGtTDkfIiJy4gVSEgzkZMAYkmYwvXMW/zuzRnp2+2BPAnZ511RcO2Oo+zcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6833
X-OriginatorOrg: intel.com

On 04/08/2026 17:10, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] A double free occurs in the error path of `i3c_master_set_info()` because `master->this` is left as a dangling pointer and is subsequently freed again in `i3c_masterdev_release()`.

That is valid.  i3c_master_set_info() needs to be amended either to set
master->this = NULL on the error path, or just don't call
i3c_master_free_i3c_dev() since it will get cleaned up in
i3c_masterdev_release() anyway.

> 
> Pre-existing issues:
> - [High] Devres lifetime mismatch allows use-after-free of the master controller struct in `i3c_masterdev_release()`.
> --
> 
> --- Patch [4]: [PATCH V3 04/14] i3c: master: Fix use-after-free of master->this ---
> commit e74d33e25ba87fdc800277aa5702a984d20076ca
> Author: Adrian Hunter <adrian.hunter@intel.com>
> i3c: master: Fix use-after-free of master->this
> 
> This patch delays freeing master->this until i3c_masterdev_release(). By
> doing this, it keeps master->this alive until all users of the master
> device have gone away and the sysfs state is torn down.
> 
>> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
>> index abb582645a2ed..4839c1c186eb0 100644
>> --- a/drivers/i3c/master.c
>> +++ b/drivers/i3c/master.c
> [ ... ]
>> @@ -842,6 +842,11 @@ static struct attribute *i3c_masterdev_attrs[] = {
>>  };
>>  ATTRIBUTE_GROUPS(i3c_masterdev);
>>  
>> +static void i3c_master_free_i3c_dev(struct i3c_dev_desc *dev)
>> +{
>> +	kfree(dev);
>> +}
>> +
>>  static void i3c_masterdev_release(struct device *dev)
>>  {
>>  	struct i3c_master_controller *master = dev_to_i3cmaster(dev);
>>  	struct i3c_bus *bus = dev_to_i3cbus(dev);
> 
> [Severity: High]
> This is a pre-existing issue, but does this release function dereference
> fields in the master struct after the driver's devres cleanup has already
> freed the surrounding memory?
> 
> Master controller structures are typically allocated using devm_kzalloc().
> When a driver is unbound, devres cleanup frees the master controller
> structure. However, if userspace holds an open file descriptor to a sysfs
> attribute (like /sys/class/i3c/i3c-0/bcr), the kobject refcount doesn't drop
> to zero.
> 
> When the sysfs file is later closed, the final put_device() calls this
> i3c_masterdev_release() function, which then dereferences fields like
> master->wq, bus->devs, and now master->this, leading to a use-after-free.
> 
>>  	if (master->wq)
>>  		destroy_workqueue(master->wq);
>>  
>>  	WARN_ON(!list_empty(&bus->devs.i2c) || !list_empty(&bus->devs.i3c));
>>  	i3c_bus_cleanup(bus);
>>  
>>  	fwnode_handle_put(dev->fwnode);
>> +
>> +	i3c_master_free_i3c_dev(master->this);
> 
> [Severity: High]
> Does unconditionally freeing master->this here cause a double free on the
> error path of i3c_master_set_info()?
> 
> If i3c_master_attach_i3c_dev() fails during initialization in
> i3c_master_set_info(), the allocated i3cdev is freed via
> i3c_master_free_i3c_dev().
> 
> However, master->this and master->bus.cur_master were already assigned to
> point to i3cdev and are not set back to NULL:
> 
> drivers/i3c/master.c:i3c_master_set_info() {
> 	...
> 	master->this = i3cdev;
> 	master->bus.cur_master = master->this;
> 
> 	ret = i3c_master_attach_i3c_dev(master, i3cdev);
> 	if (ret)
> 		goto err_free_dev;
> 	...
> err_free_dev:
> 	i3c_master_free_i3c_dev(i3cdev);
> 	return ret;
> }
> 
> The failure propagates to i3c_master_register(), which calls
> put_device(&master->dev) to abort driver registration. This calls
> i3c_masterdev_release(), which now unconditionally frees master->this,
> leading to a double free of the dangling pointer.
> 
>>  }
> 

