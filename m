Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA1D23B61B;
	Wed, 20 May 2026 13:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779282271; cv=fail; b=l6rn8cStfNSZxLfUNib9jDtYv/wOzhnkV+Wk2XsRq58LxivnmvFIl6bvAhc7FyxC6tRUYj/dYic0QMrfggYMyBv+lIsJ4ng8Jx7WfIiDojpKHZHBYKo5U6nk1xzuYwFH5dub3sSB2DXh+ZnKdbYlMT4EZ71Mvvw7xg/7nC/XnSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779282271; c=relaxed/simple;
	bh=PP2VqOFUo3U4+tB741dkWlrK+ykS/5pPFuA0d5uetSI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SoG3C1tSXAJguW65WxAlfKgH81ujRh4UA50pQNra7pCf3KNSFSEyPztl8DylsHWiWUneqCDZ8siZNtesMfEHVemjh7Nzg5Ggh909AzPo6zBbv3I2XRn3DZBnzrnAAkCibA46f4z0eJdmY8PBKP//EJfkzFKUejvi8lhH8z7zjOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RSDzst0+; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RSDzst0+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779282269; x=1810818269;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PP2VqOFUo3U4+tB741dkWlrK+ykS/5pPFuA0d5uetSI=;
  b=RSDzst0+KdyLS/49yMY9gy6cR0g1FYsjv8ZNT8x3dg1zggl60xUUK8ML
   CWWw4d1zSsgol9uAVsqYfLKQ3SA8+AiRN2Fh7Hf3I4RyvZDwFTPBQeMdn
   OMEOIa2EMzJYbOpG4BnPIYC+ttKYnjmHmI0sh2TXg6n02LZ2DRyffLwwE
   BCXu1GGMIlltWvF78HTb9b01Kd4htYuPSzhqhlP1J3Pspf+C+uuirPUIg
   cz4o5LgDBb03EAquXjLN3fJCaeT0z0KHpqF/UkmCW5/XA/NewKlaf6xrV
   bL1JDIbtg7AO6OeCMjNcm7/DN2fS8NuQsFw68W5sfADjss8qjqWqw0cvZ
   g==;
