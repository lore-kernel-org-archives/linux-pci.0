Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795867814;
	b=p5XxwwpG3utE+YcVDg940BpnCFZm6w3eE6HJWBvFjFK7Lbs4Ymz/XrHLMOkbT5SDylh0
	 cksNi1U440KUK+QyImGs9L2JPMdH7cMdesgXpwie3vB230QezbZDZr9tNDchzifKnUx4q
	 aAEEPNXmFSMLgLdhBiaLibmVxABIcM6HU93VRt8Tb3yCA4UKElzG4vTD/IEX46RiF2CTz
	 i8KXdrcZ9O+1oR5+i4dbxfKm66jzUlvQ51atNaUY64t/xVA4e8cNdqlsQsg0I2IZTo9Gq
	 6ataCmJdLJY2cA0/HNV794yaC1un274nKGPCBQBxt1tA0+fU2gsEohbFd2nE9HZxuKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795867814;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-CrossTenant-rms-persistedconsumerorg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=kqCe8r23suhC0EUKKzc8n3gqFLcsbOmf3njgJKWpY2Q=;
	b=mPRCKCQQSwPhmM/4r1DtoPPcPDomzTcrugh4WMYJCjF2MDjX+8bQ0KYJkJ4IcZtTseZQ
	 0D9KrPMnmcp0ypNwsTczj8/02gc96iQgciSg0dea3e/xgk62xBvNwqUVGmkxFUukVMZnx
	 vrsngr6P80zX8WQes3qKYQuRmmm4z739qNVxb25a0mp1MBAZiiau0QBgPPVh10DZs5Nfc
	 5s5XpyqKQIAlymtWTthnvIFoiYdvQbwTXiRZia15SUcj7T9dm71ahTdqZHHqDYLuIrApN
	 bt/JAcRYIqbo1DkzhSwHrchLfIRYtXtgOGmShNHpxyts3lnDwOZIFgydPTLz3DgCxSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=cBwWlH9p;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.25
Received: from WA1P291CU003.outbound.protection.outlook.com (mail-polandcentralazolkn19011025.outbound.protection.outlook.com [52.103.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C5F606A31C;
	Sat, 28 Nov 2026 12:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75C5F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=cBwWlH9p
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jMVnckEIEcHpspSOx/TbWSECxSD/8sg6Ujicj3JoIluMKLkfE/Ui6Rw0mbQHJYcu5oe4NltVVaqQdGas147cks49gY/siIoc0xD0U+SPlqHKD9iOc9m6aaXkzAHAMHgIQYH0a5W0xOR+iiJht1C/HKCjxfx3/QX/8jl8c5rIObefZZ+onPhi8ZdE1vl+YYnw/KkZqsmNZw2jA9wMzAlwzZR0cZvR3bs+sMnrokvImEVJ/AS0EUeajZGzfvFgNu79k+A4mcHq1l4WnjsahcWezTvH2JHvsAp8FU2wfgKGzz82SDKaRv+Xc0DWU3M7B5ix3RfDappIFIQu7XaqMxIafg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqCe8r23suhC0EUKKzc8n3gqFLcsbOmf3njgJKWpY2Q=;
 b=ns5vPc8GQpjY+CloaxC6OP5eO+7WU+X8lMd3S1XZDTOUnCH8q1FBdyQNJmzAQ6qXmsfHbtqby9qNRG6amk1kcWUx2IeFJZJIr7yLrsgjQk/ik6tLT4XcFF3+ZJi3yHpkGKfm5Q2LMU83XLWUb4nDIFKpL3aLq02GXlKu0VyoNjsvlV2ap8SY3O8zlKZa0nN0MFEgNYMc5kITFd4z2MKMXKXWl8C8coqOcSV04u3IEIS0tvnW7PFVHX5nmDndOWJNj7sAXzpi/7lYAu6rYbNF4K4dAx8gTLADi3tquHqBOzPRN+h8tdtBg7mK6V7Cj4tJSDY19iqt6Pvgu7M5jk+7NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqCe8r23suhC0EUKKzc8n3gqFLcsbOmf3njgJKWpY2Q=;
 b=cBwWlH9pJZzux6UjUNkhbGPzWziTV5v+cmRQICDKBUxZxbWO80gcWVxV/dgTwcm6KmXj+cupBBH9/VN6IXnZkj8BuOGAMcrptWAcR3MiywGjrmSpDHyvy4OmprZCrp97vynjLKl6PVqHDGfRCXMUbuNPDpIpJVLtdZT7XDdKY/EuVrke0z6Y9XUJsmkOj71BQCyt8l86z09EP11sNFL7IR0GfzqYUySCP2Ua3c5wmD4X6gtIBaGU+dQ0ecpTPABtW+dVpOPuLOX3ftrbB/E1SDxig4RuwyrV5jAVaQaPyVaIBDd6gG8XVWhK1aXxhECeQFECnNlVzkSauuu4Ab5EXQ==
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:26::11)
 by WA0P291MB0174.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.6; Sat, 28 Nov 2026 12:10:10 +0000
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404]) by WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404%6]) with mapi id 15.21.0662.007; Sat, 28 Nov 2026
 12:10:10 +0000
