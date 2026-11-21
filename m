Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795266759;
	b=IHLaZRSsBbLWzluJRqzmO2E6qUjwYZKd5nzYgBruDXCDWv5xonvdEJA+nmvj7Cf0hioc
	 D60LicA9/xPOOMe3ErEHlbYDB2cvfWT2f6OouSD6u0ljMG1DH51pONQwMYNTRq5tDlRDS
	 D6pGb8pDJP+FVO69+4DkwiPvqBTY1/aHhCMeLf2fWCpuNu//cZYKuy0sQQe/Sq11GJo8f
	 20N3nG+pRUcuGrGs9MHvcaNIvRpTGlt1mB50x5hquyDcxQaGe/IuQubHO0Or63fGa18Ud
	 rHegcsNtj4byj76H7XzeADVfWqWlLi9lvQf/s7TgEJZ87qDGWk3XHxum+V7Cn0f8okg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795266759;
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
	bh=aYxhWrKmXpQ6UGbDw83Ie76JUQI7tCmaDceRa5x7sCQ=;
	b=F+RG6y1JX9OLuHQSrpLlOYpkg/yLsAI2sCjQkUY3inLtLP5+uraGzU1DaJQihesn3trl
	 yGdnxK4+x/Rm7R0fH8/yh9zKzAxwHqMmUxBDveajlaXzHGOXKqNQiBKAPwN2gP36fqPnD
	 nuC2Phd4VmzND/NKLASAUYAVBbH7r4SlMh6shojs6LMz4fXKzwOCEFmqV+c62Ep0UbhKa
	 FKWWpbFHaAvyfyDb4IWih759aUmPkvN5TTj6lIOgVKCf9kc/ybhPHVCr0fz9++OzXbqz7
	 WxdIhlttEOsbMfPs962v4bcnN+WatxcNZto7VlhabQmdPJvDG/wnTCwNz2ZjaoIWfEA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=s1BCeYIV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.23
Received: from WA1P291CU004.outbound.protection.outlook.com (mail-polandcentralazolkn19010023.outbound.protection.outlook.com [52.103.53.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CE3606A33A;
	Sat, 21 Nov 2026 13:12:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51CE3606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=s1BCeYIV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B/2ZevWNytEyofbPpKuD3uOkEQW8HR1TM0e0NokJpoY3b6nf9CSKfRNv6UyyDIgl+i4N5xgH7dJ6yo56ZV/D9y3DJWOXfN61Zb9e7PFaHgfgH6laXVqCra+00APlHVpN1q5sNPTrCbvjpdJD0qwjqyH/3nXMDyY3nHFDhwhNb3dpNAavelCvxsdNhOSRh9NcA9q15BM82yH2HcejoeruKaN37jkAQP9cDWp0DagsSa+INJZWGNHXq8kKgfCsI2p/+yZGxCJ0wE8YvLBL8YwlSFWJ3OiHIykwyDQW4h6Hib7pBiew/A3JBhw/l/YVoCOLGRPZOcKlToo3sjTjo/K/7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYxhWrKmXpQ6UGbDw83Ie76JUQI7tCmaDceRa5x7sCQ=;
 b=QYJh1QxEUOSZ8dQi093RN/dYmwc3nFg0VXGog2q9j7XsGxBSIlBIKatLwxy3sOs4vDN1KGBoYRO73WMWACCrzWOlFJ5yslBlzKDQpxvLrLUyccQ7Sdj6/WYVH5LZT2bDA2G8l1tzKk1DElN7fPA4kEIOrftxWUI3/xee6Z2yMG+1NUajlSA19w7B2QCh9EJq5eoMV8xPToFr+yDJXGxQYoZdJe5jXdkVNgT+i0y/KKZcyT66PrYha1MqKt7eOnMTXRyv/h1aZq6qpb2v900YxxAXe4aKkSA6AYzrcjm0moUUZowKmx1SkmFf9aOYjh86LsaeFmMCPC5jJrt+w2UHOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYxhWrKmXpQ6UGbDw83Ie76JUQI7tCmaDceRa5x7sCQ=;
 b=s1BCeYIVuohcHobmUwSkQXTjNi2Z+AH0WFfhUB4wEKYuGjxOaSiH3/qtOWRyhM4pAFNEy6h94c17oY4FNuTeLMmnYuQ33DjIrQTxqKfFTcFddPBSoefsNlub/aJ5xGRnFreBB4zYBIDbyRYqodYRLDH0FIEPQlEcUsalUK6RXTHq3/r9cgPg+T5oW7hPKNK4Pmr7FQaFoVckUwXMRLbr1Osn+aQxUKxMPFXCJ7F/a6C/0V4Oi5D1RHbne7IWUlvdf2sb0w/Gy7Xvg38n46IKquo740WP+WZI45bjdFMzcZskRU+MLN/NS+ri0cHnyUp40UwLJv33KxukJ4eFAJ/Dng==
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:26::11)
 by WA0P291MB0097.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:5::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.13; Sat, 21 Nov 2026 13:12:37 +0000
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404]) by WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404%6]) with mapi id 15.21.0639.011; Sat, 21 Nov 2026
 13:12:37 +0000
