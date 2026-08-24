Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021072.outbound.protection.outlook.com [52.101.100.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16920361958;
	Mon, 24 Aug 2026 15:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787586404; cv=fail; b=Tj5Gff4S8OpKyvxCPBWq93CXnTWq71armeZNfCytbheMTLYQFgg9CDZbeWpGfs25Z4gzCup+REhEQ/f2cSyztPF0zTrZGwC5lDo10YP21JYE85nnfM9FsIhkAsczJ3Y4/lPqnLDh1OgnIFYwbx2zVIwtctwzf4BKLU1JHBni96s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787586404; c=relaxed/simple;
	bh=oXxx0G4oWc4O7e0y9abqssuFPb8McnyuLuczlj4SOLY=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=orZ+/7C5Bqq/QOajoWGhVe0cvvESRKuXyI+lA5azr5UzEkhmjJZNAW044Uztr8h7nEnayUzrTamGwbEhd2oX2hTyatQ821Vww4Si243fzsCU3FuPf20bTCof+skx5ESjn43QCRXrWY/2D0NZxL8YfcSQsyEbrJu14XbKN1saM2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=wpVWDrL+; arc=fail smtp.client-ip=52.101.100.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="wpVWDrL+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rChByGcS6qnVhyKEr6Ya640uWLruhcdLbwDO5Hn+i45j7+D8VV29AQWdv1okCu0nn2s8NM8warHnO96m7e9CesaDOU0YXE5MwR9wAwsZktlkitWjcVSioujgK70uAS3q6AMzx5k2iL3SlYCIXuGgSzqZPESYO+89zw94YGLNxHaCJYVINh34+CpcgEaXeXHGgbgPnmq7I6H7A8rKiTdpTo81Z+NmYHdCHeb/92RrL5PvBm/d3SOcrGE8unuE+hY/hn2KX5Wgg8JfP353ZRIR7j3iFRvTgCJvkf4Sk1r6JFAsZiUmd6vXU8mPXw9ZH5WvWmzT6WXQHpGNdWZuGghlwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wW2fNgT2MexgH8NGz4sqZzEUC0OUZyB2w1d3n9I5vV8=;
 b=o6WI8yadUjq1vmtLO75EnRdeTBsQGdOnaFVapkVTeR6OpXxF0ZszPUxWt2T9+ZntHSizBaI/cxwF+NxCsehP9vPIuVT4yvv1syNX7PtcC1BNzYCDUYxvtBULfZnWzy82kW3B3SLe3mkpPeGJlYop8YzZslcbPU47AvfXA0XJAgDT2Yp9RhYyQIyCWfSgFkTmLXyeSYf24zDxrHVcJJIKgV/de0onaiDipggZgsaJMMiciMIcXJQRGG4YCs4OfeSbe/OK8OxN8oMiVS4o+bOOQzHHawJGvW4XYMWf4+gtbAva29e55OuQnpnL8Ax4fV3HPc2eiuUoGtSFjjSO6zhJSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wW2fNgT2MexgH8NGz4sqZzEUC0OUZyB2w1d3n9I5vV8=;
 b=wpVWDrL+rdsTkxpursIL1EePOfqJIBIf3uPburcmO9SxXDl59HqRV+WRUuiM27/E8sjKZWBp6Mi1rzLEUeAat9uzZTWe3ePMFxKl/uN4zliIBxZv1jemmyLb3N+V/mvS13OqimVCSj2LFBY0GY7nAgFifWrve3V1300E2ygdN9s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWLP265MB2785.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:a0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 15:46:30 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 15:46:30 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Aug 2026 16:46:29 +0100
Message-Id: <DKXAHMEKAJPI.316SW0ICNRS0A@garyguo.net>
Cc: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <kjaju@nvidia.com>,
 <alkumar@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
 <zhiwang@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <work@onurozkan.dev>
Subject: Re: [PATCH v8 1/1] rust: pci: add extended capability and SR-IOV
 support
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20260818084633.1673214-1-zhiw@nvidia.com>
 <20260818084633.1673214-2-zhiw@nvidia.com>
 <DKX0TRYM9KB1.HMIDNZDWMIJJ@nvidia.com>
 <DKX45Q1J5M9O.27TM3TUTQH761@garyguo.net>
 <DKX4P05VHT0E.2O8M39SOVBVP2@nvidia.com>
 <DKX5NPH3DNJR.2MADBU37NMZB4@garyguo.net>
 <DKX9YTDJLJMI.1RKDZ3S28MVQ0@nvidia.com>
In-Reply-To: <DKX9YTDJLJMI.1RKDZ3S28MVQ0@nvidia.com>
X-ClientProxiedBy: LO4P123CA0678.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::18) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWLP265MB2785:EE_
X-MS-Office365-Filtering-Correlation-Id: 8de03de6-7601-4551-cf8c-08df01f6dd9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|23010399003|366016|6133799003|56012099006|10067099003|4143699003|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	aXw2pyfLdYic50GdCXTf5U+Ic+P6DVGuiVSAo0UHF/EyWiNfRDsooF9YZHe8BpMwJ9UUqAwlOrURBLOogo+SseskdPfEoFbPuwbvHzJmQjjCw/WTvrNH8hQDgKatjeLkS4PROrfOwBLn/VHBBp5xkdpnNh0oUYWI0u7l7Nj76RuHuMekZmQ6tCNIQaBz4dX1OOTgBeL3PhK95O5NLqYqfbk3mPOZHszrAplC+sIw7Lmb0sjo5tsPbyAr1I8xIaPSESZx3vS4z3kBbzXZdwxPF+S9HqA3oWSpDVvKGuiEDe5q859Osa6/eKM4wnKwJ5cKrGa181QHlxCNYXnwKlXiJt/4hj76DDRiPqEXjjUa6kLf6TKfx+7aHpdQY7R8iRArwgAIOkqZVn2nbZvlrupHDJnEctICeDMSkW9j3Eu9wQPi3NohowyO3pf9vwoD6s8aXjy7iSRhcKZgVgyTxrB9PcSoPgohwcdXplvXIqChnAqEAk2KvNSYCm4rjltEm3iKaVNmyUdn8/U3CKFWm4npmRAVgMNKC279/Z5BTA13fBhiLWgGwef3AB3s9yTKwW20KgSjU0HDuJ4t2FIKtwM7chgcyXPWKOZA0vB/Qj9QRnBgZ8Vsr4kUbIqR4mwOdQKXumgc6aP5/w2yeHSBRf3eSbdO56zH7YMCGTABXv9VBfA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(23010399003)(366016)(6133799003)(56012099006)(10067099003)(4143699003)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTUzcDVWMEFERFhmZ3pwSFM4WVNCcWh3US9VdDNBUkFJTlFMWnVOdE41ajRj?=
 =?utf-8?B?UkprVjdmeU8wenJOc3YydEk0TkdMVnEvRnh4dlRMTVA3ckVGNmR0L29OQkda?=
 =?utf-8?B?VkVqRkhLLzJvb0RZZzlzZWdnbk13SC9MQ2QzR3NNU3ZROGsvSTlOSm04aDRE?=
 =?utf-8?B?cWZydkdWZWtjSUxoNEZXNDJUcDRGeVNqdytCYjJzYVFIRDgxdmJqY1dVUTBi?=
 =?utf-8?B?ZEpRU3FoTWRzblZWZXJGNnNQamlhNjNPWmdndmJPRC8wWkswa1dudGR0bUsv?=
 =?utf-8?B?NHVaeUtkWlRocmZ3c0VGZXVsTG5VMzgvME5lSktQU3JkVi9Zc0hOdGFhRGk5?=
 =?utf-8?B?MUhRMnlrcVAyeHRHUU9jV09GM2x4VVFXTHhEVmMvVnpoYU1aVTlmc0ZLOHUr?=
 =?utf-8?B?L0dheVNxRFdldFJpSlY0NFNuS3piemx5WDBLMVZheCtVVkZKaGxhbDVPZ3Zj?=
 =?utf-8?B?K1FPVzFqYnZMY2h6eUZOZm5pMmo5WDhndndkeTBFR1NOeDMyeEt5d0ZvNzN4?=
 =?utf-8?B?cVRpVG84UUtVZXhQT3piNWZXUTdjMlpPNkU2TlZNTmQraE11UkU2cVVQTy9a?=
 =?utf-8?B?Ui96dE9iOGcrN2V4WDBEL3p6cUxIVUU2cXpxOU9uUXorM0hKTFlVL0lNT21Z?=
 =?utf-8?B?RnlSL1ZsY1IwdzZVZGhEbk15TGozNTRLQk45d25qbG5aa3Y3amRzZnBTTzNM?=
 =?utf-8?B?MHlybFA0cVllZkhVN0krNHh6WDAwRXkrME1BL1NvdlpLVnVKWjNIczFWaC9n?=
 =?utf-8?B?emJFSHFEdEF2MXFNOVFnSVlLTS9WVEFOWEhFOHBuKzV3eHRZeU1COUljNVNz?=
 =?utf-8?B?YXdlSHBYeWNJanIwVmtQbzRpNDBMNmhNNk5zeHp0dlNMalJNNHR1Znp1M3pz?=
 =?utf-8?B?WFY5YXJEeXZ4VHNUaE9kVWlhdzQwRk1XOUFsRUVPTVNFT1had3hCdDVzNGIw?=
 =?utf-8?B?alhEY1lLNzdJT3FrUHMvV1hRT2dCaGxNMXp6NENiaVRnTVc1dnlJMzlUcC84?=
 =?utf-8?B?Y0ZQS1JGRndEMmVGT2FPZ0dHWFBSS3ZRdnMxL1lFNGt4RVd5dEVrRWhud050?=
 =?utf-8?B?ZkVDRW5BeTVlRGNnQS9SWXRqSmdDVFpzMlhKM1VmNXltcDg2TnNtWlV1aFdO?=
 =?utf-8?B?bzRDSHBCNnB6c3JBVmhHMThRUC9zVFJ5SFptWW9uME5VeWV4Mm5YSG1IR2tS?=
 =?utf-8?B?dEhLekd6d3dUV2ZMQmlqSmF5M1B6SVlubVNuTkFRK1I1NDNvMmVPaW9DYTF1?=
 =?utf-8?B?VkFqejM5YkRIUXE4WnhuYmNyeUtLaVZnUCtBaXhiWVUvWHZqRjZTYUhRekNF?=
 =?utf-8?B?SFZ4cE9zcDBsQzhsN3BEVWxWWXJyVVJBNmxXRVN0ZEczOWFnYUtTbHYwaUxm?=
 =?utf-8?B?TE0xbjd1eGJoNHFmb1UxNWFEQ3N0K3JUaHd3NDlEM3cwTk8vanc1dUpudldw?=
 =?utf-8?B?WlBpS2gxUEVXb3p2U3ZyM0k5OC9SWS90dldjL1NyRy9Dd0s1M1o4NE9iNC92?=
 =?utf-8?B?VGNkZkduWklYejZVWXNJUXA4ZkR1Y29zRjZOZDN4ODFaVlVIWWhYVWwxamRB?=
 =?utf-8?B?Syt6L3dlWWYvODlaS2k2ZWhqbFdQV21RY2M5NVFSYndzYTgvY09BV045cWhr?=
 =?utf-8?B?SnJDNjJZVjRJUk1HMkh2dzV4dVk2WHR6cFFCY2tqREpuTEN1NnR4Um51ekx4?=
 =?utf-8?B?Z1pzMFZlcHVpUjJGQWx3R0dYQ28yUnZFamNwNUJSOFB5MXcwcWhJR3BqZDBR?=
 =?utf-8?B?UUV1em0vZlBYa1UwWUZ6dzlMVWhlUHBKaitUZXNmbmFGYTdBMEhJc3MwZDBm?=
 =?utf-8?B?a1VOQTY4amZ4dUxGd3lpQWR1OVBld0hLVjFUcjBZUEVwOXlHa3F3RzBkdXBU?=
 =?utf-8?B?QzdPSDRXanRhMC83Q2UrWDZlcEpwUWJFZ2FWdGQ0WklJK2VpVzh1UnhnMzhp?=
 =?utf-8?B?QzhlMU42aGdMb0NFTnZTZFZjZko5SXoybUpaNThvUk9oUldSZDZ6dW4zQkVQ?=
 =?utf-8?B?TzNKMGtrL1p5T2ZRRU9LaDJLdXd1UWNzTU9rZWNMVEpqQit1dS9qYW5vSUEr?=
 =?utf-8?B?dExrRlY4SG82YzlpcUJsTjhKUDJ6cGlpK3NKbTVSbEZ5SC9OekZZMDhWOHFG?=
 =?utf-8?B?YTB3MDl2Qys1UzlGR2ZUSjVpc24vanVnTGpCendSZDhXSkx1SFV2cWVtOGJ6?=
 =?utf-8?B?T2FYWjdIT0xpbWdjU0JVckVQblQza3drS1BGZWE0bGo3aitUVDRKSFBXaWs1?=
 =?utf-8?B?ZVNyZjk1TUo5OTVGcDFyZU5mYUZvWFJBcFFXTmx1VmVDQU1HQlB2NzJKWXd1?=
 =?utf-8?B?Smd4ckI4aFBYVElHdjFGSnFSNFF0dVJFa1pZVnZaYThCdTBaR1lrdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de03de6-7601-4551-cf8c-08df01f6dd9b
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 15:46:30.2414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LyA0eV0pUbPtcfAe63lzckn5ozaA8ZRb+Lv84rjzm7oVBlUWECkg900WYCabHTiuuyQOXnd1/i6e5ZMrTnhtWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2785

On Mon Aug 24, 2026 at 4:21 PM BST, Alexandre Courbot wrote:
> On Mon Aug 24, 2026 at 8:59 PM JST, Gary Guo wrote:
>> On Mon Aug 24, 2026 at 12:14 PM BST, Alexandre Courbot wrote:
>>> On Mon Aug 24, 2026 at 7:48 PM JST, Gary Guo wrote:
>>>> On Mon Aug 24, 2026 at 9:12 AM BST, Alexandre Courbot wrote:
>>>>> On Tue Aug 18, 2026 at 5:46 PM JST, Zhi Wang wrote:
>>>>>> Rust PCI drivers have no typed interface for locating and accessing =
PCIe
>>>>>> extended capabilities.
>>>>>>
>>>>>> The SR-IOV extended capability describes VF topology and VF BARs. Ex=
pose
>>>>>> this information through the Rust PCI abstraction so drivers can use=
 the
>>>>>> existing typed configuration-space accessors instead of raw bindings=
.
>>>>>>
>>>>>> Define ExtCapability to associate a capability ID with a register la=
yout,
>>>>>> and add ConfigSpace::find_ext_capability() to locate and project tha=
t
>>>>>> layout. Bound the view at the next capability or the end of extended
>>>>>> configuration space. Add ExtSriovRegs and a decoded VF BAR iterator =
that
>>>>>> reads and validates all six VF BAR register slots up front, yields d=
ecoded
>>>>>> BAR addresses and widths in logical order, and keeps the raw
>>>>>> configuration-space slot advancement internal. Since PCI_EXT_CAP_NEX=
T() is
>>>>>> a function-like macro, expose it through a Rust helper.
>>>>>>
>>>>>> Link: https://lore.kernel.org/rust-for-linux/20260804161612.776752-1=
-zhiw@nvidia.com/
>>>>>> Cc: Alexandre Courbot <acourbot@nvidia.com>
>>>>>> Cc: Gary Guo <gary@garyguo.net>
>>>>>> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
>>>>>> ---
>>>>>>  rust/helpers/pci.c     |   5 +
>>>>>>  rust/kernel/pci.rs     |   8 +
>>>>>>  rust/kernel/pci/cap.rs | 329 ++++++++++++++++++++++++++++++++++++++=
+++
>>>>>>  3 files changed, 342 insertions(+)
>>>>>>  create mode 100644 rust/kernel/pci/cap.rs
>>>>>>
>>>>>> diff --git a/rust/helpers/pci.c b/rust/helpers/pci.c
>>>>>> index 4ebf256dff23..b946b14d79e4 100644
>>>>>> --- a/rust/helpers/pci.c
>>>>>> +++ b/rust/helpers/pci.c
>>>>>> @@ -24,6 +24,11 @@ __rust_helper bool rust_helper_dev_is_pci(const s=
truct device *dev)
>>>>>>  	return dev_is_pci(dev);
>>>>>>  }
>>>>>> =20
>>>>>> +__rust_helper u32 rust_helper_pci_ext_cap_next(u32 header)
>>>>>> +{
>>>>>> +	return PCI_EXT_CAP_NEXT(header);
>>>>>> +}
>>>>>> +
>>>>>>  #ifndef CONFIG_PCI_IOV
>>>>>>  __rust_helper unsigned int
>>>>>>  rust_helper_pci_sriov_get_totalvfs(struct pci_dev *pdev)
>>>>>> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
>>>>>> index 9f19ccd5905c..008c2770a3f3 100644
>>>>>> --- a/rust/kernel/pci.rs
>>>>>> +++ b/rust/kernel/pci.rs
>>>>>> @@ -32,10 +32,18 @@
>>>>>>      },
>>>>>>  };
>>>>>> =20
>>>>>> +mod cap;
>>>>>>  mod id;
>>>>>>  mod io;
>>>>>>  mod irq;
>>>>>> =20
>>>>>> +pub use self::cap::{
>>>>>> +    ExtCapId,
>>>>>> +    ExtCapability,
>>>>>> +    ExtSriovCapability,
>>>>>> +    ExtSriovRegs,
>>>>>> +    ExtSriovVfBar, //
>>>>>> +};
>>>>>>  pub use self::id::{
>>>>>>      Class,
>>>>>>      ClassMask,
>>>>>> diff --git a/rust/kernel/pci/cap.rs b/rust/kernel/pci/cap.rs
>>>>>> new file mode 100644
>>>>>> index 000000000000..ddb3fd73e195
>>>>>> --- /dev/null
>>>>>> +++ b/rust/kernel/pci/cap.rs
>>>>>> @@ -0,0 +1,329 @@
>>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>>> +
>>>>>> +//! PCI extended capability support.
>>>>>> +
>>>>>> +use super::{
>>>>>> +    io::ConfigSpaceBackend,
>>>>>> +    ConfigSpace,
>>>>>> +    Extended, //
>>>>>> +};
>>>>>
>>>>> Let's merge this block with the one below, i.e. using `crate::pci`?
>>>>>
>>>>>> +use crate::{
>>>>>> +    bindings,
>>>>>> +    io::{
>>>>>> +        Io,
>>>>>> +        IoBackend,
>>>>>> +        Region, //
>>>>>> +    },
>>>>>> +    num::Bounded,
>>>>>> +    prelude::*,
>>>>>> +};
>>>>>> +
>>>>>> +/// Number of VF BAR register slots in an SR-IOV capability.
>>>>>> +// CAST: `PCI_SRIOV_NUM_BARS` is the PCIe-specified number of VF BA=
R register slots and fits in
>>>>>> +// `usize`.
>>>>>> +const NUM_VF_BARS: usize =3D bindings::PCI_SRIOV_NUM_BARS as usize;
>>>>>
>>>>> The infallible casts module is now available in `master`. If you impo=
rt
>>>>> `crate::num::casts` you can now turn this into
>>>>>
>>>>>     const NUM_VF_BARS: usize =3D casts::u32_as_usize(bindings::PCI_SR=
IOV_NUM_BARS);
>>>>>
>>>>> and remove the `CAST` comment.
>>>>>
>>>>>> +
>>>>>> +/// PCI extended capability IDs.
>>>>>> +#[repr(transparent)]
>>>>>> +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
>>>>>> +pub struct ExtCapId(u16);
>>>>>> +
>>>>>> +impl ExtCapId {
>>>>>> +    /// Single Root I/O Virtualization.
>>>>>> +    // CAST: PCI extended capability IDs are 16-bit values defined =
by the PCIe specification.
>>>>>> +    pub const SRIOV: Self =3D Self(bindings::PCI_EXT_CAP_ID_SRIOV a=
s u16);
>>>>>
>>>>> Same here, the `CAST` comment can be removed if you turn this line in=
to
>>>>>
>>>>>     pub const SRIOV: Self =3D Self(casts::u32_into_u16::<{ bindings::=
PCI_EXT_CAP_ID_SRIOV }>());
>>>>
>>>> This looks horrible. I'd prefer `as`.
>>>
>>> Looks are subjective (or so I like to tell myself), so let's focus on
>>> what isn't.
>>>
>>> What is not subjective is that you don't lose a single bit as long as
>>> you use these functions, and can do your conversions without a `CAST`
>>> comment.
>>
>> Aesthetic and ergnomics is a big part of code, and is what make people l=
ike
>> Rust. In a world where less code is produced by human, I think it's espe=
cially
>> important that code remains easily human readable.
>>
>> You can probably already tell that I have very strong opinion about this=
.
>
> So do I, and the fact we both have opinions on the matter is irrelevant.
> "It looks horrible" is not an argument.

Ergnomics is a perfectly valid argument and often a key factor in design
decisions. Otherwise we'd make all functions carry extra argument indicatin=
g the
context they're in and would require sleeping functions to carry such token
types. We rejected that approach because it'll infect all functions and mak=
e
Rust code look horrible.

Everything is a trade-off. Whether to perform extra validation vs better
ergnomics is a genuine thing that needs deliberation. A outright dismissal =
of
the argument is itself a non-constructive argument.

>
> Safety and correctness are the very reason for using Rust, not that it
> looks better or is more ergonomic. It often does, it sometimes doesn't
> (see the hoops we have to jump through to cast a pointer for instance),
> and when it does, that is usually to improve correctness, not to
> compromise it. The reason we go through these lengths is to remove
> issues and footguns at build-time, and this is exactly what these
> helpers do because `as` is one of the footguns.

There's nothing unsafe or incorrect in using `as`. Your suggested code is n=
o
more correct than Zhi's current version. You just added some extra check to=
 some
constant that will never change, and we know will not produce error. My arg=
ument
is that that makes the syntax horrible and it's not a trade-off worth makin=
g.

When we create new abstractions, we try to make thing has minimal overhead.
Otherwise we'd be using a GC language and that'd solve memory safety issues=
.
Your abstraction is not zero-cost -- it sacrifices compilation-time, binary=
 size
(for debug info) and it adds a significant cognitive overhead for writing c=
ode.

>
> They are just a temporary band-aid and won't be there forever anyway:
> once we have const `TryFrom`, we can make a bonfire with them, and I'll
> be happy to light the match myself.

Well, I'm happy converting the code once we have `const TryFrom`, and until
then, I'd rather keep `as`.

Best,
Gary
