Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794387760;
	b=tmem6emyzAefIJmxT5VWDFIhnQeombuTFnyEAgN5v+IYVsAvJEh/R3QYVJEGyySDpE5/
	 9Y+H+N5+jIuGRFmM/KtLvEQ/dGFaOScz+7abWIQ0FgyynqC5DCzcguYoZ44AvvQghtuGi
	 cNNpBwZ6E7kyqRY+Oe/h9ADw64UWdl7o3Lqe/RfpQ9hdB1ukFR7Z3CS+yDpLmyxlBHtV9
	 K8YnXO5Jzj83D+MdUquaTkVRfLjUCme1HQ1hsomRgWjQDr5hWsqM7LLgb16WW6CXa9fls
	 IgHiVDOqzkcF71SQbdnhOufmidloHtyaDztPfHSfim/iPJGP2AXC/zBC3saiZjPhbKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387760;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=ibvwRrnA3+QoBk7k9lQ6REhTdnNoEnEpHrRcKdC88oA=;
	b=ZxAt7MathokofLx4pYd/0IY3b7ulDgoMHklz2YwGctr7z1eJxiFz/slfUZ2VlwQfChBm
	 1hi8yvc9th8JYtKGcAGlovtz03RNf5RqpMba0y3+WjkfohNlPDDKAsWsLK2+Kjx0efP/c
	 2zNhMQhvQTUgPt47JV6uz/fcd8b8Zkp3BaBzI3OIFac//cwtidfuiiuk4qVg3i8pXrpzq
	 gXsPOBG93X9xv065rAR/btrcNjWoYZaGS3wvDI67AenkvPCfXQ/5l8/vHjyBaT2g85fXH
	 U2rm1CyMuqhWk1RRuU77bjQYCqfertWu++SPBe5ny8HxPxlLK1F8yjSthp4Edjn9pjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Yw6KXSR1;
	arc=fail smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC35606A326;
	Wed, 11 Nov 2026 09:02:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BC35606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Yw6KXSR1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794387760; x=1825923760;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VYejnJwLt8095LTNmxzdFDJg/2Qm2UYmV2bPtQmyBr4=;
  b=Yw6KXSR1Jqf1iq1F6gOgiARJAti4yGDBcG6LIAYnWcYILTxF8lpRA4tu
   AV+MBotqiXzGepuz9TpJg/DVuHQrLa2gEGzAKwPdiCcI0PZNLamSW7FHx
   Ki+40oKNunbqGwyJg40zP/C+kisD7IsBeyHiYGoJLitSDYGUxg1jkOBrd
   g3umOA4k+WwcWaV4+cTLLtLZ/iO4x26nAibSppniRsWXX0DsRBT/kIqLf
   IuqOOsnPqy7i8R9frzgkKzBb5zvPNRoz6eklPmWaf+iALkB2fKUFMWX9S
   5Zs+9qz7+OYhuyGFvvtY8woBlON7b+36/8RupCdgcqUc+zDCyn4unpJ/q
   Q==;
