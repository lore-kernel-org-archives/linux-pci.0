Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013001.outbound.protection.outlook.com [40.93.196.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1BA3F0768;
	Fri, 27 Feb 2026 12:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772195644; cv=fail; b=iz5nqNhiL66nckODH3Dr1ye9DGxR+t6rW4qMtKBdRthALtu/hrbm8jrRWXHc/00FJxaFubZg1hovVhjhk9qDIK4pcJYgm50LCAGQxfy27B9Uoga6jrAMRbD073iSWwARfVcXwg0bxeix74469VcYQcrnB3WaOgazypYLuqWuUfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772195644; c=relaxed/simple;
	bh=bsPfiDiOS4XguWF4HAiUg0oF2D0bRyPH5JzZoD/wScc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LdpNpDjF1KLXiCtJTA8bJBaQV5Oe3sJYKu1HHzPrVLGWq/DzwuTNuNNpu8EynoQP/xAbR/WNgi6JQoLfM8WarEakkHFloXdlmR56NHWB6e8V5oCkLIAEnDTLxQ+bxHdgF22VfosW1UqghWfO8hjxSrgGjj2ebArKOl4ro9DLYqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mjuCkVNp; arc=fail smtp.client-ip=40.93.196.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mjuCkVNp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tshTIRkuESOfKF71dDa5lAxMPgzAxCAXUqkeDk0rCTwXwEugurjy2Ppe79H1d/hTOR8Av8zKBQzohfI4ZvCYOh82Q4A8SYdLOjD4hI+iBjw5AdNegV1Hiv2wjgnc/XsGlBdKQMDBPSbylGfzhpLRa3XYlPAMgX48rUKngKJnwTo9bZRgEmEmaq60OLo2rzeo3p0kuQNrtdp9/CTBR6e5Xvq9TQovrc64YPBYwVQ3IncQdIuGxhFBGKfDtK6vOfOaLTCMIKRLzLuVY+Wlm2vImHgvEeP7xEZpscvQ0Sf+fkyN15NtUcnCXqNHG2s7h65J+uIuZetsNO7Lq9z5kjfFbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsPfiDiOS4XguWF4HAiUg0oF2D0bRyPH5JzZoD/wScc=;
 b=fe6ODi9TmindiqwFWbSFFFFwqjaTQP/p2fk9iRA8moKvGWL1BYmR0MJjCn7I6SdEdM8rC/REbR1yUcPh0ajrUMjPcecU7al19wC36IuxWpDDPH8XodBEh3o2KJaabLLz1srKWA82M/e69XqZfgQBa5D3qJxBZo4zpTT0RyaomqqRleMWt5z1jrunlYxD1jgwryKcNfMQEyfAspB3Pd9XdOMacrdpZUKlmbhwIqVd6Ld18+jynPXlCUFiKGnkp3vf+y1zDxcfnxz+7Q0yEqr2EL/M0ndZBql+7+k5SmnM0nWuZjaJueGEVHr8aDOXclnDzlmaC8oQzBPGTxgkIYCmnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsPfiDiOS4XguWF4HAiUg0oF2D0bRyPH5JzZoD/wScc=;
 b=mjuCkVNphofbfoy578i9PuvV1sdvH44rE9j85lVVMKMdH2NQczSmNov7CEaAv+x3uDU8oWrLQ9ObP4PBAQMxsOPusmjMr02Njbr6TGGnfaLtSHEDC1vRXpVTV178u7hoLu+h917zAqY5HaeQMq149IxSa9hRrftleB1Jbb1SJVopotKcalqsJOmOejq1CJU88YHr7dgn575D1v1nM5hsIAquXVda33s8jm4Mg57DjHBW2miKNeaZ9ZofUdsxD8hUERWygWSKlocaO/V/2rEvYt5Xcu/WI0AdPjS0MAg87HYfUIsUQwwFLD6KBfN4b8rvX8WS1xp6xOEZ2bFgW4rDlA==
Received: from SN7PR12MB6744.namprd12.prod.outlook.com (2603:10b6:806:26c::13)
 by LV5PR12MB9825.namprd12.prod.outlook.com (2603:10b6:408:2ff::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 12:34:00 +0000
Received: from SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961]) by SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961%3]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 12:34:00 +0000
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
Subject: Re: [PATCH v6 08/13] PCI: tegra194: Apply pinctrl settings for both
 PCIe RP and EP
