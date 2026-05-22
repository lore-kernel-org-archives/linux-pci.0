Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42776364053;
	Fri, 22 May 2026 09:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779440976; cv=fail; b=aNy3/YBQoVuINRA06ZqCTPEr3FaMjqiTTSlCK0ecDjS/dyL5OyJSfzhM6qwIWpBnQWFBovzwg+d27Oiim9KeGgo5AMyvMsIk1VlYeDmLHPVLMJb51novrspU1F0RLn1nWpAv6NFY0CfQAQLarTjAbE81hqdODN5b7oXix72ziWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779440976; c=relaxed/simple;
	bh=7Nrt4fIB5Xy6Ci1CHmUeGeruZ4aNm0SUN1BnOY5xc1k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dT9UBNPAIrMs/qI5SVDwmrnnMD3XLjXpIzsBWB+Bc9vRErrsycUZUPmpaRw/dLtlkbjyImUhsjU5XB828pjpeKGLuPVLNEtbf4Q9sBTvSvm7NxiDZ7iuyCNPQvQgPfsiV09qZnGRl2rUSPWYj6bi3SQJxMMVYgRw3lO+kUCFjs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CG1Zn4oX; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CG1Zn4oX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779440974; x=1810976974;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7Nrt4fIB5Xy6Ci1CHmUeGeruZ4aNm0SUN1BnOY5xc1k=;
  b=CG1Zn4oXq9L1ns3KEvk4wfrW2EZAQTqaOo5sAD3YxRlJnCFX+xYOLnuM
   e2Y4zaoGOMCy0CmOck0VblovZL0QRjn0kWT/q+Y+lDFBd3JDAmIgA1kEv
   NOWBmwze+ZwVIcAVYB0xfepepJkhsuDKENkDg44i2oTYUXAxXOgeCX2RQ
   p2mWW1b9HH1/JbxGMA48xE+Kpa9ybnKVPJWKRDwU6agQFQvUxKY1UeQR3
   1Ls+g62ZlOHtD4fuCWq4HefgmSSKIYk1sLV7Azk77s+5JaBhe9K4olQs+
   rHsD40J7tW/k/2Qamtch6cXiYdnoOWNsPsAkN01StwaSFNzRGbjfexGJd
   w==;
X-CSE-ConnectionGUID: xdaeIECHQayhkU7Ujj40SQ==
X-CSE-MsgGUID: 9JSU0b3cQHWYO12cBXgm2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="82947433"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="82947433"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 02:09:33 -0700
X-CSE-ConnectionGUID: qjBTUD38QTGnM4D3TE7/sg==
X-CSE-MsgGUID: fmZ8p2oBTgalL19/6Q1SAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="244905812"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 02:09:33 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 02:09:32 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 22 May 2026 02:09:32 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.50) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 02:09:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BOP+OGZBplJElftXJeennNba3HXgasDv0ealIJUWsJzWRFAONf43I+SIo2IkMgAIWbAIg8s+ZmnhA+e+lIw4zayj3RYZ/7tdteoaY5PRSWnmwAbVJxoTlS+lkTyyzPib4Gm2/8SDa6CrWSYAsLK330Uf3JPia+OUlH5gEcWhQThIwmBtsxN/lhzcARZZUHZ8ABg/UHVdXsCwekde7TIv1I8SWaMoMbFmyD0t6rZO1nRFwNQ8oc2ljkdOH+JxRZaqDe8uggsT6MFXovf8Y0fKTi1/UZUeshPaebrLGDJiPElwYuzLCIQBmZE4bN1m1/uVLVMd6odiiIKbxmyHeatQrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fO9nX+NwQiVrJCIlMVMhTW7RmakqGJnLIBKlK5rRi0=;
 b=c1K2e5pKawhWcU5c5OQNafFt/DckL0lK/U7hgsJaSX9uTm059urRXsBZM22NcLDEP3vYrGd8JGXGFpUVDbrsmhK2mHl12xYLTy8yohMF1F+XA/5ksErVFymoKAoMo6AL52H1/FCMnT9obJx1N08U4D+QBubbefV25RSv1uiZ+bGm1J/suLbTnBPr5TnA2Bu0I44E2LCko6lHiiwiz8HWVLcEfkvYQhQEhx2RiZfqesZ+kzLEoMJWaaPhggc5A0xUmzB2jP8OV1RbjiDnfw7gjHHz7gC8BNwxJ6rFEsHAeVlXh3Ef/ll4R6FT1Z4zCHsbwO5x4NAxEzJc6F7C6SFZtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by DS0PR11MB7767.namprd11.prod.outlook.com (2603:10b6:8:138::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 09:09:24 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.21.0048.013; Fri, 22 May 2026
 09:09:24 +0000
Message-ID: <7a264588-e9cc-4598-8797-fa9caf2e1b7d@intel.com>
Date: Fri, 22 May 2026 17:17:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] PCI: Allow ATS to be always on for pre-CXL devices
To: Nicolin Chen <nicolinc@nvidia.com>, <jgg@nvidia.com>, <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <bhelgaas@google.com>,
	<praan@google.com>, <baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<miko.lenczewski@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <vsethi@nvidia.com>,
	<linux-cxl@vger.kernel.org>, <nirmoyd@nvidia.com>
