Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010054.outbound.protection.outlook.com [40.93.198.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8146F1339A4;
	Sun,  5 Apr 2026 14:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775400938; cv=fail; b=R2cxYXpq0L+R2Un2JoXgoVFC46aWQxb6wBRkpOspmH4kCJ/0Pc4OP+Osd6KHZe/t4gEPSLOas5LjNJqEs7M9Fvzh+SkdXvzr1S8xobu8uHvyU1JODNuvJo0IUuIoivK6Yfr4z49N9aGg1a6QwFG8HEk29QE+JEwE5aZzlFs2Hmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775400938; c=relaxed/simple;
	bh=EUehZ5HruNk1Wo/a+HyyFRiTEjSFgkXr1gqtW7goysY=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=XkJb2BO8UKVxx14/4itj7l3bNLs/iTm8U9vb0x+krW4cMxdGicHvBaSVXL3HCAN6s54och6ksnEj+2wfVcKmMT478W0zn31HKYZf1ggpYhiA6ikJJsZ2RU0A708SM+vO3QX5GJzMG5q6nlNqWFoZ7KdUbbAyLydwbTIo4zQbRoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lkVzT+er; arc=fail smtp.client-ip=40.93.198.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lkVzT+er"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hTDXkxmwnfu63zqEEuHDii6eeYnsZNsxAMI73gJtGfSBLIvSUok1TPVSNVMo4SvpkipAKjsOw4T5h9pAn5YipeA36DMJMAm1R/0ZutIBop/gl3m4rp/w9kr16cuFv61WjxIDzN/K7ELtkC1rGtxbfbN4VVSk1rYMV/Hci9tai4vB0c8tZrFkadqNOybJbTUlc/afogLlto+M/h2Tnjl529JQP7lDQOvvAzXs2eOVbfer5+7FiOanHKS0QEXrst7VFCao3l+40lD4BGs6aaDsq8SCWbwPlG23G/KjVksvSkqTexXlvRD4gq0qcz9k9Hv4KHN1SAejOUs6M1Wmtig8aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkYpogxtIkCk/6iIl0gOfP9j7Vd/vqc5oP4T+bGp7JM=;
 b=CwMTj5sBvgdDE5SYOKZtNfljkDRSFBPnpSP1bf45YXF9v3hjUuAng28LLBvhqV6/em9p2g1hMH42phx8Izdr/W3JjPUPpk81CaQndSN565DuZRPsBwe+2UJBUS+64NEpRuToMLhmgB3moAPwhqpjZH6y5WWy0F13uk6WqtmRWZbMT3XIXLBkpp9gAKqKivvNPA2mpKTaeqN29zaf8wFVFli14MV2OHfGnzX8Oj2Y2AN4UjXurNsZ4sEVT21XyJ00cGLXnhEvFHrmFBpWOpD+jjD2FYc2OkCdkxnFIdVVb7xTQ+JwSxjqXjKV+nuywnz4PpNe93pC0SgzW418bX/xTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkYpogxtIkCk/6iIl0gOfP9j7Vd/vqc5oP4T+bGp7JM=;
 b=lkVzT+erxe61F43bELGLwdmRp06DbcLg3EePzaEzNOF78644lDaXQ6428b8zHMSooyzfGbrOzurq/z0XnOXaGRVkkkbPq8QfJB5DYtHBJSyoDFONQRqOGvzLqIgJoaK5nt4yxMjFyED0fMH3Sp2g65PvN0r8e4yE6roNUghUPbpdRTT1q9cYwVi4LX4rSGRiz8jPOufj9x1GHl1r1H/2OBWx/FO+LlO+48SUvU1iAKu4bdtQ4Wkxpdkf8+LU9IcFzNWCmdj6/FZO7nR7IGxe/5gKuI7SHBBqV4ClLiKmx8rZhiRd5+1TjhJGqS0Fi2j7Yk1hnsWArd9Ot69cQA9T1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CY5PR12MB6599.namprd12.prod.outlook.com (2603:10b6:930:41::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Sun, 5 Apr
 2026 14:55:33 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9769.018; Sun, 5 Apr 2026
 14:55:33 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 05 Apr 2026 23:55:30 +0900
Message-Id: <DHLB3RO3OSF5.2R7F27U99BKLN@nvidia.com>
Cc: "Gary Guo" <gary@garyguo.net>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/8] rust: io: generalize `Mmio` to arbitrary type
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@kernel.org>
References: <20260323153807.1360705-1-gary@kernel.org>
 <20260323153807.1360705-3-gary@kernel.org>
In-Reply-To: <20260323153807.1360705-3-gary@kernel.org>
X-ClientProxiedBy: TYWP286CA0001.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CY5PR12MB6599:EE_
X-MS-Office365-Filtering-Correlation-Id: 2424f8c6-618a-4561-e007-08de93236345
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	61peu/WeNHwGGwA2dqN6xfp2OZUZef1b+dlfhJU4RJ8m3JiykNcctQcJgYGAH58PQWtQnTi58xK1ubE9jmzhk5tCY/zi0B9+xdjyhIGXCq43nkC5VE0RseA9FXlAsq2oqcIz7cz1u9fmgeEUxozHt6KTKeic2Veh0o3DznCCbUw5FfPtKAyk8rMTxJIDtEplvffrZvd6gNwQw/BM8iryXiPKNSKmsFpvEv3eWuovpqto3rIy2+eGnT93ZUI28OXsJe4uXMEvRT5dq1lMD/ho2DOukPOnOXkWDYoPPWkWzZKmEf2Z197o6NLAkHRidV6rWuqVSciZvZig7fpKIvkcAOebFazRwS6w0PNfHTmKqqllCFOSk2+Xyarn5uu3xTipuk/8Pht8e+rymIwvbUFwRGIhfgy7cxY3KowqjHc4pR9vkxyT6LryxhAVYSOh6iFItYPRaLJ6snkll788ODja3Xelge09c8z0wPVkhuePfOcHl4LtEcfTRscmvUKPTo67wEzN/c56MhBdaMCjowW85ZJCtecz+EANeQlObWQDEnsUVluAJZ37QZScB8quGR8aWjy1h4lJjWMmxwJmmIXi9GGStSy+3HfmDIH9irrXCE2Q58Qzge2NKgaWeeP+ubQ8GUBUkr/n0zxoax0TPslvCOX/cPqueRRerU7Tjpjr8Ym4j/Ngf1wVKoovVc1LbN9CFWlBduTIBF1eqIU2bo1RDKEpp1/kDxwyqJ2sLxn4HF4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3lUVG5xeDJHeEduU2R4Skx3NzNvZGJzV2JuL2cwYldPZk9QZkUrSzlMU2pB?=
 =?utf-8?B?TFh5TVFQWEFKdmxvV3R5bVl6QURWdkVWeHhzZE1Va2Q3b1F5VjVVWXAxTFph?=
 =?utf-8?B?WkVncHhLeXVBRmQrMkFwclE0UlpPOWNabzd6d0dHcGRxZ3FsV2NKTm1EOFAr?=
 =?utf-8?B?V1RXY0YwblVDQ3ZoVzNFV1BDWHJkVEJLemE4ZmlPV3RkV3Z0bWh1SE1NeU9I?=
 =?utf-8?B?WnQ4V0IvdzFNZkZZTVZwTWZtVWRKVE9uVFVRcmh6WW9CUjhWaExNSU43aXFS?=
 =?utf-8?B?SWhRTjlQL1NQKzE0Q2dWYmRXaHEwZXNpQVh2Y0ZXNVphRFJubkMwOHU1S2Qv?=
 =?utf-8?B?Rzh6WUkvOXhMeFBRYTJmVlFsMGdEQjhvZHl4SHp3bVhvSlZTRE5NMWpVaGUv?=
 =?utf-8?B?Qm84QXVlT0h0bjRHbElxMHhSeVdXZTdQMmJWeTlqMFJ1dzdQZWFOMEl4dC9E?=
 =?utf-8?B?OUhDZHZxcjlFR0h1Y3UvcHdndGNtMjVFcnRFOEx6T0F1TlI0cWhnc0pDQU9F?=
 =?utf-8?B?bkFudXhzZk4yRVFOTENmMk5NY1daQTZ2VTBUTlJEN09SczFyVzQ3Y2JnbFJ2?=
 =?utf-8?B?dXNEaG1wb2puaWlqVVpNbTB3SzdzV3JkR055MVBOcmUrS1Z2cTVLWVJMQVR4?=
 =?utf-8?B?M1hpVm5kbUJBdFhGS21rYUlLdlJsUGQyNkhsbzl1ZVlwdG1xYmIzM0dYSG9U?=
 =?utf-8?B?UFdyODZ0TG9DcWgrOVBsbXdCaXlRTndWUnAzMm1GNlVHMTNkakduWFRsVFg3?=
 =?utf-8?B?bVNHM0o0S3dseGpvVExYUStOV2VsK1M2YndnOEw0QjVVcmRLcEFsRDlKNzhI?=
 =?utf-8?B?bGIrQ2lWQ2labmtYOGdDQ0lXN3A0dVVXak1ZeXRtZDZEVVVtcnlhS3JnRHBK?=
 =?utf-8?B?aDdkVjFUdGxtZ3RPdDFlK283cW5NbytUazFwdlZVQ3BYZkhvaUdUTmlISE1R?=
 =?utf-8?B?UmkwTnViOG5DRG1uVHVQdG5FNXhEcE5CSzVxRCswTG1WMm0vdElIUlVlZnBp?=
 =?utf-8?B?M3ZiRXRyRFBIanhxQndoWG1CWTZjVWs0RVQrUlhUZkY5MVdvMWVZY2F3cFpY?=
 =?utf-8?B?NlQ1Z2J0UGJTSWJYRUNvWUZrY3NSSHNUQlhjVndjM2RQSHg5Zno3bElxb2lT?=
 =?utf-8?B?TU9JOGhCUzdlN1RGWUIvc0ZIV05BejN3V29mMm12ZmtXMkNneGY0NVpQRFhX?=
 =?utf-8?B?RDZ5K0hqakIzWmQyY0VKWVNOUitMWStMOG01UWlyUXlNcEFTWUN6eDByY3Nz?=
 =?utf-8?B?NmdxSi82Z1JYMDZtV2JvSnFFTVlYR3kweTdMQ1M1YWtlTk9OM2F0Y2Y5M0pL?=
 =?utf-8?B?VXhsZysrdDIzQ1dtZ1pQV0hQRU1YR1BmMGlkV2VEdW5FT3JoNU9abUhzTVY4?=
 =?utf-8?B?RGdNMWJ3bERwcFJ1NXlyNGk5aUZjNXhPNFZPczJnT1pqYjhIOHQxN2xncHdo?=
 =?utf-8?B?UjJlN1lVYnJ3NzlTYW8rYnFMV0xsSFlGUkMwVi9ZdDZJMnIwNkpuYmxGWkJ6?=
 =?utf-8?B?Uk1uZk0yNUxGYXBpRlk5T2RYbDhuVzN2VFlEbjIwZ3p3Zzlxdms2aVN2eTFw?=
 =?utf-8?B?dHF3bjhrRExOemVCYm9tanpxYlNSYjBXa2RrMHhydFV4ajhnb0dWaUVTcXdQ?=
 =?utf-8?B?SkV0VytvUnBQY2NJNHpKMWZHZmFFTU9POVFWSDdxRWgyWCs5MnRSSndzWk5S?=
 =?utf-8?B?dEFDNmZJM1U0LzlNbU9Xald3Sm5wcWZ4dXh0OWFRVXMzSU84OHZBOWlyR2hK?=
 =?utf-8?B?bGpoMldBVFBMem83UWdJcFNtRGVwakFxRkRyQ3RiV2lJL29aM05vanBuVnFE?=
 =?utf-8?B?eW5hVHZZVlUwM2oyUWRwWWkrSk5uQmh5Mk5mcVB4QXdEczhRU3JNeGpQcXM0?=
 =?utf-8?B?OEkyNWVYY3U2WWJEUW5CZkx4emh5bXcxWG5lOE8vandHQUxlcEFiYXhDVmdk?=
 =?utf-8?B?akIwcWlUUUhhZHgrNWV6cjZhOFJ1TUxROGtURHRSTWxlOFF6RWM5eDFHK20v?=
 =?utf-8?B?UXBCRFpIYllHU3lKeDlUMmQ3d1FvNDZlMjUvZmg3Q2hCWVIrNGF5d2JIMThU?=
 =?utf-8?B?VmxSRkkzNysxZVFZb2RWblUyYjBaNEZ0M3J3bytvVlVyQWVBVmcvQWFodzEy?=
 =?utf-8?B?eUJ1WHlPckZrL09sMzR3N0ROanF1cEJmWGRNVCszSERKYkdkMVVOUFFLTnBt?=
 =?utf-8?B?cFExV3g0Zm13eG9CMjRKcmxrbW5TNUpGcEcrdTRDNjlEQkU3aGNQcVNkS0dZ?=
 =?utf-8?B?YlVtNE5OZGVoZ3F2bWRNVTVJd3BMYWRXeDBOZE81TExIanU0OG5aOG5OVnAw?=
 =?utf-8?B?a09UZkhsZ2Z5eitkdUFyWkxWVFBxc0ZablhSeGE0ZjdjUytCUUl0UEZxUGtx?=
 =?utf-8?Q?OQUqOtWkOql8W+jgb8HXhTi11+Ip/KhMmCxMB3g55KcN0?=
X-MS-Exchange-AntiSpam-MessageData-1: n3oyNgZS1Vburw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2424f8c6-618a-4561-e007-08de93236345
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2026 14:55:33.5216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Cfk9L+sgRz31jxPKA2EfLo5CfNE/C2i5wx+Inh+gAIhRmqYtFgrcYyjwwMZvWReYVFL5bey9H7sVeN6AFPEtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6599

On Tue Mar 24, 2026 at 12:37 AM JST, Gary Guo wrote:
> From: Gary Guo <gary@garyguo.net>
>
> Currently, `io::Mmio` always represent an untyped region of a compile-tim=
e
> known minimum size, which is roughly equivalent to `void __iomem*` (but
> with bound checks). However, it is useful to also be to represent I/O
> memory of a specific type, e.g. `u32 __iomem*` or `struct foo __iomem*`.
>
> Thus, make `Mmio` generic on arbitrary `T`, where `T` is a sized type, or=
 a
> DST that implements `KnownSize`. Similar to the `MmioRaw` change, the
> existing behaviour is preserved in the form of `Mmio<Region<SIZE>>`. This
> change brings the MMIO closer to the DMA coherent allocation types that w=
e
> have, which is already typed.

You probably noticed, but the regular `read8`, `read16` remain available
irrespective of the `T` parameter, allowing the `Mmio` to be accessed
using both the structured type and arbitrary primitives with an offset.
I cannot find a reason to label this as unsound, but it might be
confusing as it makes projection an additional capability on top of the
existing raw I/O methods. This might be worth mentioning in the
documentation, or maybe the primitive accessors should only be made
available to `Io<Region>`?

>
> To be able to implement `IoKnownSize`, add a `MIN_SIZE` constant to
> `KnownSize` trait to represent compile-time known minimum size of a
> specific type.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  rust/kernel/devres.rs      |  2 +-
>  rust/kernel/io.rs          | 63 ++++++++++++++++++++++----------------
>  rust/kernel/io/mem.rs      |  4 +--
>  rust/kernel/io/poll.rs     |  6 ++--
>  rust/kernel/io/register.rs | 19 +++++++-----
>  rust/kernel/pci/io.rs      |  2 +-
>  rust/kernel/ptr.rs         |  7 +++++
>  7 files changed, 64 insertions(+), 39 deletions(-)
>
> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> index 65a4082122af..3e22c63efb98 100644
> --- a/rust/kernel/devres.rs
> +++ b/rust/kernel/devres.rs
> @@ -106,7 +106,7 @@ struct Inner<T> {
>  /// }
>  ///
>  /// impl<const SIZE: usize> Deref for IoMem<SIZE> {
> -///    type Target =3D Mmio<SIZE>;
> +///    type Target =3D Mmio<Region<SIZE>>;
>  ///
>  ///    fn deref(&self) -> &Self::Target {
>  ///         // SAFETY: The memory range stored in `self` has been proper=
ly mapped in `Self::new`.
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index d7f2145fa9b9..5a26b1e7e533 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -44,6 +44,8 @@ pub struct Region<const SIZE: usize =3D 0> {
>  }
> =20
>  impl<const SIZE: usize> KnownSize for Region<SIZE> {
> +    const MIN_SIZE: usize =3D SIZE;
> +
>      #[inline(always)]
>      fn size(p: *const Self) -> usize {
>          (p as *const [u8]).len()
> @@ -169,7 +171,7 @@ pub fn size(&self) -> usize {
>  /// }
>  ///
>  /// impl<const SIZE: usize> Deref for IoMem<SIZE> {
> -///    type Target =3D Mmio<SIZE>;
> +///    type Target =3D Mmio<Region<SIZE>>;
>  ///
>  ///    fn deref(&self) -> &Self::Target {
>  ///         // SAFETY: The memory range stored in `self` has been proper=
ly mapped in `Self::new`.
> @@ -187,7 +189,7 @@ pub fn size(&self) -> usize {
>  /// # }
>  /// ```
>  #[repr(transparent)]
> -pub struct Mmio<const SIZE: usize =3D 0>(MmioRaw<Region<SIZE>>);
> +pub struct Mmio<T: ?Sized>(MmioRaw<T>);
> =20
>  /// Checks whether an access of type `U` at the given `offset`
>  /// is valid within this region.
> @@ -462,9 +464,10 @@ fn write64(&self, value: u64, offset: usize)
>      /// use kernel::io::{
>      ///     Io,
>      ///     Mmio,
> +    ///     Region,
>      /// };
>      ///
> -    /// fn do_reads(io: &Mmio) -> Result {
> +    /// fn do_reads(io: &Mmio<Region<0>>) -> Result {

This can be `&Mmio<Region>`, and probably should be as it is closer to
the original code which also used a size of `0` by default (applies to
the other examples as well).

<snip>
> -impl<const SIZE: usize> Mmio<SIZE> {
> +impl<T: ?Sized + KnownSize> Mmio<T> {
>      /// Converts an `MmioRaw` into an `Mmio` instance, providing the acc=
essors to the MMIO mapping.
>      ///
>      /// # Safety
>      ///
>      /// Callers must ensure that `addr` is the start of a valid I/O mapp=
ed memory region of size
> -    /// `maxsize`.
> -    pub unsafe fn from_raw(raw: &MmioRaw<Region<SIZE>>) -> &Self {
> +    /// `addr.size()`.

That probably shouldn't be fixed by this patch, but there are is `addr`
parameter for this method.
