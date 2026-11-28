Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795867817;
	b=NOR5Wit6ImCdqJunV9nyghHXqJKnTpD0dggPJT6jK3VG9KKioksU7ZOGxEkemmoSP3Bp
	 vbhOJhuMoo3D+mAw4B/ez4W05p0Z//h1m6EZ4ddpevNFcFYt/WuA+TWtH+/U2Gn1F4oSk
	 zGnu3HrYPyNDzRWPiBHGqR/Guzu5B/XrSbJVrKxVkjXmBHwp32V/yJkfnU1DL/Mw6DzVb
	 SRrGCQ2Sb14jjETBhmE1Rna3X4wzPVRBwtKbYbhzyZBwyK7bbvo5FZLuO/DqixPP00IfH
	 CyFW767uEiPIF3fdguk8AAnEewyRoxeRqiCgqDx7lkJgaO1f1PB4g6pvT/EETMdX5Dg==
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
	bh=hcAQ+3U+L6FWYQy7KwUfYg/i+RsMclJGDXIg0WKt4A0=;
	b=M0y248O0UP8jL0GYi0d0JMH5BHCmkIvVKEoQc0hHB1H281VLXV579nog6KmLD8o3BWcf
	 8hbxHAFb74jFnrCgPSAsf+ZizdUTu5fGGhJyRWuXUNq8tF+CTK7lyUhoGpEhV7OObpgb8
	 kHEtalwf7GjRH+qzvII9RyR31UEk4RZK8tvuwkGuzTDpk8qtJeKnMOsy5NPNTUunAzCeP
	 kpLM/ymg7CUimn1yVbxMZusL1sorWyV3e2De6ISMfLIa3KGbyl2km595fmVgvfwWbf4QM
	 7bV3I+EnO1nD7MgUoU0/9Ha7tXXydP5aQCVordHGKA7+hqjZ7YJ/m0TDazvZ6ZF/VmA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b="Irbtz/wU";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.25
Received: from WA1P291CU003.outbound.protection.outlook.com (mail-polandcentralazolkn19011025.outbound.protection.outlook.com [52.103.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CC1606A32A;
	Sat, 28 Nov 2026 12:10:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85CC1606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=Irbtz/wU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vUVRJzF71JMNCwE9qjA0xDpGoL4sUyXGXO3WTys80Gr6mN5iWbNwBVqZqxT2WPffRhbN0IMFQj50ugmZ2Pb9pBkGZsbfT+1pCqFy/1IcS4vQlCnP7oq6kQ5TSOvkKMf66xmfJGhqMCoV1CNpHiEPbvBx3Nzpalh3kxs3N3Fp3OlxLMFSiJMmhQ6efrGLz7ewrtfu9yrQ2Rq7Mz1zhCYCKAOijm6EkpkXAxAMgNQVYjC8SElgCaZ8U7ZYCmML95ZMJCizktsVx03RqhTi4a0P8S0Gjz9qmGAQLS/Z7ECJgXVFXJgxwUytxw0jHy2gIOUdBPAzu0zIyVh+SRNO3a0cOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcAQ+3U+L6FWYQy7KwUfYg/i+RsMclJGDXIg0WKt4A0=;
 b=HcbSqexXz6RNj0bW/lSfJK37VewmYXnDByHBytoocSewo6WA/IBKIOyRGNk5wnEcMdUJ64rJK1CS7Xmky4a/Yk+aebA1W4ofU0KS8qHsu1ydPaDpEXkwgbVqti6hhK2sz3iLN0WNWi6w9IwWYXzj+F8YvTNs0aZxASAdvu2VhLUFMlw4vyFAGB0ajUHA2yaOncjncNfTWxxS0o2BiWt5f8MLnchCbgkSHFDrVJinmWqwbWp1yOEBc7QnqQbucbwTSy6dSpQJmXx+No2j5kxuzIQR5Oh5neJfUrHRRGPX1CcjElOmSioCPja4YkUKFN2cdYQb3Uq0RMJLmFj+FnGYPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcAQ+3U+L6FWYQy7KwUfYg/i+RsMclJGDXIg0WKt4A0=;
 b=Irbtz/wU/Jfq7EVsz5kCJ4oEk2+gpWLhNej0T0y0FADfLdmooA/s94a9v6/MZv7MJCqvVnXGdMx3Hau1ZvCUC4Na71Sjlreaiz0+eVjRI5IVl3BlXAFjra6g+HDSBw0kNjzJViUEKQu0y+zC5czglPLtGuf/4ZMmvzBqiteHveDd6Joqs4e6YJMCsj0yaOFWQPRk9AlUqQpfTKgSVwdHhNZ9GD6mypEr3dlSejcrwJMJ+4plyKy9f17IxBLdRMCuE1Ufatp9XFqCe+7CYH3PTOWyJSOo0mKAp3Hku0Yt25FcOf4PfxwbwdMwS7wn8/VkvXmHzMVxCc+7Nf5JHuGqag==
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:26::11)
 by WA0P291MB0174.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.6; Sat, 28 Nov 2026 12:10:13 +0000
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404]) by WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404%6]) with mapi id 15.21.0662.007; Sat, 28 Nov 2026
 12:10:13 +0000
