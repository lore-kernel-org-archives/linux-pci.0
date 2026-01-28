Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297421A3029;
	Wed, 28 Jan 2026 03:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769571784; cv=fail; b=poss8Odn0gjcJnJBRqVZqMJXqFTowdVSGyaSQVNm0jscWiFNVFAZHitu09f88cchR7IgvIBVkSGKwUyFsDoDhOrXlofrlErvFl96tbli1KAo/MdmGJ5LM+Xo+Im2BQIF2+XakHeJwRo2KyAxNtGyh3fj/oVVns5qS/dbXbL9Ctw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769571784; c=relaxed/simple;
	bh=y+aelVcxtrxHu080lFRVm8pHrjeRnAfajIhq/DgH5yA=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=tbsk7qZL5lL/WmnuaTk+34ERsxDL+c4p4z1oh6Jc700qkRwMj6fo+Z24u1vs417haMSAnb7h1ksCbDiaS4KCcslPYIoEap1dbCJPKJ2IpDnRBfWV2xMx3Ol0B8aZsccqijQ+KNKrfExo0Lf5OD7MGQCU9UIIn5ywjJB7PiX9Ano=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EaHxUC13; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EaHxUC13"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769571783; x=1801107783;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=y+aelVcxtrxHu080lFRVm8pHrjeRnAfajIhq/DgH5yA=;
  b=EaHxUC137RsVjiQFgi0Zw6betatpeDiMCGMTcec/k+iyTn4AbCUEtQdI
   3y8zwHKiunqPvoKz58Cl9rAIe+7rT5Ct7kPe3BMnHN/g3RQ5RHuOzJPfH
   6Z5UNTLRBdf6GnPCfJyyvsvWewkz39cElBCvB3cNPLop07EPulBC9p74F
   PBu3RChiOP3nB/gH5E/02T5/5zjb+Fo7wGzSCh24dv91GBDYL0iWiFo8s
   bNaD28MPLvPb0PTiNKtA2u0wH4R8EDAv27M60/aCqCgKxk2DzfGR074nA
   MoZsJWKPdWdfCfA468PhfN36CgIiVpRbAUQx84zw7rHXecd1gCQ9Hg0Sw
   A==;
X-CSE-ConnectionGUID: /T3GZUHXRp+dgBx4ZpM86A==
X-CSE-MsgGUID: HSCTk7m2Qca+myMurEUPTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="70681970"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="70681970"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 19:43:03 -0800
X-CSE-ConnectionGUID: T4kt0UaYRIaS3kuaSwJbfw==
X-CSE-MsgGUID: 0xm+zgGkTOGLKqHFnIj1uw==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 19:43:02 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 27 Jan 2026 19:43:01 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 27 Jan 2026 19:43:01 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.16) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 27 Jan 2026 19:43:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ro3eXd5lLYpcNeylo3RqdYEGuvwtI1tlZMXDwjMuHvdZRnmoGBh0J5bpqm9gcppNyn9pYVOzaGTzf4gZHOMKY+tR21DpICEe4irDJWgXVujbhW2+oSt86wXgi/PNhmi5OESTpXICQ6VdM1Uit3dDDVwWC2c9YnCB7xHmecdMbqLmEhlZq1zwY89lI/knvkKeWIBBkNrAvDBmsXbXVrQgTJPnCr/amJiK1fPgzY73y69ZAbXo3mdNgD578xw0m56UWSGbT+XRrn1msRL9Z8gClK0naOI2WBSQ+pprdxsKMv3uDI9oc0n2sVR/dLZ1W2XUc+0svJAfBaOUzsnl5oDRGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9NhSThXvGfI3PTZWrjERfEXTw7M5nkyBhsutACcYms=;
 b=BV02evGG6EXRuI3+ondrg/gCk2EKMPuY/VGRKa+M+uzTh4sfK7C1ENQnc8zLeu8Yvm9q/3iR2Xu5UHR0MsTAfQkHB0N/BPDNd9pgtD8jfdgO7XSr42ao7HozB2h6R4OCTlfJDfC//uYzu7bbb2jTPX6MEZOr9f78CAPfLfrNr9lg6fYPNIV0AXyaGTwuF01Cr5rv/LgsRNwY42/8Dy6UrhsgY30EFjaEgSjMphSzjIxMgVwnB9mu0zazlrVdo48Q3wKecjZ+s2mZ+ZjPf5Xc7N+ERJNSl0dQjGNGY01Vdr3bFH1PP1OT2z6YnjTmua8yxfGwMn4Wltx/Fz9cVz6FsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB7990.namprd11.prod.outlook.com (2603:10b6:510:259::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 03:42:59 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 03:42:59 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 27 Jan 2026 19:42:58 -0800
