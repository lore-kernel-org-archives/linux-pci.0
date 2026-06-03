Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331ED409105;
	Wed,  3 Jun 2026 07:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780471905; cv=fail; b=LHDStomVL/KfRpw1OsrHaJYVv4Zt1deNqqNxtOxPINDdI2k/u2nO0BdH5vuO7GSAuXkocU5BjUEbAI7oXhVzXXHcoorFppINKU+ukoljkMWBRAq07sYQDuh49+rAtIwKxFhbVxz2zgF5XDR7V9/C+VAdQJ6AQeYehnvLnrgYJFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780471905; c=relaxed/simple;
	bh=ESo7WLn1x5oBVHSOO3oQYjV19FtY61I4vB3jl3b+Jm4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rv5yRsiBhpq2BBEKXtT9ihvpfTPSJ57JCr7XJq+UUSnwLhROQ+4lSPfpo6msvABQuFXCblUxaghGVU0y+Lny9P4Am9Tsq9gOUjEZVZDnWErnjEaa435TIP6tmooxvKvmt590i+0V8m0rQtYuCNgTQ9KiuozC+JTbVcp+3ZlG9pQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZwnGN3jO; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZwnGN3jO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780471903; x=1812007903;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ESo7WLn1x5oBVHSOO3oQYjV19FtY61I4vB3jl3b+Jm4=;
  b=ZwnGN3jOi/2i5dXJLSJxx1E3yyKgheOr7jNujh88/u26Xo45/dqCfWky
   amJTISpsHihhe11T8jpxwZy4FTdMU1VBZGmOUphTbwYm4KgRUVBFbeCzQ
   ED0FLrEokmZ/rBoOTptIGyDkUWlgr3Av0HTDs39ziZ9ttUWzhtoUbNtka
   j5ImEap/TY22TCMZhAhCdzmz0CjgXOCuBW30Mb8/bOqNjXQwtPM/vZZYz
   d4nwOEEIYsj5Nc23PMA0GCqPqc6bRFggH6W1MwFa6PUpprFZNBulOXj0/
   pQaJgz8sKPc+bip7l+9Q2ZSlmPEhDIlbQ7PRVrmQKQVmaoXjz2GXXV7td
   w==;
X-CSE-ConnectionGUID: F8lx4IDHQOmIm3yKyqjpYQ==
X-CSE-MsgGUID: 6b3/zY+gTuyithxO2YhV1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="85125532"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="85125532"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 00:31:42 -0700
X-CSE-ConnectionGUID: JE25wAr/SjmwzW2uYwmFqw==
X-CSE-MsgGUID: VGeWqnpgQ7CFH+j0u+fi1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="249216464"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 00:31:42 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 00:31:42 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 00:31:42 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.38) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 00:31:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LknzvQWeRquC+Os1MHzQN4AY421lDK0Wq78lCHyk3aenrR4Bg8kx8Lm3pfvAyL69zSZN4bnXdAH0ou5+pX8JvGPASIqzs0vO3+gwj5JvrJXuzFhceTIrecurtnNxl/uOBBnF2PGCxJBopE1kI4OkfF5tOUlqerRed99OJ3QmLkjgOCwnHHKh5vWRWkiEzfMHRL+nZVxAk//kCgOALAf47Ug82U8G1CWNsK/jX66rXTPepYAPjeUyMMa53yuHFA9IrjxYWnoJlqclCj3Yj044MC3IFcPLZF10WMuxQoUE5E1RzD3LBEWE/LpfceRGrCi2Kk0ozKgU8/5CHvEyAn3E2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESo7WLn1x5oBVHSOO3oQYjV19FtY61I4vB3jl3b+Jm4=;
 b=RLk5qFyLJWg4rM44xID0GKRC0OyYLfTCzRpfLnOLOi10seYzPKSnsqZ+LkIQ/pNHzlQEEGCqz5j3V2CUs2K4V0XMMmSqw9+0w13CgOKEl2kJ1VrgBj+essgtjCBQh9jcVf4Mx2QpO2YQ9P1gqa+b4AfMtHoeuvpxTQqyRstz0TmJdf4cFW6ZOV7HVvU8iKmcctzmgJkD5Gv5UQv8V7endfBls6ZCdbZF1WuNAMRGV2+7C9tHT9/ySV7B12vSGGowT0utHr+xSFImTaObojYr7pzY6avkKakQHioazOvijJJb1tcvorYovJ4bsyWlIXGT5vSuYwawIt7iwYxggRIfIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3690.namprd11.prod.outlook.com (2603:10b6:5:13d::32)
 by PH3PPF6E8D29981.namprd11.prod.outlook.com (2603:10b6:518:1::d2d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 07:31:38 +0000
Received: from DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::7db8:f6b3:30f8:ee4b]) by DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::7db8:f6b3:30f8:ee4b%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 07:31:38 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Pranjal Shrivastava <praan@google.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Baolu Lu <baolu.lu@linux.intel.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, "Samiullah
 Khawaja" <skhawaja@google.com>
