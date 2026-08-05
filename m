Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010044.outbound.protection.outlook.com [52.101.228.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC85C436355;
	Wed,  5 Aug 2026 11:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785929296; cv=fail; b=exdhl0dAWjv+HUokymaNSJk70R/a6S/JvMcLcEBrAAwrCFW2RoyYXbL6TPz45shaqeGwDoDQpx7mfjaL/NRz7jaEctNMDIddO+mP1rPrzY1x965TkC5cPPGmy708cJ57qD6jLYv0AfRAWagkzsiRVhoUjfdkObwpD9XfWuFQix4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785929296; c=relaxed/simple;
	bh=ZAPEmzSd81tTQdSE+wL6LcNJb1wIruVA/coSMwiufoU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fVegU9yWOSfWCuF99298AocRSFSX+5LZO15r+s/R3oitjL1IPR8D5d401buUlXavev/cWZ+nlAvcSYuNCBTZ9LTIXwix8DJOqbG+cgXTtEVlSVW7kV5/3vWXmkXK6vTT9TZrxaHe0UKxBR8lvv/knG5y/v357uWrGegPShVeUpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nec.com; spf=pass smtp.mailfrom=nec.com; dkim=pass (2048-bit key) header.d=nec.com header.i=@nec.com header.b=HcQ1m5gy; arc=fail smtp.client-ip=52.101.228.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nec.com header.i=@nec.com header.b="HcQ1m5gy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oL+XOVwXYBQrILej7Opf0J5XUAz5v3wNyM7jO+1ju3nSHVpwbn+OxRzht81dcjVP7lBHQsiqXbY+ESMCUskRSw13vSAxEU8lHGN9CuvbllETjkKmeckOPDn4rYMgDU03fwJxxGSYGPBCYc6POXgeimzLRolOG04S+1qK+pO1L82nm3BdL7M1Mprns5rB5W8vpAdLEx/qwZN+CKHNt6YdPT1FocbTh5ROVgVurcc4R+aVOOAbM7wIb7sefNKj42RfQiyEtAjRqVLCph2R+gBVAvGGeN8EQbeTe0FjU4kTX6yVAvF2t+cz3sRX4z5TRBTrz3NNhaUSLtt0DEcKE8AhCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAPEmzSd81tTQdSE+wL6LcNJb1wIruVA/coSMwiufoU=;
 b=sU1yT/iBV5rJ/0kC+NdjHsMC0bGlIs6pKXkDZZGwnozwkVeIRzxFGy1E0y29itiG907qKHRo1WgfOWa9O7grT78jA2ykcDbg47rH6QPF/iv330LJCj+Kt9T3OwTGi25u6Ptt1lkxtIsSLH4G9Ac1mRt4c3CFg8sOHBUvjOe/SYgkFTWegBbRzXOaD5Qr7bmDslDJvLVSDcBOKstwABiP1TD9A0jyAnnHS0tS1S+eMGsayvsR7qLkyAaYfhBkUlmbXW2/Orpbx+XFZA0QoZtCHtsC/spqrv49kBDBE2kfPHT3LU7mSQPdbCVnE3aH9J9DH/0Pp3vJeB9/TJgwvsGK8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAPEmzSd81tTQdSE+wL6LcNJb1wIruVA/coSMwiufoU=;
 b=HcQ1m5gyxX0CyYpWLG52F0A/IyRg19AuAlWgJsxnO0RvJ90okokCyT40Z45RBHCYkuSPHsVu8l2d/SGdbigDDCfpKtzNK3iU9aGVqJTNYYEJjSrPhBw18iZWidjqhHcA2aLK2SSVtQwf1RZ9NTndiQ63Iq7OJv7gqstUzZrYx5A8GTQj4ORs1sG++4gmIR1DGX6qJNH3rjOKFng7JxusYfUvC2MIVpiag/P8Dmj3v/ELzYAzPZegr1XcbzFNxiAibe9K+ttOPZABEDjvh5W3CfFHGQO4oHXUHrt63YCrmreuqv6531gJAaA44cQ6+Qn3rL3UTrsWfoUAKyUyNo8x6w==
Received: from TY6PR01MB17394.jpnprd01.prod.outlook.com (2603:1096:405:362::9)
 by OS3PR01MB9318.jpnprd01.prod.outlook.com (2603:1096:604:1c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.19; Wed, 5 Aug
 2026 11:28:05 +0000
Received: from TY6PR01MB17394.jpnprd01.prod.outlook.com
 ([fe80::4c13:be46:256e:c1d5]) by TY6PR01MB17394.jpnprd01.prod.outlook.com
 ([fe80::4c13:be46:256e:c1d5%5]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 11:28:05 +0000
From: =?utf-8?B?S09ORE8gS0FaVU1BKOi/keiXpOOAgOWSjOecnyk=?=
	<kazuma-kondo@nec.com>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI: PCI: Avoid misleading _OSC messages for non-PCIe
 host bridges without _OSC
Thread-Topic: [PATCH] ACPI: PCI: Avoid misleading _OSC messages for non-PCIe
 host bridges without _OSC
Thread-Index: AQHdIMw9rF/Py4ZE00CoCPvRVB+Hj7aHWmyAgATDPQCAABx9AIADHzcA
Date: Wed, 5 Aug 2026 11:28:05 +0000
Message-ID: <d0355280-96dc-4e5e-bfd3-f0c3f77acfa3@nec.com>
References: <20260731090820.493064-1-kazuma-kondo@nec.com>
 <20260731092147.B7C531F00A3F@smtp.kernel.org>
 <c8b237c8-6e2a-4648-99ea-a28fdd2404d4@nec.com>
 <CAJZ5v0iNndQe9q4sK-4b6ZBH3ZRPTE+6eTiNQRwVdtazi=KvCQ@mail.gmail.com>
In-Reply-To:
 <CAJZ5v0iNndQe9q4sK-4b6ZBH3ZRPTE+6eTiNQRwVdtazi=KvCQ@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY6PR01MB17394:EE_|OS3PR01MB9318:EE_
x-ms-office365-filtering-correlation-id: b2a330c2-4bfb-4747-97cb-08def2e49e2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|11063799006|56012099006|4143699003|38070700021|10067099003;
x-microsoft-antispam-message-info:
 vvJsFYJpAv7n9ig2jMa38AZnjQfa/ToDunl12TonDou/TMRe2Orc3ZipYqSpI9BqQPcqq0Bg5prvVAIWm05FcSWfzSKkIqLRqg2azjo0KEZocWpl4p9UtVern/+/zzoXu5xPRaBxAPR4xQSZHg6Ty+1q1GzBsLiZeEA9074C+teDd++B0j+p2G29eZi/tKySRPXDIn7O2Z0sEttG7iJNWp+9sNgq31yOVpVZFEMUJ6d4jgyUgUlB4sOab3fJ3HcQ9I45kf4/vqnIjMcAsjTWPM/M1eMpQB9adFTpgwn9HlBP22LboucgYHjqIY69UWOuRQAOsOTch6uMrccnrGeShXDlVM3RnIaznG2J2nwDLcoHG4RWeDSok3BZ9WGjV5FMzLwIyOFeSkFYnwtVcIcQFjBjaTvL6qDcTtgkEFYQFRFT+pu+pm8Mk/BxHjbZUn0usKjDlSyJZjYPacv41w+f4fedDgL2PDj9jqEPWY30nwIvtgYbOkwq8rKWX7JtJ9EL3I2Egt0qdUMrFALTRBSVjSjpyYJgnqCCCaCWyRPuePVNhE1qGVqZe0EY5NyY4JaCXum6Q4PrSwHS80PJdzHbIub6rRj1Eoox2bnGYAqKYseVya4VXHGzoZDB8rVif5qReFE5COLWpkaMTgUQT26LoYmtyJcMw6VPEMJHNwNxcBo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17394.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T3VraGduYURTbS9xcE1PZE5kQ0tReDkzSkpYSWREQURsNXUraWhURDBCbUFB?=
 =?utf-8?B?VmNoN09nSWZqK0YrbFNybnc0d0VRYkE4dy9QczlsMXVRVjdlYkovM1FDb0k4?=
 =?utf-8?B?RWxzY0s3SThSejZBNmxpaEtxSks1V0E0WFpkbjd1M0g5a25jS3R4WmcyNjZa?=
 =?utf-8?B?b3RHZFUyL0REeHRhb1F0M09XS2x1TWlwcVZydVlmRVJYNzV6ZFpnRW04VEJw?=
 =?utf-8?B?ZmZRRmhZN0hhcVFmY29mZWtSTU1Hd2FBQlNJTkxCTzg4UkJaTkNpS3ZUcnRP?=
 =?utf-8?B?dE85OWlZbnhyZk1MNFh3OXNoWi8yOXFGNXNkWndOSjdGMUMyV2ZoczZtdURv?=
 =?utf-8?B?YkdhN0hQUGZDdHIveW9wdlZMa0NQOVluWGFTdlNwWmhFY2ZYcFBoS3Z0WTkw?=
 =?utf-8?B?Ly9hQUJhdTFZdlJzb3owQmt0R0h1Tk1COS91bHQvWDVCV2ZIeGRUWUs4aVZK?=
 =?utf-8?B?K2daK3FqMFdXVGgvU0VEejNON05BSEdwSG5uTXVROUx4dlZpc2JWN1UwQ0Rv?=
 =?utf-8?B?UEg5WGNLZFRUM1ZXV3JnK0xEQlh1Vk5YUFpBMlF3TTcwSnUrUEVrVTdVenNY?=
 =?utf-8?B?Y3AvUzhiS3RzZ2Z3ODkxMW1ialFXVlhqM1M1T2p2NjFMK1BwSWN2YmUvRkZU?=
 =?utf-8?B?ZHZQL2ZYbnFHSWtUU0hPakNLMG1wcGJkN1VTQnNwSVR5NnFCanVESU9tU3hJ?=
 =?utf-8?B?NURJakhyYzR3ZWhVM0RnUFJhZnFHZVh2dC9BNC93OFF1bkN5d3p6QWFUa3l0?=
 =?utf-8?B?dW9xalpIR2JXODhQVk92VnZpM1JnR1p4Y2Q5RzR5WjU4YXZOV3oxRFVEbmRV?=
 =?utf-8?B?YVM1eWtKSGFkWVZuZGp1UEtjQ0ZwOTJlM2RYUVEwMzc2Z1kxU3VzMU1JUzNp?=
 =?utf-8?B?VkE3UmYvZHBqMzNTT3RqZkxad0wwTUV0QWF0emJoMTNseHdMT2FoL2czbS9X?=
 =?utf-8?B?MFArL0puZzZZcWNkWGFBYjg4OVg5cHpRT2tDbnZPN25oclpyQklqVGFJbVdN?=
 =?utf-8?B?ZnZoN3ZnK0lLelQ2ZnlIdmpucGl0OUdtNzIzWGVHUHJUNFJkYW5xR1FFUGVH?=
 =?utf-8?B?WS9LQitEUHdoR3BhTEZ6dDVzMUwwaDZva05NTmtnclJhRjVva3ovem1qeVd4?=
 =?utf-8?B?UGtEazhKR0VrWUY4UWFVOWtFUmNBd3lhV3VDSTZJSDdJMTdKUEg1Q2NXWDZh?=
 =?utf-8?B?Z2w0OWxaRTRoSzVUcC9OcWttWFlxUkxXaU1udkxnWEU2NEdLYmVQWlRVOFpa?=
 =?utf-8?B?dGlwOEFCM2tvb1pqbmFyekJZcFpySmZqN2VLZ0JxbEVaTU5YdE5kTHptRHly?=
 =?utf-8?B?WURlRzJRQmpTMDg4UnJ6a0N4d283NVgvNStrUTBncHVEVERXZzB5cm1rcUx3?=
 =?utf-8?B?S1JpdlVSOVg0cFA5aWY3ckJUQUJCS0ZYWWluK29QNGZrYWxUdks0ajZ3ZUVO?=
 =?utf-8?B?enRmbGtkT0wvMFpOWEtjWkVTT0pmTVlnNWRURDA0cG14bkhuL2xveU1Bc2Ft?=
 =?utf-8?B?eFpjd2ZySFUySGZTTGFDdzAxdGxWeVVZdTQ1eVlzUmZtWjU1VzBVbERHNm43?=
 =?utf-8?B?aFZBUXNkaC9kbkRiamdaaWMwZHJnNllhZWJXUFg1WHAyQWZWZWQ1Z1R4NDFZ?=
 =?utf-8?B?TDlLN3pyY1NEM3NYcUFyb1Y4aSsvODN3L0VDK0pxeUd0bUt1azhBR3V5LzFN?=
 =?utf-8?B?L2JCRjRwTEtrck1tVHllN1oyMDVHS21qYlNGb2dBZUkyNFA3ejg2NVNqbjhJ?=
 =?utf-8?B?NDNrS29ab0xSMFczS0tya0JDcTZUOVlJdG1ZQzduTHl1MzNTUWdYdlFZd010?=
 =?utf-8?B?dGF4NkpybFU2K0VraTlCM1E5WnZKa1lES2lxUWErNnZsWTdYVjB4d29pTkI4?=
 =?utf-8?B?OUlvR3FYTWFtRWwzNTBIVFFHYktNWUpaNHRzcGpXdHVUdTZ1QzhRWVcrU2x0?=
 =?utf-8?B?NzEvNjlDeXFzREJMK0RHMVpBLzh5dGVHTVJaTVpGN1BKTFk2dEdka3RKL1JW?=
 =?utf-8?B?QkxjWnE3bWJWdjROYnRKQkZhVG5GaVhMU1AxL1JwZFFvWDFtL2lNcDBTR1BP?=
 =?utf-8?B?UHFpaWg3RUEwT3EwQ2ZXV3FiWWpGK01RVUp6TFZYa2RsMW9QOWFLTndxSmhB?=
 =?utf-8?B?VEt2UUhRaTJJUlFsbENvT3BjWjFyTzErK05ONmNiRnF2cmNJUWlYZ2VPekpY?=
 =?utf-8?B?UHozZHBOSWt6eE1zRUFpVkpEcjdCeVkwTUgxNXZzUEFGY2pCZFlSbHBDelNQ?=
 =?utf-8?B?MURZQ1pCYm1HM242OTlXdWlML1dyQTBiSUxzenBGdnBsbVZtRUtvTVl2V1Nw?=
 =?utf-8?B?S0RRNXVIeXphQmVhcmpSZ1k3bjFOSngybGdSOEFQSHZCZ3IydGg1dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B34B1FFC55C17D49A2C7CEA03D0735CC@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17394.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a330c2-4bfb-4747-97cb-08def2e49e2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2026 11:28:05.2966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: twgkxXg7B72GI6juIzwI/Oeir2ok3XeNlwmO/bDUu71f9Zlne9SoQB3wmNMHXqPMFsH8gNzaxQ/3lti5QAl0eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9318

SGVsbG8sDQoNCk9uIDIwMjYvMDgvMDMgMjA6NDcsIFJhZmFlbCBKLiBXeXNvY2tpIChJbnRlbCkg
d3JvdGU6DQo+IE9uIE1vbiwgQXVnIDMsIDIwMjYgYXQgMTI6MDXigK9QTSBLT05ETyBLQVpVTUEo
6L+R6Jek44CA5ZKM55yfKQ0KPiA8a2F6dW1hLWtvbmRvQG5lYy5jb20+IHdyb3RlOg0KPj4NCj4+
IEhlbGxvLA0KPj4NCj4+IEkgcmVjZWl2ZWQgcmV2aWV3IGNvbW1lbnRzIGZyb20gU2FzaGlrbzoN
Cj4+IGh0dHBzOi8vc2FzaGlrby5kZXYvIy9wYXRjaHNldC8yMDI2MDczMTA5MDgyMC40OTMwNjQt
MS1rYXp1bWEta29uZG9AbmVjLmNvbT9wYXJ0PTENCj4+DQo+PiBPbiAyMDI2LzA3LzMxIDE4OjIx
LCBzYXNoaWtvLWJvdEBrZXJuZWwub3JnIHdyb3RlOg0KPj4+IFRoYW5rIHlvdSBmb3IgeW91ciBj
b250cmlidXRpb24hIFNhc2hpa28gQUkgcmV2aWV3IGZvdW5kIDEgcG90ZW50aWFsIGlzc3VlKHMp
IHRvIGNvbnNpZGVyOg0KPj4+IC0gW0hpZ2hdIEVhcmx5IHJldHVybiBieXBhc3NlcyBBU1BNIGRp
c2FibGVtZW50IGZvciBub24tUENJZSBhbmQgQ1hMIGhvc3QgYnJpZGdlcyB3aXRob3V0IF9PU0Ms
IGNhdXNpbmcgYW4gdW5kb2N1bWVudGVkIGZ1bmN0aW9uYWwgY2hhbmdlIGFuZCBwb3RlbnRpYWwg
aW5zdGFiaWxpdHkNCj4+PiAtLQ0KPj4+DQo+Pj4gLS0tIFBhdGNoIFsxXTogW1BBVENIXSBBQ1BJ
OiBQQ0k6IEF2b2lkIG1pc2xlYWRpbmcgX09TQyBtZXNzYWdlcyBmb3Igbm9uLVBDSWUgaG9zdCBi
cmlkZ2VzIHdpdGhvdXQgX09TQyAtLS0NCj4+PiBjb21taXQgZTY4ZDI5ZjY1M2ExYzM0ZjhiN2Iw
OGJhYWE1NDhlMmZmMmQzNjYzZg0KPj4+IEF1dGhvcjogS09ORE8gS0FaVU1BKCAkQjZhRiMhIU9C
Pz8gKEIpIDxrYXp1bWEta29uZG9AbmVjLmNvbT4NCj4+Pg0KPj4+IEFDUEk6IFBDSTogQXZvaWQg
bWlzbGVhZGluZyBfT1NDIG1lc3NhZ2VzIGZvciBub24tUENJZSBob3N0IGJyaWRnZXMgd2l0aG91
dCBfT1NDDQo+Pj4NCj4+PiBUaGlzIHBhdGNoIHNraXBzIF9PU0MgbmVnb3RpYXRpb24gZm9yIG5v
bi1QQ0llIGhvc3QgYnJpZGdlcyB0aGF0IGRvIG5vdCBkZWZpbmUNCj4+PiBhbiBfT1NDIG1ldGhv
ZCBiZWZvcmUgYXR0ZW1wdGluZyB0byBldmFsdWF0ZSBpdC4gSXQgYWltcyB0byBwcmV2ZW50IG1p
c2xlYWRpbmcNCj4+PiBtZXNzYWdlcyBpbiB0aGUgbG9ncyBvbiBzb21lIEludGVsIHNlcnZlcnMg
d2hlcmUgdGhlIE9TIGFwcGVhcnMgdG8gbmVnb3RpYXRlDQo+Pj4gd2l0aCB0aGUgcGxhdGZvcm0g
ZGVzcGl0ZSB0aGUgbGFjayBvZiBhbiBfT1NDIG1ldGhvZC4NCj4+Pg0KPj4+IExpbms6IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWFjcGkvZDBiZTk0OWQtMGUyMS00NzJlLWE0NGItY2Vk
YjFkZDg2OTVkQG5lYy5jb20vDQo+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9w
Y2lfcm9vdC5jIGIvZHJpdmVycy9hY3BpL3BjaV9yb290LmMNCj4+Pj4gaW5kZXggNGMwNmMzZmZk
MGNiYi4uM2EyNGQwMTg0MzZiNCAxMDA2NDQNCj4+Pj4gLS0tIGEvZHJpdmVycy9hY3BpL3BjaV9y
b290LmMNCj4+Pj4gKysrIGIvZHJpdmVycy9hY3BpL3BjaV9yb290LmMNCj4+Pj4gQEAgLTU3NCw2
ICs1NzQsMTIgQEAgc3RhdGljIHZvaWQgbmVnb3RpYXRlX29zX2NvbnRyb2woc3RydWN0IGFjcGlf
cGNpX3Jvb3QgKnJvb3QsIGludCAqbm9fYXNwbSkNCj4+Pj4gICAgICAgICAgICAgIHJldHVybjsN
Cj4+Pj4gICAgICB9DQo+Pj4+DQo+Pj4+ICsgICAgLyogX09TQyBpcyBvcHRpb25hbCBmb3IgUENJ
IGhvc3QgYnJpZGdlcyAqLw0KPj4+PiArICAgIGlmICghaXNfcGNpZShyb290KSAmJiAhYWNwaV9o
YXNfbWV0aG9kKGhhbmRsZSwgIl9PU0MiKSkgew0KPj4+PiArICAgICAgICAgICAgZGV2X2RiZygm
ZGV2aWNlLT5kZXYsICJfT1NDOiBuZWdvdGlhdGlvbiBza2lwcGVkIChtZXRob2Qgbm90IHByZXNl
bnQgZm9yIG5vbi1QQ0llIGhvc3QgYnJpZGdlKVxuIik7DQo+Pj4+ICsgICAgICAgICAgICByZXR1
cm47DQo+Pj4+ICsgICAgfQ0KPj4+PiArDQo+Pj4NCj4+PiBbU2V2ZXJpdHk6IEhpZ2hdDQo+Pj4g
RG9lcyB0aGlzIGVhcmx5IHJldHVybiB1bmludGVudGlvbmFsbHkgc2tpcCBkaXNhYmxpbmcgQVNQ
TSBmb3IgdGhlc2UgaG9zdA0KPj4+IGJyaWRnZXM/DQo+Pj4NCj4+PiBUaGUgY29tbWl0IG1lc3Nh
Z2Ugc3RhdGVzIHRoaXMgY2hhbmdlIHByb2R1Y2VzIG5vIGZ1bmN0aW9uYWwgaXNzdWVzIGFuZCBv
bmx5DQo+Pj4gcmVtb3ZlcyBtaXNsZWFkaW5nIG1lc3NhZ2VzLiBIb3dldmVyLCBiZWZvcmUgdGhp
cyBwYXRjaCwgaWYgdGhlIF9PU0MgbWV0aG9kDQo+Pj4gd2FzIG1pc3NpbmcsIHRoZSBmdW5jdGlv
biB3b3VsZCBwcm9jZWVkLCBmYWlsIHRoZSBuZWdvdGlhdGlvbiwgYW5kIGZhbGwNCj4+PiB0aHJv
dWdoIHRvIHRoZSBmYWlsdXJlIHBhdGggd2hlcmUgKm5vX2FzcG0gPSAxIGlzIHVuY29uZGl0aW9u
YWxseSBzZXQuDQo+Pj4NCj4+PiBCeSByZXR1cm5pbmcgZWFybHkgaGVyZSwgaXQgbG9va3MgbGlr
ZSAqbm9fYXNwbSA9IDEgaXMgY29tcGxldGVseSBieXBhc3NlZA0KPj4+IGZvciBsZWdhY3kgaG9z
dCBicmlkZ2VzLg0KPj4+DQo+Pj4gQWRkaXRpb25hbGx5LCBpc19wY2llKCkgb25seSBjaGVja3Mg
Zm9yIEFDUElfQlJJREdFX1RZUEVfUENJRS4gQ291bGQgdGhpcw0KPj4+IGNhdXNlIENYTCBob3N0
IGJyaWRnZXMgKEFDUElfQlJJREdFX1RZUEVfQ1hMKSB0byBldmFsdWF0ZSB0byBmYWxzZSBoZXJl
Pw0KPj4+IElmIGEgQ1hMIGJyaWRnZSBsYWNrcyBhbiBfT1NDIG1ldGhvZCwgaXQgd291bGQgdGFr
ZSB0aGlzIGVhcmx5IHJldHVybiBhbmQgc2tpcA0KPj4+IEFTUE0gZGlzYWJsZW1lbnQgZW50aXJl
bHksIHdoaWNoIGNvdWxkIGxlYXZlIEFTUE0gZW5hYmxlZCBpbmFwcHJvcHJpYXRlbHkNCj4+PiB3
aXRob3V0IGZpcm13YXJlIG5lZ290aWF0aW9uLg0KPj4NCj4+IEkgdGhpbmsgU2FzaGlrbydzIHJl
dmlldyBpcyByZWFzb25hYmxlLiBBY2NvcmRpbmcgdG8gWzFdLCB1bmxlc3MgdGhlDQo+PiBwbGF0
Zm9ybSBleHBsaWNpdGx5IGdyYW50cyB0aGUgT1MgY29udHJvbCBvdmVyIEFTUE0gdmlhIF9PU0Ms
IHRoZSBPUw0KPj4gc2hvdWxkIG5vdCBjaGFuZ2UgdGhlIEFTUE0gc3RhdGUgY29uZmlndXJlZCBi
eSB0aGUgcGxhdGZvcm0uDQo+IA0KPiBUaG91Z2ggQVNQTSBvbmx5IGlzIGEgdGhpbmcgZm9yIFBD
SWUsIGlzbid0IGl0Pw0KDQpZb3UncmUgcmlnaHQuIEkgd2FzIHRyeWluZyB0byB1bmRlcnN0YW5k
IHRoZSByYXRpb25hbGUgZm9yIGRpc2FibGluZw0KQVNQTSB3aGVuIF9PU0MgbmVnb3RpYXRpb24g
aXMgc2tpcHBlZCwgYnV0IGl0IGFwcGVhcnMgdGhhdCBJIGhhdmUgYmVlbg0KbG9va2luZyBhdCB0
aGlzIHRoZSB3cm9uZyB3YXkuDQoNCj4gDQo+PiBBbHNvLCBhcyBkZXNjcmliZWQgaW4gWzJdLCBp
ZiBDWEwgMS4xIGhvc3RzIGRvIG5vdCBwdWJsaXNoIGEgQ1hMIF9PU0MsDQo+PiB0aGUgT1Mgc2hv
dWxkIGZhbGwgYmFjayB0byB0aGUgUENJZSBfT1NDIChqdXN0IGFzIGFjcGlfcGNpX3F1ZXJ5X29z
YygpDQo+PiBkb2VzKS4NCj4+DQo+PiBTbywgbmVnb3RpYXRlX29zX2NvbnRyb2woKSBzaG91bGQg
c2tpcCBfT1NDIG5lZ290aWF0aW9uIG9ubHkgd2hlbiBhDQo+PiBsZWdhY3kgUENJIGhvc3QgYnJp
ZGdlIGRvZXMgbm90IGhhdmUgX09TQy4gRm9yIGV4YW1wbGU6DQo+Pg0KPj4gICAgICAgICAvKiBf
T1NDIGlzIG9wdGlvbmFsIGZvciBQQ0kgaG9zdCBicmlkZ2VzICovDQo+IA0KPiBUaGUgY29tbWVu
dCBhYm92ZSBpcyBzb21ld2hhdCByZWR1bmRhbnQgSU1PLg0KPiANCj4+ICAgICAgICAgaWYgKCFp
c19wY2llKHJvb3QpICYmICFpc19jeGwocm9vdCkgJiYNCj4+ICAgICAgICAgICAgICFhY3BpX2hh
c19tZXRob2QoaGFuZGxlLCAiX09TQyIpKSB7DQo+PiAgICAgICAgICAgICAgICAgZGV2X2RiZygm
ZGV2aWNlLT5kZXYsICJfT1NDOiBuZWdvdGlhdGlvbiBza2lwcGVkIChtZXRob2Qgbm90IHByZXNl
bnQgZm9yIGxlZ2FjeSBQQ0kgaG9zdCBicmlkZ2UpXG4iKTsNCj4gDQo+IFBsZWFzZSBtYWtlIHRo
ZSBjb21tZW50IHNheSAiU2tpcHBpbmcgYSBub24tUENJZSByb290IHdpdGhvdXQgX09TQyIgb3Ig
c2ltaWxhci4NCj4gDQo+Pg0KPj4gICAgICAgICAgICAgICAgIC8qDQo+PiAgICAgICAgICAgICAg
ICAgICogRGlzYWJsZSBBU1BNIHVubGVzcyB0aGUgT1MgaGFzIGJlZW4gZ3JhbnRlZCBjb250cm9s
IG92ZXIgaXQNCj4+ICAgICAgICAgICAgICAgICAgKiB2aWEgX09TQy4NCj4+ICAgICAgICAgICAg
ICAgICAgKi8NCj4+ICAgICAgICAgICAgICAgICAqbm9fYXNwbSA9IDE7DQo+IA0KPiBTbyBJIGFn
cmVlIHRoYXQgc2V0dGluZyAqbm9fYXNwbSB0byAxIGluIHRoaXMgY2FzZSBpcyBhIGdvb2QgaWRl
YSwgYnV0DQo+IHRoZSBjb21tZW50IGFib3ZlIGlzIHNsaWdodGx5IG1pc2xlYWRpbmcuDQoNClRo
YW5rIHlvdSBmb3IgeW91ciBhZHZpY2UhIEknbGwgZml4IHRoZSBkZWJ1ZyBtZXNzYWdlIGFuZCB0
aGUgY29tbWVudC4NCg0KVGhhbmtzLA0KS2F6dW1hDQoNCj4gDQo+IEkgd291bGQganVzdCBtYWtl
IGl0IHNheSAiTm8gQVNQTSBmb3Igbm9uLVBDSSBob3N0IGJyaWRnZXMiIG9yIGVxdWl2YWxlbnQu
DQo+IA0KPj4gICAgICAgICAgICAgICAgIHJldHVybjsNCj4+ICAgICAgICAgfQ0KPj4NCj4+IElm
IEkgaGF2ZSBtaXN1bmRlcnN0b29kIGFueXRoaW5nLCBwbGVhc2UgbGV0IG1lIGtub3cuDQo=
