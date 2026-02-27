Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011029.outbound.protection.outlook.com [52.101.62.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA6F30C343;
	Fri, 27 Feb 2026 12:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772195590; cv=fail; b=QtTB3U3y+GviIsY9pzntOiMHK812lXOFoBOriq3GiK2/w4cq1/pmcO4O09/ch6Imk0Wce4LJzCve2n6IuYcJcyAlT8JT1CLgKMmodSReNMAqYSFqSdYo7oB2+gEjSCjZD1H7jxcARkpLmNhSqC9J2Wz6vUwbq0U1+isSQ+/zfUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772195590; c=relaxed/simple;
	bh=a+V0/gL5byH12C2rvyBsa7scw3ko4OSgSnVw7+Onu7Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HnLV1LySwgce6rWBfre6zF8bsJMr4Xk/6NE9PSDobHwjqrI+42nI5mgyLU6o0CT3jrjU4eh2Ue2412z94a6ssKqxTyedfun4iY/xMaXeRJ8WNLiYYMUoYqFr1GKHexAnC96XVIPTF6h7GoRNqlHwVat2sfQo40B79AmxeWZBfyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lypYx1Aq; arc=fail smtp.client-ip=52.101.62.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lypYx1Aq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6xZ6BfnH7eOvluy/t5ndAbpsiprLu9IDNbD9s2kEMZKZYqtdnVGN/DsahIdfpcFkHdk1Lpyce43tOXZv7EVbinj+nrdRISOZUz8vZeS6lsxpDD6mrWolYPuVZH2XR2ZW47ZTnf5uCbT/wunqusdSHxQjauaEEUTffh5xcruI1MQItu4EWRTRcTPkNDSv6x62LPSLMdmk0AOnGYe5s9NGB8d6nVH0o3VH4XqH6/vS9Q+0Da5ZQ4WMvZKsILRbh14ZonsTHXwV0wmi4+fLeWkh3zYmv3/0DpXcBgRSfm6nw1oZ6+JoPE53d/pvuiuBY+HuHEhzkpuKMQjrbQU4fQ7Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+V0/gL5byH12C2rvyBsa7scw3ko4OSgSnVw7+Onu7Y=;
 b=YDZ1MVIRnByPjs7ri+4rExkpViHgpNB2AAfHwMpPgYs/cY7gnLTlmbE6Elp1pypJqFMPotYoM4QmCT4fvVDP2iZRaI4pR8/LQ59RR+ptrH9gmf0hM1CFfo8GwtBIZ5xfALIPjrYUDb7WBcQGFgwIJ9e1mO0A18eKxFTM3YnscPH1uFj2iQ9JqNfi+XRVJzYTzdb0Y3gXqmI5Cnw3RphncBs8HwMrcWBY3tT+iv8yS2QoVPE0Wm86v4WGAku+bNduumi6+8EhzxuItIyr/t4RjIzFWlKwIQdn5hSPdLZQ0TCY6JhiHvFQvfPRDTMYq6qNO+vBzOsjFJ4skkfVQYkUqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+V0/gL5byH12C2rvyBsa7scw3ko4OSgSnVw7+Onu7Y=;
 b=lypYx1Aqv8JXpJ3auUL2wDjVrn36oEVcn1impxY+Qvacb/c1HuMz5bNVbWyIznODoQ8BBodMLNwGh26xAfkjix+HQLRu5CWGQMufdWzjuUtlsDBxuEkDnjVVew/CABPpoJDjTWZA+Wdj/q1ATtkmUBxki/reXH01tAuZgLt4CglQ6fUEws97ldxSYt1oiQb/kQ+viZpAwlATVIgUSkBtcgEW9G6ID5aXn1pdj2nj1nl1aZEt1AL/9sf35Mzz8oPmdlvfvGw3V7lT0YprYsLKaKMCf++mRVmdbiyDJMQOOjnob6V3bwEdyrFmGTfaBX+MRCjzQEf6h3Bc57Llje1bkQ==
Received: from SN7PR12MB6744.namprd12.prod.outlook.com (2603:10b6:806:26c::13)
 by SA1PR12MB6680.namprd12.prod.outlook.com (2603:10b6:806:253::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Fri, 27 Feb
 2026 12:33:00 +0000
Received: from SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961]) by SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961%3]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 12:33:00 +0000
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
Subject: Re: [PATCH v6 03/13] PCI: tegra194: Don't force the device into the
 D0 state before L2
