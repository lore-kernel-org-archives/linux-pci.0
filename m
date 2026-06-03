Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3010F3F5BFA;
	Wed,  3 Jun 2026 07:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472060; cv=fail; b=V2d61wAziJqri+ZUzQUv/BWvLDWYlguhGhRF5pNhGhMyIdLMxp0EAKlVyjfK0fjpi/qDEAOdJa3L04kLHobdw5EKMxdOjMWTM5M8c9wuXMVGts0yysIzYp2GBA5t7snaEhV4mAWixbYmVeBgh5xE50KWQgzhgv0+6xVnZWcQRQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472060; c=relaxed/simple;
	bh=NBG8dg/tHo/nal3xbrovq9Q9dAsjxPl2H//hVpR8g04=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TCxmaIFI19zj2hhrymCyVY9jU+oatKJO0P3g57sQZ4ZEh7PKiJ0BefFvS/m1DROITSHrJ1WFAMteWnUR2ll1yV8y61SI7Dcd+NtXcEj10ZgVJkXFUMN5ONvjPtA0awsiVjtuXRpkcXMbfYvcS0qFMnSTzNmsJ+iBRkEjzETXCLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H4V3/laa; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H4V3/laa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780472058; x=1812008058;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NBG8dg/tHo/nal3xbrovq9Q9dAsjxPl2H//hVpR8g04=;
  b=H4V3/laakrmj8d2A59VMthB/6e8dTPt+fat7Y6w3KTIuM2lBYiO2Xpg1
   bQ2jCHVzZ1p3+GGJFNhMMPiEckzXY5AbzYms9PQTxO02iI/Q88i2Uskg1
   fmSGBvhR/3hPKoeRXuGrQ8OgV8LJo5Pej5uKUvfcRN1AbHJtD/ous8bYe
   nneaGNp3wxSOAF79MyZJ6ppTqiityXEJjYQWR1uOlu4t78LibSfdKt/7/
   FVTHYrXaKG6bgGnG2HvvJRdEBoYn+Ai6+C5di1aiAqLzykvG8ecTTG86/
   hZH/W6beyTJho2tpkj2J2fsiSyjJlL4SbNH+P5OQm8MDYre/nCmLCpuZi
   Q==;
X-CSE-ConnectionGUID: WL0SQ/VURiSez01x/hs67Q==
X-CSE-MsgGUID: x4BoGowtSG2Ylq6MfhCudg==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81248513"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="81248513"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 00:34:17 -0700
X-CSE-ConnectionGUID: TR//u2IXTdW++sOzQzjRWg==
X-CSE-MsgGUID: XsMqHALQTBWbNafRAZvPXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="268031297"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 00:34:17 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 00:34:16 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 00:34:16 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.33)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 00:34:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NFIqqj5x0HO87CMhetxf/u1g3OjH9QPnqqM3Bx9pLgmw5B+Xq9cxi+2dANoBXpDrOzujbH5Ktr906HtPyDqXPgQ1i020nCBfftwWNZiIhEO2R9wm8ZsWeFBDgdOptFEUOg82KpBVhPuu3pRLP+hOPo6E3YKmzgAKAkOSg3JBFnBLcWVQ5XuZM1U6sVV0urT/v6pbmv2hP+avVyDWfSPfpcQ0a56PKlM/BBfgSnoZwUvLZ3qcSdHta6Ak/lK7bgIVUtIRG6hsERO0vwmet2/DLCPWW46afQLpxkRzCiPwclTC7ENcHP2sFdFXv7P5uGQ0sgm1ZYku5eu7alRu7qTaHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBG8dg/tHo/nal3xbrovq9Q9dAsjxPl2H//hVpR8g04=;
 b=NLOnW1vuQkPW6UFkGFdWem6uBD8iFIvz9S0pMX5+zE4IfcSxuFoaE2qGv/r3e52uTvGmQslrpqBjBrzMmvyFoqUZue/1bQJAqPu4XdiU9QNj4YA1Ui4sOoPjy832ZscAGO13H23Fzgx8WuHby+ElIcAp7Ju4OhZqQ7vYbDpD/wNIgS2l/Vy0JIHECnKXvtafuZKEnHb6wzMZn39MvoiOcMRallZoh1KtcHFKlo+Klx6WpVp9J7j5mpn8zsjYAz6Okyqq5Ll0WIw2JP0mGm+MJbio1cx+TiYaI2aUrE03m8JyacDYjakeeP0vWQsqPFcXy9+J+kageKP5UJUA4yE1bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3690.namprd11.prod.outlook.com (2603:10b6:5:13d::32)
 by PH3PPF6E8D29981.namprd11.prod.outlook.com (2603:10b6:518:1::d2d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 07:34:14 +0000
Received: from DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::7db8:f6b3:30f8:ee4b]) by DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::7db8:f6b3:30f8:ee4b%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 07:34:14 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Pranjal Shrivastava <praan@google.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Baolu Lu <baolu.lu@linux.intel.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, "Samiullah
 Khawaja" <skhawaja@google.com>
