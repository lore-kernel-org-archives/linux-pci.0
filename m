Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010011.outbound.protection.outlook.com [52.101.229.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6DE1EB5FD;
	Fri, 17 Jul 2026 12:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784289715; cv=fail; b=l6sVdL1j6Vzzf1CX73/slqVxnnesGrMfKw8tUoz6NzEiUNoeVveVtcU70DYC9/ZodI0cmHP96V1NOvOSGinmFkL4kmD/MeheXcvbVeFYJzpN3ycioWmZo/hB3VKz4OFaj9xiP6fp4avuH20jG6doVFdRQMi8K+Z8WrY8k8quqKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784289715; c=relaxed/simple;
	bh=PGynGJIq1bGpzL1HgYNzpA8LMMGaStzOgJQkaeWU+MY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jr0ibfltEnBRrOeEGe92Suw69sEUUk62ADIGGBXqC1PBeJmB8FO6PAJZnHM0gZvoc1cP7v5A3KWKvyXIlq/aitYKHDOpCt9SpcCZahpmDXP0S/2g62yFhSvJDAHBKGrXLqReptxUz+Z4Y9ApfMOxykIJj6Q5+h81M9UCMDuZjww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nec.com; spf=pass smtp.mailfrom=nec.com; dkim=pass (2048-bit key) header.d=nec.com header.i=@nec.com header.b=tKgIyoAd; arc=fail smtp.client-ip=52.101.229.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nec.com header.i=@nec.com header.b="tKgIyoAd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wIsFUX5TymNhBlWLYkPyqm4llOGrktmYT49annvCaY2bsI714AkuU0ZiEibXZNffpPoK1B4BhYmoZh1GNCMdfYEvMw5To6VOWYnIRkbQPmVVi9KSMWHgFV3rxRQ26HUsrgaAQjsdTfkUhW6WMrR5ZeJaJGwS0VCgHT+z6gdMZZa7lAa2h6roFMhW2m9/1NBYQ6X2x5W6K5hs9XqdVmycqZdwAOqHcmmhNMOmiG0fH2j0+3OWdg+jlV66Zk0JJrfTSLKsSv+hzSSmXODKTXJBbr6OEwUJD3fVWezaDHAKb6GSiJ5SzRizylKZT0gI63wPVb7ISlI/9JrphBF7LRfLfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGynGJIq1bGpzL1HgYNzpA8LMMGaStzOgJQkaeWU+MY=;
 b=ytugpz0RfyDyne0+6OEiQOaQMoC5VSj2Du9hEiDkhH5GguTQUBE4wVzxLkfIcdJn/S515PBUwb3/hJd+x2BTcd5XjbM7SNo/YgygwPNEGES3wItwx/Nd5osbMrmV+jwpvRQNr1de8dsQ2659HT4k3tHlgDJgMjEbsniEr/a+Bs5JjYxTvGovJdJ69nj2OtT01rE3Ar3keD18gJO/4ExI1wZOjIFHjS2BNugAmgI9Geor/CvgrsEo6/y8Z3cc/+X/HD16ZAricD7mVUoko2DP/zGHxklyuQhXM5XorobC4jGYjvmcfqRgVQ+n046kfjVuDhVaJir+SNj4H4BZARP7iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGynGJIq1bGpzL1HgYNzpA8LMMGaStzOgJQkaeWU+MY=;
 b=tKgIyoAdN604rxx+ZUGULqQr2Kd4NKASby8txyES/E6xIG5Oza7FOBv7z0QdVLePfO5CLobzBCXQCCButuT3xwu+QY/0pxLFjhlOcPeuiZQuN8UmHuoFSnKXVJVvsQQllFFRSwPk8fOHBEPsFjJCFVN1C1u1iuf4E/vkUfhqJ/FAHMekT52wTJ7UJvmju/MN5NLDST+Xal9KfKVU+ngzENM89O+ZHGfmbs9RnBI3W1vS4SJBnV/I4SZQ/zXDfFqyjuidlIQmWMkaOZtTDqaDj+qWoxSGkC3ecWdsPx7JfaNqOPqCuG92CPLqfX1BmDKbdvdp58ljEyXXxw6KT5wcwQ==
Received: from OS7PR01MB17384.jpnprd01.prod.outlook.com (2603:1096:604:43c::6)
 by TYRPR01MB13474.jpnprd01.prod.outlook.com (2603:1096:405:1cc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 12:01:50 +0000
Received: from OS7PR01MB17384.jpnprd01.prod.outlook.com
 ([fe80::e19a:50c0:4d9c:1bb6]) by OS7PR01MB17384.jpnprd01.prod.outlook.com
 ([fe80::e19a:50c0:4d9c:1bb6%7]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 12:01:50 +0000
From: =?utf-8?B?S09ORE8gS0FaVU1BKOi/keiXpOOAgOWSjOecnyk=?=
	<kazuma-kondo@nec.com>
To: "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
	<lenb@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>
CC: "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [REGRESSION] ACPI: PCI: misleading _OSC failure message when _OSC is
 absent
Thread-Topic: [REGRESSION] ACPI: PCI: misleading _OSC failure message when
 _OSC is absent
Thread-Index: AQHdFeQMAS/v/uLN7UirAHJi05upjQ==
Date: Fri, 17 Jul 2026 12:01:50 +0000
Message-ID: <d0be949d-0e21-472e-a44b-cedb1dd8695d@nec.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB17384:EE_|TYRPR01MB13474:EE_
x-ms-office365-filtering-correlation-id: b8a77851-affa-4b71-e614-08dee3fb2f62
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|18002099003|38070700021|11063799006|56012099006|10067099003;
x-microsoft-antispam-message-info:
 CuauDpOhbnsMRePLrUQoNFVSVSD0kX+PAatkdkXjCDfp98mOSa60CSmgVbf6mlxyxsC6ZjY7eBTjE9sUrU3J44Cfjj4ZkQpwXMNm4nlO0ldBl9dtrJPh7p8QJGLf+CmYkk9Wkte5WOvZQ8vV61jWzyzvPfpVU6FsX2ls/7OJBA0rEre9tVI5haGobvAwBMHhAqUGa9wDslYHv5/HzJl0e1FBR51BNQ2jUq2Ck2s4LCYgk//9dRKSvsN78GrUqkDhTja9PfsGmfHdKhHBPxwUBPPEWB+CRa27vJuXFjsKWt78H/Zx5mNfgKdD2jlYAoTGeUJ2NHfCPw1Hzz+N5OgoPA+gxHh8L2CcWesFd7FTc3NeXonv0zcTuub+kqVSj5kF22vAvy3zevX4lSqM7rWO8tFv2AHEtnvOTRJRqwJiDUEe6R12EUU56bTdFZOvGaWjX2nkntpWFEa4C0pvdeD5t0SiWLDy3wYqhXUdbQABdnNVvDSuxpYafR/URN0iHSY+eXehUKARk3//BxnuB1bk3luyDqkCxklOwgu4WkymjOddocWy3AuLJIXqkXAQtbaRXzs/nxmRy5mdFa7XmX5YaBaeXzpVW2ZP4t69o+CHy0gNaR+u8QFHQdmAkK4+Sa9JwznGlXl5U82/zudiiVEozzFIacs/5Msu1WuQaVDTS+j/lMfsTULWh9MaBEJVE76WFRfFG+lWN7pCses7Fm12LT0N3JfBURxQLPFWXjRdVa4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB17384.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(38070700021)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YW81UTJaZnlDMXRoc2E3dWZXT0VVN3gxM0xoNXRRTFFuaVBlSXkyRURQQ2Qz?=
 =?utf-8?B?R25Lb0E2bnp4RjNmdXlzZG5NWTlvQW10bEVOc2NnZ1dWWVNuZG1KNy9uNWRp?=
 =?utf-8?B?dlFVdDNuVzE4bHVLaVVVbEs5cjF5OFlCY1VqZ0QzMVduZjBwakZuVm5iTXZp?=
 =?utf-8?B?d2t4b0NVSEErWldFZCtkNEhxdDBjY3dwT29sL0xpejViNzVOQVY4aGFGeWJi?=
 =?utf-8?B?bGxiNWw5M3lIc1NrZHA5cmI2SnN2ZEdWLzJqT0JtalRKc1dzOE1ESnBTd1Rx?=
 =?utf-8?B?YnJnZ2lyaGJLa0FVTHBMZU1TTis2WTN0QnhnOEl0ZG5lYnpkN0J1a2xKcm8y?=
 =?utf-8?B?MGN5NU5lZTFMdE9mcU80eHFFNHRMZk5ZTzczQ1JBK3hvZGhlcm9WeWxNNWZk?=
 =?utf-8?B?eldsanArbW5BMGJiR3c0MG9VRmtPbWxUT2EzRXlCUzdrazNrTXNSZTVIRVlY?=
 =?utf-8?B?SjRISjdiMXQ2dU0rcWc1d0RwNFFMTTJseUhJU01vcVZoUDBrWUpZRVhpeXFj?=
 =?utf-8?B?NUovRzBPbmF0YjhNSmFmOW5taG5CVHFYc0dBYmF0NHJVNy9QVG5EVTRSaFlD?=
 =?utf-8?B?NVhpcFprZVhlWGxoUkQxaEVKdGhNK0o1V0l2VEM5Q3JTQ1FXV1QyTGlyamlU?=
 =?utf-8?B?WnorM280eFc3UWI0WE5xVkNud080aFA1SFdkcUtlSEhsZk9WalI5T0FnVWJw?=
 =?utf-8?B?WExwMitLVlQ4RnJMTUJZZTFqZm9iSmQ5ckE3bFNYOTlmci9WVW5yQmp5WjdX?=
 =?utf-8?B?bGhiNnNmZFFOM2g1OHNCVlB5Z3k5SWM0c0ZRbUhoRHViTmZyb3gvTExnczNC?=
 =?utf-8?B?Ym1YM0dBSENwZnRUZU9LREFaVjNZajVzN3pkSy8zZ2F3Sjc2THhqb09aaE5s?=
 =?utf-8?B?bzMrS25XeDFJa2J4aXFvUjh5YXJReXlUS014OU12MzhhMi82WURRY2JTV1ZZ?=
 =?utf-8?B?a0lLbDFJQVNDbnZBUUc0SnVuM3haV1JGZzQzcGc0bEdpYlYrS0crcFFCZ2Fm?=
 =?utf-8?B?R1l6ZVhzeXgyZEJ6Y2QveFpkY2tRNW9XalVNWXU4R041TEFtZkoyOXdocVk2?=
 =?utf-8?B?UUdVa25GV1lOa2hkZ3ZhaVBMcmRHb0FlNG1zMjI0aGxIZGMzM2FwczJhOGVl?=
 =?utf-8?B?RG1BTnBNdCtoM1UvbGFpSXcvbVhEU0JSOUgyTkZLeExSd054b0dqcktKZHcw?=
 =?utf-8?B?SWtGOW5INHVhemhhZVA4b0JVVFB0b2V4bng1bFhOcDl0aDdGeWJqQTNTTkdR?=
 =?utf-8?B?V3VDU2gzbWxXaStNYkpKUWMwK01lck9zUmVmbW5kNEVNbG9BalUwNnNpS2JN?=
 =?utf-8?B?em15Nk5RQWltTFFBVmhUaVlVckpPZllmN25meWIyaHArbUxsN2N2T212RUZi?=
 =?utf-8?B?MHdvZzdud2NkWWNVTUVRK1ZhMHVJVk1OL1I0VjFua0piWTJ4Umo5M3JYVXZ1?=
 =?utf-8?B?RlZwQkJuajNoTVpVUElzWmxQMm94M0VjWUlPeU1UNkJkamlRYVBraHQxakxS?=
 =?utf-8?B?THVZLzIvTktHRmxXSzgzN2ZwcHhwU1lGMk9jTjU5TlpTUUY3THp2K0prbnYv?=
 =?utf-8?B?eVo1b1RQR1NKUk1PR1RjZlkzekpaNThHS1ExNzBIZVpPNncyV1hENUZhaFhh?=
 =?utf-8?B?RUJKL3c4UlJqQjZPbCtDS2NEWWpObzNId0hNKzA5ZlJMeVFraFBxWXVsZnhj?=
 =?utf-8?B?OXljd08ydlkzZksvdU1FMFduR09tb2JkdWpSdFhTMldpZTUrZ1g3WjJOR3Bp?=
 =?utf-8?B?V0NicDQxZjJ4RHV1RFAvR2hjMXdoWXFHRldIK1hONGlJL09ZV3hvdEdoNS9E?=
 =?utf-8?B?LzRJQXg3MzlEV0NhZkFuNDNoVWJqY090TS9MRC9wN3ZFVE1kcmkzOUVFWkcv?=
 =?utf-8?B?eHN1cHMvb2dpZkhRTmdRQnRQZmV6QnY5R2RJbm5hNEpSWUVhcXRUTXBINE5l?=
 =?utf-8?B?N2VudUptNVI0eUErSlcyaUh0RS9HSDNPeVFnaHMvTjZscE52bWtJUDRvWEFq?=
 =?utf-8?B?WXZ6VnhPK1hzMlNnY3o1bFZIbGJZY3RPNkpxTjkrYnp0UXhSZVFIUENjNzRn?=
 =?utf-8?B?SmVMQXpoNm5aVkNrTDJ0cTJZaWFUUWZWZVRDRkdTWHFxcTRLaVdnTTNWRUln?=
 =?utf-8?B?bGVnanZidFlWdGFMWEVnM3FMeGVIYWFEbjA0R0dvdWNMU0Z5bU16SkhOcTZT?=
 =?utf-8?B?bnV4Q045VkQ4R0NpVjdZWVBteFExaCtBMjJYeVhCMzVwNHJiVExHME1xRXJu?=
 =?utf-8?B?YmNpS05VR3F3cTlwOWg0eCtRc2hjdDRXVFhTSFBNWlk5UHl3NkJRSmJCRzRH?=
 =?utf-8?B?aXd5bmVrU0NzaVNGakNjWW02cXhSZDNITXpsM3FVSDZaM2dqbWtFUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <535B3A67D103C24C9B090679516630EB@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB17384.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a77851-affa-4b71-e614-08dee3fb2f62
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 12:01:50.3947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KDLzNaqjtHe+iqJOsW6vcdMZGyHq5xFT3BumnXfp9N6jSi2Dlxc3fRSXyFpm88il/dj+NVhvHftNMBqmsks4ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13474

SGVsbG8sDQoNCkFmdGVyIDdkNzAzZGY3ZjRmNSAoIkFDUEk6IGJ1czogU3BsaXQgX09TQyBldmFs
dWF0aW9uIG91dCBvZiBhY3BpX3J1bl9vc2MoKSIpLA0KQUVfTk9UX0ZPVU5EIGZyb20gYWNwaV9l
dmFsdWF0ZV9vYmplY3QoKSBpcyBoYW5kbGVkIGFzIEFFX0VSUk9SIGluDQpuZWdvdGlhdGVfb3Nf
Y29udHJvbCgpLg0KDQpJIGhhdmVuJ3QgeWV0IG9ic2VydmVkIGFueSBmdW5jdGlvbmFsIGlzc3Vl
IHdpdGggdGhpcyBjaGFuZ2UsDQpidXQgSSBzdGFydGVkIHNlZWluZyB0aGUgZm9sbG93aW5nIG1p
c2xlYWRpbmcgbWVzc2FnZXMgb24gbXkgSW50ZWwgc2VydmVyczoNCg0KICAgIGtlcm5lbDogQUNQ
STogRW5hYmxlZCAyIEdQRXMgaW4gYmxvY2sgMDAgdG8gN0YNCiAgICBrZXJuZWw6IEFDUEk6IFBD
SSBSb290IEJyaWRnZSBbVU5DMF0gKGRvbWFpbiAwMDAwIFtidXMgZmVdKQ0KICAgIGtlcm5lbDog
YWNwaSBQTlAwQTAzOjAwOiBfT1NDOiBPUyBzdXBwb3J0cyBbRXh0ZW5kZWRDb25maWcgQVNQTSBD
bG9ja1BNIFNlZ21lbnRzIE1TSSBFRFIgSFBYLVR5cGUzXQ0KICArIGtlcm5lbDogYWNwaSBQTlAw
QTAzOjAwOiBfT1NDOiBPUyByZXF1ZXN0ZWQgW1BDSWVIb3RwbHVnIFNIUENIb3RwbHVnIFBNRSBB
RVIgUENJZUNhcGFiaWxpdHkgTFRSIERQQ10NCiAgKyBrZXJuZWw6IGFjcGkgUE5QMEEwMzowMDog
X09TQzogcGxhdGZvcm0gd2lsbGluZyB0byBncmFudCBbUENJZUhvdHBsdWcgU0hQQ0hvdHBsdWcg
UE1FIEFFUiBQQ0llQ2FwYWJpbGl0eSBMVFIgRFBDXQ0KICArIGtlcm5lbDogYWNwaSBQTlAwQTAz
OjAwOiBfT1NDOiBwbGF0Zm9ybSByZXRhaW5zIGNvbnRyb2wgb2YgUENJZSBmZWF0dXJlcyAoQUVf
RVJST1IpDQogICAga2VybmVsOiBQQ0kgaG9zdCBicmlkZ2UgdG8gYnVzIDAwMDA6ZmUNCg0KQmVm
b3JlIHRoZSBjb21taXQsIHRoZSBsb2cgd2FzOg0KDQogICAga2VybmVsOiBBQ1BJOiBFbmFibGVk
IDIgR1BFcyBpbiBibG9jayAwMCB0byA3Rg0KICAgIGtlcm5lbDogQUNQSTogUENJIFJvb3QgQnJp
ZGdlIFtVTkMwXSAoZG9tYWluIDAwMDAgW2J1cyBmZV0pDQogICAga2VybmVsOiBhY3BpIFBOUDBB
MDM6MDA6IF9PU0M6IE9TIHN1cHBvcnRzIFtFeHRlbmRlZENvbmZpZyBBU1BNIENsb2NrUE0gU2Vn
bWVudHMgTVNJIEVEUiBIUFgtVHlwZTNdDQogICAga2VybmVsOiBQQ0kgaG9zdCBicmlkZ2UgdG8g
YnVzIDAwMDA6ZmUNCg0KIlVOQzAiIGlzIGFuIHVuY29yZSByb290IGJyaWRnZSBhbmQgZG9lcyBu
b3QgZGVmaW5lIGFuIF9PU0MgbWV0aG9kIGluIHRoZSBBQ1BJDQpuYW1lc3BhY2Ugb24gbXkgc3lz
dGVtcy4NCg0KUHJldmlvdXNseSwgd2hlbiBhY3BpX2V2YWx1YXRlX29iamVjdCgpIHdhcyBjYWxs
ZWQgZm9yIFVOQzAuX09TQywgaXQgcmV0dXJuZWQNCkFFX05PVF9GT1VORCwgYW5kIHRoYXQgc3Rh
dHVzIHdhcyBwcm9wYWdhdGVkIHRvIG5lZ290aWF0ZV9vc19jb250cm9sKCkuDQoNCk5vdywgaXQg
YXBwZWFycyB0aGF0IGFjcGlfZXZhbF9vc2MoKS9hY3BpX3J1bl9vc2MoKSBubyBsb25nZXIgcHJl
c2VydmUgdGhlDQpkaXN0aW5jdGlvbiBiZXR3ZWVuIEFFX05PVF9GT1VORCBhbmQgb3RoZXIgZXJy
b3JzIGZyb20gYWNwaV9ldmFsdWF0ZV9vYmplY3QoKSwNCnNvIG5lZ290aWF0ZV9vc19jb250cm9s
KCkgbm8gbG9uZ2VyIHJlY2VpdmVzIEFFX05PVF9GT1VORCBpbiB0aGlzIGNhc2UuDQoNClRoZSBj
YWxsIGNoYWluIGxvb2tzIGxpa2UgdGhpcyBvbiBteSBzeXN0ZW06DQoNCm5lZ290aWF0ZV9vc19j
b250cm9sKCkNCiAgYWNwaV9wY2lfb3NjX2NvbnRyb2xfc2V0KCkgICAgICAgW3JldHZhbCA9IEFF
X0VSUk9SICAgIF0NCiAgICBhY3BpX3BjaV9xdWVyeV9vc2MgKCkgICAgICAgICAgW3JldHZhbCA9
IEFFX0VSUk9SICAgIF0NCiAgICAgIGFjcGlfcGNpX3J1bl9vc2MoKSAgICAgICAgICAgW3JldHZh
bCA9IEFFX0VSUk9SICAgIF0NCiAgICAgICAgYWNwaV9ydW5fb3NjKCkgICAgICAgICAgICAgW3Jl
dHZhbCA9IEFFX0VSUk9SICAgIF0NCiAgICAgICAgICBhY3BpX2V2YWxfb3NjKCkgICAgICAgICAg
W3JldHZhbCA9IC1FTk9EQVRBICAgIF0NCiAgICAgICAgICAgIGFjcGlfZXZhbHVhdGVfb2JqZWN0
KCkgW3JldHZhbCA9IEFFX05PVF9GT1VORF0NCg0KQXMgYSByZXN1bHQsIG5lZ290aWF0ZV9vc19j
b250cm9sKCkgbG9ncyBtZXNzYWdlcyBhcyBpZiB0aGUgT1MgaGFkIG5lZ290aWF0ZWQNCndpdGgg
dGhlIHBsYXRmb3JtIHZpYSBfT1NDLCBldmVuIHRob3VnaCBfT1NDIGlzIGFic2VudCBhbmQgbm8g
c3VjaCBuZWdvdGlhdGlvbg0KYWN0dWFsbHkgaGFwcGVucy4NCg0KSSdtIG5vdCB2ZXJ5IGZhbWls
aWFyIHdpdGggdGhlIEFDUEkvUENJIGNvZGUsIHNvIEkgbWF5IGJlIG1pc3Npbmcgc29tZQ0KY29u
dGV4dC4gSG93ZXZlciwgaWYgbXkgdW5kZXJzdGFuZGluZyBpcyBjb3JyZWN0LCB3b3VsZCBwcmVz
ZXJ2aW5nDQpBRV9OT1RfRk9VTkQgaGVyZSAoZm9yIGV4YW1wbGUsIGhhdmluZyBhY3BpX2V2YWxf
b3NjKCkvYWNwaV9ydW5fb3NjKCkgcmV0dXJuDQp0aGUgZXJyb3IgYXMtaXMpIGJlIHRoZSByaWdo
dCBkaXJlY3Rpb24sIG9yIHNob3VsZCB0aGUgbWVzc2FnZSBoYW5kbGluZyBiZQ0KYWRqdXN0ZWQg
aW5zdGVhZD8NCg0KSWYgdGhlcmUgaXMgYSBwcmVmZXJyZWQgZGlyZWN0aW9uIGZvciBmaXhpbmcg
dGhpcywgSSB3b3VsZCBiZSBoYXBweSB0byB0cnkNCnB1dHRpbmcgdG9nZXRoZXIgYSBwYXRjaCBh
bmQgdGVzdGluZyBpdCBvbiBteSBzeXN0ZW0uDQoNClRoYW5rcywNCkthenVtYQ==
