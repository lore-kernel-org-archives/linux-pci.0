Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021095.outbound.protection.outlook.com [52.101.100.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CA43D891E;
	Thu, 18 Jun 2026 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781802304; cv=fail; b=AKFLzS+inJreqJ8MedvMdRmC/V/3Ur/dJ6UkyT8KBlD3SMdYVEGEnc9alVr01M5ir3/XX6bphMlO1n7VC5KF/0yr7Kth0A/x61oCW7EiwbJAR50+HaA8+01ti7DOoHYjp5MeFi9XxK36oIdKtAF4rOmIszY+rOBBXdjKZxf7P28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781802304; c=relaxed/simple;
	bh=vM+4EwxTqnLZsJlEGl4U+mLg2IkF+9mY6+LzDXoKPxc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=byPy7Dgr8HPqaSpF77eJPSnkUYhBvFymU/QMpdf1FndoJTmrryZzBanwYDM/4cu1pJZc4ndvTCQNVC7/vf0wYSKJkum6PHABMUENDSzR9OaK4JiQ/OH7Z4yMONHUC15VGWSjS9LRX0VXXxH7+tRSusnJ4nMRL7JKGBLzQGp0HVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=bhv2H6Yy; arc=fail smtp.client-ip=52.101.100.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="bhv2H6Yy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2bVAfj+o13wRsDpOVYIVvYcbgYQRk0DsyoOifA70EeecB0kkYkU1WqgegI7TaUzsoXrtvMHeHqappc4Qy1YPmRx1XDlyVX4ljCe0QNrietI2E/RULdfisUI7o7bxMH3w4SQdNeGgdHXGEFVMEgnUxmBnG9FAckcJn2oZya0qw0rr7P3cP8PLC7zNrU/fhcHN+9QWWHB6IENEOvu4TBjMYTTnzIb3jSRH6BRlKS6qxMasbaNcdboAsgVeJk0D9rDbwdUcmRwXlj/nftkak3x/7NWiuO/GEas/WRX2qZzpMigsjzFPzgKd06dd5mkbsTAABViE93+aRmUtQ3ds/KwlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbq9JYxSFEEujyBl/Q/9Y8MM++bo6kvGCCsEYLS0su4=;
 b=bmIARbwwas6i32+gbemxR37BJX9jqtR6gZC9PK3nVMb4RNx7RZEqxzxKmbz1b5N4GrLLpTZwmyAoQuvzzXZAHBDgfUQ4Z2G0lIrmYougadkNsnd2Tb5CybwhlNOZJs9DmEXHKf9G/5YpgBuX+HbxyaftXZJ3TQeIw13r4j4ppdl8op+ODNlzHZVSrzHAfKVDwGws1k358LC9vKuI+2rir4gbkLYZNosHMwADJevpbCxEGwYz3hONkes6af3+FrpMqNuoI0O8JQRfBP9Y2/9mRCx9WLe+KFS/2Uman/CahGztuNGqIeAeUFySlF/kJTVIBVt2YsPAhJJgww3EqofmEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbq9JYxSFEEujyBl/Q/9Y8MM++bo6kvGCCsEYLS0su4=;
 b=bhv2H6Yyds/Yaq5co3bvcytVTfd+2utYGrtCj41kC9usa1EWDIbbWMMETOVcHSCoOvMRD2y6QKnMecN68zb+c3xTz5QOeo459TtGwGsHMkZR4elLQ/Et7J4XPvaIyQ1ha+wadz9XMnfq3HcvnGxWKRANUi/NDTQ7uS3T0claH+o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO4P265MB6966.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:34d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 17:04:49 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 17:04:49 +0000
From: Gary Guo <gary@garyguo.net>
Date: Thu, 18 Jun 2026 18:03:46 +0100
Subject: [PATCH 09/10] rust: driver: remove duplicate ID table
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-id_info-v1-9-96af1e559ef9@garyguo.net>
References: <20260618-id_info-v1-0-96af1e559ef9@garyguo.net>
In-Reply-To: <20260618-id_info-v1-0-96af1e559ef9@garyguo.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, Dave Ertman <david.m.ertman@intel.com>, 
 Ira Weiny <iweiny@kernel.org>, Leon Romanovsky <leon@kernel.org>, 
 Len Brown <lenb@kernel.org>, Igor Korotin <igor.korotin@linux.dev>, 
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, 
 Gary Guo <gary@garyguo.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781802282; l=5814;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=vM+4EwxTqnLZsJlEGl4U+mLg2IkF+9mY6+LzDXoKPxc=;
 b=vcNY1W3BYSz5bcTTFXTEVlhzLcAPALAdaJJF/5U0vRgTFLIEbDmRFIX+334zLTCDctGgv9Sxx
 i+aBWwKStpbD4cL3k4f8HeAJieuGFAaajYDq0w3QWlpk4V3LHUzVPP1
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0548.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::11) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO4P265MB6966:EE_
X-MS-Office365-Filtering-Correlation-Id: 5352048f-bff5-4939-e8be-08decd5bb4a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|1800799024|376014|366016|7416014|5023799004|921020|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	dza0LHMz6LB2PFpxhA5Xd0BfTSU6sMo4QbDi5PIToL/m3c0JAma3fHmSOAXPIiF7jG2Ik32N69S/f2v6SLmRqrd9s6xGiit27dLdWADJ2KZJUWJL+IQ9FiF/1JbHDv67NHk+oUsRdxp4V4FMxy+MH9Kvre5liBf5UNuFWpUvm9woLClvtYRVRD8upM3pIKm9f+vbq9IyhX2+k2ZJrYE/tCscX+OYag0Zv+unRvy6AhounzWka3leclZ5q7wL9Ioqaq4YKDIYy44ONU0NFm4EC2WnyzyOeo6ueU7oUAghiLA3D7XIT+THcO0AYcXIhP044YGHCd2vtoO6/dA2EPdJpndUM8uAHofHkRRuMaJQfvrVzmf9CbBGUw4FIFGJ7McGAamfVsIlVbJs3VtkCiPXr0w+FYiwKkPjxCODUb5Jc1gnn99Vws1vzCgmxYi/ikldlcQuilKyUmaqKjoTP5fHtDpQgEDVKlChckjxGJvP6Go34h/DN70SAUg8BCSZUDn6pnF1r/9rUb4VJsKYcO8smzuqQenQI/sQx38OWC7PxSzXpeDo1dLK+/gNINI1/4+zbe3PirtkykRwsfFRSNmMEE0wvRT8j9TzAHa0NvmBKnup/+ht1dxDM+glnV2kVYRH1eiKHf1gK985381WKJm6CfslsxAAwGAZQtVbhlxpXSZ2EYbk41Fo27hy7J9FH17OiJ6yHNvlX/c7I65+cLsRlwmkOmSwlu4GvjmOn8NfTj0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(376014)(366016)(7416014)(5023799004)(921020)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFhNZkdGS3dPTDdSaUtVYmZ4U3JSaG9ncThNUnRtVkMxdWtDeUZyMWhjWVlY?=
 =?utf-8?B?QUxJWkd5YkEzYVZuY0Q1eHVnd3Zhb0luS3FPMW42QkFSbzFhb1dWM0dLZ0ww?=
 =?utf-8?B?bzY2aGJnSWNKMUZmalc5ZUlyUWlRS0ZXTnhEbHJHOEQ0aERpQnEydzVCM29n?=
 =?utf-8?B?QjF1ZHZDYndpa25BTFN2NUt3TVc0SWFkRHFSb1ZKWEtoaXJJRnNVRmJOKzVK?=
 =?utf-8?B?bGI0UjY3dmZmMDZxdjlUOFFSOFM0eExYaFArck5UelJqRWV1b3E0SnpNM1B2?=
 =?utf-8?B?eEZrcWlGalExNUduMDBWVTB1Tk96MXBHMEViMGZMelcvUlE3WkdPV2RHa1pO?=
 =?utf-8?B?RkJaY2NOUE5Wb2NUQnZGM0w0b2pkMEUvZEczOGZkT2M0dVdNSXRjMk1Vcm1J?=
 =?utf-8?B?bXhjK0tkSkJMNHlYSENFNVNPYlQxQnpUbTRPeWUxVHpnb3kwUUZjZW5MSHVH?=
 =?utf-8?B?ZXlJaWkyNTFCRE5QU0pzU1pERmMvNzJ4eUExNzBDUm5TTUNKQTREQWVxTDFS?=
 =?utf-8?B?c3Z5U2N4eXRFWXR6d3gxNG9RdXRUcHpRcHhNWU0vdG5GZjZUUlNndzdWTXls?=
 =?utf-8?B?UkhicTZmQUZ1RS8zQU9kRm03UkxxWGRYRWswdHdWYzZybXhqRGFFTWRFWGph?=
 =?utf-8?B?UXRRcWdmZEFjaldJYjdNWmYxTlZUdisxaFdOYWdVR2dZMFFRbG1CYmdCV1Ry?=
 =?utf-8?B?SXo1L0EvL1VEeTB2dEpMdTVuRHhmd0p4V0V2ZDI5WmlucW0zTllCUHlFM0Fo?=
 =?utf-8?B?ZWtSSnZEbzlzdTJKNVI2Y0wvWXc0YTBuVERaNGtzK0VGeWtIazZIcWt1RFhH?=
 =?utf-8?B?WFJzWkJ6V1hpYTJKa055QTNIV3N6RUp1SVd3dWpKUDJ3U1J1ZE9EaTlJVndh?=
 =?utf-8?B?YU9qcGMyUjhYSSsyY3hRc2lUMTR4aCt2eE1qYmdlQ012OXFDSmE4cjNkckxl?=
 =?utf-8?B?ZlRRVWpMM3RUNzlvV3h0NmhtUXU2NVBnQ2x2Q3ZPN2pFMHpCTVRSM3dkQ1RP?=
 =?utf-8?B?WTBPc0lXZFRSbm9UcFUzVVdsVTlvakk5K1g4VC9LNWkwb3VsREdUa2UyUGpQ?=
 =?utf-8?B?eGNlWEVEZXJOMGNRTTQ1Y3Roakl5SUdDbFN3elQrNEdwWUZJR3piUUJIaUEw?=
 =?utf-8?B?L2xJYjRmQkdNVktYbitGcGZNT0NkYmNrOHo3eHhtYm1EbncxeDJqNXBHc2pO?=
 =?utf-8?B?NmY1bkhEOFFDNXo1bExQNmVyYmxGUWhPZjNsQkMxckk4QVY5RVRUZTB2Y2tp?=
 =?utf-8?B?QlFiNENiUjZ5MTRWYzAxSHdvRDJMU3JFUms3YnEyaDBZRFFRUGt1K2tmVWg1?=
 =?utf-8?B?SHczYUdxMGNRaTFsOVpYWWliMmdiK25QSmxEcWZ4UndjSkh3RlFka1FPNUh0?=
 =?utf-8?B?R1NjTFh3bFV2Y1hDV0ZyUDE5S2J4QW0xQzdHc1VtYWJISDhaTlpSQW9ud1lU?=
 =?utf-8?B?a1JxNE8xTjh1bU1VTjN3QXZwY1pmZnl1RzFKQnBYVWJQYUNnQzl2eUZTalI3?=
 =?utf-8?B?eFAyYW9md3hvTjUxY3hZdEQwQVF6c0Rvb1VWK2hqQ3cyZDBWdENmeExZTHlJ?=
 =?utf-8?B?ODJmLzh0d0k3VE9lanNDMUMvRlpNMjRYT0kvZStyVDEyaUdiRFFabG05OFZx?=
 =?utf-8?B?UTIwVU8yR0NKVDZxdUM0R0trN2FiN2tSQ0xaZDU0ZllYeWh1UDN1bktQcVI1?=
 =?utf-8?B?WU1NS3hPL21JU1NKUGZ0a3BpaEE4RlBHZmdHbE9aK3lTZU1SZ3dQcndPVEZh?=
 =?utf-8?B?a2x5dVJVaS9zcDFvQStwd1FJWnRyNmpnaEthN0pvQjFOVjlYMmZ3cGw5NHg3?=
 =?utf-8?B?eTdNRGZvc25jQ3BNMHBsSjRSMXk5bmpnSExMT3h6eXJPZUM1a0hUSlFwZ3Ex?=
 =?utf-8?B?UGNzNkNxVTdjWnlUSmpTTVJvNTlheW5IWjZWb1dyYTZnK2w0R2lVU2JVNyty?=
 =?utf-8?B?RFE3WXVwbUgycmx4NUx2TUx3UHZ6RWp1eWFDU0NoaDdPOElXNysremNYUVY5?=
 =?utf-8?B?anEzZmtEZnZ4amFBZllpbHYyQTZJVkxnNzE3dDRSZUJyZ3dncjJMT0lwYXho?=
 =?utf-8?B?eWpMczMzK3h0Unljb2hRa2VrMDFKbWxmZ3ZiM0V1c3RNQ25yK2pLNmdSR3dK?=
 =?utf-8?B?dXRteXQycWpZQzZxaGZ0RDdXWDI1bklKdzEwcE1Tc0YxSkpFVTdMenI1aTZQ?=
 =?utf-8?B?dnlXbFdYZXZSd1pWYmNCbW9seUIzTlVwamRNa1g4STB0amkxWFFoR2lkaU1n?=
 =?utf-8?B?SkJOSis5SDJScVo3Y3RQZytCbFpwRHIrTEY0U0xVaExNVnkzdlBnakJwOFpa?=
 =?utf-8?B?VFRyVjVIZG9STjBxckF5VHRNVS9IMUlOV3pUTE9ObFZ0NzljVy8rZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5352048f-bff5-4939-e8be-08decd5bb4a7
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 17:04:49.0483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7fnliJ8RL4f4GIZ1mQKaJQW38K+xxnFquVDVoSF7N3BHwJ1QaMMwJfteM7eM7Laf+4E0g4++r/NQ4yfl6Kos9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6966

