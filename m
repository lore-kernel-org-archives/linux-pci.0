Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B4930B53F;
	Thu,  2 Apr 2026 01:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775092349; cv=fail; b=DTuAboIrSg4eD7v2KPVVnsOFJjsiW2p2hU7iJHag5FyD89UePTGtVHQj+OkZATTgnfV4ellVVAiFLOh7Av1OwEY4LcxrBvvlDm8qDQnPWXNUsKVZsq2LH6mFBtFkr5K4yjC0We65KGyyWTxPWBa9eYtCsPjISdQfUfmP83YH3ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775092349; c=relaxed/simple;
	bh=fJmi3eFV5BMWE4ATxPUg7Plfh6dzxMZq+nmMOSlL02g=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=Ad0eSg6b7GO1TcRFCZEMGCZq41Ws/iud9Ju3I/Qd8ipyrMBVVRyDZZMGhysnphpVE6yxnzvVZDh+bTxUVFx6m2yabegn4hvfYPNQteF+MoJy7gwPYyAG6EXyip1cudnU5TBKdMH2hWZsMXqtflNDeXlHz5Kfxg2687BXgWbH14E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LWIlY/aH; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LWIlY/aH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775092348; x=1806628348;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=fJmi3eFV5BMWE4ATxPUg7Plfh6dzxMZq+nmMOSlL02g=;
  b=LWIlY/aHm4a/JlRB88wqGGHrc0K1AszdbxNVPaL4Sn4WZA3GI+I0FOZC
   KRtT1P71q491TgLPDJqZ0wtnGFt3d9f9bpFzFvOsrOesSIzMm9mvy7ScD
   IgAcxxQ6DTuAneOxhQPbOj5WYlYByRqgDdLVWy/W87uSV5zKc0mCuogfk
   dst/KTcJUXS6DpLzW2dPy5v9QMiXiq32N7HamtyK7UZ+1jNbRFMZ/07Yh
   SlczKZxsHhfi9y408RgND/VRQFvl0yX/juZmOFg0og0VVdID1POcRANsP
   v1LyNgOblHWyimh4Q9Xq+u8Ou1gXz81OeeUpNbWELulj62VbsbCdRVkGC
   Q==;
