Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3A64A02
	for <linux-pci@vger.kernel.org>; Wed, 18 Mar 2026 07:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773819685; cv=fail; b=JiXWuelp+6DkBcxo7d24/Hpao3qcU64gr38r9lrQ6Bpmpb65L+4fXb0MnxxnOn3pRTtL/hwNt55PjNOad01wHFBCrF7QRdG9UYoMEPBZkeyJ3O1DVD11AG3rhluSOGP/ufbuPQmfCzWz/ucuYjQjyEWtJMGVc5pVcHNrCFD5SlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773819685; c=relaxed/simple;
	bh=YsqmhAGDkVpZAs5LV4gb22yUIQVYV8Rxc3V14PQiK7U=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=UpmqbKk0DmW6ir5KaBWV2vhG7dwZlfdvEOZPylcC6tqI08kYgUyiJCW6u9Ka2l+iOCh9PMj1DZQJ5DI74xBgVG0wvL+Xw03iI/X6RVn6Cyq28EcqsSakC5gQml463jdnYJNcKCDFoh/Foxt16HAywsK+snQKRykGEWQlxr0IUfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xz9K+cBl; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xz9K+cBl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773819684; x=1805355684;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=YsqmhAGDkVpZAs5LV4gb22yUIQVYV8Rxc3V14PQiK7U=;
  b=Xz9K+cBlNeGzVeyt9II5umLBh8XnM48fFVuVmhjS5CqVpVdHhlQHi/kH
   6zOS1j5CtDuM2fGOIzluMo/nM9fbR5MC2RFaHj9bBWj7WL3k/1/+Bo10u
   L272DFbe4VP+dN58sL0u0FJl+ovTKm659CjzDXBVtkW+9FwGKYoZ91ctA
   Ns/x1knUL1aBkUMfj/oxe7iyKIVfY27eB9hV4RqU0lkY2fopsCLhNyxrm
   695PSNLZS59wly13ceobqXjt4eg+970AxU9X9tF51ir8Oo/hEu+6KQUBH
   JbyZ1S70xT+w6iHWclEcqsVemU/4RWzJwY7ppTXCPxbZUoKkX68uDfReg
   Q==;
