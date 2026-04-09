Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94002D6E5C;
	Thu,  9 Apr 2026 01:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775698165; cv=fail; b=qZB+hHDswUuTkUkBUQpiE5snzg6FhSGwLzcKLXxvIjk2D0mfINXp6Xp/3pYGbi9FpEsD2Cab2Z7Xb723EOaChleg/dbp2OmmeHj9TsMlPEWKb2X6uR0opcgJDuiL6Run6Qyz9tsIdHNoowMwok3Ekl4BuGnhKzfEjNUPYhLBL7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775698165; c=relaxed/simple;
	bh=O9juse5zW1vESjIYIXLYmZL2oo2LPna9XQjTBoskns8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Oqmv67GaMg2iFksgHitHK4ZlcXdFs9oVjyhjUXd3wS3pUG2ifeymMfsnwuk42wG9Hq/g2fqm0DJvv2AtUDlmGnvoXXVENFqguVWQ1lviJLjZ47w148cWNEzaB6Iuo46Olo4JwaqiiHJh+C7h1af8i5PhXKakgBdBntirSS9Qpxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bx/Ih4ko; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bx/Ih4ko"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775698164; x=1807234164;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=O9juse5zW1vESjIYIXLYmZL2oo2LPna9XQjTBoskns8=;
  b=bx/Ih4koPQtknyHRzTs+mMJe0aEuBg6/nO9Bw8ywgIHttDIBwqXMM+ad
   oDUUHlG51UBYJphApa+nR/Tpn2WAWQHJYhuODrI9ZIFnlCsQUvJASK5MU
   ZEFzL5QufPS9qEETInAzUPX9Xlv80ssSpiobOKdjIFkwLcnGSN1dbgTa5
   dis80H1BPLE2MUDXfsUKdzMazqRupKofyAPCaJHh2qwxtJWeGZLG8gKZ/
   Zm3dwgPkR49mK3wpF+s1H0Ee5702VyP3cxMFZh/AfOdVfG0AuiyOjG/Iu
   /Z6ldiBkhQZwAnZcw+IklgsdOO8ZiCxSUGrDDc4OfUI3Tve62sB0KGnAF
   Q==;
X-CSE-ConnectionGUID: /TUmE5+iQtmeSGtkD3NLmg==
X-CSE-MsgGUID: eRPAdTmMSomfiN6K5xdmJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76410872"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="76410872"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 18:29:23 -0700
X-CSE-ConnectionGUID: MPXmyNzmTPSnVBENdZ/S7w==
X-CSE-MsgGUID: MT5zLjpUQIia2uKf71cjsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="233011941"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 18:29:24 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 18:29:22 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 8 Apr 2026 18:29:22 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.71) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 18:29:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dl8f9C5kr8KtKgL9McefugiXHEFhnI6apHApcLlwjmrlrJF3dCTFxzOwEVp0cmZLM63J9GPoNDbU86nVxkwA1KxcSDMZR1RKfUF4AZJR5xD8SsMcN5vE28tWMA1rD0pMU1jIG1inbr35lQlM4pR3yZTXu0M681ti8geMKxptCAnJtqPp/ijl3r3BEbmDO6blobuxNZ0doJHvXLyRRHc0W/wE0jzkQcNlj8HUjqGiRuSYUOaEaGaWqpcRsS8aT+dIxDFZIMVBXP+rf9V6Bs5WNvioJagchKGjfx2xciF4oE9Kc588LWRuUzR9tiNevbPiVk/oNAx2iMowgeJsDVqlDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9juse5zW1vESjIYIXLYmZL2oo2LPna9XQjTBoskns8=;
 b=b5VDl15Qxr8FMBzUc80yqNhpjQbvi6+5dLaWg1+6efDBYVgD7T8gtcdQP8TmRq4uaCrsuUss6S172Owzun4Yh1aWtUeD3Dv3S601PEKcy1ky/lMY6hqnXCZpb4iQ2dvKhS9d4vtvM/9JrDAvdslqnr1axL0NHzB2naikw0exWCCc25pHFvO5v/aG7dSEAFL/0QKoeqKse7tlXloj0KBGd0ybFXFgXU1KMuIzceXl4xO3ONxokvsPihg9iOMIjPfBln0Nr22FCFp/3N+FrhSvcaEHn1A+VNYiQ9aZUUGEl2sYRoAhXkow7kQ+dYO7K4X4b4culpDSMJfmxDTDh7pRmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 DM4PR11MB5971.namprd11.prod.outlook.com (2603:10b6:8:5e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17; Thu, 9 Apr 2026 01:29:17 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9769.004; Thu, 9 Apr 2026
 01:29:17 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
CC: "Gao, Chao" <chao.gao@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"kas@kernel.org" <kas@kernel.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Verma, Vishal
 L" <vishal.l.verma@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "Jiang, Dave"
	<dave.jiang@intel.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 11/31] x86/virt/tdx: Make TDX Module initialize
 Extensions
