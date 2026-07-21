Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020086.outbound.protection.outlook.com [52.101.196.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF0C37998C;
	Tue, 21 Jul 2026 16:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784652882; cv=fail; b=B+Fa46dt2lnCyLlUPi5wJqbGWwp/92yMuthKUu5fWB5hJY6T0Wb5WUEokdceZvMPaTyZyGWnYVB7l+lpyWK4ppWH/sBlg2LQG8emoc7haI2cld1SmNrXgwUZeaGCOWoDXN1Rf7zZPYLUudabH1LXFsXyjg/qAg/x7ngcAUhjpnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784652882; c=relaxed/simple;
	bh=81woT9Stg2V3Kwz7AzOidLEkxtzbQKcnzQ0qE7/zKjA=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=PsqKf65cFYrFjCM8dWLh2zaN7BB3p5uVApXbjXnB+DSKvlr/Sbr59gyv0yKbXNDdtpX+Remz2jiXX1WkcORFE6ZDXUCyvN+2ZYLDHlhEXyp5RRjsazJMTM34nyFY4fimOIxWvaHqLZDbJBFhjMUmL90VYqN5V2dzgQN5zyZwpqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=DWqO3095; arc=fail smtp.client-ip=52.101.196.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="DWqO3095"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOCYUYKtWmTbQKH3A1bWO34FMqiO54mAnmPcBtL1pC+8TAo1V9V0mIP9fzgLFhktWtN9Jtr/3N1WBFtVWc+rj1FdqvemXADv668xec/SNUHfoNgVcJOVAhIUVBDsaPPVDqWHvCo75scCL6oiShcdQJ9bvh3eGenbmwHU6sSE7ROYcaqvaOHLIDkzJEyqpdRJHxHlQMvZAhTNkmBYbYmSnX3Qgw2KINonfhnglhL58nM+n+SJXQgh2bT1elQAZvgwXVFjb9ykduHrHIOdQLf0YOslqklkU52x2OzYvOOscFMn4IDk2EiHJL26R9zR1rwH53Xmh8QAyM1wtNkGVKoFTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Udh30nJyfVdDRcA8x22dsFA0LrJX/vlsLOSQb2G98+s=;
 b=I3HoeQwYyxVVFvhjK80No158HJlW5hxBJgh8nknwKK3+LdmnZUE8oMRCl8LosEvO19F8magLBjyViqHtsIRYcSV+6aaZY9DQwfVEGc33oEM/lVivNbFydHbBC2MhjcbxZoUiEabUaHtklLQVrx2SNvnbhfSD8OoK8kFLthaWRxIfJ/DLueVwh+bCV0VptfxC1asP6FApchUsy+D35MIavLJqgiMc5VYXemrqjjPkkS2ZTVli+/i33DmDL2w1S7F/wxrgi/pVYf/awHyQb0L+KPr0tRbqAtiWMSU2LO3Jx+a8n9qXnxxVXsq60ihHEb5iJ+OuiwjudMNqVO4J3nsUYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Udh30nJyfVdDRcA8x22dsFA0LrJX/vlsLOSQb2G98+s=;
 b=DWqO30953tq0adh5TWryvX5jrejjdHq+3hxwBW2GTm9zMAQo+T6LqHqjuh5sE4ceLQMKfyAeJEp2u0kv4aKjVDeTr6L0Vg4vegKdkB2tD6ig1rdlSuPppMxpP+XSpa7LkYWpqaReByDOFm3QfN89o0Q+ShymdAcGyCjD8khtIBM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO8P265MB7878.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 16:54:33 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 16:54:33 +0000
From: Gary Guo <gary@garyguo.net>
Subject: [PATCH 00/10] rust: io: make register bases typed and remove
 relative registers
Date: Tue, 21 Jul 2026 17:54:24 +0100
Message-Id: <20260721-typed_register-v1-0-452d72b60262@garyguo.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAECkX2oC/yWMUQrCMBAFr1L222AToQGvIiJJ+mxXNJZsWiqld
 zfRz3m8mY0EiSF0bjZKWFj4HQvoQ0NhdHGA4r4wmdZ0rTVa5c+E/pYwsGQkpW0H50/OA5aKNCX
 cef0FL9c/y+wfCLlW6sM7gfLJxTDW6clxXlXEmo8vV5O071/wBQvKlgAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784652872; l=2980;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=81woT9Stg2V3Kwz7AzOidLEkxtzbQKcnzQ0qE7/zKjA=;
 b=GXr1sBBswoUByIIUCGHPpyoFYhz6kqlBHVdR286rptZFzGnAnE8Lo16wDWNFcghsNeOHSxoHZ
 VKoCOE9crg3AjU1qPRQWPjJjbUz8XraOXkoMvXlsNf9SEzhowqUvGjD
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0143.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::22) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO8P265MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 779854e9-952b-4b56-3e81-08dee748bd2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|10070799003|1800799024|366016|56012099006|10067099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	CKLM3R46LUtd8/xyoD7S/aQkEh9zHNyf167aATC4FXxh7slaoFJIkyBa1SVsH1kp32IoduMXSQZ5ZvylIyxpX99pzNC/vMisHUQWFWYbnEv1Ih76RqL8bKZaC7q108JTNcP9Gpb7ljlBZttisfGSFBkYuTVHkMzP4p0LVO02TNrAMjw8c+H9uvUqH5/IdCq+XHuH5loqR2Zbn3IMG5Ywbm3y+mqDablGLLny5WogPNQr6ZsiOsflbzK4+68BzDjtTLvjQVoJ/A5smmI/WcUX6NxdwR60/NozOPYmHaI/Lwr1NCCFjiziiRoOioGxFU0eWowkNjGy/am4zAqieIV4T69kTZ00VpZ5GfP5bNgNJginUFPnTJpyc8+slOyPsUXBwAul36zabturD0GJb6sHKCR/0faX6L1+WZW4sKBPkFX9U/9F6Q6PSXCD8fsCT5lfEp48mUqUnIOXa7AlirdtSo8OTK26WKvPD8hlr3bj91yyo2PYgHFyr3RoIdrXP/G8i9re6Er+d5Ld//oOEFTyGTqxuTWPLBbI+GghJBQLr46tWhhyMGNDC7BPuRWi7Rh7EJqjZXAp1nGuzBCX/jUcaIOyww3SPz/9Yi5/+tXWmx3nXLoTH8L3q536V/+2pvg2DKV5gBhbkMmo2jB9q13szyvlE87YiZzzyAMwarP/CN53LAUVrDD4aDnIDND7o62QQb9BaTjW7DGG5v6ais8DIQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(10070799003)(1800799024)(366016)(56012099006)(10067099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2dJUVRrc1E1NUFKVDNFakdoWUpPUW94ektyTEwvbWd0Z0dGODlUdlY4ODVm?=
 =?utf-8?B?NDlRTDU4cFBHSFZ3dmF1djhLdEUwNG5TTWl5TVFOOUc1dGNJZkhqVGttbUc0?=
 =?utf-8?B?ZVA1NlU2MVhjazFta0UrckxiQlFsTk5QR0FyaFN1elZVUi9JOUY3NkJPNFFS?=
 =?utf-8?B?Q1JkbjVOUDF6ai9makFYb0tldm13MzRqWkFDV0plMXFyM09IQnVYcG9KaHBE?=
 =?utf-8?B?UWI2eGhxUW4rMDFqbmZUaEdOQ0NyTm4wZUJEdmNwSUV5dkZlMEhneFh5d0tp?=
 =?utf-8?B?NGU0WnkxUWdDeGRsWHhpejFpUnlvUjFqd0lEcGlNazRZN1dlREw2UlhCZkl4?=
 =?utf-8?B?UGNFWFlHaE9Ja1IvTWVNZnhvdW1oSkhLZmppdHltZ0t4NE40KytIekNVR2xh?=
 =?utf-8?B?THF5aTBUNHUxUHNyZ0NRc3NhdWhQUXdTUjh2NUhSeVMrU3RwbXJHUzk3b0RE?=
 =?utf-8?B?RXZCbytBZDBoRjkxQkdJZllIK1NGZjdqNFVmSzE4M2tpQ1pqUkxXUVQ2RllV?=
 =?utf-8?B?bXd6UWFUWEJXTU0vOVF1bDN2NUYvNHB4NEpMWnVtNDFWcjJQWDVMODFKSzcw?=
 =?utf-8?B?bE5pSjd2QlkwSDU1MnJadWlDNml0SG5pMHBXd0ZRQXJTWThRRDFIODVSQTd6?=
 =?utf-8?B?ckg4MEFUdEVVSVJEaHVyV01XQ0dleG8zNzRHN3dZWWlPdndCZ0ZyR3JjbFBB?=
 =?utf-8?B?V2ZISGd6RHdHUFdydWNjZ2tNbm1US1NqK1hnTkkya1UwbkJJUHI3VlcvVmxR?=
 =?utf-8?B?Y2tyd1cvaWtGVGRBclc3cjE2a3hYaUJiZS9heTZSenh4ZXlsVWlKVkJxaEtM?=
 =?utf-8?B?T2lyUjR2OWhCc0Z1c2lDbUx0eFU0cVJNL1FOeXIxYWRxaGNOQ0xsbzBxeWk0?=
 =?utf-8?B?UitraFAxMmFiNG1PV0VkSGh2Tmp0TjVFMnVyQ0NYd2RDc0FYUjUveU1ucGM4?=
 =?utf-8?B?dzRYSjcvUjBBbGswQ0xPOXFQWi9NbXV2VTR4ZDdtWkZEK3JXOXBUUkNzNERr?=
 =?utf-8?B?dnpPR3ZxeURsSjBXSjZrSVB2ayswNGZ2YVJKbE5BZGVxaWk0bXhEaFFyeVp1?=
 =?utf-8?B?TFpaa1V2TVFwRUVsMXk3NzlSOXhvUHNJQS9UK0gzNDlrSG4xbWxISmE1eEFa?=
 =?utf-8?B?by9LY0F1eDJtVjZONUFVZ0Z3TWVNZ1RaRkNtLzdzWDh5cXltNVRlTzJhMUVY?=
 =?utf-8?B?WXYwdlVkY2dGRGtrSFdnTlRORmZPQ2VnZE9maEJKM1N2WENjeWppa0NWRGIx?=
 =?utf-8?B?czk0cTkvNHlYRFVrUHRaeTZRR3Y1bElUdXVNVlJUblQrSkJWQ3NRNnMxbTBk?=
 =?utf-8?B?RlJwdEU0TElPeTkwcWZCL2pnSnlVazhaVlFOaWNjRU1UNlhISkhFWUNZUUhU?=
 =?utf-8?B?TldtdTloTEcreVV3WXhuMEtwUDJuUHp3SDlMWENWUDc4bFYzVkhiZytXcHp4?=
 =?utf-8?B?UnBXa3lZbVQ3alBSS2dLNXUyTnNaMXBlRVU1M04rNVp5Y1dmRWhvbGgrVG1M?=
 =?utf-8?B?VVZhN0hkQlhoQS9UQnR2NTdHZ0JKMi9ob2Q1aXU2VnRBc05aclh1Z0laNkQy?=
 =?utf-8?B?c0g3TnVvZG5STUIvWW5uTHI2eUJ4ZVNXakM1RWN0NFpwMElQbmM4VU5IeUNQ?=
 =?utf-8?B?UmpJYmYrN2d6dW5IODhkbjBEWG9IN29Md3hhMHlXVHMrNnJLNUZ6VzBnc3NT?=
 =?utf-8?B?YUVZRGJGeXRKQ1lHWFQxRmZGRTB6ckVYT3B3L1lsT0xmWG9IS0Q5cjA0NHp3?=
 =?utf-8?B?M3pnUzY5dnVjSzNHNVB5VlI1SWlQQ0NVRDB0WmVYMFBwQVNLVys0TUlCWEdq?=
 =?utf-8?B?Sys0TUM5Zlk3QlozOHBBTjNadlZRWmsvZUowZnBWeHhMdWhLSDA0ZUhmQlMz?=
 =?utf-8?B?eWNEWWwzaFNvTjRkVTYwd0NOc3VIS2h1dE16ajlobEp1ZUlIUUJiRTVhU2xB?=
 =?utf-8?B?VnBHajJ3TXIzdWU5bit0aXlhZnYwSThmQUhYdmhZWVRyM1BTMGorbW13cDZy?=
 =?utf-8?B?UVlGeXJOV3ZGd2FwZGhBQ0trTjdyS014ZVBROEhyQXdsN0Q1S1VSV3ZBVXo1?=
 =?utf-8?B?a3BvdGVIMnU0bUN6TmRMc2VRTS8vcHovY3ZhTnRzSjAyYUVURWNpQjZlcGFy?=
 =?utf-8?B?ckZMc3NLdjdJNGJaZ0JvdXU3bjZpWVl1aCt1cHRaTWVMbzdsZDJOSThrNHJ4?=
 =?utf-8?B?VXNobHJOeWNtN1ZDM0hRbDdFZXl1YjRRMTZFNjFCb21PZm44Rlo0RTZ5YS80?=
 =?utf-8?B?Z2l0YTRnaDFsU0QxQUtadElybE1CS3kybndiN3k1Smh4aDMvRW0yZ2N6VlhY?=
 =?utf-8?B?Tm9UOXNodC9PTzYwcG5hd3BUbW9vaitFVnZ2eHBxL1puczRXa3kyUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 779854e9-952b-4b56-3e81-08dee748bd2e
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 16:54:33.1922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GCoHCEKj3bK9MdFS9sHJxRRHy0ukWyueDOuef350Bq3F2Ey+gufqQDkSRl469KN0RXUHYFGY6OY2jDLUQP1Bvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7878

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

    subregion_proj(bar).read(REG)
    subregion_proj(bar).write_reg(reg)

