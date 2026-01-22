Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476EE39F8B4;
	Thu, 22 Jan 2026 21:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769117541; cv=fail; b=bCtOlksmVEcdDH7+tw/PPExqwTIUjigHEFymYGR2kxf3CGjHTaavqfOrFWZ6BVi4eC4YZlX+pLyBZ0/Ix8zIxXpM1sdGY6dgoJ61UAZBI6AdY5haJr0YH0z3sr9pYoHR92P8kLO9wTnBY4Kn1i2OS/kDG4X7n4mIvVKM8T83DXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769117541; c=relaxed/simple;
	bh=v9PMA6NBmrH+fc6ishi03hhFB8KBP9CioTx0X86NYrc=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=hzDpzVWAK5Dv8+2aiBUJgcBWS2snMXPoTtqmyH0610cpWwWfuUAJFMIICfE+sOOXa3XXhE2qef92cEqgz+5aMkEnflYwI187beU+WAql8IAGCcxYp/OjOMurk+K6DKXWPgzo7Qmgs6ibsxdoc9z+A47i3aTIHycptFQMnzqMhOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RW1+Bf30; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RW1+Bf30"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769117537; x=1800653537;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=v9PMA6NBmrH+fc6ishi03hhFB8KBP9CioTx0X86NYrc=;
  b=RW1+Bf30wbne9Z/qUcjdyVEYjsKT1QPg4ajH/jTjH2ZxfS5wnhIgO38F
   +pFfLG80WMe7VIGyk7nAOupa3lnSPg8j2yo7DpdJ0GZ4YKmyyAWOu0h1q
   jMrROEJQCobIYyycKliXyaSJhiqO9F/QCEXBgzQscjvUjO6vJXaL6jQWd
   FSV2ftP7ZgaEu7nq93fsND1QGfex1XYXOAH/qwMrXW7sR0YKm7HIPktrb
   DcV/VZgwddjXB530wy/1v2Dsw1CV4SIbb+mNAVB1hIuZZw81cdGRobGgn
   gi9fWbRdaFfBdGRAk9yvGMDyfGwqYRmy+6XTdQ5RwQYudPY1gLlBrrlkj
   Q==;
X-CSE-ConnectionGUID: fSVnHJL8Q5SDMI7Jx1vX4w==
X-CSE-MsgGUID: g/2PPb2+QVuR2U7weQGtOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="93035501"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="93035501"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 13:32:13 -0800
X-CSE-ConnectionGUID: LjKS2m5fQruTs+2qXwxVog==
X-CSE-MsgGUID: ENAdUT0nTcG29t5vvw4uLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="211700196"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 13:32:12 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 13:32:12 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 22 Jan 2026 13:32:12 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.19) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 13:32:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ajl1fgodkytqt5fNAd8YvXl47ET+BUPf7AvMihbEmj5UmyR3KHMksS7pGNZNbxUmGZYejYjDY2fkwQkufK8rAzxT8Ft+p2ZvSG0AAXbpSdp3erY8atxDrcJde0DUA1sevhld/ez7y1BIXmIb2ED9lqAiEMvikBBqIbLDouoXz/AcPUj1N3Spp5/eL3hHdyEtyXC06pQFgPYLBodqfAPMAEHc2+awKhRsTuSlbcE8yNIMDfcxwGIsWp6Xv086EBC/ctMxHnzPqsf4tK2qHT0pgJPJQkFQnPy3PR0C9qtKqxf2kPWHmLdKCGBW8iTPzSHDHjj2VE9RgVi3rXUiYLF8dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f767WTBqQukfQZ/KsvhQq19e3BZkLD9U4Z7HbukUWFM=;
 b=krctvUjS33AfogaGBhy+KS/uH1rUxgQJIJNN0z5QflET4up3Ha0XCtNQ0L/2gSiOj6/x8/1O5Z1Z4z0E3RkckLuQKytl9xDwc9IC2R7v3ks0vigJZGU81iEnZCBRlayP0em5e9dsfl/rJX+67WUVaKpkvfDmXWI/0gYABPP1Fqk5M4g85kc8UI8IgCTr+//LXoawXBCBd6U9NUFBo5zj0SoKFfDncLLkyL78NxxiMJY0CScawopqDBNUtSYGZksNnp+s5BsmwOyRUhj8UVRUNFyPYS/I00I3MZbaMckAccBSeAC7d9hH4vOPKILexs+xPcHQopgWiX7n/DN2pxlQaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB5263.namprd11.prod.outlook.com (2603:10b6:5:38a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 21:32:10 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9542.008; Thu, 22 Jan 2026
 21:32:09 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 22 Jan 2026 13:32:08 -0800
