Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013020.outbound.protection.outlook.com [40.107.201.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8787930C343;
	Fri, 27 Feb 2026 12:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772195806; cv=fail; b=HbC4ak1eSXkEq2eqFNLJ5dNoikucWjkj8sj6kywLA+BEs9r+DfAsoZz1Gah8ra9PirQnoU+CHWqjxgkwAIiiUhg6YCgMUseX4Qq12i9HhTk+GDh5gx32RiSLhrAmODMnTCOkajt9fFfB0NB8pJ8/MZpe7dDQCFQyZbZpDqifA2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772195806; c=relaxed/simple;
	bh=oLqPwXVeAqU/ybos/u4Xkytd1/+jPQCuctVZYLaFIFE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NSNEfEtjejKaRvpC693BU5AmPFV7PT1ukym4dIWD2vjswnncSy9ZDpJyqea2K7noTaGQDZWbxcKLGazpu0QPuQ7OS3p0Mct696Kn+LswzOwfk8oo2SmYDsZsndJ+LdTcLalNkrxYPdsBQsX18LSkLkA/K329u6UoysPSyO9B/Hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fyaSruZQ; arc=fail smtp.client-ip=40.107.201.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fyaSruZQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n9eW0TAiD6SwzU7N+Rk6i8fQRPfkqAWs1XMHy45dTAwSqh3Ml8ivB/yOzoJVBu8ESAM7WhWLbEDepP2W7XMZTMjI9/vBrblNAyDnfDaEyBSku5cR5oyeQuynGOm0aL+NBlNkw1GpMvl8bS8gWsoxFF1sdKgH9DY0OBAPmjRt6w00L1gV2mLEYIZthWSkhLnPjUtfOgaPJDnFSXLrfal5/r0QhzTq26axmS0QS9iNepwMNIP3N/hBGHueQskWtl+fRyJe++ScKFyz69cW42KcTuV4hw6QM6n7Tz8WJ9me6yb/kVETMzHX/NJKGfQEEJW3IhviOQDFy8Q/jtyMMqUozw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLqPwXVeAqU/ybos/u4Xkytd1/+jPQCuctVZYLaFIFE=;
 b=EDbDwe31fVOlrKpOJWSibCfIDa1jtJt4UxJmspqPiWIKFxdv77R27khETZiY6THPnHwwZg2FIVercdhARa9kCKbIDUmIHjjTYC/nP+Nx9kRLt4qR7XV7rErisCZDQlsatG98NMCsS3UXgOpcVc2KTsiSSDqLVRToxvwHJvSg2lgrAkW5+1rjaeVQk29KFvDZnVwoWyhrxHhRkU+DN8o61ExCQXy2tCCxy2VDO50K7cjIZ257JUu3W8U0OSxncecCoVQuEZ19ybVLElJux6+DL452lnM5Isbc7PDbC5dslAgmRqdIPXf1vcgNOtCQi/jMCPbfFsWOvDdCyFpcQmJn3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLqPwXVeAqU/ybos/u4Xkytd1/+jPQCuctVZYLaFIFE=;
 b=fyaSruZQD5OaWjZJln3QPr6PdpeGtUrhIZ+/tPB0l6NH1q/r6OYNpL6wFleVFC1HEm7Uud611ZYD4dm9NZi+7YJfMrZc5gUG20NBRPpQ1PNKLtReUcXiO2O7AB6urXPo95+PJLAdIJ3Rnt4ciKjNiIHFkB+5C1k6oFPgVazh3Z6fDIJE52gA2dzetVUWq2F6Z6gmoYZCPr4N025o6bqRbJAbwA9PuNC6SMmIf7gIxMMFG+KuxiI6cscUuO6xUz5UUk/sEsCZyMDdIZ9bzDiVK9zxXWihfXv6U7FuGk48PMOgTi5NpGL22YDTjph4txmDtRLshhyRwvm1EFwgiIzalw==
Received: from SN7PR12MB6744.namprd12.prod.outlook.com (2603:10b6:806:26c::13)
 by BY5PR12MB4147.namprd12.prod.outlook.com (2603:10b6:a03:205::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 12:36:41 +0000
Received: from SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961]) by SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961%3]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 12:36:41 +0000
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
Subject: Re: [PATCH v6 7/9] dt-bindings: PCI: tegra194: Add monitor clock
 support
