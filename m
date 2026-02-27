Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012060.outbound.protection.outlook.com [52.101.43.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5B438552F;
	Fri, 27 Feb 2026 12:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772195825; cv=fail; b=Rv3A4Gb9YJ3iB0/1HvrT10/rcKMJw/9Hl3Q+0xRvMlMdYHYexE28pCttsgaN6jYDkPApGEL2jvYU1yvlxwBmug8e/I8qApR9SoSMJ6bHd2HEz4K09gwTZvCaDsaV6JjbEzbu9krSD2+UWMs2CEhrif3tZz/OevW8x3L763CC4CQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772195825; c=relaxed/simple;
	bh=yLEteMxN8OWFFQa/Bj6tfoNAGHQXkHXieKBNjgKEHos=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pouhESadGf5GT92jfbfpktCy2tYzGBvS58P3XNXqXRmbR4S032Z64RIlsuzcdg8zmw0CYPPyLKD+XdlYTQ3nwiMnkZHTZMmooDJkUlHCVN1YmHAtt7WXTfzfhui7S5A6pXQdFLW1r+KZPfMRXc/to1cAFF5uVe15tlWQ/lrlJBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eu65hN0e; arc=fail smtp.client-ip=52.101.43.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eu65hN0e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PB7DRYbqkIzo8qGqtzbewhFjAofSl3QaL4wieXUX0Mcnvl5E7X4DlcN91m2+RqNRi9EstfO0zpaFt+WY6IStkwzZP+oyaA+wVrQHsED5HeIxkWqKgcqzZ73Sr/dZaOrL0GdQFFFtosruzxAWPM6Pc1XRNsnnsxWrjCRkh153dtTmJe3w2s18cOHVoUEQV6TLjTY5wLMm8zYN+6vFVIwFggrnmNRvywHvDYBAaVPtm4rNxYilvXflCTbOS+jGYbqjm2Q6SRybvYF/gM9xlIva0yJwjvTVqdsmfGvaVC8BeMRywhuVQTM/qBPcwyLuQJb7HfBoUohlu2pdX7Js5RdvPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLEteMxN8OWFFQa/Bj6tfoNAGHQXkHXieKBNjgKEHos=;
 b=hXoksm0XB6ICRTr9MnXw/eG4lT1G6FS2ogQQz2lqCOZhvHlclvz93dl+DPM4V6R6TtwD4tIPFr1qc0Pc58uu9i1XcYnux08pVxza3DPyp4kzu5oOo1a6HJOhJBvk2Czckb860tXMyHooVg5dX5VdB7RA+pXO0fnP6jYSE+ozrZxPyhTDDj09lIge8tx45If1WBtA8jIMSrS9U2t2QZif+mgyju+kdYREcNJv+iVZTV2rQJbpvDTbODO6OoRlTBLU6MFOvk5fIWVdtOKHf5ZaZSVowitjcbndUJicArdRobWsZjmnvgVOLyV27OAamhxh1loenRhez6H9c8YrcqfDzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLEteMxN8OWFFQa/Bj6tfoNAGHQXkHXieKBNjgKEHos=;
 b=eu65hN0eg+Qrdvd9Npg2wLX/KJB87hLQTIPwp/9dW/yu1tfvFwGXWUSb7MVyL+55F/Yz2kZwKe0Qa++JOXpxc4Xp3siwqdlGez0BBylBzMOmqzedZfk6Ny0Ec/UNBChMovv0jJYmN0DG+A5jT5ERlKQB/UC9TdL6A4Gizfm6d8LZlj/FRnsN6uI/s7L7+j7RGnqXZFrY2qyp7zV4bgG0+BzeTeouetZcTIQhLKJyVEKQY5T7BhvLDW+jvW7oVxgzB6tEzJDivDOyArGHQiJEgL9b8A2sIRZlj6kW1Z4h9+e4Ugf5z7ALrEyb4CMp3+7JmaUnGEj/HBrzTTj9X6KWtw==
Received: from SN7PR12MB6744.namprd12.prod.outlook.com (2603:10b6:806:26c::13)
 by BY5PR12MB4147.namprd12.prod.outlook.com (2603:10b6:a03:205::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 12:37:00 +0000
Received: from SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961]) by SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961%3]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 12:37:00 +0000
From: Vidya Sagar <vidyas@nvidia.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>, Jon Hunter
	<jonathanh@nvidia.com>, "kishon@kernel.org" <kishon@kernel.org>,
	"arnd@arndb.de" <arnd@arndb.de>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "Frank.Li@nxp.com" <Frank.Li@nxp.com>,
	"den@valinux.co.jp" <den@valinux.co.jp>, "hongxing.zhu@nxp.com"
	<hongxing.zhu@nxp.com>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"cassel@kernel.org" <cassel@kernel.org>, "18255117159@163.com"
	<18255117159@163.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 9/9] PCI: tegra194: Add ASPM L1 entrance latency config
