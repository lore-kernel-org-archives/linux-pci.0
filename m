Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010011.outbound.protection.outlook.com [52.101.193.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BA23E9F72;
	Fri, 27 Feb 2026 12:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772195704; cv=fail; b=bs1JjzIK3Lew381Xp4x/q3cBH1QMW7Hd2CcWUbnf4MF1aAhSXEfhzG/TxPoLlWkzSi0Q3JtgonXFiM3x2AppeLETu7wd1iJ5eovzD5HSQInyhWhb0sryc2Q762IiOuUCnFMaRhmyQlZExK5LsZ9CxirbKQSb6LTzQtRlZiuI+TA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772195704; c=relaxed/simple;
	bh=No3Ci4EdV+BTGYu9bln2DqsXi4dEtE1DGEk5MzpHzaM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HwMRLq4wce0j2a5KqjCipyc+21pbCyXnz0LYH1PPifOGqgNhReyhwY5S1cnYMgEGzT5QSsXr0vEuJAM5A0p7EUvhzT4bCSe0gCVcRWZgssT7NaYZTvtp4Y25IQFZIzKJR4OZZ/NX+9Lmh20/omd7kV7mBYrntD86hvmMC0s+2SY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UZKq2Wky; arc=fail smtp.client-ip=52.101.193.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UZKq2Wky"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+THJjLKDTUi7IJ8Yh+fxOmKJ647C5+xJSfU06VPBk7Kuhabjj0WuS9sQYAuCL1ODMll2RYNWllIfv40HuVG1n1uIfFjrrJ1IDVedBChHb9zdVWL5UcX+utyYltQwDdebtC2890XLXwGmCTybMSClwtkTuWSGetvK5+pv4L4S8Su6DPbOSm+sqpUh+GcI5rS8oNgkRiDC4I2wDrxWy72Z3klLDGfeMRcBMnHsNcJfS8xpAQAsUil1B53fwxgb+vhRSymZ5/ffNe+O9AdXHp6vuKXydaHSgxYXJ3NWKC05W+T62zdxdVn6vROP4yXHIFAgBHOlLV2bvKSXh30iUWUOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=No3Ci4EdV+BTGYu9bln2DqsXi4dEtE1DGEk5MzpHzaM=;
 b=IEnm3Pfdem6NgAtu8dnvbEMnaN/EUtLO5TcL3+Qjf6dz3olYG9yjhWaBUEkjUzSI3lV+mvZIEFY1WUFHcriB9e3U1Ieh4RItpyPXNoWX/MQJYf5fbE+otugOJZ9SYfaJ6rg1zcfw+TmNFVeSU21AeULKTYJOA8v5Ulo6tkJSBXXQKILuGkXYO77KN/I3bxGxuFwpSuo2XnONo/rp+h6Xbb5YqZKfXyfYowtbwlGbV9WwbB1oN4HaJR5S8pAtlEb1C/tLGs2eLyPifKeCno3l49gNbKpvOurIITo1DTTKj0F4F7CGY/arCIYoaBn57cQ2V28xxIiIi5TOvBeC9zJIiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=No3Ci4EdV+BTGYu9bln2DqsXi4dEtE1DGEk5MzpHzaM=;
 b=UZKq2Wky+nevDCAjNGoJYBB8ZmuNdd3+URZSaqt8r+42+t71u4wnHjcPjcivLTcQtdkRKg/MpSTuiDZoIdqkrOYCV/onwFNyvPaL+OcWF40EoBuoFniB6SWNufG6sAIUrO9jKFIjmZ4AgQpHO/m17iG3HYLpnMggP0izYHg4jptABu2bOkAGYuMlg0z4Ofj2shTS4Igu0VD78CUiKeWU8dZUaQ4avuAZkHGk0HJkFBwVHHL8nyx5BYhNcXpQO3pRT3aCR7XsmH7lI3LRTwzC07X+r0sF6VKAztZUWbVJUK7uHSWyn6vB6/+MRC+AZU98j5ikdrXwSSNLHPnzNTemrA==
Received: from SN7PR12MB6744.namprd12.prod.outlook.com (2603:10b6:806:26c::13)
 by LV5PR12MB9825.namprd12.prod.outlook.com (2603:10b6:408:2ff::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 12:34:59 +0000
Received: from SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961]) by SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961%3]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 12:34:59 +0000
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
Subject: Re: [PATCH v6 13/13] PCI: tegra194: Free resources during controller
 deinitialization
