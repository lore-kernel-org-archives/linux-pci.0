Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012049.outbound.protection.outlook.com [40.107.209.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2328237CD32;
	Thu, 27 Aug 2026 14:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787841566; cv=fail; b=mrUyos2ht9V/qj5OzcEc4cgcxqtFkkyhs3CQhFnavNXIbl3KI6rxQtdAhY5zHvy4SW7zajzEn8C3+JL7A2H1XKpmiBCK6YHeF32RMuwUc6jlgiZKgOHvc1rf3k201I1jBZVe8wMR+YUpTulqucwCCxYJyv4ViXVOWg6Ghz0+7+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787841566; c=relaxed/simple;
	bh=qMHHci97kpRoaH8TZCpyx6yDCW+6CrCLY3xGk3NEPcs=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=hV4v0HEyADqSX8NM2egU8n1WfIk086bvIgXG9RsgZYcMZjW3jiyPQsmz8AwuacX5gjYj3ovXaA3RBsePsRSjEODy6hFaY1VjpTjdX12BoLtN/lrk6atwtTcP1OV7ZNLriKdoRQOtgN4WYllyVTTeBKSYF/Osl4GGwfBLNUK/pcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fSpx4HTH; arc=fail smtp.client-ip=40.107.209.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fSpx4HTH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yzvnBe5EYVJk7rR6oXbdE/hvkwvVJ/9eLm/Ctpe96ZnUam71U0h0pIgSvdYB8q5XGoSoDuAdpw60PB+uy+ECyXFuIKr2S2oRNBg2PqzIpnSVbSVI1TkCcosjmjkt9XuPyJAjB6Z283yNx/dQ61FT35AiLsL9G1FlD6WsM25siD2q4Dlt651acD+pbmnjP7l/IbkPOcokr26Jeq4xsoH/xBxKT1RRyIU0ZwJKcbhMFrGV17jOLDqeRuaGZL58SiJWyzGrPWPV4BEzXBfpvXEBKRlowQmrDUr3bC3rMLxMXyXoXWXF3pLA6Ac9GThQYzIx4bc6mCrBybcN4drBeOEtLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApMdX9guvyOceEXrTPhY7HE0HrnGefrRWUY7ZHDJl5k=;
 b=kxGg2SlYl7WVX4tzr5/jLZG3aXxLqpg0KUapqlAZwYFGTIShvkC9ZkZS8qRw1PIQx+mzaCLjRAfmuj618sgkNoUxuuwvFZxkFiV4bYZKW27Qn8hKyUq85G2i5CBKk/hZB7DP8a0X4WBWTfeGFA6qV/3LVYq9pI6KQK5JgBpjbTBBSJ7ID0VvxlnIC4u5+C6mUMiR8C54RxCZJIiI1l7D6TVutnLE+d8U1Ag2QhOVpQ0h00GRyLpwVzF57aR+8K5kw+/9Z5tlMvNLZzWeHhXCkqU4bd9wIexJUtefksq9evDtNz0IIHD7Ssc2d+IZb4uajzm5TgyDZtQDUog+RUxdOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApMdX9guvyOceEXrTPhY7HE0HrnGefrRWUY7ZHDJl5k=;
 b=fSpx4HTHkWjQsKl0OkQNd5LpysXpPpYDDQACgdW/ZFgiK7guCrE25qMcXWj/t+E/gqwQOxoEzeWeyzrZgCt57ZCgnGUNfOdDk1tTT6Xjhzmt+L9YN23R7DUaWijhuZISxSRGLgrw+F+c9YnDs7DXRrx00QFyy1XacPl5USFH5vkwL0fKPbDF9rKgVrQxLetur4sCesX2SgpKZ+qF+EFlY5Gwfj5TetBks3cPa76TwzFSL0QcdoyAYsBE30v+QaXbH4D1y9Mb/3W7C0GXOm81zvfqdzX7pxYsynDgq0VZvC0V16rbzOPIWX+x/ZUQq3H175ug3YhXIJzwlKBfeKOiug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by PH7PR12MB6719.namprd12.prod.outlook.com (2603:10b6:510:1b2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Thu, 27 Aug
 2026 14:39:06 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0315.014; Thu, 27 Aug 2026
 14:39:06 +0000
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Aug 2026 23:39:03 +0900
Message-Id: <DKZSXMNDXTI9.3Q3WFXWD3YS64@nvidia.com>
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
Subject: Re: [PATCH v3 04/16] rust: io: perform conversions using `AsRepr`
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Content-Transfer-Encoding: quoted-printable
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-4-3699a75fadf1@garyguo.net>
 <DKZJ14NCZ37X.31YOYFWBKZ478@nvidia.com>
 <DKZSK6DW84GM.2EARLBR7IPHQ5@garyguo.net>
In-Reply-To: <DKZSK6DW84GM.2EARLBR7IPHQ5@garyguo.net>
X-ClientProxiedBy: TYCP286CA0158.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::9) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|PH7PR12MB6719:EE_
X-MS-Office365-Filtering-Correlation-Id: 38b9bcb0-2c28-4d92-d1d5-08df0448f27f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|23010399003|7416014|376014|366016|10067099003|56012099006|5023799004|11063799006|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	l+EhGhYQ2qMKsPYfBq58+0iz9jlDU6WiHQP3HainPRIC4hsUC/k+FzeBdoxUhqi/G+Yc+XsEF53axm8Go+LhWS9peEpHaUjQWQDo5qTWvxbl5bjmaQA0FqpyoNenMRUC5VM6zpYJFWSR4EP1jkeTCToNU/UTuIyVh5dZHfw6to7S+E+/tjPSlyy7BdZjXuMjVz8P2yBq8pujXw4xkxnSzQkxwXubSjnSH0uBMCJm9v73Y2uWMTy7iGQkB6C0D2RsgugzwJq+UW7EkLl7INasvFQN3ooQ2PqqKRz7ixxdsdv8VbA1lebFbOVFVz6w4mHP6oqNzRZVQZ30rT5ri2QddQEH5IKHpwHet6+AjTx7q7p1T2JEovRX2LiP9vbtukoP3S+jXcv7UeDfB8aNjugWAiN25KzTJclGKab4dzoSr5whm/0U47SAbBtSgcGfCSzD8q9FqRgSz2FyFWkeWoufmQN+6Z1iISFOWF+d7cp7vHayHHQiqXwF4fi3kM1NWbdq1A9AgeIKlahoF2WcX3gxwskUVhrx0TVrU2l78j8xluynfraRNtytuOJGsgdpNgLMet6bOBE6xvfuf1bGzsIgM2r/u9ePHoWGkcbMig6vi/31J0YKYA4t7KxGDj0r74/f0C5e1XblwStz1uUdXyZo600Iix0a9dIu9T4IunMNxNo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(23010399003)(7416014)(376014)(366016)(10067099003)(56012099006)(5023799004)(11063799006)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2FGUkttQjI3YlkySVdDVW45WWhuRzdsTHg0YURJa1llMnRoTVBqQjlkY3hw?=
 =?utf-8?B?VU4zWERqMWdkOFhVS0lPSG16MVBzaVM3b0IyODhUclUyVElablRVSlVPb3NN?=
 =?utf-8?B?OHBCVFdBd1d2TmJNWjRxZkV1NktkQW9YWTh5SUxScDBGMFhuWTdTSStUOSto?=
 =?utf-8?B?cGtjeXQxNEUwYkRBdWVXT0JTTkJtZy9UV3NCaitMK3czamx2MVEzK1U4U00z?=
 =?utf-8?B?cjRHWjhXYVpoMnZKVTRHdGx1MlArTlZYQkMxelkwMW5QOU85YWdwNTJXMzhp?=
 =?utf-8?B?L0xJZnVHNWNnVXNYZzZFQStXY2JWS3dKckNWdnBmbmw0NVMvZEFBaWdCMENu?=
 =?utf-8?B?MWllQWRaMWtjVXBRMC94OW5lblR6MHBrZTBrSW5VNHB4ZjBCTDlHdFkyNzJU?=
 =?utf-8?B?aWx3UFNseDg5akJDSnZBSEt4M1hZbVBoaGIwalB3OVBjaWdYNG9GY1F4L2xr?=
 =?utf-8?B?VkdadlgrcmQyaGlGRmcwNVlHZ3VOTklScW1NMnc0dm9FOWxyMTA5S2t3UDJw?=
 =?utf-8?B?Z3RQem9vTUZBcDZNNU1uNEgrdzBZcDNtOFZWVTBnVW1pQTBhUnN5bjFLZndr?=
 =?utf-8?B?WExPZkdkTUtyeVBJRTBMdEdGV0Y1QUE0ZWRCZ3JiKzk3b29NRFdhM21SdmpS?=
 =?utf-8?B?UFVuZmkvQkF4WW9teVppdzRzekJsblpHQzllcmlLQy9RaXpuZDZyRHE4bjUr?=
 =?utf-8?B?VEtEQWFWN202UTBmNXloRWlkWURGTmxVUmlFaUlBTk5ERnBiMmVZNWQ1ZGNl?=
 =?utf-8?B?TXJSY2dXejZSdjNOTStWUWh6UGdZeDkzaFJ1d29XR0xzVFJNLzZtSTc4UkN1?=
 =?utf-8?B?aVVuM2RMQk8yTEhuVXhPTGpzTGNRMHd2d0l1OW5jTUJEWHdyRWw3UWhiUVZD?=
 =?utf-8?B?bGtWUEhJNlp2QmtHcHlFSS9tSXdaT3VTWFEwZm9LUVV3WkNmbTRIbkxGdE13?=
 =?utf-8?B?aEZKS0FLMWJQL2pRVGdjMXMzZ1crZ1plNGdISGZhK3gvNDBzUW4rWE9oT1BO?=
 =?utf-8?B?M3RlL1NsYi9maTdQZkh4STlOQ2RXbEs0QzVPMk14RERGQ1l5OUh3d2tzclpH?=
 =?utf-8?B?aGEwWUQ2MFc4a0R3bktYaU80NW9RN21COTIyWTJVT0V2U2VvQ1ZDWlVNODVl?=
 =?utf-8?B?Q0JiQnNaUTRaTkRFQ1htN3ljOW8vVlBGT1JDeDBZbWJLNG5rVmszc3FHaUsx?=
 =?utf-8?B?aml5R3VucXVYWGZrdmdRV0JyY1VsdjYvZGxDSmFFNG5lUmtkSTNPOWVUdVBW?=
 =?utf-8?B?UElHbmVXMU1FaDRCbE41NWhmQ3lrZ2JNMElJOWN1em1pbUFGWEtCSTZSbWZp?=
 =?utf-8?B?aTY1MlAxdy9NSUluRnI2aElJUnJVUU9GYkZlUkxhWERYZ1ZscXBPYXkyMk1S?=
 =?utf-8?B?UjdvODhFNVc3SElqc2NqVlh5WkZMczJ2d3BnUTl3TVkveFRqZ1FQVTlsYjFH?=
 =?utf-8?B?LzVQeG9JYmVOM1hXckV1MUdiMjE1WlJwSDgrMXQvTHhFWGY1K1JOMW9iSjZI?=
 =?utf-8?B?VWE2Y3NjcWhkbmdHT2JSdk9LTmFvWisrMmhHeDZRcUh3ZUJHazhwTXEwZDlR?=
 =?utf-8?B?YWJqMW93cGx3bTJsb2hRYzQ0MGFBdnZUUWVlaEpOeC9KUW01ZnVTeUZTYlU5?=
 =?utf-8?B?andLclNZd0lMd2IyODA4dHVaeCs1VU9NMm84VUwrR09Xb3k1Qy9NSVE4QlVS?=
 =?utf-8?B?d2dtUDc5YUh1Unc1UnpZWktHQVRoNGhNcElUMFFlNExYTXM2dHpBV3VhOUhH?=
 =?utf-8?B?MW5tR0VoVU5KWjBrSWlScC9RVWJOWDBSUDVkOTgxek5ZM1c4Ni9RRGlkSFB3?=
 =?utf-8?B?ZXZ4WEFWUXFobi9TZWtUWXZ6V2d6RCtuSDFFVEdaTTVaenZrVXJZOWtqM1Uy?=
 =?utf-8?B?dURFTi9HcXFZS3J0K0ludVp3eDZVdFVmRlRteTV5YVlRaEtITVNzTFhPQWt5?=
 =?utf-8?B?aVd1WW9heHlVY2xkalNpRkJMMGxjR3pya0ExbU4yeVZSWk0rLzRFUXZSTnBi?=
 =?utf-8?B?STRLL0xYdGQwZ3grRFdrM2FYbUExM3RwQXlEMTRBSGZjcFU5WVFJQ2lXM3p1?=
 =?utf-8?B?UEJsQjRsSmkxQUJiNmlHUEh5M3NScStJQk5xbHUvdno1c1lROC8vcWR2Mnlt?=
 =?utf-8?B?QWlsaWFJaVVHQVFNd3FzNjg5ZG1WaThYbElBMHY0UlRRaWQvTWIrVFNtcFBQ?=
 =?utf-8?B?dWVXZW5HeDhjaVBGcW91d2RsaVUwdW02U1daaEh6M0tsK1RHMlZSU2VWQkQ3?=
 =?utf-8?B?dWozaFM3UG5ld1N1WEZGeG9ZdnRONXhYOWtwaEgyclNodzBzSVJuODZSYzVE?=
 =?utf-8?B?UVJiZExvYURreC81eHVJcTNLeXhVZlloMGx4cExXK3hJUXlxNktEYjVhenNa?=
 =?utf-8?Q?lNHanoGkdEbIiRYIk5asg5Kvu0R+yDdi7V1rN+0jqnhzg?=
X-MS-Exchange-AntiSpam-MessageData-1: jBpmYFQKarBpqA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b9bcb0-2c28-4d92-d1d5-08df0448f27f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 14:39:06.3663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3PnsXCbu6z7dpON+lJgd3nwBsC4PXhL55fR8vidnucrNteZKLNDTHSX0uxcyiR+4+GVLV4vhIVfXDgu48ahvJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6719

On Thu Aug 27, 2026 at 11:21 PM JST, Gary Guo wrote:
> On Thu Aug 27, 2026 at 7:53 AM BST, Alexandre Courbot wrote:
>> On Wed Aug 19, 2026 at 8:09 PM JST, Gary Guo wrote:
>>> For types that are layout-compatible with an I/O capable type, we would
>>> want the ability to use them directly for I/O operations. E.g.
>>>
>>>     bitfield! {
>>>         pub struct Foo(u32) {
>>>             ...
>>>         }
>>>     }
>>>
>>>     #[repr(C)]
>>>     struct Bar {
>>>         foo: Foo,
>>>     }
>>>
>>>     let mmio: Mmio<'_, Bar> =3D ...;
>>>     io_read!(mmio, .foo)
>>>
>>> Currently this feature is available from `register!()` macro but not
>>> otherwise available with `io_read!`, `io_write!`. Support this by
>>> performing conversions to I/O primitives via the `AsRepr`/`AsReprMut`
>>> trait.
>>>
>>> This makes the `IoLoc::IoType` and `Register::Storage` redundant; thus
>>> remove them; also convert register methods to use the `read_val` and
>>> `write_val` instead.
>>
>> Nice, the redundancy was bothering me a bit so this is clearly a better
>> design.
>>
>> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
>>
>>>
>>> Signed-off-by: Gary Guo <gary@garyguo.net>
>>> ---
>>>  rust/kernel/bitfield.rs    |  10 ++++
>>>  rust/kernel/io.rs          | 135 +++++++++++++++++++++++++------------=
--------
>>>  rust/kernel/io/register.rs |  15 -----
>>>  rust/macros/io/register.rs |   2 -
>>>  4 files changed, 86 insertions(+), 76 deletions(-)
>>>
>>> diff --git a/rust/kernel/bitfield.rs b/rust/kernel/bitfield.rs
>>> index a0d089423f21..619c5e2189d1 100644
>>> --- a/rust/kernel/bitfield.rs
>>> +++ b/rust/kernel/bitfield.rs
>>> @@ -308,6 +308,7 @@ macro_rules! bitfield {
>>>          $(#[$attr])*
>>>          #[repr(transparent)]
>>>          #[derive(Clone, Copy, PartialEq, Eq)]
>>> +        #[derive($crate::prelude::FromBytes, $crate::prelude::IntoByte=
s)]
>>
>> Do we need `FromBytes`/`IntoBytes` for every single bitfield type? I
>> mean that probably doesn't hurt, but if we need them for registers then
>> we can derive them from the register macro.
>
> These are not needed now (as `AsRepr` provides sufficient guarantee so
> read_val/write_val use unsafe with them instead); but I kept them as I th=
ink
> it's useful derive regardless. I suppose these are not needed for `regist=
er!` so
> direct user of `bitfield` can derive them manually instead.

Yeah, I don't think it's a big deal to have these, but since it is
easier to add in the future than to remove once people start relying on
them, I'd rather add them when a concrete need manifests itself.
