Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013022.outbound.protection.outlook.com [40.107.201.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3799D3A0EA2;
	Wed, 25 Feb 2026 13:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772025217; cv=fail; b=J2VErNwIaKie8CWp71hAs4b32ULvla+CHf00T677MhVW4c8igUcFCQrBH66rdjPIEgmUSBs64HEW47Rw+Mlz3FwgiZnwvLrQluITGct0U7Icn88RIPL97Cu0vpnmX+nA3uG/s/kiiUn2QKwp6TphODH7JbYAvnIUTBM6TASypVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772025217; c=relaxed/simple;
	bh=UugqRoO3bPiqJHyW7qD6F7hjvebEd0ZgLEjKwJGO0W4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jQmZa13Z80sPBFTlhrSyN8q9qoHqGLET7DRbZ1bENRsQjqV0InZeNbSXfop12jeUAH35R697ke3jneJgOZ8asz5tymPnje9b7RzAFT5RAIrxuHJpB/35qA3yhKHCAQ76vWUeuUA7hKITX0li2dA+R+A6HEdHAUkb8U1oSWhzq6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SrNF+xnG; arc=fail smtp.client-ip=40.107.201.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SrNF+xnG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T2IGFS05w1MdTGaAQMYHtJpKdzZwKYlpIWl1SyYa6xXhJp7v8HQjinAs3LV2+0t8+kKPCk/xUL5GuSZULTrCjiF37feb+OacxysQbhMpitBQokxT3k0nkJP5pgylJsPaCHGzfsgpZg+1TCR00nO1JHR1snKv3NlA/eWnNcucP0mRQ9cxADiVlzpaRzHbEHXvdBxw5CZyPWGIO1131/uvHqYildOdwD0txuV9sini3sa9PvEnv//B8e+BNY4EQ3lunuvDLelPl4GLvr2OijDVTA7bv4RjMIUxOMlI8aFOL08tC86zb52+Uo1s4Oo7FX/zZI9UIExFeo6SD8Bjm1A7Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UugqRoO3bPiqJHyW7qD6F7hjvebEd0ZgLEjKwJGO0W4=;
 b=jOf9/TKSz2uaKHwLsfzEWPU5UivC9ebkVG+sAcQwuQhM4CxDVEQvdxr+63/boTuSnXdjH7T45NHk3diFY7hA3hfKd/5BlG+lUkzB/JSuXiU3SHwGEasgfLSElF/I5Dkd9OVDOna6/NjDZgEIZRA35kWorUQlKTxf0qGUy4hRLmj8XUlWISG0WlF+EqX3wTm6bC9jH8cepu7lKqDCk7v6VZJvH91F+gQLqoH2tigovgsd/7FhykF8aKBVnGXDRTjMH9g/+4IZNZJxp9Lyl1qF6t8QOA6wPp93DddATs3D0bkkrKfzUAi6Nt1UHruzYg654Rcnx1K9TgGwgBe/Ifh+Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UugqRoO3bPiqJHyW7qD6F7hjvebEd0ZgLEjKwJGO0W4=;
 b=SrNF+xnGv4G/MfKV9zQSj+FgHrUhTDEQekoqirbotreVJlJQ5Vl3OwxrjJUTWXWE7mWqedRunBgvXe5gsTn5jegWOcLS5oLHKrBzcpJNopi1bwh/o1y6TMVqdgUrFiTDlytz0vR/un2GYrc2opGIW2UJohENLZsSEEnidAHPd1yWMqWKxYD7fn6xOcXKUjNgKZ7sLWt5skHwVNgZd4mIC2fcOgaTjILQqOwezLfTirWBXsYAavSncMyvlTj3jM9TUyBzqxnoh/B3kSwBRjaxbHOiJrnIa9CGKi6vSAQNWYUNlBGSiNoWOhxllYClfZKdtSCZmguXBLF1Bb91nrLtRA==
Received: from SN7PR12MB6744.namprd12.prod.outlook.com (2603:10b6:806:26c::13)
 by IA1PR12MB6067.namprd12.prod.outlook.com (2603:10b6:208:3ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 13:13:30 +0000
Received: from SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961]) by SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 13:13:30 +0000
From: Vidya Sagar <vidyas@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>, "raphael.norwitz@nutanix.com"
	<raphael.norwitz@nutanix.com>, Dan Williams <dan.j.williams@intel.com>
