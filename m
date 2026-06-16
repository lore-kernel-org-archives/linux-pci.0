Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022110.outbound.protection.outlook.com [52.101.101.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B70D436369;
	Tue, 16 Jun 2026 11:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781608384; cv=fail; b=s7iuxShEQuvgRAKj9ClLCuSLHoRjVZnuyFml2c2BshWvpURqMrOl52mOdmu77qP20CSJ3Y9SOnaAlUFtmIwldfo/+CtCw2FuSEl08CkN6YUVTEYn29RvEGHXQ+uFUBNzWxuGDrugqb4QVqYT2KeMMWwfJ5ezK5xLqPJnIW2R92I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781608384; c=relaxed/simple;
	bh=lsnIRHdKTXXZ/uSrletTNPLAkbqv3AQNJqkVXzA8x8A=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=W3wWlblrsYR/x2KNmKESGssikluyhgAWl97MhWGRNR2UcYW01MlX6KMFBhiWV45PhePywL2srwbHY3zrQAzino8BunnzWfdBEGAtvTsp/Onwf0BuGFTl+Ctd65U7lYw4jKsIJU73R8YkH0OE7RH07jLGj2Cc2VN2fsw4HaVQ0+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=feHoVzyX; arc=fail smtp.client-ip=52.101.101.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="feHoVzyX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k18WeP+fyi/Can4UgmubAtoV7oDFd96w3GT7VeuZsRTzlHKTVcAAJNb1U9n8vaSaz3B5nl/HW5PN6dV1CCSSD7BoxldWbwn6WCaXDWC19M5QtLamTJFFqNg5LmKwKmDVExNk6n5X1Riu7BsnUd625QOKz8w9tRa0NnfGYCmtDhrkuCxnCrJIggQ0cS4+TJPuzFXJyxSve8GF9Pu6GDRC4ya4EspBsAxT5o8FbhVua1G2wtQ8/NdrdIl608CADXqYLWSL7A7i7enBe8KgCWvTYac+XrdetBcrxKQWUAPXUXK2d2tSRY8eL8RZ/c8c/sEN9w0tCjpMHiKnOlXuNJAkoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7WFIft6NXMpF/MvPJjpDVvNiULb+piafNvfCxbyhlk=;
 b=CR0+RzN7iSJX4MXv9kvK2q9/182DtjPsEvUDc+GW2Jsrd+5pblrW+MQpWwzykMLtlmwVQTOmE3fdCNZqNdrMYYkf4Uj+66melXQUOTae67Pj6CFmGoe+6YJERHfKUptoEJ32QKYZJHEQNmcBSDaQKNlkkJkZoNhE+vdne5hLjiPJiXu9q8ohU+VQSj4A3MNiOxfXPVFB/jt8u6RLOlSiX5/hCfdDqpWBA4lcHrE9NZaDDjU7baOVzjzi0iZQBaulTchogp1uncfVCDuwBBW2J+B/2zcW8vzn9POl5lZ0N2I6TTKbRTHwScQ8RuRs3ASeDxDB/t8Gu4aRcd3FTFh1tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7WFIft6NXMpF/MvPJjpDVvNiULb+piafNvfCxbyhlk=;
 b=feHoVzyXOw1AMWe+lSaR0IbSZREveC/ablN0QUdzB3v/JzD5owl0liPHrMYZJ9zh1/Qtf3yJOWkZrHgRXlo3uVgYEvKjzsffq8nn3J2P/Lhwhtk60sBv2wgwqwiKRvsxhZQM06FSyuSFzQjN8P9SEhICNNqdXRlIhJ1b8uRGByg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB3280.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:198::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 11:12:57 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 11:12:57 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jun 2026 12:12:56 +0100
Message-Id: <DJAFGLBC8WQY.L3P1T92AFN45@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
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
X-Mailer: aerc 0.21.0
References: <20260611-io_projection-v4-0-1f7224b02dcb@garyguo.net>
 <20260611-io_projection-v4-7-1f7224b02dcb@garyguo.net>
 <DJ9PI9NEJ92T.3D0E90RPSCXA2@nvidia.com>
 <DJ9PXYB91UDG.3BV4EJJ10RIC4@garyguo.net>
 <DJA1J6H6Z6CI.3LLUM4T35FXXK@nvidia.com>
In-Reply-To: <DJA1J6H6Z6CI.3LLUM4T35FXXK@nvidia.com>
X-ClientProxiedBy: LO4P123CA0431.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::22) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB3280:EE_
X-MS-Office365-Filtering-Correlation-Id: c443ae29-f02b-46c7-4417-08decb983841
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|23010399003|10070799003|1800799024|56012099006|4143699003|5023799004|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	3LezqJ3tBdCOHmEKbUXsWDUM7f3hp9hY+HQmi1zGqZ5gDhV21TpQOHIzJji2v26w7qcA/2lnvFn407WUI57pr9oe+k9RE2CyCsbdvq1nWuV8CE1aTbmzTnPQb/VMc/btpMPY+gFkGg/b+p7XxpHl+it4Dy9CIzrCmbH+fAX9m2v7lQRIMNNU4haULE5XChUfeWiqjqQF9TOU4vlT3J3+Yg0s014bzzlxfdh3Jejn0nihLwMSFt8B+FcSlAH1usPYc3ujpxK0ZyhnJIAheQeRr0pG+kYLG6LPSXpHR+Ejpf3WvjlUjrGQoPudoz9QuXBL5mcQSX+kwqE+RrEtcWzcwL4XrlGoDfI1n6098Qxds1JbYwcn5MHeRrvk5AE43QL0mq+LNEeG2tu0sd1cfoOs8oM0Weo8iHrZoOQU+NGc6ty5JxjX94Hl8oxjz/I1YpKdvB4xhRhAtdJqMzU9Lgmo7KOabb3FFDbsedACkc7Xqpm5o+9b8Q8MdoSztTZ8edW77+l0h6hOqElHPRV3trhoEcSipSlllsAuaN5D6ktdw5UPZ16MQ2zzBxedEvYkT2f/CNQi+29A29l233gRlPwFPN1IVa3bPOnCk+kFNZUNIZO9aIq9xKVtbDglrjGZiGVVMlj3ucIAik4P2iyBstBWuT32WFF22cx6CCHVlXqBajrSlFJDvD8kaBTPVs6G+D6P
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(23010399003)(10070799003)(1800799024)(56012099006)(4143699003)(5023799004)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2RseE1PdnFXS2pldU5YMkJ2SFQ0T3E0T2pSRzUyWVNPREJGODE2SGd6MDdk?=
 =?utf-8?B?aFVSV3RvazJ2RlhaOGYrM0dvYlU2UVYwQ2RLa3RSRGVOMjc5U0lMODMwcWlo?=
 =?utf-8?B?WDFvbmRtY0NHbUpZM0ZoMUNDdlVZWnpiQ1ZwVXhycmpQYm5KdFJQS2ZXaWZW?=
 =?utf-8?B?UHpEcHlVbS9oalpzc0FvMTEwUlBXVGJqQi9sY0lGbjBEOThMakRqQ3p4Q0VQ?=
 =?utf-8?B?S0ZQYTNxYm1xYkNHYTZESDZBcW03QjRHeGlQNFordzRiTXFqUTdET0g1VlQy?=
 =?utf-8?B?TEF6aW5xZFp4TWVHSXh0dDZlWU0yTXFMZUlzTDhXSjV6bVdkVEc0TEp0QzVH?=
 =?utf-8?B?S0FwcUxLeS9RZUVnZzZPa3J2M2srSGpDRVMyTDdXWk5BeXVuRUdienN4WEZ4?=
 =?utf-8?B?UGNRaUNVa1NjenJhNkJySWhOb1lHYUxkdnV5MW5tN2pGTHNBYkZqU0dnUjR5?=
 =?utf-8?B?TVRpb3o3R0pVckxURkpKc0g5Vi9hMHdwOVduNDIyM01yY0RUU1N4UGNzd1l2?=
 =?utf-8?B?ZEpHTXAzRTFpb0F0dHNwSE9aSWxjTXNPU2JVcUt1cHpDL1V0dWRWM0lIeE4r?=
 =?utf-8?B?bmdmbHlRM29KdHlKM1ArdVU0cGZwdUhLVzhGM3J0Z1c3d2RIMUlhcEQ4Qngz?=
 =?utf-8?B?eVhtR3NCaGRuZ3VPRkNFYTVVL2o5YUhNaXBJVFk1UDhBdlZBc0M2aHlMQWx2?=
 =?utf-8?B?THdXWklsL0NOS2FOdkhyWVhVOVNoUmowZmE5UFF5Qm40MGMvTDkrWit0Rk1o?=
 =?utf-8?B?R1V0dS9HMFBWNVN3OFFiMGpFOGpHbjR6RnA4S3BmT3BwYUlISEhPRGs2cVdP?=
 =?utf-8?B?RmtpZlJIaHJoN2JEUktoRjhIMDBldzhNUHRDU2dHa2djSm1jZXY0dVNUbUox?=
 =?utf-8?B?ZStGMHc5bzdBRWFXM2dxOFQ3Y3F2MDdjMElUemdmT0htSTNMUCticG4zK3Q3?=
 =?utf-8?B?aGxsc2Q3V0crRFRhWUlQU0FlTEtmOXRQMXRVUkxqWGZndUZEN25aTEpFdkNN?=
 =?utf-8?B?KzdubkhLTXJWZEZoMG5QZUFteS9NbUhCZkQ5YkZhOUhlUGpqaktkbXN0UWFW?=
 =?utf-8?B?Q3psdGJSRHNKcHIvTUh0U3Q0QnpOSUowQjAxdWJGU29zRU5EREYzN0ZpY2xq?=
 =?utf-8?B?K0s3UlhTWXVFUk5oVVY4NStqT3dXRmlScjBQOTVCUFpETHRpQXkyVlk1MFBO?=
 =?utf-8?B?T1hXUmNpUE55WUtlZS9OeUxxa3NKSy9MT2YxYXF3RnFtTnF3LzJOb1BaRHJB?=
 =?utf-8?B?c3JWZEZGS1B3VXJiODdzVUY1NmJOZ1VvMTNCUjNDaGlUSEozWGxRK0hXWi9j?=
 =?utf-8?B?RDdRcnQxb210SGxkVXRkdUVyaUNiYUFkQUlnbXBoTDFlMERuak8xeXFoLzNn?=
 =?utf-8?B?NUd6Skp0Vks5Z0dwVlBkdkw4SCtBemp2Nmd6dndqdkFnRklQckxBdCtKWGhw?=
 =?utf-8?B?VkREaVVkMjBkWGtYOG1CWXU0eDNEaU1zNzRwaFRQY2VsVWlwMEh5aE9JR2dS?=
 =?utf-8?B?dEZ0U3R3S214Y3ZVZng2Z3Y5NjNDTGQ1QjNDMWcwM2hKZWl3UFhGT1NXN3VT?=
 =?utf-8?B?Zk96cmY4VE9aNDVFRC8xTUwvMnFMTkNaSVVtRGwxWkFxbitLQXl5TDZzT1pM?=
 =?utf-8?B?MTk3Qi9PNldYTndWYkFmQ2g2cFRmc3lYZ2c0SUNWb3dtdTFyS0RkU1JzK3Fv?=
 =?utf-8?B?M0lSM2dOUjNyNG9kTGVtUFpBUDA5Q2xsdmsvUjhYeWVRV0lua1UwN0lwZzRa?=
 =?utf-8?B?MGZycDA1eTUveDJweDRQUTlueUdFYUZmcTNqamFZbVZFZVZPYzM4N09rWVpZ?=
 =?utf-8?B?OEQ2eTVlUmM3M2hkRDFPMURTNHZBY0NZK0oxd1JwUnJyTEU0azNmUlprVjh4?=
 =?utf-8?B?cS9MRnRRS2ZRNWZoaVpDQW9kZmltMmpYUyt0QWh3RmQ1SG9CUitZeEJNZEJj?=
 =?utf-8?B?Q3ZBNG04cGZ1bHRpOWRHZTZjSGhuMVNXMEc5VGVBUVdiajR0SkJRNXZRZ1hJ?=
 =?utf-8?B?K2dDZHE2am9MeVN0d3ZpbCtrSnBhcExKZmFuazl1a21RamNlSGhtRnVwVm9M?=
 =?utf-8?B?V1dLSGlVRS9PVEZ4aC9pVWRMYzJ3ZnR4SUdvR2N4Y2psb1F2RDI2eG55OUhG?=
 =?utf-8?B?Rlk1eTZWME5wMjVrckdDQnN2SDkzSmJRTHZuL1NHSUJROW9HRDAxRmJzNE8z?=
 =?utf-8?B?VEJIMDFvWEw2TEFNcWZ6aWc0WTRMcmtwZEJsaG1jZElwS0xoblFDWUZqR25K?=
 =?utf-8?B?R0d0RlEySmJrUzBoMXZlSnU2VzVVLzZrZ2VweFQvNTZURTdwc1hkdnhDcmtD?=
 =?utf-8?B?VVh3UnZVNEliRmxsZEU3cEcybTNLMmlRdlFkeDM4QkxYaUU3NUx2UT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c443ae29-f02b-46c7-4417-08decb983841
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 11:12:57.3394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJRx9XqZRJz08cebERdMilGw0czS/nFJ9JJbckH5mkJYgYLMNu0QQLwc1nUTZvG+fNbYZH30C0QfKCtWE7UpTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3280

