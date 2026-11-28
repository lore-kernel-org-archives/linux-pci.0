Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795867817;
	b=k7cCrr2JUBosyrChwR/3nVr/JH5svZvtkiT2x7pbMnEsP26Jxik7jx7VdkXN2aQNJof9
	 1fCVe/V2dQhAWuES5/d0pQCzu4fgl5Gh/rbDGsOidKLNLbF17bCmWaoYz0w/Ql9y5Ii/9
	 0PQll08BVECTZhQ85HW7/GputndnYDTBBetohLZ0MW/RkjhZ8kEUF45v0WVyjBEN+m76g
	 eqp7YMRpfBdQBfK1JoarSPDm5oDqQzVF5RVCUNOBjRKHY++lE/a+PDK3XQBS+zRm92ZGG
	 KZgEWXe0N/PWnUoU4QvmhDiVwUTfW2ZR3aTztO1hdsvyh+EV2vfK8o1XigRJ9LqPWtw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795867817;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-CrossTenant-rms-persistedconsumerorg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=a7TtoXAGrLGvZNFiUnlI2pdg5OXyBDuwUTrMYlPtVyg=;
	b=sYVos9GmPMfb61eg7A21EViU4zKhnRDze+hkzFRO+AvLPaTSDZKZm58B/PDWMbHRUU9G
	 vYmp/2JZ7Vg2cSmDVf10qQW/tBXaX8rw2STrP/Qcki3uRBEmO/yYW0nI4ZQJ1fwQhJKEX
	 cGXxWW0qh1+cce/Av/u9PWVChIOzghmiAyEqt47tOedrJPw+nVOFa2V30va0QPlyQZIwc
	 Kj9/NZLSR+8C9WSSJScybnuVFKrH0m0cFtZTsTp5ELUNrUVCWrQ1lXP1gkkigL01jQQAi
	 BhHbgCSSFjnB9Zaef4bU1o6Bhw5nJFGfRwjZu+eowN457q57EyTkqMVfhexIwrmkvjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=pFe3HPM1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.25
Received: from WA1P291CU003.outbound.protection.outlook.com (mail-polandcentralazolkn19011025.outbound.protection.outlook.com [52.103.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D9D606A335;
	Sat, 28 Nov 2026 12:10:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53D9D606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=pFe3HPM1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQI8qJPxW3nl2V4JQ2eDafyGltqsejNaok3tUpVNlLSCZIaBbiYZLPtGyeDT2hq9Gq6UGo/pff5u7Vy3t0ACble2X6nxlxgMg8G4OmP+6r3o1A5kAGuD0I55bu0exYLz4eg2sBEXJ1H07cO5T4vC+IYQIPO467liu7dkBghIvOuQsDYEQ+SenqXo5nQSuBUdmQlVWti/aVdYEtBnoV8KUzkWWZcWbgYpCOu+yiiiPBhWWAts8SOreOUNlC3il/2ETjj/OjCaBpRiItmnWl+Q/7arIgkmDoY6vK13BPKv1xhxXVdBnyg/Wqhw6ELxmM1Y95LsTIdcY7zdFo8Zv6by8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7TtoXAGrLGvZNFiUnlI2pdg5OXyBDuwUTrMYlPtVyg=;
 b=IOw0S9M0LjF1DovmPLbyEvYnLJJVE/jmeCFrpi1vY4l3GczFwHHgOQShesCCDMszK9IslZ9IvoJdfoOphiEE5MYPXQd0MW2LD82RPyb/ZF4JOvHbRrQwyzEdknan5M4aw50E6LSIOcmIfFI6mCb/W90jNttaCklSXeC2zScnxT/WlAUYTogAVwkfkZl3MUmLxt0N0Sxe6lDWZEUA/xJYk9nN+qxETD0CwCl3RFPsz3IcmHgXXkK4eFN8nO5OMpocdE3f6COk0jLB+nQTCgDXccJB9JUcO2osrKMHeEJdmzEdxdWKrlxoufOY75ooZGIUmiQHS9HlkbMFfedTmtbUPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7TtoXAGrLGvZNFiUnlI2pdg5OXyBDuwUTrMYlPtVyg=;
 b=pFe3HPM1WPpedEITiXfE2HGPYA+lOAR563IVF//wQyT7xooXOMOvzzQgYX77ftIZlfXqtg+iWnvHfcESlVO1TApwJqTMrUN7LpAHKhDUXpY3cpJ+sH+PENYiP79jMTiasuDnK0mrtENqrL6McSWcRC7ZxaN0az99LWkTBh7884H90ORPSHA7OqYASDnq7+5ZZENIwyOdS5ig0HTi3yWNQuyrQRm/be7yiUkoadnpLwpz6CO45I8XWYBAAmwDHdL2l1VIMheVa58X58ZWndKoitmK0enln94a1TtRttcQyOmk4xQndSNm9dulNM2h5iKtao8NBt4WBbC7nSETM1ZzCg==
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:26::11)
 by WA0P291MB0174.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.6; Sat, 28 Nov 2026 12:10:15 +0000
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404]) by WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404%6]) with mapi id 15.21.0662.007; Sat, 28 Nov 2026
 12:10:15 +0000
