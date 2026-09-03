Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010011.outbound.protection.outlook.com [52.101.56.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B0444C4F2;
	Thu,  3 Sep 2026 10:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788432456; cv=fail; b=Hlq+qW0g499yrl8P+o75H6B5eVCrZlcQlMqHN/2Cml59ZMkjt5RKUKfEiEll7861jBLRyZ5xM0OuI2p8dAvj6vqWgb7degzdsD4HFHlE7Qgyisr21M2wMQgarnzxyOpq5pN0zrk3BiqYQdlOCgyKP8YVFNQ5wYWt7EPRa6B/mbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788432456; c=relaxed/simple;
	bh=rlhImbdcKCGQNtNvjaGcgb8DAmTYc1LsddLZMsgXC7o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mIFsBqHeyFZMvRibeUkbjOX6AMCKNf8emrWHXl12RfOgARNIiENq1xyVWowDyEkLegV5ucwcnNYk5iYdK3qbEOrxu4Ndwlo1V/29fCtbkyhJ3gaPDrYOCe9/LErsc4MVx8ErxRE9IjVuco2q/8FFYSGoJHrop0Md4HogrBBz1OQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PkmoOXRz; arc=fail smtp.client-ip=52.101.56.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PkmoOXRz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kf02avRkowXV/Vst0xOw+uPsvNVbIDNXeTrI9X6UCZMGUG/3FMl4uDy0TRo4srfpujRST8BVJTg68vqwqtdz+9mz/X0vYLflD6iKxFGW0mRE2u3+Mzsr1C9hDhtixBwAG/au5mcmrrRYBGxOg7l3kGJabTEVc7HpJqT23LtAtJxjsR/su/jyjxU32SwRsWRddPjBvU0NqkIJOPZXHytde8KSEw56j7IMvHjUPk60xhqW42/acovng/8XrwgTcW6kDZ4dsrxrtwAfhxvQvrWppL939Brc4mGVyF0O6ReJRdjZ+BH9xBwzXdz+acdGzdZRXT8A8Tvy9lEQ5Pmec1IywQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rlhImbdcKCGQNtNvjaGcgb8DAmTYc1LsddLZMsgXC7o=;
 b=VeIfWD5TOfVIo9ShKbujzqoLyf7Ur2zfyVMbisr3NZQLBdMa6nTh3VlwSP+XKMrMkPR4Mdxk78SdLMvz+mUija7gtCX9sVlb9D1Y9r4pTCN7VXMARD19keMKhPaqlXZMynxNmUp2+fHcGAQ0TolKBKbzw16r2slhEcW0tyAxksN6JxY3kJj203NcKE8h3Mvuih/ZMjK198X5SUZPR4IIF2qDNDq272Bjwza9gBv254MvsvrrRWV5153JQ6UrhR99664QTIxF8Eqs23VFh+HtPhVK5z4Jjx+fQr5KgTj+EBWWqiPw7YrF+LUssK1xmDCm1hMnY5vg4dEhwAdcy3WJUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlhImbdcKCGQNtNvjaGcgb8DAmTYc1LsddLZMsgXC7o=;
 b=PkmoOXRz24WeeadgsAs+k8vw6JIC381P+wAgO1rNpKd4CB+GIJLxt9FF+KGpvUAfM7xt85C4rezIxfdU7yjks40UmI0licbxBeNExmrZKSrQJ+RJe2mB/p6jBCosAoIYEjhil4p4IU5LmPxS87QP6PVznu7iAa4SWVM+LXvzx01V4YxUM9snYtMp25YIM/IgaQNTD5StVhfJdg9I/qLMqqBELETkSYqEiwmqQg6jwPyd0pZjMJnHL0Ic3Ty+un5tlepggIpAZb9dGwZ5Wn02kwxb05p4OMRLU0qV9Px0wtlTeVQvLa3WAnadWA8FIXuNud2SGBxwEArHoBTmfOULJQ==
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 by DM4PR12MB6664.namprd12.prod.outlook.com (2603:10b6:8:bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 10:47:29 +0000
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b]) by SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b%5]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 10:47:28 +0000
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
Subject: RE: [RFC PATCH 11/19] vfio/pci: Serialize runtime PM with recovery
Thread-Topic: [RFC PATCH 11/19] vfio/pci: Serialize runtime PM with recovery
Thread-Index: AQHdO2+EbOPnBbgFyEik1JYrAsWEjLa8q2cA
Date: Thu, 3 Sep 2026 10:47:28 +0000
Message-ID:
 <SJ0PR12MB86146DEE4798BFEB753BF8EDABB62@SJ0PR12MB8614.namprd12.prod.outlook.com>
