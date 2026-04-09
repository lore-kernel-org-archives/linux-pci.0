Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013039.outbound.protection.outlook.com [40.107.201.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622031D5CFB;
	Thu,  9 Apr 2026 03:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775704155; cv=fail; b=AUtJhMh3FZtZpVekg9vARjxNDZGQmo8GuDFVuoVOIe96gTI7MkzNaSw2oQeVxCwDr4yLkwET56VVcQWu6p/Y8BfCgBSpFigFxvPOUIJWOVS/PpJQhClO/zJGLEDoZXeyi4uvRwGjUYhTQDDqvrOP/y1yrFuPpnnn38kDUN1jJuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775704155; c=relaxed/simple;
	bh=VRIyi9/XT2I5nzJlJSDkIBAaqViQJIOlj/F42Qquw5A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fcPCHYLxyoyg45llvLaOd/oAZdlCOvfabfloTtuAURCBDDTWJwwja88rOjYCnyp4PeLetqwwCFJM8z+3ObnLt3S8bXHw/qNla1bPznrPMAn4IaA4wnCgr3YXfrx93Ki0HACQg6IGqFbarkNuRDVG+seoFDIl6nsRl9roKtW479U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CJ9bQw5l; arc=fail smtp.client-ip=40.107.201.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CJ9bQw5l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=capZfBAyWpNny1tTAQ9AkqUHpwdXwldRWICm4Ts3n2ebDVbrgD1bs2Vq4L1FO0zpArHBmVl47Bx9wgNsJkDIOfQ+1zo8ZxoND6KSKrU4PntsSHZIDRbhv8HiVfbbbJ0oMyw6O9ZxZB1Yncnyo8eicB+9lTXq9+cxh6LYo9yTbANL25ZYB50oFnsXs66nGy/TBGONoLA3Su3GTu0C8D9qj+/0eq0qBTdl5CPTfpRK3tRFt3Rs0uKzc/xDPPbaLYxXkU7HiA5G/EpATphmDPXm4l8Q0oHPH8o9nhnL+qXwsJyPiZbE3uX6ZLHdQQ25tZ3eSZf1GICJWjmImLtehNqgXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRIyi9/XT2I5nzJlJSDkIBAaqViQJIOlj/F42Qquw5A=;
 b=uaaRBdSUXKTYZ7DzfbKAO5w78J14T7D5q9QXANfeHUg9cTEChUgWtKQ+nmqsnX5bNwZArw2W3WHiJAUPe/5Hp6oA4KK6twBaACC8WPMrMsLHX61YUJppCA9dP//FEDsG71ICmWswbl5QPmTsAsHd4DEMaSNreYBOar2MpYf+z9VO3aP5NJOb8yr+OmsY3cm0LKzOKfbc0DgTupXtFmE4wD9XydzUgCgSj4LZK5dcjzVQ5HUVxghfqsA2dWvpAQeJP0WtiKxV9FUgkhuoQQsoS04YXiTjke+57wm4X1GF31fzF1eG/iv1tpXsnWOGfCLVOxr/AWztNzTJc7z81h/7gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRIyi9/XT2I5nzJlJSDkIBAaqViQJIOlj/F42Qquw5A=;
 b=CJ9bQw5l/qAIvCuRI4kG9l8kUd5sYTxiYVVsTb3hY6uNLv1moJh7fHM59Menlgp8c9EK7xzKTNpFu6aZxBIfUG4ExiXKOGlZU34QWEQOiVLmUSDuXZIZd7OXo27MqrFhpx2NggUU25yQLagiYTEC4ys2xgCxkILPtehJXLflmLU=
Received: from IA4PR12MB9810.namprd12.prod.outlook.com (2603:10b6:208:551::13)
 by CHXPR12MB999243.namprd12.prod.outlook.com (2603:10b6:610:2fc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 03:09:10 +0000
Received: from IA4PR12MB9810.namprd12.prod.outlook.com
 ([fe80::2d21:ba94:fd95:5b0f]) by IA4PR12MB9810.namprd12.prod.outlook.com
 ([fe80::2d21:ba94:fd95:5b0f%5]) with mapi id 15.20.9769.016; Thu, 9 Apr 2026
 03:09:10 +0000
From: "Musham, Sai Krishna" <sai.krishna.musham@amd.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cassel@kernel.org"
	<cassel@kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Gogada, Bharat Kumar"
	<bharat.kumar.gogada@amd.com>, "Havalige, Thippeswamy"
	<thippeswamy.havalige@amd.com>
Subject: RE: [PATCH 2/2] PCI: amd-mdb: Add amd,versal2-cpm6-host compatible
Thread-Topic: [PATCH 2/2] PCI: amd-mdb: Add amd,versal2-cpm6-host compatible
Thread-Index: AQHcwsusM8A+AujgCU2xltvvcRC9yrXOPRcAgAfQ8iA=
Date: Thu, 9 Apr 2026 03:09:10 +0000
Message-ID:
 <IA4PR12MB9810793B69CDAFEBF45411AECD582@IA4PR12MB9810.namprd12.prod.outlook.com>
References: <20260402180006.486229-1-sai.krishna.musham@amd.com>
 <20260402180006.486229-3-sai.krishna.musham@amd.com>
 <iruxyxjoaozkt5xigchqnqvik5blbxxy7vubmadtcn5jyjnwzn@lvdnttblbx3f>
In-Reply-To: <iruxyxjoaozkt5xigchqnqvik5blbxxy7vubmadtcn5jyjnwzn@lvdnttblbx3f>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-04-09T02:57:14.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR12MB9810:EE_|CHXPR12MB999243:EE_
x-ms-office365-filtering-correlation-id: c3658411-e2e4-4c91-ab0c-08de95e55f07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 GYhJ7xZIJerfhQKLCuxBcO99qZMb+L6fKRiSDrKyWdEAKOfEmc+0c7Gxm4XiRrUYfFGN2V2y7Vf5rE9FXrGK2wzOaoMsvDqeFs6gCunxo+7IF7cHVS7TpTZB9nR2M/acs+0HaMue1ymvvvTpVDoYjO9Qp9z6xsrMdzbOn+F4I5GwXqm6ONftmY/XZcbXOzx5OeVSLZPR4OEOym79JlyWRXBywy14H6qsin/L9/KAX0CO01txDfdkcAE3/8NeC49RaBJBBzDmEerCccnaXDeH4rhx8MlbvfIHIbwKg3TDGLMUv1jP8OujHZIhIQZ6BkfylDDuqcZT+4/fo3QIzgAtTmn+KWiTdEDDS4U4bpWjA6+QrvIBRkrvLDR3t8OHh0E9I//C5zkK43U+OxNDJeecnRKzGG/QSodSPCBQY/cPXpJx/7+iQuPTe58djcCOBNujzX53qu/16EAZf/TbS+Z18lXJNPw9+CVQc8kO4KDqKJKw6yRFj26tOyAZ7ueu9CkqiqBjJJw8F9T7DyrHvHC7e3HNBGusG82lJ0wLYgCvwvqFg4isn66vDBpRvEe8xX+hqORSb1o/iOCAiaRneiJYdkgzzVNZTxGWO1dlg14SsTxU6lTWeiLYxX3L20IChzcSyuxiUOuTyq8xQm9fgMK7H5KyspKPelr5KYld3agWO1Sui+w9yYFSbOUPcrsrIGyvVRy1TN+gqrwiD92xqGK3TIXzOIzTl1CLjG4PLAqDhqyAvqMmd46UUIPKaW5RbjyGO20LbRqSBQUrC4wSbQrzeAowXmiLj58ch59OYzQtdrA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR12MB9810.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VEFxMzZSQTVTN002czdRTkpJSmdYeXorOFpoNGJ5ZTBPdk54ZUJjYi9xVkNt?=
 =?utf-8?B?bGtYMDZpNVlaK0NRZnFBb1lMWlljaHJiTDR3NmlrbEx6R0xhUXRDbkZZMG1H?=
 =?utf-8?B?eXFwVmxrNlFUZFBQdTl6QlRwZUdRQ3U4bHYzWkRjUUdYa3NueEV1WFVlZWJ6?=
 =?utf-8?B?T0xORXJTRUN4RGQveHdIZlByc3l0ZWY5eDJENjdFSTdJN2lMUzhrUkY5UFl5?=
 =?utf-8?B?bWNSWFFCUFQ5TFlCckkvaFYxSjhYSVJMMTJENHBjNDdlbzhnSkxiazRJcTNL?=
 =?utf-8?B?M2xRRktxUytqTGc5S3hlZGlVQ20zRCtyWUxJVWtndHZKTXBDSHNNVW5DcUpa?=
 =?utf-8?B?S1gzTStwdllLanI2TXlXY3hScENrd2hIRkFBZmdGWlVOK1NtMmZmdTRFUW5S?=
 =?utf-8?B?ZXUrK2NxZm04cmtyV2lUL1lTUXkzZGJBYkU4NTNaMlh1cEhzQTRtSklzMVEw?=
 =?utf-8?B?Z3VaVnN3ZWVNbmV5K3dEVEMxNTgrMTg3SzNKVFFxSXJ0Y240endOMDZrUEtS?=
 =?utf-8?B?VXROcW5Yd2pCRFRlaXA3UzQ4bmcyRktVd0N1c3g3eUw4SnpVQ2N6Wmk1bmd0?=
 =?utf-8?B?ZHVuM0d1OStGYU92Y09TeFJHSExZaTNJNU1wam9PeFZwSExGUXRUdXovVjBl?=
 =?utf-8?B?Q2I1bm5rTzZtTzdxUFhLaHRQNDYwRmpMZ1h3Z2V3NE5Ia2YwRFVVb0h6Ly9n?=
 =?utf-8?B?M3ZRa3V6UHZmbEVXZUNucjZrS1lyTENqSDI5MWg5cHl4MEYwSFNDU1BhSUc5?=
 =?utf-8?B?U0podi9ISGR6eXZ1dmdlTEozcFJtRUtYa0ZhU2NhVHgxaGdNM0dVelUwMGQw?=
 =?utf-8?B?emtvbmJHdmtaSzlYd2xpVks0dkNCMVVFRUZONjlLdmkxcCt4cjhJS0dJOEY0?=
 =?utf-8?B?NnQvMWJ4LzBaendMWHNpbHpJTUVUOUR1eCtmUWlSc01LSWFDSlRkblpvYkhh?=
 =?utf-8?B?c2VhdHo5NDUwRWxNVGo1Sll6bElZelQ1aUlLcUdETklEK3JkazNITWVPQlBJ?=
 =?utf-8?B?SnFyT2Z2L2pNT2E5WE12R1FDK3BTMHBoZjNIRURKVnZBNnVhQnlnSU40RlFY?=
 =?utf-8?B?TnNnQlgrSmduNmk5am1ZMTgwQ3kyb3grMkc1VkR1dnNLSDFSOFlOMmtSVFZm?=
 =?utf-8?B?TTlEUVVlTXo3bjMzdzhoYXZoY3lKT09UQmZpSEhqdWdwd2g4c1RYdHZ4dTUx?=
 =?utf-8?B?MmlUZmJnZis4blpHVWpDWkJCa3JCdmgyM0FlMGs5SS9UMHBVcXkvTE1lRXpH?=
 =?utf-8?B?ZDdDZC9oL05xQ05Bb1FnK3ZPaW9uNWtxc2dkTWVCRjdMWUVKQldwVkRtQ2E0?=
 =?utf-8?B?WC93U0hYTVBhQXk5ZGpXWFVTd2JoUFNYTzZQRU9leHBYUmNxNWpUbkVVSDJj?=
 =?utf-8?B?YmplNElvbkJUTm9ROW1PUXN0UzNMVXZheVZCeFdUeXdvQStYZVZsTXdjNXZE?=
 =?utf-8?B?ak9RTElhVXQ5Y1o5YmFRS01mdXJoVjFPNU84YVhDU0xINVg3RHo0dGtTOGJu?=
 =?utf-8?B?Y09DRmRYT3U1MDhEUEQ1R2lsblZPbWdENmgrZ3p0Z0ZLaWJXWkVtWWNDdGFk?=
 =?utf-8?B?WG1pUzlJeis4MEYzTVAzOC9VSXVOU3JSTk5VbGsvUkoxOVBMeDdtQmxTS0Fl?=
 =?utf-8?B?dTQxMkVTVHJVZi8xVnNZOGZvQWFydW95c1RmUUt4VEY0dDdhYTlobXpTcUo5?=
 =?utf-8?B?QmE1SnJTRTNoSlhzc21YMmthNlVGS05XNlZWSythYVlkNGZ2c0xwK3VhYTZK?=
 =?utf-8?B?RHB2MDYwNE5hQnlwakpoa2xUMlMzVEwwL3ZkRE8ydkxQa2h6dXh5N0x3cTYw?=
 =?utf-8?B?ZGVURGN1VTh4elBOR2NUS0hQWGV1L2xtUXlabXpkOTFzR0VrSXdiQjVhYWZY?=
 =?utf-8?B?U3NHM2VWY3IydVlNWDFtMHBUeEU2NnM1UW9RYit6aGc5SVBubWs3aVF2SjFG?=
 =?utf-8?B?LzVLdmU5ZTRNQmIweUx5QlBPZ3dWNlU2WWlBbHRUMTRqZXdjWkl0ck5kenQ4?=
 =?utf-8?B?aVZVNys2L0pHbTVLcFkzWHFQL2o0ZzdmZ21VOG9NeGlJRm9VSVpkQyszNW9n?=
 =?utf-8?B?NTlmU2FDYUYxMnZ4S0kyTjcxQjJ6TVFJbHJ0ZTdqYkJzUXZqUzY3NCszdmht?=
 =?utf-8?B?SHpnU29vN2VMU1FsV0JtazZjNlNwNEZxdktiYzdIN0ZiblljRVpGeS9yVUNa?=
 =?utf-8?B?L2dWTzNIWFpKdFN3VzdFaHJsZzhDRW9HVWU3eUVKRVFRWUNveVl3VVB3dTJi?=
 =?utf-8?B?RHVGYWFnOHBwV1ZMdkJuQ3ZlMnZzaWdCK09UK3U1SkZoYno0M0lIKzNJSVM3?=
 =?utf-8?Q?2e9t9azcxL27cgvBqj?=
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
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB9810.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3658411-e2e4-4c91-ab0c-08de95e55f07
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 03:09:10.7183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: augcyGfs3c9yWAYVjvGNc0qt0y9XiPEPbc/h8xfMQJ0mqaXhkaY0GQT3YeVQs/0JGPJmXSaj5ydaSlDRjeWUoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR12MB999243

W1B1YmxpY10NCg0KSGkgS3J6eXN6dG9mL01hbml2YW5uYW4sDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFuaXZhbm5hbiBTYWRoYXNpdmFtIDxtYW5pQGtlcm5lbC5v
cmc+DQo+IFNlbnQ6IFNhdHVyZGF5LCBBcHJpbCA0LCAyMDI2IDg6NDYgQU0NCj4gVG86IE11c2hh
bSwgU2FpIEtyaXNobmEgPHNhaS5rcmlzaG5hLm11c2hhbUBhbWQuY29tPg0KPiBDYzogYmhlbGdh
YXNAZ29vZ2xlLmNvbTsgbHBpZXJhbGlzaUBrZXJuZWwub3JnOyBrd0BsaW51eC5jb207DQo+IHJv
YmhAa2VybmVsLm9yZzsga3J6aytkdEBrZXJuZWwub3JnOyBjb25vcitkdEBrZXJuZWwub3JnOw0K
PiBjYXNzZWxAa2VybmVsLm9yZzsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFNpbWVr
LCBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPjsNCj4gR29nYWRhLCBCaGFyYXQgS3VtYXIg
PGJoYXJhdC5rdW1hci5nb2dhZGFAYW1kLmNvbT47IEhhdmFsaWdlLA0KPiBUaGlwcGVzd2FteSA8
dGhpcHBlc3dhbXkuaGF2YWxpZ2VAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzJd
IFBDSTogYW1kLW1kYjogQWRkIGFtZCx2ZXJzYWwyLWNwbTYtaG9zdA0KPiBjb21wYXRpYmxlDQo+
DQo+IE9uIFRodSwgQXByIDAyLCAyMDI2IGF0IDExOjMwOjA2UE0gKzA1MzAsIFNhaSBLcmlzaG5h
IE11c2hhbSB3cm90ZToNCj4gPiBBZGQgImFtZCx2ZXJzYWwyLWNwbTYtaG9zdCIgdG8gdGhlIE9G
IG1hdGNoIHRhYmxlIG9mIHRoZSBBTUQgTURCIFBDSWUNCj4gPiBob3N0IGNvbnRyb2xsZXIgZHJp
dmVyLg0KPiA+DQo+ID4gVGhlIFZlcnNhbDIgQ1BNNiBob3N0IGNvbnRyb2xsZXIgaXMgRGVzaWdu
V2FyZS1iYXNlZCBhbmQgc3VwcG9ydHMNCj4gPiBQQ0llIEdlbjYgb3BlcmF0aW9uIGF0IHVwIHRv
IDY0IEdUL3MgcGVyIGxhbmUuIEl0IGlzIGN1cnJlbnRseQ0KPiA+IGhhbmRsZWQgYnkgdGhlIHNh
bWUgZHJpdmVyIGFuZCBtYXRjaCBkYXRhIChOVUxMKSBhcyB0aGUgZXhpc3RpbmcNCj4gPiBNREIg
aG9zdCBjb250cm9sbGVyLCBidXQgQ1BNNiB1c2VzIGEgbmV3ZXIgSVAgcmV2aXNpb24gYW5kIGRp
ZmZlcnMNCj4gPiBpbiBsZWdhY3kgSU5UeCByZWdpc3RlciBvZmZzZXRzLg0KPiA+DQo+ID4gVXNl
IGEgc2VwYXJhdGUgY29tcGF0aWJsZSB0byBhbGxvdyBDUE02LXNwZWNpZmljIGhhbmRsaW5nIG9u
Y2UgbGVnYWN5DQo+ID4gaW50ZXJydXB0IHN1cHBvcnQgaXMgdmFsaWRhdGVkLg0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogU2FpIEtyaXNobmEgTXVzaGFtIDxzYWkua3Jpc2huYS5tdXNoYW1AYW1k
LmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1hbWQt
bWRiLmMgfCAzICsrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1hbWQtbWRi
LmMNCj4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWFtZC1tZGIuYw0KPiA+IGlu
ZGV4IDNjNmU4Mzc0NjViYi4uMzI1YmY3YWFkNjU3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtYW1kLW1kYi5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9kd2MvcGNpZS1hbWQtbWRiLmMNCj4gPiBAQCAtNTExLDYgKzUxMSw5IEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkDQo+IGFtZF9tZGJfcGNpZV9vZl9tYXRjaFtd
ID0gew0KPiA+ICAgICB7DQo+ID4gICAgICAgICAgICAgLmNvbXBhdGlibGUgPSAiYW1kLHZlcnNh
bDItbWRiLWhvc3QiLA0KPiA+ICAgICB9LA0KPiA+ICsgICB7DQo+ID4gKyAgICAgICAgICAgLmNv
bXBhdGlibGUgPSAiYW1kLHZlcnNhbDItY3BtNi1ob3N0IiwNCj4NCj4gQXMgS3J6eXN6dG9mIGNv
bW1lbnRlZCwgaWYgdGhlIFBDSWUgSVAgaXMgY29tcGF0aWJsZSB3aXRoIGFuIG9sZGVyIHZlcnNp
b24sDQo+ICdhbWQsdmVyc2FsMi1tZGItaG9zdCcgaW4gdGhpcyBjYXNlLCB5b3UgZG9uJ3QgbmVl
ZCB0byBhZGQgdGhlIG5ldw0KPiBjb21wYXRpYmxlDQo+IHRvIHRoZSBkcml2ZXIuIEp1c3QgZG9j
dW1lbnQgdGhlIG5ldyBvbmUgd2l0aCBmYWxsYmFjayB0byB0aGUgb2xkIGNvbXBhdGlibGUNCj4g
aW4NCj4gdGhlIGJpbmRpbmcgYW5kIGxldCB0aGUgZHJpdmVyIHdvcmsgd2l0aCB0aGUgb2xkIGNv
bXBhdGlibGUuDQo+DQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4gQ1BNNiB1c2VzIGEgZGlmZmVy
ZW50IERlc2lnbldhcmUgSVAgcmV2aXNpb24gYW5kDQpoYXMgZGlmZmVyZW5jZXMgaW4gbGVnYWN5
IGludGVycnVwdCByZWdpc3RlciBvZmZzZXRzLiBJIHdpbGwgc2VuZCBhIGZvbGxvdy11cA0KcGF0
Y2ggdG8gYWRkcmVzcyB0aGVzZS4NCg0KPiAtIE1hbmkNCj4NCj4gLS0NCj4g4K6u4K6j4K6/4K61
4K6j4K+N4K6j4K6p4K+NIOCumuCupOCuvuCumuCuv+CuteCuruCvjQ0KDQoNClJlZ2FyZHMsDQpT
YWkgS3Jpc2huYQ0K