References: <cover.1779392420.git.nicolinc@nvidia.com>
 <0dd7e22f44bf35a33a590e0916983f9f7fe00de3.1779392420.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <0dd7e22f44bf35a33a590e0916983f9f7fe00de3.1779392420.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:820:d::10) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|DS0PR11MB7767:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dbd9d78-2945-468a-4d51-08deb7e1d12a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|42112799006|1800799024|7416014|376014|366016|56012099003|11063799006|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: rq1cAytwJSbH7kd0inH6xu9tlTG617sDQX21QNRRr0X3jxN5IkxcKtq2jOAQk+qqX2us1fYdVep3hjJChwdPqZ8T2Bno57XrQV7RwQ4wGcsiqDU5K2YVgFuld2HYWbFTR1VYN/PVwR0HpM3Q06BEs4Kh97W1DRnmvoGVkYpcoGnaqAW34JrBjE4Ts2jMDTw+tyD+iQ6+jR9h5oi3bEB+qay+yzMha3rmCQ+5JlMIYj/qYa4siLwjRxSMxf0WeE8Mq82U0NVlQ+SBn5FXiYxbDUBr7+7XJkgxIjT6wOB8uyd3X8+JFwHwGIJZS7Xj/IFtribFxterTtKedt5LiTeOz38YNUgwbODOk4jzvUR3OT9KQVXHZn/dIMbreyV5t0mbRUc4gim5axKbKq9KoX865dUe+NAD4XIvyO8sfvNjmUTOFlVOE09upFEeFEXWYcE+jTDIJ6Q0lEPNKY5dmD4yku1jt7DM0Q6o5+KfxqUCJ+/LeXo7DHRwG9ti7le7bvIxjKj+ZxTghaxvcJO8226RgiaMIROUcdLy+D+wcsjO4t0LQM1IvhqdHicI6cubg0IBIskIfr0fv2CXNDF3vQVlassE+5mdNv6LzSJcVLpCNG3ZVXyFDHJMiALrgtB0ZtqISzcojR/vnULUpPx84RmSm2p2vjzgx/QM7NnLEaiVCvYX+1DaRaUryLJk9X4L2HKU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8509.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(42112799006)(1800799024)(7416014)(376014)(366016)(56012099003)(11063799006)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1lNdG1CK2RiVTJ6NUhmbnp0MmpWdW1rRTFnd21tUWVZUjNiR0xBbklmck5Y?=
 =?utf-8?B?YnZtUE5kNmdPZEUrRVk1NXdGWU83akJyTUx3K0ZXM3duekV0emR2b3lXZFhi?=
 =?utf-8?B?YVJzYjZOd2ZFTEdmUm9YelV4a1lOVjJTbFY4NUpRdjNQQzh3NG1jNE03a2Q4?=
 =?utf-8?B?eXV3SEpobENDc0NkMGF1cjZGRytqMFBiRW5mZThyK09ZTk5Zb09OeGpKWk9w?=
 =?utf-8?B?Wm9uNU9HZGhrS0t0K1E3Zko4RVVNTks0dFNHWE1ZQVRxaEpIakhrbWsvVWl5?=
 =?utf-8?B?UUIwSFJjTlE3OEJMejRxcEJIOWN1ZUZIa1I2UFZGdzVOcGxvcFhXSXIwYnRZ?=
 =?utf-8?B?UWFNMERQenc2ZkZQY3haNThUTldXQVFYSk5NUWNmSStWTWgrL25Uc0JmOStJ?=
 =?utf-8?B?ck5OWVVSZW1pL05xOTFRdm9FclVZNHRkS0xPL3NiV0hBaGZYdXB6YVB5WWs4?=
 =?utf-8?B?NE9xaStTTzBtY000eFFmMFlTY2FQak96TDRiRit3UzlSL2RYckMveWFBM1pm?=
 =?utf-8?B?Zkw1T09TWGcrelhkd3BJdVZoVzgyVXNRSkJSNGsvK2dkZTJKaTJMTFZXMEZG?=
 =?utf-8?B?WmttQVZMb0dWSjlwWXVQTWxoZkdSeEJva2k0dUpzMWFxTXZzMkhRZVAxRm40?=
 =?utf-8?B?NlpCcE8rZ3VvK2FDaVdUZWlIL0NjWEVad0d5ajN2aE93dGhhM0l2aW1DdEhj?=
 =?utf-8?B?a0V5ZjRwb0FQZUJpNFQ3OERmUmVZZzJjZjI3YXdLR0tFd2dPWjhRK0RGVzlN?=
 =?utf-8?B?ZUQ2UmZXNjJrZ3dROFFwbmZDSGdJM3dockJkZXBxclBjdWhoZnZlTVJTc1ph?=
 =?utf-8?B?aGtrZ1oxNDkwZFllUGRrcWs5dEpWSVppNE5tYmpHOTh4MkhRSDNFT1ZRcEl6?=
 =?utf-8?B?VU5DZjRJTGRDQTdNY2prcFZ0YXdFNXRkWHdHenQrdHBXNEhNbmV4Q1BsOTI5?=
 =?utf-8?B?MDlGVDJUWkVhMVo1R3R4WnJUWnpETThSc3lNYnZOMHVtQSthN211aEpzOUVN?=
 =?utf-8?B?eFdwOVAxYllLa3JQNVQxeklxUTdKaWVremVwTFpnK3owNUtWbi9DOExwa2Q1?=
 =?utf-8?B?aWw0ZGtKR1VnQUdEcFBlajZCVWx0VlZqVDF0VXREZFNZNzUrdnNid1pLMnE3?=
 =?utf-8?B?QlVxTGZWRmU3SGlReGJWUnV0bW1tMVV4UFJQbGlJQ01yZm9WK3JHNTEzUzF6?=
 =?utf-8?B?UExucGNRWHkvNEVDUkQ2dHVaY3UvakFxV2VkOVFsL0M1U3ZHdUozNU1QeEhG?=
 =?utf-8?B?TVVsYXhIckRnbUdKZ2tuc0JQYzk5TW5WQzRCWEVHT1ArSHRrRHlkZ1NLVW5T?=
 =?utf-8?B?dWpGYmovT2o1RDlvZjV3ZEMrZm5IcWk4dnBLazVBYjJZeWRCcE5nckx3dVRO?=
 =?utf-8?B?ZHJjekYxQ0ZiZGlpWVd1NmFoNzMzUm1zTXlMRlpuVDFVRFMwWFFhZ1FiYmh4?=
 =?utf-8?B?OWJiMU05bWdXYXk3Mm5SZkhyeHNuMS8rMFdVcVo2TGN6amxhM1dPck1PeFlO?=
 =?utf-8?B?TlM0R3VtWXZvcHNadEhUSkNXNEY3MDMrOTNsTzE0UFpxMTdESHVTeUVBZHlx?=
 =?utf-8?B?Wmt0THh3VmFaZEJxd2hyTUxESk5rdk8yL2JtVTBEQThWaUkya3pZV3UyclEr?=
 =?utf-8?B?MldOaWdhdytUV2RxNW5nWkpQcklyYzMwNUc0VnRFWmF3Y2JLRVVWcmVxNk9X?=
 =?utf-8?B?RmtHblJRNCtZL1lkeSsyWGVoTjgwZUh6cG5UUGtYODBYdW54Ri93OFRZcGhP?=
 =?utf-8?B?K2tIb04rNHFINHU4cFROVlhzQWJWeXRKL3V6aXpmV3RaNnF5aGltT1U0bTJy?=
 =?utf-8?B?YjBrMGh4SFkvdElyUGNjV3FUbjZpSit4QTlPcWh0aEUzN09WTTR1SEJlV243?=
 =?utf-8?B?eFF3S0RxR0QwQnZIUXYxdWw5cndHRlJDdS9qTU9NZUNxeTdHdVBLOHJjYmhQ?=
 =?utf-8?B?Y1NvNkJhNzRCS2JtN1JlVnpOSUNHZVkyQVdKdUZrNys2ZVdHZU5SQkIrQlpk?=
 =?utf-8?B?bXJ3RWdwaGxNUWwzUVh5L2txRkh2Rlo1dDcyLzVIc1VWSWZORzY5eEloMGls?=
 =?utf-8?B?Rk9YNTNJeUhzako0bGRXSG9xYlYxN1pNZ1JZZkNRRldSaFRJTGlCL0pjVTlC?=
 =?utf-8?B?MERzMkZxMFVoVjh1OFZoeVRIdGp2RGNabkhhbm1BdHdSRUJFUE0rUlh0dFF0?=
 =?utf-8?B?SWVhWVozVzAzalZHY3N2RnJqbzFjNGo0dHNidTVxdlhLSmlRS01WV21LZnQ3?=
 =?utf-8?B?ZGR5TGhxRjRTY2hKRjRHTGhoMVRzSmswL21oTE05Z2lBWmM1U0Y0bFQ4aXYr?=
 =?utf-8?B?L3BodmJLYmFEa0daaEJ4akx3MVM5UEYydG13TVI3Vk93dVl5VEJUQT09?=
