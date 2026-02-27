Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011054.outbound.protection.outlook.com [40.107.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D347030C343;
	Fri, 27 Feb 2026 12:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772195624; cv=fail; b=rxzUU5kb6vQbE/+EsZxs2KKDaAy1CH8eAJMXnh9PjjaB26Wy4dTPORE77iuoJNGtzeyhI7G0/aAc6SFKWkRUKitTGbxWHFdY/95I6bjLlzCErO3w4BOeHkQql6EXPUr52Ah4sLOXt1LTocf7tUFNVi4Spk+EyB5f2rhTjWcYVhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772195624; c=relaxed/simple;
	bh=Uftr6K3XG57rWMNBvFC2e6I6VRDHkkaAT9n2VRpQj3Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ffOKp5i29cbmtfLtPJJ1dwRacFnifPfsAGWsZMuwmaWnBpSbJC6HOcfCzFej8TaHGzAFWWEYuYmVZSV2s8md52rHswwsQjsl+7CgsG7BmhzPhUtUKPCDxcLiwydq8fWMMGNGqvIZrOWMnjIQjl+PwV8rYVY69kZN0ikOk1E3pmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qw+vXFMx; arc=fail smtp.client-ip=40.107.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qw+vXFMx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K0ygtewLETKuoIdkZ7elZAyYAiiA6IW1/wAMUy2YDQNOW0CotfIJhmImmwZfO2eO/PKfail9mtaIlRbH8sALVoKu9CCPt9zQXykxrDmh/XoCWjAUBJ8Uq4v3S6fXBTosRPYg/ci5oSwYuFnX4zmIYT64c0k594xUFcEgFsc5gdybodJJzdcrA6xRbdwoAI4yolevgv8uF4syeSjl5i6YnPFtfFRcjquCdkgKPBSTBeCLsMeWpt0BWJbqKvY7q1zTPxUajoPfMcHuia9PQNCh0z/nN20QcgncjQgRRZlZAdmD5yUqXxe1QI6B+fPZdRnd6MelNP7+hjhYqqJf83iHzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uftr6K3XG57rWMNBvFC2e6I6VRDHkkaAT9n2VRpQj3Q=;
 b=jRkCsmtsYnsAHbLlt2jj18WaqYSdn3by38yWcD9jC47Ia059BgQfLIb7dO0ZTnjUDmqA/6O2y4MGCYNPInLnxEhxx3E6dRULN4AIpXX9LrTUXp8U7KBnF6Pfvw6uEwUqL16U06V4d3JgJCJrqboQ3Umx1rkrb5FKMIctmswWX+mtKS5NSp35AIEHJOn6S8HWSf/P94AtYjWzK5IumwhhlVYvpPMQzvxGAVVQ+AHyCBP6iNicLt4VRU7rhVTidBqV5zcpbJWSBtWKUfTkpNuDcPv2/hKX1JgYLha5p++PZfH8U0TdKN7XN0FCJ5DMrEdaZ1D4dbsMcai+IueXabLtxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uftr6K3XG57rWMNBvFC2e6I6VRDHkkaAT9n2VRpQj3Q=;
 b=qw+vXFMxXpXnLyxrXPQRrs+VSzywFq/+b/zWmS1XPF3Q7mU++jXxF4l1/5BIHLzXGRVQOwmYAJzNymFdeEhWiu3AAnjcWW0FsUaICDeX9pUxRFn8onDX/5NfCAG7FV6Mx6tA81SGm5TC3p0Klb43M1ZkKKzV1oWo595ejLrlIPG/XPtpDkLDiywqcsZmpnjmjSK9MPJRg1gzp0jtyeTq0eIds3k+fzjUcD0AhD3jGErIcWNKF/nhzrxfSWjWB8NF8sBLHIGWMlFPo7IlwLSf0JoquDgIBDBFG7QleFfXCcOXQQFjflIoHLnuMyowLtpG49K1xo7jKGad4TksL/hxDw==
Received: from SN7PR12MB6744.namprd12.prod.outlook.com (2603:10b6:806:26c::13)
 by LV5PR12MB9825.namprd12.prod.outlook.com (2603:10b6:408:2ff::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 12:33:40 +0000
Received: from SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961]) by SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961%3]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 12:33:40 +0000
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
Subject: Re: [PATCH v6 06/13] PCI: tegra194: Disable direct speed change for
 EP
Thread-Topic: [PATCH v6 06/13] PCI: tegra194: Disable direct speed change for
 EP
