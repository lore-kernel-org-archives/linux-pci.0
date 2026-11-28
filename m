Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795867816;
	b=GuxnVBUP3TV71emjn6FIqRT3lUZV6f9pB72cz7lYeJ7+UanZTVi4WdnQQxbRHN2oiyau
	 fhTb+zYj1HHgsOdM9kQ51W1bZNSyCuVlRf1D5SSEDE4ogSA1l1MAxqCXIdz9ssrXlCy+Z
	 FwQW9cqr+qXspBCv1LtM7s2E7/V/Ht0Xnt/83LJ55iz6LXjULD09VIFT4pGtDVm1eDNzc
	 ZgwMFKj0jhCBixZSt7I764/X7UI7ggAes/fmYeB8XRdrWY9rDZSMwasL2WhhPoA1mFJwy
	 tRAoaKq5h5s4hID3xJNgP+RId6uuRjhKWvV2HE+lfSjqmhW5QfLhq4hEZ066lbUoaBw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795867816;
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
	bh=8wNfPlGF51r0Po3mQ4FGCNe4nFMLjgNkYSNbljH4BiY=;
	b=VUHRvIBgLVz4ZQByQG3WuSJ1h11Erb7G7kToPFwFIGGKcBLps1OwcQHaaPVsIKj4ape5
	 r1IbMCDk5pf1u8ewyur/NBWvGLJLbgaHZyaXAjwVRR1DRW9+VZasF4kh9vK/IZR4L1onD
	 HMsX6awDJ39pj4hxIV6hJMPbDQ8BYHNRZCZS7Opjigze9m+LXdCFGLQRM7kHbvD5DsAgl
	 k36e8u6Aa8oBm783FrT/23kT+9glVaKUYfNxLREtUSEeIKeOc2bdBEcLLfLfb9aMZPnKM
	 FOQYV7Tb69vNz54MJdtcA8XH0Qqfi1p2MkxPk78aX3ydLgyhVXQkNLW5DLGcZdzTASQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=V+NQoUkg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.25
Received: from WA1P291CU003.outbound.protection.outlook.com (mail-polandcentralazolkn19011025.outbound.protection.outlook.com [52.103.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53A3606A327;
	Sat, 28 Nov 2026 12:10:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B53A3606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=V+NQoUkg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXsepq9YN/irvF4vX29yjH8PxE59nOjgs2DW77bUH5pFUnzXPjKnZeVZZB+N/5uMXyEVdWbKAuofDKhWW4h7/ETvXMOvmrW4F2PQF2A2Gg6wkKsV/1UNsjpbmm9K8bcnwDm070CD6u7aOC/FCRG+lJLjGF1civZkmimVEBDTmeSY536p1W48BF5L6F2R6hWpuyVZ37PRocbgjLIddRPQNT6UES6sh9cF2Qd+JJgcaU6RDbvAwRCEMx/61lVXi2FGIskdROfiJRVld/xSCIxjEkWvBzakiVIaHqySF9OEY+T/qQ2G0+8vKxolER5lcVS0WYKG2434ggBLXezCO0xE+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wNfPlGF51r0Po3mQ4FGCNe4nFMLjgNkYSNbljH4BiY=;
 b=hBY14D82LMYow72dJD/mdej/fPSsEOXL84mKr+LfEw4zEg8nMNMxnqtzuEyh6EiYQaRZzxZ1wBI6jhSfuKqQ6KoBE9E/BmItfOYwfw6wEoGljwWCgP3b3GEjvoneybD1zzfbwLqFJp8yF4P0wF7OyWVFqxBSa0bA7lxWf/q664WTlOMAaBCgdb8n1FIFm1m1Cbrp8i8MfG0F1QB5E+sIdScz9pNpyFlW6u7H1c8aDT6Et76xjDQ3l0eZB2IWbcBEBDltptGeKOGN/7tzgWObLhGPn1us0lwUizo06yOru24AlebsDqgT61rrORnvCtiyBf6+PYcPDqUifx3mZqracA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wNfPlGF51r0Po3mQ4FGCNe4nFMLjgNkYSNbljH4BiY=;
 b=V+NQoUkgtHH0O/Tt3e5mOtHzARRn4m3xJEKwAHYspTj98zNOlZgEhRMHaZmrXOcvArK8lXB10QfSLnTQ3laXbF3P6tOShWz774r+dhkx6J3I2tohsViyfrEOyaO33z4kCes+zvu7NImAwQiWTY3jDGCkT0AYtgWUkvcEAXxuXc4MilFYA5qKI9zw2taiZeq+iADCst1hfxMHPpsvocP6cCt0UcogjH371DopHFL50TBZG+0h2S3h/1M2trgftBbIwoA33N5wcQ75x3URGJl40HYzTkTpk9/DXcGxbwnZGfPgx7iiLpFelMxAwtieqw3/l0BD8v0X9aw66Uz/nVQpVg==
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:26::11)
 by WA0P291MB0174.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.6; Sat, 28 Nov 2026 12:10:12 +0000
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404]) by WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404%6]) with mapi id 15.21.0662.007; Sat, 28 Nov 2026
 12:10:11 +0000
