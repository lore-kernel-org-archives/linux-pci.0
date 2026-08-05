Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021089.outbound.protection.outlook.com [52.101.100.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D0D3F3276;
	Wed,  5 Aug 2026 16:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785947831; cv=fail; b=Z2FEC+hMXYGlJbGoWXUR6wUp6TzsuU9SUIXIz8l6pPySd2FRDTwItm/xg8vN5DsB/kfrODXW/QymuoxLl7/euRP+2Z0gzHyEHBFLQ5KASjOI3/3jf8I/E/8XaeYhKKOrjpCOXG0mWJzUXklDUm7NRabNAmbpEhLUqJ9MqYChRRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785947831; c=relaxed/simple;
	bh=3HJQu9UUIdolXjh7kkotdQzQZQ68FkOlMtc5pwzM4Lw=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=tOTh3n4ERizd/O5HH8X3sR13kgjtqJLXnh0MJ3SK+kSFjY40ZNfcApJoUfDm0oyaGvKmFGcv2rti2SeiCClBNQzcZ1rLsrn/rjidCdL04nghaPcNIg3Hi77IhW8ncyjv+YZa/w7CjqQ5ervyzRfAy2Hpw7c7lbKRPerQZXsqMOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=aBsmtcky; arc=fail smtp.client-ip=52.101.100.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="aBsmtcky"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MMmwYpD1EwKjdx9PgJNzDUtiVgZ7TLKiA2+cZmk5+rFyW1oFOOc4VS9aJGMfDl5KtvaFfpNXf1gW6cSH9PcraQe75nB26a+6BqP+Oby8+4Ox5FrPjNJyKCvEDnT2hxmpa9PinHCHIv1QW2cuj6bEBqGAN/al+u4+D28TaKnfar/FyA3lpBMmUeOCEs2Gjnc6PAzYjND2nrCk89aHzHXlkjuYWIEtDd150Ln3/5YMhfPL4kVf2TRZFVKLZEJXt/TjXNpYppWyKTx8lwWMb54UsYjQahTCG6XuGDQEFO1XOGpHQBU1FYkJzmDtarD8kVBJWkbvf9CFa87LtZDllMLYCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dT27UE7HNt9LB6agZz+RPKnSvDJ9eil1+z3HDip4fc8=;
 b=GV4pS2D2PmJhKwGxT653whV3eFZzsSLxb3XR1U11czTmAX//t0TVepmkKPKWZcH6iBINTAaICW3wsa7WS0x8nLu9tRx60tvcIOuZMkG2VH6yCL/Lyhz4No3qhedMRAdS8XNPs38dZelJ4nTfh7QK+eC4WbexEqj58S+B8DQwVjD//l1ztogumYc2qVuW7EgxVHLIcQOUMbqojwl/hPm8yz+/a6aFAZYB3A9/gRli1vBoPeZ8S8JoThQHIXTLpnnJQ/wCZBUUsEJHjEGiKbz2/tprZ3VR9cCIkZRKZZXxxbbY+Epd33hkU4GKs2j+l79thgIAzbmEQ7oH47o1O5YOJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dT27UE7HNt9LB6agZz+RPKnSvDJ9eil1+z3HDip4fc8=;
 b=aBsmtcky0pE00MFj28iL+QqIBRB67qYQdd60WZMLr0jLBzJdTxw61RzFLHdyEs38Ah8qZ+XkjHv9AuLNJvZViq78ObnDgT2gE1xYdDvMQS8rNTqhzUKCESjF3/pYGUG60s2UnUs/06zveaYx1phJTUZZkpGaOSF2iGFNl9TKsNE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b4::24)
 by LO2P265MB5822.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:26c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 16:36:59 +0000
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a]) by LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 16:36:59 +0000
From: Gary Guo <gary@garyguo.net>
Subject: [PATCH v2 00/16] rust: io: support register projections and remove
 relative registers
