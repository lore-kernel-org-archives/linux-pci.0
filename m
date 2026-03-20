Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1309A2820A9
	for <linux-pci@vger.kernel.org>; Fri, 20 Mar 2026 02:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773975035; cv=fail; b=PNcNSdNEZHob6cfWG36w7XFUbIsFUd4fHovWkRAN6VBuX04x5vFa1c63G54nbik25c70b4b3e70UvuP6OyoQs6qZslFzK4gA37hK+vJvrnNxA03V1k1tXiEJAAqgvPuk8yKZnMesYC/VXdqo8M+b3BA3q2dx8I8SRF7vOuIh9xM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773975035; c=relaxed/simple;
	bh=JBve/V/Cj6RaZCg5tlKe6lzau+Sz5dmWfuu0oRa0Iwk=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=bFzR9GOQ9T3Cbs65G4405zmteQHx3O6G2NjlpPBLsFHumuXly/q4oI/5OuzKaKRBAKuEMtfXzFJH9DkxUnuWL0vGj8qoLLqFBtX/xHFx88R5Z38SpSytxTipF59G85hTMFM/VJg1Qaqv7Tdcu9BSObsW8By1I+Fcv+v1Kw3+1fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ndonUDps; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ndonUDps"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773975034; x=1805511034;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=JBve/V/Cj6RaZCg5tlKe6lzau+Sz5dmWfuu0oRa0Iwk=;
  b=ndonUDpse+lwFbNfdgsU4s93iReoTaLFf7giVJ4WplMIK7tTXVNV3pjD
   /FnrZud9W9bXD1KRrbnLDY/sKFkfYvv53ULD6budeRzM73yPjpubZ+S+P
   Fj4zj4Tx+Gz7lFO7CBrd67OnXNmmWwwK7KcW2bS3nhqWxqK64jHhsfyaD
   NXMNeWIspfEfgZNlijSOZuJney0G95qiQ+bpruqRib1R0xovpsrXGud2F
   ABDHe/5BUvhER/B/rZq/0MlvQIE4B3dHelkwUWJ7qspxnZWRFNIUwxs1b
   Hwmu4ZZr+qri2ICuxRIfXqhMkHhWrJRGqC4QFX/hT8tiuyEImexN4Cgyf
   A==;
