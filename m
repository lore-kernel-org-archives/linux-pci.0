Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022073.outbound.protection.outlook.com [52.101.101.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D344B401484;
	Mon, 15 Jun 2026 15:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781536394; cv=fail; b=Vrd02BUH0VhsYIoYj1rQAV/ADXzhbGpqoBhvkXH6/p7sDD1ouDALXeb/ASZDO63lvnWWIyN/GFwUJ93yM9nMX6v6yxNbWBrmi0dkguUez1B/1Hu8cgg/JRFOzuYtPbym45Zu9mR6adkuZhHxjJQE+MRbLWzfwHEOuBA6aCbup/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781536394; c=relaxed/simple;
	bh=uzT7AJ1t75MbKZmH4Z7HiMjWbwki/Tv1UCe9li1FrT4=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=Uev5926FlFq7nVgmOLeJouTvFlT6luo9fwkwR8HW8iW6egM60dtzAC5az7BTiuYEOCgDzIv1PMGQAMbpGXF4ChANEFtwc3dRSpjf5TDzGSdnoZZm0OmunD8z1VVbkuy9QIvNDDXBD8PBzCPgElWiYA/N3gVfAPTCKuJe3cG96DI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=P4wKzmYP; arc=fail smtp.client-ip=52.101.101.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="P4wKzmYP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dl2ikhImH82hJFh5Rd+oe/1d51WL3cpjyaw0YeUGMNP4W++BXi7n2dXzBnUqmO8/BgyzO6jtLD9pRbcOjHXoBGDNkjHTebSIrzicUnw8jhy0MG9IX4jGEAuiV0ZoUHrEtUpQzYibb2m+F/FyDf5jCf533ycceteifBtO5dm4+EPw2sppE9ECoIlV2ZCyquNkQurmwL61zvR7iV2cAL5yBVIGe5cNUiO6oA4xSlRpENNzaPXQacewjajDMa0yo2rHt2QIv8+CgH5r6hpFYVNVfOcJoL1LUlW14Dh52uGjw7/kV/KKOaB9klUTN2MX2NhA5+ycxfRCp5bp8+ExcSIhDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPgmbFGRGc+BgS+/4BR6ROcDXAkmehDIC/qNvCJJS6I=;
 b=w3/monCXno3NsASTH9k4ii0f7NNuypEMEgNGlysJVaI+xN0wHvcUo00EUUpvspH3ahokcDru378miGpkYfXtwfZY1Yj5TSEOh0gwuxWU2KlLbpCLQPOWwllmBQeulIjDINgdy32C0mh9WdlpC1tt+tflUL/OOJL9m5pf/Ve5NgxKGRZNg3lF6g4y+X6GvhtVqNbDhRB/4RGocX01FSxULPYvJY2Fhq/+I3Q3fK+Xcdb+lYvh5sSa4UmBEigsG/O2NUELKIHcZeRrqTyzt8qE7m1VwFmro+Fvqz26tXLi3/zESVN1Fq5D37CgczvEa6B/0EXRjjAgt/H9CHa9PL2B3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPgmbFGRGc+BgS+/4BR6ROcDXAkmehDIC/qNvCJJS6I=;
 b=P4wKzmYPohQ7jnB/20Sa4AfuGFkswcodrIHuRK/3Q9/ebBYm5AdxlCsJ2mhIWfrOqAkVevNEC5uuA87QJvXVTQtufYSzt8Ven1HDFDBCdiq500udMMapB1EpwOLc2v4UseANmcOuK1jgfeHVpEkhEA/+LnYFwZxEZFEXRYzTv7c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB2487.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:9b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 15:13:09 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 15:13:09 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jun 2026 16:13:08 +0100
Message-Id: <DJ9PXYB91UDG.3BV4EJJ10RIC4@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo" <gary@garyguo.net>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Abdiel
 Janulgue" <abdiel.janulgue@gmail.com>, "Robin Murphy"
 <robin.murphy@arm.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Danilo Krummrich" <dakr@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v4 07/20] rust: io: implement `Mmio` as view type
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260611-io_projection-v4-0-1f7224b02dcb@garyguo.net>
 <20260611-io_projection-v4-7-1f7224b02dcb@garyguo.net>
 <DJ9PI9NEJ92T.3D0E90RPSCXA2@nvidia.com>
In-Reply-To: <DJ9PI9NEJ92T.3D0E90RPSCXA2@nvidia.com>
X-ClientProxiedBy: LO4P123CA0385.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::12) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB2487:EE_
X-MS-Office365-Filtering-Correlation-Id: efd169a5-b8b8-4fd8-c406-08decaf09bcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014|23010399003|22082099003|18002099003|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	Up6QCLYUOv+PE9ogj+XSBPxzndc6AUTtMPVpe0m4C54yon1jSc+ogWLm80nDTIy4fS1FBSKCgIzOX/929bqqn6PlPQWBylkZKtHV6mYkxV0fVBR6+sFN58WOQ6PDkoPd5zwvXBJoeYq+BrFsEiDhQYYUaVLS5tn5m8trmJ77funGjz77a3Up5IpQJKZtS58MBcMKbWD1PADnEG8VWa0+BSB/AvTsfLeVsBkvHM1zEJMaBWynLmPIIYzCz36VZSWcm1iphwXxb3YM7PU0WsQynQWMTitmLDECYNpPGnwEI5e8V1Y3Nkat+4krz+AXNVFXk7FeAaGxR/jAilmkFzWgUuLTISVWQy5hAHt3bnxrkcbfJaq518BzYurrKqGMiXOrqGE2+PZlWfprj94uyDZJli4w7Dw8zfUne1zsS49C+Khyg0A1/7BvJzibDyaKBV6+1oTJuLVaDcMTlhoN4l71XgCygUO6KQ+TD+AqUGTJNBh/aiXXzrRUpqmNZW1lMHGtOoz27FwQyjBURzXAG4wAbJXBCnFgH6e0jmZ5vKT3GkGtrXtzRw65Xc8u4hBZqtfkzrjVHUYFZXnLnXkF0KhcwDxHTX013Ypp1OdcICNJqM/C+iJOGh/IgO+ujicAxU4ZdGfr3g/HjjLPvOXLGhfDOVSzBiTDfrY8yLATB9c3UgcHCAxCQ4rVkia478AAEVTw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzNwVlRoK0Q0VEg2b0gwdVI0eFcxaktzcmxvK2tnVFBpek9mSXFHSjFTa1pT?=
 =?utf-8?B?dDFXUnM2Ukc0NTR5WXVhQkVoZUhKdGhPV2VHRDkvN2wrR2VCZEl0a0JvUnJ6?=
 =?utf-8?B?WDZHcEpzR1I4TlBTSTFEeFNHaElkQ3p3a2ZMZ1FLUVpGU09PL3haNW9BMGVG?=
 =?utf-8?B?ckhvbUtwaHZvQzA1SWFZNkdTdGE3Z2VQMEdFSE53dFZDTE9vNmZaM2dmU1My?=
 =?utf-8?B?aEp4K0hGWnhjYWhhQ3d2UkF1cy9ZMVFwQnNZTXFBekVra2ptOUVsem0vWUhL?=
 =?utf-8?B?aEoybzBlNW15R3FVNjNiS2p6dENlcTJVeEllVUo0YllIMkpWYlFIQUxKQnlH?=
 =?utf-8?B?UTRWRUcvZkV1Z2l4NmdUQUF5MzBjYllzL1VRd29vUnBlMmtoUFgyN1UyQlJS?=
 =?utf-8?B?RXlTOHVzb3hpMmFXYVpOOStVWWR0MDdrSmk2WUxtR0J3Wml2SkE3b1BtTWFM?=
 =?utf-8?B?L0NNT21mRHIyMWYwMENyRFh2TjRCbDR5YXc4d3R1b2JTVDdpVE4zdEJ5NVIv?=
 =?utf-8?B?MUtseUlpcUorc0tjTmM3Q0VZV0Rxd01UZXl2NlNvL0hodDJuRDQ0QXN5OFZt?=
 =?utf-8?B?Qm1SY3lWdUp4bThSaFNlelJGeTJQZ0tRdVkyZHJ5WFNhUFprc0EzemJwMmJ1?=
 =?utf-8?B?c1VkVUR2ZmI0OTE2T3ltYzRnL1NmRk82TmN2THlRQjBQNWJCanljMWp2WE83?=
 =?utf-8?B?YWhnOFBFWkxrekQ4RFJmV3ZkSDlhMk5wMnpIWmlZQ2hzNmtYcmFuL1VZeDRo?=
 =?utf-8?B?NXduamZlRDJpL0RiQ1NLNXFrc05nWlRyaS9hZXpGem1JcGFYOWltWlZRWGlT?=
 =?utf-8?B?SEx0bjFEY0V2ZXVwR25WV3NUZjVlWHhjZS9PWkgzd3Yra3B1NE9vVHozREdy?=
 =?utf-8?B?dXIxMDZQY3BIS010SUtPVVlQUXFPWEt6RkNZb0YzZU03bUNPNlRWbkcyaWxr?=
 =?utf-8?B?bjZnNjl5VHhLeXhWY2NWaU9IdnlHOVdVOTRvODkvNkFWTVl4RllqSlRseGN1?=
 =?utf-8?B?WnBmajh0VlVVU0t3K2ZkdzZjTXFsMXhYc0lhS2tVMWdBLzFaNVJ0UEpLVHlS?=
 =?utf-8?B?aG1UMk15V0lMVEhBZWI4M1dHT21iSlNydGZjZldmZVZJdjNZRVIrU3lMMVg2?=
 =?utf-8?B?Mlg4TnpHbXFhZ01YV2NlT1Q2SEhFWVdZbDZUbFVjUkdubWRLa2xSZWFHNGsw?=
 =?utf-8?B?eW02OVlmQ3dJek1tMFNwSlk1cXc4M0ZVZjFhT2cwNWh1aXdKVVVZWXN3bmNz?=
 =?utf-8?B?WHliSnV2WHE3TlpyRkF4UERLSjBucW8rcWVWQWduRXNxeFFQbEhWMi9lQUVE?=
 =?utf-8?B?U3FjNi9HME1SVWZNTEU1dzluV0ZqWk83WHNJL1hrZy85Q1duR2FxU0ZwN1NV?=
 =?utf-8?B?QlFXalFmbWdRUWRxYi9UWHZ5NE5aY0V6djNqRXNvNWtXMU1DaENtb0t3MFY2?=
 =?utf-8?B?d2gyRllFdlV4a1Q1SUU4TnYwUDE3RDRyQldlMjBZQ0d0T1VIWUVXbGwxR2dl?=
 =?utf-8?B?eWVRblEzZHRhVUdRY3EzUUc2WnBYbHF1ZFQzeWphMVlWYjBrVTVUdlFBUzdN?=
 =?utf-8?B?VUoxNS9hdUc1NUZnYmdUV3NoRWlsNWtkd0RNM3JSbzFBNHgycDFNRzJyQllk?=
 =?utf-8?B?WUVCM0RWRXZZancxNEJxdjdLdFRYL1RlVjNPbUZYWURRdmRhVHE5MGxVSUc2?=
 =?utf-8?B?bGkzYkJiK01BdlRncTNma2Ywc2pRd0dZUWpIanpZeUVZREt1UDJSVGJyRFJ5?=
 =?utf-8?B?OVVWRmFpYnRVanluNE1SV2t5cmEzOU80U3NXdnMwelBKK0ladVR1eElCQ1Fm?=
 =?utf-8?B?TWlTUUxLSGpVQU94QnFmUHE4RXZNd1BEbnljSzRrYVgvc3k2NnJFQVlicjlr?=
 =?utf-8?B?VmZVYzVTUlhoZUc1UXFNOXo0Z1ZxVjFncENKcW5ieWNIQ2Y4RW1JejRBRFJP?=
 =?utf-8?B?WlN0NldSVnpFYXFuY25VRXJYd3EzdmpLSjl3RDFLTWlSQjIzYitJZ1lrTy93?=
 =?utf-8?B?LzNtTFl5WUVHK2pSeWNncWxJR1JWQ2JiS0ZHbGl1V3JhaHRpODZqWGYrTDF3?=
 =?utf-8?B?Z2tneXpxTXo3OU1oNFIwc2tsNk9RQ294UzdtTTY3ejFNVE5wS0FnMzY3aGdP?=
 =?utf-8?B?aWRHNW1Zb2ZWcE8yT0RRM2RWalJVNThvTE9kWXllRjZ3eVRnLzNXK3BFckYx?=
 =?utf-8?B?cVNLRGxTUTkwcjN1ZE8zWjA4amprS1daNW9Nd0tTRXd5eC9vU1RJU3FRbVUv?=
 =?utf-8?B?akhRYjVUd1JOZDRhd2tuWklOUzYwcERLdFVodFNvckpTYjJsQlhHVXRocnpr?=
 =?utf-8?B?VjRnc2JSOWZzTFJoNWJjWklXS0QvbUxtWEpIT0JnZmhsQ3lwdjFFdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: efd169a5-b8b8-4fd8-c406-08decaf09bcc
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 15:13:08.8885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S37yepC3RpGCnwIy2+jJWzVwlUf88JLar7jx5pkQ4t9kMyoPSq3TE3ylCNY4kUeI1Ae8XHZ81P+Vd+fTsuHXaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2487

