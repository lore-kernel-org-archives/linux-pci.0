Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011015.outbound.protection.outlook.com [52.101.62.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC7221772A;
	Fri, 27 Feb 2026 12:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772195680; cv=fail; b=tbQsZZmjaIUMCT2CCMxVYiVTptr/eU2Q2kfc7XedGV4K49qXq/Sml74CYP2Pv1U6Mj/5Iu/Kru0BfUkywqGHIXpxguDaiX6fymbHYDhxy8rvIT43/9YZoiFhitqCdLFZRN8k+FVC9qWQPwt0E8qLbDquv5qF8fFryD82C/IEvmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772195680; c=relaxed/simple;
	bh=lhW28WxxZikQSx3CT85LFv2SuBVErBZnme7up/owbP8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MI9Yk+n+B710ucEgHuDRVCcNZGl+pwZLQyEa1mtCRJDxE2iFwJj3FfXyP+GFUCgS+Li4prDxqRaxlG0cq0RhnPKeKOMtSQCc1Nzd/a2THXaJhEfpQbYukgwgfvNSwE71ACMOcKHWwbq+u8B9JSd5MJ6iMAP2Uns1aYiwb9KBa0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VxDuqBIZ; arc=fail smtp.client-ip=52.101.62.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VxDuqBIZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZbkXAVFy1teu0EH8HMeRtIq/MKUSbNQx8baIZa4dBMoXlM5drO2tjDTsCeei4O0FhLC1oHS3582TAQd1rSpMwHMqVHwTPb2wx9k+Y3UrZy6VzBV/DB9TbwnV9vkqYPelwp5WfAlggU4N1etxHOpB0SxOM5ozOj/uKXk+laNNJWpu1C4krneYMCXw6+gZ9k78oEQ3uhqc4iTYvw8LflvO9DAUUW+V5SHkEBM6oVdb8KUIUc3Oap2CQQF5Vxd4eFHRRAQpZkE97DWA97h5RjNg0ClZBn3jFI3XddrNHdnqrv5chfF8za7187VB4Eyfiw/S6YA87S8QLUsHnADIFbCMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lhW28WxxZikQSx3CT85LFv2SuBVErBZnme7up/owbP8=;
 b=I76mDVL/cRzCrCMvKUiIGtxgPNCxpWEqFCUPh/ltm2k582jehhm8XiS2pubreW+pXdP0Sw8M8alfgUh5hpApmuXJLHyFCsGvhCB7kmf5HV/XP/b79O2WuW7KS1P/VGSxwMNvkT/UY2LWiCvQr4yIyS0waqpEWmLcBJU7OcGtbNBwzpN8O/jzrxeC5sSllmlydvzhC9JJLymF032BK5hJyDu/KKXwWgRId0LThpnLJ5PsGqDv25/7/tJndGWXR//HGcxZyUh3nMDRxSfnaCNPEh8jU4ubcyEysA5ALmrRtDhhUzVe3HoqzuE4aAwVRrilnmz2Gh5OtJE/Bwj0DTpLPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhW28WxxZikQSx3CT85LFv2SuBVErBZnme7up/owbP8=;
 b=VxDuqBIZ4eBMdGy6iHAKXLr9C5CUYvXLv4cHgts+49O6frMrcRtc9Y+/mofTeiG6gDQpR/sZzhl7MFWwBpEoUUIAtbbnOlkHJQqcVY28BYmWQt1/gABoIubEPSXk2sla27plsu6soW90FQtu0mgwPDDdNuL2cNW0MsHuzmjSyPEu9IZQMGRWMI0fVLMf3JSm0woyhZxoFU+nL33Sj70Xz+/uBSoPIrZM8jcdbBoeBGZ4Qu6iIAoh+HYw4fy9DeT75AQYab0pYFxlvPka7kH8vo6AlGeEY6iD7/yJwVLAzU94Mr9Ffg+4jMaa8c5j7Y6AVoXswd9NlS7EJs50l6r5Dw==
Received: from SN7PR12MB6744.namprd12.prod.outlook.com (2603:10b6:806:26c::13)
 by LV5PR12MB9825.namprd12.prod.outlook.com (2603:10b6:408:2ff::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 12:34:36 +0000
Received: from SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961]) by SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961%3]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 12:34:36 +0000
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
Subject: Re: [PATCH v6 11/13] PCI: tegra194: Use HW version number
Thread-Topic: [PATCH v6 11/13] PCI: tegra194: Use HW version number
Thread-Index: AQHcpPRgSLtqSeh2OU6LvnctuRvKtLWWgPOA
Date: Fri, 27 Feb 2026 12:34:35 +0000
Message-ID: <d6584cb2-3200-43cf-8750-4df1468a00f7@nvidia.com>
References: <20260223184151.3083221-1-mmaddireddy@nvidia.com>
 <20260223184151.3083221-12-mmaddireddy@nvidia.com>
