Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A834D41760;
	Mon, 30 Mar 2026 00:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774829343; cv=fail; b=KF7TBv7AGolSVKOItqq0rmYc9cJyMb6rmxBDN6zwpwqStCU0Jox+AKrF/nc0Ctfok9qzsUMiDELbd/oYeQFZofk+krSV5j8xX1CbJ/xndRlTWt52LjnqbjBgm5TV+Wa5z2Qpu+Wlek4RwL3T/sFPl4dnA7PzroZHOkF368XanLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774829343; c=relaxed/simple;
	bh=lfE4rUfB4xzkUnBBACUavS0KDJpo6YozrVQ8s5Nevc0=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=tOHg/Ktm8OoA07Lu6fy2Pd8DfN5Yxwu59h54vUpnQyxY0QPw4ziqvuuI+qkTsHiSJgaZFdOfoLk5wNboeCvm0N0eS3tNraXOmur5qkjGYYEeW7SsxZr6/hGlWXhosi7h2Ydi9c+Sc+CVL3J3+x7+gvJdCF9H63VbAUgQSIwI0to=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RnxNYO/y; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RnxNYO/y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774829342; x=1806365342;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=lfE4rUfB4xzkUnBBACUavS0KDJpo6YozrVQ8s5Nevc0=;
  b=RnxNYO/yInNNHmEXwQB9OGaLC5S/9rLm8knBqErHxL3jB4spbVGrQtWw
   wptMQWzqcD4NocDr+MshKTWK4OuzW8+dmKislPx4FhdVQovWjXHHVdW7b
   j1ElU6EhkWFY1c8CZbZs/nQRjoyLgQOERTgElZRhVXVrB6OL6MUi8gC7z
   gTaefek0TmRJZ4UjwO2+Fy7HFPLVnwvKRwRPjFODF8SqwSHvkbBOFs/z2
   +V8aoBpv52lA72aSwGxQErtxzsDgi2BkGPqYj12jsh1RZB/dTLFW9EgYU
   RAx3KbRtdomMWMpv69J9FRxGN7UKLMCA4XHN5dY3r1LB5j9f9TBaVS+fO
   A==;
X-CSE-ConnectionGUID: Sf4TshxETxmeqKVDsG+zUA==
X-CSE-MsgGUID: P0JiMZ0zRjK23ocNFeaLqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="76009954"
X-IronPort-AV: E=Sophos;i="6.23,148,1770624000"; 
   d="scan'208";a="76009954"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 17:09:01 -0700
X-CSE-ConnectionGUID: dSRBvgUTTeCBTYYzAwJApg==
X-CSE-MsgGUID: r1WtI09zSjq902MIYCGS+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,148,1770624000"; 
   d="scan'208";a="248943551"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 17:09:01 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 17:09:00 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 29 Mar 2026 17:09:00 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.1) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 17:09:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZF00VUwb3c721OzoiNwUMkiY7a3DwuPHWjM6yDP8cEFgffttvBQ+NBZqkWRrHceTdbqMQ/0inj+2DzBDetYyRBBfkG5ILrN/ISUp3c6QLmW4rkfV9xjUBfxbwYxTaewA5Sh0l6T+oMxh5KPhqfdbzJSZrJXeSWTZWs0bCpNDRRAvQfyKdfi9MITOkfUWPE8AKhLquBeMKfLVOM9+ChPuXGDiSYmCwcPgg51vxADp6ucqaQX7LhoF9aUVX1cWs7V07UxJhh5VuyG4NNd+ABZ+b1chHNs56Iigdia6zB7PFaZxcMqGvMi3JIzB4sjtHhmD5qoelZWl55L76Q2Orkn6Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0aR5cbDkmJCdJWEfvm1aF6xnJeXJbQRTjuAEy8tjUSw=;
 b=GTKlHW4/YYi2wk2qULg0iHJiTf8CW3D3rNvjbubSipev6QQEP9wg6OjWgG2hyy8FVtY8oSHslV43oHV+tsweQoYlMc/0+NgdTEnxHm9MSrf7y4mOoeGqHL1GukrbutBXANMeXSYh0FHsKxYB0c3ia5qq/wt0GCPzGg1MltObd/g5+KVkFHnrwvgy4SI/+kq/A0P8aOVwBBYvTDM9novjKU+q8Bak7oZ9klGG7gGixJaq5RpPaqQZUgVa0nK4BDasyCYK1YDd8JFHYoM3DbdS2NwdSQrhRcUDlICkSblX3ljS3H2d0ZpECbGii4IA2KU+6xMnRMHJtx0eLE2KeRd+bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ5PPF0D72A1BA6.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::80c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.12; Mon, 30 Mar
 2026 00:08:58 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9769.006; Mon, 30 Mar 2026
 00:08:57 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Sun, 29 Mar 2026 17:08:54 -0700
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
Message-ID: <69c9bf16b42ba_178904100a1@dwillia2-mobl4.notmuch>
In-Reply-To: <20260302203648.2886956-6-terry.bowman@amd.com>
References: <20260302203648.2886956-1-terry.bowman@amd.com>
 <20260302203648.2886956-6-terry.bowman@amd.com>
