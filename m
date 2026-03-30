Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A80E2A1BF;
	Mon, 30 Mar 2026 01:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774833751; cv=fail; b=U2crhg5hgj2rHxoAeUfC9VZj9rdl6jXBAjQUoFBLe518P8PUAKYALGciqoMeVLf7YVQtrEBXcbaRlp+9BFpQ+pcW3zTpJZVFiMMn+tWn9fxZnB+hfYJZElq/DMqPEGj3ORhMr0/v0jheNx3MTFFklxyBg+nStnz63IqCA0gVY+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774833751; c=relaxed/simple;
	bh=vtoDbmTf7eVkXt3jWitnPxWj84Ejf0zUnsyDEjrzqQg=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=Pag/AvjswmPllaGQ+Ijqx1uTAVqTeDjcLPX1NJS07ruG/xKfEqBG6MZj7nrnuUwRqx1bzO04KLRY8Yh+cbIQzmmiqkKMLrqNPxZu1dnLonGjSQ/OX1dBiX0Y7ga7NpnLy7d9rKXeUjQVTng1NYKhjzpPXV47Wf9fAGfvqJE0kKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lk2goj+g; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lk2goj+g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774833750; x=1806369750;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=vtoDbmTf7eVkXt3jWitnPxWj84Ejf0zUnsyDEjrzqQg=;
  b=lk2goj+gObUtx0JZ+xrhKNYLSG60S+VrINJdPyIC/4luWwOy9K1GmcuW
   Y1qZoprssF+jW0I9OoKXZhZGo7VmQNe6rWm8BWGwkMZcfAxv5kkJHRYuP
   P6sD8WAfO3AGOADyOUSc3h9+5g2GO35+GRMOKOcKRS9LOHSiuYmcTNFNZ
   Jk4bxI2cyAWG2PvIzCj2C/YhXHo7sYU4yCcNa5FNK2dHb8E3q3dLqu2Rl
   qV75t9QjDtFuHwvSQemTsfKS4LFvDmNDpjz4xbC0+/CaT+hxFw6Z2Jpfk
   EUnN6ZaC3TsA5qmRFeWZT0jqLHmEXJnyeXXPe3jYxzipvldHMS+6+pnKy
   Q==;
X-CSE-ConnectionGUID: GoQL8Vl/RXCYVudUuh+PAA==
X-CSE-MsgGUID: HBBMBN8bQb2hlFpLv1h/nA==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="87292557"
X-IronPort-AV: E=Sophos;i="6.23,148,1770624000"; 
   d="scan'208";a="87292557"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 18:22:29 -0700