Thread-Topic: [PATCH v6 9/9] PCI: tegra194: Add ASPM L1 entrance latency
 config
Thread-Index: AQHcpPTaLzQ/y2rIQU6X+zirVylq6LWWgZ6A
Date: Fri, 27 Feb 2026 12:36:59 +0000
Message-ID: <32af978e-2fd6-4ac4-a402-0580837b8676@nvidia.com>
References: <20260223184538.3084753-1-mmaddireddy@nvidia.com>
 <20260223184538.3084753-10-mmaddireddy@nvidia.com>
In-Reply-To: <20260223184538.3084753-10-mmaddireddy@nvidia.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB6744:EE_|BY5PR12MB4147:EE_
x-ms-office365-filtering-correlation-id: dd2b22ac-bfb5-452d-dadd-08de75fce6f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|921020;
x-microsoft-antispam-message-info:
 Hrq3HEv4SV6ESqDhM4hVgwJQb03y1pceKAFC3wvP+7RIBF/Oes1v+mHka/m+k9L+K6l4QNbC+NWmyy9BTgXQtM4PQEYyyveRigALGei59lk145T2UaMjRKxsOr85ZzKakLEJ4MZQ4h3UHR5VDmek7DA4VddtT9QE4pcNYzbKU8043q9fuVdi1A9pPE04AvYmt5vtQF7OrAWJw/hRNGST01/Z10e0pYlMwBMKuPvvFDLhDoGxzo6Xrn0a+CtQND35On360UfWBaW/yrdGHBWMLPKv5a/6iZGIwkP8an+QDOWkG+c140+o9eqYb/WQTj3fRHz/WKY1wyRBc4I3ls9K+zwy0iGFiQDacMsOMOyPo51q/we6M6bLa8yfFcb6fBuJmDh4yg5gFOnWcyqquvcPTBxxwHFLRuPlEgoAA2eHLevhXHcDURwixE+2mTVwfDyB6BmopErTXb3MMXxhGUvxw8C51JO84oRrFV5B9vrCkLOM1r1M9ycbMn3kUZ/36prOkxIhSAvHbRl/QZSHw9HixqpYstJdrv8iaBRC6HFwlIx2643uZsstkYfktno0g2IoVDRJzCiB/2mlWAnxtf3UgwiQqTdq3C5Lt0lRci5GxiKh6xGGVQQ2DQVGRgZdwcbw6sKx++Acee2Lgr3Zfz1UPxD5XLeRpOPM+hP3oSRthNbRmU0EgNm0b72Aeig53mQA7wKt67BpeFWeW6l9YmqahlorPqaJuuTRuT+yaDlHabe2K8bH8PIH+fbRyv+geoifBykO+0cQvZjjlvA+KH1kLgzpgNQ42IlvbZ4dOQ7TcDE033iVQ0KZdEj9GWhlVdLn
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB6744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d0IweTFIRmlxbUxPV2pxSENuUXp1OHFIbUpDWkI0OVJaK3NIY1RZa1dIdW92?=
 =?utf-8?B?TGpVQkJjVFhxRWNPbXVFR09hU0RTNTRtWHBBYzd4ajdqOU9xc0Zoa1A3ZFZS?=
 =?utf-8?B?eWpwUDJUT3JjdlFOTityUUxpREZQT3lWQWtteHgvbWdMTnN6NHF0ekxlQndC?=
 =?utf-8?B?ZkpxMTZJNzhqeHN4YTF4aXhkY2NJUzZSTlk3Z05VNjJoTlBQUWUydXBVZzND?=
 =?utf-8?B?QkJwenluS2Z3QWFFNlFXM3pvMWFxOHlaZmpLbEdXZ0NFUlVLOGlPK0VZODZU?=
 =?utf-8?B?WHoyOW9GeU9NaHVsa1ZDeVViQ281RStCeHRuWWpaNjFsQmRGczE1VElXSDFI?=
 =?utf-8?B?SStTNkZjV1dtbVJyRFdEcFQrTHFZR09ISGlsckJQNVpYbTJUbkVlcCtVT2JS?=
 =?utf-8?B?emFNZVpFdlFEM0VpdjlpQmppTHVyZGFiamlVTUUvSFc0Sy8vcFNjamYxbDZj?=
 =?utf-8?B?ZDY2ZmMzaFV6cjJEQzhiYThjK3k2S04zblVHVDVrbldOREs2aWJZaWdsaG14?=
 =?utf-8?B?cFFUSDJTME5hK1BtOE9PZkdSVHc4VXh6NzFtazZqR3p4cjBWVEZWbTZBWUFZ?=
 =?utf-8?B?L0JHUmxoWENmRVFXaytzeTBxVXgrT2VMbFR3MVJFaWdRTzVqTldTdlVBRGJm?=
 =?utf-8?B?MFE0U2t0c0lmM3BWZGJtbUZvTk53YXJNVDIxS1d4NHE5NWdEOG5uRXlJZ2Fz?=
 =?utf-8?B?Q1ZKMWszZVJ5dDA4TEM2YjBQRURNdGgrWVphOGRUUWx3SURIK21qeXFFb29y?=
 =?utf-8?B?UitwN2Z0OW1jaVY1MUlIQU5ETlpkM2FGalR0bWJrTGdTOXlsczFVeFBPbDJD?=
 =?utf-8?B?R2NKRDFsVWNaRXJkUEVNMFhhbkZvNlNuSmNOSXUyUzd1MHJSbk9NNFBjcExG?=
 =?utf-8?B?amQ4UFpuQXRnT2ZYMWNzVnJZQUc2dllPTE13c05NVGVuTC9EK0UwMlNJL3ZY?=
 =?utf-8?B?L0RhOC9zdG9pMkczdHlvenc5ZVo0QTJyZG1ublFMQ29KLzdkTmxrRjJIK2sx?=
 =?utf-8?B?WUMzSkNTblFicGNvSXRYNW1uNlQ0enptVERwNkEzWi9HZ290VTFKYVp3cWJC?=
 =?utf-8?B?MUErZEZXWk1HSzdaWTcwZXh3aXJ1c3Nob1owSFVMWExWdlVIZUwrTmZxTURu?=
 =?utf-8?B?ZktueHhudUZ4WTJ4TFRGZWc4aC9ZdWxNUFdXbjgvQmo3M2V0NHU2QnNNQWtV?=
 =?utf-8?B?MEhaMENrZTlodlU1cFU0bmhCR0l2dVpRV0cvYlRHVkkrYTRSUll6dnBpV092?=
 =?utf-8?B?UGJwN1BGZjJnN09oOWJsZjJPdUoxVTdQbitubE9rc0g2S0pCTkxXT3B2S1pl?=
 =?utf-8?B?MWpFT1YzMTRkR3lGMFpYcVRtb0JwV0NjTkdxUW1YbGNKcDMvMXhWeCsva3JJ?=
 =?utf-8?B?SVE3Nm5ZUkZJT2JrWlRWRkl4Q3YyWkE2UkFtVVAxNW1uS0ZwdG42YWk3ckZj?=
 =?utf-8?B?aXEwQ1g0aWQrbjJuSUYzbEYreXFEVmdxZTYvOHN5Vi9IUWxZOGpEQ2xDalds?=
 =?utf-8?B?VVBTSkd1S3cxMlMxdVV2OVhXTnZYOWkrS3ZGaS9iMEVRZkMyenJKYW9SemQw?=
 =?utf-8?B?K0JaTk5pMnFIR1JjRkkrNDhLblZmVU1QVFpBTFg1OHJhcFJzSHlQVENFVjRs?=
 =?utf-8?B?NDZvMVpuVDMrSUZvZkZldzdkb04rRlhyWUxGWVVUZ0hJSEM3N0VXSWl5OHZX?=
 =?utf-8?B?bTBGdHg3ZGlrWktWYnRXUy9HQmJXRDFZeUN0TlRJSzZ3NnNDMmRzOW95RTJF?=
 =?utf-8?B?Z0lRQjVuQWZtdGxsYlBUaXFrSEVQdkpHTzFEcXJqTDRyNmplWStlZDlxaStY?=
 =?utf-8?B?RktGa2tZSjRBVVZ4d2tUVXczdnhqRWZhSDZxdDNPY2ZGN0I2Qy9zTWVLbGlD?=
 =?utf-8?B?N1l2em1VVmdXTHFseHpWNGQxbER1OGlvdG5wTFdyZGY0L3FKMmptVnJoU2g5?=
 =?utf-8?B?bkZORlNwdmZhZW1KR2hwYko3cHcxVUEzYVhmMmRUdVdPTnBYMFE3dWM2Y0dt?=
 =?utf-8?B?OWhzWDNDb2JjMTNRT05vQVFKYzVySlpqdHNhb0VYcFJiVE45OVdnc1ErRFhu?=
 =?utf-8?B?N2plYWdHTkVPVWJVaUY3T3VHZXRRdUhhN1gvT0xKdEloR1dnbFF0SXRQU3hU?=
 =?utf-8?B?cTk0NENqMGJ1WmpFU1JBRFJUZm5BbVgxOGsxaElhZ21iN2FsWG5ZdytXOGFI?=
 =?utf-8?B?WDYwRDlxSnJHRFMrbnVXeWNzMDY4M3BGRks4YlB4S3pveHhLZGdXTUdtL2Er?=
 =?utf-8?B?bmFsOTN2U1ROTDNVV0NDV3N1c2NGUFpsVHZGR3hLWWUybEExZFdZbk1xdy9t?=
 =?utf-8?B?SVNlYlJSZGlvWU14MGMvbk1EOEtGcGtPd1lJNUQyZ0NVMlorcTlFQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <78C6B93AE32D8C409010C4848661E0FB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd2b22ac-bfb5-452d-dadd-08de75fce6f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 12:36:59.9897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Rwzhf13Hq1suj9oHCvN+z6ezAVSP7xBT6JuTueCfGiIC65Ey2Y/xuBSb6unioDb+PpmE16RFAQX+a7cXLOk1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4147

