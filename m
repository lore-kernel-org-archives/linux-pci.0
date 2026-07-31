Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010035.outbound.protection.outlook.com [52.101.85.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2571377AAB
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 20:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785529400; cv=fail; b=pnw4tKhLyGv0N0MT1LQg4dFHdtrVqzWt5fLrEF5BkkuY7kBVt4obyBeGqDqj/WJfRefctV9WBPNNanNvbNxH43mKjmStA7uuqBNkutjnDX1xsGl6ylxiBCoB+C1HmXX4Ht/cupuQ73t3rWig/7sGB3oH5LXZmH+HJE0NyYZ+D2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785529400; c=relaxed/simple;
	bh=OSNZUy3R0xMxXv6yjzegWKbB3piQadvPUjBFEAn4X6I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qu/31B8LB1jrCinnTZwVHfo7K8RZoPVasAKUqVp7FicdpU7ObzSBoTwefyHxjO4HsclRdGwD9MQpe4G+X1PzVeK0zdzAXCxexkrtKeOcOcpuMOMEWrG63rUG+AUsMZUaZszSEMy6vGeieepnG2Zy58U/LgmlKziGAsiX3ZFbmPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qphfNIQ4; arc=fail smtp.client-ip=52.101.85.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qphfNIQ4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GW5tiSabW6ojCNiqXuZmgwTMhJxFZq2eEy3w+fdeSCk46UeHmhuSKIEJD/JFouLFnNU23vdyQnkynhzFD/nqTkltg4Vi/sjt+ITR9ipseXRFJbFO209lR+DjL8X173cCQI5awZQ8/4M8OYKuvzLR7NybBFHoiSBKeELGf5Acq74ZKGoqrQ3g4WJOWTk6eivLvbW/j2gQe0InckfIKsJwl6gcDnaIpX7LBG6Y6kR8Lp2a3PXKTFz08pJzs6PS8v+Tn2YQpovkZKS8jyI0qDzwXahHujmsAbQxHxvpgfkhLj+fWJJTSqc84Ld7GuD1G/Tcob7aSBbflI2Z8JpBoQ2oqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSNZUy3R0xMxXv6yjzegWKbB3piQadvPUjBFEAn4X6I=;
 b=VlxPcdKROrIJaISIrofj6RIQjZu45I8FMZnyPmMfD2nmuztaQ/DSCn3POClBC4MsUEr1ebvFgQEDoJdrJXWShQDxjK705n3/EOrqAFLM3kU0wzIWkqmG9X+CHd8UqneL65E8jJHQl4kKp467SMg3gL7WD/b4pKFA/bwa1Fd2rW/3HGp1070tT3c7rU6dP3ZhfqlfMEj/DNEVI0IyREgC7XG1XRVW1zek16yhqibu0B1trP0iykueioA3CV1q8kZrfXaQGDzvQjztOVqnPQeeg7nxF6cN0sRTeqlmxuNsP4hvUFcAPawN1pyRb1lmvLovvm5yrI0HgLDMjB70VEvYfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSNZUy3R0xMxXv6yjzegWKbB3piQadvPUjBFEAn4X6I=;
 b=qphfNIQ4NDX8SdMNE2HUA1XPaKu75xxgDS8yVXKtOYfUOsjtvLEMQN4d9pEO0EY/+pGf5mN6cDB9wWIqGhBGEVHKpcwsi/APbxlzIO5OjH6MAF2blKNH+KF9Df5r5a86FHTh2EV9SIXLyEhQd9wPv+W9VmOJb9rNeBbStbftprE=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by PH0PR12MB5678.namprd12.prod.outlook.com (2603:10b6:510:14e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Fri, 31 Jul
 2026 20:23:15 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%3]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 20:23:14 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Kuehling, Felix"
	<Felix.Kuehling@amd.com>, "Hegde, Vasant" <Vasant.Hegde@amd.com>, Jason
 Gunthorpe <jgg@ziepe.ca>
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
 AQHdGmrXXVaTvXvBoEGo7Q2TpyKmibZ8ya8AgAP/o4CAAK8DAIAA7JgAgAAKzQCAAOUFgIAADS2AgAS9avA=
Date: Fri, 31 Jul 2026 20:23:14 +0000
Message-ID:
 <BN9PR12MB51464567463FE49B084AD57CF7C82@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <20260723061548.10187-1-vasant.hegde@amd.com>
 <20260723061548.10187-3-vasant.hegde@amd.com> <amOBkJ4BaZ4qnkpc@ziepe.ca>
 <a2f38742-c8a1-4dd5-9fcb-120c1c989203@amd.com>
 <ed296c0d-246f-492b-970b-49c45e25f5f6@amd.com>
 <f4355034-d40a-4d11-ab98-eef0f2991f33@amd.com>
 <838281e9-8ee7-433a-b06c-68675e9b285f@amd.com>
 <2f400c7f-eada-45e3-9079-7b5727ecb5c3@amd.com>
 <bacdf160-8ab2-4bd6-aa9d-ab63b16527fa@amd.com>
In-Reply-To: <bacdf160-8ab2-4bd6-aa9d-ab63b16527fa@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-07-31T20:21:00.0000000Z;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD
 Public
 v26;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|PH0PR12MB5678:EE_
x-ms-office365-filtering-correlation-id: 6f70711b-5d09-42af-1a3d-08deef418ce4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|5023799004|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|10063799003|38070700021;
x-microsoft-antispam-message-info:
 4ZCMUzSrrHCPUhYonBQLPJt4dve/bqAn2+MlX2DMknJuBrK8O2nsPzBMQQV77LC5lJP+XCFevg0Es+fI1m9Fe8B+jXEiaJRt54AOnbkB7PJeQMx9XhiVvjaMBRTzJkGjuWThmY600dRkXNhe9qzeEeuW9UezuU6cOdkvbxk94c1VofU6dXIXlO9AxUJ+7tHnyAlTtKaRdqvcJJIOqURssL35KfOisuMVQPm2R5Oj3ZQhuc/1V/1bJ7gf8staylcNmpSFzPaXQgqdQftQiASXiC3BxLJwH3SOn4SMUxOc8b5oDrgpRCDA5y9X12oOCgttVKxTcBGWd2PC7V3Z3wGXW9zqH4sb2Kv1HpvXaJ71xJmosX++5ZlgeywfSwrr4E/jgdEsKJy9rdYeeZu2seBsHZwaSe7rCk8WaVe9jGs4GXBJXdjnYsPYXvvMYXEIStEyE9R7zV4MESGDvBi4u++/6rseE97MCLH+cdR+LLqAGMohjhJk9oNaDJY5zsdjjmWD1VEl9lN/kHVTWSu5bRSmt6PfEGMGGQceM0nI3yqM8jN7ekztfU5QsDPeT+DyYVJl8juiOmDBugiItMf5qtktdmYA7S+D7SVdsVnzOuDNRWyJQncTw2VnRCsVZOJcnXS266uNWgIcUQd35Ch0hwlBMpElFptK9OGf3QS7hllaqrGUhBeVk1UBo66X/9jXksfvgdfmuCM8ThKkHntsKsEti4bVcvh/LCSy6oJSYetsdLk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5146.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(5023799004)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(10063799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eDNSMG53TkFlMVhFei9ZUE1NUjdRN3hzMWRGQjBPYlM5d0ZyUnB3VFc3MkJY?=
 =?utf-8?B?b0EyejV0ZDVwMDFVeURhZExiSlJtVUhlSUxSU1NkYnNBV1YzYThWa0xUV1BO?=
 =?utf-8?B?NGd4MGVScTByUkZxQ0JLc3RDVmtYeFBYblJPMmwyUmVSZzI1TkZiUklla0ZK?=
 =?utf-8?B?eXdYKzN0cklDb1hsb01SN1pleEpkdHphczE1emVQMGE5QVRDdmordithakxU?=
 =?utf-8?B?MlJJaVFZeEhteUVQcTFQaGlyRDYzVlBYZFBoR3ZwQWt1dGF3Ui9NRUQrZlZy?=
 =?utf-8?B?QUg5K0hROGYxNjM3TnZpaGtIb2dKTXJSczFZbkxXS0J0OXNMVXhleDJmL0Jr?=
 =?utf-8?B?alluWFoxTHp0UXFiSEhSeUtrVlNPWkVmUGY3WWZNYzhSY1UzTEdTYytBdlEw?=
 =?utf-8?B?VFA0MERiVlJzMHlkcHJsR01sZmptWFNBL1lFY1R5aE1VdVVRVzEyS3pLL0I2?=
 =?utf-8?B?aWR2NGNMMCt2eVg1UDFlbFFRbWc0ZWNFNDQ1dzlkWmxGN0JWbmZiVHhXa2R2?=
 =?utf-8?B?ZVA3OXQydGtGL2pwd2lweU1wcVJPbC9ScVRpVzFGOHJ6L2tQQkdUVGlqZkFW?=
 =?utf-8?B?VmJiUk9kYzljTlhENTd0MU9vcXBhajVJVHErTzQ0endJY2hpR1lPMGpFT1FU?=
 =?utf-8?B?WHJZNmZJWFJPT0s4ZEI1S3VVeHg2R0o5bUlrQ3RMU25NT0p3V2hWVE9TWVFK?=
 =?utf-8?B?anJXRWhURGNiY29Kdjh5Z1pURXdhM0NzalkzZVd1TU9mekZhMjJOdHNpSjl1?=
 =?utf-8?B?cUFMSFg4MlNVUFdMMXBDK3MxaWFxc0RvMWZDRzZKeWJ1cEpRNjZza29MS0VI?=
 =?utf-8?B?cmsvZVlVR0xQcjF6djBsRkFrMTJNQkR1VlI0ZWRQSHErcFc5dmFCNlBXcmRi?=
 =?utf-8?B?RjcvbFNyYzZDUVJ4bTk4R09iN2dGRlFEeDJyMzZwWTRqZFZVZVkvcnR6dndH?=
 =?utf-8?B?Y3V4UEFMa2wwaFVZQnR1UTdyV3JGa2QrTkdkRWp2bFpzaFlkdXc5SW9Nbk1U?=
 =?utf-8?B?SWtzNkdoQjgxZlJtR253OU5iWnplYmdFUURtZytaOU9zKzRPTmdEVC83SlRw?=
 =?utf-8?B?UjJpS01pRG5Ec3l1M3BhU0JadDg1ZTFHQ25nTFZzL1lpbFp6VVl5SUZsTHVN?=
 =?utf-8?B?dENMWWpGWU0yeUs1TXRLcXhmQkJzbVVzK2c3SHB2YjVmZmN3ZDZKV1BGZXVS?=
 =?utf-8?B?QWVSWXZrK3B2QTltOVltS3QzMGV1dEZWdTdNS0szR1RNeWEzd0JzS2RxL255?=
 =?utf-8?B?SzhjREdCREYyRmxzV01OYVJTQmlsMTBsSExpeklDSnhpUTZCeEM4WGxqeDJm?=
 =?utf-8?B?cnNZWEtvV05GMzJWU2xMZ1FmeFdNVDFPMG1BNE5YZWFxUDcxZlIwYy9FSmNN?=
 =?utf-8?B?Q2V1cm5OWXU5c2dyMHBxait4OUN1RlpFTGZpS3BadDF2by9MZXhXUmNZRloz?=
 =?utf-8?B?K0xZNUd4dWU4N0xQakw1S1UwdDdkbGJsbTdwYkg4NkNNek1qaEE2a0lCNG03?=
 =?utf-8?B?UktldEI3SlU1ckliZ0s2N2wyd1FDU3J5ZnIyMkhKbFplV1ZQU2d2aUplUjF6?=
 =?utf-8?B?NGRyK3lFemNscnQ1a2pJMU52dTVRZ0xLa3dSWUpoSTZFTVhjdGlsaVpLeUxl?=
 =?utf-8?B?Zm01QnBvNGdPUzBaM1kySGlpVUNVSWFVdXFDUlZkNzJVaDRjR1hQR2R0clNF?=
 =?utf-8?B?RTlaM001Z2tqOWlMbWFXMDlRb3ZOSzExYzdZK3pJMXlJYTQ2bjd6WC84ZDJ1?=
 =?utf-8?B?cG0wUHAzWjlsRjk4bFBYR01YVUttaUFtTWZ4Wmpzd3g3eXk3b1N4bFlHNENp?=
 =?utf-8?B?UHpQZXllQjlWdTE2UUVtbURGd3JQUGRkMUZGallTUkRWT2d3SzFSaGRZR3pG?=
 =?utf-8?B?WmYwRElkUHZ1MzVqaTFVWTliTk92UmZacTNYVkVnMXo5ZDE5VDRnUnQ2bUV1?=
 =?utf-8?B?L3VRWXNsUlBvNkJHMDFNS3JGbGExNG1RTmFhWWM5UFo1d1laVXVsMVpRelUw?=
 =?utf-8?B?VFdISGdjdHFYdi8rQVZ5M3BiTW9CYTQ1alA4OU9jdGZrTjdxSXFDUEhXUDRM?=
 =?utf-8?B?dnNxU0lnbEgwaFRONmJsS013a3VtZmE5UzVBcE91dXJncE9od1pqTjMxd1Jj?=
 =?utf-8?B?VU13dVBqcWVhajlYaVNkampySmV1RnNCcmwzc1Jhd1p6KytIdENISDNSVklO?=
 =?utf-8?B?V2lOWUhtOFBYVHhMdkZscHhLOWgwYVRDTmxma3poOGx5MEN5QndnSzIxb2gv?=
 =?utf-8?B?aXpqRVJDSjlZSFJZNStvaTNWUmJzT2Zxbm9kWHVKSG9JVkttWXhZQnNvK3dS?=
 =?utf-8?Q?AtdsNij3IkR8KyXhQU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f70711b-5d09-42af-1a3d-08deef418ce4
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2026 20:23:14.8417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W5cQYED0rSriSKgbGcV/2h+n9KyZyq5b5BDOF+nHzezYubxkZyNJ0BfPfTxx7fnEmWE2NmsTKK7Xzbhd+bY5JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5678

UHVibGljDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGltb25jaWVs
bG8sIE1hcmlvIDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBK
dWx5IDI4LCAyMDI2IDM6NTggUE0NCj4gVG86IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxp
bmdAYW1kLmNvbT47IEhlZ2RlLCBWYXNhbnQNCj4gPFZhc2FudC5IZWdkZUBhbWQuY29tPjsgSmFz
b24gR3VudGhvcnBlIDxqZ2dAemllcGUuY2E+OyBEZXVjaGVyLA0KPiBBbGV4YW5kZXIgPEFsZXhh
bmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IENjOiBpb21tdUBsaXN0cy5saW51eC5kZXY7IGpvcm9A
OGJ5dGVzLm9yZzsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsNCj4gd2lsbEBrZXJuZWwub3Jn
OyByb2Jpbi5tdXJwaHlAYXJtLmNvbTsgU3V0aGlrdWxwYW5pdCwgU3VyYXZlZQ0KPiA8U3VyYXZl
ZS5TdXRoaWt1bHBhbml0QGFtZC5jb20+OyBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBMb25naWEsDQo+
IEFtYW5kZWVwIEthdXIgPEFtYW5kZWVwS2F1ci5Mb25naWFAYW1kLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCAyLzJdIGlvbW11L2FtZDogRm9yY2UgaWRlbnRpdHkgbW9kZSBmb3Igc2VsZWN0
ZWQgR1BVcw0KPiBvbmx5DQo+DQo+DQo+DQo+IE9uIDcvMjgvMjYgMTQ6MTAsIEt1ZWhsaW5nLCBG
ZWxpeCB3cm90ZToNCj4gPiBPbiAyMDI2LTA3LTI4IDAxOjMxLCBNYXJpbyBMaW1vbmNpZWxsbyB3
cm90ZToNCj4gPj4gK0ZlbGl4DQo+ID4+DQo+ID4+IE9uIDcvMjcvMjYgMjM6NTIsIFZhc2FudCBI
ZWdkZSB3cm90ZToNCj4gPj4+IE1hcmlvLA0KPiA+Pj4NCj4gPj4+DQo+ID4+PiBPbiA3LzI3LzIw
MjYgODoxNSBQTSwgTWFyaW8gTGltb25jaWVsbG8gd3JvdGU6DQo+ID4+Pj4NCj4gPj4+Pg0KPiA+
Pj4+IE9uIDcvMjYvMjYgMjM6MTksIFZhc2FudCBIZWdkZSB3cm90ZToNCj4gPj4+Pj4NCj4gPj4+
Pj4NCj4gPj4+DQo+ID4+PiAuLi4vLi4uDQo+ID4+Pg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IEkgdGhp
bmsgdGhpcyBjYW4gcHJvYmFibHkgYmUgZHJvcHBlZCBub3c/IFRoZXJlIGlzIG5vDQo+ID4+Pj4+
PiBpbnRlcnNlY3Rpb24gb2YgdGhpcyBvbGQgYnJva2VuIGVtYmVkZGVkIEdQVSBhbmQgYSBDUFUg
dGhhdA0KPiBzdXBwb3J0cyBDQyByaWdodD8NCj4gPj4+Pj4NCj4gPj4+Pj4NCj4gPj4+Pj4gSSBk
aWQgY29uc2lkZXIgZHJvcHBpbmcgdGhlc2UgdHdvIGNoZWNrcywgYnV0IEkgd2FzIG5vdCBlbnRp
cmVseQ0KPiA+Pj4+PiBzdXJlLiBTbyBJIGtlcHQgYXMgaXMgZm9yIG5vdy4gT25jZSB0aGVzZSBz
ZXJpZXMgc2V0dGxlcyBhbmQgSSBjYW4NCj4gPj4+Pj4gZ28gd2l0aCBuZXh0IHN0ZXAgb2YgZHJv
cHBpbmcgdGhlc2UgdHdvIGNoZWNrcy4NCj4gPj4+Pj4NCj4gPj4+Pj4gQEFsZXgsIEBNYXJpbywg
QW55IHN1Z2dlc3Rpb25zID8NCj4gPj4+Pj4NCj4gPj4+Pg0KPiA+Pj4+IFRoZSBiYWNrZ3JvdW5k
IGNvbWVzIGZyb20gdGhpcyBzZXJpZXM6DQo+ID4+Pj4NCj4gPj4+PiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9hbGwvMjAyMDA4MjQxMDU0MTUuMjEwMDAtMS0NCj4gam9yb0A4Ynl0ZXMub3JnLw0K
PiA+Pj4NCj4gPj4+DQo+ID4+PiBUaGFua3MgZm9yIG9sZCBsaW5rLiBTbyBpdCBsb29rcyBsaWtl
IHdlIGFyZSBnb29kIHRvIGRyb3AgU01FIGNoZWNrPw0KPiA+Pg0KPiA+PiBZZWFoIEkgdGhpbmsg
c28uDQo+ID4+DQo+ID4+Pg0KPiA+Pj4gQWxzbyBpcyBpdCBzYWZlIHRvIGFzc3VtZSBTTlAgaXMg
bm90IGVuYWJsZWQgb24gdGhlc2UgcGxhdGZvcm0gYW5kDQo+ID4+PiBkcm9wIHRoYXQgY2hlY2s/
IEFueXdheSBTTlAgcmVxdWlyZW1lbnQgKHdoaWNoIGRvZXNuJ3Qgc3VwcG9ydA0KPiA+Pj4gaWRl
bnRpdHkNCj4gPj4+IG1hcHBpbmcpIGFuZCBBUFUNCj4gPj4+IHJlcXVpcmVtZW50IChuZWVkcyBp
ZGVudGl0eSBtYXBwaW5nKSBpcyBjb25mbGljdGluZy4NCj4gPj4+DQo+ID4+DQo+ID4+IFRoZSBj
dXJyZW50IHBsYXRmb3JtcyBJIHRoaW5rIHRoaXMgaXMgYSBzYWZlIGFzc3VtcHRpb24uDQo+ID4+
DQo+ID4+IEZlbGl4LA0KPiA+Pg0KPiA+PiBDYW4gd2UgcmV2aXNpdCB0aGUgcmVxdWlyZW1lbnQg
b2YgaWRlbnRpdHkgbWFwcGluZyBmb3IgQVBVPyAgRG9lcyBpdA0KPiA+PiBzdGlsbCBob2xkIHdp
dGggdGhlIGN1cnJlbnQgaGFyZHdhcmUgYW5kIHNvZnR3YXJlPw0KPiA+DQo+ID4gSSdtIG5vdCBz
dXJlIHdoYXQgdGhpcyBtZWFucy4gSXMgSWRlbnRpdHkgbW9kZSBzb21ldGhpbmcgbGlrZSBwYXNz
LQ0KPiA+IHRocm91Z2g/IEkgZG9uJ3Qga25vdyB3aHkgdGhpcyBpcyByZXF1aXJlZCBvbiBBUFVz
LiBJZiBpdCdzIHJlbGF0ZWQgdG8NCj4gPiBJT01NVXYyIHN1cHBvcnQsIHRoZW4gaXQncyBwcm9i
YWJseSBubyBsb25nZXIgbmVlZGVkLiBXZSdyZSBub3QgdXNpbmcNCj4gPiBJT01NVXYyIG9uIG91
ciBBUFVzIGFueSBtb3JlLiBTdXBwb3J0IGZvciB0aGF0IHdhcyByZW1vdmVkIGZyb20gdGhlDQo+
ID4gYW1kZ3B1IGRyaXZlciBhIGZldyB5ZWFycyBhZ28uDQo+ID4NCj4NCj4gSG1tLCBJIGp1c3Qg
aGFkIGEgdHJ5IHdpdGggdGhpcyBvbiBhIGZldyB5ZWFycyBvbGQgQVBVIChQSFgpLiAgSXQncyBm
bGlja2VyIGNlbnRyYWwNCj4gd2l0aCB0aGlzICg3LjItcmM1fmlzaCB0cmVlKToNCj4NCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvYW1kL2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L2FtZC9p
b21tdS5jDQo+IGluZGV4IDI5ZGMxOGQzZDIyZTUuLjFlNzkyY2VlN2Y0Y2QgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvaW9tbXUvYW1kL2lvbW11LmMNCj4gKysrIGIvZHJpdmVycy9pb21tdS9hbWQv
aW9tbXUuYw0KPiBAQCAtMzEzNCwxOSArMzEzNCw2IEBAIHN0YXRpYyBpbnQgYW1kX2lvbW11X2Rl
Zl9kb21haW5fdHlwZShzdHJ1Y3QNCj4gZGV2aWNlICpkZXYpDQo+ICAgICAgICAgIGlmIChkZXZf
aXNfcGNpKGRldikgJiYgdG9fcGNpX2RldihkZXYpLT51bnRydXN0ZWQpDQo+ICAgICAgICAgICAg
ICAgICAgcmV0dXJuIElPTU1VX0RPTUFJTl9ETUE7DQo+DQo+IC0gICAgICAgLyoNCj4gLSAgICAg
ICAgKiBEbyBub3QgaWRlbnRpdHkgbWFwIElPTU1VdjIgY2FwYWJsZSBkZXZpY2VzIHdoZW46DQo+
IC0gICAgICAgICogIC0gbWVtb3J5IGVuY3J5cHRpb24gaXMgYWN0aXZlLCBiZWNhdXNlIHNvbWUg
b2YgdGhvc2UgZGV2aWNlcw0KPiAtICAgICAgICAqICAgIChBTUQgR1BVcykgZG9uJ3QgaGF2ZSB0
aGUgZW5jcnlwdGlvbiBiaXQgaW4gdGhlaXIgRE1BLW1hc2sNCj4gLSAgICAgICAgKiAgICBhbmQg
cmVxdWlyZSByZW1hcHBpbmcuDQo+IC0gICAgICAgICogIC0gU05QIGlzIGVuYWJsZWQsIGJlY2F1
c2UgaXQgcHJvaGliaXRzIERURVtNb2RlXT0wLg0KPiAtICAgICAgICAqLw0KPiAtICAgICAgIGlm
IChwZGV2X3Bhc2lkX3N1cHBvcnRlZChkZXZfZGF0YSkgJiYNCj4gLSAgICAgICAgICAgIWNjX3Bs
YXRmb3JtX2hhcyhDQ19BVFRSX01FTV9FTkNSWVBUKSAmJg0KPiAtICAgICAgICAgICAhYW1kX2lv
bW11X3NucF9lbikgew0KPiAtICAgICAgICAgICAgICAgcmV0dXJuIElPTU1VX0RPTUFJTl9JREVO
VElUWTsNCj4gLSAgICAgICB9DQo+IC0NCj4gICAgICAgICAgcmV0dXJuIDA7DQo+ICAgfQ0KPg0K
PiBUaGUgZmxpY2tpbmcgaXMgcmVtaW5lbmNlbnQgb2YgaXNzdWVzIG1vdmluZyBCT3MgYmV0d2Vl
biBWUkFNIGFuZCBHVFQNCj4gZnJvbSBhIGZldyB5ZWFycyBhZ28uDQo+DQo+IFNvIEkgZG9uJ3Qg
dGhpbmsgaXQgY2FuIGJlIGRyb3BwZWQgKGp1c3QpIHlldC4NCg0KTWFrZSBzdXJlIEFUUyBpcyBl
bmFibGVkLiAgRGlzcGxheSBidWZmZXJzIGluIHN5c3RlbSBtZW1vcnkgYXJlIHJlYWxseSBzZW5z
aXRpdmUgdG8gbGF0ZW5jeS4gIFNvbWUgb2YgdGhlIG9sZGVyIHByZS1yYXZlbiBjaGlwcyBsaWtl
IGNhcnJpem8gd291bGQgZmxpY2tlciBldmVuIHdpdGggYW4gaWRlbnRpZnkgbWFwcGluZy4NCg0K
QWxleA0KDQoNCg==
