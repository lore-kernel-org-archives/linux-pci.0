Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779F438734D;
	Mon, 30 Mar 2026 23:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774915037; cv=fail; b=JmIkNbnDSjFvw3eQFZLR6c27xCl/BkjEvgsufCB2C+RKQ/gKzdIMescEBKPYbmWWTKwB4f9ix/8+b2NHp2rulNL0ylwnj8u2N2RcNkQF6fkRTq58BXw5CeM95WZ5tDVSx6rI6UgBSlLMCJQ1+oVq7DiqM00shgRH648nRKN+ReU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774915037; c=relaxed/simple;
	bh=CAL7JCry7DgQre6CYd3hPG82DD+rbWke79xwiTXPyZE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ossuczk/WmoVM4HrKrnqRNIvlyggBk/EmnTYoCEVwWDYRgvNUJvPntBEdv/9zzF03vfB7pG8JwZuf8Frqxlh77gMDX2sIt9YLroRsHfqs1GoeQxJU8gWtQOEuBB5b5biYjetZVbBzp7OEhg6x5niOzidvoE9cJ6tswpU0jXcp2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NrbKotyx; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NrbKotyx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774915036; x=1806451036;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CAL7JCry7DgQre6CYd3hPG82DD+rbWke79xwiTXPyZE=;
  b=NrbKotyxqXHHrBFJGI2//BzE2hpDbCUX0wlG6b1JsrSQYh8e4IXoFqmB
   ZbdAQkuxjTtzjlJ8n3AxsysOcSOC46XSco/8y+rI23Hy3CcLuU8v+U/x5
   CNqqhP4FjIvZVrD5hyNHrCrrDlrWs0DieSLSPUljMEtRVj0QKGvtnAoa/
   6eE6KsOSYITdKZpF4ZvpjpklFG2V3rCRAOuDsSFuaL4gH5cZKkyssSeys
   53Wv1qzM0GWrAYN94d9Yh6lqpqe5Mx0Ad9Xy/hW6QiERYXQakI+HzMAP2
   nCKmRT74LI1IXAP5fErHqylv7j/3oFzszEadvJE5IqqWXRp3M/vjWjDjx
   w==;
