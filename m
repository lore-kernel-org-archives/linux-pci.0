Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021101.outbound.protection.outlook.com [52.101.95.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A073F23A6;
	Wed,  5 Aug 2026 16:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785947842; cv=fail; b=ViCSOEkxFMFFMdTXmVKeJS20deMWI+vH/M4RkzikXKgl7udwuhllJiSCxL0FepVVimHFjOYxAIbTjM3m/dQBpPUnalomnWa9goZb9FSK6fwcB6zpWK131rnr/tvQ3EW/udp2MHoHSe1Jpa7CpbbENTxrw8ivBS7eLLXZKO72uTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785947842; c=relaxed/simple;
	bh=J7T0h1H5JiBlAO98luxgcDArI0ekO0PDo9MEHKowcpo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=m/RL+l3KN+CQOw4hku0UQBSFtASrc9vFOV8FoCuKPcQsZQAsNzywUWI9zWGzR34bGJ3sBrAdg+pRqZ47Kr0indDBFjBARf4c92fEAlYgzoOKVo5VWG8zoON4jc8xItM9GqJ94H4hZY7VJ2B0XeBq/vYTQ9vR1nQM2Fu6pNNgUc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=YwQAogS1; arc=fail smtp.client-ip=52.101.95.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="YwQAogS1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PwnAy1XQkO0nn+jBob6w+ua9d+Y7h6FXHBRMJhfRTu9JFW11MRFCg6nbsGBArkNnvzJAIm1+CWMax8mtuOnhz5L/HjLAtHfS+kDUyIjPByLR5uBngmxxgsJbLJ70f6IOMFlDhupsqyZvZ6A9I9FSSoZGvAlYdBRRlZBSbmWKVOfFr/vznyDxi2Tptq4a4W9CafB3M4AOdMza11OwaZ5+b/o5d2pMP7sMNvWIWN7ooKWIxK3KuCVx3yqaa26WHokZyNGW0KnN0D5162a90NxhQbTbL2pZmBn9WnkypjfMaFfRsp8DqdvODWfNaa8J0kNaMIFgV1YkcTBY90IOFFfaYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=siKhFg/e4GporWH1i2gXjVNpEbe2iSlWPEbJONPkryk=;
 b=hT6D8NogCBUlELjslwcbhH54S/s1f5Vmf7yE9kfK8yN8wNs5rUn9Fs9QuYTTadHzssVkVIDHG6Ey9Wv5mwgeCkj89kKGoKIMibVA2B2vuEUMkUXlHNNGHjjGTzr/7rmSRSFqBXMIcY/GYI7uOm5KPDjDq/kJfNsNEDHygjlyGjsDQsTUscnGPCHwlWhoPh05wJIN59OFZWsO44FhYjWfs39rfQN1JX2mqxPP8NA+6s4OKz6Q2ClCANSQhs6+deAAM0OtajW7fhvT2XT0kWSli79YSjhcej3AIL6e3q3EOsGvR0qBXSn9LbFgMTdIHT3VBKcWvqidJebC+GjY/yf9VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=siKhFg/e4GporWH1i2gXjVNpEbe2iSlWPEbJONPkryk=;
 b=YwQAogS12yFDa2syyuzrPBuWueMrDcgM8sHqBIkaOiBfFTzoJ1adnpSi2RLghpC8OFxMkkZd6qemgKhsLbfuSHH+axLlTmxzOyh7QQxyM+jgdGZUjUWkUgzDQ3hWAH01O1gWaqfGmLVQvG/3utGc7mv+o/NGNghKu+UilGKgabs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b4::24)
 by CWLP265MB3412.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:ea::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 16:37:07 +0000
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a]) by LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 16:37:07 +0000
From: Gary Guo <gary@garyguo.net>
Date: Wed, 05 Aug 2026 17:35:55 +0100
Subject: [PATCH v2 12/16] gpu: nova-core: use projection for PFALCON and
 PFALCON2 registers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-typed_register-v2-12-c3ca142220a0@garyguo.net>
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
In-Reply-To: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785947819; l=44542;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=J7T0h1H5JiBlAO98luxgcDArI0ekO0PDo9MEHKowcpo=;
 b=DrWNiRIuEPLxmpeGu0wvP9j4O6UVy2ejT/jZZ4s5icfxe37DJCZq/cCyhFaen7Z5NORpkEz5n
 9NyixVGiPHDD4YNe1mjWTzzo0Pz/fWwnYULlsb7D0D2AFjihE66xEn0
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0608.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::8) To LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4b4::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOZP265MB8551:EE_|CWLP265MB3412:EE_
X-MS-Office365-Filtering-Correlation-Id: 77681894-384d-455b-d5bc-08def30fca2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|7416014|23010399003|376014|22082099003|18002099003|56012099006|3023799007|6133799003|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	KFmRVV8WOR7S+IawVWm+z78Dd1cV0LzUmKZS3Ym+Lair2PYKc5vjfKSSXkcR7D3mGR5N6eTTWt9C+Mp2iijMYuTRK0hIDWq/bNrhs9XULT9Ci+TZkqazHz1lO7tiK/mv3OzWHwcJKWVmf2NtGu9M+pwDg+zR6EDof6pSRk9ZsBOVpvaP0HWpu+vlfoeCll/SYUMUsBsXl04KD/Ub0WxvItZbuyzBnA1B9km+9+Se2fm6+Dix8xElIOBYf4sRANa/EbirxFCYohIEhEyV5Q6I1/xXTckU2AgUJWXyfVg8IAPc4N3/PiqG8YwYaN6D0K7fkOz34l/DKv7IsloUhKZOXswXnoAeVrru7uZXVmzsSL6Er6IkIai2TmNB4QvwlWx+IPkXf1VJIwP/Juy5xbHNH6PEQ0K5aPNGAMSeOByrD1lHf+NWD2B9yq7JDPQdMIKy2qGtPqrP0XqCabGVldh5CwmSrwU1bZ4CfePkwuvc+tskS0axo40Q2dXnuUQPwFPZOB980TrclAX6wRyoTF997DmAKPmBCr4fG70CNXa9A6KoUZxe6kbZG0mBPQm9IedWzvd+GZ8WUgWa5xyWlIzb7hN9THPjRVBltqBDTmMNWvoXVmkcb1RbV0gvUSKIqnja+TaRCQAMryoG9djgbeOsmRx59WDb7k2wcL6lzGFyhrxe6jpyWT3UhgzyxfgwxT6pQfRmxfHZqNIforXreg5Q/g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(3023799007)(6133799003)(10067099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjFHSDA1alAzckp6VHdEckNHTnhFZlNDMGZzR3Y0SVQ2MXpYNVFzQzAxR25Q?=
 =?utf-8?B?UmdocFpPMlFlQ3dwakJ1Zlk3bHdZVFlBOTI4NU5zM1MzN21XcHMwTXlneXdR?=
 =?utf-8?B?WDQ3VkNPeC85VmVUZThPd3JwY3kzSTVXUWVEalc4SUFLa1preGJpeFlLSHVZ?=
 =?utf-8?B?U2UzRk5palpjZjVzbFA2R1hsSmFOQUZMS3ZCcEl6TnpFMHZtN2FBMS9UOXM0?=
 =?utf-8?B?S2JwR2FXeEwyMEJ2WHYraFBPTEJ4N2JveTR2VVNoZzA1U3hzTzByWXR5cWJj?=
 =?utf-8?B?QnNRZERYYk5YQzd5a0VyenZBOElGVEMxMllNbzZiRGlyNWdFRGQySVBZMTZP?=
 =?utf-8?B?dHJmN21OZzZGZUo1RHZHemVjeEpwQkhQcUVuUGF3V2d6dWw1ZDU0RERMOHNK?=
 =?utf-8?B?cGc5TW9SWnd6SlBHUnQ2SjRNQ2xvRGJWdVBkSlB4MGE2WTFmSUxZdE9UeUhN?=
 =?utf-8?B?K0g3bktyNkk2eXFFOGg2cnJkeHovUEcxWjZySXd0VVp5d2VUVmZIb2Qxd2NH?=
 =?utf-8?B?SWt1WjREQ0ZqcUtkTG9hNm51QXRLQktTREVYRlBScVc2QlgrRVVKSkpkYVlV?=
 =?utf-8?B?OThaaUhzbkxXUkFzdlNFeURtODk0elJqVzE0UVFuL3dwaUw0MktadW0yQjRs?=
 =?utf-8?B?VTIyN3VUZzdnSjlobGVEN0FCWGM4V0ZuQlo4ZE9jOEFLWGlOR0xEc1BGODNu?=
 =?utf-8?B?YVB2OHE4anZTYVdBZXhtamtnVmNvRmt1TGFzZStHTWhxS1E0Rzg0L1NMdS94?=
 =?utf-8?B?OXcxT3Fad1lNcFF5L3lxZGh4dVFWeDJWT1lGZmd1eGxQajR4Mks0ZEVyT3g5?=
 =?utf-8?B?WlE3ZGRWMXo3bzRicEdrQkNjQVZVZndHdERaRGEzWUVncFhXQks5NWZKdXdE?=
 =?utf-8?B?ZEIyaWVpcFZFaWl1NEk2Y043T05IbGNrVFFOSFozVUlMZ3VyWlhHYzRXRU9x?=
 =?utf-8?B?WG82ZE5icVd2VGdqaDlzakpFUHVOS3lBbzhtRWpHT29CZjZ6TFNTWmJtOGFr?=
 =?utf-8?B?MStubjRPRitUc05pNTVkY2tiNDU4RVZ5aWlYVjJXWmMwc1ZaR1pyYnN5VWIv?=
 =?utf-8?B?Z3YzS3NZazRuNlpGSVA2OWVzVmFQSEFDNHZYbTFRL1FhMDcxZlIzTktDRU5F?=
 =?utf-8?B?OWNVaVZST3lsUkp0MVQzN01yTXdKREt0L0hvbDB0NWR3WnhTL25RYWlNTnR4?=
 =?utf-8?B?aVF2TGg1RUU3Zk1oSVc4SHdiSjloYUJoMlpTdm01MWp1MzhIcE9QbnZJbU5q?=
 =?utf-8?B?bzJMbTB1LzNHRHNIQ2oxYVRhMW55d2JaQURIalFBeDhGcXgvSFlRbFNNQzQy?=
 =?utf-8?B?ejJxNWFFN3pVZGJWZ2xqWCt1WUx0YnZTb2lwNG8zbWdOZWFBZ3g5bVhvZ0JU?=
 =?utf-8?B?aW1rVUJENjRhaXVzV2MyVW1sbnJ1OEUxOG52L00rTEE0TE1vSnBwbjY3NGdN?=
 =?utf-8?B?VEZUczlrS085djhlcXBLQm1HYjh1QnNhcHovdmxvU3E1blN4aVJGa3JzZWIv?=
 =?utf-8?B?anZ5NmVsbXQ2VG1vSmV0UExDUjE1ODdMbExLaEtTZFRoMHE2UDU1Z1VvdkR0?=
 =?utf-8?B?VG9lMUVtUjBnZUZrNVNBb1BxZTNkRDlGN1hrTWNwN1dsQlRRY1p0bXY4K0ly?=
 =?utf-8?B?a1V2cjYreG1BRGZOZHg4V1hlRzZYdlN3cEhweUVDTnB2L0ZQSUI0R0hoeENF?=
 =?utf-8?B?Z0s4TlBWWWxlc2tLRTY2MXNHTkZIMFBMendoL3dkcnA2VmhjWFd1MDFVM2V1?=
 =?utf-8?B?b0xSeTNUNVNOb1M5VjJEOXNabXRUYm10U1FXbFlOZjZOZ0hjeWVaSEUrRHB1?=
 =?utf-8?B?bnBaMHExMWlFbmRIaEEvRFU1RXJkVStaSTB6NHg5MXl4aWNqem5rY3locU03?=
 =?utf-8?B?WExCaDdYc2l3Kzk2bk9tbGd5ekw4ZkhPcEpYSnYvRmJTc0JuZ1d3V3M4ODl1?=
 =?utf-8?B?MFR3amFiRDN4SzRsMGFkOGxxSTFodkFPbHZEU2V6Tm9zbVdDNDA4dDVBeVls?=
 =?utf-8?B?MDFNdzh6eE0rdTI4aG1ZUXFHcEFncUF2eGhvQzBRU2JTNTJaOC9UeE5jN3lj?=
 =?utf-8?B?K3NTSnVQZkYrQVpqbFZ6Z0pEYUNUTDNrWjdaT0lhbmp6MWNvK0g1UG9iU2ZK?=
 =?utf-8?B?WVlxV0FRTXk0RHFIYmprVmQxY1RxdTJaRGl4TU1MUlFHaFRMdWtmTmFPWG1F?=
 =?utf-8?B?bWNKa0dDc0JKN3U5Uytza3NuUlNhK0NpOHpqekdBUWU2Nzk1WUR3YmhpSy8r?=
 =?utf-8?B?c3BFU21zbjUxWFRQRk80MEc3YXliZjEybjV4a29qSFZ3ZmVKeURnanRpSkF3?=
 =?utf-8?B?QUtCcnJrNnB6Q3N0OVhXZUVjNzBhcHhjQ1RXMnhqQithSmJZVWkzQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 77681894-384d-455b-d5bc-08def30fca2b
X-MS-Exchange-CrossTenant-AuthSource: LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 16:37:07.6140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w9CnD43HIk66UGosigMIq8lOPp9uhgV7Ua//rpy1lAd+F5oWwTcNDgPj9T9IzJXtms8kp2o+oQehcztIk88F7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB3412

Add fixed size region types `PFalconRegisters` and `PFalcon2Registers` and
update PFALCON and PFALCON registers to be fixed register on them and not
relative registers on `NovaRegisters`.

Update `Falcon` struct to store projected views when constructing and
access with `self.pfalcon` and `self.pfalcon2`.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/gpu/nova-core/falcon.rs                    | 157 +++++++++------------
 drivers/gpu/nova-core/falcon/fsp.rs                |  63 +++++----
 drivers/gpu/nova-core/falcon/gsp.rs                |  51 ++++---
 drivers/gpu/nova-core/falcon/hal/ga102.rs          |  62 ++++----
 drivers/gpu/nova-core/falcon/hal/tu102.rs          |   9 +-
 drivers/gpu/nova-core/falcon/sec2.rs               |  37 +++--
 drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |  18 +--
 drivers/gpu/nova-core/gsp/hal/tu102.rs             |   7 +-
 drivers/gpu/nova-core/regs.rs                      |  91 ++++++------
 9 files changed, 238 insertions(+), 257 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index a91cbdd5d636..ed52572690ff 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -14,13 +14,12 @@
     },
     io::{
         poll::read_poll_timeout,
-        register::{
-            RegisterBase,
-            WithBase, //
-        },
+        register::Array,
         Io,
+        Mmio, //
     },
     prelude::*,
