Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795266754;
	b=fjG4bF/yUMUECgNpZp6lO3lbLKIavh61RiXnKZhOc6fMozIO0PR6Cn9WwUpBRIkcRmCi
	 7ZfWpLP+pOO2ASH7F0W/jDnn5fOM8YgqiOMfPKTPeuY2Sko4EXwoWw4xBpjyn92Sm85b8
	 1vmfe68xNEKVw1uzE5W5Avyz9njRRPRmtHOrvMxJ3Bcg4MCpFP+fP/YOy+ZVhnb0gA2oA
	 KreJPRWc3l7YZCktJrrwjEG5srZFlqi/XXzB+ZDIUQTLq8BV3uCAy44+ZPg8xvIXHIbM+
	 E/6aV8+NwfhOLOEaDMBmz1EFiGYC1X4l43+CewdYJ3hXQqe1PmxFg1MgI3IM2UcxBhQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795266754;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
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
	bh=zIy0dMDRoKRRyIWw2jQO38m9FIGj2xEPmv/97NETzbA=;
	b=2Niy3F3X0Ea/JceRon1NY/gofedOak/uhwwM/jRchMBllRz6YLVhd9vtBrPgGt3Bm6XR
	 1ZaA2bUqofNM2vLyvBv4W/5oXUq4YOT2/sT5M5UxDbjyXnaNQi0iGWfkG73DJra8KTDaf
	 1XQSBQGSWVK81mo52Bnl/48OBRKPwe1kfoo0Xs0b03ZVVQgsGlAI0iyF7Gj5CRB2coW4U
	 EQYCxmrk4JGaND32bu7e68CAjcrGdjTt0CAW9OMAktTdBzAqr5277TsT5VfbHkLcC7xdn
	 ZZH6ugrLgbtcFJ/RXkVZhwDQBUaNdXr8vvvrbGf3HhwWyYK817K9oDC43+NdTPmmdTg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=Y+ilsIzj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.34
Received: from WA1P291CU003.outbound.protection.outlook.com (mail-polandcentralazolkn19011034.outbound.protection.outlook.com [52.103.53.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE73606A338;
	Sat, 21 Nov 2026 13:12:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAE73606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=Y+ilsIzj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y64mtLFsg6HpTC9YJfj7mEG1TFb+yEfzN3uw0D7oeo3ML/HYlPo93Clmfr/GMsPRE3qfB1KhprVhXRaKXMCBRObkFfbF0F/LC7+5DrRlnbhYXFXNb7fpMuqdSZfHNgYoPCEZn2l7oIdleJ1QWtnBSzYSICjqmGS4L3Im/6AvTPk+4lvGnjQ+nkVkzvvXZFurHRDaBtjffZh+TlkQr5nyRQDld+3YBMW5AELcGRIXvv869QVThPyP35nZhpUWDxaWQiuUqH33hZCuaxkDcZBzFJ0OnwzJxw6XoyO2Dv259b6iW/1biCqjkfGEUykue8R5u/H8+AV/1CKkMji7VetgpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIy0dMDRoKRRyIWw2jQO38m9FIGj2xEPmv/97NETzbA=;
 b=GoCBNarXbB9v8SnNatszcKGcfJbvkGhbFi8tGNyKIFiq0tRE4DUTVpzGP5TS1ogWLIe/oHZvvke4HH3O82aXuPuC3yNwYeDuveRSnWOADGh0qM+WsrouT6p8Z8KC2XWqPbeFpYl3DNIeORg/F8hfcVm3QPuuPbB3F+7abZ92pG4lCUHxtn9reX88gR1d851XVjsR/d4ZAbS1Dg9u0+xFJqoxUHINkxks7gAT/bjykeM4PllU59lA0qQhIRfXMUMG0q1rTVQZTiykyNLYcRn6uBbbI4lQWagjgAUiGCiIn7SysReC71KU9bNhlt85iQzrj7QKZ5iDHv7Ej1LWEga0Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIy0dMDRoKRRyIWw2jQO38m9FIGj2xEPmv/97NETzbA=;
 b=Y+ilsIzjK6e9MwiGCmjRzqwwlvF97FuLi9HSgouOCtYmz6EVkBJiRDMa+l7j+EaUNzwszbk08S2w2XtnI8t7DkHMXmDo9C7R98Y5Dy/IhvZZPvNk9LcJaPSK2+2z0NRYGkZtzis3H88kDL9RfqqYarlwIe9/MsZd7DcsF5pXsUrLg2KBm7K3yNigSdfcneNn1NIOMf/37GAcwj5YRgMhkSM7sdMTYKCmVu0MCLIB8oJbMDUgfyyj/+i/+CMs3UggEIq4s7uta4Roww4beegCQg330P8wvyKnSGL2MyMu48kZdEOwlwCRItzyy0E97vJM6qn4gtglB04OjygGoga7Tg==
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:26::11)
 by WA0P291MB0097.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:5::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.13; Sat, 21 Nov 2026 13:12:30 +0000
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404]) by WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404%6]) with mapi id 15.21.0639.011; Sat, 21 Nov 2026
 13:12:30 +0000