X-CSE-ConnectionGUID: L970pppXQJazAY6w2BH1gw==
X-CSE-MsgGUID: gOtqEHPMRw6YEIxKnFW+Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,148,1770624000"; 
   d="scan'208";a="263837223"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 18:22:29 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 18:22:28 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 29 Mar 2026 18:22:28 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.19) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 18:22:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zacc+d4pXwYR0FChbm/OTTqfy5bW26cUsKOpcR/gY21Td0OyqW9lcs8F0ADMuXuXafFevP2e7p7MlYsnPAC/pzJrjWSYlbqpuqfZnNQrXDT/dokPlr45WgmLQjegYqkp0SNWcIkdg+53Ng9LfEalGUu80+ar9xKHkeDFzCSbLBlUOGqaDyHeA5WCgvwBdpCVE96UmhEAjiVx0cGlAboFTP5nSsXl7E+hTokfGG393sk2pdM4+yB8G5EytKeHq6RBgBzbsu31aBWFjvMHEGLEMPofw61P2xezfok6rEucZ6Rcd0ndeNGClOXobc+CJKQ/JNzNxT2+crrmseSVe92wlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2oqa/BkIcKqmpzU/ZBNXe62BcEhy3M6kcNa8j3ME1w=;
 b=KAvruXYxUXWi8py1/eF1LQL0GYAXNCqpZmNye8IBpW9Q06wSGbvjL1v2LCZ8jTP4u6d1hx9HQ+n3MJRAmKQZ5XVy+dQ27SlYcISwJU1ddniHha5wlzOBHAE3ZProgGbPjuNLrdben+uXMVg5oIMyBOECBnKhoRIAj86rb9iQO6OrwTcPiIbRxmOGhrvjChMMMm+D9WOk136LrZ+pis1769VgkzX57DsG6tADwRytxCq4CPOITnZzXhrOPF6UIvfDY60FaQlpxtdrmUS+vteYMPDfLt16+qlxpmvQ86WkhGE/gjj10r1zRVEjQuIHnRnm3P6Wiz8PcnmRbzoYsdFqAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB6701.namprd11.prod.outlook.com (2603:10b6:806:26b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 01:22:24 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9769.006; Mon, 30 Mar 2026
 01:22:24 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Sun, 29 Mar 2026 18:22:19 -0700
To: Terry Bowman <terry.bowman@amd.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<vishal.l.verma@intel.com>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Message-ID: <69c9d04baa431_178904100f1@dwillia2-mobl4.notmuch>
In-Reply-To: <20260302203648.2886956-9-terry.bowman@amd.com>
References: <20260302203648.2886956-1-terry.bowman@amd.com>
 <20260302203648.2886956-9-terry.bowman@amd.com>
Subject: Re: [PATCH v16 08/10] cxl: Update Endpoint AER uncorrectable handler
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0203.namprd03.prod.outlook.com
 (2603:10b6:303:b8::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB6701:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dd090fc-b905-4e2b-6c99-08de8dfacb0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: 1dUeVAFT7QPYDdOlXXBKnsRo/I3QVJ2kFl8uma9f5A4SGUZU12rUCvcR4ODLWW/mk+AnR7nOGAxM5oAh7MpWc4/Hu3AOV5WnxgLxZICfoChK3QsQ/MDICI/nvX/HCqhshLSc0u/cX7taWgveIYj+E0Dehoyo5xn8pQcQqdr++vc2YkH6nlikUtU2Vw9Gz6vrQa5aRtcGiHtHc/HadJsX0KVWiKM0gmR3bynfhmPkALXjbkA6Od+WpwcSKUMJEDxjlRK7LSgMljxwuDom8p4r+H40wZxfiUjfFCJUod/Jb6tIRcVkZKcVL1IbPlKdKKGDnwHP7AAPI1HETEwwNCmvYVOkKYHsvYjDWb+WiFB3XhBC0t5sUTYQXEJA6iLZ/+TAbgXbdmPculqqnx7AT/Hja3p7jUxQesV5MRDp+wFzT2xnlreqf7BNIKz1DF6D95DYK1Hh93SyO6LOmgGvWSwsxLH8nUbpiWAlqK389MMJ7kbq6DukaP5XgYzK1a6UtsfyzHFEfHsOI4uxo8xq8vPGraBUkr+Ts4JC3JBrWD2WY4XockDgr3UMPCjP8pkbJ/MsVcuHiNq1UUUcZElG0JJ46DXLKtbntx1RyP5RzVPga9h9BovtB6V+Wq2aGOI4EP8bRtNWpf3diSSaNrSgji8Y+jMKewiwkOL4AfaVy5G8zS399aa2uCI12p6BRys329Xw0DTcfyrp0rmDRVPIM9mn86VANxkHFQVSW90ge6F5Xhg7baU9TlpVfuF25hh8vma/55gVDSvU1TbF5iEp3V2hTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzBHOG5VMmlYb2lEQ0dvWWRzOFhMbUE0ejZmWTVqNklBbDVIQWh6VHVmeXN3?=
 =?utf-8?B?SjVPWXJKN0IwdjBiM0lhdWk4OTl5Z0U0dXhUL3lvN2NVRi9RVGk5TGU2K0l3?=
 =?utf-8?B?UGZEcVkrVUlDNHI3K1dSMk5XaElLRkpuRDVsMWZjWm1TU29KeENsUGtPME9I?=
 =?utf-8?B?YUhsWlBvWDJXWnByNVdmZjdHL2dIQ1UzalROUEpycThYT2FRRndmVWRraEdS?=
 =?utf-8?B?RTJVSDZDdzgvWnZEb2w1bHZ2d0pYcTdobGF2SzBsc2V3cWptTWNsUlJucGQw?=
 =?utf-8?B?NGlRdHNpYUNZakl4OEcwTXY5T1diV1labmpEekRhTmdidG14d3daY3J4aHhX?=
 =?utf-8?B?ZVFMQWU0N1dQM1E1d3hTN3NSS3diaWw1Qnd1MTBRZ2RaMkNGYkpvdHVTblpw?=
 =?utf-8?B?RXpWd2hXdnltWHBqMVVkUjVwc1hZZ0U4VGNZUEJxRG4yVTEwY01TaHl2OW1K?=
 =?utf-8?B?c3hmMmNVTDltLzhkT2V4SG15UWRXb3JKa0VwQ2VmRDcwMHlHcDBjUW9uV09O?=
 =?utf-8?B?cFYzcEQvcHo5aTVMSTJwWlE4SkN6SER4WDNWQ2tkTkpUbUxyeHRaaHNaMTJJ?=
 =?utf-8?B?L0dFcFpqbEpQZ3dzSlhkeld0aWV1ekZaUE1DYitRNEt5TVg1SGJqenRwS1dV?=
 =?utf-8?B?WkVyckIwV3g4V0liMXlzL3E2bGhQRUJzRlBESTE1ck4wTGczUkFvamZOUnVX?=
 =?utf-8?B?ZGVQWUFMaG01ZCs2ODNralhiVnVuUzg2Zm1ScWk3L3VBaDdraWFQODlhZ3JF?=
 =?utf-8?B?TVR0OUpOVlgzT3JsRitBemR6Uld4NzhtYjQvQ0pIWTNDMnhwSEZ2Z2QxSnBI?=
 =?utf-8?B?WGJrYW9kMElsZlRjbmcvdnNJVytuaks1akRPU2hLc0RRK01hTWxIcFNIeFE4?=
 =?utf-8?B?cTR3SnBBT3B1VHdrY1lGSW9OL2tQLzdRa21HUVFscGZlZkxiTzJDUDFXSXdW?=
 =?utf-8?B?dlNmSC9tK3RMbU1xeTM0OUEyRGcyL2pHU2JpUFFVYk92Q2l6VzRqbXgvT0lP?=
 =?utf-8?B?U2J1QUJPZlJiTnBTckM2Sk9uOVpLWjVxQ0dCZXF6c1BMWVVxNGNPSWx3cEVh?=
 =?utf-8?B?OWg0RW4vOHhjQmRRWFRTdjQ3TGkvSUtPa0hja3ZhR0tObkFXL2xCZnNaSi9J?=
 =?utf-8?B?dERWRzQybG03anV3NkYvY0cxSjdMR0xnQzdsNGY2dVkxTnhGUVV5MlJvc05j?=
 =?utf-8?B?NWtneUYxaG5id0tJdnRhd2MrcW53VWtDR2xrY01CTDQzUmZzYmxzSnc2QXQv?=
 =?utf-8?B?VXRCMjNHNloybzYvRi9KSjVyWjM1Mkt6a1VxbmY1UXp4UGh1MFdjRDlwVllB?=
 =?utf-8?B?V3g1UEx2WlE2UE1iK3JpdmVDbTVGVkNBQVkzYmxUS3JQWEk3ZjRyQXFYSUlq?=
 =?utf-8?B?MitJWDdKUXRDbC9nUmhzUlFvWEF4WlVEQWl2YkVkQlhMM1VQTkthYVJyQi9P?=
 =?utf-8?B?TzdjK1picytHSU1VQkFtZ0RieGp4LzRjOTUrZWh0UHZlQUZPbHhXYUFWekYy?=
 =?utf-8?B?WUxzUnZDbURaTWE0WTA2QjY5dG11cit2cjB3Rml0SVBDMzQ4aEZiMHhtVktT?=
 =?utf-8?B?TTA1eVlTM1lyK09HaVM0LzNDdXFyamxKV0pRMTV2QTBQVFA1U0NkbTUyU3Vz?=
 =?utf-8?B?Z1BZVHZDVGFJNG9rNVZMaHlpRWVkbXY4Ymc2T1dSeFQ3NkxacGwrMDRxSWpq?=
 =?utf-8?B?amdxbDJJMkRLektSQjFCbXJ3WDVtVEFoVnliQldOcDhVOG5LQzBJRldMWlB4?=
 =?utf-8?B?NHpTY3JoU1VIemZETUduWTFIa3FhRlZqR1ljTHhHNER0Zmpvd0RLTUc5UHM2?=
 =?utf-8?B?TXphRm9MUmxJK3JJWmxBeDFMZ3YzbVRtUkVvWEo0MzR1TWx2OENRcFJzWUZi?=
 =?utf-8?B?a1diUEduc0k0VVRicHVrU1lzRnFoQXJaZjhvYXQvVFNPUHVzOVJrTmJiS1hp?=
 =?utf-8?B?QzF5cEVIVHZ2MHRVWHB6L1F1aHBVbE1acEVXd3JaeWoxdGdpdG1jQVpMMk9J?=
 =?utf-8?B?TmdpeWtpOHhRTnFxWC9UdlNtWlgybWlWbUZoTnZtcXpZTG13MFdFYnlZMWhO?=
 =?utf-8?B?bUNheWcwS0F0Tmw3Z2tENFVPUTNoR0gzVFU0NFN5NHN2YWw1NTlwdC8yVzBk?=
 =?utf-8?B?NEw3Q1A1SVNhZ2kyb0p3WUV2dEhEUk13K0x0eitxK2lBeHhXRVZRQlRGanYy?=
 =?utf-8?B?ZjlBeUhmS1pza0RXTm1JVGdjeks1N1p6NkF2Sk5OMmkzdW1YYVlQbUV4MXBp?=
 =?utf-8?B?MTF2UEhINkFrUzJIaXp6eW9Pd1RpNUJvU1l1N3c2b0F2ZXNscGpoMFhYbVkz?=
 =?utf-8?B?ZTY1RWZMRDc5OVliNnorRGtWQ21wTWhsMks5VjZIbmpaZkw4MmhUckJ6MjhL?=
 =?utf-8?Q?hbUqdKcIA+KkmSPw=3D?=
X-Exchange-RoutingPolicyChecked: hJBHskYxbKoHWVfpHqoteNDxaQ4YdQkyJGTuKrM/L/QlDoEQW/BGK6luyZzVYy42uQX9jDQJEWDdXZb2AJJXeI+ZOqNTAQxTY3jAQT6PqkrAT15D/eIwntiYEfxXzH03nfhAITKI93qbYF0lQhRpw/x9D7EXyikSYYSPwMvIPrTPIDOaCmME27ZmWJCzFa2DuJvwh9O3DSr+8IbBjz05MMpSMM4ilDgNVmQH1QFrTW45ylBNsVZwT/vhvw5UPVdjPJ0P+IlIq0Qex6oIJ6KAsoP6PAf8phttQIQNrCUpO0RX54aFK528sGUnqCdfwy8N76Hqcw8LkS7vADbn4oUMTQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd090fc-b905-4e2b-6c99-08de8dfacb0a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 01:22:24.5639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gC19sO2cgLLvH7K0xvqLpJVRLsBsyOlH3c3DX6WuPZV4Os4zGBlxXL9KnvPH6idoCkX9r+FuSySdD/UyxypHCCVysLdZwxaRsFci+Nb9KJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6701
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> CXL drivers now implement protocol RAS support. PCI protocol errors,
> however, continue to be reported via the AER capability and must still be
> handled by a PCI error recovery callback.
> 
> Replace the existing cxl_error_detected() callback in cxl/pci.c with a
> new cxl_pci_error_detected() implementation that handles uncorrectable
> AER PCI protocol errors. Changes for PCI Correctable protocol errors will
> be added in a future patch.
> 
> Introduce function cxl_uncor_aer_present() to handle and log the CXL
> Endpoint's AER errors. Endpoint fatal AER errors are not currently logged by
> the AER driver and require logging here with a call to pci_print_aer().
> 
> This cleanly separates CXL protocol error handling from PCI AER handling
> and ensures that each subsystem processes only the errors it is
> responsible.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Assisted-by: Azure:gpt4.1-nano-key

This is not a human. If you want a tool to do some of the labor of the
patch I as a reviewer want to know what labor is performed. This tag in
this case tells me nothing actionable about what needs reviewing.

See: Documentation/process/generated-content.rst

> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 254144d19764..884e40c66638 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -393,34 +393,41 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
>  
> -pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
> -				    pci_channel_state_t state)
> +static bool cxl_uncor_aer_present(struct pci_dev *pdev)
>  {
> -	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> -	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> -	struct device *dev = &cxlmd->dev;
> -	bool ue;
> -
> -	scoped_guard(device, dev) {
> -		if (!dev->driver) {
> -			dev_warn(&pdev->dev,
> -				 "%s: memdev disabled, abort error handling\n",
> -				 dev_name(dev));
> -			return PCI_ERS_RESULT_DISCONNECT;
> -		}
> +	struct aer_capability_regs aer_regs;
> +	u32 fatal, aer_cap = pdev->aer_cap;
>  
> -		if (cxlds->rcd)
> -			cxl_handle_rdport_errors(pdev);
> -		/*
> -		 * A frozen channel indicates an impending reset which is fatal to
> -		 * CXL.mem operation, and will likely crash the system. On the off
> -		 * chance the situation is recoverable dump the status of the RAS
> -		 * capability registers and bounce the active state of the memdev.
> -		 */
> -		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial,
> -				    cxlmd->endpoint->regs.ras);
> +	if (!aer_cap) {
> +		pr_warn_ratelimited("%s: AER capability isn't present\n",
> +				    pci_name(pdev));
> +		return false;

How did the PCI core generate the error if this capability is not
present?

>  	}
>  
> +	pci_read_config_dword(pdev, aer_cap + PCI_ERR_UNCOR_STATUS,
> +			      &aer_regs.uncor_status);
> +	pci_read_config_dword(pdev, aer_cap + PCI_ERR_UNCOR_MASK,
> +			      &aer_regs.uncor_mask);
> +	pci_read_config_dword(pdev, aer_cap + PCI_ERR_UNCOR_SEVER,
> +			      &aer_regs.uncor_severity);
> +
> +	fatal = (aer_regs.uncor_severity & aer_regs.uncor_severity);
> +	pci_print_aer(pdev, fatal ? AER_FATAL : AER_NONFATAL, &aer_regs);
> +
> +	pci_aer_clear_nonfatal_status(pdev);
> +	pci_aer_clear_fatal_status(pdev);
> +
> +	return aer_regs.uncor_status & ~aer_regs.uncor_mask;

Is the above doing anything that pcie_do_recovery() is not doing?

For example, there are zero endpoint drivers in the kernel currently
calling pci_print_aer(), why is cxl_pci special?

> +}
> +
> +pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
> +					pci_channel_state_t state)
> +{
> +	bool ue = cxl_uncor_aer_present(pdev);
> +	struct cxl_port *port = get_cxl_port(pdev);
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
> +	struct device *dev = &cxlmd->dev;
> +
>  	switch (state) {
>  	case pci_channel_io_normal:
>  		if (ue) {
> @@ -441,7 +448,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  	}

I am getting the sense none of this is required. When the device is
trained in CXL the bulk of errors will be CXL port errors, when the
device is not trained in CXL it will not be in use. For that remaining
case, why does the driver need error handlers?
