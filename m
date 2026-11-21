Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795265959;
	b=GS98n7l9qCNAOriNOeV4qjcZSw+XZAkf3i36vyfcdYIc2A+bKcQmTlAmDzHvMHLfeQ+A
	 rZiVLhLaVytmq7lZX7+GVcXNxFSSU5y3gmcHlPYA90g9dXNGGB0LunVqpBSCR22NKhr33
	 6eIDHHakXUW25jJY0wsD2OEnHGxqsM2JyAwfLjLJ6H2gx+N0TyZo3vlMBCUU0WfqSaTTm
	 Vu+icAIQ8Y4mJpLfT+cTXvItRRw4rTVaL/iZ/wpNunQliG/XTCbUPy5Gi/BYn3X9iQEyi
	 cT6DCFdAMD05cxCcHrzbAxqM9udOS347zGSYlrXb3N/gb3aDCnid2UhPyQVJY7QJ59A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795265959;
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
	bh=yQnyivCG2C0casbEGhbKxTfLOU9Vet5YZCNFEoJvdPI=;
	b=AdmSfKxxYhNu4rLAtbuyBG5u4731/ChiwawUR66uxAW79IaXP42arcMTfz8mh+bnOOoy
	 BHxvQbg5HvAswApls5Dgz2++Zr81HguCRrNCcaIxa8PGLfcmpEc3m0b+wJJWUCVk893mZ
	 PnQw/FpQMkVSX14faP6GaVQ1atAhdiAgvWaCvr6LBaOtnAEE1UfkUfFYyJv7hcYy35Uff
	 BgiQGpEtvEjSJzdqRIAhAe4wqQCemP33W92BNPUsr0+GcCePc/nGWauUTAKi2BsgaWDDp
	 178+kYfXBT5af5SngQDPRolfEOc3cJwR0mOC6l0vMtkfSEA50rKmY/0P+L0UtV4f9OQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=lhBALcMN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.20
Received: from WA1P291CU004.outbound.protection.outlook.com (mail-polandcentralazolkn19010020.outbound.protection.outlook.com [52.103.53.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDC0606A33F;
	Sat, 21 Nov 2026 12:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FDC0606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=lhBALcMN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TNRx2zpVxeKBNMXlXgeeTsGQR7VXJ3CHz2D7yh6JGjHrHXPP2VH1Po0kdCq24EEnTQe4ZJrLKEjVElQNs+87+p+TAhEqJBKt3AWNby/UZP69FU5Ka/49ZHz/wVaBFKOZidlMLS4YgV4XcwbmUa4zZugRvGVLQRNDVS9Uac9H+pHr2PHktLnUJD8MS0PQw5ddwGTplLhsH0kN8XzWrDiT9myEiRc9g52f+tT1DJchS+I79Hc1IhXsDhTFB3YKhERuTcBd9HnDwxIyZ1YDE+48OMk5gSrd4LLy+iYaUui9rMj+486xmERGB49vDXY1HzC2iQeNOUWPPrM6rI23AHUKGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQnyivCG2C0casbEGhbKxTfLOU9Vet5YZCNFEoJvdPI=;
 b=uRhF2OWNGD7/QizYOH6SPDJX7sw7FV583PtFwmqziwj42is4i0A5ufWV1CkGvYjShvZ8WYAGkAztAqjISxFDea0agagdNdE8NIauvNWX276sphx/RuKySae6Ar/Uo53qpEDu3ifzRolgLqTndL6Ui5AkgMcHfV+eO1GE0G+0T52UEgcXHx3vcjaogHqayWaqT6o2oJNfrkahux2DEea+5Q3FMDjNSi/pEi2gJBc3HKnL1FWAs2b4uiaxYQ13Wscyit/5cccBRB+kL9fbIP+V0hTzmkMkg/ysKvFJNSo+r+eZV0GcaGD91LXf5xSBzAScYQl4HVq0UFd2k9fjmgT3Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQnyivCG2C0casbEGhbKxTfLOU9Vet5YZCNFEoJvdPI=;
 b=lhBALcMNpvKX/aY4wAyY6MLEH8wEldHVNk6wQa68noL9WNwro81carxrw9rpOV176KwD5twoSJDki+iJCA0Tx3aXwJ9MYv4MDbNvMusje431pGl7t8T4oVurJfbItlxeaRTDbvkyQFQyJtd6IQwe1pd589DdkGtnMUgbb3eFlsvtcdCRR7zkTN0Gqlz9QvJ6PsLkOb/iDAGWb1atC1TznMXHxisfKSQoRYfbKnN0/yuuoX743v6bfU828B4sL+1ihjFaALQMOlDsEOUX5h0X8DHQaaDEvLr62qEfshZ1PXUa38hzr5mW6nu3NVBiJvD7l/BmzoYjxooURgJUjM6Xyg==
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:26::11)
 by WA0P291MB0248.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Sat, 21 Nov
 2026 12:59:15 +0000
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404]) by WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404%6]) with mapi id 15.21.0639.011; Sat, 21 Nov 2026
 12:59:15 +0000
