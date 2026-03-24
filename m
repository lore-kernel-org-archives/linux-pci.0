Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EBC386564
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 02:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774318957; cv=fail; b=LAPmLGL060BDVEtaqcgjSlzXH7mvDQYcxbOt1SO6uY4WLR8Ot2ShqImXCb7hxJQ8uFyW6MCXQuiKs6vYTf5w+Ca6wKtUaIKupIDQE9u+axGkhgFmjkjl60GFLszG4bA9G+gKuEg1vg2FAwgCtctk5f7xamEoxURd2WnSEBnzRro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774318957; c=relaxed/simple;
	bh=bdf78w8REJzoOnQMRKPQW+/W/BHbiftFu1P0jD0KO1Q=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=nHmr0SDhz28X9P2anmw4H7Z/W4ySFVsOfy99oKOhjXd6arYYeyl8/n0IhXP0o7QkpFesOYERPdolZ5P3FZGum+Y24CHOWPFAfvCpfwJJG1aEQy2XV9EbTDNu5YBmqvmg9de2c2ajEY+ZoD3VE/qRTogxL1HPl5i7iFDDvcHvu94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MvLHwLP8; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MvLHwLP8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774318954; x=1805854954;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=bdf78w8REJzoOnQMRKPQW+/W/BHbiftFu1P0jD0KO1Q=;
  b=MvLHwLP8llCoA6uHR1mKgpmsaT4AsUMi5YSBMHD3Ul086C/nlooUgXXj
   kZ5JdlwsdqPhZY9ix4/qXwQUhyuhtLc7mnT3OxcDo5/ZCFF30EViylB22
   XcEkEyvRr9REI6vvHfh/XrlMrLpXtD8Oao4sa2SOZSA+ULipdNJfW5MN6
   hQA04nFZHoFPVXMr88sAIkQ6J7zSZuHSVZDTnivGhw+VVxw3i0qFl2Kba
   QURvhjwmYnb4h+5R14Y/SDS6sWyMuWhL3mchYziAHIVKSgYgu/SDwJwt5
   /AuvJ832NF18fUWQX86DYX9YiHFaLQNL+Kg0Ym3JZtv87lgqbY/gPni6B
   Q==;
