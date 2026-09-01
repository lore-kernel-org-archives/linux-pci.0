Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19012039.outbound.protection.outlook.com [52.103.23.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A3833F368;
	Tue,  1 Sep 2026 12:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788266156; cv=fail; b=rIwuv//aXWO9xxXPsUn3pAtHJVBvAcApsuO71D5sq1KZ5h6URyV0kWmfxL9oI9JOUQoSRiba4TvyVGBrmidR630pK2tbsFTawzbGsBqs//JJa8vnMsnqBYpUcIMBMLvxI1KTlPZZKIgFPz7eduMnzRBqJuIwXFJu83Gfmf2fiJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788266156; c=relaxed/simple;
	bh=x6EvZsWPOEKZMdTGfWbjrNJfgV/73ACNXKF/usWA//8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uYixj0iDinH0O2oOnROfKTuyw1qU6v+eFfhauP+LarhsHA5vyMV/7j9TvITNmXf8uDGPh48WhNONf2NiT6sEG7zsxtS3cw0ufOVjP9V8FTGcfh/l05PnBnqwlK8c3HpV1cYHjR0TqlpoM283O5lV4extNavgmH6flITFVxk6Lnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=sgSRYzkM; arc=fail smtp.client-ip=52.103.23.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="sgSRYzkM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hyq9KNk9PW151RJMcmdu+M7ut3lhtqlxnZm0tLD59Cd1Vf8oaVJEBAs8F6+ugAIcISfF7v14n7pFmmW9+5XfamwFkEMM2jtNt9OrLlr6bLCWxSrelBTYfmfA6JfE3gw1VQKpCaqjiVCWp/riOnB5p56fx+FASpdjgLwvXAREVIXUX1UxI2nK0r5w6ZZoaV6sPq2dSFC6XAeUZDsvCKPOu1Uuait7Tq1bIdBss6WbYb0kS+I5o52tPdxeprNi9XBiRwI7sIcl5eXHo4RCZQfFrD5P6jmQxmDyX4Uvs74AvEHNPHXrZMuVGNrVjpSjMXTiD6e5u3qqs06wmw9leBMXXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6EvZsWPOEKZMdTGfWbjrNJfgV/73ACNXKF/usWA//8=;
 b=VsunKnwZdeoELl8f1lZapzh/Gkepxyscdgy+h7G/EUZOs+Vqs0qNL47aJzU2/1O0RgyovClp9WkQlErljOT2gECG8rvlJJRny/5kqTfe25H43qaUFDt49wIp8/uJVq0k/q20IwKBpUkUPdkE12y/NDkDSxPdrwRMtNTZpL+zrMsNeXNtxKi5JxhQjRNNjbn4H3uow115QqRYki4k7m2Uw5wR9MjloQpI9KuNO/Hi3XSVOM0eNIIaKBwwM0xxOqLuh8YEBaVcVSXDaRE7BOEx+1qGWXC4knn8Dy9su0oY6zP94IMgzdjGHaHcGKqeDWQmhwlSnr0kEobR26qpntVudA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6EvZsWPOEKZMdTGfWbjrNJfgV/73ACNXKF/usWA//8=;
 b=sgSRYzkMkd4hXHa5nTBWym5vYR1dPywuhtzCBS2dL7OQH1jgSG6XwryIch88nGxkGIFrlrox2vEjdTNNRdIZZbUa8c7MHWqR9nETbV/Ux8rTKo8K4RjW+l6k1bMFx3pAJLxbfxF4YphlYlKPohRIJYDQGuFvIKfSWw9r595F4kYIHclUCqA7Ud/4zv3XdnoD3cCVTGDZ7rXmWhGfY1tXXUFZNxPxAzB3N4aelqMA2fEkVDnAn52y9+T1n0vLiT+P1Fb+NUAhrSTjNNoZ12UgsNp3i1n+mwQTv4aOpW/8lsrW6NgxfKzncwlzCLJsrxzgphITP4T/6yQx2+W/EVu5Xw==
Received: from SN7PR07MB9708.namprd07.prod.outlook.com (2603:10b6:806:32d::7)
 by BN8PR07MB6962.namprd07.prod.outlook.com (2603:10b6:408:d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 12:35:50 +0000
Received: from SN7PR07MB9708.namprd07.prod.outlook.com
 ([fe80::b852:966d:a1c6:78c]) by SN7PR07MB9708.namprd07.prod.outlook.com
 ([fe80::b852:966d:a1c6:78c%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 12:35:50 +0000
From: ai qubits <aiqubits@hotmail.com>
To: Gary Guo <gary@garyguo.net>, Sophon Zhang via B4 Relay
	<devnull+aiqubits.hotmail.com@kernel.org>
CC: Alexandre Courbot <acourbot@nvidia.com>, Danilo Krummrich
	<dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	=?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>, Miguel
 Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
	=?utf-8?B?QmrDtnJuIFJveSBCYXJvbg==?= <bjorn3_gh@protonmail.com>, Benno Lossin
	<lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl
	<aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Daniel Almeida
	<daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>,
	=?utf-8?B?T251ciDDlnprYW4=?= <work@onurozkan.dev>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject:
 =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRDSCB2NF0gcnVzdDogcGNpOiByZWplY3Qg?=
 =?utf-8?Q?IRQ_vector_indices_that_do_not_fit_in_u32?=
Thread-Topic:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjRdIHJ1c3Q6IHBjaTogcmVqZWN0IElSUSB2ZWN0?=
 =?utf-8?Q?or_indices_that_do_not_fit_in_u32?=
Thread-Index: AQHdOWxhfi2vd45HaEGtwvA0/upoIra5jr2AgAANj/mAAAWcAIAAB3Mr
Date: Tue, 1 Sep 2026 12:35:50 +0000
Message-ID:
 <SN7PR07MB97080BDF4ED89ADB6F43194ACFA82@SN7PR07MB9708.namprd07.prod.outlook.com>
References:
 <20260901-fix-pci-irq-vector-index-truncation-v4-1-f94aa6932fd9@hotmail.com>
 <DL3XDBBHXKKV.G9P6KRSSX1DN@nvidia.com>
 <SN7PR07MB9708B6C36F40362265511D2ECFA82@SN7PR07MB9708.namprd07.prod.outlook.com>
 <DL3YTUU7W86I.29BD41EC3XI9V@garyguo.net>
In-Reply-To: <DL3YTUU7W86I.29BD41EC3XI9V@garyguo.net>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR07MB9708:EE_|BN8PR07MB6962:EE_
x-ms-office365-filtering-correlation-id: c6e2fd19-0fa8-49f0-04fb-08df08258e33
x-ms-exchange-slblob-mailprops:
 P1EfU6pZOd/ur0QDa6YmBjuOVf78JKonG/KhJoU8FfTRcqmrFlr/c6kDWuyifJdeJ9DKPpJt3uZqhVMxWySKkWOw+hdqbW6xzGPtQS6vKYyjT/0rhqKGIUEOcHCAFzr+R8ipGVhScXyP1cC3VB//O87HN5MAkZGBjEcyiwGk3eagcnQx6mMtw4EGJ8cqvMFVEAOLTiMewhNoqFfF/u5h43HWOyZEUJ2d/CIfEqNxK+maoiANy2P8xwJdX7+dyjnZONCaximzUR9s7sALU3C09YPi/G4Rj09RLq7hV4jz9mhbu8hTRCAIAuuNCPaUhaQt0gmlKd9emGcLUy8Nhj54yeShKDenv/TGX4qPob/S/F52JHw+oUkT5ABdkT7WoObZW2NE9yaEs4jwv/kjyLUmxWcPvfsgmNwQcxeEwGBCRFCqqfNidKRhgJnNmokSL7SabynB53dopRmrPeZI6/gxXWHmOy1TkQ7glNkYG/L6Aw+4XYMEtuH6iiiQ1NHL9NlBVNnz2JO1oPwnQ7OQxqwblg1229K3kzB0m6HT0a2A5ogOzI9UIAbFOs13cYxObsWOmofCNWcXW3mTgWdS1HL7aOemwEz00Op5qEaGAkxPduKaAcGXa1TLr/DYlO97n3/WGr6KJhmDEmLKK0byyN1B5bTDs3XVHn5Je4yI9CVcKqek1rB+KF8vQOwqjU+GPPwlpJPz3vEPIyfS4j5+DpkUkrIkC6P6ANCnGH/eKsPIjRkKkt1G4ypBPGmRb4RWl4juejxH0mHsnHeTL01KtvLas5kMOEsQWmILcwrnbJJxKX5Buz0YebNRPg==
x-microsoft-antispam:
 BCL:0;ARA:14566002|6072599003|45011099003|24121999003|6140399003|22091999003|8062599012|8060799015|19110799012|15030799006|15080799012|7042599007|31061999003|51005399006|2604032031799003|4302099013|440099028|3412199025|102099032|1602099012|40105399003|3430499035|2607281247196008|26121999007|10035399007;
x-microsoft-antispam-message-info:
 =?utf-8?B?a1VuVW1HRVV0VjV6NDkrZnUrSTBBMnUxR1JRUWR3TVlwTms0WXJKdUkvOUsv?=
 =?utf-8?B?SXlITEw2YzZuSVFVczg3cUR2N2JpRWdEY2E0K0s3NGx5a1R2SExvZ3hIMEFn?=
 =?utf-8?B?YjVKWmM2RzEwVDFZS3ZxOEVNVkx4NzVQcW8yRTRxVEp5TitxZHhLUlRrRUlV?=
 =?utf-8?B?WlU5dVhxa1dkWkp3YXNoblIzZ2tDUXA0Wlk0UFJlbmxYSlE2NEt0bEEzUm5F?=
 =?utf-8?B?S0dnQVB4bHJIUnl2Z0Vxc0duUkJ2bTVDK2tJYmpveWpRRXJrVWhEV2tWSmZO?=
 =?utf-8?B?c3AwdDNVUHphSGFMcjl0cWhaajhKUlNqRlJIUmVKZ0p0RjVWbkhDMVFmcXYv?=
 =?utf-8?B?eDNOVVZHaXRHakNqMlI1MmljY0pDdmVmWWFvdUovMFFSOWphVXpHT2dwVHlH?=
 =?utf-8?B?ZlNvZ3ZpdjBpUkxPYSszWTBZeVlrRzZiaXlTakpvNGR1aG5wZjhCM1lrYXQ3?=
 =?utf-8?B?S2xCdkZoQm5QSjRNS0x5L3NacnZyYnBhOTYzalBqZWpoYUh0WVJCdmZpZzVX?=
 =?utf-8?B?eFg4YVFsdjNZZWxsZ0dCOHk2eHdPUVRpUWI5VzJHTjRFK1J5VFI4RzhaL25K?=
 =?utf-8?B?R2ZjZDU4WTh1NVdGMFVVSGJWeTVwT1NyRkFTTnJuMDBJUy9NVWFNejN5YStF?=
 =?utf-8?B?clRTazQ2bHIxQzZVYjRCUWg4TW9mVlNkSmc5bmpqM0Z4UU8yM1V0Z0czeFA2?=
 =?utf-8?B?RlorVSsvNFplbWRINFVPUFF2eXAwZGVqQWU0OTBiT0dBdWlCVmlVZFJOMitx?=
 =?utf-8?B?cHlhOTFtZDhpYWMzTllCUUdqazJOd29PTW1BaDUyeS96ZlNkVWRpamNYMXZ5?=
 =?utf-8?B?Y0hzL05ZTUo1a2tCZ3REbU5EVWc3ZU5ka0tjTERMOXA3WDQzcVRwTWxYMU1w?=
 =?utf-8?B?UmdwNTFiWjdzVTd0K1hnSDI5ZzZkb01CdjlSSDdlTWJ4WkhWanREdlRPU3ZF?=
 =?utf-8?B?bHg3cDFWeHRhZFhmQWUrVEUxVG1zVWJteW5XYmFOMVJjdjhNelBMZ0N4Skd4?=
 =?utf-8?B?Qll4NWRnY0dkcW1NWlNqQ083ZnQ5T2pjRlNRS1A0TWpnQmtWVjcwS0UvNEl1?=
 =?utf-8?B?bjR2eWtpVi83dUZhUUpXNkw4VXNuNXYxUUNacnBYV0JqZzNEcFRTRHoydHVz?=
 =?utf-8?B?dEQ0ZzRLbmF6dEUvUVUxdEozU0dxZi9JQk5XM2dvMDNCdXo1Q3pPaGJBN3dO?=
 =?utf-8?B?andrdEFWT1l0THFZU21IckdFNXhobVQvVXYvS1R2SlE4dEQxek9uY250ei96?=
 =?utf-8?B?QW04eFJtVmZRREgrV3JidlEzcTcrVTV6c0lxckZIQjFEV2JzdzhNV0RQeWdu?=
 =?utf-8?B?OHBUNk1yNE8xSVdUUlF6bm8wYXhKVkVFVmc0cVpRcGNXZUd2OFNTNGx1Tk51?=
 =?utf-8?B?Y2FsSGhzMjZEMUxRZlVva3ZhZElIbnhlYmVYaCtpN2txVnBwYlh0ZFVBVWxO?=
 =?utf-8?B?Mjh4aHo0ZDZ3ZWxXVXNCWVlWTkJXWThNa24zU1pLRjR6dmplU2ZYZmVCd042?=
 =?utf-8?B?cVJBcXhjalpTM3JQUENBdDYzUk1JbXYrZEhKMlRyWkIvMS95WElxS2g1SWc5?=
 =?utf-8?B?S0YzYkVvbWlOb0xXUVFSd0l5V1lsK0lMRVV4UnYxOWxqS0tJcjRmVGY3M3dE?=
 =?utf-8?B?MHNQQ0NzRUd6cm5nTFdQQWtoZ29sVmc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VlNoREJyb1R3NUdGMG1teGNyN0dQd0RYcFlBNDYybzlCb29KOXNWcUZhVlVH?=
 =?utf-8?B?cFhyU1U4WjVBMEpUUWtjOVRZZHFzRUxKSXBTZXl0YVFkSzVqQUxtS1JJN201?=
 =?utf-8?B?aVFSdnIwWGhrS3BCVzBIaFJyZnJmZER3SU1WNytzOVBneUZmTzM0YjB1d2ZI?=
 =?utf-8?B?RWs4NTE0WEVoTEJZUTh5VnJNb080bjdQamptZEJWTjFuTnluV1lpeGVIdDdM?=
 =?utf-8?B?YjEwRVRmM0ZIRGp3T3V0MWFaR0FKQi9abjlBcCtBYm9BU1hORFZPbnF3U3Z0?=
 =?utf-8?B?Z0VIeGxPT1grbmxSNVQwUXRvamFYYzZxdTlzWFZUU0FJdGtEMCtIRFZUUWdh?=
 =?utf-8?B?eWl1cGh4eHZLQkd6dXN4YXVUd1FqSThvY0kwSjJCOXkwWWpvU2FRR1JvTzd3?=
 =?utf-8?B?aXlpTHMxQUtiUi9JQWxkQVFEcS9GQ0c0YmFoMTRucE52M0IrUm5hLzZ0TTVU?=
 =?utf-8?B?M0UxMnFtUENpb3BPT0dOUkNZUG1WaGx2dFhmak1sd2JobGxLWlRBZnYrd0c2?=
 =?utf-8?B?a1pHMVZvYUlaa2JwRk5HaFlRclR5RFMvWHpmbzd2Szc1cTdOWjJWOElUTkRL?=
 =?utf-8?B?Sk5rYUFSSzNXeEJLWmVLakJMZUV5c3V6cElkcHpGK2p3K1VZWHBYNFUyUWtH?=
 =?utf-8?B?ZzBYZTJ2SGxNWHcyYStNb3ZxWWV3cHpHdEtTUzdLaUd3TlR1eVJXdXJSOHUr?=
 =?utf-8?B?alhsYkppK3I0NGRKZnozTmNjMmhSM25iREdOUVFrS1NOSHk0NmZZR1NLajZJ?=
 =?utf-8?B?MllpNEZ1V3hHOUJqT09NTzhoNjUrVENlTFJSbVdHeUs0czJYdnZnRmoxdjRO?=
 =?utf-8?B?OSt3cm9LdUhsR1JwWnlxb1BWQTA1eDY2NVRYcG9Zd1c0Tk9tc3JiSXZ5S01C?=
 =?utf-8?B?QkYrcGlHTE4xRWRkVGliTFMrQzhRWmJIUFJWU2RNclpmRWI5UUR4Z3daQWJi?=
 =?utf-8?B?d3RubGxEbVh5ZDRPc2t1RWl2WEFPTll6U0R3NFZ6K3BQUEc0L1dna1FnanJl?=
 =?utf-8?B?ZlBCTkZxQTVxZHVMTERscDErekYwazZaTU05aVc0aW1yWUJ5Mld5eGJCQks1?=
 =?utf-8?B?YlV6T29keVpRaGh6K1pYcnp6SFdDbEtMOUI4L0d2OTNSZStUL0tPRXUrcWNy?=
 =?utf-8?B?YTJHZUFiVlkrNkFseFZnNEdkUi9KOXBkSVBJTzNJY05ySGVnUHFDaVhUTytR?=
 =?utf-8?B?aXRRRlNpWXhZUnRSSTZZbnU5QktHR0lZQk52UEtyMkVua0VkMUV5eGE5azdI?=
 =?utf-8?B?TlZyeXE0cjVDUG1VaEpJSkVUWDhMUUFhK3R6bXBKNStCTUlMZEFKaXdQV2hT?=
 =?utf-8?B?MTYreUdzaGhiYkhNdGdZaUdtVTZIRDFoRHcxU3V5czkwK1hCbmhmeTVNY0ov?=
 =?utf-8?B?NmZxY1JwaTNCMXpxc2tjSitGMlNrZlJVMElLNlhTY0tFNlNST1RqQ0lLR1Fq?=
 =?utf-8?B?Tlo4M3ZxOHhEbFlRZ0h5Ym1OL0JydmdXNG8xQzJMZ05DK3FSSTdFSmVjMldr?=
 =?utf-8?B?UW5tUm01bm9RS2xlQ1RwbVUrRGdNZjR1cFBDd0VBZjB5L1g2YmF0Nll1VmdN?=
 =?utf-8?B?UUFXRFArRDlZdUhSdHp5MHVPNjlaT2NNTG9BY2psOHpLVGtMWGpOM1Z2RCsz?=
 =?utf-8?B?Njd5Rks0NDNhbHplWmQ3bFQ1b2JuV2VxQURWTGs2d1VnRWE4WWp1NGhSRlRP?=
 =?utf-8?B?T3E5ZisvazU0ckQzdFNIeUovcE1zZGZUdDFaMGR0SXh2SHVmbmw0ZTFsbHBK?=
 =?utf-8?B?aUN5RzBjeERkeklmYTBVWEY1L3ZhSk81N1NhVXo1NWFsaUU5SlNYd1NYanhQ?=
 =?utf-8?B?ODE1d2xFYlBMR3pGVVl1V2xuTkpFN0pIMHNrcnZKUXVpWm96SVVrRGozaXNP?=
 =?utf-8?B?QU1rSHpDK1NMWU9lay82dFVSa29XUit0ams5blF0ZnZsdUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-13ed7.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR07MB9708.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e2fd19-0fa8-49f0-04fb-08df08258e33
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 12:35:50.2260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR07MB6962

VGhhbmtzIGZvciBwb2ludGluZyB0aGlzIG91dCwgR2FyeS4gSSB3aWxsIG9wdGltaXplIHRoZXNl
IGVtYWlsIHJlc3BvbnNlcyBpbiBmdXR1cmUgZW1haWxzLg0KDQpCZXN0IHJlZ2FyZHMsDQpTb3Bo
b24NCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0K5Y+R5Lu25Lq6
OiBHYXJ5IEd1byA8Z2FyeUBnYXJ5Z3VvLm5ldD4NCuWPkemAgeaXtumXtDogMjAyNuW5tDnmnIgx
5pelIDIwOjA2DQrmlLbku7bkuro6IGFpIHF1Yml0czsgQWxleGFuZHJlIENvdXJib3Q7IFNvcGhv
biBaaGFuZyB2aWEgQjQgUmVsYXkNCuaKhOmAgTogRGFuaWxvIEtydW1tcmljaDsgQmpvcm4gSGVs
Z2FhczsgS3J6eXN6dG9mIFdpbGN6ecWEc2tpOyBNaWd1ZWwgT2plZGE7IEJvcXVuIEZlbmc7IEdh
cnkgR3VvOyBCasO2cm4gUm95IEJhcm9uOyBCZW5ubyBMb3NzaW47IEFuZHJlYXMgSGluZGJvcmc7
IEFsaWNlIFJ5aGw7IFRyZXZvciBHcm9zczsgRGFuaWVsIEFsbWVpZGE7IFRhbWlyIER1YmVyc3Rl
aW47IE9udXIgw5Z6a2FuOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBydXN0LWZvci1saW51
eEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCuS4u+mimDog
UmU6IOWbnuWkjTogW1BBVENIIHY0XSBydXN0OiBwY2k6IHJlamVjdCBJUlEgdmVjdG9yIGluZGlj
ZXMgdGhhdCBkbyBub3QgZml0IGluIHUzMg0KDQpPbiBUdWUgU2VwIDEsIDIwMjYgYXQgMTI6NDcg
UE0gQlNULCBhaSBxdWJpdHMgd3JvdGU6DQo+IFRoYW5rcyBmb3IgdGhlIHF1ZXN0aW9uLCBBbGV4
YW5kcmUsIGFuZCBmb3IgdGhlIGNsYXJpZmljYXRpb24sIERhbmlsby4NCj4g77u/DQo+IEkgYWdy
ZWUgdGhhdCB1c2l6ZSBpcyB0aGUgbW9yZSBhcHByb3ByaWF0ZSB0eXBlIGZvciBhbiBpbmRleC1v
cmllbnRlZA0KPiBSdXN0IEFQSS4gQ2FsbGVycyBhcmUgbGlrZWx5IHRvIG9idGFpbiBpbmRpY2Vz
IGZyb20gcmFuZ2VzLCBpdGVyYXRvcnMsIG9yDQo+IG90aGVyIFJ1c3QgaW5kZXhpbmcgb3BlcmF0
aW9ucywgd2hpY2ggbmF0dXJhbGx5IHVzZSB1c2l6ZS4NCj4g77u/DQo+IFRoZSB1bnNpZ25lZCBp
bnQgZXhwZWN0ZWQgYnkgcGNpX2lycV92ZWN0b3IoKSBpcyBhbiBpbXBsZW1lbnRhdGlvbiBkZXRh
aWwNCj4gb2YgdGhlIEMgaW50ZXJmYWNlLCBzbyB0aGUgbmVjZXNzYXJ5IHZhbGlkYXRpb24gYW5k
IGNvbnZlcnNpb24gc2hvdWxkDQo+IHJlbWFpbiBpbnNpZGUgdGhlIFJ1c3QgYWJzdHJhY3Rpb24g
cmF0aGVyIHRoYW4gYmVpbmcgZXhwb3NlZCB0byBjYWxsZXJzLg0KPiDvu78NCj4gSSB3aWxsIHRo
ZXJlZm9yZSBrZWVwIElycVZlY3RvclJlZ2lzdHJhdGlvbjo6aW5kZXgoKSBhY2NlcHRpbmcgdXNp
emUgYW5kDQo+IGhhbmRsZSB0aGUgQyBBUEkgYm91bmRhcnkgaW50ZXJuYWxseS4NCj4g77u/DQo+
IEJlc3QgcmVnYXJkcywNCj4gU29waG9uDQoNCkhpIFNvcGhvbiwNCg0KUGxlYXNlIGF2b2lkIHRv
cC1wb3N0aW5nLiBTZWUNCmh0dHBzOi8vc3Vic3BhY2Uua2VybmVsLm9yZy9ldGlxdWV0dGUuaHRt
bCNkby1ub3QtdG9wLXBvc3Qtd2hlbi1yZXBseWluZyAoYW5kDQpyZXN0IG9mIHRoYXQgcGFnZSwg
dG9vKS4NCg0KQWxzbywgeW91ciBlbWFpbCBjb250YWlucyBieXRlIG9yZGVyIG1hcmtzIChGRUZG
KS4gTm90IHN1cmUgd2hhdCBjbGllbnRzIGFyZSB5b3UNCnVzaW5nLCBidXQgcGxlYXNlIHBpY2sg
YSBwcm9wZXIgb25lIGZvciBwbGFpbiB0ZXh0IG1haWxzLg0KDQpUaGFua3MsDQpHYXJ5DQoNCg==
