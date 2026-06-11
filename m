Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022106.outbound.protection.outlook.com [52.101.101.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A46D44D6A1;
	Thu, 11 Jun 2026 16:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195323; cv=fail; b=UWkrr1aFgHHExiP/FArhYxoRIWTUy3f2nE1OgK02rmUIFPDpWxvHfXalSHI3GjS1uHEw/u6nlopmsGNf8IB45uNqCAvjtJydQghWKXwgl/HEeueTb77yJ2o4A8mpiHBa9zUSW/OjcNkDyXm03X7RL5DJq2jbMC7AB3/9toOaJBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195323; c=relaxed/simple;
	bh=yTxNVoexkQa5ghSRgiZ4IDZUMzahHs98bJoJqFesjDg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=dBlfVmMXKJXl9Qcn2TlR45b6xUtWRS5GhfFd07d/QlCT48bwMXc04juhLF6vTwHz60O30lY9nGm9JBwRQO/B1E8p7EXnw0xzvkXmhg8d5lgc5lM9NL65c8ukdwS6WCerDgiE8wV/bn9epne2Se924dNfKk4IGGRPcPOPyCMXrlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=zzwx/o72; arc=fail smtp.client-ip=52.101.101.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="zzwx/o72"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oDdwgxLnMYi3UICnXrhxn7Ji5gCxd3JJNf+YAuMowpVs6wav7/gnW6sgqCg71hdwiwmd74ubXMppy2OZHYO1T7jOMXtACXUtIqPW1KY3lT1p3Kvrc9X6c3HehEbvae8gPC730mFXPGgAGdLqMPakClKvVKtJ2TZdoYF1YsQ4sAQUf8TznYchaMdX7Q05ENgrRDzUQcOcxYx3uN0ASuVI7kNUgSwjR3z9gD8XRFQkaal4/ngqNEPfDjNbR1Wq0oFjf2pDZskqbzJUT2pf6HRW4qYPTuXbRoL5MAppUHAabY/2H7N9cx4vDaIwKDR0a9Hw+7skGNYjYmhH966Gi6x/Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CU3aq4g1wJ41mMYj2EqQEpAh/FCh6owb2V+lttrlG+I=;
 b=gLUUb6WyQ8pRKnV/fsRzYDnmfj0VYC95PKhL7/6ebQuVqG/yoZLf0bLgMOpxRQKIzzEXJzbx20iM3DlKv+DkibNtlrT/ReU8hcdxWTp1c3fUqUDEc9HiPngoI6ud8pv+8nG1ojZ9OFkfodJjJtjoa17hLwq12gVDceuQnQvthQ4zI54umhSK2Z5ipcmw07aUcNyxtsJmC/+ffdcP06aOKhf5Jc2On/LfVKFU5/8Jfcmf5pHj+gYWOLej8zmOjQY8AKkXMlFGBNtonp9LEmkOyfCuJ5B/iVCTjjGuv5NJTSytj2kGn1W2vTA08J4IMy+nUD4O/PAC6Bfkhfp3pc6meQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CU3aq4g1wJ41mMYj2EqQEpAh/FCh6owb2V+lttrlG+I=;
 b=zzwx/o72edDVPcxJzHhPNytJIEKRH1EnPq/VIi411C8Ze0zn9/JyM8bBNZ1SfePcqE14XefI4IEmn0MDUZYrtpfe9/UYZ9kFD/eKZHnwGsVU+7F/WbD/a+WkMth0RfxHUWoccLzKONU2Uh1l/f6jvU1z15J423ypQ/6GSQUbydg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by LO4P265MB6525.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2e7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Thu, 11 Jun
 2026 16:28:29 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 16:28:29 +0000
From: Gary Guo <gary@garyguo.net>
Date: Thu, 11 Jun 2026 17:28:13 +0100
Subject: [PATCH v4 11/20] rust: io: move `Io` methods to extension trait
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-io_projection-v4-11-1f7224b02dcb@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781195301; l=6959;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=yTxNVoexkQa5ghSRgiZ4IDZUMzahHs98bJoJqFesjDg=;
 b=GG6s4jjIT1Nfjs3VO1gdInRVylFCHg0hKlxdTWHcNVVbcjGdjZ4icmjasx+yHiUPKHeyNSuCb
 ww9057mJqs0AubGbWTyrg0FAdgAjBAXJxndqvSFvQ7sZhR1l3oZgSyJ
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
X-MS-Office365-Filtering-Correlation-Id: 51f334b6-df05-4dd3-46ba-08dec7d67872
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10070799003|921020|6133799003|56012099006|3023799007|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	vks86nwaePNnp2ERbdmQqhxC+6QczAJtM1q9XZXA3LF4f+v+aEF0GSwz7ySXmjCYna1eeo/ZYGO4wpNwg97vI8w1HJ2TZ3RmWSAYkifs0ZYCCESxsp8vpMLrnbBVLGcw/AIf6dSHg0Es7dqx3ZTPzXCztRK2f/5fJgPNFJxPqgptgYxWEdFFdZBR5ydt/ljdtede2PNlrA7YivgJHpASxqONXYzAJ9VtFxnl/GRUU1aFY/s/0hgUu57os2VuQcpY/eHngMlqg6jenygnbF+VhdYcn5jDd9NHCOA/x4GeegazDfWbtY5mMA0l99UHiLu12P42QtXnUojTm340gFzNRhnGjFeW0+SI/HKvadYGjDgA805yhOUXeD6rrHeeMPTBLlY4buobngP6x3yR4QgThBJ+wzlQSoH19Vb9tDq3s8Tc/DSEkBpNP1jW3dR/zNAl2QGMmZlvbxuLJ87zc1j7Vjd0tQvwlUMydcGy2uQXDNZ4c0FKNNlUOPB2xw7/zh2/jv5h7ip+YeStd3EGcogvpxMukq+r7SMqB3sOXLeTclwt0QhPmO1u3+v1kCdo2wr5e8C2us1+BUPxZmHFGiyC8n494NfqQAEE2zUHz3D5vwFfzfoFq5IBVNXd9Ydd4jOEvk/thC57Q7D1eRfTK04le9xAZSYcl5amgphFAk/44kfCjFGv9ZelqaM5HzKVi7S8Qd17kwuJ4RnrfBCrMfZyhYEFjolFH3L9CwF/GNCaVeM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10070799003)(921020)(6133799003)(56012099006)(3023799007)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFlzOVpXSTcrZFN6UXNObFhvOEJGdnh1MEUwdHRUMzVJZVhramZQSHlQZU9E?=
 =?utf-8?B?Ui8zbFo4NEtOZ0lZMVFWWk14cFVOWndFV1dXNFFXTEUwZ050R0dUV3FVeFkv?=
 =?utf-8?B?SEg2ZFVSMGx1bEd4U1VwNTVHRTM0c3VTalUvUDlaWkd4N3ZhU1hzNC93YnZ4?=
 =?utf-8?B?MHJFT3l1eTdPR3BWMmQ0QllTWlplcWI1WFZwSG9tNmo2anJSOGF5T1VucjM1?=
 =?utf-8?B?bXJiemdWZGkyUzBJQVlHZzJGR2RjWGp2NVhleWhHaVVzMUlDcHpVVnpxRExu?=
 =?utf-8?B?L0hxSDdTd1hsdTZSdEt6MVdEZUIxL0Y5bEx1TnZXWENOMmUyaHo2VDVsdDVm?=
 =?utf-8?B?Zy9hWklhUFh5b2VDcnRkYnFIR2hBcGFLcUxrNThlNitwSTNNdWRoRFlEQ1hP?=
 =?utf-8?B?eDdITlFKNnd2QU5PNU9ubGh5Zmh3cW1BbWo2MnhWV0dKL3g3TnhZWnJyR2ls?=
 =?utf-8?B?OUZWU2t3dkVaNFVUak96anBwQ0hQNVZIMU83Z0dycTRQSmduckovRFgzbFJh?=
 =?utf-8?B?ZXc3aE00MUJLTHE2dUZ3aVUzdHVJZHhZWnpEN3l6Vm9VTmNUMU9iNDJGOXRk?=
 =?utf-8?B?VzV5UzluTXZVeCtvU3N0c2JXRk5NZ09MV3pBSE1ISUpOYkJpZWNrQUZ2Z0wr?=
 =?utf-8?B?aWFvWmxJR0tCdGxXazFhd0huNmtBUGg3S0MyUWluNVNNbWVxL1ROd2FrRHdm?=
 =?utf-8?B?TjBHWnlGZkZ1YnFXQkZGcW4zME0yM0FUSkpITVUxTXBkVFhNYU96cWJ6aU1h?=
 =?utf-8?B?UmxUbEs4K3U5K0RHNnNPL0pQVGpFRlFyeWJqRGZhU0dabGhaTTQyeWdzVHd2?=
 =?utf-8?B?NGR0SWNUd2w4MWJMMHJnY3R1MXBWM0hmbkE4Y1UzOVRNaC9wUGhCSGV1dmFF?=
 =?utf-8?B?MjBTMjVFRk1Cb0IvdlJKTEw5dERYbFdvRHVabk1Hc2dLTmxpV21QR3gyUWtj?=
 =?utf-8?B?UWpwVXd6RmltY1h1bUlNSGlsNm00Qm9XSVM0bUtFWnF0QjRyWFRHREV2K1pl?=
 =?utf-8?B?VHRNOWZTakZYV05jRENxb2RSNFZCdDlxRXRXbTNtMlpUdERLbVRsQVlXTlhL?=
 =?utf-8?B?b25ZODZmYW4wZytKcERhNFZlWmlOaFp2K2FHZGRFb0NMWjJCWXlZNW9iaGF3?=
 =?utf-8?B?b3JFdnArT2dHVUpFY1hNQWxDRzBMbXlOWkQrWlBRbDVsMlQ4OE9vd2lMeFZj?=
 =?utf-8?B?L2k4bHY0cjlqSWFVa2lWQW51aURodE16S2swM0c1WmtSd1RiL2U4Wm8rTGZ5?=
 =?utf-8?B?THd2Nlo3STFiTkxnL0lyNjlZYzNMU2ZVaElqdG01UDNMT2lXTGVOeFY2dFFR?=
 =?utf-8?B?d0VTcUtNT0xla3BuWVlaQmtZcjZoQkFyd091Ym5Zd2lGRmRtaDFCeklPRFQy?=
 =?utf-8?B?YU93S1RxdGlwekx5OFN6TnN1ZExUUGxseHpNcFgyN2xKVUFGMXZRQWVZUGZI?=
 =?utf-8?B?NGVLK0Iyd01naUVETmxtSkJpQlF5eWhueDhSdDJQdmw4ZGh3QzJIbSt6Q21L?=
 =?utf-8?B?VFMxLzFNNFRNdjRNSDZSYkRkY3VadkxGOVRESDNjR1R0dldYZCsrZkczSEls?=
 =?utf-8?B?SDZMUWhBVC9VN3E2T1h1NXU5VFFhVElPZUhuS0JqbGdkY0d3RTBTY3lxUXow?=
 =?utf-8?B?RWUyV1ZCaXg1STd2SklBbjVTTHNUaFpGUzRaUDJQQnJvUXBYVGU2OVdVZWtZ?=
 =?utf-8?B?Z0lPckd4VVFBeHZIMzNncExNYnNHditMT0hiQnZWbkluYlRGcDQ3cDhRYklo?=
 =?utf-8?B?Q3IzTVJyUHRCQXlSNzNiWmt4elhCWHdkd0tPYldkbzFFNndUQk9jOHIrSW1r?=
 =?utf-8?B?Sm02RlcyZWFMTFkzSjIwNUorM3N4VHd1a0xUSnp6aXpySXhQTXNXVGhmdHhP?=
 =?utf-8?B?Ui92S0VIaHRXK1BWRmUwWi9JRy94OS9NeDFqT3Z0S3JFRUNyODhWLzlZR25S?=
 =?utf-8?B?R0g5dGJhMXdGbTVJT1k3WmxRN2VWa3dWNHFudHVZS0xFdGRDL2wzSElTTjQ5?=
 =?utf-8?B?SHNXTEZkN05WbEY1RTl6MmRvQVRPb3JQK1FVZVJPTmpPUU45NTI1Yk1LUEJt?=
 =?utf-8?B?eTl3M2lPNmtBQWJUSExscG8zSU5EbzJDTCtpV0hlU1FSUFFLWWdLVDNiUEVv?=
 =?utf-8?B?L3ZtV3VYSGxFTFF6bU42d1pZdXpzdG5oNXNiS0l0VU9ZRzdSOWYvVTJnNHgx?=
 =?utf-8?B?cDBTeVJ4Zk4rQmRvTGR0dVc5RzVOYkJQelhQd3Q2Tnk3NS90c214cnhJdWhO?=
 =?utf-8?B?VnhENkdWZjVTaVBMZTVxK1kvUU4ySVpUUHFTZnJQQVE0WCsxWURmT29JQ1FD?=
 =?utf-8?B?ckhFN2hFNFg1Q2dVVWdVbDVHaXdib0FLQVp2c3pwTlg0cUdYREp5dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f334b6-df05-4dd3-46ba-08dec7d67872
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 16:28:29.1653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fnxQK+k/vbFzg5MgSFKqu34E3ahZXGQB+1SQy3NAjcAbB5VYC+6T3v/RrSav5tYREOdYKpSra2S2hetxzmz0Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6525

