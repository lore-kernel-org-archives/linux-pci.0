Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B834C97;
	Thu, 19 Feb 2026 18:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771526925; cv=fail; b=ZTbVqrocJm6WQK/8vPZ+yM7Z9hJiYuEpetIK3FgQeEWcPd6axEV5GZLeSMthjDMsPGNmpvEbwZaX3Weexz30KKbu4bhIswSGQu20rcrIfizAihSgQTo1MH9uF7WoCHZL2+E+j76ga+N95ot0G9GdlRACY4gb9d3gOjj5gILBACg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771526925; c=relaxed/simple;
	bh=uVX8Il1OeydsidHaPQIYESkBr5i3Y3mGrsfXsjtBaw0=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=nncfzYEGDDJbXUOwxiLrGRTVlqbXBNgAUieHX4BpTxnxyrA6GGp2qNXjY4yfdXMUf/bPQJFti/5SJrSVwCtjVHf1URDeAtg7XVCdUSZ0svAk5B4TVXE9xQZm33seQSZ6gm8IkHCchO4aay98NKUh5poJmvUoEMZDCae6wsGSG0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZgPENvhw; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZgPENvhw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771526924; x=1803062924;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=uVX8Il1OeydsidHaPQIYESkBr5i3Y3mGrsfXsjtBaw0=;
  b=ZgPENvhwqg9lXTs6YCdqom6Ae3yBCDnIkg6wy93WwiN0pLNaCxuaiDp6
   nUez61PXFV/z/1Q5H8zAhUhWNgoXsbyaBaFtUiIZ/qY4YToxVMsWSFwKT
   Ej7YuoOSzqNCykIRLyJBxrNs30ezZhsqwGOnA7vJZjg+tbMCIlabOkY8y
   onGfOTdp+p0RnEZ+PxJ6RREOokNGyXjvHdkpBkZU+8jd+xGOea61iglrD
   s63cmKEtF1vmb/NqfxRWJkUd8r7bu2E7CjNJvGEmUv34disBK8E3akKLm
   bQy0yMib3RC3lvhp07tl6dCBOyL9BaEY0MZNzowAUYui/nryukd2Y3hOc
   w==;
X-CSE-ConnectionGUID: ytuLjL8WTvqnXdYRBmogaA==
X-CSE-MsgGUID: NdhXmzzZT7WglGRNdWymQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="72531398"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="72531398"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 10:48:42 -0800
X-CSE-ConnectionGUID: yD9WfkhvTNK2jQUIPlYiRg==
X-CSE-MsgGUID: 7pZ5r14JSIWGfUX7+U5XEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="214738140"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 10:48:42 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 19 Feb 2026 10:48:41 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 19 Feb 2026 10:48:41 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.31) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 19 Feb 2026 10:48:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uu9HXHAvlbvG3o+ruYLGLN+oVUq7KnKbuay5lq4lXWBMrVYOKr+lLXOaEnHRTMt4hMmlRcY0VbSESv4CTidw6mLM2CXmWV2nld2Rwrgr9dQvrs9VNJo4xJb1mnjJb8YYfzjVkDxRNNDdkMtSdT2SXsDH7KLNwcAZMhyS6ju4KFJdiHH6c1p5WmdCTMs2xApw5to0CpNj+STF598QeWCgns2Wzlm7GlUW0vqKSvokpmXEtrNeKzMKqo5stQm1Z69ufQvMkiKXpzmPEjhYzmyqTraQp20gNQC0y4fXoxPvvlxs0LY+hOBOMkpE2Zu69wLXv3gJMsfPggy0E6cqiJEQ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8TO9b1qhj8j8J3ncaNasO3ez2VogYPSUm5V+rGx0BqI=;
 b=y1xBTcU0ZutZg3SWQ/TDBQcG7xCxhizhGMW2NwauDKe/tmVGth8VnWFWXY0vjF8ATycC+DeHQOFxV02VlLpkOJP4cj6LEZFWX8NnDaduAN6SXFpC08aNJq3Tsi5OPecf3haf059/Na1F+OQ0lgvmilFzZxzn+SYjn5ti/UrHKbcCh3FJNYhNeEj0oh1hB1iDyTyoqog1tfli/J5n0N81QniADCSXCoesks5Sj3X3fsjzyeKu8Tl/x1tFeVRo5MuKwLZhz+kJ2RnjCHp3G9DveC1Ypu9nhvAcvlbdBUIv8FlX2w1MGTSZr6z1MtesVizNL5nbhvKrILl42217880tuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB5177.namprd11.prod.outlook.com (2603:10b6:806:11c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 18:48:34 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%5]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 18:48:34 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 19 Feb 2026 10:48:31 -0800
