Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020089.outbound.protection.outlook.com [52.101.196.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C160B483825;
	Tue,  1 Sep 2026 16:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281442; cv=fail; b=K9kBDCjUTPMFQuqOa7lU0vw7FhXnzV1z2YvWZniCbvYBpuU5fsNDapF8sb8VFKZmCh/mHa+VuyoRrzpLuhRiBdBleaiQqq5p/qF6Rajqf886rFWg6tiUycaOoBGh8VygZjJ2KETkcPdBOz/AfXbuS29M8zUwQ14Xv+roDIQu/sQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281442; c=relaxed/simple;
	bh=Zx7heSsk8DCn4lZE4dws+jTnWJOl/ZnhN4v8+izAFmw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=cSuqsoWExgDw6PWFfAq9+/IMX2sTpZF/AZOp1RNWnqiQFH3tn06g1dOT//freAJb5fpTc+6CKOt6epOGOPEXFyHs6j0AP+6DXTr5Sej5LVXCgLrDgsJq0T4RtUXtWe4ZxXaMNZGWvFbEv8a3jD2ed0bgvmFal2hnP+t+6NMisLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=e5SnFC16; arc=fail smtp.client-ip=52.101.196.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="e5SnFC16"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQLedsB1gkJDYx7NZv+wXCAqCgaF0wPYiQostUud/6Yljgwc4QCnCuwN4e93/1MUX7N/2ANm8G+Aau6RZQrOA1XH8AbpUuygQb+iRwAe54pSrD4ZuvvSGXrnKZZx8hc2ZXvV9CxMJKfJWTXc47zOzmcJs4VGAheDhoeSdOSp7e87jNN1fXYiQa0ogcXBCF+m06A/vxxIsEKjZu4VFJr538pPcjCo3onKmoX5iytp1r9FlzMWUCArPUu86zsz322KM/i4VMWiPAc91iEsyULNGB5apBzJgkrLhIilYPEtFHHG7CzmWVhgIVzqD/QX5qXicTITp1a1Vji9Vs2XguxUCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l61BiUTycE5b/rJHGCJOA270/LuiPPdk9n7KTr72HlM=;
 b=aC0jTHLb5LIpbX2xb63Yr7c9wsXaJKPux2zjRUEU7ajx4QOCGjTmmebmjSH4qL2CaziwK/M16p+euwtsiLC6N0AKF/ERlND+PmVyZ+yZgK4wB7bE5pPNFYJQG9mwAY/v5c/2bztxY7z9ASNFD/c5XUE72YhBRwPrM6eEmqYpLulowGhGVNEYgu4Wm/4ZuSAH81UsMeti6U8eiabVk9vYMVhWXzyzl7xfWr/o0ebdlKWdrn1fQyFPMX41XCPsPnONmWrssEhNIFTFke1Qi7zTl6Eont3VgQawxJ1udir4kyNejvpbd9TVa0xEWKTYJyRnElnmN4XhIcqoMFew2O8Rnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l61BiUTycE5b/rJHGCJOA270/LuiPPdk9n7KTr72HlM=;
 b=e5SnFC169tqNYMYezOJ/eSihjA3p31BM5c/g1VKLgNwc/+0ytt7lfvVSAPhAB8hQ9xTopNIOfWIFqDgQ3Q3F9uFPwLRy+7bWo58HuwupyS4dnMuc2kYUD2vh+zUj2MlVdbp9/Qln1XRZOfkxG3YWtDm8ZuHPYNMvedlA+uXrUEs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO0P265MB7316.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ef::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 16:50:33 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 16:50:33 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 01 Sep 2026 17:50:25 +0100
Subject: [PATCH v4 01/16] rust: io: register: reimplement as proc macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-typed_register-v4-1-5552b1d59525@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788281431; l=21718;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=Zx7heSsk8DCn4lZE4dws+jTnWJOl/ZnhN4v8+izAFmw=;
 b=AJXGj8Aysc3ywlPvPtWMYTRL655UGTuKSuxb58gJg2uGREdKt+wlxII41ZD9YlMp7UovD6ojW
 Ct0a1v0IHbRDvsB4HHxW8FI86KFCaZBHq4O7Y6z+Cq4cvutms+RqMie
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
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO0P265MB7316:EE_
X-MS-Office365-Filtering-Correlation-Id: 9358661a-65f9-48db-debc-08df0849235c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|10070799003|376014|7416014|10067099003|3023799007|22082099003|56012099006|5023799004|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	czpw+6aGODEBR/yNlIEJLG7gXruWkrEJwOsjoUAM4W8pwveDEHiHAX8y2Qp0bkjq2yyvn/xY6yeEkAneJ8IVHuh6V14dqpgcbk/87wR9wuSRU9vj1RIAkl9Prh9TwLX6JcUJaH3sySCyrSTX/mbFdzLk+IP+krEUvzGTOzi9Y6O2HdBcznVy0KkSo/N7Mo+10a8TYK0ELvye294/qv0pqlxtHfjZ1m/6OEe7LkZKB11jH7u9ifTEOZUxyf8UhSWrYQ/Np4jEPXNEMfYgZzGZDU18F495wWVf5I5Ba+xhUt5XC2+Mq6FJr3PnyQzdfPVbO0RAcG2AhoDpw2vUSpoIPsul14tTDxti7ASZkzUdencbTdWbAEE0lvMU26xAKhT8q3ZkF9b0fcdorrCdaEiPioFn4F/wUeveO1JNHcQODWHD+CJ6SFFlBYLSgCtz7z49yA3hes3CPZt8jBEl1gfMOm4CVHbFX1GCURjSdCfUsZdBwUupoKw0N8rNr3nHx0nE58uhpYuovC5HC3mF8l8J8T3IMnK1pci4HkbILxYUFx6cXmMXA+vhf518gFD+1MQBW7MiWQlkqwGzglzohObDqyfINartBfJr3Uf+m+4ZVDOKUfc9LX1g1qoKyzoYMEwW2uIBp3NcMUtWu/37crB7xOg9JXNh/byPa/s0ZTOQ0oUnp10THftSfM+zFf1VURoAa8WzUAQK+5wOEdh6OwxJ8g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(10070799003)(376014)(7416014)(10067099003)(3023799007)(22082099003)(56012099006)(5023799004)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUVQN3dKVkRxRGJ1THlHVEVqNG1NZHNzYk10R010Ynd2VU5GdDExZ1J3dmZY?=
 =?utf-8?B?Z2lUTmh4dDdGVklzcHVIajdEWjlta0RRTjduQjYxNXdCTGkvZkw3SCtEOWdi?=
 =?utf-8?B?U1hZVU93MEoyS0VmbW94R1kzOEFwMHl1aW4zS21iSGc3NC9MNUVWWTA3NkFT?=
 =?utf-8?B?WW5JaTBGVW9NTVZzTm5pTEprL1FtRzFWS0pRUnUzUXlyZDlXVGNhazdkSnNy?=
 =?utf-8?B?N3hZOW9BNDVvK056SElHTEJMZUtlVm05cklMVWxOYXB1MjBZdTQ3SzJENFhM?=
 =?utf-8?B?STQzN0JCbzFvWmZOaWVsUGRvMnZaUW51YUxMSWllcWR6eG5uRWgyYjlBbXlM?=
 =?utf-8?B?a0tra2Ryd0x0N2poR1dOVU5LVUJ5Y254Smg5QlZQMUpPNVdTekhYUFc2SHZy?=
 =?utf-8?B?UkJjN3dGYXI2N1djTGoxYTRJQTAzZ3VncUU5a1l6bU9hTnpNWWNxTkJXZTly?=
 =?utf-8?B?SlF3L21UUURFblpGTkdlajBVRlBUVjhEUXo2SDJ0TEt1bXlHVXlDbWF5Nndz?=
 =?utf-8?B?UzdhcTB3b2w5SmxvbEdIRS8vb25aVUlNMlB3Sms1MGRtUFlTWVIxejd2aXVu?=
 =?utf-8?B?RW43UEtXQW9mUUV1VGFlMUk5Z0tOclpiZnRTZGhMSXA5aXljV0N4NVdBTnU2?=
 =?utf-8?B?Ynpza3EySUU0dENMazZJUHZJc3p4aU1SRUs1NnBjU2hsbGlJTUVxTkF2R0RI?=
 =?utf-8?B?Yjd5OTBYQnRQcE9XU2lSZUh3UDYvN1JQOGQ3QmxtR3JyUGFPMUsrMjE4WEZS?=
 =?utf-8?B?UzdlYmk4Qk1BbVp5eVREcDdmTlV4aSs2ZXJkTkxiOHJJREwzTDgyWElHQ3E1?=
 =?utf-8?B?R0M2SEdJZHA2NG0yRitWRFA4OHNWNHFhWHJTZHZoU3JiRU5LSkJzem1TSVZV?=
 =?utf-8?B?bnMvc2pBVjFEWGUzWDlidDRHWXFnamRUVXNGdUpMcko5QWlkM1hqcEZXZVJF?=
 =?utf-8?B?eC9aYU1jUFRwOGgwQUJhSTZ2TzRibjM5SGV2VGh5RkU1OEE3VmxQZ29makZB?=
 =?utf-8?B?T3p5YkViL04rQzFGc1crRzMyQ0gzOU9FRkFsWW11N0M0SkQ2WHNxd2RYZndX?=
 =?utf-8?B?YzRSQ25pVUlaQm9CbVRnemlPaE1aUjFHUStCTzBLbytqUkdrNEtFc2sybi93?=
 =?utf-8?B?Ukh5NDZnVituamRmZDhRQk8yVU1FbmkrYTRQR0dXVUJhYnJJT3lqRjdFWTZW?=
 =?utf-8?B?YXhTSWhtZWpGdml1aDFsaVEwOEdNZzZnY3VwN0JDNnJGZE9PY0dXVm5BU2lh?=
 =?utf-8?B?ZnY3K2crVXRHL3VNclBwNE5tTmYrUzA3ZUJRNmdWMHlSdk5ucUhBTWMrK1pL?=
 =?utf-8?B?TE5XUVNSdElxUVRzWDN2VFZZZFZxRkM5eFBZaEpXNWxoTFo4eVJZQkczZ0xO?=
 =?utf-8?B?blZJa1BYbXZCVVBWQ2Y2MHlGUkpiK3lLalNnSlV0VW0rcGJndXRRakFoUldM?=
 =?utf-8?B?bVJBVEh2a3V4Z28yOFRsc25uZjZTelA5ZTQzY1dJamJQM3VCZkpwbGF4YnFS?=
 =?utf-8?B?Wmd3dnlYVDgxWlZKV0ZqcXVob1BMTVRKRGYrcHJCWkhnU3RSL0xTSVkvb0tr?=
 =?utf-8?B?ampmeTNhYVQyZ2ZMVm11SlUxa1MzQklXdmFVSngxRGZ4SUhoQmEwSHQ0clBw?=
 =?utf-8?B?YkQvWlY4c1RWaUtwZytWQUNJNWFCR2tJNHhPZm5YcEhuZmJvd0x4cDRiVUhl?=
 =?utf-8?B?M2lQUTh3QVlIWDY0L1RlQU8wU3FjdUVRaXhUTlRXODFmb3k1cFpMMUtZekZr?=
 =?utf-8?B?Wk01cnVzOWIzOG1vRGhjbnZuWGtCbU1EOWFiRjRkdFN6MUFuZW9DWkVtVUdD?=
 =?utf-8?B?V2VuYUJFVkRZZVQ2T2hSbGVyVnR6d2xLNkh6RDhPWGkzTllzMDFxQWp1VzRx?=
 =?utf-8?B?NEF3ZHVBdVQ1UzQyYkpGTHUyam5VbDA0Wk5qM2NDS0p6TXBPZVFhMjZOeENK?=
 =?utf-8?B?bE1lSVZXV3hsd2h4U0E2YnpxY1JLRzlVWUk4enNlclNSVjR2SThVbEVFVTVl?=
 =?utf-8?B?VU5sRzFkR3RzODQ4R3VxMnRvUnZ1K3A4Y3kxckU4NGhOMHRNM0orcWlpZWVx?=
 =?utf-8?B?Qmx0ZTRTMklxdEdQL3Z0RExnYm9LaVJtMFhXZFNaaS8wZ25sdzhwR3dvR1Bz?=
 =?utf-8?B?emZuQXlNUi9MQm9NS0xGM0tmYWtMUGp2Q1ZSTXByN3cyVW9OSVV6ZUFFWmxp?=
 =?utf-8?B?Z1BtUGVpVXluVW9DLzRqVlZSTVgzWDBtbkZzQ04wT3hUNzVvQkdiR29zaDdE?=
 =?utf-8?B?ZEYrM0s0dDJnQ3BPdlo5UWE5WmxkcEhiT0JUSTdoTDdyck41QWtkRU80OUZM?=
 =?utf-8?B?RzhiekVYaDQ1Z3ZLUlNwNE4yWjlsU2FRbnA1YjlrQXFQdWRqMDJrdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9358661a-65f9-48db-debc-08df0849235c
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 16:50:32.9752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tnn9+mRSOkes6ewPJpb/z/5tmiyVv6KwnQoWyHPVAx+qOKVSVwLssq0sfrPdIbPbW+slEVJ8TjekwBjVSnlZOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB7316

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
 rust/kernel/io/register.rs | 224 +-----------------------------------
 rust/macros/io/mod.rs      |   3 +
 rust/macros/io/register.rs | 276 +++++++++++++++++++++++++++++++++++++++++++++
 rust/macros/lib.rs         |   9 ++
 5 files changed, 291 insertions(+), 222 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a19da74d00c..d92c7d834693 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7494,6 +7494,7 @@ F:	rust/kernel/io.rs
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
index 000000000000..87f7742f4619
--- /dev/null
+++ b/rust/macros/io/mod.rs
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0
+
+pub(crate) mod register;
diff --git a/rust/macros/io/register.rs b/rust/macros/io/register.rs
new file mode 100644
index 000000000000..83ba4dd75ab3
--- /dev/null
+++ b/rust/macros/io/register.rs
@@ -0,0 +1,276 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Documention and usage example of the macro can be found at `rust/kernel/io/register.rs`.
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
+/// Definition of a register array.
+///
+/// Specify a size, and optionally a stride. Syntax is of form `[size: EXPR, $(stride = EXPR)?]`.
+struct RegArrayDef {
+    size: Expr,
+    stride: Option<Expr>,
+}
+
+/// Offset of a register.
+///
+/// Can be either of form
+/// * `@ offset` for fixed offset
+/// * `=> alias` for alias of register `alias`.
+/// * `=> alias[idx]` for alias of register array `alias`'s `idx`-th element.
+enum RegOffset {
+    /// Register is located at fixed address.
+    Fixed { offset: Literal },
+    /// Register is an alias of a fixed register.
+    Alias { alias: Path },
+    /// Register is an alias of an element of a register array.
+    ElementAlias { alias: Path, idx: Expr },
+}
+
+/// Definition of a single register.
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
+        // Parse offset and the base it's relative to.
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
+                        (#idx) < <#alias as ::kernel::io::register::RegisterArray>::SIZE
+                    );
+                ));
+                quote_spanned!(alias.span().resolved_at(span) =>
+                    <#alias as ::kernel::io::register::Register>::OFFSET
+                        + (#idx) * <#alias as ::kernel::io::register::RegisterArray>::STRIDE
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
index 24f96feaeb34..9b76efe1476f 100644
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
@@ -481,6 +482,14 @@ pub fn paste(input: TokenStream) -> TokenStream {
         .into()
 }
 
+#[doc(hidden)] // Documented in `kernel` crate.
+#[proc_macro]
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

