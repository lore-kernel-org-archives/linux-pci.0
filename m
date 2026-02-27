Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013007.outbound.protection.outlook.com [40.107.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B44C30C343;
	Fri, 27 Feb 2026 12:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772195598; cv=fail; b=jZON0g0gNZ/W8jE/WWVegXtCBd/VZ/8yKPd9rDRjuSPhO/qQCLV0ePW5YHBFPSEDTvQmoqakPHS8iuDCgQDkOHliznHvWXtwajt2xDw21MstBGrj8hWIQTZec36QnHuPQhChxkp6wmY6BXrRVocXKE2AvvylYC2cosx//Sl35Dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772195598; c=relaxed/simple;
	bh=/KrqJwX1ESCMPaUJzeHgV/vWalPLr5hGtNh5lOcbYjg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NUGB2Cnybjf+H/OZbY7uGRg7XYilYi8AmnmEw2dvgxG5hLRGDOiyd0+Yze+o/tDVo59AUlZW9Sr078k8rVj4LzSZ/mMV3nN14elPTq88tV0PnBJC66VAU5vEDKm67c11O0vrQp0C37jTpkz0oEpfUioqGFXq/xvRb84UBTlA1GM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qN19UzVD; arc=fail smtp.client-ip=40.107.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qN19UzVD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qoickstJGZ4kpydwMYa+icJUNrx1adj+oyLyIBmoKNksuepxMqMrytcPth01aB0J3TuSoXpq4W+yTrjcwhJ2EKtDXIJTivjKGZhSk3lUXMuR3wFiUAXKCY6PDMX8N/NVJ75CGcvSp86Kkqmh8R4hGaXsIrTb9h+kF7Ro+cg0EtSgcb2UyN/sJq5CP3J5VTrUM1MiUcWGb0mK4YgPzaKkxbwhjGs0cBnE0ZZ1SK10AZ+U21PQa+u6GpL1chejjvqGcYF2OfaCbL6+10CBi9RWD/kxcdX0pXWm4xJuGIbSAhAzWiA81WIBx5b+OFoASpj+8B0+TGABvP4IGobNcIHNSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KrqJwX1ESCMPaUJzeHgV/vWalPLr5hGtNh5lOcbYjg=;
 b=nYlXTyIeBmpam/kGYohWyaDWtTAmLHLftVEx+vJ2RA0SkFUxBmz4tO37uL5hro5C/dOxiIL4zgmXda4httmfdPV4pSx+FP8FLnENRQFGL5w7p740vjfsoXOtPHgCdexoJhsCMiD4Ttp++8gZ/oxdq9tvfi2u7eTZbAvxXX3oZ0dfW1qV5Tf0Q/52f3b+wH1YLDcHkXwapoT5m7op5L8ndV8ydSgJSBYo+770AdNSEc45avoLmm0vWeMUugYGS7qak+Nb+c5NDq4bpfhQKvEKorSMBmmVklfBrw737DKCvrVkTriSXA0UF+j4Be0AJQvVc3umMOVqxOFxWobeEJZEgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KrqJwX1ESCMPaUJzeHgV/vWalPLr5hGtNh5lOcbYjg=;
 b=qN19UzVDYZpAS+9PdYZex8zGsZjzjdZ2gczuPYJvO5v/Hkc2SqTFSfujnro694aqNm2geG0tpXcS/EAToEc7ffATDUkQunnHxRx/OKKWO47Uc5StOMmyRJKjuhFQL0TGGgW2pti7sYFS8dPaVOwpls5svYKB6ViOb58Uwgs79Qdsa6JTTLoAy8Ucol48CBI8ZhmodQ/72//jREodAVyuF3l6Dm88jyi0jdz7J+w0+7shMNwPTn863e4F3y0g/+ZPU7l1eJqHH79ttmQVL+HEG66o+7fxi9mCfd7ai+qw7/A3ihXU7YHyd9MP0ErG2TbWQ4RTFj7ZZJ+VNe6Orqrscw==
Received: from SN7PR12MB6744.namprd12.prod.outlook.com (2603:10b6:806:26c::13)
 by SA1PR12MB6680.namprd12.prod.outlook.com (2603:10b6:806:253::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Fri, 27 Feb
 2026 12:33:12 +0000
Received: from SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961]) by SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961%3]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 12:33:12 +0000
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
Subject: Re: [PATCH v6 04/13] PCI: tegra194: Disable PERST IRQ only in
 Endpoint mode
Thread-Topic: [PATCH v6 04/13] PCI: tegra194: Disable PERST IRQ only in
 Endpoint mode
