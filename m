Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012059.outbound.protection.outlook.com [40.93.195.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393F4388E74;
	Wed, 29 Jul 2026 15:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785339917; cv=fail; b=nUu8yD4LGSS1aXAl8Vybb7Du+CXL+JqWIzRhLCZlmSOjHm9CVEZ2vKVlXLJ8aKoPIsz6+iUz63NBzfJcrktwH4t/3omGaP27DJ2TRJE3qpjnBgtVvcFR/w/Fgwv4T5rA2RGZ/HRhroJZmrXiseWHA5mIJUuzQLDmxE2+7vstoYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785339917; c=relaxed/simple;
	bh=aO71anehnspymeUC1KuzImfPCZQTrrHptGxSltj+zcA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=El1UI9C1ETRjCKjVjWzowdNwic6zQu8uMASKjCHtLMnTpzjHXX393L/17Xx8C4BasTmTQsyfPEW56ljg9iya6lOKvKz429k91IIYY2KCH2OErJxPqwz9ceMlJC82hZrN90yWeb+eXM0BQ03YJxuw46vn7cY5gl0PSIOoCjpzQx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1HTKURZj; arc=fail smtp.client-ip=40.93.195.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1HTKURZj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iVudwZB0Zcl5njBCVIalL6TJK6xcc4OyZA+4wRYgv8aBBIRgXktGvSHuZpC6OTUEJrpzH7lmAa57u+GzyeXKYIEgbdPZ2CjSw9BijnvKctq/7j530zmI5vKH1Gwc23ONXJLYngBPpIIXRb9QCllNk5d+z0Sas+9EL2T9MdUOgr9TLjpgx3Pi60AK8zY+Wr8/fAMqIYS7ueNXN0MyqG8+ehXYwUiXJljF65m0UINdPjvQ0m0eTWzrYkWPK8hPk8Eo3q/v1XPjN5tUns+O4zPKaSKlFbRUd9igr55KdxM/M50fa+Aoci9QAPFG5fFrkQYIvZzME0HmPh7tK8ijHkSsIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aO71anehnspymeUC1KuzImfPCZQTrrHptGxSltj+zcA=;
 b=V5bRhhie/89S73+vtnLZLzQJku3yDnmy9VudDnlGXn0kByfqTBf/sWWtUwaet/NDgfYTeIFoJTHfgMMytNekeE9ih3LJ5g6sTCc/qDcxn7crZTQE483HGnpl4AzkX2+8FPVVXDe+Sh50c2AiArWZQguq2yik2CfQUmYGMFIhA4r7rHrt4kMnGy0impC6KViieC3nlRP/uvdJjnBx27GZrbCKyAa8lf6TeJx9j+jKcasaaJWVwgf1ynYX8wo/f3e+ppUQbba5PpLjIPCwpDiBJLcEE2jV8jZ0MFJCJaCiO6ujilb23ErRUbz8rl8t/c9KcGYMBbUHs7pXIYLq6E9HOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aO71anehnspymeUC1KuzImfPCZQTrrHptGxSltj+zcA=;
 b=1HTKURZjS2kzhLMUmKjthbKhOjIxKY7NYPGggre9sraZdFxjfXQFt4nCu0WaCvMSNyiolHEtzLH0rrc7fgmbJMIp2Bv5Wqf07hn6TQ4USdWfIkpITRITHvu4eBmScT6h4W+mKEBkBi41AB1FEUdyED7AriEnwXIavdt0KtG6XaU=
Received: from IA4PR12MB9810.namprd12.prod.outlook.com (2603:10b6:208:551::13)
 by DM3PR12MB9285.namprd12.prod.outlook.com (2603:10b6:0:49::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.12; Wed, 29 Jul 2026 15:45:05 +0000
Received: from IA4PR12MB9810.namprd12.prod.outlook.com
 ([fe80::2d21:ba94:fd95:5b0f]) by IA4PR12MB9810.namprd12.prod.outlook.com
 ([fe80::2d21:ba94:fd95:5b0f%4]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 15:45:05 +0000
From: "Musham, Sai Krishna" <sai.krishna.musham@amd.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "robh@kernel.org" <robh@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] dt-bindings: pci: Add CPM6 support to AMD MDB PCIe
 binding
Thread-Topic: [PATCH v2 1/2] dt-bindings: pci: Add CPM6 support to AMD MDB
 PCIe binding
Thread-Index: AQHdHs7F+BzMyBrQg0uVhd+MbYfh7LaDYT+AgAFAj7A=
Date: Wed, 29 Jul 2026 15:45:05 +0000
Message-ID:
 <IA4PR12MB9810115150350A1AB20C371BCDCA2@IA4PR12MB9810.namprd12.prod.outlook.com>
References: <20260728202044.1785986-1-sai.krishna.musham@amd.com>
 <20260728202044.1785986-2-sai.krishna.musham@amd.com>
 <20260728202655.B64101F000E9@smtp.kernel.org>
In-Reply-To: <20260728202655.B64101F000E9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-07-29T15:34:21.0000000Z;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD
 Public
 v26;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR12MB9810:EE_|DM3PR12MB9285:EE_
x-ms-office365-filtering-correlation-id: e3760102-540d-45fe-cf75-08deed885c5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|11063799006|56012099006|38070700021|10067099003|4143699003|3023799007|6133799003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 W1evWl3c+prkgWG2DWYRuUB2RDf4mTDdyfpZF1wK7OpIZEI4IfT04oXtQ+vxG/ZESFi1WzVZIVNXQx2Y8oPeZjqXWpCCKxJo3LE3XVZOA/NDLy61LhNpiVLt6v0AKrwwbn6AhwLMndNx/Un2zCWFhf5IMvgRVRpC95WlTkEpim118OEFwjgOCXOUgygwlhKm756da1E9K+Mu5XRm3VA03DTS5mNxiCfevCz5IkQm3kLXrv7g8ggoCv8i35Nkm4Opf+5Z9AnUuJZmf51r+6tsdsVeqngVt5DB2/ZW4eAYaolSQ0jFI4QhbNZ0yMfzYoaZA17PXivF+14VaPWfmLxaIpQe9MdqfOACakrieD6bQ04OSs976QK8mCq3hlXnIBF0OTXr8sKoJzfbuwuTeH0sM9lo2tXfedywJXe7ccG5rNnYfBvVF5EXwD4hDJanwUba+tat1QgBp0db0tXe0mQ1p/LcewoOtnN92L0gxGBUf3knzwL4Ay4iKZS0gmSwX0NryIGWVr7DJ3bD8pwIhoowJic2aFgErBaR3tB24sBp4oJX+WopIB3WO/r/LKGdIE52JCSrGiEv/ZEHlS9hCFW8rVTiDqKxQ8NEAzr2vEOmnjf7Cgt5qOvyJRYDwk7LzKKt98Y+J9R+PjVriRrhVhN5itFhV7t6oSjXR5XXSeuBOTk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR12MB9810.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(11063799006)(56012099006)(38070700021)(10067099003)(4143699003)(3023799007)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UitnYzVLandDY2hWbEsrM2Z4QjNxb0ZGQWpqVEJyTWhmQ3dkSVpQQ1hDUzg0?=
 =?utf-8?B?VE9majRGYzBMc2M3K05GMU1qNVl4V1ZIR2FxTUtvVVdWN2xOSCthV1EwNHFi?=
 =?utf-8?B?Q3grZXRiWTcwQitXbEk1L1o0QTlKRlIyMTMrMkZSVzRRdU9YMDdoVjlsRWpJ?=
 =?utf-8?B?Ry9BTFJoTm0zNE9jWVU1LzBrOE9SNDl2MEM5WWtUS0VDVFFpTTBxMHk0dVdH?=
 =?utf-8?B?SmYycGluMERzaGpNRVZVRHhDeXBLZk9VUStZUm1RTElTM1pLeVpzbThFbmlM?=
 =?utf-8?B?bHU3dnV0cWxjWWFCUTRvWUVVeXEwRk9YTEhsZVA0ei9XVXplell3TVpsWnRl?=
 =?utf-8?B?UERGUk5uQmZNVCtIZ0tGMlVELzN6bU5UT3V6Q1NiN1E0QlBWUE1ORmJWYlhN?=
 =?utf-8?B?ZEdPWW5pOUQrM21tZ01WdFRhdWhNM29EVUFUeEh0SlBTYi9NTTVzWktDbnNi?=
 =?utf-8?B?aml4andXVVAzQU5RR3dwRUU0N0wzRkk4QnM5SDNETDNGeXBPSHhJN0g2Z2F6?=
 =?utf-8?B?UWM1YlNtbVYvRFhkeEs3UWZZelQ3S1R1SnRmWFJoVGZqOGNKbVkvSFRobDU3?=
 =?utf-8?B?NVRhYW5yNmNHU21kS2V5T2ZwdVlrZTBPcnlmaHo4TVNsV3BvSXJOZm5hTzhJ?=
 =?utf-8?B?aHF3Yy8wV0FocGpBVUxlUW5sUWpiVDZObmJ1eURZQ3dPUGlmbDFuT2pXYmN1?=
 =?utf-8?B?eHZDS1QxbjFOL3N2YXA4bUFuUDhvZ3ZKdWI5SDJqVEh1VzEweWhWN1QrVmJl?=
 =?utf-8?B?M0NyN1NmWnVTV3AxZ0RSTCtLUnZpSnZoYmgwckNFZjBTaFB4U3FHWjJBTjdH?=
 =?utf-8?B?QkErNHU3VkNpYUc3NDI2ZUthUElUQ2VJek54UFNqTlNwWkxOQ21ZV3lmRy9I?=
 =?utf-8?B?ci9OUktZUXZmbTVLNEhCRDl0QXV4ZkRTOWx1YXRidnNqbisxZTEvTUc0Zy8r?=
 =?utf-8?B?QjRaV1hkSFg4Yk1iYVZOcHJZSVprcklwbXVBWDkzZmozanF0VitIVXpudnFl?=
 =?utf-8?B?R3BFTVJvbjhrY0ZyVSswUmY1LzR4QTM1c0N4RnNrY0d6M25MTU51eURtbllI?=
 =?utf-8?B?emJuMStzSlV5b0llRjd2NWhQQmdoUEJqSWE5TFJtV25WeEw5aCtEUER4THJ1?=
 =?utf-8?B?eEVLL3RGK25XOXhhZ1k4RmFaank1V0M2WFVaZ1lrTHltNm1naVNBd25qazNU?=
 =?utf-8?B?SUt6UnFWY2Q5a2JQSEtucXMxbVU0dEdoZWc3RFNmenpOU2FDQ3RTUDhPWHFy?=
 =?utf-8?B?ZkZQWUhIN1g1QnA2RUZSb1F1SFVQM1BZdEJtOHUyWnd6Qjd6RnNpS1F4a0ZV?=
 =?utf-8?B?aTJxQnhvL2R0MGdzTmhVQ0ZFU1k0U2E1VTNlajZQTXFrNUNFQWl4ZTZoMlFu?=
 =?utf-8?B?STd2YTFyOGZYUnZRemFjMXpoSEIrK280eG5IaVRqdFVFNkdBLzk2c1NSZXUx?=
 =?utf-8?B?cGZEOWhpalpCbFludVJCbit4OFU4aXA0Mm9xdno2QUE3OVFoYSs2ZHdQQUdx?=
 =?utf-8?B?eWluNnFjOFE1b1R6azdYeE1xNGJ5VFVSRi9DRGtoUnZmTVcvRUhYbnpsU3hY?=
 =?utf-8?B?V29hTElhNzFGT3kxNUx5QU1JTXBxSEVYcXcyZ3YwTTAweUlNZzlKTWZxSTNH?=
 =?utf-8?B?d1E2SVJ0MldYVkxTeUptcTBRTzVQR2Z0NG91TllGV0pMaE5jMS9WODludVh1?=
 =?utf-8?B?SlIwUGM0VXdoT3huR093RitJY1paRjc4aGNDS1ZCMXVpUFZibXYrS1Zxd1Q1?=
 =?utf-8?B?RFJ6Nm0xNENja1FLQXl0SzdKUys4S2NNZmhReGs3SmhWUGRSdHRHcklGcFpj?=
 =?utf-8?B?OXFKWVlLemo3aG50K0k1WnFwa0hCWkQ4cGNremRFeWhYZkxBbisxQUNDQlF0?=
 =?utf-8?B?WVZ6UWE3NzM4aGZudSsvMDloNDVUTUQ0K3FFOVFISjN0RlBxdngzNEc1eVhN?=
 =?utf-8?B?RkZxVVVwN21ZT3NCcHlMUW9TVzJCTVhnY2tZaHJiam1QTlp0ZzNlZzMyMkZY?=
 =?utf-8?B?Wit5N3BRUkVyR0NGem5hNUtzamxQamxUU2Vka1AvNVBtTUdSQk8zMVpNcGdW?=
 =?utf-8?B?MUNVWTJNaVhKM1hVNW5OZDZtY2JxUnVMdEhDZlVSem1Dc0RQSnZ5S1lVUjBX?=
 =?utf-8?B?Y29xdHBXVks2VGp3NHRKOGlySWp6UEk0YUdIUk41YTVwYnJUaHRrSUVGNUxh?=
 =?utf-8?B?RDhSWHdQeThEektjS29CNU04cmZEODVkcVQ5VVRQd2VFOUZSZkgwSmdLekpI?=
 =?utf-8?B?UXFPUjRQMmRBbklBam8xbkx0dGxhcjRtQSs4c2dzTGZiek1OOERMRkh3dHFG?=
 =?utf-8?Q?neVCfYBdK/W67I7rnK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB9810.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3760102-540d-45fe-cf75-08deed885c5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 15:45:05.3941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sdyQFzM48FKM4MdMPDW8CpoMwhp5MkTV4sW2T1+iejPCaddSI1yO2us1An97j9GiS6Wzp0SMr0bE4/u8nfyyLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9285

UHVibGljDQoNCkhpIFNhc2hpa28sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
RnJvbTogc2FzaGlrby1ib3RAa2VybmVsLm9yZyA8c2FzaGlrby1ib3RAa2VybmVsLm9yZz4NCj4g
U2VudDogV2VkbmVzZGF5LCBKdWx5IDI5LCAyMDI2IDE6NTcgQU0NCj4gVG86IE11c2hhbSwgU2Fp
IEtyaXNobmEgPHNhaS5rcmlzaG5hLm11c2hhbUBhbWQuY29tPg0KPiBDYzogcm9iaEBrZXJuZWwu
b3JnOyBjb25vcitkdEBrZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4g
bGludXgtcGNpQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvMl0g
ZHQtYmluZGluZ3M6IHBjaTogQWRkIENQTTYgc3VwcG9ydCB0byBBTUQgTURCDQo+IFBDSWUgYmlu
ZGluZw0KPg0KPiBUaGFuayB5b3UgZm9yIHlvdXIgY29udHJpYnV0aW9uISBTYXNoaWtvIEFJIHJl
dmlldyBmb3VuZCAxIHBvdGVudGlhbCBpc3N1ZShzKQ0KPiB0byBjb25zaWRlcjoNCj4gLSBbTWVk
aXVtXSBUaGUgY29uZGl0aW9uYWwgYmxvY2tzIGZvciAnYW1kLHZlcnNhbDItbWRiLWhvc3QnIGFu
ZA0KPiAnYW1kLHZlcnNhbDItY3BtNi1ob3N0JyBmYWlsIHRvIGVuZm9yY2UgdGhlIHN0cmljdCBu
dW1iZXIgb2YgcmVnaXN0ZXIgcmVnaW9ucywNCj4gYWxsb3dpbmcgaW5jb21wbGV0ZSBvciBpbnZh
bGlkIGRldmljZSB0cmVlcyB0byBzaWxlbnRseSBwYXNzIHNjaGVtYSB2YWxpZGF0aW9uLg0KPiAt
LQ0KPg0KPiAtLS0gUGF0Y2ggWzFdOiBbUEFUQ0ggdjIgMS8yXSBkdC1iaW5kaW5nczogcGNpOiBB
ZGQgQ1BNNiBzdXBwb3J0IHRvIEFNRCBNREINCj4gUENJZSBiaW5kaW5nIC0tLQ0KPiBjb21taXQg
YjZkNzFhMDhjZjQxMDFiOTRmNGVjOTE0ZmU4NmQxOGM1Y2QyYjdmYQ0KPiBBdXRob3I6IFNhaSBL
cmlzaG5hIE11c2hhbSA8c2FpLmtyaXNobmEubXVzaGFtQGFtZC5jb20+DQo+DQo+IGR0LWJpbmRp
bmdzOiBwY2k6IEFkZCBDUE02IHN1cHBvcnQgdG8gQU1EIE1EQiBQQ0llIGJpbmRpbmcNCj4NCj4g
VGhlIEFNRCBDUE02IFBDSWUgY29udHJvbGxlciBpcyBiYXNlZCBvbiB0aGUgU3lub3BzeXMgRGVz
aWduV2FyZSBQQ0llIElQLg0KPiBUaGlzIGFkZHMgImludHIiIHRvIHRoZSB2ZW5kb3Itc3BlY2lm
aWMgcmVnLW5hbWVzIGZvciB0aGUgcGVyLWNvbnRyb2xsZXINCj4gaW50ZXJydXB0IHJlZ2lzdGVy
IHJlZ2lvbiBhbmQgdXBkYXRlcyB0aGUgYW1kLHZlcnNhbDItbWRiLWhvc3QueWFtbCB3aXRoDQo+
IHNlcGFyYXRlIHJlZ2lzdGVyIGRlZmluaXRpb25zIGZvciBNREI1IGFuZCBDUE02Lg0KPg0KPiBM
aW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNjA0MDIxODAwMDYuNDg2MjI5LTIt
DQo+IHNhaS5rcmlzaG5hLm11c2hhbUBhbWQuY29tLw0KPg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2FtZCx2ZXJzYWwyLW1kYi0NCj4gaG9z
dC55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9hbWQsdmVyc2Fs
Mi1tZGItDQo+IGhvc3QueWFtbA0KPiA+IGluZGV4IDQwNmMxNWUxZGVlMWIuLmQyMmRlMjRiNDFj
YWUgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bj
aS9hbWQsdmVyc2FsMi1tZGItaG9zdC55YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3BjaS9hbWQsdmVyc2FsMi1tZGItaG9zdC55YW1sDQo+IFsgLi4uIF0N
Cj4gPiArICAtIGlmOg0KPiA+ICsgICAgICBwcm9wZXJ0aWVzOg0KPiA+ICsgICAgICAgIGNvbXBh
dGlibGU6DQo+ID4gKyAgICAgICAgICBjb250YWluczoNCj4gPiArICAgICAgICAgICAgY29uc3Q6
IGFtZCx2ZXJzYWwyLW1kYi1ob3N0DQo+ID4gKyAgICB0aGVuOg0KPiA+ICsgICAgICBwcm9wZXJ0
aWVzOg0KPiA+ICsgICAgICAgIHJlZzoNCj4gPiArICAgICAgICAgIGl0ZW1zOg0KPiA+ICsgICAg
ICAgICAgICAtIGRlc2NyaXB0aW9uOiBNREIgU3lzdGVtIExldmVsIENvbnRyb2wgYW5kIFN0YXR1
cyBSZWdpc3RlciAoU0xDUikNCj4gQmFzZQ0KPiA+ICsgICAgICAgICAgICAtIGRlc2NyaXB0aW9u
OiBjb25maWd1cmF0aW9uIHJlZ2lvbg0KPiA+ICsgICAgICAgICAgICAtIGRlc2NyaXB0aW9uOiBk
YXRhIGJ1cyBpbnRlcmZhY2UNCj4gPiArICAgICAgICAgICAgLSBkZXNjcmlwdGlvbjogYWRkcmVz
cyB0cmFuc2xhdGlvbiB1bml0IHJlZ2lzdGVyDQo+ID4gKyAgICAgICAgcmVnLW5hbWVzOg0KPiA+
ICsgICAgICAgICAgaXRlbXM6DQo+ID4gKyAgICAgICAgICAgIC0gY29uc3Q6IHNsY3INCj4gPiAr
ICAgICAgICAgICAgLSBjb25zdDogY29uZmlnDQo+ID4gKyAgICAgICAgICAgIC0gY29uc3Q6IGRi
aQ0KPiA+ICsgICAgICAgICAgICAtIGNvbnN0OiBhdHUNCj4NCj4gW1NldmVyaXR5OiBNZWRpdW1d
DQo+IFNpbmNlIHRoZSBnbG9iYWwgbWF4SXRlbXMgZm9yIHJlZyBhbmQgcmVnLW5hbWVzIGlzIGlu
Y3JlYXNlZCB0byA1IGluIHRoaXMNCj4gcGF0Y2gsIGRvZXMgdGhpcyBjb25kaXRpb25hbCBibG9j
ayBmb3IgYW1kLHZlcnNhbDItbWRiLWhvc3QgbmVlZCB0byBleHBsaWNpdGx5DQo+IHNwZWNpZnkg
bWF4SXRlbXM6IDQ/DQo+DQoNClRoYW5rcyBmb3IgdGhlIHJldmlldywgeWVzLCBtYXhJdGVtcyBm
b3IgTURCNSBpcyA0LCBJIHdpbGwgZml4IGl0IGFuZCBzZW5kDQppbiBuZXh0IHBhdGNoLg0KDQo+
IFdpdGhvdXQgaXQsIGNvdWxkIGEgZGV2aWNlIHRyZWUgd2l0aCBhbiBpbnZhbGlkIDV0aCByZWdp
b24gc2lsZW50bHkgcGFzcw0KPiBzY2hlbWEgdmFsaWRhdGlvbiBmb3IgTURCNT8NCj4NCj4gPiAr
ICAtIGlmOg0KPiA+ICsgICAgICBwcm9wZXJ0aWVzOg0KPiA+ICsgICAgICAgIGNvbXBhdGlibGU6
DQo+ID4gKyAgICAgICAgICBjb250YWluczoNCj4gPiArICAgICAgICAgICAgZW51bToNCj4gPiAr
ICAgICAgICAgICAgICAtIGFtZCx2ZXJzYWwyLWNwbTYtaG9zdA0KPiA+ICsgICAgICAgICAgICAg
IC0gYW1kLHZlcnNhbDItY3BtNi1ob3N0MQ0KPiA+ICsgICAgdGhlbjoNCj4gPiArICAgICAgcHJv
cGVydGllczoNCj4gPiArICAgICAgICByZWc6DQo+ID4gKyAgICAgICAgICBtaW5JdGVtczogNA0K
PiA+ICsgICAgICAgICAgaXRlbXM6DQo+ID4gKyAgICAgICAgICAgIC0gZGVzY3JpcHRpb246IE1E
QiBTeXN0ZW0gTGV2ZWwgQ29udHJvbCBhbmQgU3RhdHVzIFJlZ2lzdGVyIChTTENSKQ0KPiBCYXNl
DQo+ID4gKyAgICAgICAgICAgIC0gZGVzY3JpcHRpb246IGNvbmZpZ3VyYXRpb24gcmVnaW9uDQo+
ID4gKyAgICAgICAgICAgIC0gZGVzY3JpcHRpb246IGRhdGEgYnVzIGludGVyZmFjZQ0KPiA+ICsg
ICAgICAgICAgICAtIGRlc2NyaXB0aW9uOiBhZGRyZXNzIHRyYW5zbGF0aW9uIHVuaXQgcmVnaXN0
ZXINCj4gPiArICAgICAgICAgICAgLSBkZXNjcmlwdGlvbjogQ1BNNiBQQ0llIGVycm9yIGFuZCBl
dmVudCBpbnRlcnJ1cHQgcmVnaXN0ZXJzDQo+ID4gKyAgICAgICAgcmVnLW5hbWVzOg0KPiA+ICsg
ICAgICAgICAgbWluSXRlbXM6IDQNCj4gPiArICAgICAgICAgIGl0ZW1zOg0KPiA+ICsgICAgICAg
ICAgICAtIGNvbnN0OiBzbGNyDQo+ID4gKyAgICAgICAgICAgIC0gY29uc3Q6IGNvbmZpZw0KPiA+
ICsgICAgICAgICAgICAtIGNvbnN0OiBkYmkNCj4gPiArICAgICAgICAgICAgLSBjb25zdDogYXR1
DQo+ID4gKyAgICAgICAgICAgIC0gY29uc3Q6IGludHINCj4NCj4gW1NldmVyaXR5OiBNZWRpdW1d
DQo+IERvZXMgc2V0dGluZyBtaW5JdGVtczogNCBoZXJlIGluYWR2ZXJ0ZW50bHkgbWFrZSB0aGUg
NXRoIENQTTYtc3BlY2lmaWMNCj4gcmVnaW9uDQo+IChpbnRyKSBvcHRpb25hbD8NCj4NCj4gSWYg
Q1BNNiBhbHdheXMgcmVxdWlyZXMgYWxsIDUgcmVnaW9ucywgc2hvdWxkIG1pbkl0ZW1zOiA0IGJl
IHJlbW92ZWQgc28gdGhhdA0KPiB2YWxpZGF0aW9uIGVuZm9yY2VzIHRoZSBmdWxsIGFycmF5IGxl
bmd0aD8NCj4NCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3LCBNREI1IHJlcXVpcmVzIDQgbWF4SXRl
bXMgYW5kIENQTTYgcmVxdWlyZXMgNSBtYXhJdGVtcywNCkkgd2lsbCBmaXggaXQgYW5kIHNlbmQg
aW4gbmV4dCBwYXRjaC4NCg0KPiAtLQ0KPiBTYXNoaWtvIEFJIHJldmlldyDCtyBodHRwczovL3Nh
c2hpa28uZGV2LyMvcGF0Y2hzZXQvMjAyNjA3MjgyMDIwNDQuMTc4NTk4Ni0NCj4gMS1zYWkua3Jp
c2huYS5tdXNoYW1AYW1kLmNvbT9wYXJ0PTENCg==
