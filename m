Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010057.outbound.protection.outlook.com [52.101.201.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B6B3793C2;
	Mon, 15 Jun 2026 05:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781501372; cv=fail; b=Tm6agVLZ2nod6W9Vbtqb0D11RfpqUakyRCVyyo5v7Mvbi+Ssgq5xhh5mckyT+Y7IxsqP37xTmFntah7DBl2pHHcjay6SQbhYaX0NsebNopv7IyThFBcwPHATVuQkWEZPXJRHINpZkRQI5MG4wfCwnt9DahQS84IYpnJj0DrIvi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781501372; c=relaxed/simple;
	bh=UQmkMiB+L2prp8bgUDf2jSefobiwuP0sQMnwauRZ4eE=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=hcpq30nx0s68YY9tNMOxOvOCI7rr6zEZzDhjLn4C6a2Bow5o63XlZgoDm1No8iYJ2rVlAUoi5wlJjA043cJUquVxC4o+YTUy1FJh3TVcmvBDN3kguSLNL/gGHekdY/fi3AGZ2ca7e8RBYfMkitZkvVtLWZrogB/zRUaeOvoYLyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=esTtbZFQ; arc=fail smtp.client-ip=52.101.201.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="esTtbZFQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+b8OiLL29E/2hEY2qaqUfp2Am2I3+/dBmRosgos2NsSAv423diW3fQvWfwBk0sd2VSXm8ZFhThsIXf/byC8qIWhV0voya6qgXE9INKUuAA+aqCjMRw2S8i48O858L60wi96ZE7gioJm9LWcewhplJ7mj7AphqXtR23Crn/vg4hxFmvHfnMX7mb3V9PUwYvNaoQa5Y36LZTCU5o7wagEDAU2iEdMOCI0U9IVGHeUlF55aLHkjPJLbzkwj8OUrImlzkz+bRcrlmpkWV1wSzw2FvMz2z/l4JKzMVM+xlIbxNHcg2Mu+mEUQGnWqLZdp3IC9wye32ghfXGULY5RPpNFvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e49TG8bSOkcCjh3RY8jLexbQ8J4wVg1Xijjai1ktfuc=;
 b=rlorGNElh63YkI8KkqQ8ZLV4wNPONTGtC7G3PKCGZhmMjW0aa2E4bQiv0pl1vKObnbkqPqM9TrCqB2h77IFQa4VPpjQKXXZSJhiIjxCSU9Zf+t1/lgd0/zqD6txeht12/uR9oJmcv52Zt9hlSKqi1UD9/lTJf42BrCppUhwCD62E0bu1YpsEbaSa6wpqt0UwQkqHYz/BY9/so1njt9Eu8/VEkjTU28xCPjy7522a4Lm0y7l26+j7sT/XWV0UZwR1c+cR6LqvqKyL9VMoIDuTAebpSKUYZi2ixKJWOjCTw4SHGtFocEs8R0DoYy88gytzeN/LMSuI8IeruIht2UCeYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e49TG8bSOkcCjh3RY8jLexbQ8J4wVg1Xijjai1ktfuc=;
 b=esTtbZFQ4JM4FSuKwqG1LymUkQqJe9vXRoPh0JqA/gI94NCz+wwRjSmy0waWc54lY2YI1BDMs+uG86ylvll81QNYrM+8ZeWUFs6cgSfzrkRRu4s5uOFDBFPxH8WXic5qw3LR/Qtnwxcm9fCd65+Wy26pGxpdMxXxAV378cMHV4rfrCLULvxcZWunwMkmozjMCSmdszoUHSCSgX1JAod5R8Da1ZB56tkv+xEIcE4Bu7T7ynOTte2WZA1AjRAlSy1G/DHDEtUSGCtj1eD61hjshy7CsjY3nCU0DjGe0HMJSHmsH6aDjtcY0fJN7mLLxJYcAPOLIFZSFSI2PnQnpw3M3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ2PR12MB8928.namprd12.prod.outlook.com (2603:10b6:a03:53e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Mon, 15 Jun
 2026 05:29:25 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 05:29:25 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jun 2026 14:29:19 +0900
Message-Id: <DJ9DIY622MHM.3RXBNI25DNAG4@nvidia.com>
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
Subject: Re: [PATCH v4 04/20] rust: io: implement `Io` on reference types
 instead
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Content-Transfer-Encoding: quoted-printable
References: <20260611-io_projection-v4-0-1f7224b02dcb@garyguo.net>
 <20260611-io_projection-v4-4-1f7224b02dcb@garyguo.net>
In-Reply-To: <20260611-io_projection-v4-4-1f7224b02dcb@garyguo.net>
X-ClientProxiedBy: TYCP286CA0249.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::7) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ2PR12MB8928:EE_
X-MS-Office365-Filtering-Correlation-Id: dff503a9-7cbb-434f-dc0d-08deca9f0e83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|7416014|1800799024|376014|366016|4143699003|11063799006|56012099006|5023799004|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	ky0b/Mu7MbIR9zy29dGoCyemdBZ3G6mFzdNG4Zhqq4B73qj93EHypLjtAqoCp5tK7jRUquiYkx9JIhLdc+8GHAcCkWa7BGiUHzcofuEW6kTBcIhhfOwHztBiVfyS1leaARvDDAMtvmTcAr6ZCVE3IyPyxENZqwv41yDC5K0KB1fgvA6YLkNsc1t0RJFUgWbgOQ+v8WxNDr3H+/mRVwGsp5n0n67DAgji2fE7TAKKKjbV/FVnKhGyAfFG8khR7c88IHR71Na1hD+cPyeaeCcbr0PA+psHlYoi13ssVaIEd52UjADds/JumnrDrquKuL6R7adccRWVbPS7+OtWOvHYRUcOnU2Ql9RNWkBJgvOr48fwoIj6pUnI0IMHn7pD71aVCA6QO3HncMXKhkv8z/UoJtxdT51XbmnKMJ+0ACoXun4tfXzymk8cS2h56dUMPClbqfhNBqDpnnspsmNc9HTf9Og/FF4oliAjHaIx+voRqjwkOXUUC+07STTPWVyH3bXF+mPjsKeAn8JwBFCeE2W156gIW3Am56k9ztPp8eenHtap+fwuKCew1rC2qtUdZp1Tttc5L1lyW02YTDMsSL7Ouo0ftV00WydI9qe8rGyGbSCRgXGPtdDRM7ODC6nOIhc5SdAqmseAjeTR/m2XgsRqnsd+rnAakh/C8bfdFIgMKRi1YsP1aZZ4bd3OyOQXrLzf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(7416014)(1800799024)(376014)(366016)(4143699003)(11063799006)(56012099006)(5023799004)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2RvS01zQ3U5YjBYR2UvYjBLMXFmTVBrVzFzMmhOaWtubmhrZW9CUUFxSHQr?=
 =?utf-8?B?aEgweit0TmYxZkUrNFIwRk5scUhkRVZZc0E2b2xLNG5sZWtmcW12VkRpZGlx?=
 =?utf-8?B?anY5WFVycG5SRWlJaEd3WDFvWjh2L1Y2bGZZa3lxR01FUXhKSWwxaHNOYzJa?=
 =?utf-8?B?ejZKVEVQd1NDaWRoc3NKVU0vYTdZMklKenFEc0luNFNzeDVpWWVabE9YOGls?=
 =?utf-8?B?cE5BcnR5N1k0SksrMDdaS3NITFErbVRwVFFLWWFKZldTZTBJU0hheGpmbWhQ?=
 =?utf-8?B?bGxPVDVnejBTYWdnaFNVbFFqRklnd280dmFwQ1BqRHc0cyszWXBhcy94bVJ1?=
 =?utf-8?B?czZoeXVSZ01LQXlLVUxRYk1kS09SaUJvWmNaakliQTFlN1R3VmtPKzJpY1Vh?=
 =?utf-8?B?TGI1V0wvLzVYUTV3ODVRRWYxNXpvN0pUd2tRWGtYem1qVVZnQ1lDWncvZmJu?=
 =?utf-8?B?TTFFUFI1MXUvYm45eDl1aUpkMnd5STlRZ3BNc3N5dDdwWVZLTVljOEZOdlpx?=
 =?utf-8?B?Rk45UkdhcUg1MDM1TzN6Rk5aNGxYY1Z3MVg5aHNJWjB2UGVMUUorUjBnVnc0?=
 =?utf-8?B?NjVlcTBHbXRYV1M2T2RQR0FwY3JFS2ovNGZvekJBUFpublJFRUhKNlorV1U4?=
 =?utf-8?B?MklXd3h1cmx5YWVLWXN0T1hES210aTJCN3ByQjM1TGRTT2JyN0RBQmJTdFhV?=
 =?utf-8?B?emtYLytUaWdveWdTVG5kZEhXS1V0N1pvMVJiSnk0Ykd1VERJblFqaURyOVQx?=
 =?utf-8?B?VjdzZUdWRWFhNkdzb0pTUnZQVk5JUVAyRGlGOFBwYmRZTVVWZ1YzSGUzSGxo?=
 =?utf-8?B?M3dWZ2gycTJSWkR4eHg1ZGpXRzFVNlZWS050RThGcmg1bk1Mc1haR1Y4aWsz?=
 =?utf-8?B?QU1DQ1ZtUHJKYzNxRlpoVkxuemVvTXZLVEIxT2NXd3hQNHlWaUloS0Z6MGpH?=
 =?utf-8?B?WjNZdDhBbVdsTmN5Wjl4ZUpSSVZPK1RwTkNGTGxsT3htVDNmUUpab242bjV4?=
 =?utf-8?B?TlArb0lkK3hYTDY1T2dkOHBDTEVxZGhsSHhibnJaRExhVEJWK3o1UUQwRDdJ?=
 =?utf-8?B?cnAxSGJSSWFOYmJUY1VDTDZIazFIZFkwbFF1WVJGSTFsd0Z1RWxsYzczVERG?=
 =?utf-8?B?NFkvNUNmT1YyWGtkeWgxd3EyVjlVVkdoQmFnU1Jlb3VaaThKVUVqNXhYVk5X?=
 =?utf-8?B?VWpBcUtzd3B1SkVjb1gxQU5hNjkyRmRodWdUYURWVXhPL3FQYnBCdEp0N1Zt?=
 =?utf-8?B?TUNvcVJpR1hEdTdReFBMSTNIaW1DSU1ZZkZqamRod1FEUW0rNEZoYTBETTRu?=
 =?utf-8?B?WnB1ZlZBOVdpUkE0Q2prcGp5NHVSQU9weWNjVU5IL0dBUVZWRGdGTWtuemhp?=
 =?utf-8?B?NTUvNHFEdmRJclVJYW5JOEZUeEFzclFJcnlnZXp0REdJUkJkbW0zM2FrT1kx?=
 =?utf-8?B?V0Y3eGN0TW1DcUFQS1pCSTRjZW9lSFVDSDU5UzNkWE1qQXFETzV1MVVtOFZE?=
 =?utf-8?B?bGRaZ3I3a000aG4xU0lYUmJRMEp0elNVWkJxcnFLNlNUSlZQZHUrblZ5bFhL?=
 =?utf-8?B?SnNBWi9sSHVlcjNLUDdLbXdjQnllUjBnbllENjJhKzE1eXBFS2ZsakNxNzI1?=
 =?utf-8?B?Q0Qrc0o4V2tsQjkyL0grM01PdWZoMXdXK21iSGVxVklSd3E5anhUTXdVcTFy?=
 =?utf-8?B?YktIZUxhMCt2bVEwV0kwVEx0ZHhCRUhTZlcxWm5PcVZ1eXAyNFFXamxjajZS?=
 =?utf-8?B?dDY4TDgwTDY3T0ZTRXZTNUNqVkpleWVObXF2NzhMREwrQ3V5Tm9nYnljUmxu?=
 =?utf-8?B?ZndrZGpJTkYvbEFTRHdEYU9VT2c1bXdOU3BDb1lOcGo1bDF4WjRkTlU1em1r?=
 =?utf-8?B?S2NQb1NoU2drL1hodVRNVXh2ajVWUm92dTZyeHJpcU1xNTNucjZvTlVxQlBZ?=
 =?utf-8?B?MmlaL3F0aW1LMDJhOGVZY2NZZzZqc0I3VjV1M3B6TWw0MkRKb1l4aE9LTWt0?=
 =?utf-8?B?NGdOL2FaNUgwS1AzK0IwTVJNN1FOUURLV29ENEM5ZjdkdGp6UU04Wk1CT1pJ?=
 =?utf-8?B?NDZRQXRyMnBZRUg3TWNQVVpGRFhucGtjVDJCUXpRNHJOVzFYYytQdHJNNSsz?=
 =?utf-8?B?eWJrRXlUcFZTL3M5eERRQ1lUNVJXYmZSQWM4VVcxcW1GbjB6MWRLV3Q3OVht?=
 =?utf-8?B?clkyb29pVjZJZVNzdXkvUGZEQUFINXpIR0dQSmtCbW5jMTJidUJsR1g5RWlE?=
 =?utf-8?B?bkhGdy9NdWZXM0I0M2dlTnNneHlzNXB3Mmh6MXFWQVJkcUcrakg2NitLNDc3?=
 =?utf-8?B?UHF5d0h1MmZvZlpIRzBvZytLZ3dyTjJjUHgwSnlDb0drWVF2YU43R1Bwc016?=
 =?utf-8?Q?+vnhccAE5inV4jXuu2WRrJ81W347nm8apBAD2rfy5Igyf?=
X-MS-Exchange-AntiSpam-MessageData-1: KvW/wL5Wq+Vz6w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dff503a9-7cbb-434f-dc0d-08deca9f0e83
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 05:29:25.0461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dz6G2t8M/3qX9bp0mSyDvF/SgLxPeIXg9VHlnHdAix0puy93jteG1t3+gxA8H0iOaZvtWasaXSEARKJGgIz8ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8928

On Fri Jun 12, 2026 at 1:28 AM JST, Gary Guo wrote:
> Currently, `Io` is implemented on owned I/O objects (e.g. `Bar`). This is
> going to change with I/O projections, as then `Io` need to work both for

nit: s/need/needs.

> owned objects and views of them. Views are themselves reference-like
> (however they obviously cannot be references, because they belong to a
> different address space).
>
> To faciliate the change, change `Io` to be implemented on reference types

typo: facilitate.

> for the owned I/O objects, and make methods take `self` instead of `&self=
`.
> When I/O views are implemented, we can then naturally implement `Io` for
> these objects.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  rust/kernel/io.rs     | 80 +++++++++++++++++++++++++--------------------=
------
>  rust/kernel/pci/io.rs | 12 ++++----
>  2 files changed, 46 insertions(+), 46 deletions(-)
>
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index 38281636b4da..3b478dcf10f9 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -224,7 +224,7 @@ pub trait IoCapable<T> {
>      ///
>      /// - The range `[address..address + size_of::<T>()]` must be within=
 the bounds of `Self`.
>      /// - `address` must be aligned.
> -    unsafe fn io_read(&self, address: usize) -> T;
> +    unsafe fn io_read(self, address: usize) -> T;
> =20
>      /// Performs an I/O write of `value` at `address`.
>      ///
> @@ -232,7 +232,7 @@ pub trait IoCapable<T> {
>      ///
>      /// - The range `[address..address + size_of::<T>()]` must be within=
 the bounds of `Self`.
>      /// - `address` must be aligned.
> -    unsafe fn io_write(&self, value: T, address: usize);
> +    unsafe fn io_write(self, value: T, address: usize);
>  }
> =20
>  /// Describes a given I/O location: its offset, width, and type to conve=
rt the raw value from and
> @@ -299,21 +299,21 @@ fn offset(self) -> usize {
>  ///
>  /// For MMIO regions, all widths (u8, u16, u32, and u64 on 64-bit system=
s) are typically
>  /// supported. For PCI configuration space, u8, u16, and u32 are support=
ed but u64 is not.
> -pub trait Io {
> +pub trait Io: Copy {

This requirement on `Copy` could seem a bit confusing without context -
maybe mention explicitly in `Io`'s doccomment that this type is expected
to be implemented on cheaply copyable handles like references and views?

Regardless,

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
