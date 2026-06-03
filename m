Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B99725A2A2;
	Wed,  3 Jun 2026 06:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469767; cv=fail; b=GA4y2p92DHLy59K/2SdcSS+T/QhM5OHJ/jtw1wlrcKTrgZ2eitxTlhGj0qdYzvMRGFrme7R+wlINt80lUlGEEPaI+DqgSxNSgq87bniJH+wY6wbgQKra3FPZclRe17BQt3+Uo95M1LOTZI2ok/Om0H86Fu3sGcJWpCY4p1xSE7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469767; c=relaxed/simple;
	bh=FqPBxzey3aVksZc5SfnE5st3xPIOW9IteIoBYtBfvsc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i31+ZI7sM5bkLNTlNEzBmklZ5ZRT0yd6XogrZY2yWgR2t/PQOa9z7t7XKxsNXE/N/06ENjEIVcE1SwqhI5rXQ0oQVNyMMFCcF0gU7mw92MzHRl2yoXvb11yIX8EnxmxwhgZ8tp8roxScHoz/WauQL9UWIf8xfCwNQHD1W1DVVSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FubAMSy2; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FubAMSy2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780469767; x=1812005767;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FqPBxzey3aVksZc5SfnE5st3xPIOW9IteIoBYtBfvsc=;
  b=FubAMSy2u0uyT5LFQtG5us87ceis3fXXDEzZhRp7zDOeF/x2bzh3p5eb
   qqc+0rzKT4MpyyEkhsr2L3EQlT5721ptgy8hkeWePJvUTUred3nWP9TaE
   soGV+ShorvJvIlCpG/NOq2FkNDhW17hkDNuq4dBX/tr/eo6TfClsfWPSt
   OzrL6gRp/qb7wjJLZfg9sVsphQvvgwpolBeVsArOHRLq6EDb+U4hyuKh7
   9gFVbuvCxAeE0ATTRHS36V/JHOqhE0ASRHRDQmPAV8mNf7x6H0fe8j06T
   X9OlFn04TQKVrsO2N7u9ha1NbHbTeYP4BIoSRpVfWReVXQbNWtXMcE0dD
   g==;
X-CSE-ConnectionGUID: 5/Ie0LnkSVKeZLKXCKkHpg==
X-CSE-MsgGUID: CcLyBmZESlqM2+rFbJKPOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81327480"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="81327480"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 23:55:54 -0700
X-CSE-ConnectionGUID: bxa4NrLJRIGFjQU66HiiUQ==
X-CSE-MsgGUID: OSvFNyVhRpSeOObUphMS7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="268017888"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 23:55:48 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 23:55:47 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 2 Jun 2026 23:55:47 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.28) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 23:55:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rbl0JMjGWRSRrUqJCa5jeV5fkbPEH5G9EGcKer2tgijBnXH66V4bRQeMLoqQYLtjr5giQFVjd6Irssuso8dmQkgrXy84J4tXwuM+CJ8Tsvx5bnYLmuJXxM90B7w0w/mGp8j5SIB0rDOZnlrqBIgNdb4n5SeoNm8Kd4xSEREPfMtfQ+Fnva04xvZvTZXcNSbU+yK0Yqt5JyVMYCuAhsjuiNbO7sKp7R4DHwR+kLt4anbmihnjRDw9xCp5r+dS97zCJPGOaf0kZ2wFN1hfM5+7ylW8++mENqBrJoCAXof3NVMI87Dj/dApiA9Iroa3f/AfB72bNaIro5YEZaaNfQQjog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqPBxzey3aVksZc5SfnE5st3xPIOW9IteIoBYtBfvsc=;
 b=J64/0VLTvW2jbzK72Obls2XzQXP1rcHaMEY1bNfuZXVF+npgERvwS5EJ/ziLSoSJbWWMrLmma7UXHWSsti5WYzB61NIH32ZGTektr1AOct61SyD0WTd6nNHs47WpKVWn0y0MoN7dyhI/rFQ2DG520u/eo9OcPBIbCr4su2FU1bqLppswWnS56xHyHkTCbDSisuS4wAx3nXb6cgwD/U9qNUL7cmzuxHNzJf9cXB1CNJN5q1Qh/uHsSlNjbdGmN/8fiAAkF3phrxdBGToeNbtBUUnVCzSsJbELziZqRLPdP48/6wgEYI8CVH0hwULClMQdkvi0aGGTpajNUJT/S8Nfzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3690.namprd11.prod.outlook.com (2603:10b6:5:13d::32)
 by PH0PR11MB5030.namprd11.prod.outlook.com (2603:10b6:510:41::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 06:55:40 +0000
Received: from DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::7db8:f6b3:30f8:ee4b]) by DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::7db8:f6b3:30f8:ee4b%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 06:55:40 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Ankit Agrawal <ankita@nvidia.com>, "alex@shazbot.org" <alex@shazbot.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC: "jgg@ziepe.ca" <jgg@ziepe.ca>, "yishaih@nvidia.com" <yishaih@nvidia.com>,
	"skolothumtho@nvidia.com" <skolothumtho@nvidia.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "clg@redhat.com" <clg@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v8 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU readiness
 check via CXL DVSEC