X-CSE-ConnectionGUID: FePlgE+oTxa1TWftbpBB1A==
X-CSE-MsgGUID: bkhwMvRjQAOARsPTaiLDKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3041112"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3041112"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 01:02:39 -0800
X-CSE-ConnectionGUID: 0qqax8K6QdSLJzdGGa8nVg==
X-CSE-MsgGUID: IfiHOHpYShS+2ZKAGYKPvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="8468398"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 01:02:38 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 01:02:38 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 11 Nov 2026 01:02:38 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.28) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 01:02:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vRmMRCCpxZl9SA289IdHvERY1uP3JC9Qaa827OnU35xjrOGHao+m+Ih697NU3SY48h6+mtZ4PeFpp8LM8ALYzN86R/lGakc1kkJKBb84YKfjhsaGz8xb486/ENiamVimt5EAeWEN2MjTWA6F4RSQCfHAO1aAgUVz8SmhY6eGlEiEUaArNNL0twE4otdKh5unsdGcvwpLvW0/9Ai966+CSqTQpL4GQUs1sy2EvLGfF4TSV5bEjBPgQKtkr1kLPcjsmHpK+tMvEZdBzm3l3IKr4KLArQfanyST3lqF/p6LMT4wrvzAQMvOsjDFgNjMp/uSQV0/o6poaTKVSTbw8Uj/qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ibvwRrnA3+QoBk7k9lQ6REhTdnNoEnEpHrRcKdC88oA=;
 b=khVQKJxkqDjjrNrP+CUtJSvCLMrsqC58A7pZuotJlxWZsdogfq/y2iIEOg1uLoPwogyn/NgfBjQ0yGeaqZgllxT07vqNW9kmJkFBAf9hAuAHqpKu3PnmekRJZqCGLiRBc/BxwdKOsZE1dh3wh00FnWua0kQfOm1D/uQPnSR4p7mqHwVzgraFTohCMOR3+msYEyho2RnnTDDqlfXMZdF+17SQ0xNZVfFEr6I2en0Wl4YTuyyGTPL/T3qGgobmkPPZx0apO+Zk1z+VDVyvSkc4OZZbpbu0tKjO3wcMtl2nTJvhy6Y6i6jdkvVWZTluERt/OwXs8BLkYygU/iFLZ8R7pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5617.namprd11.prod.outlook.com (2603:10b6:5:35c::14)
 by IA6PR11MB087122.namprd11.prod.outlook.com (2603:10b6:208:601::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 09:02:35 +0000
Received: from CO6PR11MB5617.namprd11.prod.outlook.com
 ([fe80::a93d:4c42:c821:3cb2]) by CO6PR11MB5617.namprd11.prod.outlook.com
 ([fe80::a93d:4c42:c821:3cb2%3]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 09:02:35 +0000
Message-ID: <5d45a583-198c-467d-afbe-8f19398e82f3@intel.com>
Date: Wed, 11 Nov 2026 11:02:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] igc: Disable PCIe L1.2 substate on I225-LMvP and
 I226-LMvP devices
To: =?UTF-8?Q?Daniel_Via=C3=B1o?= <danividanivi@gmail.com>
CC: <netdev-bot+sashiko@kernel.org>, <anthony.l.nguyen@intel.com>,
	<przemyslaw.kitszel@intel.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kuba@kernel.org>
References: <20260925112850.189302-1-danividanivi@gmail.com>
 <179068206160.434549.1717741783856466607@kernel.org>
 <02c36d47-ad50-4f2c-88cc-6c91f62bba00@intel.com>
 <CAD6rab8LEfZcQgcZLmeiDzd-PUi56h=9aBEsuOS2qnoyZEsdxA@mail.gmail.com>
Content-Language: en-US
From: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
In-Reply-To: <CAD6rab8LEfZcQgcZLmeiDzd-PUi56h=9aBEsuOS2qnoyZEsdxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::14) To CO6PR11MB5617.namprd11.prod.outlook.com
 (2603:10b6:5:35c::14)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5617:EE_|IA6PR11MB087122:EE_