From: =?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?= <habilerenturker@hotmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "H . Peter Anvin" <hpa@zytor.com>, "andriy.shevchenko@intel.com"
	<andriy.shevchenko@intel.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?=
	<habilerenturker@hotmail.com>
Subject: [PATCH v4 4/4] x86/quirks: Use pci_power_t_eq() in
 apple_airport_reset()
Thread-Topic: [PATCH v4 4/4] x86/quirks: Use pci_power_t_eq() in
 apple_airport_reset()
Thread-Index: AQHdebn6yDwj/cmZUUaPOrIHJV/j/Q==
Date: Sat, 21 Nov 2026 13:12:37 +0000
Message-ID: <20261121130936.53191-6-habilerenturker@hotmail.com>
References: <20261121130936.53191-2-habilerenturker@hotmail.com>
In-Reply-To: <20261121130936.53191-2-habilerenturker@hotmail.com>
Accept-Language: tr-TR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: WA2P291MB0187:EE_|WA0P291MB0097:EE_
x-ms-office365-filtering-correlation-id: f966d588-b53b-4847-8053-08df47d11d21
x-microsoft-antispam:
 BCL:0;ARA:14566002|38102599003|41001999006|15080799012|8062599012|8060799015|19110799012|21061999006|31061999003|2604032031799003|12121999013|55001999006|24021099003|16051099003|25010399006|51005399006|102099032|440099028|3412199025|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?enU1V3B4UDNxeHlobTBkNmJDNkV1Y09GTDViOXVvMTU1bVEyY3hKQ1MyYzlH?=
 =?utf-8?B?bFVpaDZtbWRhdGFDRFZOTWhoY2xsSWM1QVdJVTRlcUs5SXZML1B6bG9uc0c4?=
 =?utf-8?B?ZE1jbTlna2xiUnhIb2xqeVYrOGhTVCtNd1IydklEVGRPM2E3K1JVaUVCcTF0?=
 =?utf-8?B?T050TTkzdTF2VXRWQmxYNXNWYmdRSmdMWlVWSk5yaVJIekRncmhKeTZjZkw2?=
 =?utf-8?B?b0ZLYXlnTklaQXIxeGZFanZLdERvL2dNalBndEhvaVpEN29YUXhVaEVzdmhF?=
 =?utf-8?B?b0xLTVQ2OHpqbmhpNDdOeU12OU12NmhURWNSYUNlOGtzYTRydTJLUWxQSlpH?=
 =?utf-8?B?cGMzTm5xVGZGdEFDZzlvNGxzY2lhazFEZENSU2RZQ0IvV282VVFyRVFRdDFt?=
 =?utf-8?B?amN0SkErcWp5bVVXa3RqRyt5R2FSRmNjMzdmckRBeEhBQUtyeTZrWnhzYUlC?=
 =?utf-8?B?aDZ3MWNwY2l6S3JDbytxaG85akYwVGVOWDZmOEpzczM0L2JUbmFKcnNvV1hG?=
 =?utf-8?B?UldueUJzUForNFc4YzVPbmJ6VXE2RjhzZHV0SG9BTWhWc3hkZkNya1JjcjB0?=
 =?utf-8?B?UVZZT0ZkeU1ZMkhuT2JyaVI1emRQdXdWV0FnazV5dHBiMTY2YTZTZDIyYXJk?=
 =?utf-8?B?Ry8vMzcwZHFCcmdJb2xJb01adk96dWVyeGtEVkY5ajNRWmhqTnp6Qk9BRm1T?=
 =?utf-8?B?S1BvSlA0NE9xak1TR0JGZG5jSG9BemZGSW1Obkt2MmZaN0pZM3FSNUFvYzYy?=
 =?utf-8?B?OHN3NTYzL1RibTByNm5IWVZyeW5lU2dVRlFzR1h2SFg1Y0wwR3FjbndlRHNq?=
 =?utf-8?B?cmtHdFJjN0duL3o0bzZwTTRNbisyQVZ4ZDlOalBzN0VTdnpXQmN5U2lpczJP?=
 =?utf-8?B?akZwRjlNMTBway9wNE1OOWpZcVFDajVCWnQxanU2NGc1Q0NObHpheVlEaWEy?=
 =?utf-8?B?OW9QeHNocjQvUlo5ZGlNVm43a1Nic2krc1NGSTd4TmpYOVc3VXhRNGZJVFgz?=
 =?utf-8?B?bmxQZy9FVy9IVkdOQlVpQS94anhlRkQ3QmxHem1kaDU5d2lYOFVxRjVobGxB?=
 =?utf-8?B?Y2dTV2p2R1cyVnNsNk55T0hlZkx4UWpFbFcrbmtSR1BUbXQ0L0lXWG5ySHdm?=
 =?utf-8?B?b2NuUDZXdzFGTDhQWWJXRnBqYmFOaThjaS92Wk84R0Z2M3ZJRXZQdFJZaVpZ?=
 =?utf-8?B?TjJ1VGRRbUQ1ejRWeUNhWmlLZUFQSW0yVk9CclBBeHN4SkhweFFYWWdkd1ZD?=
 =?utf-8?B?VG1Wbm12RnFtakx5T2RhSTJvL2lBeGNuU0ZVTWt1K1dmZnBlRjNCd25Nck42?=
 =?utf-8?B?Q2NoVXI2aHhnV05Ndy9vN1BmMDN3ZmJMM2d6eUNFVWhPV1ZndHpEMks2Y0o5?=
 =?utf-8?B?ZEoxeVFSMGJyYkM1ZzZzamRCTFVLcm5LUFFaS2w5elJGTmlya3hhS2ZWMmVP?=
 =?utf-8?B?K3FiNVpSWUxYYzNIbGFYbjV3MEYyRDJ2aHZ2bFZRUzRuUENRNC81dDRBbWRT?=
 =?utf-8?B?OUNaeFlrMllIZ3ZCZFZtczBmTkptSzIyaXdneVprYVhuWjJVMUtsZGdGM2l1?=
 =?utf-8?Q?3lqFZgO1cKozE0iyYLuiHR/I6g/HFQsMKt+fn7LkmHlkQG?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U25TRDRGRzk4NTB0dGdVbkJ6VGJMWXlsOVFYZG9QenhRbHZkckFud1RIemEz?=
 =?utf-8?B?LysyNVlzWVRBbGZlOFh4T3pXM0JUM0ZIVE9TVkN4VTBVYmVOWHVQYzY4eU0v?=
 =?utf-8?B?TXFTclZsSThwbG5RbUJ5ajJaUkZMZS9heWpyMmtiazZsSk9neTJsRFF1ME1F?=
 =?utf-8?B?WVBNL0lQSmZlOUU4UkJBU2ZMNjlQbTVuc3Q2d2pmZ1R2N3k3VDQ2anI1Z2I2?=
 =?utf-8?B?aDZpWktEMzhZOUw3TGdycGVWbzJ4dEhwNHZwS2dIL1RGc0xXUkpGRUJIQ1Jo?=
 =?utf-8?B?Qm1TWjRFaDJtUlVGOGpnbUYvOUE1VktLcml4b1hTMUJDLzNmblNFd1h3emJy?=
 =?utf-8?B?TWtoQ0FGR2xZZEdvRU1JZkVqd0pwOXdTS1d6a1JKOG13blp0ZFBKd2Z4bHQw?=
 =?utf-8?B?RGZmdlFXQUZIUFdFa1A1UHJWU2E0Tkw3UU1lQVRucjhTS0NKd05XaThLZ1hI?=
 =?utf-8?B?ZEdIVHNwZUNScmp1TFhXbmtVd1dLRDQxcmFoTTA5SERVbmtOMkE1bjVPSjB3?=
 =?utf-8?B?SnhGUXVpK1RIS1BQY3JLcVhiWWRCcWpXbjRRNm1VTmtGUXRQcXhuQmhkM2x1?=
 =?utf-8?B?ZHl6dEZITTROdmFkUHJPZXhXVWh5TlJqNGRSRS9zdzl5RlRYcmVKUkFqdE9H?=
 =?utf-8?B?TmtmY0QrOGJORm9yS3BQMTlnQURyTS80TTFXVmlmVzhBeXozZHNrM3pXMGJI?=
 =?utf-8?B?SVByekRzL1hGWllicVlTTllPcmllU1E2eTN4cEtBS254ZzkzelNObjk5YUlS?=
 =?utf-8?B?aUdNek13WFJqbHpydUdjb0VQZVdkNEJiVExWQnZCbWkrR2hoK2tURW9RSk9D?=
 =?utf-8?B?N2huWXpCdlk1SFJHeEpueDFtbFkwMDYyalhxRlpyZjdEeWpNRUZPdlllYmpw?=
 =?utf-8?B?WmdJOEFkbDdQQzAyeit0VVZKWDVZZkhoaDdKRDJIM3Vsbk5GSkFlMWhOSlpj?=
 =?utf-8?B?Z1l1S1N4KzVUSXZ2NU5kbHVtSm9seGhZRzFNUjhPa01zNTRsVEJwbFdxMmVJ?=
 =?utf-8?B?MDUyTzl1YktrQWlWUlh0bnBaZk80RCt0aVQ3NzZnVVZKcmZ3TnJhZzJmeUdX?=
 =?utf-8?B?dDhvNVVQQ3ZpMlFlbndqUFJqUjBvMnBCcTROUVVvRUhFQ0xYV0pMeVpWRUVz?=
 =?utf-8?B?aTFncnhlbXhZc0VOU2tKUnA4QzR5eEx3NXEwdWJvVVV6anl6VWRETURObzVY?=
 =?utf-8?B?dmlwNEo1TmxSWnEwSk1qdUtNaVZCTTByUndweWVaNXdRZTc1cW5ZZ01CbmFW?=
 =?utf-8?B?cGN5TmVkNDB0aXEra3RXcFgyRzFjdnBFcm5FR1dIR1VTYkFHTXhBU21rSUFU?=
 =?utf-8?B?aFAxbkh5SWErTWI4OUp6S1ZNT3lVU0Z0SEd4ei9Wb3BGMXBxNEZ4cng5ek94?=
 =?utf-8?B?WXJXblh4TjlNdWRDdmwzcDhDdVkzZXp0Njg5eEhkbnVkVWRHZ0NKMm0xYStQ?=
 =?utf-8?B?YlpOZHVOTTJ0OWtMTy96SzdNZ05ScHkxNnFQellHUGRUa1ljd1d0ckRzbGlP?=
 =?utf-8?B?SmduelQ0TUlJWDBwLzJILzRnMGxGRGdiZnYvd3BTV0JLNjlYamtScTdkV2I5?=
 =?utf-8?B?R2FMU3FHZUw5dTlGUFpZZllIWkc5VDRQSVl3WlUxRmllbGVLcGNJZFVtSnR3?=
 =?utf-8?B?dmhLYmswREZvNnhobW4vdGZ1bGcwckE4M0ttN29ZaE81RGxVYnJBanYrYUxU?=
 =?utf-8?B?UG1lQzc1RVFEQ3ZmV2wyRVRPTGlvbXROY1hWUVhpT2JwQXdTRmxvMHM0T3FR?=
 =?utf-8?B?cUE2Z3ErbUcwOUtidmxjKzVzdVo1Qm50bldiM2lpWVB5S0cvQlB1UFRVZ2t6?=
 =?utf-8?B?djMzYXJESS9rT0VPZmRGS2NUUHZ0NXM2QnA0azV0Mlk5d3NMejlCN2ludWlu?=
 =?utf-8?Q?PzbYZ5wOWoVIb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1718EDFCF2DC647A5FC2E2DDFBF5C4B@POLP291.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f966d588-b53b-4847-8053-08df47d11d21
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2026 13:12:37.1786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA0P291MB0097