Previously, `IdArray` contains both device ID table and info table so we
keep a separate copy for MODULE_DEVICE_TABLE for hotplug (which needs to be
just the device ID table). With the info being changed to be carried via
pointers, `IdArray` is now layout compatible with raw ID table and hence
there is no longer a need to keep the distinction.

Deduplicate the code, and remove the redundant copy for hotplug purpose by
just giving the `IdArray` instance a proper symbol name.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/device_id.rs | 76 +++++++++++++++++-------------------------------
 1 file changed, 27 insertions(+), 49 deletions(-)

diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
index 59453588df0e..26618bcda276 100644
--- a/rust/kernel/device_id.rs
+++ b/rust/kernel/device_id.rs
@@ -86,28 +86,23 @@ unsafe fn info_unchecked_opt<U>(&self) -> Option<&'static U> {
     }
 }
 
-/// A zero-terminated device id array.
+/// A zero-terminated device id array, followed by context data.
 #[repr(C)]
-pub struct RawIdArray<T: RawDeviceId, const N: usize> {
+pub struct IdArray<T: RawDeviceId, U: 'static, const N: usize> {
     // This is `MaybeUninit<T::RawType>` so any bytes inside it can carry provenance in CTFE.
     // If this were `T::RawType`, integer fields would not be able to contain pointers.
     ids: [MaybeUninit<T::RawType>; N],
     sentinel: MaybeUninit<T::RawType>,
+    phantom: PhantomData<&'static U>,
 }
 