X-CSE-ConnectionGUID: aBMitS3MQCOYSl+Qy87PoQ==
X-CSE-MsgGUID: TiSElvvtRUSwXSL9t8fu5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="76161154"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="76161154"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 18:12:27 -0700
X-CSE-ConnectionGUID: 2IM4udm5S0+EJ3WVuyvAOw==
X-CSE-MsgGUID: 7d/aWQsbSzWpZBc5ZP3wAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="257301690"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 18:12:27 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 18:12:26 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 18:12:26 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.38) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 18:12:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RhFFjcF6QqGsk1lU8l1lSTvyT8xX04qufsAc8pAa4TU1fqSejjXK2OwxisCIsI5uRLHUInXlgfZVT9O0rKC95nyITM29tgHKTGBu072qPsnA9PLQnmSJtoMjqMLlC0Dm0490H0Qi8ENMi4xb9NDK8fFFnhe6f8KgdyAjM1sWuESlTQvSAd3/joDdYiNklsJph+YDlsSYWZARGW1aMfogzgEofOx0/SlMmfN59c4vTloN9QW1Y7lwJq7eyNusbzVSWYiQtVFSU6Lzrmss3ql/KlVsDRgnwFjC6UPvaTSg2xb+9w7XV/ImzRcB8OoCHxLFuXEQ8zVgekGAVD3czrABbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntFC7C5bFnrcKfBXvCNKciUxbSWXAKxBQIhPvnVkyGo=;
 b=gUFZB2zT5Ggqi5kBJ2VEI4tP/yYU8+Hg516NQw6VzK19xgIgxRqnAXlVgIvGOIrRmAP94Q/EbqjqsVrJX4FR+D1SUsKyA+B6RtnQlNr0fLOPXiQ4YaP5oM0WN5Kg5vuUHYyy+g5rAV0X1RceVEkytsFF6KE0e40R3Z5GUdQaLSFCUCe/dgb7DnkVQQrpUq1utdomLhOXIge/jgQM4UsDP7FpqA2qiEKvI+gxrm0OEpQsGVhkpttF0oIJoiczGS9VtobWZZcqOfz07pnyrAkBJhqxROwZKC2cQuncwWzL4vyl0pm/FA7Br/x9OZIpZAUk+zucgu6tbMXbsPZVw6TFSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ1PR11MB6156.namprd11.prod.outlook.com (2603:10b6:a03:45d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Thu, 2 Apr
 2026 01:12:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 01:12:22 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 1 Apr 2026 18:12:19 -0700
To: Alex Williamson <alex@shazbot.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: Manish Honap <mhonap@nvidia.com>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, Srirangan Madhavan <smadhavan@nvidia.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, Jeshua Smith <jeshuas@nvidia.com>,
	Vikram Sethi <vsethi@nvidia.com>, Sai Yashwanth Reddy Kancherla
	<skancherla@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, Shanker Donthineni
	<sdonthineni@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>, Jiandi An
	<jan@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Derek Schumacher
	<dschumacher@nvidia.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, <alex@shazbot.org>
Message-ID: <69cdc273ca48e_1b0cc610042@dwillia2-mobl4.notmuch>
In-Reply-To: <20260317121943.3c404db9@shazbot.org>
References: <20260306080026.116789-1-smadhavan@nvidia.com>
 <69b08f8d8eb97_490a10042@dwillia2-mobl4.notmuch>
 <20260310164630.7abeed30@shazbot.org>
 <69b0c934b2793_2132100ec@dwillia2-mobl4.notmuch>
 <IA1PR12MB90304014081461742C3977F4BD41A@IA1PR12MB9030.namprd12.prod.outlook.com>
 <69b98960907e9_7ee31003b@dwillia2-mobl4.notmuch>
 <20260317121943.3c404db9@shazbot.org>
Subject: Re: [PATCH 0/5] PCI/CXL: Save and restore CXL DVSEC and HDM state
 across resets
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MW4PR04CA0373.namprd04.prod.outlook.com
 (2603:10b6:303:81::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ1PR11MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d4564b8-6d95-423f-cf10-08de9054e47b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: pUWUDJogTUxwjh0dxcjIXDkFw9JJq5OBEmCIvquGbS4fM0OEwJ6MKnloMrH0kVIavtsNfd521RB9NGiV7BK3p6OWiKjpFPu5nKB/1NqfgdU1nkPCBtxSy85RT1Y1+/8nAJhQrhi71UBVzjoMKXu0k51lZmDHOrv1G5q9hWYtI8qY/yMYF2v/SljwQvYMdXZ5hf7/RNNJnJ8tOQoZdjVJFgthSf7UFQHGpL6RwE8cbCg2bmiCeAF6FWtjF59cQDiv3nRB7++oShTPbRdx82JIhgC19u18H1uwVj8e2icMUvGwc3QYVGEBe3n6SG7JM+y+/a4hWoKcibYQ5c4vreWYRUSn4i3jnGz3asomD2iG1Ib1Epgo25BjjPbZxaHqD+g+TD24nUf7rVJqmhKaDOmMgQxiWZETx3JrDwmaCtzbBIgWtUO5ShOB9hURQFbVmO6tNtpkFygKYq+ytisDZQhN7FhZQXAMkvwqowMVj/dE8caHcgoH77AcM7QT2nQfd19QllmPWf6WAl7yEDu4XG9vBMDRalrYbImkUIH5UvkGqaWuFsNxi22UwQYWrwQBEh1E5OiQ+gV3cP9vNMG35dnGyMcYhkmgDdMexXGN45ndOL4tnmgPVEXSw4NLpfuFDaEgqmJcQs1Spj4GJfrI8kvISuU7qedvQhBqdZ0xjv5QYBIL57ys1mqYa+CRhWB0yqaVvqLoaJ51Y3eQbHduP8gEi/OJDV1KTBaYgelImuVVCRM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MG9DcGxvODRENzFCSGFESDh2M1dNbDVyOXkyMGs5blBRVVZhSjFvNit3SjRH?=
 =?utf-8?B?REMreUpVRlgrdnkwajI0V2VqOFd3WFFISnVFY2xFOVFlNGZaSjJCS0x5MkxC?=
 =?utf-8?B?eXpvY0V5dFRGZ09vZFZVTjVhS2JjSU1uUitZckJaZ0xZWVh1UW9tdC9zT29h?=
 =?utf-8?B?bGpiZTBQUVczTGgrOS9rYmUzZVNsRlBvK3NmS01SbFdUL1pibS9TMkhKOGJ5?=
 =?utf-8?B?U0ZPelNKMStYa2ZUamlJWWpaVXFvK0hvOS9zODZYaUZUM3BHRzNDYWxTdnZH?=
 =?utf-8?B?ZGgrbllPWkRaelhSVnlwSmQwVnlCbDl5bk9aMFVYMWxjRDF1SlJvM3lmaURa?=
 =?utf-8?B?dnlySzhhN0RpRlI4dFJpQ2RaTXN5VlNxa2F6Kzl5d3MxeGViMFZ5L29KRnR5?=
 =?utf-8?B?Z0VmZzlBdmoyT0lUaTA0a1hVaFZUV2cza3lRVHExbGJ3L3FWNWJtSGRHWmQr?=
 =?utf-8?B?UXZURW5wWVBrMDRKMkZNaU5URXBKTGhZenJ1SGk0UXhCdU1LL2hSbERoc3B0?=
 =?utf-8?B?ampONzQ3UGh4eGNJU29IRU85amYwc1M2VTRWVHF3Z1NnaVBXa0NoV1MzU2Q4?=
 =?utf-8?B?anBuNzJYSjhMeUtqMzQwVFk4UDNXSDg4TU5lRFo5Um00dnFBaGo4K1pjZEFW?=
 =?utf-8?B?TXppVFptTkxHdFl1SXBzNnA2d2E2TG55SkJFbVR4MEtwTEZaU3paL3REMlNy?=
 =?utf-8?B?Sm9FU25GeEJKRVJUcWdSYjFsK1F6ZGtTVm85V3liYTV3c1RmcmlkQlpHVFBv?=
 =?utf-8?B?NEo0a3BlaW80dHcxYkZ6T0dNSmlhakovT2pkNHByTEtJL0JmMkxTUEkrcGJy?=
 =?utf-8?B?MG9mRmt1OTVmNGFZUFRSV2QrSG0vQjFNdU9qbHdxYlg4ajVyaWd5NW1XdWZx?=
 =?utf-8?B?dzY3NVhJc0ova1RUT0xocGJndCs3cmhxTDhKT3o5L3BiYkt5QkFURklrdlVZ?=
 =?utf-8?B?eS9NekZVcllhTHlIc1UvZFN6c3FXTHZFV2hWUE02ME5lanNuZG5ScjdiOWVI?=
 =?utf-8?B?SXVzTkJ4TVBHVTQyMmpmSzYwTTNQeW5BSU9CWUFmVmtDbFF1R3NzQXo2N3JO?=
 =?utf-8?B?RE1KMllNWXZrRnlPTGdYNi9jRVlCaGF6eFJwclNPaEEyZDFmZVg3cW0zZVdU?=
 =?utf-8?B?Zno3TEI1MkdQOWM0cmFKMENIOXBPSWRDUEVYQzMwWTRRdW96UGQ3ZUdEUHhq?=
 =?utf-8?B?TFJaVnk5WitiVmZXbWxnWkppWG9mT0wvR1ZGZG5vQlhnbkZqNHZUMUtXQUw3?=
 =?utf-8?B?MDQ3dU9KcmVHbDFkUi96a1hHQmZRaU1SQmM5Rk90Tlh3dGdpMzkwUTVZQisr?=
 =?utf-8?B?RFdodzlmMXdGYkxTellWcmRQZmtkMHlReDlWTnFqeGd2dkxCWHI4SXQ5Wjdy?=
 =?utf-8?B?MkpoYTk3eFFHdmZDbjdwclovODZkakc4Ujh5TVpVVkM3M3RGQ1JVU2dZTmZD?=
 =?utf-8?B?ZWFLMWFBWEpiM25qcFk0Q1YrYis5QWV6emsva3ZZRWJJVFEzMjNVR3BoeUtK?=
 =?utf-8?B?NDR5cUpkK0hKUng3QUNRc0hVTG1KNGZyMk1VdHd0dnZMM1ZFblJmQWl2eFV2?=
 =?utf-8?B?djJqSXY3dGtQQTZCYjNIVDVqejZhZEtYQm5veVFCbngzYzhnbXdYTWlKMUN3?=
 =?utf-8?B?Y1UzL1FFNjRocG5TR1A2Wld5eEZNUTJ0ek1oOWxKdERkNEFoWXBkbXhvLzVJ?=
 =?utf-8?B?SmZncjJTQm1TUHhJNmhySjhLT3hiQk9qZVVsWFp4b2pIa2dSTktKTnhmTEJq?=
 =?utf-8?B?MFcwY1hqdkFUV0lZUVBEbFpleWlvdWx6UnEvUkJBdGk2QUVkQUUvYzZIR2Jm?=
 =?utf-8?B?V3VoRlI4SHFlc3JtbWpia3pJeEtXRjR2bC9xVkhSN3lRWk9zRFFUaUx6ZnFT?=
 =?utf-8?B?UWlndlFIREQ1ZkkweUc2QmhyZmNUdHlwUmN5dFZaNzliNUtvODV1WTh5Wlkw?=
 =?utf-8?B?S0FDemdFUEVKdUo2UE4rSzBGU1dzK3dPcG5NQ2JtWVlidzVzL2s4YUVqbldj?=
 =?utf-8?B?cTJsMjVlWUFVdXg2MnhvY2EyTUJQb1R6R1R4dk5mcTdJOFkwbUt0VVJtd25D?=
 =?utf-8?B?L2xFMTFpVXVEQ25laC95K1pFQTdUb3lvRU5mQzN2R0pBVHk3QmE4VzdmakNq?=
 =?utf-8?B?Z09SSmhzeHJiTlhEbzgvVW12a1Z0WDVQa29TdW41TXoxWjdPc0d3aWc5N0lB?=
 =?utf-8?B?TXQyNzN3WXhaRU5PRVErQUZYK09vUFFRVWpSVjRhY05GVERzbndkeEhDYWR6?=
 =?utf-8?B?NVNaYnpqTFZneDJsQmdBRGZ3WjZ5WEZwd1cxVWtSRitOTjZuQ3hLQ1d0UmYw?=
 =?utf-8?B?cmk0amJxMm9zbW4xWEdZMklqYUNHQ2VTTXFzaEZvVXBXcG1uNDVHV015UElw?=
 =?utf-8?Q?zmMFD6uzqT2fGm6E=3D?=
X-Exchange-RoutingPolicyChecked: OMtxJdCmru8MYi5NLGGhr2m3UepITYmiMFGw6DoUGsrigBuN2kmD2PFJsWDCmVKulwwwhHdy2KMayTn8dCdR40GO6NWcYEa93D4DKfGV64rZIyTEg8irN9pv5h7GDstUBTnQCfMpNIRcjRVYQq2SE6gjrhS14ykUNaJbrMVukmPV1UnwlYP1TFE6SSHyq4G7/C2Etqdw4DkI/CwvwPUGmQDTjbiyMRltF9zxFpyABOKVMEi4hxUgykFGHYigmhyEJijItjA0e5F5j47+W2RKWznWvFe7uWJeXlgLk4iA3JO63K2LkHlhar7iCPoQlUoc2OuDmOLhXj5Lm7iT6tQVtA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4564b8-6d95-423f-cf10-08de9054e47b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 01:12:22.1071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZGffA0bSRHiuXaaa0kn6ajf1im1pCdC8GKEgN0OuE+VlIyeUb1iWe9zJbPUAgknMeVQlNk91bvdJby3QKFxuyLYxVXxCZBbnDN/uUhNxw6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6156
X-OriginatorOrg: intel.com

Alex Williamson wrote:

Hey Alex, sorry for the lag in responding here...

> On Tue, 17 Mar 2026 10:03:28 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>=20
> > Manish Honap wrote:
> > [..]
> > > > The CXL accelerator series is currently contending with being able =
to
> > > > restore device configuration after reset. I expect vfio-cxl to buil=
d on
> > > > that, not push CXL flows into the PCI core. =20
> > >=20
> > > Hello Dan,
> > >=20
> > > My VFIO CXL Type-2 passthrough series [1] takes a position on this th=
at I
> > > would like to explain because I expect you will have similar concerns=
 about
> > > it and I'd rather have this conversation now.
> > >=20
> > > Type-2 passthrough series takes the opposite structural approach as y=
ou are
> > > suggesting here: CXL Type-2 support is an optional extension compiled=
 into
> > > vfio-pci-core (CONFIG_VFIO_CXL_CORE), not a separate driver.
> > >=20
> > > Here is the reasoning:
> > >=20
> > > 1. Device enumeration
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >=20
> > > CXL Type-2 devices (GPU + accelerator class) are enumerated as struct=
 pci_dev
> > > objects.  The kernel discovers them through PCI config space scan, no=
t through
> > > the CXL bus. The CXL capability is advertised via the DVSEC (PCI_EXT_=
CAP_ID
> > > 0x23, Vendor ID 0x1E98), which is PCI config space. There is no CXL b=
us
> > > device to bind to.
> > >=20
> > > A standalone vfio-cxl driver would therefore need to match on the PCI=
 device
> > > just like vfio-pci does, and then call into vfio-pci-core for every P=
CI
> > > concern: config space emulation, BAR region handling, MSI/MSI-X, INTx=
, DMA
> > > mapping, FLR, and migration callbacks. That is the variant driver pat=
tern
> > > we rejected in favour of generic CXL passthrough. We have seen this e=
xact =20
> >=20
> > Lore link for this "rejection" discussion?
> >=20
> > > outcome with the prior iterations of this series before we moved to t=
he
> > > enlightened vfio-pci model. =20
> >=20
> > I still do not understand the argument. CXL functionality is a library
> > that PCI drivers can use.
>=20
[..]
> If we were to make "vfio-cxl" as a vfio-pci variant driver, we'd need
> to expand the ID table for specific devices, which becomes a
> maintenance issue.  Otherwise userspace would need to detect the CXL
> capabilities and override the automatic driver aliases.  We can't match
> drivers based on DVSEC capabilities and we don't have any protocol to
> define a "2nd best" match for a device alias if probe fails.

I can see the argument, and why it makes sense to attempt this way
first. Point conceded.

Now a follow on concern is the plan to manage a case of "PCI operation
is available, but CXL operation is not. Does the driver proceed?" Put
another way, I immediately see how to convey the policy of "continue
without CXL" when there is an explicit driver distinction, but it is
ambiguous with an enlightened vfio-pci driver.

> > If vfio-pci functionality is also a library
> > then vfio-cxl is a driver that uses services from both libraries. Where
> > the module and driver name boundaries are drawn is more an organization
> > decision not an functional one.
>=20
> But as above, it is functional.  Someone needs to define when to use
> which driver, which leads to libvirt needing to specify whether a
> device is being exposed as PCI or CXL, and the same understanding in
> each VMM.  OTOH, using vfio-pci as the basis and layering CXL feature
> detection, ie. enlightenment, gives us a more compatible, incremental
> approach.

Ok, to make sure I understand the proposal: userspace still needs to to
end up with knowledge of CXL operation, but that need not be resolved by
module policy.

Userspace also just needs to be ok with the unsightliness of the CXL
modules autoloading on systems without CXL.

> > The argument for vfio-cxl organizational independence is more about
> > being able to tell at a diffstat level the relative PCI vs CXL
> > maintenance impact / regression risk.
>=20
> But we still have that.  CXL enlightenment for vfio-pci(-core) can
> still be configured out and compartmentalized into separate helper
> library code.

Yes, modulo some of the proposal here to enlighten the PCI core with CXL
specifics that I want to give more scrutiny.

> > > 2. CXL-CORE involvement
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >=20
> > > CXL type-2 passthrough series does not bypass CXL core. At vfio_pci_p=
robe()
> > > time the CXL enlightenment layer:
> > >=20
> > >   - calls cxl_get_hdm_info() to probe the HDM Decoder Capability bloc=
k,
> > >   - calls cxl_get_committed_decoder() to locate pre-committed firmwar=
e regions,
> > >   - calls cxl_create_region() / cxl_request_dpa() for dynamic allocat=
ion,
> > >   - creates a struct cxl_memdev via the CXL core (via cxl_probe_compo=
nent_regs,
> > >     the same path Alejandro's v23 series uses).
> > >=20
> > > The CXL core is fully involved.  The difference is that the binding t=
o
> > > userspace is still through vfio-pci, which already manages the pci_de=
v
> > > lifecycle, reset sequencing, and VFIO region/irq API. =20
> >=20
> > Sure, every CXL driver in the system will do the same.
> >=20
> > > 3. Standalone vfio-cxl
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >=20
> > > To match the model you are suggesting, vfio-cxl would need to:
> > >=20
> > >   (a) Register a new driver on the CXL bus (struct cxl_driver), probi=
ng
> > >       struct cxl_memdev or a new struct cxl_endpoint, =20
> >=20
> > What, why? Just like this patch was series was proposing extending the
> > PCI core with additional common functionality the proposal is extend th=
e
> > CXL core object drivers with the same.
>=20
> I don't follow, what is the proposal?

Implement features like CXL Reset as operations against CXL objects like
memdevs and regions. For example, PCI reset does not consider management
of cache coherent memory, and certainly not interleaved cache coherent
memory. Other CXL drivers also benefit if these capabilities are
centralized.

> > >   (b) Re-implement or delegate everything vfio-pci-core provides =E2=
=80=94 config
> > >       space, BAR regions, IRQs, DMA, FLR, and VFIO container manageme=
nt =E2=80=94
> >=20
> > What is the argument against a library?
>=20
> vfio-pci-core is already a library, the extensions to support CXL as an
> enlightenment of vfio-pci is also a library.  The issue is that a
> vfio-cxl PCI driver module presents more issues than simply code
> organization.

Understood. As I conceded above my concerns are complications that a
vfio-cxl module does not solve cleanly.

> > >   (c) present to userspace through a new device model distinct from
> > >       vfio-pci. =20
> >=20
> > CXL is a distinct operational model. What breaks if userspace is
> > required to explicitly account for CXL passhthrough?
>=20
> The entire virtualization stack needs to gain an understanding of the
> intended use case of the device rather than simply push a PCI device
> with CXL capabilities out to the guest.

Agree.

> > > This is a significant new surface. QEMU's CXL passthrough support alr=
eady
> > > builds on vfio-pci: it receives the PCI device via VFIO, reads the
> > > VFIO_DEVICE_INFO_CAP_CXL capability chain, and exposes the CXL topolo=
gy.
> > > A vfio-cxl object model would require non-trivial QEMU changes for so=
mething
> > > that already works in the enlightened vfio-pci model. =20
> >=20
> > What specifically about a kernel code organization choice affects the
> > QEMU implementation? A uAPI is kernel code organization agnostic.
> >=20
> > The concern is designing ourselves into a PCI corner when longterm QEMU
> > benefits from understanding CXL objects. For example, CXL error handlin=
g
> > / recovery is already well on its way to being performed in terms of CX=
L
> > port objects.
>=20
> Are you suggesting that rather than using the PCI device as the basis
> for assignment to a userspace driver or VM that we make each port
> objects assignable and somehow collect them into configuration on top of
> a PCI device?  I don't think these port objects are isolated for such a
> use case.  I'd like to better understand how you envision this to work.

No, simply that CXL operations relative to that assigned PCI device are
serviced by the CXL core. The object to manage over reset is subject to
CPU speculative reads and potentially interleave, I think it breaks the
PCI expectations of local device scope operations.

If CXL Reset in particular stays out of the PCI core it at least
requires something CXL enlightened to be loaded, and at a minimum I do
not think that "something CXL enlightened" should be the PCI core.

There is a reason the CXL specification decided to block secondary bus
reset by default.

> The organization of the code in the kernel seems 90%+ the same whether
> we enlighten vfio-pci to detect and expose CXL features or we create a
> separate vfio-cxl PCI driver only for CXL devices, but the userspace
> consequences are increased significantly.

Agree.

> > > 4. Module dependency
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >=20
> > > Current solution: CONFIG_VFIO_CXL_CORE depends on CONFIG_CXL_BUS. We =
do not
> > > add CXL knowledge to the PCI core; =20
> >=20
> > drivers/pci/cxl.c
>=20
> This is largely a consequence of CXL_BUS being a loadable module.

Yes, the question is why does that matter for CXL enlightened operation?
Simply do not burden the PCI core to learn all the CXL concerns.=
