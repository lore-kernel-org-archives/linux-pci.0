Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61B215C14F;
	Thu, 19 Feb 2026 05:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771477535; cv=fail; b=gyzK8kOqfTFVHObEwjvATlr2n/jzJX6fwxvGG1I+bQW9emGGKRs61DERB5t3Pic98KzuXnp1lo2vdoy8pC8j4aHuwBWsPgFINqd68eLEjHICbp283SdqzFNuHDIWxbFb9TGFIpulnwGTveS6dYuf3x5nSfgD51l0ijHEVgVK5Jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771477535; c=relaxed/simple;
	bh=+BAiNK8BrCf3xP/YWVSRBofuyeLzwgiW0DIRLDeatwI=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=XImnPndQuLBMxAtWiXtUaYULQLpVqpOXFpKrsroyxaAXjmshXdRlKdma1fE8orwKLUYpV+i3Rz7fMtGW7l5GdReBWSF2kZRWUJBfoepmJvh4lE73GJEkW6Yi9WwqedGNSjOZ/89kyC/iDXENQd6ZPL91CRRPGEztqGflPAwpdWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YomWyYrV; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YomWyYrV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771477533; x=1803013533;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=+BAiNK8BrCf3xP/YWVSRBofuyeLzwgiW0DIRLDeatwI=;
  b=YomWyYrVrctgpbVv3F7pEDnKC9arlxNFx2gCgHLF7/xaVlzdQkWUBlFb
   gZYc1ueP82q6a9Slv2HGo3FknFHaeJYWegMN5Md5pc6M9u2jDXqVGg8F4
   Vt/boEof5x0Rtzsh5tfQStD51Rxf4ndrG7xszSSdDK9BtqQ5vHhtKFiP/
   ZqLAAOQ3QX7twnonC8O9x4BCKUv3O/uyy7U95zR9VYXvP9DNj7Imf+FUJ
   TTqa3asn8ZlCifhpSzQPYf0jrGbsa7DdbmzUV9M71vMbibMts6Twd9ymp
   88z9foEXrGk0ZOevCsR2tD8bzNgM3WxBmFmVW4rpmuTLSTUzOA6guiuEC
   g==;
X-CSE-ConnectionGUID: kKGxJJ5lRf+cVAcbTEXFaw==
X-CSE-MsgGUID: BFJYaZ1/TT2VAR9EY7QVMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="72602616"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="72602616"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 21:05:32 -0800
X-CSE-ConnectionGUID: kVUi30xkQpuUbXqM9Cv54Q==
X-CSE-MsgGUID: 9GT0gXDoTBeQRZqqBGFMVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="245010609"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 21:05:32 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 21:05:31 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 18 Feb 2026 21:05:31 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.27) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 21:05:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h0LIh5gjvLFsfODCrt/VLamxUvBfTLDKeatlnGGJdsG9M4Y4qBSmJAAvIJzk2Jer5Gw5yFcPP2W4MNVPOrHk9xXWPO4BuFwGCY3ARHTBBVhbWQhNkrFaT1molh+if1hxzCvUcbSNs8UqI0E0u0F0ZCt1ORJrNhMps8Eembw3vQcFAXrtYIBEO7tL76AdhVWdsZmW+my/J3K5UE5OGKo5DbyNMcmDTK2sbuvTu5u9vpUnZoygu2naGxz+IFbSwg2uRzaFX1PdR/eOZSypc/dM3HEw1KtExdROB6uvH1IHQM5cwGb9WSql22sHxz9RiXB7RX83+lH1uaHn6utlqybe2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pj0iFcIIvDtmr1xrWjAlm4fw9hpZEeNgbdYbGkI20ZU=;
 b=PN93vx5STYXuT2D0DWK34s4iE0SzUo5HiuWDsUv9tSEB4VwTEb0uOpKScsgdPIaHXcmHYfLHmTbbhehHha3XXEYWmMK5BPyYDPIh7ksJ0KYRs1rBxFgSvsoPWoICD0fTu4PXGNKK6ZTN/+jo0QXemIHe2AhfzFjyBjHJ12ZQd8yhIbKh4oqruSySrMW4bzJxd6xwSYX9WCIvvVhK3W8AD2INjBpV2CjT4MgIGgEXYv+d2wuwQJEWxnkqinCD7eocJdzVSxIZsE0MetG46RwNVrJEQ48BHriJwJ3le4xcMO+AZLtlWTLfKssdn4TEwiOoG10BfwfJfr+3DXYZNHdegw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA7PR11MB9543.namprd11.prod.outlook.com (2603:10b6:806:4d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 05:05:30 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%5]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 05:05:29 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 18 Feb 2026 21:05:28 -0800
