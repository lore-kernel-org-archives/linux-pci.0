Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012069.outbound.protection.outlook.com [40.107.200.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9228533260A;
	Fri, 27 Feb 2026 12:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772195571; cv=fail; b=G4eFknFgR81Si7rSSTOzVbUyuZOmcouZgmJcNFAbcwPexshAVFj6nGjEa/7Odjmhmblia37H93hZiguulxyq4lbEuWeo+YUdK2vCE6OoZZwtEaJ2C4OeDYafY/qIO0701oPSHJLA/f68kFIP2/C/IRe6juuxTCP83x35D3meuZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772195571; c=relaxed/simple;
	bh=Rni0wwvJu3gY3Bu/1HpnuzW56IHXyj0WSVxstVYx5U0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iHYTx1ByjBykfGfpgZRSuN4gi0Y2VBCrDAz2fmfn06DimnPf7XsACV/aw+HuZk2kuFDUsbKACKaDGqIMCf9PO7DxRwkm6H96aGeSeH13jcP/bEQm7F0Zid2X9Lu8iI1+CVfrMNwYNp20N64jt4039bVVwZhNfDrMNeTTCtJ6F0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ld33VBRm; arc=fail smtp.client-ip=40.107.200.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ld33VBRm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D0Egk7vDTg1qLFjjyWC6zirAyFhK1Hj9cIuKR8m4YsPIqK01pvFhJSIa9Ua1islC/T1V2UlxhOWTvKtRNRjelnE63E3Jdk/Rr7lt5IPwnberKC9C856c1limKGHptqHSkcy39EsFzL+2MUYZOGKBtORMEgx9Vpshh8aUoo+TvQIQjWfPT8r2kv0OlLi9VEq4p5pPb7rHi6VDPifrZQrM8kOHBDqcE2f6WFNfx6yNjj0f5YARQnym5SdK0TIGWxvuiTUAdB6X3B0HrY9GZNREMdjCxHStVZSxEOZE4Wk+qsODx2Zuhdk56tZYjhRFeF4v0tMjq1M0k4RA+UwJ9T4OMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rni0wwvJu3gY3Bu/1HpnuzW56IHXyj0WSVxstVYx5U0=;
 b=b/8c5aC3K/uoERaptJb+WDaU0v5aKkrSDQGFgiQSFv9Xa7fYI6FWmPUUIL85BfCGj/gj6hpf0bRAOv/ofon7WRL0YTrHukDFCXsorKhrXmcbxGITf/Zi5SnN2kYtxOxosK53coQOZv32onuy5mBGCovzHfMfCWtfIED1l/1/58lmG3ngZ4Md8gOkYJY4yjf4rac4ZptixtwFn5FVvWo6BG1noGYT3Gra25VSXUZs4j/i3/9fRn1QC8y8ymqxCf4c2g9R7rUk5zjpWAC6LkzRHvh/r977YZI4H/vwyhJZgLud+aEQFYfbjLnyIXoRclsmi5rAeB0K6opLKZU2QlnXRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rni0wwvJu3gY3Bu/1HpnuzW56IHXyj0WSVxstVYx5U0=;
 b=ld33VBRm7R3uE6t4DsPm3qy2B2nMwwZLcYewNYX5PBGbmYBewDtvVwl/FqxoEX0BaYb0RTXLFMAgPn91sIKdf0t+HzyX9cPuEA5G17NwoWsxKK3WlL/ZMSIWwUTyYBFkebkdoIPZ7NogUgDTZrl/1gPpguGoUekcolpt8T9lzVXI6VRZwv019evlYkPnYVeIDKNDpD9fJRWJRvlzRubimlRrCcsTxyphYj7SwxTjxr/On7R+A+VHoVUGmP/zJeHtS9OjCMlRhrIrZucy2bp8at3cJKxuEZXyRguwy1C7mJbUplDVHaiIxqtzamYYEmHi0qs2eXcTm78jihFHAEsMLg==
Received: from SN7PR12MB6744.namprd12.prod.outlook.com (2603:10b6:806:26c::13)
 by SA1PR12MB6680.namprd12.prod.outlook.com (2603:10b6:806:253::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Fri, 27 Feb
 2026 12:32:45 +0000
Received: from SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961]) by SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961%3]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 12:32:45 +0000
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
Subject: Re: [PATCH v6 02/13] PCI: tegra194: Refactor LTSSM state polling on
 surprise down