Thread-Index: AQHcpPROYjr/ukeYvEqKo5+9ztEpSrWWgLCA
Date: Fri, 27 Feb 2026 12:33:40 +0000
Message-ID: <6f544cb8-ceb9-4ce4-b096-c2046e2c5716@nvidia.com>
References: <20260223184151.3083221-1-mmaddireddy@nvidia.com>
 <20260223184151.3083221-7-mmaddireddy@nvidia.com>
In-Reply-To: <20260223184151.3083221-7-mmaddireddy@nvidia.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB6744:EE_|LV5PR12MB9825:EE_
x-ms-office365-filtering-correlation-id: 4f8386a0-0883-4fa3-d373-08de75fc6fe4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 p5LRFHs3XMF6tRgHKlwpgGdlZ2hTgyPDIiS4sIg1YP70k4+jDeI/U5wX1zpkkI5U8Ra8dtHqU63XMOYI5qZMy4qrnBIwxAsOoPytdbhugHj2QzUjcMJWMy8ebOxMIZ+4n3VvlpXhN6ONYgkDrQyzVF4IvZppV+UTfOUh+bX25tQ8qBHiPsJ2pgfXuY4v9Jx0164GD5xFVU+d0F6lL7JOL2dN2Vc+So2pb6KxPU5Yx3/OCMpzTyOw1hFSOg/6ufwth/MnIvOW0jH3jqYjNHyaGcch4ZUJycHs77vPqde/gRlJUqllvZ1RnK2ypXeJ3PaYFkl+ryJmZnlkqHOCrlGsGMDGS2MrO0Zh6CJu92gxLKoUEtg6YlYQFLfLMveGlGEhncT48K/Io3kpap1YGSCM6YlDTdM9dAPtIUgmj1jPcaAcYJXEX2R3QsgXOfqxZoRkfHRV53Nw3SvpEy24IJaicVAZObH/YqfqRMts3gxPRoS7ArbcchVHDEn9S9ALNcVcwe5ezRwMoYwijGgXix/ctyw5yFrCKPPqBoVx8fZkHN99DyTZ0NBY2UX3NlHQm5pUMxcsGh8lSJaFbmt1jP2pXnhjlVl79hwyyp7ZQHdcK7MZGJb7JlLvR75ETGNUl4A+3BaCiuI1sYo+/MpwAFi5k2woDUcSpc1piygWGgMvRb66/gx9wGmHxN7t2x+OxTgQC2QiswM02jYscjbGViUtz2YC0cRNN/DD5BQZxdA0bdWM2nE/lf9m0QHzgUnev/0FDCpsa9G8t9ZKD6/6hwdhyxT1eB8T7qdj3/5/DcPGhom5pfLpPBlMzwCiM/pVoKeN
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB6744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cFdCQXE3RGFlaUNhSVlia3NvNWp1TXBDZkZHSzQ3eER1ajN0cHd4b1hzbXgz?=
 =?utf-8?B?TVk2SDZrejh2eVIvc0M2a0g4ckh2enpMV2F2eUVEQ3ZHQTcrUE1qZXpoUVZx?=
 =?utf-8?B?WXNkNWZrSENLRWw4Nm1pR2J5Y0tBUHhDWGVjaDl5OVhicFB1QkFIaDdJZmxL?=
 =?utf-8?B?YVdwbTlBYkFoUXJram1xckZXcHRtMG9pTFdaMDI4Yy9tTGc0dVJMdlNsSUo4?=
 =?utf-8?B?bnZpYTh0R2V2MFNCVGVacUd6cmgyNFc5QyszSVQySFdRVy9xVWpaMXA0MUU5?=
 =?utf-8?B?dHg4elA5OElYeXRZeXFLYngwWW9KNXlXYzdnWFo1NW9FREVzcS9TNjQ5Uitp?=
 =?utf-8?B?c1NDRmlYQnduLy9iaHpZRVJtazJWRFpvMlJpMUVJSVI3LzROcXA5SnVLSThr?=
 =?utf-8?B?YnZRK1F5K0hvWVhaQWhtQzErS093dUpKc1RTT1gzNDJQM1VWdHJrMEk2eG5C?=
 =?utf-8?B?dVVoMjNiejFsK3RBMjJsbmpNYy9BWFk2d3VnN2Z2MFJCQkluR3RsdFIrV2Q5?=
 =?utf-8?B?QXNKRTB5M3hJWDZBUUw3ZGkyRVhJTXNIL3VMNWErbXl4eitDd1N0TjMwV0Vk?=
 =?utf-8?B?YUNzU1gzYmdpL2srZTJEWXdVVjdCQmdDNkh6OVFCN0tvaGpRN0J4OUJsYjhP?=
 =?utf-8?B?SCs2UmRsdzE2ZjVWdk5rZnJOajZZSlNheFp4d1ZZcFM3amt0dGhkMzJUazRD?=
 =?utf-8?B?VisrWC95Z0ZTL0IrOWlNbVlFYUlEd1VwVERWMGlsTEs5Sk4zYmNtZmJYMnJo?=
 =?utf-8?B?ZUlZc1N1WnBpUXNTM3JkSUs1NGF0MXZIZnBydCs0cTd5S0VoRVYyVXRZUFpu?=
 =?utf-8?B?V3JGSENaZjNjWEVpa3YzcnZGcWlJb282NGNIVCtFV3YyQThDbGN5MVAvbkQ4?=
 =?utf-8?B?NHB6MVdpbjhUWnVXZjlVcDBGWXgwVHNQQ3k2Ly9pTC9oNzVwb1hjdk1VQ1VI?=
 =?utf-8?B?SkFqSHlSYUx0QWhpUXUyN3hIOVhwWFcvU2JrQXNiTGpkSnhMdkZKL2JhVytl?=
 =?utf-8?B?Vkt2SmRsT2hZL2F2NEVUOWRidWhEc2dwcytobnNPMjVVOXZaR01xL2VZSWpO?=
 =?utf-8?B?R3B5ZjFyZFVoRWVtV2F6cDZHdWwwaXZlaWFCMzcvNkY4Qkc5V08rQW00cWtk?=
 =?utf-8?B?bDdEQ1g3T3ZvQVY0R3RWdk5sODFhck9kSmNOcDZGcFdlemx1d2dzTTZGdHN0?=
 =?utf-8?B?SUhJRUJDK2t4K0JtMjg1SUZ1ZXRyeDNmQWl2WkZ4RGRQaW10Q2lueUlIdnM5?=
 =?utf-8?B?STF2MjM1clZ4Y25hOG82bnZLa1RlVkJZZWwwRytWcDI3ZThHeFo2NVNPUTkv?=
 =?utf-8?B?R0I5SU9SZjJnRDNJWmJKdTVoK3ZsMzZMQnhYYkVWYzF3NGhxZ0Q3UHcvWmky?=
 =?utf-8?B?SDVja2tuKzRvUGdFUEdwdFZjYXhHMEVzbDJJSW94SjdYYjNHYkJHWHU3Ullm?=
 =?utf-8?B?VGkrKzhiWFNXdC9uRHBnZGJxWXRvRjkvMXZUalFzbHpGYjM1akVSL0xZSzU0?=
 =?utf-8?B?RVRad2NTZG92NjNrQWpMb3U2c3hXSXd3MGNDUHYyaHQ4VFpjQWkyZFllN2Rj?=
 =?utf-8?B?S3ZzYjRKYVRFSHlUZkRvZFVqU254T0E2bHZmVzRiS0ZWN2tPdnhVUG83dmsw?=
 =?utf-8?B?ZHl1NUp4dFo0Ymc1R0pxakpCeUFBQTJtSkhCT3dQZTcrUUhsWm8wWjNTYThI?=
 =?utf-8?B?dWdOcVRvYURxU04yTVJDRVhxY0gyMW9CQlhjUkNQeVpmSUVISVg0UEo5cVk5?=
 =?utf-8?B?RkM5NkJ2dUNuOUJQTFFKWUJ5NWJadDB1S0lWNFlJRVhCTDFqUmxmN3J2dzlY?=
 =?utf-8?B?SVJGZDcxa0Z5MWpEVlFLNDdjT2RaME1OUGwxcnFHRmpoNWJpdDBzelpzOGJt?=
 =?utf-8?B?S25HYTdzVlcxdGxNRUdyRGNqSzIvdnh4MWNzNjUzNXhvcHFJUlJrK2sxRXJX?=
 =?utf-8?B?TFgwL2NkTUdZWDRidjVXQ0xrVE03NFlGRnZXSWxRdjNPNUdQNDhDRmo5NkpT?=
 =?utf-8?B?S1E1UFVXempWa3k5UDExNmN4SzZHdE9YSlI4L2VjOEQxcjdKdnZDbkpCemts?=
 =?utf-8?B?K0QvVHRYYTcrdE9qQ3NOUVJmaHZEa2l4anJCMXZKRjFmR0laakF6TVZVUml4?=
 =?utf-8?B?WFYyTVFYVnR3TUtCMEc5dkI4dDdEZlNrbHNRUU9jYkFaWjZiZVpDSkRPNGNW?=
 =?utf-8?B?RmhZL0I2cnhrMFlVVHptc05PK3hEMy81SGszZTlWWWdIQWFvd1JWc3l3QWJu?=
 =?utf-8?B?RngyMkQ2Rk43d29tclhENUVQeW4zUmI1YkI4STQ0NVRXdnh6cXFvRGdZQU1R?=
 =?utf-8?B?azEyV1d6ckVzUUZzZEwwMDVRKy85L1h4NlM1eTlMdzZ5R2k5N3lqUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CDEE40AF5A1DB4698070CC4101A38F8@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8386a0-0883-4fa3-d373-08de75fc6fe4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 12:33:40.1447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DUmtxJqY+zRE61B11QOQchW+PqWTt70Je+qZoKCtgOQ5MpenFLWHLDuQNd0J5M2BOS+FMunCBSqkNO1Ob2mbSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9825

