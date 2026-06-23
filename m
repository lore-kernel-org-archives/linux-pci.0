Received: from PUWP216CU001.outbound.protection.outlook.com (mail-koreasouthazolkn19010003.outbound.protection.outlook.com [52.103.75.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD0B2D7393;
	Tue, 23 Jun 2026 15:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.75.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782230126; cv=fail; b=ZiBGbeBgg5PF9rXvKzgIMyXllvDBQsczlp3zyPGrOBsjOEwzMQksu64pGrw4SuiT5ElDRDklfXC4G4MY5xfVNCLiUq2eBxjbZWed4aDl32FV662+xpgNwMDUfLrhUiekbgYA30vLPTew0ygXD3y8AcHBgfCth2xYdmiPoWS3kqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782230126; c=relaxed/simple;
	bh=gztGAX7XV5C3v/+QGVyMlfEKcMo5o9NIAVVxwM7X4B4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gG6kNvDkbN016PmAhL60DqjJZUXYJwaWegC5PwvqH4zkePEP3Yd4T8E8vZcNhdKwb84ziiIFElj0REv87J0ajfv06lDYTBzeW6zXBAjDou0KnLPfYmVls3I8uhMjaI9iUS7fTjzeQpSLQR2nomTHCiiSscrbxMBjEQWzO7C3PQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au; spf=pass smtp.mailfrom=outlook.com.au; dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b=Sz9P3XSg; arc=fail smtp.client-ip=52.103.75.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b="Sz9P3XSg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HSLPr8jNqHcH9B7cKgfDJDiYSPwanMl2+gm2pCyFnlj/BX3kSDXfVEtjVyh7rwBSA1sGLhXDfLFLoPF5ZvDshepkmw0pENCrYa1wHwfFQtYwvZu1CzRX5jhTNoCrAgZJacyUQ7ADbcNPQwiFx6GAXqaIYiouTlh13Gu1qfGPGCswKn1u8oL8Cg81HdusnHYw7BGfZ/Iq2mYLizB3CMDeqJdQItSVkw1tfb1jquFhE270VkR05JqaZeZj6s8UrO1cQyVjxNWOSHMHiwIK81Pgp2R36f2nVtFCENuqidV1mIJh0WEHmfBpPR5W1sTvWL+O1Y7mG3MqL2MkawoAsjvXbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gztGAX7XV5C3v/+QGVyMlfEKcMo5o9NIAVVxwM7X4B4=;
 b=YLZEarliaEc9QiEORlMWeakt9LKKm1e8Aqo6ANoUBu5TXZSHxJ3BfBjxdhhgsv8tKXyRXZvgz1sP+dNEGuyddL+/VUyVwhKUH7sDT6gqVfok+citOPf3DoSFwZTT3SZEP4gcX8hxipNI/i3r8mCfSJNng79DDYdmBEPkI7l2dvRTIQ0TdyF/iRqXVYrmn5ra5QHxJtBdQu4pNgIXXgrrFEeKChYsmicx8dT2cbhxYqgSOb0P1s/7XHapRMfXdPfpsu46nZFJAOck/+6tRifEjpzC/zYhCQFAhso63L6GEV+T78Kaq4aKPI8KaRV6UE3cz8E6CuQsQ6M43Y6EebGTqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.COM.AU;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gztGAX7XV5C3v/+QGVyMlfEKcMo5o9NIAVVxwM7X4B4=;
 b=Sz9P3XSgTNAUdlfiHfa2d6X4AAPN1uwwEtJXq8AtS60avJ2hUn+3/pLkCu5v8Ep2+CtRAee+GgrQCXpaylHTdoqAu8GpyZC/nKQcViyjcPO8rT6kVhp6M7BVjSu7S2BzuOoLEKqjoEvQb7Zixrj8iXA1xzYN70S4oXoPr+9z6ViBEJympRD9RwLC9c9863yrE+/Ylrrw9oWWbvhfClVAZSFbuJvGDCs38K81ehCijlKIXPao/vCZmKxZJqwFF9Cv96Zct2YhLKNWdnbFfU/uW3I7fkFRjOn6S+8VjMlsySfua0FX4PVC++LBndx421uqBjfRVWGfiZeNaui1i4TwNQ==
Received: from SE2P216MB1523.KORP216.PROD.OUTLOOK.COM (2603:1096:101:2d::7) by
 SE2P216MB1686.KORP216.PROD.OUTLOOK.COM (2603:1096:101:fc::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.20; Tue, 23 Jun 2026 15:55:21 +0000
Received: from SE2P216MB1523.KORP216.PROD.OUTLOOK.COM
 ([fe80::7e41:a55e:876d:dff2]) by SE2P216MB1523.KORP216.PROD.OUTLOOK.COM
 ([fe80::7e41:a55e:876d:dff2%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 15:55:21 +0000
From: Nicholas Johnson <nicholas.johnson@outlook.com.au>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Nicholas Johnson <nicholas.johnson@outlook.com.au>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] PCI: Fix bus number allocation for switches with multiple
 downstream ports
Thread-Topic: [PATCH 1/1] PCI: Fix bus number allocation for switches with
 multiple downstream ports
Thread-Index: AQHdAyiyG6BnTtr9RkOgZDdcX83MfQ==
Date: Tue, 23 Jun 2026 15:55:21 +0000
Message-ID:
 <20260623155256.32688-2-nicholas.johnson-opensource@outlook.com.au>
References:
 <20260623155256.32688-1-nicholas.johnson-opensource@outlook.com.au>
In-Reply-To:
 <20260623155256.32688-1-nicholas.johnson-opensource@outlook.com.au>
Accept-Language: es-PE, en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE2P216MB1523:EE_|SE2P216MB1686:EE_
x-ms-office365-filtering-correlation-id: d16e1b64-a3d4-4bc4-1411-08ded13fd4dd
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|15080799012|24021099003|25010399006|38102599003|8060799015|31061999003|37011999003|19110799012|51005399006|55001999006|3412199025|102099032|440099028|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?d2FHanM4ZXluWm5MKzJFYjlEd3hHMjQvWGkxMFU5a0ZQb25HUzlZV1lzdnRD?=
 =?utf-8?B?MDFGN3VJZzNWRWZNYzJFaXJVb1ZoY2VjVklCMHU5N3NXRHFyYzUzZmV4VGo2?=
 =?utf-8?B?cmhlZ0lBUFEwYjFoa0hDZWE0Z0JFc0NDRHJVckJFRnp3M2MrV3RPbUVwMEMx?=
 =?utf-8?B?LzFvNlQ1MUVSWUZ6QzFWLy9ZUStsd0NyZkowVHJVYUZUK05YbTNiczE3alRo?=
 =?utf-8?B?NytwdllxWkNOc2RaRm1KdmxTbldNRENON0VlTk1zSjlJWTZ4WG56QVhmQTA5?=
 =?utf-8?B?aW5xUkhndUpoOEVCYnJvQzVIRW9mTVlBS1hUd3ZYdGJOTS9BQUxyNk5XUG0x?=
 =?utf-8?B?WWZaSDk4VXVxcmgrOFJ2QlZubkNCQm9RU2drcTE4aHRxQ1FHREZoNmt3enBY?=
 =?utf-8?B?cWtqQ1c2aURyK0NnQTBkMlI2TXI4RDNKWXBUSlV3Rm9LTzMrSTlzRjVvSmJa?=
 =?utf-8?B?b2ozd1RKbGtQN1dnbjdqV2hHVk1nSzlraHRhNWd2OXFhTmljWGJLcTdnNjZz?=
 =?utf-8?B?K3pjRW55bFFwb2YwRHN2TjdhdHJuaGlEWHM3dXZqRzVTNXlzdjYxZm9IdSta?=
 =?utf-8?B?cGZzSmxGeWlYKy93MldoWXlnK2lJZmpuaUR2WXArUWZRTk1JcitHM3NMdGQw?=
 =?utf-8?B?alR6aXVsa0hkRnJZamdTQUEwbFMzdGxLNzJ6bitLRVU4NWVuWjNuU2t0ZENa?=
 =?utf-8?B?bjZKZ003eGNRK0gvRHkvdVhiRVVld0tPNGpWaGh2dG1VQVgrK3laSE9Va0dV?=
 =?utf-8?B?TTh3UzN5bVd1VG44TEc1eVBCQ1p1TUsxZjBOV1Q5dXpWdi9LZHFXdEtoaWZt?=
 =?utf-8?B?dkc0dXEwTnVpOVJ5aEpzaTNaSTZDS2I1RkdZc2daYm1KRkxreDZOcWp0RnJz?=
 =?utf-8?B?STZtbmQ5cFN1MHNvWXQrUjRERkFpWkhIbTdEaVdHNUY5bHVEQWlrdWxkQWs3?=
 =?utf-8?B?d3diZHJuNmJUMVl1UHdWVksweU8wc3FpWkJERGQ4ekV3bzBLUnNLc0NieDFV?=
 =?utf-8?B?K1FhdVB1UGwwcGhoNjBWZEs0Qm9KNXZZeUxZUnBLdC9ieVYxM3JWb1RWZmNy?=
 =?utf-8?B?SFc3MnIzcjVnUW1rVlJ6MG9iSGFIRWFPQWdpQVlkRDBhSEc3cjJYYU5tV1ZO?=
 =?utf-8?B?U0NpdTE4WThCVzN0bk1NL1VNMUlQTkJUQzBZTVRPL3A2VTF4MW5tbmVCNUtX?=
 =?utf-8?B?SHZlT2lXQWs5YzdrWElsNEl6SW5ZNEJZckgxVk1ubjFwYkJuSUtXUWtLNXZ2?=
 =?utf-8?B?TWhjdkFIUWJvOFZtay9qQVU3SmJSUmg2azZVVHdBb0RVMGNGT3huY0paRlND?=
 =?utf-8?B?T21WaWJ3emJ2Y0tjckt2NC8vTlVRQktrVWpPUmUxc1pKZWxLRm9RYnMxOUt5?=
 =?utf-8?B?UnZGUFcxT1FYYjAxT3pnd0RDQlBvbVM4a09tQ08zLzZSc1QrRWt3QjNLS3Y1?=
 =?utf-8?Q?7UJHOMub?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VEhTdStacjBpZnc1MVFKUUlyZVphaUVZTFlFMTlERVViRFlRbGRYa1A2MTBI?=
 =?utf-8?B?TU8zUmlDVDdtY1dDNG80YTBiMFJkeldtMWdiSUphT2FqVDgyemk0NkcvUjBp?=
 =?utf-8?B?c1crNVV3c1lzQmt1S3JpUVlCb05zbHBBYzlnQ2hEallTQ2pUUStrcGZNYVdY?=
 =?utf-8?B?MU9Odm9WUzBESkJvaW96MHpidnF5VFBKYUFaMHBDMXlEQWtmNHFaWk1Idzd3?=
 =?utf-8?B?c214UHpmUVVjNE04VTJvMkprejBxZVRxV1g2MmZITWFYUG5LN211TUtVaGl1?=
 =?utf-8?B?UjNkbXRBUFBYd1RjYTEzZDlNdnhwaTY3MktHWlViVGJMNkVYa1kxWjB2WG0v?=
 =?utf-8?B?Q0U0Ri8yOXdQTmM0YStoZ0RZUVBRdVVyVEs5MW9LL3dSV1d0MVg1WldKZytv?=
 =?utf-8?B?MmdGRnVteDh5dWU2Z01KM3dnR084eXZKaW1XYlA1YTdKRFZQT3lsdFRxWFpR?=
 =?utf-8?B?alBzdThMaDZ6WWdZdFUzUzczNkc5VWROWGFFOUo3TTFuUnhsUGFpRkJCTjB2?=
 =?utf-8?B?cUJ1WnNYQWRnKytJdjgzSjlLSUVqRUNMZ3A2SGpPc0gxdGF3RHloN0RQMHhT?=
 =?utf-8?B?OW9qZDlpVzFFQnRFVERDaXhFV3QxNnpGdnlFRkdJWTNFSGlSQWZ2VnhXY0Vo?=
 =?utf-8?B?cTJSRXM3RUtET1J0U2NMWlFETGZxNHUza3lQRUp4NGFlTm4zMG5rNFdUZGNQ?=
 =?utf-8?B?N1plVEFsYmVta25oQ3h1bklPa1RpTXY4ZExlNVNPM3VDTGNHRjk3WXFweHhY?=
 =?utf-8?B?UDBuRGJjTmZKbHY0QTkrNmdCdXNBcGZ5bEFPUEExV2k1OFdNU1ArUHNsTnds?=
 =?utf-8?B?bFNQNDQ0M3BrazBwSFNBT29qTGFpM096YWdhQnZPTkQwbnlSSE94b21RNXd0?=
 =?utf-8?B?NFBPSnh5cVo5VERhNHE5K0x1K2FhMVcwWkZsRTRRQmJUR2ExcVV0L0pVUkRB?=
 =?utf-8?B?OFZhWXBKbkVVeDV4UzdiR1VPbHdUa1BuMlBROVJZc2hyMFpHWS9tVFlqTnAz?=
 =?utf-8?B?bG1PWGdSREtCeHc2eUpzRHNBQ0FLUHlsQ0NLQ1FkeFhYa2I0MXM4cTUzNGVq?=
 =?utf-8?B?ODRrczJYSEhrL3p4MThpNHJ4VGdFY2xKdlo4RVE5UVdrZ1dRRStIVWx1MDlM?=
 =?utf-8?B?RCtJZWRmcjlPOU43bXpXR01qMXlKeVRodW4yT21MeEE2bTkyc1Y5OXJOaHBs?=
 =?utf-8?B?enIyVk90dHB1U2lYVXRrUldWaVZ3WW5SRy9XTVIzbG02TXUxOVh5aHNqUFlY?=
 =?utf-8?B?MTVmeTZGT2F0dFc1Q0FwdWZRdXdvdDlSRnp6dW9OZ2FndHpqOWtWbEZ2WTlQ?=
 =?utf-8?B?UkpNQkRUN1F0QnFocDB4MVlMS1pRL2h0Mmt5S2pFZWUxdjRwYUNUZHRoSnky?=
 =?utf-8?B?SnFKcGtmNWM0OVBaWjA2ZlhnbE5qTHUrNGs4RFYzZ0U3bVpVc096TUVIRng0?=
 =?utf-8?B?dU1PeFdWTFUyYWg3ZVJ6U3VWSVhKZXN5MFY4blN3S0JIbkJKRWJ2L2g1S3J5?=
 =?utf-8?B?NDI1S2hqSG5xQWU3N2NROWZJVWVTSTdsdzk3MUxjS2k0LzFZUUh4Y0M1Y1Uw?=
 =?utf-8?B?MmxzK2ovMCt4QU9SSlZBWjlpdlplSzhMR0JLZC83cWlwTFlZdGVoeW9EQURT?=
 =?utf-8?B?OFU2cUFUaEY5SDFXcmg5Y3Y2dWxIRXYzNlNQZGNPOU51TnkvU2p4UngwUXRR?=
 =?utf-8?B?cjJJWU90Q2w5VXdiM2hZWW00bFltZG84SWhiTFg3MjlwWUJiRXYzVWdGVno5?=
 =?utf-8?B?K0JVSHlTUUpRa2RtUUxlZlMwcm9RMzhZKzZNZTljZlRreWo2SmhIWDBNbUlC?=
 =?utf-8?B?ZTFCZ1JjdW5IU1A1QW40Mmg4VHFQcjJIYXk5YVgzbUZtMFZTdVR4U0VhanQ2?=
 =?utf-8?B?bzBHV3lFMWdVc2x5WVc3WUdWMDBZN2xyKytpVXJObDNUeUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-94596.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE2P216MB1523.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d16e1b64-a3d4-4bc4-1411-08ded13fd4dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2026 15:55:21.7235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2P216MB1686

V2hlbiBzY2FubmluZyBhIFBDSWUgc3dpdGNoIHdpdGggbXVsdGlwbGUgZG93bnN0cmVhbSBwb3J0
cywgdGhlIGtlcm5lbCBjdXJyZW50bHkNCmZhaWxzIHRvIGFsbG9jYXRlIGJ1cyBudW1iZXJzIGJl
eW9uZCB0aGUgZmlyc3QgZG93bnN0cmVhbSBwb3J0Lg0KDQpUaGUgaXNzdWUgb2NjdXJzIGluIHBj
aV9zY2FuX2JyaWRnZV9leHRlbmQoKSB3aGVuIHNjYW5uaW5nIGFuIGFscmVhZHkgY29uZmlndXJl
ZA0KYnJpZGdlIGluIHBhc3MgMS4gVGhlIGNvZGUgdXBkYXRlcyAnbWF4JyB1c2luZyB0aGUgb2xk
ICdzdWJvcmRpbmF0ZScgdmFsdWUgZnJvbQ0KcGFzcyAwIGluc3RlYWQgb2YgJ2NtYXgnLCB0aGUg
YWN0dWFsIHN1Ym9yZGluYXRlIGJ1cyBudW1iZXIgcmV0dXJuZWQgZnJvbQ0Kc2Nhbm5pbmcgdGhl
IGNoaWxkIGJ1cy4gVGhpcyBjYXVzZXMgdGhlIHBhcmVudCBicmlkZ2UgdG8gbmV2ZXIgYWR2YW5j
ZSBwYXN0IHRoZQ0KZmlyc3QgZG93bnN0cmVhbSBwb3J0Lg0KDQpGaXggdGhpcyBieSB1cGRhdGlu
ZyAnbWF4JyB3aXRoICdjbWF4JyBpbnN0ZWFkIG9mICdzdWJvcmRpbmF0ZScsIGVuc3VyaW5nIHRo
ZQ0KcGFyZW50IGJyaWRnZSBjb3JyZWN0bHkgdHJhY2tzIHRoZSBidXMgbnVtYmVycyBjb25zdW1l
ZCBieSBhbGwgaXRzIGRvd25zdHJlYW0NCnBvcnRzLg0KDQpXaXRob3V0IHRoaXMgZml4LCBvbmx5
IHRoZSBmaXJzdCBkb3duc3RyZWFtIHBvcnQgb2YgYSBzd2l0Y2ggaXMgZW51bWVyYXRlZCwNCmJy
ZWFraW5nIFRodW5kZXJib2x0IGRhaXN5IGNoYWluaW5nIGFuZCBvdGhlciBtdWx0aS1wb3J0IFBD
SWUgc3dpdGNoDQpjb25maWd1cmF0aW9ucyB3aGVyZSBidXMgbnVtYmVycyBuZWVkIHRvIGJlIGFs
bG9jYXRlZCBiZXlvbmQgdGhlIGZpcnN0IHBvcnQuDQoNCkZvciBleGFtcGxlLCBvbiBhbiBBbGll
bndhcmUgMTUgUjQgd2l0aCBhbiBJbnRlbCBDb3JlIGk5LTg5NTBISywgdGhlIGJ1aWx0LWluDQpK
SEw2MzQwIFRodW5kZXJib2x0IGNvbnRyb2xsZXIgZmFpbHMgdG8gZW51bWVyYXRlIGJleW9uZCB0
aGUgZmlyc3QgZG93bnN0cmVhbQ0KcG9ydCBkdXJpbmcgbmF0aXZlIE9TIGVudW1lcmF0aW9uLCBw
cmV2ZW50aW5nIHByb3BlciBUaHVuZGVyYm9sdCBkZXZpY2UgdHJlZQ0KZGlzY292ZXJ5IGFuZCBo
b3RwbHVnIGZ1bmN0aW9uYWxpdHkuDQoNClNpZ25lZC1vZmYtYnk6IE5pY2hvbGFzIEpvaG5zb24g
PG5pY2hvbGFzLmpvaG5zb24tb3BlbnNvdXJjZUBvdXRsb29rLmNvbS5hdT4NCi0tLQ0KIGRyaXZl
cnMvcGNpL3Byb2JlLmMgfCAxMSArKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNl
cnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9wcm9iZS5jIGIvZHJpdmVycy9w
Y2kvcHJvYmUuYw0KaW5kZXggYjYzY2QwYzMxLi44ZmIwOWNiYjYgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL3BjaS9wcm9iZS5jDQorKysgYi9kcml2ZXJzL3BjaS9wcm9iZS5jDQpAQCAtMzEyNCw2ICsz
MTI0LDE3IEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQgcGNpX3NjYW5fY2hpbGRfYnVzX2V4dGVuZChz
dHJ1Y3QgcGNpX2J1cyAqYnVzLA0KIAkJCW5vcm1hbF9icmlkZ2VzKys7DQogCX0NCiANCisJLyoN
CisJICogU29tZSBob3N0IGJyaWRnZSBzY2FuIHBhdGhzIHBhc3MgYXZhaWxhYmxlX2J1c2VzID09
IDAgZXZlbiB0aG91Z2gNCisJICogdGhlIGJ1cy1udW1iZXIgcmVzb3VyY2UgY29udGFpbnMgc3Bh
Y2UgcmVzZXJ2ZWQgZm9yIGRlc2NlbmRhbnRzLg0KKwkgKiBQcmVzZXJ2ZSB0aGF0IHNwYWNlIHdo
ZW4gdGhpcyBidXMgaGFzIGEgaG90cGx1Zy1jYXBhYmxlIGJyaWRnZSBzbw0KKwkgKiBpdCBjYW4g
YmUgZGlzdHJpYnV0ZWQgZHVyaW5nIHRoZSBzZWNvbmQgYnJpZGdlIHNjYW4uDQorCSAqLw0KKwlp
ZiAoIWF2YWlsYWJsZV9idXNlcyAmJiBob3RwbHVnX2JyaWRnZXMgJiYNCisJICAgIGJ1cy0+YnVz
bl9yZXMuZW5kID4gYnVzLT5idXNuX3Jlcy5zdGFydCkNCisJCWF2YWlsYWJsZV9idXNlcyA9DQor
CQkJYnVzLT5idXNuX3Jlcy5lbmQgLSBidXMtPmJ1c25fcmVzLnN0YXJ0Ow0KKw0KIAkvKg0KIAkg
KiBTY2FuIGJyaWRnZXMgdGhhdCBhcmUgYWxyZWFkeSBjb25maWd1cmVkLiBXZSBkb24ndCB0b3Vj
aCB0aGVtDQogCSAqIHVubGVzcyB0aGV5IGFyZSBtaXNjb25maWd1cmVkICh3aGljaCB3aWxsIGJl
IGRvbmUgaW4gdGhlIHNlY29uZA0KLS0gDQoyLjUzLjANCg0K