To: Lukas Wunner <lukas@wunner.de>, <dan.j.williams@intel.com>
CC: Jonathan Cameron <jonathan.cameron@huawei.com>, Terry Bowman
	<terry.bowman@amd.com>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<vishal.l.verma@intel.com>, <alucerop@amd.com>, <ira.weiny@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Message-ID: <69729758177e_1d331008@dwillia2-mobl4.notmuch>
In-Reply-To: <aXJ7VKwM6xfH-42L@wunner.de>
References: <20260114182055.46029-1-terry.bowman@amd.com>
 <20260114182055.46029-11-terry.bowman@amd.com>
 <20260114190818.00004112@huawei.com>
 <6969513c2b1a4_34d2a1008a@dwillia2-mobl4.notmuch>
 <aXInXZiTCSN06si8@wunner.de>
 <697275fcc1686_309510085@dwillia2-mobl4.notmuch>
 <aXJ7VKwM6xfH-42L@wunner.de>
Subject: Re: [PATCH v14 10/34] PCI/AER: Update is_internal_error() to be
 non-static is_aer_internal_error()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB5263:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dfd8bf1-7a32-4569-547c-08de59fdb2ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cUZvY1RvSEVxTVJaOHgxaldoMDZHZDZuc2lhR2JKUmRpcllyNWs2MzdQNWdw?=
 =?utf-8?B?dWhUQlBibEhLRjY5OGNHZVB5MndjbHRQekNVaU1VVUp5cVBRdjZIMVp6VS8w?=
 =?utf-8?B?b3FQRThJQjV1K1p6REN4Y0wyWnRyUndTclpXdE85UFR0ODdIdEJqNFpGS0pN?=
 =?utf-8?B?RWdyMkFzMDhzY1RaRHN2amppeFgvczlQUDZyM1pBOFU0QXFsSE5KNCs0dlJh?=
 =?utf-8?B?MCtjQWd1UEJISVMwOWpDUEJTVEVjOU9NSi8wVFNYa3ovUXIzY01hcUptWk93?=
 =?utf-8?B?RHVEQURxTytHbGJxSDhYakxZY0x5QnVWd2ZTODRsVFp6bWdwK2t6TTJMZStQ?=
 =?utf-8?B?VWIvWlZuUEhJazhhTlhJTHBMVFlZUmhWbE0zTEtGOTNtWmlCRjhQd052cjRm?=
 =?utf-8?B?ZXFJc25aNjRGdE9GODdRZlFlMW8yMTVBdTBiOFdYWTZ0a3NyWlJVTlBLVXht?=
 =?utf-8?B?S1BWZzFvUDJMM3pvNFhQQ3N1UWZWM0RUUXFLVjluampuZXdDQkp6eWc3Sk1l?=
 =?utf-8?B?VEwwUng2NlZRM1d6SzBJbjZZbDhXdDdoZlRjblNUaXI1OHhrYmV1dFRtUUpk?=
 =?utf-8?B?dTJxcU1XNmdsZytpdlZqd1JhYWNoaEUyeVlUN2RTN3NWQWJpRTBXNTA2Z2tM?=
 =?utf-8?B?ODZndy94bHlsbVlpN3hHM2JmNzMxWEh4dlF6N1g3SHd6dEJuTExiZWtqdTBl?=
 =?utf-8?B?UDF2Smk5M0VGazNrajRKM1pNMmNaR0FQcXZxaUtrRFA1ZHN0T3ZvMnJuQS9u?=
 =?utf-8?B?dEFVdzN4RWs2cDlsUWdtZG5HS291SVFXaGVFMFlhQmEyVXBmeTh5WitBenlu?=
 =?utf-8?B?Z3pYZUluR3ZHbVo0LzkwazRvMU9WVU8zNjV5bExXM1VRcXRjZ3dsb0g5Skhs?=
 =?utf-8?B?S0V6dTdaSmljSUdITDI0djVOY1BYMDJNSXUzcWhlcHd4OUtOS09RMnlNRE1q?=
 =?utf-8?B?SmpJdjlEWkhFTkI2RU8yVkhJSlFWY1ZZN3ZoQXlPTGVYLzZFa1BDbHhFUmJn?=
 =?utf-8?B?ME9mTWh6RnYzUXR5S3lVdEFucmoxUkgzaHQ0Rk8wTHZVVDJzS004M3RZNkRJ?=
 =?utf-8?B?MUowVG9DcWVtbDlPSmorYlNpOXd5T2hsQjlIb2ZHZEYzY1Y1L3FncVhHd21u?=
 =?utf-8?B?TDF6clpmY2x3OE92SmdDTXFENDdOdFVaVU43dndHakYwbVdONEtCb2Z3NTdO?=
 =?utf-8?B?UVRGZ2Q0VDdmUTNMSkoxUURjWWV6Yk5rS1JjQURZelFUSkdiTkRsbUNOeDdS?=
 =?utf-8?B?Nnd1MGlkUTAyeklsbkxVWGFKMjRFWFNYQWRadnd2ZGFZNXRSUGlNRWVYcmdq?=
 =?utf-8?B?ZTRTWDJmQWgwUFZQVGhrbHQwU1IxN1pVT3NsUzdlQ2MrckNOUEJLTlNWaG5m?=
 =?utf-8?B?ejVsN2VhQmJGTmpLT1g4eTEyY0JESEFGd2FXcXBOOFhYYnlDdjlXU0RoR0ls?=
 =?utf-8?B?bnJ5V20wUDJ6bmkzWmtGcFJ2SkVVc2U1am9vNTZkTGV4M29PazdwelVUbVVD?=
 =?utf-8?B?alBsQVY5amZlR0g0RUNxVDA4bjMvN1Y2OFBTSmdNTkZibGROMjJyRDBnYXAz?=
 =?utf-8?B?dmNvd0FmTmV6eTB6ZkdqNWJuZ3JUSkdXaElkRWVkNVI5MC9NaDBlVENhMUhr?=
 =?utf-8?B?ZDF4LzY0WGlnbUgrdWNWTzRxTkRtWEJXLzZLdkx3U1VLVy9zTENJNkJWY0li?=
 =?utf-8?B?T2djVE9UV1Mydy81RkxUWndLWlJsbkV2ekRWZzJDOFRJVFd4RE9zek5ONEEz?=
 =?utf-8?B?VUhGQVk3M00vTXdnWDhNdmUvQ3ZxZGEwakl2bjl3alFlbW5FUU91RFhVVVA1?=
 =?utf-8?B?aWdQTzhhZFg0bVA3UWJpRHc0VUlxdENCcDFtdDhPQlE4TlVnYjUzSWQwSkgr?=
 =?utf-8?B?Y0pMTllHOXZxSFhFTUZnalFmaGRIOFNxQjM2ZENPcEVSdVhsbXlQdTRFVWt2?=
 =?utf-8?B?b3lEQ0dITE55cGpkZEtPVi9vZnFHUUtqQ3N0d2xPNXZqNFFMWjRiYTR2REVp?=
 =?utf-8?B?QVZXSGR1ZVhyYWtjMVhHcDhlL3d3N0FQT2VxbWZuYThVU2duMTJ6SjhLRUVo?=
 =?utf-8?B?dS9uTE9lQjVIem9WM0ltWVB1OWJycUpQdlFNcERSbUFENTVTNTZOVW1ER010?=
 =?utf-8?Q?OgUc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkVmUnNhNnJuemU2WWNOa2txUFNWT2xCdEgrTld4NjYyM1J6WHN1YjlPQ3Vm?=
 =?utf-8?B?bXNuU2wrNkgxU01DSDZsRzByRlI5NG81Mklmb0kvc0JzSEdlOWtTUU1wN0lp?=
 =?utf-8?B?SEVvSFNmcVBlclROUFl5eE1rOGF2NnBXY3RIbktLVFIramdjbVlUbjJLUW1O?=
 =?utf-8?B?N1I1WHlnTXBNZXFQN3BhZCtFSDRWVGpWdlEyYUxLV085YXBuNUplSC9vMmtl?=
 =?utf-8?B?Sm1MSE5tZTZuUWF1UzlSR1FGcU5PcnIzZVpBVUhOTCt5dUovMk5nTmF6SnVK?=
 =?utf-8?B?R3Q3aXdhZWVnRCtOMW9ZT2NaR21oNUxQQ0NVQzVnRlp4QlJzMDZvUmNDbmxt?=
 =?utf-8?B?UUVBTnk2WDY3dkF1TXBTUVpITjFWa2ZTdWRINzZHVUVldVM4Rzhna2JjQkdq?=
 =?utf-8?B?R2lEclhtWHhKMk4yeDR1amNmKzJRdzA2OUlFME5rSW05OGx4eTNBNHhvUXdO?=
 =?utf-8?B?VGk1bmUyRi81MGtOZEVndjNzZS91bW5NVUtUUVBUTEZiUSszcURHN21UOWlN?=
 =?utf-8?B?czhvUmxpYnlvTndaTG1lSzlnQm9WRHlXZlFsbktQdm5tTGIzRy81TGdJSVhZ?=
 =?utf-8?B?NFBHa0EwSGpGTGY1cit2SC9TbE1DQzI3aWxJa0ZtZm1ON0dManp4c0xwcnRB?=
 =?utf-8?B?dUcrSlh5VHdQSHR6QS9jMXhvMy8vUGhqdUlBQjAvWXVNbDZaQnVMeGx0cng1?=
 =?utf-8?B?M1FZSVU0KzIyTDkwYzZQQzJldWRZekdOc3pDeU1TeFlqRmpHWUs0RGVqakVN?=
 =?utf-8?B?cEJjSDhmTXhhTHAvb1k2MmJieTlkWExtQmNDYkgxQnB0OEhBYUFINXhKc1Q2?=
 =?utf-8?B?YmxpYVcvM0E3cnYvdzd2SVFZVU0yeDdXSEJjd01iWDJMZHZVenpmNmtxT0li?=
 =?utf-8?B?NythK2RtclRndkMvQitqU2pvdnVudFhRR0crT1VFekh2N3ltQ2FKTmRCa0po?=
 =?utf-8?B?K1kza0ViZGNmQTFqSStsbHZNQWdvUUdWS0NoTlhGN2diTFhyZWFIUWF4QnRI?=
 =?utf-8?B?WjVnZkFtaXJxQzdVUlBvL3VkYi9pYnRIeExZMkh2ZmpzVGd6NVhOL0EyNE1Y?=
 =?utf-8?B?S0RZQ0E5d0dweXFnS3JBd3lBUkJvdjh1NUV2dDJ1RExlL0ZpdGhYRzI5Nzl3?=
 =?utf-8?B?dFZPaW5ZZ2pqSHNIb05lYURlL3NkRE1KakRjaldqL0NOcXNCdzd6dmJnZVcx?=
 =?utf-8?B?b0s1N0lVYXdvSE05RGlML1J1V2hmRG96NVZZN1NTZWtWOElVcFhMckszUmRa?=
 =?utf-8?B?QVRzN21CbXR1Mjk5cGdsYWFESDJrT3RHRnNMRkJsZE5qRjVIN1ErbzRCdFY2?=
 =?utf-8?B?TWd0NE9JY3NuckZQdmc5dzBSTlh6TGU1SGVZUzE0NTFibVhyUUZpTTFpQVZQ?=
 =?utf-8?B?Y2pGb3ZtWTZ3S2czY29oTTJNYnpSWFk5Vi9UMVRiM2FPSkdtMTJrVi9KU25z?=
 =?utf-8?B?eEU0R3BrRzlpanIwN2M2RGlJZ0V4Z3ZBZ01uRVpXT1dXdGNtY2RlV1FYS1li?=
 =?utf-8?B?WGFYN3dQejJEdkRQSEdQVG45VWQ0cHZ5cVdGTWVYMmJRRVhLODErRWdySTlD?=
 =?utf-8?B?cWFHUlhOUVh4NzBSNTA3Z2dLVVpmZnhjcmJscUUzcXhoK2lNck5uRjZKRjZZ?=
 =?utf-8?B?UXNGZjJCMDBFRHFRVk1SSnRjM0dJV3ZkRTdrZEZkOGNSWGhjZy9yZWxkSXd1?=
 =?utf-8?B?ODk2K3hxYkZlZFRYOTFoM3cwWEROZFJWYnZFZ2R2UFVkb2NyU2xTdjRYREJQ?=
 =?utf-8?B?YkdvZVdpVmYrUjlYanFybEtobjlmQVBURnAwMlpYb2U0VHZ0RnZ3TTJHMFI3?=
 =?utf-8?B?dzZUV2dtNHpkdHY2TnpIbitUZWNKd2ROVmRlN2FpNk4rNkd4ZlB2cnBSOGhF?=
 =?utf-8?B?OUNjS3BmNUhNT2JLVmcyZDFrQXMrTzh3dFNHSmxxbTExelNvclY4dVdaMlNj?=
 =?utf-8?B?Y09IUU5DcEYzWktERklUTzRzMC9rVlppenBlRE1hb0g5Z0p4VE9GOW4vY1pL?=
 =?utf-8?B?YzlZbENRZ0d2QThtV29lYmRHYWhpb1VQV1ZTOXFXWWRxVWZkYjgzL2dEYTJO?=
 =?utf-8?B?L2FjazhKSjZTcm1aRmtRVmlxTW9LL1J1Y0lIbEY4Rks0ZU82blk4RmxhN2ps?=
 =?utf-8?B?VUpyMStXSWVzamNvRXV5S2g3K3BJT3B1YzFvdVdtVGd3ZHY1U1BQb2dLdnlB?=
 =?utf-8?B?dUZ6OXNZc2hUNFFOU0xvRnowLy9KZWQxVFErQjdwY0FZbmpRMVB0WmhSRU9V?=
 =?utf-8?B?dHlnRlY5aXhaeE1qa015MTY2b0lhbll1aDNZQUpLeVBtdVBZdmYyUDV5NU00?=
 =?utf-8?B?OTNiQUJBYWhJK0xSY2pHVGhsbllkWlVZQmpxVGhDUDFHQi9XNE0xdE16MEhF?=
 =?utf-8?Q?dhoMYgvhuHu6y4Zk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dfd8bf1-7a32-4569-547c-08de59fdb2ff
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 21:32:09.9178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cr0xuIX/dKFCSRNQXw0sUDTjPbueS07cZfe5Wx07UujEQnqBzud1e5TS+o6prSNSs4e0DoYVDaN5MMZIM7StIpZNVgzFRscgfNqLHiSzazQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5263
X-OriginatorOrg: intel.com

