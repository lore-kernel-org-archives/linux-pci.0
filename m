Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC4C470103
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 15:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785859085; cv=fail; b=t0vdogQj/YSu/GaDZtWRk+S4a6ezDTizt63+3Et/IvozeGEW2V7c3qsJEl4mamwhyb0EDwq8MZcokqMNs48iX60i+SB4iryTyb5CyzxpqDFkf1ip/aJIC4RbhHanDL0O1ljGFZ++enLb6qX46rec+y+GiACqXnPnNF3c+V8Tx4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785859085; c=relaxed/simple;
	bh=lAMbc03m/VN6qPW4PlG1z1p8hOsqh8W6j9zF+iwcehs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AXfPFD6btONidQ7DKPClCY+pJSsHl5+hgcrjTnwOUoDywXpwMq8TrIEB6xjJ+M6bpd5mQpBEXZd5ardIFfkb0gdHURXl4w1omD3lPD90MYfrB47hG1x8abdqAKk9xUs9FCSyN2UBjeFfqr57jVUahlWScPKE4aJOHaW05t17Sk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GYR0lL4d; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GYR0lL4d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785859082; x=1817395082;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lAMbc03m/VN6qPW4PlG1z1p8hOsqh8W6j9zF+iwcehs=;
  b=GYR0lL4dxYF2prkTTig8zqyoOfr4ymfrG27mbVaTZ6588cQS2UMRjm/c
   JDoAhvkAbP4Z0gEil2Je7Idnl2dOUMBBRkPtsKTKtWB7dXCT0+HKA4OJZ
   YwMmlH/juQ/5bgvw4KwCzweBulh38nWScckw06QDLrbeabHHmsvRZb6Oy
   hSBF6Hlq1nG8yd6+szr5l610o+nqhRUtdEB0RcYbesD7HrlJw2cU3X6KD
   9KWY7FUP8s2Cj2Bm03tpUJytgViWjw41NOjpzC7cbCyiy1ZGhHKau30pc
   Qy7nt+XgHN4rGQZw0cjUDCQK5u7kUC/fZJgAgkqETeBV/1mCKzuqU7Ssz
   g==;
