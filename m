Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795867818;
	b=oic7N3z4SWTfUkWAvv8DrC4vzEAr29mWH7c2AU1YBXPQNpgFZtvPj2S2fd2RKhJWO3Vw
	 x/R+oIl69vBaoKJdZ6ObE/LWla3prmEUvXYodKEs2xdzGr140AGS477AY05fMJ+pGW+Q8
	 96VvOSaM2kpIybzr2ND6o0mlf97i9tTLttWX51evH6CgE9Gca1AGlOoQSIHjBu68Ms6dl
	 j1IZzfUayJT/8uzT0I4nZjHvVJdtDje3J9UJbFJ6NyV3foUFO1Mc2cmwkAg67VUcxDaKR
	 Vk5H/LtQea1R/KahwH/DpraDTzA2W2gBYWJZsTB4dLo/CjJkvmULFyfBv5toVzZfyiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795867818;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
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
	bh=aYxhWrKmXpQ6UGbDw83Ie76JUQI7tCmaDceRa5x7sCQ=;
	b=ZN7mYsQkPBrWRK0LwTjavhMf9Pj5KycFCJsaXxVFMAp+3DAlQpsGoDLejUZmh64g7vTv
	 KdnqJ9yHHdOuajTtYECAvQPVWtibzp327dbt7VkycI4lzlVBFLKJOXzpuTBUnvVdSaWhJ
	 TZ4D9+sKlv3gpOJ79WHtV/EeOaQcKR86xnGWm9DgFH0uM+ZqiblAawUynXtOZ/TCiFoA5
	 iK5Bf+/UepWbjUAHTzsq9ykdh4LsNhK/SHMfrDhBq/XuphJqNDu98ANDMe/NH5qMvPkW4
	 6NfvY/kAAi61ExqJjM9Wu418w/lXXoHiYna1um1KmYJq7E5vGTZW9eOUMy8Y/N4ddpg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=LwIvHFZY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.25
Received: from WA1P291CU003.outbound.protection.outlook.com (mail-polandcentralazolkn19011025.outbound.protection.outlook.com [52.103.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C887606A33E;
	Sat, 28 Nov 2026 12:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C887606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=LwIvHFZY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vNo2UCcZauOOrq7b4LkOcgFqV/3RW1gz5BMEiyG80NaT7bnibVSkCUICreSft/P/eSw+OwvmG2KtSsPImxZ3t+kup1dDOlpAyZzhj7I1mPpHD1sI1PBqThxSQU1OdiFsjzPMopy4GVNznZzY9fCicf7xvNpuSjIhd7XMwAhA67SB5X+KV4pMQKUbDlHudO3zaaGk4pUESJ09pm6gX9Zf8d7IsBKC+yOTXmYZ+i8yBXE3wvi+xcfWokwCGaCwd9jzgJG2jFvKEZsb/Bnfbh+DrvY12G5a54h6aP/j956h+shjOHqiHPCDZmxNupIDtX0qol2whqC0/NZDmjUNWz4WBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYxhWrKmXpQ6UGbDw83Ie76JUQI7tCmaDceRa5x7sCQ=;
 b=lL1CYt/HVRJxZpMIgcXJ2GrDTlWJX/3vkNq92Wwp5MRAv/QWoMpI4tGtg831C4OqsgAVejz94J+XlpB4fTPOBGMukQdilxxmhAzi+sWmmn9QTBhOuE8HQzZf8ChxdeMtOYXiAbETe0e1/bmJSnhZqAULO9/N7lYOIbJKREG9q9YhcxRsdOIrgmWu3xYsBXM4vAcc//QjO426mUWha3usHO2fNxPvCVRldQb3hdES7PlLXxBX8usfU0Yu8th68Ss3ZfExyf3lttlg4Pst4gxqBfXtL6ls7HyolGVEslOVPZM9gebP730VFiazBL9ygdU9DKIkLuMGUEgxnEyniYygVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYxhWrKmXpQ6UGbDw83Ie76JUQI7tCmaDceRa5x7sCQ=;
 b=LwIvHFZYAqhBJp1prWaZQjEfH/OpFBe7VF/Mwfh1dwOBtVWfjhjy2k3X4sEUsWVQu+4VryItwnyuMFgFIIsIhA43Hmmwu9oN8eUWsf3fywYjeJRrlrRIM96FsGfiESLvA4A85mcrTQ0fkNnBMSSPMkeTFw8qzF/My1IYpTPImjOBiajQ4K8MC0oCKBLqU4AVOegcIGhzpMdaAtjXWYAg7xNsaqqyH8D2dl9hgzwKXw+oyS56S573c38Hhy01PDwV/wlXSd0Ob6qm1JXB5Fqu3QYPG9pR/AfytHALMTUz6eHSAJWUSQ5OpEZaNjLy34rtAwDlMGn3D9qP6jKljEzu+g==
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:26::11)
 by WA0P291MB0174.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.6; Sat, 28 Nov 2026 12:10:16 +0000
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404]) by WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404%6]) with mapi id 15.21.0662.007; Sat, 28 Nov 2026
 12:10:16 +0000