From: =?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?= <habilerenturker@hotmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "H . Peter Anvin" <hpa@zytor.com>, "andriy.shevchenko@intel.com"
	<andriy.shevchenko@intel.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?=
	<habilerenturker@hotmail.com>
Subject: [PATCH v4 0/4] PCI: Add pci_power_t helper functions
Thread-Topic: [PATCH v4 0/4] PCI: Add pci_power_t helper functions
Thread-Index: AQHdebn2N7KfhVqyjEOsrL4ygtF+ow==
Date: Sat, 21 Nov 2026 13:12:29 +0000
Message-ID: <20261121130936.53191-2-habilerenturker@hotmail.com>
Accept-Language: tr-TR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: WA2P291MB0187:EE_|WA0P291MB0097:EE_
x-ms-office365-filtering-correlation-id: 3e198b5a-b0de-4920-a2ee-08df47d118cb
x-microsoft-antispam:
 BCL:0;ARA:14566002|38102599003|41001999006|15080799012|8062599012|8060799015|19110799012|31061999003|5062599005|2604032031799003|55001999006|24021099003|16051099003|25010399006|51005399006|102099032|440099028|4302099013|3412199025|1602099012|10035399007|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?bXRkbUJ5UEM1dmUzSko2ZVhlMDUzTkZkbWhCWThFNkE4OHhIWEN6bm1rWDBJ?=
 =?utf-8?B?M2FaMUNRVkwxTlE1b29kUnlZUzRmV2tyVVdwMFYxMkIybTZvMGdGbC85ZzdL?=
 =?utf-8?B?NmdpeTZHL25BYnJDSHI4SXovcmlNRlJMK0lLMFRka3FNT0N3enVqS21OU0k2?=
 =?utf-8?B?d0ZnK0tQZGs4V1ZKV2dJZjZMbnp6NkROQmcvODk4YWJHYW1UdlZBbkEzM0pM?=
 =?utf-8?B?Z1BaVkhlQTdhVVh4Mks3ZUVTQ0EvKy9ENXBUUkJLQkJrY1dZeitiZXVua0FP?=
 =?utf-8?B?R3BQaUpKVlNNQllhanJDL1BxS3BXaWhuN20rNzJmN2FZUCtxOVVNcXE5QmVy?=
 =?utf-8?B?ZGNpd2hkV3h0Zi9sVm1jbndkZ1lMV0tZMVFvc2tmV0ttb0FOVDVRYnhjQzZX?=
 =?utf-8?B?VDQ4UnE1Nkh1ZHFZYUZkY0J6ekxWbk5xWE1mbTdDZGdvRHpid2RZWkJtVmli?=
 =?utf-8?B?YVJGekJQNDlQeTl6RVk0ZzRkVFZiOExzcHVQNi8zOFRuQXB0cXZpckxZVTRP?=
 =?utf-8?B?d0NROFE2YndLYzA1VkVaMDE2ZXoycnJ5Sko2aEZVWXVNeTNTaExsa0Znb3RZ?=
 =?utf-8?B?MVlnc0NpQjZCMHAwdzNFRXp2Q2pwZ3RSUjlKQ3V6ZkZEbitPaVJDUVdDNFZ6?=
 =?utf-8?B?RDFNajUxNFVVYy9mQ2R3c0l4K09Qd3R5S3dvbWljdm03U1BwME5xbnVmVGpD?=
 =?utf-8?B?UnJzTWdhRkI5UlNHbXZXNmhPbVF3aGpjVXRSbGVaS1lRS1QxcWk2WDJMODNN?=
 =?utf-8?B?YTJJVGwyTXZCWW1lRldLeHNaajhraW1xSnBMWW92TlhSalVwc3VhbHBiamlN?=
 =?utf-8?B?U2pNd1BleFpyTklZQWVYSURvZ3daMHpMa1VvUzcyY1Y1T1k3UUZuVUVKNzZY?=
 =?utf-8?B?VlZrU3A1N0hKWkQvdTVzYnpIRWlkR3lYUDRwYWp5U0d5Ly9Ud2tmOGlrdUNX?=
 =?utf-8?B?QXl6VnpobzBtZ1l3azJraEFpN05rRmxDNFpJcnYzNTBYK0lpVWZzcmFKaVFm?=
 =?utf-8?B?VWxsMEZmSklVejYrcHVXUGx4SlgrSXEwcXdjd1JPbzRXZWVuTzUwQWZrR01X?=
 =?utf-8?B?REpDRXVCSk94Q1lnbEJFZlVXT3dVZzUzWDgwa1BhV3lNZnRlUXIyeUxyRlNj?=
 =?utf-8?B?KzVjU204ZFYzYmlvc1dpTmkzTVFpNVJGY2xNM2QrWms3VEZBcGpPNmRDdGJy?=
 =?utf-8?B?Z212bWxlNHVKVG83NnM0UEVadm5ZQ0FWYXdGUGU0dXZqdjlqQnpxa1hPeHR2?=
 =?utf-8?B?Q3dNNCtNZDVEc0dyaVQvSFRzTmpNSDI0SnJtNHZDbUQxYkFtbjFlK3k0RWc2?=
 =?utf-8?B?aHpwM20wYlhhK2pBRWlHenpxSHpSQWoxSnhLV2pqc2ZPUHVIZDlQQXp2L01M?=
 =?utf-8?B?L052UEpuRXQxNytTajZXNkF1MmFKQXp5eU5PMWh2bjNmZkp2VkF2STcxYVlG?=
 =?utf-8?B?R2pEd1VkTFdQVHFhbG9GSTBjb2pXS1EyVVdSNWg3RnEwb25ZYldjWkdkTlhh?=
 =?utf-8?B?ekZieG1WZlNVWUNBVndUdXNSVjdGQUh1cVNueVN3TGdEaUxWT2dDdHlURGFh?=
 =?utf-8?B?UWZHQ3VmRGRLUlh5YllsR09IMFMzaEgvUHM0NkcrTkJJNi80RkVhSko1OEZ4?=
 =?utf-8?B?YytkcFYzbXdJMXFiNE1oa1Z0K0taVmc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MytuVjBWaFBrM1pEdEdBNFgyTjdsLzNqYU9nRnVvYzJadmFMNi9QMmMyMmJ4?=
 =?utf-8?B?OCs5UTZ1TjVmNEd5YUhveHU0YUNsUUVtd2luTHQ2SC95QlMvT0xWUDdvNlFv?=
 =?utf-8?B?WHlFK1oxVlVUNnJhQXVwRGs4d3ZQRWwxTlBtZ2ZlTzNSdDBMSk1tbXRtVDNq?=
 =?utf-8?B?SnBkKzU2SDAvRVp5RVh4bjdnVnFMbUtmeklrcExMcjVScDlTZy9sYVF2d2JT?=
 =?utf-8?B?VElGQXZPTVN2aG1RaDB6UUNiN3dBOEdLWFRMM1lXQjIxakIzQlFjWCtOejRj?=
 =?utf-8?B?Uktsd3I4WVRTbVlMUkRwRnNnYzMyM0JBZjluM3FDeGpneWRQSDBDMzh4L2ZC?=
 =?utf-8?B?aVNJeGpBUVQ5TWt5NDJubkczejQ4dHkyb0gxa1UyaHl6Ni9qMkxOcURSNVg1?=
 =?utf-8?B?eEZqVy9rM0pWOEV1SXZxaGFBbm5RMVg2Q1NPSmtUQTBUN2VwdDRvWGdxbUph?=
 =?utf-8?B?ZEpxano5dCtxU25IZlgvOWpGMTZaUVo5V1J2V1F0NmRxaVB6OHFBbGJPQTVF?=
 =?utf-8?B?aDZGNkg2VjVvK1BYMGpJNHJndkNhMWxzejE4bWxyUWh2NWlJUGMyNXYyL2NS?=
 =?utf-8?B?dGlOUzYycW5leXF3aW5QRVZFQjVxeStjVTg5UzNFcXlkaklBUjZEZjMyd25n?=
 =?utf-8?B?L0JoUlg3TDdMbFNtVzg2c1hTNkJHWm44aVZqZzNxcmxmSlI3RFY3eDlPeXc4?=
 =?utf-8?B?ZFRQTEVvZGtoQUV2Nm1jQ0txUklMY1czdXY0ZHRQTFEyYVNtdTZPUmYrbW82?=
 =?utf-8?B?MVkrdnorUUNIcUcrRDJJaW1mYkZmS0pBNXFMR2tvanYvM3Ewa3hJc09ZNlhO?=
 =?utf-8?B?TmNxNmtiTmpXaGp6SmZpV28vMzhPOWVzQ05ITWpLbzlVS0orbzlnREVPYitV?=
 =?utf-8?B?YWVnb1dYaUVrdUtvZjYwSUVyMUpScjZaUGdUK2h3SWZ3WFdVc1hSNUpGS3Q0?=
 =?utf-8?B?Y1h5eDRjbk91QWlybDV2ckNWWDBGMWRHbGhRdUFaL3ZxcnBBbHovZjlXVzFQ?=
 =?utf-8?B?WlRPb0YySU1uVWxlSVpDdXNIZlZ5WHVOeURwdUt0RGI5d0wydmFNY3hYWm9u?=
 =?utf-8?B?cktJcjJFcFZab1JkREI0bkZsTEVLdER1Q2YvVUlLRkFlRlluSkdINWFRWkgw?=
 =?utf-8?B?cWZCL1RmeXQzamhTKzhtSUlMaCtDSmJySmVGQy8vQWhTSFlVNlM5V2w0U1RN?=
 =?utf-8?B?QmhFZXpoUG9HQkYzYnJFZ1BKWkRSTmJKTGZwN2VVWVZTd3JmY1NHUE44azRp?=
 =?utf-8?B?VHJMSlU0cU9vTCt3cmdMSkdOajlaczVGSjZpdDJaNUlJYXFRVERaZ1lqSmU1?=
 =?utf-8?B?Z2JGTkw4YTNTOS9mZEF3Zk1HZVRCdkNzcVVlc3pGaGFrbFVNdkw3bG05dFJL?=
 =?utf-8?B?L1VQVVFabXdVTnlna0c1cFZCdk8xSnAyU09tZ2ZtZ3NqRzJQZUhTQUZxL0hD?=
 =?utf-8?B?VzRlYkhwV012ZjN6a0E3VFRSak5JNGRlWmhNdHN1VGFnUkxtUnhGZlhSL3I3?=
 =?utf-8?B?WEtzOENQYzljdEpsNUxCQmExaUViemExTGt0MFFCb0Racko1ZXRaRUxmVFhk?=
 =?utf-8?B?NkNGb2RaZkRIZUw5WVBaaXN1N0w1V2JsMWQwY0c2M1JXS1ZEK09uSTdIeGMw?=
 =?utf-8?B?dmI3dTAxY2tOYmNTS3J5YWpvdkhaSmpnNlpjNXg1c3ZsbHYzVElBOUxpS002?=
 =?utf-8?B?YkpLL1l1K3ZCL0RYOGlUUzZlbkhuL0lNaVo3WUEzTzl4ekdFYWkwbW9OMTEr?=
 =?utf-8?B?bEZSNDNsZ1dHRHROWWFuaHlhYUZmTzFMcHc4K2h3MUd5eDUzR3hJL05CQU5w?=
 =?utf-8?B?Ky9HTktDYWVRdUVLWUdmUzVWa2hUQkxzcThpRjR2Wk0xM1Y5QkpVTytDVGFy?=
 =?utf-8?Q?hSTZ2yjnUJ1tD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5491CA0F6D99AE4DA6FE6F7077D8AAF4@POLP291.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e198b5a-b0de-4920-a2ee-08df47d118cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2026 13:12:29.9072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA0P291MB0097

