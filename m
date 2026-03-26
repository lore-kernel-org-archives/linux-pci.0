Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022091.outbound.protection.outlook.com [52.101.96.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04433587DE;
	Thu, 26 Mar 2026 14:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774535572; cv=fail; b=TkQMgf7Ny2bx1LJLW2dZfQrhuzr7qjPUBiE2VkXxOeqM9b7yxKnJoek95hZi9hBdQhUqj3SVUBTASZvqFK9MYFqNt4Id/kL21nQIwSrDnp30OSZg4IWLB9dKgs5J1m35sIwSmqVedULLcYsHI47q0iTraOjbNgVDAMjk6ggUOdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774535572; c=relaxed/simple;
	bh=Dxo06wUc9ylyEJEKuydTAR+3AptLXESdyf12lqpUmaY=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=JfOwqt4nw5b0J/zva4D48VmblBVBTtJJPlZjI/Rk9Y/Mvau49lux8gXuF1cD74Qg6z7p4zMzBZuo7r8T5qXpwMgrP/cMpf+bDvuS4TDy91y/GTsg4sBFHmHny4n2CNvjRK1Dg1VMOJJ7urTFtyn+REb/SKkLeeYrkA11TYAEOhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=zBp74hVf; arc=fail smtp.client-ip=52.101.96.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="zBp74hVf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RKtuonAsiVhkXdOs4Mnqej5shtOD3NjT2jTXz38XDKyOpp7w/xQDkCw26gFTcODD4FXdSWuuXkgT60R35wz1l4wQC9macKc41wizsU4gS77it+9DLwJtIfUC3WdwxuI29TxpV4rXR7C7B/rIMQnxWkpITZk6VdTG2mNzkdDySyBLinnkiqr6kAv7WXQXdHYdfIXxfPDtHGnSiarWL3xtSHPljXkqv1bSJNG4H03foMpnqm1pAaxsQ4pVzNbwqty0m9JRSWsoZUXiI1zZUwFcW5CtguOhcSiG/t+GxWCDMZsanBj+WCDzCYvX0IFWRQrsjDiSLNNJgLnO+Z0IU1Sa+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcLWnF9zwlREze8qZI2/QTjg/LRrqpWfeAVa7b23zNQ=;
 b=WIuQZTynu1jWl1culxd9YhQB2BTDURoSmRqDvCSSlXR7gIQ16kAxDGaylwuBmbZew8CLZumUxn6xczZ2XaAb8yO/zlakf7CA3ZZqTlfmJ17VLrhTvH2+Tt3iHfUaJIQyIIKato+8kTI5fBNXDFTOK+86Tue4EOPGqWeOO10hAFuyfiPZzkOYUBnxjQlmrE8fteAw6YXvmtWYw9ERY2WGOpVhlnQrAXlJEZhuHUx/qiPAEthqG/CvwKRG3CiYfzJOfy8AQFGx9Fz8m6OTIZunjCN/5jOg5P1ji8jXfAoMn/8iWuGayfsjFBua+61z55ITt8Y6zRYQpsLPzZES3hQhzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcLWnF9zwlREze8qZI2/QTjg/LRrqpWfeAVa7b23zNQ=;
 b=zBp74hVf3PVLXxfsZfQsViDOkyY5SokRIH49lTgyBLci+K1tRvj/0pf0EAExXs2DM7kRpS1snjGVwT1piao5r+LNWt1Cz78+L4BxUy6tjNUJhk8MmL2LTQW8VlyqiA2OQm6JDDYEYwUSf+nK6B2Nnq8rDtDAY9gWt4jaPbCTNBM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CW1P265MB7427.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:217::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 26 Mar
 2026 14:32:46 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9745.022; Thu, 26 Mar 2026
 14:32:46 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Mar 2026 14:32:45 +0000
Message-Id: <DHCSCWVI38X2.2K7DBY0YPBS5N@garyguo.net>
Cc: <rust-for-linux@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/8] rust: io: generalize `Mmio` to arbitrary type
From: "Gary Guo" <gary@garyguo.net>
To: "Andreas Hindborg" <a.hindborg@kernel.org>, "Gary Guo"
 <gary@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross"
 <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260323153807.1360705-1-gary@kernel.org>
 <_GdG2BR4qqT-8cwpiurteKJJr58WPTCsM6UyCU0NsA1DK6yTNMiSGOBZlm79OMaLm_tIMM7feHDx7mKljWea4A==@protonmail.internalid> <20260323153807.1360705-3-gary@kernel.org> <87o6kayc5t.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87o6kayc5t.fsf@t14s.mail-host-address-is-not-set>
