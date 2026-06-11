Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022106.outbound.protection.outlook.com [52.101.101.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB111426ED6;
	Thu, 11 Jun 2026 16:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195315; cv=fail; b=I5NxWfn0qctsRya4y/7L1s8cJWT9sig6RmC85UxE4ICnHjFR9YDyA7C9LDGI3PO9JQtnAbfSsv8NbInTS0wAA4XCVi29H5mOqvTvHw6cgpiYyfNmomX6gs182bqZeuUU/HnyPqmvGwvbPHC1Wu5Bk0GAIsYenHYO6Ybar3jy4bM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195315; c=relaxed/simple;
	bh=K6nQV4iI8FfcvJD7Z2NsruF+J8mGKyD8IQYu0km/f30=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ry9oAh45k0Iu324G6/WE9C2MmHbeqlOu/HEBBYq2ULhViismzDEXypTPYWv/KV/4LIA2IjR9Ks2a52eDAmbfRn0srzRFqk2GUg2AVpAUtUkjqHyYpQfK917u/WbgpRqmfufImiUPNgyYICIi3Kv4RjX+1ioUS5YHnvnb26WGADc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=PLuelntq; arc=fail smtp.client-ip=52.101.101.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="PLuelntq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOxxMkLSP3YlX+ssXOfmXvNsC8o1lZnIOIjXBcXoPt86oPXcEOwVtylrMNZbJRx3x5mxk3GaJxhbtR7iWIpQ9ArhMFjzfZOvMYRnRvghyvup1cbcg40SxyfU7k+165RjsaFGjKbq1jH5xh40tIt3tBXeGHLbNEgYIhBjmSzO1QoRiBO0BNv/pBmrkMiShBgQMDSj8HAF20bvxd19Fn7y1P3sUxOSBWOUoVwobI8yB1LhR+Rn93SYNUFHiIC35UhAebjbnorYzHEl77r9C+nbO72PickzVS2C0jyNPuwtAP90XGinmzU/1H7JaGAo87k6O++doVSzUWJyr26FxRAVIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBeszMFrKEUnSD+0j3WKKXUfZgc0TI4EmSEva2w3I5U=;
 b=nH1ga9dcyYpv+3u4zA97LPJcwKc6N2q3CrN2Ng6rObtLmUyPUYCVRvN3dX7VkaHvVBKJSAbHXcB7IG6XZvuXsC2X5Kyx4Mk30jA5Bh1NscCVrMYQa7PfdHyKv/ySR2pw5sdZQV3/MmGF8QqqDgI+nBR0s8UDynj8ETJxepnCkp0XA+xPj+l7G1aC42favUwIWm1L/7iu7DUPCYRBxdoFp1U8+D5EwdV1Ux9t7KchJbzoyjGPgVEjg4iHFzHJk8klF9+edorjuiemhJE4N1ecDMz2M8KojIje2LBowWm7MhTYrvsOCl9ukXGhL4WVmQ7DEQVZPxio6rNwERNiEHuWTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBeszMFrKEUnSD+0j3WKKXUfZgc0TI4EmSEva2w3I5U=;
 b=PLuelntqXah8PFLfGUQSgMYrqG+MUULA6inx8SK8SPsMl8dom+ENx1xWcmk2HCAO49JWlPi6XkoVr7eIchNFZqcpmAnlR+Jk9755XtzKFt+4tUigxFxkjWG9cI3EhslF2fSIR6wg54cZscugmcB0+E+kaCTHhQXUgkaDlnDQVaA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by LO4P265MB6525.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2e7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Thu, 11 Jun
 2026 16:28:27 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 16:28:27 +0000
From: Gary Guo <gary@garyguo.net>
Date: Thu, 11 Jun 2026 17:28:10 +0100
Subject: [PATCH v4 08/20] rust: pci: io: make `ConfigSpace` a view
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-io_projection-v4-8-1f7224b02dcb@garyguo.net>
References: <20260611-io_projection-v4-0-1f7224b02dcb@garyguo.net>
In-Reply-To: <20260611-io_projection-v4-0-1f7224b02dcb@garyguo.net>
To: Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781195301; l=5854;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=K6nQV4iI8FfcvJD7Z2NsruF+J8mGKyD8IQYu0km/f30=;
 b=4m0X7pr+O7bMeachyLVlXvBsixzwEPfoXt12+sixaTZrlIpcIuhERem3wqwWocnswuKCYXQzR
 cKftY4AoFf4BgShAGvBMBtTWRyZaBvmRmSFibOoXycsxfg1eBdf8k3X
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO6P265CA0015.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::8) To CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:27c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CW1P265MB8877:EE_|LO4P265MB6525:EE_
X-MS-Office365-Filtering-Correlation-Id: 3edd8112-50dd-4448-f8eb-08dec7d6775f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10070799003|921020|6133799003|56012099006|3023799007|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	pqhFWZZXzG2P4qHkXh0ufh18Nsx7khDsynTnpwu58NZ+bXOeccaYXMFIMZKk/OWioPbzpY2H9zoDigZA0Q/VhF6dc+h4Pj5vtTnnaoO46uI6o8dRGQLrbQzFzlWTL0pZ2jsq7tCVSYZa3q7yJQKxCW33CsXIxHUGl4QdWwpXX/YC8byq9IvfmizUkdcdRCEOrV4ejTV5efQ8avmxfTbvBMHH/zHpRnIDyZ47A6sULbnvxOOtaLoh0b53zLHMsw5egL6AKCSEizgyy6AhDwvlj41V+WhWQTAppggz+ZroZ5cBDSxXhG5Vfho/PgfSwOGqYhbm0oSO/YodC7peWOFC3jFBja9+YG4+kneyN8fPUcHAkx/q3MBePV30L7ZDQ2MNwXSDT4aMt7Z03XW9QUUxQWTphrDOoLCVHQB+FiOKHsDIcApAJj2WsMoAim7d34lphTEKjj7TEUg6VaKmFzFtKks8um6Bdp5UA7Bma58lXHzA1HZQKYT0l3Fp+sIgG5CWMz79yZd/UiLTzszYXTNvJOmtQTjFFiV+g1pzRTXU96QWJbFTYw8LqSQfLCiYP11W0c9Z+t9b0qRV/YFujyDIJifsq+Ukh5GcxpJ76zEJnp1LWdIeRykyZU3LERWMLG4rAaHJiiZSafZjvYjltsrLI+a/Odu98GCmqXht7OoZPPKOraxp4qy7a34PShFEfa9WJxhVTfaex0bKLPwmEo+q6fI4dgxkYdRGYKOBgFBSHaY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10070799003)(921020)(6133799003)(56012099006)(3023799007)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZExXeDRsdXU2eG9WNm9JNm5reXN5MVBQeVlSd2tEQ0IxVW8xMzVOUUJ5WWNx?=
 =?utf-8?B?Q2RwWUFleGkzMU1ic3RpaVdwSUlwMk12TmVyUDgvWElSS0Rra25jcFFReTk3?=
 =?utf-8?B?Mm5Vcmt2T1BjbERPWFMreFlGT1V1eEk2ZURDbTRSd2hEUDUyWUk1M3lxeEpX?=
 =?utf-8?B?QWZML2dDcDdXUGxESWNRS1BlZk93Vjd6aVAxRHlkYm5NRldrU05XbEN5b2NT?=
 =?utf-8?B?SjJsYVBvQXFYL3lMV09JZGRLSHVMUU92ME90QWttSU9NT2JvUTVETFVlZmp4?=
 =?utf-8?B?cnNqcHNyajM1T3AySFFja2g3NS9mWHdBQ1lUTVh1M1g1YXpBSlpoVmJJQ1RX?=
 =?utf-8?B?cTVqcEI5ZUVMYm5TU2syUkkxb2FROUM5Q3k3RmVubm5Tc2JaTjFTMk5VSDZX?=
 =?utf-8?B?V09NYU5DUkhSTUkzekNKSWszUFJiNmdOU20vZjBGbjNkNUFGTlcyaDIvWXBw?=
 =?utf-8?B?TjJZbXh4NGJwNU1wTXFodU40dVB6SUlOblZvUllCOFpEOWhhZ29kczdYV2FV?=
 =?utf-8?B?QjRQNTg1djMyVUZWdnZHOVlBc3NiaEozNThwTVR1VkptYmQxUU1LQ2xQWTVK?=
 =?utf-8?B?VldJQjJGOHN0MlNSQXNBQStnSVVZaFJWaFVNa20zeFljRDlFSW1xdytaeWZr?=
 =?utf-8?B?bDU0N25sMnl0WW4veHkxTU94UE9OeUxIc0xRSEQ2S0xQTFJQMzUrdUE5SDZM?=
 =?utf-8?B?bWVhN2JvVUptUzgzV2N4NjU1WlByZGdvcmtwY1R3aDJLU0c1N21STkJlMW9T?=
 =?utf-8?B?bmlwSkdnc3NXWFhwOVhqL0taSkZrY2swT2VLMkhQbEJBYlBvc2NIRkExMmJi?=
 =?utf-8?B?RHhUNHJPNFMvT20wbWlyc3FQS2F2M0U1alp1b1VFQm45cWdCeERMcUNJeUE5?=
 =?utf-8?B?SUE0cEtVRlZ0Uk5wYitCaDVSWE9jelduTjZ1S3E3b201ekRzVkd3SGh3MHlZ?=
 =?utf-8?B?NXRzRkhYT0xZWDhhWGFhSlpiTXBjeU1sMm1INFJkZHRvVkhveHR5eTA2Vjc3?=
 =?utf-8?B?OGNJTmN6RHNERUZ6TnhVazZPaDhvTXJkYW9MQ00xNTk2VkZleGR5RHI0elVF?=
 =?utf-8?B?SjI2K2oza2FHd3BpR01QQ01rd2Q2VDFjbFMrbHVycXUrWDdscm50djNvY0NL?=
 =?utf-8?B?bE9CYm84cWpEOWhzWUQzNm1PaWU0VndEejJtT296MVZwek9PaGE0cGhnaWpw?=
 =?utf-8?B?VXl6OU1HeW5IVG4veGVWQk9RaFp0dlRFWVdKaEZoZ1FIMDkwWUxPZTZqc2pC?=
 =?utf-8?B?Ny80QXVSZlVtYUE3c0t1RGg0cGZVdDUrendMUFpzODNBTkNQTGFQMnF6VEZu?=
 =?utf-8?B?TFVjV2hWc1M1N0hpeXFjemVrRklWM3NpZ0JOVmxlOXZSdG1mT0ZpeG9zaENz?=
 =?utf-8?B?MFVMNkduNUlwWFk4TG9DcVJBdndnWFlSQkMyeDFNQTU0anpsRElEcUU5RnBl?=
 =?utf-8?B?QXlEczVTUDE1cmZTanV0UW9NNHprS3ZJd3lkMldKQnpWeUxYcFJ1TlNNS3F0?=
 =?utf-8?B?K3ZvZ0ZBS3ZDSEc2ZXNiWWZZdDFtblhFSTVVNEp0UnpsbTBRek1kNmplU2JI?=
 =?utf-8?B?UXVlTnhzVmxCbU1pN2lNL3NHOFh3TVdWdVJEMVcyNDM5eWphcStmRlBha2lX?=
 =?utf-8?B?NkZDbG4wek80c3BuUkNpR2RjVFhBa1laK0dBdlNLQUx2VkE4b09GQ2JNVk80?=
 =?utf-8?B?WkdBWE9rQzdjRnNDbWk0dUZXRm9BYm9hcXZxVzFHdmJWQnVTZFJCWDhCNFJ6?=
 =?utf-8?B?bnR2akJ1cTFBcHUvQzlReXQwRnhTRGJXMk0xVDlkZTlKa2h0NFlVSDB6aG8y?=
 =?utf-8?B?bndBYy9KL3BNRDVqWHpIZHMvOXBCZXd3bklTSHVnUFYxYVNlMnRZY0hGVWUv?=
 =?utf-8?B?bG15SmM4OGR6Vjc2RFZQNGR5bnhHZkFsK2FkSkw1VzZFQWVqL0xnZnBnemgr?=
 =?utf-8?B?QWFMU0pBSDI2V1VZd1pMRklKVUlLeHBiaG5PdlVKYTBPcHBSVTA1KzUwOVZP?=
 =?utf-8?B?dk5URStxWFFZMnVYcDI2TExVQ25LTDVhWjlVNS9nNHl4TzlhMWNOaTZtWDVX?=
 =?utf-8?B?b1ZVRlBTcnp3V0diSzZENGhOTkYyL29pNEZHV0hlU1BZbFJuK21LVzYxd21v?=
 =?utf-8?B?L3dQdFd0K1BESDJXdkl3TlJQZ01vQUJyT2tkdE1PVU5UN0tMY2RLWDZseDRy?=
 =?utf-8?B?YkZGWTlCSUUzMHFGOURZL3dRTk11ei9Id09tdzlMY2RJd1gySzY3YlhINXJ0?=
 =?utf-8?B?VkJxN3NsVDIxcWxSMm50WmxVSFRUVTB6b2cyVUJzSXhoMFAySWd3MmhJRjFB?=
 =?utf-8?B?MjRhc0JiUTMxQ2E2OTVyRlpNNkVDVWtMUWRSNnZzeVo3U1JKWlhndz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3edd8112-50dd-4448-f8eb-08dec7d6775f
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 16:28:27.3856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ScyWeBjDq36HRoQGZxtbuuxitcVrTNwxHEKKMj7MYo+XLcriF2vpRUCiZA/3IvzSGrNpFiYrl5n03jRfbGwHbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6525