Subject: RE: [PATCH v7 4/5] iommu/arm-smmu-v3: Standardize ATS enablement
 failure reporting
Thread-Topic: [PATCH v7 4/5] iommu/arm-smmu-v3: Standardize ATS enablement
 failure reporting
Thread-Index: AQHc8dQlM9qB1q/QaEGi+kJgUM64DLYscmSA
Date: Wed, 3 Jun 2026 07:34:14 +0000
Message-ID: <DM6PR11MB3690D6851AE3354AC55CA2368C132@DM6PR11MB3690.namprd11.prod.outlook.com>
References: <20260601143644.2358771-1-praan@google.com>
 <20260601143644.2358771-5-praan@google.com>
In-Reply-To: <20260601143644.2358771-5-praan@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3690:EE_|PH3PPF6E8D29981:EE_
x-ms-office365-filtering-correlation-id: 1ae7f946-4e5e-4cd3-7937-08dec14282e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|22082099003|18002099003|4143699003|11063799006|56012099006|6133799003;
x-microsoft-antispam-message-info: mEeM2OE9xOeulL36G7ySwrN0CkKZHcMJAdcrIsu4SpVMWXr3ujNM20nEbKqzM00ekUyHTtBzGdrcagCfDi7jrAymb55EAvdpcoMRR/XavNVaRB/IqlOOYH6ZDbHuHwYqBnrdUOKCxnscHmNRb570UOne+At196aqxcjSxq9q8+lgl9Mb9NjpGfLIey0S2/g/lwWOGsWNqoIMXC81m7mKS8AbrNaSdwsAhNWNa4AtNWqAKQBxEto+YZ6F9qV0oAZ5DRfs1SFDWvHHgnonGAW9RTx5fut4Fi5O1jiL4zmO5FevgR3QgrK38E+z7+UtasKPdF8Z1efHNdL33TKEqrzE+xtJeveWbloFs8/4jE3eS5SNDVw6JcrXQBKsT6OybMiz+qpkEbKqrAKzqpl9qc8nBonWmjOcd+G/ThEfMs6v9r4HHErHDSoPPgO/3IRC5WgnG+ogPo3+lPHlxLvvZATz/bJo0NXyd5dLnZ9+SHcme0duGYBi6Cc1qmHwjTeCm0xlq8F527tg7sSYXSAXiUXZTdJFrF8fNqVfvY9vSg0Rr/0Z+Ha7ObzOgjv0p+r1bSeIEbzzzPxN4bY/Pi04FDcREo4tlxrqjy5L4EtBRx3o9cCYwFvmxJaWtSvkfVIbsyqjASwzjxzYuwSO6nG66u7S2zfNDsoJ9FlUP5oHX7iKtrfxrfhfJImWExeKyKpAX7nwvdt5Ry1X+JqLnXs/FTgJPEl4WTR1o9Ja+T0IXmoqGMOsjo7JmMv6kCjh/l4YEKAC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3690.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZURSVkN3YzZIOFpaQ1kvVlpyKzhiN0c2a25pT1JzMTVNRkY3T0NOWUFMcW1E?=
 =?utf-8?B?SGN3MExiWkJ4SW9RZmlEWktyT3Bkcy9VaGd4K2dHYmVLUHF4OTlQTjY5enlV?=
 =?utf-8?B?Zkg5N0xOYkVwQXcwa0VJaEVDQUFsa0lEd0FSYWQzZG82emdQRzhUaUJGMVVJ?=
 =?utf-8?B?RGdETkduSGZkZlhxc2tsaFJaRWJlTStadGpTVWxwMVhheFVkOExUdHhham8v?=
 =?utf-8?B?S0JiSzlRNjBtcmY2ZHhRekxtZDdnZVM2eGlRTTFNS0dHZ1VSandWN2pUN1FC?=
 =?utf-8?B?NEVkaE1KRU9hTW1rUHMvUGI3dWpUbmluMnRGVUxheVRZNDZNbFMxWUZadTV6?=
 =?utf-8?B?aFpPbUo3czFCMEk2OGJ6VWZ6ZnByZGFzUk9Pd3NaUnlTT29uZEw1MytUWDg1?=
 =?utf-8?B?ZUduTEZKRXdud1Zid2JOQ0FvTlk5ZTR5Tkxsd3g0N0FwVVRCRHJzNEw4WUsv?=
 =?utf-8?B?RjJQWEhUaWt2ZWo4OHJKZ2t0WEpmYjRqL3dYeDIxYmpUL1NXR2c0VGVnQU5K?=
 =?utf-8?B?R3JZTE9FandicXhEckdLeUF5eDVzdmNiNEExQkpFaWx2RS9GZys1NitJYTNP?=
 =?utf-8?B?Z05VNmtNWldlam85UkxDNXp0ckRCRU5xaVJuVTN3emtHSmJhblBCS0NTZFkw?=
 =?utf-8?B?c1ZBL1dtclFWd2hGeTBGeE1pcWp3enhwK1BTOFdEUC9VUm1PK0EvOFo3VURJ?=
 =?utf-8?B?ME0wN1hHOGg3Y3h3Q08yUHlXWTFmQ1FwUEl1RnBSc3B5RHpVRDlCRWRtVnV6?=
 =?utf-8?B?YnU2SURHRGhzLzEvaCt0b04zdldMYitwYUZDM2JoVDVvUHlwNmpYNnluYzVu?=
 =?utf-8?B?TzRBeWJvSHYwWHdCUzFERVVmWlB3K1M2cG9xRFEzMUVlVGllRkJkVytRWUls?=
 =?utf-8?B?WDNKcUV6bmF6cnUvUU0vcWJBR25WUEFBZ2syb2FuY2h5R1NXT3UwYVRvZS9r?=
 =?utf-8?B?Z1hMYXdEM2xkOVBQek1oTDhFU3Yxdis0MUp2U3JwNzZselM1eDE5WXVWZHlk?=
 =?utf-8?B?OXJ3R29nZ21EcmNZZkV2ampJaWRBRGpKVHhpRmEvMDlHa0hhQmxuY3hpU0hm?=
 =?utf-8?B?NWN6TnZhWWhVUzVjeXFKanJJWm0xK1BoNkFLN0JLTlRFdXZBbDViLzIwOWJ3?=
 =?utf-8?B?K01JZmo3SCtHZElTYmZCamhOUDB4UlJiNThFMHBNYmxOVVJXUzZoblA4QmJs?=
 =?utf-8?B?eGhRSGd1eC9ZNVE3ckYxazZacVh3dnVCb3Z5WmtUalNtdDI0b1JHcGN5TUxY?=
 =?utf-8?B?WUV0a1Z4ZFlZc2ZPSG50akFCUVVMdXpKb3gvdXgzM2JYVW1EVnZNOVBhaERr?=
 =?utf-8?B?WnlKL01hczFRanUyMGN5TmhKMFFYOGNLL1VWY0s2VHphQ09qRVRDbG9mOGxs?=
 =?utf-8?B?Q1k1dm5KTDR3K0lkczduOFY0ejBrTjV3NGpSR2xGWGV4WDFyTHQ5b2FlT2lN?=
 =?utf-8?B?TUZmNlZBUi9jQVJYWkhrdXV2Njc3KzJFK2hFby9BNHowS1ozMTZRK2J1ZXVw?=
 =?utf-8?B?N0FJVHNpM0VEOEZHMkxreE0yUmVLRitrN0ViT1MyT0V4dUdQSVRXUFVSbllU?=
 =?utf-8?B?VG9HT3pwV21PQUNLN3JoSkV0Mk9zazlVYnNIb2V5YjhlNVpKNlZ2U2hQNyt6?=
 =?utf-8?B?N2gvb1YzOFY2M04wVlArd01iZTBkV2pjQnJjc1RoNzQ5YktWVTRJNFU2Vk54?=
 =?utf-8?B?VzBKM3hxOWVWZlBrUmFoRG0vNnMvWlptazg2a3d4OVFBU09mNjFYTGk4b2Q3?=
 =?utf-8?B?dzg2L0JZSE5PWEFCUHlqQ1lNTmowNUZEMUhBQjVpY1pVQ3huL0tNWThVVExr?=
 =?utf-8?B?S3hNT3E3Y1dKdzNUYm1vZkhFNkE4SU5paTFBZHQ0Z2F5alpnckswbUx5ekpy?=
 =?utf-8?B?VkJMNm4xdUcyYStLWFl6ZHZNY1FoYTJvMm5lTHcwbnFNbmtKVjlhNGI0Vkk1?=
 =?utf-8?B?VnZuU2NZNnRCQXoyOXFiVk5OTzFHU2pDZEl2c1NNdUx0U3lkQnRMQlFkUXg3?=
 =?utf-8?B?dktWbHVUOUhLR3ZpYUFRNjJmM0VJTmhxaEMvb2xjVDVGYXRFOTBEOFU0WndT?=
 =?utf-8?B?VUM2am9iNkRmRmNsRGF0WWU1Q2ljYmJVaVcyWk5kMmoraUFvd2RKUnM2c0l2?=
 =?utf-8?B?MWUyNzNrK0U4bFZMeDgwR1NtSDZxT0hHazZiRE5pYU9USGJQZ3RvOW1mTzNk?=
 =?utf-8?B?cXRYZGQ4L0hZcGhVbFltVDV0eTRZZnhUdno5Vnl0RXUvb1hnQlM4S0lmWmd5?=
 =?utf-8?B?Qlp0UnJoV01tUkV3ZS9MbW9OZmk0dVBkaEk5OHdOVWxDaTI2K092UXRtWGhV?=
 =?utf-8?B?UUVUUnBOT0RCTWMwQzFPK0czNFZmUjl5MVg3RjZhOXo4S2N4MGJrZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pKas2QjFd1TpmBnt9VX5U+xZrHnxuZV4AlSXyqeC6lraJi+SNrson1j9tsVeg/F/utDFWWw6/CqaD2EEVE68xxATTVxoNt4zMcJhhN/eMEplv79kz7Q7nNOH/iwG3uFkHk0eCrpw7wBYq58ERb5Ydr3a1LvtrVqJpFTircPuVoNJdyPbaRtYEnCy2i/4g1+8d4X7CdHiBg+N2s8+kKX+csvbNtjYlooHaRo9ZMyAfVdos4bnOUFcfH6tBIIUth6PRG/agLumJ4tSLu9KL/+n+YyY52KbGdGOq1WUFl34vuIXDR8iLVL7ggGmJFMoThzN6JHVX13IC7E3Tjav67Jfsg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3690.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae7f946-4e5e-4cd3-7937-08dec14282e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 07:34:14.0971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lfgQZeTUI4iMJzsmpEy1ilf1KzngmRGfJheYksggKmfGUaAJlEyzedL9IiLWlbjyOkqLP0oPLNK2bB0aOBDqyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF6E8D29981
