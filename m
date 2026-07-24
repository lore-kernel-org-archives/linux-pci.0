Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021083.outbound.protection.outlook.com [52.101.95.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B11E30D416;
	Fri, 24 Jul 2026 13:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784899367; cv=fail; b=A3q++2fNnuzSSYMaHpAzl8EyJ3AnsJnzvchNlV3xbEXHnGOFRmaRxi5FpBiTqHCPNM6mvGng6Ex/6oCeKmxtT/ca9Ya2dustsuA2kIj5bMe3iv0ik6BSZPI3oKw8aO/ggVWgCMSNbXSmxwGVtx3HYBSZCd+GCCOkaQ1RkhIJ83g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784899367; c=relaxed/simple;
	bh=r/06/CYsZfuv2vfba+055aaUwuqPIfO6CrZq1J34vvU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=C1vZbO5CIHHGi2BHmeHhR7DHAj8UWN1NsfSurhUiAY+2jrKaPa0h3B9o0Lu79pcXM+7InfqANGXpcUFsuEuZSHK2HU0EUPJD0S+UvMrop8vSYDkOpuz7nEjeYVH9KcRd1L1Am+BOzlL0MY5FaNEo/BhD1wCZMmRuL7sEpB54yW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=srBWI/6m; arc=fail smtp.client-ip=52.101.95.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="srBWI/6m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mFa2dOldTsmXoYdbaJCa70uj1t2dYY6+8xc5wV7fqteYn+VK259Emi2iarhnDhemkQ8hSHFknujQo+1wvuAYDD4a6jRTyrzRQupflBWlsbE0oRcjCmPETwM7RkiLTyo93QiVvI44tb8dsoisf16wX/fl9L/Iy6VduNypHZy3wZpkcoj187pzhZSMlj8dNF441ECxBJVmx3nwjTM4q0dqPLmezkrtRwe/9f4R8Yoi+88gYDpRG5hS+ZWMxzkVQWfKw1CZg0dsYII6j5j1bGa3WZo3nUpr2oSwo8rZnP4m6FZopEWFQ05QL5z6mk+DhxSK/Ct/Lee+AJkwoABslNLgUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SP/n9gusqnMelDzwSpzt60029G8k5xRq+f1yTx6WNRs=;
 b=hQ51T/PGazGhfLZ6GOVpE6dE3mRKlwolYehqIvZ0/Nofzy9MJTyrft+KNv3Y388j99JhgsuWkKYYGJNqhHSbNpc8WB9+mPirfAq9EsfowL9TtjG0djwJZQ4MSowubne31orpNQSweIEN8u3MiCIjzLUUW8q/g7pP+ErGe0wRYRIZqEksa6Jm01EgukPxIHdGJe+/ajYhD93maPuiuxwuWBHfXvMz5fGWCxAf+OD4Zyq1D0Ri3gQ2FC2/f0NQx0HVlL8dmSpK37cL9N6/VCbk9gbl6rf6w03822jWNSY96Rp011pXP7jkEYS5Jfup020BwN5zvJj0uw5kAsNESGQFcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SP/n9gusqnMelDzwSpzt60029G8k5xRq+f1yTx6WNRs=;
 b=srBWI/6mHCUZnsW474HcvCv8XeilkDg8djHTW4rGwXEtM5mMlBeBvLlXZ1eGID6BLidoHzLTAXWdpzHh/lnzrlFuGm1MEuV+gCLkitFSHQTABp4k72jzoYZQPU6QyAG8S83t9xB7ee+JXEOg4s66Smxp7q1YIRyTyTZY02rsKxo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOYP265MB2237.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:116::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 13:22:40 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%2]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 13:22:39 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Jul 2026 14:22:39 +0100
Message-Id: <DK6U0LR7D57N.3FW1CZG9R42YF@garyguo.net>
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
Subject: Re: [PATCH 01/10] rust: io: register: allow explicit base type
 specification
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260721-typed_register-v1-0-452d72b60262@garyguo.net>
 <20260721-typed_register-v1-1-452d72b60262@garyguo.net>
 <DK6LF1ODPWC3.3QQV3SXQ55SXP@nvidia.com>
