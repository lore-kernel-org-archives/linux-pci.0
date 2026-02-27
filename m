Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013061.outbound.protection.outlook.com [40.93.201.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50A83F0751;
	Fri, 27 Feb 2026 12:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772195668; cv=fail; b=pnWWTGQ2fPeNJ6epfySefNNWpM6/uGA3+k4yWCxfLsWXKyVGELNH69R+WQ6TH+yu2eyW/va0Zu/Sd5mH0P0ZWNTxFl1/GseeA2qCjmIzuvCnxGTTT8bEKjM1mGrwETr1pyvJTpXmJb+uMZnd35YIbHZFWxR3xlf+UUlq+7EaIIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772195668; c=relaxed/simple;
	bh=GcfAnXfeqXe2Nn6Cn+EQlIUDtsglzMLIpUJzFgVIPu0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VIYUcW5NTyFt63TaxuN1mDXhAjfa8F54OR4DQE0SThuYSWJ82x4EuLjo8/GDISSBZbCp0dXo63zjGqeZtPy+J2Y2zBAWiHI6MR02yBiaDhHnHbT3QQaOO6qkhV+JP9D9kHcefAqWJmagFVqCsLBVV5B5DZsxHvHr4rldkiSfJAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=drkP2GpO; arc=fail smtp.client-ip=40.93.201.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="drkP2GpO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cjDyq/EDP7uCSZnTypJZs61WnmIOIy1exJLdrNJQWs/QMsVuCpv5kYYhrauCeueXxKdiMFdkJaB5XwLYvVd14+myquw0HBMWxVt4rwPfBf8052/weXTaWArK9AFTughkLkG2uDUxdYXk5m2Whc3iGJfYIO4XdIIIr3x8aZiMJAIbIY+3IPuWjBYoaKS9xTUQONrxUjRaJAU34jLInsSZwuj2U3tzmb8r7jAWaVQSqc6fwU//M81ahVz029YY6zs+JIeH4cUhLkxqD6JZ092ir/d+PvXieoagucsUgu2VemhLnAqY2wZ4jCb1/MkzspRyXDSo94xgTj0UWyRh2MdUjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GcfAnXfeqXe2Nn6Cn+EQlIUDtsglzMLIpUJzFgVIPu0=;
 b=amlsoCtOwML/jr0BquDLWTZHsF+JATHa6dSxPhghpsyH0+UrSatoEghXKgbL3udKboggl3266UiE3Y4+R2kUBNeKvMlbjVDYlkqJu2rWOXeRbVUyQLjJWj+Wve+ywDqhxYDnup36O4oxHOGuym2c0zQ3nyGa9nhS2sG+1TaYDGgtUi5pman9LuBW/MMFUS05RbW3b+rrLiQ+rmE1CBT3E9SRUrX/D8XzX3DvGjMC+dCFrGNv3jQknamsPdIKduUTlzeF10tspxJOSNW7SyR4Tw/sIEVuVjVCERdML+w5dtpxAAOvkib4y9AQjKq9rBGh1dxO6o4pGLRPSOVSeSjwIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GcfAnXfeqXe2Nn6Cn+EQlIUDtsglzMLIpUJzFgVIPu0=;
 b=drkP2GpO1fvVbXZ51zQQopZOKel1Emv9MjCu/AAquB0u38XPhIQE0YBK6WcFC/OeyuCh5sl+suCaFWBSdSZMp2YBKEFPz8/5m28EzinxMX5/Y8SlsnKJvQLID7bvwan6Ma57QeurtTq9RUugmj+niggDP/NXffeEUMgO4i4w+H0T9FfAbyJrWdgCnay9yu+KlXuzl3neL7HsWnoPflff+KHgeS+/4Se/kg0frG+ZxR7m3yA4qvSv9bBjDplatODqCIJdsebSiJjgct0IOlwtDdo2dqkVkQCNq0ZeQ1Lxi6j3rQfRJH9QqeEYAeuImSyqZvclbAO2b98+DBVpdsdwtg==
Received: from SN7PR12MB6744.namprd12.prod.outlook.com (2603:10b6:806:26c::13)
 by LV5PR12MB9825.namprd12.prod.outlook.com (2603:10b6:408:2ff::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 12:34:24 +0000
Received: from SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961]) by SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961%3]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 12:34:24 +0000
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
Subject: Re: [PATCH v6 10/13] PCI: tegra194: Free up EP resources during
 remove()
Thread-Topic: [PATCH v6 10/13] PCI: tegra194: Free up EP resources during
 remove()
