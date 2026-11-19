Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795098950;
	b=RaK9ym+BKtpl9bfcH1WHbzdBx3znsSfap4sUl5v2HASERh0w9hU0yVa0Ub6rBKCb9SJV
	 D88WkgBHmhsjXlTZCtbUMOH1j8jGMq1svzj5a6L+MhfqMbf1a6coX2vlN3XtR4euT/IVK
	 a4JBGzFknNn9Gtk0kTQrxKVCuK8z1ZCBG//QoW6ndz8C0SIpLmnDDxyZt1S2e8mybt3gW
	 ABUiHo7DNt1+5mkA2/9zFquo7zWfsqHtpymxpV9ACdZDzzsAHjLznGeMqYVS25POLYE8o
	 URk89tLgPF40lj+ORdeGq/ZybcNBeyZl4/4+ET19l2bjRGCUFKLHvDtgx7bRXzT++Yg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795098950;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-slblob-mailprops:x-microsoft-antispam:
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
	bh=MRaLIh09EJdTzZ5BUtwCKmMaRivGc3uyWyE/N1CA7uA=;
	b=RT2TYg6WhdftqOeaIj1iCKnH7mSJLpiGUqgWu404NIN4Ei/Sww4FXxeT5pjYH/1dDo3w
	 ts+fbU+jus4WXEuyuhLuxHBmrBW+0Ff1IAeXtdBJh0fvQ+IefNjef+bGc5Dgp3IreZK7I
	 i38wdo2/snTTSZym6JnNQ6lp99FLvrk/ALNGuMijlSPjy1avYVh5E2oHeVz2ZizKCtcF1
	 AtaHux5zzORzxPOqg3ryUXLgk8zWer2DM0e2tiaJA545qNQxoUOA1tt4XmNhEJU30Annx
	 8YzShMz/nDjcinsta9ZYmUP8eA8MEgGjDGAh6wUOjhZkVtdRvhzecJtkeH6fJERvvVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=jInHEL+1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.2
Received: from WA1P291CU004.outbound.protection.outlook.com (mail-polandcentralazolkn19010002.outbound.protection.outlook.com [52.103.53.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57F1606A335;
	Thu, 19 Nov 2026 14:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E57F1606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=jInHEL+1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YyCa5JvYGtqfDs3Ag02SrBSMaYG583Yp44LWMjP4PnqQKKPk+p94/wOQpEyty4fhiCHXst/iuP+H7ppBEnpk71ShaERYXiM2Go1rtP9Ddvu2BbAlW3dtodHwvBTfOniNXlwLx3bfiSx1RXQde/WjagLYyJxQrKWBLfLd3HfG0tEAjRk5jb1tKKbIju5rdaWUhGaGVwHBZIOvuaip3U+YCe4mPO8A1f2zK4O2Jz1zTs3JYBp6rHGcKIO3mPjQbbudu4BqB1Oqz2dorqoqnmYakaecnD5pZtqPMGGMK/FGTfjaWX5YlYz8kqcoqGdSQ9aejK33jFunwNxybWmYyl96eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRaLIh09EJdTzZ5BUtwCKmMaRivGc3uyWyE/N1CA7uA=;
 b=Rkg8ymKCVFFiKv3dmkh10n+qKtKfvYIrmgbXNvGelmo3pgBIXPxDEeOHQPqeYaU+sGr2RlD0H0LWlrT7IWa1uJsbzNSvC6QtCokGh2CeeDFIltyF8rW9aKTgMCnwzt2TwXXoPzvL7Q/vprxrvGmXSutrbsaUSmXhu3LIRPGgmAzDaNqi5Ij2L65eebAIDCL68KspFc/TyFejJi9bS3/M/N+3GBwV1ANiUihlQZLraybJ+LXfY6xrYyViFuB3Mxgp3yGqhx9E7KAAiF2ikN77znG0LvChSqWhpPMm0WsQ5HWOsrJrxWtaZJ8rkLC1hJZNwkakIy8D2S3RfyyIKkHuPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRaLIh09EJdTzZ5BUtwCKmMaRivGc3uyWyE/N1CA7uA=;
 b=jInHEL+1m3mDFCDo0GTn831MaQ0L1NXej75y45kbYqSlTp7hwFO5weo4rjSNNZkKletihIWai0IYkS+WAtRenjr0j37lqKebIXS0VcWoBLn2IYfNEma1FVy01TuhXt2501kbJkhHh1RyE/0e4nMfTIFyBpu4k+znATmM9Rq2/5b82+stOO3JceSEYCgDzlGb1MtAKqa164MeHdqx6unuaOLL52zaZBRurWAznd1ufWytjL9502eXmwvUgU4bKNJBqEVxS5NpXA2saFvyViDD54GFRr+8fJqZgmqoq6/RzuxIbVP/SH03ShhDLQHMcDYIbVImgMQ8KsjkvwFBbP6A8w==
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:26::11)
 by WA2P291MB109571.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:47::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 14:35:48 +0000
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404]) by WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404%6]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 14:35:48 +0000
From: =?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?= <habilerenturker@hotmail.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>
CC: "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>,
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, =?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?=
	<habilerenturker@hotmail.com>