Subject: Re: [PATCH v16 05/10] PCI: Establish common CXL Port protocol error
 flow
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0342.namprd04.prod.outlook.com
 (2603:10b6:303:8a::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ5PPF0D72A1BA6:EE_
X-MS-Office365-Filtering-Correlation-Id: 705e5f95-a74d-4010-85bf-08de8df08994
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: TJptANmPExgNLnW+yeL5UlVJH2efkatJ5eA2A4KUVp3ykpdOHeANaCqfqNsOFDC3OL/0EYr9Wp1yTYeDxwZrNJubCnEqB7EfWKV9Aqju3ZCYOKIyN2kNovsYadRuXwLhJJSA8TYUPa6xObyZ4L+SLXmaHi66iwkYQauLppWZ8/+Y3n6y60PeWCNcDILdcA1Uz7DA5ORCdFf4qvaLMoF9G6+kPD4sj88lV2SPIvE4WRDKGDKyQWe24rA+NlF1vEh4DihgYMg+7IaU1lEGQdCWBzizIOUh3mJ69YPMIPaKHX2CUpoBE0aJf6jlMQIPtlUm6UPJgWndX9i9ogSeDn+6VtH59pQ5yXPsRtp6p4PetX7bFqNiSdnSHgThj1kJPSkuerjaNDG4iKGE/Bdd7pZj3dgHCjyv4JqpVspDT6czxc3QM2WDJtexVrQ361/T9NzLPhrb58m74ceLSqPOnO4K4JOhdI24cCt/WD0Qt3AIdh1F0CUXvGGv729bgi0RlI9T27ubx/gr2vkEIib7OcCVvofwRF7J+x/OFykQDjxvAhDCa3EgCxku6CMWc6AmZJqtpw+8i2LB8IIYEqOICB1kFjhmrtMClbSKkmzYwvS7PBwe4q+6GJHNF00/4n71EiiI1vZ8e+bCiIV0t4nQtJ3+Ka0oDVOek0+uQPNxssCP8rR6i5jyPzWEGd+mawyoC6mf9MmHBPcJmql9EgxuGwmf8H7ZnO0zFERcCI6nxSRSQAUUkMUnhpsX5SpedYznNs2g6SpAdl8vBkxPfSsoCxw5pA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1VlVE5lQzdpUDE1VzFFQmwrNUpvekxhR2kwV3crVUM2QXkvTjdmcWx4TjF6?=
 =?utf-8?B?aFZ0eThkZDFqTlRhVUFlQTVXYWhTOUxIZDVqT0FFNTZYN1R5UnBmSzRQY0Nl?=
 =?utf-8?B?SzA3NTY2VCtkRmwvVHYxc2R5Q0FIYlhOZU5IMWpkeGRqVXcyZDZCVUVKVGM2?=
 =?utf-8?B?dE5mV1IxSmJjcmhQeXpLTk55NUpMaWQzN0IreDlRejF4ZlJUVm9vUnFURnRP?=
 =?utf-8?B?Zm5hMVhJOEdXUkVXcFdXTmpBYzd3YnFsVzJJM042WmdISnUzSlgzdVZiNGM4?=
 =?utf-8?B?MjNlWk9vcTcxN0ZGcVA5NG9LZjhzNGxjemFDcURNdkEvMzF2SmlIbUIwdzhs?=
 =?utf-8?B?d0RUa2phZ0xTVUFSVko1eVg1bWlFcWFOQVdkSG90TXhOWVhPK1F5amMxWWNS?=
 =?utf-8?B?SGxrSmRFZnViMGw2blpTZEVlMzgxZGdYTE9EQXlCNnBWYTF4L25IWFkzN2tp?=
 =?utf-8?B?SVNFTnorRk5ocm52Q0p4OFJPdEhhb3MycjRZZm1LekJ6KzNVdzRkbVUzK1p4?=
 =?utf-8?B?VDR3R1h1QS9TWSs5REJieHg0RXNwVERyRDFod3E3cjk3SWpwelJpUGtDK3Ev?=
 =?utf-8?B?U1pscTgxRTg5WFZlWEZKVWNIRmVyY2tqODJMZ3NRWVJFcWxTUURYMmVmc2hr?=
 =?utf-8?B?TUw4L2RDUWZ3NXFUN1A3b2d1TkhYWDRMN3pQL0UyYWFnMWJ2RVZhVUJYYUVo?=
 =?utf-8?B?aWhveGhCQ1pXT1dZelVrenFOK0dzZTVueXMzNG55a01uZmVFRzRidjhFYTlp?=
 =?utf-8?B?SzRiaGRGamtyT0dsMnVGM1k3bURBYnBnaGNxTnhSelhocEtQNFJvcUorc0JJ?=
 =?utf-8?B?aDRwdEl2c216UGlBTGVvYVJKaU9MSHhMVXg2ZWFqM01jZHlISlF5RHRRQ0Zv?=
 =?utf-8?B?UE1OeWEwYUY0RzNhWWtOZFFZSmQ2K3BKOVFMYXJybEZnL2tWUElIRysvSFlF?=
 =?utf-8?B?KzlwaTdqRDVrbXhVOFBQVjF5RXFrT0pBRHhieDY1ZmFuUjdqckFlSDA3VC8w?=
 =?utf-8?B?RHVMZ243Um13aXMvRzZXVUYyRjl4L09qTDBjTWhSWGczczlDcFJsQ203bGpL?=
 =?utf-8?B?dEdNSWh1SFY0Z1dzWTFyUkRRaDB0WU8yZjQ5Y2RBWjVuMnp4QVRUOE5reWpz?=
 =?utf-8?B?aFB2V1RpdFhycUx3eFQ2dW1VVTJmY09UdVBsdGl6S2l5eDFQUmN5QkkxMTNP?=
 =?utf-8?B?eTAydlgvbEpQd0F3VWJycDJSbVBVemZSV3FwNXZadC81djBjYTAxanNWRkFi?=
 =?utf-8?B?dFZ5SjRJeUFwbEZKSkRMbnplRzJFclF2MGkrSzFEZlUvKzZNQ1JuOW1KYnRz?=
 =?utf-8?B?djFUOEVrL2ovUGRGQ0lRWXNWWWk2RFg5SWI5cHdMdzZFS2M5MUorN2NDd2ZB?=
 =?utf-8?B?ZEZJYnJLblFqTVFGaFZLODROZGZOTmFlbFBxU0V0cHRVQUpuY2JVZzRlRFhO?=
 =?utf-8?B?dC9ZT0NoTEJqSURiZ1E1UG5MVVoyZ3pob2VrNVM0QzlUbHBBQjRQMXJQOENj?=
 =?utf-8?B?TEFraTAyclVQSkFGV1dZVldhRFBJOFg5MjBQbTYydGNORkxaSXYvY2VxRS9D?=
 =?utf-8?B?RFdVd0lQQUtZUkxBWW9kOWtLbXFxVmVHYy9UVUZtdEg1RC9aYitLa0Z1S3J1?=
 =?utf-8?B?R0diUjhCRWIwRXVQYzhJMDA1SDVLaFBNTzErVjhsaEpFU05qbGVPNFBQb2Fn?=
 =?utf-8?B?Rzd5aXFPUDN2T1ZxK3RKdUJ4c0Z2YUtjZjhkUS83R2JsbzlSU3dlZVNlYzZ4?=
 =?utf-8?B?R1VlRTRmaEVkS3c2bjJnVG5iaFozQVlMZGMxU1J6bUU5NWMxUEpibWZ3WkNM?=
 =?utf-8?B?WkpLMWozajBhSzBnYU5jRjJrUHQxZjI5RmRxMk1PS3dTa1FKS1N6U1pLeDFX?=
 =?utf-8?B?T2pPYThLYlQvMUUrT05VWWJVUFlwK2NxeDNCNE1aU3BpSFE4allocXlDaFZx?=
 =?utf-8?B?L29rTG9YcCtKQzhqd2J0MUJsS3ZNdWxuSjI3YWtuejhqeE1DVUtuRmdMQlFC?=
 =?utf-8?B?RjUzQVpwSElXWUxXazM1dzAzTHZkcGN2bEJLZEEzRk1mZUtXNFUwbnVrSzZX?=
 =?utf-8?B?bU9abWE2Sk8rVkNReXR3NzBicERwanoyeFVTODNxN3UvcTRwUWF4MTJZWTI0?=
 =?utf-8?B?dHpCY2NXQzFVVlJPQ21HR1Y5aXpJSXl3YzM0R0tlZGNtYkp2cEpLbjdMUmhj?=
 =?utf-8?B?RHNYZGM3MFlyalV4bEpGMldSZGNxNGp3K3dLMXlPZ3FEUUYrbWN5SU84OEhO?=
 =?utf-8?B?cnd4KzVLOXpwWUFHbXp4VW5NbVdBZlJ6WW16b05WNHdUajd4MUVGYWxWTzNo?=
 =?utf-8?B?YkxLSGlzSGwzUm5CVVd5R1FMUGFnbW41a21wWFdoR1ZxT3laTHkvK2FadU4z?=
 =?utf-8?Q?lq+KD4IWViYCTFBk=3D?=
X-Exchange-RoutingPolicyChecked: caZHnVAbL+H+jYI3HMdF8kg4utd9tIIVBzmDBnMNrQT+hxwfLh4qVQbdDmItDWwKvTl4N1hfX18DKy1raw6MiT7cs0Tpwvc6h160MocHCx66vZchK66YXPg+h77YGI1QFgGdyt9wDJpVVRmaZ9ILqAYnA2JersFIQ3mpNz7IjjLsGwdykav9pjgpMpFov79dXv7ORPLEe5+WmC9nJs+BmwMWVZWnCV2WcVrhWvxeM7+bU2HD5Uuqe8FkCuNEt2hauE6aDUaWxpXnuSM9J4RTafUSp2q4g8t0vpoPKkayMrodo9PNzdUEbXiw3B4tkMenAI6fRP5658mu4SfNqGLsqg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 705e5f95-a74d-4010-85bf-08de8df08994
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 00:08:57.7990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQ6X8iLEdOgp6Avy+lVhVJYFkrx+Otr1Ok73rY3NGFSUIvtriUu4zaSVS8A0uhCd+U+xfGhOQC3GZ3WD/WaJXvLL/zJj9aR/6rusxcvVbdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0D72A1BA6
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> Introduce CXL Port protocol error handling callbacks to unify detection,
> logging, and recovery across CXL Ports and Endpoints. Establish a consistent
> flow for correctable and uncorrectable CXL protocol errors. Support for RCH
> Downstream Port error handling will be added in a future patch.
> 
> Provide the solution by adding cxl_port_cor_error_detected() and
> cxl_port_error_detected() to handle correctable and uncorrectable handling
> through CXL RAS helpers, coordinating uncorrectable recovery in
> cxl_do_recovery(), and panicking when the handler returns PCI_ERS_RESULT_PANIC
> to preserve fatal cachemem behavior. Gate Endpoint handling on the Endpoint
> driver being bound to avoid processing errors on disabled devices.
> 
> Centralize the RAS base lookup in cxl_get_ras_base(), selecting the
> downstream-port dport->regs.ras for Root/Downstream Ports and port->regs.ras
> for Upstream Ports/Endpoints.
> 
> Export pcie_clear_device_status() and pci_aer_clear_fatal_status() to enable
> cxl_core to clear PCIe/AER state in these flows.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
[..]
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 5051800882c5..0eb2e28bb2c2 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -208,6 +208,9 @@ static inline void devm_cxl_dport_ras_setup(struct cxl_dport *dport) { }
>  #endif /* CONFIG_CXL_RAS */
>  
>  int cxl_gpf_port_setup(struct cxl_dport *dport);
> +struct cxl_port *find_cxl_port(struct device *dport_dev,
> +			       struct cxl_dport **dport);
> +struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev);
>  
>  struct cxl_hdm;
>  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 0c5957d1d329..27271402915f 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1386,8 +1386,8 @@ static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
>  	return NULL;
>  }
>  
> -static struct cxl_port *find_cxl_port(struct device *dport_dev,
> -				      struct cxl_dport **dport)
> +struct cxl_port *find_cxl_port(struct device *dport_dev,
> +			       struct cxl_dport **dport)

