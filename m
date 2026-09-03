Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012071.outbound.protection.outlook.com [40.93.195.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9344243E48D;
	Thu,  3 Sep 2026 11:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788433736; cv=fail; b=SquxjOiA21V7OyZuuSxENJOhVsKM0vj8mKqBml1hYJThB/LfNKSIj90fcmxxwkfXBrvV/GY3RmHkwr/g+FSGdKYY+PeSuDPSTElay/HV/940j/7PHUbmdGLLXGd/wpauzlB4NGGRdE5CHZbJUB+70Yb/xwfgxOEO9LAdpvK3VBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788433736; c=relaxed/simple;
	bh=Mbef8quQlk0V9frRQl9JInLBLItAUme+Y9B7tdb+hPk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AjrawHi1+EESDct5YkPktuxwmrmXOXY5janjVsVO3ZfTxomVboCM4ROHiyha2eCUh5EHB5hLM8xSCoGMjNLIwEI1qkS6s6iWM524paz764fkZWsMKvmYb5ZETE/dWNxSAY1BdZwV7TSM2SU04xS3p4Qwqs5VecK4ROLlzeUUESk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f3Pnf5yd; arc=fail smtp.client-ip=40.93.195.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f3Pnf5yd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWuj6RNbYNQE8JZ9uZeGw8jMeNhnepDyuw5w0eIo1i4HcmgZjrnoK77XocjPPaE5PFg01+M6edR2qZi2uyL5Excq9gNWsV8PdyIduXPIt/kbUCid8A2vk8qcrR9rqKFNRV+9yMKmEaSOU15FEbwjekWMAum0MVMithr9tBJDVV6PkGOh4i9G8VlSEhvhizx2mrysM1Fdyby0np4ipb27UNRzsP4b0Kz4BLwRNnL1Ly3sm9AyemdRzbjbP1BzpHWQHakAM75DRFbWIk/eFeTA9LCGLC5hfM25QqlqZLipTG9yW7AjN+uAeStb1uuM+V3OmGJ067K/xBU0gCnYb6K1UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mbef8quQlk0V9frRQl9JInLBLItAUme+Y9B7tdb+hPk=;
 b=VH06xeTKtynDHPlw164Z+T/M8Vh5UlP6fRqSxANBa4atgV4mqwYVx8tkO/h27asyki5g3iAVG2wig1ahJWH+AlL9uinunmrRHnQDfnQqL5PMrJtBhY1E/BlsPTaNeWaqo80U64jpuAT/8NKckKbaPMGE+Oyd8j3ANXZZwX8yvyE027a1LTYHQXluAB9Fk8NYO948GpP/gceEUzSf6XCz3v1XVP8FSzpj+PExUTawZj9bWgtIkeLKtV1tfJuSX5pgsbOkIs2hV+iXCZ+bEWNIYNszd4WR4KNHg8ftboHBBnxz1TVkWBPYU/SNS9CVdtYg+07ZnFTqSar5aNIO0/rddw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mbef8quQlk0V9frRQl9JInLBLItAUme+Y9B7tdb+hPk=;
 b=f3Pnf5ydCLYyXzxrgnBsIRvigweFDOH7VpE3h1RTiMxaQ/1HzScTsCvHpYPjHUabc2umP+ka3Oj+nRlEqbt5vXSEQ+9cYP/TAeDZRVy0FWGzyRpAO8v/AE4OpaNJlVky/mIoIZaGElXMi1UeiKKLA8NW7nlp7h5fob0sKdO5hMDtMUevMfqma/DLns5LO3n1LPb2/KmRObJ+qwsvicQz8khEcMh18zAAsY40MG/h0i2GVLKMDRizN/DdOhka3CS+RX7hoE+aV1WzUUmSEGdWph4JbBlx3WT4vveu/bKx4lQCy+CiffRi/5jXoG06fMMWIn3iHEiMP0DgXDU+XyAtqg==
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 by BY5PR12MB4210.namprd12.prod.outlook.com (2603:10b6:a03:203::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 11:08:51 +0000
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b]) by SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b%5]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 11:08:50 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "K V P, Satyanarayana" <satyanarayana.k.v.p@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>, "kbusch@meta.com"
	<kbusch@meta.com>, "michal.winiarski@intel.com" <michal.winiarski@intel.com>,
	Sonang Patel <sonangp@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt
 Ochs <mochs@nvidia.com>
Subject: RE: [RFC PATCH 05/19] vfio/pci: Serialize config access with recovery
Thread-Topic: [RFC PATCH 05/19] vfio/pci: Serialize config access with
 recovery
