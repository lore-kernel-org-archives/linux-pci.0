Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011052.outbound.protection.outlook.com [52.101.62.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9E73F0751;
	Fri, 27 Feb 2026 12:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772195636; cv=fail; b=MBA1nhD633rGRXl4CIO5UV4siSzQoYPZ2fgC/hDSps9x4bqllbCJvEo+sAS64Fif4hy+VNcZWyhdV6T5r3+amNr6+S23GbkhFEeBC/7l0ngQuEXPn2NDMDOBcZRLeGS106BT7vyEP/0Qp+wzZq45h3q9OHL42BulA4lkcvjFE1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772195636; c=relaxed/simple;
	bh=ovIW6cbhmsc4bcirQtOLSRZU8Bm648s52OhCPDHXLjc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NOPAvqEQtL4aInYSl71ROCtVEG5TztemX6fwZBw7CNfHAC6nCkRJko4nEvP1n6m9viGVusmJVupgNI/7hc4N87YcsLKkgcThjrMkkPxKfkP33hhd4V9YvptOcrTD/unl8qFCvhRs7xulHbV0I/0JaXk/61YLYbauzKuwOm1iPYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IWfaDUVL; arc=fail smtp.client-ip=52.101.62.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IWfaDUVL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yiOCILBk3gZNkFCITj9vjvv9nkJl3i2NuuuhaR7cqglbwBvhbtFeey962ubdLWQ08mLR81B6SkYVS5kV24ibdV5Wa2LjZhoc8RI4KDwDIF7fJKqlgRAGDv1sdRnB1jgWtwQgqkTm8ASJtjD6LwtiLV6oSQobBfj9PqaXwzfhbE/TBG66YD/V2Kh5k7cUUv4D0rz7tDi0b/KFKipRh7zGa5ZoOvqdPv+uIELUAcUweKJ7ocnt7K+b04Nw7AoWPAOZIdYx8WhnWPybLK7NNbZzAMok4eDhKYpLXFrrRpNDbpXrmLCqFxWkaR+SYKJDrUw10NYoT/RHxJ2oD2D7W6WCbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovIW6cbhmsc4bcirQtOLSRZU8Bm648s52OhCPDHXLjc=;
 b=Z1KDN20Reuw/g/Dcm9CDrrKJiHxIe18l80QinJPLUD95dl0M1a7afNq7m2SOnLTy7SQhfAgnAmAYcPx8zRmnOv/fjRKEZhpQOl1mbzpxR3p31+1/gkF7fi5Ss3a072ha2D0+BdwRkdfytGjCH9NtQUdflU7qVdscGiXl3601G4JOU92SkYgBqp+GuhDzvfeGrD29BC/fgDdEO/KXDOhsCnh3O/tGhCnM7N+LTkk6PAYVeB1Sb1lkTFGIhkV2+yxGrLskSobrsmcw/OaOqxwuvRoa9BARifgU4J0YSIbtOJsaAbFS3IN+7I5U7ISmxi4CmLsLH5XW/kedQnvH80AOgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovIW6cbhmsc4bcirQtOLSRZU8Bm648s52OhCPDHXLjc=;
 b=IWfaDUVL+aIk2smrBXPyzg5RDBsdUeNKUzrx3RYVAbExrJY0pK7brBy5PdD8u8/RKfehjoJpLiUcU8YJYi9YGrTN7dlHDgjoWqLdyhUFXW/RSPfcjaILubjXZ5fIgJcAHlOl3FBmv4l2MfKkkZkBwghMat9QvRBTWvyx6ZOUJ0LuhCzdqSH1p2a+QB72EdGoF5GYDtU9HsynMbO68ZPd7ZjEBYI+KE0W8uYctmdkOpcmjjuK1dlLfkBru3X9La8wx56tGcci2XuJm8Q8k7JonGXCFNpS+3ALmkazGkBpOcpBdBjVkWFlM106W6ffcVkXYowcylZpkFRRms+UbTQYhg==
Received: from SN7PR12MB6744.namprd12.prod.outlook.com (2603:10b6:806:26c::13)
 by LV5PR12MB9825.namprd12.prod.outlook.com (2603:10b6:408:2ff::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 12:33:51 +0000
Received: from SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961]) by SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961%3]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 12:33:51 +0000
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
Subject: Re: [PATCH v6 07/13] PCI: tegra194: Set LTR message request before
 PCIe link up