Thread-Index: AQHcpPRLKDXjO3E/30WcyP9LgM+PhrWWgI+A
Date: Fri, 27 Feb 2026 12:33:12 +0000
Message-ID: <36462e2f-034b-4402-ac5f-3f30de52f4e9@nvidia.com>
References: <20260223184151.3083221-1-mmaddireddy@nvidia.com>
 <20260223184151.3083221-5-mmaddireddy@nvidia.com>
In-Reply-To: <20260223184151.3083221-5-mmaddireddy@nvidia.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB6744:EE_|SA1PR12MB6680:EE_
x-ms-office365-filtering-correlation-id: b0e39973-71a6-41ef-7d4b-08de75fc5f66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|38070700021;
x-microsoft-antispam-message-info:
 OqKgRYHPX9ya7d7MzWTe5128iMko1dpDIVQTJfaQel6SL83AKQu3uNAPtSpFKDXHF2heHhLV+RwYB1bDccIq6jOckT6j+cBdFINBuOiHCkyfOuTy0rmSbAIH0tyQXJPU7U5Z9vNboNHY1gJEq+ohIx9tIynxsrHeqV8YK2UnQkG05rTeUKyHgRfdlnd4qTCYOLzhxY1+Ylubthla9KgEfrUW7XgctPyAkIaGVZBpR1voW3GAZCg3F8+tsclGxqUYnhaspTrXlMKi1dNTwhtpIfIjyiR7EGi6cY+8ACApp/gltkz196qsTI9ZMtYrQFO7ukRWcZ7qYzpmTBdllkkIhwTFjyKScZ2+1g+AxCafek1SO2cQKsHvLIplV3RnwdtkfR0nKEKqKINMWTQfQHfbwTbCi64RP2qqH3Ln5BQOP0YcA2e/1sIEzxz3gSWWuF7JrhivGd0nhpvrehpbaVd9eWOY4iDyfswkAJNcseD1pWYZiUMB7zw8eXhB/4Yxi1gskglgdxwIL4xJNDMd58upSKfuUZiG2yd5Ym3JXNL4CUMxunttdS/4rGE0/EzXZOeuQARoSJEc/L8KiJjicZjBqo6oVu3RdXlgGhxQJLd3BnCIM97zZqw6MUZzwu7poTAA+DzpZ0+2RcUd5QFnt+46n0NNjE5XKOFNvs85v2eVZC57LhiXYQhzQbGU0Gk9oWyNw184q3H1SDgXy4hCLRdwImnnK41RRD74fmKEA6J9aBy96Wht0pJz7hsSm+wqQrTQzuNsXc/gC16g7qZNDPEfUPN8gcOXgcQ0opIVv0L/Y75CZt2tkHMrrqtBWDCD5diu
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB6744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S0tDZm1YWVRwdDBJTzdxc1NzeUFuQ3RKc3BMQzkyRzltVllKeEFVY3IyUHVH?=
 =?utf-8?B?TGJPVlJRZWo0bkJCemFOd3BHUC8vbmMxZFRobzAzemgycGRIUUhrVjkzRVJL?=
 =?utf-8?B?QjdwTHNiL1BvMTFSUlIvTUZLUlFzZ0lpOUh6VmJiZEFCSDhSNVZIYzMyT3ZU?=
 =?utf-8?B?ZkJ1NjEwZCtjaXpMUk56bXJnd3ZEVEJxVDhzb05zZHVmUUpaZUJUdGpXTEpu?=
 =?utf-8?B?bERaa0EvSStTcmJLVUlsUzZ5TXZUNmxaY2ZldUVrZmthRUJpTUpaVFlSR3VI?=
 =?utf-8?B?WWZvMTFNa0tDL0NwYi9tNFl5cUZVbVJ4dm1mQ3ZMVGVDUkFJV0taZnVEUTIy?=
 =?utf-8?B?ck9TM204WFBNMDJYb2crbFB5REFPNkxWVmtYVmVGS0E4d3dCN2xGWnVpOGdT?=
 =?utf-8?B?TXZMcUpyaTgvelpTdnpZeE9NZDdTTFBnQThCTGtuMTBmdHFjQjNiMUt4cm10?=
 =?utf-8?B?NmY4YUV4N0d5VUpyRDlHRVdSWlB2SEZMZlBEbzZSR0NqNk1lYWd3dzJaRFUz?=
 =?utf-8?B?WU40MzlmWlYrYlVXTEloY21RTUd1OFZicDgxUFR1UG8rQ05UNE02ZVFhcHIz?=
 =?utf-8?B?V3ZIcGdiMzFZK3dzNDBtczVUVm9Qa2xXY0tYOXlDbEkxWGdUMmVOK2lWZ2pz?=
 =?utf-8?B?UGs4am9GSmoyRXN0dzQ4bG45ZDR1Z2VVcjhCZW94a3ZiNVg5SWhsVE56cmJI?=
 =?utf-8?B?d29LRDkyVEdCMG00WUx3Y2t5NlBFc3Y2RkNRS3RuMVZtY2NUZmh4VndDeXpB?=
 =?utf-8?B?QWZNVXFyVFJOejZCa29rd3MxcWd2RndJSytqQnRpM3h2bkRpL3JEbThZVTla?=
 =?utf-8?B?TTNJT25SWHZ2MzRyVis4empMNkJ4RlRGNlB0RU91enp1Vm1KV2lTUllSeFJM?=
 =?utf-8?B?aTM4RHI1RStzaU16aVdoRXRudVNnMXRjaURjdWErUWhadTNRbTU1Uzc5L1Jn?=
 =?utf-8?B?Y0VzMWUydE1GWFBmWFdoL08yMndvcENBam8yVXA5OVd6NW9lVHNNbGh4YnpN?=
 =?utf-8?B?aS9iMENKd2YxbHIwcHhuMWdPTnZuZlBxMVRuNEkzSVpEaGpGeWU5SUN5Qngv?=
 =?utf-8?B?U3pZQ1NiNExGNVY2NEFhU1p2ZHFydzc2aExMSEZKakhPK0o1cXRDQ3ZreW15?=
 =?utf-8?B?Ky80dlBOOTdRc3FscFFqUEVSUTQwR0xwcUk2YmlBSTRLK2pKb3NqWDlTOW1X?=
 =?utf-8?B?dmp1SHNQQnFBR2NCNU5pSUNJWHFUMGgxUHFadkppZWFkVktyR1NGUDJLZStW?=
 =?utf-8?B?RzE2N282YWVXQ0ZCQWdmeUV4Zzl2QnpJNFJnYlNkNmFQSEtPeUNZRHFUUnda?=
 =?utf-8?B?ZStxeG1jTWNBc24rMXc0bnd5UkNvZmhXbjdFQkVEdmpEa3dUcUtDSk9WRUc1?=
 =?utf-8?B?N3RwWHhSbXZyOXQyOVBYR3VDaGFVV3huSVZWak5GNzVZNHFHV0xkejBWUDJa?=
 =?utf-8?B?aE5RbEdHajVHNXVoNHI5K2dQRjJCSjhOV21hWmczNVdlMEpzdXZiYm5WYWN5?=
 =?utf-8?B?U2d1R2haa1RHdVdzZFhlT2hkWElZSDQ2T3k2NzhvYVJVSENyNU52YjhaMFl3?=
 =?utf-8?B?VDluWTdDbDBrQWNYSFVPTUthNFNKd2VQM1BEM0J2U2Rrcm9yNWoyak0zaHlB?=
 =?utf-8?B?SFQxdmRkUGRRVUJ4d3RDRzhvN052dDdXVUk0N2t4NkNhbnFCUjV1SldLMmFQ?=
 =?utf-8?B?VjBORW1WQXdyZGJJNnprYXkrUUlzRzBJMDlIUStKTG9relArQ1dsWi9IKytF?=
 =?utf-8?B?amlwbVFaL0NXTVYzWjhuS3o4TFJIaUVBdmszZGQ3QkdDMUE0U1dYcG40dzVQ?=
 =?utf-8?B?dEFlWG9ZTGZlZ3YxRG9naTlMSDdWb2hvUHlzajVyK3NmN3RPbHJkUDZNcWRQ?=
 =?utf-8?B?b3NHSlZmVzA2RnczeGJzek05MFNyTlhjdDVOZmNObGxBT0dFLzUrcHQzUzVj?=
 =?utf-8?B?UnBOWlA1VG9naVlLS0tOakpWU1RPZ0ZCQzY0Y2pQZjVwbitwRFJ3ZFBrMGdq?=
 =?utf-8?B?aXBNdHNxd2liNDcxNFBHaUM3U1Q0ZnZ6NFZTMDF0MzNsRnhhRkpybm9wbTI3?=
 =?utf-8?B?bU5SVURIUVVnVHRENjdrbFB2WEl0RXZ2cmdDRkkyNkl2bWhZVmY5Ti8xbTBX?=
 =?utf-8?B?alpjcWR1WkZTRThTRDBaWUVuMzh0WWNWQXBFbE5ndXdtU1lBV1FsQnphcmFp?=
 =?utf-8?B?RmFWQ3JjYW03WVFxQlBXekNTVGNSZU1nZ1A5dDBaaU4yRkNvVHc2VzFHZjBo?=
 =?utf-8?B?S3FVNk1ObFJvZXFaRml5VzdncHNuVDdMbG5tZkp4S0wyK1VYTGlxK0o5SHhi?=
 =?utf-8?B?cmRPOUJ6ZXlWWHFBbkZTb1NXMm1WbjNZdC9ySUkrNjdhWVNLWUwrZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C971E46EF8517A47937E56595D2381E9@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e39973-71a6-41ef-7d4b-08de75fc5f66
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 12:33:12.5678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wzWrxVm+XdcEQfG95FEfyTehY0AsHtblzToU3zDqPhoTKPrFsn9gvCnJ/TALEIJVrJr5vmIQ74LeRtbAAAp7dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6680