Thread-Index: AQHdOqQhPH0FkzkrhEuo8srcRgj/Cra8s2LA
Date: Thu, 3 Sep 2026 11:08:50 +0000
Message-ID:
 <SJ0PR12MB8614B1F236C9E664A26601FAABB62@SJ0PR12MB8614.namprd12.prod.outlook.com>
References: <20260901093217.8539-1-skolothumtho@nvidia.com>
 <20260901093217.8539-6-skolothumtho@nvidia.com>
 <4dfc0aa3-a08a-495f-896d-7ea7c91a12ff@intel.com>
In-Reply-To: <4dfc0aa3-a08a-495f-896d-7ea7c91a12ff@intel.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8614:EE_|BY5PR12MB4210:EE_
x-ms-office365-filtering-correlation-id: cd41d86e-e0dd-4415-b708-08df09abbc0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|38070700021|4143699003|56012099006|10067099003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 cQXgVWKMd8M7mnDuDH6nRmHaPzk3XJyO3PDDeyTU3m31P9rzJb+ckq0K4MD5r+koX8S8C9SVuFXyMnBCiiSRdmi8Hs4OiEZsdJNfcxB4zpZDGd+CioDtPa2mea7lH/UsOoz1Prp7WcGkaXz7q2HzmZmBPi2jZyQTQU1WFvzNVd0En8ygOg2HJwDgpEINxRqxktDchrBga/Spr84jD+0YWouO6P1epk3P2kx4jErhKS+MQW34N79aPXCGPoGF+lDpSvAyoIhsvyOeqfYEnVJoudyJ/au45UeKw+tfcBxY1Wiz19S5z6tKLNEORDOxkABk1INRAlwkDqrR7111ChntHbSv0a9tOXARbwPoex1ckg7uqruhdthFLg4Ua3eaJiZVS4K8kTd0XWjOCnXV/+BpHpP3SJdDaL3s0+iLuNB7Iz+c02sQ+UAYvgyw2/O06+wXK32ctfRZpEfeTUGg5AghNa0ZKgyuOIRoolzUNVpotNyUtAGp1Uiixn64BuryNx+a7qk2c8FoHcQ5iYpcaiFImSr1mUWFsi800bHcqrLQP5lAM5Sz/ypzY3DWc2mIVj1pZLWPwoFj8S/YUHBXZBF9R2Z2E934TFyQ14j8WU044DbQLUg0etY2lK6G3g0hlMUy4NFTZHTQPolU0QaHt7o49w8+3zlrpebtzhf8ICjAN2oL6GStw+T5P5lz0lZmMeCAPOFWmdkTxq3Y2Ki07JoJOw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB8614.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(38070700021)(4143699003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K2s0cXFwdEVNTkZoZnEyT3M2L09Pbkd0THRuUE1yWkx3YlFoVkw1MUI3ZlR2?=
 =?utf-8?B?YlRFWEF3dXVJN2hyQUtRRFZzMkFGYXBwNFEvaFJndjVob08vQ241VlNESDFs?=
 =?utf-8?B?aDRUR0FHbVdnUHp2OXNkZS8xeUVEeHV3WlMxNFJucnREMWJ3MGxYak1CYUls?=
 =?utf-8?B?YVJWVXZyTFdBenM5QkdwK2Z5WllRT2NaNWZ1QTAvdEdKa1QybFhhYlo5TXRN?=
 =?utf-8?B?SFB1RGh3U3Q4Vmd5bGwvMGRjYjE3THZGNW9WRFY4TTQyQ0EvckI4WW8xblFR?=
 =?utf-8?B?T0ZUUmRpNmdyRGVLTGFoMFBuR0JDYlpYODBVMjRGUk5vVFlCTFgzaUxWRjE5?=
 =?utf-8?B?Zkh5SDV6YXlpKyt0d0U5a3dDcG0wdHdQaHNocHFLOGdhRkxNdk80ZWhDRVR1?=
 =?utf-8?B?NHQ1bkxGMm5WNlhMa1RFNWFZbGNUdTUzcks0RWhOOU5FY1dQZHF6SERVekRV?=
 =?utf-8?B?blFGbGo3WlZ0bDRXYnk2eG1kdENDSFJvd3JXYi9QYlFteTFoVDliWmtSL2ZG?=
 =?utf-8?B?T2NNV3hBRWZ3aTM2U2tuODZJMU1PdURGOVZ6dFZWTVRyN2RtdHNoSW5Dc09x?=
 =?utf-8?B?SUtXb2kwSm5leXFnVEZLdUxDN0JsK09JMGdxQWlqU3JDaXBDQkJRNFNIQlBl?=
 =?utf-8?B?ZWx3cUZUeHV2OStINlZuaXZZVzRSMk1ISjJMNHZlbHJJN2svYTNYc2szWlFk?=
 =?utf-8?B?TjVFWUwvSGVCTDVyR2FycTlkU2JJejQ2REo5eFQ3MmZGV2JtT1RXUTM1ZzZY?=
 =?utf-8?B?ODlyZEtmL2QzMHVqNGswZVBZRWttNzFBTHBmSEE4RlppTWFqOElBVUY4VjZo?=
 =?utf-8?B?S0dYTWV3c1JwRFFzQ25rOGFGclVxTWYrdEdCK2JaNDhJbVhpb0xuUE5ZRm55?=
 =?utf-8?B?aGJDNk80YVZHSjU2ZlQ2R25XVkJqSkQwdGFmVWtrdWNoT2ZSSzBrcFlKRnN1?=
 =?utf-8?B?eHBHM1YwVUxFYTdpQklQNllBclhPVFpjeGpFQlFUdTViNkdpalNuVHhNVHpK?=
 =?utf-8?B?OVlZaEVGR1dOQTlidGxPU1daYm15eFhlN2hNNFc1a3h6MWJUSU1TMGFlUHov?=
 =?utf-8?B?OFZSZVNIM290S3hVVkRlNXB1ektoNWs4UHVnNzcyRFpacVk1ejhxNFp6TVJB?=
 =?utf-8?B?aUE5V1NUdFprU0l5S3hjUGg4WHk3VEU5YVNBVUpXN2xXVjBrdkw4WXJJWDdN?=
 =?utf-8?B?c3NqV2RXcUxaejVJVXZZN0VPT2xhZVYwOXJaVHFEd1c4K2RPT3p6N2VsZllX?=
 =?utf-8?B?Mlprbyt3QTdSUVljQ2trb2FLUWFYU2VUUFZoQnRvVzR5dTQ3ZDhBc2dsblZG?=
 =?utf-8?B?ZzFlanFiTmFEYlA0M0tXUGFVTXlSbEVhSXV2Wk5nc21CblN3SGREWXJ6TzEr?=
 =?utf-8?B?QVQ4RGNQak8zMlVHNk1kbDFlZ0gvTmJaamNjNUF0ZER5ZHJrVXg2N0RuYy9K?=
 =?utf-8?B?bHRlUFJoY3BTbkowY1ZZL1pGUHdvQXpWSjduOHBnMmVPbU0rUXhJMWkvdWtq?=
 =?utf-8?B?N28wSktJNWdoaFgwNVR6Q015bkVmMG1GRnp1NG1KdU1ZNTh5SmpTWHpvZTdT?=
 =?utf-8?B?UDlIL25OcU13dlFTYnVEcTNJdmR5L3BwNUpIUEx0eVoyeUVwOEc1ampxNlp1?=
 =?utf-8?B?MGZMaERkaVk5T0duRVdoVDJRdHFDRVo0ZzNiSFBMUFJNb0lBelRXT1k2UTNJ?=
 =?utf-8?B?WDNkakx5UTVsa2RQWXVLSlFDRWtqaG91WktuRGVNbVphWjBpcmJ0T2hTaUJp?=
 =?utf-8?B?VkZaeGdDeGFRRmJzWm8wVzYzK2xSSEtxenJVd2laQW1Vc0sxZ2JPZkRjVjlX?=
 =?utf-8?B?aURidnpOdDFQWDM4akdpbVpqZkNqVUdZZ0hrMlVMU0ZlaDBkR0hSWDB0amE5?=
 =?utf-8?B?QUtkU1NhUVFhOEh4UzNyQXhUMmpZbUVUSENYVWhBNTZMcFNXVjdqd1BYeGhm?=
 =?utf-8?B?TGp5ZjFrRCtvVTJZTDJ5TU8xOER6bU5EbXR2K05hRDkvc2VCRXlRREQrdkhn?=
 =?utf-8?B?M2NySEgxZFJNREVsVVd3cEpWQUswUlJCaW53emVQMzM2UEFVZ01xTGloWWQy?=
 =?utf-8?B?RXlTeGtnZ290L3V5UmdMUE5ReFFpZlMzNUpENWliMzlVUjFuM3pIdHN6RzFR?=
 =?utf-8?B?RVpmbUpRSmc4ZFFBMis4Y1ZrTUhwdzNCdnJqVmVybnprVWpYS1BFSlpxclJI?=
 =?utf-8?B?dldidHVKa0N2MVREc1FSNXlMRHR0eW9NdzJyOTlhMjFQUVlNdmVkWUpRTlRi?=
 =?utf-8?B?ZFRyaVA0REhaOHRzTXNwK2xpVExHazhxcWlTSzY5NVFVa2FqUWovZ1F4eTRk?=
 =?utf-8?B?UHVxSyt4YmVIN1BYUzNRVlVCRHp4dnNpTmJNWm5nZmxWaHFSWW9nZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd41d86e-e0dd-4415-b708-08df09abbc0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 11:08:50.8266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OxEBYodb7emAQFJ2mRLnsvwxf/RRDOnNASfjuzPbECI4Kd/JENG0TEcP0ZN7tlGXN1plJBLG1U6p8+EZF4dugA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4210

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSyBWIFAsIFNhdHlhbmFy
YXlhbmEgPHNhdHlhbmFyYXlhbmEuay52LnBAaW50ZWwuY29tPg0KPiBTZW50OiAwMiBTZXB0ZW1i
ZXIgMjAyNiAwNzoyOA0KPiBUbzogU2hhbWVlciBLb2xvdGh1bSBUaG9kaSA8c2tvbG90aHVtdGhv
QG52aWRpYS5jb20+Ow0KPiBrdm1Admdlci5rZXJuZWwub3JnOyBsaW51eC1wY2lAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBhbGV4QHNoYXpib3Qu
b3JnOyBqZ2dAemllcGUuY2E7IGtldmluLnRpYW5AaW50ZWwuY29tOw0KPiBrYnVzY2hAbWV0YS5j
b207IG1pY2hhbC53aW5pYXJza2lAaW50ZWwuY29tOyBTb25hbmcgUGF0ZWwNCj4gPHNvbmFuZ3BA
bnZpZGlhLmNvbT47IE5hdGhhbiBDaGVuIDxuYXRoYW5jQG52aWRpYS5jb20+OyBNYXR0IE9jaHMN
Cj4gPG1vY2hzQG52aWRpYS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIDA1LzE5XSB2
ZmlvL3BjaTogU2VyaWFsaXplIGNvbmZpZyBhY2Nlc3Mgd2l0aCByZWNvdmVyeQ0KPiANCg0KWy4u
Ll0NCj4gPiAgICAgICB9IGVsc2Ugew0KPiA+IC0gICAgICAgICAgICAgaWYgKHBlcm0tPnJlYWRm
bikgew0KPiA+ICsgICAgICAgICAgICAgYWNjZXNzX3JldCA9IHZmaW9fcGNpX2NvcmVfYWNjZXNz
X2JlZ2luKHZkZXYpOw0KPiA+ICsgICAgICAgICAgICAgaWYgKGFjY2Vzc19yZXQpDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgIHJldHVybiBhY2Nlc3NfcmV0Ow0KPiA+ICsgICAgICAgICAgICAg
aWYgKHBlcm0tPnJlYWRmbikNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0gcGVybS0+
cmVhZGZuKHZkZXYsICpwcG9zLCBjb3VudCwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHBlcm0sIG9mZnNldCwgJnZhbCk7DQo+ID4gLSAgICAgICAgICAgICAg
ICAgICAgIGlmIChyZXQgPCAwKQ0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJl
dHVybiByZXQ7DQo+ID4gLSAgICAgICAgICAgICB9DQo+ID4gKyAgICAgICAgICAgICB2ZmlvX3Bj
aV9jb3JlX2FjY2Vzc19lbmQodmRldik7DQo+ID4gKyAgICAgICAgICAgICBpZiAocmV0IDwgMCkN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gDQo+IFRoZSBlbHNlIHt9
IGlzIGFsbCBhYm91dCBwZXJtLT5yZWFkZm4uIENhbiB3ZSBtb3ZlDQo+IHZmaW9fcGNpX2NvcmVf
YWNjZXNzX2JlZ2luKCkgYW5kIGVuZCgpIGluc2lkZSB0aGUgaWYgKHBlcm0tPnJlYWRmbikgPw0K
PiANCj4gV2UgZG8gbm90IG5lZWQgdG8gYnJpbmcgaWYgKHJldCA8IDApIG91dCBvZiBpZihwZXJt
LT5yZWFkZm4pIGluIHRoYXQgY2FzZS4NCg0KUmlnaHQuIFRoYXTigJlzIGJldHRlciwgd2lsbCBj
aGFuZ2UgaXQuDQoNClRoYW5rcywNClNoYW1lZXINCg0K