References: <20260901093217.8539-1-skolothumtho@nvidia.com>
 <20260901093217.8539-12-skolothumtho@nvidia.com>
 <37b7f389-d95f-4d0d-8bd7-85074f7c6122@intel.com>
In-Reply-To: <37b7f389-d95f-4d0d-8bd7-85074f7c6122@intel.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8614:EE_|DM4PR12MB6664:EE_
x-ms-office365-filtering-correlation-id: cb9ad1ac-3ed1-44a3-6202-08df09a8bfee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|38070700021|11063799006|56012099006|10067099003|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 unlQfPy38aP5qHCu5zX6e4gfPg/sDvpQhU/ykvNs8I7u/TAwuwkQzJIXWmByndr2koUvXpN3jPxH4qroaFr0Hgl0U4HVpIIF3YWyG8xS4iK0CTGDcJitTpwAusQvrR3frzyT9n57GAPvBEzVQmCFtLxp0Xd0TmQHCrgB3yTVmcKN/7vFdFTWqs2FaOr18HG9edzY3KRcESY3brI3ApqcK8/6HY2Wok2XMhE6IelVAJcl9GKZmxExRM+2qbNmlEomiL/ewmf/qPGWTinKsEKAAvI79ncRjee6qV9RZnYjxFFKIN00ciO9lyXwZJlUSN8GUA0KAOTjs638+48zkQRIT+GcygvNRdQwJwbHoswBjsUBG+mQr9AgV7+iVXxCp1aBv+an6Ki3f3YbBZ+6WyuPmovYP/HgEUp+l1hwvWqV9lltTa3ic0V/sCZWgWZ2yfx5aO2c2+Bg2Id/B5qeurWH7Xa4CgxHF38nxs1UVaZvq7kJE3NUBCZwdnd3uhLq9TbrUoXdNCQ6C5T1TzJHkib1PTVQn/JAMp9VO3TWCY1EqZu0RrjhJ9PtUFyDE61r4iMMJFnfyDvdAAXMNgTLrk1fDDUANACEdV8SBDE/tdJ7rzjFHWEA7/f566dma6g+ukqIr9SM3xDFdDAyxuEVUHzkjXGJn53YpQGtZ2R5w/8aqf+0HnmHy35EsJDzCtHMk3iCxgirpR4x550p8vlmgHDAUA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB8614.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(38070700021)(11063799006)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RStsSVYwYzdwSkJZMEpjdEVPdUFGOFlIZVlRWXJDZDRPNUxWb3VMd1pvVWR1?=
 =?utf-8?B?T2Q2OXJGamx5WDYyV0xWR0xjQnRLMzZXamZPVC9TNGpkUExIa3g3NURJQ1ZU?=
 =?utf-8?B?L0ZzcGVzbVQ3QnVsdEh2RGlGV3llcittdWxwMm5HSkVGYmU4eC9HZk1TdlVW?=
 =?utf-8?B?M3kycnNpbXB4TVFMaUY1amxJSjFsaTlPaTdoOWVZa3pnZ2RGb25SRFZFcnVV?=
 =?utf-8?B?K0ZZUkVtMHFqRlUzNzNRMURlQnlCdXFQUzNzVVJ6bXo0eGEyNWw2K0dHL21h?=
 =?utf-8?B?QzkxS3JCcHZwRmw4bEI3QWFWdkhVamRXR3p4aG0wNFh6YUJIckxPVUxIMGs3?=
 =?utf-8?B?cFBieU93bTc2RmN3d1ZhMi9xMDdGZGNqZU1rRUpYMEkydDlhYnBsTU5jWktt?=
 =?utf-8?B?VmQrRy93eHZFM1dUY0ZtN0hwNjV5RldKa2FZMjAyNmx5VVMyZUo3WTV6YWJ1?=
 =?utf-8?B?aHBwYmo0UFFJUCtsUlE4K0FtV2xJRlozQzVKRk1PZzBaMjF6cjRBSkErTW5v?=
 =?utf-8?B?VkxDU3NLS2ZOdDBGS0FVVGtFMlJWR2VNMFVneUNhWlB4dUJoZFZXUWloazdS?=
 =?utf-8?B?MFZmblZlTFd0ZXlUTkx2dkExZWgya3VnZkNRdHNCS0tGQStjTVE5bGhNUCtI?=
 =?utf-8?B?WG1HWFdVbjRERmd1WDF1b0lWNHoxeGpHVGhKOHVqaGZEa0htaDdKRHRURjhm?=
 =?utf-8?B?RFJqU2xPYkp5TklJZktrb0tKTndFbCt3dlVnaHVUaTJKdXR4K213ZWlaNGpH?=
 =?utf-8?B?SU1GYWwyWEN4UGNzbE96bXZ3ckxTL3c2aC9LaC9DaXRiK2JwY3lKZWdCWXEy?=
 =?utf-8?B?cXdvYmlodUxrWjE0THhhOHJKc3JlUXR1OTI3U1RkZUZjU3I2cWRoakJKWi9v?=
 =?utf-8?B?VHpZNmhwbEpyb2MzQUpzTVpxNlV3aXRJUTF2aFBhVlRpYThsVXNtSDdUWGJ2?=
 =?utf-8?B?Q3BCZ2FQd243NkZub0RKUStxRTc3aTNtaW52Z0VzaWYwU2ZZTUhLMlRhYzVM?=
 =?utf-8?B?Um4xWWpURzJhK0podnpDbHIvemFHdXhZM0puaW5Ua242ZVhVWFZRVXo1TFBL?=
 =?utf-8?B?SzBOOXorVGdHY2lhUm5EY056b0M3VmZGcTVPWDJBMzVibkdTVnNqRExTeGVa?=
 =?utf-8?B?YUlmcldvb0hmTklyN1FRQUY1dE5hc3hVTlVSTzRNRmk5UjhRRnJmZnVmNHRK?=
 =?utf-8?B?ZEZPTmVsOFJPNG4xOXd5YXdNNktuQU5RL0tPZzNLSFRybFViOW83SVJQQk9N?=
 =?utf-8?B?TXU1Y1h6Y3RvWEtCUHluTkpNeElkYWorNS9nUnNabzIxSVFQSmJTbHVNU2l5?=
 =?utf-8?B?Sys4ai9XcjJWU2FBZEFXY0NpNjhZcWF1VUlqODZZemRkTm80S0hIZGJGWkRv?=
 =?utf-8?B?RlVIWlRjTnJpWUpLS1FpYmo3U0tBZUJLUlJGWXd4MEFkcTBkUW4yeU5lYkox?=
 =?utf-8?B?S1ZhUTdiZHpDQnV5VG1qR05Jay84TWNQL0dQVTF0dGZMeDVGNzBpK3VFTjh2?=
 =?utf-8?B?d1QxVjBtZnJqQjZPRmJ2WHRHSzR3OHdqQ0V6ZU1SZ2NUTDYvQytmZ2xlbWJp?=
 =?utf-8?B?dXlqdlRxRzl4STZZY0ttQzBzdW9nY09FdTVjeTVicW8zN2daL3RmWVdad2Ev?=
 =?utf-8?B?TUViamkvU1E4WjVnNi9xeERxT0NEVmYyamZ0MW56V05QaXlYTUJvV1lSZ0Fa?=
 =?utf-8?B?ajB1MTZkSTlHYjhyMm1nOVcxQ1oxY01ReUM5WUpsdlQrUzdlZ0NIL2ZuMkFS?=
 =?utf-8?B?WmdCRmIraDEzd0R3VURtTUJCc2xJQVlNajY0UWxwdU5yY2lOdWc3Z3RHRVlq?=
 =?utf-8?B?UW1Hak9oMTJ1em9CalFRalRoclNtWlhGd2QxZ0s5OGEwUTM1SE9hYW9aTDc4?=
 =?utf-8?B?RVJwdWdpaUFiUUZZd21BdjUxTWNlNW94K2Z5KzhCamNNa1JrNWF5RlJza254?=
 =?utf-8?B?K3gvMDcrRzNrMkNxajE2YWVRZ3VQeG4wd0IrVDBTaGpKaWN4d0pFRjBpOUw2?=
 =?utf-8?B?VTBYUnl0anQ4UVVPbUlsZDFWenNqdyt3TzhMOGNLVW5YMmcwOVhPbUhLTzE2?=
 =?utf-8?B?R09xams3V1RkdnNaSTBRanBWUlUyZDBCR0IrR2UxKy9kOXVSQldzVlNYNngx?=
 =?utf-8?B?eTJpMmxpT0pVL0tIT1J5YVVTYS9IZE5mWE5mMWtiWGJpcjJVdjQ0aG9NajVt?=
 =?utf-8?B?bE1yVW1STGNVYTVRWk10NVYybGdwbVZOSTZHSTg2U1FYNXJTaEZ4aTRJdGk2?=
 =?utf-8?B?ZHdXZjFYbjlDN0kvNlZkd3hYSng0VTBweEhGVGcyTnBYMnZNS0lQZHVTU3pZ?=
 =?utf-8?B?WDMwOGhWVkx5cnZIUk9lL1dxSVFXby93Rk9wYndXWlJPRDlXUkFaZz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9ad1ac-3ed1-44a3-6202-08df09a8bfee
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 10:47:28.8881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N7EL0WEyTg1OwFUlzZwuxYn063r0lVbLd9PAgUi3+Y3mWMfODIvTGhUiUcdT5hQzYGbC463h81RgfBb+sGxnzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6664

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSyBWIFAsIFNhdHlhbmFy
YXlhbmEgPHNhdHlhbmFyYXlhbmEuay52LnBAaW50ZWwuY29tPg0KPiBTZW50OiAwMyBTZXB0ZW1i
ZXIgMjAyNiAwNzo0Mw0KPiBUbzogU2hhbWVlciBLb2xvdGh1bSBUaG9kaSA8c2tvbG90aHVtdGhv
QG52aWRpYS5jb20+Ow0KPiBrdm1Admdlci5rZXJuZWwub3JnOyBsaW51eC1wY2lAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBhbGV4QHNoYXpib3Qu
b3JnOyBqZ2dAemllcGUuY2E7IGtldmluLnRpYW5AaW50ZWwuY29tOw0KPiBrYnVzY2hAbWV0YS5j
b207IG1pY2hhbC53aW5pYXJza2lAaW50ZWwuY29tOyBTb25hbmcgUGF0ZWwNCj4gPHNvbmFuZ3BA
bnZpZGlhLmNvbT47IE5hdGhhbiBDaGVuIDxuYXRoYW5jQG52aWRpYS5jb20+OyBNYXR0IE9jaHMN
Cj4gPG1vY2hzQG52aWRpYS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIDExLzE5XSB2
ZmlvL3BjaTogU2VyaWFsaXplIHJ1bnRpbWUgUE0gd2l0aCByZWNvdmVyeQ0KPiANCj4gRXh0ZXJu
YWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+
IA0KPiBPbiAwMS1TZXAtMjYgMzowMiBQTSwgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToNCj4gPiBI
b2xkIHJlY292ZXJ5X2xvY2sgZm9yIHJlYWRpbmcgYXJvdW5kIGxvdy1wb3dlciBlbnRyeSBhbmQg
ZXhpdC4gRW50cnkNCj4gPiB6YXBzIHRoZSBCQVIgbWFwcGluZ3MgYW5kIHJldm9rZXMgdGhlIERN
QS1CVUYgZXhwb3J0cyB1bmRlcg0KPiA+IG1lbW9yeV9sb2NrLCBhbmQgZXhpdCByZXN0b3JlcyB0
aGUgZXhwb3J0cy4gVGFraW5nIHJlY292ZXJ5X2xvY2sgZmlyc3QNCj4gPiBrZWVwcyB0aGUgc2Ft
ZSBvcmRlciB0aGUgQUVSIGNhbGxiYWNrcyB1c2UuDQo+ID4NCj4gPiBOZWl0aGVyIHdha2VzIHRo
ZSBkZXZpY2UuIEVudHJ5IG9ubHkgZGVjcmVtZW50cyB0aGUgcnVudGltZSBQTSB1c2FnZQ0KPiA+
IGNvdW50LCBhbmQgdGhlIHN1c3BlbmQgd2hpY2ggZm9sbG93cyBydW5zIHdoZW4gdGhlIHZmaW8g
Y29yZSBkcm9wcyBpdHMNCj4gPiBvd24gcmVmZXJlbmNlIGFmdGVyIHRoZSBpb2N0bCByZXR1cm5z
LCBvdXRzaWRlIHRoZSBsb2NrLiBFeGl0IHRha2VzIGENCj4gPiByZWZlcmVuY2Ugd2l0aG91dCBy
ZXN1bWluZy4gU28gbmVpdGhlciByZWFjaGVzIHBjaV9idXNfc2VtIHdoaWxlDQo+ID4gcmVjb3Zl
cnlfbG9jayBpcyBoZWxkLg0KPiA+DQo+ID4gQ2hlY2sgdGhlIHJlY292ZXJ5IHN0YXRlIGJlZm9y
ZSB0aGUgcnVudGltZSByZXN1bWUgaW4gdGhlIHJlZ2lvbiByZWFkDQo+ID4gYW5kIHdyaXRlIHBh
dGgsIGJ1dCBkbyBub3QgaG9sZCByZWNvdmVyeV9sb2NrIGFjcm9zcyBpdC4gQSByZXN1bWUNCj4g
PiB0YWtlcyBwY2lfYnVzX3NlbSwgdGhyb3VnaCBwY2llX2FzcG1fcG1fc3RhdGVfY2hhbmdlKCkg
YW5kLCBmcm9tDQo+ID4gRDNjb2xkLCB0aHJvdWdoIHBjaV9icmlkZ2Vfd2FpdF9mb3Jfc2Vjb25k
YXJ5X2J1cygpLCBhbmQgdGhlIGVycm9yDQo+ID4gY2FsbGJhY2tzIHRha2UgcmVjb3ZlcnlfbG9j
ayBmcm9tIHVuZGVyIGl0Lg0KPiA+DQo+ID4gVGhlIGNoZWNrIGlzIGJlc3QgZWZmb3J0LiBJdCBh
dm9pZHMgd2FraW5nIGEgZGV2aWNlIHdob3NlIGFjY2VzcyBpcw0KPiA+IGFscmVhZHkgYmxvY2tl
ZCwgYW5kIHRoZSByZWdpb24gYWNjZXNzIHdoaWNoIGZvbGxvd3MgdGFrZXMNCj4gPiByZWNvdmVy
eV9sb2NrIGZvciBpdHNlbGYuIEEgcmVjb3Zlcnkgd2hpY2ggc3RhcnRzIGFmdGVyIHRoZSBjaGVj
ayBpcw0KPiA+IG5vdCBleGNsdWRlZCwgYW5kIGRvZXMgbm90IG5lZWQgdG8gYmUuIHBjaWVfZG9f
cmVjb3ZlcnkoKSBydW50aW1lDQo+ID4gcmVzdW1lcyBldmVyeSBkZXZpY2UgdW5kZXIgdGhlIGJy
aWRnZSBhbmQgaG9sZHMgdGhlIHJlZmVyZW5jZSB1bnRpbCBpdA0KPiA+IGZpbmlzaGVzLCBzbyBh
IHJlc3VtZSB3aGljaCBydW5zIGFsb25nc2lkZSBpdCBkb2VzIG5vIG1vcmUgdGhhbiB0YWtlIGEN
Cj4gcmVmZXJlbmNlIG9mIGl0cyBvd24uDQo+ID4NCj4gPiBBc3Npc3RlZC1ieTogQ2xhdWRlOmNs
YXVkZS1vcHVzLTUNCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGFtZWVyIEtvbG90aHVtIDxza29sb3Ro
dW10aG9AbnZpZGlhLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvdmZpby9wY2kvdmZpb19w
Y2lfY29yZS5jIHwgMjkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgIDEgZmls
ZSBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy92ZmlvL3BjaS92ZmlvX3BjaV9jb3JlLmMNCj4gPiBiL2RyaXZlcnMvdmZpby9wY2kvdmZpb19w
Y2lfY29yZS5jDQo+ID4gaW5kZXggYmQzZDc5ZDI4ZjI3Li45NTg4NGU3MTNhNGIgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy92ZmlvL3BjaS92ZmlvX3BjaV9jb3JlLmMNCj4gPiArKysgYi9kcml2
ZXJzL3ZmaW8vcGNpL3ZmaW9fcGNpX2NvcmUuYw0KPiA+IEBAIC0zNzIsMTUgKzM3MiwyMSBAQCBp
bnQgdmZpb19wY2lfc2V0X3Bvd2VyX3N0YXRlKHN0cnVjdA0KPiB2ZmlvX3BjaV9jb3JlX2Rldmlj
ZSAqdmRldiwgcGNpX3Bvd2VyX3Qgc3RhdA0KPiA+ICAgc3RhdGljIGludCB2ZmlvX3BjaV9ydW50
aW1lX3BtX2VudHJ5KHN0cnVjdCB2ZmlvX3BjaV9jb3JlX2RldmljZSAqdmRldiwNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBldmVudGZkX2N0eCAqZWZkY3R4
KQ0KPiA+ICAgew0KPiA+ICsgICAgIGludCByZXQ7DQo+ID4gKw0KPiA+ICAgICAgIC8qDQo+ID4g
ICAgICAgICogVGhlIHZkZXYgcG93ZXIgcmVsYXRlZCBmbGFncyBhcmUgcHJvdGVjdGVkIHdpdGgg
J21lbW9yeV9sb2NrJw0KPiA+ICAgICAgICAqIHNlbWFwaG9yZS4NCj4gPiAgICAgICAgKi8NCj4g
PiArICAgICByZXQgPSB2ZmlvX3BjaV9jb3JlX2FjY2Vzc19iZWdpbih2ZGV2KTsNCj4gPiArICAg
ICBpZiAocmV0KQ0KPiA+ICsgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiAgICAgICB2Zmlv
X3BjaV96YXBfYW5kX2Rvd25fd3JpdGVfbWVtb3J5X2xvY2sodmRldik7DQo+ID4gICAgICAgdmZp
b19wY2lfZG1hX2J1Zl9tb3ZlKHZkZXYsIHRydWUpOw0KPiA+DQo+ID4gICAgICAgaWYgKHZkZXYt
PnBtX3J1bnRpbWVfZW5nYWdlZCkgew0KPiA+ICAgICAgICAgICAgICAgdXBfd3JpdGUoJnZkZXYt
Pm1lbW9yeV9sb2NrKTsNCj4gPiArICAgICAgICAgICAgIHZmaW9fcGNpX2NvcmVfYWNjZXNzX2Vu
ZCh2ZGV2KTsNCj4gPiAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+ICAgICAgIH0N
Cj4gPg0KPiA+IEBAIC0zODgsNiArMzk0LDcgQEAgc3RhdGljIGludCB2ZmlvX3BjaV9ydW50aW1l
X3BtX2VudHJ5KHN0cnVjdA0KPiB2ZmlvX3BjaV9jb3JlX2RldmljZSAqdmRldiwNCj4gPiAgICAg
ICB2ZGV2LT5wbV93YWtlX2V2ZW50ZmRfY3R4ID0gZWZkY3R4Ow0KPiA+ICAgICAgIHBtX3J1bnRp
bWVfcHV0X25vaWRsZSgmdmRldi0+cGRldi0+ZGV2KTsNCj4gPiAgICAgICB1cF93cml0ZSgmdmRl
di0+bWVtb3J5X2xvY2spOw0KPiA+ICsgICAgIHZmaW9fcGNpX2NvcmVfYWNjZXNzX2VuZCh2ZGV2
KTsNCj4gPg0KPiA+ICAgICAgIHJldHVybiAwOw0KPiA+ICAgfQ0KPiA+IEBAIC00ODMsNyArNDkw
LDExIEBAIHN0YXRpYyBpbnQgdmZpb19wY2lfY29yZV9wbV9leGl0KHN0cnVjdA0KPiB2ZmlvX3Bj
aV9jb3JlX2RldmljZSAqdmRldiwgdTMyIGZsYWdzLA0KPiA+ICAgICAgICAqIGFscmVhZHkgc2ln
bmFsZWQgdGhlIGV2ZW50ZmQgYW5kIGV4aXRlZCBsb3cgcG93ZXIgbW9kZSBpdHNlbGYuDQo+ID4g
ICAgICAgICogcG1fcnVudGltZV9lbmdhZ2VkIHByb3RlY3RzIHRoZSByZWR1bmRhbnQgY2FsbCBo
ZXJlLg0KPiA+ICAgICAgICAqLw0KPiA+ICsgICAgIHJldCA9IHZmaW9fcGNpX2NvcmVfYWNjZXNz
X2JlZ2luKHZkZXYpOw0KPiA+ICsgICAgIGlmIChyZXQpDQo+ID4gKyAgICAgICAgICAgICByZXR1
cm4gcmV0Ow0KPiA+ICAgICAgIHZmaW9fcGNpX3J1bnRpbWVfcG1fZXhpdCh2ZGV2KTsNCj4gPiAr
ICAgICB2ZmlvX3BjaV9jb3JlX2FjY2Vzc19lbmQodmRldik7DQo+ID4gICAgICAgcmV0dXJuIDA7
DQo+ID4gICB9DQo+ID4NCj4gPiBAQCAtMTg2Nyw2ICsxODc4LDI0IEBAIHN0YXRpYyBzc2l6ZV90
IHZmaW9fcGNpX3J3KHN0cnVjdA0KPiB2ZmlvX3BjaV9jb3JlX2RldmljZSAqdmRldiwgY2hhciBf
X3VzZXIgKmJ1ZiwNCj4gPiAgICAgICBpZiAoaW5kZXggPj0gVkZJT19QQ0lfTlVNX1JFR0lPTlMg
KyB2ZGV2LT5udW1fcmVnaW9ucykNCj4gPiAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0K
PiA+DQo+ID4gKyAgICAgcmV0ID0gdmZpb19wY2lfY29yZV9hY2Nlc3NfYmVnaW4odmRldik7DQo+
ID4gKyAgICAgaWYgKHJldCkNCj4gPiArICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gKyAg
ICAgdmZpb19wY2lfY29yZV9hY2Nlc3NfZW5kKHZkZXYpOw0KPiANCj4gSXMgaXQgcmVhbGx5IG5l
ZWRlZD8gT3Igc29tZSB0eXBvPw0KDQpUaGUgaWRlYSB3YXMgdG8gZG8gYSBiZXN0IGVmZm9ydCBj
aGVjayBhbmQgZG8gYW4gZWFybHkgcmV0dXJuLg0KTG9va2luZyBhdCBpdCBhZ2FpbiwgaXQgaXMg
bm90IG5lZWRlZCBmb3IgY29ycmVjdG5lc3MsIHNpbmNlIHRoZSByZWdpb24NCmFjY2VzcyBiZWxv
dyB0YWtlcyB0aGUgZ3VhcmQgZm9yIGl0c2VsZi4gU28gaXQgY2FuIGVpdGhlciBiZSByZW1vdmVk
LA0Kb3IgcmVwbGFjZWQgYnkgYSBwbGFpbiByZWFkIG9mIHRoZSBzdGF0ZToNCg0KaWYgKHZkZXYt
PnBjaV9yZWNvdmVyeV9zdXBwb3J0ZWQgJiYNCiAgICAgICAgICBSRUFEX09OQ0UodmRldi0+cGNp
X3JlY292ZXJ5X2FjY2Vzc19ibG9ja2VkKSkNCiAgICAgICAgICAgICAgcmV0dXJuIC1FSU87DQoN
ClRoYW5rcywNClNoYW1lZXINCg==