Thread-Topic: [PATCH v6 7/9] dt-bindings: PCI: tegra194: Add monitor clock
 support
Thread-Index: AQHcpPTTBVrl0/wEUUir3uXK32gZ27WWgYcA
Date: Fri, 27 Feb 2026 12:36:41 +0000
Message-ID: <432d8a74-b954-42c1-92ba-2a401315f327@nvidia.com>
References: <20260223184538.3084753-1-mmaddireddy@nvidia.com>
 <20260223184538.3084753-8-mmaddireddy@nvidia.com>
In-Reply-To: <20260223184538.3084753-8-mmaddireddy@nvidia.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB6744:EE_|BY5PR12MB4147:EE_
x-ms-office365-filtering-correlation-id: 0d52cce7-08ff-44cc-8143-08de75fcdbd0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|921020;
x-microsoft-antispam-message-info:
 8PqIYPhTjcD/yIYwkP0kpJYLw7LtSUX6QkjkHLaEZK6d0OFt+KHcdKyUFmoec6Guct7WEszWAJbTlIsiYxIWaM7TAURDFB1/NH6z2f5f+ESqt1Ffx93SSeIbhq/U96a10ry/GjAaJtHoKKB95sJ/1oosOpa8YHZYU4QlD28dNow8o21Hf5gsYs1t1TBJDw9PKopDvhZLaFIDfPi4gQKMQSCK596+gxtqDVBOkcloO6FIWtMw2V8KBKHxCfJQ0yDn8D6mwcyEeNFhHUgtA/kJ9/gliHAivOuS+0b04jlLsHHG6SNl1qdez8GxuPTY7z16KmxZhCQJQ2KYd0h8AoD8Tc5yBo3kAeGQFUA4tUOrLnQEzpcE5IMjtg6JBVla2dAvdUhm/YXUjSF+lT3OwhPAovJMFCNpts0onkCtNogsB0Aleb+1QBn+Vgp/saIn6PBFongE4VhUNuSgEKW9/6/figHAbHq0nyrCbFpzf91fqUHqWV15QHpsYJu+lLdQDBUo8mnOoLqIDpYCBAuFRxIuoSzlLm+Y+zR23mAS1yIzStqoDx6ehgffiuvw8XPWb+BBcs4jT88cHnzv08SVNtFm8iAWvXrRbQt0l9KvAs6fvVULA65zEfgbVEiR4juEqKf2ERVM8+4GAjdDNmzHr1TTXwaXOh9RBoN9tVeQoKcluHOMmBXjfeIuZEVkP8irD/7kFrGAEILMb+9RP79/RqEmtSPB5DxZqvknWHZ4OG9bk8oCc9Bhic+RAm70BIl55ET/S27I07pDEsAlKJh3zfl6oycUB7yQNQU+5GqFiKTTVvrsmbPOVMkS2UewcXE7sx8a
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB6744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QWd5eWJBSzlIQS9LR2h3VUlndmpKZ1gybmM3MjdERXJKaGlza3U0R1BMR2F2?=
 =?utf-8?B?REo4NHNGcEJpMzhmSEZNSTBUOFNOKzNwZlJWU3V6dkFNT2lhOXl2ZFY3Q29y?=
 =?utf-8?B?aGg2M2dkeDNGcWtrYkxIWGhhWkdsZ00yeVBsWUEwQTRXdU8xOGRmUEl1eHRy?=
 =?utf-8?B?aDRYb2FNYXlWY1lHZlZHWHRTZmZsa2VMbytQK2NKYjFramhHU3hWUTNJODVu?=
 =?utf-8?B?dGJaa2d3eW01cVVBbzc5c3ZReVJ5SEpOWjZBYVpqLzNPOHR1VnFjRjdjSFlU?=
 =?utf-8?B?a21SbWtreFMyMW51Nmlvc0VGV2xpbE41eHJWZUpudWRTNlg5QTdCeU5XWTZs?=
 =?utf-8?B?V01TWVFWb0h3bUhEQ0JtVTlFYzBKUkhyZmtBUnpjUk1yY1dBY0VZa0Q0enEr?=
 =?utf-8?B?bXJveDc1bHorWm1KMFA1eVE3dnVhYTZoVEVGcHR6S2xZckJaQlFYSUFGVm0z?=
 =?utf-8?B?QllKR052ZlpqelVBdnJUL291M0hoMm9jY3RxZDl4aXp3bEN3OUhoWFFHMDF6?=
 =?utf-8?B?MHplWm1XMnpFZlVBdkQvOGxBNXhpcU1kK0s3dHpldlQybkl6VWhSK0pBQ2xL?=
 =?utf-8?B?YVNmRlNtRE0xTUVtK2RRQU5hdytlb3lQaWxRT0owSFJ0eGNEQThselJVdWFR?=
 =?utf-8?B?aE9CZVh0MU5rVzhtR2VZRVZjV1kwN1IwZEx6K1ptNEpZWG9IWGp2WDJDZXk0?=
 =?utf-8?B?YnBuQXBxZ0EzMXhSMlNoMExiU1hOUkdPT29WMnE3OHpIbXl4em5JSnU1ZC9G?=
 =?utf-8?B?VEVNQlpsU1dEYU9uSEVTcm9COXRGWGtWeFZqaTd0TlJvRlhPSU1tSGxDbXJm?=
 =?utf-8?B?RFdwWElTZlRuWksxalh0NEZpRkZQNmc0L2dyNTZXM01KZS9TYjZyM3RlYzEw?=
 =?utf-8?B?OE4vOW1nVmdrVTZaVi9Nai9mWThGSXZSaEFMT0ZuTTRIbXVIbXlSVzFqQ2cv?=
 =?utf-8?B?VWZCdzcwa2dpcVVlRFA1ZXU2RDBQMGFySUlyeWM3bTRETWY3WUQvbUxRaEFq?=
 =?utf-8?B?UkkrYjRBSW0vMFVIbS9CdjRUMjh2WmNJQS96Vmx6bUFrRnFrTXJRZkdOUkZw?=
 =?utf-8?B?Tmg5Y2JoV01vVk54ODdUYjVuQUxRNitQNFFwaGRJVUo5SStQYndQbEZGZEJu?=
 =?utf-8?B?bWRaeGZ2dlo4TTA3ZC9TdWM0VTY0Nnp6NXpweUJKRmV2QmdGN2J3Z0hNbDBD?=
 =?utf-8?B?aE1PWGdtUnI3TTBPdkVEVnY2T3FGbEhwUVRqNWRHeklxWFVTVmwxWXBrZ1Rl?=
 =?utf-8?B?dE1kd1BoMHBIL0piQXR5MXNaUmo0OUZRUjNvSmFqTm9xRllndFIzL1A4Um1y?=
 =?utf-8?B?aUhvSjFkeEU4ckRhY2MrOEt2akFhbFRwYk1wQ3VrMXZuWWxKbE5qaGNCTGk5?=
 =?utf-8?B?dWVUTjdxNGNldzlhMkppd3BzU1NIaEpGUElDWXFUZy8vS3orOGYwbDI1eVo3?=
 =?utf-8?B?bFpYSHZLV3hyT2hJbTdkM2JsTEtLUDNCYktWODMybWZIS3ZGNmNONXcrdlJE?=
 =?utf-8?B?RWM5NXdvNXhsdzFXMytyTUFUYnIzQjBoVy9JN2V2SWR0RDVwVWhRTnF2dFVW?=
 =?utf-8?B?VFh0Rk5XZWVHNnVjSTV5QXBIVmtBNklhNkFTYzZWdXdYa1p2dTRFS1dKWGRh?=
 =?utf-8?B?OXJEbFYrY0dsellVQUpISzhUTzhpQ3NHWExzVjBtdURVT0VGOGlVZ2RkZFIz?=
 =?utf-8?B?MWMwWmFWcVR1bjF2c3ZDVDJwR20xUmllNzBMSk5HelFwemx5TzNuUktYN2Qr?=
 =?utf-8?B?aVZpSmNrTSt2SSs0eXNHMEJVZmhKUmFCUlFQaHZnbFB5M2FGZjA2T0N2Q0k3?=
 =?utf-8?B?VHVrU3hLSTFucFo4SDVqNWpGbGxxOWxtcjFzNHQxamV5SUE2U1V1R2tOOVRX?=
 =?utf-8?B?bmQ5ZHgwZlVqeXhHcnBEOWNIOUlPZnFXbklvOTFibEpmL2NDR1ZCUzZZb2cr?=
 =?utf-8?B?TXFEUzQyckY0YkJHcWVPaWliU29DTitlWmpSMHZsaGpTak9wa2NwZFRIZmMv?=
 =?utf-8?B?NDlPdWpZWE5WNkd1QzlRTmRPTEk3R1dCcnpRSngzaEo4Myt5Q0dtb0trb1Zv?=
 =?utf-8?B?WnczOG5rZWxpOElWdVZsbVRQVVVoU3B2SjFNcUM4dUZCdVVKM3dtL3VjSDNC?=
 =?utf-8?B?QTczTmlFaW9FV0lialVyQ2xVNUVEekE0aXcrQmZSMWU1L1l5dGZtWFhpcmhv?=
 =?utf-8?B?aFp0N21YM3l0UjNzblluR0tjNnpXMitzL05IQkdpcERIY0oxN0NnMlNMN0tL?=
 =?utf-8?B?MloybzVmbERDUFhlMmJ6UENMZGROdk5RaG9tQjMyRTM4Tnpxb3dNdmFqeE14?=
 =?utf-8?B?UXJJdmVDYU52MSt3THNTbS9aNWhRQWhUckVsSWZNL01Ga0VZL0JQdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A694791D939AAD41B303E911880AC023@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d52cce7-08ff-44cc-8143-08de75fcdbd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 12:36:41.2733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qzCtnImAVRGU315ibyF9nH1dSS8+BSJaAHUpTl3peIB540eWUJ7ZQmU7gMLl7B0DUKmp7uvIojNGaXNt8ul72g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4147

