Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013022.outbound.protection.outlook.com [40.93.196.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669203FCC;
	Fri, 28 Aug 2026 00:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787875331; cv=fail; b=Pang5IfKAzaqFBA0gMZBp9F/m+XGBvnVF470cpUW4A7+wi1Xkx+plV+LcOm17RTAAAALCxwCeO79T2D9C8N2hpVlZRVU1S0mymwc5ZqYvQXiZnl0kWvU/AEdxOG6ifHHeIiEVjopp913G4L39pvrSowp1gPKl7/Iw/jV7TNcUxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787875331; c=relaxed/simple;
	bh=HYlOk2PNIceUORAZaNfLnV5+2ida2uGJz1GZjVBZYqo=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=S27fByYGLbmHKlliRbx8Hp95RVOlzNPP/kMD4vxEKTxNgCqVE+Cu2VlpTk8ZGc4vElRu/B6S4O+ZdxDSCw1eO5F5XJMA5jHtFgFnUPR27S2fDUtQJzIw5OYuoJHlmUlsFJirxUotCiWBLYvsBI4LADzrfjjAxQLjiHP67vOU9is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hm/WSmK+; arc=fail smtp.client-ip=40.93.196.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hm/WSmK+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VjOKjcBAEabr3JNJyoPSbTMZx3QU8rJ/BApstYWWxKlI5THZ14OcQgs9M0xDTmT3EJZ3X8ZwGyDGfqJ3r0KYinPMFq+HwHm28h/FegeFm6py8QQmKa4CZKwn0engYECDunESbTIlEM8jdamL5qeilsvq5HzJ4DH1OpNfXwoj8ttipgir0W03WGzJNX7PLvC4HWxBCw1dBZl6thLaSS8g3yHouIGKgvxfLa5FEmtlmOk8EaED6r/zNJeZAzMzaXbRdynTwvnGHqHBGIpxVqupIKOCkiEi7Pv4UFG635byfDZcW38iO/+pX4Xk6FgRzf+oqEKXHJHmKpub2VqdgehQ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucyOr2bHjoL17LsB8zAVeo8ZBWCAjTNm1Zp3LR5uG3M=;
 b=SUumLpVx1p09RCuM6AKE0+m05YSBz8jHNrAlXsj5ENFt+8LuEYAEGtxw486L3lS8zbbz2RygDRbtd2DjpmrhcTpp69oKsdl9K5ZREfH2ckOkInI1eY5RiI6QjQgeCIxCdO0VfJXiPe+aCcDsqjokX/mbWRWIr1GQzQ/3MFuwi8k3N+nA678O+Q8xif6/F6Ir/6chipEohZPTDusHFlrNSZIxPdWYnOWpVZNMJNJ2HX0Bns3zg6yblXozdDHZDhyyCna6ElC+TWwfdY4GEIDAsT89X+2/KS9Mqfu5fXTVBxyuzdeFRI+Yvq3FW+ObHstfBDc4akvFm/0QpyYOnLAEvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucyOr2bHjoL17LsB8zAVeo8ZBWCAjTNm1Zp3LR5uG3M=;
 b=hm/WSmK+S1FMJBmArtYeA/vmhH0IvA9/1xIOE/ZZlK7PXHI+Tmze+K30bvhwDPpC6q6/F8964SHdZ7M9VOp/QztUoWZRvzF2R7r9WeQGWXsHPdb8yepmTHORH2bH4g03ZLDpYJ/MizkOmL6YBwfEfOolL1hTVwBbscjqap1lqt+5eqqMczINGg8FEw6fiHciwdIQ9jC3UTB9NL9zjR7knK/yxHIbe38RdQfzB+n6Co/f2ZU/xq990zzwdnNmyO7BJREVbTy+CwY6hQQGZ4AZ0V6k18ljvKs2TdX++FfX3bJrBMHGNyEdTON4crEtPgpzvoOieF2RbAElK86reiovSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SA3PR12MB8440.namprd12.prod.outlook.com (2603:10b6:806:2f8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 00:02:03 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0315.014; Fri, 28 Aug 2026
 00:02:02 +0000
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Aug 2026 09:01:59 +0900
Message-Id: <DL04WN17HK3U.2P3ZVKRJDOPRP@nvidia.com>
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
Subject: Re: [PATCH v3 10/16] rust: io: register: make register have a typed
 base
Content-Transfer-Encoding: quoted-printable
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-10-3699a75fadf1@garyguo.net>
 <DKZRPYOFOIY5.3RAONSST6MTL4@nvidia.com>
 <DKZSSBO7KNYJ.1YCSZDT87W7PX@garyguo.net>
In-Reply-To: <DKZSSBO7KNYJ.1YCSZDT87W7PX@garyguo.net>
X-ClientProxiedBy: TY4P301CA0001.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:26f::12) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SA3PR12MB8440:EE_
X-MS-Office365-Filtering-Correlation-Id: 6af6b4ec-53df-472a-ab8e-08df0497965b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|10070799003|7416014|376014|10067099003|6133799003|18002099003|22082099003|56012099006|4143699003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	2SKGsOh67eMw1JF2R3n/goDaiK0VfBWcW63kUIVTsu68Lu0IW6kBKDS0h6rEToVi0nabkQ2OpS0IQcixnFU9dIzpWQ3t0EZ9A4MAsl+zsVZQB0IKK1vw8KlKxyIjbj7jHxIzS1u651siU2Bc/kynjIw0uAEDnXzxUrJEeQfocJZQSnVdMOxlBM8WbOXer21rctCGRXhqSuqTiaO+uVdZpZ4r0HTnA/LL7D/lxcU9aYzDvyYu49rU1nXqgUovrWCgqakfracpf/QILVXoQtwB7wgxLJeh3MSyz4xQUqDOghoBhOrHi9LxahLBGxXBEWazY4DzKjbDHdz2/BFtlSGgvtmMdFV4XlYEdFNz3PkhHx7xmBkc/HctfnRRh0/AwNjBLgJb1QUrrvUgNqCrZpzQMpoUtDdp/adHh1WHSwCUQFnh1zmLa+gn6yxY0RO0JPVgy/mzi5HO6ZF3o/m1nBa7f6iuxWTntAVuh8IKKpDMfX2hZH73Dtj37hT7ROLucwGw2B7IM2Fm8SPVFQku5PYSm3sjQ3oHTLtQC1WUWgOvSFOm4d6aliLy9wkyNI79CK5inYhtCbmiqhCGXeB4RvZ/0CEjnXUT9RqN/wpelhYeymFxS0bgXmHlEjmTuHgyxqsaTAXFADHSvMYFu+AaRouvoZ3F85G/pNkmbZR+TGmSmj4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(10070799003)(7416014)(376014)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmJnTGVwV09TOThmdjQzZHFzVFdKa2FtTHBvaGhUdlNPU2lOUXNiS25CUWU5?=
 =?utf-8?B?ZVErVFZhU2VqMnFZeElyRW5vc1FCUGh2UHQ4akNrWnQvc0E4OTFuMGE3bHJs?=
 =?utf-8?B?VGZiNGpYM21YQnpVMXVacXpHQWdLY1kzMm83dWg0ODROV2NkVk9lc2x2VG9v?=
 =?utf-8?B?Y2RWMHYyQXROSHAvRHRoU1VhaTZsYnR0MEY0VnNQQmNpVVplTjh0bURiNW9C?=
 =?utf-8?B?N2xsV3REWUFxUUcxSmZob2FhVUtSWDJCWWh4cEJkRGRDOVB3Wk13UjhkM1pa?=
 =?utf-8?B?NDRWaHJaS2N5ZEwvWXIrL28rRUxScHk1VjhBSmVmUTBNK2dXbW4yWkp4Uyth?=
 =?utf-8?B?NXpYUjc5alNGQ1JpNW0rQVBUZUNlekVhTHJHSU1nZE42bW5Fdm9HV05pdUpv?=
 =?utf-8?B?aWhwYVdzTmF6TTRzdkt3aFZzNE0wTVQ5YWxmYUNLbVlXcGdWSEg4VVh2RS9w?=
 =?utf-8?B?ODg0RGFyOEhxTXJHd0ltWWxDSVJETWtTZDIzK1h3dTJkaWVvR0x3eEFHakNy?=
 =?utf-8?B?R2VtR0NyZWpGTUlvdVJJeEZmZG9HcEEvVUQyM3pWZUQ1bDhheDlyNkJhYVl4?=
 =?utf-8?B?Tzc3Y1dJZWx6TnEveFlaRzhXQTVNdk02c0NQYndVOStMQlhPdkJ3Ylh1TVIy?=
 =?utf-8?B?cW9mUHQvZEJ0MlJHcmhJUG9OeHNuaC94NkVBWUJmbml2RVkxMXFkQ29UY2da?=
 =?utf-8?B?elJhUTdRSnd1a3hSMEZDMXhkd0psREFnM0VLZFFIR3FFaXNFbWwyY0JGSFlT?=
 =?utf-8?B?cUJHR3FWTDVXTHhmTGF4ZW9mVkxKdFpNQUErZld3VGlzTUpyOGFJSnZhWXgv?=
 =?utf-8?B?NFVOb2ErQUlDMnFsZ1ErUFdsYlJKc3N3ZUQ3QkRRSGpiTGdhbE1Xd3dMZjF2?=
 =?utf-8?B?anQyMHNxREJoSkNEK3pab3NibU54cGU3dCtjbXRJVEpTU3A3NWo3RzN6VU11?=
 =?utf-8?B?YTkyUU9rUVFyOVA1NzRFRzdtUXBBRTl3RU9zQzhqM0VOTVhVSlo4Y2NRVUlZ?=
 =?utf-8?B?SVRudUJzMlQ3RGJObjhsWnptZGlRRTRQRVVxQmlMZUU0UU9XNmx5aVpEcVJD?=
 =?utf-8?B?WittUlYzQVZ3MEFGWnVNTG1nUFYwTHdvTUxWRXAxeXo5US9oYm1WUWh2TGw4?=
 =?utf-8?B?VWhxMjBabkFsdDhEelN1ZFZhc0xsMDBPa1NwZEdTNWEvTmdQTXVveXpzaGtY?=
 =?utf-8?B?TkJWTlpsU2N5TUZLUTF5ZmhWdXJNWXJQSXZHRDlyYXdudzZ3bTVPOEZoa3Qz?=
 =?utf-8?B?TUhFMHJ5U2JQN1JMaUF5TmhuaWpxQkUvN3RDbWpqbkUxUDVvcVNCNjJMM3BZ?=
 =?utf-8?B?Mlg4NG8wWXZ1djg4cGVYMjNSM3FrWjBWdDgwdjZyRXJDekV5YVY1Z0sxMVMr?=
 =?utf-8?B?TVhOMDNPc0JHR2JPMktTRWRrbXdZUVZpUWNwMExBRXVlc0xWdFJodU1nR2tO?=
 =?utf-8?B?ODd4V2Y4UXg4dFBuSWg0NVRyTXdxSzAzRGlJWDlacXdUdGRSOVQzS2JRS0Rt?=
 =?utf-8?B?bXVYbUw5dFRxY0dVaGRFalVpUFRCRzhBS0VhR2ZVVjB1L3RXTjJVd2pwNXlN?=
 =?utf-8?B?VkNPNy9CMnRLUGtCUVQycHlDNDN3TXNVd2k0RFFCMVExQllYQzNGMEtRRUd2?=
 =?utf-8?B?MUlXYmFEZFBQYzhBWjIzNkRiTXZrS2xiUFV6czIxVjE5amRBczJUYWVOWGJN?=
 =?utf-8?B?bWFhekRzcllaeGxiSmVrRFpQV2F0MzAwUTB6SmRxbVNNNTVqUHRiZFZWUnVL?=
 =?utf-8?B?T2lFTmFaaEJYd3YvT1JJNHZwa1NaSVRJUU5RQVZzbXdnNG1EcWVZK3p1RUtO?=
 =?utf-8?B?ekpXNHZwb3Y4SnJQT3ZsbTBVTEkrYjVjOUhlRUJiU2FJZ1d5ZThqNnVsTVRR?=
 =?utf-8?B?OTdTWXlTT3U0TFV4S2QyN2hKeEE4L1VYbERwUE8rdGcrV0dBK3VtRENOdlZJ?=
 =?utf-8?B?WVFrc2g5SFUvNWFENWwvMG9DK0tmZHhtaEUwU0djeUJJZ09NaTRhc3IwKzRN?=
 =?utf-8?B?d2E3TTQ5SFIzZ3ZtNHlXdlFaYUcwaExvdHFoNDRibHBKQVlTa3dmS2oreTZ6?=
 =?utf-8?B?Q1lpMTJHZFR6aU9JZkYvUU1yeW16MzJ4V0dRSHdTTkFEREEyOWkveE4wd3U2?=
 =?utf-8?B?TEo0R1BxY1p3VS9iTjNaOUVoVXJpWUh6SEZSdVZLdS9zRUJ0UnVXSlRVYUZw?=
 =?utf-8?B?eUQvcEpucGhRZGJjU3dSbUxnamltODJFcTVwUVZUbDFvWnAzN1R2WnlHOGhY?=
 =?utf-8?B?aVhDOEJmNC9TSFdNZlZHWWdPL29PdmlyOFJCM3VweGI0emFyTmFlZlYzd2lv?=
 =?utf-8?B?d3p3LzY2RUlhUmxRbmM4MmdadGNjdjRrVXQxNlhnUjJ4TjkxYUxEMlZYTjJ5?=
 =?utf-8?Q?oOz9gE4p10jwRGvZeYyueBEfdO1eGV8S0PEHvqLqMsmGf?=
X-MS-Exchange-AntiSpam-MessageData-1: j6zVa0d5YP+HEA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af6b4ec-53df-472a-ab8e-08df0497965b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 00:02:02.6376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a4s3fB6t5/+aOP3ACZk/lCD3eU0wwntq+6BQq6jBr1aInxne631JZlzDxmnO3bDc+fb5N0aupvSQu+kDncLFbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8440

On Thu Aug 27, 2026 at 11:32 PM JST, Gary Guo wrote:
> On Thu Aug 27, 2026 at 2:42 PM BST, Alexandre Courbot wrote:
>> On Wed Aug 19, 2026 at 8:09 PM JST, Gary Guo wrote:
>>> Previously `register!` defined registers can be used on any untyped I/O
>>> regions. With all users specifying their desired register type now,
>>> propagate the specified type and restrict I/O access only when type
>>> matches.
>>>
>>> Also, add an `io_project!` example which is enabled by this change.
>>>
>>> Signed-off-by: Gary Guo <gary@garyguo.net>
>>> ---
>>>  rust/kernel/io.rs          | 13 +++++++++++
>>>  rust/kernel/io/register.rs | 55 ++++++++++++++++++++++++++++++++------=
--------
>>>  rust/macros/io/register.rs | 34 ++++++++++++++--------------
>>>  3 files changed, 68 insertions(+), 34 deletions(-)
>>>
>>> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
>>> index 84dd876b3407..4542187d6b91 100644
>>> --- a/rust/kernel/io.rs
>>> +++ b/rust/kernel/io.rs
>>> @@ -1692,21 +1692,34 @@ pub fn project_loc<U, L>(self, location: L) -> =
<T::Backend as IoBackend>::View<'
>>>  /// The syntax is of form `io_project!(io, proj)` where `io` is an exp=
ression to a type that
>>>  /// implements [`Io`] and `proj` is a [projection specification](kerne=
l::ptr::project!).
>>>  ///
>>> +/// `io_project!` can also project to subview of registers defined wit=
h [`register!`] macro.
>>
>> nit: "to a subview".
>>
>> <...>
>>> +/// Helper function for register alias implementation.
>>> +///
>>> +/// This is used to enforce base matching. Only called during const ev=
al.
>>> +#[doc(hidden)]
>>> +#[inline(always)]
>>> +pub const fn alias_offset<Base: ?Sized, Alias: Register<Base =3D Base>=
>() -> usize {
>>> +    Alias::OFFSET
>>> +}
>>> +
>>> +/// Helper function for register element alias implementation.
>>> +///
>>> +/// This is used to enforce base matching and provide bounds checking.=
 Only called during const