Thread-Topic: [PATCH v2 11/31] x86/virt/tdx: Make TDX Module initialize
 Extensions
Thread-Index: AQHcvgc98Is38OpLIkO/aXISJkcG77XHvPSAgAEEoYCAAVuggIAKyQWAgADZ/oCAADktgIAACxeA
Date: Thu, 9 Apr 2026 01:29:16 +0000
Message-ID: <9c6535a9efa86682ed4e0eab49eb545909b2663c.camel@intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
		 <20260327160132.2946114-12-yilun.xu@linux.intel.com>
		 <5cbed31cdfcc7e43f283abc275848370239a3d40.camel@intel.com>
		 <acvhD/XeCbB4ea0C@yilunxu-OptiPlex-7050>
		 <124b776006fee36e4a242f58bd4e128eae97c505.camel@intel.com>
		 <adYQx+6LcO/s2nyn@yilunxu-OptiPlex-7050>
		 <8b6627db920d3cde3fb4c3826a25210965dabba2.camel@intel.com>
	 <9c00b87b7b69470ad1e7b1d2788414002b9a1c77.camel@intel.com>
In-Reply-To: <9c00b87b7b69470ad1e7b1d2788414002b9a1c77.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|DM4PR11MB5971:EE_
x-ms-office365-filtering-correlation-id: 2fc26c03-df07-4119-4933-08de95d76a59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: Ze0z7r3W69MSBotVt11OW2Yfg1kW+Z42f97fzeojLTy+6DAjMT6ibUJt17eWy8xZ25T2SUvjG7F92zC36tqfCPNII3TfdjQUrPiE8v/a/8TdehobSbGKqo3pmizpAjSx3k6FkzPJca0w4Wp92DCboNLnMNu53i8QlAnzhHoHAABzPwxVJqZPpp5Vx48HLusCNu7Q9Ct8H04oCfhhKvmpEWODS4AJQVl8XvTLOPFiwK/eNBokPbCXKk3jKeKlnNXBEa24/bF+m1qbdwe3IsypT+1epkEQxrZMsh8VJqlbUdSyNJhrX3OQclg5WmqT1QvUKcNYlh5ZsrKmJUgqVdbdtcBPgizTh0Zw7v2gCpJYR+A24kvZ10p/twHMLQhkSAeiKZOrzu+JS1y5p9XbQQH4ZifbdUjvLfZ8ZUGARrkW9lH/7dsRDXZNsY1YnkWOogTXD60cAVMqh2w0Yl/PFBrL735RgL33agwa5cV/XHx92HhrTIdfoDBBKNjQI5p70P1z/Q3wodJeDbmbyYcJw7wsvyNspVbRfAXlta7xCkXiXIpX97kOag4ohv3qVhDTUCzyeL+LAycIgZxLVkUWUU7h25a/n3OXvl0dOEdQwzO5yYwbJxPvwBVvSiuq2oRdiK43gPEm7G7eQJ7MN/jNQ8R0fOfhhYFkNJSu0w21rjTjiB5jCTKqUOQ+edviS+VxuiiZ1PbZAtWkSTM8sa2Srz0fpAZpiFAdtynqTvSAQU8r/vM7m+abtDAwso84FULCjL6L1Xez7dq+xuPIernYDD0SK92OtYufAUn8x8K6oRkM15I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmNnYnBFS2YweTlRcHVSa0E2WXFQVStUQXhkRW5PN1BtVmttenlzNEpIVkx3?=
 =?utf-8?B?dVNjbk0xZi9YbzBydkxWbUN1NWlYcXRTbVp2OUVsWmNFRWJ0TkNDNkZVMmNu?=
 =?utf-8?B?dlBabWNXeEZnUmphMWY1SnFQK0hzcS8wbkllL0thdHhpMDIwOEJuWkZjeTVW?=
 =?utf-8?B?UkRuUGpOOUY3WXJGN2xSSmE2V2UyRE1XYkRGblYvTzhMWjRVejhPejVpWnpT?=
 =?utf-8?B?R3VseDFCNFhKMXViQ3E2R2xWYlg5bncxdTJGWFNIS0ZqODVTY3lLc1JHakY3?=
 =?utf-8?B?RDVwQ0U1azZMYlByU3Q4U3FWRzNBZ0hvQjJRSCs3dlpPUkZsdGFoT2VGRGNp?=
 =?utf-8?B?b2lBY1d3Q2Q4cG5xbXNnWEVHdkNUQ3lRYUczRXAzclRNNFBhN09LT1Q3aDNm?=
 =?utf-8?B?RHdZVWVFQUwzdTFSKzk4SWxrUml0dnNaNEc0WmwrS3pGRndLcDdWeGlYYnhU?=
 =?utf-8?B?RGRNdEYrZUlVQmxLRjlvUk1YeHo2UndYbWNCOFh2QWV6M01uSG9CWWJDbCtS?=
 =?utf-8?B?VytTWmF3SitKckh3dzNFeXRVM1dSblN2b0ZhTms3OU9GZjExdzUyd2Zub0h5?=
 =?utf-8?B?dDFqRGwyV25rdGJIVG9JbE1QV3ptQzduZnVVbTl3bUdHZUpLbnViRHV0VVVp?=
 =?utf-8?B?M0tFZE9lbEl2TGtvazBFT0pmZUtiVEh1Qm0rc2ovakNzQzNBZExHdlMzWDRD?=
 =?utf-8?B?endYMnppUUxqMFhnRjNHS2k5bjNLSlk5Y05rbm1CYVo0VHlad3FhMnBRcFFs?=
 =?utf-8?B?eG1sVzh1S1BkUWkxTS9xdFNkTU1xWHNYZ1BVVnZicDVuL0VBOGJJb0h1cWR5?=
 =?utf-8?B?VDk1ODhLRnZrNW1PaTg5M2FsMlh5aFFVTXR2Q1NiWHBoREIrOUF2UHNOeFZX?=
 =?utf-8?B?QW5mQnBuMTM4aTBQVXFXNCtDakdQaWplMzRrWVVRMnJBY3RBdVJIbXNSZ3NK?=
 =?utf-8?B?QzVrdkpQdlFKMlpLby81UlphUzBiR1c0eG5UVFNvb0FCYW96WUw0UjhFR1lq?=
 =?utf-8?B?VGtNbXM1V29zK0pLcnJYYmZmbG9MRTk3VmpCZmxNb1NpcFJxL05aYnN0OWtG?=
 =?utf-8?B?eEo0NllkRFQvUmJDeWVhVHNBazBDUC83SGlSL3JvSVI3VFhkSTlGeGdhclNH?=
 =?utf-8?B?VU1VaGMrQm12N2JDc29DM1FJajQ5YlN6SjZVUk1hek5lZm02dmo0ZW5BU01t?=
 =?utf-8?B?MFdVL0F3NU5KeWthL2IyTTNubDFxYXd4bWtTT2VGTjRQUHBkb1ByMDRXVUNs?=
 =?utf-8?B?eEJGK1FyQ2lXTkhJU3ZLY200V21yWUlDeTF1UEdyOVlyQk0rM0dkTVh4VzVs?=
 =?utf-8?B?K0xwSmlwRll6NGdueFR6VlVLcURrQTRqcFJsc002alRkTDdabUd0QjMzNURs?=
 =?utf-8?B?ZHVRV0VGdnQ5c2lXckpkMmp2SzQvSnRPSjZFZkVXbVljR1VsaGJLMS8rL3Q5?=
 =?utf-8?B?aXd3a1lQaDg0MTRaSktDbXljaXh2THBVSUFXMWxNQjQ2eXcreGIxTS9yMHRN?=
 =?utf-8?B?dDdYdTBvWFc5WG05bVRzYmZjU05JVmRVcTcyLzBpeEFRTHdEb2hqQytIZmVP?=
 =?utf-8?B?eURJYVQrd2dXanhzejNCek1QUjJKcVpjUDdBZlRydGtNTm5Ick04K0N5cHdm?=
 =?utf-8?B?ZTVBU2M4LzJhVm5keXUrV0JYeVY2RE9BT0VKK1hZWWZtQ2RDZTZxZ1NBdWpi?=
 =?utf-8?B?RXI3VW04NVhEeWhrOUxsS200RVE0Nk53c1d6V1ZJdFR1TkNCb3RpY2Z2cnpJ?=
 =?utf-8?B?TldrU1hOZmNmOFRBT2NCcEU5UHlOVXprcjRkRndGZGhhemRxdTZBQWVTTzdh?=
 =?utf-8?B?VDVFS3paNWswTjBhZG16c1c1MWVGTzN2dkFteC9CbmoxT1A0QzFkVUljT3JK?=
 =?utf-8?B?ajh5VjNabG05RE8xdW1TNGpxdC8rQXQvYnlPUENhc29LWGZLOEJRNk51WEpT?=
 =?utf-8?B?Tkp6b2lUNUFXMlVzRDVZZGZrQnF5azBJL2Q4alk3bVZ0c1oyQTE0Yy94TXgw?=
 =?utf-8?B?cGN3cVNZNjNtRWpkMGNZSTU0ZEoxY3Fyd2hLNCtaaGlveHFSM292SjVXMUdE?=
 =?utf-8?B?dmE0NHhpSC84a05veUh6OW0ybXgybHNQVVl1RC9aZUIybG53RHRQa1dLSTFZ?=
 =?utf-8?B?dHFoWWU5cUVXcG9HYVJkYUpJNFd2NUErRWU5cWRjeTdzc1RUblE5VUxJODQv?=
 =?utf-8?B?Ri9BWEgvY3RrUkJNSGN3b1R2UWtjalZmdnFJT2UyVENJSXZHb29hTjROUHov?=
 =?utf-8?B?WXlOdWlNREdpSW9meUJnMU5mWHlTaDF1Y0drdEJrTDZCTllzeUNsN1Z2VzVi?=
 =?utf-8?B?NTR2bGlWUms4VTVxZlBEVU1XOUxOT29VSjZlRHF3RkZWUjcyZ1hTdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCA8C9EF34DCD441B80A67A637C27CE3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bAUxYm+4hdrPqIwhzquGOrVxenHzPC+y3+ERk6tlWpX7fb7afbKvSM1gtAXuSrELr/ItJCL2YDjuLf1vL1mOJg5ihCsWi+zGkigNZhDlC3b3fOB5Z0KzsTC6+OtbN390jBPI370SCJxefAgFaumW52txAZqzkKTpqJPG1ri77LlboHpe1B9/fo453aSr/jZjrzKCWbpMNek7AA89W2mBLQMWP1j/hruP+xTilgBF5A4MyupOb3KAaeyY0tokTYYBM5PL7Cy3KKCnqIacUA3i50vMVIehz6x98C21z9LzywpJlRPRYXv2SFP0vVletpHJWsIm9WyEFHFFpayJHsa2Cg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc26c03-df07-4119-4933-08de95d76a59
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 01:29:16.7576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HslRG9zlwUlXugM2VufJDZ1xMDYWescwcWtpGPoQAM0c/r8Lj7Mko82GEJvVPbq0bK4U0l3nyWjXEevtb0CW0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5971
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA0LTA5IGF0IDAwOjQ5ICswMDAwLCBFZGdlY29tYmUsIFJpY2sgUCB3cm90
ZToNCj4gT24gV2VkLCAyMDI2LTA0LTA4IGF0IDIxOjI0ICswMDAwLCBIdWFuZywgS2FpIHdyb3Rl
Og0KPiA+IEkgZG9uJ3QgdGhpbmsgd2UgbmVlZCB0byBndWVzcyBoZXJlLsKgIFdlIG5lZWQgdG8g
dW5kZXJzdGFuZCB3aGF0IHRoZQ0KPiA+IGFyY2hpdGVjdHVyZSBiZWhhdmlvdXIgaXMgYW5kIHRo
ZW4gd3JpdGUgY29kZSBiYXNlZCBvbiB0aGF0LsKgIElmDQo+ID4gdGhlcmUncyBhbnl0aGluZyBu
b3QgY2xlYXIgb24gYXJjaGl0ZWN0dXJlLCB3ZSBuZWVkIHRvIGFzayB0aGUgbW9kdWxlDQo+ID4g
dGVhbSB0byBjbGFyaWZ5Lg0KPiANCj4gQSBnZW5lcmFsIGNvbW1lbnQuLi5JIHRoaW5rIHRoaXMg
aXMgdGhlIHdyb25nIGF0dGl0dWRlLiBJZiB3ZSBoYXZlIHNvbWUNCj4gYXNzdW1wdGlvbnMgdGhh
dCBjYW4gc2ltcGxpZnkgdGhlIGtlcm5lbCBjb2RlLCBsZXQncyBnZXQgdGhlbSBpbiB0aGUNCj4g
c3BlYy4gT3Igb3RoZXJ3aXNlIGdldCBhbiBhZ3JlZW1lbnQgZnJvbSB0aGUgVERYIG1vZHVsZSB0
byBtYWtlIHRoZW0gbm8NCj4gbG9uZ2VyIGFzc3VtcHRpb25zLg0KPiANCj4gSnVzdCBzaWxlbnRs
eSBob3Bpbmcgb3VyIGFzc3VtcHRpb25zIGFyZSB0cnVlIGlzIG5vdCBncmVhdCBlaXRoZXIuIEJ1
dA0KPiB1bmNyaXRpY2FsbHkgaW1wbGVtZW50aW5nIHRoZSBhcmNoaXRlY3R1cmUgdGhhdCBpcyBo
YW5kZWQgZG93biBpcw0KPiB0b3RhbGx5IHdyb25nLg0KDQpZZXMgYWdyZWUgaW4gcHJpbmNpcGxl
Lg0KDQpNYXliZSBJIGFtIG1pc3Npbmcgc29tZXRoaW5nLCBidXQgSSBkb24ndCBzZWUgYW55IGJp
ZyBpc3N1ZSBmb3IgdGhpcw0KcGFydGljdWxhciBhcmNoaXRlY3R1cmUgYmVoYXZpb3VyLiAgSWYg
eW91IGhhdmUgYW55IGdvb2QgaWRlYSB0byBpbXByb3ZlDQp0aGlzIGZsb3cgdGhlbiBncmVhdC4N
Cg==