In-Reply-To: <20260223184151.3083221-12-mmaddireddy@nvidia.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB6744:EE_|LV5PR12MB9825:EE_
x-ms-office365-filtering-correlation-id: 3c5dce31-0cf3-4f57-c77a-08de75fc9121
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 h5sbcgCWD6od1BMw6mOEOVC7Tb3NC2J3Z1VyKFaWbOsSXJdd+Qf/knciMPTpuVeRq2rsxiWM3C6KfYc7i0K6BFadrybR3/dMgGEIRQXDbM+xOhl7z4Nan4TlM1Jml9lTcKndh6Ec5YukqPyAbDLsFVY2XVRBHLD6HwZ8kTOUfez3Yk7VGSCtpAa0MzbdZPuKjI04HgxpIz3KDbeYmW4Nb/bMvu4p4EzLeVff56uU+/P2XBhLBB+D4fiCj2B8WSLCCXEnCc46qZ8rNbNkTzpqXSQLUnz8e85UlXAliM1RgFraVPk/k1zSvicoVV2I7pZh4pQKOzwEiK9opfR5q4/6VbNhB/W3sICzqXL92teGZ3Lgjj/ZNta1fGONBWXcfNqLrhFHpTZDr/C6yCnGPjHg5dhHnh3HMNeIIAqrnxR1b2Var6EY0UsSpZL1bcPNY6qKHpB5c/ZH5dnxHS7J4gs57HsGxeGYqnZmeI1ChSODtQcJ4CJQ+HpdhPtPWkdRcKaQcfhCOeo2o4RzP/CHLQzzTPhmvan3qpiNW70a3D0g55MqylnxYIdstH51Ykov/MsUWHIo0WMLdH5djR+k4y6bBNhk+CGdMvmcdkcOsGoBUwwWkPAzsJRSNHymZ203gkqdEQ0guHovxropNSzBAhI3HLi5snq0UpAXlNxuAciAMiLVP1xPXzLGZCco+pvK1N+TyShO5j9xH/pU34HWsJK+2XZqXxJuQ8iofWR1kd85B386n9AvEIL2AzBIV9RaqceLSNqdMPEcKaxLXWv4zKcgE/r4K3fQWVTQaqNeSZ+kF321wFyPwnfdptmUdPQD3OcD
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB6744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z0I4aERDdHZqY0dRdjArc2dqTXJqNHp6V1FJaTQyM3JMR3daZkcxTFNSN1RB?=
 =?utf-8?B?dGNXZGhrdTN1ODV4VngwQmM5VnB6SWUzZVVEZkdrSVJpTXdLLzBRKzg1QS9t?=
 =?utf-8?B?WUJETzNNamxkVXN2clJncHpmVlVMOU9DK01reXIrUTg4UTdHOFhoWGJleGl5?=
 =?utf-8?B?WmRIVUVUMWM1WGtTa1hUaWhpdXFNR3BZc2VLRXhFL0pndWxEOS9kcWZjSU5a?=
 =?utf-8?B?cVlWWndFYzdqbWc2Zm5LYzJBVUVsVXYxZ2puR3Y2b0lxM21lQ1FweDMyR0JD?=
 =?utf-8?B?SzIrQjlCZGoxdEF0SHZWdEJqaVZyTmUrY0NycFNZVnB6STNiQzM4K01FcHBH?=
 =?utf-8?B?QmpqZTZCMTNmeWNyVy92dmk1WWNMbUhBdlBjNWsvb2w3dEVYcEYxYUNzRkZS?=
 =?utf-8?B?N1o4bndZYkNqV3VjV2t0L2NsRUo2SVU1TGJsTFFaYkNmdE5iTzh0R1pIc2hW?=
 =?utf-8?B?Sy82MzRZTHM1V25xcmVsSGFHUFdLcUdjRFZzZFZSUE11QkFUOEVuN1J0d0Ny?=
 =?utf-8?B?c0xocjlLZk8vMUhZN2M3c1E0eVpFa3VEOVpCY0xOMVdiVTlNREgrb3pKMzVt?=
 =?utf-8?B?dHR4SkxnNGQ0TndKN3BZUGRtVEhzOHh3Y28yUllCMEM4enljRllya3pabDl5?=
 =?utf-8?B?cVVKcFRvRVBsNjdGQ2ptelhDU09yKzY2dTdIeXN2OHJ4SHF1MnQ3YzhPRmRZ?=
 =?utf-8?B?ZVFGSEs5TzZrWkFLU0hza2ZwK1JwTk1TZUdOUjBteDBwTGFSeWtoYjJ4UUFV?=
 =?utf-8?B?UXN0ZFQxeWlkU1I4UEp3U2xOTWdjak9RYXR0SGplUGJuczJ6YzhxYlNaS29O?=
 =?utf-8?B?Nll4V3JZNlVGNm1jcGlKWGZDMkxxQ2phaGh5bU9BRktIK1pFeXdmYXdGa0lF?=
 =?utf-8?B?Y0oxSU81R3BnUllSdEswWWNQaXUvTVJBL0QyN1E3Nm1sZHI0SmJIZWdITUhm?=
 =?utf-8?B?cnVIVjluQjFtRUlVZFJnWUJKWi9UQW85andYVmRodk92NlJLWmx4TW51SWhK?=
 =?utf-8?B?ZXZISFNKMlhyYW8rcDZMM25RV3NOMndBU2JtcW1URjZJQnRDUkE3TlpVV05Q?=
 =?utf-8?B?QXdSNGFkd21uQ2RVZUNmRktMdFlsTGJSRTdpbWlrRDd0OHZkdTVSWnErZ0Nv?=
 =?utf-8?B?MEZldjR0bm8ySDdjT0NVTENYLzlUU2RUVmdEcWVtUXVER0k1MndITVFSdXVv?=
 =?utf-8?B?OGlhcmVFUlpFSmFnSkVDZXlYOEd3ZTlTZzdsbXU5VWlwU1NQMFoxSUVSb29O?=
 =?utf-8?B?M05rVHU5MTVsQzlEYjJpY0MrK011RW5qcisvcUtrZEw4WUV0bGNLNzIyYjBW?=
 =?utf-8?B?UXJvRGlVc1dGUXIzcmZtcVhiSlIyaE43NDVLRGdOTXoveEdLckRvWFNnWDNE?=
 =?utf-8?B?K3lVS0Yxc3NFR0VjS3c0N3VIcUdxejA2LzdvTmc1cTNpKzYyQTU5Rnp3aFhU?=
 =?utf-8?B?U3FyRHJrTmFRUVJzVW1xTGtOa2l4SjRYYjEyNkxmT3dtcTdwWXAxeGcxZjlm?=
 =?utf-8?B?bjJuQ2hpYkdTV2lXWWsvYWYxOXdjNXhQTGRrbkJYaHBxZlYvM3V5d2dhMjk0?=
 =?utf-8?B?cFpwQTBhcTRwQS81UzliYUZTZkVPUzdVM2psWGhtK1lhSHJRSHNIODBrelQ0?=
 =?utf-8?B?Q0l3QjJLdEpzelNLck1oTUtLcHNiSVl6VDBlbG82MkdFMVZiVEZ6QjJmYnJu?=
 =?utf-8?B?OTQwWWZPcTNXTWxYR1B2RlRnTmRsMWlTaFN6WEY3U0pPbkdMSlE1ZSs5U3B3?=
 =?utf-8?B?QyszclNjS1BPQzNvOWJHdG5sSko1UEpNZ0VsbHZrelJyN2xnc0paRFFzM3lG?=
 =?utf-8?B?OGlJN04vRGxxcXNzckxQeDlVQnQwbkc1VHJ4czRkbGNUWEM2YjdoMnRFbEVD?=
 =?utf-8?B?SER0a2hqcHp1aFBlQ2t1OWN0UWZWWGs3Wk5xV1cyWnpoSmpIWUlpZXpJOHdR?=
 =?utf-8?B?b29adnZCMy82ZjhUdW5RU01wYTVNVXNHNXpoVU9FRnAySTVxR21xUnpRRzNn?=
 =?utf-8?B?LzBXTFdSWSs4TjRwQndlL1N2WkwxRVlRY3U1TE1YZEovc05xcFlOd3ArUmU3?=
 =?utf-8?B?NnQ2RVJaNHBsQVV5dTNxbzc2OEhlbTNNekpLWkpILzZmV2IyYWd5ZXp2YzJm?=
 =?utf-8?B?QUNwWEZuNTVXdm1ZTFlWNnliREo5WXoxaUk0MnBsZEhqY2g2eDZHYkRhczVu?=
 =?utf-8?B?NUMrZXRDMmM3K29ieTlWaTdSU29BeFdFclNIYjRaRXFzVFFQWUZSZjI3MDlG?=
 =?utf-8?B?UzBtRXJnN0VIY21vTDJqK1Q1KzkrcG9Db1ZaT3N0TmZDYUFsVHoxaFhwWVYx?=
 =?utf-8?B?Zld6QlNFTG84Tk91NWRRV2k2bGliTk5kUnVzM1ZKODZ2Mjl5S0pNZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <105CF6344A732446ADC7AAEB42A23AC5@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5dce31-0cf3-4f57-c77a-08de75fc9121
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 12:34:35.9664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1oq5GVRfC/PNTPadZnBtAsdUbeITFme+04s1P0zaF6NvjOE2SBckjCVv0YBWq/sBKTmGfkL5piKdRBC93GnQ2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9825