Subject: [PATCH v2 2/4] PCI: Convert pci.c to pci_power_t helpers
Thread-Topic: [PATCH v2 2/4] PCI: Convert pci.c to pci_power_t helpers
Thread-Index: AQHdeDNEl5SnbY+LlUKyXX5lZTmKKg==
Date: Thu, 19 Nov 2026 14:35:48 +0000
Message-ID:
 <68e76d8e17030a21d3ee6df2f2109057f75147fd.1795097970.git.habilerenturker@hotmail.com>
References: <cover.1795097970.git.habilerenturker@hotmail.com>
In-Reply-To: <cover.1795097970.git.habilerenturker@hotmail.com>
Accept-Language: tr-TR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: WA2P291MB0187:EE_|WA2P291MB109571:EE_
x-ms-office365-filtering-correlation-id: 94aabf59-c28f-41fd-81f7-08df464a6728
x-ms-exchange-slblob-mailprops:
 qdrM8TqeFBvhuFgLLe5qs4jWk9CHdv0AMuJ2yLdKpWKVF1TeD6CCobuRV4kk7pA/o6v6e6D0MOem2kLKvrN3V41Km+OPvMty88suoC1bS48KeszCmiaz5DmPeRVgx40x+lBjM8SBbsAlvFK5MbDb1NHhm6Wh6WKowjWhCiQAVMieRRxvJ6PejrDQhyZ+N/ok0uSlHng3z74zb5uJPWJNaUgoh5YxX8bzts8s2Z0HrGRfLlqyXUgp9Nn26RecLzRG8a9B3lf1cjRIMRL5IXzRmuNnW1TzGntLWs6OKv5acHwDbLFYheCtiLvg0fx4Nm0VTRn5jY6W2jCsUEcoru83Z/dE5csm3XS/pUjfJlAGFe24vVu3S+xzG8XdmmZBFBvN1At9yJG9hrRZL8PqtYSfa2HtSiIf0RWH0fUd0DCoH7doPBvZ+AcTmcBTW+x5EyuC1Zf5nxHvDgi+Sgxah1WaP7pZJ6Wa1VG3cOF7LZn7SrPloMGlgxq1woQ3oKjZnaZZXAYcyeppLV8lrKBtnotPxNrobpCqCoxTZ4MpGa3YU/NllV8kE5JxPXqsDc1zyXuMxHqcKOKTXbC3KVeICI4cXY+CpbDO1Q56LHvBe9mXhdDYKpXQ8vT/wPyi3yMlUpmkM5gkcoa0rFoVG5cVxrUzS1aBlBBJR1kP6yoBsfbfJPe7vZk79nicPucihxLamkn1SMQrarvwj6Y8g9p9BBZLFf4lHkiPn1OcnvWYiolYcqrKry6XJs7v/254oXVm6A7SiALcoWE5EfY+EbT4oGRSy5Jg3YG9yLpn
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|19110799012|51005399006|25010399006|24021099003|55001999006|8060799015|38102599003|31061999003|41001999006|15080799012|40105399003|102099032|440099028|3412199025|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?a1lLZGpHTzBsY0wxQ2M5K2hUZjNqcm11Mjl0Vk1lZjZjcGRHTjJ5OGVvL1VY?=
 =?utf-8?B?QWpLcW8zWTRzNFRvK2RXVEVZWFdBT2tFdUIrcU80MnBoZDhzNmlURmRINEFC?=
 =?utf-8?B?SmRrM0cwdEE3bEUyMjJ6OG83YnpMMnJlYXc2d0cxaVlnV3VwUmgyWXVhczI3?=
 =?utf-8?B?RFRkNDVBSEhCS1E1WFZheGlBVGN0VUlxenlIb1dsaXNTSDlGSndtbVZtdVlU?=
 =?utf-8?B?em5JeEpsK2djeW9LdU5sRnVMa1ZhNkh6UTFSUndqT0QybUVDNTNUVkEycVZO?=
 =?utf-8?B?eFV6SEtQcmk0VS9FSHpwMVQ0UlYrcnRLU2gzWWh3RmVXTitEdG5SKytFODE3?=
 =?utf-8?B?RkhDOXFHUzQxRGZORU90TlVyRWZKZzVaaGJJZkI4RGFWTUdlQ1NpcmV0T21G?=
 =?utf-8?B?d3VJdDRYSGN5MVI5NXR4VTFsZGpoR0xsM2hqK3NPaTlCTC9SSDNTRmhBd0lN?=
 =?utf-8?B?eldmSXhWSkxsVXFpcnZGcUV1TmhtditmZ0RRbUlNWEVHbG95Z0RyRnRQaVM0?=
 =?utf-8?B?MTIxeVZtWkk3aHozYThlSS9wM0JXd0NzZS9hYzhxcnpySzI0R2dkbkVWSS9R?=
 =?utf-8?B?L1RnZllXRXZKRlhaVVNZNG5PZldzakdkaEp0c2p6dG5VemxmMHN4R3E3Tm80?=
 =?utf-8?B?aTQ3dnR6dEl5Vi85NHVTTkM3TzZPVlFMbm1RY0d0VitGaXZZWkQxbXpwR2xV?=
 =?utf-8?B?a3gzdjEzanFvSTBqTWV4Y2ZUQnd1VDJ6MDlsT0pYUUVLQ3d2RGw0OC9aeW9D?=
 =?utf-8?B?VkZXSTNIMWsxZ2VsMEx3YXV6SDhDQ29GcXlDUm1VM0QyN0lLVEFKb2h0a3ls?=
 =?utf-8?B?cTBaT29NOUIzcWtwQzVPWmFxOTNkM3FFK1hOcXAxbXdNTzhKbkI5czVBY255?=
 =?utf-8?B?T3FLanpLMmJCNWlsRU4xUy9pY2hqb0Z5Y1BaNjQvWGMzZXNhb1BZTlV1VG8y?=
 =?utf-8?B?MmV6UUFVUWZEL1pvNzVZKzZBS0J4UWZNdE04NVhPQWJ6eUYyWFVDUjlvSm95?=
 =?utf-8?B?NlpQSXhnSVNEalVESFB1RnRlU0JDT1VGemZjbldMR1J2STJDZTZjclNpdjho?=
 =?utf-8?B?L29ZWDV5bkc0ZkRjd1lodjljQTZmMmJ1NkJmTUZJSHIwZWlzQU5NSm51WFh0?=
 =?utf-8?B?KzBGU0d3VXJRT0Z4M002NHI1TVdmL1BQV2o0c1B1VHk2ZmFVeWhBS0RZbXRo?=
 =?utf-8?B?cmJpUEpsMkxyZVUzek1IS1lYR3Q0c3FQd2tvVGNRTmc3TXBSMUVJdDYwWHZk?=
 =?utf-8?B?QitRMUorK2I5bEhrdjRBSGpPWUlqZlZvczBiNjBOclBsMGYwdk9BS3pFaTli?=
 =?utf-8?B?aFVzYnpSRlh2Y3IralJVOUE4clBsN3ZOSk51a2cvTHZkOVlQQk1JTHBCNXpM?=
 =?utf-8?B?c1paSUpNOUoyV2ZMWktuUUFSYUVKeENsSHBPemlCUStyQnRNVE9za21SbDBK?=
 =?utf-8?Q?Ye+/Xb89?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MkwrV2E1bWhJdzVuMjVnUVdVTEFpT05paFpITG1PN2dGakpDeFh0SytJUmRl?=
 =?utf-8?B?T0UvSzVreHZnRDZRSDVNMHFLMFhzWDlXVlVUUklRN0JEaVk5UkU1bHlRWjRj?=
 =?utf-8?B?V1BmcnNWTHNrWHYydFUrOFNvMkN6eFlGdlQvTythZzZkcCt6Q3NycW55bVdr?=
 =?utf-8?B?UEk4OGwrMlozVFpOVG5zN01YaGNnNGRzV0xBQlRPSS8yOU1iVXIzVzM4WE9s?=
 =?utf-8?B?Wncyam82MXdWTnZKUXhMUHM5K1RKdXM1dTBzd3FCRi9KTXJqdGdKSkM3dmE1?=
 =?utf-8?B?d0tCd1lDTmwrZVRaYkxvQmkzOFJkUHBWcEVBWHI0ZW9vRXUwTkhvSEIrUkwr?=
 =?utf-8?B?R2drc2NVZVZGZ2lmRlZkZklnZWQ4SXYwZTdCSmtzeEtTZnR6M2tTanZZUTdL?=
 =?utf-8?B?Yks2MWg2L082cjEyQ1MvMVBqb0dVUG5EVkVneGpZdThrN0h5ODdMR2NZOGJR?=
 =?utf-8?B?SGRma0s1dnZ6ZTlkbHlJVU4vRUZ1NVZOK04zelZaS1V2VDRLMW5PRWNXMkh4?=
 =?utf-8?B?YUJlYW5YOHBtZWEvY2s4WmJrck8zL0phMCtLb1g1V3pXaXJZUEJUbnU0Mlc1?=
 =?utf-8?B?SUhqUE9vOXM5bGorUkhLaXYrVDZ2NGw1Uk5KTHI5bk5RV0x1bHF1Mmk0aTdr?=
 =?utf-8?B?bnpDcFgrVTQzTlhjMjVYZUNVemQrOStjbXRUSXFNanN2RElEczdXMmNCVXZ6?=
 =?utf-8?B?VDVzd3ZGTFo3ckdSWTRmOHlhYlg1WEt3aCtiRmZFbS9ndGJ2WXZRRllmYTRl?=
 =?utf-8?B?NURSQTYwSVdzVmw3MWR1dUQ4WjZVdHM0Z3dtbkF0MWs0S3NwYjNCeTRhTTJC?=
 =?utf-8?B?WmwxK1lQTDNUNFVyODJrbE9IMkFtdjd6cC8vSmZ0T2t2S2U2SXZYZU50K2cw?=
 =?utf-8?B?eHJGd3ZQamJFZE9PdmZTOW5XaG5DdXpFVTgyN2NJY0JFOGR2ZWVIQnpseVlw?=
 =?utf-8?B?Zm1Ba1Yvb2hLeGIvK0ZWMlA0UHZ5WDU3K2djN1R1bzgrcVZQZnBLMFFPc0lU?=
 =?utf-8?B?Y0VGbXJGTTh3QWdZNmZqUkFDSnNPOVVNaWJwdWRUWlJIMVJqR2wxSEpUMjF4?=
 =?utf-8?B?VXRYQityVlM2dURuMHRkMUNibzNYR1JMUWw4OVZ0MWxrSklLZ3NybGsrb1VJ?=
 =?utf-8?B?TVkrYWF1WDhHVmo1VDVKNGFVSlBEU1FHVGc3ZFhDZy9SWi9iOHNzaWdNNkN4?=
 =?utf-8?B?TitqL3ptQVFrRldiVUk2ZmRHVFFZQ0p6S0k2ckdoeGZ2R2J2a1Nlc3M4VVg1?=
 =?utf-8?B?cStWZ0JvLy9zeWhNaUFneHhJRTMvYW05RHN2SkgxNDhJa3hWMHpoeHZBc1VK?=
 =?utf-8?B?RVpsWjBsZzJ6WkVoSGxLc2xValJvZmFVL0U3Q2puVkhibGJpdThoQ2FGb0E1?=
 =?utf-8?B?a051MU1EY0dvSy94dWVGNVVXY2pWcUp3WkZrcy92SEtyaDB2WDFwVm4xRGhZ?=
 =?utf-8?B?Mm5JNVYvMSs0dWgzcVU1czIzQ0RQNm1mdW5TeXdNc3JhcWl2TENqaGJmdVlL?=
 =?utf-8?B?T0tWbXU3VVIvSVQ0NmFhb2VTNGNtNmdkUW5ZZW1MWjM2dTBrRm93R1FQdDRE?=
 =?utf-8?B?MnVTS2xmaGRRZEgzU0pHTDJpT2J5WjF3UDM0UVVsSU5Xakk4SlhLcFp5UnVT?=
 =?utf-8?B?bkg1TFFGS21xZjY2dUlqeGIrOTJKMTRkVHpJZE8rRklQbC9ObUNpSmNJWkU0?=
 =?utf-8?B?VnJadGJ6Vm1TQzA5SWU0WVd5TGdpRkdxZzBDQ0p1aXBwVVFBMzhRclNxU3Vl?=
 =?utf-8?B?KzRtd0JybFRHQWp3QXMvaUpzV2tGL0NQb2MxNkxNdHdpRGRpMVhwbzAvaWVV?=
 =?utf-8?B?NGovVXd3RktFSTZmZGdVajlvLys2cTRWSGVXQmYxenNEMU1PTXo0UjR2NjZF?=
 =?utf-8?Q?biCCCeH6zpG6/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD80DC6464861E47952210A6F4A69C8B@POLP291.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 94aabf59-c28f-41fd-81f7-08df464a6728
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2026 14:35:48.1655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA2P291MB109571

