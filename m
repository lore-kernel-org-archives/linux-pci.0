Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.74
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795018567;
	b=J8BoQOH4PQenogV0n0PqquE/yx+DoT/6TLZYSXzOPAPGqF43tr3/ENRyNfHGZ1JpcbhE
	 M1A7P/ltNtmZdIzxKvlsml/v9o0ADtrzTR8R0sOubAp4TuxuslU8q+h3eIPcOasO2osGr
	 C+H0KzgOijF55+hsKT05GhrK95zJDAA3Ucri2ffUJsQK8EUeplZAfVPUdAdcetiynrWLg
	 ObLTr8vYRGoIteKkYWYNuWLh8ak6fYcsKyjPgSSyO+ZBovQM5pZbETfDKcvZag+mVxO5I
	 soXqu1AdlSnVNDtGhMdvSQ+QEExFQ+PMvJ4nKA6JiQi0qPeNEseLwYAyeTwbaVis/GA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795018567;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
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
	bh=CSnc3Hzdp1RbJjtIEpciCHmm/h80Wg591v1To/HFSL0=;
	b=qvHWtD8sq/TFWkL+L3xi9R+G0OnaNJ/a6lZNq4flAeDuCznu/5KmQcbWkh7a0MtB+imq
	 RK9m0IgdoNwdPQurlUQo31RjitImDvZHVIbFpOdBqRtKNoNJMdBMFDSseY2GWe1ZHNd7p
	 sD5XSmLZHFKpxKEq8cG4UfjyUCDjfMXAzeWS+rjZXBhceu4NDzcSjVS0ZcB6q1YbOCLKD
	 +Ie/rHHWXZpOBQkdLPwo+OhH/RRyKSwnaQNIGPHw4eK6lBgXceEa/0oaNJj2ayS8jkVp9
	 rh3coqN+BomRuBWLV1btSmXYM0dsjo4m+R+wN5Wgm1Krqj//pQd4hu5/Orauxgn6z1Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=YEoK4w21;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.74
Received: from WA0P291CU002.outbound.protection.outlook.com (mail-polandcentralazolkn19013074.outbound.protection.outlook.com [52.103.53.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4C4606A32F;
	Wed, 18 Nov 2026 16:16:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B4C4606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=YEoK4w21
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MedhVwcj+xxfnEGDmqLhVI2lPr9nb3l9t3gESQK0LCrlso04NTZ/5cz94hXn0lVF9/Ih4y0BzvLKq4lvhk8xzs6bXLUzYeCw02dFmMF0+y5iEeOKmJnCSNOAlK9HxVj7D518w2yh5euSJ52Byzm6IvcsR6qqewAAqUZv1SvcP7dW6amN1c1fS//YDF/DBOuXd5evhrAc5q2+BWojVDCreRkVGGaPdvgomh7x3aMhWMSXgT/iVF9NwgXyF5jwSFVNUXvxdMhIkAciA11cS5nq4XpdrAlIS8yfUQCTEP7HqCcm0XVQN+Au/4wBAZxT1OVzcVg6mDhwnrpHaiQj9Z56Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSnc3Hzdp1RbJjtIEpciCHmm/h80Wg591v1To/HFSL0=;
 b=vUJn0GF3F/mvB97N73fruLWLmYQztYUIxk+jEM5X2xuqbkgcZpPYx1GBLkJv3Bl3qirAsrPfGbUmp3IdJ6IBQzK+lZnVa96ftKu/l7TMF7Wy0ee7SKoT1/IVOoDcekBulmbA5+HPYcqTu1W3l62WADEjUncUVQHzP6TqeocPhmK7mngBw7ivkxInBququUt/MEEkZU/eU4hydFuMwNG2n5S0n6Bhb43vwE5ysSMK7+SwvSFhaZEsp/WCFjFH7/E9oW9wllZzlRkAJT96aZD2eeNbaF6hRPySofnxfXJF/BtpL+i3XsmQO/Sf0YJHtZuKwyoyXT0HX5VlFMZcfcys2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSnc3Hzdp1RbJjtIEpciCHmm/h80Wg591v1To/HFSL0=;
 b=YEoK4w21WZ/Q9k/WrRVRP8A+gQTQWldULhBSuXsPCg6ojEUYd8KxLselMtqGU4DVxz3GG8lFluwh06meydPnBTSSwbLncp/meWv1TcfdD75EmLLS/XfVdYD5EQoOI8Iuw8MUIb518YdTtmCL3VOiXpmoK6t0kMHwf0uthgMhTtR19Voce6W5duUhb4y5YFildqGYEHMxLe5f4eizvzHP8jQNgnloVUDEQqVdXVXLBsW8yR4P1tONCfv6z2UxIlLRWYA07GEfGTBVsHyZF3VjgPs3nBJOr5pwQJiUqgrWtFdoTeHsfQPcUX+LOjScaJ2OdG5vqNCCw5huMVIQrbj1qw==
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:26::11)
 by WA1P291MB0300.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 16:16:03 +0000
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404]) by WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 16:16:03 +0000
From: =?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?= <habilerenturker@hotmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "H . Peter Anvin" <hpa@zytor.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?=
	<habilerenturker@hotmail.com>
