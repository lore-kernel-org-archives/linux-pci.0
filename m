Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEFB32938D;
	Fri, 24 Apr 2026 09:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777021869; cv=fail; b=TWWSllPCkED2RvQbv7IdrGFnx5myLSC5UosY2HJoxAzlgDCd+hCJ4hQc+hUUMAehRQBo1tWbbU+VRXoonA1YZKsgl0v7GPv5cN+hMWYdyQ9SXjv+69jFmF6oNszXHDGaLUCNQlOxHc3xSyPx5wCKZf3qJGBonXrEXtFmQ5EWU0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777021869; c=relaxed/simple;
	bh=8rnHfYiisa/bjTyPsxsIga8CQxJOpgrBRmli04GVyi0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Cs3ScuwEUbkMYlG5DSE2D8Wa6GPzZbhxO/6Sn/dhxl9W98KoihccOwBK3LPtshW+Md+u6qMVKPogvV7/4MNchAY3aiYYhJjLfN72h0OSijSKWQu3H1PeYQYqTCEP4WVjVEggJ42+UkDbyQ+he0YmIQrBc5Y/o2Wx0DYx6QlhxPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FbS2o4wE; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FbS2o4wE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777021867; x=1808557867;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8rnHfYiisa/bjTyPsxsIga8CQxJOpgrBRmli04GVyi0=;
  b=FbS2o4wEeFJa1aUcRj2Wgv/uwjlaJxCirTAgrmwJdblRv1Kaqs9FEm3E
   aV4SWlTVpqr/9Rhl4ZDHg/dfPd0agb1KE87ErVAcNsOD5D2kadMR3wHmA
   +i/0vGKId2L1KwYeU3rFHufFmmUhXMITtzuCMmiCfeXwJrCP14OHHOs4Q
   wSYaRPnf2VVKfik6MAYhUha2EPfUfjdqPBCyFe4TO2DYRpX/ID5ZWaAYT
   vCxf4lLSkLTUcl6FBXvEQDP4F8Z6oSzvAtHeS6uH14pFYYEuuaGs/eFmH
   Eud3IvhEPQIM7rQ4FPfREGwikEqu5J5nsPjuLQsooINmpwPxylnJ/5REu
   g==;
X-CSE-ConnectionGUID: xBOsIUCHQFmYHEP5Xq5j8A==
X-CSE-MsgGUID: h0rH0UXhTzS1sSExY8bHgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="77986640"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="77986640"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 02:11:07 -0700
X-CSE-ConnectionGUID: rBDgOKUKT/WMouEnGhPKLg==
X-CSE-MsgGUID: dweRWDToR/mBe9KmcQ7icQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="232762282"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 02:11:08 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 24 Apr 2026 02:11:07 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 24 Apr 2026 02:11:07 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.62) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 24 Apr 2026 02:11:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dyaBX14pxKtiJ/ftTbh8DXqDW2L9Pgofiz9RFez61ea7aMEjDPuw0/T7RMwf+rapuxuo1t6OGm7AUddcaC+ct+/MoF/3OEeE9SyHhKJ02woHYSIM2CbVWiVAXm3rHGlHIQMhZuo7njm1Td1UZ0gCFiPBNYoNze1RsJwol6ksTBFl8V+BJld2o/D4m76O1BEw3XBCZokcmJimsjCmRkTTlErb5qDKns36Un/fgOZ4zN/fAlXzx/KO3MLXqRkEKWq2RBuXB68DglhGLEWI8GUFvxd6nqV7Oku4UeN+eXk9lei0qfnanbH+F/qbi2A1HwbYnWqa1y9YrHRjskCt+NIxFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rnHfYiisa/bjTyPsxsIga8CQxJOpgrBRmli04GVyi0=;
 b=bxxBQcB2qWCrhDBs3pmKe7fDY2StC0WLYgO5vHCbTKNf6Lo+o6Dh9sL2UH8VFF2FAILWTWTu3ngRbumNw5tnHNu/1HXZI/4trNtDnjz2xypXX8OJmOJRpb/G4KPRpInGVmDmEu1IwFpKWZMIhjprJA4C0wNP1NC3eJm1U9GwA5+dPv18HEosTPvzrTLiphCHzv3asK9YQNaZnFuDwauY5lSApP8jig2sQW0QNaEF6xXpdJQ/SKEDpQzv6i+04DEWBqIqybsD4rFc5xXXqIoKpF9yYQid8Rmdh9OFKlleow2VnhyDdjfDE2VcCj7bNa6d4K2A643AJW8SZ4iApwL9PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 IA1PR11MB7856.namprd11.prod.outlook.com (2603:10b6:208:3f5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 09:10:58 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 09:10:58 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Xu, Yilun"
	<yilun.xu@intel.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"Gao, Chao" <chao.gao@intel.com>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 10/31] x86/virt/tdx: Add extra memory to TDX Module for
 Extensions