Q29udmVydCBQQ0kgY29yZSBjb2RlIHRvIHVzZSB0aGUgcGNpX3Bvd2VyX3QgaGVscGVyIGZ1bmN0
aW9ucwp3aGVuIGFjY2Vzc2luZyB0aGUgUG93ZXIgTWFuYWdlbWVudCBDb250cm9sL1N0YXR1cyBy
ZWdpc3Rlci4KCktlZXAgY29tcGFyaXNvbnMgYmV0d2VlbiB2YWx1ZXMgYWxyZWFkeSB0eXBlZCBh
cyBwY2lfcG93ZXJfdAphcyBkaXJlY3QgdHlwZWQgY29tcGFyaXNvbnMuCgpTaWduZWQtb2ZmLWJ5
OiBIYWJpbCBFcmVuIFTDvHJrZXIgPGhhYmlsZXJlbnR1cmtlckBob3RtYWlsLmNvbT4KLS0tCiBk
cml2ZXJzL3BjaS9wY2kuYyB8IDI2ICsrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUg
Y2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9wY2kvcGNpLmMgYi9kcml2ZXJzL3BjaS9wY2kuYwppbmRleCA3YzZmMmFiYTgxNDQu
LjE5MDJiN2M4NThmZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9wY2kvcGNpLmMKKysrIGIvZHJpdmVy
cy9wY2kvcGNpLmMKQEAgLTExNzEsNyArMTE3MSw3IEBAIHZvaWQgcGNpX3VwZGF0ZV9jdXJyZW50
X3N0YXRlKHN0cnVjdCBwY2lfZGV2ICpkZXYsIHBjaV9wb3dlcl90IHN0YXRlKQogCQkJZGV2LT5j
dXJyZW50X3N0YXRlID0gUENJX0QzY29sZDsKIAkJCXJldHVybjsKIAkJfQotCQlkZXYtPmN1cnJl
bnRfc3RhdGUgPSBwbWNzciAmIFBDSV9QTV9DVFJMX1NUQVRFX01BU0s7CisJCWRldi0+Y3VycmVu
dF9zdGF0ZSA9IHBjaV9wb3dlcl90X2dldChwbWNzcik7CiAJfSBlbHNlIHsKIAkJZGV2LT5jdXJy
ZW50X3N0YXRlID0gc3RhdGU7CiAJfQpAQCAtMTM2OCwxMiArMTM2OCwxMSBAQCBpbnQgcGNpX3Bv
d2VyX3VwKHN0cnVjdCBwY2lfZGV2ICpkZXYpCiAJCXJldHVybiAtRUlPOwogCX0KIAotCXN0YXRl
ID0gcG1jc3IgJiBQQ0lfUE1fQ1RSTF9TVEFURV9NQVNLOwotCi0JbmVlZF9yZXN0b3JlID0gKHN0
YXRlID09IFBDSV9EM2hvdCB8fCBkZXYtPmN1cnJlbnRfc3RhdGUgPj0gUENJX0QzaG90KSAmJgor
CW5lZWRfcmVzdG9yZSA9IChwY2lfcG93ZXJfZXEocG1jc3IsIFBDSV9EM2hvdCkgfHwKKwkJZGV2
LT5jdXJyZW50X3N0YXRlID49IFBDSV9EM2hvdCkgJiYKIAkJCSEocG1jc3IgJiBQQ0lfUE1fQ1RS
TF9OT19TT0ZUX1JFU0VUKTsKIAotCWlmIChzdGF0ZSA9PSBQQ0lfRDApCisJaWYgKHBjaV9wb3dl
cl9lcShwbWNzciwgUENJX0QwKSkKIAkJZ290byBlbmQ7CiAKIAkvKgpAQCAtMTM4Myw3ICsxMzgy
LDcgQEAgaW50IHBjaV9wb3dlcl91cChzdHJ1Y3QgcGNpX2RldiAqZGV2KQogCXBjaV93cml0ZV9j
b25maWdfd29yZChkZXYsIGRldi0+cG1fY2FwICsgUENJX1BNX0NUUkwsIDApOwogCiAJLyogTWFu
ZGF0b3J5IHRyYW5zaXRpb24gZGVsYXlzOyBzZWUgUENJIFBNIDEuMi4gKi8KLQlpZiAoc3RhdGUg
PT0gUENJX0QzaG90KSB7CisJaWYgKHBjaV9wb3dlcl9lcShwbWNzciwgUENJX0QzaG90KSkgewog
CQlwY2lfZGV2X2QzX3NsZWVwKGRldik7CiAJCWlmICghKHBtY3NyICYgUENJX1BNX0NUUkxfTk9f
U09GVF9SRVNFVCkpIHsKIAkJCXJldCA9IHBjaV9kZXZfd2FpdChkZXYsICJwb3dlciB1cCBEM2hv
dC0+RDB1bmluaXRpYWxpemVkIiwKQEAgLTEzOTMsNyArMTM5Miw3IEBAIGludCBwY2lfcG93ZXJf
dXAoc3RydWN0IHBjaV9kZXYgKmRldikKIAkJCQlyZXR1cm4gLUVJTzsKIAkJCX0KIAkJfQotCX0g
ZWxzZSBpZiAoc3RhdGUgPT0gUENJX0QyKSB7CisJfSBlbHNlIGlmIChwY2lfcG93ZXJfZXEocG1j
c3IsIFBDSV9EMikpIHsKIAkJdWRlbGF5KFBDSV9QTV9EMl9ERUxBWSk7CiAJfQogCkBAIC0xNDMy
LDcgKzE0MzEsNyBAQCBzdGF0aWMgaW50IHBjaV9zZXRfZnVsbF9wb3dlcl9zdGF0ZShzdHJ1Y3Qg
cGNpX2RldiAqZGV2LCBib29sIGxvY2tlZCkKIAl9CiAKIAlwY2lfcmVhZF9jb25maWdfd29yZChk
ZXYsIGRldi0+cG1fY2FwICsgUENJX1BNX0NUUkwsICZwbWNzcik7Ci0JZGV2LT5jdXJyZW50X3N0
YXRlID0gcG1jc3IgJiBQQ0lfUE1fQ1RSTF9TVEFURV9NQVNLOworCWRldi0+Y3VycmVudF9zdGF0
ZSA9IHBjaV9wb3dlcl90X2dldChwbWNzcik7CiAJaWYgKGRldi0+Y3VycmVudF9zdGF0ZSAhPSBQ
Q0lfRDApIHsKIAkJcGNpX2luZm9fcmF0ZWxpbWl0ZWQoZGV2LCAiUmVmdXNlZCB0byBjaGFuZ2Ug
cG93ZXIgc3RhdGUgZnJvbSAlcyB0byBEMFxuIiwKIAkJCQkgICAgIHBjaV9wb3dlcl9uYW1lKGRl
di0+Y3VycmVudF9zdGF0ZSkpOwpAQCAtMTU0Niw4ICsxNTQ1LDcgQEAgc3RhdGljIGludCBwY2lf
c2V0X2xvd19wb3dlcl9zdGF0ZShzdHJ1Y3QgcGNpX2RldiAqZGV2LCBwY2lfcG93ZXJfdCBzdGF0
ZSwgYm9vbAogCQlyZXR1cm4gLUVJTzsKIAl9CiAKLQlwbWNzciAmPSB+UENJX1BNX0NUUkxfU1RB
VEVfTUFTSzsKLQlwbWNzciB8PSBzdGF0ZTsKKwlwY2lfcG93ZXJfdF9zZXQoJnBtY3NyLCBzdGF0
ZSk7CiAKIAkvKiBFbnRlciBzcGVjaWZpZWQgc3RhdGUgKi8KIAlwY2lfd3JpdGVfY29uZmlnX3dv
cmQoZGV2LCBkZXYtPnBtX2NhcCArIFBDSV9QTV9DVFJMLCBwbWNzcik7CkBAIC0xNTU5LDcgKzE1
NTcsNyBAQCBzdGF0aWMgaW50IHBjaV9zZXRfbG93X3Bvd2VyX3N0YXRlKHN0cnVjdCBwY2lfZGV2
ICpkZXYsIHBjaV9wb3dlcl90IHN0YXRlLCBib29sCiAJCXVkZWxheShQQ0lfUE1fRDJfREVMQVkp
OwogCiAJcGNpX3JlYWRfY29uZmlnX3dvcmQoZGV2LCBkZXYtPnBtX2NhcCArIFBDSV9QTV9DVFJM
LCAmcG1jc3IpOwotCWRldi0+Y3VycmVudF9zdGF0ZSA9IHBtY3NyICYgUENJX1BNX0NUUkxfU1RB
VEVfTUFTSzsKKwlkZXYtPmN1cnJlbnRfc3RhdGUgPSBwY2lfcG93ZXJfdF9nZXQocG1jc3IpOwog
CWlmIChkZXYtPmN1cnJlbnRfc3RhdGUgIT0gc3RhdGUpCiAJCXBjaV9pbmZvX3JhdGVsaW1pdGVk
KGRldiwgIlJlZnVzZWQgdG8gY2hhbmdlIHBvd2VyIHN0YXRlIGZyb20gJXMgdG8gJXNcbiIsCiAJ
CQkJICAgICBwY2lfcG93ZXJfbmFtZShkZXYtPmN1cnJlbnRfc3RhdGUpLApAQCAtNDU5MCwxMyAr
NDU4OCwxMSBAQCBzdGF0aWMgaW50IHBjaV9wbV9yZXNldChzdHJ1Y3QgcGNpX2RldiAqZGV2LCBi
b29sIHByb2JlKQogCQlyZXR1cm4gcmV0OwogCX0KIAotCWNzciAmPSB+UENJX1BNX0NUUkxfU1RB
VEVfTUFTSzsKLQljc3IgfD0gUENJX0QzaG90OworCXBjaV9wb3dlcl90X3NldCgmY3NyLCBQQ0lf
RDNob3QpOwogCXBjaV93cml0ZV9jb25maWdfd29yZChkZXYsIGRldi0+cG1fY2FwICsgUENJX1BN
X0NUUkwsIGNzcik7CiAJcGNpX2Rldl9kM19zbGVlcChkZXYpOwogCi0JY3NyICY9IH5QQ0lfUE1f
Q1RSTF9TVEFURV9NQVNLOwotCWNzciB8PSBQQ0lfRDA7CisJcGNpX3Bvd2VyX3Rfc2V0KCZjc3Is
IFBDSV9EMCk7CiAJcGNpX3dyaXRlX2NvbmZpZ193b3JkKGRldiwgZGV2LT5wbV9jYXAgKyBQQ0lf
UE1fQ1RSTCwgY3NyKTsKIAlwY2lfZGV2X2QzX3NsZWVwKGRldik7CiAKLS0gCjIuNDcuMwoK
