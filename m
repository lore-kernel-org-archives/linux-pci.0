Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011066.outbound.protection.outlook.com [40.93.194.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4AB40683A;
	Wed,  8 Jul 2026 14:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519411; cv=fail; b=IcbP9hRISNNUgOhmhARUPpkamnw9QG6K1/8T2eSU9awrij/fuW2QXwOMrT8b3Xl5cXmLr2t2+0uBgiGj1Ae9RaMTsH9Xiy/QC4JvkQr+YilX8EuBJxN6o6fSTDZw3Cy29Us1Him4h1tWJ8nfM6nSNuJ91aYgF2fkMa7YQFY2Dlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519411; c=relaxed/simple;
	bh=wxxotW96AgahGKXcFp1LEzi3fvrgCQxfk85ZzuVY85U=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=RaBXOHb9s/qeq7eio07AbICFh8lDbuvpUcIdep6+qIg7dFMhovYypvJkkYuhd/QFLrwf0AIH+iXiSZpwQHGtvZ4Dq/2bmk0nbOlwLHHq98MBxbNIi/nnYMWstyvS1yH7CsN2dIDlmGt/IFaUCehtBgVgAsnlQq+hMfFgswjlJrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ya265F+1; arc=fail smtp.client-ip=40.93.194.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ya265F+1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jy4RdARrSpkBirRnDEVUQlQIc0c99/5ZN8Kw2ABGLL9f+Yn5CYUlveCUpa2EmQ2RqAoz7T4LBlPRXhF+/Apzfyd/LzvH5GUNF9a1ohLvOEkvjv/q30MqnTx+LKVljYJ/4uAjwWc0fJj8+Z1rKBaE2Z4qSDFnjOp1c7mJV4iJ39Xie5qMW33RRtIk+a08L2JtNLAxGBZQd+o9TIzRzw9I81qFr9qVJfHTK7AaTyxNrmwCuJDlWcvgO81kGX5DMrnODVoYJdkomrXHt8y9R/TNb9RGfdaE5K5Z39G+02qv0B8uB1avZRcXsb2Yx73sNzQ8Emy64QwTvUGW/WItOsBoAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=juPSnogkDkH24Xz3ggCVxHKwxeebqYhhM54eUSELhdc=;
 b=rKfOdXw2Pi6SMnDKBSAoaRZs7R6JLsegq46w1OqQFJaEFton3Ps0TRPG6QVAZP7CdpuJIq0hl/6GoyV48UQ7U4S4/qRkGtIZbGbM/T8NAhYlv03BSN7v5HLicC+6v4JhPy0YOmywwJObRziqZYg5DzLHjR3DCcuZFzUUYKXqru9pCs8mNg2qa+vBtMCiKImzWxcQ7TeQx+SJTNb097P8hr7qedw2RdxWjDGoVHiLERkQWFCubv6kf7GsOq7BpgCihdi1dL+Dg3BysOQG+cX2CetjvNFU15Vg4NXVqO3SbKK/xWFXf7k3dZvMuinTFMsKFxD4H53O29Up6n+iFZrtdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=juPSnogkDkH24Xz3ggCVxHKwxeebqYhhM54eUSELhdc=;
 b=Ya265F+1fqbP3AEsuhA8ChGhAs+9QXGK4RdKocscGAwWAAq79zB57Jne2uEBnEj8OMPn1XnZOOVE+CK48zCxQ6rXnZMkI+O0tY81EeJMjRdGBQvtfc3COzPSR0LCVBRrj4rAdAKRys0KjODCXoU9LOPDzGneyVhFiV8BqvDgBI8D6EmWSUHrTmPEy1CBsjOPZmIFdLOxDtsUDzBTRqz3gVdObBFmam8odQszv8q4x4WZJrLOaPMa80geHVObAokFtlFJIkBt30M9zDCSsjgsQCDin+muemwTY70zLffjsvZe3klGlQno5xbyuhX02keimokQ/PidSfv2UTWUhpQbOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Wed, 8 Jul
 2026 14:03:21 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 14:03:21 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Jul 2026 23:03:17 +0900
Message-Id: <DJT8V05POUOC.1F5BQDTMHCTLF@nvidia.com>
Cc: <dakr@kernel.org>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <jhubbard@nvidia.com>, <ecourtney@nvidia.com>, <joelagnelf@nvidia.com>,
 <apopple@nvidia.com>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <kjaju@nvidia.com>, <alkumar@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <zhiwang@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>, "David Laight"
 <david.laight.linux@gmail.com>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 2/8] rust: pci: add sriov_get_totalvfs() helper
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Zhi Wang" <zhiw@nvidia.com>
References: <20260701062622.3499033-1-zhiw@nvidia.com>
 <20260701062622.3499033-3-zhiw@nvidia.com>
