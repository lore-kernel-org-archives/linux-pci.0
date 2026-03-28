Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35535175A9D;
	Sat, 28 Mar 2026 00:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774657721; cv=fail; b=O6wwb+AqoYMTOgl+uYv1r1qoZUkslvqUeVtmZYShN4/xxB5YR3vK6ZZUwPa/XUKNsnNOGxh2mIg+w/URaeh/iY8JHoWz/N0G+HBbFo4DY/8GUuBGfmFEOcPJK38CqQ8OYoJAsBSlWKsRl16GZYVN7u6zTNioJ5SqoN97oxHUXE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774657721; c=relaxed/simple;
	bh=amBBWBNDotHgFdobIqJC1q9S63trJacecAl/Tdujw/Y=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=Rx553VXG/9sN+lGy0T4zHeQ+B0cDNRdvMIEXUb/h7HfCZ/bYYJ/DMaKzEy/swOyw2ZNTmxh0JP3dCGwc8IFBMHMPhDSCol+VXgRvYUwTnXssxJNbkwrNx9p7LIrbbuBSYbjUUYAQB3PTpQfDXBor4Ob3cW8sZQqMIbDzH87pk6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CjyXkUWa; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CjyXkUWa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774657719; x=1806193719;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=amBBWBNDotHgFdobIqJC1q9S63trJacecAl/Tdujw/Y=;
  b=CjyXkUWaKTnIL7dp2zE6SpISDmExs8l1nFIV5FIy0sW/RusC6c23sRL0
   bulf+9536i4pS3xFucwHIHMh32CZUzD2SVQExRsIpVgDUZ6+IviyMcL3l
   1sqClLfCg0MpbYGTwy/c36li+/xChWbklGDVXg4V0zWFXsKst6yxbi0GW
   QsePPI62CUwcS44NHzPen8crNoI6H26hleaJXgWMP7Hg0OTihIBC+7XBf
   NT3oS+SPzmyxKO8CRKZlwmZ+zn+zdAGHRac5ONdukA2Dh49PRUhbfZzw3
   JWG2UcS0+X2MXnPw3AVnVlj1wljBwXAIcXbiU2zSKNv0UCHLwrFnkDL/f
   g==;
X-CSE-ConnectionGUID: V82l9Qz9Qg6TvJAlK1+Y6w==
X-CSE-MsgGUID: sXk3Oi8vT3a4roTalFuQ1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="93317848"
X-IronPort-AV: E=Sophos;i="6.23,145,1770624000"; 
   d="scan'208";a="93317848"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 17:28:38 -0700
