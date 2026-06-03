Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625F83FBB7D;
	Wed,  3 Jun 2026 07:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780471518; cv=fail; b=lu7qLXfzMkkZfUsDZ3NDLUKz7LmrA8DSk1s7g3VI3v7LbUkYt4RaOX3JVoZY7sP9SNzeE6rUvBkET6BReuTbwbIjU/jrBpm5OhzcHqKZAVvcstZpVqTlKiyliIfbzyC2YDyNeL9HmVcE4m2hCKJXYepS4qCsQ/XMFhqb+WV9ZIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780471518; c=relaxed/simple;
	bh=BX0UBKHVunDd9vehgTWcDlaDkDPSW1mTZCiQpL56p1I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NkxyFwRBOXtG+zAu+tzeJD/2XGV8DocUfwY2fUbhM1xBgFOF+gNh0dw++Dc3epqvXapUOf0sGEPJdmPXZ1k73NUt5LotvyHD0VHIqiCZZpYGAEXHniJHYIdb72Y3bg9GA7xocKTD2E3j8kKbkVJyuI9mysIIkq2VGRZQVS7mey0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DILpYzXX; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DILpYzXX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780471516; x=1812007516;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BX0UBKHVunDd9vehgTWcDlaDkDPSW1mTZCiQpL56p1I=;
  b=DILpYzXXZbRx0cYADlJPjy6osGHVZIT7G1YpXv44TWIOaBAzf0b922v3
   X04XFD3+drL04/4jQIhMGgg6C1e8G6EJowCib7jY12qO4JNPoBc73+UpP
   MYBRlKVd+BuSiQbCtTWiABbHHALjqQmVWd5bP1UcX7F92/N1U2euA9uNM
   xQIsIv5MQzfO+2T+BA9lNU2KqQDDjxtFlcpvgu6OKHqpWXqq7vqnFKBZL
   0uOYD/k7vwBwqXLx4e+ILNSrYu+Tm7BdKpnyZYSa697ElGmCsuuAhmO+M
   0YOtvJB8bx/HOwNo7NMs2jQWimyquzi+vK+cDVpqmYq8nomrjQ6ABBI5c
   A==;
X-CSE-ConnectionGUID: DtzrVmlpRAe5HpW0EwXvwQ==
X-CSE-MsgGUID: Rf34merkRImONkKp2aytQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="85157581"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="85157581"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 00:25:16 -0700
X-CSE-ConnectionGUID: fpg2HWfoQw+mK7bVVpMyMQ==
X-CSE-MsgGUID: D2dWSV7STN+kv9HKv8qU/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="239686138"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 00:25:15 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 00:25:15 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 00:25:15 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.69) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 00:25:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FekY/NwBxdwTcWTj+MaadU+91RitE9L5UMvV5EEgmR98FFL/lpBGwg3RuerujlvF8j+NAwqydUb7dTLxr+fSsHGBuyvuB9vURPNF2D3gZtStFCmgN4wXbcxSsRIdcyo8WiTUMPPdaob+52/1MuXXvNy+o78gomDYBcbrAyCTt7XfZ+siWPtAUxwZvd/0FGSawX7WCeX9Flet/1Z8AFvx6NFuwpWF3N8bv6MuG7e90iV/I8kASbYTEzFcLjTWd5f0M9hGok1u21RB1fdqrBybFqKo1Wm20I7oDILex4EsA4pGqTWIxr+RxqXv1stlRZMB+eXLTUXJ/ZlgxupPC6h1kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BX0UBKHVunDd9vehgTWcDlaDkDPSW1mTZCiQpL56p1I=;
 b=Gn6saEyfvirTBcMrs1ZkE4uEWlI4w5fslp2FgBfFuXxunPgG+BDx7qhyvUdWmmnMVKc8sqQNkf1o7UnGMZeKwGn6vmptXqcaFhy8DEiiTmN6rNNwJe4l7ZiW8A//XCrtI8hBnbc14olM1hM1RPwQWbzHDzcfVse8mR+wfkyRj1VV/NNz6uU8iQcJXbCAwRUzo0ooYu9ApJSej4op8zMdwTW7WZCES8m+1Bc8u4Jy/9Afhuyv92rmIyl+71GixqH6ev0RzieA863okEJOtu5JL4yj+3OW3VZxO+yM+D+Q9JQN38uuKwLcZDtoR+yd6yFTnyVDtqM5atlDeTBTdZH43g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3690.namprd11.prod.outlook.com (2603:10b6:5:13d::32)
 by PH3PPF6E8D29981.namprd11.prod.outlook.com (2603:10b6:518:1::d2d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 07:25:12 +0000
Received: from DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::7db8:f6b3:30f8:ee4b]) by DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::7db8:f6b3:30f8:ee4b%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 07:25:12 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Pranjal Shrivastava <praan@google.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Baolu Lu <baolu.lu@linux.intel.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, "Samiullah
 Khawaja" <skhawaja@google.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v7 1/5] PCI/ATS: Ensure pci_ats_supported() is PF-aware
 for VFs