Lukas Wunner wrote:
> On Thu, Jan 22, 2026 at 11:09:48AM -0800, dan.j.williams@intel.com wrote:
> > Lukas Wunner wrote:
> > > a device possessing ECC RAM may raise
> > > a Correctable Internal Error when ECC successfully recovers from flipped
> > > bits because it allows alerting the user in advance that the device might
> > > need to be replaced in the near future.  If ECC recovery fails, the device
> > > might try to use a reserved spare portion of RAM in lieu of the failing one
> > > and instruct the AER driver to recover through a bus reset.  Such errors
> > > are not covered by the spec-defined types.  Using the Internal Error type
> > > is the only possibility it seems.
> > 
> > The Internal Error type is a poor fit for that. This ECC RAM scenario is
> > simply an internal device event, not a PCIe visible error case. Consider
> > that CXL Memory Expanders are nothing if not "devices possessing ECC RAM"
> > that may encounter correctable errors in that RAM. Yes, the user has need
> > for those correctable errors to be reported, and no, PCIe AER has no reason
> > to care about conveying those reports.
> 
> I'm not aware of a better PCIe spec-defined mechanism to report such
> errors besides AER (Advanced Error *Reporting*), so I'm not sure why
> you consider it a poor fit.

PCIe spec has no role defining the internal error model of devices.
Linux has reason to not endorse a blurring of the lines of where the
PCIe error model ends and the device-specific error model begins. CXL
respects those boundaries, Xe is pushing the boundary.

