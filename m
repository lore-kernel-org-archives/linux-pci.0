Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020102.outbound.protection.outlook.com [52.101.195.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A071A453A55;
	Wed, 19 Aug 2026 11:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787137832; cv=fail; b=NCr022u0h8Ln+9vdwkr2cJJVAkPfIRXCl+IGNyYFduNLc9jR8iqXxowSvmYLO2TC/NSZYUrFvKHRFrkZr2uF6LyKC/V/+l5QALgbol7LR8H3fFu4zChXZ8/qAjsTA7vS33pOxjIq0iYbPOSY7NhPpzRQPZrF8f1RuAvcbrNSDww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787137832; c=relaxed/simple;
	bh=P0E4tPfO7qfgNF+lFWa94pAJ03QSSk+2txS9i3ApG/4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=RQDuB+V73ptig4uPhiWQvtcgFrhTpVlzEXozmE4oxJ4b5eoe93fSR6Jst6LROZODy3SolgkqbkmybKyMYPf0jdpUrhHE4Zj+r1tSCmig+ZFiRQS+ORm7XG38bDWJd/xNzC31xAzXminXQKAKBJkfU8C9Q2FJ6ihcbS5HqBvyYt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=fYWqReeR; arc=fail smtp.client-ip=52.101.195.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="fYWqReeR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NP1E7TfAwlzltwq2YT805db/y5NXRHqHhgvgSwcOlZ7HUsMMSC9vHEpEFkYOIZ152hRN2oYvIz/J0gqINd6yvNdr4JuDlNB2d0mwcq3iKJiIk/GdQRYPe+2P5BAHJb0gdTJ5z/BvG3jXrdS+w6HjG69u49nCoFtcytKh5GoVfoLc9Xi9PFFlYgG9Q2jHdPeU1nAZSB/9nKe0RDIBbO0AeJciXiRkGuxCPRwPcNSHkLAlf45P1QKnqPhWfMqy1/0omIa3WUu56uoWbVWEGizymGfmqUrLT3yyBUiVp9fpa3EI6VMy/0JtrwFzhYfjz5QXr4wb2rJOMLMqcSdAjJC4Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=463CuS4BsuRP5CzzIs1yPaKtoEzbEnCCAdL7KAGQ4l4=;
 b=LtV4xr2Ou0QhzWIrT3tZ3BV/GdQSYlrkX2wlOihnbUmWNwyQBwxVHVWGaeqc2/ZUKgKgh3eedpUlpJpJjekv5Ar/9rQCY5VDCk6eULavJLvytWaHoVViRAQvwou4mc0PgvrDnm0poQg5gO9Wllo5+J9ffQMZTbXEXqKGIBVytF0pq4PVMkd6oFjtLqaPcOEDZ6Y8gSzqHOY58YevzxiHgs480p6MH+m3tZPlfM7WKgeKxZUZNYa+74Q9B/GcrSG4xuez/z4wfGplUYw2yUS4dlSmSpJ/X4URkarCRihJr9xszF/kmlmlZ1ZWJQ07AyNSS2gHS2hJLNa332QlPYgNqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=463CuS4BsuRP5CzzIs1yPaKtoEzbEnCCAdL7KAGQ4l4=;
 b=fYWqReeRiiFIxC44xBZWliQYszpouDV0FS0mYvAO9B7j1fVtnNYbrVd11NKofKnvBwmfJvc4/pwhcECxmzvLthwpF2peGE/8Eo/7KjORmh4/rNQz1ozF1YLV1F8q2nWT9zBFIVUkOP1Y3Cl3iRPvhfjnzaflnql92ZBAhUZbhmY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO0P265MB5167.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:283::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 11:10:15 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 11:10:15 +0000
From: Gary Guo <gary@garyguo.net>
Date: Wed, 19 Aug 2026 12:09:09 +0100
Subject: [PATCH v3 01/16] rust: io: register: reimplement as proc macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-typed_register-v3-1-3699a75fadf1@garyguo.net>
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
In-Reply-To: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787137814; l=21187;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=P0E4tPfO7qfgNF+lFWa94pAJ03QSSk+2txS9i3ApG/4=;
 b=m22lD9YsvllFChFefUAUzSSrMb4NUAlRnvEqfw1xt5ZT+aMT4XaTT6Su2xYaKYXkZySf6TNgY
 eOYcwO6pIFADAxYnpB6905nNtu/PqtG6B2z517V8pbh9kVJVlpWiTSp
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0096.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::11) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO0P265MB5167:EE_
X-MS-Office365-Filtering-Correlation-Id: e31e1659-68f5-4c60-a3ad-08defde27232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|23010399003|376014|7416014|366016|22082099003|18002099003|921020|10067099003|5023799004|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	GtODGBtj0sgmbW36595CqVe12r9S/VrT2yw/mB/RXQO8lUxPAtDwI4SxrFd4hK3SaOIqCFdx47Im4YaJb71MH8NqjnWOPWiHZMkBGE3OC+dL/1melbQTR8gVbnMqzWAtab5XdhJa9qbkeHNo26PqaQCf2cgpkuQP7kFFNnvapuDUCPHL0iop1fXnkrVHn9usgm7equIEFjiPXaxU6lNGpQK07ULdWgwy5GauL6GiZ3qDZ/sLSm9gyUAlKGRvN8Rt70onO7uX3rmNqs6DnqxdAc74I4cZHqVnCd4jurCsd+XpfQxd53MoxngipgqtyiQbK9HQZslaBxhptuBqO9DaBUMCLOYxjl04NmUfRkpp1RVkSRokcAVwMNdOyARQ5K75ep5h4e+MVDBCkVMYuHZ3X0PUvrcM3TXhmQFOKbvseBr9ktDkfg3COh8caDvwiz9hcWqsQ4jVNrdjBGCckfrWm9rXBDP52zF5DzniBHNsYclJvYREx5y4OK91sDFA9vpTYCc6ETD9QJIc4EZLbu9J13nAyKEm95PYBn0U9CkREsl2vj7t46zg0nsPGP83Y7kHIxJis5kH3h+LtH0z/hmnSR2dumhTX6tkKn5uyZjgPQSDNGEqFApv9AmGUNxqT0HUWYGY+4wYZU2OXvHEwq5uPSQJ9rLrK0y48Wl7RLn4d3Cn+1hYV1aLfk+o7J1MBsaZ2a0k3Nrm/j+4uuIevIGFTg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(23010399003)(376014)(7416014)(366016)(22082099003)(18002099003)(921020)(10067099003)(5023799004)(56012099006)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2lvYkNrVXBqU1EyZUpNUi9OKzhkUFlsNHVCQTBtTWVwOXBuN0lPNVZQQjB1?=
 =?utf-8?B?ZWVRdGEweDlxQmM3OXhVQURDa25xT2FIYlFsN2VjRGU1T3BqZWtkZTJlZHNa?=
 =?utf-8?B?aVc4VXVKVy9VVXQ0NzEycW56NHdvYkxyMUxkOGJ4blp4S05aY3NMaVlwdnds?=
 =?utf-8?B?aHFwZVVNSlF1WkRaSmJaSXhUTThIMlZuUGdvQVR2TnY3OUM0c2tnR0h5UUlt?=
 =?utf-8?B?a25aUlk4RDBiNGt4TWRFcExybFZzYmxZWC9uSS9HUU4rNzZ1Qk9pZEdZa2FN?=
 =?utf-8?B?UFFnUEtXSHUyT2xkZnJrUHNuUEk2SzJzbTNZZE42RGhhd2FYdnhHTFJFdHlQ?=
 =?utf-8?B?K3o5VDROK2FoS3FtSDk4d2hyZnk5WFJhdlY2V1FPM2JYaDVaQi8xekdtc1kx?=
 =?utf-8?B?RXNBb2ZLL09hUTBZNS95VWJxMUlFZ3BCNzF0YUpVeCtuemdtWTBZRHNqYWxh?=
 =?utf-8?B?clE2d3BleXFsb2ozY2NhamxpMFFRMUx0OHdDV3NwUlhpZlVjcFZicTF3YjRS?=
 =?utf-8?B?QWFSbFFuNEROOXBoVU93S1NhckhYdkYyRVdZUlFXWVh2anQ1dmtpeFlmaHB5?=
 =?utf-8?B?WVJYT21laWhna0Y3TmlxNERrMUJnK3JVekM3T3QwbjFmSXJMQUM3K01IcHY4?=
 =?utf-8?B?Y3ZBSDlyWGdiL0FyTTE0eFpFeGw4VTBZVHJHOWUwZFB2T3BkOEd5dENIWERU?=
 =?utf-8?B?RnRxN2EwRGtKYzd0MFkrSzROZVBJcUsvelladk9Dd0FTbnVxcWJRSCtkWmIw?=
 =?utf-8?B?MmhlZDhNMEp0SnAxTGFmMSt1WHlwa0lEeDVGK2hORTZPUTFJaDBxYnNxamhO?=
 =?utf-8?B?cE52enJwZmpmWEM1OHlVcVBGYTFjVFFQN1MreVBma1RFZk5GWk9XZUp1dUo1?=
 =?utf-8?B?OGpKMGVxNThuQldtcDlITDNIZTkxSTlnaXJtUUFvLzhjcmthZDc3OVFlMVZi?=
 =?utf-8?B?OEcrMGJuSWtOZW1BeTgrYUpnVnZLNFp0QkZZQWFBMGJNS2ZLemNjNzZveksr?=
 =?utf-8?B?UVVPTDdib0NjbWNBR0UvMUlhRTdITHo3NDJwRVJpMzhwVHlYbkdmUEh5Zis2?=
 =?utf-8?B?dXNLMHBLMVZVd0k5cG0xUDlSQndvRHRQQ0NLY1cwdGNXMURIdzUyTmcwSEZZ?=
 =?utf-8?B?bGJFL0VxRUhvRllsL1o4L0JGRGV6WjFydThSN0xaYXNwdzl6WUViNUhITVo4?=
 =?utf-8?B?RWJ3WDQ2QkJXQ1k5WkpmZUVDMTJDdFlLOHhwUUdrdSs4U1hxZXp5aTNqRXVh?=
 =?utf-8?B?bGJOTU1WTkhuUkwvN205Rk05VytDUzZVanRpV1A0M21ubTZQVUY4K2lnenZ0?=
 =?utf-8?B?dUdMMDdFSkdqM3gxb2pWWmczVmRIYjE1elRNMmpGRnM5Vk8vUVFUU3VESUt4?=
 =?utf-8?B?aGpyV3M0TVBlUzNCS2J1K3pNRmd4akYvYkMrK1dJWUI2cmd6OFJ4OTQwbXZ1?=
 =?utf-8?B?Z0dtN1JaQTJLSEpJQ2dlelZQek4rOEhjYUtTakNlWFVZR1pRWGhUNll0UytH?=
 =?utf-8?B?WEtHUWgvMDgxbTByd3BEeWZZZ1l2V0hHK1hIcFFnbjVWSnFXRTFrRnFSYzR5?=
 =?utf-8?B?eGtPaE5BMDg2YjBSZVl0ZWRNVXVRNXlaR2N1NWd4QW0vK3gwSmZ5dXBxdXVx?=
 =?utf-8?B?RVZScWRNZ0VxL20yeDlFNFZ5ZmJ5dVVXWjFaNld4MHB1UEJaMUhTN0tiaXpN?=
 =?utf-8?B?QjRqaCtHbmM1RUsvM1RiSVp3OXZ6V1NtMmJWTHhVQit2bFVKcTNwSDAvN0ow?=
 =?utf-8?B?d21XMDdmUzNFU3dVTmlFRFd6WU50TEI3UjhnOFd0Z3NlZFFuT2dBY29kUGJi?=
 =?utf-8?B?bG1ZMDl5T0Uza3AydmFCVTFpaENwOGRCUkNZWWNhL01teXFhVkJEMUNtV0JU?=
 =?utf-8?B?TVVNeWcxMlZURlVUWFRjb205V0RJR2dmbGpubnlWUzBKK0F1bGNzZ1hDYVNi?=
 =?utf-8?B?R2NFVGovTXNqQ3RBQW92OEdSVnM3V0oycUFqcEJncSsrSURKbStvR0dCTDU0?=
 =?utf-8?B?Y2VOM205aXBOc0NLb29LUnJEWnhtV0RYZXU5TFA4RVVYYkRheXo2dUVBRk95?=
 =?utf-8?B?cW1qUU5lRXVkN2dka2Z0VE91WDZQNWh2NDRyUXBGUWdML3pDTm5ZUEROeFN1?=
 =?utf-8?B?emQrdldHQXgzTmFkY1pKTkZmOHVROFo5VGlMRHF2V05LNEJXaDFGRDdEc2Ux?=
 =?utf-8?B?MWNYcFljUmlURndqNWJoVkdtWHBYZ3o5bnN5dmlwU01vWE9qa1JwQTBYRTNY?=
 =?utf-8?B?S3lSMzUvbVAxcG9XbU1QQ3JmdUo4OTJKK3BYRXN2K0xnN1RXeFpRV0UwL1Vi?=
 =?utf-8?B?REl0U2UxYWpMMnVBZVdFRGNuMWdnczJtN1d0QWNLYXgwYTVoTmwzUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e31e1659-68f5-4c60-a3ad-08defde27232
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 11:10:15.4599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TWNk4xlVE01CzGEfLDi9Ry+rfoq198Za8kzRLWPExOVnrmJQELF6qS6kicX+YjxfcQW7Mo0j4ioeghDRaMohKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5167

