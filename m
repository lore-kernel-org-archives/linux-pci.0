Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D83334A797;
	Thu, 29 Jan 2026 03:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769657289; cv=fail; b=oyugw9N8+VY5IEvRhOSKKwHsuY9Eo5zUV6yoaeuiLw72U+5R4+uU5sIj7TCOLCBkG0lnnZHP2yMKYfne4M2ywsmRmB6uf6t7L6DcAvEitWUxCcfpwYkfxZn99FkGt4wCcnb9rdNdn1Jy9AnBhVcXJqSprGiPlxW8b578J1YspS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769657289; c=relaxed/simple;
	bh=3BmHjUM0BiK8E+BLat32ca754PpJd88Om4ltiZIstp4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zs0Or/qo64GD9pWhe3Ek1wPMXRZ4t2YFGXtke52zv26NjYjBI4IrN47gNyS263VfVn37haLNHsNiuE0BX+yIvwCjGl5IXsKIqLcxZssl4a4hliX4Kox0pr/KJGlTWN4MDtFJBU7d583ROWUDGXse6ciYwRRKNT/rmMUE5YXLiog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q7ETT01d; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q7ETT01d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769657289; x=1801193289;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3BmHjUM0BiK8E+BLat32ca754PpJd88Om4ltiZIstp4=;
  b=Q7ETT01dXhAIxB4vbnl76ImbKuPas+NrtTVYeWAIJ7D6EqQhm/x9SGXw
   QuA/hVg33+sllYIIvPVJOBsklWufxahi+1uSRaj8uxJCSaGwAQBrHn51n
   AVBGdb0Py+H5PDcWz3hQHMBsAf3gvEGWeTn7g3ZZmbTXX0INWL1kQ62qu
   4cHMbfYAT+j25kNzyXJfE6tbL+Vz7fjgNscsvGTT62eY0KW9TynC4uUUI
   5ezHSc28/iQ9qD+iFlN8JJxzVPCE4DFVDm2FqRF5Q67Bs4EtebKt80ybz
   SNh0dMvTlQJ6jmlPKZw5ANlpQbuw8bo2UzgCxlFpO7MRX/ImKgQSJuOMY
   g==;
