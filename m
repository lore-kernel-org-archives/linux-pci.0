Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA811F4CB3;
	Thu, 19 Feb 2026 18:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771526562; cv=fail; b=l5FzIXNf+ve1uAtAJPakL65i8D6Y7v6W0NstuqKs78hyChH/FXKI+XqI+TuPaj4WP6GresIaU0I62K5U9TWlhZSzeNwAIPzBc/PTpsIvUNyOa0xPwO3TFXNFmRGw5DiTPt07bcQwYod7rXhTqNsOFHz9QcGTn1+7FSChZ/rkvAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771526562; c=relaxed/simple;
	bh=NFcU+hjWvTtt/JUlGe/xEyL+i0vLy8uhHSSKI8H5TkY=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=h2ygu1noYz8rwy3kpCQ5BfZSNHSIJaqGVum6W073yh3K5+5nkKVAw5gZMjMAHd2vX1RaSouy87LW4Igi9ceHF8OLzvgaaHZXOGtTnyMY1IGArHX6268B4QFtYOj1sSokVXzPZM6CSu5ywsXa0lcr2Txcm0W/SM73b9l4GVwvYg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T+bkNbZ3; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T+bkNbZ3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771526561; x=1803062561;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=NFcU+hjWvTtt/JUlGe/xEyL+i0vLy8uhHSSKI8H5TkY=;
  b=T+bkNbZ3iiwY4saULFhlKYuaDsiFFdLkUdMfLgm3fvUS4ISW252fO3lp
   Wt9UyeM6mzla7e4byQGH/rw+ZI8zjlom0rV1zeQEbEtnGOohu2fa9RlD9
   eq/Vs8ETFffR3ZVJ6yaJD3eLqj8nsjOWn0pB4pGdzt3Co2YxxBe173F98
   QqlrnU+Inp11CRGBDW2tOuGD71RAdg0toMi+nWLyzERHz7PN4Ih32Z9o/
   +iQJgQceY0tRCgxqKiumVgOpnYjyDJOu7zz2EPo0IbggEghdsudYfCSjR
   hOrkTVcQueF/fXSJS7ixFWfcNNc8J5F6RIWgv4jrP+3TBCMw04wA7Fe8U
   w==;
X-CSE-ConnectionGUID: nHgrJVviQyCzM0wV4E5Rkg==
X-CSE-MsgGUID: DqOYx1WKQi24Dmdrce38cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="71646315"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="71646315"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 10:42:40 -0800
X-CSE-ConnectionGUID: /1UxOccUToymMPzmVS2Jwg==
X-CSE-MsgGUID: 4aA9WNAaQ1WfXYpAXeShBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="252296386"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 10:42:40 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 19 Feb 2026 10:42:39 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 19 Feb 2026 10:42:39 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.57) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 19 Feb 2026 10:42:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ow/iobvkTBetXv3yHoLrNn23sesL+c/RP84IsFmlsFKeTgkHr3mZM/nVnxi1gIcGwwV3kqbBYXOPFvtAFJ/IDLMY/2lgL2afHQRjusOZEZJ88u6tnF55hlamAH2Vsyqp6MpLIMrrrVBGyGFe8cJtRxGm/luO2nEIhlszjdxrPwxIPQFxI5FnUN5RU83yFHoKDPC65BSOYBw1tNDjv0AOOgtpl6njj+oqiC+3th3rOp1LkgwMNCOJz+eM5aQvEReLipXjSsqGg2mw8L/ZgdtYmESUslW20t4siHC187z6i0w3AZkS8bV6jEUwgHuO9Yds1GriQFNWWEp97k4LjmudPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=auVbDHi9euLkc7aVlUwKyx1IIWKbbS3rRGZeBjarTCs=;
 b=Sizwb4Im5C1B1ZrPioBy0GUR3AmjHgaaproIoJbVMWTfWoIHSn+ifqAYSep2M5VIjAkx+0bZNIMZh1+7Qx+h1mBvYmFDeXJsYXEjtRVnAU42xYhELmj5tAGnKndPr2sJY2DKzD8vWF8lA+iNUKU/nBUzuZ4xOadOLKHMhDYszhY4j2epHLEKQjTyf0bXrB0J9AZJvbItYBGyEsZhg1zv/joVMbrU9a9uF6bKfVguskHIYYpTYVJOFWeEu59iP26i6qPtGv7WFQsAyrNgPbYvt1+UhfqMNeBzyz1Jc41T51SrJHBk9Huc5Y6Q235BvQ37U8PAv9mbnsW/wYkrD6ugaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB5822.namprd11.prod.outlook.com (2603:10b6:303:185::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 18:42:36 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%5]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 18:42:36 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 19 Feb 2026 10:42:34 -0800
