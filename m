Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795266759;
	b=0cp4m0DCMeN1mejrqTgoHKwlORPWKAG0OrcZnRwzBDKIrkaz5ojlJhmxXeEM5FQQqqyN
	 /l1fgjOuE3tscYKG8mSk18aQx23gAX2zr4CHZCgRA8nZu0vZnferojqBTfVmj3fzrObKw
	 gLasXnnMOe00nbumxtgftACJy88q4T+qJ5YJ2lvflJ6qDPXU9WN7vqNEhP/OTWiyO9NED
	 Sk/3h+y9jQYhMgMLBKl44jBfllAjssK46+z6WAOy3kSp25ObJ8/A6GSRKW251/Vkga051
	 Q5tpYL4ykRZ7QuZw5qIJD0TViV+w+AKmolP9c9n/fpR8079pecb9Y+vJ3Av9XHK5p9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795266759;
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
	bh=a7TtoXAGrLGvZNFiUnlI2pdg5OXyBDuwUTrMYlPtVyg=;
	b=Z4lKZYFFu+rdKGKx00xGDZYCTbfEBJvP9QfTYn7QxZ6ITXPWCZ6L2xEzBZ80hEIH3sgU
	 KC9/AUfMN0ygHJK0DOcCBQ6MQ8USrW8e4ekMpjvD3SxVESSWeoRoRBwMJ1Z7v5lEd9RsC
	 zUGvT4vLpTbHxheeAZKqYS0S0YqNs4w457CgwAw34VSV3J31Pg1pRKUjmvTj0GFPo44gj
	 /35IUzHo6KC4tjMUFagNOg/BDiN54UeEwJuDIlkUFJQ36CpEIJDQ8uTFwSIyh9cBwAG1m
	 EC2pUMH7Y4iY99iHuIjkzUvCrKesFPcayXB8Jm4fH3mBYc52lCv99RCPA4fSE6esliA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=eGY4PoJz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.23
Received: from WA1P291CU004.outbound.protection.outlook.com (mail-polandcentralazolkn19010023.outbound.protection.outlook.com [52.103.53.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B14606A693;
	Sat, 21 Nov 2026 13:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83B14606A693
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=eGY4PoJz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kB5fW33M6yWD3QVMkTgVzYk/apW3lSb1tJA6JgfoPy+IqRJ6PB8h6JLVwGQj23FcLoJz4FS2S/Pbau643mLuuMiDIzMGUpKH9kP97Efb0qzbr5ywyIGN4O749d4JAc0Hv8rXvAJJ6OMknv5wKP50DMhNhdAjoIwJTUNBcCR/CVv2x+F23VyT3kaRHX4P/utAFm8mQ7zP5oV+8VdmA3RJfRjaxPQhJx8IVqkPw+RBiZSZhueRCHoCIQMOyqxYPINucfxqw3yNZapO96IlXyMFtFBjtwIP+gHdHhC7Nu/WB7wUHmCuvvkqfacE7VS3GrtQO0u7pizZzMdpw4GTHM2EzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7TtoXAGrLGvZNFiUnlI2pdg5OXyBDuwUTrMYlPtVyg=;
 b=UOU5sx8PdaUqXtN7KOui9mFuHuOLG9ZrDFHYyQz04E918vbBRDKHa90ZfZlkJNUyYm2ZXy8y6Ndv0XG7Ffzdxbf3O/xEkzAX48qmWz5/D1wBgBlPFSgI9goHUU3AefiNGLbUM2NKgOTH/p3I0PO8K397FwfLn6mJuqeEEUBK4VQio1oxnGS4qhrj/moPtVDlmOwnfTxMcQ02ykBuK0i8uJ3lt8X1V6h55X2jGByu2SwvvzToW3Hi3aHytiKR7lEjItPD4ilVsxQuyOoqSj4xwVgLPhpBngt9XpBXW5vFQBpLzOH+FRazgHh0gp3XZnss+07gilFZlyE0TySt8E24Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7TtoXAGrLGvZNFiUnlI2pdg5OXyBDuwUTrMYlPtVyg=;
 b=eGY4PoJzYRMaJawlK52ywfYYQLqWBZyJsvMIIQOC0jMnIDndOcJwxw3pJMeMdqWijP5TeW8u/dS8YXmKsp1PXsn5i6qOrRj6tj+vNX7RrnxYAyLuh4m9TyilyMu7hN1nBlbqS5Fg2Agdi7YFUebMRkNeXgdKCZiVbaymzjC3ugLl8DWaJKHTt7c9AZfuSpvGUSpo6InhhNSDubDWC/YB32UlaeWkYXusnzvKpuvmMPN19L/GUMIXM5vddyRssHtFvcoA8Jx6zmJoxIZMeT5kFhKxTsrM4x5MeUKPYU+/efzKjCJkqnI5Mv4gJKO1OvJhesjE19ygNyqpRKoB1etibw==
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:26::11)
 by WA0P291MB0097.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:5::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.13; Sat, 21 Nov 2026 13:12:35 +0000
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404]) by WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404%6]) with mapi id 15.21.0639.011; Sat, 21 Nov 2026
 13:12:35 +0000
