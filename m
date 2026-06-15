Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020083.outbound.protection.outlook.com [52.101.195.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29363DA7F4;
	Mon, 15 Jun 2026 10:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781517911; cv=fail; b=gC+gj6oNx9t/2xjlPvlBHJhuvMJRtWOL89m93GvsYBi7isxz11it7CknrPD8cdDodgSPTptKdwh1wFrZIW1xnG5du50+e4WVamiVm/JX7yUfdkYY7uzCvoWqPB4O5AiGgj5w/7Tn7ixpwsKYPKbZjYGEco/f3l9TeZ4tL754DSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781517911; c=relaxed/simple;
	bh=6VF9iJjKGjIpvV1V4m6R+9HCEfHcCZa2Ifq9kyqlCxY=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=J3U5dMlg7xLETW/zQxgema7OGdxK3G7T8q+X1yZT35iTcZYowHLwhOu4Dq2kGhp009hM73ytpxmPYloSzpV7T1DqGZQufwFqjV7VQmM6ZfawHKfmgnst1PD/9FyVQGgd2KI5U+JsLwbYaKmqP7mtJOjIK88VmEgzP70Y137bfpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=dUwl1SEB; arc=fail smtp.client-ip=52.101.195.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="dUwl1SEB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rXgcQy/NHZfs47zyOaws8vcMMrRtWUYLr0TPN3F7YF6vLqtXM3XCi415OCckYzwhC80pE7RAW+VhAdac+1ZCzW62HAFuKSKtnmFGikX/nNowRFdUMAroxvqcgp1VGV+9sPBEpnxH5DWrViz2310p2i9W7so/Ssz7vebzdCBlSGhFPrK12E6nrlaeyxnPAsWroEi9e+0lqVP1ZLYYW0vfxATaBz44uQ1Yzc48R1A5scpflD1WUUSpObP9DYML4Wy1l5J3q8/QEgU89iGhRY/ZDqk67uW5dMAKyPY0AH/Fg4pxPFe1g8V2l5sy8K34FTX970Sr8HiZ8vsGZHhrhj2z7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+BPTyh+t6jHP749f/MCfkCPvaOKHfbtFfG14iSYzVk=;
 b=o0fAIGctgTJ617oE+MXloAGbR4bK298qrmyuvRgeHjOckxkTVH27IQWdIUCeN04lFMtT2gYwromBqV95zKfLNW6RlC5aZAC/2DTh+58YRJmRdopyzMGJyeuHEkcLDNe8Atb3aztUxZnm2z6h5S1dS2B6KwHfDvNYvhI97claIpJlTOnrpsUn+gFUoTc6y3HU72BKNfaCKqi+WpIZ71JjVvK4GvLhhF6BNlSuNpjmsXHE9wTx9v585Txg3RlCZlzoZTGmAq+hFfBgR+uFjGjhhbrgFdAiWuujNLEvcQ7YbR4KxFc9Kb67CwRWlesUGiXgY9fY2CfLVhgg6D13J2UlPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+BPTyh+t6jHP749f/MCfkCPvaOKHfbtFfG14iSYzVk=;
 b=dUwl1SEBUPFxgsDFVoZ9uq9anv8bZ7fyGyQeEwnY6ZG88hZ5kbBQv8tELXdYKkdbcizS6tcKFscQlcdZKsJjsZvM+6mfMBrbkyYMyYVpwEto4U2ZSUr1fy1Rbx5i8fvYRB/TPrPaWNNnXP1xxe2P2WVRbYV3GSBfbyAtHc+C6Dw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO7P265MB7828.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:419::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 10:05:06 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 10:05:06 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jun 2026 11:05:05 +0100
Message-Id: <DJ9JE3I9MCG2.2G88FWQPWRBH3@garyguo.net>
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
Subject: Re: [PATCH v4 01/20] rust: io: add dynamically-sized `Region` type
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260611-io_projection-v4-0-1f7224b02dcb@garyguo.net>
 <20260611-io_projection-v4-1-1f7224b02dcb@garyguo.net>
 <DJ9BPBO51J9U.FQYCSB4SSC8Z@nvidia.com>
In-Reply-To: <DJ9BPBO51J9U.FQYCSB4SSC8Z@nvidia.com>
X-ClientProxiedBy: LO4P123CA0370.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::15) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO7P265MB7828:EE_
X-MS-Office365-Filtering-Correlation-Id: a7ecbabc-6d16-46c0-8746-08decac5934f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|23010399003|366016|56012099006|22082099003|18002099003|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	W1d0NzMsKuXF+Tyn4brYyZyANd75eZGwNgOHo1I+U8yhQJP2fgElbQ4hBAP7JGLDulXsPWkGQr05hlk0ADsuLuG7gC/QSwT/ajl+fBADF/29xKWWmM0JhfpznO4/O3QqmyJG8TRpWeBR2rhGeWJnkn4GSi5ZHzAM1gnOAxK+veKZFZLzQK9mKaWo8x8SR8yNMt4S47B2n0W9z+CE/4iDrtVeY5sfV3scGyfaMUJzqZ9EUWxui+RfbXYopowHzRS9dJ0zWRxIaelSfVcuEuRb4lT38KWWJGYsfWsEA5uQxkR+7BZEZpqggs9ayQJ3vjmQqKZh50d1DOjAaPXi+09Fl+XLPDMv390uzpL/nqdNnSwBjeJxQhBGqzuppAUvEqPsn6Usu/j6F3qIyWWnhEFptESpt67ItfDGe53YG1XULtP7Y6Ih++w4TICEixqVCZHSEXDKLCVCGBlwmx3j+cJd+Hzfa5OWgpSM4fo3aAwPXkuN6jTmm9J0gNX8J5Q2IDRSNgIDctZnQ8fJ1VXterj0aEob2AlRjD5LNEwivu/40iQhIJ5z6eYUCx5XlAE7cNxg8rs2BCrLplhRx5KimJ0FGsTinm9+C/5qVslMiPoEp2g1IQ5B8NmM+D+f+dR5A6v8W0lGNFNborNbpjU6+Qt6yPTTIhLYftV/wxNXi1e5ycj4XBa4lQ0gb0gDnXp0gdm4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(23010399003)(366016)(56012099006)(22082099003)(18002099003)(4143699003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VE13V2lFSzFMeFpTUjNYdDRmNWJoYkZvZzgzRzVyYkloL0g2SzVUWVlWQ1p6?=
 =?utf-8?B?V3N5aWNyWEgvYXV3ZG9kV1EzZ2lTTnNvdS92MVB5WmJEV0NOY2V6TGwzQlBN?=
 =?utf-8?B?L2kwS2NuL3lRWjgwUk1NNk1ZbkdCQUZMMUFMcjZ1T1p6UDZ5ajJXaDZEMTlX?=
 =?utf-8?B?K2p3dzB4bDMzcEY5R3dvRUxSZGlhNDhuNVhyY0xBM2VzazhYcE0vL0FCZlNh?=
 =?utf-8?B?T3hGdDBOdk5pSWFlcGJqendVby9naThESWRESGF4TlJ4U2JjQkRqMnFXNHBQ?=
 =?utf-8?B?LzIvamVObzhwSDhRWXFPNFRWKy9xaFZvV2ZEdTlxWGtHK1lRL254UW5Lb2Nu?=
 =?utf-8?B?TDJOSmZOano0ckswUDUyK3NuZFBFMWVyUXIwSzJFQkhCRVFnTmp6NHRucFNk?=
 =?utf-8?B?ZXl3WUlNbi90QlFmQWs1T2tGMThudUpld0RtcG5reVJ2d0RNT0hPR2x5OHBD?=
 =?utf-8?B?V2ZxSEUzMFNTSGxGWEdXVCtuaE1JUTNPZHppVUJoYThLdnkxYjAyZmg5RDQr?=
 =?utf-8?B?QmFLS21oVU9QTC9RZUVnVE9NbFdlR0Rwb2JCS3A2RFc0TFErS3NwYjZZbTNM?=
 =?utf-8?B?ekRFRCtZQ200bUg1Yk84UXZOY2Z3VUNKbEJDYXh2YzhJYjh2VkZ4YmNqVG1N?=
 =?utf-8?B?TUlvWC9mRmtRa3ZGM0tNVzFhaGdETzY1bDI1Wm1LYzFxUThFK05CNWxJN2Zj?=
 =?utf-8?B?U1VnUFdkQ0gyM2lZdWo2MmROQmV6aWgxRlNsanljclRYWUFYUkxsNEJsNnhI?=
 =?utf-8?B?cU1WVDRRUmcrbUhxWXhNZ3JzMzg2U3BYVHR3SU1GTlNQUFRtT3pRbmNuSXA0?=
 =?utf-8?B?VE5CSzQwMU9rQmdCM1JrNVVkNHJDdElqRi8xTW1lWDZObFJGQU5tL1N1L2Ev?=
 =?utf-8?B?dUdOTTNJbi9ZU1VPenM1OUNwMHFVMHZ4WUVJelNxWGpPc240cHJpTXUrbWtK?=
 =?utf-8?B?a3J1ODNNQ3RqL1N5bW1EYWxHWHhBRXk2VGRGNDdLMDhST0trRVBtQThaUHFF?=
 =?utf-8?B?bXovdDZKSllkSWthMDBKdUtMbm5NM2tHdmFjOVZKUE9ERllRaW81TTNNWnNr?=
 =?utf-8?B?ODJDTEdnenU1QnFiMGNYSVFGOFN6eWRMSnNNYnl5TnQrWUhxanFQV2dkRGNY?=
 =?utf-8?B?RGpqaWw5NVZ0SWtqajQrNXZDZTdtM3VGWGxHbFVlNUxSRnE4V2FkRUdKMWYy?=
 =?utf-8?B?dlhwd0p6N2pHaWxOVUdEc09sREpMY0pTbGtJT0NVM2htVml6VVc0OWRaaG5E?=
 =?utf-8?B?RXBKbTNGL1A5NnFueHJSNkQwN3BJc3dHdmo5aVN2c3lVNlNBb1BiaHVrUm85?=
 =?utf-8?B?M0NwSmRZUm4xeEpTZ3dudWs0Qyt5cGZ6dHl4TmdoOXFVUVEyYUI2NllBdUp5?=
 =?utf-8?B?SzRmbjFTQ0ZDTkNBV2dxQTQ3SXBqZS8zYTJJb1BsU0pZR3BOcXBmYUxNcUVl?=
 =?utf-8?B?QTJtZjhwejNZdk1jUjBSL3doRXQyUDRjWlpwemh6bmRTSng5ejUxbXpUMEgz?=
 =?utf-8?B?bHZ0Rm5JdHlMcTNyTDNWNkc4WmM2SldkUnorVFEwM1NFdldaNUxDaGl6UVNk?=
 =?utf-8?B?bXp5bGFheU1QODNMcTA3VEJiNnZYYUs0NnBic0EraWRPbXhTd2tuVVR1cW1q?=
 =?utf-8?B?bEY1VWExUzl5WVZaM0dOQ1hWWjZndFc3dG5TZUxscWwrck02dWhHRUxLUmg5?=
 =?utf-8?B?S2lRY0dkZG92NDhDZS9pU3B5eHN2bkhPRjR1blQwRFAyK1F2V3MxbEJjMXhx?=
 =?utf-8?B?NXVWWUJDTkNxOTFRWTZRQzVSaHovS0huNnFyUUpQbHdrVURnOTNXYjM5cnN6?=
 =?utf-8?B?d0d6ZEpHT1FSN1hHU2haNlBNVzQ5bFM2RFNOMXhKRXdFVzhzbW1JWGFuYVA4?=
 =?utf-8?B?T1BCaENYc3FJVHkydUNlcnNsazlZUFQ3WjQwOXVLMENzTCtPYmdKUXFjMmFn?=
 =?utf-8?B?Sitmc2lIODlhbDNudmdWanhsTWRQVXV3UVJQeEw3RFluTFZFWThXcWNuU1pK?=
 =?utf-8?B?RmJnYlhSNXNsZDRsblFNT2JNaklLNDRkWHpmQm95a1U3cUVZZ2FPSmJHUTAv?=
 =?utf-8?B?eG5ER1B0L3BhRWp0NkZ5eDhqcFpkcWpMeVQ5N0pkdDRrL1hHUlNuTTBxc2Q0?=
 =?utf-8?B?WnMvcTd3VWpJYWhEZk9qbG9sODBwLzFqMGpwRUFyaENLd21Pd2NzK2cxMG1E?=
 =?utf-8?B?Tk52Y01NZUV3dEVNZXBXajYzZ3BxK1RGYTAvTDJ4YU94WUowRlV0dzQxU1Vk?=
 =?utf-8?B?TUoyS1dtQTFTWW41cHgzcWMrRnFoVUdOMGl6R2FoYjZQRkhuU2Z3ZHlPN0VS?=
 =?utf-8?B?c2RsWThwSEVPWmJyUk52ZUlFcStUVGhQQkRCQzZtaHlOa0JZaVpXZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ecbabc-6d16-46c0-8746-08decac5934f
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 10:05:06.2903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xvuM3rJ2/gm9xnWOzilm0OtU5O7ng3ipO0Sis/B8aDVCa7X5Fazrhzr+DD/c9PPbl/vsJHr56xa7hmOgSAwo2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB7828

On Mon Jun 15, 2026 at 5:03 AM BST, Alexandre Courbot wrote:
> On Fri Jun 12, 2026 at 1:28 AM JST, Gary Guo wrote:
>> Currently many I/O related structs carry a `SIZE` parameter to denote th=
e
>> minimum size of the I/O region, while they also carry a field indicating
>> the actual size. Proliferation of the pattern creates a lot of duplicate=
d
>> code, and makes it hard to create typed views of I/O.
>>
>> Introduce a `Region` type that carries the `SIZE` parameter. It is a
>> wrapper of `[u8]`, which makes it dynamically sized with a metadata of
>> `usize`. This way, pointers to `Region` naturally carry size information=
.
>> This type is required to be 4-byte aligned.
>>
>> Expose the minimum size information via `MIN_SIZE` constant of the
>> `KnownSize` trait. Similarly, expose the minimum alignment information v=
ia
>> `KnownSize::MIN_ALIGN`.
>>
>> With these changes, it is possible to add an associated type to `Io` tra=
it
>> to represent the type of I/O region. For untyped regions, this is the ne=
wly
>> added `Region` type. Remove `IoKnownSize` as it is no longer necessary. =
Use
>> the same mechanism to indicate minimum size of PCI config spaces.
>>
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>> ---
>>  rust/kernel/devres.rs |   6 +--
>>  rust/kernel/io.rs     | 130 +++++++++++++++++++++++++++++++++----------=
-------
>>  rust/kernel/lib.rs    |   3 ++
>>  rust/kernel/pci.rs    |   1 -
>>  rust/kernel/pci/io.rs |  40 +++++++---------
>>  rust/kernel/ptr.rs    |  12 +++++
>>  6 files changed, 118 insertions(+), 74 deletions(-)
>>
>> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
>> index 11ce500e9b76..ed30ccc6e68e 100644
>> --- a/rust/kernel/devres.rs
>> +++ b/rust/kernel/devres.rs
>> @@ -68,7 +68,6 @@ struct Inner<T> {
>>  ///     devres::Devres,
>>  ///     io::{
>>  ///         Io,
>> -///         IoKnownSize,
>>  ///         Mmio,
>>  ///         MmioRaw,
>>  ///         PhysAddr, //
>> @@ -297,10 +296,7 @@ pub fn device(&self) -> &Device {
>>      /// use kernel::{
>>      ///     device::Core,
>>      ///     devres::Devres,
>> -    ///     io::{
>> -    ///         Io,
>> -    ///         IoKnownSize, //
>> -    ///     },
>> +    ///     io::Io,
>>      ///     pci, //
>>      /// };
>>      ///
>> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
>> index fcc7678fd9e3..bef571dad6eb 100644
>> --- a/rust/kernel/io.rs
>> +++ b/rust/kernel/io.rs
>> @@ -6,7 +6,11 @@
>> =20
>>  use crate::{
>>      bindings,
>> -    prelude::*, //
>> +    prelude::*,
>> +    ptr::{
>> +        Alignment,
>> +        KnownSize, //
>> +    }, //
>>  };
>> =20
>>  pub mod mem;
>> @@ -31,6 +35,58 @@
>>  /// `CONFIG_PHYS_ADDR_T_64BIT`, and it can be a u64 even on 32-bit arch=
itectures.
>>  pub type ResourceSize =3D bindings::resource_size_t;
>> =20
>> +/// Untyped I/O region.
>> +///
>> +/// This type can be used when an I/O region without known type informa=
tion has a compile-time known
>> +/// minimum size (and a runtime known actual size).
>> +///
>> +/// This must be 4-byte aligned.
>> +///
>> +/// # Invariants
>> +///
>> +/// Size of the region is at least as large as the `SIZE` generic param=
eter.
>
> I noticed that patch 13 adds the "size must be multiple of 4" invariant.
> The doccomment for `ptr_from_raw_parts_mut` says that "size should be
> 4-bytes aligned" though, which sounds like the same to me. So should
> that second invariant be introduced in this patch instead of patch 13?

Oops, I think this is a bad `git absorb` operation that I didn't checked
carefully.

>
>> +#[repr(C, align(4))]
>> +pub struct Region<const SIZE: usize =3D 0> {
>> +    inner: [u8],
>> +}
>> +
>> +impl<const SIZE: usize> Region<SIZE> {
>> +    /// Create a raw mutable pointer from given base address and size.
>> +    ///
>> +    /// `size` should be at least as large as the minimum size `SIZE`, =
and `base` and `size` should
>> +    /// be 4-byte aligned to uphold the type invariant.
>
> s/should/must? I guess we are running into all sort of issues if we
> create regions which runtime size is smaller than the compile-time one,
> and this is an invariant of `Region` itself.
>
> Maybe this method should even be made `unsafe` for this reason? The
> caller will need to write a `SAFETY` comment before dereferencing the
> pointer, but IIUC this comment is bound to cover the pointer invariants,
> not necessarily those of `Region`. Making the method `unsafe` would
> force the user to cover them here.

Note that the function implementation is completely safe, and it can be don=
e
outside the module, too.

Thus, the real constraint is that user doing raw pointer needs to be carefu=
l.
This is true for all pointers. You can safely cast between any raw pointers=
, and
dereference requires you to uphold the invariant of target type. This is tr=
ue
for all types with invariants, you can do

    *core::ptr::from_ref(&0).cast::<NonZero<u8>>()

And the unsafe part is the dereference, not the cast.

Best,
Gary