Now that these is becoming a public function, and the fact that the
"find" namespace is getting crowded, it deserves more description. It
also turns out that the process of describing this appears to generate a
better name / calling convention for get_cxl_port(), see below.

[..]
> @@ -185,6 +175,117 @@ void devm_cxl_port_ras_setup(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_port_ras_setup, "CXL");
>  
> +/*
> + * get_cxl_port - Return the parent CXL Port of a PCI device
> + * @pdev: PCI device whose parent CXL Port is being queried
> + *
> + * Looks up and returns the parent CXL Port associated with @pdev. On
> + * success, the returned port has its reference count incremented and must
> + * be released by the caller. Returns NULL if no associated CXL port is
> + * found.
> + *
> + * Return: Pointer to the parent &struct cxl_port or NULL on failure
> + */

No, 'struct cxl_port' instances are not "parented" by PCI devices. A
'struct cxl_port' is a "companion" device. This is similar in spirit to
how PCI devices can have ACPI / OF device companions.

This is also clearly another "find_cxl_port" routine, but in this case
it is "find_cxl_port_by_dev" where it is ambiguous whether the @dev is a
dport or uport.

It is also unfortunate that this code is duplicated inside
cxl_get_ras_base().

> +static struct cxl_port *get_cxl_port(struct pci_dev *pdev)
> +{
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_ROOT_PORT:
> +	case PCI_EXP_TYPE_DOWNSTREAM: {
> +		struct cxl_dport *dport;
> +		struct cxl_port *port = find_cxl_port(&pdev->dev, &dport);
> +
> +		if (!port) {
> +			pci_err(pdev, "Failed to find the CXL device");

This is a "find" function, why is it reporting errors? Only the caller
might know if this an error condition. Indeed callers do have their own:

cxl_proto_err_work_fn():
+                       pr_err_ratelimited("%s: Failed to find parent port device in CXL topology\n",
+                                          pci_name(pdev));

cxl_do_recovery()
+               pci_err(pdev, "Failed to find the CXL device\n");

Why is an uncoditional error print followed by a rate-limited print of
the same information?

Push the error logging to the location that has the proper context.

> +			return NULL;
> +		}
> +		return port;
> +	}
> +	case PCI_EXP_TYPE_UPSTREAM:
> +	case PCI_EXP_TYPE_ENDPOINT:
> +	case PCI_EXP_TYPE_RC_END: {
> +		struct cxl_port *port = find_cxl_port_by_uport(&pdev->dev);
> +
> +		if (!port) {
> +			pci_err(pdev, "Failed to find the CXL device");
> +			return NULL;
> +		}
> +		return port;
> +	}
> +	}
> +
> +	pr_err_ratelimited("%s: Error - Unsupported device type (%#x)",
> +			   pci_name(pdev), pci_pcie_type(pdev));