To: Lukas Wunner <lukas@wunner.de>, Jason Gunthorpe <jgg@nvidia.com>
CC: <dan.j.williams@intel.com>, Alistair Francis <alistair23@gmail.com>,
	<bhelgaas@google.com>, <rust-for-linux@vger.kernel.org>,
	<akpm@linux-foundation.org>, <linux-pci@vger.kernel.org>,
	<Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <alex.gaynor@gmail.com>,
	<benno.lossin@proton.me>, <boqun.feng@gmail.com>, <a.hindborg@kernel.org>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <tmgross@umich.edu>,
	<ojeda@kernel.org>, <wilfred.mallawa@wdc.com>, <aliceryhl@google.com>,
	Alistair Francis <alistair.francis@wdc.com>, <aneesh.kumar@kernel.org>,
	<yilun.xu@linux.intel.com>, <aik@amd.com>
Message-ID: <69975aff95b6b_2f4a10059@dwillia2-mobl4.notmuch>
In-Reply-To: <aZbZP2-CadoUR2Wo@wunner.de>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
 <20260217235604.GA1595019@nvidia.com>
 <CAKmqyKNeyEN-h9tAnfM9j0GWiFU9idXheGQ1COCqT9MVZgsZYw@mail.gmail.com>
 <69964ddaa5471_1cc5100c3@dwillia2-mobl4.notmuch>
 <20260219005614.GC723117@nvidia.com>
 <aZbZP2-CadoUR2Wo@wunner.de>