X-CSE-ConnectionGUID: OeUEjlEoTcW4yxR385Gvmg==
X-CSE-MsgGUID: sbl4lsPHSK64drMUVc3LuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="100327153"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="100327153"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 00:41:23 -0700
X-CSE-ConnectionGUID: 0Iq6CMmSTzmusCpY7aMF5g==
X-CSE-MsgGUID: mnDEUVbARuGAO/prPaUhQg==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 00:41:23 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 00:41:23 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 00:41:23 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.33) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 00:41:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfGzWNU2Ap1rhJP+bFX84jRfS27cnIQvCGTA9ckj8THsKpkJcTs0QSWlkLumwjesqULgyX+JOZ5uZF0iS+BgMPCXR7RDULEmbqvTC9djpIywGzwd7qwYMkjXgRVMrrbfXspcaFI8YsCa2ltIoAfepJsuOAqDmmY+6bmYtU3iN8ETycvStZXJXBvIMYRt7edLbU0M5gTnqCkDec6o5pSbiYkeSJQDaVU7EELPxksSxRMMuodTY0XywJSygz7XkUrnoTZEQWi9AKGGQQcy2qazKlw+fjNOQSsTsfBTjIlzNTfBoBc/5VSsF1oxsZbfC770dpmeCuYuQPXqTExUxFo+Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElOyTmAQKG6AEBf86zbafpfwcWHz7qDNtwGG39Fl60A=;
 b=GBsFABld+d0rkBWPPS1QlFmSxW31rIu4xn64lFCpp5S/xJ9dJHh2WbADEdxEkFH0IYSUYxWbW4k51MQhAJzr+uuPjs4KMGBbB3Ca1s8gm8HoJ2D/NugcFXWIWels1feGbfiTj1tHzsYHOK9UNQ15E5xBgcfUR1DE2iLMw8vOpFZz/0nlz+QqeWDYdVL4Ja4vSGs8g9aZx0+ig2OY6jmJww+JO/+6SMCxES57X1PLE31XASzm6Md76s6sLoyzecqgLqAaEClOzy1NMfVj1DgWEiGHOFwsz2l2QuD/soTQHMll6omFrFDXdXEsvWHtIASKu1L9u50YQQ8WWVDpTNKgBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH0PR11MB5299.namprd11.prod.outlook.com (2603:10b6:610:be::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 07:41:16 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 07:41:15 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 18 Mar 2026 00:41:13 -0700
To: Lukas Wunner <lukas@wunner.de>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <aik@amd.com>, <aneesh.kumar@kernel.org>,
	<yilun.xu@linux.intel.com>, <bhelgaas@google.com>, <alistair23@gmail.com>,
	<jgg@nvidia.com>, Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski
	<kuba@kernel.org>
Message-ID: <69ba57199b38b_7ee31005c@dwillia2-mobl4.notmuch>
In-Reply-To: <abmcWIgaAyw66h5J@wunner.de>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-9-dan.j.williams@intel.com>
 <abmcWIgaAyw66h5J@wunner.de>
Subject: Re: [PATCH v2 08/19] PCI/TSM: Add "evidence" support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0068.namprd17.prod.outlook.com
 (2603:10b6:a03:167::45) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH0PR11MB5299:EE_
X-MS-Office365-Filtering-Correlation-Id: cc12d3f7-70b7-4cd0-0574-08de84c1bc4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: JNAJqT++frbMDmQZOSBaA96NoOSOLWgU7L5kIo+t69xvuwlrnM0u5YBqOzfI7IkO7MTbvESoalvrXYoxxbb19hlTL6KMAKFJAJRJmF6APaXnQ6OUsUTL5Vg5DRNRvfA8P+w7SMBVicJkF1Ak8ERgEpW6vWai2d8pdNzviPhJOwG1LFAQMYdfi230NolwzxW7hv66Cfyc9kDFN7gFYKJ+gon0/DotzqTYaEAtfy9PrEmMa6XrX8c+cF4yFK7J4Z2jKC2hMMOYeWooFma162S5YEeAH3xZSIFJtThwtn/MJ7G3N1zks8PgrOl8HXmzA8A4etPbTZiwJ2XoAh4sWaBOtcINkc+a5RYZiWpBFIG7VG1I7HEH3DzPzUAsEhFkqRG4Ub+bhnc9aEZonHXLxho/WMvCqn2urentgq3n+l11K3x0mk+YDmJxtD0HS60y2tL1iHw9W0VjXFHrF5ZqdbM6vLRYjri+qzgE/qW+AmYBjDOLqlU7CgXRDLvU2MJyzaj3n0PiwmsnKRBaZpdT/3/ZHaHfmtVdM8mryuJlTxtG1HkuoIcudpI0B/O3QynAsoefduNQEOntHXwCTNTPLH9Dh1Nm0g3aLHC4W+LAwk5vpYgTfouFopPAHKi8eSClV4T4JbyVXxPy/RsXqx639tbleDeIh0K+H+cKxJykV4F5BuZAgMpDN4tfCPPLc+NwQmICJaETpbkH3mn3FGD+LYOLzbZjlvCwwCPw/7zEoMe1Z3c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXgvWktkdkR1MGJqN2tXZjlnYlV3MSt4SURxZmx3dElsTDRXSEhWSkxaNC9t?=
 =?utf-8?B?YTVVZnNJUFgwSlZ3OHBoUzZSTTJ1Vk01TzlzK0JwM2JkTW1FL1BXSkFGWVNO?=
 =?utf-8?B?cmFCU0lTUE0xcmVBVHhGb1FiZTVmaXZrZldyNHhXeVZjTjZET2h1VGtzWEFm?=
 =?utf-8?B?RzRMWDF2dlRTRGQ5QUFPVjNVeTBQMTdobHM4Nko0MmR5dmpoVFA4V1Q3Y0xU?=
 =?utf-8?B?T3NIWXpzdXE0UVMvRzJ6S01TVFdBUlJYNFV3QnBTbVpvMTdlb3p1cm1MYTVI?=
 =?utf-8?B?azhsL0JNV3lVK0cwQzVzMG40amNhcEtSRWRXOGlSeGN1UUFYa0N3OUdTdUVE?=
 =?utf-8?B?R25MN3dVTzNFNWxnMFdCR2Vvd2hPLzB5WThpWHdMcHFWZ1ovNTB3T1JwWmZt?=
 =?utf-8?B?Q0dKMW83SDdzdExha2twZXB6eEZBL3I0S0F3SnJDYUIxUGpkQVNuY3QzdVhH?=
 =?utf-8?B?TGFmYTRYTWs2cXdrczZld3EvdWJLeERuMU84ZEdYclBWZkExaHFJai81emgy?=
 =?utf-8?B?WTA5Wk00aGlCSzNYLzRKdjM5bkZaMUtrZ0lBNDVocWllZEFKMis1eXhoS1Vv?=
 =?utf-8?B?RkF6a3BhZHNMalJLMEZvd1dqYWNFUitmck9TdDlDRUpMQTdDNXlVdXFwM3g2?=
 =?utf-8?B?YU1ZZkVtVGpHVnY1WlBGWXVnWFpqbkx3cEovVUpDWE1KL2QxMnVUc2ljTm1z?=
 =?utf-8?B?Q3lnT0RURTRBd095Y2FHeWdyV1M0bDhndDJENGFJa0d6RGxkcjhOcjdZd0pB?=
 =?utf-8?B?NjFBMytGZnZGdEVUdGt5SUdQdjI3TDJNc0lydEF6aDRtWkhUYTF5Z3VDNFJz?=
 =?utf-8?B?ekxSdlc4NWQxdWZOVSs3UDdLUWc4cWFCUDB6Vi8ydVpOSVVHWGlLMHFzTmZU?=
 =?utf-8?B?S1hKUEN1c05PNlFjQ2pFS3ZzeXp1OWtTSys0VXczTVUrZW4wbXB6MGd0d1Zn?=
 =?utf-8?B?Z04zVm5sblhCUkVqNGVTNVdwL3NJK2lUZzU0L3Vxdk5JOUN6RVA1amh4clNP?=
 =?utf-8?B?N29oMDlNcXlKUG03dVVycS9NY2JRYnZUaUxVeWF2VmRUcDhhUkNFZFBLZFFV?=
 =?utf-8?B?dno1aUxoRUZSL2V0UU1kbDk4L1hJZ01xR05IMHkrYVEvY3c4N0c1WHphYlVz?=
 =?utf-8?B?SkNKcWFDT2hYQ0ZQaFZVdzN2ZWVJcEptUDhMWGY2L3N3bHNQVEJZT2svZDZw?=
 =?utf-8?B?Q3lQNHVQQ3ZXQU11MS84M0EvVHFJeWdxdm91K3pjL0hvTTYrcHRHNHBFQ2hE?=
 =?utf-8?B?RWtWME9CMEM4VXl0Z0tDV0tObXVrc0ZxR0lBRnlzRnViK3ROVnh3bkcvcFl3?=
 =?utf-8?B?ZWgrVC9qL1ZhQ1VveVdJRGVURlhBbksxM2RCNzc5MS9tRnpyNkFkMUVadHcr?=
 =?utf-8?B?aUE0UHJtNE1MbGJwd1JTbFd0MnVmaDgvWGd0d2h2c3lTOXVQUU5CaHBZWE1E?=
 =?utf-8?B?U1RWeXFhaGU4Y0FVYzZOdHFQUit4WHIrMmlXeVFPdUt5YXFqRWlmY1RScmJN?=
 =?utf-8?B?NE5hMGFTekZxY09RdW13TkRuMG1SUUhKdktHU21QTW9sM09PZi83aG5mVjNz?=
 =?utf-8?B?SjRlTUJQRFcySGtBVnpzQ2hTSXBKY1VuamhYSm05dEJuODJKelMvWU9oYlI2?=
 =?utf-8?B?bm5CVDR5ZmloRUpKWTV1YlV4VmQyc1Q2YnR4WmRpQ0RLT0FiRXNIb2h0a2tw?=
 =?utf-8?B?RGxnRHgxREpQWGRmQnZ5aVpBcVVXbDEvZHRUV2VlQnI0cjh6S1hySWpvaEV5?=
 =?utf-8?B?TWs4NnBjWUVxRm5veHAwazlybG5ZZXhyV3dmQXpsNHh4UmpvSFAxYS81T2Vi?=
 =?utf-8?B?MW1FR05VZE9EUHVJMDJTcWJlMFdNeXBuR29zdDVFOEczSTVoUW5GajNMcEgz?=
 =?utf-8?B?QXNld2hTdWJVMWZIUXFBb2NCV0JPOUpNWTlOYXFDd3lmMDJYNW1OeHVEUUZ3?=
 =?utf-8?B?eFJGMXZ4c2ZEK3VMWmNhdUxJK1hXYVNtSnNHaU1OWE4yVWh5QWRxcC8rSFUw?=
 =?utf-8?B?bkRLSDE4d3VxcDRsczZLclBaMm1wT2lGaFNuSFNXaWFCNWhadkhLSXFBZDM4?=
 =?utf-8?B?eGJmRUZZTWE4ZDBrSzlDa2VmUTFkeWRGcys1QjdWRnphdThWNzlISmM2aDIv?=
 =?utf-8?B?UEtwUVdJSnlvMHFWZ1JlODZnSlEyWFRqVHA2U29PMkVFNVQ0UzlRaFY3Q2JN?=
 =?utf-8?B?YU5wbTU0bGtRZWErRUxTL3ZLcXhMc1dIOTNvKzFVQXNPTXN5VHRhNC9qbWVO?=
 =?utf-8?B?ZG9jdUFiMlB3MFFiWkpuUzNTbFVXdDRka05haXowNEFyTVZWMUMxTytsZEJz?=
 =?utf-8?B?aUVVV21IWTJvL2RWUE5JdkNKQTZ2dFdSZkl1RmVHN1lsRjZjT254b3VwVWo4?=
 =?utf-8?Q?eZMWZZVAYqEAvj7Q=3D?=
X-Exchange-RoutingPolicyChecked: UBsB6wj8OGOj4+H9JdgdZETZtcCDOB28TjVYPNVIKC8tU05rlBzYXzZWotkcGR5H1PYfNkPNRct53vdeiMVBX+T5pQLWOClBSB3JefFrb3qBQwdPDI+W1P19YKlaI3XrF4fGhyITxu+o6fwLz6ncOJ/TEm028Ir8oSCS7715mEwLZbxKIt8Ak/Cko3j+ZRLzPfH+qgivDK+/RVi844OU9gU8sA/rnkwxSjbdoztE0J0XdxcUsjNzxKigk4CcMs5Nc+eQ+yD/warSktoTX0obWmz9tqyrC00J0lec7ipi+eqAp0pHGEPmPFIgxCYKOq4U5EzKrMniRMV04MHNtiS2zg==
X-MS-Exchange-CrossTenant-Network-Message-Id: cc12d3f7-70b7-4cd0-0574-08de84c1bc4c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 07:41:15.7368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VHDzcbmXS5F0Gip1ZrKyFAV+J3ksyoiKU2zd7AhsygBqcWP9HddcdHfZGy/8v8rkkbeuhl5Yo8Pt4M+z/6RXZ0VGa/Wr79zU7Dax+QcOM+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5299
X-OriginatorOrg: intel.com

Lukas Wunner wrote:
> On Mon, Mar 02, 2026 at 04:01:56PM -0800, Dan Williams wrote:
> > +    type: const
> > +    name: max-nonce-size
> > +    value: 256
> [...]
> > +#define PCI_TSM_MAX_OBJECT_SIZE	16777216
> > +#define PCI_TSM_MAX_NONCE_SIZE	256
> > +#define PCI_TSM_MAX_OBJ_TYPE	4
> 
> Where is the maximum nonce size of 256 bytes coming from?

I took it from Aneesh's off-list RFC, and meant to circle back with him.
Yes, it should come with a spec reference.

I am having trouble finding a clear reference for ARM CCA that clarifies
that measurement recollection takes the SPDM standard nonce as an input.
Perhaps the document I have "DEN0137 1.1-alp8" is out of date? TDX and
SEV-TIO do reference SPDM for the nonce size.

> Such definitions should always be accompanied by a spec reference,
> not pulled out of thin air.

Yes.

> SPDM nonces are 32 bytes, I assume that's what we're dealing with here?
> 
> This patch:
> https://github.com/l1k/linux/commit/bca645e08ee9
> 
> ... contains the following definition:
> #define SPDM_NONCE_SZ 32 /* SPDM 1.0.0 table 20 */
> 
> Though it's defined in a private header in lib/spdm/spdm.h.  If there's
> a need outside of the SPDM library, its visibility can be broadened
> of course.

Of course. Again this points to a need to pull this proposal out
separate from the rest.

The ARM CCA spec does reference the EAT nonce which is 64-bytes. So it
may be the case that PCI_TSM_MAX_NONCE_SIZE != SPDM_NONCE_SZ depending
on what evidence can be collected over this interface, but I am not
finding any spec references for 256, Aneesh?
