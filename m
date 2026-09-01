Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021101.outbound.protection.outlook.com [52.101.100.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801A3481669;
	Tue,  1 Sep 2026 16:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281445; cv=fail; b=cbU/YCZz0q3W7fYNScW2/iOXsgRWXTFXkEOHeLV0F/pQ16e9dM42p/S8sH11zr5wqSkAbaRzGGWsnQbMmIWRS0MIj+i+Ccyi8KcUWwBeOVY+e+2xtFbRlgpmu8GJuso0t0aKZfMFQjnCDcZkBEiIuyW+O84NPTPPDGY6OhxwfLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281445; c=relaxed/simple;
	bh=sSdw1Dv5hlsSyV6K0T7adkobqSvSgIeuYjKeEZiTdAE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=aDspcRBU6jEbIgjkGQGDVeIjro7CI4gIHXPltKq+Ow5Rcrtyh/UCaK05SfG+ZPQgxU1PVyLlYH1BNrjPuczZR3SePn12DaTQBrruyYnReIZbERrjf1yPhnE92RaxLyVAWuxff5nHv8y7IyU1gkDteC/Ejgm9xiK87LlCIypGSqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Es/yGJVh; arc=fail smtp.client-ip=52.101.100.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="Es/yGJVh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mGlhk9cuh8+VK/dEMT9I9u1tap+fMMBQCMVQRMcdKKOPkgZHh75HP5R80TZsL9p+Twz1EyvAtcCkSXWeP4VzjtShvmH/614UQGLBrY92v+AOT/4ooLM5aDB6rnfG17AKG9JZfo804IcZOtotJTC2EAIGTbPD8aYTfCZTNhJdHMPd5HSsis/bamVxMpdWFiKQ0Sl/1GIEB+JlPEpGadVMuF15AOoJ//pWvHFvUDQCMJsBXf1L6mYmfwU5c7FK76c0l4hua64cJo7FsvrTaLoELTyK1Qk1gpuJR0S+kGgAzEOJIHzVV8yXqXRC+CJ2XLDuCLuFd6uJrLLknsjIWFs0LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDHJXJ/+khNEoOPvYRZ9OmruChe2fAgBcIw89OaS+4c=;
 b=AGzlv9SpwAxqbcfdXVL1EJf7kIePfrtcVzieJObdEcGvSPWZRKU4ivYf0iB/IfMBSjVQaRfCEkILsEAvY6GCUPFN+W/B+rMxREySyLBHCyyoSqyGul3IwDrCfJV5ruk5kgoN5g55ZWZLjEeom78PxmAjel/LBnkXSdz1xDBH3L+tdjFdLjMPx/c9IDcZ5P/V6+SNxS56FY6lChLsVEfaVElBcLfh2Fy/OD7zqukIlG76yaz0j+qoN3VkbjjDpB3vdXz6KmEBOdgMoosCqq2AQYJxYQP6odz2G90uWVSnPNfMqtrY0eWp+vFeP/gQ2voLe9YQGhIwvYF9TarZS8uiCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDHJXJ/+khNEoOPvYRZ9OmruChe2fAgBcIw89OaS+4c=;
 b=Es/yGJVhu/Q75rUdASuW1gfu387vGTpC2fNgglRy3qsEHPjxjYTgbRs5qYYP0HekAplxR/a4YguSt/lkPizEyI5tLHB2KxuyRV854NDfBp7siEyrBNxm8I9wF1rQFHLT/OYJdJAV+UW4bFxKEdilBYBbzOte8VDm4xHryfGRKVE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CW1P265MB9199.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:272::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 16:50:40 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 16:50:40 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 01 Sep 2026 17:50:33 +0100
Subject: [PATCH v4 09/16] samples: rust: pci: specify base type for
 registers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-typed_register-v4-9-5552b1d59525@garyguo.net>
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
In-Reply-To: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, 
 Gary Guo <gary@garyguo.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788281431; l=993;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=sSdw1Dv5hlsSyV6K0T7adkobqSvSgIeuYjKeEZiTdAE=;
 b=BGW+bCFaAxx/XFZbYYhjY7dh4ectiA84l9SMk5lqC3cPQikq0d/Mi3DbEgjozYq7FEKL6J6Wy
 4BX8BbZpb/bBFSR3JlV3AkHEb+iWiDTCdjWz7sktrgDU/BQD1+j/2ih
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: PAZP264CA0173.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:236::16) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CW1P265MB9199:EE_
X-MS-Office365-Filtering-Correlation-Id: 036a5c3e-54f4-4da7-363a-08df084927c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|10070799003|376014|23010399003|366016|921020|6133799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7M6RLwvUXy2nk9IPTarJOEQQ4u3exZ8sIDX5uKFtw39Vbg3RBJrMPKc7sZo6DR3v7ufRRUtI6n78UewWppK1S9MGaghJuiKaWJ7XSBH0zADOhom9RBTnWq8sFk9g4GdvxWAvHT10iVHWC0vUi6vNi9YidpG3dcBLTitqDx4oTY4UjfDvbQJFYr1VkpNbMm8qpIlgwrrPFC1xUmimK4vIv1SAhg5tyUwQxNYH+qkJ2KL8TH/ry8+sFFTFPftthhz/OOeUGFMZnuhvYcGbCPRsEQWbirp4wgvVq9lgLJ18YYtj36783gySLXlSPe7lr1+7KscbGyA/SBlG02IPuEbt5ZB8zG6lPxUOLYW7IhUsQ+CA4elnAqi3kEVtWq+x+adbdKivq8dZGEB+vzToA0ZXLo22svhEtxRT7vnaotbEMbcmw280DqOx/SdvwkgWLPwXxiOphlmm8HRBQpKZ74sgx0iPwrQe/U+8dtcMlHKRKBJpEOB8Az6r6Jmb45m8HvzbQn22E/6HYVH4IWpOUWg95lWIKrQR47/1f/x6iWL5fV1mH77MRNYOKlWltlw2l/lfCdKac+ukYlzDIyIe3gpzF+3C+xD8h5SHZPxzYxoaaOr1/Vl3ExvRBs8124yFzBZUaKkRuTNPFhAsX8y3VdseQPURN2A4foxaBd2PP+4AafvTVltO2OuSpq/6x6cz4UFwrD6YxGI+b1ukRVA+CSYLBw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(10070799003)(376014)(23010399003)(366016)(921020)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzlSMnB4MGl2SDRIY2FaVmRpaDNkNHdKekU2MzdDNXRUaEdhZGs4a0JXaU5T?=
 =?utf-8?B?VDNqbkIxdHVYank0SS9EMEFFdXdrTDJEbjRadm9lR25zVE0rbVMxTE9KMlhm?=
 =?utf-8?B?Qml3b0pKc3FubVZZLzIveWE1QVIreGxZaWh2aVVzbitlWFdOdWVBVW5DdUxi?=
 =?utf-8?B?MU9VWHRUKytQUlNFTDZOVDJ2U0U4YkxiUmpYaWMxRlZ6TGxraFB4SVZUamJJ?=
 =?utf-8?B?eXFHdkswL3k4USt5TzF5QjhOMmkzaDJzcFlKOHZ5azRGR3JPK2hTeWRHeXJQ?=
 =?utf-8?B?Rkw5QVpscTBnK1crRXJLQmtTQ1JIYVB3KzFucUMrdVJlWHJmam14OHErVTVU?=
 =?utf-8?B?MEhkY2hLRDFlRWYzOEx3VzlkM2kvckNuQzJMcDhJTm52SEFoUWtpOUdwMWMv?=
 =?utf-8?B?aFVUN2ZLOVQzSVRQdDFDYngyWWpkL1pwK1hDcFc2eENIdDJlMVFUejVENnph?=
 =?utf-8?B?b21MU3BzVFF2RTV6V2NBVTdmd21aMFJ0RjQyREp0OFFaaFFTbzFWdmMxQSs4?=
 =?utf-8?B?WkZ1VXo0ZEZoYzdETm1BY1VRM0NiY2JaeVR3amZtZFJyZWFjUWx1aXY0MENI?=
 =?utf-8?B?RFdtNXlsQVBreXQ2a0lsazJaMnphL0hBM0tzR2ViMm9naWdHb005VUFZbXI0?=
 =?utf-8?B?M0NzamFZZ3BnamxvbzN6L3h2ODhzUWw4c0xHLzh4ajU4SjMyYW1Sa0lxRlpa?=
 =?utf-8?B?bEZQL00yQlFwQ01uUnFoUGE5amhpT051RFFIemZYa01HYjNnc081QmhXR09H?=
 =?utf-8?B?QnVUZGxZQ1c5emNOem9hdmd3VEF0QWw0U1NVNTBUM3BuZ0FYSFhIZEdVeXd1?=
 =?utf-8?B?VkR5TEJlVi9NcXhzM1l3MzlRR3RQMmczcmxFVVRhZ0ZyUmtkelR3RjRMVXcr?=
 =?utf-8?B?Z2o4eG50S1lhcUlyckxuc1ZRT2FUK3p4R2FWazN5SzAzcjlweVFlSTkzVGht?=
 =?utf-8?B?djFuVFBUTzd4bkZrTTVvQmd1dWFkWFViT1BlUS9DWEhpTTZ4Q2hZdGtST0Jk?=
 =?utf-8?B?RmFacitZMGRWMlU2YW1DcDRrclEwSVUxVTlLRlBNais3c0E1TGpTQkd1L1dF?=
 =?utf-8?B?SExnMWl2bis0ZS9ZSVp4TXpzOHVRN0x1ODdMSkZ3YitlYWRVTHpiZmY3cGxE?=
 =?utf-8?B?Q0VZWi9DaXFMN1hnTU44TTZTUjRDZW1MdzVkTFR5V1JWT1lDU3hETEQ4VGs0?=
 =?utf-8?B?Zm5RcEp6TmFlWC9ZTms0bStpNmxkMEh6SDJ0WWdKaWR3WGZrbDBPOEhQanhh?=
 =?utf-8?B?V1pwK2hxV2o4aGdpeHJrb2Zpb1Jmd0pwY1dsQ1NTU2tudnhVMktjRk8weTdW?=
 =?utf-8?B?TnJtYnROa2xXQ3dNcmFpbzlqQlcrUG5pMy9zRW15emtvdERRVU9aZTVyQUFN?=
 =?utf-8?B?ZGJtTlNQZzlmWUhmMCt4QnNEVzdvQVFOeTdxK21PVzVJV0hXVm1BcUQ1Qm9D?=
 =?utf-8?B?TFZrTzRLZHpGSmFCWC9wcHhwelFXMmpNNmNienU1OHdTbW9wdit5TEQwVWVO?=
 =?utf-8?B?bDhnazF4QWNjTmZ4NDZZU056OTlRUCtWUXhpenhvdnp5T1FrdURUSWJoTEdU?=
 =?utf-8?B?RDF5QnFqSi8wYmNDbU9WbDZRcUVRM2VzMlhjQUlHMnRqTDM3SDNOWktMaTRV?=
 =?utf-8?B?S1VvejRXOVZEWW5RbTFkT3I1NndCVUxidlEzQmp6M0hQMm5KYU9yeU54SmRx?=
 =?utf-8?B?VTVrbXVFeFZOUlI4T3ZTQS9KVmVXNDN3Ymt2M1J5RktyN0VndkNOU056NjBm?=
 =?utf-8?B?RHZhODVzaE5Na1RGaG9HODhGOGt5Yy8rUlcxMVRuTUl4cy9FRCsxcDJNWC95?=
 =?utf-8?B?dnJiNnM1WFl6Y3hCQ1JWaGg0aGZNcDlxcEhvQktmUlVna1F0dEs1YTlkMEVn?=
 =?utf-8?B?NzdNTDhJNS9xWXVRb1g0cTRQT0lGb0RrUUNRVEM2QWlJZGpIOFlMUGg5Q2JI?=
 =?utf-8?B?WjJjQko0NXpRWnlmTW1kNmtNc1RrUFF1ZWI1WVY2cVZnVzRjT0l2aE1SY0t2?=
 =?utf-8?B?WDBBajQ4L0ZtYk1JeDN6YmhPMnQ4S1hldGJtSDdLUk1VRnlXMnRmSFhubEpW?=
 =?utf-8?B?djBZSkNGdXRhSzE2Vk9YbHdiZXF0NHpXQjZwNVkrV1gwdmEzaHp4aFExclBw?=
 =?utf-8?B?U09keXo5Tk00Z2tZRVNNZVRCNzlCanRxTHFhQ25PWjBuZTJRZzJYb1Q0MG85?=
 =?utf-8?B?cWllZ0JqZndnUE5XQWF2UjB0SkUzK3JYc2tUMlFrMjZ3MnFWZFZnNGNNcWVJ?=
 =?utf-8?B?c2Y3SUdtU3lsaWVPeVplM09UVFZzRFpSeTZSaFhZaEd5UXFZeFg1S3IxTU1T?=
 =?utf-8?B?b0p1MUN6M0ZLbmp1TmgvVDNhcG5tWHJueHlQdlAwamNyWEpqL2dRQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 036a5c3e-54f4-4da7-363a-08df084927c2
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 16:50:40.3329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJGX04a9YxfUpmwQwwih7lDO/UHsYrC21rbgfrTnjSXpMl8l64uZlfYCCn8LFvNNYlzUXAitoyGzvPpfJs9c9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB9199

The `register!` macro is going to require explicit base type, specify it
for both `register!` usages in PCI sample driver.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 samples/rust/rust_driver_pci.rs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 2282191e6292..13b035a95756 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -23,6 +23,8 @@ mod regs {
     use super::*;
 
     register! {
+        base: kernel::io::Region<END>;
+
         pub(super) TEST(u8) @ 0x0 {
             7:0 index => TestIndex;
         }
@@ -102,6 +104,8 @@ fn config_space(pdev: &pci::Device<Bound>) {
 
         // Some PCI configuration space registers.
         register! {
+            base: pci::Normal;
+
             VENDOR_ID(u16) @ 0x0 {
                 15:0 vendor_id;
             }

-- 
2.54.0