X-CSE-ConnectionGUID: jYP2joiFRbKO94H/Ioj5/w==
X-CSE-MsgGUID: h7L0yG0UTNK5+1vimFfbHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="88301281"
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="88301281"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 19:28:08 -0800
X-CSE-ConnectionGUID: Sma15Z4TR9GUm10HZCSFGQ==
X-CSE-MsgGUID: c0EOM+WNS025EPGbx/Q8vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="208801755"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 19:28:07 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 19:28:06 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 28 Jan 2026 19:28:06 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.62) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 19:28:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YxIghJ9rzxJWHeWToore79Xmf6wZ2aEx77Vi2PFNznP96h0rZ86cgkZqzhPLp3vk9lF9Funv9c8W2zVDuPv2/NxZHS9HTcc7KLZjYp9KkoZ1ao+IxcG0YgOfsTZjlB3QUHQMtVB634nB6ZbDTQbufYrfpiT9Du2yRLXptunirPJ7dtBMSu8EWVSdQchmNf5iiWGlcwfkMfUQ28tv5Hv6c6LheVQzCVwk0oyBIU/qY/hBypJRUqjO9E4XFVTHJe3KqWvW652vWnv7myjl/ohwcPBFBpwWXnFhsCEpnFNLdjFD2hqw5KIryiAhyc0Tr2aYpYotZYNKIAY7JV/8mMX24g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1J0QQEYsLja46NKI4IIIqWBEX798K3yTqKi42qkkq8A=;
 b=GNZr7CKmAYOjqltui/z2kccj9ImgbYqCvgF9bWDH5U4gWqjmjgrYNHQAn2qvrhRICJgXAJrTXLTB33aUcd3HfqAuhVc7E4JhSn9doboi2hvvQkDNYCAzM6V3BulYv1OuWOUdav9IbKp/AtmQYbrZiXGD4s9gSWuFmn0SKE6gJ59JLRsrot36eAEpujLTo19zwPP3hlie7r62xb6HjlkPADWriYcgsrZvdzhl6xYDMy6PKDold1HAkf9BztBC4T8kwszUnwOHiVHKXpp5Ri51Bw4JGL20P1Z8sAr06lPbUhnLzwyaWeGSnMdVmKQgI/w+VdFqUyoV5vyGMq5GE+fFAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH0PR11MB8086.namprd11.prod.outlook.com (2603:10b6:610:190::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 03:28:03 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9542.010; Thu, 29 Jan 2026
 03:28:03 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "Williams, Dan J" <dan.j.williams@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Nicolin Chen <nicolinc@nvidia.com>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "praan@google.com" <praan@google.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"miko.lenczewski@arm.com" <miko.lenczewski@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
Subject: RE: [PATCH RFCv1 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Thread-Topic: [PATCH RFCv1 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Thread-Index: AQHch228OMA01jUUyEiv70mzhaALBrVcR9QggAAjmICAADJUgIABF8EAgAB9uwCAAG1mgIAHDgXwgAB/AgCAAJ1EwIAA1Y6AgADt7EA=
Date: Thu, 29 Jan 2026 03:28:03 +0000
Message-ID: <BN9PR11MB52769F0A4DE065DD1A5CA8108C9EA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <d1768bb6384050a23769f20ca28216f520f77e26.1768624181.git.nicolinc@nvidia.com>
 <BL1PR11MB5271F0BDC68C2D7F172122E98C96A@BL1PR11MB5271.namprd11.prod.outlook.com>
 <20260121100307.00004e60@huawei.com> <20260121130315.GE1134360@nvidia.com>
 <6971b9406d069_1d33100df@dwillia2-mobl4.notmuch>
 <20260122131432.GJ1134360@nvidia.com>
 <69727e7ded712_3095100ab@dwillia2-mobl4.notmuch>
 <BN9PR11MB527649A0049CA195E7BCF9218C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20260127150440.GF1134360@nvidia.com>
 <BN9PR11MB52760F8EE835B4D06BAF0C248C91A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20260128131153.GW1134360@nvidia.com>
In-Reply-To: <20260128131153.GW1134360@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH0PR11MB8086:EE_
x-ms-office365-filtering-correlation-id: e9ac235b-89f8-49b9-12c7-08de5ee66960
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?8CICS33dovwyEKKiqGvayb+C+oUsTnWGYea0M0KnVBKWEdoMonaF2MwHoJF3?=
 =?us-ascii?Q?Lrv01YR/auf3qVsQPZaPJFMjM6944kE6Ry4+dTKInxrIR8SD+pHFl/C/H+XO?=
 =?us-ascii?Q?UmQeaGS8eMl7XUTccwPgHHKXCsrlR1yZYgIXDLwq2bOkaGMUqxM8gMtuVbMG?=
 =?us-ascii?Q?4DVihymB6Wv872m9hWH1no5iWWbsFCSLxdIveZppsVxWQa92pdbihf9qZN59?=
 =?us-ascii?Q?UJbgjj3GPyUHbqkyo+EML9HWgIkYSvGs4HWTNPjWOBlpoEv91YbJwpPziNA4?=
 =?us-ascii?Q?3ynDa6lT+G7YC7woGn5nRViZp6HYxlsXromWhaM8+/4wkKALjCy7nadeWa6O?=
 =?us-ascii?Q?/n3CddTlIcZ3rACi0JsTMdSpJmb/z2Qmd1cUsLRgBWz6KSiiRmdz4HzK9rbh?=
 =?us-ascii?Q?IenlCDocouIl9beUJIW3WSjvWGnO7xlUBLqwtOKV/b6uyMpX1BDiTXoz/kzA?=
 =?us-ascii?Q?ULzKS+PsVNiIkR3NdtkuIIUHgKmAbfVMWNK5o/f8dUz34vCHwRRIhUMIu2qj?=
 =?us-ascii?Q?iHPqDOB/DpMY8Gl+nVpJdtFln6e7NI41TkgtWWlFOkrAyCtKGa70V4eCnHLs?=
 =?us-ascii?Q?+Xg6rGN32w6RI48+SVNmSEksf9/gz1AUHXSW+kw4zNB4adOxiCEr3AeTt5Oc?=
 =?us-ascii?Q?9ALXiS5GTm2fLkCqtofK7i3yRikPTSRdT3xgyIpd0pvB+nW6wtKHgwFb+DOo?=
 =?us-ascii?Q?5fFWiozCP/m2eoOh5pLyk7H/vdnweyDQr65V0v+zzbdXH6emEFcSU7/MYoyY?=
 =?us-ascii?Q?FvDgYPtX04Np2dUEdKa6TJw8YTxSYXYC/+MMQDVerQ3a38A9d/R4PhK6yl25?=
 =?us-ascii?Q?62km1QpHGHLyb6Lv9OrPeE+Rd+Zs5OKpuN4sRNe+vowanLD5M4dklAWzUqIc?=
 =?us-ascii?Q?5X9/+BIXXEDZuP5it4lvIJfJEHIh7uy/ScPSogloq+/64c5/rniUgps4nicw?=
 =?us-ascii?Q?A4aFHuJ45uHPtzPbiQ8f/1uoiT2P6xLiLYvqWFPdRZfc2vW+vPUsUDaiylHe?=
 =?us-ascii?Q?XtE5XjM6sfzb66WMUzDNc8Oa/wOgv2zz9SOe0JiV761V14d0BDcDe2C4SPix?=
 =?us-ascii?Q?FXhQYr7wCHxw4xlpSAIYjxzDMDXs82CzspIznX3Xgj5XmoB+zfWUwNRs98UW?=
 =?us-ascii?Q?EKlG8s9TtvksskmsOoUsekyCL5IlO2cUhq5MLRghPgrBRFwB+So/aJ9K/zK3?=
 =?us-ascii?Q?Do98wJFWwZXx/PrksWgLkOj6UulR9zrpnpc47MkwdPsXClIbO79obngqqJXz?=
 =?us-ascii?Q?OXxGS5a2uSGmMQNCrpOHfVqYWsob5Ky72F4dXVtxrgqUoLeXmHJ4WDD8wAiM?=
 =?us-ascii?Q?SzVWnKYxWsybGT7nfATe76LoRRZa/DHui+VNWOTdhb6M7BjKeCbMQsRtbyNd?=
 =?us-ascii?Q?3+5ChkhHjSZ0OBbIAFMo6v+24HbRPUK9MbGe5NC1TiNadEoK4uR3zR5V3aey?=
 =?us-ascii?Q?orUEM4w4T1oeFzAe20Afiv/mF6r2kJo6y0Fm2BoefabalABymlWSG1MdPuHm?=
 =?us-ascii?Q?Ywt5IskxB2r62uANa4aeElxMJIED8iq9lRGsNR9OKX/vLFdCaZh6LIrCeZpp?=
 =?us-ascii?Q?+nyQ9+JHm/ofr2QjYctXeeBMbXSfJxG9xUi5YGygYnNokFAImSicFE9xrTG1?=
 =?us-ascii?Q?Ws1qiXE3R4ljlb7Q7R/lXyU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8VPTsG3CTvl+H57Ou4bggqYibXPiyd7KBoOWjWT8QXGO1S2eUx75LNyCfI3I?=
 =?us-ascii?Q?oUICQgKoqNmVR0lTTBS7ncoVQkEPjG/BXVBetGEZvBu0gD4neT6uNmfGlyZ2?=
 =?us-ascii?Q?LmIWOJIB1VgGrFrOqsKzbmNc5GsY4858wsdKj/IC+kwa24+G9lN4NaMkUYAE?=
 =?us-ascii?Q?jc1FhA19pIZ7uWo6jTpF1Ir24XyfuK7xOAB9B5KdHxy95oGbCx0nHh8sOTU/?=
 =?us-ascii?Q?D6WaJT1DbrTISg0WjrEgh2hXCvfiUCe3SiXntoWVAPWeYeEPZg234NmAWUDc?=
 =?us-ascii?Q?R2Ms5eFoMZUzAYAJysuCBXaQN1zDbI+6H0fqhAyj1Xu3Z/NGobqbBg5XGitx?=
 =?us-ascii?Q?F2J0z/oaClTXrf4EIF+QsIAEJQvjeBN/tsq3xssgWqE2lF/NqOvQTNZEJo/B?=
 =?us-ascii?Q?Earb9AOsJgtzt2D2LYOJZPjbLyTAjJKgQSbuwngKxjd5e36vcTI0oEcujXJ7?=
 =?us-ascii?Q?Y+UUG4b7pZNq0XarkwGmrkXFvjcxNaUJxDB56DS+l4rQ3fQaC+Ugw0whEb1w?=
 =?us-ascii?Q?qc8ME348ABhyCJYVenPGEIB8HBjeyt4RBA3bN62/H17ysv/5aMXdJvo4Jua9?=
 =?us-ascii?Q?KIyx1yrL8c1ukx7nyxAV3ra/77rf7uHvEXuyXWJbpBs6Bwd/ZmgBJ0T5a8BZ?=
 =?us-ascii?Q?V7yPaeaAtBeqbluQ5R1I2Jy/GiDnXTenv9j2vGhUdsZIzzcbc4/12cTPlV4+?=
 =?us-ascii?Q?KKJpL5/RE/D5R9QqM3nUI9Bnm3rtyR8u0ErtcG7otuiWBopNUwuFELX895jq?=
 =?us-ascii?Q?MPchUwwAk1uXCevwptwoFHK6tVY8YI/OLd/xej7IpgW7eTwFYnUOpJRjX1mH?=
 =?us-ascii?Q?LUQoYKiOMRyetHykGZenF0KNqAh9l6eWUdLP1vEdtJ0zZNKMm/OWMKiKHzyg?=
 =?us-ascii?Q?qUJWiynuO4Szr4gVaU65wQvLIPdla12nif99N4xPkQn9G8gPwnuGCKAniM5Y?=
 =?us-ascii?Q?rAGVXr9se5Oit85JE09SuzQ6rTFj0SMIGGHvPYxZs0IHYaiymNXgPPxaN7hQ?=
 =?us-ascii?Q?JZxtRMMGiwuomC08iWJoF1KExLYL8LE+oUk208RLjyi6fesMgUz73hYYNN6a?=
 =?us-ascii?Q?xpSNLBHbWoEFkfDbGW4QjSbiCy2KamGCGefa6U9UuFNDwIXxkaSPLiER4m7c?=
 =?us-ascii?Q?gIELQ5ZcietLXpG/AoJJItnpb+EVlIcShWUPmLkU0mbZav9MdyL5SoMUObXk?=
 =?us-ascii?Q?kz6+U2T/rbVFYpxuK0pcL3AOHWvLMZS8qcsQ9QbH/4TCyZQprl1SeE5Prwbz?=
 =?us-ascii?Q?Xq6NXot1IXNYD1Bifps64WeH9c4+oCCN1Q3K6xaMRDYUg7elm3tVoVj7PTBs?=
 =?us-ascii?Q?uyq1hKSjKxT9hxseGo0MXxw8lsN7Ii1sDy6KnU1YG2r5SOyNHafvUksREBnn?=
 =?us-ascii?Q?WYJiXqZF3vY4LhTeQXy+5plOfpZURzoKp5jWA8e4bI12iIv0e7BYz74Jug+T?=
 =?us-ascii?Q?kyUUd/krDaS+l7+hujZ2e2dy+ceHXwCzsxsNaUqMpQHrijzJJlKOH1j5rYDa?=
 =?us-ascii?Q?tynD0Awhj5p0AsIUv2E1v16X1naXco+JaS8p3ZgtVEbn0qLbXVbVZuNxIQwr?=
 =?us-ascii?Q?V+eAuaK8vLaQn7tdaCw2rv83pcs7wmTbxvl9Oj2Pa4eNP0Dgf0011SqMQzfm?=
 =?us-ascii?Q?xjTDnsK/4sKoqBy6YOP5eu7MpLCC4YwG6q480FtUIhSzXAhjaM0qxGHwPW7b?=
 =?us-ascii?Q?0NTMCKeYCqYBdSe6+vEwY5KgtHl0vcqbNfuwm5TBbsrM7rGItft0O5e491XT?=
 =?us-ascii?Q?y830WzflGQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ac235b-89f8-49b9-12c7-08de5ee66960
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 03:28:03.6262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RrtJNLVB5SHImR423XEZum8LoyQbesVUgiF4ozT4GTFXkksPvpI5Ezkd4sKaKKh8tmafA9tezhEYmWYv1C8czQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8086
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, January 28, 2026 9:12 PM
>=20
> On Wed, Jan 28, 2026 at 12:57:59AM +0000, Tian, Kevin wrote:
> > > > - Intel: ATS is enabled when a device is probed by intel-iommu driv=
er
> > > >   (incompatible with the suggested flow)
> > >
> > > This is definately not a good choice :)
> > >
> > > IMHO it is security required that the IOMMU driver block Translated
> > > requests while a BLOCKED domain is attached, and while the IOMMU is
> > > refusing ATS then device's ATS enable should be disabled.
> >
> > It was made that way by commit 5518f239aff1 ("iommu/vt-d: Move
> > scalable mode ATS enablement to probe path "). The old policy was
> > same as AMD side, and changed to current way so domain change
> > in RID won't affect the ATS requirement for PASIDs.
>=20
> That's a legimiate thing, but always on is a heavy handed solution.

yes. at that point the rationale was made purely based on functionality
instead of security.

>=20
> The driver should track what is going on with the PASID and enable ATS
> if required.
>=20
> Which also solves this:
>=20
> > there is one scenario, e.g. VFIO allows domains attached to RID and
> > PASIDs being changed independently. It's a sane situation to have
> > userspace change RID domain via attach/detach/re-attach, while
> > PASID domains are still active. 'detach' will attach RID to a BLOCKED
> > domain, then disabling ATS in that window may break PASIDs.
>=20
> > How does ARM address this scenario? Is it more suitable to have
> > a new interface specific for driver bind/unbind to enable/disable
> > ATS instead of toggling it based on BLOCKED?
>=20
> And is what SMMUv3 is doing already. With an IDENTITY translation on
> the RID it starts out with ATS disabled and switches to IDENTITY with
> ATS enabled when the first PASID appears. Switches back when the PASID
> goes away.
>=20

yes, that should work. In that way the driver binding flow is covered
automatically.