Thread-Topic: [PATCH v6 03/13] PCI: tegra194: Don't force the device into the
 D0 state before L2
Thread-Index: AQHcpPREJ5EGYUfCdU6NtXYDgm8gKrWWgIGA
Date: Fri, 27 Feb 2026 12:33:00 +0000
Message-ID: <1cb77d65-ca0d-4142-a1e2-0713760a8689@nvidia.com>
References: <20260223184151.3083221-1-mmaddireddy@nvidia.com>
 <20260223184151.3083221-4-mmaddireddy@nvidia.com>
In-Reply-To: <20260223184151.3083221-4-mmaddireddy@nvidia.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB6744:EE_|SA1PR12MB6680:EE_
x-ms-office365-filtering-correlation-id: 3c09343e-f102-44f1-a2d6-08de75fc584f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|38070700021;
x-microsoft-antispam-message-info:
 2DiOO/n8jvYq+/OF3e4EbivuSZiSiqi1QONSo2XnzxNgjuxZFG1hEmN1w1fFK4Me2t7SU/6lFCZN2i6t4SshZv6TdUihIndMMXdRIVL9bO5Ks9fd+XTtNXgHUF5wNHtJRxD08WvlnZdhJazo032XnlkvMTsKN8YlxHfi19GX8B97gvYHByPmTtJ4qF69HoXz7qLcl5vAKEn68mN2yNqnRH10TWOKqaAukHB40DEtzMy9Gn/dZ75MqTTbH7BNsFyfhVy+WXcfbNoF3dqLhyG80CLLOsUgX6tUcF19xI/i/h6wnGPuNs1ApTKuY1XCUyCKWcHM/hHn6Ab3oY/DGLx6m0S85D7dfPDQpN4HuMeS1bZz3QDh9z3CixPYtiOJGmQlTP93/3KdW5L+6qkEVIGRouOf0pCGoDvnqmiBMTsmJcH01yl1xdED5nwOV6TRdaK645DQLoM+6XZibbvjFufSHruhAVq0pu2IHNTs6Hh7AIUa6Pbw/bmrwfDH2vIPe0uF0gXZiPRS4rNNi4jOxMOLnpwhAGWqtrQG/RqMKksMiJU30JjCoqTydh4W+Lqdf9fW+OTqcOAvYoaKx9aWudwv6yBOomu+jqLcAolfMSGNpQuhy73qcUoZt1MvBfxUAIpBqQLmjkRy9mnD+OzUkTvE0NRPWSc7cyPU2e4B9q9ojEL71q6faIPghkyMZjfMV75GOHE2M1mgw6Fv8DcEveEI5CFNyOF/ztW7ax83dDphfLc6Tu1wvVGiPxFyGZLoZQKj+FzSVgwkgP52uoKdXsATkxvYoeCpCWJz76rTZ6UYw/KAD6IAfP1uzeH903ccX7AR
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB6744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NjQxNGJ0cnNZblYrUmJNaHZOdExBOVllbmxRTitvY3NzcHZQdWJTbENXVkVp?=
 =?utf-8?B?RzE5WDZIUitObG1PaXViemhWODJPcjFRc3NGNUpzR3ExUk9Ya2VTM0JWSkp4?=
 =?utf-8?B?OHFJeENHMlhTMkR5ZUlGdm5DRVdGNnlWKzZIVDQ0cGlhRk1Uc1I1alpqdXhX?=
 =?utf-8?B?QjRlT1BSSTlkanFpZFhkN0Y1d3YxSUNnd2JPSVNQRkxBeTViWllGemxob1V6?=
 =?utf-8?B?RXBGc1ZyeVVSR09ReGNlTnJRa1h4WTZib2dwZDdjcjArdlp5UlA5d2RKakxR?=
 =?utf-8?B?Z2ppUm50V2pKME5KN1NMdXp6VmJrdUdqN2dKbWdlazV6aVA5bTkwWEJ3RGhC?=
 =?utf-8?B?WFlwUkdDVk4wRnZYQkR5d0NWMlVOR2d4Zm9zREgwZDkrS08yOER5dVNheFlN?=
 =?utf-8?B?UFZNWHl1eWJzZlJWT0lzY0tEc2tzT3dGS0dqVHZZTml3M0VveWEyaTROZVVm?=
 =?utf-8?B?SDJkQ1ZCeENOY1AyYkcvQ1JaNzJVZGdOV1ljUWdlbU5ES3lNbWU0WWVJdnFz?=
 =?utf-8?B?OHhIS0M3d08vQksrUUlkanN4Q2wyOG0rSmRCR291eHlKVUpudGI3V2lPNXBJ?=
 =?utf-8?B?Rm5JRFhJVjFXOFM4cVpSSWc5K2dSRmlCVHpjWjFJSElqeW9vdG1iZng0OGZu?=
 =?utf-8?B?V2Vhdy9UODVRZlRKTm54VkxiV2tvcmpaM3FkRFpacXIwc0tWNWN3Yk1lTVpm?=
 =?utf-8?B?T0JtR2VhWVhMNzN4azkvM2dZSHN0NXpTOTR5NmpFYjVRM3cxMWJjbnBZSVlr?=
 =?utf-8?B?OGE4b3BoaTBMK1NDeWZBUXdMaE5ZYmdWOEZ4Q2pxaEkrU3B1ZlRLRXh0UHRi?=
 =?utf-8?B?dVR3aUh1VWQ2Z0IvdDVtSFpHbTFsR2FrbEw0eW9xYjVRdW9kZlkzd0o1Y0Nu?=
 =?utf-8?B?cmFFRnlsWjIrMHBPTFg3QzhJQ04xN3ZNbmorUTkybGd0bS9xd2VjanY0eEdE?=
 =?utf-8?B?Ly9pcGlBczJQTHhFdjZUL3p4UWZEcEdDZDJ1OGRUeG5kdDRjMWhzSmo0cjlt?=
 =?utf-8?B?R25zeXB6Tmg0dlVNbTlrU0FGM0xyL3hLeVlubnBGT2xWL3NzcGwxVExwY0pI?=
 =?utf-8?B?MWVUYnF4TEsyWUFCMUtMVHFkZkNXendSMlMvTndWQUN1QVdObWhKZkhXSTU2?=
 =?utf-8?B?NnlISEtZVEoreU5OYVk2aDc4OVNwMmNQc0Rzak9vNm00cVl0bzJ4MU1rMHo3?=
 =?utf-8?B?WktYS1BPcnVRQmlCUUVadExDV0VlNjA3blFoeFhPNlBmUnBwVDcvckhxcitM?=
 =?utf-8?B?SVNDTzVzbVRpTGhwaFVuVkkzbXFQamZrNHloTHNWUFVZdFdza0VwRjVTTGNX?=
 =?utf-8?B?YTJheGpHK21TVnI1N1BLWXNhYmh3YXZIUCt6ODUyRmxRMUNZRXhPN3E3MHZI?=
 =?utf-8?B?ek9wRHUweUtWSUF5WlJFakc0R21pODhXYitzQ0VEQ0xvemptMllXYmlxamhL?=
 =?utf-8?B?SUxUQXlKVFRxRUhZR2dRM2NKZ2N6YjU0VDJNQnhZNFd4M2dydFdPWG83VXVV?=
 =?utf-8?B?UUhyaUZNaXVLVWw2ZTRjTHpCakRVWmhCcnlrbzdJaHVMMlJpeGkybWxlZUdx?=
 =?utf-8?B?S2tpWVBHMGw4MDJTaWpORXB3ZmYvSmE4WGJzMTFLQUppOCt2YWFCeTdJaW55?=
 =?utf-8?B?SWMzNnZLWS9VdWhmUmlRalpiMUhMbmNQQ2hJRXdTaGNzaWZYdWF3RGUyRjhv?=
 =?utf-8?B?and2NzBXQklidXllVzUrNlp2V2ZFN05rQkM2ZnlIdEtYNUZLVkx0KzJCN1hq?=
 =?utf-8?B?dUpKYlVzUWNIblorcGw0YlRhRExCTStPYi9Yb1QwVmJEMEFNY2VDbnBKS2ZU?=
 =?utf-8?B?a2RnSFU1M0IzaVZVbDB1ZURWamhiU2l2V0swRGVUUlRUWkhZcGFydGFTWEF4?=
 =?utf-8?B?dm5sSG5WYjZZUmVvS0FUdGFhZ011OEorK21xaXlEYXkyZG8xZUJPU3BDY1o1?=
 =?utf-8?B?ajB3elo3ek5RRFhHVHpxR25NQkxuVmhLMU9aa3QrZjNmYjFSbnFTcGg3WTFE?=
 =?utf-8?B?SXNVV1VFNHJNYThvdE45Ukd5OGlYZ3BZc1RoMmpCY0ZocjcwUW13cDVCNTUx?=
 =?utf-8?B?REpNcjVqRGlCZlVKbFZ5ZXdMeHlwbS9QUnlsaHYwQzlzUFN4YnpFd1RrT3Jk?=
 =?utf-8?B?WXArdUFhVTl6M1hJV2x5MHpra0pDRkU5OHR5MjBKMUdGWlBoYzVVNTB5UmlP?=
 =?utf-8?B?eDl0QkVhVzVYUVg4TUpNOXZmaU56MklXN0lNR3JPdkhWb3VUZk5uWHVxVjdq?=
 =?utf-8?B?dnY1SWppSlduQTRuU3JPdWJuOHZXbXNkbXNwME1zY1ZoZHZSaVk2L2JKTWRP?=
 =?utf-8?B?MW5RRVlEWVlyaW9jSHdrRy9PTkU5WDJxY2J6K3E3c3NNZzFxZDZTdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E08DF7A0ED3D94DBFCCCEF7788A846A@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c09343e-f102-44f1-a2d6-08de75fc584f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 12:33:00.6541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DRHjqBLeDV81tvAvce05H0zBXZ2J60rbZIDEdFmsMFMJaNo6vN6H1evm1IXXMcCmRl6ovWcEDSskpd4zcq2xdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6680