CC: Vikram Sethi <vsethi@nvidia.com>, Shanker Donthineni
	<sdonthineni@nvidia.com>, Srirangan Madhavan <smadhavan@nvidia.com>, Sai
 Yashwanth Reddy Kancherla <skancherla@nvidia.com>, Vishal Aslot
	<vaslot@nvidia.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Krishna Thota
	<kthota@nvidia.com>, Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	"sagar.tv@gmail.com" <sagar.tv@gmail.com>
Subject: Re: [PATCH V1] PCI: Hide SBR from reset_methods if masked by CXL
Thread-Topic: [PATCH V1] PCI: Hide SBR from reset_methods if masked by CXL
Thread-Index: AQHcoqKiG24KlYCSm0Ksb0cJxXYNarWMGHmAgAQuNQCAACzggIAC+D4A
Date: Wed, 25 Feb 2026 13:13:30 +0000
Message-ID: <66a7d3e6-d97d-43e3-8629-e793dbabb1f8@nvidia.com>
References: <20260220195259.2397847-1-vidyas@nvidia.com>
 <835de7c9-a64f-4aaa-95e0-b91c2ae5885e@intel.com>
 <82a5a344-26d7-40ef-9047-60657c6923b0@nvidia.com>
 <d6e2617b-6dd2-4c08-830d-e6d917387c66@intel.com>
