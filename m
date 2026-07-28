Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6ED3C7DE1
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 19:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785266196; cv=fail; b=RxFk3MV/TMdUcKqvirHkN1lrvSbbzfHQEoyXkByvX5AAIqrjOBH2Ijl1Uj4Pv7XU02TS9xsoFdtq2zSLNXx/XlJnfdSXXrtGGvRxkbrKcRwzHNESBGnvgwa7RdFCZe6KWSPSww1k224TNbW+ZxebJ5TAeXhfk6Vjpm1y89r2YYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785266196; c=relaxed/simple;
	bh=R2B2EVHfA2mAvseKFULhnXFgQmIs4b4IMkFB/pdm64Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aZBlT+oOjM1acN+M1k9qFvlcU9ucPxAKro/MVsVM2zoiz4Lg4jbsD8xl9LKpdJG1Z1GcmbM+EOd1nnhamrmIGWKFRAzHDMLRst2g1s5sJOm3peUis36dGS8R8/z2mPvZBD9ssV5YbGnHazubLjvbHNkjVhEwuL5RcbZaG2ilFV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nZfGpe8o; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nZfGpe8o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785266194; x=1816802194;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=R2B2EVHfA2mAvseKFULhnXFgQmIs4b4IMkFB/pdm64Y=;
  b=nZfGpe8o4J6VSRVTr6advf/vfU2SuXbfYqNabKol3J5LnPP1JWi0Zjy4
   OfoMK2p4r3tNtEHA0n+xfoM7IVzu/EWxpXiXNmSQN9qw5gfUuMAN6Pa41
   SF+8Bh2ftTFEXqrBlGatEs+A1Ja7DRqVU9KzcFWzhUp6W9JTUtE5d3bKt
   Ne/+O4gzmZkMiPdu8rlcHOLMfWyli7X6H6ZEbPVnD3WIgTDBKebFgnuGy
   KQTFTJ2ArMgfy51VipjZu1ofJkKvlZb0jwUmwMOyIZhTg9TBWVXMz4Eby
   uvcCKGTu2n7HOhY7aa0U7aGNxZJGvs3DzLYkRNIo1C0LtMcYiDMyWxw87
   Q==;