X-CSE-ConnectionGUID: FGtVyFxUQaKzQPAsObEmFg==
X-CSE-MsgGUID: c6FF/oMbRbetwi9Dt4xsHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,145,1770624000"; 
   d="scan'208";a="218830174"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 17:28:38 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 17:28:37 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Mar 2026 17:28:37 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.66) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 17:28:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fjy5LJ04PjgyT3oXt/er+Jrao1AIc6YYLlRYeEjoA53UQDJAjgd8+0w/Yia0HI79jhAdXOynFFxxX7HDPChghFCszaz3WeIC6OaHN4d6wBLWa5dssJnd6kfuVYjT/b6H0oZuAupgdEE8tOgvQbXtJHA8qx+0Ncd8TO7gR25oXkY8i7Lv0erMHz3AeQBoPxHkDz/mrgBnd1TNpt7iUmYAgh0Z2CoIDBTWwm0jzNvO7A9QN5pfiwF/z9PW5hWfPh898lNkWK4/K2KJ2OePPFwYUlxSVJc2gKkskG2rFBXV2SRGCCgTljRkSa4Sj0Gs3Oht/k7x65qvTXs3oPaaKcKCsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NldCGhtmkjJ0Of8BVVK9e3D9GvbLowMR7mL0BVFAqk=;
 b=bVIHukiZLL9CDPAL4VHY0Q8WOy/op8Zp7YVmbWWM3XOq0M003nIWpax7Pbn3zCfTU4o9/TfRuuv5GtkL60B3ajfEo1+JvKVAVx6yG1WnVrbgWuv59/TNtqnYTYjcmiG2PmU3bw9Jv68SGsfT6NpF9y++VrRQmvr32lMNgvhbyz6kEeg3ot9Dz38Zv1+Evd+AM+KkhL6VcK/hid9MfPKoK0LChqBP50CXVBZYYsWsj9kuds6vPL4ZY9XSzdzlFixMcPfntQCj/00SYXUguGEFpNGlLBOI3HfuoPZ89ROXE9t3nMUradu6Esfl2M3d5ArBeyO7Qh2zu6i1I7lmilHmuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM6PR11MB4706.namprd11.prod.outlook.com (2603:10b6:5:2a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Sat, 28 Mar
 2026 00:28:34 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9769.006; Sat, 28 Mar 2026
 00:28:34 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 27 Mar 2026 17:28:29 -0700
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
Message-ID: <69c720adadcd4_1b0cc6100b4@dwillia2-mobl4.notmuch>
In-Reply-To: <20260302203648.2886956-2-terry.bowman@amd.com>
References: <20260302203648.2886956-1-terry.bowman@amd.com>
 <20260302203648.2886956-2-terry.bowman@amd.com>
Subject: Re: [PATCH v16 01/10] PCI/AER: Introduce AER-CXL Kfifo
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0233.namprd03.prod.outlook.com
 (2603:10b6:303:b9::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM6PR11MB4706:EE_
X-MS-Office365-Filtering-Correlation-Id: c9b1a58b-cd52-4c2e-87a3-08de8c60f1fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: +/3WYEiB5wN9fAaKG1BJH7WNC8T2p9wkNierGG6IUsAEzVrmh/XAf7o5om9Yfi0vKRG6Kam4teU1wz/dmnXyRN3UxFvu5GxJNsPR1ft9VJQoaqW/73NECdjx3h1LIO11XZyw4UqfbZz+jDQPeiex5ujKG3So8ufLAEGsrmUL6iNnR7UQa8cbEGsIqwSmgrV8QWEpTQ3uC29Uo7SF+qO0dSmtDSH8h5c1fP9+psb9KnBLqi89p7RHUS27jHPvXcLhD+uBOQLJTD7KRHsx5Vd/oYs+JXVp+IGbVD94mHb2f9CiBiqsaRnxJJUuWHOjIC0sUh1pxtF4uw4Q/P1Noz7wieC6qSepiCUiWAp2JRkTfCrGzacHl6rW7qcUmneljkGnhGpZRNP3YTHBaCTCqgOW5ImA1ISlmi9W5LPguoRhFwiso0QV3CNy9UabuEWCRd/ezGA0I//QbopOG0i4VTCZX/79KSbR1Q97vB5RK7tI7v3gYWFyjoyy9AwZGFvWlJgHFONJf5499JE+Wq7u9IkcW6j1XIBzLzBLmUTZs9VN4Q+m7WtmqghSdVL5VQM46XT4ZGCnsnKY3xLo4ay/WSBkC1oXgJ+wiK6I6A7KvCFOLrVhuYas5JxZyiPyXjzj3HsyfPvMIPTlIqklS/E6IklFN+tH2GBpwsbrx+7wtW4OkBeCj8Ze7O5qsD8nz5PE/7n/Ye+Q58Vdn+TtbQYix1io7ygM4B81vtN7hzywf8KxaQ4ia0MRQHmDvjOK9+2AnoTiatZMlJeT0dv4ccEEOA+7SA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkJTd3VEWGRHQmlaYWJXOWt1OUV4cmRIRmNjN0lyRU92dllodzBiT0V1Um5x?=
 =?utf-8?B?blZpTTJ6N05qeDRjMkF5dU4wdHJnbDg5ZWd4YStkK0RZOVRhZ1l5bitsbWRY?=
 =?utf-8?B?SUxJZW8zcG5aSG9zSW5SQ3FLZnczbFRhak9BSSs5Yko2cWkxOUdUT0lsNTNs?=
 =?utf-8?B?cjlNc3dpZlVRVUNnblF6aGM3c2JwckRvdjQyd0V2b2NuVElCQXI0VTJDcXpk?=
 =?utf-8?B?N0V1ZFpiU2p1T2lUOCtYSktGamlEd0R3c2J2ZjJZSm1jSzUvSmo3K0lGUTRQ?=
 =?utf-8?B?aTVISU1aSXdTbUY5TFowOGswRjc5MjlpNk9BRjlGSmVyUWh0UDJYY091dU1p?=
 =?utf-8?B?RjF3Yk5JS2hDYTAvbDJBVGFQbC9KMlVVbmd6NGRicVZkdGlMNGduZUljRldH?=
 =?utf-8?B?V083V1BreXZjZFJwN1B1akQ3OXFEaFBLSm0yR290VDBsR0laZCtkcFM1ZG1u?=
 =?utf-8?B?UW9nVm5UaTFDSzFjUjEyRVc0dUVIenhGQmtDWHpjZFZPVEsyV2JxSnIvOVND?=
 =?utf-8?B?Lyt4SGROZEVmZURRek9pYkNwZGtXUkJ5Tk41WnFVWnEyWTJIdGN5ZnZPbmJy?=
 =?utf-8?B?SnRCSjZXZEx3bythN0sraTBpNFZ6ay9URVVMU2lOYkVFa3pDd21rVDhuMXg2?=
 =?utf-8?B?MHhtY2JSWEVYbzdBZktUazBuVDdNbWFOY3FsMnlxa0JQeGhWc0hLQkROeHcr?=
 =?utf-8?B?emtBaE1rYnk0eWk4NVVBZ2hsSlZLRTBhSWtkMVNrc1JGYzdaTy9YZHNPWnNn?=
 =?utf-8?B?STlKbEJGWEtxSGpUNHRFUWZqUklQQi9oTnVkUlhQTm0xT2o2ZWlJL25BUWlQ?=
 =?utf-8?B?L1BMSzZZNTgwUm1vcEJ5TjN0VTAxQlFwWWtPV1JFNlZidGVIcUNrV2NOVk5W?=
 =?utf-8?B?QlNQNU13WFFpYU1aZlVwT1JwVDc1THd4aFR2QnhMYytWazl0SVU3S3RkVXgz?=
 =?utf-8?B?Z2dLZGVKbzRkaGx2cXRnSU9Ha1RZdHZsN2RxcVRNSngyc21IYmhWSldPU1g3?=
 =?utf-8?B?RTVOSjZkem1zTnRHaVFJTWZ3c0hHTjVXanh1Z2V5N2k1RSt2b3lIbnNnVjFy?=
 =?utf-8?B?WDBzOHRkK3NXdlRjOWpkSjNoOGZkVnU1WndBLzVSaWtRdzNBWEdJT2FxcmQ4?=
 =?utf-8?B?OXd6TmpWd3Bjc3orVGJ6TFR4bE0xaEZnY3JUNmlwSEY2bTRHQi91NndkNjVG?=
 =?utf-8?B?U1ZTVDlsbjR4Z1VBdFdidnFUMnF3cjlFY3JnbEIxMEowMEZsZ0xtYm5OcVo3?=
 =?utf-8?B?d2hMS3E0Ky9LclhMUkFxL1ovS1ZyLzRQck1DeW41NjFQKzJEL1Awang4RVph?=
 =?utf-8?B?em1kbkJKZWdoa3d6MW52bFV3a3JvMmZ4SHZnQkx5cy9ENEhxTHBVTExwOXVy?=
 =?utf-8?B?N3BRZE15bjhMUzdmaFcyb2JIaEdTVkdxMFJOSk9NSE84RVZtWU1uVmhIUkt4?=
 =?utf-8?B?WGh2S1VwVmZiOXlZRzFkZTVjRks0Wjk5WlRocXpUV2JNeGNua3hDVERzVHpO?=
 =?utf-8?B?Z1dReUNPeHFvbTBaamwySDdmak9vUlBSNjNKRWdHd3B4d3RoT1kzTmVlVEsy?=
 =?utf-8?B?REo1dStyQTFCbVNGUm1qc0dSRmZFTTRrRHBkTjJWcDJJZmRTczljd3pDK1ll?=
 =?utf-8?B?elROQnFRS0gxK0sycWhLZWpBL05XZlJPQ2ZZUmcxalF2cjlNU3VUaWVDd0xB?=
 =?utf-8?B?aUtXU3FGekZYL2ZkTys1VVJtSmltOWxicEFSNzErTTRPdlFmNVcxUVV1eGgx?=
 =?utf-8?B?TUdYdytuZmZlMDRuTzExV2RIMlpzRU5xM3FQSENtMUFpVjd6L2dGbXQzWVg5?=
 =?utf-8?B?ZllZT3VWT2RTK2JwbEEvcHc3bU9laEJFblowOG5oRVBaaVZZUEQ2dlhMQ1ph?=
 =?utf-8?B?VjVTL2xJRjFuMnZ0dkRiU2ROcGd0akUvVzBYcWdYODMzamkwZ2NtaTM0dnNP?=
 =?utf-8?B?cnRyOWZlb01tSXZMR29QbkEweGVVdTJZZkVHZGZxdW04YkdaVUpQSDk0UDlj?=
 =?utf-8?B?U05sdFhtSVY4bFU4RDkweU0wWG9jdkE5OE41TFZvZ3ZScHQ0VkVveHJsZU9q?=
 =?utf-8?B?VkhPY0RoRmlNUGRpSWh0N25VK2VZQTlYZElodmFlTnpTWTRmcWVHbWQ3SFRE?=
 =?utf-8?B?TVlzdkRhdSsvcld6aEFyalhTTmc5OXBkSHZxeEdSUzYwZVZiT3RPQzZWS045?=
 =?utf-8?B?WWFDaUxZT2ZqQUhWazFtT0ZJeEw1MGMxU3FpSHA5ZlAyc3NEaGZhT0FoRFRC?=
 =?utf-8?B?b0toWEN4VzErRzBkSXA0RlB1SkUzazltMmRISSt6SnMwZHMyQUM2SmQwMWdP?=
 =?utf-8?B?N0daYUdsNmRaTGIybElwaHBwOGkxbURxRlMrWkFqa3JZT2lWdjVBL3pKOVda?=
 =?utf-8?Q?GxLIj8HXh50Fauso=3D?=
X-Exchange-RoutingPolicyChecked: BNJDXZ7JIn3WeZPuQkLPCoL6vy0PXd1RYCs7Sav4DOe+dLDREqbUaZ0xoSuVZ4QMd8hnk0WGmzTAurRLgmr8tgKNWsHccesNzLPOe4PRNnXJhQHJ8wx/vOOdp4PP1hC12C7BJVzzPLyEe2ckDyX2v+0Gu/+ssAMVBNSWC3jZPrqUFDCm75fExk5gp5jJPV6wmTBO2xxnyck/4ZZs6UqBnnLHQNYf09K4W+tANtA6+EfsQQ8BIZ2J7KxZT2TX6N6l1w2WkXlEWJwaIqcwt5NUfdk6uOsxhQ7oWzGUV97QLyWgE3aszMcdccd5K5OQZ0nRsahfOalpJV2vO6sCDfVWGA==
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b1a58b-cd52-4c2e-87a3-08de8c60f1fd
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2026 00:28:34.0242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XxDl3KvgyxkbmMgU5V/kz6WJ+3U/sorMX96ehp3F01QooOg/xOuJInWlgEDXSsj/7vwMIzRKqVuORN9XfiuJa6sa+zhNvXw6qRssN6QZTvo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4706
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> CXL virtual hierarchy (VH) RAS handling for CXL Port devices will be added
> soon. This requires a notification mechanism for the AER driver to share
> the AER interrupt with the CXL driver. The notification will be used as an
> indication for the CXL drivers to handle and log the CXL RAS errors.
> 
> Note, 'CXL protocol error' terminology will refer to CXL VH and not
> CXL RCH errors unless specifically noted going forward.
> 
> Introduce a new file in the AER driver to handle the CXL protocol errors
> named pci/pcie/aer_cxl_vh.c.
> 
> Add a kfifo work queue to be used by the AER and CXL drivers. The AER
> driver will be the sole kfifo producer adding work and the cxl_core will be
> the sole kfifo consumer removing work. Add the boilerplate kfifo support.
> Encapsulate the kfifo, RW semaphore, and work pointer in a single structure.
> 
> Add CXL work queue handler registration functions in the AER driver. Export
> the functions allowing CXL driver to access. Implement registration
> functions for the CXL driver to assign or clear the work handler function.
> 
> Introduce 'struct cxl_proto_err_work_data' to serve as the kfifo work data.
> This will contain a reference to the PCI error source device and the error
> severity. This will be used when the work is dequeued by the cxl_core driver.
> 
> Introduce cxl_forward_error() to take a given CXL protocol error and add it
> to a work structure before pushing onto the AER-CXL kfifo. This function
> takes a reference count increment of the PCI device. The kfifo consumer is
> responsible for reference decrementing. If there is an error on adding the
> work then this function must decrement the reference count.
> 
> Synchronize accesses to the work function pointer during registration,
> deregistration, enqueue, and dequeue. Further synchronization fixes will
> be added in the following patch.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> 
> ---
> 
> Changes in v15->v16:
> - Add pci_dev_put() and comment in pci_dev_get() (Dan)
> - /rw_sema/rwsema/ (Dan)

To be clear I asked for s/rw_sema/rwsem/, easy enough to fix up.

[..]
>  drivers/pci/pcie/aer_cxl_vh.c | 87 +++++++++++++++++++++++++++++++++++
>  create mode 100644 drivers/pci/pcie/aer_cxl_vh.c

Bjorn, do you want this additional burden to fall on PCI core reviewers,
or perhaps make this change to the "COMPUTE EXPRESS LINK (CXL)" entry?

diff --git a/MAINTAINERS b/MAINTAINERS
index 61bf550fd37c..1b46ac52839d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6438,6 +6438,8 @@ S:        Maintained
 F:     Documentation/driver-api/cxl
 F:     Documentation/userspace-api/fwctl/fwctl-cxl.rst
 F:     drivers/cxl/
+F:     drivers/pci/pcie/aer_cxl_rch.c
+F:     drivers/pci/pcie/aer_cxl_vh.c
 F:     include/cxl/
 F:     include/uapi/linux/cxl_mem.h
 F:     tools/testing/cxl/

[..]
> diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
> new file mode 100644
> index 000000000000..7e2bc1894395
> --- /dev/null
> +++ b/drivers/pci/pcie/aer_cxl_vh.c
[..]
> +void cxl_register_proto_err_work(struct work_struct *work)
> +{
> +	guard(rwsem_write)(&cxl_proto_err_kfifo.rwsema);
> +	cxl_proto_err_kfifo.work = work;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_register_proto_err_work, "CXL");

Probably more appropriate to make all of these exports:

EXPORT_SYMBOL_FOR_MODULES(..., "cxl_core");

> +void cxl_unregister_proto_err_work(void)
> +{
> +	guard(rwsem_write)(&cxl_proto_err_kfifo.rwsema);
> +	cxl_proto_err_kfifo.work = NULL;

Where is the work cancellation for this?

Oh, patch2 has it, that should really be in this patch. I would fold in
that fix... but it needs a bit more, see below.

> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_unregister_proto_err_work, "CXL");
> +
> +int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd)
> +{
> +	guard(rwsem_read)(&cxl_proto_err_kfifo.rwsema);
> +	return kfifo_get(&cxl_proto_err_kfifo.fifo, wd);

I just realized that this reacquires the semaphore on every invocation,
and leaks stranded references.

How about something like below which I think also address Jonathan's
concern about the awkwardness of the consumer needing to manage the
producer's refcounting. With this change all the refcounting is internal
to the producer, and it is properly cleaned up as to not leave PCI
devices with dangling refcounts if someone unloads the CXL core. The
rule is errors are dropped on the floor when the work handler is
missing, and any errors that race unregistration are also dropped on the
floor.

diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
index 348374859ee4..cc4e443511d0 100644
--- a/drivers/pci/pcie/aer_cxl_vh.c
+++ b/drivers/pci/pcie/aer_cxl_vh.c
@@ -72,16 +72,43 @@ void cxl_register_proto_err_work(struct work_struct *work)
 }
 EXPORT_SYMBOL_FOR_MODULES(cxl_register_proto_err_work, "cxl_core");
 
-void cxl_unregister_proto_err_work(void)
+static struct work_struct *cancel_cxl_proto_err(void)
 {
+	struct work_struct *work;
+	struct cxl_proto_err_work_data wd;
+
 	guard(rwsem_write)(&cxl_proto_err_kfifo.rwsem);
+	work = cxl_proto_err_kfifo.work;
 	cxl_proto_err_kfifo.work = NULL;
+	while (kfifo_get(&cxl_proto_err_kfifo.fifo, &wd)) {
+		dev_err_ratelimited(&wd.pdev->dev,
+				    "AER-CXL error report canceled\n");
+		pci_dev_put(wd.pdev);
+	}
+	return work;
+}
+
+void cxl_unregister_proto_err_work(void)
+{
+	struct work_struct *work = cancel_cxl_proto_err();
+
+	if (work)
+		cancel_work_sync(work);
 }
 EXPORT_SYMBOL_FOR_MODULES(cxl_unregister_proto_err_work, "cxl_core");
 
-int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd)
+int for_each_cxl_proto_err(struct cxl_proto_err_work_data *wd, int (*fn)(struct cxl_proto_err_work_data *))
 {
+	int rc;
+
 	guard(rwsem_read)(&cxl_proto_err_kfifo.rwsem);
-	return kfifo_get(&cxl_proto_err_kfifo.fifo, wd);
+	while (kfifo_get(&cxl_proto_err_kfifo.fifo, wd)) {
+		rc = fn(wd);
+		pci_dev_put(wd->pdev);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
 }
-EXPORT_SYMBOL_FOR_MODULES(cxl_proto_err_kfifo_get, "cxl_core");
+EXPORT_SYMBOL_FOR_MODULES(for_each_cxl_proto_err, "cxl_core");
diff --git a/include/linux/aer.h b/include/linux/aer.h
index f351e41dd979..8d60fd97ed67 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -79,12 +79,19 @@ static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
 struct work_struct;
 
 #ifdef CONFIG_CXL_RAS
-int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd);
 void cxl_register_proto_err_work(struct work_struct *work);
+int for_each_cxl_proto_err(struct cxl_proto_err_work_data *wd,
+			   int (*fn)(struct cxl_proto_err_work_data *));
 void cxl_unregister_proto_err_work(void);
 #else
 static inline int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd) { return 0; }
 static inline void cxl_register_proto_err_work(struct work_struct *work) { }
+static inline int
+for_each_cxl_proto_err(struct cxl_proto_err_work_data *wd,
+		       int (*fn)(struct cxl_proto_err_work_data *))
+{
+	return 0;
+}
 static inline void cxl_unregister_proto_err_work(void) { }
 #endif