Subject: RE: [PATCH v7 3/5] iommu/arm-smmu-v3: Fix a UAF in the probe_device
 error path
Thread-Topic: [PATCH v7 3/5] iommu/arm-smmu-v3: Fix a UAF in the probe_device
 error path
Thread-Index: AQHc8dQhngiSXOA7LUylIS3s6L3I8rYscWqQ
Date: Wed, 3 Jun 2026 07:31:38 +0000
Message-ID: <DM6PR11MB369078B4E5BC3C6514A99AFE8C132@DM6PR11MB3690.namprd11.prod.outlook.com>
References: <20260601143644.2358771-1-praan@google.com>
 <20260601143644.2358771-4-praan@google.com>
In-Reply-To: <20260601143644.2358771-4-praan@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3690:EE_|PH3PPF6E8D29981:EE_
x-ms-office365-filtering-correlation-id: 5b898e93-9927-4f1e-6d7d-08dec142265f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|22082099003|18002099003|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: HIR2tpthSb5iunRN8r/eQyZ18smgl8KD+UlcNW7UEOP6ARv4VkCh+motYFmc8OdApbHRpgwl4YWzzWGWBUU4DbusBfoQ8qKov/h/tMVWlC1EdQk3ON7Tdoj1jSTRfXcRTuIVCZnj0GdtgCJjIWMZuBsPUxBNF+svs2g30qASQWn4B9bo1VQ4Dq/4RObi9IQXHoAXfMruxP5YSBGcexEo9e9K2D6PVDgY1clrbzWAYTEUwDWEKZc8wznS7nhE4pbk3t8uypsogpMlqxH0cMw7ctEYFv6l2xiGq3HwIY0tTs1ThXkcNWlYzMO/yA3puz5Ryv2GIjIN18+xTYB79saUQ9EDucYqpb+WmfsjHDQZBzR786X09KAq+PVrY+cNXSJx5IdiRjev1jjoU/oAaVqhy6AWTRE6Tp+HgXt9TABaQiRPWjVlPoW8w4i75uYYIkZMjBHS70hfx2NYN92fUwPUiyrPWhfMfYnppgw2/U1dp5JK98cMYxAwrfND7OTE6yxWbJKu7nPR7rcvTq/702dfvEVNQYGPLKOJdJoitkvx8/PjDGU0sACVMnAdFdDn9+TIJplw3ZCtdkx/fCG9o1obJhVm1vsKgSe1Ykbw8kSdzX4gFq1tbhlnj+O5sdLW4oYH+PadRZCcHrFvP1g8sauqFMqu/SiuKQeQ3cuDX7CACbtRJD2EGH/hlNdajkJ6hxNi2JNcjJI2xZwdM2MPq4pqPekrC6whzuCx/ZLyWC3OxHPwssEL5YdLaKvV0cwk+VtN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3690.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OS9JV2hYMkFmamlYL0NMTEtxTzZKVGhCN1dkeHVlUlp3MkcxM3F5bWNCcHFy?=
 =?utf-8?B?ajRDNktlUEJOdU1rWHJ6dFkvNGtHZGNDTzZpaXlGSHZVb214ei82cWZEWHk1?=
 =?utf-8?B?MFpzOUl3a1RpaUNPUUtDWldSdHlDSXNscWhMRUQwaWlOZFc3ZkJ6NldmS3lT?=
 =?utf-8?B?Vk55a29wMlV0R2tzbVRiZUNvaHRyTks2UEJMS3hxbHlsWjY1WnlKUXRrUExU?=
 =?utf-8?B?OU1XVUljcC9EWUhKOG9xYXVTOC9CaERoUDV6U2krbzhRTjlNaDhKVWtQMEtm?=
 =?utf-8?B?Q1p4cU1Sais1K3lRaHR2ckJzZTQxSGxvaENreko2ZjJhNFpPQzB3SWlJNXpu?=
 =?utf-8?B?aDN5bFgxYnlZU1k4OHcramY5aWE1RXFtS2U4NTBaZURaSCtGU0QyUzJMVHVJ?=
 =?utf-8?B?dlpQYU56bkZlbEo5SkpibkRoYnZVU0R5TXBWcXhNUFk4WG1TMnluNEpFYjJJ?=
 =?utf-8?B?b0RrWlZFcHNLRGNha2p3R3RsMGVjRHFGbm4ybVZpcUNaZCtKUlcxSkF5SWlw?=
 =?utf-8?B?c3FFa3RtOTZtZnkwTExvOGkzbjBRemRUSUFQdTVjaWIzRmNaZjhWSkNXRjVB?=
 =?utf-8?B?amVlNE1uVThTdG9LTnVtRFJlRkRmZzRad05NNWtuRFZidXlIQmpaVmFubEdo?=
 =?utf-8?B?eWRTeG1UUmlKeVFibnFiOEcvV0UxeVpOMVBWc3VablhUN2lUa1dycjFFMEdR?=
 =?utf-8?B?ZDZGRTZCMTU4U3I2dW0wWjZBVzdFeEJmYXkrTURXbFRRMitEOHE5dGc1dWRW?=
 =?utf-8?B?V2htUkpBSFg3ME91SG5keUhCUko4c0dzZVpZakFkVzZGMkcxTGxwdnhEWVcr?=
 =?utf-8?B?VVZ4YXhPaU5NUHRFQ09LblZ4SDdtN09qVDYvVTdTQjdYeGZBcjk2Zm0reWR6?=
 =?utf-8?B?VUxiRHdUMG54a0JOYzBxeFZ0K29wVW1pNGdLVGNnamtWczJjcGlOUnFrMDQw?=
 =?utf-8?B?WVFpa3czTU1SdmZ4U0NQREdnVG42T29TZmFubTUzVnRWRlJnWFdHRUFPeFR1?=
 =?utf-8?B?Q0dId1g2WDhLOGI3Sm9xVTEzVU84V096RVVSd09nUzdNZTRnSzJtVHpUUkRO?=
 =?utf-8?B?UkRVRk1PQ2h2WXZwVjEvVGVkVXJLM2o2UUNyVEp3Zmc0VldMcEdEY1RiaGFi?=
 =?utf-8?B?QkVKRnRkUEFsb0dBUnBWSlhyVUVmck5FM3c5S3Y5TkY5K1pUSlpScG9QdUl3?=
 =?utf-8?B?WjJNbjBmNUxYeDlWZXMwOEpWZTJPSU10d0tYVFBPTnF5NVhUSHh6TDNkeCts?=
 =?utf-8?B?aVNxQUtQcVdxUmlZU2xUdW9SL0V3QXdpUlhaQzJ6R2ErWGZYclluZTNHZ1Fq?=
 =?utf-8?B?TWlDMlh5YzVUaHlPVmZUODRpNjg1UmRPNWVEc0laYU1rR1Y0dGZQb0FHVTV2?=
 =?utf-8?B?UGhFN25GL0VKUGtmblkwZG00OGZaSUZ0WFp1T20xaGQxek5iUEU1d2hid24z?=
 =?utf-8?B?WEt4bkh6NUJiUEJHSDUwYmFJM2tnRjI5NVdOTmQwM05NcTAyajVISkJlVnFJ?=
 =?utf-8?B?NVp0VXZMdjZlODdrV29QOWU3NjRSUkpTVTlUQ3lwSGVXNmUraUF2ZEl5RS9G?=
 =?utf-8?B?SVIyOGpSR2I1WFdoRDhkYkVJam1tNHY1TytWUlgzaitJUThGOVgrMmhZUmRh?=
 =?utf-8?B?ZW5tRWVldlVpS2FJKzVBbDljdmlFNHFMaFJ5OGdRNDhRUE9xaVBhU0JURTJQ?=
 =?utf-8?B?bnkrckNUWlhPZThBdVVpR2pjbzhSaWYwTlpCT3FBazhQSDdrR1dXK2lOUmFi?=
 =?utf-8?B?Y0U5QzhFejlDallkRlpWUGhjQ2FkRldzNjMyS3BQYnBuTjFrUG1sS0JqTnFy?=
 =?utf-8?B?OU9wb1NEZDlsZHlEK1lOM1N4T3V4aEhQclJHVWY4aEdJMHdiZDJNbkloRXk4?=
 =?utf-8?B?NUFFRG1Zc0UxK0FXUnNnVUZIcjB5YjBDK2V5R2l6ODJhZmdHN09tSjFuTDIw?=
 =?utf-8?B?Q0JOTndPVGpHaFYyWHpNcFhNRzZ2U09XaGgrZ1g5UTMxUDR3K05FNGdFa05J?=
 =?utf-8?B?aVh1dkhVRDVFL3c4MHQ0b0lXbjZwZlYzcVlJd0ROSlBJNUJwZW1mMGpiVWtX?=
 =?utf-8?B?bG10T3pPSVFkYjBrTktyOVFqaG9CREExQkhEQW16SzhyZlJPS28vbEZrcjZW?=
 =?utf-8?B?V2grMHVBdWNZR085SzVsR3NZOWJEUVFadmlGNHZ0MWpOK3UyMFBBc0NUSEl0?=
 =?utf-8?B?MzdxL21KNFpHb280UGxQcTRkYVU5NW1ZZ0FlU2hqQ0lTTTNrWnFLUXlPaDlv?=
 =?utf-8?B?cVVtcjZaOHYrSUdRNklJeWNxZGdhaEl6MGZlTGpwNXZBaTU4WGJES2wybmZi?=
 =?utf-8?B?RTlDV2xHTWp0eHBLMWhCdmpBTmRydm9VT3grdmtnalAySXM0anZadz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gBCa+Wl2/Hy59DDAr8h0x30ayFJOaiIWwU3pojKqJ3KiSBEEklFn5dRiaX29Ch9PuczDIcVWOFJVJJ1jrEn7Q3ur9raDehtoBsSILyHG0u2pd/ey9c18woatAoHkUyc+SilXMoFBvqSNGw2o+lBeLVIAGrlSYwTY3f3Agu2JmbRL9n/gmsAro/errgPnpHddEpfYRt9LWxOWc2seIBBqBKjQil00ZoWRXUQfUJeHJTXqHWnU8KJopW5QR7ntqIWLFZE+2A7UNJAd2klLSh1jc1PRcNNhCqHCE/OTvU0rbCTIGUkwONM+LA/WOok7rz6mhFNbILzg4HsIsQWb2QDxoA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3690.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b898e93-9927-4f1e-6d7d-08dec142265f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 07:31:38.8713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TbYubT10rgFeBAA51EMz8JATGv78g897OLm5AEn5A/J7pg7hVGVRyiAmK6tAV9aTPzPSxKwuWpkgiAxLANIIiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF6E8D29981
