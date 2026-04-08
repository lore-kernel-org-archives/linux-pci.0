Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A823B39B49F;
	Wed,  8 Apr 2026 08:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775637201; cv=fail; b=dTRlqM7P/QlgBHRRbuqh2ybm/hzW4/BXACxbb8HZVECgmjLZwJ+39iX5B+UklTBJoFpL9sVQSwAGG/ga5aaLAL5OiLo78cp6IIlvUr3qThUe+DPJU8sjJnHytHAFlAxFcZRon+y64AB/UJ30vuONxixKcDyTFfnbr03Xwxl1ssE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775637201; c=relaxed/simple;
	bh=8haCEBcKsIUgJMKeEtims6IMnORNw9TtxvWMBTDw5PM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=db5fMShyPEaR5va8VMj4XbxTpvn1q1ttCROXCHg3MZ6G31cOMBgDfgliH9IVDOc4dHvmJfoBiTkV3ppexu+vsqqFab214pDvqN1pTWb/mNSGD0TktfMwSC0T7fDqVEyMpyERFy14OQibZkFQczvzvYRL7VpFAi33cwCf4McXZfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dS87TM78; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dS87TM78"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775637200; x=1807173200;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8haCEBcKsIUgJMKeEtims6IMnORNw9TtxvWMBTDw5PM=;
  b=dS87TM78hhVW/5xYXSmhL7h0/AZZRn7KzFxCGKncVIJpHEUltKmk7Ol+
   4QIIz3QpHexaqNYrB6HNE5BtuuMiO7Kpl1JJX1h677iFBXHDUt090dwBV
   ST6lI8OF8JixWYvwBEPLgDGXF09XqdlFqE06udezrUZnHvgAfbI+QUjO4
   J7eY/pSXoCf8pUjisEYlTAzyrHd3iZ7dJ6RBWDX1w3rs8m6kgVC1u8cuT
   s23lZ4p9X0HWOwPeJPcMQR1RrLVUnZv0UB1AFjt3jJQ1DtJEWnunQQNCl
   Bd50k6Xno20BrUdSFLCpNAf2X+f1seY9xwj/GMTe+KpHKrWffy5CufcWl
   w==;
