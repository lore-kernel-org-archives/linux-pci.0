Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010008.outbound.protection.outlook.com [52.101.201.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8524363C73;
	Tue, 16 Jun 2026 14:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781618766; cv=fail; b=Hyo264iGKwWmgsT/zFWIh4Y/l+QtdJhIU1hDabQjTEFaKfCB/2GEO3Rz3AqIoe0dFKoDivUoRbtVnahdopsdDD6CGQR/1mQoFXyirASgKA7PFfgD2oTw8AkyOzXmb/IHCXF+sh26TAcxrj01ih1N+Iy+PRDxL6rShMryv3jTN5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781618766; c=relaxed/simple;
	bh=fnR7sirmSRHjos9CYa/ZlPG8k7Y6ozFMj2rq11JvVY8=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=FSB09dZQ262FYIU8Y+e68Vzj8TcdWzdpccMEYoqqUgJois8HFHjLrirTAZTstKJPHVGOnOmk8tqKpNuBBEVmKGuSd+v8g6LkRv8OK6Y2siGCXdcsPFnoLq6aaKDS6FtEx3Pm+5s44QEIJUvFGccFzgRMLQ4W9uJWW61u0HHNy8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ByH5p1Bs; arc=fail smtp.client-ip=52.101.201.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ByH5p1Bs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQB/IFGZNCSrSyGsHzBt7djuUj3OAm9IpMsJb28r2beb1miDWoCufCejZ/rCcnqd6Tf3tTEjh2AMUI1mII1UbsaNQDlvEh0bnd4Q0WnPNTmJIOI4HPw3yRbG6tEoEs74+sJP6LdnYNCiEl0TTHWXpEDLkB8KTMMhsZuneyElS3f3+Im84aoKzzdIaagmokHowUek4eclccmb+JGlzcrdT0Cb3eyZenqINOJF6IbxLj9C/0sMW+A1cNpRyjFgkb/tyxNXqFLulTPq3YOHWvhipcnquufgZHG3jGTkJUnIN35UrR5HzlKPh4PDqR8oY444K3HW3Po7gpzxqCqR/PmAzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgRZHbRW/zWJ5EQ54PKjLk4wwOLJznJXGlNLLsPsrGU=;
 b=mCaMJqBi1G3uBSMC2Ad/Wj9+VHZ2nIP5lzlvoblMmurvxdUnvdXecIjWJ8C6Axcl4d0suGPNJS2e0a0dxDGSzNZjya1n4pLa51puxw/JhEldeEtIs3pTvefudARmPV1WneNbp5ajh77HPLch/Vd9iWK1V0wkT4PtYtHET1dkhOxCYfmTweNAuB8NPqizCZE7Cf5tkScvuF30i3KCMe3TKDxqn4inL7WmC9HZl+DjOH94EY8hAqt26M4FJfH+W0n2G0TtEWUvuROJXUac+ojzrSlRa5DL1ENE3rL7EgD4qZyVdwftC4E553TCYkHmgLL+Kv9/GKaP6KQMED/VoscbMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgRZHbRW/zWJ5EQ54PKjLk4wwOLJznJXGlNLLsPsrGU=;
 b=ByH5p1Bsyg41Jcm3iP7LArpj0s6Lpx/qInmWuzkUw5eVJ42TkjYap9ySp9XcAg/CZ6ei6Cg2YTz3C6OL7oXAjDVMGtYy1ceIXr5F/zb45IdReLvZNl+evAZEsmjRke9zWLLuioCnTYV2DKzPlvgYGyNMF3e5DdlP6ooVb36b4Y63VTnygeGXhBNBSW5SruFkhMk1y872Io0UFo1XnaullHsUU00roxcwHGDiGAwNGsqBCHgDDMzfzeYKvvm/5mQktpBLdywDRk1DVGneFdCbJzyv2c0DiSJTD2EMcGbE0hwyP716d9X/ab6QyKvThHLSgCCpoLUMcOqotl4j5oNMeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA1PR12MB5671.namprd12.prod.outlook.com (2603:10b6:806:23b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Tue, 16 Jun
 2026 14:05:59 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 14:05:59 +0000
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jun 2026 23:05:55 +0900
Message-Id: <DJAJ51781EOF.1Q2VTH6CQVXYD@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
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
Subject: Re: [PATCH v4 09/20] rust: io: use view types instead of addresses
 for `Io`
Content-Transfer-Encoding: quoted-printable
References: <20260611-io_projection-v4-0-1f7224b02dcb@garyguo.net>
 <20260611-io_projection-v4-9-1f7224b02dcb@garyguo.net>
In-Reply-To: <20260611-io_projection-v4-9-1f7224b02dcb@garyguo.net>
X-ClientProxiedBy: TY4P301CA0010.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:26f::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA1PR12MB5671:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cf9ab4d-f921-42e8-79e6-08decbb06408
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|7416014|366016|23010399003|6133799003|5023799004|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	uF0lonxvLxb9qKxrVwALxHVsX24JgP86jAqysCQMfVAtRVMdyDcZ9yDOjziSFcT7hQ5dFeSUdEb7PsclGF4Igc3p9nlFRooCJTGYS+txuBFuyfD4G313CQPaVUf4eUwv/GtPzFciaa6isiE9+k7OR006klGk2yKUjdwxNp3LHMf+8wbarBgqCUf7KV/NWrXGAJNS/B737EOcYFCGWs50+WFhaoeVcay6c8K5sWaJwGzVFjg6aa6ISazj2uozpqKSoXy0SXy5CaP3Z9lG2qEoanfxz9fCMedGXxq/9bCSEgdPBMAhjRmYPMcpljxVLqYbWK+uXjMe9RZVYqS3HcWXfPLkGhx1yhQBoVPgpCy+/L3XqTtIZ3TpZ7gAKp8sCXecZJPJbFnzQz3FL3Ng3suo1HsT5Hv50J1gAsvPECOTdOswf6duf40BnFEDbAhI/7ORdfeCM2GLyYJuJzEgFRAI1xhrU+SXPLZEKuInHeu8cU7+R7OYk95Nl2vKOfKA8onEwvXVzG5l60WrheaosQYxxUXLEZZaZW2Ai6M4SMit61OA6+Sl0E6k6XEsG2IR9v75mshjWb5Knd1yqeD1w9bLCmXoa6jZNHKruCjLDMmDQqUPK6myeUZg7knsgr4NaE8Pfn7173YWBpargtnHjRh6YQIB7f/IY7s7ngLPhaon1/YA7siYHyIJXKfdPbg/l83f
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(7416014)(366016)(23010399003)(6133799003)(5023799004)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFdBRGxwQ09CZVF5MHM4YVJvU1IrSU5GUXFsV2VSRHEwWnBqU3RyOTVBZUo2?=
 =?utf-8?B?L3VRd2VGK3g3Zk9RUzgyZnR2dk82VmF6UjJJTnVoTnlpNkJPQ3pPNGtGaGF5?=
 =?utf-8?B?NUorTEdTWVM2YUVDbEFsOG0zT2ovTHlzdW9wK0tkaER3NHdWQjI5OHJkbng0?=
 =?utf-8?B?MzRzNmljdlBhWFpJL2R0RFlDMys2RzJabkRtSUNGOXc0RHprSnhnTE1EeDZ1?=
 =?utf-8?B?cURLNWZLM1NvSVhzeXVSTUM4TGZ0Wis0RjU4V2JxeGhEWlJiV1c4S3ZBNnpS?=
 =?utf-8?B?YlNZbjFMc0VVdWhEZ1hyS3JEY3pQd3VGOFZhbm5Lei85Y083WEtYT0VBT3hh?=
 =?utf-8?B?S05aaEhIbHhzYXIrOG0zdS9Ob1dDVzNjbG90bHN5cnhQQWFEU292Zy9FdnNO?=
 =?utf-8?B?KysvdVExNWs4N084UnhxMnYrbTJad1NDcmVBbzM1MXV3WGpHMk9zRjluKzl1?=
 =?utf-8?B?Ui9rV2VBNUVNK21qRDNEZkMzMWMvUGE2aEZyOUFkMHZOS25XSHpaTkNTYjZ1?=
 =?utf-8?B?MC9rZk5WVEhVbUgrdlZFeFNpTk1sZEJydUhHNVVhMlBIdE1GdmJVNDVyQS8x?=
 =?utf-8?B?eEEwZ3lVTyt1ckRwYVYwM3BHNVFrVEZmRHB4dE5TTmQ4T1YzOWNIeHZnNUhp?=
 =?utf-8?B?SFozT3hZYzN5K09UWkxrQmZGbjMvdDZVaUZpQjVvZGsxM1hGcHF3WWhrb2FX?=
 =?utf-8?B?QWhaSE5RR2w2Smlyc1NwaHQwK2tpKzBmL3NsNHJsL0l3VE1VL1hBTnlGK2ZM?=
 =?utf-8?B?bDVGMk43MkYxU1g3RWxKREo0dVpTWXdOMldiS2djNXQ4YlNYZUFXaHR0Z0l4?=
 =?utf-8?B?ZGs0MHhoYjJMUTVtQmZHRGx6bXBld3NEY0Q3d3NtbWJKQjdac0N5Q3NWSWhm?=
 =?utf-8?B?N0pBY0U3WEdxTnlOcEkrSWlwckM0YktmREc3clowbGVIS1diVERORVk1ZEwz?=
 =?utf-8?B?RlJkNWRzQnFyYTlUYm82bHhNWW5uYmZmWk1RNEQyNjQyV0F2YUl6RlBYZnc1?=
 =?utf-8?B?VlJoZS8wTy95eG0xZUF4em5zTzNBa0doMUxhZ1Rsak1ZZVk2dzF6SGtBeCt6?=
 =?utf-8?B?WHdqekpHVEhSRTBiaVpmZDBIUzJCaHJCbnN1MXFzRnNBUk5OU2FIL3huZjNl?=
 =?utf-8?B?VENnL0tqZGljeSttK2FlS2g4T1o5NmtXalo0VlFtb1B6SDJPaFg1aUdmUzRI?=
 =?utf-8?B?ZE45UFZlcFJ5UDFlRHUrbDhISXdtYTR4Wm5wTCtPb29qTVo1eVZ4OVlZWXU2?=
 =?utf-8?B?Zlcxd21zRUNZY05NVzQwUHNiaDFESUx5SHJYVzNRNVBqQkxiOEI1UUk2a28y?=
 =?utf-8?B?dVVsRDFWK1RjTVl4VUw0cEZZS1RoejJHaEJoNTg5aG9DRHptQVpoSGc1UndB?=
 =?utf-8?B?bFN2aTV6NndIL1YvQUpsNDRId044aUdwYVNRaDNKY3Z4Ulg4b2xXR3N0V2lQ?=
 =?utf-8?B?QjhwRTB5ODZkSXE4UXl2N2JkNkZidG5Ga1MwOGV0Qi9jT3N4ejIwWmI0OXJo?=
 =?utf-8?B?eFRxbTFRUGxmRlR2ckRyT09pbXpyT3hSV0ZzSmtUVExoUGtRQSs4RzhqWWdZ?=
 =?utf-8?B?SDVKWXJTUHlDS0ZZdTcvWFFzRFBUYlR5N1JOd3hpMUVtV1h4OTBhc0t2YVgz?=
 =?utf-8?B?ei9EL1ZlZ3Y1VytPbDFhTzk1NFdIOWljcUZ2QWpKUmNXWFI1RHFteWQvMXJv?=
 =?utf-8?B?QXRxdzVQY2RzVEgzL0V1WXFPU3plSHJJQS9pVUVoY0lOamtNUFRnaUg4TE9x?=
 =?utf-8?B?SEJBb2tZWUpGKzVqMm5QSG1EZWovVTRRdWx2OVN1blNKdFUvWlpLaFVKS2JZ?=
 =?utf-8?B?MGhBZkdidDIwam94Z3hjQUsxSVhVcXdiN0g2N2krNk1lNG5icm1sMjJlVEVZ?=
 =?utf-8?B?UGlISGNUemUwSHlMMnpPR2Nqbkl6V1hPQ0dQZFhyTXBDU2ViVnR3T2ZlTVQx?=
 =?utf-8?B?U2V4OWZGa2hTeENHdmdjNkRxRHZFUExaamJ2MmRKT21qeUhIS3RqYXVXdTMw?=
 =?utf-8?B?ZW9wOVFvY0pOWStPNDF4aHN6enpkem05NnFYbXBoSDhjOEs5SE9CMEZUR0du?=
 =?utf-8?B?R0VBOG1uT1dWWW1lTWU5TGdRRm16RVBValNWaU1TYzMwdk1zVjgrY1lObTF3?=
 =?utf-8?B?dlRKQzkxZVJDQWJVL3pLbEZ1Q08yMFNidkpjMlI0MVprNTgvSk8vN3VaU09B?=
 =?utf-8?B?UmZHQkJnbTBkVk1KSFU1T2FiYXNFVUkrRXZiSGcwOWROVEYvZjFTTWE0bTdW?=
 =?utf-8?B?Vk9oQlNydUFzUnZSOG5uczdKcFlrQW9sVFVDOWxmaHdTZXY1YWNyNEx3U1g2?=
 =?utf-8?B?cDlocmduNjdSQUNWUkZVRmttSXZJVEZ3elcybzRQYjdscjhiOExnSHArcXN6?=
 =?utf-8?Q?GuKnp5dbeDprGvhmO8HA0EeFdIphRpo9VHAfUJFyH5QkO?=
X-MS-Exchange-AntiSpam-MessageData-1: mFUnkKWN2ZIsRA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf9ab4d-f921-42e8-79e6-08decbb06408
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 14:05:58.9128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xjMxjs/1JtWB2rMELp42zZ4DzO1WIC0BdqqIrF55tW0JWvxPzHy1LTxKbNI9wwNjg1Q3RuJ/W1EHth7MIHQbwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5671

On Fri Jun 12, 2026 at 1:28 AM JST, Gary Guo wrote:
> Currently, `io_read` and `io_write` methods require the exact type of `Io=
`
> plus an address. This means that they need to be monomorphized for each
> different `Io` instance. This also means that multiple I/O implementors f=
or
> the same I/O kind needs to duplicate implementation (e.g. `Mmio` and
> `MmioOwned`).
>
> Create a new `IoBackend` trait and define these operations on it instead.
> The operations are just going to receive a view type and operate on them.
> This has the additional advantage that the invariants can be moved from t=
he
> trait (and guaranteed via `unsafe`) to type invariants on the canonical
> view types of the backends, so `io_read` and `io_write` can be safe.
>
> Note that view type is needed; addresses are insufficient in this
> designk, as they do not carry sufficient information. For example,

typo: design

> `ConfigSpace` needs `&pci::Device` in addition to the address.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  rust/kernel/io.rs     | 345 ++++++++++++++++++++++++++------------------=
------
>  rust/kernel/pci/io.rs |  70 ++++++----
>  2 files changed, 224 insertions(+), 191 deletions(-)
>
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index 3ac8b396f5a7..e422a5ff2a5e 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -244,6 +244,38 @@ const fn offset_valid<U>(base: usize, offset: usize,=
 size: usize) -> bool {
>      }
>  }
> =20
> +/// I/O backends.
> +///
> +/// This is an abstract representation to be implemented by arbitrary I/=
O
> +/// backends (e.g. MMIO, PCI config space, etc.).
> +///
> +/// The base trait only defines the projection operations; which I/O met=
hods are available depends
> +/// on which [`IoCapable<T>`] traits are implemented for the type. For e=
xample, for MMIO regions,
> +/// all widths (u8, u16, u32, and u64 on 64-bit systems) are typically s=
upported. For PCI
> +/// configuration space, u8, u16, and u32 are supported but u64 is not.
> +///
> +/// This trait is separate from the `Io` trait as multiple different I/O=
 types may share the same
> +/// operation.
> +pub trait IoBackend {
> +    /// View type for this I/O backend.
> +    type View<'a, T: ?Sized + KnownSize>: Io<'a, Backend =3D Self, Targe=
t =3D T>;
> +
> +    /// Convert a `view` to a raw pointer for projection.
> +    fn as_ptr<'a, T: ?Sized + KnownSize>(view: Self::View<'a, T>) -> *mu=
t T;

Same as the previous patch, this pointer is not necessarily
dereferencable (e.g. for `pci::ConfigSpace`). This should probably be
mentioned, or maybe we can use a newtype to prevent dereferencing?

> +
> +    /// Project `view` to its subregion indicated by `ptr`.
> +    ///
> +    /// If input `view` is valid, returned view must also be valid.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must be a projection of `Self::as_ptr(view)`.
> +    unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + KnownS=
ize>(
> +        view: Self::View<'a, T>,
> +        ptr: *mut U,
> +    ) -> Self::View<'a, U>;
> +}
> +
>  /// Trait indicating that an I/O backend supports operations of a certai=
n type and providing an
>  /// implementation for these operations.
>  ///
> @@ -252,22 +284,12 @@ const fn offset_valid<U>(base: usize, offset: usize=
, size: usize) -> bool {
>  /// For example, a PCI configuration space may implement `IoCapable<u8>`=
, `IoCapable<u16>`,
>  /// and `IoCapable<u32>`, but not `IoCapable<u64>`, while an MMIO region=
 on a 64-bit
>  /// system might implement all four.
> -pub trait IoCapable<T> {
> -    /// Performs an I/O read of type `T` at `address` and returns the re=
sult.
> -    ///
> -    /// # Safety
> -    ///
> -    /// - The range `[address..address + size_of::<T>()]` must be within=
 the bounds of `Self`.
> -    /// - `address` must be aligned.
> -    unsafe fn io_read(self, address: usize) -> T;
> +pub trait IoCapable<T>: IoBackend {
> +    /// Performs an I/O read of type `T` at `view` and returns the resul=
t.
> +    fn io_read<'a>(view: Self::View<'a, T>) -> T;
> =20
> -    /// Performs an I/O write of `value` at `address`.
> -    ///
> -    /// # Safety
> -    ///
> -    /// - The range `[address..address + size_of::<T>()]` must be within=
 the bounds of `Self`.
> -    /// - `address` must be aligned.
> -    unsafe fn io_write(self, value: T, address: usize);
> +    /// Performs an I/O write of `value` at `view`.
> +    fn io_write<'a>(view: Self::View<'a, T>, value: T);
>  }
> =20
>  /// Describes a given I/O location: its offset, width, and type to conve=
rt the raw value from and
> @@ -319,56 +341,54 @@ fn offset(self) -> usize {
>  /// Types implementing this trait (e.g. MMIO BARs or PCI config regions)
>  /// can perform I/O operations on regions of memory.
>  ///
> -/// This is an abstract representation to be implemented by arbitrary I/=
O
> -/// backends (e.g. MMIO, PCI config space, etc.).
> -///
>  /// The [`Io`] trait provides:
> -/// - Base address and size information
> +/// - Method to convert into [`IoBackend::View`].
>  /// - Helper methods for offset validation and address calculation
>  /// - Fallible (runtime checked) accessors for different data widths
>  ///
> -/// Which I/O methods are available depends on which [`IoCapable<T>`] tr=
aits
> -/// are implemented for the type.
> -///
> -/// # Examples
> -///
> -/// For MMIO regions, all widths (u8, u16, u32, and u64 on 64-bit system=
s) are typically
> -/// supported. For PCI configuration space, u8, u16, and u32 are support=
ed but u64 is not.
> -pub trait Io: Copy {
> +/// Which I/O methods are available depends on the associated [`IoBacken=
d`] implementation.
> +pub trait Io<'a>: Copy {
> +    /// Type that defines all I/O operations.
> +    type Backend: IoBackend;
> +
>      /// Type of this I/O region. For untyped regions, [`Region`] can be =
used.
>      type Target: ?Sized + KnownSize;
> =20
> -    /// Returns the base address of this mapping.
> -    fn addr(self) -> usize;
> -
> -    /// Returns the maximum size of this mapping.
> -    fn maxsize(self) -> usize;
> +    /// Return a view that covers the full region.
> +    fn as_view(self) -> <Self::Backend as IoBackend>::View<'a, Self::Tar=
get>;
> =20
> -    /// Returns the absolute I/O address for a given `offset`,
> -    /// performing compile-time bound checks.
> +    /// Returns a view for a given `offset`, performing compile-time bou=
nd checks.
>      // Always inline to optimize out error path of `build_assert`.
>      #[inline(always)]
> -    fn io_addr_assert<U>(self, offset: usize) -> usize {
> -        // We cannot check alignment with `offset_valid` using `self.add=
r()`. So set 0 for it and
> +    fn io_addr_assert<U>(self, offset: usize) -> <Self::Backend as IoBac=
kend>::View<'a, U> {

Since this doesn't return an address anymore, should it be renamed?

> +        // We cannot check alignment with `offset_valid` using `ptr.addr=
()`. So set 0 for it and
>          // ensure alignment by checking that the alignment of `U` is sma=
ller or equal to the
>          // alignment of `Self::Target`.
>          const_assert!(Alignment::of::<U>().as_usize() <=3D Self::Target:=
:MIN_ALIGN.as_usize());
>          build_assert!(offset_valid::<U>(0, offset, Self::Target::MIN_SIZ=
E));
> =20
> -        self.addr() + offset
> +        let view =3D self.as_view();
> +        let ptr =3D Self::Backend::as_ptr(view);
> +        let projected_ptr =3D ptr.cast::<U>().wrapping_byte_add(offset);
> +        // SAFETY: `offset_valid` checks for size and alignment and ther=
efore `projected_ptr` is a
> +        // valid projection.
> +        unsafe { Self::Backend::project_view(view, projected_ptr) }
>      }
> =20
> -    /// Returns the absolute I/O address for a given `offset`,
> -    /// performing runtime bound checks.
> +    /// Returns a view for a given `offset`, performing runtime bound ch=
ecks.
>      #[inline]
> -    fn io_addr<U>(self, offset: usize) -> Result<usize> {
> -        if !offset_valid::<U>(self.addr(), offset, self.maxsize()) {
> +    fn io_addr<U>(self, offset: usize) -> Result<<Self::Backend as IoBac=
kend>::View<'a, U>> {

Same here.

And potentially, a more serious issue: `io_addr_assert` and `io_addr`
remain part of `Io`, which is a public trait. They only verify size and
alignment for `U`, not whether a projection of `U` at `offset` is
structurally valid. AFAICT this remains that way by the end of the
series, so users are able to call `io_addr*` to create and use invalid
projections.

Moving `io_addr*` out of the trait and into local helpers should be
enough to close that loophole.

Also, (and not entirely sure of it because I haven't completely wrapped
my head around the issue yet), we might need to seal or otherwise
restrict `IoLoc` so external code cannot create arbitrary
implementations that allow invalid projections.
