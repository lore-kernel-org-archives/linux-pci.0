Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022106.outbound.protection.outlook.com [52.101.101.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFEA439010;
	Thu, 11 Jun 2026 16:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195319; cv=fail; b=TsCXmuXuE9aJ3Hdsvbg63fIcpmdGS17JNWM5GYM2x518sduV3+Rd6/5NoyRAmmpVdgl37NzoOfc31GkE9hCP25zm6y7YMBk4GYVoChLprb1p9QqvpBzYTJO/rD2+DPFkYskkH1AAcO2Cc+0JPHQRSDKo47Dszz3HrVWhsiEq/bU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195319; c=relaxed/simple;
	bh=aogygvAMVs9+bXGq3flUbl77HtTfoPkh+xeIlfu5bzM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ORlSdf5K46Eb697XcQZXAl+x/UGJJK5iv/2bpnyqmyu413JGpbtu2dvvLOmwr5JD0XvvHpRpCuNIYx4vo4kfdHTCylw8HKoT72pn0OtGfZHMwRh13uOsOcsJdD7oWVqkdKhSTqz1v0MJWpOQmITAOIS1OviNT2zGS5tjCeezQoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=uTcNmNao; arc=fail smtp.client-ip=52.101.101.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="uTcNmNao"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YqSAvCtUjbhZcG2cwMFEyRNv2AiPyLYJo6H8giTtRgnTa0KAVMExEFebuD8D2SjdS/2OnDG80j3Wn7XtvXMLn5f/wW49pkiv6BnEcIuRTJVUW2juQk3aRW42yae1XxGTufAG6yO25xXKYFRvj+6/5hswhBiXKLn3GjcDEaP5+jqG/p0FQMJpsqBRXLMaj+i7SNU4RVlcnYRbVzWxY+GWUQqt/DvnjdFWv8wSJD11T9j/kGjlzzmO9kUZdaSwWMB5B8O6sHk2nciv7Pb4OlWF6syYmpeGbAgQIVsHFEJITEXmPNgubZTbJBypkwKUHeYAyZ5wNp9bda2ADL0aHH+vKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfjvam4JclqvTAPWjS2e757MNoHOIMWPaZlWMFuLYDY=;
 b=iIsBXMQYmGAfRZHpyaYBH83MjX0R+jqIkYu8Zc1O29CdCD16BaZhP2PnN0cil8rm2GG9CBqtXJ9lKt2vpH9T7RatN45jl1Kl9q5/Jgncq2CssxKZ7B9DWJ835eq0ZAQXHOoeHmSxLLihdXkxJtiffGAWnTRJeoh8MLR0a/VQrSE7C04L9isa7pfDNMJ8J3n2v1/vnYuMovF5QzAUO8EhwmWA7GTmfgR54pi4KlEdymBZ3t8bGoYosLMH/HPnD0vED58wLm5skIidJaE9+ih5vtJcwzgQl7SlIh4tbGcdXgaRIKWC6WcKm+HdvycK9/ZXoVMTgwkrV+O14T2XIX1YLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfjvam4JclqvTAPWjS2e757MNoHOIMWPaZlWMFuLYDY=;
 b=uTcNmNaoJhpi9IWKiplSqbWwhNodrYxxP8sh7n97+sXqXLtCqKwYMgmCkz6NozBe7CWrUKUnKJK5uBH7JACE0mWxfhrwDKeh4wUzcd3AykXG1Tfdj0Qk0FXb1iI84R+D0VCg8ZK+9yMcJLIbtTiiQtIlOoXXIBzk9ilOymSgO68=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by LO4P265MB6525.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2e7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Thu, 11 Jun
 2026 16:28:28 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 16:28:28 +0000
From: Gary Guo <gary@garyguo.net>
Date: Thu, 11 Jun 2026 17:28:11 +0100
Subject: [PATCH v4 09/20] rust: io: use view types instead of addresses for
 `Io`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-io_projection-v4-9-1f7224b02dcb@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781195301; l=30721;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=aogygvAMVs9+bXGq3flUbl77HtTfoPkh+xeIlfu5bzM=;
 b=SRR6yi1FmEpAFC4SJvbBTxXyKM9BUntHOfB8DFDTxl0ZBzofa4XJ23Tylj/+9F4zdQOArYQAE
 9zF4TC6buIkCeDLRM7te0GKH832wFFmFwqexCeYGnfx8k0t7saVqmDz
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
X-MS-Office365-Filtering-Correlation-Id: 9b74b187-e338-45fa-aa79-08dec7d677b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10070799003|921020|6133799003|56012099006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	m+0Dw/Cszk+PUTpN8vyemCVE5F1STBBP85ZKJQDKAP+pYoPfl01hVVX31f8FG9ynDkLqpN6+03Za11ltznRA+BpdjmvUyJor61DKmM81VZQQmjHtTfs0TVdYXuh69knBpcD4aShLDczd7eHbmxrMJLwEKy0M3xPk7Sl+vaxhw0J249xRpkyGrCLU1WH9jMYPZfvK2vvVsUosYIHLpZDSiNwhDegP74zdp/W7fXABRTpfG1yIXGDE8d6kvfbLoEKasypl6kNqFUHTSpCaCVCU68cmkeIGjMvvC4Uqyu7zEpEWfdv3/UMLUHd2CaDtyan7I2hHeujmu7w+F+xmSdoogs58Iv6gd4TXdJ+2gg/Oa3ynb53PF2gxZAqBtMfjicyhHJtv6yswW4uH/H00VUWzxQm3+GYNCU3Tlea5DAusbhGVSD4QEg4KERPkmnVefJwAl78AEBTemNr7/eNq6TM5ry+Y5WoE9g/LjeRqwWDWiyJc0h79LYTOFd7CuJ+Ix2xf+MLF+tHso3+BTF5tJN7ICiDAyzo/w+MCXsUI8sOp7qSkz445cGbrZaeqVXCZ1L2JB6KiYnQryN06t1N8qKPWDT0d7HH88Ckgb8grd8vvZ6u3P/sWCtlE0/7E7EDtY9ur4WEEd17C/d+lhbbCI4QrsilsYOx+jzJg+4sYCOGC6TcJ8nQ+zRLKbGUOP+D0DgQCcexYLv0PCVt/MdNKhqPSP81apVrnMuaKBlSItJ/KqD4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10070799003)(921020)(6133799003)(56012099006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blFDNDkzZWJWWVY2bGRhRVpCdTNjRnB3cDFYa1NocnVHMnZOSXVzL2EvcnEr?=
 =?utf-8?B?NU9ISFhIbWxXTDRwMEhGY0puRVU5N3FURFl1MjNTU0xxVlo1WkUxUkg4Wkdr?=
 =?utf-8?B?dmFUN29kZXFveGN4OEtzSVUrYyswSWZRL1B5T2F6aXdrTWlEeEFJa0RRUUJW?=
 =?utf-8?B?UitNN25DaU9QaHVxaUZMNkJYaGJJdzFXMHpndjNJdzNuVFpRQ2tvRlZhVGpw?=
 =?utf-8?B?Zy81cWNkR0tvQ3NpcGZ0bGN3RXNsRlVpcVlQQnhXTVMyb2pYeEJtZ3Z3L04x?=
 =?utf-8?B?ZTRjN2FNNU5SbGVzYUhhd2NadWduaVB0eHdHYlk2dFdEVUdiSG5EbzZER3RS?=
 =?utf-8?B?cWZmRjFuMmhRcVFoc0t2NitibmRLRmh3N21QY2puZG5pem5uZXFmQWpBVlZM?=
 =?utf-8?B?YjZINk1rL245RGQreGRNY3plamdBcDVucDI4bHRnd2xpaFpIZDduQjRlaXQy?=
 =?utf-8?B?WTR0U2s1elIwL0hvRnBQcVFQT2JjcDNMaG5wUXZWM3JGRlVTb0lQdy9XbGl6?=
 =?utf-8?B?VEdIVGR6VG9Pd2hjdGNhWWFTSWE3eElDaVIvUUF6bG16cGJySlNUckhDNGNs?=
 =?utf-8?B?MWdwOHhtdm9RUzJyQ1pOOGpKTUlrdER4K0pOK0p6V2pLMlB5YnBkQjBXbkJQ?=
 =?utf-8?B?dVU0cWFOTlRzRFliYzhoLzRSTWZBOC9UZ3FUN2grLyttSGxCdUk3QnJNK050?=
 =?utf-8?B?Ym9XQkR4WFhVUHlHanVoQUxyejU0VjVhRW9aeXZOaXNWTSt3MXhxUWlsZTB1?=
 =?utf-8?B?U1F0UUIzeVMxbFVsT2lsMzVPUkoydUt3RFQvanJnNVBmc25MeHU1eDFPR2Y1?=
 =?utf-8?B?Y09qNEZyVTJDak1XTTNGYnhLZmhlQ1haY25XUEoyZGdSbDZ6NUI2ajYzYXkr?=
 =?utf-8?B?L0Fad1h0ajIwTjRFRDJmbzFSK2JabG1jUE90R2pMclcwdXp1RUZQdnlobFVu?=
 =?utf-8?B?ckJtM2FhYURtYitJb0NqZStGL2dTVlRPTDNVNnJXWlY4YTFnU3Y4bEZZSlRr?=
 =?utf-8?B?TmhVN0lhUWk2dDRUUDZjNFkyK0JXb2hlTlc0YWVycFYyUjZlYlE0cUQ4cUtH?=
 =?utf-8?B?aWVnZnFSTXc0b1oyMWtpZkNxTGdwUEFBU0Vkc3NFU05NdUJlelFJOFBSYm15?=
 =?utf-8?B?b21NUEY1ZUw0NTNKYXdybHZzam9YTXNpZ1o2QjlsV3p5RzBKQ2s4clRjbGNP?=
 =?utf-8?B?WTU3RE1hNkMzaXk0T0NjU21DazRsdENNck1yK3BtdDRnZERmRDZRdTMxNm1F?=
 =?utf-8?B?elpSZWJHcEQvekZCQzJJUFp0NjFvVHd2MFN4VkVKdG80bWVkcldrWHQ4akdQ?=
 =?utf-8?B?NEZXZUVhRlU0Vm5CaTVOc2cwa3MxeU5lajNXdlBwUjBnWXord2FaTDdpZ2M2?=
 =?utf-8?B?ZTk3VzRhdnVGTHloczRRallwSm1WSnJ4MVRqeXI4SlcvQk1qdmFEZGRkMFdZ?=
 =?utf-8?B?ODAycGR3YUcvb2x0TC9ZeWZWZno2aktBMGYySkpPbVQ4VWU0emhQSGNzZHM5?=
 =?utf-8?B?RWs0T2k3Y3UzZXEzRkJuamptdjlKQ3R3VXdJVlNTNkgxb0JtKzc5NHNtSllH?=
 =?utf-8?B?blNkTmhybE9uQWhHTjVVM2tPQmRCVnNnbVV1YmMvazYrSEJSYjQ0RytZcitM?=
 =?utf-8?B?aFFsNnFPSGEyRSs3YTRTSkF3cHJjRTIrYk5FK05DcUYxVjBvVWJkaExLVkJL?=
 =?utf-8?B?KzRzVnVDRnRqTjlaVGF5N0tSSFdOZDAvOUZVRVEyMDVnMTN5U3ZINnNGUnhk?=
 =?utf-8?B?T3VYaW9RckNna0tEbzIwMWZ6UngxWk5kZmtqcnJXYis5Z0xxMUp6b2lhR0dt?=
 =?utf-8?B?T3o3MVFMd1hBRlJnS081blhvREVleDIwaFdzLzlhQWNoRDF6OGRsMU5KRGdL?=
 =?utf-8?B?WEF0d3ZTTGNnNWRjNGtXbWo0VzN1QnV0RGpuR0tBK3d3TXg5TTB6Z1p3cGRl?=
 =?utf-8?B?YzJCRCtsU1RqcnFUZDNWV3c3b0wxMWdoeWxjOGNCWmo0L0JTVUhrYXlFMlN5?=
 =?utf-8?B?d3BMa2dBTlBPNHpWUmI5S2M0ck1LOW8veXBYbjFZOFcrR3pUbEFlTHErZGgz?=
 =?utf-8?B?SzRMallRTWt0UXNvdTQyOHJ0aXRzWk9LdUx3OXR6TGMrdTZjcStqK1BMOTl4?=
 =?utf-8?B?clFnSHBxMG9vSk9oc0VMcE5Za2UyK1JDRHVUOWJINzZ1YXpZS3dGcDVKNE9s?=
 =?utf-8?B?cE91M1F0QWloMzc1R1RlTUR4dHNCUVJFYlhwYWtOYlQ2TWJGcTloLyttMzYw?=
 =?utf-8?B?RFdUQzNPVEM3ZlI3T3RPY3ZLcjdVbVBqOVk4dDd0MlVXbGNiVlZlNE9obWtp?=
 =?utf-8?B?eDIrL0ZNVlo1azdSSHNRRUEzcUhPc3AyU2NoNnB2SXh4cUl4c1o2Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b74b187-e338-45fa-aa79-08dec7d677b9
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 16:28:27.9624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RXjWtgI/t/f5PFqpxvml1SBybv+3MMMQh+aqMtRYaa6NrVZ3X4FVvSPlYgz2QG6oHl2tC5xs2mPgCzgkfjOdSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6525

Currently, `io_read` and `io_write` methods require the exact type of `Io`
plus an address. This means that they need to be monomorphized for each
different `Io` instance. This also means that multiple I/O implementors for
the same I/O kind needs to duplicate implementation (e.g. `Mmio` and
`MmioOwned`).

Create a new `IoBackend` trait and define these operations on it instead.
The operations are just going to receive a view type and operate on them.
This has the additional advantage that the invariants can be moved from the
trait (and guaranteed via `unsafe`) to type invariants on the canonical
view types of the backends, so `io_read` and `io_write` can be safe.

Note that view type is needed; addresses are insufficient in this
designk, as they do not carry sufficient information. For example,
`ConfigSpace` needs `&pci::Device` in addition to the address.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io.rs     | 345 ++++++++++++++++++++++++++------------------------
 rust/kernel/pci/io.rs |  70 ++++++----
 2 files changed, 224 insertions(+), 191 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 3ac8b396f5a7..e422a5ff2a5e 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -244,6 +244,38 @@ const fn offset_valid<U>(base: usize, offset: usize, size: usize) -> bool {
     }
 }
 
