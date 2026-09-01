Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020089.outbound.protection.outlook.com [52.101.196.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC662481FD1;
	Tue,  1 Sep 2026 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281439; cv=fail; b=HA/TW4KQI4OlRjLljUC2ZnkqKyy/+zqFXvR0yq2Ml5MG4w7KmwvaboPUxUZ4pAxuw8yg928xMXVAdZkyZEQVYGFtn+MFYKGgx9SKN7dcxB4BSRhZggI7NAtrKXmhV82sdnl0I1R+zVK0U1LL9i9lAYq4RKgp+oKZaM00Js0ljWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281439; c=relaxed/simple;
	bh=UHKH4zyYBytsX3yO7lbFYKBzvVJUryht3EMmJm8jozY=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=P7UJDBnIdCNZzBynENtDwPsRAO8p3FvIitK2wFy4SFKDOXk0l14Ey79Od2qO6uCS3kWeWKvMdF3tU9zUSDS9gpVBJP4RzFGyXDiW+aaf/HnPrQfm83fQsDzsEbsMfcVjUXpaJwLDPPvakVP3hSFxTyk5r+zD2jjlFc+Wv75hnhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Tw6/oquS; arc=fail smtp.client-ip=52.101.196.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="Tw6/oquS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bdzOnzYrcvY/swV9r8s+fCtiuOrSFejVFpMUhW3QcxDusSn762m4d2gVMTlYYBOHTuPb4gY/LDxGE+1YWryFAUGsv8G5xAs0EwWUgPjQSGq8Dibsk4T/F8J+iClutk7yWg17HEwEqLId4rfUGP6p9E2Q2Sl98zwyQpvAqm3QO0kwIhL1XrbGUhIHVJG9qA8kbVwVqLG7H5wR8Uzrc8JwyvMMpzxyKcn1dLc2kP6p4QsQCW/g/lAlq3IcjLoNbio5fYFatRnxNpFH5mMfUUiFngqYkk3/evwAu+20vsP8ZWSBrDrBIE4my7MyJP1ATYZ2npk0iLa0Urp1RV1SMV26Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ig7lugtsLlgWziVqLe0/Z0Y7oBFIKuQzN9aKaxiTeG0=;
 b=glS3oX66ORxWAUu6bQ/effaccZE7pw1xhA2p+JxwuK6jdSVEAJkmnjsRaAQYg4+qIeVjewZNZE7Fgf10sInOw6OnL9pzKxl5pKAG8XhdcIXduAkbZs98y2ZGML5YYRdIr/73vwnxYIdk5epshe8L4TMzVpMn46Z0KmpQA8sw+HauOo5BaqhjlunUwuhxuBdGT+rC8VbnezVSYHCqXIvMjO27ozQ4w9xnpGBzzIFOJTds10FCww1JiSQSZjz2MAZGzNaFT2Gi6NLv5B324n105W1e0TB4ad9Fv/GQBzoT5ghFg5U9Te02OzX/sEafF7Y/cb7TsnOwUdaNSsUQGeuKoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ig7lugtsLlgWziVqLe0/Z0Y7oBFIKuQzN9aKaxiTeG0=;
 b=Tw6/oquS312zLiRE1AJlDa+IhLMOnWqfnkAi4eTWQ/y7OcVeEhHHnADRV69BH2+QzYIphsDGMUgFgGr3CrnJfuQl+zTh631ofPQeUi1sw2qBbfewyRC53FITN46ErVKTxZIJ15X6I+1jsCCtNusljB0R8Itc1lwWTlT24mq2KxQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO0P265MB7316.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ef::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 16:50:32 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 16:50:32 +0000
From: Gary Guo <gary@garyguo.net>
Subject: [PATCH v4 00/16] rust: io: support register projections and remove
 relative registers
Date: Tue, 01 Sep 2026 17:50:24 +0100
Message-Id: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFACl2oC/3XO0U6EMBAF0F/Z9NlqOwUqPvkfm42ZlgFqtGzaQ
 iAb/t12fVBDfLyTOyf3xiIFR5G9nG4s0OKim3wO1cOJ2RH9QNx1OTMQ0AgNkqftSt1boMHFRIF
 L3RAahYZIs/x0DdS79Q6eL985zuadbCpKaRiMxE1Ab8dy+nB+XrmnNT19YiFLZ8z4FLb7qkUW6
 98Bi+SCVzV0GkyTO/A6YNiGeXr0lFiZsMAP8CzqAwAZsMqirABAoDgC6hcg2wOgMqCatkVd99j
 18i+w7/sXK2UxZGYBAAA=
X-Change-ID: 20260721-typed_register-176eab3abee7
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788281431; l=5764;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=UHKH4zyYBytsX3yO7lbFYKBzvVJUryht3EMmJm8jozY=;
 b=c/skwdWn4QYGIVRI4NePMh/PpUn71kGDiWIJCQWVXIaZG+l+KND0Mo3nK4iAWGzyQ9pQuPQQ0
 VZxjKD1N7eHAbUn2TMmUh0AQNzUW40ezOil0NnzGymrozQ0Sf1kxxXa
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
X-MS-Office365-Filtering-Correlation-Id: 620eac85-c3b0-47db-c795-08df084922db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|10070799003|376014|7416014|10067099003|56012099006|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	J+EqeZ5K1S/P+uTewWH37e5T4D9ZaDuV42pe51AGzI6ujXKZfg/w8lMsPCZXMWRAAUkaVsCmGY85T1AJxTAaeYVpgzzrkcwrF8xLyfNN7A48GpWRgOaPwyCUbBXm5EuwVlIj2aSGsxFjCH3rk+hwlk0MiTkyRTR7So5gDmaqX0Lwl88V2KiT+jt6CFElvA7Ow2kqajXpTYHF38TsqRTsozXrlA90rQMP8dp+n5neS7Y6izRRsoKJ44/WfxFGRJPpBKcRH5TXLlPVvQ0PXwZ9c6603I6Ecq4GKhYK7/U5lxoK+YyHotUuLc0aOU6uKKETUKXsHoP7ccBjQRh2LNcqH+FU1EMu4qij5mw7rSrApkwGRxoe8OlsJaw5jeHxALnZkk6moPHDzVMjQoMo249bWOK3i9mxgryh5wJme7TVX+Z5Jw7ehAZD+weFjEIJeHENFcihUa09mMtq9fAZPFDQTZvVYRThqfyaICtyE/5vwaE17L8eJTyLikLQlG1yWu8pxGbcULcQSP9WoPkBTbDEBZtfr0rSYxyQ4n98rkkfwXeTBNV2FqVxBZ4fE/rFe1ktjkyFTEXtYhlJgRQYqKMnnOibI70+hFg2891b8tpjXZ6tR0GYbsnA1yW47DOvN0KbkXRcWfVqaqlAS1VWSePCORzaS3KZb2a9DCNJc9xNFEI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(10070799003)(376014)(7416014)(10067099003)(56012099006)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlZTU0F6TUdDd1FTTVh6aW1abnVXOGZ3WUo1UjZ4b0xPYyt1NnBJUHA1M2Jm?=
 =?utf-8?B?M3p5V3lFVjdCN1N2T1FnUlNyY1dFYTA4aWoveXFNL0w4djc5TFdiU1dKaXFz?=
 =?utf-8?B?RHloNktpcDNrRW1tTkJPZGdYejNMUUx3YVkxU0xlS0hxL1dnYWpGQXBzV0pa?=
 =?utf-8?B?NWxHQlk4UVZTQlFKTDRMZHdXMkZuRFQzTlBRdW1obkF3bmx6dmk3eWNkSThu?=
 =?utf-8?B?eWhBczBQcXQ3YVIramc3TFp2SjZTSlBhQnI0dWcrb3dyMGQ1cUxOSWlHZTVG?=
 =?utf-8?B?cUFReUFDVWJ5c1ZnTkgra25vUzN4a2pUdWFsVGRlb0V3WnFxVHR3Y1NzRmh1?=
 =?utf-8?B?dG5GcmcvZ2pvaDBpRUJsNkd1NThCM00zdlNPeFBkM21mWGNqVm00T1NLQVNP?=
 =?utf-8?B?dy9IM2k1bVpyRkg2SDdtdFBMRHRhUXVxbjh0RTUrOTEzTGdMaVo2Tkx2MGN1?=
 =?utf-8?B?dEIvOEtTOVJuTmhwa0xDWks2MjFiSFFjY2xhYm5NV1FFUE1zVk5ISStDemNz?=
 =?utf-8?B?Zjd3Tnp6ajlNOGdEVCtmanBHczJNWkl5b1ZSQTV2MVNYd1pCM2VZS3FYMjVi?=
 =?utf-8?B?UTg3UDJBcFVLUkxzL3NodGkzYi9lZ1BwUzRQaEt1VFhBbVRCbDRmN2M4Skhz?=
 =?utf-8?B?QkhHS3F0bXVHNEt2UUhySk9XYnEzMk1PZkNFSVQ3Rm5wRzJWRGlPZ25qR09V?=
 =?utf-8?B?YmJxeXl6ZERyUGNiVHU5MEJJUU5yN1lNTkVLNndTdUljVDhPQXNRd3lVL3Fr?=
 =?utf-8?B?eGk5OU4xVmV4K3VVVWpremY0dmtBa1VraW9DZ1NmcDR1OFBpSnhjTEMzYzdi?=
 =?utf-8?B?K2dIYUhOb2g5ejk2bkIxcHY5RloyOW9DZTdqZTh3clE0d1l5TGZ6RHpXQkVw?=
 =?utf-8?B?c0tTOHBka1liZW54bDVkcXhES2RqR09xTGFYTHlRaFlWZEN2Z2tkT2hKaGhi?=
 =?utf-8?B?Z2hsZXVZRGF2VHNNb1hSeHd2ZnVxcFpPV0h3a3hqVUpNbFQxUHp1YWcrQWUv?=
 =?utf-8?B?eGdja2R6SVZKcWZjTU9UZWUzb3lSYytVejFZZjVFb3VZL3JUVFZydXBXcTFn?=
 =?utf-8?B?YzExQVNlNS9jKzhuNGNVMEppWUY5Y2RLL0NOaUNLUE1PV3d3NHZWMnlTNHNV?=
 =?utf-8?B?WnRXVWdxVTM4N2xCMFhXMDcreGZaSjEyZXQ4Y3VGQURzY1hzMm9qbFZBbmpN?=
 =?utf-8?B?QnJxVk5XSG85R0VJeEwrNFQrcDVvZ0J2RHJUZVBodlZMd0pUT2pmR2JqaWtD?=
 =?utf-8?B?dHVHMjJ2WlpYOWZhUmdMVmU0K2JnNkYvNVJHSGRWSFFQeC9WUUN4M2FmRVBH?=
 =?utf-8?B?L21vTlZWL0Q3MjR4OUhJSm1nVFJEcllZTkZ5YktSeDVwZlVCZjMyUSs1RnZt?=
 =?utf-8?B?eFoyelRUWGFUdE9LQnk4MTBNM3JFWFJ6dURNUXRiZnhMWnpGTGJhckNnazBW?=
 =?utf-8?B?RFVNRGFSc2dTM240MTlaYUttU3ZMWUlFNzE3VXBLN2MrcHM2WjNiV1oydUZl?=
 =?utf-8?B?R2IyaWROZW1ESGpXVWNUemJkZWFCK2c5cTV3YW1KaTVrMUZPN0ovakpaTXdX?=
 =?utf-8?B?TDQrUk03ZHlEbkM5UTVQdHQ1SkRHVEx4YVJ2SnJDWGxhdzlhZ3V0N281cEJP?=
 =?utf-8?B?RHZyckFHb1ZvUHlpR0ZialVMcWF5RmtibVA4QVdva1hFdE43TFovZ1EySExn?=
 =?utf-8?B?TmJsNDA3Y2hnUkE1ZW1ZZHZKRjRpMk5SQ0lCRVczV0lQUFdSVWJkY0tFWG5k?=
 =?utf-8?B?K2FVV3liSUhHb2dQbWpuZW1DZ0FGVm4wc29pdDRyRkk0Wkhud2dMaU4xdmdL?=
 =?utf-8?B?Rjk4NndxTG00N0hTS1VNLytLcTNxcllsZHZGU3JKS1hBcjNsaW5JeFowZ1hl?=
 =?utf-8?B?d09SQ1hyVHAzd29odExQRkJ5YSsvczJhUHAwZEFxZGN1Yy9IUXVSZTNDbjBt?=
 =?utf-8?B?YVlVMDgzd1JqVnZoNWhSbmZUcnVJY1ZUMUdITk9hOEpxK09OekhmMlRLTTI3?=
 =?utf-8?B?alR6ay9mSWsxQ1o0VERoUGk4RmgzOHlQcXh1VFU1U3QreDlaUXpjekhCNjBt?=
 =?utf-8?B?RXNYUUt6dURhRUJURTFGMVNoNFVqQ00xS0hCdDVTcTY5YUhsM250cWl1U2hj?=
 =?utf-8?B?SmM2VnNTQUtKTnh3ck5Ebm1kbDRlc1hwN3NBMDExUVJKTUtZMWt1TVRQbVJD?=
 =?utf-8?B?NkptbURRaHRlOEY3RVNkTEtqS3dSTEpGNWl4RS9VSWJweENQZmE1WmtTOHRC?=
 =?utf-8?B?UzJMMHFoN0xZc0EvY2lTeEJPUVhnejNaMWtLWHdmcGdEamk3eG11RVNXTzc2?=
 =?utf-8?B?SDZ3Yk1kZWVtUjhXVktHNjA5SEhKUWhLYVFJenJwaGRDbGxTdWxVUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 620eac85-c3b0-47db-c795-08df084922db
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 16:50:32.1847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kaT39AwKFE+Q+z24VQEf1GSlYnpkri4wxUE182HaZvQLNCNEJujnUiuehMknoLTGZnIMM2oqbCcgVnvK2Krb3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB7316

Currently registers work for all untyped I/O regions, which is not ideal.
It allows registers defined for device A to work for another device B and
there is no safeguarding at all.

Change this by requiring a base type for registers. `register!` can still
define registers on untyped `Region`s, although users would need to do so
explicitly and supply a concrete type.

This change makes it possible to use projection for relative registers;
relative registers can be implemented by defining new types for the I/O
subregions and just define registers for these subregion types like normal
registers.

This actually results in more ergnomic code for users of relative registers
(currently only nova-core), because non-array registers can be written to
with

    #[...]
    struct Subregion(...);

    register! {
        base: MyBase;
        SUBREGION: Subregion @ ...;
    }

    register! {
        base: Subregion;
        REG(u32) @ .. { .. }
    }

    let subregion = io_project!(bar, build: SUBREGION);
    subregion.read(REG)
    subregion.write_reg(reg)

instead of

    struct SubregionType;
    struct Subregion;
    impl RegisterBase<SubregionType> for Subregion {
        const BASE: usize = ...;
    }

    register! {
        REG(u32) @ Subregion + .. { .. }
    }

    bar.read(REG::of::<Subregion>())
    bar.write(WithBase::of::<Subregion>(), reg)

This also allows a lot more code sharing between I/O projection and
`register!` macro.

The expressiveness power of Rust declarative macros is becoming limiting,
so it is converted to a proc macro before new features being added to it.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
Changes in v4:
- Rebase on 7.3-rc1.
- Many typo fixes. (Alex)
- Tweaks to `transmute` and `AsRepr`. See changelogs inline in patches.
- Link to v3: https://patch.msgid.link/20260819-typed_register-v3-0-3699a75fadf1@garyguo.net

Changes in v3:
- Convert the `register!` macro to syn.
- Add check to ensure register and alias share the same base. (Alex)
- Split transmute functionalities to `kernel::mem`. (Alex)
- Remove some stray trait bound in nova code. (Alex)
- Link to v2: https://patch.msgid.link/20260805-typed_register-v2-0-c3ca142220a0@garyguo.net

Changes in v2:
- Extract type conversion from `register!` to `Io`
- Redesign the API to be centered around regsiter projections.
  * Support register projections in `io_project!`
  * Support adding register definition without defining bitfield
  * Subregions is thus unified with other registers.
- Store projected subregions in `Falcon` for nova.
- Link to v1: https://patch.msgid.link/20260721-typed_register-v1-0-452d72b60262@garyguo.net

---
Gary Guo (16):
      rust: io: register: reimplement as proc macro
      rust: mem: add `transmute` with deferred size check
      rust: mem: add `AsRepr` and `AsReprMut`
      rust: io: perform conversions using `AsRepr`
      rust: io: support register projections
      rust: io: register: allow explicit base type specification
      gpu: nova-core: specify base type for registers
      drm/tyr: specify base type for registers
      samples: rust: pci: specify base type for registers
      rust: io: register: make register have a typed base
      rust: io: register: support fixed offset register without bitfield
      gpu: nova-core: use projection for PFALCON and PFALCON2 registers
      gpu: nova-core: convert hshub0 from relative register to projection
      rust: io: register: remove relative registers
      rust: io: register: remove `Register` trait and cleanup macro
      rust: io: register: unify handling of register with/without bitfields

 MAINTAINERS                                        |   1 +
 drivers/gpu/drm/tyr/driver.rs                      |   1 +
 drivers/gpu/drm/tyr/fw.rs                          |   5 +-
 drivers/gpu/drm/tyr/regs.rs                        |  45 +-
 drivers/gpu/nova-core/driver.rs                    |   1 +
 drivers/gpu/nova-core/falcon.rs                    | 161 ++---
 drivers/gpu/nova-core/falcon/fsp.rs                |  63 +-
 drivers/gpu/nova-core/falcon/gsp.rs                |  51 +-
 drivers/gpu/nova-core/falcon/hal/ga102.rs          |  59 +-
 drivers/gpu/nova-core/falcon/hal/tu102.rs          |   9 +-
 drivers/gpu/nova-core/falcon/sec2.rs               |  37 +-
 drivers/gpu/nova-core/fb/hal/gb100.rs              |  59 +-
 drivers/gpu/nova-core/fb/regs.rs                   |  31 +-
 drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |  18 +-
 drivers/gpu/nova-core/gsp/hal/tu102.rs             |   7 +-
 drivers/gpu/nova-core/gsp/regs.rs                  |   9 +-
 drivers/gpu/nova-core/regs.rs                      | 115 ++--
 drivers/gpu/nova-core/vbios.rs                     |  11 +-
 rust/kernel/bitfield.rs                            |   9 +
 rust/kernel/device_id.rs                           |   3 +-
 rust/kernel/io.rs                                  | 181 +++--
 rust/kernel/io/register.rs                         | 759 +++++----------------
 rust/kernel/lib.rs                                 |   1 +
 rust/kernel/mem.rs                                 | 231 +++++++
 rust/kernel/sync/atomic.rs                         |   4 +-
 rust/macros/io/mod.rs                              |   3 +
 rust/macros/io/register.rs                         | 296 ++++++++
 rust/macros/lib.rs                                 |   9 +
 samples/rust/rust_driver_pci.rs                    |   4 +
 29 files changed, 1230 insertions(+), 953 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260721-typed_register-176eab3abee7

Best regards,
--  
Gary Guo <gary@garyguo.net>

