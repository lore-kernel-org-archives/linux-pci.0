Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021081.outbound.protection.outlook.com [52.101.95.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550A31ACEDE;
	Thu, 26 Mar 2026 14:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774535733; cv=fail; b=aKzZO3Bt/7He2e0kUMCrSTBJiU92etDib51SzMsWFctrI6FPFB6mivNk0ndH5Qec5xjmB0W8J25iX6LsFk8n2vB80j/Fm+M6rOscRmuncYPc8fNN1fHaNPudnY3STp23k8SAF8LneV4xGgwUX8Ures8Vf8R/3zO9gXt8S/a8JBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774535733; c=relaxed/simple;
	bh=TT0QhF/a7kppDmNd8y/RYjoSVnEj6mM4OVkL30WuEX0=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=NIeKR2KHIPpUpk3r3PZmv3uBMA0tN1AFzaBzByEBa+64CiA8+8BpoMloAOkoR15FVsC454bhJxYCVAVS8a5e3wersNbO003puPfjefZCMvZapL/cmaQ6FxqfWbybgmIf4mLK86rN6vmGkF53Iho8jQX1ad3mDAgypdS/dlwRa1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=IUlq9KrQ; arc=fail smtp.client-ip=52.101.95.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="IUlq9KrQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KEXRxXYLAMu0AU4I0ihDkFVTew9+cXthdQ0+/gvJC8/TPFkDLn/RO3Is4aJ/JQAspzNXG276H2JklFdZzajlhJmwS+g0UIU/BNMhVPTSYO8N/N8YSe+t5EYdY0xJU0NJaiW2RTA63Lm9BDpAYBZJqW97BE2Q7M6HEssJAW+sm6/EtoWO/S4jMy0QQIUhR4Dx0YPH+sRrQMTbmsjr1EyNGbrGf2bK+XpE56ZlxLhdozkEye7ZkBRx2evBXgWT+zGLuWB4JhzugWjJxDt6Vm8c60H3OTquelLfWhh/mTAYtC6c2jBD6OAjdGETnTO36x94im2STjnJSSJPnwmRWtdA5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JknpYl/3AIUEbCBOFQh9X1BcQC2/aixiTFuM579loQ=;
 b=InQi1RpZTRubBOYK6GcAhyKSplXgiZlrke3iDsAP/7MgfPrLmJkJY4YkHSMhesJMf/9OrZGlJ14Mqq7dnD0T1+81l+JK8qtWHwcc/Ssb+NW/zb4JYd4IylDuqiNnnRcNaXVQ7J4l+OfP2iQ1F/UAqY2HsIiU2feH8J+MBuAf+CBaRct26zTZmU9UuRcXjXonVE4LrtK9qOrCz3s7QQ5FM4PBLi3cP/dYSHzKL7WwNpXDX3iZodUpwTvW87oEJN+TXFYdCN/jxoaNEdA07HXJTx33y2U2ZYpdPd+pfsYef/N6EE1jP6qhojDluA1cvsgdxBAsHoVZT2ovnrZ7RPeckw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JknpYl/3AIUEbCBOFQh9X1BcQC2/aixiTFuM579loQ=;
 b=IUlq9KrQcaxVQdLyOBH8VlFQsc/D9ODAL6T3wKSnioUAUrD6BPAQB+dHdZMFmW2ilFu/AsWpR8X0ia48MMMOykDdp6sGiGlC6e/37wazCtgnTBsDBZkJJ5PheIv42Ndp0dXlH7Vk4PCVjczwQ+yXP8Qf+j6dVxvQVO7bfnj97Ik=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB3038.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:173::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 14:35:29 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9745.022; Thu, 26 Mar 2026
 14:35:29 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Mar 2026 14:35:28 +0000
Message-Id: <DHCSEZH8M3JU.3LB4M2ERBJSYX@garyguo.net>
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
Cc: <rust-for-linux@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 3/8] rust: io: use pointer types instead of address
X-Mailer: aerc 0.21.0
References: <20260323153807.1360705-1-gary@kernel.org>
 <U_v6wkMtfgu8yfV2Nh5Im8t1w4KZ7mdbG3VQciT2g3DULhsKBXJgIz2psuj76-V94TPNtUry3J727gLTbUByug==@protonmail.internalid> <20260323153807.1360705-4-gary@kernel.org> <87ldfey8nh.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87ldfey8nh.fsf@t14s.mail-host-address-is-not-set>
