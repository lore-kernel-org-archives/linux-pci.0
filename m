Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257DE42AB7;
	Sun, 29 Mar 2026 21:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774821477; cv=fail; b=G8Cy0R4Q7x1KMiwoo3mIKGYulo33GjPizT6BJRi0MRTCxVZkvWYtUhvolHBGt8ClbYgqkqLeIehC6YLE6ikeKAkkbcnKH/GfKWQoCdP0hbXS3PtXUdg8fNSJdlIy0CZ+AvrXGroxTKQ35jlAhhEBNLYbu+RaSjXZ7LGd0Rpedls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774821477; c=relaxed/simple;
	bh=3HnWwNuK1PE6A1rugoPiQZzPiI92Qa4p25KiXgrl90o=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=ZrMVnET4Jkj5OWvW2y9DPNofUF8HzQoRnvmvHqqXU7AYoIt0J0nJV0Nt82sULIUNosKeTB7wk6O+wOaSgMOVvUVn2N4S6VOfE/BD4kFE1hLOLjw/WDURRelNkoH/z4V12958PlyG6vUkNPNl8/NwltBJN11qAH6u8a8OJGcmsJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IkldOfcf; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IkldOfcf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774821476; x=1806357476;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=3HnWwNuK1PE6A1rugoPiQZzPiI92Qa4p25KiXgrl90o=;
  b=IkldOfcfbnopqZwWdPDAVcT7GZDEf3wZXMaYT4PWEAXdXj5oG1mX8aHz
   2CCyitDHR3O10i72gUYY8/R83sWdoQJ4qcLghCi9WFxaTg+gL93LLKdb5
   tBSSqBy4/DOp+8leLGjL9rkM4SDZ44292O4J11uGe3recZhQkxg0DFcdT
   g8h5ppcB0jfEAOG4VYgnP7V+zxuFvw/At3xXzYqLP7vzwOcY0MeaCtm9e
   QcgAhiS9VkZREZXmpvXANi6XK1oQAkC4cOVJZ2XhZq/ecBPn5LK6wp18y
   Q5wUnVgtHtDzsrgu+XeC4PLFF1KClFzn6ExrbfVtbg4CvH75aBcGNA5Q+
   A==;
X-CSE-ConnectionGUID: 5YuW6jkSQfKYMkFQGxtMng==
X-CSE-MsgGUID: uJZA6s6mTaqSuLSbXu5kcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="101272350"
X-IronPort-AV: E=Sophos;i="6.23,148,1770624000"; 
   d="scan'208";a="101272350"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 14:57:55 -0700
