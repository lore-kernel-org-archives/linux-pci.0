Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021115.outbound.protection.outlook.com [52.101.95.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71574442B21;
	Tue,  1 Sep 2026 16:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788279564; cv=fail; b=r0hQIGqnLEETV5OB4kMdsAcgGmmKlcIeRzGyIYAtbTjlYFZcHa54alKTyltBTRDVKNgrDWSEjaXEVvwtTuVQXq4eKCjWCQepmD8lHY8tl4g1tXd1NRBpdmZ44OHQZvpoezL9oD5qEGRE8yvCVtE9yoHmY+GcElTnis0Ejc3XXWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788279564; c=relaxed/simple;
	bh=a/q6GUAXRmD2FCH5mgs906A/2xopuhglllrEewfUjaw=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=EzwT31hcbcpmCFc8SbZh/lDW1LOyj+9cD6BiajqN0VyAkGMDvxKtUrtqlI2x+wWJj5c1kQXOzh6nFkoJyS7Tyn6ZueSqRQEzJE52y0ODT9aO4HTZWjgsmaxVe9qPY80UsNFe7IfiSG2Pye0/FmDgetRNZkZE0KrF7SKIRXErgTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=pth/quYz; arc=fail smtp.client-ip=52.101.95.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="pth/quYz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wTm7r9ems3yydEe2T8l+R/YqR7BydvZyiqMmI/HbfpfEMAFSqgh6YS+R4j2kW47at15dxwvaYpL5rdQCpxiNs36V5M/YTQy4MBFxuy5Ao7FKMW/+LMzwY6EXB6L7UXDHCCIPqjLp72A2mbqD25O70BjKRRcR3xz9HopcFwocSGj9BUBX9Q9asSTh5Fa681jUYvMrnFr/ODvrROf27ULWGpX5y07VJhreC+yr6xZ1z1tIPRohjkMjmRwf6VkIla4VyLEEH64aHbwMPBFvFTyZB/Hc28lUU4BlK7rnRjhKOlg942cxFzD1bA4et6FugDD7af/rUFTXtO164wv4fqtswg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XetSbOcmX1N2QZJVz9JX22t2OfbbbGwPV3cCDwDv/VU=;
 b=EKJ1PuMH+EicpPHpmKzeQa0uwpADja+ReODy31MCYkMBLQMS9DTLpmxjkQbVPIc2q9frTrisqrKx8hLHSk+1GINqVstqIfI7HzbhV7d6f04YBMR+d7mOMjRiFLJd/E1ezhZVhaoPwN1N/P8ZBLnzj0kYUS4oGnuEdCCwwXjPKFqNkLexIke8OBoa/LwiZeB3N+KqT+3KLnj8hH8hXdF2KrjnHSZWBoJCpqCSZ0etXGxtYQjs2xnQZSCKd/+f9Vqb26CHceYabBfKEZGGekM7l95fwx7WaYhxe6qqLgaBa0yBcuvxLOaPr41KElJ/0FB/60F0ThBq5c2gawDDC9GyTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XetSbOcmX1N2QZJVz9JX22t2OfbbbGwPV3cCDwDv/VU=;
 b=pth/quYzy0hC6jpFFQMO/HYhCmipiS5UHZT64G9FtdLpvjb0/aEWEA7UcregStHfP/fkqv7dtFuspFxJ9/IO//mIDYdSpvEicT5FTRH9t4DZ+S7X+XCfkBq2aQRGaJ+n0DLr+nEm2eA4jYDdiv73AuBhGGFXXwrLXrCm+kr/F5E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CW1P265MB8782.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:279::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 16:19:16 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 16:19:16 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Sep 2026 17:19:04 +0100
Message-Id: <DL446XEUY9RO.3LHKZ2GYE6Q5E@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: <aiqubits@hotmail.com>, "Danilo Krummrich" <dakr@kernel.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] rust: pci: reject IRQ vector indices that do not fit
 in u32
X-Mailer: aerc 0.22.0
References: <20260901-fix-pci-irq-vector-index-truncation-v4-1-f94aa6932fd9@hotmail.com>
In-Reply-To: <20260901-fix-pci-irq-vector-index-truncation-v4-1-f94aa6932fd9@hotmail.com>
X-ClientProxiedBy: JNAP275CA0023.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::16)
 To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CW1P265MB8782:EE_