X-ClientProxiedBy: LO4P123CA0190.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::15) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB3038:EE_
X-MS-Office365-Filtering-Correlation-Id: a11d158f-838d-4342-f5a5-08de8b44ed47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|7416014|1800799024|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	G65AZxdzFeZHd+M9mj55EJmZnbq1k2IPQvGGktbYdo8iWfpQe+uJ1oJnEV5QPmhfEpcWiu+GSIbo6/n0xN51Fh5eO/wXfAh4Kj1b1Braul30PetmDxaYTHG6OVtLW4h5KAYaUzqrhr11dvZywvCxORmNojMNcvjuO8mbELTach6BO/H89wCo+eb8FY3XADp13XEJamd2epwnyJIwvYv0nNRNG+pj05iU2840eObDM2BBF8Zir8eY1T8y9ubTDTIxmtU1pGPtHnzSuYcCza2UIZFxkFWkW2tOhqdj/8JcNTu4z8ta4bM3D+W0ifuwNT83b1g7IUlRXF5cUu3OwSLygYWLih/by1LkQwlvjpoX8j5Ru1BOtil5QHe1Oztozf407q9ozt3dRwTpKwc25cAABqrMvu/6pMlKGn37yyMpcRchS8Q0NRjj53pBbzGBvXr3tjnP7ElSjzqihNvCLcodfd9UpY/kYZtKEApjZZE+LMwNSKCpv0M9LfVoNs1qS548AWFPcG5Kc7d/XwilVq8uKJiscR02mXn2t93YBfL9jzcE2NPYv5Ogg8y3kZ8b5t3P2qw8fqFMR5Hp+x2ZJAgopo/LCLZU/My7zJvDbcMogntG+v+35yeORGklfoQsHEKWlhBLy1QR2E7g4lL0HrDkkMic2GZvbWPBZrJyBHrbX6APMaHVSqSGSOdFn1BJ9EMKKc7vRveEHZ9HKYYBISyg75bW2izCcmcr9aq3hyyRERTyO+fnJfwu2ZfNdI1V6yYOVJyNitz18xugmv/dDemm5A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(7416014)(1800799024)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3NPSUNWUTkyaDRIU1ZZaUI3RWVGZGxHZVNpM0xLNkluQnFrbWc0YU41cW9D?=
 =?utf-8?B?dUVuSCt5NlVxVjNJdUZqanFvTDZPSTRyMDByQWR3blhLZHRlbXB3bnJpdjdj?=
 =?utf-8?B?ZDdRUGV4NFhqdFR4bDFXUmdJQ1ZmbDBNNnRxSnpKVmp4R2NUTDF3K3JSZkw3?=
 =?utf-8?B?TVU1Z2Y1YUVzK0xVNmMydWlEQWtOWGN2Z2tDL3ltN01tTy9xS3haYmNqV3gz?=
 =?utf-8?B?bGNtaFltMUxrSlVMOGZlc25xdUVXeHJjOXQ1dDhmbU5ON21pZHlpdTFYUUxU?=
 =?utf-8?B?UGkra2p3N0JVSGR0eXUzMUdRSWF2VE5zMHJDdjRmVDBXZit5SzQ5bmZSN3Uw?=
 =?utf-8?B?NElaY0tRak4rVTUwVlh4VWFINUYvNkhzWWFWN1kwSTZSR2xuaE9lb2g1OHRC?=
 =?utf-8?B?aGRwTzdZTVlqOE5ibVhULytjdkx0Y0ZDa1Nna2FhWXNEL1NPbmNwUFhiRWFR?=
 =?utf-8?B?QWRTZzc4VnBzaGd4OUk4VHNBS2JSbEdpTC9XN0tYQ2Y5ck8xdy8reENNNUtH?=
 =?utf-8?B?U1JQVE5mNGNrSGhhVW5hb09pdUYwUEZUWWxHOTR4cmFxaGZ5YmUzQ1hXQnhq?=
 =?utf-8?B?eFUwMVQzOHgxNzdWYzU1dExkR1U4ZlVvclJlUk1YelZnNlF3bzg2YTdNKzBH?=
 =?utf-8?B?MzJKNkMxd0czT3NGMXYxdUExUVYyWDF1QjFyN0NkbXVvdmYvdnBXV1FpaEto?=
 =?utf-8?B?NlYrai85NWdQSmdFWHZ3R3k2NHozTHQybzVjVkpDNFRLY3lYQWZ3cWx5ZmI3?=
 =?utf-8?B?WEd1bGFqd1MvZnBMZmdnMVFoUGp6Njl2Z0ZNL1gvRkZTZlFEbjZlZWVBVGVa?=
 =?utf-8?B?VHhQZlU2blFXTXU3WEN1TlZwNHZwN1JteE1pbzZkR1JScmErbG9jUDhxOHk5?=
 =?utf-8?B?eWpDOHN3dFBHUlZyd3F3Wjk2UDlnMWU4OC9FdytLQWhwOVlSWHFIbHJVbVRq?=
 =?utf-8?B?cXJUTTl3RkM0SWozR0xhQVdGb1pldkVvV3hzQnVYZ0RlU3lxc25sNm1yVDQ0?=
 =?utf-8?B?MHpCVWJOYXlPdkJ1OWlxV1NLNUFkMjBTc0wwU3kyMHRXWDBLS3IwUUxEblQ1?=
 =?utf-8?B?dHNGekluaVdWTllkbDB5Z1JtWW5VczI3RHJLQzk1MzlQLzE2NWJtVnZ5TEJt?=
 =?utf-8?B?dzRXK29hbWw3d2JuMWFvbW9waWxyd0ZqZDJqK3MvY3pEUlFUQmxLRFpqV1Za?=
 =?utf-8?B?aUQwc25uMXlaN1dEZzVPUG8xR2FOengvLzlIYW52YTZldGk5Y2xMKzc3SFFS?=
 =?utf-8?B?Q3VkeEgwUzE4UStEc1FZSmE0aytMRkVVM2FaMkVnNXFjd0hacDNGSkMrMFM0?=
 =?utf-8?B?S1ZVTWk4WG5hNXl5WUQySG1JaVNQL0JoMVp6R1FDRGl4TmxXdjQ4cVJMVm9y?=
 =?utf-8?B?N2IzVVE2eTFwbHlOUTBJSEludjc2bEtZbXpqdnlkRWxFSjMySDh3V3pkR0R3?=
 =?utf-8?B?UTkwelV1azRsdlZ6N3VZa0lxTVdiU2dYZjF2anppcnUyWFM3cCtMaHZWcjRS?=
 =?utf-8?B?MFFDaURJTXFQNlpWUnhhY2xZc2RidGtJbzI1VmJyS0VxOFI4N2xMTTFWbU5E?=
 =?utf-8?B?clhtUDduMThoL0J4NFlBKzJ0MG5JUVVwRHVuYzd4c2Vka3VyakUvdHBkSXBk?=
 =?utf-8?B?ZXVlWGl3U2FqbURpZytNK2xGeWYzMmlyWk9NanVtZFlWcDRsZ2U2eG4yM25u?=
 =?utf-8?B?VmhudkhsQVVRaDdGM0w5TjdBV1RwQmdzSmt1THdIMGMwRHo0UjFjMnZqcTk2?=
 =?utf-8?B?NlNPL3h4b2djRkdMMlllSWN5NGxIcnF3eGRDdWpCS3V1MXNtcnl2bi84YlNS?=
 =?utf-8?B?ODZnTDJQMUl4YWpBTUwrVHIwL1JsQ25Fa3VTckNhSTcxMC8wMjEzZHc0eFhQ?=
 =?utf-8?B?TG5hNVNRRm0yVFllL0dRODd2ejN3NXNKd0lPSWk1TTQvNUUrOTNPMHg5RTVO?=
 =?utf-8?B?T1BLQlZSdVRTQm90dFFHVHFJanl3MHRmMW9UWkV0YUFGcGRkVndCUFlyKy9V?=
 =?utf-8?B?NURodFQ0azJ6R0QraTBEdm4wTWRISUwzbXBOWkRoN1NlL21tTnV6VWQ4bENH?=
 =?utf-8?B?YXg1KzZxNTBjU0NORk14eVhKaVBoaG5qZmREVkkzbWlnTERVMlJjekdqdjI3?=
 =?utf-8?B?K3pvbUxUKzFhd2o2K1JWWG8rWXV0MnoxUEJBOEZqMlVvK3RsT0M3TjJ5UU5Y?=
 =?utf-8?B?bHB0L1RDR1NCY1JkYmtiNEZod1NmZG11c1RoSW1zVDZkNVZLSkFBMWtIZjJE?=
 =?utf-8?B?ZkNCRXJHN0VxbnBQbGp0MnNVSTJtVStacFN4Z1laNmREQlpDVVdGeis0SlFB?=
 =?utf-8?B?UkdycStKa1NoM2dMMFFhOUdBcjE0TkhQM2ZYM3JWMElqaGlKcHp6UT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a11d158f-838d-4342-f5a5-08de8b44ed47
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 14:35:28.8915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QrQ3hDBXTYiCpGleVJPVU3X8XH/K/Q1r6DY6NegbivjCQl5hixcefKOm5SAvhrhgv+P6x4q423LBFPf442Tiog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3038

