Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFDD40DFD7;
	Thu,  9 Apr 2026 00:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775695777; cv=fail; b=PhoIAtu3jZnEGDSvtPMBRT1AjR+qmmGxeU9oJdCwHfCNcWJXENTOp8G/hcdLNrYJi9wkH3zvf2HRMsLUCK+7+g6Td8ANB/M1d8/A36mzWvlZjqRQIFv/kqcfKCwnv8dSCnh7pMafznguDnrFKfrm94N5yaz7T99EYLTJgPOLMaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775695777; c=relaxed/simple;
	bh=m02nhLI32yvWzt1gr4zQangPdmtLVlKLsCvO6ZV9Q+M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FE/0mTU3pYtwYYoaexriqy8HdNoPsKiJf8gdr9Rcjr5+ltVvULEZVpO9LrF7uFkSxP5Dk+Si2gGrIL4wUMSSfASB/LJXQPiXXh3olvV/V4sl7RbwomGBxbsBkAI+nQlQlmu6yDZSUHOoZjoobhvZ0lPdnlN+xqjklPdExreS2lU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZwdKqT0d; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZwdKqT0d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775695775; x=1807231775;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=m02nhLI32yvWzt1gr4zQangPdmtLVlKLsCvO6ZV9Q+M=;
  b=ZwdKqT0dSZ9fZayGHB2QAGO/z49Z+Rwzqz7alBaC/joOJkxArLdSBYCi
   eMWjoACqAvE2OxbPsR6fOoU6N9Vz2R80lBOnlCOuX+1UfY5LirRrrzv5F
   d9EEP7kf4wSyruB/xzqrp13VI2jZjb3fW55asl2hx4H2639c+I9APXnHi
   yyrxpgTA/K9lgc/y/ESGThrsKIw8Smmyj3Gmt3G7AHUbfls23BkaB4Idb
   Paq3h0u0lGiLF6bz9kog7Cl3IMEzzFkwnyEzmAad7Q9KnXvTzucpec9kl
   oKK7yUDCkRr0Vdf2IcMYXQ5n5d+ZndyOsF2/cC74gaoG5U4f9/lX6gYcf
   A==;
X-CSE-ConnectionGUID: 2CFJeFghR+CSu8vezTYEQg==
X-CSE-MsgGUID: WWyZBlPNQL2xfaCWPMfWfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76572685"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="76572685"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 17:49:35 -0700
X-CSE-ConnectionGUID: VDyPvmCRRW+44nuf4N81Ng==
X-CSE-MsgGUID: ZmluMlrjRluAInaBBVqhow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="266595303"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 17:49:35 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 17:49:34 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 8 Apr 2026 17:49:34 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.13) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 17:49:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QXB8l1b9BtWGJGGPGiNphTUKbc6okSiljqgSXe1D5xvOezHiuI4lbcoH7W2beIGUnnhRP/Q3NgeNqoo48s97rzRnjoUedcXHWXxzsqesLLptyqyM1XgKIZMTyBOyGdyj4/m4YZOQt2gjUlPZLfAwvTNDmFf0ddhPDPD6Q3AEwnCPjtoZfvvmG/zSkvjfjOc47z8DKd0OtDZ26Hl6qTHKkL6BqXWPWIjrXYem2TjR6wPh+EhJkZ1gCG7/jOdyxjCi742OvK+KGbQrPDIcKwG1tYmcs25/HYuRCeNZB8HMOzcsAE5T9l/OpbLSMkvSDpOxMTqyy6zlDIOdHkDop+laAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m02nhLI32yvWzt1gr4zQangPdmtLVlKLsCvO6ZV9Q+M=;
 b=RkH0WhdT4qivkzDv19Q703OWvdtLC4CaM+6jp3ezkXPvCARUJrvGtrG0l/fGAh+71JH1NQqhlndxTUOD44j8NxZCJ9aToCpUIwf0XTQndUmaMC1NQnkEiIVvRa+kAg33wmugICN+dHtlrLlshfjsZJ+LwgZ41ko89fFjKFBRINKevtId/5+zdLzTMPGPes9Jmph62SvmieoRscEgbNtwhZVGXI/TyDzW7ukhXBZH6QIJYRDJ0BdFaro2s98yJwZQ0Lz0uMWTE9D0jSRE8RrDGwdng+s9VBRvU9tavUbPDpOuRAwp5E/qi8yo3RfyYo+oaeJMmAp1VWbma1WMkPNKIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CH2PR11MB8779.namprd11.prod.outlook.com (2603:10b6:610:285::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 00:49:31 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9769.017; Thu, 9 Apr 2026
 00:49:31 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Huang, Kai" <kai.huang@intel.com>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>
CC: "Gao, Chao" <chao.gao@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Verma, Vishal L" <vishal.l.verma@intel.com>,
	"Jiang, Dave" <dave.jiang@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 11/31] x86/virt/tdx: Make TDX Module initialize
 Extensions
