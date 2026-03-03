Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3CD3368BF
	for <linux-pci@vger.kernel.org>; Tue,  3 Mar 2026 22:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772575326; cv=fail; b=t3Ujq+GgpuacHGccPzTt8zFIPZdz4YUx/CPgLSkRruxlWv/8ZOVsvK2ghRXjPpx2pNd8lFr1lEfsE44RDOXnxs94eE+ArDz2YOFLPLrfI1xFG9B7EEPJiueBvfYnscWCx2wVLGiMpccyBG6jO5PzcafX5c0l/rNdtaZpIlJy6nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772575326; c=relaxed/simple;
	bh=LeiEOect3/XxlZEwyGhZQZaXJ6GHEqlIlnCFpDrvgPA=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=Sdfx7AtsU3J1YgGEfM4gJJi2UG6xEfx1gj9mLLHPE9lJEnhTr9UaYDrILH1jKWOALmbrOG0H3BhPulLMFuFKA2bbiJrCA+t079SxIFqhNcXpOfO1wJYPJEg43vUxbXkQ57HnKXDZaQAa4VL+69ApwJ7X5eaUZSHD2VhtY0mrwss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hLT7MB2h; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hLT7MB2h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772575324; x=1804111324;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=LeiEOect3/XxlZEwyGhZQZaXJ6GHEqlIlnCFpDrvgPA=;
  b=hLT7MB2hh6yHori4QeOFdVYuG5A5+6LFrs80tSagYU7ybVc9IWuhYXa/
   O484aNWC3pAZg3zGVNiv/HAKNJSiKFMiBrrGamF8d+Eymwvq7l56XFnie
   dIbkssmzHGsgPXkk3uQU1XuCUDxycrF7IHKmvWvT83JoZihHpVxWggBqI
   nLnEsL69BNGYbPy/PRU/KAuFiJ6v3OIyYjK4/shBXbMSUvFK22AywKain
   PuKXbHRE0bVcBxlUskROtRKeq+oi+4jnRcekGUaYptmB7G9mPOyyQMUVi
   332I5nwRBa1HvJnOojA5B7yUa9TWZS2o7xWNnVml9TOffKhUGT921eAEd
   Q==;