Thread-Topic: [PATCH v6 13/13] PCI: tegra194: Free resources during controller
 deinitialization
Thread-Index: AQHcpPRoztFDWmbla0m/szhINLUA97WWgQ+A
Date: Fri, 27 Feb 2026 12:34:59 +0000
Message-ID: <cc4d05f7-701e-4cd7-85e1-4553ab3cb7e2@nvidia.com>
References: <20260223184151.3083221-1-mmaddireddy@nvidia.com>
 <20260223184151.3083221-14-mmaddireddy@nvidia.com>
In-Reply-To: <20260223184151.3083221-14-mmaddireddy@nvidia.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB6744:EE_|LV5PR12MB9825:EE_
x-ms-office365-filtering-correlation-id: 664e70f8-af19-42bc-546b-08de75fc9f41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 NQ89Fn7S7foe+oTfUt3by0rRsxfCyE4SJFR0RuuvU+mCtC6ta3N6hYWL64W2+Z8W50EyM60iFuVNQ57PLGgQD0UL0fx0Ftc7w1w6ekY2Ybt48DNCqbEj2zP5mSteazBDTdcyrQRmXIRfvRFDcizX9Z7oYVy+dojQ7ffKh+E1YnLE/p/FQZ9KsTuGd3if5BR+tR7WjjOXToAB6r5V25mh+F7xDgrXiYbI7sojCoJy1wrZ+a1sOLUNEAeea20v1tK6ESlswxKeauVlTQDzZRM9oFygVLhrIzAKvufKI5bzTi2cTjpT/rV5O+pnMrPG1lE0H9/GpwEV+rOplf93Ncyin2yX2wu0NKhXGDdxQOLWZpj4t4soqJP44v2TC0YCW/YTuqY/h+iQKdPiQJjXJV7l3/bU8d5ARZY3wkEOcDsqMY/qC0/dMu+1YCCShe69WxQoG0lUuE3s4ws9nX986DLYtmoJM5goh0Rl78OXy00Vv624SF5GYkaTQQnqB+Qgbyq/OKYjw6ikhk3P7MORwytoA9d7lCqH/ukFk+f/KwyBYTJJ3HRa8PQCO2uqIN315sz9YutJ/nRx65iQM99yZ85H3hzmIzQNz1l9ry4B/y6vyGQniCS2KN2QxvxYlsQJYPMOMpvgK2HeELbhis+wwXA8Tkkv0flgW02T/bIhQVfrhPd51a/CK63ODornIrXru4/hU1/Hu/NGWfac0Vab6zk0W/2G0hdkOgk7i8gyTiSKcpt4o3w2fEbiAb8tPuAboE6lSSfYIXq6WxKEsUXs5UqFNS+1LSoDJdmNgXAnGzbgVTBzvcfFz2TqmWwM4JHUcg/5
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB6744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NGlad1hUK0JIQUNoVTVwOHFYcVlmWHFCT21tc1lCdk5BYXpjeXh2cElIMmQy?=
 =?utf-8?B?Ly9xOFduVHI1djZVZmFaenBDUTF2R1JrSndIa0x2RGdla3I3TWovbEthYzE4?=
 =?utf-8?B?akhNZjZIaWxteE5qVlRnSjlQOHdna1d5L2FVeEk5UkM4YTFUbDE1RzR3ajV3?=
 =?utf-8?B?QmVHWGdxZVpQVTlLWXRqUVh6YzMxdEMzVTkzMGhzeUlUMkZOYVpvVkI0Mjh5?=
 =?utf-8?B?ME9ySlhWRUVZWkJuMzU5ZmJNNVF0Y0xvMkxqeGFpREZTM3MweFVzSjl1YkZp?=
 =?utf-8?B?ZTlrMHBscW5qTWZIVkVUUzU0ZEYyL2tWdXVnTDN3WEYrLytnRFluMDgrOHh5?=
 =?utf-8?B?d29SVGdPZlpXL1RIL2wzZFhmQmpaYU15R1p6RUp5T2x4am01WEJId2wzREVp?=
 =?utf-8?B?cGhKbjIxM09Bd3IyRE5YUVNFZUQxWmZQZFJFM3J1czBIK0VFbjBXa0lxUUVK?=
 =?utf-8?B?NlhSM0krZEtxNFR0QTRPUEtVdTZURVp2NGhmNENTQmtMUnBseUdqVjFtQjVF?=
 =?utf-8?B?Q3RneHd3VlVsZDFEakVFcXAyL29YOU9NSm9DUFV4NnFhaTRjZlY2cU9CVXBs?=
 =?utf-8?B?NWRkZVBBQm94bWFTcXVtOGtoYXdQTmh4dWFSaWtYTXZaMlArb2lEcHNwZi9a?=
 =?utf-8?B?dFk0QUhJRHJJc3FkQVA0a1l0Y0JlVnBSQ2FFTHVQTnJMa2RHeGlUdnVXMlFJ?=
 =?utf-8?B?RXA3U2sra2EyMXV5SEJteldYTG80WS9MN2hhSXEwa0ZJWDZwdjkwNHhUNjdH?=
 =?utf-8?B?KytDU2x0aWIvSDhXK3JiU004TmdiWG1uRU94SVdzQVlHa2FZWVAzSGFJd3ly?=
 =?utf-8?B?MUZKb3prMW0yek5IekNpVldjUVI4ZUNFVk1vclRiUDZyK1VlblZ3NnhSVUQ4?=
 =?utf-8?B?aU1GQXJudC9RTDA2WFZ6K25rU2RWYlNzc0RVUzM0dnpIK01SVm5QZTduOXJt?=
 =?utf-8?B?MlFDdU42ZVBOUldTMXMzUHljN0NJZE96bG5jT08wamFOZmxHcEMzSnNHNGxF?=
 =?utf-8?B?RmlXc0RHQXZFbzdTeGo0a3B2Z0NVVGtpT1JiRnE3UmFVYXowcE1TdUFIWXE3?=
 =?utf-8?B?cnpvcDFKUWFNTlBQQnlUZ3E2czRQMmtIaTl0cm9wclBmK090cTJyTmFreW4v?=
 =?utf-8?B?S0FvQ084QTRIeUg2RXBzdk5OR0RMVmoyN1o4Vy96L2xyU0MrQjc3YU13Ukp2?=
 =?utf-8?B?TTM0TzNqSGV3RWhUTXFkd1RLbDNuR2tyZDZRNjZZZ1lqRFFxTklRcllFZ2Zn?=
 =?utf-8?B?ZkVYZ2p6anhxL0sxL1JraUNLNmZzN1ZmUUVPV2VKVHNJZWw4L2NxSGV3RW1B?=
 =?utf-8?B?Ymd6Z3F4N2JzNGZGU3ZQSThRWlVQNUhGT3UvelBqWWxCNVQ2TjVFc0VaL0Rh?=
 =?utf-8?B?MFR6TXo5S2tXMExtRnFKdHJFbzY5ZndJMTJ5c0lNTFQ5NDNpQkpNdW5CVGhz?=
 =?utf-8?B?YTh4OHY2U1g2K2V4eTJhYmN4dkZuYk80RnZVOEpna1NQTE5IOERUd3Z2UGFP?=
 =?utf-8?B?d1g1NzlLQ3hCYnlIVnNuK3k0VUg5ZEhJNlBGUFNNcU9kMTd6RVFxbVhtM0NV?=
 =?utf-8?B?TnVzTjBwbzhNU1hLNWE0aHRxclhJZHc5M0VvTWJpTXdmcjlZaDdkcUhGNkRl?=
 =?utf-8?B?c0MyOCs5VU9VUGVkbHNhQjRVNkVYaDFpOHJLWXk3Q3h0MDlleEhaRmVRbVpM?=
 =?utf-8?B?Vklnejc2c3JYSXBCK3FOZ1BXWlhSbHg0MnZZNzBLQ0w1RURIOXFMWDFLRCs2?=
 =?utf-8?B?UkZHVGZRRU4yZ1kvbXd1Skh2QUpMd3MrTFJkZUxqeXRLUlYyRXlMWkdGVUZK?=
 =?utf-8?B?SlViaS9CTjAxRjFmOEwvZGlBZ2Q3KzZ3QVlHbzcvaFM4dWx6ZXhWU2QvMFdT?=
 =?utf-8?B?SmJxTkVreExEME4rbHdjU3h2YWFBT1FQME5jcllJVjh4aUJCYllqcUQ2amRE?=
 =?utf-8?B?UEFoR2l4YnFJUWNxTnJ4TW80VGdSSlRIc0w0cHd6SnluejFVNFc0TW9OWkVv?=
 =?utf-8?B?dnc4ZzB4Z1BlMjJmQVlhSmYyczgvbWtWUUsyQmdtbTh4UnMxeDZvSjc5MmxC?=
 =?utf-8?B?SE9vSXVyeXVCNGxVbGN5UjlhN2lKVTVWMXU5Q0plZ1dVZXdHbEUxc1oxYzkz?=
 =?utf-8?B?TXUwZkJDOWJZOEZOUGJ2THU1NUQ4VjhNbWZiVGMzNkQvQzdVNXB5VWRSN1Z4?=
 =?utf-8?B?cUVJdXBGaXh4SEVkTHpjTnAxQkp5U0xMKzBYQ0hWWXloL0QrOWV0am9sTVY0?=
 =?utf-8?B?L3hOUlFsa01Ta2pCa2xpQmxmSTJxVkhHRFl5U0ExQmRZNDUrSlByUTdZWWhy?=
 =?utf-8?B?c2lFSDR4K01MTzNuRmo3T0pFdC85MFNJOFZJWjR0K1NNeEcvd1hsdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <863F328E1196FE4CB272F137AE30C158@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 664e70f8-af19-42bc-546b-08de75fc9f41
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 12:34:59.7155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KSwpHr6l6SorQrQTaGOXh3yRXUDgkv+xYC92QTBiGnxzT4bhewNA6LU6rK8QiXFrad5MMIBUjUHsmlDIZ1zSUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9825