In-Reply-To: <20260701062622.3499033-3-zhiw@nvidia.com>
X-ClientProxiedBy: TYCP286CA0181.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN2PR12MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: f20a4c75-4408-4eaf-20ca-08dedcf9ab1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|10070799003|1800799024|18002099003|22082099003|11063799006|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	+fYO8+PNKYvrNZO1OcOPZAOlq/SdRHhTEp85RUhEKETCdkbmCwnHNU5QJlDtDshHdHpYWwRXeubKyLiwwQvEewnkqesZsybLS3PXPUGY8AmQAvIfsRwM1hqr1GOBWDEKk0bOy7nTfk8Z2qpUjg8fGzBsuhoxICbOqS1e/i/BVNk3TKxu7MkIrHOQuljsZfBGmZY8r6hV+y3MGlWSmJGtQdjmDfPdxEc5sTDilTV1D/PIL93Ca6k20QY2mi/VmKIW5KaKpzWveRW1EU9pnw3exp9Mie0t7a42RtYZoYYOOIIFeb+TbJu2PtekVlJvOt73N+66fNRZz9r3OjL/SKvVEPPZ+AZmx7EteUX4qtaW6eqhHqxGfd8IrSsybx1mCnYlCN/2nYhMW3aJ2/bsu4r2jahlvRcnMTp4ud801kpaGx5V+2EownJHPT0WXhsudUnD/q50ylyo7JOg6tRaeQVs0jyIVFgqNfdEyJRd2m0RnVAbexP5IRe3whqD0/OgwvsIuAyxYADhpnj1iszhlDf50O9yrpeMsz9vt9NkWW8nfKa4SddzZD79awN+6264CnXgV09dhi1McZx7sqUAyntsUyCFWNYie95blHbO6CjzOlrcnGDP7beUw0lkf8q/0MxGT8i2mhfDHZGYZzQm7YIg+Mfl0u1kJQWW8HRSxaK2OOo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(10070799003)(1800799024)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUdGZkhQYkdPdzBBclBWU2JXeGNiU1ZEZFRpb3BvcXFoNWJORjl5SU9aRERt?=
 =?utf-8?B?elJzSmc3UVg5TjVtb01iL3IvNGczenNoZ29SUmtCeXZscjV0ZkF3YjV2NE1W?=
 =?utf-8?B?aHFQNCtZd1Y1dm9yRjY1V3ZVQmRaMkZKbUJaUkt1NUIxdGxSTjlvUDNXWDAv?=
 =?utf-8?B?VjdSSWlabldsRy9FYW1ZMFQ1bUtPNS85VktDS0VLZXFVRnpBTWE2MmlhcE8w?=
 =?utf-8?B?ZWtyNXhjZzEydDJzT2RxMGszeU9LSFNPaDNqd2dTNVRidHJ1K05BN211bHlH?=
 =?utf-8?B?bmJ1UTJsbmJEZ21uLzRsMnptdGdiRFNOZFl2bndiRVZMZ0xaemcvb0NOQzZ0?=
 =?utf-8?B?bGpPNkxYZldxRHhDejI1dnlMS3p1bnpZZzlRZlFiZnVOTkRhVkdFZ1dVMS90?=
 =?utf-8?B?UVJkQ2x4aE1zUlhLRGszTDNUaFpLM1N6WDFEQ09EK2dTRDNSblJteHJZT3dp?=
 =?utf-8?B?SFM5d0N1TjNkSUoxOHFPQmNmbzdWQlRCV2N2dzdZMW1ReHFXdTd3SEwwZjl1?=
 =?utf-8?B?aEc1SXBqdmE1d29IMVlvTlFGYzF6a3ZzMjFLdjRUUGlhZnUydDNzMVRWbzBn?=
 =?utf-8?B?Ty9aS3FzWCtKRnhsUG5BMmNTa2UzSVd3a3lxTDNsQ2tjTUtNNHVRRDJWSmhq?=
 =?utf-8?B?QkFsL0grZ2dOazROYUtYWTRUcXdteFVEVDhybVh2UzA1TmM0VkdwczFmc01J?=
 =?utf-8?B?dW1xZVpITkZ0bkVaY3ljUkJZaCtVa2RydzdVQ3RUZlJKN003b2ZMYkF2U2E1?=
 =?utf-8?B?L016eUQvekd4Ni9FVzREbU12emU1Mk5JZGVHQnM4VWwvVGFXdk8ySlpHOW54?=
 =?utf-8?B?cWd4QllNK2NmYm5zY0QwTmxrK2xqbXJqYm02cWdpL21NeUZsMmJ1dVZ1dzlq?=
 =?utf-8?B?VkxXSTZzRC8xR3N5aGkxcGczMnFaekhSbENCc3FoRWNZZHZFVVVISkd2bEwx?=
 =?utf-8?B?MWZEN0l4UjRTZ0FLak83SkllNHdQOElKQVl1dk0zUVQ4S1BCQWxDRWtKamhh?=
 =?utf-8?B?d2QzamZ5dnk1emFWeEpzRFFkODJaN0UxblJkU0luVnBJNCtsODF5SElKcEhp?=
 =?utf-8?B?a1laTTQ2R0NUTmV4QzBnT0NxZ1kxc0V3VW45NzlxM0owOUFGeEZLVldSeDBu?=
 =?utf-8?B?VzVsYXk3em53K2FxRzd1ZUIrUmFuQ3c4NzhSeE56Y3JzZHJ4eVhicHV6Mk8z?=
 =?utf-8?B?TU00bFBMU2lWWVF3cFE5UTRCM2JvUU9ERlp5U3FVUnQ0V0E0OU1pYmRJM1Zh?=
 =?utf-8?B?dzEzcVM3NzRzc1JrQUpxcEVnaWtTbVhLNXlGOW13WXg3Mnh0WlR4VkYzV2Uy?=
 =?utf-8?B?cVhwelFkS0cxSXdUYloySlFTeWtEd0pzVmlsVzh6VVdxZ1YrR1lONGtJSHZT?=
 =?utf-8?B?d0NLWUJWd21QRlM5ajZIc0hEb1VtQnc3Q2dOTG5HQkR3THYydXBmbUhMWDVa?=
 =?utf-8?B?OGk2RTdseHpzOFJUY1lFNldNOU5uaXF1MVVnSHI5VG13NXZxYUZQWVNaVm9v?=
 =?utf-8?B?Tms5RzFnYjcvQzVKMzFQQWhhOEVsUDFrclJ3R00wRDlDSkVkd3JnVU9yTFlr?=
 =?utf-8?B?ZW02REVaaTRMZ1BVTDdJSC9wdVdGZlJvYm5uMmdJbkc1dXVnOFU2R0RqNFFy?=
 =?utf-8?B?bkdZMEZrSklDOEo0S2xMRGthUGRkb2grSTRncER0Ynlicm84RjE4ajNLUUhI?=
 =?utf-8?B?U0lNaWpmNlJGVHVPNXVqOVJZZmhYaUVzSzloTEpnMVYxbTFuMjlTWFVZREJN?=
 =?utf-8?B?RlBRYVg3MlZmTEsxQW1HRzd2OXVCL1V6K09VMnFBZ0MrdE5hUkdZQy9zcnZ0?=
 =?utf-8?B?SFZ2Q0Y1bDF2RWFpb0wrVVA4Q3NoMHMrczNySVZ3dlhMdzFDanUycFdEWncr?=
 =?utf-8?B?VGo4YXlqMnFzdDNtQjczS3dNNlU4bmd4N3dLbW1GU1VtVnRuOUVGYzRUcTJM?=
 =?utf-8?B?TUVqK3gwWHh3c3lyeG56Rjg3VHFQYkVNRmkvTzlCdkUvbXVNZ2VSMzJBOFc4?=
 =?utf-8?B?OHJ1MTdqU3p6RjFaUlhxNDU0QjFVc3hzVWZpSjZrTmhQcVdhTlFnd2grMWhU?=
 =?utf-8?B?TzJ4T0NqNGltalNKTEY4RVFGMk5keGwza0dtZmhxM0lkTWlaWStBd3FjQWM5?=
 =?utf-8?B?dDdUR0RxTmFuWHJjNE1yaTNtNjV0aFZWeEdTM3laTFB4NHhjUVJmWk9XejA5?=
 =?utf-8?B?SnFnclR5VmhHTE5XS0p2Z2RPMkhjZ1BrK3dCRHFLaXVIMlYyck9LNEkwT1ZL?=
 =?utf-8?B?U3lKQmVNdXdqOExmRWU4eE9ldlNCczFiU21YVE1OK0xNSmltNUlkeXF6WVo4?=
 =?utf-8?B?WWlhR1ZsNnlBUEx3K3hWbGwrZDBpV0I0aS8vNmIxUHF3dEY2dlB5L3J4Vkpj?=
 =?utf-8?Q?esf7LQbMp4+CLyTTAE1ghGrR3ampLjtBZM8Zt4xWqbMRi?=
