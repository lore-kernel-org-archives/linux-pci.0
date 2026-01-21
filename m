Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFF1296BDB;
	Wed, 21 Jan 2026 00:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768955426; cv=fail; b=UJD8CWnGSzHh8VmbnznUN5snGlgbsxE0qkSvmQAO+pfvdtK5G+FG5d/h/oskXaM9WYyLYAPkBAKOeE25A69bfhhY0LgEg8mHdNYbG26s+FfN6X7DHO5ktzxGUTgTwDsNKCJuQjkCkmn4Ii1RBE/zYCHM3WtVyMHmv20SvN5IwUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768955426; c=relaxed/simple;
	bh=3iEfwr1UpZUXl3UzJ7Opaoxql8oRzkREhvreBrRy29w=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gNJjX6gYEDpuwoyNIlMj+27NXLZZbQ3LnHkbbEVPb0nEQhJ702aI014XsdCNqX/gzEJikuhddZ38+9HLsFRgzHTQ456U6DkAs+n5CKNOUMT1m3+4BIuIuhhxkB5gQ2qNUTbZfPKOtu0EXQlNX5ku7NxR0gdAUZsv/oxttJ1GyQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UIH3CLKL; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UIH3CLKL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768955423; x=1800491423;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=3iEfwr1UpZUXl3UzJ7Opaoxql8oRzkREhvreBrRy29w=;
  b=UIH3CLKLExAnthMpi1RgpNNO4dU3DATTqIc9s9/OI52nvHkpNrbzmBKm
   ozYk8TJtszvzVSB+AhzVRHDHOC3bG5ptMPl302tw2eKoXRJGllo7bW2f2
   I2cJ1o4bbfEgmfRQlZBn+RSnCOgIRcinqZ3weaxdvatb6jXZr3MXZ048T
   pwj9Ltp7R2sJUtUw71YdrTJ9XAXoFRjNYfvPms5JY17v1yEqv1yKiv+wp
   jMZX12gIE4ivpWFTuZpXmt8WRpnp8NFvEDaHnPjL15WxyjBk2MJNacfy2
   d1o0ZamqvOmoYDTm4Um5AAOZq0SVjb+Hq6QSB8DeAZ1n+5gM1jAIC4yIl
   Q==;