In order to support I/O projection, we are splitting I/O types into two
categories: owned objects and views. Owned objects have a specific type
that is related to setting up and tearing down, while views can have their
type changed with I/O projection.

Things like `IoMem` or `Bar` are owned objects, which requires setting up
mapping and cleaning up on drop. On the other side, `ConfigSpace` is really
just a view, as the resource is associated with the `pci::Device`.

Remove the `ConfigSpaceKind` bound on `ConfigSpace` and make it a generic
view. This means that `ConfigSpace` object now represents a subregion and
therefore encodes offset (as address of pointers) and size (as metadata of
pointers) itself. The full region case is still supported with offset 0 and
size of `cfg_size`.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/pci/io.rs | 64 +++++++++++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 28 deletions(-)

diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index e0acb62f58a2..89f4bb483a7f 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -18,7 +18,6 @@
     ptr::KnownSize, //
 };
 use core::{
-    marker::PhantomData,
     ops::Deref, //
 };
 
@@ -53,33 +52,42 @@ pub const fn into_raw(self) -> usize {
 /// Alias for extended (4096-byte) PCIe configuration space.
 pub type Extended = Region<4096>;
 
-/// Trait for PCI configuration space size markers.
-///
-/// This trait is implemented by [`Normal`] and [`Extended`] to provide
-/// compile-time knowledge of the configuration space size.
-pub trait ConfigSpaceKind: KnownSize {}
-
-impl ConfigSpaceKind for Normal {}
-
-impl ConfigSpaceKind for Extended {}
-
-/// The PCI configuration space of a device.
+/// A view of PCI configuration space of a device.
 ///
 /// Provides typed read and write accessors for configuration registers
 /// using the standard `pci_read_config_*` and `pci_write_config_*` helpers.
 ///
-/// The generic parameter `S` indicates the maximum size of the configuration space.
-/// Use [`Normal`] for 256-byte legacy configuration space or [`Extended`] for
-/// 4096-byte PCIe extended configuration space (default).
-pub struct ConfigSpace<'a, S: ?Sized + ConfigSpaceKind = Extended> {
+/// The generic parameter `T` is the type of the view. The full configuration space is also a
+/// special type of view; in such cases, `T` can be [`Normal`] for 256-byte legacy configuration
+/// space or [`Extended`] for 4096-byte PCIe extended configuration space (default).
+///
+/// # Invariants
+///
+/// `ptr` is aligned and range `ptr..ptr + KnownSize::size(ptr)` is within
+/// `0..pdev.cfg_size().into_raw()`.
+pub struct ConfigSpace<'a, T: ?Sized = Extended> {
     pub(crate) pdev: &'a Device<device::Bound>,
-    _marker: PhantomData<S>,
+    ptr: *mut T,
 }
 