X-MS-Office365-Filtering-Correlation-Id: bae2ead4-fbe0-4e8d-b48a-08df3fd286ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|261028144727099003|261026140227099003|261026121527099003|261102123227099003|261021121427099003|261021135927099003|261022105027099003|261022075727099003|11063799006|5023799004|4143699003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: I/6C3nfTWfV0EdD2zp8avbc62ogauAPFJ5go0winnp51qojT64NtK2FmhmgxgWRKd4oSFrDcyWmSIUc68bP9Jg0KLsmOEz9eo93MHTpqO+xskMNl/FTCVRiBe4YIs/9u6JhH8Ob8mqas3xL7unC/uXehHi6xWPO/H7S4s0EnMydIFOG+94yPF4YGTFqj1L5P51A5cnBFdQjooB/qaJdJNUJ52CpQIri1GwRiER/ZrSbLB06LEQek89kE3+bus7hObH3pztnxiyaMLJx2+vAeQs5DYoeJeFOn2kqIFoMQwnhlfuyPs5ljWnsyPNfb+g26nxQnAH9Q+9mtMSaEj1MDvDF9D/TnWDYDtiDXtd74w9GtPY32l6jjH42WXslrGgfg3g25SYufKlVgtQTq4kG09GfwdihxmJdvLarZkpBK4lmVj+kuC+FaKwqYPBvCymo8tu5vM9U1f+pIHVcMh77ZK8pn2BQzRh5DG/6GBXrFUIe9NAWTUGMTeWOSAdyE68Eh2A9A+G38sWxWR67x5ufZ098GaCWCl+b6NuhCpf3R9XDHwsyADWOrgIgMig1nQgNiy5jdciXfpWr/zg4nq7UcIGmBFIawv3UDr8pJmc0RUI/g0RhoqKgAgQaJi3dPvxQHwIjRkX86TKOdtu0UYp/RR6ECFt9LcDosUNAVNIKhbpk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5617.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(261028144727099003)(261026140227099003)(261026121527099003)(261102123227099003)(261021121427099003)(261021135927099003)(261022105027099003)(261022075727099003)(11063799006)(5023799004)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0NQQzdxTXdjZ21RUnZiajlnK1NuM3RxVERCUnpnQXRxeGtKRHVOdEh0YmpS?=
 =?utf-8?B?bGNPa2lRWGYyVG9hN1VON3JDK2plOUUyQWlzYk5INjhYckJGRzVnckRLeEVn?=
 =?utf-8?B?ekw2LzNFemV4S2pXK0RsNUFZNnVDREZVM2RwZVFJdE9QTUZ3Z1QrUDYxL1JM?=
 =?utf-8?B?Q0oxQzVHNjBsNDl0WlYvVWM2ZXI4UU8vaTd3dW0vZzMzUXZ6YUtqRExTeXUx?=
 =?utf-8?B?TUh5TzFnUzhlZHVwMGlWM214a2J1eTZkSFBSc1doWW9YUGxuRU5Xd1BNSS9E?=
 =?utf-8?B?UGloY0JMZWZEMDRad0VuRWt6bkFCK05GWkFKVlVkOGEwMXBNOS9QcTNYaVdB?=
 =?utf-8?B?S1R1ZWJ2clNuZm44M0I1bjUyRUVRaFJhUlJGSWhhZDlQNWw1YlV2M3BVbDZ3?=
 =?utf-8?B?SWJES2JtMko3bWZITU1mRzJDc2hMUjI4RXdCdGdYK01rbGZzTjZQZXgxMXZC?=
 =?utf-8?B?TmV3K1ZjYWhrdTR4RWQ1VXR6T0tUSkgzSnNSRXYxSXJ3VnhPdlVMOUhYb2pX?=
 =?utf-8?B?S01rVGlVNHgyZktvNTlmUjBsNnZxZGtZQktnVkFJQkMzemFSb0NsdjcyQkwx?=
 =?utf-8?B?QnNjWCtlT1UwWkJBbm5pR2pPTVg0aWR5ajEvdy96N3ZldHdLV0UvMTVPRnNZ?=
 =?utf-8?B?ZzRFRkpXdmRkQWtqK2FZd0cvNkdjRUlRcldQS1pCc1VUMndwVk9OTUtDYkV0?=
 =?utf-8?B?VkYzVFlEODcrMHlYbFdpTmxUK2FOQkNUNkFjZlJOM0NqWWlQckFqZm80RVVW?=
 =?utf-8?B?Mkxub2QzNVoxaWpvbkN1Y3dpcjV0eVE3VFdBK2VtS3dVbHFITm9jU1hMRDVy?=
 =?utf-8?B?bHhCNi9FYi9uV25wOU9QWHZlQTJBcE9rQXFjSUpHM1VJMU4xS0JRM2xpUW5Q?=
 =?utf-8?B?T3ZBelRvMzE4NU1mTUUrUnFkbXlydVhqNmIzMU5QR05nSWprdW9oVmxFYWFm?=
 =?utf-8?B?VUxXL0t6UW5SYU9ndjA5ZGNKc0VwNTRTUmRsMFFIcEV0dXZvTHB1NXk1b29Y?=
 =?utf-8?B?a1RzWHpvdlZuUTBLem4wRHNrdlhZTnhiOTl2d1ZwdTZ5RDl5MFlNRHpaNUNS?=
 =?utf-8?B?WVdWemIwRDdaOUtaMThuQ1FIOHJ4cU5IV2plM2ZWTjY3WjNYanFqWm41ek5z?=
 =?utf-8?B?SkloUnRlK1EyYWRkZWhYZU9Dak1ER242bHMyTFFidUJOVkNuZERqTzFGMHR5?=
 =?utf-8?B?ZVgrSzNIcDJnQ2xFdWN5M3dNRmdRWkFDNTI0Y0x4aFdrTStTamF4VHg4bWxu?=
 =?utf-8?B?WHh2M1N1bVFBSlBTYzlodEtIVTE5TnAwRkQyV3VESnRoZEVKMFJjemJnMC9i?=
 =?utf-8?B?MzZHQUVoUm5RbDZQb0krUXU5N1Z5Q3plZ2g0eUtXamNQb28wbzRCTFF3TlJ5?=
 =?utf-8?B?SmQyWHB3RVc2UEJCckRFKytqcjdVZWJyOU00U293bkUvMW0waXEvTi9zc2dN?=
 =?utf-8?B?TEUyRUwrUW1OZERnLzVwUktqOU9FZ0RQOFNPMHBFcGNBU3lnN2FoVnAyb0Va?=
 =?utf-8?B?T1gyWmVtdklaTGJYbkRSZFpEOU5nMVNOYzFkWUJHR1YxZ05kbFU4SWNtYTkr?=
 =?utf-8?B?YVU4VktLc1dmM2xvNTUzRDRKYUZ4NUpwaTE0RVdPRkxIUk1uNlc3VDdER2ZC?=
 =?utf-8?B?bVp2ZFdrV2hTajNQcWNkZ3c3UE02NjY2YXN1a0dqa2dtZkgrNEYzTDM1ZFZm?=
 =?utf-8?B?YjRTL0VEYnRkWkZlU3R3RlY4VUtyRS9yajFaZ1gxWTBPV05aU0c2TUdOcEt0?=
 =?utf-8?B?RmtkbDBFTzJlc0t0OHI1Q3B4Z0lOUGgrSHhTMDBacFRGOFNmN1piSkNtcHlZ?=
 =?utf-8?B?UzgvSGlvRUN2QVM5VHNjVnBHMDFlbHJoR3NSeEdZZVhUNmd4Q3kvVi9ibzRx?=
 =?utf-8?B?ODdoTXl1VW1VNmU4OTlmaWdoSkcrZURoRko0eHBSRWdOcWxZZ0VEc0JGQnoy?=
 =?utf-8?B?K1lualNRc0R5OU04aFhOUWk5UWN0VVJQek9pZU1QVEJWN2hiT0JYNmhSMENT?=
 =?utf-8?B?TkJtQkl0TlBZOW00djJOcFYxc2FqM2krSmFGczR4NVh6N2g1K3d4QzZvVjVI?=
 =?utf-8?B?Rmk2NnRMeVBNcGJSaTFoNG1NNnBhUVQ0V0w1YXJuRFhFdUNQMFEvTUErQXJs?=
 =?utf-8?B?Wmw0bU5ZVElZMEp2dFhFV0FzMmNVLzRwamx0SWZQU3BkUGxnNTdJZmVoTW00?=
 =?utf-8?B?VjdlOUh2UTVCUGZza0VkZzJrUGplRmQ5MUlNbkpnTzNWN3dxRVJCMVlwYWZ4?=
 =?utf-8?B?YmJKb1V3KzVFKzhWQ040aVR3eDQzUFMrLy9mZDlDclNKa2xGcXQ3d0w3OG5B?=
 =?utf-8?B?TWpUdjk1eFNHL1F0Q3Q4NDZ3R1k1TmNWNVlNeHhHbEpKTXdNR2doZz09?=
