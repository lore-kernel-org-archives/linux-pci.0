Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9913932F0
	for <linux-pci@vger.kernel.org>; Thu,  2 Jul 2026 10:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782988742; cv=fail; b=n5vMvzrfSKWgMkymEuyzdDTiUNqkGD6zSLDChbWpq73wQsU3u0Umuc6zeUrC3FZQ7V+e6x0OuhMbGkKk3gRFw+Lsytcbsg5B9opvET8JuQbnUWJMehlCdDQoc+QG8Bjo2QtE3Ar8j2B6T62CeMGhYAoJ5VQhpdR/SV1HSC2y2Gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782988742; c=relaxed/simple;
	bh=xOzJLBuO6xZBsUGqofSmOU6U1oVXYIBYF7DLYj00Mw8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DA653Dc3xGABqm4jpNMm/+uYKaz7GCNznv3buSRH0VULh5HVmVJi6eSBzSwk5L08lzfZAfK/N1d7CP/n/xHTer1DnrA4IwzfhR572hn8PXN4bLvQcD69u+53hsfjaf2cV3CJ2UgtM7wXHXeAMDwse/ch6bzItDtHYxLpKefaDQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IV1jDPHB; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IV1jDPHB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782988740; x=1814524740;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xOzJLBuO6xZBsUGqofSmOU6U1oVXYIBYF7DLYj00Mw8=;
  b=IV1jDPHBF6A6weCQWZYsHhTJeNMNnDhWuNCufdoDnxCCvLBEeppS3H9O
   pX5ORAeyz3Fu59LxL5pYb4mdOf2aVvf2lPbZlVhjs6iJ52Dx6nRx55L1T
   aH8sPTCIaWxPgN3xKLhZghIyuvlgicSy9b0aqaEEbzahguJh8RhY/qMGh
   199IgZd1Y7JkJN+zyuokY5941ank9Mj9/CZPdWXbtBtijQuLH7r/GYn0a
   rbTQPyLhy8bFDcV2/5QZN1UhTexJyJj6DGOeDh3JkMRRjd82Mu0PL2IDo
   snFzyTwmzLWoA95XTXbiQCmMp4Tnf14+0l5asqCjaSr38SMJnWcPqvvJN
   w==;