Thread-Topic: [PATCH v6 02/13] PCI: tegra194: Refactor LTSSM state polling on
 surprise down
Thread-Index: AQHcpPRAr9fKnkrzkkyfIUkB4BzsSrWWgG8A
Date: Fri, 27 Feb 2026 12:32:45 +0000
Message-ID: <0d183970-eb68-4139-aba1-27662691f36d@nvidia.com>
References: <20260223184151.3083221-1-mmaddireddy@nvidia.com>
 <20260223184151.3083221-3-mmaddireddy@nvidia.com>
In-Reply-To: <20260223184151.3083221-3-mmaddireddy@nvidia.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB6744:EE_|SA1PR12MB6680:EE_
x-ms-office365-filtering-correlation-id: 743f921e-8814-4815-4265-08de75fc4f39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|38070700021;
x-microsoft-antispam-message-info:
 k477MdNLvUUVmg8YheSg/K7lGh6Rm55cmSWKqQ0rr/07IbZX4Hy7/MmE2cY9kilSqw09TVN/xfwJcLrJovklyKO6hvIWbPr+LnuwpKuuzw1+GbeGl4mZCKlDcsQMXWZXMqQutN0IM/neC44EO3RJllP2G/31ENx5LPc/8Ww+wTohXUpXNgfocShe0LY/JGLGtT5qgR2NPB2S3XV5rne+GvbCmogDnO5Bvwu6AZfLnZoZO786q+AVK5dsRXDM50SfNFPY8EYYHSqNGDvNCtXWol33YmpGt141bGEqbcXurwfo5pV82VlIByL+/9+oCcJn+HErxJV9CogPu4ag7iWZ7dND26gszS32rF+6STHwPI1uS0+W9gBzonAXTLhhx3j9KA2NAUpK58TjXOph5XL77V1/+gOeNv596tOT/l/S7KEKAmfIjMr9DJSObKf2+9KLd81oI0fdp222dUaQabG3tSW5R5kQqPze0ThLIZJjiDyOsFdjB6+hmy1VqQL9IOO7mYzbRE1lXmGScYiZbVwB696mcCbHK9oh2lYjzTwuYWEe4QYr/971h7SiyY8sF3w+tv6a2C6uiEgSKE+lQ2Wh8fWpoFa4fGnCLircuG4C4FnDHHE2uRy07X6a18UwZG/B+onsNKCAMZUNFCBgzF1anofmKquzUI9VAsxnofR81iyz0c8etXnZYBtlWLW3jaUPstXrStlFOcTyf0xFRco21PaQ52wrw4zju4JpPrJz4kWH9SA87yl3PEz+p3hXmELVjGyzWzbtS3+xtLO9rpp7V2i1JmrxfTdTM7Fujj312sgOyKe87SEzVeDUK4+USzab
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB6744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a0NHWkpKTm1ZdnhIZSt6V1RlT2tYVWpIckpDcmdBbFpQZ05kZWRJbEdCWWFh?=
 =?utf-8?B?V0VMbHZVNnVKeEduU2htUTdZRVlNMkJMa2lPaTdzSFRVNzBvb1ZnMkhzcDBN?=
 =?utf-8?B?ZFlockd5NHJPZ3hWbU9TaUtJQnU5dHUwVXlnWG5nT2NoaURlRHh2dHN6ek5y?=
 =?utf-8?B?elljMDRSSU9vNWZuSytONzNReUVjcnd0cFZkQTRTc1FQc3hmS04yTlQ5OHlN?=
 =?utf-8?B?eWNFSzIxeDRteCtCWnhjMWI3TjJuT1dlSzdoY25vN0JiUXp4UFVXQnhPc1l4?=
 =?utf-8?B?eldCTFZuNXRYK05qWGhOc3pIS0toaFhsaWxXc2ZSWW80VDNZL0tRbWVETnU0?=
 =?utf-8?B?RHpGSzRDZGJIeGRzaVVPN0w3MXg5VFJCTklmVTFGSldvYVBHVFAwSmh2ekM5?=
 =?utf-8?B?L2NjMEgwTGZDaWtHVSt0Lzd5c1Rtd2dadGY4ZCtIUHNRYWZmZHJsWXlPKzN5?=
 =?utf-8?B?SEhJZk5sMmxiUzdWbkMrVytiaEYvMnN1QXJMOGVNcVFCSnp1MUNROHdOVE1C?=
 =?utf-8?B?MXpGamIwSkh1azVzenNOQW9xNVNFZ2kzMHBwVytKcG9pVFkvUXB6RTgwZEx5?=
 =?utf-8?B?ckJXWFpEMmZOUGN4SWs5UkhRRzlWaFl4REROVUUzQjZJMURPbC9aV2t3c3M4?=
 =?utf-8?B?dkF2amRlcUc4RFRlM0J3N3d6bk9QaFNMNGlNbGpFMW0vNzQ0MUNFTGtCYjN1?=
 =?utf-8?B?akNtY3I2MmFvYzlZamhWWUFLaVdGNTZTNTZVRktNSm9ia3RBNFNQSUVhRzIv?=
 =?utf-8?B?UHlhYkJZcWVaK3A2UWE0MDdzZFluRk9pVkxJRzBHMUdTenNjMWNNSmZWRTk1?=
 =?utf-8?B?MFpyL2R5NkhyK2VOT2lGQ2pDSDhRODVjdUx6Z1JPYkt3SmtnYWxpUGJJT1dz?=
 =?utf-8?B?dGZmWUQzeGFZZnR0TWpSY2xtYlBLQVBicFFlZ1lncmJUL2x6RDJDYlVyK3Vn?=
 =?utf-8?B?TWJ3YlNhRGxIdFFNVC90Tzk1ZzdXcmNqVTcyUG1teFp0b0VjNlFKaTBxb0R6?=
 =?utf-8?B?TE1qY3BpTVEzdlJTaExTUDIxeXNPVUowQk44azFxZkxvd1Y2QnZkeDB1Zmp4?=
 =?utf-8?B?T1N0SU5QeG5BOEtYM2ZFNXFMZmdqeHNKMU53NGxPdU5Ib1ExUE9aQ2hVTEFD?=
 =?utf-8?B?eHpPeUFWamw3ZlArMHRxdHZna1A1Qlc0WmpuaGR4MDZyZkljYUlaay9oYUJi?=
 =?utf-8?B?WERGc1V0eUJWTnJ4ZkhmbTBMNzZzamVZMS9qekFuNmZwYzN6RmpXV2IrZVNk?=
 =?utf-8?B?WDV0M1h0MEt3cmVYZWt5dnF0cERTanhoeTNoMUd6aVlkdU90NFJ0TlFXUjY1?=
 =?utf-8?B?dlJhVmxack4rT3dLdVQydFdjVjdmRTkyeWtCK0ZTcTcrOHZrUFFtU1VnOElX?=
 =?utf-8?B?eWpxeEc5S3Y2WE5SL2k4MmkrWlZzcnhYd0FXUjNEMDMrS2xFSVpuRHk1SW9I?=
 =?utf-8?B?K0ZEUmpsWGhySU1MQlFjTnZmSytINjNwODJIajlRSDBsaTdyN3hmbWh2UUsz?=
 =?utf-8?B?K2hKUDY4aXdMOXVSY1hSckR6QTA1TUJrZDQ3cGE0V21BM2xmQ2RVZjN6QVhr?=
 =?utf-8?B?SStsMVIrQjlWM0M3K1YwZk1CTXh4MlozaklsK2ZaWXhMQ1lRSTFOZURDRTc1?=
 =?utf-8?B?V3dMM0F6a2JGZzUzTXdHdzJ1M2o2NXE4MllqNERBemMxQ2FZV2ZiU2h3QUhn?=
 =?utf-8?B?eFFiU2xlTFFUZVN1K3RTUGc1T0FLWk1zVmRKazR3NFFHYkRYTFpMTjEwU2RI?=
 =?utf-8?B?ZU0wOUNnYTZqOUlCMW9vd3RkRHk0OXZRL3hVWWQ2ditKRnoyMXdsU2RyUExT?=
 =?utf-8?B?V3VVU0FUR0xxR3Q1THVVcnZod1ZJWmU2UVlNbEk0bTQ3eExvRXRGaDB2Mlcy?=
 =?utf-8?B?dDl2SGJIdzl5eWhEaEI1WHQvUDFkdFM4bm9vNFVyU1RRb29EYzF0SWlucWpq?=
 =?utf-8?B?bG9BL2JTVi9CMGlSU3VYWEMrNzFhUXMxNXhDdDhGa2NHYytYeVQ4ZTQ3RDdq?=
 =?utf-8?B?ejM5NW55UWZNWXkrOXFGdTh1cXBwSGM5eHcyNTV1TFRsRjlHSE5UeThQTXB4?=
 =?utf-8?B?RHpVSUo3aHJGODBSOVVpaUlRTlFjZllSRnhiVTcxdEt4eVdxQnlQWWowMXlJ?=
 =?utf-8?B?Z0tpMisrbDVDdGtkaWpRaGdLa2JkRStJQ2lKSTZCMUJDcmpkeE55NnV4MmRN?=
 =?utf-8?B?d0c0dlU2bExFQkJIMTRVdE92aEpvZ2w3N090U3N3V2NrT2VjZTNadm1JOS9x?=
 =?utf-8?B?dTBPYjRkVkxkNEFBUGV6TDQ1Q21UM1hydmFmd0J5dEh0M2c3b3I1NFV5ZmVj?=
 =?utf-8?B?VXN2dlA5ZFJBaUpLaVhvUFZEZzVLWDcraXVlQzdEZUJLY3JMeEg5QT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0B893A336C09240B7A0696A65392C32@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 743f921e-8814-4815-4265-08de75fc4f39
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 12:32:45.4290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tsSG0xQXqPxgcH+PLnskNHG8Qkad7dEpzbvxIgkJheSX0ZmT6fWm8MQI750VbUFRQAiK29YfWpEKXiToPH3wMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6680

