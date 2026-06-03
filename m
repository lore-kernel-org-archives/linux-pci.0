Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54213A0EB8;
	Wed,  3 Jun 2026 07:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780471710; cv=fail; b=h2sm2bvrAXoNR5rXqNSEWS6zlQ2fwubOoTWcp/Hwbs0oXEyk5yeWHj7mbqWZU9EmNWexonD3vw0/3PV8xE+rnSTaZazBVUtCVxjNALULuSGJOGU5QjMsDOz7rbJU0s+QMUVgUA3X+gbsNxVd+hCGfs6HR529q0zRJnQ8EMT7Lko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780471710; c=relaxed/simple;
	bh=CVrG90ILhA4W7lTa5tknnezfsKzxFy3x8p3G08FM7SA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SjSQqNrSyqZbPnM5y5m1JOx7OX4DyZfD1/wGVePVKboaXvUnciAauomXs5cz6LSPdkw9UgYLlrGEOTXZCvMDWiQJnO+7lULl5rtEZGEy1tCj6qR6KBSmHfQ2vrDxmWYGV56C0tRbWqkdptA2+kMoZS3OqOAgCovvi8DOP3Z5N8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lkNAfADI; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lkNAfADI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780471705; x=1812007705;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CVrG90ILhA4W7lTa5tknnezfsKzxFy3x8p3G08FM7SA=;
  b=lkNAfADIUUFdrVXWVpUano5lqtE7smtN8mvmcCu8OydI4rlLoGHuDB7D
   hM5UyzLFCAHcIVYjhS4n+4u4ooueew2G+EpgCpJS2RkleVzCAIG/j1GNc
   KpnsMzslytvJMFUoCm7d7ZnMTGM1xXhWj+4XGj7/s+MKpKtVwS1Tm2oNR
   EHp03FEi4i/MLZ426FnOnU7c36UWw4x3jPKq7/K/DDSvdqoZcUTAYV1yt
   9xbxV3XnBPzedztz9bKQ42JRebH9m3TZzVr2HqPoBFfcCEAP9g/0U+BVX
   hffK9XZBCRvkKWub+EJZP+kYUEm01oLsu5RI9T64/w6fTskRrX3lzdzdH
   A==;
X-CSE-ConnectionGUID: uE3lV+O0QU2AmTSU6Xi7fw==
X-CSE-MsgGUID: 33iVepJtSCWRaULIc7wkiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="92753676"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="92753676"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 00:28:24 -0700
X-CSE-ConnectionGUID: rA1sPdRRSsK907d3v2Gzow==
X-CSE-MsgGUID: GcUMq//BReOIMiX/zOsDKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="245960265"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 00:28:24 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 00:28:23 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 00:28:23 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.20)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 00:28:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OvUHko0YNZEKBwUriF7rRLxF1G8IwBpH214zMiz2ioIsyn3gKzpjLOCMfPDH9LOQYkNNNFf+vQt2Ag6S2OLTlu2MuCPCwH+kHKdB7wMRSpS5VlBkdL0G2oVFrWybCfg9xFhrkXp6+/e0gGfAM6poL313OXABrt22oILNHxI/Tcu3hUopGkqJFLXknH851n0QXIsBjziCPnXsNI9xDWKwNCtm2GwGtsrF6Rpi4VnpiO5hN1aPv5NK9e+j4mCMPjlydCodsNLohSgkKPCb8x6mrLNHmLcbdmxTnOEBzudqa+T9e1I2czwKKAe2U5fKntvUS0Oo57wKO9EZ5ZyVCU6rdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVrG90ILhA4W7lTa5tknnezfsKzxFy3x8p3G08FM7SA=;
 b=wKHD3cNMDNPbEtkRukEoaN0NFGGj31FMAlgPa4q1x3mYv5hcZDEAtjzDeCwtGULSPUm4PMt5LIpW37lNb5ptKcfhjIGH1pKSCkkllZ0Ipi9qex9xrOM8EQ9LybMnZ3T5CPZ1/IxhXm+ZPMyiFBtA600M4/iwYWDnYrkzOCMM+l+gFaLauMrdMaRgK8XmLeTAwR/rMk6sb55TePSqhef6/3jhh3tlpsy2Gi2uZfSIkQe61iQ0QPmcGMP1adBzXTJEm+VWvz/vXogomb0A23iRsUEfTto+vR7iQ29k93hWXSQd8T6vrQ5SPorulQGfVBPRETdrDWWZ43z0Ukdk+uEhuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3690.namprd11.prod.outlook.com (2603:10b6:5:13d::32)
 by PH3PPF6E8D29981.namprd11.prod.outlook.com (2603:10b6:518:1::d2d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 07:28:12 +0000
Received: from DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::7db8:f6b3:30f8:ee4b]) by DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::7db8:f6b3:30f8:ee4b%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 07:28:11 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Pranjal Shrivastava <praan@google.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Baolu Lu <baolu.lu@linux.intel.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, "Samiullah
 Khawaja" <skhawaja@google.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v7 2/5] PCI/ATS: Validate STU for VFs in pci_prepare_ats()
