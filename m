Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011015.outbound.protection.outlook.com [52.101.125.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC3B372B39;
	Mon,  3 Aug 2026 10:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785751542; cv=fail; b=u8yElwQikmEeLsEm/eJCN05agkUjS25ZGIr3ORJpFXu2fT93EkgZh+1TDWJJSX4YotW4GBMtDF44pc27HS9spu50OteDXSN6VEB8Sx69GCHVcyJHg1L6YHINQqzWy9qR9FzIWmSlqWXrZ31FMIMK2xVeRLbxZ3lqLONYXjYEEGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785751542; c=relaxed/simple;
	bh=hQ+oP7jnKXBKEZqdwr/aFA8YbIgA/H+Y+pYa/dH4beA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lvGhNsDJ72RFS+XzAWrTU1OpUkB2bQQDEmXFPCsrn/pql5AbiPhv85i2afISDpgPKzgmePPHi4nSlXh9/qFZQmy43hDAKXqQfW1GvFt6Uzb1hLrjHvK7gnNxuDsh2YadyXfe3OKmZRQe0HtomcLk+pE9flvxI3QtcSZkEeX2kUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nec.com; spf=pass smtp.mailfrom=nec.com; dkim=pass (2048-bit key) header.d=nec.com header.i=@nec.com header.b=Zuz9vpKL; arc=fail smtp.client-ip=52.101.125.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nec.com header.i=@nec.com header.b="Zuz9vpKL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HzcatZm/22ZHAJsPqdNHgeZYG8/+h2UyXUVWddZM8HTMjKsHHxUfOA+l5TROLqGkMo/4alJ00hSFC6jCmlg+VghQsVe6TPh3+X0YUwVHEQslUOhbGo40HCMlzCR+9xsiOAkCSnuD+IOgOXyN0NpuRuE3L03IuEBYLVA4J0pTTDpho5Hmxt1a2c5/VNlPzbt4Bc4tQjUtpNQ/94llpfiii8XjPAwWnycq+fHHSf/qpddRg2w8GY/+LN7iXLeD2b4NDdN9g3Yds+qFBfLc74Iw3yXIZHja5hH9L7I7yKWOVy/sALc2wl1YjV4U4QED8wXC7VnlgrurlEwDfwbbxZAQYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQ+oP7jnKXBKEZqdwr/aFA8YbIgA/H+Y+pYa/dH4beA=;
 b=BdBE8ELLL+PyikQ5/2n+tLZg4qXQ5xkPjEGsrSq4wroRZi1ugQwrdb6Jvm055itZnRDsALox86ddsT3bCNwJdkXA1grbo6/KPT7PsTBCuPUlSRzc3znPVHko0MESMzgQCISuLQUU/9D5DtwsP3GOjNIaqdLo5XlJ/coy1+/rT6wShctOtuRlFNV4y9thrGUvqAs1qxZyuC181wfn1h2K8mP7EgOLFGFWoJ2u8dF3DWdvpVKnzriaEaRBL0+UBooIFVYkfdKKL4qkIO06U/ZBVCwJALJqnyphzl63/1l+XF0gk4zDBpnLHDRj5UEgxVZIEhSHaBmGu/q1pQOFgrmceg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQ+oP7jnKXBKEZqdwr/aFA8YbIgA/H+Y+pYa/dH4beA=;
 b=Zuz9vpKLCvmpLbOJyB1+/mN8OJsOaL3qELbw2Yt/WOSIIeXlxGsZwqKZpxNWxwcB09/laTj2ywGIfVY2XEE5k6CzUtH5mjUp/dgOSOKsGVk5Fi8ag2JErBnao4evyHnGiwPxoFxNrhwbntTUCgAo49Ep4KPL3V5CfPVrA5M6wEjzn7j6r4p/JeVyb45IFKk10dqsf0DmYnKg+XbWiM3ZTvddINKw7xJnns+e7IaGVrmvcFKt4OqOAIqK9YEpTwM7kaDTcW/f73XUazl7aj8CF18nLND8jaeFPDL23V6Nzt74w3J8SUy9vcu+7lplfrX+VfnToK0athjyUxLmhIH+Gw==
Received: from OS7PR01MB17384.jpnprd01.prod.outlook.com (2603:1096:604:43c::6)
 by TYYPR01MB15068.jpnprd01.prod.outlook.com (2603:1096:405:1a2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 10:05:36 +0000
Received: from OS7PR01MB17384.jpnprd01.prod.outlook.com
 ([fe80::e19a:50c0:4d9c:1bb6]) by OS7PR01MB17384.jpnprd01.prod.outlook.com
 ([fe80::e19a:50c0:4d9c:1bb6%7]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 10:05:36 +0000
From: =?utf-8?B?S09ORE8gS0FaVU1BKOi/keiXpOOAgOWSjOecnyk=?=
	<kazuma-kondo@nec.com>
To: "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
	<lenb@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>
CC: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI: PCI: Avoid misleading _OSC messages for non-PCIe
 host bridges without _OSC
Thread-Topic: [PATCH] ACPI: PCI: Avoid misleading _OSC messages for non-PCIe
 host bridges without _OSC
Thread-Index: AQHdIMw9rF/Py4ZE00CoCPvRVB+Hj7aHWmyAgATDPQA=
Date: Mon, 3 Aug 2026 10:05:36 +0000
Message-ID: <c8b237c8-6e2a-4648-99ea-a28fdd2404d4@nec.com>
References: <20260731090820.493064-1-kazuma-kondo@nec.com>
 <20260731092147.B7C531F00A3F@smtp.kernel.org>
In-Reply-To: <20260731092147.B7C531F00A3F@smtp.kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB17384:EE_|TYYPR01MB15068:EE_
x-ms-office365-filtering-correlation-id: 2ef55e7d-d270-4bb5-0dbe-08def146c39c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 AsuZZuoDfOsSiKKCrvN37mSkhNFACl1+tJJ4cOTanLCocMTV/F+x6pqEUJrMsnISQN2f9i6qYXl9MlAtQnf1mQwLJcDs/3VgQsDjcwd1cGwTFIb/mtkvlbGXn9ftUpK6mMgafiCpFS8xJqA06HxM7tldii8/xYvxf+UvTLXEU5ahK1W5JUi/Z2ej4aPla34GkUi2LxDO1EJtOHGoSOy8idPcjxJUL4obKLYJA8RTNry8ymUrwINhhngPyvMFGZmONY5EBrGf5e/CsWmtpB1MS+UilALhXflKESk8IjsKFURTTfEw7W+KuPGPaltjdQVFpAECLyW8RHANIiz2gNWqqkB56eIuLR69H63Z0zEMjT1+WKoa5xCglt7hywlP1Eeccs/k/nou89nvvJyjk6CjH6hQuJmPwaMUoVTaquG/3cct+Jlu7tPagQeBNqe62sn5x4vRwBlahEan844guFbjWfpU28DJsYvYGGrxxaf1XNeg7m5qmWLRRv2stxwH/8dsld8PJ5MSjGIRoR4sge6/t2F9C2QRYRgJI60QNx0KLuAPfpM3vlFz5FakES5j54JIwUcqXXgoHhXHkqhr1Wl6awKNAjMD00m2aJESdmMQ9RYvN+OCKSlC+s4ZaBIYZ6cqSXJ5aoPNT4KIZD7ZWPvHW2i+UPLGLAi2AUc3u8s4XcM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB17384.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UTlQV2JiSGlJeEhVdDlvdjVobVBRSWJMb0JxOGlBUE5RWU84bEV1STIweVRC?=
 =?utf-8?B?NTAvYXA1WkgxTFJrandOY29EZDNFaWZDaVRqMFZxRndXZitEM2E4SHM3VFRr?=
 =?utf-8?B?QXJZNTEvS3ZOaXMxdWR6TmVINnlRcHBpdVpHY1ZRZEwrQ3luTUFwZHdDYnpO?=
 =?utf-8?B?STAwYmtobk1WTlZnNE54Z3UzeVFSWnZSeTZQM0NjQWwrVnQ0ZHNldCtMSmkr?=
 =?utf-8?B?VVd5TmYwWnJueGJVMGovNnBDMWE3ZUViQ1JkaGtiTWd6UmI2NG5McUxsKzFT?=
 =?utf-8?B?Nzd3cjYwZE94QUpQaHJXV202Tk12UjRzNEtvOVdpN2paV2hmRVpkbWxQZ0hZ?=
 =?utf-8?B?VThOWWRtVnJMb3hlNVhmRFlUWGZ4NUpIMkpVNUxBUmk0N21mZDFDbmF0VW9n?=
 =?utf-8?B?YzJSSjJqVm5FNng1VytiNHFkT2loMElpMkZnbWp1WjJXaDdseXZqN0hPM2dk?=
 =?utf-8?B?b0RSZ3hmZGJSMlBHOTlCdUp6MTBTVTQ4N2l6dFdPcCt5d0dTbFh0QVJ5Y1Vu?=
 =?utf-8?B?cHoyNjA2dFZueHZzQ25BT1daa2RMc3dZaFZJd1RtVk1FTTBxcFVUNUNIMEMz?=
 =?utf-8?B?aUlMQ0NWckZlanBTVVF6TnZuUS9iZTVzdlErQkozL3dZNDhUNzY3aFV6SHVt?=
 =?utf-8?B?M29HenVjTE1Oc2hIUUxSRHRMNU9yNTJRYTFEMlBIQVBzY3ZRSjlmNU0vUXNp?=
 =?utf-8?B?ZWx6bFFIbE9yN0ErYVFaaWpKRitCN2lBQWNFZHVad21BeXpVdkRYY3pMekVw?=
 =?utf-8?B?M3RKVGRFRG9OQXlNcThmeEMvVEdEdzFIL3pOQmJ0NE5lSjFMKzNMTTdZUnpV?=
 =?utf-8?B?ZTF5R2lZUExIU1dOeFdZUm5RRDVYY2pSZnBNTy9Pa3ZvSWtFSFprTlZQekNs?=
 =?utf-8?B?UXJEVTJIM29TZS8rZzQzVjdCd1NWZ21XOGU2N0E1U3Y1cUJSaFhiSnd1dklx?=
 =?utf-8?B?ZFB5Vm9HUDZkQzM3M2lXWEttcjY4bXhCd2J2SkJPMXkzYXcwNzhuVFIwU05E?=
 =?utf-8?B?WVJzaTJUNkF2cWNsdVozdDY2UlNQVjJXYi95M3BKZml3UDhoa21jdVZCNkdY?=
 =?utf-8?B?REFxN0x4OXlDVFJ4SXRoeEpUM2dadm5nSklCRzdHZXpPeUtHb2hKY1ZoamtW?=
 =?utf-8?B?SEVPanEvMjd2em9PdjFoZXhydlRtWXVCM2JPYmg0OFVjdHlkMTVibm1mYVFy?=
 =?utf-8?B?MzREWjhrdFIwQ21mOG5hbW16eFdlZUpYaHlBOEN2bUFEKzEyOXdSUmdwNGZ4?=
 =?utf-8?B?bDRGWVBQYSs2dzVGdHhDUnFxV0xuL3lNZ1EzcmZ1Qlc4R0tacjlrcm5zVTQv?=
 =?utf-8?B?dm5MTnJtRXFxb1hKS0FwcjQzTXNjQks3ajR5cnIxVzZWWU9IUHdzR3ZtdnNN?=
 =?utf-8?B?Z3ZuT0dSV0VIRW5ESVhYTmNwdjFSbnY3Vi8vK01TYWd0M29wU0Y3dk5XbDU4?=
 =?utf-8?B?akt5YmcyVCtRZm1ZcWJ0bWZlcWpJdEVpR1RzMG9uV2ZxRDZOa2ltanZHQ20r?=
 =?utf-8?B?NWcvN3Q1anQyRFNKTVlySU9vd3A4RkI1TUFQUVdRajR5UjZvSUp2eTVyNVVl?=
 =?utf-8?B?ajRUSE95UHRyaXNBNHpmc2xuTVhNYjR1M3c5ZGdOT2lHNDl3bkM3a3ZIL09G?=
 =?utf-8?B?MWxUV20ramRLbFJaTUYyRXVYbXdVMnRndDc0L0pMUDJqMUlhb0E2M2UxVWha?=
 =?utf-8?B?a09Fb0swbVlGcWQ2MVBCakVmRlhCTUlSNXc1RlFHWUkySVAwcnB0NjhKb3Mr?=
 =?utf-8?B?RnRVd0svVHY2Z25NL2pISnd2bDN5RFM4WndIa1JuRGhKdTQwVTZ1eVBsWUhJ?=
 =?utf-8?B?UFloQXpPaXZ0K3pCamp0SXRPdVdDamhlWGM3UmpLdU83Sjd5eUgvd0dpVjQy?=
 =?utf-8?B?UCt3eHdKVW4yeThYTjZPbCs4dlcra2o3UXdsRXV4RmJhRUR5czNuemo0OHNU?=
 =?utf-8?B?M0tkNVNVY2JYMkRFQXA2VmFDY2NlY3VGeWFXUmhranM2aGgxYjdkdC9KQnBZ?=
 =?utf-8?B?ajJiTXBJbU8vRjNTc2hRbmFHV1Q4bXV0dHpoUU1YUEpuWkIyVGNubFlpc1lp?=
 =?utf-8?B?d2loQlBtdUpKcm1zZnNDVnA0NGo1cjhJTFJSWGk5K3Z6Ujh2VzJVSy9SU0Fu?=
 =?utf-8?B?UlhqN2RSc0RhMWNiTU1qdThya1d1K0t6UmFVdW5aN1ZJNThwcXVxaEtGLzFI?=
 =?utf-8?B?Z2dzUVlraUFuNVZBNlRsZHI4U0pJa1FjLzEydEJpSm5HMFM5WEEreUIveE4y?=
 =?utf-8?B?NHIwdGYzdkVtT25oVUtPRklYZlJQVUVuSy9ad20xOVhtNW9MQTMrcTZFdEVF?=
 =?utf-8?B?U0t4VnVBUU1nc3BNdDNFSmFOVTVqMkN4SldDMnNBalVyQVVpbHY5dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <56818CAA2A15764EBD3C37C6B4D9919A@jpnprd01.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ef55e7d-d270-4bb5-0dbe-08def146c39c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2026 10:05:36.4945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: izhlzYV5pWda0/lBSeN78GG6Biot4V87xYBVLJQTdXrSmuA63LHRTQfiJ/TJL1Z/NRprhVFIlPNtR8U/RMI32w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB15068

SGVsbG8sDQoNCkkgcmVjZWl2ZWQgcmV2aWV3IGNvbW1lbnRzIGZyb20gU2FzaGlrbzoNCmh0dHBz
Oi8vc2FzaGlrby5kZXYvIy9wYXRjaHNldC8yMDI2MDczMTA5MDgyMC40OTMwNjQtMS1rYXp1bWEt
a29uZG9AbmVjLmNvbT9wYXJ0PTENCg0KT24gMjAyNi8wNy8zMSAxODoyMSwgc2FzaGlrby1ib3RA
a2VybmVsLm9yZyB3cm90ZToNCj4gVGhhbmsgeW91IGZvciB5b3VyIGNvbnRyaWJ1dGlvbiEgU2Fz
aGlrbyBBSSByZXZpZXcgZm91bmQgMSBwb3RlbnRpYWwgaXNzdWUocykgdG8gY29uc2lkZXI6DQo+
IC0gW0hpZ2hdIEVhcmx5IHJldHVybiBieXBhc3NlcyBBU1BNIGRpc2FibGVtZW50IGZvciBub24t
UENJZSBhbmQgQ1hMIGhvc3QgYnJpZGdlcyB3aXRob3V0IF9PU0MsIGNhdXNpbmcgYW4gdW5kb2N1
bWVudGVkIGZ1bmN0aW9uYWwgY2hhbmdlIGFuZCBwb3RlbnRpYWwgaW5zdGFiaWxpdHkNCj4gLS0N
Cj4gDQo+IC0tLSBQYXRjaCBbMV06IFtQQVRDSF0gQUNQSTogUENJOiBBdm9pZCBtaXNsZWFkaW5n
IF9PU0MgbWVzc2FnZXMgZm9yIG5vbi1QQ0llIGhvc3QgYnJpZGdlcyB3aXRob3V0IF9PU0MgLS0t
DQo+IGNvbW1pdCBlNjhkMjlmNjUzYTFjMzRmOGI3YjA4YmFhYTU0OGUyZmYyZDM2NjNmDQo+IEF1
dGhvcjogS09ORE8gS0FaVU1BKCAkQjZhRiMhIU9CPz8gKEIpIDxrYXp1bWEta29uZG9AbmVjLmNv
bT4NCj4gDQo+IEFDUEk6IFBDSTogQXZvaWQgbWlzbGVhZGluZyBfT1NDIG1lc3NhZ2VzIGZvciBu
b24tUENJZSBob3N0IGJyaWRnZXMgd2l0aG91dCBfT1NDDQo+IA0KPiBUaGlzIHBhdGNoIHNraXBz
IF9PU0MgbmVnb3RpYXRpb24gZm9yIG5vbi1QQ0llIGhvc3QgYnJpZGdlcyB0aGF0IGRvIG5vdCBk
ZWZpbmUNCj4gYW4gX09TQyBtZXRob2QgYmVmb3JlIGF0dGVtcHRpbmcgdG8gZXZhbHVhdGUgaXQu
IEl0IGFpbXMgdG8gcHJldmVudCBtaXNsZWFkaW5nDQo+IG1lc3NhZ2VzIGluIHRoZSBsb2dzIG9u
IHNvbWUgSW50ZWwgc2VydmVycyB3aGVyZSB0aGUgT1MgYXBwZWFycyB0byBuZWdvdGlhdGUNCj4g
d2l0aCB0aGUgcGxhdGZvcm0gZGVzcGl0ZSB0aGUgbGFjayBvZiBhbiBfT1NDIG1ldGhvZC4NCj4g
DQo+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWFjcGkvZDBiZTk0OWQtMGUy
MS00NzJlLWE0NGItY2VkYjFkZDg2OTVkQG5lYy5jb20vDQo+IA0KPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvYWNwaS9wY2lfcm9vdC5jIGIvZHJpdmVycy9hY3BpL3BjaV9yb290LmMNCj4+IGluZGV4
IDRjMDZjM2ZmZDBjYmIuLjNhMjRkMDE4NDM2YjQgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2Fj
cGkvcGNpX3Jvb3QuYw0KPj4gKysrIGIvZHJpdmVycy9hY3BpL3BjaV9yb290LmMNCj4+IEBAIC01
NzQsNiArNTc0LDEyIEBAIHN0YXRpYyB2b2lkIG5lZ290aWF0ZV9vc19jb250cm9sKHN0cnVjdCBh
Y3BpX3BjaV9yb290ICpyb290LCBpbnQgKm5vX2FzcG0pDQo+PiAgCQlyZXR1cm47DQo+PiAgCX0N
Cj4+ICANCj4+ICsJLyogX09TQyBpcyBvcHRpb25hbCBmb3IgUENJIGhvc3QgYnJpZGdlcyAqLw0K
Pj4gKwlpZiAoIWlzX3BjaWUocm9vdCkgJiYgIWFjcGlfaGFzX21ldGhvZChoYW5kbGUsICJfT1ND
IikpIHsNCj4+ICsJCWRldl9kYmcoJmRldmljZS0+ZGV2LCAiX09TQzogbmVnb3RpYXRpb24gc2tp
cHBlZCAobWV0aG9kIG5vdCBwcmVzZW50IGZvciBub24tUENJZSBob3N0IGJyaWRnZSlcbiIpOw0K
Pj4gKwkJcmV0dXJuOw0KPj4gKwl9DQo+PiArDQo+IA0KPiBbU2V2ZXJpdHk6IEhpZ2hdDQo+IERv
ZXMgdGhpcyBlYXJseSByZXR1cm4gdW5pbnRlbnRpb25hbGx5IHNraXAgZGlzYWJsaW5nIEFTUE0g
Zm9yIHRoZXNlIGhvc3QNCj4gYnJpZGdlcz8NCj4gDQo+IFRoZSBjb21taXQgbWVzc2FnZSBzdGF0
ZXMgdGhpcyBjaGFuZ2UgcHJvZHVjZXMgbm8gZnVuY3Rpb25hbCBpc3N1ZXMgYW5kIG9ubHkNCj4g
cmVtb3ZlcyBtaXNsZWFkaW5nIG1lc3NhZ2VzLiBIb3dldmVyLCBiZWZvcmUgdGhpcyBwYXRjaCwg
aWYgdGhlIF9PU0MgbWV0aG9kDQo+IHdhcyBtaXNzaW5nLCB0aGUgZnVuY3Rpb24gd291bGQgcHJv
Y2VlZCwgZmFpbCB0aGUgbmVnb3RpYXRpb24sIGFuZCBmYWxsDQo+IHRocm91Z2ggdG8gdGhlIGZh
aWx1cmUgcGF0aCB3aGVyZSAqbm9fYXNwbSA9IDEgaXMgdW5jb25kaXRpb25hbGx5IHNldC4NCj4g
DQo+IEJ5IHJldHVybmluZyBlYXJseSBoZXJlLCBpdCBsb29rcyBsaWtlICpub19hc3BtID0gMSBp
cyBjb21wbGV0ZWx5IGJ5cGFzc2VkDQo+IGZvciBsZWdhY3kgaG9zdCBicmlkZ2VzLg0KPiANCj4g
QWRkaXRpb25hbGx5LCBpc19wY2llKCkgb25seSBjaGVja3MgZm9yIEFDUElfQlJJREdFX1RZUEVf
UENJRS4gQ291bGQgdGhpcw0KPiBjYXVzZSBDWEwgaG9zdCBicmlkZ2VzIChBQ1BJX0JSSURHRV9U
WVBFX0NYTCkgdG8gZXZhbHVhdGUgdG8gZmFsc2UgaGVyZT8NCj4gSWYgYSBDWEwgYnJpZGdlIGxh
Y2tzIGFuIF9PU0MgbWV0aG9kLCBpdCB3b3VsZCB0YWtlIHRoaXMgZWFybHkgcmV0dXJuIGFuZCBz
a2lwDQo+IEFTUE0gZGlzYWJsZW1lbnQgZW50aXJlbHksIHdoaWNoIGNvdWxkIGxlYXZlIEFTUE0g
ZW5hYmxlZCBpbmFwcHJvcHJpYXRlbHkNCj4gd2l0aG91dCBmaXJtd2FyZSBuZWdvdGlhdGlvbi4N
Cg0KSSB0aGluayBTYXNoaWtvJ3MgcmV2aWV3IGlzIHJlYXNvbmFibGUuIEFjY29yZGluZyB0byBb
MV0sIHVubGVzcyB0aGUNCnBsYXRmb3JtIGV4cGxpY2l0bHkgZ3JhbnRzIHRoZSBPUyBjb250cm9s
IG92ZXIgQVNQTSB2aWEgX09TQywgdGhlIE9TDQpzaG91bGQgbm90IGNoYW5nZSB0aGUgQVNQTSBz
dGF0ZSBjb25maWd1cmVkIGJ5IHRoZSBwbGF0Zm9ybS4NCg0KQWxzbywgYXMgZGVzY3JpYmVkIGlu
IFsyXSwgaWYgQ1hMIDEuMSBob3N0cyBkbyBub3QgcHVibGlzaCBhIENYTCBfT1NDLA0KdGhlIE9T
IHNob3VsZCBmYWxsIGJhY2sgdG8gdGhlIFBDSWUgX09TQyAoanVzdCBhcyBhY3BpX3BjaV9xdWVy
eV9vc2MoKQ0KZG9lcykuDQoNClNvLCBuZWdvdGlhdGVfb3NfY29udHJvbCgpIHNob3VsZCBza2lw
IF9PU0MgbmVnb3RpYXRpb24gb25seSB3aGVuIGENCmxlZ2FjeSBQQ0kgaG9zdCBicmlkZ2UgZG9l
cyBub3QgaGF2ZSBfT1NDLiBGb3IgZXhhbXBsZToNCg0KCS8qIF9PU0MgaXMgb3B0aW9uYWwgZm9y
IFBDSSBob3N0IGJyaWRnZXMgKi8NCglpZiAoIWlzX3BjaWUocm9vdCkgJiYgIWlzX2N4bChyb290
KSAmJg0KCSAgICAhYWNwaV9oYXNfbWV0aG9kKGhhbmRsZSwgIl9PU0MiKSkgew0KCQlkZXZfZGJn
KCZkZXZpY2UtPmRldiwgIl9PU0M6IG5lZ290aWF0aW9uIHNraXBwZWQgKG1ldGhvZCBub3QgcHJl
c2VudCBmb3IgbGVnYWN5IFBDSSBob3N0IGJyaWRnZSlcbiIpOw0KDQoJCS8qDQoJCSAqIERpc2Fi
bGUgQVNQTSB1bmxlc3MgdGhlIE9TIGhhcyBiZWVuIGdyYW50ZWQgY29udHJvbCBvdmVyIGl0DQoJ
CSAqIHZpYSBfT1NDLg0KCQkgKi8NCgkJKm5vX2FzcG0gPSAxOw0KCQlyZXR1cm47DQoJfQ0KDQpJ
ZiBJIGhhdmUgbWlzdW5kZXJzdG9vZCBhbnl0aGluZywgcGxlYXNlIGxldCBtZSBrbm93Lg0KDQpb
MV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzEzMjA5NjExMTMtNTA1MC0xLWdpdC1zZW5k
LWVtYWlsLW1qZ0ByZWRoYXQuY29tLw0KWzJdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8y
MDIyMDQxMzA3MzYxOC4yOTEzMzUtMy12aXNoYWwubC52ZXJtYUBpbnRlbC5jb20vDQoNClRoYW5r
cywNCkthenVtYQ0KDQo+IA0KPj4gIAlzdXBwb3J0ID0gY2FsY3VsYXRlX3N1cHBvcnQoKTsNCj4+
ICANCj4+ICAJZGVjb2RlX29zY19zdXBwb3J0KHJvb3QsICJPUyBzdXBwb3J0cyIsIHN1cHBvcnQp
Ow0KPiANCj4gWyAuLi4gXQ0KPiANCj4+IEBAIC02MTUsMTAgKzYyMSw2IEBAIHN0YXRpYyB2b2lk
IG5lZ290aWF0ZV9vc19jb250cm9sKHN0cnVjdCBhY3BpX3BjaV9yb290ICpyb290LCBpbnQgKm5v
X2FzcG0pDQo+PiAgCQkgKi8NCj4+ICAJCSpub19hc3BtID0gMTsNCj4+ICANCj4+IC0JCS8qIF9P
U0MgaXMgb3B0aW9uYWwgZm9yIFBDSSBob3N0IGJyaWRnZXMgKi8NCj4+IC0JCWlmIChzdGF0dXMg
PT0gQUVfTk9UX0ZPVU5EICYmICFpc19wY2llKHJvb3QpKQ0KPj4gLQkJCXJldHVybjsNCj4+IC0N
Cj4+ICAJCWlmIChjb250cm9sKSB7DQo+PiAgCQkJZGVjb2RlX29zY19jb250cm9sKHJvb3QsICJP
UyByZXF1ZXN0ZWQiLCByZXF1ZXN0ZWQpOw0KPj4gIAkJCWRlY29kZV9vc2NfY29udHJvbChyb290
LCAicGxhdGZvcm0gd2lsbGluZyB0byBncmFudCIsIGNvbnRyb2wpOw0KPiANCg==
