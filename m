Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020108.outbound.protection.outlook.com [52.101.196.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7293484246;
	Thu, 13 Aug 2026 17:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786642179; cv=fail; b=FRPn0HaP1kwFC/gBOsZqHFyx0/+Nd/93RuoA6lMujst63e29Ri1pBPcofTO0ZhqFXw2e7Pr/8VWlLR7qBuKCGMIh9+i/1IlWRQPu+m1f0ygEONKuuQnSNZAUTCx/ais5gg0JAciW+KRi05BN1kRHoU212zJimOGq20Vqe3gENBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786642179; c=relaxed/simple;
	bh=gExHL2OR4FOxqeegnEGq/9eRChIg/ItecyYmaWHsziA=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=SDbWTIGhjRDvxIkgi/MC1/KGGRsa14WxP87oC+tK0Ye1qhtpiAeUMx1nuW1ELsbFCHP2VDrOLQVO5vi45Zv8a4n6b1AFw+Ft5/3fcUf8JuKlP6LD+/C2RV9KjM8+bLAEz3GdR5E0y2V9KOdvEz3zbvNBqMUp1HWuB1Dl/hQ/1xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=HQiC4ai8; arc=fail smtp.client-ip=52.101.196.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="HQiC4ai8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L8WAsN0FkDGlu39//WaRXYNJNRCLEAUz6IcHt+kYKVGA+AZIzwotwE4mqwrp9wBYT9h6yF3lI9Y93EZQDZhI2zQnaR553I0tJ75F4MdoARKl+xFSCc4bkYqzcSFnV0I1+CjICk3IZg/4kbcoG34OKKt3tjAdcEKYJXif+OitcgX4tpiasTSJffZvNxhlbE/wVWiUm4K6Gl6UIdmMArKhIlr3as5FAmesloLcvhCie5eTVTi7q2D9n5RaLr/MReiuL8/6DHrSP+c4anNfm4hPfllItPdJyLtHMGFI16xZ6gijQwbGkcogGfNFZTyyJwIheTcDjWcqahwqHKOppJkmIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cK35aN0hEi1ovHKXY3E1pSNxfQeaCu0kY1KQFDMLfDI=;
 b=HHX4qs72HBJ9TqD+9n1UO7CgKmxxsTpSSZ9tfXbH1eVNmPsYuVtOjbwNf3DkQyMgg33I55YRwuqK+rpSSeKROL+hUwPuSavAbSpGo2Wec1wFOE6T42Ih7BbGKvfJB4xeYPxZTlEYUj24Fa6jH/ICGWhNnPvw4CXcaiLxr0YQxgvT1gltUe6ft43DqMgYJy43+4Xy/51yutvqnbalnaA02r6l4ZVl6QXp9XmGJqZLd+jA6efPGfE4svoTS9+nwl2ShXFy0e/bKvBWpiQ0rLP7itZUOzcvyZmg5gQxWb1ug7zDEsIaZaEIURt6ow7I/nOAQQFmo2zhaKeVHvOjYpaItQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cK35aN0hEi1ovHKXY3E1pSNxfQeaCu0kY1KQFDMLfDI=;
 b=HQiC4ai8zo3qCkwba1f8PvoGyhwjqPzTcfTAQbBkubQqrTvkpv0G9awz0hOiwJMwPMORPXaQxSN7KhghthH9yoIw19FgtyRfOcfPdFNwWN66OlZXyMO9qTI1K/FRJ+sQSIxOgDwmFm4UhmAnj1e1FEmXcdm+1eNQN6W3FvHUan4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWLP265MB6531.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 17:29:33 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 17:29:33 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 18:29:32 +0100
Message-Id: <DKNZSJ3YXV87.TCOAG98VFTSX@garyguo.net>
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
Subject: Re: [PATCH v2 01/16] rust: io: add static `cast()` method for views
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-1-c3ca142220a0@garyguo.net>
 <DKL5P5CJC170.3EFWNHBMTTIPS@nvidia.com>
In-Reply-To: <DKL5P5CJC170.3EFWNHBMTTIPS@nvidia.com>
X-ClientProxiedBy: LO4P123CA0485.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::22) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWLP265MB6531:EE_
X-MS-Office365-Filtering-Correlation-Id: e7db64cf-d3b6-4535-74cc-08def9607061
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|10070799003|22082099003|18002099003|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	S/jYB37Ca9/6BOQA55oZhkqNI7EWF6tKSVceT9TXrZxrtxxFfifDoKR39PyYNLxJMt7qzg0Q0PLRDIM3MwS+2di/M5Iy8h4xTK7qL4APChcCH0x7Z3tqsNy3kDVnFiNconwyISw3Ie0PE/ixMVcYKJhnD9XsgqN9oWdak+MIJ6VIfeIGL+0ISOkRDREJwGtlNmQcxbqxNJkFw7VxdhsxPxPLx1AAkdaigoL1vHOcvlzvbvAoM+kOhXzRN2j5aJ7ahQ4ipFa0u9Hv2/ZoMP5x8mb1Jk0PAsBjZmx5pOK1Ze5ngokNZev2GApv37jdih3TYPk3TjFVMoAFTgkC0OQhm0RsKZrHNTl23LXOUnOQb5dSIwCr17lPF7eKV5uRkYPYWDhRC1EY6zQMDmHrUlUPHZrKdfDdWsCXQZAqR/ZRLCC7YWoIbT2vT4TgKyF4cBvk3rNs/tCczutygq+BufXuD3m2HpRq3YPDO/txbMZhFMBIF3me0erGex25MK5cC9pldMo3NzgdUnUqot/khNilYe/i9gwWnEU54FVegN9hYRy30bji/YNYewzLiz0LogdPY0nqSVW6bNvFR7V6sxAaVEJ6GvXNxtbsU9WYMxU3z8n7plS5wTZ4Va5/UrQ6dBPiy7pxtJDvDnbA9sqXIGa/F6v4dIcSTSUVG+bHymyw8ak=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(10070799003)(22082099003)(18002099003)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2FkRy92UkVxamtMVzNSSFl2bi8rcUs2T3F5a0U5TXROWEppMDlMSU92cUVC?=
 =?utf-8?B?YmRoaXFxTDk0bnQzUnZPclQ0OWdUWnJ5VFdLbTRwdEJyY05nSW5hMU1IditI?=
 =?utf-8?B?TFVYOHFteDRhNk1kR2hMTk9vbHA5K0RDeGJ6ckVuZnRnSysyWlRNSzRoQXFx?=
 =?utf-8?B?Z2hXQzNjRVgzYlEvRlQ2anZlR1JoUlJ1U041V3R0U3BoRXEzOFQrOWYxZHFw?=
 =?utf-8?B?MGd0bjkzSmtOc0k3MmhtQkd2ZmlVNWdMY3BCbUxObGwyR2E1UjJVN1NQSDlK?=
 =?utf-8?B?cWpwSnZLbFVIY0pseWdFSlpPdWZOZDVzcmtsc044SkRnTGtLY2dBUzB0aTdP?=
 =?utf-8?B?N2ZIamliS21PNGZLM3VnaVBQdktIdWhES0xxN05RdWlKWVNvZGpNRm96TGpH?=
 =?utf-8?B?Q1pCR1Y2bnhxWTVoMHh5TnFFa0srU05CQm9oOUxpZmQ5RHVRcndRZXNUVkZy?=
 =?utf-8?B?OS80eVpORlgyM3RFeHh3MmlGVldkOFdaYVdjVS95QU5kSVA0amVIV0NhNEt0?=
 =?utf-8?B?WnRINFlnVGwvMnVHY2MxaDZZUklMN0xiT1NobGhwaDFTdGlGRkxqS3VRR0Zy?=
 =?utf-8?B?YXBVc2tnVFhIU1dOYS9pUVhnazJGNUNNVW5IWWRUaVJWckxPbnZMemtpd0tY?=
 =?utf-8?B?dWw5Y0lJT0JuMjdvc3hPdVFSUTR2L3VHTCtLdWVtTFJWREYrRnVMUmhPYzlZ?=
 =?utf-8?B?MHpxMmg1QjZXU2p2K3pQM1Rtam5EOGNGVVBoSlRFSjhGYlR5TEc0Ni9sR1hX?=
 =?utf-8?B?Y2EzR1l0QWo1Umw0VjBSRzI1UmFqYlZZZW1sTlNLNVlObmt6WnM2cVU1SkVl?=
 =?utf-8?B?MjEvYkp3aWJkNUFGWHBVcFcrZWpZMFpYZXF4YSsrMU1YRE4yMURpajlucG1U?=
 =?utf-8?B?cjRod2tMOE56VlV4VC9YVCtJZ2hxZ01KaU03ZHlMMUtCTzErbXcvNEVFb3dQ?=
 =?utf-8?B?UDcyUHdkN2NldWYrbXJxRCtvd0JPZWFiUks5NWx1N3lBYzRHN0NzaEFER2dQ?=
 =?utf-8?B?SHdmTGUvelV6ZnpLL3FRdldsRGZYV0hISUQ0TW51SFpjQ1p0MzdTN1cwQm56?=
 =?utf-8?B?WDZnY2k0UEVZZjh3bzhkK3RBQ1Q2bzNFTHZWdWt3TVlILytSZmZCMWlUelpK?=
 =?utf-8?B?RjZVY1o2UjF5SUZpVVo4a0IrbXBzL2d4TFl0Vy90YTFHd0xIOVk3NmhZTU9T?=
 =?utf-8?B?Y1dpeEp2Y1IzZkdsdTNqQ3RPNlhRTDhJSmFPWHBnSGV0SmpLS3F5VmFpQ0xs?=
 =?utf-8?B?cWVZMUZUT0dqcXoyMXhZNEpBblZiZm5FZFVHenY0MVZMVk1LU2VDdnp3cEJr?=
 =?utf-8?B?Ujc1dzlzQkkzd3k3YWlXQzVVZEk3cVdmSEFQME9nN0ZWWVI1RnZaZVB2Z3BH?=
 =?utf-8?B?NjJuMWlXSithSzAxQkl3WER5aUI3VGZkQUhScUZ5WmNKMUZCaHJZUzVSK0VY?=
 =?utf-8?B?U0JrQ1pQMmdGS3FPNlhkRTdmSDdXUFRmZ2VleUZMZGFMVmpUTDhhczlZR0dw?=
 =?utf-8?B?eVVXbUJyWGlveXI1MUtqM21FWitHcVVpd2RMdVA2cjU3cDdmMkFCZWRYQW1X?=
 =?utf-8?B?aVgxMmlaeDhGcFh4V1llV2ZCSHQ5ZFA3WUQxMUU4ZWs5OVgzd3pqM1Q1N1JH?=
 =?utf-8?B?bWoxSmdVWURQZU9SR1BzOXZWcDNCRGl3WkhNUXRVVDNMd245dGl3Sy9OTU1T?=
 =?utf-8?B?NEsyUktQZTgxaW9HdDQ1K3FzWTJpQWFYb29KQmJ2ZU5UTUNuYklxeTgzU2ZI?=
 =?utf-8?B?VGlpUFlvTjQveUwvUnd1Y28wMzBoQVFmWEhRZmFZTVdBS1IxN09tWG0vaW04?=
 =?utf-8?B?VXo3TDF2ZkI4VzZGazdOS2w5eHYydTBPSDVlMlVzWnowMWNNUm9QemgrL0d5?=
 =?utf-8?B?dWMrV2J5d1Z1UldQbTB2N0ZacDNxUGF5UEdPU1JUT2xkaVBwNzBHWEhmcHhU?=
 =?utf-8?B?bXMrL3haMXFhYkNMWFdNU0tIS0dKd2pRR3NOT0dObXFpNTFqT3F0MjZIVW8x?=
 =?utf-8?B?aTFQZ3RhYVh5SUtKSXN4cHJ2S0luay9OR0JIVnBKV2ZWOU1IRXBPcklWSWZZ?=
 =?utf-8?B?OUdUc1lWMUFzMVhiNm5DSWZCZUVkRkhMSWVHSHhZNVdoUU5VNmRPY2Zhclpn?=
 =?utf-8?B?UlpTck1TWUduQkpXb2NBbi9sVGxlLzM2cXJXQktwSWdGZ0RQL1lJRDZFcDN4?=
 =?utf-8?B?VUZualUvVUd4WG96RlVOdjdDaUc0amRRUHIxWkh3eTFxWEV6ZnBTZ2I1KytB?=
 =?utf-8?B?UStwYmZHMzBraUc4TDF4VjBOd3JsU0IwN0JBV2lvT1YrY2JIYmtwK0p2TktN?=
 =?utf-8?B?R3NCY01NWlNiMFFBNHNPYloxUWNVc0pBTHM3V2N5bDlMTklXNHRWZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e7db64cf-d3b6-4535-74cc-08def9607061
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 17:29:33.2006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kTFdlGBDDfefmVtriqX9ZoD6czKYo0wqzBUbsBEFoMz4AssmEaEyQ5qmsqbApYEnC64l6S4JjDvh+iA3mSxRlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6531

