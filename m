Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010015.outbound.protection.outlook.com [52.101.61.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF48B40681A;
	Thu,  3 Sep 2026 12:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788438430; cv=fail; b=V0r3FKyWWcilZmbsCtBbyuELC0fPTKbiXQV+dS9DQQAASTRP6c7ulDd40ZkdTtayGXjKin+LPD6HIW4IiHN6pUvRiDVnQRJgHK1+uJPofUdiTG6/c+XLL3ZaQJBpxgaJPbN2qf6GtVW0vCe0w7ooxB/PrZbUHs0rUKEOrYtPlcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788438430; c=relaxed/simple;
	bh=Imr/XfhwElG9Ewl5+0wysTitlhhtSJ1MpMStdMmrFEA=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=RXKURzx8qumI0eY71Qt8C06hVkr29ZA3fpYMZ0IMBKOPEqBmbx7OL57gtcg7OM4mkkvlKtWhJp9YTQbFpe3X5lV065PWnJnCjrINizjOPpSDHx8IDPtayKPIvKY+a4efj+VLvqH4WzB+49+N82sO1Uvc0nLQ8oI8rxo4FBzPQVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=egKtmy4C; arc=fail smtp.client-ip=52.101.61.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="egKtmy4C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vIcJlSjelrjVmamkifEPYvyRZDsshD2e5jEvQ/29O87dY/KuHVesViIhA2BxTNwSYCrzGzDaiSX1RNMcV3v4irT3zBKVKGnHMXyFTFA5HeOeSwCLZmfOZ+kQln4ekYWZj3QxXqSkgFMzFeO886afzBKkfXFy+gF9DtRNzgpMs1uoRNlJoilOoUkea7CfUI407jiO6WWG/U45h0HYoN+tPFLU+I+6ASK69/9iS9nMFtu1W+5KlGhB6HDUmyiixCq1dNW/1Pw4IJJAI6uxydfWDvd1/CP7lzU6GKKAgXcvUkLzaExpDRMnoaWKpojLRfZYexTcdN27wXO9ocxoWbOvmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Imr/XfhwElG9Ewl5+0wysTitlhhtSJ1MpMStdMmrFEA=;
 b=S8Uq+cxigPslz2HmKmSfOwQOgClwccYhOaWBQy2rZKgO+++xDixweWybQWypHnfWpuFPwweYND//0Lv0Hk6MrKqM9icDL3b5f4mjE/VpHbCTVak5nFWs1KfF4dWTfFXaIuMcagAG3EjM9x/FUPkvXhWsCFADm6twD3wCW686zewl1M48tjlYKfTveUxI2BoY7Bq6U/GWH0cvG7ODg3VmkpCtu39JfzV71NdkGGdfK4jfC9OVa01KIVPVNhyaeNKLqa2rar7dVEoH3ssymvJbRI43vwzFwIIUVA6U2AApHuEpApgQE4pCkp0xqPJijCXNlT7KF7mXLhN5b/Mx40Cjvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Imr/XfhwElG9Ewl5+0wysTitlhhtSJ1MpMStdMmrFEA=;
 b=egKtmy4CFMyF+A+j747teI5lYP7s1DCk6VDxjJOQZpuX2KnmPY2bzG9HW6EXQsR0dt5sJhXHHO5Ln418j5KsTwQx1az9k7xuDMvT5cLrIVQrxRPduOD4XBgMRNxQcp04GSJyezOWPrnGCqDfU6jSgjCoFYVf1OILRJlIWWibMQm1s9hfw9khiju+2chJTEdNeNNmer6rGQh2VzVqpdENrue1OuuHhWzLEfYy3qeWpkfaVo2txDhW2WjsbADoNWZdH2QLfSoQiZXp8/PalcsT0VEaUz3dgz/IMDvxgoGGMNx5GfLN798cl22bVXSwM1DCVukgOg1J6+iHupbVRLuTkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by CY8PR12MB8194.namprd12.prod.outlook.com (2603:10b6:930:76::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 12:27:04 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 12:27:04 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Sep 2026 21:27:01 +0900
Message-Id: <DL5OICH9XD61.2LWT081VGN3N6@nvidia.com>
Subject: Re: [PATCH v4 10/16] rust: io: register: make register have a typed
 base
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pci@vger.kernel.org>
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260901-typed_register-v4-10-5552b1d59525@garyguo.net>
In-Reply-To: <20260901-typed_register-v4-10-5552b1d59525@garyguo.net>
X-ClientProxiedBy: TY4P301CA0046.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::18) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|CY8PR12MB8194:EE_
X-MS-Office365-Filtering-Correlation-Id: 807af4eb-f0db-4307-070e-08df09b6a940
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|10070799003|366016|11063799006|10067099003|4143699003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	qAYp1ZvlsnlG2ZFnX4RBUJsCHJF9aDY0ahlt1N305slpyuL408cU03O55AoWQqZMvseW1e9bxIyeIJi8UT3dA8yThFZnLnpXcm6j3HMo03RIhLRxSN7y2QBnAVEDxwTsX10XW8edUBkwjacALF6VKbOwigLfG4kUDQ/vRcv/boJH5YDFj62UJZna8nM4mX+urs4uOxtZIXOAKhKrJsE0TnGnKvUPDvcCqhhx3HbTk/aY6Gs5aHm4/3eUQdW7Fco9ctR3uGDogqYAyr7FpbyJYQCKDAsjWE/PeJ3NAqzYWOMNfGmFnH4OrAnPNWUiPPpHBX5XoH030Ftv0BHYZZYK7ElrD5dadLifupnkAAQ/XzpUIDPHTasrJKx3HRMTS9Ntkaor8793rj7wWtwKHHIVpx/HsiTNpR3+IM5pRLeJPo09bn8A2rZD2tJS4oBjwnH6mwjrf/EBRzLlmkk4ONYkYvGfzs2WuqPR6F9BxqFKKz8/8taO9786gX25jC+7Jx5emHBEjxMXkybGnFSXG9+3mwLHuv8i6pwSYVV/4srlWcVyYW1sNG21OZVe7ZZV3ILREtrcHvN7kv74MvOpOrm87c48Q/0B5ApuCpZCtC2X0796OUQaRh+/kOH9bnThm913w0RU48xHsK2r1j6swUh76bNTx33YmuQ+NcwSrBUGMac=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(10070799003)(366016)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YW5vSURDV0I0NVF0RmRoVjIxUCtCYzJ3dDNiaEVINGdGalBOYWRGQUs4Q0w5?=
 =?utf-8?B?MEY5ekdta01RR1RuQkRQc1pkRnhaVWU2dXQwclRIdXJtbjBldjQ5OEhmSlVJ?=
 =?utf-8?B?ZWI1RFRtTmFlUWROeE9xSVBhZjFFRGp4VDBEQ1Y4RE5PbW9RODBWaVJaTk9P?=
 =?utf-8?B?Uy9kUWRHUDVoNGZaRzN1QWVucXBka2E5UWtvVkY4V3h6d1BhQm02Q3dtQk52?=
 =?utf-8?B?T0NObVUzWGpoVDYwL1hXd1hsZzF1N3ZVT1R5M3J5MENjUkNTRVFZNy9iZmZ0?=
 =?utf-8?B?Sjl3M0ZRYVp1clQ5YVlwUU1JN1V4S0J1Y2wwZXBIZC8vajdrb3pmbHBUS2RI?=
 =?utf-8?B?VE8raDM0WUZMNVhrQ0t5WWpQNUNtQnJEQ00rSGVwVVpnUXZDOUhvZVA5V3FP?=
 =?utf-8?B?QzNhTXNEcmpaS2hKa3VOZUx2WVVKV0JHTVhXcC8vSUNVNkNCaXhVNzMxaTRv?=
 =?utf-8?B?WFFBbURFOXNJaFFmN1lFODZjZ0k1a3lPZGdJdXZFaU1xVkJDbFR6TjZlZDNX?=
 =?utf-8?B?U0Z4SVRpcWRaU0plbE1NdHlmT0xMWkFpd2lBTEQ1U09BV2dHMU5YNmJqeVBG?=
 =?utf-8?B?WDR5ajM0OEkwT3VTYmZiMndmVFFVZ3F3VjFVSUEyZkVsamRoUFFMak5XUFM1?=
 =?utf-8?B?YUVnWTNXWUpxQjdjdThmMmo4WFBHUUJxeHRiVW9nV21oOHpIQ21NRHhROWZQ?=
 =?utf-8?B?WHU3amhTeFNjUWMrcmVxNm1XTGU5d3V1eDhSeGVHdHROOHpSSTJ4WHR3Q2tp?=
 =?utf-8?B?dTdCRzN2ajJTTU9Wdml3ekJ3ZHhhUzZqRUd2RlFMZmdpQy9pM1MrSFRFMm5M?=
 =?utf-8?B?NWFCckZHOVhhVzl5M2ZHRHFsTHdXMURXamtqRUhnVmo1VmtmQy9wRGd0TnVJ?=
 =?utf-8?B?STFsUG94dVBBNFRrNzIwaFRDVWdwY1FJbDlGaythYTIxQ2ZabDByNUt1bGpo?=
 =?utf-8?B?MERDRlg2Nzd4dUdzdVY5OG92WlVESVM0ZUppMkY5TnUvZ2hHVStXdTYxVVk4?=
 =?utf-8?B?RDlnUktKMk9aeGY2SllkN0JkUmJLNmhLR2paZjBmRXZBeDM4cnNZQ2lHbXlC?=
 =?utf-8?B?SFFtUzQ0YXpQanM4NDk0WGlrTGxrSmdjbTFuUGRscE9RbXdiT1JNdVpET1JC?=
 =?utf-8?B?TjRMOHVlbGREYThhQ2JXd1pUclcxdWE3Z0NJNURPWGthRm54WmxMQXZTcklQ?=
 =?utf-8?B?bm1zNkxKRWtIenljMWRqQURXT2gybldVaDAwM25MWDFTKy9ER3pVR3FLL0JL?=
 =?utf-8?B?M2p2b3ROekdJV2VPREhPbEkwN1JWOE5hT3V2ODRjSGV1NTRyQ01XOG5EUFhn?=
 =?utf-8?B?VCtzYml3OWVUVTBFYThhenl3dzVjaUdMQjl2VHRvR3Z5RDZnTEZEWGp5OERG?=
 =?utf-8?B?eWNpUG5rRllFVHNQQzhpUGlOYm9Xdk5lYjBoNTNlREgvSTNacHJicHc5SGtl?=
 =?utf-8?B?VEtOUXZCeEd6RHd3bGNWbWtLeHZnTXpmMEhkbkhIUmxLQlpyR1Q0Z1hPSFVK?=
 =?utf-8?B?bGllUFRudTFEdEJmeFZNWGh5T2U5eDdwdllsTkhVc0I2cldwY0hWN1c4cHp1?=
 =?utf-8?B?TWswblZXRCs3bitEeUltUkRVcTdyZmE2eUtwWmcwQ1RhU0pVK3BvSFBndFFr?=
 =?utf-8?B?czZjc3B4M2h1STNkZFFzQ21ZSzNvQndhQkVvTGVNUytiemErbnJhb1NaODVj?=
 =?utf-8?B?REVvaGxEZ015K01uNkhEelQyRFAzN3diSk41d1VhM0V4K2toVVIrdzJ6ajBZ?=
 =?utf-8?B?am12bWd0aXJiTTc3ZmVib0hGd21sWDliaFYwQThOQzdmUDN6ZmFvcFRnTG5n?=
 =?utf-8?B?V043NnJwV3Y4U3BtYVVqNnk0T0cwMFJGTE9iSzNhUWhraEdiSUgwcHZnUkFw?=
 =?utf-8?B?bTRRaExpWEtpMXBUNGZoSUlTbWVOZ0VXZ1NmN3JVMHNlVG5haHk5TE5VYzJq?=
 =?utf-8?B?YzlmdmpwQ3lWYVhPMkhZb00xZmpWSHVVMS9pVnNFcGZqOVQ3Sy9FK3pQNlFT?=
 =?utf-8?B?QVF4OE9tUnpZa3FXNmd3SlF0WGlNcmZHMlJyM1h2bjVZTUdIUmNIM1pZZ0R4?=
 =?utf-8?B?YVJUT0ozTUNXSDZrVlhwTVJ3SVZiREZDVDJUcnlNQmZQc3QxUEV0ZmR6ZVh6?=
 =?utf-8?B?NVFFL1V4U3dma1k2Yjg0ZGR5M1M5QzVyTUdvaXdwRUMxMjVMWmJpdzdqZ2hB?=
 =?utf-8?B?Z2lFT21aSXdhQnFkNm9vUXlwQjFuOU1XZ25DZFYxMVR0cVhvSXlubW9OcHJG?=
 =?utf-8?B?bkZpYnRGRzVzcWpTbTJ0cG0wZEpSQksyN3hxajlESmE0dUpLSzN3OFNicVds?=
 =?utf-8?B?QmFKVkVkZUpDa1BHVFdUMTNxT3ZadTlaSzV5K09hNExZeHY0ZDRxL3g1cDBp?=
 =?utf-8?Q?TICzB5p1Qlsg0cgRu7+fi2gLyEIucInUjoQt4XSOO5Zx6?=
X-MS-Exchange-AntiSpam-MessageData-1: p7h4Ak9TgFn75w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 807af4eb-f0db-4307-070e-08df09b6a940
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 12:27:04.0033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0qzGzWHH6KyMjzBlXTOF4+tBPLVxEbYZLTAzISWFGAY/txptveL2woNymC7gGokvmZSCe27SvBdGK71bmRNtDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8194

On Wed Sep 2, 2026 at 1:50 AM JST, Gary Guo wrote:
> Previously `register!` defined registers can be used on any untyped I/O
> regions. With all users specifying their desired register type now,
> propagate the specified type and restrict I/O access only when type
> matches.
>
> Also, add an `io_project!` example which is enabled by this change.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