Set aside that this find function probably should not be tasked with
reporting errors, I notice that pci_notice_ratelimited() and
pci_info_ratelimited() exist. This seems to be asking for
pci_err_ratelimited().

> +	return NULL;
> +}
> +
> +static u64 cxl_serial_number(struct device *dev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
> +	struct device *port_dev = port ? port->uport_dev : NULL;
> +	struct cxl_memdev *cxlmd;
> +
> +	if (!port_dev || !is_cxl_memdev(dev))
> +		return 0;
> +
> +	cxlmd = to_cxl_memdev(port_dev);
> +	return cxlmd->cxlds->serial;

This is quite a bit of work just get a serial number. Given we are
already committed to reading some device registers, why not a few more?
I.e. just call pci_get_dsn() as needed. That will also happen to work
for switches that have serial numbers.

> +}
> +
> +static void __iomem *cxl_get_ras_base(struct device *dev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_ROOT_PORT:
> +	case PCI_EXP_TYPE_DOWNSTREAM: {
> +		struct cxl_dport *dport = NULL;
> +		struct cxl_port *port __free(put_cxl_port) = find_cxl_port(&pdev->dev, &dport);
> +
> +		if (!dport) {
> +			pci_err(pdev, "Failed to find the CXL device");
> +			return NULL;
> +		}
> +		return dport->regs.ras;
> +	}
> +	case PCI_EXP_TYPE_UPSTREAM:
> +	case PCI_EXP_TYPE_ENDPOINT:
> +	case PCI_EXP_TYPE_RC_END: {
> +		struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_uport(&pdev->dev);
> +
> +		if (!port) {
> +			pci_err(pdev, "Failed to find the CXL device");
> +			return NULL;
> +		}
> +		return port->regs.ras;
> +	}
> +	}
> +	dev_warn_once(dev, "Error: Unsupported device type (%#x)", pci_pcie_type(pdev));
> +	return NULL;
> +}