To: Jason Gunthorpe <jgg@nvidia.com>, <dan.j.williams@intel.com>
CC: Alistair Francis <alistair23@gmail.com>, <bhelgaas@google.com>,
	<lukas@wunner.de>, <rust-for-linux@vger.kernel.org>,
	<akpm@linux-foundation.org>, <linux-pci@vger.kernel.org>,
	<Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <alex.gaynor@gmail.com>,
	<benno.lossin@proton.me>, <boqun.feng@gmail.com>, <a.hindborg@kernel.org>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <tmgross@umich.edu>,
	<ojeda@kernel.org>, <wilfred.mallawa@wdc.com>, <aliceryhl@google.com>,
	Alistair Francis <alistair.francis@wdc.com>, <aneesh.kumar@kernel.org>,
	<yilun.xu@linux.intel.com>, <aik@amd.com>
Message-ID: <69969a18ff0_1cc5100e2@dwillia2-mobl4.notmuch>
In-Reply-To: <20260219005614.GC723117@nvidia.com>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
 <20260217235604.GA1595019@nvidia.com>
 <CAKmqyKNeyEN-h9tAnfM9j0GWiFU9idXheGQ1COCqT9MVZgsZYw@mail.gmail.com>
 <69964ddaa5471_1cc5100c3@dwillia2-mobl4.notmuch>
 <20260219005614.GC723117@nvidia.com>
