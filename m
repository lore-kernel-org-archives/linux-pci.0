Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAD63A759B;
	Thu, 23 Apr 2026 22:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776983384; cv=fail; b=DELzven14gY1WCpGxx/RRHllGyhuqMZWPfE/hw2oHWG0YrqR8xmc963dFWArysyNSu02XBUF1kcGvcpwy4u2KWwBhNeqj0KZSMyNswDoYprmhpApYWRLofB3dFGBad3RAHAv5Ght3kccE348gKc/Bd62FpOGVTU2Jf3L1HJcMYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776983384; c=relaxed/simple;
	bh=KbI9qE5wQDiCQFNNbBJ3x47bNawT4vPrcTfSDjLSGbI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VduHO9d1cqc8lvGQbCMc/WsDf3SPcQRRTTAbKN+Whwc0y5yocJXODM8oqN5G4mxjjF1RlQNRB1lgFiRFfjTtx/H0PTAmGA7s/FOIIsnY5gO5kGLZcWECgu2IuOFNHNnyVOXEpEja5783XdUWGf2PdDAGS+CusRdzH7D1DT0pWpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bHimMZCy; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bHimMZCy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776983383; x=1808519383;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KbI9qE5wQDiCQFNNbBJ3x47bNawT4vPrcTfSDjLSGbI=;
  b=bHimMZCySKI+5UTFlqf1Jp+S49TsWJZMSeVX8Or6CY63k0+fkPTVHRl0
   ua+9Jx/tVQcuA31PpHzV/UiK2SW5Ju5A6WxWwt7NpPFK6LDdBmesnMMAb
   oEOmQbtTXPe6fvCsR6qJ20whWXoMkluaNVcA7vjAymSxD6lEkW+Q+sgop
   x48Tu/xaW8mKRKLm7A/Mn3qvDwO+rFkQtTNzeOvxodh/0awMXYIEhslsb
   h5BMOkGt6E1LTMzrpOB13/oHFZYXp9WjeZYA2CvURt8crkfOV1XOqw1GC
   /M++A7vgKv8tXNhE0nOuYpToKAFHsfIzFZyLhH9W4Z8CqoXGPyWM4QM8O
   A==;
