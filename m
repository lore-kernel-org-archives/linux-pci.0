Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.26
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795259729;
	b=iemmbBnFoq2ZMH+pKHiqdKMR3pe2Jw/5zNpxToOIk8wfV+WOo04T4Z1jT+6VaHxqWP7b
	 eaCypYdPTU+51cU4uJO+6BcUOV7N3HeE3Wd4enREpbNwDlUHXtU2JkT9v0oUhV+g6I52F
	 ky8SwLkw4+2ojrh0ExFxSwyk2kxlGymkx+w36IGgQpN6gtpc3UrE4iBhLXcESivNASp+p
	 4vlZgGuoZiWMVZyGUNj7dYUUS+OqB9IF2gWIiwAhT10Wee6KIUGq7Ug39OF5DBv/T5azG
	 rWdBbcOeag7xxeNAhaZ8DREHOV9TqC2fdgrvjafz41Q4gbnnUF8OppaKAevMJNb01Xw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795259729;
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
	bh=QqEJkdqFYlir0e9ju0tjUWQuW/qO/RfmtRSlSYcgVJ0=;
	b=Ax0F9WjiFgHLcZrgpW4HXbUqYMG7gIqiHg400XgiJG4+oeQenWErZI5olXjg0zg0wbwd
	 VLw/pl5XSLlzP1sRYc4dLKSwH3Vf/7iu6lfEJoxddqKygYbMB0ic+0YluWO1yvxa0xP1r
	 ch8H/YDz+X7hlkltv41V0wk7gOAe94+J1yWG2yPPzi7QoJjc8QBThyxifdPji+x/sCVvW
	 To4hfqdVqsk9NO2TdEXmwty2CsWxGhAMi0E2YJL0shjFXEBhQC7vYkx++wyiIdBJ2kZ+n
	 Vkwhix3qJQb76fHDU0SkehFPuyKykz+ybXDs54yT64ZdDKJiKAMpAUpieFj86vGvs8g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=FkEVYvOG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.26
Received: from WA1P291CU003.outbound.protection.outlook.com (mail-polandcentralazolkn19011026.outbound.protection.outlook.com [52.103.53.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66232606A32A;
	Sat, 21 Nov 2026 11:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66232606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=FkEVYvOG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vbp+6y0JX3kcAZIZ3VtqoAtuAWpKI6zTtqiLNTFOwV/oTE1tgwYis11j2Gqx/BAuzif3ufmtJaxlJDyZT71Qf3jFaSKan0Mko9OlDkLsm58p994CkfulAY9yop/KQr7ok98tGhPADlvjrVvZJp/NKzLd/6mizb9wZTKKzBPLv0Bqx49JGVmGK8Pa3+TLWVSsEVmXiBd0AGqayHnuc0UIOR0rvLKJ8ZryXGgFrLyWD23AwV1+42UGH9rdejYzehdlv9KRqAQhyefGKjPz7TJuji5tJD4Aou2sJxgqXtE7o2cKRLTTM2hccFJah0Sbff2nQntQYdNmxmeIcTZWgsA52A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QqEJkdqFYlir0e9ju0tjUWQuW/qO/RfmtRSlSYcgVJ0=;
 b=dBqog/F6uP1mLxjyXdgm4y9jDiMtkscB87i5k1+vm6enPSd+743EmVtl+m7WMR9gwk8BdLlHH36degH7c6Qt2fSznKmGHlXDTveiY7WQvSxkrVvB6mtQWTf8s2gdnbLzHus6aIt7xEqdPHe2RpE8k9i/2ih2W6CKzgWsgRVsZ313DROr/PcYwWTfGQMX+TRQ6VoVcQI+AeIHaWckFlF7r6GWulw02HtqSf3GvTrcihh0Yy0FR26w4L7aSGoa6JeFmnmmd9ehq6ts/ZuWOk15s1jXI78/m7XHZIpZAMxj9gIeqwJk00uGHNy4S+dtKW6O6CMxE7QYvg3jPVaDJlHJWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqEJkdqFYlir0e9ju0tjUWQuW/qO/RfmtRSlSYcgVJ0=;
 b=FkEVYvOG2HK/UwYQyUUdTWpyByweT7A+3ubaMnIg4htrTkDKtj1tZ9JJFgapAhvQKvwoMmuAsqTcZgiqkjEzC01r1eYGNvRtvDqrn5O5DV0YFXQGqXxBSFHS5lhlRn52uiCKKzztSfPUXfGFyZt4aRolKtLsRoYZhwIuOSXrW00yFYLFwUgOae1hTPIGpQlhMydi7AH4VVTmLfy97+Up0NLw51Cvhn2Kcgb5UFFTHR9OnLtgt0iL/jmlWQTD3ClJDFWfPZ/OI+KaUVVBO62VM+bHBkLjuXx9sJuC/mOntYsoa1DprZ+Z6TBQy3WnKmTgIDWVFP8Sn/7A7J3TwJMyeA==
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:26::11)
 by WA0P291MB0123.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Sat, 21 Nov
 2026 11:15:26 +0000
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404]) by WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404%6]) with mapi id 15.21.0639.011; Sat, 21 Nov 2026
 11:15:26 +0000