In-Reply-To: <DK6LF1ODPWC3.3QQV3SXQ55SXP@nvidia.com>
X-ClientProxiedBy: LO4P123CA0687.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::13) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOYP265MB2237:EE_
X-MS-Office365-Filtering-Correlation-Id: dae6347c-cca9-45b1-2175-08dee986a2a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|10070799003|376014|7416014|22082099003|18002099003|5023799004|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	LgS7HDYXNS/TXs4n4QmFMwfMmkBNcRAf2riQI3tYPcHgB45YB/PImatQaqEHxbAzCH7HGydeyQmf6BSLq+YHN2NjIHhtYputWsGjCpIl37wTp1hSgncxYMacozUc9TTdsbwI4DCQ+WfE8Ox9eJ2AwMAQn45ceXixVeBDa9yJNAMrCqLljVIR0F8MZeDCLSsFmtuhQXxECZ1aNHYEbEZ/RWi9RD+O4aucic14djcV63oaScSkw+ZKXNM/rT6lNQFm3zfyAogoW036V9ohpC3aPdM0/8WIWjyU+jSTIJeC1cgNVtSck6CrvugAduLeBkOt28djA8i+UADnDzn+ynGaYaKH+jAYaaW6hWO7hSQGvEYW4dxfNpMnqhljAqczVU1TRRREtqKQfac6brH5KjqEVWJMBLKIFG9CQ6q4Hil0ZBY5Up+7URva0EOqrg7Gr+tbcdVtrp91/9HkyAD3PGaAdd6zhyqPHe0WIMHavnhw/SrZ6xAtMv+tEj93HgrvqEcIyo63GFDlbxYBqxSxeZ5I6B5mZZYaHezkf8ZUmKWBt6sU7Duou4XPrSZfhWa7jHYJqs2F6rdLraN3aO80rhac1a1/Xxzyj0WKCxjR0C+AG+hkeq3Sm211fhQLzhfpec8lvVcE7HeVn6htCoI4iJc4ng47/MK5t1XxAwmfQ7ykHlA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(10070799003)(376014)(7416014)(22082099003)(18002099003)(5023799004)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmZKZWZnQXU2Z2lieFNleDNEN3orVEZhVVhPN0JrZnNIZU42RTZNVHhsY2lp?=
 =?utf-8?B?bCs1M2xBbGJtMDRHVHI0cmtETkFOUjFrMHhjd09IUXJNR2NKWE1NdDEwR2tu?=
 =?utf-8?B?R2tDRU41MCsvQ0d3S2RNbmN6NTRvTThxRGxIcXN3ZStFYkVURW0rd1diNnhY?=
 =?utf-8?B?a0FnZG1ERVUvdDFacHE3N21nUVdlRitxanRnN2VqakU5eXY3L1JTMjJvMTV2?=
 =?utf-8?B?NWZuYkZWVm1aSVpCK2FuOUlWem5hV05vNzZtQ0JWM1JVN3RQemdvdXdlK1Q5?=
 =?utf-8?B?MDVFWjVIdFhuOFY5T1Nyb3F6MnNvQzE1SVFDcW92NWNvRUx2Mm42MGZXRHhR?=
 =?utf-8?B?MzN0UU5YejVlNVVSa05nUXN5MWVVSFUxRmpNeG9McW9ySUZLbm9jZXZqMG1s?=
 =?utf-8?B?TUxmeE5PSWhNdXU2UVJiclc0YjJQYUhOQlBTN0hvT2hjSFYvaUFjTFpKR0FM?=
 =?utf-8?B?eEY5SFJQbFVwck5oMFUxcWVKN2g0ZElCdW9PWFgxY3Bhb2JNSUw3bHVrV1Nz?=
 =?utf-8?B?MFI5bU0yMzFERHN4Njcra1puenJRNEUwTDMyUG51NTh6dzl5c1FvaHBpeXBZ?=
 =?utf-8?B?dUxSZ2svaUFvWnNZSEpNUDFIUnlpeXRKMGdqRjlDeDYxMlNxMHJSN1RpeUdH?=
 =?utf-8?B?TU1HRlprc3VKandiUEg0b2oxT1pFbUVSTEhDdkZNVmU1RXpjR1hKY1BtZTJs?=
 =?utf-8?B?M2lqa2FvZWVzS21pbStVc2pQSDhzeXlET0k3OEg3VlFrM1FuMXFGMFRDSVc0?=
 =?utf-8?B?WkJSUUtQNityaFZKZk9NVUIvQ3dZTnExcVpEKzRjV1AwRnM3MFkzdHp3aGpp?=
 =?utf-8?B?REliUytEU3lhTVYybVlwV1NtbWZtSEtheFh3WURkZCtNV0MyTW5pSE80ZWY2?=
 =?utf-8?B?eHcxKzhudmgzazl0VGVPMnUrWFFJeHN2UDBlVDZEaEdjdDNBVHh3dzd3S3F1?=
 =?utf-8?B?bTRDQlFuaDJSUThZRGVLaDhUOHAxSHpKeXpSUWJja0Nwd0g5VkwreklZZ0Rt?=
 =?utf-8?B?ekVqelgxRE0ydWFZRW1BOTMwc3JBeVJmRkFnVEZydVR4R25mSFFNWm5nRjdp?=
 =?utf-8?B?dkpwZDdKanB5RWJEeFBXajB3NnJXODBzdHpQTkY5NC9ScHhobmdDQnAyaElu?=
 =?utf-8?B?b0xaVkRwVTc1WXFpVkpiZkNFT3FHcHd0bjhYcDdhRS9aZlB2YzVaYlVld0xP?=
 =?utf-8?B?Mm1IN2hiRmJaT2NQVWt3Q0pHZVk3RjN2TWJ0L2FVVjRMK2I3NDc3S3lzOTdU?=
 =?utf-8?B?VkNLTTU5MUlraUZZM0l3MnUyM0w1YjBRbUxNQVg5OHFaQTFTbkh3TFZHWFht?=
 =?utf-8?B?WEJaTWsxOXduTlFoM1M2a0dJWmJlNjF4cm1vbStkQjljK0hLNzEwVnZoSFdH?=
 =?utf-8?B?eDNKaFErZmpLTG5LL3l5NnNWVklVSjhGQnFmOStBeFQ1N2ZwUjFrOUtjY1JV?=
 =?utf-8?B?VUhtVnJGYkcxVW1MSHI2YUd0dlpPdnlUU2V5WTE2OTFXeWN0THIvRVl6YWRk?=
 =?utf-8?B?Vkhyb2RpejF4UEJlRnM5V0c4Vk1uNkpUYnNVTGQ3SFBhSlBGMFN0VGtuUTNS?=
 =?utf-8?B?bnhkL2NIVGljUTRkQURXZHZTcDNrS2hsMVorU2NiYVhxTElEc2d6ZUNyQkdF?=
 =?utf-8?B?MDVIT2VodVM5OTJZY1hnOFJOT1RGaFIzRVNYc2c0L2o3SjE2MzRHYUV4UnUy?=
 =?utf-8?B?bk5zZ05QdmxQRTZCU0FUMVdaakNiUUVRQkJaVS9lUzhyYTEvcWhGZTE1eHNt?=
 =?utf-8?B?OHR5RXZHYll3ekdDSmtwUTVkcFZNRnpLNjM4WHcrZWRIdnpndDhGeXd3WEVV?=
 =?utf-8?B?N25xRkoxWXN2Z0pXVVZlWWpyVHcwMGdqdUU0ZFZ6YzNacnBxUmlvdW16bk9z?=
 =?utf-8?B?N0lrQzQvWUtweTFIL1A5YmVBZmhwV3c1aUFua3F5VG0vcTRyeVgxeE1qNmIy?=
 =?utf-8?B?aEJOajRRR215cEE5cTZCbThTazJnVWp1V2tocU1qTGkwWFNONjR6Nmt3amxT?=
 =?utf-8?B?N2QvTjBZWXBZOEFJRzJhN2NkZUNHUy92cHZrMWFXUktNbzUyUVhtQ005M3BR?=
 =?utf-8?B?N0xlMk5rSWQzRThzNS9BZkk2RlozbVRnL3ErTGZwU2d1K1BlSTU1VWNsUDZS?=
 =?utf-8?B?bTVpNmd5aTNXeTMwN0JEZUpCMjRYcHNXcVZFcnJ5WVJOUU1mV3h4MzY0MXdO?=
 =?utf-8?B?Y1BmYi9JZW9WWERjazNPSDdvc3pPdkRxa3J1QUlXaXlQOTRSckJWejc0V0kv?=
 =?utf-8?B?aGFoZFoyRUp1SGJNMWZBNktNMkgvRVBaTWNpUnRTRVFFMm1QY05veUZ6SVZu?=
 =?utf-8?B?dlhOOWRYeGpyVk05MnZldzh6U0VDZWdrd29nV3RNRTZDV2dXdU83dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: dae6347c-cca9-45b1-2175-08dee986a2a8
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 13:22:39.8237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: svcPxgrOzyq8c1h+Thp+Jdo31BYk6Mzvq5GdAZESydDwTDmlluCxVUiRR18LZs3rX1JrgFi+/w8/A1aWtZwJHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP265MB2237