T24gMjQvMDIvMjYgMDA6MTUsIE1hbmlrYW50YSBNYWRkaXJlZGR5IHdyb3RlOg0KPiBGb3IgVGVn
cmEyMzQsIHRoZSBIVyBQSFkgdGVhbSBjb25kdWN0ZWQgZXhwZXJpbWVudHMgYW5kIGRldGVybWlu
ZWQgdGhlDQo+IG9wdGltYWwgQVNQTSBMMSBlbnRyYW5jZSBsYXRlbmN5IHZhbHVlczogOCB1cyBm
b3IgUm9vdCBQb3J0IG1vZGUgYW5kDQo+IDE2IHVzIGZvciBFbmRwb2ludCBtb2RlLiBVcGRhdGUg
dGhlIGRlZmF1bHQgQVNQTSBMMSBlbnRyYW5jZSBsYXRlbmN5DQo+IGNvbmZpZ3VyYXRpb24gYWNj
b3JkaW5nbHkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYW5pa2FudGEgTWFkZGlyZWRkeSA8bW1h
ZGRpcmVkZHlAbnZpZGlhLmNvbT4NCj4gLS0tDQo+IENoYW5nZXMgVjEgLT4gVjY6IE5vbmUNCj4g
DQo+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLXRlZ3JhMTk0LmMgfCA4ICsrKysr
KysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS10ZWdyYTE5NC5jIGIvZHJpdmVycy9w
Y2kvY29udHJvbGxlci9kd2MvcGNpZS10ZWdyYTE5NC5jDQo+IGluZGV4IDgyZTllZjE3MmRlMS4u
MWI0ZmM2YTliZWQxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9w
Y2llLXRlZ3JhMTk0LmMNCj4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS10
ZWdyYTE5NC5jDQo+IEBAIC0yNDQsNiArMjQ0LDggQEAgc3RydWN0IHRlZ3JhX3BjaWVfZHdfb2Zf
ZGF0YSB7DQo+ICAJdTMyIGNkbV9jaGtfaW50X2VuX2JpdDsNCj4gIAl1MzIgZ2VuNF9wcmVzZXRf
dmVjOw0KPiAgCXU4IG5fZnRzWzJdOw0KPiArCS8qIEwxIExhdGVuY3kgZW50cmFuY2UgdmFsdWVz
KFJlc3QvUHJvZCkgKi8NCj4gKwl1MzIgYXNwbV9sMV9lbnRlcl9sYXQ7DQo+ICB9Ow0KPiAgDQo+
ICBzdHJ1Y3QgdGVncmFfcGNpZV9kdyB7DQo+IEBAIC03MTQsNiArNzE2LDggQEAgc3RhdGljIHZv
aWQgaW5pdF9ob3N0X2FzcG0oc3RydWN0IHRlZ3JhX3BjaWVfZHcgKnBjaWUpDQo+ICAJdmFsID0g
ZHdfcGNpZV9yZWFkbF9kYmkocGNpLCBQQ0lFX1BPUlRfQUZSKTsNCj4gIAl2YWwgJj0gflBPUlRf
QUZSX0wwU19FTlRSQU5DRV9MQVRfTUFTSzsNCj4gIAl2YWwgfD0gKHBjaWUtPmFzcG1fbDBzX2Vu
dGVyX2xhdCA8PCBQT1JUX0FGUl9MMFNfRU5UUkFOQ0VfTEFUX1NISUZUKTsNCj4gKwl2YWwgJj0g
flBPUlRfQUZSX0wxX0VOVFJBTkNFX0xBVF9NQVNLOw0KPiArCXZhbCB8PSAocGNpZS0+b2ZfZGF0
YS0+YXNwbV9sMV9lbnRlcl9sYXQgPDwgUE9SVF9BRlJfTDFfRU5UUkFOQ0VfTEFUX1NISUZUKTsN
Cj4gIAl2YWwgfD0gUE9SVF9BRlJfRU5URVJfQVNQTTsNCj4gIAlkd19wY2llX3dyaXRlbF9kYmko
cGNpLCBQQ0lFX1BPUlRfQUZSLCB2YWwpOw0KPiAgfQ0KPiBAQCAtMjQ3MSw2ICsyNDc1LDcgQEAg
c3RhdGljIGNvbnN0IHN0cnVjdCB0ZWdyYV9wY2llX2R3X29mX2RhdGEgdGVncmExOTRfcGNpZV9k
d19yY19vZl9kYXRhID0gew0KPiAgCS8qIEdlbjQgLSA1LCA2LCA4IGFuZCA5IHByZXNldHMgZW5h
YmxlZCAqLw0KPiAgCS5nZW40X3ByZXNldF92ZWMgPSAweDM2MCwNCj4gIAkubl9mdHMgPSB7IDUy
LCA1MiB9LA0KPiArCS5hc3BtX2wxX2VudGVyX2xhdCA9IDMsDQo+ICB9Ow0KPiAgDQo+ICBzdGF0
aWMgY29uc3Qgc3RydWN0IHRlZ3JhX3BjaWVfZHdfb2ZfZGF0YSB0ZWdyYTE5NF9wY2llX2R3X2Vw
X29mX2RhdGEgPSB7DQo+IEBAIC0yNDgwLDYgKzI0ODUsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IHRlZ3JhX3BjaWVfZHdfb2ZfZGF0YSB0ZWdyYTE5NF9wY2llX2R3X2VwX29mX2RhdGEgPSB7DQo+
ICAJLyogR2VuNCAtIDUsIDYsIDggYW5kIDkgcHJlc2V0cyBlbmFibGVkICovDQo+ICAJLmdlbjRf
cHJlc2V0X3ZlYyA9IDB4MzYwLA0KPiAgCS5uX2Z0cyA9IHsgNTIsIDUyIH0sDQo+ICsJLmFzcG1f
bDFfZW50ZXJfbGF0ID0gMywNCj4gIH07DQo+ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdGVn
cmFfcGNpZV9kd19vZl9kYXRhIHRlZ3JhMjM0X3BjaWVfZHdfcmNfb2ZfZGF0YSA9IHsNCj4gQEAg
LTI0OTIsNiArMjQ5OCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdGVncmFfcGNpZV9kd19vZl9k
YXRhIHRlZ3JhMjM0X3BjaWVfZHdfcmNfb2ZfZGF0YSA9IHsNCj4gIAkvKiBHZW40IC0gNiwgOCBh
bmQgOSBwcmVzZXRzIGVuYWJsZWQgKi8NCj4gIAkuZ2VuNF9wcmVzZXRfdmVjID0gMHgzNDAsDQo+
ICAJLm5fZnRzID0geyA1MiwgODAgfSwNCj4gKwkuYXNwbV9sMV9lbnRlcl9sYXQgPSA0LA0KPiAg
fTsNCj4gIA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCB0ZWdyYV9wY2llX2R3X29mX2RhdGEgdGVn
cmEyMzRfcGNpZV9kd19lcF9vZl9kYXRhID0gew0KPiBAQCAtMjUwNCw2ICsyNTExLDcgQEAgc3Rh
dGljIGNvbnN0IHN0cnVjdCB0ZWdyYV9wY2llX2R3X29mX2RhdGEgdGVncmEyMzRfcGNpZV9kd19l
cF9vZl9kYXRhID0gew0KPiAgCS8qIEdlbjQgLSA2LCA4IGFuZCA5IHByZXNldHMgZW5hYmxlZCAq
Lw0KPiAgCS5nZW40X3ByZXNldF92ZWMgPSAweDM0MCwNCj4gIAkubl9mdHMgPSB7IDUyLCA4MCB9
LA0KPiArCS5hc3BtX2wxX2VudGVyX2xhdCA9IDUsDQo+ICB9Ow0KPiAgDQo+ICBzdGF0aWMgY29u
c3Qgc3RydWN0IG9mX2RldmljZV9pZCB0ZWdyYV9wY2llX2R3X29mX21hdGNoW10gPSB7DQoNClJl
dmlld2VkLWJ5OiBWaWR5YSBTYWdhciA8dmlkeWFzQG52aWRpYS5jb20+DQo=