-impl<T: RawDeviceId, const N: usize> RawIdArray<T, N> {
-    #[doc(hidden)]
-    pub const fn size(&self) -> usize {
-        core::mem::size_of::<Self>()
-    }
-}
+// SAFETY: device ID is plain data plus a `&'static U` and can thus be sent between threads safely
+// if `&U` can.
+unsafe impl<T: RawDeviceId, U: Sync + 'static, const N: usize> Send for IdArray<T, U, N> {}
 
-/// A zero-terminated device id array, followed by context data.
-#[repr(C)]
-pub struct IdArray<T: RawDeviceId, U: 'static, const N: usize> {
-    raw_ids: RawIdArray<T, N>,
-    phantom: PhantomData<&'static U>,
-}
+// SAFETY: device ID is plain data plus a `&'static U` and can thus be shared between threads safely
+// if `&U` can.
+unsafe impl<T: RawDeviceId, U: Sync + 'static, const N: usize> Sync for IdArray<T, U, N> {}
 
 impl<T: RawDeviceId + RawDeviceIdIndex, U: 'static, const N: usize> IdArray<T, U, N> {
     /// Creates a new instance of the array.
@@ -137,22 +132,13 @@ impl<T: RawDeviceId + RawDeviceIdIndex, U: 'static, const N: usize> IdArray<T, U
         core::mem::forget(ids);
 
         Self {
-            raw_ids: RawIdArray {
-                ids: raw_ids,
-                sentinel: MaybeUninit::zeroed(),
-            },
+            ids: raw_ids,
+            sentinel: MaybeUninit::zeroed(),
             phantom: PhantomData,
         }
     }
 }
 
