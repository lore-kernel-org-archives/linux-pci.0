Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022139.outbound.protection.outlook.com [52.101.101.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A71F4582F5;
	Wed, 19 Aug 2026 11:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787137827; cv=fail; b=HTgEnDI4GEGOD/RVc86gncergIZPsPCUhgGpDcBAy6fYp53ewk0jO25Ayo4nLoC/D7MVHPtEpZpKWRL5Z0/UTlcYrRFshccMl+5LQl5KLYh66LmfeTVPev0dEQC4St25Z0T7983JNg2n7SWghKDYCNqckAe0Qiu2tkUWfhiKHuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787137827; c=relaxed/simple;
	bh=fNklDIbUzqKSWVEec0SWn3DPw8OYEFfR6ffLgTCMyYU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=KkK0q9vK8u640fFcN89p5kB5goxu0xAd8w/LJcVKxmGiVbjD5a1FT1BkDOcJCCsNS7F9Rxqpg1IhxV6v79kwNadEMtcVR2Da+56XAmDFCrhAZGPCEeX10je2ZPs+x7TbT/pG2zSGxrAXF83lEwAxVR/OSX5YGl84s0O4paMXozA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=WONRkcjY; arc=fail smtp.client-ip=52.101.101.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="WONRkcjY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wVpNd674T498BF3qwmvBrflbOns4B0l1EShDa4gULoAmzFNNn7wM6FfVjw2f7M0zjVNEAmT/EqjRQvWOFcWZjWfCyB8c8HNJCq0A54bZ0pHAYxDTBYmXUdhvR5fEbLUbUYdTn46mluA442GhfqMMtgmGRtyTaz+TEpTVP1QTQgQIn4EkYg+zq/sAu8/Uvy3JrrqJnKjkCl8jGSDdx54VkDyHuCBUPcSUGHz2sJOPCA6/sVBd2uMocRjW16XYXfvk8wfHKJetx9Yi0zE4+MkO1yf3yviHZnAL/eED6rqi0LHyjRy6SLw4G+sEWOHTZmax1JyoKX9xI/dsCnMrM1LhOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJJU6M0wRwT05SIiqR0kX7QMTa06jMPQLqD4QL3HvJg=;
 b=oNRv18YeMW7siwNKFnRV1Z8+p4d5RqDGVmgtOTJy31Nbi9yGY0LaBMko3mlY0hZWUZh7dnOUus/3hBgk1jVVLscWB97g70b2t1VKKPK9vaaEYJJOhBQq1/x8bkfTcgSCd0ADc0nHcZHIBp3lX9r1NdL1dLAW7N7ftdIy2KQkUFwHgG3p3SwfP5bYwKIv+i8/oEWVMLH+cke6/bwmkiVtEya1fgrAjNhymFoa5TH94LmalWlQxmKXQEp6vuWn6PmZhySMvD5d+YJWLCtDvxLRrxBI3GgjCTfF+b+izgNtZdfnaV+nqvhtsZh3e6k1a/YALzkZng+rmC/CgBIhWiVaKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJJU6M0wRwT05SIiqR0kX7QMTa06jMPQLqD4QL3HvJg=;
 b=WONRkcjYGLWE9gSeF2o45pCrOYUkL+AZq1lRZvLWhvZn9MmwDT0wKMueZaB5x0681nsieL2le1iDsNYa4Wt9u3x/3Ldvy7xLQce+wBaq9d3XZbVypdRi4lcbkS65Z2TM7uH7sKIOULTu7SoZBtMgVeFlRSG8PFdgMhHWUIJfSB4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWLP265MB5113.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:15d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 11:10:21 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 11:10:21 +0000
From: Gary Guo <gary@garyguo.net>
Date: Wed, 19 Aug 2026 12:09:18 +0100
Subject: [PATCH v3 10/16] rust: io: register: make register have a typed
 base
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-typed_register-v3-10-3699a75fadf1@garyguo.net>
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
In-Reply-To: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, 
 Gary Guo <gary@garyguo.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787137814; l=9303;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=fNklDIbUzqKSWVEec0SWn3DPw8OYEFfR6ffLgTCMyYU=;
 b=fz5cHTSBS+Nb0xG7qnnrNoT1YMOMcJ0YOBm+VpAMcu2+rxaa7HCaGyIxKzuKy8hwn/feyiw7r
 upAMWWLxwz1CA+GvBpRWy0Gel3Y3vti70p69GKJbeCnROHSUVHSuQjW
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0096.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::11) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWLP265MB5113:EE_
X-MS-Office365-Filtering-Correlation-Id: 5449a54b-9e34-4407-9980-08defde275d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|7416014|23010399003|921020|3023799007|56012099006|10067099003|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	fujDrFXF/IMBBFjQnUVc6SN0c46MRdswste1XSt8I4pb0QKVYav+jDCGVt8sFyfQW+yriNAo37ZCLGVwr1qA0xP2bOCTEqnE82dbrxsXRAHLfPSEf4nv8kd/2NXztL2nDRHezg5riu9ZbavDP6IoRxlZsN9yc5j/XL3EQtS1kgVebM/6MaTkL+JKVCZVC2oeI94eiopa6yX1I4hWQgHnCJbHWluU5t9Ardn0WANHS1fmyLvw5xMXhPJ79a1bM+J74avHPPJVqQhFClfbpANW0lu05MSUHJj2YBXCj8tvmqaRYngdwAdrykJ//kAlV/a+hUbHe3ToakyyaFDupl5q8otWNWifPbaXdf5o0Dauw4LUGnQIJhpWPyWcOdkaVcJpgi3mGYM+G7ImmFE1hddyCgDwoCWKlJcYWoMBnqzI84gDUpU7Agyliz79KMhf7uq/CNV6SHwaa3wCCE9FrcAifb635jOEUt7fZtTPCdOozEGhn6Z/FZiL3gSYjDZrltHzTZ85zE5ZDP0IiRUgDo19JltlUww1D3Po3S2dI4J7bTjxRi7z4REm9vta6PJYWYBG2wSDMuoSjW3oKmWWJIbs7NAvk3lNoh5qTzFpLlO440d0FzsKyjFzE23MoKNIzpXkHgrkZDHCNmJFIFa0jgmq+DS4d/Dyu6QKRTpVBXfyAwxNx8WDxQICIqSCQWB02OukQHtdkWEEvkHirUgOkWzozQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(7416014)(23010399003)(921020)(3023799007)(56012099006)(10067099003)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dEJTY1pScHJ4ZzEyNkNDem9pcG1XVXB4MHo5Ukt6UG1RdXVvYjNEdm9WWjl5?=
 =?utf-8?B?dFdUckNzaWdhbjZDS1dTQ3l0UE1EOFVaYlA4MEVrQ1ZiNFRkdFl2dXhkcmV0?=
 =?utf-8?B?cTcrQjh3ZXlzUUVZT1VTYk5LMG02d1NuZFV3aDVNWkNKZ3dMQnhHZDJYRWVv?=
 =?utf-8?B?czRyUTVoc1JCU3BINVBoSjRFNmNVMW1lMnlCMzhIYW9DdyszRGRVUzd2a1Ax?=
 =?utf-8?B?ZlM5QkV0U012OFN4ZUt2MHJvbVdETFBpREpJVUdnSmd1eldJclByTnBkRXVC?=
 =?utf-8?B?eWdleVJLc3VaVWZmS0hSQkxTR1RISy85aW12MzVzdlJFaGQ4VGkyUENRUHBW?=
 =?utf-8?B?VG5GelIrS01sNGFhcEhwaWJheDNFTW5DM0hjNVcwUzZyODFiS3Z3UmFSNytX?=
 =?utf-8?B?NER0VzhHWDZydmphU2tWOFNqcXVvdmdDYkhuQXVuMEVXY1UvTGs2eHBYWTBl?=
 =?utf-8?B?ckxLVmwrZnd5RnB6VmxDVUQ0Z0twaHpGYVl5bkJZMkJDNjlOai9panYxeXgw?=
 =?utf-8?B?bS9iS0JqVGNwM1N2NEJEZHM0VXFWaHdldTBaSFQ4aG5GcmR3UmdCZVhNSmxZ?=
 =?utf-8?B?T1p2aFJxKzNFRmpZckhtOFZseHhOVVZXWElwZGJFUENid2hjYzcxZVNDQk5P?=
 =?utf-8?B?WTNSa3JHNVAzRzkrOElrTkJ5b2ZsL3h2ZG5OaDdnZDNwYUozWDhPMWtXejRB?=
 =?utf-8?B?bzJZSlQwVS9EYVBzWS9IN2dHWWxzclZhc3ovVjBKMXhYa1hwL1B3NlBQd1Zy?=
 =?utf-8?B?b1Jsck9tOHgrUXZvSmRWTkQvZ1VYMHEzUGFhbjRxTllFUE1hOUtDRzZVaVMz?=
 =?utf-8?B?QUJHcERoVnFnbkZRTm5QdnROQWdocXMvOThzVXJGb1pSeEFTL0hVQXZnS0t5?=
 =?utf-8?B?dDdsUHNneXdsaHlScExsRTdNejBFdjVMYU1BVmUxMHMzQjdOME1nY01nSWpJ?=
 =?utf-8?B?Y1V4TVdPNXNSZjN1YU9FeVVSK2ZQaU9zY2lvZ0xveG5tZU9BK2w0c0RxZTZq?=
 =?utf-8?B?ZkpWMXpLdkhlTFllSEZRUTJVR0hNcW9kdTlBU085Ym5hUUhQZmdITXJuWlht?=
 =?utf-8?B?VDZkMFhlWGcvLzZqTXhsOUV4eWRhN2FRYW8xcE4wekh6d1d6ZzBUdXRqb09i?=
 =?utf-8?B?LzNlWi9ET2tGVkU2TjR5TDdLa2JxVFArUEtsOWVVa1NTakxTZGMxLzFMY1ha?=
 =?utf-8?B?dTIzMFJhaExmTXFCcUNYcGo2OW44djViRjlycEZEL0YreUxuYXVzWFFyV3VR?=
 =?utf-8?B?eU9LQ1FzYWxJYW1Nc1hSNGw5OFdtTmVpYk9LUmVPOVZubkY5d2hVbm0rMGNk?=
 =?utf-8?B?TG1zMHFtZ3ZHVEdyRWIya2J5YnJNa1BYZVR0QStyR1NVZFJPdVYxQ1ZwbVp2?=
 =?utf-8?B?eEtrUGYwTHZFSlJBSW1qcitwcUg1ckRLUWRFU1ZPbHB5Yk8wQmhLZk1RUkhD?=
 =?utf-8?B?WGxXT0VRZnB3aS9RVjN2VjdRUlp2aVJFZnFwV0UzbVlwWFFWaCtVYzhPS3VM?=
 =?utf-8?B?OHVudDQwWVpkc2dET01YalEyam1rVTVmZW1XQUgvMGZTeFlKWCtDeVFYWkJ5?=
 =?utf-8?B?RmphYkR6Z3doYWVsOHRVOHVBN1VVUzMyenVVQXphRU9GVXQ4NThtR05uRFFn?=
 =?utf-8?B?OUN3c1dvVUEvQ3lWWTdLVEJlWDVNSjFrOEdhMDRHZjhxZnMzc1FLaUx3c3oz?=
 =?utf-8?B?UWg4VjVoU0xSNnlXaGYxQk5lTnhncmIzQ04rM3dGUk8zS2tHaS9mSzJUNi9Q?=
 =?utf-8?B?eVB6UHJYb1VGVUJsb0RqR0ttdnAzaEs0dUdYRm1XYmFsaGZ3bGFObWVzYWEv?=
 =?utf-8?B?Vmc5QVNWWEMrMnp3RTROVTFoSGtWbVdFZE80Tlo4N0FmeHBSdC9DYWpTWVhH?=
 =?utf-8?B?TUVidGI2VXZLdmdnUnIyVjZPT3BuK2tUUTF0L1Y2VG1qeEVyUnVub2x2ZmFv?=
 =?utf-8?B?UTNjanczUUFCdllJdlUvQWt4SlR4bjJIbHFGUXBqWHg4TXh6WE4vaTNqYkxr?=
 =?utf-8?B?bmh6QkZXV0ZHc1pYMkFGaDhRUThlR21xVmlUOU1sY0loY0lic1NaemhRelpQ?=
 =?utf-8?B?SHVvdVVtd0gxUnJlTmprQWhxaExpUE1RM2pocGRuL0w0VlhtYnRQanBzRkxr?=
 =?utf-8?B?Z2ZhcXIvNzlhVFJsckpsZ0Y2eWRsQy9SbXl3RW85L1ViZEYvOU1ZaHQxNnRw?=
 =?utf-8?B?eWpjUjE2UmFGOHZrOTVOTTdaTWxFSWJJdEpzWVpwbGUzeVlCYmtNclVYT2o2?=
 =?utf-8?B?RXZDWDA0MHhHWGtNZUtSeGRURGpIM3BpZ2pObE9qQ0dmc1ZleVlIY2prOE9h?=
 =?utf-8?B?Z0NXTUlPSXZSd3I1YmhwVkNGWThxS0JDcVRrdnE4VkZiQ0VSZHFZUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5449a54b-9e34-4407-9980-08defde275d5
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 11:10:21.5684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLCZiKsxnpBW+2JZFYo6NUGMPMk7D3XXXK8hMNs6aYdrzVtsBTrllPLq1S8RswV02hznOkLVI+tIV6YSECWQAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5113