From: =?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?= <habilerenturker@hotmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>, Thomas
 Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?= <habilerenturker@hotmail.com>
Subject: [PATCH v5 0/4] PCI: Add pci_power_t helper functions
Thread-Topic: [PATCH v5 0/4] PCI: Add pci_power_t helper functions
Thread-Index: AQHdfzFqAnbh5w9njECEgxMEONpOBA==
Date: Sat, 28 Nov 2026 12:10:10 +0000
Message-ID: <20261128120858.8737-3-habilerenturker@hotmail.com>
Accept-Language: tr-TR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: WA2P291MB0187:EE_|WA0P291MB0174:EE_
x-ms-office365-filtering-correlation-id: 932265e0-9349-4b77-2579-08df4d488cb5
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|25010399006|55001999006|8062599012|8060799015|38102599003|19110799012|31061999003|24021099003|41001999006|5062599005|15080799012|1602099012|10035399007|40105399003|102099032|4302099013|3412199025|440099028|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?cTBvWE5reWRSSlBLTjRMbHR2VGFGYnViUVN6aXFKQm5LRlhiNTZpYVUydWFP?=
 =?utf-8?B?NmNEQThJNHBKRWpXMGs4Nk1uUWpQc25weFpQREdsMkh6YU1KUnIrYmlKNDdI?=
 =?utf-8?B?TjN2S2xIRVhNcjRVZEg0UlUyd2ZzR1A1ZWxRSWNUOUdUVEcvenFoa3JBVU1a?=
 =?utf-8?B?bWQwS1Q0OU5ONVQ5TGtvUHhKRm41V1V0cTE3eVZ5SmpaeTJVSnV0ZmhIUUFL?=
 =?utf-8?B?cTNCY2ZxWGE0RGU1Mk9hWHROMkxOYkJCY0JwV0ZOMThqWERvaGRaV01HZHFC?=
 =?utf-8?B?TmpPK0pTVDd5U04xYk1WSnVBQXJHUEthSXcvYjRjajNhU3ZoeHI3OHR5NDB5?=
 =?utf-8?B?Tm5lVnlkd0ZSSDZLY0c2M0VXU2xyL0NiSG1NZi9nS3pSWDIvZithUUZsNjND?=
 =?utf-8?B?TiswRjRyT2RhUW1kOFF2V1NhbDAyNC8veGhYcDRiOEdWQTA0enJFek04SGR6?=
 =?utf-8?B?TUp4bVlQYUFLMHJkdVJwUWw3YWxZTTNZQ0phWElyNmNuZlVsT09IKzBySkVn?=
 =?utf-8?B?UWpLZjczMmxnZ0gzQkJCK3h4ZXMvTGtLUnVqVHlxcSt4UVFzQmNCMWlib0JY?=
 =?utf-8?B?Z1F3T2R1RytNTlp5TnRBalM5VWpyb2Z3bCtSOWF6dlI0UlZNM1JrMHhjZ3Ji?=
 =?utf-8?B?V3ZQbGVPVk8xN054UWNrSTl3bjl2K250b0w4d0thbG8vNlRrMkt6ekpuMHgy?=
 =?utf-8?B?ekpaNmY3TTVta3ZMRXRhSjV4aTlYMkZpdkF5UlVjd2I4SEgzTGpTYjJhbDJx?=
 =?utf-8?B?dkVMS1VCTVpBRVJjek9adjc1dVJUSTh5YTV1dWZOckhKYURUa3BiRFlRRWpU?=
 =?utf-8?B?ZElNbjI2emVLc092TFFvZTMxbnhEbHY0eURBVHVKZE1OWkdVbEVtUk1kZGNZ?=
 =?utf-8?B?bHVrcnMvZGxkYWw1NS91K1RwOWwrOEIzejZRQTJuMHVuWjE3ZmMrUGZCR0NS?=
 =?utf-8?B?Wlk4dWlWOHR6MkQ1c2MzazZDWXR4VlpHS05CMWZkNHRMc0g4SXRhSnM3emJH?=
 =?utf-8?B?TmlqYVlVV3RaMFRRR2dUNDQrM0FZQVYwUUJEMXVyclhyaDdWWjJVUkJaNG5w?=
 =?utf-8?B?aXUzZENYWDlXeDZ3dWdVdld1Qk4yYnBFQXpKeHZMdWpQR3ltak1BN2ZOdnNw?=
 =?utf-8?B?WU91NkZSdFRPOHVMaEVWQXJCQWhlTlo3dDdaREJ2N1AyMTVhOHgrYndhZDJZ?=
 =?utf-8?B?eVRDZnBWRXBHbDJuSm02WndWT1VWL3JEcS9UT1prL2lpRFRhWTFLQm5BTmY4?=
 =?utf-8?B?N0tSWklxZ2t2N2RGUW0xU0d0T1JMSHRSY1BFUjRBdm5DVWtBTWJ3VEdpdE5m?=
 =?utf-8?B?NVdRSlJxdDNmaG16aGhtT1JQaEJoSHowb3ZRLzEyKzlDZFBSYkgyYkRmSmxh?=
 =?utf-8?B?bkl4OHo0S2l3Wmd5dWJaVDMzZnVmWTNzMThrVEJ1bVRLL210ZTZ6eFN0K0k1?=
 =?utf-8?B?TUJGdTk5Wi9vM0NOVEFuaXdSUHV4dzVvaDEvaWl0VWRYbUJLdkVxUHpYS1hm?=
 =?utf-8?Q?/xQlPtPs7/q3b/imCn+nh/ZSs6a?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y0FLZWxsNGhLVHZjNE9NckZMRXNMZXFjMXptd0dhbGV6aDBHSVBDZ2grZVh2?=
 =?utf-8?B?ZHBCM285dy9YNHpNM2QrZ2FZKzAwNmh0eDNuSlY0bXYvQzc2VUJkWE1XYlV1?=
 =?utf-8?B?ZWkwdVJCUnVWRUFQWEVsN1M0MlIyM3dIQ3h6Tk41WTBEb214OVpFTFhMUll2?=
 =?utf-8?B?WVpnR1VtMm9wUFNhVFFSMEg2ekg5ZEZya2p1WHZjTkQwSmpLcHk0UTdaNVNO?=
 =?utf-8?B?Q2xMMHBnN2ZQbjVLblNuNS93WWQwRjFTOWVTbmRFQXgyREpLdzNLc0w3Skxm?=
 =?utf-8?B?Wnc2Q0huSXNSN1k4ZXFUR2h5UzVaNEs5dnBHYWtPa005c2trWERDbUR0WUox?=
 =?utf-8?B?b3Yxdm9ZbXVMaHRlbHhkR0l3aGxrREY1OHZrRWZWNmNFV3gvWUN5Q1RJT2pP?=
 =?utf-8?B?OGtlcld5T0dPSzF6eWs3d0xHdnZMM3FoYmtTa2dRczV1MlplYnpEcmJHbU9W?=
 =?utf-8?B?NitoWFFiUi90WW5PQitrd2FMc3Q1TTlhakMrRFkwdkh1SW5sWTZlUW9TSHVS?=
 =?utf-8?B?OHBXS2dHZXFJSm5DVVZiV0c5NXRldC9ScjZENktKVFlBM2VXZkY3amoxTnJw?=
 =?utf-8?B?bWx2Sks4SGY1dnpEMXQ1S2Y5MmJ5anRmcGJnNFdhTlJycXl4WTNyK0hqZ3ox?=
 =?utf-8?B?V2JIdXdHT3Q0dDBJTTg3VW40ZkRLZ216M1JsL1NqQjBpSHBsZEVZWjhpOUMv?=
 =?utf-8?B?S05najV5UDNvR0trazNQMUthMENDYjViNU5lQXF1SFZjZlN0VHpmYUVrR29M?=
 =?utf-8?B?YVlOaDFSRHFzZ0ZMVTZsMG5xc0l1K1NsRjJmQWVqYWNwc29qd2VPWDNwSjEw?=
 =?utf-8?B?OEtKUXNrckNkYzk5ak5HaTFvRlpOYlhXYWlZREx3VlZUM2VsSDhwUVUySzBK?=
 =?utf-8?B?OGFlOTF4a2NCbjFaMFprSnNLNzlrMlFDYWhaYUpVZG1vQWZDSGg1aEhUSy84?=
 =?utf-8?B?Tm1aVGpnVms3OUJ5ZFN0ZHV5eGNDVEJZanFkbXdkN0hGdE50UkdXblg4Qzha?=
 =?utf-8?B?NWRrUWhMdEpJT3B0REF2VncyQUYySzFkK2V1bmZONWI2ZVdFK3BNcTdnc21G?=
 =?utf-8?B?Q1BWQkl6NHlQcVcwakt5ZHJvdC9RMnJtdzhXcTZaZWdrckZpUjFyOTFwVHBC?=
 =?utf-8?B?Z0xkYXJwdTlRQnhGUy9QcnYxS1NwT3hyOVBwOExuR2YxWnVJZVBIU3pFcmRr?=
 =?utf-8?B?ZDh6YUpXRkpWZm9jTGJ0R2hKNXlFcytrTDBONkwrQkZkVGN1WkpYa0ZzQ3lS?=
 =?utf-8?B?czdCanV3Zk9pQkdCWkhBTytxWGRQZ1pvT3Y2OCs0TFpjZ0kwdGJBOGRaaUpC?=
 =?utf-8?B?ZkF1UnF2RU9RZ0Y1UHBaQUVMZzMzY1RQZ1d1U0dCVDUyMDd2VWVhZk40T0ln?=
 =?utf-8?B?T2w3emoySkFtZUFxZVU0U2NNcElXeVJNNXM1NTVaYWdZdFdCdzdwTUNHK2RE?=
 =?utf-8?B?SXpqc3Zsc1hLdEl6Y0FLM29qKzZLZElkWmM1TVgxcmRKaDhrUDUxVkFTREND?=
 =?utf-8?B?dlVYU0g1cVpVemFXcFkwRll0VHRDc0MwY1o5NnhVZ2h4U2JRU3JMSDV6SlNt?=
 =?utf-8?B?VSsydE0zLzd0Z3I3UlNkUm1jc2F6aVBYT2drOVJZa0Fkb1RmVTJZK2xLM0dX?=
 =?utf-8?B?L29kQnRnVnlGcVVwWDBTa1FBc2JCUWVoWmluNyttVnJxSGFwQ2J5dUVVS3E3?=
 =?utf-8?B?eUFTcCs5UnVWS1ZKZGpzTTdNN0hwOVQzaG04ZGhqUTF5Q2xveUpFR2MxT1V4?=
 =?utf-8?B?aGM2M0tra1EvS3lVeE5IRUYzVlVTa29vNDVPY3dkZWVjbk90NHJ4ZE1Wb3ZR?=
 =?utf-8?B?STVVSFM1aVpqRmdWR01wU1VDR3pCbnBVa28ySWQxaGNndUprcVdqMmZ1ZjJy?=
 =?utf-8?Q?KmU/Cy1vD35tT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B6E945DA129FE547ACB4351222D1C324@POLP291.PROD.OUTLOOK.COM>
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
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-2112e.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 932265e0-9349-4b77-2579-08df4d488cb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2026 12:10:10.2447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA0P291MB0174