Thread-Topic: [PATCH v7 1/5] PCI/ATS: Ensure pci_ats_supported() is PF-aware
 for VFs
Thread-Index: AQHc8dQgN6BHxdHpg0GvqgflN3VGibYscGrA
Date: Wed, 3 Jun 2026 07:25:12 +0000
Message-ID: <DM6PR11MB3690D980A73D1AE8D1B40A328C132@DM6PR11MB3690.namprd11.prod.outlook.com>
References: <20260601143644.2358771-1-praan@google.com>
 <20260601143644.2358771-2-praan@google.com>
In-Reply-To: <20260601143644.2358771-2-praan@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3690:EE_|PH3PPF6E8D29981:EE_
x-ms-office365-filtering-correlation-id: ee4150ce-6a5a-41a1-1ce3-08dec141400b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|22082099003|18002099003|4143699003|11063799006|56012099006|6133799003;
x-microsoft-antispam-message-info: zTq0X2D8dE1le3xvdup+DR5x17kSQlQ3lYsvprq8D0GDc9OzgxSO4zmbL/afNZXvrnSrsar6nMhS88tE+yZexv46EiGkgFtBJ8PM5MpAVsOsisnQF2eJM6fDxYdWIGw/8VjDgz0oFPYwm5a3tM8d8MOb60izRKapO3Wo8J4KzFYEpq0WFjyGd0jm57BAQ91P4Jj71zG9XVD5KeDv8cDzL6adsdO7XKbaQtb+n3dRz5H+5P1yj4n6V06xqjJ+gyoX7pXr/mRUHZkH82Q/xRDvL+MoPwp92aKj+Odqq76SENPCw7UAEFa862VkfU3ldwKFpeclK0f4tJW8Wyz5gAGwcRIVEi79YCbJr/VvCKpMs11OxDe3Vxjp6fO4EDNLIxGkkz/wSDE2hxfYttfb4FKEYG+aNMJFdQ0YlVpf4AbHNceua+V2N8gbl6fAxk2Zx33HaWhbhL5WSi2phnu0LRfbfD8xcBS024b8BN+yH3Qo5sZEXJeJ0Qa9DSgY7qh7qCpXaZjZzp7oKxmdVR+05Wv75Dt1aS5utJ9ifw5op65ERjyJnzuQXhcCfy99fps66Rj+sm8uvFrnBQhyWt8HFdVOHEGV/dkZMEkxqRkxzOSoypzrpAlIZVW09NZiM7euxQxdacuQ8F61MqmO0qCfMDB8n0Amx/8KItWfUcICCdf33ie1u6yx6Ce1qFo80J8WGJBwl4IuaB6V/4ktzU87/wiHdnTrOtxN4C1bm/TSTCjnTYsJs/tB2x54EGjw15Zndc6Y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3690.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TStFT0FHUVZkbDluSUlEMzRuZE4rd3hudUo3amd3TGhMUzZQZDN1bHJHSnc1?=
 =?utf-8?B?WisyZU9rV3phRks2WUE2Zk9IR1RzN0d1V2ZWLzQ0bVYrajZHelI0S2hFaGsv?=
 =?utf-8?B?ZTBRdTFhNmZUQ0lOTTdSenFGalZjakRlRVF6RzVZdDJxd0ZIMDJRYVlNV3h2?=
 =?utf-8?B?bDlVVFc0THJqRlVPRHpWR3cxMlpGR2oyaDRzWWlQUldCWHlYMk5TN2ljaHBw?=
 =?utf-8?B?Z0xhU3BiZ29aOEpBcU9mTXBTc1ZGQlYzV3Zlak52TExvaTAxdWE3RjVCcExQ?=
 =?utf-8?B?ZkpsKzAyVHZtQjFHZytEcGRkOXY2eGF2SUgvWWVmWXBpM3FPN2hnYVpseDZp?=
 =?utf-8?B?eG1xNVc4THEzSWhPc0M1TndBR3VaQjNjNkY2UldhSTR4K3g1c1VoZ0I1ZENm?=
 =?utf-8?B?TDhudFlRL0Vwc3VzcFNJQkUwT2xJOTJLZmtLTXp4QzRMMXJNZ1RiYTNGM21t?=
 =?utf-8?B?RmRXdXRlbFNQWHZBelhkZENPVzkwM216YlpTK0pQem5YemZqUHRYOGF5THM0?=
 =?utf-8?B?S2dqb1MrR3pKbmdCWVFkMWRJRlJWT0VmYkhuSFpIWjVtcXpyWVdWbWtXcU5i?=
 =?utf-8?B?cnlpakhsN2hCUWF3ajd3K1h4RHM1T3F1eG8zbVV4MFdKZHZoN2ljQlVrNEdZ?=
 =?utf-8?B?VHBrM3dtM0dTeXJBMEJ2UTFPcjlQL0RkcnB3OGo2dFpxVHRrVG1TV3RETXFi?=
 =?utf-8?B?VkZwNVVQeXJDQkkzLzFnWTVvUkZIOEk0SGVyOUNEM2wvdjFhUlNBVE9odWdh?=
 =?utf-8?B?OW54SlM0RmhNRXp3L3N0dWxJNTRqSHhnUUhNa1pOWmdKMlhmOWcrMlNmY2hh?=
 =?utf-8?B?Y2I4bE5wd29TL3BMam5jWUNpcEt3c1k0ajRscGFUSlJQRGswZFI0YmlBR2hl?=
 =?utf-8?B?YVJJV3BXbnNUb0V0WEIzOVl6YWZrTmJSNENBS3NaN21GSHRqa2dzRnNPSjBi?=
 =?utf-8?B?Y2x2d2dua1ZXTTJQQjE2TzQvRExRL2hQZWxNYk9PTWhseEh0MWNxa25BaVhX?=
 =?utf-8?B?NTNxeUhjUG1IS3ZkRUxrZk8ydStuRlFNTlhCR0lKdUhVRkRvYkNaQ0pSQ2ZK?=
 =?utf-8?B?N0ZPQjRUUHNXNTE1dCtqczFjaWpDOVArNGR5d3Vsc1RYaXZnL1BDbjhuMEFR?=
 =?utf-8?B?TzZ1am1Qd0tqUUhtbEE5eTlIbElDbVRzcVdIVFdzOUtKbTROSXowSzRnbmdl?=
 =?utf-8?B?L2xwcitKSENPUXQzNEpKZkczaVhocDBOWU1Cd0JNbkI5R1orQ2FKMHZlNEUx?=
 =?utf-8?B?ck4rR2lsazYzdVdITU9LREJjTFkvRFdDN2tqVEt6WHNrMER2dWRGN203K2wz?=
 =?utf-8?B?aTYwVE9uenVvUU5lMEtEVjZmTHJZd01GTlZXTWVsQy8vQ3dJaUU5R2NJMCtO?=
 =?utf-8?B?SkNTZHJTbVNhZUJLOFFLSWFVVGJsM2VxTng4Qm02YmFTSS9yRWZyU29zdG1q?=
 =?utf-8?B?d1kxUG5BamdyeHpJUDBHZlo4M2xPYklFVUt3VE9EazhVN01VOTV3V1BJVGUw?=
 =?utf-8?B?N201UEJBR3VmRFNZM094Qm1iZkVFQXpuaTh5MkNMWjZGaXhLVzAwZkNDWTRQ?=
 =?utf-8?B?a216VUMwbmpxTlJuWnBlck5xZFNOTXNzVHlaZDFjcGpvc2tGV1g1NzlPYUdu?=
 =?utf-8?B?Nng2VE9FZ1gwbnBoZ1A2R2FqdmxNOXZub2pqZDdpclFXN2pLcG5JTGEweHNR?=
 =?utf-8?B?ZExrSXEzSVJpMXpnd1ZoM1ZaMEFQOEdNQzF0c1M3SnY5aGdQYmxHOGVPQ0dP?=
 =?utf-8?B?aDdoR0E3Z1lHRnBwb2lNUWNFUkZOcGI1bWwrclJESDhaT0VuQlU2N0oyME4y?=
 =?utf-8?B?YkRWSjI3QzFPc0t2ZXpuaHhZT1NhTnJ5VDFrbm1XOHN5dHIwT0U1R1J4dW1u?=
 =?utf-8?B?b3RxeVJCdDAxL2JXa2RydFdJRjlhN0VyRXZYR3BSQnlDaGhkUUEwU0h1QWdZ?=
 =?utf-8?B?cndVdTkvb044S3VXbmdLMVRvUWxtVlJ3ZlNOVG1TUmxrTkNmY096UTVHbW9J?=
 =?utf-8?B?aGJJdU9QcjNCamJYdjN3YUhQM3ljWFY1LzA5TG1qRFNjRnRqK0hlNmxyQW9B?=
 =?utf-8?B?MTI4MzRhKzB3Zms1UUU4N09qRVU5ZXNmcEtxaU84SmROTHpkZGRTMUlqblpp?=
 =?utf-8?B?bkRvMzFlU1gwNVFCNGtqN2VpYVhSc0lZRjZBOUVwTUhUMThHbFRyd3NPOHNp?=
 =?utf-8?B?VjZKWUpCMVhOQVhEcWxiOVV5bHZ1dEsydXpwL3JMZWphVzFsOTFhY3A4QTBz?=
 =?utf-8?B?QVk1TGx3R2VUeTRiTkgwWVdBZ2R4QlhaSDFiVzdsWE01OVFpanJzbTNlZGZu?=
 =?utf-8?B?b1M0ODE0RnpXOVVyUUpTSW9PUWpBNHluMFBUY0h6b25wNEN4ZlMyZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pV/v2kZXczrNh949+JLm8bSz6ZIeXLaPZlbrjppe+3JiZ6tsBAgd9kkbJVtKCsvfD3ySCw3ntgyu29Kpr90SJMICSDkWfWvoQHCTwXkRwOiIdxlvva7jv14QW8VUP64pqJmrm+HJnm0mBJLuXUIawTd10XXgimb3C0M5qLNM5QnavarHop52F0QhoiySxrccdBB+/OWPaY3TB016Un95UC0YqnsI8LmCCDYPfKw8AA8oEpu0Qmeyp7Nu6NYLoN8ib1U+D7PHj3w5dPiffrsO3d/DYlTewfgy3w82IHIVynLt7h9x/tAJYTSEvsPEbnUwbWCMaA/M23eX2MoFzKe9Kg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3690.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4150ce-6a5a-41a1-1ce3-08dec141400b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 07:25:12.4629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xHgGbPdf8IWA1fZLsokDUxjUkDBNgU2CIZdMjMdJN2r1x0+88XvYPr3gXI1wWHqqJK8pyeC8kEvbnXpNeEgPjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF6E8D29981