Thread-Topic: [PATCH v7 2/5] PCI/ATS: Validate STU for VFs in
 pci_prepare_ats()
Thread-Index: AQHc8dQdaSd1LRqPZk+c6Aitz2R9XLYscQGw
Date: Wed, 3 Jun 2026 07:28:11 +0000
Message-ID: <DM6PR11MB36906976C452B1A21F1BABB18C132@DM6PR11MB3690.namprd11.prod.outlook.com>
References: <20260601143644.2358771-1-praan@google.com>
 <20260601143644.2358771-3-praan@google.com>
In-Reply-To: <20260601143644.2358771-3-praan@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3690:EE_|PH3PPF6E8D29981:EE_
x-ms-office365-filtering-correlation-id: 437407b2-7472-4892-5ecb-08dec141aae7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|22082099003|3023799007|18002099003|4143699003|11063799006|56012099006|6133799003;
x-microsoft-antispam-message-info: lFSyD5q3njnA02zg9tPJvIV2toRTendxX1PQbJXrgo88h0D6aMVOWDBTQPrsRh2b7TNsa0/9V9W8+WNAAO0WfUwH5aQv4TuY31Sexu5b3YNpwphKtluMMZ/w+ElmW06BC/n630P8+XpRI9MZU8kddKjJa9svlTnOUKoijwhwiWzKT/zt+hy8GkGuadv71d03ADdn3dbHD+FtVrSOHv/2CtTV2EGF89QqGXMds8lm6uM8z+o4sta0zigwia+gWPCb+XWdLjrGU2uWuI0XpcX4SyGFeHGmnjs0estojym5g0AgMQnVjFTfq7yCb2wthGZHOhJz06vWYJGfo8IApPtr12plttjevyWPvMRDIlN2SAhFADcrIreYy0xlszTyJdXkIbEPcn7ccpPiM5/0RG35fUjrZGVsgWKRLEghyA/w14yLiuTPxBwuajxZ3svpzt8H9DnLmMdkTlmQB25ocQWo0ut5QJ00fXfTfMf13NZV3EdP/+gomTkYq3fxJTEzXZhQwoyez3eeeR4CbmUDbq1onKFaBp71Yrrc9Rjy+rq8vySuu1OzXyAeiHShhk4Hk50t+1Fb5OiQ9lgf5kFqIjNhfjthy8+BrgL2iVgsP8jipeMpPgup4YU4C7n63dKhpJr71XjC3CX9KEN55lHHj6zoWGDLPTyfUsNoGImcm0otwUvhO+yggLxEm2+vkDFkwcXcLzx2Gf5i+gs3l4MBNu7gpptFZmyg23uCkADzJIFcqKs+RRkrmHvzp42BCfdI7Enp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3690.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(22082099003)(3023799007)(18002099003)(4143699003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXFRVUJuUzM2c3QrRnFZV2FERWF1WmY3cURMVnF2dDY3MmtEZ3ZkWVYvRHl5?=
 =?utf-8?B?RlJ2V1Q1ZmZianFUZENHamN0Y21CK281enFHd0I1QjlRQ3ZmcC9CVHF6TEJl?=
 =?utf-8?B?bEtEUUdveW9CWkxaU3F3TXBkQnY2aGZLSy9EdHJTYXdyL1d4dXlMNTFuaXNK?=
 =?utf-8?B?T0ptSmFPTjhPcXg1MjNwcGt0SFlKQkpxQjdBQUlBQ3hNblFWZGJNZzhtbzdy?=
 =?utf-8?B?aFp4LzdJRG5wcW9xZTQ3blJITDBjcFh1SmlzTnRobDhlVzdXd0VIeVF2OFF4?=
 =?utf-8?B?UlREVDRJVkErZ2JiTmczV2JVWXBicFJLWk9TcHNZdnlsWmhGWmxFUWYzUUR4?=
 =?utf-8?B?VytFRG4xYUZKTk9xK1RSQ2tZOTI3d3I1dlpBaUdZMXlYa3RyQmt5LzJHOW9l?=
 =?utf-8?B?cW1QK2NFak9YaVdJOE1QQUxjelVldnVzQ0JIMHozS0pYdjlpV1hNYTlUblZi?=
 =?utf-8?B?c0JmMUhtcUh5eEdVaFF2dHN5bHlwRFFhc0IwUnZib1A5ZkdCOVAvL1lzbStO?=
 =?utf-8?B?MytLSkpzSXY3aXVMbDRXVm9hUU1LamhxeTBQdWRvb0pHSk9tSjVJN05DVmQy?=
 =?utf-8?B?d0xobm1mK1FHQTRQVjZlS0JZdW0vZmg5QXZxZjg1dDRHelBtMURuUTZCUyta?=
 =?utf-8?B?d0wwYXJhLy9QTlJjZ1pMY2UvVU5oRzFXSnptdS9BQ01aemJsK1BNRXR2KzhO?=
 =?utf-8?B?WWpOUFVkRG90eWlPVFF4ZGtlQVQ0R0Q3K1g0OWJFT1VWWWlJblEwc2ZxTkp6?=
 =?utf-8?B?NEJzcHdySmpFbms5UmR2ZVFpUmgvc09CWWxJSS9uS2hzREJ1UlozWGVvQU4y?=
 =?utf-8?B?TTFNc2NVRlJMeFpielg3cFBpUjhQMkJleG5aOVA1YkRTMEVaMC9WUEQ2OUxL?=
 =?utf-8?B?ZEFwaEtucjBMbExBVmhVRXZycHc3SmZMdDlhZ3Y3elVkNTdxUzZZeG12cnpR?=
 =?utf-8?B?TExKdE5zTTROdndvb3Mrakhjbm11VnNHVWhpdkpJMmRWUDNHN25ZcUQ1WU5s?=
 =?utf-8?B?VFNra3h6MFNKWGpOQTlML2VGWE81dHNiMDYzbE81M1Bid1Jhb21DY3JPdmxG?=
 =?utf-8?B?RllwSFNzdWhjUEpNN2Y3SS9INWtLVzBXQmsxK3Nac04rNUNHOU92NDJ4VWkw?=
 =?utf-8?B?a2orWU9qT3YxOE9vUHpCNHB0WkFFclV3UGMrZmNmM1hOQTQ1SWJReDVUMlND?=
 =?utf-8?B?V2cyUzZzVEh0dUVHQ0ZMZENWemxPVStGcEtBVU5qNVRjeVlhRkdFbEhVNWps?=
 =?utf-8?B?V1duZHVpbVlTckttY2xYdGp6bWMwZHhhV1BpL3NYdXlidjlhMUJ0VGwrcTNo?=
 =?utf-8?B?SERiSEo0QllRMVMwbU9tNHB3ci8zLzJQcVNMK0thZm9hZzZlbXZvL01OWTVo?=
 =?utf-8?B?eUZ5SnRXM2piWklVdis2RDd5VDZZcFd6TW1MNGZRWHRBZzFzV0RIUFJJRGhW?=
 =?utf-8?B?TWR2S2k5eDVJV3BLeFFHNlU4OHhuaGpyTXlzb0JHSHgzSmYwa0J1c2l0MDJh?=
 =?utf-8?B?QSt3NUwvblpQNXFFUDFzS0hnZUxCT2pQQklCZGxUYkpKWnBRN1RxZzkxRUpO?=
 =?utf-8?B?MkI5bWVvdFpXN3pFYUlhN243Rk83OHhEVDdxeW1NNmtVNUlsV295b2luUWdx?=
 =?utf-8?B?clVaTXNPcFpucjVwM3pjNTJYV0tWMEdtenFKNFV0KzRsMGJOcE45Z0JFS0or?=
 =?utf-8?B?bGFWb1BlYWpMZVMvb1BycTZNcGFFOWZ4T3pweXZQWmRZbmxpZmFLd243QVV4?=
 =?utf-8?B?bEpWZkhWUC95QlhuSlFPVCs4b1Z2WElCWFdNYi9FTHRHeDhITWZhRllacndY?=
 =?utf-8?B?WTBhQkFRdTZtaXRvTFJ6L0tqbEl1bjVUMVlyaG5uVnU5OXlIWUVISUtSZkxv?=
 =?utf-8?B?V3cxYzh6SEhWS3FYSzZwQ1l0VGd4TEo2RklLVk8rdGVaT0JvODFhZmt6Y1ox?=
 =?utf-8?B?MTlVOVVaZU45bU4yTlp2WGIxbmpTSmtBNHhpNC9HZlF2SEFTUTNZT3JzaFZH?=
 =?utf-8?B?bG53TUZScEdhd0ZEYUZyTUplQm51ODh2eXN2Tm1oMTNnRkdlYjN4SDh4NzU1?=
 =?utf-8?B?MWdHMWRERmVLa0t1N2ExKzhYdnROTUhBeFpMKzBZTEdVWFA0dzNMV0YxRG1F?=
 =?utf-8?B?eFdyUHZzWkcrbU95NURjYVlUS2dyVFVzbEltZ3Y4UFhZUDNEUWE0SW4rRCtP?=
 =?utf-8?B?b3NsVkVaT1dySEYxU3U0WUNYT000QzNtSFVITUVyT0wyRlZnQkVnejVBWXhj?=
 =?utf-8?B?c1dNZTl6bjVDNkw0RE1VQnNzV1k5WjJ2NmZaMjdMM2xZN041V0hHZnA0WVFy?=
 =?utf-8?B?R0J0dHYrSWVMNjVDZUFzbmNtS2wwMnhsUWI1MEhmRjdZSGxjQnR0Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rwdnRzG2D2BnfKFkGp2h3+1jfkJ3tYSkyxZQOeAw4p92vOPdzkm/YEHXmTE+P4gyNk7FdV1lP36imvoBfRvOwwOsBW75B2na1KeOMy+ujPUPy6RxIY74cFeNkZ2kUPxO4bcvoICBqYZYmQPwp89hSJD9l727TesaLdMR8JEXEYu7vuu9c3hlns8I1R9ehZmFIdH0D+SWN7Nf7d7cabU6A71LjwPk9J4G2eLypoviAUIZG90TxZJwkIyfUj2MQ+YUashR1dR0Z6U8Pce5YcX1WGSN0hBTV10D/Iod+WjLUFRGrGi1JuV9Gy4B3hUZCC/W1iVhZkh+sKo2cO4n3sOMUg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3690.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 437407b2-7472-4892-5ecb-08dec141aae7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 07:28:11.7169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qgko6sQnWICwOq8sYl4XyKXyQpSSiWH2i1/nXWb3MAlKoc2TEeQjBcjj/7rXa8fsZlluE+xYySpsvK+7behkug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF6E8D29981
X-OriginatorOrg: intel.com

PiBGcm9tOiBQcmFuamFsIFNocml2YXN0YXZhIDxwcmFhbkBnb29nbGUuY29tPg0KPiBTZW50OiBN
b25kYXksIEp1bmUgMSwgMjAyNiAxMDozNyBQTQ0KPiANCj4gV2hpbGUgZXZlcnkgUENJIEZ1bmN0
aW9uIHRoYXQgaW1wbGVtZW50cyBBVFMgaGFzIGFuIGluZGVwZW5kZW50IEFUUw0KPiBFeHRlbmRl
ZCBDYXBhYmlsaXR5IHN0cnVjdHVyZSB3aXRoIGEgUmVhZC9Xcml0ZSBTbWFsbGVzdCBUcmFuc2xh
dGlvbg0KPiBVbml0IChTVFUpIGZpZWxkLCB0aGUga2VybmVsIG1hbmFnZXMgU1ItSU9WIEFUUyBi
eSByZXF1aXJpbmcgdGhlIElPTU1VDQo+IGRyaXZlciB0byBjb25maWd1cmUgdGhlIFNUVSBvbiB0
aGUgUGh5c2ljYWwgRnVuY3Rpb24gKFBGKSBiZWZvcmUgYW55DQo+IGFueSBWaXJ0dWFsIEZ1bmN0
aW9ucyAoVkZzKSBhcmUgY3JlYXRlZC4NCg0KSXQncyB0aGUgUENJZSBzcGVjIGRlZmluaW5nIFNU
VSBtdXN0IGJlIGhhcmR3aXJlZCB0byB6ZXJvIGZvciBWRiwgaS5lLg0KdGhlIFBGJ3MgdmFsdWUg
YXBwbGllcyB0byBhbGwgcmVsYXRlZCBWRnMuDQoNCmFib3ZlIHJlYWRzIGxpa2UgYSBzb2Z0d2Fy
ZSBkZWNpc2lvbi4NCg0KPiANCj4gQ3VycmVudGx5LCBwY2lfcHJlcGFyZV9hdHMoKSBiYWlscyBv
dXQgZWFybHkgZm9yIFZGcywgYXNzdW1pbmcgdGhhdCB0aGUNCj4gUEYgaGFzIGFscmVhZHkgYmVl
biBjb3JyZWN0bHkgcHJlcGFyZWQuIEhvd2V2ZXIsIHRoaXMgY3JlYXRlcyBhIHBvdGVudGlhbA0K
PiBtaXNtYXRjaCBpZiBhIFZGIGlzIHN1YnNlcXVlbnRseSBwcmVwYXJlZCB3aXRoIGEgZGlmZmVy
ZW50IHBhZ2Ugc2hpZnQuDQo+IA0KPiBVcGRhdGUgcGNpX3ByZXBhcmVfYXRzKCkgdG8gdmFsaWRh
dGUgdGhhdCB0aGUgcmVxdWVzdGVkIHBhZ2Ugc2hpZnQgKHBzKQ0KPiBtYXRjaGVzIHRoZSBTVFUg
YWxyZWFkeSBjb25maWd1cmVkIGluIHRoZSBhc3NvY2lhdGVkIFBGLiBUaGlzIGVuc3VyZXMNCj4g
ZWFybHkgZGV0ZWN0aW9uIG9mIGluY29tcGF0aWJsZSBjb25maWd1cmF0aW9ucyBhbmQgbWFpbnRh
aW5zIHRoZSBrZXJuZWwncw0KPiBwb2xpY3kgb2YgY29uc2lzdGVudCBTVFUgc2l6aW5nIGFjcm9z
cyBhbGwgZnVuY3Rpb25zIGFzc29jaWF0ZWQgd2l0aCBhDQo+IGdpdmVuIFNNTVUuDQo+IA0KPiBS
ZXZpZXdlZC1ieTogSmFzb24gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT4NCj4gUmV2aWV3ZWQt
Ynk6IFNhbWl1bGxhaCBLaGF3YWphIDxza2hhd2FqYUBnb29nbGUuY29tPg0KPiBSZXZpZXdlZC1i
eTogTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPg0KPiBSZXZpZXdlZC1ieTogTHUg
QmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogUHJhbmph
bCBTaHJpdmFzdGF2YSA8cHJhYW5AZ29vZ2xlLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEtldmluIFRp
YW4gPGtldmluLnRpYW5AaW50ZWwuY29tPg0K