To: Lukas Wunner <lukas@wunner.de>, <dan.j.williams@intel.com>
CC: Alistair Francis <alistair23@gmail.com>, Jason Gunthorpe <jgg@nvidia.com>,
	<bhelgaas@google.com>, <rust-for-linux@vger.kernel.org>,
	<akpm@linux-foundation.org>, <linux-pci@vger.kernel.org>,
	<Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <alex.gaynor@gmail.com>,
	<benno.lossin@proton.me>, <boqun.feng@gmail.com>, <a.hindborg@kernel.org>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <tmgross@umich.edu>,
	<ojeda@kernel.org>, <wilfred.mallawa@wdc.com>, <aliceryhl@google.com>,
	Alistair Francis <alistair.francis@wdc.com>, <aneesh.kumar@kernel.org>,
	<yilun.xu@linux.intel.com>, <aik@amd.com>
Message-ID: <6997599a471ce_2f4a1004@dwillia2-mobl4.notmuch>
In-Reply-To: <aZbUS31_lsLr72Uq@wunner.de>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
 <20260217235604.GA1595019@nvidia.com>
 <CAKmqyKNeyEN-h9tAnfM9j0GWiFU9idXheGQ1COCqT9MVZgsZYw@mail.gmail.com>
 <69964ddaa5471_1cc5100c3@dwillia2-mobl4.notmuch>
 <aZbUS31_lsLr72Uq@wunner.de>