From: =?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?= <habilerenturker@hotmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>, Thomas
 Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?= <habilerenturker@hotmail.com>
Subject: [PATCH v5 2/4] PCI: Convert pci.c to pci_power_t helpers
Thread-Topic: [PATCH v5 2/4] PCI: Convert pci.c to pci_power_t helpers
Thread-Index: AQHdfzFslXEA5tx+T0yguLz4TvhnzQ==
Date: Sat, 28 Nov 2026 12:10:13 +0000
Message-ID: <20261128120858.8737-5-habilerenturker@hotmail.com>
References: <20261128120858.8737-3-habilerenturker@hotmail.com>
In-Reply-To: <20261128120858.8737-3-habilerenturker@hotmail.com>
Accept-Language: tr-TR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: WA2P291MB0187:EE_|WA0P291MB0174:EE_
x-ms-office365-filtering-correlation-id: 32cfeff2-9589-41c9-5674-08df4d488e8f
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|25010399006|55001999006|8062599012|8060799015|38102599003|19110799012|31061999003|24021099003|41001999006|15080799012|40105399003|102099032|3412199025|440099028|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?SzBFRlBKMnJmNWEwWWF4Y0RQVkxTQm9yK3cyZC9uMExiWkZUZ0xKaThsNWFS?=
 =?utf-8?B?WFlpNEZ3d3lnY3lnYjYxcHNDZFVRZDhmN2VyTVBjdkRHdEhOd2ovdm5mVkc4?=
 =?utf-8?B?a2pHTjZXay9hMTdBQzJpcE5XL2h5eHpIVWNSbXpNYlBNM0xwY0hGMy8yM0hO?=
 =?utf-8?B?WVA0bVM5R0VKR0tENGRWelV5ZG05d3h6M1lhOVZ0YUtib0RJanlaUEZNc3Qw?=
 =?utf-8?B?aTlaWTE1NGJKOUxFeFBkVWFHdjB2MjY0dzYzamgrNjd0V0NUalhEMGZieXRz?=
 =?utf-8?B?UDVyY1hwcWdpQjFjcXJJQ3dlbTJSQkw5U2k3UjRPc2ZFa1hHNW5tNG54Qmti?=
 =?utf-8?B?RE1Va2dYWTA5QXN6QVlOQ0EvbzBpVmNHU3lQS0RvSUZVcmdiQzJRaWRnOHNk?=
 =?utf-8?B?NG9jZDRKZ1YyQjM5cmZyVzFUL1R5a1NLRmFBUjYwTmtaQkZoTnNoMDMvcGpy?=
 =?utf-8?B?TXNkc2ZOODBuT1BSNXBoTTRvbG03S1FQTDNBdXFoeXpmbXNtWDdoTHNXaU9v?=
 =?utf-8?B?REVxOWhBcjhOdmh1Mmw0U1R6M2hlVWM1cGpZQnU4dk9xRjN4Y0Uza1FpVWZi?=
 =?utf-8?B?SjVYbUZ3WUQxRXVFRWVqbFRnZnViUzhNM1R6aG9QeC96ZXczeTZxbjhNaElo?=
 =?utf-8?B?emVVR1VoY09BK21QMmx4SmdyQ29hZ0JZZDdqSkl3dDdpUjBZZDc5RU0xRGk2?=
 =?utf-8?B?NG44Y09HMWgycm11TVZva0l1Ui81cUVqYWV3TVkvMzVvU2pZalowZXRtRzZI?=
 =?utf-8?B?Zm1wazNsTUlhRThRUzdkTllxY05zaEl2cEhkWURlaURsQjZHTERBekJpVHhS?=
 =?utf-8?B?N1czVXlUZHFzTE0xb0UyUzJnUXZaVDNGNStVcVNyYnd0UHBHeGpZRUcreVJh?=
 =?utf-8?B?cjZaVlJpRDFYeXQ3NFVMRVdPSU5TdnBYRTdBcE1yWFpDWDEzNk5iVVBOSkla?=
 =?utf-8?B?d2xUeGRaM3VoS3VobkNuUEpwajJOR2tmRVN1cy8rT0RnMEZ3enpiNnd0blB3?=
 =?utf-8?B?V3kvV0huM3ZPT085OU10VUJqckNEajdyZ0VEci9TTUJXQnZCRHkvQ0lkdm9u?=
 =?utf-8?B?OGVWTUtYdjV4RjRxWDF6WXE3bUxPL2JaQjlSMjRwNktRVXpKNTJmdHA0QVVi?=
 =?utf-8?B?VWNzMTNZVXV3TENEVWpEZ04wc0VUbEJBczkxNUpRZFF6SDR2RFluemowL2hi?=
 =?utf-8?B?RXB0UjczanhwTHdrN1NWaE41cVBBeDhpTU1IUUQ0SmhPYkcyNFg0dTZieGJy?=
 =?utf-8?B?V2R4YkRFYmgxODNxcEtZbkhLZ0Z2QUVZM2Rwd09SVVNJa3RBUEhRTkdnVlBY?=
 =?utf-8?B?N3ZkRnpOMDFlcUdjcjR1TW5rb200T2pBZWtkaEU4U1FlbG9ibDhlUUMyc1lq?=
 =?utf-8?B?RnNkdjYrOVpCL0t5NW5xWFBsZUxobURLVGZ5SHluM0UvWkk4ZW04cVh4M3Ez?=
 =?utf-8?Q?c/NIZKvn?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RFVoQnQ2ZUkyYk5EdTA3cEJzQW51NXhaRnhCN3dhamxyRW9jVWswbVl1Z0pF?=
 =?utf-8?B?aFNTOVdKdW1rNXpwNG54OEJCNXd3dDROckIwdm5Jdm95RnIxRFUrWkI3UnhU?=
 =?utf-8?B?bDZzWUU5MDc3RXZFemRJakhjRGUwYVRjQ1ZUc0cwSnk2em90eS9RUUc4SUkv?=
 =?utf-8?B?V010MEdiTVpYemhGNDVuZ0pGNjhzQWtic1ZUbE12NDJLalgxTDIyVFhhOXBD?=
 =?utf-8?B?V0xqNHVIY1d5cGZSYmRnTDJ3VEVXcWpCc3Z1YlZkVUNSMGhJOXIxM0FyOTFQ?=
 =?utf-8?B?QXhHbk81bVl0U1VrQU42K053U2NmUUZubFdtY0ZJU0FOS3R3bFQwdEVINm1W?=
 =?utf-8?B?YUFwK1pEQi91RmtKZm1oZVhVVHBwUmpHK3JiUGNMVmpTcm1xdlJhT2RzOEl6?=
 =?utf-8?B?TEtFS3A1QUJUZDlONFR1ZFpoY3VST1ZaS1BMVlRMNVVEN0htOTA4ZnhXbnl4?=
 =?utf-8?B?VjBCZHRFWnhES00vL2pOL2Rnb1AvOWxMeG04bHl6SVE4OTkzYURHV0Q5VFpH?=
 =?utf-8?B?dklWV2pNbjgyY0tLdzdPR05jZWhkbkk0aTlQRkRzSFJpMmMzRHlaZzhkMWQ2?=
 =?utf-8?B?MGppS3FiM3c3YXQ3RGpScjZsSWcxMG9LczZjaTZFL1NjdFdUTmxZajZVV0Ex?=
 =?utf-8?B?WXBBK1QzNVNERU9OUmd5a2s4aS96d3MrTzB3b1ZnbkJCbVNRQjMyOWtYSW13?=
 =?utf-8?B?WFJNMUhDZ0F1K0RPN3dKZUxBODdKWGw5dnVMUFZJN0luQ2wvT3pYb2ZZQkhG?=
 =?utf-8?B?WDdLejkzYjlldTMyZTZmekdYUFZUT2M2MXJaYjgxNlB5NXQzZTYyTkJwRml5?=
 =?utf-8?B?a2loWlBrZ214MWNzVDlkbDZDcDc1L2pFYS9SamVveDI3VVNMZlp6NkVhR1F4?=
 =?utf-8?B?U0lwYzlycXBJWlZnRFdIY0YxTVQ0aDdXVWpBYUVVamtSczJ0K0hFR25ZMGN4?=
 =?utf-8?B?YWVXQnFXN0pzWWxCcFlraFBRclZ2elRUdUVrcDF5L0N6UmVMd0tQV2lseFlW?=
 =?utf-8?B?V3FaRjZoa3J2eWxPVG5QSk02dXBYUHhDWWc1QzV4bWxWSE9pNlpjMTJSUm0r?=
 =?utf-8?B?SGM4cTJXeUl4cStiVDhRckUwMWlGUGs1UENhSEdWYllLbHFFYVE3RGZqL2ll?=
 =?utf-8?B?bFFkZDdhZ0pJbTNGQTVRRDRuclhZQnY5OXUvL1F5R25VUTQwenExMHJpZUVv?=
 =?utf-8?B?cFl1NTN1ZEx4MytJTUV5a09DK2J5a2dGb1hOVGJQUnBvQ0lDdXVoVXlENm5x?=
 =?utf-8?B?WFEzMWlkSFRhUnhEdVczWGhrS21uOC9xTEIvcjdqMTQ2ZUM2NnRlUG1pZG1S?=
 =?utf-8?B?MmRQUWRUUE5JMDZqcnBTYVVvVWtRbUNwcmIySEl2ZFB2V05EeVQ5UGwxUmhH?=
 =?utf-8?B?Qkx6VXJLRTJRb2pIQUFYUGRUVHlEN2VuV2dHcFFWaTBnRWhBTUtHdEtFT2th?=
 =?utf-8?B?c0tRREU4Y3YxamVic1pxQlRDVGFBNE44NUpiTDROWnNYTWF4TllQaDdwR3NJ?=
 =?utf-8?B?TFM5dnJQd2loeXpVN1VNVGNuM2VSRFJNVE9OVzBaMVV6S1NqelpxdVkweGpQ?=
 =?utf-8?B?VHVTMzRVKzJsZ3lqd0tHd0lhNEJGcTdHQzh2OGJlc0VkMVdRQVc0Z3FLLzR3?=
 =?utf-8?B?REJSVDBmMTFyQnZjQ1B2R3lDWit0dkVWR3UyZXNvdnB4QTFsVDRhNUdRYjFR?=
 =?utf-8?B?V2gyaGNDWXVPdlhIL3NtRUgrYWNnU1dVSVY2K1JHQ256RTJmNnJVNTNGV2ZB?=
 =?utf-8?B?U29lYjlmVm52QzBzeDNNSGxkZG9acnFxYU9vVnltS2hNSW4wQXVLRTNUNGVp?=
 =?utf-8?B?amVhTXphMEIxQWRvRmVMTzhxZU5IbjNHbG9uTlBJQm1INEhpUFdKbzJpL1pq?=
 =?utf-8?Q?ajtFVo8AiNWFy?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A09637C17B9D454FAAE8168027288350@POLP291.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 32cfeff2-9589-41c9-5674-08df4d488e8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2026 12:10:13.4350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA0P291MB0174

