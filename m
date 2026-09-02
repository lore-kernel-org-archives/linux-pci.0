Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664C1289E13;
	Wed,  2 Sep 2026 06:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788330466; cv=fail; b=RepKHvLTULKuGlQo4AEeca6nClTcoN8DY+YuVhxyeEpXcw61ddW8MaUcSMI8r4E6TP/ey2dlX5TOrZQdAJEXLkK33y3Mjt1cMV1oxth6iXjZOjOSYwS7Da+61wKX2WSVatBQV3EGaiCqr1Vy2hJSZtfcX1S67zUuXBWVcO+5jM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788330466; c=relaxed/simple;
	bh=zAncDQvuUsCHvnypIsj+pvikqtXfgYousyH3xsoBKDY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=heF0y7s7aycoabxMnsbe6m423IMxXTu6yY0YbDjx6ZnDx2FlNmodfMlMX20v5ZL2d9lKrKHbg5Swt2NhT8uVVgCVK3C688rhVxVw/zkcQsVRDceJmQduZBEQ9S8VHPilvGXMXHww78D25xZOHnuBG+kuYmyV+NBNoy3LbPtcw6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZQX7eMDO; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZQX7eMDO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788330463; x=1819866463;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zAncDQvuUsCHvnypIsj+pvikqtXfgYousyH3xsoBKDY=;
  b=ZQX7eMDOOibWBVgZm3RdmEZeqquYaF7LvqV7i8SO2yne8/qIELDFu0fh
   nHCZyozlJ5GL9MTUgKNTAchdwhq+945ngrujHTG5T+ZFjNVt+S93XHkME
   Cqpqb5E7mmLUZXyfssUGQykg9ZTrYWUNDgXkapOaDvyn7QL8QKz3NPmj9
   gPnQangmyx5J0u07/Np1pq7GlyJQ/WYPEN2iL4/6dlxZ5NAA3XyLwSHKD
   pIOJ+lIykNMFs4nHDaUZAscHeeG01HsKJSl+tHfBxG4X7tPLiv0AqoH9p
   xKE8NCM4F3UIiTfmu5quO75LTs8xl8DQL1nYGhKNJcAL/DlC89SYiZBhE
   Q==;
