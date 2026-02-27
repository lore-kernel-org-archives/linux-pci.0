Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012025.outbound.protection.outlook.com [40.93.195.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A90330334;
	Fri, 27 Feb 2026 12:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772195783; cv=fail; b=oW/pOUjXVxhCZqDL10nhZpJ8CPFjbja1kSFbqPB80ErpWUtx5XsMdry6w4LxtnGT6Yh1eFVAIYZnAG5Om6kUbltwruB45MFC0ABU5Z0tKO3dGaOdSV1R6AQaZsKXHcWVNVUWxzPVi1T6em5rzlme3u8i/B9rqcuTcwk3m1OE9WU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772195783; c=relaxed/simple;
	bh=Cv9i6PWZf4kOlJNBUbQXQgecxSzI0sdACjqP2AXCBCM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rFld/aMY7PdKxSEwWWhRRGOoKQ0UCxkpJ4hhaQgLiVP9MkqMyrpIiSOtnOGeHx/Fd3lNROGmSA7Nd8UKjXOTQUAcWzFKWnCLk76wFIU/3Znn9M7vrHwoDI4oPhErQN2L6w8uIW3h1niHfJLwKW/oVMeeVUr4hZpk0sO75ZfkWqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jwtJ7/4W; arc=fail smtp.client-ip=40.93.195.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jwtJ7/4W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QmDMlSN12Jta+cjIsTX3lXcKQNR+H0+CAjzo/7Nhj8oWx4FdcO/UbEKPWm1CCq/8KpWr2ZIKLik37BmRwHu2ABjwIuHlUvSIqSFTUbgatkxf8DQdNZ6SX/1oObErJudCqbBiyTMmzDEyBgi7AU4PPAwmbg6EZfYZ8bCGxYmwAx7OhdHkikHpCmNKToEula2HTr3ic5Q1QQ1t6KG8gd2UGh6ihgywXiqG9quU0KPmvhBd+Um6tq1TaszUCYWry6icQyYBvmjkHuRm8WhdUBZMAo6yv808xHMKcoY/YZ4rgtxYa6YgMGUPciQoFBy7i017gLnPEeEzgymacIqvwRKzuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cv9i6PWZf4kOlJNBUbQXQgecxSzI0sdACjqP2AXCBCM=;
 b=ZFBF5v68YrKuw+CbzDPC+ZQPCBMFSBVEBYtrhPzSD+KN56a9+wzYETTyt7J78YPTrlgl7tEWORo2YZRJ1uFr7Xqrgawbq2L4jU2u6MEXnKNK5wCsKPfdOxJUCr1LvESbcyE6MVScU577coELsa4p+y3moIZsLcpbM2BVHeYPoxGvaTsbXx2qKq9gSMoE0cyssh2aq0wt1pTZSHnW9St9/Ra59dwKmp+2qHLNgXQP82dTVsVI4DpHPapGITayjf0ZWtH7NRGWmf2GI9aKG+JWWVb1PWr00Rpzj6U4C6JASpW0jG8l4+VuPrv/Jr2gfB/7LCq6o2zAcSb9ptHPggwBJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cv9i6PWZf4kOlJNBUbQXQgecxSzI0sdACjqP2AXCBCM=;
 b=jwtJ7/4W+eHvKDPS9vNHAja3N2O7uj8/lsDZMV3tK5S1y4r72QkQZ5GTjiAglOlpIT4NUr6Qr6wgv2UVfZozWgNNMQohVwWkICUOyQs8gbkw0VDp7n5FI+A3K5dhbh8n5adnB2/ATrQnuSHqf2x5N5NBdgJsPd261YaVOj1rVIcDbKuxoytbF1D41KI6KYrI8XhkIYd2eqTCDWihdVFTxMFl0zSYGZmhRgSRuu+W0gkTogRTHfB9Pjxg7WXiFKQXvqR/t6/lrOcJZNZfzErhpo4454iKnIhzwl0s0PQT8BPtuCTUIe2KEQ0jhC72UaxDpgs1CQT+wa9FziqSGBCHgQ==
Received: from SN7PR12MB6744.namprd12.prod.outlook.com (2603:10b6:806:26c::13)
 by BY5PR12MB4147.namprd12.prod.outlook.com (2603:10b6:a03:205::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 12:36:16 +0000
Received: from SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961]) by SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961%3]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 12:36:15 +0000
From: Vidya Sagar <vidyas@nvidia.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>, Jon Hunter
	<jonathanh@nvidia.com>, "kishon@kernel.org" <kishon@kernel.org>,
	"arnd@arndb.de" <arnd@arndb.de>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "Frank.Li@nxp.com" <Frank.Li@nxp.com>,
	"den@valinux.co.jp" <den@valinux.co.jp>, "hongxing.zhu@nxp.com"
	<hongxing.zhu@nxp.com>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"cassel@kernel.org" <cassel@kernel.org>, "18255117159@163.com"
	<18255117159@163.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 5/9] PCI: tegra194: Enable hardware hot reset mode in
 Endpoint