From: =?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?= <habilerenturker@hotmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>, Thomas
 Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?= <habilerenturker@hotmail.com>
Subject: [PATCH v5 4/4] x86/quirks: Use pci_power_t_eq() in
 apple_airport_reset()
Thread-Topic: [PATCH v5 4/4] x86/quirks: Use pci_power_t_eq() in
 apple_airport_reset()
Thread-Index: AQHdfzFtwNyhJ1v1pkaVzc17uSNH6g==
Date: Sat, 28 Nov 2026 12:10:16 +0000
Message-ID: <20261128120858.8737-7-habilerenturker@hotmail.com>
References: <20261128120858.8737-3-habilerenturker@hotmail.com>
In-Reply-To: <20261128120858.8737-3-habilerenturker@hotmail.com>
Accept-Language: tr-TR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: WA2P291MB0187:EE_|WA0P291MB0174:EE_
x-ms-office365-filtering-correlation-id: 10133090-e38b-427d-862d-08df4d489050
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|25010399006|16051099003|55001999006|8062599012|8060799015|38102599003|19110799012|31061999003|24021099003|41001999006|21061999006|12121999013|15080799012|40105399003|102099032|3412199025|440099028|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?eGJnSk5lbzUyR2R0bnh1R29pamZjeThkMk1PQnRhb25HVURMM0NmQXhUNGNp?=
 =?utf-8?B?RUZpMzhvTldVOEo0dEdqSXVQQ1BzbFVNQmRmMFdQN2h6YkNQMGRld0VMNDkv?=
 =?utf-8?B?TzYxSkJVVjg2WWxsUENHZkpFTHI2Z2IycUpycFdoandvRjlZZ25rdXQ0M1pt?=
 =?utf-8?B?S2FZdzhteDZLZWp1K1JFNGMrU05qQkFBaGF6QzZEenpsS0FVclJ4Y2daNVE3?=
 =?utf-8?B?STFsSmt0ajhXTjUwdk9OcGdTS3pKVTFoM3pxaUl0MmN2N205cWJyTEFXM2RK?=
 =?utf-8?B?NjVwVmlLbkpwK28vREErL0tnTlc5TDRLZFJCMDBucjdkTm9Jd3pZYTZ1S25B?=
 =?utf-8?B?OThpcGVrUWc0TnU2RXUvVDZGeW5FMEgrU3hMOXVRZUp6SnBwMk1waDlWSGxZ?=
 =?utf-8?B?dkxwOHZKV0NNM1F1M3JGTWhuWU4wOFA3R3ZKclMyeW9uY0JVdEVhd3RMc1F1?=
 =?utf-8?B?YjNPRUhhajlVSWJtRWsrZnNlSDhuQ2NHNW9VeHhQbnFNZGJkR01XTUZLR1g5?=
 =?utf-8?B?MGdobzV6SjdxWjRrMll0dXk4RVJLSWNPaWtOQUFQbk5WSFl0OTNBRVRsdlVr?=
 =?utf-8?B?YnExY2lVYXpkUlRnRVBWbU1rcUtjeDduRUZtRGNxL3B4STBnc2VTOU1QRlJ0?=
 =?utf-8?B?aTRlU3FUaFZmR01YaG1sVWttaU9CZ3hhbCtPa3R0VitGT2E2SVhtNTcraytV?=
 =?utf-8?B?SmFVZ1ZZUFZyN3M2MnRFRzBUWUVLc1l1L1FlQ2RJd2RjQ1NROU5leVNLWDY2?=
 =?utf-8?B?aW9RVFhyMjRRRTAzNWMzbVlKYWR4ZTlOKzNLKy8rQlVLOTAyY1k5ek85QURW?=
 =?utf-8?B?Y215M3VKMmg0MGdQUEdscVFuR0NEMDJwOVN3V1VvbTh1MkI3SERzYUFoclFZ?=
 =?utf-8?B?Y3lUNDJZbGRxTmNWaWR0eEF5Y0VQankwTnU0aisxemdBcWl1MlJ4cS8xTkVO?=
 =?utf-8?B?eE1URERta01SS1RyMkp1STlYeTJSVDZYeEY3dXBOZ2g4NUdsR0g1TFlNWTJu?=
 =?utf-8?B?eDBqVk5tSlB4M3lCOFY0bUZkcnZoVXM0MWN3ZXUxaytDNjJPOG92MXJJY3Nq?=
 =?utf-8?B?dk5WT1FmUlo1ZE0vMldBaEtBRy9Ya1ludDByWU1CMHlXYU82UXJQOE5JSlBm?=
 =?utf-8?B?ZGFPTEVSMzF3Q0tkZ2laZ21ReC9TWkpiME5RaEdkU0lTbDdTdkZkMlc0ZXNH?=
 =?utf-8?B?bnU2ZGVzRmZ0UEJUUlpFOVRvZUNMUjVLblRDTXU1OVhmK3IwLzlpUzdWdUdH?=
 =?utf-8?B?RXpJVUZKVlJNNVlERVBpUThxQkpseUhVVmoybnpFRHBqOHQ2NTVtV3pnLzNS?=
 =?utf-8?B?YXd1U1VQTm5RczBhT2tuVVUvODhTeEgrZXFNOUYrdytOL3NNdTRraVJ5TGpM?=
 =?utf-8?B?RWc4SVRRc0x2aFA2dW1VN2xGRnYwbmwyUytCOXE1WHdFcDBPMnErRkE3aWFO?=
 =?utf-8?B?NUVBNTVIMy9xQmxnWG5MbTlaS294MXdaMU1GbXZUOHIzSVE1RE15SG96UWg5?=
 =?utf-8?B?S0hmbUI0dHR3YS9vbGhwTERsdlFtU3ZZaWFsS0dXV0duaE5JcklUNEdrSWpr?=
 =?utf-8?B?anV2UT09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MDVwb3JHc0ZFa2Q3M0RTNmw2cTZ3dlZ5L0gxTUxtZWd5aW1TUWwzUEZuVjRT?=
 =?utf-8?B?SCtBVzdYNkdNYUZ0NTlwS2t4eEhPRWU0ekcyTk9HNnlIQTZBeFcvbC84ZEZZ?=
 =?utf-8?B?ZWJndHNmTmxiKytvMzcvanQ0bUVVaU0yeXVyOVYzcjA3dk1Wb2xhQWdYblly?=
 =?utf-8?B?WHNHMVdvT1hMbnRMdHc5TS9pSmZYckEwSWl3dUZ4eWFXWVRxeUtuTE8rdnQ0?=
 =?utf-8?B?di9laThacDh3Yithc1dicXdTWXdmWVB4eFlhVmV1c1N4MGNkK244RHM3VE9U?=
 =?utf-8?B?Ry9HN0NnOURYdWVUSTZpaWhRVVpRQ2hZY3d3ckUxSVRvZXJ2blVYdDUrb2J6?=
 =?utf-8?B?Qm1rVlIyRnZpYmtaZ3VMNnc5SjRPME0vNXVrQzIxUUdPMGJjS2g4ZGplREhk?=
 =?utf-8?B?NWs3V1BYVHZac3pPT1hpOStKY1I2TGNHbU9mQ0h0clUrdVAzRGlrVVRHOENE?=
 =?utf-8?B?YXNVbXFWdUQ2ZldzNm9obDdQUWJwSTFIUXFVTFFCT2hZa2MvSnc0NjlFVitp?=
 =?utf-8?B?NDFtRitKOTZVRjlkYitxYTk1L2dqRkZkSDFJTDc4N2FhT3ZBcElDOUxTSFdZ?=
 =?utf-8?B?ZGNvRlZSWlN5cmh5S00xL1U2WGc2MmlVVDMyeVJBZFE2ZjFqcnZCdnYxbzBN?=
 =?utf-8?B?UmwxeUtuVjNoOG1UazVaN3JsVTFCekVUN0JET3V5RUlvNTRRNFBxSDZhR1VG?=
 =?utf-8?B?NmdLYWlvMjR4dkdBVGNyUUNlQVdkaGJCUXMrWE5DaVJYOFFWWDhIWGxwYUFr?=
 =?utf-8?B?aFhJeVg5WTUwOGRWUkUzdVIwQXUvcEVFQ2R4M1Fpd0hGeGRhNGp3WkR6M3Fv?=
 =?utf-8?B?bW50M0cvYVdIbytHcE9XcXdQMWVPYXROcU4rMnJyblJQVzNLUmI5YkptNG51?=
 =?utf-8?B?VkhaQnVrTDRaODMzb0FtclhjZWNRVVZPUjI1UTM5NlVpTmtPNjNKenM4MmFJ?=
 =?utf-8?B?dktURjFDZWV3c1RZSlhDZDY5RmVVMGhPTEdMSmRYV2g2RlREdm9EZnNvYjJV?=
 =?utf-8?B?WHNYOVFUTHFZRlVwc3RSQVFGem4rUGs0bTVKblMxY3BlNW84ajI3Q0hhTlgv?=
 =?utf-8?B?MWpOUEdTR3dTUE8yNUlKa3htSTFrV2F0K0FYVWxWS3F0dSs2YU91S09RUVR2?=
 =?utf-8?B?Y0U0c0xVQW0rUTBnbUNCVm9udTdNc29LLzF1c3F5Y0NrbERQRzZsdkJoL0dj?=
 =?utf-8?B?eVlvM08yc3g1VmxLeVEwelRDc3BadXI5L2cwNzAxSHZEZEJqdXBZcXR2aWxp?=
 =?utf-8?B?WUpDRVRwdVhQT2Z6ZjRyNE1naXFTc0NUTGhHT29MSC9oRnpUcFp5M2xyWllz?=
 =?utf-8?B?aXg4Wi9MbmhaenV5dnplTm8rYVJnM1UzTjJ4TnRqcUhodkxEYkN6U3ZCYW9x?=
 =?utf-8?B?MG5jV0d2NzE1Vk5kWmRuWG9aWGo2Tm91Zy9FZzZpZUZCQTRZbkRWZmFqYWRy?=
 =?utf-8?B?dk5KdytlUEV4akNySkhMUXlETDNFSjlmYmpHaGN2UkppRGt6TFVjUVM4bnRQ?=
 =?utf-8?B?Z3h1bThVVUtrQ3ZnSE9FQUpCQVduQ3EwWHRnM3F1VzJqclp4UkFNZ0M4bVhX?=
 =?utf-8?B?d0VXT3hGUzFMZEQvWE4yclBwVjZIc1huWWpEYXJ4VFZabktodWhiNEE2UlF6?=
 =?utf-8?B?MklXaGZHK2VZalc2VnZHeGVLdWxjSGVhV21iNTEwYlBxVkloWVRidW5lVHZY?=
 =?utf-8?B?VWRGQWVMTTNCSVhpYkcwdWgwc0xMTWZwUU1KTE4zYitIVVBkWWlZQ295T2tv?=
 =?utf-8?B?TkY4VzNUbUVKSFEyNzg2eWpjVkpCSVhVWVdOYkhjRlM5TXZ6czZQckhvd2U1?=
 =?utf-8?B?MFhPV1Q0NElMY0tWVnZHdDA3VUE2OXpkcnRjVkZEZmQ0ejNWcXdVL2UrNWx5?=
 =?utf-8?Q?P6fHYV2xREXMe?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CD870E32455B14B890DE06F589DF353@POLP291.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 10133090-e38b-427d-862d-08df4d489050
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2026 12:10:16.3678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA0P291MB0174