From: =?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?= <habilerenturker@hotmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>, Thomas
 Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?= <habilerenturker@hotmail.com>
Subject: [PATCH v5 3/4] PCI: Convert quirks.c to pci_power_t helpers
Thread-Topic: [PATCH v5 3/4] PCI: Convert quirks.c to pci_power_t helpers
Thread-Index: AQHdfzFsaWCMvEuuj0ae102HbKFteA==
Date: Sat, 28 Nov 2026 12:10:14 +0000
Message-ID: <20261128120858.8737-6-habilerenturker@hotmail.com>
References: <20261128120858.8737-3-habilerenturker@hotmail.com>
In-Reply-To: <20261128120858.8737-3-habilerenturker@hotmail.com>
Accept-Language: tr-TR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: WA2P291MB0187:EE_|WA0P291MB0174:EE_
x-ms-office365-filtering-correlation-id: 3715e5ad-32ee-4be9-a4df-08df4d488f7a
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|25010399006|16051099003|55001999006|8062599012|8060799015|38102599003|19110799012|31061999003|24021099003|41001999006|15080799012|40105399003|102099032|3412199025|440099028|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?c1ZJQlIyVVNIRE8xbjcyejhmVzRWY0NVVlBhYmlFdWdPNG55VytReU05TWx0?=
 =?utf-8?B?K1FiWjZJZDJJcWRxeWdobk14SUlDRUlBT3k4VzVySnNyd3NJVVpvTElvRytl?=
 =?utf-8?B?RkdIOWNZVWdmRGFra2tmemZTdEdVRXBOZHBFOHB4TVBlOWQ0czJod3lveXZn?=
 =?utf-8?B?MDBCbjB3cUFKNFdyZ3p5MFdtZEJIMkNCMGRwOTJkV2JFWXQwSkUzWElhdjAw?=
 =?utf-8?B?VWYxNTRZbFpmcmo5ZU15Y3pISjFDUmVvd2JFcGNyQzhET3lSempmU04vYkI2?=
 =?utf-8?B?WE1LY3JXY2o2N3ZFa3VQWXdnZW9pbitOVVVOZ0M2a004M1pPSmd0aWlURXJq?=
 =?utf-8?B?dnNRMjRHMDBZSUdEMUVUNVhSQXA1UVJjbThVbVlPQ0JpTHcvdlpsSXdId05z?=
 =?utf-8?B?YUhvemF6aUhKK3c2SHdYK1Z3bzZwWnFUZzVSemZGQzVOd1hrY3lnSjkwbmls?=
 =?utf-8?B?clVHMTB4Qk91blo1S082cVpzaGpUdVRxcmdZZlNyRmZyZ09QVjZmWTN3KzJV?=
 =?utf-8?B?RkRPUG1rTzlQckplNHNJV0UwUEE1MWxQazdBOFFKOGFUY3VBQXRtNlpmdDUw?=
 =?utf-8?B?YURpZ1Z6b3RRa0xJaWU0WVhKbHdZZTF2Ti9mVkphL3RmNlFFNG1aRGpLZWlz?=
 =?utf-8?B?bE1wUXVGNzdRV3F5SzFyVjZpWHdjZzBDOFFpWmN1dnpwL1I1WjNtK2diQXI2?=
 =?utf-8?B?emJ2ZFlmVnRTbzZ4RWxKWlovOSs2djlYWnpaMFpaM2l1SDE0aXdBdHA4aXhr?=
 =?utf-8?B?MzZpNks1Y2FLNE1ZbUV3M1p0RnRFRUt2K3VZcTVVV1BEcEFVSkp3TUtYd2VQ?=
 =?utf-8?B?ZDBwaXNrTFRjdVdvUUpoY0hmdjNGZDNkQjIvdnovanloRDdHZG52R1psTGZF?=
 =?utf-8?B?MklKUENUUnVwdGFEcGhUOXBRKzdYWXNyRDVkWkdXOHdBaXZ5SDA1alJRcHdV?=
 =?utf-8?B?MGQxa1dpQ0hFZWRWSFU2SXUyaVBlL2hKb1J5MXpQQUhiQVN3bjVWeGtZdURq?=
 =?utf-8?B?NkJVWFVzbGR6SXlGNURkN08xMlZ2UzJBNXgrZU5FcjNPQXJtVE5KUUdUTHEv?=
 =?utf-8?B?OTNwRkowQzlJdUx6UEgvN1Nrc3pIZUZEbldkcDI0ZGQxQi9qUDc1TnpnVnhC?=
 =?utf-8?B?YWRHa0hOUkZnM3pkRElFU0tpdTJ6ckU0TTBqR2xYQmZPM3JjY1BSeHN2WFdz?=
 =?utf-8?B?dzN5UnpOSFRUV1RIZTI3NjhTdUJLa0N2YzNqUXhKWE5ZQzZVSlR4NG45c2pz?=
 =?utf-8?B?UG85Vnd1OUlPNDNZaVByTFIycEEzWmZoSERBTUNjb1MyUS8zRS9JTUVhM245?=
 =?utf-8?B?UFV1Skczb0pVYzVSdzIrK2hDNXZBZCtHbVYwc2dHWnJsNFJTL3Mwc1cxdWlO?=
 =?utf-8?B?ZXplRjhtbzRMTzByem5YUVVnSlh3WFVIYllpUjVSMTB5N01mV0dIWG5RaHZo?=
 =?utf-8?B?eDRxMFZqTnl1TC9pcGJwNEp0ME02NXNLd0xnZnlnPT0=?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QzhxYlh1bVl2cHNKUk1LMEtuTlpCcDU4Vk0rTXFVOGNZK3FtYjFKdzI3Wmwz?=
 =?utf-8?B?bHFoYTdkVWRlc3VOYjRSM0trbVp1eGhzZjNiMWRKTXlmbGxncnVPQm1KNCtC?=
 =?utf-8?B?YTd5T3M4Z3MvbVBYUW54L0dZSXI0U3FFUTd4bjQrT0hvSHplNkYxTXNadFVo?=
 =?utf-8?B?bEhOd1RXUmFEQTVIYi9qYktRT2RYeFl5WTEwL2U0aDcxQm00QllVaWs3ZXRx?=
 =?utf-8?B?NnJRNHZQUjBMUzhCNG5hOFYvZ3V5dDFTTGViYjROUFNIanZwQUxoMlJOOVNT?=
 =?utf-8?B?L2J0MUxWdVYzUDZNemp6bmpCL09WdlkvVWZsbTh1RjhOMFZxLzVxWmF5RGVH?=
 =?utf-8?B?WDhjTHZKSGwxQUFqRG5XRWMvZ1VKeVUzNTBYSFNRZ3ZldjE3WDZqNEVISDF5?=
 =?utf-8?B?dXBWSkQ4WW5ickpiRmN6MWxSZ1R6aUVqZ1M3WkxnMXRtb3BTdHB1YjdXVjVh?=
 =?utf-8?B?QkRQRXh4eHJvQXc0a01POEZKbUd6Y093d2hoTkdLWnlEZk93ZzFNVytYdWk2?=
 =?utf-8?B?anFjb3BZaW9LZmIyMXdHbFlHMTAvRmI2NDdweDkvZ2V0YTlHQ3ZjanFJaE01?=
 =?utf-8?B?cmlIQ3FHazBFdE10dEw3aGczYmRVUVZzOWhObjQ0dFZxYTRLY0dtcTR4UGcz?=
 =?utf-8?B?WGQ4WklhQ05uMGJzeDBZd2w0anNBYWl0dEc3S3Y0ZUxQVm9qbUdoaUY5VDNB?=
 =?utf-8?B?S3JYWnJTZGprNldvVlJJbVNBOXFnTGpMeThhNmVxUWhqV05HUVRFMVlOZ0Vy?=
 =?utf-8?B?MzVoOFZiTkZIT2VwbjlvWHoreTVxQ24zL2lSQkhjU2ZWQmxxN0laTnVzZ2Ns?=
 =?utf-8?B?ZkRRQ05VZFV6SlcvQlJINVdhb08xeXVNUFN5SlhKMXhsQ3pQODlUdlBOMjIv?=
 =?utf-8?B?dFJReDJkVDZrMzltZjZWQ2dSYVlWUnNYOXNuVko0Mkt1MzVRN2txWHdFZElO?=
 =?utf-8?B?aVNlMG0vTmxpelFEQlV1N01zVUY0VmxrWllhUUkzQ0h1Z1hidWRUbDZNcnBi?=
 =?utf-8?B?VUlqTVpuWXJBUUZCRUR2TEUwOHdPQldKUjMvTmpoMWY5NEwweklzVGF2RnR3?=
 =?utf-8?B?K29aby9PeThLUVN6U1NLRWVGa0xWZXRrYTE5SlFTOVJzVnJ6emVvaGVobSsx?=
 =?utf-8?B?QXRzRFB4NlB3bEtrTDcvTFB6akt5Z0xKQTE4VFdzWmpXdDBnUjdKNmJlUGta?=
 =?utf-8?B?dzcyakZYaWNqMDJaZm5rN1EzVzB4dHBROGpjdFlNRGNWaW84aXNrQVdhTkNE?=
 =?utf-8?B?T1hQU0poRFRqVjl2b2VuRzduNE9VYWhaOW1MTVVOSUtDTHNCakg5ZnVja1FZ?=
 =?utf-8?B?cVB5TnFZekxQbldFU1lxanFpOUdUVjVjWXd2L2hqN3pjV1Izd0lra0F4ZDFM?=
 =?utf-8?B?bFpyYjl0NHpQbnA0QWMveU1WdWdYQ0gwOVE3MW1BU3d4QUVRVjdYTkU5N1Vo?=
 =?utf-8?B?T0xoSXJjV2RrWWNndktPRUNlcjRqZEc5NEE2dkIrNTlkNkFFZzR0eHVBTU80?=
 =?utf-8?B?OWFRMEVaK3BiUlp5cW0vQTFZZGVUdCtQTmoyd2kxbEhoWWhkRHR0OWo3TDUr?=
 =?utf-8?B?Wm91QXQzdCtDWXFJby9KOTR3bUw2Myt4UE1kblhYK05YZ1k0Qm5wRnk2d0FH?=
 =?utf-8?B?b0hER2s1S1NzTUszTkVwUGF6QTZza1JscWxHYVRoUEEybjVBUWpOMlFsanFW?=
 =?utf-8?B?Qm1KMzhYWXJDblNqa215Q2owMW1YY0pHeExCTDh6REFrQWgyb2JjN0J2WlJE?=
 =?utf-8?B?czRSM0lNOGM0UVpZdlpXOEFQZTdNb2VUdzhzWUdlUmxtcExHeklleUZnRC9w?=
 =?utf-8?B?ZkVxL2NkTEt2RjdNSGVrV0xWL3l6eWpkcjcrM2svN3dsYUM3TUhhbTRoUncz?=
 =?utf-8?Q?LbZ59V6tgefO3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <39176BB012F65546BBB71BE4061FE04E@POLP291.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-2112e.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 3715e5ad-32ee-4be9-a4df-08df4d488f7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2026 12:10:14.8833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA0P291MB0174