X-CSE-ConnectionGUID: Qh7DXUzRRC+YMPs1if17jA==
X-CSE-MsgGUID: Z99qwcl9RKi+M8uUG4fsuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="70078937"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="70078937"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 16:30:22 -0800
X-CSE-ConnectionGUID: gv+txz60QwavwRQiXrjZIQ==
X-CSE-MsgGUID: VBt3LyPYS3ijxBJRcFR7RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="211286717"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 16:30:22 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 16:30:21 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 20 Jan 2026 16:30:21 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.67) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 16:30:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fywdckgxQ+fwvtD8ViDss1/w/bWxzYOnhy2Hm68nanHtYmtmJBNtjqG/eA4TAxZdhzjc+HR2uWuhkClsCwMnpyc3qflqo3R0EC+SAE3pnrR1exYxjo6dgdlGh9SwCzlXe/QtINE49VFVwX7ZIeM1F/Z5HGh3A6Z07Es+T1s7sL8vU56yt8apMKL8Eaxk+qZ7PO8AeNLv4+NKr+8Scf8C2FAgqsiRI/z4DtJbRJp3alLXw4WCDngh7SVqPnTrnICZBXHgEAmbfgAGVgKoftWSGXv2955OhaxM6HP+B16/s/Xdt9msAUuIKjuKjFNu7O0L5Zv08j/m7EKBfJgg5RHQpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jZB2K/iObEkiWGiWoOg6xmC0TawZ2xhXGmytAX+Vp0=;
 b=OJhoi4u+YPjttwjcwrPpl1cb8ydpjEJQzyN9ANO99KIPYm+hOWN+YAnuB2V5Y9oBd60boGJIDDZD1Nx3d4Vn5f/dJauix5zFwCu+qrP4Zt5Oh6AoC7YrJo2pqImcere2Q9RrxGPiyUVjx4CSFhThfb87MWYNg79oXuPnSuoEhMGY/2XEtOn2vwsQAMFV5ziZhXs/FXVG7wRy0wixJse/d/RPWH7O2SRSnylds0E0vekEdhwZ6IITf7FkWcel78EKHaLu04RHpgyE1xi+dciW4XFi9dgo00/WWHp+lbc28tkAGoh09gRPrz/cB0FWbOQoQm+p21uUhcqw64Ixox+n8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA3PR11MB9088.namprd11.prod.outlook.com (2603:10b6:208:57a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 00:30:17 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 00:30:17 +0000
Date: Tue, 20 Jan 2026 16:30:08 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>
CC: "dave@stgolabs.net" <dave@stgolabs.net>, "jonathan.cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "ming.li@zohomail.com"
	<ming.li@zohomail.com>, "rrichter@amd.com" <rrichter@amd.com>,
	"Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>, "huaisheng.ye@intel.com"
	<huaisheng.ye@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Vishal Aslot <vaslot@nvidia.com>, Vikram Sethi
	<vsethi@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>, Vidya Sagar
	<vidyas@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jason Sequeira
	<jsequeira@nvidia.com>
Subject: Re: [PATCH v3 0/10] CXL reset support for Type 2 devices
Message-ID: <aXAeEHMVY1Jf7oeI@aschofie-mobl2.lan>
References: <20260116014146.2149236-1-smadhavan@nvidia.com>
 <aW1ercZMyqh2Ej5F@aschofie-mobl2.lan>
 <CY5PR12MB6226EE35D88E6F4442572D1CC389A@CY5PR12MB6226.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY5PR12MB6226EE35D88E6F4442572D1CC389A@CY5PR12MB6226.namprd12.prod.outlook.com>
X-ClientProxiedBy: SJ2PR07CA0022.namprd07.prod.outlook.com
 (2603:10b6:a03:505::24) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA3PR11MB9088:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b748ee3-de19-45d7-fa0d-08de58844020
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cVRXQitGR0xLcjh2UnQ5U0xYNFdza2xiWFZramt5c2ltc2lxYjhvSWdZWXM3?=
 =?utf-8?B?eVhXV2JrR0hmTlVqQkZaakllRDdPWFBwNGU4QXoxcEx2MEFMT2tFQXNLTXNl?=
 =?utf-8?B?Q1J6WW5yT2YzSWNtWVd0Z0IwUkFpY21ldTJaaXNnR1VtQVlCeHVJbTlxNGFM?=
 =?utf-8?B?WUtzU1ZsRjE1U3p3bG5wTUVKOWhMamZLN0wzZitTSkRFeDZoMXZpMFBuTy9T?=
 =?utf-8?B?d1FQWi9kL0lqaG5YUThTbXI1enJibnAwb3lYcUFxU0FTeUxSbzhGNHBFbnd2?=
 =?utf-8?B?YXFnM3BjTW83a1NyOUFjeEZyQUtOYmJPbklMeFZKeWdMaXpRZXkvMytRNjlO?=
 =?utf-8?B?T2lqQk41QlFnQXg0OVA4M0dWNWp1Y3F2bU1ZV1pBbDkrSkdCUHlhL3Y5ZlNN?=
 =?utf-8?B?cW9TVDVsY1BGN0FFc2EzV2VRK1BqaDlMMmpkUzFPZnREeUlKRmlQancwRVpl?=
 =?utf-8?B?NU1aRmRySHpRSFJjWncwVDJpbkpnV1NQWUNlQ285SGlzTzFrWjcwT3Y2dUtI?=
 =?utf-8?B?YlF3ODhmLzh2TVpoaHFrM0RkTm4xMUdFanhSbnVVb1RuNnkxR2FYL1hCTXZE?=
 =?utf-8?B?SjQ5VzJzZXQzMU1RK2xJT0U3b2JjL0VIb1gyVXRHL0x4bXBObDQ5czZ4YjMv?=
 =?utf-8?B?dzNHR2MwT3daVmpmVWk2K3ltTFRFZDAyT1QxanQ3SHc3V3dHaGgrV2RWRDVM?=
 =?utf-8?B?L3ZJeFl5a0t3blVpR0hGZkFFSmRHVFR3RE1TUXNjekhZejlER3dZOTVmS25N?=
 =?utf-8?B?N2FYTUszc0grcXNmM1dHcU5ZSW90TmVSQ1p4am9uZ2hodHZibk5CUEIwMytp?=
 =?utf-8?B?TGo1dGxHVytXaUg4bG9VdG1uUGcyS2MvZHNzVXFZY2dsMWdQNDVkTGh1SWFv?=
 =?utf-8?B?RXlVTHFzV0ZvYXY0a0FmM1lOa0hUVGV3QVpNendUYVh2aU1wcTkrdHJIRGNH?=
 =?utf-8?B?WVIveDRlVHg4eXRubVFNblZldFo5ck9xUUJ4UnJaUk5EeHI2bWRmVGtFZUFV?=
 =?utf-8?B?bytkcGhxWDB1NGRZN28yTkQwMTFwQ3BBTUJTSGJDcXp0RWtHM2JZVzBWU3Jy?=
 =?utf-8?B?TFBRUU1IbkFDbHJaemxYWlo4cEEzbzhBdHVzMHg2RHdlNzFaandheUE3elUr?=
 =?utf-8?B?ZFM5NFFGTGVYSVQ2Q3U0d292YlhocGdCUnVGekw4VmF5YWI1TTU2UGxYcjJ2?=
 =?utf-8?B?bnlLSFVGNjZSUlhvMTJZa3I1L2ZXR2trNTJodndSVnAyeGV5dGNFZ0tmZ3Ix?=
 =?utf-8?B?UG1UUElNalVZcmdWRm1yZDAyYUYvRTNuTFAvUnBOOGZGR2FTckhISENWcitR?=
 =?utf-8?B?STBwUVVtenNoeEl4OWZzdUtTK3JKdGcxMXNMQ3FGeVE0T1U3bWZPV1BoWTl0?=
 =?utf-8?B?bkgwU0R5OEhyK1hhRThKaitFYVZ0VGVIYTV6MTYySC8vN2lwZ2tidlp5MlF3?=
 =?utf-8?B?emx2SjBkM2VIU21HMWtBYXlqR2p3dzhkNGdkZ3RKM3ZBSm0wVU1mU1NZODBv?=
 =?utf-8?B?cFpyWWJVNXRQdERBZlpXcFNaU1NPTFppTXNDOFdUbUtJUzJVa08ydWE3WGMy?=
 =?utf-8?B?dGdFY0prOGNqK0ZJOSszUW1tcFNkYjk5WWxKZ2NSY3c1Z1NIaFlMaG11TkYy?=
 =?utf-8?B?b29EcTRhSWo3OFYvaGQ4QnhTU0JqWWcvMDBvdnprNzFlc2dSNU9uUVNUTmlk?=
 =?utf-8?B?cWE3TEVjVmZoMVZIWWxRTjB1cFVnbmViQW9rS3IydWc2UVpFVERsNFVBSm1Y?=
 =?utf-8?B?ckI0aHVsSTlZNmdnM3hJRHkya3pVS1gwcVBpQURrWTViVTQxMXo5LzZTcXdE?=
 =?utf-8?B?Rmx6Ui9LNVM0cDFYeWwzM2tGbG5WWnVIaS9WZ3R5V2g3ZEZvdHUrR2EycWJr?=
 =?utf-8?B?bFovbmt0d3E5SUR5VG54bXpHOHRicmpGQnRBQVlSSlB2QWo5bzBJZE84bXpR?=
 =?utf-8?B?VUdSYit3YXNKc01TcnJ4S1BIYTZHWjlBQWlJWEJRemlzbUFadG5BSzBmMDU0?=
 =?utf-8?B?M29QeXlFY2poZDRGQ1kwaUJEb0lScllJWDN0NVZtNU1CT2pHZTdUS2RPckE1?=
 =?utf-8?B?eHJaT1NXdHMrbHR3UERyVEhWNHpQWEhzVnp1WlJBYmJLU1J2a0FhMHByVmxH?=
 =?utf-8?Q?keOg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXQ1c2l1bDlvbSt2N2hlYzBudjhIalYydnpIZlFFSnVFK2tsU0xMNXNQaDZ4?=
 =?utf-8?B?enB4VVczaDlvWDZieWJNaGd5bmdheVI1bWJ6MXpnVUdkclJXNFZ4ZFhVcnBh?=
 =?utf-8?B?SlhGUGN1bFUzRmF0ZkIzZDVpY0FxUTdyTlZrclpvTzQ2dkJMenlIeDdKOHNO?=
 =?utf-8?B?U0NuckhnZlpJOFRJWjN1empZTFZ1R2tRVXh5eHQyRzRuSFBxN2VtNksycTNB?=
 =?utf-8?B?N2xhVXRSbi9yRFdnR1NaWlZiMFUxK1ZRdERQZFlMT3M3b0FVbElYZHdUc0Qy?=
 =?utf-8?B?eVpLT29YUWprNUIvbEhPRVYvVFRxVWFTTkVGOUI2YUZaQWNrZzVMaU4wd1VT?=
 =?utf-8?B?NTd3Y1ByR0twN0dqV3ZCOE1oamZRT21yelJlcVE0Y2J4Y0VrY2Y1YWxuT25Z?=
 =?utf-8?B?UFZ4SS9xcTF5QkVIaTdQM2wzQ0xxU1lUNk9nWWFZWStKeXUwQzhGSUpKall4?=
 =?utf-8?B?VG0yYTFOTFNTZVVYN29laVZhc1drZHJISUFjcUJySGNNZE4vM1R0eHJ2aW0v?=
 =?utf-8?B?a2toMmh4R1ViOXd6bU5CcUt1cTUvVHFnN3VrZUpsdmJXSUVjR0hnZWcwV2Ni?=
 =?utf-8?B?akZyRTV1M3hQVUVRYW5ka0UzWEVmSXNXT0R3SkZ3aXpYczY3SjU4RjFUNUVw?=
 =?utf-8?B?THRlM0NFTDhjMWd5aFo3R2RkYnFoWjh4NXpDWGJBRVpqNE5FMUMxdWxQbHdF?=
 =?utf-8?B?RXhCVWdJWW9GTFRxTWR1U2VxWStwQ2YzU01CbzFub1ZHUi9QZ1FyWGp4QW40?=
 =?utf-8?B?QjcwNFFOaSs2MCtPSzExd1ZvWGczQ3ZlNElPdmN0VjBtNTM2aDNDcnltb3VM?=
 =?utf-8?B?emlrS2p6UjdXeHhMenZrV2pLaWNFMzgvY25qSnZiSlNrUEJYcmxxVnNrbjE5?=
 =?utf-8?B?OXRtemMyK0I5dThjQzU0UDArd2hWK3VkS21yTGZpYmpUUmo1aWJyMVdyQ1I0?=
 =?utf-8?B?L1lSM1B6OUZXVFI1YTZKMkRCRXNlZW1oT0QyUVBrMXRaemUwRHl1b0pUNWlH?=
 =?utf-8?B?ckxtZDRKTFJXVVZVc3VTSzFMTytDSmV4M3dMbGlZNHBNUjlKSDV1SDRXR1Nw?=
 =?utf-8?B?eUVFRndDQjR1ZGtva0N6QVl3V1dsU1NGNk5DcVBzTEhtcUFCZkJJTkJaQm4r?=
 =?utf-8?B?RzJEVE1XL0tWTjBXZVNwTVlwNUp3WXd3UXZKYkNYZmJwWGo4cFYwd0RFWVFo?=
 =?utf-8?B?MnRPZGlqN094ZXlmV0ZKVFNBZGNWRmtaV3VLVkx4SzFNWmZDRk1Dd1hoVHF3?=
 =?utf-8?B?bVRlUUdGUVFQNjh3YllQZUM5bXBsKzNoZkZ2TWdVckN0Slp3VEFZbW42dFNn?=
 =?utf-8?B?UVJXVEFxKzhwa0dRSHdxTFVOelR2WC9SOWhTNHpocldBSk1RR1lLZEVYU1Ny?=
 =?utf-8?B?bnJuT3JpZExEQk1hTE8xdXZ5VVY0UUo1b285bVk0RmVtdGsyU08waHdsZHA2?=
 =?utf-8?B?WFZXdnJxYWxOVVZTL0hkSklmMHVXT1JwWVhtMUZRVjVqek53S0o1b3dPb3FU?=
 =?utf-8?B?dGJRb3M3R1J5dlFVT1NuMHJqZ2FzeFVLNTliUGxXMGJzMUpWd1BxZHZmSXox?=
 =?utf-8?B?d2NwVXRsQ1dRVTZmdkFTSis2R2I5R1ZQLzYrdDJMY09TRnFuakFIanlKbVNC?=
 =?utf-8?B?UjF4ZFNxVU4wN21LdDl3YmoxZE1YUzI1TlhHOStFL2RleWhwczQ3ZXdKMWc4?=
 =?utf-8?B?Nlp1WHpVS2dRWVk3RklHT3d6UFoyaWg5di8wZ25Xb0VLK0ZacFZxUUdKcWQ3?=
 =?utf-8?B?ZzNqTXlYbnpGUzBzajBrKythZHZtVzV5SEdPRmFxbXlFMzVWa3REUDRGR0Nm?=
 =?utf-8?B?NE5LZWFLcGM0TVl4eUZPZDFjZ1Z3UzZibnlJcmlmV1h4ZmlsQmt4eDlvWFdi?=
 =?utf-8?B?MEpMclYrQVhmSm9XanZ6TndJT09kMnkyMGEzVE44R1M5V3RkMHozcjBVNG9M?=
 =?utf-8?B?Z2dqRDVEZHRnaTNGRnUrcVdzUTc3VFhBNXZTSVNOUzVwR1BzdUdHQTdsM3dM?=
 =?utf-8?B?ZC9MeDJsRkl2dWlhbmRseEdHdWZSNkMwK1pIVVJOWGp6YXh2WDhhb0pUZDdt?=
 =?utf-8?B?dHhnakxjWlcyWjV2eXRVcHUwNE9zNjhSdlNCVGxrSG9ENG5PR1RScUZDMDZE?=
 =?utf-8?B?dmhZaHlKSlk2LzE3UjhxRTZxSUVyY2ZIcnhXRzd0WHNDcW12aHNxTWNoVXNY?=
 =?utf-8?B?bnBDYXU4alRCaWlYVHJpeDJSWmNtbk4vREwzYXlORkpIQVAycXAvWjFIQlZK?=
 =?utf-8?B?ajUxRkQ2dXpwaHFGN0MzM2ZvUXh3MllRazRPenhNN3NYVzVTeURuYkpGckh6?=
 =?utf-8?B?S2hDVlRpUlhFcFpMWTVrTGhFQ1dzK2k5OUdhSFQ1enA5bmYvSGlHUUtZa1RI?=
 =?utf-8?Q?m02HJlgyyivA2Hvg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b748ee3-de19-45d7-fa0d-08de58844020
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 00:30:16.9913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +g9w7E6shJzOQlzFMtqfGi1MmIsbyzws5ntluRSDmjDl+J86elvrNEXMKpM9hfBkz68l942dlQjy8SbgaaOSbK1WSvePgIMci5Trfu5Z+Ic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9088
X-OriginatorOrg: intel.com

On Tue, Jan 20, 2026 at 10:30:51PM +0000, Srirangan Madhavan wrote:
> Hi Alison,
> 
> Thank you for the heads‑up. I’ve respun the series as v4 and rebased it on pci/next as mentioned by the testbot. The v4 changes are limited to build‑fixes from the bot report + Reported‑by/Closes on the reset method patch. And the reproduce steps from testbot clear locally for me now.

pci/next? Ah, that's different than what we typically do in drivers/cxl.
I was expecting a mainline base commit - like 6.19-rc6. Anyway v4 still
has conflicts w that. What is the dependency that is on pci/next? I can
see the impact, appended below, but pci/next has a slew of things since
6.19-rc1.


drivers/cxl/pci.c:1090:6: error: redefinition of ‘cxl_is_type2_device’
 1090 | bool cxl_is_type2_device(struct pci_dev *pdev)
      |      ^~~~~~~~~~~~~~~~~~~
In file included from drivers/cxl/pci.c:11:
./include/linux/pci.h:1472:20: note: previous definition of ‘cxl_is_type2_device’ with type ‘bool(struct pci_dev *)’ {aka ‘_Bool(struct pci_dev *)’}
 1472 | static inline bool cxl_is_type2_device(struct pci_dev *dev)
      |                    ^~~~~~~~~~~~~~~~~~~
drivers/cxl/pci.c: In function ‘cxl_check_region_driver_bound’:
drivers/cxl/pci.c:1419:28: error: ‘cxl_region_rwsem’ undeclared (first use in this function); did you mean ‘cxl_region_ref’?
 1419 |         guard(rwsem_read)(&cxl_region_rwsem);
      |                            ^~~~~~~~~~~~~~~~
      |                            cxl_region_ref
drivers/cxl/pci.c:1419:28: note: each undeclared identifier is reported only once for each function it appears in
drivers/cxl/pci.c:1420:41: error: ‘struct cxl_region’ has no member named ‘driver’
 1420 |         if (cxld->region && cxld->region->driver)
      |                                         ^~
drivers/cxl/pci.c: In function ‘cxl_decoder_kill_region_iter’:
drivers/cxl/pci.c:1437:9: error: implicit declaration of function ‘cxl_decoder_kill_region_locked’; did you mean ‘cxl_decoder_kill_region_iter’? [-Werror=implicit-function-declaration]
 1437 |         cxl_decoder_kill_region_locked(cxled);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |         cxl_decoder_kill_region_iter
drivers/cxl/pci.c: In function ‘cxl_region_flush_device_caches’:
drivers/cxl/pci.c:1504:53: error: ‘struct cxl_dev_state’ has no member named ‘pdev’; did you mean ‘dev’?
 1504 |                 if (!target_cxlds || !target_cxlds->pdev)
      |                                                     ^~~~
      |                                                     dev
drivers/cxl/pci.c:1507:35: error: ‘struct cxl_dev_state’ has no member named ‘pdev’; did you mean ‘dev’?
 1507 |                 if (target_cxlds->pdev != target_pdev)
      |                                   ^~~~
      |                                   dev
drivers/cxl/pci.c: In function ‘cxl_reset_prepare_memdev’:
drivers/cxl/pci.c:1548:21: error: ‘cxl_region_rwsem’ undeclared (first use in this function); did you mean ‘cxl_region_ref’?
 1548 |         down_write(&cxl_region_rwsem);
      |                     ^~~~~~~~~~~~~~~~
      |                     cxl_region_ref
In file included from ./include/linux/spinlock.h:63,
                 from ./include/linux/sched.h:37,
                 from ./include/linux/percpu.h:12,
                 from ./arch/x86/include/asm/msr.h:16,
                 from ./arch/x86/include/asm/tsc.h:11,
                 from ./arch/x86/include/asm/timex.h:6,
                 from ./include/linux/timex.h:67,
                 from ./include/linux/time32.h:13,
                 from ./include/linux/time.h:60,
                 from ./include/linux/stat.h:19,
                 from ./include/linux/module.h:13,
                 from drivers/cxl/pci.c:6:
drivers/cxl/pci.c: In function ‘cxl_reset_cleanup_memdev’:
drivers/cxl/pci.c:1585:35: error: ‘cxl_region_rwsem’ undeclared (first use in this function); did you mean ‘cxl_region_ref’?
 1585 |         if (lockdep_is_held_type(&cxl_region_rwsem, -1))
      |                                   ^~~~~~~~~~~~~~~~
./include/linux/lockdep.h:253:61: note: in definition of macro ‘lockdep_is_held_type’
  253 | fine lockdep_is_held_type(lock, r)   lock_is_held_type(&(lock)->dep_map, (r))
      |                                                          ^~~~

drivers/cxl/pci.c: At top level:
drivers/cxl/pci.c:1665:5: error: redefinition of ‘cxl_reset_prepare_device’
 1665 | int cxl_reset_prepare_device(struct pci_dev *pdev)
      |     ^~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/pci.h:1477:19: note: previous definition of ‘cxl_reset_prepare_device’ with type ‘int(struct pci_dev *)’
 1477 | static inline int cxl_reset_prepare_device(struct pci_dev *pdev)
      |                   ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/cxl/pci.c:1696:6: error: redefinition of ‘cxl_reset_cleanup_device’
 1696 | void cxl_reset_cleanup_device(struct pci_dev *pdev)
      |      ^~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/pci.h:1482:20: note: previous definition of ‘cxl_reset_cleanup_device’ with type ‘void(struct pci_dev *)’
 1482 | static inline void cxl_reset_cleanup_device(struct pci_dev *pdev)
      |                    ^~~~~~~~~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors

