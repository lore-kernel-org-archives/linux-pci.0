Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012025.outbound.protection.outlook.com [52.101.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FF93803C7;
	Mon, 10 Aug 2026 09:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786354383; cv=fail; b=cH06yq8a6yZe7U4G/DYSOX5Lr8u7HOLPR8d+zzWVoXhGDuw8vSfVEuidzMhxF/RIc0gpV8/nZdtRL7XcIbdenkQ09Lw04MLaR2EXo7AOqWm8nmSbF5okyon4zzZipk4FXgwsHAr7t1trEwJIi8NF8WPYjO7b0F0WagaJxO9aDkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786354383; c=relaxed/simple;
	bh=5UqMiB07e6wOaNYJ1+dDQ4EKskQ1dPOKD2lMnThZ3FQ=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=qJKvrlIp+btVQizJutFaE+U/K7Oy9fvVS60U7IvRLhTTI0qJ/WBRQyiLG84bE6YlCLPo18eAsMucCR638Y0iWZoTgBu08mhf3gnKZACPVGe24cAbS39EwsCyjtoKGq71MjEgsWHuRpin/mXsRHkPeIOKHkU9skHBw0YIoPL2D/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fWlWj9a0; arc=fail smtp.client-ip=52.101.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fWlWj9a0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZYrcXRgVhKQoVYvQyCToUbe02EbJpvU+XpX1K2cYWCprR6TCwMqRozQVeTV37L4wCavdeu9RcyJLuAx1WunxvPz3uZs+BYHqYWdG5cyunBP1Me8IPwiAz2bPLEm/tFjEcJxmB/J1lRVxwJEqEkQddj5Ams0ihCEb5Gwgc0lP5W8wwS1YN9mIxq9FEbaI8Zf1GkrhXXlPTKuo0lLQIX+UYTOYl/8CMbhEFJyW/XAWNzQfOKFjej5XJvarWIKzwTU1hozxFSBG8WKqot9n6F+7xOLvOdwhYEiozEzNtXTD135r8aLgS25/3aYjC8UalRp2RCaL2z/yY8ceX54YupsGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UqMiB07e6wOaNYJ1+dDQ4EKskQ1dPOKD2lMnThZ3FQ=;
 b=NtapI0eU76hYxCrFYTwsvysDElyUBBMOecWyHTvs1r9WtgVLJ947c37diEqp8/+DEPPsorSmR+y3ztZVwdd7ul3xz0uqBKBAeTp19stOKifHXteVTfuNUmKpxM4KYVFpkF8EtI2ioOXc20/fn2ZSoEkKyNwl591mibx8uaqc5XxjXJQfoYhcUfu/nwQV6MnRBDf1HADvsig7udwi9Il2WjZAiE9XI7MEmsbr4zShjgmOODloIcTP6rz/W4l5uPurAiDH8DfnPtvXkoJIZZgquiTLIQTtAn/sCwcuV3zGS/7kLtONzz+CG/6WgcLVD2Cp11c8KMqUmO/D+GqXheteFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UqMiB07e6wOaNYJ1+dDQ4EKskQ1dPOKD2lMnThZ3FQ=;
 b=fWlWj9a0Zj2TEXEdWCTuSIt+4qPNYGahOGVYYrdi7tB+VW8PbhZgnTJbljMMOPleNdFDyP8gRCAltQjWMmu6mJka0FOYhSSA+AV8h0381jCOuRmb5aIfCTjMYBc7qG7rfAW3g6DNbxHXMrt488N/sUShyGYIiTP32mCILmiuPmOeXf92rFdr4n/yuFAUXoZYiJ9yxLPWAfNgmw58EIT7HTMsUOSd1KUfufyGL/ThReoE5/rGT5B1wSDdkoZkyHTwhGSozG8TnBeOCTqSG3R5WqjR+4oRWBhg1agk/C5nmwRQpK35hTmyofFU0xykXma0VSYwD2tk8gJ+d5MuBsnWJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Mon, 10 Aug
 2026 09:32:58 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 09:32:58 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Aug 2026 18:32:54 +0900
Message-Id: <DKL5RYI8V8GH.2X3FMJUO6JYHA@nvidia.com>
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
Subject: Re: [PATCH v2 06/16] rust: io: register: allow explicit base type
 specification
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Content-Transfer-Encoding: quoted-printable
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-6-c3ca142220a0@garyguo.net>
In-Reply-To: <20260805-typed_register-v2-6-c3ca142220a0@garyguo.net>
X-ClientProxiedBy: TYCP286CA0127.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN2PR12MB4175:EE_
X-MS-Office365-Filtering-Correlation-Id: cb89a51a-f8c3-49c2-55ba-08def6c25d08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|7416014|376014|1800799024|366016|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	UFriqu99/fcS7gi0FuyZ11QUT/xuUueVxPf173svdvU6mn8/h3YXgZbEpsOG6AzyH2OiRH0mbCfVcp4fR7OHFnOJmbRz0YZ9pdUPQSwSUniwGGkw08wAtB9akXaFOR6m2t1PPmkAmR2HP3KwfLT3ixZ1SVisoC7RY7UOcEbzt5UCl+Kz+TcfXx7qab1Hwcw2w2rAr4ZIN29lDoIKCTJ26fb+fRJzAtYXpooyWcLd7A2DOS8uXgZoSW8T+F6OL95UzERHjfck17RgU7Apw7yGexnuJwxixua8lEPyaseFBKK4+bEEwIQI0KP9TgJ3xaTbZRMEKVtunz+hoU+MMRYf/mvbJJiuNrPgVvgcntrz/tjjV3/98uxnrFkKi5CelyBIpLiDjxqvYsJLTjEfwRCt6nJlTqa/FsJsdscaZBNUWmUIJ9d2u9XCTlfWos/06fUvRucYKP389bGtWpWVmOnEiMtlTSQcMCMMc5/dx1Gytl/qYQ4o8H2Fb2EVKW8bTe77XEaQSKAoYS0ih3qmGNJPnhCz5yzC31MKxFYm8VvFEAwrE4/S+wG53L+vgG+ovvjmvGT/Q/468MQjjgOCOyZy8Lkw30RvRgedUAB9+xvxqOwTzUUvOMnd0hdYq9JjuxfkT5/sX27dNlUjfX+zwEIEdrjgNNltyhyE2ZL6M1lJKQI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(7416014)(376014)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2hmcitJN29yOXdJT1hya1JVeUhsWld3YUhuSkJjWU91bnpmbmZUM1ZwU1B0?=
 =?utf-8?B?OUtWaktROWVKWFAvanVmeCtYcktnbEJKV0plSVlHRkJtd0NYR2Y1dHc1QUoz?=
 =?utf-8?B?Q0lidTM0SlF6N0R4a3RkdlRDcFVDSU5Kd2ZES0hKRmx3MnBpcHlCSDhIOXp5?=
 =?utf-8?B?Sk9LbFBvV0ZvMW81Yjk2alExOHZEdkF5Q3NPcDU4aXM2cVp3R09kWThMdG9r?=
 =?utf-8?B?bUU0WURaV1BFdUlSNCttVVVjcWcvcWk5anFsZHQ3M2Y3bGNoYVpGZVU1Sm1n?=
 =?utf-8?B?R0J6bXBmNVp3amFTY1BnMFdYVFNxTWM4MVBuY1Y3ME5jM04wbk1USUloaE1D?=
 =?utf-8?B?Zy9NV2U3N3VjZHF1N1JLUGdzWEQ2VWRZcGxLZE1HK3dzd043M05kSER3RjR5?=
 =?utf-8?B?SGE1RjBLcVZjV2s3SVBXWFBHM1U3ZTFwOVhrZCtLM3hoakRpNjh3elR6WDlP?=
 =?utf-8?B?YmRzSlFkTjJSMk9OMEFNdy95bVc0YSt5UEVXTjJBazQ0L296TW5LZGtTYk9O?=
 =?utf-8?B?TlJFbUhDcnZteUFHNldMd2hMbWoweHVaQitjclpna2o2bmpRSXhIUXlNa1Fz?=
 =?utf-8?B?Y2cwNi90YXZYcW1wcWUwdHRuSUZ2UHEvY1pyaFdxYzZqeTY4dkZzNVFxMFVs?=
 =?utf-8?B?V04rdThlV0RpVWZ4UHNVV0lkbkR4OGNML3QwcFo2UmF3YkdvSTNXcUN3ZnBu?=
 =?utf-8?B?RmlPdjhjTzlBMDVxVHB6R25Jd01vZ2JHQUI1WmJQb0syMHBvS2U1cXhuNXFI?=
 =?utf-8?B?ZkowOHlTMmJtQktONzBpa1Z2NlFlSWpoZEhGd0dzZnAyZkRKTElnVVFQS0VJ?=
 =?utf-8?B?bTd2Mzh4eVVRK0xpNHhtRXowZXdTaUxWQlhRQkdJRktTY3Fhc0kyYUFITWw0?=
 =?utf-8?B?cGNJcjUzU1NRR1ZYeFNoV2k3VlFJS3VkNU1EaUprN1VmSzJkaHB6MituWEpv?=
 =?utf-8?B?c2pGNUNXNHc4ZFZCNmNuc0tIK1BrSGI5Q0VPY1FHT0VRL0Y2bmFxbHhpNXUw?=
 =?utf-8?B?MHE3SFF4OStKLzRsc2VLTkZiZ1QrV2V1Smx0TjVVWlNNbGs2U3I3S1ZmVUs3?=
 =?utf-8?B?NnIwTGQ1RHZDTjJhWDVOeWovUFMrSXVLbWRyQzVmVFd6ZGpKNmxid2hwR2tw?=
 =?utf-8?B?Q29qanV0Mi9wMGcrZEFtRUZJcE5xdnFrVVoweDAxTXdQbFJzdlFGekZ5d21J?=
 =?utf-8?B?SHJvR3VHZml3Z3dUdThqOENJN2xVOEZjV3UyOHFuQ3c3V0U4aFgwb0VFODZj?=
 =?utf-8?B?V2VRNFNTVmNCbFJCbWFLZFVnY252ZHB4VFZPbCs4TFpNZExKNlhZa3RlZzhV?=
 =?utf-8?B?NkN2ZGNITDFmb01OaXUyTjFBYi9SSjcrVXRJVm9DdnFVeUN6bUlBZWFtTHlM?=
 =?utf-8?B?czdUUW9PMWd3U0VGRW9jNEVzZ0JiZFBuSzE0NHk3ekR0QWFtLzJmcUx6aFgr?=
 =?utf-8?B?S0tmdlR4ZnVXYUthcVM1eVpJWVlNeU5DeERNWCtTcmw1Yy9HWHdkZVlscld2?=
 =?utf-8?B?U2ErYkhxZ2VNUFZHWFFYNHBMN0VKN3hWUi9MUjcxMDl0eTl0clhnWGNPVEQ4?=
 =?utf-8?B?TDBoanFRNmp2RGNhOUt6Y1dqTjRQUnZjS1NGVUt3U3g4eVhjYjNSQXUrMUtU?=
 =?utf-8?B?U0xJQjEzTWcvNWhEb241MFFFYzJHYjZpZFcvTzhiZ3Q3cWhLd21OUE40Vnha?=
 =?utf-8?B?K3NGOGdTTzBZM0haOVprSzV1dUl1QXFzM0pGVWFRRUo3b1p1WFlQSDZGS3JH?=
 =?utf-8?B?bFRBckhEVjR1YzJJMzcvTlFtRG52c0FZRmNMekcrOFQxdm1oWi9lSHIvOUZp?=
 =?utf-8?B?TnA1VS9lSTN5ZGN6bDErTDRPU3l4ZnNUZi9UcHo0QXhMUHdrbGFtQTR2NG43?=
 =?utf-8?B?OG1PTTNjR0RIRno3ck1aOCtKQko1K2J6SHVMZzlva09yZFBNVHk4ODdQWEhl?=
 =?utf-8?B?emdVMHZGT0J2KzQxU1NDbENpUHoyN2lFWDZPR1d4RjRLRTVaMEE0bDJVS1h1?=
 =?utf-8?B?aTQ2UnhrM29GbVVGMWtVOW5RQmlac2VhS3Jzdjl0Z3lNZ3hubHhJMHdERkRu?=
 =?utf-8?B?RGxzblU3ZzFQNy9GV2VyWmtPZUl5RnZDdHl3aUlEVmZQUXQvenVobERibWpK?=
 =?utf-8?B?NTRhUFZiQTlza2tCbTRzTnl6Z2ZNTGlHWGlIQWNZWnRFQUFYa2VKU3lUOVo4?=
 =?utf-8?B?UUtldmx6MU9pOWZSN0llbGtadERhTTdMVkp2ZFdrY2VzRW85Uzg2ekI1RzlH?=
 =?utf-8?B?N3N4TE5uNjVMakc3V1hWdEFLODNEdlhGMi9FSUxQUURTR1lsekF4UkFXOTIy?=
 =?utf-8?B?WDZMaEpXMG1aT3Q2NGZ1dnVxS25sUnpscmY1MnhXMjBFRFBWRkw2T1BLZnpS?=
 =?utf-8?Q?kBZ1DTJwbeNCVa0rGuY8ytegb90zz5mTpNmjqzhfQxMzN?=
X-MS-Exchange-AntiSpam-MessageData-1: c1u91cd6AkMwOA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb89a51a-f8c3-49c2-55ba-08def6c25d08
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 09:32:58.3726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hnO98V2xvdwGSkRAfRJWco+Ckhm0206pZUGQ+iIWaAV+SIdUuyxLETKPtHn31oqT5TswltKoP6EzDpi7nFPK2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175

On Thu Aug 6, 2026 at 1:35 AM JST, Gary Guo wrote:
> Currently registers work for all untyped I/O regions, which is not ideal.
> It allows registers defined for device A to work for another device B and
> there is no safeguarding at all.
>
> All users of the `register!` macro know what type it will be operating on=
,
> and that type is consistent across the driver. Therefore, add a `base`
> parameter to `register!`.
>
> Currently this parameter is unused in the generated code; it will be used
> when all users of `register!` is converted to gain the parameter.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

I did push back a bit on v1 about making this mandatory, but this makes
a lot more sense once you consider that by the end of this series, the
`register!` macro does not really define registers anymore: it defines
the layout of an address space - that you can define register types with
it is just a convenience shortcut.

With that framing, it is much more defensible to have to specify the
type (or at least the size) of the address space itself. I guess we
ought to rename `register!` at some point in the near future (not
necessarily with this series).