X-Exchange-RoutingPolicyChecked: i6fhV9nK6jFQZWLEZV1JVs6RlVHdTQBwmTUt9qr0F+2VViX/ZH9Bn1bi/rXc/ntg4NJ45SVYM1u57vUcMYQQ30AjP3ti5D9dgFPVoM8vCFEVCADrCWt/ZZncBYFT3Nor1YgPb08L6Ag3SDCk2alYDV5AQJ6nZPuXok2tcKU8F4eLJmGIAhAF0jGT0njqW00NdBMRT10i9lXarx0930av6LFe4DWLzFyC/kJKzIEfNfiD+9pd0fR33LtfkHVJ94+nBqkd692Tt3Fea6ssMloHoI/2MMkgo96b+4P8C+UUx0GteSh+lcHNuSPh4nFANC+E+CzZLpd05XKoMdyA5pn8KQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: bae2ead4-fbe0-4e8d-b48a-08df3fd286ee
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5617.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:02:35.3256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMtEgnljbCq6CgUnG/804PS8Bbcccje3pYGDzhYKUxzUhWblo+uFJS743e9APHtpykVfhE2vsFEERk617wjWdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR11MB087122
X-OriginatorOrg: intel.com

On 10/11/2026 12:04, Daniel Viaño wrote:
> On 09/11/2026 12:45, Ruinskiy, Dima wrote:
>> I think this patch might better be split into several patches.
>>
>> 1. Adding the missing IGC_DEV_ID_I226_LMVP to igc_is_device_id_i226().
>> This was probably an accidental omission.
> 
> Agreed, I'll send this as a separate patch. Note that it also changes
> the TSN code paths in igc_tsn.c for I226-LMvP (they will now get the
> i226 behaviour), so it would be good if you could confirm that this
> is correct for 0x5503.
I confirmed that the new I226-only TSN functionality (enabled in 
upstream commit b8897dc54e3b) applies to the I226_LMVP (0x5503) as well, 
so I see no risk adding it to the device ID list. This will make the 
L1.2 disable code function as intended.