-impl<T: RawDeviceId, U: 'static, const N: usize> IdArray<T, U, N> {
-    /// Reference to the contained [`RawIdArray`].
-    pub const fn raw_ids(&self) -> &RawIdArray<T, N> {
-        &self.raw_ids
-    }
-}
-
 impl<T: RawDeviceId, const N: usize> IdArray<T, (), N> {
     /// Creates a new instance of the array without writing index values.
     ///
@@ -164,10 +150,8 @@ impl<T: RawDeviceId, const N: usize> IdArray<T, (), N> {
         core::mem::forget(ids);
 
         Self {
-            raw_ids: RawIdArray {
-                ids: raw_ids,
-                sentinel: MaybeUninit::zeroed(),
-            },
+            ids: raw_ids,
+            sentinel: MaybeUninit::zeroed(),
             phantom: PhantomData,
         }
     }
@@ -200,13 +184,17 @@ macro_rules! module_device_table {
         $table_name: ident, $id_info_type: ty,
         [$(($id: expr, $info:expr $(,)?)),* $(,)?]
     ) => {
-        const $table_name: $crate::device_id::IdArray<
+        #[export_name =
+            concat!("__mod_device_table__", line!(),
+                    "__kmod_", module_path!(),
+                    "__", $table_type,
+                    "__", stringify!($table_name))
+        ]
+        static $table_name: $crate::device_id::IdArray<
             $device_id_ty,
             $id_info_type,
             { <[$device_id_ty]>::len(&[$($id,)*]) },
         > = $crate::device_id::IdArray::new([$(($id, &$info),)*]);
-
-        $crate::module_device_table!($table_type, $table_name);
     };
 
     // Case for no ID info.
