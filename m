Received: from SEVP216CU002.outbound.protection.outlook.com (mail-koreacentralazolkn19012057.outbound.protection.outlook.com [52.103.74.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D561D30677C;
	Tue, 23 Jun 2026 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782229996; cv=fail; b=EWV/8NxqszMkLBLH1MWyw28CBF1rMf5n72TJP6pwpJ8IE9nyDGCi9aKEFE0y21L6VmwxqomRrs2ofrzlwpRxFPrxB7d6n8+uwfTQrT5fsTgNDkBNwwmTugTLTczsJSXhu35fv2Td0iXafaf0pPAFalxCFerOpQ/VZdvienVurNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782229996; c=relaxed/simple;
	bh=bQIP6uS6uesb4k3Uxp4H20tbP0AbQqZ45+ROfs6aUhw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VsTCFcvqotW9QO+f0+z+03cb7rGag0wTlral9RAcRYIJuzQ3lI/VHvynJOsfyMQGIBTMJAHX0Uc6csO2mhKoWhqB886iMdiI8h+GyXKMqUQoB+t4HJ4PKvXyIXw5gXkMc+BQtjF3B5CijvT55Dj+c9ytCJzZFowc3iv1231rikQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au; spf=pass smtp.mailfrom=outlook.com.au; dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b=MNfFFi3r; arc=fail smtp.client-ip=52.103.74.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b="MNfFFi3r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n951GsEfOaOeYnSIb4nvjvhgXlFE/XilOeg7wlcZFLBQyzqFpDQfetSTbGv+amdeEIdvYdZwUbFx/f2JDO2grivbEpoWbjzE9M+v1pS9IBn+a9vrqIAAgJIr6zKI3Z2lqetLsbxn9fEoNSmqtpT4OQX3ciBiV+DA04r5TRzyFgnpELRwRZ4oogeHEV30EECoAoAM2ubLiM167Fyb5TZkyCWxwD4KtOv0n+Kf369y8tmyF1KWNxQLYe60QXXHRPvdEnz1WroBSELOXWZlTjXIiO0yPjwKVqlgtrcetsPjDdiHPAc4wrFoy/sl4AHnsmqokW30V7T5T149LWb6MCCyUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQIP6uS6uesb4k3Uxp4H20tbP0AbQqZ45+ROfs6aUhw=;
 b=v4Fti5rBkMz381CT+t/vsx+4ibdNd99OWMyQscnVcM/S5Y+mkHQU9YH3UzlUTqnJloZTqtjm+LbEYnG92SR6oaJYqGtGtdPymyqJMh7TClRs1UUZ6jcusNyGQ7RvfAu22TImRyf3s6klHipKCJzmEisY7RmeNnLSnlKgTtum2iAG0LIo7jfq0+jJ1FjZFn4o0VeBVbe592yB41c9K+U6lb6/LIHG+UCACUoSgOrH6O4dlnvhQ/mtxjW8zuJK31kZ1N8hT/7hDH4KtfNfYLxCztFMupQskSKBFeMnnOBtDGEEmEG1nwgdGkK16ZGaSdcHI886n26nQNjgJsESa+ePPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.COM.AU;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQIP6uS6uesb4k3Uxp4H20tbP0AbQqZ45+ROfs6aUhw=;
 b=MNfFFi3r26sllp8CS7dQh5yNreTpB6fkgwmYBJP9MCo2Mjoc5iqxW6LNcAWNBQcNMIUucZY4VEw/o9qfrEc1sAmNSkCIOQZIdtjKSRQMHvemxlxZXrprm1Itko3fjukHaEIDhgo2DvwbsJZ63ppfQPZGQfxplZPBy04WfzBU9hewo9nBpSaAHAhBP5g960GBo1FxsipHgU15/LyruMKKVSUfCADRc3UhU0dO4wb/HcpjeAgv9Im8CTBZN/l0G8GmeImSJ6aqN8GhxlYEHqxpmGIzsvmGlLEdMRA5V8sCT+yVnm40R0swc8chJuLbZ9BspaDl0Tpsy9CiHTiGVNi5ag==
Received: from SE2P216MB1523.KORP216.PROD.OUTLOOK.COM (2603:1096:101:2d::7) by
 SE2P216MB1686.KORP216.PROD.OUTLOOK.COM (2603:1096:101:fc::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.20; Tue, 23 Jun 2026 15:53:11 +0000
Received: from SE2P216MB1523.KORP216.PROD.OUTLOOK.COM
 ([fe80::7e41:a55e:876d:dff2]) by SE2P216MB1523.KORP216.PROD.OUTLOOK.COM
 ([fe80::7e41:a55e:876d:dff2%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 15:53:11 +0000
From: Nicholas Johnson <nicholas.johnson@outlook.com.au>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Nicholas Johnson <nicholas.johnson@outlook.com.au>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/1] Fix Thunderbolt enumeration
Thread-Topic: [PATCH 0/1] Fix Thunderbolt enumeration
Thread-Index: AQHdAyhklgOqlW0gs0SfSZVoSTQqbg==
Date: Tue, 23 Jun 2026 15:53:11 +0000
Message-ID:
 <20260623155256.32688-1-nicholas.johnson-opensource@outlook.com.au>
Accept-Language: es-PE, en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE2P216MB1523:EE_|SE2P216MB1686:EE_
x-ms-office365-filtering-correlation-id: 3f563708-062e-453a-c74e-08ded13f8727
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|15080799012|22121099003|24021099003|25010399006|4140399003|38102599003|8060799015|31061999003|37011999003|19110799012|39105399006|55001999006|3412199025|102099032|440099028|40105399003|56899033|12091999003|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?bmhsZGNEYTkvc1NZNm5CSUFtR3dHL2pySTlabVgvL0hxeDhVVHB2UFFuNXF1?=
 =?utf-8?B?b3pQMXgrOWhqUEFiNUt5cVRoUjNjVzJJN3hqSFZPOGhhUVpGWGxqZHNzUzJs?=
 =?utf-8?B?TWhEN0g5ZG9senoyK3luc29Qc0VqczJHNGhvTVp1akNCb3RVaVFJMTc1YnF1?=
 =?utf-8?B?VzZlODJ2ZW1Ea2JpbytMbmQ1WEhMd0JFeFh5eDJHaDZMM0FsaEltZC9vUER0?=
 =?utf-8?B?THZrdWhZdlZ1WW5TQ2RMdHhibXJ3eUxJdXdWZW5RVXRUUytoUTFDL2M4MXp4?=
 =?utf-8?B?Tkh4V01Oa2VsK3RlTWpzSVFyYXBMTzVrYmEyMWQyTCtQZC9jdUxnRW9mbHow?=
 =?utf-8?B?NXFCL2s5dXhaMjhpLzV5NCt2RXlCNFNQU1NiY1pxaWtoQi9JMEloTlV0YW5h?=
 =?utf-8?B?Rm43dUl3cGxIQnczTHZmUGZwSHZoNXdUbHpXZzRKclNrbEVsZGFaZk03ZzBC?=
 =?utf-8?B?STB5c1BMSllsamdJWmpORHpWZUdxekZCV3g4ZHhYLytuZ0NJOEhDNnRuYkF0?=
 =?utf-8?B?SXJUeXIzZDduZTU1a3dBV0JPbVNCdTMvY3BEdFByMHQwaUZ0TWNTZEY3TlJo?=
 =?utf-8?B?cWxTdnJheHRoYTF0VEUwbkwrb0lVdzBUTDlzMkZpQlZDcmhTUWtxVUpLbVZW?=
 =?utf-8?B?c1YvK0hIZm1jVjR0RGtZbGVZSmNFVnVlWFBtVW5PMld5NWREeG5mK2c4WFpj?=
 =?utf-8?B?M2RQWHZtV3pLQ2duV1QwMmRVcGRjbmMvUUVhMWNWOUxQMkI1cUlLcTNNMDBP?=
 =?utf-8?B?Y1VxalQrem9qVitGSTBxTmZCNnE0d2p0YTRSMFgxcUpLZVlER3VyYXVHaEF0?=
 =?utf-8?B?VGhhQnp1YUVubnZpQW5tOVVwQzl5TWRLSmpXdkVUQjZWcENyVXE1L1h1R3Rz?=
 =?utf-8?B?S2ZwTlB0b2I0TGowZWQrVXFCMDBkdDBtRTlhNVgzQzVVaUluS2hxdnpiMFcr?=
 =?utf-8?B?bUJDUlRvWTgydVFSRlF6ektQalI1elNlMWp0TmhZNkN2a0lodXE4QUVCMkFD?=
 =?utf-8?B?d21sTTdqVG5NV1hCTTNJUjhRLzBtcElMbzJJeVJrZnVSYmtCTHMzRFg0WCtK?=
 =?utf-8?B?OVhUYktBaXFwQm5GUTRPTXJkR3NKWHl1Sk12eFFGOWRrYWEvcGJ4NWJCYVVO?=
 =?utf-8?B?VkdqTmxUZUpHNHFaMEJKems3S3hORW9WZWJQYzFUZFFsTHBlZ2RxRkJOWDRv?=
 =?utf-8?B?MVl4WVB1aW1rbVNHVzNqNzZyOTcvRjRSWWVWdklSRVZBbXNlK0VES0V5SGZh?=
 =?utf-8?B?dUFjcGZORzVHK2hNR29tRXA1d0g4Y3Z5UG4wM1JFMG4weWc0MUpuc1pNWXpt?=
 =?utf-8?B?K3FMY21RZFhyTysvdlhsbnlFMHA2b3drTDBkbURzZ1B0UUNCMFlUeGVZMW9j?=
 =?utf-8?B?S1FjVFEwaHBqZm9OUXFZN3ZUN25uYm5FZUJoTnFzejUwYmxkaDlvZU9XZzdj?=
 =?utf-8?B?ckFtaU80aFh2bUx3bHNBWitpZVI1WXJtRjhGK2RHcThjSzdYMWhGN3ZTQjlN?=
 =?utf-8?Q?IPEaZvGfyZS16LmOv06I14XSxee?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VFVnVGt6Y2FvSjNBSmZvcGVMMGp4by9KcWhieFFmR3lSTVlBbFRmVzhKN2pM?=
 =?utf-8?B?cGlVYXM3THNnczNUb0RCN0Q3L2x1Y0dvZ3pQZEF3VkFoVEVEb2RaQnJYUEI2?=
 =?utf-8?B?VWZidndiRlVaVnpWcXpNSUhGRDdSTmZBa0VQSXVkSmx2NzNjUzIzVGhzcCtE?=
 =?utf-8?B?V09GZDJzbVRsVjJ4UWd0dFRsNE1zeDdDeldrNG9pc25sTzRCdnJ3ZS9lYmps?=
 =?utf-8?B?UkNFSDJ4MGQ4bko2czA3RWxmSUluWUF5aG9RcEpqbEFpNC9RNU9WSXQ3R01D?=
 =?utf-8?B?TkRXNUdwT1gwUzAzdlptQzJMZ2Z6T2JSOXZYSXhlWXhwN2VORVJZZ1dxNUlB?=
 =?utf-8?B?TkU2ZjljNGpTWFIwTEJYa3ArNXB1TG9SYVhjT1puclhJdVYzRHhXWVcvTjRF?=
 =?utf-8?B?UFlHalJsQUt6dzlXVmJ0Y3E0M3VRazZIYjExOW9jMUw0c2ppN2hkb0tQTm1y?=
 =?utf-8?B?TXdaUUhaRmdyQlJCajIyOVJlOTZueHNaVlpEQkJEYTJoaFd2TE9ZR2ZCSitJ?=
 =?utf-8?B?M2lvZnhnaTNuYlQ1RGUwNjVsV2lOUEVQRC9XTDRtNXFMVWdGZ0V6QkhYcmlz?=
 =?utf-8?B?Y3pTRDlJd1lSanJ6N0lvdUtTWWl5UEpkaVh4eGpTQlU0YjRxUXhENTk4ajlF?=
 =?utf-8?B?dnYvbnpZcWx3blpkZGhzUmhtOUhqZ1M1YzFIcENFVzRrMzVrQ29Ld2hlUkpB?=
 =?utf-8?B?VU4rRkhmd3ZjRWRjdmdsOEJxWmVURUY3U3ZzQnduWlNhSUMzNDBJeGp2V3FY?=
 =?utf-8?B?bGJPczB6T1ZoaUZtTHR6VlR2ampQSU40QytDTmIxaTlHL09raW1BVkFjS3NF?=
 =?utf-8?B?Qm96alQ4czV5eEVqblFKRVFHVWpKT3ZoK0xWcDcvaXZEa3Q0QWcrOG1FR2dm?=
 =?utf-8?B?T3JyK1dEUnozQlZyTnRJcnMxTU1HL3Jwd3k0REh1cy82RE5lUmVVUWs2ay9S?=
 =?utf-8?B?SWdpTFZDK3hnVGw1K3RtbmR2U3ZRYjlaTnB4SnhrcDhFMXlnZklUdUpDSHB3?=
 =?utf-8?B?TTNpNXk2STF4cXA3YnRxdlpvbmhjaHJIbFJSRHJZQWpSZVdzL3BCeVRBLzY5?=
 =?utf-8?B?cVRVKzBWeWVZQzFCWFU1OHlDaW9jSVBaYXdGeVpCWnFacVNDTzNtd05JMGRQ?=
 =?utf-8?B?V3BaVTg2RUJ2RHdMQlUzTXhEUnZBekkyWkNHOXA5aXllQ2lZcXMyYkFheVU3?=
 =?utf-8?B?azFYK0tWNzRIOE1xaEJsSWUxdmlRNmlrZFlIaFMzMkxaQVJ5c3ZZdWpuR2U5?=
 =?utf-8?B?VWtxZjZvdGxhSjdUUlM2YWZpVU5GTzIrZ29TOXo5QTh1R1A3Mng1WEEvbzYx?=
 =?utf-8?B?czJjRFZFSk1TcVZaVWJJRVNUMkdZdnk4SW02WG16enRZQ0NjWVd3ZjFEUUE4?=
 =?utf-8?B?Rk5GUUhrZENuNzF3eFdEL3Jic2lUL1hZeXdZQVBVYlk1UlFyK0RraExnUEpN?=
 =?utf-8?B?UjFocEVaS2swYWxBYUd2Y3hIN09UeFVCekhmcStybXFSZzhjU0hzdnFVL0F0?=
 =?utf-8?B?cXFVZWpnbG9nVUxRZVZML3ovNmNJQW9oWUxEcEtkMzBCTDg3NGx0ZnhxWjZK?=
 =?utf-8?B?MmNSaDZ1WmlqMDZGcDN1UWdaQW9sKzRKSEdTVGVibFNyRTB6ZllZQkVmeDIy?=
 =?utf-8?B?cEFYQktQVFJqWFU3ejBFNWZka2tKN2hSQXJQVTZiOFRNUEdabU5JUXJuQ1NV?=
 =?utf-8?B?OXpzL0tZQjB3ZjFJUVVRZy9BdFptMDlneG9Vc2pjeDF1dEpGcUR4eG04UGRp?=
 =?utf-8?B?dGpZYnV4RUxqRjVXWTBEU25RQnppaVRxUnczd21ZMjljYzZueWxrdnZJTXA2?=
 =?utf-8?B?MHJqWkpOdnRINHJkc2o3YXRXenN5OTdqVzhraU5uSmtlL2VodVBKZXFsb1pw?=
 =?utf-8?B?OTNVL1ZyNGNCaTFYaHRiOGNoTlJuZjhyZnM2NGJYQjgwcXc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f563708-062e-453a-c74e-08ded13f8727
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2026 15:53:11.3365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2P216MB1686

SSBoYXZlIGFuIEFsaWVud2FyZSA4OTUwSEsgd2l0aCB0aGUgVGh1bmRlcmJvbHQgMyBwb3J0IChK
SEw2MzQwKSBhbmQgT1MgTmF0aXZlIA0KRW51bWVyYXRpb24uIFVubGVzcyB0aGUgVGh1bmRlcmJv
bHQgZGV2aWNlIHdhcyBhdHRhY2hlZCBhdCBib290IHRpbWUsIGl0IHdhcyANCmZhaWxpbmcgdG8g
ZW51bWVyYXRlLiBJIGhhdmUgbm90IGJpc2VjdGVkIHRoZSBrZXJuZWwgdG8gZmluZCBvdXQgd2hh
dCBjb21taXQgDQpjYXVzZWQgdGhpcywgYnV0IEkgb2ZmZXIgdGhpcyBmaXgsIHdoaWNoIEkgdmVy
aWZ5IGZpeGVzIHRoZSBwcm9ibGVtLg0KDQpIZXJlIGlzIHRoZSBwcm9ibGVtIHdpdGhvdXQgdGhl
IGZpeCBhcHBsaWVkOg0KDQotWzAwMDA6MDBdLSstMDAuMCAgSW50ZWwgQ29ycG9yYXRpb24gOHRo
Lzl0aCBHZW4gQ29yZSBQcm9jZXNzb3IgSG9zdCBCcmlkZ2UgLyBEUkFNIFJlZ2lzdGVycw0KICAg
ICAgICAgICArLTAxLjAtWzAxXS0tKy0wMC4wICBOVklESUEgQ29ycG9yYXRpb24gR1AxMDRNIFtH
ZUZvcmNlIEdUWCAxMDgwIE1vYmlsZV0NCiAgICAgICAgICAgfCAgICAgICAgICAgIFwtMDAuMSAg
TlZJRElBIENvcnBvcmF0aW9uIEdQMTA0IEhpZ2ggRGVmaW5pdGlvbiBBdWRpbyBDb250cm9sbGVy
DQogICAgICAgICAgICstMDEuMS1bMDItMDldLS0NCiAgICAgICAgICAgKy0wMS4yLVswYS00Ml0t
LS0tMDAuMC1bMGItMGVdLS0rLTAwLjAtWzBjXS0tLS0wMC4wICBJbnRlbCBDb3Jwb3JhdGlvbiBK
SEw2MzQwIFRodW5kZXJib2x0IDMgTkhJIChDIHN0ZXApIFtBbHBpbmUgUmlkZ2UgMkMgMjAxNl0N
CiAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArLTAxLjAtWzBkXS0t
LS0wMC4wLVswZV0tLQ0KICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IFwtMDIuMC1bMGVdLS0tLTAwLjAgIEludGVsIENvcnBvcmF0aW9uIEpITDYzNDAgVGh1bmRlcmJv
bHQgMyBVU0IgMy4xIENvbnRyb2xsZXIgKEMgc3RlcCkgW0FscGluZSBSaWRnZSAyQyAyMDE2XQ0K
DQpBbmQgaGVyZSB3ZSBhcmUgd2l0aCB0aGUgZml4IGFwcGxpZWQ6DQoNCi1bMDAwMDowMF0tKy0w
MC4wICBJbnRlbCBDb3Jwb3JhdGlvbiA4dGgvOXRoIEdlbiBDb3JlIFByb2Nlc3NvciBIb3N0IEJy
aWRnZSAvIERSQU0gUmVnaXN0ZXJzDQogICAgICAgICAgICstMDEuMC1bMDFdLS0rLTAwLjAgIE5W
SURJQSBDb3Jwb3JhdGlvbiBHUDEwNE0gW0dlRm9yY2UgR1RYIDEwODAgTW9iaWxlXQ0KICAgICAg
ICAgICB8ICAgICAgICAgICAgXC0wMC4xICBOVklESUEgQ29ycG9yYXRpb24gR1AxMDQgSGlnaCBE
ZWZpbml0aW9uIEF1ZGlvIENvbnRyb2xsZXINCiAgICAgICAgICAgKy0wMS4xLVswMi0wOV0tLQ0K
ICAgICAgICAgICArLTAxLjItWzBhLTQyXS0tLS0wMC4wLVswYi00Ml0tLSstMDAuMC1bMGNdLS0t
LTAwLjAgIEludGVsIENvcnBvcmF0aW9uIEpITDYzNDAgVGh1bmRlcmJvbHQgMyBOSEkgKEMgc3Rl
cCkgW0FscGluZSBSaWRnZSAyQyAyMDE2XQ0KICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICstMDEuMC1bMGQtNDFdLS0tLTAwLjAtWzBlLTEwXS0tKy0wMC4wLVswZl0t
LS0tMDAuMCAgUHJlU29udXMgQXVkaW8gRWxlY3Ryb25pY3MgSW5jLiBRdWFudHVtIDI2MjYNCiAg
ICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFwtMDEuMC1bMTBdLS0NCiAgICAgICAgICAgfCAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBcLTAyLjAtWzQyXS0tLS0wMC4wICBJbnRlbCBDb3Jwb3JhdGlvbiBK
SEw2MzQwIFRodW5kZXJib2x0IDMgVVNCIDMuMSBDb250cm9sbGVyIChDIHN0ZXApIFtBbHBpbmUg
UmlkZ2UgMkMgMjAxNl0NCg0KDQpJIHdhcyBob3BpbmcgdG8gZ2V0IHRoaXMgaW50byBMaW51eCB2
Ny4yIGFzIGEgbGFzdCBtaW51dGUgYnVnZml4LCBidXQgaWYgbm90LCB3ZSANCmNhbiBhaW0gZm9y
IDcuMyBob3BlZnVsbHkuDQoNCktpbmQgcmVnYXJkcywNCg0KTmljaG9sYXMgSm9obnNvbiAoMSk6
DQogIFBDSTogRml4IGJ1cyBudW1iZXIgYWxsb2NhdGlvbiBmb3Igc3dpdGNoZXMgd2l0aCBtdWx0
aXBsZSBkb3duc3RyZWFtDQogICAgcG9ydHMNCg0KIGRyaXZlcnMvcGNpL3Byb2JlLmMgfCAxMSAr
KysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspDQoNCi0tIA0KMi41
My4wDQoNCg==