T24gMjQvMDIvMjYgMDA6MTEsIE1hbmlrYW50YSBNYWRkaXJlZGR5IHdyb3RlOg0KPiBUZWdyYTE5
NCBQQ0llIGRyaXZlciB1c2VzIGN1c3RvbSB2ZXJzaW9uIG51bWJlciB0byBkZXRlY3QgVGVncmEx
OTQgYW5kDQo+IFRlZ3JhMjM0IElQcy4gV2l0aCB2ZXJzaW9uIGRldGVjdCBsb2dpYyBhZGRlZCwg
dmVyc2lvbiBjaGVjayByZXN1bHRzDQo+IGluIG1pc21hdGNoIHdhcm5pbmdzLg0KPiANCj4gVXNl
IEhXIHZlcnNpb24gbnVtYmVycyBpbiBUZWdyYTE5NCBkcml2ZXIgdG8gYXZvaWQgdGhpcyBrZXJu
ZWwgd2FybmluZ3MuDQo+IA0KPiBGaXhlZCB2ZXJzaW9uIGNoZWNrIHRvIGVuYWJsZSBlY3JjIGZv
ciBUZWdyYTE5NC4NCj4gRXhpc3RpbmcgNDkwQSBjaGVjayBpcyBsZWZ0IGludGFjdCBpbiBjYXNl
IGFueSBIVyByZWx5aW5nIG9uIGV4aXN0aW5nIGNoZWNrLg0KPiANCj4gRml4ZXM6IGE1NGUxOTA3
MzcxOCAoIlBDSTogdGVncmExOTQ6IEFkZCBUZWdyYTIzNCBQQ0llIHN1cHBvcnQiKQ0KPiBTaWdu
ZWQtb2ZmLWJ5OiBNYW5pa2FudGEgTWFkZGlyZWRkeSA8bW1hZGRpcmVkZHlAbnZpZGlhLmNvbT4N
Cj4gLS0tDQo+IENoYW5nZXMgVjEgLT4gVjY6IE5vbmUNCj4gDQo+ICBkcml2ZXJzL3BjaS9jb250
cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuYyB8IDIgKy0NCj4gIGRyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5oIHwgMiArKw0KPiAgZHJpdmVycy9wY2kvY29udHJv
bGxlci9kd2MvcGNpZS10ZWdyYTE5NC5jICAgfCA0ICsrLS0NCj4gIDMgZmlsZXMgY2hhbmdlZCwg
NSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5jIGIvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmMNCj4gaW5kZXggMzQ1MzY1ZWE5N2M3Li4wZGFj
NWQyZjVhODMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUt
ZGVzaWdud2FyZS5jDQo+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVz
aWdud2FyZS5jDQo+IEBAIC01NTksNyArNTU5LDcgQEAgaW50IGR3X3BjaWVfcHJvZ19vdXRib3Vu
ZF9hdHUoc3RydWN0IGR3X3BjaWUgKnBjaSwNCj4gIAlpZiAodXBwZXJfMzJfYml0cyhsaW1pdF9h
ZGRyKSA+IHVwcGVyXzMyX2JpdHMocGFyZW50X2J1c19hZGRyKSAmJg0KPiAgCSAgICBkd19wY2ll
X3Zlcl9pc19nZShwY2ksIDQ2MEEpKQ0KPiAgCQl2YWwgfD0gUENJRV9BVFVfSU5DUkVBU0VfUkVH
SU9OX1NJWkU7DQo+IC0JaWYgKGR3X3BjaWVfdmVyX2lzKHBjaSwgNDkwQSkpDQo+ICsJaWYgKGR3
X3BjaWVfdmVyX2lzKHBjaSwgNDkwQSkgfHwgZHdfcGNpZV92ZXJfaXMocGNpLCA1MDBBKSkNCj4g
IAkJdmFsID0gZHdfcGNpZV9lbmFibGVfZWNyYyh2YWwpOw0KPiAgCWR3X3BjaWVfd3JpdGVsX2F0
dV9vYihwY2ksIGF0dS0+aW5kZXgsIFBDSUVfQVRVX1JFR0lPTl9DVFJMMSwgdmFsKTsNCj4gIA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJl
LmggYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuaA0KPiBpbmRl
eCBmNGNmMTYwMmNjOTkuLjViY2VhZGJkMmM5ZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmgNCj4gKysrIGIvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmgNCj4gQEAgLTM0LDggKzM0LDEwIEBADQo+ICAj
ZGVmaW5lIERXX1BDSUVfVkVSXzQ3MEEJCTB4MzQzNzMwMmENCj4gICNkZWZpbmUgRFdfUENJRV9W
RVJfNDgwQQkJMHgzNDM4MzAyYQ0KPiAgI2RlZmluZSBEV19QQ0lFX1ZFUl80OTBBCQkweDM0Mzkz
MDJhDQo+ICsjZGVmaW5lIERXX1BDSUVfVkVSXzUwMEEJCTB4MzUzMDMwMmENCj4gICNkZWZpbmUg
RFdfUENJRV9WRVJfNTIwQQkJMHgzNTMyMzAyYQ0KPiAgI2RlZmluZSBEV19QQ0lFX1ZFUl81NDBB
CQkweDM1MzQzMDJhDQo+ICsjZGVmaW5lIERXX1BDSUVfVkVSXzU2MkEJCTB4MzUzNjMyMmENCj4g
IA0KPiAgI2RlZmluZSBfX2R3X3BjaWVfdmVyX2NtcChfcGNpLCBfdmVyLCBfb3ApIFwNCj4gIAko
KF9wY2kpLT52ZXJzaW9uIF9vcCBEV19QQ0lFX1ZFUl8gIyMgX3ZlcikNCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtdGVncmExOTQuYyBiL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvZHdjL3BjaWUtdGVncmExOTQuYw0KPiBpbmRleCBkMjI1MTY1YTNhYTIuLmYx
MDdmMmViOThmZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNp
ZS10ZWdyYTE5NC5jDQo+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtdGVn
cmExOTQuYw0KPiBAQCAtMzUsOCArMzUsOCBAQA0KPiAgI2luY2x1ZGUgPHNvYy90ZWdyYS9icG1w
LWFiaS5oPg0KPiAgI2luY2x1ZGUgIi4uLy4uL3BjaS5oIg0KPiAgDQo+IC0jZGVmaW5lIFRFR1JB
MTk0X0RXQ19JUF9WRVIJCQkweDQ5MEENCj4gLSNkZWZpbmUgVEVHUkEyMzRfRFdDX0lQX1ZFUgkJ
CTB4NTYyQQ0KPiArI2RlZmluZSBURUdSQTE5NF9EV0NfSVBfVkVSCQkJRFdfUENJRV9WRVJfNTAw
QQ0KPiArI2RlZmluZSBURUdSQTIzNF9EV0NfSVBfVkVSCQkJRFdfUENJRV9WRVJfNTYyQQ0KPiAg
DQo+ICAjZGVmaW5lIEFQUExfUElOTVVYCQkJCTB4MA0KPiAgI2RlZmluZSBBUFBMX1BJTk1VWF9Q
RVhfUlNUCQkJQklUKDApDQoNClJldmlld2VkLWJ5OiBWaWR5YSBTYWdhciA8dmlkeWFzQG52aWRp
YS5jb20+DQo=