Date: Wed, 05 Aug 2026 17:35:43 +0100
Message-Id: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF9mc2oC/3WOwQ6CMBAFf8X0bJVWpYkn/8MQ08Kz1Ggh20Igh
 H+3xbPH2cxO3sICyCGw625hhNEF1/kEcr9jdau9BXdNYiYLWRZKCh7nHs2DYF2IIC5UCW1O2gC
 Kpaee8HTTFrxXPw6DeaGOuZINowO4Ie3rNp/ezg8T95ji8aNzMjttinc0b6tGkVt/B4yCF/x8k
 Y2SpkyOvFlNsx26g0dk1bquXzw/wJjkAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785947818; l=4482;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=3HJQu9UUIdolXjh7kkotdQzQZQ68FkOlMtc5pwzM4Lw=;
 b=CUZPMFXOxtQVqw0y3Y2sPgK5ZiCtYsV864NGpigc0xF+Q2/qB2c5imAaz9DVsmy5q75PEjPYB
 h0VMggobRDqBDxmuADnm9TMw7tENE1/Nsnu1O7U/ORmSb+joyJd5eml
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
X-MS-TrafficTypeDiagnostic: LOZP265MB8551:EE_|LO2P265MB5822:EE_
X-MS-Office365-Filtering-Correlation-Id: fd6fd99f-8259-4eaf-eb18-08def30fc55d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|1800799024|376014|23010399003|366016|18002099003|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	cuJo6XUVTZ2f1LXZ+uaOJ201d3cz/6/ml6u3t6OfrQzy7iOF1seOovA0iFpVJEHGCW0V5KX5kD91+/eVQ7pgkmsSO+KmR6ZjBLOR6a84xxjt4aWYfHqupc4eypEWzHdmDaxRH/sD+sguTDVdtTF4MNKNc98nZ+itcfFL6v8kYtOcmn3+KjiNcryAMC2l3BPg5uyPXZEa8vTw64HsI7Y6ajs0l8Mha+CwwjN+KrltibvnhBSUVX6WSQx+h++bYF6RmyHy6qy05A/BPPF9xCC6cgyJqe3w2krMAm3bIagAs6kx5EzxDVi8Brk/UmPOjT5SrilC+N/sy5M6hfSZaYA5B/NZVad4KGkz7crSl52IfoRcxHIijFgSixrJm07j6fKQJxbT6QQgqkx//4sKopbeWWnluxXQf39opYpnsyn5h4jqGqsb5iiFf2qshRNdeJ2L0Z3EqDC4ad8SAal8vIF4lq0KV3agGhNWeftn90arEK6WW0xeWfSUg2uMajP9SFK7l2W+6pF0kngD3Fqel/xVLoCCkh5J9CiXqls5UVUvlPDNED/EbdBorcbEA0Q/3d594z6/P0ZnAHsTGHgfz37ez68f4lLqw/isLo2asM8eABpTA4CIKvhnCP2BQc8eh3Yy1QWGGGoggkqhZs9OpJiKf/ECPgwGCYAynRUGPOYkV8P3opgmcTP4iPFm2YJdny2xEOVNpBDVjtTPprNrkbqv2w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(1800799024)(376014)(23010399003)(366016)(18002099003)(56012099006)(10067099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFgrQ3BoZzBoazNWMjZPZGkwV3AzOW5NVytlMWh4d0w1OEpJVWk2aUVhQ0FU?=
 =?utf-8?B?Szl6b21ZRlFhYVpzTGRraFVwNWxQUDFYZGZlY2RyblZ4eEpONFJHZ1FLV0po?=
 =?utf-8?B?VkE4OHZ1WDc5aVFRY3g5anU3cDNvUlRBWCtJU1ZKZnRoc3hFay8rampwOXBZ?=
 =?utf-8?B?b1U0MVJZY0hjMkdTRWh0bzM3aWNkd1E3dGIyclFQa2hFcThHaWh1alVzS0JO?=
 =?utf-8?B?dzVHQy83YzVJVnc3TkJJb1lyMEJmK0NmT3ZHUUs2WFNMZ0pLckF3TnBjc0tW?=
 =?utf-8?B?Z0gxM2sxQVNjTlNiMkpoSm4wbmY5Nmo4cFJZNDJ3YW5lc245QW12em15NTNo?=
 =?utf-8?B?RW04VUVIRU81aEF1YVFKOVB0NTBPc2RkTllVbFp5cFpXd2FnQTNZUXM4UkhV?=
 =?utf-8?B?MmozNnNjdEZtMDkrWlU2TVZZWGJoMk1ka0UrRGkxNnQ5cDNjYkQwUUp6WlBt?=
 =?utf-8?B?a3pDS2lwcTczR1VCeXNPUVBSeE1wOXgrV01rV3pSd0VibUxTQkEzZk85NWZv?=
 =?utf-8?B?ZUJCeW9tWHFkWGVXUVdCUXlKYmRraUQ3OWVBQVNaZ0s1QkdCbkhvMUlvYWRQ?=
 =?utf-8?B?TVh4THZYRTlzaVdSNHFMSVlqT3VFVVR6NDZ2cW5kbEdKejdxS1oxKzhKcHVL?=
 =?utf-8?B?QXIweTQzSDY3OGM3TVVaczJ6azNUbmV4blhBTnVBY3QyRFpYUHlxT21sLzhT?=
 =?utf-8?B?M3BiNTBkNHZvamhkM215b1g1OVcrMWRDbVlxZXg5eWx2clBLVEdvV2JtVTR2?=
 =?utf-8?B?SWJwZDZmYWh4dFRZSUZKcWVoeHg3cU5NWlFJK2VNNHBnSU5xMWV1RlEvNng4?=
 =?utf-8?B?ay9vL1dWUGxTRkJTenRLUVRvNWZBcmRLclhnVGRwd2NmL0xWNzJ6d2dheDdq?=
 =?utf-8?B?d0s1eGx0aVdBNU4rcWxwd29wcUhPQi9tTWQ3R1pEdXV1RkxvMXNiWkNES3dH?=
 =?utf-8?B?YlZOb2JoZzRCblRseHVmOUl6RHBzcWhKdHhmUWk1MjlFT2N0ZW90ajZYOTEr?=
 =?utf-8?B?ZC9vN2lvamZsclpOVklReEZVbFkwb3FXT0V1SU5zb3RPUjVYQldENldJc2Nl?=
 =?utf-8?B?em5Scm9oVHk1eFNMTStXQ210dXN5NFM4OW5lK0ZpWGJObmlmS0dNUk56MlhH?=
 =?utf-8?B?WEVLVUFFZUo4eW1vNTZEZkVuMEpxOWxBeFJhNko3YW5ac1hLNURlOTZTZjM3?=
 =?utf-8?B?QVVGTTVqU1YvY2NOdmNDSU1uMFZ0WHhYM3IybndlWEgwMWFFd1JzWVJubnBH?=
 =?utf-8?B?ZHpLNG84SFh5WDRocmd6eGJhcmdXWHdZZjRzSnZBK0JRYWRLUTJRUmdUN3RW?=
 =?utf-8?B?OWV6OGR2ZUlyNHFZaXpNRmQrcVBUamVXdzBFWEQwbUpUdlpqZFJCb2ZoYkNi?=
 =?utf-8?B?VW5TbCtMVEtqOXp4MUVEcW1EcXh3alFuYlZPeTNZWDZEaG0vL2hIRUhkck0z?=
 =?utf-8?B?UDFHbm80NENIU1JCS0RJTGhpb2JHakwzem41enp3TFVKUnFiNDI1NG45RVZH?=
 =?utf-8?B?Y3JFRU53ak9sd2liNFpwcng0OUg0ZVZnKzIzWVk0ekwrczZ3UzVJWVR0NkVI?=
 =?utf-8?B?UlRxWkJIZkpVM0Y3SUZkbU9CVDNmUmkxd2NCa3hhdTN6QXJFYkg0QTU3UThV?=
 =?utf-8?B?N0lZNEhkMlZRYnp3WTR0UmZYOTlPNno1ZkJNZitDbmdlQThxWG85dTZEOCta?=
 =?utf-8?B?RlFwR2w4d3RnUk1qdTcxQ2Yxd29jQnR0bC9qUUdwR3pMaWRoMlhjSXRpOGNO?=
 =?utf-8?B?dmQ2Q0tsbHpPWEdKVWNHU1VyRGJyOVpvT3phY1liS1A4cXRhWW1DYXpvbis5?=
 =?utf-8?B?TElaSFBQblZ0ZWwwTEtIOGZER3BwYWpUTmgveVdjOW51KytOL1J1c0RCNUI0?=
 =?utf-8?B?L2p5N1plKzNPbFBHYUEvcTJuR3pPMzhTKy9lMkJPUktQcDZCbmVJNHZuSmth?=
 =?utf-8?B?M0xFZ3JqaFQ4MGlFM2VFZGRidlkrZGE1V3pHdXlqU1d1OGc1cFVxSUJ6YTc0?=
 =?utf-8?B?MHJWUWpwTWlNZ01RU3d1UW13SG9BcTZvODN3aHRqN2Q0Tnk3VnN5OGRlVzk0?=
 =?utf-8?B?SVVkY1ozaXZCTmR2ZjlvaFZqdHZ6TklCeGlzOHNvODZRbVhFTG9EREhpUGxR?=
 =?utf-8?B?aUZGWjk5Ti81WXhQS0lLUkpzblVETkpsS1hKOFBETTN0czZIcFhyQjlPUnZV?=
 =?utf-8?B?ODgyTUlBWUMzU0k5R3BOVUdUMVdwNkZKaGF3TGFZYXJRaE5HV1g3STBqWlZr?=
 =?utf-8?B?ZlpzMStiNU5EYmQzQ1h2UXVjNVZvTFg3WTVGVWZ6YWd5czBMYk0rL0VsOCsr?=
 =?utf-8?B?RWdzaDE4aGo3NlJiRFBoVHgwbmZHVEp6NzFmMWd6ZmhDYk9JemFHdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: fd6fd99f-8259-4eaf-eb18-08def30fc55d