X-Exchange-RoutingPolicyChecked: VT6zRfe8BFgz/UrJDEbAr5RKN5UdvF9Ww7+FcBnsQAsb5Nj2Wt1QX99BHVZUnRgtaY5/R6hMNjKdhqlXs47+j2gLzWqqIkWdU4TGMCjsyAGUJQDLdZFda6Jn/vTj9jlWTv3/W7icP+F9pZbsqK5lOJ8jLbBJeL9quuF3w67wTZ3oWuONLfCqB5bXofI9YRHiqfcwjDjnlW9cR2aRxS0b8uRoyBg7g1UFAV9B4z4O8ui5R8JZ3suEY/j8GlZNh3ony4fGoWMIwzisN5h76WpneNubxfN9BuWZ8z4JqzLE1EueW+if/1gfLgEC5KGlysLnBaqDYjYARkLEmMB2C7C1qg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dbd9d78-2945-468a-4d51-08deb7e1d12a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 09:09:24.1692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PTouVRFKAPmJjCv+3dXG1ZJJbwNCuulVMxiqMtF7r5UiUfh8p854H52npNAyAeft9am/sSgNZUuTTQwa9zSbdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7767
X-OriginatorOrg: intel.com

On 5/22/26 04:34, Nicolin Chen wrote:
> Some NVIDIA GPU/NIC devices, though they don't implement CXL config space,
> have many CXL-like properties. Call this kind "pre-CXL".
> 
> Similar to CXL.cache capability, these pre-CXL devices also require the ATS
> function even when their RIDs are IOMMU bypassed, i.e. keep ATS "always on"
> v.s. "on demand" when a non-zero PASID line gets enabled in SVA use cases.
> 
> Introduce pci_dev_specific_ats_required() quirk function to scan a list of
> IDs for these devices. Then, include it in pci_ats_required().
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Nirmoy Das <nirmoyd@nvidia.com>
> Tested-by: Nirmoy Das <nirmoyd@nvidia.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