X-CSE-ConnectionGUID: BLxqi+bISkaAkkL5xxFGgA==
X-CSE-MsgGUID: rl/0Hb0XTBiUJPb5wGwoEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="95119536"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="95119536"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 03:39:00 -0700
X-CSE-ConnectionGUID: jaj3JTi+Ta+nnkCBN4Tbzg==
X-CSE-MsgGUID: lek9CStzRCCWbD/TRBDriQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="253493181"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 03:38:59 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 2 Jul 2026 03:38:58 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 2 Jul 2026 03:38:58 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.19) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 2 Jul 2026 03:38:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ot2uDNLmvvkrPCyZSU3hFAajEG23dXt2AMZgT2VjsxIZpVf0a/9rT9r1gVe7Eg0lTXpzXlZnv2XG3fRuTzSNHrdK5vP0ux4XjyEH2iVJJ6QuaqlFJBPUDlXMqu8FFEAm+wzRN4u6raRRGkyfVwTU6PVwAtC9q0NruBcL+ZO7Q7klW7w6K5yvH+cCKQGX2qpLGFyq6BYxriReQ+gp/zdI0yuCfjPrQPaJWS+oOrQJ6nnaqwyPg0MRpoK3botZ+orzR4xmZJ7uucENToug3CQTfW4Od9rfH5scPoRXnN3Wd8qvyspv1rYlsDvdNjPgbPeSz0RqGUaxrfHT8yTx4HWO7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUrYtAZ4GnBn4bbYwrwgRX3oD0Ok55AgpJWScHxCRXA=;
 b=fc1NeVyr9ouA9AiXmT+FzbCzEScr5I8cP5fPDYfyBWsYo38+gtGPSi7oB61r7xhNHrP8Q7MLce+6zn0BeIj8e8loSD6fOBoL6DdWurX7XQjOfSg1r7iNMS8sPh7LTbVtOFa1lVPSAgZx6aWEj65Ykq4bx2m9OGNwYjAdovcBG0+vkuGGARpK/crDNpQUpKSmUUAc/sXOATFPhKc2UKeltEcgRDyxke9jiudPabt8vAxUYHbZ63/1T/nUy0EFrV1QfN859RmDvG3o+PeajeD367q4dQ+IXSi2zg+q7Dxdo6gOj7yShHWcsI6LM0zNNblBXSPQD2EK+QcUQnxfKp7Svw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SJ0PR11MB5893.namprd11.prod.outlook.com (2603:10b6:a03:429::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Thu, 2 Jul
 2026 10:38:49 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 10:38:49 +0000
Message-ID: <a8aba6ab-75e6-4c0a-b6e3-afd9fbb2042f@intel.com>
Date: Thu, 2 Jul 2026 13:38:44 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC RESEND 2/7] i3c: master: Report wakeup events for IBIs
To: <sashiko-reviews@lists.linux.dev>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>, <Frank.Li@kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-i3c@lists.infradead.org>
References: <20260701201533.220818-1-adrian.hunter@intel.com>
 <20260701201533.220818-3-adrian.hunter@intel.com>
 <20260701203336.D13321F000E9@smtp.kernel.org>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260701203336.D13321F000E9@smtp.kernel.org>
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
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SJ0PR11MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e705903-50e9-4bf3-306a-08ded82619d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|6133799003|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: U03mMQNTL57d3pqWdx0WUpuDTlpHRaxnSfPH1dDPyR+ners2NaoPBALL+NzVFMiVML/UM62YPxZ4+n7Z4x1pVbQS+WBOdqcArB97YOtFX5pg7oUnbrpng7RyxIzYkP454ldY1UY6mcVD7JFuGYbEENvtqVjW0U7BSjjuMjktkH7JwLJlalC/+HniNP0hC2hbNCKTeDX4DScd0OhbsK7wq6HAO5gWqK3CtVxohL05uEDahSZMGzwUgUcoKUagwmU4wSOR5ewJhupD0UYMJco3fP77g6WTsm9pWBYZX5SuRt7TdpemitGXw3Na65RwYlke/SXVVrCarwm8LWo92bDw5r8hpWtEVGpfLn7X8+sR+QdZTJzclWDUEaNRypPILufWPwL5KJF3PUxCekDF7TPEUq2LQc+Jo6A+7IW/HHnixbmfJwkTXK/slbRzTo97YGJIOX3gm5tXSfxikxAMRkVcBE/xNLLB9WlUzpasyjlM4Xkdh6Dm5RXG3sj8RaJ96GK6bMnLMces614QbvLkp8r8VcRw9gj8lrx0vs2eUo7ndM5TgmPEk9Ny7vd7Kr9Hk3aupAflXxCIRToPC0ZbKaixLlZjYz9CDN15VaKE2v+r1GpG27zOtyKoAF2laXTtm+4bDj+MaT3KZC2J5cnpOwJSQHTQLi/eGsVF6jXb1VYpAHM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dExzT2lVckdvTVNqNXh1amV2WWpLelZsVFpkamxFUWlXVzJybmxINW9NVVgx?=
 =?utf-8?B?UXpHVExlK1dQN0xHdnRwM3NoTFNJYWFrNzNaTFpaZ2xBcXMzL3F1d1VpS01i?=
 =?utf-8?B?RkxvWUFELzQ4bkVFUlQ1TzlGOVFpQ3VYcG9KQ205N1FSZVpZT0NndVBPK0dy?=
 =?utf-8?B?MEVoazhWS1hXdEdiRW45dkh1cWN0cUZIeWYzdm4rWE15c2lnU2M4bWl5TkRa?=
 =?utf-8?B?VTYvSysxWEtBUzJnckVURTBLTWQ5Y09Ic1RCK25iZFUyY01yTXhoakhNem1L?=
 =?utf-8?B?cW5JN1pocEtqTzE1R3g2MndPcW94ZCtLRG10dFRuZ3oycDlvVld6YStHSWkw?=
 =?utf-8?B?ZFExNzl3Wm9IMWozazJFQnRsMkVPUnVXVzMzZDBWRTduOTBZYlZVUUIxT3NR?=
 =?utf-8?B?cG13ZklwbzJlNEZxMkQ4MnNyZUdKMkhweUNCdlhwRHFGaitOSW5QM1dXTGhy?=
 =?utf-8?B?Q202NHpheE1YTmFpcTZEbWlYa1E4eGlhTHhLZnNwK2ZpMEVWcTZyZDhGdldR?=
 =?utf-8?B?a3dSbldNV3pKL2NmZ0ZRUk1kdERoekpJaFAvVi95YUlnWFMyVTNuOFRHeEpF?=
 =?utf-8?B?cDVkVTU2UFIzWDRybTJWSCtWYldYMVhvWWJISzQxRERWQ0E2aGNieThJQU9n?=
 =?utf-8?B?ZnpTT25xZW1HbkhVYjFtOXpIWnNNOXhiL0cva0RJbnN5MVM5VVc1R1BPR2Nw?=
 =?utf-8?B?UWowT0Q2T0hqYU1SYTFOQ3M2MzBlKzljQ3FlVU03aFBMZVdkaVpMZXpzam5z?=
 =?utf-8?B?WHIwRDhBdnlUMUhPMnYvR2ZManZMVFJEWjdKR29rY1hJckYyeE1ZRnJ2ckJU?=
 =?utf-8?B?T2hhQVZ1M3Q5cjIvRXFaZTV5K0ZDazJ3S05XcmlLZnhHV2pYSFVXQjJoT2RM?=
 =?utf-8?B?Z0FIM2p0aTducjhTZXdEamZTMFdkUlkyYU83ZGp0MkhhTUdxSTdjY2h0TDV5?=
 =?utf-8?B?eFIrUXYrWjhwSmc1SG1zQnFGb2J3elB1ZFF3TTZ1aFdtSFM0TnQ2bzZBNEJE?=
 =?utf-8?B?YnM4aHBIZE1LaXppelNNQXpnM1Z4OGNSL0s1QUp1T0ZkMSs4WnlGMDJkNHNv?=
 =?utf-8?B?VDFDMzQ1dzdxZU1XbUNxNFBvSWkxbTdJY1VvamZ6ZlQ4aUZKWlptOTgrWnV0?=
 =?utf-8?B?Ukl4VWpFdy9yM2NMTG8rZ2Z6cmdLQ0JZOWZYNTFjOVlFeFpaUGdtTXFXMHlt?=
 =?utf-8?B?TWFITmEwT2Q5YmN1ZldKRmttcXdFcndoTmJZWWF0djFUZ2hjZ0FQTXRFLzB6?=
 =?utf-8?B?c0VYaFh3REFVSUVEN0FuTVc3ODFLbE5nODYzMXNQK3d4U2RXRERsY3pPa0RD?=
 =?utf-8?B?dVd4U3lPdXZ1NklxN2JqcG1nM2ZmUVVUUnl4Z05ZZW1sL3Rud0ZCZXBPQ3lI?=
 =?utf-8?B?Yk1ST1lNZGR3c3RpeDR6aHhzNVM3NzZ3NThWU2V6YmkzcDQvOW00UFM4WWlr?=
 =?utf-8?B?Z3FIZG5yeW5rbHJCclYwbXNzNjVZdjJwb0hQdVZBN3dvK0JOR3RtbHRsTFV3?=
 =?utf-8?B?VGdFbU83OEdzUE5MVHBnZjRsRFJqR0lLMU5yU3QrZitYWUkyVENWL2VGWU1J?=
 =?utf-8?B?YkRTS1hTT2dUeUFrSE9HcHZUVVBzUjU1ZkxKS1oxay9oUGgxRmFkdjJ0ekgr?=
 =?utf-8?B?cXFJZU9ucWFoU3RGV2hWNFBSUm1rbThCVE5oMXRxRFR4c09meDhIL1pReHNW?=
 =?utf-8?B?SEM4bjA4MVEzNlFlZXFlNk5kMlFBckFadWozZ3RETXFwVjNub3lPc21RUjFq?=
 =?utf-8?B?WlBjMEVjeXZhdFA2MEMyNDdFdEhxVTdYQ3JMWTBZWFphS3NPZDYxUnVGY3hX?=
 =?utf-8?B?Q1E3NjFvd3RHVVp4OXpIbTV3MW43SjF4REFWY2lkQTJKLzBmbHY3czhKVzF5?=
 =?utf-8?B?RVhERTQ3VW5hd2Z0eHpjSUF2YTJEZUdKWjY0dTVoV2oxV2lqZHFPOEVnbUdm?=
 =?utf-8?B?UUJuSDYrY1dtNW0yUEs0N3RlQXI5KzFWVkJFMHE3VlhFUkVSRzMwdVJOeVZL?=
 =?utf-8?B?M3BSK1cyWGtBc3RSV29sSDlkenhHVU1yUVJJY2Z6VzN1ZnZ6Y1I4NFRqZU5F?=
 =?utf-8?B?REhvSktGL1pnMDFKQUk2a0RGcEJ0QmlqMnRRNGRpVC85Ujlja1VDS2JTWXhP?=
 =?utf-8?B?UndBVzJmSXQvQ0t6cjhxeTR6L0lVK3Y4Rk44b1pwR28vanBaRkRtTnhmMVU4?=
 =?utf-8?B?MEZIcWtPMkhVMU9YY0xrL0xPVFp0ZlRBNHBVZ0YzcE5TWisvd2tuYU1MMzNY?=
 =?utf-8?B?R2FoU2ZaUldoYkdDM05sbmtqOC8veGRBY0YzQ1B5RVRjSndTdkJaRnlxN2hZ?=
 =?utf-8?B?T2Q4NjBXK243bXc2K2tXVHJoQ3hiZExzZHhLTjZHOFI1TlVOTm1zSTIxRUFP?=
 =?utf-8?Q?9KYk5klVV7L0JNeI=3D?=