X-MS-Exchange-CrossTenant-AuthSource: LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 16:36:59.5744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UFcIx+rhiMS4ex6OUCsBcdV2WdVCRmwHi7sWGULeLvzCD83Z15dWc4h6wX23vk5PJXnt2Flz5Meh18XMUsQ7yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5822

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

Signed-off-by: Gary Guo <gary@garyguo.net>
---
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
      rust: io: add static `cast()` method for views
      rust: io: add `IoRepr` trait
      rust: io: support register projections
      rust: io: register: handle one register at a time
      rust: io: register extract offset computation to helper rules
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

 drivers/gpu/drm/tyr/driver.rs                      |   1 +
 drivers/gpu/drm/tyr/regs.rs                        |  43 +-
 drivers/gpu/nova-core/driver.rs                    |   1 +
 drivers/gpu/nova-core/falcon.rs                    | 157 ++---
 drivers/gpu/nova-core/falcon/fsp.rs                |  63 +-
 drivers/gpu/nova-core/falcon/gsp.rs                |  51 +-
 drivers/gpu/nova-core/falcon/hal/ga102.rs          |  62 +-
 drivers/gpu/nova-core/falcon/hal/tu102.rs          |   9 +-
 drivers/gpu/nova-core/falcon/sec2.rs               |  37 +-
 drivers/gpu/nova-core/fb/hal/gb100.rs              |  59 +-
 drivers/gpu/nova-core/fb/regs.rs                   |  29 +-
 drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |  18 +-
 drivers/gpu/nova-core/gsp/hal/tu102.rs             |   7 +-
 drivers/gpu/nova-core/gsp/regs.rs                  |   9 +-
 drivers/gpu/nova-core/regs.rs                      | 114 +--
 drivers/gpu/nova-core/vbios.rs                     |  11 +-
 rust/kernel/bitfield.rs                            |   5 +
 rust/kernel/io.rs                                  | 295 ++++++--
 rust/kernel/io/register.rs                         | 774 ++++++---------------
 samples/rust/rust_driver_pci.rs                    |   4 +
 20 files changed, 828 insertions(+), 921 deletions(-)
---
base-commit: 1701fda2f58e345c050f4309971bdc07cd6146ba
change-id: 20260721-typed_register-176eab3abee7

Best regards,
--  
Gary Guo <gary@garyguo.net>

