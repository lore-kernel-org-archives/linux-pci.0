Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010061.outbound.protection.outlook.com [52.101.193.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7F4499F3E;
	Thu,  3 Sep 2026 12:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439762; cv=fail; b=uMcgVIerZlCkD/bR83mLI3ry6suRWYj7vikIHPwR2x6GTflyxS+XXnyuCacLUg8fKgxz/q5ZzTEyn+I2KjvQPOLuU8Q2TFmtDa67e8Z+N+cxrZp07sEZHHXwBebRBB0D3Z+POnr8WqGTH6yWZliCEenMwdQwqfOi4JpMVAGVHCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439762; c=relaxed/simple;
	bh=3abOz57N4EazpRAfI9VTnIEbE4rKlqil5SPvlOuvD4E=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=T0sdCKoO5R9btoRmcMBc5yV/fsuTGJJ1L+EtLFo8P5oSd5TUKOTOF/FRZKwYqqzi73Wn4iB8wvbafJxeSHIl9UnMzQsVLI5uKf+KdzTa8Z1/JWv4eyvbuZW4xHtv4ma2GeNDvBLi9uMWesG5dJKsQGFDwJIlI4bA73Qct2DSlmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Cdj9V1Ox; arc=fail smtp.client-ip=52.101.193.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cdj9V1Ox"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E4M5pjc2f9anudaORaymvgiNxSUgps0oNnwMhvylc7Yge2rDxi6UAJR8DOoZMbN3glHiGLNOFUJMVLgjzB4DoboQYZVx2vBQCbJ+FAGn6PR+enGFZE0GQLDlJSysIi9d7A7QGbePjOyz06nVe3E+URFjqzcIhcl61K1Mb6TGRgNABKFrfkPBoxAam5OpqRtnVrr0TBgZzMoDejvV+4MJhsxmE/c6Lk/T8hhRyi4tsDVVGcaCRaqw27VkU58UaqnqC9T5YNlZFqmb+9AjSmPGVYwwg50GxV459rx7Wl27IzWyFFjs31DNvgRGmQEmY27yXS+dgVuzXI7l4nFhMxaD6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3abOz57N4EazpRAfI9VTnIEbE4rKlqil5SPvlOuvD4E=;
 b=XBO/fQtxW2NgKlcsYm8zpRcIgRHw+JVGywz5ieH5y7QTTu0cemIa13qez3dffX95483N283DBVMCD+mmBdqZ8MleLEQLTN9bWR7HxwZNZZCnKz96rxk/r2euIfSNnowu0huSuCnyo2c4wAi+dUQziGrV4HMeXwaA/3bvzFKglKnXhRlcNp7yXkwy3oYWlxW8vVCVl//4LXmfVmIJKBforiueAzAhqRoMnFMukw5Tc7TgzE35MWuBpYhnLxQGpXZQOD52JDQ9xY8pCJWdVEM3rhsNluEryKUaq3TDwAKQltbhvaYo15FvqUxDirffjPhHu0Z865xN/ZGu4As4SIrirQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3abOz57N4EazpRAfI9VTnIEbE4rKlqil5SPvlOuvD4E=;
 b=Cdj9V1OxuV4liPPpCpE2IkV/dya7tJuvwvXRBVbW0JlD8a8dFr3shxE3j4b6pzGqACBIhI8g3t1zmfcNtBWJXSN+aMPdgFv/6+Oml5Sn7IkQ/D6Wf6HAnD9YTu5jgLo8aCvnBB5PThQdaEwOyxbTAQ27mwoVxH7lneMPl7fsEv3rOwAK+NZiu5/d5AQUavzK6xdXV42KFBMbC+hVzXoKkrb4EoVnJoFdNaBGErFHlM31F3OEnZECkeSISXgFUHfua84R6f3ACXIS56YrmbM0mFyZK281nHsdJxodMZuTlGBhiEMVt7OL4Er7lJMsZpYjy8Ffv1js760/hi6K9q2HeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by CH3PR12MB8354.namprd12.prod.outlook.com (2603:10b6:610:12f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 12:49:12 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 12:49:10 +0000
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Sep 2026 21:49:07 +0900
Message-Id: <DL5OZ9NEXGR1.S7ZYQ6NWCKYO@nvidia.com>
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
Subject: Re: [PATCH v4 00/16] rust: io: support register projections and
 remove relative registers
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Content-Transfer-Encoding: quoted-printable
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
In-Reply-To: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
X-ClientProxiedBy: OS3PR01CA0006.jpnprd01.prod.outlook.com
 (2603:1096:604:dc::11) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|CH3PR12MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: 68c552e9-6f87-44cd-3d15-08df09b9bff1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|10070799003|366016|11063799006|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	SMtg+p5T36xqRT+Q/NPRctatjFPV97ILld2pgK/zDH1TdWRn7xoXTMAsR2YNlMWcAWo+GcU2w9snZmZubpVzDF/kUeSrkAiL1yjWsMdRFsmWtdcyQmbEA6ia1gSLl40AXi2cnFxoPFt3QeORjf0KBe4p1LaCUVuGGF4WvnjcjCgB91RpUrvLGVlR0mYsGKu2NxacPl+FCvmNGofGceg5a8o0VeBPtEz/ZNPp3qtQ8U6fKUHhwsGGXlXjdF+mwr+HxpGy++VPuTuBUVqk7abCY5zmtWmXwkhVBnZM+juXa3TdnWF0cKeo+KbBj+Qw2mE08TfSsJgiLmXzlVL2gYesxIV7ilnb/oEr1ANm/yw0wJVD1JZn2hFnFgRv2Sf76/s/dyqWYocuZDLpeUv90GdozBeDW8pDUOw8dJ+3hLsk/w2z6TbfCeOGLUWxizevtqYiOAxtjtz9zs2NyKqJXP393zqllAK9fXbY8LBlbV97aHdpn3NSRmCFdTPFwj1vNaz5R8c+pjpeW59iUf4dKSaI87Jaz7Z+Fik2ys07OouL7BxKu+U7OUQr17rXIqwbZ1rgCUHip5DWehLJT/whu0uSnw2vKR310njAuAdSkjzFSoK8QGDa/H4R2Bh1rSdpkj4C4qUVDTOIPExYp3Nl1qmZSFfkZ3UGK4CD2cJd46FNJVw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(10070799003)(366016)(11063799006)(10067099003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnBRQnR2VW44QVdLVGx2UTcxNVgwTmNaTDhFeVFTOE9CbmJDNHlkWG5mOHEy?=
 =?utf-8?B?VGxUZGJ0K0pTSi9XSThkaUdwZm9vYlF1UkkrY0N2N2ZmbE9NSmlGVjVwM0Vt?=
 =?utf-8?B?L0lwZ1RqOFc2UWVZekwzdTNrMkFsNjVSdjkvWDhFNXQ2Ui93VU5vOGxWb0tk?=
 =?utf-8?B?bnFuYWxXbHk0a3ZveUwzNTBpRHREM3AyeGVtbm5HZW5IczdsNlFWNlp6NDNI?=
 =?utf-8?B?OFZtOVBjYjg5ZWxJZHZKeHZjTEFENzBpREpUU3g3U24yVDBsWDQxaEpVOE1p?=
 =?utf-8?B?ZEFKTVphWWZXY3dmL05FbFdNQXFJNnV3VTQ4cUlaUkZOTi9IUUVVK3AxUkQ1?=
 =?utf-8?B?UHlPUzNnR1Y2VWdXaG1jY3F1bk43cUpRMkVkQ3Z6ci9TbFhCSzBNRUxLYll0?=
 =?utf-8?B?RFkyY1FRN0U1cVJSWUFlRjhxZG9DVnc2QzlXMmdMTE5yZlc3eXp4RWt5dE5p?=
 =?utf-8?B?Q2RRWU9qZWxHVE80T2MxM055RUxUNXhVY3EwdG1OeEtEUS9jREN5TlNYVCt2?=
 =?utf-8?B?L0dCQU9EOTB0R3NmV1dKUWFDVGwxNSt5dWZUdHl6LzlBcUNWaUpBQk9NL3ZZ?=
 =?utf-8?B?RG9IbVpnNW03QnNOOTVBOG9peEpmMG9sMXUrRTF6ZFJXZUZIMTh1L3prMnBy?=
 =?utf-8?B?MFJBS0FZcmo3UFNPWEpNZDQyYmJrT3VrajdGMldxQXVKNExsT281Ri9hdk90?=
 =?utf-8?B?M2JtdmtFZVkvSTlTN1UvbitaTE1SYVprS1ZtZHRQL1R3aFNPekpyZ2hncmZT?=
 =?utf-8?B?ZVZtempQRHlBWktDT2J3MEQ4TmlrN0xmWlQxbmVRU1I1TS92MVQ3bklkc1NP?=
 =?utf-8?B?aUoyTlJTL1F6MzEvUGZ2ZkpDZkc2SWZtNEJ0TmRVRC83SitUbWJxVVRTUjJQ?=
 =?utf-8?B?M1VscjdkOTcweHRBaU5CclFBbkFzTmhxQm42R1RQUTN0QlVGakdiaGp0ZVpm?=
 =?utf-8?B?MDNCTGlWbFAwRWpFaG9hRk9qUysyQVRXNjJJY2xVS3d2YzUxUDVzN2wzbFhv?=
 =?utf-8?B?NHVkd05McEFxMXF4bTRJcnphTVlQZG1nSW5Wd0JZcHMzY1lPSTJkVTZieVpp?=
 =?utf-8?B?SGZ4azFKS1VmZmt3bW1YZnB1Sm1CYnBDeUtxYVg2anhnTkZHQWQwdGF0d0Ir?=
 =?utf-8?B?N1RPcGJPMmRtdzh6MThOUkw4MGYwMEh3emNVaTI3TkNQUEZlM2JMWWprOWpZ?=
 =?utf-8?B?b1hVV2VERkNrWFRadHk2NmNnNVJXYnlYWUtTc0tZQUtDRUl4UEtvZHdKWnJr?=
 =?utf-8?B?Ty9TcUlmY0N3NHFUNlRjdGlMYmRaZHVQQUpTK0pzNmdHL3c0dzNrd3Ftb2Zn?=
 =?utf-8?B?cXdYdWQ5bTI4TUkzUTcvUFJTeEw0ZU04N1FHb3ZNNkVpaUNZMk1hVk51NkUw?=
 =?utf-8?B?akI4V0pWM29NTytQUXZqV3NLWldOQjNWQXNuS09aRThtZ20ydXJ3SnJ3OFZ3?=
 =?utf-8?B?M1k3WGpteGovRWpoc2ZGcHRaT1J3THh6eUxscTU3bE1TYXo2Vm5zTVl6MlVY?=
 =?utf-8?B?cDlqYkhBVHU2eDlNeVdQOE9ncTZFb2xjbGl5NUtaYUZSWlV2NE8wNDltcFpl?=
 =?utf-8?B?UXBHZ1kydXk5SzZyU0ZKaGpndjVtSHdSU1VzS0VaaDRVSVRFQlRQT24zT0ph?=
 =?utf-8?B?Z1JyMStlZG5BNzBhbzJ4Wlc2UWNnZ3IwQk0ySUxUKzlkQjRxMWM3VU5yQ2FJ?=
 =?utf-8?B?WlNNalRBWWkvMExjY2pNbmRvckdUUG1FTDNYQVZFNVp5WWxJOFVaMVJFQk5u?=
 =?utf-8?B?VUI0L3g0aGk1a0Rkd3FjdFdFY0hhQlZYSXdDN3J2WFM3dUgzMEVmSU5VSjUx?=
 =?utf-8?B?NFNJa3djY2Q5bDBYYkpoVXpuZ2xOV3RuVnhnTGR5UmwwSGNkQmFJVzhjTEkv?=
 =?utf-8?B?cmJkUkE1enZFUlBCUTc0N2R1TVBLLzB4dmI0ajMrVHlTdERacDRONVY4cG9E?=
 =?utf-8?B?aWdtSm5OMjcySURoOFEvOGxjRjZrT01XamNBbDlBYVNHQW1JY1RnZk8wYVhT?=
 =?utf-8?B?ekRic3crR1lxemI1TE1MeHNsUVk2eG5nN2ZOSGo5MEdwcmFpUDJHZDdqRWl0?=
 =?utf-8?B?ZmlKeDNaL1Vmc1RGanlkQjVmRWtMbytMNmtxU3dMVU5WVlJqMU9HZWdBc3Bv?=
 =?utf-8?B?V1l2THBHN0dCRDBWTGx5MXYvNVVLZitHN3YrMmdSNTQ3bytEaFFOanU3b051?=
 =?utf-8?B?dXRvY29xQ3ViNnc3RXJzRFdGN3prRzU4bVZlQW94bHFGOCtKelM3WkRIbmlw?=
 =?utf-8?B?QUtFSkVVWjB4M3MvcTd1eTNrT2FJK05meENXQVk1S2RXcjJQak1CTXNVV0hx?=
 =?utf-8?B?SnloOUVVam1YWnRtWkRoTmVQSUNWbU1SZGlDaElIL2pQVEhzTGNhMlBOS2M1?=
 =?utf-8?Q?xB6aREnIfqeNuNH79eAsLDSvUZHFL1Ku8vdzyaxyFmSgv?=
X-MS-Exchange-AntiSpam-MessageData-1: +Pkrh8MsfnTo/Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c552e9-6f87-44cd-3d15-08df09b9bff1
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 12:49:10.6166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7VwATTK9fSYLwj2y4H6fAlTi4iSnyfCm3E/8N6aAO6b8gAkt8fwZL0xg5GhbrT1UQkEuB7ufBnJpl4d2GEtpcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8354

On Wed Sep 2, 2026 at 1:50 AM JST, Gary Guo wrote:
> Currently registers work for all untyped I/O regions, which is not ideal.
> It allows registers defined for device A to work for another device B and
> there is no safeguarding at all.
>
> Change this by requiring a base type for registers. `register!` can still
> define registers on untyped `Region`s, although users would need to do so
> explicitly and supply a concrete type.

Thanks, this has come together really nicely imho.

I did a quick patch-by-patch build and tested the top of the series with
Nova, which happily booted. Thus for all patches except patch 8 which I
couldn't test, feel free to add my

Tested-by: Alexandre Courbot <acourbot@nvidia.com>
