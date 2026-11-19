Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795098951;
	b=GyyIpPteg6v4um6b/4A5y6yWhm6j9QpazMVup4Eiy7I4qnAFZzxgLCH1hhQ7uhZ/zSl9
	 vKb4rkjaOkmw9itIkH7qElcYbjcAgMHGTF7g/Y126w6WS5aZXTw26xJo3UVrywa8pi2UP
	 qs2CEbuQiufmvhIK63i8YbaPP+RWBt3w0hwzSmKpRh3ebkRlqZwumZuD5fRiEvHCgFEcv
	 /XwiVQUAjrgeb60y11Kg7kxIh3nY9OqblC1nHlg7QpyP5HkN5/mZM8QwgpueqHcg0rqmm
	 jRAnaG13GDRHEaUvYjq76n9xd5g5Y18U/853yEUBYFrYdZ/wSnFdLOZ8E5mwV25++Mg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795098951;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-slblob-mailprops:x-microsoft-antispam:
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
	bh=f8NNhsyyV09m7xXjps3J2GPgQuBvEy5PdLAUGbF2CO0=;
	b=z2kDhWUGFrbY86bBxLQZetrFFzMGCz0O/YEKm92Bvd3S5OL+uJQRp3EeGjfifVXInuXL
	 ISIqSOr9jjrDYUEb+Qdyf3P/zQoS7oSzcrsTkkXf0lJew3GRm0DfAAkD6D0F44/lrnbDG
	 Juh+K5CMMDmD1/PaWIpLrC1jeN96HUhOrXHf98B6Fa6h5PTZ3cRO6h1EYn4lMsoU2QdKg
	 duB2PLoPEVIWoQlV5hJjgBGbanbQg3UzaiBdk71dBcsr8utDxNwuAm/0eZM0pyCwSL2Nx
	 WuJ9IjJnPUzNQ1yGwTi4uJp5uauYXiQXQz/S8PEF5w9avSvt4CllRuGWBbTjFrILYSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=B9L+8hCV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.2
Received: from WA1P291CU004.outbound.protection.outlook.com (mail-polandcentralazolkn19010002.outbound.protection.outlook.com [52.103.53.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9217606A339;
	Thu, 19 Nov 2026 14:35:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9217606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=B9L+8hCV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sn2Whg/vZ2ztFqVfClpinjuJYpmdzI4ifrFUJavpvVRH3mJbzLXvb/7moD6iKGqcQE8FnlWpLdwl5ogrjDY1rGfKyX/5xj11aJn6ZkHa/FvSAxlAZSolc6m6aZ0h5mQYmxH0VCubjOn8dA5S6FWQjWg0+4EPDEtjex235GvATxBdEib1+WK1a+CgNMzVAu2+BsvrFYdUDFcZEMK6oHeeQ5vik88NO9bED2hicwa+dHDq3gjrl+Wo8Fgj7sywLrDe/cADYuq8bMQoPpEVeSRQKB0wTSJGQvgryWSqST+5olfVieUJBFesfoIl1UIW4fuf7uZbzj1RC71YK32sCRVJHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8NNhsyyV09m7xXjps3J2GPgQuBvEy5PdLAUGbF2CO0=;
 b=vlct7veRcxpptVp0OzWWbs3SJHcHNJompDEyS7l14cRXJTZzbsBmPsmHcCzRvc4HHJeT+Zfxjp8ZfzdnBOTCa4MQ+lbFE16chDj6nEfTte9pMIjYCoMwdJvmhrbXiVJeIecEdHJcDGZ05MGFcuct3ydy3l3V3NHqadnWoiDB3EpYzeDd1cYr1s3r98DkedFMYkvoOIMQOEAeoWAybk6mGavPLSU3Ry0sxKWGWYs4Jtttu/Sko6MXD9xPXd+XtQcxGlLqVc68lStiUvoI2L0ILH4iOHSpeIqDMchU7xk/1vxgyxQBt3sEO0Jxd1ir/ZZyeyUBerXj3FdSenK7jqao0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8NNhsyyV09m7xXjps3J2GPgQuBvEy5PdLAUGbF2CO0=;
 b=B9L+8hCVWmNShXC9chOGRCklUhQSteKYz1XV8zwa0982C/2GNJkyMFt0gpidad+zpGqtzFxL5J2xRcCRdTkTSI4P9IMBcMJdvjN+pxANi/Syqmgv1YbfdsAiUG65bNihVjD5NNB3Zagt5HtiHEKdCzQWtgFoZxQ5oSlSvDfYs6FIL/G+7X317ZJNR0DUedE4TnTwlJF2WxQN5qIKmM9GsXxFn/wzOMvOcrY+fNYm7ujqe8fJKlOfIetyYJTEwEy1phXfaq0JzrW1JNDGdyyAeNNm4EDOkKxe98u0mPCeRckIAae5ippLl39HyheAKb7Ey3HCsYDtS3hvlE6RmV5amw==
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:26::11)
 by WA2P291MB109571.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:47::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 14:35:49 +0000
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404]) by WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404%6]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 14:35:49 +0000
From: =?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?= <habilerenturker@hotmail.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>
CC: "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>,
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, =?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?=
	<habilerenturker@hotmail.com>
