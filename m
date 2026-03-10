Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D612701B8;
	Tue, 10 Mar 2026 21:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773179047; cv=fail; b=IhDMrKllHXDLrTfMOhd54ohvqv9eNLNWuHqRZ51KVCi55odYBVyUrGdbSw25/E0pbE5rFT/HL7Tj2vjrWxWswxBZJhB6Wi48xwrV2/j8M0+jDv359Br2dwmTTzQqrClfazbJM3psS+f3QYuD9qmvCjQ58C3+ZUTHYDmlE44ALDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773179047; c=relaxed/simple;
	bh=EmJfez24PBHccSh2hOBGHgyw9312gwBdaKLG9GiGnOQ=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=YR2g3Uc0hDVyEY7v4kgAw+18lrNxaijbZy0ee122l2Z7IZGWFpWK9oQIlWs0m7HVexm4zC2X+CbuC0lqesdFGd+kzXRES4+U9qluyOhOc/VRBtHjkZ9FEXH8awr0vTCALjWO6IS3M7dUK5HspAbEB00mo0+2hoJD86l7B6svqq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wv2lu3Ts; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wv2lu3Ts"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773179047; x=1804715047;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=EmJfez24PBHccSh2hOBGHgyw9312gwBdaKLG9GiGnOQ=;
  b=Wv2lu3TsBo7JZZ5W3C6dtYK7qHnabSFaSQYFySUS+/ifzxeaeyTUrN2N
   fbKLZTos5TBBFcd/XXaS2ssv1HnhwmucwAGSOGxvjYz/VzOn4CmMqMccB
   /SP06G9yqrmI5+ugr2H3TwgrTwA57P/INNr75XDYzyoSLmCaJRr1fNpwT
   GTkvV4REn1iZUAkvxd0MtvoFFUMlnTsNDrR/7hfCO8JQaESJzR7Q0HIJM
   fuJxmD3Po8pdFR+ECg5uq4soPYOhoOV2W+H3191cDKtO9nNO5my7lUpml
   FVpeWgcMj1Dtjv9yP+GvJMRe99lLY+pwIgOvH0KMIXY+y7ldxHc2nniv+
   g==;
X-CSE-ConnectionGUID: fLN9LxIiRRCAJZweQmA3Cg==
X-CSE-MsgGUID: cbzZ7h41SEClhyMVrZdZkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="61812795"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="61812795"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 14:44:06 -0700
X-CSE-ConnectionGUID: M7IkC/Y5S7SARTv0+4cKqQ==
X-CSE-MsgGUID: HomqcTyMTSuLCsjyTPSnrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="219367610"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 14:44:06 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 14:44:05 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 10 Mar 2026 14:44:05 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.18) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 14:44:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g+WIFMeVyBJpA5yQnCQQPiQUF/KQrhQPnSptbe/6QytaCJNrsCQ4+ox47v1rGeT8Ex4AWSNpB88RiZwBK0ukEODVEps6pedAepWwMIBTvHZYZ2xp3uiPU21Pv3cmJ1sAn9UVUQyb3oGYvehUqlSS60e+J4ma2orRbj+h1ZIBrZm4vCaLr4LBU3EEy/zVr3nv84LPnZyT/ft7bXrmDwua/q1XFeFLKGlHXm59R3ykCzf+vRsJkhyxkAppMiyveGHzyJefIizffGlA6Ry2OVgH5HI9ZekpFPrLw7fcMXnXq7OorPkGJHmysrsxMt6/qhNwjlNVT0AD8/+mN+OUAOHSLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03Zlje0Qe60uJg5ThhIzP6Bz6W0DOZQkbRfcKVzUHGM=;
 b=Fbeoi8EzvCL2G5QwKoEZtRHJmPZGpur8YrqIAq9iVHpe5Z0RLIymUMwgYBNQdzWAf+gDh8aeaQuI2Dpps//gvUzRYBUIll8IO2uzYcaWxCKGRJhRlHvRQhifekm6muceBlF8BTv5iGx2G/IhFmlt8iNkoexgC3LaEiOdlT36oTgfMrj4VuxscVC9Y2uN1hH++RkEhrLemQNIiUxKqy1uiYyY8wxV13iBr9sxm0TfzVz1EPCuGe1PnnS+chmxbkK7And/sBe/nHbUQuE/d6bciMjq7YvGMKZ0TgWfwJbztm/tlBGpsWEGjecLBU8rE+WVRopzoTtsUsvFnuta54XO9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB5817.namprd11.prod.outlook.com (2603:10b6:510:13a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 21:44:03 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 21:44:02 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 10 Mar 2026 14:44:01 -0700
