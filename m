Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0934938AC7A;
	Wed,  8 Apr 2026 21:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775683502; cv=fail; b=cYWu3r8AnZ6o/z1f5TzOO0oaCN+jLkAXofWYFk2xv+YvtcKL6d43806li4VLi5o6p1ObHl8vijvJlyFZU7OtItOUhP59ZyJdZY6GZgt000hPvqg1l98dvUI0oDzRU2bRLJRQGDoZBqvt6Zu14oNI3lZKeXgLENV3sqC7vBKna6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775683502; c=relaxed/simple;
	bh=nqFKY5n99BxnlLBFTWiJnuMOuhRFtXhzPg8rxiKjei8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B0flysFyCqkG9Pkg9lpBVkkpLuO/26w1AaLeTjU9yxdtI/qvBZLmSsH95/8f7s9axuZBgtpyMPL9x0b+MTxsPz5o7AkTa/QSmex68V2VxZXgG5T5glPr6Qp6OpLsflWSCvCpk2vG3VBMEodNE3UKdXDZ2aCu331S2FxLmtHZHjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bUlDzWWu; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bUlDzWWu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775683501; x=1807219501;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nqFKY5n99BxnlLBFTWiJnuMOuhRFtXhzPg8rxiKjei8=;
  b=bUlDzWWuvi7Vh5DmTBM+s2m4hy9r5L08Ht5LU2syUQ5TeW2kLm9SUMu9
   qpoB0ziV1Ophpl7D8RUMaL1Lgbzfd9af/LZrD5ltXPBSa0vdZB5yuWTK8
   yUGP1Qlsje9bqTqgHMkrNjZK7zAwesVpE8h2/sJ+S6TisTYqBiWPLm1EB
   R1s57KfOM0NTMFzbhsvvIkY+xPpWTHOysc7ZZI9NU5sOuoqHKom8auV2B
   bi/h87K6nKGumGuBVkoISKtmGglZP2bN3dwDKUlTBQpsDytuIOHe4QYUM
   G71Bu22LNTgbAvRvXbNEzKtt+02BntDBuiiJVF4Bme5oadx/I811pFksU
   Q==;
X-CSE-ConnectionGUID: ZYk1wVQIS6mkg4yzkPRssg==
X-CSE-MsgGUID: /GL7US7OQf+sMMfMO6HNxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76801058"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="76801058"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 14:25:00 -0700
X-CSE-ConnectionGUID: YWkprthETZW2747rlzjw7Q==
X-CSE-MsgGUID: gRZtRdYhS5ynrdOs6yIc7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="232962564"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 14:25:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 14:24:59 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 8 Apr 2026 14:24:59 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.0) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 14:24:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n4Z+MaMsEspGCSgU+3ErP94ww5oCVo4JMx3wu/d/h6Bi3gognuKOlQGXeyQeVB7a6IaEdoo6UI750p2pRi3uE8ggAzCMaEzsTyWYh08C/AoMSpI35yTA7EzPCtelL95ifMA6Q545/WybJ2DDHmVoTd0zG1ptsoor4O+0wCNr3oNZMA/argfzqJah17dQCMyrnDtvkntrpUHUuo6d9IAlzi/UYb0cqkcor07e12IHMzWx2RsDGvDwdlxYkJ8/WHtGU2+5SmCOUnv2of9esDhCws0YVPQur8+PjppHQJnCFP3laSx5Et2CB+PydgeP5VR3OspT29suuWO633fNur7c9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqFKY5n99BxnlLBFTWiJnuMOuhRFtXhzPg8rxiKjei8=;
 b=LZ0PTakckEqv5GjZDqwOPvTtY7PoOgN2zMhI8jb/Lm3rfNBeuQYfeAWNFmw4b/UQSmhY4sMylU0VrQMvb4KiMBLRROYzEnl4b0c6Qg7hoDdpQcdWrqTq3y+CNPSinFaULZcUbQTNEKW7yxOUEMVbDPn+TLKy4/lOObKQZMNf1FpKWOFpGGSTEXQXWGUlySxc/EUOp0PenNaQDECLcxnDEmROyh3aNw0EUAmaUqphWAVqW9hlmK2upZpdIETBpLzuaD2PY/kEH6OcHQK4Xw6qBHGIwXy9KO+3JXF3d1Vmd15vswsMVb6ym939Te0XM/tSiyIrQbxZvHZUfiCS4GojKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 CYXPR11MB8709.namprd11.prod.outlook.com (2603:10b6:930:dd::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.19; Wed, 8 Apr 2026 21:24:56 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9769.004; Wed, 8 Apr 2026
 21:24:56 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Xu, Yilun"
	<yilun.xu@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"Gao, Chao" <chao.gao@intel.com>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 11/31] x86/virt/tdx: Make TDX Module initialize
 Extensions
