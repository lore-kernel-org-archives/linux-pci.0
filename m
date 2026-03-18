Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C95536B07D
	for <linux-pci@vger.kernel.org>; Wed, 18 Mar 2026 07:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773820610; cv=fail; b=Kr/OLiXudoQv8v4EOw8yCdSvl9qUV08S65imCQc2YVuzFc/G+wF6MQW06UFww+14ueo8heMBNtpNZGxMbHZB/VCthU6vYhN0/lcbYeMSBx31bydKvhjgOUPRFNZPyoUCtnIvOoQpTyt79YJ9qQc4V4e+Xh6/W8f0AsZIpEaFL4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773820610; c=relaxed/simple;
	bh=tZW0uBtWLVkXTlioikte6BZuJxa0DsFjVRs3GtqxFS4=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=KqGY7EL7XyGx0yh/cKL3z1GP/ex6ZXPXti8bKNB77LxrAtnLX8rt14midnpz/JKaGPHZMBY1DtMQgMOTxu473v/TGmsB8nhngs5IPjQqUNgeHRSKLM67+/EyxVHN1kDyWhdQ3FYuiwiElhgBunEmBHW33NABL/S8M6RZ3iVZmeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iLQ7AnlH; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iLQ7AnlH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773820610; x=1805356610;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=tZW0uBtWLVkXTlioikte6BZuJxa0DsFjVRs3GtqxFS4=;
  b=iLQ7AnlHaS4I92vQ9+zuiaepS4uliKLXnlVKWAEmm0MyPgTP+9hUK6Ta
   tUmWf5Ail7MnhCoqUo7xsgcTGWiSmhhQDtmSoufM1a+DLaG/wvanZi8Oe
   MdRbNpHqVCun2AXp+yRTwR7z0dhJG9ajchImga4g5PD0rOQdjqxq29GG5
   BnKdGe6/Liv2aYVWt2uu7EFawPwKuoFl3W5hvq2LT5BeE8CAY95KhDpUp
   TXd1xUD8uuSTmzXZrDVPYumWDVV/32StqExefsukRn3WiG/jNhvoo7bVV
   S+aoX42mBpEA/GoqOPXOyRk4gVWggpoigfvqkXQu4O2E/xAnuuWkqmWrX
   A==;
X-CSE-ConnectionGUID: /4Zcl9AJQg+Ni6+Z4POZYQ==
X-CSE-MsgGUID: f2SAc1v6QbylHqGXd+/QOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="85183713"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="85183713"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 00:56:48 -0700
X-CSE-ConnectionGUID: guIJznrfQouCH1CjedSUgA==
X-CSE-MsgGUID: sLDKL6SXQdSUAU8Nr1zlpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="224634835"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 00:56:47 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 00:56:46 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 00:56:46 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.31)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 00:56:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EN+Ni1YzkkKzoFajnMN6U0jAFnW6COBx8w5uBc8P1F6S0PUAsUy8tVEnTeUzycD+1NLTutNjUKlm4IAFdnLfrz2dgV8ytf+a9Ad4Uo5PW/uGncg7GHoMeXEIJajM3ULgSMZRIf6xiLGKxlXprf2i8yoZjAYFxwDZ/XrdTeFvBzPb/X5UcrQGetuCJKUK2gjJT3whjoD24+mL9A5mC/QGmRiZ8s/R6ch7qdEMxn8Z7H0iXMzhygSPBEG0ApZXDNE+I+Rev0QTTZhlBbRXfP1bOAcK/GbnZsvacFO0ifU0NsPeUun1Nld2n4/SRVwFvPn8fbuS4kKTa+ZXBS9bSDHxuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gDRD7jblOqlDcegqM+iyTWUo7HmeqFv4cuISqdiWFA=;
 b=goSlttvNh0fwOzgvtBfkvitTXh6BBOJyJx5qP9E0TGpPzmQtRpr/VmEeRH/fQ/EAJt3Yfl3N42bcFFuMx7rN20aNwfdL55ZCTcGN4SkQzOFgYghg2LzUzT8YTLLHp0N4AHj3mfeqi1/rg42lXf0/DW/BiUkh7SrNILWSK1Dx62eX3WjhE5QGc7kwslaN8iPgLK+RDBHIaQRZ3YpRg12RxCYvQ1Z2axqxesvlsaJULSCifYQ0aG7fgk/E7wl72w5geRpS/IIyHoYBRpRYhuXGwldDaYUEXLqeMK5qV4xmQCyYBRu2fFcLi//Dfl0QlW9boynZjC+oCPJsaoFBbuUIOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB9454.namprd11.prod.outlook.com (2603:10b6:8:28c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 07:56:45 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 07:56:45 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 18 Mar 2026 00:56:42 -0700
