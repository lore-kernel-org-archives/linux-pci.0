Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020133.outbound.protection.outlook.com [52.101.196.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00013DA5AC;
	Mon, 15 Jun 2026 10:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781518441; cv=fail; b=csbIB7QVPxJPu5Tui8Uf6ngDNZ63WeLB14k5R38ec84dxxe8CqjiTUiZ9ZJQVB8u8Z0xu3VoF8ii60fNfFvG6myjlcDNlIgnwHwUUb14eaQ9Cm6qt/79zABfOYe1v5EhfRXGHnaivofqfxn9lL70nFMC7Q4agB1M7MyxaYMJpg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781518441; c=relaxed/simple;
	bh=DT9tKEQqI3Ku0spWZCFLWY8YYWGvyqTWkwDZl3lSYXs=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=ud3HgdaR9V+eVv2A0mov5Tp9nyixbN6sLg/WM+yDs4yglYvEOgi0ZFDSj1toOr0yD2uJsREM2VsBiczyq7wcwduJ/Tsc9Pc+482dWpb8DpWhjhHTlKe+r1HQcgzZlAB6eTYFykrPY9BGZk87Z3zy4NR+3IRrEH96fotDGF0nBkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=D6bKODG6; arc=fail smtp.client-ip=52.101.196.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="D6bKODG6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJ4kkuyyNJzOqy2tCp5HVorxz/DZFE351WkTI9aMNzxY/tstFI1Yyx5eXBhoCus3Q9zN/WWnhaV3onPYo3TIweVNVK5DiT2J0S3isxyBcqtiu4Ma/+fYO9kfig3oyrE0y2bHPUjlK1gDXx6V5zyfOg8SKw81qgqncq3tl4tONeQIbM702eL7hyzGbZpqw3VsLR1b9b/RoVjdarbSdaEBYQjKpMXGVqPJMej/SKAhESQoClKBOk4A0m4LgPVDC9FVAb3DyZMs7SL73jaacpiSeReyYjsOlWr5UQJE36R3ZbHpcYPH/4B5skv6w7TGpAyA14Dl4iqNq7bNUy3Cr1dxJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3EQDRK+s4N92CFeUVp05Sg5E0h5UWtCp4LkZdkpf5o=;
 b=CExXsQN3sZm0yDrKxMWxCWFWVdAVa3zcqCIj/MhDJGKVLuLu3O2mPJ5IIHRuzTmzKMB2piuaPJTBrFE29CbrQghdOhXUBnJVmidgvo68ZQpS0yDC0TXv4oAFVJxp+vCbhmiOFtZOHhb/Z7URvkGQeHBn+aGYqkzRlypZk02Nj7fTyaGfQqguHjj65U5j+kz0U87vztJN3Yp9JRLptLyzwvwEdn6YTP760AlQ6ryNL9YWeu2zboznF+CnBAGR9pShFwkMUMoT9RBNfepP0SBGEy6jJ42pyWC68uvY3Lfdmz7XmggfL694lHJth7ZDHdwHMNaVbpoqnjiNCdYRUlW/fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3EQDRK+s4N92CFeUVp05Sg5E0h5UWtCp4LkZdkpf5o=;
 b=D6bKODG6hlEnjuibiTYUNWKBCvOS+51xLfJejfDwLVvJrgE5D0DPrVMO4JYEZmCJIhELW31fxwNAfJXt4NJ+PdqxtkQhU9+3kTjC1T/nMfiylbv7rG42JqfQ/NURGb8uH8KsCLEuk35G6DZMEbkmwpJlfIJpA9kOnso0QKZ+1Qo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB5142.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:282::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 10:13:56 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 10:13:56 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jun 2026 11:13:55 +0100
Message-Id: <DJ9JKUVU0G1P.5W8EYOTQBOT3@garyguo.net>
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
Subject: Re: [PATCH v4 02/20] rust: io: add missing safety requirement in
 `IoCapable` methods
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260611-io_projection-v4-0-1f7224b02dcb@garyguo.net>
 <20260611-io_projection-v4-2-1f7224b02dcb@garyguo.net>
 <DJ9C815EGU4Q.3L04WWDJAUK1H@nvidia.com>
In-Reply-To: <DJ9C815EGU4Q.3L04WWDJAUK1H@nvidia.com>
X-ClientProxiedBy: LO4P123CA0656.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::12) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB5142:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f393a63-39e3-417b-a570-08decac6cf14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|10070799003|1800799024|56012099006|4143699003|5023799004|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	shB3DmAuObqrhY0PwfFpOgbTkubS7XZbNBeL6Cp10W822knsnUyfHn80yeDE+zzDx+nkzDtmfec78RHxAn2FjoymkZavi+UNFZGD7UNa8Zid4khgh2CmH197vdo1xe1qNtZnavgJYeAWdKWVfKzO9lnDvWDQy779u4c21jIQ/n9TTke4bPEKr140kbMHU6gEPb60Xt302PMrNPgrI+FAO5bocTcnFy+JxYDHvDiJ8wLdr19vSHvh7uFZLjcyTai5WhC4tstXHND5V/EXkimVssOiHQvpsCU1fTYBMaH7aH0P0FFdyoAn/oW514hCj0ZHdfAaWnwSSV400wSoNjq2h2MPgfuFgGbkn7IKmsjTCgOoaTwVwsVKK8Ti8TH14qrF5oMvreo0i6vIhy4ueTz3UEmnaSh+i+F5VyncV0Pwqgj+nMqqmft9Qbmqt2a8km/QjHveYwuYR9WUHD4k1nMcIQFfDgRd76PeR/kN8crjsFfEc6ZWuUSD2zZBcsFEMiYhk0KUMfMpyFcKLC4NS5UJnQ+cirHHvvybhsl6+s0o+UcDUD06Rgf7lBdLv8CK2JOt5c6eeN3KaZXyjx3ftawpgixKW6SX/6KO3CfAfQxhSadVupgree9BrfZCreKmeOlI0xcFl+zabJ+JYpkIrSCuFnJdcFRE2OP2K/TnJ136/eOvhYSONmqtdFNtXXu55Ob8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(10070799003)(1800799024)(56012099006)(4143699003)(5023799004)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0I1RHA5SXNTU1pnZHk2NE8xRmp0U0JQMXBvbmlvc2JOcVdQeU9CNjdXNHlp?=
 =?utf-8?B?eDR0NHNMWjdxWmlYd3Y2STY1bGtXbVByTDVrTnVvZnhCakhteDJRYUl0ekRX?=
 =?utf-8?B?SklmRjFaeUQvRExjb1p2SE5CU3JIVmx0T2pPSjhhT2RpTlFQdGc3bnZDVVRB?=
 =?utf-8?B?TjNzZ3pRZ3F2d3ZkTFFjZVZ2azdWMG01QjlnanRuVDZPTk11N3orUDhkaWtL?=
 =?utf-8?B?b2N6cERxNnUvd21BR3RoZjJVSDkzY0M5WGoyQnphN1BXWjRsUU9DQXBaN1RY?=
 =?utf-8?B?azk4ZWE4ZnhHekt3N05vaHZqdWxNZXppcEdWbEo5dkp3OXI3dkhnYi9OYkZM?=
 =?utf-8?B?ZG80c2tTcTVZM3ZJekd3OVY2aTdRZXY2aVc2S214b3RPTGhDR1FaSXZKT0g4?=
 =?utf-8?B?cldBR0g2YWR3OU4xbENnc2s0ci9uZkkrRHJkeXRsenVpQWxmSXBsSHZrMzgy?=
 =?utf-8?B?SHpXOTYwQURERW1lbVpXV3ZSSjl5MXVRY2R2aXFTcmpoTlBob3I2Qjcwelp3?=
 =?utf-8?B?ZGhrQTNZbHUrVGZzOGdtWmlJNUQyV1M5NDNhUmNmRG9jQXhrTFV0aXR6TjRU?=
 =?utf-8?B?RFNmem9oZGZ4VnlZU2lWc0NlbXJ5L2E0Q0xLN3hpZ2VzcWZPRU92bWRoVkox?=
 =?utf-8?B?WUh6bnY2Q28xVGk4Y0FmK2F0RWJvdWQ3ZVM1RFhIQnJIZE51L2ZrUzR5V2k5?=
 =?utf-8?B?WmRpT1VndjRNRkVvZHQ2L0tFdGFtY3pnNStiSFFLQzZPdGdZZDd1RkU1Umln?=
 =?utf-8?B?MnNacHlabVRkb0J3Z29aMlNwYlhlTm9rN3NXRklRTkRqclZWMllZMGNuRERM?=
 =?utf-8?B?di8yc1pYUVpaWTlYc0I3YTlBcmVRZ1dpdnhtSUl1bnNjc014NWY1MVdLaTl5?=
 =?utf-8?B?YjNIM2VvQmdRSnBPMldqRExVUktLZ0lUZUtaOTYvOGYyaXpWYW5hWGNNWGp6?=
 =?utf-8?B?ajdhaGxTejVSeVQrRnNhVVFyaUIyd2RjNERVVVg0Myt0aWdwdUo4SFIwZy91?=
 =?utf-8?B?UUsyOERpWS82NkErYXdqWEFhRW9EOXNJZTVPOW5jMkI0SVJsTGs4Y1haL0dJ?=
 =?utf-8?B?VzlEY1k3VGI3b0d2TWJjSWJXSEVjVlFBbWNrWXhFMnNVOXQ1R25YV0k0NDF5?=
 =?utf-8?B?WW00eTk0TWxoM21LY1VzekFTYWlYYW42YVcvWVNQMk8vVzRhZUlQMWk3bFI5?=
 =?utf-8?B?SFd1UnFrRE9UdGllakRFVEpZOXNOK0FubEpmSWVYRmVHaE9zeW9ZZFpkNXJM?=
 =?utf-8?B?dStVeGNtbE9MNU1iRWJxL0dxZnpVUGlWLzdIVzR2K1NISWVnQnpSZHFyZmNl?=
 =?utf-8?B?aGRDcWYwejVlL1RKeW5va1VzeGxveS9ucXYxK0Y0MnE4eWtJcW5FS1I0ZU12?=
 =?utf-8?B?N1lBNDhmMUZEZlJma3lDbDRxUFRHcmhQRmRQTTlSWExWSDJtUU1GdEFwdHVO?=
 =?utf-8?B?aStVbkxZOVFmTmhVYXllQUpseFZVY2RoVTJDeVJHV3JXalZ3ZmlsM0FJS1pX?=
 =?utf-8?B?U3B3SUxmYXNYYUx6a1lYMnlKTUVxRVpmQ3E3eklNTUt1STllS3lWVU1ET0pk?=
 =?utf-8?B?VWlyVzFib2U3WUZ2YjE1clM1TkwrQWkrZjBaSjFwaEd5b3dzNFdidWNvbmNs?=
 =?utf-8?B?S3lKRG9INmJuZ0trYzYxVGNERmhwbm5JNm9XOWxmZzBTNGhxT1ErNG5WV3Nt?=
 =?utf-8?B?RlFMSlZTSktzTm1YS1NKZlZ5elZxT1grTThEQ0wySUJNcUJaSWhkcktlc2dL?=
 =?utf-8?B?dHhxalpXN0JMVkUraWdpcEFlb2thdllDWFJjdnNZT0lWb3U1aVNyMDQ4UmpK?=
 =?utf-8?B?ajA1YS85ZDFwcVNNQjZldGN6MFRpMlFYNVFpWHhreXloV1p1aDgzOUNXMFBU?=
 =?utf-8?B?SVVjckNBbis0VzFpRFhFdzlycHVGSUFJWUs4cElPWE1iOVBMUTVjQzZxQlhp?=
 =?utf-8?B?eEFKUDNaZ0FBRm5xZFlNSUNTZEI4cmRsZkpLck05UFM5YkdJZVl0VzFWenlC?=
 =?utf-8?B?Q205MVI3KzEvd3hQYUcvb3dhVyt2aldhMXpTbXdNODh1R2RoSEFjbDMyb3FF?=
 =?utf-8?B?dG4wSzRwSThXMUVzSVQyYnRzRFRWdlBLcTRRbDdpb2szZkcwdlVvaHM3VkJK?=
 =?utf-8?B?dUo0YThsZFRDZmZLQW5YM1BEREFjeGwwbktvNFcvU0VlL1JjQXowVUt3aHhU?=
 =?utf-8?B?UzNjSTRydFJMYXVIMmJ2NnVjenVZL1NJSVFiOFpiYVRUc0tZa1ZmMmpjVjhr?=
 =?utf-8?B?ZnBTTWFwcUMveWd2aHJIMVBVUE1RdjRJU216NTR4RytTZWVYdFh2NERURC9r?=
 =?utf-8?B?T0xYZmEwZlhPMExYNFlWSDR2K0lqSHVQdlZ6TmEvc3lONENCM0FRUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f393a63-39e3-417b-a570-08decac6cf14
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 10:13:56.0721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iILnHc1yMHMUxYh2epmYIECIIYAD88sUsvxBZXH6bb2a+0DpmCjOJMsftm6+t4Cx2PJyoKqJnyU/9t22ZrK/Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5142