X-Exchange-RoutingPolicyChecked: VkKZhVOwglwwVg02ILbvEfUp7AEcep0r6Snfsg6USEKMYDkWG8jX2nd0ZwwHU0AUjb8EwBo2ALATDKmt/ZvqMdU6iixiVeeHCZHkqb45jGbpBZ7P3KbIrislEkMF5P5odlachyfv4YD3BwByFz6cWI+j1oSo349sLG1dY3fezato9EiUOgmJWgVxcQZBlQPLQez5ZXW+YtbhGQl873BIqSmlKQZ6ptK6Vy5xfbcm0fUvU9G2k7Knl/Eve681JlfF4pruMtfPj3i26meZ6CXjW4j7ew0zOQKNRy0Isge0dx6Eknm6jhBAz5yKVVWxYFtZjm8gcDBnQJPUr03YjhZvFA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e705903-50e9-4bf3-306a-08ded82619d5
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 10:38:49.0009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VmV4N4YWhIFhVyz+PXfeDICZE1RWLCYJ7Q2dQajEspf3Y1xv1t3Pjqo98IHkGY04tMEus9XQwypnh2z94XIm9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5893
X-OriginatorOrg: intel.com

On 01/07/2026 23:33, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] Unconditional NULL pointer dereference of `dev->dev` in `i3c_master_queue_ibi` during device teardown
> 
> Pre-existing issues:
> - [High] Lockless TOCTOU race leading to Use-After-Free of `dev->ibi` during concurrent IBI teardown
> --
> 
> commit ffdd9b066a2bdadecaab205d187dab1a5ecff5ae
> Author: Adrian Hunter <adrian.hunter@intel.com>
> 
> i3c: master: Report wakeup events for IBIs
> 
> An I3C device configured as a wakeup source can wake the system by
> generating an In-Band Interrupt (IBI).
> 
> When an IBI is queued for processing, record a wakeup event for the
> device if wakeup is enabled.  Use a 100 ms processing interval to give
> the I3C device driver time to process the IBI.
> 
>> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
>> index a47e2924bb701..a36f9b617cbf7 100644
>> --- a/drivers/i3c/master.c
>> +++ b/drivers/i3c/master.c
> 
> [ ... ]
> 
>> @@ -3007,6 +3010,9 @@ void i3c_master_queue_ibi(struct i3c_dev_desc *dev, struct i3c_ibi_slot *slot)
>>  	if (!dev->ibi || !slot)
>>  		return;
>>  
>> +	if (device_may_wakeup(&dev->dev->dev))
>> +		pm_wakeup_event(&dev->dev->dev, I3C_WAKEUP_PROCESSING_TIME_MS);
>> +
> 
> [Severity: High]
> Does this code introduce a NULL pointer dereference if an interrupt arrives
> during device teardown?
> 
> During I3C master controller unregistration, i3c_master_unregister_i3c_devs()
> clears the device description and sets i3cdev->dev to NULL:
> 
> 	i3cdev->dev->desc = NULL;
> 	if (device_is_registered(&i3cdev->dev->dev))
> 		device_unregister(&i3cdev->dev->dev);

