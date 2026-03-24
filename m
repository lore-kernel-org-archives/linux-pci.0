Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023134.outbound.protection.outlook.com [40.107.44.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78AE3F54D5;
	Tue, 24 Mar 2026 12:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774354975; cv=fail; b=XSymffvm4QaUDnVdL/haf8EF29poBHUbdSF1gseo7EK5Bt5XYRC4Mq2rEq5uRb8VZrrJDM7CTh5s6hbuceKGXpGRcNVNe9CGI5po8OR+y/iejIyI6I69EFJEdOKzKUtVU093rWaYBdCmjAHUJoQ+GCcCo6kkV8sH3DgSPTSE9sM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774354975; c=relaxed/simple;
	bh=+onPMRlxlUL4bNKu3F4S6yhtnMQLNfwyHdIAyk7OcYY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ooMAdjK45JDD7uEq9FwDbBnPDa2A8KpPF27tRiD2nL0JZ2rRcwkvDwOmc4cgMX6AoEhRQ664+bpMdThSJFGVe7mYWmEp847rd5C1FTZHRz1YMJmCkHHNdERbYZPHtqf094sUGDomwg4QdHn07PIHryTw9Q0xa5/OySIXvdkQ2lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=FM61Lz26; arc=fail smtp.client-ip=40.107.44.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="FM61Lz26"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJ1kKRMlHaAj/f0DX1D/yBmd3bHTzDXFOwgzMMxW5re1C6muID6jJwIbchAUUsSi1dPRKg+HhZ1Awajpb2tGwRbLcQ0x42krQUFvANQZidpuSy56YMDwz5tB2FhpY65iHrMs/iq+GdUTpVijh5QKcoB6+xBvmaV3PLVbiZd3V9fyeyAQVme1cIdH9FO9Q0YL3Vu2k1Pr6xrxSJsDgQSWS9pTKa4wCSS13Np8rcDR76Ijp/IoN+B64AXt+vj4eXxDT9Sc8pjUIwLP1PXcUR2RGd+gD/ONs8K2Rbf9IYvl2DWs38xw+e6f3N+LL6MrS5/t6H98RNbzgXINlsbqN4MNSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+onPMRlxlUL4bNKu3F4S6yhtnMQLNfwyHdIAyk7OcYY=;
 b=IURbHTb2kmp5j/EthoKwZDWA21/HlQfXjPLi8Jd68DdGLWP3OIf5LEkkpuZL5XbRpdI6XseED8Z2xpkfeyrPZ0OgQ6lza/J6qcZGqZ91hI7L19F+8nbwBXwR0EpQjQVCHVPpCceTtNIVLJJMZhHALqt8MjgptX7kVjBvbh3+yzLx0pFm7TwuYwgUzRZJ2zIlMachXjv+gPzXHtJpOVFPwR/bRVMSFK8CnFrXxgqjIzr7n9SQrwBFee/hun4Mad8zIe7tH3Ay782OIJuWJGrnrsCBl++66m0UtwnCJXwMhjFRnkbeU4Wh6dB0IYjhXMMN1EZLrKWLOZcOc63V4ixf/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+onPMRlxlUL4bNKu3F4S6yhtnMQLNfwyHdIAyk7OcYY=;
 b=FM61Lz26UcqBbKHFTff8BKvFkHI5GWIIAmBsYyjaHJHnnxutAly4HNwWtmdEF0cw1+NP4Fd7KsAbmsoGjcBGZluffTmPWcioJBMsXmXWdLameH5FagHFbk57XRUYj6k/VY9gecunR17UqfltZn87l5TexBI3ebjdKdJ9wD/wvp73cJg6pKzrwgjpqKJxO0NEri1EWE04RDATI4Wb9DgK/7UFR48v6fBiL/mOrWDEzE3vh3ojOxYoxlmzR4pnSMxRzdioRqkylV36iznFLlFpvrB/9png5ysXIl1QceZ2BBxb/T11rkix0HBDcucjDWNWfTBnsuxkBjJr89LkpnywrQ==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by TYZPR06MB6466.apcprd06.prod.outlook.com (2603:1096:400:45d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 12:22:47 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c%4]) with mapi id 15.20.9723.028; Tue, 24 Mar 2026
 12:22:46 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Felix Gu <ustc.gu@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>, Manivannan
 Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>
