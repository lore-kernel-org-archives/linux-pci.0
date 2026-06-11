Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022092.outbound.protection.outlook.com [52.101.96.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD26A47CC81;
	Thu, 11 Jun 2026 16:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195324; cv=fail; b=cUE61TGEghyQlj9Chf8orORGVW/AEozv+VP8Jk+Jr8mzRTZ9AVMFNhJ5KeXnP7a3qq+bB8zB8aTTllZE0wkfH/7DlybA61/95+Oci9C00T6/swUDl0vEm+MsYByzl5PvmY25QHNKgHEv9FYMnrGILyD6G3ewP9Hn6znvFXE98Zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195324; c=relaxed/simple;
	bh=AGvF2/hSGFWEibxHYJRZxGGpo9SaGA+vZSfD5GYxu6o=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=QzTfbBiRFUcTLY/ecfeTVjQe9Lv+VZvpQb5xhYSOP9OCiIDb+90xBnh0OQoNCI0E87baYqQa7EnmmlqUGwNKACYM4eBWlw6RM9rh3W2Hp3xWfcD7LFolm0Tf4lHgeI0RzNvkwBHZnEw+re78XlVgIKF5yC6kuDTT3EP4NRSSGIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=OMRC8Isb; arc=fail smtp.client-ip=52.101.96.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="OMRC8Isb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6dD0pHV9dmWJwgLv4mvZCFVWu5TY2MJUjocD/7bEE2gNLcnX+NGi5SV8D/wS/1mDqX3Web2bhz6Snc5P2fRxeNMCrwn3V1C41Umhz+hgbMmvPxNXAotT6A2VzMczc5FG6JeN4IE41Jrlg1GFQylSmLP8NEth4VSvdiL5BqzN95KQLCTT5l+nrY3b9MyM9BZojv305jsy18o7VoRMQ/Q+Z2fnYxYLyt2iMaH++phIj53J8oYbQND8tWRucJ91dLXQq9BuoWsP6DdPXcBm1+Q80dJsOYrLvUcC2K9b3+cb92fNKtwVy950y09NQpIIc0yZWkIcFN6uuJPrcZQP22yyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPmicdJDeHPwAA+5x7f6CCnvjBWluXEwiR4ROiYGTW4=;
 b=RRmcnZNIb5a8+AyN9BvjbG+ZF0MibOPjg+ux4cX/6Gk0vWrYR/on/w+OMa45OwDmvqT3o5fzBRWi6jbU2sTzh3Mi2S82woyAc4fC4vJmcm30pnUBMVi5uLWFm7roPhvk587xuo4pvtk0KuwY0wtzSZEJu0JFG5IptXk17qOO3ute4X4cP3ogabf9jdiAju7VbxFmuMwr1hpj2a7fcVqkFVWKGAlsRHzELFy7EobAShhNTVxVrNi2B98jdfaTeqKtnr+dxi21p2AQzpORGNqLP0bfA60ZtJiApna+o0uqOdcPyAz26UXwUbcHQKQiWAkgrs878fh2pTAP77bcmSSEfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPmicdJDeHPwAA+5x7f6CCnvjBWluXEwiR4ROiYGTW4=;
 b=OMRC8IsbhfFmGzyPd23zI4NO3+dZY0/DYoDrdJCRrMh7sUPRXnxRjZPs0gKCCz/1pl6VdCaLicyOfpEFSIKStWyXPVGQFQhIlOQDGk/2tGTPTN9ef3UE0vSX6dH8bmMHn/GAs/WCQP9Rw/lSpt47Cwm+PFqUl5NS70pOqvIywDo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by LO2P265MB3263.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:156::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 16:28:34 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 16:28:34 +0000
From: Gary Guo <gary@garyguo.net>
Date: Thu, 11 Jun 2026 17:28:22 +0100
Subject: [PATCH v4 20/20] rust: io: implement `IoSysMap`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-io_projection-v4-20-1f7224b02dcb@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781195302; l=5479;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=AGvF2/hSGFWEibxHYJRZxGGpo9SaGA+vZSfD5GYxu6o=;
 b=bbZr8M7GrKpU1CS/yIgftjgU+co0rixsTFvsPYIgZRfiQRIyhe0ayexpgbqP6gK0Z+Y/GGbnL
 UE3PvMcpg0oDu+YwGx1HcMyAYtzo71lDv+sTkHVkrW0ierL9jRwzuC7
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
X-MS-TrafficTypeDiagnostic: CW1P265MB8877:EE_|LO2P265MB3263:EE_
X-MS-Office365-Filtering-Correlation-Id: bc9c7400-846f-4c4c-7ed2-08dec7d67b8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016|23010399003|18002099003|22082099003|921020|5023799004|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	PA1c5wlNR4F/7fecPliMjCBW6WXfS+4Rg8/SxCsUw3gePn0znJNSqWZqo5p07uDi8QNQO68P6QkfBXdwKz9x6jLckSP2olRIt25D+SIUCQycjj6UI1HoZs5LZ00TRHmhc+kzNb4PA5Z3WPqUaocDGCCqr7pbEWHem9o95DuVs0TM6ncwIjvKRASp6CBp98v8fxq+3Mk4R1S9t6jGKakQ1eiqhDUBv0iNrxuDGz62DTiZPmWyeJdqLty2yyqjlNuwPv8PgaC7qG1ZiRZGPo64f1sSSiKlAvcdc1T833Mv+mZ0MT4A01viM0C58rOamDIPcusn2K0h7zY0p7mDVGImhbYZfsfb04hYHxtZslT5RKPySwFAgnsijoXMFhIQMkhSWFSz9N42IBZrYqik4sxSd1hhDSprGI6ige2dC6txhjjzP7Ub+dYcrht/9DfVp9VuiwwDSM9xLtZBG76igZ2szTpAmsZ2hYEVoTVYmWpm2YbTgQHAUet2Q4FDvXPymAQMZMCQY2iVcvzz6yFXdy+/OarCj4IzgC2skWOifUiRYyESYa0rDii1GwVmnWdoJPy9cQCLQD3NO28SdNdJTm+fnP0TPVgfh4m6tOBJtAE18PgPHscheI/ZTAD+I5tXfUekMy53cCMRUeWFMqHbuSDf83SsrDXpS14KaLVcRRNjjIosE2ulhDEnsRpEXXHlh4FVnDfiEeD0oO0MXPito2xd/5NsBg/Bu2O4h9tadsoDDIg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016)(23010399003)(18002099003)(22082099003)(921020)(5023799004)(6133799003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDlMNG1GUGpnbDhad2NSU0t3ZEljRmtRVzA5YzJTV1ROQzVndW1aZ29ITU52?=
 =?utf-8?B?RXVOUy81RVcyYVNQK1BUbVMxZXpSOUs4cDJQNTlIcjZXbkdmQWlYbWhaek1U?=
 =?utf-8?B?YUJxNDRpL1BEdWlKTDh2ZEtrcHFGcFJLKzNXazc4UloyTFUxZG1wMVJOQTF3?=
 =?utf-8?B?UE1wYVQzZHUycHAzRWxyVWl4OWFnYUU2MWpocEkvU1JJWGJJSkd0M2w5L3M5?=
 =?utf-8?B?QU9taVRMNGVmZE9ZalNaSFJ1Yk41M0tVRFNDTnMrRThWaCtibFVmNXZWL2JD?=
 =?utf-8?B?OEFYV1NGRWhXOEZUVmd6WkZyc2J6bm5HVlowQnlQNDh2TkdaanpKVW5HTGRw?=
 =?utf-8?B?Y2xRSkJKRXFPVUhiTitIaDFXamUvL1FRVm8vbXZEVVNEWXVOUmtJRDJxTzlW?=
 =?utf-8?B?ZWlCdVRFckNXZ09xaHE1dTJMMWxHSXh0eE05eWtCUmErL1NZUmR2a1Z6ZDcz?=
 =?utf-8?B?UTVnTFJZNDJsUXkzcTFST0dSUjFoVkc5ZUpNbGVaYVh6RmluN29EL2RQaUVx?=
 =?utf-8?B?d0RqV3dMbjdxQUR4RGNlTTlLVVpRUlpFcndKWU14aVU5R0ZXOUNpTEdXZWdt?=
 =?utf-8?B?NzFzS0syUjNMUlRucGw4QnZwOCtSUFhaWnZPRlZ4L3JsbCtQM05yS1BBVi9R?=
 =?utf-8?B?akcyRmVOVFlhQVlXSXNZYm1zemd3eHgxdkdnNjJXT29uYmdmM0hBbmZrOEFH?=
 =?utf-8?B?SENtQmMwSUZEc2J1TU9Hc0x6NlJsbzlCTW9XRmRqRk55Z1l5SjdSMlZGU0FP?=
 =?utf-8?B?MkIrb1lTaHFTek03cjR1UGJDdG9QbEI2aUhmaUgrZ3pQNjBaZWJCRW9EdXhZ?=
 =?utf-8?B?Z0lRTE5zdXpBZk1nWlZPeWtUZEJzeTZDVGR2L3o1NkhoRmx3RmQ0Q0pESmw3?=
 =?utf-8?B?R1RXNEhWOVAveWtZU3VxYlVtN1NhcUFzUnlVZ2lNWlY2YjJvNFJpS0tZeU9S?=
 =?utf-8?B?bDdRaUpDTGdFNThQc21YVHdqQlJyLysyeldrRFVLMWJ2S0swQ3cyQVNkRnNE?=
 =?utf-8?B?SEpzem5xVmxGTUNvSkpGT2crUFZJRm5HZ0pxNW9nSHJsM3VwVWdmVm9IaG5p?=
 =?utf-8?B?d3ZSWUw1dFVPUUxJbFN3QWR1UGVITEFXZEgzR3VqSWpzSCszUG1wazVCbi9v?=
 =?utf-8?B?UCthNThOZlRXb1pwVVNJMTBFN2oyeFhLYVNFd1NnZjJVcGlVemlZVWdETWNH?=
 =?utf-8?B?dmM1RGc2SnZJOTZpa3gyT2Zkb3F5eWNQWmpLcEpjTUJWaXVxRFptUVRWWHUw?=
 =?utf-8?B?V2N4K1RuMzRlU1F5eENtRGgwOTg0ajMzbE80aUhob1BQZlgzb3BLeEdqZThM?=
 =?utf-8?B?NWZnbVZ0UWNqT0JVUEwydjZiQndjK3NoOG13bnVxRWtnSFoyVzJkWHJQRDg4?=
 =?utf-8?B?RW1WN2tsTnY4Q2o0eVJVTkZGZDczSlp1S0ZXSmZQZFNPK25NTFN3SXZqQmdU?=
 =?utf-8?B?K29Pa29RRE55VjYvSEFjdWNLRm8xcTdxek5wMHY3UW9hM0l1S0RjUFlDU0hE?=
 =?utf-8?B?dVA3c2VPaVVwQUhGM0tTZnpMVFdIQjVGdDRJZ1lUc0pHcGdBQzJkYmVjWlRy?=
 =?utf-8?B?bUhLbmRNdENrcFZMMmtCVEpHbGJlWHBpSFVJTzloSW9Nbk1aRDlYSEVoODdl?=
 =?utf-8?B?R3RveURiVjJYZUdFMyswYm8rY1FRQmRLSXdpNFpiaWtKeHB3b29CeXNyVWZF?=
 =?utf-8?B?OEw5RERyNUpDOXVielIwSTFnMXZnNjRtVEtMaTN0a0N5S0I3OEoxTkJUemZT?=
 =?utf-8?B?VVNGclZDb09pK3RwRDI0bUhKb3g4U1lEVlRVclMxUldzZnd3ck9DT0FUWjQ1?=
 =?utf-8?B?Zk5MVTV0Ky9NRllJRzhDYWFzcGxBUG83R21Id3hIbTFWTFpZbXdiVVU1MW41?=
 =?utf-8?B?YnBDVWhnQXRDQ0NVa1RtNmttaEFvU09DbW5PSE5XSGhXZGFMNWZNOTRRYTdk?=
 =?utf-8?B?WUtOU0VwVVVVei9Pam1aL0FOc0N4MWNIbnlETThBUkRFdTlTR2YrODBzdlJp?=
 =?utf-8?B?ZURjUzk4U0Framc2NVMrbEtIaTdZSTdqN2hyWUV4ZVI0aXFzak9yRkJpRlF1?=
 =?utf-8?B?MG5UT3lzam9SWFZZZnk2ekNOY2RsSE9zbkh6eXdPYk4rU0hkeFVvV2hZYjdP?=
 =?utf-8?B?S2l2TVoxcHNlUkpvUmpvUUFPSUt0NWF2MzMrT3dPNUhCY0FucURRYzdpdEwv?=
 =?utf-8?B?ZmhLL1JJZkpYTDBQYWlwUUphMG90NVA4V0JQU0tMeUxWYkw2NTRleENROU1C?=
 =?utf-8?B?Q1FDanYrbW5oN3NFMzhHS1Q4UGxMNHVzckxQcHNBRTZFdXZ6WmU3Q20za2h2?=
 =?utf-8?B?dFBZTlV5WUU1dXNiYjArU1F5RXR5TisyeTAxcGNxaG9kK21lMCtOZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: bc9c7400-846f-4c4c-7ed2-08dec7d67b8f
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 16:28:34.3938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WNvZtOkkI0CSnlKy68g/hwiMK++9aoMVnuvhtXyIMSv2zZmqDvhh459Ob18MZRKdkaQFqY3Ol9GXTDISNyC5EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3263

Add an enum as sum type for `Mmio` and `SysMem`. This serves similar
purpose of `iosys_map`. Thanks to Rust's type system, all of projection and
struct read/write can be handled by the generic I/O projection mechanism
(i.e. `io_project!`, `io_read!, `io_write!`) for free, and there is no need
to provide things like `iosys_map_rd_field` or `iosys_map_wr_field`. An
enum type also makes it very easy to construct or destruct.

This could be made more generic by implementing on a general purpose sum
type like `Either`; however this is kept specific unless a need arises that
warrants this to be generic over other I/O backends.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io.rs | 135 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 16f818d396bf..5cd4756cf237 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -1443,6 +1443,141 @@ fn as_view(self) -> <Self::Backend as IoBackend>::View<'a, Self::Target> {
     }
 }
 
+/// I/O Backend for [`IoSysMap`].
+pub struct IoSysMapBackend;
+
+/// Either [`Mmio`] or [`SysMem`].
+///
+/// This can be used when a piece of logic may wish to handle both MMIO or system memory but does
+/// not want or cannot be generic over I/O backends. This serves a similar purpose to
+/// [`include/linux/iosys-map.h`] in C.
+///
+/// This type can be used like any other types that implements [`Io`]; this also include
+/// [`io_project!`], [`io_read!`], [`io_write!`].
+///
+/// [`include/linux/iosys-map.h`](srctree/include/linux/iosys-map.h)
+pub enum IoSysMap<'a, T: ?Sized> {
+    Io(Mmio<'a, T>),
+    Sys(SysMem<'a, T>),
+}
+
+impl<T: ?Sized> Copy for IoSysMap<'_, T> {}
+impl<T: ?Sized> Clone for IoSysMap<'_, T> {
+    #[inline]
+    fn clone(&self) -> Self {
+        *self
+    }
+}
+
+impl<'a, T: ?Sized> From<Mmio<'a, T>> for IoSysMap<'a, T> {
+    #[inline]
+    fn from(value: Mmio<'a, T>) -> Self {
+        IoSysMap::Io(value)
+    }
+}
+
+impl<'a, T: ?Sized> From<SysMem<'a, T>> for IoSysMap<'a, T> {
+    #[inline]
+    fn from(value: SysMem<'a, T>) -> Self {
+        IoSysMap::Sys(value)
+    }
+}
+
+impl IoBackend for IoSysMapBackend {
+    type View<'a, T: ?Sized + KnownSize> = IoSysMap<'a, T>;
+
+    #[inline]
+    fn as_ptr<'a, T: ?Sized + KnownSize>(view: Self::View<'a, T>) -> *mut T {
+        match view {
+            IoSysMap::Io(l) => MmioBackend::as_ptr(l),
+            IoSysMap::Sys(r) => SysMemBackend::as_ptr(r),
+        }
+    }
+
+    #[inline]
+    unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + KnownSize>(
+        view: Self::View<'a, T>,
+        ptr: *mut U,
+    ) -> Self::View<'a, U> {
+        match view {
+            // SAFETY: Per safety requirement.
+            IoSysMap::Io(l) => IoSysMap::Io(unsafe { MmioBackend::project_view(l, ptr) }),
+            // SAFETY: Per safety requirement.
+            IoSysMap::Sys(r) => IoSysMap::Sys(unsafe { SysMemBackend::project_view(r, ptr) }),
+        }
+    }
+}
+
+impl<T> IoCapable<T> for IoSysMapBackend
+where
+    MmioBackend: IoCapable<T>,
+    SysMemBackend: IoCapable<T>,
+{
+    #[inline]
+    fn io_read(view: Self::View<'_, T>) -> T {
+        match view {
+            IoSysMap::Io(l) => MmioBackend::io_read(l),
+            IoSysMap::Sys(r) => SysMemBackend::io_read(r),
+        }
+    }
+
+    #[inline]
+    fn io_write<'a>(view: Self::View<'a, T>, value: T) {
+        match view {
+            IoSysMap::Io(l) => MmioBackend::io_write(l, value),
+            IoSysMap::Sys(r) => SysMemBackend::io_write(r, value),
+        }
+    }
+}
+
+impl IoCopyable for IoSysMapBackend {
+    #[inline]
+    unsafe fn copy_from_io(view: Self::View<'_, [u8]>, buffer: *mut u8) {
+        match view {
+            // SAFETY: Per safety requirement.
+            IoSysMap::Io(l) => unsafe { MmioBackend::copy_from_io(l, buffer) },
+            // SAFETY: Per safety requirement.
+            IoSysMap::Sys(r) => unsafe { SysMemBackend::copy_from_io(r, buffer) },
+        }
+    }
+
+    #[inline]
+    unsafe fn copy_to_io(view: Self::View<'_, [u8]>, buffer: *const u8) {
+        match view {
+            // SAFETY: Per safety requirement.
+            IoSysMap::Io(l) => unsafe { MmioBackend::copy_to_io(l, buffer) },
+            // SAFETY: Per safety requirement.
+            IoSysMap::Sys(r) => unsafe { SysMemBackend::copy_to_io(r, buffer) },
+        }
+    }
+
+    #[inline]
+    fn copy_read<T: FromBytes>(view: Self::View<'_, T>) -> T {
+        match view {
+            IoSysMap::Io(l) => MmioBackend::copy_read(l),
+            IoSysMap::Sys(r) => SysMemBackend::copy_read(r),
+        }
+    }
+
+    #[inline]
+    fn copy_write<T: IntoBytes>(view: Self::View<'_, T>, value: T) {
+        match view {
+            IoSysMap::Io(l) => MmioBackend::copy_write(l, value),
+            IoSysMap::Sys(r) => SysMemBackend::copy_write(r, value),
+        }
+    }
+}
+
+impl<'a, T: ?Sized + KnownSize> IoBase<'a> for IoSysMap<'a, T> {
+    type Backend = IoSysMapBackend;
+    type Target = T;
+
+    #[inline]
+    fn as_view(self) -> IoSysMap<'a, T> {
+        self
+    }
+}
+
 // This helper turns associated functions to methods so it can be invoked in macro.
 // Used by `io_project!()` only.
 #[doc(hidden)]

-- 
2.54.0