> However, reporting corrected ECC errors is only half of the equation.
> As stated above, if the ECC error is not correctable, the device may
> choose to replace the faulty memory region with reserved spare memory,
> but then a reset is required to recover from the error.  Precisely what
> the AER driver provides, so again I'm not sure why it's a poor fit.

Again CXL has a model for this, those are the "post-package repair"
events handled internally to the device / driver either transparently or
user coordinated. No AER needed. In general devices have plenty of
reasons that the driver determines they need to be reset, they do not
need AER core help to reset themselves on error.

AER is there for link recovery.

> > So if CXL saw no need to architect internal ECC events into AER, why does Xe
> > think it is special in this regard?
> 
> The most charitable interpretation is that it's just the first mover
> and others will follow.  Well actually CXL is the first mover. ;)

...first mover that helps clarify the role of AER that just happens to
match the status quo that PCIe AER core ignore internal errors.

> > The CXL solution is simply a typical device interrupt that notifies
> > new entries in the device event log. See trace_cxl_dram() and
> > trace_cxl_general_media() for that event handling.
> 
> This seems to be based on CPER, which is not part of the PCIe Base Spec.
> I can only guess that xe devices are intended to be used on non-ACPI
> platforms as well, which may have led to the decision to use a
> PCIe spec-defined mechanism.

CPER is compatibility hack for operating systems that do not have native
CXL drivers. The native support is just an interrupt fronting an event
log retrieved with mailbox commands.