X-CSE-ConnectionGUID: 7dFhjUN0TzO0QXbDY0/SxA==
X-CSE-MsgGUID: M4kHPc+MTlaykCFuEUXVfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="103426547"
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="103426547"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 15:29:43 -0700
X-CSE-ConnectionGUID: jmr+JZlnT56V5kgQi7fOoQ==
X-CSE-MsgGUID: BKBQy+XWSeStFOl5SAmnKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="233096224"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 15:29:42 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 15:29:41 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 23 Apr 2026 15:29:41 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.70) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 15:29:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dAbciQK8BfAjwkNEIwwDaEw8SCIs9g0wQc3YzbaNPFxU0hye/fgVJsPys+zKhdoR1IJz1dUyunrMyh5yN8Xz65zIfAoQYqBkBynabJpgFcff66AzUIN7/JVln2hPAQuYlSQgdzn3VATx/g92kb+lketItCb50t8sCZTSABTIdTRceEzJ4DmKGN9aI8vkgOO2X6XAtgLebttSF3W04gsVMOHC0G5c55aZpuFGhfhXVcSP0zkHck0I07AQ4CJrc5XskyY/VhQtmjV20T16FZ6P+lyri2HJBD2Fyk2vz9NcWBK6+PkV0wXKDHNIMmyBuqgoy1I5VPRBUJLXMIV1GYTrlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbI9qE5wQDiCQFNNbBJ3x47bNawT4vPrcTfSDjLSGbI=;
 b=jJcGuTHuVlrhvOk3NJFvG2s0XGIcUlLdzLbxCzxGWuP2Wa8FWrft3yzee6MPGuPwpLRUnmj3065BWsqqql4H6+/NkAHwGcIYJBXLCQ1V5mDQekVk9+14HOBAvfDN8o7dRa+CnQAooj8nN121lu2C5E6ZsTHWMZo0F36tohELQDmG0dqdRIwZTZ2Gbwb93MfH4sku0k92A7AyzIKG1RlXhILAWTjZ5fR8VlHGxNg/z5SpnwzKgueFo2m9n+MW+7gbbFB3idltb4zfefzPeYAelDiH5le72fzbyLhejd0cUcm8edyi4fihMzmtpOCerVM+cVhrWfYlQywKzqu/Gt/jfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 DS3PR11MB9842.namprd11.prod.outlook.com (2603:10b6:8:366::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.16; Thu, 23 Apr 2026 22:29:32 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9846.019; Thu, 23 Apr 2026
 22:29:32 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "Edgecombe, Rick
 P" <rick.p.edgecombe@intel.com>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "Gao, Chao" <chao.gao@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Verma, Vishal
 L" <vishal.l.verma@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Duan, Zhenzhong"
	<zhenzhong.duan@intel.com>
Subject: Re: [PATCH v2 10/31] x86/virt/tdx: Add extra memory to TDX Module for
 Extensions
Thread-Topic: [PATCH v2 10/31] x86/virt/tdx: Add extra memory to TDX Module
 for Extensions
Thread-Index: AQHcvgcsp3iEtTEG/UOFY+bW5PCg8LXr/O0AgAENtYCAAFqbgA==
Date: Thu, 23 Apr 2026 22:29:31 +0000
Message-ID: <48171f4ab772da546beccec3c7a95fe442524b42.camel@intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
		 <20260327160132.2946114-11-yilun.xu@linux.intel.com>
		 <89bccca9a409e02667278fd83f0b7b9064557dab.camel@intel.com>
	 <3b0bc0dea544b10bd2fb0304a96d2671f263829b.camel@intel.com>
In-Reply-To: <3b0bc0dea544b10bd2fb0304a96d2671f263829b.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|DS3PR11MB9842:EE_
x-ms-office365-filtering-correlation-id: 81970156-04ea-40ca-1333-08dea187ca5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|38070700021|56012099003;
x-microsoft-antispam-message-info: EFU8zfYkRW2elZyqx6jHiCAOW1KrA472NNdEusLeiHK7cL0svuusmT2qZLUplvcv4iYNhH/3j4LkSt7ir5l40AZUZPI6oQi8Hb05Il0miKt3XTixHEI+w2Fh/KwLhR9cdrG8/RWm2c5ellzUhUL0tWpmBBxDehvZe90Vue6ZMigQYGNa27+ChO7LxBO5SSQLQpBrLKRuF/Y8UxbDf+L5erMPJJ98BE14DP1eMyXBvoEyVgQDmzdUl6By8aaVdhSS/MvVVpizpcrDSNqhxNp9dbfVqeWApBI2yplUQeFeHYWnTyARZkEXqRfJPIIj2UKATM8KxGPL07gqLs648mnEywqMeuuUTd1uSjd4L5vqMe7BPEg9QHWU6mIpQEEqIw3gdH2tGYfClICmOj1t0PNoB5mhqDFpZFPWBqnWJEM20MD+zgCmsST4Li6M5fjktPParRr9Zm7RdHOwc+IWBRaSZT7r9DfX7/6GpVBLWNSEBHS+7LdYssLaLuRhjfa85cBk5XsHEFhrisKCydeaIfBts0NvwCEdYvGIGnhYQ1vaUVAlsa0dgCw6Rhp+XmI+J+QmIBniimVj1fhsAjuR590s6myjozGnc4KjWw82gcZUEuNmLBkKMccruAFxaG+Yjeva6k3mS38/DtddkGe0Av5AXt938YmloyhSwTUT8yZXaRRDexva9f1w+CI+ikQlxMR86df6WFBz/hzEQ7vB6pkk+OhKs5P61qB/9qt2mlqIhw2n8J8FegG66tFx+hKu/j5L01xkC+tG4BSG8J8hC1Kbhr1W2JIiUPGoLkRdijBxnwE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(38070700021)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWc3dndJa0JEd1FyRW1CVWZWa0YyY2IwNkI5cjJEeUU3a0srV0FxeFp1RVZv?=
 =?utf-8?B?emhyTFFod0I3d2N1dmt4QlQyMk5QeTN5RUxGV0poUGx4VFNCS20yQ0t4dVdo?=
 =?utf-8?B?Rkl5OHhjQjBVZFk0a0ZmZTJBWEFzOGtjMmFyUVlPMTZGNkhYd05LcExjTEJw?=
 =?utf-8?B?YW9nc0hYeXcxMzQvZExVd1VhYUpJNFdKNTNHOGtXRjR6Vmw1S0U2eDBBOWNm?=
 =?utf-8?B?a00wYTJUNTlnTWkyU1hDS0l6YUxUaWpNQlR1a1oydzl4Y0grOFgyUWFjRXdT?=
 =?utf-8?B?VTl6UFlyYmkvK0IvZDZ6UzJHWm1HZW1OcTh2N2VJZEFOUlRIdHBpZFBZRGxs?=
 =?utf-8?B?TDUyTHgxNlR2RzZ0QzJ3elNVMFBibE42TFpUT3lRYWZRTHYrT3N5S0UxYVRr?=
 =?utf-8?B?aFlKNkNhTVBoRWMzUVJYREd4eTRxLys0TkNUOUk1WW9CbVZhWmNqazFTT3M4?=
 =?utf-8?B?WmxGM3pnMHBPRVVsRVlSUWVhMXBQaCtXUHZDY3YyVmt6SmpQTWpBUU5xRWZx?=
 =?utf-8?B?QXY3eDdzdzZyOXRiZTNVV09LNmpkQ3lYeVM3MFlwRndNWUg3UkhZQjZ2ZWdU?=
 =?utf-8?B?UGRzUUlzeVlWaEhZanFnZkJoekJGVkhzdkE0QTNybytrWVFqQVYxNEgvNnMv?=
 =?utf-8?B?blhlaXpDbHRHUUlsWGhyZERGb1BtTnpHZ1pHbnNQMVFJbWJZQ2VyNDJJdC9F?=
 =?utf-8?B?WlhjcXFZdVA4N3JTNVJMMWtLSUpKcGdDb0VwY3lleVR5LysvdDBYK3BzcXEy?=
 =?utf-8?B?dG43YUZsYVlnTS8zcGQ3Y0hUTEZNR1oyTEw2QXUxczFKOU9xRkdNUWp4RzNT?=
 =?utf-8?B?NXdIYW1BQ3FLaVhvRkJmc2trMG1IR2RSQmNDcEI0K3ZsU2ljZWRpbFRRNkZY?=
 =?utf-8?B?anJpUVdpK2p0amxPbUNrekZ1QkVzWkJndnNBM0Fja2Q5em9jV1llSjV5ejVT?=
 =?utf-8?B?ODBobldIUE9IMENLYXNmYThDTjBFd01uMGViVTBESVpOeXhiVWk0SDhha1N5?=
 =?utf-8?B?NDE5ZTVkZStPeHRnMHdqcFR2VkhtODg1d2pwRFM4a0IzWjNLd05LSzk5Q2Jn?=
 =?utf-8?B?UWJiYVBIbGlnWVFqSGpGYmMydEdWcjFOVlJiay83eDZKNHJta1ExZXh6cC9P?=
 =?utf-8?B?ejlxUGNtd0NxOG5TUlZTNzl2ekZkT3VISjRrVGprT1R6U2VDKzJJeWo0Z2Iw?=
 =?utf-8?B?V25QTTYrdnVWOVJ5YUVER2czakdhMys0V3BmOGVBaDV0S0gyTnl3ak5ONzNN?=
 =?utf-8?B?dUZHY2lFMFdzbGZkWGtRelE1TndXNkRSTFRheG9RWXRsSTF5QnQyMmc0QTkx?=
 =?utf-8?B?aGU5ZnlTbjhnRFlpZ0QzaUZFci9jRXZOTXgrRGFYdE92NkFEQW9hMG4rNFU1?=
 =?utf-8?B?blVOalQxL1dhSExKMG1zdDFsU1JjL1ptbUxpRTBzMUlYUFVFQ2x0VHRwOTFq?=
 =?utf-8?B?UVBwVHJNeHg5U2NDWjlXVlJpM29NbHQ0SkJieFdMVVdZcFJBN1pob1o0WEsz?=
 =?utf-8?B?QlFYSmgzNU52bUFJMjZyUGc3RkpVUHhGS29VanoydUl5K2Y2Nmk0RkxCclRK?=
 =?utf-8?B?eG93SVd4dVVYYitlTnlnOG1naDFWd2dWWGU5U0o2dG5RZXJQai9iZm9MT29H?=
 =?utf-8?B?UkNjYy9FRmFYSHlWdGpydjE5TkhUaE5RUXhWdmltN1llZEtnSUgzQ1oyanF4?=
 =?utf-8?B?MVdhU3JSdmN2MExSa2wycGVLS2xHdGdIV1MyRnVhM2M1amNlRFEyWW8vOXpI?=
 =?utf-8?B?aHFSNlA4UHR1MkpwMmNTMTc2eHYreVZtQ2Q5QWdGMDRxc0tqdXZOVjVPOWg1?=
 =?utf-8?B?UndtczhKMm13UnZsT0k3dk0yZUdDTWJwRi82UXUrL2JweW9WZlNoYU1hU2pa?=
 =?utf-8?B?N3RTTnB5Q0Uyd1Bub1h6SmluTnlZUDgzVmZwS0FQZFIvbllnTCtFRFNlTUJ6?=
 =?utf-8?B?UnJOOG91RjF4a0JIeUZabkF6QWJGYnJ4dW81TnZtOS91eUgwM3dTdjByeXF6?=
 =?utf-8?B?KzBLR2JKUGs5VHV4cityK1NxSW04alNGeUpmUWpnbkJqOHhoUFQ0Nm16NElQ?=
 =?utf-8?B?UDNGZ2xkQ2lLSGwzRUhIM2dhREx1TE1Nb3ozaWI5bUJvMkRFTC9MMnlkMzYv?=
 =?utf-8?B?K2ljeFd3Tk40aVFVd3RORWRhdUJtbEhLVXVJOTNCc3ZnY1NTcDVZU2htck9B?=
 =?utf-8?B?K3NHT29DOEFmZ0s1QjMyK3F5cHQrWk5LUEdYbkdKa0lyMHcxUVBsZVBrWFJW?=
 =?utf-8?B?ODg0U2wrOEwrTGNBV0xlRVRzc05VZFFQWmkxUTdaakNPZEEzSEIwWXJ6QTc3?=
 =?utf-8?B?TmkwcUJDakY5c1JyQ0s2V3hUeFl5ZHRpSVppdlhuRG5TVmlSNG82UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E117C694E5CEC4A840BC945FFE776E3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fx96xtK3PWxdzvMzIeh5IMtSO6jOt0/CzF2USIwisQdRIOD48fLEvEiqx0vWwZUOyvUFzX64KtNF6yparSFCOKCKegr2fy9ArQTKBi9RzZ8xqhQX0hlExRvbWDYP7GGjJimK36+qXQ30HzDnE5j95woyzhZRPH8X1P/FbBUtvCdXCw8TTKgv07H2/zPO3WduboOvc9ZL5Y3ljG0gIF2iw7EIRyz7KOjw0f2LZ7huKHNJvxuAyF7cmgpVPCpNr4HHd38vO4WUkTrp7FzGgFsB+Exa4yvE9NAt59arEEDF6EAIkWXePwQcN89F1cF9eNUiY30w4ZRL/dc/ZmL5GkbqBA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81970156-04ea-40ca-1333-08dea187ca5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 22:29:32.0395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qRy8dgDwbEmFkIbgGhQh0NnI0S9ybEnPUJHk8rYSoGNe5rm7LD9DE1a2ORHZQkF2ORJyR0ZFmDWeN9lni3eP/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR11MB9842
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA0LTIzIGF0IDE3OjA1ICswMDAwLCBFZGdlY29tYmUsIFJpY2sgUCB3cm90
ZToNCj4gT24gVGh1LCAyMDI2LTA0LTIzIGF0IDAwOjU5ICswMDAwLCBIdWFuZywgS2FpIHdyb3Rl
Og0KPiA+IERpdHRvIGhlcmUuwqAgSSBkb24ndCB0aGluayB3ZSBzaG91bGQgaW50cm9kdWNlIGFu
eSBtb3JlIGNvbmRfcmVzY2hlZCgpLg0KPiA+IA0KPiA+IEJ0dywgSSB0aGluayB0ZWNobmljYWxs
eSB3ZSBjYW4gcmV1c2UgdGhlIHNlYW1jYWxsX2lyX3Jlc2NoZWQoKSB5b3UgaW50cm9kdWNlZA0K
PiA+IGxhdGVyLCBhbGJlaXQgaW4gd2hpY2ggYSBsb2NhbCAnX2FyZ3MnIGlzIHVzZWQgYXMgYSBj
b3B5IG9mIHRoZSBvcmlnaW5hbCAnYXJncycsDQo+ID4gYnV0IHRoYXQgaGFzIG5vIGhhcm0gZm9y
IHRoZSBjYXNlIHdoZXJlIHdlIGNhbiBqdXN0IHVzZSB0aGUgJ2FyZ3MnIHRvIGxvb3AuDQo+ID4g
DQo+ID4gSSBhbSB3b25kZXJpbmcgd2hldGhlciB3ZSBjYW4ganVzdCB1c2UgdGhhdCBoZXJlLCBv
ciB3ZSBqdXN0IGdldCByaWQgb2YgdGhhdA0KPiA+IGhlbHBlciAodGhlbiBvcGVuIHJldHJ5IGJ5
IHRoZSBjYWxsZXJzIG9mIHRoZXNlIFNFQU1DQUxMIHdyYXBwZXJzKSwgc2luY2UgdGhlcmUNCj4g
PiB3aWxsIGJlIG1vcmUgY2FzZXMgd2hlcmUgd2UgbmVlZCB0byBtYW51YWxseSBzZXQgJ3Jlc3Vt
ZT0xJyBpbiB0aGUgU0VBTUNBTEwNCj4gPiBpbnB1dCAnYXJncycgd2hlbiByZXRyeWluZyBURFhf
SU5URVJSVVBURURfUkVTVU1BQkxFLg0KPiANCj4gSSBraW5kIG9mIGxpa2UgdGhlIGxhdHRlciBv
cHRpb24gdG8gb3BlbiBjb2RlIG1vcmUgb2YgdGhpcyBzdHVmZi4gVGhlIHN0YWNrcyBvZg0KPiBz
ZWFtY2FsbCB3cmFwcGVyIG1hY3JvcyBpcyBhbHJlYWR5IHRvbyBtdWNoLiANCg0KQWdyZWVkLg0K
DQpBbmQgU0VBTUNBTEwgKnVzZXJzKiBjYW4gYWN0dWFsbHkgY29tZSB1cCB3aXRoIHRoZWlyIG93
biB2ZXJzaW9uIG9mIHdyYXBwZXIocykNCnRvIGRvIHRoZSByZXRyeS4gIEUuZy4sIGN1cnJlbnRs
eSBzZWFtY2FsbF9pcl9yZXNjaGVkKCkgaXMgb25seSB1c2VkIGZvciBJT01NVQ0KU0VBTUNBTExz
LCBhbmQgd2UgY2FuIHB1dCB0aGlzIHdyYXBwZXIgaW4gdGhlIElPTU1VIGNvZGUgb3IgY29jby90
ZHgtaG9zdC4NCg==