From: =?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?= <habilerenturker@hotmail.com>
To: "helgaas@kernel.org" <helgaas@kernel.org>
CC: "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	=?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?= <habilerenturker@hotmail.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 1/4] PCI: Add pci_power_t helper functions
Thread-Topic: [PATCH v2 1/4] PCI: Add pci_power_t helper functions
Thread-Index: AQHdeamb+4URkAj1B0aPid0KUMSnAw==
Date: Sat, 21 Nov 2026 11:15:26 +0000
Message-ID: <20261121111525.41762-1-habilerenturker@hotmail.com>
References: <20261119172320.GA817954@bhelgaas>
In-Reply-To: <20261119172320.GA817954@bhelgaas>
Accept-Language: tr-TR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: WA2P291MB0187:EE_|WA0P291MB0123:EE_
x-ms-office365-filtering-correlation-id: e1c70882-5890-4104-2231-08df47c0be70
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|15080799012|38102599003|31061999003|8062599012|8060799015|19110799012|25010399006|24021099003|55001999006|440099028|3412199025|102099032|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?N2hyeXo0TWc4QU1TanlLZlpyOThkTUpkZ1hOVitDWHVDUkdTeTVqcjNwL3RQ?=
 =?utf-8?B?bGpCMWNVeEtEV3Q3L2xocHVBYWpBYy9sb1JML3F6akJjRFB0MHBsQlQ3VFI5?=
 =?utf-8?B?RmVINmpTTWVmV09hbTFWYU4yRUhDU0ZKM29KZHlMU1dOYjBjR2VBYytLMlFO?=
 =?utf-8?B?NVRWRnkzaHpIV203dWJ4bUtKV0FjdUlaQ3Bub1dGeVZYZ1I4MnIzekx1MlhI?=
 =?utf-8?B?Q2NVMHJvcThVRDJhOWhCYVl1d1dsSlNvSmVDUXAzOEZpMDcwVWVDS2VpdWxH?=
 =?utf-8?B?c1JnRENHaTl0QmdvVThSdWpmTDNBUDRGYStseFp5dk1VS0REN1BjSFBIOVpn?=
 =?utf-8?B?eXFweTh4c2hBa2xGMVNBdFVLYjNHayt4UjhNTnI4V1FZQ0VHZURJVkhOL053?=
 =?utf-8?B?cDMwMEJKYWplSkdPT3Voa1dXbGJ0blJqUVdObnBpVXJHL3dJeCtUMUN4WUlZ?=
 =?utf-8?B?RXlaQlZuVFgyVHJjSURHT29zUUN6VW9RVjZGUEIwSjcvUUdYT0YrTWx2cjNu?=
 =?utf-8?B?STFsWjJzeURjQWsyaUZpS2FOVzlhcTFXK2Y3SHJKSHlMT3RkU2ZWV0toa3JC?=
 =?utf-8?B?aVlZSndpcll4ZWdhSDhZRmlmY1lwK28rejZITGNuc3FuSW9yeVJ2aFlGMEx0?=
 =?utf-8?B?bnN2eDVEUGo4aDd4Vm1CWG5IYk05QXE5NDhwWHg3NVcwVSs1Z25TOHJvZzl2?=
 =?utf-8?B?b3JGVXBYTnFrUnF5SjRQakVrSE5QbDZORGxLeDZHZndvZlVhenRrOFJsNURN?=
 =?utf-8?B?bFI4blBSL3ZtWXlhZVBpbzhndVZhOXJFRlc1ajV0ZzVoTmwzdWlpbXFRaHl0?=
 =?utf-8?B?MW1FMTByZGlZbDZmMHU1eWlnWCs0V1BINDFMdEdlbVhxeDJSaFhNakYySHc5?=
 =?utf-8?B?anZmOHAzUE5pT1pldy9pMVdzSFhWOVVjQnRtU0VDTllZM09wWDFVRjhJTDhZ?=
 =?utf-8?B?NWRwOHJNMUxvSiswYXhqdGlidWkxbFNCOE1JNTZvTzlQZ3FEMTFwNFhEMzdL?=
 =?utf-8?B?RlpFcDk1SGlpbG5kOVhsRnBpTnhKMkgwUTNmN1pvZWw1ZGlMMTlHVjg3OFNK?=
 =?utf-8?B?M3MvYSs5dHNWZGR2T1BRRlUwQUxsVDlJcTRwZG5lOGkzRXpUeUpqcENKR01a?=
 =?utf-8?B?UTBvUThTK1E2ZXRoUG03OEVUcU5GVnBuRVpuYml5OStwQjRGODRDS2ZiTXls?=
 =?utf-8?B?YTVGb3dvMEpFRWVPZTMrZXBDSEZvM05Bb0I2eDNpa0tHRUs0aTh1VVVldElF?=
 =?utf-8?B?bGZtQmtGM0srOUYwRllyMTFYc0dCdVk4disrRkw5SXhhMG5Fd1FtNkxkc1VI?=
 =?utf-8?B?NytXM25MTWJPb2xoOTJNT1Q1RGttdnViRWUvcnUrWWsrR25sT21SVGNWVkp1?=
 =?utf-8?B?VGZ4S25ycTdTdHc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SEgrdEpnbkdMT2tCdVhvMkxGOStOc2REYWlUQlhPRHd6T2U4RWpUSmtjVm16?=
 =?utf-8?B?WTVHdU03TzQxRld0dHVKVWxnZm9kRnhKbkljUCtXRkU3Mk1yV1U3azFUdERG?=
 =?utf-8?B?Nk5LS0o4RFJYdWNYcTBHT1UvMU9MMW9XQ01RYkRodWhYZTVhWE1xbXVWaTZq?=
 =?utf-8?B?RDNJd1ozODNiZ0ZYSXp0YXZZaGN5RmwxanpFN3pmcHZGcm9SMFE1M0ZweW9Z?=
 =?utf-8?B?ckVDOHcxRzVSUVAxOUpnKy9PN041SkVhSHF6SG45VEZpMTh0Nm1ZbHBMb2Z2?=
 =?utf-8?B?bUpBSC90RVEvcWwxa2RMZXpzbWN5WWliMkczS1ZiMzlLcmFjNjFNb1EyUG0x?=
 =?utf-8?B?dGJjNDhaY2NhcVFMZE9zUGdEclg0amJrU1ZYL09scFV6RGcxaGdvUUpSd2JB?=
 =?utf-8?B?RXN3MGdmc0hxMkdSejNoMmZMM0pGQ1phbGtqSWw4WU1BYlhxdC9mZVdHY2Za?=
 =?utf-8?B?NmVtMWZuQlJTcnIwWVA5R3NnTnNlQVdmRUpZdVYySEVpa0p0Sk8vaXd4YVpK?=
 =?utf-8?B?RUlQbFZJcHE4bW1ic0tZOHkvNThDdHpPM3ZpdU4xKy8yZEpxZ0tBRG5xVW1q?=
 =?utf-8?B?VmhtSEQvWGlTN2F2RzFxSGp4MWNIVW01QmhXRXZ3WTM3OWkxUEczcjJtQ0Yy?=
 =?utf-8?B?Si9mb0plSkJXM1NHL3EvMVZ0TDdzS3NkdU11b3JjbUptWWhreHB3ZGlISThI?=
 =?utf-8?B?c2FDVVZwNWFTODM1dldXa29kWkoyZGd2ZVk2Uk8yK0UrWVB5K0JOdUlWRlNp?=
 =?utf-8?B?c0ZsZzZ2TW04bGVpazZFc3YyU2tBeWtLR3Y3NUEyU1dZYWtNL1RSTXRmYTc3?=
 =?utf-8?B?ZHBxNmplUlVlVGs4R0t3MDIxcGhEc0poUjlsUy9VVmdXZ0x0T3o1RWd2TUY0?=
 =?utf-8?B?MDg2OGp4aHcvaFZLbzFURG1yN3pZc2VHT25aa1M1aWF6QlBjTmZQZUgxQlFJ?=
 =?utf-8?B?VUxza1RQZS9PZWRuQlJsdlhpb0xYSE9FbjhDNGh5YUpySUxPNXRIWjUzZ1J5?=
 =?utf-8?B?bExhNDNKaDZRYVU3SkhkemxpRUUwQkZKRHNiVnV1SEhxS3k4UmNsQXN5MFQ0?=
 =?utf-8?B?cWw0VzVJV0dkQmtDYzMzZCtaQVNoWGxCK2l4aGtvU0wwMEw0MjBzSDlZalVW?=
 =?utf-8?B?elRBZEdOSUxhYVdSVVA4V09ybjBTSFozMUJZOHhVbnhhWFJhbTFCQWNFeXo3?=
 =?utf-8?B?TVF3Y2s3OHcveG53K1huSGRSL211aHhHV1BLRklhM2MvdkhUSkwvTS9BMk5u?=
 =?utf-8?B?UHNkMVRYRll3U1dmK000dmFRWlJqcGdzOFVqQldIR1hNYnM3a1ZlSm1DMk9y?=
 =?utf-8?B?ZmtyNlZDMzQyL1diR3MydHJoTWhrbnB1blF3R2M3TVNaVTF0U21NZzJSRkla?=
 =?utf-8?B?c3V1YkxmWnY1TzUvb0M3S1U2NXk3RHhmekZNbmY2MmdldEw4QngyYVk1S1VW?=
 =?utf-8?B?czlXWmorZnhVR0hNdXhWTEdOR2tjVzY2Y3psNGFXT3l5YnVYNEFWWm16Tjcx?=
 =?utf-8?B?YThqT09FS1NuaVd4dWNaOGExRXZmWGJoYzBITitDUHhlLzRLbDVQTVBPdTNs?=
 =?utf-8?B?V3RMM203dUZqdkFsdG1TVndXM09BdXlyclB1YXRJQ2JHTUxyNHoyWktyZUpj?=
 =?utf-8?B?Y1hKVGVqcDJuV3N1ZUNyMzg5WTE1SHQyRnIzTnlJcU84OTdFc3REcHpIVFhH?=
 =?utf-8?B?TWRxaTNQZzROVWo3SU5pNWxpL0MwZ2tueTBZN2o5MU83WXdNMVV3Z0hIMndE?=
 =?utf-8?B?VjRjSlAyNFpGR1dRRTl2cEhHQjFram0vcm9nbHB2MG5VMkkwejBFa2szWStF?=
 =?utf-8?B?SFFZbUdlVnBLWkErVzNQNnhYMTVWT3ByN3NRdk1FWjNCcHliT0M4RitXZStP?=
 =?utf-8?Q?d/NdovYIbx5+C?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B4E4E4C3B713242BD461C1E5A4C2D3B@POLP291.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c70882-5890-4104-2231-08df47c0be70
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2026 11:15:26.3931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA0P291MB0123