To: Lukas Wunner <lukas@wunner.de>, Jakub Kicinski <kuba@kernel.org>
CC: Dan Williams <dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <gregkh@linuxfoundation.org>, <aik@amd.com>,
	<aneesh.kumar@kernel.org>, <yilun.xu@linux.intel.com>, <bhelgaas@google.com>,
	<alistair23@gmail.com>, <jgg@nvidia.com>, Donald Hunter
	<donald.hunter@gmail.com>
Message-ID: <69ba5abaf3ae7_7ee3100d@dwillia2-mobl4.notmuch>
In-Reply-To: <abmaG0jC7b05Lytz@wunner.de>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-9-dan.j.williams@intel.com>
 <20260314111245.76d18d73@kernel.org>
 <abmaG0jC7b05Lytz@wunner.de>
Subject: Re: [PATCH v2 08/19] PCI/TSM: Add "evidence" support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0086.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB9454:EE_
X-MS-Office365-Filtering-Correlation-Id: 898acd73-2e65-4f53-e1c8-08de84c3e63e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: YdS/xkbFpIj0T4IwqB/FdKYGaVeWcOp0miL8OJR2DqFfhkiUUBlpu1ftLLOVr6q/RYA2dkfY0aAJpHusgV7wO2oe4zSiBaC9q4f8xeF/gOL4ckuqdYCJDo1674THI2CZq17atuUxicEoUhTRnwCO05FrhcKSvpDBsFsGEOVLQTiivX9220k6Q4TEe36XN6uZAiCkzYX7YEK4+vJOSm3OSsuviF0vvebbZokCd9iZWUmmPXG4aJUvFp8V+xTMDkd2RpYUYGg6XdNdv+yLMPnjnIvuyAXsLLHO+OOj5IFvq+8E6ORoGH+zZzBZDd5R/Y4jueuvfrq3oIW+Hnc2vw5djfeg61zrrliJCksZvUxPTBi007g17fHPMzmVWmvvdJMp8wN7Xg3K0DIqDvIWVUhZWUZqUsbQEINEwjtQmVFtjvWbA48syWw4R1qTdYN0Q+DZqOvjz3NDvTled4I7Rv/3ZepYK3fk8S6hOltsEQbTq8XrWiIe0lYHQ0dQNK5niF8ZLgCYfrN4RShjJUv5YUw/XryxLu/BdB9/i5NNKhjTIKjRjTeE1u+9puawZHMUFTmIaoE4MGuYJOu912aedNUb3x8T6YmP1P5c1/0M/As724IQEerD9b0TRoVbpIuwi64rNe+zQH4vhVcmSiU+oy5W0fkiaIlKipeiY97JSCF2BHdXCmo6UcWENRlj1dY8bO3pep3GsBwyhNjgporeoRiwJi/mdSRve2npn3deBJllNjA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTZBU2s3ZFFlSjZPdkZxNitTTHhwaFp2VW1wNURkMExpMEk0aC9GOUMwU3hB?=
 =?utf-8?B?eUEyNTJ2VUdoeTQwRzdja0tYNTV4MGRYeWU3bEtsb1JDVFlxN2tWaXpnNGVk?=
 =?utf-8?B?Znk1MndMSEVCVnpjOUl5bXhLc3dLaUk0RWhrZ3BBd095QVRWbkU4V2l1R3l2?=
 =?utf-8?B?TTJiMlF1K2pmL3hJMnZxWUE1ZEplRmpXeGJzcFh2T2U4LzJaYnNwcFZvNlNI?=
 =?utf-8?B?U2RGWUN5UVY3Nk12V0VJUVVRQVF5RkozbHBUU0VycHJPdHROcE9nNW5BR0lO?=
 =?utf-8?B?M2V1UUphbTM3ZEhpSThhL0dydDR6NHU1bVpPZFY1V1E2NEdZU3RrNHhta3Qw?=
 =?utf-8?B?SjNNdU9SSm11WHV4V0Z2SWhvR2NXNHYxZnRua2J2cUFXTCtWdlRnQTBqb09P?=
 =?utf-8?B?Q1ZrUVVPQmp4VjFFOVdBdmdlT1JSM3B3b0ttVjE1ckN3alFabkQ4UmYyQTJp?=
 =?utf-8?B?aEhVcmlMV1o4aEJIanphcmF3SUdXdWl5NURmQTR6SW16TXJQR0Q5UVhxQ3lx?=
 =?utf-8?B?RVpaWWpOUUEvR3B4TGNWU2J5UHdPZDJYOW1wNmFnSEJTcXpjYnUxS096dUU0?=
 =?utf-8?B?Z2xYY0JFbW12WnBSQmlnU2txRjI1NnloVzd1dE92dnFGY010YS9EcEU2RlFr?=
 =?utf-8?B?Z0cyTkpKamZBVndDeURmOHJEWmFTTkNlZ1hNUTl4NWlEVkZ4ZUZSOE9Ick1k?=
 =?utf-8?B?dkZYTWVOUkFqNXVHRHZBNEN0aDNWYU43dWxRc29sSXJ4K3FNMVRvSVZ5dE9z?=
 =?utf-8?B?MFRzU04wWE9kdnIrclB4RThscTB2MEhOdzNVdC9qMW9QR3J4cVRIQUNwRVJB?=
 =?utf-8?B?a05sTG5PeGVIcVljN1VKSDVxVXY5dDNLMVl5eEFLWFlIN01UYnQwd0RmM3Z4?=
 =?utf-8?B?NTl5UWMzWllYNUMxYXZIY21KdHEvTW5lcERtR2loanlLRTFXN2h3VVN3L1dq?=
 =?utf-8?B?N0ZQc3ZtRWlOem5HWlIreGRyRTRsZVhRTVRmb003SDl4WlNPS1FDV1VWVzhV?=
 =?utf-8?B?QmdvNCtaRFI5WFRCZzRZVmN0K1dBeUdUZlVlMlZmK29Maml1ci9aQy93d1I3?=
 =?utf-8?B?R2VnRFoxOTFxNVNXV3BOZUhIVUdJN090bUZzcGRyS1BTVUllMEVhQncweXJ1?=
 =?utf-8?B?LzV5R1FuKzQwUTMzWmFDZmliaG92Y0FscWpYV3pPTGdtakR1aklQZkx0Mm9U?=
 =?utf-8?B?d0RTUVFLQ2poZDFyR0oyS0ZCQnFvaytSUjN3cHdNTEladzYwNSt3OW9TUlpW?=
 =?utf-8?B?MkNvOHlPMU1PTVp2VjVUMkR6OGs2RGlVanhtNjlrREduZGxXUFRYaXV3cWlo?=
 =?utf-8?B?elE2RHZUVUpyNlkwYXZwN1B1QWhWbUJBZ0hOOXZnVFl5TC9ZcC8rWTMxenhZ?=
 =?utf-8?B?MEZwTWhkTExCUVVrQzRnSkVPQ1VJZ0NQYS9CU3V5QTZ6NW9nL0lIaVhkYmIx?=
 =?utf-8?B?UjVXWGVNcC9jSk40aWpHSExJYlV6U1VqSk1uOVA4VG56VHdxNHYzMmxZZ0Nj?=
 =?utf-8?B?WENMaE4veHBJS0cxMlVhSVA5UEhuSzl4Rml2RzBVMS84dG5CRWZBNkZ6OFRF?=
 =?utf-8?B?Rit5MTZYelJkNW5xa1ZZUjgyYmRGb1lBanZxQmwyNmlTWWpZclZJK1ZHTTlY?=
 =?utf-8?B?cjduU25xNFN3RjlDZVZIT2JYMWdKMHdIeGcwSDQwaVc2Tk15RjF0MzFYcm9N?=
 =?utf-8?B?MllmdnFuM3pLMVF0NThKZTdYaUhzQkdUUzRSK0JJTCtlMDllc1pxSnlrek5T?=
 =?utf-8?B?cmdXaStsVlEyVHd3bFhFRjlSeVZibjVXT1NQTWNZOGc0UEd1QVhkMWxoNDlh?=
 =?utf-8?B?Q0pTY0lQQ1lvZ2lPN1QwMTBpZnZ0eHNmN0Jia2U3RlpWdnp6L1cxMFhGL2kw?=
 =?utf-8?B?RmRoWEE3b0k4d0ErOXYvNVJ1dDg1dStkcHlPM0t2Q29qZm1YaDhvQVhNdXVY?=
 =?utf-8?B?UFhXWUtEQ0FBenlwY1RJQW5IWExnWFAzY04vQXVCZ1hpb1cvanp0U3YyQmcv?=
 =?utf-8?B?aEV5QURCS1dQOGVVRjZWS0FXRFFid3E5Mi9vTkNZVEhSeUFmWFgzR1kyMjhV?=
 =?utf-8?B?b0ErbUkxOEd0QjB0WndVTC8xdWE3N3d3S2VXN3RoZXlaVXZNMnB6Znd1UDMw?=
 =?utf-8?B?V3c4ekRiY0p0VVBsa21lekRDK3p2ejhKOE1VYlRZNG1PMHV3YVlnT0h1ZUZB?=
 =?utf-8?B?YVpTVFRaMzVhN1Y2TC9qN2NnTTdBbkU1N0MzV1J5Z3JEWm15RDllc1I0TW90?=
 =?utf-8?B?YVZ4MFRqZHRyN2hzREtLSzRqYktOd0QwVUlBVGJJdFJBSWtUR0p0Z3piQ1Az?=
 =?utf-8?B?SWZvVTdQaWJ2NHIyK20vdmN0TDQ0VHBiQ2hBKzhzd3Zoc2MrZlhzK1IybHJF?=
 =?utf-8?Q?vAvyZ7V+g96xEPA4=3D?=