`Io` trait now has a single required methods with many more provided
methods. Provided methods may want to rely on their implementations to not
be arbitrarily overridden by implementers for correctness or soundness.

Thus, extract these methods to a new trait and provide a blanket
implementation. This pattern is used extensively in userspace Rust
libraries e.g. `tokio` where `AsyncRead` has minimum methods and
`AsyncReadExt` is what users mostly interact with.

To avoid changing all user imports, the base trait is renamed to `IoBase`
and the newly added trait takes the existing `Io` name.

A `size` method is added as an example of methods that users should not
override.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/devres.rs |  3 ++-
 rust/kernel/io.rs     | 34 ++++++++++++++++++++++++----------
 rust/kernel/io/mem.rs |  6 +++---
 rust/kernel/pci/io.rs |  6 +++---
 4 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 3545ffc5345d..6e0b845b229b 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -68,6 +68,7 @@ struct Inner<T> {
 ///     devres::Devres,
 ///     io::{
 ///         Io,
+///         IoBase,
 ///         Mmio,
 ///         MmioRaw,
 ///         MmioBackend,
@@ -105,7 +106,7 @@ struct Inner<T> {
 ///     }
 /// }
 ///
-/// impl<'a, const SIZE: usize> Io<'a> for &'a IoMem<SIZE> {
+/// impl<'a, const SIZE: usize> IoBase<'a> for &'a IoMem<SIZE> {
 ///    type Backend = MmioBackend;
 ///    type Target = Region<SIZE>;
 ///
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 132454a38d64..470ee2ed9849 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -184,7 +184,7 @@ const fn offset_valid<U>(base: usize, offset: usize, size: usize) -> bool {
 /// operation.
 pub trait IoBackend {
     /// View type for this I/O backend.
-    type View<'a, T: ?Sized + KnownSize>: Io<'a, Backend = Self, Target = T>;
+    type View<'a, T: ?Sized + KnownSize>: IoBase<'a, Backend = Self, Target = T>;
 
     /// Convert a `view` to a raw pointer for projection.
     fn as_ptr<'a, T: ?Sized + KnownSize>(view: Self::View<'a, T>) -> *mut T;
@@ -267,13 +267,10 @@ fn offset(self) -> usize {
 /// Types implementing this trait (e.g. MMIO BARs or PCI config regions)
 /// can perform I/O operations on regions of memory.
 ///
-/// The [`Io`] trait provides:
-/// - Method to convert into [`IoBackend::View`].
-/// - Helper methods for offset validation and address calculation
-/// - Fallible (runtime checked) accessors for different data widths
-///
-/// Which I/O methods are available depends on the associated [`IoBackend`] implementation.
-pub trait Io<'a>: Copy {
+/// This trait defines which backend shall be used for I/O operations and provides a method to
+/// convert into [`IoBackend::View`]. Users should use the [`Io`] trait which provides the actual
+/// methods to perform I/O operations.
+pub trait IoBase<'a>: Copy {
     /// Type that defines all I/O operations.
     type Backend: IoBackend;
 
@@ -282,6 +279,21 @@ pub trait Io<'a>: Copy {
 
     /// Return a view that covers the full region.
     fn as_view(self) -> <Self::Backend as IoBackend>::View<'a, Self::Target>;
+}
+
+/// Extension trait to provide I/O operation methods to types that implement [`IoBase`].
+///
+/// This trait provides:
+/// - Helper methods for offset validation and address calculation
+/// - Fallible (runtime checked) accessors for different data widths
+///
+/// Which I/O methods are available depends on the associated [`IoBackend`] implementation.
+pub trait Io<'a>: IoBase<'a> {
+    /// Returns the size of this I/O region.
+    #[inline]
+    fn size(self) -> usize {
+        KnownSize::size(Self::Backend::as_ptr(self.as_view()))
+    }
 
     /// Returns a view for a given `offset`, performing compile-time bound checks.
     // Always inline to optimize out error path of `build_assert`.
@@ -769,6 +781,8 @@ fn update<T, L, F>(self, location: L, f: F)
     }
 }
 
+impl<'a, T: IoBase<'a>> Io<'a> for T {}
+
 /// A view of memory-mapped I/O region.
 ///
 /// # Invariant
@@ -809,7 +823,7 @@ unsafe impl<T: ?Sized + Sync> Send for Mmio<'_, T> {}
 // SAFETY: `Mmio<'_, T>` is conceptually `&T` but in I/O memory.
 unsafe impl<T: ?Sized + Sync> Sync for Mmio<'_, T> {}
 
-impl<'a, T: ?Sized + KnownSize> Io<'a> for Mmio<'a, T> {
+impl<'a, T: ?Sized + KnownSize> IoBase<'a> for Mmio<'a, T> {
     type Backend = MmioBackend;
     type Target = T;
 
@@ -925,7 +939,7 @@ unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + KnownSize>(
     }
 }
 
-impl<'a, T: ?Sized + KnownSize> Io<'a> for RelaxedMmio<'a, T> {
+impl<'a, T: ?Sized + KnownSize> IoBase<'a> for RelaxedMmio<'a, T> {
     type Backend = RelaxedMmioBackend;
     type Target = T;
 
diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
index d9b3189d09b4..e95b769ebe47 100644
--- a/rust/kernel/io/mem.rs
+++ b/rust/kernel/io/mem.rs
@@ -14,7 +14,7 @@
             Region,
             Resource, //
         },