VGhpcyBzZXJpZXMgaW50cm9kdWNlcyBoZWxwZXIgZnVuY3Rpb25zIGZvciBhY2Nlc3NpbmcgUENJ
IHBvd2VyCnN0YXRlcyBpbiB0aGUgUG93ZXIgTWFuYWdlbWVudCBDb250cm9sL1N0YXR1cyByZWdp
c3RlciBhbmQKY29udmVydHMgZXhpc3RpbmcgUE1DU1IgYWNjZXNzZXMgdG8gdXNlIHRoZXNlIGhl
bHBlcnMuCgpUaGUgaGVscGVycyBwcm92aWRlIHR5cGVkIGFjY2VzcyB0byB0aGUgUENJIHBvd2Vy
IHN0YXRlIGZpZWxkLAppbmNsdWRpbmcgZXh0cmFjdGlvbiwgc2V0dGluZywgYW5kIGNvbXBhcmlz
b24gb3BlcmF0aW9ucy4KVGhlIHNlcmllcyBhbHNvIHVwZGF0ZXMgdGhlIEFwcGxlIEFpcnBvcnQg
cmVzZXQgcXVpcmsgdG8gdXNlCnRoZSBuZXcgY29tcGFyaXNvbiBoZWxwZXIuCgpUaGlzIGZvbGxv
d3MgdGhlIGRpc2N1c3Npb24gd2l0aCBBbmR5IFNoZXZjaGVua28gYW5kCkJqb3JuIEhlbGdhYXMg
aW4gcmVzcG9uc2UgdG8gIng4Ni9xdWlya3M6IENhc3QgUENJX0QwCnRvIHUxNiBpbiBhcHBsZV9h
aXJwb3J0X3Jlc2V0KCkiIFsxXS4KCkNoYW5nZXMgaW4gdjI6Ci0gQWRkIGhlbHBlcnMgZm9yIGNv
bXBhcmluZyBQQ0kgcG93ZXIgc3RhdGVzLgotIENvbnZlcnQgUENJIGNvcmUgYW5kIHF1aXJrIGNv
ZGUgdG8gdXNlIHRoZSBuZXcgaGVscGVycy4KLSBBZGRyZXNzIHJldmlldyBmZWVkYmFjay4KCkNo
YW5nZXMgaW4gdjM6Ci0gTW92ZSBoZWxwZXJzJyBwb3NpdGlvbnMgdG8gdXBwZXIgbGluZXMgb2Yg
dGhlIHBjaS5oIHdpdGgKICBoZWFkZXIgaW5jbHVkZS4KLSBGaXggaW5kZW50YXRpb24gaW4gcGNp
LmMuCi0gUmVuYW1lIGZ1bmN0aW9uIGBwY2lfcG93ZXJfZXEoKWAgdG8gYHBjaV9wb3dlcl90X2Vx
KClgIGZvcgogIEFQSSBuYW1lIGNvbnNpc3RlbmN5LgotIFJld3JpdGUgcGNpX3Bvd2VyX3RfZXEo
KSBwYXJhbWV0ZXJzIGZvciBjb21wYXJpc29uIG9mCiAgdHdvIGBwY2lfcG93ZXJfdGAgdHlwZSB2
YXJpYWJsZXMuCi0gTW9kaWZ5IGBwY2lfcG93ZXJfdF9zZXRgIHRvIHVzZSBgdTE2ICpjc3JgIGlu
c3RlYWQgb2YKICB1MzIuCi0gVXNlIGBGSUVMRF9NT0RJRlkoKWAgaW4gYHBjaV9wb3dlcl90X3Nl
dCgpYC4KLSBSZW1vdmUgYHBjaV9wb3dlcl9ndGAgYW5kIGBwY2lfcG93ZXJfbHRgLgotIEFkZCBy
ZXNvbHZlZCBTcGFyc2Ugd2FybmluZ3MgdG8gY29tbWl0IG1lc3NhZ2VzLgotIExpbmsgdG8gdjI6
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvY292ZXIuMTc5NTA5Nzk3MC5naXQuaGFiaWxl
cmVudHVya2VyQGhvdG1haWwuY29tLwoKQ2hhbmdlcyBpbiB2NDoKLSBSZXNlbmQgc2VyaWVzIGNs
ZWFubHkgd2l0aCBwcm9wZXIgc3ViamVjdCBoZWFkZXJzICh2MyAyLzQgaGFkIGEKICBtYWxmb3Jt
ZWQgU3ViamVjdCBsaW5lKS4KLSBMaW5rIHRvIHYzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9s
a21sLzIwMjYxMTIxMTI1ODExLjUwMzE1LTEtaGFiaWxlcmVudHVya2VyQGhvdG1haWwuY29tLwoK
TGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDI2MTExODE2MTU1OS42MzYxNy0x
LWhhYmlsZXJlbnR1cmtlckBob3RtYWlsLmNvbS8gWzFdCgpOb3RlOiBMTE0gYXNzaXN0YW5jZSB3
YXMgdXNlZCBmb3IgZWRpdGluZyB0aGUgY292ZXIgbGV0dGVyIGFuZApjb21taXQgZGVzY3JpcHRp
b25zLiBBTGwgY2hhbmdlcyB3ZXJlIHJldmlld2VkIGJ5IHRoZSBzdWJtaXR0ZXIuCgpIYWJpbCBF
cmVuIFTDvHJrZXIgKDQpOgogIFBDSTogQWRkIHBjaV9wb3dlcl90IGhlbHBlciBmdW5jdGlvbnMK
ICBQQ0k6IENvbnZlcnQgcGNpLmMgdG8gcGNpX3Bvd2VyX3QgaGVscGVycwogIFBDSTogQ29udmVy
dCBxdWlya3MuYyB0byBwY2lfcG93ZXJfdCBoZWxwZXJzCiAgeDg2L3F1aXJrczogVXNlIHBjaV9w
b3dlcl90X2VxKCkgaW4gYXBwbGVfYWlycG9ydF9yZXNldCgpCgogYXJjaC94ODYva2VybmVsL2Vh
cmx5LXF1aXJrcy5jIHwgIDYgKysrLS0tCiBkcml2ZXJzL3BjaS9wY2kuYyAgICAgICAgICAgICAg
fCAyOCArKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tCiBkcml2ZXJzL3BjaS9xdWlya3MuYyAg
ICAgICAgICAgfCAgMiArLQogaW5jbHVkZS9saW51eC9wY2kuaCAgICAgICAgICAgIHwgMTcgKysr
KysrKysrKysrKysrKysKIDQgZmlsZXMgY2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygrKSwgMjAgZGVs
ZXRpb25zKC0pCgotLSAKMi40Ny4zCgo=