Thread-Topic: [PATCH v6 5/9] PCI: tegra194: Enable hardware hot reset mode in
 Endpoint
Thread-Index: AQHcpPTMd52sWRFUC0Wgee5LdeK9vbWWgWmA
Date: Fri, 27 Feb 2026 12:36:15 +0000
Message-ID: <667008b0-e2a5-47ab-a801-252e7ce6bf9b@nvidia.com>
References: <20260223184538.3084753-1-mmaddireddy@nvidia.com>
 <20260223184538.3084753-6-mmaddireddy@nvidia.com>
In-Reply-To: <20260223184538.3084753-6-mmaddireddy@nvidia.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB6744:EE_|BY5PR12MB4147:EE_
x-ms-office365-filtering-correlation-id: 1c9fd773-f4fb-49af-de9a-08de75fccca6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|921020;
x-microsoft-antispam-message-info:
 w3fO6Sqk/QbjPKqMqmm+csb7Dyl/Rv3i0Yy1LEdDUIB0fNyLh2tmw/Lmka2BkyNfCGUyyscTRn+2ixc/Hf2jfiY9QPnvgT5+5e3uX89HChlWse6UxxOryadHHorC/H6QLF6FjZW8SewGRe52ivzuxUo+ktKJbIrR9h8duF/KjeQdidnSOcE+S/qgqdANXTQzXpho1xQcqy2v+9lPAEMKZ17Cr0HSq36DQojZfPWehSAzD+Y9h0XCQuId/vOnig7g72kHYjWnVWIxpQTpRGgB/dCdmTTf2R4R1XNoCEu4elsH5BdJZoMfBHV3fG2eKiLS4TkYbtSV4dAXu4ViYypgqVIZaWl8WLJUx47IFweBSR6NbrxQsKhDCjgxAgfXtvcmHyIYubuq/S9fyFfuLk4domLbPgOROE90q4431ph6DMe7Deiq6KBAE4GI9GWgnGW/GjWoz3YLo4+O+R+JVUE2Ab9wDIBPJqTNOR06wzawsC8mOhOq5r2xyAx3wpVWQNcDF1at0cZwUfkb4NgpkfR9i6UXarWGO08UTEjheEv7aBijB76BnEa2f+nDHFT5Ei0JnwgZVK1x5pwV7HcnZ4bUypS4CG2S8ahAauPtov+YipTTFxA617LGSxmk9IkLPeoKIdhnl3GUXUInsXtXZ8dBJrcqBDv3ZvbJPYOb/OTCaymV+rlzMklyKMPuaYgP71uKamQ8xPqSgmdWhRBpE2QIrkPNFszRLEvW93PGcqZBmDvp1vfPnAV801x8i7UuxJga6znn1A3j3UP3Znv4rx3HaLRUbfbRLRBJUqa6fsdz33+cn78hyB3J8Ry8edJ+h46/
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB6744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MnBXb3Rvcm9TT0w4R2FSQTBJVy9BaFpPczBLUXBYSFhRUnBBbE1XTmNzQ3lw?=
 =?utf-8?B?aFh0cVdGNTZFSmdHWW1OWkttU3B4dEtaYzkyaENpMkFsQnFJbSt1TXBnaEEr?=
 =?utf-8?B?RWYwSldBZENrT2thTklTN3RzRzF2TUwxUnZNdzFrekUvUWVoV21JSHhWd2Fl?=
 =?utf-8?B?dUM1YmVEZGZYdFNyVGpvbGVXZUcxRW9RRG5Jdk9zTGQ5TGY1eHhrSENNblEy?=
 =?utf-8?B?eTZYVnRITTBrSnF4bUoxV2NHOWw2dkFlL3BtZG9jSTN3TWc3eDBHbGIrelJq?=
 =?utf-8?B?Vy91VWw3VXVlN0pid3J4ZEUzY2Y1eGk2dm1aL1NpL0VTNSttRFBBVHk2U2VQ?=
 =?utf-8?B?a01TanBPekhEdTRBNlM0dktPbW5lTmw1U0gybmdQaWNEWGIwSm5nQUVpdXFr?=
 =?utf-8?B?djZOQ1o2K25tRnVacTlQbFk1ZGVvWmx4LzlIRXRCRmJuSDVZcmlrdktVM1NU?=
 =?utf-8?B?cnZma3VXcUo0K3FoTmNWTGhyYXkwc3UyU0N6SkREV2RBdWZ2M1Q1RWllNDVq?=
 =?utf-8?B?TFpzbUErK1RIMWE1K0NHL3Uzd2xuaGgvK2VVVExVbjdGMTRqdGVGTkFJWmY2?=
 =?utf-8?B?aEk0cEMzVkdMQUlseW9ydWNYRDVkV2ViOGFFNk5nQk9KSXhqSXBWd2lTZlo2?=
 =?utf-8?B?dlNJNDJkeEh5TS91dStralJNREI5aHkvZ3daSVVxR09BVTJ6MFNIRnpUNEFS?=
 =?utf-8?B?Wm5GUmRZajZjZlZZUUNiSVhuSHg0MC9xb2oyU253ZklwdExjbEhoL2c3U0hL?=
 =?utf-8?B?YlVsUzF1ZHdFMnphKzBWRUgxL0MwZ20vcEdzaVpWZGROdFpiOWR3SnI3bmQ2?=
 =?utf-8?B?OFpzRlJkUnJCU2hzTnBhRFNsVk80RnNSQms3Q1lwNjdpdUJXRXJyaCtRdXYz?=
 =?utf-8?B?RkVQQjZ1Z3VNZnYvSmZGRjZsU0xnbFpGMkNDT3YxSENsZHZ2am5tU1pnY2Vn?=
 =?utf-8?B?Z0E1KzkyYzRPa0wvVmlOQURkekd0clp4UmJUQVFITU1qSXhkS2V0MW9qeTRP?=
 =?utf-8?B?bENUWlRWRDIrbkxNSXBhM0RvYndVeVBZazkrdDNhUGJ4eVZORER1WTd3THlw?=
 =?utf-8?B?NzNKL2IwSFlVanpJL2MwSWVEejg5VlJPNlova2hOKzBjYzJEWkZhQkFuRGov?=
 =?utf-8?B?QUZMVWRXSVVlVTBOeHBwTHQ5Sk1HaDFsS3luMjVOZ0xuRnNpNExJMEwvaW1R?=
 =?utf-8?B?Q0JrUXBLNnFQTEU4b2NaMVZIZVkxTFc1UDBncnRKbFFyM0JMd1E1VGV5RVR0?=
 =?utf-8?B?MlUyOWJ2b2llcEJBZzZOQXRrcGFhMFRGTWV4bjVzcktkMEhqMXRUN2xHOXZr?=
 =?utf-8?B?RWNKbkVoL042Nms1YnlCbzdudi9aMStRQzk4VEFBdWFsY3ZjUU1TUENXcUNm?=
 =?utf-8?B?UUoxdTVpUmZOekJ1N2s3VWZNUFZZakJJRnFjM0cwcjlYZmlxNU5HUGIyNDF4?=
 =?utf-8?B?WlhYbGNrMVZOM2U2Z1ViMmhlWWpCRVFvSTljaStMN0dVZjgyRXZ1NkdzRGRS?=
 =?utf-8?B?QWdhcWxxQzVndW1uZGY0c1BPU0ZrN1pZeit5bG4ySWZSajgwR1I0b0ZtZ3hW?=
 =?utf-8?B?U1YyLy81U1plU3dXSmdOUkU2TEtNcEU1WDh4c0ZRYXNUSlpFMmVhbmhaOTN6?=
 =?utf-8?B?ZzZsZVNydFRxZ3NFMW9qVzI1YXVJNElNcDQxd1ZoUTg2bVNLakZLWDZBNzc1?=
 =?utf-8?B?bDF5UDdnZGRlUUVnSHlEL1kzZTZTdTN3eElBOE9MUTNSaUFsUWtpY284OE9n?=
 =?utf-8?B?dXZvVVNqRnFzZkdDN0xEZWx0cXR0QmxQb1ZUVmpabzUwMHhHWlR1UzU4Uyti?=
 =?utf-8?B?M1ZMQlBSSDZlSHNFNUZOMkFGU2o3QlhPY1dENXRDbzlMUkxZd1hVLzFqUG1m?=
 =?utf-8?B?S2RIb0VqeHV1aWIzUm5XeXNzTkh4N1BCWTZFeFk0U3d0TTBCRGkxQ2lCc3I4?=
 =?utf-8?B?TzY1a3pjRnByaGhpNVZRZkcxbVBhZzJCQW1LWHVtZEVMdDd1U1lVNzJUbmwr?=
 =?utf-8?B?dUVRZXh1dHY5QXROamtMY1BYaStHNXN2RDZPOFRSS1pIbW5QZ3BGb21YYUh2?=
 =?utf-8?B?enR3TmVFd1pRVGZIczAxOEE1bDkxbExGdnp3TkFCcjlFaGFOaFN6ZWpDUkI4?=
 =?utf-8?B?SStPeTRhY25VbGNmdTFBbzl4VlBwSnFFK211Uzd0TUlGaEc2b0x2cnlON1Ry?=
 =?utf-8?B?b2MxQzJzaDJrWUlUYW9sNXVMMnJQZi96SkxWeVNhcjNvekdCS1ZwdnhJTTFG?=
 =?utf-8?B?YnA5clh0OFJqdlBUNlQyQ3ZvVVRvWkZnWm10S244QTF1bVpVYnplQWxjcHFq?=
 =?utf-8?B?WGNyZW94TStnMDMxWWlHR1N4STJURHJvNWpwQ21BN0ZZSUJXRExYZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B72581CF7589545BDC104B3E3CDA29C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c9fd773-f4fb-49af-de9a-08de75fccca6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 12:36:15.8765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WQO9sPckx+l4Pk3EREUbBNOd9khAaGiuufCholM3g9zXGl/lxeLFpJeaphRx0Ntj4g4djqQT42e+W8Pvwezp/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4147