On Tue Jun 16, 2026 at 1:18 AM BST, Alexandre Courbot wrote:
> On Tue Jun 16, 2026 at 12:13 AM JST, Gary Guo wrote:
>>> Is there a reason for not just declaring `RelaxedMmio` as
>>>
>>>     #[repr(transparent)]
>>>     pub struct RelaxedMmio<'a, T: ?Sized>(Mmio<'a, T>);
>>>
>>> similarly to what the original code did with `MmioOwned`?
>>>
>>> I tried locally and could build. This avoids declaring `Mmio` and
>>> `RelaxedMmio` as basically identical types, and lets us remove the
>>> explicit `Send` and `Sync` implementations. IIUC you can also reduce or
>>> even remove the invariant section as it is enforced by `Mmio`.
>>
>> This is what I did originally, but this would cause duplication for
>> RelaxedMmioBackend, as now you have to do
>>
>>      unsafe { bindings::$read_fn(view.0.ptr.cast_const().cast()) }
>>
>> and the `.0` causes the macro not being shared with MmioBackend.
>
> Since `MmioBackend` and `RelaxedMmioBackend` both implement `IoBackend`,
> I think using `IoBackend::as_ptr` in the macro should let you avoid the
> duplication?

Good point. Are you okay with the following diff?

Best,
Gary

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index c6f3ab530b4f..a8da625560a0 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -1136,14 +1136,16 @@ macro_rules! impl_mmio_io_capable {
         impl IoCapable<$ty> for $backend {
             #[inline]
             fn io_read(view: <$backend as IoBackend>::View<'_, $ty>) -> $t=
y {
-                // SAFETY: By the type invariant, `view.ptr` is a valid ad=
dress for MMIO operations.
-                unsafe { bindings::$read_fn(view.ptr.cast_const().cast()) =
}
+                // SAFETY: `$backend::as_ptr(view)` is a valid address for=
 MMIO operations for both
+                // `MmioBackend` and `RelaxedMmioBackend`.
+                unsafe { bindings::$read_fn($backend::as_ptr(view).cast_co=
nst().cast()) }
             }
=20
             #[inline]
             fn io_write(view: <$backend as IoBackend>::View<'_, $ty>, valu=
e: $ty) {
-                // SAFETY: By the type invariant, `view.ptr` is a valid ad=
dress for MMIO operations.
-                unsafe { bindings::$write_fn(value, view.ptr.cast()) }
+                // SAFETY: `$backend::as_ptr(view)` is a valid address for=
 MMIO operations for both
+                // `MmioBackend` and `RelaxedMmioBackend`.
+                unsafe { bindings::$write_fn(value, $backend::as_ptr(view)=
.cast()) }
             }
         }
     };
@@ -1185,14 +1187,7 @@ unsafe fn copy_to_io(view: Self::View<'_, [u8]>, buf=
fer: *const u8) {
 /// the regular ones.
 ///
 /// See [`Mmio::relaxed`] for a usage example.
-///
-/// # Invariant
-///
-/// `ptr` points to a valid and aligned memory-mapped I/O region for the d=
uration lifetime `'a`.
-pub struct RelaxedMmio<'a, T: ?Sized> {
-    ptr: *mut T,
-    phantom: PhantomData<&'a ()>,
-}
+pub struct RelaxedMmio<'a, T: ?Sized>(Mmio<'a, T>);
=20
 impl<T: ?Sized> Copy for RelaxedMmio<'_, T> {}
 impl<T: ?Sized> Clone for RelaxedMmio<'_, T> {