X-Exchange-RoutingPolicyChecked: vskj70DZRZl7J8JhliutfF/1j2T60w99vB1Yt6iH94VzSSDGGO5QJ+F+EXw6zsH+Q9S6eOWsasouVIsYZBkdNAoHR94zaNFv2h61PmoXbCy8umtZTSouf9PrEVb2PtVthNS2vRZxSnXma4RYaWihaB1r0yPfMdpVjnBzq8ID6YzBWhgP4YctaAavTviBgDIy+ob2JfKdBpKLOpJFgM3vOt7gmxGQiPjjaRm5QEUhAiHgJLCVKNUN4WLp5iPure9GTxyYL3YEkXcg8M6KQzCS8XxJ8YEFpVhdFXD+8/GNuIWx6blT43/w/lynzmwv7y3rdEga4pwPAdU/syacE2gHTg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 898acd73-2e65-4f53-e1c8-08de84c3e63e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 07:56:45.1089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VzSB/mwkKi9lTiPiuptHLx9eufMgjg1JwfKKsT1rEWFukcuyYkPmy5dVJCODRZpJGgIx0OkPOfnvwUs8ZoOhxyNbU4IK6q9HX4t8SVMx/2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB9454
X-OriginatorOrg: intel.com

Lukas Wunner wrote:
[..] 
> At this point perhaps your conclusion is that netlink isn't the right
> protocol for this job. It's great for transmitting sets of small items,
> some of which may be optional, but it's obviously not well-suited for
> large items.

Right, and sysfs is not well suited for transaction in/out semantics.

> Jason Gunthorpe was quite insistent that we use netlink and you know

Jason can of course correct me, but the insistence was less that netlink
was the right tool for the job, and more that sysfs was the wrong tool
for the job.

Netlink appears to be the least worst option.

> how consensus-oriented kernel development is.  Indeed sysfs has turned
> out not to be ideal because the protocol that we're dealing with
> (SPDM - DMTF DSP0274) allows many degrees of freedom and making
> them available through sysfs quickly becomes unwieldy.
[..]
> If netlink is at all the right protocol for the job, I'm wondering if an
> extension for larger attributes would be entertained.

It is still not clear to me that allowing larger attributes are part of
the solution space. They seem to be a premature performance optimization
once userspace is prepared to reassemble a large blob over multiple
messages.