Subject: [PATCH] x86/quirks: Cast PCI_D0 to u16 in apple_airport_reset()
Thread-Topic: [PATCH] x86/quirks: Cast PCI_D0 to u16 in apple_airport_reset()
Thread-Index: AQHdd3gbW+1bmUjs5E6RWZ8qpfDQtg==
Date: Wed, 18 Nov 2026 16:16:03 +0000
Message-ID: <20261118161559.63617-1-habilerenturker@hotmail.com>
Accept-Language: tr-TR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: WA2P291MB0187:EE_|WA1P291MB0300:EE_
x-ms-office365-filtering-correlation-id: 4255f41d-da32-448d-c4ba-08df458f3e3d
x-ms-exchange-slblob-mailprops:
 iS5pQZgsAQDZd5pLvsexcGXRgbvG27NWKnC5mPafDOxDgfEMsz1tJ4l5RtyJ68UrToHgbj18jDgUwSdFIftp0ss602AscbS9jBkjuui4v71eJu13/frWoLPbFQJTncNydBOORCzzy3r7OIrRxTplJxVc1ydpequNP2CMNIofIokQVgJCvG1XPzJVRctLMJCIz01iihuHl/5spsF63oDLzFeOApHz4g9FiVibqBSAo72YMem32BV2mIzNoGcI1IFN4D2OcjHwVkMaNfxybxGjVn8THo/lcp0QT0n7KvNcSnKRbt8izI2/hkoiiSmYmhNlVI42sz7f6/U9lJLcUzYBVDRBo3vqigO6IHL8bBXKN4yALSyGhZmUjhqc4xRyVwEK/HNYdKYOy285co7AQCo+b5yHX7ufBLUnhMi3wVaVA3+kqljOgtalyKVhcNvlg7xw8JEjWLJw8BaWtGbshFCD7Wj5fYPmsNk+TxzoU+BUY9z9/56jlU5A9UNkFNAw6K25HA5CSAK6+YCrw8lm759874E7Jc17DUWU3CmbC0GUzlRIdxKOvd5rU7iro35h4mhFYlCg7VGgMTP9gmnCWltjidp/YvwhKJS/erHKhYt77on0RfzAEIrPs2xtAmdNYH795yjzcRNfgEkBxey4FAy1lyQX7Jgm7yFufoaJOEfDpqF7BdsUw5amvAvStQuz1R/3bRXw7m+al5bLktG0T0ZjMwQ8iHG+/A7c7qVow9iiNh6xYkO8sqTB1TipE72upP+wBEYdPFEcOBtHEofVEQ+YBD4+SxOSs+6+jQDW4q34/RaLM3t1jokp/Xj8nv+kTawI
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|19110799012|4140399003|25010399006|51005399006|8060799015|55001999006|8062599012|24021099003|15080799012|38102599003|21061999006|41001999006|40105399003|102099032|3412199025|440099028|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?WmJVdGF3ZW5WTkszQlpQM2lvdFR1RU94Z2ltaWZQR3NQL0EyVzBncm5uakZu?=
 =?utf-8?B?dUZEYituUi9sQjh3WjVDYWZQMjAzd3BXWC8yN1ZVcTRqR1NmalpkQXRUUTA3?=
 =?utf-8?B?VkhyQ2dVMWxlYXpMQnZadG4xdk1Jc0gzT3VXblgzTlpBcUlhUGZKdGk0dDMw?=
 =?utf-8?B?VklxUXNCN1BmTG9TeHlVd2RsL0RvQU1IRGltN3NLb2FZcjVUV1drdHVSWW90?=
 =?utf-8?B?MGljdXpxUkp1YWxrUGZGaUlRVUt1bTJHSlZDdzcycERDOURQRlVGUitJbCta?=
 =?utf-8?B?U0pNRWx6ZHFVdzA2dllNL3NHUDFBdTlXMnNWcHhuOEUxR2lNU2hTMGtZTE4z?=
 =?utf-8?B?K2JzSmx5cUlFbldMQTIrNWRNQkZ5T1VySFVOdHF3N0F2ajYyekhjaUgyTkhN?=
 =?utf-8?B?ZFJaSkR0L0ZzcjhYMVgySHFvVnBhUjJBK0NvellSZWZBRDA4RVlnc0NFTW1U?=
 =?utf-8?B?ZTIxRXdjZjVNZXZFdTFMaXRmT2RYTm5TTU9NYVlzamhUQTRUbHVxbGNGK01y?=
 =?utf-8?B?WVA4ajE3eEJWRjMzQVN3dkRBL1oxMVdRK3UvZWhCcklKWmp0amJaVy9MMlpX?=
 =?utf-8?B?dmRHaGtsZzk1K1ZmVVl4WlZtR1l4TU5iMWtWRTMzdTFCNXZScmZJdW5FL2xu?=
 =?utf-8?B?NDBjM1JERWVyeXZlZm84MXljclc0SFR6NnV5NHYzVjdpeGhUTzc2U2Z2MWpW?=
 =?utf-8?B?YXpUbWNzMkJMTHhpOXBEUjZvRlZRdjBJRS9KOFpVa1RiR0xsNEpDRXVjYzBo?=
 =?utf-8?B?YmxsNlpsQUVPdUJ2Yjc3UUpwK2dGc2hzVzJMZkhyVmN1UXFWYVA4LzhuT1Zh?=
 =?utf-8?B?V2FuMlFINm8zNXRFcFFXeng5akN2dE1PUDNEamdCZ0xyYitIUmdZdlZDeG5K?=
 =?utf-8?B?R0RvMGlDWXV2aG50MTQ5SnlMVlM1dDdTaHUxcXBqc3BaT01CeUxRaWt4aTA0?=
 =?utf-8?B?YmlqSjVnd3p2OGZXZzhDNEpnaXhZS2JFQXR2MHpuWlhGN0NNbkhzdWxhRE5X?=
 =?utf-8?B?Y3NnUGl0NVoyTnRSNmZqbGFxTGdkTEY2WG5hVG5EVDlhZ0lweENncnJCSlNa?=
 =?utf-8?B?M0tjVC9sWVZjNlZDRHl4Z2xlN1NxaTFiZFlsSWlON2NYRithWW5qVEEzWnlu?=
 =?utf-8?B?RnBKNlhCMVhXazJwajlaUEg0MTFpa0NJUnBkbG5nT1ZzUVZwcXU3SVBuK2RT?=
 =?utf-8?B?NTV4Rnd0RkNkdEpNeWI3Y044eC9jdDlKS0JnMXkyTFRmckFLaVR0bU95YXAx?=
 =?utf-8?B?Mm9UeTFsRENBb2I4VzkvOTFPYnAwbi9PUW1lcXZkWjNiV1Vkd0d4eHRaM1U5?=
 =?utf-8?B?RXRqaVhRdVhzM2VTZnljRUx5d0JTZFpSZFpnUk5rWm5TUFl6Vm1RWjVFeUx0?=
 =?utf-8?B?RUU3dVhXdnYxSTlQcCtvKzJsbFV3UUlKalkxWUwyemk5Rmx1MW9ZbFlnQWM0?=
 =?utf-8?B?cGlwR0k5SGtteGVkUElsWVllQlN1TkFlNG9jS2lBPT0=?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?anBKYmZveWhJUXRHdFpnRW5Mc2RvakJyM3RkMmd0dWFZQW5xTmQzN2FMQklK?=
 =?utf-8?B?MlVXSDYrWGlXc1k2RzJaaTJ6cVpEdmdoaGx1LzhxQUlDakJEeUJveE42Y3ZJ?=
 =?utf-8?B?RTI3L0pwUURsTDJwbFBTd0pDdmNvOWVpRnlNUGQ3czQ1SHNWd0lHQzlSYWhE?=
 =?utf-8?B?Vy9JVVFRR3dvZ1hpSnJyNHkzdXBwWWxmaHExeW93RWFubFdQbHJhclJZUlEw?=
 =?utf-8?B?d1ozVUZ2VTR0bW1nUW5qOERZU2pKRDVhQlZHZ0NtK0xkZ0J4L0dMckFFUitM?=
 =?utf-8?B?NVFYNWdIRm1mcmFwQUVyOEdVejlLeStpbmN0OENwUEYxeXZta3d2cC9Ga0hJ?=
 =?utf-8?B?cUFIVVBRamVLaFBRcUNZcStSOTZTa3drUm9oTVE2UkRyeTErU1B3QzZvc05P?=
 =?utf-8?B?bnppQ0VZeE02UzJvbXNvbmZRK3M5eGF2MmtSWWs0WngxeUNjZ2pGeitIK1J4?=
 =?utf-8?B?UzM4dlNIRlpZM2xrQ3lWbUFNMUNlRFBVakQ4Z2h1Z005ME5lb095N2NtckZQ?=
 =?utf-8?B?NnFKaHBYL3FCZTNJVlRlaUFiTmE1a2NIM0NDV0tWVWMzWVlnYVQ0TzBqcXo4?=
 =?utf-8?B?T28rZVBLUEJqak9EQ3o5bWlvU0dOZGNjOXp3SXN3c253eG1YcmppcjVoTTJu?=
 =?utf-8?B?NEJSMTQzN1FydHg3ZmhmTVdrUEo2cnIwcEVXTkNreEpQTm14OCtDMEdwaTRO?=
 =?utf-8?B?T2x6cEdxZWFhNTUzY3ZRejB2L3JOUnFjb296LzBadloyYkQzNVprYzM3NUI0?=
 =?utf-8?B?c05uWjhpNFo4WHNRWDlhK2t0UmZDQzNxbWMycDF3YW9YNDQvYjdNSitrc0RB?=
 =?utf-8?B?THRWU0RhekhFeUo2cmFOSzJYMHA2MW9lQTF1dnBrSjNyUXhTUnhkSVBMSVI1?=
 =?utf-8?B?NURBQXhGTDlSM3BidVlBMFV5WkdTNjhDalppWVNVeGJRNzFaQXh6cWxyeU9T?=
 =?utf-8?B?bmthQXZyMjdrSkMydCtJQW1pNWorU3VzeEFlQm9wSm16bkdFRzZpZ1Nqck1t?=
 =?utf-8?B?VU9SejlpMG9OVkVTS245Q1dNcXpiMUF6WklKaWdOcXUyQm8xOHZrZWlVMzI5?=
 =?utf-8?B?cm10TG1wQ3UzcWdzWGt1SDA2bzJwTVh0TVJSNFplM3VyUGhBT0RvblFDc242?=
 =?utf-8?B?b294Q0htdGFtdmZteGgzLzlWV0pZL1dwUGNVNVMvQVl2UFA0dkRxNUo0UUtl?=
 =?utf-8?B?YUwwNzJqODE0M3N1WXFMNFZOYTZkKzVkanpyWEFVa212VGtiSlpGdHdQaTV6?=
 =?utf-8?B?ZzBWNE9xNDdOVWsrdUhuWHpGZ2Z6eEJGcWNyQWVBRStnU29xSnVMMmwzb1Zv?=
 =?utf-8?B?emx3a2JiYzN3OVJjYWRzUVhXK0p4a1Vqc3dWVGdDQ1ZER0ZjK1J5RG1ybjhS?=
 =?utf-8?B?TEYwRTVNejJtNHFldTdaZGxLbVUwZFBUamNEUDg0cG15Y2dDSDA4eHZ1T0V3?=
 =?utf-8?B?ZiswQWxER0QyZGcwVFFaMnFCYVBzKzdqZ0RmVGtHZG1PTnJ1eklUclNyZU9U?=
 =?utf-8?B?QmIvSDdLNzdWeWNkTWdIdnFkVTV6Rmt1aEVpMVRkZFZzZys4VGVEMEFVRjZD?=
 =?utf-8?B?bFZNVkVJdXV2Z2VJeVN0Q0FUUklEYjJreUtTT2MrSkwrRTdBaWhCS2hsbTBJ?=
 =?utf-8?B?TFlNc29aNlJRSHVBZG5nS0lhdUZWTGZJR3NrL0JjRmpYRmRoc3V3ODh6MWNJ?=
 =?utf-8?B?RGtuTWJRYzhpNzFZcUduOXZDRHNZU2lvOHBnSVVmNTB0UXZxamJ3ZzlUU2JV?=
 =?utf-8?B?a2R2L21QV3Z0aTE3ZWNwdWgyb3RYcDhVWG1DZjdDN2tPeXJqaEF6U01aVWZx?=
 =?utf-8?B?cVV4YTRJNzFQenUwTGZDNVdNSEJsOXdsbU5sVHdmL2QxTS8zNFJkLzh2Rnd1?=
 =?utf-8?Q?IM1KDrdjA8FVA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA43C829C3F6D042B6175428DC10429C@POLP291.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4255f41d-da32-448d-c4ba-08df458f3e3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 16:16:03.6366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA1P291MB0300