Previously `register!` defined registers can be used on any untyped I/O
regions. With all users specifying their desired register type now,
propagate the specified type and restrict I/O access only when type
matches.

Also, add an `io_project!` example which is enabled by this change.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io.rs          | 13 +++++++++++
 rust/kernel/io/register.rs | 55 ++++++++++++++++++++++++++++++++--------------
 rust/macros/io/register.rs | 34 ++++++++++++++--------------
 3 files changed, 68 insertions(+), 34 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 84dd876b3407..4542187d6b91 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -1692,21 +1692,34 @@ pub fn project_loc<U, L>(self, location: L) -> <T::Backend as IoBackend>::View<'
 /// The syntax is of form `io_project!(io, proj)` where `io` is an expression to a type that
 /// implements [`Io`] and `proj` is a [projection specification](kernel::ptr::project!).
 ///
+/// `io_project!` can also project to subview of registers defined with [`register!`] macro.
+/// Register projection has syntax `io_project!(io, try: REGISTER)` for fallible projection and
+/// `io_project!(io, build: REGISTER)` for infallible projection.
+///
 /// # Examples
 ///
 /// ```
 /// use kernel::io::{
 ///     io_project,
+///     register,
 ///     Mmio,
 /// };
 /// #[repr(C)]
 /// struct MyStruct { field: u32, }
 ///
