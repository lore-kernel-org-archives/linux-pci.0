Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF94337B9A;
	Thu, 22 Jan 2026 19:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769111192; cv=fail; b=NGsftG6k4esOyvMbBJHXCPtarNz7+huCy3rsxmI+QC/5cl4Kz/TPTq8e7nd/4ssMnej1qY75p1iqVWqsGAsTDLKvH2TR4hJwjOuBlFlAoDvA5vyusX7rYtdNsbSGYt5bTtfsQiE1pz/DRTC2RdUeUTvLvabC5KwneiRyrzvVe+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769111192; c=relaxed/simple;
	bh=owF4gU4elaCKD7lupaMRi1+ifVl5cFP0igirvVkcK5M=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=tNhh+RmGSLuYx2HoQ4fqCOqbN8iUUNwasOxtfE3fW2ERyW0qagRdRm4h5puQYpOAoEBZotUg3GcdmAKz0wRTX+74D/bv6M88SrGrHeyDZMMeFuAkEk6DhH6gPYa4UwhxIFIXeBzNpLCnh3WLX7HO5wbUYykQtOoc68007IpoWG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IUDNwf/K; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IUDNwf/K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769111186; x=1800647186;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=owF4gU4elaCKD7lupaMRi1+ifVl5cFP0igirvVkcK5M=;
  b=IUDNwf/KQ3DTq3doitfz+Hhx1b4oFq0mPkkmraZ6jtDrChwnV/FmhOx1
   yT7mqAAk5TjGQFflVBzx6TutPVH7acA8ZxoP4WkxkGazGZWQsltYsNotg
   vHSh0sjWL7hT0MDIE/1wu1IPZF/3unawrQl7udrEcWBlFRv1L/vQQQIgJ
   g2a86/JXfZUXApDSaEzwuZEYN46inC2sy11Bxd9soJpShGwJm4TKuSZ0D
   01REj9c3pduVDVuwyx4HsCswXdmUyaAoqAXe2l0q3dhZr5oTm6H9igX0d
   VzTtMahmwqZ9l6K8aWpis7YjTeixXVjz/UfIlrodQ1/ctEq3DnaG7BWtI
   Q==;
