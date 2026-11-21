Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.26
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795261119;
	b=eaINrnToYyeLaGOY1D9dUF8n+AkIJXRxTfVhSicp+Vk/GxcC84DNJ9VRO3VfHydCtRVa
	 YBaflr7fTeo+6bEELEJEeBSBh4K1TSmZwh9XKH9qZmDhVbHMOL5s1tOX3orHsWh68M5Mn
	 NVt4VYw2woa7eLTBJl+islJVHcCuqpMKuGnJMxpEskqIdqA/X1DX8t5N2A1D+rc3j9pRj
	 LHehto2q9k119ZdEEaKu1uE93msJ0DSUXDOWodxjtZZVcysBd7or3YQ38XBZAMfT4iZ0C
	 1jn9KbEmJ7bm6L4UXker8jrBm001WwFQHpLbMx+TV3ZGq71r/QjCydIcpLuBpvfiybA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795261119;
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
	bh=+65VI6ZrfMATo28D3uXxBTJPoEGQ+wfTHv4eOsoAt7w=;
	b=IToecUSWxNICJ/77dmPZcTUH3l1Xx+HxDIygUdW+di7dYe5LyqjYcVJ6K5jpjJzDegak
	 lV/F5Ca4sUZypIubj8fQPtOFL0G/CmPVwHfaA5Mb7lqHsQ2Q6Ibvwyv73vuRkYwQ0HvPC
	 yz+t5LW/0vtFUmWZQrMvucaDPDrxmzg7AFnnN89+XoTjBF0hVD975MyHYxaB8/0GsXaPc
	 v9s912nO1EHmemRAWftNQANl4Q48gXo5Q/YrJi6Zv8wi5WK93EqQoSNmqmJX7RmLOEJXh
	 uuS2Z7c38iZPqpwPfTcHQHOofCmWdtUVIGHM+yKK0tp5XvyNbRYMB0beZa0xI9zBnHQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=bJxmDnmL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.26
Received: from WA1P291CU003.outbound.protection.outlook.com (mail-polandcentralazolkn19011026.outbound.protection.outlook.com [52.103.53.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A5C606A320;
	Sat, 21 Nov 2026 11:38:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88A5C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=bJxmDnmL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pScUXrDeucftK7IzvD8Gtdu5/9YlaBuEyqcYOpLHYZFWkNsBuRqHvZsmgaY1ERK5QToB95lHC5rJx1kx7oEmsxGQAuq8Z9tRL14KhHmi9Ar82xbZu6vL7oelwhPob8cpp4IEWgMVHyrm12cO+2o/4DrmduZkenzIoownraRsELJ2HW1yMrcR+cnle2DJrZnrI239a3R1D6z6Qpvnek90/4rRSNpLiyHrM7O/z0Evn8RNIO412kBpf0tNASjiOAmfsVVHlvGwydbck1JZ4FWB78YbrA5BJDQ+WHqw1rTy4TADouw947+be4tFmJycoLrPAP6YYKNE5hf2bm8nQaLQBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+65VI6ZrfMATo28D3uXxBTJPoEGQ+wfTHv4eOsoAt7w=;
 b=VMvoR28WsutQQQ7O2zsKk6TeFRaVz2/mw8mbyUHp3QbvC6VYNxnaNfbLUx9YQdpJ8yVPtdGDXaw4NT40nkd5rjx1CblzyFm8brvNk33xIhPKJs8uCCUmtroX+LNiiefFPMwy2dtdrKoVEHjvvYLokGU2ubcdUeCzA1SiDgmjhIIXyDxckw4pGd3KFkXpODzR7Hru+ehrqZ0K76eW4WTIBpGJ90y50+ecNxa14b0EaJD+Yw48jrnHrZGbO3rbQU0XbpM7YbXAfzBoUs0wihbdPxyVwfsgB5lgnTvdd2sbq/IzWnvSQ+9tYN7PuiAfH+NOmPE88ybs/RK3IWCIFal3gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+65VI6ZrfMATo28D3uXxBTJPoEGQ+wfTHv4eOsoAt7w=;
 b=bJxmDnmLCArQgGtqsoxLWKiht8YlrfLOO+6GJFQDxc/c3ePB3PvO1Rt8YnsxUXX4t68FB9mfO1Cly9HQ/w9VXpWzJ2h6lWnCBGfcbAZMXcR+/nm4b6MfEZiwAaBrhzemiUEVqXstVPHcJBORBrpQU2U82dMdhdorpHeMaf4H5hcy6Vh3diHVagmUYtMixFTbDCV6sK4TcGI0PNCc32r1+0nULD0esUQ8ZJSlSTC4lb64ZU1kCN+ZrZ5V0CoyZ7O3RoYVHOGTFtmUAEUCaLBaxfrzne6LD6VOVcysqCVzr/wMbY6YvrSxtyKT4KB2TYXbQ+tDhj38/B4Ux16VBT/+Wg==
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:26::11)
 by WA0P291MB0145.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Sat, 21 Nov
 2026 11:38:35 +0000
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404]) by WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404%6]) with mapi id 15.21.0639.011; Sat, 21 Nov 2026
 11:38:35 +0000