X-MS-Office365-Filtering-Correlation-Id: 17834247-a990-49fa-5583-08df0844c4b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|10070799003|376014|23010399003|366016|921020|6133799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	whX1SeQpgXsjcaM41weQbWvgfqqP2Jc1lQXQb9lvAXd14IPhEoT2uapj8CI05flHxrubWUh6MjBZaIHnq21VTX5MFrevy6JKE2/WtjJM5uuE011SYW1jJ+uf7mDrZw3ALEUmqK+jq0CLobdT+scna6CAFN5AEKGHwv/E2dsD6qun3S4s95kZ2DVC17wTu4D8xdSRgOTJwe6L7UqtP5UW92nJJqqLDzH1ro+k0PynJEKvATkt9GM5yr7vy3/IWc9scsS92pR7mBryHd9hC9eFnEzt8rJB4N5WPpqY+60Ca1vxZYkpvlIEi0ky6Sq/suKolP3eorJbzO56uCz4p5n5gNucFMM58lmpAcIQ9qXaSmv+RlP2YqOGDm3y3ILTPBWqMNDM1xnwm9UhKpT8CQrBYqd4QSGv9HyuTLknHVdRVcNagH+aoTP4gpp6sDtDLYoR6cVUWFQb7mgBl2wb+Rbr7t92OVRwk5VnKQP64X9ftwPQhKngDe6Fzz1dvc/UgY07Iho+U9FS0+PUWIQnaGVGttacd/mKR34ShfEDInUqta4JxOeJWiKEGv1dCgTs1CGboDuFFqkHUh8u5Ryfab95QhgtXDCWGXeuuxhkQEpsj/V3YcdTSSdvrb0TY7lCMgjUsAJwU0M2q6I3ZfJEx6t0XIUfVItREYDxrsIPYM/l8eY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(10070799003)(376014)(23010399003)(366016)(921020)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VE1CUDVCSEUzdGdvNUJ6bjlNOWd5Q3BQSmE2Q29hMnB6K2NjRjl0VzBTUU9K?=
 =?utf-8?B?c1dzTTRvQVI4cFJsRld6QVpMQTVGbm9wSHBkNXV1MDVzSnNLMFNCL2V6Ulls?=
 =?utf-8?B?WlM5WlN3ZGNZUzhIa0l5b1pha3B5NW0veHNVTnhMSzgzSG5mbG5ub2puejFT?=
 =?utf-8?B?OXZOVDVXNDZmWkZRLzhYQklEaXFvV3I1ZlJldTk5bVdwYzNJN1dYM1ZzVzFX?=
 =?utf-8?B?SllhYVJwdUxJMUxwL050ZUc4MkVscjZjZks1dzVGTHpHRGNzWjc1RUszbm15?=
 =?utf-8?B?b3hCYVdBYXl5bjdyWkVWT0FqdDhwZUhLTzh1VXJsckVkOWR1dEJGcTJ5dTU5?=
 =?utf-8?B?WDE5NndMZElucWNqZjlqcmJhRDZkM0lvVk51R1BmbjN5Ukp1VDZjSFRDOVNr?=
 =?utf-8?B?dmtSeldtYVJvaFNEWVhYZVEzdC9nRVBuWmpPNmQvS2ljWEdkclRtR2poSE82?=
 =?utf-8?B?NXV1NkJqWnBkbEEzT2J0YVNNREdYQk5BZmhJY0VuRDdQZE9pTVA4QUpGQXZF?=
 =?utf-8?B?OWlYdmNpd2U0bUk5KzRvcUlNRWlRcXROR0liTWpsa3VpYWc3RnVxSmh2aGxQ?=
 =?utf-8?B?WUNyQllxa2lVcjdUU0dmajRpMGk2UUkvNU04RE1Xdld2dy9UZVJFWjY2NHRz?=
 =?utf-8?B?bVllMThVM0dPNm5qeVZKd2lPb0QxbUEwcm1ITlFXQ1daQ1luV20yZHlHem9F?=
 =?utf-8?B?S0dLQWNQREsxMGloTHVDTmptTHhKR284QVlheWFLZmlkMkVLZktpaDhxVlRy?=
 =?utf-8?B?SXA1UVc4YmttRHBQcytPR0FpdnlKTm5Mcm9VL2k2WXhyN0xOODFZdXNIaXlk?=
 =?utf-8?B?R2lnV1c3OHgyYkJOMHUzUjUrQ2pnL3E5NFNrMUpuUnNuT01DWlB2azBheFli?=
 =?utf-8?B?bmQ3YkhNODNhZUNUMXdzamxROWZ6RDdKbkE4WGRDZ0RSVExEdEwvMWd0a0Jj?=
 =?utf-8?B?MnJjVnY5bWlBVWhWSkpLaGs2ZkNHeDk0VnJld0RkVzNWbDBydVpqWlZEN29F?=
 =?utf-8?B?aGZXamlGdCtuNGNWTzZMeEQ5ZGw2UW10N3p6WlFUTTNIeTBaVWdTT3B1VDBs?=
 =?utf-8?B?Ly9LZ3p4bU1mZW00NG90RVlVNFVueis3anBQNXV6R3ZweWtQcjhycFFiTnNE?=
 =?utf-8?B?UWhiamtsK2JSSnVWdFNGYUVXMzlvb1kwR3cwV3IyRC9OQllpVjZ5VXZVL1dV?=
 =?utf-8?B?ZVBTVEloUVo5L2Jjb3VUMUUvRWpCN0FoVVZCK1RUU0dOdHc0R0dnQVpTTkVH?=
 =?utf-8?B?enNSY3JHQ0dYVXlCdVR4NFJhWGcrMDF5OEdmUmhnS0dlMGRlUTVVMnZRUEww?=
 =?utf-8?B?TDhjK2lrYm9VYVdzTDRMa05CRXBQUmVmVXBjVXVqNm5KVzl1bERHT1hHVkxU?=
 =?utf-8?B?WTRYZmtzZWp1TXRHR1o4OGo3bndiV0ZzWXZhWU9pYThRYTU3dEo4WDVxNEtk?=
 =?utf-8?B?VHhHNm52UCt5OUhGbHZIa2hDRmd3NHVIVDdSQWhtQmhPVzAzaUpMbE1KS1Ir?=
 =?utf-8?B?ZGQrZHpXbEhZdS9BSnBqZnRoTUt6Q1ZDNm5vUlFURmJiTTlUdm0vbHJybVFL?=
 =?utf-8?B?ODhET25HZy8wN09UOG9uNGU1QXNBSDE5VC9DTERLMkdhWHlUVDNoa0hRUDNY?=
 =?utf-8?B?b0pDUE5WVW9WVmlJcE1ZcWc2VlE2V1JCcUJBMnFIOStMOGpENXhrcXZ1OTRo?=
 =?utf-8?B?RU9VeldCUDhUSjAxL0RxempsSUNsM2FFc3ovWW5uY2YySXFlOU9vY2w5c0Z5?=
 =?utf-8?B?R2lzQmJkY0ZvWmRKNGlhem5paWRaY3FTWVFwK3pmS1JLaGtLdCsxUW1pOTlE?=
 =?utf-8?B?SWhaZUF3M0JJVVBsUjlObFNQa2NvMmgwUW1mQjFFQ3ltVXhreWdLaVJTeGxN?=
 =?utf-8?B?dHlHMUdOdEJzanBUeWJmUkRSY3FMZ0FyN3FVaG1KVXNaZFMzN0VRQjRMdXVm?=
 =?utf-8?B?dXNuM2xXWWFCNEdjOEM4T05FUExsdGdTYnpyOW9ib25JVDRqcHpja2M5UlVp?=
 =?utf-8?B?d0c0T3VFK1MvZFNFQXFoN0ZKeXN0OVU0anVmWmJyOXFRZXAvQ3d4aWZISmVJ?=
 =?utf-8?B?QmRGN0NQR0U1UFIxTE1Pcll6RUFWZmpLck1ZM3kvRUVwampDMUhWYVBBQzRu?=
 =?utf-8?B?bnl6ODUwSXo0MVErSW5qSmtxaktmUG9BVGRLR3VmM1JkS2RUVlhHNENFdDI0?=
 =?utf-8?B?Z1l6dkUrampLZytpY3k1VVZQQ3hXaS9rQnVESmRHNVRTdkduNlNWVHlQRVZu?=
 =?utf-8?B?cTNad2tFc1A5MVpsYmhyMWdSWTVhM0srWW5KWlEwWXB0Zno5OGVqTEhWME5s?=
 =?utf-8?B?Vk8rVjhjdWJaME1sMDJkMENmNU13SWxoL1p0blBTa3l5QUhBSGpQUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 17834247-a990-49fa-5583-08df0844c4b0
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 16:19:16.1596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YT46YhR/uQoX/z7bz6edLDsE1GxEg0W/fmn9b9c+rHIQWjou9mW0+jKl45h06nsiTScRiGlUEQ/EmDGzg5RhAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB8782