X-CSE-ConnectionGUID: ANwA1RTbTiOuo8nFpOvFbA==
X-CSE-MsgGUID: xtw+xndbT9Cvx2ZCBFCqQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75446896"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="75446896"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 19:22:32 -0700
X-CSE-ConnectionGUID: hCbHFC3zTYCnQlaxgyRWBQ==
X-CSE-MsgGUID: 89hzJKf5TvGeLcOu75NTag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="219793967"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 19:18:29 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 19:18:28 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 23 Mar 2026 19:18:28 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.61) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 19:18:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RwResHNL74+zCQexDL6sxk//qv8Ivh55ofr97w82VuTYSwfIn+/xvDVZ5OdS7FlzFQl58GTF/K5pbBacNNUgNzX6WPR2YHM6KbwsEOPLLghc3vztgzYW7geOIpaNfqR7SCHiFLqqwf7vNhJzPD9jg3vYZQl6x/KypXgs2sYXj6YKY3sRGGjgkOooYsx3vobl0B3pHbCLRcFQPbM+Wc7d1Bfy4L8RvbWNTmJzk9fDp3pNopLnLNhRYi7IDitYX21EwVTsaSi1Q1kW44mqh/xeB8uOZ6hJu5yQ4MzK0aldUWbLIL2Ohcrtb5fBOfaQRYPsNaLapdeC5NKgdFKM3R5pRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jc7jCa3jj/LEcv/T7VkKO/Wbd3HZWphDPVPGsdVQCsc=;
 b=hDdIsbEpEz9zWx948zO5mdBtfmSDj+NTuPKbCq9PStP+mpyIC3h+Ga7TM1G89cysjZIiDRofk/Ooyc8UDX+flECz3LJqdDJTQmhseQwabsrBVpK3whYcD8L1UW+LAec6zPkIJPP/ke40rT4B1H9beNBgykUNQvFet8YG7UoPWVpKv07UIHf1fQ57tKisgx6VH4gEOOx/pSUFjNKGlcaZ1H/B1C/WgNJxXfQ5z35E8PEBichT1EhfazcUSu8DHNkDi74OxLZ3d+QNmqe8al4V5KjwPI14W4Ue+req/O1ejl0Y7xOedQT5JuyvZZ5YuKb0ycz7tbqexF6kU2qxxe/WxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB7616.namprd11.prod.outlook.com (2603:10b6:510:26d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 02:18:20 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 02:18:20 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 23 Mar 2026 19:18:17 -0700
To: Jason Gunthorpe <jgg@nvidia.com>, Dan Williams <dan.j.williams@intel.com>
CC: Greg KH <gregkh@linuxfoundation.org>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <aik@amd.com>, <aneesh.kumar@kernel.org>,
	<yilun.xu@linux.intel.com>, <bhelgaas@google.com>, <alistair23@gmail.com>,
	<lukas@wunner.de>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Roman Kisel
	<romank@linux.microsoft.com>, Samuel Ortiz <sameo@rivosinc.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Message-ID: <69c1f469f2814_51621100bc@dwillia2-mobl4.notmuch>
In-Reply-To: <20260323181413.GP7340@nvidia.com>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-4-dan.j.williams@intel.com>
 <2026031230-mastiff-create-7593@gregkh>
 <69b38e7427a61_b2b610073@dwillia2-mobl4.notmuch>
 <20260313133235.GC1586734@nvidia.com>
 <69b46bd7935d9_b2b6100b7@dwillia2-mobl4.notmuch>
 <20260313202421.GG1586734@nvidia.com>
 <69b4baab2b950_b2b610013@dwillia2-mobl4.notmuch>
 <20260323181413.GP7340@nvidia.com>
Subject: Re: [PATCH v2 03/19] device core: Introduce confidential device
 acceptance
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0295.namprd03.prod.outlook.com
 (2603:10b6:303:b5::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB7616:EE_
X-MS-Office365-Filtering-Correlation-Id: ea8fd708-6de3-45a0-c388-08de894b9e19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 723qYI7QHiE7pP1kr3G0V1F6H/iTCBk7HZYDUl09PZZHJftUMZQHKEFFDrlxR7AewPTQE5mPzekgMfY3044e71sIhp4dDskYXUMsNNJe3IZTLePwPDGoavqXZfGlnMM742HiqhBv21wZ3MPSmXBallhDUavyX6PuO02d7FGASa6QSkG6ERCm58rZowjQ8KOsmQ1jmDnu+VynrtQk03pyHn2ON/EhVrAObVbhuoO51o/wzAWMWj34KiNyZImc3fcvezp3nFOnjnnR7xXaudEI0HaQD+f18sKF8u1YK0leyy0JZwiQNO8EZSsHVsUMLzOpV3SG6XS4dQll5PQ7j/JRWazSE+Z6+kDW83sABfN3GkIkpLFsI5DYJkDnd4+W9QaPMqFwCd3egx5uf0rkNO+8eBDbqKmFgO1OTZL1KZ7EuNTMDp3fHZcQf65toXA0LWJNXYX6qWdw8N7Nsrpyxg1+6Z6IkLyZk1RBx892bwjMyAo0pyTkJbU0RdhGalS6xKwE1L82+PnA+SKqEQWRm6rGNdU72U8cN7pWYP+Cl/exq2tV/moe2Z3K3yTU6/0U2wF0HHP774SnyJOk3yaX17zzPjjM5+kloiMJmWhZCG5klkcsqgxUarKOWievNqJ67mD1B3sQwkBdYKlDh2sRz01CP9asp40pbiQGt7E7V6OuRnnJ3RVKRusD1Vzl/zVbsMPe0ZnCAaqYptQVECXqzmw07/UdNgLygTW/0zg1ZBJVjzE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tngzc3J0VWFXZHUwS1VYWFFweDBTT2FmQXNVZDFHdzgxakJabDRrYzB2Q3Zw?=
 =?utf-8?B?eUFBZVFsbzBnd3AySit4MW9NT2xhVmRkcmJMUGZsMU00ZFdBdkg1alNIcFdC?=
 =?utf-8?B?R3VoZi9FZG1hd2NkeW55KzM0RGJ1WTNRbXd0a285VVVweFB0a21lM2RLckZC?=
 =?utf-8?B?Q0phNWRPbTFiRkFBTkhuR1k2ODlvZFdGYWhnUjhGdGdhdGd4TmU1eUdKVGdF?=
 =?utf-8?B?R00rUDcxcGpOSjUxdXNPYU1qN1Rsdm9CZkx3TEtuZm5KcmU5SzZ1UnRSRDR3?=
 =?utf-8?B?ckQvNGVMQ1JYWHdsUEJva21zbHVSZGh4WksrQkFpMG8rb2ttRk53Z0tXcXRh?=
 =?utf-8?B?cnRzeTEzQzVyWmh2UEEyWkwyeW9CcTJLZUNCMkRhcmh1d3I3V0NhcWJhbmY5?=
 =?utf-8?B?QlNvSFE2Z0l6ME05WjE3MUVlQU9HcnZCeXE3L1FsTDBvc2hvN2Fpa3d0c3Fl?=
 =?utf-8?B?OU5mUjYwYkcwWUlaZTU1UnFjNHp0Y0w0eUwxN0NVTGpRRjh1R1AwdCtWRDda?=
 =?utf-8?B?MWY3emM4UWFjeTc1RDlGeGFEM3JFN2F1ZmxZTG5US3V4YitkdzNLZ0QwQ0dv?=
 =?utf-8?B?L01CYk54U2NLN0REb2JsNW9jNk9sYXE5MDEvRlRZbnc0bmk3YXVkWVFIbThv?=
 =?utf-8?B?OTRoNUs1aERlb3gzalB6Z1VUV0p4N2RFZW53UFQ2N3RuL1BrN2xqbG1RcjBz?=
 =?utf-8?B?c0UwQVRHSEkycXBSMEhpNDFNM2VydVlYVHppSHFGWVM4dzlmLzlaZXA1RzRL?=
 =?utf-8?B?b2l4QncyWFBaU3VkUm4rVDdYd00zdWJZQlNudUR1N1RHNXhyQTdocjIxQklX?=
 =?utf-8?B?RklMZitQRGdKNFN3amxyTjZTUGNYOFBSRzBuaERBSyswSWhHNUlsUG1zVFNv?=
 =?utf-8?B?cVRvRVJ0STBOTHBXVTBEWjZqQnRzcVpid2QrSlNiVWFEc3ZqODc3VXdITnBp?=
 =?utf-8?B?bnhxNC9nQmVsQ3JleUhGdUhCNUViQzdFOW5vZEdxL3o3TENQYjVROTFvTHNq?=
 =?utf-8?B?djFtNlNvZDlXaG1va2dvZitaYUxEcllZM0h5cUNCY3NMdjVmdmJzNlZrMU1s?=
 =?utf-8?B?aEYyRU5qL2k4SjJrYjJDd1BhNitnTGZCTk9jNUtaajl6ZnFwYi9MYis3di9Y?=
 =?utf-8?B?RWRaYjduaCt1MGJ0SEMzOE13bFB1aEd2T0Z2RGRySmFkTndKRGtPREtTMmJF?=
 =?utf-8?B?SmEwVlpPTUlnNXMvNFRPdmxkczZXNndjcjRYOXBVQXNXZFA4dExxYzU0NUFV?=
 =?utf-8?B?UVlVZ1l2bzU0QjJkMlFYN1RDVUtobS90SXVtb2Q4MkZQRjd2MHdUbWU5b1Bn?=
 =?utf-8?B?b0dBUStCVzFUNC80V21NejZYaFhidHNYay8zWUt1OUpDMzl5YTFXb3krNG5r?=
 =?utf-8?B?OUtQQmxPcVV1YjdJbTlFN0syQUY5SFhnWDMvOGJvOGNzdjNObFpjbzVFUTJv?=
 =?utf-8?B?RVBNSVk5M0FZZVV1aEpUZDBXeHM1bU5KZ2tlcG56Q2EzTnRpSVB5UjlxenRu?=
 =?utf-8?B?bUIwZitzVHczbnlaYkxEVG43M3dlcW1jOER3MEdYOGZaWklJRGlXZFY1WDJm?=
 =?utf-8?B?TVJYNXgvc0daMmtQT3lDM2ticDlKSjVuZjFtUU5iNHZxcTU5NHY2cTRUVmZY?=
 =?utf-8?B?d1JGak5JeUhWV2Q5Smp6TFI5U2JQMG1ERFdJcEwvQ0pEOVIzSnFMSnRYaGhJ?=
 =?utf-8?B?OEI0ZVRBTTZZS3NlVm82OWxOamFzeE9pdDhjVGIyU1d1M29jTGF3ODhYeFlo?=
 =?utf-8?B?cWlPK3hLbjVCaHYwVFRONFZFaWRGTnhWT1FweDUyZjhacVdhZ0hmdytoUDJX?=
 =?utf-8?B?cFBQZ2pnWEt2cThLbSsxV1F5c3M0VEk1Z0w3MU4vdm9KbW9jbUV3UWFxQnJU?=
 =?utf-8?B?eGlCU2pBNDgwNm9ZWlNJQzAraGVlSWFVWjRNQ2tyVVZ1THgzbENZdlpDZjFM?=
 =?utf-8?B?K2p4NmxIbi9tTUJGL2ZFU0J5MG16SW9kbzV2cDdsMlFPUFVOY2N4WVg2RzJQ?=
 =?utf-8?B?RnE3RHFyVjZaYmdXRG5qSlRhK1R0SHl5aTVOdzU5WmR6a1dnSStOQ0l6RzFx?=
 =?utf-8?B?UmY0d0hCbmNjYVl1NjMxNEh4Y2hFMEMySFg3eXpGQXBtNXZTYWRBNDl5WWJ3?=
 =?utf-8?B?Si93ZEJxanVoTHpLdHYyZVo5Y0NoZ1kwVm1hMTMyRllQMnF6RWNvZklHUU9J?=
 =?utf-8?B?N2lRS05HdWxDd1pkQ0RKcTYzV2NBSXlqbU94QXgrd3pjbkU3SGxCZU1ETGY0?=
 =?utf-8?B?UlV6Yk90dXVDNnBWdGJBc2ZOUGRrYlI0VzN0ejhTUkhYbkgwY2lCYjF0T2pz?=
 =?utf-8?B?UUg1VHZnWUl6dVZEOVZxdUdMN0Q4OTc2Mk1VRVF2UDMrb2dvSzkyeElKQ0pG?=
 =?utf-8?Q?vC9YZUUh6kaSLKic=3D?=
X-Exchange-RoutingPolicyChecked: sqfhLVZhZKb2yStklW8Tx69M87UwcTgEm2fv9tD7aSEpynbnJahg3zyB56jhtfh8NtnL0zz2fvIYBYGNfHX2CB2ql8zDUayn3wyXPs4Sa185ZWgWfg4lTYvCjQl6UuNVoTn5OtfLI0/1unn9otViyIAUaFSiXCo0XOTPTUrprqfZoaMfCiA3oEDxNpyX766buJnGfA8Hbga/WS4Y2NyT8tgQXxXHwUxQoz43DAn35IixfbR4UiPVX9ApWwaxepCK3KUUqMpgR0h1/bU5NyznsHdxKZ7bc4lDSRDnVhmrum+sWJhRrDpHDJ5s72JrCSjkxFh12+GcetlQuIwBl1hGog==
X-MS-Exchange-CrossTenant-Network-Message-Id: ea8fd708-6de3-45a0-c388-08de894b9e19
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 02:18:20.5028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yjmIsKFokCBDHeHdGPJnpG3A+q2i0H1sFNWyTqEMt/n3rOEWR+k8TCRojNunXwcSDXF1FPJLdzNF8X3EHhGhbOy4ZYTMkqdWC8vOrgYEQtY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7616
X-OriginatorOrg: intel.com

Jason Gunthorpe wrote:
> On Fri, Mar 13, 2026 at 06:32:27PM -0700, Dan Williams wrote:
> 
> > The problem is that for all the buses that do not currently have a
> > "device authorization" concept only userspace can decide that a device
> > should skip bind by default. For that, I propose module autoprobe policy
> > [1]. Not yet convinced the kernel needs its own per-device "no bind"
> > policy.
> 
> I think it is just part of the broader definition of the level that
> extends into the iommu and so on. It makes sense to have this kind of
> no-binding security level, IMHO.

Easy to include for completeness.

In a CC VM userspace can set "$module autoprobe=0" to get a control
point to set @trust to zero, but @trust otherwise defaults to 1. This
allows for userspace policy to generically distrust devices, but without
needing to build a new mechanism to specify which devices start life at
trust == 0 (i.e.  "device filter" proposal previously NAK'd).

> > > The DMA API just wants a flag in the struct device that says if the
> > > device can access encrypted memory or only decrypted.
> > 
> > You mean separate "trusted to access private" and "currently enabled to
> > access private" properties? I am trying to think of a situation where
> > "dev->trust >= 3" and a flag saying "disable bouncing for encrypted
> > memory" would ever disagree.
> 
> I'm steering the trust level toward more of an acceptance criteria.
> If the trust level is you have access to private memory but the device
> can't actually do that then fail the trust level change.
> 
> Same for the reverse, if the trust level says no private memory and the
> device is T=1 then fail the trust level change.

Ok, so the uapi for PCI/TDISP would be:

echo $tsm > $pdev/tsm/lock
<gather evidence, validate with relying party>
echo 3 > $pdev/trust

...where that @trust attribute is a generic device semantic, but in the
case of PCI device connected to a given TSM it invokes the TSM hypercall
to transition the device to the RUN state and the TSM local call to
unblock DMA to private memory.

So, userspace can generically understand what privileges come with which
trust levels, but the mechanism to get those privileges remains bus
specific.

> > That bit though has lock-to-run consistency expectations. So if the
> > kernel does not yet fully trust the device by time the relying party is
> > satisfied, and the uAPI to transition the device into the TCB (level 3)
> > is driver-core generic it raises TOCTOU issues in my mind. The
> > driver-core would need to ask the bus "user now trusts this device, do
> > you?".
> 
> Huh? No, there is no concept of trust in the kernel. The userspace
> setting level 3 is "I now ack that this device is trusted", there is
> no further trust cross check. If TSM side says it is in RUN/T=1 then
> we are done.

Ok, so maybe I misunderstood your point. Per the above, if the trust
setting is what kicks the bus to finalize T=1 then it makes sense. If
that kick fails, the user's trust setting request fails.

What I expect is unwanted / surprising is device has already been
transitioned to T=1 state ahead of the trust setting, it is a
synchronous mechanism.

> If we fall out of RUN then the level auto-resets back to 0 and
> userspace has to go around and fix it again. (ignoring driver RAS)

Yes, at the moment that the bus detects that an event like SPDM session
loss, IDE link loss, TDISP ERROR state entry has occurred it can
downgrade trust and notify. That notification fits well with netlink
because all of those events are downstream of evidence validation.

> > Aneesh and I are currently debating on Discord whether the kernel needs
> > to protect against guest userspace confusing itself. 
> 
> Userspace that controls acceptance must be part of the TCB or the
> whole model is fully broken. If your guest userspace is so security
> broken it can accept devices it doesn't mean to then just forget it.

Agree, it is a non-problem. If guest userspace confuses itself by racing
sysfs operations then the relying party should not trust that userspace.

> > However, to Aneesh's point we could protect against that with a
> > transactional uAPI like netlink that can express "trust if and only if
> > the device has not been relocked before final accept" by passing a
> > cookie obtained at lock to accept. That would be awkward to coordinate
> > with driver-core generic uAPI for trust.
> 
> You could, but why make it so complicated? The whole LOCKED/RUN thing
> is already supposed to deal with TOCTOU, doesn't it?

Right, the threat vector is the guest accepting something it has had no
chance to validate. Guest userspace confusion is not that. Guest
userspace asking the device to be re-locked in a way that confuses an
ongoing evidence validation sequence in another thread is a "you get to
keep the pieces" event.

> The CSP cannot trick a device to fall out of LOCKED an the re-enter
> LOCKED without the VM knowing.
> 
> The VM attacking itself on something as security critical as device
> accepance can't be in scope :\

The complication vs benefit tradeoff is indeed not mathing, but wanted
to do justice to Aneesh's proposal and the suitability of the sysfs
uapi.

> > > This way nothing is coupled and the kernel can offer all kinds of
> > > different uAPI for device verification. Userspaces picks the
> > > appropriate one and acks it with the level change.
> > 
> > Thunderbolt already has authorized uAPI. I expect adding dev->trust
> > support to thunderbolt is more related to ATS privilege and private
> > memory privilege.
> 
> It brings it into the whole 'measure the device and then decide what
> to do with it' framework. The trust level is still the generic ack
> that the device is allowed the participate in the system with whatever
> level of security.

Some thought experiments to confirm alignment...

'Generic ack' is a synchronous mechanism for the bus to evaluate. So if
@trust appears for any device, and by consequence alongside @authorized
for a thunderbolt device, it should be the case that these operations
are equivalent:

# echo 1 > $dev/trust
# echo 1 > $dev/authorized

...and the result is cross-reflected for comptability:

# echo 1 > $dev/trust
# cat $dev/authorized
1

Consequently this:

# echo 2 > $dev/trust

...would be equivalent to authorizing the device and unblocking ATS (if
such a thing existed).

For bare metal PCI device security the TSM 'connection' needs to be
established in order to enable device evidence collection.

echo $tsm > $pdev/tsm/connect
<validate device evidence>
echo 2 > $pdev/trust

Now, I question whether 5 trust levels instead of 4. This would be to
explicitly only trust devices where the TSM has established physical
link encryption, or the TSM has asserted that the link is protected by
other means. So the trust levels are:

0 disconnected: bus does not attach drivers
1 limited: core code deploys hostile device mitigations like disable
           ATS, CC force shared memory bouncing.
2 DMA: full DMA access, driver responsible for protecting against
       adverarial devices.
3 Link: mitigations against physical integrity and snooping attacks
        deployed
4 TCB: full device interface validation via a protocol like TDISP,
       CC private memory access granted.

Where the native Rust library based SPDM driver only offers trust level
2, bare metal TSMs can support trust level 3, and the TSM interfaces in
CC VMs can support trust level 4. I could see squashing 2 and 3 and
making it a documentation problem to understand the capabilities of the
various TSM drivers.