>   drivers/pci/pci.h    |  9 +++++++++
>   drivers/pci/ats.c    |  3 ++-
>   drivers/pci/quirks.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 4a14f88e543a2..e8ad27abb1cfe 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -1155,6 +1155,15 @@ static inline int pci_dev_specific_reset(struct pci_dev *dev, bool probe)
>   }
>   #endif
>   
> +#if defined(CONFIG_PCI_QUIRKS) && defined(CONFIG_PCI_ATS)
> +bool pci_dev_specific_ats_required(struct pci_dev *dev);
> +#else
> +static inline bool pci_dev_specific_ats_required(struct pci_dev *dev)
> +{
> +	return false;
> +}
> +#endif
> +
>   #if defined(CONFIG_PCI_QUIRKS) && defined(CONFIG_ARM64)
>   int acpi_get_rc_resources(struct device *dev, const char *hid, u16 segment,
>   			  struct resource *res);
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index 84cd06d74fc9c..96efa00d97433 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -247,7 +247,8 @@ bool pci_ats_required(struct pci_dev *pdev)
>   	if (pdev->is_virtfn)
>   		pdev = pci_physfn(pdev);
>   
> -	return pci_cxl_ats_required(pdev);
> +	return pci_cxl_ats_required(pdev) ||
> +	       pci_dev_specific_ats_required(pdev);
>   }
>   EXPORT_SYMBOL_GPL(pci_ats_required);
>   
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index caaed1a01dc02..c0242f3e9f063 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5715,6 +5715,48 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1457, quirk_intel_e2000_no_ats);
>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1459, quirk_intel_e2000_no_ats);
>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x145a, quirk_intel_e2000_no_ats);
>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x145c, quirk_intel_e2000_no_ats);
> +
> +static bool quirk_nvidia_gpu_ats_required(struct pci_dev *pdev)
> +{
> +	switch (pdev->device) {
> +	case 0x2e00 ... 0x2e3f: /* GB20B */
> +		return true;
> +	}
> +	return false;
> +}
> +
> +static const struct pci_dev_ats_required {
> +	u16 vendor;
> +	u16 device;
> +	bool (*ats_required)(struct pci_dev *dev);
> +} pci_dev_ats_required[] = {
> +	/* NVIDIA GPUs */
> +	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID, quirk_nvidia_gpu_ats_required },
> +	/* NVIDIA CX10 Family NVlink-C2C */
> +	{ PCI_VENDOR_ID_MELLANOX, 0x2101, NULL },
> +	{ 0 }
> +};
> +
> +/*
> + * Some NVIDIA devices do not implement CXL config space, but present as PCIe
> + * devices that can issue CXL-like cache operations like CXL.cache. Thus, they
> + * require ATS to obtain host physical addresses, like pci_cxl_ats_required().
> + */
> +bool pci_dev_specific_ats_required(struct pci_dev *pdev)
> +{
> +	const struct pci_dev_ats_required *i;
> +
> +	for (i = pci_dev_ats_required; i->vendor; i++) {
> +		if (i->vendor != pdev->vendor)
> +			continue;
> +		if (i->ats_required && i->ats_required(pdev))
> +			return true;
> +		if (!i->ats_required && i->device == pdev->device)
> +			return true;
> +	}
> +
> +	return false;
> +}
>   #endif /* CONFIG_PCI_ATS */
>   
>   /* Freescale PCIe doesn't support MSI in RC mode */