From: =?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?= <habilerenturker@hotmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "H . Peter Anvin" <hpa@zytor.com>, "andriy.shevchenko@intel.com"
	<andriy.shevchenko@intel.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?=
	<habilerenturker@hotmail.com>
Subject: [PATCH v4 3/4] PCI: Convert quirks.c to pci_power_t helpers
Thread-Topic: [PATCH v4 3/4] PCI: Convert quirks.c to pci_power_t helpers
Thread-Index: AQHdebn5hyg8bTdV0UOngF0hrIp0WA==
Date: Sat, 21 Nov 2026 13:12:35 +0000
Message-ID: <20261121130936.53191-5-habilerenturker@hotmail.com>
References: <20261121130936.53191-2-habilerenturker@hotmail.com>
In-Reply-To: <20261121130936.53191-2-habilerenturker@hotmail.com>
Accept-Language: tr-TR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: WA2P291MB0187:EE_|WA0P291MB0097:EE_
x-ms-office365-filtering-correlation-id: 8a3988da-2c57-4e45-48d4-08df47d11c30
x-microsoft-antispam:
 BCL:0;ARA:14566002|38102599003|41001999006|15080799012|8062599012|8060799015|19110799012|31061999003|2604032031799003|55001999006|24021099003|16051099003|25010399006|51005399006|102099032|440099028|3412199025|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?WTM1NWZLTE5WMjJQWmp6NDNmZ0hINGZLbzNnRXJYQ1NYSDJUc25ZekkzTjVu?=
 =?utf-8?B?ZUtTSDRMWklmMGtWeFhkY1ZVR0FlL0U2bzNhVjR5UzZyQVdNbTlNVnc2SWE2?=
 =?utf-8?B?WkNRZS85ZUN3Vm9JK2lmTXMzQjY5UU1FTlNMaGNIbkJ2M3dUNjlJWFJBeVBN?=
 =?utf-8?B?Ynd1bTEzUVhUeE5BVHZVcW1PdDh4bnRQZ2Zwb0lIVGlHQkVwUnpUZ2Fxa1Qy?=
 =?utf-8?B?bTNrdGhoZ2NIb2JWWnNFQmEyOFhOMlV5alhhZGZCZVJzdlJleURBUTdTVU1Z?=
 =?utf-8?B?Z2Q3T0RtblhWTmNYM2EvdHh2V252Vmp6Nml6Z21XQUtwT1R5Tkh2bElScU0z?=
 =?utf-8?B?eDlJRk5oeG9XbkhWL2pMQXN5cW9kWkhQWlVlU2NTU0lMZDdvbVQ3WFZjYXV5?=
 =?utf-8?B?YUpoaSsyU2g1RmZLUU9jT0pyNUk3Wm9iRExla0hZbW1XR29tdlUxWXZFZ2hz?=
 =?utf-8?B?SmdZaEVaQU8rTUVUSGxKck44dzF1VG5wREdUZWNhWkxzY0VIaWxucHN1NTJO?=
 =?utf-8?B?RUdybGM3MGw4akNqVklFSlhab3J1bG1Cd0x5SEoxTXd1S2FoZ1V4Q1NWZW5z?=
 =?utf-8?B?R2F4dTduZ3VhZm10MXJqYXNGd3FpNTFaUzJYR0lFQ2JBMlRKSDhobVhzbVVm?=
 =?utf-8?B?RXBqaGU0UThONXJNU1Qyb3A4TEx1VTdKeGtIVTdDdkw1UkhyVE5qSHd6M2Y5?=
 =?utf-8?B?MlcxMTd0eWJuZ2NZcXloNUhhcGhwNVNpT00xWjhxcDQwUW9KRkxXWFJidzBy?=
 =?utf-8?B?SjFZaytIby9sRTUzOGV1dDJvUDZYRXFyYUdLZ1RzRGllL2JlaEV6UUNXcVRG?=
 =?utf-8?B?MnFEVmdqWW0vb3RmWUljNzMycHI0VWk4aDd0MzloSHVvdGhITjI0bmpVN01I?=
 =?utf-8?B?a0J5MldoMlpGYzhBT3lCSTg1SmU1S21NU09kMENtMkNySTJZRVBRWTVKc094?=
 =?utf-8?B?L1RMbGo1ZTZsQXJudVZTeldNTk5kWTBKM3huU1N6Y0UvdlJjZlQ1bWFFNzRD?=
 =?utf-8?B?cGw0Nk9TMGpZQ0s0LzNsbDU0ejR2N3lCTklkNG5XSXhwTWR0U01MaEFIN3V3?=
 =?utf-8?B?b3hxSTI4MGNZTHdHUTIvT09RS2R0WFZ6YmJhK3QvUElnaDdoNmxDcVpHTXZP?=
 =?utf-8?B?aWdKai9QSkx4ZW1GNXFJL1U4NWpRRG5VM3RJMS9pUmtkUkRKYW9zYzZhclBT?=
 =?utf-8?B?dmx3SmMvT1JhV1czVTRrS1l1Tjk4dURqSnpmeGJ2Z1pQQ1ZURE05UXVEZm1k?=
 =?utf-8?B?Sk5ka0xhRGQ2Z01YN3BwandNMVZqVXduYi96U2hqNXJnUDJzTU9QMVB0Zng3?=
 =?utf-8?B?YXgvTGY3aDJtME45WE1NN1VVV1lxejZUY2Z3OFVlbDZqWFh3akRITW1mQUZM?=
 =?utf-8?B?ZjhaYlpwSUovNzFnaVVNOWU0RHhHYnZ1WXpBdnpJVnNVUE9SM3c0eFFKVGRG?=
 =?utf-8?B?dXRLSEdWNkVBbUFaaHJGYVl6MFY0ZktycEFrdlR4U0lqM1gyazh5bHplWDhO?=
 =?utf-8?Q?SOA9RDa8gKQrkG8vJBToH/tWY98?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Slc5YmhRcno2bmhrZm4vQ0tTQTdRaWhrZXhFL0tsSEltQjNabVdWUUd3UDA4?=
 =?utf-8?B?UUZpdUpJS3NSUDNzZTRZTG8vYS9SeHNSN205WnpBVHBWRGwxbnhraTd0bW91?=
 =?utf-8?B?ZThSVTJ3anJQQ2xlL2dEWG9DK3h1UUNHcXNkakM3SHZwN0NUM1NSSnBvSmlV?=
 =?utf-8?B?QU13cVFIQy8vZllzMFRIc2pvckhLTS83TTZJdGtvMkEzbUo4eER5cXpqOE0v?=
 =?utf-8?B?VG96R3ZGNEJhWU1CTU5JSFZabXpIOGFleDBDMWxOaWkrRjZkYWZBb05nbUMy?=
 =?utf-8?B?bXhHUzVDaG5zY0drZkN4dzNwcGV1c21mY3JXdm9MTjVpNm5YSklJSkxFaEY5?=
 =?utf-8?B?dkRGOFFucUdUc3lTZUVzUnFEMk9jeHZuSEZsajJpeWVMZGU5VHhqelBWbG90?=
 =?utf-8?B?TFJRR1ZjNjFzK0xwL2daZXRLWmhOZm83eUVMMzFXSkRxVGpTK0NwNzNZZnha?=
 =?utf-8?B?aUovWHBpWWlzRnNGYmE1MkNlS25LS29TRVp4aFFSYzhiY29VbDlOZDlhdFVF?=
 =?utf-8?B?SzJNV3hnVloxR1lWZXJZZStIOXhwMFdROHBwbkdLTnpwamt3ZExzci9NZzdX?=
 =?utf-8?B?eUNUQUczb25aR3pDbEVabVp2MURFUEpBa2FBaDhqRFdiQTI1SkorS3I4MXZa?=
 =?utf-8?B?akhidjVzT1R4TmJobHFtcWVjbm9zcTVFNzR5QURocWNTdTRJVnBvRVVYeFJs?=
 =?utf-8?B?VVFyWEV0aDhMM2F4K2FpYkp6U1NscnprNjg1bTNwT1o0ME1PRkZGMnBwKzFK?=
 =?utf-8?B?czNzcGR6K2FJa3F6cm9yYXBTSnBzM2gvUUpRbjQxVk5XQTZlb3RqZGhDMHZo?=
 =?utf-8?B?ZTdLVU5XaTVQckNOQVRNN0hJRVVaUmh5dDVsakw1M0trYjl2NHZMWnVnYkN6?=
 =?utf-8?B?NHRNMlYzWHVrM3FySi9qZTkxckZSN1JDTVBvQXhrd1dYdEV1RmtmSHlxZDNw?=
 =?utf-8?B?M1pQREpUWVg0TGZsZ2dGV1V5ekFzZktkZ3BDV1hmWEt4SjdMWXQvSlNLeHBm?=
 =?utf-8?B?YjZ0NXh6amhTSXdvZW1ycWVuWmo5cFIzQ3Z3WUhXTURwY0UxZXZ1NXdldmhr?=
 =?utf-8?B?N3VSOEpScTRkYTNOdDR3N1c4RUhSM2wxMUxlQUFic1Bqa3ZRSlVFQnVuWE80?=
 =?utf-8?B?SEVUVG5jcThKcHVhZkVBT2FrTlhUUnRDeFdCMjFGTzhzTDcwN3RST3NwSEdV?=
 =?utf-8?B?aW9CY3I3ZzU3ZG1ob2Z0OVQ0dnBlNHQ3YzVoZGhJa2tndllsTHdhcGtKTDlw?=
 =?utf-8?B?SldOZFpZWTZWZTNYVzRrWVFsbUhSMHplelJvWk1YWU43cURkeE5qcXNZb2hF?=
 =?utf-8?B?eUM3TEdiVmVobitkLzdEQ3RHMFFEOWtLYWJHYXErWXZxZHZ0cGlWMVV4TU1U?=
 =?utf-8?B?RENCOEd1aFhCSXlXRDhWV1NlUVEvUFhFWFpVS1Vjc2o3Y25McFAzOVhZN2x0?=
 =?utf-8?B?dFIwZjU3ZG44aVgzTE91NW5zZjdpYmRLTDhjU0dMR2h1dzdMWFlVaW1GOE05?=
 =?utf-8?B?eXhlMG5RMkF5Y1JTem9Wd2U1b1hxYmJMUld5ajd1OG0xNU9qMzg1NHFDSlRu?=
 =?utf-8?B?STlwcTdPMEFQSHJpd0laZERjcEFhZk1Odlp5TUtLU1psdzd2aU9HOVRLOUZz?=
 =?utf-8?B?Tnk5YVRhcjZnL0xJMnFYaGdXbHY1TklrdjNsVStKbHRYS0pDRHBXS0o1UzYw?=
 =?utf-8?B?OW1jYXVaQUdaSkp5bFRZU1dIZlVKc2l2djRleU9zUmFDbDBnVjM4VStxV2Mv?=
 =?utf-8?B?eUpYV1lzSEdtUnBBQnVqV2lrckRoSzVaQXJWdUg4TE1MSUNRYmVsWjc0TnBW?=
 =?utf-8?B?ZWJKU1RXRHo4RnFmTTZ3R1dZQVVRUUdTbmIyZVU2Q3F3L0Z4SjByVVRsVzIv?=
 =?utf-8?Q?9qZW/aUe4OWA5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3DE326536CA334D955F79954B826F7F@POLP291.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3988da-2c57-4e45-48d4-08df47d11c30
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2026 13:12:35.6376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA0P291MB0097

