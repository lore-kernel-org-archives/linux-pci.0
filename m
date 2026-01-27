Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7342853F7;
	Tue, 27 Jan 2026 08:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769501412; cv=fail; b=Y2q3RjLMyeVHqw1xL67U3KegHQ9Hsa32MdSXcKgLJdWzYwwxzYl6yqFOrapcRJzRVJocOtCO7LXeLYcZ55oZYnLaaSoI+TI8GigOx1UhQP7I43Nfz+kGtZj7norV3c71p3khi101GyRXGuayBQJvlGWybtyWfwaYkYo0JLQutLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769501412; c=relaxed/simple;
	bh=2t0qG93VIVyn3OPfoB6LAwWXxnQEmIQqAvn24q8EIoA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QSl8fYT0RT4eqdtOGLMFXBDAEGER+cr+fImF2zzUoHAvpT2RggqmRT1HCUjwJtwaS1gWuJ9rbsMd0E/fmaPDtLiU9R2I1Hq3nMx2ti1m0xHmQAAxQDNqpUMXGnQrZdE2ruMEf/EKGs25jGPMDhlt+BChntZFVBKlq20sgDsb738=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gNcQkuT4; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gNcQkuT4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769501410; x=1801037410;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2t0qG93VIVyn3OPfoB6LAwWXxnQEmIQqAvn24q8EIoA=;
  b=gNcQkuT4HiX5Cl1ygLtLwXTnlBojdHBLyywbxrMrybfNFtgO1csdWDMS
   yBMz+lG+55qOKK69rmDSPvtAaHoXA0gBqs3KodnEaYa4g2Wjg624nD17k
   WV8qLWDNdkilAhvcGYvMH36QMIxJCh9axo13XLIYkfHEKZZPhWgaHVjJP
   ebi9tJpsv2FtXpdIKWkRsoL0ksd1reZRcig9lBHDTiCAhA7Ch+QrzowIX
   zBZh1pAk+LEPxRw6ZFwEYewahm0UNNQ+Dr4QdmngCC2GSsz2TtKVynvgH
   ywk8jGYFNu0C1j1NGznSBZRqKhjGlFMb1NlnVsVLPjmr9Nb4JOWDVWvZN
   g==;