T24gMjQvMDIvMjYgMDA6MTUsIE1hbmlrYW50YSBNYWRkaXJlZGR5IHdyb3RlOg0KPiBGcm9tOiBW
aWR5YSBTYWdhciA8dmlkeWFzQG52aWRpYS5jb20+DQo+IA0KPiBXaGVuIFBDSWUgbGluayBnb2Vz
IGRvd24sIGhhcmR3YXJlIGNhbiByZXRyYWluIHRoZSBsaW5rIGFuZCB0cnkgdG8gbGluayB1cC4N
Cj4gVG8gZW5hYmxlIHRoaXMgZmVhdHVyZSwgcHJvZ3JhbSB0aGUgQVBQTF9DVFJMIHJlZ2lzdGVy
IHdpdGggaGFyZHdhcmUgaG90DQo+IHJlc2V0IHdpdGggaW1tZWRpYXRlIExUU1NNIGVuYWJsZSBt
b2RlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVmlkeWEgU2FnYXIgPHZpZHlhc0BudmlkaWEuY29t
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBNYW5pa2FudGEgTWFkZGlyZWRkeSA8bW1hZGRpcmVkZHlAbnZp
ZGlhLmNvbT4NCj4gLS0tDQo+IENoYW5nZXMgVjEgLT4gVjY6IE5vbmUNCj4gDQo+ICBkcml2ZXJz
L3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLXRlZ3JhMTk0LmMgfCAyICsrDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9kd2MvcGNpZS10ZWdyYTE5NC5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpZS10ZWdyYTE5NC5jDQo+IGluZGV4IDExMGYyYWRiNzRkMi4uZjYzMDVhODgwY2FkIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLXRlZ3JhMTk0LmMNCj4g
KysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS10ZWdyYTE5NC5jDQo+IEBAIC0x
Nzc1LDYgKzE3NzUsOCBAQCBzdGF0aWMgdm9pZCBwZXhfZXBfZXZlbnRfcGV4X3JzdF9kZWFzc2Vy
dChzdHJ1Y3QgdGVncmFfcGNpZV9kdyAqcGNpZSkNCj4gIAl2YWwgPSBhcHBsX3JlYWRsKHBjaWUs
IEFQUExfQ1RSTCk7DQo+ICAJdmFsIHw9IEFQUExfQ1RSTF9TWVNfUFJFX0RFVF9TVEFURTsNCj4g
IAl2YWwgfD0gQVBQTF9DVFJMX0hXX0hPVF9SU1RfRU47DQo+ICsJdmFsICY9IH4oQVBQTF9DVFJM
X0hXX0hPVF9SU1RfTU9ERV9NQVNLIDw8IEFQUExfQ1RSTF9IV19IT1RfUlNUX01PREVfU0hJRlQp
Ow0KPiArCXZhbCB8PSAoQVBQTF9DVFJMX0hXX0hPVF9SU1RfTU9ERV9JTURUX1JTVF9MVFNTTV9F
TiA8PCBBUFBMX0NUUkxfSFdfSE9UX1JTVF9NT0RFX1NISUZUKTsNCj4gIAlhcHBsX3dyaXRlbChw
Y2llLCB2YWwsIEFQUExfQ1RSTCk7DQo+ICANCj4gIAl2YWwgPSBhcHBsX3JlYWRsKHBjaWUsIEFQ
UExfQ0ZHX01JU0MpOw0KDQpSZXZpZXdlZC1ieTogVmlkeWEgU2FnYXIgPHZpZHlhc0BudmlkaWEu
Y29tPg0K
