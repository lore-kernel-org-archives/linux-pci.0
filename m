Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010010.outbound.protection.outlook.com [52.101.56.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB092E975E;
	Tue,  1 Sep 2026 13:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269849; cv=fail; b=qaPnAKscd+6tB6CSEvOlGh3wmwxvz5i3WtlkwqqSYKNeJi0+FU4XPbNb5p7rh1vFsMBWuEi/ez57israqvzfycAI/2pjUc+qiOR+Mmxe6m543q11A7aoox//Ul9aFCmnX0Soqin4MO79knJBjBbfn8Y1WokLXQQA/WC91R/w0Qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269849; c=relaxed/simple;
	bh=JK/ku++1cN/kELZ9pABUqC8R6yaYXxH2CdSLrl/QK6Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XcU5KJ3ctRzbvE4lXBCLFiEw2+h33Qcrb4Dym8+jB4S6vVl0gPuJy1TA3fG40noz5JEZ/np8fgig0jEEBCI50O9JNSA0prb08secxpmO6c20Cn2QEaD6Cc0jwWLwZ/dpq/TM0CXa0NdmLv2SoEK9xHL8NNE/cOgTlFnxpaGTCCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qF1FE8e1; arc=fail smtp.client-ip=52.101.56.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qF1FE8e1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NpEjb6RNZQfWrk2zCP3Dias31UwF/RslG1ZxIERPJZfqS5B8UIWFjMwRInmtIl2At3bfrcN1ojRwxrO+iHVrGSreAaSseryjY+Hw6lHQlNvLptKqiTseefw1LEymmPU3M40zP+LOcO78KfkulqnjdkC311hqllGDR75v2zMUqNV2FrX9Ir4KUWkePpcvUYF/DO6R9VokLrIUxomkhKGAAgOjGScI6j0nYjSvojXKRDRqpm+x7pmm79Vit+sbTmYYsKOWVOfqkDOOahGtZNujIj/MrWzE2WRHDFHT7UAboAtYpUtZ3yfdEEbraqjKEXKiT5pAvGNw2GBEMckPUEaQIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JK/ku++1cN/kELZ9pABUqC8R6yaYXxH2CdSLrl/QK6Q=;
 b=VJ0E6+sIoi/vqTyxvpZGcxsD9MIyh1hD6s4SE/4FxsxoV3IieTv5a6iemJiAVv0uWVVqlfkdq8z/wkFdrIckcrYT37uZWnFtHbDOzRck5S7TlM+REfXgrCtgrFh84DvBInoQTdMdY7b1LLmbw8Xskr6MJWi2ywzeXP7qbE4YkoV6eoX0TNbVo7t1c+EfgqnXkb8HkM0hjAL8ELipcgYv8MXNU1lKWuxVeB0gl5lwF0aW6yNZWUYv1IdfJ3hQRjfNkwzeqRHGtur3N69ymLWoHRoZp6ne7YAHSROL1KmpsQb/KXAWysXHzhLBZBJEygihqF+8dG9JHPo9irLFWnWKMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JK/ku++1cN/kELZ9pABUqC8R6yaYXxH2CdSLrl/QK6Q=;
 b=qF1FE8e1YUeamoFZ/q2VGYS3JZy2KeGjYuFiIFqfnanCLMFqHXWR07VnSn5Vj2pFmjPOyl1lpY5A7ankfRQms5/KqvdMHNQvKq1LRbvrHoT8Wxhm8orDOZSAwLIqWHqvMBZaHpTwGADjCz9L0eStvcMO2PVDeOd+mJg3VKOGAzqFafH/MM2WhupbgYkb+SL2XQmzcxIYE0llr9L1NNM97zi5NJuNVdGOPhzmYocGmoeAbsgOKy8xILsXRItaU8YaTH1luf3hW1Fqwhe/W50gpoylkKdFCevDwJcbjTtQIUCV2Wvpdm4EQkjUGeaPcFCSWP/NeuYM6zry1YeZQCmfoA==
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 by SA5PPF9176ED2F1.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 13:37:17 +0000
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b]) by SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b%5]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 13:37:16 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "K V P, Satyanarayana" <satyanarayana.k.v.p@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>, "kbusch@meta.com"
	<kbusch@meta.com>, "michal.winiarski@intel.com" <michal.winiarski@intel.com>,
	Sonang Patel <sonangp@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt
 Ochs <mochs@nvidia.com>
Subject: RE: [RFC PATCH 02/19] vfio/pci: Serialize generic device lifetime
 with recovery
