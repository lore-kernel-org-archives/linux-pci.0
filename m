Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012062.outbound.protection.outlook.com [52.101.48.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CA2332ED3;
	Tue, 21 Apr 2026 09:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776764544; cv=fail; b=MakD16HxM3ot1XWTSymW8O1nqD2tC7+qFj2zXJPr34Mu12U7Y78FMPsDdyGrqUh1UPUZEyHdiSRuBGvAoOyft2Nx0oXWK2wM3kcUZ9QFrt949nE2WPYLB4EsPscuuFRlB5Job1iuvzLEkc7WRw0ipBqW//5z3/3horhFqJNueIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776764544; c=relaxed/simple;
	bh=2o19P5eWKrdFrlCm/vIcQYFL9cp3nGXy8ahyj7bYexc=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=l9LJZi4wF41TWMIoDgHh9bfgQ0JVTj1pjFhXW9OlE69tneo/N+kPPKmN4EyEwYE+T3gEs44Dzrv3ldGINiSL+zhJMogNH0Y4R8mnFtzrdNwjsU2uOySoVJuYSNFZl3hQbTnl6g65mkUmEkXcpQuxcxRF0k9Aqk7n0PlFZmZxX3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OhFGH/Jd; arc=fail smtp.client-ip=52.101.48.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OhFGH/Jd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5uuLls2fQ5a3aj554Xk//ZNh7VcgxBEC7G4OPPLU7aqJCcISwVV9vqjWTQfruXhq9LGgf/DqT0UI0Q5cM36onuHFPRUF71Ca1n09YG8V74HnUnrySKweLzjTHO7JE2RKveITq1LcYdshatviv7lssxKhLrzOrU2GBIJc3spYQoVcKiZ1pwbJ9kU2bJNhlZvC7oe6BAxJs3kg3EqhSKWL36t3ejbiTDcULfoo1Kbn+FSh+vaFJQlbYE/Zjs+rUBaeiHzrH4CQZAed9zq4DDaTRqE/fA/83QWXzOh1aEA5W4Pm8G18itBZQnZr8ql9KUrwTa6qHRkpmg0p5Sh+Sq99w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kah2V0EgyuRmauLyhNZvK0heFPDdTXc5vGeUFP6//os=;
 b=NYPTpC2JD9L5kj6z78CnLs2/WCxQIVfYFcnv15HHtud1bAvzq2MDrllUbSrVrEJA/mnWEeEyUTOwC7P/DAQ1Dln1AJqZ9iLnXpY9SQpjXE6B+TucP1868cqzCj5pWIz9XGGmiQfedBKjdnq33lHKG6ttPRKqO5HzTe1k0LAOPGavSbG0+5q6uzX3cud8CkdAq9EujKiiBS868Sd94TP7k1z7Ye+7dPAet6ppJKQt/wEWIQR1hH7TNpfcXfiujOUn1QJckjzjgzrQ4P0T3iXUEsgk1loG4766x7Ypf++IceOplce5PbICGwyK3nSHjZQGrijL5WBgwefEa3yCucQOsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kah2V0EgyuRmauLyhNZvK0heFPDdTXc5vGeUFP6//os=;
 b=OhFGH/JdrYk0krtDauvFSDaoqFxx7patDdbiUWfSiC2PrhRs0lpI/NOzdSavAn3z5tG1Eoqxk/X9UOcRCkBaIHTSvIvFhHh8qMs+A0YGYKaJkTjLskMybr/1AGRG+jOYj8MJA8zVfKskMRR5PQQ6sZmEQYP0K2nM+pmuAhPu9DmIG5CPoekaP9gLKa81RmveclOCggcuJLR672RSKWLVcltaCmdCMySVnCbdOnXiV2HjCNHGlE7J4TQTYQJWP+BkSjvQsZah7BNzl7likCtQdZGb40KmOB2SUXvdfJ8x3mrM9GfSXWB0MCXDfdYLICyOuY1PmcAQCFwlXwMxlDVMKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SA0PR12MB4413.namprd12.prod.outlook.com (2603:10b6:806:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 09:42:16 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 09:42:16 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Apr 2026 18:42:12 +0900
Message-Id: <DHYQGLYYXEN6.11Q3FQGZMWCJ6@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Boqun Feng" <boqun@kernel.org>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] gpu: nova-core: send UNLOADING_GUEST_DRIVER GSP
 command upon unloading
From: "Eliot Courtney" <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260421-nova-unload-v2-0-2fe54963af8b@nvidia.com>
 <20260421-nova-unload-v2-4-2fe54963af8b@nvidia.com>
In-Reply-To: <20260421-nova-unload-v2-4-2fe54963af8b@nvidia.com>
X-ClientProxiedBy: TYCP301CA0079.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::15) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SA0PR12MB4413:EE_
X-MS-Office365-Filtering-Correlation-Id: c91402b2-abe9-4d6c-9582-08de9f8a45d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|7416014|376014|1800799024|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Cjoy2uU26uDN5Yb1AVRQV8Qm6Z6K8QmNx6QXlY8hcsz25EL59AuEXNUS1B8o2ONFQQFB4/wn9nGwMoLbVzQTq9k5KDUSCtJOJ+QoAM9BTQ2I54rb1Rg1fZp7cF1kPbiXYaQc0MVwSZRLqLIzs1Q+ak2paS+t5ISvf7F8W/ee2zP6iVYrxwnb7j/NeQnTZHmTvyg/WKP1a/DlMwQeavjWfO88EwzOajuOReKqcJasunAv/aSHx6hIeXMlWgzn3LBdi/x8suHQtkR+DyWwFduI9D9CEiF1fFfqNnC4+bS4Udf6YrPSkBQiqSaq85tLLw+0odr8zMcfqYcmwyOs+j2kMvRTtDe7j3AmCn4O9K5Sj/Tysn1K4gJF6VYzyhRcc/l2HhQ74ArXxQIAr4hIrKqPVN7qtQMDGNJoqK8pAzWqkvcYRZDRYKHutqNfhWlCg0k0/8GogkK3UiTFbo31FHCUWUg/GhR3Zv66ok9TdZbOD9CYJo5x33p1TbF5Ge+cmpyRyqKbDF2XU0jFwFToH4TA0v8ZMt4uZ/ZMjfXYWZz6ONae8ufF/HotYRLtCJqJ85Jku8vgSL40KWOC/kKodEeUs7pWI5SuidYhdNfI7ZDgFwlXYyx3n9zB4gfU9MDMCU67VV58pQH+X6Bkc0Na1RD5afxNYC1Jor/yIz30UxY0mgfNuQJRUleybjPjsiZKsdShgo1NtlTliUBU4VYdx3OKhKz9WhKnbNeE/nldtzkuAim3qZ0uSOy7grvdvt8NrItzrBGFAo4yCkZCB1FQO2B2aQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2353.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(376014)(1800799024)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3l2ZkQxTGNrVkRBRlM2bmFwNDV1a2g5QU9IYnFFWE5jdnlWbDhkOFhOSko3?=
 =?utf-8?B?N1JhVmRxcCtJMEVpQjVQWW9lNFZlSVlSZk8xcXg5Qk9xS0Rmd21RL01hSmJz?=
 =?utf-8?B?cU1PckNRMHVLTHAyYTJDa3RUWFcvZHVrQzF0WnE4Y3V3OU5FV0c0bzVJVkl1?=
 =?utf-8?B?WllmckpRS1krU1gvRTFPdzB4QituL21XZWxWSjgzREZLSlBpbEk1N3dwZkNH?=
 =?utf-8?B?Z0wxdkdoQm9iY3p0MStUaUNwRmttTSs3elk4N0Y0RmdCL2t3UjU3eVpVMVlu?=
 =?utf-8?B?dHVDZFZHT3R6U3I0VzFqWjkwck40cno3L0NBajNvOWwycy9IUmE1ZjBJQ3Uw?=
 =?utf-8?B?VWVoblA3QzZ4Ym1aWERBWmxWNHlKd203eUFteEVhcEg2NUE4cGphUkx5eWI2?=
 =?utf-8?B?QzhYUXA0UFBTOFVpWmpZUmRJRVBpNG9lcDREdnE0SGVvczVKcHZ6MDVnYVZ1?=
 =?utf-8?B?czhLbHVZWWhwVngzM0prc3VZb0tleHI3Wi9GUERIS293ZUdkYWRGY3R4dUpy?=
 =?utf-8?B?cWxCTGRuMUpoTGN0NEhkZHhIdWk5TURpYUZiVElhNlZpUWMvaFNVODlDZ0RN?=
 =?utf-8?B?WkVzbk94M1hhaUV6NHpGUGQwbnhnaUVUY2hiQmFFYmFSYVdscnB4SVNnZy9m?=
 =?utf-8?B?dkF3Ykh1N1hNYWd1VFlJOXc2SlZjMWhPU0ZSRGRLOWFHUnR6dmJnR1l0a291?=
 =?utf-8?B?MWVCMldickpKRytpOWJqYWlocFFBcjVGV3IxLzdSOHM2QWFST3ZRcVRxekRw?=
 =?utf-8?B?V1V0NDdVaFVVMUVZNGpHQmp3eWRPZUM2ZU16WWxLbTF2RlBmcHorWHB4Z1Mr?=
 =?utf-8?B?aCtHZTJJSHhKeldNMW55bjFiVkdMZ2wwRVZRby8vaUhnLzUxZkpuRGhtR0hy?=
 =?utf-8?B?UllHd3JzNnNRNlRXeGZDYUdURW9lVlp2OGtDZVIxd3VMbGR2VFRNTWJjY3A2?=
 =?utf-8?B?ekc1UWh1YXpqQmliV0NIeW1hRTZBVTFhQUpsRXU0OE82Z0lqRWIzZ1pzclNG?=
 =?utf-8?B?eFNoczBBR2VpY0dtbjA2emM5WVlrcGNkNVZuK2ZTWUJMWXhrTkhnc0I4OG50?=
 =?utf-8?B?OWlHaFIwaTY3R2pSWjZIMGs0bXMrWUlwOG1xK0kwUzR6NEVzVldJbGVOT1BP?=
 =?utf-8?B?aG5KU0Z3OTVHdjE1cExBZ05PMXhnamNwcXVaV2U5Q0grQVFYOEg0NjlKcnhG?=
 =?utf-8?B?R0pCdkt4S1NWTzZpVzhPbjlhM0RTNXdoSTdIZVZ6OVdlU09MRkgwNXpBT0Er?=
 =?utf-8?B?ZE1SOG8rb3dja1NEWWpvSXlmWXJLWmlvWjhOQ001eDkxdkdhTCtuTE0rZjlX?=
 =?utf-8?B?cWp0dTh1a3RLaU5ueldoaHA5aDU4TWJyM0pKa3h1S0ZsYWNCbCtzdi9ZN0ZR?=
 =?utf-8?B?alA0bjRTQkVKK0YyZVBkTHh5ekNTOWdqa3JISDRQRHk4OFV6eXpuMW1WMlhO?=
 =?utf-8?B?VXJqTEJ6anoxSVlOM2lyY0J4Q2loUTJqMGtsdk44YVorUjNpVURaWnN0Q0p0?=
 =?utf-8?B?Zk9lQlE2V1FFRVRUK1l1UHRrc1RYd0FJZGFsYTJWbXcwcjhjVDA3K29FdE4v?=
 =?utf-8?B?ek9scUd0cmhSQnNGK3ZxZXYyMnZSZFFCbXNKekFqUFRlaGdsdG9sTVl6Q3k5?=
 =?utf-8?B?eWtGeWFWVWxJb1JUTjdvZUVHWDlyaW9YZ2hRa3lpdkIvVkpWckhJeHhibDFB?=
 =?utf-8?B?QWFDcjBiKzJuQS9RNis1cG5qWUhHTGNHRmZxTlVRdUlIY29IemFpYmxjYWlq?=
 =?utf-8?B?R3U0UjdHUUxOL2ZGamZhQ042STJxRUh5Y0daWXdZWU9DK1piN3h2R25pdHBa?=
 =?utf-8?B?ZXJidzB5SXB2TWk2Uktrb0FnNlJ6cXN1VmlubXYxNVdaRjdUWVdsWUFEb1l0?=
 =?utf-8?B?VFR4ekpyR3o5dUliKzJvekViWVRZTkJDKy9xRERpNkZiN05uWW4xOXVyWDZX?=
 =?utf-8?B?aTBza0dZdFpxUm5qUCtyaHNaUXRVWElGS1ZyRTUyVE10WWw0YUc4MWlIcitZ?=
 =?utf-8?B?VjBxWGsxRzVXTjdLVzR1N0dLekR6eGNrR1dCbll0UzNxbFdYeERoTFdsNWlo?=
 =?utf-8?B?dFdkMlJ2N0lLR1FWL3VwRkExR0VyOE1VbGZZTXZlTlYrbUZwYitQWStwdk9n?=
 =?utf-8?B?c1ZaZG1NQlFlVGxRYWcvcS9ab1BJeGZTUGt6NFRhcndUU1VSZ3VOVEt1czRx?=
 =?utf-8?B?NExndE1pY3VWUXJpNG1ObFZ2a0NLcjhicEVoU0ZMZXhLVTRyeVBFZlo2dUJt?=
 =?utf-8?B?ckNnTjdQdGFoSlJkdkgyaHVwNDlpSFZZR0dwWUp4SDByUkMyYmxHZlVqdWQz?=
 =?utf-8?B?czNmYlI5d1NtbmUzY3dQZTZUbFpOMWdaTjJlWllGYVpSKzM3c00xUzNrVDN5?=
 =?utf-8?Q?rTt15YGWkX3I3/XRsHJIM5CsC1aL5wMzlj0lRC5bGV/H9?=
X-MS-Exchange-AntiSpam-MessageData-1: Nj+k8BGagP/F3Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c91402b2-abe9-4d6c-9582-08de9f8a45d6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 09:42:16.0977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IGi6dX/KyAn8+VJResL8Jjg9dOF4KGPV6gYcarkOOQ/8Gw6BDReOzdySGkU+4L79zIr3GMXxO2oxKDTHIGuirA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4413

On Tue Apr 21, 2026 at 3:16 PM JST, Alexandre Courbot wrote:
> Currently, the GSP is left running after the driver is unbound. This is
> not great for several reasons, notably that it can still access shared
> memory areas that the kernel will now reclaim (especially problematic on
> setups without an IOMMU).
>
> Fix this by sending the `UNLOADING_GUEST_DRIVER` GSP command when
> unbinding. This stops the GSP and lets us proceed with the rest of the
> unbind sequence in the next patch.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  drivers/gpu/nova-core/gpu.rs                      |  5 +++
>  drivers/gpu/nova-core/gsp/boot.rs                 | 40 +++++++++++++++++=
++++++
>  drivers/gpu/nova-core/gsp/commands.rs             | 36 +++++++++++++++++=
+++
>  drivers/gpu/nova-core/gsp/fw.rs                   |  4 +++
>  drivers/gpu/nova-core/gsp/fw/commands.rs          | 23 +++++++++++++
>  drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs |  8 +++++
>  6 files changed, 116 insertions(+)
>
> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
> index 1701c2600538..8f2ae9e8a519 100644
> --- a/drivers/gpu/nova-core/gpu.rs
> +++ b/drivers/gpu/nova-core/gpu.rs
> @@ -277,12 +277,17 @@ pub(crate) fn new<'a>(
> =20
>      /// Called when the corresponding [`Device`](device::Device) is unbo=
und.
>      ///
> +    /// Prepares the GPU for unbinding by shutting down the GSP and unre=
gistering the sysmem flush
> +    /// memory page.
> +    ///
>      /// Note: This method must only be called from `Driver::unbind`.
>      pub(crate) fn unbind(&self, dev: &device::Device<device::Core>) {
>          let Ok(bar) =3D kernel::warn_on_err!(self.bar.access(dev)) else =
{
>              return;
>          };
> =20
> +        let _ =3D kernel::warn_on_err!(self.gsp.unload(dev, bar, &self.g=
sp_falcon));
> +

If I remember correctly, at least on blackwell, doing the full unloading
procedure here actually resets the sysmem flush register, so you get a
spurious warning. In my local branch I actually swapped the order of
this and unregister to get rid of it (not sure if this is correct though).
My sysmem flush patch that skips printing the warning if the value is 0
would also fix this, if we care. Have you noticed this happening too?

>          self.sysmem_flush.unregister(bar);
>      }
>  }
> diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gs=
p/boot.rs
> index 18f356c9178e..3f4e99b2497b 100644
> --- a/drivers/gpu/nova-core/gsp/boot.rs
> +++ b/drivers/gpu/nova-core/gsp/boot.rs
> @@ -33,6 +33,7 @@
>      },
>      gpu::Chipset,
>      gsp::{
> +        cmdq::Cmdq,
>          commands,
>          sequencer::{
>              GspSequencer,
> @@ -237,4 +238,43 @@ pub(crate) fn boot(
> =20
>          Ok(())
>      }
> +
> +    /// Shut down the GSP and wait until it is offline.
> +    fn shutdown_gsp(
> +        cmdq: &Cmdq,
> +        bar: &Bar0,
> +        gsp_falcon: &Falcon<Gsp>,
> +        suspend: bool,
> +    ) -> Result<()> {
> +        // Send command to shutdown GSP and wait for response.
> +        cmdq.send_command(bar, commands::UnloadingGuestDriver::new(suspe=
nd))?;
> +
> +        // Wait until GSP signals it is suspended.
> +        const LIBOS_INTERRUPT_PROCESSOR_SUSPENDED: u32 =3D 0x8000_0000;

If this can change based on firmware, should it be taken in via
bindings? I also noticed in openrm 595, this is waited on by checking the
bit rather than by strict equality (see _kgspIsProcessorSuspended). So
it may be more defensive to check the bit rather than strict equality
(even though that is correct for 570 according to openrm code).

> +        read_poll_timeout(
> +            || Ok(gsp_falcon.read_mailbox0(bar)),
> +            |&mb0| mb0 =3D=3D LIBOS_INTERRUPT_PROCESSOR_SUSPENDED,
> +            Delta::from_millis(10),
> +            Delta::from_secs(5),
> +        )
> +        .map(|_| ())
> +    }
> +
> +    /// Attempts to unload the GSP firmware.
> +    ///
> +    /// This stops all activity on the GSP.
> +    pub(crate) fn unload(
> +        &self,
> +        dev: &device::Device<device::Bound>,
> +        bar: &Bar0,
> +        gsp_falcon: &Falcon<Gsp>,
> +    ) -> Result {
> +        // Shut down the GSP.
> +
> +        Self::shutdown_gsp(&self.cmdq, bar, gsp_falcon, false)
> +            .inspect_err(|e| dev_err!(dev, "unload guest driver failed: =
{:?}", e))?;

It looks like "suspend" is only ever false here? Will this be used
later? If we want to keep this, it may be nice to use a 2 discriminant
enum so we don't have misc boolean parameters hanging around.

nit: dev_err! should have \n?

> +        dev_dbg!(dev, "GSP shut down\n");
> +
> +        Ok(())
> +    }
>  }
> diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-cor=
e/gsp/commands.rs
> index c80df421702c..fb94460c451e 100644
> --- a/drivers/gpu/nova-core/gsp/commands.rs
> +++ b/drivers/gpu/nova-core/gsp/commands.rs
> @@ -237,3 +237,39 @@ pub(crate) fn gpu_name(&self) -> core::result::Resul=
t<&str, GpuNameError> {
>  pub(crate) fn get_gsp_info(cmdq: &Cmdq, bar: &Bar0) -> Result<GetGspStat=
icInfoReply> {
>      cmdq.send_command(bar, GetGspStaticInfo)
>  }
> +
> +pub(crate) struct UnloadingGuestDriver {
> +    suspend: bool,
> +}

This feels like it only makes sense to call from within the gsp module,
so I wonder if it can be pub(super) (prolly a few others in this file
could be too, ofc not relevant for this series).

nit: Should this have doc comment?

> +
> +impl UnloadingGuestDriver {
> +    pub(crate) fn new(suspend: bool) -> Self {
> +        Self { suspend }
> +    }
> +}
> +
> +impl CommandToGsp for UnloadingGuestDriver {
> +    const FUNCTION: MsgFunction =3D MsgFunction::UnloadingGuestDriver;
> +    type Command =3D fw::commands::UnloadingGuestDriver;
> +    type Reply =3D UnloadingGuestDriverReply;
> +    type InitError =3D Infallible;
> +
> +    fn init(&self) -> impl Init<Self::Command, Self::InitError> {
> +        fw::commands::UnloadingGuestDriver::new(self.suspend)
> +    }
> +}
> +
> +pub(crate) struct UnloadingGuestDriverReply;
> +
> +impl MessageFromGsp for UnloadingGuestDriverReply {
> +    const FUNCTION: MsgFunction =3D MsgFunction::UnloadingGuestDriver;
> +    type InitError =3D Infallible;
> +    type Message =3D ();
> +
> +    fn read(
> +        _msg: &Self::Message,
> +        _sbuffer: &mut SBufferIter<array::IntoIter<&[u8], 2>>,
> +    ) -> Result<Self, Self::InitError> {
> +        Ok(UnloadingGuestDriverReply)
> +    }
> +}
> diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/=
fw.rs
> index 0c8a74f0e8ac..59b4c4883185 100644
> --- a/drivers/gpu/nova-core/gsp/fw.rs
> +++ b/drivers/gpu/nova-core/gsp/fw.rs
> @@ -278,6 +278,7 @@ pub(crate) enum MsgFunction {
>      Nop =3D bindings::NV_VGPU_MSG_FUNCTION_NOP,
>      SetGuestSystemInfo =3D bindings::NV_VGPU_MSG_FUNCTION_SET_GUEST_SYST=
EM_INFO,
>      SetRegistry =3D bindings::NV_VGPU_MSG_FUNCTION_SET_REGISTRY,
> +    UnloadingGuestDriver =3D bindings::NV_VGPU_MSG_FUNCTION_UNLOADING_GU=
EST_DRIVER,
> =20
>      // Event codes
>      GspInitDone =3D bindings::NV_VGPU_MSG_EVENT_GSP_INIT_DONE,
> @@ -322,6 +323,9 @@ fn try_from(value: u32) -> Result<MsgFunction> {
>                  Ok(MsgFunction::SetGuestSystemInfo)
>              }
>              bindings::NV_VGPU_MSG_FUNCTION_SET_REGISTRY =3D> Ok(MsgFunct=
ion::SetRegistry),
> +            bindings::NV_VGPU_MSG_FUNCTION_UNLOADING_GUEST_DRIVER =3D> {
> +                Ok(MsgFunction::UnloadingGuestDriver)
> +            }
> =20
>              // Event codes
>              bindings::NV_VGPU_MSG_EVENT_GSP_INIT_DONE =3D> Ok(MsgFunctio=
n::GspInitDone),
> diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-=
core/gsp/fw/commands.rs
> index db46276430be..71c8690c9322 100644
> --- a/drivers/gpu/nova-core/gsp/fw/commands.rs
> +++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
> @@ -129,3 +129,26 @@ unsafe impl AsBytes for GspStaticConfigInfo {}
>  // SAFETY: This struct only contains integer types for which all bit pat=
terns
>  // are valid.
>  unsafe impl FromBytes for GspStaticConfigInfo {}
> +
> +/// Payload of the `UnloadingGuestDriver` command and message.
> +#[repr(transparent)]
> +#[derive(Clone, Copy, Debug, Zeroable)]
> +pub(crate) struct UnloadingGuestDriver(bindings::rpc_unloading_guest_dri=
ver_v1F_07);
> +
> +impl UnloadingGuestDriver {
> +    pub(crate) fn new(suspend: bool) -> Self {
> +        Self(bindings::rpc_unloading_guest_driver_v1F_07 {
> +            bInPMTransition: u8::from(suspend),
> +            bGc6Entering: 0,
> +            newLevel: if suspend { 3 } else { 0 },

Why '3'? Is there a binding that it makes sense to use for this?

> +            ..Zeroable::zeroed()
> +        })
> +    }
> +}
> +
> +// SAFETY: Padding is explicit and will not contain uninitialized data.
> +unsafe impl AsBytes for UnloadingGuestDriver {}
> +
> +// SAFETY: This struct only contains integer types for which all bit pat=
terns
> +// are valid.
> +unsafe impl FromBytes for UnloadingGuestDriver {}
> diff --git a/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs b/drivers/=
gpu/nova-core/gsp/fw/r570_144/bindings.rs
> index 334e8be5fde8..5d8e4c0ad904 100644
> --- a/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
> +++ b/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
> @@ -880,6 +880,14 @@ fn default() -> Self {
>      }
>  }
>  #[repr(C)]
> +#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
> +pub struct rpc_unloading_guest_driver_v1F_07 {
> +    pub bInPMTransition: u8_,
> +    pub bGc6Entering: u8_,
> +    pub __bindgen_padding_0: [u8; 2usize],
> +    pub newLevel: u32_,
> +}
> +#[repr(C)]
>  #[derive(Debug, Default, MaybeZeroable)]
>  pub struct rpc_run_cpu_sequencer_v17_00 {
>      pub bufferSizeDWord: u32_,