To: <smadhavan@nvidia.com>, <bhelgaas@google.com>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, <jonathan.cameron@huawei.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>, <dave@stgolabs.net>
CC: <alwilliamson@nvidia.com>, <jeshuas@nvidia.com>, <vsethi@nvidia.com>,
	<skancherla@nvidia.com>, <vaslot@nvidia.com>, <sdonthineni@nvidia.com>,
	<mhonap@nvidia.com>, <vidyas@nvidia.com>, <jan@nvidia.com>,
	<mochs@nvidia.com>, <dschumacher@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Srirangan
 Madhavan" <smadhavan@nvidia.com>
Message-ID: <69b090a110f0e_490a100b8@dwillia2-mobl4.notmuch>
In-Reply-To: <20260306080026.116789-2-smadhavan@nvidia.com>
References: <20260306080026.116789-1-smadhavan@nvidia.com>
 <20260306080026.116789-2-smadhavan@nvidia.com>
Subject: Re: [PATCH 1/5] PCI: Add CXL DVSEC control, lock, and range register
 definitions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0170.namprd05.prod.outlook.com
 (2603:10b6:a03:339::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB5817:EE_
X-MS-Office365-Filtering-Correlation-Id: a9e28c47-4d88-457a-fdfa-08de7eee251b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|18002099003|56012099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info: mQjLbkaMGxJ3nn5noJgwrHw/twO8QmBWJkgJU/fhh5MhgZZAqqm1XLVDiKVdw/Gmt+U0dkkbCSJO3WpCJoYUARchb70g3gHT4qEOWpYydD0GJ6oaO+lbCCHSniBGxA7svbNemzLPb0W9oKxhVsj4gdZE7Qid4HAt10hpvo0rWew0fQCnWHx1clyw9k835p0lXmf7ewzTy72eBRFvJTJgneB/9dnJm3BX3FOlFXXLjLN4424nK6yssy2iNzsfmKz+vnEayhu2DHKXUJfFryLPe7ekLpAMygkLVubpItxk+RZsmdzNITi9/wRNnVjJc92NkE7BYP0syaCrGKyrmcExZY80ri/gC+i+qwUDeW/ZyxWLNjGMa1p4S7cS9Mlw1ozMVptVUO32qVqSLdUxJrdbAHyXRAXP5Zap0V1+yFMirUV3pc/1UyChVkL1arKHD1KEg9sDZzyZ8B9iTjO0cShIQX+/lv7UHeI0o7iAOE2VSAyNaM7PdKKe2s062eRuqNifqbvYwAa1QG7fN6A/U7Ct6Oml3L9toyU6iYZ/BqivRDPZR19KTIAcLWZ4bHJFZmPnk/RJ8/d1a79KNag9S/6Yt870nlVTlEGIDoRtucgr9mK6ieFEB0MsICRnZYlUH7vivXRHSfuB68IyM5kJamOamYE0ZH7FYW7zRtQcPD8E3Z5Ht6ADBq+WVbu7uTdnbVN6vMsQFAtTsmlIv5kksLi8uPBRiB3RohYT2H2zP9wwAa4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(18002099003)(56012099003)(22082099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0FYTWFPRDIzQmFRWHNYQjFNK2JCejRRK0M4dEpSTWNuQmFOWlBSL282aUt1?=
 =?utf-8?B?cmh3YXh1Q1BkMFlCaFZLU3czM0Y0UmxRbkRwR2VQNUswK3BHNVB3YzFCY0oz?=
 =?utf-8?B?dnhoL0pGL09hb3ZqWnNLVDA2a1V5YUR1cHBxT1ZNTnplWURUemoyNURjL2lU?=
 =?utf-8?B?dmpGVlBXY242WWppOU9yV0xpZmU3MTdjSEJ1bVRKSDBmRmZTbkkwZC9XZDJy?=
 =?utf-8?B?aHNNaXBCUDl3eUZmK0pwSDU5bkZCUCtaalZyQmNxQmZZUmFBVVJjZzYzUGVz?=
 =?utf-8?B?dUs0eURmekFUVkhzSSttSUtsU3hYa2I5VElydXk4VVZIeU5OK3JwcTNSZncx?=
 =?utf-8?B?cy9HbkdHV292elZFbFh6ZExIVkdGUExLbWl2dWs0cFlGSTRrY0hmTVpyUkYr?=
 =?utf-8?B?SmFxRDJRd2Z3TEJQYXJ0VElGeHUySWpPRDNveDdNcjNOSnF0cEdUQ0o1Yjcx?=
 =?utf-8?B?bUo3R3BiSng5dlVnNUVucmo0WnZ1OVJVNVlxbmE1Y2M0aUI4ektWZmFwMldM?=
 =?utf-8?B?dk9oYWhiWXZBODNoZGZsbWFaZHNKMXNsSkZDcFd6enpIeXpGazlBczF0YWlQ?=
 =?utf-8?B?SGFKS2VVdGpXUm9XeW1zb3hNRDJocXRLU2wrMSt2T0hvMGRZSTdzNDhmVmtq?=
 =?utf-8?B?Z2p0eXpKOVh3dGxBckljakQ3M0x5a1cxeGJUamxzN0FHTVJSWDhkaFpjZmQr?=
 =?utf-8?B?VzRpWlB1ZFAraWVpWExlaTY0VmxIS0dkRllGNlIvTDJtRnMzakZ2c1FJYVRQ?=
 =?utf-8?B?U2NFTC9nSHpHb1MvcEdkNjFlQkxKaFBsK2ZCM0VXL0UxVmU3WEhCeVlMamp2?=
 =?utf-8?B?ZXBGWVh5ZlhSN01iSWEyZ0t4d3B5RUpYQjI0ek5Eb21CV2xjcDdsQXcxWi9Q?=
 =?utf-8?B?Y1RFKzFscjd3L1prNFpWT2swWlJRSVRCRTBIeXZBWnVEaGJyWEw1eU5UNEhE?=
 =?utf-8?B?d3RoT1FJUmNKVGV4aHBncVVpdk1rWlVQdWtLTDZsQVBjQlh4YWxHZWtOcVFk?=
 =?utf-8?B?SnJIYW8xek56Mk9FMHhWQlpmQmt2bzN2ZEJkSldqbzlGSDQ1WGg0OFJYZHYx?=
 =?utf-8?B?bGJKOW1EK2xHOGlpRXlRTXorVE43bUM3VytmRGU0cmsxN1RXSmsrSVpwaC80?=
 =?utf-8?B?dkxzaFFndGdBZGE2QkkyTVFLL2dHWHd3YVNwTmpkVHl0dVR3MW1DY0F4ejU3?=
 =?utf-8?B?QWo2MklsSjgwcTdVM2FhZzhYMzFBaVlYZjBnVUNKSGZGY1MrTktZNkJPS0lj?=
 =?utf-8?B?NmwwbWxDZDlkc21VelZWdDFuL1RZZ1JzaDN4czMxT2ZVSTVqTU5TMTlITVQ2?=
 =?utf-8?B?alZPNHlHSi9welJ2MXloL0pZc00zRytJejB0VzQyTXd3aUNpVTFyd2NwL0lM?=
 =?utf-8?B?Qi9GdmFYRUZ1b2FuZjRnVUg4WDZqMDErZ1BOTDVPNmd0N3JlNzZjL0lHdkdq?=
 =?utf-8?B?TlFkMGhqZW9zZGlFOUtYdjJIT1BCN2w3S2ZXL1M1OE9pSGNmN2loU2tBOERT?=
 =?utf-8?B?Q3dpNW1IWnhQN0xoaFZYcXM2QlNvYUNMQ1l6emIrWW9yK3lwU3NIdzEyNVlr?=
 =?utf-8?B?NExiQ3RxYTRMWEJnMWFGdUtSZGt2Tlg0bkJtTTg5dU04cm9Wd2Z4QnpKeklG?=
 =?utf-8?B?MlNFSElHYmc3QlBYVFVMblprWm4xMS96S0RnWG9DUGhLOEx0eHlQRFR5M3lH?=
 =?utf-8?B?Y0JLRWZZOWFLMjdqZENZaGllRHlDc0RvcUN4ZHFKNkNzeE5rRy94OC8zbEEz?=
 =?utf-8?B?VDl0amN4Q1MyZHViekNrNU8wV1FEU3VkTmZYR3B4dWp3dHdrTjF1anZOeUZz?=
 =?utf-8?B?cmJ6N3lXb1FVbDIyZHJ1aDBEcEE0ZlRRZ3k2Wjl1dzFuUWRpVEtVdmwxSTRM?=
 =?utf-8?B?Vy83bjhaY1dJVGwzTTNscHczQTBPQTlnbGU3aDRNZ051N2x0QXpoMCt4Uzdy?=
 =?utf-8?B?azZadDlGOEJXVFh0WWptWmtOeEpkMHJhdnoyRFFZTk0wWHhqMDJwYmtIci92?=
 =?utf-8?B?YS90NS9XdkpKU0RJNUJRSXpqQUkrdUpVcTNuN2wwNVhFNXc5SERBWGZrMFpV?=
 =?utf-8?B?LzE4cHphNGxySnB1enMvUGp2amlBWmtaUEhCc3JPckxCVUtUdGUwOVE0NWtm?=
 =?utf-8?B?TEpDSFNvTER2R0RzM2Fqa0RZYTJjNVI0K0FxVTdzUENqYkJ0eExzcU9RSGpS?=
 =?utf-8?B?S3FqUHhGQTcvVHM1aVp3R3FJOExvQkVTdkpldm1rZ2RObzVTLy92MG9jSWd2?=
 =?utf-8?B?dy9UdHpXaW9ybkZQb3FhNjhWcVhBL1N3cXZwbDdXL2NIejk2R2xvU0M3bGtT?=
 =?utf-8?B?OVVDaGpiR2ZCRUpNS2NjcFpnS00xT2J5bTN3UERYNy9zYnRrYlZYTHVOa0RB?=
 =?utf-8?Q?ntchUHASDLkM5T9M=3D?=
X-Exchange-RoutingPolicyChecked: o+29OMUTcrTVoj7EW/uk0O0N4foIGVfmrHWUVUEzywhRY+UBWJcURqWw78p/2sskIwCjbOIx2KAHIcWNe8rm1GegP7pdfjXGYnwVqMhl+nSBn8icYJ6kND9M/XeCKZWqkZ4bh4sDeoSF+Ysqp/ZneMrUWFfm0rsfPbyVc6ecbGUW8Jt4bX/nYealsm5zmcwqPbbZhISgCUmGkiPfPk/VP/URIlxsjT0fG+o2TK7RkCsiIrgI9hYnoEg5eQ91pYaouFnZJ+BmIBnWOkDBvnctLBD1Yp6u4fhVFt8qJiHzAoD6cIItpGQsY9npDM05GZG2xYN4Y8D2ERcj/FJHRd1+BQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e28c47-4d88-457a-fdfa-08de7eee251b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 21:44:02.4601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lzO37EsgPAqzbmgo60kz5zAwEaDnh8MRcwRa5YUyc8Na5cbrebMZUDORDgpYspDgJJp3ydQTm5if/fBZYUtcXt4/MQIUP7egbEPxHteOU34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5817
X-OriginatorOrg: intel.com

smadhavan@ wrote:
> From: Srirangan Madhavan <smadhavan@nvidia.com>
> 
> PCI: Add CXL DVSEC control, lock, and range register definitions
> 
> Add register offset and field definitions for CXL DVSEC registers needed
> by CXL state save/restore across resets:
> 
>   - CTRL2 (offset 0x10) and LOCK (offset 0x14) registers
>   - CONFIG_LOCK bit in the LOCK register
>   - RWL (read-write-when-locked) field masks for CTRL and range base
>     registers.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  include/uapi/linux/pci_regs.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index ec1c54b5a310..6fdc20d7f5e6 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1353,14 +1353,20 @@
>  #define   PCI_DVSEC_CXL_HDM_COUNT			__GENMASK(5, 4)
>  #define  PCI_DVSEC_CXL_CTRL				0xC
>  #define   PCI_DVSEC_CXL_MEM_ENABLE			_BITUL(2)
> +#define   PCI_DVSEC_CXL_CTRL_RWL			0x5FED

This is odd, why is it needed? If the bits are locked then writes are
dropped.