Thread-Topic: [PATCH v2 11/31] x86/virt/tdx: Make TDX Module initialize
 Extensions
Thread-Index: AQHcvgYM0hzom+MtakSW2JbAkZWfSbXHvPUAgAEEooCAAVuiAIAKyQOAgADaAgCAADmzgA==
Date: Thu, 9 Apr 2026 00:49:31 +0000
Message-ID: <9c00b87b7b69470ad1e7b1d2788414002b9a1c77.camel@intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
	 <20260327160132.2946114-12-yilun.xu@linux.intel.com>
	 <5cbed31cdfcc7e43f283abc275848370239a3d40.camel@intel.com>
	 <acvhD/XeCbB4ea0C@yilunxu-OptiPlex-7050>
	 <124b776006fee36e4a242f58bd4e128eae97c505.camel@intel.com>
	 <adYQx+6LcO/s2nyn@yilunxu-OptiPlex-7050>
	 <8b6627db920d3cde3fb4c3826a25210965dabba2.camel@intel.com>
In-Reply-To: <8b6627db920d3cde3fb4c3826a25210965dabba2.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CH2PR11MB8779:EE_
x-ms-office365-filtering-correlation-id: 6f21fcf2-2fc2-483d-77fc-08de95d1dcab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: fWOSSNCSuhv7Jw+5x66cFgVMzInuhLvbElxjtOU+Z3OWX1f5xZKWY1nafFHMc1duFAqo0ud+5ojkk9GDP9y5rO3NG/5nx4fiA8AtDsoHAfcgPyzu6OWCB14zvQUy0GBiUnOzsKuH3v3MCkKdHu69glQ6Oge/BCmRQFBRsoUyOJqgCXip62FH0IuKYksV9XFC0iDbc2gWwGjFIZ4IwOwNCanYPkRyCs3ZjN9eS0rLYhnLyPiTbIONcxUpioBz2TGaackTgCFSdUyZ/JcSBsV7TJw+iYeKUejqQUHWpT3NSA5wwa/kZa1P9Y4f0IkXzIS1FX9FZJ6VRfA2L8lV7aR4qz2jUlNAQ0iWyHqNMbTMYpzzupj580SqZ46/QcQ2pJfANlkegwuZBqEAjdMPBTj6L8z1XH1XfGrxoWQivYvXmQ77d9ec2fjhzZUJOU9Gmf428aj/WY7Z41DU0i3u2gcHSyW/sFaWUhVIlO9k405ekPgfpT/hFMmg3QQGMvN8gAXbDj0bgSxFSHMaV0BgU6UFeQchvmT4h2xf0BoS6joZUxm6c7Z2+kK03h2RNOtB2iC0oD85XXuU7JUv7J2SdOn0v1qQnIKIbCY+nz0TQd3VdXq1DO9eusMwU93ODfpet44ynlH+77G1O4zRPd7adm7COS67xoiEDs3qz6plfU30eTwm3w6YAXz8jhWZH34hx0SY+bA7GrMQSymO9Ng+TPxV3PCRfUnA2x7Nd3dzIIeBQ2phejiIJH4RooCjt9+/gheyUScOwS36V/PsSIJiDrjzQeDAAa8/Ox0t1ZZ/eYKCkHw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEFDODVzYitTeFhVUGZLVmc1VjZKK2dqUFdCSE55UDFqMzZJNVhMa3lyQUlK?=
 =?utf-8?B?aVJLVWc1WWRwU3haV3RDeVVTTDFSeUtpZkJmTzU1UnlaWUduU1YxSTE5Z3hJ?=
 =?utf-8?B?QkRQSEw4eS9EcGptRWllZTl6TlNUVDVNSEJ1a1hsUnR0RFpGOS94SzNnY3E4?=
 =?utf-8?B?SGx4ODhEVlo5Y3lyeHpmd1ljL2ZaUVVVeW5xaFl3SmlOL1pBYlZrY0MxMDBm?=
 =?utf-8?B?UUtmWU10eFUrVEQ1cEJ3YjIwNG9nMGIyRHMvNjFxRDBUTzljb0piUzA2Mkhh?=
 =?utf-8?B?aEJLOC9SNkpoZW5XQTBjT1lxbTU5VEM2OEwvUVR3ZXlkOGNza2MyTjFMbWFJ?=
 =?utf-8?B?dzhRYWtMb2xrL3luV2ZOWFZMa29CR1R1RVpyeDN0bkZWNWhNU1VCS1I3U0tx?=
 =?utf-8?B?ZlhZeDF3L0taYm83dWQ0YUpSZE90RkJiZmV3cDBWQnVMY0dGR0xjVmpsSWo5?=
 =?utf-8?B?YWlBVzI3cER3T3Q5TENuWlFwUHdzVFliYWQrTktpS2VmaitSNkY0VllhU1Mw?=
 =?utf-8?B?QnZzV09mUmpWYVY4Q1ZNdC9KaHY4MWoxVUpLR1VNUkl4RCsvY2ZrSDNNWW5p?=
 =?utf-8?B?dk81TW1COTcvOUlkdEF6ZzladmtrS3JkVE05THpDWk1xNytCTWdKNFh5c1Q4?=
 =?utf-8?B?V0RrWWFVbGRDb1hHQVVoeTh3MHE2ZjIzZm10U1RaV2lMcHJMT0xrejdmWS8x?=
 =?utf-8?B?d1pzQVVOdGdkcmlVZ1lWSmxkY2NkeWFhcXp4d3ZiZjZGZWNBazlPNzNRdFc5?=
 =?utf-8?B?bWtYQzF1ODFuRVJnQnRWME12TTlNOVpTVXE5NjFDOEo1UjMxSzVyN1doUlJn?=
 =?utf-8?B?NTJ0RG5WS0xOVVZxRDR5MXhQeWRSUThuaitnM1RxNE44a0E4bXNZaE5abmkw?=
 =?utf-8?B?ams0UXFyVjNVK1MzQTd1bmJOcDVJOEFvdDU5di9pN3JFZ01LVEhpUEo5NEF1?=
 =?utf-8?B?ME5WZThUZnRQQ0VLQW04d1NXTUZMZWE2N2xRamJsam1rWXJLWHVQUytvSEhu?=
 =?utf-8?B?ZVJPMUVoZCtLcXNEYzFqeGNsWmpEdGRYcVROMGlmN29CU2hnNWwwQkNEcGl0?=
 =?utf-8?B?dWdVa2x2Q0RlMTBZY1Y3b08xSEhMVDVycUd4bG4xcE5QaXphWVBtTFhIK25G?=
 =?utf-8?B?OWNzUlNzOWdUTjBTeGZpQzFsNGJJSlVGZGhDSDRtRUE3NEU1WG1qbHhBODhk?=
 =?utf-8?B?RHM2ek5qVjRabHcyOW1JejRIQU5sT1ZlYUFjRVVJZ1paUGV6a3BncDk3bEVx?=
 =?utf-8?B?c2YxT0NsQUtOczBQRzh3V2tEWnJYbkhKMDIxTnNaUkNwSk9QcWwvT2x2aFg0?=
 =?utf-8?B?YVhVd1pVNC9SQ3FQcUxjNE5uaEpnSnpPUjhCcXNOcmJwcC9HVG1jSHlna3A3?=
 =?utf-8?B?N0RST0dUbFFScUtuRFZ0alFQR1o0aDQvOVNjcjE4MGdFdk42bGdGWTdSRkdG?=
 =?utf-8?B?RVpSOXNMVm4zWm1sbld4T2lzYXNPSmtwNGVHSGxmUGh5WGJ5amlVSG44blJE?=
 =?utf-8?B?TjlIRC9CbWQzaDZ0cW9tTDQ1V1JjOXFTOGtYQWQxVldRWGFpeFVhZTFCVURH?=
 =?utf-8?B?UXpObTVBZmx4bnJGdW45OG9NaHVrODZvc1BFRzN6OTgxb2dQZDNSYURFTStM?=
 =?utf-8?B?SCtqVy9VdnJDN0V3MGkxQzY2blp5V3FubzRqbEIrR0JnWUE0R09aczZnTy83?=
 =?utf-8?B?ald1d0NieWlLZFdUd1RWc3c2YUJNSkhwWlg0MjF4TXdXeFc3SllzaVdhOUR1?=
 =?utf-8?B?RG91aVBUeXI4cDkvdEVsalpQejEvVVNMNE1pRGkwN1JoTUxBQ0tIOTZTRjNE?=
 =?utf-8?B?VExxaVVoSSt3NWlvajIyK0RINmVCQTlqWGJjbnBCTHVOT1VqcUUzUnBQcXBu?=
 =?utf-8?B?Rk9ZQldjZVFGYkJ4WnBkdkE0eUgyZURHTmRFZTYzbG50TXk5dVphNTlHMzVI?=
 =?utf-8?B?MDJXVHF3aXZDRjh2SklyM3MrZ3NGTlVyZXFIaUFQcUlCdXdqVDZmck5iZTNV?=
 =?utf-8?B?KzFhZm9nNjFWN1IzNGpIM2NtZlF0SlZ1ZEpjRE4wLzg2N2hqSlhQUUc1UDc0?=
 =?utf-8?B?QXNoQm9zZHc1a3QzUUQvdVBDMlZJWUUxQXkyb1Q4TXl1ZlhVeUpDdTlJNTBa?=
 =?utf-8?B?SU85L3BHWVhXZG9UbXgvOGFTc1pZa2xyL0xVOHl2NHBWSXFVTml4bURQcDhp?=
 =?utf-8?B?SkhJWm41QlNoakZvYXByUzhaZ0oyb0tlQWhJWFJsS09KbnRNZEFCWFhNa0Fa?=
 =?utf-8?B?RnQxbXgzL1l6ckNKdGlwYzFwb2pXZzI1NzdwVmI5U25wcklybHFTTVQ4cXRW?=
 =?utf-8?B?S0VCcXdQVkovZ1hiMHgwbzhONkRUN2NoTmE2Y2JCUS9wTktxYXJHWnUvV0VJ?=
 =?utf-8?Q?t4sRY4BA5zj2uIcc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7AB927A411B6445A08283EEF37EC2E1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DE3PXj+3Eb+yEmB3paGO0BQN1QqPJuT2QdxgJSif24frdF+KgHrmwOR0npW5xJrTIGOtS+r2MBxATB8N27Bug1ahS1hV0FmO931lzyFdWaE2oNi5ahQB6usv6F3J6k+yVaPy965ru60cQudVZsfLk1+xdjg8r+OsUiiwlme+RIV/WmR1qGm8Sfg+qH0m79JChlInrvDvNLdEc8j4HJssmCP+CvojYWgewVye9SnvG3JJKStIOz7UrBk7eWZbNl751UezOzU7uWhsve+YkcJtF6ntEe12jNxumKuSbNUvBulIqTU6IWSJdxF676VbI1R/4bvaGKoGMUWosKSPyVWKiw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f21fcf2-2fc2-483d-77fc-08de95d1dcab
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 00:49:31.5504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jgq2e0nz5eMSt/HI4BeU6a+c/0/FTd7f3XJLWRHNA2au0H1vZ1uluqSYhl6SXkOaxBNidFRO0owz7BhJ4qMdjjcCKtI2tdK5HMBleuKNAqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8779
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA0LTA4IGF0IDIxOjI0ICswMDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiBJ
IGRvbid0IHRoaW5rIHdlIG5lZWQgdG8gZ3Vlc3MgaGVyZS7CoCBXZSBuZWVkIHRvIHVuZGVyc3Rh
bmQgd2hhdCB0aGUNCj4gYXJjaGl0ZWN0dXJlIGJlaGF2aW91ciBpcyBhbmQgdGhlbiB3cml0ZSBj
b2RlIGJhc2VkIG9uIHRoYXQuwqAgSWYNCj4gdGhlcmUncyBhbnl0aGluZyBub3QgY2xlYXIgb24g
YXJjaGl0ZWN0dXJlLCB3ZSBuZWVkIHRvIGFzayB0aGUgbW9kdWxlDQo+IHRlYW0gdG8gY2xhcmlm
eS4NCg0KQSBnZW5lcmFsIGNvbW1lbnQuLi5JIHRoaW5rIHRoaXMgaXMgdGhlIHdyb25nIGF0dGl0
dWRlLiBJZiB3ZSBoYXZlIHNvbWUNCmFzc3VtcHRpb25zIHRoYXQgY2FuIHNpbXBsaWZ5IHRoZSBr
ZXJuZWwgY29kZSwgbGV0J3MgZ2V0IHRoZW0gaW4gdGhlDQpzcGVjLiBPciBvdGhlcndpc2UgZ2V0
IGFuIGFncmVlbWVudCBmcm9tIHRoZSBURFggbW9kdWxlIHRvIG1ha2UgdGhlbSBubw0KbG9uZ2Vy
IGFzc3VtcHRpb25zLg0KDQpKdXN0IHNpbGVudGx5IGhvcGluZyBvdXIgYXNzdW1wdGlvbnMgYXJl
IHRydWUgaXMgbm90IGdyZWF0IGVpdGhlci4gQnV0DQp1bmNyaXRpY2FsbHkgaW1wbGVtZW50aW5n
IHRoZSBhcmNoaXRlY3R1cmUgdGhhdCBpcyBoYW5kZWQgZG93biBpcw0KdG90YWxseSB3cm9uZy4N
Cg0K