instead of

    bar.read(REG::of::<Subregion>())
    bar.write(WithBase::of::<Subregion>(), reg)

Signed-off-by: Gary Guo <gary@garyguo.net>
---
Gary Guo (10):
      rust: io: register: allow explicit base type specification
      gpu: nova-core: specify base type for registers
      drm/tyr: specify base type for registers
      samples: rust: pci: specify base type for registers
      rust: io: register: make register have a typed base
      rust: io: add static `cast()` method for views
      rust: io: add subregion method with compile-time check
      gpu: nova-core: use projection for PFALCON and PFALCON2 registers
      gpu: nova-core: convert hshub0 from relative register to projection
      rust: io: register: remove relative registers

 drivers/gpu/drm/tyr/driver.rs                      |   1 +
 drivers/gpu/drm/tyr/regs.rs                        |  42 ++
 drivers/gpu/nova-core/driver.rs                    |   1 +
 drivers/gpu/nova-core/falcon.rs                    | 158 +++---
 drivers/gpu/nova-core/falcon/fsp.rs                |  53 +-
 drivers/gpu/nova-core/falcon/gsp.rs                |  43 +-
 drivers/gpu/nova-core/falcon/hal/ga102.rs          |  39 +-
 drivers/gpu/nova-core/falcon/hal/tu102.rs          |   8 +-
 drivers/gpu/nova-core/falcon/sec2.rs               |  32 +-
 drivers/gpu/nova-core/fb/hal/gb100.rs              |  51 +-
 drivers/gpu/nova-core/fb/regs.rs                   |   4 +
 drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |  11 +-
 drivers/gpu/nova-core/gsp/regs.rs                  |   4 +
 drivers/gpu/nova-core/regs.rs                      | 134 +++--
 drivers/gpu/nova-core/vbios.rs                     |  11 +-
 rust/kernel/io.rs                                  |  67 +++
 rust/kernel/io/register.rs                         | 539 +++------------------
 samples/rust/rust_driver_pci.rs                    |   4 +
 18 files changed, 461 insertions(+), 741 deletions(-)
---
base-commit: 3fe08b9796f36ef437ab9328e7dd1e5ff2d66603
change-id: 20260721-typed_register-176eab3abee7

Best regards,
--  
Gary Guo <gary@garyguo.net>

