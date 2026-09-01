Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010067.outbound.protection.outlook.com [52.101.201.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6E4396B96;
	Tue,  1 Sep 2026 10:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788260305; cv=fail; b=anvr09iEw14K9LrQDtne/U7OVLaqctYhCB/D/bA8rWLBQKv0Uhyv8bo3JN6+zCu/pME0tWKHopl6M/4v0z0Ax/wQBNsR5gUQXnw7uRtsrVEmZu0YsRKKTW71tVnuPID1LoMn8esDIO0F32UA0CWpgqTY00yHLDUDuCb4ynfCbQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788260305; c=relaxed/simple;
	bh=1ziDnqlkeoWRnxMS99oPc9+WQsTGhpaI/q3/LPYKVaQ=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=DvWw9R52vUbRAoYlAGePOaQkgIfMhL3fWi0TooQm80tNAPUilCu9iDXfTpZ7JypkCmbhj1HRKoLgpnUtMt6Cy/K6ykYmYuLvhm3e7HhyjlHc2AtAShwXJyMX33UJKYUAz7CcWtkxcsJTcd5zL0yTSiauV4+Z7mf38c2ZS5p3Iww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jA4q6P3p; arc=fail smtp.client-ip=52.101.201.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jA4q6P3p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GNkhX0rzK5GlT94IYXsazXd+AOZYEYSEhP/fN4jAlCNuiNDrdyAvkw9FP1LZQ79AS5GczB8YI6WTpI8GqkA8icCmFCX/Tto5Apnf9OI2pB9OM7Jr7RAvRQDF6lYj/PpdsNrHLl6Bx3eK1dRh9k/+0N0b46Kz4a2q4lBAzgtfpKBiWLIfSSaaiF1a+hfwNE+JEyqt2pHtFmiV9onnSAjac3qv8qxpISupncIvED52cV1pxBHcCzBSWFyPb+FEXZSNHXe1t7fjkJE07kb4KGunI0Ckq2YoNgPOdAvobSg/Gk+gg7ScSAuUnSmlUe/uNTZ0qrG4DsqKN/5SfWHH5z2uYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIDou/msh2J0sz14j+NEAxNUEPyQ6qTy3ovESNKZBwg=;
 b=ZOyv74RxBJX4kcczX+NAxqhMdr1CrajR1UrfkbpjrlT45CwnvUb1iY37hUJpYNcL9Ud77hcCBjxPzAm5c9FXKre6PSB7wYdYVQDM6S1dxt8zThFZ3sE5kK3DEz82CkYbzbOrXuIZoZI4b06QtZRSx3PkArodZqFOjsSxF0rfBRYlud34nRDY3WoQozvZ1f/h4T4SmOGkH13ym9KGT5LnoaL+Yi7gBDQOVdUZNkYkHdp7bAVTVpt9EitT/T7YbOv2H125BVIAyNK0f3bkKX6DzLdukBiAbidiQkXBbYwi2XmtxOGsO3z1YlnvsoVjEvFQaMWAG2VygNq5TnpL7AkmVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIDou/msh2J0sz14j+NEAxNUEPyQ6qTy3ovESNKZBwg=;
 b=jA4q6P3p+Rq2PV8kF7hxy8kuVS4Z6a5dF0J/AThSF9E2dt+E2EhSeOFthXpyiSX4BdlOVcmg/CPO9w7Bu1lxQ6QU8+qKYVIJqFsyVO6bWzem6yRRri+Jud+EqXqIjGXRCU5aZDZ8bV6hvb7t0IVi0fM31qdQdUiDFo9q4igT9/IzdGUa7n0GLODCTOy/UIkVh3utpTfiAsH6zQL6YQ5eqXLU52zHdHtXTk8ENJ8/PlAiT956PsFDT0TcVmAlwvusyy40GLQHoMCczUjZB4NccxqrN/IxMTi9vnPLm3pZwEo4OFMEQpMvQSoclDrodBX9WHnz3MIvOUZd+yZsLj7zKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by BY5PR12MB4147.namprd12.prod.outlook.com (2603:10b6:a03:205::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 10:58:20 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0382.007; Tue, 1 Sep 2026
 10:58:20 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Sep 2026 19:58:17 +0900
Message-Id: <DL3XDBBHXKKV.G9P6KRSSX1DN@nvidia.com>
To: "Sophon Zhang via B4 Relay" <devnull+aiqubits.hotmail.com@kernel.org>
Cc: <aiqubits@hotmail.com>, "Danilo Krummrich" <dakr@kernel.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] rust: pci: reject IRQ vector indices that do not fit
 in u32
From: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20260901-fix-pci-irq-vector-index-truncation-v4-1-f94aa6932fd9@hotmail.com>
In-Reply-To: <20260901-fix-pci-irq-vector-index-truncation-v4-1-f94aa6932fd9@hotmail.com>
X-ClientProxiedBy: TY4PR01CA0080.jpnprd01.prod.outlook.com
 (2603:1096:405:36c::15) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|BY5PR12MB4147:EE_
X-MS-Office365-Filtering-Correlation-Id: b2ca5079-661f-46e3-78f1-08df0817ef20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|10070799003|366016|6133799003|11063799006|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	CxwYNyMmHZpRIWn4yddmcR7IwntlRivOcNXkJhB1wAIzb4aWU0xbwOGTf5SEHUYM4S5D9zJu5eG2QMt6G1c6K7gh8Osy65LZTz4akmEagi4E3r9PqkdTuADWbArOpujKv+WvlPTex1nTchcE51cJFOaSpzCMktARMprd2a/XO1P9ESrhx5SGmNfovI6Lh63MUQveNeOJfUFf0fBUQUoB0D0hVLja8z7C5JUZhRJ2V9wEkgaPMjFCyQTtSpiram3T6Vi/Y3uzUH16yM0H5LnKlOYyZ4I/uXJlltYljDMXvSFpKmGKP5x0nxVehb7eyHwlleKoxEZ+FEu7IuX2+Y9wubHCOw7hrPwUBishUwdE7YxwY7uLHfhprPno7iKx6ixTZKyXX8ViKtFoEvDeJtnFR0/CVg97TE/CFijFnvbhziaI3ybD1IcydnptA61RDljhWbiFx5ow/dg5UJkpsZN9VB9l4Z2cPC/N7isjJ4TkYBmgI+3qT0oi0R8BZpSDinmpLKFBWrEYfCrOEi7FDxDEK3Sk9FEgSxJL4WMACwnmT37VasQTAV/wHi6q5lPmOXWx65OcX8pJ1aP6BsN1e0zrqVFhMJ+Y3c0l/l0wjUVSGjNhwBXTaitW0g6oxa/118zAA5BRmRKzSUaoB+DIiTHFkFUvwc42VV07xgMGlUEoGus=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(10070799003)(366016)(6133799003)(11063799006)(10067099003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2lTZGlKWDFWcXUyYmJkQUI4bjBFaUdBMzlEb1g1WHVaME90YzZFQUh4WFBK?=
 =?utf-8?B?QzNXMm85aHpLeGlRRWhiMW15YUtVNkZieUxJSGJrREo0TkpuUXlOYSsvUW50?=
 =?utf-8?B?YWZmWjhlN25nbENNVDhlbkFJNWVwK2hUZjUyWXpJUkQ0L3B3OHJpVGlBRUtq?=
 =?utf-8?B?T2VOeE1RREdKbUhzVk1JY2ZGOE8vd3c3aHlRakkyMFNSQ2h6ZnFmWWdxQmxF?=
 =?utf-8?B?MHRnMnZuN1JDQy9obGdXVStXZTk1RDdmbzRQVHNGVlNKaWJiNHR3RUY2K1RM?=
 =?utf-8?B?bExpRHZBZkp3NkRCemkzZUg1d251ZEc0TjhKKzlLMmVoY0t1UVIvRkV0aGFK?=
 =?utf-8?B?L0hYTWNnNkV2Q3grR0U3ODE0QWRHRHhtYTB3b25uTWtDZm5YWGtPaWhuQklC?=
 =?utf-8?B?ZTY1U2JJWWFHaFppa2NtNDQ5QWNtK0Z2cTdsMXNXTlJQMVRmaWZyWHhNQkVX?=
 =?utf-8?B?TC9ONWluM1hFR0twRmN4MklHMEx6dVRmSkZVaUd1S0xRZnA0ODA4aitvZUhm?=
 =?utf-8?B?b1VoNGJrczFwb2ZxWnMxODBwdytFblhUcHJwY1A1U0VaRTVqV0J3djFwMTJl?=
 =?utf-8?B?OEZNOFFMbWZnM2ZqUHcyUUJxdTQ2bVIvQW9udStlbW1reHp5QmxIWkxUOS9n?=
 =?utf-8?B?aWFvUkIyVDdGZ3lqNEYxc256Q3hyNnF5QXFmNmdwUXVZUGhiQmFndysrcWlz?=
 =?utf-8?B?WFRiUVhBSXZpZitONkZ4cldVSHJYWTEyTFk1RXNTZHZxSEErUjBmZGdrV2Y4?=
 =?utf-8?B?eUFlb3dBaDE0MXlQZmdNY1dIcFZObjdwMGM5cjc4RkU3V0h3dlJLWE9oZWxR?=
 =?utf-8?B?TFkzRDdDRmtnS2lUTi9YcWF4N0pydUlXbzlNWnNOc2IzVlFCMGdyZVJpbWJT?=
 =?utf-8?B?REo3V0pyTmwxTG1JcStSOE8xQUlnK0lmMXVpd2lVdzB0MStoZ0JYZmduTXpu?=
 =?utf-8?B?RC9tYWh1SFR0QjhGYkFUcE5nMGMzT2lSaStpWnlmM2pkWndRL0V3RE15QVR1?=
 =?utf-8?B?cU9XbHpad2owU010NitibU1EQ2JjdUR1Yjh6ZzdUcUdlRkNkTmlWVmZPcGlO?=
 =?utf-8?B?Z2VEeU5nVTcrTmZQdVJRYUkwMzhUUDhVdVlBQmhHSnc0WWZxVVJrMnF5eW5w?=
 =?utf-8?B?N1VpNnF6NUlYMVdxZXBrd2lrd21vYVpZenpkY3dGR2V2TDNHazhDN09yK1hx?=
 =?utf-8?B?c2ZMZlI5VEg4WnNtVVY3MGNYZVpWMjJrcFEvZUh0VWkrSEFGYW5LdzE1anJp?=
 =?utf-8?B?VjdlYlpnQzIvazhKaXVwTkp6K0paTFI2MDB6eTEvZTZ5NW4xeUlsTkkxN3FL?=
 =?utf-8?B?TDUydE5HQm5mb0lVR3RJMUZ1b2E3M282bHh4REFxdlV2S0pYTS96NnNnWEIv?=
 =?utf-8?B?SXRKajBISlJlZXo2dXQwcjA3eDVJVDc5NTNwYUtrcEdPSitmU3pNQnhVeTBk?=
 =?utf-8?B?SVFyVzFBTlhycTNqQlB2MHFYVEJDb0hWRVhvdkdOTUtON0NLeVl1YzhSNFdP?=
 =?utf-8?B?VGFrclNuVUtYK2lCcmVwL3U5M09LQTlQMXJqTHZWeGxPcGwwUm5oUmdka2Mv?=
 =?utf-8?B?dnFuKzNTV21DOWRGYUJPN1NyNGJjb1FPci9YNlp3RGRZM251VitWWkU3UXRy?=
 =?utf-8?B?R2VWM0RUc3dTa1lsd1MwNGVTMGd5Snh4Rjk4c091VkVnTUJmVFRSUU85azZI?=
 =?utf-8?B?ZTIvNWk0bE5SaTVjNi9WbVZFOTd4T1hiWUtHSXJXUkoyZWViVGduMWE0N05z?=
 =?utf-8?B?b0F4VGtRUFpZTXQwT2JCa29yL2NjZm5ET1ErVEdxQllveDA2SGw3Q2xHcFNh?=
 =?utf-8?B?M0l2aTZpbGRVYXRuWmgrS2ZsRmYzTmszOU9LSU1rVkg0N1lXZ0RrVEMzRVV5?=
 =?utf-8?B?bzZLNzA0RU5GQVU1NXpheVp1KzBXS1lVd0RYakw5TllQYVEzU3RuR1l3NDJB?=
 =?utf-8?B?R09jc2NmbXZ4TnBqSjc3dU41Q0NybGNHM1BlZEFkNU5YalVFVXhVUVRHNEIy?=
 =?utf-8?B?UmF5T0NUVE90aGUrSWNYNkJwNksrZndDRFNZM3VkSWdRdTF4UGxsSnUzM0M4?=
 =?utf-8?B?VUNYLzBYb2x6SmhoRjdLdDMrblZzTWh3UVNKckJVdDVmSEVxVFhVNFVWUSs2?=
 =?utf-8?B?LzB6djVNelNkdHRleXU0Nk93NzVXb0NYcGszNmxnYWdqOHhRTGVDWGFIVUdI?=
 =?utf-8?B?Um5SSFQ4dlNiaWtBcklaWGlRWHR5UHVSSUR6S0ZoT1hQL3oxQzBsZTFaQzBO?=
 =?utf-8?B?VzIvcUk5dDVXcGZCQUlLS3JZckh0WVR1cDQ1bG5QaGU3SXZneFlNeDRwSFdt?=
 =?utf-8?B?YUV5S1NVWnBVRzFQWmdTdG1IVHU1TWtoYXpHU21HRFhOdHFyQ0hBZWw1eHpl?=
 =?utf-8?Q?FNuHxBc5lRII7uhsxwVtc14XW4wgHogt62G4WIxT6pcuk?=
X-MS-Exchange-AntiSpam-MessageData-1: juitIwJQL6rv/Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ca5079-661f-46e3-78f1-08df0817ef20
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 10:58:20.1459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rsNXDFEa43k04v4Hz+hqQZ89mlF6Kjgs0fzW1rT/xyMNjx8oAYujtaOmEaDPRSsgKX33kBNB18Dupi+6XJyEug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4147

On Tue Sep 1, 2026 at 2:09 AM JST, Sophon Zhang via B4 Relay wrote:
> From: Sophon Zhang <aiqubits@hotmail.com>
>
> IrqVectorRegistration::index() accepts a usize, but pci_irq_vector()
> takes an unsigned int. On 64-bit architectures, casting an index larger
> than u32::MAX wraps it before the PCI core can validate it. In
> particular, u32::MAX + 1 becomes zero and can resolve to the first
> allocated vector.
>
> Use a checked conversion and return EINVAL when the index cannot be
> represented by the C API.
>
> Fixes: 2fb7755b0a7e ("rust: pci: resolve IRQ in index() and embed IrqRequ=
est in IrqVector")
> Signed-off-by: Sophon Zhang <aiqubits@hotmail.com>
> ---
> Prevent 64-bit Rust IRQ vector indices from wrapping when they cross the
> PCI C API boundary.
> ---
> Changes in v4:
> - Drop the explicit length check in favor of PCI core range validation.
> - Use the existing TryFromIntError-to-Error conversion directly.
> - Keep commit trailers adjacent and narrow the description to truncation.
> - Link to v3: https://patch.msgid.link/20260831-fix-pci-irq-vector-index-=
truncation-v3-1-a2103084d20e@hotmail.com
>
> Changes in v3:
> - Check the index against the allocated vector count before entering the =
C API.
> - Keep the checked usize-to-u32 conversion and document the C-side warnin=
g.
> - Link to v2: https://patch.msgid.link/20260831-fix-pci-irq-vector-index-=
truncation-v2-1-4030ea7746a9@hotmail.com
>
> Changes in v2:
> - No code changes.
> - Link to v1: https://patch.msgid.link/20260831-fix-pci-irq-vector-index-=
truncation-v1-1-d63217d99b67@hotmail.com
>
> Testing:
> - make rustfmtcheck
> - Not build- or hardware-tested; bindgen is unavailable in the test envir=
onment.
> ---
>  rust/kernel/pci/irq.rs | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/pci/irq.rs b/rust/kernel/pci/irq.rs
> index 6741046ec1c0..22e2cdf82a21 100644
> --- a/rust/kernel/pci/irq.rs
> +++ b/rust/kernel/pci/irq.rs
> @@ -151,8 +151,10 @@ pub fn irq_type(&self) -> IrqType {
>      /// [`Self::len()`].
>      #[inline]
>      pub fn index(&self, index: usize) -> Result<IrqVector<'_>> {
> +        let index =3D u32::try_from(index)?;
> +
>          // SAFETY: `self.dev.as_raw()` is a valid pointer to a `struct p=
ci_dev`.
> -        let irq =3D unsafe { bindings::pci_irq_vector(self.dev.as_raw(),=
 index as u32) };
> +        let irq =3D unsafe { bindings::pci_irq_vector(self.dev.as_raw(),=
 index) };
>          if irq < 0 {
>              return Err(Error::from_errno(irq));
>          }

That makes me wonder, shouldn't we make `index` take a `u32` directly?
If that's what the C API expects, it does make sense to align to it
instead of forcing users to make a potential unneeded conversion if they
already have a u32.