+/// I/O backends.
+///
+/// This is an abstract representation to be implemented by arbitrary I/O
+/// backends (e.g. MMIO, PCI config space, etc.).
+///
+/// The base trait only defines the projection operations; which I/O methods are available depends
+/// on which [`IoCapable<T>`] traits are implemented for the type. For example, for MMIO regions,
+/// all widths (u8, u16, u32, and u64 on 64-bit systems) are typically supported. For PCI
+/// configuration space, u8, u16, and u32 are supported but u64 is not.
+///
+/// This trait is separate from the `Io` trait as multiple different I/O types may share the same
+/// operation.
+pub trait IoBackend {
+    /// View type for this I/O backend.
+    type View<'a, T: ?Sized + KnownSize>: Io<'a, Backend = Self, Target = T>;
+
+    /// Convert a `view` to a raw pointer for projection.
+    fn as_ptr<'a, T: ?Sized + KnownSize>(view: Self::View<'a, T>) -> *mut T;
+
+    /// Project `view` to its subregion indicated by `ptr`.
+    ///
+    /// If input `view` is valid, returned view must also be valid.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must be a projection of `Self::as_ptr(view)`.
+    unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + KnownSize>(
+        view: Self::View<'a, T>,
+        ptr: *mut U,
+    ) -> Self::View<'a, U>;
+}
+
 /// Trait indicating that an I/O backend supports operations of a certain type and providing an
 /// implementation for these operations.
 ///
