Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011023.outbound.protection.outlook.com [52.101.62.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415E73CBE69
	for <linux-pci@vger.kernel.org>; Wed,  5 Aug 2026 17:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785950547; cv=fail; b=GpSDsF2k5TGcK9wT7cIISfFgl2l4TUJg0Dbke+5D6Es72YwVRgpnYRTntrKlUQo+IA6g3Z+uzJtJULzvS2QAaj1pGcaU78yi6iKRKyQgpMZgqKffVSrh5hgGxUmwgIrZKDz4ZXtYTEdZR828Niu3Gi0klGQ4U/3XijVSpYACJDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785950547; c=relaxed/simple;
	bh=5F9NqI+QDFTATve3hxXcm3ZXnVuhLl+mvxn0aiQI3Tk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b77V1gbGi9aD291TiG8oW4EtVpJ0J+yZzVsUgLDuTNfVYSY4n9HHQJncoiOH352qE3sMXoXVIunczoJjHkce9k/1NUsVT/a+UMmLnEQYiaIch88r9TM+Q6IqZv5gC0RA4IPoNxB59RuurvPDmq777qdn++DRAitzGWe7npgV1+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JqjtsTQ2; arc=fail smtp.client-ip=52.101.62.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JqjtsTQ2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Alsaql/rWoPCk9CmZDccxtx9kE3RrS8QAKpxjCcvW7hL2MCBThUmY2nDsRjmxXZqs8VFzbTatWRomUTnlrN8tK3QdVsjaaNFaOz5k7lvFbIVRMOTN07zPPSSkrSrVef2pg5Ab8fmpJqNVANbKoqDh0QeyY9IQzvV6pCFF7V2eGRtGQxAXrtoYCDS0nlPPM3CeNWYXeV9MSzoxJ6hKVIHnAobyYjUiRGapZNTHmxooPO3DrTpddUkxJlRjOfDs4fSM8uoCgnWAk46XzceGBfX3DS7RPRr4vg+m7hMMj7cNAvKfANvX2wheya0C3GLtawCwlKFxvupJnyA1JTp6Zr+yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5F9NqI+QDFTATve3hxXcm3ZXnVuhLl+mvxn0aiQI3Tk=;
 b=JjNgh6i86QDsIWaIjRBZfrwJ2QT0TC6cFXyGUEZhJwqN9OOmHIOYlS6O6Nmp/7UNqQ2RoFoQomrB6B/5Q0uSyWYusNJ6d80ruT7NXb7Wck7p/0syccSwMPky3AsAXoBvEeeqc8fyjqKDszK7IQ6UGxx79uE6nNXklOX/ZMu0QDeuWOAHrWCVbRS+KgjCA+QWiAhAmkUEMkbJp4SToUig4RK2KcFzKEr9ZV0DatBRqVMFpKbwEI+kUYegQc4t7O4WYcm9rFrpjLbxlLP7jmwcShUVk5P3XngqOnrRwnMcDV5vm9Tl94mh1KeTFlVzyJfBj029q3UIoJ94pQtTeBncKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5F9NqI+QDFTATve3hxXcm3ZXnVuhLl+mvxn0aiQI3Tk=;
 b=JqjtsTQ2yD1z9PVn3dNDLk6Td6+na0ppUYZCJ9KYQit4YLXf+9Bh1j57XqiorsYRdAZYa6AWV6DqbKPkLTl0RWcNg/qvp2sDvOUPOb0PpcxaH/MS1tPaZu+lSp3yKPhwMcJ5Iha3LCjL0rhDl4qIi72dMGrnFCrPF16oRUhVwRU=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by MN0PR12MB6030.namprd12.prod.outlook.com (2603:10b6:208:3ce::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 17:22:22 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%3]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 17:22:22 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Hegde, Vasant" <Vasant.Hegde@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC: "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Kuehling, Felix"
	<Felix.Kuehling@amd.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"joro@8bytes.org" <joro@8bytes.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "Suthikulpanit, Suravee"
	<Suravee.Suthikulpanit@amd.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"Longia, Amandeep Kaur" <AmandeepKaur.Longia@amd.com>
Subject: RE: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs only
Thread-Topic: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs
 only
Thread-Index:
 AQHdGmrXXVaTvXvBoEGo7Q2TpyKmibZ8ya8AgAP/o4CAAK8DAIAA7JgAgAAKzQCAAOUFgIAADS2AgAKVz4CACMDmAIAA4oQAgAAtKPA=
Date: Wed, 5 Aug 2026 17:22:22 +0000
Message-ID:
 <BN9PR12MB5146934D584CF0A2A9DD8CFCF7D32@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <20260723061548.10187-1-vasant.hegde@amd.com>
 <20260723061548.10187-3-vasant.hegde@amd.com> <amOBkJ4BaZ4qnkpc@ziepe.ca>
 <a2f38742-c8a1-4dd5-9fcb-120c1c989203@amd.com>
 <ed296c0d-246f-492b-970b-49c45e25f5f6@amd.com>
 <f4355034-d40a-4d11-ab98-eef0f2991f33@amd.com>
 <838281e9-8ee7-433a-b06c-68675e9b285f@amd.com>
 <2f400c7f-eada-45e3-9079-7b5727ecb5c3@amd.com>
 <bacdf160-8ab2-4bd6-aa9d-ab63b16527fa@amd.com>
 <08f2e48e-6e98-4fde-af71-cb8cde666bdf@amd.com>
 <20260805010706.GC28508@ziepe.ca>
 <39ce2a2f-3bb8-43e7-9446-a67551cce104@amd.com>
In-Reply-To: <39ce2a2f-3bb8-43e7-9446-a67551cce104@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-05T17:19:27.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|MN0PR12MB6030:EE_
x-ms-office365-filtering-correlation-id: bc2ecba4-793b-473c-6b51-08def3161c53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|56012099006|11063799006|5023799004|4143699003|38070700021|10067099003;
x-microsoft-antispam-message-info:
 bQDm9ztO7nlz//sIZkmCaCNj8JoP+BFM0zdoVzQHk/irn0BHwwKFGX+MgX0E1GHUI/jqiuLqsMufVdjiEdAlTFG9s1AF/tD8fsJh6fkFK6s5FwXHzBnpx1R2rrFwWMxQa7qR9EbEQfGD6hirrW+gDj5XOxOhy5WvpYEUSB+tzqd5sd8l6sRSKTzwhLWaNTAvvL7tfa3kIusuKEmlZGB7QXey3id7PBvxxCqQD2XYdubgbE0HFw+CMHxLmWLQRQuo62wGKJWG9IhQoU53F/AhJeBHr6/KcyO4MYei8mGOE6ZFB4dsmFxkB1ZlDbiUh/x1kuApNjrVqLC32uHc272YA0DXbtbhZ3v7qTHiCTWoygojOkkX/SCU/0IqloQ160egBmd/nM+OAn0HCq9Zxr9in+laTfD5VSKGuRRPvL+DkOkxFKP4UIeItVoxx64rm5Hlx+vLakUlOG+EoB5su9FJj6PJBX+ynzMZW44edAfN3CUiBui6ci5UXRqhXqXGbR7iVkdgGL3JUx0SAABLQYc8JleS1e7VSCpiqXAnsOzPNc2lN/p71dbNdD3BBFV/az++ypJdCKDE066w0RNNDnsrZIxiZsk3YQhgvlDFJZPsiwO8ZLrgywqjNe5vhiLQ1736dCNQudMug0pH9NrO2DkdMYHDq3Ipd6hq7kWBbrh7MO4LKMEdgMfz8sA5JKG+uRzOciPHunQCR4vOgzsEktvLwtPyVGX9I6PmZPICmodnn0E=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5146.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(5023799004)(4143699003)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NDNoNXdWcmp0QmNJVUhocHdvK2NOa3pQMEdEWDZWdjdrN2ZSUDU4WjlDeWN5?=
 =?utf-8?B?MlN5V2oram0vR0VsL3pjZ0ZJd29DcUhGQmdCL2lERGtYVVljK3lnNFVPdkpI?=
 =?utf-8?B?WEcwZyt4Q1JtOFFtVjl2SHRQKzltekJKQ2ZFNmlJU1BKU2srZFU4TEt0MzhL?=
 =?utf-8?B?eXIrZmthNy9PNzVTU1E4T2YrWlpYWEw3OUhLaFpkUEl5bU42Wlk3L2pUSk1x?=
 =?utf-8?B?SWsxOExTVnlQdmZpWlJXTGFyMnhZd0dDZGxOa1FIWCt2Y3BFd1QwMDBZVTg0?=
 =?utf-8?B?MGZKMGRSeUtmcW12bWdhc1lhSkFHeC9WbDRYVXBVYjR6WXlyS2lwaW9SK3d4?=
 =?utf-8?B?ZmFPajdlWkp2cjZOU3l0S2IzOGlGaHNmaGY5MUh4c3hDYml4WjNmK1EyYkx1?=
 =?utf-8?B?WXBLbHUwMEtKOTNidDk1OEV4SGgxRkRDQlRhR3krL2FPVUY0ZUxUSWc1czVy?=
 =?utf-8?B?bXdNeFdnQXpaa0FVbWIwdlpTQnE5WFowb3lBandOYytDakNOVTdjQ0VSNW9v?=
 =?utf-8?B?QTRYL254NUxjMWY5c1pnTGpPTzJpU1FwdWk4aFA2SSttRlZCc2krK3F6K3BD?=
 =?utf-8?B?Mk1FaW44Z0ZScWN2L21xVDF1ZHFEM05jRExUdGZZdkV5dFlwMDhDVkdkRzRp?=
 =?utf-8?B?TUpTU29JQm9ILzlMVS8rZHA2cjhmc0FCQzJrakRzZkxiWG5qTTRiUHFNc0VT?=
 =?utf-8?B?MlVkMzgyTTFWa21qM1AvSWJ0K1RjZk9xN1dlQzhjcVcySEVhUXN4YjE5alVl?=
 =?utf-8?B?SDRCblpxcDVuZ2NFUGVJTS9rd3B1M2lNL1dKc3BOSVcycVdZOHAzb1dCS0o3?=
 =?utf-8?B?MzlMV09USk83WTRlZ0pJYjVyRG9qb0I3RTdHclczek5od1ZGZlhpcGN4NGha?=
 =?utf-8?B?ajRXVlozY3ZSRHFqZ3gvVnhnUEhZeEJNeWRPZ2R4bjNpQTFoL2hCNlAwQ0do?=
 =?utf-8?B?YTBBTlI1SEx5b1kvbGllaCt5NU90N01CUVc1c2RRcjJGUDNKNllnQWJaeDly?=
 =?utf-8?B?aW9wM0R4bGRWNXRDWGQxeU9NRnJrTjZZaWpDMkp0VEFWRzRXWTVRQkVQYzky?=
 =?utf-8?B?MEZUOXluWWhWK3k5SS9VVkdGdFUybk9CbHZPZWc0QVhEeUh0aWpVSDh1T0I3?=
 =?utf-8?B?aElmR1krek5CT0FqS3JLcnhhaDY3RXNTNE9Ia3M5NWFlNmlad0tVZmNOOU1r?=
 =?utf-8?B?ejNETUhsaFJ2N09sODFIWFozelFWV1dWNTNxMzJiS3pJa3g1WEcvMy9WaTRo?=
 =?utf-8?B?Y3N6RG9jd3dVeEFOdFgrcGpSZUp0L2E4MmRudmtpVHVmdGNrUXJsU1BVZHpV?=
 =?utf-8?B?cGNUUmdaRTRNZi82NkhaVVBMSFdVKzN3LzZsSWxoMjNWNEU2cDJXNWhGaWJE?=
 =?utf-8?B?bDRwci91aGwvaTVWU3UrZWNPdnh1dWlWSDV0cXhyZ0plSlU0STE5YUMrNHpP?=
 =?utf-8?B?QzFFMGp6US9sQkwwRkNoNGdiM2h2R2RVckJoNGRLeTRuZWFabDJqZVpDSGRM?=
 =?utf-8?B?aTFjSlBGUlpiRU9XN1Y1Nkh6a0k1OW44ME50ODZmZWdXU1JJT1daSmdDbTFD?=
 =?utf-8?B?Qll3cnFjYXg0b1NzeXpHWkJ5T3B0Y2puM3FCQzc5K0R6RFpQNjBlZ1dGVnUy?=
 =?utf-8?B?cWVZc0hCV2RqR1NEV0xlUEpLNTFFM1VTQ1A2Sm5iT2tDZTN4a1ptTlB5RUhI?=
 =?utf-8?B?NkpYcS9IVWdwSEgyM21mbjViQk9aZmhkZDRrcEdGS2R6Q0hvc080MFRka1Nw?=
 =?utf-8?B?NFV4ek9zOXljWjBXQ3lDbDU1UVBkbFlFSDA5ckxsQWRNQlEwT1ZocjM3c0hF?=
 =?utf-8?B?U0JNVGg4YVR3azZXTFNCazdBSTFFeDZZN3ovOUFscU1zQTN0MGxnMWVTRG5j?=
 =?utf-8?B?SlhHajkvQkpJcTcxZDllQ3p3WERGYU5IMFk4MmhZUXlyRCt0dFZqWit4bWlB?=
 =?utf-8?B?WUwrM01SSEQzUWdYSVJkRE81TnJtam1qSGJOdlZtM2ZxUmZlRE4zQVJpL0Iv?=
 =?utf-8?B?U1VJNWNuY1lxdng1aFJTZDF2LzJRM3E5TWVQc2dKc1NSNWVNSy82U0tUeDg3?=
 =?utf-8?B?cFJSWVAyeG8zZlpROGNZaExmcnJUSzZ2V1NpQ1NOdWsxeGg4cFJSZ0dmUUxh?=
 =?utf-8?B?TzNsdTBHTCtuYnZWN09tME9ObDhuRkoxL2NCbnYzR0xBMFlCZlVGdXFLYUJO?=
 =?utf-8?B?eS9XSmw0K1hsaXJ0NnVzdlhCV2hONTVndkRzWVFJUE01cXNLbGhCTjFaZWEw?=
 =?utf-8?B?cE9CKzg4R1hOMytjZzVhZ0dSK0FHbDVvWmhKSEdlUTVxckpNcU5TcFJpNlI1?=
 =?utf-8?Q?LuEr966f17QxBNztb5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2ecba4-793b-473c-6b51-08def3161c53
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2026 17:22:22.2652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YOopCTli0JRCANhh8tErMxqluRSCeDZIN/FVOFdGnXYfFKuy0FP2kB0ZxLcM7MAWBTFjUgHTjmo7zfLYvYomtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6030

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIZWdk
ZSwgVmFzYW50IDxWYXNhbnQuSGVnZGVAYW1kLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBBdWd1
c3QgNSwgMjAyNiAxMDozOCBBTQ0KPiBUbzogSmFzb24gR3VudGhvcnBlIDxqZ2dAemllcGUuY2E+
DQo+IENjOiBMaW1vbmNpZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+OyBL
dWVobGluZywgRmVsaXgNCj4gPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4
YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBpb21tdUBsaXN0cy5saW51eC5k
ZXY7IGpvcm9AOGJ5dGVzLm9yZzsNCj4gbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgd2lsbEBr
ZXJuZWwub3JnOyByb2Jpbi5tdXJwaHlAYXJtLmNvbTsNCj4gU3V0aGlrdWxwYW5pdCwgU3VyYXZl
ZSA8U3VyYXZlZS5TdXRoaWt1bHBhbml0QGFtZC5jb20+Ow0KPiBiaGVsZ2Fhc0Bnb29nbGUuY29t
OyBMb25naWEsIEFtYW5kZWVwIEthdXINCj4gPEFtYW5kZWVwS2F1ci5Mb25naWFAYW1kLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIGlvbW11L2FtZDogRm9yY2UgaWRlbnRpdHkgbW9k
ZSBmb3Igc2VsZWN0ZWQgR1BVcw0KPiBvbmx5DQo+DQo+IEphc29uLA0KPg0KPg0KPiBPbiA4LzUv
MjAyNiA2OjM3IEFNLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+ID4gT24gVGh1LCBKdWwgMzAs
IDIwMjYgYXQgMDQ6NTY6MzdQTSArMDUzMCwgVmFzYW50IEhlZ2RlIHdyb3RlOg0KPiA+DQo+ID4+
IEJhc2VkIG9uIGRpc2N1c3Npb24gc28gZmFyIGluIHRoaXMgdGhyZWFkIGFuZCB0aGUgbGluayBN
YXJpbyBzaGFyZWQgZWFybGllcg0KPiBbMV06DQo+ID4+ICAgLSBXZSBzdGlsbCBuZWVkIGlkZW50
aXR5IG1hcHBpbmcgZm9yIEFQVXMuIEkgd2lsbCBmaW5lIHR1bmUgdGhlDQo+ID4+IHBhdGNoIGJh
c2VkIG9uIHRoZSBkaXNjdXNzaW9uIGluIHRoaXMgdGhyZWFkLg0KPiA+DQo+ID4gSU1ITyBpZiBj
ZXJ0YWluIEhXIGhhcyBicm9rZW4gc3VwcG9ydCBmb3IgUEFHSU5HIChlZyBiZWNhdXNlIGl0IGNh
bid0DQo+ID4gaGFuZGxlIHRoZSBpc29jaHJvbm91cyBuZWVkcykgdGhlbiBpdCBzaG91bGQgYmUg
cXVpcmtlZCBhbmQgYmxvY2tlZA0KPiA+IHByb3Blcmx5Lg0KPiA+DQo+ID4gSSB0aG91Z2h0IHRo
ZSBpc3N1ZSBoZXJlIHdhcyB0aGUgUEFTSUQgY2hlY2sgZm9yY2luZyBpZGVudGl0eSBhbmQNCj4g
PiBhY2NpZGVudGx5IGNhcHR1cmluZyB0aGVzZSByYXZlbiBjaGlwcyB0b28/IEl0IHNob3VsZCBq
dXN0IGJlIG1vdmVkDQo+ID4gb3V0IHRvIGEgbm9ybWFsIHF1aXJrLi4NCj4gPg0KPiA+PiAgIC0g
SXRzIGZpbmUgdG8gZHJvcCBTTlAgY2hlY2sNCj4gPj4gICAtIEkgYW0gc3RpbGwgbm90IHN1cmUg
aXRzIHNhZmUgdG8gZHJvcCBTTUUgY2hlY2sgKENDX0FUVFJfTUVNX0VOQ1JZUFQpDQo+ID4+ICAg
ICBCZWNhdXNlIGhlcmUgd2VyZSBhcmUgcHV0dGluZyBhbGwgQVBVcyBpbiBpZGVudGl0eSBtb2Rl
Lg0KPiA+PiAgICAgQ29tbWl0IGVhNjg1NzNkNDA4ZiBleHBsaWNpdGx5IGVycm9yIG91dCBmb3Ig
UkFWRU4gYW5kIHNvbWUgb2YNCj4gPj4gdGhlIG9sZGVyIEFQVSBwbGF0Zm9ybSBkaWRuJ3Qgc3Vw
cG9ydCBTTUUuIEJ1dCBub3Qgc3VyZSBhYm91dCBuZXdlcg0KPiBvbmVzLg0KPiA+DQo+ID4gVGhh
dCdzIHF1aXRlIGEgaGFja3kgY2hlY2sgdG8gbWFrZSBpbiB0aGF0IGNvbW1pdC4uDQo+ID4NCj4g
Pj4gU28gSSBhbSBpbmNsaW5lZCB0byBrZWVwIFNNRSBjaGVjayBmb3Igbm93LiBPbmNlIHRoaXMg
cGF0Y2gNCj4gPj4gc3RhYmlsaXplZCB3ZSBjYW4gcmV2aXNpdCB0aGUgU01FIGNoZWNrPw0KPiA+
DQo+ID4gVGhlIFNNRSBjaGVjayBtYWtlcyBubyBzZW5zZSBlaXRoZXIsIGJ1dCBpZiB5b3Ugd2Fu
dCB0byBzdGFnZSB0aGluZ3MNCj4gPiBJJ20gT0sgd2l0aCBpdC4NCj4NCj4gUmlnaHQuIEV2ZW50
dWFsbHkgaXQgc2hvdWxkIHJlbW92ZSBTTUUgYXMgd2VsbC4gQnV0IEkgYW0gY29uY2VybmVkIGFi
b3V0IGFueQ0KPiByZWdyZXNzaW9uLiBBbHNvIEkgZG9uJ3QgaGF2ZSBhbGwgdGhlc2UgZGV2aWNl
cyB0byB0ZXN0IGl0LiBIZW5jZSBmb3Igbm93IEkgd2lsbA0KPiBsaW1pdCB0byBBUFVzLCBrZWVw
IFNNRSBjaGVjayBhbmQgZHJvcCBTTlAgY2hlY2suIE9uY2UgaXQgc2V0dGxlLCB3ZSBjYW4gZ28N
Cj4gd2l0aCBuZXh0IHN0ZXAuDQoNCklJUkMsIHRoZXkgc3VwcG9ydGVkIFNNRSwgYnV0IGl0IHdh
c24ndCB1c2FibGUgZHVlIHRvIG90aGVyIGxpbWl0YXRpb25zIChlLmcuLCB0aGUgcmVxdWlyZW1l
bnQgZm9yIGlkZW50aXR5IG1hcHBpbmdzIGR1ZSB0byB0aGUgZGlzcGxheSBodyBidWcgYW5kIHRo
ZSBsYXRlbmN5IGltcGFjdCBvZiBlbmNyeXB0aW9uIGZvciBkaXNwbGF5cyBpbiBzeXN0ZW0gbWVt
b3J5KS4gIERvIHlvdSBjb3VsZCBlZmZlY3RpdmVseSBwaWNrIGVpdGhlciBTTUUgb3IgZGlzcGxh
eXMuDQoNCkFsZXgNCg0K