T24gMjQvMDIvMjYgMDA6MTEsIE1hbmlrYW50YSBNYWRkaXJlZGR5IHdyb3RlOg0KPiBGcm9tOiBW
aWR5YSBTYWdhciA8dmlkeWFzQG52aWRpYS5jb20+DQo+IA0KPiBBcyBwZXIgUENJZSBDRU0gc3Bl
YyByZXYgNC4wIHZlciAxLjAgc2VjIDIuMywgdGhlIFBDSWUgZW5kcG9pbnQgZGV2aWNlDQo+IHNo
b3VsZCBiZSBpbiBEMyBzdGF0ZSB0byBhc3NlcnQgd2FrZSMgcGluLiBUaGlzIHRha2VzIHByZWNl
ZGVuY2Ugb3ZlciBQQ0kNCj4gRXhwcmVzcyBCYXNlIHI0LjAgdjEuMCBTZXB0ZW1iZXIgMjctMjAx
NywgNS4yIExpbmsgU3RhdGUgUG93ZXIgTWFuYWdlbWVudA0KPiB3aGljaCBzdGF0ZXMgdGhhdCB0
aGUgZGV2aWNlIGNhbiBiZSBwdXQgaW50byBEMCBzdGF0ZSBiZWZvcmUgdGFraW5nIHRoZQ0KPiBs
aW5rIHRvIEwyIHN0YXRlLiBTbywgdG8gZW5hYmxlIHRoZSB3YWtlIGZ1bmN0aW9uYWxpdHkgZm9y
IGVuZHBvaW50cywgZG8NCj4gbm90IGZvcmNlIHRoZSBkZXZpY2VzIHRvIEQwIHN0YXRlIGJlZm9y
ZSB0YWtpbmcgdGhlIGxpbmsgdG8gTDIgc3RhdGUuDQo+IFRoZXJlIGlzIG5vIGZ1bmN0aW9uYWwg
aXNzdWUgd2l0aCB0aGUgZW5kcG9pbnRzIHdoZXJlIHRoZSBsaW5rIGRvZXNuJ3QgZ28NCj4gaW50
byBMMiBzdGF0ZSAodGhlIHJlYXNvbiB3aHkgdGhlIGVhcmxpZXIgY2hhbmdlIHdhcyBtYWRlIGlu
IHRoZSBmaXJzdA0KPiBwbGFjZSkgYXMgdGhlIHJvb3QgcG9ydCBwcm9jZWVkcyB3aXRoIHRoZSB1
c3VhbCBmbG93IHBvc3QgUE1FIHRpbWVvdXQuDQo+IA0KPiBGaXhlczogNTZlMTVhMjM4ZDkyICgi
UENJOiB0ZWdyYTogQWRkIFRlZ3JhMTk0IFBDSWUgc3VwcG9ydCIpDQo+IFNpZ25lZC1vZmYtYnk6
IFZpZHlhIFNhZ2FyIDx2aWR5YXNAbnZpZGlhLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogTWFuaWth
bnRhIE1hZGRpcmVkZHkgPG1tYWRkaXJlZGR5QG52aWRpYS5jb20+DQo+IC0tLQ0KPiBDaGFuZ2Vz
IFYxIC0+IFY2OiBOb25lDQo+IA0KPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS10
ZWdyYTE5NC5jIHwgNDEgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDQxIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvZHdjL3BjaWUtdGVncmExOTQuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUt
dGVncmExOTQuYw0KPiBpbmRleCA0YWM2YjFjZWExM2YuLjgwOGExZTIxM2I3OSAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS10ZWdyYTE5NC5jDQo+ICsrKyBi
L2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtdGVncmExOTQuYw0KPiBAQCAtMTI2MSw0
NCArMTI2MSw2IEBAIHN0YXRpYyBpbnQgdGVncmFfcGNpZV9icG1wX3NldF9wbGxfc3RhdGUoc3Ry
dWN0IHRlZ3JhX3BjaWVfZHcgKnBjaWUsDQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+ICANCj4gLXN0
YXRpYyB2b2lkIHRlZ3JhX3BjaWVfZG93bnN0cmVhbV9kZXZfdG9fRDAoc3RydWN0IHRlZ3JhX3Bj
aWVfZHcgKnBjaWUpDQo+IC17DQo+IC0Jc3RydWN0IGR3X3BjaWVfcnAgKnBwID0gJnBjaWUtPnBj
aS5wcDsNCj4gLQlzdHJ1Y3QgcGNpX2J1cyAqY2hpbGQsICpyb290X3BvcnRfYnVzID0gTlVMTDsN
Cj4gLQlzdHJ1Y3QgcGNpX2RldiAqcGRldjsNCj4gLQ0KPiAtCS8qDQo+IC0JICogbGluayBkb2Vz
bid0IGdvIGludG8gTDIgc3RhdGUgd2l0aCBzb21lIG9mIHRoZSBlbmRwb2ludHMgd2l0aCBUZWdy
YQ0KPiAtCSAqIGlmIHRoZXkgYXJlIG5vdCBpbiBEMCBzdGF0ZS4gU28sIG5lZWQgdG8gbWFrZSBz
dXJlIHRoYXQgaW1tZWRpYXRlDQo+IC0JICogZG93bnN0cmVhbSBkZXZpY2VzIGFyZSBpbiBEMCBz
dGF0ZSBiZWZvcmUgc2VuZGluZyBQTUVfVHVybk9mZiB0byBwdXQNCj4gLQkgKiBsaW5rIGludG8g
TDIgc3RhdGUuDQo+IC0JICogVGhpcyBpcyBhcyBwZXIgUENJIEV4cHJlc3MgQmFzZSByNC4wIHYx
LjAgU2VwdGVtYmVyIDI3LTIwMTcsDQo+IC0JICogNS4yIExpbmsgU3RhdGUgUG93ZXIgTWFuYWdl
bWVudCAoUGFnZSAjNDI4KS4NCj4gLQkgKi8NCj4gLQ0KPiAtCWxpc3RfZm9yX2VhY2hfZW50cnko
Y2hpbGQsICZwcC0+YnJpZGdlLT5idXMtPmNoaWxkcmVuLCBub2RlKSB7DQo+IC0JCWlmIChjaGls
ZC0+cGFyZW50ID09IHBwLT5icmlkZ2UtPmJ1cykgew0KPiAtCQkJcm9vdF9wb3J0X2J1cyA9IGNo
aWxkOw0KPiAtCQkJYnJlYWs7DQo+IC0JCX0NCj4gLQl9DQo+IC0NCj4gLQlpZiAoIXJvb3RfcG9y
dF9idXMpIHsNCj4gLQkJZGV2X2VycihwY2llLT5kZXYsICJGYWlsZWQgdG8gZmluZCBkb3duc3Ry
ZWFtIGJ1cyBvZiBSb290IFBvcnRcbiIpOw0KPiAtCQlyZXR1cm47DQo+IC0JfQ0KPiAtDQo+IC0J
LyogQnJpbmcgZG93bnN0cmVhbSBkZXZpY2VzIHRvIEQwIGlmIHRoZXkgYXJlIG5vdCBhbHJlYWR5
IGluICovDQo+IC0JbGlzdF9mb3JfZWFjaF9lbnRyeShwZGV2LCAmcm9vdF9wb3J0X2J1cy0+ZGV2
aWNlcywgYnVzX2xpc3QpIHsNCj4gLQkJaWYgKFBDSV9TTE9UKHBkZXYtPmRldmZuKSA9PSAwKSB7
DQo+IC0JCQlpZiAocGNpX3NldF9wb3dlcl9zdGF0ZShwZGV2LCBQQ0lfRDApKQ0KPiAtCQkJCWRl
dl9lcnIocGNpZS0+ZGV2LA0KPiAtCQkJCQkiRmFpbGVkIHRvIHRyYW5zaXRpb24gJXMgdG8gRDAg
c3RhdGVcbiIsDQo+IC0JCQkJCWRldl9uYW1lKCZwZGV2LT5kZXYpKTsNCj4gLQkJfQ0KPiAtCX0N
Cj4gLX0NCj4gLQ0KPiAgc3RhdGljIGludCB0ZWdyYV9wY2llX2dldF9zbG90X3JlZ3VsYXRvcnMo
c3RydWN0IHRlZ3JhX3BjaWVfZHcgKnBjaWUpDQo+ICB7DQo+ICAJcGNpZS0+c2xvdF9jdGxfM3Yz
ID0gZGV2bV9yZWd1bGF0b3JfZ2V0X29wdGlvbmFsKHBjaWUtPmRldiwgInZwY2llM3YzIik7DQo+
IEBAIC0xNjI3LDcgKzE1ODksNiBAQCBzdGF0aWMgdm9pZCB0ZWdyYV9wY2llX2R3X3BtZV90dXJu
b2ZmKHN0cnVjdCB0ZWdyYV9wY2llX2R3ICpwY2llKQ0KPiAgDQo+ICBzdGF0aWMgdm9pZCB0ZWdy
YV9wY2llX2RlaW5pdF9jb250cm9sbGVyKHN0cnVjdCB0ZWdyYV9wY2llX2R3ICpwY2llKQ0KPiAg
ew0KPiAtCXRlZ3JhX3BjaWVfZG93bnN0cmVhbV9kZXZfdG9fRDAocGNpZSk7DQo+ICAJZHdfcGNp
ZV9ob3N0X2RlaW5pdCgmcGNpZS0+cGNpLnBwKTsNCj4gIAl0ZWdyYV9wY2llX2R3X3BtZV90dXJu
b2ZmKHBjaWUpOw0KPiAgCXRlZ3JhX3BjaWVfdW5jb25maWdfY29udHJvbGxlcihwY2llKTsNCj4g
QEAgLTIzMzcsNyArMjI5OCw2IEBAIHN0YXRpYyBpbnQgdGVncmFfcGNpZV9kd19zdXNwZW5kX25v
aXJxKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIAlpZiAoIXBjaWUtPmxpbmtfc3RhdGUpDQo+ICAJ
CXJldHVybiAwOw0KPiAgDQo+IC0JdGVncmFfcGNpZV9kb3duc3RyZWFtX2Rldl90b19EMChwY2ll
KTsNCj4gIAl0ZWdyYV9wY2llX2R3X3BtZV90dXJub2ZmKHBjaWUpOw0KPiAgCXRlZ3JhX3BjaWVf
dW5jb25maWdfY29udHJvbGxlcihwY2llKTsNCj4gIA0KPiBAQCAtMjQxMSw3ICsyMzcxLDYgQEAg
c3RhdGljIHZvaWQgdGVncmFfcGNpZV9kd19zaHV0ZG93bihzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQ0KPiAgCQkJcmV0dXJuOw0KPiAgDQo+ICAJCWRlYnVnZnNfcmVtb3ZlX3JlY3Vyc2l2
ZShwY2llLT5kZWJ1Z2ZzKTsNCj4gLQkJdGVncmFfcGNpZV9kb3duc3RyZWFtX2Rldl90b19EMChw
Y2llKTsNCj4gIA0KPiAgCQlkaXNhYmxlX2lycShwY2llLT5wY2kucHAuaXJxKTsNCj4gIAkJaWYg
KElTX0VOQUJMRUQoQ09ORklHX1BDSV9NU0kpKQ0KDQpSZXZpZXdlZC1ieTogVmlkeWEgU2FnYXIg
PHZpZHlhc0BudmlkaWEuY29tPg0K