X-CSE-ConnectionGUID: ShGNo7UaQ06K4exUILavlA==
X-CSE-MsgGUID: RavwJ/6DRSW33KyzeQFL9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="80990337"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="80990337"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 11:46:20 -0800
X-CSE-ConnectionGUID: Jscm2n4BTM6ZpCH7V6MHFg==
X-CSE-MsgGUID: prGllr40TK2RjzoWgr3W1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="207080130"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 11:46:20 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 11:46:19 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 22 Jan 2026 11:46:19 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.26) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 11:46:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cv8nqhO0o8/OFm55Vso1KideXnSuwW2TJYf7W2zJ34khBu8sqSn53VPUyOt/SWliNKYK6RyR6W5jxZ7rqZb2hsMXz23At8DI3xIQreGJCP5EzbiCWEAh5/5hlenKs8+vSdB0OOHSABPpk9LvKOefzCze2WGz1GtZejLBcCPNygR968No32vKV3PguD7aFtfPqBeKTPuWU/9jRMd5Mw0uBSI0bvT2rIGy9bJekZ0BGGdxclntjGMSoofLIxcd8s0GvjOwpTWzGxAYPQPztrNRs66w5Np/E0E7KHOensjc5McC390SpF4eauO5aLpv/jkqmojBRPlgQtRFn+akJCBoUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpxL4jASNYd7ROdFDAU8TdZT8uvMJWPVA+klQo2FTzg=;
 b=ZDDjLmpmrhuFJaLzRnVhoiiOuafo3BUo66srgS57Zf0iaQ7kG+x8g0aqfPQeOV316++g6G+5yP5ewUH5Y43cb17OTPqSbmZKxZ+NUMX/q6QGaWkqdntCXOXh/iChX/bo35GLR6Re6GJ1oIj7hSjNUjWvstO+km9K14UxFIlF03b23R1iqNVS/Ql+Xe84irJgBxN8v5SJln0zrZYZvPkqMD94EGtpyOTFcysvtzipS4Sst/XVyNOlpVbyyEadgTIQ79LE793moeEOvyDeRoHevnxx+GdFdEH2W6EgLNh2olAZmI1Xt5KAmb/Vwk7U4UiTVPi64U4oafK2+hWpXJKVLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CYXPR11MB8755.namprd11.prod.outlook.com (2603:10b6:930:e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 19:46:10 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9542.008; Thu, 22 Jan 2026
 19:46:07 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 22 Jan 2026 11:46:05 -0800
To: Jason Gunthorpe <jgg@nvidia.com>, <dan.j.williams@intel.com>
CC: Jonathan Cameron <jonathan.cameron@huawei.com>, "Tian, Kevin"
	<kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org"
	<will@kernel.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "praan@google.com" <praan@google.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"miko.lenczewski@arm.com" <miko.lenczewski@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Message-ID: <69727e7ded712_3095100ab@dwillia2-mobl4.notmuch>
In-Reply-To: <20260122131432.GJ1134360@nvidia.com>
References: <cover.1768624180.git.nicolinc@nvidia.com>
 <d1768bb6384050a23769f20ca28216f520f77e26.1768624181.git.nicolinc@nvidia.com>
 <BL1PR11MB5271F0BDC68C2D7F172122E98C96A@BL1PR11MB5271.namprd11.prod.outlook.com>
 <20260121100307.00004e60@huawei.com>
 <20260121130315.GE1134360@nvidia.com>
 <6971b9406d069_1d33100df@dwillia2-mobl4.notmuch>
 <20260122131432.GJ1134360@nvidia.com>
Subject: Re: [PATCH RFCv1 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0131.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CYXPR11MB8755:EE_
X-MS-Office365-Filtering-Correlation-Id: ce3af05c-4a19-407d-780b-08de59eee2d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S3I1ejR4eUcwck5vTm1ENkw5VnBPMXJXTTE5aGI4ejkzN1ZtK3Jlc2xaM0dH?=
 =?utf-8?B?V3U0b3ZCRmNqT1N3dmlvZEsybmlxTDFDMzRhZ1dmcHJqYWxMTHJaaVFVcnh3?=
 =?utf-8?B?M1o1UU10aVhrUlBYb0p0VlZCYzZBc0V0Z0ErMEgwOEtiNCtSUEhFSklMcTZ5?=
 =?utf-8?B?VGNJaWk2WnJXK0ZmZHJ1SGd4R1lDNkhrVGRXTDFRT2NmK04waTBOdzIvQVIx?=
 =?utf-8?B?UnA0M0hMSXE1U2RtMWVlK3MvZTFSNlM3Z1gvZjl6dThqK1VOdkp0eis2eHIv?=
 =?utf-8?B?b3JBbHQ0TkZIVExoM1RIMlgyUmNqWGNWOEQ0WTZtelU1bWlISFhQVkZwS2JV?=
 =?utf-8?B?MnJrazVLNWtBRG5wdVVyUVB6ZTJ5MllUdHNxcXQrUWVVRDVua1k2V0orN0N6?=
 =?utf-8?B?cDJNdENvUUJuZkIwN0h2THR0Sy9DQncxaE8xYU83RHMzNVU3Rms1MWFrU2dO?=
 =?utf-8?B?UWVzeW1OZHVacXZ5TGxCOXVFMFBmRlJ4N0N5Z0s4N0pPNzVWREY2TUhEcGlN?=
 =?utf-8?B?VzZvOHo3STVvd3RKV09VUUZtRlBIVkM4Rk9PWVd0cU9xa25xcDZHYjM0RUVj?=
 =?utf-8?B?OFFKRkhhOXVSYkY3cHhVMDk2MkRoOUYzclhuaFNEeFRCSXpUeDcwZlZOd3BE?=
 =?utf-8?B?UlIyTUFFWDcxd1EvUlNjc2M2VVNuWFRYWVhSSTBEdmg3aVlETkV0VXprZ2pG?=
 =?utf-8?B?V2NBRWRNQ1BZZWh0Q3RsUUFVZzlaY3NHN2pYWTIxRnRveDN0cVZkbklpbCs3?=
 =?utf-8?B?aE9KNjVOR1JKM3BTdU8zcHZUUG1aRUFIMm1nUlBNeUp1T2hwbUJaMFBxenNo?=
 =?utf-8?B?Q0VyZHJqVzNLbDlWdlFITnRFaEY3SnM4RTdmSWNhcFZrVXJnS2dEN2tjdlVM?=
 =?utf-8?B?cms1VkIrLzNpWTZXdWFBU2RBWU9WNjQ4d3NrRUs3dFFxTnJ4UEY4T2w2b3pq?=
 =?utf-8?B?U0MzeWhFZUVXOW5Iamc2czFIY0crcC8rRnAxTmFNZzFFWXFvRmlxNkNTOTJw?=
 =?utf-8?B?ckJsalpTR1JyZUpNbHQ3Zm5LT2VhYmlTdmZhb1E4R1pqU1ZMbCtJaXdKaVRl?=
 =?utf-8?B?K2hhVFU1aWJEdk9zSUYwVmc3bjRKY1lYaFVUUlNoRjBrS2wyZWxSV2lyK0Ny?=
 =?utf-8?B?c0FwREFHQVJuQ0xMOEdiVDA0SjNJL2xybGpJdHV1MEU5U0pETXFrSFVNenpo?=
 =?utf-8?B?SkZrbDR4WklCR3QybG8xc2M2N0NJeGdkM2hmZU84Mkk3RU1XUUVTMExESXp5?=
 =?utf-8?B?ckZyZEpUOC9lUUpTZWVVYWRTdnpGdmZlSHlmZW56VXdwMXVqVzdjbEM2U1k0?=
 =?utf-8?B?MlJnVEVNS0dMcVlvSEVtYUxxbGlMZVpLcFFQU2orM1MrMXg5YXFYYUNFcXh3?=
 =?utf-8?B?NGtOUTg1S0RXWjJ5R0pOdGxNeVE4d0pUWjJmU0NQUy8ydlltQzNKT24ybmUw?=
 =?utf-8?B?VlhuSVlOZHNKcHp5YjZpOEtnUkFldDZqMTVDMklRUHNkcVZEYW80djdmNDRH?=
 =?utf-8?B?UnpPQmUyZ2RYN3A5NHlhdXBRYkpRVUl2VElrRHMyOWx1bUI4bGQwV2JtNXZ2?=
 =?utf-8?B?T2grLzRqZWRaa1pPQzdGSUpaSzB4Y1M1Q2l5bHg0TnpDa3pMSWNNQkFBSko0?=
 =?utf-8?B?OEtJZ0kzeWpYZkhINUF1b3EwdWcrNVJFc0pyZmkzcGVta1NsOGFPOERaMWNx?=
 =?utf-8?B?SE83MzBFS0h4UENXOTM2eHFWdHhTVHlGKzNaZ1hxdklLUU95eTM3Z1JaaU1G?=
 =?utf-8?B?T2hUUTJOYWtxenQ0S1VBUlllK0dwTkZWWnErUkUrcFVycU1CMzRGMTVxZVhL?=
 =?utf-8?B?dFp6K2dNbEQ4MWxFYjJNS3RiZDdXN0MzSE9wTFRiM09OVnlMcFVjcjFpbG11?=
 =?utf-8?B?SUV3Mmx2aHVoTEtrazE3di80QzB2RmpvZS9SVWFJQWxuL2t3L1ltUFluVSta?=
 =?utf-8?B?b2U2ZEhCUkxyR0JaZlpSRG9wK2hyTkJpWXJXR3djb3dSTUpwZ2sxVHV2ZFNv?=
 =?utf-8?B?clFhdU5DZkhuSnhRZFpia1gvUjJDc084SUxzMndIS0ZYVW56c3Rwb2RBcWcv?=
 =?utf-8?B?cnQ2aVIxQmZoNzlFdEs1U3ZZa0FHb0VVT1J2Mmk5NzNsZStSbG1lUW84TjBq?=
 =?utf-8?Q?45T4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFhRejdIbmFPUmRWVjdTSG5lL0VTM2N2ekJ2MWVzNko0TUZIUnpORXJwdmFB?=
 =?utf-8?B?UmNXb01BZHFtSW96WVRBS2dwbWR3SnpIQW5FS1B6TG00dWdZQ2dteEtsNjAy?=
 =?utf-8?B?OXo1THIvOFpKdE1BWloxaWxCVmFhL2Q3aTlkWUhhRmcvNndFWFEyT2ZCVnFw?=
 =?utf-8?B?SUNIYk5GM2lwWkhXRm5wT1lhRTF2RC9OSVJCYWh0Q0NpTHd5UU92bGl3Tmd6?=
 =?utf-8?B?UlBsbVlaa2plUHZ1UGJRbFYraTVKSHpCblVPREhmNDhLc2dMUnRON3VmSVE2?=
 =?utf-8?B?MmNtNURrN0FCZUg0WXBhN2krTytIYWZDY0dGUXNhTXNQV2NZeUQ4SnJYbkt5?=
 =?utf-8?B?eGQvVEx0SHVUVnFEay9XNFZyRmo4ZTZYZHFZUzlFNnVGWFNYVVlDV2hseERl?=
 =?utf-8?B?V3Z5S1d4dzM4SWYzWVhrQUs4RFVreWIzRll6OHJRckt5eTQwKzNVMzdPWXJR?=
 =?utf-8?B?blY1Rk1tY3pydTlQSWNlVjRiM2xBMlJNajFSZEFTOU00aXJza3BHRVdhZW0z?=
 =?utf-8?B?OStqNWcvMXVhVitwdmRwOUJYWjN6L3hpc0ttYW4yVGdWb0dDWEorbUJqc0l3?=
 =?utf-8?B?UHh2c0dnMUFrMms1cnJpaUdBRVFMNmZKM0lxL3c0bE9UT2xLeHZnWW03akNi?=
 =?utf-8?B?Qm9QSGozRHlBSlhJNG9EL045VjFJbnAyYjg1Y0lBdFpNb0V0NVVQT0dLQXBN?=
 =?utf-8?B?QzJTQUR1SlZRc25NcElpM2hteFB4bFRXZENBa244OHErSTA0cXdWalRIZmkx?=
 =?utf-8?B?RkRmcVB0WVJEYnRZMFpNYW1FSUxSRGIycnMrVzlTbWxRK01OaStvM1d1TjEy?=
 =?utf-8?B?cWQwOHNRKzV5RkhXcHZGbUJRSEZtK3A4Q0dvb3A1Q2ZuWlVKK2pYVXhrdnp3?=
 =?utf-8?B?aEFFWDN6SVdaUmt5cUpnUDcwUVRxbmsxQVpSMzVMejJ1amlOWFJhZ1Z4REVN?=
 =?utf-8?B?ZFpDTFMrSHdmdEVxcGxKT0MyZDNtdDhNZGpkMzFnTHdsSDhOY3Bvc0x3VHFB?=
 =?utf-8?B?MTdYWEhSMi8xZ1g4amVoMWZZYU9HYTlwNHBmalpBQVd2QUJQNlJHUGpBUnBr?=
 =?utf-8?B?MGpYcVZ5SnZkSnNvUWpMOUVKMHdRUDJjTmZ6VkRSbFRvUlk3MnAycW5UbVRJ?=
 =?utf-8?B?RWtOZFhrNENlUjltbCtqQTRSNmFEdWFsYzZUNUlCM2tKNUFCdm1qWEExSUJF?=
 =?utf-8?B?cUwzZ21vdkprQVNkZldVMnFXQ1FlanJSeXZOekdkc0IwL1h0L3VhTW9kS0lR?=
 =?utf-8?B?K2FaamFsaUZYbE9aY1dtODEzTFBxT2JGeDltN3lWcUdOc0tWWVpTNlkxTFY0?=
 =?utf-8?B?eEtFMXVkakNLU05KemdrS3EvRFlSak9uNmxybFdweUQ0NEthSmJ6RWk5Tm1H?=
 =?utf-8?B?Y0NNcjVoTHZtcGNiNmR2dVltY2FRT3BMa3RISFptbU5kQy9TWmNpaTVQUWFY?=
 =?utf-8?B?Q1JaRmRhRWZGSEsyN3IzT09pY084bGpaQzJHL2lockV6cEFYVzdFV0Z1eVc3?=
 =?utf-8?B?NnlmR3dFRWJ0VTJydkpFNmVEa0sveUJvN1UwRldZT1FJTTh2R2R2U245Q2Rl?=
 =?utf-8?B?eXJpVUxsSE5xaE1wRjZaOTZ5KzZUdG0rTEYzV3RMSU5vTUo0RVhWMzRwNnF2?=
 =?utf-8?B?MVhwVWpDVXJCK2hGQTN1U1g4S05Zd0RvbFhvNjdpanFmazB0Um1qbDRBTVM3?=
 =?utf-8?B?aTFxWWR5RUg3TE9GRjVsSWo5UFVGVWt1ZHdMUjZqRWcwY1dncUo0OEkvWUZp?=
 =?utf-8?B?MUJ3TGU3R0Z6RHNsZE5sbm5uTlljU0lBcDVPWVVTenEyZjdDYjFjS1NuQVY1?=
 =?utf-8?B?bmdaUlNPQXEzSUR1N2pBZWk4OFRHWDRoekM0RXpBZmZ2bDdtWkM0U05ybzU4?=
 =?utf-8?B?aWdRVnY3eDV5MTg2MnA1c1V1dEtCUkR0NWpnM3o0bkZQcC8xRVJKWTR1T0Fh?=
 =?utf-8?B?SCtDWUpLRm5EcVN2VFZOWW91UENiYWxtcy96eXlPaU1Vb2llcitVRXhxd21t?=
 =?utf-8?B?eTRsUVV3M0FCaS90Nm1mS2RLdEtkRTk3ck80eTFua2MzQlJuWE43SkNJM0xv?=
 =?utf-8?B?TGxJYnN1WVNyUDM1ajFid00ydkd6VjRvZ0xuL050YXhaT2ZYUmMxdmVlNzAy?=
 =?utf-8?B?RVpqdGxZTkxTNDF3RlloVkIyRWxPWExqVlRVR2F0eUxvOVc0eXMxdjRmMks0?=
 =?utf-8?B?S2FLMUt5aG8xdDZmKzBYNHJkTmZWZ3hXeVI5R05TaVoyVTFCOXdXdGl4c21v?=
 =?utf-8?B?R1lMWk1WeXFDZzlnU241azgxUyszNmM4cXJGTTlrVU1PTXBPdURrRjVnK0sr?=
 =?utf-8?B?T2R3Si93UUltU2JGMHVHMjVMUlJKVGVqUUlzcWQzbldRcVhWRG8zTkp3cHRN?=
 =?utf-8?Q?7EbRVqC7QNn0XHfQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce3af05c-4a19-407d-780b-08de59eee2d9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 19:46:07.7460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lv9pN4RIlZajdGMmZ6/KgcKokuynJkMv0NCoXfLMLLU6u3216w/OqFFq+lC2Z6feyefl7PPE6ySi894EHdwHnsAv5UrJGHID/BT0dL8veJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8755
X-OriginatorOrg: intel.com

Jason Gunthorpe wrote:
> On Wed, Jan 21, 2026 at 09:44:32PM -0800, dan.j.williams@intel.com wrote:
> > Jason Gunthorpe wrote:
> > > On Wed, Jan 21, 2026 at 10:03:07AM +0000, Jonathan Cameron wrote:
> > > > On Wed, 21 Jan 2026 08:01:36 +0000
> > > > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> > > > 
> > > > > +Dan. I recalled an offline discussion in which he raised concern on
> > > > > having the kernel blindly enable ATS for cxl.cache device instead of
> > > > > creating a knob for admin to configure from userspace (in case
> > > > > security is viewed more important than functionality, upon allowing
> > > > > DMA to read data out of CPU caches)...
> > > > > 
> > > > 
> > > > +CC Linux-cxl
> > > 
> > > A cxl.cache device supporting ATS will automatically enable ATS today
> > > if the kernel option to enable translation is set.
> > > 
> > > Even if the device is marked untrusted by the PCI layer (eg an
> > > external port).
> > > 
> > > Yes this is effectively a security issue, but it is not really a CXL
> > > specific problem.
> > 
> > My contention is that it is a worse or at least different problem in the
> > CXL case because now you have a new toolkit in an attack that wants to
> > exfiltrate data from CPU caches.
> 
> ?? I don't see CXL as meaningfully different than PCI in terms of what
> data can be accessed with Translated requests. If the IOMMU doesn't
> block Translated requests the whole systems is open. CXL doesn't make
> it more open.

Right, the game is mostly over in the current case, but CXL.cache still
deserves to be treated carefully. Consider a world where we do have limitations
against requests to HPAs that were never translated for the device.  In that
scenario the device can help side channel the contents of HPAs it does not
otherwise have access by messing with aliased lines it does have access.

At a minimum CXL.cache is not improving the security story, so no time like the
present to put a policy mechanism in place that improves upon the PCI untrusted
flag.

> > "We have a less than perfect legacy way (PCI untrusted flag) to nod at
> >  ATS security problems. Let us ignore even that for a new class of
> >  devices that advertise they can trigger all the old security problems
> >  plus new ones."
> 
> Ah, I missed that we are already force disabling ATS in this untrusted
> case, so we should ensure that continues to be the case here
> too. Nicolin does it need a change?
> 
> > I do not immediately see what is wrong with requiring userspace policy
> > opt-in. That naturally gets replaced by installing the device's
> > certificate (for native PCI CMA), authenticating the device with the
> > TSM (for PCI IDE), or obviated by secure-ATS if that arrives.
> 
> I think that goes back to the discussion about not loading drivers
> before validating the device.
> 
> It would also make alot of sense to leave the IOMMU blocking until the
> driver is loaded for these secure situations. The blocking translation
> should block ATS too.
> 
> Then the flow you are describing will work well:
> 
> 1) At pre-boot the IOMMU will block all DMA including Translated.
> 2) The OS activates the IOMMU driver and keeps blocking.
> 3) Instead of immediately binding a default domain the IOMMU core
>    leaves the translation blocking.
> 4) The OS defers loading the driver to userspace.
> 5) Userspace measures the device and "accepts" it by loading the
>    driver
> 6) IOMMU core attaches a non-blocking default domain and activates ATS

That works for me. Give the paranoid the ability to have a point where they can
be assured that the shields were not lowered prematurely.
