Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FED42DCC04;
	Thu,  2 Apr 2026 21:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775166767; cv=fail; b=Brcs3RRXEVdNZp6I9eefNUyXYGXLIaMr0WPh/PuxothxZlXtFtJWwP4N6+uhvHcE3xQhC0dyFrdccZcGN2UltqI6CQKiUVKv94tc0fs1gnILtzIsbACImEclmRwLmdSG8JGZ+sod7MBKEsZm0vlR1Xc5o921P14+tQ7LIWhkqDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775166767; c=relaxed/simple;
	bh=nYMPxwNFAS/7ergCLxnZO9ep37afcjL2xyFA7AOxrDA=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=YlmQ4Ge+BH18ZOCGVdHrpZQ6cXTMjCLcP5EJUc8Ejbtp3B5oe9FfOoLxzGGwOw4rU92pM+n6KxPoYNfnyaSVAMsiw7tU4PeyVoi2+Mt2kXqOzZUi+eLoJLfjVMLlqB9yNtYJsPtjOqv72Gxn06qUPZ7KVrbgivcYrXqHfH3S03o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eJXFwFMJ; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eJXFwFMJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775166765; x=1806702765;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=nYMPxwNFAS/7ergCLxnZO9ep37afcjL2xyFA7AOxrDA=;
  b=eJXFwFMJmqcmBLGD0JOuoxIsgRZtiNUgf/OtBNrRDFaa3yKSOHmElaW6
   HdHpYHylt4G8pNhnjwavuIXvq3lqNVGlaT6gr7t8HMPKMvGs8fDHGqiBM
   dm962bMR6AkbBqjFd+uHzEIUoXOZuUkwh9ZWllLI0w/zHCFCrViw5HOS7
   jtjQXcZidFPogQyEweMVTfLcrZPF4Lu7WDQx6Ak0yIteHm9qyNFhab/vJ
   uyUshjG1GIJXCsJItFM36GsKUtFuGLaUMgo/dtsL5JCoV3EKw7rZ9HZj9
   tG6J5j1waDoHNUmPD6EaHLHSTLucQHz3IpmnE/h5D7wya5f6fIv6a7NWQ
   Q==;
