Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B4C3B3883;
	Wed,  1 Apr 2026 11:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775043766; cv=fail; b=W96VSiXpQWrSblglvLabbLRQgyGXTRpqNIaM+Qm1DDttfmMlbMaDghUtgpxhq+R1lkKqApvnEGL7pvpVcxT2YdTVyWcALZhCOM6sSSeRxJT66C/+OH3m6/Bnkk/KME7thGu7LzCJfacpL7cH3Mlf3j2+52Y/fhjaJQk0NF2R8Sc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775043766; c=relaxed/simple;
	bh=D8XQa1t29YzbPhBiGs6AsWjIbeTjnmMm2bs5HPN9o6Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BCgGCwFDm+EXUFlQy6PSu5iWggJ04KmMMdAMjqax3/PV7pQ0l3+CvQYJ2E5z6YE9LJV501LwHWb88h/q7otYL6vh5OnvJOi314O4Mzw0u6WeWsOaHYhx7dHzbAi9On0tLUObuRVT9nsr84rEeR+5v30D55FpziQ+7c7S9m5Dus0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NvsPVjPV; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NvsPVjPV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775043765; x=1806579765;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=D8XQa1t29YzbPhBiGs6AsWjIbeTjnmMm2bs5HPN9o6Q=;
  b=NvsPVjPVR2C3xxC1pMKdmtjgOUPsmL0y7ipmZytxU6jhNIycU1D4+WSR
   Az5b/YZgnxhVa7zVW5M3Y8FeI3XfbKHkV7nr50u94RF/DOBZ/LIa4fM6G
   SuqrfymEnFMcTvqyXeaXokrjA+3NnDL9QqmmBPQ8t3sJ0ES834zxcLckZ
   TXF09odXePPTlY4zgP18QRvFzIha5njIJAxkTgarWJnPJ6BVubTYYW1D9
   H5fldCvaBK7L5LgAxcSog0VB72mlL8h6uvGu3bzws1piGE24eD+qNZ2a4
   15yL7Z+6hPqREGmlcAUxYe2IhUKxHz0c5Q09UwCa5rLUaqy0bLNDwxIHG
   Q==;