Thread-Topic: [PATCH v2 10/31] x86/virt/tdx: Add extra memory to TDX Module
 for Extensions
Thread-Index: AQHcvgcsp3iEtTEG/UOFY+bW5PCg8LXr/O0AgAENtYCAAFqbgIAATY2AgABUbgCAABE5AA==
Date: Fri, 24 Apr 2026 09:10:58 +0000
Message-ID: <a5fd1a0d32892bc9b7f264bf73d0d13f08113bb1.camel@intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
		 <20260327160132.2946114-11-yilun.xu@linux.intel.com>
		 <89bccca9a409e02667278fd83f0b7b9064557dab.camel@intel.com>
		 <3b0bc0dea544b10bd2fb0304a96d2671f263829b.camel@intel.com>
		 <48171f4ab772da546beccec3c7a95fe442524b42.camel@intel.com>
		 <aereVy8zVb2be2hh@yilunxu-OptiPlex-7050>
	 <668a903ba2dccff2d641ac15b74deacc95ef19a6.camel@intel.com>
In-Reply-To: <668a903ba2dccff2d641ac15b74deacc95ef19a6.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|IA1PR11MB7856:EE_
x-ms-office365-filtering-correlation-id: 96c2bdcf-0127-4b0e-7e6f-08dea1e165f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info: geE8qAf+Td9DdrzqHNYOy3AEKyGPxCAosQgh8ye3Ovlc9YuOppwENACpb8gXG7bT50wpyLA/I0JAo19Xy0XNGJpicDtNXvEMi2UPZOSkt7fmaLwyT9/bi6mWnjJ+cUTu5EiJiLOF5Shsh/4iMToHlr/l2asw5B1H7YrzVyOk5UH15AuX2Je0noqvyLmZ2yn12ZObIE/DvBTWGV8qH9zB9HgZ22VPADWu4CqGvJYnKFsRetK+m9WVL55tUesFmo4SRYc2VmPKZOZNJaarfBqFJ0/if/JXjmiOmUq3/UIlWHW4wjFugGKGCb2tvsm0yLuItYGMKV61G7axt8bUB9ed+0doB8AaK0aijiufSN43lHpzlt+Ph0Ujx4mCQEytmbNLDCRXlFlYsIFtDJOpfc2dTyaX9aT/3aonEwA7IxzYKaf/kMv3WvDJy3OL99vL5P3nHaW1F/MTGfHF4/Xmv2DfDflEitCPMOS8q+nITIftDCNs0befsSjo5hV0XZ++UIX5iat9BN+af/acR3rXgwiwbnWMIzSlX6fwenZU0a8eteqBpdboESNdvHO+IkDBh9cqslxh6hzoEKUABNouF5DqNhCveAQnbMhlsu4TzWKI9/zLH37gYkdnX/EJGPzV/1FjF9ITNVLR63Em5aQzqhYA0NfxQsDvJajphJpe3JI2dgF5er8ufWAA60wS2Z1JhHaG5kuJo5fzhj3xs9p1HYOeX/49jSwXNYVN3EsnhTtUVJze5RG38KQ6Xwp/dpt8hUhztaszRXp6t2SxZiUs462qQ0tgQ2sFADxKKceSE8W0UBI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnhkeVRpTzdnOVp0U3RxZjcrVWdmUnR1eVRJVGdmOGphd3Y1ZGJ0bXFGVWEy?=
 =?utf-8?B?NmN2TjFzUXkrV2xrSkp5TDdHTVZwUUQ2S0Uva242ZlliT1RTbHpOVEdub2xn?=
 =?utf-8?B?K05GNkFyNC9Yc1hkYWV6NERIVENZTFNNVjZxbHVJanRVQjdBc3VYYmdkNUdz?=
 =?utf-8?B?ZG9kUXZrY0tZZjRoYjF1MnpjYVJvelBxc3ozenpIUTBPMnJ0cjc4aHlZQUsv?=
 =?utf-8?B?MUZaTjdJNzEwcTFBWWpKbmZyeHRTRlgvMitzNHEyUVplUENDM1o0Mmdyc0o1?=
 =?utf-8?B?Zk9odzM0bWFsV1R1UUhvRzhla01HdnBpMFIwK081djB6bTE4WStkVFF4Szlr?=
 =?utf-8?B?aU5MTTI0RXBjOVlVZzhkSUcyTk5sQkV5dVIvUHdMOVZlUXNoZzYybnVsN2Rm?=
 =?utf-8?B?dWlDcGVFS3FIcmlNZUlpczgvbzlnNmYrUzN4aW9nWnZZcjlLRkpFTnhnd3lk?=
 =?utf-8?B?MEhxTjFIZ2h3UUlLT04zek84SWhpcE1FVmxZbEhibWplNXl4cU9iN0FCUEN5?=
 =?utf-8?B?blo0Q0lSOHI4S3liU0UwU2JDQ1pReStoWXo4N3VqcWZwWm02SkVVaitPL1Zl?=
 =?utf-8?B?VG9idlZOVXUzQlE5NWZ1dWhGS2MzRmVKTjFnaGw5Yk42ZWZ3WjBSZ3g2ejBq?=
 =?utf-8?B?bGJmbUQwWnRrektKbXJWakVWOHB3SjFKN3BnRlNhdUZQZTdEODNtWkY1M0pC?=
 =?utf-8?B?SnFsYjFPNHNWTnhkT0U0MFBjWGd2eWVsa2hlSmdmUk5xaDNaM3Z2SVVTUDVN?=
 =?utf-8?B?WmUxYmpUbUNtN3JlMDcyaDU5Skt3QWtaRWZJZEdvZXREcjV0V25RQ1A4ZmM1?=
 =?utf-8?B?NEhwYVNRQitub0EzdDhveG85WWZzOERwais3ZVVEcXNMTm5hL0t6MXBuSlI3?=
 =?utf-8?B?NTVoZjdyMW5hbnhtdmJ3bUpiN3NqMG5haVcxVWlOdmtLZVJ5ZlZMVXNLRm1q?=
 =?utf-8?B?QnZPMm4vOWE0RDRLUFNvT2NMZzJFWTlhUmpremJRTEhtVEJPWkppZUR4MVF1?=
 =?utf-8?B?U0MxdHJzSWxaaTRaeDdSbjd6WWdVMjk0RGpzclJGMkhjajVyaVVPaTBrSzlh?=
 =?utf-8?B?Q1lmaWsvaW1GSzRxN045cU9BQ2JqdXhxalBoQ1NZNHhJK09QNEVrVS80ZndG?=
 =?utf-8?B?aStGYTlzVmdiWEdvblBxYXdyTVI0bTZ6Mi82NHdKVW5sTm5JMFNWVC9ubUMz?=
 =?utf-8?B?YlNINW9EVEpvSjhjMFdGcUtrY2FlaVF1N1dub1NzVjE2TzJ1eHJRQXFUUzJ5?=
 =?utf-8?B?T1BBcGltZW9NZXJpUU9xbDg4VjdMOXZqZGg1Q0I4MEQ0ald3eGpCL3JzOVNv?=
 =?utf-8?B?M2JFdE5OWENNMy9YLzVFR2hPNENUNytGSXYyb2d4clRaT0NTeW9WbTB3MHdB?=
 =?utf-8?B?SkJsaGRCa2l1S045bG5MbmhjaG83ZmQ1eWJScUo5SEkzMDZraldnZWVJelBt?=
 =?utf-8?B?YXc2V0RNL2hBMC9ndTZVaGNmY1hJbm1xbHZpcmhPcUtHQVAwZldPU2cvUVJr?=
 =?utf-8?B?bS8ycFNRUXM2ZXMyeG94bnRYczNyVkR4VU55MFdidVhzOUgyZzd0TG9BaVg3?=
 =?utf-8?B?Z0w0WVBmMXQyRlRZZW5IVTJsMld5ZUx3MGlWSEdJdHBIRHZ6VlV2TG9uRk9y?=
 =?utf-8?B?bTNGSUxhVHBOblRaV3VLVkJUN0ZMUHlpMFZlZk5FTGRpYlVMQjBrMSs1VkNX?=
 =?utf-8?B?OGdXa2IxbEpkcjNzMHdINEZwU0I5b3cwclB3bTJjL0RwY2U1cjdtQ2UwczNj?=
 =?utf-8?B?YjJ0SC9ZNm1mTm9yV1piN3g1OTRBbFhUcXJuUTZxc3RCSlNXZUQyRWRhYnhk?=
 =?utf-8?B?SjhpMkg4L25OTk9lUm95TndGbkk5emxiZGR4WG40bVV4VmtNUE0zM0MvL2JW?=
 =?utf-8?B?aEVOWEhwZmppeUF1Zkh1SVp3M29QNXhiKytzend4NW9TZ29LYWZhUnp6RTR5?=
 =?utf-8?B?YU00cTlFZXAzUU9wM0ZTR05sRkVYbHZaVkJ2Z0ppL1ViS2NTV1ZMNGMyazZW?=
 =?utf-8?B?aU9MUTNwWjY4UGMzYldLVk4wc0dIQk01dmd3QWNwcXhGdjBuRW1QRm1qaFBn?=
 =?utf-8?B?MkVXKytyR3VpLzhqZVZmTEdkWTV4SytUS2dteWZMamljcEhQbDJ4Qlg3UGtl?=
 =?utf-8?B?SDMwT0lBZkJ2aHRHOXFUN1RDOTdaWDM0WFovajIxamlmbTZzcW9HeUVJdFRX?=
 =?utf-8?B?V2tVWjBZQWRwMkVtMFh2dDZidHMwWmxlTXhZb3RPT0dSdmU0VGRPSUZNdjhY?=
 =?utf-8?B?OUYwQTA2eEprcGhsT212L21pL0s5NWc3SDJZYjNFUlRNanFyWmpjRWl3ZWls?=
 =?utf-8?B?eVJMYVB2S0pPU2IzOTlZdnk5VXcvcU1KNnZTSVRMenppQXozZUdadz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <478F2B08823D9243B7E71C21F4EBB440@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gFEm62+LABH/tnX6raKPkqcpC3UTfDfbeSh4j1Bgj6cNlF0pp5bZt/+yZZXrYpF+neFyWDKA5y5NHVoCsQfKOC0iAR+uUWF6cTfJCHMIF9fAukbn7rxV09DS5EZNbecF8UGZpDCJTy5yoE+TW0FkzpJJkPOu46ZphgReNcb2jE1auz9amWqY/gKEzh/Y11hHC910Oi5uaWbl0FkIOrMOKBnlgxRFGjUzRqecInfNarErYY93iDkYaPV/zmiCeGKUR/dArqBw/dWM+3EBNfV7rByf0fZeudCo+E3qI92CT+Dab3O2AXVLzLi1iRl9CA3jClbb3UZHrvzqEZdYj2QW2g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c2bdcf-0127-4b0e-7e6f-08dea1e165f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 09:10:58.3437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CQ/JuPf8wv9Dhoxgi9CvBkULD5fNc0FwiJf4diMbjPiZC+EoTTk9DgMNoC1oGT+Kk4G3Nj5logBiej/ZD8ggng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7856
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA0LTI0IGF0IDA4OjA5ICswMDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiBJ
IGJlbGlldmUgd2UgY2FuIHVzZSBzb21lIHNtYXJ0IGhhY2sgdG8gaW1wbGVtZW50IGEgY29tbW9u
IG9uZSB0byBjb3ZlciBhbGwNCj4gY2FzZXMgYWJvdmUsIGJ1dCBJIGFtIG5vdCBzdXJlIHdoZXRo
ZXIgaXQncyB3b3J0aCB0byBkbyAobWF5YmUgd2UgY2FuIGhhdmUgYSB0cnkNCj4gdG8gc2VlIGhv
dyBkb2VzIGl0IGxvb2sgbGlrZSwgdGhvdWdoLCBJIHRoaW5rKS4NCg0KU28gdGhlIHByb2JsZW0g
aXMgdXNlIHdoYXQgYXMgaW5wdXQgd2hlbiByZXRyeSwgYW5kIG9uZSB3YXkgaXMgdG8gcHJvdmlk
ZSBhDQpjYWxsYmFjayB0byBhbGxvdyB0aGUgdXNlciB0byBwcm92aWRlIGEgc3BlY2lmaWMgZnVu
Y3Rpb24gdG8gdXBkYXRlIHRoZSAnYXJncycNCmJlZm9yZSByZXRyeWluZy4NCg0KU29tZXRoaW5n
IGxpa2UgYmVsb3c/ICBJIGFtIG5vdCBzdXJlIEkgbGlrZSBpdCB0aG91Z2gsIGJlY2F1c2UgYXMg
UmljayBzYWlkDQp0aGVyZSdzIHRvbyBtdWNoIFNFQU1DQUxMIHdyYXBwZXIvbWFjcm9zIGFscmVh
ZHkuDQoNCnR5cGVkZWYgdm9pZCAoKmFyZ3NfdXBkYXRlX2Z1bmNfdCkoc3RydWN0IHRkeF9tb2R1
bGVfYXJncyAqYXJncywNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0
IHRkeF9tb2R1bGVfYXJncyAqb3JpKTsNCg0Kc3RhdGljIF9fYWx3YXlzX2lubGluZSB1NjQgc2Nf
cmV0cnlfaW50cihzY19mdW5jX3QgZnVuYywgdTY0IGZuLA0KICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdGR4X21vZHVsZV9hcmdzICphcmdzLA0KICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhcmdzX3VwZGF0ZV9mdW5jX3QgdXBk
YXRlX2FyZ3MpDQp7DQogICAgICAgIHN0cnVjdCB0ZHhfbW9kdWxlX2FyZ3MgX2FyZ3MgPSAqYXJn
czsNCiAgICAgICAgdTY0IHJldDsNCg0KICAgICAgICBkbyB7DQogICAgICAgICAgICAgICAgcmV0
ID0gc2NfcmV0cnkoZnVuYywgZm4sICZfYXJncyk7DQoNCiAgICAgICAgICAgICAgICBpZiAocmV0
ICE9IFREWF9JTlRFUlJVUFRfUkVTVU1BQkxFKQ0KICAgICAgICAgICAgICAgICAgICAgICAgYnJl
YWs7DQogICAgICAgIA0KICAgICAgICAgICAgICAgIHVwZGF0ZV9hcmdzKCZfYXJncywgYXJncyk7
DQogICAgICAgIH0gd2hpbGUgKDEpOw0KICAgICAgICANCiAgICAgICAgKmFyZ3MgPSBfYXJnczsN
Cg0KICAgICAgICByZXR1cm4gcmV0Ow0KfSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICANCg0KI2RlZmluZSBzZWFtY2FsbF9yZXRfaW50cihfZm4sIF9hcmdzLCBfYXJnc191
cGRhdGVfZikgICBcDQogICAgICAgIHNjX3JldHJ5X2ludHIoX19zZWFtY2FsbF9yZXQsIChfZm4p
LCAoX2FyZ3MpLCAoX2FyZ3NfdXBkYXRlX2YpKQ0K