From: =?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?= <habilerenturker@hotmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "H . Peter Anvin" <hpa@zytor.com>, "andriy.shevchenko@intel.com"
	<andriy.shevchenko@intel.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?=
	<habilerenturker@hotmail.com>
Subject: [PATCH] PCI: Convert pci.c to pci_power_t helpers
Thread-Topic: [PATCH] PCI: Convert pci.c to pci_power_t helpers
Thread-Index: AQHdebgcYSmC18i6S0iW/AaAGRZ0IQ==
Date: Sat, 21 Nov 2026 12:59:15 +0000
Message-ID: <20261121125811.50315-3-habilerenturker@hotmail.com>
References: <20261121125811.50315-1-habilerenturker@hotmail.com>
In-Reply-To: <20261121125811.50315-1-habilerenturker@hotmail.com>
Accept-Language: tr-TR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: WA2P291MB0187:EE_|WA0P291MB0248:EE_
x-ms-office365-filtering-correlation-id: 663c9cbc-3202-4529-e3ba-08df47cf3f41
x-microsoft-antispam:
 BCL:0;ARA:14566002|38102599003|31061999003|24021099003|51005399006|15080799012|41001999006|8060799015|19110799012|8062599012|25010399006|55001999006|102099032|3412199025|440099028|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?WnlpM0E2cXVKSWFxcGV5blFOQUVIakxpVk56ZlBFTGlRK0VNQWR2a2Nsbkwx?=
 =?utf-8?B?KzVrd0p3RmFOVU9lSDFaM0M4dnhWbVN0MGluRytyeVJINjNkRDloc3VqUE5C?=
 =?utf-8?B?alFVS0QxWGVLWHhmN1phQVNub3JDd2Q3dmxOcDRGQWVZazF1QlZ2dzNudTJu?=
 =?utf-8?B?RlNROGhqU0RrTGZHR0UrTmo0M3ZWdU1TRkVMZW9ocjNDUlptTGVDTDRwMk1p?=
 =?utf-8?B?cEcrcXVOdkdSMUVRYm9QUGtTT2ozU2xaWkh6UkkxR2kzOW9xM0hvbEY5V09u?=
 =?utf-8?B?Yjd6T2JjZy90SXZIcnFYc0p3cUhQenU0SFFPNVY5N1cxb2hYZE5Kc2Mxa3c4?=
 =?utf-8?B?YUtXNFdhVjdnaHZLMERpL2NuUmpjQmloWWpId0xhV004aEJTZjR6a1NxSkxr?=
 =?utf-8?B?L3R5UERzZEk5U1dQTmU5c0s2akVHZWpGZmtwN3VSWEZpSm9GaFZsc09tQk43?=
 =?utf-8?B?TXVSdXN5a2JsbS9kdU4vVER0emdzMzNRN2VKaUliODNSV05EOXVBMEpCbS9R?=
 =?utf-8?B?WWI0eXZmYmpLanlJTnl3cHBnSSsyRDVpalRRcGd3QmdYUTMvcndSaExFTDJZ?=
 =?utf-8?B?Z3FFenJHc1JzUmcwbUlGWDdOWkxaU3pBWGFabkFsdkVwTUcyTU9INnNGbzFj?=
 =?utf-8?B?SmRmNFAzcXV4emhYdjVGZXlQb2JoYmFVeUVrNkw4a1dXdjFyY3pLbjZ2Wklk?=
 =?utf-8?B?aEpubVR5NVNTWHk0LzRJYzlLR2MrM0pPbzRybDVYUHU0Uko0cEdPU3Q1WTYx?=
 =?utf-8?B?NUZCVlNoODRpV1ZXTEl6b1FZaTdQcUZkTlNuMHFpMTlIbGxhSEIrL3dSMHl0?=
 =?utf-8?B?eDdaK1k4VFVmUW01STZ0b0Y2UHg5Q3plNXZDZUZkbWpIRFB2ZS9FRW1YME9U?=
 =?utf-8?B?ajcxRVFNY3NteEZoOXU4UTA0WStsaHl5QndTKzR4TzNYV0xXeGR6cWZzZVNa?=
 =?utf-8?B?VHRkVHQwZ25mczBvY1IrcVJjKy9uYW9LRDlyNi92U2lxRTBnNWloaU1pQUpN?=
 =?utf-8?B?VWsyTFFjRVJiOWFYMWJCNFc2MjdRbWR2ZnVTblJNZHBpYlFFMG9hZ0c1SHl0?=
 =?utf-8?B?NkhTNG5DTnF1TkRPeXF6bEFLeXFQRyt3aHBYa3dBdCtHdFZ0NW53QytsVWIr?=
 =?utf-8?B?ZjFQalpTV1U3Q3FWZmVFcFpHMjNCMDN2cmkxZzZoU2xFcDRCaXFTWHJKQ3Rv?=
 =?utf-8?B?VUpNbExGUUZWZXB4RXBVN2F1OHN6emVqUXVPVTcwS2krZFB2R0I3Wm9BZ0ZP?=
 =?utf-8?B?cVdEYVNhV3Q0Q1RpQjFIYU1kUGM0VmNmcHA0dHQramp2ak4zbXprbzh2UmpS?=
 =?utf-8?B?MFpUc0tiYmhoYk9sZjB3QStuWUxzVklqaUxydHhaOVZaUFlzazZNb3I3Qk1G?=
 =?utf-8?B?UlZ5T0ltWEgyTWNtRFJXWE1aUElscEdNV1NNcUJ0TWpRNzl3dlY0Mjd3RWl5?=
 =?utf-8?Q?cEa0f9XT?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Sm9KeE5FVXpGbzJLK1ZHTi9BMmJLZXlwbE9JZGFwcHhxRkJ6Snk4YjRVK3B1?=
 =?utf-8?B?eVFZeXFFZnVPUUJDd1NKdnphSGhOREFoaWc3SUZtNndCdVNrUi84aEkxWGNZ?=
 =?utf-8?B?M2F3cDdJUFZIMUl1bFpsRFJaaGp2b25kemN5RGREZGF3V2ovSzI2eHlXaFpu?=
 =?utf-8?B?R1RXci9qUDZLTUFLK0kyazhDd3V6MFBkMGRPYXRpS24vOUtvRWY3VUJBTDBR?=
 =?utf-8?B?TFR6NDZVNmIrR2ptVUx0ODVKT0JETUtwcFlldUxoMU91VGppdGl3Tzh2Smxm?=
 =?utf-8?B?SWZqbGVtNzBBVTQ0ME0wT0JNZlZaZm9TM0VzY0RsNmZBTFVya2VoZ1J1b3lt?=
 =?utf-8?B?RTdleVd3cnVDUnA3U2lFM3RBYUNqSXBDUWhIK3h4aisrMnBaODZJR2c0cTZl?=
 =?utf-8?B?OGVxZFFlUUFiaGZSUW94OVlDT0VOV2NiU2toQ3NTZWV3M3M5WS9WMlU3SmZk?=
 =?utf-8?B?WnFrSTd2emE3UHdQRFV6M0NoOHNXcmpyQWUveThZdjRadlZuSjJqbEkvUmRY?=
 =?utf-8?B?ZzkxdWhXTE9QSG1NQmNPUXp5YmpCcXVnblVGeWg2bVZINXVWQitjUjQ3eENT?=
 =?utf-8?B?N2R1bG1HNnU4UzY2aWkzMW0vSVJPMnR3Qjd0NVdXNkxZWm40b3dqdjYvQmhm?=
 =?utf-8?B?eGtLUkFvRktCSjBzSFIvNXpTUlpFMHN4TG9XUENoaHpaTzlpS1NweE9mK295?=
 =?utf-8?B?Y2hxS2NmdVJ0b0tZZ2xtQlNJZmdCeHU2SmlrRGtscXVxTmVXWmlUNGVMWVRt?=
 =?utf-8?B?ZnFSL3N4V3IrbFErdkc5OUx5TUtscUw4dmM2djZndXhTeS9lU2ppbG1VL2hn?=
 =?utf-8?B?TDMwb0k2d09BQ2JkTkorWXI4dW9zZHkzT0F6M3NhS0JiZEtEa1pINDBDRjhI?=
 =?utf-8?B?V2ZyUnhNSldxaG9PeUJOS3A2WllHVUZwWDhOektuSUVGdG4vRFA3ZXhkaVhC?=
 =?utf-8?B?dmdjREQxcDRNbzJmcG1TQmdtMXUxMUdwQlBJSzZoSWIvUEJQOHRHYXB0MzhL?=
 =?utf-8?B?WDdkcjRxSmRlUDNwMzQ1bEE4UjRKeVozc3dnRDlhN202QXdVMjZqK2FTbHpO?=
 =?utf-8?B?bjVJUVlBWUpsbXMzandQRS9TOGcyOU4zZGtQVGVCMDk0WHdjNTQxbzZRMXJi?=
 =?utf-8?B?bWRVVlN4a2hhZ3FwakJ3SElDWU9vbzJpL0NsNjVuYWlXZ1hmY0pqVGxRVDBj?=
 =?utf-8?B?QlMvcUh5eGtzWUlXdXU0WC8zUGRFSm1IRENxd3lwUXFSS0wxdjd3VXdoMVpa?=
 =?utf-8?B?Rk9oc2VXSU1tRTREZnA0eGU1RGZGdXZyWThlaURBTFpVTmVpWGhPWGZmRVZz?=
 =?utf-8?B?NFVBTXNJa3B1aHRsYS8xQ3NsbmE2NTZobkkzS28wemVCbDl4YkE2QVlGODBR?=
 =?utf-8?B?NU9FQjFtQy9SMmx1OWthbzFFZGw5bWdTTmlQdmhiZTJSOW5rY1hJMFVhR1VC?=
 =?utf-8?B?WUtpQUIvam1HNXI2UU8rMHFzNFJtT0htcnplYzU1MWJTQS9EazIwYTlLTUxP?=
 =?utf-8?B?T0hhRXlnR2xUZUx4djN1YnFTMW50UFJqUm9TS25ENHN5bVV1WUVKMHdYM0Fq?=
 =?utf-8?B?RnNCelJqWlZMazMwZnkvL21sbWlEVkNaNzU5VUdiUzdjcFNYb1UrR3NMd2Fy?=
 =?utf-8?B?ZVdJWC8zL1JKMlhmM05oeDdKdjVWMG9VMXVOTmlWMHZFTTBheXBjVGdEb0FK?=
 =?utf-8?B?VUZ5Yi9LSElDQWg3YWhZeW9iMjBqYksyaFhWZ3FHbEJOM1BnbTlQdFpUUlEr?=
 =?utf-8?B?MnpjTVhPUHdYSXh5dE9kcmpiNFIvUS9pT3dzVjc0djJTMHNLRlRYbkRSa1Rm?=
 =?utf-8?B?TkJyeUJPNW9QdWk5bXpXU1hRT2FSTDlrWERWSnFodm00aGd4NjdyMWVWMHpU?=
 =?utf-8?Q?LPtPxxUlh9pTv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <77BC73D7A1E4D146A3C99F020F6F9288@POLP291.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 663c9cbc-3202-4529-e3ba-08df47cf3f41
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2026 12:59:15.4834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA0P291MB0248