To: Vikram Sethi <vsethi@nvidia.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, Alex Williamson <alex@shazbot.org>, "Srirangan
 Madhavan" <smadhavan@nvidia.com>
CC: "dave@stgolabs.net" <dave@stgolabs.net>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"ming.li@zohomail.com" <ming.li@zohomail.com>, "rrichter@amd.com"
	<rrichter@amd.com>, "Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>, "huaisheng.ye@intel.com"
	<huaisheng.ye@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Vishal Aslot <vaslot@nvidia.com>, "Shanker
 Donthineni" <sdonthineni@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jason Sequeira
	<jsequeira@nvidia.com>
Message-ID: <697985c2c622_1d33100a2@dwillia2-mobl4.notmuch>
In-Reply-To: <LV8PR12MB9182DEE18D9F83194A6E0034BD90A@LV8PR12MB9182.namprd12.prod.outlook.com>
References: <20260120222610.2227109-1-smadhavan@nvidia.com>
 <20260127093343.67715d5e@shazbot.org>
 <6978ef9919421_1d3310036@dwillia2-mobl4.notmuch>
 <LV8PR12MB9182DEE18D9F83194A6E0034BD90A@LV8PR12MB9182.namprd12.prod.outlook.com>
Subject: Re: [PATCH v4 0/10] CXL Reset support for Type 2 devices
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0272.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB7990:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b399606-2f84-4946-db0b-08de5e1f54c7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d09pUE1hV0Zjekp2ZExFOWVmeUdvNmdMdjlEb1YxTkhBNDR3QXhPZzBteFZW?=
 =?utf-8?B?Wkc4WW1adHJySVRNTFhlaUhJN3VRb29qbUVremkrdTJiQncva2FSOENRUW5G?=
 =?utf-8?B?R0NnYmxOaXpleEZvRUhxbitqa1I2RUFINm11R1pVQnVKMi9ZV0FTT05aSWVX?=
 =?utf-8?B?NnBPOGdPRkRCZ0FzK0xCd05vcTA4WHppdExmUUZla3lOd3U5cTJCZThYc3E0?=
 =?utf-8?B?aFBnYkNMNE9USW8wUjBaeWJLbGVHNEIxaVVuaXZsUFBCVUV3aVlUYkh0MktV?=
 =?utf-8?B?N2FYMEFZVHBpa0FQMGZub3Mxc2V1L0hSbEpFdmdPcGZxQWFPMStldVMzei9O?=
 =?utf-8?B?V0FFWmNzbkZLcXVRWk5uTWI3dG1Wb0tENm1POGNmZ25oaFpLM3kzeHNEM0pp?=
 =?utf-8?B?OTRuaGw1N2xwVTl0M1NXYUppbGZuRVYybzY4aHo2UUErNWV3amFxWFc4dnll?=
 =?utf-8?B?TFJlNmlKNDQ2ZzJ4VjBhVzhFbHFsbDlOWTN3NFo3Q25Dd1IzYTMyakdlczc2?=
 =?utf-8?B?dC9sekpUWnpPUDBNWllPaWc5ejI4MlZjLzgvd0VNZXZCZm9Fa0xob3psQVVU?=
 =?utf-8?B?dXlnRDJjQzhkOVc3Q1duOUdtaGwwRko4NGJvNW9SMGNrNEU3TjNUQWRvekl0?=
 =?utf-8?B?bUwzZHQ2NnhCTStKVXpyL1QxbmRueVB4cDJPRjM4SytHZ3R1MVpkL0I0MVlZ?=
 =?utf-8?B?MUhudlI2YWh1TTAxUDc2UjZzUVk0Q1BCS0pod0hZN2pWci9pbERZMFVRaGpu?=
 =?utf-8?B?dENKYWN6emhwME9TREFCbVh2QnB6UG1EejlvbFN6cUpWYVJJQWEvcEhNVms1?=
 =?utf-8?B?aHRyeGd0V3NvZkVvY0pkT0VjZitCaUVoZE8zVHlGUXVhZktJUTZwR05ZSmQx?=
 =?utf-8?B?NXRlVzRrQnFEa2FIc2N3NzlqZTRnNTk1cXk5WVBUMHlZWVdGNnZWazNub0F5?=
 =?utf-8?B?d2hBNnBYK2hvK3pGdy82OFdwYTh0aTBrL2lwdU9TSHZGTW96bFE5a0k0dHhy?=
 =?utf-8?B?VWJyMHJwZCs5a0tsemdZZkx5VE10RjBYK3Evc3RjT3hucm5iQ3NvVFBhaEJK?=
 =?utf-8?B?YVBqZTF0N0UzTkRqYlJORUY4K1FHRHNuNFN1OGJTazVVNm0yay8rb2lFVmtX?=
 =?utf-8?B?Zk1kTWtmalFwMW5nQ1kzYm9vdEdOMHJQQ1RaMmxmWmhyQmt2Y2ViMUk1ME9I?=
 =?utf-8?B?VnJhZ2pFR1Jkb2VmUDFOVFNXSk1OcnZhQ3UrZ0swZURoMFJwajkxcG1iYUcy?=
 =?utf-8?B?QmtlZlFKL2dpME9EdDE5cGFhdUJtUk03TjMyMXdzZVl0MUNhNEdCMnJKYmVJ?=
 =?utf-8?B?a1hjYXJVNUIzOUJQcGxmTGsyenpJTzJLOGlpTXIycHJsK0FZL3J1ZVNjYXQ0?=
 =?utf-8?B?azlWUy8vUXJJcEo3bmV5a1dDY1I5VW12SHMreXh0cmhVZDJXV01OckJFZ0tQ?=
 =?utf-8?B?K05pNnRac1A5Q05pd0luL2Rmb2RyblM3TWlQeVA1T0plVGZCd1lvMWtZUDhk?=
 =?utf-8?B?cm11bEFmSVNkWUEzbmxUb20rSVRHcnFsMVZWYWZWUndWcTZXUGlXTWRzRzZ5?=
 =?utf-8?B?NlFDSS9jUWI4QVJOYnVZM0tPRmxLR29YdDJUWkFCU1FpUURQZzFyUENvcXIz?=
 =?utf-8?B?Vm15TGxydDVKZWJwZURBNlFrU1RMcGd0QWdjWTBwOHRSWENXUWIwTjdLQjgy?=
 =?utf-8?B?d25mMGx4MmRWREFSVzVGTExoV0krS01JZC9nVTFZajA3L1RtNGhIV3dVY3VO?=
 =?utf-8?B?UUIwNndCeEtNZlJiK0theWFHUzlGMkxWbUFBcTllbGlyZHA3ZFV1YldXWXlh?=
 =?utf-8?B?czI5M0ZoVzNFSVYvSk5BN2NVeUM1Nlc4a2pxMS8xVjZPZ2p0VmNlMzlZSklx?=
 =?utf-8?B?b1hFbkd5d29RSy9kYXJ2eDZYNTZxRVJ1bmpKS0VFM2s0WVlNRjRxcHVMSVBW?=
 =?utf-8?B?elJwU3BMSGRacDlCN2EyUWhhaG1Ea2tpK2Q1L0hETzJNY0I5UVRJbUZtY2hM?=
 =?utf-8?B?SG9xMDFYM0xwbEUwWVNGWEU5ZWNsOHo5RjJuNDZHaUlrRWlvOUhGZFZ1RjJZ?=
 =?utf-8?Q?ff189v?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXZ2ekxQZ09mWGdxanBiSmROeFFsbGtFYjN5YThRTWlvNkZVUkVtelNPbERp?=
 =?utf-8?B?Q3Y4RkZxRFp4bjhTRXNkRzJYT3BOSi9lZkJaMFFEazEreGt5ZHJlU09yNzc3?=
 =?utf-8?B?YzN2SC80a1lxQ0IxanN6REJBL1IzY2RleURRb0ZaNXpjSklJRHF6TWJxYTgw?=
 =?utf-8?B?dUVEclR3eDFLWmRrdm16bzZwMzFFaUFPK0JkVlA3NW9PdHVxYW9xNXJBTldG?=
 =?utf-8?B?WDZNci95WHFiVWtPaldGSktxOTVzUGtYQmFzOTd1RnQ3YUZOejFKN3pNU0F0?=
 =?utf-8?B?bXZqc3M1NjR4djViSlc2VklOaUxOYVZGL2lvTWFuYStFMmZ2TzhVd0ZFajVw?=
 =?utf-8?B?bVhzcFFsaU1VZ0VLbS9oV0hKVmlGa05IcCtCbmVic201ZTRQSlBCWHM4WTlQ?=
 =?utf-8?B?VEErTmZaRG5DQ1pzc2pMNWFCWkpRdGFnNGttQ0Jmd05XRGZOYVh6RVZBQ1R1?=
 =?utf-8?B?dHdGVnpDNHhOSzBEYnVqdjM0bTB4eDdFbzlGRDJmbXM1alBmOFJmYkM5Z3c5?=
 =?utf-8?B?S3JNVW9TWGNkeVQweVFMS01RTEtkQlliYzBNR1FVZ0NFMlBoam1zYzVwN0RV?=
 =?utf-8?B?Y2NwaEFrRnRaUU10MVkzQ3NvNzV3S1o2UnJTNkpRcU9FcWJnczRpTVo4d0dB?=
 =?utf-8?B?RE1KSktmMmFSMThTYnJ3ZnJ5NnZSRHRWODZuZm1IQldlTFZTYU9LU0ZVbWEv?=
 =?utf-8?B?UklWUmMvUDM3UmsyZkhsN2RzRFc1TGdJTlQvT2hkLzRCYURZUGgwUDcvdncv?=
 =?utf-8?B?dEEzQWJucnVuVWZjUUtpc2ZxeU1vMUx6MkhyTG9mR0I2WVV2aVBmU3phYVpo?=
 =?utf-8?B?TXkrQ1Q3djNnUjEvVDc0ZHd5NEpKSG4zMVhDbTlUVmFhWDBMOFhYSTcxcWdy?=
 =?utf-8?B?WDN1Wkk3VVJhOE8ydkM2UUR0cnBRSWUwUkpsOE83M21XSkIrdWtlWEpjZkp4?=
 =?utf-8?B?QXhxclFhK0g2S2VPRndTMjlDcFBGV1V4aFF4b29lVnB0N1hPQ3JIK0pKQWVX?=
 =?utf-8?B?SHNib2x3MjR1ZTJmR2FCc28yWGlINVQzTWR3QjE1VlNJcUFiY0ZjYVQ5aC9V?=
 =?utf-8?B?S1dNanNWa0xVdHdoNDhmR0J1cnBTdDRnNzdNNklLa3c5U2hLRFlKUTFaTlRY?=
 =?utf-8?B?YnRPNUNkT0FiK3N0Q29aR0hsWUo0TWo2S1QvTURmN2lBZGxoeG9wNWprT0Qy?=
 =?utf-8?B?N3ZtbCt3Q05VNFhJbXVVdEc5eGlhaFFjaTFjazdNZVdrSldJN2xaN2ZuY2dS?=
 =?utf-8?B?L2RlYzYvRy9QUXVCQmFPQjVBMDZkalFHdE5idE1oQ09xbTltSGpqRmNJMVMz?=
 =?utf-8?B?WHl6cHkzR2RiQjc3cFJ1YWcycUc1VzhHZWU2UUZhWkxIWndyNnBLMXVYVzBk?=
 =?utf-8?B?OHNLV29MeG94MjJnY0paYmNwZmFZZEU2NWNmdjJaR1pNd1A3ajlxK2ZKQ01V?=
 =?utf-8?B?cDliY0FhYkNjUnM1TWtpTU96ZC9mZFFLaFlxMTZXdVFvTGF0QzkrL1ZKZ3JY?=
 =?utf-8?B?cXYwcFpnSGVKbXZwYnh6aFh4dzdHaXJVL2tIYWtGbGJxSWx2aHQ2Y29XRGxX?=
 =?utf-8?B?L29uUGFiWWxHQzNLQjM4cGZlc0NpWGVMaXluc0hXVHJRcGdNZVpscG1qVlBr?=
 =?utf-8?B?Wm1LVVA1U2J5aVh3Y3JjZFZVUTN3ckRtNit0Z0I0WU1GOVZOOFk3NkltMUpH?=
 =?utf-8?B?RWFDMndpYjFtcGJjaW1wcEd6bE55WHU4UmdxNk5hUGg4OEtoRitmQWlDOVgw?=
 =?utf-8?B?SzhrSlJ2c3RwN2ZTdVFLK2l0ZlNRaEt3WUNMdUZwaGRWT1dxbFhWZmdCMkhH?=
 =?utf-8?B?Q0l0TFhPWTE3bFcxRFdkc2JSTWhzOFk4aXN5d2pxajJ5Q1NVZURnYTFPT3VB?=
 =?utf-8?B?S1BUcnRUcDhYRnZKb0QyNXVKNzRRRkxDcHpxNVQ2SXhlUWdub0Q5YnB2V3Uv?=
 =?utf-8?B?Mi8rNTI1N21PcTdxRytxVytlMytLeWZYOXVIZVBiNFg1aXBxSUt3WFFTaGJS?=
 =?utf-8?B?VkxIVlBuUUlTUnp3L3JhQjRTaC9VRTEvaUVwelc1MEt4RVlhZnFwWFJMRUp1?=
 =?utf-8?B?cWVRRmJQaitBUmlzTXFDRDZMM2syUEhFNGIxVytHcGJJaWV2TEV1ZnBNNWQz?=
 =?utf-8?B?Vjd3Y2I3cUszaTQrd3pFSmZyWjE1WmhZL0pDVTJybDZZYUtFWXdGYVVtT2VF?=
 =?utf-8?B?QW03Q2g1UFpCZ3R4S1ZpNy9GUm5MYytTb0lrMHJUYmNodmUzVDVOeEdKWE1k?=
 =?utf-8?B?R2MwZWVLaDdnOTY2ZXFtanJlckZvZ00va2NTQ2dyK1NHb2xvSURnbE04Nnlx?=
 =?utf-8?B?VWdhc3NsQ21rZ1BtRWNxSldFYmppWjJEcGJPb3dRTDlWVGNjZ0p6dE9HV0tJ?=
 =?utf-8?Q?V4kpRYdfOy6Y7JE4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b399606-2f84-4946-db0b-08de5e1f54c7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 03:42:59.4107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d9nPAABq8WCtZeI7F3tA1jV+QAgL3eEZsikh6BhxyBNeXU9LHJ5XJit+QZtgf4Uy3nQnXJOqq5Dbb4OUt+WsCImIon7a5maCyqvs/1O+abk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7990