X-CSE-ConnectionGUID: 3mk+KRC/QVOS2MMY9WHNgg==
X-CSE-MsgGUID: ZSBmKE7/TH6TVuss3DHnXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,148,1770624000"; 
   d="scan'208";a="221006600"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 14:57:55 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 14:57:55 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 29 Mar 2026 14:57:55 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.42) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 14:57:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oM9rqwzJbeUzaMH5fsERTT6FMshzRHwBRaWFzQO8FMM4ZgiFqbXymOwvwYJhHzqYiELkMFkAWezJSwRqHA2TIFsv/yxv74WSUykSToy9UcOwYSNKKnUOvazNi+Aa14MvwbJBNXmOQXqXwVA8pPfPCSI+yrOjAF3vLaoDB9aGHej/aRaVd23iaYYY8uTo+utUYKP6MD3c+VQ8swWE3X0bXIxU7QuPzNSAvkFztFBu/JcW7TO3kcoTjY+Qe6g/LDNsHAYwgTQR4FwHE26O935I2Iw/2w+kp192XVLJ06cgorH6ght/oDG0TBZY+STjqday1G3684SVIiCUPwEKpzZ7xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lywJeRIaVetFZ1wLRQWwL+JqwUcmodM5A9eFsjwmGGY=;
 b=g/2tQuLlMPrz12yULi3/9mEwiLCtfHSQlWnZgsgOtDRwDvuoM+3MuZnn/rFfNzYqmal8gmmoud90ZPFBZYlSR9ZkuoDrO29nhrF/Xh1ecTleNoWeWj+/iW1mIl7JFHpk8xhywsha5dt/0RYE31i4m3oJV9kuLNOLRt12pIBAH0eWzMEQJ9gqn7nw7Qw37oq0bwqr90UAMwPRwukA1E0eDRLs8PK/kwscK7bIXdebznfVZSc0yzW5VqpiZu1tUXQO5c+HAI6VkNZMvZ2z87N5QqvusSLQPo0HgCVhy24V9XXr6W1nWGIErd26ZY3uyr1jR4pbXq524jy101aHXIGBXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN0PR11MB6277.namprd11.prod.outlook.com (2603:10b6:208:3c3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Sun, 29 Mar
 2026 21:57:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9769.006; Sun, 29 Mar 2026
 21:57:50 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Sun, 29 Mar 2026 14:57:48 -0700
To: Terry Bowman <terry.bowman@amd.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<vishal.l.verma@intel.com>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Message-ID: <69c9a05c45d99_178904100b0@dwillia2-mobl4.notmuch>
In-Reply-To: <20260302203648.2886956-5-terry.bowman@amd.com>
References: <20260302203648.2886956-1-terry.bowman@amd.com>
 <20260302203648.2886956-5-terry.bowman@amd.com>
Subject: Re: [PATCH v16 04/10] PCI/ERR: Introduce PCI_ERS_RESULT_PANIC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0107.namprd04.prod.outlook.com
 (2603:10b6:303:83::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN0PR11MB6277:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bd37050-45c8-45c6-4d51-08de8dde38b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 4kG4gfIVyxjkE85Amy2QbMtMlffvfvIyy1WkSQfXff6EZLi9EcG2kWQVu2CAz/o9WTvxIHV27p6zQOKeUl1fGBIJSd8sGj6E5jgEvLVkF25qrbtcMKDWi+twDVThIeo1jBN+dK4jBv95A80Um2m4jsmn6HQbCkHvUn3QOWg5MtpuIBn5k4O/qEJVMNKwvuE0JJFLXanlQV2vtcR0E8iTfWdc+KATS6F4nJ+Gf0S4+X1CdUNyH8x5ZXvh4JJ0q1kCLE8GQMwqOKo5PI+mW9eVugUAAn/nV6U/p+smuVVfU3wnB98IjXqOOlQ5Lgc6Sq21lNpFutlLCj5hBGjPmCk0I/CX7W7CRX0AcNdH+oWaT+rMbD6cyx5gQoch7f1CObYn7ry6CVkQTxjJuvXuqsDBy3QqtG204vlZ9q0LjYIqgO1TaehJGHpduvWPZwAs1PHbjgi++FJ9W44L22eXEqa/ZcOPSic4fdJ4J5PEHh8Ty3zqL3jzGYjPVdv7wDihVz3K5T+JBmEMccNogVgYCbIj9mncqWKSK3vNcK6oUkV7T8qSuNIjHjqHfq5ljigKQ2zjxcfDWr80u3Q15cU3ijYEBD6XSjCu2JlVXRpt1uGUiZF5nQ2OntQUI6b9b8covXq6cM0DBzk7UgDmh4KfY5XfJBMvsi+a7WCwq18wVbGTuD5SJeOoWTVg6A6v3Rn6fH/jKwBgTEh1f9ygLqcqzIB+HJKK7qtH72xBE8RZYTVP4tuen2CWatdh7id1gibp7ZaoOUrtYgg0Xm1GAvJAoR4R8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHl6SG83Z0RmaUNtNlY0UDZJVWRNWDh2b1BNYWtLc3lZdjUyOFFEOW8reVVm?=
 =?utf-8?B?Z0ZqSnA3VjQ0c2tjZ1JOb0syYXU3Y0FQY1hFaTRwWE9ic0c3TUplUlpQbGNE?=
 =?utf-8?B?V0UzS2VKYXluT2dGMzgxUjB1ZENRd3B1ZzZicDJjSjFUdDY4Q1dMb1BhYktz?=
 =?utf-8?B?eC9yKytIVmtrUFRJbTIwSFY1OTFlbGY0SnQ3UlY1eHNURkZpOVhZd1oxOWpn?=
 =?utf-8?B?WFh2eFRMa29EQ2ZmMjZOaWc1MndYd09LeStSckdYVUl2KzAwbmg0Ylg4Qm9Z?=
 =?utf-8?B?bzdHenZkVENGbjlrQldxRWJ0TEl6bzFtY3RUR1MwaG5qUWlIYk5xZ1owcTh0?=
 =?utf-8?B?THkwbFZEUjdOMXRCRmZ4TXNQMmxYUXFNV0VIakFKM3hWeVFobjhWNHRQMXpo?=
 =?utf-8?B?UkdMUWZveEdpN2JXZWZjUEg1OU0wREk4Zzg4Q2ZYMFRvNjZ4K1l5NHM0Ulhm?=
 =?utf-8?B?cnNKZDkvR3FFb29NRVlHWUlNSDVzQWVjVUVOK01tK0NOVmhZcVlOOGQyTThx?=
 =?utf-8?B?Umg2dkhmUXo3bG1IcW1UK2RzQytHajNXRVFYWjRKdnBkL0pBTDhzZCsrb01k?=
 =?utf-8?B?L1ZxQTU3bTBEbTFZR052ZXNaeVdMQ1NDZWx6NU1RcGNkWXRqa3BzTkVpSUI4?=
 =?utf-8?B?N1FMU0VoUlpQUlVCTE55b1ozTjFNbkRPLzJLclkxdmJGVnNwdXBYN3B1cXZt?=
 =?utf-8?B?bUNId1pLRUVsR1N3RWNtdklvQ2VBZmRGYzRRY2s2V3B1Q21UTThHS0dKL1RE?=
 =?utf-8?B?c1BWcUdlSnVTU0tQeFh2am5lRU1zRGR0VlAzRDgyTVZqOXNZWWwxRmFmQXhB?=
 =?utf-8?B?ZjBkL1NQN2FPaENxMUR4UUpQdW5Vd1dPM0FFN2QzR0RzWWk4V0RrM3lKcUFa?=
 =?utf-8?B?Vjd2R1VGbC95ckhhbGRDNXdPNEFKcjE0QjlXcUQvUlFkM2hNeEJDWEgzM2N4?=
 =?utf-8?B?Vk1rT015bVB2UDNDbUR5Q3NpazZsR2VTUXM0SWs0a1E1TXFpUE1wU0gwV09h?=
 =?utf-8?B?ZnZhb05TbGR5SGNKS3NOcyszQTRxcXY2WHV4UHZ5WDMrSE45aW0yd2hoNXZu?=
 =?utf-8?B?OUk4ZlkrcnlNSDZGQ2d0cGEwRk5sWmVnVHhaRlJSMmYxNnh5TUlwN2V5MENM?=
 =?utf-8?B?My9idkNqV2l3T25qMVNGMmpvT2d2N0cxT2FoV3liOEQrOFA0eEdmN0dPM3BQ?=
 =?utf-8?B?M0Nuc2ZoU0NNRWlwcjJ6UmlONGYxYkdQSnpwaGh3L0FXNmxYRFVUZFhZUW11?=
 =?utf-8?B?REhFeUNxL0tLSGRNWDJtbEh5RjBETVU1K24xS2ppNGdycXlBUmpWd3FVR0ho?=
 =?utf-8?B?WGNsUEpMZ2t5NUdJaVpYTDBuT1c4RmtEVUV0Q1ZkUGFueGRJTVZvclVaUk9j?=
 =?utf-8?B?aHBtQlEwQlYvQjI2aVpIUEJTN2xuWkdERHlzNTVQK3JGNFFHbi8yeHV2bGdK?=
 =?utf-8?B?cHdsdmtVUU4wYzZuVnNZRldja1dkVlFteEVsMXFlMXAyWElOUkJiWmJnckNa?=
 =?utf-8?B?RlZjQ0lzdE9OYkk4UWVQeFdFMWNORUxNVEY3VjBvalZTOTJ2Qys0OXd4T0hU?=
 =?utf-8?B?YVBtcmpUa2MxRnpTRUdjRit4SmxWcTFsZjdFa0NjbzlsQjZVN3RBSHFZNDlW?=
 =?utf-8?B?dThvVWdTN04rMFpSaDBpVGk1QlZQWEpLM09JT29rV2xaZGlmSHc4MS9oM0l0?=
 =?utf-8?B?SDdnd0dtaytzaXNUT1J3cG1tSHV4c3A5VjBXbHRJZG5iNkc1anZrUlBFTXBU?=
 =?utf-8?B?QkRsTXpuQTRwL2g5Zm80UWp0eG93RVRwcG9yb25NajJBVmNIUlNPYlN3TWgr?=
 =?utf-8?B?SzZ3a1FXc1BTVzB0OUFzR0dtME56TDloc1lKRldHc1cvQjM0a2VmSTRkTjVF?=
 =?utf-8?B?NW55MXNOZFpBVzdNR1IwQzBGaWxVY0xuNTJyZnVzQzdhYUUvTmQ3MUxzUklW?=
 =?utf-8?B?ZHdYNGh4Y2V5bElCL1VHdk1SOW9HSDhQcFNBcnhsZU0yUStnaVh6Y0RZR0N6?=
 =?utf-8?B?VmV1U0N1Y3d0cmZEQzFhaWs4QTVLNVRIekxzY0pIaWdGb0ZJMGprSVRydGVh?=
 =?utf-8?B?aUEyaXNCM2NoT2FVSjBSb1Fvek1pandLcHRXcFp6bjN6QVZhd0hsMzBad2JD?=
 =?utf-8?B?eGJBM0JTVVBUU0h5ZFpQajF1cDhPYnhRZ0lmaUt3cFVNYnM1OWdZcmk0NEdF?=
 =?utf-8?B?ZitxN1JrTWFXbFpyd1RFZWhFMHhWeC9kWm9EN2NhejhxdEZ0czd5d1dzbG9P?=
 =?utf-8?B?MW1BeDRkMnFXbVN5QTVsVXk0NmtndTBiMGZJSC8wVU5ZUWVUdkRLNHRsTm9h?=
 =?utf-8?B?YVBqT25GOWUwL2JnQ3pnS0dCbmJ6K0ZSMTNwajRNYU9rQkRIUFR3NFVPSDJC?=
 =?utf-8?Q?sXCanl8j9SuY4BdQ=3D?=
X-Exchange-RoutingPolicyChecked: rkgrUthXx25k5mRtFrN6yzC8kFCEh/KvoJqxjcIkTm57C7C2uJpkJMmLXTG5saFWCWVlq3d3lVGqRF6+JWfmJibZVhR0VgZ1xm57ipyP1l5r3nhn1DgxxTl/MUid2OJMBAgFfCXHUhlC7MwnOiPiUExU9EVi1ggh8IAgjIv61pta2ZqG+y+wMdN10/lIjvp5Db9OCDrL3MIY1NlhYGrcuJ6c1j+RyztqG0t2f6vSigvdim8ne80F5DkVhSJ6Fc5uQpxqCy0eV2EWW0v1/BnrtO/R/DodTfYcvxU8X//WJ14zRnHfCP1t9n+Y54dvy8DLPKmEodc8kd31kLy+p4WwoA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd37050-45c8-45c6-4d51-08de8dde38b1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2026 21:57:50.8086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +YLYzVtYCNqIkWrpShufbuJ+AUekE/zU8lPOYn2Q2F/w/n4COUH53Mm+tgJH3a9nmctigc6034P+6T+QUVtchFcoP341WUnrp/RidJykNhY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6277
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> The CXL driver's uncorrectable (UCE) protocol error handling will be updated
> in the future. One required change is for the CXL error handlers to force a
> system panic when a UCE is detected.

Similar comment as the last patch "future" has no meaning and "required"
comes with no context.

> Introduce PCI_ERS_RESULT_PANIC as a 'enum pci_ers_result' type. This will
> be used by CXL UCE fatal and non-fatal recovery in future patches. Update
> PCIe recovery documentation with details of PCI_ERS_RESULT_PANIC.
> 
> To clarify, PCI's merge_result() implemented in err.c is not to be changed.
> merge_result() is not aware of PCI_ERS_RESULT_PANIC and will not return
> PCI_ERS_RESULT_PANIC.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> 
> ---
> 
> Changes in v15 -> v16:
> - None
> 
> Changes in v14 -> v15:
> - None
> 
> Changes in v13 -> v14:
> - Add review-by for Dan
> - Update Title prefix (Bjorn)
> - Removed merge_result. Only logging error for device reporting the
>   error (Dan)
> 
> Changes in  v12->v13:
> - Add Dave Jiang's, Jonathan's, Ben's review-by
> - Typo fix (Ben)
> 
> Changes v11 -> v12:
> - Documentation requested (Lukas)
> ---
>  Documentation/PCI/pci-error-recovery.rst | 2 ++
>  include/linux/pci.h                      | 3 +++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/Documentation/PCI/pci-error-recovery.rst b/Documentation/PCI/pci-error-recovery.rst
> index 43838723fde9..55be63f1a649 100644
> --- a/Documentation/PCI/pci-error-recovery.rst
> +++ b/Documentation/PCI/pci-error-recovery.rst
> @@ -102,6 +102,8 @@ Possible return values are::
>  		PCI_ERS_RESULT_NEED_RESET,  /* Device driver wants slot to be reset. */
>  		PCI_ERS_RESULT_DISCONNECT,  /* Device has completely failed, is unrecoverable */
>  		PCI_ERS_RESULT_RECOVERED,   /* Device driver is fully recovered and operational */
> +		PCI_ERS_RESULT_NO_AER_DRIVER, /* No AER capabilities registered for the driver */
> +		PCI_ERS_RESULT_PANIC,       /* System is unstable, panic. Is CXL specific */
>  	};
>  
>  A driver does not have to implement all of these callbacks; however,
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 1c270f1d5123..0d6ad11e3422 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -933,6 +933,9 @@ enum pci_ers_result {
>  
>  	/* No AER capabilities registered for the driver */
>  	PCI_ERS_RESULT_NO_AER_DRIVER = (__force pci_ers_result_t) 6,
> +
> +	/* System is unstable, panic. Is CXL specific */

I will note that panic from error reporting is not a CXL specific
phenomenon. One of the future topics to resolve is indeed the
discrepency between ACPI/GHES and PCI/AER. PCI/AER does not panic in
situations that ACPI/GHES does (see ghes_panic()).

I also notice that helpful TODO in drivers/pci/pcie/err.c was removed
by:

b06d125e6280 ("PCI/ERR: Remove misleading TODO regarding kernel panic")

...which did not make any comment on that mismatch.