>>> +/// eval.
>>> +#[doc(hidden)]
>>> +#[inline(always)]
>>> +pub const fn element_alias_offset<Base: ?Sized, Alias: RegisterArray<B=
ase =3D Base>>(
>>> +    idx: usize,
>>> +) -> usize {
>>> +    build_assert!(idx < Alias::SIZE);
>>> +    Alias::OFFSET + idx * Alias::STRIDE
>>> +}
>>
>> You could convert the `build_assert!` (always good to eschew) into a
>> `const_assert!` if you turn `idx` into a generic parameter:
>>
>>     pub const fn element_alias_offset<
>>         Base: ?Sized,
>>         Alias: RegisterArray<Base =3D Base>,
>>         const IDX: usize,
>>     >() -> usize {
>>         crate::const_assert!(IDX < Alias::SIZE);
>>         Alias::OFFSET + IDX * Alias::STRIDE
>>     }
>>
>> You get a better error message, the const parameter is used in a
>> very controlled environment well within the expressive power of const
>> generics, and that function is not public interface anyway.
>>
>> If you don't like it (recent discussions make me think you might not
>> :)), then let's remove the `build_assert!` and keep the `static_assert`
>> emitted by the macro until this patch; it's not as elegant as checking
>> the condition into the same block of code that uses it, but again we are
>> in a controlled environment and static_assert > const_assert >
>> build_assert so this may actually be my preferred solution. You can
>> document the invariant in `element_alias_offset`.
>
> The error message should be identical? This function is only called durin=
g const
> evaluation, so even if I replace this build_assert to assert it'll be fin=
e and
> never actually cause linker error or runtime panic.

Indeed, I missed that. Even in this case, it's still better to use
something the compiler enforces can only run at const eval.

`build_assert` is something that in an ideal world shouldn't need to
exist, so let's avoid proliferating its use if we can avoid it.

>
> I wonder if I should add
>
>     assert_in_const_eval()
>
> or maybe
>
>     #[const_eval_only]
>     fn ...
>
> which expands to
>
>     #[inline(always)]
>     fn const ... {
>         assert_in_const_eval()
>     }
>
> so that it's clear to reader that this is a const-eval-only function.

If that doesn't delay the series, sure.