On Fri Jul 24, 2026 at 7:38 AM BST, Alexandre Courbot wrote:
> nit: the base-commit trailer points to a commit that only exists in
> linux-next (next-20260720) and is not easily discoverable - it would
> help if you could mention the base in human-resolvable form in the cover
> letter.
>
> On Wed Jul 22, 2026 at 1:54 AM JST, Gary Guo wrote:
>> Currently registers work for all untyped I/O regions, which is not ideal=
.
>> It allows registers defined for device A to work for another device B an=
d
>> there is no safeguarding at all.
>
> This doesn't sound like a real concern. Registers are typically local to
> a driver, so one cannot use registers for device A on device B even now.
> And within the same crate registers can be isolated by module if needed.

Even for a single driver you don't want to mix register definitions. E.g. i=
f
you have more bars, e.g. if you have subregions of registers, like PFALCON =
and
PFALCON2.

Your relative register design uses an artifical marker type to distinguish
between two different subregions, which is a very good motiviation to say t=
hat
registers should be typed.

>
> Even if we restrict the base type, the examples given in this patch only
> partially address the issue: registers from different drivers using
> regions of identical sizes could be used interchangeably without
> complaint.

This patch set gives you the way to do newtype on regions. Ideally all driv=
ers
would eventually use that and not use the `Region` type.

