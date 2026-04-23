Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B231A1E885A;
	Thu, 23 Apr 2026 21:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776981347; cv=fail; b=iRe8AGhNrBxYksIfPxUXzb2ehtYQnzQWJdChFfc322lDVjDcUgYDKR5kcLPo/ggNpqEeDiInSCzQyXbyK/kBEAYU85OYv3UAnaRLfnpiHqsaNaim9XBu7tj4ku8aKzr9347/uMZDmeSyGoCcqWLD20o+FQrUvBQIQ9+XoHIpffU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776981347; c=relaxed/simple;
	bh=4tK+7TlqUmHbFV0vcMnC52l6yhLqq84go4eq12V55cU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ayQ8Qn1Ai+gfg3mS8Z3AxmzDwIdYT4Q4N9tKaPS4J6IFn4S8dd6sR3Q1wCQpcbTXqCq4lsU9AQHpQoUbgBFUunx2QbjhaOEqzhWbseDbObgs9oygRu/ItdVhY08KwXuuom1rLPwNDVDCuK4pnSmKHaCP/+lVi9xJPqD9s9t6L2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RyTadPrd; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RyTadPrd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776981346; x=1808517346;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4tK+7TlqUmHbFV0vcMnC52l6yhLqq84go4eq12V55cU=;
  b=RyTadPrd1p5msrtFutlYrxEOIkpd8SQxztc8D6IGu4keV+kynTtnjdEL
   QaJ3b8kNiEEs+99Qsa7fhPKkRAZgAebc7cLCSPd5h7aq4fJ9r7nCACiy2
   FCOEJfNhVXmHJDgS+IfqVRq9RH4FrUaCX8w612xEHYh8+jkQiysj09rk2
   nwStB5OJ0PtKwpReDi56fHwZVW1XMA+NevELQOndJ0Uviat+OFeIGlkrY
   MmdgAk5MIhpYrG1u7+UPVfYTzEz9rByDwIkb1qhu/z2f+1mwOTGxxfJcg
   i12UtDLBvPIy+9OmwzW9in2s0gP/nWPdbhuhyUJ7YZWpi/RFoJ4wIprgh
   w==;
X-CSE-ConnectionGUID: BYXON8uORVSZghbpYP5mmA==
X-CSE-MsgGUID: kDtxhYAdQA28s6HnAJTjQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="95376059"
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="95376059"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 14:55:46 -0700
X-CSE-ConnectionGUID: P0QDMkqnRSC5kZRdZzFraQ==
X-CSE-MsgGUID: axbGu9KAQ9KVnqBtuLu6ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="231750897"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 14:55:46 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 14:55:44 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 23 Apr 2026 14:55:44 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.29) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 14:55:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CTiPcpmBxgtUMOG2h/p4dUnfPm3DtOayVomhdE9q+y1cqjwrE3e1hkIMGu5FSjY4btpyMRjRGpB2vvdSNEM0Rud7sVUcwOHzsK7XLtLKpu606Ax1GLqT5+vpbNe1XGwWfNiY710uyR4jHTJrP/UI8ygDIcHnV8E8WSEhh91r3jGgpyMgtBLHBgZ/5R0U6Cq/NdJBmWzcnTfl16UDBgqg6IRDS0y9aHKeWUhvwm4BVF1ZX7hUFuDi/RQ45/toH4BS8kbWE7eeNqGVBcXh3Pr/cAGPfVmh1RvEADPOueusApj78VbwSxMzq79VT17yadD8nTFHaOMs/BS4SPkcc1BYLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4tK+7TlqUmHbFV0vcMnC52l6yhLqq84go4eq12V55cU=;
 b=i8ZXCxB/5Z5X+MB7IlKdWm6iRGdPWuGzMNIywFBh5kTYsjmiihRrna4Y6e6JEoaWqiv+HGB9B1rwkbCPPyO4pT59BkA+pOfn9HdWBeK9PWNN2gWV9m14amQy70WNndFE1iUJ2+s7sytjBI8UKizbZaqzIxIMoe0Ik8nGO0yZe/OD82yB7lC7a68oQdw15W7g1PX51F4Ac8dyNxJVPu57Q+DGVwfu26VnHQqm54hCMCNkCCqIp9qndeHa1mbCi4tk5dt7ax2brgoK2fHPRoqXU5Sq36ECL/QQXGg9mlh/JhXhaA5hksSu5eL19TxdPIEHrLLZy/ZfEi13aOblD9pM3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 CH3PR11MB8702.namprd11.prod.outlook.com (2603:10b6:610:1cb::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.20; Thu, 23 Apr 2026 21:55:42 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9846.019; Thu, 23 Apr 2026
 21:55:42 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Xu, Yilun" <yilun.xu@intel.com>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "Gao, Chao"
	<chao.gao@intel.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "x86@kernel.org"
	<x86@kernel.org>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 10/31] x86/virt/tdx: Add extra memory to TDX Module for
 Extensions