Thread-Topic: [PATCH v6 07/13] PCI: tegra194: Set LTR message request before
 PCIe link up
Thread-Index: AQHcpPRROTx8+OfvkEKtYNxPA+oXBrWWgL0A
Date: Fri, 27 Feb 2026 12:33:51 +0000
Message-ID: <92b47e43-d6ec-450b-add8-4cdcb66ae390@nvidia.com>
References: <20260223184151.3083221-1-mmaddireddy@nvidia.com>
 <20260223184151.3083221-8-mmaddireddy@nvidia.com>
In-Reply-To: <20260223184151.3083221-8-mmaddireddy@nvidia.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB6744:EE_|LV5PR12MB9825:EE_
x-ms-office365-filtering-correlation-id: 97957622-5a6b-4c78-68e2-08de75fc768c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 So0dbPMlOlYi3qVRh0sY3X+ZycIUVefKvVGqfqEoMCQw/jeQbh56BZ+wyOYgCcoiIt1PN66N2lNty624eWRI03ro0y0boRR1r5WOajzeHZZTuTIhS4Q501h2lR7ecxnFZc8Z0LLfc0UF7J2yXwLnEzwUchT+eRSgeM4N1TTbk2Y7WPvnIdCXNX1J1bNqgeoxdzEOzRSvWzmMreW6AtgEvKzZHlpBt0ZBpzfyU5dBRWKj2eznsg1ak/MArkjoTi83DX1DJcdDXl+K3jC8ZBlIHoxekuyigQjI404oZQG0JqoVAQG9qzDDmMpnIQJCvgZ9ihV9+S5aX/whsmH/fa9vu1iJeUQe8tEVwlYZzh9bw8ytI+jL4GVmuQ5Q2OZ3etk8FvzXaT7POfal3g2I7A2hNPVteLve9rURHXAR40aquSXHJ2YAavsYZxFkBf3gs8T8luwxYwqSQAEWelAi2SVDjSkJEUmMskhy6ShAGxs3ysTieIwUJA7hd+cU++CpCDy/CXoHD7DtOzpy7phEHOIhZFP9FP4Vr41qj6EtzVm6SyA8XKfiMaMB6v3G4ZeCNwdIlNQsbugkdi65z6sB1/bKv5fXUlFO6UGJirmnpfhyJ78m+HkQfyVG5XbPIR/NmYHJT+A+glLOBsTKK02k6rDo10oT7paQf5ICTl1GjbXVZkem5BfktZVhEFq1PtNLTfuzrLDsrrsLs1U4rmAGFNBpOY0C/IKX4gHlb77dJ5k/gndKNjl1g4Y/80qqX0o/7Wy0VTdbUQmWCvxkc+ElU1AfGu4zxz78aUEaH5113VeiklLD5iM4teZKgJbqGLun3ivW
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB6744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dnZWTjUwTW5iY2RFY20vUGk4ZGxvS3UrMzhsOVNuQlFnbnlMZlRTeGdNYjhw?=
 =?utf-8?B?aFBCSUNXZ2d2Wm5qUVliTXZpWHZCK29RalovN1RnQ2FvejNoQitDcks2K2JC?=
 =?utf-8?B?YXI0K1hmVGtXQkJ3TTFLOUNoa1I3K2FGbHJVd3d1MURma3F5TTEySk1tTzhv?=
 =?utf-8?B?Lzh5Q1pqVldEWmcvVHlwYmM2c2lzNmY5QkwzYnlRMUZKSEtpbWtNRHh0STFE?=
 =?utf-8?B?dlc3Z0w5ekZ5ZUlGOXBqTmNXcmJlajlaWWx0T21PUjArOTJqNjdleEFOeWxh?=
 =?utf-8?B?cnA0dk9xSmd3emNFZ3BlWjc5eDdRbWFtcDZZYko5NU9lZm01c3EycldOZFdC?=
 =?utf-8?B?LzRKbnU5VmVGbjJObm1Udjk5S1orbHNTUm1lUmF3ZmE5d1pyOEVBZkY3WGly?=
 =?utf-8?B?MUhPcVRTTmpBeE9SNk14YjJ3N1d0WFQxelRGeGUzeXlzVi9rU05xVEJ6WCtm?=
 =?utf-8?B?ZjdHdldSVTh1TFFXenhPN203TlUxaElxaE5WV3dGZWM5WU80ZGdIOGJkcmh6?=
 =?utf-8?B?SW01bG80UEdwMXVYVzdYMjRQb3ZMYWpCNW5yRWxPdDdmdnBEbjFNZHdUL3BI?=
 =?utf-8?B?bUVqKzBzejgwaGh0THl0cU1ZdnFVRHF2bytlRmNCeGFoZ3FndkJZdityMDF6?=
 =?utf-8?B?WE5FREU0MHc5NzFoS1ZKTlV4OWtSclBEdjNRVUU3R2QzYWF0aC9KL0JRZTB0?=
 =?utf-8?B?M1Q0V0Zsa2M4MlVIQVVFQnVMTkE0YkZkbkFvVXR1RG45YjlWNkRGb2huY2Ru?=
 =?utf-8?B?U0I0UHJhZ3VuTG5aNHVVSXh3cWJFMUZoZE1wdlQxbTJNZFhsYTROKy8xYytL?=
 =?utf-8?B?MkYxN2xJcFVaUW9SQXVJTWRwREZRemxkenNkOHRHRWFFT2NPSzNGemRzcmZF?=
 =?utf-8?B?S2VLaVZUcGc1ZWlUYUJVM2NsT0xWRUgwNkZwci9XRnRIdjRwdEJqTlVIZ2Jy?=
 =?utf-8?B?TTczeUYzR2FocHMvSi81eEt1K0UyTWE4YVNkaFFmS01kSWhEaXBvbGVrOFYx?=
 =?utf-8?B?c1VaRUFhVExweGZ0TjBCNi8ycDcvaWxVUml2bmk4bnJsS0h3NGIyaXdRNTg1?=
 =?utf-8?B?Q0luNEtybW1zSVRBcmVzOU1lN0ZqRXYxQ1IreHlCd1N5ZTYxRWIzcGQzbmt5?=
 =?utf-8?B?RUd3MDJQRmZ1cDVKa2xHM2tHdVVpU0xGQjFWVS96SitQaTRrbWExdnhtZEZZ?=
 =?utf-8?B?VCtWTllqS0N3WWJhaGJrQjZPUy9rQnpseVRvQ3hOVlZoMm9ud1lSdEJuT1Ft?=
 =?utf-8?B?ZFdvWFROeGZiaUIwL3JnenhnUTFJU0Vwb1ZiYnZDS21rQU43SHFTN3oweGh6?=
 =?utf-8?B?bEFsQU8wU1pHcXoydXRSYkRhazl4WmtPeUJ4ck9WeWd3OFRmZ2x6OG03dmlB?=
 =?utf-8?B?ZDFiSmE5V01DeGlnbVV1WVU0UlZZWnRPamJGbGRhZWx0WlN5aERZR096Y01o?=
 =?utf-8?B?QVBZZnkzRDQ2aFh5OUtPSEZrS3cvMVNNTWVEdzdYa2hMYkZ2L2ZiRzgyTmFC?=
 =?utf-8?B?THorbnA5UUlPTTdKRE82WjRNcThLbDJBQmZWOGtObVZ6OXBJVXNmeW41Smg1?=
 =?utf-8?B?R1dDVHpTYjFvbDVrdWlKVW1RS1Q1TzByMlpEcnJ3N21WUHlab2NnTVBVeVNh?=
 =?utf-8?B?RzNyaWpDRnd4bTdZdVhpYk8wQ3ZqVWsvcHR5R1lpekJzTlBDSVNWRmY5eVJH?=
 =?utf-8?B?QUJsWUdYOWMwRUFDcDgrS1ZEMGFDdmRZUW11TGpadmdwVVJsSXIxc0JkTllH?=
 =?utf-8?B?N2krcDRQWHZQOGF5dGk4WjBVZ2dZZWFVV3hRU05yWlFLeUdkMEQ1cldVRUgw?=
 =?utf-8?B?dWZER0lYeHpsUEJIYWQ0RlZ4N0JTQXhjSG5xclJaYzlROWxYYXN6T3dBcXlX?=
 =?utf-8?B?MlpGdlBJZUZWdkhlZXU2MzNhTXNCaTVGS2FMLzZtcXRyZS9KcnRsWU5hSXlK?=
 =?utf-8?B?NklodUdDTEV4MnY2Q092YzhDOWxya0lzazlrQ3VnOU9sTUU3MkRuQVR6dE44?=
 =?utf-8?B?dWM3WFhvcEJDYTdyYitZdVowSmFxN2NnRkVONjk4eFV5UDJKZUt5Y0RsMkhs?=
 =?utf-8?B?YkRheWJzcWV1QUgzVFlyaVcyT1RyTWVUcHNxZkxQaEM4RVJOL1NQcmdPTDZ2?=
 =?utf-8?B?aXRWL0VDT2duWDJwczhOaDhCbml2TnAyWGtzdmQ2OU5YWjR2T21DZ00ydHNs?=
 =?utf-8?B?cHZiOXNQazc1TzJUYktsL3c0UU1GbFR1SDVMcWRSQk5YNDQyTXloQktrZ0lh?=
 =?utf-8?B?Sm5vanZOMG9IRURIK3FhY2VYVkhaeXk5OUQ3aG44OGowNkJuU0poSnRvVVhE?=
 =?utf-8?B?S01OWTNNUHZLWVg5dXVGUmphWGd1VjcxNTBGYURIYlNIV01aeG5TUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <53F5B665895DAC4B9C1C6126BBBD37D8@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 97957622-5a6b-4c78-68e2-08de75fc768c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 12:33:51.3834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y6PCk0/abm/DPwx29Y7JaCvcaZMmLjUT+UBdoEJFIcgLOPg1H/x9xWIwzngcKjYww99Gbx8OE8Biy2f7k4qKaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9825