On Mon Aug 10, 2026 at 10:29 AM BST, Alexandre Courbot wrote:
> On Thu Aug 6, 2026 at 1:35 AM JST, Gary Guo wrote:
>> Add a compile-time checked variant of `try_cast()` using the minimum siz=
e
>> and alignment information.
>>
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>> ---
>>  rust/kernel/io.rs | 39 +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>>
>> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
>> index a38c20ba3d23..adfc555de7d0 100644
>> --- a/rust/kernel/io.rs
>> +++ b/rust/kernel/io.rs
>> @@ -436,6 +436,45 @@ fn is_empty<T>(self) -> bool
>>          self.len() =3D=3D 0
>>      }
>> =20
>> +    /// Convert into a different typed I/O view.
>> +    ///
>> +    /// The target type must be known (statically) to be of the same or=
 smaller size to current
>> +    /// type, and the current view is properly aligned for the target t=
ype.
>
> grammar nit: s/is/must be.
>
>> +    ///
>> +    /// # Examples
>> +    ///
>> +    /// ```no_run
>> +    /// use kernel::io::{
>> +    ///     io_project,
>> +    ///     Mmio,
>> +    ///     Io,
>> +    ///     Region,
>> +    /// };
>> +    /// #[derive(FromBytes, IntoBytes)]
>> +    /// #[repr(C)]
>> +    /// struct MyStruct { field: u32, }
>> +    ///
>> +    /// # fn test(mmio: &Mmio<'_, Region<0x1000>>) {
>> +    /// // let mmio: Mmio<'_, Region>;
>
> Should this be `Region<0x1000>`? Because as written the `cast` right
> below wouldn't build since `Region::MIN_SIZE =3D=3D 0`.

Indeed, I forgot to update the comment after copying this from try_cast doc=
.

>
> Also, looking at Sashiko's comment about `KnownSize` we should maybe
> bite the bullet and make it unsafe? There was some talk about it [1] but
> the reason why we kept it safe back then doesn't seem to protect us
> here.
>
> [1] https://lore.kernel.org/rust-for-linux/DGSDGDIVUHO0.P594H9B4LLO5@kern=
el.org/

There isn't a way to create !Sized I/O regions safely right now, so I think
everything is still okay. But making `KnownSize` unsafe sounds reasonable t=
oo.

Best,
Gary