@@ -252,22 +284,12 @@ const fn offset_valid<U>(base: usize, offset: usize, size: usize) -> bool {
 /// For example, a PCI configuration space may implement `IoCapable<u8>`, `IoCapable<u16>`,
 /// and `IoCapable<u32>`, but not `IoCapable<u64>`, while an MMIO region on a 64-bit
 /// system might implement all four.
-pub trait IoCapable<T> {
-    /// Performs an I/O read of type `T` at `address` and returns the result.
-    ///
-    /// # Safety
-    ///
-    /// - The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
-    /// - `address` must be aligned.
-    unsafe fn io_read(self, address: usize) -> T;
+pub trait IoCapable<T>: IoBackend {
+    /// Performs an I/O read of type `T` at `view` and returns the result.
+    fn io_read<'a>(view: Self::View<'a, T>) -> T;
 
-    /// Performs an I/O write of `value` at `address`.
-    ///
-    /// # Safety
-    ///
-    /// - The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
-    /// - `address` must be aligned.
-    unsafe fn io_write(self, value: T, address: usize);
+    /// Performs an I/O write of `value` at `view`.
+    fn io_write<'a>(view: Self::View<'a, T>, value: T);
 }
 
 /// Describes a given I/O location: its offset, width, and type to convert the raw value from and