Here is a cleanup patch I will send incrementally to change the
get_cxl_port() calling convention to find_cxl_port_by_dev() and reuse
the result rather than duplicating the lookup and the implementation.

---
 drivers/cxl/core/ras.c | 116 +++++++++++++----------------------------
 1 file changed, 35 insertions(+), 81 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 1d4be2d78469..3c503ae870df 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -176,97 +176,47 @@ void devm_cxl_port_ras_setup(struct cxl_port *port)
 EXPORT_SYMBOL_NS_GPL(devm_cxl_port_ras_setup, "CXL");
 
 /*
- * get_cxl_port - Return the parent CXL Port of a PCI device
- * @pdev: PCI device whose parent CXL Port is being queried
+ * find_cxl_port_by_dev - Use @dev as hint to do a _by_dport or _by_uport lookup
+ * @dev: generic device that may either by a companion of port or target dport
+ * @dport: mandatory output parameter that is set when @dev is determined to be
+ * a companion of a dport.
  *
- * Looks up and returns the parent CXL Port associated with @pdev. On
- * success, the returned port has its reference count incremented and must
- * be released by the caller. Returns NULL if no associated CXL port is
- * found.
- *
- * Return: Pointer to the parent &struct cxl_port or NULL on failure
+ * Return a 'struct cxl_port' with an elevated reference if found. Use
+ * __free(put_cxl_port) to release.
  */