X-OriginatorOrg: intel.com

PiBGcm9tOiBQcmFuamFsIFNocml2YXN0YXZhIDxwcmFhbkBnb29nbGUuY29tPg0KPiBTZW50OiBN
b25kYXksIEp1bmUgMSwgMjAyNiAxMDozNyBQTQ0KPiANCj4gVXBkYXRlIGFybV9zbW11X2VuYWJs
ZV9hdHMoKSB0byB3cmFwIHRoZSBwY2lfZW5hYmxlX2F0cygpIGNhbGwgaW4NCj4gV0FSTl9PTigp
LiBTaW5jZSBwcm9iZS10aW1lIGNoZWNrcyBub3cgcHJlY2x1ZGUgY29uZmlndXJhdGlvbiBlcnJv
cnMNCj4gYW55IGZhaWx1cmUgZHVyaW5nIGhhcmR3YXJlIGVuYWJsZW1lbnQgaXMgY29uc2lkZXJl
ZCBhIGtlcm5lbCBidWcuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQcmFuamFsIFNocml2YXN0YXZh
IDxwcmFhbkBnb29nbGUuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11
LXYzL2FybS1zbW11LXYzLmMgfCA3ICsrKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11
L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5jDQo+IGIvZHJpdmVycy9pb21tdS9hcm0vYXJt
LXNtbXUtdjMvYXJtLXNtbXUtdjMuYw0KPiBpbmRleCA1NGM3ZjFhZTNhODQuLmRmYjJiMGQyZDJh
NSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUt
djMuYw0KPiArKysgYi9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5j
DQo+IEBAIC0yOTU2LDcgKzI5NTYsMTIgQEAgc3RhdGljIHZvaWQgYXJtX3NtbXVfZW5hYmxlX2F0
cyhzdHJ1Y3QNCj4gYXJtX3NtbXVfbWFzdGVyICptYXN0ZXIpDQo+ICAJICogQVRDIGludmFsaWRh
dGlvbiBvZiBQQVNJRCAwIGNhdXNlcyB0aGUgZW50aXJlIEFUQyB0byBiZSBmbHVzaGVkLg0KPiAg
CSAqLw0KPiAgCWFybV9zbW11X2F0Y19pbnZfbWFzdGVyKG1hc3RlciwgSU9NTVVfTk9fUEFTSUQp
Ow0KPiAtCWlmIChwY2lfZW5hYmxlX2F0cyhwZGV2LCBzdHUpKQ0KPiArDQo+ICsJIC8qDQo+ICsJ
ICAqIFNpbmNlIHBjaV9wcmVwYXJlX2F0cygpIGhhcyBhbHJlYWR5IHZlcmlmaWVkIHRoZSBIVyBj
YXBhYmlsaXR5DQo+ICsJICAqIGFuZCBwcm9ncmFtbWVkIHRoZSBTVEUsIHBjaV9lbmFibGVfYXRz
KCkgc2hvdWxkIG5vdCBmYWlsIGhlcmUuDQo+ICsJICAqLw0KPiArCWlmIChXQVJOX09OKHBjaV9l
bmFibGVfYXRzKHBkZXYsIHN0dSkpKQ0KPiAgCQlkZXZfZXJyKG1hc3Rlci0+ZGV2LCAiRmFpbGVk
IHRvIGVuYWJsZSBBVFMgKFNUVSAlenUpXG4iLA0KPiBzdHUpOw0KPiAgfQ0KPiANCg0KbG9va3Mg
c21tdSBkcml2ZXIgZG9lc24ndCBjaGVjayByZXR1cm4gdmFsdWUgb2YgcGNpX3ByZXBhcmVfYXRz
KCkgdG9vLg0K
