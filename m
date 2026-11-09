Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794236435;
	b=cmGoedG0bBVkiVEgtu/GSN0rLGJF1PpH2JRqDdEcW7jhWomo5tgDKv9M52SrT6zGh7eC
	 I4q8yjmIG5KzAdur4fAkkUtEVXEp3/GHUSrRvksGik552o4r9dDrHNzSbMmNtvE6wPVX9
	 6eXyqhXVE32fN1iu30sfCEQ4IdYEuSlZQiV32NR64Z59WMSHIFSzFp1Xne2vyhVdyGhGP
	 TB2v8/MacMFt1FVsV1jzQNON9qyGqwIK50FKzBB4cRVrZua9xP5makREgcINaJuh7GNeX
	 Efp+zadSYe9HQEV/QyPB4fVq7tsG9OTHxpa1PJRRET5RfqzOWo/5ZhQD8s21ZAzAXAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794236435;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=iGXACBxujb6IpTtKsqG5qaTxWxvUbzob62917gCDhhE=;
	b=3FqcXaFCJDLCUPSKx2gSwHz46L+X7U2RVIPoLolR8tB3OENLbnMBgHLjffVllqloiXIL
	 4xh8izl5k1f0B67vtF3O9NE3JL/mTIP9Wqpf9OY2xOpdnuBkwqBwQOajrZDTzDvwISvNP
	 WYhPJF+SVwISfZocUcSAu5e6F+fwv0OAMPkfInyHJ94gRx0a7O019irAEQA+hEqIKIiTd
	 yZU9cv0K5I2EAxSfiIqpMmLEHs38L8cJQ6HFI0KGHhoiuPYl1Ulf5O0PmYBvwwDLSkCBD
	 Qx9PYF5BnLJ6tQy5HmwrYpkgnGb005sm/2KlZOSZHlztiaSJAxRdmLGjHzF9L/AtLsw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CRU8jZxy;
	arc=fail smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F82606A31C;
	Mon,  9 Nov 2026 15:00:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98F82606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CRU8jZxy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794236433; x=1825772433;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=2jJ9Dnv21l6vrL1QuHqMF5Y9a/yMknOwOak0Ch7zPlA=;
  b=CRU8jZxyB8tDUgn/Nm3uOrmOai7JALodKBOEBtGCrv7PvVGX9bo6n1Z+
   uftQbhdEGM6vmexszlXnNvwdvkyuoiZ6YogCh4z69ccmy99ro9b2dlpUq
   mMyBFpBQcOK2QROBuvFpiagVpWN/LeEehjQ4MaMc5Cerc0HdkmQGhAR8K
   qDY3/Rnrd14q1u50Y97F7QyrvVMWUBRSIZKgjvynYuRw1DElVhu9LtcMZ
   ww+G9XpvdV9c6JUAjWPVcW62ijp9CQbebKJdOlzzZEXuUcmi5n23/5yTP
   ph4UewKPmw600GJURg4+L26lB+o68yQq1VFbhdYodXwyhlqeCwAQYYYkN
   g==;