X-CSE-ConnectionGUID: OP0cVcs2Q9+G80O4pM9NLg==
X-CSE-MsgGUID: r7cpZwP9Q2Ozxo03j4hGMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85739648"
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="85739648"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 12:16:33 -0700
X-CSE-ConnectionGUID: LlQZX58iTDe7p3kHcod9fw==
X-CSE-MsgGUID: fOmQYRYPRSCDXkxuopwAnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="261748269"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 12:16:33 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 28 Jul 2026 12:16:32 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 28 Jul 2026 12:16:32 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.19) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 28 Jul 2026 12:16:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZskJ6mF+Kv7GhmWAbBjcgqZaxwqj6hlScUZJh2nUfx1AMY4/GtjWDUWeylcWOT24lw5iWGY7kHq0hR/Dqr04XRI94N26KmFV1NrRerXx+yBoSAtdG0buW97qlwtjElUuoLQnyKuY3Xe60ZqOUw2HZI0VfMiNlQdl8ZJ5nPJ2jlOLp3M7lPc/Fy150bjm0Lr33jrSyu9ADA8Hv2Khj2KwEPLg4g8W1F+EJ5uK46NG4dPyq68Smzt/iUr6LgSOoV74hfjlMNhm1HJPjqIKiY8zZZAe2Mx4y8ECj+a28LOIPizcn8DhFWzhQ1inYBXu5R80qdMgWKPkDowbWLfUoee+PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2B2EVHfA2mAvseKFULhnXFgQmIs4b4IMkFB/pdm64Y=;
 b=WvAaITJKfjuRaKlGiF1NM0rzb/Q60djSpe0LVVHLoh0i8cM0uwMlAov6CTLxU9gYC5VobJedasTL6yKiq39/0uy9OYePLi+M7/p/FyTZRWEixl1r8JHktMkXA0j7ZF9wfglbQObnk87M22gzJvvh+x/d8ow7oq/KMQjdtxGRAztEWti7k7jlA0PdqacSTrqzrjR05/yTVZPhH2Y3L7IseyQCEm63vfLqSFhe4Rp6xyOEU4NXl8ehfgOJDo3qm+uzcImhySUqmHa/PLM/KzpC8DN7w3caquy0YD4vdkdGoLRl93b8XEfUJoP8y6tlwmo5MSgY9boZBy0zmqh79KqP5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7494.namprd11.prod.outlook.com (2603:10b6:510:283::18)
 by DS4PPF2AD6B04BA.namprd11.prod.outlook.com (2603:10b6:f:fc02::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 19:16:29 +0000
Received: from PH0PR11MB7494.namprd11.prod.outlook.com
 ([fe80::e642:c73c:6d80:5083]) by PH0PR11MB7494.namprd11.prod.outlook.com
 ([fe80::e642:c73c:6d80:5083%5]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 19:16:29 +0000
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
Thread-Index: AQHdAUruh/HWEZwEC0iMA6tK8iUSn7ZImB0AgAAE6oCAMTTxAIAABOIAgAAe6wCAARjQAIAAHZOAgAhH+4CAAAUPAIAADfsAgAABaYA=
Date: Tue, 28 Jul 2026 19:16:29 +0000
Message-ID: <f3de82374a791c236a8c5a51676fa676c4621ca6.camel@intel.com>
References: <20260728191124.GA1386613@bhelgaas>
In-Reply-To: <20260728191124.GA1386613@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.60.2 (3.60.2-1.fc44) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7494:EE_|DS4PPF2AD6B04BA:EE_
x-ms-office365-filtering-correlation-id: e254bf45-6dcb-4251-3d4e-08deecdcba36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10067099003|6133799003|11063799006|56012099006|18002099003|22082099003|3023799007|38070700021;
x-microsoft-antispam-message-info: IWbRWvjF8AJ22YuKb4irnUImiA/aDJ1hR39GY4dYz+3L7pVp0Y1PEtf22js5Pfb1xRGOHntN9eOTHFq4SFl6CQFaxK9ueTGOSTpFcoCc/IqmU2MScmkuA86pRJwxloolem6VUSutVIVeP53CzZl9KIKMGeZwa+YC4j1Id4HFZTP+S0iEtI+55Zov107tGhTZUko0Jnil81eHZNlU+Eil1lutntuwfQ4WIszhKYPHZATMXFZ5XfGsAOODBhQ+iGUoOgy3LZ7R8DcxfEDxqe/TWRlYjZWpC5Dt0L2T2ZSp8RDOL1DyLIFlvy3IC+xwt1tpvlEBg9uixBBgNwNdgZ2Z5ShiOyNKipAIVi/27zmErzBRGt+5XNsndBzhcy0KuEhpSX8jK74R0v9bzQ+hCcpgIr/h7wNcY/EBYKu066gZ5wwlIyEXBOlY8p2mgE0qHFfECj/9z3olV0aaQCsTlAF2RIvwjL/fa7ZXhmB36PNTQ2gfgPpsuLG+KupQgHPROBahyJK5DnZMVCcDyVONpHPAW9Oq8ege4I8yT4uzuq5askcz8olphEcNBIoc+YfW0YFCibat4D3xNON66HEi/rV4dB4AAxOOxuOSxhODmR42DVJDMG8ecSpx9F19jNl3m1M3/kYBl9YKSDYHnqfR7kl3VLW34EpdfVIoCrlR7i+6IxCMX6P4KqxLospZk3/AMfgECna5wnSNcMzAjIvx3PHQTGC5GsNK8/GtllwFZHuooZM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7494.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WG5pZ2FmQnFXeVdoMUVSeStZTHJicmkyci9wTy9EZlU2OTlWRFF5ako1cVVD?=
 =?utf-8?B?c3RzdlJVNGVVTHJVd1ZobkNKNk4zV0lsbUZmSGZFNG5JVXZwSVJGZlltekJj?=
 =?utf-8?B?WllSRWYvTk9uMHhJUFIzRU10cWlnMmhhTW84aG9KOUtEK2ZmTjcvNGpNZHFC?=
 =?utf-8?B?MjFlclp1c2ExazFDMDZBaU9XT2JHVFFJdXN1WmVjZlFPdTJmbWdmMndXcXo4?=
 =?utf-8?B?MG5qT2hrLzlISFZzVFBTM0FJZjQwdkxLWjgzQmVwU1BOTlErNjZqZlE4UkY1?=
 =?utf-8?B?cXkvWnJVdkRUaWJSeTdIMFpCWng4OERmelVFOU50Y1NpYXpOZ3l6VGlQOS9v?=
 =?utf-8?B?OG1vVmtkMDNXVExEVndGbytyZ1pjZ1JlWkRzMmpqRWFHMEhkaXM5Q0M1V0kz?=
 =?utf-8?B?NUdvUzR1NCt1OEVXbTQvaFZ0dmdqaEN5YUxpZHU2NnptVFF5emwwUGFIK2ly?=
 =?utf-8?B?eTB0NjNCRFhyYXY5anMxK3BPNWZBcEY2eXVGOTlhd3A1UmUzUTNPRXVoTnE3?=
 =?utf-8?B?SG1iUzNmU1VOZFZMZUtIU0RnSDl0TDNPRjB3S0NBV2RZUXVKRmFacVNoWStT?=
 =?utf-8?B?bHdOT1M2OS9TMlBhaTZpOExPR2YwVmdhSVZzQ0Vlc2E1NFdnaFVkeHF2MnNP?=
 =?utf-8?B?OGxRcnBITy9yQlhMLzZXelZMa1B3UnQ3dEdpeDRlSTlycFNsU3BDZmlWVkxy?=
 =?utf-8?B?aGhlUC9ja0JXMDJWUjVjQWF0cEpHQkwyN3g0TTV1aWdNOXd4MjEvdVJKcmk5?=
 =?utf-8?B?TjVjWVpSeXhWUUphOUo5MWZoZ1RoWHBxMXlIcWxFSnlnWFRoR0dwSFprOStM?=
 =?utf-8?B?YTdMc3J4aDBiYUpJWGNRWlB2eUg1aEhhWlQ1a1BkU3QvTDdjUHg5QU9DOVRE?=
 =?utf-8?B?SmwwTlcrNjZVWGRqTGE1YThHeTZiWEFFb1lQdnppenYrUVpIK3luNVVHdXF4?=
 =?utf-8?B?RHlXaUNUU2ozZUdwaUdFYTRsUXNHOFAzVmIyNkRNNzRXZ0Vta1JPZjhqbWl5?=
 =?utf-8?B?QzNmNWRMTzBEbWxnaEpFS2dWRmJrcFZ1Sk1QNWR4Sm1pS0hwUzh0WHI5ekgx?=
 =?utf-8?B?dDJlWDdEZ0dnWHYrdXd5b0UwcFpZam1NaDZrWnRYbWVDblhETXAxNzh6WWcz?=
 =?utf-8?B?UzVCT1hidVdnWWdCZkFuK2VJcm9qRFVUcHFGTmpuY25HVUxZTjBhblVkZ29J?=
 =?utf-8?B?RlVPcWtzNHkyaURtNkhXN3dRNGIwaVg1dXNGN1FaZk1ZV0dtZTVDR0NWTExC?=
 =?utf-8?B?MnBmcGNEQUJwZVdkcGtxYUp3NEdjZkRJMW45ZVM2eS9mTHp5bXhZeHlESzk1?=
 =?utf-8?B?M1JtTjRzOFVrbWZjaWt5YlFIVlV0bHdSaU42eVNyNjN5MjIzNzR6UWZpb2NO?=
 =?utf-8?B?MUhPcXE4VSs0NkhiNm92QmhWK2tOUGhhUkVRY1NpUjRQWUpjaTNiQjgvWitq?=
 =?utf-8?B?dVhjcmIzUDFKbmtHYTNIREMwUnFSMTVudmc5WWhoMmZxYmF4VUJ3cldIajhE?=
 =?utf-8?B?MGsvelphWnpKSExFd3RIdGNIMkI2aHlHUGZsd1Jja0ovZ2JBcmpCaUxiUU90?=
 =?utf-8?B?bUVKZlY1ODhGbFRZRkkwWW5XalJGM1JZa3dTaXMwV3R6UkUrY3FpY2N6d040?=
 =?utf-8?B?a09zQXFQa0R1Z3dULzZDZjdFYjRnRTFGazFaV3lTQUZDODZ5S0MyNFNZR0tu?=
 =?utf-8?B?YTlnM1J2QkMrMTVXcWhmVmhxQlpyWUpZa0lBUGxUVlhGWTJIZ1pVVVh4WGho?=
 =?utf-8?B?SHVuNzcwdUU0bURCaHJmN1VWMDBSU1dFMFAvNTlmQStPUkFLWDRjeG9Oc2Jx?=
 =?utf-8?B?aGorMDRsZHFlbk1mQkJYV2F4eTIrdDVFR2dWanJuSUNkTzdlWFA1eVZNSE9w?=
 =?utf-8?B?UEV0b05tWE5MQ3VzeHFtQ0YvNEhaMThhclVFSk9ZUGg3bHFiRVJFUHczMExM?=
 =?utf-8?B?dSswclptV3NLU214UElHeCtuRCtOYm5sZ1VlREhlSnB2VTliSGJPeW9DemJ6?=
 =?utf-8?B?MTN2UUZ0dFZzS0VzbHhmNGZtL2ZBay84RDdjQkhFeTA0K0xOT2tKTW03MXls?=
 =?utf-8?B?YTkvOW8yaHZ5K2hnVWZmcU9YeGh5ckFKM1F1dndLWHNMdmFMd0VBVzAzeXg5?=
 =?utf-8?B?ZWhoeU1uVVRUZ2dmL3VoK1VVRnIxR0VHL1BiMjZFYUx6Vkl4MWgvSTMvdTFK?=
 =?utf-8?B?aUNTNGZ6WkZEVzlsdmtCdk1QOS9VU1Q2QTc4SzJ1Y296ci9ScldtSEdLN2Jr?=
 =?utf-8?B?YkJFU2RtNGlVZFo4eFl6bFZEeWdERlQxQWxKczg4SmVOTXloTy9CYjVhcHhu?=
 =?utf-8?B?QXJRc3ByWWFJL2NCNmFPRFdxenZYc0d2YTFzNGtSVzR6MDZWRC9lWCtNaThW?=
 =?utf-8?Q?TjPYd60B8cShJLQ0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE10015297901A478FD6C6164D75686D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: grEtCXZClRK7gYxrLC3PoBgT9RtsNOM8J3O2/FaQqgminfMzE3lH7jarig4N3QCbeZNOXJusXkaMuLElxj51MwSACsYlCrjKgmB5GrJ4+0LSfqJEjK6f1hEKOQKG+eY/6qSWOHgeJ452HpOk63MErbPJZL4xE5aHkHkhtcFEvSkrD/+ylHHfBnryB0B3ovr3RTyX1O1EPoYlrs++DzG9OT2srFsRH2sAqIPOWbT0cBqiAwnxlqXERpFl3ZP8KcLHQWCVBbtQkxc8s6QQlZINCGvY3UPpIqprHrfFTD28kJM5E+FCmD6eBycT80I7opbc+YxMVcmMwodQW0q9c95LWg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7494.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e254bf45-6dcb-4251-3d4e-08deecdcba36
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2026 19:16:29.3862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sGX9ILuj3X1WPksJFRGTsHl3ko7gwirUnZLjTgkczuKwK7pApw7BZPdaWxeaRykLtB4cE4Lq56Le9bt2p8WvHkJIZDjcZz0cGMVP75/MAdk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF2AD6B04BA
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA3LTI4IGF0IDE0OjExIC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBPbiBUdWUsIEp1bCAyOCwgMjAyNiBhdCAwNjoyMToyM1BNICswMDAwLCBHcnVtYmFjaCwgRW1t
YW51ZWwgd3JvdGU6DQo+ID4gT24gVHVlLCAyMDI2LTA3LTI4IGF0IDEzOjAzIC0wNTAwLCBCam9y
biBIZWxnYWFzIHdyb3RlOg0KPiA+ID4gT24gVGh1LCBKdWwgMjMsIDIwMjYgYXQgMTE6MzU6NDFB
TSArMDAwMCwgR3J1bWJhY2gsIEVtbWFudWVsDQo+ID4gPiB3cm90ZToNCj4gPiA+ID4gT24gVGh1
LCAyMDI2LTA3LTIzIGF0IDE1OjE5ICswNTMwLCBNYW5pa2FudGEgTWFkZGlyZWRkeSB3cm90ZToN
Cj4gPiA+ID4gPiBPbiAyMi8wNy8yNiAxMDozNCBwbSwgQmpvcm4gSGVsZ2FhcyB3cm90ZToNCj4g
PiA+ID4gPiA+ID4gVGhlIHByb2JsZW0gd2FzIHRoYXQgd2UgZGlkbid0IHNob3cgdXAgYXQgYWxs
IGluIHRoZQ0KPiA+ID4gPiA+ID4gPiBlbnVtZXJhdGlvbi4NCj4gPiA+ID4gPiA+ID4gV2UNCj4g
PiA+ID4gPiA+ID4gc2VuZCBhIG1hbGZvcm1lZCBUTFAuIEknbSBub3QgcXVpdGUgYW4gZXhwZXJ0
IGF0IHRoaXMsDQo+ID4gPiA+ID4gPiA+IGJ1dA0KPiA+ID4gPiA+ID4gPiBvdXINCj4gPiA+ID4g
PiA+ID4gUENJZQ0KPiA+ID4gPiA+ID4gPiBleHBlcnRzIHJ1biBhIFBDSSBhbmFseXplciBvbiB0
aGUgZW51bWVyYXRpb24gb24gdGhhdA0KPiA+ID4gPiA+ID4gPiBzcGVjaWZpYw0KPiA+ID4gPiA+
ID4gPiBwbGF0Zm9ybSBhbmQgdGhleSBzYXcgdGhhdCBwbGF0Zm9ybSdzIFBDSSBjb250cm9sbGVy
IHNldHMNCj4gPiA+ID4gPiA+ID4gdGhlDQo+ID4gPiA+ID4gPiA+IE5vU25vb3AgYW5kIFJlbGF4
ZWQgb3JkZXJpbmcgYml0IGluIHRoZSBUTFAuIEFjY29yZGluZyB0bw0KPiA+ID4gPiA+ID4gPiB0
aGUNCj4gPiA+ID4gPiA+ID4gc3BlYw0KPiA+ID4gPiA+ID4gPiAod2hpY2ggSSBpZ25vcmUpLCB0
aGUgQkUyMDAgaXMgc3VwcG9zZWQgdG8gcmV0dXJuIHRoZSBUTFANCj4gPiA+ID4gPiA+ID4gYXMN
Cj4gPiA+ID4gPiA+ID4gcmVjZWl2ZWQsIGJ1dCB3ZSByZXBseSB3aXRoIDAgQXR0cmlidXRlcyBh
bmQgdGhlDQo+ID4gPiA+ID4gPiA+IGVudW1lcmF0aW9uDQo+ID4gPiA+ID4gPiA+IGRvZXNuJ3QN
Cj4gPiA+ID4gPiA+ID4gY29tcGxldGUgc3VjY2Vzc2Z1bGx5Lg0KPiA+ID4gPiA+ID4gSSdtIGN1
cmlvdXMgYWJvdXQgdGhlIGRldGFpbHMgb2YgdGhpcyBlbnVtZXJhdGlvbiBmYWlsdXJlLsKgDQo+
ID4gPiA+ID4gPiBEbw0KPiA+ID4gPiA+ID4geW91DQo+ID4gPiA+ID4gPiBrbm93IHdoaWNoIFRM
UHMgaGFkIE5vIFNub29wIGFuZCBSZWxheGVkIE9yZGVyaW5nIHNldD/CoCBQZXINCj4gPiA+ID4g
PiA+IHRoZQ0KPiA+ID4gPiA+ID4gUENJZQ0KPiA+ID4gPiA+ID4gc3BlYywgdGhleSBzaG91bGRu
J3QgYmUgc2V0IGZvciB0aGUgY29uZmlnIHJlcXVlc3RzIHVzZWQNCj4gPiA+ID4gPiA+IGZvcg0K
PiA+ID4gPiA+ID4gUENJDQo+ID4gPiA+ID4gPiBjb3JlDQo+ID4gPiA+ID4gPiBlbnVtZXJhdGlv
bi4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gQXQgbGVhc3Qqc29tZSogY29uZmlnIHJlYWRz
IHRvIHRoZSBCRTIwMCBtdXN0IHdvcms7DQo+ID4gPiA+ID4gPiBvdGhlcndpc2UsDQo+ID4gPiA+
ID4gPiB3ZQ0KPiA+ID4gPiA+ID4gd291bGRuJ3Qga25vdyB0aGUgVmVuZG9yIG9yIERldmljZSBJ
RCwgd2hpY2ggd2UgbmVlZCB0bw0KPiA+ID4gPiA+ID4gYXBwbHkNCj4gPiA+ID4gPiA+IHRoZQ0K
PiA+ID4gPiA+ID4gcXVpcmsuwqAgU28gSSB0aGluayB5b3Ugc2hvdWxkIHNlZSBzb21ldGhpbmcg
bGlrZSB0aGlzIGluDQo+ID4gPiA+ID4gPiBkbWVzZywNCj4gPiA+ID4gPiA+IGFuZA0KPiA+ID4g
PiA+ID4gQkUyMDAgd291bGQgcHJvYmFibHkgYXBwZWFyIGluIGxzcGNpIG91dHB1dDoNCj4gPiA+
ID4gPiA+IA0KPiA+ID4gPiA+ID4gwqDCoCBwY2kgMDAwMDowNDowMC4wOiBbODA4NjoyNzJiXSB0
eXBlIDAwIGNsYXNzIC4uLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBJcyB0aGUgZmFpbHVy
ZSB0aGF0IGl3bF9wY2lfcHJvYmUoKSBpdHNlbGYgZmFpbHMgc29tZWhvdz8NCj4gPiA+ID4gPiA+
IA0KPiA+ID4gPiA+ID4gWW91IG1lbnRpb25lZCB0aGF0IHRoaXMgaGFwcGVucyBvbiBKZXRzb24g
VGhvciwgYnV0IEknbSBub3QNCj4gPiA+ID4gPiA+IHN1cmUNCj4gPiA+ID4gPiA+IHdoYXQgUENJ
ZSBjb250cm9sbGVyIHRoYXQgaXMuwqAgTXkgZ3Vlc3MgaXMgaXQgbWlnaHQgYmUNCj4gPiA+ID4g
PiA+IFRlZ3JhMjY0DQo+ID4gPiA+ID4gPiBbMV0sIHdoaWNoIGRvZXNuJ3QgbG9vayBsaWtlIGl0
J3MgbWVyZ2VkIHlldC4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gVGhpZXJyeSwgTWFuaWth
bnRhLCBkbyB5b3UgaGF2ZSBhbnkgaW5zaWdodCBpbnRvIHRoaXM/wqANCj4gPiA+ID4gPiA+IERv
ZXMNCj4gPiA+ID4gPiA+IHRoaXMgUENJZSBjb250cm9sbGVyIHNldCBObyBTbm9vcCBhbmQgUmVs
YXhlZCBPcmRlcmluZyBmb3INCj4gPiA+ID4gPiA+IHNvbWUNCj4gPiA+ID4gPiA+IHJlYXNvbj/C
oCBJIGRvbid0IHRoaW5rIGVuZHBvaW50IGRyaXZlcnMgYXJlIGV4cGVjdGluZyB0aGF0Lg0KPiA+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBbMV0NCj4gPiA+ID4gPiA+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xpbnV4LXBjaS8yMDI2MDcxNi10ZWdyYTI2NC1wY2llLSANCj4gPiA+ID4gPiA+IHY4
LTAtMjNlNTE1ODkyMjliQG52aWRpYS5jb20vDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gSGksDQo+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gSmV0c29uIFRob3IoVGVncmEyNjQpIGlzIG5vdCBzZXR0aW5n
IE5vU25vb3AgYW5kIFJseGRPcmQgYml0cw0KPiA+ID4gPiA+IGluDQo+ID4gPiA+ID4gY29uZmln
IA0KPiA+ID4gPiA+IHJlYWQgVExQLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEkgbWFkZSBzdXJl
IHRoYXQgYm90aCB0aGVzZSBiaXRzIGFyZSBzZXQgaW4gUlAncyBEZXZDdGwNCj4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBEZXZDdGw6IENvcnJF
cnIrIE5vbkZhdGFsRXJyKyBGYXRhbEVycisNCj4gPiA+ID4gPiBVbnN1cFJlcSsNCj4gPiA+ID4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUmx4ZE9y
ZCsgRXh0VGFnKyBQaGFudEZ1bmMtIEF1eFB3ci0NCj4gPiA+ID4gPiBOb1Nub29wKw0KPiA+ID4g
PiA+IA0KPiA+ID4gPiA+IGFuZCBkdW1wZWQgVExQIGhlYWRlciBmb3IgYSBjb25maWcgcmVhZCB0
b3dhcmRzIEJERiAweDEwMA0KPiA+ID4gPiA+IHdpdGgNCj4gPiA+ID4gPiBvZmZzZXQNCj4gPiA+
ID4gPiAweDI0Lg0KPiA+ID4gPiA+IMKgwqDCoCAweDA0MDAwMDAxwqDCoMKgwqDCoCAweDAwMDAw
MDBmwqDCoMKgwqDCoCAweDAxMDAwMDI0wqDCoMKgwqDCoA0KPiA+ID4gPiA+IDB4MDAwMDAwMDAN
Cj4gPiA+ID4gPiANCj4gPiA+ID4gPiBJIHRoaW5rIGRtZXNnIGFuZCBBRVIgbG9nIHdpdGggaGVh
ZGVyIGluZm9ybWF0aW9uIG1pZ2h0IGhlbHANCj4gPiA+ID4gPiB3aXRoDQo+ID4gPiA+ID4gdGhp
cyANCj4gPiA+ID4gPiBwYXJ0aWN1bGFyIGlzc3VlLg0KPiA+ID4gPiANCj4gPiA+ID4gT2ssIHNv
IEkgY2hlY2tlZCBhZ2FpbiB0aGUgbG9ncyBhbmQgSSB3YXMgd3JvbmcuDQo+ID4gPiA+IFdlIGRv
IHNlZSB0aGUgZGV2aWNlIGluIHRoZSBlbnVtZXJhdGlvbiwgaXQgZG9lcyBzaG93IHVwIGluDQo+
ID4gPiA+IGxzcGNpLg0KPiA+ID4gPiBQcm9ibGVtcyBzdGFydCB3aGVuIHdlIHdhbnQgdG8gYWNj
ZXNzIG91ciByZWdpc3RlcnMuDQo+ID4gPiA+IEkgYXR0YWNoZWQgdGhlIGZ1bGwgZG1lc2cgb3V0
cHV0LiBJbiB0aGF0IGxvZyB3ZSB0cnkgdG8gbG9hZA0KPiA+ID4gPiBpd2x3aWZpDQo+ID4gPiA+
IHR3aWNlLg0KPiA+ID4gPiANCj4gPiA+ID4gSSdtIGFkZGluZyBoZXJlIHRoZSBzbmlwcGV0IG9m
IHRoZSBmaXJzdCBsb2FkOg0KPiA+ID4gPiANCj4gPiA+ID4gW8KgwqAgMTUuMjc1ODg3XSBpd2x3
aWZpIDAwMDE6MDE6MDAuMDogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDUzDQo+ID4gPiA+IFvCoMKg
IDE1LjI3OTczN10gaXdsd2lmaSAwMDAxOjAxOjAwLjA6IGVuYWJsaW5nIGRldmljZSAoMDEwMCAt
Pg0KPiA+ID4gPiAwMTAyKQ0KPiA+ID4gPiBbwqDCoCAxNS4yODAwNDddIGl3bHdpZmkgMDAwMTow
MTowMC4wOiBIV19SRVY9MHhGRkZGRkZGRiwgUENJDQo+ID4gPiA+IGlzc3Vlcz/CoCBcXCAqKg0K
PiA+ID4gDQo+ID4gPiBUaGUgImVuYWJsaW5nIGRldmljZSIgbWVzc2FnZSBpcyBmcm9tIHBjaV9l
bmFibGVfcmVzb3VyY2VzKCksDQo+ID4gPiBjYWxsZWQNCj4gPiA+IGluIHRoZSBwY2lfZW5hYmxl
X2RldmljZSgpIHBhdGguwqAgVGhlIDAxMDAgaXMgZnJvbSBhIGNvbmZpZyByZWFkDQo+ID4gPiBv
Zg0KPiA+ID4gUENJX0NPTU1BTkQsIGFuZCB0aGUgMDEwMiBpcyBmcm9tIGFkZGluZyBQQ0lfQ09N
TUFORF9NRU1PUlkgdG8NCj4gPiA+IGVuYWJsZQ0KPiA+ID4gbWVtb3J5IEJBUnMuDQo+ID4gPiAN
Cj4gPiA+IFRoZSAiSFdfUkVWPSIgaXMgZnJvbSBpd2xfcGNpX3Byb2JlKCksIHdoaWNoIGxvb2tz
IGxpa2UgdGhlIHZlcnkNCj4gPiA+IGZpcnN0DQo+ID4gPiBNTUlPIHJlYWQgdG8gYSBCRTIwMCBC
QVIuDQo+ID4gDQo+ID4gSW5kZWVkDQo+ID4gDQo+ID4gPiBTbyBJIGd1ZXNzIHRoZSB0aGVvcnkg
aXMgdGhhdCBUZWdyYTI2NCBzZXQgTm9Tbm9vcCBhbmQvb3IgUmx4ZE9yZA0KPiA+ID4gaW4NCj4g
PiA+IHRoZSBNTUlPIHJlYWQsIEJFMjAwIGRpZG4ndCBjb3B5IHRoZSBhdHRyaWJ1dGVzIGZyb20g
dGhlIFJlcXVlc3QNCj4gPiA+IHRvDQo+ID4gPiB0aGUgQ29tcGxldGlvbiBhcyByZXF1aXJlZCBi
eSBQQ0llIHI3LjAsIHNlYyAyLjIuOS4xLCBhbmQNCj4gPiA+IFRlZ3JhMjY0DQo+ID4gPiBsb2dn
ZWQgYSBNYWxmb3JtZWQgVExQPw0KPiA+IA0KPiA+IFRoYXQncyB0aGUgYXNzdW1wdGlvbiBiYXNl
ZCBvbiB0aGUgQUVSIGxvZywgeWVzLg0KPiA+IA0KPiA+ID4gQUZBSUNTIHdlIHN0aWxsIGRvbid0
IGtub3cgd2h5IFRlZ3JhMjY0IHdvdWxkIHNldCBOb1Nub29wIGFuZC9vcg0KPiA+ID4gUmx4ZE9y
ZCBpbiB0aGUgTU1JTyByZWFkLg0KPiA+IA0KPiA+IE1lIG5laXRoZXIgYnV0Li4uIEkgY2FuJ3Qg
Y29tbWVudCBvbiB0aGF0LiBBbmQgZGUtZmFjdG8sIG9uY2UgaXQNCj4gPiBkb2VzDQo+ID4gdGhh
dCwgdGhlIEJFMjAwIHJlcGxpZXMgd2l0aCB0aGUgTm9Tbm9vcCBhbmQgUmx4T3JkIGNsZWFyIGlu
IHRoZQ0KPiA+IFRMUA0KPiA+IHdoaWNoIGlzIHRoZW4gY29uc2lkZXJlZCBhcyBhIG1hbGZvcm1l
ZCBUTFAuDQo+ID4gDQo+ID4gPiBVbmxlc3MgaXdsd2lmaSBhc2tlZCBmb3IgTm9Tbm9vcCBhbmQv
b3IgUmx4ZE9yZCB0byBiZSBzZXQsIEkNCj4gPiA+IHRoaW5rDQo+ID4gPiBpdCdzIGEgcG90ZW50
aWFsIHByb2JsZW0gZm9yIGRyaXZlcnMgaWYgVGVncmEyNjQgc2V0cyB0aGVtLg0KPiA+IA0KPiA+
IEkgLi4uIGRvbid0IHRoaW5rIHdlIHdvdWxkIGRvIHRoYXQuIFRoZSBkcml2ZXIgd291bGQgY2Vy
dGFpbmx5IG5vdA0KPiA+IGRvDQo+ID4gdGhhdC4uLiBSZWdhcmRpbmcgdGhlIGhhcmR3YXJlIGl0
c2VsZiwgSSBjYW4ndCBjb21tZW50LCBidXQgSSBjYW4NCj4gPiBjaGVjaw0KPiA+IGludGVybmFs
bHkuDQo+IA0KPiBSaWdodCwgSSBkb24ndCBzZWUgYW55IG1lbnRpb24gb2YgUENJX0VYUF9ERVZD
VExfUkVMQVhfRU4gb3INCj4gUENJX0VYUF9ERVZDVExfTk9TTk9PUF9FTiBvciBldmVuIFBDSV9F
WFBfREVWQ1RMIHRoZXJlLsKgIEFuZCBpdCB3b3VsZA0KPiBoYXZlIHRvIGJlIHNldCBpbiB0aGUg
Um9vdCBQb3J0IGZvciBpdCB0byBhZmZlY3QgdGhlIE1NSU8gcmVhZA0KPiByZXF1ZXN0LCBub3Qg
aW4gQkUyMDAuwqAgVGhhdCB3b3VsZCBhZmZlY3QgZXZlcnl0aGluZyB1bmRlciB0aGUgUlAsIHNv
DQo+IEkgdGhpbmsgdGhlc2UgYXJlIHByb2JhYmx5IG1vc3QgdXNlZnVsIGluIHRoZSBETUEgZGly
ZWN0aW9uIHdoZXJlIGFuDQo+IGluZGl2aWR1YWwgZGV2aWNlIGNhbiBjb250cm9sIGl0cyBvd24g
UmVxdWVzdHMuDQo+IA0KPiBCdXQgdGhlIGFuYWx5emVyIHNhdyB0aGVtIHNldCBpbiB0aGUgcmVx
dWVzdCBmcm9tIHRoZSBSb290IFBvcnQsIHNvDQo+IGl0J3Mgc3RpbGwgYSBteXN0ZXJ5IHdoeSB3
aGF0IGhhcHBlbmVkLg0KDQpPci4uLiAgVGVncmEyNjQgc2ltcGx5IHNldHMgdGhlbSBmb3IgYW4g
dW5jbGVhciByZWFzb24/DQoNCk5vdGUgdGhhdCBvdXIgcHJldmlvdXMgZGV2aWNlIChBWDIxMCkg
ZG9lc24ndCBoYXZlIHRoZSBidWcsIGl0IHNldHMgdGhlDQpiaXRzIGluIHRoZSBUTFAgYXMgZXhw
ZWN0ZWQgYW5kIGl0IHdvcmtzIHdpdGggVGVncmEyNjQuDQpJIGhhdmUgdG8gYWRtaXQgdGhhdCBh
dCB0aGlzIHBvaW50LCBJIGRvbid0IHJlYWxseSBrbm93IHdoYXQgdG8gZG8uIFRoZQ0KcXVpcmsg
dGhhdCBJIGFtIHN1Z2dlc3RpbmcgZml4ZWQgdGhlIGJ1ZyBmb3IgdXMuIEkganVzdCB3b25kZXIg
d2hhdA0KZWxzZSBpcyBuZWVkZWQgdG8gdGFrZSB0aGUgZGVjaXNpb24gd2hldGhlciB0byB0YWtl
IGl0IG9yIG5vdC4NCg==