X-MS-Exchange-AntiSpam-MessageData-1: 1/b2nOIZo2Qgow==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f20a4c75-4408-4eaf-20ca-08dedcf9ab1a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 14:03:21.2459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sXVyUG63zWZ5v49HH3WnxxI4b005S7MwnNv4aUbZfxDAQjzA11gt+YT76tW8WWF7x+VrAIyPlpGzeTK22pqlOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360

On Wed Jul 1, 2026 at 3:26 PM JST, Zhi Wang wrote:
> Expose pci_sriov_get_totalvfs() to Rust PCI drivers so they can query
> how many SR-IOV VFs a device supports.
>
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: David Laight <david.laight.linux@gmail.com>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: linux-pci@vger.kernel.org
> Link: https://lore.kernel.org/all/DJHPRE4TGGT8.BUTMYOF5YE05@nvidia.com/
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> ---
>  rust/kernel/pci.rs | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 5071cae6543f..21c51981c02e 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -450,6 +450,17 @@ pub fn pci_class(&self) -> Class {
>          // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev=
`.
>          Class::from_raw(unsafe { (*self.as_raw()).class })
>      }
> +
> +    /// Returns the total number of VFs, or 0 if SR-IOV is not available=
.
> +    #[inline]
> +    pub fn sriov_get_totalvfs(&self) -> u16 {
> +        // SAFETY: `self.as_raw()` is a valid pointer to a `struct pci_d=
ev`.
> +        let total_vfs =3D unsafe { bindings::pci_sriov_get_totalvfs(self=
.as_raw()) };
> +
> +        // CAST: The C helper returns `unsigned int`, but the value orig=
inates
> +        // from TotalVFs/driver_max_VFs, so this cast cannot truncate.

nit: "from TotalVFs/driver_max_VFs (which are defined as `u16`), ..."

With that,

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