X-CSE-ConnectionGUID: p4tBVw4nTLGfF7KgFhF1Tg==
X-CSE-MsgGUID: mU+Qn+ytT92tveA2DxOFlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="88980248"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="88980248"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 23:27:43 -0700
X-CSE-ConnectionGUID: fHE576SKSAS1MD+uj97s5g==
X-CSE-MsgGUID: 4uyrvFHSRwijuOjkgp7MKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="307536725"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 23:27:43 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 23:27:41 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 1 Sep 2026 23:27:41 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.3) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 23:27:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZWi2Vix0qQvyhujQ9uodWuFfA8V4IszJp+7dv6w3FC9xBhzm0dqSTQ+qvDPnm3obIn7WpNoAr9XfFgDYDnjPdqK36Jy/ouVuo6L9LunvEKW5lhDyTIbML8hnzFEsLKKNuK1QG/GOm++vy4iLM/pOw+YdFgxWBqD7/PusIc7DpisdOQyktyZMyNHh8aQkfglEQIsVvYEuD3VhH0ZvREfkLtmf8v4fmhE6HHl+UJpWkHs7XxOXefhA0EcmgOmYurwJmRfRfi4kWleiT4Z/j/TtE8/5QFQvmKLPAiBwC4DGO1KBzkk30eRNb6wHQV7J6y92b22et3enZI3IDce3IaAnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7s57TIFolcRAa9pMx89sJv9yZaRbS8kLxTYrALMZhE=;
 b=Shlu8KkpBixc2bBWkDcLwQ6u1txe+Lr6+8XLfFwpM8whd+aKsC2XEVMFzbbf75dHqXHKglByWz1MPCrGUNHyo1BmvTVJOlJUqGU+79IRPJShwsjKjOoJjH6EzX/zxffpl0wM8xJtuv1Qeb1w4lAuE7Y9gR1KwACijBtCEoT082C1kmgWUwfrz+h6XGvi+BxmJsWaF2eDY6xq1UgnjOf+aszqoY1sOXQhX87kSVYb+3wB52D01an6FdY6o9MAvdJ8vCTgeCcKKbkKU/g7CAPoJOH6/8/DrjHV1nyFIZSvK3GVewvkHUBda97X59tb20UU5XQjfQ4YJ+gMK3e1Je7LmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8695.namprd11.prod.outlook.com (2603:10b6:408:211::15)
 by LV1PR11MB8844.namprd11.prod.outlook.com (2603:10b6:408:2b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 06:27:39 +0000
Received: from LV3PR11MB8695.namprd11.prod.outlook.com
 ([fe80::ccc3:3fd6:58f5:927]) by LV3PR11MB8695.namprd11.prod.outlook.com
 ([fe80::ccc3:3fd6:58f5:927%6]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 06:27:39 +0000
Message-ID: <4dfc0aa3-a08a-495f-896d-7ea7c91a12ff@intel.com>
Date: Wed, 2 Sep 2026 11:57:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 05/19] vfio/pci: Serialize config access with recovery
To: Shameer Kolothum <skolothumtho@nvidia.com>, <kvm@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>, <sonangp@nvidia.com>,
	<nathanc@nvidia.com>, <mochs@nvidia.com>
References: <20260901093217.8539-1-skolothumtho@nvidia.com>
 <20260901093217.8539-6-skolothumtho@nvidia.com>
Content-Language: en-US
From: "K V P, Satyanarayana" <satyanarayana.k.v.p@intel.com>
In-Reply-To: <20260901093217.8539-6-skolothumtho@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0008.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::15) To LV3PR11MB8695.namprd11.prod.outlook.com
 (2603:10b6:408:211::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8695:EE_|LV1PR11MB8844:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d99673d-113d-4022-5aad-08df08bb48e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|5023799004|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: VcWY1Faqzu64tCwp23+3kXUav7zJPcvw7FizcBn3uAQ2VJpTZuk2eULB4NAmKhaKGWK9rGNOJhfI+mt96GO9vFprXp3oJI/CqRAqRX6gdk5mUnJunWDNgRtz3PPQIRNSkiVM6KBHvnIzlrCCN+1QBMVdnqbK11XzOWHQ+JxU7WwjfEMoIHVitGt/k5GsW9n+0/jVpmJBgFS50YDEzkOeWWKhP/XttCH4B9ohjUQDlbuGbfba1Zyl9wxXvBCrfenMDq41i/WMNw6zamMcCqTbyUs1UW3qPtfxfGwJfG2sE7LxY44Q+RIYuDxHrsbZw+NOPqFyJcVUw0YZnumysT4AqXFk+JhLgsy25AnnGXasY/ej0hH2OX2ABhZ2wOT5eai8qDAmCZGLLZdtp6mkAEOTLxIKA27AjTqlJga6nOFseRcvYBt4puOZNmOf5ebsK0TUbtgoIyQlRoXgUhm9iiXbc1cWIdL66vewc8tDZ29Q1XxG6rbpp+YSnKScXD/hoVqu1eP2IBBVl+yUhNvc7lcO75NeFwh9aRftovKuKmUfjDlKSBSPG04+jtC4BP42DdOYnVlvvmHfopD/QCdXrXAlyHZUbrNJdYAd4HvrMQZygbHU+Cwlnji+5Y4mpJ4s1cTtTQpKVI85vCiNvR1ac849CIWMlrz2BNolkz7FQL7V0UE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8695.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(5023799004)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmlYdFRDclh1V29lVFBWNThsS0JycEIyV25aUHkyYzhzeC9kalBGQ1V2cmdU?=
 =?utf-8?B?RStZRmVSYTFKWGVDeEtxTmFESXhwUXBTSUppd1kxd2RYeVZaK2tBbE9DVXcr?=
 =?utf-8?B?OFo1aHZJUkFxWStiOFFZRjRPNVZubXhRckoyRExtaFVYRGt6NFQvd21vNEZn?=
 =?utf-8?B?TisxRFBPMmxtV3M0NlVVR1B1WGdRaTNPRXhLS1hBVjJ6RlZvKzBoc2Uya2lI?=
 =?utf-8?B?RmNlNE82aVI2Z29XZlhDMGVUeStFMDY5dnJTTTl6K2c0Ung5OUsrcmh1cmhL?=
 =?utf-8?B?dmZkS1IzNkkrWlVsM0J2bnU3QTN1TXpWajNkVm1oNVBRT1paZzJUWDlwNnRL?=
 =?utf-8?B?TFlqVlFxTFI3UzZYcnhPSnUrZGhicTRCeHM2cm56b3psRTFlaERGc3c1Sm5K?=
 =?utf-8?B?YUJwRXZvVFlnSVpyR0FlYmVWZ3d0UVdvZ2J1Q01zcmZIcVdIeTNlVGdxaTFO?=
 =?utf-8?B?a29ISWVlUit2WXBJcU1pMHZ2ZmdsZ29MbE1WV1BIU1FqdWlkSG9VcnRoYmIw?=
 =?utf-8?B?R2JTQS81MHFnMjdONkEyVFRBVHZTcytCc2hLdlhSSENIUVZwZGhmUFpQZEM3?=
 =?utf-8?B?cDVaZm5jb2txcGlEaElja2t5T201aTRhYzVXVW5SNWRyNmEzOGpKL0FEeVE0?=
 =?utf-8?B?UFZZNjE1UDd6aXE4SVNMMXJkRWJORU9xamVhTmxZY21Vb1hOOHFVVGJNK2Nl?=
 =?utf-8?B?SEwrQXhLMUw5enlWbldlUEdpWXZkeTlvbzcwcjlZVWEvbG1IMnVuVjJoVkRC?=
 =?utf-8?B?VW9HQmk0bmV6SU11ZW94S01SczdiSnp1ZmYzUkt1V0laam1QMnF0RjVuME9J?=
 =?utf-8?B?c3hkWER2eHBuTXhHSnJxWjZxbWlMWGZ6UnlZQWQ0Q2U0R1RGU2Jac1B0MkxY?=
 =?utf-8?B?eW9WSGZSNmZ4Y0pOL3NHTlFEM0pvQmVXZEVDa0NhSi9XdTBhTEk5TmNha3Ji?=
 =?utf-8?B?UTVrRlpMaVdCUVhxQzFONkZPTzlPUDMzMjhzNU0xU1RQR2NRQkhpbXYzQVVy?=
 =?utf-8?B?cS80S0Q2ZzhMQ2hjSUpxZDZwOFpnNmtDYjJXclEyREJWdEg3SVZpMXFXdHZH?=
 =?utf-8?B?SmhVckFZbDZBWXdOTkhpenRYOXkvcGhCd0pNRFVsN3h0N1dEeitTbGErby9S?=
 =?utf-8?B?N0JzT3FLT3ZEaTcvYWhVbTVlNExtQWZDK3lWN3dUWjhCa0xuV1doRHBKRFRQ?=
 =?utf-8?B?eDlqMi9qQ2w0Z042N2lEdVIwRERRMFo2Z3RqbnY1NHpvRHBKQVI1UXFxUWln?=
 =?utf-8?B?WUFtdkNVaVR3WTU2TWhuRjRtRUVQTlVyaGlCL0hIYURoN3VvbHR0OXM5cDBL?=
 =?utf-8?B?SFhISnlnL1pVUkNaWlB4L21JbndGZzUvTkE3SlF3Y1laZXlmNmh0T1ZtOHRT?=
 =?utf-8?B?TTZ2Y0Zwdmh6NjRnRGE3MG1QVE9DUlAvYUtoWHI1eDN2SUEwemh0dW5YZWtT?=
 =?utf-8?B?ZGtZTGk0ZHg4NEpxS3NERWxuY0szN0NWOXFTOG9EelFJbGc1Q2daR1lPT3FW?=
 =?utf-8?B?YlRrcXYvM3owSXFhWkIvMUpYTnVET3hGaHk3T2JyamViMzd4czlKKytvMHMy?=
 =?utf-8?B?aVhEM0tIVk40NHhkMzBVcjlLKzlSbGNSUURPRFB0amxOMkxiMVViS21keWFa?=
 =?utf-8?B?VmdXTCtoWlI3TG54blNWV0hmSW5vQjh5SHJBdko4K3R2NXFJR04wSnZBZ3lm?=
 =?utf-8?B?SUVxSGNwdGh0VnI3TEp5OTFUTDY2NEhuclFsa1NTWEVDbStuMmJ5cXJhdUd2?=
 =?utf-8?B?Q2UyaFhucHBsZWg3QWdXbWc3NU9pNE52TXFKcVNlaTVqRk96cnhxSzJlY1NE?=
 =?utf-8?B?SEhvWk9rREMwSFNDWEo3L0EvejkxK1ZOdmVZODVvODIrVWc3eUY0dGdoeSt4?=
 =?utf-8?B?OENXazBrWm1oQWxReFlEamZNdWxjSWpXOVNyVmUwaVI0bEV4bmlFeUlUZ3p1?=
 =?utf-8?B?RGIwRnVjT05yWFordTRxMkU5eWpnZ2Z0RlBadmZwMnA1ckdZcXNQUFVwNmNr?=
 =?utf-8?B?NzduZ1JvakVacTlxRUpyaWpvVlY0Z3ZXdEJXN1VVejBLNzNVYm5sZ3MwVTFp?=
 =?utf-8?B?NGVxazI0MWt6cFdRTzZBempNSUxRWFgvdVpzMGJmQmlhZnBTdFFjWmlWSVZl?=
 =?utf-8?B?c253NDVPQmgzODIwVUN6ekxTVmVONStPclhCZ2Nqb2xnTEtpNjFLQWtaV3FC?=
 =?utf-8?B?UDQ0NDNaTTdlMXNhQjc2aTMrbmlmRXU1Zk5KTU0zd00vcFF1OXFQNzlmRElV?=
 =?utf-8?B?TGtnVEUweXNjbkorZnNraGd6MDNQWWJjNDBqbHJLTm12RkQyS3NVbEx6VFBj?=
 =?utf-8?B?OGk4dkZYWjd5TS9kZUs4bHZsSFRKcm03SzZFb3ZHVFpKNWxUMEE3VGgvR2lZ?=
 =?utf-8?Q?yWFJIZznDsDkjpi8=3D?=
X-Exchange-RoutingPolicyChecked: QKDcBUb7s6391M3rHD2+ZB6aJzwtErM8Z1nXZRTCUKgDwMp90Phj9bri6xqRdYlwen+0wClsAphfNrptoOYnP7EiLeH7wBrCDR/jqk36PGMmvkdxT9blJCniIkKwyoqUP8g1fzpqCzE7ncXI+syFnxH+i8PTcOfxPT+ohG6dQeZPiEt5DD3fzFS5x39eo8eSB2JCbRKUXttAl2KSWzoq8bwQWK6whByZ8SHaLFERQLG8pHvdRNYYtZPXlHuCKiKf/DM/O6zr/E6X4ntwT3MV7p2qHD2N+PkeCeAwdb0F7oPoMWqwwiRWl7R/aEipsH2JC9wiqzR5m66FDp1PxRM42A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d99673d-113d-4022-5aad-08df08bb48e4
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8695.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 06:27:38.9250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9WxM+8/N1Lf1Mh9P3jyVSBgA0zQGfmSGtns/hW1oMPIYKZwMcajCbxy74T/cdS0iV9ur0uutRFDclE1yAsbNyfSD9LLV7sKVCzrsloAd65g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8844
X-OriginatorOrg: intel.com


On 01-Sep-26 3:02 PM, Shameer Kolothum wrote:
> Hold recovery_lock for reading across each config space operation, so
> recovery can shut out new ones and wait for whatever is already running.
> The user copies stay outside the lock, since a copy can fault.
>
> Take the lock in the dispatcher rather than around the individual
> hardware accessors. That means once recovery blocks access every config
> read fails with -EIO, even a read served entirely from vconfig which
> never touches the device. Userspace which wants to know what is going on
> reads the device feature instead. That one stays available during an
> event.
>
> The PCIe and AF capability writes no longer reset the device themselves,
> and the power management write no longer moves it to D0 itself. They
> record what was asked for and the dispatcher does it after dropping
> recovery_lock. Both take pci_bus_sem, which AER already holds when it
> calls into the driver, so doing either inside the lock would be the wrong
> order. A reset method reaches it directly, and a D0 transition reaches it
> through pci_set_full_power_state() calling
> pcie_aspm_pm_state_change(). The lower power states take neither, so
> those still run in the writefn. The writefn declaration says so.
>
> Both stay best effort, as the guest requested FLR always was. The result
> is not reported back through the config write. With recovery enabled they
> are dropped while a recovery or reset is already in flight, since that
> leaves the device in D0 and reset anyway. The reset helper tests the
> recovery state for itself. The power up does not, so the dispatcher
> tests it before that one.
>
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>   drivers/vfio/pci/vfio_pci_config.c | 147 ++++++++++++++++++++---------
>   1 file changed, 102 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> index 9914f3ac69ae..3365100acf21 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -99,6 +99,12 @@ static const u16 pci_ext_cap_length[PCI_EXT_CAP_ID_MAX + 1] = {
>   	[PCI_EXT_CAP_ID_DVSEC]	=	0xFF,
>   };
>   
> +/* What a config write asked for which has to wait for the access guard. */
> +struct vfio_pci_config_deferred {
> +	bool	flr;		/* a function-level reset */
> +	bool	power_up;	/* a transition to D0 */
> +};
> +
>   /*
>    * Read/Write Permission Bits - one bit for each bit in capability
>    * Any field can be read if it exists, but what is read depends on
> @@ -111,8 +117,17 @@ struct perm_bits {
>   	u8	*write;		/* writeable bits */
>   	int	(*readfn)(struct vfio_pci_core_device *vdev, int pos, int count,
>   			  struct perm_bits *perm, int offset, __le32 *val);
> +	/*
> +	 * @deferred records work the write asked for which a writefn must not
> +	 * do itself. Both a reset method and a transition to D0 acquire
> +	 * pci_bus_sem, which AER already holds when it enters the driver, so
> +	 * doing either here would invert the lock order against recovery_lock.
> +	 * The dispatcher does them after dropping recovery_lock. Callers zero
> +	 * it, and a writefn only sets a field on a success return.
> +	 */
>   	int	(*writefn)(struct vfio_pci_core_device *vdev, int pos, int count,
> -			   struct perm_bits *perm, int offset, __le32 val);
> +			   struct perm_bits *perm, int offset, __le32 val,
> +			   struct vfio_pci_config_deferred *deferred);
>   };
>   
>   #define	NO_VIRT		0
> @@ -200,7 +215,8 @@ static int vfio_default_config_read(struct vfio_pci_core_device *vdev, int pos,
>   
>   static int vfio_default_config_write(struct vfio_pci_core_device *vdev, int pos,
>   				     int count, struct perm_bits *perm,
> -				     int offset, __le32 val)
> +				     int offset, __le32 val,
> +				     struct vfio_pci_config_deferred *deferred)
>   {
>   	__le32 virt = 0, write = 0;
>   
> @@ -272,7 +288,8 @@ static int vfio_direct_config_read(struct vfio_pci_core_device *vdev, int pos,
>   /* Raw access skips any kind of virtualization */
>   static int vfio_raw_config_write(struct vfio_pci_core_device *vdev, int pos,
>   				 int count, struct perm_bits *perm,
> -				 int offset, __le32 val)
> +				 int offset, __le32 val,
> +				 struct vfio_pci_config_deferred *deferred)
>   {
>   	int ret;
>   
> @@ -299,7 +316,8 @@ static int vfio_raw_config_read(struct vfio_pci_core_device *vdev, int pos,
>   /* Virt access uses only virtualization */
>   static int vfio_virt_config_write(struct vfio_pci_core_device *vdev, int pos,
>   				  int count, struct perm_bits *perm,
> -				  int offset, __le32 val)
> +				  int offset, __le32 val,
> +				  struct vfio_pci_config_deferred *deferred)
>   {
>   	memcpy(vdev->vconfig + pos, &val, count);
>   	return count;
> @@ -563,7 +581,8 @@ static bool vfio_need_bar_restore(struct vfio_pci_core_device *vdev)
>   
>   static int vfio_basic_config_write(struct vfio_pci_core_device *vdev, int pos,
>   				   int count, struct perm_bits *perm,
> -				   int offset, __le32 val)
> +				   int offset, __le32 val,
> +				   struct vfio_pci_config_deferred *deferred)
>   {
>   	struct pci_dev *pdev = vdev->pdev;
>   	__le16 *virt_cmd;
> @@ -613,7 +632,8 @@ static int vfio_basic_config_write(struct vfio_pci_core_device *vdev, int pos,
>   			vfio_bar_restore(vdev);
>   	}
>   
> -	count = vfio_default_config_write(vdev, pos, count, perm, offset, val);
> +	count = vfio_default_config_write(vdev, pos, count, perm, offset, val,
> +					  deferred);
>   	if (count < 0) {
>   		if (offset == PCI_COMMAND)
>   			up_write(&vdev->memory_lock);
> @@ -727,9 +747,11 @@ static void vfio_lock_and_set_power_state(struct vfio_pci_core_device *vdev,
>   
>   static int vfio_pm_config_write(struct vfio_pci_core_device *vdev, int pos,
>   				int count, struct perm_bits *perm,
> -				int offset, __le32 val)
> +				int offset, __le32 val,
> +				struct vfio_pci_config_deferred *deferred)
>   {
> -	count = vfio_default_config_write(vdev, pos, count, perm, offset, val);
> +	count = vfio_default_config_write(vdev, pos, count, perm, offset, val,
> +					  deferred);
>   	if (count < 0)
>   		return count;
>   
> @@ -738,8 +760,15 @@ static int vfio_pm_config_write(struct vfio_pci_core_device *vdev, int pos,
>   
>   		switch (le32_to_cpu(val) & PCI_PM_CTRL_STATE_MASK) {
>   		case 0:
> -			state = PCI_D0;
> -			break;
> +			/*
> +			 * Going to D0 reaches pci_set_full_power_state(),
> +			 * which takes pci_bus_sem through
> +			 * pcie_aspm_pm_state_change(). Leave it to the
> +			 * dispatcher. The lower states do not, so they run
> +			 * here.
> +			 */
> +			deferred->power_up = true;
> +			return count;
>   		case 1:
>   			state = PCI_D1;
>   			break;
> @@ -799,7 +828,8 @@ static int __init init_pci_cap_pm_perm(struct perm_bits *perm)
>   
>   static int vfio_vpd_config_write(struct vfio_pci_core_device *vdev, int pos,
>   				 int count, struct perm_bits *perm,
> -				 int offset, __le32 val)
> +				 int offset, __le32 val,
> +				 struct vfio_pci_config_deferred *deferred)
>   {
>   	struct pci_dev *pdev = vdev->pdev;
>   	__le16 *paddr = (__le16 *)(vdev->vconfig + pos - offset + PCI_VPD_ADDR);
> @@ -812,7 +842,8 @@ static int vfio_vpd_config_write(struct vfio_pci_core_device *vdev, int pos,
>   	 * of PCI_VPD_ADDR, then the PCI_VPD_ADDR_F bit is written and we
>   	 * have work to do.
>   	 */
> -	count = vfio_default_config_write(vdev, pos, count, perm, offset, val);
> +	count = vfio_default_config_write(vdev, pos, count, perm, offset, val,
> +					  deferred);
>   	if (count < 0 || offset > PCI_VPD_ADDR + 1 ||
>   	    offset + count <= PCI_VPD_ADDR + 1)
>   		return count;
> @@ -881,21 +912,24 @@ static int __init init_pci_cap_pcix_perm(struct perm_bits *perm)
>   
>   static int vfio_exp_config_write(struct vfio_pci_core_device *vdev, int pos,
>   				 int count, struct perm_bits *perm,
> -				 int offset, __le32 val)
> +				 int offset, __le32 val,
> +				 struct vfio_pci_config_deferred *deferred)
>   {
>   	__le16 *ctrl = (__le16 *)(vdev->vconfig + pos -
>   				  offset + PCI_EXP_DEVCTL);
>   	int readrq = le16_to_cpu(*ctrl) & PCI_EXP_DEVCTL_READRQ;
>   
> -	count = vfio_default_config_write(vdev, pos, count, perm, offset, val);
> +	count = vfio_default_config_write(vdev, pos, count, perm, offset, val,
> +					  deferred);
>   	if (count < 0)
>   		return count;
>   
>   	/*
>   	 * The FLR bit is virtualized, if set and the device supports PCIe
> -	 * FLR, issue a reset_function.  Regardless, clear the bit, the spec
> -	 * requires it to be always read as zero.  NB, reset_function might
> -	 * not use a PCIe FLR, we don't have that level of granularity.
> +	 * FLR, request a function reset once recovery_lock has been
> +	 * released. Regardless, clear the bit, the spec requires it to be
> +	 * always read as zero. NB, reset_function might not use a PCIe FLR,
> +	 * we don't have that level of granularity.
>   	 */
>   	if (*ctrl & cpu_to_le16(PCI_EXP_DEVCTL_BCR_FLR)) {
>   		u32 cap;
> @@ -907,14 +941,8 @@ static int vfio_exp_config_write(struct vfio_pci_core_device *vdev, int pos,
>   						 pos - offset + PCI_EXP_DEVCAP,
>   						 &cap);
>   
> -		if (!ret && (cap & PCI_EXP_DEVCAP_FLR)) {
> -			vfio_pci_zap_and_down_write_memory_lock(vdev);
> -			vfio_pci_dma_buf_move(vdev, true);
> -			pci_try_reset_function(vdev->pdev);
> -			if (__vfio_pci_memory_enabled(vdev))
> -				vfio_pci_dma_buf_move(vdev, false);
> -			up_write(&vdev->memory_lock);
> -		}
> +		if (!ret && (cap & PCI_EXP_DEVCAP_FLR))
> +			deferred->flr = true;
>   	}
>   
>   	/*
> @@ -968,19 +996,22 @@ static int __init init_pci_cap_exp_perm(struct perm_bits *perm)
>   
>   static int vfio_af_config_write(struct vfio_pci_core_device *vdev, int pos,
>   				int count, struct perm_bits *perm,
> -				int offset, __le32 val)
> +				int offset, __le32 val,
> +				struct vfio_pci_config_deferred *deferred)
>   {
>   	u8 *ctrl = vdev->vconfig + pos - offset + PCI_AF_CTRL;
>   
> -	count = vfio_default_config_write(vdev, pos, count, perm, offset, val);
> +	count = vfio_default_config_write(vdev, pos, count, perm, offset, val,
> +					  deferred);
>   	if (count < 0)
>   		return count;
>   
>   	/*
>   	 * The FLR bit is virtualized, if set and the device supports AF
> -	 * FLR, issue a reset_function.  Regardless, clear the bit, the spec
> -	 * requires it to be always read as zero.  NB, reset_function might
> -	 * not use an AF FLR, we don't have that level of granularity.
> +	 * FLR, request a function reset once recovery_lock has been
> +	 * released. Regardless, clear the bit, the spec requires it to be
> +	 * always read as zero. NB, reset_function might not use an AF FLR,
> +	 * we don't have that level of granularity.
>   	 */
>   	if (*ctrl & PCI_AF_CTRL_FLR) {
>   		u8 cap;
> @@ -992,14 +1023,8 @@ static int vfio_af_config_write(struct vfio_pci_core_device *vdev, int pos,
>   						pos - offset + PCI_AF_CAP,
>   						&cap);
>   
> -		if (!ret && (cap & PCI_AF_CAP_FLR) && (cap & PCI_AF_CAP_TP)) {
> -			vfio_pci_zap_and_down_write_memory_lock(vdev);
> -			vfio_pci_dma_buf_move(vdev, true);
> -			pci_try_reset_function(vdev->pdev);
> -			if (__vfio_pci_memory_enabled(vdev))
> -				vfio_pci_dma_buf_move(vdev, false);
> -			up_write(&vdev->memory_lock);
> -		}
> +		if (!ret && (cap & PCI_AF_CAP_FLR) && (cap & PCI_AF_CAP_TP))
> +			deferred->flr = true;
>   	}
>   
>   	return count;
> @@ -1168,9 +1193,11 @@ static int vfio_msi_config_read(struct vfio_pci_core_device *vdev, int pos,
>   
>   static int vfio_msi_config_write(struct vfio_pci_core_device *vdev, int pos,
>   				 int count, struct perm_bits *perm,
> -				 int offset, __le32 val)
> +				 int offset, __le32 val,
> +				 struct vfio_pci_config_deferred *deferred)
>   {
> -	count = vfio_default_config_write(vdev, pos, count, perm, offset, val);
> +	count = vfio_default_config_write(vdev, pos, count, perm, offset, val,
> +					  deferred);
>   	if (count < 0)
>   		return count;
>   
> @@ -1889,6 +1916,8 @@ ssize_t vfio_pci_config_rw_single(struct vfio_pci_core_device *vdev,
>   	struct perm_bits *perm;
>   	__le32 val = 0;
>   	int cap_start = 0, offset;
> +	int access_ret;
> +	struct vfio_pci_config_deferred deferred = {};
>   	u8 cap_id;
>   	ssize_t ret;
>   
> @@ -1957,14 +1986,42 @@ ssize_t vfio_pci_config_rw_single(struct vfio_pci_core_device *vdev,
>   		if (copy_from_user(&val, buf, count))
>   			return -EFAULT;
>   
> -		ret = perm->writefn(vdev, *ppos, count, perm, offset, val);
> +		access_ret = vfio_pci_core_access_begin(vdev);
> +		if (access_ret)
> +			return access_ret;
> +		ret = perm->writefn(vdev, *ppos, count, perm, offset, val,
> +				    &deferred);
> +		vfio_pci_core_access_end(vdev);
> +		if (ret < 0)
> +			return ret;
> +		/*
> +		 * Both of these take pci_bus_sem, so run them with the access
> +		 * guard dropped. The reset re-checks the recovery state for
> +		 * itself. The power up does not, so check it here.
> +		 *
> +		 * Both are best effort, as the guest-requested FLR has always
> +		 * been. The result is not reported back through the config
> +		 * write. Without recovery enabled the only failure is -EAGAIN
> +		 * from device lock contention, exactly as before. With it they
> +		 * are dropped while a recovery or reset transaction is in
> +		 * flight, which leaves the device in D0 and reset anyway.
> +		 */
> +		if (deferred.power_up &&
> +		    !(vdev->pci_recovery_supported &&
> +		      READ_ONCE(vdev->pci_recovery_access_blocked)))
> +			vfio_lock_and_set_power_state(vdev, PCI_D0);
> +		if (deferred.flr)
> +			vfio_pci_try_reset_function(vdev, false);
>   	} else {
> -		if (perm->readfn) {
> +		access_ret = vfio_pci_core_access_begin(vdev);
> +		if (access_ret)
> +			return access_ret;
> +		if (perm->readfn)
>   			ret = perm->readfn(vdev, *ppos, count,
>   					   perm, offset, &val);
> -			if (ret < 0)
> -				return ret;
> -		}
> +		vfio_pci_core_access_end(vdev);
> +		if (ret < 0)
> +			return ret;

The else {} is all about perm->readfn. Can we move 
vfio_pci_core_access_begin() and end() inside the if (perm->readfn) ?

We do not need to bring if (ret < 0) out of if(perm->readfn) in that case.

- Satya.

>   
>   		if (copy_to_user(buf, &val, count))
>   			return -EFAULT;