X-CSE-ConnectionGUID: TIR4G6S5R4OHW6IReABJsw==
X-CSE-MsgGUID: Cf5KVSz0StqImoklfeE/pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="90755165"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="90755165"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:04:28 -0700
X-CSE-ConnectionGUID: ViUowP4tThKk8tiIX6D1Nw==
X-CSE-MsgGUID: 50aRtqj3TgOMXPcEBv4YZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="241984273"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:04:27 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 06:04:27 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 06:04:27 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.31)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 06:04:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kLYUwiZzq07mTB9xu5uFpRHA0DY1F+i5MRqB1/QAXoXtc7TlJaLXJnxElKDfdNIVz3aPVrLChulwjAPz0PVjfIb8uwxuKdiTajrPrK5GLzYG+mXILPklE1tbeUnO1d5mm9TcyqU4DJoYsK+P9Rqg3otpPkPi/siIfe8hW/XhBtQNxp6pXMJvQrScmAu7a8m/VKxDZ+FsHAyT+1zZwk7CWyyi6bPmV97SDqYILj5BKcZgxL/sTAAMGJptEvItM7PE/Szs+kv63Za3CgS1C8kbBCGno2i9fSjEpzWuo7BZRL6u1UABUg2xenOUkHLVY6GjE5k+omD/6zj1I9LMyaOCTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5BertsErcOZ4NtJHX+Ny1VQdLQYQnVLfEZBuZGlEBU=;
 b=enlmwEuQBdiJFuG+3sFUfPAQ122lmRx8ki/rK8oNL0S9uGNIP6XMQM12u6SCHPT4KwCdzQzp0IYtRb2GxjkObCB4uvU5gRXs2PShg6lC5W8W2ZLUTpJ6FoOhAfIyjVXwIW55sdJYAFrH0PUQkHzyXD2Y3KGZNy/NWjrNT9wA5GhLmJa+ZFsKmE0Feho/JZ+NBTn4cIEq3hxWuJoTthoKL/UTPkDMyqxHoOj5RCEHvGsyjRyTW9CfmC8uQPg4dQNc1I2LRrtizR0xB7IsmK5hnNCHRpnbHOqWKydpcG5bVkFzy7zt85+LuWt8JLQ6+RB584GhB2WT+Wu92jCVCUv+sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by MN0PR11MB6134.namprd11.prod.outlook.com (2603:10b6:208:3ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Wed, 20 May
 2026 13:04:24 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.21.0025.022; Wed, 20 May 2026
 13:04:24 +0000
Message-ID: <e8337102-aecd-48e8-9a2d-10f41ed43c5b@intel.com>
Date: Wed, 20 May 2026 21:12:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
To: Nicolin Chen <nicolinc@nvidia.com>, <jgg@nvidia.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <bhelgaas@google.com>
CC: <joro@8bytes.org>, <praan@google.com>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <miko.lenczewski@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<vsethi@nvidia.com>, <linux-cxl@vger.kernel.org>, <nirmoyd@nvidia.com>
References: <cover.1777269009.git.nicolinc@nvidia.com>
 <f6734b9dad0050138676f11ecd14e9db1cf6b697.1777269009.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <f6734b9dad0050138676f11ecd14e9db1cf6b697.1777269009.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0030.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::15) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|MN0PR11MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e284111-7c8c-4e49-e344-08deb670508f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|42112799006|1800799024|376014|366016|7416014|11063799006|5023799004|22082099003|4143699003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: BzxxO34EURM8sBfLGQYQGd6giAkzlsiZqODnpclzcJD1k5ENg4a7KnWMPD6EMIk77TjE2B2p2fjGTNXYiva0QsZI48oLrwjPYjUrvi6F9K96LAmeAkK1DFYCmJalwycektzr7xCPC+cuvAesQ2WDXSMpOUkDQUEg6yV2/dbcDtjckSq62y7LxzPtplTMleN/g6nfy/VgV9tdiTC5mHbZ4Ll37JEzqOifOuvzbHAgL05NYeHCtJyKfwRes5N5r10SeukUC5h919RsvPTu3DcDOLpmtCCcHYzp9mRRC0b7aO43X62Mlmj/uTK+hTwSPs0XKAXfuGWrdB6AMowCBCMRvpBHti5MEv6IuE1xQ+djQKCQuGTF6K1RnoHT2czv4zApCCARZjD94/DjpJohi7xwmbrbJH6b0RxNRMoyJkEH4js98cB6M9GtWleDM7boc4w3jnU8aOO0kbVczDYDp8bJ5aDXmEOLhBbu6x2mmzABCEn06jUoIxVmzWbWRIiD8wLAbMFOaysd9Z+hKSl166T8LbGgnFAUie9Y8qi4rldaiV/l6ZbPIJ/6BgPyFjy8hXLNofPTU+gHkUqukk7OIpFx0ErWq6Lwbx8lBuptMZiIU77DZ5uFUQXvvWAr3Hwd3u3j6foaqv6/fC+sxIE9Uhqw0Z/pvlsKZ2sReDcPIx511zC1tFcbtiCbe3Nf5mphgDQ0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8509.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(42112799006)(1800799024)(376014)(366016)(7416014)(11063799006)(5023799004)(22082099003)(4143699003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmRiY3NpN1gyVm8zNlJQOWd5TG83ZXJyelc2eVJaaU5SK0o5eFdOZTN0c1Fk?=
 =?utf-8?B?NjFCREVlUUhIb1BJbnlkSlNaQUlCUURnemIrMmhpRDY3SkFJb1V3MXkvc3RJ?=
 =?utf-8?B?a1dKTVNNbjlUWmQ5dHF6Mkg0R1FsZ0lFSm1tRktxdENrOTFYNm5yemtqZll2?=
 =?utf-8?B?YUhwUWYwRG9kcnJuMnd6dXpBa1NmdGptVjlIRnpwVEhYUjJZTEpPSkVxbkc4?=
 =?utf-8?B?NEZXMHMzTi96TityVWE3RzdQbEczS1JVSVoxNHFnWGFUWVplK3FzOERBVk9R?=
 =?utf-8?B?VEcrSWpTQW9FUTJrelAxakM1NzVYQUJZV3lydE45NmhPeDhxOHkvRjZPMDJ1?=
 =?utf-8?B?TzRvUXR4SW5ucStUQ2w2aDFESE5hRmJRdWZwbHRIQTFwbWpxWjBxQmRSQU5v?=
 =?utf-8?B?S28vaFBOMXBpUTZkaGJjaFJQSTA0QVFrNWhNRi9SbzJGUGVaN2M0MHVmTnpM?=
 =?utf-8?B?YklJNWZCNWtFN3o2cnMxcGJBL1ZmR25neEhQR0JSaXZxN3hCR1JmSm8wcmFl?=
 =?utf-8?B?WTl5MTVIVWNmY2lCMG0xaGxQdThmbmE1TlZPQ2JuWmd4MzB2K3VxSUFWUjdn?=
 =?utf-8?B?bzczRlA0MGkxbDBzdU1FbnNMRk1DTW9DY0o0NFNiRmdES2JiU0IzdFBaRnZ4?=
 =?utf-8?B?Y3hxVDZmd0JzMjNnbVRqQ29GZ3VBc1hnU3BTdjgrdHEzcUZNS2Y4YTNXU2N5?=
 =?utf-8?B?NWFxUEQraVlKVndYbWZZRGZsZWtkZlYvcmFrVGJKWUxYbU56UnhUR0N4cEVO?=
 =?utf-8?B?RnZkalJUbUg1aFFJaHNXNkxTVlRUaWFKdTNySXVlU09SVUVSUFBqOXJ4SGY4?=
 =?utf-8?B?akF5S3B4d3BWRDF1OHZ5dUl1UkwyeEgrajhkQWhodDVpUG1mbkxlMVpzQkVO?=
 =?utf-8?B?OXo0eFhQTVhmUElUQmVmblBaL3pnOXREU1VLMEtYUG5vSVZuT3gwdTRGdkx6?=
 =?utf-8?B?bXpVM2FmNmVpWGtaUlZiY040NHZIOFN4Z2tTeEhsanh1amk2czdQc1BBWC82?=
 =?utf-8?B?Y2tlTXdJUUl5dzRHYmNSMExLNEM5anNHcmRlRHMva1Z0VmpTZ2xnK0w3cUFv?=
 =?utf-8?B?VjJaTjN6b2lnNzVKL2FhblFtVjVXa2VXTkxZM3lFT2hyR24raS9GTFgvNzhW?=
 =?utf-8?B?YmZUYWN3aThSSGo1UUpxNjBPZUtXSGlCM0lqSkFHcWlEazU4dkFYN294M2Fi?=
 =?utf-8?B?OVIwUVVNVHVIczNqY29XMWVXaEpiQlh5dGh4WFZiMGdFZDJTc2xYOVRiMk0z?=
 =?utf-8?B?eWR1SEh1VlViWWMwSExZME1pR1lLeGxIMHZaUEI4YlFOaVdFOG9aUW54dE1R?=
 =?utf-8?B?SXk3MlhEd29JdlFpNTlvVUkrRHQ1S3hNcXNEUEpWODJQamlycm5KdEgvcXdL?=
 =?utf-8?B?aHJKRlRIME9BL1ArZWttSWZyY2pDbVBVc2c2OVBlSnBUSkdTVEdZaG92SG5Q?=
 =?utf-8?B?WDdkM084MG1JdmRZRDFTa3g1VG0yZElZb05aRXpsTTRaR2tSdVNvbzRDMnk5?=
 =?utf-8?B?YTN1UmhWZjdWeGlpdTI4dlpBUFlYUElOcGJSMWlNQkovRTFrdzF3N0lzQTBU?=
 =?utf-8?B?UW5QcEs0OXRNbktxSnBBS0ltY2JhQmpGRnVxaDUyOFJ2MEtEbzFUMGdvTWRm?=
 =?utf-8?B?OEY1Ym1wZlZGWW16S1JyS1RoR0ozNVBqVFIvYzNhWHlXZGRNWWZydkNqbGY3?=
 =?utf-8?B?N01tY1pUVng4bW5iYllyM0tyOENQRFBjZGtyendGblFwR0NZWjNrbndmR0hK?=
 =?utf-8?B?T2t4R3dOZDNDbEplNEo3bTVGUlVMczVUVWFZNVNLUElYY1JyMWFtT1I1VE1G?=
 =?utf-8?B?NGZzeExEVCtoeFBmNm40U1dHWkloSkxYNThiTGVlcXdTY0ZXQ0F4N25XZHdB?=
 =?utf-8?B?VXFDbk1NZGk1b00vdDJSbC9zM25yN2dyaW5OdGJmZVNHUWIxUXRpakYweUQx?=
 =?utf-8?B?Szk3RTNUdjg5dVRuQ0V0WCtyNnUveDJnalhNZk9uOWEwWWJrREdibkc2QVh2?=
 =?utf-8?B?WGtSYnVWdG9wR1kzYU9VR2dCRml1QzF5STB6QTRwQjhIdHFPN2EyeVBRWTlK?=
 =?utf-8?B?WnJYMzdlVmdHZlJWd29PdlJWeFIyVzNmYUdaREFmZytNQ2I3OHJsT2Z3TWF6?=
 =?utf-8?B?dzgxd0tEQXNZWW1SUkxreERDQUdFY1l3ekFLZ0RFQjNMUitRS29XV0hqZWd6?=
 =?utf-8?B?SE95KzhhT1A1dzZkRUVhaFFPcnJxcGsrRDFPTjJoNzFWVEU0V01kRXdMdDVI?=
 =?utf-8?B?bTY0b3JWQmprQzM0SExzTkVmdkNRS2d2YUNoV3QxaTNDM3ZtMUltRGlpZEl2?=
 =?utf-8?B?REwvU2dJUWltR3dGekRZTWpKVU4zcS84cEY4TUNOUVFlMmx3ZUR5QT09?=
X-Exchange-RoutingPolicyChecked: vmaYb5fsLjeyiNt1LdkpqVsLsNe99lEUGU7wTOBvEG68S0UhQnFqFx0rtTVmrhHKEMX6htvvDImA8bUlTzq0kpwUhDAy0qIIexW63Op2TPFmQsaJfXp1DFSHdiQCxhm2R65rdL3OAGmRqL4WpH/5ly2oUsbf3xi3XNufFK/fG9JvfQF2DIqWYI4FSIc027juGRFToD0PsI/6V7ZQiV/Z2Fyt6B8QcHzzk7dskHS3pABt6tOo/ky3BZlUy40XRqZ7ut0vp1lliyR27ypLxt52nq4yG7wHbbTQumBB5+VfU1Q3U5yz3fdbz9zjPcVc7INHk7FT6qLANoKz97nfYmFL0g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e284111-7c8c-4e49-e344-08deb670508f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 13:04:24.0544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /bhwaOTBG/gproVfp31DiWWN+mJkn1xzZ9e7c8tkeU7lDHlHzEkEM32wZvKK4S0axxpuCFM/gkOUo3jtu5J06g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6134
X-OriginatorOrg: intel.com

On 4/27/26 13:54, Nicolin Chen wrote:
> Controlled by the IOMMU driver, ATS is usually enabled "on demand" when a
> given PASID on a device is attached to an I/O page table. This is working
> even when a device has no translation on its RID (i.e., the RID is IOMMU
> bypassed).

nit: this description seems not accurate. Intel iommu driver enables ATS
in the probe_device() phase. mind tweak a bit to avoid misleading
message. :)