Subject: [PATCH v2 3/4] PCI: Convert quirks.c to pci_power_t helpers
Thread-Topic: [PATCH v2 3/4] PCI: Convert quirks.c to pci_power_t helpers
Thread-Index: AQHdeDNFCSkt0YnohU+kbfy3sJ7a1Q==
Date: Thu, 19 Nov 2026 14:35:49 +0000
Message-ID:
 <4ec395bd084e703fe6cacb31bf287a739cdab35b.1795097970.git.habilerenturker@hotmail.com>
References: <cover.1795097970.git.habilerenturker@hotmail.com>
In-Reply-To: <cover.1795097970.git.habilerenturker@hotmail.com>
Accept-Language: tr-TR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: WA2P291MB0187:EE_|WA2P291MB109571:EE_
x-ms-office365-filtering-correlation-id: c62a716c-45c7-469b-f7fd-08df464a67ef
x-ms-exchange-slblob-mailprops:
 qdrM8TqeFBvhuFgLLe5qs4jWk9CHdv0AHliBZFaAR8+lVSnkZjKsyFyu/hwrsvrqMKnA3VpYQpfgObIJNkNTmaNa5xnBoOk3dXC0dewKX70hnNsF62lpMtdoBrGAHhigYACoSBu5Hx9JxCLrCb62kWaFBIxawpAp7uD9Soqe0fFyNzfbwq6ll8NiTCsR4qTBm0xQVzLVvXA+7IygjvL1ENA36MaK0Eks6ORIbWCz8KhQ1zbsMVWoNk27GCpeyUR4igmnDbDteqiNeNYFjABXpyf327beSJ7ekvKpcaMohBR9+UnhXCjwMaa6ierhOjEUYvucDkHuQnl9kIAmiWxXWE+q5S26oVNYIbHlL+VpvqRNl0LHgHPRjS2S/5hliOg36L95DE+UmKU9R3NIkszPos2oxNONEzFJIsoFFRP0RFtAvqzGjtJPL0EPGYEOQApQRv3zLBSRM3Uf8waXDqv1PYTrbB9jMx2mBEzvre6KR3D99sjsyNL9/AOJNQXRAGcdqtfvCEnWQMOTCkV2IlTg+AvilTsuk1EYd4gbuRp9ow/qrDxWO3Rs2aeumuhmQsS1w5nVogoqN/HuhvWU7i5wdP+VhBLLAtAvJJVZKou1/U6VsK8NX55xjCJ0oHUO6CRRsOeYZy/91+oPR7DJB71zxsY9iAiF7X7Hs7/1+GCj7rezfBUGaVSI22qBC6X2AVeLYozT5SYNBEQ3vPfwLYrrL0vfQApl7vkIEsyIWft3r2t8U/RTG97W78mjJ9q3dDlVyqYP/Er6xLfEr4XY6NEdQ7yboJrJZCn9
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|19110799012|51005399006|25010399006|24021099003|55001999006|8060799015|38102599003|31061999003|41001999006|15080799012|40105399003|102099032|440099028|3412199025|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?eFNidTIrWGEveHlGWHZxRHJkRkF3WVNtd0NCOHFLT2FSNllJSytISjR5cWpu?=
 =?utf-8?B?TXM1Q2RqNHk5WDcrWVVTQS82UVkxZk16dEFiaWZmRkhMdE5jdzd0NkZQMDcx?=
 =?utf-8?B?TG5kVmwzaFNGRGFwMXQvWXVONXlacW1VVVhqUm9Rc3k5SzBjMTk3NmN4VGMr?=
 =?utf-8?B?WmdDbjk4WFN1NkdTeEp0OVRqcnk1V21vNTh6a3NaWFAzTnVHMHM0SDBjVXdT?=
 =?utf-8?B?Q05lbTNaRE9ENVVyVkZUMUdVOTMvY0pHZkxSN2pEbGpHcEQxdTJTU2JLZFRC?=
 =?utf-8?B?ZXBweE8yNTA5U280VnJFWTk4aHdjaGttejZEbGtDNXlrRVNkcGpQTThkZFVy?=
 =?utf-8?B?anJXYlMrTzhRVGlwWWV0S2FQbnNXL0VUR2pQeCszQXNrTjUxT1o3NllRKzJK?=
 =?utf-8?B?eEdTRitWaERFOUZNN0FWQVlFK1ArbThkR3R1NGkxclA1OFVDODRQejRjeUM0?=
 =?utf-8?B?aVhhdnpzOTV2SzJRekpHblUzb2RtSDJUUnlIYWxRbUZ5bVlzRkZza2ZyVTdl?=
 =?utf-8?B?aVZKaGtaMytOVUhZWmZaSEdMTFhrdzNJMUhDTGhRN0UyK1NMSzZ6Q1JvN0RG?=
 =?utf-8?B?VjdJbnBzald4MkZ2UkNlRmhhYjJvNWNUcnc4d2FONllzMHlOdUFTTWZxaFpt?=
 =?utf-8?B?RGhBcnM5MkZOdFQ2VzdjZ2JaOWxDUUJxcWF2MDk2YUFZSWJNK2FRMDdFOWtI?=
 =?utf-8?B?QjlyUEFhTXVKcGVXY1ZPamVxTW43L3dXOWNZdlBHSlo0NC9Hd1ZwbCt3NjF1?=
 =?utf-8?B?dWN2V0liM01XMEVaeDhERXhYSDU0WkdyNkRMVDRWa0JJWVRoNHc4TGl1ZTZk?=
 =?utf-8?B?bEhtNlE1Z01XQk1DWkppN0ZMeUtDK2xMQXlOWjAyalpJeXE3VjRjaXJuNDlM?=
 =?utf-8?B?OVBRU2MrOVVqZnVQMnFaQXhoL3JJeGM1a0g5Nk9obU9FRkEwanNrNk1RUFNR?=
 =?utf-8?B?dGtsS2NGTy9WRmdKMEJVM0tsNjRROHlOYnlnNitZZERKekIvb3pzejd3aC94?=
 =?utf-8?B?d0x0UmROdzNhNWY3NDBOUHNjcUFpeHhDZWpDN1ltYjg3QUFhZythK1RQMVNY?=
 =?utf-8?B?WDJDSjRxTUdmbFVrMmJoMzNSOXcrZTR2dkpaaWZSdERYcTVpbFhubzRySlk2?=
 =?utf-8?B?V1B4d0ZkSE5qa08rMldLVUlyWUZxV1YwNm5veW5BQUhjMzR2U0JoMWROOGpX?=
 =?utf-8?B?MXNmcVp4VG4ydEJROWtjUWN4NGdVSzh6NithN3B4UVJwSGN3ekYxQ1ZhZFV5?=
 =?utf-8?B?aEQzdVEwTXpTN1c2dFNacE04U2NOeGZVRjRtQjNxVmZpcmV0VWh6ZUJld29x?=
 =?utf-8?B?elYyOElReGtOVGNlUE5oU3prS0lldjFJQ00zL2FOZnN5eFJla3NyUUoxRmVW?=
 =?utf-8?B?cGpaajNpdXlsd2tsQkhESkc4WnFMdCtqaStVdDZZOTBoU2FrSmlKTlpSUlZ6?=
 =?utf-8?Q?+rOvBcpV?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UXBIczhzaE5hZkk3TWhpdk9DL2NoeEpVQVVvS2UzUC8wcUNuZEhIOFVMc3dN?=
 =?utf-8?B?bFNGSHJTWmJHcVNOeGFhRGgzY3JPakxHT05NNFVvNHdlc1NJRG9DUVRPbmVr?=
 =?utf-8?B?UWVCK0VLVGdlM2lvOGF0U3NKdFJpUVF4VFRwMzlNeE95Qm9jTDUrMndmeFdT?=
 =?utf-8?B?c3lwYTh6TUIySXJxL3g1K3ZESnlscXI5czVDa1F2YVpjWDFjTkVadmpVTnlK?=
 =?utf-8?B?bS9GWXBnWUZIYWxscGJkNTRLQnhRKzNsczZST2lOUmwvL3lhRGtsdVRBcW5G?=
 =?utf-8?B?MFBHejljZ2lsRmxhUU5VSk9OSDJXc0Iwd3ZkeUdpMm1YL1hvVlZJVXM0MExv?=
 =?utf-8?B?QlB4M3RVOWpRK2xQdnFES2JleTZnTzBWcVhna0JuV0JrZFpkZW9xOG0vRGJW?=
 =?utf-8?B?VzF6VkFRY2dCT2V2Ymw2cEViVWZTamZHbEx5VlBVSjlrUlgzS3NyRXgzQlly?=
 =?utf-8?B?S1hqWFpJWTNla3lGNnp4UlBpdEJWSllabTRoUCtLV3FBUlRucjVFMUxuaEhG?=
 =?utf-8?B?YWR0WHVqUVFTaFdJdlVSMHh1WmcyODlmNm5mZ1ZFRnNaUlJsQXZVWXJ0ZEY5?=
 =?utf-8?B?Yzd0R3VuMVNLM0RQNHV4OXFWRzJTVWxOMXQ1cUp6ODlDdE81ZkhRYVNQZjJJ?=
 =?utf-8?B?Zy9oTTUwU2dud0cvY0I1OFlPWGJKL2FrTjEzZTRiRkdzUHZnejk5Z3hRellu?=
 =?utf-8?B?QjNQTlJ2cVNZaFRTMzJ3bEMzYlpkQWJRZVBqRXdaNkNZcUVUZ0kwV3ZKL2N5?=
 =?utf-8?B?MzFxVEZsYXFHSnd2L3gxNlFuN05uMVFjd1NyT3dFb295d3dNZWlBVVpXaUgw?=
 =?utf-8?B?TVJscFd3N0o5LzRoalVtdllWRi9wa0lhU1ZadU9HZWc3d0hXSlB0eFg4VEtx?=
 =?utf-8?B?VGMvYVFxNk90Y0tHWW13ZVNqMWt4RGpqcjRGNWNCcTVMaDVKaXo1MlRyZG5w?=
 =?utf-8?B?ZllYTFd1c01PT3Vtb0preXZhR01WbDFyYVgxRzJiYm5IM0NWL29KWVJwcHB0?=
 =?utf-8?B?UUZyMVBETHRmZTRZc0RnR2tLeU9kMkNkUWg0UktteE9TUjRSdmJmODU1TmZP?=
 =?utf-8?B?Si9jdktrU3FjamVLSTdKZWMvOXJkRXVmdnZySWMram1LL2xFNUVEZnhUVjRC?=
 =?utf-8?B?WHgvWW5qUG9Ka3k3RmpodDdKUlpXU2lVSENtSC9JYnRXWjR3eFNoZmNxaGg3?=
 =?utf-8?B?ODk1enNTUTBIRnRnSEdZUitHL1htWW5Ub0tpaEVxWENOOW9tRGE1M3ZZc2lN?=
 =?utf-8?B?VVd5OUxwZzZvYnVvWUxvTnh1aUtlN2ZrSzUrMHJ0RzJsaURoL0pWKzFCcG13?=
 =?utf-8?B?dEV0NGdxT1NDNjJnYW1zM1JWZDNIZC8rWFlaM2dvZS85NU9xRmhxQ2ViWkJo?=
 =?utf-8?B?UTc5ZnpuenlIaEZ6TDlIemt1bmhFaUlxUnBQY3kzS2lyeTRDSkdsTEg4L1g2?=
 =?utf-8?B?Y1h2L1pMbGhvVHJJbnRJR1NYQlFhY2FzTHVoMWtKY3VnQmdjQ3g3Szc5SkE2?=
 =?utf-8?B?NTJVdkhHdTUxU041em0yV2NwUitpVEJQRUtsbkJRRDRLanlxaEpDQkdjQmxz?=
 =?utf-8?B?aGlkaUZlMkord0loZkNBY1BTZEZaQ2xoSmo5d3JwenlwMG1WMnUwbUlocTFw?=
 =?utf-8?B?Q29BUTNWeHNYTkpuRTFMWURVd2FWa2R2eGp0b0pRc2NTMEtkY3M5RmhTV1k0?=
 =?utf-8?B?RjVhVXEwbXRlUnNsL2FVdEVTOUQ0MnpZKzZEcUFzWFFtNDcvQlM4VGlXSEZB?=
 =?utf-8?B?OUtYNTBXS1I1LzA5S2ZiYXFLWmY1ZkJ5a3JvanRqczlGaHV1YzJHWkJKZi94?=
 =?utf-8?B?RGdzMGpRODMzTlRtZGU4enhWRVVKSkpJb1JHYVE2TTl3QlBXWmhpRUJRY2VD?=
 =?utf-8?Q?vXyXS3yFmTVk0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B36E528D29291F4E890B71D81AE24640@POLP291.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c62a716c-45c7-469b-f7fd-08df464a67ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2026 14:35:49.4829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA2P291MB109571