Thread-Index: AQHcpPRbxG5AqY3xQUumahNcaz6SVrWWgOYA
Date: Fri, 27 Feb 2026 12:34:24 +0000
Message-ID: <04e7221c-c85a-41fd-ae3d-2248bf800f5c@nvidia.com>
References: <20260223184151.3083221-1-mmaddireddy@nvidia.com>
 <20260223184151.3083221-11-mmaddireddy@nvidia.com>
In-Reply-To: <20260223184151.3083221-11-mmaddireddy@nvidia.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB6744:EE_|LV5PR12MB9825:EE_
x-ms-office365-filtering-correlation-id: f6e02419-c222-4aab-8c5c-08de75fc8a4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 zJrar9btK6OQm+LVeUXxE7YIbGEVswG4KZQrJJTv7VDFPyBdtsasNmo4U4ZmRMga+y/iL8bCx1ctNR37+rTvxMVDoy5WuFkZOSVc0s806m953WXV2Ux9TVVhSrm3kRr7xuKMmVqr6hiVyydce8x4XTYESHINKXlMnJwcFtQ94smb5+NB6PwmL/6RstdPQU82LVU09k0u3VUCFuDCnMCrty8osJasTVySXgRAT8mmVau+iyamBoTn+hyYkRF0XHob9w90fucH0P0VFWKPmcwGYTNEF4//P/d263RjB6BYRMktPRysjdLrVU6G3Vn7O7zDuvuatmI/xvdSxryMC0pv2TOfENayfLRa5DuGHyCnffNgrg3aC8UUBa/UpllbIM+wSK+hFdWsUq5BvmjbUPYSHuwxQTCogRTtE4Pp4FaZUAwAGJTRcwXYOwY8pyx6WEBvT29UxHHcbGLpTnY0zM3HJy6OScsLdIX2QJ305rOSLW7/vRnU22pz39lvnhWMidAKnW4hiyF/LYsrsl+TUwZMSjc87Vw/FTZ+5lXC+LKroAHqPcZT/UxP7EeS+vKMeWSKNPGvUTwp3a6YPlHUYiFRJX5M1VmNIyXEH/+XPdU1o9b2ObqSyvnwFFyOOdRPz9YdyhPAer4m5nfprMS096/dN1St5Twu17vyR4h9P049ITAhky5DuqFNfW+MTIx6la6c6pT7H/6oUPibfRL55m5OZo2zD3N5tk90DhmMhZkfCkKcnGKynn3KBf7HPE0cegqf3vKPO1kCs/cylW0+oECMzVQ4vsg7oaR3uUbmDTxZK1U=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB6744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NnUzeGNaRHFjeVlHTXJ5NkFaR1g3QnhQSnFITGltKzlETGdTTm8zQUZMWjBO?=
 =?utf-8?B?Y25NcEZ4QTlKSEF3KytHaXJFRFpIYUlFd0pwbmFlaVZRRFFRbU1YYUlNeFJT?=
 =?utf-8?B?TDcwNTY5QjVpZERaYWl3OVJzY2xHNXpCaEtjeTZ6VkkvSWozV1JOUHNaSTVh?=
 =?utf-8?B?NEZsU2tQTEtYdnlTYXFiQWtqSFRnSWJTRXFFOFY2NFBiSFYzZmw2SEwwekZD?=
 =?utf-8?B?RkcvVTFnL3llUnJpLzhYT3RuNUFWQmNlMTFaUmwwSE13eTc4L2wwYStXdXZL?=
 =?utf-8?B?UXVaVDZIWndQRUdJU1FmVUlZY2FWS0pyZkd2SEJEeUhzeWtvZlFmaERIZjlN?=
 =?utf-8?B?WWsrQnlxYk9ZZ1JUMjhFUFlTbjN0aTdpRCtteGRDVGRtMXd0bnluaWtBbnJJ?=
 =?utf-8?B?WWs1SFNveXFmSXh1ZmVuZnFlaFpVY3ovYkdXcVNWc3JUUzBxVU11czJFOEVW?=
 =?utf-8?B?R1ptYm1DU2F3WHFqanczdHMrTEhQd2hQb3dZeDNacHErYUtZSjVnNGpSanJI?=
 =?utf-8?B?WWUyN1VnNnZuR1pRY3FEaU5GRXhXa2FBZHdDS1pkdzF6ZCtWckhPTmkvcWQv?=
 =?utf-8?B?T1h2S2x3MXdQbFV4cW5JZmlCWmMzVVR0S2k0SkxsMXNDUkFsSHQ2dGVlWXZh?=
 =?utf-8?B?ZVp0RDdTQzJEL2FWK1V0ZHN4U0hocWtVdEhicTNmL1JzVXpQSi9ieGp2TE1o?=
 =?utf-8?B?Z1BhbENPU0ExVzBNYnV4Y1pOOUJMVVE4VnpGR2FFMXFhSGVZMHlWR2x4TTIy?=
 =?utf-8?B?R2JLeUJTb3ZsMmEvSGM4UlRkbFFUOEZXT3d3alBjOFN0d25BTHpvc2RQTkZF?=
 =?utf-8?B?NG5BNVEvTmtkZzlIR0pQUlhtWmlaSUNEMzhBT0RBdm9oNm5HRjdHeDRtQ29k?=
 =?utf-8?B?MzFHWmFuQzBEaUhyQmxobFBXNmMyMys1VDgzOG9Nek9iQjRTazRoYW9RRGtn?=
 =?utf-8?B?Wlc2bVU5UHJlRGJlc0R4K3A4b3Iwc3Bpdi9hQTNnSGM1ck85Q0xXZ2FESThh?=
 =?utf-8?B?R3dtcW92dFhIRGNRQkR4Wmg5cjF2aG5tZmFlNWQ5ZHk4Q1J2RTFkQVpzK2Mw?=
 =?utf-8?B?V3Z0ZFJPV2RpK2dvVDdkV09sVDhUR3FOcGFNR1NjVmxkcTZSYXlKVDNYdWNN?=
 =?utf-8?B?eTZtSjFpUkhIQzVlVWxleEd3Qk9uZ2JKUFRMdjZNYjNBNENtQnZVRjhEK0lr?=
 =?utf-8?B?WFZ4Unl1NCtWOXI1VlBROExjTkM2VWRHMHNGY2VrUG9xL1dzZXppVFFkTitR?=
 =?utf-8?B?T2JkZ1kyL2kzTGd2b0RTbWhjeGNlRUM1bHpKVUVETnRBWE9NelVUcmpjaHpZ?=
 =?utf-8?B?NjIrNVAxWVh3S1g1ZFQ2MmdNaHVqSVdYbkJvcGRnck5pMmZJcng2OTJSYnpU?=
 =?utf-8?B?enF3S2tlWUgwakFpakMvOERsRWpMczJPemhhN2RNUkFGZzN2cWwvcXR6UUth?=
 =?utf-8?B?MDQ1TmhRSE9jSTBuT0JjQzVFVFAwRkdVcFdyODhMVVVDM2xrNjVIdVVKVzJl?=
 =?utf-8?B?dUcyMnlkM0taRENkNUVKenkwUlZFd3dCWXU2ZDd2aWtyMnFqK3pvS3kxYi9p?=
 =?utf-8?B?QjAveE9abVFway9CVnlUeDgvdVFJSGVPcERkdW9LeFVoaGdaUFdYTTQ1SERI?=
 =?utf-8?B?c0xpbGxaVVNYUmNqZDRCT3BNSnZBSEgyMmJNSzZTazdMZnNlZFNGK1M1MkV0?=
 =?utf-8?B?dU9wZnkvbHNocmtXcHVSWDJMQ0tlM09VVytrNHVGVTc5dHI5Q0VFOUxYcG5a?=
 =?utf-8?B?WWUyQzQvVHZEelZxVE9SZHY4M0NWc1Rqam15M1lwOWZZWjBVK2tFVDJmZjFV?=
 =?utf-8?B?c2E5NS9TeGlUUmt1c25STWFWeWw0elRYT0Rac0NnTUV3WEthVlFCZDYwUlFL?=
 =?utf-8?B?U3NUQUMrYi9rc0RoK045UVZZOGh1Mm1US29JUTEvZFZMNXI4M2d5MGE5NWIz?=
 =?utf-8?B?SGpEQnFBQ1YwKzFUYWFVSmtXeGpJUllNUjZqQU1UYm5sTWhuWlVaVysyRi9i?=
 =?utf-8?B?SG5zVHVuTXl1ZTBzVW9qL1BTaWFweEtiU0RaTk5UcDRsSjFtUU8zZm50UnNh?=
 =?utf-8?B?Z0xPdDByR0YrSHBPMjZaVzNkYlpYRnNBa3c4TUpKQ0Fqam95QmpTZ2lTcHVz?=
 =?utf-8?B?Qmcwcmk3U1dIYnc3dXBScU1VSlo5T0l1c3FOQzZ0L3NDR1hFdTViWm5waTcz?=
 =?utf-8?B?cXRnQ3lwL2o1dnByTGZNTk9VeXVqZGo2V0RpK2ZWYVBNOUw3Y0RKQkx2VEdV?=
 =?utf-8?B?UHdWM1RRRlpmRUdRd2lnb1FyQlpMbW1SQmsrVHhOaEZzUlArbDJMRUMvVUVW?=
 =?utf-8?B?U254WVVvNHM1d0VHS0orUTVFQ0p6aFRoNng5QXJXRUM4VnFQQ2ZFUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F24E360E8F3B7F4287E76CBD80BDF96D@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e02419-c222-4aab-8c5c-08de75fc8a4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 12:34:24.5547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NYxPLoDVW5bR1mV/MSBrEwa4jOfo104nKOCAkLG9dT5FGBa2MhNISF6wk4q5RtLIjTCzDHbChdnGck4tPUrItA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9825