X-CSE-ConnectionGUID: ym1+4YxTTkGIu89oTp6V8A==
X-CSE-MsgGUID: k4bR8JVRS/iYcr3cuLSHig==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="80207877"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="80207877"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 01:33:19 -0700
X-CSE-ConnectionGUID: Xc0MthXqSbiF/fT8CQTslQ==
X-CSE-MsgGUID: H6NRbbN9TtC0w6BUAUpfWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="232447514"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 01:33:20 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 01:33:18 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 8 Apr 2026 01:33:18 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.51) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 01:33:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQJCbf7YiP59645HlFQRficQVgqKjWLVjNxkXmhuHdMaY4vEmn4Xhiru5tiSHK2vrhCkk48JIM7tLzGldY2qNK+OEdA8scNkioqfO8DH+9BZUI+w1DCdTQfwLnIaf8ixPB5xEyIClV2bPWIKI241I4SpU8GzEXxH/KoJqefLJMidzJuGS60FzX/1cD0XD4XB8zICYE0Kf0zsiPOiFtuz6dFFwW4EmktbxgU3UEE4Dwiky5rG2TaEUNK+fNn7pLoI6LOsKpDgYKj52l47m46eM6U9wJfo9Fwu3idoU4TMqZUoeGS1CeXSYvivCTuvFXxUTA66JzZrsZkPubJfMyJx8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8haCEBcKsIUgJMKeEtims6IMnORNw9TtxvWMBTDw5PM=;
 b=JiKjbhk5jIBUkrE9/jYBdsGgZj5Ss9fzFn94/tNgtauSwJKMoWPmPoXEjjPT3JQ9KSFO83mDsdakPHq5SgEofe5i+UlsQ4VOAmlEjlpKST/nCfCymnJ4acL9Y5vdrYa/dmzZCfcBfNBLRb0KLZH0zgkZUKtyzIIMrm1fwJG7SxzRHFB358bBAJ7aitLLs1ASMDeAMcdujyReNb/eK9411cRrYcyuWlovZ8dSs3Cv9h9n3HTi8R1jxqPWX34u0S2mwP5EeJ8YkDJn4ScNM52yyPcQO/jW1J+n3Jphg0q6noVH2hfbwuQx8B6FH03VoVVY0QKb4rMVnm3DBPd/zjoW9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 SA1PR11MB6614.namprd11.prod.outlook.com (2603:10b6:806:255::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 08:33:16 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9769.004; Wed, 8 Apr 2026
 08:33:15 +0000
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
Subject: Re: [PATCH v2 08/31] x86/virt/tdx: Configure TDX Module with optional
 TDX Connect feature
Thread-Topic: [PATCH v2 08/31] x86/virt/tdx: Configure TDX Module with
 optional TDX Connect feature
Thread-Index: AQHcvgciEO9ja9+YTEeNEsKQg5wh6rXKBFOAgArNuQCAABaSgA==
Date: Wed, 8 Apr 2026 08:33:15 +0000
Message-ID: <ce5c435dac51862db0d0d8307bcee075b900a5ec.camel@intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
	 <20260327160132.2946114-9-yilun.xu@linux.intel.com>
	 <d563b85664271c4d8510f66222c8a05d77d396e1.camel@intel.com>
	 <adX/2oTOsiigA2QI@yilunxu-OptiPlex-7050>
In-Reply-To: <adX/2oTOsiigA2QI@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|SA1PR11MB6614:EE_
x-ms-office365-filtering-correlation-id: 93f8268f-cc6d-41c7-e688-08de95497ab7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: rNPMFOWReNtCjk/chiGeMpus1s+gnXM8kng1Mv7fAji811t1TPGFLacUHEV5ym8IdtfIUoAixnEz6MJrxYAVLwiNnWtLUP3k0KFkDSmraoIeRbqSwXjh4jDGpkhkeJMCFauQaiCF6KGzeQugIyZOjomYK1ATJg7g7DFt1+luunaFRAxDrFRwC4dXco29dmrfKpaiVU01JP7i2pm/koGXwW+wq60x3mAwfF1oNC1DtKJuTEONLYoOewzrA4UCbiAzbHrJmkZxHH26VevzE69Du2Xg+BlzTR+LKzZZtHkwX7chtzdJxj1ur7oxuXE/z9ob7wUghnqSNTmIS241FooKa3oN+Det5rbPULGJIELEETc3k0fF85EvXcg615/mNkx4ZmVAZ41fNj1OP77GhwhyoC1YnXBYS8GyjO8nE5rAUf64NOVobzEs0qycuzlKSaLo0CZXkk49TQfH5QAg1RewJ4Qy4PhSavZIm8+f1njjquUghgP2PJEBJawXcVcYzjqU0AoElipkJoUk/jg509fBK/D+5euaUu9FsDYnOzfPMUh3wIcXqtGxJW52BmmB2xG3V6zhfEzImefl6YRqyZqUTSb3OpgOknX+tQWq9UpTHP4MomY+JugR2zVPl1MjIaY3McISfenoOLYDgG2Pvg+Ki18+qnC4J6L9PbI7B0aWHkCu5SqBr7EkL6B9MecwTrgMn15CgnY8zuYBLeJNyG88BBddzY3IVBTfnxn6GEm5N/WSQIHeN0EBfR2BwvGzPcKG8mnqLAmKwH1Q/HviiXqXoCUfyduYvQ1KSctiPhWGU/s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0laRmUzRys1MitJR0RLY3NiS1hqSDhxZ2FwNk5RVUM0aHRIZUtZS2VjeDV6?=
 =?utf-8?B?aXE2eVg2UFpWaFNBTjNLYlFBcUY4a2JGYVY5YTJrbEtTNTlpelFCby85OERu?=
 =?utf-8?B?LythUG84YlN3alQ5UEwxYXJPZDdCYUl3d0puamhrN3p4amFGRWFPTU5ONVhz?=
 =?utf-8?B?NlZHL1hqdlUxZlFBYStVdGZCbXpJQStsYmFrZzdjNDVnOXFnSTFNOEF1UnZP?=
 =?utf-8?B?blJOYW92RWZtczk3RjEvaGpPNUN2ZStkUXVhVVo0b2FIYjZEV0FYV1lNbUE1?=
 =?utf-8?B?ekt2MTZzZ202cnJtWi9nK2ZZWU9ub0d2dnYxL1dHdWZuM1ZuZlU3R1FPQUFO?=
 =?utf-8?B?a2Q3czl3WG9RQ1RQV1B2ME9UU3FqdGU1bVhXNzNFSW5FZzBmdXNPSWV2T1lq?=
 =?utf-8?B?WWFmckJlUkhBRUd5S1RnR3Fjb2pmTUIzdmYyUzZncHIwTkN5dnRLT3gwSU9O?=
 =?utf-8?B?T0tZUGczWVZvbFdIRWt0M2p3TVQrYkhGdGZQelIzZmsxZm1kY1gwT1R1Qk1n?=
 =?utf-8?B?amhRNnFWY2J6LzRyS1l3REtGTnZUU0ZsbGtGU0RMSnZrNDdVYUp0dzMyYWNt?=
 =?utf-8?B?ZlBlMkFuZlF5VVdVS080RTVsWXpiSUlvMEl4TCtFcWtkMlp4RGowQzRCd1JS?=
 =?utf-8?B?anMraU9rN2dXSXY3blJnUkZ2QkpKd3lBYVFIL3ZjemQxL09jaTdLVFFFSzl3?=
 =?utf-8?B?eVZtelJpRHlFMlViUXpJQjl2OEFSR0ZJMkVuQzIwUlVTMHd6WHlGRk5sUWtS?=
 =?utf-8?B?S2ZkcERSVFYxQ0F0c3hvY09QdkV5ZjlEVUwwQWJ5cXhOQXYwNndkZ092M0sw?=
 =?utf-8?B?dWpRNXRaMUhLakZueWdqU2lHOCtJUktqZHpWaXZZMnpsQkZ3UmVmV29jcEJk?=
 =?utf-8?B?SHJTTjA0aVJiSzZIY3dYN1k0bnNLaENNcTB2WnZLZHUwTjFKVUhzNlF2Y3cw?=
 =?utf-8?B?MXVFT3h2M1RlNVZwa09lNHFVa3NZTjR6Um9TR3ZJMTB3N04xM0FYVGtsUUs0?=
 =?utf-8?B?VGRIZkxaNXMwUkxsUmh4SkxOdHVNbDhTMkdmSndqcTA1dVUvZ2xQaUxtbnFy?=
 =?utf-8?B?ZCsyTE5oVkRJMlZGaDJvVW5mOC9hSitjWFNCckQ0SU8vNXMwTmhabk5DdjFs?=
 =?utf-8?B?SC9YRU9IWk4zZUNyYStWQXhDL3pjVG8yNzhqcVBxeDJxTFYzNFhnK2FJN3lF?=
 =?utf-8?B?ellnNytmaDNCRHY5R09pUFhsUUFQWDBFZnkzYnlBVExvTW5kMGwrTGJwcXc5?=
 =?utf-8?B?b2sxdUwydS9HLzM4RTl6VE5HVVpKTGcrK0hVY3VxUFREUXpvcytKbDRxcnNW?=
 =?utf-8?B?RXV4WmNVL1g3VCswd0FVRHQyb0N4QmFjSHJWd3orZ0tneGpvZE4zdlVYZSta?=
 =?utf-8?B?dUdZM3BGUGZ4QVBjOW4va1MzZ1pUR3ZtclZXMHJWTmRDYWMxcndzdnV1Umt4?=
 =?utf-8?B?OER5bmZ5TWo0cy9Pa3B5ekN1VjhVMVFUQ1VGaDNHNHdMQW0wYUFSMnpYMHU5?=
 =?utf-8?B?ZkV4YWVzYUc5RFZtbSsrZ3diR29nV1ZnN3BmaS9aL25qQkhxY01pUWZpaUVo?=
 =?utf-8?B?dWVZZFpxVzRiOVZuMElLVWduNG1BMUxzV1YzSjAzM1RYZFVXdXdVY25CZkxp?=
 =?utf-8?B?S2pVK3pYZGtOTURTZWlka0xUejhrV2YyakpENHdsZVh6VGFGY2JSNllvMHhD?=
 =?utf-8?B?RjNoNmVqVU9uYlF4OUQvcy90eWlrdktsOUZDUjI2SzdNdzFrZEgwR1BNRDEz?=
 =?utf-8?B?VkpUbnIvQ0RYaU5CeURQMWdMVituRG5IU1k3WmM2UjdWUENEeGdSSXJOY2Vy?=
 =?utf-8?B?d2hHdlVzR3I5MjY3QndpQWZXRVdLNUp3TUwrRk52TGpibzUrbUdjc2RISU02?=
 =?utf-8?B?ZHZMTkJoRUtNcGN2UjNGRXhFcXp4cy9QaFdQUUM5Z2YvZVN5MkNqcW9SdDNJ?=
 =?utf-8?B?UTVrcEhxOUFGYVkzQ3k3cTJ2U2N2S2lVeitIelVybzVZcFJVdDNVWTYydlYr?=
 =?utf-8?B?SHJvNEl3Vkcva29zd0wvYVBNTDVQY2RPVFdRZyttSUQ0N3ZUWFhZK1ppREIv?=
 =?utf-8?B?OTViTjFRdGVEa2Z3SHQ5MEFUdW1yZjZLR0RVajlFTnRMT0ZJd0Qva0t6djNv?=
 =?utf-8?B?Si90WU5GdEpOOFozL2JCcE80Ynd3b0lKV1A4bjREQXpQSVk2b0t5MEIvM2hY?=
 =?utf-8?B?VXBtVVNXUDk3SWl6VExUbGtzR0czTCtwa3ZXcGtpY2NmVWNuZmtmbEJjaGVl?=
 =?utf-8?B?L0Z6azZkVVRJS2w2Mm1KeC9zbHZBSWxaKzRJb2dtSzExVmNGNDkzOExZVHU1?=
 =?utf-8?B?TE91V2NBN0RmTU0wTngyRmJieU9YRHVaRktDcHIyR3dYWkEyNjlsdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B8EC60B4442F52418CF49A3EC1ECC3DB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HUM10l9YVzZ86tbrpwCXSnFjIMj+xapNUmOeFY/8cuDW6oe0DdYiS4jYtIo7UQibZHeAnU02XiVzyAC2XNEN8aS5AVWKBO/LZAh0a0Lqw5f9T+EepWJAOklBwZKp0+IyhtnWpQDQOHbKFJCFKmNvCQ9lEnzU2HX/Ed1YTJL+mOuEDh79Jv6AglH8uQ8f2d0x0aO4WcJOqevwSKT49OM92s0Dnod+BevGIaidsjUem1PIje8v3EotAfOcpL8BkzUka84yxk3hOjeL63AOheYV8NtenDbU5y0YmLj4UsIhlrfl1j8flNFFoQ17nvC9Uoq4gRB6cwWJUVeMV586jkBsjw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f8268f-cc6d-41c7-e688-08de95497ab7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 08:33:15.6708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1KdG1PxjVqyGcQsFy2uGdwWtp5Eg7zefI62qNOuUguTeIvyNhxRhJJhzBri6PWf5frONXZR3jUIxb/ZctSQlpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6614
X-OriginatorOrg: intel.com

DQo+ID4gPiArCS8qIGNvbmZpZ3VyYXRpb24gdG8gdGR4IG1vZHVsZSBtYXkgY2hhbmdlIHRkeF9z
eXNpbmZvLCB1cGRhdGUgaXQgKi8NCj4gPiA+ICsJcmV0ID0gZ2V0X3RkeF9zeXNfaW5mbygmdGR4
X3N5c2luZm8pOw0KPiA+ID4gKwlpZiAocmV0KQ0KPiA+ID4gKwkJZ290byBlcnJfcmVzZXRfcGFt
dHM7DQo+ID4gPiArDQo+ID4gDQo+ID4gSG93IGFib3V0IHB1dCB0aGlzIGludG8gY29uZmlnX3Rk
eF9tb2R1bGUoKT8NCj4gPiANCj4gPiBJbiB0aGlzIHdheSB5b3UgY2FuIG9ubHkgdXBkYXRlIGds
b2JhbCBtZXRhZGF0YSB3aGVuIHRoZXJlJ3MgbmV3IGZlYXR1cmUNCj4gDQo+IG1tLi4gcGVyc29u
YWxseSBJIGRvbid0IGxpa2Ugc3VjaCBzdWJ0bGUgY29udHJvbCwgZXNwZWNpYWxseSB3aGVuDQo+
IA0KPiAgLSBXZSBleHBlY3Qgb25lIG9yIG1vcmUgZmVhdHVyZXMgYXJlIGRvb21lZCB0byBiZSBl
bmFibGVkLg0KDQpUaGUgbmV3IGtlcm5lbCBtYXkgYWxzbyBydW4gb24gb2xkIGhhcmR3YXJlIHdo
ZXJlIG5vIGV4dCBmZWF0dXJlcyBjYW4gYmUNCnN1cHBvcnRlZC4NCg0KPiAgLSBXZSBhcmUgcHVy
c3Vpbmcgc2ltcGxlIFREWCBlbmFibGluZyBwcm9jZXNzLg0KPiAgLSBUaGlzIGlzIHN0aWxsIG5v
dCB0aGUgZXhhY3QgY29udHJvbC4gSWYgd2UgcmVhbGx5IHdhbnQgdG8gYmUgcHJlY2lzZSwNCj4g
ICAgc2hvdWxkIGNoZWNrIGZlYXR1cmUgYnkgZmVhdHVyZSwgdGhhdCdzIG5vdCB3b3J0aCBpdC4N
Cj4gDQoNCkZvciB0aGUgcmVjb3JkIEkgYW0gbm90IHdhbnRpbmcgImV4YWN0IGNvbnRyb2wiLiAg
SXQncyB0b3RhbGx5IGZpbmUgdG8gbWUgdG8NCmdldCBnbG9iYWwgbWV0YWRhdGEgYWdhaW4gaWYg
dGhlcmUncyBhbnkgZXh0IGZlYXR1cmUgZW5hYmxlZC4NCg0KQW5kIG15IG1haW4gY29tbWVudCBh
Y3R1YWxseSBpcyB0aGF0IGluaXRfdGR4X21vZHVsZSgpIGlzIGFscmVhZHkgaGF2aW5nDQptYW55
IHN0ZXBzLCBzbyB3aGVuIHRoZSBuZXcgY29kZSBjb3VsZCBsb2dpY2FsbHkgZml0IHNvbWV3aGVy
ZSBlbHNlIHdlDQpzaG91bGQgc3RvcCBtYWtpbmcgaW5pdF90ZHhfbW9kdWxlKCkgbW9yZSBjb21w
bGljYXRlZC4NCg0KQnV0IG5vIHN0cm9uZyBvcGluaW9uLCB3aWxsIGxlYXZlIHRvIHlvdS4NCg==