X-OriginatorOrg: intel.com

PiBGcm9tOiBQcmFuamFsIFNocml2YXN0YXZhIDxwcmFhbkBnb29nbGUuY29tPg0KPiBTZW50OiBN
b25kYXksIEp1bmUgMSwgMjAyNiAxMDozNyBQTQ0KPiANCj4gQ2xlYXIgdGhlIGlvbW11LT5wcml2
IHRvIE5VTEwgd2hpbGUgcmV0dXJuaW5nIGFuIGVycm9yIGZyb20gcHJvYmVfZGV2aWNlLg0KPiAN
Cj4gRml4ZXM6IGEyYmU2MjE4ZTY0OSAoImlvbW11L2FybS1zbW11LXYzOiBJbXByb3ZlIGFkZF9k
ZXZpY2UoKSBlcnJvcg0KPiBoYW5kbGluZyIpDQo+IFNpZ25lZC1vZmYtYnk6IFByYW5qYWwgU2hy
aXZhc3RhdmEgPHByYWFuQGdvb2dsZS5jb20+DQoNCnByb2JhYmx5IGFkZCBhIG5vdGUgdGhhdCBV
QUYgaXMgdGhlb3JldGljYWwgYXQgdGhpcyBwb2ludC4NCg0KaW9tbXVfaW5pdF9kZXZpY2UoKSBj
YWxscyBkZXZfaW9tbXVfZnJlZSgpIHJpZ2h0IGFmdGVyIEBwcm9iZV9kZXZpY2UoKQ0KZmFpbHMu
Li4NCg0KUmV2aWV3ZWQtYnk6IEtldmluIFRpYW4gPGtldmluLnRpYW5AaW50ZWwuY29tPg0K