On Mon Jun 15, 2026 at 5:28 AM BST, Alexandre Courbot wrote:
> On Fri Jun 12, 2026 at 1:28 AM JST, Gary Guo wrote:
>> The current safety comment on `io_read`/`io_write` does not cover the to=
pic
>> about alignment. Add it so it can be relied on by implementor of
>> `IoCapable`.
>>
>> Expand the check `Io` by taking `self.addr()` into consideration when
>
> "the check performed by `Io`" maybe?
>
>> checking if `offset` is aligned. For the compile-time `io_addr_assert`
>> check, check using the known minimum alignment of `IO::Target` and the
>
> typo: s/IO/Io.
>
>> accessed type.
>>
>> While at it, fix the alignment check to use `align_of` instead of
>> `size_of`. The values match for all primitives (including u64, given tha=
t
>> we do not provide u64 accessor on 32-bit platforms), but are not
>> necessarily true for custom types.
>>
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>> ---
>>  rust/kernel/io.rs | 25 ++++++++++++++++---------
>>  1 file changed, 16 insertions(+), 9 deletions(-)
>>
>> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
>> index bef571dad6eb..fa9ae39ad9d2 100644
>> --- a/rust/kernel/io.rs
>> +++ b/rust/kernel/io.rs
>> @@ -196,13 +196,14 @@ pub fn maxsize(&self) -> usize {
>>  #[repr(transparent)]
>>  pub struct Mmio<const SIZE: usize =3D 0>(MmioRaw<SIZE>);
>> =20
>> -/// Checks whether an access of type `U` at the given `offset`
>> +/// Checks whether an access of type `U` at the given `base` and the gi=
ven `offset`
>>  /// is valid within this region.
>> +///
>> +/// The `base` is used for alignment checking only. This can be set to =
0 to skip the check.
>>  #[inline]
>> -const fn offset_valid<U>(offset: usize, size: usize) -> bool {
>> -    let type_size =3D core::mem::size_of::<U>();
>> -    if let Some(end) =3D offset.checked_add(type_size) {
>> -        end <=3D size && offset % type_size =3D=3D 0
>> +const fn offset_valid<U>(base: usize, offset: usize, size: usize) -> bo=
ol {
>> +    if let Some(end) =3D offset.checked_add(size_of::<U>()) {
>> +        end <=3D size && (base.wrapping_add(offset) % align_of::<U>() =
=3D=3D 0)
>>      } else {
>>          false
>>      }
>> @@ -221,14 +222,16 @@ pub trait IoCapable<T> {
>>      ///
>>      /// # Safety
>>      ///
>> -    /// The range `[address..address + size_of::<T>()]` must be within =
the bounds of `Self`.
>> +    /// - The range `[address..address + size_of::<T>()]` must be withi=
n the bounds of `Self`.
>> +    /// - `address` must be aligned.
>>      unsafe fn io_read(&self, address: usize) -> T;
>> =20
>>      /// Performs an I/O write of `value` at `address`.
>>      ///
>>      /// # Safety
>>      ///
>> -    /// The range `[address..address + size_of::<T>()]` must be within =
the bounds of `Self`.
>> +    /// - The range `[address..address + size_of::<T>()]` must be withi=
n the bounds of `Self`.
>> +    /// - `address` must be aligned.
>>      unsafe fn io_write(&self, value: T, address: usize);
>>  }
>> =20
>> @@ -310,7 +313,11 @@ pub trait Io {
>>      // Always inline to optimize out error path of `build_assert`.
>>      #[inline(always)]
>>      fn io_addr_assert<U>(&self, offset: usize) -> usize {
>> -        build_assert!(offset_valid::<U>(offset, Self::Target::MIN_SIZE)=
);
>> +        // We cannot check alignment with `offset_valid` using `self.ad=
dr()`. So set 0 for it and
>> +        // ensure alignment by checking that the alignment of `U` is sm=
aller or equal to the
>> +        // alignment of `Self::Target`.
>> +        const_assert!(Alignment::of::<U>().as_usize() <=3D Self::Target=
::MIN_ALIGN.as_usize());
>> +        build_assert!(offset_valid::<U>(0, offset, Self::Target::MIN_SI=
ZE));
>
> IIUC this can allow unaligned accesses if `self.addr()` itself is not
> properly aligned. Do we need a new `Io` invariant for that or is it
> already enforced somewhere?

Adding a trait invariant would require marking the trait as `unsafe`, which=
 I
don't want to do because the `addr()` method is removed later anyway.

One argument is that it's `Io` implementation causing issue for its own if =
its
`addr()` is not aligned. This is later redefined using projection and views=
,
which further shifts responsiblity of upholding invariants to the `Io` type
implementator itself.

Best,
Gary