VXNlIHBjaV9wb3dlcl90IGhlbHBlciBmdW5jdGlvbnMgd2hlbiBhY2Nlc3NpbmcgUENJIHBvd2Vy
CnN0YXRlcyBpbiBQQ0kgcXVpcmtzLgoKUmVzb2x2ZWQgU3BhcnNlIHdhcm5pbmc6CgotIGRyaXZl
cnMvcGNpL3F1aXJrcy5jIDogd2FybmluZzogcmVzdHJpY3RlZCBwY2lfcG93ZXJfdAogIGRlZ3Jh
ZGVzIHRvIGludGVnZXIKClNpZ25lZC1vZmYtYnk6IEhhYmlsIEVyZW4gVMO8cmtlciA8aGFiaWxl
cmVudHVya2VyQGhvdG1haWwuY29tPgotLS0KIGRyaXZlcnMvcGNpL3F1aXJrcy5jIHwgMiArLQog
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9wY2kvcXVpcmtzLmMgYi9kcml2ZXJzL3BjaS9xdWlya3MuYwppbmRleCA3ZjFm
NDdlYTJlZTQuLjQ0MTdlZDY0MjJhOSAxMDA2NDQKLS0tIGEvZHJpdmVycy9wY2kvcXVpcmtzLmMK
KysrIGIvZHJpdmVycy9wY2kvcXVpcmtzLmMKQEAgLTI0ODcsNyArMjQ4Nyw3IEBAIHN0YXRpYyB2
b2lkIHF1aXJrX2UxMDBfaW50ZXJydXB0KHN0cnVjdCBwY2lfZGV2ICpkZXYpCiAJICovCiAJaWYg
KGRldi0+cG1fY2FwKSB7CiAJCXBjaV9yZWFkX2NvbmZpZ193b3JkKGRldiwgZGV2LT5wbV9jYXAg
KyBQQ0lfUE1fQ1RSTCwgJnBtY3NyKTsKLQkJaWYgKChwbWNzciAmIFBDSV9QTV9DVFJMX1NUQVRF
X01BU0spICE9IFBDSV9EMCkKKwkJaWYgKCFwY2lfcG93ZXJfdF9lcShwY2lfcG93ZXJfdF9nZXQo
cG1jc3IpLCBQQ0lfRDApKQogCQkJcmV0dXJuOwogCX0KIAotLSAKMi40Ny4zCgo=
