Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793074444;
	b=QHXM5jCFNAmiKVzSfnney4OkU9GX+RDHt1KQrFpgPAxe5NYh71BAnMq2dbqBiwRGZQjW
	 uxYbKYbyslyRQZ4KjVPlReXBzDwRbE4C4tzEzx+hETNfZ8UdAJKzk57TTv3k3JdUibA7X
	 mOAIwZlGsGeLhOhD4HFwi+PE7v7/W3k9EDpcYrxU8ADvRKHzFjV1upc2YL6FGVmNfkkJt
	 P+cLtd6En2DmA5ri9fvlVFiAw4NEuH3DUyAKD58wHVJLOhAUF2CCn6ay5fI3YmXtk+Zic
	 hs2gWRFrlTm0l3aPqAYIexSDVg9vVPzWip2Z5/Ef3GPnDkG5XZE8SqGjoJA8fHaCnvQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793074444;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=wndcsVM8zEbKKULdYYupw38QWAIhp5Ok7MO+rKwHZAU=;
	b=3n2JRspMs3nxAuypC+v1ar1c6PLUbGEGJQm/mTLUQHMf/fPmKW8HiqX8gVcM0uQsnIZE
	 pHxDHE1hX0KjF1San0o156PQUzhWljlmUMEGu968Izm/ivv9qwh5ktP99NKtglLkAG5FL
	 sw7zoWMkh2Kmppnii9ANQUBuvDnhu5VCu6HLHjKwOV7IYhGCtTUr7MO/c2HuyiY6PiH11
	 4ogfQjVnMzq6CaC7u9NWRvJGCC+GFpDi2+6arjT8lwXyUt8kBoKh/5aZ+VEONWWhxejZ9
	 +QHqBVL4bw4s+eFEhNL8cMX1GBOnizSZU23ZqWbGIvmbxnMTxXVr1K9Oi2dQpYr6QjQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IN+YLpma;
	arc=fail smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD755606A31A;
	Tue, 27 Oct 2026 04:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD755606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IN+YLpma
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793074443; x=1824610443;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AsZ3j7S/MLh+29o1eDCPSWSH4APcTB4Q/0ANzs/lP10=;
  b=IN+YLpmaIOupsOGO1pOfwW4Wtf0m01IznLtDHqyIwkg1XzkJmJNul+y4
   lvM3VhkjV8ydd6QRObBBa3Un1GS0rlw7Cb5ew3yUotyX/VUOKYaCThKIr
   40ysSVUWdF8Iw8OadU+z7tRq0Fo9Ich9/cF+yH7EDifYsJ5Z0Lp6xuHcQ
   cQmIM2oSJzqNfMipTXW1LBTulTfJnFkBKwqQAgrC8xY9yS+CPGDBNxUtz
   96hC5DZxKBGo6owXAyW7SqwHUQvkZRsA4TKdIPPb6YQHrhi3Oxt0aK1Lz
   2tBuxvhPzYXrarjPHsUJ6lat4XS/3JNBmM52x50hf/yDFMLgwb7KTpjt0
   w==;