X-CSE-ConnectionGUID: b/HPPrjlQVKJRwtISYo8XQ==
X-CSE-MsgGUID: GbZhDbBTRaOiou0gNQr0fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="86218900"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="86218900"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 16:57:16 -0700
X-CSE-ConnectionGUID: JDXOTxC0Q9ay/kaRm+bfYg==
X-CSE-MsgGUID: W6aqI41cRJaPswVyhj42Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="223326592"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 16:57:15 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 16:57:14 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 30 Mar 2026 16:57:14 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.48) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 16:57:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WOOYX1SnCOW43fudp83yBVEx2BGjxVLwNmxfi9DVwFYYHKFbVvElGGPOCZ1jISIoE72VM88zPhsn1qCLgF/aH9AxqWzcpGmts9lSBQ9JydEi/Nsmh92U1H2I92a38ugLbS0BIlTNKO544L5DbwXt9CgLS8Jw0YO1M28lMdng1pOhTw/UlX5J84RyynL9SgLBHzz85FyKLMPMQcXvdD+zcQ+ByoG7CDGAblvYj3gUN97VcrUCmPhAZfUl4C1GTFfwHf4iMDRJM1UG/pgZ6ZZKzUeqkUWWBEpFr/bZI+e/NEyKp6NOtnwcoBNz7sOOi4eHlieMH2oMTIuAiEjq1al3tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAL7JCry7DgQre6CYd3hPG82DD+rbWke79xwiTXPyZE=;
 b=Ja56QbuGSDDXiKdOljccUoMv0CCXWbEmWYscZCeD6C/In091we7nD+lN+6DQmopt982x+Ywl7PwoJAUIauZEDU9/lEqQTaf7D777jggqAc4BcyfhWHpvkQiV+ipqIIt1IMAHx0X67LjXO9tbxjwLMIdGMJqR2aeiBKeHPYsHQ9pEBiIvMzul9ChF8nLES5w85OjS3AcZEUuMQd6N1us33Z4cGmBFFKK0w0e+3Uo0H68pcOyIAHrxKU1LQ/PbUeU0FfVZoQRQTo6K6TbClCLqIqKP9sNeJwtEqPDWquMto0lo8m01B/v7hWICc5uReUvIA6RnHsZzxh0uI04EZ0ocOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH0PR11MB5046.namprd11.prod.outlook.com (2603:10b6:510:3b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 23:57:11 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 23:57:11 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
CC: "Gao, Chao" <chao.gao@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "kas@kernel.org" <kas@kernel.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>, "Jiang,
 Dave" <dave.jiang@intel.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"Verma, Vishal L" <vishal.l.verma@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>
Subject: Re: [PATCH v2 03/31] x86/virt/tdx: Add tdx_page_array helpers for new
 TDX Module objects
Thread-Topic: [PATCH v2 03/31] x86/virt/tdx: Add tdx_page_array helpers for
 new TDX Module objects
Thread-Index: AQHcvgX616NCzLrQvU64gEOMZ9C2QrXDKlAAgAQSpoCAAIjVAA==
Date: Mon, 30 Mar 2026 23:57:11 +0000
Message-ID: <f163ab3b7c939a7d19864dfde9897ca3b424c60b.camel@intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
	 <20260327160132.2946114-4-yilun.xu@linux.intel.com>
	 <1dd0b8f4d1ad5cd07b5139ed8c944e1e1d004661.camel@intel.com>
	 <acqbDVnd6gNJWmBi@yilunxu-OptiPlex-7050>
In-Reply-To: <acqbDVnd6gNJWmBi@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH0PR11MB5046:EE_
x-ms-office365-filtering-correlation-id: 7960455e-e24c-4da4-0326-08de8eb80f3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: qAbhgQYpzqjcncXsbIJ4jU9jKp1VBM0XSt+W9C78N7qiG/9iBXgA2gHrh6ZA1fgB1mlVWo5LkN5hCfdiOx2Ju+QYN4Qrw5qbZmTmRGI/ZHGnEGrduaRcCG9OgFTR0hVBGLu/53IHr0fmCbtWbUxbmzQpsJ38maJNqbavEP5m3n/qGsmEZ5kV62JlQVUCNof2gLbfLI5s+hXNTdhSSyPoxQoosUjQCDn86xX/foM0qVxbF46vgGov2p3de/WL5V3q2Lkm+s9iusFm2Fd+I+FB+Cr9tZwZ4CWuUmGAkJNTckvwCYwf84eBs97HHXP8/w5UbSe0rCg9GnsK++p35tYI/ehvwYPU8fex9un/ZPSMOISDuJxlJL03zEMLepju0Lj4xc2wtaKuUx4MjxHV0aoynFDLEVH47s3v+VB09OSYO5BHHn/qz5OJtmHRhWCS/PXhytEe7Q3GgY2UF8BfW0vhfI5eiSH6Rd64ZdEuQU0F+jB7grYrcVfoET9Vcp7OswUa46l44zOPVCk9ahyaztvotPN2288KYNPcDbFf3AS7m6rZl/5Sq2GTP9gOUHYynKFwhBmfo38rT9rJkvqLSsGW2Cv9UwSUGGbcgkrQGWpn5xsBoD5p8rkYu0XA8FPVMLVhL7WAQBLoPGhxkztLLoXk1xclT1rgnOUwi2OCZkXJ0BJBx+Nf46G+ajPXskPm98gJR6uEJmX/q2zF8QVkxiqIiFl4lIEoieQjLyspnPPLykjSM/+srmD8LESq0baXjg1yS+A7Juk9LZgkCNZCBP4t66H/4MIFhnZCPQlKD9vN8Pw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YU5nZ25peDBNdW8ycW1XTDNacTR1NEhrUkNEL3FQbzRCZVhhQzFnY2pYU1la?=
 =?utf-8?B?TkdXbzNmekp4MWVPV0hrTXlVcXhpNmk0ZVdNRElKOGZ6NHI2bVAvQnV4RDY4?=
 =?utf-8?B?bnZWWnZ2cHZRWnBmRThsdlpQTzh2bEZjVXZtS2FsZ2hsNThsdU9EU3NlbGxL?=
 =?utf-8?B?UlRJMnp1RWowMjRsWGtSZzE4d1BpTG5TMzNUQkxqNG50OENWWFdLTnRRSnJ4?=
 =?utf-8?B?c1BXR2IxWmJDSnY3Q21qMWQ1OTVmTlorMFpJSjZDQzkrT2Q3NmM0NEQzNXJN?=
 =?utf-8?B?UVdxSWFhNFBOblI5aUlLMVdkR1gxb0hVdXJHTG1aUFd6ZkFGSFJna3poTzFW?=
 =?utf-8?B?L2E4K2F3U05mOVJFTWg5RG95d3FKd0E3cVNiWjY2Zzl2LzR6SUhKMnJnS1FS?=
 =?utf-8?B?KzhjSmMyZFRnTDh6S2V5UmNCcHdTZCttZkRkeVlYNWd1cUVONUhDZEhXZkxN?=
 =?utf-8?B?amJjQ1F6Mzd4VjdtQk1wODB5MHBXdEdiMWhlUFQyTlcwSHJvV2d5QXI0eXI2?=
 =?utf-8?B?Ull3U0drT1JoaFpRTml1UXdIYnF3OG43NjJSYkdQTFo5TE13dzVMdWxUWDFM?=
 =?utf-8?B?ZmRkYmdNTUdLdVNDOFdJa0Frek5xNXZXMnpyVWtLMnUvUVBvTkdPTjJTZUJH?=
 =?utf-8?B?Z254dTAzOUUvSzgyUXhadWFKYm01YmRCN2JHVm8yTG5CdDhHRDFMMEtiVTVB?=
 =?utf-8?B?eEd1RGpqazNLT1dNZHBGL2NhOW9iOW5jRDIxYStQYm4rVHF4ME11UFBoTk0v?=
 =?utf-8?B?SkpLVFJYQXpsV0NMdFhUUnJ6bHgrZEhLb2VjU0U1ZmFyZUx4ZU1UYTI4cWs1?=
 =?utf-8?B?dUlxOVNFbkJDTkZaanJjQUtSc1huOHg2c0RVSUsrSTlQT09CV2NoajlvcTBw?=
 =?utf-8?B?SGxseVVXbnNQQUU5bm9TRVNnWHZoVEFoVEZFZmN0NElvMjNJN0hZY2lzYTB5?=
 =?utf-8?B?VHN2R3V2cnd1LzZTczBQMjhvV3ZIV2ltYnd6WmoyN2NmQUN4WElEd3I3eHdr?=
 =?utf-8?B?elZOcU05bldVakttcUpQSUVDUGJ3b2szZi9Sd3g2aCtvMEtFaHRDSVF1c2w1?=
 =?utf-8?B?SE51bjU4THBTZUxZeHQ2S2ljTTdlQVBUcXVNWURHQVhpL0dYRnZqK254eG03?=
 =?utf-8?B?MUV4ZVF0YS9DOGxoa254M3dMM3FxbXYrY29VVHJIdm5scTJCUTlqbTFNSTJS?=
 =?utf-8?B?MnNGN3Y3S01NcnI4SlhMR0tKL0RiYTVVekJCUWk4Zm9xLzM1WUswME56S0Yr?=
 =?utf-8?B?NlhlL1J3WUswaVlVRmp0R1dGcXFoVEUwV1ErR1ZjV0IyVUlXaXptenI0UkV2?=
 =?utf-8?B?NDUvS25jQTNSVEFTaUlHeHB6UHY2MjZjck9wbHZYWXBtRSthZi9HRjVSYnlY?=
 =?utf-8?B?alEvWENTTjVBN3FDSWdxblFCbmIrQ0V0UFBBQUNkbndETGcxUGhaZ0I3dUZ0?=
 =?utf-8?B?QUF1UEk5a2ljRGRGaDZyeWI2U2M2RnRib1g1YVpkbW1Fa1NjRmpKb2dsbUU2?=
 =?utf-8?B?RytnRVZ2U0FpTTZRL3Vjb0Zrd2JvWmhDbzhuQ2RhcHIvcnFVRENvU2FETTNv?=
 =?utf-8?B?YUw1NEhUQ3lLVjFZa2RzZGtlY2FOTGRGOGZka00wNklJREJWNTAzdHBLU08v?=
 =?utf-8?B?VTBpSHpadDRIKzhjdVRTd2RKVWJMKzlVc2s3Rjhwb1dobm14emh6R1VFVW01?=
 =?utf-8?B?U0JKZlp6a0xEVVRxRjRmWkRReTF5NDhPMklJSWNCTTgzcWo2ajlLVUluMnEz?=
 =?utf-8?B?TG9tVGlQRUtRTVJrc0NSWURjYThsRlNKNVNqMzFRT3VvRDAySDMxeHdYSHlw?=
 =?utf-8?B?K1ZKZHlVazhDVFEwVzdNcGtmelRaTHdIaDkyUERDSzhqWk1oVFB0NVBtUmFW?=
 =?utf-8?B?eGtiSk5IdVdNNTE5cldJd2IyTVRTT1g4Sm5ISjNDQkZGZHMvcm1TaGJVQ2gy?=
 =?utf-8?B?SHJ6WTBDaUR1Smw3cjh3b3ZtQnRtYW5xbnlucXMyQmd6dWRiVnE0TnJhUGhN?=
 =?utf-8?B?dWg4Ymd0MUNMR3A5Qjc1Tm84WGcyZFFaN2FGK2x5SGVUOTdyc1E2bmtqMUtC?=
 =?utf-8?B?V0dERTlXVDErd290V3htN2xvcGFRTWRJenh0UlhzM0ZheEUyYnNacDNsZ3RD?=
 =?utf-8?B?cms3RDNBODJsbVdSUnlCSkVITTJZc1RwSUFPdmlmdUlVbStXd3ZDNW8rWXJZ?=
 =?utf-8?B?R1MzYzBFWG1TR1dzZkdid1hWR1BpWVh5MzlpY1dPenAzSEhMTFN4RktUY0lo?=
 =?utf-8?B?Yy9aNVNHQW8xWFM2TGkrT2dENUtNc2VzcVJXYzhUSnVlWUhTSkpUTGJHbVl3?=
 =?utf-8?B?WGNqNUpOOWpxUzJwVHV4VFkxOVFMOU9vNUFrbEtjU2JxSlBnWE0vZ3M0YXNj?=
 =?utf-8?Q?VcqkB/uBqxkXPCVc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <573C479D2FD00C489F6F368A8C23480A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GfJ5hw5s0/BYv3JMGh6APk9UR6hzrCvhJHPSzmpDaypZK0U6ADfnLYuETjoR/20G4R70Iqe6cxNjq62UkhuVEHtNCQYnKSRfGhzFnC/bX5VzPlbGrBET5smrLdi+X1b+pqzC7aKI0yw3VObRtk5yPgySnFhh8dWMz4PBgtISJCMKqrW65/56WsAE2rLWHrggKP9gTQSOzysggA353qEa6pSmW7Bv9dxGuKVDHttSaw/kcvgppoz4PiWEVJapdCGjjLc00K3xkUOE6t5vzE/LqoP42e6so1tRy13YYsoWdpshpibtB0v+C7OdYF/EzudsAsJ/t0E86xX82/lTafMngA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7960455e-e24c-4da4-0326-08de8eb80f3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 23:57:11.3824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OO0OUy0v96PogIAIhwPHc3pl9iSEEUQ5Xoao7JtpE28LDtmNYxM7IIyMjbvJOfLbNeSz6uDis7ICBcxogLRvnsokhAI9eRdPJ9I93gFgkao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5046
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTAzLTMwIGF0IDIzOjQ3ICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gPiBw
YWdlcyBpcyBnb2luZyB0byBiZSBhbiBhcnJheSBvZiBzdHJ1Y3QgcG9pbnRlcnMsIGFuZCByb290
IGlzIGEgc2luZ2xlIHBhZ2UNCj4gPiBvZg0KPiA+IFBBJ3MgdGhhdCBnZXRzIHJlLXVzZWQgdG8g
Y29weSBhbmQgcGFzcyB0aGUgUEEncyB0byB0aGUgVERYIG1vZHVsZS4gV2h5IGRvDQo+ID4gd2UN
Cj4gPiBuZWVkIGJvdGg/IExpa2UganVzdCBrZWVwIGFuIGFycmF5IG9mIFBBJ3MgdGhhdCB3b3Vs
ZCBiZSB0aGUgc2FtZSBzaXplIGFzDQo+ID4gdGhlDQo+ID4gc3RydWN0IHBhZ2UgYXJyYXkuIEFu
ZCBub3QgbmVlZCB0aGUgcG9wdWxhdGUgbG9vcD8gDQo+IA0KPiBXZSBuZWVkIExpbnV4IGxhbmd1
YWdlLCBzdHJ1Y3QgcGFnZSAqLCBmb3IgYWxsb2MgYW5kIGZyZWUuIEFsc28gbmVlZA0KPiBURFgg
TW9kdWxlIGxhbmd1YWdlIC0gUEEgbGlzdCAtIGZvciBTRUFNQ0FMTHMuIFNvIElJVUMsIHRoZSBw
YWdlIHRvIFBBDQo+IHBvcHVsYXRpbmcgd29uJ3QgZGlzYXBwZWFyIG9uIGFsbG9jYXRpb24sIHRo
ZSBQQSB0byBwYWdlIHBvcHVsYXRpbmcNCj4gd291bGQgYXBwZWFyIG9uIGZyZWUuDQoNCk5vdCBz
dXJlIHdoYXQgeW91IG1lYW4gYnkgdGhpcy4NCg0KPiANCj4gQmVzaWRlcywgaG9zdCBtYXkgbmVl
ZCB0byB2bWFwIGFuZCBhY2Nlc3MgdGhlIChzaGFyZWQpIHBhZ2VzLg0KDQpTb21lIGNvZGUgc29t
ZWRheSBtYXkgbmVlZCB0byBjb252ZXJ0IGEgUEEgdG8gYW5vdGhlciBmb3JtYXQ/IElzIHRoYXQg
aXQ/DQpEb2Vzbid0IHNlZW0gbGlrZSBiaWcgcHJvYmxlbS4NCg0KQnV0IEknbSBub3Qgc3VyZSBh
Ym91dCB0aGlzIGlkZWEgeWV0Lg0K