X-CSE-ConnectionGUID: kKeCSx0xTkCuQnWHIrPyoA==
X-CSE-MsgGUID: gdYPTz5NT56kXketvW/XIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="76127419"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="76127419"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 14:52:44 -0700
X-CSE-ConnectionGUID: uQTzeFnxRAy74K4bTkbjgw==
X-CSE-MsgGUID: AE1+WaUrQYugy1fmoDeRWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="223815491"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 14:52:44 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 14:52:44 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 2 Apr 2026 14:52:44 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.67) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 14:52:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QfIF21htn8Lny9Ee9cx6/VZUH2mvFOpRhxr2yIPwv0U6jpiYPeVEUjRakG2TDffoVdl14CzDQ2z0IHs4522JAMyqO0U/LJgFOvvV74YpkbybJAOPQ/BPovXBWIlMxvt2NbFqWyhfwXJjUgTM5mToUWN04M23B5/lYGaKa/9q7pGaXoE9dz4i+xbGmFgYrdfQbfMkPt27Wy81DA92jZyVByGtCBgYHt+0Zjth0f1fuQ4FTJLb+Rso5CASc/eO11MEt/3FAgZkQQCnpugarWohgBGG+RJAK/0mb1wofSlGZ9pj4LARuBPpi+myHUsswBxH40UZAMutzSueb51Ae4Oitg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrLJGQSYSjtJcjmYO5fOXmLZA1ntb2HQvWH4IE91x74=;
 b=kZE2gYtNt/77YYW+Fj4krdBuw5Tin70lSVxb4Ru1Qes0CmWLehZplM9QxE/9IvHNxj4CIuL6Mg7PqmbJ9O0AaAamNXB/mO3yThIhZoIJp9SEPhOAd6K721DuUzc/+CjHKqiLM1Kpq2dWHAdUeRNVK1ZuF1TJXRC4EwkZ9eHoovyBrgNllRdC9Wt3NdwDklhHgWD3LyRAGU3LY9WGL7BCpGIhyMH9aXk5T785kj50Xsxhm5LoXd4wB8i9mn4aOJgsG7rnWFsYPbQQnwfwzzSqRt5TurUH0MJVE8nlNmKZX236SJ1fY3+FcYM1AeUxtOmo5TemC2YysY8vWoxQdXN+6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8517.namprd11.prod.outlook.com (2603:10b6:610:1ad::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 21:52:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 21:52:39 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 2 Apr 2026 14:52:36 -0700
To: Alex Williamson <alex@shazbot.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: Manish Honap <mhonap@nvidia.com>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, Srirangan Madhavan <smadhavan@nvidia.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, Jeshua Smith <jeshuas@nvidia.com>,
	Vikram Sethi <vsethi@nvidia.com>, Sai Yashwanth Reddy Kancherla
	<skancherla@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, Shanker Donthineni
	<sdonthineni@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>, Jiandi An
	<jan@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Derek Schumacher
	<dschumacher@nvidia.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, <alex@shazbot.org>
Message-ID: <69cee524adfd9_1b0cc6100f2@dwillia2-mobl4.notmuch>
In-Reply-To: <20260402150131.0abe12e0@shazbot.org>
References: <20260306080026.116789-1-smadhavan@nvidia.com>
 <69b08f8d8eb97_490a10042@dwillia2-mobl4.notmuch>
 <20260310164630.7abeed30@shazbot.org>
 <69b0c934b2793_2132100ec@dwillia2-mobl4.notmuch>
 <IA1PR12MB90304014081461742C3977F4BD41A@IA1PR12MB9030.namprd12.prod.outlook.com>
 <69b98960907e9_7ee31003b@dwillia2-mobl4.notmuch>
 <20260317121943.3c404db9@shazbot.org>
 <69cdc273ca48e_1b0cc610042@dwillia2-mobl4.notmuch>
 <20260402150131.0abe12e0@shazbot.org>
Subject: Re: [PATCH 0/5] PCI/CXL: Save and restore CXL DVSEC and HDM state
 across resets
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0027.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8517:EE_
X-MS-Office365-Filtering-Correlation-Id: 10f4427a-f73f-41e1-bcd5-08de910228b1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: UMqsbTyNKuZiUPaMjVu+BRE6/j07dR2RW6xEd/0b45Rha3OWo4NCwwsVuelMPa23GVCOjV98YpGdfbtjCaugi/ZGMD5VCUYh4es0E7lN3mTSg8vlcWIGAbOCSN/AQkPOFI3NzdTdNaghygWl+ENnbHICxNYCnqx/QVDFv8jW/b4/hkZ07wtVdguwIGboZBfWXdiOSzN5V6hUOVsyFYNYY6pxrYOEaeEzYm9JAQ5/FF5ZFPZ31CC5dZujLyWkRuwhhtI5DG/QRu6kYLuD0J4CKcVANuRyBR59bn5FLJz4zNrg7Dp8Uv1F6Jug1WEpZEKNvP45lNtIC4IqWPk/qH05LwEjBr4j/rKNluExH9Knq3jpGNKDx3JL3QBLf2xZfpw0HLwjaWQuIeK7kSvF/Ez/O3Z/SM0RvtvRg/3Hnt+UsIh7qP9vt/8EeN17ClALtc5Q+ofR5GwpEwU340ak5HD4BVakeReszfaa9VAc7v9FQAPa3N43PyylKfGxM7pnDKpJB0aGCygQDFrQl3YpTo1EMb9ZN+yZZboDqmh7rmUOv1GBAwp4OAHJs2+Kie6kZQKaw4oOR82CzKxkls/QHcvMGY0oKRu+zB3pwDTVaA0bOtucUoHew2dqwEpxoZczoIyfkkNowHKLg+sROlwiy1KH0gUk71adfhfU1Fh/LrxXrROf4rhim5MeIv77Rvtqk9K9An1JYKjjo9nTRg1JUyXG/ceIBtlmcpHfaZIqk2ux0FM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTBDa2s0S2VBWWo2Z1VteGJhbFFNcSswV092cnp2V2EwZ3dXdjRySUNnZmlt?=
 =?utf-8?B?TFFnZXJIOW5rTzUydVlVd3FqaDAwbjJpVE15U05DdmNRNzZWemNMbmNhVjUy?=
 =?utf-8?B?QXpabGxyM09naFFXOHMwWDE0cjNzSEdmM2Z2S2U2TlgrVERzWXpJZy9oMWpW?=
 =?utf-8?B?UGt5S2ZJcEhmbGEvWWtKVmNEaDNpMWNjU0lkWktLMVlPRXpKZExxSmZEb01x?=
 =?utf-8?B?bHlBaVFjemhybGN0aUdNK1plUXBNdzRNbGVjNW84bXJvTzJ1Z1pyT3F6MEty?=
 =?utf-8?B?Y1hvREY5YkpqQUc2M0g4c1FWVGZLUGZtREZXTFR3YkZTL2tHSW9QamMrZlNt?=
 =?utf-8?B?bEFZWGV5NmZtelNjVVJTSkVoWGxlUk1IbjRLY1dsaEZWcFlqcVVESldwRzdj?=
 =?utf-8?B?WXd1T1c1ckwrWXdrZGtpVjE4OC91cHdCSVVkSG1IdzBOekZ4Tm84MmtRMEN5?=
 =?utf-8?B?TjNqM3JmZjlMNFJEcDAvYXpFOWRMMC9qTWRLVU8xcWcwV2t2YmlybFZsTDFw?=
 =?utf-8?B?aWdDYnBiU2ljQWNsbkFEL0Vzanp1ZW9JRXNrcUVxV0N1bm5wdlUxSUNTeFN2?=
 =?utf-8?B?NFpRZDlSZHI1MEJBYVBzMTN3SGRDYks3d0FJQXBkWDN4WWRQc0VweWZpak9z?=
 =?utf-8?B?bXk1M3l2UnVHTGV6WEpNS08wd0tNaWp0THNVTWtRU0RHaXVPTE9sSTAvVUlJ?=
 =?utf-8?B?TlEwK3NxOWVJeFAxUnZ3eWlRcDFrclFOaXl6TlFwV21EenR2VWJBaXVLc1J1?=
 =?utf-8?B?NWQxeHdvd0M0dUFLQklzbVFIWmFjSUpUdEtpN1V3dkwwNHhMUVlON3lRbDVn?=
 =?utf-8?B?aENENnV0RDRyVkhYWlhvKzhIdGRkWUo5Z0RJdlZZWE1JU04wRDlnNmRram5N?=
 =?utf-8?B?YVlQOS9kMCtzVHNxTHBNM0VEY1IvWnV2RXQrdlRSWGRMbndWelFYaWhhK2ZW?=
 =?utf-8?B?YVp0R012TFlZNDdJVFpmcVkrR0U5WWsrUUkwbGNCeDlMRjIvUi9yRldTdUh1?=
 =?utf-8?B?eHlFeGc1aUJkT0trc1BIZTBMVVd0TnQ5MnhOc3c5WjBLbnlORk9wbEtsMGtB?=
 =?utf-8?B?b0FDQktvK1B3WUlvZE14TlVUc1c0MUhjb2NpRUtUaEJQMzA5ODNydSt3S010?=
 =?utf-8?B?eFNid0xDQVpLOVBBWlFRNUxNMWJZelM2cncvSG1NUitwZEJnM2cwK0RLUnBZ?=
 =?utf-8?B?VDZXLzc5a012bWpkY0l6azRBc1NUVXRjbzRldnQ2b1FFNG1hajY1aTltc2x2?=
 =?utf-8?B?ZEZyWEMrVG9IZTRYL2YvR0MzR0pRTnByTE9vVUxEOGF0bmRPbjdNbFVDYmtk?=
 =?utf-8?B?dCtWNmlLdU9uRVNMS1lpNGM5eFR3TVdTMW9TYjZPS3FxY3JsR0cvL1kxdjNi?=
 =?utf-8?B?Y0tEMnFIUVBLU1B3S3piWjJHODgzdFpvbDBScHk3b2s3c0NuWExKZnFUSFYy?=
 =?utf-8?B?elVWaFdvNDJxekFOckJYQjFzVWxmNklZQ0xjQ1pQVEpkeW05MFA0UDM1OU9o?=
 =?utf-8?B?NDl3QlpBRWJHMjNmY2lYVW9YRzNLOFJMTXZ1R2RzdmRRWjhSd210dmV3d3FS?=
 =?utf-8?B?SnpXd3dvTVlkSU4zQzNacS85SFU3ZDMwL0wzOTVtZUJjZVNPUXpGa2FkTk1o?=
 =?utf-8?B?Z05zbHpQNWNWOXhHMW9hUUF0R096U3BpQkxHVlFDeEM4SDlTUzFML0RLaDdq?=
 =?utf-8?B?ampzdUUyc0UyQjdPMkVEZGEzUjZPT01uM1YvTVB1V1FpTkg2clFaL2xwY2hO?=
 =?utf-8?B?b0huRjBBRU92N2M3WU1WcEk3MHRvdUh4YmQ3SnFObW5OYkJYbURacWVRSkpI?=
 =?utf-8?B?NEZHLzErZndZZXFCb0V1RndIb2FQcXlEQlZ1RVA3V3ByWDV5YnA0R2RwTitQ?=
 =?utf-8?B?eUJLZjZsaXFvY0pkaEpsK3Y0cWoxOGNac3MzS2c2NnpOeXFGQklQU25qY2Jo?=
 =?utf-8?B?V2JDcjY4aXBVY2xhTVRCSE9aMFNzMi9CbHUySmRwNUZpSlhPSmlzRUNvT2F4?=
 =?utf-8?B?V2JWRThpMXl0bFY2aUFCaDdGRGh5bnpGdEs3Y0paQytIbW1ZNlliTHRoTUVR?=
 =?utf-8?B?MXlNbDRnVUU0OGhFekhCTHk4ZGhpM1NJcTFhLy9lUTB0U283bnBmY2d1c3Rn?=
 =?utf-8?B?dnMzU2s1ZUhraVlwNVZ4YlZKZDl6OXpBa01DWnl2ZUZyV1hGL25lRnRuQzN4?=
 =?utf-8?B?d0lRd2JRc1dUSUlmdHZXWHFNTWxMamw0b3U1WTQzMTVsQXByVjFEcXBpbkY0?=
 =?utf-8?B?RFpMNTgxOGM5bXlIc2t1L1NIRHRmOEJMTERQZWFzQVF1WXM1elZjVnNVcE5k?=
 =?utf-8?B?THZuclVXamNsdStjVUo1c1hzNWZlaDBiaFJYZlB1WDViTDl6U3NkT0FvMngy?=
 =?utf-8?Q?efqVh6i2gmQoqOg4=3D?=
X-Exchange-RoutingPolicyChecked: GEWkAU5DQ3MXRBhI2OE/yFj3mDR7bRWe3EvCt+Ah4LaWhs0gLiCCx2Rx3x+a1qQ/gkjOlmTQgX7yetZtfrrBqE2R6Sa3VX6s4ucRAk+6jx+DlupC57ebgJaq+S3XqmylEZxdITf3HQKU64CNzuvn7B2FIQbTxuSuPYMYTrcaURZJD1/c9E1u6vWzJZYA0TcQWjgYm60P8mLZZXeI/uco56aOm+Ncw5p+A50uewqJ/nFAPnia1WaOPOVgPZ27xMV7Opl8veaOEbQvyR4mUmmlcczORE64eUJP9+SL+UC7smvgns7roDgxV+V+/iniDxC2e1BoEwM+2cVh87S1uUoG0w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f4427a-f73f-41e1-bcd5-08de910228b1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 21:52:39.3221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 54kYZS/2giRkotds0Azwr+pwgp5T+45Z5CuoKW+D+lBaAXk8wswoP+9SGAnNAZ3bhGaf0ULle8GUcGynbj20OtBxlUzSs0FoO5LW8bPqQgc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8517
X-OriginatorOrg: intel.com

Alex Williamson wrote:
[..]
> > Now a follow on concern is the plan to manage a case of "PCI operation
> > is available, but CXL operation is not. Does the driver proceed?" Put
> > another way, I immediately see how to convey the policy of "continue
> > without CXL" when there is an explicit driver distinction, but it is
> > ambiguous with an enlightened vfio-pci driver.
> 
> As an enlightenment to vfio-pci, CXL support must in all cases degrade
> to PCI support.  Manish's series proposes a new flag bit in the
> DEVICE_INFO ioctl for CXL (type2 specifically) that would be used in
> combination with the existing PCI flag.  If both are set, it's a PCI
> device with CXL.{mem,cache} capability, otherwise only PCI would be set.

Ok.

>  
> > > > If vfio-pci functionality is also a library
> > > > then vfio-cxl is a driver that uses services from both libraries. Where
> > > > the module and driver name boundaries are drawn is more an organization
> > > > decision not an functional one.  
> > > 
> > > But as above, it is functional.  Someone needs to define when to use
> > > which driver, which leads to libvirt needing to specify whether a
> > > device is being exposed as PCI or CXL, and the same understanding in
> > > each VMM.  OTOH, using vfio-pci as the basis and layering CXL feature
> > > detection, ie. enlightenment, gives us a more compatible, incremental
> > > approach.  
> > 
> > Ok, to make sure I understand the proposal: userspace still needs to to
> > end up with knowledge of CXL operation, but that need not be resolved by
> > module policy.
> 
> It's a single module as far as userspace is concerned, and the decision
> lies with userspace whether to take advantage of the CXL features
> indicated by the device flag.
>  
> > Userspace also just needs to be ok with the unsightliness of the CXL
> > modules autoloading on systems without CXL.
> 
> I'm open to suggestions here.  The current proposal will pull in CXL
> modules regardless of having a CXL device.
> 
> We could build vfio_cxl_core as a module with an automatic
> MODULE_SOFTDEP in vfio_pci_core.  We could then do a symbol_get around
> CXL code so that we never CXL enlighten a device if the module isn't
> loaded, allowing userspace policy control via modprobe.d blacklists.
> We could also use a registration mechanism from vfio-cxl-core to
> vfio-pci-core to avoid symbol_gets.

Probably just wait until someone really needs that small bit of memory
back.

> > Implement features like CXL Reset as operations against CXL objects like
> > memdevs and regions. For example, PCI reset does not consider management
> > of cache coherent memory, and certainly not interleaved cache coherent
> > memory. Other CXL drivers also benefit if these capabilities are
> > centralized.
> 
> I think "CXL Reset as operations against CXL objects" is large already
> proposed as [1].  However, it's specifically for type2 devices, so we
> can ignore some of the complications, such as interleaved cache
> coherence, of a type3 use case.  

Nothing type3 specific about interleaved cache coherence. Now,
interleaving for accelerators is not in near term scope, but CXL.mem is
coherent. I do not want to paint the design into a corner in case
host-bridge interleaving for bandwidth becomes a consideration.

> [1]https://lore.kernel.org/all/20260306092322.148765-1-smadhavan@nvidia.com/

Still playing catch up on review, but yes, that version looks
directionally ok and at least has a chance to be extended for
interleaving.

[..]
> > > This is largely a consequence of CXL_BUS being a loadable module.  
> > 
> > Yes, the question is why does that matter for CXL enlightened operation?
> > Simply do not burden the PCI core to learn all the CXL concerns.
> 
> How do we then proceed relative to save/restore of CXL state based on a
> PCI reset?  Should CXL core register a save/restore handler with PCI
> core or does PCI core reach out for a symbol from CXL core to support
> save/restore?

I am currently thinking CXL registered handler to enable enlightened
reset, or direct CXL uAPI.

Is it not safe to assume that new CXL awareness in user tooling is
prepared move to new CXL aware reset interfaces?

> If CXL core is not loaded, are we ok with silently losing CXL state
> across a PCI reset, ie. assume that state is unused currently and accept
> the risk of losing preconfigured decoders?

> Does PCI core need to be involved in suppressing SBR?

SBR is disabled by default. It can currently be destructively forced
with the PCI "cxl_bus" reset type.

Maybe what this wants is a new "SBR iff single device CXL.mem and mem
not kernel mapped", to set aside the "but coherent interleave" noise.
Just not sure it is worth introducing the concept of "device rejectable
PCI reset" vs requiring using CXL uAPI directly.