Thread-Topic: [PATCH v2 11/31] x86/virt/tdx: Make TDX Module initialize
 Extensions
Thread-Index: AQHcvgc98Is38OpLIkO/aXISJkcG77XHvPSAgAEEoYCAAVuggIAKyQWAgADZ/oA=
Date: Wed, 8 Apr 2026 21:24:56 +0000
Message-ID: <8b6627db920d3cde3fb4c3826a25210965dabba2.camel@intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
	 <20260327160132.2946114-12-yilun.xu@linux.intel.com>
	 <5cbed31cdfcc7e43f283abc275848370239a3d40.camel@intel.com>
	 <acvhD/XeCbB4ea0C@yilunxu-OptiPlex-7050>
	 <124b776006fee36e4a242f58bd4e128eae97c505.camel@intel.com>
	 <adYQx+6LcO/s2nyn@yilunxu-OptiPlex-7050>
In-Reply-To: <adYQx+6LcO/s2nyn@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|CYXPR11MB8709:EE_
x-ms-office365-filtering-correlation-id: b421e347-1a76-462d-23a6-08de95b547f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: PvrothVoqZ5P+DzDfU1LKafdkujnVgs393k3NQfuWC2ohhsa2QYPlsFcVil4CYqQE130Rg3oSY1v063qeeAkhMhQ/jHupEgsiu9uDpxpmE6O/RXVi3GMdGOC7Fd+s8afkCaeZSW02x7SKWap0S7hOhp22PtPdkkpHwRkizTAN7Gyz5TDY5vx2FV8leujHpyXITV6+yJMWqbmC7OEFN+l+A5N+yEFKx/fmCxD7lyfJJSC0x3FSaYHgbdxL+M5Ls7Z389H6rK87LXL4w9g1Hl+1AgSniyib+qgYSDcOZmPvLO0HgfNC6e5JOrOPCRxtgD653aYx/zByD2Gz0mGkjFWYJQ+Uy0djdRdHlWAhAV+HLVyBBDlCrjVdD/BUgSOB2rPP6rvd92vzZNnksYkDV6uuS+Iq/kwVTFNXkB/XFwCSrGy3jlsR8X18IUIATUxDo6rVmuykKHs0a1fqa7vgeO+uPtnmIEtgKhRbHAVMv9QNdaGgxuIxlkl2JGkLZ8aMu0CCACASUJ2k36Q316IHIdFtyQM8lD11xgOpsBpVxGAgH67M/Z+6qIGILecbW4ypXQBPQuNO/A7IULskdynTKuzWYMIG18oxu2hGQNcV0vhuVHkpct6FWhGnVL6x6/71M6tb26XCNNQQihEl0wxRR7z8oyXpr6ZOcYzQWRp6dURQY4AzUtX1C4MvPOv843JXvYxit0wSlMEeF5u2GJEs5PTMhq2yRjnHpiMlp4S0HM0zXzX4MSiQSG9nvURL20J41JFBJIdTldB/4t5wcISNLMxnazzwUwqSKnavGKqM2lXoU4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmN6SXRaMlFNeGZ1ekROR2MveEYvZEY4dWhxWkVuZ3QrZkpuR3oyTmdxTVVn?=
 =?utf-8?B?ZlUwNmdmMnp0QzN2V3l1ZCtVSlBENmVlYnI5MkV6dkJrZUlYdUJvN2dQTTN6?=
 =?utf-8?B?b2N3WGNHS1BDekJIV3Fkbk5QYTBYNDYyREhKM1dZTDArVXEzOU1vMUlDN0g3?=
 =?utf-8?B?V0lpbi9DVkRJT2dtL2ZncG5UaHlaVFpxQzZ5OGxUQ1RLQUl5RUNJMHZUL0hm?=
 =?utf-8?B?eDRXQkhLV2gwTDJVeXJQc2drd0pha2lVNTArUDJrSFJEZ24yVFpjaE9ySFlH?=
 =?utf-8?B?Vk1QL2dLWi8wd2lPa1NraE1meXQ1Vy9zMHFIQjFiQWpFWUphd2FNMXpCNm1R?=
 =?utf-8?B?WGg3M21aVXJROXFVNHhuNHE1M1ViaFpsVzZoQXFGcXdDL3l2SE1VWkxKclYw?=
 =?utf-8?B?WUlJVThGalZacFcwSUZaVGM0ZUJvM1d0WElOcDlaTlNyR0RBdXFYZGlWRWhS?=
 =?utf-8?B?SGpJbnozWVdiMmVTd0k0bGZRZGQwa0Z3MzJVR1Y3TkcyQWk5RFFBb0Vqa3dh?=
 =?utf-8?B?T3h2eEx2UWN3ZzYwUXNob05xdk9jV09iK0pFSHdnV1hzbHNqVnJCRDFyQ1oz?=
 =?utf-8?B?MmRoU2RnOFBGY0Q4NjFocnJ2VUhwMytRTTkxQWVtS2ppT3JEU1NLY3FieG9F?=
 =?utf-8?B?VEJSdWhodVlESnN5NXl4T2pwa1p4UkJkZUxCbW5ncjduUnpuZVBMcEVyR3Fq?=
 =?utf-8?B?RkJ5ZVdrSENaNzk4cWRVR0p1UWFSQmJEZkh6WGNZdEhSL3pIeGxManFVNkpG?=
 =?utf-8?B?VXBOUGJLM0kxTFVENlZWbDN0UkRENkxlUnJiS0JFQitpZXZlcEM5YWhqa01H?=
 =?utf-8?B?YUI4VllKK1dVUmtGbzhKTjdaTUxZcTdKRHdlZno2QjAzYmxCYm9ubXFtV1dK?=
 =?utf-8?B?UWJmc2ZUaTgxcFdUamVhS0FQNEtUWnhJZmdZR0tCRXg0WWQ3VFFldS9Sdnd6?=
 =?utf-8?B?U0dGZ3BOaG8yM1p5QnVjWE9zK09PM1I4Y3NYamE4bS9qbXZEZy9Fc0pGNVNF?=
 =?utf-8?B?YkR4S3dxdm1aRkxhTVAzYTQ3bXd5Ymt6c0VGaVRTanFWcFhNcnBUSlIrOEdL?=
 =?utf-8?B?L3pReFdmdlBycjBiNDJkK2tOZngrMHBtdUtNN2N5b3ZFNjVROVdNUmplTzVY?=
 =?utf-8?B?bUsrSkhHQWZ3NCtxdDlNT09uTjRjVHVLTlpjcU9wUzB6R2NVakprSDdYM3ZI?=
 =?utf-8?B?TC9DZHBxOHo0NkFYZ3p2anFrOTVubVZVeTRNMXhWRENFa0tYYnhQby8vT1pq?=
 =?utf-8?B?THBETmZhdHNycXBHU05XcGhhOGt5V2IrM3U3YUdrQzcvVUdCbGVNeTJhRkgy?=
 =?utf-8?B?VnZnV1ZWMGF4WTNrL0lSUGxSOFpWODBhUHErSmhDYmowaHNPNDRyWmhmVm9Q?=
 =?utf-8?B?YWxzbk1HUmNsS3dSek1pbnlMeFNFaVZ3ZU1tdUJGdUg4Y1R3aVlQUTgyd3k4?=
 =?utf-8?B?NXQrVGpnUk9ZZDNTZWluWGZ2SmJvU1dkVFY0VlAxT2hDM1RzcEd3UTcxcUh4?=
 =?utf-8?B?ZGNpZjVoYjNPZXhtVUdsRkFVK09WMnk4SnB6bGlkdmhWQnQyeEI5cDBKd0I0?=
 =?utf-8?B?dzhFZkQ0WGhPU3Z2STIyMDhvT2Nyc2JHcXBzVU1HbzNhSHFkNUtSN0xwMUdk?=
 =?utf-8?B?aHVrR0ljQmsxM3ZDc1BCQUF5TmxNM09EcWRpS29nTmUyNEg3SFZVa09Ya3Fz?=
 =?utf-8?B?eTVyYnF0YkpXdFpHSTNVbHRaUlRhMXBpR1dmSjQvb3R3V0lWdGZqRTVyWVhY?=
 =?utf-8?B?aDV5UFFDNEQ1dmo4emFOZTVyWGFYL3dMaG1zS2c1R0J0aUNDUFlZMklEU1Nw?=
 =?utf-8?B?OFNrSmtERHRGREx6bU55eDVORTRoYlZ4c1JEN2tHZU5TRUVpU2RFKy9qcXY3?=
 =?utf-8?B?Mi9TU2VpaHUzWU9vbUlrb3VQUlR5dGtHOHMzS0NTQ21jdFBtZW02cDkyTHpG?=
 =?utf-8?B?RVZBcGxQNEVKTm5Gd2ZFa0xKYysyTTdjSzZhYW5LUjZaWmtRc093R2FScU1w?=
 =?utf-8?B?enRJa0tKVTQ3U0xCOW1sM1JVSm43b2lNTWg3OC9RYjBUd0V3SE1hRkZZaTdp?=
 =?utf-8?B?WjhFMGJIODRIQTdHNlVNakN4ampULzFTOEM3a0tNdTQ2K3ZuSG5YdlpFb1JP?=
 =?utf-8?B?UzVObHBBZ2wyclk5SHlELzQ4SWdBbVZGc21EZGJLSEI3bE1EVXZjQk9tOUJh?=
 =?utf-8?B?cUlxWGdrWFg5OVE5Q242a0phRFJob1Mrc2o2Zm1IZFA5T2VERzUvSzNKTGZt?=
 =?utf-8?B?c2lURlA0aVJtMW1LaExEZnFDaUhlSUZtUFplZHhxbElRc3pCZjlIekZyUjZE?=
 =?utf-8?B?eDNDZkFBMXRZcXdqdStlQ01uQkNaZ3FiT3dGWDFPaG5ja2pnRjBhQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E9C9C7642D46E4F82170F362788B343@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: RbEO4QdrfiWRAUXGiDJpJ+UBKp58YRWFz/32jgEH+etL8NeAXobxadapq58P6lcQtjHROVb1nwysY8lQMqROWct6SSKqic6mQ9nc9Dpf2u4aNHLUdii38YbPXIlmjFhDnbxIU2LMSsGdLE9BAB9Oh0fYEBpHC/0TBJeQh7C4CL63JHndDelzyTLXZ6SDcm4yrtDM6KAMSBoyyIdfwsbUAoFQMQw1+Kapw5QZM+vZPuHXltXdszplKUehJXG44Rca+RXlVJpnDX1e+++Z2xWBKTnNylQlsJJ6Jdcp2VvCzqoPZWPxzoHbhrfEPtF2EWhU5wNHPGSUZncpsxAIiU3emQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b421e347-1a76-462d-23a6-08de95b547f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 21:24:56.1400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f7Yi+ll4B6LIBUcPV5k/zmc0Er7Q8ZOjYa1a2x2wrEEuEiANkZIuQ0QKO56abCFbwSq2OsDTS3Ze78IsPyxuTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8709
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA0LTA4IGF0IDE2OjI0ICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gT24g
V2VkLCBBcHIgMDEsIDIwMjYgYXQgMTE6NDI6MzZBTSArMDAwMCwgSHVhbmcsIEthaSB3cm90ZToN
Cj4gPiBPbiBUdWUsIDIwMjYtMDMtMzEgYXQgMjI6NTggKzA4MDAsIFh1IFlpbHVuIHdyb3RlOg0K
PiA+ID4gPiA+ICsJLyoNCj4gPiA+ID4gPiArCSAqIGV4dF9yZXF1aXJlZCA9PSAwIG1lYW5zIG5v
IG5lZWQgdG8gY2FsbCBUREguRVhULklOSVQsIHRoZSBFeHRlbnNpb25zDQo+ID4gPiA+ID4gKwkg
KiBhcmUgYWxyZWFkeSB3b3JraW5nLg0KPiA+ID4gPiANCj4gPiA+ID4gSG93IGRvZXMgdGhpcyBz
Y2VuYXJpbyBoYXBwZW4gZXhhY3RseT8gQW5kIHdoeSBub3QgY2hlY2sgaXQgYWJvdmUgYXQgdGhl
DQo+ID4gPiA+IGJlZ2lubmluZz8gQmVmb3JlIHRoZSBhbGxvY2F0aW9uLCBzbyBpdCBkb2Vzbid0
IG5lZWQgdG8gZnJlZS4NCj4gPiA+ID4gDQo+ID4gPiA+IElzIHRoZXJlIGEgc2NlbmFyaW8gd2hl
cmUgdGhlIG1lbW9yeSBuZWVkcyB0byBiZSBnaXZlbiwgYnV0IHRoZSBleHRlbnNpb24gaXMNCj4g
PiA+ID4gYWxyZWFkeSBpbml0ZWQ/DQo+ID4gPiANCj4gPiA+IG1tLi4geW91IGFyZSByaWdodC4g
SXQgbGVhZHMgdG8gc29tZXRoaW5nIGFic3VyZC4NCj4gPiA+IA0KPiA+ID4gSSBjaGVja2VkIHdp
dGggVERYIE1vZHVsZSB0ZWFtIGFnYWluLiBUaGUgY29ycmVjdCB1bmRlcnN0YW5kaW5nIGlzOg0K
PiA+ID4gDQo+ID4gPiDCoC0gVERYX0ZFQVRVUkVTMF9FWFQgYml0IHNob3dzIEV4dGVuc2lvbnMg
aXMgc3VwcG9ydGVkLg0KPiA+ID4gwqAtIG9wdGlvbmFsIGZlYXR1cmUgYml0cyBhcmUgc2VsZWN0
ZWQgb24gVERIX1NZU19DT05GSUcNCj4gPiA+IMKgLSBJZiBvbmUgb2YgdGhlIG9wdGlvbmFsIGZl
YXR1cmUgKGUuZy4gVERYIENPTk5FQ1QpIHJlcXVpcmVzIEV4dGVudGlvbiwNCj4gPiA+IMKgwqAg
bWVtb3J5X3Bvb2xfcmVxdWlyZWRfcGFnZXMgPiAwICYmIGV4dF9yZXF1aXJlZCA9PSAxLiBPdGhl
cndpc2Ugbm8NCj4gPiA+IMKgwqAgbmVlZCB0byBpbml0aWFsaXplIEV4dGVuc2lvbi4NCj4gPiA+
IA0KPiA+ID4gU28geWVzLCBJIHNob3VsZCBjaGVjayBtZW1vcnlfcG9vbF9yZXF1aXJlZF9wYWdl
cyAmJiBleHRfcmVxdWlyZWQgYXQgdGhlDQo+ID4gPiBiZWdpbm5pbmcuDQo+ID4gDQo+ID4gTXkg
dW5kZXJzdGFuZGluZyBpcyBkaWZmZXJlbnQ6DQo+ID4gDQo+ID4gUGVyIHNwZWMsIHRoZSAnRVhU
X1JFUVVJUkVEJyBnbG9iYWwgbWV0YWRhdGEganVzdCBtZWFucyAiUmV0dXJuIHRydWUgaWYgdGhl
DQo+ID4gVERILkVYVC5JTklUIGlzIHJlcXVpcmVkIHRvIGJlIGNhbGxlZCIsIHNvIEkgdGhpbmss
IGFyY2hpdGVjdHVyYWxseSwgaXQncw0KPiANCj4gTWF5YmUgdGhlc2UgdGV4dCBzaG91bGQgYmUg
aW1wcm92ZWQuIFRoZXkganVzdCBsaXRlcmFsbHkgdGVsbCBob3csIHNvIGxlYWRzDQo+IHRvIG91
ciBkaXNhZ3JlZW1lbnQuDQo+IA0KPiA+IHBvc3NpYmxlIHRoYXQgb25lIHBhcnRpY3VsYXIgZmVh
dHVyZSBvbmx5IHJlcXVpcmVzIGFkZGl0aW9uYWwgbWVtb3J5IHBvb2wNCj4gPiBidXQgZG9lc24n
dCBleHBsaWNpdGx5IG5lZWQgdG8gY2FsbCBUREguRVhULklOSVQuICBPciBzb21lIGZlYXR1cmUg
bWF5IG5vdA0KPiA+IHJlcXVpcmUgYW55IGFkZGl0aW9uYWwgbWVtb3J5IHBvb2wgYnV0IG5lZWRz
IFRESC5FWFQuSU5JVC4NCj4gDQo+IFRoaXMgaXMgZGlmZmVyZW50IGZyb20gd2hhdCBJJ3ZlIGJl
ZW4gdG9sZCBieSBURFggTW9kdWxlIHRlYW0uIERvIHlvdQ0KPiBoYXZlIGEgcmVhbCBzZXR1cCBs
aWtlIHRoYXQ/DQo+IA0KPiBNeSBndXQgZmVlbGluZyBhbHNvIHRlbGxzIG1lIHRoZXJlIGlzIGxp
dHRsZSBjaGFuY2UgdGhhdDoNCj4gDQo+ICAxLiBUaGUgRXh0ZW5zaW9ucyBpcyBhbHJlYWR5IHdv
cmtpbmcgKGNhdXNlIG5vIG5lZWQgdG8gY2FsbA0KPiAgICAgVERILkVYVC5JTklUKSB3aGlsZSB3
ZSBhcmUgc3RpbGwgYWRkaW5nIG1lbW9yeS4NCj4gIDIuIFRoZSBFeHRlbnNpb25zIGNvdWxkIGVu
YWJsZSBsb25nIHJ1bm5pbmcgLyBoYXJkLWlycSBwcmVlbXB0aWJsZQ0KPiAgICAgZmxvd3Mgd2l0
aCBubyBtZW1vcnkgY29uc3VtcHRpb24uDQoNCkkgZG9uJ3QgdGhpbmsgd2UgbmVlZCB0byBndWVz
cyBoZXJlLiAgV2UgbmVlZCB0byB1bmRlcnN0YW5kIHdoYXQgdGhlDQphcmNoaXRlY3R1cmUgYmVo
YXZpb3VyIGlzIGFuZCB0aGVuIHdyaXRlIGNvZGUgYmFzZWQgb24gdGhhdC4gIElmIHRoZXJlJ3MN
CmFueXRoaW5nIG5vdCBjbGVhciBvbiBhcmNoaXRlY3R1cmUsIHdlIG5lZWQgdG8gYXNrIHRoZSBt
b2R1bGUgdGVhbSB0bw0KY2xhcmlmeS4NCg0KQmFjayB0byB0aGUgYXJjaGl0ZWN0dXJlIGJlaGF2
aW91ciwgdGhlIHNwZWMgIjQuNCBURFggTW9kdWxlIEV4dGVuc2lvbg0KSW5pdGlhbGl6YXRpb24i
IHNheXM6DQoNCiAgMS4gVGhlIGhvc3QgVk1NIGNvbmZpZ3VyZXMgdGhlIGRlc2lyZWQgVERYIGZl
YXR1cmVzIC4uLg0KDQogIDIuIEJhc2VkIG9uIHRoZSBlbmFibGVkIGZlYXR1cmVzLCB0aGUgVERY
IE1vZHVsZSBjaGVja3Mgd2hldGhlciBhIG1lbW9yecKgDQogICAgIHBvb2wgaXMgcmVxdWlyZWQg
YW5kIGlmIHNvLCBjYWxjdWxhdGVzIGl0cyByZXF1aXJlZCBzaXplLg0KDQogIDMuIFRoZSBob3N0
IFZNTSByZWFkcyBNRU1PUllfUE9PTF9SRVFVSVJFRF9QQUdFUywgdGhlIG51bWJlciBvZiBtaXNz
aW5nDQogICAgIFREWCBNb2R1bGXigJlzIG1lbW9yeSBwb29sIHBhZ2VzLCB1c2luZyBUREguU1lT
LlJELg0KDQogIDQuIE9uY2UgdGhlIFREWCBNb2R1bGUgaGFzIGJlZW4gaW5pdGlhbGl6ZWQgKFRE
SC5TWVMuS0VZLkNPTkZJRyB3YXPCoA0KICAgICBjYWxsZWTCoG9uIGFsbCBwYWNrYWdlcyksIHRo
ZSBob3N0IFZNTSBjYW4gY2FsbCBUREguRVhULk1FTS5BREQgIA0KICAgICBtdWx0aXBsZSB0aW1l
cyB0byBhZGQgdGhlIHJlcXVpcmVkIG51bWJlciBvZiBtZW1vcnkgcGFnZXMgdG8gdGhlIFREWA0K
ICAgICBNb2R1bGXigJlzIG1lbW9yeSBwb29sLg0KDQogIDUuIFRoZSBob3N0IFZNTSByZWFkcyBF
WFRfUkVRVUlSRUQsIHdoaWNoIGluZGljYXRlcyB3aGV0aGVyIHRoZSBURFgNCiAgICAgTW9kdWxl
IGV4dGVuc2lvbiBpcyByZXF1aXJlZCB0byBiZSBpbml0aWFsaXplZCwgdXNpbmcgVERILlNZUy5S
RC4NCiAgICAgSWYgcmVxdWlyZWQsIHRoZSBob3N0IFZNTSBjYW4gdGhlbiBjYWxsIFRESC5FWFQu
SU5JVCB0byBpbml0aWFsaXplDQogICAgIHRoZSBURFggTW9kdWxlIGV4dGVuc2lvbi4NCg0KU28g
dG8gbWUgaXQncyBjbGVhciB0aGF0IHdlIG5lZWQgdG8gZG8gdGhpbmdzIGluIGZvbGxvd2luZzoN
Cg0KICAxLiBPcHQtaW4gZXh0IGZlYXR1cmVzIGluIFRESC5TWVMuQ09ORklHDQogIDIuIFJlYWQg
TUVNT1JZX1BPT0xfUkVRVUlSRURfUEFHRVMgYW5kIEVYVF9SRVFVSVJFRA0KICAzLiBBZnRlciBU
REguU1lTLktFWS5DT05GSUcsIGluaXRpYWxpemUgdGhlIG1vZHVsZSBleHRlbnNpb246DQogICAg
YS4gSWYgTUVNT1JZX1BPT0xfUkVRVUlSRURfUEFHRVMgaXMgbm90IHplcm8sIGRvIFRESC5FWFQu
TUVNLkFERA0KICAgIGIuIElmIEVYVF9SRVFVSVJFRCBpcyBub3QgemVybywgZG8gVERILkVYVC5J
TklUDQoNClRvIG1lIHRoZXJlJ3Mgbm8gbmVlZCB0byBtYWtlIGFueSBvdGhlciBhc3N1bXB0aW9u
IGhlcmUuDQoNCg==