On Mon Aug 31, 2026 at 6:09 PM BST, Sophon Zhang via B4 Relay wrote:
> From: Sophon Zhang <aiqubits@hotmail.com>
>=20
> IrqVectorRegistration::index() accepts a usize, but pci_irq_vector()
> takes an unsigned int. On 64-bit architectures, casting an index larger
> than u32::MAX wraps it before the PCI core can validate it. In
> particular, u32::MAX + 1 becomes zero and can resolve to the first
> allocated vector.
>=20
> Use a checked conversion and return EINVAL when the index cannot be
> represented by the C API.
>=20
> Fixes: 2fb7755b0a7e ("rust: pci: resolve IRQ in index() and embed IrqRequ=
est in IrqVector")
> Signed-off-by: Sophon Zhang <aiqubits@hotmail.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

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
>=20
> Changes in v3:
> - Check the index against the allocated vector count before entering the =
C API.
> - Keep the checked usize-to-u32 conversion and document the C-side warnin=
g.
> - Link to v2: https://patch.msgid.link/20260831-fix-pci-irq-vector-index-=
truncation-v2-1-4030ea7746a9@hotmail.com
>=20
> Changes in v2:
> - No code changes.
> - Link to v1: https://patch.msgid.link/20260831-fix-pci-irq-vector-index-=
truncation-v1-1-d63217d99b67@hotmail.com
>=20
> Testing:
> - make rustfmtcheck
> - Not build- or hardware-tested; bindgen is unavailable in the test envir=
onment.
> ---
>  rust/kernel/pci/irq.rs | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