T24gMjQvMDIvMjYgMDA6MTEsIE1hbmlrYW50YSBNYWRkaXJlZGR5IHdyb3RlOg0KPiBGcm9tOiBW
aWR5YSBTYWdhciA8dmlkeWFzQG52aWRpYS5jb20+DQo+IA0KPiBPbiBzdXJwcmlzZSBkb3duLCBM
VFNTTSBzdGF0ZSB0cmFuc2l0cyBmcm9tIEwwIC0+IFJlY292ZXJ5LlJjdnJMb2NrIC0+DQo+IFJl
Y292ZXJ5LlJjdnJTcGVlZCAtPiBHZW4xIFJlY292ZXJ5LlJjdnJMb2NrIC0+IERldGVjdC4gUmVj
b3ZlcnkuUmN2ckxvY2sNCj4gYW5kIFJlY292ZXJ5LlJjdnJTcGVlZCB0cmFuc2l0IHRpbWVzIGFy
ZSAyNCBtc2VjIGFuZCA0OCBtc2VjIHJlc3BlY3RpdmVseS4NCj4gU28sIHRoZSB0b3RhbCB0aW1l
IHRha2VuIHRvIHRyYW5zaXQgZnJvbSBMMCB0byBkZXRlY3Qgc3RhdGUgaXMgfjk2IG1zZWMuDQo+
IEhlbmNlLCBpbmNyZWFzZSB0aGUgcG9sbCB0aW1lIHRvIDEyMCBtc2VjLg0KPiANCj4gRGlzYWJs
ZSB0aGUgTFRTU00gc3RhdGUgYWZ0ZXIgaXQgdHJhbnNpdHMgdG8gZGV0ZWN0IHRvIGF2b2lkIExU
U1NNDQo+IHRvZ2dsaW5nIGJldHdlZW4gcG9sbGluZyBhbmQgZGV0ZWN0IHN0YXRlcy4NCj4gDQo+
IHRlZ3JhX3BjaWVfZHdfcG1lX3R1cm5vZmYoKSBmdW5jdGlvbiBpcyBjYWxsZWQgaW4gbm9uLWF0
b21pYyBjb250ZXh0DQo+IG9ubHksIHNvIHVzZSB0aGUgbm9uLWF0b21pYyBwb2xsIGZ1bmN0aW9u
Lg0KPiANCj4gRml4ZXM6IDU2ZTE1YTIzOGQ5MiAoIlBDSTogdGVncmE6IEFkZCBUZWdyYTE5NCBQ
Q0llIHN1cHBvcnQiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBWaWR5YSBTYWdhciA8dmlkeWFzQG52aWRp
YS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IE1hbmlrYW50YSBNYWRkaXJlZGR5IDxtbWFkZGlyZWRk
eUBudmlkaWEuY29tPg0KPiAtLS0NCj4gQ2hhbmdlcyBWNSAtPiBWNjogUmV0YWluIG9ubHkgb25l
IGZpeGVzIHRhZw0KPiBDaGFuZ2VzIFYxIC0+IFY1OiBOb25lDQo+IA0KPiAgZHJpdmVycy9wY2kv
Y29udHJvbGxlci9kd2MvcGNpZS10ZWdyYTE5NC5jIHwgNTUgKysrKysrKysrKysrKy0tLS0tLS0t
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKyksIDIzIGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtdGVncmEx
OTQuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtdGVncmExOTQuYw0KPiBpbmRl
eCA5NmQzODU3MWE3ZTcuLjRhYzZiMWNlYTEzZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9kd2MvcGNpZS10ZWdyYTE5NC5jDQo+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvZHdjL3BjaWUtdGVncmExOTQuYw0KPiBAQCAtMTM3LDcgKzEzNywxMSBAQA0KPiAgI2Rl
ZmluZSBBUFBMX0RFQlVHX1BNX0xJTktTVF9JTl9MMAkJMHgxMQ0KPiAgI2RlZmluZSBBUFBMX0RF
QlVHX0xUU1NNX1NUQVRFX01BU0sJCUdFTk1BU0soOCwgMykNCj4gICNkZWZpbmUgQVBQTF9ERUJV
R19MVFNTTV9TVEFURV9TSElGVAkJMw0KPiAtI2RlZmluZSBMVFNTTV9TVEFURV9QUkVfREVURUNU
CQkJNQ0KPiArI2RlZmluZSBMVFNTTV9TVEFURV9ERVRFQ1RfUVVJRVQJCTB4MDANCj4gKyNkZWZp
bmUgTFRTU01fU1RBVEVfREVURUNUX0FDVAkJCTB4MDgNCj4gKyNkZWZpbmUgTFRTU01fU1RBVEVf
UFJFX0RFVEVDVF9RVUlFVAkJMHgyOA0KPiArI2RlZmluZSBMVFNTTV9TVEFURV9ERVRFQ1RfV0FJ
VAkJCTB4MzANCj4gKyNkZWZpbmUgTFRTU01fU1RBVEVfTDJfSURMRQkJCTB4YTgNCj4gIA0KPiAg
I2RlZmluZSBBUFBMX1JBRE1fU1RBVFVTCQkJMHhFNA0KPiAgI2RlZmluZSBBUFBMX1BNX1hNVF9U
VVJOT0ZGX1NUQVRFCQlCSVQoMCkNCj4gQEAgLTIwMSw3ICsyMDUsOCBAQA0KPiAgI2RlZmluZSBQ
TUVfQUNLX0RFTEFZCQkxMDAgICAvKiAxMDAgdXMgKi8NCj4gICNkZWZpbmUgUE1FX0FDS19USU1F
T1VUCQkxMDAwMCAvKiAxMCBtcyAqLw0KPiAgDQo+IC0jZGVmaW5lIExUU1NNX1RJTUVPVVQgNTAw
MDAJLyogNTBtcyAqLw0KPiArI2RlZmluZSBMVFNTTV9ERUxBWQkJMTAwMDAJLyogMTAgbXMgKi8N
Cj4gKyNkZWZpbmUgTFRTU01fVElNRU9VVAkJMTIwMDAwCS8qIDEyMCBtcyAqLw0KPiAgDQo+ICAj
ZGVmaW5lIEdFTjNfR0VONF9FUV9QUkVTRVRfSU5JVAk1DQo+ICANCj4gQEAgLTE1OTEsMjMgKzE1
OTYsMjIgQEAgc3RhdGljIHZvaWQgdGVncmFfcGNpZV9kd19wbWVfdHVybm9mZihzdHJ1Y3QgdGVn
cmFfcGNpZV9kdyAqcGNpZSkNCj4gIAkJZGF0YSAmPSB+QVBQTF9QSU5NVVhfUEVYX1JTVDsNCj4g
IAkJYXBwbF93cml0ZWwocGNpZSwgZGF0YSwgQVBQTF9QSU5NVVgpOw0KPiAgDQo+ICsJCWVyciA9
IHJlYWRsX3BvbGxfdGltZW91dChwY2llLT5hcHBsX2Jhc2UgKyBBUFBMX0RFQlVHLCBkYXRhLA0K
PiArCQkJKChkYXRhICYgQVBQTF9ERUJVR19MVFNTTV9TVEFURV9NQVNLKSA9PSBMVFNTTV9TVEFU
RV9ERVRFQ1RfUVVJRVQpIHx8DQo+ICsJCQkoKGRhdGEgJiBBUFBMX0RFQlVHX0xUU1NNX1NUQVRF
X01BU0spID09IExUU1NNX1NUQVRFX0RFVEVDVF9BQ1QpIHx8DQo+ICsJCQkoKGRhdGEgJiBBUFBM
X0RFQlVHX0xUU1NNX1NUQVRFX01BU0spID09IExUU1NNX1NUQVRFX1BSRV9ERVRFQ1RfUVVJRVQp
IHx8DQo+ICsJCQkoKGRhdGEgJiBBUFBMX0RFQlVHX0xUU1NNX1NUQVRFX01BU0spID09IExUU1NN
X1NUQVRFX0RFVEVDVF9XQUlUKSwNCj4gKwkJCUxUU1NNX0RFTEFZLCBMVFNTTV9USU1FT1VUKTsN
Cj4gKwkJaWYgKGVycikNCj4gKwkJCWRldl9pbmZvKHBjaWUtPmRldiwgIkxpbmsgZGlkbid0IGdv
IHRvIGRldGVjdCBzdGF0ZVxuIik7DQo+ICsNCj4gIAkJLyoNCj4gLQkJICogU29tZSBjYXJkcyBk
byBub3QgZ28gdG8gZGV0ZWN0IHN0YXRlIGV2ZW4gYWZ0ZXIgZGUtYXNzZXJ0aW5nDQo+IC0JCSAq
IFBFUlNUIy4gU28sIGRlLWFzc2VydCBMVFNTTSB0byBicmluZyBsaW5rIHRvIGRldGVjdCBzdGF0
ZS4NCj4gKwkJICogRGVhc3NlcnQgTFRTU00gc3RhdGUgdG8gc3RvcCB0aGUgc3RhdGUgdG9nZ2xp
bmcgYmV0d2Vlbg0KPiArCQkgKiBwb2xsaW5nIGFuZCBkZXRlY3QuDQo+ICAJCSAqLw0KPiAgCQlk
YXRhID0gcmVhZGwocGNpZS0+YXBwbF9iYXNlICsgQVBQTF9DVFJMKTsNCj4gIAkJZGF0YSAmPSB+
QVBQTF9DVFJMX0xUU1NNX0VOOw0KPiAgCQl3cml0ZWwoZGF0YSwgcGNpZS0+YXBwbF9iYXNlICsg
QVBQTF9DVFJMKTsNCj4gLQ0KPiAtCQllcnIgPSByZWFkbF9wb2xsX3RpbWVvdXRfYXRvbWljKHBj
aWUtPmFwcGxfYmFzZSArIEFQUExfREVCVUcsDQo+IC0JCQkJCQlkYXRhLA0KPiAtCQkJCQkJKChk
YXRhICYNCj4gLQkJCQkJCUFQUExfREVCVUdfTFRTU01fU1RBVEVfTUFTSykgPj4NCj4gLQkJCQkJ
CUFQUExfREVCVUdfTFRTU01fU1RBVEVfU0hJRlQpID09DQo+IC0JCQkJCQlMVFNTTV9TVEFURV9Q
UkVfREVURUNULA0KPiAtCQkJCQkJMSwgTFRTU01fVElNRU9VVCk7DQo+IC0JCWlmIChlcnIpDQo+
IC0JCQlkZXZfaW5mbyhwY2llLT5kZXYsICJMaW5rIGRpZG4ndCBnbyB0byBkZXRlY3Qgc3RhdGVc
biIpOw0KPiAgCX0NCj4gIAkvKg0KPiAgCSAqIERCSSByZWdpc3RlcnMgbWF5IG5vdCBiZSBhY2Nl
c3NpYmxlIGFmdGVyIHRoaXMgYXMgUExMLUUgd291bGQgYmUNCj4gQEAgLTE2ODEsMTkgKzE2ODUs
MjQgQEAgc3RhdGljIHZvaWQgcGV4X2VwX2V2ZW50X3BleF9yc3RfYXNzZXJ0KHN0cnVjdCB0ZWdy
YV9wY2llX2R3ICpwY2llKQ0KPiAgCWlmIChwY2llLT5lcF9zdGF0ZSA9PSBFUF9TVEFURV9ESVNB
QkxFRCkNCj4gIAkJcmV0dXJuOw0KPiAgDQo+IC0JLyogRGlzYWJsZSBMVFNTTSAqLw0KPiArCXJl
dCA9IHJlYWRsX3BvbGxfdGltZW91dChwY2llLT5hcHBsX2Jhc2UgKyBBUFBMX0RFQlVHLCB2YWws
DQo+ICsJCSgodmFsICYgQVBQTF9ERUJVR19MVFNTTV9TVEFURV9NQVNLKSA9PSBMVFNTTV9TVEFU
RV9ERVRFQ1RfUVVJRVQpIHx8DQo+ICsJCSgodmFsICYgQVBQTF9ERUJVR19MVFNTTV9TVEFURV9N
QVNLKSA9PSBMVFNTTV9TVEFURV9ERVRFQ1RfQUNUKSB8fA0KPiArCQkoKHZhbCAmIEFQUExfREVC
VUdfTFRTU01fU1RBVEVfTUFTSykgPT0gTFRTU01fU1RBVEVfUFJFX0RFVEVDVF9RVUlFVCkgfHwN
Cj4gKwkJKCh2YWwgJiBBUFBMX0RFQlVHX0xUU1NNX1NUQVRFX01BU0spID09IExUU1NNX1NUQVRF
X0RFVEVDVF9XQUlUKSB8fA0KPiArCQkoKHZhbCAmIEFQUExfREVCVUdfTFRTU01fU1RBVEVfTUFT
SykgPT0gTFRTU01fU1RBVEVfTDJfSURMRSksDQo+ICsJCUxUU1NNX0RFTEFZLCBMVFNTTV9USU1F
T1VUKTsNCj4gKwlpZiAocmV0KQ0KPiArCQlkZXZfZXJyKHBjaWUtPmRldiwgIkxUU1NNIHN0YXRl
OiAweCV4IHRpbWVvdXQ6ICVkXG4iLCB2YWwsIHJldCk7DQo+ICsNCj4gKwkvKg0KPiArCSAqIERl
YXNzZXJ0IExUU1NNIHN0YXRlIHRvIHN0b3AgdGhlIHN0YXRlIHRvZ2dsaW5nIGJldHdlZW4NCj4g
KwkgKiBwb2xsaW5nIGFuZCBkZXRlY3QuDQo+ICsJICovDQo+ICAJdmFsID0gYXBwbF9yZWFkbChw
Y2llLCBBUFBMX0NUUkwpOw0KPiAgCXZhbCAmPSB+QVBQTF9DVFJMX0xUU1NNX0VOOw0KPiAgCWFw
cGxfd3JpdGVsKHBjaWUsIHZhbCwgQVBQTF9DVFJMKTsNCj4gIA0KPiAtCXJldCA9IHJlYWRsX3Bv
bGxfdGltZW91dChwY2llLT5hcHBsX2Jhc2UgKyBBUFBMX0RFQlVHLCB2YWwsDQo+IC0JCQkJICgo
dmFsICYgQVBQTF9ERUJVR19MVFNTTV9TVEFURV9NQVNLKSA+Pg0KPiAtCQkJCSBBUFBMX0RFQlVH
X0xUU1NNX1NUQVRFX1NISUZUKSA9PQ0KPiAtCQkJCSBMVFNTTV9TVEFURV9QUkVfREVURUNULA0K
PiAtCQkJCSAxLCBMVFNTTV9USU1FT1VUKTsNCj4gLQlpZiAocmV0KQ0KPiAtCQlkZXZfZXJyKHBj
aWUtPmRldiwgIkZhaWxlZCB0byBnbyBEZXRlY3Qgc3RhdGU6ICVkXG4iLCByZXQpOw0KPiAtDQo+
ICAJcmVzZXRfY29udHJvbF9hc3NlcnQocGNpZS0+Y29yZV9yc3QpOw0KPiAgDQo+ICAJdGVncmFf
cGNpZV9kaXNhYmxlX3BoeShwY2llKTsNCg0KUmV2aWV3ZWQtYnk6IFZpZHlhIFNhZ2FyIDx2aWR5
YXNAbnZpZGlhLmNvbT4NCg==