X-CSE-ConnectionGUID: 72XUXomaTvaX6JM/srqCvg==
X-CSE-MsgGUID: /DLbYBTjQw+X8G5+DUxKGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="72827340"
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="72827340"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 14:02:02 -0800
X-CSE-ConnectionGUID: X77Tr33lSC6ytXmKPWI0VA==
X-CSE-MsgGUID: jw1sDwhETeW/Qe3gRGzZ6Q==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 14:02:02 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 3 Mar 2026 14:02:02 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 3 Mar 2026 14:02:02 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.14) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 3 Mar 2026 14:02:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qji8ZYaSh07BKf47br10F3G/dwsVpry7b//bYF31+9g7a+R9VN4JYc6nTjrt1sxgzh+C9dOPAC5tLN6JH3UsS8sRJiD8wvwibCzZmoA2CiEfR8cG20NxCjedlBlAzEaIWpQDq00tFDErHpNWDEB4PGqz96MVzSnLvVpFCqggnaf4HQSu2OfzyhAqFwwqBdMqocoTDxFQtt2vtw7fve6RNpwpYVdgfKuv7n1g6rAqhzmI6MXnRd8rOc4Yk0HoHwRi4udt0j0dhbSi+xMJ2Uw4VMi2JmmCenliTU8MDkdDi6/UytjAz/FMggaD8BrN2mGNgu4KHLgL9smtMbyBugTHDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZ1b1vVTQdXZcLFyl0YL+Rywal6B2M2R1U02u1R2nFw=;
 b=j46VZm6x7xaN66iQ53jSAKeYG+fjJoz/mLaL493UB269xcQgWoo8KYlQDbJBXq8odWcpNyfMOJfgCFuF6ziCWCccxkYiDB1POJREOmr1XoUh3rcCeiR6b68LpREtRWXryHQADpxvbYUywhmA0w/NfuCRM9L3gjPhJGrj7JAuYmwScRMc3zTqYUiseikRW/3677B0g6rG3o+zFaO7W3VgaoKNFX1NlpsEFeqTuZY++xN5Bj7a9QeYrC8aUBJoRDrNWlOPMtBdcJKQsMXnYNltVGofXVo76wCXbUawQ2mtHVUzeBsJafBy7ftXEzfeNaiyA3R9iGzHY4nEJuyuD1Lhtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH3PPF67C992ECC.namprd11.prod.outlook.com (2603:10b6:518:1::d28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 3 Mar
 2026 22:01:58 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 22:01:58 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 3 Mar 2026 14:01:56 -0800
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <aik@amd.com>, <yilun.xu@linux.intel.com>,
	<bhelgaas@google.com>, <alistair23@gmail.com>, <lukas@wunner.de>,
	<jgg@nvidia.com>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann
	<arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Christoph Hellwig
	<hch@lst.de>, Danilo Krummrich <dakr@kernel.org>, Dave Hansen
	<dave.hansen@linux.intel.com>, Donald Hunter <donald.hunter@gmail.com>, "H.
 Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Luis Chamberlain
	<mcgrof@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, "Peter
 Zijlstra" <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Roman Kisel
	<romank@linux.microsoft.com>, Samuel Ortiz <sameo@rivosinc.com>, "Saravana
 Kannan" <saravanak@google.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thomas Gleixner <tglx@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Message-ID: <69a75a54cbb16_6423c1004f@dwillia2-mobl4.notmuch>
In-Reply-To: <yq5aecm19shr.fsf@kernel.org>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <yq5aecm19shr.fsf@kernel.org>
Subject: Re: [PATCH v2 00/19] PCI/TSM: TEE I/O infrastructure
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH3PPF67C992ECC:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a772e43-f786-426b-50bb-08de79707da6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: o+k8KMhSTQztbVTxeW5+72yNtP8sQhLflFKiJEZP2E2x8ArKNC1grhEwNbLDwhY/ikw/HlCXCHV4iCW2vhGJEsQeJXspTYF8AEObvr4Dh/qKY8T5INDTYV81ULbmRREKUnAQTOIa1TsGZU8kRYjU+aDBKVk/33RFLN8hnoVKenvdGD3DuWMOs+YnsWqj6p6QK3Jr2gvhYxF4K8MxhasO0Qs2NyALxdf2eAi8TZc6tm5GXkvoJpNpf7lmAn/m+3HlzTvuxj5B8d71WqOmhK8SFxYrjgQO5+jMBCeekNn86lzm2XzN7Xlev6MZ7sTi+w4BPrk9Fm8PXPo244x/7SGuUIcaVyyOxI/6XQ/NUII21KifEbXP/d95fZ8V+tW1QyQFM2CAx6ZWVgDtMd7OE2cBT3ROU2m/tEqZRejlM3Wcd6MDzgJEi2ljEZIAF0ncnxnunr/J8w4do5XMxXOIngz5c/w0F486Jmr3RMwApHEWhWX2vt8ZnBOG/fbR2VBPfUWVRMgo9rWIOaDVxeFukAF6hBL1SdS2EvEOTXvcW0odL0PXvqKJzEVELlvy0kBUvu42MOot6E+kq1+HCPQeHWZcELuWsaBge2x7wH76JLccPXXMso6nGPyVuUFrw4osEAvPS7xf/1rNhf4sAGGcXAWO8vqsBWqs31YY42gF3LxL/GjROYxiNJpPzewHqlm+HLEGDZjLwvke8iGuUD7GPChWFgo38pWBKut9fKoVNc+IhNs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGdpKy94MXZ3OGc3Nyt0M3QyNkMwTlBjcEFPZCtqSDl1T3gvU2NGakM3bGhW?=
 =?utf-8?B?MFlaNzdoQVNzZXU1YnJvdTlzdmZab2FyWXVvUDI1M3l1U2x3aWpJQ2NNQkty?=
 =?utf-8?B?bzVLV1lCaGtpOC9LdzViUzU4NnFtR0N3VUt4VXlRMmJZSzZqdndWVnB1Z2g5?=
 =?utf-8?B?SUcvQjRmNGtNOTcrb0cwWW5aSzBsYTA1dVBrVGJ5UDY4N1BLQkl1Z3FxcWJC?=
 =?utf-8?B?d04rd0ordm9nU0tCeDUyNXRBUjNld0lEaXllT0IzakhKRjFBNDFGNTB2VUpS?=
 =?utf-8?B?Y1VCaVVLVm9Uak4rVVF6cmpmdnp6eEtjSnhrc04veUtSc0FPQ0NEbzdhZEFo?=
 =?utf-8?B?dzAzNkpEcGVLUjd3cVhCYzU3TFp5U2t2aHNrSmFxNWV6T0hxWXNCL1dlQ2tH?=
 =?utf-8?B?dkhDTlNTOGkzL3dLcENhZGxwZGIybFJuQjc5ZmJjY3p3VUVEd2hKR0kwQ0tW?=
 =?utf-8?B?b3dqcVJPVjVkY3JhZWdFYzVNZ2V4MHFQdEFKS1c2ZnU4NGdvYVVTQkc2eFNs?=
 =?utf-8?B?azJNQTNCd05KNjUwWTR1aUxTOElTOE9VNnBoSG1XaGF1TEhWMFVoSjFEbjRE?=
 =?utf-8?B?UWpPY1Q3b1l5Rk1Mb3pNUCtnQzkrTSt2NU9henRpdndBd2ZjU2I0eU5TeSs4?=
 =?utf-8?B?WTFORnUvSStpTmdES2RldGNRUEx5amhJRFhDbStFMno1aTVLZHVUeU9udDl4?=
 =?utf-8?B?emZEd2t1VFdueWI0WFlyNzNSa0k5UHZlVGsxVHV2S3JXTHNLbWxmWDNyU1dF?=
 =?utf-8?B?aS9qQ1poWVM2ZFhHVUgvSXZIMUZ4VS9JbVNQS2doY25WNHdvbHFnckY3Nkw2?=
 =?utf-8?B?TnByZEtCSCsrNGQ2NTFENWFYMXF6c0x4bGFqcmRiVk9qOXZFNkI0b2FMYk82?=
 =?utf-8?B?Z1lHQ0wxcU9nMCtZS1UyTGRvd3JleUN1TVVENVBpbTh0OGdQalpzKzZFejUz?=
 =?utf-8?B?cEo5eHlNYjRrZVBJd3NhUStvamk2bjAvaTd0MVVqblRqS0JzeFhET0J4WEht?=
 =?utf-8?B?cWFyUHdSem0wYU1CTkQzNE9ZaDVQc3MyTTBTcktNakcxTklrdUp2NEZKVlQw?=
 =?utf-8?B?WUtsblVTZkZTZHVLWEhkUVdTN3NpWDlMS0swKzNPSkRIajkzaU9vQUcvTmpy?=
 =?utf-8?B?OEhLL3ZqbEJlZ0lJME9lUVpDeGpUYVZGYlladEVUR1ZST09NdWpnU085OUc0?=
 =?utf-8?B?RTlxK2g2azJIT2IralBSLzVQaXNWMmVkbGJObWN2eDBCZWdmZXVReU9kTmI4?=
 =?utf-8?B?czJONEFFdTV0L0swRVFBZDgrNjg5V05KRUZVNkVGcHZDeVJjaS95RGtmMzRP?=
 =?utf-8?B?Uzh0RUo4RjlxTWtqaStuMzAxZ3RLV0tZc2RaWEg1b0Njd2VVN0xjdkZub2Mx?=
 =?utf-8?B?RmVFVGZxVExiTXkvWmJLbDRzT2wzQ0doZm9xVDRuc3FwaXladUZBU09wb1hI?=
 =?utf-8?B?T1p0alJETFp4enFtTFFleHVlZlVGOG5LcVRMeWF6NUxVdEZoeFozZ1Rnay90?=
 =?utf-8?B?cTF4TFlzREJHaXJLcWxUSE4xNWVDcVQ2TnlLL1pCa2JlZWxMTDFyL0JOOVR0?=
 =?utf-8?B?WUZ0dnlhTTQ2RXJscE0zUFdzK1lNQmxRaDdoakxrYThsMEtZUVovTzdMS0xi?=
 =?utf-8?B?b2dQdThOeHBmVFd1TFZUVC9adTd3RUlsOGNJNllQTWVia0oxYWZpOFBaZDB1?=
 =?utf-8?B?ZUpOMzZINThrNUUvd0lSSnE2TzRDWHNjMW5mTGZCUWhnTVhkWjMvNndJZUZo?=
 =?utf-8?B?UkNzcXJjeEhQRDNjUG93S0dJek55SGs3KzE4ZVJETDBFbStWdmxIcFJqRm93?=
 =?utf-8?B?QzhKRFZzZU5YVzVINHVabnlkS0RZenVGU3Y0Q0M3UlN6WnVCZGRJeHR1Sjhz?=
 =?utf-8?B?N0hKZE5WRVVtYU5sV0lEWmhBZVBwcUJKUHV2YlVmS2FPS0FkZWw4SC9jaitB?=
 =?utf-8?B?bHdzVlJZeWtKM0VTNDU2MHhlY0Vpb3M5MDJzeGJmZ1ZibU1xbkRsRi9KVWhD?=
 =?utf-8?B?Q1RjUUFQenQ3UGZubXNVUjhRWk9Pc2FPVVJtWlBodTBXcFZkamNpOTQ0VG0z?=
 =?utf-8?B?NDMrdW40UU9JazFsTE9wMHpkeExPUGlJVmljTkFNLzVOWWtSQ1MrS1Btamp0?=
 =?utf-8?B?eUtIQjFRZTNjRURVcTZqaEdCb0NRNnZGWElmaFVaL2UzamFIM0owVUtvcXRE?=
 =?utf-8?B?TThwcmFieERETncvN1VYdmkrOHpjeTBLVGFTUnFTRXYxc2VEb25KMUlwREpX?=
 =?utf-8?B?WlBEaUFCZCsyMDRWbEFMbDFuYy9KUUNYdWcvN1ljcHhDOVJhUDlUWkdCaFND?=
 =?utf-8?B?N1BpR1lmYXVZNDNNbFRJZlNQR3RoN0xXcmgxUGRpVVJrVXFmRTIvYnM3VTVL?=
 =?utf-8?Q?g/JYZwyZXlIwcaN8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a772e43-f786-426b-50bb-08de79707da6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 22:01:58.6044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nDYvBhaeCcvA2wrkcYuuUbNHQNkPVcUw3HNz3K7OFWHKWWx6aiamG5Pau4G6/cyuu1Y/qa9rj+fPUBY7yiAfq4PcX4WEcI4SG+IYbz5YG3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF67C992ECC
X-OriginatorOrg: intel.com

Aneesh Kumar K.V wrote:
> Dan Williams <dan.j.williams@intel.com> writes:
> 
> ....
> 
> To support devices without  IDE/DOE support we need something similar. 
> 
> modified   drivers/pci/tsm/core.c
> @@ -1236,12 +1236,14 @@ int pci_tsm_pf0_constructor(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm,
>  			    struct tsm_dev *tsm_dev)
>  {
>  	mutex_init(&tsm->lock);
> -	tsm->doe_mb = pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
> -					   PCI_DOE_FEATURE_CMA);
> -	if (!tsm->doe_mb) {
> -		pci_warn(pdev, "TSM init failure, no CMA mailbox\n");
> -		return -ENODEV;
> -	}
> +
> +       /*
> +        * Note, low-level TSM driver responsible for determining if it wants to
> +        * proceed with a device that has no DOE mailbox. TSM may have an
> +        * alternate method for coordinating TDISP.
> +        */
> +       if (!tsm->doe_mb)
> +               pci_dbg(pdev, "no CMA mailbox\n");

A patch like patch can go upstream now. Care to send?