Thread-Topic: [PATCH v8 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU
 readiness check via CXL DVSEC
Thread-Index: AQHc8llgX0bwGaLcQESRmerbfY6YE7YsZy3Q
Date: Wed, 3 Jun 2026 06:55:40 +0000
Message-ID: <DM6PR11MB36909F7FC7FECFFF5D8A8E818C132@DM6PR11MB3690.namprd11.prod.outlook.com>
References: <20260602063015.3915-1-ankita@nvidia.com>
In-Reply-To: <20260602063015.3915-1-ankita@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3690:EE_|PH0PR11MB5030:EE_
x-ms-office365-filtering-correlation-id: 935bdfe7-bef9-436a-7679-08dec13d1fc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021|22082099003|18002099003|56012099006|11063799006;
x-microsoft-antispam-message-info: qYfwlHPnbhLSOw9kWDcZ9X7Zd7P7Q4HH3lx5uymjmEMynBl4zzJ33dTBo8A3OPMUZXhWE4JqFk6aOXayJku5xUW3lbmxZDCyrKaKqBXp0y6NTe8Db6OEfoMqHPq4DS6YzMLp8WzQWLUQHuDWl/3SC/7PwjAZavlENpFM4xbL9apwJDeQ2ILg62KEqSaKVyrHzote022Q8eMG0c3uHrYfR/hl/Fp5aJsRHYtFQ4JqbmecFOLh8/Eyp3Be2jJp0CySy7/kzkVJBFeh4KQKE53EU1eMOV+vyPJd+53WpFQu+PVqog+ay4BX/xnX0RxGK9oEOvLIHwPwsExTb1hFPCjVT1xES1ARIo2NPpNU2PN169YS6EY9/5Jkqi9HJqkWH2uxmCENMJIe159SXYB+9/4kEkXXqMegEa5k9i+cnCFbyXqHi9IsQxb+hW6omc1vBQJlAwTUWW72jJQpRTWSwrukXIjhkhLlazW+KNS15QftlUYuQ/l3bb4K1LCUJT95o/ZGbLdEdGYO1K+QS978fTsPuBbDczvWRRD4aD3MUYZre1FQ4D60/yv4mYd1DNhgGURJd04eERJalLeGQbIsgAyTxSnyz3+DB5dKJNc78QTki+7odKkp1ofFp7RiAlFXbUK505KJ/AAX7RiZ4raDKO5JJHmjj0Nd7B8sPV7exCJbLBIlcBf0d0IvPxfv+bpZ1HeLkI0i270BiIofZIWGA1Hcn9qpv+qVnZ5VU2+M0FGriWe99hDB+cnUlXtk3uYjdUuc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3690.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0dCaEh3S3ZzNmpVMHdmTDVVbXpRSTVhRWg5YTRsdzNFUnJIcE91N3ZTVHpl?=
 =?utf-8?B?eXE4RkdYb083RStRTm9DVlNIc21XUjNqM2FEYXZFbGRNcmlnWU5iTkJicCtJ?=
 =?utf-8?B?WmJleVBFb1NSSDNicCswUU91OVBjNmFVQWRMcDhlT3dNaE1pUnhzVlpaZ0xH?=
 =?utf-8?B?VmplbHExMk5FblJLS1diMEpoc0RHbVFDZUNkUUFRTGM5ejkzeGN3VEJsRDBk?=
 =?utf-8?B?Q0NJMXh6L2RYTTVzeThrY2RQb1AyYnRjNFVSd2FqOFk3L0tQblU4SzhUczZP?=
 =?utf-8?B?VnUrVlF5MGt1Mis0ZkpjbUQyMDJjOFRzRVVtNlBONFBLSG9DTGdmS2gwbnht?=
 =?utf-8?B?aUp1Tk5jYk1kekVKK3NMTWpyNDJTcjBZb3ZNNmdwQ2gxckpkSTF1Q0xLa3ZN?=
 =?utf-8?B?TnpCdjFKMGtZNUExclVEcHczTXBka1dKOTVtWjJDWnpkcm1ML3JRdW1Jc1Mr?=
 =?utf-8?B?QzNmRmJ4UjZ0M3JjQlVCeERROWtoeUsvS0lWYTJKTVh2TEtzVjV3RERleGlq?=
 =?utf-8?B?VGdheU1WMDUzdmZwaEVRdUpCNThnRm90c1lQcHV4ZEprMDYxWkVodUlrRjJY?=
 =?utf-8?B?OGZMV3ZGaVNCUTBuTDQ1RmpiVzRqVkZJK04zWkxQRnpmcTY4N3RzTHhWZmlO?=
 =?utf-8?B?M0tDYTBKM25NZi9nUGxPU3Q1b0xmeG1iWm02MDZGSW9MclQzQ1NnamtRZU9H?=
 =?utf-8?B?aFR0VGdEN2VLbHpxSTU3ZEUrcjh4T0pVOUdFd1V2NG9pbUo5YTNwcHpRRWlI?=
 =?utf-8?B?cWVRNy8zaXJVU1gxdW5SdUxZYmhYcnJYZjFJUC9UL3Ard3AzS3hLRlAyaFNy?=
 =?utf-8?B?cWZDalBIQ28vRVhDbEw4ZmRuR0hWaENvUnErQ0FXODhqaHZFWnNDK3FRVzhY?=
 =?utf-8?B?L0puZlYvbDVoWGhON2t4NG1FRjBGaFAwazZZSHlDWFI5VFpzQ2pmRk0wbG1R?=
 =?utf-8?B?dTc2VGVQOGVKdU9uUDFZVHRvT2QyWmtDcEtRbHB4ZHBBdzJ2MVlRaWViMkhT?=
 =?utf-8?B?MVVmdE5rZlcrOVJVNzRNTVQyOFNveWxZTVI1a1VaOEhPRnV6bnVhakZlZjA2?=
 =?utf-8?B?SVdzd3M0UXJCdk9ueG5jSHE4NXJqazNwcWQwZVpFMEgrTXRyTWM0SXNEZXBI?=
 =?utf-8?B?Zk5xYUd0YjJ0aWhtckJqM0szeHhLKzhvWjQ5OVdxRU1Dak85d2cvNFF6SDdx?=
 =?utf-8?B?NWtJN0VNQ0llSEp4ck8rSEVJbFdhNkM5bWxMZ3hPNWJNeWgxa3JTSm4xcTFs?=
 =?utf-8?B?NXVVeU14Q0ZncjVFVHFwZU5MMUlMY0IzNDI1Q1dvVWttYmwxLy85ZDJZRmt4?=
 =?utf-8?B?M0o5TWZXamRRNlo2TnN1QWZ0clJJM0VoUjNDeVJYWjR2YzZQenBUN0RNd1Ni?=
 =?utf-8?B?a0J2Wk1SZjRJemhFenZQaFNLVFp3NFE5SWhlaWlPdmNhTjB5M2ZOMzJnWlRK?=
 =?utf-8?B?TG1NeGNjUnVlOFhnUWFkTG9DMTd2NDdwakhmbkwvQ3czdGpzdW9LK0c3ZjVr?=
 =?utf-8?B?R1BwRGEvSkMrRGJNempnSkJvT1F0L21OM01zV2huNWYvZ2JEbDcrckxERzhr?=
 =?utf-8?B?eDJDK1ptNDJxMnNIcU5hVWUzbk9Kc3RHQ3dRak5XMk1WUG1NckJCUmcwMDhO?=
 =?utf-8?B?R2xHYXR6NWdVZjIyY2ZrQ1BrbzFvMUlyeS83dXpXV042clR1alJKeFNCSmNy?=
 =?utf-8?B?Y0hiN1ljUzVodXBObjlHekxUWUFSRnVHRGR1V0xpZFhuUFZVOElVcFdDYmc5?=
 =?utf-8?B?MVRoZVJSb1Q0TU9nMlNPVmUwb0tmTjFEbWtxaHhtT21ySlVLNHVHbGZSZVJP?=
 =?utf-8?B?RmthSk50Ykp4cW96bE5uS1FOamRsaXJqNmlia21JdG91bnR4eVJ2V1JoUEww?=
 =?utf-8?B?ZGl2NEpKZU1aL3c0eDNiSW14eE4wazFGdnlEL0FhT3BiTENwaGIwMDlWL1Za?=
 =?utf-8?B?RVhvTU5TOHNnWmJDbEJkZmErbmswSVJiUkNycUF2UmljdmJVRmswTys5a0xH?=
 =?utf-8?B?S2o0SDdoWnZYenBObXJHZFhLQVJmdzR0eUdNMzRoenZjbnlVUHViVThjcUky?=
 =?utf-8?B?TC9hODBVaVJUY3VNeFRMYnFTVkpiRHh6dThiSE9mdmIxSWF4dmN4eHZDSTBz?=
 =?utf-8?B?V1piZHlENUlrYjNyRi8zcjB4NitzYk10eVMzZlRUL2QwRmFrbkhDL0pvWWdK?=
 =?utf-8?B?clFxcXgzQm5Jc3AzeWZKVHJjTDVIMU4rZVlVbGVXQjBwbkNlZGxvL3gwVmZ4?=
 =?utf-8?B?M3p0S2ZGRHgwUlVEWlhEL2hKWFV3SlBqRTltOFBPM1pRcXlwbjFxRGdxaGFv?=
 =?utf-8?B?aGQ5WE9Ea1ZLS2RkM1N1aTE1VHhYSWpsZlFGVWFUamV6azlQWGRlQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kfRYWgfE8dpNiRqUI32hgfEfHE62Oa5DCmN7zgkQrjZLvm+jTm9puSc88KsAvAMhDJOAJ91UG9IQ0uQxN7+idYZ19uVxvTgRibCKCUq0+pMyPYDnb33xPA/fbhGEgtcWlSLxGDSQtbVXpLT4bh1b+SGxS+LJkH2i+fxZp6pfQTbBkWkKYJUaWHKBj+smk/63CpQiDFsrC2SyGUYDOBdwWQ7eFxUJOQVXBhadFgZlqsfZJdFdUGaiSEssgt6WYCA3g+/+SMt2hVz2NjqtRQpp/5wW5cvNCeNxRL8suEhnatyaaTM5Xve6re4iuGHXuuMR4VzW7z5F55fZRCxzZ8zZSg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3690.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 935bdfe7-bef9-436a-7679-08dec13d1fc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 06:55:40.3518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CmCK9OmLbaSNGiZWClH0AUeG6GYxVXXA6jWhP/dWfHJI1bDb3Bg9aAXavchwCoRituHV/n3AEiSIeHHTLeVoEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5030
X-OriginatorOrg: intel.com

PiBGcm9tOiBBbmtpdCBBZ3Jhd2FsIDxhbmtpdGFAbnZpZGlhLmNvbT4NCj4gU2VudDogVHVlc2Rh
eSwgSnVuZSAyLCAyMDI2IDI6MzAgUE0NCj4gDQo+IEFkZCBhIENYTCBEVlNFQy1iYXNlZCByZWFk
aW5lc3MgY2hlY2sgZm9yIEJsYWNrd2VsbC1OZXh0IEdQVXMgYWxvbmdzaWRlDQo+IHRoZSBleGlz
dGluZyBsZWdhY3kgQkFSMCBwb2xsaW5nIHBhdGguIFRoZSBDWEwgRGV2aWNlIERWU0VDIG9mZnNl
dCBpcw0KPiBkaXNjb3ZlcmVkIGF0IHByb2JlIHRpbWUuIFByb2JlLCBmYXVsdCBhbmQgcmVhZC93
cml0ZSBwYXRocyB0aGVuIGJyYW5jaA0KPiBvbiB0aGF0IHRvIHVzZSBlaXRoZXIgdGhlIGxlZ2Fj
eSBCQVIwIHBvbGxpbmcgb3IgdGhlIENYTCBEVlNFQyBwb2xsaW5nLg0KPiANCj4gVGhlIENYTCBw
YXRoIHBvbGxzIE1lbW9yeV9BY3RpdmUsIHJlcXVpcmluZyBNRU1fSU5GT19WQUxJRCB3aXRoaW4g
MXMNCj4gYW5kDQo+IE1FTV9BQ1RJVkUgd2l0aGluIE1lbW9yeV9BY3RpdmVfVGltZW91dCAodXAg
dG8gMjU2cykgYXMgcGVyIENYTCBzcGVjDQo+IHI0LjANCj4gc2VjIDguMS4zLjguMi4gR2l2ZW4g
dGhlIGxvbmcgd29yc3QtY2FzZSB3YWl0LCB0aGUgQ1hMIHBvbGwgcnVucyBvdXRzaWRlDQo+IG1l
bW9yeV9sb2NrIHdpdGggb25seSBhIHF1aWNrIHJlYWRpbmVzcyBjaGVjayBpcyBkb25lIHVuZGVy
IHRoZSBsb2NrLg0KPiANCj4gVGhlIHBvbGwgbG9vcHMgc2xlZXAgd2l0aCBzY2hlZHVsZV90aW1l
b3V0X2tpbGxhYmxlKCkgYW5kIHJldHVybiAtRUlOVFINCj4gb24gYSBmYXRhbCBzaWduYWwuIFRo
aXMgYXZvaWRzIGh1bmctdGFzayBwYW5pY3MgZHVyaW5nIHRoZSBsb25nDQo+IHVuaW50ZXJydXB0
aWJsZSB3YWl0LiBFeHRlbmQgdGhpcyB0byB0aGUgbGVnYWN5IGJhc2VkIHdhaXQgYXMgd2VsbCBm
b3INCj4gaW1wcm92ZW1lbnQuDQo+IA0KPiBJbiB0aGUgZmF1bHQgaGFuZGxlciB0aGUgd2FpdCBy
dW5zIGxvY2tsZXNzbHkgYmVmb3JlIG1lbW9yeV9sb2NrLiBJZiBhDQo+IHJlc2V0IHJhY2VzIGlu
LCB0aGUgaW4tbG9jayByZWNoZWNrIHJldHVybnMgLUVBR0FJTiBhbmQgdGhlIHdhaXQgaXMNCj4g
cmV0cmllZCByYXRoZXIgdGhhbiByZXR1cm5pbmcgYSBzcHVyaW91cyBWTV9GQVVMVF9TSUdCVVMu
DQo+IA0KPiBBZGQgUENJX0RWU0VDX0NYTF9NRU1fQUNUSVZFX1RJTUVPVVQgdG8gcGNpX3JlZ3Mu
aCBmb3IgdGhlIHRpbWVvdXQNCj4gZmllbGQuDQo+IA0KPiBDYzogSWxwbyBKw6RydmluZW4gPGls
cG8uamFydmluZW5AbGludXguaW50ZWwuY29tPg0KPiBDYzogS2V2aW4gVGlhbiA8a2V2aW4udGlh
bkBpbnRlbC5jb20+DQo+IFN1Z2dlc3RlZC1ieTogQWxleCBXaWxsaWFtc29uIDxhbGV4QHNoYXpi
b3Qub3JnPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbmtpdCBBZ3Jhd2FsIDxhbmtpdGFAbnZpZGlhLmNv
bT4NCg0KUmV2aWV3ZWQtYnk6IEtldmluIFRpYW4gPGtldmluLnRpYW5AaW50ZWwuY29tPg0K