On Thu Mar 26, 2026 at 2:20 PM GMT, Andreas Hindborg wrote:
> "Gary Guo" <gary@kernel.org> writes:
>
>> From: Gary Guo <gary@garyguo.net>
>>
>> This carries the size information with the pointer type and metadata, ma=
kes
>> it possible to use I/O projections and paves the way for IO view types.
>>
>> With this change, minimum size information becomes available through typ=
es;
>> so `KnownSize::MIN_SIZE` can be used and `IoKnownSize` trait is no longe=
r
>> necessary. The trait is kept for compatibility and can be removed when
>> users stop using it for bounds.
>>
>> PCI config space uses only offsets and not pointers like MMIO; for this
>> null pointers (with proper size metadata) is used. This is okay as I/O
>> trait impl and I/O projections can operate on invalid pointers, and for =
PCI
>> config space we will only use address info and ignore the provenance.
>>
>> The current safety comment on `io_read`/`io_write` does not cover the to=
pic
>> about alignment, although this is guaranteed by checks in `Io`. Add it s=
o
>> it can be relied on by implementor of `IoCapable`.
>>
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>> ---
>
> <cut>
>
>> +impl<T: Io + ?Sized> IoKnownSize for T {}
>>
>>  /// Implements [`IoCapable`] on `$mmio` for `$ty` using `$read_fn` and =
`$write_fn`.
>>  macro_rules! impl_mmio_io_capable {
>>      ($mmio:ident, $(#[$attr:meta])* $ty:ty, $read_fn:ident, $write_fn:i=
dent) =3D> {
>>          $(#[$attr])*
>>          impl<T: ?Sized> IoCapable<$ty> for $mmio<T> {
>> -            unsafe fn io_read(&self, address: usize) -> $ty {
>> +            unsafe fn io_read(&self, address: *mut $ty) -> $ty {
>>                  // SAFETY: By the trait invariant `address` is a valid =
address for MMIO operations.
>>                  unsafe { bindings::$read_fn(address as *const c_void) }
>
> Should we change this to a `cast()`?

This is a `*mut T` -> `*const c_void` cast which needs
`cast_const().cast::<c_void>` which I think is less readable than just `as`=
.

It's also existing code that I haven't touched in this commit.

>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
>
> Side question: Can you explain a situation where `IoLoc::offset` is not i=
dentity?

By identity, you mean the impl of `IoLoc for usize`? `IoLoc` is also implem=
ented
for registers generated by `register!()` macro.

Best,
Gary

