Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011008.outbound.protection.outlook.com [40.107.208.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D3652940B;
	Wed, 14 Oct 2026 15:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791991032; cv=fail; b=Ecn1tD71Dj5RMfFnm8UB15BHkSbOKFJdH5cY+fP8V3QGFNYzjItCRfB6CQP+WzVk6DPaXkPbhLi3/rHRiYu6RbPL5uJFY+c4TQ4z87r4t8psCI5MHzcrnh7Q12o3Ahj83WPSgtWt26rdV9nATMwJtgkF7z1K2lvxTAyxcUc3eKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791991032; c=relaxed/simple;
	bh=MMwxn+WeJQPTVPdj1a5fEPVVtrTSE1y7lJC+Y04HtIY=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=Pm4E1OWef8jMLGbbJLv5XcxOe8NUrIkbdUiY7LzoaZQ5kK0Pjrst4LR79qJyAT18uXmEteU6Vi+lJ7Toh+5i7mUWl8QUbvGYsvdSZ+fRRyYqihBsb7RAaazMcjHQIdr1B/vlLoHjRpfH2Lmc7nHR3agmakQkWdgDypEBDj4r65k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PDSpc9G4; arc=fail smtp.client-ip=40.107.208.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PDSpc9G4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KGEpyV2I+/JVnpTdbqO1MnrIyZaWujFpT4kgJdDxgA3zfbNnrTC0dJZXLdwL2RXVB7HetOH75/Btu4EbcwwRpNgcbOV2Vg8B7AHm0fXBArvUdf4Mywm73J5nmS3sgZD+tDH0224rHvtmYMJfrLlFWxMlmFZKJYNXhG6peHirlhgOYVleE6L/UxETIoT87HSUnVM04B55kFsf05aMf0JAPj18V4qKn0mtgpY8rzs1vRrVmbsl4UjbmoOFo82u2Ek7LD8QtX6ko8F7IcY6mSNJESYp6aBTBu4UGkOSnRT7nTRSqMkwDFUkfTI5KbZcP/NzSoXcF8sNfElEs6jkIr7PGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Cda3uK4OrXEKn4pie4NZyavTt8jBqRLYy9G1A3ST1g=;
 b=noWNwOLbCScVMXTKx8A6bPy3AxipDfVJa79e+3CdZZ/s5q868UMOFSbkTnjxVICeF+yRyXHRSn8SdUp36j/nJtnbWc++Sr3Qi5mr6VWhNq+FzaMTnfSeugL0qlF/c8BkEcL3Y6ZowPU4NdGC7jllf4SVSWwa6q0Qic5mU9OhVhOd7vj9NsGMHEzlta7Gh7lKXGu3XaftcrZwP6CZeDkW/n7ZygMszK1lgM4hPHUglJEI8hLpXOTPmjkAluIALTD2hPYwItu5em77njubu9K+27HUqNpRtyAiuWdmE8X3aBfQnILM1s4mT2YVE4rKFmxZ6DmiXqnCDLTziS8Mu9mW0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Cda3uK4OrXEKn4pie4NZyavTt8jBqRLYy9G1A3ST1g=;
 b=PDSpc9G46OveT+DPM3uhG6+/K+PfYn7gPVypzoeYivIzyYBTOtV8wsbYtq5g64Mqm3OG5zoCb+V/F7fepdCJEXI6bYnYCRfyhQ02qzqXuoCzo8eN8zxdA+dnaCWE2ESWLovBjHm7PClsazQLcU5ZsdyQSWtT9+x2tjpnvNKoUIeCqcBawHlSvZRuGio9X4I42HmobYN+aDQmGaqrlsRS4n5rhE/MLLwcRvpWHw+LXFMStRHLfYM41IAZB7iFcwTQoOhjLNTalSEQqAaLTcvCKeRBGqzqke6o3fTi1DShFVE1HA41QPs2PTVOeHQOseOCy1fLYkrloAPF4ie5CS9N8A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by PH7PR12MB5880.namprd12.prod.outlook.com (2603:10b6:510:1d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 15:17:03 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0522.011; Wed, 14 Oct 2026
 15:17:03 +0000
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Oct 2026 00:17:00 +0900
Message-Id: <DM4NSU7XQTV4.2ZUEKRQAI9CXK@nvidia.com>
Cc: <lukas@wunner.de>, <linux-cxl@vger.kernel.org>,
 <akpm@linux-foundation.org>, <Jonathan.Cameron@huawei.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <jic23@kernel.org>, <bhelgaas@google.com>, <alistair@alistair23.me>,
 <djbw@kernel.org>, <linux-pci@vger.kernel.org>, <wilfred.mallawa@wdc.com>,
 <a.hindborg@kernel.org>, <gregkh@linuxfoundation.org>,
 <alex.gaynor@gmail.com>, <aliceryhl@google.com>, <benno.lossin@proton.me>,
 <boqun.feng@gmail.com>, <bjorn3_gh@protonmail.com>, <tmgross@umich.edu>,
 <gary@garyguo.net>, <ojeda@kernel.org>, "Alistair Francis"
 <alistair.francis@wdc.com>
Subject: Re: [PATCH v4 03/22] rust: create basic untrusted data API
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: <alistair23@gmail.com>
Content-Transfer-Encoding: quoted-printable
References: <20260928011123.450800-1-alistair.francis@wdc.com>
 <20260928011123.450800-4-alistair.francis@wdc.com>
In-Reply-To: <20260928011123.450800-4-alistair.francis@wdc.com>
X-ClientProxiedBy: TYCP301CA0065.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::10) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|PH7PR12MB5880:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a6d11d3-3e20-4912-f0d7-08df2a0633b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003|23010399003|6133799003|10067099003|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	3aaUud/ZClY/2dCgJ2rtH1HBa9PiPCtsv9dk6QqVj60R3JIEsfbYJsuHN3S/vIJbfgNCkRXcpTEgafatzpiYx/EVVz3xNlGP22YsEInNIPoyBPb7TL7gKFHYL/EL/8HV5lpmdun2RpcT9mxcbkdil6cz504u5F+/00U22+gmGiduQYOktv3Zaa7yBj6/CDdOx0iKvvhNYufyh8XQKti/zCcjMs2AOq9JV54BMDBnlvjV1M57Bu+7wCr9yloiWo0bbbtV+GPHRSjQmnj6rJDv7BToi4/Vkn/o5IGhuwHLNMGPgYAOG8gxyc8F4TBBVGlwo39hd0wV84y9rG5GwuWxc/v+We3MrVinq156VFw/SQGilaKQNpwLz2VCdBq35WQX5mzTQnwAodDrTqIaq+M9hosd0Cd1k8U52pg+we355/Wrv/7KxUN1Mr5m2AJS3VnogSTNVSdATUjGEYdtF0NlIIr1lXtnr8CGPODX1Ylbk9bR101ey0AQJ4tkXXmX1efPAGS5KbjXhw57qEsrK1dLwAVsdIT5N/CQ6TL5G6x22MqSFv2AVFUCTbNNRk0YofJla6DJVfUBA532DZXQEMJs9alkpoiGTP7btBlfNg5EP7hMxn46SwVEGNAzVWtVJ9zNN427W+XEK3WMtoE7LDGePMiv31NLgH9Vdv7dPZ0qaTE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003)(23010399003)(6133799003)(10067099003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEIva2NrSVJOZ0dJeis0WWViTm4vUUZHOVpmUmU4eWpyZXZkUXp2L0wrRjJo?=
 =?utf-8?B?ZFAza1l2YXN4Q0U5eEh5Y2NIVi9rTVpoMThlUkZHOGlkM3ppMUt2TVZCcE5a?=
 =?utf-8?B?TkRzaXdZa1NNU1A2ZW9oeDlIRm1tcUtxWHVSTFZOd242YUl5cFZ3M2cwNUlT?=
 =?utf-8?B?RFJ1OVBLWTlMOGcyby9DY2s5SUp5SFFpclpTeTlzWXVPT1ArNUcxRHRMZXkw?=
 =?utf-8?B?TVJGUkRXaTNzZUN1UHNsdGE3ZDJZUXJtNHdTeFZGdE9qK2lzekdLQXhiZGRw?=
 =?utf-8?B?YlB0SzN2YWJFVnlkUFREQm01US9VZEtSV045cEpYU3lDLzdjMjhxdnpaTDNp?=
 =?utf-8?B?Mi9EQytoc2g4NXZyYTBoUnF1RUQ4NXZsWVFMYm5WTUhHN3lxY0cyZlBqZHUw?=
 =?utf-8?B?dVJmZlJSRExNaW8rc1lrMFYvUUt6OENiWVFuMGZDbUlRZGxweEtFcXZuT0dK?=
 =?utf-8?B?MWVrVGMxMStKbFNDdkJrajVuazFBQUtBZGV0dzRJb1JYQUlPYkhSMk04eHQ2?=
 =?utf-8?B?bW9ZeFpUS2t0cXQwNzViNnFNcURwbXU2SW1TbEpUOURmWFFmL1ZUTzdxYU5C?=
 =?utf-8?B?TVhhdlV6QXd3dFc4TVZhRDJZNzR2OGNkaEx0T1BBY28vcUl3L01HN0NJMjJO?=
 =?utf-8?B?UUsyc2NXSVBsVThJMm90NU15enllVTJCbmxVMEZDSmt1NWJzYTlxQTAvT3ZU?=
 =?utf-8?B?TnRtVndqcTV2MzNCZkFUcVVYakgxYTVFaVVKQXh5WmJEcGJWT3dvY3lOcXhO?=
 =?utf-8?B?S0xvVWtQSzQzOEpQSEJUSG54ejZLTnB4ckgrcGJtZ0E2ZDNnMnNxRzZoK3po?=
 =?utf-8?B?NDMzM291SzMrVUZLRm1jTGExZnA4djJLcWZZMXRRZ25wQ3I3YmhhL3ptN0lm?=
 =?utf-8?B?RSsrYWxLaVZSdHdlZWpZdHZ4d0xPbVd6RktVdWhoczRSN2lKRnVwNEJVQmFz?=
 =?utf-8?B?dXAvRHJXWlpKdGY3VjZtQ0QyM2dGMkhmSzNOMzF1b0NMU2duT0VCTHVvQ2F4?=
 =?utf-8?B?dm55dEhoMFBEalAyRDV6Rkc1QURvc2U0aGhMUVZmYTFSVzRDaGtKak9kNWI0?=
 =?utf-8?B?KzIzSFRnQ2ZDbDZFNWtkRmxtb2J2NCs1WUlXZGgwdDVxVlhiZHBha0txSlBR?=
 =?utf-8?B?aXVxVzJOZTRWcHRKVjUzUnlnT0Q4RmxZV2I2eDIySlBHcjgwdnkyb1doSjYx?=
 =?utf-8?B?L09BbEZuVlNUNkhlcUhxcjhWV1NBbjZUaUtwQlJBY3ZzUS8vSFNTaUxNQjNx?=
 =?utf-8?B?a0Y3Z3Vsb3JTYUhTZm1IMmZjb2lpNUtoeTd0enJZUUI4dk1oUVV5VGZ6dFRY?=
 =?utf-8?B?djNCbGEvcFcrUGJ1UVpQZFduM0pWNnRPTUJpSVJUR3hIc1U1aksyQmhsMnJv?=
 =?utf-8?B?aHdzakVUS1hnMDhNR2Rwc0FKa0hQU1dNVkJHbUpsSkExalZBb3hGUmptYWJa?=
 =?utf-8?B?ZWNSTFR4ZklFZkdvTWVmYk54bWdwUHFWL1hxWlk2QWgraEloZmtIVDd0MDFM?=
 =?utf-8?B?WFpyTmxDY1haTmRvUzJLWUtQanRUOW5GcHVSNDRud25MWG5ySzZySk9mUTll?=
 =?utf-8?B?MlNjZnlQOU9Tb2dwekh1bnhEajlkV0tsanZOdG5wdkdDbThyTWFKNzlST3dJ?=
 =?utf-8?B?S2pCeHZqTXplNjFFVFVWYmlTYlc2MzR5OS9PeHVSck9JOWlTQkp3UXM4WU0y?=
 =?utf-8?B?MzFZeUpHVWxTemIrYzQrdXkrbFJ3YkVkdWZveG0zWFhXT1pVejl6K3FmejYx?=
 =?utf-8?B?WlYrcGYyYXBDNGt3d1djUzhUU1hJSDE2ZmVXbmptVmFCNW1GWVhBNWk1UFdm?=
 =?utf-8?B?Z1p3RGJXSU5LSEliNjdWeWxOR2NucjNFRCtzVFZZY2hZdGdDYThtS2R4R1c2?=
 =?utf-8?B?UEdnTGRWLzZQa0hDWmJRSU1GZXQ2RjZ4dXAvWGZWbDZPOVd6S0JibW5IR3Jz?=
 =?utf-8?B?M0FOM2NNWVMyb2tqR05pSjZOMkJvUmRiQTJVWGQ1UXoyRVg4eDE1YzNoQUNp?=
 =?utf-8?B?eXZOa2ZSS1h0OHg1RjNDSksvOURnbUZBd0JFTTdtQVNrT1dxNGI4YURlMVJC?=
 =?utf-8?B?cUdRc1RiNUJGWm9BUnc0dDYwVnprTUVsR1V5eDNTN3RMY05RUzl2Nm1mR0Rx?=
 =?utf-8?B?T1g1c1IvYkwrdTdybTJZS2hVMnFVaXdndmRnUjkzbVBId1lLTGNIczhVa2x0?=
 =?utf-8?B?aWJhazJoWUpFblA3RHNvOG1HWjV2VmFHNENhRWh6aXR1ckU2TkNKNjRkdEtt?=
 =?utf-8?B?OHdCcS95REFOOFZFOUc4bFdiczJvKzUwWDdtNGc5aUE2RGpUdWYxNXNkb0pU?=
 =?utf-8?B?NGZ5djN0ZHJyVGhpcE5Ta01WVjAvT2Z0QytpVU9GQ0RoTHF4K1ZEb2tFVnF4?=
 =?utf-8?Q?fJfwb3S/YklYi6uNxheHDkmDdekHThD7pI9qNKmTwlhS7?=
X-MS-Exchange-AntiSpam-MessageData-1: nqBCrjIJY4mRYg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a6d11d3-3e20-4912-f0d7-08df2a0633b2
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 15:17:03.6880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FPxVjBEiRXch27a798ZHTC25Bu0G2IzuD/+IgvyC5ps1oUY9YlAY6MZPEr5D5FHcdNo89ugb5fQjGE9Nn6RpwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5880

On Mon Sep 28, 2026 at 10:11 AM JST, alistair23 wrote:
<...>
> +/// Untrusted data of type `T`.
> +///
> +/// Data coming from userspace is considered untrusted and should be mar=
ked by this type.
> +///
> +/// The particular meaning of [`Untrusted<T>`] depends heavily on the ty=
pe `T`. For example,
> +/// `&Untrusted<[u8]>` is a reference to an untrusted slice. But the len=
gth is not considered
> +/// untrusted, as it would otherwise violate normal Rust rules. For this=
 reason, one can easily
> +/// convert that reference to `&[Untrusted<u8>]`. Another such example i=
s `Untrusted<KVec<T>>`, it
> +/// derefs to `[Untrusted<T>]`. Raw bytes however do not behave in this =
way, `Untrusted<u8>` is
> +/// totally opaque.
> +///
> +/// # Usage in API Design
> +///
> +/// The exact location where to put [`Untrusted`] depends on the kind of=
 API. When asking for an
> +/// untrusted input value, or buffer to write to, always move the [`Untr=
usted`] wrapper as far
> +/// inwards as possible:
> +///
> +/// ```ignore
> +/// // use this
> +/// pub fn read_from_userspace(buf: &mut [Untrusted<u8>]) { todo!() }
> +///
> +/// // and not this
> +/// pub fn read_from_userspace(buf: &mut Untrusted<[u8]>) { todo!() }
> +/// ```
> +///
> +/// The reason for this is that `&mut Untrusted<[u8]>` can beconverted i=
nto `&mut [Untrusted<u8>]`

nit: missing space: "can be converted"

> +/// very easily, but the converse is not possible.
> +///
> +/// For the same reason, when returning untrusted data by-value, one sho=
uld move the [`Untrusted`]
> +/// wrapper as far outward as possible:
> +///
> +/// ```ignore
> +/// // use this
> +/// pub fn read_all_from_userspace() -> Untrusted<KVec<u8>> { todo!() }
> +///
> +/// // and not this
> +/// pub fn read_all_from_userspace() -> KVec<Untrusted<u8>> { todo!() }
> +/// ```
> +///
> +/// Here too the reason is that `KVec<Untrusted<u8>>` is more restrictiv=
e compared to
> +/// `Untrusted<KVec<u8>>`.
> +#[repr(transparent)]
> +pub struct Untrusted<T: ?Sized>(T);
> +
> +impl<T: ?Sized> Untrusted<T> {
> +    /// Marks the given value as untrusted.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::validate::Untrusted;
> +    ///
> +    /// # mod bindings { pub(crate) unsafe fn read_foo_info() -> [u8; 4]=
 { todo!() } };
> +    /// fn read_foo_info() -> Untrusted<[u8; 4]> {
> +    ///     // SAFETY: just an FFI call without preconditions.
> +    ///     Untrusted::new(unsafe { bindings::read_foo_info() })
> +    /// }
> +    /// ```
> +    #[inline]
> +    pub fn new(value: T) -> Self
> +    where
> +        T: Sized,
> +    {
> +        Self(value)
> +    }

This constructor is probably useful (although it should probably be a
`From<T>` implementation?), but is also moves `value`, which might
perform a copy on the stack that we will want to avoid if `T` is big.

So in addition to it, can we define constructors that work on references:

    pub fn from_ref(r: &T) -> &Self;
    pub fn from_mut(r: &mut T) -> &mut Self;

So we can pass around data to be validated without performing a copy.

While we are at it, we can also add slice variants:

    pub const fn from_slice(s: &[T]) -> &[Self];
    pub const fn from_mut_slice(s: &mut [T]) -> &mut [Self];

They will also be useful for the `Deref` implementations below.

> +}
> +
> +impl<T> Deref for Untrusted<[T]> {
> +    type Target =3D [Untrusted<T>];
> +
> +    #[inline]
> +    fn deref(&self) -> &Self::Target {
> +        // SAFETY: `Untrusted<T>` transparently wraps `T`.
> +        unsafe { cast_slice(&self.0) }

With `from_slice` above this can become:

    Untrusted::from_slice(&self.0)

> +    }
> +}
> +
> +impl<T> DerefMut for Untrusted<[T]> {
> +    #[inline]
> +    fn deref_mut(&mut self) -> &mut Self::Target {
> +        // SAFETY: `Untrusted<T>` transparently wraps `T`.
> +        unsafe { cast_slice_mut(&mut self.0) }

And this becomes:

    Untrusted::from_mut_slice(&mut self.0)

> +    }
> +}
> +
> +impl<T, A: Allocator> Deref for Untrusted<Vec<T, A>> {
> +    type Target =3D [Untrusted<T>];
> +
> +    #[inline]
> +    fn deref(&self) -> &Self::Target {
> +        // SAFETY: `Untrusted<T>` transparently wraps `T`.
> +        unsafe { cast_slice(self.0.as_slice()) }
> +    }
> +}
> +
> +impl<T, A: Allocator> DerefMut for Untrusted<Vec<T, A>> {
> +    #[inline]
> +    fn deref_mut(&mut self) -> &mut Self::Target {
> +        // SAFETY: `Untrusted<T>` transparently wraps `T`.
> +        unsafe { cast_slice_mut(self.0.as_mut_slice()) }
> +    }
> +}

These can also be implemented identically to the ones above.
