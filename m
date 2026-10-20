Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792502335;
	b=QzwuM3TgcWyBQNnrqnt1nC0EncmFHHK0o6EnEygvkKi+xv1sZfsHDMUynh1Zb6YBqrqE
	 rUatjbCgm2hS7YYTJ3Os/5PHcqum4Zb89h44v2msidgK/VBSY6GRmfzKdOskwIufYcXKL
	 oC+38SwhXQXl0tmEfRBk2D6yV2Mx7iGHFqZld0ASi3c/SWTr1mO+rP4CDkqOpD0gwWvuF
	 GnCBNsb5nP7DXKWqi5RSwWPeNPFc9TbcXIhW15mqQubJuYq2TyGxH2KhHp2rf5knM3f16
	 znR5VhAedOlzYAJnsom+9mI+1OXBsUSeN4Vmo7MgVV5spUXShNgoC5C4Pf4aUztPm2Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502335;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=4r9zugj67HF1IKNz/zjJLTqU3rl2J/u14CcAQ2yyuzg=;
	b=c7vmY7Ub6RPQatn7t2+lt8D9kuvwRHUUTKEhWq2mauwUR32uOKTN9d90rFwlQv3+4GDi
	 rtFb1aIR8iDHTuU2VUer5rIdDSXhMTlcQyyoKFWTe+32EjeVxWk1yjVSGBNdu9E+1NGrf
	 intYz0eljjc7CZA5ATItmYIJDBBgKD/wgXiART6OvWXEz+jfA+6COldwWJCCaR5dsnoAe
	 5MCyUpL3wWzeEZPfp4TPuigTE7DepkEP7R/MQZmUYBfGluM5BS7/NmEe+ChzwnLX4urzr
	 xPAp8d3bmqBrGQCsEMdIPnEggItrIaNZJz5hZ/q2jQA99rV2bS8YXd96ghmmbsjcELw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=nCRaAGg9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.12
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012012.outbound.protection.outlook.com [52.101.43.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABB9606A322;
	Tue, 20 Oct 2026 13:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0ABB9606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=nCRaAGg9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ati+nVQ3S+AciwzQ+4niCbC9kbmzRPr3qojSNz/u4iLinoLgYyfdzplw0X3xWKaWx/bM3C3Rh/lAAOZDzxOGGE/Flq1dPb1QhDojaa2xMKUoMGUXBOcLforDIZFe7dJI44pzqA/GD++lpU+OaPTNV46ufoxGF0nRNjHOmxj0ZHY4NiL2QPMyJZ16F2en16KxDERErIU8ryH1roynwiHSwcxzSMcTUNko71mzPSVT6Ti9a09jdyJCGZlru76t+ILhKZef5Iafcr7ZcV2Hf+InltIoVLGd97A/Cfs3A8Vndt1X+GZ/LYLxnmlkMJvZpHJhTjw8GQU6IxOAHsTk5LMhNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4r9zugj67HF1IKNz/zjJLTqU3rl2J/u14CcAQ2yyuzg=;
 b=zPOGjxsgvNCSsL0A2dWRqsrrHhhJK0/oEff1rL8VTUp6Udq3vGFkqmnrIbI9NkOlyx+IuUDs+OiRAgLMDav2On+QysKWa2To+I5zIYRHtMshL/5QuWXAj06Mjgtl+QdtFVH9sMUz4/H/y9Ty7hQHGijlZmCdGCNjSP+SFX17dXzkB7qLRL5WSpQPBFfPMBQNb9LQ40I4AM6ScD7fb1+D2ZmrEIRYRUMpvTrhLllgwulM8x5G/xAysUfu9RU8TJUPSRfFN30KzKee0HROoniv3Ehtam8OTAX3K8q3YgFl5FbBOxk70tYkFn53r61Nunz4j8RvTiqxSIUkRWzki6wx6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4r9zugj67HF1IKNz/zjJLTqU3rl2J/u14CcAQ2yyuzg=;
 b=nCRaAGg9bOoZESIzHzdjwBS9QWnAkI9+7r39+DeTct2gpbkgOtSmrVPzgAf/PpVdeojkATu+GUgq9NPu3G+bJv8eYIjetFIn7Ualls1iXF+SletnEquYpccWj7jm/0k73i0LJfLZ75GeC41wuA1dGwdf7MHJj9dZXUg4DpbQUIY=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by DM4PR12MB5820.namprd12.prod.outlook.com (2603:10b6:8:64::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15; Tue, 20 Oct 2026 13:18:47 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%7]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 13:18:47 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>, Bjorn Helgaas
	<helgaas@kernel.org>
CC: Oz Tiram <oz@shift-computing.de>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, Reza Nikzad Chaleshori
	<rezanikzadch@gmail.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Match VFCT using initial PCI bus number
Thread-Topic: [PATCH 2/2] drm/amdgpu: Match VFCT using initial PCI bus number
Thread-Index: AQHdYDSWrcg9yNK07EyD4mGcI4SJbrcGalNQ
Date: Tue, 20 Oct 2026 13:18:47 +0000
Message-ID:
 <BN9PR12MB514670CFFB9AAA7C2E6109C9F7672@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <20261019-vfct-regression-v1-0-5a63ddd378dd@amd.com>
 <20261019-vfct-regression-v1-2-5a63ddd378dd@amd.com>
In-Reply-To: <20261019-vfct-regression-v1-2-5a63ddd378dd@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-10-20T13:17:41.0000000Z;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD
 Public
 v26;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|DM4PR12MB5820:EE_
x-ms-office365-filtering-correlation-id: 9373790a-49e2-4f8f-bb3a-08df2eacacc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|10067099003|18002099003|22082099003|11063799006|4143699003|261009223027099003|38070700021|56012099006;
x-microsoft-antispam-message-info:
 yjaNR002VxTIHyVJsaZOUj2cWdq4aBkYY+EhxjqSmm++tZXCdo3Wh1GDlbfiMY3VQGM35d79l1Da7V/t1ZKXMlPBYPfBcqQ32tHgPDW0hM2rC7lNn42YWIjyemX2njfKSvizrpY0/JSR7Ifvtq1bNnI27I+SDpUKjJIr8fMrwdN49lqdowCMziYOW1n2og7/wTaYh0ABmEG47im9+QnYFR00oyaHD7dhpilOiW81DlkaTJUmOtatwZZZMLevavX3TWJToImxGicnI8QwDD5QI4IXhmRJT7qPB13cjQsqGqD8QgETFjV/6+k15S08yAMpgsLVNe9QXIoIcb5jTxpjaRCBxsyj2ihTFZuRyVozg6mKoBmeDVp07MOCosDfHO3a801pR0GMYqayTuPi2CRSpgaDhSa/tCfDKSK9gNEwq4bSusZBCdTESqdyPQDt7C082TmbkkCBvkciWABp8w/iIAeASDAWyItIrRRIQp7lIDuqrZjwRjFVPJEq84WHHbHo+Mk49KO3IOctcfy6Lpvgh/AVKLWPcwKF2XOtBXnCzMsFsO6KTZDs1tuZVEdjyOOYN/zHqwjMA7cvyTPmLV7RE0khQM4s4D89ulkLLtZIHmPrmumhy3GS9PC45guO06jOP2VPZt9+qrgtd+XxpV4bWaWhhW123A22PNVfuoJkCwQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5146.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003)(261009223027099003)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YUxIN0RSWm0zcUk3V2RsZG5qRTFDOEdncGFJZCtTNVZ4eE1vNUZIZjVESDV6?=
 =?utf-8?B?ckUyOVpEdC9FQmlReGhLeVh0bWREelZ4Wkp4TmJnb1ZndUxNaWNaUU50UjJ0?=
 =?utf-8?B?dWp6SzhOV1FJbncvYTkvazR2YnVMK1RZeEJUSURoSWp5REFiSk0xMmRtcTVt?=
 =?utf-8?B?UXVKbFg3eE9pNTZtS3hxTnF3TW1pLzNpU24wN29kV0xuYUI4eW8yd2pZTVV1?=
 =?utf-8?B?VkxubzVzbVcyUE9xMmdMZ1F0bWU5MTh4UXFXQ2ZOYS91VGVwVEIvLzBqMmN6?=
 =?utf-8?B?THM5RjJsTjdZa2N5K3EzSFpBVWZaYll4aEhVYTVCa29Wa3ZjeDRnZXBYWHk1?=
 =?utf-8?B?cVZzVGVjUGNMemNKTm1EemtLS1RIUVFIUkpieU5QcDVLMU1mZkxsYXBWRDBn?=
 =?utf-8?B?R1BHZFlBSHdiSDlScU91YmZwQlJYQyttaFJBSjRtTUc1YzNKNTlsMVBpVTJI?=
 =?utf-8?B?eUNEejcrRVRWZk1kaW00M2hoRllNbzNBWG5ZbUp0d0pyR0tVTjdrTWtSZmJ1?=
 =?utf-8?B?RGhtbjY5eXp3U3pOZ3hmVjVoeEYzMVAydXoya004Snl0dDNmTTRaazVXZ3N0?=
 =?utf-8?B?Q2ltWVl5L09DUnppMDVGa0QxWGU2dWorcW5VK3hLS0ZROElobHI2TFNlZzR1?=
 =?utf-8?B?WlphQkUxM1ovQStPUmcxRGQrWVJZVDhEUDNONDJoOEJ4bGw2Wk9DdkVXQkxv?=
 =?utf-8?B?a0ladUErdjRQMDgrbGxQU2MwenNJcTBZemZrK2dwTm1URkV4Z3FGSytEcCti?=
 =?utf-8?B?M3U3cXRlRitDR3QrL2toVy83ajNpVU1STDJBVUNQSTFwT0NDVzJEREN2WlBO?=
 =?utf-8?B?eHZUM0x5SzlkUy8yWHVCdHUvWEhRYjBPemhjekRPdEVTa2FRVjRtclhIK1VK?=
 =?utf-8?B?OUZ2aFhNbTNNRm5rcUpVUFF4UmFhWHZTVEQzY0ErT2tqNXhMa3BVL3NIVDEx?=
 =?utf-8?B?WHJQc2hUWnJkK2VOZ0FKOVVTSXNiSDlwenJ0ekRGdTRTdzIxVXNFUkl6Y2tL?=
 =?utf-8?B?SVpkNnVvd0xhQjYwVUNRcCtjZ3pqY0FVZks0bVlBWVkxeUU5TUhPeTlzeDVh?=
 =?utf-8?B?aXJJVzU4eU1qKzJuSFlnUlUxdUVFZjVPZXFFdzlHdjJ0SEVnV0xmTnI1THhs?=
 =?utf-8?B?UVJYSUE2V3lSMmw5SGZBMCs2WlNFWVF1LzdYczkyUEtIUjNOZmw2cm1nQnND?=
 =?utf-8?B?eW5NN2NOM1BSOW5zNFJ3S2pWZjdsbWZGWm92Z1o4bzZYOUUvay9EVTY4MHhC?=
 =?utf-8?B?Zzdmd0hOZXUya0tuenVaNjZ3VGdncWk4bE85ZS9Xdkc4MzU3eUl6bXR5V0RD?=
 =?utf-8?B?T05TQnhHdUdLSnN6aGNKb0dkeFhoTmNORWJwUG9LREt0ejVtWko3YTlhNkRt?=
 =?utf-8?B?OTdhMi96V25DQVBhYjNFU1hkNWNTODM0YkFGZ1hzcHFSb1o1QUFtaHhCMjNK?=
 =?utf-8?B?bzVnTmpQMzNEZmt2RjNqRjZUNnlHMENXZFpjVW9vcnQxcTM2RmZ6MmdacVYz?=
 =?utf-8?B?Y0Vlc2w1eDlaWnNHT05DL3YyVXRob0NnZXY2aHNWK3dBUUUyNHE4OE1GMU04?=
 =?utf-8?B?YWpYbjE0SFhUYmVXUlROVWJha3g3Mm9lRmxNOVJZWG1raW1aWWNjdU1EMnZ5?=
 =?utf-8?B?QytQZjJISWw4ZXhMaXArTEhPY0VNWWlDaGJDeG5EUWp4aGxZSFc0UzNqdWM3?=
 =?utf-8?B?K1Q2dk83bE5wTUZjMnhOVVQ2Z3hXQkROTmlKUXJNZ3djb2tTa1pIWnpsbGN3?=
 =?utf-8?B?cGlPb3IzNFZUMHdlaUs4RGR4WnIzRnVoV2hsTm1OdkxxZElZenhEUkU1OVF5?=
 =?utf-8?B?WjBoU2tLSkpkeHZ2MXgwRlhiUk5mV1ZVWUNmWlVTQ2x0dGJlSGNkZTZKRXMx?=
 =?utf-8?B?eDdoL1RzUWhZR1Y4Ly9mUnJybHlLSzdhY1BXUTk3SE8yZmxZeW1jcnJ2d2Zp?=
 =?utf-8?B?WFR1QllWMHVaYzBlWmdjUThQdVVhbDNMUjk5OENNK2MrcFBBWFJmelY0ZWRz?=
 =?utf-8?B?TUt6dURiOVZNNXdvMVpuWFdEODh3d1kwTkVYM25ZSzc4bDZVbGdwVVl6L3p5?=
 =?utf-8?B?SnFUQlFmVDV0cGR2RnlkalI0dmd3UjFVVlowcHZjbHU3MDZrREV6RWhta1hV?=
 =?utf-8?B?anFOMW45L2JubzZTSUNEN0tjL0piZXV3ZUZBVGR5TG5yam54TGRaMDVObkoz?=
 =?utf-8?B?U0VZcXVGdE1QTDViaFFFYXJnWHNSd2hLR1hqeTVPejdxVlNxa1FCVTNhNXZ6?=
 =?utf-8?B?aXRoK21jQk0vcGdWRXhTaUVyajNQbmN4QXZGZjdFNGplRm8raFI4amZXRFZw?=
 =?utf-8?Q?2sv7R+1fbG0j+hLftN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9373790a-49e2-4f8f-bb3a-08df2eacacc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2026 13:18:47.7746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jTemZ9eSIw7pP78cHQcENWQttfxqGCqtBn08UAGM7+/R4Idvig+p+fBUfXEEOxrkbVtVid57aMG+V/QNoU20Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5820

UHVibGljDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGltb25jaWVs
bG8sIE1hcmlvIDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPg0KPiBTZW50OiBNb25kYXksIE9j
dG9iZXIgMTksIDIwMjYgOTo0NSBQTQ0KPiBUbzogQmpvcm4gSGVsZ2FhcyA8aGVsZ2Fhc0BrZXJu
ZWwub3JnPjsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29t
Pg0KPiBDYzogT3ogVGlyYW0gPG96QHNoaWZ0LWNvbXB1dGluZy5kZT47IGxpbnV4LXBjaUB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZzsgZHJpLQ0KPiBkZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7
IExpbW9uY2llbGxvLCBNYXJpbw0KPiA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT47IFJlemEg
TmlremFkIENoYWxlc2hvcmkNCj4gPHJlemFuaWt6YWRjaEBnbWFpbC5jb20+DQo+IFN1YmplY3Q6
IFtQQVRDSCAyLzJdIGRybS9hbWRncHU6IE1hdGNoIFZGQ1QgdXNpbmcgaW5pdGlhbCBQQ0kgYnVz
IG51bWJlcg0KPg0KPiBWRkNUIHJlY29yZHMgdGhlIFBDSSBidXMgbnVtYmVyIGZyb20gQklPUyBQ
T1NULiBUaGUgY3VycmVudCBidXMgbnVtYmVyDQo+IGNhbiBjaGFuZ2UgYWZ0ZXIgUENJIGNvcmUg
cmVudW1iZXJzIHRoZSBidXMsIHdoaWxlIGFjY2VwdGluZyBhIG1pc21hdGNoDQo+IGJhc2VkIG9u
bHkgb24gZGV2aWNlIGlkZW50aXR5IGNhbiBzZWxlY3QgdGhlIHdyb25nIFZGQ1QgaW1hZ2Ugd2hl
biBtYXRjaGluZw0KPiBkZXZpY2VzIGFyZSBwcmVzZW50LiBDb21wYXJlIGFnYWluc3QgdGhlIGJ1
cyBudW1iZXIgY2FwdHVyZWQgd2hlbiB0aGUgUENJDQo+IGRldmljZSB3YXMgZGlzY292ZXJlZC4N
Cj4NCj4gUmVwb3J0ZWQtYnk6IFJlemEgTmlremFkIENoYWxlc2hvcmkgPHJlemFuaWt6YWRjaEBn
bWFpbC5jb20+DQo+IENsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYW1kLWdmeC8yMDI2
MTAxNDA4MDUyMy4xODY1MzMtMS0NCj4gcmV6YW5pa3phZGNoQGdtYWlsLmNvbS8NCj4gRml4ZXM6
IDExYzE0MTY3MjA0NWYgKCJkcm0vYW1kZ3B1OiBGaXggVkZDVCBidXMgbnVtYmVyIG1hdGNoaW5n
IHdpdGgNCj4gc29mdCBmaWx0ZXIiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJpbyBMaW1vbmNpZWxs
byA8bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4NCg0KUmFkZW9uIG5lZWRzIGEgc2ltaWxhciBm
aXguDQoNCkFsZXgNCg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9iaW9zLmMgfCAxNyArKystLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5z
ZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYmlvcy5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2Jpb3MuYw0KPiBpbmRleCAwOGVkMWViNjk1NTg2Li4yYjM3NWU2YjM5ZDVm
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYmlvcy5j
DQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9iaW9zLmMNCj4gQEAg
LTM4NiwxMCArMzg2LDggQEAgc3RhdGljIGJvb2wgYW1kZ3B1X3JlYWRfZGlzYWJsZWRfYmlvcyhz
dHJ1Y3QNCj4gYW1kZ3B1X2RldmljZSAqYWRldikNCj4gICAqIFZGQ1QgZW50cmllcyBjb250YWlu
IHRoZSBQQ0kgYnVzIG51bWJlciBhcyByZWNvcmRlZCBkdXJpbmcgQklPUyBQT1NULg0KPiAgICog
T24gc3lzdGVtcyB3aGVyZSB0aGUga2VybmVsIHJlbnVtYmVycyBQQ0kgYnVzZXMgKGUuZy4gcGNp
PXJlYWxsb2Mgb3INCj4gICAqIHJlc291cmNlIGNvbmZsaWN0cyksIHRoZSBydW50aW1lIGJ1cyBu
dW1iZXIgbWF5IGRpZmZlciBmcm9tIHRoZSBQT1NUDQo+IC0gKiB2YWx1ZS4gIE1hdGNoIGJ5IGRl
dmljZSBpZGVudGl0eSAodmVuZG9yICsgZGV2aWNlICsgZnVuY3Rpb24pIGFuZCB1c2UNCj4gLSAq
IHRoZSBidXMgbnVtYmVyIGFzIGEgcHJlZmVyZW5jZTogZXhhY3QgYnVzIG1hdGNoIGlzIHByZWZl
cnJlZCwgYnV0IHdoZW4NCj4gLSAqIHRoZSBidXMgbnVtYmVycyBkaXNhZ3JlZSB3ZSBhY2NlcHQg
dGhlIGVudHJ5IGlmIHRoZSBkZXZpY2UgaWRlbnRpdHkNCj4gLSAqIG1hdGNoZXMuDQo+ICsgKiB2
YWx1ZS4gIE1hdGNoIHVzaW5nIHRoZSBidXMgbnVtYmVyIGNhcHR1cmVkIHdoZW4gdGhlIGRldmlj
ZSB3YXMNCj4gKyAqIGRpc2NvdmVyZWQsIGJlZm9yZSBhbnkgYnVzIHJlbnVtYmVyaW5nLg0KPiAg
ICoNCj4gICAqIFJldHVybnM6IDAgb24gbWF0Y2gsIC1FTk9ERVYgb24gbm8gbWF0Y2gNCj4gICAq
Lw0KPiBAQCAtNDA1LDE2ICs0MDMsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9hY3BpX3ZmY3RfbWF0
Y2goc3RydWN0DQo+IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ICAgICAgICAgICB2aGRyLT5QQ0lG
dW5jdGlvbiAhPSBQQ0lfRlVOQyhhZGV2LT5wZGV2LT5kZXZmbikpDQo+ICAgICAgICAgICAgICAg
cmV0dXJuIC1FTk9ERVY7DQo+DQo+IC0gICAgIC8qIEV4YWN0IGJ1cyBudW1iZXIgbWF0Y2ggLSBw
cmVmZXJyZWQgKi8NCj4gLSAgICAgaWYgKHZoZHItPlBDSUJ1cyA9PSBhZGV2LT5wZGV2LT5idXMt
Pm51bWJlcikNCj4gLSAgICAgICAgICAgICByZXR1cm4gMDsNCj4gLQ0KPiAtICAgICAvKiBCdXMg
bWlzbWF0Y2ggYnV0IGRldmljZSBpZGVudGl0eSBtYXRjaGVzIChQQ0kgcmVudW1iZXJpbmcgY2Fz
ZSkNCj4gKi8NCj4gLSAgICAgZGV2X25vdGljZShhZGV2LT5kZXYsDQo+IC0gICAgICAgICAgICAg
ICAgIlZGQ1QgYnVzIG51bWJlciBtaXNtYXRjaDogdGFibGUgJXUgIT0gcnVudGltZSAldSwNCj4g
bWF0Y2hpbmcgYnkgZGV2aWNlIGlkZW50aXR5ICh2ZW5kb3IgMHglMDR4IGRldmljZSAweCUwNHgp
XG4iLA0KPiAtICAgICAgICAgICAgICAgIHZoZHItPlBDSUJ1cywgYWRldi0+cGRldi0+YnVzLT5u
dW1iZXIsDQo+IC0gICAgICAgICAgICAgICAgYWRldi0+cGRldi0+dmVuZG9yLCBhZGV2LT5wZGV2
LT5kZXZpY2UpOw0KPiAtICAgICByZXR1cm4gMDsNCj4gKyAgICAgcmV0dXJuIHZoZHItPlBDSUJ1
cyA9PSBhZGV2LT5wZGV2LT5pbml0aWFsX2J1c19udW1iZXIgPyAwIDogLQ0KPiBFTk9ERVY7DQo+
ICB9DQo+DQo+ICBzdGF0aWMgYm9vbCBhbWRncHVfYWNwaV92ZmN0X2Jpb3Moc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYpDQo+DQo+IC0tDQo+IDIuNDMuMA0KDQo=