@@ -319,56 +341,54 @@ fn offset(self) -> usize {
 /// Types implementing this trait (e.g. MMIO BARs or PCI config regions)
 /// can perform I/O operations on regions of memory.
 ///
-/// This is an abstract representation to be implemented by arbitrary I/O
-/// backends (e.g. MMIO, PCI config space, etc.).
-///
 /// The [`Io`] trait provides:
-/// - Base address and size information
+/// - Method to convert into [`IoBackend::View`].
 /// - Helper methods for offset validation and address calculation
 /// - Fallible (runtime checked) accessors for different data widths
 ///
-/// Which I/O methods are available depends on which [`IoCapable<T>`] traits
-/// are implemented for the type.
-///
-/// # Examples
-///
-/// For MMIO regions, all widths (u8, u16, u32, and u64 on 64-bit systems) are typically
-/// supported. For PCI configuration space, u8, u16, and u32 are supported but u64 is not.
-pub trait Io: Copy {
+/// Which I/O methods are available depends on the associated [`IoBackend`] implementation.
+pub trait Io<'a>: Copy {
+    /// Type that defines all I/O operations.
+    type Backend: IoBackend;
+
     /// Type of this I/O region. For untyped regions, [`Region`] can be used.
     type Target: ?Sized + KnownSize;
 
-    /// Returns the base address of this mapping.
-    fn addr(self) -> usize;
-
-    /// Returns the maximum size of this mapping.
-    fn maxsize(self) -> usize;
+    /// Return a view that covers the full region.
+    fn as_view(self) -> <Self::Backend as IoBackend>::View<'a, Self::Target>;
 
-    /// Returns the absolute I/O address for a given `offset`,
-    /// performing compile-time bound checks.
+    /// Returns a view for a given `offset`, performing compile-time bound checks.
     // Always inline to optimize out error path of `build_assert`.
     #[inline(always)]
-    fn io_addr_assert<U>(self, offset: usize) -> usize {
-        // We cannot check alignment with `offset_valid` using `self.addr()`. So set 0 for it and
+    fn io_addr_assert<U>(self, offset: usize) -> <Self::Backend as IoBackend>::View<'a, U> {
+        // We cannot check alignment with `offset_valid` using `ptr.addr()`. So set 0 for it and
         // ensure alignment by checking that the alignment of `U` is smaller or equal to the
         // alignment of `Self::Target`.
         const_assert!(Alignment::of::<U>().as_usize() <= Self::Target::MIN_ALIGN.as_usize());
         build_assert!(offset_valid::<U>(0, offset, Self::Target::MIN_SIZE));
 
-        self.addr() + offset
+        let view = self.as_view();
+        let ptr = Self::Backend::as_ptr(view);
+        let projected_ptr = ptr.cast::<U>().wrapping_byte_add(offset);
+        // SAFETY: `offset_valid` checks for size and alignment and therefore `projected_ptr` is a
+        // valid projection.
+        unsafe { Self::Backend::project_view(view, projected_ptr) }
     }
 
-    /// Returns the absolute I/O address for a given `offset`,
-    /// performing runtime bound checks.
+    /// Returns a view for a given `offset`, performing runtime bound checks.
     #[inline]
-    fn io_addr<U>(self, offset: usize) -> Result<usize> {
-        if !offset_valid::<U>(self.addr(), offset, self.maxsize()) {
+    fn io_addr<U>(self, offset: usize) -> Result<<Self::Backend as IoBackend>::View<'a, U>> {
+        let view = self.as_view();
+        let ptr = Self::Backend::as_ptr(view);
+
+        if !offset_valid::<U>(ptr.addr(), offset, KnownSize::size(ptr)) {
             return Err(EINVAL);
         }
 
-        // Probably no need to check, since the safety requirements of `Self::new` guarantee that
-        // this can't overflow.
-        self.addr().checked_add(offset).ok_or(EINVAL)
+        let projected_ptr = ptr.cast::<U>().wrapping_byte_add(offset);
+        // SAFETY: `offset_valid` checks for size and alignment and therefore `projected_ptr` is a
+        // valid projection.
+        Ok(unsafe { Self::Backend::project_view(view, projected_ptr) })
     }
 
     /// Fallible 8-bit read with runtime bounds check.
@@ -376,7 +396,7 @@ fn io_addr<U>(self, offset: usize) -> Result<usize> {
     fn try_read8(self, offset: usize) -> Result<u8>
     where
         usize: IoLoc<Self::Target, u8, IoType = u8>,
-        Self: IoCapable<u8>,
+        Self::Backend: IoCapable<u8>,
     {
         self.try_read(offset)
     }
@@ -386,7 +406,7 @@ fn try_read8(self, offset: usize) -> Result<u8>
     fn try_read16(self, offset: usize) -> Result<u16>
     where
         usize: IoLoc<Self::Target, u16, IoType = u16>,
-        Self: IoCapable<u16>,
+        Self::Backend: IoCapable<u16>,
     {
         self.try_read(offset)
     }
@@ -396,7 +416,7 @@ fn try_read16(self, offset: usize) -> Result<u16>
     fn try_read32(self, offset: usize) -> Result<u32>
     where
         usize: IoLoc<Self::Target, u32, IoType = u32>,
-        Self: IoCapable<u32>,
+        Self::Backend: IoCapable<u32>,
     {
         self.try_read(offset)
     }
@@ -406,7 +426,7 @@ fn try_read32(self, offset: usize) -> Result<u32>
     fn try_read64(self, offset: usize) -> Result<u64>
     where
         usize: IoLoc<Self::Target, u64, IoType = u64>,
-        Self: IoCapable<u64>,
+        Self::Backend: IoCapable<u64>,
     {
         self.try_read(offset)
     }
@@ -416,7 +436,7 @@ fn try_read64(self, offset: usize) -> Result<u64>
     fn try_write8(self, value: u8, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u8, IoType = u8>,
-        Self: IoCapable<u8>,
+        Self::Backend: IoCapable<u8>,
     {
         self.try_write(offset, value)
     }
@@ -426,7 +446,7 @@ fn try_write8(self, value: u8, offset: usize) -> Result
     fn try_write16(self, value: u16, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u16, IoType = u16>,
-        Self: IoCapable<u16>,
+        Self::Backend: IoCapable<u16>,
     {
         self.try_write(offset, value)
     }
@@ -436,7 +456,7 @@ fn try_write16(self, value: u16, offset: usize) -> Result
     fn try_write32(self, value: u32, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u32, IoType = u32>,
-        Self: IoCapable<u32>,
+        Self::Backend: IoCapable<u32>,
     {
         self.try_write(offset, value)
     }
@@ -446,7 +466,7 @@ fn try_write32(self, value: u32, offset: usize) -> Result
     fn try_write64(self, value: u64, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u64, IoType = u64>,
-        Self: IoCapable<u64>,
+        Self::Backend: IoCapable<u64>,
     {
         self.try_write(offset, value)
     }
@@ -456,7 +476,7 @@ fn try_write64(self, value: u64, offset: usize) -> Result
     fn read8(self, offset: usize) -> u8
     where
         usize: IoLoc<Self::Target, u8, IoType = u8>,
-        Self: IoCapable<u8>,
+        Self::Backend: IoCapable<u8>,
     {
         self.read(offset)
     }
@@ -466,7 +486,7 @@ fn read8(self, offset: usize) -> u8
     fn read16(self, offset: usize) -> u16
     where
         usize: IoLoc<Self::Target, u16, IoType = u16>,
-        Self: IoCapable<u16>,
+        Self::Backend: IoCapable<u16>,
     {
         self.read(offset)
     }
@@ -476,7 +496,7 @@ fn read16(self, offset: usize) -> u16
     fn read32(self, offset: usize) -> u32
     where
         usize: IoLoc<Self::Target, u32, IoType = u32>,
-        Self: IoCapable<u32>,
+        Self::Backend: IoCapable<u32>,
     {
         self.read(offset)
     }
@@ -486,7 +506,7 @@ fn read32(self, offset: usize) -> u32
     fn read64(self, offset: usize) -> u64
     where
         usize: IoLoc<Self::Target, u64, IoType = u64>,
-        Self: IoCapable<u64>,
+        Self::Backend: IoCapable<u64>,
     {
         self.read(offset)
     }
@@ -496,7 +516,7 @@ fn read64(self, offset: usize) -> u64
     fn write8(self, value: u8, offset: usize)
     where
         usize: IoLoc<Self::Target, u8, IoType = u8>,
-        Self: IoCapable<u8>,
+        Self::Backend: IoCapable<u8>,
     {
         self.write(offset, value)
     }
@@ -506,7 +526,7 @@ fn write8(self, value: u8, offset: usize)
     fn write16(self, value: u16, offset: usize)
     where
         usize: IoLoc<Self::Target, u16, IoType = u16>,
-        Self: IoCapable<u16>,
+        Self::Backend: IoCapable<u16>,
     {
         self.write(offset, value)
     }
@@ -516,7 +536,7 @@ fn write16(self, value: u16, offset: usize)
     fn write32(self, value: u32, offset: usize)
     where
         usize: IoLoc<Self::Target, u32, IoType = u32>,
-        Self: IoCapable<u32>,
+        Self::Backend: IoCapable<u32>,
     {
         self.write(offset, value)
     }
@@ -526,7 +546,7 @@ fn write32(self, value: u32, offset: usize)
     fn write64(self, value: u64, offset: usize)
     where
         usize: IoLoc<Self::Target, u64, IoType = u64>,
-        Self: IoCapable<u64>,
+        Self::Backend: IoCapable<u64>,
     {
         self.write(offset, value)
     }
@@ -558,12 +578,10 @@ fn write64(self, value: u64, offset: usize)
     fn try_read<T, L>(self, location: L) -> Result<T>
     where
         L: IoLoc<Self::Target, T>,
-        Self: IoCapable<L::IoType>,
+        Self::Backend: IoCapable<L::IoType>,
     {
-        let address = self.io_addr::<L::IoType>(location.offset())?;
-
-        // SAFETY: `address` has been validated by `io_addr`.
-        Ok(unsafe { self.io_read(address) }.into())
+        let view = self.io_addr::<L::IoType>(location.offset())?;
+        Ok(Self::Backend::io_read(view).into())
     }
 
     /// Generic fallible write with runtime bounds check.
@@ -593,14 +611,11 @@ fn try_read<T, L>(self, location: L) -> Result<T>
     fn try_write<T, L>(self, location: L, value: T) -> Result
     where
         L: IoLoc<Self::Target, T>,
-        Self: IoCapable<L::IoType>,
+        Self::Backend: IoCapable<L::IoType>,
     {
-        let address = self.io_addr::<L::IoType>(location.offset())?;
+        let view = self.io_addr::<L::IoType>(location.offset())?;
         let io_value = value.into();
-
-        // SAFETY: `address` has been validated by `io_addr`.
-        unsafe { self.io_write(io_value, address) }
-
+        Self::Backend::io_write(view, io_value);
         Ok(())
     }
 
@@ -641,7 +656,7 @@ fn try_write_reg<T, L, V>(self, value: V) -> Result
     where
         L: IoLoc<Self::Target, T>,
         V: LocatedRegister<Self::Target, Location = L, Value = T>,
-        Self: IoCapable<L::IoType>,
+        Self::Backend: IoCapable<L::IoType>,
     {
         let (location, value) = value.into_io_op();
 
@@ -674,17 +689,14 @@ fn try_write_reg<T, L, V>(self, value: V) -> Result
     fn try_update<T, L, F>(self, location: L, f: F) -> Result
     where
         L: IoLoc<Self::Target, T>,
-        Self: IoCapable<L::IoType>,
+        Self::Backend: IoCapable<L::IoType>,
         F: FnOnce(T) -> T,
     {
-        let address = self.io_addr::<L::IoType>(location.offset())?;
+        let view = self.io_addr::<L::IoType>(location.offset())?;
 
-        // SAFETY: `address` has been validated by `io_addr`.
-        let value: T = unsafe { self.io_read(address) }.into();
+        let value: T = Self::Backend::io_read(view).into();
         let io_value = f(value).into();
-
-        // SAFETY: `address` has been validated by `io_addr`.
-        unsafe { self.io_write(io_value, address) }
+        Self::Backend::io_write(view, io_value);
 
         Ok(())
     }
@@ -714,12 +726,10 @@ fn try_update<T, L, F>(self, location: L, f: F) -> Result
     fn read<T, L>(self, location: L) -> T
     where
         L: IoLoc<Self::Target, T>,
-        Self: IoCapable<L::IoType>,
+        Self::Backend: IoCapable<L::IoType>,
     {
-        let address = self.io_addr_assert::<L::IoType>(location.offset());
-
-        // SAFETY: `address` has been validated by `io_addr_assert`.
-        unsafe { self.io_read(address) }.into()
+        let view = self.io_addr_assert::<L::IoType>(location.offset());
+        Self::Backend::io_read(view).into()
     }
 
     /// Generic infallible write with compile-time bounds check.
@@ -747,13 +757,11 @@ fn read<T, L>(self, location: L) -> T
     fn write<T, L>(self, location: L, value: T)
     where
         L: IoLoc<Self::Target, T>,
-        Self: IoCapable<L::IoType>,
+        Self::Backend: IoCapable<L::IoType>,
     {
-        let address = self.io_addr_assert::<L::IoType>(location.offset());
+        let view = self.io_addr_assert::<L::IoType>(location.offset());
         let io_value = value.into();
-
-        // SAFETY: `address` has been validated by `io_addr_assert`.
-        unsafe { self.io_write(io_value, address) }
+        Self::Backend::io_write(view, io_value);
     }
 
     /// Generic infallible write of a fully-located register value.
@@ -792,7 +800,7 @@ fn write_reg<T, L, V>(self, value: V)
     where
         L: IoLoc<Self::Target, T>,
         V: LocatedRegister<Self::Target, Location = L, Value = T>,
-        Self: IoCapable<L::IoType>,
+        Self::Backend: IoCapable<L::IoType>,
     {
         let (location, value) = value.into_io_op();
 
@@ -825,17 +833,13 @@ fn write_reg<T, L, V>(self, value: V)
     fn update<T, L, F>(self, location: L, f: F)
     where
         L: IoLoc<Self::Target, T>,
-        Self: IoCapable<L::IoType>,
+        Self::Backend: IoCapable<L::IoType>,
         F: FnOnce(T) -> T,
     {
-        let address = self.io_addr_assert::<L::IoType>(location.offset());
-
-        // SAFETY: `address` has been validated by `io_addr_assert`.
-        let value: T = unsafe { self.io_read(address) }.into();
+        let view = self.io_addr_assert::<L::IoType>(location.offset());
+        let value: T = Self::Backend::io_read(view).into();
         let io_value = f(value).into();
-
-        // SAFETY: `address` has been validated by `io_addr_assert`.
-        unsafe { self.io_write(io_value, address) }
+        Self::Backend::io_write(view, io_value);
     }
 }
 
@@ -879,78 +883,76 @@ unsafe impl<T: ?Sized + Sync> Send for Mmio<'_, T> {}
 // SAFETY: `Mmio<'_, T>` is conceptually `&T` but in I/O memory.
 unsafe impl<T: ?Sized + Sync> Sync for Mmio<'_, T> {}
 
-impl<T: ?Sized + KnownSize> Io for Mmio<'_, T> {
+impl<'a, T: ?Sized + KnownSize> Io<'a> for Mmio<'a, T> {
+    type Backend = MmioBackend;
     type Target = T;
 
     #[inline]
-    fn addr(self) -> usize {
-        self.ptr.addr()
+    fn as_view(self) -> Mmio<'a, T> {
+        self
     }
+}
+
+/// I/O Backend for memory-mapped I/O.
+pub struct MmioBackend;
+
+impl IoBackend for MmioBackend {
+    type View<'a, T: ?Sized + KnownSize> = Mmio<'a, T>;
 
     #[inline]
-    fn maxsize(self) -> usize {
-        KnownSize::size(self.ptr)
+    fn as_ptr<'a, T: ?Sized + KnownSize>(view: Self::View<'a, T>) -> *mut T {
+        view.ptr
+    }
+
+    #[inline]
+    unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + KnownSize>(
+        _view: Self::View<'a, T>,
+        ptr: *mut U,
+    ) -> Self::View<'a, U> {
+        // INVARIANT: Per safety requirement, `ptr` is projection from `view`, so it is also a valid
+        // memory-mapped I/O region.
+        Mmio {
+            ptr,
+            phantom: PhantomData,
+        }
     }
 }
 
-/// Implements [`IoCapable`] on `$mmio` for `$ty` using `$read_fn` and `$write_fn`.
+/// Implements [`IoCapable`] on `$backend` for `$ty` using `$read_fn` and `$write_fn`.
 macro_rules! impl_mmio_io_capable {
-    ($mmio:ident, $(#[$attr:meta])* $ty:ty, $read_fn:ident, $write_fn:ident) => {
-        $(#[$attr])*
-        impl<T: ?Sized> IoCapable<$ty> for $mmio<'_, T> {
+    ($backend: ident, $ty:ty, $read_fn:ident, $write_fn:ident) => {
+        impl IoCapable<$ty> for $backend {
             #[inline]
-            unsafe fn io_read(self, address: usize) -> $ty {
-                // SAFETY: By the trait invariant `address` is a valid address for MMIO operations.
-                unsafe { bindings::$read_fn(address as *const c_void) }
+            fn io_read(view: <$backend as IoBackend>::View<'_, $ty>) -> $ty {
+                // SAFETY: By the type invariant, `view.ptr` is a valid address for MMIO operations.
+                unsafe { bindings::$read_fn(view.ptr.cast_const().cast()) }
             }
 
             #[inline]
-            unsafe fn io_write(self, value: $ty, address: usize) {
-                // SAFETY: By the trait invariant `address` is a valid address for MMIO operations.
-                unsafe { bindings::$write_fn(value, address as *mut c_void) }
+            fn io_write(view: <$backend as IoBackend>::View<'_, $ty>, value: $ty) {
+                // SAFETY: By the type invariant, `view.ptr` is a valid address for MMIO operations.
+                unsafe { bindings::$write_fn(value, view.ptr.cast()) }
             }
         }
     };
 }
 
 // MMIO regions support 8, 16, and 32-bit accesses.
-impl_mmio_io_capable!(Mmio, u8, readb, writeb);
-impl_mmio_io_capable!(Mmio, u16, readw, writew);
-impl_mmio_io_capable!(Mmio, u32, readl, writel);
+impl_mmio_io_capable!(MmioBackend, u8, readb, writeb);
+impl_mmio_io_capable!(MmioBackend, u16, readw, writew);
+impl_mmio_io_capable!(MmioBackend, u32, readl, writel);
 // MMIO regions on 64-bit systems also support 64-bit accesses.
 #[cfg(CONFIG_64BIT)]
-impl_mmio_io_capable!(Mmio, u64, readq, writeq);
+impl_mmio_io_capable!(MmioBackend, u64, readq, writeq);
 
-impl<'a, const SIZE: usize> Io for &'a MmioOwned<SIZE> {
+impl<'a, const SIZE: usize> Io<'a> for &'a MmioOwned<SIZE> {
+    type Backend = MmioBackend;
     type Target = Region<SIZE>;
 
-    /// Returns the base address of this mapping.
     #[inline]
-    fn addr(self) -> usize {
-        self.0.addr()
-    }
-
-    /// Returns the maximum size of this mapping.
-    #[inline]
-    fn maxsize(self) -> usize {
-        self.0.size()
-    }
-}
-
-impl<'a, const SIZE: usize, T> IoCapable<T> for &'a MmioOwned<SIZE>
-where
-    Mmio<'a, Region<SIZE>>: IoCapable<T>,
-{
-    #[inline]
-    unsafe fn io_read(self, address: usize) -> T {
-        // SAFETY: Per safety requirement.
-        unsafe { self.as_view().io_read(address) }
-    }
-
-    #[inline]
-    unsafe fn io_write(self, value: T, address: usize) {
-        // SAFETY: Per safety requirement.
-        unsafe { self.as_view().io_write(value, address) }
+    fn as_view(self) -> Mmio<'a, Self::Target> {
+        // SAFETY: `Mmio` has same invariant as `MmioOwned`
+        unsafe { Mmio::from_raw(self.0) }
     }
 }
 
@@ -966,13 +968,6 @@ pub unsafe fn from_raw(raw: &MmioRaw<Region<SIZE>>) -> &Self {
         // SAFETY: `MmioOwned` is a transparent wrapper around `MmioRaw`.
         unsafe { &*core::ptr::from_ref(raw).cast() }
     }
-
-    /// Return a view that covers the full region.
-    #[inline]
-    pub fn as_view(&self) -> Mmio<'_, Region<SIZE>> {
-        // SAFETY: `Mmio` has same invariant as `MmioOwned`.
-        unsafe { Mmio::from_raw(self.0) }
-    }
 }
 
 /// [`Mmio`] but using relaxed accessors.
@@ -1004,17 +999,38 @@ unsafe impl<T: ?Sized + Sync> Send for RelaxedMmio<'_, T> {}
 // SAFETY: `RelaxedMmio<'_, T>` is conceptually `&T` but in I/O memory.
 unsafe impl<T: ?Sized + Sync> Sync for RelaxedMmio<'_, T> {}
 
-impl<T: ?Sized + KnownSize> Io for RelaxedMmio<'_, T> {
-    type Target = T;
+/// I/O Backend for memory-mapped I/O, with relaxed access semantics.
+pub struct RelaxedMmioBackend;
+
+impl IoBackend for RelaxedMmioBackend {
+    type View<'a, T: ?Sized + KnownSize> = RelaxedMmio<'a, T>;
 
     #[inline]
-    fn addr(self) -> usize {
-        self.ptr.addr()
+    fn as_ptr<'a, T: ?Sized + KnownSize>(view: Self::View<'a, T>) -> *mut T {
+        view.ptr
     }
 
     #[inline]
-    fn maxsize(self) -> usize {
-        KnownSize::size(self.ptr)
+    unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + KnownSize>(
+        _view: Self::View<'a, T>,
+        ptr: *mut U,
+    ) -> Self::View<'a, U> {
+        // INVARIANT: Per safety requirement, `ptr` is projection from `view`, so it is also a valid
+        // memory-mapped I/O region.
+        RelaxedMmio {
+            ptr,
+            phantom: PhantomData,
+        }
+    }
+}
+
+impl<'a, T: ?Sized + KnownSize> Io<'a> for RelaxedMmio<'a, T> {
+    type Backend = RelaxedMmioBackend;
+    type Target = T;
+
+    #[inline]
+    fn as_view(self) -> RelaxedMmio<'a, T> {
+        self
     }
 }
 
@@ -1051,14 +1067,9 @@ pub fn relaxed(self) -> RelaxedMmio<'a, T> {
 }
 
 // MMIO regions support 8, 16, and 32-bit accesses.
-impl_mmio_io_capable!(RelaxedMmio, u8, readb_relaxed, writeb_relaxed);
-impl_mmio_io_capable!(RelaxedMmio, u16, readw_relaxed, writew_relaxed);
-impl_mmio_io_capable!(RelaxedMmio, u32, readl_relaxed, writel_relaxed);
+impl_mmio_io_capable!(RelaxedMmioBackend, u8, readb_relaxed, writeb_relaxed);
+impl_mmio_io_capable!(RelaxedMmioBackend, u16, readw_relaxed, writew_relaxed);
+impl_mmio_io_capable!(RelaxedMmioBackend, u32, readl_relaxed, writel_relaxed);
 // MMIO regions on 64-bit systems also support 64-bit accesses.
-impl_mmio_io_capable!(
-    RelaxedMmio,
-    #[cfg(CONFIG_64BIT)]
-    u64,
-    readq_relaxed,
-    writeq_relaxed
-);
+#[cfg(CONFIG_64BIT)]
+impl_mmio_io_capable!(RelaxedMmioBackend, u64, readq_relaxed, writeq_relaxed);
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index 89f4bb483a7f..e67c1e3694fb 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -9,6 +9,7 @@
     devres::Devres,
     io::{
         Io,
+        IoBackend,
         IoCapable,
         MmioOwned,
         MmioRaw,
@@ -84,32 +85,57 @@ unsafe impl<T: ?Sized + Sync> Send for ConfigSpace<'_, T> {}
 // SAFETY: `ConfigSpace<'_, T>` is conceptually `&T` but in I/O memory.
 unsafe impl<T: ?Sized + Sync> Sync for ConfigSpace<'_, T> {}
 
+/// I/O Backend for PCI configuration space.
+pub struct ConfigSpaceBackend;
+
+impl IoBackend for ConfigSpaceBackend {
+    type View<'a, T: ?Sized + KnownSize> = ConfigSpace<'a, T>;
+
+    #[inline]
+    fn as_ptr<'a, T: ?Sized + KnownSize>(view: ConfigSpace<'a, T>) -> *mut T {
+        view.ptr
+    }
+
+    #[inline]
+    unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + KnownSize>(
+        view: Self::View<'a, T>,
+        ptr: *mut U,
+    ) -> Self::View<'a, U> {
+        // INVARIANT: Per safety requirement.
+        ConfigSpace {
+            pdev: view.pdev,
+            ptr,
+        }
+    }
+}
+
 /// Implements [`IoCapable`] on [`ConfigSpace`] for `$ty` using `$read_fn` and `$write_fn`.
 macro_rules! impl_config_space_io_capable {
     ($ty:ty, $read_fn:ident, $write_fn:ident) => {
-        impl<'a, T: ?Sized> IoCapable<$ty> for ConfigSpace<'a, T> {
-            unsafe fn io_read(self, address: usize) -> $ty {
+        impl IoCapable<$ty> for ConfigSpaceBackend {
+            fn io_read(view: ConfigSpace<'_, $ty>) -> $ty {
+                // CAST: The offset is cast to `i32` because the C functions expect a 32-bit
+                // signed offset parameter. PCI configuration space size is at most 4096 bytes,
+                // so the value always fits within `i32` without truncation or sign change.
+                let addr = view.ptr.addr() as i32;
+
                 let mut val: $ty = 0;
 
                 // Return value from C function is ignored in infallible accessors.
-                let _ret =
-                    // SAFETY: By the type invariant `self.pdev` is a valid address.
-                    // CAST: The offset is cast to `i32` because the C functions expect a 32-bit
-                    // signed offset parameter. PCI configuration space size is at most 4096 bytes,
-                    // so the value always fits within `i32` without truncation or sign change.
-                    unsafe { bindings::$read_fn(self.pdev.as_raw(), address as i32, &mut val) };
-
+                // SAFETY: By the type invariant `pdev` is a valid address.
+                let _ = unsafe { bindings::$read_fn(view.pdev.as_raw(), addr, &mut val) };
                 val
             }
 
-            unsafe fn io_write(self, value: $ty, address: usize) {
+            fn io_write(view: ConfigSpace<'_, $ty>, value: $ty) {
+                // CAST: The offset is cast to `i32` because the C functions expect a 32-bit
+                // signed offset parameter. PCI configuration space size is at most 4096 bytes,
+                // so the value always fits within `i32` without truncation or sign change.
+                let addr = view.ptr.addr() as i32;
+
                 // Return value from C function is ignored in infallible accessors.
-                let _ret =
-                    // SAFETY: By the type invariant `self.pdev` is a valid address.
-                    // CAST: The offset is cast to `i32` because the C functions expect a 32-bit
-                    // signed offset parameter. PCI configuration space size is at most 4096 bytes,
-                    // so the value always fits within `i32` without truncation or sign change.
-                    unsafe { bindings::$write_fn(self.pdev.as_raw(), address as i32, value) };
+                // SAFETY: By the type invariant `pdev` is a valid address.
+                let _ = unsafe { bindings::$write_fn(view.pdev.as_raw(), addr, value) };
             }
         }
     };
@@ -120,17 +146,13 @@ unsafe fn io_write(self, value: $ty, address: usize) {
 impl_config_space_io_capable!(u16, pci_read_config_word, pci_write_config_word);
 impl_config_space_io_capable!(u32, pci_read_config_dword, pci_write_config_dword);
 
-impl<'a, T: ?Sized + KnownSize> Io for ConfigSpace<'a, T> {
+impl<'a, T: ?Sized + KnownSize> Io<'a> for ConfigSpace<'a, T> {
+    type Backend = ConfigSpaceBackend;
     type Target = T;
 
     #[inline]
-    fn addr(self) -> usize {
-        self.ptr.addr()
-    }
-
-    #[inline]
-    fn maxsize(self) -> usize {
-        KnownSize::size(self.ptr)
+    fn as_view(self) -> ConfigSpace<'a, T> {
+        self
     }
 }
 

-- 
2.54.0

