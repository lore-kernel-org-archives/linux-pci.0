Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011021.outbound.protection.outlook.com [40.107.208.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3971C25C6F9;
	Fri, 27 Feb 2026 12:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772195659; cv=fail; b=DZTsWNRgTNfCBY7hLMPiwDQj2pezhJx1VfVZYaiQl04NCApu21yi/zqwe2D0tfvEDQ0I1g2KwFQMUwOVENzwyTNz15dQ7vm/1ZbwMnu2o1mQpaFdu6gvfsomHFlYETnw6RzSObL38mfmg7cS0uJadAqE54wpELKyu1s8ExGHjOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772195659; c=relaxed/simple;
	bh=W+TRa/25B6iuHtvJIYX4ioAFUb4wF6W4oEQvkq7iCMk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tyB1SDySb1LgRmDTnb36N/QqkLkQnABRg9Gejo+hMmVuVNUk5lMKONKKbpxJ264xNDJSxeZMC0dvIkg9w5uRsfOVQd2AuP7/9eY7TyeSmHY5iFpLwARdvhTyBgbMGQf8rcW2rnKyg3V81Ks35XpXKZ7a28/LPj5Igjhr+IrgB1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R/Oc2l7H; arc=fail smtp.client-ip=40.107.208.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R/Oc2l7H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DNxLKMxYlb1hjPgu4HVmUVt30WK6ucGLgd21ASbh+kbjqVS4DiKa4b+gW5U1F9nuH6y06H+6g4x2YDrU8yoHNMr7Q9r5EpUhM/SY/rpSzDTwt39Jb56penNHlmuxKWDM/v3xDXE4rfN8MJyhdff84j5opnDoEjJpbflT+KTXNCfa3BLyOMiS0rfiooVNqQwGyQwCsDZmyYzIYpr6eSIK0rtmVuGHEuearyaauofYvN5fzeGMmlDfBreL5d5c/Mhrvm/ox1uVYye95rbkY2SKkOfVVpCrbPEq2GOwHYUKYjfqyQ5YPBdtQeyq+nvEo1aNcZvpUNEwepvqbFQT1k+skg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+TRa/25B6iuHtvJIYX4ioAFUb4wF6W4oEQvkq7iCMk=;
 b=IzRqsInwIN2E2kOL8SQtoFVgQIk6IlyQwVZIYqv8TEgbongxlPCRttLinBNh3eH6rZVdpnOOwoOXT5bqivLt5zBVBI4kcc/wUOXeJ9KlX/jd9i1+KEYvDeNZqsVjShRW11jP/+oFOKDxJZJ7/cnlb2RP6wEdDqgUN0mJFZggaAPO1ACQPOjSClrtjYXuZfjkp/sn00LzVRIE/8g2VwNoC53CDfkb9nMXDCmbAlK7ESxFk2MlDp9SnybRZa0CkluBwYc9pwmb3Smlpb+055vEdBveDnbA/ae4K3CSRmrPV9fOx4UwzZh/MLZMVaAUxf6AoDZpDjNmZ2iE+ruJeEd/xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+TRa/25B6iuHtvJIYX4ioAFUb4wF6W4oEQvkq7iCMk=;
 b=R/Oc2l7HBakoupeXjZCS8b8TXubGVSRm1caagn5XReJV6HOJ9SAzyu/64IyONONuh+iqWG//8BNi5ExPg2/bufsgF2HDVzE+q5/nKs7pwfbV9hAC4zdKCHFBj1/Fg7UL4Vd51wFoPtHeHadrIBInUxafbjlBbbhN7jrc/l5ulUhBFh2T2N1UrDQc/1Tdr03hvN4Im/EHXs8WkYqZEH7MYtywB2krH5YXnJhtLI+TOOy3VRVV3l2yNq8DitZFxVJz4JxVLRFR68UKCLffoqeIPsd+OsXsB2FsPewgnaqRMgDGG/F34DiJmzi2vk42OIJNuomnZQZFRddjLxdPKAgTRg==
Received: from SN7PR12MB6744.namprd12.prod.outlook.com (2603:10b6:806:26c::13)
 by LV5PR12MB9825.namprd12.prod.outlook.com (2603:10b6:408:2ff::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 12:34:15 +0000
Received: from SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961]) by SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961%3]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 12:34:15 +0000
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
Subject: Re: [PATCH v6 09/13] PCI: tegra194: Allow system suspend when the
 Endpoint link is not up