> However, certain PCIe devices require non-PASID ATS on their RID even when
> the RID is IOMMU bypassed. Call this "always on".
> 
> For example, CXL spec r4.0 notes in sec 3.2.5.13 Memory Type on CXL.cache:
>   "To source requests on CXL.cache, devices need to get the Host Physical
>    Address (HPA) from the Host by means of an ATS request on CXL.io."
> 
> In other words, the CXL.cache capability requires ATS; otherwise, it can't
> access host physical memory.
> 
> Introduce a new pci_ats_always_on() helper for the IOMMU driver to scan a
> PCI device and shift ATS policies between "on demand" and "always on".
> 
> Add the support for CXL.cache devices first. Pre-CXL devices will be added
> in quirks.c file.
> 
> Note that pci_ats_always_on() validates against pci_ats_supported(), so we
> ensure that untrusted devices (e.g. external ports) will not be always on.
> This maintains the existing ATS security policy regarding potential side-
> channel attacks via ATS.
> 

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> Cc: linux-cxl@vger.kernel.org
> Suggested-by: Vikram Sethi <vsethi@nvidia.com>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Tested-by: Nirmoy Das <nirmoyd@nvidia.com>
> Acked-by: Nirmoy Das <nirmoyd@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   include/linux/pci-ats.h       |  3 +++
>   include/uapi/linux/pci_regs.h |  1 +
>   drivers/pci/ats.c             | 43 +++++++++++++++++++++++++++++++++++
>   3 files changed, 47 insertions(+)
> 
> diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
> index 75c6c86cf09dc..d14ba727d38b3 100644
> --- a/include/linux/pci-ats.h
> +++ b/include/linux/pci-ats.h
> @@ -12,6 +12,7 @@ int pci_prepare_ats(struct pci_dev *dev, int ps);
>   void pci_disable_ats(struct pci_dev *dev);
>   int pci_ats_queue_depth(struct pci_dev *dev);
>   int pci_ats_page_aligned(struct pci_dev *dev);
> +bool pci_ats_always_on(struct pci_dev *dev);
>   #else /* CONFIG_PCI_ATS */
>   static inline bool pci_ats_supported(struct pci_dev *d)
>   { return false; }
> @@ -24,6 +25,8 @@ static inline int pci_ats_queue_depth(struct pci_dev *d)
>   { return -ENODEV; }
>   static inline int pci_ats_page_aligned(struct pci_dev *dev)
>   { return 0; }
> +static inline bool pci_ats_always_on(struct pci_dev *dev)
> +{ return false; }
>   #endif /* CONFIG_PCI_ATS */
>   
>   #ifdef CONFIG_PCI_PRI
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 14f634ab9350d..6ac45be1008b8 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1349,6 +1349,7 @@
>   /* CXL r4.0, 8.1.3: PCIe DVSEC for CXL Device */
>   #define PCI_DVSEC_CXL_DEVICE				0
>   #define  PCI_DVSEC_CXL_CAP				0xA
> +#define   PCI_DVSEC_CXL_CACHE_CAPABLE			_BITUL(0)
>   #define   PCI_DVSEC_CXL_MEM_CAPABLE			_BITUL(2)
>   #define   PCI_DVSEC_CXL_HDM_COUNT			__GENMASK(5, 4)
>   #define  PCI_DVSEC_CXL_CTRL				0xC
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index ec6c8dbdc5e9c..fc871858b65bc 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -205,6 +205,49 @@ int pci_ats_page_aligned(struct pci_dev *pdev)
>   	return 0;
>   }
>   
> +/*
> + * CXL r4.0, sec 3.2.5.13 Memory Type on CXL.cache notes: to source requests on
> + * CXL.cache, devices need to get the Host Physical Address (HPA) from the Host
> + * by means of an ATS request on CXL.io.
> + *
> + * In other words, CXL.cache devices cannot access host physical memory without
> + * ATS.
> + */
> +static bool pci_cxl_ats_always_on(struct pci_dev *pdev)
> +{
> +	int offset;
> +	u16 cap;
> +
> +	offset = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					   PCI_DVSEC_CXL_DEVICE);
> +	if (!offset)
> +		return false;
> +
> +	if (pci_read_config_word(pdev, offset + PCI_DVSEC_CXL_CAP, &cap))
> +		return false;
> +
> +	return cap & PCI_DVSEC_CXL_CACHE_CAPABLE;
> +}
> +
> +/**
> + * pci_ats_always_on - Whether the PCI device requires ATS to be always enabled
> + * @pdev: the PCI device
> + *
> + * Returns true, if the PCI device requires ATS for basic functional operation.
> + */
> +bool pci_ats_always_on(struct pci_dev *pdev)
> +{
> +	if (pci_ats_disabled() || !pci_ats_supported(pdev))
> +		return false;
> +
> +	/* A VF inherits its PF's requirement for ATS function */
> +	if (pdev->is_virtfn)
> +		pdev = pci_physfn(pdev);
> +
> +	return pci_cxl_ats_always_on(pdev);
> +}
> +EXPORT_SYMBOL_GPL(pci_ats_always_on);
> +
>   #ifdef CONFIG_PCI_PRI
>   void pci_pri_init(struct pci_dev *pdev)
>   {