From: =?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?= <habilerenturker@hotmail.com>
To: "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	=?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?= <habilerenturker@hotmail.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 4/4] x86/quirks: Use pci_power_eq() in
 apple_airport_reset()
Thread-Topic: [PATCH v2 4/4] x86/quirks: Use pci_power_eq() in
 apple_airport_reset()
Thread-Index: AQHdeDNGToMhTgBsW0WxP5JvTKrwTrc1oooAgALGnYA=
Date: Sat, 21 Nov 2026 11:38:35 +0000
Message-ID: <20261121113835.43201-1-habilerenturker@hotmail.com>
References: <av8uhCdgJ9hX4eLT@ashevche-desk.local>
In-Reply-To: <av8uhCdgJ9hX4eLT@ashevche-desk.local>
Accept-Language: tr-TR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: WA2P291MB0187:EE_|WA0P291MB0145:EE_
x-ms-office365-filtering-correlation-id: b991896f-f182-449f-bc5c-08df47c3fa8c
x-microsoft-antispam:
 BCL:0;ARA:14566002|25010399006|51005399006|24021099003|55001999006|21061999006|15080799012|38102599003|31061999003|19110799012|8060799015|8062599012|40105399003|102099032|440099028|3412199025|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?R3MxdjFRSHNyUFd2c3pHVU80V3d0eWE0bVNlUUdoRnhObGpMa1dLRkk3ajg3?=
 =?utf-8?B?dFFING93SytUcGNMY014ZDJkbG5lMHZiSm9INUpkS0hkYlpPd2tWckRXZ3pm?=
 =?utf-8?B?c0VSZHFydzlxNlFzV2Q2REh2czA3Q2x0bWJ5ckZVQWdLWitmZ0E2NVlUcXhz?=
 =?utf-8?B?SG9HYlY5YllEeWRYTHpXUzA1OTVLSXkyWGtCSk0zN01vNFp6ZWRSOXBselNo?=
 =?utf-8?B?eHBzNDF6eVBBeUFlMTZaN1lvV1R0KytzSDNId1oyb1R0Y0hyUEVjRWFkMlp2?=
 =?utf-8?B?eDNSS0UrendLcmRVTG1JUm03Zzh0ZjNsaVRnUDJZVzdBdlJVU0RDZ1lPeWcw?=
 =?utf-8?B?anJDeUExYytmeGUyVEo3ZEhrMENBN01SU2FoajlzQzJaR1kzaHY1SEErZHBO?=
 =?utf-8?B?YlF2Ny9DV1F5SGJ3Vm5UL0Y5RTFhU0NTQ01Ca2lJTEVGS2V6T0t2dkNFSmUy?=
 =?utf-8?B?WmozTk5SeHJ3TnYwdFF6TG9nRUU5OWdIekYwMVdOWlhxWURtYjRkRFliL1Fr?=
 =?utf-8?B?MW41MzJpTDJZR1JiQXFxTnFsSXcwZmIwYnJQTyt5b1JrY0FlWmVtbGRaZnJp?=
 =?utf-8?B?aHF3V2RWNUJvR3l6UERJZjRVZWgxVS9uenNwK21pT3NzWEMzeDcxUStNd0xN?=
 =?utf-8?B?R1hKRm9iR0t6SlBVT01XU3JiL1BQclNKQ2FOd1FCKzZTdmRSVEFkbjlFOWZl?=
 =?utf-8?B?M1NCY0VsSHJiVSsvZDlHb2ZyYWdkZDNRVEN2bDJiRnZ1NG5sckZYK0tLZW9W?=
 =?utf-8?B?aklaejN2VWtEeVFZM0c5L281Z2RmNGdTV01mUTArWWpXUTVSdHNpK1ZZZm5N?=
 =?utf-8?B?ek05MGJLRFpBbGtWOFY5c2duS3dNa2tHM3dEMEdIQXZEZFczeDFTSzFUb1Vm?=
 =?utf-8?B?RmNQSXdhZUFBVWMwdXJRYnA2emFzWVJTLzBDckJUdnRVRkFHdHZKYXpGRXd3?=
 =?utf-8?B?QkpmRHhzM3JUZkFnYzRpekpWckdTNDJiQnkxWDNDeHpVcGdFcGkxVXhQK29Y?=
 =?utf-8?B?WFVaa3FLSERUWVM0Qy9ycFQvSXgwQ0plejU3ZjYwSXcrRndYTGNBVG10RVRT?=
 =?utf-8?B?Y0ZoYVpLbU50T2JKL3NnRVRHbmpSTklZc05aek9mUW5wc2dFdmxycGx0cmw3?=
 =?utf-8?B?MnBJRVlUamFRTjV6cnNkM1A5VnRieTlCQmJzTFdHaGZMVVFib3E2a0MrN3ZL?=
 =?utf-8?B?ems1ZnVDYm95MlBRazJFVGlYQ3lxZXFHeGZ1YSt3d1J0UGJkazl2VzRpZDN1?=
 =?utf-8?B?M2t6TTdHR0tUSkpBREt6MWxaeC92KzZTdnh5Tm9tSzgxWFZ5czBMOWNIVVJZ?=
 =?utf-8?B?MXVZNjVURGdiNTUyN1ZJUm4wSTJTc05yMVVuQ2FGdVZvQ3A0aGh2T3M3eTgv?=
 =?utf-8?B?SU9TT1l1cUVCTzZvQlF0OWo0b0YybnVoaS8zVEJrWE1FT2I5RUNsZ2VYM3JK?=
 =?utf-8?Q?Mo+IgPpP?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eEt0YjVnc1V4N3hYM3FxMkdxQmttcHhNTEYvRGdqaWlLa2w4TEZLR2hFSWhB?=
 =?utf-8?B?cjhSY0F4NGRlT0FickJ2cWh1SG42M1U5Vk5qNi9zNHhHUmx0V1Z0M0ZoNUI4?=
 =?utf-8?B?V0NhZUZzQmNmV21vc1BhMjkyMmp6Mmo0VzBWNkh0MWNsbXJXR0lia2U1RFl3?=
 =?utf-8?B?alNsS0lhOFBLT3FDS09pclZHZk9MUWNiNFBCZGFSMlJmMkp2UmdDUTRBTmtU?=
 =?utf-8?B?ZjVZUjllOER3eDQ0a1h6aWFQbjhBcnFuVi9EdFZDVFRKL1poUjVRckdJbXNw?=
 =?utf-8?B?ZkJ0Q01pMFNCellvTTEzdHBRRGVZeFVLNGQxWElSL0RWd1dYWnlaSElTZUJk?=
 =?utf-8?B?T0JmUnpwUmtQdFp4eEhyV3RNdzFWQW5veHdnTSsweWVQRnJaM3dqWmU1MjF6?=
 =?utf-8?B?T0VrdGFvYmRBeVEyZ1hIS0M0UmZWYTUzTElLNjFySW4zazdVNnRBeGRBMllw?=
 =?utf-8?B?YVZ4YnEwSEpsNEpSQVRtVjAwcG9NOFZxTGE1bEFsRWxuU0tjWGxydkFGUkFW?=
 =?utf-8?B?aDA0WHp6a1BaZzFwc1Z4a1BlZWppQ3l2cXBqWVZaZVhCUFdGaklGaktxandV?=
 =?utf-8?B?OFRFN2VxMFljYkpHZWx3VzJFWkxjMG5Kd2txMGcxSzVIcFI3cjJxalZBdXNK?=
 =?utf-8?B?YnZYc09TVGFIRTRLWnVsanJrQytVZHE2SVdkS0ZqYVEvRXEvcUM0NFVrSnM3?=
 =?utf-8?B?WTNkVE5DaVRtTWRJQXBqWTZUMi9YeFAwUHlHWEhzN3NSRVdkeVJjSWhwU1JE?=
 =?utf-8?B?amZaR2xmL3lHSnptT3UxZ2czeWdFZExreHVvWmtUczIzdlQwNlVTZzFVWDBG?=
 =?utf-8?B?bzNEZ1VjZ1M4WXpkRlZ5TnU0dFR0cjZIblFkMk84MXIrMW5GYUk0MVpKaGpX?=
 =?utf-8?B?T0tsNE1nQU5hZWJVV3ozaUlacG55QkNGUDBmUW9lTFhwNWFiNFpRa2phWndQ?=
 =?utf-8?B?bXB0NlBYczdtVUhyVWNCYmU1UUk4QllyYm1vckNDY1lRMU1sQnAvMDJtMmhT?=
 =?utf-8?B?ZFZGMVJpazBSTmQ4NklwUng3S29sbWd2aCtjY3UzeUxlSTllMGFhajlsa3Js?=
 =?utf-8?B?QnhuK2NXaFlFRzlGVUdrcS9ReUV2YXBsRitxY2JPRkd2anp1cVNOL3BNY2tJ?=
 =?utf-8?B?djlLU090Ujgwd25zcURTV0kyYmJ5SXNrYUgwVXQ0eFJaUm5BUVVaa0MzZnQz?=
 =?utf-8?B?d1E1Z3RQeWVad2pKenU5dWhWVGo3OUdVR20rRXlCTjBqQ2E1UExTVDQyM082?=
 =?utf-8?B?MzZ5ejdQT3YwZk9SZE1MN2hpQy82a1NPeTkwcnc1TjkzVHZkZUd1d3hLenpl?=
 =?utf-8?B?S1NTQ29wZjRSWHB1T2R6Z21sSHBiNkMzKytNclJPOU1FVVJsa2owK2J2UlRM?=
 =?utf-8?B?QkVmUUJJMTFNMkRUUmltdDVkZG05NE5YYUNpazlvMVNBQkZLU2pLSzBRamJS?=
 =?utf-8?B?QXlxaUprNlRmSXlMQ1ZReWp0azk0UEIxM0plU1M5ck5KbXdRbHRyV1ZwK09E?=
 =?utf-8?B?bW4wWU5vNDRGNHBSQWhaNENQYXQwbFFtdFIxYis0QzlyekJiNjV2dDdZMGJE?=
 =?utf-8?B?SWRtN09XVjdoTmgxbEJQUzkrY2ppM1o0NVM5SDNYWjhXVk44QmxoQzA0REFy?=
 =?utf-8?B?ZFhDd2hWVFJrdVFodFNVcGFld0RSaVBxeHVFbzdMSkEzQXZnTllqZFU0cTl0?=
 =?utf-8?B?WGk2NFdBQXd4VGN6NGw4bXNTdSszUVdkaHY4K0RCODE3Y3c4Yy8yVVJhcml0?=
 =?utf-8?B?QjFJYmZEWmYrNVZEV2VLT2RtVUp3clZtVmZ5OU8vZVF1SHp1V1l1K2lPdEYw?=
 =?utf-8?B?NldKS2grZ0hxMnBtK2xXc3lKeGNHSHVGcmZaeFlJdHBrV0U1WWZDVzZHWXNN?=
 =?utf-8?Q?82TW1dTrYb/MH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE72D23987A47048A622696262B2A58D@POLP291.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b991896f-f182-449f-bc5c-08df47c3fa8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2026 11:38:35.7173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA0P291MB0145

SGkgQW5keSwKClRoYW5rcyBmb3IgdGhlIHN1Z2dlc3Rpb24uCgpJIGhhdmUgY29uc2lkZXJlZCB1
c2luZyBgcGNpX3Bvd2VyX3RfdXBkYXRlKClgIGhlbHBlciBpbiB0aGUgY29kZS4KSG93ZXZlciwg
dGhlcmUgYXJlbid0IG1hbnkgcGxhY2VzIGluIHRoZSBjb2RlIHdoZXJlIHRoaXMgZnVuY3Rpb24g
Y291bGQKYmUgdXNlZCAodGhlcmUgaXMgb25seSBvbmUgcGxhY2UgdGhhdCBpcyBzdWl0YWJsZSku
CgpUaGVyZWZvcmUsIEkgYmVsaWV2ZSBpdCdzIGJldHRlciBub3QgdG8gaW5jbHVkZSBpdC4KClJl
Z2FyZHMsClTDvHJrZXIK