Thread-Topic: [RFC PATCH 02/19] vfio/pci: Serialize generic device lifetime
 with recovery
Thread-Index: AQHdOhPKp+3cWPRQe0ycPKkygd3Qd7a5uZuw
Date: Tue, 1 Sep 2026 13:37:16 +0000
Message-ID:
 <SJ0PR12MB8614B94DA25747E7493B592DABA82@SJ0PR12MB8614.namprd12.prod.outlook.com>
References: <20260901093217.8539-1-skolothumtho@nvidia.com>
 <20260901093217.8539-3-skolothumtho@nvidia.com>
 <562f64cd-1c85-45bc-99da-89e8ec168b11@intel.com>
In-Reply-To: <562f64cd-1c85-45bc-99da-89e8ec168b11@intel.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8614:EE_|SA5PPF9176ED2F1:EE_
x-ms-office365-filtering-correlation-id: 744f97e6-1c37-4d69-4653-08df082e2377
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|10067099003|38070700021|11063799006|56012099006|5023799004|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 JQ1OLUzqIq4pLXErytJSowHaSRQBoXEotB1QzBO9i55i1/Tds7ZTy5WtGFqDOVEZ2XZkn39HUWW5VXoX3rGo5O1mtb0fgnvcs6ieqKnKm4zmHO6vAJIXB7md2aDNabbHwfgY5dGm7KLyUp0/hTC4jtkikQMipzU1tV6HhjCPTu30Kvdg+HFZekmjzk4mkdo9u4cj7b/J1OhIdXHR+/aIXlMoP1xCayu0HMLf7T1r08NEShSVgWrsRexRMOYILjLcsf8z0PBTeHAFVYK8K/VUkkhkALQQwi2AU5EV0rpjJGmtzOgm6n/GDqYyKFY1qigrUt1wWsuUFHlB4+XtgJ4YDMv18/X7bGZTKsE4zFSc3g3Jg2uvGosBmeZzhL4p2b3XmhfqWQYi618V6sBcRZCPhlORfHMq8j0QktTsjvyoJxjwoi/8yS8fHJLZPUVZ+BtWyxOmmo6JJsEydHUNDQIThmTKWlfSWpWKqh3PwEcvL2BL67Nlsl3KSMUIx1hcz+zqDpJyaZ9dmEQgwapUy1c1q4V6MfUFAB5cVioaKXcH/a6ga6T/I3xnD0hcRyvJokADMfa+yS4yQumeho6otTV4xTspaDB+X7jRyeQ+1DxLYxqqfMj3MA4Sc33dJKgvcikc7rxqd5zlyoaTfrUXdJk2yLVh9dj1PBDKGJGWuoTNCCTApjxpnxIT+/TEDYCuCWAe2x0mVSjexK7AatmrdokRjBnMjvHtVMdyToz1c1Ao7KI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB8614.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(38070700021)(11063799006)(56012099006)(5023799004)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a0Q2bk5NRUVNNFVlRXEydDF1NEhyOExCTnN4TlEreVMzbkh5ZU15NHc5aXlB?=
 =?utf-8?B?MTh3R1ZkRXdpY2dISnJQVmJIK093NlFudTVQaVN4OUNGaUdTWXk1dUw2Sm1z?=
 =?utf-8?B?d3gzU3Jxc0ltcWxkUi8ySGtpRHVKUzhlVGNSOXlRQjVlVnpVTE5CVnZtRnpC?=
 =?utf-8?B?eFl3dmtGbU52dnFsa3hySnRZYXdmTTk0L0hoMUh6R2ZyK3M5b1AreDAwdm85?=
 =?utf-8?B?RFlxZW84NEdGZmhCWkUyb0hhbm8wVFNKdy8wcExtZVU1bXpDaGlpNUN2QzB5?=
 =?utf-8?B?YjZTb0ZZZ3U2VWJxRndQQVZmbVZRazJGbDZUV3hEVXBDcXVtdHlNdHQ3Vm16?=
 =?utf-8?B?Q1BhczBRenJ2a0tqRmdsSVorVFNwVHFGcHFXZjlMOC9CbTRqVm5DMFRHNnY3?=
 =?utf-8?B?ZEF3THVOaEVTd3gyMEtIcUE3NDFUTFo0RVBRVDlaTjlYZW5iNHcrVTZyTzBL?=
 =?utf-8?B?eUo4T0I3ZEZjNXhlK2JkcWZpdG4yUEpXa1F6aE5STHMrSEtJRFBVKzFRVEhz?=
 =?utf-8?B?Q2psWHRyQXIrZklscllzUklYM2x0OUVTMUl0NW1wcGhZWUlrYUJtakpXT05H?=
 =?utf-8?B?bnFSSURSR21LU3YrblZHcGtoK1J2QUlnR0RncFc5WXhsUVlJdDdlVisxT0Vw?=
 =?utf-8?B?SlFKdkkrKzZoOFF3enlLa0htSEFGQXhxNWhRZGVLQkJqZHVrRzlOK3FNRGpw?=
 =?utf-8?B?K1hNenBHVjYzM0dyY3NlaUdkdGJZQWVnYUJEODZnNVA4VmRWcWpLU0dsaFBS?=
 =?utf-8?B?Rk9zSXo0Q083aE8vU2Q4WDdsbU0vM3FDK1I3WGg5ZWdLeHk2M1U1R0JxOTZr?=
 =?utf-8?B?cUZKb3NhL05IREZhU29JZGR5WGtyeDd6N0NTc0J1WWwra0tBUkxON1VwOG9t?=
 =?utf-8?B?WjZweTI1ajVMV2J2Yk1IdStEbzdCOU10d2tQZ2VuUDRKSXNmaTNydTFXL0FI?=
 =?utf-8?B?VGVKSFY0a2h4R0trYmNUNHBkVkpTVXZxcXM5aTY2RVVUL1d3eGg5amd5d3Va?=
 =?utf-8?B?OEVid0hDL2NqK3E4ZXhOTmpRYzFFQWtPa1B6VDY5ZGNWTjFYQmFka0JDRjky?=
 =?utf-8?B?V3J4bVNtMklHUlJsZ0dWYVZMeng1Sis4elh3S2xGeGdMWHN4MkRIRWU3aDdo?=
 =?utf-8?B?WW83VGhFc2I2YTNqb1M1TTFyTDJaMUNFVXliNUpIdU10VGJVcHFYdmdrV1Nj?=
 =?utf-8?B?M2I0TmdhZDNsNHA5ZERBbmJZeFdxYjZuUHluRUQ5RHJiUTV6TWVBUElnMk5q?=
 =?utf-8?B?TkVNcnc3ZzhQekxkcGhra2tFWGwxV2NMcys3OTB5QnNKSlFZYTNMRVhGRlhX?=
 =?utf-8?B?N3FwSXhRRnhWWGF0aklwRjRMMGdxSHpZNE92aE9SU0tyY2dWeG9HWDNxQ1lS?=
 =?utf-8?B?VU9NLzNYZ3pLbzVxNDh4a0RFT25DbzM2aHZmcjEwQkRZcmZPbkN0cndnZVlF?=
 =?utf-8?B?WGN5NHdiQ0xlZHRpcVdTVjdoZ0lzaGVSVDJFZXcrN3dJUENJNjdxRVVuTlZ0?=
 =?utf-8?B?aEk3ZWRTN3dmaWdoeXhVdmNRejRrNFBtWkw1VkhKTStPWGQ2YVlBSlRDaEl6?=
 =?utf-8?B?WGtySXNESHNBWmdCWVN2aWU2b3o3RCtpb3IxK3hDc0VLSDVpbTJQczRVOXFk?=
 =?utf-8?B?YVl0aDlCS1JrUE1Ldlo1Q0JIbkVzY1ZJVWxjdzJYM3pBT2MyaFZvRS93S1JF?=
 =?utf-8?B?eUpZRlJBSW9oQXR2OE1RYXptYyt2aE5kUXd6ZEozREV5OTNTblpEcWJ5WkMr?=
 =?utf-8?B?T0l5djFITmZGMmN2KzVxTlV1ZXFSSHUxWkpDOE5VMEpnakxBMElndW1lbXJ0?=
 =?utf-8?B?N21Dc1dCckdOTDBpSEtUZjRCRE00cVNLVXViYnkzOWNuSFQ1d0lXakVIQk1E?=
 =?utf-8?B?SUdVSkUzT1lKbTZEeFFmeXhPQkdlOTF2bmNCNnlwNzJYSzF2eXpFRDVxQTIz?=
 =?utf-8?B?WkNJQSsya0l0bWlrUVVLNi9IY2lTZldTWDlVekE1WU1QSURWbllyNDE1dnhN?=
 =?utf-8?B?cG9RUjFYR1lMeWZ0amF6NkhlaFY3WVp5N2JPZkhwUkxiaGtudVlBcEdra2ta?=
 =?utf-8?B?bTlqNUo0RW02eGJCZlNqdWYzZC9lNEVvbG1oS2poS2t6ZnNneFkvb3VUWEQv?=
 =?utf-8?B?dzNpaEczOUs1eVVuN3ZWc0ZKMi8vSVRJVVVJcEdpMmVUMVB4cmpEWGc1K243?=
 =?utf-8?B?ZkpZWTVXaytzL2tyTlJ1bDdNMWhtcFMralR6UitPNE5xNUFGeXE1Ym1kUmRQ?=
 =?utf-8?B?VjhITGZIbGVXSlRqaU4rU1hpSE9lcm9JTFZhQmFTZG9HV1FBVmRxNW9UeG1m?=
 =?utf-8?B?ZzUwUG5RejVNL250dGpKb0xlMEMySUIwY3lCWXBxQlVLSnJaMFBUQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 744f97e6-1c37-4d69-4653-08df082e2377
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 13:37:16.6394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xLb9/jQe+racvXePR7A+qnEePM9aSt2DjqMIGH7p0fNlXnPuztWxJc0YKEbUNsM6epGB2fxXX3ZjKHWV6ZF1zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF9176ED2F1

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSyBWIFAsIFNhdHlhbmFy
YXlhbmEgPHNhdHlhbmFyYXlhbmEuay52LnBAaW50ZWwuY29tPg0KPiBTZW50OiAwMSBTZXB0ZW1i
ZXIgMjAyNiAxNDoxNA0KPiBUbzogU2hhbWVlciBLb2xvdGh1bSBUaG9kaSA8c2tvbG90aHVtdGhv
QG52aWRpYS5jb20+Ow0KPiBrdm1Admdlci5rZXJuZWwub3JnOyBsaW51eC1wY2lAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBhbGV4QHNoYXpib3Qu
b3JnOyBqZ2dAemllcGUuY2E7IGtldmluLnRpYW5AaW50ZWwuY29tOw0KPiBrYnVzY2hAbWV0YS5j
b207IG1pY2hhbC53aW5pYXJza2lAaW50ZWwuY29tOyBTb25hbmcgUGF0ZWwNCj4gPHNvbmFuZ3BA
bnZpZGlhLmNvbT47IE5hdGhhbiBDaGVuIDxuYXRoYW5jQG52aWRpYS5jb20+OyBNYXR0IE9jaHMN
Cj4gPG1vY2hzQG52aWRpYS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIDAyLzE5XSB2
ZmlvL3BjaTogU2VyaWFsaXplIGdlbmVyaWMgZGV2aWNlIGxpZmV0aW1lIHdpdGgNCj4gcmVjb3Zl
cnkNCj4gDQo+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0
dGFjaG1lbnRzDQo+IA0KPiANCj4gT24gMDEtU2VwLTI2IDM6MDIgUE0sIFNoYW1lZXIgS29sb3Ro
dW0gd3JvdGU6DQo+ID4gdmZpb19wY2lfY29yZV9kaXNhYmxlKCkgZnJlZXMgdmNvbmZpZyB3aGls
ZSBob2xkaW5nIG9ubHkgdGhlIHZmaW8NCj4gPiBkZXZpY2Vfc2V0IG11dGV4LiBUaGUgUENJIGVy
cm9yIGNhbGxiYWNrcyBuZXZlciB0YWtlIHRoYXQgb25lLiBUaGV5DQo+ID4gcnVuIHVuZGVyIHRo
ZSBQQ0kgZGV2aWNlX2xvY2sgaW5zdGVhZCwgYW5kIHZmaW8ncyBjbG9zZSBwYXRoIGRvZXMgbm90
DQo+ID4gaG9sZCB0aGF0LiBTbyBhIGNhbGxiYWNrIHN0aWxsIHJ1bm5pbmcgd2hlbiBjbG9zZSBz
dGFydHMgY2FuIHdhbGsgaW50bw0KPiA+IHN0YXRlIHdoaWNoIGlzIGJlaW5nIGZyZWVkLg0KPiA+
DQo+ID4gUHVibGlzaCBhIGRldmljZV9vcGVuIGZsYWcgdW5kZXIgcmVjb3ZlcnlfbG9jay4gZW5h
YmxlKCkgY2xlYXJzIGl0DQo+ID4gYmVmb3JlIGl0IHRvdWNoZXMgdGhlIGRldmljZSwgZmluaXNo
X2VuYWJsZSgpIHNldHMgaXQgb25jZQ0KPiA+IHZmaW9fY29uZmlnX2luaXQoKSBoYXMgYWxsb2Nh
dGVkIHZjb25maWcsIGFuZCBwcmVwYXJlX2Nsb3NlKCkgY2xlYXJzDQo+ID4gaXQgYWdhaW4gYmVm
b3JlIHRoZSB0ZWFyZG93biBmcmVlcyB2Y29uZmlnLiBBbGwgdGhyZWUgdGFrZQ0KPiA+IHJlY292
ZXJ5X2xvY2sgZm9yIHdyaXRpbmcsIHNvIGEgY2FsbGJhY2sgZWl0aGVyIGdldHMgdGhlcmUgZmly
c3QgYW5kDQo+ID4gY2xvc2Ugd2FpdHMgZm9yIGl0LCBvciBpdCBmaW5kcyB0aGUgZmxhZyBjbGVh
ciBhbmQgZG9lcyBub3RoaW5nLiBUaGUNCj4gPiBhY2Nlc3MgZ3VhcmRzIGFkZGVkIGxhdGVyIHRl
c3QgdGhlIHNhbWUgZmxhZy4NCj4gPg0KPiA+IHJlY292ZXJ5X2xvY2sgaXMgbm90IGhlbGQgYWNy
b3NzIHZmaW9fcGNpX2NvcmVfZGlzYWJsZSgpLiBBIGxhdGVyDQo+ID4gcGF0Y2ggaGFzIGVycm9y
X2RldGVjdGVkKCkgdGFrZSBpdCBmcm9tIHVuZGVyIHBjaV9idXNfc2VtLCBhbmQNCj4gPiBkaXNh
YmxlKCkgZ2V0cyB0byBwY2lfcmVzZXRfYnVzKCksIHdoaWNoIHRha2VzIHBjaV9idXNfc2VtIHRo
ZSBvdGhlciB3YXkNCj4gcm91bmQuDQo+ID4NCj4gPiBhY2Nlc3NfYmxvY2tlZCBpcyBvbmx5IGV2
ZXIgc2V0IHdoaWxlIGRldmljZV9vcGVuIGlzIHNldC4gTm90aGluZyBzZXRzDQo+ID4gaXQgd2l0
aG91dCB0ZXN0aW5nIGRldmljZV9vcGVuIGZpcnN0LCBhbmQgY2xvc2UgY2xlYXJzIGFjY2Vzc19i
bG9ja2VkDQo+ID4gYmVmb3JlIGl0IGNsZWFycyBkZXZpY2Vfb3Blbi4gSWYgY2xvc2UgbGVmdCBp
dCBzZXQsIG5vdGhpbmcgY291bGQNCj4gPiBjbGVhciBpdCBhZnRlcndhcmRzLg0KPiA+IFRoZSB0
cmFuc2FjdGlvbiB3aGljaCBzZXQgaXQgY2Fubm90IGNsZWFyIGl0IG9uY2UgZGV2aWNlX29wZW4g
aXMgZ29uZSwNCj4gPiBhbmQgZXZlcnkgcGF0aCB3aGljaCByZWZ1c2VzIHdvcmsgb24gYSBibG9j
a2VkIGRldmljZSB3b3VsZCBnbyBvbg0KPiA+IHJlZnVzaW5nLiBDbGVhciBpdCBiZWZvcmUgZGV2
aWNlX29wZW4gc28gYSBsb2NrLWZyZWUgcmVhZGVyIG5ldmVyIHNlZXMNCj4gPiBpdCBzZXQgb24g
YSBkZXZpY2Ugd2hpY2ggaXMgY2xvc2VkLg0KPiA+DQo+ID4gb3BlbigpIG5vdyByZWZ1c2VzIGEg
ZGlzY29ubmVjdGVkIGRldmljZSB3aXRoIC1FTk9ERVYuIFRoYXQgaXMgbmV3Lg0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogU2hhbWVlciBLb2xvdGh1bSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+
DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL3ZmaW8vcGNpL3ZmaW9fcGNpX2NvcmUuYyB8IDY5ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNjgg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdmZpby9wY2kvdmZpb19wY2lfY29yZS5jDQo+ID4gYi9kcml2ZXJzL3ZmaW8vcGNpL3ZmaW9f
cGNpX2NvcmUuYw0KPiA+IGluZGV4IGUwYmU1ZGRmNzAzOS4uOGRlNTg2ZTRiYjczIDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvdmZpby9wY2kvdmZpb19wY2lfY29yZS5jDQo+ID4gKysrIGIvZHJp
dmVycy92ZmlvL3BjaS92ZmlvX3BjaV9jb3JlLmMNCj4gPiBAQCAtNTkxLDEwICs1OTEsMjMgQEAg
c3RhdGljIGNvbnN0IHN0cnVjdCBkZXZfcG1fb3BzDQo+IHZmaW9fcGNpX2NvcmVfcG1fb3BzID0g
ew0KPiA+ICAgaW50IHZmaW9fcGNpX2NvcmVfZW5hYmxlKHN0cnVjdCB2ZmlvX3BjaV9jb3JlX2Rl
dmljZSAqdmRldikNCj4gPiAgIHsNCj4gPiAgICAgICBzdHJ1Y3QgcGNpX2RldiAqcGRldiA9IHZk
ZXYtPnBkZXY7DQo+ID4gKyAgICAgYm9vbCBzdXBwb3J0ZWQgPSB2ZGV2LT5wY2lfcmVjb3Zlcnlf
c3VwcG9ydGVkOw0KPiA+ICAgICAgIGludCByZXQ7DQo+ID4gICAgICAgdTE2IGNtZDsNCj4gPiAg
ICAgICB1OCBtc2l4X3BvczsNCj4gPg0KPiA+ICsgICAgIGlmIChzdXBwb3J0ZWQpIHsNCj4gPiAr
ICAgICAgICAgICAgIGRvd25fd3JpdGUoJnZkZXYtPnJlY292ZXJ5X2xvY2spOw0KPiA+ICsgICAg
ICAgICAgICAgaWYgKHBjaV9kZXZfaXNfZGlzY29ubmVjdGVkKHBkZXYpKSB7DQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgIHVwX3dyaXRlKCZ2ZGV2LT5yZWNvdmVyeV9sb2NrKTsNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9ERVY7DQo+ID4gKyAgICAgICAgICAgICB9DQo+
ID4gKw0KPiA+ICsgICAgICAgICAgICAgdmRldi0+cGNpX3JlY292ZXJ5X2NvbW1hbmRfdmFsaWQg
PSBmYWxzZTsNCj4gPiArICAgICAgICAgICAgIFdSSVRFX09OQ0UodmRldi0+cGNpX3JlY292ZXJ5
X2RldmljZV9vcGVuLCBmYWxzZSk7DQo+ID4gKyAgICAgICAgICAgICB1cF93cml0ZSgmdmRldi0+
cmVjb3ZlcnlfbG9jayk7DQo+ID4gKyAgICAgfQ0KPiA+ICsNCj4gDQo+IENhbiB3ZSB1c2Ugc2Nv
cGVkX2d1YXJkKCkvZ3VhcmQoKSBpbnN0ZWFkIG9mIGRvd25fd3JpdGUoKS91cF93cml0ZSgpPw0K
PiBUaGUgc2FtZSBjb21tZW50IGFwcGxpZXMgYWNyb3NzIGFsbCBzaW1pbGFyIHNlY3Rpb25zLg0K
DQpTdXJlLCB0aGFua3MuIEkgd2lsbCBjb252ZXJ0IHRoZXNlIGluIHRoZSBuZXh0IHJlc3BpbiB3
aGVyZXZlciBpdA0Kd29ya3Mgb3V0Lg0KDQpNb3N0IG9mIHRoZSBzZWN0aW9ucyB0YWtlIHRoZSBs
b2NrIGFuZCBkcm9wIGl0IGluIHRoZSBzYW1lIGJsb2NrLCBzbw0KdGhleSBjb252ZXJ0IGNsZWFu
bHkuIEEgZmV3IHdpbGwgbm90LCBJIGd1ZXNzLiBTb21lIG9mIHRoZSBjYWxsZXJzDQpkcm9wIHRo
ZSBsb2NrIHBhcnQgd2F5IHRocm91Z2ggb24gcHVycG9zZSwgc28gdGhhdCB0aGUgd29yayB3aGlj
aA0KZm9sbG93cyBydW5zIG91dHNpZGUgdGhlIGxvY2sgYW5kIGtlZXBzIHJlY292ZXJ5X2xvY2sg
YmVsb3cgcGNpX2J1c19zZW0uDQpJIHdpbGwgZG91YmxlIGNoZWNrIGlmIHRoZXJlIGlzIGEgd2F5
IHRvIGNvbnZlcnQgdGhvc2UgYXMgd2VsbC4NCg0KVGhhbmtzLA0KU2hhbWVlcg0K
