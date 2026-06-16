Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010003.outbound.protection.outlook.com [52.101.56.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9DF360745;
	Tue, 16 Jun 2026 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781620106; cv=fail; b=PWHkpITD8lPINknm8bfmNPRojISol+rfW691q5Ap+r2Tzr2Ij3p/d+0ETvFdC67DGpV8IFPYEy2bjA5lmvQjAK/u1OKUKQNNPaRpdBP3IRZr+TueF1XsqI1Vn05+JadlQXAMBJ5iXlEdhzQAn1jtX6Ujt9r5QfX92Y8hhaJBCfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781620106; c=relaxed/simple;
	bh=UL8zQJGSznpPWn37H4SFc9FgDuIbq1wS7bG2hoJ5Lsc=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=Un/pVfFpkBmejvLU0KUWcHQrqEu1OE8QDHO26ELUZ/L4KYDVVIAhGcBsoxbwsjSzk8fxTkn1IhJaY1AAlI9DAzVmzZtmaOps3YdqrdnI2WV3kgRR9cWfVB09WtbwQXwjD/tUaonAO/FClgv3jw4Co6wpWRmJsZhOOa+9ICAkjI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RPr0OjQm; arc=fail smtp.client-ip=52.101.56.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RPr0OjQm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BrJK6hmhHo5SJ6fX/X58lYUdC1AFSC3Sc/nJ1Z8xeI3WVFZldYW0lrCwu5nYD3WTNE+pDzYkthDMY7r2zO/3/XDKwsMOODPaBb7FcnWi5Pk7Q4VnhLUc78ftqOocw7zvWSHljDEYEir3v73VWLs5hk2Vw97GlkHaDR1CGaagmls4SJbMZyJRLKOA9EtzbczKtZINHpoIlWsU1hfT4CtFIvk5HpcWhDyAuqOi4LI+kJmLn3R6MYOruVOsDpBfu4jWmizipqNdoQhCG2tsWEBJDXydu98kFmB90uIJV6w8TQgKmy81wvWoIl951kgJfmZFkt1rzzMwE7pCdC7770Rj+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bbw8CYw2sjD/PUbviaMAL5scYe9Wm5sduxl9Ubsuy+I=;
 b=esofpS6uf3q2cAxz1TIDSVTfs+D8JePZLn5aLfhOecf9aCUgRbApCdvjlk/l5ktAAYVI3F3wvfZX6UyvvFP+RPOllqdDqfWuQfGhrZjO8iQGiEn5hYVm+tyqISwYKsUdFQyBr31BJWTJZ98AyH/dn3Z/1bP9zWWzVTgbPbYq9Y40JLGA4ctNCZK1FI/GwgnGI6go/l/TfJEpQjxWWF0oVRggR8iExL7vYIUohxeci/pvB+zCTp3GeBOyinUgIupQrV/2p1wZxUprPVHMICyY3r36eCtB5Q3CweJT0y4hB+dq2ds2cuhiQ/08nf9Ez46DzZxtsqb2mvcpDMLXl8KG6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bbw8CYw2sjD/PUbviaMAL5scYe9Wm5sduxl9Ubsuy+I=;
 b=RPr0OjQm6rV7MRoQ3wn7RV3XntrON2rSSX6rMNzxUFVdtpQeVtt2YmSi/KCwpKB3vN4Fe1Fzhwxhmp1OF5BWcNtCmIFC2jrUA+LOJOFlN0FpExo/6jrmjW5AXkllvgfquqiR1maw+Pu9K7U8yO2lLajB/v820XJJRFzIUTUmMtPM1jXqa9LO16Y075MTeeBECw3VD8ATxR846djIvfEDo3CBLOBSejcwdtS3RvOA7A9w3wPNQmZwErSN2/Nn/mMyNsAZtdypeFJ1DVEyDA0ZRLLXh55we/hr3P5jTyOPGT4NjxMZ955jmQ40J0WX+6VplhjPRk7vFwNJlzorkwYxlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN2PR12MB4240.namprd12.prod.outlook.com (2603:10b6:208:1d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Tue, 16 Jun
 2026 14:28:21 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 14:28:21 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jun 2026 23:28:17 +0900
Message-Id: <DJAJM5QOYK7V.10KE3BKP218H4@nvidia.com>
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
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
References: <20260611-io_projection-v4-0-1f7224b02dcb@garyguo.net>
 <20260611-io_projection-v4-8-1f7224b02dcb@garyguo.net>
 <DJA9JOVL3WF2.DF0M3HNG1OGF@nvidia.com>
 <DJAF55KT7M1O.2HRG877RZ650G@garyguo.net>
In-Reply-To: <DJAF55KT7M1O.2HRG877RZ650G@garyguo.net>
X-ClientProxiedBy: TYCP286CA0176.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN2PR12MB4240:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fd67274-83be-4c12-13fe-08decbb38427
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|10070799003|22082099003|18002099003|4143699003|3023799007|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	9FTs5hf9lMmoUFqqn1Y/OQsAi7MBeWe8JwHNlk3Re91UCAKjFpqEypJZKc4wYta7AsKGs6AsAq8uPd/53663928Z09FzTCER0wPSIpVNi7UlUJqHcVZg8tfgV6OKqtvQJnXbpPRJCor8L56/yuv97VhCexNpjqZk/MQCqrd8X+aOYR8uNJlFRYdrSxgfYEsfxg3qkbyCVkDE+Z1og4Y+e5Vzc2cetmlBVilddylFZakZaKadkhEkR59Td/yfoOJBIZJa2eR3jo06MfHu1+E+pue6AywrasxeFTkRuaCsRLZjAKiLZJOISiDeWhuBW47PH8qdvG6q/z8igDKCwR4XAihF+r3fQg11KW/bRkkbp1p5W+mTwz3FxcYsV9kVISbnQdAcCxHB1gvNGYsrdUv4daiDpk18u/zDy8wp906YKFKbK2BdgzcILBJ/kCzx0yDodjv2Kwk5ZCSddllB+oYr+fTssWdZcVvvbSNfMYZ+mWczAgaScgfdnQyGYZBdvBiZuoMRJwrxkmvHewjy2wmXdsI1kkqHuLU2fItqTMFaxqnwQGCaUBApbCJ5eDRsvy5pPfL25C7JHMN+P6ZjkGzl3KRqMdEfUsQLIGpPHBr3RQdpcbid5F5dIo0zx24IIBEWHOdIAd4nDOeJKFgMt5tKld9dhuflt+0uhfY/CQ/iKEsmUNqGDwJbm11swTqXJvKM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10070799003)(22082099003)(18002099003)(4143699003)(3023799007)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHM0elVLcmY0NHQ4aWZFMUdBZER3ajR0Tm5WZVdDakxyMmRpZTRVSnF2NThL?=
 =?utf-8?B?RjI1eEJnV2psMmZ5L25vQ1ZNTy80b0E5OTJiSVR0NmpRZ0cvQjd2R2p0NmNJ?=
 =?utf-8?B?N0lwR0ZHUjVjcFh2Wjk2T1RaYUZUZzZMQ0pSVUJFbnFBZEhDa2V2bFAxOFln?=
 =?utf-8?B?Y2pseWNCOE1UV2tMcVlBeHE4VE9CT0JxRkZPL3diR2V0RzRrNnZwY2V2Mjhv?=
 =?utf-8?B?WUVVOE0zdnpSUW5ncFNaQ3JMQlNSYkk5OHpHbU1KZ1dFckdFblNub1BQaVBv?=
 =?utf-8?B?anlGTVdUR2VBVmVZK3JjTkhSL1hXQ3pwclpVZE55dzB5eUYwa2dmUXdVeFZ2?=
 =?utf-8?B?V2tJeE9QSmc4d0hrSHhaQUdNSGFuUTNkQkdqZzFsamNnbjVhNkR1TXpRT2Nj?=
 =?utf-8?B?a0huZklXdWltK3A1bkZLWk84Mi9aeVRJTEd0QncyeEhJZXdCdU1ZcG1DMGNo?=
 =?utf-8?B?aXlvblpUUnNXK1ZXUythVE1HZ2NwSHRBRE04M3FZVFdaUktaSnBLL05aVjVm?=
 =?utf-8?B?Y3hINUcyQmdFbTRtSDdyMVVRLzFBN081dXZwWnpVZ2JnQ3dqK1ovaVhIbFdy?=
 =?utf-8?B?bmRPZlpSSUJ4c0N3NTVHeElxR0UwM1FYck9qQUR2aVE3WFVLOTFhUEc3bTNx?=
 =?utf-8?B?ZlJhTTVsYWozeGFOT0xrNmhjZTBXSDdlekdNSnFhb0V2Ykd0ekdBVDYzK0lK?=
 =?utf-8?B?NW1SeFFab1lwMCtzU0o3QlAva2dxVEd1YzBUYnJoUk1vUU5aTEhJZmhoUXov?=
 =?utf-8?B?SzkrWTNycW8xdFdQbEthUTJ3aWVBNnhJblB3SXNzSUMzMERKeDh0Q0FXSlM0?=
 =?utf-8?B?YitMUzMvcWxRdHI1ck5BbUllUFZBeHFtNTVyeng1aWd2dW5kV1BYS0hkWDNo?=
 =?utf-8?B?b2pjbkFkZGR3aEhNZld5aVYvM0tOMWxkRmszQkVCVzBKb1RDVnIreFR6YkE2?=
 =?utf-8?B?Q1ZlM04wc3FtdWdHbU1NRWd1NVhxUGNJMHZoTEJ1MnZjRy9xcHh5Y2YrbXd3?=
 =?utf-8?B?c0Q4V1lBOThnNnFtaHF1VlQyTyttUXVkR0NWNnVja0MzU0ljdkpkcjdmTU1X?=
 =?utf-8?B?NlVTZUpmTldXM1hWLzJDaml2QmtBYTVZa2JXakRjNGtlaWU5S0hMRzh2dld3?=
 =?utf-8?B?ZGkvbkdNbDlrbFpUL0dKcEVCMUY0b29uMHQzaUFrWHlSZ1hQZDZ2R09ZdW1m?=
 =?utf-8?B?UkxmZFJ6Q05UUGxXbFpUL2VRaWhaYWEzeEI5MlUvVTVram5vYWZGVllkNVpJ?=
 =?utf-8?B?Z1dTUm9Qb1RmQnpTWmZ1R2FNbkNYQXZzZkNUWG82Y1ltNGJmb1VTQTZhNWtB?=
 =?utf-8?B?RW8rOFdVQklReFVLcnZQSEFzaTIyTWttMnUrSk4zVXNZTWppV3ZzSFloa1di?=
 =?utf-8?B?R2I4Qy9scDZMVE5hZUxhaFZMNzZMc1FTa2diUTJ2MjJrUU91emdBWkIzbWY0?=
 =?utf-8?B?MGp5UzY2ei9YbWMvSFZkNXhqQTlMU1F6L3pMa3NJMDJJbzlucGxpM3E0eWpH?=
 =?utf-8?B?anFEM0xkcmNnQmlrT2NJSzB3YUF4ZHNoN2R6WHh3SytaRVN3cFZFckMxRElT?=
 =?utf-8?B?VzJrZGtFUzhSUytST0VoUlZqNmVSb04zM0NyeE1vaTJ6NndDKzBFNnNKVXBr?=
 =?utf-8?B?SWZvQ2pzZCtFMXRPRlB4bkVDTmIyWU9zMGZ6aVJTb21QYWY5U052V1VNNkF6?=
 =?utf-8?B?T2IzSFowUy9JNHRaQ2Nzem00czQxRnJGR2xsWTI5TGVhV3AvOUNMblZPSFNH?=
 =?utf-8?B?eElmU2o1YWs0a3dKTlJGbEMzdS9MbGFpMU1kUVU4dWI1Wk9BSjI3TktHRTNR?=
 =?utf-8?B?cHJNNGRWLzY2bm1Ic3hCUi9LRUU5clhOQkNrU0RxT3M5WkpSdWloc1dhMEJn?=
 =?utf-8?B?OG9tVmZqeWd4eC9DTjY5d0JYdVQyU2tEY1dvbWhFNlMxK3lNelFXeEVXQ2tw?=
 =?utf-8?B?aG9iUFk3QWpPMURTNWl4NjltL2NFWHYxL2xScUkrek1TcFI3U2E5WGpCb0hq?=
 =?utf-8?B?dkxaSFJtclpEM1ROaElEUndia0JuaHdXZGJUS2hBaGEyQWxUUUlYV3k2aER5?=
 =?utf-8?B?M2VHVzBwZ2crZGJyNXJGVVg2S2doblNQZ1VtdWRBWFpCa2ltSVlYdXN6cXZK?=
 =?utf-8?B?STIxcjFHbUFSQ3RubzRmcEpkZS9DT3BHZ0hZTFBQYmdVK0p3d1czekxodkVl?=
 =?utf-8?B?RUlEUkZKMnprZFNQSFg3OEM0RWhaVnhLdWdoa01ON3RBYm42VEZtZFl5NFVq?=
 =?utf-8?B?Y0NISFJhUlMvTThUa3g2aENuVnhndlBBNUZmMHQ0Yi8ybW43aGlGTzZPSk9O?=
 =?utf-8?B?d0s4UTNOZldtK0NXQTkzcnFLbXpObjJFQ1FYZFlXOHYrLzBDOGFJN0pnN3dU?=
 =?utf-8?Q?6t86e0sYu5ZgOu0kQAlXBeruDo9JI3Jae+cLfG4ED0PzH?=
X-MS-Exchange-AntiSpam-MessageData-1: laEhDpZU+nxWNw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd67274-83be-4c12-13fe-08decbb38427
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 14:28:21.1562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yWkx66SlCyFjF1ta2bz/eoATwkrGMpcb/+Aj+rDwtMNJyWM8uaUe0fsCgH3VcTpVFbTAquz+DyDuv5wAUMssNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4240

On Tue Jun 16, 2026 at 7:58 PM JST, Gary Guo wrote:
> On Tue Jun 16, 2026 at 7:34 AM BST, Alexandre Courbot wrote:
>> On Fri Jun 12, 2026 at 1:28 AM JST, Gary Guo wrote:
>>> -/// The PCI configuration space of a device.
>>> +/// A view of PCI configuration space of a device.
>>>  ///
>>>  /// Provides typed read and write accessors for configuration register=
s
>>>  /// using the standard `pci_read_config_*` and `pci_write_config_*` he=
lpers.
>>>  ///
>>> -/// The generic parameter `S` indicates the maximum size of the config=
uration space.
>>> -/// Use [`Normal`] for 256-byte legacy configuration space or [`Extend=
ed`] for
>>> -/// 4096-byte PCIe extended configuration space (default).
>>> -pub struct ConfigSpace<'a, S: ?Sized + ConfigSpaceKind =3D Extended> {
>>> +/// The generic parameter `T` is the type of the view. The full config=
uration space is also a
>>> +/// special type of view; in such cases, `T` can be [`Normal`] for 256=
-byte legacy configuration
>>> +/// space or [`Extended`] for 4096-byte PCIe extended configuration sp=
ace (default).
>>> +///
>>> +/// # Invariants
>>> +///
>>> +/// `ptr` is aligned and range `ptr..ptr + KnownSize::size(ptr)` is wi=
thin
>>> +/// `0..pdev.cfg_size().into_raw()`.
>>> +pub struct ConfigSpace<'a, T: ?Sized =3D Extended> {
>>>      pub(crate) pdev: &'a Device<device::Bound>,
>>> -    _marker: PhantomData<S>,
>>> +    ptr: *mut T,
>>
>> `ptr` is used as a pseudo-pointer here, can its documentation be more
>> explicit about that?
>
> The invariant section is already hinting this by saying the pointer is be=
tween 0
> to cfg_size?

That's correct - I guess I am more worried by the fact that `addr` can
return values based on these pointers that are not dereferencable. The
problem (provided there is actually one) should be addressed there I
guess, I made a note about it in my review of the next patch.