+impl<T: ?Sized> Copy for ConfigSpace<'_, T> {}
+impl<T: ?Sized> Clone for ConfigSpace<'_, T> {
+    #[inline]
+    fn clone(&self) -> Self {
+        *self
+    }
+}
+
+// SAFETY: `ConfigSpace<'_, T>` is conceptually `&T` but in I/O memory.
+unsafe impl<T: ?Sized + Sync> Send for ConfigSpace<'_, T> {}
+
+// SAFETY: `ConfigSpace<'_, T>` is conceptually `&T` but in I/O memory.
+unsafe impl<T: ?Sized + Sync> Sync for ConfigSpace<'_, T> {}
+
 /// Implements [`IoCapable`] on [`ConfigSpace`] for `$ty` using `$read_fn` and `$write_fn`.
 macro_rules! impl_config_space_io_capable {
     ($ty:ty, $read_fn:ident, $write_fn:ident) => {
-        impl<'a, S: ?Sized + ConfigSpaceKind> IoCapable<$ty> for &ConfigSpace<'a, S> {
+        impl<'a, T: ?Sized> IoCapable<$ty> for ConfigSpace<'a, T> {
             unsafe fn io_read(self, address: usize) -> $ty {
                 let mut val: $ty = 0;
 
@@ -112,19 +120,17 @@ unsafe fn io_write(self, value: $ty, address: usize) {
 impl_config_space_io_capable!(u16, pci_read_config_word, pci_write_config_word);
 impl_config_space_io_capable!(u32, pci_read_config_dword, pci_write_config_dword);
 
-impl<'a, S: ?Sized + ConfigSpaceKind> Io for &ConfigSpace<'a, S> {
-    type Target = S;
+impl<'a, T: ?Sized + KnownSize> Io for ConfigSpace<'a, T> {
+    type Target = T;
 
-    /// Returns the base address of the I/O region. It is always 0 for configuration space.
     #[inline]
     fn addr(self) -> usize {
-        0
+        self.ptr.addr()
     }
 
-    /// Returns the maximum size of the configuration space.
     #[inline]
     fn maxsize(self) -> usize {
-        self.pdev.cfg_size().into_raw()
+        KnownSize::size(self.ptr)
     }
 }
 
@@ -281,23 +287,25 @@ pub fn cfg_size(&self) -> ConfigSpaceSize {
         }
     }
 
-    /// Return an initialized normal (256-byte) config space object.
+    /// Return a view of the normal (256-byte) config space.
     pub fn config_space<'a>(&'a self) -> ConfigSpace<'a, Normal> {
+        // INVARIANT: null is aligned and the range is within config space.
         ConfigSpace {
             pdev: self,
-            _marker: PhantomData,
+            ptr: Normal::ptr_from_raw_parts_mut(core::ptr::null_mut(), self.cfg_size().into_raw()),
         }
     }
 
-    /// Return an initialized extended (4096-byte) config space object.
+    /// Return a view of the extended (4096-byte) config space.
     pub fn config_space_extended<'a>(&'a self) -> Result<ConfigSpace<'a, Extended>> {
         if self.cfg_size() != ConfigSpaceSize::Extended {
             return Err(EINVAL);
         }
 
+        // INVARIANT: null is aligned and we just checked the `cfg_size`.
         Ok(ConfigSpace {
             pdev: self,
-            _marker: PhantomData,
+            ptr: Extended::ptr_from_raw_parts_mut(core::ptr::null_mut(), 4096),
         })
     }
 }

-- 
2.54.0

