Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010017.outbound.protection.outlook.com [52.101.61.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684D53ED10F;
	Tue, 16 Jun 2026 06:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781591705; cv=fail; b=kR58B+0As5IeWP2RdfnZz7Az+pqdErdyfMXoNkpROCwwh0JfqotDufXmuNvj91gxY7JeiEmi4giFdWPEBxpHpVZpqFoAccowQH+5mDA9XGf3LVzBfFEWazTDBhHk1Ayx2SIItyYJECyucBNJ9gYwhRH47czdNuXz1dA++M+7oKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781591705; c=relaxed/simple;
	bh=rnWdHblzgU9wDpHvv1kzeBM+l6qQ2LKROs12Du0wFk8=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=o6WrBf6BP4F+Tlm038/ShAcoNcIC4NJIjHl5pQvEmV3e5HaWqX51RYNyt9ZIJCwU7NJ7bakEhoE1///+zh9DTb61y7jOVnrh284GekDjmm6O5hZo0PfHW2k+olH7CGg54QkNzANV0d671sh4o9vaCW9OIrW7fcHa08mWwYuSAq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GNBzbOc1; arc=fail smtp.client-ip=52.101.61.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GNBzbOc1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZKnBecNIsJztmqMrnRPESLUeq+N5/0L3y2VA8a+xGzW77eXCW+4NfW/rECmKNqPWEgQtmkcmGXn8gd7mqQB3vgijHmx9kaL5Q8Vg52RbnM9H1VmTc8MDQFTF6AqSUWSsm7EiydaCQAYc5XHnWmkkwk0GUcvjazAzjP7wWr88pcqUo7zjO8Ivp82E7CxAIoFBlQJ5To6wnf3koVtBqG0mO+Tc/CNR0DjgPAc8LqdbJkvTZvq7fN5cnTbzOSaKJhAla4PX6ebKfsxABQcSmuJ144PeZGsTK9asnLdNPV7Det4wLDEXvANjcDfKH7FGcUOfktrZQHM4LrYClWSvwB/uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3AFRB2LfgaP9xxFMvysIIUUX5TUIefyeJeA50J1hN0=;
 b=Vgy0xwU2o7BXWRJUEtEex1P/uWouNzKJDrVLRRm4RKTPGGoAyPiJM2qUIh3T7I4kUDbp7ozYx5WIuaQ55cANKxK1ulnHgS4IbY9axCPGhnWODIJaAtxEUtJSbleTGi5GHIOyKxuQjhXbn6J+Dm7h2T+dSSFOdl8VdJSxwFvnPN+fiabEvYKDN+E8OHVQToiicePS9dBSWzUfn807ciP0TYmz7nd1cu+AbwKqvI3+Uz8i38popStO9qFdK2T5nrr0XTbVqv6q4qljZSZuPyPMMvTtTzBq5EAmA5ILdBhvuAaM9cOOrSuNPmszkxjcQBJpFD/f9Btsz3RO6sKxlgXSJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3AFRB2LfgaP9xxFMvysIIUUX5TUIefyeJeA50J1hN0=;
 b=GNBzbOc1vKYAvhc9rHQNWSAvdIkCaiNdGaFnyCHajSn4b+3w5EmlX5bNM5STVydSahwqdPsxSIGVuqtCS/elR2TS+2+1MXXvR2PvOhg/T6jm3F7TDQ8Xik9WWeRTJ/hxDyjT6QNfnauhF9IvpuImuVfWecZ6fscrvVXOX7nZEoUyx/105YxTEvPgpMjTQTEUPyvH0qB1q6BLn67Lif00zzX2rUqQelBzl4vu3n+N1YuY6LKgxML6riUKayeOiW0XyiepewLmVFKJy7hBOmntP1BtXGWf80egB6w3ZkRivnyyxRnomI9qbT6rTw0gaWQheRd/MRFLWKrZF6NNjy/J7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW6PR12MB8897.namprd12.prod.outlook.com (2603:10b6:303:24a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 06:34:57 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 06:34:56 +0000
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jun 2026 15:34:52 +0900
Message-Id: <DJA9JOVL3WF2.DF0M3HNG1OGF@nvidia.com>
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
Content-Transfer-Encoding: quoted-printable
References: <20260611-io_projection-v4-0-1f7224b02dcb@garyguo.net>
 <20260611-io_projection-v4-8-1f7224b02dcb@garyguo.net>
In-Reply-To: <20260611-io_projection-v4-8-1f7224b02dcb@garyguo.net>
X-ClientProxiedBy: OS0PR01CA0037.jpnprd01.prod.outlook.com
 (2603:1096:604:98::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW6PR12MB8897:EE_
X-MS-Office365-Filtering-Correlation-Id: b8d971ad-d3fd-48db-5ed4-08decb71618e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|23010399003|3023799007|22082099003|18002099003|4143699003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	bt2dbQFxarO/VBmgwRJoMU6zw6JTY8DefE8TKCMTh5ELL0b1C4SPA7QYIVVI1YYkiev5+cfI0QknUMagwrxoUed5dgYXoEAybgcx62jyuzMOK0xvffFwXqzEIeuZeRBAGaMU3Ll9N/XgD6pi6PC51uiacalEKQvJ0MeTZU0ZiCdR6FpBhDlf/ytWdcppKMA8Py2wuFT58SWeD+rOVCGIDpKW+4v78JJj5CHQC431qTSth04ida6RYe/OVE0Xv1+Yfe3vDoQKcLNCdoM3KidbWg990HHmsl/LjqFmpGYr5a+UEjsr3S61e6Ho2+j5MG3KOZf5Q8W0KBJJXzxtxEx6LH4xswz08GNKdg0p4e6vh4XQ+W6S0u52WfREHpO/8RmW78kdJVLUKWQmEwVJqgzSH1fP0DQJuJY2FOv9LD/hOYHTb6D3uDLzvyGazTw+nvC4NqoNLjl2EMpSNbK5dvF87TYCbEnOXk7PgBVNmgfJ3HR/X1s8omCkrWEJcrQEqzmGk0nvxsrxuqOIVF+KdBPWcfGYFCK4yeA8KBsQfsnj2V/PtjH46MYrejwwVdUE9m0FE+KdRSc9bybgfW33Ue+u9XbpwxOLRyBvlzSIrMRb0/m3JKSdsEhZyE18/ubKn3VNDAqQLfewgcSQ659SfmkG2dpg/O7gWX+uxwifhLKpt3lL4jSuqEo0Foq1ycAr4Loh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(23010399003)(3023799007)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c25CeE1hVTRUaklaWW5SUjMzNUo2S2YxcG0rQVlaNW1mQUNQTlpSd05GaGMr?=
 =?utf-8?B?N21ZK09qMGlzVHoyRFBubDlZV285N2lTU1VoaWlBbVE3akhSQUdWY1RlVmw3?=
 =?utf-8?B?TVlGbVlHUERlalBXczBsNVovQ1lFc0ZWN2NHdkVyYTh2bmI4YkdoKzRQd0Ru?=
 =?utf-8?B?ckd5UjNJTXBLMEVmMTYxck1vZjlhMENxbnRwZ09veFpxUWR3QUhNblFnSW50?=
 =?utf-8?B?SU5HcDRUU0hJMkZ2bFZITDRROUpBSmJ4dnRGajVneE1zMjJicFBPUm81SlZx?=
 =?utf-8?B?QTM1dVkxeERYTyt4dHhqLzJsWXBSV0c2UXEyZGdOUFRFU2lxclU1Ry8raWcy?=
 =?utf-8?B?eUV4ZWlrd3NjZUhCNktHWG5wSTRxQTVkOFVPMDhNaWprTEV0WjF5US93dTFN?=
 =?utf-8?B?UG5zSkV1SzIwNk5CU2wxM1V1ZmQ3RmJzWEEweEppcUY2ZHM0dS9RUkJwRjNi?=
 =?utf-8?B?UnRRRUlUWXVQZDl5RU1pUWdXa0ZYOCs4N2pGa3Vyc0l0dUtrd0IxTzdVRTVu?=
 =?utf-8?B?Vmh5QVZ4bkNESWFmTzFOT3Q1MFJNQkFrVnJHS21odWRvMi9WK0w4SUJ4ZklW?=
 =?utf-8?B?LzcvUzNsQXl2K2orTTJ3TW9nYndPQjdpa0hvV2lmUi9rcVZpTE15MlZtMmNl?=
 =?utf-8?B?V1JmNkpyM281blplQUpTemk3c0lJTG1BL3ZpeVR1UUtaZHFDZGdvZWdDSHBO?=
 =?utf-8?B?QnZ5bDZDQ0J1MUxqaU52bS9HRG14cGZSaUdXa2xTcE9UZlU2SC85aGNldkNM?=
 =?utf-8?B?MnVya0tSYXVZQ24rNlJQOUg5czhvTVp2Y2pIbWF3OUdHdFBGRURYczF5MUxJ?=
 =?utf-8?B?QmtsVjZJOGVhcmhDeFpmcWw0N24za0t0K1hkR1ZjdnQ5cG9ybHIySTcxRDFz?=
 =?utf-8?B?eWNjQ1ByWkwrTHFIVWNwWUFONkg0NkhqbG1iU0pDanBsVGpHV3ovQzFSRzBX?=
 =?utf-8?B?TkpGSWJZK0t3MkdLNUVmLzRnNzk2UU9JemIxV1NFd3FuQ0dnWk5zcVU2eWdv?=
 =?utf-8?B?WE52WjRBRHp6OEZkd0pSS2g4bHIrWkRSeG5aN0tQRDRDT2c1Z0w3RjYzblJO?=
 =?utf-8?B?aGZWRlBHVlhYSjQvN3JuRnNaVGQ1bFRJYXQxMFF3SE9CVXFNQUZQaENNS2dV?=
 =?utf-8?B?WHdrd2xiZGxWaFpLTHFDc2lYZU5BSkJNaVZZcUtZcStDdy93N3JsanBJVDR1?=
 =?utf-8?B?YS8vSm1IZWtsZTZLWHNJN2dZM3lYQzVRK1c1OTVPWmFpcHlPVFVCbUo0b3lF?=
 =?utf-8?B?ZjlkaW9ueXFvUFNrdGVKS1NXdDhpVmU3Z2RHNHlvQk9Da2hZallTT0h4YnFS?=
 =?utf-8?B?TTNtRnNsUmpLZkt4R2Y3RW84eEhvU3FOWWtJRU5Hc3lVQnlCQ01JME5DcU9z?=
 =?utf-8?B?VGhBSHkyUlkvMjlDanlCNFdyV3NObVg3MnZJQzBVdE5EYzEraVNnN2kvUXhu?=
 =?utf-8?B?ZzhscHBUMTlnN2lVNkN4YXZPZ01sMGVzQkhFaElneVh6bDNNVzlzbEJINmQx?=
 =?utf-8?B?dzBRUHVFdXZxbldiTUhKQk5RRllUcjRtYnl4dDVLbXVmSGluNUNDZitJamJW?=
 =?utf-8?B?dktBeWVvRzZscGllbDNISlVVd1B3RHY2WFgrNmp5cG11bXpZOEhJNGhrK2kr?=
 =?utf-8?B?eklpQXRrMUhadjhZRGJzbEJnUzRpNFBGNVBLajZBVkhQRzBaT1RvQTZlSEJZ?=
 =?utf-8?B?bWlSK01FTzdka0h0bmUxY2FkcEtPSGdkTHNoODYxZWFVVjNlR0oyQk5vSDg2?=
 =?utf-8?B?STVCWG1OYzFpYzdtRmUxRHRkb1djMlowNHMwLzFZSDlNTDRlUFVtKzdDcE1Q?=
 =?utf-8?B?azVQNjMwa2pnNXRic3RiYzJGQWRoQUtUWitKTlI3dXlQeG9WZkZhcGg2ZGZI?=
 =?utf-8?B?ZEg5ZXRuQ1Jjd3FtZ2JmY04wTzdMV1RxVEZjdCsrWklHZ2NuWnFubDRMWE5Y?=
 =?utf-8?B?NEoxWGpHbncwOHIzbXF5VDVZaVA2eXg2NWtyTmJ6eDNFMWxZTWRDYThqanFo?=
 =?utf-8?B?NU93Rm5pNTNvQ1ZlV3lIRkpEbkdGV1JPUGJOT0ZsSTNJZDVxTDZ1YjNQdWVn?=
 =?utf-8?B?TGVJZ1dXNDRhYy9kMVZEdC9PenJNdzh6YjIyNVlTV2NmOGpMcUxQbkNWSDJz?=
 =?utf-8?B?VS94eWM3S1FrMUV5cTFtaDFQeWdlcUFCUE5kV2FHTU41ZVVkQm1MR0dCTm9R?=
 =?utf-8?B?YXpUczUvVFd6VUNyMW9tcExVMTZnV2prTEJDNUhDYUhUQmw5QnV1K0NsRHVs?=
 =?utf-8?B?Y2htL0xXL3U3ellKd0hZaWZldFdST241RzZhZzV0bFZYWnBKbW5vdGFNK2dT?=
 =?utf-8?B?OWJMa3kzaEo1SGw2SHpLdjhDeXlSSHdpeVNXTXZ2S1FOOHdHL2Z1dTBrc2Za?=
 =?utf-8?Q?S+yVqHvQ5eEGSUOaJP9PcsMaeI5VCe3QExt35ITs22F/7?=
X-MS-Exchange-AntiSpam-MessageData-1: FUqdu6PkVSmOyQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d971ad-d3fd-48db-5ed4-08decb71618e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 06:34:56.5630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u9o4Pq/4ZYxb49mKcyyBeRX1pOnrBU3czGyHOxTIIn0opT2PUs5R+q1O3n6XUFrPlL6OA6Sj9Kl8KPjZ4iZwmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8897

On Fri Jun 12, 2026 at 1:28 AM JST, Gary Guo wrote:
> In order to support I/O projection, we are splitting I/O types into two
> categories: owned objects and views. Owned objects have a specific type
> that is related to setting up and tearing down, while views can have thei=
r
> type changed with I/O projection.
>
> Things like `IoMem` or `Bar` are owned objects, which requires setting up
> mapping and cleaning up on drop. On the other side, `ConfigSpace` is real=
ly
> just a view, as the resource is associated with the `pci::Device`.
>
> Remove the `ConfigSpaceKind` bound on `ConfigSpace` and make it a generic
> view. This means that `ConfigSpace` object now represents a subregion and
> therefore encodes offset (as address of pointers) and size (as metadata o=
f
> pointers) itself. The full region case is still supported with offset 0 a=
nd
> size of `cfg_size`.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  rust/kernel/pci/io.rs | 64 +++++++++++++++++++++++++++++----------------=
------
>  1 file changed, 36 insertions(+), 28 deletions(-)
>
> diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
> index e0acb62f58a2..89f4bb483a7f 100644
> --- a/rust/kernel/pci/io.rs
> +++ b/rust/kernel/pci/io.rs
> @@ -18,7 +18,6 @@
>      ptr::KnownSize, //
>  };
>  use core::{
> -    marker::PhantomData,
>      ops::Deref, //
>  };
> =20
> @@ -53,33 +52,42 @@ pub const fn into_raw(self) -> usize {
>  /// Alias for extended (4096-byte) PCIe configuration space.
>  pub type Extended =3D Region<4096>;
> =20
> -/// Trait for PCI configuration space size markers.
> -///
> -/// This trait is implemented by [`Normal`] and [`Extended`] to provide
> -/// compile-time knowledge of the configuration space size.
> -pub trait ConfigSpaceKind: KnownSize {}
> -
> -impl ConfigSpaceKind for Normal {}
> -
> -impl ConfigSpaceKind for Extended {}
> -
> -/// The PCI configuration space of a device.
> +/// A view of PCI configuration space of a device.
>  ///
>  /// Provides typed read and write accessors for configuration registers
>  /// using the standard `pci_read_config_*` and `pci_write_config_*` help=
ers.
>  ///
> -/// The generic parameter `S` indicates the maximum size of the configur=
ation space.
> -/// Use [`Normal`] for 256-byte legacy configuration space or [`Extended=
`] for
> -/// 4096-byte PCIe extended configuration space (default).
> -pub struct ConfigSpace<'a, S: ?Sized + ConfigSpaceKind =3D Extended> {
> +/// The generic parameter `T` is the type of the view. The full configur=
ation space is also a
> +/// special type of view; in such cases, `T` can be [`Normal`] for 256-b=
yte legacy configuration
> +/// space or [`Extended`] for 4096-byte PCIe extended configuration spac=
e (default).
> +///
> +/// # Invariants
> +///
> +/// `ptr` is aligned and range `ptr..ptr + KnownSize::size(ptr)` is with=
in
> +/// `0..pdev.cfg_size().into_raw()`.
> +pub struct ConfigSpace<'a, T: ?Sized =3D Extended> {
>      pub(crate) pdev: &'a Device<device::Bound>,
> -    _marker: PhantomData<S>,
> +    ptr: *mut T,

`ptr` is used as a pseudo-pointer here, can its documentation be more
explicit about that?

Regardless,

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