> 
>> 2. Addressing the locked vs. non-locked call to pci_disable_link_state
>> (the possible deadlock noted by Sashiko) - this should be looked into a
>> bit more, I don't know off the top of my head what race is / isn't
>> possible.
> 
> I believe the deadlock is real and already present for I226.
> pcie_do_recovery() runtime-resumes the affected devices through
> pci_walk_bridge(bridge, pci_pm_runtime_get_sync, NULL), i.e. with
> pci_bus_sem held for read. If igc is runtime-suspended at that point,
> igc_runtime_resume() -> __igc_resume() -> pci_disable_link_state()
> takes pci_bus_sem for read a second time, which can deadlock if a
> writer queues in between.
> 
> The L1.2 disable done in probe is sticky (link->aspm_disable) and the
> PCI core honours it when restoring state on resume, so I plan to drop
> the call from __igc_resume().
Great, so yes, this is good to have as a separate patch.

> 
>> 3. The actual problem with L1.2 substate this patch aims to solve. I
>> checked with the HW team and there are two conclusions - (a) it is
>> strange that L1.2 is enabled somehow for I225_LMVP - this is not
>> expected.
> 
> You are right, and I was wrong about the mechanism. On my setup (HP
> Thunderbolt Dock G4, I225-LMvP rev 03 behind a Goshen Ridge
> downstream port) the NIC only advertises L1.1:
> 
>    L1SubCap: PCI-PM_L1.2- PCI-PM_L1.1+
>              ASPM_L1.2- ASPM_L1.1+ L1_PM_Substates+
> 
> and the upstream port has no L1 PM Substates capability at all, so
> L1.2 can never be enabled on this link. I will drop the I225-LMvP
> part and investigate the dock errors separately with AER enabled.
> 
>> (b) generally it is probably best and simplest to remove any
>> device ID checks and simply disable L1.2 across the board in this
>> driver.
> 
> I can add a third patch doing that if you prefer. Otherwise I'd leave
> it to you, since I have no I226 hardware to test it on.
Thank you for checking. Since you confirm the I225 issue you experience 
does not actually stem from L1.2, we can skip this for now.

--Dima