CC: "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] PCI: aspeed: Fix IRQ domain leak on platform_get_irq()
 failure
Thread-Topic: [PATCH] PCI: aspeed: Fix IRQ domain leak on platform_get_irq()
 failure
Thread-Index: AQHcuu6cQ07XbsQEf0CeVoZPpBZpA7W9l+RQ
Date: Tue, 24 Mar 2026 12:22:46 +0000
Message-ID:
 <SEYPR06MB5134E8A8893AADAFE82180989D48A@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20260324-aspeed-v1-1-354181624c00@gmail.com>
In-Reply-To: <20260324-aspeed-v1-1-354181624c00@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|TYZPR06MB6466:EE_
x-ms-office365-filtering-correlation-id: 7e2567fc-64c8-4ed4-73bc-08de89a00ece
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 6Uh3q+6rx+sBNLnrZqJLvlByK1PznNQ9vm6bf1PrGKjW7TbdxJ3F6+2RiAey6B8nfFbfmDGUaXprLqoVhlpxpzD4jIlzO5sN1x0/ie5+DOPtGQ08vS5FGkuex5kloIPKDxR+D3s5BJ944IBKz/QNPK0nXt6+lpI+m26p/aVWs0l+cssu8k3PZ5i2cxyZlD/vphubmDYF7RtPftALO+1RMdX2C14qGEAcfbXzPpIKT4/pXEhiSqGDwsKd+WHVKPnAqyt+/q30ZznTKKTAcfUY2Sr251nA80Oi3PiToiyvfPHNtEsnJlUra3vOt9pigHlrkwJHykSzvj3FhxwoY0N1MG6Hn5imz3ry8dKeTpDItGXMbec2jHbg9Haag4k8fQsHa35y2h6iXJCCVYFl9w8w92nU8oYUdE41HCD5QcCJ3t4EGr1efZKeUXwWHWJo40PIzOel40RpfZFr2pIaqlCV51uCZitvbOAX/1ZCF9Ve3jpFCr3eP6Y+GF/X6bDZTV+6LU7hr2fD41DO9vhP1k1FUI6LAuPMPks3J0AAFWevHq/pkBK6IMRHaPkz3Hi9IUwQyqWgEvlNJ/iqhEev8B4b0CL3OwHHbvjcBp7fSv8A1VcWBzR6sD1iJzG4nuTm2wrcC5Q+6Paa82Y4ISUZk+/KiKuRSc0HIHbumOGY/HZolSvk9EXudRpe06lPht4GJ7b5XPkI+iaHc0/JjmDhH18DO9ZmFPMh0WFRNS5PkYM6587MSEY2/lJmZPWPrVLOQlLScS210gEaoqnd5ovtbAhD3NLHfo4Sr/0Lu60jzU/VkkM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RzZweU9kSzVsdGJPZTlvbHVDTmtjQkswSmdIWHJERWlLSmlMdU9Neis2bEZn?=
 =?utf-8?B?OE13UVNZYVVpdHBnOEdaR1puTnZyWGhPbmFtV2U5Z3d1MVpvTjNUOHJoZXUv?=
 =?utf-8?B?dVVqR0VHendIQUJ6WGJTdGVzeEUzcmNKdm1vSHpQdUZPM285TzR2TEhTU1Vo?=
 =?utf-8?B?Uzc2NFV5THFEaVZONGVNOVF4ZnZaWmcxWEs4MHlZMEx1bWdmdWdXZjJlMkZP?=
 =?utf-8?B?b1hYdytZL0twNGtYNm04WmplTXZ0R0p4YXFRcEJ1UEplTjN4c0dHWTRUaXFh?=
 =?utf-8?B?WUlVODRRRlpMUnJwRXp5THVlanY4aE82TmpjUm53U1RsOVBFOG9uVVNzM3NZ?=
 =?utf-8?B?QkxNKzAzZE9uRkZOTnBDdHlwbUc1ckZtZjZUMEttbXN2ZzIzMjQzQVBveXRX?=
 =?utf-8?B?azAra05Lbkc2dFB3d1d6dUhpOUV6WWVRd3pXaUY4MFhOZHNFeTJsbEdBVHpL?=
 =?utf-8?B?OUFiOTdGNlRkMnZJUnIzRzd1Y3JmNkcxbTNOUVN4b3dYTkRlR1QzbHVUTG0z?=
 =?utf-8?B?bDZxV3JkUkUzb1dEdFJGbVZDM0tLSDcyUGJGRTcwTUFaeFhuTlBzczBGN1g1?=
 =?utf-8?B?SHVoUlkvOXV4alVsejhUTWErNGl2L2lRZGJJNHlOdXd3Q3NXOE12cDZ2YXhF?=
 =?utf-8?B?blJ0MlNiUjllcXdqc1hobUhNRmVoemJ4R29OUTYrRW10YStCVmp1ZWEzV2tI?=
 =?utf-8?B?SHl3SFpmWTBiTDZZbG1ycG14dE9MdlZqbFZHVmdEYjdoU01tV0hHdk1Qa0Ji?=
 =?utf-8?B?d2d1MVltWldid3lCZmpFMmVzS0RhSVg1am1wa3EyQytGMWhEMVprSzB6MGo0?=
 =?utf-8?B?ZkhiNGdCYXQ3SVdhdnRNeUpQQllEOFZoOFZTUlpwUHJWMFcwTm9pUkMvSHNF?=
 =?utf-8?B?Q01GNk1UaGcxdklrNmJxcCtBb2JPSDlJM2tmMUVXUGI5Nnh0NkxUN1QvZkpi?=
 =?utf-8?B?TWdTRmRUMGdIUDA1YjZ3SW5IYUJYdDRPamc2Ly8xVXBqcFRyYy9wWnVUQzFq?=
 =?utf-8?B?dS92Vmx5aEszYlZoUG92T1dTTGdJMU1Uc21nL2RpT2FidjY2Q1FtclhsSTVk?=
 =?utf-8?B?ZUZyQjB3UEVuc2VPeVRhTmZ3TWovVFppY2FDZ21OSFloRVIxcVZwTE15WE9S?=
 =?utf-8?B?OUtKMUl3STZsbHp6TG9aSVN6bUdWQ3NpcnB6MnozdUFoMFFJclpvemg2dUd2?=
 =?utf-8?B?bkpKM1oyTS9NY2RJODhxQ1lpaTFhSy92NkxrVlJRbDhPUGhXbk11c3FHN05x?=
 =?utf-8?B?MWx4VnBQcjdtdlByWUtueWF1UjdmcUFRKzN1dnE0MlFFM1VoNGFKa3BTS1kx?=
 =?utf-8?B?LzNremxSSTNJU3hvTEZyaStHU0N3WEptcTRoeXpIT1p2SlJVR1VlMW5BM0tR?=
 =?utf-8?B?UnUvdzRQeGg4VDF3dW0xU2lLV2lqUFVzTC9HV1pMQVQ5Y1RvK1V4SDRMblJ4?=
 =?utf-8?B?VkIyZGFvWjNBd2Y0QTFQZ3JoRXJJWmF2UzQvbFowREFjTlFqY2FoNHJmSnMy?=
 =?utf-8?B?c3V4VGoyaVJKTnFGTmozTHJubXh2SDBpcXIwaE43czBaUmF0NGFreUtwZVh3?=
 =?utf-8?B?emJRSGRZUkVidWE2Z2lrbzJnTUVQVDhQV0NZMG1mMUtWcU9kWmtTUDNxMGxK?=
 =?utf-8?B?cGxCQzJDNmsyc1ZJVkNIWjBZYVJXSU00dmZkOFF1NmRqMElQei95SXp1M0oz?=
 =?utf-8?B?bVRremVZNUJNMEN0SXdjRittT1daOHAxWGVYdnp3eDRlakcyR2FjdVpLMHow?=
 =?utf-8?B?SURTSEltRm1wVUpiaVBWS04reGVWSDVoNW14czZrbTVCOEtZWU9lMnJHQkUy?=
 =?utf-8?B?YWxkYUVBeStWRnhQTzNzUlRhYlYrUUFoZTJvbG5jS1BWaEFrbDVnLzNZQ1Y5?=
 =?utf-8?B?R3VqTUs3bXZuM0o5VDE2eFA0akVKYU5rZkRQWElXNUpCOGN6ODNmOWtnR2x6?=
 =?utf-8?B?WlpabnZWR2xxQWZCWDkrVzMxTGk0VEJwcSszN1UzLzVkRGlNQXJ0ZmFIbk5T?=
 =?utf-8?B?QkNwWU5idkdjQUY2OGlOMXcvbzlXamUrVGRuL1NlU044NmcrZS9IZVVGVW9E?=
 =?utf-8?B?RTJEWE1OWk9FS0hZd28xU2xkL05BaFR1SW1NOENFb2xPZzJiSEh0Q0k1Z1Fz?=
 =?utf-8?B?c1lKNlA4QnJvS2lRZW1RQnhWcWdxTVI0RHVKSkRJZWpNdEtHS1Bsc08wZXpB?=
 =?utf-8?B?QXhjSmtieDY5b1I0U3JPMnhmVGtJVGk4MjB3RDVqVnYwSXNidnB2SHI1YkY1?=
 =?utf-8?B?S3FZR3VQelZlUDZMNXcwVjVCN0pJbncvQ0h2cmc3cEhCRDVubU1QeDcvTUtF?=
 =?utf-8?B?ekptRi9uZ2pkSjl6UUE2TXhyQTNUTjJPdVZPQTE3U2VOaEJYd2JtQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	U4o9OnlvVnnn8Qy3GHJ/ZJVPMqd2Gj/J876tBe5q5AtMMwxb1vacRS8vtZnqntmviCbTwgkqxyH1a3qrNPlLE/2Cx8BzfK0ZF50wTV4flZoF33j/6aLAMXVmcmnUaX00ns7EVczIvs45YugBla4Zz4dZcvJ4zFlCoPIZa5XxUHrKInR9t/T0E2s4jEX/D5a1COsnPEB1Q8XqkmNPeRjZtjR9pBdw58Ng9wiRusEknq/cgXmFt8lGH7/YmG78XNjMTIkJaFdoYOIRg3HHE5TrtGeEPJ8215+Pyk5VTnZPYw/GI6RbUh+NM2JQminzpMPdBhEVFgP3RNces7ZWhaD1/A==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e2567fc-64c8-4ed4-73bc-08de89a00ece
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 12:22:46.9322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EM+JHZuQG6Ztql2VXZVI6Tl5Bl57YcHnTSBhTLWWyHmfokXTTjBAwtO7QZ/zWoK4wOjtVMuXXxJSfrjeUrtjIJEX/X51eSLrkX/Kn0slYkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6466