-        Io,
+        IoBase,
         Mmio,
         MmioBackend,
         MmioRaw, //
@@ -210,7 +210,7 @@ pub fn into_devres(self) -> Result<Devres<ExclusiveIoMem<'static, SIZE>>> {
     }
 }
 
-impl<'a, const SIZE: usize> Io<'a> for &'a ExclusiveIoMem<'_, SIZE> {
+impl<'a, const SIZE: usize> IoBase<'a> for &'a ExclusiveIoMem<'_, SIZE> {
     type Backend = MmioBackend;
     type Target = super::Region<SIZE>;
 
@@ -292,7 +292,7 @@ fn drop(&mut self) {
     }
 }
 
-impl<'a, const SIZE: usize> Io<'a> for &'a IoMem<'_, SIZE> {
+impl<'a, const SIZE: usize> IoBase<'a> for &'a IoMem<'_, SIZE> {
     type Backend = MmioBackend;
     type Target = super::Region<SIZE>;
 
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index 4be33ecb4192..4d1d0afdc491 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -8,8 +8,8 @@
     device,
     devres::Devres,
     io::{
-        Io,
         IoBackend,
+        IoBase,
         IoCapable,
         Mmio,
         MmioBackend,
@@ -144,7 +144,7 @@ fn io_write(view: ConfigSpace<'_, $ty>, value: $ty) {
 impl_config_space_io_capable!(u16, pci_read_config_word, pci_write_config_word);
 impl_config_space_io_capable!(u32, pci_read_config_dword, pci_write_config_dword);
 
-impl<'a, T: ?Sized + KnownSize> Io<'a> for ConfigSpace<'a, T> {
+impl<'a, T: ?Sized + KnownSize> IoBase<'a> for ConfigSpace<'a, T> {
     type Backend = ConfigSpaceBackend;
     type Target = T;
 
@@ -267,7 +267,7 @@ fn drop(&mut self) {
     }
 }
 
-impl<'a, const SIZE: usize> Io<'a> for &'a Bar<'_, SIZE> {
+impl<'a, const SIZE: usize> IoBase<'a> for &'a Bar<'_, SIZE> {
     type Backend = MmioBackend;
     type Target = crate::io::Region<SIZE>;
 

-- 
2.54.0