Subject: Re: [RFC v3 00/27] lib: Rust implementation of SPDM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0049.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA7PR11MB9543:EE_
X-MS-Office365-Filtering-Correlation-Id: 294e1733-19ed-4016-3667-08de6f74809b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U3VQd0kxQnZyNGxKWUpoRGZDUnVDU2lpMkJwSWxraDR6RGRDdTdUWXl4ZjJa?=
 =?utf-8?B?Q3dlckwvT3FHR1lqazdPVHlYVDFiZzhKdHJFVVVralpMcC9oM2tQclVaMmhM?=
 =?utf-8?B?TkdFSjhJYmI0TE1CSGV2Vk5OcEVFellGVEIxaGZRU0xmdUdPV0o2NmJ6OEdy?=
 =?utf-8?B?dUhkd25DQVVTMENybzV5amJpYmdqbEZwRUtEZHk5K2pGSFE2a3Q0RXhvdEtQ?=
 =?utf-8?B?UTBqOEwyZytxMDBYWWVnWVUyUVJOMXRhZ3dSalFvcGVSTGNhL3VNTERLUmtt?=
 =?utf-8?B?RVMzUlhGYkN0dW9WYXArK3lDTjdnZVVzckdTNStpaEN2d09Qb0hPS21iVXBE?=
 =?utf-8?B?V29HN1FlaFA1VEExOVNyUkJla3BxZ3ZWYXZ4QjE1WTJXWTNXYkc0S1A4MUh4?=
 =?utf-8?B?WVlrcFNFSVA0M0orZEJKU2RTVzFtQWtCQlo2ZzFqSmdFeWRwTmNqbXFKVDIy?=
 =?utf-8?B?VzNlVy9oeGVBZ3RrM082dXpwRWRSM2NUNHpHRmVIU2E2Rm1VQTFqcUxkdUF2?=
 =?utf-8?B?eUJPWTRMdlVGc0kvVFdDcjIwblcya3FHZUROVlBraVc3V3dBSkJtK3JuRDFE?=
 =?utf-8?B?eFJJbHpWbGQ0dkVQcldpSG5lMlZnVGhRbkh0RnBncXYrMW9tRzBtLytaQks4?=
 =?utf-8?B?UlhlQzlIcmJtWHZqTlovQUhGbVB2MU9qRXR6UHdWQTJlKzRZSVdmcnZCNjJv?=
 =?utf-8?B?WFRmaFoyWVRLOWJqbXFyZmFsRGRFRlNKenlZNm1uL29kbU5IOXZ6VFpPeDNi?=
 =?utf-8?B?VHNvQ0MxbkJoL0ZET3VES3BPNk9lNEZxTVhKdnJqUTdTSGVoOUFnRk4rTmRG?=
 =?utf-8?B?alBwR2hvL0VxbERkTVpGNllXOWVCZS9FVlVIbGlJUEdZMFFsT1R0NmZDbXpX?=
 =?utf-8?B?aU0vTEc0cmM5dkhqcXdEMk8vSDZBVU11cjRJSS92akFTZUFXZnlLRm5OZ3Vq?=
 =?utf-8?B?UGdWSEc2bCtQWkQ5TGhUdzhZWUw1alFXa2RiMFFnRXdhN3NjeExjNzVqNk5l?=
 =?utf-8?B?TGNhU2tEYkZnOXN6Sk9JWUwrYlBEZ1ZFMlRrbU9FYzM2QkVQSkVpWFJINDJv?=
 =?utf-8?B?TlgycXFzeWo3YlkyZHlGZW9QRlMwOGxPbzlVSm5pMUI4WnlETnMyQlh1ZTYv?=
 =?utf-8?B?dXFNTG10OTcrRW1KbXJIOGF3U0kvV1dVYWh3cDIwVHRSNGFkRTJyRkhPSXF1?=
 =?utf-8?B?V1FxWWd1TzhYU21HWjNPMTNGbFNkNnhsU0dva1AxdUVYTzYxRitYdFkzaC8v?=
 =?utf-8?B?M0pHb1dNY2Z4MEVsbWJodzJRcTBiNWprZWo0dXU1cFh2czR2VXRGbUxXcklx?=
 =?utf-8?B?Vlo1VGIvekFRa3liRld1VnFPT0RqeUJOcGl0WFQ3QXk0dzNTQzU3Z2lQQVQ2?=
 =?utf-8?B?ank1Y3d4cUZhV2FncG4vSUtCdWhlNW5jTGtGOWw2RUdvek5vMkJBN3hCNUFD?=
 =?utf-8?B?eCtqTW9GYmRwRFFDclVRLzh3VVdKL0VkTmxBbG1NTlFZWlFCQlQxMFh1QTZ2?=
 =?utf-8?B?YUYvZ3R0MTJNSWRZT0kxVmZ6ZEVwSWowdVhlbzE4emIrQ1kwNXZLbElqUzZy?=
 =?utf-8?B?d2VuOGhmbmJNSklEMytRL0orQ1pVUE9ZVEVyTG5ZNmsyNG9YWUtOeFg5d2Jl?=
 =?utf-8?B?OVFWL3pyd2F0RnNvRTZNdWhVUGNsbWtmL2k5OUc4NFJSQ2RlRklFZFp5Uno2?=
 =?utf-8?B?ekNMMTc0LzdiOWZJRkV5Y1RQbnJLVk0xdTUrWmR3VmZGY0ZLM2doanR6R1hw?=
 =?utf-8?B?d2t5czJCMlM3V2pFU2FTMmoxa1VvdDlJa2UxbGw1L0xlZlNwc0JJbWxRa2Vi?=
 =?utf-8?B?NGVibi85UU5vcm9sQW1SZlpPOHVJNzczTjcyWTJoQVkrcjNsdXArZTNwcFhk?=
 =?utf-8?B?OFBEc2Y5Q1RZVzZ2UXBCZGIzUWJVL0orYXBCQ3NQRE5mZ2JpbzFoenVmZDBQ?=
 =?utf-8?B?YVhTVmZQdnVCdDVSeGlrQkVMMWhKd3NzbDB0eTRtVTVhWUNQanR3aGZaSHBi?=
 =?utf-8?B?ZjU1SUdRRGowRUlZa0ttVW1GL1dEdXB5c1dsYkZSOUJickY5aUJJSlBvcG1j?=
 =?utf-8?B?R0dJK0NWSXR1TERKQXdaMnU4SGJyQWZzZ1lHcHdPRjZIZ3Y0cHN1Zm9pQXRG?=
 =?utf-8?Q?ZkyA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzR4RmZxRGE2b2ozZXJwWXk0L0phK0p3VjhJcWRNUXpXNnU5STlmVVVlV0x0?=
 =?utf-8?B?ZjV4WTZGT3NHeVNEMjQ4aVR0ZFllZDBJZXJGVktId0pUMVZQQ1RpVVE1ZWRZ?=
 =?utf-8?B?a3FZNVh5OGgrWkxMekxFZ1Z3MHdCN2xrR0xCQlZQSlZjd1VQS1pPS2ZIVkxD?=
 =?utf-8?B?R3RtT05mbjJFcUtYYzZrQ2VzbHBQREpWK1JsSC8vYlBiSGFoNXJTNk9aSEpP?=
 =?utf-8?B?dFFOUlkzNmE5bHFPaW9HOUhxbDg2Sm93eVZDd0k5YStDSHIvM0lodjZWVVlH?=
 =?utf-8?B?UVlQM25LYzdjT09NOGxIVWkrejhHNGlBWWxMRnJBNng5aEdSb0ZIdHNacGVU?=
 =?utf-8?B?a1J1WUFBT1Z2aDl1T004emY0eXI1Ty9DdzhqOTdPSTYyN292clZIZ0RhV3l0?=
 =?utf-8?B?bDJEUkVnT0ZOWlpaMlp0UnBVMmd2czNlOUlTMW9Rdk5hYVI3RFQ2ZG10NWNm?=
 =?utf-8?B?enpQaW5oVGxPcDgycXVXZHhSMHZ3eWpRQUxlZ2RrNUx3RlBhejJlRmZnd1Qy?=
 =?utf-8?B?TlVBWU83aGN5enpLVkowRllJd203QjJkeVRBM0RqYXl4NmdabnAwWEFBaS9J?=
 =?utf-8?B?bVZFYk9qSmpzSWRzR1k4Q0swWG5sTFl6aWJiWGRIYmlJbTl4eXk2QXhxU0Ir?=
 =?utf-8?B?UEtQZnVlMlBwY1VXK0thQTlzSGVlNno4ck1HbDErWjZBdWFRbVU2SzJoeGJk?=
 =?utf-8?B?VldDWDcrbXAzNGZaZWF0bDF4VEVUbnlzT1duMjhBMENZZ3JXaTBIL0JsMDVM?=
 =?utf-8?B?K1NNM2dHYUIwWTZOMWtrTkQvQUVqTEpYL3BhNXV1TmNLY0lSR2xkMWZoWk1t?=
 =?utf-8?B?bGxaZEhQeVBoN2pzMUdsWmV1M2oxQ3BPK25DR0l4azh6VndZQXpFQmdEdzZI?=
 =?utf-8?B?MENURnJlSGYrR2d6ejFwZDBWamtJV21kYTlqdThCS1ZLSzVVRUlGbFlsbUd4?=
 =?utf-8?B?WmVoWkt3cXBuOUZ0bWtRNVlLclo4ejNIUmRFdEdQUCtMdG0yYzNPVE5YR3Rh?=
 =?utf-8?B?ZUtBNDBqSHNVL3NkcDlFZktxL2NYZzJLcGlNc0k0OTMvYXRURnNBOXdFVytO?=
 =?utf-8?B?dUVkc3hqY1d6MUpScHZKT1g4K1Naa2ZNMHRFck5tTDdJS0FKNmVuM3dFSkEy?=
 =?utf-8?B?YWkxelBGcWlLN0o5VHJkSitmM1gwMVMyN05IdEk0OEVJWVp6cklVSnJ4LzNr?=
 =?utf-8?B?amZtdkRZOFd2ZTZZREQ5WlJYeHhOUEljV0ZJSWc1OGFUNzN0MS9Gb0RPWFRY?=
 =?utf-8?B?dEw1N1RYUnZjTjIwUjJKYUY2U0NjNGo4MitsOGZRcDloSEp2MEJvSWpOa1BP?=
 =?utf-8?B?d3RXQkluNXdyMmQzS2hIcWUxRjZGUUFxZ1hzclgweWVHZkdBYlFpTXAyQW5Y?=
 =?utf-8?B?WHJXZld6VUd1SHZPUytoQUlzOTJiazExY3BLbnpmVVpBZzhiWkd6VVdpbHRJ?=
 =?utf-8?B?QmkxUkhHTURObnNCODQxVnBXZm4zaE1OaE5OYmRlSVN1T2g0dmRHRWZ6UWU5?=
 =?utf-8?B?N20ydFJGVjBlQ0YyTm1ZajN4Y2VYUE1oelQ0cTFxRy9KalJFZjJLS0todVU0?=
 =?utf-8?B?UXJEMFl6UXhqYkJNbzFONVpVOVRLUTEyaGw4dGFaL0duekhqVW9KemQvM0Y3?=
 =?utf-8?B?azF3b2E2dUlOZ3o3S0ZwY2RSWWhkMEx5VCtzd3FKbDlWQ2s0YllSajVmaExP?=
 =?utf-8?B?eWNzZzROTDMrQndlY2RNMkM4aWhBM1lvak5GN3Z2TjNNVWx5c1Z1RXhJRWho?=
 =?utf-8?B?cWlUalRkdWdnYkVsc1hwTUFjUW1idlI3YmtaV1QwUHAydnp6MDMxRTR0ZzdD?=
 =?utf-8?B?TTlRSGdqQmxvWTJWc2J0aXg1bEZTMkZZY0RSanQ1VGwyUW9NOHdSanZpd2dz?=
 =?utf-8?B?dHNaa2wvMERteXBlSExjcU5XSEZBcEd3NURKcjB3OFd2SnpYZDJHa0NpcFdZ?=
 =?utf-8?B?ajBhdzVBMndDZ2VxeWx1VGxSbVdvenNUOWpmVW8wN2tkZHNheGJTK0NUaUND?=
 =?utf-8?B?Y0NXQkdrMzY3UEUwdjRJc2s3Ti9KQncxZDRBSUVicmJSTTRMVHRaODJLQmpL?=
 =?utf-8?B?c050dGxnZS9ndlBwTS9WOGhoVXJ3T2Z5MVpadEhnK2xBWW03aUV6bGNhcFR3?=
 =?utf-8?B?dTZVMGV1NVFIVnBsOWpuVUJLRDZlUW9jdHBtVWZPU3hNbVdmL0RhTE1TbXhV?=
 =?utf-8?B?T3VrYTFSVTd2RTBQa01ERGh5K2FwVHd5dnhkSEhMSVR6QnV3K0FnMkZHQnd6?=
 =?utf-8?B?bDhabzJaVE5JQTdCK01Bai9YY0F4NVdMY2xWSmVyNXgrSnROUmRLMVpjQmdl?=
 =?utf-8?B?ZzR0VmljOHBRaGROaHhITFhWZlZUcVN0Vkh5SkRlQlVLdkpHNzQ2Z2laYnR3?=
 =?utf-8?Q?EbqdlfeV20HtaxdE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 294e1733-19ed-4016-3667-08de6f74809b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 05:05:29.9005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ow5+CKdfGT5YuWF5QI+GR878LAngGUE8DqruA8QB7lBU8faFB9xdeeSz9F1buSxAnxTDyClIgR1K+42qFnj/lgTVKVmaoHtGNHRSSKW9n4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA7PR11MB9543
