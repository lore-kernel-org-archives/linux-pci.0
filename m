Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012047.outbound.protection.outlook.com [40.107.200.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F312375AB5
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 20:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785529196; cv=fail; b=lUAGD5okmTiv1VDh4iGITGrVDsp8cQPg9AEGv9iMU3F0f2K3k1aJajQ4csAqpZrvGEWsSHRJu8t0o8aclFlv+2684JbQgURTOC9B6A0EM6KxyBQEWyNh654PuSe3Ym1NjBmRi1HD0+c9VIKIsHLbeDhR7BlWmWddBDijtGCpWSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785529196; c=relaxed/simple;
	bh=Un8jHOhFQZ6EbTQansQ2ClG3fSw0F1eJbGUhSGMqeNg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xdx7WunbxDWMIVh6rKfVYyD9D6K1V1rcUnounYwgHf+m+oWzmVMiUHYBI/X4VLm9GNV40Ab2x2p6Ul4yc9DMgV3lxctcV96+UhIuS4n8pDTlpRxGhObuqx29bZ0xysa1gB7Ho/+VE5kT0J3eN06t4MwZL+1jcXsgNmppwK10V+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oLdI6+eM; arc=fail smtp.client-ip=40.107.200.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oLdI6+eM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lmFvx/ORorUnN00qAl0ELnpch+tXba2sb6kcCcrBXdEqFOhoVtR4xy4lUuHbWcOUQ9kwajpXoXqbDU+oQIDkv+oQYQQrBzSQkGC87cDJJc7ehSkFQdYHG5e6BBizBFgGDzx3GPSIzdGN4KVt9cKiOwm3Ue6MOhv3TDjSuMPIVyLOg21STIkR1kSotKAEyXabh+aVMXmAJyU6/Zkg9FqAkQjCxit17DEetG6zLes9d6GWLzfaqaAX+CXYEjs33aYtsUf0Bjd0YO9HzZaxPAyIJV3UbDxre62SxFzJpg+7ISijq7VgBmzefzHTgYiEN1uIJY9eApfsU+gqREk46B1WOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Un8jHOhFQZ6EbTQansQ2ClG3fSw0F1eJbGUhSGMqeNg=;
 b=DhUZg9qMbwN9xFdekENvXLG/3VfBC7r5NO4tOLQYP2XV+G48NsvDngPVzdF/saynh8apG1yZAtW/jrgBaUJzcDJhP2fZkK2Vx4WwizsqF7XROITRUcNxR7Hxdvmhbpt783KTDhEFTmXS7DAuLXeDFR6S3Z3r/xKpztqZwvfCn+SdHfD6OWXA6xCjZegUkRf6otn12nHjdUvHCIz1Ki46d4qAKLAZ6uplOEuKxwtWz4J6y0pI3LP1t5UQCrmHlxX1DCnlU84LjmdDDwMgfI+mJQy5XKU2inUkY+3SiXUTo/13EifFtvuAdHAEtSGl1vmN8enaFb56pg9AmwtIaczBhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Un8jHOhFQZ6EbTQansQ2ClG3fSw0F1eJbGUhSGMqeNg=;
 b=oLdI6+eMFRiC/dQveQSn1f939P4UcVybWyPM+q7rHeX3I2ti6JAzR/sy/Xpvl5iS5p5kzf9mow4NJUQ/yKQQxd1MY0hMNg2k+SVz3JSj+LvWEERIn5JX7EpXBLRPQHRUcdsyo7A9EM5PBe15liEgXgREdjMRQIjQrTbxATzmr7I=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by PH0PR12MB5678.namprd12.prod.outlook.com (2603:10b6:510:14e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Fri, 31 Jul
 2026 20:19:49 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%3]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 20:19:48 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Hegde, Vasant"
	<Vasant.Hegde@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Kuehling, Felix"
	<Felix.Kuehling@amd.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "joro@8bytes.org"
	<joro@8bytes.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "Suthikulpanit, Suravee"
	<Suravee.Suthikulpanit@amd.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"Longia, Amandeep Kaur" <AmandeepKaur.Longia@amd.com>
Subject: RE: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs only
Thread-Topic: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs
 only
Thread-Index:
 AQHdGmrXXVaTvXvBoEGo7Q2TpyKmibZ8ya8AgAP/o4CAAK8DAIAA7JgAgAAKzQCABayL0A==
Date: Fri, 31 Jul 2026 20:19:48 +0000
Message-ID:
 <BN9PR12MB514646ACCBDBD8F03A2401BCF7C82@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <20260723061548.10187-1-vasant.hegde@amd.com>
 <20260723061548.10187-3-vasant.hegde@amd.com> <amOBkJ4BaZ4qnkpc@ziepe.ca>
 <a2f38742-c8a1-4dd5-9fcb-120c1c989203@amd.com>
 <ed296c0d-246f-492b-970b-49c45e25f5f6@amd.com>
 <f4355034-d40a-4d11-ab98-eef0f2991f33@amd.com>
 <838281e9-8ee7-433a-b06c-68675e9b285f@amd.com>
In-Reply-To: <838281e9-8ee7-433a-b06c-68675e9b285f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-31T20:09:54.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|PH0PR12MB5678:EE_
x-ms-office365-filtering-correlation-id: c8bc575c-e04a-4e67-3a90-08deef411220
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 u53Wze8J2f3m/2BP7pxv6lkQIf+3OIG+gS/2ysLlARui5SnzLA1gk9b24YNReSJLMHTv4Cv7IWIRITq6S1wKRv8seUjcHFgyFF+93h/KIsUv2H0gpphVEVcuxP8MVuqkDHrI1Tl50tkx4j90V0t+JZ4t23CQfLbBZBrv/9glBZsD2ZDBuzLsNzKZZl9R70qVth/+A/9KeaYuDPCZZoNZAP/3VdxbY6H1jLI2Ym93g1OqkA6drdf3PFjBoJtvv/zB5h8yZ5G7YqTwiTbm3+Q8/T2nS54LK/RwJizPYMa4Sp5z6cIio1jZR+Ik/rplP3e703QvieO3rvX5rhK6/xWtKfsyjaxGlvWgabrx64CYctoJpfIzxllFC8Qwi4O+rM1+9Yd//FoT5Jt/JkVa/jGx2OcccaoKly/nbSlDNidhp81XvlS4Fk5Ey02pqzz2rkp7Z34Zgj++fqgp6WOSu7zVOkkZ2saU2H36L/9uNxFb7dejboBAXrTGChtBOLGUJ2QF7piMF8zlRggkZgTVUOXTcamGQHwxaH6lY5xHUHa15H/6BR+BkUfLQGHf/zaZhdvL18PMQfyEhsULgwixP7xI9qhjmvTtjGU6jFpA1ZKd/s4PbzsDOsZKPTBsYp6GSx5MbI92Q9oWTx/5NQka2FYgRkuTFRmgzhwSNe04PhPr8Cif/DtzPwSm7+Bhmdzz3S8I0QW/0zaqkoo6bOUFZX3+ep8pIOt25/j3i9oLC/rMJv4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5146.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q05xdGpUcXRaajFWc09BdFZNLzJzVmFsQkF3ajFKU2tPSTVtcXpxOVhVcWY2?=
 =?utf-8?B?alRhL04yKzd2bGw3WVV4VlkzL3RTa3BaNTBCR2VRbFRSNXFVUkxmM3B4SHpH?=
 =?utf-8?B?VVE4d3RiWFo0bWxRWG5nbm9pZHJ1N0Zmb1lnYmVoUm44emkrdmdlZ0F6RVk4?=
 =?utf-8?B?WTlzNDl6aWZHdW1IQkpUTUpIR2tKMHpiTjBhNVlmSi9BOXVtSEsrQzY4cDMy?=
 =?utf-8?B?R2RRN2N5aEtoNmxhNkVhZzdlN2JSNUNLRlBsYWpPb3l1UVJpbXhuQ2RpR2g0?=
 =?utf-8?B?YlozdzFCL0JsY2o2Sitabng0NkVkb3FkQ0dGY3NyL1p1dThPQ2Q3ZWN1TVlh?=
 =?utf-8?B?dXFkVVBWSGE1ZUhGVFJKSW94Sm1kT0VZU3FuMEZsVm1qbjY0RVpBYVJOMUtJ?=
 =?utf-8?B?Z3NabWo3SkRLcVQ0NFJHNHY4WXBPcVBuNVZtNGJCaXVkTVpWYVRkTEl0eElu?=
 =?utf-8?B?eVFNbzFBUW9RMHpocmo5THppaXZQZHNCL2pnRVFMT0hiQThVam9BREZ4Qyt5?=
 =?utf-8?B?Qkp5MUM2Z24yQ254NElRdW9QYkk4NmpuSkpQaGNTVkdmdlRPTFA4ckdDUGVw?=
 =?utf-8?B?alg0QklMR1p2ZGxRNlY0SEFxSUlzSjQwaXVmWVBGVksxd0ZsVi9SaDlVWlBt?=
 =?utf-8?B?K1dFaHhqS3lybzFzSGp4UkRQMmowVnlMOTk2eFl6ZlNUUEFxVkVSUnJPRjRn?=
 =?utf-8?B?cmlCY1pwVlhOMnZEYXNjQ3h6YUVjL3pwVkVNWktHWmtGeGtNWkY3ejkrbTdG?=
 =?utf-8?B?YmRBQU5mbEpXaitYa1FidzNwQk5QNWc1Zi9rSzNRZ2U5QXBkd2hXYmI0UmNE?=
 =?utf-8?B?b0lrSStFQ1BqTDFTNEJtSXZFQXhWTWh0emsyelJ6NjZibmlOWFd1Sk51YktV?=
 =?utf-8?B?ZWprRm1oY0ptOTVXWXp4TllCR0l2ZnNKNlI3dURhOW13MUF4elpSZmNsMlNJ?=
 =?utf-8?B?aUd5MEs1TTBXUkVvZVFMOStQUDdDUkIweGJYTTdHMFZsZU5WZE84bXIrZ0RZ?=
 =?utf-8?B?S3pNekoyODBueGlzbUVzNnBtUjZFMEJDMFNWTTFOczdGL2FlZEpyTEtMdDc5?=
 =?utf-8?B?NWF2dStaN1dTdi8wSFVpWmRlbmh5bWNaOVhma3JINkdlN09oTlZ6c2VBanpV?=
 =?utf-8?B?ek1TRjVJajlPNkhZb2duT28rYlB2b1M3a3lHWXZ1R3NjZTdBNTNtV0tNVHNx?=
 =?utf-8?B?NElXMSthZFhtTUhlNXdFOFl3NDdGYnM1MitPNUhhRXpMNFFKOXJMWU44Rmdv?=
 =?utf-8?B?VGt2TVgrL2NXQzVUNVJORlF6cE9qYnBoSTJYYjdtcDJLRm9aSkNUMXQ5UDRU?=
 =?utf-8?B?QUljVmZGUDFVRXRzSmVoWlVraUV6Sk9mcm9GQzd2emNCRVpQRWZveVZybE5Q?=
 =?utf-8?B?ODYvZjBHczd1bXVhSTgrOENENFdKSjJTSldrNXo1M2xqV0xwMDM3T05RcGU2?=
 =?utf-8?B?bW1PbFd1aGNwaWRxK1ZoamZ0eXZyM1NJTGdzUjdRZTBGTUNZd2hWdkh6ZEJR?=
 =?utf-8?B?UkRlMyt5bWNHaXNpTHYwQUg2VGMxMWU3QytybDZtVDIvcnA1Z3Nwd3RvNnhE?=
 =?utf-8?B?UEFxSjdGSm9HOTA2ckt3dS90NXRaOHlGQ1hCTzRLdTU1Y1crUHNEa0dUUW5H?=
 =?utf-8?B?QkZrK0ptaGdRcDBlbjI0enJDZURPVjA2TTdCeTFoSmI5b3pHVkRkeEpBcXgz?=
 =?utf-8?B?SU9rcnprWFloR0dCRy8yZXRYZXRPV3c5Sk8xM0VteUxtYXlBSnh3bDd4bjk4?=
 =?utf-8?B?c1AzdXNsUTE5clIvWTVkaUZFbENDbmh4YjF2NGVVQXhnNzRBbzNobEcxbmV3?=
 =?utf-8?B?UURZWktmTU05ZFd3dVVyTDBBcVRya3pwYXFKU2U0ZHFGQTNIVmNMOEJkRFhC?=
 =?utf-8?B?RkFOZEdraTF3L1dEVFJDakc1MHdrNmE0OTNhSkV2TTFmWEYwekMzbzA3dWtZ?=
 =?utf-8?B?QjFpVmVoYitOUm9oRFh4ckN3QlVldXBkUUpSdmhWVFVmVWlIYWlBRitVRG9u?=
 =?utf-8?B?MTFPRU9rNlRRL1dtcEsxTm9CeGljYXROdFVITlVFWTFhSkVqUW91cGl5Rzkr?=
 =?utf-8?B?YW1SMU9qajdINEhGMnZoeGQxMCtmOGhMVlBQTXNRaERwa2dzRkZqYTA2bmgw?=
 =?utf-8?B?bTBudHoxallkRTZiY3NrVTFzajF6MG9qbnNSRzZ6eE9wa0xzdldkVEdLZ2Iz?=
 =?utf-8?B?SmdaTWFHWWJMaCtmQTZrd2JWWHIxZ0pLR0JCUDJSUzFPNjRnWnBqWHFDSkFt?=
 =?utf-8?B?d0xya1Z4UE5nV3VZbEZ6Nkt3MXczdlQ1OUEzRHc4Y2lZVFp3Z1duVXd5dWRs?=
 =?utf-8?Q?WveH39XOuDg/UTA+8y?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c8bc575c-e04a-4e67-3a90-08deef411220
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2026 20:19:48.8683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 05i07LjSIZ8B1cedix0GpqPnpJ6Rqshb2FFsSUUfx1fyKdMXRotO+6bS8naAfy0kcz1f5vL7PlIC7iWfSybwAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5678

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW1v
bmNpZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+DQo+IFNlbnQ6IFR1ZXNk
YXksIEp1bHkgMjgsIDIwMjYgMTozMSBBTQ0KPiBUbzogSGVnZGUsIFZhc2FudCA8VmFzYW50Lkhl
Z2RlQGFtZC5jb20+OyBKYXNvbiBHdW50aG9ycGUNCj4gPGpnZ0B6aWVwZS5jYT47IERldWNoZXIs
IEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47DQo+IEt1ZWhsaW5nLCBGZWxp
eCA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NCj4gQ2M6IGlvbW11QGxpc3RzLmxpbnV4LmRldjsg
am9yb0A4Ynl0ZXMub3JnOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOw0KPiB3aWxsQGtlcm5l
bC5vcmc7IHJvYmluLm11cnBoeUBhcm0uY29tOyBTdXRoaWt1bHBhbml0LCBTdXJhdmVlDQo+IDxT
dXJhdmVlLlN1dGhpa3VscGFuaXRAYW1kLmNvbT47IGJoZWxnYWFzQGdvb2dsZS5jb207IExvbmdp
YSwNCj4gQW1hbmRlZXAgS2F1ciA8QW1hbmRlZXBLYXVyLkxvbmdpYUBhbWQuY29tPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIDIvMl0gaW9tbXUvYW1kOiBGb3JjZSBpZGVudGl0eSBtb2RlIGZvciBz
ZWxlY3RlZCBHUFVzDQo+IG9ubHkNCj4NCj4gK0ZlbGl4DQo+DQo+IE9uIDcvMjcvMjYgMjM6NTIs
IFZhc2FudCBIZWdkZSB3cm90ZToNCj4gPiBNYXJpbywNCj4gPg0KPiA+DQo+ID4gT24gNy8yNy8y
MDI2IDg6MTUgUE0sIE1hcmlvIExpbW9uY2llbGxvIHdyb3RlOg0KPiA+Pg0KPiA+Pg0KPiA+PiBP
biA3LzI2LzI2IDIzOjE5LCBWYXNhbnQgSGVnZGUgd3JvdGU6DQo+ID4+Pg0KPiA+Pj4NCj4gPg0K
PiA+IC4uLi8uLi4NCj4gPg0KPiA+Pj4+DQo+ID4+Pj4gSSB0aGluayB0aGlzIGNhbiBwcm9iYWJs
eSBiZSBkcm9wcGVkIG5vdz8gVGhlcmUgaXMgbm8gaW50ZXJzZWN0aW9uDQo+ID4+Pj4gb2YgdGhp
cyBvbGQgYnJva2VuIGVtYmVkZGVkIEdQVSBhbmQgYSBDUFUgdGhhdCBzdXBwb3J0cyBDQyByaWdo
dD8NCj4gPj4+DQo+ID4+Pg0KPiA+Pj4gSSBkaWQgY29uc2lkZXIgZHJvcHBpbmcgdGhlc2UgdHdv
IGNoZWNrcywgYnV0IEkgd2FzIG5vdCBlbnRpcmVseQ0KPiA+Pj4gc3VyZS4gU28gSSBrZXB0IGFz
IGlzIGZvciBub3cuIE9uY2UgdGhlc2Ugc2VyaWVzIHNldHRsZXMgYW5kIEkgY2FuDQo+ID4+PiBn
byB3aXRoIG5leHQgc3RlcCBvZiBkcm9wcGluZyB0aGVzZSB0d28gY2hlY2tzLg0KPiA+Pj4NCj4g
Pj4+IEBBbGV4LCBATWFyaW8sIEFueSBzdWdnZXN0aW9ucyA/DQo+ID4+Pg0KPiA+Pg0KPiA+PiBU
aGUgYmFja2dyb3VuZCBjb21lcyBmcm9tIHRoaXMgc2VyaWVzOg0KPiA+Pg0KPiA+PiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMDA4MjQxMDU0MTUuMjEwMDAtMS1qb3JvQDhieXRlcy5v
cmcvDQo+ID4NCj4gPg0KPiA+IFRoYW5rcyBmb3Igb2xkIGxpbmsuIFNvIGl0IGxvb2tzIGxpa2Ug
d2UgYXJlIGdvb2QgdG8gZHJvcCBTTUUgY2hlY2s/DQo+DQo+IFllYWggSSB0aGluayBzby4NCj4N
Cj4gPg0KPiA+IEFsc28gaXMgaXQgc2FmZSB0byBhc3N1bWUgU05QIGlzIG5vdCBlbmFibGVkIG9u
IHRoZXNlIHBsYXRmb3JtIGFuZA0KPiA+IGRyb3AgdGhhdCBjaGVjaz8gQW55d2F5IFNOUCByZXF1
aXJlbWVudCAod2hpY2ggZG9lc24ndCBzdXBwb3J0DQo+ID4gaWRlbnRpdHkgbWFwcGluZykgYW5k
IEFQVSByZXF1aXJlbWVudCAobmVlZHMgaWRlbnRpdHkgbWFwcGluZykgaXMNCj4gY29uZmxpY3Rp
bmcuDQo+ID4NCj4NCj4gVGhlIGN1cnJlbnQgcGxhdGZvcm1zIEkgdGhpbmsgdGhpcyBpcyBhIHNh
ZmUgYXNzdW1wdGlvbi4NCj4NCj4gRmVsaXgsDQo+DQo+IENhbiB3ZSByZXZpc2l0IHRoZSByZXF1
aXJlbWVudCBvZiBpZGVudGl0eSBtYXBwaW5nIGZvciBBUFU/ICBEb2VzIGl0IHN0aWxsIGhvbGQN
Cj4gd2l0aCB0aGUgY3VycmVudCBoYXJkd2FyZSBhbmQgc29mdHdhcmU/DQo+DQo+IEknbSB3b25k
ZXJpbmcgaWYgd2UgY2FuIGp1c3QgYXBwbHkgaXQgdG8gUmF2ZW4gYW5kIGxvb3NlbiB1cCBlbHNl
d2hlcmUgYW5kDQo+IHdoYXQgZ2l2ZXMgaWYgd2UgZG8gdGhhdC4NCg0KDQpUaGlzIGlzc3VlIG9u
bHkgYXBwbGllcyB0byB0aGUgZWFybHkgcmF2ZW4vcGljYXNzbyBmYW1pbGllcy4gIFRoZSBkaXNw
bGF5IGhhcmR3YXJlIGhhZCBzb21lIGhhcmR3YXJlIGFkZHJlc3NpbmcgYnVnIHdpdGggSU9WQXMg
c28gaXQgaGFzIHRvIGhhdmUgSU9WQSA9IElPUEEuICBUaGUgcmVzdCBvZiB0aGUgR1BVIGNhbiBo
YW5kbGUgSU9WQXMganVzdCBmaW5lLiBUaGlzIHdhcyBmaXhlZCBvbiBSZW5vaXIgSUlSQy4NCg0K
QWxleA0KDQo=
