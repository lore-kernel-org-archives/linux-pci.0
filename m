Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3163A9879
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 19:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785268031; cv=fail; b=OB71WkaJJ1y/0NMrpee7GFfc6AcWqqvGhFQUU0k8CnEZSSocIOM9ckk3hIaNest5y7Qup5X2ubQi0ITqvVCqtb790JJq86xj56rdD2iSflnb+lqDGA9tLDPrTg2NAP6ZycLAFkvPAAlX2JrJS1ww21F48+1b1d+NeBIIqjkf+SA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785268031; c=relaxed/simple;
	bh=qCM8Fd/Z9nDhHpecwuimcvn+n2ocvJMNjZIaPMErRzE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aIMOVkfQmpyBWkWctG1GHDbxC0xp70LFsjf1f9QZv6rH+dTU2JJK7vL659VOFzd0mUoa1H1F27KEZ9kndhU+PZhGLpZlGELT5TArLWFK+9YRlFziI8+e1VrNVTaTorB+omi/F1uEZt52gcSwqhFZE/Ie3WVKAircgHFo0Eg3XIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HBmAA7zU; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HBmAA7zU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785268029; x=1816804029;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qCM8Fd/Z9nDhHpecwuimcvn+n2ocvJMNjZIaPMErRzE=;
  b=HBmAA7zU/T6XSjb1bthiHTa/z/45ewEnmFQDnYyxkjr58Bxma4epLnV0
   gDAzPDRnOjwzmGHGMG/3exgeYtm9ZwMtqJqx26cFuOlP1YQaKrcpJUYhY
   BzvqVDI+pqIzzsvnzoD8hzNVSpBj3Tleerr1OBUYcnKq2gljAw/AsohPa
   7hZCyx27qG7MwQU9hrjNoWaXJGCiAgDz7h+tSy1WhKGFiuoRupUAYF7bM
   g/Ww04LJkwd6FriPGWN5Yac098UA40VXwPOeNT8yI/NJO90Xf6ZKAJmzu
   0qrAZlhrRhxIdSQMRKDhPy6gMB+B+xZusC5GwVYWCJXm2B8aNdf/6Pyap
   Q==;