On Mon Jun 15, 2026 at 3:52 PM BST, Alexandre Courbot wrote:
> On Fri Jun 12, 2026 at 1:28 AM JST, Gary Guo wrote:
> <...>
>> +/// A view of memory-mapped I/O region.
>> +///
>> +/// # Invariant
>> +///
>> +/// `ptr` points to a valid and aligned memory-mapped I/O region for th=
e duration lifetime `'a`.
>> +pub struct Mmio<'a, T: ?Sized> {
>> +    ptr: *mut T,
>> +    phantom: PhantomData<&'a ()>,
>> +}
>> +
>> +impl<T: ?Sized> Copy for Mmio<'_, T> {}
>> +impl<T: ?Sized> Clone for Mmio<'_, T> {
>> +    #[inline]
>> +    fn clone(&self) -> Self {
>> +        *self
>> +    }
>> +}
>> +
>> +impl<'a, T: ?Sized> Mmio<'a, T> {
>> +    /// Create a `Mmio`, providing the accessors to the MMIO mapping.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// `raw` represents an valid and aligned memory-mapped I/O region =
while `'a` is alive.
>
> typo: "a valid".
>
> <...>
>> -/// [`MmioOwned`] wrapper using relaxed accessors.
>> +/// [`Mmio`] but using relaxed accessors.
>>  ///
>>  /// This type provides an implementation of [`Io`] that uses relaxed I/=
O MMIO operands instead of
>>  /// the regular ones.
>>  ///
>> -/// See [`MmioOwned::relaxed`] for a usage example.
>> -#[repr(transparent)]
>> -pub struct RelaxedMmio<const SIZE: usize =3D 0>(MmioOwned<SIZE>);
>> +/// See [`Mmio::relaxed`] for a usage example.
>> +///
>> +/// # Invariant
>> +///
>> +/// `ptr` points to a valid and aligned memory-mapped I/O region for th=
e duration lifetime `'a`.
>> +pub struct RelaxedMmio<'a, T: ?Sized> {
>> +    ptr: *mut T,
>> +    phantom: PhantomData<&'a ()>,
>> +}
>
> Is there a reason for not just declaring `RelaxedMmio` as
>
>     #[repr(transparent)]
>     pub struct RelaxedMmio<'a, T: ?Sized>(Mmio<'a, T>);
>
> similarly to what the original code did with `MmioOwned`?
>
> I tried locally and could build. This avoids declaring `Mmio` and
> `RelaxedMmio` as basically identical types, and lets us remove the
> explicit `Send` and `Sync` implementations. IIUC you can also reduce or
> even remove the invariant section as it is enforced by `Mmio`.

This is what I did originally, but this would cause duplication for
RelaxedMmioBackend, as now you have to do

     unsafe { bindings::$read_fn(view.0.ptr.cast_const().cast()) }

and the `.0` causes the macro not being shared with MmioBackend.

Best,
Gary