T24gMjQvMDIvMjYgMDA6MTEsIE1hbmlrYW50YSBNYWRkaXJlZGR5IHdyb3RlOg0KPiBGcm9tOiBW
aWR5YSBTYWdhciA8dmlkeWFzQG52aWRpYS5jb20+DQo+IA0KPiBEaXNhYmxlIGRpcmVjdCBzcGVl
ZCBjaGFuZ2UgZm9yIHRoZSBlbmRwb2ludCB0byBwcmV2ZW50IGl0IGZyb20gaW5pdGlhdGluZw0K
PiB0aGUgc3BlZWQgY2hhbmdlIHBvc3QgcGh5c2ljYWwgbGF5ZXIgbGluayB1cCBhdCBnZW4xLiBU
aGlzIGxlYXZlcyB0aGUgc3BlZWQNCj4gY2hhbmdlIG93bmVyc2hpcCB3aXRoIHRoZSBob3N0Lg0K
PiANCj4gRml4ZXM6IGM1NzI0N2Y5NDBlOCAoIlBDSTogdGVncmE6IEFkZCBzdXBwb3J0IGZvciBQ
Q0llIGVuZHBvaW50IG1vZGUgaW4gVGVncmExOTQiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBWaWR5YSBT
YWdhciA8dmlkeWFzQG52aWRpYS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IE1hbmlrYW50YSBNYWRk
aXJlZGR5IDxtbWFkZGlyZWRkeUBudmlkaWEuY29tPg0KPiAtLS0NCj4gQ2hhbmdlcyBWMSAtPiBW
NjogTm9uZQ0KPiANCj4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtdGVncmExOTQu
YyB8IDQgKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtdGVncmExOTQuYyBiL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtdGVncmExOTQuYw0KPiBpbmRleCA4ZjY5YzVj
NWEwOTkuLmE2ODY4Yjc3ZTNiNyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxl
ci9kd2MvcGNpZS10ZWdyYTE5NC5jDQo+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdj
L3BjaWUtdGVncmExOTQuYw0KPiBAQCAtMTgwNyw2ICsxODA3LDEwIEBAIHN0YXRpYyB2b2lkIHBl
eF9lcF9ldmVudF9wZXhfcnN0X2RlYXNzZXJ0KHN0cnVjdCB0ZWdyYV9wY2llX2R3ICpwY2llKQ0K
PiAgDQo+ICAJcmVzZXRfY29udHJvbF9kZWFzc2VydChwY2llLT5jb3JlX3JzdCk7DQo+ICANCj4g
Kwl2YWwgPSBkd19wY2llX3JlYWRsX2RiaShwY2ksIFBDSUVfTElOS19XSURUSF9TUEVFRF9DT05U
Uk9MKTsNCj4gKwl2YWwgJj0gflBPUlRfTE9HSUNfU1BFRURfQ0hBTkdFOw0KPiArCWR3X3BjaWVf
d3JpdGVsX2RiaShwY2ksIFBDSUVfTElOS19XSURUSF9TUEVFRF9DT05UUk9MLCB2YWwpOw0KPiAr
DQo+ICAJaWYgKHBjaWUtPnVwZGF0ZV9mY19maXh1cCkgew0KPiAgCQl2YWwgPSBkd19wY2llX3Jl
YWRsX2RiaShwY2ksIENGR19USU1FUl9DVFJMX01BWF9GVU5DX05VTV9PRkYpOw0KPiAgCQl2YWwg
fD0gMHgxIDw8IENGR19USU1FUl9DVFJMX0FDS19OQUtfU0hJRlQ7DQoNClJldmlld2VkLWJ5OiBW
aWR5YSBTYWdhciA8dmlkeWFzQG52aWRpYS5jb20+DQo=