X-CSE-ConnectionGUID: xinQS0HPSCq1JxI9qWH+Nw==
X-CSE-MsgGUID: tQGxN3j4TBOk39TtxEv0Vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="82057590"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="82057590"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 00:10:09 -0800
X-CSE-ConnectionGUID: 7TtDYO7OTt24RUHbM5bN0w==
X-CSE-MsgGUID: pn/TofZaSaOAOISHiWpaPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="207965907"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 00:10:09 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 27 Jan 2026 00:10:08 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 27 Jan 2026 00:10:08 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.55) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 27 Jan 2026 00:10:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BONVigP41GsJGmGRDGiy2Xb79j0cILfkDAuWzJ6oZdHVt0tmhXpKDHhO8iTDjR0WMyNJ832u8JpX31NyDg4e1U3eQwZDVHMYd7Kdr0b00eVJp1E02PJ+1oFwmE3MeaeNXAncB/Spe0C2C1AGdLQkFFdLaJ2tfgAfqSlu63oIfqWIzXwDYKn4GI4yVV0vXkrRjItQGvYQqC46rVLKAZypYxY90aMlZfjZa7KGaBfnAxisx+tWpYteo86sSRtv6AJ5aCaHKxoTt9tYC8xY/AgBjQmyRgnwOMaAEfp7X786pGhp8PAH3IR++lmZylj4Bsd72qr7vi+yZBCi7nsNai+jtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2t0qG93VIVyn3OPfoB6LAwWXxnQEmIQqAvn24q8EIoA=;
 b=k0BqrZKMXbebHqgdNvaIlTIb3qJMEBAVwl6n3Vb4BTR19+Y2bTt75CrsxTq6xkc+qwxM4u7wU3xzix23q7BL9CdbkfPiqe0ZCFByKr4Wj2IZbX6xMllykte4nmts39Odgt7MtRRFLnicUA/YguXvDpEFl5VkbhgU57M6YqJ/0UldznG/OUYG78+cvKYSy11FjpEPp99HEBBJryRZXoA1wqYpuEfrSHJlRDyhjjy3pBxmcQyWMh26gFNcSN9nb99/0u/qF6GcrnWXpL21ZbuxmYmAxRFO7hYita5mYyLsDTy894MjNnccjFG0Fw647EbCodEjM81Djc1qdFXdQETaJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB9526.namprd11.prod.outlook.com (2603:10b6:806:4c5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Tue, 27 Jan
 2026 08:10:06 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 08:10:06 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, Jason Gunthorpe
	<jgg@nvidia.com>
CC: Jonathan Cameron <jonathan.cameron@huawei.com>, Nicolin Chen
	<nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"praan@google.com" <praan@google.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "miko.lenczewski@arm.com"
	<miko.lenczewski@arm.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
Subject: RE: [PATCH RFCv1 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Thread-Topic: [PATCH RFCv1 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Thread-Index: AQHch228OMA01jUUyEiv70mzhaALBrVcR9QggAAjmICAADJUgIABF8EAgAB9uwCAAG1mgIAHDgXw
Date: Tue, 27 Jan 2026 08:10:06 +0000
Message-ID: <BN9PR11MB527649A0049CA195E7BCF9218C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1768624180.git.nicolinc@nvidia.com>
 <d1768bb6384050a23769f20ca28216f520f77e26.1768624181.git.nicolinc@nvidia.com>
 <BL1PR11MB5271F0BDC68C2D7F172122E98C96A@BL1PR11MB5271.namprd11.prod.outlook.com>
 <20260121100307.00004e60@huawei.com> <20260121130315.GE1134360@nvidia.com>
 <6971b9406d069_1d33100df@dwillia2-mobl4.notmuch>
 <20260122131432.GJ1134360@nvidia.com>
 <69727e7ded712_3095100ab@dwillia2-mobl4.notmuch>
In-Reply-To: <69727e7ded712_3095100ab@dwillia2-mobl4.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB9526:EE_
x-ms-office365-filtering-correlation-id: c791be84-2187-4649-73ff-08de5d7b7b67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?SUlZRFFhd2UxVzdYbXBqd1N1S25NQUVsY3l4cG9NRVIwUllkeUNVbzZMU25I?=
 =?utf-8?B?UE9FeDlSV3Nwb1JJc3lJSHIvdkZ0Y1VmZTduc0hpM014OGJTMjU0V3FzM21F?=
 =?utf-8?B?d0tPODV0VVFKalgxRDcxUzVqc0FEWGhKTTRoWjZ0cEFwRW9aR1puZWZFTmpM?=
 =?utf-8?B?SWNQb2tDV1V3SnhUOHpOT20rbCs3alVoL2NvR2VNZVFERUFFNjdZYmplRWhm?=
 =?utf-8?B?UURFdG5GdmJQTm9hOGJySjA4bFN6TVhVWkx0YkNFM0FsaXgrOFVCMG9rWGJt?=
 =?utf-8?B?dU9vU2JuT0NYNXgvOFJyOUF4OVFBOGRmMS9UTExyWEZuWVM0S1lZa3NIcmps?=
 =?utf-8?B?bTRzZkVFb0NidWxzM21ZTW1GeFEzb0QyeHdBTU5oMVNtZjIzeEM4UWI1NVdo?=
 =?utf-8?B?UndjckpWa0Z1NjZ5MUNKU1pSdDJLUDJVNitWWG5EQldSc0lsTUszSUJOS3VX?=
 =?utf-8?B?MUdPd3FTYVZiQ25jTldEQXdsa05EY2pIK0swY2pXZURrUEsyTzBWZ3RnaFZz?=
 =?utf-8?B?NTZIZDFOVnFReFk0N05nTjJ0a3dycEVXb09oM0NhUm5qYlV3S1VtYUNJK2dN?=
 =?utf-8?B?R0l1RHk3N0pPWGV5NVdXcFlEVVR1RFBrM2hWVWlibmhhdGczNEVkOGx3aFJE?=
 =?utf-8?B?ZlU1L1RBZ0FBRGNaYU56Sjk2MmNIM05qSW5tcUh3ZzBISlNwR1l0SGlWMG0z?=
 =?utf-8?B?QXYyaTUxWkRrRUJPZmh5d2V0dEdxU29WelNDNWJ6ZzdhYWpIZE92RTl4bmNO?=
 =?utf-8?B?SkhvblhLNlRiS1NCSmY0c25lSkpHa1ZtcmtHYlhuZTQ2QktTTFQxUDFndGh5?=
 =?utf-8?B?cVhwcUVaR0hzY1JOZnVYWVI4SWlDQU0wbkdVSy9nMHVSSk1TSWtLWnBmSlhk?=
 =?utf-8?B?YkVkL2Z6RklGY2piSTR3MzRvc3JXUldVNmY1MFhhLzg4SXNvbklNa1NaTUxr?=
 =?utf-8?B?aWtVcWQ5WngyQ1pPUTgrS0ExYXk1ZWlPSndya0xjb2pmdUxDSGJ1Ny9IZW9l?=
 =?utf-8?B?RjU5Y1ZxQ0hNOC9ZMUVLNEg4NXZEaFExRXhGclF4R1EyZjZmQVFwQVlpR3g1?=
 =?utf-8?B?aENOVmUxQXg0MnBvdFBFNG1VOEc3bXBBWjZpaFowVEtUb0h0cTluU0N5ZHFR?=
 =?utf-8?B?UkFwcUZDdWVtOTliZnpaL2FsZWV1NnIyRnRTMXZlUVNLSHp3aG0xelBqMEdB?=
 =?utf-8?B?c3pBVXpoZlh5blkzZWJ5SjJWMnJmbEQwNkdRQklkREc1bVVFWTc2Yk9qWHkz?=
 =?utf-8?B?SkdhRDc1TjJkZWcwZXh6UXpKcmxpS3lNblhyVVMySDJzSHBzYzZCUFBPblpl?=
 =?utf-8?B?Ly90bzErNStIeEYrcGtTY1FlMU12MXlubjdLcyt1WVlOL2NXN05wRWlhL3Ri?=
 =?utf-8?B?QjlnUHBaejc2SlVxOFp5MUZVWDRtZFZ5Nk5VajVaWVk0a0NOSmQvdU5VMlpQ?=
 =?utf-8?B?a09FdFhMUlNJVVFNb1JLSHAzaldaZGVzRVdxdGtJbDVKWmJyVXdQMzMvaHdi?=
 =?utf-8?B?ZjNFb1NWQ0tzNGhzbzZlYktzSzdnWjl2ck5EcGxEdG1remFmbjVOSUVlRFVn?=
 =?utf-8?B?dHBpTVZOWWJ6TnRUTWJsSUdyZW9lK1MvanhxdjRyaTArTGVXbTBFUlRxTmRD?=
 =?utf-8?B?K204N3lDOGZaVGRTMHhRVVpNNVhjRVU3TEZpWGEyWEY1MVNZQkU1U1QyYWp6?=
 =?utf-8?B?ZlNNVFJzajFyUmxxc29YMlIwNVZnbDIvTVRyOThhWk5FVnBGbGttT0c3UXB4?=
 =?utf-8?B?ZmQzeXgwR3dqMi9kWmplb1U5QlJTWHpsK3BHWW9KOHFtK2pKbzhBRWt1WmFW?=
 =?utf-8?B?Qlk4TW15aFFOclV2MHhaUXB3MTdRc3FxWlZ5NDEvWTlXU20zcmFtN0ZOamtZ?=
 =?utf-8?B?WnFZb0xGUUJrZXNxU3FHaGhrZ3FjNXI4Umg5bTFzTWRySmV1ekkwK0RtTEpY?=
 =?utf-8?B?N3FBOG5veG9ldEtXQkpqMXoxTitWMjA3VDBHSWFDdEdvOUJUQjhuY3czakpp?=
 =?utf-8?B?bFhzNkhjUlRKSUdFanQyNzhtOTRNeU5yYmQ5Z3dJN042Ym45WmxYZk8ycDVp?=
 =?utf-8?B?UlM4cmI5R3JMVmFhYzdPRTByVUhGY1ZINnh1R2RZRGJKbHJlclV3WnVVNis0?=
 =?utf-8?B?a09GbzhrNlpGQldOeXpkN3hLTTBKTVl4d0c4TjNQeTdUeEVNWTllVWxNMnpu?=
 =?utf-8?Q?TmSf6avaaXAIFq0FHdD3jy8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTFaTk9lMGRqdnJJNTBpY0dHOFUvZ3ZmU3F5a2o5S0RXcStYeWhvcEQ5OEdr?=
 =?utf-8?B?Wkg4ODYwNlRRR09mTyt3LzRBL2d0NmkzVmZISklBdkwzd0JleGUwWWJXQ1Rs?=
 =?utf-8?B?Y3RUam5SZU9RYk1QSDhxbW5nSnp3Zk8rZTEySWQrZG01azNTYk9lRHNmWHp2?=
 =?utf-8?B?NElGMnBWak9nd0MzbU5QU1VaMmx6MUpMZWJ1Y29KazFVMUpWRkRhNlZ6Y1I4?=
 =?utf-8?B?OFBqSlZqb2cyNzRIcUNkekN2U0dvYWlVOG1SdWZqY2lKVG5VM1BTY1BVcmFN?=
 =?utf-8?B?MTROQU9LZEIvaGt0cENzaTVjTGpTSG1VNWxGU293N0VkQTJsUEtEZExEZkli?=
 =?utf-8?B?cEMxY3hFZGdVSkUxRndJQUFjSUF1WjJVYU5XRHFSRFVEeUdiYldCWlNFTzJI?=
 =?utf-8?B?Z1VXR1lCUFIyMHkxaVhuMlpVaEMvTXIwemFaZHpyWk1rR3ZEbDRyTVBIVldw?=
 =?utf-8?B?OGpPemVlNEtrMVBodkcwckxyQ0VKS2FndGVTdXZyRk5kVUJGK2ZJUWVWNWNv?=
 =?utf-8?B?Yjd1WGF4QnRubDNJNzdUWG5udit4Ri9YVC95TWNEM2Z1cTJUSmJUek9IQnpw?=
 =?utf-8?B?dVV4V01mTHNDMGhhMzFFdnhsT1F4ZldrYzR5Z0VVcGRxWG5JczR5LzF0SUdM?=
 =?utf-8?B?WmlXamdJK2NlQ0tKTThNV0JpV0tZaWNOSkxvTGV6VXZwNUo5NGQ4RkxZbGVT?=
 =?utf-8?B?NllHSzdrTVQ5TGhkLzBOZDJOc1hZNzdiYzIvWEZnclJ0MXdyaVBuWWxtQXlL?=
 =?utf-8?B?YnFVL3l5WG9wcjhqKzYwT3gxT1hWdDhOazU4R1JreXE3T1RLWlY0VEdmaEV2?=
 =?utf-8?B?Q2loMk9ydEJuSHREcWV3RWRWaFJUdXZZNU5ZaEIwc3pkUVNkMEV6eG9WQnNx?=
 =?utf-8?B?a2JUSnNHUFp3TlNxUGxhS1RvUFZVbFgvOUkrY1NSZVlrejVXSm1YVm9XOENJ?=
 =?utf-8?B?WjZ4TFMvODBIeXEwcUlrTmZiNlBMUXQvaE05c3hwaW5Pdzg4YjVSc0hSK05Y?=
 =?utf-8?B?WlBHVk1zTWd4QVUyTVdwWWNYenh2SkFiZWVhVXR0c012cmdmUGRFR0pjMFFU?=
 =?utf-8?B?NElnYkVtb3hiQ0NSQjF0TWx3bVJzcHhZcHovWCtYRHVZb2dSbnZoVGxWdkx4?=
 =?utf-8?B?NnN5bUd5aG5pQm5rSmlHZ1pnVnQrcmM0SHNVejNRWHFZNFd0YU9DV0tvWThH?=
 =?utf-8?B?QUpyMVc0a2ZGdkozOFdoWnNxSENHdnlsUVloakM2OXhISnppZkpZNER4eVF5?=
 =?utf-8?B?M0VNV1N5WEs2VUd1T0JlV2FjRHlOOXFwQUZMakhxQnlwbFN3SFluWGhuaHZR?=
 =?utf-8?B?MEx4bk5jdzFReHJmMlVEK0ZpMG52NnpqTFkxZFJ1RlJpREtPdmVwMGNDdVAr?=
 =?utf-8?B?T2RrcFhBTXl2aEUzV2p5TWdGOFBOU2lsWlNwc0NsL2JWUGVqSjhvdzk0N0VV?=
 =?utf-8?B?SXlrdFFDdC9QS2lmczRxeVZPV1gwYmsvdThLdjhQSHlqYjVaUnk3VmlBU3Rp?=
 =?utf-8?B?Z1BmNDhScVVscDlPTXBNSE41UHRod0hMem1jL3FuWDVYMkR6Y25QM2l4bVhF?=
 =?utf-8?B?M2VHTTJJWVpJOTR2ZUk4MXg1OWlxcGZNbUFhSVVIYWJGU0ZVc3NWWVpUeDQw?=
 =?utf-8?B?NFJadlZYUy9hcG1HZXB0eXp5dk5LMmV2SUs1UzFhczE3NXFKODUxUzIwYzJS?=
 =?utf-8?B?ZUV2MjhRQWtaVTJIb2lybmpSdVhsK1lJY3pTclpRdVptUGtQTHcwYXp1UFBQ?=
 =?utf-8?B?K3lSd3lUbkRMaEZSNVdSMGR6NWZJOCtHbVNlZllXd25Tdm9FbXhzc1FLRTNC?=
 =?utf-8?B?RnRCUy9PNXVUNE0rQVZRd1pibTFUSHNMdU9HN2REY1A4UG5nOFdJNjFPenBs?=
 =?utf-8?B?cTNuUkhGZ1FFY0VJZjB2Tnh1K0wwK2JzNkhGcWloRVBOeWhLVmhpL0JNa3R4?=
 =?utf-8?B?Mit4WHFtN01LeS9XS1IzSWMrcXRCanZ0WVBuV0txdDRwR3NYVDdxNjkrTEt2?=
 =?utf-8?B?UE5xS1RLV2VxVTMweDQzbHhBRExUaVVab2FSdlN5aXJYNGFoK3dINWcza25Y?=
 =?utf-8?B?ZUJnSk9VRkpwVVcrcTdScDc3RlFFaGhpdWRZQUYwc1FFTERMT2Rva0IwSFIx?=
 =?utf-8?B?MWY1d3JNNm5HVzBQTTNIcXBrL0t6bFpKYXk3bVg1WTRhSW13MzR5YitwQkJ0?=
 =?utf-8?B?UHJJN1dxRzRKR3VkV1k0S1VNVCtndFAwU1I5VjhiNW5uM204aEg0NWVGd2NN?=
 =?utf-8?B?bEJkbDFFMGVqeU1way80ejlXSGlDQlViaDM4S2ptQmhvditpdlR2bnRKeU9m?=
 =?utf-8?B?NEIwN0h4aVNvMUxLS2Q0elVYcXZrZ284UXcvaG9NVjlWN0RPdmNiZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c791be84-2187-4649-73ff-08de5d7b7b67
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2026 08:10:06.4909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fF4ATFgOPda7xXjKlu4Wh0dDyoP9bmc2BTle+Zvmx0fyWADNQUsJVyzFfjRQlmp9wFrn5g5kWFV1Y80tfzriKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9526
X-OriginatorOrg: intel.com

PiBGcm9tOiBXaWxsaWFtcywgRGFuIEogPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4NCj4gU2Vu
dDogRnJpZGF5LCBKYW51YXJ5IDIzLCAyMDI2IDM6NDYgQU0NCj4gDQo+IEphc29uIEd1bnRob3Jw
ZSB3cm90ZToNCj4gPiBPbiBXZWQsIEphbiAyMSwgMjAyNiBhdCAwOTo0NDozMlBNIC0wODAwLCBk
YW4uai53aWxsaWFtc0BpbnRlbC5jb20NCj4gd3JvdGU6DQo+ID4gPiBJIGRvIG5vdCBpbW1lZGlh
dGVseSBzZWUgd2hhdCBpcyB3cm9uZyB3aXRoIHJlcXVpcmluZyB1c2Vyc3BhY2UgcG9saWN5DQo+
ID4gPiBvcHQtaW4uIFRoYXQgbmF0dXJhbGx5IGdldHMgcmVwbGFjZWQgYnkgaW5zdGFsbGluZyB0
aGUgZGV2aWNlJ3MNCj4gPiA+IGNlcnRpZmljYXRlIChmb3IgbmF0aXZlIFBDSSBDTUEpLCBhdXRo
ZW50aWNhdGluZyB0aGUgZGV2aWNlIHdpdGggdGhlDQo+ID4gPiBUU00gKGZvciBQQ0kgSURFKSwg
b3Igb2J2aWF0ZWQgYnkgc2VjdXJlLUFUUyBpZiB0aGF0IGFycml2ZXMuDQo+ID4NCj4gPiBJIHRo
aW5rIHRoYXQgZ29lcyBiYWNrIHRvIHRoZSBkaXNjdXNzaW9uIGFib3V0IG5vdCBsb2FkaW5nIGRy
aXZlcnMNCj4gPiBiZWZvcmUgdmFsaWRhdGluZyB0aGUgZGV2aWNlLg0KPiA+DQo+ID4gSXQgd291
bGQgYWxzbyBtYWtlIGFsb3Qgb2Ygc2Vuc2UgdG8gbGVhdmUgdGhlIElPTU1VIGJsb2NraW5nIHVu
dGlsIHRoZQ0KPiA+IGRyaXZlciBpcyBsb2FkZWQgZm9yIHRoZXNlIHNlY3VyZSBzaXR1YXRpb25z
LiBUaGUgYmxvY2tpbmcgdHJhbnNsYXRpb24NCj4gPiBzaG91bGQgYmxvY2sgQVRTIHRvby4NCj4g
Pg0KPiA+IFRoZW4gdGhlIGZsb3cgeW91IGFyZSBkZXNjcmliaW5nIHdpbGwgd29yayB3ZWxsOg0K
PiA+DQo+ID4gMSkgQXQgcHJlLWJvb3QgdGhlIElPTU1VIHdpbGwgYmxvY2sgYWxsIERNQSBpbmNs
dWRpbmcgVHJhbnNsYXRlZC4NCj4gPiAyKSBUaGUgT1MgYWN0aXZhdGVzIHRoZSBJT01NVSBkcml2
ZXIgYW5kIGtlZXBzIGJsb2NraW5nLg0KPiA+IDMpIEluc3RlYWQgb2YgaW1tZWRpYXRlbHkgYmlu
ZGluZyBhIGRlZmF1bHQgZG9tYWluIHRoZSBJT01NVSBjb3JlDQo+ID4gICAgbGVhdmVzIHRoZSB0
cmFuc2xhdGlvbiBibG9ja2luZy4NCj4gPiA0KSBUaGUgT1MgZGVmZXJzIGxvYWRpbmcgdGhlIGRy
aXZlciB0byB1c2Vyc3BhY2UuDQo+ID4gNSkgVXNlcnNwYWNlIG1lYXN1cmVzIHRoZSBkZXZpY2Ug
YW5kICJhY2NlcHRzIiBpdCBieSBsb2FkaW5nIHRoZQ0KPiA+ICAgIGRyaXZlcg0KPiA+IDYpIElP
TU1VIGNvcmUgYXR0YWNoZXMgYSBub24tYmxvY2tpbmcgZGVmYXVsdCBkb21haW4gYW5kIGFjdGl2
YXRlcyBBVFMNCj4gDQo+IFRoYXQgd29ya3MgZm9yIG1lLiBHaXZlIHRoZSBwYXJhbm9pZCB0aGUg
YWJpbGl0eSB0byBoYXZlIGEgcG9pbnQgd2hlcmUgdGhleQ0KPiBjYW4NCj4gYmUgYXNzdXJlZCB0
aGF0IHRoZSBzaGllbGRzIHdlcmUgbm90IGxvd2VyZWQgcHJlbWF0dXJlbHkuDQoNCkphc29uIGRl
c2NyaWJlZCB0aGUgZmxvdyBhcyAiZm9yIHRoZXNlIHNlY3VyZSBzaXR1YXRpb25zIiwgaS5lLiBu
b3QgYSBnZW5lcmFsDQpyZXF1aXJlbWVudCBmb3IgY3hsLmNhY2hlLCBidXQgaWl1YyBEYW4gbWF5
IGluc3RlYWQgd2FudCB1c2Vyc3BhY2UgcG9saWN5DQpvcHQtaW4gdG8gYmUgZGVmYXVsdCAoYW5k
IHdpdGggQ01BL1RTTSBldGMuIGl0IGdldHMgZWFzaWVyKT8NCg0KQmV0dGVyIHRvIGNsYXJpdHkg
dGhlIGFncmVlbWVudCBoZXJlIGFzIHRoZSBvdXRwdXQgZGVjaWRlcyB3aGV0aGVyIHRvDQpjb250
aW51ZSB3aGF0IHRoaXMgc2VyaWVzIHRyaWVzIHRvIGRvLi4uDQoNCkF0IGEgZ2xhbmNlIGN4bC5j
YWNoZSBkZXZpY2VzIGhhdmUgZ2FpbmVkIEFUUyBlbmFibGVkIGF1dG9tYXRpY2FsbHkgaW4NCm1v
c3QgY2FzZXMgKHNhbWUgYXMgZm9yIGFsbCBvdGhlciBhdHMtY2FwYWJsZSBQQ0kgZGV2aWNlcyk6
DQoNCi0gQVJNOiBBVFMgaXMgZW5hYmxlZCBhdXRvbWF0aWNhbGx5IHdoZW4gYXR0YWNoaW5nIHRo
ZSBkZWZhdWx0IGRvbWFpbg0KICB0byB0aGUgZGV2aWNlIGluIGNlcnRhaW4gY29uZmlndXJhdGlv
bnMsIGFuZCB0aGlzIHNlcmllcyB0cmllcyB0byBhdXRvDQogIGVuYWJsZSBpdCBpbiBhIG1pc3Np
bmcgY29uZmlndXJhdGlvbg0KDQotIEFNRDogQVRTIGlzIGVuYWJsZWQgYXQgZG9tYWluIGF0dGFj
aCB0aW1lDQoNCi0gSW50ZWw6IEFUUyBpcyBlbmFibGVkIHdoZW4gYSBkZXZpY2UgaXMgcHJvYmVk
IGJ5IGludGVsLWlvbW11IGRyaXZlcg0KICAoaW5jb21wYXRpYmxlIHdpdGggdGhlIHN1Z2dlc3Rl
ZCBmbG93KQ0KDQpHaXZlbiBhYm92ZSBhbHJlYWR5IHNoaXBwZWQgaW4gZGlzdHJpYnV0aW9ucywg
cHJvYmFibHkgd2UgaGF2ZSB0byBrZWVwDQp0aGVtIGZvciBjb21wYXRpYmlsaXR5IChpbXBseWlu
ZyB0aGlzIHNlcmllcyBtYWtlcyBzZW5zZSB0byBmaXggYSBnYXANCmluIGV4aXN0aW5nIHBvbGlj
eSksIHRoZW4gdHJlYXQgdGhlIHN1Z2dlc3RlZCBmbG93IGFzIGFuIGVuaGFuY2VtZW50DQpmb3Ig
ZnV0dXJlPw0K