Thread-Topic: [PATCH v6 09/13] PCI: tegra194: Allow system suspend when the
 Endpoint link is not up
Thread-Index: AQHcpPRX/Ef2+ZMUCkCDNXyJ/ZWmk7WWgNmA
Date: Fri, 27 Feb 2026 12:34:15 +0000
Message-ID: <2d40043f-fe41-4d7d-ae2b-a581dad8134f@nvidia.com>
References: <20260223184151.3083221-1-mmaddireddy@nvidia.com>
 <20260223184151.3083221-10-mmaddireddy@nvidia.com>
In-Reply-To: <20260223184151.3083221-10-mmaddireddy@nvidia.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB6744:EE_|LV5PR12MB9825:EE_
x-ms-office365-filtering-correlation-id: 38580012-0302-4794-a7a7-08de75fc84a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 4WIOdHPkJyeEDzV3wPEBj8C+Bjhwp89SRzaPSq5YZBZzpHR0ZAtOPTs8TW/4piqqI8zCbRB3Xb/gczVPEbZVamZQWIK4KjAW3jFfMO7dgB47cmLlyz5ooe+3E+mU6f5yNPdJBohmh8n5PT2CddK/aILxEHEkAcltx2Ltn0CnGY21pA7TKZl7RLEVfSAWsKY/1KWnkypC5iNRVyoqVPxYbAdI9yUBLpQisKeCsZxlfWWAvycWBk4e7mLl3JbcAhGNlAjbsshAtWINDryZgHHszBv2XS9lVhoQ0GbQymR6K+zmTsRxbzKNz0dWja3lgusEMkAAfhnHo9PBqczIbzua6Q/LWhUpncY9QmQvWOxjA+0ZN7V6O26pzWTFRjRMWMcpJmo7OSpCciAq5OhX17p4LVBX4p5uWOG8Rdnq+TMQyyZMKfVZmnwqRSkyINP5mTndAneeH/rymik2OEt48jnphVHy6bAFbRsdSUW5urTrv5dubyKaKwYk60GwuEHUufhSIwQDjJg76cnYMbR0nev3CjxaWmi3jRuaZ6yRALduck/7mzeh+KwJ4eDd1jXGw5iwrG1I0DL8H6DLIE/BwTj+c42MIdlen4wKxAkboBpmT8jUHThrY7WzZkwx/PPavmSdypkWciVS7M9LI94THW6HUq/Lr4vH9YlRRaL2m5JqSv1vaty9Y7sV4jNo6d3N7aiinVOgRvLyl0lQa+qHrlt6g1JLCsupqc2pdgdiQT6vIeEWvvGgGCJ1ZIy2+oJlK4hV7pP4qyiL7iDw7D3QM3+aZNwLrPVKLOTjKtNM3KnL2Ylm7rZEhOeW9IWBV0zsPMk7
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB6744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d0JCUllIbGJtd3paUjZTWnM1T1IrMS9PbndRZzlvUjRUVkF4UDhrZkZvdWsr?=
 =?utf-8?B?dVMycUVDM0VxbnNlWThET0pLdWNvV0VhaWR2MVRQZklNOVJnaDFyU1kraTBj?=
 =?utf-8?B?TmNHYUZnczl1ZGFIVG1jNzUycmhobGhQdHpnUlUxUHI2SXFscmxBMG9WR3NQ?=
 =?utf-8?B?MEFtYy9YZVpkdTdNU0RzNDdIT1NOMGpRWkZyMmFsWUlyOFp6LzJoSGFqbmdJ?=
 =?utf-8?B?Q3FERnpCWVdnQU82S0FVaHVLa0RST2FEckZQQ1FqcDVxUmN0SFJiTFNpTlpi?=
 =?utf-8?B?QTY0ekVTNGgyc2R5MytsaDhwQXJqbzhFdi9SVm5IYlVYaDdnTEZ3akRFNytU?=
 =?utf-8?B?VTR6K3pGTTBsalYyZi9rMkcrQy9PdEp4akx4U1NkYyt6MzdBdi9xUS80dmZ1?=
 =?utf-8?B?eUtrQ2RzanZxOW1BMXFWb21sVTVGWWp0NUJxWE5TelBUU3RDYWZsMDZNTGpK?=
 =?utf-8?B?TEl5WXVkeWUxVUkvZ1V5ZTh2NWtTS2tSQndKZ3pacXBHb0plekE5K3VkOXJ1?=
 =?utf-8?B?S3ZOY0k5SGVwQ0VYNEV1NTV5OG5lL1QyY0ttZXVDeVNaNHp4dDl4ek5PR29s?=
 =?utf-8?B?RnlSYk94Ym9aWnNmSUJmOCtyMDVSUERTVlN6akNvSE9DTEgwMU4rR1E1aGY5?=
 =?utf-8?B?QWVMazlMYlN0Z1R3SE4vc2xnUWlUOU13cW8yUlM1Ymc2N2lpQ0p4eW5IOGl6?=
 =?utf-8?B?dnpjR1ZJN01kcWM3aStrWkxCVWcvTXVlUFFDNFlwSFBldjRObzNlSzFPaWQz?=
 =?utf-8?B?U1NLV29DUG8rR0UrTXFPYnQra3diNGk4U2lxTVlqVTlXRk1JdXpOb3FYK1pp?=
 =?utf-8?B?dWtCME4zTHRjUHBld2Zidm9PaGxIT2N3NlQxWEZJdVVrK294UkY0bW5UNlZW?=
 =?utf-8?B?Um1YdTAyd2pXMnNpOGRtK0ZYdldBd0FNbEVGcDJTbkNDZ0ovd0JWYjJjT1o5?=
 =?utf-8?B?NU8rQUx4MnMvbVZic0UzcHpsZENRd0hoWVIvK24zZ29QczFva0ZYVmRNakF2?=
 =?utf-8?B?MEI1OElzdFZObE1SVE1uYk52ejIwWGdEY0Q4TnFlNjJaYlV6Nlo2OEQzTXhh?=
 =?utf-8?B?TDFadHY1VVZZU1Z5b0FPRTQrYnYrVXFQTTBRcjduaUV5MFEyMUp5R3QxYThV?=
 =?utf-8?B?QTNVMEhWMmIrTktGSzFsRUNQQVBoblhQWTJ4eGRPczdJSXhXRDdlRkVFSU1Z?=
 =?utf-8?B?OERWenNVSDBXMDVhejlqMEZ3MzBXMm9ycTR1dmpMZ0RxZ0JOV3llWU5KSGha?=
 =?utf-8?B?RVU4a3U5SldsNHgrclJGMEh5aVR5MzlHcndWV2xreG9LRlFrc2NoMWorOENS?=
 =?utf-8?B?R3hMSzhTUWVFZGM4RERQZ0d5aDlpNm9GYk5FSnU1TnNUdUl1UXNCYWxaQ2xn?=
 =?utf-8?B?OU56NmQ3bVRRekI4aU9kZXVERWQ1eEJ3NTVyaFpUM0NBMUtac3dKRGxxL1cw?=
 =?utf-8?B?aDlUQlJWU3NRdUpMbnlESFhLaGx3L1poWnY2WEo5S2pMa2l3RG02M2xWR3M4?=
 =?utf-8?B?TlVOWFp1YU5zaytaUVpvdmtLWDZmZkdpMjBFMlN1RVVacFVzVWRMcFNZVDY2?=
 =?utf-8?B?cUdadnl3RDJ2Q0RpK3NtM2dHdTdDNmZobnhxaVFyT1pjSFAvajlPcmpVc0cy?=
 =?utf-8?B?WTlpOE0yNjZ6a3ZhVWJ1aFdqMkpLK0NRQWgycXJQSXNuWk5EYk94SGkyNUdV?=
 =?utf-8?B?T1FOTXVhVFczM244YVEwZzl0NVNuVnQ1UFF4UE16YnRjRVNwQUhYd1JZSytL?=
 =?utf-8?B?b0cvWjlneVp0Y1JhMmdZbGhQdWFvWDNnVGpoUXFkbjc3VWJQUU9VRVBldy9V?=
 =?utf-8?B?aGJMVWJTd0FGeW5rVWl4amRockphaFZvYlZkT2lMYU1rcG0vcnFTYzE3Umo1?=
 =?utf-8?B?eTMzNmp3RXFkMWwyU251bms1WGZyYTNnRGM5SU9uRnM1OTgwd0tZZkRKWkxs?=
 =?utf-8?B?RTJ2b0grRElCVk1xUXdndVdJZUVBaWNqQ1hMcm9iZ2wxQlhpOHJWYnVwc2xB?=
 =?utf-8?B?Q3QxWWgzVkczT2lUWlFHZUV1WmZFUUdNdzlrWitCQm0xaXdzRzF3cDlYK05o?=
 =?utf-8?B?cGpGSDdRL3JMWUgyMDlYR3JTTmdWVTNhUmU5c2tmQlhYdEtNZnFWWSt6d01z?=
 =?utf-8?B?OW8xT0xzQ2pTRUxpdUJWSEY5RzREYWhqRTZtMzlqM29NZDlRdkk4RlAraWVX?=
 =?utf-8?B?dFd4QWh2UUF3ZURNZ25IY21kWEtlSjZGV1drbXhVeVBPazkvT1UyVDNadk1U?=
 =?utf-8?B?Z3lNU0tqdXNwNGFFUVJBQkNjM3orMXA0blVTSW9wRHFZZXhUaENWQnB1UEJ4?=
 =?utf-8?B?MmdvMGs1c0dIZUlmWno0L0g1WHF2LzFGcjB0NEZjUmJyZW1JRkxjdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4999477CBAF7594192143824C09C232B@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 38580012-0302-4794-a7a7-08de75fc84a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 12:34:15.0605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SJ+n88BI5F5v5ZO20NllhCrM8S8FGFB5HzfZw5EbGHKO6Twy6RxqMMZLNUB8hMkF2XyNJZeluLp4FAAqji3UYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9825