VXNlIHBjaV9wb3dlcl90IGhlbHBlciBmdW5jdGlvbnMgd2hlbiBhY2Nlc3NpbmcgUENJIHBvd2Vy
CnN0YXRlcyBpbiBQQ0kgcXVpcmtzLgoKU2lnbmVkLW9mZi1ieTogSGFiaWwgRXJlbiBUw7xya2Vy
IDxoYWJpbGVyZW50dXJrZXJAaG90bWFpbC5jb20+Ci0tLQogZHJpdmVycy9wY2kvcXVpcmtzLmMg
fCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9xdWlya3MuYyBiL2RyaXZlcnMvcGNpL3F1aXJrcy5jCmlu
ZGV4IDdmMWY0N2VhMmVlNC4uZGU0MTNhMGZkYjBlIDEwMDY0NAotLS0gYS9kcml2ZXJzL3BjaS9x
dWlya3MuYworKysgYi9kcml2ZXJzL3BjaS9xdWlya3MuYwpAQCAtMjQ4Nyw3ICsyNDg3LDcgQEAg
c3RhdGljIHZvaWQgcXVpcmtfZTEwMF9pbnRlcnJ1cHQoc3RydWN0IHBjaV9kZXYgKmRldikKIAkg
Ki8KIAlpZiAoZGV2LT5wbV9jYXApIHsKIAkJcGNpX3JlYWRfY29uZmlnX3dvcmQoZGV2LCBkZXYt
PnBtX2NhcCArIFBDSV9QTV9DVFJMLCAmcG1jc3IpOwotCQlpZiAoKHBtY3NyICYgUENJX1BNX0NU
UkxfU1RBVEVfTUFTSykgIT0gUENJX0QwKQorCQlpZiAocGNpX3Bvd2VyX3RfZ2V0KHBtY3NyKSAh
PSBQQ0lfRDApCiAJCQlyZXR1cm47CiAJfQogCi0tIAoyLjQ3LjMKCg==
