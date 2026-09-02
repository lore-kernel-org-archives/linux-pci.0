Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9A9249EB;
	Wed,  2 Sep 2026 06:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788329199; cv=fail; b=RqOAz+Ri4+m447XwxO4wSAt0E+3b8uMV1ARhJ13v5jd4Xu4x8bd80hnELf/SC2pJEGP+L6r1RsPzN8QcOc5a61J2kaYll46d1U1AYYNmM+T2onHINtC0awgxhdlZQj7mRkQmOpCEffBM+x8pwtRwpc2VtigYxe65j+WIaJIBKLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788329199; c=relaxed/simple;
	bh=eWcLjMrGMUWevEBIikMjzdQPy/vCas+DfA/X/JM7g+Q=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jdT1m7LDKv+tzA9KFEjHVfpJ1ZZU+vgqzqql7dQU2xWsTpXJV4NYOlVWMzlra2hKAHtxc2dTEtG/VKcx1rRiPp6BC2aKQgOYf1EWEKs0RmLsu049pIUBakDk58hzgJvI8qtoLXYTMBUR3fcxGTJBlNRTFdpIt51/yRIxRUNKV1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gR/AYKAB; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gR/AYKAB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788329197; x=1819865197;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eWcLjMrGMUWevEBIikMjzdQPy/vCas+DfA/X/JM7g+Q=;
  b=gR/AYKABQhLx1H0B5TQJqsp/X35P9wdv14mltwjRxc7MFh3XE+SM9BHp
   Elw3cIgcENfEl3qV+QHNOWyNGf2Qzh/nEjPO+378l/0Tqy55mFOTsVmzD
   U9TPI73VEOwiza/99tC/NxgMD+YRdDzos7YgSvreDggSIY4Wq/zcoTxtT
   GFc6aqtcdrn6V6cfjnzWBZv78xPhPrEAbvAbHwj4nCkQ5UNvmHo4NzIio
   9LdgmYihy8rvg7WzCjK5JjVOCDOw78BCtfzdXpg/eAx4ZA/0Hcr4Pkm5y
   xSf3/G10/O73n/KiyQ8JfQWjrBiQPfXME9gVD8+HHIqoyIDCilE65h0bz
   Q==;