@@ -1202,12 +1197,6 @@ fn clone(&self) -> Self {
     }
 }
=20
-// SAFETY: `RelaxedMmio<'_, T>` is conceptually `&T` but in I/O memory.
-unsafe impl<T: ?Sized + Sync> Send for RelaxedMmio<'_, T> {}
-
-// SAFETY: `RelaxedMmio<'_, T>` is conceptually `&T` but in I/O memory.
-unsafe impl<T: ?Sized + Sync> Sync for RelaxedMmio<'_, T> {}
-
 /// I/O Backend for memory-mapped I/O, with relaxed access semantics.
 pub struct RelaxedMmioBackend;
=20
@@ -1216,20 +1205,16 @@ impl IoBackend for RelaxedMmioBackend {
=20
     #[inline]
     fn as_ptr<'a, T: ?Sized + KnownSize>(view: Self::View<'a, T>) -> *mut =
T {
-        view.ptr
+        MmioBackend::as_ptr(view.0)
     }
=20
     #[inline]
     unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + KnownSiz=
e>(
-        _view: Self::View<'a, T>,
+        view: Self::View<'a, T>,
         ptr: *mut U,
     ) -> Self::View<'a, U> {
-        // INVARIANT: Per safety requirement, `ptr` is projection from `vi=
ew`, so it is also a valid
-        // memory-mapped I/O region.
-        RelaxedMmio {
-            ptr,
-            phantom: PhantomData,
-        }
+        // SAFETY: Per safety requirement.
+        RelaxedMmio(unsafe { MmioBackend::project_view(view.0, ptr) })
     }
 }
=20
@@ -1267,11 +1252,7 @@ impl<'a, T: ?Sized> Mmio<'a, T> {
     /// ```
     #[inline]
     pub fn relaxed(self) -> RelaxedMmio<'a, T> {
-        // INVARIANT: `RelaxedMmio` has the same invariant as `Mmio`.
-        RelaxedMmio {
-            ptr: self.ptr,
-            phantom: PhantomData,
-        }
+        RelaxedMmio(self)
     }
 }