X-ClientProxiedBy: LO4P123CA0414.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::23) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CW1P265MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: 1881593f-5ea8-4c20-8b2f-08de8b448c84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|10070799003|7416014|1800799024|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7IzpuAnsg7Mem4yueHua+Ctl+HmisbqTM2wJ2Iu9X/bf6jb2e4fip25vkV3rv6DX/nVXDXh2OQJxjet0Ni9u/G6j4p0QteuL0pHRtfGznbldjRxp7Z/NoCBXPzIymBaTD9yvI+dwEtlSCuHTwEyXLWvkeKV7fpOZNbKnQU1v5GkU2Nigq1J7nj5OAH7+Tn9+OXwUsLl/6xwkk+qdhH4LPdVJAijJrPTgdzFxs3zQFBQJAbyk/aSIngl7DUGYZFu8PUTcbzZKM6HN/GoQIGEhNSrCLrOXONgpMBNtPCOBNkbxoTUjkZXfnO3y+kEaYwKzdwmLrEGzIe26gWBI/1UwfAmt9ObhfR3pa3c+vyK0GzjZpdXGFiHQ5aUzqcSeFCKYLewHum5xVp9mGGwbr/uqjajz898c9TIbzNEkvTBCGRg8jf6PqsogSwgnf7qQ/m/o1Vvie9aO4rHAkrL938FGpwJOypn/B0t2esbOMZ1TzxHlMgIlOc8XOBZkm9NfBUY+GjZh2aK35Wfn2YfxqO1lNqzaDcM7JGtyUGoIX3NQd2iUzNWX0U2Rag+3TEIfo7hwq8FrupHWnsD/Cfe3yC+AfOOB3x+UEIWSNE6jk2l+ToCrMIYoMhzUP0YFQxp5ALdPGWQ5VTykxxruRIOOCi1Szkg9Glu3Sz/NBwE8c69rG4kQ2Ac6rHHHGDmJyZ0X9y0KpJNpZeMzKUoIlOp7HX+tlZ2trqNVFvX3lu0f4n8m+ggBXms9FowJRS9UDIy3N57RwUYNmVvXGF4fQsj35J/gDw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(7416014)(1800799024)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dS9MMGpNdm9oMjVCUlNXdWk1QkpuVXlvU3RXR0xEY21Ha3BJVXpHR3RPSk42?=
 =?utf-8?B?TGttZ3lVYnhoUkIzbGxHRmlFV0NmMkhhbm9vbUx3VnZYSDB1ZnlpN2Q3YldQ?=
 =?utf-8?B?aWhVOWV2L0J4bjV4YnVPb1U5L3J4V1JqTmlLS0xUVno2WXNaWjE2d1BDM2dM?=
 =?utf-8?B?TWN2UWl0c0UvUUJXS3ZzV0tEYTE5VmUzaEI5K3RyeGREaDl2MFFhMEFESW02?=
 =?utf-8?B?RzFscTV2VVRoSHNMaHRrdmE0TkVscWNZSzJDTGxjcjRtazgxN3NWZDVkZVZU?=
 =?utf-8?B?aWdyQjlaMnRydjUzUTZmeVlzUzVNWGkveXNwbUtDMnVzY2pyUlB6SVV6NUtW?=
 =?utf-8?B?ZXRiNVQrVkN2ZEFWbUdMZ05tZ0M0eUQ5RERZeW1wU2pLeFowdmdFVXd2MDk2?=
 =?utf-8?B?NTQ2NVM2Vk9wWkdmM1JWZGNza3NXNUtMOGg0YXh3SGQ4WjVEanY5S2hhdnFM?=
 =?utf-8?B?aUh2ZlQwNHd5NVh1ODJ0aFlaeU1zSHVBelFnVGxwUlRLK0lKSmdIcnVwT2Y3?=
 =?utf-8?B?Qk54Z2V2RWU2MldwZXREQ1VmZG9LV253THJUT3haR21QYTNtcGVRUEp1RlBq?=
 =?utf-8?B?RlNiZ1duTUFtQ0hTY2U5RER0ZU96UDZQSnArUGVuYXZHZUtWQ2hLVmxwaU12?=
 =?utf-8?B?RCtMN3lOVHg0TEVWTEgwUmVjemo5dzdnRFZ0SnhGNWRVMVVkTk9qaUdKc2Rz?=
 =?utf-8?B?M3UvcFplQzhCMEx4clBYN0dncnZ4TERiTXRocEtVczJ2ZSt5ajE4T1d2MWU4?=
 =?utf-8?B?TDJnSnhOUnd5VGpISWljc3E2WkJlM1VtTXdWSjFIUDA2WnlDbGtveVJ3TTBZ?=
 =?utf-8?B?c0dKdGF3UlJ6dVF0bW1MNS9yNXQrMmYwdkdXL2tyQlZaQzBQMFpaK3hNQXVs?=
 =?utf-8?B?ampvMDFHM1p3ZUxXd1B5MW9kcHZoMWV2SVRBNiszYVQzYjBXSmJTbU9QTk5F?=
 =?utf-8?B?M0kxMWtyTHY5bHBGY1Uxd3haTlhwaU1lNGdXWjdiSkZhRnVnME5vclhoVTZQ?=
 =?utf-8?B?YUZhUXJCZHpCMzRjV0pmSHkrL1JXS25UbTZKSmpTUzIxNVprbENGS0Y2c3Rh?=
 =?utf-8?B?VWIrdnV2Rm5BeVVhWjQ3dzJORWwvZ2JKekdUQ2xqNlk3UGFjRFdaSkR3UVVN?=
 =?utf-8?B?WFdOZjVQeVIwZXVLZmdRMEpsT25HZm5kVVhHZVR0aEhVYVU5L2J4c2RhQ0x0?=
 =?utf-8?B?ZXZybVQ4RnZDeTQzMGdIY3FZOGNkTURKSkx2L2J1c0VaYU1IMUtOY0tuSmNE?=
 =?utf-8?B?NSt3OHBwb0NtcVFqeFBUUGI0V0ZzV3B6emZRdklJZFlxNUV4aitVY0hLMDZO?=
 =?utf-8?B?ZGdjQWpkZ2VqVzhaWk9ONUZEQkpSbys4VnRxUkJ4ZWQ4WkdlbVQvRklOaFJi?=
 =?utf-8?B?bTJEUFJUSmxJMEpnS05WRE1jcUljTnlOUHc0Um00WUF1ZkdpVXExN2lkbHh2?=
 =?utf-8?B?Vkh0TzZzRCtEdXBsT29DS09NRFBOYk1ZMEx4OEd6UVBaTVBuSXlDT3pvK2pL?=
 =?utf-8?B?Q0pYMmNDT1FsTlZNS2M2bTRKemh3OVM4OWh5M3J6OGVxMHNuVitqbUIrQVha?=
 =?utf-8?B?bXo4NUViQ3NhdzdROWlrVkwxOGhKWmMvNXJ4ZmVabHAvbzdyV09YbEdJU29a?=
 =?utf-8?B?dUFGZm1ibkRGSStnbGt5NzhMYUpJeS8rWmdvZ1JBTDc1ZUlmaXZLRWhxSkR2?=
 =?utf-8?B?d3VId2N6Znl2T0xCTGI4ME9UNVBwUjk2S0RVN0d1c2grOXh5M1ZVMC8wNndM?=
 =?utf-8?B?T0hVWHUwVzEwNlpoNk9pV1lRdnJyTmZPYmVaTStRNEUwOWdxYWI2a0RxeFhW?=
 =?utf-8?B?WEV4Z0RpN2orTjhzWGVhejdCMzEzdW16SEtBV1B0VE4xRkc5Y3JiVEdmN0p6?=
 =?utf-8?B?UUx3VWlDeWlGWVJOVW5VL2VEN0hBK2FsZmZkeW5ETXdMOU5WYmxOTktsM1NN?=
 =?utf-8?B?eDdBWjU1c1JsbDlMRTQ1cHNrL1didWhYZEZpR1hwN0l2TUVwT0FlUFpucGly?=
 =?utf-8?B?Y1FMZlJ6RHNHWXN2R3ByUjhaUWJNQnIvMS9CZElhazNyQzhGM2VObjg3V08v?=
 =?utf-8?B?OHlVMHVYaENMQTFCWVVjS291OFpiOVBqNUNYTWYwbkQxNkFUVkZYZDRGUXp4?=
 =?utf-8?B?U2l2aHBvYzZlQlFRdXV1M3pWYmdjVmZOb2hiQnUrVFBCZmd3KzFmWnd5MUZ2?=
 =?utf-8?B?dllwNUZkOG03eXR2dGNkaE5KVE91aTdkNzM5RjR1Q05zNGpzaFUvK1p5a3BZ?=
 =?utf-8?B?dGVOdjhLd3Y4WG9KczIxUWQ3K0JlNjlBMzF2Ujh3OXhocS93bVJrR3ZYQjhX?=
 =?utf-8?B?bEg3WEF2Q1o0UXllYVJmMVorUmZobnVvWnk4OTA1YkFFbXNBekJSZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1881593f-5ea8-4c20-8b2f-08de8b448c84
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 14:32:46.5683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LIuMAmTKSs3RrAnd/cxZH2890mRdgXjlfIBj8+TAcsbfb7k2nSMxhOd2GhekcUHiWWXPvcXpT5jy0R5BnkZFnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB7427