SGkgQmpvcm4sCgpUaGFua3MgZm9yIHRoZSByZXZpZXcuCgpJIG1vdmVkIHRoZSBoZWxwZXIgZnVu
Y3Rpb25zIG5leHQgdG8gdGhlIGBwY2lfcG93ZXJfdGAgZGVmaW5pdGlvbnMsCmFzIHN1Z2dlc3Rl
ZC4KCkkgYWxzbyBjaGFuZ2VkIHRoZSBjb21wYXJpc29uIGhlbHBlciB0byB0YWtlIHR3byBgcGNp
X3Bvd2VyX3RgIHZhbHVlcwppbnN0ZWFkIG9mIGEgUE1DU1IgdmFsdWUgYW5kIGEgYHBjaV9wb3dl
cl90YC4KClJlZ2FyZGluZyB0aGUgX19iaXR3aXNlIGNvbXBhcmlzb25zLCBJIHJlbW92ZWQgYHBj
aV9wb3dlcl9ndCgpYCBhbmQgCmBwY2lfcG93ZXJfbHQoKWAuIFRoZSBjdXJyZW50IGNvbnZlcnNp
b25zIG9ubHkgbmVlZCBlcXVhbGl0eSBjb21wYXJpc29ucywKc28gSSBrZXB0IGBwY2lfcG93ZXJf
dF9lcSgpYC4KCkkgYWxzbyBzaW1wbGlmaWVkIHRoZSBjb3ZlciBsZXR0ZXIgdG8gaW5jbHVkZSBh
IGxpbmsgdG8gdGhlIHByZXZpb3VzCnZlcnNpb24uCgpUaGFua3MgZm9yIHRoZSBzdWdnZXN0aW9u
cy4KClJlZ2FyZHMsClTDvHJrZXIK
