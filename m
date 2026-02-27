Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012055.outbound.protection.outlook.com [40.107.209.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA24321772A;
	Fri, 27 Feb 2026 12:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772195736; cv=fail; b=I9iuH12O/1DXTAWBKlnROstn343Yo/K6CAcwVIPX8CEeIixNiGPAKybSZBXwb09Jc2PQ2itQha8GYGWS/K8m32GmnqkBtRk1dVRsVixiP9nXZuq45RNts4O/0Hnf9lvOvn62uHMBOjXqnl4+D4U7gFyks44CBySgVFzXh6MxcxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772195736; c=relaxed/simple;
	bh=bc2rBDZ/bLzhneBzoZg7dusAaI++kV+fPxrqSWqec2E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hMBBjVG9uMmAuNwNCsPiPKe3uqnR5lvGN/wyiQoz38bwheyy6i91J5GoK3HXYw5eppa6WDcKkZ516nO+L6lJyg2SfZijPRM1ELP20DTqTbh50egW/aIi5vtgohYbjzFQlIHf4prUodwV2hhXaDUvU61n4z27ewGoyw+WpfJ028k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y5HDWpxC; arc=fail smtp.client-ip=40.107.209.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y5HDWpxC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EAr+l4Wx/1NxkCe4eQU4grBKuiexoNTC/yBqjb01n2icU1pJXQEfIcBgZ5x+Y2XYxHxrbJfcO27IflDGat+AZSALV/2KulHCoKDH4XD56yIHRI4CP3bI3EdsOGtDvEsQ1AzgGi5ZOm1gvv47+GUEqUVQAQgjkGeV36h5ojCoulFhPPiqHQV2BRAavcpeWmy8ntgRxkr1Sn0X7ljAASHG7qXjUtdsYBGtnkWXp1cEi8wi39EuLD6JvKHdrwGNUbC/NzEQu5ZBVmhlkLQmbMR/oJs0YURuI35qb1lQp/YIgT3N+aW9cSn7bDxr50R2x12HEKfnOU67dmgdW9K/m7b3ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bc2rBDZ/bLzhneBzoZg7dusAaI++kV+fPxrqSWqec2E=;
 b=MxAyfJtR58jdS1EpoSt8X4kmQGZQeVwofOM8ZWq1h7o5sQx8dkIvfouRqlK839HKrcgPFIrogK57uwIKWjrsoUqX+b7Q302x4mpUPktc/LxznGSGhFl0Inq5PNr137d4gR55clTzuIIsObG7/rh8ZG0RhJrHjj4HaEQOxGFbEf+kTl0ZWAiVOBc7DxjaAHhoEivJTLs3hTFqCXCDcpf9NmxspgIgjNtpa4YGVGQIY3SjQTnqlWFGvv4VmIQba/rzRmZNFdcO7qkiDsY1kge+FLGSMk2eOO0xWDU4YAeHtxyIZUo4niAByhlE91J48w894fjLd8zelSQ6Bt4zPp1PjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bc2rBDZ/bLzhneBzoZg7dusAaI++kV+fPxrqSWqec2E=;
 b=Y5HDWpxCxvcKzxhH+oBLudUFEbvtdwbzf3FRwXb64QTh+YySwfz4h4JPaJzijsc4qLbUQWmTg3VFLN3jH3FNsYrQobXfALnTest5aHjgyMnB9vk06jPrk22csQ/yUYwPvQz4Ena4/do15ugtbVq6eDR5Lxec/YjAvFmkYRMJFPPQuzl6//+GYJ1Q0ZwGMfc3uJ8ZJjLD5i18wsq7ua30OCI0MiWSakuITl6AOab9nPsAYa0K5gqfpSG4fuLhGjHNrx0kOj3WdclCsHwMr2VeNuMyAWf4L6lKwQGpBQJdah64+kbeeiFn0qGUiVWincG2cSXDBhbrU3gszjzIwqTvsw==
Received: from SN7PR12MB6744.namprd12.prod.outlook.com (2603:10b6:806:26c::13)
 by LV5PR12MB9825.namprd12.prod.outlook.com (2603:10b6:408:2ff::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 12:35:32 +0000
Received: from SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961]) by SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961%3]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 12:35:31 +0000
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
Subject: Re: [PATCH v6 1/9] PCI: tegra194: Drive CLKREQ signal low explicitly
Thread-Topic: [PATCH v6 1/9] PCI: tegra194: Drive CLKREQ signal low explicitly
Thread-Index: AQHcpPS8GwCDa9VSikqvgLzb9qryl7WWgTWA
Date: Fri, 27 Feb 2026 12:35:31 +0000
Message-ID: <2b1f2d0f-b07d-4b14-ac19-78112ca84f05@nvidia.com>
References: <20260223184538.3084753-1-mmaddireddy@nvidia.com>
 <20260223184538.3084753-2-mmaddireddy@nvidia.com>
