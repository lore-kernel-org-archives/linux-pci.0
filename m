Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.101.118
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794476877;
	b=wx3bjknMhv7Y0Tvq+AUAcV5mPWgil9KAUt6eMYE61v6IJnRnHyiG6LNeMkqBsDz/8Sel
	 ED+odyx7f70zokB41z6BQIwH/4db63U8pvBnHjIIGaGIjLVwZqIaRSiUAX2/o/GSK6KL6
	 g23QZFkp2Yks43XcP8BV+9626ipVv1lRHazXdT8LY725lsQ66erjMS3zwV7qv202gFC9m
	 W9sWxCEAEUNcRf/Q04L2Nh6vTZaaZ9/98xzmQKAL5GcbQeZbQ9dlMhQv3B+mSltr7Jh0u
	 uaf5Bfj4GDoSi2hhTSumfdqLaNhXt3sNQFGQcXLblbO78GX77B3LfkzOqSquwINxfdg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794476877;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=6Mt4VEBVvsoAzSderHYMNdoABJAA1LfVeVO0vl9VrAQ=;
	b=o5UnwcxH23Rcbgtx3EFcR/7BMh3qkRMfUCunFIeJMTP6OlTJYK2QDxNZSE0DxzDPg9kB
	 u0mJjic7UfCN4BsskGTa9tGd1nSrP54Bel9y2c90dEXGgb5lyOor2YNgqTQc8uEXnFA6C
	 Bngpn0VuJNWyP8hV6ZFghicKCTTzud/NqFFpFSyB4pcnk/bbKEEqlEXLNXw1UalP4wBxA
	 w5RBNuV7qIrlEfiLR+1+1Yq8aD5mILBflOnenVqLn3QBmSj8skiu/cfk49nv3DSa8e26P
	 +hKWxIxy5jFb4q/A6hOM8tnEN8cD2tYRRfxSOGHoG77o2hMz6hZ6Cas05eGjJxStrIA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=garyguo.net;
	spf=pass smtp.mailfrom=garyguo.net;
	dkim=pass header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b="rtMhs/V7";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.101.118
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022118.outbound.protection.outlook.com [52.101.101.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03FB606A321;
	Thu, 12 Nov 2026 09:47:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A03FB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=rtMhs/V7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ftiZWf0Do/NGAie3FVER+455C2FSiKyKqsGS79J6+cQzeOGhEX5yN/QzoKI23PCQhCbxkSYO9I6mVARYxnJaFJsOr9d2lH+BKOYX11BdNYf2BoLfwgn67KTRFzlB9fF/xyMV7q79Eep8zOXnWTrCG+Fb9jv8Nw0r+VxY2p3kY75xvCe7H6G4/bhtGE5IPqE/HM0gfE/8iPFVNBC30PY591i1jfp29vVWdAtQ55yCO8p2HfydD5eHGFxNQlXwP3iNC3gzq/D1b+JyJVqqR/fR+9YJKs+QwIAE/OlQ07dFwIT4wYJTDOT3WzkJ+wprhwb+PD7fE36l7vFHIkT4BJnWxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Mt4VEBVvsoAzSderHYMNdoABJAA1LfVeVO0vl9VrAQ=;
 b=EFGmYQyFD8h/RPEZRbTTPX80N+kV+W2UfH8SUyRbgfl4vS0laAYHZbVvOtSo94C/DLL00tCD/mDU6GRHlKQadToGweTeMU9kM1wnF7BwK4XewF0q+9cGX2hoJ70qUq7rk7zB7/bWKepMi1JQhouCqH8TI5zXfp+3Okb/SIvXklW9xwUbsNyRBBGUbYAZqyyWyzZFAyJBepjr/jgc7h7uXU9qfR/4I//VsI+LBZ98tXZarljchBRR/Z6tsLzwgug/hHCltAXiFhPWEPYiPiQcDfL66qae1rFhyRlV2SUnzncTlCHp3/5DP+n70+EHTyT3MoY9uoiD5hdKUJT9pIZwqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Mt4VEBVvsoAzSderHYMNdoABJAA1LfVeVO0vl9VrAQ=;
 b=rtMhs/V7FOjIVgrdUoAme4IEhkmWxFgmwKJxFAYi8AqXQ3xXuKGKGxlzp26C5GHjNipUdgNcHyQHzCL2mpYMThxX+vpGn2A3EitJ2vB0LurgU1tHT64cYWxo9CwksXlNEQpsBPq8jQaVdL8Lrpy8a8EfX2iUZvmzSTmQ1vrpSsI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LO2P265MB2511.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:124::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 09:47:53 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 09:47:53 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 09:47:52 +0000
Message-Id: <DMT4YMPJ9RZY.XXPFAVT09XNU@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Eliot
 Courtney" <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn
 Helgaas" <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "LKML"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] rust: pci: add domain_nr() accessor
From: "Gary Guo" <gary@garyguo.net>
To: "John Hubbard" <jhubbard@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>
X-Mailer: aerc 0.22.0
References: <20261111200549.160806-1-jhubbard@nvidia.com>
 <20261111200549.160806-2-jhubbard@nvidia.com>
In-Reply-To: <20261111200549.160806-2-jhubbard@nvidia.com>
X-ClientProxiedBy: LO4P123CA0559.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::15) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
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
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LO2P265MB2511:EE_
X-MS-Office365-Filtering-Correlation-Id: 9704c5dc-b962-4ffe-d07a-08df40a205b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|23010399003|1800799024|366016|10067099003|4143699003|56012099006|261022105027099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261102123227099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	pD1ZfjLBDXj7ZxQfMDT50mCqI8N8qetXsb8AXC/B+teqFl5OkLTlyDPY/HbcugQtRJDVLaGv7aFUUyGTWldGv4HqrhGI9MYisnN/vZNJuSDf5PfNcYSiQOAO1D+uwHXGQaMJZiFB7CUdO9Tq4GyTbxfynlb4Ixkki+e9wQQ1j2iRmytlIBY0/j82DnsIvyxdOwA6rGCa91S2HKeNMC/pE4uIaBBGc+SBMsewZSEKEs6Ju40gYrb6Xw38DKbYnaghOxLKkj1fV+OcRbzyeRiTV2Kje29zxL13erHdLvm53AuHiXNBHjssDpIDVIPfwbpj0zApwN2Vs3Wmi658eqoOccnEY1gkBcRvUZ4ZcCloYTdzS+M6D+PpfDWEgvCmfbekz5d2YnVZUpwXw2pXhQawT9RqotBlXbf63kQMA+ArBfMyLiqn6UqZh4qNwQho1BPgmfRkM5W/C6OAtHv2ltmLYH7atQ4vbUs6GhbJnZapUf1xDNXCpIRgYqM+/vYB5cHSRNIUkHLczwjTcHLA7lnK3MW+x7Hlw7625fmK7DJZBlc+ZAy83ya+aFgzDffIJj5hfKMh+SV5AKU1Ufan24tEFFQWo0l0VI7XeC04D2bPgvLF+YwzMh6p+3g1VpzyPuA4FhfHHT9lQtXEkUBCkoEtkeiredCnElJlTM0Mk9J3uy8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(23010399003)(1800799024)(366016)(10067099003)(4143699003)(56012099006)(261022105027099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261102123227099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXlkY0xtQmI3Mi9LTm9hWDJyT1pYb2p5YWJDSUFvWE93ajFXWXNGWGRDTW9o?=
 =?utf-8?B?ejRiT2RTRFJVeXF5cGw4TU9PdG1RZlVrcUZzSU8zVzhVcU0vUkhFeTd0Tmo4?=
 =?utf-8?B?aTdXbWhrelJlTXpjN0x5alJZMzRORUlzRUF3TTBsenU3RWducHRNNnRmVWY1?=
 =?utf-8?B?N0VvMmRjWEsrRUZ0N3BrZEtHSllpczZ2cFNYZEZqYUw1cDFvN0swbTd4OUFi?=
 =?utf-8?B?eDZ1WXE0MU92eG9JVTcxS2NHYnlqRHg0TWNwWWFGUmp3Rks3RExkcnBtRUZX?=
 =?utf-8?B?dzdQd0JUTDJQbHVYUHBrNTRHbU5jeEhXNGNPUmdIR1Zmd3hHZUluTi91ZVhJ?=
 =?utf-8?B?bjU4NFcwYzh0c0t0N3RmNy8xWlRsdFpLTGxxQTRQTU1FV3VVUmIxQStPWHlG?=
 =?utf-8?B?cFd4NEVVZ0htVEFQb1R5NzhNL2NBN1hzU1NzN091MHJ0YmlVK3c1YjFhekNW?=
 =?utf-8?B?OSsraHFuVXkreTVaQ0FUVm4ycExUOW0wdlc2R20rWUp3UXlkSUs0Ym92MFlX?=
 =?utf-8?B?MTBmcWxQVSt2R0JsUWJVZHhRNEF5ZFlEOHFqbFZIcTlubHk2K0psRkswa3dx?=
 =?utf-8?B?YXIzQVNBUS9Sdnk0NlkrdjlhNS9LeDAyaDFiZTdwcFNUejF6UFgvbmczSTlW?=
 =?utf-8?B?bmVUcC8yUXpmbFRmZGtBZWFnZ2w1Rzk3elRZR2piVGNxZFlpN25NZ2YvSFEx?=
 =?utf-8?B?b083eEZRN1dmMHNBUnFtMWNyRGRFVnVSZENycWNOckkrQWU1V0paMjh0YWJY?=
 =?utf-8?B?V05RQ2M0cS8yZjZKVXVVTWtiNzJRTVBIMDVDYXZOK1NpQS9XWHozcklNRzVZ?=
 =?utf-8?B?TEhZUVVjTFFPSGVkazk2cC93bGtKLzg3ekpjRFVVWnZPOWo0L3JnU3RyckFN?=
 =?utf-8?B?OFhyNG9hdDBiTldITGdXN0xHSE5uU0lCOVJSQlhIcERDcVZaQ3R0Y1NTTjE1?=
 =?utf-8?B?VlJneEp4SmxreDIxYkVJUWp3YUFTQURmMzMvazlkVjZFSnY3MDNMYW1MYjg3?=
 =?utf-8?B?MzhNTFVaSlBKeVpVM294d2o5cGRYWUdaYUZvMUpjQWx0Y1BQaGpwMUhaRHll?=
 =?utf-8?B?VmVRcjVNajdIK1VONm1qQXRtTm9zWW85U3FSVldhMG4wblpTTVhrNXNzd2RD?=
 =?utf-8?B?c203TDlPWFNYY3lDNk1zMG93YTg5RVI3aEZTRjAzem43aDZjS3hockxOSkx1?=
 =?utf-8?B?RWd6Q1IramlTRFJSbDJBcE9acmMyN3pDdm9adG9WMTYyQzk0TllHWDlYYnE3?=
 =?utf-8?B?VVlkWkxZKzZHUHBnSWVLUmd2SVEzSUpOR2dQNThlQjR2cjA0SFh0bUs3OCtL?=
 =?utf-8?B?bFRIM0RaS3g1T2NXVEpPTUlYc0IzSWZURmlESU8vVnNmQ2RjNC9PcEREUVZT?=
 =?utf-8?B?Z0hiMWdlZVVqRUZVSVdiMGVJS3FDWmlIWWpIN3BJQWFJL2daUmZBMWlnZXJo?=
 =?utf-8?B?OHVMTTQzYWc5RUdnUFpXM3VmdUhBc3hzc2NFWlFLeS81ZjlzdkpZcVNjd0sv?=
 =?utf-8?B?c1hJd1B2bHJHZUdrWXZGaEJGTGNPTk1CT1ZaUG1tUU1rNEdHNkN1Y1VUYWJD?=
 =?utf-8?B?THU0Y3BrQStnbFUwT1B0Ulp5dFhtenVNb1ZzYlAzT3Mra1RTeHo5VzhHQ250?=
 =?utf-8?B?bXdOU0V4dVhaVWhzNkZrQUVVb2NsTWJyb0F5QjNNRUlaU0Zvem95R085SFRa?=
 =?utf-8?B?V0d2KzRlMFRxVy9UaGZwMlBPUU9TWVp5Qk1hSFVVcDFKZVBiMWZabTJLVkw3?=
 =?utf-8?B?dHNWZGd5WkptZDVGOGlucFpZeXJIcEdvRk5VTkpSOThwVC9DRTdtTldJQ2xj?=
 =?utf-8?B?aFVXa0pzWkZFZkJ3aS9TZUJ1Y0dDd1lUUUR5dWNuWVJCdEc4VWtHaFpIdHBT?=
 =?utf-8?B?UWhDMlJNckFyYmh6eEJaL1FLNFd6WDgyVVM4cTRvM1ltSmNlRnRHdzZaaXM2?=
 =?utf-8?B?TTR3VXhSaGVNaHIvUmJHWGZaK2pJVWp5ZXV4Tjhnam0zUmE3TTJ1Z25lUkJT?=
 =?utf-8?B?TE80QWpzb1puTTlMVHZmRjRrN2c5WWkwNUdYVDAzSXNCa2loZ3ROWTRxVVlr?=
 =?utf-8?B?SFhyMVFqbUQwZVNqTUxJSVJGd045MWNZekhEWVJXM2JWbEpzajlQUW9JaWlx?=
 =?utf-8?B?Y2FNK2dvQm1CMUZDa2JtaXN0NkltSS9CemlLa0pyK25FNlJoVjZ4dStlbHZq?=
 =?utf-8?B?Mm5idkMrMVFVTDNERUdXNGcyK04rTk45UlIwOFpwOEZqMWJuUzdCbHZUQ2Fw?=
 =?utf-8?B?OWNubXJNN0lTaDNaVElobnhlOWZDbE0zcFdRZjhZRyttSTNnQzlNcStCWkUw?=
 =?utf-8?B?V0pWMDlxL0k3VjNCZzhlYXQ0MlRSQWV2Uy9xS2cyTHF3MFp0RmJOdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9704c5dc-b962-4ffe-d07a-08df40a205b2
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 09:47:53.5585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KWkR6w7GOea3SSyyHJU3ywwW7UIMQZa9LAQB9ydyLvXhXItWVJLmyNySetZ4T7YdwAZ7+ecN+r6JZvVPFrJTLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB2511

On Wed Nov 11, 2026 at 8:05 PM GMT, John Hubbard wrote:
> The nova-core driver has to send the GPU's PCI location to the GPU's
> firmware as one word that holds the domain, the bus and the device
> number.
>=20
> The PCI abstraction has dev_id(), which packs the bus, the device and
> the function into one value. It has no accessor that reports the domain.
>=20
> Add an accessor for the domain number.
>=20
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/helpers/pci.c |  5 +++++
>  rust/kernel/pci.rs | 16 ++++++++++++++++
>  2 files changed, 21 insertions(+)