Subject: Re: [RFC v3 00/27] lib: Rust implementation of SPDM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0082.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB5177:EE_
X-MS-Office365-Filtering-Correlation-Id: fc4e47da-d01d-4803-a814-08de6fe77bd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dkhDNWZJa2EwOFRodXUwYkJkUXdSZm5BTngwU0hFZXZ3MVgxVkx2L2ZSZ3cw?=
 =?utf-8?B?eDZVM1lreUxaRnB1MVBUM3pjV21TOVRYODlSVG4rcldpZlc3bndldWd2OFdS?=
 =?utf-8?B?SVd1STB0TVlwTC8rSkpCTk1rL0g4bWZvcTBlZGZNOWVFSmpzWXc2cFY1QVFj?=
 =?utf-8?B?bjFyWmlzMGtjR0EyNzE2QXI0Y3Vxd0dBaWY5TWdCbHppZG9CVXZsN3JsQjhy?=
 =?utf-8?B?aGJDTGhGbVlpSFVpTHkyTW9QNy8wRnlYWWVoWGVqa3hHOS9YSHIyeXZneGov?=
 =?utf-8?B?OXFhK29CYmY1NkZJOHZ2UXZqK3AvRmpJOVdMb2htM0VzQ3FsRkNpaElCWjdu?=
 =?utf-8?B?L0pPeWtwZTJmb1h6MXVSeWNqZmtNcDkvSEpjV3lHSzZ5VUtyQ1NGUlgxQ1g4?=
 =?utf-8?B?eEgvR2ErTVE1U1VHZXkxZ1BUUU1XYUhLUXpPaUQ5OHUvZ3FCaDhiR2Jjb2F5?=
 =?utf-8?B?UW80UTJ5QWxGa3psNzlFT0lsbWVnYkh1UWc2Tk55end3eEd2UDJIZ0UwdS9E?=
 =?utf-8?B?ZkwyWTZqR1lQVEZyVzU2WjZuWXBUQ0NjZWsxZUZ3NWdqVjVyaFRmT0ZmNFE5?=
 =?utf-8?B?Wmt0STVqY0pPTmV0TTRUUThjVXhRWE9nM3JpalZUZkRnbVJUOThhZ3VEZnRn?=
 =?utf-8?B?cklQWE5UTGMxZC9JUDBhazhlNGkyb1RhdUoyRGJmNFB6T2xnSFhrbXBoZGpG?=
 =?utf-8?B?Y24ySGFUOGxPcDg0VVJNM0F5V2NJWklIVk1nanYrL3YrWUhVQlc3SFFleEtO?=
 =?utf-8?B?U3l0YXlOSWNsQVNyR0lOdWkxckZ4ZmZDMmlLRnA1Z05iaTRocGs1UnBxV1gv?=
 =?utf-8?B?Y3RnM0FPc053ejUyOE1xQ0ZHMTYwWG5nRW5NUGJTOWN3dXQyMHpwbE9Talp1?=
 =?utf-8?B?ZzJTUlQrdWVVSEd6dGg3WlF4REJ6MTFBbVNyaGRraE54QkV2eW9lWlJjdFU1?=
 =?utf-8?B?OVJGZXVwcUdsZUpTUW9FT2dEVFRZVWxkNDJFTlVXSUhuaDROalZTM2lzVG83?=
 =?utf-8?B?b3VrdC8rc0toeW9IWHVCRXRpWXVUSGFQa3ZmRk5VemtiRXQ0OHNOd3hwY0FN?=
 =?utf-8?B?dDZaVGduaW1pamUxK1pxdTBORDIxVlNDa2V0Q0E5NTI5Ny9SejZiaWlieGpF?=
 =?utf-8?B?UFd3YVFvcjRqZkpXUk1hcGtKNzMwSXZ0T0JoUDBPRTdYN0cxSnN5VTZ6OFFO?=
 =?utf-8?B?ZUY3Z2FKcENyWVhBZFhFQnFYUjJFZldWSm1BZjc1Q3kwbE1zcHNLTzNDRFJk?=
 =?utf-8?B?ZzB6STAxL1ViZWRRTDlXaVNEWVM5ZXpRYXduM3pCeCtESjFLS3U3NFZRd0Y3?=
 =?utf-8?B?SktaSTFvazh0MkszUEpUOU5OaXdLZmlidk03ZEViMThRVzZkeUNRQjNDRVk2?=
 =?utf-8?B?UitBVzBQOFR6K2NBL0VXSGo2YkF0OHcvdXFTUlhNMDdJdWZXUHl0T0xFUzFr?=
 =?utf-8?B?MEd4Yk5nSmNsWUNScko3cWNoMlphNGVsU0ZOZHdsNDFqR0VKYWg1SXVvOXJP?=
 =?utf-8?B?Q0JaV3JxNSttZlZTZ09aUDFzWHkwOGFPcjg3OHRXTzg0UmdXb05RaEpFQlcw?=
 =?utf-8?B?OHpWUlkvMnBLa3hGVHRTVC9qUGR3SGEyV1o1OW1YUWhTbkMvWlRWR1Z0bGZq?=
 =?utf-8?B?SStBZGI1WllyaERoK3I0OHplQ2JzNlBkTjl6NlZyWCsrZmN6S1UxWVJjZFAz?=
 =?utf-8?B?MEI5S2xyS2ZWdnVjVjNrd1RueTNRekNvVjNKSk5aa3ZFeUZ6bU5uQnNlMUh5?=
 =?utf-8?B?dnlOQUNlN0hTTnJYbnpmbmw5Ykw3Rjl6Ulc4V0tKdjNyaE9pcUdWQUlCeUdE?=
 =?utf-8?B?MnhjNDJRenpNeFNxMzUwbWZ0VU5aVjVvemd4cWJucVhUV0E5V2t3SStrWldW?=
 =?utf-8?B?OTRlcUN1TmdBeXhCaHFnb0tDSHNKV3VxZ3pQd1ZudXhHenIxOGZoWlZVVDJ4?=
 =?utf-8?B?LzR3cHJ0VCsvbEZMNDZvei81K0UyckZYN2M4MVB4UGdhZ1o0TUhmcXVTa0ZD?=
 =?utf-8?B?ODdudHRFMitlcnBOVTY3NTRISVhHdy9UZVlMZDh5amxsbGx6SDdTcll5eTl3?=
 =?utf-8?B?WmFtL29QZkZMVkZMc0lmRlpvS3RVUjV5ZUt0bE9Ba3h4V000NmZ2aHRjYkxJ?=
 =?utf-8?Q?7OgY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1F2WHVRYnhWam14SEYzMGl0UHZRbmhZV1dlK25FTDluOUJUVnEzRktNRHll?=
 =?utf-8?B?MTl6aGYzVi9Denc3N0tVdnY4ekZJSmNPclFFZzQ1aTk2Vjg3anp5K0poOW4y?=
 =?utf-8?B?S3dXdzUrZUJWanU2K1BaZXFleE5YVkc1MlR1NHFVV284L2pSZThGZG4rVTRM?=
 =?utf-8?B?UlhyaTVmdndOS0dpQ29SaFdLMi92WlhRMXJxcjdsK0JSTWgwVm45MDRBRDB5?=
 =?utf-8?B?eDFzRTBHNGFjVlpiMzA1Z1pFaGlrRWZQeEszYXJ0MWV4VzNxSU9pbFJVNkRh?=
 =?utf-8?B?MU5MNEhzM2ZnUWlUQVFwQzUzeTFuNzJsWXJEUnhzblIySnZyUzZiK213cFJp?=
 =?utf-8?B?clRwdWhHeW9aWW1LdTdLOGg1a21rQTB1S1ZVblR3TTRjQ3BaUnlwVzZaSHhH?=
 =?utf-8?B?Y251dGIyZCt0QTcwWUROZzYrOEZGcDJzYm1yb0lndm9rZnNLTW5uWEpSaUV2?=
 =?utf-8?B?MEMxR2J0Zkl6dUlOa3hOOFpNN2Z1TDZSb25VcUdtMXhuY0hPWDE3WnJvYVdX?=
 =?utf-8?B?WVJYYW5FR01oN0s3aWE5VVk5SFJVZUFIdHNnVnlZcTN2eVdtTmdUc25XZ2p0?=
 =?utf-8?B?bktkL3pHK1hkUE1UZzUyKzdWSlZ1MTUwRndNU05ZQmtad2FYNkNjQjFkcmlY?=
 =?utf-8?B?K1JSOHB0MmRoa1pxajBieDdscG1HbWpxelViTnJQVDlyaDJBcitWVkREYkFU?=
 =?utf-8?B?d0t3d0FFd0lvcTlkcVdQMjVJTzFlT1cxU3k0SVkrK3MyQkZmZUR1TmlaK1RV?=
 =?utf-8?B?WG5MVy92NmFnQjBIZmxHeVU1VTVOV0I0bFh3cDZNZ29wWTRlY2RCWmNpbkVx?=
 =?utf-8?B?eDNyYkZqRDhqUVpBTmhFc3BBNHFYT096TGw1cGhqSi9MeGtsVUsrYThSb0dQ?=
 =?utf-8?B?N2xsOW54UW5RMmNXUGEvMVNTTGZhVk9ubHRVN0RKQllYK01TZDdPeU5OT1pp?=
 =?utf-8?B?R2piLzU1RkhQdjkwdEg2d2s3R2N3UFB5ajhqcCs5dnEySnJ4bXFZcjh0d0Fq?=
 =?utf-8?B?Rml6VEZ3Sy92NEJvcy9ZR3BlZGcwbko0U3hpeitBVmFjRHJxeStBSlRIYzYw?=
 =?utf-8?B?NU5tV1AvUEJJcm5zd0NpalZyall6K3NySUptbnRXMFA0VFZhMGUzMmFsOXM4?=
 =?utf-8?B?UnVpYWwyY2I2L2tNcVVLRnZZVkFtcHZlN2FjR2kxVkx6c0RDK2Fpd3hEY1Ez?=
 =?utf-8?B?WExJN1d6dkdKc3JHNWFzYVpWS2NyUUVRdW4xSmJSc3V5dGhQc1JMcS8xaTA3?=
 =?utf-8?B?dWZUcVkzYnNTamZVbU5CZ0I4OTYvRWo0VzI2OWFjalFqRGY4TE02Z0R0RTNj?=
 =?utf-8?B?OUQ5cndsejN5WXh4YmN6amR0bWVnbXJ6QmhQc2QyZWhQSll4Yno3TUlwbU1K?=
 =?utf-8?B?WkU5S1RHVm5ZNFpiTlM1S3hHcjV5WUpZaktQUVBrQnA4ZXh2Tk0wNmcxQllz?=
 =?utf-8?B?d2RxZE5ZR3NDdERkVXdqekxsT2J3SjJ0NWRzenJGQjRCbnFjamVzcTltTGpH?=
 =?utf-8?B?K3R6Q09Bb0xCelN1MkpuOTRVeXJoR1U5ZlJYWWhROTk5NkNjME1PMkJkdGd3?=
 =?utf-8?B?aDBjQmpCYzFtaVQ0Y1FBdUpOUHNTNm5XN1A1UitzQTlBbGc3K0xvU2paY0Jy?=
 =?utf-8?B?Y0dwUFNBVFhGSXlTamhqT2g3cnF0RlZqdzR4UGlUL3RSMjYzVEJ0QUpWOVVI?=
 =?utf-8?B?Yjl2N21aRVNWOEZadDJPNGRpd04yS0NEdzlSbVhzcURVdmVFZ2NwUmRkSU14?=
 =?utf-8?B?OHZPY1NNQy9BbDI1NWN4YmtUeWpaVkJIUzBMeGQwZkVJVjQ3MFpIbU5EWVg3?=
 =?utf-8?B?NlcrU2RtVFp6VEpLblZqby9JZHdocDJ5VzRZSG9iemVob3ZjZGJhTjVaSHAw?=
 =?utf-8?B?UnlxYXg4eGlwT2V4YWJTRTFSMkR2ZXZKalN0Tm5XbmhWS0hvNFRPQ0prQ0xK?=
 =?utf-8?B?WnJmL0hRQURIdWM4anBGTCtjUGZtalZHaDlvakRVNUYzam1mR0Z4Y1J6WXJ3?=
 =?utf-8?B?SmQ0RjA4a1J5amJPR0hMZlpGWmdtakVkTXBpV2JnQVA2d2Rjc1A1ZkUvZi9U?=
 =?utf-8?B?aS9LT0d5Q3IwMExBc29CSHhlYTUzRmRMVlVpdEpnMnJrdHJVcVEwN0JyUnk5?=
 =?utf-8?B?blpRMzk0N091aUJCaFR5Uk5CT3VrWkV5ZXZQRUY4Q29YbTZYbzFIVThqeTEy?=
 =?utf-8?B?SkpmUEF4UlFvblh1bkQxY3B4NVlQSzZWSU1vb25NWDB2bXdMM0RZK3BaaUJk?=
 =?utf-8?B?azYraVpYdW9xQXRwYksrY01sbTNmdUxqM052eVVCUmZxMTFuenNpaXZjbXFh?=
 =?utf-8?B?Nk1oSkd6ajlJSDdkUlhkdXJFWEJHY2wwekU1b2E3L2p2NlBLV1libzd3bmRQ?=
 =?utf-8?Q?uGXAJyRo9wCrRIJw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fc4e47da-d01d-4803-a814-08de6fe77bd2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 18:48:33.9850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DXhVTJDC6j/lGbZpJehCtfLtIN6zeiRP4YjLjTx+V7MZMv83Gz66H7UTxiNVKk9xI7Rw0VMDvF+uiIjYNIAeKdvYDtSuCcwgTWoOskzk1n8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5177