X-CSE-ConnectionGUID: XncxC2wQTqi/kjLJZksdDA==
X-CSE-MsgGUID: yRHzPu+HTv+cqarUXQZcog==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1774379"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1774379"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 21:14:01 -0700
X-CSE-ConnectionGUID: CpG5au8NSvGgpu665yVoJg==
X-CSE-MsgGUID: XYhbBA03RriSBwqOo46CBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="6316803"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 21:14:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 21:13:45 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 26 Oct 2026 21:13:45 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.0) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 21:13:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PFFXjvJeBUGI/ZKYfQ5+qHMFQaiRr8yHqVyFcc1wVRwcZ7KIgZSG1ytrqryzXOby3ySVdkBp5yEpEUzDoG5xsUMRrxAiKjdrEEjE+3s1aB0DPHLBGE5Qy77icH8ixKe0fsasl14LyuUKQtTHgTCQAqIycRNzucRqD2FfTGWHLUQC8vrQ2FuiWN2b/4Lbo5fVv73V7PJYTP8Nu9H1rL/RW7EQVIIHrjBcRKjimZPgdcs3NaxUC113/GgqppO80lrhmhm5I0LvE0iyBwhkL2HQKXC0C3rHSQqAjDcPhQQvZI0scuav4ikm0oE2V5alx0hL0Nik19UEGa8IAPpjb2YkbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wndcsVM8zEbKKULdYYupw38QWAIhp5Ok7MO+rKwHZAU=;
 b=oazcFJeiB46f1ngroGHIYvF73kk7F0fJXVwRULDEfBYEgAlPXmf9W/MB/WuCF+MKHKPvgzYg74HW+QoCyPZN46mhOyWJsb4gcyROURv7xIFksI1QtLSDOvtHWlGqJdXjoF+dseCFpSE8KLcfUvXb1oFzReUviJGoKoPiEPD5oXOqM8PtjCen4CKFSSZqCh9vlIgDNp3KZRtgiNnJvgRgZXps0fu9//H2BSk07iJni9OXzOEzBr5FirvBQh8HOd8CSBZAxSBBKrYpL+e0gZrvmMTF35Vq/ULjrpvhZzKx5KRHusmEWdgLn6JDJHsuzXJFv5RQd/1t7jbX7H+lm4Lggg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CH0PR11MB5217.namprd11.prod.outlook.com (2603:10b6:610:e0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 04:13:40 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 04:13:40 +0000
Date: Mon, 26 Oct 2026 21:13:29 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jic23@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Alex Williamson <alex.williamson@redhat.com>,
	<vsethi@nvidia.com>, <alwilliamson@nvidia.com>, Sai Yashwanth Reddy Kancherla
	<skancherla@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, Manish Honap
	<mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, Richard Cheng
	<icheng@nvidia.com>, <linux-tegra@vger.kernel.org>, Jonathan Cameron
	<jonathan.cameron@oss.qualcomm.com>, Li Ming <ming.li@zohomail.com>
Subject: Re: [PATCH v15 01/16] cxl: Drop stale decoder interleave limit
 comment
Message-ID: <auAk6a2P52eDUN5V@aschofie-mobl2.lan>
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
 <20261011021422.3428136-2-smadhavan@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261011021422.3428136-2-smadhavan@nvidia.com>