X-CSE-ConnectionGUID: sCJJWaz5Rfe3WgrfiSM1aQ==
X-CSE-MsgGUID: /+kxbCj5Qbeek7ctTbfnyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2839336"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2839336"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 07:00:33 -0800
X-CSE-ConnectionGUID: YDpXBZzHRiy2nzJ2W8BTYQ==
X-CSE-MsgGUID: ks0+Hk34TiamyvghRmnCsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="7934665"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 07:00:33 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 07:00:32 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 9 Nov 2026 07:00:32 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.22) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 07:00:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FtCUiySNprPJ2/l5fQHMdgTFzLFH5N0MTwzsTE32kvqgmQYA6ta3CMFvYPbZG9je7IXs74f6gn7av49gW83lNHcRC1v93t+xB15Rc0sbGSmRRMXugjsPjfwj2NVJuvq/jwVAEOh9d/JrxNZoq3KM2xQcF60cLOeeYzXQNd5HcYeidBfHNHNjZ3e6XPydfh8ne6LXs9o/F3Y250WxMNkm26atR8XKIMIYws7FfQFMyUk8pHWS5NtP3RQCraZiSpOEFFMDh9g43ekLOkpPEMVYYH08CROPDiQ3eIGeOma0/7dS0moxOFnI3AN5TIau9dWWiSffT3wfnTNTnMW2u4hY3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SF7kNKtoGnikwgyYdBZcmkmmQ9KvaPx6UpwoXbFIiY=;
 b=HbAoAFKE5MHJMmDt0BUx2MEr0V9GDfT9nRBvp/bCJKQ0E8spDVQjn/6MUC7FhEjz8LKsb+sMHqtiLImNcL9jnsqtk+BynfQGOYfVimo1ZzAfkX9F60fF+NYo2Uuo0MTLNHUF/lCnh2HLZ6DIzsFYKJRBHC2SPlKuarXNn0PixXiDADE8DDBpQ8mgsoMGWrgDxH/zWePRFALAQoGsnGpKjnj/3M8dsnoOyHDwqD/cRgIKHNrQgc1RIV0tKIS/9PmIkOzhR7eWMzGOeG8+dgEpVx4arVyFNRKfELkGKtWGT5IiCt+oFLJ97wVcMr5FIDx0wbkHuVT6OyoFPxZuFdzI3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by DS0PR11MB7877.namprd11.prod.outlook.com (2603:10b6:8:f4::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.11; Mon, 9 Nov 2026 15:00:22 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 15:00:22 +0000
Date: Mon, 9 Nov 2026 10:00:18 -0500
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Matthew Brost <matthew.brost@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	"David Airlie" <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	<intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>, "Jani
 Nikula" <jani.nikula@linux.intel.com>, Joonas Lahtinen
	<joonas.lahtinen@linux.intel.com>
Subject: Re: [PATCH 2/3] drm/xe: Remove driver side resource assignment after
 BAR resize
Message-ID: <avHgAmVk5jCTkECK@intel.com>
References: <20261109131011.1815-1-ilpo.jarvinen@linux.intel.com>
 <20261109131011.1815-3-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261109131011.1815-3-ilpo.jarvinen@linux.intel.com>
X-ClientProxiedBy: SJ0PR03CA0250.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::15) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|DS0PR11MB7877:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fb19f9a-4fe6-45ed-3768-08df3e722daa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|7416014|11063799006|4143699003|56012099006|261022105027099003|261021123027099003|261021121427099003|261022075727099003|261009223027099003|261028144727099003|261026140227099003|261102123227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: jEwldTyjbgOBt5jbrtT7P/rw6ZkAmpTlyLSTGK+a+yLpTiP1exvjEXs7AFvxT87y2jW/CupRaKZE/KXSvR3OpIsYrgJkzngMM8PhgqOlfA41oq0oevS4e4YhkLx7vfGG9v3P8IESFvsIUliRdBS0VhX1jLFjSw9qcwoE7VMUd5fqgB1ZuypyxkE8Pt1UVsY1/p3zDTos/gmkFiudw50jH1lo8OdMDs7gLq7tUva0VRr2tLnJ/MI+24DW5IWMdI9L8lVA6SYdhz7iqIgYp1KIxHaZW+vVcW9fQ3tjneKA+KCiIifS5BniLZimnf+eiixN6oTWAuBE0lwfgHf7RIblu7x+kxHkM/jMhmYCPHnmxQnN26k655f3F5NLHwOpXdHGO0oTNhfvLo+BmoejQ+SXfTFVrpCdI54awX3cESdDCRWjas0M1+F8r6cX+OL+t6VK41DBqozoM69at4woW3AsVWGqv7NGizZsg9d0tkZU0b3GNmI6FLM+WtvX5uySAPiSlPAqbVSmOwRDDxlT2YO+RJ7QHida8eDirQx2ebgoO0JZ+UtH5AWFQzE2L5j81AmC/h52H6KrT5bj085M/PHhavgRLYuCS5xtlXHit4Tj7eF9LEJ9EC0N4vm06EAFNS3NBZwKNIu4HM0dLPZrpw//AgNcW0kXG+eSaxtBnjzv+oI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB7187.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(7416014)(11063799006)(4143699003)(56012099006)(261022105027099003)(261021123027099003)(261021121427099003)(261022075727099003)(261009223027099003)(261028144727099003)(261026140227099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?quyoCj92hy6kkzl8Pj3AgTAmtJcCJGbcNsZ8kPZF++SsKWiP0RDeFtnIZQ?=
 =?iso-8859-1?Q?Y+HrZZLgkzY7JqS9F4NxZ6wnCqdeQqWrHri2fH8Te8FW/GiOOB89jqPUZe?=
 =?iso-8859-1?Q?ZyN54IpD1J1V1I9cd3nCL1WiuTZfazqJSMsyAoKUrMBd4myJfmCU9Q4Uxl?=
 =?iso-8859-1?Q?ko3fNdkTEpv5O0BQElJmOUmjTBxAUBBEtCvTYnEZvsV/bW4knmPx0T2GN/?=
 =?iso-8859-1?Q?LRm0gkc8uiDbkBm1VRVqCT2m7eKKRZ+BvbPMFX2Rq0lIzpqECVPg0577Cv?=
 =?iso-8859-1?Q?y8+uSj4UoEfR+//K8QJQ4N1L112iMPm/W96Ng+eQvdsPBcJtn/seL4JcQY?=
 =?iso-8859-1?Q?FuJe/4GLf8NWAGsqMENR9aQNrOESfkZsSaK/kPgwu466ZgmyHEzo3CYOgw?=
 =?iso-8859-1?Q?8FgKuKo7CCy0GOjLRTHy08TKdeZVM/R/UJy9TIwmOpmianP5ug92sO/jpI?=
 =?iso-8859-1?Q?RYvCo03PGv2MekdHfhQBTiJD81irhKVZ+Jnp7z7kWu4ruGH6gyqknSzhL5?=
 =?iso-8859-1?Q?lfBvUWvGNTbDSHgS143WLN4+F54smukEqDO2Lj+d7LRDEVsBmbcHrA9Szq?=
 =?iso-8859-1?Q?2bu+Cl9+NJXhDYcEVono4GR1jSCMd/EfBuCRIbz25mD2zAltKE+L1SdtYM?=
 =?iso-8859-1?Q?6UdBUiikoBGEqRtl5P0MpWk0LTeL8zaqaJtYxicTVQXM17Jd1Vy4kUD2cG?=
 =?iso-8859-1?Q?hXscysS3On1i5nXGmL1LVvqYVOs5VdCd0AEiVX6/lFzER/x5b1Gnbofgaj?=
 =?iso-8859-1?Q?CCweNsM1dfnTNP5yu3Tg+KbHWY3JcTBw0aJzYVslLdt83esEf673PpCMyH?=
 =?iso-8859-1?Q?KJEJo6HcDVLUqiGkFd72jzMS0R91HgiwzF2PNYb49clBnCzizPPPPN+ebz?=
 =?iso-8859-1?Q?d9D9siNR6aBgCHwnsgqpDRwTB/LbFwDpwK2Tv0uWvgujiP0ugoU7WvGjaL?=
 =?iso-8859-1?Q?OGXCn3I7kFLs6x+zr8catSHFtGqk/kjLG6HacW1QgP0IhRpAe07qrSD8JH?=
 =?iso-8859-1?Q?MdZCACDjaZrTaGL0XEnqWvKirgcAFSPicXWo12fpWhNYPs9JhMl4tVOxKM?=
 =?iso-8859-1?Q?DaLoF1lbdHwup6wNaFctlplsoLfjlTjZcTSxl3M1Lm2THLaaKJy9CLrlI3?=
 =?iso-8859-1?Q?ZGdHTqnIkZeu2Q7LveWRIQvdHTUxPsvsxTA6b2tdO13wmsOB3IoEiaWWNS?=
 =?iso-8859-1?Q?rh94tUfch/fpZ4HIhE7bTmNbC+24mjXiJ2l/AL5lmSxXx//0RBYajVSDZb?=
 =?iso-8859-1?Q?ssjX7lsSkRz5WDSZUIiDvkqUahXezIf3lu21CR1z6SMlsMQ66gOIvRfgvV?=
 =?iso-8859-1?Q?8OraSjMEFg3HVVLfGx62wJz3icgvmWdZ4SGpSuoSN36e3UxsZ8N9bk9Wqx?=
 =?iso-8859-1?Q?JY9ifR9VCu4MLw5lvf6n3egl1N+GZuPhEpeJ4KO1IWL7LmlzvEYIlg7DDD?=
 =?iso-8859-1?Q?KVZ/BoiwMdhqyLahL8eO6PlyfCRd3R76H2k58Zdn6h97CrlOK2d6cwMM4m?=
 =?iso-8859-1?Q?sQNHGFDkgZ4hkCpdrTI4NQ5iBMnI9XMAyVK7xJ2UA642DvHUA/kgwkQNsG?=
 =?iso-8859-1?Q?3B6tZg6nCDeEkka1stMpu/AEi6B0qVkHZ03wVagEhnkEdpSGgu1LEtIzpP?=
 =?iso-8859-1?Q?Ks07RCqzpzBDV95O5/rBPnloUlIVtLqqWU/sCU7yToAsoNmd4XSYylv5aZ?=
 =?iso-8859-1?Q?ak7gKuastcnn4sRYs0WUXHYpFJN73owFP2KnnGOCz0oCP5sgKeQs1iPmM2?=
 =?iso-8859-1?Q?iKGps4sMfixKb6cZILB3c37RYqW82IhDnj5LBunByCvgdZM4l3kot4ekVW?=
 =?iso-8859-1?Q?oD/S89Wrsg=3D=3D?=