>
> So I don't think this patchset addresses this particular problem, for
> which namespace isolation is the correct solution anyway.
>
>>
>> All users of the `register!` macro know what type it will be operating o=
n,
>> and that type is consistent across the driver. Therefore, add a `base`
>> parameter to `register!`.
>>
>> Currently this parameter is unused in the generated code; it will be use=
d
>> when all users of `register!` is converted to gain the parameter.
>>
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>> ---
>>  rust/kernel/io.rs          |  4 +++
>>  rust/kernel/io/register.rs | 79 +++++++++++++++++++++++++++++++++++++++=
+++----
>>  2 files changed, 76 insertions(+), 7 deletions(-)
>>
>> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
>> index 95f46bb75f9e..c5f07c38e59e 100644
>> --- a/rust/kernel/io.rs
>> +++ b/rust/kernel/io.rs
>> @@ -883,6 +883,8 @@ fn try_write<T, L>(self, location: L, value: T) -> R=
esult
>>      /// };
>>      ///
>>      /// register! {
>> +    ///     base: Region;
>> +    ///
>>      ///     VERSION(u32) @ 0x100 {
>>      ///         15:8 major;
>>      ///         7:0  minor;
>> @@ -1028,6 +1030,8 @@ fn write<T, L>(self, location: L, value: T)
>>      /// };
>>      ///
>>      /// register! {
>> +    ///     base: Region<0x1000>;
>
> I'd prefer if we could limit the `base:` parameter to registers defined
> against a specific block (like the current relative registers). Having
> it on all register definitions adds an artificial limitation (that e.g.
> regions must be of a given size, which may not suit drivers that support
> several generations of hardware with varying BAR sizes).

This is more or less intended. Your driver code would have a fixed known mi=
nimum
size, even if your code works with multiple generation of hardware.

It's just that code touches registers outside the known minimum size would =
need
to use fallible accessors because the bar is not guaranteed to be large eno=
ugh.

If the code is written so you have dedicated HAL paths that the register wi=
ll
always exist, your should just create a new type for the larger region of
specific hardware generation and define the register on that instead.

E.g.
   =20
    #[repr(align(4))]
    #[derive(FromBytes, IntoBytes)]
    struct MyNewGenHardware([u8; SZ_1G]); // This new hardware gen has huge=
 register space!

    register! {
        base: MyNewGenHardware;
    }

>
> Top-level registers are currently working fine without this, so it
> doesn't seem justified except by the safeguarding argument, which I
> don't think is relevant here.

This *could* be done, but this means that we need to change register traits=
 to
not have `Base` assoc type but have it as generics. It is however problemat=
ic
from trait coherence POV, because Rust complains that downstream crate can
implement

    impl FixedRegister<MyRegion> for () {}

and conflict with blanket impl.

Also I think this is not really needed with strongly typed regions (see abo=
ve),
hence the design.

Best,
Gary

>
> The syntax (specifying `base:` only once at the top of a register block)
> is a great improvement over the current one; if I were to pursue my own
> fixup series I would definitely have adopted it.
>
> Still going through the series in detail but wanted to raise this point
> first. Overall I think I like the direction, it makes the falcon
> register accesses read much more naturally.