@@ -215,26 +203,16 @@ macro_rules! module_device_table {
         $table_name: ident, @none,
         [$($id: expr),* $(,)?]
     ) => {
-        const $table_name: $crate::device_id::IdArray<
+        #[export_name =
+            concat!("__mod_device_table__", line!(),
+                    "__kmod_", module_path!(),
+                    "__", $table_type,
+                    "__", stringify!($table_name))
+        ]
+        static $table_name: $crate::device_id::IdArray<
             $device_id_ty,
             (),
             { <[$device_id_ty]>::len(&[$($id,)*]) },
         > = $crate::device_id::IdArray::new_without_index([$($id),*]);
-
-        $crate::module_device_table!($table_type, $table_name);
-    };
-
-    ($table_type: literal, $table_name:ident) => {
-        const _: () = {
-            #[rustfmt::skip]
-            #[export_name =
-                concat!("__mod_device_table__", line!(),
-                        "__kmod_", module_path!(),
-                        "__", $table_type,
-                        "__", stringify!($table_name))
-            ]
-            static TABLE: [::core::mem::MaybeUninit<u8>; $table_name.raw_ids().size()] =
-                unsafe { ::core::mem::transmute_copy($table_name.raw_ids()) };
-        };
     };
 }

-- 
2.54.0