In-Reply-To: <20260223184538.3084753-2-mmaddireddy@nvidia.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB6744:EE_|LV5PR12MB9825:EE_
x-ms-office365-filtering-correlation-id: 521ed8b1-4331-4926-1524-08de75fcb266
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 FqyA4k1vNulsKNpk6/yANiX2yFmpbm/1QBXWygWEx1jloCnA3BaeYp7PTQiHxm5He2kRoRxzCYk+djOh3xwHou7h1/w9cXG7KW5GAJ63Im900GHfwN5tZxJREf9Eg7hmXLDzHZg54PE8iVfoGnbGhwzsZbZ+KUqQEKOxxTcI0687ZbXk7eODvQgYREhQ+slKZ3ZgBRuHfB8zDm1Fj8rCOPW+GvUFZg1v03Y06u5Au6aTiFgUgTblod9Co0P8J5xwHF1TM8KkSjeGTuLikO+AYRN/UoTX/g/MLvrBbqyfe0wXcvvFmLOejMy8OqIF5VKOK9nPfJtOxu78SmU+hvcXYDdRz3Ct9Igi04viBlfoU+BIvmXLiFJgjYehcMTvTiuGXydhJ5egLbpsWLXzmjmXSIh47gyLiSbVRWD/3ivmiZiCDVYymtU9OnNzs/OgK2djPg0ZVAcRJDd9FAcz5lDGTOeF3uZKh459zHXTO1AeifUK5454USnzCWKTzmfkud+ezHGwolz+5aGxOKhCWZprxRf3AEdVzyp3sPKmcDCu3Z0UaeuHZetXM4pN2EY8hpp6HV1IERKa54vYgaJCpomkafLUWW0CZokvCxani9XjtbwJyZZygBwesBFhBNDo+FDX6RfNH0cAeLCMAU8IPkjYfTYLugxNh4PcP/ThkWmPdeOBqZ6wTdiix1ExvD801ieqxOQl5JJDO/EXTHhJt3pBRMDmQgrc5x42Fyz5igKrZGgvYOj1sOIbmZfbqI8qroedOilDMNKmJ9AbE5zmkhg9AbyDmD29RlPvPb6W+veav4xqSN6V8NHZUt4qVtphq/ZW
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB6744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eklBbFRmbTVTNHpQbElaOGc5dUpVY0lueTdMMVdWWlk5ZVdmbUxoRXJMb2tq?=
 =?utf-8?B?RXVLN3hKbkhPM04xbXNpSDZ4aldYYWpmQVY1SjVWUWVyNXFYRVJwa0o1emk1?=
 =?utf-8?B?K25CejBRa3ZCblRmRkF0elk5bkoxc0JneEJERUF6TGxuMndYNXlNWkwzMjdR?=
 =?utf-8?B?TnBqUUxieElNNGhYdnlsQm9kUkRHT0Eyc1NXaWt5RmFFMXVUeDFTNGo1VUhQ?=
 =?utf-8?B?ZWlSWEZMeXFITUNpTEJ2Zm1UeStzTUJkZHA3VXB3QW0zVENsbnlFSFNyQkcy?=
 =?utf-8?B?Y2s4VXJ0NGVaN1ZOSjlLSnlpWS9YT0dFVm04UXEwN2VSTmRrY2Q0TnhJUGxT?=
 =?utf-8?B?RzUrNytWSkMvdm1HczA4ZU5wSkxKRVUreUxwODU4aDBMOG03NDA5ejhZMk9w?=
 =?utf-8?B?K0tHU0tsL3NBVXFzdDNBaFcxUmN1SVZPTnBmU1Jid1RzeUNEd0ZOa2FjL2NB?=
 =?utf-8?B?T2t5SXJsRWNMZHg4a1ROZks2anF5YjIyL29ZdUxFTXViTkxJc20wbE9jQ3d0?=
 =?utf-8?B?VWkwN1luQTRNQS91R29MdFEzV3B3WTBTdDdtbEN5eUx2TFFmTm1Oa1Y4N1FU?=
 =?utf-8?B?ZzlKMkVqTkR3cG1zbkVIVVlZY1BLdWtMV0M4N3NjdUkzOGhFMXlEOEtnQlB3?=
 =?utf-8?B?dGRkUzJpZFVjbmJ5elhzTzJqYk9CL1ppdm00WU1scjJFOFpwN1NRWmtEYWsv?=
 =?utf-8?B?WDZCSng5L2kxbzNBYVArTG5zTWVjN3BNNkRJMm1hY0JTZFZRRC9JVjNRU3hk?=
 =?utf-8?B?d2dTbzhyV1BlWmprejJqWGhXay9MOUVibFFZQTBMTXhZY2hoRGhFemtVdVhN?=
 =?utf-8?B?NlUwbUMrak10Y1FFNnozWU92dVU3MVVHVFMrZ0JOU3QrNXJvTEZudVpSWmJU?=
 =?utf-8?B?WWhlampqSys0Wll2OGUwVXRNU1NJU3Y1NWNrdjRvczY5dUpoUUhKZmhGbHlK?=
 =?utf-8?B?ZG11NmwyU1VneDBTOStPeERJVXVEQVJGeHozNENBYmNBNGFNRDJQbXNhZGVl?=
 =?utf-8?B?a2pyM3o2aWdoa1pFMlNEdlVSOFRZRjBKVkFVVDhJQnMvUEJaWDhETE5CL3JY?=
 =?utf-8?B?YmpaZnlJa0dHSjQyakpoQXVGejJCUDMyNk9tS3hzUy9JUGM4cDBsT3VaQXRS?=
 =?utf-8?B?UjdLQlIvR0N2d2paL1BZZ0hlMXNLaEkxZFdsblZTZ0hkNHUyVzR3b1J5Wkdx?=
 =?utf-8?B?TFhiamlLM1d3NFNJRW50N3lWeXUwTnNjZmdhSVRBVGYzeDY0WHVrZ0hubnJZ?=
 =?utf-8?B?c1h2RGR2emZuMUp2WGJwZm9EQ3pLMVVwS1I1M2U2aElhbVJoR3dDOUdvQ3ZI?=
 =?utf-8?B?WWltbnMyMlVKa2c0UktBS1c5eTNNZE1MMWlCYVljUGpBR0R6L1U0U29kblRW?=
 =?utf-8?B?aGo0YlpIK1N1cEw1ZjdTQUV6N2dDZTdyRzQ3RElkOVBYd0NLZGFaTG43c1NR?=
 =?utf-8?B?RnBKV2pvbEsvRmVBb1laUklPbEZBSS91b0JUN3VGbHN0Ulhaa0E1K0FCZjBL?=
 =?utf-8?B?cnQvVHo1Y3lJUzN4SE84UmhlRlZ2Z1c0a05iRnBuRGNMMnFQWVhOSkpaNXAw?=
 =?utf-8?B?YkdiUkNFODFOQU1CN1pqQ0NGMGVGRWcwTHE2RTkwWUhveEZ2OEpCTjVnU0t1?=
 =?utf-8?B?dlF1M3A1N2JqdE9adG4yTmxOdGNCblFTUkdDMFhTcGM5T3FoalNJSDNIR1Zs?=
 =?utf-8?B?Q0luOERrVnl5MTlRM0xFM3BtcHNsVXVSZzFZaE1POGczeWs1TWlZZnZrOG8w?=
 =?utf-8?B?VzdCeXgrdzFXa3NTaWREcUxUUkpWb0M2UkIvSVdROExHUHczdlE1MDEyZ3Za?=
 =?utf-8?B?cys2SG9rMUhVb0ZOdk9TWlVzWGZMWUNrYm91WFkxcHpCaE40OEhHeFl6eE9P?=
 =?utf-8?B?eFdQL0theEpKb2dDU1gxUGFzT1dFb0dySVFGK0xEMkp3NS9ERlJ1c2dYNlhU?=
 =?utf-8?B?bEc0TElXMUtpeThlamlFeUxmaStHL1N5aU5uc1lhZ0JXYUNieHR0LzQzSmdt?=
 =?utf-8?B?QmlLUjFMZXlUbHpoazVqQm4xZ3VlR3REcTk4S3F5YWUyM1JzOER3QXdZVUJN?=
 =?utf-8?B?ZlArQnlFMlJ2M2V5TEE0RlNCNmY4ZklKaXdDcWFyTzNIaEpQalFwTDJYbndp?=
 =?utf-8?B?Q0h4Qnh2MDllRC95d3NEbjVTbWozU0FyNHd0Q2pSakFmZFlzUmNyeEYrQ2xX?=
 =?utf-8?B?dk9yR0hWbGxHUWlDdVkvcm04MndkMDFwVG1zK3Z6TUVwU3dUcktDQ2dneHU4?=
 =?utf-8?B?RnFZWXk4RE9RdUs3clllaVluUk5YUGhDV0cyYVBXYTREcUlnb3NmVkp0UEVs?=
 =?utf-8?B?SkVTb0p0OTBJa3RmNUx4Sk9Ha1dyaktXazRsOERQVUs0RXdISFFDQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2C30409ADDB8D4EAAB848D1D2CE7A5C@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 521ed8b1-4331-4926-1524-08de75fcb266
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 12:35:31.8124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c61ceZ5YhSe3oikfyC+Az54PVOFHr8IFkMoPFb2Ji/xIONUMI5x0+B8p98TnlZjBLGavV5BWimJRk2cvR8IWAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9825