Thread-Topic: [PATCH v6 08/13] PCI: tegra194: Apply pinctrl settings for both
 PCIe RP and EP
Thread-Index: AQHcpPRULzBRbR+e+0CX/vkmrKRM8bWWgMkA
Date: Fri, 27 Feb 2026 12:34:00 +0000
Message-ID: <dabbc4cd-3a2c-44fd-be93-595ff827f005@nvidia.com>
References: <20260223184151.3083221-1-mmaddireddy@nvidia.com>
 <20260223184151.3083221-9-mmaddireddy@nvidia.com>
In-Reply-To: <20260223184151.3083221-9-mmaddireddy@nvidia.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB6744:EE_|LV5PR12MB9825:EE_
x-ms-office365-filtering-correlation-id: d497301f-911e-4d88-cfe5-08de75fc7bfb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 TOQa1FxUhR5bg8AA0+90X1YdSvCUpD49JV+QeVBb/47VAMeZMuXwp378qUdIn86fDPE2qQ82LzyPwmbVLEoZkHMv639LPwbZPXIEaDiuJ3/BEYFVqR+HpjckErHzaNlSvoulHCfoP2+cA+MDAf9Y/i6HadvxXenAIVuO3X8nSe9NG2S+TLN5XTX9Hzgs9Fq+SLB3dA4ADcm4wPscERXHg2WZWfuDqsjzIcBUN47JHphgTzcmwl3OpCKoQQv6mt/7cgduSZ8aAkaFwd4XwTmYxKqhFNBkG7Xa3NrRpSF04UaD03LMxOGsPqMassBAznFux2GaJO9Kq1tRcflOOu1pX7OWksEWR57weM+ik9hM3jc//NS+M9jQdt0HVnHdfGwLuLchZxZwucHCm98gIN+qWXScIvHQoEKX0ycwfclIidt2KzLgJOga/qIWfmLNKMfFljJAi7nT3+Pr9gagYnPP3zCzMJVqvjdyp08nEk4029kMSWVwKDoZCs3xtFKR64L29j/VDcJ4vXszR+cX1Ml6h90yzyWFTFMQMbNlgWsie5fNO189ZQgFiIlXltQmYvmaN2csnUkvqbOMdJ0SpaLpeim01yvWjPFo5pF7A1oJBgdsFv3VEQQbdwHxIDXbojTITE/3bk3UEmUk9dAMQAK/rqt0irzZQCgyp7HqtaQl9F+EWZrAjOqlilmKrREn5Mqwt2W5nXUWmRQQxNgjIqH7eoPToqV+aTLd68OMOmmK88u7PH5BU/r96gYNso5j00eBIKocsdup6o6F+WmVnY+Im6fgWKd3FOr0cZZm+dlu19zCcmyL0HecsvcGOIzSOPh8
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB6744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V1ZpRVF3eVEwNXdSM2ErMjN3Z1dDOCt1Mk5VNnBZUVlSUlZyaEVEdGZYQjY3?=
 =?utf-8?B?TDl1djE2Y2sxd05tZXU3STZtSnNyRnA4aU1BK095YnkzV3lTRzZYV0dKODdU?=
 =?utf-8?B?czBhK3BzNXVIcjRIZ05sbVRYTjN3d3Z4dUgrV21IZENiR3FFRHQ3Vy9ERGh2?=
 =?utf-8?B?YklUaHZXYng1clZNKy82eGNFMjg3NmFOKzEvM3grUUFUaEcvZzhwT1Q4UEVM?=
 =?utf-8?B?Z09yQWxaWDYvNkd2eFRYTlI3RkxieitrOFVZRytuTGNOSkRIdEVueHFiWlJQ?=
 =?utf-8?B?UVM2bW9lRFN4b3RPWVI2ZE1RWjNESDRwSTRzeUgvalBjMzV4SXI4REwrUVhl?=
 =?utf-8?B?K0pBc0VRZHg3T21tU2ppWTFBL3pQOUNiYWNFeXIrNFNib3BIa0xrbCtxcDk3?=
 =?utf-8?B?TkYxTHJLWnl6d3RURWw1QzZnM2lXSXZsa2FqMlY5WTg5d3lpUW05WWk0K0Vs?=
 =?utf-8?B?MTFBWGl3WFZYaFpYM0p6WjRZWHptajFjdjF6eVBITnN0QXpOd0RFWFU3cmNZ?=
 =?utf-8?B?UDVyK01kaDVwNW1ZYkQvOTN2cHlHUkxpWFB6RHhqWFVHb3pYMC81aGJtTnhX?=
 =?utf-8?B?TERSdzJxNXpnbEVoZEpZZU00ZUhjT3piTVhLS3R6aGJZTWZkYWwxNk9VdXdt?=
 =?utf-8?B?aWNJaUJtZlRmeGRoeFZtR3Q0YmhSbE50UXZFR1ZHVzVQSS9qV1RjQmlvMnVM?=
 =?utf-8?B?YWpqYWtaSldUd05DZUNUblhwU0JZVWhObWFVN055R2VpVWMvbWdsUXB4TTBT?=
 =?utf-8?B?WlNJemZSYTNhWFJQWXBmL2NOTFBIOUNkajdHd0MzUmovT2ZxT2J0aUpnWGVp?=
 =?utf-8?B?YWtQaHpNYmxWOHB1MzhSM1ZodmswWkJGQjRNakN2WmlGOUhJVzZKNG0vRFdW?=
 =?utf-8?B?aU1YVm9aUjA0VSt4dWVFS3dWWGVLTnZIRzMxdVM5L3ViOFpOWm5xQ01UTmNW?=
 =?utf-8?B?TnhOaTNIc0Nrdnd5NWRmZ1JLZm9GYlhRdzF1UjFKTXNmWmFCK1dJZkhGRGJU?=
 =?utf-8?B?TlN3MnIwWnZrWEg4SGZXQmRGRjBNWDZ3S3lRRzN1M1Q3eHQ2WkZyS2txeDFv?=
 =?utf-8?B?VlZwUC9May9QTEJpS296NHZ2NEVKOXVvN1RrRHhvN3ZHRkNWcjlzc3o5Y09J?=
 =?utf-8?B?RyttNmxka3dWY2J6UldhQXE5MC9lbzdoRmc2QVpQYUJTTlRvdW5LTlc1Z1JH?=
 =?utf-8?B?RGN5K0xpZmdxNHZucm82WTdIOUhXb2JtWDA0THMwbCtlSE8xbVB3LzRRbWFV?=
 =?utf-8?B?NWk3OGtNNW51WFA0alNIWHpNMHdVTDRqd1lBVmt1RXMycmszUHErNmZiUTBk?=
 =?utf-8?B?cTZYZjVmbm5FLytrczhTU2M0bDk0Zkc5ZkZSMFFMN2ZmdkpJM2lKSWZoQWcy?=
 =?utf-8?B?Vkd1RFFxTERrVUxmNkRZNkxlaFhRWkN4eFZwUDNBYXdGK0daekEveDlFOUxX?=
 =?utf-8?B?NndrQWQrcGlXT20yU3lQNlZLem9IclRVV1hJQ2FVZUczWTdyUjhpNVpkemsy?=
 =?utf-8?B?Smh6UG5lOVRyM0lYblExUVpBOTBaaE9Pa0NLTGpyZHl4dmhXazlFQVJOcElH?=
 =?utf-8?B?MGlmY1pkUHhzVWg5YlVYUm8rOE9VWFJOTWJwbm9Ca3cwTEdob05EdGp1SVhn?=
 =?utf-8?B?QkJUTVJCaFkxam9OUjZ6WDZ4UUJUYnI4cTJpM3ZrbVQ4bXhadW8vQ3BTSHlO?=
 =?utf-8?B?Z3pWUkRvT1hkN2V5WGlqY3R1NHhUVnE0V05peStwQTlKUzh5L0NlelZjaDBo?=
 =?utf-8?B?WEFReUdBVm5XaTAxRi9lM1Y2Vi9JVk8vSTk3RDhhTCtWTFZwQ2k1ZXlhbFNl?=
 =?utf-8?B?Q2J2NmVDd3VwbDR0RnJUdTFUZ0JaK1VsNXpOeEJ4VFZjcHNuaWhsRXlmL3No?=
 =?utf-8?B?dGhaZkhpMmRrK21zeE5lQURFeXJiOVJhTUZlaVNyaGNDek9ZWjQ1bHVoaXJq?=
 =?utf-8?B?L0ZNQ2M3cHBTcWZ3NElvcGxuczVGRHBrMXhTNHo0THRCVzE0WEhQT0VvYlJu?=
 =?utf-8?B?M1ZTTjZBV0lwbFd6aGJsK1NQc0ppS0FxS3pjbHlHSHZzUU5zZFh5cEVSMDNw?=
 =?utf-8?B?MWM4d2ZhZEE2N2ZKbk9iUHZjYithbm93QlNVZDFtcGN5NmExR1ZkSzdzek1t?=
 =?utf-8?B?d1hhOEorYjhlbWZuelJXUm0vUzRxMEFNYVZPQnJJUUJYaFl6SFRqYXVZTUMy?=
 =?utf-8?B?VHhUWUd1QWk2bzZ5WmtUeU9GMkpsR1kwMTUwUDN1Sm04YUtrTUtzM0RGTkxK?=
 =?utf-8?B?QVN1clZseGlLRGhuOUhsVVViK0xpdmx4YTlXTzJqQ0pYT1BpQnNFZHFqdTdH?=
 =?utf-8?B?dGNqQ0I0RyswL1Fxek96YnM4Z29yY1NRTWdYdHd3cExxT3RUMUZMQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F0D66A708098040BF1B318EBC635D6A@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d497301f-911e-4d88-cfe5-08de75fc7bfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 12:34:00.5235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JRg/6LOugiJ09Af946fCV/h1zF/r9mkfA+LtYoSbRVzufUaTmvbKRUs5KyFZSTPMXK7zWkMR5hgIAexQzjAtEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9825