T24gMjQvMDIvMjYgMDA6MTEsIE1hbmlrYW50YSBNYWRkaXJlZGR5IHdyb3RlOg0KPiBUaGUgUEVS
U1QgKFBFUlNUIykgR1BJTyBpbnRlcnJ1cHQgaXMgb25seSByZWdpc3RlcmVkIHdoZW4gdGhlIGNv
bnRyb2xsZXINCj4gaXMgb3BlcmF0aW5nIGluIEVuZHBvaW50IG1vZGUuIEluIFJvb3QgUG9ydCBt
b2RlLCB0aGUgUEVSU1QgR1BJTyBpcw0KPiBjb25maWd1cmVkIGFzIGFuIG91dHB1dCB0byBjb250
cm9sIGRvd25zdHJlYW0gZGV2aWNlcywgYW5kIG5vIGludGVycnVwdA0KPiBpcyByZWdpc3RlcmVk
IGZvciBpdC4NCj4gDQo+IEN1cnJlbnRseSwgdGVncmFfcGNpZV9kd19zdG9wX2xpbmsoKSB1bmNv
bmRpdGlvbmFsbHkgY2FsbHMgZGlzYWJsZV9pcnEoKQ0KPiBvbiBwZXhfcnN0X2lycSwgd2hpY2gg
Y2F1c2VzIGlzc3VlcyBpbiBSb290IFBvcnQgbW9kZSB3aGVyZSB0aGlzIElSUSBpcw0KPiBub3Qg
cmVnaXN0ZXJlZC4NCj4gDQo+IEZpeCB0aGlzIGJ5IG9ubHkgZGlzYWJsaW5nIHRoZSBQRVJTVCBJ
UlEgd2hlbiBvcGVyYXRpbmcgaW4gRW5kcG9pbnQgbW9kZSwNCj4gd2hlcmUgdGhlIGludGVycnVw
dCBpcyBhY3R1YWxseSByZWdpc3RlcmVkIGFuZCB1c2VkIHRvIGRldGVjdCBQRVJTVA0KPiBhc3Nl
cnRpb24vZGVhc3NlcnRpb24gZnJvbSB0aGUgaG9zdC4NCj4gDQo+IEZpeGVzOiBjNTcyNDdmOTQw
ZTggKCJQQ0k6IHRlZ3JhOiBBZGQgc3VwcG9ydCBmb3IgUENJZSBlbmRwb2ludCBtb2RlIGluIFRl
Z3JhMTk0IikNCj4gU2lnbmVkLW9mZi1ieTogTWFuaWthbnRhIE1hZGRpcmVkZHkgPG1tYWRkaXJl
ZGR5QG52aWRpYS5jb20+DQo+IC0tLQ0KPiBDaGFuZ2VzIFYxIC0+IFY2OiBOb25lDQo+IA0KPiAg
ZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS10ZWdyYTE5NC5jIHwgMyArKy0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLXRlZ3JhMTk0LmMgYi9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLXRlZ3JhMTk0LmMNCj4gaW5kZXggODA4YTFlMjEz
Yjc5Li45NDU1NDU2MDI4YmMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaWUtdGVncmExOTQuYw0KPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9w
Y2llLXRlZ3JhMTk0LmMNCj4gQEAgLTEwMjgsNyArMTAyOCw4IEBAIHN0YXRpYyB2b2lkIHRlZ3Jh
X3BjaWVfZHdfc3RvcF9saW5rKHN0cnVjdCBkd19wY2llICpwY2kpDQo+ICB7DQo+ICAJc3RydWN0
IHRlZ3JhX3BjaWVfZHcgKnBjaWUgPSB0b190ZWdyYV9wY2llKHBjaSk7DQo+ICANCj4gLQlkaXNh
YmxlX2lycShwY2llLT5wZXhfcnN0X2lycSk7DQo+ICsJaWYgKHBjaWUtPm9mX2RhdGEtPm1vZGUg
PT0gRFdfUENJRV9FUF9UWVBFKQ0KPiArCQlkaXNhYmxlX2lycShwY2llLT5wZXhfcnN0X2lycSk7
DQo+ICB9DQo+ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZHdfcGNpZV9vcHMgdGVncmFfZHdf
cGNpZV9vcHMgPSB7DQoNClJldmlld2VkLWJ5OiBWaWR5YSBTYWdhciA8dmlkeWFzQG52aWRpYS5j
b20+DQo=