+/// register! {
+///     base: MyStruct;
+///     FIELD(u32) @ 0 {
+///         31:0 val;
+///     }
+/// }
+///
 /// # fn test(mmio: Mmio<'_, [MyStruct]>) -> Result {
 /// // let mmio: Mmio<[MyStruct]>;
 /// let field: Mmio<'_, u32> = io_project!(mmio, [try: 1].field);
 /// let whole: Mmio<'_, MyStruct> = io_project!(mmio, [try: 2]);
 /// let nested: Mmio<'_, u32> = io_project!(whole, .field);
+/// let reg: Mmio<'_, FIELD> = io_project!(whole, build: FIELD);
 /// # Ok::<(), Error>(()) }
 /// ```
 #[macro_export]
diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index 49a5fe069e47..f622057f7346 100644
--- a/rust/kernel/io/register.rs
+++ b/rust/kernel/io/register.rs
@@ -121,10 +121,11 @@
     io::IoLoc, //
 };
 
-use super::Region;
-
 /// Trait implemented by all registers.
 pub trait Register: Sized {
+    /// Base type for this register.
+    type Base: ?Sized;
+
     /// Start offset of the register.
     ///
     /// The interpretation of this offset depends on the type of the register.
@@ -136,9 +137,9 @@ pub trait FixedRegister: Register {}
 
 /// Allows `()` to be used as the `location` parameter of [`Io::write`](super::Io::write) when
 /// passing a [`FixedRegister`] value.
-impl<const SIZE: usize, T> IoLoc<Region<SIZE>, T> for ()
+impl<Base: ?Sized, T> IoLoc<Base, T> for ()
 where
-    T: FixedRegister,
+    T: FixedRegister<Base = Base>,
 {
     #[inline(always)]
     fn offset(self) -> usize {
@@ -148,9 +149,9 @@ fn offset(self) -> usize {
 
 /// A [`FixedRegister`] carries its location in its type. Thus `FixedRegister` values can be used
 /// as an [`IoLoc`].
-impl<const SIZE: usize, T> IoLoc<Region<SIZE>, T> for T
+impl<Base: ?Sized, T> IoLoc<Base, T> for T
 where
-    T: FixedRegister,
+    T: FixedRegister<Base = Base>,
 {
     #[inline(always)]
     fn offset(self) -> usize {
@@ -171,9 +172,9 @@ pub const fn new() -> Self {
     }
 }
 
-impl<const SIZE: usize, T> IoLoc<Region<SIZE>, T> for FixedRegisterLoc<T>
+impl<Base: ?Sized, T> IoLoc<Base, T> for FixedRegisterLoc<T>
 where
-    T: FixedRegister,
+    T: FixedRegister<Base = Base>,
 {
     #[inline(always)]
     fn offset(self) -> usize {
@@ -240,9 +241,9 @@ const fn offset(self) -> usize {
     }
 }
 
-impl<const SIZE: usize, T, B> IoLoc<Region<SIZE>, T> for RelativeRegisterLoc<T, B>
+impl<SuperBase: ?Sized, T, B> IoLoc<SuperBase, T> for RelativeRegisterLoc<T, B>
 where
-    T: RelativeRegister,
+    T: RelativeRegister<Base = SuperBase>,
     B: RegisterBase<T::BaseFamily> + ?Sized,
 {
     #[inline(always)]
@@ -282,9 +283,9 @@ pub fn try_new(idx: usize) -> Option<Self> {
     }
 }
 
-impl<const SIZE: usize, T> IoLoc<Region<SIZE>, T> for RegisterArrayLoc<T>
+impl<Base: ?Sized, T> IoLoc<Base, T> for RegisterArrayLoc<T>
 where
-    T: RegisterArray,
+    T: RegisterArray<Base = Base>,
 {
     #[inline(always)]
     fn offset(self) -> usize {
@@ -367,9 +368,9 @@ pub fn try_at(self, idx: usize) -> Option<RelativeRegisterArrayLoc<T, B>> {
     }
 }
 
-impl<const SIZE: usize, T, B> IoLoc<Region<SIZE>, T> for RelativeRegisterArrayLoc<T, B>
+impl<SuperBase: ?Sized, T, B> IoLoc<SuperBase, T> for RelativeRegisterArrayLoc<T, B>
 where
-    T: RelativeRegisterArray,
+    T: RelativeRegisterArray<Base = SuperBase>,
     B: RegisterBase<T::BaseFamily> + ?Sized,
 {
     #[inline(always)]
@@ -393,9 +394,9 @@ pub trait LocatedRegister<Base: ?Sized> {
     fn into_io_op(self) -> (Self::Location, Self::Value);
 }
 
-impl<const SIZE: usize, T> LocatedRegister<Region<SIZE>> for T
+impl<Base: ?Sized, T> LocatedRegister<Base> for T
 where
-    T: FixedRegister,
+    T: FixedRegister<Base = Base>,
 {
     type Location = FixedRegisterLoc<Self::Value>;
     type Value = T;
@@ -406,6 +407,28 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
     }
 }
 
+/// Helper function for register alias implementation.
+///
+/// This is used to enforce base matching. Only called during const eval.
+#[doc(hidden)]
+#[inline(always)]
+pub const fn alias_offset<Base: ?Sized, Alias: Register<Base = Base>>() -> usize {
+    Alias::OFFSET
+}
+
+/// Helper function for register element alias implementation.
+///
+/// This is used to enforce base matching and provide bounds checking. Only called during const
+/// eval.
+#[doc(hidden)]
+#[inline(always)]
+pub const fn element_alias_offset<Base: ?Sized, Alias: RegisterArray<Base = Base>>(
+    idx: usize,
+) -> usize {
+    build_assert!(idx < Alias::SIZE);
+    Alias::OFFSET + idx * Alias::STRIDE
+}
+
 /// Defines a dedicated type for a register, including getter and setter methods for its fields and
 /// methods to read and write it from an [`Io`](kernel::io::Io) region.
 ///
diff --git a/rust/macros/io/register.rs b/rust/macros/io/register.rs
index 2fb48e1be82d..cb02e850b23f 100644
--- a/rust/macros/io/register.rs
+++ b/rust/macros/io/register.rs
@@ -140,21 +140,23 @@ fn parse(input: syn::parse::ParseStream<'_>) -> Result<Self> {
 }
 
 pub(crate) struct RegDef {
-    base: Option<Type>,
+    base: Type,
     regs: Vec<Reg>,
 }
 
 impl Parse for RegDef {
     fn parse(input: syn::parse::ParseStream<'_>) -> Result<Self> {
-        let base = if input.peek(kw::base) {
-            let _: kw::base = input.parse()?;
-            let _: Token![:] = input.parse()?;
-            let base = input.parse()?;
-            let _: Token![;] = input.parse()?;
-            Some(base)
-        } else {
-            None
-        };
+        if !input.peek(kw::base) {
+            Err(input.error(
+                "a base type needs to be specified for `register!` invocation with `base: ty;`",
+            ))?;
+        }
+
+        let _: kw::base = input.parse()?;
+        let _: Token![:] = input.parse()?;
+        let base = input.parse()?;
+        let _: Token![;] = input.parse()?;
+
         let mut regs = Vec::new();
         while !input.is_empty() {
             regs.push(input.parse()?);
@@ -166,6 +168,7 @@ fn parse(input: syn::parse::ParseStream<'_>) -> Result<Self> {
 pub(crate) fn register(def: RegDef) -> Result<TokenStream> {
     let mut outputs = TokenStream::new();
 
+    let base = &def.base;
     for reg in def.regs {
         let Reg {
             attrs,
@@ -186,18 +189,12 @@ pub(crate) fn register(def: RegDef) -> Result<TokenStream> {
             RegOffset::Fixed { offset } => quote!(#offset),
             RegOffset::Alias { alias } => {
                 quote_spanned!(alias.span().resolved_at(span) =>
-                    <#alias as ::kernel::io::register::Register>::OFFSET
+                    ::kernel::io::register::alias_offset::<#base, #alias>()
                 )
             }
             RegOffset::ElementAlias { alias, idx } => {
-                outputs.extend(quote_spanned!(idx.span().resolved_at(span) =>
-                    ::kernel::build_assert::static_assert!(
-                        #idx < <#alias as ::kernel::io::register::RegisterArray>::SIZE
-                    );
-                ));
                 quote_spanned!(alias.span().resolved_at(span) =>
-                    <#alias as ::kernel::io::register::Register>::OFFSET
-                        + #idx * <#alias as ::kernel::io::register::RegisterArray>::STRIDE
+                    ::kernel::io::register::element_alias_offset::<#base, #alias>(#idx)
                 )
             }
         };
@@ -211,6 +208,7 @@ pub(crate) fn register(def: RegDef) -> Result<TokenStream> {
             );
 
             impl ::kernel::io::register::Register for #name {
+                type Base = #base;
                 const OFFSET: usize = #offset;
             }
         ));

-- 
2.54.0