+    sizes::SZ_4K,
     time::Delta,
 };
 
@@ -165,18 +164,22 @@ pub(crate) enum FalconFbifMemType with From<Bounded<u32, 1>> {
     }
 }
 
-/// Type used to represent the `PFALCON` registers address base for a given falcon engine.
-pub(crate) struct PFalconBase(());
+/// Type used to represent the `PFALCON` registers.
+#[repr(align(4))]
+#[derive(FromBytes, IntoBytes)]
+pub(crate) struct PFalconRegisters([u8; SZ_4K]);
 
-/// Type used to represent the `PFALCON2` registers address base for a given falcon engine.
-pub(crate) struct PFalcon2Base(());
+/// Type used to represent the `PFALCON2` registers.
+#[repr(align(4))]
+#[derive(FromBytes, IntoBytes)]
+pub(crate) struct PFalcon2Registers([u8; SZ_4K]);
 
 /// Trait defining the parameters of a given Falcon engine.
 ///
 /// Each engine provides one base for `PFALCON` and `PFALCON2` registers.
-pub(crate) trait FalconEngine:
-    Send + Sync + RegisterBase<PFalconBase> + RegisterBase<PFalcon2Base> + Sized
-{
+pub(crate) trait FalconEngine: Send + Sync + Sized {
+    fn pfalcon(io: Bar0<'_>) -> Mmio<'_, PFalconRegisters>;
+    fn pfalcon2(io: Bar0<'_>) -> Mmio<'_, PFalcon2Registers>;
 }
 
 /// Represents a portion of the firmware to be loaded into a particular memory (e.g. IMEM or DMEM)
@@ -358,6 +361,8 @@ pub(crate) struct Falcon<'a, E: FalconEngine> {
     hal: KBox<dyn FalconHal<E>>,
     dev: &'a device::Device<device::Bound>,
     bar: Bar0<'a>,
+    pub(crate) pfalcon: Mmio<'a, PFalconRegisters>,
+    pfalcon2: Mmio<'a, PFalcon2Registers>,
 }
 
 impl<'a, E: FalconEngine + 'static> Falcon<'a, E> {
@@ -371,19 +376,19 @@ pub(crate) fn new(
             hal: hal::falcon_hal(chipset)?,
             dev,
             bar,
+            pfalcon: E::pfalcon(bar),
+            pfalcon2: E::pfalcon2(bar),
         })
     }
 
     /// Resets DMA-related registers.
     pub(crate) fn dma_reset(&self) {
-        self.bar.update(regs::NV_PFALCON_FBIF_CTL::of::<E>(), |v| {
+        self.pfalcon.update(regs::NV_PFALCON_FBIF_CTL, |v| {
             v.with_allow_phys_no_ctx(true)
         });
 
-        self.bar.write(
-            WithBase::of::<E>(),
-            regs::NV_PFALCON_FALCON_DMACTL::zeroed(),
-        );
+        self.pfalcon
+            .write_reg(regs::NV_PFALCON_FALCON_DMACTL::zeroed());
     }
 
     /// Reset the controller, select the falcon core, and wait for memory scrubbing to complete.
@@ -392,10 +397,9 @@ pub(crate) fn reset(&self) -> Result {
         self.hal.select_core(self)?;
         self.hal.reset_wait_mem_scrubbing(self)?;
 
-        self.bar.write(
-            WithBase::of::<E>(),
-            regs::NV_PFALCON_FALCON_RM::from(self.bar.read(regs::NV_PMC_BOOT_0).into_raw()),
-        );
+        self.pfalcon.write_reg(regs::NV_PFALCON_FALCON_RM::from(
+            self.bar.read(regs::NV_PMC_BOOT_0).into_raw(),
+        ));
 
         Ok(())
     }
@@ -413,8 +417,8 @@ fn pio_wr_imem_slice(&self, load_offsets: FalconPioImemLoadTarget<'_>) -> Result
             return Err(EINVAL);
         }
 
-        self.bar.write(
-            WithBase::of::<E>().at(Self::PIO_PORT),
+        self.pfalcon.write(
+            Array::at(Self::PIO_PORT),
             regs::NV_PFALCON_FALCON_IMEMC::zeroed()
                 .with_secure(load_offsets.secure)
                 .with_aincw(true)
@@ -424,14 +428,14 @@ fn pio_wr_imem_slice(&self, load_offsets: FalconPioImemLoadTarget<'_>) -> Result
         for (n, block) in load_offsets.data.chunks(MEM_BLOCK_ALIGNMENT).enumerate() {
             let n = u16::try_from(n)?;
             let tag: u16 = load_offsets.start_tag.checked_add(n).ok_or(ERANGE)?;
-            self.bar.write(
-                WithBase::of::<E>().at(Self::PIO_PORT),
+            self.pfalcon.write(
+                Array::at(Self::PIO_PORT),
                 regs::NV_PFALCON_FALCON_IMEMT::zeroed().with_tag(tag),
             );
             for word in block.chunks_exact(4) {
                 let w = [word[0], word[1], word[2], word[3]];
-                self.bar.write(
-                    WithBase::of::<E>().at(Self::PIO_PORT),
+                self.pfalcon.write(
+                    Array::at(Self::PIO_PORT),
                     regs::NV_PFALCON_FALCON_IMEMD::zeroed().with_data(u32::from_le_bytes(w)),
                 );
             }
@@ -450,8 +454,8 @@ fn pio_wr_dmem_slice(&self, load_offsets: FalconPioDmemLoadTarget<'_>) -> Result
             return Err(EINVAL);
         }
 
-        self.bar.write(
-            WithBase::of::<E>().at(Self::PIO_PORT),
+        self.pfalcon.write(
+            Array::at(Self::PIO_PORT),
             regs::NV_PFALCON_FALCON_DMEMC::zeroed()
                 .with_aincw(true)
                 .with_offs(load_offsets.dst_start),
@@ -459,8 +463,8 @@ fn pio_wr_dmem_slice(&self, load_offsets: FalconPioDmemLoadTarget<'_>) -> Result
 
         for word in load_offsets.data.chunks_exact(4) {
             let w = [word[0], word[1], word[2], word[3]];
-            self.bar.write(
-                WithBase::of::<E>().at(Self::PIO_PORT),
+            self.pfalcon.write(
+                Array::at(Self::PIO_PORT),
                 regs::NV_PFALCON_FALCON_DMEMD::zeroed().with_data(u32::from_le_bytes(w)),
             );
         }
@@ -473,14 +477,12 @@ pub(crate) fn pio_load<F: FalconFirmware<Target = E> + FalconPioLoadable>(
         &self,
         fw: &F,
     ) -> Result {
-        self.bar.update(regs::NV_PFALCON_FBIF_CTL::of::<E>(), |v| {
+        self.pfalcon.update(regs::NV_PFALCON_FBIF_CTL, |v| {
             v.with_allow_phys_no_ctx(true)
         });
 
-        self.bar.write(
-            WithBase::of::<E>(),
-            regs::NV_PFALCON_FALCON_DMACTL::zeroed(),
-        );
+        self.pfalcon
+            .write_reg(regs::NV_PFALCON_FALCON_DMACTL::zeroed());
 
         if let Some(imem_ns) = fw.imem_ns_load_params() {
             self.pio_wr_imem_slice(imem_ns)?;
@@ -492,10 +494,8 @@ pub(crate) fn pio_load<F: FalconFirmware<Target = E> + FalconPioLoadable>(
 
         self.hal.program_brom(self, &fw.brom_params());
 
-        self.bar.write(
-            WithBase::of::<E>(),
-            regs::NV_PFALCON_FALCON_BOOTVEC::zeroed().with_value(fw.boot_addr()),
-        );
+        self.pfalcon
+            .write_reg(regs::NV_PFALCON_FALCON_BOOTVEC::zeroed().with_value(fw.boot_addr()));
 
         Ok(())
     }
@@ -563,16 +563,13 @@ fn dma_wr(
 
         // Set up the base source DMA address.
 
-        self.bar.write(
-            WithBase::of::<E>(),
-            regs::NV_PFALCON_FALCON_DMATRFBASE::zeroed().with_base(
+        self.pfalcon
+            .write_reg(regs::NV_PFALCON_FALCON_DMATRFBASE::zeroed().with_base(
                 // CAST: `as u32` is used on purpose since we do want to strip the upper bits,
                 // which will be written to `NV_PFALCON_FALCON_DMATRFBASE1`.
                 (dma_start >> 8) as u32,
-            ),
-        );
-        self.bar.write(
-            WithBase::of::<E>(),
+            ));
+        self.pfalcon.write_reg(
             regs::NV_PFALCON_FALCON_DMATRFBASE1::zeroed().try_with_base(dma_start >> 40)?,
         );
 
@@ -582,23 +579,21 @@ fn dma_wr(
 
         for pos in (0..num_transfers).map(|i| i * DMA_LEN) {
             // Perform a transfer of size `DMA_LEN`.
-            self.bar.write(
-                WithBase::of::<E>(),
+            self.pfalcon.write_reg(
                 regs::NV_PFALCON_FALCON_DMATRFMOFFS::zeroed()
                     .try_with_offs(load_offsets.dst_start + pos)?,
             );
-            self.bar.write(
-                WithBase::of::<E>(),
+            self.pfalcon.write_reg(
                 regs::NV_PFALCON_FALCON_DMATRFFBOFFS::zeroed().with_offs(src_start + pos),
             );
 
-            self.bar.write(WithBase::of::<E>(), cmd);
+            self.pfalcon.write_reg(cmd);
 
             // Wait for the transfer to complete.
             // TIMEOUT: arbitrarily large value, no DMA transfer to the falcon's small memories
             // should ever take that long.
             read_poll_timeout(
-                || Ok(self.bar.read(regs::NV_PFALCON_FALCON_DMATRFCMD::of::<E>())),
+                || Ok(self.pfalcon.read(regs::NV_PFALCON_FALCON_DMATRFCMD)),
                 |r| r.idle(),
                 Delta::ZERO,
                 Delta::from_secs(2),
@@ -630,8 +625,8 @@ fn dma_load<F: FalconFirmware<Target = E> + FalconDmaLoadable>(&self, fw: &F) ->
         };
 
         self.dma_reset();
-        self.bar
-            .update(regs::NV_PFALCON_FBIF_TRANSCFG::of::<E>().at(0), |v| {
+        self.pfalcon
+            .update(regs::NV_PFALCON_FBIF_TRANSCFG::at(0), |v| {
                 v.with_target(FalconFbifTarget::CoherentSysmem)
                     .with_mem_type(FalconFbifMemType::Physical)
             });
@@ -642,10 +637,8 @@ fn dma_load<F: FalconFirmware<Target = E> + FalconDmaLoadable>(&self, fw: &F) ->
         self.hal.program_brom(self, &fw.brom_params());
 
         // Set `BootVec` to start of non-secure code.
-        self.bar.write(
-            WithBase::of::<E>(),
-            regs::NV_PFALCON_FALCON_BOOTVEC::zeroed().with_value(fw.boot_addr()),
-        );
+        self.pfalcon
+            .write_reg(regs::NV_PFALCON_FALCON_BOOTVEC::zeroed().with_value(fw.boot_addr()));
 
         Ok(())
     }
@@ -654,7 +647,7 @@ fn dma_load<F: FalconFirmware<Target = E> + FalconDmaLoadable>(&self, fw: &F) ->
     pub(crate) fn wait_till_halted(&self) -> Result<()> {
         // TIMEOUT: arbitrarily large value, firmwares should complete in less than 2 seconds.
         read_poll_timeout(
-            || Ok(self.bar.read(regs::NV_PFALCON_FALCON_CPUCTL::of::<E>())),
+            || Ok(self.pfalcon.read(regs::NV_PFALCON_FALCON_CPUCTL)),
             |r| r.halted(),
             Delta::ZERO,
             Delta::from_secs(2),
@@ -665,19 +658,13 @@ pub(crate) fn wait_till_halted(&self) -> Result<()> {
 
     /// Start the falcon CPU.
     pub(crate) fn start(&self) -> Result<()> {
-        match self
-            .bar
-            .read(regs::NV_PFALCON_FALCON_CPUCTL::of::<E>())
-            .alias_en()
-        {
-            true => self.bar.write(
-                WithBase::of::<E>(),
-                regs::NV_PFALCON_FALCON_CPUCTL_ALIAS::zeroed().with_startcpu(true),
-            ),
-            false => self.bar.write(
-                WithBase::of::<E>(),
-                regs::NV_PFALCON_FALCON_CPUCTL::zeroed().with_startcpu(true),
-            ),
+        match self.pfalcon.read(regs::NV_PFALCON_FALCON_CPUCTL).alias_en() {
+            true => self
+                .pfalcon
+                .write_reg(regs::NV_PFALCON_FALCON_CPUCTL_ALIAS::zeroed().with_startcpu(true)),
+            false => self
+                .pfalcon
+                .write_reg(regs::NV_PFALCON_FALCON_CPUCTL::zeroed().with_startcpu(true)),
         }
 
         Ok(())
@@ -686,32 +673,24 @@ pub(crate) fn start(&self) -> Result<()> {
     /// Writes values to the mailbox registers if provided.
     pub(crate) fn write_mailboxes(&self, mbox0: Option<u32>, mbox1: Option<u32>) {
         if let Some(mbox0) = mbox0 {
-            self.bar.write(
-                WithBase::of::<E>(),
-                regs::NV_PFALCON_FALCON_MAILBOX0::zeroed().with_value(mbox0),
-            );
+            self.pfalcon
+                .write_reg(regs::NV_PFALCON_FALCON_MAILBOX0::zeroed().with_value(mbox0));
         }
 
         if let Some(mbox1) = mbox1 {
-            self.bar.write(
-                WithBase::of::<E>(),
-                regs::NV_PFALCON_FALCON_MAILBOX1::zeroed().with_value(mbox1),
-            );
+            self.pfalcon
+                .write_reg(regs::NV_PFALCON_FALCON_MAILBOX1::zeroed().with_value(mbox1));
         }
     }
 
     /// Reads the value from `mbox0` register.
     pub(crate) fn read_mailbox0(&self) -> u32 {
-        self.bar
-            .read(regs::NV_PFALCON_FALCON_MAILBOX0::of::<E>())
-            .value()
+        self.pfalcon.read(regs::NV_PFALCON_FALCON_MAILBOX0).value()
     }
 
     /// Reads the value from `mbox1` register.
     pub(crate) fn read_mailbox1(&self) -> u32 {
-        self.bar
-            .read(regs::NV_PFALCON_FALCON_MAILBOX1::of::<E>())
-            .value()
+        self.pfalcon.read(regs::NV_PFALCON_FALCON_MAILBOX1).value()
     }
 
     /// Reads values from both mailbox registers.
@@ -776,9 +755,7 @@ pub(crate) fn load<F: FalconFirmware<Target = E> + FalconDmaLoadable>(&self, fw:
 
     /// Write the application version to the OS register.
     pub(crate) fn write_os_version(&self, app_version: u32) {
-        self.bar.write(
-            WithBase::of::<E>(),
-            regs::NV_PFALCON_FALCON_OS::zeroed().with_value(app_version),
-        );
+        self.pfalcon
+            .write_reg(regs::NV_PFALCON_FALCON_OS::zeroed().with_value(app_version));
     }
 }
diff --git a/drivers/gpu/nova-core/falcon/fsp.rs b/drivers/gpu/nova-core/falcon/fsp.rs
index 0437180b8829..85f9c8c5d60e 100644
--- a/drivers/gpu/nova-core/falcon/fsp.rs
+++ b/drivers/gpu/nova-core/falcon/fsp.rs
@@ -8,13 +8,12 @@
 
 use kernel::{
     io::{
+        io_project,
         poll::read_poll_timeout,
-        register::{
-            Array,
-            RegisterBase,
-            WithBase, //
-        },
-        Io, //
+        register,
+        register::Array,
+        Io,
+        Mmio, //
     },
     prelude::*,
     sizes::SZ_1K,
@@ -22,11 +21,13 @@
 };
 
 use crate::{
+    driver::{
+        Bar0,
+        NovaRegisters, //
+    },
     falcon::{
         Falcon,
-        FalconEngine,
-        PFalcon2Base,
-        PFalconBase, //
+        FalconEngine, //
     },
     num,
     regs, //
@@ -41,15 +42,24 @@
 /// Type specifying the `Fsp` falcon engine. Cannot be instantiated.
 pub(crate) struct Fsp(());
 
-impl RegisterBase<PFalconBase> for Fsp {
-    const BASE: usize = 0x8f2000;
-}
+register! {
+    base: NovaRegisters;
 
-impl RegisterBase<PFalcon2Base> for Fsp {
-    const BASE: usize = 0x8f3000;
+    PFALCON: super::PFalconRegisters @ 0x8f2000;
+    PFALCON2: super::PFalcon2Registers @ 0x8f3000;
 }
 
-impl FalconEngine for Fsp {}
+impl FalconEngine for Fsp {
+    #[inline]
+    fn pfalcon(io: Bar0<'_>) -> Mmio<'_, super::PFalconRegisters> {
+        io_project!(io, build: PFALCON)
+    }
+
+    #[inline]
+    fn pfalcon2(io: Bar0<'_>) -> Mmio<'_, super::PFalcon2Registers> {
+        io_project!(io, build: PFALCON2)
+    }
+}
 
 impl<'a> Falcon<'a, Fsp> {
     /// Writes `data` to FSP external memory at offset `0`.
@@ -62,19 +72,15 @@ fn write_emem(&mut self, data: &[u8]) -> Result {
         }
 
         // Begin a write burst at offset `0`, auto-incrementing on each write.
-        self.bar.write(
-            WithBase::of::<Fsp>(),
-            regs::NV_PFALCON_FALCON_EMEMC::zeroed().with_aincw(true),
-        );
+        self.pfalcon
+            .write_reg(regs::NV_PFALCON_FALCON_EMEMC::zeroed().with_aincw(true));
 
         for chunk in data.chunks_exact(4) {
             let value = u32::from_le_bytes([chunk[0], chunk[1], chunk[2], chunk[3]]);
 
             // Write the next 32-bit `value`; hardware advances the offset.
-            self.bar.write(
-                WithBase::of::<Fsp>(),
-                regs::NV_PFALCON_FALCON_EMEMD::zeroed().with_data(value),
-            );
+            self.pfalcon
+                .write_reg(regs::NV_PFALCON_FALCON_EMEMD::zeroed().with_data(value));
         }
 
         Ok(())
@@ -90,17 +96,12 @@ fn read_emem(&mut self, data: &mut [u8]) -> Result {
         }
 
         // Begin a read burst at offset `0`, auto-incrementing on each read.
-        self.bar.write(
-            WithBase::of::<Fsp>(),
-            regs::NV_PFALCON_FALCON_EMEMC::zeroed().with_aincr(true),
-        );
+        self.pfalcon
+            .write_reg(regs::NV_PFALCON_FALCON_EMEMC::zeroed().with_aincr(true));
 
         for chunk in data.chunks_exact_mut(4) {
             // Read the next 32-bit word; hardware advances the offset.
-            let value = self
-                .bar
-                .read(regs::NV_PFALCON_FALCON_EMEMD::of::<Fsp>())
-                .data();
+            let value = self.pfalcon.read(regs::NV_PFALCON_FALCON_EMEMD).data();
             chunk.copy_from_slice(&value.to_le_bytes());
         }
 
diff --git a/drivers/gpu/nova-core/falcon/gsp.rs b/drivers/gpu/nova-core/falcon/gsp.rs
index ae32f401aeb0..cbea6d7b49d3 100644
--- a/drivers/gpu/nova-core/falcon/gsp.rs
+++ b/drivers/gpu/nova-core/falcon/gsp.rs
@@ -2,23 +2,24 @@
 
 use kernel::{
     io::{
+        io_project,
         poll::read_poll_timeout,
-        register::{
-            RegisterBase,
-            WithBase, //
-        },
+        register,
         Io,
+        Mmio, //
     },
     prelude::*,
     time::Delta, //
 };
 
 use crate::{
+    driver::{
+        Bar0,
+        NovaRegisters, //
+    },
     falcon::{
         Falcon,
-        FalconEngine,
-        PFalcon2Base,
-        PFalconBase, //
+        FalconEngine, //
     },
     regs,
 };
@@ -26,24 +27,31 @@
 /// Type specifying the `Gsp` falcon engine. Cannot be instantiated.
 pub(crate) struct Gsp(());
 
-impl RegisterBase<PFalconBase> for Gsp {
-    const BASE: usize = 0x00110000;
-}
+register! {
+    base: NovaRegisters;
 
-impl RegisterBase<PFalcon2Base> for Gsp {
-    const BASE: usize = 0x00111000;
+    PFALCON: super::PFalconRegisters @ 0x00110000;
+    PFALCON2: super::PFalcon2Registers @ 0x00111000;
 }
 
-impl FalconEngine for Gsp {}
+impl FalconEngine for Gsp {
+    #[inline]
+    fn pfalcon<'a>(io: Bar0<'a>) -> Mmio<'a, super::PFalconRegisters> {
+        io_project!(io, build: PFALCON)
+    }
+
+    #[inline]
+    fn pfalcon2<'a>(io: Bar0<'a>) -> Mmio<'a, super::PFalcon2Registers> {
+        io_project!(io, build: PFALCON2)
+    }
+}
 
 impl<'a> Falcon<'a, Gsp> {
     /// Clears the SWGEN0 bit in the Falcon's IRQ status clear register to
     /// allow GSP to signal CPU for processing new messages in message queue.
     pub(crate) fn clear_swgen0_intr(&self) {
-        self.bar.write(
-            WithBase::of::<Gsp>(),
-            regs::NV_PFALCON_FALCON_IRQSCLR::zeroed().with_swgen0(true),
-        );
+        self.pfalcon
+            .write_reg(regs::NV_PFALCON_FALCON_IRQSCLR::zeroed().with_swgen0(true));
     }
 
     /// Checks if GSP reload/resume has completed during the boot process.
@@ -59,8 +67,8 @@ pub(crate) fn check_reload_completed(&self, timeout: Delta) -> Result<bool> {
 
     /// Returns whether the RISC-V branch privilege lockdown bit is set.
     pub(crate) fn riscv_branch_privilege_lockdown(&self) -> bool {
-        self.bar
-            .read(regs::NV_PFALCON_FALCON_HWCFG2::of::<Gsp>())
+        self.pfalcon
+            .read(regs::NV_PFALCON_FALCON_HWCFG2)
             .riscv_br_priv_lockdown()
     }
 
@@ -71,10 +79,7 @@ pub(crate) fn priv_target_mask_released(&self) -> bool {
         const LOCKED_PATTERN: u32 = 0xbadf_4100;
         const LOCKED_MASK: u32 = 0xffff_ff00;
 
-        let hwcfg2 = self
-            .bar
-            .read(regs::NV_PFALCON_FALCON_HWCFG2::of::<Gsp>())
-            .into_raw();
+        let hwcfg2 = self.pfalcon.read(regs::NV_PFALCON_FALCON_HWCFG2).into_raw();
 
         hwcfg2 != 0 && (hwcfg2 & LOCKED_MASK) != LOCKED_PATTERN
     }
diff --git a/drivers/gpu/nova-core/falcon/hal/ga102.rs b/drivers/gpu/nova-core/falcon/hal/ga102.rs
index 7600ee07ca2e..ebfaff3d960f 100644
--- a/drivers/gpu/nova-core/falcon/hal/ga102.rs
+++ b/drivers/gpu/nova-core/falcon/hal/ga102.rs
@@ -6,11 +6,9 @@
     device,
     io::{
         poll::read_poll_timeout,
-        register::{
-            Array,
-            WithBase, //
-        },
-        Io, //
+        register::Array,
+        Io,
+        Mmio, //
     },
     prelude::*,
     time::Delta, //
@@ -24,6 +22,7 @@
         FalconBromParams,
         FalconEngine,
         FalconModSelAlgo,
+        PFalcon2Registers,
         PeregrineCoreSelect, //
     },
     regs,
@@ -31,17 +30,16 @@
 
 use super::FalconHal;
 
-fn select_core_ga102<E: FalconEngine>(bar: Bar0<'_>) -> Result {
-    let bcr_ctrl = bar.read(regs::NV_PRISCV_RISCV_BCR_CTRL::of::<E>());
+fn select_core_ga102<E: FalconEngine>(pfalcon2: Mmio<'_, PFalcon2Registers>) -> Result {
+    let bcr_ctrl = pfalcon2.read(regs::NV_PRISCV_RISCV_BCR_CTRL);
     if bcr_ctrl.core_select() != PeregrineCoreSelect::Falcon {
-        bar.write(
-            WithBase::of::<E>(),
+        pfalcon2.write_reg(
             regs::NV_PRISCV_RISCV_BCR_CTRL::zeroed().with_core_select(PeregrineCoreSelect::Falcon),
         );
 
         // TIMEOUT: falcon core should take less than 10ms to report being enabled.
         read_poll_timeout(
-            || Ok(bar.read(regs::NV_PRISCV_RISCV_BCR_CTRL::of::<E>())),
+            || Ok(pfalcon2.read(regs::NV_PRISCV_RISCV_BCR_CTRL)),
             |r| r.valid(),
             Delta::ZERO,
             Delta::from_millis(10),
@@ -86,24 +84,23 @@ fn signature_reg_fuse_version_ga102(
     Ok(u16::BITS - reg_fuse_version.leading_zeros())
 }
 
-fn program_brom_ga102<E: FalconEngine>(bar: Bar0<'_>, params: &FalconBromParams) {
-    bar.write(
-        WithBase::of::<E>().at(0),
+fn program_brom_ga102<E: FalconEngine>(
+    pfalcon2: Mmio<'_, PFalcon2Registers>,
+    params: &FalconBromParams,
+) {
+    pfalcon2.write(
+        Array::at(0),
         regs::NV_PFALCON2_FALCON_BROM_PARAADDR::zeroed().with_value(params.pkc_data_offset),
     );
-    bar.write(
-        WithBase::of::<E>(),
+    pfalcon2.write_reg(
         regs::NV_PFALCON2_FALCON_BROM_ENGIDMASK::zeroed()
             .with_value(u32::from(params.engine_id_mask)),
     );
-    bar.write(
-        WithBase::of::<E>(),
+    pfalcon2.write_reg(
         regs::NV_PFALCON2_FALCON_BROM_CURR_UCODE_ID::zeroed().with_ucode_id(params.ucode_id),
     );
-    bar.write(
-        WithBase::of::<E>(),
-        regs::NV_PFALCON2_FALCON_MOD_SEL::zeroed().with_algo(FalconModSelAlgo::Rsa3k),
-    );
+    pfalcon2
+        .write_reg(regs::NV_PFALCON2_FALCON_MOD_SEL::zeroed().with_algo(FalconModSelAlgo::Rsa3k));
 }
 
 pub(super) struct Ga102<E: FalconEngine>(PhantomData<E>);
@@ -116,7 +113,7 @@ pub(super) fn new() -> Self {
 
 impl<E: FalconEngine> FalconHal<E> for Ga102<E> {
     fn select_core(&self, falcon: &Falcon<'_, E>) -> Result {
-        select_core_ga102::<E>(falcon.bar)
+        select_core_ga102::<E>(falcon.pfalcon2)
     }
 
     fn signature_reg_fuse_version(
@@ -129,27 +126,24 @@ fn signature_reg_fuse_version(
     }
 
     fn program_brom(&self, falcon: &Falcon<'_, E>, params: &FalconBromParams) {
-        program_brom_ga102::<E>(falcon.bar, params);
+        program_brom_ga102::<E>(falcon.pfalcon2, params);
     }
 
     fn is_riscv_active(&self, falcon: &Falcon<'_, E>) -> bool {
         falcon
-            .bar
-            .read(regs::NV_PRISCV_RISCV_CPUCTL::of::<E>())
+            .pfalcon2
+            .read(regs::NV_PRISCV_RISCV_CPUCTL)
             .active_stat()
     }
 
     fn is_riscv_halted(&self, falcon: &Falcon<'_, E>) -> Result<bool> {
-        Ok(falcon
-            .bar
-            .read(regs::NV_PRISCV_RISCV_CPUCTL::of::<E>())
-            .halted())
+        Ok(falcon.pfalcon2.read(regs::NV_PRISCV_RISCV_CPUCTL).halted())
     }
 
     fn reset_wait_mem_scrubbing(&self, falcon: &Falcon<'_, E>) -> Result {
         // TIMEOUT: memory scrubbing should complete in less than 20ms.
         read_poll_timeout(
-            || Ok(falcon.bar.read(regs::NV_PFALCON_FALCON_HWCFG2::of::<E>())),
+            || Ok(falcon.pfalcon.read(regs::NV_PFALCON_FALCON_HWCFG2)),
             |r| r.mem_scrubbing_done(),
             Delta::ZERO,
             Delta::from_millis(20),
@@ -158,20 +152,18 @@ fn reset_wait_mem_scrubbing(&self, falcon: &Falcon<'_, E>) -> Result {
     }
 
     fn reset_eng(&self, falcon: &Falcon<'_, E>) -> Result {
-        let bar = falcon.bar;
-
-        let _ = bar.read(regs::NV_PFALCON_FALCON_HWCFG2::of::<E>());
+        let _ = falcon.pfalcon.read(regs::NV_PFALCON_FALCON_HWCFG2);
 
         // According to OpenRM's `kflcnPreResetWait_GA102` documentation, HW sometimes does not set
         // RESET_READY so a non-failing timeout is used.
         let _ = read_poll_timeout(
-            || Ok(bar.read(regs::NV_PFALCON_FALCON_HWCFG2::of::<E>())),
+            || Ok(falcon.pfalcon.read(regs::NV_PFALCON_FALCON_HWCFG2)),
             |r| r.reset_ready(),
             Delta::ZERO,
             Delta::from_micros(150),
         );
 
-        regs::NV_PFALCON_FALCON_ENGINE::reset_engine::<E>(bar);
+        regs::NV_PFALCON_FALCON_ENGINE::reset_engine::<E>(falcon.pfalcon);
         self.reset_wait_mem_scrubbing(falcon)?;
 
         Ok(())
diff --git a/drivers/gpu/nova-core/falcon/hal/tu102.rs b/drivers/gpu/nova-core/falcon/hal/tu102.rs
index 5291598fedf7..cfb0a435698d 100644
--- a/drivers/gpu/nova-core/falcon/hal/tu102.rs
+++ b/drivers/gpu/nova-core/falcon/hal/tu102.rs
@@ -5,7 +5,6 @@
 use kernel::{
     io::{
         poll::read_poll_timeout,
-        register::WithBase,
         Io, //
     },
     prelude::*,
@@ -50,8 +49,8 @@ fn program_brom(&self, _falcon: &Falcon<'_, E>, _params: &FalconBromParams) {}
 
     fn is_riscv_active(&self, falcon: &Falcon<'_, E>) -> bool {
         falcon
-            .bar
-            .read(regs::NV_PRISCV_RISCV_CORE_SWITCH_RISCV_STATUS::of::<E>())
+            .pfalcon2
+            .read(regs::NV_PRISCV_RISCV_CORE_SWITCH_RISCV_STATUS)
             .active_stat()
     }
 
@@ -62,7 +61,7 @@ fn is_riscv_halted(&self, _falcon: &Falcon<'_, E>) -> Result<bool> {
     fn reset_wait_mem_scrubbing(&self, falcon: &Falcon<'_, E>) -> Result {
         // TIMEOUT: memory scrubbing should complete in less than 10ms.
         read_poll_timeout(
-            || Ok(falcon.bar.read(regs::NV_PFALCON_FALCON_DMACTL::of::<E>())),
+            || Ok(falcon.pfalcon.read(regs::NV_PFALCON_FALCON_DMACTL)),
             |r| r.mem_scrubbing_done(),
             Delta::ZERO,
             Delta::from_millis(10),
@@ -71,7 +70,7 @@ fn reset_wait_mem_scrubbing(&self, falcon: &Falcon<'_, E>) -> Result {
     }
 
     fn reset_eng(&self, falcon: &Falcon<'_, E>) -> Result {
-        regs::NV_PFALCON_FALCON_ENGINE::reset_engine::<E>(falcon.bar);
+        regs::NV_PFALCON_FALCON_ENGINE::reset_engine::<E>(falcon.pfalcon);
         self.reset_wait_mem_scrubbing(falcon)?;
 
         Ok(())
diff --git a/drivers/gpu/nova-core/falcon/sec2.rs b/drivers/gpu/nova-core/falcon/sec2.rs
index 91ec7d49c1f5..6648a397d38a 100644
--- a/drivers/gpu/nova-core/falcon/sec2.rs
+++ b/drivers/gpu/nova-core/falcon/sec2.rs
@@ -1,22 +1,37 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use kernel::io::register::RegisterBase;
+use kernel::io::{
+    io_project,
+    register,
+    Mmio, //
+};
 
-use crate::falcon::{
-    FalconEngine,
-    PFalcon2Base,
-    PFalconBase, //
+use crate::{
+    driver::{
+        Bar0,
+        NovaRegisters, //
+    },
+    falcon::FalconEngine, //
 };
 
 /// Type specifying the `Sec2` falcon engine. Cannot be instantiated.
 pub(crate) struct Sec2(());
 
-impl RegisterBase<PFalconBase> for Sec2 {
-    const BASE: usize = 0x00840000;
-}
+register! {
+    base: NovaRegisters;
 
-impl RegisterBase<PFalcon2Base> for Sec2 {
-    const BASE: usize = 0x00841000;
+    PFALCON: super::PFalconRegisters @ 0x00840000;
+    PFALCON2: super::PFalcon2Registers @ 0x00841000;
 }
 
-impl FalconEngine for Sec2 {}
+impl FalconEngine for Sec2 {
+    #[inline]
+    fn pfalcon(io: Bar0<'_>) -> Mmio<'_, super::PFalconRegisters> {
+        io_project!(io, build: PFALCON)
+    }
+
+    #[inline]
+    fn pfalcon2(io: Bar0<'_>) -> Mmio<'_, super::PFalcon2Registers> {
+        io_project!(io, build: PFALCON2)
+    }
+}
diff --git a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
index d9fafd2eea5b..f139aeb73f14 100644
--- a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
+++ b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
@@ -12,7 +12,10 @@
         Device, //
     },
     dma::Coherent,
-    io::{register::WithBase, Io},
+    io::{
+        register::Array,
+        Io, //
+    },
     prelude::*,
     ptr::{
         Alignable,
@@ -26,7 +29,6 @@
 };
 
 use crate::{
-    driver::Bar0,
     falcon::{
         self,
         gsp::Gsp,
@@ -272,12 +274,7 @@ pub(crate) fn new(
     ///
     /// The bootloader will load the FWSEC firmware and then execute it. This function returns
     /// after FWSEC has reached completion.
-    pub(crate) fn run(
-        &self,
-        dev: &Device<device::Bound>,
-        falcon: &Falcon<'_, Gsp>,
-        bar: Bar0<'_>,
-    ) -> Result<()> {
+    pub(crate) fn run(&self, dev: &Device<device::Bound>, falcon: &Falcon<'_, Gsp>) -> Result<()> {
         // Reset falcon, load the firmware, and run it.
         falcon
             .reset()
@@ -287,9 +284,8 @@ pub(crate) fn run(
             .inspect_err(|e| dev_err!(dev, "Failed to load FWSEC firmware: {:?}\n", e))?;
 
         // Configure DMA index for the bootloader to fetch the FWSEC firmware from system memory.
-        bar.update(
-            regs::NV_PFALCON_FBIF_TRANSCFG::of::<Gsp>()
-                .try_at(usize::from_safe_cast(self.dmem_desc.ctx_dma))
+        falcon.pfalcon.update(
+            regs::NV_PFALCON_FBIF_TRANSCFG::try_at(usize::from_safe_cast(self.dmem_desc.ctx_dma))
                 .ok_or(EINVAL)?,
             |v| {
                 v.with_target(FalconFbifTarget::CoherentSysmem)
diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index e3c365cf4a68..45fc9a213275 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -63,12 +63,11 @@ impl FwsecUnloadFirmware {
     fn run(
         &self,
         dev: &device::Device<device::Bound>,
-        bar: Bar0<'_>,
         gsp_falcon: &Falcon<'_, GspEngine>,
     ) -> Result {
         match self {
             Self::WithoutBl(fw) => fw.run(dev, gsp_falcon),
-            Self::WithBl(fw) => fw.run(dev, gsp_falcon, bar),
+            Self::WithBl(fw) => fw.run(dev, gsp_falcon),
         }
     }
 }
@@ -89,7 +88,7 @@ fn run(&self, ctx: &mut GspBootContext<'_, '_>) -> Result {
         // Log errors but keep going if it fails.
         let fwsec_sb_res = self
             .fwsec_sb
-            .run(dev, bar, ctx.gsp_falcon)
+            .run(dev, ctx.gsp_falcon)
             .inspect_err(|e| dev_err!(dev, "FWSEC-SB failed to run: {:?}\n", e));
 
         // Remove WPR2 region if set.
@@ -169,7 +168,7 @@ fn run_fwsec_frts(
         if self.needs_fwsec_bootloader {
             let fwsec_frts_bl = FwsecFirmwareWithBl::new(fwsec_frts, dev, chipset)?;
             // Load and run the bootloader, which will load FWSEC-FRTS and run it.
-            fwsec_frts_bl.run(dev, falcon, bar)?;
+            fwsec_frts_bl.run(dev, falcon)?;
         } else {
             // Load and run FWSEC-FRTS directly.
             fwsec_frts.run(dev, falcon)?;
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 1af073f3861f..6fdfdb0b3c60 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -4,8 +4,8 @@
 use kernel::{
     io::{
         register,
-        register::WithBase,
-        Io, //
+        Io,
+        Mmio, //
     },
     prelude::*,
     sizes::SizeConstants,
@@ -13,10 +13,7 @@
 };
 
 use crate::{
-    driver::{
-        Bar0,
-        NovaRegisters, //
-    },
+    driver::NovaRegisters,
     falcon::{
         DmaTrfCmdSize,
         FalconCoreRev,
@@ -27,8 +24,8 @@
         FalconMem,
         FalconModSelAlgo,
         FalconSecurityModel,
-        PFalcon2Base,
-        PFalconBase,
+        PFalcon2Registers,
+        PFalconRegisters,
         PeregrineCoreSelect, //
     },
     gpu::{
@@ -202,32 +199,32 @@ pub(crate) fn usable_fb_size(self) -> u64 {
 // PFALCON
 
 register! {
-    base: NovaRegisters;
+    base: PFalconRegisters;
 
-    pub(crate) NV_PFALCON_FALCON_IRQSCLR(u32) @ PFalconBase + 0x00000004 {
+    pub(crate) NV_PFALCON_FALCON_IRQSCLR(u32) @ 0x00000004 {
         6:6     swgen0 => bool;
         4:4     halt => bool;
     }
 
-    pub(crate) NV_PFALCON_FALCON_MAILBOX0(u32) @ PFalconBase + 0x00000040 {
+    pub(crate) NV_PFALCON_FALCON_MAILBOX0(u32) @ 0x00000040 {
         31:0    value => u32;
     }
 
-    pub(crate) NV_PFALCON_FALCON_MAILBOX1(u32) @ PFalconBase + 0x00000044 {
+    pub(crate) NV_PFALCON_FALCON_MAILBOX1(u32) @ 0x00000044 {
         31:0    value => u32;
     }
 
     /// Used to store version information about the firmware running
     /// on the Falcon processor.
-    pub(crate) NV_PFALCON_FALCON_OS(u32) @ PFalconBase + 0x00000080 {
+    pub(crate) NV_PFALCON_FALCON_OS(u32) @ 0x00000080 {
         31:0    value => u32;
     }
 
-    pub(crate) NV_PFALCON_FALCON_RM(u32) @ PFalconBase + 0x00000084 {
+    pub(crate) NV_PFALCON_FALCON_RM(u32) @ 0x00000084 {
         31:0    value => u32;
     }
 
-    pub(crate) NV_PFALCON_FALCON_HWCFG2(u32) @ PFalconBase + 0x000000f4 {
+    pub(crate) NV_PFALCON_FALCON_HWCFG2(u32) @ 0x000000f4 {
         /// Signal indicating that reset is completed (GA102+).
         31:31   reset_ready => bool;
         /// RISC-V branch privilege lockdown bit.
@@ -237,17 +234,17 @@ pub(crate) fn usable_fb_size(self) -> u64 {
         10:10   riscv => bool;
     }
 
-    pub(crate) NV_PFALCON_FALCON_CPUCTL(u32) @ PFalconBase + 0x00000100 {
+    pub(crate) NV_PFALCON_FALCON_CPUCTL(u32) @ 0x00000100 {
         6:6     alias_en => bool;
         4:4     halted => bool;
         1:1     startcpu => bool;
     }
 
-    pub(crate) NV_PFALCON_FALCON_BOOTVEC(u32) @ PFalconBase + 0x00000104 {
+    pub(crate) NV_PFALCON_FALCON_BOOTVEC(u32) @ 0x00000104 {
         31:0    value => u32;
     }
 
-    pub(crate) NV_PFALCON_FALCON_DMACTL(u32) @ PFalconBase + 0x0000010c {
+    pub(crate) NV_PFALCON_FALCON_DMACTL(u32) @ 0x0000010c {
         7:7     secure_stat => bool;
         6:3     dmaq_num;
         2:2     imem_scrubbing => bool;
@@ -255,15 +252,15 @@ pub(crate) fn usable_fb_size(self) -> u64 {
         0:0     require_ctx => bool;
     }
 
-    pub(crate) NV_PFALCON_FALCON_DMATRFBASE(u32) @ PFalconBase + 0x00000110 {
+    pub(crate) NV_PFALCON_FALCON_DMATRFBASE(u32) @ 0x00000110 {
         31:0    base => u32;
     }
 
-    pub(crate) NV_PFALCON_FALCON_DMATRFMOFFS(u32) @ PFalconBase + 0x00000114 {
+    pub(crate) NV_PFALCON_FALCON_DMATRFMOFFS(u32) @ 0x00000114 {
         23:0    offs;
     }
 
-    pub(crate) NV_PFALCON_FALCON_DMATRFCMD(u32) @ PFalconBase + 0x00000118 {
+    pub(crate) NV_PFALCON_FALCON_DMATRFCMD(u32) @ 0x00000118 {
         16:16   set_dmtag;
         14:12   ctxdma;
         10:8    size ?=> DmaTrfCmdSize;
@@ -274,15 +271,15 @@ pub(crate) fn usable_fb_size(self) -> u64 {
         0:0     full => bool;
     }
 
-    pub(crate) NV_PFALCON_FALCON_DMATRFFBOFFS(u32) @ PFalconBase + 0x0000011c {
+    pub(crate) NV_PFALCON_FALCON_DMATRFFBOFFS(u32) @ 0x0000011c {
         31:0    offs => u32;
     }
 
-    pub(crate) NV_PFALCON_FALCON_DMATRFBASE1(u32) @ PFalconBase + 0x00000128 {
+    pub(crate) NV_PFALCON_FALCON_DMATRFBASE1(u32) @ 0x00000128 {
         8:0     base;
     }
 
-    pub(crate) NV_PFALCON_FALCON_HWCFG1(u32) @ PFalconBase + 0x0000012c {
+    pub(crate) NV_PFALCON_FALCON_HWCFG1(u32) @ 0x0000012c {
         /// Core revision subversion.
         7:6     core_rev_subversion => FalconCoreRevSubversion;
         /// Security model.
@@ -291,12 +288,12 @@ pub(crate) fn usable_fb_size(self) -> u64 {
         3:0     core_rev ?=> FalconCoreRev;
     }
 
-    pub(crate) NV_PFALCON_FALCON_CPUCTL_ALIAS(u32) @ PFalconBase + 0x00000130 {
+    pub(crate) NV_PFALCON_FALCON_CPUCTL_ALIAS(u32) @ 0x00000130 {
         1:1     startcpu => bool;
     }
 
     /// IMEM access control register. Up to 4 ports are available for IMEM access.
-    pub(crate) NV_PFALCON_FALCON_IMEMC(u32)[4, stride = 16] @ PFalconBase + 0x00000180 {
+    pub(crate) NV_PFALCON_FALCON_IMEMC(u32)[4, stride = 16] @ 0x00000180 {
         /// Access secure IMEM.
         28:28     secure => bool;
         /// Auto-increment on write.
@@ -307,17 +304,17 @@ pub(crate) fn usable_fb_size(self) -> u64 {
 
     /// IMEM data register. Reading/writing this register accesses IMEM at the address
     /// specified by the corresponding IMEMC register.
-    pub(crate) NV_PFALCON_FALCON_IMEMD(u32)[4, stride = 16] @ PFalconBase + 0x00000184 {
+    pub(crate) NV_PFALCON_FALCON_IMEMD(u32)[4, stride = 16] @ 0x00000184 {
         31:0      data;
     }
 
     /// IMEM tag register. Used to set the tag for the current IMEM block.
-    pub(crate) NV_PFALCON_FALCON_IMEMT(u32)[4, stride = 16] @ PFalconBase + 0x00000188 {
+    pub(crate) NV_PFALCON_FALCON_IMEMT(u32)[4, stride = 16] @ 0x00000188 {
         15:0      tag;
     }
 
     /// DMEM access control register. Up to 8 ports are available for DMEM access.
-    pub(crate) NV_PFALCON_FALCON_DMEMC(u32)[8, stride = 8] @ PFalconBase + 0x000001c0 {
+    pub(crate) NV_PFALCON_FALCON_DMEMC(u32)[8, stride = 8] @ 0x000001c0 {
         /// Auto-increment on write.
         24:24     aincw => bool;
         /// DMEM block and word offset.
@@ -326,29 +323,29 @@ pub(crate) fn usable_fb_size(self) -> u64 {
 
     /// DMEM data register. Reading/writing this register accesses DMEM at the address
     /// specified by the corresponding DMEMC register.
-    pub(crate) NV_PFALCON_FALCON_DMEMD(u32)[8, stride = 8] @ PFalconBase + 0x000001c4 {
+    pub(crate) NV_PFALCON_FALCON_DMEMD(u32)[8, stride = 8] @ 0x000001c4 {
         31:0      data;
     }
 
     /// Actually known as `NV_PSEC_FALCON_ENGINE` and `NV_PGSP_FALCON_ENGINE` depending on the
     /// falcon instance.
-    pub(crate) NV_PFALCON_FALCON_ENGINE(u32) @ PFalconBase + 0x000003c0 {
+    pub(crate) NV_PFALCON_FALCON_ENGINE(u32) @ 0x000003c0 {
         0:0     reset => bool;
     }
 
-    pub(crate) NV_PFALCON_FBIF_TRANSCFG(u32)[8] @ PFalconBase + 0x00000600 {
+    pub(crate) NV_PFALCON_FBIF_TRANSCFG(u32)[8] @ 0x00000600 {
         2:2     mem_type => FalconFbifMemType;
         1:0     target ?=> FalconFbifTarget;
     }
 
-    pub(crate) NV_PFALCON_FBIF_CTL(u32) @ PFalconBase + 0x00000624 {
+    pub(crate) NV_PFALCON_FBIF_CTL(u32) @ 0x00000624 {
         7:7     allow_phys_no_ctx => bool;
     }
 
     // Falcon EMEM PIO registers (used by FSP on Hopper/Blackwell).
     // These provide the falcon external memory communication interface.
 
-    pub(crate) NV_PFALCON_FALCON_EMEMC(u32) @ PFalconBase + 0x00000ac0 {
+    pub(crate) NV_PFALCON_FALCON_EMEMC(u32) @ 0x00000ac0 {
         /// EMEM byte offset (4-byte aligned) within the block.
         7:2     offs;
         /// EMEM block to access.
@@ -359,7 +356,7 @@ pub(crate) fn usable_fb_size(self) -> u64 {
         25:25   aincr => bool;
     }
 
-    pub(crate) NV_PFALCON_FALCON_EMEMD(u32) @ PFalconBase + 0x00000ac4 {
+    pub(crate) NV_PFALCON_FALCON_EMEMD(u32) @ 0x00000ac4 {
         31:0    data => u32;
     }
 }
@@ -385,13 +382,13 @@ pub(crate) fn with_falcon_mem(self, mem: FalconMem) -> Self {
 
 impl NV_PFALCON_FALCON_ENGINE {
     /// Resets the falcon
-    pub(crate) fn reset_engine<E: FalconEngine>(bar: Bar0<'_>) {
-        bar.update(Self::of::<E>(), |r| r.with_reset(true));
+    pub(crate) fn reset_engine<E: FalconEngine>(pfalcon: Mmio<'_, PFalconRegisters>) {
+        pfalcon.update(NV_PFALCON_FALCON_ENGINE, |r| r.with_reset(true));
 
         // TIMEOUT: falcon engine should not take more than 10us to reset.
         time::delay::fsleep(time::Delta::from_micros(10));
 
-        bar.update(Self::of::<E>(), |r| r.with_reset(false));
+        pfalcon.update(NV_PFALCON_FALCON_ENGINE, |r| r.with_reset(false));
     }
 }
 
@@ -405,23 +402,23 @@ pub(crate) fn mem_scrubbing_done(self) -> bool {
 /* PFALCON2 */
 
 register! {
-    base: NovaRegisters;
+    base: PFalcon2Registers;
 
-    pub(crate) NV_PFALCON2_FALCON_MOD_SEL(u32) @ PFalcon2Base + 0x00000180 {
+    pub(crate) NV_PFALCON2_FALCON_MOD_SEL(u32) @ 0x00000180 {
         7:0     algo ?=> FalconModSelAlgo;
     }
 
-    pub(crate) NV_PFALCON2_FALCON_BROM_CURR_UCODE_ID(u32) @ PFalcon2Base + 0x00000198 {
+    pub(crate) NV_PFALCON2_FALCON_BROM_CURR_UCODE_ID(u32) @ 0x00000198 {
         7:0    ucode_id => u8;
     }
 
-    pub(crate) NV_PFALCON2_FALCON_BROM_ENGIDMASK(u32) @ PFalcon2Base + 0x0000019c {
+    pub(crate) NV_PFALCON2_FALCON_BROM_ENGIDMASK(u32) @ 0x0000019c {
         31:0    value => u32;
     }
 
     /// OpenRM defines this as a register array, but doesn't specify its size and only uses its
     /// first element. Be conservative until we know the actual size or need to use more registers.
-    pub(crate) NV_PFALCON2_FALCON_BROM_PARAADDR(u32)[1] @ PFalcon2Base + 0x00000210 {
+    pub(crate) NV_PFALCON2_FALCON_BROM_PARAADDR(u32)[1] @ 0x00000210 {
         31:0    value => u32;
     }
 }
@@ -429,23 +426,23 @@ pub(crate) fn mem_scrubbing_done(self) -> bool {
 // PRISCV
 
 register! {
-    base: NovaRegisters;
+    base: PFalcon2Registers;
 
     /// RISC-V status register for debug (Turing and GA100 only).
     /// Reflects current RISC-V core status.
-    pub(crate) NV_PRISCV_RISCV_CORE_SWITCH_RISCV_STATUS(u32) @ PFalcon2Base + 0x00000240 {
+    pub(crate) NV_PRISCV_RISCV_CORE_SWITCH_RISCV_STATUS(u32) @ 0x00000240 {
         /// RISC-V core active/inactive status.
         0:0     active_stat => bool;
     }
 
     /// GA102 and later.
-    pub(crate) NV_PRISCV_RISCV_CPUCTL(u32) @ PFalcon2Base + 0x00000388 {
+    pub(crate) NV_PRISCV_RISCV_CPUCTL(u32) @ 0x00000388 {
         7:7     active_stat => bool;
         4:4     halted => bool;
     }
 
     /// GA102 and later.
-    pub(crate) NV_PRISCV_RISCV_BCR_CTRL(u32) @ PFalcon2Base + 0x00000668 {
+    pub(crate) NV_PRISCV_RISCV_BCR_CTRL(u32) @ 0x00000668 {
         8:8     br_fetch => bool;
         4:4     core_select => PeregrineCoreSelect;
         0:0     valid => bool;

-- 
2.54.0