In-Reply-To: <d6e2617b-6dd2-4c08-830d-e6d917387c66@intel.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB6744:EE_|IA1PR12MB6067:EE_
x-ms-office365-filtering-correlation-id: 26f96f12-1039-437f-84cd-08de746fabc8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 OoayTtFkwJufHEGfWISp8H3Gi7rlXkoHg4AzfOMNslvntrJj/TOArG9NWvyzU19PWW/BbbfpIh3IMZLJX51VDhMoCpk8wNHQYpVFmlUz26/Zrt/UAcFtm80f2LlnlatzTD/+IlCRWIwOQFNu+kQPa9JxZ4mHeXkf0V/xZo0pC24gRyJc6hyGChDhFGOR034pBsNE61bU5kU5qsq8LQs9YeXfwRKqtN/vNUG/tTVC/n4tMYDKKxYCoMuNPP5pWXUto/rAcvTKLJUexqDD8GimcKQlV8vOTUKhL2bHfUSFSeWtWdM5FnS6zIYNSmHQ2Zl+2tA6tzGc6QGtKzrgWAGzvYIyCD0Qrb4rf6uZsyrjDssw/fptKykVChY7S98h1QTvj8d98LavKQNzu3gXmuzkW1xf/iIlDcKc8RO784QTSonoEk5XM/IEvclWtsdD/EIx9BzLsDPOcUcXm2+72W2rmwHHw//w3E7JwYc99DWsqEZ2rHPCl4RnfZE4JhtlKiLmObVPy7ElHdNAfgUFX7jYYFBVA3hgIkeGB85AbYGKmfJ0iv28EnoQZI+PNtSjZzjFSL80D+5KuLSBhiyX1LvF4rnRhaI9UL/cHjKj0ejXeXIj1I87pYwQMYiu+hMU+sxRlcsebQpwnZURWjxGtzhVsSXQrI8p913HRc/L+qniYtRIRB0Sq4Ylh8rjZwDApUWNXIe+MSDH1awlsA1CdYmZgFDyLYYUg3satqkzyWyoEyOvc0ufckiKjoiJF2l6fIqN2J7S81SBLs22C9dtkFdJ+u//rYQzH11L/1Zu38oaGd0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB6744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UkFTeE4rNFVpZmNOMEtoaUFxNTFhZE1hcWlQZjdRUG1Qa0FIVys0YVlydWR0?=
 =?utf-8?B?NmQzUGx1WW5ZSmNVeTZUN0FpK052YzVRMGlwdHhPb1pHTHYzTzNZeklnbmQ5?=
 =?utf-8?B?a2ZlWnJhRkI4OGVCUjNleWNtcjBkd3M3OW1vUHVwTG5NZXZ1QzZEVTN0bjNZ?=
 =?utf-8?B?WEJieEU0aWoyR2lRZXlwc05EclFVS25MMk5uVW40a1RVQktGK1RSV1JpK0s1?=
 =?utf-8?B?QmZwTVMrbkpQNjJGU1A5NytiRDZ2UU0xN2FBU2pLa3RMczVVR2xxVTJUNjBR?=
 =?utf-8?B?SGV2TEwvYWszZXJTekF0engxUjkwV0plSEFoN2NwMWNWWXdxUC80YmJ2VTdW?=
 =?utf-8?B?WkRQajI5Uk0zc3MvcDlLMzVsNWlyaUo2Y2FsVEJEdUJrK2hJVmxuT3RvSFEw?=
 =?utf-8?B?MEcxZkJsdkNxTUpPYlFPcVc2R2ZVMmZHQTk2dzV2QmRmVlI3WlY0ajQrM2c3?=
 =?utf-8?B?SnN5Qk9ObUo1OThwQU9qbnV2TmxUNFUvcVZxN0RIWlpaZXNPeDJ3SzQ0d25B?=
 =?utf-8?B?bkh0eHhtblhJZ1NISXNSSVQwSWRPUHpxOWpUcWtrR1ErSk9ON01vdWlTaDJG?=
 =?utf-8?B?eDlNMHk4RitoZmUxK1N1Z1FqdlVJR2trci9uSXZIQ2hBY2s5bjg1UVVWbGd1?=
 =?utf-8?B?MXNNVHlDY21mK09ORlF4SWVEOURxZUNyZmc2b3BrTktYYXEreUQ5TkFGZHNH?=
 =?utf-8?B?dzB3NmZNQk5BcVNCczJhZDNHbGJhYnZxamxZdE1uekdJNXA4dWlxU0Uxd1pE?=
 =?utf-8?B?MS9TcXo2cjNqdk1YZzFNYUFtSnllZzUvYnpISmFLUUZqdklaZ2VqY1IrcGNy?=
 =?utf-8?B?TEpMVUlxRTF2ZHo4TWRxSmYrQVYvdExOTFlXWUExdHNhUVBNYWdvNVo1Wmln?=
 =?utf-8?B?UnRpMEdOZ1hpTC9GRGlSZUlMd21yVmxJV1BQQWVSMVh3WisyTDZVbXk1T0tW?=
 =?utf-8?B?QkhkOW1zZi9TM2FSUE1UaXh0akpsM2hzQWdUWTBGY00rOEFUSVRnclhPYUY2?=
 =?utf-8?B?djJiV1JlOWFaNWZDWHQxZkJqOVIrb2pIZmRMR2hHZmY4TUVQMWk4Y2tDRmNM?=
 =?utf-8?B?NjBLWXJLQWdsTng2WnMvRWM5QTFFNW5Jc3plNHExR1YxN01xOFdpTGt2MWx0?=
 =?utf-8?B?ZldCMzZaTDNyRUYxWDFYVVg4QlZ0c1dzeTM3NXpBYWZLS2ZaaFpQNW9CTmtn?=
 =?utf-8?B?MDBmN3MvSzBZSm42b1l1Q2VMUjgrVnNCOC9VYXpRZ1dIOUVSdDZMdFU0Z3hn?=
 =?utf-8?B?OWNtbjZxMnJzYW1EcXBPWXhjUzhNSTFvdTErVjhPWEZUeG1QaXNrTEtIZWhl?=
 =?utf-8?B?Ti9wUnFOUWZGTFhrdWM1MS9HejFEeFU3K0JMYW84cHlla083L0pmVmgxNXRy?=
 =?utf-8?B?eVc1R1ZIbWdHUUhLRjdycVoxUVZxME9BUGM5aFFPUzkzSHhZWUVXZ3FlcDkw?=
 =?utf-8?B?dXhxdHRFUzZyU0lkMWxZaHN6YVN0QitFSTZvdXgyZHNMUVByaHFJaFExZVJ4?=
 =?utf-8?B?UFo4Zit4SVhvMkdTTlQwWGdFcmNUQXBhMk1pWWg2cHFSdHZpSGlyRCtQblJU?=
 =?utf-8?B?ZWpDY0lpV1RTeHVza2pBY1k3Z0ZxNU42YXZIV2NvNzNLYng4MXJuRGhza1RR?=
 =?utf-8?B?aWN2YVlLSTBYdWRiL3c1bk1sbStLbS9acFZFOWdPZFBERUxxWHMwYVc2aDJi?=
 =?utf-8?B?bkliSTJRNXNONENHNzhGQjBhcHF1WEhVU0txMTJRdU42NWNGbFZtUHRraUtl?=
 =?utf-8?B?OWQ4Z2FUOEpyZE13UW5tSDJhUXpqeUF0ZWhSYnZVMitadk1ISzdSeFNoSzc5?=
 =?utf-8?B?bWQwengvSjhnMis2dHhxTXZYQ0dYOFZOaUZ2allWM0p6dWFDTThia0Y4VUE5?=
 =?utf-8?B?MWNxbUhPcUsrUFBIdGNQdGl4T012dmFIbEs4azgzampCMlJ4N2VVUnduZkhj?=
 =?utf-8?B?cFZYSGZVYzh4WjlDS2ZiYThvczRaVERKcHI0QjlTNU5NeWYzVVhLbkU3QTJx?=
 =?utf-8?B?eVJ2c3VyTEgwNHREOTZKODA3RkNNc1ZaN0lRb3RkVVhjTDE2VXRqVkRKUkFK?=
 =?utf-8?B?d2s3NTY2MndtWlNWUldUWm9rc1NaQXZVOS9iQ2FNZ1Z5Z0xEK2lhU3dtTHY4?=
 =?utf-8?B?cGxtQWZYSzZPVFVTcmxoOGk5L3JLYTA0VDd4Z0VZK1oyazNyTlhWekpjVkhR?=
 =?utf-8?B?VENkYUtNUDVmR2toQzIzaFM0U21uMHJzNVpnTllZNFoxNWZLZ09pc0pNM3dQ?=
 =?utf-8?B?TVdPVkNaMmVkNHQyS3RIUnkxTDd2RlNzREF2WXpZSU80eG5KZ09WV0h2YlZQ?=
 =?utf-8?B?U1g5ZjZwT0ZoSEd5YTRUdi82Y2RodEZudGZZWVVoK1Y3VS9XRmFCZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EDEF3B888AE62542AC18C5599B869C94@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 26f96f12-1039-437f-84cd-08de746fabc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 13:13:30.5040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j4kxMxIjzzPIZD+LOEOjfwLjP2vvPRE8RMQSlPHvYZq9nu2HxNS9dneIdmxptMd/sC8CxPPJBuqTtWD+O3EZrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6067