Q29udmVydCBQQ0kgY29yZSBjb2RlIHRvIHVzZSB0aGUgcGNpX3Bvd2VyX3QgaGVscGVyIGZ1bmN0
aW9ucwp3aGVuIGFjY2Vzc2luZyB0aGUgUG93ZXIgTWFuYWdlbWVudCBDb250cm9sL1N0YXR1cyBy
ZWdpc3Rlci4KCktlZXAgY29tcGFyaXNvbnMgYmV0d2VlbiB2YWx1ZXMgYWxyZWFkeSB0eXBlZCBh
cyBwY2lfcG93ZXJfdAphcyBkaXJlY3QgdHlwZWQgY29tcGFyaXNvbnMuCgpSZXNvbHZlZCBTcGFy
c2Ugd2FybmluZ3M6CgotIGRyaXZlcnMvcGNpL3BjaS5jIDogd2FybmluZzogaW5jb3JyZWN0IHR5
cGUgaW4gYXNzaWdubWVudAogIChkaWZmZXJlbnQgYmFzZSB0eXBlcykgKDQgd2FybmluZ3MpCgot
IGRyaXZlcnMvcGNpL3BjaS5jIDogd2FybmluZzogaW52YWxpZCBhc3NpZ25tZW50OiB8PSAoMyB3
YXJuaW5ncykKClNpZ25lZC1vZmYtYnk6IEhhYmlsIEVyZW4gVMO8cmtlciA8aGFiaWxlcmVudHVy
a2VyQGhvdG1haWwuY29tPgotLS0KIGRyaXZlcnMvcGNpL3BjaS5jIHwgMjggKysrKysrKysrKysr
LS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDE2IGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3BjaS5jIGIvZHJpdmVycy9wY2kv
cGNpLmMKaW5kZXggN2M2ZjJhYmE4MTQ0Li5kMzljODk3Zjc3MzUgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvcGNpL3BjaS5jCisrKyBiL2RyaXZlcnMvcGNpL3BjaS5jCkBAIC0xMTcxLDcgKzExNzEsNyBA
QCB2b2lkIHBjaV91cGRhdGVfY3VycmVudF9zdGF0ZShzdHJ1Y3QgcGNpX2RldiAqZGV2LCBwY2lf
cG93ZXJfdCBzdGF0ZSkKIAkJCWRldi0+Y3VycmVudF9zdGF0ZSA9IFBDSV9EM2NvbGQ7CiAJCQly
ZXR1cm47CiAJCX0KLQkJZGV2LT5jdXJyZW50X3N0YXRlID0gcG1jc3IgJiBQQ0lfUE1fQ1RSTF9T
VEFURV9NQVNLOworCQlkZXYtPmN1cnJlbnRfc3RhdGUgPSBwY2lfcG93ZXJfdF9nZXQocG1jc3Ip
OwogCX0gZWxzZSB7CiAJCWRldi0+Y3VycmVudF9zdGF0ZSA9IHN0YXRlOwogCX0KQEAgLTEzNjgs
MTIgKzEzNjgsMTEgQEAgaW50IHBjaV9wb3dlcl91cChzdHJ1Y3QgcGNpX2RldiAqZGV2KQogCQly
ZXR1cm4gLUVJTzsKIAl9CiAKLQlzdGF0ZSA9IHBtY3NyICYgUENJX1BNX0NUUkxfU1RBVEVfTUFT
SzsKKwluZWVkX3Jlc3RvcmUgPSAhKHBtY3NyICYgUENJX1BNX0NUUkxfTk9fU09GVF9SRVNFVCkg
JiYKKwkJCShwY2lfcG93ZXJfdF9lcShwY2lfcG93ZXJfdF9nZXQocG1jc3IpLCBQQ0lfRDNob3Qp
IHx8CisJCQlkZXYtPmN1cnJlbnRfc3RhdGUgPj0gUENJX0QzaG90KTsKIAotCW5lZWRfcmVzdG9y
ZSA9IChzdGF0ZSA9PSBQQ0lfRDNob3QgfHwgZGV2LT5jdXJyZW50X3N0YXRlID49IFBDSV9EM2hv
dCkgJiYKLQkJCSEocG1jc3IgJiBQQ0lfUE1fQ1RSTF9OT19TT0ZUX1JFU0VUKTsKLQotCWlmIChz
dGF0ZSA9PSBQQ0lfRDApCisJaWYgKHBjaV9wb3dlcl90X2VxKHBjaV9wb3dlcl90X2dldChwbWNz
ciksIFBDSV9EMCkpCiAJCWdvdG8gZW5kOwogCiAJLyoKQEAgLTEzODMsNyArMTM4Miw3IEBAIGlu
dCBwY2lfcG93ZXJfdXAoc3RydWN0IHBjaV9kZXYgKmRldikKIAlwY2lfd3JpdGVfY29uZmlnX3dv
cmQoZGV2LCBkZXYtPnBtX2NhcCArIFBDSV9QTV9DVFJMLCAwKTsKIAogCS8qIE1hbmRhdG9yeSB0
cmFuc2l0aW9uIGRlbGF5czsgc2VlIFBDSSBQTSAxLjIuICovCi0JaWYgKHN0YXRlID09IFBDSV9E
M2hvdCkgeworCWlmIChwY2lfcG93ZXJfdF9lcShwY2lfcG93ZXJfdF9nZXQocG1jc3IpLCBQQ0lf
RDNob3QpKSB7CiAJCXBjaV9kZXZfZDNfc2xlZXAoZGV2KTsKIAkJaWYgKCEocG1jc3IgJiBQQ0lf
UE1fQ1RSTF9OT19TT0ZUX1JFU0VUKSkgewogCQkJcmV0ID0gcGNpX2Rldl93YWl0KGRldiwgInBv
d2VyIHVwIEQzaG90LT5EMHVuaW5pdGlhbGl6ZWQiLApAQCAtMTM5Myw3ICsxMzkyLDcgQEAgaW50
IHBjaV9wb3dlcl91cChzdHJ1Y3QgcGNpX2RldiAqZGV2KQogCQkJCXJldHVybiAtRUlPOwogCQkJ
fQogCQl9Ci0JfSBlbHNlIGlmIChzdGF0ZSA9PSBQQ0lfRDIpIHsKKwl9IGVsc2UgaWYgKHBjaV9w
b3dlcl90X2VxKHBjaV9wb3dlcl90X2dldChwbWNzciksIFBDSV9EMikpIHsKIAkJdWRlbGF5KFBD
SV9QTV9EMl9ERUxBWSk7CiAJfQogCkBAIC0xNDMyLDcgKzE0MzEsNyBAQCBzdGF0aWMgaW50IHBj
aV9zZXRfZnVsbF9wb3dlcl9zdGF0ZShzdHJ1Y3QgcGNpX2RldiAqZGV2LCBib29sIGxvY2tlZCkK
IAl9CiAKIAlwY2lfcmVhZF9jb25maWdfd29yZChkZXYsIGRldi0+cG1fY2FwICsgUENJX1BNX0NU
UkwsICZwbWNzcik7Ci0JZGV2LT5jdXJyZW50X3N0YXRlID0gcG1jc3IgJiBQQ0lfUE1fQ1RSTF9T
VEFURV9NQVNLOworCWRldi0+Y3VycmVudF9zdGF0ZSA9IHBjaV9wb3dlcl90X2dldChwbWNzcik7
CiAJaWYgKGRldi0+Y3VycmVudF9zdGF0ZSAhPSBQQ0lfRDApIHsKIAkJcGNpX2luZm9fcmF0ZWxp
bWl0ZWQoZGV2LCAiUmVmdXNlZCB0byBjaGFuZ2UgcG93ZXIgc3RhdGUgZnJvbSAlcyB0byBEMFxu
IiwKIAkJCQkgICAgIHBjaV9wb3dlcl9uYW1lKGRldi0+Y3VycmVudF9zdGF0ZSkpOwpAQCAtMTU0
Niw4ICsxNTQ1LDcgQEAgc3RhdGljIGludCBwY2lfc2V0X2xvd19wb3dlcl9zdGF0ZShzdHJ1Y3Qg
cGNpX2RldiAqZGV2LCBwY2lfcG93ZXJfdCBzdGF0ZSwgYm9vbAogCQlyZXR1cm4gLUVJTzsKIAl9
CiAKLQlwbWNzciAmPSB+UENJX1BNX0NUUkxfU1RBVEVfTUFTSzsKLQlwbWNzciB8PSBzdGF0ZTsK
KwlwY2lfcG93ZXJfdF9zZXQoJnBtY3NyLCBzdGF0ZSk7CiAKIAkvKiBFbnRlciBzcGVjaWZpZWQg
c3RhdGUgKi8KIAlwY2lfd3JpdGVfY29uZmlnX3dvcmQoZGV2LCBkZXYtPnBtX2NhcCArIFBDSV9Q
TV9DVFJMLCBwbWNzcik7CkBAIC0xNTU5LDcgKzE1NTcsNyBAQCBzdGF0aWMgaW50IHBjaV9zZXRf
bG93X3Bvd2VyX3N0YXRlKHN0cnVjdCBwY2lfZGV2ICpkZXYsIHBjaV9wb3dlcl90IHN0YXRlLCBi
b29sCiAJCXVkZWxheShQQ0lfUE1fRDJfREVMQVkpOwogCiAJcGNpX3JlYWRfY29uZmlnX3dvcmQo
ZGV2LCBkZXYtPnBtX2NhcCArIFBDSV9QTV9DVFJMLCAmcG1jc3IpOwotCWRldi0+Y3VycmVudF9z
dGF0ZSA9IHBtY3NyICYgUENJX1BNX0NUUkxfU1RBVEVfTUFTSzsKKwlkZXYtPmN1cnJlbnRfc3Rh
dGUgPSBwY2lfcG93ZXJfdF9nZXQocG1jc3IpOwogCWlmIChkZXYtPmN1cnJlbnRfc3RhdGUgIT0g
c3RhdGUpCiAJCXBjaV9pbmZvX3JhdGVsaW1pdGVkKGRldiwgIlJlZnVzZWQgdG8gY2hhbmdlIHBv
d2VyIHN0YXRlIGZyb20gJXMgdG8gJXNcbiIsCiAJCQkJICAgICBwY2lfcG93ZXJfbmFtZShkZXYt
PmN1cnJlbnRfc3RhdGUpLApAQCAtNDU5MCwxMyArNDU4OCwxMSBAQCBzdGF0aWMgaW50IHBjaV9w
bV9yZXNldChzdHJ1Y3QgcGNpX2RldiAqZGV2LCBib29sIHByb2JlKQogCQlyZXR1cm4gcmV0Owog
CX0KIAotCWNzciAmPSB+UENJX1BNX0NUUkxfU1RBVEVfTUFTSzsKLQljc3IgfD0gUENJX0QzaG90
OworCXBjaV9wb3dlcl90X3NldCgmY3NyLCBQQ0lfRDNob3QpOwogCXBjaV93cml0ZV9jb25maWdf
d29yZChkZXYsIGRldi0+cG1fY2FwICsgUENJX1BNX0NUUkwsIGNzcik7CiAJcGNpX2Rldl9kM19z
bGVlcChkZXYpOwogCi0JY3NyICY9IH5QQ0lfUE1fQ1RSTF9TVEFURV9NQVNLOwotCWNzciB8PSBQ
Q0lfRDA7CisJcGNpX3Bvd2VyX3Rfc2V0KCZjc3IsIFBDSV9EMCk7CiAJcGNpX3dyaXRlX2NvbmZp
Z193b3JkKGRldiwgZGV2LT5wbV9jYXAgKyBQQ0lfUE1fQ1RSTCwgY3NyKTsKIAlwY2lfZGV2X2Qz
X3NsZWVwKGRldik7CiAKLS0gCjIuNDcuMwoK