On Thu Mar 26, 2026 at 1:04 PM GMT, Andreas Hindborg wrote:
> "Gary Guo" <gary@kernel.org> writes:
>
>> From: Gary Guo <gary@garyguo.net>
>>
>> Currently, `io::Mmio` always represent an untyped region of a compile-ti=
me
>> known minimum size, which is roughly equivalent to `void __iomem*` (but
>> with bound checks). However, it is useful to also be to represent I/O
>> memory of a specific type, e.g. `u32 __iomem*` or `struct foo __iomem*`.
>>
>> Thus, make `Mmio` generic on arbitrary `T`, where `T` is a sized type, o=
r a
>> DST that implements `KnownSize`. Similar to the `MmioRaw` change, the
>> existing behaviour is preserved in the form of `Mmio<Region<SIZE>>`. Thi=
s
>> change brings the MMIO closer to the DMA coherent allocation types that =
we
>> have, which is already typed.
>>
>> To be able to implement `IoKnownSize`, add a `MIN_SIZE` constant to
>> `KnownSize` trait to represent compile-time known minimum size of a
>> specific type.
>>
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>> ---
>>  rust/kernel/devres.rs      |  2 +-
>>  rust/kernel/io.rs          | 63 ++++++++++++++++++++++----------------
>>  rust/kernel/io/mem.rs      |  4 +--
>>  rust/kernel/io/poll.rs     |  6 ++--
>>  rust/kernel/io/register.rs | 19 +++++++-----
>>  rust/kernel/pci/io.rs      |  2 +-
>>  rust/kernel/ptr.rs         |  7 +++++
>>  7 files changed, 64 insertions(+), 39 deletions(-)
>>
>> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
>> index 65a4082122af..3e22c63efb98 100644
>> --- a/rust/kernel/devres.rs
>> +++ b/rust/kernel/devres.rs
>> @@ -106,7 +106,7 @@ struct Inner<T> {
>>  /// }
>>  ///
>>  /// impl<const SIZE: usize> Deref for IoMem<SIZE> {
>> -///    type Target =3D Mmio<SIZE>;
>> +///    type Target =3D Mmio<Region<SIZE>>;
>>  ///
>>  ///    fn deref(&self) -> &Self::Target {
>>  ///         // SAFETY: The memory range stored in `self` has been prope=
rly mapped in `Self::new`.
>> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
>> index d7f2145fa9b9..5a26b1e7e533 100644
>> --- a/rust/kernel/io.rs
>> +++ b/rust/kernel/io.rs
>> @@ -44,6 +44,8 @@ pub struct Region<const SIZE: usize =3D 0> {
>>  }
>>
>>  impl<const SIZE: usize> KnownSize for Region<SIZE> {
>> +    const MIN_SIZE: usize =3D SIZE;
>> +
>>      #[inline(always)]
>>      fn size(p: *const Self) -> usize {
>>          (p as *const [u8]).len()
>> @@ -169,7 +171,7 @@ pub fn size(&self) -> usize {
>>  /// }
>>  ///
>>  /// impl<const SIZE: usize> Deref for IoMem<SIZE> {
>> -///    type Target =3D Mmio<SIZE>;
>> +///    type Target =3D Mmio<Region<SIZE>>;
>>  ///
>>  ///    fn deref(&self) -> &Self::Target {
>>  ///         // SAFETY: The memory range stored in `self` has been prope=
rly mapped in `Self::new`.
>> @@ -187,7 +189,7 @@ pub fn size(&self) -> usize {
>>  /// # }
>>  /// ```
>>  #[repr(transparent)]
>> -pub struct Mmio<const SIZE: usize =3D 0>(MmioRaw<Region<SIZE>>);
>> +pub struct Mmio<T: ?Sized>(MmioRaw<T>);
>
> Why not have the `KnownSize` bound here? I think that would be more clear=
.
>

There's no need to put bounds on structs unless you need them for `Drop` or=
 use
of assoc types.

Best,
Gary

>
> Best regards,
> Andreas Hindborg