The existing `register!` macro is implemented as a declarative macro.
Reimplement it as proc macro instead, with no functional changes intended.

The old implementation produces unhelpful diagnostics when things go wrong.
For example, for code like

    register! {
        pub(crate) TESTREG(u32) {
            31:0    data;
        }
    }

which misses out the "@ offset" part of the specification, and the
following error is produced:

error: no rules expected `{`
   --> test.rs:42:5
    |
 42 | /     register! {
 43 | |         pub(crate) TESTREG(u32) {
 44 | |             31:0    data;
...   |
100 | |     }
    | |_____^ no rules expected this token in macro call

which isn't very helpful. With the proc macro implementation, the following
error is produced:

error: expected `@` or `=>`
  --> tests.rs:43:33
   |
43 |         pub(crate) TESTREG(u32) {
   |                                 ^

which is much more helpful. Apart from diagnostics, proc macro also has a
benefit of not having follow-set restrictions, which makes syntax like

    register!(name: ty @ offset);

possible; declarative macro will reject this as `@` is not in the
follow-set of "ty" metavariable kind.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 MAINTAINERS                |   1 +
 rust/kernel/io/register.rs | 224 +-------------------------------------
 rust/macros/io/mod.rs      |   3 +
 rust/macros/io/register.rs | 263 +++++++++++++++++++++++++++++++++++++++++++++
 rust/macros/lib.rs         |  10 ++
 5 files changed, 279 insertions(+), 222 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 637bdf68135e..c9f11fa9f2b2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7486,6 +7486,7 @@ F:	rust/kernel/io.rs
 F:	rust/kernel/io/
 F:	rust/kernel/irq.rs
 F:	rust/kernel/irq/
+F:	rust/macros/io/
 
 DEVICE RESOURCE MANAGEMENT HELPERS
 M:	Hans de Goede <hansg@kernel.org>
diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index 03dfd2ff48c7..6a19552ffb95 100644
--- a/rust/kernel/io/register.rs
+++ b/rust/kernel/io/register.rs
@@ -801,227 +801,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 /// ```
 #[macro_export]
 macro_rules! register {
-    // Entry point for the macro, allowing multiple registers to be defined in one call.
-    // It matches all possible register declaration patterns to dispatch them to corresponding
-    // `@reg` rule that defines a single register.
-    //
-    // TODO: change `alias:ident` to `alias:path` once relative registers are replaced by I/O
-    // projections.
-    (
-        $(
-            $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
-                $([ $size:expr $(, stride = $stride:expr)? ])?
-                $(@ $($base:ident +)? $offset:literal)?
-                $(=> $alias:ident $(+ $alias_offset:ident)? $([$alias_idx:expr])? )?
-            { $($fields:tt)* }
-        )*
-    ) => {
-        $(
-        $crate::register!(
-            @reg $(#[$attr])* $vis $name ($storage) $([$size $(, stride = $stride)?])?
-                $(@ $($base +)? $offset)?
-                $(=> $alias $(+ $alias_offset)? $([$alias_idx])? )?
-            { $($fields)* }
-        );
-        )*
-    };
-
-    // All the rules below are private helpers.
-
-    // Creates a register at a fixed offset of the MMIO space.
-    (
-        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) @ $offset:literal
-            { $($fields:tt)* }
-    ) => {
-        $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
-        $crate::register!(@io_base $name($storage) @ $offset);
-        $crate::register!(@io_fixed $(#[$attr])* $vis $name);
-    };
-
-    // Creates an alias register of fixed offset register `alias` with its own fields.
-    (
-        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) => $alias:path
-            { $($fields:tt)* }
-    ) => {
-        $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
-        $crate::register!(
-            @io_base $name($storage) @
-            <$alias as $crate::io::register::Register>::OFFSET
-        );
-        $crate::register!(@io_fixed $(#[$attr])* $vis $name);
-    };
-
-    // Creates a register at a relative offset from a base address provider.
-    (
-        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) @ $base:ident + $offset:literal
-            { $($fields:tt)* }
-    ) => {
-        $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
-        $crate::register!(@io_base $name($storage) @ $offset);
-        $crate::register!(@io_relative $name @ $base);
-    };
-
-    // Creates an alias register of relative offset register `alias` with its own fields.
-    (
-        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) => $base:ident + $alias:ident
-            { $($fields:tt)* }
-    ) => {
-        $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
-        $crate::register!(
-            @io_base $name($storage) @ <$alias as $crate::io::register::Register>::OFFSET
-        );
-        $crate::register!(@io_relative $name @ $base);
-    };
-
-    // Creates an array of registers at a fixed offset of the MMIO space.
-    (
-        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
-            [ $size:expr, stride = $stride:expr ] @ $offset:literal { $($fields:tt)* }
-    ) => {
-        $crate::build_assert::static_assert!(::core::mem::size_of::<$storage>() <= $stride);
-
-        $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
-        $crate::register!(@io_base $name($storage) @ $offset);
-        $crate::register!(@io_array $name [ $size, stride = $stride ]);
-    };
-
-    // Shortcut for contiguous array of registers (stride == size of element).
-    (
-        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) [ $size:expr ] @ $offset:literal
-            { $($fields:tt)* }
-    ) => {
-        $crate::register!(
-            @reg $(#[$attr])* $vis $name($storage)
-                [ $size, stride = ::core::mem::size_of::<$storage>() ]
-                @ $offset { $($fields)* }
-        );
-    };
-
-    // Creates an alias of register `idx` of array of registers `alias` with its own fields.
-    (
-        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) => $alias:path [ $idx:expr ]
-            { $($fields:tt)* }
-    ) => {
-        $crate::build_assert::static_assert!(
-            $idx < <$alias as $crate::io::register::RegisterArray>::SIZE
-        );
-
-        $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
-        $crate::register!(
-            @io_base $name($storage) @
-            <$alias as $crate::io::register::Register>::OFFSET
-                + $idx * <$alias as $crate::io::register::RegisterArray>::STRIDE
-        );
-        $crate::register!(@io_fixed $(#[$attr])* $vis $name);
-    };
-
-    // Creates an array of registers at a relative offset from a base address provider.
-    (
-        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
-            [ $size:expr, stride = $stride:expr ]
-            @ $base:ident + $offset:literal { $($fields:tt)* }
-    ) => {
-        $crate::build_assert::static_assert!(::core::mem::size_of::<$storage>() <= $stride);
-
-        $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
-        $crate::register!(@io_base $name($storage) @ $offset);
-        $crate::register!(@io_relative_array $name [ $size, stride = $stride ] @ $base);
-    };
-
-    // Shortcut for contiguous array of relative registers (stride == size of element).
-    (
-        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) [ $size:expr ]
-            @ $base:ident + $offset:literal { $($fields:tt)* }
-    ) => {
-        $crate::register!(
-            @reg $(#[$attr])* $vis $name($storage)
-                [ $size, stride = ::core::mem::size_of::<$storage>() ]
-                @ $base + $offset { $($fields)* }
-        );
-    };
-
-    // Creates an alias of register `idx` of relative array of registers `alias` with its own
-    // fields.
-    (
-        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
-            => $base:ident + $alias:ident [ $idx:expr ] { $($fields:tt)* }
-    ) => {
-        $crate::build_assert::static_assert!(
-            $idx < <$alias as $crate::io::register::RegisterArray>::SIZE
-        );
-
-        $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
-        $crate::register!(
-            @io_base $name($storage) @
-                <$alias as $crate::io::register::Register>::OFFSET +
-                $idx * <$alias as $crate::io::register::RegisterArray>::STRIDE
-        );
-        $crate::register!(@io_relative $name @ $base);
-    };
-
-    // Generates the bitfield for the register.
-    //
-    // `#[allow(non_camel_case_types)]` is added since register names typically use
-    // `SCREAMING_CASE`.
-    (
-        @bitfield $(#[$attr:meta])* $vis:vis struct $name:ident($storage:ty) { $($fields:tt)* }
-    ) => {
-        $crate::bitfield!(
-            #[allow(non_camel_case_types)]
-            $(#[$attr])* $vis struct $name($storage) { $($fields)* }
-        );
-    };
-
-    // Implementations shared by all registers types.
-    (@io_base $name:ident($storage:ty) @ $offset:expr) => {
-        impl $crate::io::register::Register for $name {
-            type Storage = $storage;
-
-            const OFFSET: usize = $offset;
-        }
-    };
-
-    // Implementations of fixed registers.
-    (@io_fixed $(#[$attr:meta])* $vis:vis $name:ident) => {
-        impl $crate::io::register::FixedRegister for $name {}
-
-        $(#[$attr])*
-        $vis const $name: $crate::io::register::FixedRegisterLoc<$name> =
-            $crate::io::register::FixedRegisterLoc::<$name>::new();
-    };
-
-    // Implementations of relative registers.
-    (@io_relative $name:ident @ $base:ident) => {
-        impl $crate::io::register::WithBase for $name {
-            type BaseFamily = $base;
-        }
-
-        impl $crate::io::register::RelativeRegister for $name {}
-    };
-
-    // Implementations of register arrays.
-    (@io_array $name:ident [ $size:expr, stride = $stride:expr ]) => {
-        impl $crate::io::register::Array for $name {}
-
-        impl $crate::io::register::RegisterArray for $name {
-            const SIZE: usize = $size;
-            const STRIDE: usize = $stride;
-        }
-    };
-
-    // Implementations of relative array registers.
-    (
-        @io_relative_array $name:ident [ $size:expr, stride = $stride:expr ] @ $base:ident
-    ) => {
-        impl $crate::io::register::WithBase for $name {
-            type BaseFamily = $base;
-        }
-
-        impl $crate::io::register::RegisterArray for $name {
-            const SIZE: usize = $size;
-            const STRIDE: usize = $stride;
-        }
-
-        impl $crate::io::register::RelativeRegisterArray for $name {}
+    ($($tt:tt)*) => {
+        $crate::macros::register!($($tt)*);
     };
 }
diff --git a/rust/macros/io/mod.rs b/rust/macros/io/mod.rs
new file mode 100644
index 000000000000..39fa5bc302ba
--- /dev/null
+++ b/rust/macros/io/mod.rs
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
+pub(crate) mod register;
diff --git a/rust/macros/io/register.rs b/rust/macros/io/register.rs
new file mode 100644
index 000000000000..61d076ab570a
--- /dev/null
+++ b/rust/macros/io/register.rs
@@ -0,0 +1,263 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use proc_macro2::{
+    Group,
+    Literal,
+    Span,
+    TokenStream, //
+};
+use quote::{
+    quote,
+    quote_spanned, //
+};
+use syn::{
+    bracketed,
+    parenthesized,
+    parse::Parse,
+    spanned::Spanned,
+    token,
+    Attribute,
+    Expr,
+    Ident,
+    Path,
+    Result,
+    Token,
+    Type,
+    Visibility, //
+};
+
+mod kw {
+    syn::custom_keyword!(stride);
+}
+
+struct RegArrayDef {
+    size: Expr,
+    stride: Option<Expr>,
+}
+
+enum RegOffset {
+    /// Register is located at fixed address.
+    Fixed { offset: Literal },
+    /// Register is an alias of a fixed register.
+    Alias { alias: Path },
+    /// Register is an alias of an element of a register array.
+    ElementAlias { alias: Path, idx: Expr },
+}
+
+struct Reg {
+    attrs: Vec<Attribute>,
+    vis: Visibility,
+    name: Ident,
+    storage: Type,
+    array: Option<RegArrayDef>,
+    relative_base: Option<Path>,
+    offset: RegOffset,
+    bitfield_args: Group,
+}
+
+impl Parse for Reg {
+    fn parse(input: syn::parse::ParseStream<'_>) -> Result<Self> {
+        let attrs = input.call(Attribute::parse_outer)?;
+        let vis = input.parse()?;
+        let name = input.parse()?;
+        let storage = {
+            let content;
+            parenthesized!(content in input);
+            content.parse()?
+        };
+        let array = if input.peek(token::Bracket) {
+            let content;
+            bracketed!(content in input);
+            let size = content.parse()?;
+            let stride = if content.peek(Token![,]) {
+                let _: Token![,] = content.parse()?;
+                let _: kw::stride = content.parse()?;
+                let _: Token![=] = content.parse()?;
+                Some(content.parse()?)
+            } else {
+                None
+            };
+            Some(RegArrayDef { size, stride })
+        } else {
+            None
+        };
+
+        let lh = input.lookahead1();
+        let mut relative_base = None;
+        let offset = if lh.peek(Token![@]) {
+            let _: Token![@] = input.parse()?;
+
+            if input.peek(Ident) {
+                relative_base = Some(input.parse()?);
+                let _: Token![+] = input.parse()?;
+            }
+
+            RegOffset::Fixed {
+                offset: input.parse()?,
+            }
+        } else if lh.peek(Token![=>]) {
+            let _: Token![=>] = input.parse()?;
+            let mut alias: Path = input.parse()?;
+            if input.peek(Token![+]) {
+                let _: Token![+] = input.parse()?;
+                relative_base = Some(alias);
+                alias = input.parse()?;
+            }
+
+            if input.peek(token::Bracket) {
+                let content;
+                bracketed!(content in input);
+                RegOffset::ElementAlias {
+                    alias,
+                    idx: content.parse()?,
+                }
+            } else {
+                RegOffset::Alias { alias }
+            }
+        } else {
+            Err(lh.error())?
+        };
+
+        let lh = input.lookahead1();
+        let bitfield_args = if lh.peek(token::Brace) {
+            input.parse()?
+        } else {
+            Err(lh.error())?
+        };
+
+        Ok(Self {
+            attrs,
+            vis,
+            name,
+            storage,
+            array,
+            relative_base,
+            offset,
+            bitfield_args,
+        })
+    }
+}
+
+pub(crate) struct RegDef {
+    regs: Vec<Reg>,
+}
+
+impl Parse for RegDef {
+    fn parse(input: syn::parse::ParseStream<'_>) -> Result<Self> {
+        let mut regs = Vec::new();
+        while !input.is_empty() {
+            regs.push(input.parse()?);
+        }
+        Ok(RegDef { regs })
+    }
+}
+
+pub(crate) fn register(def: RegDef) -> Result<TokenStream> {
+    let mut outputs = TokenStream::new();
+
+    for reg in def.regs {
+        let Reg {
+            attrs,
+            vis,
+            name,
+            storage,
+            array,
+            relative_base,
+            offset,
+            bitfield_args,
+        } = reg;
+
+        // Use register name's span for generated code, so error messages (if any) can point to it
+        // instead of the entire register allocation.
+        let span = name.span().resolved_at(Span::mixed_site());
+
+        let offset = match offset {
+            RegOffset::Fixed { offset } => quote!(#offset),
+            RegOffset::Alias { alias } => {
+                quote_spanned!(alias.span().resolved_at(span) =>
+                    <#alias as ::kernel::io::register::Register>::OFFSET
+                )
+            }
+            RegOffset::ElementAlias { alias, idx } => {
+                outputs.extend(quote_spanned!(idx.span().resolved_at(span) =>
+                    ::kernel::build_assert::static_assert!(
+                        #idx < <#alias as ::kernel::io::register::RegisterArray>::SIZE
+                    );
+                ));
+                quote_spanned!(alias.span().resolved_at(span) =>
+                    <#alias as ::kernel::io::register::Register>::OFFSET
+                        + #idx * <#alias as ::kernel::io::register::RegisterArray>::STRIDE
+                )
+            }
+        };
+
+        outputs.extend(quote_spanned!(span =>
+            ::kernel::bitfield!(
+                // `#[allow(non_camel_case_types)]` is added since register names typically use
+                // `SCREAMING_CASE`.
+                #[allow(non_camel_case_types)]
+                #(#attrs)* #vis struct #name(#storage) #bitfield_args
+            );
+
+            impl ::kernel::io::register::Register for #name {
+                type Storage = #storage;
+
+                const OFFSET: usize = #offset;
+            }
+        ));
+
+        match array {
+            None => match relative_base {
+                None => outputs.extend(quote_spanned!(span =>
+                    impl ::kernel::io::register::FixedRegister for #name {}
+
+                    #(#attrs)* #vis const #name: ::kernel::io::register::FixedRegisterLoc<#name> =
+                        ::kernel::io::register::FixedRegisterLoc::<#name>::new();
+                )),
+                Some(relative_base) => outputs.extend(quote_spanned!(span =>
+                    impl ::kernel::io::register::WithBase for #name {
+                        type BaseFamily = #relative_base;
+                    }
+
+                    impl ::kernel::io::register::RelativeRegister for #name {}
+                )),
+            },
+
+            Some(def) => {
+                let size = &def.size;
+                let stride = if let Some(stride) = &def.stride {
+                    outputs.extend(quote_spanned!(stride.span().resolved_at(span) =>
+                        ::kernel::build_assert::static_assert!(
+                            ::core::mem::size_of::<#storage>() <= #stride
+                        );
+                    ));
+                    quote!(#stride)
+                } else {
+                    quote_spanned!(span => ::core::mem::size_of::<#storage>())
+                };
+
+                outputs.extend(quote_spanned!(span =>
+                    impl ::kernel::io::register::RegisterArray for #name {
+                        const SIZE: usize = #size;
+                        const STRIDE: usize = #stride;
+                    }
+                ));
+
+                match relative_base {
+                    None => outputs.extend(quote_spanned!(span =>
+                        impl ::kernel::io::register::Array for #name {}
+                    )),
+                    Some(relative_base) => outputs.extend(quote_spanned!(span =>
+                        impl ::kernel::io::register::WithBase for #name {
+                            type BaseFamily = #relative_base;
+                        }
+
+                        impl ::kernel::io::register::RelativeRegisterArray for #name {}
+                    )),
+                }
+            }
+        };
+    }
+
+    Ok(outputs)
+}
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index 24f96feaeb34..5807dee84747 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -19,6 +19,7 @@
 mod fmt;
 mod for_lt;
 mod helpers;
+mod io;
 mod kunit;
 mod module;
 mod paste;
@@ -481,6 +482,15 @@ pub fn paste(input: TokenStream) -> TokenStream {
         .into()
 }
 
+#[doc(hidden)] // Documented in `kernel` crate.
+#[proc_macro]
+#[allow(non_snake_case)]
+pub fn register(input: TokenStream) -> TokenStream {
+    io::register::register(parse_macro_input!(input))
+        .unwrap_or_else(|e| e.into_compile_error())
+        .into()
+}
+
 /// Registers a KUnit test suite and its test cases using a user-space like syntax.
 ///
 /// This macro should be used on modules. If `CONFIG_KUNIT` (in `.config`) is `n`, the target module

-- 
2.54.0