X-CSE-ConnectionGUID: gRNy5K3PQjKW51tjtB8emg==
X-CSE-MsgGUID: U8Q9sZ5rSPG90KlxDOMRvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85720072"
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="85720072"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 12:47:08 -0700
X-CSE-ConnectionGUID: BcRMqVs5R4Sqlp+IUoXyWw==
X-CSE-MsgGUID: lqjF19z3T/mlQ/aDQ7ygeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="257125639"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 12:47:08 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 28 Jul 2026 12:47:08 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 28 Jul 2026 12:47:08 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.43) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 28 Jul 2026 12:47:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IcMkJ1/23QAquOsQ2LKCTjRAUZW1IhphxzA0QUtab1Z/B0+TqoBmuDMTHrI4PFG3BS5EWm2yloSRMzAQxQaUp7hI/JW85/DdFJ5V+3bSOkpLGCJAvfKIBZhA6MoLrZZk3iQF5XBBzktH+3AKYAyBFjTyppzGKZlvS4SMfYONSwlyvj1XwgJxW19AmCj2IiWhIRqhGEG363mLaghHh0oGb+IEccEeXjPDDauJF2siwrBCbkzUkuN5P40t5R+bBkg/CVff0pPK5Ou7Hf3MG0eoPDWZBZ5zbA0kZBcV0fN37vS+RSVnwdKJjcF9HEuUBB3FH0Ekh19RbjwwjKYByPPmxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCM8Fd/Z9nDhHpecwuimcvn+n2ocvJMNjZIaPMErRzE=;
 b=Ne3SeyNirLm5Qjqt1zkjXy2/q4XjM90N7YtQQ8l4BAdpQfzw2Tt11fLoXjakFYYnyEdobup6VEzUXvNEfqmEHUm26hRV4HxxWipY5hWGlfgPORWlFi4s2/NPaJWERA567WTEx0NNy6FgNIP3zgi30zwvY0wRCqINmS+5smsfxgDIDqV9hGnGdEko4al4sdzxEdFM87nAPSSn/lgH/omAm/Y0trY4d74gOlqTGFK1UzXLjhBJeCAc0dfKmXownhoNmBh4eKAH55EmAqbydtUSmjFx/tENSpOKBB4f6I8NRK0meu99AfcgWnps7WsFXauw0w22dVtCk6NjLSJDcaqoHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7494.namprd11.prod.outlook.com (2603:10b6:510:283::18)
 by SJ2PR11MB8471.namprd11.prod.outlook.com (2603:10b6:a03:578::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Tue, 28 Jul
 2026 19:47:04 +0000
Received: from PH0PR11MB7494.namprd11.prod.outlook.com
 ([fe80::e642:c73c:6d80:5083]) by PH0PR11MB7494.namprd11.prod.outlook.com
 ([fe80::e642:c73c:6d80:5083%5]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 19:47:04 +0000
From: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To: "helgaas@kernel.org" <helgaas@kernel.org>
CC: "thierry.reding@kernel.org" <thierry.reding@kernel.org>, "lukas@wunner.de"
	<lukas@wunner.de>, "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
	"sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
	"Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
	"treding@nvidia.com" <treding@nvidia.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: Disable NoSnoop and Relaxed ordering for Intel
 wireless BE200
Thread-Topic: [PATCH] PCI: Disable NoSnoop and Relaxed ordering for Intel
 wireless BE200
Thread-Index: AQHdAUruh/HWEZwEC0iMA6tK8iUSn7ZImB0AgAAE6oCAMTTxAIAABOIAgAAe6wCAARjQAIAAHZOAgAhH+4CAAAUPAIAAEYwAgAAGZYA=
Date: Tue, 28 Jul 2026 19:47:04 +0000
Message-ID: <2ddabba85b064bb731fc99476184804f225d6858.camel@intel.com>
References: <20260728192410.GA1387466@bhelgaas>
In-Reply-To: <20260728192410.GA1387466@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.60.2 (3.60.2-1.fc44) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7494:EE_|SJ2PR11MB8471:EE_
x-ms-office365-filtering-correlation-id: cb40b501-0f01-4ad6-0549-08deece0ffee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|11063799006|56012099006|10067099003|6133799003|3023799007|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 6oHapRpi9KoixfZD9rlr5ftbl85S83BEcA4qdY/8b+mVlvtbDQiSLW+x753AWk/CN70B2gr7pt/iqFA9gbXYfLA4ciufvnvAc6LybLY0mdapQvBULnITKatCkA8F+bT/CLsqnYefBWIYKoWoG4dwNLRXhDdG6cRy6bMvt+YxaY2Y2MfPFQnbIKqZS2c00mQfKP5l7RdZt9isWRJYZ7btsLm6ksdz9hEytgusnWIpsyniEj4xmF1HxDyOX5U49x9ywP0fh4k87H47J80tGAYDZjZx0kiHfClm6Xtxnhvmn9hWK4kWXwHDWvk4MjaAm213AX3GcFsrMGDHUTsuBCZZ1muXTckS8PBGwzOICO8i25hW9dFKdecHYCMyW7xSK76G14AYEc68G5CwHuX55AleWHDH+5z4xmHehfYv9Iy8gdjcnvWCCqk4CHa2hKwVYXRpXzqSgvNwrHGhED3wKGA6GcQoR3ioDc65i0ugM4WRaIK7TvTErWgRpfVHpHE/TQq9QvWekXtRJP6YwjgMzYjFP5X7pZNpxdXdTy6rEq2VRlKD86jxBpqOkG2cfzbw9Ub+7OaqFKGfuNFBkw5InLzqdbQH6ahy1af8sxc9c47R7N9sP3LcHJ4IbxSuesrCLhbbCQn94GRgUrSQPNuxfKO3Z2xY43M55l/Lbr5+2OdIrVjNOV7jAJINolBN6JgCA+B1eltPZdRUxXYUBbMh9SFrTaZMcEoUX4jIh4sdJ/Nw5SY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7494.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(56012099006)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVpzK0pGcjJvdTBzeVg3Unc2NVk5Mmc2dXR4TDBhM0NUb2FzUHluQ1I2SGtB?=
 =?utf-8?B?WHhpQjBFdXZXYUdlNnc4dkdzUWVoRjFpMGhWSkgwTGFXRGlQZVh6eURYem5F?=
 =?utf-8?B?S3V4VysrUXhaY1AzQndiWEhKQXNVSWNLdjRaNzE3SUFlNEpUQnYrbVNsTTgr?=
 =?utf-8?B?RTR6dkxURWU3dkZGdmNvSll4K29jd2Z3QUFQWTFFeCtzcmVQdWZ1RGJEdi80?=
 =?utf-8?B?UkxXOGRvSnRkTmlYK1lPenk1T1gvWUdmd3E0QkVmOHBwQ2N6cm9pZ3lsRk5h?=
 =?utf-8?B?dS8zbFRMYzFNdmhBelpDTkgvTklCeko4YnlraU0xV2RydzQ2S3RaOHIvRDE0?=
 =?utf-8?B?SUM2MnVjdDVQNzJ2N1VBV1RFUGZ4Z3phUENrZnpqb1lsYUJ4QlJkUlVUcTJH?=
 =?utf-8?B?ejJ4WlFma3J5MTVaeHBnVENuYm1iK0FGQmxjSTVWODhwVlhHUmdHRTZGRHhW?=
 =?utf-8?B?VnJsWXlvNWZZbzFEa3NtdU1PMEk4VXN4bThPQVlPWVdEN3dubkZyZ3IxLzNT?=
 =?utf-8?B?ems5TVI5VDJXTlEwdWdCUkd2M1Z0NzBVU2ttdmpMS20xMmtKWVc0V2QrVjlQ?=
 =?utf-8?B?b3Brc0Z6OHZTZFNKNTRvNVE2ckVGMmptNVl4a1J4eVNoVEpYb2x6eEdhcmxh?=
 =?utf-8?B?dGllaHZMOVNPc0haUG4xUTU4MERpdDU0bVhtTURITWJlNGw5aTh3dWxpMGVx?=
 =?utf-8?B?emI0ZElUelBXV0U4L00xOVFpbWxtMmQ4ck9HdGg1YkJLSVFMMUtsVGZrWkFN?=
 =?utf-8?B?dnd3MlVsaFRZMVZpVzFXcWdQdGppbElPeVBlNFd0ZTRnaXh0ME50K2l5OVYz?=
 =?utf-8?B?c1Y4eHFvdVBZT1huK3dubEZYSEtrRmlpcmNkbG9wU1ZGckNZZWs4Uks5M1Mv?=
 =?utf-8?B?S1Q3ZDZTVEdQZ1BxNzBGaGVFbGUxWmhHMFc4b3Z0VzlqTmpLdk9ZNkREM0tP?=
 =?utf-8?B?RHpTOFg0WWtkdG45d2wxYVJkL3IrSW5PNHgrc1Ntd3RxU2RKV1BWWmxWOWlI?=
 =?utf-8?B?dWZjc05vT3BkMnBJSWgrZmxVWk5yaFBlczVxb002WHRvM2tqWGVONW9BbVJV?=
 =?utf-8?B?eWNEUUtrQnVxblRvSkFsYTVPUzdWR25leFp6RzNla3RhS0hlZUh6bnZMUStG?=
 =?utf-8?B?bW5QZzFxalBNT0NyYVBQbjRraVZUeERmcCtxQkZ2clBmdlh2c0NMWG9GV2l0?=
 =?utf-8?B?RmhvZHAxUWEyYXBRRTRTcThNcjR6TUJoWnpxbTB3bFlpUS91cGdHc2x1elFF?=
 =?utf-8?B?WHVCZ29QZUxzVmJZRmUzUmZXOEg3TkFnam1WbHhEVyt0bXJURnlaYWNyYUE1?=
 =?utf-8?B?YXN0UmtxYkFXYzNrT1N1bHZuVmdsMVA4RkFDMFBTNU53TzBYMDlyR2ZzZWxv?=
 =?utf-8?B?Nk1WdWFCaEF3UEk2T0F6emM1Y1BZcFNnM0UrWVRaZWU1STdkWWo5KzU3dGVi?=
 =?utf-8?B?QVVsS3hOaHp2ZTRybjdPN0xMbmdWRTduUjg2Z1d2Si8wTmYwSzZ6M083anFB?=
 =?utf-8?B?TElRam5ZMUloTWlzd1J0WEJjL1M0d1JUU3BSZWx3TTJoaUxuR1lSVGdpRzdZ?=
 =?utf-8?B?eTlsVzNYcTQwdWFadHhycGFsTnR1ZnEvUHZUSmFkaFExUzVOTmgwclFnMXk3?=
 =?utf-8?B?RGpBZURWYUxqM3VTcUtLNEFMZ1lINVJCdzJ2OWZJN2FDckd4N0l0T09NVnZp?=
 =?utf-8?B?UklsbVdydzBhNVJRUjhFSGJ0NEpWSWNXc3paR0ZtS1pFOEZWY0tEL1N3enpU?=
 =?utf-8?B?bzBGZFVaSkhzN3lHZXA4blFTQ2ZvTW84NXJNcVVxVFcyZXJKQWF4YW5wSGZG?=
 =?utf-8?B?T0Z2dHF6cVdHV2JpQkxlNmhFdHdqdkl5SVpsOFFwTGpEN2xxK3lBajVwOUww?=
 =?utf-8?B?Wk5NMFJ1bTFIUlNjYk9vdDA2QjhLdjdkbjJlTFlQbjJYdDVVVmtlcTBJeGN1?=
 =?utf-8?B?MUxWUjIrZmwzeWVYckFCS2ljaVFMSnV1c3lhTGpKeGRYUEVXOWpMWmdWVHk5?=
 =?utf-8?B?bmdqVTl0N3FYV2s5NUNXZHBoc1BXSVU1U3QrSXN5cUVySkZnanZEM1ZKR2Rw?=
 =?utf-8?B?Mm8zVjJhZ3VNcDU5aTl3NmY0OGJiWXdEaXU2NnhFTzAvYkFmZnU3bkFiUE9D?=
 =?utf-8?B?VWdYaFhMeUpkODVyY3FXU0JxSXBNTWQ1R3hlUWEzMjhBRXJYWkVRSFJ6VDdk?=
 =?utf-8?B?ZHpiZ3gxR1Z1WTkvQnh5Tm1VQ3BKWForTnMyak9ycU5jN2FPcE5Ma2JHeVFX?=
 =?utf-8?B?SHRPTStRU1Rhd3hYb0plUk1DbGo2YThqWVhpN1g0bm9jK0dURWRPWFByMjh2?=
 =?utf-8?B?clVQMEtLWFVhNWFwOU5vekVWaHc2Zm1ZWmJLNXRLSVFXUDBLbnhQQmlGOHlJ?=
 =?utf-8?Q?cn+o27+JxeDcnsrs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1683D86103D734FA53DFBBA3F922980@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: A94JaZJrvXHKYRwyfWcpfNDKI7R9dT0ueTFsYnLp74GiYm73SiJozmsQF2JLrtG7y2HMTedCrUFH/8k9J2TnREgDliose/y2ZdMKJQoqLsax6MYB753sBsAJ/HEORtyaITQzU7j4ft61vBxJPZo9Fe5g3F7V8OPbCjimNPZEEGJ4H6OMnz7h5FPQT6iBIdFPn8+SvkeDp+DZcU2jR7CoWBNGWKe2Qznk7tHIrinjhu2tp4AyfJrJ12jajaTLY2oSa2wz2kxcRxYLz6orRIs4mz6uwKWdTzHtIKgSW/4vENbOcujevjFX53ykFmUAba4UDoP2+q++hurA4zbbdffCJw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7494.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb40b501-0f01-4ad6-0549-08deece0ffee
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2026 19:47:04.3211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uQbAn76XxthHmB1zNu/IYBjBDBmTRrXOs1nbHNoraGsah1Gko6vBrzhys/R80qWHSot61lVrbU+NM3f7K0LqBSNH7oOoKBD/wyE94Lpp4Is=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8471
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA3LTI4IGF0IDE0OjI0IC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBPbiBUdWUsIEp1bCAyOCwgMjAyNiBhdCAwNjoyMToyM1BNICswMDAwLCBHcnVtYmFjaCwgRW1t
YW51ZWwgd3JvdGU6DQo+ID4gT24gVHVlLCAyMDI2LTA3LTI4IGF0IDEzOjAzIC0wNTAwLCBCam9y
biBIZWxnYWFzIHdyb3RlOg0KPiA+IC4uLg0KPiANCj4gPiA+IEFGQUlDUyB3ZSBzdGlsbCBkb24n
dCBrbm93IHdoeSBUZWdyYTI2NCB3b3VsZCBzZXQgTm9Tbm9vcCBhbmQvb3INCj4gPiA+IFJseGRP
cmQgaW4gdGhlIE1NSU8gcmVhZC4NCj4gPiANCj4gPiBNZSBuZWl0aGVyIGJ1dC4uLiBJIGNhbid0
IGNvbW1lbnQgb24gdGhhdC4gQW5kIGRlLWZhY3RvLCBvbmNlIGl0DQo+ID4gZG9lcw0KPiA+IHRo
YXQsIHRoZSBCRTIwMCByZXBsaWVzIHdpdGggdGhlIE5vU25vb3AgYW5kIFJseE9yZCBjbGVhciBp
biB0aGUNCj4gPiBUTFANCj4gPiB3aGljaCBpcyB0aGVuIGNvbnNpZGVyZWQgYXMgYSBtYWxmb3Jt
ZWQgVExQLg0KPiA+IA0KPiA+ID4gVW5sZXNzIGl3bHdpZmkgYXNrZWQgZm9yIE5vU25vb3AgYW5k
L29yIFJseGRPcmQgdG8gYmUgc2V0LCBJDQo+ID4gPiB0aGluaw0KPiA+ID4gaXQncyBhIHBvdGVu
dGlhbCBwcm9ibGVtIGZvciBkcml2ZXJzIGlmIFRlZ3JhMjY0IHNldHMgdGhlbS4NCj4gPiANCj4g
PiBJIC4uLiBkb24ndCB0aGluayB3ZSB3b3VsZCBkbyB0aGF0LiBUaGUgZHJpdmVyIHdvdWxkIGNl
cnRhaW5seSBub3QNCj4gPiBkbw0KPiA+IHRoYXQuLi4gUmVnYXJkaW5nIHRoZSBoYXJkd2FyZSBp
dHNlbGYsIEkgY2FuJ3QgY29tbWVudCwgYnV0IEkgY2FuDQo+ID4gY2hlY2sNCj4gPiBpbnRlcm5h
bGx5Lg0KPiANCj4gRm9yZ290IHRvIGFzaywgY2FuIHlvdSBjb2xsZWN0IHRoZSBvdXRwdXQgb2Yg
InN1ZG8gbHNwY2kgLXZ2IiwgYXQNCj4gbGVhc3QgZm9yIHRoZSBSUCBhbmQgdGhlIEJFMjAwPw0K
PiANCj4gQW5kIG1heWJlIHRoZSBkbWVzZyBsb2cgd2hlbiBib290ZWQgd2l0aCAibG9nX2J1Zl9s
ZW49MTZNDQo+IHBjaT1lYXJseWR1bXAiIGFzIHdlbGwsIHNvIHdlIGNhbiBzZWUgaWYgYXR0cmli
dXRlcyB3ZXJlIGVuYWJsZWQgYnkgYQ0KPiBib290bG9hZGVyPw0KDQpJIGFzc3VtZSB5b3Ugd2Fu
dCBhbGwgdGhpcyB3aXRob3V0IHRoZSBxdWlyaywgcmlnaHQ/DQoNCk5vdGU6IEkgZG9uJ3QgaGF2
ZSB0aGUgc3lzdGVtIGluIG91ciBsYWIgc28gdGhhdCBpdCBtaWdodCB0YWtlIHRpbWUNCnVudGls
IEkgZ2V0IHRoYXQsIGJ1dCBJJ20gb24gaXQuDQo=