X-CSE-ConnectionGUID: bZ+T5qdYQ/GCrsz6M2OxKQ==
X-CSE-MsgGUID: UIlXulafQaylcd20rrQxYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="79933789"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="79933789"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 04:42:45 -0700
X-CSE-ConnectionGUID: cdkhXpygRsenjA+IDH3I+Q==
X-CSE-MsgGUID: 1/xNYn3cQ9e/MUUd1T+HBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="249872215"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 04:42:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 04:42:43 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 04:42:43 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.30) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 04:42:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=elOvLqZzEoQLYqAr5VhkPkahPjdCeJG7iJ1m+GQpKoO6hYiEZRo0vnM3B6wr6ZeGy1gvKDE5v0Ds+JxNzw1Nh+yKyjBXabfuPXuwpgfLxXr+e/ElEH1r5C6v/Uh9xkifyCUNB7c1GUxNuciHIuN0Cz07KpACWExHUUXbfv5I8t2FH8pd1mFy7ks+RTftkQnBPZTAAo6notPZmsQyp1sZesw79uugqUMb7elRU/+FWACpkGyBsF4IJd7saMmlKZlJcJYPcdXSQf1m8D+IXXRqZN5dUvWW/uA7Rva1AbSdiEGthkIpxD6i9KU4zlmFEU5jH0g/WHyKddexAQ6OfdQ6MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8XQa1t29YzbPhBiGs6AsWjIbeTjnmMm2bs5HPN9o6Q=;
 b=KXIS7+SKLlqDOY+j/B/5BApN461f4iFuTdCQaIsnxkuRwlJjXnQovPWwxdajzKq5WrnxSbDKlVMgie8HAQaizzkK1PjlcV5x+W6cfyVjtdaN1zfj6JJMTzsV/mEpPisK/wwoVGLrWb0qATRlBWnonuKmdBfEk+UrU06XsXzhfloa3JNKvLy1CnSLOIMG2wgFPGi5tFRWcmF2IxsfyWGNCs5D96wNF4pRaBqbPOUUiPNKQGFV0+/cZTY0zzasiCWGUG+wZhPUK+kgq/yF90GBYUOBZ0m6Q3S9PwqVN3M0HPzlpxXLSNZcR50tbvcKM42oWdDguLOxI3LBWxCzODhz5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 SN7PR11MB7138.namprd11.prod.outlook.com (2603:10b6:806:2a1::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.16; Wed, 1 Apr 2026 11:42:37 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9769.004; Wed, 1 Apr 2026
 11:42:37 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>
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
Subject: Re: [PATCH v2 11/31] x86/virt/tdx: Make TDX Module initialize
 Extensions
Thread-Topic: [PATCH v2 11/31] x86/virt/tdx: Make TDX Module initialize
 Extensions
Thread-Index: AQHcvgc98Is38OpLIkO/aXISJkcG77XHvPSAgAEEoYCAAVuggA==
Date: Wed, 1 Apr 2026 11:42:36 +0000
Message-ID: <124b776006fee36e4a242f58bd4e128eae97c505.camel@intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
	 <20260327160132.2946114-12-yilun.xu@linux.intel.com>
	 <5cbed31cdfcc7e43f283abc275848370239a3d40.camel@intel.com>
	 <acvhD/XeCbB4ea0C@yilunxu-OptiPlex-7050>
In-Reply-To: <acvhD/XeCbB4ea0C@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|SN7PR11MB7138:EE_
x-ms-office365-filtering-correlation-id: 34c31791-8bfe-4973-2f8c-08de8fe3c599
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: bOeK2NLPC6LWtmre/D/lDCTuB5SGl5lEY/sNsqoXapl9z1PxWecO4IUFK/x+u7AO5tNXZY6nIQM79LD9nCeRqN+3dXQnr/PBuKfZHxbEi+7XuzJQsCX0yef3NJ3rBtdUcgoplr/FkR9RpCcBP8NRbCR9t9FlN7PIlUqfbsDdqdc6gXZ6wo6fbvsJ0iQvROWqDHqLGqW0yGHWvxb3Pd/0An1yvqd4jXOivy1kJikzNPrwwPtW08m7dIhBhy45/sYMJPpRLPEIDkwAIVe0tOZYlmATNKW7l6f75jglAphmkWBJm1AOv2VlE6NYefDX+18wyqH9fJFeyrEPhY0myJnjdGSVpQvx+TDQN1cYG9jSq/xqLzNYd6esgxlByK/QKp5/pN6niu/BCzfedsDi9R9CWoJuj++n9GJKTEBnHK+YR82mcU5ebKsDF9VUkbsQIc2Jc5t0EMDH+rol6bNeXJ4i02vwtk+LHrT95oOSy6sKVcRfcVNNxvcuLSqOOCR2wHZFqjPW/BGUZJh1ao14E8eZS33US4bwnGxh8HkqbAjrAZxHZPA0WOu9wmAURaku5YJ0hYN8QxHr4DjOP8QLCi2nUlsMbLRHfETWWAUulTrFe7TgzrXRRemvDI4Js5+qi/3yuIcwcVka7Tu7GlzVgxPaXBD7tCbP3mrz61gucmsg3EkE+crxxqM7FxY+J1EXLPpL33rUMRYjH1kY7DsSzbmBDuBJ1MtGhX/6m+5pYOz8wFRlu0/Es1crAhmlGcDhh1G3jn9HoWcZgBS0Hq8aIlkipdfo3FwNH32BGLf7mi4HAVw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHhBc1NUemdvTEF2cUZPL1lJN3Y3U2R1TERISEt4cnYxdVdkTkJPUmREdWlw?=
 =?utf-8?B?S1JDeDAzamlHL0ZpRC9EN0NRN1ZQcHhUUDNvQWMwK1RxOHRKVHlzaHQ0N29l?=
 =?utf-8?B?SjlVN1JBSk1tUWdBbWlHdUdzWUJyc2UrVDh3bnVxL1NlVVliK2g4Wmd0N0N1?=
 =?utf-8?B?SzExRGh3YUp1Ykxhc2M3b2Y2aEhYc2lnVEhZWThDTFlVTGhvd3lFMDhpakxx?=
 =?utf-8?B?cm84RGRFNlkyNnBFNjdSRzgzNUt1KzJCTm40ZTFySXRaV0dVdlgzaFJPemV6?=
 =?utf-8?B?Qyt3Z3FLU3ZvYkpIa1J5TG96TTQremIrNVdaWGk0VkZ5SVhES0pxcG1hQ0t0?=
 =?utf-8?B?MWQ2Ym9OdW5LVURWenZyUkRtcHJQU3g0RGVmSHBmWkovWlcyKzFlbE5oYVdi?=
 =?utf-8?B?WXg4NU1GRkFQQkMyRVdDdkQ3ZVh1anZBSGhsQnBaZDVyaXhuSGFGZDUxQzVw?=
 =?utf-8?B?T2V4MVhtVXpiR3Q4bDZaUURudnM2azFzbjdSNTArdmtrcFVaUy9mbEl5cVJO?=
 =?utf-8?B?dDNsMnZjQjVrdWR4NXNlT2xtNnVjc1E2eWg1QTRJTHVQeklpbmg2eDFPbkg3?=
 =?utf-8?B?c1MvUlBCNlZlS3U5RWdhVjZwbDk4dCtPbWpyOFdoZkJ2TDM3aE1VTUdyRGc3?=
 =?utf-8?B?UVdEK0NXWkFCWlRpdkp1WVppQnUvNzZwZkgxQ0c2L3REcFM0RSt3UkdZRGFJ?=
 =?utf-8?B?Ti9kU1U0NFVtUVhGRFBFejc2VGdRQmdWNFJ3U0JjWU85VHQwMHd3bVp1aFBG?=
 =?utf-8?B?RFlXOEFnRm5KNHdjeXNsSGt6VW1mSnpkZ1Y3S3ZyaFlrTFQwQis1NTZxYURq?=
 =?utf-8?B?VkpKNnJ2eGl1a1lXNENydVk4UHZ3dmJFTzlwWUdWbmRzWTB4R3pXNGx0SjlR?=
 =?utf-8?B?VThKQjFsN3o0bHk2YlN2RlhreGlUNWFUM2dtMEZ0eldCclZUa3pocWN4ZE9D?=
 =?utf-8?B?cTE1SG9sN0w2Y2xuYWd3bzRaUjhTK0tjMWwwajNpelEwM2RxYjhpUjlaelVP?=
 =?utf-8?B?clZiQW9RNlozd3lKeGdSaURVUXRZU1p2NzZENkUrTlZMN2YrNmQrM1Nzekx6?=
 =?utf-8?B?aHhxeWNwVVVlZG9JRWVIZlM4UUZzMGJ0TGR2VklQaXVXZDBuRWNZQkd3bFUv?=
 =?utf-8?B?RG5uUlN3TUxib2hWSy9UZHFTNXVKRVNzNGFpRFpITk4rYnE1ZyttMllZamNx?=
 =?utf-8?B?OGxHUDl2bkp2ajFqRno0cG5HMU1QNVJEWDVScDlETkVlWStURW9XWUNGd3Js?=
 =?utf-8?B?aUN4WTBTOG43MzFUK0N4bjRjTkZTa2FmOXh2YjNLK0FFU3lJd3V4Sm5ZTjA4?=
 =?utf-8?B?ZWsxZ0lQM1ZWYTkvRzJ0V2RNbmpwQjd6Qnd3MVJ1U3M2cjdEUmRrT3R0TjVH?=
 =?utf-8?B?dUxUQnd4SWw1bjBIRkdFb2YzanpwKzFjeEZOOXdhWVNUcDNVN3Uzc0IwSzRP?=
 =?utf-8?B?SVFrODhQOTZPMllSN28vK090SnhCUkJRWk5JNXFFK1g4aXNJcDdONGpPNkVR?=
 =?utf-8?B?YnZvaDlFQjhvQjJjOG1lUzNRby9pcUdqbis4Q0I1bkN5Y091V0Q0NVJDNjUx?=
 =?utf-8?B?cXJJMGJZRnlvYXc3QStFZ3luQ0t5Vm9aU2pyQjJIb3hwZUNEdVJtNVlmNEJ4?=
 =?utf-8?B?bU4vanI5RitQU3RVMVdINzVSVWM3U2NWbUNCUEFwS0RQbm8yQk1KaE9NcDZt?=
 =?utf-8?B?dVJZUy9vYkNRamxPbXBsek5HRTBDcFhobEtIbFpTUUtqVk9VNmN6NHdHMHUw?=
 =?utf-8?B?SjFVWmhucStnNFVTY29pRUlBRHZLUllKMHIvUHBlbnk0ZW1nOVZIZWZZVjB2?=
 =?utf-8?B?K3BicDBDSG1JSDN2Nkw0OVRjR053enRwZmYwYVpQdTVGMlhXUE9UbVk1b3hX?=
 =?utf-8?B?Y1lXT0dldXpxblRsKzFwRzJ1NFAvV1V6VDZ6Vmw2bS9MUWJHV1MvQzFTcWZ4?=
 =?utf-8?B?MWovcU5SWjIyYUNIZ1F1MDRRQkxkR2QrTjdSMG4vd2Nhd2hyTTJIOVVjOFhF?=
 =?utf-8?B?ZCtqUnJMWmY0V0paY01ZangvVm1qbFhZYXA4SGFSNEhqWTZRTVJseDNnb2JC?=
 =?utf-8?B?NXV0djhvQ2ZOZnhIMWpNWWV2NFQxbWJOR0R2REF1b3Y4QzgyMHFLYXZJMGZv?=
 =?utf-8?B?aE9hSjNLRGE0V3VyZkVXM1I2Z3Z5c08rRmVNWEM1OElIMkszSkFjUDErRU9n?=
 =?utf-8?B?SHpnUEMxdWx0NkV4T3c1dWVIMWswenBoVTdleXNTeXF0YTN2REZZRWVFRkdD?=
 =?utf-8?B?Z0UxOFVud3AyNkhqWlRzd1F5RjhmRzNCa3ZvS2dUNnkxQ2NCSTMwaDdQQWpQ?=
 =?utf-8?B?Z2NlbFdVRzZReHFXdStqWEpadDBKSUduQTZjeDhpLyt4dlJ1TmU1QT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7E1C94661C6A045A8C4C00E70710F31@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Bnf6pkjMnhC2lCP4QIaMXVG9PTXmlZzxJmgOj1hH9L8Xlpt3sQW9Yhg/LjuFvQPjjL7DIgZRiDHlbrU9JwrkD0RmibxILfBFwUW5wFkDw+BFlRWO6uiKvadD5+Vn/BR+VBToGBkWkqQHrqd4SX7BMn4OrXeVNDoYicLHXablDCNbY2tx0JbdGmOfW7+0BD+rgHkVOdWgYUDo6wAnhmMSclAAOn4f+37OThThfjOlCoI3ngOebex9q0bCj3sfmQ/SOjeg3H/1ug+B9VnYsT8mybd1C5yqAGhSMSuEHGZxxvaBXQQNz89O+DPD1Xn5pyxpeFn9rpA4R30yiSBvc5Ymqw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c31791-8bfe-4973-2f8c-08de8fe3c599
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 11:42:36.8415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x8/p7f1TSqLs9row7Z+sC2QZ80GjM8Xv78L2ZpWZ+828AcE9YGJ3ryovTBIpmtfBGDOfbCVQDBHbGwO9Dzhx7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7138
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTAzLTMxIGF0IDIyOjU4ICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gPiA+
ICsJLyoNCj4gPiA+ICsJICogZXh0X3JlcXVpcmVkID09IDAgbWVhbnMgbm8gbmVlZCB0byBjYWxs
IFRESC5FWFQuSU5JVCwgdGhlIEV4dGVuc2lvbnMNCj4gPiA+ICsJICogYXJlIGFscmVhZHkgd29y
a2luZy4NCj4gPiANCj4gPiBIb3cgZG9lcyB0aGlzIHNjZW5hcmlvIGhhcHBlbiBleGFjdGx5PyBB
bmQgd2h5IG5vdCBjaGVjayBpdCBhYm92ZSBhdCB0aGUNCj4gPiBiZWdpbm5pbmc/IEJlZm9yZSB0
aGUgYWxsb2NhdGlvbiwgc28gaXQgZG9lc24ndCBuZWVkIHRvIGZyZWUuDQo+ID4gDQo+ID4gSXMg
dGhlcmUgYSBzY2VuYXJpbyB3aGVyZSB0aGUgbWVtb3J5IG5lZWRzIHRvIGJlIGdpdmVuLCBidXQg
dGhlIGV4dGVuc2lvbiBpcw0KPiA+IGFscmVhZHkgaW5pdGVkPw0KPiANCj4gbW0uLiB5b3UgYXJl
IHJpZ2h0LiBJdCBsZWFkcyB0byBzb21ldGhpbmcgYWJzdXJkLg0KPiANCj4gSSBjaGVja2VkIHdp
dGggVERYIE1vZHVsZSB0ZWFtIGFnYWluLiBUaGUgY29ycmVjdCB1bmRlcnN0YW5kaW5nIGlzOg0K
PiANCj4gwqAtIFREWF9GRUFUVVJFUzBfRVhUIGJpdCBzaG93cyBFeHRlbnNpb25zIGlzIHN1cHBv
cnRlZC4NCj4gwqAtIG9wdGlvbmFsIGZlYXR1cmUgYml0cyBhcmUgc2VsZWN0ZWQgb24gVERIX1NZ
U19DT05GSUcNCj4gwqAtIElmIG9uZSBvZiB0aGUgb3B0aW9uYWwgZmVhdHVyZSAoZS5nLiBURFgg
Q09OTkVDVCkgcmVxdWlyZXMgRXh0ZW50aW9uLA0KPiDCoMKgIG1lbW9yeV9wb29sX3JlcXVpcmVk
X3BhZ2VzID4gMCAmJiBleHRfcmVxdWlyZWQgPT0gMS4gT3RoZXJ3aXNlIG5vDQo+IMKgwqAgbmVl
ZCB0byBpbml0aWFsaXplIEV4dGVuc2lvbi4NCj4gDQo+IFNvIHllcywgSSBzaG91bGQgY2hlY2sg
bWVtb3J5X3Bvb2xfcmVxdWlyZWRfcGFnZXMgJiYgZXh0X3JlcXVpcmVkIGF0IHRoZQ0KPiBiZWdp
bm5pbmcuDQoNCk15IHVuZGVyc3RhbmRpbmcgaXMgZGlmZmVyZW50Og0KDQpQZXIgc3BlYywgdGhl
ICdFWFRfUkVRVUlSRUQnIGdsb2JhbCBtZXRhZGF0YSBqdXN0IG1lYW5zICJSZXR1cm4gdHJ1ZSBp
ZiB0aGUNClRESC5FWFQuSU5JVCBpcyByZXF1aXJlZCB0byBiZSBjYWxsZWQiLCBzbyBJIHRoaW5r
LCBhcmNoaXRlY3R1cmFsbHksIGl0J3MNCnBvc3NpYmxlIHRoYXQgb25lIHBhcnRpY3VsYXIgZmVh
dHVyZSBvbmx5IHJlcXVpcmVzIGFkZGl0aW9uYWwgbWVtb3J5IHBvb2wNCmJ1dCBkb2Vzbid0IGV4
cGxpY2l0bHkgbmVlZCB0byBjYWxsIFRESC5FWFQuSU5JVC4gIE9yIHNvbWUgZmVhdHVyZSBtYXkg
bm90DQpyZXF1aXJlIGFueSBhZGRpdGlvbmFsIG1lbW9yeSBwb29sIGJ1dCBuZWVkcyBUREguRVhU
LklOSVQuIMKgT3IgcmVxdWlyZSBib3RoDQooc3VjaCBhcyBURFggQ29ubmVjdCBJIHByZXN1bWUp
Lg0KDQpXZSBjYW4gc2FmZWx5IGFzc3VtZSAyKSBhbmQgMykgYXJlIG5vdCByZXF1aXJlZCBpZiBu
byBmZWF0dXJlIGlzIGNvbmZpZ3VyZWQNCmluIDEpIChiYWNrd2FyZCBjb21wYXRpYmlsaXR5KS4g
IEJ1dCB3aGVuIHRoZXJlIGlzLCBJIHRoaW5rIHdlIGNhbiBqdXN0Og0KDQoxKSBJZiAnTUVNT1JZ
X1BPT0xfUkVRVUlSRURfUEFHRVMnIGlzIG5vdCB6ZXJvLCBkbyBUREguRVhULk1FTS5BREQNCjIp
IElmICdFWFRfUkVRVUlSRUQnIGlzIHRydWUsIGRvIFRESC5FWFQuSU5JVA0K