From: =?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?= <habilerenturker@hotmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>, Thomas
 Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?= <habilerenturker@hotmail.com>
Subject: [PATCH v5 1/4] PCI: Add pci_power_t helper functions
Thread-Topic: [PATCH v5 1/4] PCI: Add pci_power_t helper functions
Thread-Index: AQHdfzFra/cDKSl8CE61Qz1T5FXm+w==
Date: Sat, 28 Nov 2026 12:10:11 +0000
Message-ID: <20261128120858.8737-4-habilerenturker@hotmail.com>
References: <20261128120858.8737-3-habilerenturker@hotmail.com>
In-Reply-To: <20261128120858.8737-3-habilerenturker@hotmail.com>
Accept-Language: tr-TR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: WA2P291MB0187:EE_|WA0P291MB0174:EE_
x-ms-office365-filtering-correlation-id: a5e150ed-e43b-4cad-5958-08df4d488dab
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|25010399006|55001999006|8062599012|8060799015|38102599003|19110799012|31061999003|24021099003|41001999006|15080799012|40105399003|102099032|3412199025|440099028|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?SlhxK3pvTHEvam04TEErU2ExM2k0ZjgxcmVza2JoQmEvWGlYY1dMRit3Zkw5?=
 =?utf-8?B?ZjBwYmZub3ZpSUIwUmgrMXlKeXRIRzhNUG8yY1hESm1mbmo4b3VNekkxWnRK?=
 =?utf-8?B?azZWL0xUZVdxMkpoSG5tTGtoVk5oSW1QTVlUUU5xTWFWR1Fta3V6OXhUTDdD?=
 =?utf-8?B?b0lMbG80b0hNbzZVUjR4MUsySHhMam1wMnlsbDlSVDEzT05sTVlOTEgxTGtG?=
 =?utf-8?B?NXI4eEU5RCtXVlJuL2tWbFB5WU5UTEgzcUZLTkV5dzhlejBnYmtDVnlqYjIx?=
 =?utf-8?B?N2crNnZLYUpwRXNkWnBCVEVZWHU5cDlmY2JYQXJiZyt6U2RybHU0UkFsREVo?=
 =?utf-8?B?V2lYcWFhT2dhMFcyVG9jZmNOYTBqVFB6b3VBbDlXNGtIdEZRanJNRy9hc0kr?=
 =?utf-8?B?RHh1VDUxeGNOdExtRHJhLzBWZkxRWk9UZCtYeDY5TFgvZU1WZFc2Y0ZURkRi?=
 =?utf-8?B?Wk50dHVMTW1vQXN6UGdXbForckJ0QWpFUW1MTWJTN2pYdVRjbjE0azU2dGNu?=
 =?utf-8?B?QStuSnVoRU9RV1cyeGlSY2R5bGpHKzQ2dzRsNTJYakJOeFlmNVdtTEd0TERN?=
 =?utf-8?B?SEFwYmZUaDF0b0cxQmpTMkwxalV1RGduZW4vSW1YTXA1bWc5TkthdTNXTDZB?=
 =?utf-8?B?N1ptSDBtY1pmYmE0WWVPZ1YvS1RibzFIVllsY1ZRRjZvRE9wYi9FWEtDYmJL?=
 =?utf-8?B?MDJURjQzWFFKUTlJbjhXUW13UlMxZ0h2d210cHF1RWJOMlZCRWI3aEI1RktP?=
 =?utf-8?B?TzNLT1hoOHBSMVV3WDVXa1ZyVTBSRWZRMFNZaFdQZ2xqQzYyWEFhSUR0d1Nr?=
 =?utf-8?B?VmV6RUIxblZpVXRkUDlncjhHTzFFQmxuRGl0KytTb2g2TTZGcFB3eTRJaVFy?=
 =?utf-8?B?aS9BOHpYMlk4Z3gyRlIxeVNwaFJhLzFjbGpkWkZsRDU5UG1tYXBZcjk0RlEy?=
 =?utf-8?B?ZFNpeVQxbU5RNVp4R082YmEzeGVTbG93UVJrWjZQZ1lBd2RPRWN2WXoxT3Rx?=
 =?utf-8?B?Tmp4UHZrY3RCQW5LYUtlOUZLZjNrZnVXQkRKTFJWU0ozV2hIMVdwWnc1aVZE?=
 =?utf-8?B?bWtPL3lUemVlMU5zVUZSY3JaWDhOT2F0SXcyODBaTWc3VThDNlJ0WW80emJq?=
 =?utf-8?B?UW5qU0laRnFVMFVOaUs3dk9hZUo5cExKVFJYYWdzb0c1dG1LZGJwZERvSUZ3?=
 =?utf-8?B?MUFKZ0s4QVZtU1JEL2JiSkVCNFFzWUxuWm9aWUdyOHNKUnJMWE9EM2dsRXhx?=
 =?utf-8?B?Qk0zeHNMTUlSRCtPS2tOZi8vZjVXKzc2V1I3Rng4bmtxTTdRS1Mxa1hnWi9v?=
 =?utf-8?B?REJnMlUwc0xyMXRteUF6Zm8xU0FOdy9yaFE4RktKTkVVWWVtN1ZVVnBEWlgv?=
 =?utf-8?B?UTYxdStnTlpSMWVGM2tYZTBwaGpWUkEwS1lOMjRlMnkwOTFWeG1qWmI5TXZW?=
 =?utf-8?Q?5ylpiOo3?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VVJCeWNncWFVRVZiK0tIU1U4SEo2bjVIZFB6Y0pMNFZvVVk0R1grb2VYM1Iw?=
 =?utf-8?B?TnJNR3VBQXVlQ05pOG1XRXhMNmNOaVdoNVlselJQZkVZTW04aEVjUHRYQzRp?=
 =?utf-8?B?QWNNYVR0Y2hFdmF6ZFpITjE0MHNwOThKNk1zc09iVUNhb0FYREJ1dzhIQzJK?=
 =?utf-8?B?M1Qrbzg5T0l4WUF1QmJwK2I4b2pnSFY4TlIwUUQ1Nk1UN3hocFcvb1ptYTBL?=
 =?utf-8?B?UjVFSGNuNU4zZWI3NXgvZnpFQ1J3WHpkWEE0S3FMd2d3eVFMdEVDL0NrNWRJ?=
 =?utf-8?B?L1QzUEZZbG9SZk5Za1ozVlFJb0VaSEMwTFpuaUFyL2pxU2VwS002dnA0TC9W?=
 =?utf-8?B?Q2FOSmcxS21jbTRjcVc2OUEwMWFQZU1xdFh2TnpkRTFuT3ZUN1hGV0xFK0xU?=
 =?utf-8?B?OTltbEtubHFTTENGNk0xOCtvWFQxWXRYbEdpaUlMZkJVUjNxcmdLTE9ycFpZ?=
 =?utf-8?B?NkpEQkl2SkVKWXBFb09jc3NsWlQ4QkxmNUdhRjJMZmROWUFRMUFyVWRheUU5?=
 =?utf-8?B?cElSNFRRTWJ3aWt5SDRzMXpKZGtYb25Eb0dTSkFOQys4ekZFT3VtbnJCWDRJ?=
 =?utf-8?B?RGF6TGQ3ai9ma2RhdlpVT2tPSXNvQmxrcmRKZWFJb2RDTzB3UmlMODRnTGZp?=
 =?utf-8?B?eEtnTjRCV1pEQm16anpJS0JMVW0yNVJ0RFZLUkJBcWRmbVRuNnVaOXpwLzB1?=
 =?utf-8?B?WUs3cG9pVndHN1ZhUHJCckE1a0NzWHRJQlZvSzRJOFJDbHRyYmcyWm0zdEc5?=
 =?utf-8?B?dzQ1RFlubUdPTllWdDlaak8rWDNuemIxOExzOTBQT2ZlZ1BnN0UrZWRpQno4?=
 =?utf-8?B?WkRGSWtTYld4TlVwRWszeVhhdkYxcE5OU2Q2bHFPazFNeFFsRk9ZcGF5VGdu?=
 =?utf-8?B?NGJ6Ujl5ODNFaXdHVVZsZ3B0V2pnSjF0RUpzWHRMMG1tQm1qbUNsNTJ2alVC?=
 =?utf-8?B?NGdnclpIYzJHR3BKR3NVc1piRjBWRm53K0lIb001SFFxM2N6YUNMbkc0VE5w?=
 =?utf-8?B?TGtxZVc5cUIrZnlIaDhzOUR4emZtOEViQjJHSVQ5SjNHNklLb3h2UW44cXJO?=
 =?utf-8?B?Q0lMNUtOaUxucWFBckIyRzhMVDFPVVNKSFZFVlVGZHBqaVhxekJXWmNySnd4?=
 =?utf-8?B?MnJJcUNVYVBNdmpwaWtZQkYxMDFWYlpUUitMRXN0ZUJiQWxlMktJQjRxdTJL?=
 =?utf-8?B?cVVNK1p6MFVGNDdBTVA1YXFvQ1JmNE4yZmdZSk94aEw1N3krZmlQeEU2Y2VJ?=
 =?utf-8?B?WER5OE50RWorWkVud0tEdFNoVTQrQVVicHMzeGEyLzd0T0hSdDNueDdPVkZi?=
 =?utf-8?B?WmtDbldTVXZIZzF0NVlhM0pKcFpqT0NBTG1nWjZTemk3UytERTVTcHg5TEhH?=
 =?utf-8?B?UkV5YnJQaHhYV0FoNEthc3VMci9YOWFvcTlPMUpxbjNBdWNucGp1bkpQcTg0?=
 =?utf-8?B?ME5haGJ3SU5zckdUOGhnd01PWUU0QTkrK09FdmxtODJ6Zld3cVNBT0c0VnNY?=
 =?utf-8?B?eFkzSmZJVkk3bTVCMWhPTE1obHBEVWFoRGRrWERldC9xOSt3SjA0S0RJVWlN?=
 =?utf-8?B?UmU0RFZwZkIwcXVNSloyKytRMXIwL3cxTVVkdFhjZXkxUkc4cEJkQkM5K2ZW?=
 =?utf-8?B?Uk1kcit0bG83Vi9GaE4ydXU5NjVBR1BwZmhNcjRFY1Q4a0xzZlVIcFh3emNZ?=
 =?utf-8?B?WW1xQ2dnUVQvL2tDdGdFQXE1bW1ibER2TnJqdVlwd05YMG0zWlpTZDU2Z1Zk?=
 =?utf-8?B?bVdmSDRqL0R2N2Y0eE9rZGNITllpMTVmSHBZVThrTnJ3RFpobndRZ21oUkFP?=
 =?utf-8?B?TlZTc2VVOGZpaGl6UXRxOTcyV1l2ZndBdERIMENSQXVpdXlqeUR5N3ZJMWYr?=
 =?utf-8?Q?DVsBo4SaHm6IQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43D2F8E6A7C5F947823E1987689BA8E9@POLP291.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e150ed-e43b-4cad-5958-08df4d488dab
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2026 12:10:11.9580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA0P291MB0174