T24gMjQvMDIvMjYgMDA6MTEsIE1hbmlrYW50YSBNYWRkaXJlZGR5IHdyb3RlOg0KPiBGcm9tOiBW
aWR5YSBTYWdhciA8dmlkeWFzQG52aWRpYS5jb20+DQo+IA0KPiBDYWxsIHBjaV9lcGNfZGVpbml0
X25vdGlmeSgpIGR1cmluZyBjb250cm9sbGVyIGRlaW5pdGlhbGl6YXRpb24gdG8gZnJlZSB0aGUN
Cj4gcmVzb3VyY2VzIGFsbG9jYXRlZCBieSBFbmRwb2ludCBmdW5jdGlvbiBkcml2ZXIuIFRoaXMg
aXMgc2FmZSB0byBjYWxsDQo+IGR1cmluZyBQQ0llIGFzc2VydCBzZXF1ZW5jZSBiZWNhdXNlIHdl
IGRvbid0IGV4cGVjdCBFbmRwb2ludCBmdW5jdGlvbg0KPiBkcml2ZXIgdG8gdG91Y2ggaGFyZHdh
cmUgaW4gZGVpbml0IGZ1bmN0aW9uLg0KPiANCj4gRml4ZXM6IDQwZTIxMjUzODFkYyAoIlBDSTog
dGVncmExOTQ6IE1vdmUgY29udHJvbGxlciBjbGVhbnVwcyB0byBwZXhfZXBfZXZlbnRfcGV4X3Jz
dF9kZWFzc2VydCgpIikNCj4gU2lnbmVkLW9mZi1ieTogVmlkeWEgU2FnYXIgPHZpZHlhc0Budmlk
aWEuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBNYW5pa2FudGEgTWFkZGlyZWRkeSA8bW1hZGRpcmVk
ZHlAbnZpZGlhLmNvbT4NCj4gLS0tDQo+IENoYW5nZXMgVjUgLT4gVjY6IE5vbmUNCj4gQ2hhbmdl
cyBWNCAtPiBWNTogUmVtb3ZlIHBjaV9lcGNfZGVpbml0X25vdGlmeSgpIGNhbGwgZnJvbSBwZXhf
ZXBfZXZlbnRfcGV4X3JzdF9kZWFzc2VydCgpDQo+IENoYW5nZXMgVjEgLT4gVjQ6IE5vbmUNCj4g
DQo+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLXRlZ3JhMTk0LmMgfCA1ICsrKyst
DQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS10ZWdyYTE5NC5j
IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS10ZWdyYTE5NC5jDQo+IGluZGV4IDI1
NmE1ZDFlYmExNi4uOTg4M2QxNGY3Zjk3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL2R3Yy9wY2llLXRlZ3JhMTk0LmMNCj4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxl
ci9kd2MvcGNpZS10ZWdyYTE5NC5jDQo+IEBAIC0xNjI3LDEyICsxNjI3LDE2IEBAIHN0YXRpYyBp
bnQgdGVncmFfcGNpZV9jb25maWdfcnAoc3RydWN0IHRlZ3JhX3BjaWVfZHcgKnBjaWUpDQo+ICAN
Cj4gIHN0YXRpYyB2b2lkIHBleF9lcF9ldmVudF9wZXhfcnN0X2Fzc2VydChzdHJ1Y3QgdGVncmFf
cGNpZV9kdyAqcGNpZSkNCj4gIHsNCj4gKwlzdHJ1Y3QgZHdfcGNpZSAqcGNpID0gJnBjaWUtPnBj
aTsNCj4gKwlzdHJ1Y3QgZHdfcGNpZV9lcCAqZXAgPSAmcGNpLT5lcDsNCj4gIAl1MzIgdmFsOw0K
PiAgCWludCByZXQ7DQo+ICANCj4gIAlpZiAocGNpZS0+ZXBfc3RhdGUgPT0gRVBfU1RBVEVfRElT
QUJMRUQpDQo+ICAJCXJldHVybjsNCj4gIA0KPiArCXBjaV9lcGNfZGVpbml0X25vdGlmeShlcC0+
ZXBjKTsNCj4gKw0KPiAgCXJldCA9IHJlYWRsX3BvbGxfdGltZW91dChwY2llLT5hcHBsX2Jhc2Ug
KyBBUFBMX0RFQlVHLCB2YWwsDQo+ICAJCSgodmFsICYgQVBQTF9ERUJVR19MVFNTTV9TVEFURV9N
QVNLKSA9PSBMVFNTTV9TVEFURV9ERVRFQ1RfUVVJRVQpIHx8DQo+ICAJCSgodmFsICYgQVBQTF9E
RUJVR19MVFNTTV9TVEFURV9NQVNLKSA9PSBMVFNTTV9TVEFURV9ERVRFQ1RfQUNUKSB8fA0KPiBA
QCAtMTc5NSw3ICsxNzk5LDYgQEAgc3RhdGljIHZvaWQgcGV4X2VwX2V2ZW50X3BleF9yc3RfZGVh
c3NlcnQoc3RydWN0IHRlZ3JhX3BjaWVfZHcgKnBjaWUpDQo+ICAJcmVzZXRfY29udHJvbF9kZWFz
c2VydChwY2llLT5jb3JlX3JzdCk7DQo+ICANCj4gIAkvKiBQZXJmb3JtIGNsZWFudXAgdGhhdCBy
ZXF1aXJlcyByZWZjbGsgYW5kIGNvcmUgcmVzZXQgZGVhc3NlcnRlZCAqLw0KPiAtCXBjaV9lcGNf
ZGVpbml0X25vdGlmeShwY2llLT5wY2kuZXAuZXBjKTsNCj4gIAlkd19wY2llX2VwX2NsZWFudXAo
JnBjaWUtPnBjaS5lcCk7DQo+ICANCj4gIAl2YWwgPSBkd19wY2llX3JlYWRsX2RiaShwY2ksIFBD
SUVfTElOS19XSURUSF9TUEVFRF9DT05UUk9MKTsNCg0KUmV2aWV3ZWQtYnk6IFZpZHlhIFNhZ2Fy
IDx2aWR5YXNAbnZpZGlhLmNvbT4NCg==