VXNlIHBjaV9wb3dlcl90X2VxKCkgdG8gY2hlY2sgdGhlIFBDSSBwb3dlciBzdGF0ZSBpbiB0aGUK
QXBwbGUgQWlycG9ydCByZXNldCBxdWlyay4KClJlc29sdmVkIFNwYXJzZSB3YXJuaW5nczoKCi0g
YXJjaC94ODYva2VybmVsL2Vhcmx5LXF1aXJrcy5jIDogd2FybmluZzogcmVzdHJpY3RlZCBwY2lf
cG93ZXJfdAogIGRlZ3JhZGVzIHRvIGludGVnZXIgKDIgd2FybmluZ3MpCgpTaWduZWQtb2ZmLWJ5
OiBIYWJpbCBFcmVuIFTDvHJrZXIgPGhhYmlsZXJlbnR1cmtlckBob3RtYWlsLmNvbT4KLS0tCiBh
cmNoL3g4Ni9rZXJuZWwvZWFybHktcXVpcmtzLmMgfCA2ICsrKy0tLQogMSBmaWxlIGNoYW5nZWQs
IDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9r
ZXJuZWwvZWFybHktcXVpcmtzLmMgYi9hcmNoL3g4Ni9rZXJuZWwvZWFybHktcXVpcmtzLmMKaW5k
ZXggNzQ1OWEwNzNjNzRkLi5iMTBhNzNmYjRiY2QgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2tlcm5l
bC9lYXJseS1xdWlya3MuYworKysgYi9hcmNoL3g4Ni9rZXJuZWwvZWFybHktcXVpcmtzLmMKQEAg
LTY0NCwxMyArNjQ0LDEzIEBAIHN0YXRpYyB2b2lkIF9faW5pdCBhcHBsZV9haXJwb3J0X3Jlc2V0
KGludCBidXMsIGludCBzbG90LCBpbnQgZnVuYykKIAkvKiBDYXJkIG1heSBoYXZlIGJlZW4gcHV0
IGludG8gUENJX0QzaG90IGJ5IGdydWIgcXVpcmsgKi8KIAlwbWNzciA9IHJlYWRfcGNpX2NvbmZp
Z18xNihidXMsIHNsb3QsIGZ1bmMsIEJDTTQzMzFfUE1fQ0FQICsgUENJX1BNX0NUUkwpOwogCi0J
aWYgKChwbWNzciAmIFBDSV9QTV9DVFJMX1NUQVRFX01BU0spICE9IChfX2ZvcmNlIHUxNilQQ0lf
RDApIHsKLQkJcG1jc3IgJj0gflBDSV9QTV9DVFJMX1NUQVRFX01BU0s7CisJaWYgKCFwY2lfcG93
ZXJfdF9lcShwY2lfcG93ZXJfdF9nZXQocG1jc3IpLCBQQ0lfRDApKSB7CisJCXBjaV9wb3dlcl90
X3NldCgmcG1jc3IsIFBDSV9EMCk7CiAJCXdyaXRlX3BjaV9jb25maWdfMTYoYnVzLCBzbG90LCBm
dW5jLCBCQ000MzMxX1BNX0NBUCArIFBDSV9QTV9DVFJMLCBwbWNzcik7CiAJCW1kZWxheSgxMCk7
CiAKIAkJcG1jc3IgPSByZWFkX3BjaV9jb25maWdfMTYoYnVzLCBzbG90LCBmdW5jLCBCQ000MzMx
X1BNX0NBUCArIFBDSV9QTV9DVFJMKTsKLQkJaWYgKChwbWNzciAmIFBDSV9QTV9DVFJMX1NUQVRF
X01BU0spICE9IChfX2ZvcmNlIHUxNilQQ0lfRDApIHsKKwkJaWYgKCFwY2lfcG93ZXJfdF9lcShw
Y2lfcG93ZXJfdF9nZXQocG1jc3IpLCBQQ0lfRDApKSB7CiAJCQlwcl9lcnIoInBjaSAwMDAwOiUw
Mng6JTAyeC4lZDogQ2Fubm90IHBvd2VyIHVwIEFwcGxlIEFpclBvcnQgY2FyZFxuIiwKIAkJCSAg
ICAgICBidXMsIHNsb3QsIGZ1bmMpOwogCQkJcmV0dXJuOwotLSAKMi40Ny4zCgo=