X-ClientProxiedBy: MW4PR03CA0302.namprd03.prod.outlook.com
 (2603:10b6:303:dd::7) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
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
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CH0PR11MB5217:EE_
X-MS-Office365-Filtering-Correlation-Id: 94446d14-5790-4a44-90b4-08df33e0aea3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|22082099003|18002099003|261026121527099003|56012099006|11063799006|4143699003|261021121427099003|10067099003|261021123027099003|261022105027099003|261009223027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: s2a5EraYqnN39QNwKCjBo1vMwtmuiJCWGSoU12q8QPMSoOPVfawjzahB9pLw5dUvoBEt/R1ADED40z1lDI1v/OzGpuOF5hO0Up1VpA4rzs2PElhSq6MZ56y+HB5k+JErtqlzkQXhjZOu8zk1p/0a4xPso6BxD3PV2JFMGdwE/ZBlbK4yvcf0Y7ZUJoVcAxTsmQnNpVmOTrrjnJQNNyaWt+HRuE+t0DE4wiRZ6s4U60RFKn5dgpRu2M48pUOvft6GEoJDLEvmP1x5z0GsccvnKiOPTqp9NkUh7Byp/5IWzkSBaHIpqnnltqhpl/552ntnj1ZjPReK8KALuUVwsKpeqEXeuA1f6gQINfJ/T7iou8q8awNvS4jTXNSzsSiyZeebidIqYnIecxni4b+stHe57UqQ8DbMeaZ698/OvMIiUhJCKa8RiYP4SOfQ0lzScKyfEGu9JPN3WuUnFBvSOFwv0BSVA0PGNcX43q33TXxbT+7WI9O7Cl8XSfPaSAnaimI9xAgFf1dMdnfPcWoHH8/pa3mNMzXQ07T02Bm0EnXZmwhKHHFwZj2CWaRFyf5UFedC3Iu8U8czCO3hHSDT2i4UQb0DHqqNBBurU2e1xHJb9rJuI9pkRMASmYuhXTWArmxa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(261026121527099003)(56012099006)(11063799006)(4143699003)(261021121427099003)(10067099003)(261021123027099003)(261022105027099003)(261009223027099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G4eqEfl87te64P6a3sMECPj22J7PZ89MwbVLL7+fscX6rhkIT3RRDpOx5jTd?=
 =?us-ascii?Q?G/NpjgnVKflC/9FHwq12mTcSymhrSsJpIe3bLI6pwpAyxpQVOF35o25VNQOn?=
 =?us-ascii?Q?/hpnlpRePiWk4mXoL9W7/zT0tKBYjVNu3+SOkN7sDGG1rf9xanVzWY4GGwmm?=
 =?us-ascii?Q?c/NEKHdqnOszNtpHU7UiOp4KQAFCnZbfgNa/gNT33s3LT6U0NtAojLNC7276?=
 =?us-ascii?Q?ZSBE4727R+65OZhEnW6xDtsRWVP6O9/xBHCNNRRIGSg5UDUnL2V3bQ9qditY?=
 =?us-ascii?Q?BH6thG4FFDgkNGwsxHrePZODGIf9wvGwunoUbe1XfMq8WeFEsSqH25SYMcRq?=
 =?us-ascii?Q?1Nl15H/wUPNcMsi7Ok24LZxQlifNV3iX7ETndpt7j4sVcnOGEK+Xhxm59061?=
 =?us-ascii?Q?bSFz2TgV4fM88PUJ0FjLd7Ivw4CfiQTpnWWaZLUfqDVDoXbtFVDrK+yHGQxm?=
 =?us-ascii?Q?Jx16bdIaYB4JP5cnuZt55EwlYvWB1Dygt4dYFJKxrpmPLedDqH/Md8JWGWcV?=
 =?us-ascii?Q?mZIgbyvZc53eIQJHSApkn1E3BaXHq30IWKgqq4L5sc8VgIRx/5KwBD9Lwmfn?=
 =?us-ascii?Q?z5iTwuIpIR2Ikc6hV0wHYYg53vl4ehoP2fGRtP9BzNvjhk7sxDFKcqouIwdR?=
 =?us-ascii?Q?/2f9/t44UG3f3JdxEGUW+jxolsN6dVDqiwPEWhf1EE0ffE66EbvYYcEsnxWL?=
 =?us-ascii?Q?h3pvCOSbIUqbhtdhF8L2MMVIlWfxXw0HkHkgOmOGZmdlBN5paLzpy6vkhQO8?=
 =?us-ascii?Q?c5kvFIxSoaWaP409qpoXl9ImSTYMncdnM1jGPXucvKVRNsffi+iWVT4ygqe5?=
 =?us-ascii?Q?sJWo24YUm60GE9pZ3wrhoZxxWKIaQ7Lb0ZGJIUlEFHF08IF3IuT3sDGRQpi0?=
 =?us-ascii?Q?ZxntvlMX5LRnE93URFRagVhAA+A4LqXj+wrdymxNrYHKcE4YIq/Waod4BQNw?=
 =?us-ascii?Q?I2HFLyibCYTtyqhw3EFH5BzwvNOLrmnOmzPt6ihI2DHlV+tvH1SaJsp/BgnQ?=
 =?us-ascii?Q?tpKQgyDY4rkbp64V4KKubFhFeFyb1ChJnnqffEl7ww6Khwfwy39eK0FY4Yog?=
 =?us-ascii?Q?8nJaiZwACPpOWXmJQh+b0/UH55q8hchtBvhzpYjmZeuFR94LgU69Z5+lf+kn?=
 =?us-ascii?Q?O2GAzHOYwRsU7MdR3XVrxxaQ1peuDqw3THEiXR0WJ0RgPkpQ0+9PM/6oP5wQ?=
 =?us-ascii?Q?Al9XOGaqzTU0ByCz94Twl+2oH4tDlVckxxfBwjbWmVgJr7FUWRokFwotcAb3?=
 =?us-ascii?Q?XOK1PETIh4AF13pavkB7zR3/qXxe37fOcb493nIy0h8EEKfd8Z/fXBe2H+yf?=
 =?us-ascii?Q?Q4IKZfHwzoL5s+DHw9h269GKNNGdXB05/uDYcnB6k2HM4gbaOnJOHp9zRbdt?=
 =?us-ascii?Q?RzSDxjXln5PhjeycjhsKZrSn0P4nBaobUbdkqXEc4CARAy+M1IxQDcT14Zvw?=
 =?us-ascii?Q?q716a91gIpw/XvIhwOdJkUrsGOCB8S+k4CYWZx94YtHd4FkjS3GM2IRT8A18?=
 =?us-ascii?Q?o/Gxw6oKIFy6xdTokuPCVEV3pWBVOkWeLj2En+6EN3g8RKcJidg0Y+mUUo1j?=
 =?us-ascii?Q?CjoZpzKfo/rPCVeM3DozwMgQoD62ZeiTnT8nubDhyfKR38MHohrBBbX9MDtq?=
 =?us-ascii?Q?v4L+Edmt2ZqQ4uEODzJxvPQ2nFhSDHOH1+/47bX4N8l4aoTLfJAMYbatFgzj?=
 =?us-ascii?Q?Mf3XmU8yY2xjJzOx8qkX/vYLFfGLgKbS1T1wJf+Oog3DsYO/Y7u26IpzhyFH?=
 =?us-ascii?Q?wieYwtC6uHzgRMyaPYXGyegEm8IKoOA=3D?=
X-Exchange-RoutingPolicyChecked: mFwiQ7RVa1GbbVbFn7q8KW0LgBmu6Cwwgc0Myjqzk9zT+qEHO8goxVo3o+v9+bZ6mpCGewCOYE6v9HtNeLYNOA59P+b4Wgei90Qs7MGgfGM1T3JZm6TIa6mxaif/Qd/NS6DgX4FOBDw6goVFhwkTRSMFCSQg0z4D79rZ5KY/NSXNl5ZJLy3HH7SIoeDikVbQcVSAhli+1O3JFFCSEw2jdN0/RNDWsMqJdTyE1yD2j+1+m+Rzl4Sre/cvuCSq0qwSZTssfaaYsujGPoxfxAqrfxCeMGtrJBBxksqzxeJE86HR5xmdNcVMIWr7anZrGXzz6QxVD4m6AB9TPA3Gw/+BdQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 94446d14-5790-4a44-90b4-08df33e0aea3
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 04:13:40.7085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /3gOn2ykOt9MCLd2Qo/71ExXnyRR8whdt6XPsf2ykTGFQPBJ6Zk/N+VvF6uV6ChCxXz8/2Ty+2pItTe0+9sgnTyKvkxZwQ8FFEhPRejBSxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5217
X-OriginatorOrg: intel.com

On Sun, Oct 11, 2026 at 02:14:07AM +0000, Srirangan Madhavan wrote:
> CXL 2.0 added 16-way memory interleaving, making the comment that the
> specification supports only 8-way interleaving stale. Remove the comment
> without changing CXL_DECODER_MAX_INTERLEAVE.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Link: https://lore.kernel.org/linux-cxl/20260912003057.3db9335c@jic23-hlaptop/
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Richard Cheng <icheng@nvidia.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> ---
>  drivers/cxl/cxl.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 3ef0810ab86b..9e0500d56866 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -269,10 +269,6 @@ enum cxl_decoder_type {
>  	CXL_DECODER_HOSTONLYMEM = 3,
>  };
>  
> -/*
> - * Current specification goes up to 8, double that seems a reasonable
> - * software max for the foreseeable future
> - */
>  #define CXL_DECODER_MAX_INTERLEAVE 16

How about telling folks where that 16 comes from?
(lest someone think its a software defined limitation)

/* 16 is the largest interleave a decoder can express (CXL 4.0 8.2.4.20.7) */


-- Alison


>  
>  #define CXL_QOS_CLASS_INVALID -1
> -- 
> 2.43.0
> 