X-CSE-ConnectionGUID: Bocm5IWgTCSAOVZPQSUtNw==
X-CSE-MsgGUID: TRnuEPLmTWu8xzVVRDrHUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="106144985"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="106144985"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 23:06:37 -0700
X-CSE-ConnectionGUID: Pw4ff2IoSICq+QEHhmW6dQ==
X-CSE-MsgGUID: dojb0Wv/RdyCLQOUdcT7zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="268770342"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 23:06:36 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 23:06:35 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 1 Sep 2026 23:06:35 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.49) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 23:06:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bVDu9DrHgpgz0dj+4LQrr/7rAG4JPkQ/DaBhEb4FnRrP/x2xpWo3+vzsD4MGjOKKE4i14v/c5AExXPN6jemgy+khUCfYpbfhYvfHUusvxFdDCnJFUFzBsaygbhywtCDzm97OdLTSWS0KMzAtLS/gllR4bl92409tYJUebYON0N7HYBUuvb9w26Jgw6KQOlvEK87JjQVCzDig8gOJx81mc2Aza/foHfMyUZtxlwA6ZulNNhx9CMkWk9Kbhwe8XIc3TK53xEtg25p0Ieo07jI3LxMzYnQW/AmlIUXgMCbiJ44iSy756nqmPiNVkDmha8yBxWAw2i/01M4BVfpYwoGl9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7hbCvq2CMXFEbUwPizRZkrIN4e/liijAoPdiDpWScQ=;
 b=nLdVHmw+P7HHHeWBgGvijLr1tvqA2RiR4OTCwbvFhUPYgMm3ciYGOQpIBmhDieO8hPayQN1ciXF438Aie4za4nVhMjafoiCwYrDa+gMcfTvcVNbamgGuAWIvxSk/pN8oy5GIWxFvm9OvrzQSfimEb7SRmsPldt0qKM8Lozza8J57pndE4+AcdM04qjTJpnzrtRblEqKHFjLoFynSpNgOUp3YEbPABCzEu9gvR+y4NsW1AKHlFzmQTgCPNE2YOapi2dP/u+GTQxYJALA3KVh73xbrJ6d4/hVRywW/3QY9eRALjtjnYEk9fGoaa2AQ/opFaD+gndDJUgiTdKMbMMk9qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8695.namprd11.prod.outlook.com (2603:10b6:408:211::15)
 by SAWPR11MB9710.namprd11.prod.outlook.com (2603:10b6:806:4c8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 06:06:32 +0000
Received: from LV3PR11MB8695.namprd11.prod.outlook.com
 ([fe80::ccc3:3fd6:58f5:927]) by LV3PR11MB8695.namprd11.prod.outlook.com
 ([fe80::ccc3:3fd6:58f5:927%6]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 06:06:32 +0000
Message-ID: <3ceaf230-c06e-479e-80c5-8517dbc1710a@intel.com>
Date: Wed, 2 Sep 2026 11:36:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 04/19] vfio/pci: Serialize function reset with
 recovery
To: Shameer Kolothum <skolothumtho@nvidia.com>, <kvm@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>, <sonangp@nvidia.com>,
	<nathanc@nvidia.com>, <mochs@nvidia.com>
References: <20260901093217.8539-1-skolothumtho@nvidia.com>
 <20260901093217.8539-5-skolothumtho@nvidia.com>
Content-Language: en-US
From: "K V P, Satyanarayana" <satyanarayana.k.v.p@intel.com>
In-Reply-To: <20260901093217.8539-5-skolothumtho@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0227.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::14) To LV3PR11MB8695.namprd11.prod.outlook.com
 (2603:10b6:408:211::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8695:EE_|SAWPR11MB9710:EE_
X-MS-Office365-Filtering-Correlation-Id: 61aff3cf-2edb-446a-5a7c-08df08b855e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|6133799003|11063799006|10067099003|4143699003|56012099006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0QhyiAmWKV7xMR+Kd9KhBxSxESt4f7vtWS5tc0A43UA3Rwvzi7zxXaaMcognTQbtTWd/xIqEwhbboNXzfoN2RZ5BsCeD9WA8rjfWvge1vQgleF+RWg7He+5aGUbZGjaHKna7495qtO9HaYtzyXPostpTDQatTKDihBP/NYBMm5wOt9mR0cRfUzAdFjb1N3EWHY4P9048LMApG6jJ0XxfWGSt7qhoezyvN59Rjs51zvldRwGiMvgVuFWAVcV1cZAZofb4VEqoyr2Bnh0VwbnxZYIcBecEEnIZxX0v7oHHLpv9En3+0RJgIDGKq9zyrNIrppY1Y+48wYZ1g0M6iShroz1PsicXtax7lEE8XL4fvII/ikxm3A3F4T+6+LAkaABvnvcTViyJHRdnTcXDZFmOIyFwZucaKqDmKAgxCF5BjPjREk/mB51C/zX0p+avLkycNsyiXvaO4Z1oWZHUveA8fnrDEPVJLI0howK3VyyPnJydfxFfhlwXpxgu9076njEganpvvt7vI8rbOfGWrF9IB4B0hKL+umtLhYKhvQsgWBWqXTleqg8jZMMApJfWsqyWksM5v6UNcbIt8Pjv98PGEQ1KNpZInU4RDnVI46IcJGzlHBFhZn1klUodZq8HKa8y9NAWe4A6idmb0t/vUjTskZMhD/tSyeIqwl0i7ya8lrs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8695.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(6133799003)(11063799006)(10067099003)(4143699003)(56012099006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djBlVHVXMDVPRC9CTndxNnVSalBUZG9FY25NT3ZDVDlNZWg1MUZwK254QVVm?=
 =?utf-8?B?aGxicE9wbXh2WmloTUVWY0ZLTkorUlVUcU54eFhacEJyYXhjNVJZcHE2elZn?=
 =?utf-8?B?RXZvcGJwWFRrVE5TYk1BRk9xMDVLMkpFdWtkY2FJa0k1TWozdTZodHBKV2xY?=
 =?utf-8?B?aUMwejVvb0NFR1FuL1pHbTlrWjRVd2RJay96ZFZLQjIrK0V0ZG0zMHZYekVJ?=
 =?utf-8?B?MmQ2c0FVL3hvOTRWSDZrTmNiTUlEN0dUYU8yc3JLdytCcDZ0YXl3Z3Z1R3Q4?=
 =?utf-8?B?YklZOUh2dWVaUXF3SnpCNDBzUHBnbUw0NFduK1NWNCt6Ujl3TVM1ZTNSbVBF?=
 =?utf-8?B?bStCODZjUHpOUklJTVVzbVNTS1dVajR2M0h3VWVTYllncGNjWWRjTnkrT2dl?=
 =?utf-8?B?d0hwTUtxS0twa09Na0FnSEFFemg5a21nbklPZFJ3MnRGdWRJbzU3RFJEOXpU?=
 =?utf-8?B?aHVNa3poRmV6d2Zza3pOV1k3ZUxZbVlYcnNJWVdtUmh1QzR1Rmovc04wbU5B?=
 =?utf-8?B?N1E3SGcyY3Z1RWp3NUpIalprMEZ0VUJhdXVkU0NEaVh5aXk2Sk9jUVlkRVhE?=
 =?utf-8?B?aG90SDc1RENWQmRrWlAwc2NmTDIwT3VWdC9RWTBkdTRzZWtOZXRtN2xMZnIx?=
 =?utf-8?B?QStIczB3UkVsWDd4QmNUclJyNnk5N1k2LzM2UnU4ZTNQUjNDMm1yTHBsazMx?=
 =?utf-8?B?dG1oUXFWbUR6U0dLbGRCWEt2S01uYkI0bU9zY3o1WUQ1WSs2NXFORjVudmhK?=
 =?utf-8?B?dWFXMWJZblBFbnNiWEpSdkVkS05uU3ljRm9aajJOTDBzMkNtMHlpcHRmN1RH?=
 =?utf-8?B?SWl0UEk5RHQ3dmYyNXZGdWJKcUIwZFRCa04zNVNMM09vYXNjemJxTlk3bGdj?=
 =?utf-8?B?MC9HL1I4RmlCSUNVRnIva3c2R1hhM3ZuS0c4NGg3YUVVZ08wallLMFZFUWtG?=
 =?utf-8?B?UG8xTStqMmlkeFpMWlRiQ0tGOW54ZWJFcGd4ZnQwZk9ENlFZTGN1UTB3dFRC?=
 =?utf-8?B?MzRwMDRVSjZHd29jTzZaU2hRY05QT0RoT2pZME1lbXkrUlRHQmgrbkIvYTlM?=
 =?utf-8?B?OUgyRTlGVEZnaGhZV2RIL1k3UTdMTTlQYU5nZ2VNZDhIUFg5Rmw3N1ZsRU1H?=
 =?utf-8?B?Rlc1R21HUDJua1E4N0xDWnpZdjBnT3VFakVIYmF5azdTM0ZBRlVpdy9DdlFy?=
 =?utf-8?B?c1lIRERkK1VZTlM2c0JNb04wb2g2Ky9aN3R0R085RzJwL1FzK280Yk9mZXZY?=
 =?utf-8?B?dktqMDU2SDdJQis2L3NhTkUyYk1YN2IwUDFtdmdPTFJNNDBrczRBaEJRMlE3?=
 =?utf-8?B?Q2dWNi83YnZmTXVxYktFZjdQMWdKMG02VThZL05EOHVBTjZpbU9KbjY0STVr?=
 =?utf-8?B?cTZld2YxUjhoOXlITWw3VC9mTVFEbWFTbkRrRDJRZUhYT3RHRHZLK1pzY0lL?=
 =?utf-8?B?cHJnTzhQemh3L2NUMlJrVDUvOHVFdUF1cmdheTFSTTRGSUxGYSsxQWVYUXp1?=
 =?utf-8?B?VlNQYW96RTFxWk00RGc2RGc0ZHJzSkR0L2Z2dzlsRCtDaCtBWWhjdUZMTEoy?=
 =?utf-8?B?ekRNcW9hY3V5bjFqNFF5dGtaUmhOWFlzY0lXQXBUNUVOeDFWVGZtaUpYMzlG?=
 =?utf-8?B?a01UdnhxYzZ1SWh5NHhEdUllaG1vQXZJVU1kOE1CWXVQeUtUUDZvQVZ2Q2xk?=
 =?utf-8?B?SUZjVG5NU09Vc1dtS3N3ZEhjNGhueXZxVXZpRCtKWThTa2w2Qkt6aEVqOHlM?=
 =?utf-8?B?VUZzMnd4elljTkxQd28rUlJ0OXRURk5VZlgzTFhrNUxrdGVlaE5LU0xLMG5V?=
 =?utf-8?B?L1I1WlhHS3VPNWhlb3VqMi8rTC83cjlxK2gvUEpMN3krd3BIcTdlVDVzWG5I?=
 =?utf-8?B?T3VPeVV6Skl6cWtoNXNCVkh4ZUpIQUR4dWRFRGFVR1N5SG5rSVgzMTlRWnRw?=
 =?utf-8?B?eENrU1ZWaTB1bnY2d2NIUkVRaVR1RGdzZFpGQ21Ddk04YnRxS2gxdTgzM1Zm?=
 =?utf-8?B?eUFCdzF1WFc5NzlyeHYrR1VSdUg2emErbGVqeDZzcExpZUV2OHQ4cllhTWFI?=
 =?utf-8?B?T1BWMUdsd2hIbldoN3Y0TmZ2U2t0TENEd1FPelBSWjdCL1hzdE9oQmNrWUY0?=
 =?utf-8?B?Sm1PNHAzSWwzY3pwMXF3c2cyby9iUGFWODVlQTVlM08wMG5xOVdEYXlUcmRR?=
 =?utf-8?B?RytHNlJFY1NZUHZuZGJaVVlzRkVSYWlmRm9FbkpmSnBSdGFoOGFyTU1NRnVz?=
 =?utf-8?B?NTI0VDV5WmxrS21hWjloVFd2SEMyTjdqdFgwQ1R4SE5BU2g5V2NHRVlIMk83?=
 =?utf-8?B?a3IzOTl3UWlRVGJzRk4zTmROa1RVU2s0QVYzNDVDMDBWOW56Qit0NHQ5endW?=
 =?utf-8?Q?+PP7ZhA0FfeF/M4E=3D?=
X-Exchange-RoutingPolicyChecked: zDiksPNEYsbD/BFpFj1boFNvpj/eBvBM6gZcBA+T6eD6ZYSxX1wDqaXDuFCWhkQHUIq11Z4y3TmMEXkVLS7I2FoKlE/ZCx1uHR2tDqqfb3MlHiYOHgERqFM5OK9Mh48pB6nuSphBv0sqow/LA4LmjoiJbB+jPW/8cDZzzW6isHCIGch1yemAIfxxgNa6nn5KWVD3K4B/WHHhOO6M41ND2dCjbcQbvVsHFIlEd6NwPP3gk/Sf1ax0SccPFVYYDVFdW9ie4d2Y2ee96JFut0mJDFo8MPGFTDikz6y0tnRLbM4RzjbL9EG5Jgegh6a7veEDCRVXxteRhmPDD2xp9l65kA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 61aff3cf-2edb-446a-5a7c-08df08b855e7
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8695.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 06:06:32.2263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k39qX8JmMRL0jvYF6GqaIYbIolBMmCYKlea03gGiDyAK1JeAMG1gozt6eL2N0LJxlkhmXktjWNOnAd8zzCQgNCy3gDx8sVleqO6cF09RdtU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9710
X-OriginatorOrg: intel.com


On 01-Sep-26 3:02 PM, Shameer Kolothum wrote:
> Add a function reset helper and use it for VFIO_DEVICE_RESET. A later
> patch routes the guest triggered config space FLR through it as well.
> That path never did the power state transition, so make it optional.
>
> With recovery enabled, take recovery_lock for writing, refuse the reset
> with -EBUSY if access is already blocked, otherwise block access and drop
> the lock again before revoking mappings or running the reset.
> recovery_lock cannot be held across the reset because a reset method can
> take pci_bus_sem, and the PCI error callbacks take recovery_lock from
> under it.
>
> Dropping it is safe in both directions. The error callbacks hold
> recovery_lock for their whole body, so one already running has finished
> before the reset starts. One which arrives while the lock is down runs
> its own event, and the PCI core calls it with the device lock held, which
> pci_try_reset_function() also takes, so it cannot overlap the reset
> itself.
>
> Only unblock access at the end for a reset which is still the one
> blocking it. An event which started meanwhile owns the state from then
> on, and resume() is what ends it.
>
> With recovery not enabled, leave access_blocked alone. Two concurrent
> resets still serialize on memory_lock, same as today. Setting the flag
> for a device which never opted in would turn a working VFIO_DEVICE_RESET
> into -EBUSY.
>
> Access stays blocked until the reset is done and memory state is back,
> and the wait queue is woken once it clears. A later patch adds the BAR
> fault path, which waits there rather than failing the fault while a
> reset is in flight.
>
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>   drivers/vfio/pci/vfio_pci_priv.h |  3 ++
>   drivers/vfio/pci/vfio_pci_core.c | 85 +++++++++++++++++++++++++++++---
>   2 files changed, 82 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
> index 6daf51669d05..8a7f9fe22386 100644
> --- a/drivers/vfio/pci/vfio_pci_priv.h
> +++ b/drivers/vfio/pci/vfio_pci_priv.h
> @@ -41,6 +41,9 @@ ssize_t vfio_pci_config_rw_single(struct vfio_pci_core_device *vdev,
>   				  char __user *buf, size_t count, loff_t *ppos,
>   				  bool iswrite);
>   
> +int vfio_pci_try_reset_function(struct vfio_pci_core_device *vdev,
> +				bool reset_power_state);
> +
>   ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
>   			size_t count, loff_t *ppos, bool iswrite);
>   
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 4194d44d6530..3645daa8891f 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1379,14 +1379,53 @@ static int vfio_pci_ioctl_set_irqs(struct vfio_pci_core_device *vdev,
>   	return ret;
>   }
>   
> -static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
> -				void __user *arg)
> +int vfio_pci_try_reset_function(struct vfio_pci_core_device *vdev,
> +				bool reset_power_state)
>   {
> +	struct pci_dev *pdev = vdev->pdev;
> +	bool enabled = false;
> +	bool supported = vdev->pci_recovery_supported;

Can we use a helper function to get pci recovery is supported or not?

Maintainability will be easy with helper function than direct assignment.

-Satya.

>   	int ret;
>   
> -	if (!vdev->reset_works)
> -		return -EINVAL;
> +	/*
> +	 * Claim the device against recovery before resetting it. The PCI
> +	 * error callbacks hold recovery_lock for their whole body, so taking
> +	 * it for writing here waits for one already running, and
> +	 * access_blocked keeps a later one away while the lock is dropped.
> +	 */
> +	if (supported) {
> +		down_write(&vdev->recovery_lock);
> +		if (!vdev->pci_recovery_device_open) {
> +			ret = -ENODEV;
> +			goto out_recovery;
> +		}
>   
> +		enabled = vdev->pci_recovery_enabled;
> +
> +		/*
> +		 * Only claim access_blocked when recovery is enabled.
> +		 * error_detected() returns early for a device which has not
> +		 * enabled it, so there is nothing to exclude, and claiming it
> +		 * anyway would fail the second of two concurrent
> +		 * VFIO_DEVICE_RESET calls with -EBUSY.
> +		 */
> +		if (enabled) {
> +			if (vdev->pci_recovery_access_blocked) {
> +				ret = -EBUSY;
> +				goto out_recovery;
> +			}
> +			WRITE_ONCE(vdev->pci_recovery_access_blocked, true);
> +		}
> +		up_write(&vdev->recovery_lock);
> +	}
> +
> +	/*
> +	 * On a device which supports recovery, taking recovery_lock for
> +	 * writing above waited for anything already past its access check,
> +	 * and if recovery is enabled access_blocked keeps new ones out. Do
> +	 * not hold recovery_lock while taking memory_lock or running a reset
> +	 * method, since a reset can take pci_bus_sem.
> +	 */
>   	vfio_pci_zap_and_down_write_memory_lock(vdev);
>   
>   	/*
> @@ -1398,15 +1437,49 @@ static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
>   	 * reset without restoring the original state (saved locally in
>   	 * 'vdev->pm_save').
>   	 */
> -	vfio_pci_set_power_state(vdev, PCI_D0);
> +	if (reset_power_state)
> +		vfio_pci_set_power_state(vdev, PCI_D0);
>   
>   	vfio_pci_dma_buf_move(vdev, true);
> -	ret = pci_try_reset_function(vdev->pdev);
> +	ret = pci_try_reset_function(pdev);
>   	if (__vfio_pci_memory_enabled(vdev))
>   		vfio_pci_dma_buf_move(vdev, false);
>   	up_write(&vdev->memory_lock);
>   
> +	if (enabled) {
> +		down_write(&vdev->recovery_lock);
> +		/*
> +		 * An error callback can have started an event while the lock
> +		 * was down. Leave the state to it. Only unblock access for a
> +		 * reset which is still the one holding it.
> +		 */
> +		if (vdev->pci_recovery_device_open &&
> +		    !(vdev->pci_recovery_flags & (VFIO_PCI_RECOVERY_IN_PROGRESS |
> +						  VFIO_PCI_RECOVERY_FAILED)))
> +			WRITE_ONCE(vdev->pci_recovery_access_blocked, false);
> +		up_write(&vdev->recovery_lock);
> +		/*
> +		 * Access is blocked for the length of the reset, so anything
> +		 * waiting for it to clear has to be woken here. A later patch
> +		 * adds the BAR fault path which waits on this.
> +		 */
> +		wake_up_all(&vdev->pci_recovery_wait);
> +	}
> +
>   	return ret;
> +
> +out_recovery:
> +	up_write(&vdev->recovery_lock);
> +	return ret;
> +}
> +
> +static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
> +				void __user *arg)
> +{
> +	if (!vdev->reset_works)
> +		return -EINVAL;
> +
> +	return vfio_pci_try_reset_function(vdev, true);
>   }
>   
>   static int vfio_pci_ioctl_get_pci_hot_reset_info(