T24gMjQvMDIvMjYgMDA6MTUsIE1hbmlrYW50YSBNYWRkaXJlZGR5IHdyb3RlOg0KPiBGcm9tOiBW
aWR5YSBTYWdhciA8dmlkeWFzQG52aWRpYS5jb20+DQo+IA0KPiBDdXJyZW50bHksIHRoZSBkZWZh
dWx0IHNldHRpbmcgaXMgdGhhdCBDTEtSRVEgc2lnbmFsIG9mIGEgUm9vdCBQb3J0DQo+IGlzIGlu
dGVybmFsbHkgb3ZlcnJpZGRlbiB0byAnMCcgdG8gZW5hYmxlIFJFRkNMSyB0byBmbG93IG91dCB0
byB0aGUgc2xvdC4NCj4gSXQgaXMgb2JzZXJ2ZWQgdGhhdCBvbmUgb2YgdGhlIFBDSWUgc3dpdGNo
ZXMgKGNhc2UgaW4gcG9pbnQgQnJvYWRjb20gUENJZQ0KPiBHZW40IHN3aXRjaCkgaXMgcHJvcGFn
YXRpbmcgdGhlIENMS1JFUSBzaWduYWwgb2YgdGhlIHJvb3QgcG9ydCB0byB0aGUNCj4gZG93bnN0
cmVhbSBzaWRlIG9mIHRoZSBzd2l0Y2ggYW5kIGV4cGVjdGluZyB0aGUgZW5kcG9pbnRzIHRvIHB1
bGwgaXQgbG93DQo+IHNvIHRoYXQgaXQgKFBDSWUgc3dpdGNoKSBjYW4gZ2l2ZSBvdXQgdGhlIFJF
RkNMSyBhbHRob3VnaCB0aGUgU3dpdGNoIGFzDQo+IHN1Y2ggZG9lc24ndCBzdXBwb3J0IENMSy1Q
TSBvciBBU1BNLUwxU1MuIFNvLCBhcyBhIHdvcmthcm91bmQsIHRoaXMgcGF0Y2gNCj4gZHJpdmVz
IHRoZSBDTEtSRVEgb2YgdGhlIFJvb3QgUG9ydCBpdHNlbGYgbG93IHRvIGF2b2lkIGxpbmsgdXAg
aXNzdWVzDQo+IGJldHdlZW4gUENJZSBzd2l0Y2ggZG93bnN0cmVhbSBwb3J0IGFuZCBlbmRwb2lu
dHMuIFRoaXMgaXMgbm90IGEgd3JvbmcNCj4gdGhpbmcgdG8gZG8gYWZ0ZXIgYWxsIHRoZSBDTEtS
RVEgaXMgYW55d2F5IGJlaW5nIG92ZXJyaWRkZW4gdG8gJzAnDQo+IGludGVybmFsbHkgYW5kIG5v
dyBpdCBpcyBqdXN0IHRoYXQgdGhlIHNhbWUgaXMgYmVpbmcgcHJvcGFnYXRlZCBvdXRzaWRlDQo+
IGFsc28uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBWaWR5YSBTYWdhciA8dmlkeWFzQG52aWRpYS5j
b20+DQo+IFNpZ25lZC1vZmYtYnk6IE1hbmlrYW50YSBNYWRkaXJlZGR5IDxtbWFkZGlyZWRkeUBu
dmlkaWEuY29tPg0KPiAtLS0NCj4gQ2hhbmdlcyBWMSAtPiBWNjogTm9uZQ0KPiANCj4gIGRyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtdGVncmExOTQuYyB8IDIgKysNCj4gIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9wY2llLXRlZ3JhMTk0LmMgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3
Yy9wY2llLXRlZ3JhMTk0LmMNCj4gaW5kZXggOTg4M2QxNGY3Zjk3Li5mMDI2YWY3YzJjZTAgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtdGVncmExOTQuYw0K
PiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLXRlZ3JhMTk0LmMNCj4gQEAg
LTQ0LDYgKzQ0LDcgQEANCj4gICNkZWZpbmUgQVBQTF9QSU5NVVhfQ0xLUkVRX09WRVJSSURFCQlC
SVQoMykNCj4gICNkZWZpbmUgQVBQTF9QSU5NVVhfQ0xLX09VVFBVVF9JTl9PVkVSUklERV9FTglC
SVQoNCkNCj4gICNkZWZpbmUgQVBQTF9QSU5NVVhfQ0xLX09VVFBVVF9JTl9PVkVSUklERQlCSVQo
NSkNCj4gKyNkZWZpbmUgQVBQTF9QSU5NVVhfQ0xLUkVRX0RFRkFVTFRfVkFMVUUJQklUKDEzKQ0K
PiAgDQo+ICAjZGVmaW5lIEFQUExfQ1RSTAkJCQkweDQNCj4gICNkZWZpbmUgQVBQTF9DVFJMX1NZ
U19QUkVfREVUX1NUQVRFCQlCSVQoNikNCj4gQEAgLTE0MTUsNiArMTQxNiw3IEBAIHN0YXRpYyBp
bnQgdGVncmFfcGNpZV9jb25maWdfY29udHJvbGxlcihzdHJ1Y3QgdGVncmFfcGNpZV9kdyAqcGNp
ZSwNCj4gIAkJdmFsID0gYXBwbF9yZWFkbChwY2llLCBBUFBMX1BJTk1VWCk7DQo+ICAJCXZhbCB8
PSBBUFBMX1BJTk1VWF9DTEtSRVFfT1ZFUlJJREVfRU47DQo+ICAJCXZhbCAmPSB+QVBQTF9QSU5N
VVhfQ0xLUkVRX09WRVJSSURFOw0KPiArCQl2YWwgJj0gfkFQUExfUElOTVVYX0NMS1JFUV9ERUZB
VUxUX1ZBTFVFOw0KPiAgCQlhcHBsX3dyaXRlbChwY2llLCB2YWwsIEFQUExfUElOTVVYKTsNCj4g
IAl9DQo+ICANCg0KUmV2aWV3ZWQtYnk6IFZpZHlhIFNhZ2FyIDx2aWR5YXNAbnZpZGlhLmNvbT4N
Cg==