Thread-Topic: [PATCH v2 10/31] x86/virt/tdx: Add extra memory to TDX Module
 for Extensions
Thread-Index: AQHcvgcsp3iEtTEG/UOFY+bW5PCg8LXr/O0AgAEHDQCAAFfSgA==
Date: Thu, 23 Apr 2026 21:55:42 +0000
Message-ID: <5d559320c86cc1371a39581c709e461c79582311.camel@intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
	 <20260327160132.2946114-11-yilun.xu@linux.intel.com>
	 <89bccca9a409e02667278fd83f0b7b9064557dab.camel@intel.com>
	 <aepLsi/cHnw3Cfgs@yilunxu-OptiPlex-7050>
In-Reply-To: <aepLsi/cHnw3Cfgs@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|CH3PR11MB8702:EE_
x-ms-office365-filtering-correlation-id: 0da96db7-3d8b-4dfa-fc32-08dea1831076
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: 7vYl+zOS7mwD7JshlvNS1IuuzRlzY1xQfITX0sYoFajLjpVd4GQF8KmAxAg0N1rIWOlRcMwcZZViJsLGH+S68eLBsMXAoQu1wTbhQvDDcmklVW6ACZOD6nXykEvnbjTMsI/BlWT/WO075V5k0qbp8848zW+hzAPxnpjDRLKkdrb6sf+4sZA87wbye4vxVaKcgJq+g5hYw+6axop83oz10JF6aEvlkA4rpdMoIUset/jJGY61XRSGm+lYCnBPl5BNgupWkeseJYPRJdBtKKh3y5xgVu8aX2Q8Sbc4ClL7uCVe/UEYGZbnVQJJEwc+kdyfvUgTTXwVLS63xMwZjsFs3WM/T/qWsnEbvyVvmyH1RaJYegylEX1tf5xGIeWHv0PurVgP2LJOW0SQz1oF4Scq4DZrSgSRRLBkjbvRIlfYUFSMJFbw2tOZ512AwN7TKfsMLlPIh6llTEeG/SKN0YoIN0zoS6Njx5hHjf6f4KLMVWh+uRVCEhiWeFDQTn0U9gVGS1qaSTGlaSiCE2JSQMD33pHK1L8SC4n0hLLXhAgr/opSgqUOy9LvfZP30sttCPjjcjeuyCsY1CT3jb6rOzutXVC1pjjWeyRmv9Wo2gtxo9K+VYYjNYYJaKX2BYWx3fWcTeV8kSWqDj+bS5Erf5I18QiQ03+kVtEYTHGCc65ybphab1fHcdwSqjN9dmW4iC/Fi7JwL0mlzynwl0gFfxDzChB7kQcyiZS8pQuEPlIFGvKifzT0AD3K5J83Bc9ssPEv47CN2CQq4wFDIV+Bh7na+9z9tFCJi4M7kJgprSSaJYg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1pJei9JdUVIU2FwT1psdTRHY3dZUU13Z1lDcnREQzFiSkc3K0puaS8wYTUw?=
 =?utf-8?B?NGdIV2lrRklZcW4xYU1QQ0hMZXB2aWg5aXp5N0wxQzN1OFZrQmwySm1zTXdL?=
 =?utf-8?B?WWZHdGMrUWUvSTdhek1DR1E1YklPa05DMk1jY0tINTZmZ01KeFE2S2xXcCs3?=
 =?utf-8?B?MDY0RWp2VTZPZ2VjUnpicStzTWhEb0RWaG1MdnBXVno1cjdtQk9TdUZ1VlJp?=
 =?utf-8?B?L0VQc1VwNUNqRWNkUDdWZitoSklkYjNtVFZ3M3lvYU1tZUpVR1NveU1yWDBi?=
 =?utf-8?B?clVTQW53U0FEMlJiZHo3TWZWL3ZIZ0ZaR05UVHRiSTFqbXdBbFFYU1B4MmJM?=
 =?utf-8?B?NytCdCs4cnBBR1RHK0hxbS9GZkNNcytNTUFHUm1Bcm5pNVZUNE00WWduZEEw?=
 =?utf-8?B?SHJxc0E4cmtHY1V1RURLVkhnVnBKNFhKTGZwWXFxM3RYRFZ4OWNNbGpablhQ?=
 =?utf-8?B?TGg5YmprWisrSUdXZ2Z3TElPcnVCbVlPb29ZQ0pxOC9SUVVxUGgzWnNZOVJP?=
 =?utf-8?B?TnNjbjdlbWpNWFB2MU80Wk9FRVpMd1paVVNBY004cFJueEUyRHlxc29Cc2hC?=
 =?utf-8?B?c2xJNnpVZk5YU2xqdjlkdjVRNWxHUHVOcEtCRDR5QWYzUFFHNTF0VldMdlAz?=
 =?utf-8?B?bk9obWZxbU82NHdrdHRWbUtNdkRUenZHdDNtaE9JTmpDa1VGaWxzUzZmOXpk?=
 =?utf-8?B?N09rUGF5QmdmdzRqZ0RQTFdPOVE1bEQ0emZVdGpjUXRhTEtoa2xjYjVFREVk?=
 =?utf-8?B?ZGQ0QnBRcUUxdDAxRE5mTndWNmVucWlPSkx0cHJzaEIxNzFvc01XWnlxWFhu?=
 =?utf-8?B?TkxFRUFCODJHckVKVWplaDRpcXM3R0VlblpVUjROL2hqUElMdGI2Z3liWXdl?=
 =?utf-8?B?TjUzOGIzR2JUaWQyd01EcUVwWDAzdk1IUVVUdzRQdHZSSGZIRGZSZW8yVll5?=
 =?utf-8?B?d25EOUpoTksvK3UzU0Z5YWJxWlkxd3Q1NjRnaHhodEZodFhKSUN1bDJ3eitm?=
 =?utf-8?B?ZndpZ2YwWG13OCtobzlWc3hQenJUR2JCVkVOTHR5K2tPT1poMU4vR2RTT3hQ?=
 =?utf-8?B?MVNJeDIybG5zQlh3SGNFajh5eWlkOVVCRTlteFV2dDdHUXUyblVydkE1Qzcy?=
 =?utf-8?B?SDhFS21QVXRRTkFmdEt5dkFSRHIwUm0zOVJXZTNrMTFMWk50RkRBeUNBL1VZ?=
 =?utf-8?B?eEFXVUt1TmU4V0ZvUEFLeVo4cU1VUUZncmoxNDd2SjJvUGM4cnVaTHp5ZDhQ?=
 =?utf-8?B?V1VFbC84RTJNNnhCSklqYVRqTzN3QnRUSmpNc2duTnZ6UFVMTWw4dWsvRnBH?=
 =?utf-8?B?WnZHU2NFcVBYdU1oTndxYWtYNU42bmdWa1JCNjVPU1htdGJUSU16aUxNQVZS?=
 =?utf-8?B?ajBvem9hVjJoWjVTNGN4QXVmdVdXR2JMYjhXQ2ttb1pLRTJGM3gveTNSM1Ju?=
 =?utf-8?B?SHQyMkJyZjE0SXVKSmdEb2RJbWU0ZS9FNUtiU2lER3NzRWxMb1hvU2FLaUIy?=
 =?utf-8?B?Yy9CWVVnRXViZk9vMm54N2I5OVExN0dDMGdtS2h4TGVDVm9scE40bzZkbDhw?=
 =?utf-8?B?WVNnR2l5UG9pZXlhNXZtWkFnOXhlSFg4N1JYRVJaOXNRTTA3a1BuQTlhRWl3?=
 =?utf-8?B?MHByaGlTVUw5aGF1R3F3VTc5U1EzQXhoeGFmUDZOQWZqZlh3aVBGSkFZaFJC?=
 =?utf-8?B?a2FpOGpOZDdJZzJrTzJwcm5kK3YyNTZXZE1BMjY1RHZLbVpCS0VobGcySzlK?=
 =?utf-8?B?dllhc1ZxYUUzR2xqd1Qza2dNcVZYZENmdXgrUWc4WTNTbFJhT1hPRFRlSTR3?=
 =?utf-8?B?NjhhTTNUOFM0TFZDTnh5NlZjZUxmbmV5cFFJUWxaZnBObkY3ODhjdWpmVVhq?=
 =?utf-8?B?anl0VUY4ZlVqQ0JBR1BnVk5LY2xvYWZoNUN6SlNLWXpkQ0ZieVBJYnQyWWll?=
 =?utf-8?B?SDdaOUVCWW5KQ2l6WGhkRlBMbXhEUVVURFdyL2d4dGFyYWFzd0VyaTZ2RG9a?=
 =?utf-8?B?UWJ5WkUrQ2dqeGNtNkMxM0RuYVYvRCt5WGFnVVRWRUdDVngzVU41eS9GVk56?=
 =?utf-8?B?K2gwTzJYNkxwL2ZhUEtNdkhYZHEwdDRFVUNwUkFCOGxUOW1ZR0hWTUJadTBi?=
 =?utf-8?B?c0hNdCtuelk1QWdjU3dIb1dzc3dwUElnc0FEUnI1WUZGSlZIRHZobDVkSTZR?=
 =?utf-8?B?NzBjbml0TmlHZXNVSXVJSW1BT3JPS09yaUEwQjhEUkpRMW5aeWdEZHltd04y?=
 =?utf-8?B?NVFpWFZSMHJvQkJhcHZLR3pZbTNCbUlYU3JRZ1BIUys0VjF2aVhIeGtnMzdL?=
 =?utf-8?B?YStXSFVHMHo3L3dQOGIrWFY3M2tWZUVJTEo0cmtzS2padXlVNzc5Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2942489993B2054F9C09F89374964A8D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: N5ljDAT70z5XPSz9MYQnEyaWh9u6iKf/qd6is0pQ6159D4y414GQG8YWrV26n1L58uN2zqcJZAaLub8O19oW/0Y52+m0qYvvh4XaqxsSpUyBgJ0c4s5kIFWWLNCSJoDdoSuCWFZvON0aEFroHw9FwdHU0sm4dC8hcGVhlA6fTo45qkOmoDgCHw5oRsOuuNWfxtsHqGwlb6nzHkvFjThXRJQscTywD32gI3pfOJDEIu0Hdsu3jTrT/K4rfmfvjVUmm/aQXrUg2bEvivDYvphxHuiP/THaro62spDp20ZnLK24lN4GcrWaBt+iRPVgLNMZHbSNxxbfCuiEtGN48pbDNA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da96db7-3d8b-4dfa-fc32-08dea1831076
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 21:55:42.2180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gVH9UZo6kzRZzfMLhFL0eubSE4XxjeSTZubfIhC86HwekwpcRlahH7nQUhri6DN3FvNsuG3poYGLn21xDKzxdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8702
X-OriginatorOrg: intel.com