T24gMjQvMDIvMjYgMDA6MTEsIE1hbmlrYW50YSBNYWRkaXJlZGR5IHdyb3RlOg0KPiBGcm9tOiBW
aWR5YSBTYWdhciA8dmlkeWFzQG52aWRpYS5jb20+DQo+IA0KPiBQRVJTVCMgYW5kIENMS1JFUSMg
cGluY3RybCBzZXR0aW5ncyBzaG91bGQgYmUgYXBwbGllZCBmb3IgYm90aCByb290IHBvcnQNCj4g
YW5kIGVuZHBvaW50IG1vZGUuIE1vdmUgcGluY3RybF9wbV9zZWxlY3RfZGVmYXVsdF9zdGF0ZSgp
IGZ1bmN0aW9uIGNhbGwNCj4gZnJvbSByb290IHBvcnQgc3BlY2lmaWMgY29uZmlndXJhdGlvbiBm
dW5jdGlvbiB0byBwcm9iZSgpLg0KPiANCj4gRml4ZXM6IGM1NzI0N2Y5NDBlOCAoIlBDSTogdGVn
cmE6IEFkZCBzdXBwb3J0IGZvciBQQ0llIGVuZHBvaW50IG1vZGUgaW4gVGVncmExOTQiKQ0KPiBT
aWduZWQtb2ZmLWJ5OiBWaWR5YSBTYWdhciA8dmlkeWFzQG52aWRpYS5jb20+DQo+IFNpZ25lZC1v
ZmYtYnk6IE1hbmlrYW50YSBNYWRkaXJlZGR5IDxtbWFkZGlyZWRkeUBudmlkaWEuY29tPg0KPiAt
LS0NCj4gQ2hhbmdlcyBWNSAtPiBWNjogTm9uZQ0KPiBDaGFuZ2VzIFY0IC0+IFY1OiBVc2UgZGV2
X2Vycl9wcm9iZSgpIGZ1bmN0aW9uDQo+IENoYW5nZXMgVjEgLT4gVjQ6IE5vbmUNCj4gDQo+ICBk
cml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLXRlZ3JhMTk0LmMgfCAxMCArKysrLS0tLS0t
DQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtdGVncmExOTQu
YyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtdGVncmExOTQuYw0KPiBpbmRleCBh
ZDEwNTZkNjhkNmQuLjYxY2JiNGYyMzBlMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9kd2MvcGNpZS10ZWdyYTE5NC5jDQo+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvZHdjL3BjaWUtdGVncmExOTQuYw0KPiBAQCAtMTYwMSwxMiArMTYwMSw2IEBAIHN0YXRpYyBp
bnQgdGVncmFfcGNpZV9jb25maWdfcnAoc3RydWN0IHRlZ3JhX3BjaWVfZHcgKnBjaWUpDQo+ICAJ
CWdvdG8gZmFpbF9wbV9nZXRfc3luYzsNCj4gIAl9DQo+ICANCj4gLQlyZXQgPSBwaW5jdHJsX3Bt
X3NlbGVjdF9kZWZhdWx0X3N0YXRlKGRldik7DQo+IC0JaWYgKHJldCA8IDApIHsNCj4gLQkJZGV2
X2VycihkZXYsICJGYWlsZWQgdG8gY29uZmlndXJlIHNpZGViYW5kIHBpbnM6ICVkXG4iLCByZXQp
Ow0KPiAtCQlnb3RvIGZhaWxfcG1fZ2V0X3N5bmM7DQo+IC0JfQ0KPiAtDQo+ICAJcmV0ID0gdGVn
cmFfcGNpZV9pbml0X2NvbnRyb2xsZXIocGNpZSk7DQo+ICAJaWYgKHJldCA8IDApIHsNCj4gIAkJ
ZGV2X2VycihkZXYsICJGYWlsZWQgdG8gaW5pdGlhbGl6ZSBjb250cm9sbGVyOiAlZFxuIiwgcmV0
KTsNCj4gQEAgLTIwNzYsNiArMjA3MCwxMCBAQCBzdGF0aWMgaW50IHRlZ3JhX3BjaWVfZHdfcHJv
YmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAlwcCA9ICZwY2ktPnBwOw0KPiAg
CXBwLT5udW1fdmVjdG9ycyA9IE1BWF9NU0lfSVJRUzsNCj4gIA0KPiArCXJldCA9IHBpbmN0cmxf
cG1fc2VsZWN0X2RlZmF1bHRfc3RhdGUoZGV2KTsNCj4gKwlpZiAocmV0IDwgMCkNCj4gKwkJcmV0
dXJuIGRldl9lcnJfcHJvYmUoZGV2LCByZXQsICJGYWlsZWQgdG8gY29uZmlndXJlIHNpZGViYW5k
IHBpbnM6ICVkXG4iLCByZXQpOw0KPiArDQo+ICAJcmV0ID0gdGVncmFfcGNpZV9kd19wYXJzZV9k
dChwY2llKTsNCj4gIAlpZiAocmV0IDwgMCkgew0KPiAgCQljb25zdCBjaGFyICpsZXZlbCA9IEtF
Uk5fRVJSOw0KDQpSZXZpZXdlZC1ieTogVmlkeWEgU2FnYXIgPHZpZHlhc0BudmlkaWEuY29tPg0K