Subject: Re: [RFC v3 00/27] lib: Rust implementation of SPDM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB5822:EE_
X-MS-Office365-Filtering-Correlation-Id: d9dae410-55ba-40ff-5af8-08de6fe6a666
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eWxzNGNqSFNkR0h6R1VML1ArbHJlRFZuaWR2elhSS3JyNE1PVzBubC84Ukxa?=
 =?utf-8?B?amZndGlhNGdXVXdML25hWHdNaUQvekdxVTIwMkFibk9vMVd5RWFnK1hPT1Ns?=
 =?utf-8?B?bUREaXZDbkFnYXNoN0JvVUtUT1FEZkRNRzg5Y0dGNnhBRGdWYS9Mb3drQ01R?=
 =?utf-8?B?L2dMajhEZHRGSFNWaFZ2Q1lGMStIQit2RnJ5UUpzekFKWU9HNktJcWFUSGlQ?=
 =?utf-8?B?S3graldFOXhETTJPOFljUS9NOThTNUVKRy9XS2Q5S1lnTGdNNHMvM1RETW1K?=
 =?utf-8?B?L2paeG9NQWN4b0Z4MEVwMkFnejlqUkNMOXU2WTk0QXJQYlMxZ3JhbDE4QkJH?=
 =?utf-8?B?TDN4SklRL0xoaTNKQ054anMra3NuUFhvYTdVQ3JnUkhENERadVZ4Nk9YS2tF?=
 =?utf-8?B?N2I0YlJPMGk4bExGdXpxN1BXeXBmRGYwWWl0RmRNaGRSVW5WZmRjK0hGcWI0?=
 =?utf-8?B?OWtjTTdXcTVEYkJmMjdDRHJxQ1BQd0VUcmJrZzlKSzJvL3JxazMxNmdtNlJ5?=
 =?utf-8?B?d0VrWUU5V04ySk00THVYZXlKNmtDcTFEdU1rcnRqcDc0aHNjT2hFWnNzM3Zh?=
 =?utf-8?B?cXpzZlljZE9JTkk0ZFlaZjN0bXZGRXQ0NXR5OGNBbVYwYy81RkJaeGsyN3ZB?=
 =?utf-8?B?K0Q2VHRoV3JCcGkva3BtREVEa0pNYUFwSEsyRTdKdTVrUE5tV00xZ055Ynd6?=
 =?utf-8?B?bzdNenBsQWMwTmxiNC9ub25WVC9nVXV3QkpmVnhQaEs0VHp0Yk1pSkZjVmVm?=
 =?utf-8?B?SFgzU1RYY09yc1U5SDltVFpDaCt0aTNKVjhmeDVJVmprRlJhbktGN3NISlN1?=
 =?utf-8?B?a2ZuYkFaUHVRSUJOSzFPdFJ0RFFkM1g2ekVpVUV2ei9XMEVCRDR5SVh4d09a?=
 =?utf-8?B?Qlhlci9zQlJuL29vQkNqWFdvM0hTVXcyNlp6RzM3dGpKTVh4Ums2QVUyQzlx?=
 =?utf-8?B?UDkzdnMwakU5dzIvRmVBL1FUV0EvbDc5ZUxPaUdzWGxYYUJaRmt1K3ZVZGdi?=
 =?utf-8?B?V2lQV1VieXhDZ1lTTnR1ZDJ4cWZtOGJlQzA2N2ZYSHk1MkViY1dUaWs1dGYw?=
 =?utf-8?B?YWsvQjNkaFVTWVBteWJxMkNlTVJraENPdGczc3Q1VUFLY2NjYXFjVHdBSUtX?=
 =?utf-8?B?UndTQll3OUhuYm5sMXpsdmd1cXhyZGdVZ2w0Ny93MTJuVk94dzJ5UUp1MEdm?=
 =?utf-8?B?KzdJbmxGNmYxa3JPK2x6ZTM2ZHlTZTI0LzE4ejEvSDd4L2dVOW9jbWlZd1pJ?=
 =?utf-8?B?dURLUUdwQ3ZFSXk5elFBS05sN1RlZzd5dHVPclk3WEFGaTNuUjBaMkJUOVky?=
 =?utf-8?B?S0lEYWpwak8zQlpGaWN5TU1zZkxpQ0FEUVFlZVNhY2ZJTmJiVmN3WnpIWkJo?=
 =?utf-8?B?SVJ6RmpUTWJGL0l2Q3dMM1EyWkF0MWtLREU4SHFnekpJMnlEWkU3cUQzcTBB?=
 =?utf-8?B?MjdNUkIwMkNYTFlTTkdjNkNkQTdiT3doWmpyS2FyQ1BIdkRBbitGdEFKYmFa?=
 =?utf-8?B?U1Nlbk0rNzUzR240NG5VTGp2T1dLakhJRzA2d3VZMTEzNWdwNS9RazBwSFZD?=
 =?utf-8?B?ajNIdS9VUkVacnVVT0RyZS9kY0Z2aVhudERXUmFLbjVpKzMwb1FsRmNvdXha?=
 =?utf-8?B?Nk5qVDZVc3RIZG1zbnBwK3ljVStPNjhPU1Z3UnFPOGd0VWJFckxQNlE1QzdC?=
 =?utf-8?B?K2dLRmtlei9vZEpyMitFTzdKeVZqT2UvekplOExEaXRWckdvZmVyUW9UWUNh?=
 =?utf-8?B?Yzd4M1lUckFBVDRXUDZaL3dLV0l5U2p5cDY0Y0RXcEt3OUFac0RMRmtLMHll?=
 =?utf-8?B?SDBDVWpLUldjakU1aU5mc3ZHTEsxYmFKZ2UrajFRK1B0bWdXZStINis0UXVX?=
 =?utf-8?B?WFdFZ1k2dm40NkQyV2pGVmlsS0hocExseVk3RHVLOEVocWVZV2dtZDB0ajhC?=
 =?utf-8?B?U0l2QStBd1VDN0dZL1dKQTZ2T0VIWDlaRmdLL2ZTRkk3d0FEL2lHTVhJMlVB?=
 =?utf-8?B?OUxXZm5sNHB0c1V1OWI3WVlKbERVNTBQalZPN2s0Rks0QllsaytLeE1kb0dx?=
 =?utf-8?B?U2k4RlZiUGx1L1RCNjh6Sk9qN0dRakJyY1lDVHZXSDFONHFqM3RvcDVuYjV3?=
 =?utf-8?Q?8EKm5guHB7I853UKoLjoslk85?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUFHbTg5b1NPRjdKdjlqQStJbTN6M0IybUw5YktEU2JUbXVXNXhsc3E2QW5o?=
 =?utf-8?B?TWR2Z2ZTQXFpM3dIdXQva1VvZFJkUWVCZ0hPL0Z5OUI0eWhFRnh2eWViY0ZI?=
 =?utf-8?B?UjNxMDRlbnpicFhCNnk1Tit3engvVm9McDhTMVphcXFmL2wwRjV5Mjc3Uzc0?=
 =?utf-8?B?U1hIZzZEODVuZEgvUTJzcExsS2lEN2tRNVNnYzRHMysxMFNvWFNZKzNOelNH?=
 =?utf-8?B?dldlMHZwSERwbldUL0RHR3c4V1JwWWxkRDB0RHU2U3BJQ1A4VzJadm1VS2wr?=
 =?utf-8?B?dUZCSnJmS0U0M2oxNSs0aS9Id1NONEZrQVpmdWxoYTlnUTkzMnRMSElEcXRz?=
 =?utf-8?B?TTNGOFFvdGtSSWd0cmRlbXNhK3NWciswNFlyZU92UUNqUWJPUWdLdmVZa01t?=
 =?utf-8?B?Mm12cnAyMStjc3V4TzlnK3pqNXN5dHIvYVMxQUJZOXdhMXpDQ0xyYUxOcjNP?=
 =?utf-8?B?Mk9vanJyeUd4Z3JwbmV5YnJsVzRGR3B4aWF2V1lrZ2FaYkFoMXJlenN2SU05?=
 =?utf-8?B?MzJXbksvWGZZYjdBYTExV2JXRmpRZXpWNkViSWY1NWtjWkd1dUhKNUhUaU1Z?=
 =?utf-8?B?ekE1UUdOeWkzbUZSbTNwc3hPQnNwSkFOQnJRQy9ZSlY5VEtWS1pwTHg3RC84?=
 =?utf-8?B?OVR6ekZYUEZKeGhRaDNNRTNDcjlXNnBDa21VQXE2SWwyWStTVzJnYm16R254?=
 =?utf-8?B?T0lLUGtJWFVtWDF6bndsbDlYbmtkYzM5alpwY2dWU1MzRHdIL0Rlb1pZRFFX?=
 =?utf-8?B?cjI0c3grR1hCTE1rRE1JL0dLNFNqQ0lTVk04WGpzY3N2SXJGT0tSRlI1WFBi?=
 =?utf-8?B?aFRhTXd4d21HUnVRMlhlWmV3RmovcGFBVEt1MHFSdTJEUTJtOXIrYU9jVTVx?=
 =?utf-8?B?dk5qK2tYdEprejNVNTBYVW5FNVNTU0x3RzgyWUJMRzg2bUdlMmtadGh0cmc2?=
 =?utf-8?B?Qzh6d3ZoSFlDSGx3cXhFQ3FDZlgwOGR5ZGl3MnZLN2lBY3JudDRTd1VZYkZY?=
 =?utf-8?B?UmJrNUFZTlFJVjRvQjE3b3RHK3RzbVBrQzY3MXZRZk0vRGJwaXlQaEc2M1dr?=
 =?utf-8?B?MnJEL1dXaC9iMTRZYis4RzFPdjFjZzk1SnZHdVlENXgrMlE5LytOTzAwTGlD?=
 =?utf-8?B?eWhVazNLd1FkR0VIVG5EOEtLVFA4ak1TaWRMN0lMYlFmS1ZES2lHazMxNXlB?=
 =?utf-8?B?WmtsSDVNVEl4bXFwN0pDTmdRb2VMWVQxL28yZ2dKUXhUa0RWd001RThNQTRB?=
 =?utf-8?B?SXJJZVZLdXR4SEtHZ3RUcDhmV3lZY2tvZTJTclVYM1ZINXpyUnlZM3Y4b1hM?=
 =?utf-8?B?ZmdpUEdRWkJXUWIzRUtxWlh6blQwSzBoV0lWUkJ4T0F5TG92RUQ1eURpNGFa?=
 =?utf-8?B?K1Y4V0JwMCtUUFVtL2l1RTRTWkRmM0Nlc29ZeGluTDhROVlaUG1rakR2dUkx?=
 =?utf-8?B?V2ZJVi9sSEo3clNzQUJyUTR1b3pCMS8wZjUzRWFiby9jU0s1UW0xVnpZNWkx?=
 =?utf-8?B?ejFHd3NHdFgxK3hxYTdpZmxra0pJdGc1RlpYQURFaXRXOUVzVXZwVm1hK1hH?=
 =?utf-8?B?R1FJSE1HdnB4K3NBME5peFcwR1l5WXAzOXRrdjJ5SDdSZ2JrUitPSHhTZ0R2?=
 =?utf-8?B?cFlIVThQTnU4UUNzRmVCdVVQdDRCUlVwZyt6N1B2SE9IQlJMRmphRkl4MmNB?=
 =?utf-8?B?eklwc29kQmJmTERORzhXZVR0WVlCRkRVaFJPNUYrbTRKaDlDVHV1Mk1nVER4?=
 =?utf-8?B?dFQvbUY1VUdZdTVGL2RyZmNBOWkwZmk2U0hvNWVXM2pUcEoxTkRqdUNFZ1ZZ?=
 =?utf-8?B?OThOaWVDQlpTN2IvNWgrQnlKUWhGS2MydDZ3WXkrZ0xiWXRqbmhMakFXbnJv?=
 =?utf-8?B?UjArdGFYRzd2cWxYTFVNNm16SWl6aXlLdm1IcXBVa01xNWZvMEVFclhNVi9z?=
 =?utf-8?B?OGx0RUVFbnpoVGZvRTNxbEV4REVuc2J2YXdidStOYjVBQ1Y1T3NGbDJ5blF6?=
 =?utf-8?B?Kzc0bzFVUko3MDRUNWFXYVAvZy8rbHRUYWlSemRMcUgzWVgybXRzL1RjT1hN?=
 =?utf-8?B?Q25VT1l1NTBNcTdWY1Z0bmF1aDRtb2hiY1hvbXI1VlV6TWxxUlM5NytFNmI0?=
 =?utf-8?B?OGsxVnBpaG9yeGRvNzg4TFJ3emlwcGdFejRKM2xWd3IxVmlwMWk3WWZMbE16?=
 =?utf-8?B?bFBUK2ZtejJWUFdCb09lWXU3QjA3bDYybGd5L2JiQktoYkZJU082SmlaZUov?=
 =?utf-8?B?dmJ1SnB4Y3lMakJzOTRySWdkN2xOZlMzVFArYlllNkZycC9qUlowNGV6TERS?=
 =?utf-8?B?TitCZzZRMHVHalpOYjRDTXM4QkRSbnRlS25hSVR1NlVlUGp2M3oxQmQvNVBN?=
 =?utf-8?Q?Gt2pWNRncPqOVTU0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d9dae410-55ba-40ff-5af8-08de6fe6a666
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 18:42:35.9633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zulBtwk7Jp3QBZs0dAPUsy9GZAC0ZDIQbwPhmc/6Ge3zw+nbKA3s9r8OpQnGT7dlx5q93BH0w0N2uCFXlpJ9F+Yeh4utWvBtWbzdEjFdG/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5822
X-OriginatorOrg: intel.com