T24gMjMvMDIvMjYgMjE6MjIsIERhdmUgSmlhbmcgd3JvdGU6DQo+IEV4dGVybmFsIGVtYWlsOiBV
c2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4gT24gMi8y
My8yNiA2OjExIEFNLCBWaWR5YSBTYWdhciB3cm90ZToNCj4+IE9uIDIxLzAyLzI2IDAyOjUxLCBE
YXZlIEppYW5nIHdyb3RlOg0KPj4+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5n
IGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+Pj4NCj4+Pg0KPj4+IE9uIDIvMjAvMjYgMTI6NTIgUE0s
IFZpZHlhIFNhZ2FyIHdyb3RlOg0KPj4+PiBUaGUgQ1hMIHNwZWNpZmljYXRpb24gKGUuZy4sIENY
TCByMy4xIHYxLjAsIHNlYyA4LjEuNS4yKSBkZWZpbmVzDQo+Pj4+IHRoZSAiVW5tYXNrIFNCUiIg
Yml0IGluIHRoZSBQb3J0IENvbnRyb2wgRXh0ZW5zaW9ucyBSZWdpc3Rlci4NCj4+Pj4gV2hlbiB0
aGlzIGJpdCBpcyAwIChkZWZhdWx0KSwgYXNzZXJ0aW5nIHRoZSBTZWNvbmRhcnkgQnVzIFJlc2V0
IChTQlIpIGJpdA0KPj4+PiBpbiB0aGUgQnJpZGdlIENvbnRyb2wgcmVnaXN0ZXIgaGFzIG5vIGVm
ZmVjdCBvbiB0aGUgZG93bnN0cmVhbSBidXMuDQo+Pj4+DQo+Pj4+IEN1cnJlbnRseSwgdGhlIExp
bnV4IFBDSSBjb3JlIGNoZWNrcyB0aGlzIGNvbmRpdGlvbiBpbg0KPj4+PiBwY2lfcmVzZXRfYnVz
X2Z1bmN0aW9uKCkuIElmIFNCUiBpcyBtYXNrZWQsIGl0IHJldHVybnMgLUVOT1RUWSBkdXJpbmcg
dGhlDQo+Pj4+IGV4ZWN1dGlvbiBvZiB0aGUgcmVzZXQuIEhvd2V2ZXIsIGR1cmluZyB0aGUgcHJv
YmUgcGhhc2UgKHdoZW4gcHJvYmU9dHJ1ZSksDQo+Pj4+IHRoZSBmdW5jdGlvbiBjdXJyZW50bHkg
cmV0dXJucyAwLiBUaGlzIDAgcmV0dXJuIHZhbHVlIGluY29ycmVjdGx5IHNpZ25hbHMNCj4+Pj4g
dG8gdGhlIFBDSSBzdWJzeXN0ZW0gdGhhdCBTQlIgaXMgYSB2aWFibGUgcmVzZXQgbWV0aG9kIGZv
ciB0aGUgZGV2aWNlLg0KPj4+DQo+Pj4gVGhlICJVbm1hc2sgU0JSIiBiaXQgaXMgYSB0b2dnbGUg
Yml0LiBJdCBkb2VzIG5vdCBnaXZlIGluZGljYXRvciB3aGV0aGVyIHRoZSBkZXZpY2UgaXMgY2Fw
YWJsZSBvZiBTQlIgb3Igbm90Lg0KPj4NCj4+IE5vdCBzdXJlIGhvdyBpcyB0aGlzIHBvaW50IHJl
bGV2YW50IGhlcmUuIENhbiB5b3UgaGVscCBtZSB1bmRlcnN0YW5kPw0KPiANCj4gVGhhdCBtZWFu
cyBpdCdzIG5vdCBhIGNhcGFiaWxpdHkgYml0LiBJdCdzIGEgci93IHRvZ2dsZSBiaXQgdG8gbWFz
ayBvciB1bm1hc2sgU0JSIGZvciBDWEwuDQo+IA0KPj4NCj4+IEJUVywgd2hhdCBkbyB5b3UgbWVh
biBieSAid2hldGhlciB0aGUgZGV2aWNlIGlzIGNhcGFibGUgb2YgU0JSIG9yIG5vdCIuIE15IHVu
ZGVyc3RhbmRpbmcgaXMgdGhhdCBlYWNoIGRvd25zdHJlYW0gcG9ydA0KPj4NCj4+IG11c3Qgc3Vw
cG9ydCBTQlIuIFRoZSBwYXRjaCBJIG1hZGUgd291bGQgZW5zdXJlIHRoYXQgJ2J1cycgZW50cnkg
aXMgbm90IHNob3duIHVuZGVyICdyZXNldF9tZXRob2RzJyBpZiB0aGUgZG93bnN0cmVhbQ0KPj4N
Cj4+IHBvcnQgaXMgYSBDWEwgY2FwYWJsZSBwb3J0IGFuZCAnVW5tYXNrIFNCUicgaXMgJzAnLg0K
PiANCj4gVGhlIHB1cnBvc2Ugb2YgaW50cm9kdWNpbmcgdGhlIGN4bCBidXMgcmVzZXQgbWV0aG9k
IGlzLCAieW91IGtub3cgd2hhdCB5b3UgYXJlIGRvaW5nIiBiZWNhdXNlIHlvdSBzZWxlY3RlZCB0
aGlzIG1ldGhvZCBhbmQgdGhlIGtlcm5lbCB3aWxsIHNldCB0aGUgYml0IHRvIGFsbG93IHRoZSBy
ZXNldC4NCkknbSBub3QgcmVhbGx5IHF1ZXN0aW9uaW5nIHRoZSBwdXJwb3NlIG9mICdjeGxfYnVz
JyByZXNldCBtZXRob2QuDQpJJ20gb25seSB3b25kZXJpbmcgd2h5IGlzICdidXMnIHJlc2V0IG1l
dGhvZCBzaG93biBpZiBpdCBjYW4ndCBiZSB1c2VkLg0KPiBCeSBkZWZhdWx0IHRoZSBVbm1hc2sg
U0JSIGJpdCBpcyBjbGVhci4gU28gaWYgeW91IGhpZGUgdGhlIHJlc2V0IGF0dHJpYnV0ZSB0aGVu
IHRoZSB1c2VyIGNhbid0IHJlc2V0IHdpdGhvdXQgZ29pbmcgdGhyb3VnaCBvdGhlciBtZWFucyB0
byBzZXQgdGhlIGJpdCBmaXJzdCAoaS5lLiB2aWEgc2V0cGNpIHRvb2wpLiBUaGlzIGlzIGludGVu
dGlvbmFsbHkgc2V0dXAgdG8gZG8gdGhpcyB0aHJvdWdoIHRvdGFsIGNvbnRyb2wgb2YgdGhlDQo+
IGtlcm5lbCBhbmQgbm90IGhhdmluZyB0byBqdW1wIHRocm91Z2ggaG9vcHMgdG8gdG9nZ2xlIGJp
dCB2aWEgYSB1c2VyIHRvb2wgZmlyc3QuIE90aGVyd2lzZSB5b3UgY2FuIGp1c3QgdG9nZ2xlIHRo
ZSBiaXQgd2l0aCBhIHVzZXIgdG9vbCBhbmQgdXNlIHRoZSBzdGFuZGFyZCBQQ0kgYnVzIHJlc2V0
IG1ldGhvZC4NClRoaXMgZG9lc24ndCBtYWtlIG11Y2ggc2Vuc2UgdG8gbWUuIFNpbmNlIHRoZSAn
Y3hsX2J1cycgbWV0aG9kIGlzIGFueXdheSBnb2luZyB0byB1cGRhdGUgdGhlICdVbm1hc2sgU0JS
JyBiZWZvcmUgYXBwbHlpbmcgdGhlIFNCUiB0aHJvdWdoIEJyaWRlIENvbnRyb2wgcmVnaXN0ZXIs
IHdoYXQgaXMgdGhlIHBvaW50IGluIHNob3dpbmcgJ2J1cycgd2hpY2ggZG9lc24ndCB3b3JrIGJ5
IGRlZmF1bHQgYW5kIGV4cGVjdGluZyB0aGUgdXNlciB0byB0b2dnbGUgdGhlICdVbm1hc2sgU0JS
JyB0aHJvdWdoIHRvb2xzIGxpa2Ugc2V0cGNpPyBUaGUgdXNlciBjYW4gdmVyeSB3ZWxsIHVzZSAn
Y3hsX2J1cycgZGlyZWN0bHkgd2hpY2ggZG9lcyB0aGUgc2FtZSB0aGluZywgcmlnaHQ/DQpCVFcs
IEkgZm91bmQgb25lIGlzc3VlIHdpdGggbXkgY3VycmVudCBwYXRjaCB3aGVyZSBJIHRyeSB0byBo
aWRlICdidXMnIGlmICdVbm1hc2sgU0JSJyBpcyAnMCcsIGJ1dCB0aGUgQ1hMIHNwZWMgYWxzbyBz
YXlzIHRoYXQgZm9yIHRoZSBTQlIgYml0IGluIEJyaWRnZSBDb250cm9sIFJlZ2lzdGVyIHRvIGJl
IGluZWZmZWN0aXZlLCBib3RoICdVbm1hc2sgU0JSJyBzaG91bGQgYmUgJzAnIGFuZCBhbHNvIHRo
ZSBsaW5rIGFzIHN1Y2ggbXVzdCBiZSBvcGVyYXRpbmcgaW4gdGhlIENYTCBtb2RlLiBJJ2xsIHB1
c2ggVjIgcGF0Y2ggdG8gYWRkIHRoaXMgY2hlY2sgYXMgd2VsbC4NCj4gDQo+IFBsZWFzZSBzZWUg
Y29tbWl0IGxvZyBvZiB0aGlzIGNvbW1pdDoNCj4gNTNjNDliNmU2ZGQyICgiUENJL0NYTDogQWRk
ICdjeGxfYnVzJyByZXNldCBtZXRob2QgZm9yIGRldmljZXMgYmVsb3cgQ1hMIFBvcnRzIikNCj4g
DQo+IERKDQo+IA0KPj4NCj4+PiBUaGUgb3JpZ2luYWwgdGhvdWdodCB3YXMgdGhhdCBpZiB0aGUg
dXNlciBpcyBpc3N1aW5nIENYTCBTQlIsIHlvdSBrbm93IHdoYXQgeW91IGFyZSBkb2luZyBhbmQg
dGhlIGtlcm5lbCB3aWxsIHNldCB0aGF0IGJpdCBhbmQgaXNzdWUgdGhlIFNCUi4NCj4+Pg0KPj4+
IERKDQo+Pj4NCj4+Pj4gQXMgYSByZXN1bHQsICdidXMnIGlzIGxpc3RlZCBpbiB0aGUgZGV2aWNl
J3MNCj4+Pj4gL3N5cy9idXMvcGNpL2RldmljZXMvLi4uL3Jlc2V0X21ldGhvZHMgYXR0cmlidXRl
LCBldmVuIHRob3VnaCB0aGUgaGFyZHdhcmUNCj4+Pj4gaXMgaW5jYXBhYmxlIG9mIHBlcmZvcm1p
bmcgaXQuIElmIGEgdXNlciBhdHRlbXB0cyB0byB3cml0ZSBidXMgdG8gcmVzZXQNCj4+Pj4gbWV0
aG9kIG9yIHRyaWdnZXJzIGEgcmVzZXQgdGhhdCBmYWxscyBiYWNrIHRvIFNCUiwgdGhlIG9wZXJh
dGlvbiBmYWlscw0KPj4+PiB3aXRoOiAiYmFzaDogZWNobzogd3JpdGUgZXJyb3I6IEluYXBwcm9w
cmlhdGUgaW9jdGwgZm9yIGRldmljZSIgZXJyb3IuDQo+Pj4+DQo+Pj4+IFRoaXMgcGF0Y2ggbW9k
aWZpZXMgcGNpX3Jlc2V0X2J1c19mdW5jdGlvbigpIHRvIHJldHVybiAtRU5PVFRZIGltbWVkaWF0
ZWx5DQo+Pj4+IGlmIGN4bF9zYnJfbWFza2VkKCkgaXMgdHJ1ZSwgcmVnYXJkbGVzcyBvZiB0aGUg
cHJvYmUgYXJndW1lbnQuIFRoaXMNCj4+Pj4gZW5zdXJlcyB0aGF0ICdidXMnIGlzIG5vdCBhZHZl
cnRpc2VkIGluIHJlc2V0X21ldGhvZHMgd2hlbiB0aGUgaGFyZHdhcmUNCj4+Pj4gcHJldmVudHMg
aXQsIGltcHJvdmluZyBjbGFyaXR5IGZvciB1c2VycyBhbmQgYWxpZ25pbmcgdGhlIHN5c2ZzIGNh
cGFiaWxpdHkNCj4+Pj4gcmVwb3J0IHdpdGggYWN0dWFsIGhhcmR3YXJlIGJlaGF2aW9yLg0KPj4+
Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBWaWR5YSBTYWdhciA8dmlkeWFzQG52aWRpYS5jb20+DQo+
Pj4+IC0tLQ0KPj4+PiAgZHJpdmVycy9wY2kvcGNpLmMgfCA2ICstLS0tLQ0KPj4+PiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA1IGRlbGV0aW9ucygtKQ0KPj4+Pg0KPj4+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9wY2kvcGNpLmMgYi9kcml2ZXJzL3BjaS9wY2kuYw0KPj4+PiBpbmRl
eCBmMzI0NDYzMGJmZDAuLjU3ZTI0MzAwZDFjNyAxMDA2NDQNCj4+Pj4gLS0tIGEvZHJpdmVycy9w
Y2kvcGNpLmMNCj4+Pj4gKysrIGIvZHJpdmVycy9wY2kvcGNpLmMNCj4+Pj4gQEAgLTQ5MTUsMTIg
KzQ5MTUsOCBAQCBzdGF0aWMgaW50IHBjaV9yZXNldF9idXNfZnVuY3Rpb24oc3RydWN0IHBjaV9k
ZXYgKmRldiwgYm9vbCBwcm9iZSkNCj4+Pj4gICAgICAgICogSWYgImRldiIgaXMgYmVsb3cgYSBD
WEwgcG9ydCB0aGF0IGhhcyBTQlIgY29udHJvbCBtYXNrZWQsIFNCUg0KPj4+PiAgICAgICAgKiB3
b24ndCBkbyBhbnl0aGluZywgc28gcmV0dXJuIGVycm9yLg0KPj4+PiAgICAgICAgKi8NCj4+Pj4g
LSAgICAgaWYgKGJyaWRnZSAmJiBjeGxfc2JyX21hc2tlZChicmlkZ2UpKSB7DQo+Pj4+IC0gICAg
ICAgICAgICAgaWYgKHByb2JlKQ0KPj4+PiAtICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIDA7
DQo+Pj4+IC0NCj4+Pj4gKyAgICAgaWYgKGJyaWRnZSAmJiBjeGxfc2JyX21hc2tlZChicmlkZ2Up
KQ0KPj4+PiAgICAgICAgICAgICAgIHJldHVybiAtRU5PVFRZOw0KPj4+PiAtICAgICB9DQo+Pj4+
DQo+Pj4+ICAgICAgIHJjID0gcGNpX2Rldl9yZXNldF9pb21tdV9wcmVwYXJlKGRldik7DQo+Pj4+
ICAgICAgIGlmIChyYykgew0KPj4NCj4+DQo+IA0KDQo=
