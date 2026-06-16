Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021127.outbound.protection.outlook.com [52.101.95.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EB142EEC7;
	Tue, 16 Jun 2026 10:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607485; cv=fail; b=IytE1EdfC2r70XEbFWn6wOnBwKJbFQGmY60HyLkkimpxJ/vN3ACbUa3ee0N/mZtCp4zCwWZZkVqh8O4wFpAz2pLqSvZlq6R8HTMeicDAKYLz2EKr0iTNiODOZIAKtU5ky+SH0DsT/HmcBq+t6DoN6K6FJ+g3oHh7Xxrjb27D04w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607485; c=relaxed/simple;
	bh=p9MrJ3t4bRaA+SlqtqT3YswSbsFeQwLrKSBLMhOnqG8=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=dQ8pMCq5+7dVKLYMfct6naaO7wBxy8RONMHS5apX19Mk4q8T/yjgS0v8b9UpwLc3b1KTMVFM7OWBrYBAyKnY3iL4dq3lWJzVel2mP70jcp/7A9mp7/6Rm7TrNsL1d9eacBvqC2GyjMW3wwX7y+sAkQv2gSt5OYqoLELiqEDZikI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=v57qrVKb; arc=fail smtp.client-ip=52.101.95.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="v57qrVKb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JiJNiuof4RXuxT8RNkz+PMRQA/dRx05UWI6ecUS8xbIVbTSDbcob+R3DeRctv92jIrLXeQHH+tuYWcDcmgk66vE+D6TunW2xxL3o02yUwBvbXiVzxqUMHpFCrz+2Gdvp5Zpd+v8EIJKiriwaCAMNg3X8b1dqCWhl5Z2DZA6XFv9W4S6MGQNAnzBMx+76aJJV7knf8PJV6PKW/HYREZYzCghF9fEAL9/f3hAVRSBsTEFRFAVE6LFJGiTLP7bsjlvaufOBjvgmwPGa7c5y1Y3giBOmkLzAsxaxBQ9GRzlmCcU5l7H6XlysklEFnDAG4ilri56qqxSaeNS/NFhK/2XXeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPxNcRCRy1ENK0qvaj1MwXJnWGu3sTaVald5bD0VQPE=;
 b=j8IbmrIB4LuoGl9y6i9Sbo1c0/78d3eNDWkMnD9/V8cHb9mEN1M4y8TyNbu8zHl6UNMy/Ky0eMcRsR8RJccLxraGWGsWVqsG6pqmeHFGfzt8w8YnuWX0E4lbnpQIUkgFurWJhJk/i3eceWMk/R7865hce/yuIjb3oKmllI4SC/d5ydPUnViuAgNXiFNu8GP0hZlaHbJQZMI5wxuSP+XNauSJGbNhjLpEv1u+5L2m5pYYnXsPNfkyYTreDiEMkf/P6GV2bWqX8QZHoK+SkhQM2BvW+H9hgPp9WICXeshfGIlH/aPH4GBe8p3lPKaVTmVjp6+WeeVuMzWk3B/zHh0xiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPxNcRCRy1ENK0qvaj1MwXJnWGu3sTaVald5bD0VQPE=;
 b=v57qrVKbGA1pJv3gCS2I7nZqb20pVYgKDJmkP9z5MyEcM2FibVYNhykMRbwWsADyBL5OrLjoTTwGfxURBExhuoK7TIT7EFVM7MY2fjSgPENupv0Tk2lpIgENdNKkJG+B/igD3f/FNCjvSOr9dQJSI2j+BU3wr5aNJ/60adwotqw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB5517.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:25c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 10:58:01 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 10:58:01 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jun 2026 11:58:00 +0100
Message-Id: <DJAF55KT7M1O.2HRG877RZ650G@garyguo.net>
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
Subject: Re: [PATCH v4 08/20] rust: pci: io: make `ConfigSpace` a view
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260611-io_projection-v4-0-1f7224b02dcb@garyguo.net>
 <20260611-io_projection-v4-8-1f7224b02dcb@garyguo.net>
 <DJA9JOVL3WF2.DF0M3HNG1OGF@nvidia.com>
In-Reply-To: <DJA9JOVL3WF2.DF0M3HNG1OGF@nvidia.com>
X-ClientProxiedBy: LO4P123CA0288.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::23) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB5517:EE_
X-MS-Office365-Filtering-Correlation-Id: beaeeeb4-8e39-4d1b-3059-08decb962202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|23010399003|10070799003|1800799024|56012099006|4143699003|6133799003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	1lbUeTZYHVyo6uj1vVwEeYlRj/QK03kP4D+WnmGMHhyYTwhZHNmP9boLRq/yv5wsjXXx5XXiNiP7RJJ5Qu53OiVyvAucWiPPk7raIe4hCUQfGDgyNz6638wCRcg8vVGJkoYmpmLVZD55E7B0+W7rx8q4UcEHTWlfs8koIEtiiulCc3EfGbdn4fssI24NxzyAsgs0DJbiqUj2ji3YMpYxMxz6xUMVE6E+Lp3VCRN0KF5EvQzRy3qChOVtYIU4TkyM1HtubeGy4fQ8BT30X4ZqOLEIA6DKBrtwKvqDZOyBSOhfimLEFqXretS1i9Iz5AUt9TdW7oE8nzBv/bN4KQzK7H4BOzP9auJrzhC2lsA3Ni20O/ennFeL2GlxVfUILbvGjI56SaJqlDHcZxRgxhOQWESrx1jINewU4iWQd9pNit20PzEyDSV2IU/44cZmMBxMxpV8oKbzxSksxaieg+9B3Pks08IuJMurs5SvjN7IQPzstTisNDC2Pys/xQ0S5QnlXyJ6cCt7WqWSpJJnuGORvwCaU2FojlOzGdZ4SsJ7wt29KA9hBQMxv6h11HVLajTlmBVHlbQ3G0F37FZ3AxeYGQETE91Kdu6JkEelHzcC4BCKn9Zu+3ntnAzIkLLN8DGzUW6e7p3n0+JDHIYZXPGX9tXJ0y9CjZr8OLp0ke0zgncteYYphvsy+6dFDiFs8x8Z
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(23010399003)(10070799003)(1800799024)(56012099006)(4143699003)(6133799003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkVtSGh5UVFVMHdoVFhBelZGMEhLdzR0ckdveHY4MGdSaEVpbkZnN2h2cDAw?=
 =?utf-8?B?Q053d3RXOUJJNWFUTWg4dzcrY3JTK2w2dmpJalhqL0QxV3l2YVhUeTFlVy9F?=
 =?utf-8?B?UzEwallyQWxaOW9qMXExYWlGVXlJRWJnQWdaUS9mNDZMbnV4ellPU21zVUdX?=
 =?utf-8?B?TGFqS0dab1hlV3V6NFpTQll2RjJOMTAyYTUyZnZWalNWZGgyaDBKK0NiVVJE?=
 =?utf-8?B?MVQ1c2krY081YVV6dXdLbmhRbytDQTM0Z3A3Y0FCMlRteithL2U5eWV4OURO?=
 =?utf-8?B?Q3ZzMGM4UVhPK3ZucXdhbktUa3Y5Nm1WTTVLcE02bmRZNmRVQmxQR3QzY2lr?=
 =?utf-8?B?aC9nemhKTCswdGt3RERwNy9FR1dsZlpUaUtRWVNMUTljZEg1TFRkQ3Z4SEls?=
 =?utf-8?B?NmUwRm4wd01Mdm9KWHVNZUpnTmpZQTQzV3h3L0t6M2ZKZmZSa204WE5DNE53?=
 =?utf-8?B?Yit1TVFINDhEaEdlc1dtU2dvdlB0d3FNTWhVazVFM09VcDdQSW9pcXQyTEZy?=
 =?utf-8?B?WFB4ZmZTcDBLVzJvNzdNbk9yQzZ4dGVra3JETGd4Mm1DK0ZJR1NBc29jNkx2?=
 =?utf-8?B?ejRreXlreUdUTm1zQzRHMGlnZ1lQVGxaQ1U5Y1FLZlM3NXE4OXJjSDhnK3pE?=
 =?utf-8?B?WUx3djdDUnB4S2g1UWNWUkJ1eHlaeVNadlFCUm5EL3gzVnQvQTkrc2RSOHBL?=
 =?utf-8?B?ZVRLYVdoODM4RTdpa2JIWk5WSXhNeEJDRndvSHlwd3BrK2RzK0J2by9aL1p4?=
 =?utf-8?B?Q1IrWUNBWGoyRmNUakF1dDFDY1JFUkVZTjBjZXMvM25hM1dkOVhlT2NHeVRi?=
 =?utf-8?B?dGJWbU1pc2RDUEJmNVlFSjU0WlFqY1Q5SDJDQS9hRXJvT01NczQ5aWRST0VT?=
 =?utf-8?B?N3NmUTBkb1ZjdnljNFdjeGdvWVhaMlFBVlZiaW1NMkllcDJML0ZEZjZQdkY5?=
 =?utf-8?B?R2pVeC9tKzkxdXFUOUNIZmN2dHFWRWY3UnNrQlVaMVNRTG1MbnFCcUwyMGc5?=
 =?utf-8?B?Wk1Bc1BjUlJ2Q0p2a3NyT0xCSHc5VUpFcWxBUEwzM0tMUDh5THh6S3VaRDdh?=
 =?utf-8?B?dHpockJBVTBvSUFuaWlGWDNrMEY3UC9JQ1dZeWFWSE1PNlU1MTFyczNtSk5l?=
 =?utf-8?B?NXZXcU9QZlQxK1Q4SjlHNGFtZHVVNWFXS3VWQ1JKa29QS25LQnBBUm9zZStk?=
 =?utf-8?B?YlJnWmNYK0N0bGl4b2p4cit5M0dlemxpOFFPVFFWekw2RFJyNGZhcy9RTlJs?=
 =?utf-8?B?d1VBVjNPQ080eGlUWnB5QnAvak9VcGpZNERMRnVmMXY1c1FvZjIycUtNU2F1?=
 =?utf-8?B?eWR3TXNDVUlPREVob0dlTXAvdU8xNzJ6K21nYzZUbFVob1JpL21YVWVrT3lV?=
 =?utf-8?B?UDE5a2ViNENlWHZpclhZektzYVdSWGRZaStEcGk5cEtDelFNeGxMQ3ZEQVlD?=
 =?utf-8?B?NUZGaER2L3VKN0R0Qyt3czRVUmZqbUYzOHh3aHdkOWllNzBsRWdIaFhKc0tV?=
 =?utf-8?B?L0VlbDRmRUxXTkNodk9lWG42dTJsMTBFOXNpYVZIQm41Rjh4aXdQclNzUmJq?=
 =?utf-8?B?TDVtNjBRSk1JN1pZdThaaWVueGpKbGJjSkpBTVFLZThVV1pvT1l2RkZnWEtj?=
 =?utf-8?B?NXprek1RVXNjUEIwendES2JoQXh0U2dQSEJCdVpKQzZCZlRNeFQxQjR3L29I?=
 =?utf-8?B?OVhWTHFBejQ4YmhpaW1XWTAvZ1NwbHAyQzErckdLWjdvWEJ0Uk5RNUJXZlJ5?=
 =?utf-8?B?T0VWSndjQWVaYmFNeWhMSDVVMDBkaGFFeVBaSTRDZTE0RjVab090U09LSHow?=
 =?utf-8?B?MHFCOTgySFFwM2lPZnRGVVdCM3JrNXluQmFUN2ZhaXBqTFZ5MDBEUGQrU1lJ?=
 =?utf-8?B?OUc2OUQ3VXFzNEd1L1FaSS9JVVA0aUpEVDNOalNWM3FnbkJmT1lBVlVFR3Q1?=
 =?utf-8?B?aG1aYjI0bWNsR3pPcHlQR2xTbnNqWXhlc25nRkFNdUtiTWNuNStFQ3owWkdn?=
 =?utf-8?B?UjhHMGxreHdEWHo3YnRQbDh5U1AyVnBDVDVIcDlqTWl0TnlQSkM5WU0yRm1U?=
 =?utf-8?B?di9lSlg3cVAyUkRRN081OGltWUh5aHVOSHhqcXZMRFpmdWNFM1Q5ODZXVGJy?=
 =?utf-8?B?UWdXQlZsdlpUdVlXZllTRmh6N2lFWlVkUlZNdzdUM0Z3TlpuelFhUXl0WEN6?=
 =?utf-8?B?bHdSZ1hVU2ZtbEhxZmQ5L3lKdldOYk9zVldMYlNZa1l1bVdnbEUwTHQ0S1Jv?=
 =?utf-8?B?V1FkU3BGV3lKYTlqOE9Qb3FSODVRVGI3ZEtodm9Sc1Z3YjljY1g5M1lhUitr?=
 =?utf-8?B?WGRSdWZzSkV2TjFSZ0NvdzJaY3MzcTRZNnZkZnlxaWZlZUswT1d0dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: beaeeeb4-8e39-4d1b-3059-08decb962202
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 10:58:01.0061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X8bLYGaVjJ11dlco5oAxk26fiY3RQFm0loN87Tar/21RBxqD2Z+psU5clbWx8XPhpHLxuDT60Lu5YM3rMOABCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5517

On Tue Jun 16, 2026 at 7:34 AM BST, Alexandre Courbot wrote:
> On Fri Jun 12, 2026 at 1:28 AM JST, Gary Guo wrote:
>> -/// The PCI configuration space of a device.
>> +/// A view of PCI configuration space of a device.
>>  ///
>>  /// Provides typed read and write accessors for configuration registers
>>  /// using the standard `pci_read_config_*` and `pci_write_config_*` hel=
pers.
>>  ///
>> -/// The generic parameter `S` indicates the maximum size of the configu=
ration space.
>> -/// Use [`Normal`] for 256-byte legacy configuration space or [`Extende=
d`] for
>> -/// 4096-byte PCIe extended configuration space (default).
>> -pub struct ConfigSpace<'a, S: ?Sized + ConfigSpaceKind =3D Extended> {
>> +/// The generic parameter `T` is the type of the view. The full configu=
ration space is also a
>> +/// special type of view; in such cases, `T` can be [`Normal`] for 256-=
byte legacy configuration
>> +/// space or [`Extended`] for 4096-byte PCIe extended configuration spa=
ce (default).
>> +///
>> +/// # Invariants
>> +///
>> +/// `ptr` is aligned and range `ptr..ptr + KnownSize::size(ptr)` is wit=
hin
>> +/// `0..pdev.cfg_size().into_raw()`.
>> +pub struct ConfigSpace<'a, T: ?Sized =3D Extended> {
>>      pub(crate) pdev: &'a Device<device::Bound>,
>> -    _marker: PhantomData<S>,
>> +    ptr: *mut T,
>
> `ptr` is used as a pseudo-pointer here, can its documentation be more
> explicit about that?

The invariant section is already hinting this by saying the pointer is betw=
een 0
to cfg_size?

Best,
Gary