Lukas Wunner wrote:
> On Wed, Feb 18, 2026 at 03:40:10PM -0800, dan.j.williams@intel.com wrote:
> > However, I notice that Aneesh needs x509 certificate parsing for his TSM
> > driver [1], I think TDX would benefit from the same to offload needing
> > to specify the wall-clock time to the module [2] for cert verification,
> > and SEV-TIO (already upstream) is currently missing any facility for the
> > host to attest the device.
> > 
> > [1]: http://lore.kernel.org/20250728135216.48084-17-aneesh.kumar@kernel.org
> 
> There's a newer version:
> 
> https://lore.kernel.org/all/20251027095602.1154418-1-aneesh.kumar@kernel.org/

As I understand this still has a dependency on a new base ARM CCA
posting. So the nearest term solution is to just wire up the existing
certificate blobs retrieved by the upstream SEV-TIO driver.

> This would allow upstreaming at least the three X.509 patches at the
> beginning of my CMA series (and Alistair's rSPDM series) and thus
> reduce the patch count a little bit.

ARM CCA only needs to parse the certificates to confirm to the TSM which
public-key to use. I am struggling to find another near term need for
the kernel to parse the certificate.

> However I don't know how far along Aneesh's CCA work is.
> 
> Note that David Howells' introduction of ML-DSA in v7.0 moves around
> a lot of the X.509 code so the three X.509 patches for CMA will no longer
> apply cleanly:
> 
> https://lore.kernel.org/all/2977832.1770384806@warthog.procyon.org.uk/
> 
> I'll rebase my development branch after v7.0-rc1 is out and Aneesh can
> then pick up the latest version from it:
> 
> https://github.com/l1k/linux/commits/doe

Sounds good, but I want to focus on the blob dump interface for the
existing upstream SPDM requester, SEV-TIO, and then go from there.