X-OriginatorOrg: intel.com

PiBGcm9tOiBQcmFuamFsIFNocml2YXN0YXZhIDxwcmFhbkBnb29nbGUuY29tPg0KPiBTZW50OiBN
b25kYXksIEp1bmUgMSwgMjAyNiAxMDozNyBQTQ0KPiANCj4gVXBkYXRlIHBjaV9hdHNfc3VwcG9y
dGVkKCkgdG8gYWRkaXRpb25hbGx5IGNoZWNrIHRoZSBhc3NvY2lhdGVkIFBGJ3MNCj4gc3RhdHVz
IHdoZW4gY2FsbGVkIG9uIGEgVkYuIFRoaXMgZW5zdXJlcyB0aGF0IFBGLWxldmVsIHF1aXJrcyBh
bmQNCj4gdW50cnVzdGVkIHN0YXR1cyBhcmUgY29ycmVjdGx5IHByb3BhZ2F0ZWQgdG8gVkZzLCBw
cm92aWRpbmcgYSByb2J1c3QNCj4gc3VwcG9ydCBjaGVjayB0aGF0IGFsaWducyB3aXRoIHRoZSBr
ZXJuZWwncyBQRi1jZW50cmljIEFUUyBjb25maWd1cmF0aW9uDQo+IG1vZGVsIGFuZCBpcyBpbW11
bmUgdG8gdGhlIHRpbWluZyBvZiBWRi1zcGVjaWZpYyBmaXh1cHMuDQo+IA0KPiBSZXZpZXdlZC1i
eTogSmFzb24gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IFNhbWl1
bGxhaCBLaGF3YWphIDxza2hhd2FqYUBnb29nbGUuY29tPg0KPiBSZXZpZXdlZC1ieTogTmljb2xp
biBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPg0KPiBSZXZpZXdlZC1ieTogTHUgQmFvbHUgPGJh
b2x1Lmx1QGxpbnV4LmludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogUHJhbmphbCBTaHJpdmFz
dGF2YSA8cHJhYW5AZ29vZ2xlLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEtldmluIFRpYW4gPGtldmlu
LnRpYW5AaW50ZWwuY29tPg0K