X-CSE-ConnectionGUID: SOP8/xP0Tv6WDN4Nc0CKnA==
X-CSE-MsgGUID: 9CTUampmTBayxjM63bZuAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="75129951"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="75129951"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 19:50:33 -0700
X-CSE-ConnectionGUID: kUKv1FeHT6W+bASqbmVuiQ==
X-CSE-MsgGUID: jFLd0VV5TeyzSNOw8xct8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="219005524"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 19:50:33 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 19:50:32 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 19 Mar 2026 19:50:32 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.49)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 19:50:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bd8ZmZfOU5RWLGQNHmmBUYdU2ZQP1tR7Kv6mnalK+6KUGEES9/NuhkTZHr9IcbkY4t59lolO8MdtFgcSCh5lGgb3ZivUNGqp01Ls7ZtuZtdxCQvYqRQfU4Edd3k2X2WusdrH/od0D+7XStk0NExPfbUIFgfWscvp2Mojjh4K2sFiwm4m5rFU55UucVulCQxlEpTkVfRR1a+npCM4KETJPjkfjWHwIDiCbbboIu7K6RbJTPT+K9MMvnQueUN3ilKjaGB0+yatqgnhriSJUp7idUMincW3rHR5ljocKOKZGJrHDbiuJZrOW/NTzkv/rENW0cVHH1sgqVB1nf0KEY10FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8dIL0bCwALdkrrLWihwW5/LJNUKbn9BFlZzz3En3O9w=;
 b=JyNiGjmzwGAQyP1mXPTlB0b6R9Yc8iUn6vsIBn58Ah5OgFFzYkj1Gir5uL1/sV7spBsTBTNJyt9kDvOFEdBCpz26usGQa/XRObD8H61leDVUYD3e4repY158aBIL49mY8l4MBI30veAB9otWobf6NTJXiUB9qkhHCQCyt5sVR00daMlDYVCpTf5lOABEdZ7MKrg9qnqH48NSrnTs44iV7TwiwWsv84TVIiiULgY9Fkcb39+q6hXc94pJnOwKsC7E6RO+co52Rko8QeZEcj0n0rDKEjQ6e2UGCk2dIGOWffZuHur2HJ08/nanI6w2fKAnG54ZtHujNNxg5VoGqMWRdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7081.namprd11.prod.outlook.com (2603:10b6:930:53::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 02:50:27 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9723.018; Fri, 20 Mar 2026
 02:50:27 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 19 Mar 2026 19:50:25 -0700
To: Jakub Kicinski <kuba@kernel.org>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <aik@amd.com>, <aneesh.kumar@kernel.org>,
	<yilun.xu@linux.intel.com>, <bhelgaas@google.com>, <alistair23@gmail.com>,
	<lukas@wunner.de>, <jgg@nvidia.com>, Donald Hunter <donald.hunter@gmail.com>
Message-ID: <69bcb5f1412cc_40c0100ac@dwillia2-mobl4.notmuch>
In-Reply-To: <20260318170014.6650d2bf@kernel.org>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-9-dan.j.williams@intel.com>
 <20260314111245.76d18d73@kernel.org>
 <69b8b234177ea_452b1001a@dwillia2-mobl4.notmuch>
 <20260318170014.6650d2bf@kernel.org>
Subject: Re: [PATCH v2 08/19] PCI/TSM: Add "evidence" support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0244.namprd04.prod.outlook.com
 (2603:10b6:303:88::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7081:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a3fb48e-124f-4ed7-e3d4-08de862b70f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: muHcEIakwZVWtkb/5X//tai/Lf3CeNUAiCfEu0F0xX7fK0SLjWes5LW+6G6VoYRLMZpp/Gvn14LCS0TNmQKStG7hTpN5Q0Za1NcdJ6LJuAg6KMWDfnt3u+b5cbUzs+xlhT1Xunm0opNLLb6q3rasM/KtBHxd2RuHMpWynFsnL75fb/skHdxKPFq6xMLxLeQLYGuq6eJ4iTYUonlvWqnIvQA57YloCjjEcV7R6HFROSKhFbLGmUKdnPuADEMfAuitIqnseFvjA1CDYTnERLkcpeTiv+ME5Y+KyXk4bqM5Hg9rlaASKmC+D40J8CceaTW3eu3bEZCAzEJaLxHZFCEaAeAZ6i9ZhVRHR0R5KNX18h5P68/kQD9BUxB1O4yKItGF2DvFjbe7dPCmOOslo7DPr+9w7HzpUBYGnEj9IO93+7Pz0QiYtINbgtFWXAlBTR5+i9/4w/wDFIV0dClLLi41SKoDx02eIv9m6rEz19EdlRAEKSprGaQyWyHIHNOD2eNLqnw6IU3gC8qYVf6OCRjPQEBpwC8XwKvejq3toX8T9nDPWjOcus+cVP2buXMoDMaoFV/wOzaU1ZcH9fWJ26Xo9xWPFmrNiyLOgtiNPriWXqys5gDQTO5f9sWE15k438bR+AWqwXB3H5pu6I0jaE9ofuq8yIMCXi+zsvhh0Kb8oYrXmN8nPrfRSl5QG7QQFDCcea9C7QqDZc6MlrVfJjKHwXNrfCTYyKfcmknP1/NJp+E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUdOLzE5RFo4RDVURVBjZXZHblpVVU95aVhrWnpheVlvWnFjNlRwazRWZE42?=
 =?utf-8?B?bElWVU1LRmNNNmNXWkd1MTg5d2JCT3N1S0U4d0VGck9RTDNIN1JTbER2dHAx?=
 =?utf-8?B?U1hBMCtGZURpV2t2cWFpa2FENkNNa2FNMTd4NU9RYVo5UCs3SldESUhNaE9I?=
 =?utf-8?B?Q1dudzQwL2FHcEdyNE52RGpLOXgzYmdhMnlvTEgvaFlPQmlpL0dhTW1VZkRo?=
 =?utf-8?B?RHdOZ0U3NjQxZEM3MXozUnYrTTdyTE5vK1F6SGs2enR4VkN3Q1dKZEFGZnV6?=
 =?utf-8?B?ZndIZUVtRm5CZDdOaEZaZEJ4Z2ZGVHZxekt6YkRkQ2Y4OWxNZzQxbkhScnFC?=
 =?utf-8?B?OVBFVGdpWDBSTUpKZVU5NDBSNkVXbk9hOWtsTnk4UjMzUUJKMlZNQTdtM3Q2?=
 =?utf-8?B?UzhKSFpkb1VWTW96c0VJUVZCdjJjOUdSZEZrSHdRTFpHRzlsb09YU2lDdVBu?=
 =?utf-8?B?ZUkrc0RtNTVYMmRmK3BLQjQ4UXNZTlFXWkZaVUtaUjRmZGpZUW9idXhsSFpz?=
 =?utf-8?B?b1lqK3A4N2s5MGx0bTZsbGdzN0s1T3B6NzhlVk5DeGp1VC9OQ2FnakpVMW45?=
 =?utf-8?B?dzBBZGpzL1ErajAzWjNId0NWRXlTQkF3VVRoS1Rza1hqaFh0OVZodVNBSFNR?=
 =?utf-8?B?N3d0cnVCOUQ3WHY2Wlc4TmNBQWc3LzMvNWtJeFhUdUxkU3Z4TXRDYlpEVmdB?=
 =?utf-8?B?Ujl3R2x5RnBZcFBxWEs3N1hKbDg5aTZjcVNHcmgxMk1HT2dmblBiblRUTVYv?=
 =?utf-8?B?M2RqWmo4QzFGbEsrZUdJVDQwU212UVZSaWpGaVR5c1owanY3OEFuWERJME9y?=
 =?utf-8?B?b3lURWZXQzgxZEtmcjdtSVlxWEM1SG1GbjVvQkI5WGxvYzR3VEVsOHkreGUy?=
 =?utf-8?B?UnJkWk5LeG1lUEVJR3NXMlMvTzdqWnpFNkhEdG9RUnlwbk4zVW5zYy90cGF0?=
 =?utf-8?B?WS9aN1hRTmxHbW0wOWZoa1ZnK1lySndENTVXMjA0aEoxRmhYZ0pGVnVyT01l?=
 =?utf-8?B?T2RHbUUxUVFKeWlnVEpWandMMm9VRkcvNERBeDF5Z1A3SFc3MEdPeFltRXF1?=
 =?utf-8?B?S2NPNWQzYlA2dzBkQzBJZTlWQ0ZXeExtc3MzUUg0UG1tRWFxKzdEMW12dnR2?=
 =?utf-8?B?YzlaUG5NMjZGUmxOWURpZmRIQmlnWnlEcVc0c1ZFTytBV0F1dTM1WmZYM2V3?=
 =?utf-8?B?VFpUVjRwQ3RGRVVRUUdNa3BmNE1yQk9LMzM4d2JIMHA5MkVpTGh3bWY3Ty8x?=
 =?utf-8?B?bmFMWFdEKzhMc2lWalIrMEJrWTZnbTFsUnowdFZqY21YeVdpS0YwUno4ajAy?=
 =?utf-8?B?alM4YytYOVdZQlVrWTNYK3IrTjJFMldSK29BRnNWWmozSktJUEZSZmhwcEtn?=
 =?utf-8?B?ejNQOXBHTzZQaE9LbENUdS9FN0RFQ0lLWHhxNW9uYWcxZzYyVWlITWxrMkJE?=
 =?utf-8?B?OUUvUEx2WVZiNDdXSEwrSjAzUThYTFd6OE1xWTArWjhFUnpReFJJalkvVDNI?=
 =?utf-8?B?eEVuT2RrOUs4N2J6ZDUxWG9qcDZydTVDcU1wU3FsdnUwUzR0cGFsY0N1MTh4?=
 =?utf-8?B?S3pSYllReGdzL1ppUjZKdktMd09OSWJQNHNuaXBza0VGanJoUnM1Q21lRGM2?=
 =?utf-8?B?VzVOdm16SXJ4MEZ4WXRZWWc2emhKbjZZQmFxaGpaMjRxYWRmNStoK3Zya1Vr?=
 =?utf-8?B?Y3BTa0ZIRmZxcmIwRmhPbng3cGprSUgyRmhoNGRvbVJZRnN0R1Z1R2NWd0FL?=
 =?utf-8?B?S3UyV1lnZW81dEN5ZHVVU2srTmtGRlIrUzY1aW02am15NXJINzFOSC9lY05G?=
 =?utf-8?B?eEFNc212THpubExpSUZ2T005WWFDRW51U01CUE4xa01DQzEwN0lMS3FRSFRL?=
 =?utf-8?B?T3JVRE5TM2dQRnRFdWthQ2JRU1A5dGFwMVIrdW43MjJTK2lYd0NSeUgxdmJJ?=
 =?utf-8?B?cVFjeGZqb2w1RkVCU0d6aSswZ2F6OEhGUTluVXd1eGF2TkxCTnNNYUtmbUFt?=
 =?utf-8?B?Rit0aU5qNk8rMlByTlZFcjZvdGozVnl0R2Y2SXYrYXhGc3U0ZmtXcTRCcVdy?=
 =?utf-8?B?VWJZVHV3elVkN2haK29vdk5xSXI4YXZ2azQvZ2daYTFWbWc4R0ZiNlBCclV5?=
 =?utf-8?B?K1djL2RaRjFxWEtHeXQvMkxRUjZ3aXVML1QrUk4zTGg5RlBqakoyMDQyK0cr?=
 =?utf-8?B?KzJOaW5WSmROS2JsSSt4dVlwbW04V3piMTJNR04vMnNJT3pzZ1lrR1JxZ0p0?=
 =?utf-8?B?NkRraGR3dlNCMnBZNmJWd1pHWVZSbFZlRmNmM251c0tsL0lreGZrUzY0Q0tz?=
 =?utf-8?B?b2gwRnBOUzkyMm93YVJuWWVQNStveVppd1U1MEM1SkMyMUNmMDhrMkxlOG0y?=
 =?utf-8?Q?V+AyiAQywBnhaVSE=3D?=
X-Exchange-RoutingPolicyChecked: T2hPp3LGwScnd6xYPApR5th5zoco59893k5mJ26wyeaDciRFEVDqYuMakxFUxwe3CiodsvzWKcy+hXZ6HsSq5sDf5nOMUse+k5PdFYA0fzjNxTuHsapGdnqL9AijfdHQD6F/PhSXR/+0/siyXg6LDmFIW/AM0Z0u5lZniYfPzQ5la5VQrVBDkGfU8itG4yjPegQfaCpR9GrHP7w5iJnjocH9+PVEQHcYnY5watU8OmVx2+Npy4sNkHlrzkUoSOBHympIE95EEJqyUoKtbwx7YrTLuNVpeB2S2HfPnY1L2uBqyFow8QScwqXCyI0mO1mbxrynDvw2etcXEMfpfBTzZw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3fb48e-124f-4ed7-e3d4-08de862b70f2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 02:50:27.1859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y0zG/Vd0Vfha6FECsaVzB4rhsViXMpT+0pgCgklyZ6ukHa2oQY5L8gO4qC5ub4kTs7LOe3CJhSCSZXGh5WtPel8AxYTt/V6kkkGL24Wy6tQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7081
X-OriginatorOrg: intel.com

Jakub Kicinski wrote:
[..] 
> > > The main strength of Netlink is "do" commands with multiple optional
> > > attrs.  
> > 
> > Yes, that is attractive and saves a pile of bug prone ioctl handling.
> > 
> > The gap I need to fill first though is a uAPI that allows for large
> > blobs to be fetched after being regenerated / reformatted besed on some
> > input attributes.
> > 
> > "Multi message netlink attributes" while inventive, feels less awkward
> > and more future proof than a sysfs binary attribute scheme to do the
> > same.
> 
> Alright, so to make this more Netlink-y you can either:
>  - delete the F_MULTI and replicate other attrs in each message and 
>    add an offset attr; this will make each message in the dump more
>    standalone. 
>  - keep the F_MULTI but object_val has to be a multi-attr, and then 
>    we have to teach YNL to correctly append the attrs.
> 
> Former is definitely less work. Latter could end up being cleaner
> but there are some unknowns so hard to tell for sure; more plumbing.

Makes sense, and not yet sure which one is lower maintenance burden
long term. I will play with it a bit.

I am leaning to the first option more for the fact that it puts the
burden of being strange squarely on the implementation that wants it. If
this discussion attracts more large blob dumpers then the second option.

Thanks for spending some attention here.