X-OriginatorOrg: intel.com

Jason Gunthorpe wrote:
> On Wed, Feb 18, 2026 at 03:40:10PM -0800, dan.j.williams@intel.com wrote:
> 
> > So one proposal to get the x509 pre-work upstream is to extend the TSM
> > core (drivers/pci/tsm.c) to export the certificates in sysfs, and update
> > the existing "authenticated" attribute to reflect the result of cert
> > chain validation.
> 
> Why do we want the validate the cert chain in the kernel? That sounds
> like something the verifier should do?

This is more for the CMA case where Lukas was imagining automatic
revalidation of device certificates coming out of resume before
userspace is present. If someone wanted to use a TSM for device-auth +
link encryption outside of TDISP and Confidential VMs, then it could use
the same mechanism.

However, error handling / automatic reset recovery is out of scope for
the first phase of the TDISP enabling. Also all the early TDISP use
cases seem focused on datacenter where there is no need for the VMM to
authenticate the device. I am ok to defer the "authenticate while
userspace is unavailable" scheme to keep this simple.

> And not sure we should be dumping any certs in sysfs if the plan for
> the other stuff is netlink, it should be consistent I think.

Lukas was only putting the dynamic / transactional pieces in netlink.
Specifically device signature events (multicast) and device measurement
collection with a nonce.

The static cert chain blobs can certainly also be in netlink... but no
real driving need like there was for the other flows. I am also
encouraged by Lukas's work to handle large blobs over netlink [1], but
no real need to add that as a dependency to this simple mission of "just
enough of a real user to land the crypto prep patches".

[1]: https://github.com/l1k/linux/commit/af9b939fc30b