QWRkIGhlbHBlciBmdW5jdGlvbnMgdG8gZXh0cmFjdCwgc2V0IGFuZCBjb21wYXJlIFBDSSBwb3dl
cgpzdGF0ZXMgaW4gdGhlIFBvd2VyIE1hbmFnZW1lbnQgQ29udHJvbC9TdGF0dXMgcmVnaXN0ZXIu
CgpTaWduZWQtb2ZmLWJ5OiBIYWJpbCBFcmVuIFTDvHJrZXIgPGhhYmlsZXJlbnR1cmtlckBob3Rt
YWlsLmNvbT4KLS0tCiBpbmNsdWRlL2xpbnV4L3BjaS5oIHwgMTcgKysrKysrKysrKysrKysrKysK
IDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9s
aW51eC9wY2kuaCBiL2luY2x1ZGUvbGludXgvcGNpLmgKaW5kZXggYWEzNzY1YTIwYTk2Li45YjA1
YjkyOGUzZWQgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvcGNpLmgKKysrIGIvaW5jbHVkZS9s
aW51eC9wY2kuaApAQCAtMjQsNiArMjQsNyBAQAogI2RlZmluZSBMSU5VWF9QQ0lfSAogCiAjaW5j
bHVkZSA8bGludXgvYXJncy5oPgorI2luY2x1ZGUgPGxpbnV4L2JpdGZpZWxkLmg+CiAjaW5jbHVk
ZSA8bGludXgvZGV2aWNlLWlkL3BjaS5oPgogCiAjaW5jbHVkZSA8bGludXgvdHlwZXMuaD4KQEAg
LTIwMCw2ICsyMDEsMjIgQEAgc3RhdGljIGlubGluZSBjb25zdCBjaGFyICpwY2lfcG93ZXJfbmFt
ZShwY2lfcG93ZXJfdCBzdGF0ZSkKIAlyZXR1cm4gcGNpX3Bvd2VyX25hbWVzWzEgKyAoX19mb3Jj
ZSBpbnQpIHN0YXRlXTsKIH0KIAorLyogSGVscGVyIGZ1bmN0aW9ucyBmb3IgUENJIHBvd2VyIG1h
bmFnZW1lbnQgKi8KK3N0YXRpYyBpbmxpbmUgcGNpX3Bvd2VyX3QgcGNpX3Bvd2VyX3RfZ2V0KHUx
NiBjc3IpCit7CisJcmV0dXJuIChwY2lfcG93ZXJfdCBfX2ZvcmNlKUZJRUxEX0dFVChQQ0lfUE1f
Q1RSTF9TVEFURV9NQVNLLCBjc3IpOworfQorCitzdGF0aWMgaW5saW5lIHZvaWQgcGNpX3Bvd2Vy
X3Rfc2V0KHUxNiAqY3NyLCBwY2lfcG93ZXJfdCBzdGF0ZSkKK3sKKwlGSUVMRF9NT0RJRlkoUENJ
X1BNX0NUUkxfU1RBVEVfTUFTSywgY3NyLCAoX19mb3JjZSB1MTYpc3RhdGUpOworfQorCitzdGF0
aWMgaW5saW5lIGJvb2wgcGNpX3Bvd2VyX3RfZXEocGNpX3Bvd2VyX3Qgc3RhdGVfYSwgcGNpX3Bv
d2VyX3Qgc3RhdGVfYikKK3sKKwlyZXR1cm4gc3RhdGVfYSA9PSBzdGF0ZV9iOworfQorCiAvKioK
ICAqIHR5cGVkZWYgcGNpX2NoYW5uZWxfc3RhdGVfdAogICoKLS0gCjIuNDcuMwoK