VXNlIHBjaV9wb3dlcl90IGhlbHBlciBmdW5jdGlvbnMgd2hlbiBhY2Nlc3NpbmcgUENJIHBvd2Vy
CnN0YXRlcyBpbiBQQ0kgcXVpcmtzLgoKUmVzb2x2ZWQgU3BhcnNlIHdhcm5pbmc6CgotIGRyaXZl
cnMvcGNpL3F1aXJrcy5jIDogd2FybmluZzogcmVzdHJpY3RlZCBwY2lfcG93ZXJfdAogIGRlZ3Jh
ZGVzIHRvIGludGVnZXIKClNpZ25lZC1vZmYtYnk6IEhhYmlsIEVyZW4gVMO8cmtlciA8aGFiaWxl
cmVudHVya2VyQGhvdG1haWwuY29tPgotLS0KIGRyaXZlcnMvcGNpL3F1aXJrcy5jIHwgMiArLQog
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9wY2kvcXVpcmtzLmMgYi9kcml2ZXJzL3BjaS9xdWlya3MuYwppbmRleCA3ZjFm
NDdlYTJlZTQuLjQ0MTdlZDY0MjJhOSAxMDA2NDQKLS0tIGEvZHJpdmVycy9wY2kvcXVpcmtzLmMK
KysrIGIvZHJpdmVycy9wY2kvcXVpcmtzLmMKQEAgLTI0ODcsNyArMjQ4Nyw3IEBAIHN0YXRpYyB2
b2lkIHF1aXJrX2UxMDBfaW50ZXJydXB0KHN0cnVjdCBwY2lfZGV2ICpkZXYpCiAJICovCiAJaWYg
KGRldi0+cG1fY2FwKSB7CiAJCXBjaV9yZWFkX2NvbmZpZ193b3JkKGRldiwgZGV2LT5wbV9jYXAg
KyBQQ0lfUE1fQ1RSTCwgJnBtY3NyKTsKLQkJaWYgKChwbWNzciAmIFBDSV9QTV9DVFJMX1NUQVRF
X01BU0spICE9IFBDSV9EMCkKKwkJaWYgKCFwY2lfcG93ZXJfdF9lcShwY2lfcG93ZXJfdF9nZXQo
cG1jc3IpLCBQQ0lfRDApKQogCQkJcmV0dXJuOwogCX0KIAotLSAKMi40Ny4zCgo=