VXNlIHBjaV9wb3dlcl90X2VxKCkgdG8gY2hlY2sgdGhlIFBDSSBwb3dlciBzdGF0ZSBpbiB0aGUK
QXBwbGUgQWlycG9ydCByZXNldCBxdWlyay4KClJlc29sdmVkIFNwYXJzZSB3YXJuaW5nczoKCi0g
YXJjaC94ODYva2VybmVsL2Vhcmx5LXF1aXJrcy5jIDogd2FybmluZzogcmVzdHJpY3RlZCBwY2lf
cG93ZXJfdAogIGRlZ3JhZGVzIHRvIGludGVnZXIgKDIgd2FybmluZ3MpCgpTaWduZWQtb2ZmLWJ5
OiBIYWJpbCBFcmVuIFTDvHJrZXIgPGhhYmlsZXJlbnR1cmtlckBob3RtYWlsLmNvbT4KLS0tCiBh
cmNoL3g4Ni9rZXJuZWwvZWFybHktcXVpcmtzLmMgfCA2ICsrKy0tLQogMSBmaWxlIGNoYW5nZWQs
IDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9r
ZXJuZWwvZWFybHktcXVpcmtzLmMgYi9hcmNoL3g4Ni9rZXJuZWwvZWFybHktcXVpcmtzLmMKaW5k
ZXggNzQ1OWEwNzNjNzRkLi5iMTBhNzNmYjRiY2QgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2tlcm5l
bC9lYXJseS1xdWlya3MuYworKysgYi9hcmNoL3g4Ni9rZXJuZWwvZWFybHktcXVpcmtzLmMKQEAg
LTY0NCwxMyArNjQ0LDEzIEBAIHN0YXRpYyB2b2lkIF9faW5pdCBhcHBsZV9haXJwb3J0X3Jlc2V0
KGludCBidXMsIGludCBzbG90LCBpbnQgZnVuYykKIAkvKiBDYXJkIG1heSBoYXZlIGJlZW4gcHV0
IGludG8gUENJX0QzaG90IGJ5IGdydWIgcXVpcmsgKi8KIAlwbWNzciA9IHJlYWRfcGNpX2NvbmZp
Z18xNihidXMsIHNsb3QsIGZ1bmMsIEJDTTQzMzFfUE1fQ0FQICsgUENJX1BNX0NUUkwpOwogCi0J
aWYgKChwbWNzciAmIFBDSV9QTV9DVFJMX1NUQVRFX01BU0spICE9IChfX2ZvcmNlIHUxNilQQ0lf
RDApIHsKLQkJcG1jc3IgJj0gflBDSV9QTV9DVFJMX1NUQVRFX01BU0s7CisJaWYgKCFwY2lfcG93
ZXJfdF9lcShwY2lfcG93ZXJfdF9nZXQocG1jc3IpLCBQQ0lfRDApKSB7CisJCXBjaV9wb3dlcl90
X3NldCgmcG1jc3IsIFBDSV9EMCk7CiAJCXdyaXRlX3BjaV9jb25maWdfMTYoYnVzLCBzbG90LCBm
dW5jLCBCQ000MzMxX1BNX0NBUCArIFBDSV9QTV9DVFJMLCBwbWNzcik7CiAJCW1kZWxheSgxMCk7
CiAKIAkJcG1jc3IgPSByZWFkX3BjaV9jb25maWdfMTYoYnVzLCBzbG90LCBmdW5jLCBCQ000MzMx
X1BNX0NBUCArIFBDSV9QTV9DVFJMKTsKLQkJaWYgKChwbWNzciAmIFBDSV9QTV9DVFJMX1NUQVRF
X01BU0spICE9IChfX2ZvcmNlIHUxNilQQ0lfRDApIHsKKwkJaWYgKCFwY2lfcG93ZXJfdF9lcShw
Y2lfcG93ZXJfdF9nZXQocG1jc3IpLCBQQ0lfRDApKSB7CiAJCQlwcl9lcnIoInBjaSAwMDAwOiUw
Mng6JTAyeC4lZDogQ2Fubm90IHBvd2VyIHVwIEFwcGxlIEFpclBvcnQgY2FyZFxuIiwKIAkJCSAg
ICAgICBidXMsIHNsb3QsIGZ1bmMpOwogCQkJcmV0dXJuOwotLSAKMi40Ny4zCgo=