T24gMjQvMDIvMjYgMDA6MTEsIE1hbmlrYW50YSBNYWRkaXJlZGR5IHdyb3RlOg0KPiBGcm9tOiBW
aWR5YSBTYWdhciA8dmlkeWFzQG52aWRpYS5jb20+DQo+IA0KPiBMVFIgbWVzc2FnZSBzaG91bGQg
YmUgc2VudCBhcyBzb29uIGFzIHRoZSByb290IHBvcnQgZW5hYmxlcyBMVFIgaW4gdGhlDQo+IGVu
ZHBvaW50LiBTZXQgc25vb3AgJiBubyBzbm9vcCBMVFIgdGltaW5nIGFuZCBMVFIgbWVzc2FnZSBy
ZXF1ZXN0IGJlZm9yZQ0KPiBQQ0llIGxpbmtzIHVwLiBUaGlzIGVuc3VyZXMgdGhhdCBMVFIgbWVz
c2FnZSBpcyBzZW50IHVwc3RyZWFtIGFzIHNvb24gYXMNCj4gTFRSIGlzIGVuYWJsZWQuDQo+IA0K
PiBGaXhlczogYzU3MjQ3Zjk0MGU4ICgiUENJOiB0ZWdyYTogQWRkIHN1cHBvcnQgZm9yIFBDSWUg
ZW5kcG9pbnQgbW9kZSBpbiBUZWdyYTE5NCIpDQo+IFNpZ25lZC1vZmYtYnk6IFZpZHlhIFNhZ2Fy
IDx2aWR5YXNAbnZpZGlhLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogTWFuaWthbnRhIE1hZGRpcmVk
ZHkgPG1tYWRkaXJlZGR5QG52aWRpYS5jb20+DQo+IC0tLQ0KPiBDaGFuZ2VzIFYxIC0+IFY2OiBO
b25lDQo+IA0KPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS10ZWdyYTE5NC5jIHwg
MTUgKysrKysrLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA5
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaWUtdGVncmExOTQuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtdGVn
cmExOTQuYw0KPiBpbmRleCBhNjg2OGI3N2UzYjcuLmFkMTA1NmQ2OGQ2ZCAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS10ZWdyYTE5NC5jDQo+ICsrKyBiL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtdGVncmExOTQuYw0KPiBAQCAtMTI0LDYgKzEy
NCw3IEBADQo+ICANCj4gICNkZWZpbmUgQVBQTF9MVFJfTVNHXzEJCQkJMHhDNA0KPiAgI2RlZmlu
ZSBMVFJfTVNHX1JFUQkJCQlCSVQoMTUpDQo+ICsjZGVmaW5lIExUUl9NU1RfTk9fU05PT1BfU0hJ
RlQJCQkxNg0KPiAgI2RlZmluZSBMVFJfTk9TTk9PUF9NU0dfUkVRCQkJQklUKDMxKQ0KPiAgDQo+
ICAjZGVmaW5lIEFQUExfTFRSX01TR18yCQkJCTB4QzgNCj4gQEAgLTQ4OCwxNSArNDg5LDYgQEAg
c3RhdGljIGlycXJldHVybl90IHRlZ3JhX3BjaWVfZXBfaXJxX3RocmVhZChpbnQgaXJxLCB2b2lk
ICphcmcpDQo+ICAJaWYgKHZhbCAmIFBDSV9DT01NQU5EX01BU1RFUikgew0KPiAgCQlrdGltZV90
IHRpbWVvdXQ7DQo+ICANCj4gLQkJLyogMTEwdXMgZm9yIGJvdGggc25vb3AgYW5kIG5vLXNub29w
ICovDQo+IC0JCXZhbCA9IEZJRUxEX1BSRVAoUENJX0xUUl9WQUxVRV9NQVNLLCAxMTApIHwNCj4g
LQkJICAgICAgRklFTERfUFJFUChQQ0lfTFRSX1NDQUxFX01BU0ssIDIpIHwNCj4gLQkJICAgICAg
TFRSX01TR19SRVEgfA0KPiAtCQkgICAgICBGSUVMRF9QUkVQKFBDSV9MVFJfTk9TTk9PUF9WQUxV
RSwgMTEwKSB8DQo+IC0JCSAgICAgIEZJRUxEX1BSRVAoUENJX0xUUl9OT1NOT09QX1NDQUxFLCAy
KSB8DQo+IC0JCSAgICAgIExUUl9OT1NOT09QX01TR19SRVE7DQo+IC0JCWFwcGxfd3JpdGVsKHBj
aWUsIHZhbCwgQVBQTF9MVFJfTVNHXzEpOw0KPiAtDQo+ICAJCS8qIFNlbmQgTFRSIHVwc3RyZWFt
ICovDQo+ICAJCXZhbCA9IGFwcGxfcmVhZGwocGNpZSwgQVBQTF9MVFJfTVNHXzIpOw0KPiAgCQl2
YWwgfD0gQVBQTF9MVFJfTVNHXzJfTFRSX01TR19SRVFfU1RBVEU7DQo+IEBAIC0xODA1LDYgKzE3
OTcsMTEgQEAgc3RhdGljIHZvaWQgcGV4X2VwX2V2ZW50X3BleF9yc3RfZGVhc3NlcnQoc3RydWN0
IHRlZ3JhX3BjaWVfZHcgKnBjaWUpDQo+ICAJdmFsIHw9IEFQUExfSU5UUl9FTl9MMV8wXzBfUkRM
SF9MSU5LX1VQX0lOVF9FTjsNCj4gIAlhcHBsX3dyaXRlbChwY2llLCB2YWwsIEFQUExfSU5UUl9F
Tl9MMV8wXzApOw0KPiAgDQo+ICsJLyogMTEwdXMgZm9yIGJvdGggc25vb3AgYW5kIG5vLXNub29w
ICovDQo+ICsJdmFsID0gMTEwIHwgKDIgPDwgUENJX0xUUl9TQ0FMRV9TSElGVCkgfCBMVFJfTVNH
X1JFUTsNCj4gKwl2YWwgfD0gKHZhbCA8PCBMVFJfTVNUX05PX1NOT09QX1NISUZUKTsNCj4gKwlh
cHBsX3dyaXRlbChwY2llLCB2YWwsIEFQUExfTFRSX01TR18xKTsNCj4gKw0KPiAgCXJlc2V0X2Nv
bnRyb2xfZGVhc3NlcnQocGNpZS0+Y29yZV9yc3QpOw0KPiAgDQo+ICAJdmFsID0gZHdfcGNpZV9y
ZWFkbF9kYmkocGNpLCBQQ0lFX0xJTktfV0lEVEhfU1BFRURfQ09OVFJPTCk7DQoNClJldmlld2Vk
LWJ5OiBWaWR5YSBTYWdhciA8dmlkeWFzQG52aWRpYS5jb20+DQo=