X-OriginatorOrg: intel.com

Vikram Sethi wrote:
> Hi Dan,
> 
> >Once the protocol error handling series has landed there is a potential
> >to extend that with CXL Reset recovery. However, that needs a clear
> >error model defined as to which resets have a chance of recovering
> >*system* operation when CXL.cache/mem fails. In Terry's series, panic /
> >reboot is the recovery, not reset.
> 
> It's not just about CXL protocol error handling though. Type2 Device
> passthrough will be a common usecase for CXL reset (entire device is
> assigned to VM) across different VM assignment.

I understand. The point about CXL Protocol Error handling series is that
it at least enlightens the PCIe core about the presence of active CXL
links.

It is also the case that it much closer to being upstream than this set
which still has fundamental questions.

> The cache and mem of the device must be cleared via CXL reset for full
> device passthrough in addition to the PCIe/CXL.IO reset. Another
> usecase is when the device is reconfigured either in baremetal or in
> VM for passthrough usecase. Such usecases often require a reset of the
> device, and it's cache, mem and not a narrow "memregion" reset, so I'm
> not in favor of exposing it via CXL.mem sysfs entries. IMO, device
> sysfs attribute reset method is appropriate for type2 devices.

That case is already handled today with secondary bus reset to
completely reset an entire device. That path is problematic for CXL
because PCI reset has no idea about how to manage caches or handle
memory unplug.

Administrator is responsible for making sure that event is not a
surprise memory removal or cache protocol corruption event. That is a
level of explosiveness that PCI reset has never needed to consider.

CXL Reset wants to be more surgical than secondary bus reset. The only
way to be more surgical is to cooperate with the CXL core that knows
whether the explosives have been rendered inert.

> Finally, there is the error usecase, which in the common case is as
> simple as an uncorrected ECC error in the HDM. While not strictly
> necessary, it is common practice to reset the device in such cases, to
> recover the bad page/row via PPR on device reset. You want reset of
> the memory controller as part of the CXL reset here, FLR is not
> enough.

??

CXL memory repair is already upstream without CXL Reset, see
CONFIG_CXL_EDAC_MEM_REPAIR.

> Regarding scope, and "recoverability", we have significant experience
> with recovering "pre-CXL" coherent GB200 devices for device errors:
> memory ECC or other, by killing the application using device memory,
> unloading driver, resetting the device, and reloading driver. The CXL
> protocol error series can use CXL reset series, but I don't see that
> this series needs to wait for protocol error handling to be merged.  

I do want to get to the point where device memory error recovery is a
first class citizen. CXL Protocol Error handling just happens to be at
the top of the review queue and safe to assume it can be a foundation
for further RAS features.