PiANCj4gPiANCj4gPiBCdHcsIEkgdGhpbmsgdGVjaG5pY2FsbHkgd2UgY2FuIHJldXNlIHRoZSBz
ZWFtY2FsbF9pcl9yZXNjaGVkKCkgeW91IGludHJvZHVjZWQNCj4gPiBsYXRlciwgYWxiZWl0IGlu
IHdoaWNoIGEgbG9jYWwgJ19hcmdzJyBpcyB1c2VkIGFzIGEgY29weSBvZiB0aGUgb3JpZ2luYWwg
J2FyZ3MnLA0KPiA+IGJ1dCB0aGF0IGhhcyBubyBoYXJtIGZvciB0aGUgY2FzZSB3aGVyZSB3ZSBj
YW4ganVzdCB1c2UgdGhlICdhcmdzJyB0byBsb29wLg0KPiANCj4gTm8gd2UgY2FuJ3QuIFRESF9F
WFRfTUVNX0FERCBpcyBkZXNpZ25lZCB0byB1c2Ugb3V0cHV0IHBhcmFtZXRlciBSQ1gNCj4gdG8g
b3ZlcnJpZGUvdXBkYXRlIGlucHV0IHBhcmFtZXRlciBSQ1gsIHNvIHRoZSBjYWxsZXIgZG9lc24n
dCBoYXZlIHRvDQo+IGRvIG1hbnVhbCBwYXJhbWV0ZXIgdXBkYXRlIG9uIHJldHJ5IGNhbGwuIFVz
aW5nIHNlYW1jYWxsX2lyX3Jlc2NoZWQoKQ0KPiBtYWtlcyBlYWNoIHJldHJ5IHVzZSB0aGUgb3Jp
Z2luYWwgUkNYLCBub3QgdGhlIHVwZGF0ZWQgb25lLg0KDQpPSyBJIHdpc2ggdGhlcmUncyBhIGNv
bW1lbnQgc2F5aW5nIHRoZXJlJ3MgYWRkaXRpb25hbCBvdXRwdXQgYmVzaWRlcyBlcnJvciBjb2Rl
DQp2aWEgUkFYIGFuZCB3ZSBqdXN0IG5lZWQgdG8gZmVlZCB0aGUgb3V0cHV0IGFzIGlucHV0IGFn
YWluIHdoZW4gcmV0cnlpbmcgdGhlDQpTRUFNQ0FMTC4NCg0KPiANCj4gPiANCj4gPiBJIGFtIHdv
bmRlcmluZyB3aGV0aGVyIHdlIGNhbiBqdXN0IHVzZSB0aGF0IGhlcmUsIG9yIHdlIGp1c3QgZ2V0
IHJpZCBvZiB0aGF0DQo+ID4gaGVscGVyICh0aGVuIG9wZW4gcmV0cnkgYnkgdGhlIGNhbGxlcnMg
b2YgdGhlc2UgU0VBTUNBTEwgd3JhcHBlcnMpLCBzaW5jZSB0aGVyZQ0KPiA+IHdpbGwgYmUgbW9y
ZSBjYXNlcyB3aGVyZSB3ZSBuZWVkIHRvIG1hbnVhbGx5IHNldCAncmVzdW1lPTEnIGluIHRoZSBT
RUFNQ0FMTA0KPiA+IGlucHV0ICdhcmdzJyB3aGVuIHJldHJ5aW5nIFREWF9JTlRFUlJVUFRFRF9S
RVNVTUFCTEUuDQo+IA0KPiBJJ2QgbGlrZSB0byBrbm93IHdoeSBzb21lIFNFQU1DQUxMcyBuZWVk
cyByZXN1bWUgZmxhZyBidXQgb3RoZXJzIGRvbid0Lg0KPiBJZiB0aGVyZSBpcyBjaGFuY2Ugd2Ug
ZG9uJ3QgaW50cm9kdWNlIHRvbyBtdWNoIHZhcmlhbnRzIGZvciB0aGUgc2FtZSB0aGluZywNCj4g
dGhhdCdzIG1vc3QgZnJpZW5kbHkgdG8gT1MuIEFuZCAibm8gcmVzdW1lIGZsYWciIGlzIG15IGJl
c3QgcHJlZmVyZW5jZS4NCg0KSSBkb24ndCBrbm93IGVpdGhlci4NCg0KPiANCj4gRm9yIG5vdywg
SSBjYW4gc2VlIG9ubHkgb25lIFNFQU1DQUxMIHdpdGggcmVzdW1lIGZsYWcgaW4gbWFpbmxpbmUs
DQo+IHRkaF9waHltZW1fY2FjaGVfd2IoKS4gSSdkIHJhdGhlciB3ZSB0cmVhdCBpdCBhcyBhbiBl
eGNlcHRpb24gYW5kIG5vDQo+IHJlc3VtZSBmbGFnIGFueSBtb3JlIGlmIHBvc3NpYmxlLg0KDQpS
aWdodCwgYnV0IHRoZXJlIHdpbGwgYmUgbW9yZSwgYW5kIHNldHRpbmcgJ3Jlc3VtZWQ9MScgaXMg
ZXZlbiBkaWZmZXJlbnQgZnJvbQ0KaG93IHRkaF9waHltZW1fY2FjaGVfd2IoKSBkb2VzLg0K