T24gMjQvMDIvMjYgMDA6MTUsIE1hbmlrYW50YSBNYWRkaXJlZGR5IHdyb3RlOg0KPiBGcm9tOiBW
aWR5YSBTYWdhciA8dmlkeWFzQG52aWRpYS5jb20+DQo+IA0KPiBUZWdyYSBzdXBwb3J0cyBQQ0ll
IGNvcmUgY2xvY2sgbW9uaXRvcmluZyBmb3IgYW55IHJhdGUgY2hhbmdlcyB0aGF0IG1heSBiZQ0K
PiBoYXBwZW5pbmcgYmVjYXVzZSBvZiB0aGUgbGluayBzcGVlZCBjaGFuZ2VzLiBUaGlzIGlzIHVz
ZWZ1bCBpbiB0cmFja2luZw0KPiBhbnkgY2hhbmdlcyBpbiB0aGUgY29yZSBjbG9jayB0aGF0IGFy
ZSBub3QgaW5pdGlhdGVkIGJ5IHRoZSBzb2Z0d2FyZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFZp
ZHlhIFNhZ2FyIDx2aWR5YXNAbnZpZGlhLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogTWFuaWthbnRh
IE1hZGRpcmVkZHkgPG1tYWRkaXJlZGR5QG52aWRpYS5jb20+DQo+IFJldmlld2VkLWJ5OiBSb2Ig
SGVycmluZyAoQXJtKSA8cm9iaEBrZXJuZWwub3JnPg0KPiAtLS0NCj4gQ2hhbmdlcyBWNSAtPiBW
NjogTm9uZQ0KPiBDaGFuZ2VzIFY0IC0+IFY1OiBGaXhlZCBjbG9jayBkZXNjcmlwdGlvbiBwZXIg
cmV2aWV3IGNvbW1lbnQNCj4gQ2hhbmdlcyBWMSAtPiBWNDogTm9uZQ0KPiANCj4gIC4uLi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3BjaS9udmlkaWEsdGVncmExOTQtcGNpZS1lcC55YW1sICAgIHwgNiAr
KysrKy0NCj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9udmlkaWEsdGVncmExOTQtcGNp
ZS55YW1sICAgICAgIHwgNiArKysrKy0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvcGNpL252aWRpYSx0ZWdyYTE5NC1wY2llLWVwLnlhbWwgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL252aWRpYSx0ZWdyYTE5NC1wY2llLWVw
LnlhbWwNCj4gaW5kZXggNmQ2MDUyYTI3NDhmLi43ODA1NzU3ZjJlMmQgMTAwNjQ0DQo+IC0tLSBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbnZpZGlhLHRlZ3JhMTk0LXBj
aWUtZXAueWFtbA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNp
L252aWRpYSx0ZWdyYTE5NC1wY2llLWVwLnlhbWwNCj4gQEAgLTU1LDEyICs1NSwxNiBAQCBwcm9w
ZXJ0aWVzOg0KPiAgICAgICAgLSBjb25zdDogaW50cg0KPiAgDQo+ICAgIGNsb2NrczoNCj4gKyAg
ICBtaW5JdGVtczogMQ0KPiAgICAgIGl0ZW1zOg0KPiAtICAgICAgLSBkZXNjcmlwdGlvbjogbW9k
dWxlIGNsb2NrDQo+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBjb3JlIGNsb2NrDQo+ICsgICAgICAt
IGRlc2NyaXB0aW9uOiBtb25pdG9yIGNsb2NrDQo+ICANCj4gICAgY2xvY2stbmFtZXM6DQo+ICsg
ICAgbWluSXRlbXM6IDENCj4gICAgICBpdGVtczoNCj4gICAgICAgIC0gY29uc3Q6IGNvcmUNCj4g
KyAgICAgIC0gY29uc3Q6IGNvcmVfbQ0KPiAgDQo+ICAgIHJlc2V0czoNCj4gICAgICBpdGVtczoN
Cj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbnZp
ZGlhLHRlZ3JhMTk0LXBjaWUueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9wY2kvbnZpZGlhLHRlZ3JhMTk0LXBjaWUueWFtbA0KPiBpbmRleCBmZTgxZDUyYzcyNzcuLjQx
MDQxYWU3ZTBhNCAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3BjaS9udmlkaWEsdGVncmExOTQtcGNpZS55YW1sDQo+ICsrKyBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbnZpZGlhLHRlZ3JhMTk0LXBjaWUueWFtbA0KPiBAQCAt
NTgsMTIgKzU4LDE2IEBAIHByb3BlcnRpZXM6DQo+ICAgICAgICAtIGNvbnN0OiBtc2kNCj4gIA0K
PiAgICBjbG9ja3M6DQo+ICsgICAgbWluSXRlbXM6IDENCj4gICAgICBpdGVtczoNCj4gLSAgICAg
IC0gZGVzY3JpcHRpb246IG1vZHVsZSBjbG9jaw0KPiArICAgICAgLSBkZXNjcmlwdGlvbjogY29y
ZSBjbG9jaw0KPiArICAgICAgLSBkZXNjcmlwdGlvbjogbW9uaXRvciBjbG9jaw0KPiAgDQo+ICAg
IGNsb2NrLW5hbWVzOg0KPiArICAgIG1pbkl0ZW1zOiAxDQo+ICAgICAgaXRlbXM6DQo+ICAgICAg
ICAtIGNvbnN0OiBjb3JlDQo+ICsgICAgICAtIGNvbnN0OiBjb3JlX20NCj4gIA0KPiAgICByZXNl
dHM6DQo+ICAgICAgaXRlbXM6DQoNClJldmlld2VkLWJ5OiBWaWR5YSBTYWdhciA8dmlkeWFzQG52
aWRpYS5jb20+DQo=