-static struct cxl_port *get_cxl_port(struct pci_dev *pdev)
+static struct cxl_port *find_cxl_port_by_dev(struct device *dev, struct cxl_dport **dport)
 {
+	struct pci_dev *pdev;
+
+	*dport = NULL;
+	if (!dev_is_pci(dev))
+		return NULL;
+
+	pdev = to_pci_dev(dev);
 	switch (pci_pcie_type(pdev)) {
 	case PCI_EXP_TYPE_ROOT_PORT:
-	case PCI_EXP_TYPE_DOWNSTREAM: {
-		struct cxl_dport *dport;
-		struct cxl_port *port = find_cxl_port(&pdev->dev, &dport);
-
-		if (!port) {
-			pci_err(pdev, "Failed to find the CXL device");
-			return NULL;
-		}
-		return port;
-	}
+	case PCI_EXP_TYPE_DOWNSTREAM:
+		return find_cxl_port_by_dport(dev, dport);
 	case PCI_EXP_TYPE_UPSTREAM:
 	case PCI_EXP_TYPE_ENDPOINT:
-	case PCI_EXP_TYPE_RC_END: {
-		struct cxl_port *port = find_cxl_port_by_uport(&pdev->dev);
-
-		if (!port) {
-			pci_err(pdev, "Failed to find the CXL device");
-			return NULL;
-		}
-		return port;
-	}
+	case PCI_EXP_TYPE_RC_END:
+		return find_cxl_port_by_uport(dev);
 	}
 
-	pr_err_ratelimited("%s: Error - Unsupported device type (%#x)",
-			   pci_name(pdev), pci_pcie_type(pdev));
 	return NULL;
 }
 
-static u64 cxl_serial_number(struct device *dev)
+static void __iomem *to_ras_base(struct cxl_port *port, struct cxl_dport *dport)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
-	struct device *port_dev = port ? port->uport_dev : NULL;
-	struct cxl_memdev *cxlmd;
-
-	if (!port_dev || !is_cxl_memdev(dev))
-		return 0;
-
-	cxlmd = to_cxl_memdev(port_dev);
-	return cxlmd->cxlds->serial;
-}
-
-static void __iomem *cxl_get_ras_base(struct device *dev)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-
-	switch (pci_pcie_type(pdev)) {
-	case PCI_EXP_TYPE_ROOT_PORT:
-	case PCI_EXP_TYPE_DOWNSTREAM: {
-		struct cxl_dport *dport = NULL;
-		struct cxl_port *port __free(put_cxl_port) = find_cxl_port(&pdev->dev, &dport);
-
-		if (!dport) {
-			pci_err(pdev, "Failed to find the CXL device");
-			return NULL;
-		}
+	if (!port)
+		return NULL;
+	if (dport)
 		return dport->regs.ras;
-	}
-	case PCI_EXP_TYPE_UPSTREAM:
-	case PCI_EXP_TYPE_ENDPOINT:
-	case PCI_EXP_TYPE_RC_END: {
-		struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_uport(&pdev->dev);
-
-		if (!port) {
-			pci_err(pdev, "Failed to find the CXL device");
-			return NULL;
-		}
-		return port->regs.ras;
-	}
-	}
-	dev_warn_once(dev, "Error: Unsupported device type (%#x)", pci_pcie_type(pdev));
-	return NULL;
+	return port->regs.ras;
 }
 