X-CSE-ConnectionGUID: +m8nkhUdSzm2lT5GJ82CYg==
X-CSE-MsgGUID: Gya0Uo0eT4uk4kEUJw6ECA==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="111966182"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="111966182"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 08:58:00 -0700
X-CSE-ConnectionGUID: ly0QgdCTQJu2pFzfDi6a1w==
X-CSE-MsgGUID: 2O0JnXUpQBSDNTMMFShdHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="291482762"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 08:57:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 08:57:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 4 Aug 2026 08:57:59 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.53) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 08:57:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RcEDYMMF8KJapnLOE3xk6AfaHXr7KGXcpYVNvYubsdNu0lDdLzThgkMZyA2OCcal4kCcsShIXX2IVQ4Nhjv7742Ug3DpYVAV0kQIgLhyi2Rz5FyC9u97scf2IL/oRIZkQRQ3qvm+R/lBx18CkGILtzfPabcXGuDZQC0h/zME8vsGyOzUEV6jCl1SAjdjZj875vLyiu8Jm8sBoQJ2DHx+lF3QCIfLuGAyjHGMnI3ZhKbw9D887j2ZQ+RoB0kfsZCtaO5XFVYljhaFH83Vt6YfApqvEoCOQQ8ZNsYFrJTOgc5e8ERl3mqgPgD/X2GTuYMe0/SHTxCSJ1xyWVLCOwoBCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAMbc03m/VN6qPW4PlG1z1p8hOsqh8W6j9zF+iwcehs=;
 b=v+WM+ePvqUn8AJP8K4pekfK/zz22ZLeIf5+mZouPp9YvTlXNe5zw7QgxqjPrtRiqZpOyb6HnHK2jZRYAZiM7znVtHQVlob/yGesYQSGcDZIvbfzH/FZW8VXNpm1z0WRRuhVAW8rT0KJ9UnIr2+WNCDD1RPAcMCIUq5W4DLRRP3WEkCCYFtU4jUuNq3aZV7vPz7G+r9Nh8M6R7dKOg+oUfPsKl6byP7sXWT8dK7xBKvbnRwRqw+UXu4YRDLiLdfeFp0OrFft9mSaV0s2DvYftDsrM7SyF+ae37gUOg+fRIbtVQTN69zWT3y1f/0vcNgHHQYeFFon61YIyAMw5sci0pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7494.namprd11.prod.outlook.com (2603:10b6:510:283::18)
 by CH3PR11MB8545.namprd11.prod.outlook.com (2603:10b6:610:1bc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 15:57:52 +0000
Received: from PH0PR11MB7494.namprd11.prod.outlook.com
 ([fe80::e642:c73c:6d80:5083]) by PH0PR11MB7494.namprd11.prod.outlook.com
 ([fe80::e642:c73c:6d80:5083%5]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 15:57:51 +0000
From: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To: "helgaas@kernel.org" <helgaas@kernel.org>
CC: "thierry.reding@kernel.org" <thierry.reding@kernel.org>,
	"mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>, "lukas@wunner.de"
	<lukas@wunner.de>, "sashiko-reviews@lists.linux.dev"
	<sashiko-reviews@lists.linux.dev>, "Korenblit, Miriam Rachel"
	<miriam.rachel.korenblit@intel.com>, "treding@nvidia.com"
	<treding@nvidia.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: Disable NoSnoop and Relaxed ordering for Intel
 wireless BE200
Thread-Topic: [PATCH] PCI: Disable NoSnoop and Relaxed ordering for Intel
 wireless BE200
Thread-Index: AQHdAUruh/HWEZwEC0iMA6tK8iUSn7ZImB0AgAAE6oCAMTTxAIAABOIAgAAe6wCAARjQAIAAHZOAgAhH+4CAAAUPAIAAEYwAgAAGZYCAAAi/gIAAsEyAgAFxSwCAANOCgIAAFZ0AgAAXJoCAAAJLAIABQL+AgAZSnQA=
Date: Tue, 4 Aug 2026 15:57:51 +0000
Message-ID: <6c067883cd68a835a4ab5432e2b509b3686257b5.camel@intel.com>
References: <20260731152431.GA1566014@bhelgaas>
In-Reply-To: <20260731152431.GA1566014@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.60.2 (3.60.2-1.fc44) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7494:EE_|CH3PR11MB8545:EE_
x-ms-office365-filtering-correlation-id: c1ac4dc2-2c0f-46ed-01ec-08def2412396
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|18002099003|22082099003|11063799006|38070700021|6133799003|10067099003|56012099006;
x-microsoft-antispam-message-info: /J4j4nJmXBSacDIqjbXKryEZwV7ndi1ILb/e4dK6yggA5M1VWeKUKBon1iotcZlWjsMPcPoS5Rnk+4iHRAGgtOTKm9xIH7aYA3f3VAFdF0gnTOinqYp9XCgEgw+kbGfdrwUW7Cds5kXIfb4RlOTnEi779ecIkNdjU0kbyqgg0/Dft18Y9lk0aZNxr/8PStXq76wx7gcsZWg0je8BIeFv28gycLeXR9tcmDUC8ZWGsZQE7g8B6xb9S/pEX1NJOixYO6iO9VafWXUAwtiEMIGlPVOjxg/1TjYTE/qhpyh8EgJTvuC3qdH0Gzg15LkCAZhDuxGmhIKi+FNmTj+2eBYjJEwE3qWgbH1GD0zSs6ya8z6i0pq7UpSAbLUGCkCMTwrARfJpbJ+VKYSLFRNrQAS7LBo89vi6Sm2SRGTWICLr2CE5kgdXf3tkp8nRTlycDVobxLJAbJ6eMii5VaeoQNJUp8xgTjQJgcYJ/qiPcYVBrp4I6DC0tffHoddrSodEEoX8KfnQKnoztdwr8O4W7zW1kU9lxCsrOcH3z0nvM+eKMfmTZKwp2vowTvbAiA1A2A/L+mfRd/LkUwhrz+JQy/jMF1ZwDmNzNp/T+Uxi6foxw+ItLYSH+TtTw+2erNWmhHaqelqVDok/Gr4tjiNliA+CtElFSrB7KIBVrM/4pTmlY5lvVhgu4PSXTWdqLo3NGpCpEiWMMKUOAmn+y6B1jL+WV15Z59N1lMobtu3nvSenS0E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7494.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(38070700021)(6133799003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmhwblZHQXZQekVxcHBieTF4azVTdWtIK2NQU3lod01lWUpOdzdreWI5dlE4?=
 =?utf-8?B?aTB5dlZEZTVjUDIzQkdaTlV5eUx0M3NPUTZmTllSZGhxVkJaMmVqenN3RzBG?=
 =?utf-8?B?MkpPdkhDNHM5Nk90M0ZibEFiZE80cCs2Y0dUbzFUQ1FPV0tGa0QrdStFbU5D?=
 =?utf-8?B?Y0t5bVFvR1prck15MS9YcS85V0RiN0ZEVVdwaFhWUnlZZW5lT1RRa094dGlQ?=
 =?utf-8?B?S2JqeXI1YTFVNERBM3ZRY0JNeTJtQ3NVUEVtQ2oxTlgvTU0wQmF3MW8yM0cv?=
 =?utf-8?B?SHFOYVgrR1ZCOS9lQ0NKU2VyZWNHNkozVllOa3pPUk5FQjFKVnhjQ0x3a1RD?=
 =?utf-8?B?V1JObzFKRjBnL0RxR1FGaFBkRExZQVEvdXdSSUdSdFZTWnhEWHdQT2luS3Zw?=
 =?utf-8?B?TjJzTmRaQ2hiMHRvbnRCc015OGpzbzhscFV4bGhKWnIrRDlNTFBmc3Z6Q0J3?=
 =?utf-8?B?amY3eFNpU1BkSUVLOW5IalZxRG1BUWZHTTg2bFVQQitKNDZaVWtGbzlGMlFn?=
 =?utf-8?B?NjQ4bW9CbFozdno2UzhXUGMyM0RtTGF2Mm5IdHZpQnlwRGEyYVJiVDNIZ0Uw?=
 =?utf-8?B?VHgwSXRHTFkvVFlSNkRJQkNQK08wUFNON3RRbnZUZ1VvcEpvOXdCTjFzWVFS?=
 =?utf-8?B?aUpQUkMrN3h0ZzI3dW9EejBhd0VESE9YakRKQklrQlU0VlBnTXhXZDk0M3dV?=
 =?utf-8?B?NnorZDR3V2dMZnlLTnpOQ0RMZXdESUZ3NHh6UTNhQ1FGMVc4Um1sbUxjcHBv?=
 =?utf-8?B?cEkrZDd3QzNra0NTNUFNazBBaCtnR25qVm1pa0pyelpweUlIc3B6M2Vwak90?=
 =?utf-8?B?YTFETFhOd2VLQ1RSODBOenl0NmJWdkg0amxwVXF4ekJ1Z2lPako4NXVKNlVz?=
 =?utf-8?B?aUNaQ0hwQmcvZG9PTUsvZXRSeXVRVkpUZlRGajc0Q08yS3poVko0WUllVlJq?=
 =?utf-8?B?RTJ6VG9JK1JSR2dKOE9LTjA4ZmIwcTZWdkFQT2V0ZStvU3BZd3hxZmk0aVRX?=
 =?utf-8?B?ZHdOd2xLMmQrS013djJWOHFLd1RaUlhHVXdFRXZxOUszdmhqdUdMQlpyVXFw?=
 =?utf-8?B?WW9zVnF3Nnd3QUxmWTJDeEdWK2lDS29XQXk2cEFUSm9qTEl4bHB0V2U3SXJ3?=
 =?utf-8?B?S0ZzM2V3aGN2azkxcUxQbGs1MVIxWFhSR3dBOUJ0LzdMT2UrZFZ3MjhIbFB3?=
 =?utf-8?B?eVZweDR3Y1M4U2xKYjVwREQ5T0wvTW9mYmFHVjl6U0pxcHRxSktiRzdwNHlZ?=
 =?utf-8?B?VDhldlpZNnRCWnVXUWI5UEkyeDkzaitWQXdlVDNXT3VEMzFmeE5SclhEL3NU?=
 =?utf-8?B?MUFWam5Ja0FMTDY5YWFhTjVJcDMyVjA0dU1neXdSZTlINU5Ub1dhMEFrQUNp?=
 =?utf-8?B?SFlta3IxNkpQRnh5MElSRVNubFNGR3FOaTdEQnhvKzZrcDlsSWRTSVJDaGJI?=
 =?utf-8?B?d2pFOVpoVW1qY2JkblV5Z1dmcnZaOW5pUXpPZFlZRFBtQU05K1VVblZzTFVF?=
 =?utf-8?B?Y3JaZmo0Q2dIVVhMMzUwQ2pTZzBVQnRkTzdISlY0RmZQTG9lVzdjL0ZEOFA3?=
 =?utf-8?B?SDJiNExkRW9rcW1vcmd6SlhrK2FSdlhsMUd6Y3ZneDVGNHJpZXVzc3VHOFg4?=
 =?utf-8?B?OUFNWXFNUXVMcTk3dzJlV2RrVzhZajZnNnpUeFNYSXphVnNRRnUwQjNnQlpK?=
 =?utf-8?B?dm9ZTkFuSDR4eEpEV3lZaXE5TmRxK3VWWHBhYmEwV3dNUTZ5c05XTDNHV3Bw?=
 =?utf-8?B?QTFWQjJnWUdoeUJYSEpwMTFHRERDZzJZNHQ2ZHg2bzIxdks3bWxnWitkQlc3?=
 =?utf-8?B?N2Jwc2oyWElSVjBXb2hqTzdadFZ6ck9jN1NrY3p3YjhLS2NoRkI2VXEwSTRM?=
 =?utf-8?B?ZWUwWHo5UitmT3ZrbjJkWksvWStZWHA1ZURkblFjamVCeHpoYkJHRWw4MFph?=
 =?utf-8?B?MjlOMHlJZCthS3ZXL2d6eEp2TFl6T0hENTk4dTRvUEV2Q3ZzR25kL1FudkhW?=
 =?utf-8?B?VjE4aENPWmtaNjd4SDQ5OXA3cjJuWnVJRC9VSFdMTEJ3QnFFM1FTekFTSWwr?=
 =?utf-8?B?QkQzK1VPRTYvSTdrQVR5L0JyNjFZNDg1V1dpZDgyTy96NGo3R2ZkNE93UDlW?=
 =?utf-8?B?VWtUeFczSzd5cnYzNjVWMXVuQ3pUYk1Sd1JzS0Ewc05pTlVpZ3IyWE1sL25n?=
 =?utf-8?B?VmdrSXd4Q1dBTURlQ2tSYUlIVVBGNU1YMHQyL0MzRVRpaUN4cTVsZTF1VXdo?=
 =?utf-8?B?K21yMllCYTBDS0xRci9kV2U4YkUzN2VKREladFpkSkxMbEs0M0ZSVEwzekRJ?=
 =?utf-8?B?c01wUjJEVEtxdWh4MnpqU1R0Ry9xN29nZU45a2xqcVAzbWwwUTdMUTZBY3dq?=
 =?utf-8?Q?lVp9c8nTn5lgTgZ4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC91F2FBF25D374EA7EEBC17B1A3A65B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SrYAmfzTubVQml4NV2pfnx9R0yWey2nZ+GRqvEVQNrPR03mjRmLipHvljbtF4QVu9pSkpCkPMIa2af/QGqFvk1EjJYJ6aPaqIdlfoBykWEriz7jjhNEZX1EvBf45EBHh68AsR+RZpDquFLWiXEL3zmTbP1hS9XV7uDOk/JDMFiGestoGXPWd91tfFHw4qXnMrwblp6tYazXj5FF+HJWceklH4+NbkJ1o8pVw3YOPrE50C/Si3O4QNikuLMW48fZqGM0TtjlCuRm4LR6Uh7iFytXnp/uFfws8Hy6PPuSCMKWqRAnUMzBmeGuchFeyG5Uwd+soggKaTDa6mtRPG1TP/w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7494.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ac4dc2-2c0f-46ed-01ec-08def2412396
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2026 15:57:51.6900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e+SAdDkbq0brnUwc8DKSBN9XSrct3w2tfIEI+ER2/01Cc0PC7Udh0QjHb/ir1UVGjk/VVH07XgsxWhRkbDi6rnEeoASBEkcrwERGVMN2tCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8545
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA3LTMxIGF0IDEwOjI0IC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBPbiBUaHUsIEp1bCAzMCwgMjAyNiBhdCAwODoxNjozM1BNICswMDAwLCBHcnVtYmFjaCwgRW1t
YW51ZWwgd3JvdGU6DQo+ID4gT24gVGh1LCAyMDI2LTA3LTMwIGF0IDE1OjA4IC0wNTAwLCBCam9y
biBIZWxnYWFzIHdyb3RlOg0KPiA+IC4uLg0KPiANCj4gPiA+IEkgd29uZGVyIGlmIHRoZSBQQ0kg
Y29yZSBzaG91bGQgZGlzYWJsZSBSTyBhbmQgTm9Tbm9vcCBvbiBSb290DQo+ID4gPiBQb3J0cyBh
Y3Jvc3MgdGhlIGJvYXJkPw0KPiA+ID4gDQo+ID4gPiBJIHRoaW5rIHRoaXMgd291bGQgbWFpbmx5
IGFmZmVjdCBNTUlPIGFjY2Vzc2VzIHBlcmZvcm1lZCBieQ0KPiA+ID4gZHJpdmVycywgYW5kIEkg
c3VzcGVjdCBkcml2ZXJzIGV4cGVjdCB0aG9zZSB3cml0ZXMgdG8gYmUNCj4gPiA+IHBlcmZvcm1l
ZA0KPiA+ID4gaW4gb3JkZXIsIGUuZy4sIGlmIHRoZSBkcml2ZXIgd3JpdGVzIERNQSBkZXNjcmlw
dG9ycyB0byB0aGUNCj4gPiA+IGRldmljZQ0KPiA+ID4gZm9sbG93ZWQgYnkgYSB3cml0ZSB0byBh
IGRvb3JiZWxsLCB0aG9zZSBzaG91bGQgc3RheSBpbiBvcmRlci7CoA0KPiA+ID4gSWYNCj4gPiA+
IHRoZSBSUCBoYXMgUk8gZW5hYmxlZCwgdGhvc2Ugd3JpdGVzIG1heSBiZSByZW9yZGVyZWQuDQo+
ID4gDQo+ID4gQXMgYSBkZXZpY2Ugd3JpdGVyIEknZCBzYXkgd2UnZCBiZSByZXF1aXJlZCB0byBh
ZGQgYSBtZW1vcnkgYmFycmllcg0KPiA+IGluIHRoYXQgY2FzZSwgYnV0IHdlIHVzZSB3cml0ZWwg
dXN1YWxseS4NCj4gPiBEb2VzIHRoYXQgaW5jbHVkZSBhIHdyaXRlIHZzIHdyaXRlIG9yZGVyaW5n
PyBIbS4uLg0KPiANCj4gTm90IGJlaW5nIGFuIG9yZGVyaW5nIGV4cGVydCwgSSdtIG5vdCBzdXJl
IEkgY2FuIG1ha2UgYSBjb252aW5jaW5nDQo+IGFyZ3VtZW50IGZvciB3aGV0aGVyIFJPIHNob3Vs
ZCBiZSBlbmFibGVkIG9yIGRpc2FibGVkIGZvciBSb290IFBvcnRzLg0KPiANCj4gTWF5YmUgaXQn
cyBlYXNpZXIgdG8gYXJndWUgdGhhdCB3aGF0ZXZlciB0aGUgUk8gc2V0dGluZyBpcywgaXQgc2hv
dWxkDQo+IGJlIHRoZSBzYW1lIGFjcm9zcyBhbGwgcGxhdGZvcm1zIGJlY2F1c2UgZHJpdmVycyBz
aG91bGRuJ3QgaGF2ZSB0bw0KPiBhZGFwdCB0byBwbGF0Zm9ybSBkaWZmZXJlbmNlcy4NCg0KVGhh
dCdzIHBsYXlpbmcgc2FmZSwgd2hpY2ggaXMgbmV2ZXIgYSBiYWQgb3B0aW9uIGlmIHRoZSBwZXJm
b3JtYW5jZSBoaXQNCmlzIG5vdCBzaWduaWZpY2FudCwgYnV0IEkgY2FuJ3QgdGVsbCBJIGNhbiBj
bGFpbSB0aGF0IGhhdmUgYW55DQpleHBlcnRpc2UgaGVyZS4NCg0KPiANCj4gUm9vdCBQb3J0IHNl
dHRpbmdzIHBvdGVudGlhbGx5IGFmZmVjdCBzZXZlcmFsIGVuZHBvaW50cywgYW5kIEkgdGhpbmsN
Cj4gaXQNCj4gd291bGQgYmUgaW1wcmFjdGljYWwgZm9yIGRyaXZlcnMgdG8gcmVxdWVzdCBSTyBz
ZXR0aW5ncyB0aGF0IG1pZ2h0DQo+IGNvbmZsaWN0IHdpdGggZWFjaCBvdGhlci4NCj4gDQo+IERv
IHlvdSBoYXZlIGFueSB2aXNpYmlsaXR5IGludG8gd2hldGhlciBhbmQgaG93IG90aGVyIE9TZXMg
YWN0aXZlbHkNCj4gY29uZmlndXJlIFJvb3QgUG9ydCBSTyBhbmQgTm9Tbm9vcCBhY3Jvc3MgdGhl
IGJvYXJkLCBpbmRlcGVuZGVudCBvZg0KPiBpbmRpdmlkdWFsIGRyaXZlcnM/DQoNCkkgYXNrZWQg
aW50ZXJuYWxseSBhbmQgd2UgZG9uJ3QgcmVhbGx5IGtub3cgd2hhdCBXaW5kb3dzIGRvZXMgd2hl
biB0aGUNClBDSSByb290IHBvcnQgaGFzIHRob3NlIGJpdHMgc2V0cy4gV2UgbW9zdGx5IHRlc3Qg
d2l0aCBJbnRlbCAvIEFNRA0Kc3lzdGVtcyBhbmQgdGhvc2Ugc3lzdGVtcyBoYXZlIHRob3NlIGJp
dHMgY2xlYXIuDQoNCkJUVyAtIGNhbiB5b3UgcGxlYXNlIHBvaW50IHRvIHRoZSByZWxldmFudCBw
YXJhZ3JhcGggaW4gdGhlIFBDSSBzcGVjDQp0aGF0IHN0YXRlcyBSZWxheGVkT3JkZXIgYW5kIE5v
U25vb3Agc2hvdWxkIGJlIHNldCBieSBkZWZhdWx0IG9uIHRoZQ0KUlA/DQo=
