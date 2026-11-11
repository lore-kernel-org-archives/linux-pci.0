Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.140
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794358379;
	b=Gney6gfjG6DXnN2IdHrgyAmFsbbK0vyH4TmiygbmXFktk3iR+W7f8xc0JJtmF81PnrWF
	 oF2KxArMg+poLQzr4GCEzvbwT71t309Xf+dLuh6IoPL2YfdFLIExb1duUqUPeFppXKxup
	 WaWua3dmYIw6tgpKBUhmWD+H0S1GqsetbulGivNgl+VYUxAsVxF7CSydK25eBMUk3/Fpf
	 oaFklkcZo0pPsY82PQ45MaGN9rV948bSp12pv1YuDjx3TuG1OJrbPdFubkqMBhCSTFasE
	 XCxw1i43z9E8B6c7EdvN8Fdz++J1GvgwrZly6q+/UxmPxunfE1i6LYRhtRQJpfqXXgw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794358379;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 drawingcanvaselements:composetype:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-atpmessageproperties:x-ms-exchange-senderadcheck:
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
	bh=YXZ1RBMLuzCK7yik4xpMRJs5UUDXkFtHDZ07CerhL2Q=;
	b=RvQiqZq1gPMYGVuW9KEOIbz51ljEzNuxpDnevNuSPYJhNz094iOlmnvil0oGDsEfEB+U
	 gnISD4bJfgneX+IxE7B9mEfFxfw1eVVCV7Ws1GTt5kli6FcsSDh/d5/cUdetaf+3b2YWD
	 PMz3EKeL1l2l1EjQxvvNAjJrbM/F9l0RB1ziVNnq7tNadR2oIZqXnGtezb1a+KoOtDSAu
	 v1L8vsnmYh+dzj4EwqSCEichAUF/hFp8FL4lEr2Jwh/Hxx6WAMsbpfNEQpMqxjAymcpJd
	 OxqHpXphHr17XJH3/5ekZnlrwNRQhlGLC0RmAtju9vVcLpjeLRO/tKGvaPt8hmnKu1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=diodes.com;
	spf=pass smtp.mailfrom=diodes.com;
	dkim=pass header.d=diodes.com header.i=@diodes.com header.a=rsa-sha256 header.s=selector2 header.b=LKvWGxAO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.140
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022140.outbound.protection.outlook.com [52.101.126.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28C7606A320
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 00:52:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D28C7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=diodes.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=diodes.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=diodes.com header.i=@diodes.com header.a=rsa-sha256 header.s=selector2 header.b=LKvWGxAO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tc3/87UnRcSyQU+vwxarGPQAAmPcchCMeN3T5g+tqv0lyw9+rjtDU7j8nShXKckOzDpnRqEBLLKb7i7kY71KSqu9DIMkhQxZ+Bu3OTvQGncLmuVEBXH2aJl4jamVczoAO1a8G0SOglqpNxOkQHVdU8RsSZmgIYArM86R+Y9zeGW2HjFxs4reffmPD5EVAoG9BUYLWPCVcMeY/gxhGaIZ9k9WsEE044NvuZv/23ubdWz/G/3mjC9+i8SJVO5/Eb2cxcDG0twfNHjCs6oWDReLQoFNAW1+KtTu7rm26ulyEki5/wZzesHg//JsKpdaT23ZRY5zf5bvfn9HMVzj5RzSJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXZ1RBMLuzCK7yik4xpMRJs5UUDXkFtHDZ07CerhL2Q=;
 b=N7jDkR0SrhRODA80qIaiwYLq/mIKKGSinlkWMrMZ6CyDW7Zy7nLxMPxIhf6TCEghougK8N3f5F7Yg0bUL/4A4p1OKG2FVcvYuH4onymkUGCRWmDX/9esIWTIlz9Mnvj7DgH3Bl2WgmKNMiJIDZWlpbYesc/M0nwvizx90y/28LbEevJ4ngEa4jhN5agHA7L11lfTYXD7fPEHFT9MT50+crSzHz1IP7LnCHXaFpSMBAJUkIrLTKdIYmnWRKt6EyLeXPyV5CAtpcJSk/dXwmy1NxNAKJaIxZ0/QErJFH53Iu1qdehJILMz3ghGpvmq1Mg+UMM0x1lATJKUZkTHNYhnhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diodes.com; dmarc=pass action=none header.from=diodes.com;
 dkim=pass header.d=diodes.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=diodes.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXZ1RBMLuzCK7yik4xpMRJs5UUDXkFtHDZ07CerhL2Q=;
 b=LKvWGxAOi4/Oy0AvWlpIwjtr0hISVlNEWeqCGVbtoozaizhtvXzIy73Ua6PjAAdsuxITq9Ixq8dQuAqX/+sakYLHqRbRuwElGtyhqZpywM4AA7lyScLik+jBNZ8rBLDHfNvY+GwtXUlA6/IsSVEXIBx2dimeSE/Jktrr7G1ckvsOV2yUr7xBKjGRMD/FnB1c2CAK8CVJikEQxHgOdw8Kx97vyMQ77opdwPXiluN65sR6aQRjgUFgwOLCJi4BZav/G8J4UfweDX6G5tn//UVQ7DOuZNTBPL3EKHoqdPxJet7RM8TqXhQ+19pu3HZTyZ4ynaqnnfJNzV17xj8FRcND6A==
Received: from JH0PR02MB7011.apcprd02.prod.outlook.com (2603:1096:990:52::9)
 by SEYPR02MB6605.apcprd02.prod.outlook.com (2603:1096:101:1ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Wed, 11 Nov
 2026 00:52:52 +0000
Received: from JH0PR02MB7011.apcprd02.prod.outlook.com
 ([fe80::a44:f104:f70e:56c7]) by JH0PR02MB7011.apcprd02.prod.outlook.com
 ([fe80::a44:f104:f70e:56c7%6]) with mapi id 15.21.0592.012; Wed, 11 Nov 2026
 00:52:52 +0000
From: =?utf-8?B?U2ltb24gQ2hlbmdb6YSt6YeR56eJXQ==?= <simon_cheng@diodes.com>
To: "sashiko-bot@kernel.org" <sashiko-bot@kernel.org>, Nirmoy Das
	<nirmoyd@nvidia.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject:
 =?utf-8?B?5Zue6KaGOiBSZTogW1JGQyBQQVRDSCB2Ml0gUENJOiBXb3JrIGFyb3VuZCBQ?=
 =?utf-8?Q?ericom_PI7C9X3G606GPC_Port_4_BAR_erratum?=
Thread-Topic: Re: [RFC PATCH v2] PCI: Work around Pericom PI7C9X3G606GPC Port
 4 BAR erratum
Thread-Index: AQHdcXY0CndfqWg3GU6FbBhaTN6STA==
Date: Wed, 11 Nov 2026 00:52:51 +0000
Message-ID:
 <JH0PR02MB7011C479E26E65DDB03F9C93EB712@JH0PR02MB7011.apcprd02.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
drawingcanvaselements: []
composetype: reply
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diodes.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0PR02MB7011:EE_|SEYPR02MB6605:EE_
x-ms-office365-filtering-correlation-id: 2dbd93e9-c1b7-47fa-cf41-08df3f8e1d5a
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|18002099003|6133799003|10067099003|55112099003|38070700021|11063799006|261102123227099003|261009223027099003|261022075727099003|261022105027099003|261026140227099003|261021121427099003|56012099006|261026121527099003|261028144727099003;
x-microsoft-antispam-message-info:
 wZpihHYw5BacBoKF2dtBcR3NgDX3pMXdKP1A6J/Kkwywz0LeUlynvl9dN5Y+jAJTfp1D2QR6Mm6ozfR7qxQaNNhj6qzFEmrzRFrNvKTZD85jbKqJocWoINUO41ymnyG6D295sTByysg0flVrPM51mBnjNPXFiZ2o264Sq8wxo6XteWxEHkn9LNlASYqlphXCbtdbILh3FYm67Du/CjS/Ko031/Lr1sjq6MyLwnADZsVUfJ3LfdpWYLgH9Oltyfz4OLjOcT/oWlVleH9DylV29rZKnDgpbhsTPd6QozfO5wFYQTbV/Bjk1onEzobrFoq2s1j8WvF+3Hrz7cbD6JUirAtMNdMXO/+H4B9uitTff964wbxVVdAPJKgj7UpNUAacUxQ7ojSmOWKJmFJUi7sFQPVAIijO1N43PINcN0isjWungFavQaxj4Qoi8KM2b1ZSdLiqFVNQaVtEZV2+sLrakS022z71t15M/F6ck+aZtM/7oFjuIMj2oStXedLJi00JKNNeUaEbpcxEsba2Iz5cuqRTSNk35XpM2HCjwPuWiNh2PY5UyttWyUuuVToC6PJl7XD0bl+unE8iUI1Lszl8hciPeyTPTjAiV64IFJ9TOClwgJEG39xjXKMToFS5526IozVuttHjAVMPsR4pmvkzoDdMTaU/HtZVEGsK/t7fGEF1AqSHsaiUUuF6CMSfVpDLy5ntlB1YRu7kf9GEEtfqEY39HMjC+iU/pRxxOnNxhCU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR02MB7011.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(6133799003)(10067099003)(55112099003)(38070700021)(11063799006)(261102123227099003)(261009223027099003)(261022075727099003)(261022105027099003)(261026140227099003)(261021121427099003)(56012099006)(261026121527099003)(261028144727099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R3ZFWVY0YXRpbGhoZVllL3Vxb3RxRFB5dVIxd0pOempYTVlUV01ERXY5bjIv?=
 =?utf-8?B?RjU4c0JWVjhjRGp0RzRMSHVkK242YmV5RExBQVJPZkVvMVNkQlU4WTBOaGpM?=
 =?utf-8?B?bVpUQ1FCYUxVSDlNdmVZZVFRblorc3BuL1VZTm9XUlU0VVU2U0JmYUxFb2dD?=
 =?utf-8?B?OHpZS2xPRGpCY0hMODgzck5ic3lGNW1HMSswMmtEUUxvZE9aUHAxZ25PemhO?=
 =?utf-8?B?SHl5bEpRcVlEQ05qYmVoQi94cXFmbER1NDhJSlNZZE5xRmlCVGhzYS81WWVB?=
 =?utf-8?B?MGZkYUZVNzFXUURWSjFCUEI2Ry95TlNTeGFQeXdFSFZiTlJaTlFwL1duR29h?=
 =?utf-8?B?azNEQW1YREwvbGxDTG5HcU5FeERETGpQMXNlbHlCeC8yM3hGSzBSemU4OEc3?=
 =?utf-8?B?dzREWldkbnNxTnJaTjVpREFwT0VYMGNsN3Baa3JGSFU4S0ozVnUrMnd5SEVv?=
 =?utf-8?B?VzZwaVVsQldtVmpwaXhFNU9RK1JTOWgrU3l4V20ya282ZXloYmZLN1lydkJP?=
 =?utf-8?B?cDdoK2xZMzRvVWFLd0R4LzF2NU9FWW5HMUozT0JWU3Z6QzEwSWdvMWNVRjJD?=
 =?utf-8?B?K3JqM044Z3FXSVc3TWJjZ0o4SThpMjlLR1p6Z0YvS2pOSHJLOHFiMk1XSU44?=
 =?utf-8?B?Y0JaOVd6Zm15MXlRUG1UM2ROazJzUmo3bFB0WG9sQWpOSDdhTmxlRThNNS9p?=
 =?utf-8?B?ZGdwQ3BvbTFUNjN1LzFmQWU2dHp4aGg5SnZsRFc3VnF0RjdYbDEwTXB0OW9S?=
 =?utf-8?B?dVdsekhpaUZQeTVuRkdNc09KUEswWXVFZmZDNHFqMTAzS0wxM1FpZDRlL2py?=
 =?utf-8?B?ZkVyY2wyKzNKcTM2OGhxb2hQTHFUQm1LMVh4aUZEQjBJbTBzL3M2L1ZmOWg0?=
 =?utf-8?B?UEUyRTRIb3dMK0l1YXpWRVZQMGx1TE00OHk2ZnZOR1RIUGtiaXo5bEY2dWhJ?=
 =?utf-8?B?cHpDNFdXdUxpdHNLKzhJUmtidmRERm1kcGo1NUt6bUFqN3NIeEVlUnhBUkt3?=
 =?utf-8?B?aXhLZ2ZFTWgxSmRyNXNSdDVyd0lyUmo4cVVpd1pMOXBpbWhNR04zOFEwY0lW?=
 =?utf-8?B?eDBmNDc4K1JTT2pIeWVHMlg2VFdLVzRNOVJXbm1lSTVnMUt2RUxtOXJUTUk1?=
 =?utf-8?B?Rm5uVFY2UFpJY0czRWh2dFdoVll0ZVpCeUp1NkJFVlM4LzM3OEdKM3BlYTQ0?=
 =?utf-8?B?VlBRd1NhRStkaDRTMW40cmVlTU5QSENNeUdDaU1VcXRYUmZIeDR3RXYxRktV?=
 =?utf-8?B?WHd6OGJJd3Bvdnp4VXpuRXRna0VNTVZHT01ZVUFVNC9vY1ZTdll1Y1pXOGFp?=
 =?utf-8?B?VEhsTzNlQVA1SEhUeUpDNmhrUDkxMGx6a3o5MTZtT2U2RXp2K2FDbDRkUkJY?=
 =?utf-8?B?NHlDVmV6K040a01EUUsrRmVFVDFlcXJmNWFqTlZTbUdlT3hGQUhnWWY0aFdj?=
 =?utf-8?B?VDJMQU1aY0lzb3psSndTSFI4cFVLYmc1VXBNSkR6RVhONWVxVDB5RjByRTFt?=
 =?utf-8?B?L3NMWUdWbXN1Y29XOFRLQ2ZNeUpSRnFkTlA4b1dvWmNldWw2Qy9YMjBUN2Rk?=
 =?utf-8?B?NW9tZWVtWWsxVzdDQmQvMnZaUzkyOU8rSUh1YTBYRFZ2ZkxZcWpLS2ZTSXRC?=
 =?utf-8?B?V2R0UThNNFR5NU1Rb2hRR3BFUHBFNW9VYWJESVJmd0IyNVBSVEFPU0xPK1po?=
 =?utf-8?B?ZXZ6Y0YvanU1dG9nSk5UK2ZwRExhZGRXMWVsSnlnT2FzUXlUaWkya2tKOGRJ?=
 =?utf-8?B?LzI3ek1iQ0hZVE5IeHp2Q1B2UGhWNzQraTU1eE11d3JSdWlabGhUclhxd3RV?=
 =?utf-8?B?enBNZ2lxZ3E0RmQyMkp2ZnBKd28xTjd4bFlmcDFtU202MU9YMXNmTmJ2SXZw?=
 =?utf-8?B?alpOQ3dEOFpmWXVtSUFCdkhjUncyVjdhbjU2cm1ManQvUjRoREJNaTlHL3FQ?=
 =?utf-8?B?cXkvYnBhdW5mN0Nwdjc1aTZwYnYwVW51MDMxY1M2N1ZiSXYwVHNYSUtFL05R?=
 =?utf-8?B?bUVxb0ptOXlQYUN3UGpIWCtCcWFmVTBnYVg0WFVuSFc2Z3hKOVlsd0xtUm1Y?=
 =?utf-8?B?RUt0elp4aGovVkkzYjNmSWlBVGlYZTBGRWE4WEsxcTduTkYzUzgrYzVRT0FR?=
 =?utf-8?B?emZ5TmNHZjFVVS9vZEVEZ2pCK21ZbkdaTDh1WEFVcGtYblY1YmFseWE3M00z?=
 =?utf-8?B?bUtxN2JmMmhwZnUydlpWMU9POWdTN3U4eUFabitnWUt4U0JXSkxUaVRNL211?=
 =?utf-8?B?M01aYlhSUFlUNW94MS9PbGd6TVJqY01EUllTZk9od2sxTEJtUC93VGFrM0JH?=
 =?utf-8?B?ODk5ZjVGS0xRT0VFTVdSZVczeUFkOFBvWEZRWHIreFkzM1RuTmwrUT09?=
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
X-OriginatorOrg: diodes.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0PR02MB7011.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dbd93e9-c1b7-47fa-cf41-08df3f8e1d5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 00:52:51.9793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d06d8d8-8ae9-41a0-a393-f29912d98b07
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K1dIfQnH1MoY/NI/XvPOU8QVYUrTkdDMZqeIAHhw9tZapCx78JZg1ZQGTZWrbddhO102M/7vpvl8LHi5c9DKAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB6605

SGkgTmlybW95LArCoCBJdCBsb29rcyBncmVhdC4gKGFnYWluLi4uKQoKQWNrZWQtYnk6IFNpbW9u
IENoZW5nIDxzaW1vbl9jaGVuZ0BkaW9kZXMuY29tPgoKCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCuWvhOS7tuiAhTogc2FzaGlrby1ib3RAa2VybmVsLm9yZwrlt7Ll
grPpgIE6IOaYn+acn+WbmywgMjAyNiDlubQgOSDmnIggMTcg5pelICDkuIvljYggMDY6NDkK5pS2
5Lu26ICFOiBOaXJtb3kgRGFzCuWJr+acrDogbGludXgtcGNpQHZnZXIua2VybmVsLm9yZwrkuLvm
l6g6IOWbnuimhjogUmU6IFtSRkMgUEFUQ0ggdjJdIFBDSTogV29yayBhcm91bmQgUGVyaWNvbSBQ
STdDOVgzRzYwNkdQQyBQb3J0IDQgQkFSIGVycmF0dW0KCgo+IFdoZW4gdGhlIENyb3NzLURvbWFp
biBFbmQtUG9pbnQgKENERVApIGZ1bmN0aW9uIGlzIGRpc2FibGVkIG9uIHRoZQo+IFBlcmljb20g
UEk3QzlYM0c2MDZHUEMsIFBvcnQgNCBleHBvc2VzIG5laXRoZXIgYSBCQVIgcmVzb3VyY2Ugbm9y
IGFuCj4gTVNJLVggY2FwYWJpbGl0eS4gSXQgc3RpbGwgY2hlY2tzIG1lbW9yeSByZXF1ZXN0cyBh
Z2FpbnN0Cj4gQkFSIDAgKyAweDdmMDAwIGFuZCBCQVIgMCArIDB4N2YwODAsIHRoZSBNU0ktWCBU
YWJsZSBhbmQgUEJBIGFkZHJlc3Nlcy4KPiBXaXRoIHRoZSBpbnRlcm5hbCBCQVIgdmFsdWUgYXQg
emVybywgcmVhZHMgcmVhY2hpbmcgUG9ydCA0IGF0IHRoZXNlCj4gYWRkcmVzc2VzIHJlY2VpdmUg
VW5zdXBwb3J0ZWQgUmVxdWVzdCAoVVIpIENvbXBsZXRpb25zLgo+IAo+IFRoZSBhZmZlY3RlZCBz
eXN0ZW0gaGFzIHRoaXMgdG9wb2xvZ3k6Cj4gCj4gICAwMDAyOmExOjAwLjAgIFBJN0M5WDNHNjA2
R1BDIHVwc3RyZWFtIHBvcnQgWzEyZDg6YzAwOF0KPiAgICAgKy0wMDAyOmEyOjA0LjAgIFBJN0M5
WDNHNjA2R1BDIFBvcnQgNCBbMTJkODpjMDA4XQo+ICAgICAgICAgKy0wMDAyOmEzOjAwLjAgIE1p
Y3JvbiA3NDUwIFBSTyBOVk1lIFNTRCBbMTM0NDo1MWMzXQo+IAo+IERpb2Rlcycgd29ya2Fyb3Vu
ZCBpcyB0byBjb3B5IHRoZSB1cHN0cmVhbSBwb3J0J3MgQkFSIDAgaW50byBQb3J0IDQuCj4gVGhp
cyBwbGFjZXMgdGhlIFRhYmxlIGFuZCBQQkEgYWRkcmVzc2VzIHdpdGhpbiBNTUlPIHNwYWNlIGFs
cmVhZHkKPiBhbGxvY2F0ZWQgdG8gdGhlIHN3aXRjaC4gUG9ydCA0IGFjY2VwdHMgdGhlIHdyaXRl
IGJ1dCBzdGlsbCByZXR1cm5zCj4gemVybyBvbiBjb25maWctc3BhY2UgcmVhZHMsIHNvIHJlYWRi
YWNrIGNhbm5vdCB2ZXJpZnkgdGhlIG1pcnJvci4KPiAKPiBGaXJtd2FyZSBjYW4gYXBwbHkgdGhl
IHdvcmthcm91bmQgZHVyaW5nIGJvb3QsIGJ1dCBMaW51eCBCQVIgc2l6aW5nCj4gcmVhZHMgemVy
byBmcm9tIFBvcnQgNCBhbmQgd3JpdGVzIHRoYXQgemVybyBiYWNrIGFmdGVyIHByb2JpbmcuCj4g
UmVzb3VyY2UgYXNzaWdubWVudCBjYW4gYWxzbyBtb3ZlIHRoZSB1cHN0cmVhbSBCQVIgMCwgbGVh
dmluZyB0aGUKPiBmaXJtd2FyZSBtaXJyb3Igc3RhbGUuCj4gCj4gUmVhcHBseSB0aGUgbWlycm9y
IGFmdGVyIHJlc291cmNlIGFzc2lnbm1lbnQgYW5kIGFnYWluIGFmdGVyIFBDSQo+IGNvbmZpZ3Vy
YXRpb24gc3RhdGUgaXMgcmVzdG9yZWQgZHVyaW5nIGVhcmx5IHJlc3VtZS4gSWYgdGhlIHVwc3Ry
ZWFtCj4gQkFSIGlzIDY0LWJpdCwgYWxzbyBjb3B5IEJBUiAxIGFuZCBkaXNhYmxlIG1lbW9yeSBk
ZWNvZGluZyB3aGlsZQo+IHVwZGF0aW5nIGJvdGggaGFsdmVzLCB1bmxlc3MgbW1pb19hbHdheXNf
b24gaXMgc2V0Lgo+IAo+IEFzc2lzdGVkLWJ5OiBDb2RleDpHUFQtNQo+IFNpZ25lZC1vZmYtYnk6
IE5pcm1veSBEYXM=