T24gMjQvMDIvMjYgMDA6MTEsIE1hbmlrYW50YSBNYWRkaXJlZGR5IHdyb3RlOg0KPiBGcm9tOiBW
aWR5YSBTYWdhciA8dmlkeWFzQG52aWRpYS5jb20+DQo+IA0KPiBGcmVlIHVwIHRoZSByZXNvdXJj
ZXMgZHVyaW5nIHJlbW92ZSgpIHRoYXQgd2VyZSBhY3F1aXJlZCBieSB0aGUgRGVzaWduV2FyZQ0K
PiBkcml2ZXIgZm9yIHRoZSBlbmRwb2ludCBtb2RlIGR1cmluZyBwcm9iZSgpLg0KPiANCj4gRml4
ZXM6IGJiNjE3Y2JkODE1MSAoIlBDSTogdGVncmExOTQ6IENsZWFuIHVwIHRoZSBleGl0IHBhdGgg
Zm9yIEVuZHBvaW50IG1vZGUiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBWaWR5YSBTYWdhciA8dmlkeWFz
QG52aWRpYS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IE1hbmlrYW50YSBNYWRkaXJlZGR5IDxtbWFk
ZGlyZWRkeUBudmlkaWEuY29tPg0KPiAtLS0NCj4gQ2hhbmdlcyBWMSAtPiBWNjogTm9uZQ0KPiAN
Cj4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtdGVncmExOTQuYyB8IDIgKysNCj4g
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLXRlZ3JhMTk0LmMgYi9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL2R3Yy9wY2llLXRlZ3JhMTk0LmMNCj4gaW5kZXggNTgwNjliMTYxNWI4Li5kMjI1MTY1
YTNhYTIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtdGVn
cmExOTQuYw0KPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLXRlZ3JhMTk0
LmMNCj4gQEAgLTIyNDcsNiArMjI0Nyw3IEBAIHN0YXRpYyBpbnQgdGVncmFfcGNpZV9kd19wcm9i
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgc3RhdGljIHZvaWQgdGVncmFfcGNp
ZV9kd19yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIHsNCj4gIAlzdHJ1
Y3QgdGVncmFfcGNpZV9kdyAqcGNpZSA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYpOw0KPiAr
CXN0cnVjdCBkd19wY2llX2VwICplcCA9ICZwY2llLT5wY2kuZXA7DQo+ICANCj4gIAlpZiAocGNp
ZS0+b2ZfZGF0YS0+bW9kZSA9PSBEV19QQ0lFX1JDX1RZUEUpIHsNCj4gIAkJaWYgKCFwY2llLT5s
aW5rX3N0YXRlKQ0KPiBAQCAtMjI1OCw2ICsyMjU5LDcgQEAgc3RhdGljIHZvaWQgdGVncmFfcGNp
ZV9kd19yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAl9IGVsc2Ugew0K
PiAgCQlkaXNhYmxlX2lycShwY2llLT5wZXhfcnN0X2lycSk7DQo+ICAJCXBleF9lcF9ldmVudF9w
ZXhfcnN0X2Fzc2VydChwY2llKTsNCj4gKwkJZHdfcGNpZV9lcF9kZWluaXQoZXApOw0KPiAgCX0N
Cj4gIA0KPiAgCXBtX3J1bnRpbWVfZGlzYWJsZShwY2llLT5kZXYpOw0KDQpSZXZpZXdlZC1ieTog
VmlkeWEgU2FnYXIgPHZpZHlhc0BudmlkaWEuY29tPg0K