-static void cxl_do_recovery(struct pci_dev *pdev)
+static void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port, struct cxl_dport *dport)
 {
-	struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
 	struct device *dev = &pdev->dev;
 	pci_ers_result_t status;
 
@@ -275,7 +225,8 @@ static void cxl_do_recovery(struct pci_dev *pdev)
 		return;
 	}
 
-	status =  cxl_handle_ras(dev, cxl_serial_number(dev), cxl_get_ras_base(dev));
+	status = cxl_handle_ras(dev, pci_get_dsn(pdev),
+				to_ras_base(port, dport));
 	if (status == PCI_ERS_RESULT_PANIC)
 		panic("CXL cachemem error.");
 
@@ -429,7 +380,8 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
 
-static void cxl_handle_proto_error(struct pci_dev *pdev, int severity)
+static void cxl_handle_proto_error(struct pci_dev *pdev, struct cxl_port *port,
+				   struct cxl_dport *dport, int severity)
 {
 	if (severity == AER_CORRECTABLE) {
 		struct device *dev = &pdev->dev;
@@ -442,11 +394,11 @@ static void cxl_handle_proto_error(struct pci_dev *pdev, int severity)
 						       pdev->aer_cap + PCI_ERR_COR_STATUS,
 						       0, PCI_ERR_COR_INTERNAL);
 
-		cxl_handle_cor_ras(dev, cxl_serial_number(dev),
-				   cxl_get_ras_base(dev));
+		cxl_handle_cor_ras(dev, pci_get_dsn(pdev),
+				   to_ras_base(port, dport));
 		pcie_clear_device_status(pdev);
 	} else {
-		cxl_do_recovery(pdev);
+		cxl_do_recovery(pdev, port, dport);
 	}
 }
 
@@ -460,7 +412,9 @@ static void cxl_proto_err_work_fn(struct work_struct *work)
 	 */
 	while (cxl_proto_err_kfifo_get(&wd)) {
 		struct pci_dev *pdev __free(pci_dev_put) = wd.pdev;
-		struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
+		struct cxl_dport *dport;
+		struct cxl_port *port __free(put_cxl_port) =
+			find_cxl_port_by_dev(&pdev->dev, &dport);
 
 		if (!port) {
 			pr_err_ratelimited("%s: Failed to find parent port device in CXL topology\n",
@@ -475,7 +429,7 @@ static void cxl_proto_err_work_fn(struct work_struct *work)
 			continue;
 		}
 
-		cxl_handle_proto_error(pdev, wd.severity);
+		cxl_handle_proto_error(pdev, port, dport, wd.severity);
 	}
 }
 
-- 
2.53.0


[..]
> +int cxl_ras_init(void)
> +{
> +	if (cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work))
> +		pr_err("Failed to initialize CXL RAS CPER\n");
> +
> +	cxl_register_proto_err_work(&cxl_proto_err_work);
> +
> +	return 0;
> +}
> +
> +void cxl_ras_exit(void)
> +{
> +	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
> +	cxl_unregister_proto_err_work();
> +}

The asymmetry in the above is unwanted. It arises from trying to make
cxl_cper_[un]register_prot_err_work() needlessly generic for any
potential consumer.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8479c2e1f74f..2c4bad5ad2b1 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2246,6 +2246,7 @@ void pcie_clear_device_status(struct pci_dev *dev)
>  	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
>  	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
>  }
> +EXPORT_SYMBOL_NS_GPL(pcie_clear_device_status, "CXL");
>  #endif

Similarly, there is no need to tolerate any consumer but the cxl_core for
this export.

---
 include/cxl/event.h      | 10 ++++------
 drivers/acpi/apei/ghes.c | 23 +++++++++--------------
 drivers/cxl/core/ras.c   |  6 ++----
 drivers/pci/pci.c        |  2 +-
 4 files changed, 16 insertions(+), 25 deletions(-)

diff --git a/include/cxl/event.h b/include/cxl/event.h
index ff97fea718d2..86f9b0b5b635 100644
--- a/include/cxl/event.h
+++ b/include/cxl/event.h
@@ -289,8 +289,8 @@ struct cxl_cper_prot_err_work_data {
 int cxl_cper_register_work(struct work_struct *work);
 int cxl_cper_unregister_work(struct work_struct *work);
 int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd);