UENJX0QwIGlzIGRlZmluZWQgYXMgcGNpX3Bvd2VyX3QsIHdoZXJlYXMgcG1jc3IgJiBQQ0lfUE1f
Q1RSTF9TVEFURV9NQVNLCmV2YWx1YXRlcyB0byBhIHUxNiBpbnRlZ2VyLgoKVGhpcyBjYXVzZXMg
U3BhcnNlIChtYWtlIEM9MSkgdG8gcmVwb3J0OgogICAgICAgIHdhcm5pbmc6IHJlc3RyaWN0ZWQg
cGNpX3Bvd2VyX3QgZGVncmFkZXMgdG8gaW50ZWdlcgoKQWRkIChfX2ZvcmNlIHUxNikgY2FzdHMg
b24gUENJX0QwIHRvIGV4cGxpY2l0bHkgZWxpbWluYXRlIHdhcm5pbmdzLgoKU2lnbmVkLW9mZi1i
eTogSGFiaWwgRXJlbiBUw7xya2VyIDxoYWJpbGVyZW50dXJrZXJAaG90bWFpbC5jb20+Ci0tLQog
YXJjaC94ODYva2VybmVsL2Vhcmx5LXF1aXJrcy5jIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tl
cm5lbC9lYXJseS1xdWlya3MuYyBiL2FyY2gveDg2L2tlcm5lbC9lYXJseS1xdWlya3MuYwppbmRl
eCA2YjZmMzJmNDBjYmUuLjc0NTlhMDczYzc0ZCAxMDA2NDQKLS0tIGEvYXJjaC94ODYva2VybmVs
L2Vhcmx5LXF1aXJrcy5jCisrKyBiL2FyY2gveDg2L2tlcm5lbC9lYXJseS1xdWlya3MuYwpAQCAt
NjQ0LDEzICs2NDQsMTMgQEAgc3RhdGljIHZvaWQgX19pbml0IGFwcGxlX2FpcnBvcnRfcmVzZXQo
aW50IGJ1cywgaW50IHNsb3QsIGludCBmdW5jKQogCS8qIENhcmQgbWF5IGhhdmUgYmVlbiBwdXQg
aW50byBQQ0lfRDNob3QgYnkgZ3J1YiBxdWlyayAqLwogCXBtY3NyID0gcmVhZF9wY2lfY29uZmln
XzE2KGJ1cywgc2xvdCwgZnVuYywgQkNNNDMzMV9QTV9DQVAgKyBQQ0lfUE1fQ1RSTCk7CiAKLQlp
ZiAoKHBtY3NyICYgUENJX1BNX0NUUkxfU1RBVEVfTUFTSykgIT0gUENJX0QwKSB7CisJaWYgKChw
bWNzciAmIFBDSV9QTV9DVFJMX1NUQVRFX01BU0spICE9IChfX2ZvcmNlIHUxNilQQ0lfRDApIHsK
IAkJcG1jc3IgJj0gflBDSV9QTV9DVFJMX1NUQVRFX01BU0s7CiAJCXdyaXRlX3BjaV9jb25maWdf
MTYoYnVzLCBzbG90LCBmdW5jLCBCQ000MzMxX1BNX0NBUCArIFBDSV9QTV9DVFJMLCBwbWNzcik7
CiAJCW1kZWxheSgxMCk7CiAKIAkJcG1jc3IgPSByZWFkX3BjaV9jb25maWdfMTYoYnVzLCBzbG90
LCBmdW5jLCBCQ000MzMxX1BNX0NBUCArIFBDSV9QTV9DVFJMKTsKLQkJaWYgKChwbWNzciAmIFBD
SV9QTV9DVFJMX1NUQVRFX01BU0spICE9IFBDSV9EMCkgeworCQlpZiAoKHBtY3NyICYgUENJX1BN
X0NUUkxfU1RBVEVfTUFTSykgIT0gKF9fZm9yY2UgdTE2KVBDSV9EMCkgewogCQkJcHJfZXJyKCJw
Y2kgMDAwMDolMDJ4OiUwMnguJWQ6IENhbm5vdCBwb3dlciB1cCBBcHBsZSBBaXJQb3J0IGNhcmRc
biIsCiAJCQkgICAgICAgYnVzLCBzbG90LCBmdW5jKTsKIAkJCXJldHVybjsKLS0gCjIuNDcuMwoK