I3C drivers are required to disable and free IBIs when they
are removed, and they do do that.  There is a corner case, if
the IBI disable fails, but that is out of scope for this patch
set.

> 	else
> 		put_device(&i3cdev->dev->dev);

dev->ibi will be NULL for devices that are not registered,
so i3c_master_queue_ibi() would never get to i3c_master_queue_ibi()
even if somehow the controller driver tried to queue an IBI.

> 	i3cdev->dev = NULL;
> 
> Since clearing dev->desc prevents the driver's remove callback from disabling
> the hardware IBI, the IBI may still fire. If i3c_master_queue_ibi() executes
> at this point, the newly added device_may_wakeup(&dev->dev->dev) will
> dereference the NULL dev->dev pointer.
> 
>>  	atomic_inc(&dev->ibi->pending_ibis);
> 
> [Severity: High]
> This is a pre-existing issue, but does this lockless check open a 
> use-after-free race window?
> 
> If a hardware IBI interrupt is processed concurrently on another CPU, it can
> evaluate if (!dev->ibi) as false, get preempted, and then access
> dev->ibi->pending_ibis and dev->ibi->wq after they have been freed by
> i3c_dev_free_ibi_locked():
> 
> 	kfree(dev->ibi);
> 	dev->ibi = NULL;
> 
> This is possible for hardware controllers like dw-i3c-master that do not
> implicitly synchronize with executing hardware IRQ handlers during their
> disable op.

Yes, some drivers have gaps.

For dw, an IBI would have to arrive immediately before the DISEC CCC
and end up being processed during the same invocation of
dw_i3c_master_irq_handler().  The DISEC would complete() first which
would potentially allow i3c_dev_disable_ibi_locked() to
atomic_read(&dev->ibi->pending_ibis) before the dw driver gets to
atomic_inc(&dev->ibi->pending_ibis) via i3c_master_queue_ibi().

Out of scope for this patch set.

> 
>>  	queue_work(dev->ibi->wq, &slot->work);
>>  }
> 