T24gMjQvMDIvMjYgMDA6MTEsIE1hbmlrYW50YSBNYWRkaXJlZGR5IHdyb3RlOg0KPiBGcm9tOiBW
aWR5YSBTYWdhciA8dmlkeWFzQG52aWRpYS5jb20+DQo+IA0KPiBPbmx5IGEgUm9vdCBwb3J0IGlu
aXRpYXRlcyB0aGUgTDIgc2VxdWVuY2UuIFBDSWUgbGluayBpcyBrZXB0IGluIEwyIHN0YXRlDQo+
IGR1cmluZyBzdXNwZW5kLiBJZiBFbmRwb2ludCBtb2RlIGlzIGVuYWJsZWQgYW5kIHRoZSBsaW5r
IGlzIHVwLCB0aGUNCj4gc29mdHdhcmUgY2Fubm90IHByb2NlZWQgd2l0aCBzdXNwZW5kLiBIb3dl
dmVyLCB3aGVuIHRoZSBQQ0llIEVuZHBvaW50DQo+IGRyaXZlciBpcyBwcm9iZWQsIGJ1dCB0aGUg
UENJZSBsaW5rIGlzIG5vdCB1cCwgVGVncmEgY2FuIGdvIGludG8gc3VzcGVuZA0KPiBzdGF0ZS4g
U28sIGFsbG93IHN5c3RlbSB0byBzdXNwZW5kIGluIHRoaXMgY2FzZS4NCj4gDQo+IEZpeGVzOiBk
ZTJiYmYyYjcxYmIgKCJQQ0k6IHRlZ3JhMTk0OiBEb24ndCBhbGxvdyBzdXNwZW5kIHdoZW4gVGVn
cmEgUENJZSBpcyBpbiBFUCBtb2RlIikNCj4gU2lnbmVkLW9mZi1ieTogVmlkeWEgU2FnYXIgPHZp
ZHlhc0BudmlkaWEuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBNYW5pa2FudGEgTWFkZGlyZWRkeSA8
bW1hZGRpcmVkZHlAbnZpZGlhLmNvbT4NCj4gLS0tDQo+IENoYW5nZXMgVjEgLT4gVjY6IE5vbmUN
Cj4gDQo+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLXRlZ3JhMTk0LmMgfCAzMSAr
KysrKysrKysrKysrKysrKy0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygr
KSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2llLXRlZ3JhMTk0LmMgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ll
LXRlZ3JhMTk0LmMNCj4gaW5kZXggNjFjYmI0ZjIzMGUxLi41ODA2OWIxNjE1YjggMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtdGVncmExOTQuYw0KPiArKysg
Yi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLXRlZ3JhMTk0LmMNCj4gQEAgLTIyNjYs
MTYgKzIyNjYsMjggQEAgc3RhdGljIHZvaWQgdGVncmFfcGNpZV9kd19yZW1vdmUoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldikNCj4gIAkJZ3Bpb2Rfc2V0X3ZhbHVlKHBjaWUtPnBleF9yZWZj
bGtfc2VsX2dwaW9kLCAwKTsNCj4gIH0NCj4gIA0KPiAtc3RhdGljIGludCB0ZWdyYV9wY2llX2R3
X3N1c3BlbmRfbGF0ZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICtzdGF0aWMgaW50IHRlZ3JhX3Bj
aWVfZHdfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICB7DQo+ICAJc3RydWN0IHRlZ3Jh
X3BjaWVfZHcgKnBjaWUgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gLQl1MzIgdmFsOw0KPiAg
DQo+ICAJaWYgKHBjaWUtPm9mX2RhdGEtPm1vZGUgPT0gRFdfUENJRV9FUF9UWVBFKSB7DQo+IC0J
CWRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIFN1c3BlbmQgYXMgVGVncmEgUENJZSBpcyBpbiBFUCBt
b2RlXG4iKTsNCj4gLQkJcmV0dXJuIC1FUEVSTTsNCj4gKwkJaWYgKHBjaWUtPmVwX3N0YXRlID09
IEVQX1NUQVRFX0VOQUJMRUQpIHsNCj4gKwkJCWRldl9lcnIoZGV2LCAiVGVncmEgUENJZSBpcyBp
biBFUCBtb2RlLCBzdXNwZW5kIG5vdCBhbGxvd2VkXG4iKTsNCj4gKwkJCXJldHVybiAtRVBFUk07
DQo+ICsJCX0NCj4gKw0KPiArCQlkaXNhYmxlX2lycShwY2llLT5wZXhfcnN0X2lycSk7DQo+ICsJ
CXJldHVybiAwOw0KPiAgCX0NCj4gIA0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+ICtzdGF0
aWMgaW50IHRlZ3JhX3BjaWVfZHdfc3VzcGVuZF9sYXRlKHN0cnVjdCBkZXZpY2UgKmRldikNCj4g
K3sNCj4gKwlzdHJ1Y3QgdGVncmFfcGNpZV9kdyAqcGNpZSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYp
Ow0KPiArCXUzMiB2YWw7DQo+ICsNCj4gIAlpZiAoIXBjaWUtPmxpbmtfc3RhdGUpDQo+ICAJCXJl
dHVybiAwOw0KPiAgDQo+IEBAIC0yMjk1LDYgKzIzMDcsOSBAQCBzdGF0aWMgaW50IHRlZ3JhX3Bj
aWVfZHdfc3VzcGVuZF9ub2lycShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICB7DQo+ICAJc3RydWN0
IHRlZ3JhX3BjaWVfZHcgKnBjaWUgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gIA0KPiArCWlm
IChwY2llLT5vZl9kYXRhLT5tb2RlID09IERXX1BDSUVfRVBfVFlQRSkNCj4gKwkJcmV0dXJuIDA7
DQo+ICsNCj4gIAlpZiAoIXBjaWUtPmxpbmtfc3RhdGUpDQo+ICAJCXJldHVybiAwOw0KPiAgDQo+
IEBAIC0yMzA5LDYgKzIzMjQsOSBAQCBzdGF0aWMgaW50IHRlZ3JhX3BjaWVfZHdfcmVzdW1lX25v
aXJxKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIAlzdHJ1Y3QgdGVncmFfcGNpZV9kdyAqcGNpZSA9
IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiAgCWludCByZXQ7DQo+ICANCj4gKwlpZiAocGNpZS0+
b2ZfZGF0YS0+bW9kZSA9PSBEV19QQ0lFX0VQX1RZUEUpDQo+ICsJCXJldHVybiAwOw0KPiArDQo+
ICAJaWYgKCFwY2llLT5saW5rX3N0YXRlKQ0KPiAgCQlyZXR1cm4gMDsNCj4gIA0KPiBAQCAtMjM0
MSw4ICsyMzU5LDggQEAgc3RhdGljIGludCB0ZWdyYV9wY2llX2R3X3Jlc3VtZV9lYXJseShzdHJ1
Y3QgZGV2aWNlICpkZXYpDQo+ICAJdTMyIHZhbDsNCj4gIA0KPiAgCWlmIChwY2llLT5vZl9kYXRh
LT5tb2RlID09IERXX1BDSUVfRVBfVFlQRSkgew0KPiAtCQlkZXZfZXJyKGRldiwgIlN1c3BlbmQg
aXMgbm90IHN1cHBvcnRlZCBpbiBFUCBtb2RlIik7DQo+IC0JCXJldHVybiAtRU5PVFNVUFA7DQo+
ICsJCWVuYWJsZV9pcnEocGNpZS0+cGV4X3JzdF9pcnEpOw0KPiArCQlyZXR1cm4gMDsNCj4gIAl9
DQo+ICANCj4gIAlpZiAoIXBjaWUtPmxpbmtfc3RhdGUpDQo+IEBAIC0yNDQ3LDYgKzI0NjUsNyBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCB0ZWdyYV9wY2llX2R3X29mX21hdGNo
W10gPSB7DQo+ICB9Ow0KPiAgDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IGRldl9wbV9vcHMgdGVn
cmFfcGNpZV9kd19wbV9vcHMgPSB7DQo+ICsJLnN1c3BlbmQgPSB0ZWdyYV9wY2llX2R3X3N1c3Bl
bmQsDQo+ICAJLnN1c3BlbmRfbGF0ZSA9IHRlZ3JhX3BjaWVfZHdfc3VzcGVuZF9sYXRlLA0KPiAg
CS5zdXNwZW5kX25vaXJxID0gdGVncmFfcGNpZV9kd19zdXNwZW5kX25vaXJxLA0KPiAgCS5yZXN1
bWVfbm9pcnEgPSB0ZWdyYV9wY2llX2R3X3Jlc3VtZV9ub2lycSwNCg0KUmV2aWV3ZWQtYnk6IFZp
ZHlhIFNhZ2FyIDx2aWR5YXNAbnZpZGlhLmNvbT4NCg==