X-OriginatorOrg: intel.com

Lukas Wunner wrote:
> On Wed, Feb 18, 2026 at 08:56:14PM -0400, Jason Gunthorpe wrote:
> > And not sure we should be dumping any certs in sysfs if the plan for
> > the other stuff is netlink, it should be consistent I think.
> 
> It has turned out to be super convenient to expose the 8 slots with
> certificate chains in sysfs for direct examination with openssl and
> similar tools, without having to go through netlink.
> 
> Originally the plan was to make the certificates/slot[0..7] files
> also writable and the kernel would implicitly perform a SET_CERTIFICATE
> SPDM exchange with the device when writing to those files.
> Unfortunately with SPDM 1.3 the spec editors made things more
> complicated, *cough* sorry *more flexible* with additional CertModel
> and KeyPairID attributes.  That additional complexity makes it less
> suitable for sysfs, hence for *provisioning* netlink is indeed the
> better choice.  But just for *reading* the certificates in the slots,
> sysfs exposure is very useful.

Useful, but not required, right? The consistency argument from Jason is
growing on me. Merely validating the certificate chain is not sufficient
to establish trust in the device configuration. So, if a $pci_auth_tool
is needed in the flow at all is there a practical difference between:

	$pci_auth_tool cert --device $dev --slot $slot | openssl

...and:

	cat /sys/bus/pci/devices/$dev/certificates/$slot | openssl
