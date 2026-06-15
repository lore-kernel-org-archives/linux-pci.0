Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010071.outbound.protection.outlook.com [52.101.201.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EE03C06;
	Mon, 15 Jun 2026 04:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781496231; cv=fail; b=cnkwGFrm8BT5sTEtKN325W0tMGn8je+k6W8wa02/nWnbOV4mJovemgv2AAXot/ZMVF84U87RkY/nWcqIcb1E1IOIu3nAVHwyIfuGvC61W2x3xsphThikEx6Y/AryIO2h/rsjUBjz8WD4TarCBaE+raYUDycfJLYT2kqwz5U21B8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781496231; c=relaxed/simple;
	bh=mstqABRgB9ZamQHhKiJlr4OuGWBSeviDNtSnpYApZmI=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=HpR+Q94V6+z3OFG/jaCe2wLJwDAKg64KzXcs+/w4iMrGFc7xLy0mwKKaqviUgkRN338MgzfTolUkZ0JKNVa1SBT0+Hzhwt8AzyhnqsafFzPzaobA1Bl+9drqTcOMPK4qj4rBb4MOEuR+aBWIFyuZzjuabHGEaF/ZjHrc0JIqNrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AjsZ+9m9; arc=fail smtp.client-ip=52.101.201.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AjsZ+9m9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mbnCiBHFu9TpGbHy6jTv0wZwiTqYby9/2bL770KEgsCLl9tj9sNTM+1c9iLghhFEkuIgbg72q4uzEMkUCDlOpPitLdwNKzwZJnNH/SuRl40MQeiVOwo+iJ8sk+kA+DjVTuFMes5txWNldnmmrRM4JlMzv+GIDgvm2wjAX8Vzo3hX2Vaguf69GM1HJs0N8MMwSwnEhGjhrw5GimIJAyNmhp+NuvIhoFWUTepuGu3XE5OOL6TF8jnmKMO/KyRxE6yN2E2sl0rcqJmyEta7Ip57wsp/LNoYFg8ugX+qv18cFjoLoWnfHG1IMgRwr51hUSgaRVTzHyeMMzPrGZjcr7u9mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOO0Zi5rzlP2W4F1J7myCp3XlN0MuW3mfaRZagFV5m8=;
 b=Klgm0kNKWVIqkLFMUKqDKe9w3tANd7049udoy9paU/RmUKO+lWDdCJ9Loejf8wM66i1ePiP1P3685KF7yiag77dyGMBz7KaZzLuSKC8eNYuSxC1ZN6NObDuIaHG+svoE0sa5p+JYE24n5I9RfWgWMM1Jvtv2HUPO6cjuQSrpfs/xchOZOFTIBtGhqXlIdk8yIFlLfwny7GkSTtQm8C6eI09QzS7AYyF1Ei19oTRTnAnn3fqlPDjuiRv1C8Dc9VTwULB5dzpHCggAWGlEmGUxedvkMV05OnNJSWKWdNZ1RMTmgmAL6sQflopTF03hkosdt+CqmFxzVqCeF1BXqz0dJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOO0Zi5rzlP2W4F1J7myCp3XlN0MuW3mfaRZagFV5m8=;
 b=AjsZ+9m95D6it89xoQ0HoTuu6fL3w/XVnQ7tGkxN0TWr3QhW3hVjZcpfgqQDwEH9uSOH+DN+wIcDrVLCwlcBrswbrveb8rYlmx/1dg3+NvoPCIe0ds6JTNH6TpZQhDcqj5dYVB2PDMoOx/21GA1MGTOHli1KWGva3cpZJUvUkPmO0KjrwJwdTaqv3g85XpFRWLKKuqH1tejG9De1/+UMRg54BHhSgB0SFAzGBghmlxnLlXgRYv1WM0fGF35RPyhBVOy9yBmKLJV6dP//SvbwLt0Bi7EV3DHnyVyRxNGIVox3qbsd8q0H7izgee0cznaQjCdNE7GbivDtLGqflbwpYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN6PR12MB8469.namprd12.prod.outlook.com (2603:10b6:208:46e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 04:03:45 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 04:03:45 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jun 2026 13:03:36 +0900
Message-Id: <DJ9BPBO51J9U.FQYCSB4SSC8Z@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
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
From: "Alexandre Courbot" <acourbot@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260611-io_projection-v4-0-1f7224b02dcb@garyguo.net>
 <20260611-io_projection-v4-1-1f7224b02dcb@garyguo.net>
In-Reply-To: <20260611-io_projection-v4-1-1f7224b02dcb@garyguo.net>
X-ClientProxiedBy: OSTP286CA0044.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:224::10) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN6PR12MB8469:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a05603d-dbdb-4489-cb91-08deca931841
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|10070799003|1800799024|366016|6133799003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	N+W+NZbyrlW0Y2Vr/TcQpNl0Fgws6J7fjYxjoTIOMXG/1s8dn4gz+CTufAasefBuYmXmYIE4H7u3bbBFCRBUtTxAN5E9LttlGGJDftTr5v5g0kSiJeMXwJjkskoLVlA2VqiI/QtQoaaft/aoqTkxuB+NfSkBefIaBcoxsMCE6/YGsZL3wPG2lShmDu6amCIO0q0j0gWRZw4qZq3KY7BJqYM3f4jmZeaZrMcvHYqlDGtEozx88NzqaNwg9om71WFgLRAX8/nbyEFv7a8zj8uhVfC6JpQtsbX27uk8q0lbPLw/Aye5rg77z0jbyUCosdz6F25OD0Iz/A4DeHa4YPJ0j0/F+w8RT5iW/GzZW+KeA6UKfm5H7wUXWh3og5/I4VpI9woHHvYpk4kVxfwLsNvQ262SCe1EK26n4raz1HCpWPWvpJ5Dzf8duHV+h0pDKfgwdiN9kHQmiDW0eYgfzA8KZMN4E4gZGHLzI04KTi3tNfFixbU5V8Sa1KnhvuaCAN0IStuDzKQ4rSKF1PlqXyoiV4gMZb7NLawaNMTH6IMWbphGYhJ+IL3nAOrsi6t2ZVs3MCKUkXxnE6fOeZDJOmakgnATbgxCzRm45PxP9H80wgMBW3SNDsw124u0QD5t2Nu5c8ufR1lffgvuRtMW4T9XWu0xsyR85R8Fw25xhH6nWK2vYHcfdfR/gpG9j60UDtSj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(10070799003)(1800799024)(366016)(6133799003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1pSbTZFNnB6eGsyblliRkJXVSsvL0toTXRzalZzSUVJSXhNTXFYZHUwaWlm?=
 =?utf-8?B?WFR6VG9LeFpHZGovc3pQT0pKVDRnYkwwZUkxdnZVb3lyWFczNzc2MUVmL0Nk?=
 =?utf-8?B?ek9ycnZrcUE4aXBwaGdLM0pEbVI3a2pRKzl5djBnODRZVERjVHdBRVBhVTQ3?=
 =?utf-8?B?RzkrblJWQVl4RG9rbTJwUS9ENVZ1VDVIcjRoUmNHRUVRWnZkVjVvS2I3YVNh?=
 =?utf-8?B?dVRvNDY5YnV6VlFzeGtKWUFENmNiNXVadHVQa0pCN2ZLdTJPaFdtNU44UTYz?=
 =?utf-8?B?ZEJ4WHgxZWlUSmFieVc4TjB0NHh1dC9LNHJtMUZsSnNmS1lKdEZCSEIvd1RJ?=
 =?utf-8?B?OHZyRGIrRmRQZHEvbi8rUDNUQWJ1WC9RK0tPQzdWdWFQSTd5Q2puelMxRXBr?=
 =?utf-8?B?dHovVC9TN0tWMENOc0NmUm0rNVdrcTl0djlvbkFzeVJ2Ykw3d0UxbXRrRlM3?=
 =?utf-8?B?RENUcmQrajlUblRISVhXTUhWSWdtWFpHVDFQdGhkdkU2OGdINWx6MEVBK2FK?=
 =?utf-8?B?UlZ0bXFyRzE0WmxuWVpIRXREM0ZOcmlzd0pud05BSTJYckJ0RHIraldFWFFU?=
 =?utf-8?B?amdNMmNkRGtXdGkwMkhHMExOSEhRNzdUVURqd04xU1ZvbW42eWp0L0crVnUy?=
 =?utf-8?B?T3FqME5OUCtYMkFCT2tsMlhHQzFGN1lWRmdoNC85NEtSWGxGaUppcnhuVmgy?=
 =?utf-8?B?OE9rT3Rtc2VNcGk2dUZzU2swNWFFRFdaQTZZVkFIZU9wWTgvMit5SU1RWWFZ?=
 =?utf-8?B?bHNZUFBvY2cwRDFBbTRWakJ0NitZdVMwdUpGZkpUZ3JueWR2SDhTY2Q4d2FZ?=
 =?utf-8?B?OEFMNEd1MEo0aFVRRk55RkRtM0JnK1Z2ZXd6NC9qeGVKYzd5WFkyQXZwb05o?=
 =?utf-8?B?QmJiYnplWlh6RVZFUkZYYnJ3ZXpvSWM5WDdPaG1rQkQ2cW5aQ05CbnJwQUR2?=
 =?utf-8?B?cUlod0VIaUhmOHd3Tks0Rm81SGk3bmd0MWJDdmljZy8vY0Y2YTFpRmpNcmk3?=
 =?utf-8?B?Slh5clNNdWxSSjZjQ3NTMHBuWXFRZWZCMnEwcHJ1RjBNOVBCRVc1WnhTZU1F?=
 =?utf-8?B?ZVh0N0lLSlZ3N2dWejdXMTRUeWhWalczOW5Kc2wwR1N5b0s2YU5tRldNQnpX?=
 =?utf-8?B?MmRqdE9mWCt3V0NKQmNQSUo1MVF5dytIVFR1eERDcjdlc1BwQTNzU1BWN2Iz?=
 =?utf-8?B?T1BPZ05qOENiOFhON08wNWxUeDE5cDRScWhpQkxtNytMWllBcDF5b21kQ2NV?=
 =?utf-8?B?bzAybTQybC9lbHhISjhSWGJxQXV6c3AwNkxJeVpidzdES09ORU95VFRPOExi?=
 =?utf-8?B?cWtXenY1bkV2Vmc0eWFUVGVoQnpwNzJBTUs4VTdVdTM3VE1uS3ZSUlZQWTBl?=
 =?utf-8?B?Z0VRNUpqS2Nld1FJaTdFSkxnNWpWTVhmMzRyV3JEUlowMlFhSEtpSXR2QlFl?=
 =?utf-8?B?bVZXdHlRSFBNaW1aNFlJMVErRFhOWUJ1TzByaXV1ZWtlVXZmQk14K2paQWtl?=
 =?utf-8?B?RW9za3MrSVB3WFpabE92V1RRYWwvczBYSkVkUFdpd2h5ZUlUMGJFbEF0U0Fn?=
 =?utf-8?B?MVVoOXVKdmdYTFJzS3Rkb2FhRXBHVzY0YnNGVlBIMGJSSTBPdStoVGVWMDdR?=
 =?utf-8?B?OWszZ1J0ak9ubWhnSjZPVjJYT1JTb1Npb3pwSC8vLzBRdFpEVFFEWkFBS0F2?=
 =?utf-8?B?aUJOMHZFbmhYMS9kY20xdXMvdCt6Y1pmaS9DSnp6TGZPUFYzdk1NMlF6V2Jw?=
 =?utf-8?B?NUJxaDZyd3pYM00yamNqZEpGZTB5NzJ6KzlYc2pVVkxLbXRyOEdRd1BxL1JY?=
 =?utf-8?B?WFlMUUovWnFZTnYra0s4eW1DL3FDRWVxNmJaWkVXRUFobGR5d05wT0pUdGpr?=
 =?utf-8?B?R1c3UDFMbGV3cGt6eGlNc1pBSEh2aElQNEFNK1EyU2VReStyTGZycVJEQWdu?=
 =?utf-8?B?SWtMU1kyZFRXR2lZVWF5a1V1LzNHYWY1VGs1YitFM2doRHU3L0E1cjhTT3o0?=
 =?utf-8?B?VllMQWlmZkp0VWVYUGZZNGxjWE43a1ZvRTh2ZEhVRjdlbU1rdUV4YlZJNnhY?=
 =?utf-8?B?Z0pscDcyTDhzaXU1LzZ6YytIWU13ZGhraGxJYzhYRjQrdVRXaG5STEdFMXpv?=
 =?utf-8?B?WVZIeGxQdVY5eUpOdUo0N1VxVk1UekxxVVRvK0NPbHJPY0ZmOFdqQi9SbVBZ?=
 =?utf-8?B?YWoycTJxNFYzM2tZVlBpZUlOT2QxTVk5UTJuVGR1MnQvZjY4a0xhaUxCUG5z?=
 =?utf-8?B?Tm1LWTdpV0ZRSXVUTklIM05lcEYvY1pDYm5vUlNnUzRMVklUWHpKOGhFQ2cw?=
 =?utf-8?B?NERRU2pmR29LK3VEdWsxL0pHS1U4WTNVeWJ6SC85ZElhdjNHNUthTFVIaTlG?=
 =?utf-8?Q?x1oD3AtQnhQeZ3ML0kW953U6vUwRsVZdAXlYw3cOMMFOy?=
X-MS-Exchange-AntiSpam-MessageData-1: mxK2u24GlJPFWA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a05603d-dbdb-4489-cb91-08deca931841
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 04:03:45.3540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iksHR+jeTw3vj7KBJBtDdzfRnmiwl4EP54TzrqhR5HEcMKXjY9qzmpUdKHrpZPPT4srT53/9PZ3++KAuiAEN+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8469

On Fri Jun 12, 2026 at 1:28 AM JST, Gary Guo wrote:
> Currently many I/O related structs carry a `SIZE` parameter to denote the
> minimum size of the I/O region, while they also carry a field indicating
> the actual size. Proliferation of the pattern creates a lot of duplicated
> code, and makes it hard to create typed views of I/O.
>
> Introduce a `Region` type that carries the `SIZE` parameter. It is a
> wrapper of `[u8]`, which makes it dynamically sized with a metadata of
> `usize`. This way, pointers to `Region` naturally carry size information.
> This type is required to be 4-byte aligned.
>
> Expose the minimum size information via `MIN_SIZE` constant of the
> `KnownSize` trait. Similarly, expose the minimum alignment information vi=
a
> `KnownSize::MIN_ALIGN`.
>
> With these changes, it is possible to add an associated type to `Io` trai=
t
> to represent the type of I/O region. For untyped regions, this is the new=
ly
> added `Region` type. Remove `IoKnownSize` as it is no longer necessary. U=
se
> the same mechanism to indicate minimum size of PCI config spaces.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  rust/kernel/devres.rs |   6 +--
>  rust/kernel/io.rs     | 130 +++++++++++++++++++++++++++++++++-----------=
------
>  rust/kernel/lib.rs    |   3 ++
>  rust/kernel/pci.rs    |   1 -
>  rust/kernel/pci/io.rs |  40 +++++++---------
>  rust/kernel/ptr.rs    |  12 +++++
>  6 files changed, 118 insertions(+), 74 deletions(-)
>
> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> index 11ce500e9b76..ed30ccc6e68e 100644
> --- a/rust/kernel/devres.rs
> +++ b/rust/kernel/devres.rs
> @@ -68,7 +68,6 @@ struct Inner<T> {
>  ///     devres::Devres,
>  ///     io::{
>  ///         Io,
> -///         IoKnownSize,
>  ///         Mmio,
>  ///         MmioRaw,
>  ///         PhysAddr, //
> @@ -297,10 +296,7 @@ pub fn device(&self) -> &Device {
>      /// use kernel::{
>      ///     device::Core,
>      ///     devres::Devres,
> -    ///     io::{
> -    ///         Io,
> -    ///         IoKnownSize, //
> -    ///     },
> +    ///     io::Io,
>      ///     pci, //
>      /// };
>      ///
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index fcc7678fd9e3..bef571dad6eb 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -6,7 +6,11 @@
> =20
>  use crate::{
>      bindings,
> -    prelude::*, //
> +    prelude::*,
> +    ptr::{
> +        Alignment,
> +        KnownSize, //
> +    }, //
>  };
> =20
>  pub mod mem;
> @@ -31,6 +35,58 @@
>  /// `CONFIG_PHYS_ADDR_T_64BIT`, and it can be a u64 even on 32-bit archi=
tectures.
>  pub type ResourceSize =3D bindings::resource_size_t;
> =20
> +/// Untyped I/O region.
> +///
> +/// This type can be used when an I/O region without known type informat=
ion has a compile-time known
> +/// minimum size (and a runtime known actual size).
> +///
> +/// This must be 4-byte aligned.
> +///
> +/// # Invariants
> +///
> +/// Size of the region is at least as large as the `SIZE` generic parame=
ter.

I noticed that patch 13 adds the "size must be multiple of 4" invariant.
The doccomment for `ptr_from_raw_parts_mut` says that "size should be
4-bytes aligned" though, which sounds like the same to me. So should
that second invariant be introduced in this patch instead of patch 13?

> +#[repr(C, align(4))]
> +pub struct Region<const SIZE: usize =3D 0> {
> +    inner: [u8],
> +}
> +
> +impl<const SIZE: usize> Region<SIZE> {
> +    /// Create a raw mutable pointer from given base address and size.
> +    ///
> +    /// `size` should be at least as large as the minimum size `SIZE`, a=
nd `base` and `size` should
> +    /// be 4-byte aligned to uphold the type invariant.

s/should/must? I guess we are running into all sort of issues if we
create regions which runtime size is smaller than the compile-time one,
and this is an invariant of `Region` itself.

Maybe this method should even be made `unsafe` for this reason? The
caller will need to write a `SAFETY` comment before dereferencing the
pointer, but IIUC this comment is bound to cover the pointer invariants,
not necessarily those of `Region`. Making the method `unsafe` would
force the user to cover them here.

> +    ///
> +    /// Just like other methods on raw pointers, it is not unsafe to cre=
ate a raw pointer
> +    /// that does not uphold the type invariants. However such pointers =
are not valid.
> +    #[inline]
> +    pub fn ptr_from_raw_parts_mut(base: *mut u8, size: usize) -> *mut Se=
lf {
> +        core::ptr::slice_from_raw_parts_mut(base, size) as *mut Region<S=
IZE>
> +    }
> +
> +    /// Create a raw mutable pointer from given base address and size.
> +    ///
> +    /// The alignment of `base` is checked, and `size` is checked agains=
t the minimum size specified
> +    /// via const generics.
> +    #[inline]
> +    pub fn ptr_try_from_raw_parts_mut(base: *mut u8, size: usize) -> Res=
ult<*mut Self> {
> +        if size < SIZE || base.align_offset(4) !=3D 0 || !size.is_multip=
le_of(4) {
> +            return Err(EINVAL);
> +        }
> +
> +        Ok(Self::ptr_from_raw_parts_mut(base, size))
> +    }
> +}
> +
> +impl<const SIZE: usize> KnownSize for Region<SIZE> {
> +    const MIN_SIZE: usize =3D SIZE;
> +    const MIN_ALIGN: Alignment =3D Alignment::new::<4>();
> +
> +    #[inline(always)]
> +    fn size(p: *const Self) -> usize {
> +        (p as *const [u8]).len()
> +    }
> +}
> +
>  /// Raw representation of an MMIO region.
>  ///
>  /// By itself, the existence of an instance of this structure does not p=
rovide any guarantees that
> @@ -85,7 +141,6 @@ pub fn maxsize(&self) -> usize {
>  ///     ffi::c_void,
>  ///     io::{
>  ///         Io,
> -///         IoKnownSize,
>  ///         Mmio,
>  ///         MmioRaw,
>  ///         PhysAddr,
> @@ -241,12 +296,25 @@ fn offset(self) -> usize {
>  /// For MMIO regions, all widths (u8, u16, u32, and u64 on 64-bit system=
s) are typically
>  /// supported. For PCI configuration space, u8, u16, and u32 are support=
ed but u64 is not.
>  pub trait Io {
> +    /// Type of this I/O region. For untyped regions, [`Region`] can be =
used.
> +    type Target: ?Sized + KnownSize;
> +
>      /// Returns the base address of this mapping.
>      fn addr(&self) -> usize;
> =20
>      /// Returns the maximum size of this mapping.
>      fn maxsize(&self) -> usize;
> =20
> +    /// Returns the absolute I/O address for a given `offset`,
> +    /// performing compile-time bound checks.

nit: this doccomment could be a one liner.