X-Exchange-RoutingPolicyChecked: m+MV831OY033Ko62gw+jLXqgB2853dWwI4757E2ngpumKmSeldSt0HJXqjIHmmCl1skf+LiF5VED2L7kF1xV5+FpXidErpmRSeDQgunHzkN7QdBdq05ILfmRennjCEhLjOUW7TCAzxiHYigGRMk+nbnBczS2d/EBEED8jxu8EKos6ehpW4NTpDnScDNEfKB7sx/Sv0RhsMIM68ZQOhyYX2Cou1TYeSVXizue8Bk72QjKJ/kiuzf+sxgQJz6XPO70a0VqkcTjpRje7KzQuQy+yN6t+xBJsKZYaSkHLtvyQGkfrCbSYEYIR/xUDwo8sqtnTqe7cci0rsehpdCuQQRd5w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb19f9a-4fe6-45ed-3768-08df3e722daa
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 15:00:22.6038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h4B6OIfNtm/VVubdX2ypfWkX1OXbZ4i8ZYj7IkcsKHr7/rEzFoJ91ZTAbO+oZj3RG/e8Bn792HlUqNFdEnSdiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7877
X-OriginatorOrg: intel.com

On Mon, Nov 09, 2026 at 03:10:09PM +0200, Ilpo Järvinen wrote:
> pci_resize_resource() assigns the resized BAR and the other BARs it
> released, or restores the original configuration on failure. Calling
> pci_assign_unassigned_bus_resources() after it is redundant. If that
> call manages to assign more resources in some scenario, the problem
> should be fixed inside pci_resize_resource() instead.
> 
> Remove the pci_assign_unassigned_bus_resources() call from
> xe_pci_rebar_resize().
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

feel free to take it through your trees

> ---
>  drivers/gpu/drm/xe/xe_pci_rebar.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_pci_rebar.c b/drivers/gpu/drm/xe/xe_pci_rebar.c
> index 7e2c7079b6ff..f47b3c039abd 100644
> --- a/drivers/gpu/drm/xe/xe_pci_rebar.c
> +++ b/drivers/gpu/drm/xe/xe_pci_rebar.c
> @@ -100,7 +100,5 @@ void xe_pci_rebar_resize(struct xe_device *xe)
>  	pci_write_config_dword(pdev, PCI_COMMAND, pci_cmd & ~PCI_COMMAND_MEMORY);
>  
>  	resize_bar(xe, LMEM_BAR, rebar_size);
> -
> -	pci_assign_unassigned_bus_resources(pdev->bus);
>  	pci_write_config_dword(pdev, PCI_COMMAND, pci_cmd);
>  }
> -- 
> 2.47.3
> 