SGkgRmVsaXgsDQoNClRoYW5rIHlvdSBmb3IgeW91ciBwYXRjaCB0byBoZWxwIGlkZW50aWZ5IHRo
aXMgaXNzdWUuDQoNCj4gVGhlIGFzcGVlZF9wY2llX3Byb2JlKCkgZnVuY3Rpb24gY2FsbHMgYXNw
ZWVkX3BjaWVfaW5pdF9pcnFfZG9tYWluKCkgd2hpY2gNCj4gYWxsb2NhdGVzIHBjaWUtPmludHhf
ZG9tYWluIGFuZCBpbml0aWFsaXplcyBNU0kuIEhvd2V2ZXIsIGlmDQo+IHBsYXRmb3JtX2dldF9p
cnEoKSBmYWlscyBhZnRlcndhcmRzLCB0aGUgY2xlYW51cCBhY3Rpb24gd2FzIG5vdCB5ZXQgcmVn
aXN0ZXJlZA0KPiB2aWEgZGV2bV9hZGRfYWN0aW9uX29yX3Jlc2V0KCksIGNhdXNpbmcgdGhlIElS
USBkb21haW4gcmVzb3VyY2VzIHRvIGxlYWsuDQo+IA0KPiBGaXggdGhpcyBieSByZWdpc3Rlcmlu
ZyB0aGUgZGV2bSBjbGVhbnVwIGFjdGlvbiBpbW1lZGlhdGVseSBhZnRlcg0KPiBhc3BlZWRfcGNp
ZV9pbml0X2lycV9kb21haW4oKSBzdWNjZWVkcywgYmVmb3JlIGNhbGxpbmcgcGxhdGZvcm1fZ2V0
X2lycSgpLg0KPiBUaGlzIGVuc3VyZXMgcHJvcGVyIGNsZWFudXAgb24gYW55IHN1YnNlcXVlbnQg
ZmFpbHVyZS4NCj4gDQo+IEZpeGVzOiA5YWEwY2I2OGZjYzEgKCJQQ0k6IGFzcGVlZDogQWRkIEFT
UEVFRCBQQ0llIFJDIGRyaXZlciIpDQo+IFNpZ25lZC1vZmYtYnk6IEZlbGl4IEd1IDx1c3RjLmd1
QGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtYXNwZWVk
LmMgfCA4ICsrKystLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNp
ZS1hc3BlZWQuYw0KPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1hc3BlZWQuYw0KPiBp
bmRleCAzZTFhMzlkMWU2NDguLjZhY2ZhZTdkMDI2ZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9w
Y2kvY29udHJvbGxlci9wY2llLWFzcGVlZC5jDQo+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvcGNpZS1hc3BlZWQuYw0KPiBAQCAtMTA1MiwxNCArMTA1MiwxNCBAQCBzdGF0aWMgaW50IGFz
cGVlZF9wY2llX3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJaWYg
KHJldCkNCj4gIAkJcmV0dXJuIHJldDsNCj4gDQo+IC0JaXJxID0gcGxhdGZvcm1fZ2V0X2lycShw
ZGV2LCAwKTsNCj4gLQlpZiAoaXJxIDwgMCkNCj4gLQkJcmV0dXJuIGlycTsNCj4gLQ0KPiAgCXJl
dCA9IGRldm1fYWRkX2FjdGlvbl9vcl9yZXNldChkZXYsIGFzcGVlZF9wY2llX2lycV9kb21haW5f
ZnJlZSwNCj4gcGNpZSk7DQo+ICAJaWYgKHJldCkNCj4gIAkJcmV0dXJuIHJldDsNCj4gDQo+ICsJ
aXJxID0gcGxhdGZvcm1fZ2V0X2lycShwZGV2LCAwKTsNCj4gKwlpZiAoaXJxIDwgMCkNCj4gKwkJ
cmV0dXJuIGlycTsNCj4gKw0KPiAgCXJldCA9IGRldm1fcmVxdWVzdF9pcnEoZGV2LCBpcnEsIGFz
cGVlZF9wY2llX2ludHJfaGFuZGxlciwNCj4gSVJRRl9TSEFSRUQsDQo+ICAJCQkgICAgICAgZGV2
X25hbWUoZGV2KSwgcGNpZSk7DQo+ICAJaWYgKHJldCkNCg0KSSBoYXZlIHZlcmlmaWVkIHlvdXIg
cGF0Y2ggb24gb3VyIHBsYXRmb3JtcywgQVNUMjYwMCBhbmQgQVNUMjcwMCwgYW5kIGl0IGZpeGVz
IHRoaXMgaXNzdWUuDQoNClRlc3RlZC1ieTogSmFja3kgQ2hvdSA8amFja3lfY2hvdUBhc3BlZWR0
ZWNoLmNvbT4NCg0KVGhhbmtzLA0KSmFja3kNCg0K