-int cxl_cper_register_prot_err_work(struct work_struct *work);
-int cxl_cper_unregister_prot_err_work(struct work_struct *work);
+void cxl_cper_register_prot_err_work(struct work_struct *work);
+void cxl_cper_unregister_prot_err_work(void);
 int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data *wd);
 #else
 static inline int cxl_cper_register_work(struct work_struct *work)
@@ -310,13 +310,11 @@ static inline int cxl_cper_register_prot_err_work(struct work_struct *work)
 {
 	return 0;
 }
-static inline int cxl_cper_unregister_prot_err_work(struct work_struct *work)
+static inline void cxl_cper_unregister_prot_err_work(struct work_struct *work)
 {
-	return 0;
 }
-static inline int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data *wd)
+static inline void cxl_cper_prot_err_kfifo_get(void)
 {
-	return 0;
 }
 #endif
 
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index de935e0e1dcf..11432374b364 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -760,37 +760,32 @@ static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
 #endif
 }
 
-int cxl_cper_register_prot_err_work(struct work_struct *work)
+void cxl_cper_register_prot_err_work(struct work_struct *work)
 {
-	if (cxl_cper_prot_err_work)
-		return -EINVAL;
-
 	guard(spinlock)(&cxl_cper_prot_err_work_lock);
 	cxl_cper_prot_err_work = work;
-	return 0;
 }
-EXPORT_SYMBOL_NS_GPL(cxl_cper_register_prot_err_work, "CXL");
+EXPORT_SYMBOL_FOR_MODULES(cxl_cper_register_prot_err_work, "cxl_core");
 
-int cxl_cper_unregister_prot_err_work(struct work_struct *work)
+void cxl_cper_unregister_prot_err_work(void)
 {
-	if (cxl_cper_prot_err_work != work)
-		return -EINVAL;
+	struct work_struct *work;
 
 	spin_lock(&cxl_cper_prot_err_work_lock);
+	work = cxl_cper_prot_err_work;
 	cxl_cper_prot_err_work = NULL;
 	spin_unlock(&cxl_cper_prot_err_work_lock);
 
-	cancel_work_sync(work);
-
-	return 0;
+	if (work)
+		cancel_work_sync(work);
 }
-EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_prot_err_work, "CXL");
+EXPORT_SYMBOL_FOR_MODULES(cxl_cper_unregister_prot_err_work, "cxl_core");
 
 int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data *wd)
 {
 	return kfifo_get(&cxl_cper_prot_err_fifo, wd);
 }
-EXPORT_SYMBOL_NS_GPL(cxl_cper_prot_err_kfifo_get, "CXL");
+EXPORT_SYMBOL_FOR_MODULES(cxl_cper_prot_err_kfifo_get, "cxl_core");
 
 /* Room for 8 entries for each of the 4 event log queues */
 #define CXL_CPER_FIFO_DEPTH 32
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 3c503ae870df..b6fb6e2925f2 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -437,9 +437,7 @@ static DECLARE_WORK(cxl_proto_err_work, cxl_proto_err_work_fn);
 
 int cxl_ras_init(void)
 {
-	if (cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work))
-		pr_err("Failed to initialize CXL RAS CPER\n");
-
+	cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
 	cxl_register_proto_err_work(&cxl_proto_err_work);
 
 	return 0;
@@ -447,6 +445,6 @@ int cxl_ras_init(void)
 
 void cxl_ras_exit(void)
 {
-	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
+	cxl_cper_unregister_prot_err_work();
 	cxl_unregister_proto_err_work();
 }
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 2c4bad5ad2b1..1bb59b0f96e8 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2246,7 +2246,7 @@ void pcie_clear_device_status(struct pci_dev *dev)
 	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
 	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
 }
-EXPORT_SYMBOL_NS_GPL(pcie_clear_device_status, "CXL");
+EXPORT_SYMBOL_FOR_MODULES(pcie_clear_device_status, "cxl_core");
 #endif
 
 /**
-- 
2.53.0

[..]
> diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
> index ebca1112652a..818ec0d0a012 100644
> --- a/drivers/pci/pcie/aer_cxl_vh.c
> +++ b/drivers/pci/pcie/aer_cxl_vh.c
> @@ -33,7 +33,10 @@ bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
>  	if (!info || !info->is_cxl)
>  		return false;
>  
> -	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
> +	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
> +	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT) &&
> +	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_UPSTREAM) &&
> +	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM))

Is this really necessary? If for some reason someone is able to get
info->is_cxl set on a PCIe device of type PCI_EXP_TYPE_PCI_BRIDGE, what
breaks? For example, find_cxl_port_by_dev() fails gracefully.