Q29udmVydCBQQ0kgY29yZSBjb2RlIHRvIHVzZSB0aGUgcGNpX3Bvd2VyX3QgaGVscGVyIGZ1bmN0
aW9ucwp3aGVuIGFjY2Vzc2luZyB0aGUgUG93ZXIgTWFuYWdlbWVudCBDb250cm9sL1N0YXR1cyBy
ZWdpc3Rlci4KCktlZXAgY29tcGFyaXNvbnMgYmV0d2VlbiB2YWx1ZXMgYWxyZWFkeSB0eXBlZCBh
cyBwY2lfcG93ZXJfdAphcyBkaXJlY3QgdHlwZWQgY29tcGFyaXNvbnMuCgpSZXNvbHZlZCBTcGFy
c2Ugd2FybmluZ3M6CgotIGRyaXZlcnMvcGNpL3BjaS5jIDogd2FybmluZzogaW5jb3JyZWN0IHR5
cGUgaW4gYXNzaWdubWVudAogIChkaWZmZXJlbnQgYmFzZSB0eXBlcykgKDQgd2FybmluZ3MpCgot
IGRyaXZlcnMvcGNpL3BjaS5jIDogd2FybmluZzogaW52YWxpZCBhc3NpZ25tZW50OiB8PSAoMyB3
YXJuaW5ncykKClNpZ25lZC1vZmYtYnk6IEhhYmlsIEVyZW4gVMO8cmtlciA8aGFiaWxlcmVudHVy
a2VyQGhvdG1haWwuY29tPgotLS0KIGRyaXZlcnMvcGNpL3BjaS5jIHwgMjggKysrKysrKysrKysr
LS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDE2IGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3BjaS5jIGIvZHJpdmVycy9wY2kv
cGNpLmMKaW5kZXggN2M2ZjJhYmE4MTQ0Li5kMWMzZWYyZTU0MWYgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvcGNpL3BjaS5jCisrKyBiL2RyaXZlcnMvcGNpL3BjaS5jCkBAIC0xMTcxLDcgKzExNzEsNyBA
QCB2b2lkIHBjaV91cGRhdGVfY3VycmVudF9zdGF0ZShzdHJ1Y3QgcGNpX2RldiAqZGV2LCBwY2lf
cG93ZXJfdCBzdGF0ZSkKIAkJCWRldi0+Y3VycmVudF9zdGF0ZSA9IFBDSV9EM2NvbGQ7CiAJCQly
ZXR1cm47CiAJCX0KLQkJZGV2LT5jdXJyZW50X3N0YXRlID0gcG1jc3IgJiBQQ0lfUE1fQ1RSTF9T
VEFURV9NQVNLOworCQlkZXYtPmN1cnJlbnRfc3RhdGUgPSBwY2lfcG93ZXJfdF9nZXQocG1jc3Ip
OwogCX0gZWxzZSB7CiAJCWRldi0+Y3VycmVudF9zdGF0ZSA9IHN0YXRlOwogCX0KQEAgLTEzNjgs
MTIgKzEzNjgsMTEgQEAgaW50IHBjaV9wb3dlcl91cChzdHJ1Y3QgcGNpX2RldiAqZGV2KQogCQly
ZXR1cm4gLUVJTzsKIAl9CiAKLQlzdGF0ZSA9IHBtY3NyICYgUENJX1BNX0NUUkxfU1RBVEVfTUFT
SzsKKwluZWVkX3Jlc3RvcmUgPSAhKHBtY3NyICYgUENJX1BNX0NUUkxfTk9fU09GVF9SRVNFVCkg
JiYKKwkJICAgICAgIChwY2lfcG93ZXJfdF9lcShwY2lfcG93ZXJfdF9nZXQocG1jc3IpLCBQQ0lf
RDNob3QpIHx8CisJCSAgICAgICBkZXYtPmN1cnJlbnRfc3RhdGUgPj0gUENJX0QzaG90KTsKIAot
CW5lZWRfcmVzdG9yZSA9IChzdGF0ZSA9PSBQQ0lfRDNob3QgfHwgZGV2LT5jdXJyZW50X3N0YXRl
ID49IFBDSV9EM2hvdCkgJiYKLQkJCSEocG1jc3IgJiBQQ0lfUE1fQ1RSTF9OT19TT0ZUX1JFU0VU
KTsKLQotCWlmIChzdGF0ZSA9PSBQQ0lfRDApCisJaWYgKHBjaV9wb3dlcl90X2VxKHBjaV9wb3dl
cl90X2dldChwbWNzciksIFBDSV9EMCkpCiAJCWdvdG8gZW5kOwogCiAJLyoKQEAgLTEzODMsNyAr
MTM4Miw3IEBAIGludCBwY2lfcG93ZXJfdXAoc3RydWN0IHBjaV9kZXYgKmRldikKIAlwY2lfd3Jp
dGVfY29uZmlnX3dvcmQoZGV2LCBkZXYtPnBtX2NhcCArIFBDSV9QTV9DVFJMLCAwKTsKIAogCS8q
IE1hbmRhdG9yeSB0cmFuc2l0aW9uIGRlbGF5czsgc2VlIFBDSSBQTSAxLjIuICovCi0JaWYgKHN0
YXRlID09IFBDSV9EM2hvdCkgeworCWlmIChwY2lfcG93ZXJfdF9lcShwY2lfcG93ZXJfdF9nZXQo
cG1jc3IpLCBQQ0lfRDNob3QpKSB7CiAJCXBjaV9kZXZfZDNfc2xlZXAoZGV2KTsKIAkJaWYgKCEo
cG1jc3IgJiBQQ0lfUE1fQ1RSTF9OT19TT0ZUX1JFU0VUKSkgewogCQkJcmV0ID0gcGNpX2Rldl93
YWl0KGRldiwgInBvd2VyIHVwIEQzaG90LT5EMHVuaW5pdGlhbGl6ZWQiLApAQCAtMTM5Myw3ICsx
MzkyLDcgQEAgaW50IHBjaV9wb3dlcl91cChzdHJ1Y3QgcGNpX2RldiAqZGV2KQogCQkJCXJldHVy
biAtRUlPOwogCQkJfQogCQl9Ci0JfSBlbHNlIGlmIChzdGF0ZSA9PSBQQ0lfRDIpIHsKKwl9IGVs
c2UgaWYgKHBjaV9wb3dlcl90X2VxKHBjaV9wb3dlcl90X2dldChwbWNzciksIFBDSV9EMikpIHsK
IAkJdWRlbGF5KFBDSV9QTV9EMl9ERUxBWSk7CiAJfQogCkBAIC0xNDMyLDcgKzE0MzEsNyBAQCBz
dGF0aWMgaW50IHBjaV9zZXRfZnVsbF9wb3dlcl9zdGF0ZShzdHJ1Y3QgcGNpX2RldiAqZGV2LCBi
b29sIGxvY2tlZCkKIAl9CiAKIAlwY2lfcmVhZF9jb25maWdfd29yZChkZXYsIGRldi0+cG1fY2Fw
ICsgUENJX1BNX0NUUkwsICZwbWNzcik7Ci0JZGV2LT5jdXJyZW50X3N0YXRlID0gcG1jc3IgJiBQ
Q0lfUE1fQ1RSTF9TVEFURV9NQVNLOworCWRldi0+Y3VycmVudF9zdGF0ZSA9IHBjaV9wb3dlcl90
X2dldChwbWNzcik7CiAJaWYgKGRldi0+Y3VycmVudF9zdGF0ZSAhPSBQQ0lfRDApIHsKIAkJcGNp
X2luZm9fcmF0ZWxpbWl0ZWQoZGV2LCAiUmVmdXNlZCB0byBjaGFuZ2UgcG93ZXIgc3RhdGUgZnJv
bSAlcyB0byBEMFxuIiwKIAkJCQkgICAgIHBjaV9wb3dlcl9uYW1lKGRldi0+Y3VycmVudF9zdGF0
ZSkpOwpAQCAtMTU0Niw4ICsxNTQ1LDcgQEAgc3RhdGljIGludCBwY2lfc2V0X2xvd19wb3dlcl9z
dGF0ZShzdHJ1Y3QgcGNpX2RldiAqZGV2LCBwY2lfcG93ZXJfdCBzdGF0ZSwgYm9vbAogCQlyZXR1
cm4gLUVJTzsKIAl9CiAKLQlwbWNzciAmPSB+UENJX1BNX0NUUkxfU1RBVEVfTUFTSzsKLQlwbWNz
ciB8PSBzdGF0ZTsKKwlwY2lfcG93ZXJfdF9zZXQoJnBtY3NyLCBzdGF0ZSk7CiAKIAkvKiBFbnRl
ciBzcGVjaWZpZWQgc3RhdGUgKi8KIAlwY2lfd3JpdGVfY29uZmlnX3dvcmQoZGV2LCBkZXYtPnBt
X2NhcCArIFBDSV9QTV9DVFJMLCBwbWNzcik7CkBAIC0xNTU5LDcgKzE1NTcsNyBAQCBzdGF0aWMg
aW50IHBjaV9zZXRfbG93X3Bvd2VyX3N0YXRlKHN0cnVjdCBwY2lfZGV2ICpkZXYsIHBjaV9wb3dl
cl90IHN0YXRlLCBib29sCiAJCXVkZWxheShQQ0lfUE1fRDJfREVMQVkpOwogCiAJcGNpX3JlYWRf
Y29uZmlnX3dvcmQoZGV2LCBkZXYtPnBtX2NhcCArIFBDSV9QTV9DVFJMLCAmcG1jc3IpOwotCWRl
di0+Y3VycmVudF9zdGF0ZSA9IHBtY3NyICYgUENJX1BNX0NUUkxfU1RBVEVfTUFTSzsKKwlkZXYt
PmN1cnJlbnRfc3RhdGUgPSBwY2lfcG93ZXJfdF9nZXQocG1jc3IpOwogCWlmIChkZXYtPmN1cnJl
bnRfc3RhdGUgIT0gc3RhdGUpCiAJCXBjaV9pbmZvX3JhdGVsaW1pdGVkKGRldiwgIlJlZnVzZWQg
dG8gY2hhbmdlIHBvd2VyIHN0YXRlIGZyb20gJXMgdG8gJXNcbiIsCiAJCQkJICAgICBwY2lfcG93
ZXJfbmFtZShkZXYtPmN1cnJlbnRfc3RhdGUpLApAQCAtNDU5MCwxMyArNDU4OCwxMSBAQCBzdGF0
aWMgaW50IHBjaV9wbV9yZXNldChzdHJ1Y3QgcGNpX2RldiAqZGV2LCBib29sIHByb2JlKQogCQly
ZXR1cm4gcmV0OwogCX0KIAotCWNzciAmPSB+UENJX1BNX0NUUkxfU1RBVEVfTUFTSzsKLQljc3Ig
fD0gUENJX0QzaG90OworCXBjaV9wb3dlcl90X3NldCgmY3NyLCBQQ0lfRDNob3QpOwogCXBjaV93
cml0ZV9jb25maWdfd29yZChkZXYsIGRldi0+cG1fY2FwICsgUENJX1BNX0NUUkwsIGNzcik7CiAJ
cGNpX2Rldl9kM19zbGVlcChkZXYpOwogCi0JY3NyICY9IH5QQ0lfUE1fQ1RSTF9TVEFURV9NQVNL
OwotCWNzciB8PSBQQ0lfRDA7CisJcGNpX3Bvd2VyX3Rfc2V0KCZjc3IsIFBDSV9EMCk7CiAJcGNp
X3dyaXRlX2NvbmZpZ193b3JkKGRldiwgZGV2LT5wbV9jYXAgKyBQQ0lfUE1fQ1RSTCwgY3NyKTsK
IAlwY2lfZGV2X2QzX3NsZWVwKGRldik7CiAKLS0gCjIuNDcuMwoK