VGhpcyBzZXJpZXMgaW50cm9kdWNlcyBoZWxwZXIgZnVuY3Rpb25zIGZvciBhY2Nlc3NpbmcgUENJ
IHBvd2VyCnN0YXRlcyBpbiB0aGUgUG93ZXIgTWFuYWdlbWVudCBDb250cm9sL1N0YXR1cyByZWdp
c3RlciBhbmQKY29udmVydHMgZXhpc3RpbmcgUE1DU1IgYWNjZXNzZXMgdG8gdXNlIHRoZXNlIGhl
bHBlcnMuCgpUaGUgaGVscGVycyBwcm92aWRlIHR5cGVkIGFjY2VzcyB0byB0aGUgUENJIHBvd2Vy
IHN0YXRlIGZpZWxkLAppbmNsdWRpbmcgZXh0cmFjdGlvbiwgc2V0dGluZywgYW5kIGNvbXBhcmlz
b24gb3BlcmF0aW9ucy4KVGhlIHNlcmllcyBhbHNvIHVwZGF0ZXMgdGhlIEFwcGxlIEFpcnBvcnQg
cmVzZXQgcXVpcmsgdG8gdXNlCnRoZSBuZXcgY29tcGFyaXNvbiBoZWxwZXIuCgpUaGlzIGZvbGxv
d3MgdGhlIGRpc2N1c3Npb24gd2l0aCBBbmR5IFNoZXZjaGVua28gYW5kCkJqb3JuIEhlbGdhYXMg
aW4gcmVzcG9uc2UgdG8gIng4Ni9xdWlya3M6IENhc3QgUENJX0QwCnRvIHUxNiBpbiBhcHBsZV9h
aXJwb3J0X3Jlc2V0KCkiIFsxXS4KCkNoYW5nZXMgaW4gdjI6Ci0gQWRkIGhlbHBlcnMgZm9yIGNv
bXBhcmluZyBQQ0kgcG93ZXIgc3RhdGVzLgotIENvbnZlcnQgUENJIGNvcmUgYW5kIHF1aXJrIGNv
ZGUgdG8gdXNlIHRoZSBuZXcgaGVscGVycy4KLSBBZGRyZXNzIHJldmlldyBmZWVkYmFjay4KCkNo
YW5nZXMgaW4gdjM6Ci0gTW92ZSBoZWxwZXJzJyBwb3NpdGlvbnMgdG8gdXBwZXIgbGluZXMgb2Yg
dGhlIHBjaS5oIHdpdGgKICBoZWFkZXIgaW5jbHVkZS4KLSBGaXggaW5kZW50YXRpb24gaW4gcGNp
LmMuCi0gUmVuYW1lIGZ1bmN0aW9uIGBwY2lfcG93ZXJfZXEoKWAgdG8gYHBjaV9wb3dlcl90X2Vx
KClgIGZvcgogIEFQSSBuYW1lIGNvbnNpc3RlbmN5LgotIFJld3JpdGUgcGNpX3Bvd2VyX3RfZXEo
KSBwYXJhbWV0ZXJzIGZvciBjb21wYXJpc29uIG9mCiAgdHdvIGBwY2lfcG93ZXJfdGAgdHlwZSB2
YXJpYWJsZXMuCi0gTW9kaWZ5IGBwY2lfcG93ZXJfdF9zZXRgIHRvIHVzZSBgdTE2ICpjc3JgIGlu
c3RlYWQgb2YKICB1MzIuCi0gVXNlIGBGSUVMRF9NT0RJRlkoKWAgaW4gYHBjaV9wb3dlcl90X3Nl
dCgpYC4KLSBSZW1vdmUgYHBjaV9wb3dlcl9ndGAgYW5kIGBwY2lfcG93ZXJfbHRgLgotIEFkZCBy
ZXNvbHZlZCBTcGFyc2Ugd2FybmluZ3MgdG8gY29tbWl0IG1lc3NhZ2VzLgotIExpbmsgdG8gdjI6
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvY292ZXIuMTc5NTA5Nzk3MC5naXQuaGFiaWxl
cmVudHVya2VyQGhvdG1haWwuY29tLwoKQ2hhbmdlcyBpbiB2NDoKLSBSZXNlbmQgc2VyaWVzIGNs
ZWFubHkgd2l0aCBwcm9wZXIgc3ViamVjdCBoZWFkZXJzICh2MyAyLzQgaGFkIGEKICBtYWxmb3Jt
ZWQgU3ViamVjdCBsaW5lKS4KLSBMaW5rIHRvIHYzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9s
a21sLzIwMjYxMTIxMTI1ODExLjUwMzE1LTEtaGFiaWxlcmVudHVya2VyQGhvdG1haWwuY29tLwoK
Q2hhbmdlcyBpbiB2NToKLSBTb3J0ICNpbmNsdWRlIDxsaW51eC9iaXRmaWVsZC5oPiBhbHBoYWJl
dGljYWxseSBpbiBwY2kuaC4KLSBGaXggbXVsdGktbGluZSBpbmRlbnRhdGlvbiBmb3IgbmVlZF9y
ZXN0b3JlIGluIHBjaS5jLgotIExpbmsgdG8gdjQ6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xr
bWwvMjAyNjExMjExMzA5MzYuNTMxOTEtMi1oYWJpbGVyZW50dXJrZXJAaG90bWFpbC5jb20vCgpM
aW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjYxMTE4MTYxNTU5LjYzNjE3LTEt
aGFiaWxlcmVudHVya2VyQGhvdG1haWwuY29tLyBbMV0KCk5vdGU6IExMTSBhc3Npc3RhbmNlIHdh
cyB1c2VkIGZvciBlZGl0aW5nIHRoZSBjb3ZlciBsZXR0ZXIgYW5kCmNvbW1pdCBkZXNjcmlwdGlv
bnMuIEFsbCBjaGFuZ2VzIHdlcmUgcmV2aWV3ZWQgYnkgdGhlIHN1Ym1pdHRlci4KCkhhYmlsIEVy
ZW4gVMO8cmtlciAoNCk6CiAgUENJOiBBZGQgcGNpX3Bvd2VyX3QgaGVscGVyIGZ1bmN0aW9ucwog
IFBDSTogQ29udmVydCBwY2kuYyB0byBwY2lfcG93ZXJfdCBoZWxwZXJzCiAgUENJOiBDb252ZXJ0
IHF1aXJrcy5jIHRvIHBjaV9wb3dlcl90IGhlbHBlcnMKICB4ODYvcXVpcmtzOiBVc2UgcGNpX3Bv
d2VyX3RfZXEoKSBpbiBhcHBsZV9haXJwb3J0X3Jlc2V0KCkKCiBhcmNoL3g4Ni9rZXJuZWwvZWFy
bHktcXVpcmtzLmMgfCAgNiArKystLS0KIGRyaXZlcnMvcGNpL3BjaS5jICAgICAgICAgICAgICB8
IDI4ICsrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0KIGRyaXZlcnMvcGNpL3F1aXJrcy5jICAg
ICAgICAgICB8ICAyICstCiBpbmNsdWRlL2xpbnV4L3BjaS5oICAgICAgICAgICAgfCAxNyArKysr
KysrKysrKysrKysrKwogNCBmaWxlcyBjaGFuZ2VkLCAzMyBpbnNlcnRpb25zKCspLCAyMCBkZWxl
dGlvbnMoLSkKCi0tIAoyLjQ3LjMKCg==
