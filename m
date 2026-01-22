Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010060.outbound.protection.outlook.com [52.101.69.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA242EC569;
	Thu, 22 Jan 2026 04:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769057189; cv=fail; b=AAX3E4hUM2IgnbzXOCACihqir9HyI/QEJOceKL/xjcR2blr1ZxMQt34/aJ+fO4llpPC3ORyjdUh0tr8FUvZe0uHT+Z+VY+qChtqHWzXMziWTDOZISdHupTCvQiun6pmK/ClM+YCy+G2YnXvEDyPwb6SCgBdov4a9A/O3Kvpx/YY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769057189; c=relaxed/simple;
	bh=MHs3FrkiBtPBK0kEWrkGSpgIfwydP1t9DEH8GFKCSqE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PoYEhD9+Ep412r04Duvqu+McwzaFJiXKDABSScjBgMUz0h+TYHaiVhIY9AO48CvoUzGe+FXXrUZnY3ANy7fB2CRJb7ecvq5noyumyYiKwKiYd4f+gfFn4PB/TEuldlcrSzXbj/D2sShtwfuny9CS9F6nDAciClCoCZLMczeFxBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Bc0Oxxc3; arc=fail smtp.client-ip=52.101.69.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bc0Oxxc3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SNjv4b0NKIW7K7gmXmJ674TFCMje0eMVHkoWMAc76tBoQ1EWc3gp2+YgKzY1fvDHNb5eXhHtDp1xIsgYGC/n9zu1kJaJ3XXJvjfea5/LsaZJ2QTIY2URvn4lrOJeUOZckET0gXbr+JKMr2e5jUPmqBTiuHUu9QQhyCVBvMu94FV2zq23AsOlSpbaURWBi9JkTfAmbu9g14hCLrbg7fLEl12jUPeLhCnHMhUgfV9LvhOlnmzbY2aXZMiy9voD+VrUK3Ph3FFkkJc3D2vpW4SkmzbwTiMNF4HFKepXVi8olRvqxZD+XEQCbRTmThyf1KHaPxsaAWuuSzDK2pbFXgE54w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHs3FrkiBtPBK0kEWrkGSpgIfwydP1t9DEH8GFKCSqE=;
 b=yiIaxstuaEV+nHZ4ZyuJjww9ucvJVGRd7YYO+hPdaN4nNUVTxFpvOf3c44M3XhYyrm+UmunRJzp9GGqm2XxcvRCTRXD9jKIAs+51KoRQEDDeVuUQNb+vBfwwnw6MujQfpVig+Y1TF2AQ/8GUmYbEzZYH18r5H1DL2zYKCrGpug4hQV9E52n1+17Xy9ChBxuUS6aCXqNWc7T434AIg4Pwn7QwhwcLc431X2kKolbjO3oBHxKnLtoDusWbeklwWYEeoqF0H8b7uoIYaX/n/0hpwNZW9dz/ambqB+F9pO3RpZvf4VpiwXkXlLdKA8oFw4llhUvl9twAOuyQGIeodPLxwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHs3FrkiBtPBK0kEWrkGSpgIfwydP1t9DEH8GFKCSqE=;
 b=Bc0Oxxc3WNMERPF8Nv3vUp9O3KznOe2IzqJLzSz2DIMYXSxkZBrZP2ldzsp/VNF8MNzivmmqG5xLReG7XEjJ0vBHEQWkaD2l3NvyacseCLUiCXJckRkp1zCbbDumbo95aigams/3RINsoUCVTfodlQAzNpB/9waXLF6/tKbSQOPQFg23TZymBfXF1r432/rAzTrIud0Yv5PkQ43g8IHaS7OnpWfW4GdrWPcIYIUsvIW9m7dbmFsZ6P5iPI4ToL8JlKQYTmJMKolFp/bPagyr2kDSAw6Umw5Q3i4zd/MH+uAqoAFxxnU3ZPAn7K/q2+/25SUJMCClndtRZkgkWSfQOg==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by PA4PR04MB9222.eurprd04.prod.outlook.com
 (2603:10a6:102:2a1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 04:46:19 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7%5]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 04:46:19 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Hongxing Zhu <hongxing.zhu@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, Frank Li
	<frank.li@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 00/10] pci-imx6: Add support for parsing the reset
 property in new Root Port binding
Thread-Topic: [PATCH 00/10] pci-imx6: Add support for parsing the reset
 property in new Root Port binding
Thread-Index: AQHciSrfFZL+lI7gy0eY2GowpkSJdrVdQq4AgAA582A=
Date: Thu, 22 Jan 2026 04:46:19 +0000
Message-ID:
 <VI0PR04MB12114C3AD27B4A625FE6CD1889297A@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260119100235.1173839-1-sherry.sun@nxp.com>
 <20260121230600.GA1220566@bhelgaas>
In-Reply-To: <20260121230600.GA1220566@bhelgaas>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|PA4PR04MB9222:EE_
x-ms-office365-filtering-correlation-id: 1d0f3b58-e4eb-4b83-4db0-08de59712f65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NmVvanJQS1VvRHBZUDJ6dWRsUGp1TnFMVlNIWDFSdW9CY0t3YnBEalZiYVcy?=
 =?utf-8?B?VWlEVjlUVTU3M2d6aWNkK2xPbU44ZXhrTWs5c2F2YUhzaFpoOWRsYjdVclZh?=
 =?utf-8?B?ZW1YMTE5TWlnZ1FIQmFUWnJjQ2JINURURmJkQnJPVWxyTm8yT3NiWk9OYlJL?=
 =?utf-8?B?djNzWkk4ZmdOVG4wRHMvS0ZkblgvUGlBdHNJY05hY1ErUEh1MnFqaXdVcm4w?=
 =?utf-8?B?K3h3TlA5QW43MUQ2RmFxNUkwSThkZy9wN29tSHcxSXM2eCtPZVNhQjJHcm0r?=
 =?utf-8?B?ZUNiWVBvK1ZDQTN1Y1JIZFp0akQ1SU9zRzVzQ3lnWlliMzdUeS9DYUVHQUFv?=
 =?utf-8?B?b2Z4RzdFYzhiaXNHYmMvOXo1SjJlQjAzVWJGc1hub1VnaTRiTXk4VzYyck8x?=
 =?utf-8?B?aUtSTlBXZCtQN0YxejUzTGkxRDNEaFp6dDJvMDZHKzJ1ekcrVmtmMzhsQzFo?=
 =?utf-8?B?cGhoRW4rOVppZEtHVzltM0cxa2RGakN5d3B5V2cvWm1QdHlpMkowQ0FLbkVu?=
 =?utf-8?B?ekloMDJLbVJ1dWE4QTUvQkxZQXdwdCsrYmRzVlhHaFlIbGE3bWthVngwY1dZ?=
 =?utf-8?B?Ni9QWlRxTGN0NlM3dVA2cUdIQ3lWQ0dZc1VQUWFBRW9heXZTUk9KWUQvTXdB?=
 =?utf-8?B?ZTlNR1J0b08zTHRsY1k4WDh4R0QxY3FQeUhITzBvWkE1aDdmeTczdDdSMjg4?=
 =?utf-8?B?MGxvR3VXdHhiVE9ZSVo4dHdqYkNzTlMrZ2d5bUdNeHhhUnFkZnlCVVdwc0dY?=
 =?utf-8?B?R0lKNkdoMS8ydnJyZG12bFlnd0tETnA1Mk1EVjhaNHJ2VjljTDVoY0YreVpE?=
 =?utf-8?B?aHdGNGFPNWZQSDlYZEJyYkZWS3NKNUk3enRsSnFjNGw4d2lEZ1NOdmdybXZu?=
 =?utf-8?B?MndKc2hEMytoSWV3aUhaNnRidVhNMVZmQ2dxRmZxdGowR05DN0pLbm16OW9i?=
 =?utf-8?B?aWpPbUFJbVFSNGhMY3d2MzNody9DbmROcUs0RzZ2SGppWHl3bzdHYmM2SnZX?=
 =?utf-8?B?cUtDVXQvemNSNWNMT0IxcXlxQm9rUmFtUlpWY0dlSlBVSUJEVmZlSGczVE56?=
 =?utf-8?B?TWlpNVNJOGpIYjU0Q3NIVWV4eFBGMHFUWm9ySEc3WitKZmxZUVFTeUtrTU9B?=
 =?utf-8?B?U3Z6ekFocDdzVStGR0x6WndCeW5abVRpbDJXOHlVR25PSFFNbzJLNjNEMDRr?=
 =?utf-8?B?b0JDNHpKTU9UdThjWWxydzl6UGYyYzl3d1BWK0g4aGxidU56bVpybFkyQm5S?=
 =?utf-8?B?cFJta01rYlNpbkxaZFJhTjluMThNRE9LMDhaTHVpSTRBeGU4M0VKTkx4M3VM?=
 =?utf-8?B?VUh3ZTczbjNyWEZ3a3FMU1RHcWNBMWRGMVRrc1EzdHk2V25hWjBHZFZrR2Vr?=
 =?utf-8?B?aFV4UjRicG1UVmd0M2tET1Jlem81VllzS2xLdlYrYW45MG5RRkExTEE3WG40?=
 =?utf-8?B?bXRXMEdZNXM0TVNBU25WM0NrVWpRUDhvMUFKQWViNDZxbFZPN3graUxaZFN5?=
 =?utf-8?B?dGFqNmZLa0ZHbkFYT1FXSUwyVGRDQ3drMHRuMHcxYXVDcTNpbEI3MEkrQ3J1?=
 =?utf-8?B?VldqKzArR3Y4UFlDaGlTbVFqVVlNc0d0WGY1RGZSR2tWdzFMSTIxekE4eFpz?=
 =?utf-8?B?dzhJZzIzSy8xSXpPdlp4M2tGU3cvbC9OOUtZbGxoakdKeGNxb3d6Y0RRWVBl?=
 =?utf-8?B?ODlORlFCc0pBQ1dHZ3Z0dkZQclhSUGtoTHlLWC9JQlVFOFUwMVd6Mk9jNUVY?=
 =?utf-8?B?UnBvbkd6Y0pYL0dXWWdmbjR3bEFBTjZySXYrcTNQLzc1ME5FNURFR1laTVVO?=
 =?utf-8?B?ZFB4dWp0OE9Gb1JGY3dZKzNuQUV3cFFLWUVkaVF1Q2lvcXk1Sk5QUEdpTmJT?=
 =?utf-8?B?NC8yMnNpd2NmMlgyb28zcjZ1MmZKQzZWNmFMd292V3ZleUU3UDk5blJiY3lZ?=
 =?utf-8?B?RlRDditYV0ZjMmhObjJac2NJQW1XRlEyb3k2dzMxK0dKWTVhbFh1UFh6SXBD?=
 =?utf-8?B?OU5yRzlmL3Q3SVhvN1pDUWVlTmtyY3h5dzR0a1ZqTm5UVSt3TUU0cEkvSktZ?=
 =?utf-8?B?RXRqY09kT1RJenRweE04WEYvRU9xcXp3UFRsaHJyWDdCRnNGcGlQdkx6ZVR4?=
 =?utf-8?B?S1NzbnV4elJXQkppMDlWSUxrMTZMZGp1cWRLeSs2N1pEUVBhZklHUTNMUm13?=
 =?utf-8?Q?h6pnxi2KSWNsOBr/HaaXYuQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MEozNDJaaThoY3dlYlpsSzJGcE1aRkg3VmcvUHFvVkxIWEYwQzJHbmxGd0xk?=
 =?utf-8?B?Ulh3NHdwMU43eXEwL1hYTThtZ0VHTS8rekdONXVBSEtORGx1ckU3bGN3bVJl?=
 =?utf-8?B?VTh2bTlRWXpZT3BzTUVlaERLMUROU3RSQlJ6NkJqN3VjRklLSVdQV0JibThp?=
 =?utf-8?B?czBjZ1FOdjQrRFZZSktTQVRPTERsUlVsMGFQamNvMDZuU09ZME9wbUFKd2N0?=
 =?utf-8?B?WmFsUS8rUDRUN3JCY2J1Rlp2QkprV0hWanEzNXhmUTRDUmdqWU5XMWNLRSto?=
 =?utf-8?B?RnZpdTdLMWVlMHEvOG9DR1ErdkI4aVpPMGtFOHNyUzNpaUtDbmREbXM3dVpk?=
 =?utf-8?B?OHZadVJLR3ZHbDdnOG54bFgyK1R2MSs1dlJYYU5HWCtHL2h0RzNtalREYWN6?=
 =?utf-8?B?QnFuQS9zajNuVmFReGJ6OWcrejhRT0t6aW5wQTlIVjQwZUNVMm9QRGZuSEJu?=
 =?utf-8?B?L0syQVVmbU9WZWFMV3hnNHU2WmZOVWpSTTV5M3RQK3d0dnRQQWNnN1BsSHFn?=
 =?utf-8?B?Zno5Q3hHSloyVnk2OTRIdWlGdzAzMFdlcFhaVU5UcW5Qc1N0Qmt4NkhOaSty?=
 =?utf-8?B?aUxiaXVGTGUvRW4vUDRXbi9xaEc5elI2NUxQb3N3RlVCKzA2QitVVVN2TGdn?=
 =?utf-8?B?Tk9LcTFaK0oyay83REYzSnZsV2Y3VDkrOEJQV1J2ZEVzaG04UjRhdUhIZVRD?=
 =?utf-8?B?RlM0Q09tVyt1RngvRDV6S1l2ODZRODViQUFVSW5ESmNMQWt3WkYyZTRjRmR0?=
 =?utf-8?B?aTBYWWt1YVZVSUFWRjVwaCt0eGNWSkdVY2JubklmcGRDd3duNHBZeGw0Qmp0?=
 =?utf-8?B?RUdHVlFjR0E4eFMvZHYrc3FxZ0t5RFBaTno4dlcydWxCenFoR3lKY2crc3Yx?=
 =?utf-8?B?K3lYdEpwcWxxZmd0VGRxK1RPOGFWR1RaUW82MnhTeU04YlRCRm8xMDVTem1M?=
 =?utf-8?B?OUdVbWJFeVNFNjBQWmdJRUtrY3A5U0JzcG04RFBmUHdTdXQvQ0Z3N0IxZUFT?=
 =?utf-8?B?UTdrc21ubE4ycE01ZE1qSDRoUUxVb3FvU1o4THNXekxZcjhDRXNSYkE4L21Y?=
 =?utf-8?B?TWtMR3hldjZzY2RLSlJ4a0xxTjBwMloxd2RpY1oxeEFMdXNFaU0wMHpFTUp3?=
 =?utf-8?B?TTlZaWNRZkFVWE40d0s3SW9vNFE1NDJvMllXeGZDNFhFWVdFek8vTDkyN3B5?=
 =?utf-8?B?UEFacjJhUE1RMnVtbVNCUlhMbDF1bFpobVJCM0dwUmFIQWFTZm5NaGtIeXNE?=
 =?utf-8?B?WlRWcHpHZ0I2WEd5K2FTRzhRcEhVN3JlUUFhbzNyelBzYmtwdEVhUFdvYWpi?=
 =?utf-8?B?T2NId2xjdkVnQXl6N3JrazZkMkUzY24wZ29qOC9QYy9Xc2Z3d3dMZ1ZpTTZM?=
 =?utf-8?B?enlJZmltR3JLNnFkR2l4ekxCUlVLa0Via3ltNXhOR05DVnU0TnlPbTQzeGdY?=
 =?utf-8?B?MjFkUFpzSmljdDFHT2FlalcrLzhFa2dYSUt0WW1SaVZ0TFF3VFJTWDc5NUJR?=
 =?utf-8?B?WFFaQklIa2dlVDhqbUpjaEdpdHNMOVBRSmRHdWZaMzJlWnU2MHdJTk53MitM?=
 =?utf-8?B?c2tTSjIxVjVyWTkzV0o5MmR0eDVjT09VQ2R5YVYwdXpjUHpmS1Nubjg1d0dy?=
 =?utf-8?B?aXcyVmVhYTlOZ1g4MHF3c3R3YXl0eDBPMEp4aEFrcWxLL3M0VzN6eDkrbkZx?=
 =?utf-8?B?Zmg4aU1aazBhajRmWWlzV21SOXNwaWpjVk4rL0w3MG5uZnZaeWtQVlo4MDRT?=
 =?utf-8?B?QS9YSmt5a3krNEdLeEpPYmIyYjFzTnFzNGpMR083KzVuR3h3OU1ZWlRnU21R?=
 =?utf-8?B?VENxbmFHUkpVNWFjYlFDNzJ2YkVUYk5BTDQrMks2eUZzVFZLY2JWM0lqYTQ0?=
 =?utf-8?B?Rm10TFovUjc5TjlxSHllUTNLWjkyZVFZZ0J2NlUxaUE0alh6WU00ZERJYXhL?=
 =?utf-8?B?YnhBdGVUZkswOStVY0gyMmQvZzNSY2hseXpiS2lRY3NtMklhdzVCMnVRRlg0?=
 =?utf-8?B?YnljZi9iNjZBU28zVEVkWnhjK1FyeGNra1doOC9vUlBZWnhDS0k3eTU1UHM4?=
 =?utf-8?B?amVSZ1d2YkQrOHd4Wk5SQzIvUys2YmQ2clF2ZnFuemVsd1dlWUxEekROcFNq?=
 =?utf-8?B?azgrdUtOaFk5MFVLQ211WFRKN3cxbDE0K1JKcmllaVJVVGRyT3Uwc1ZiS3dz?=
 =?utf-8?B?UnIzZGdUK2Z3MjJVdWk0SmR5ZGFuZ0E1bDMzMitYZ1dSd0JiZHgrQ0xiM2l0?=
 =?utf-8?B?U3RXeTRyOE9heDN2bHVwQnFUVnJ5V1RNY2lza3ZTakp1R3kxNENBTGJ2dXNB?=
 =?utf-8?Q?AY0+CU+Bc5PMD5s/m+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0f3b58-e4eb-4b83-4db0-08de59712f65
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2026 04:46:19.3912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ymXBck0H+A5EGrJgvXYHAmXVNIqZNTAUOarBCeIq2FdAiaXi62//hH16jG/LAZkqGamvlHz5bWMNPhJms11hQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9222

PiBPbiBNb24sIEphbiAxOSwgMjAyNiBhdCAwNjowMjoyNVBNICswODAwLCBTaGVycnkgU3VuIHdy
b3RlOg0KPiA+IFRoaXMgcGF0Y2ggc2V0IGFkZHMgc3VwcG9ydCBmb3IgcGFyc2luZyB0aGUgcmVz
ZXQgcHJvcGVydHkgaW4gbmV3IFJvb3QNCj4gPiBQb3J0IGJpbmRpbmcgaW4gcGNpLWlteDYgZHJp
dmVyLCBzaW1pbGFyIHRvIHRoZSBpbXBsZW1lbnRhdGlvbiBpbiB0aGUNCj4gPiBxY29tIHBjaWUg
ZHJpdmVyWzFdLg0KPiA+DQo+ID4gVGhlIHBsYW4gaXMgdG8gYWRkIHRoZSB3YWtlLWdwaW8gcHJv
cGVydHkgdG8gdGhlIHJvb3QgcG9ydCBpbg0KPiA+IHN1YnNlcXVlbnQgcGF0Y2hlcy4gQWxzbywg
dGhlIHZwY2llLXN1cHBseSBwcm9wZXJ0eSB3aWxsIGJlIG1vdmVkIHRvDQo+ID4gdGhlIHJvb3Qg
cG9ydCBub2RlIGxhdGVyIGJhc2VkIG9uIHRoZSByZWZhY3RvcmluZyBwYXRjaCBzZXQgZm9yIHRo
ZQ0KPiA+IFBDSSBwd3JjdHJsIGZyYW1ld29ya1syXS4NCj4gPg0KPiA+IFsxXQ0KPiA+IGh0dHBz
Oi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUy
RiUyRmxvcmUNCj4gPiAua2VybmVsLm9yZyUyRmxpbnV4LXBjaSUyRjIwMjUwNzAyLXBlcnN0LXY1
LTAtOTIwYjNkMWY2ZWUxJTQwcXRpLnF1YWxjDQo+ID4NCj4gb21tLmNvbSUyRiZkYXRhPTA1JTdD
MDIlN0NzaGVycnkuc3VuJTQwbnhwLmNvbSU3QzdlOGRlZmRkOTY4NA0KPiA0MTFmMGVlMjANCj4g
Pg0KPiA4ZGU1OTQxYTY3NyU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3
QzAlN0M2MzkwNA0KPiA2MzM1NjYzNA0KPiA+DQo+IDUyMzExJTdDVW5rbm93biU3Q1RXRnBiR1pz
YjNkOGV5SkZiWEIwZVUxaGNHa2lPblJ5ZFdVc0lsWWlPaUkNCj4gd0xqQXVNREF3DQo+ID4NCj4g
TUNJc0lsQWlPaUpYYVc0ek1pSXNJa0ZPSWpvaVRXRnBiQ0lzSWxkVUlqb3lmUSUzRCUzRCU3QzAl
N0MlN0MlN0MNCj4gJnNkYXQNCj4gPiBhPWprbTFKeFZwSWV4dTA1cVFJdXdWNjlCVHoweElaT3Zw
UmJEM1V2N3k0MTQlM0QmcmVzZXJ2ZWQ9MA0KPiA+IFsyXQ0KPiA+IGh0dHBzOi8vZXVyMDEuc2Fm
ZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxvcmUNCj4g
PiAua2VybmVsLm9yZyUyRmxpbnV4LXBjaSUyRjIwMjYwMTE1LXBjaS1wd3JjdHJsLXJld29yay12
NS0wLTlkMjZkYTNjZTkwDQo+ID4NCj4gMyU0MG9zcy5xdWFsY29tbS5jb20lMkYmZGF0YT0wNSU3
QzAyJTdDc2hlcnJ5LnN1biU0MG54cC5jb20lN0MNCj4gN2U4ZGVmZGQNCj4gPg0KPiA5Njg0NDEx
ZjBlZTIwOGRlNTk0MWE2NzclN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAN
Cj4gJTdDMCU3Qw0KPiA+DQo+IDYzOTA0NjMzNTY2MzQ2NTIwMyU3Q1Vua25vd24lN0NUV0ZwYkda
c2IzZDhleUpGYlhCMGVVMWhjR2tpT24NCj4gUnlkV1VzSWxZDQo+ID4NCj4gaU9pSXdMakF1TURB
d01DSXNJbEFpT2lKWGFXNHpNaUlzSWtGT0lqb2lUV0ZwYkNJc0lsZFVJam95ZlElM0QlM0QlDQo+
IDdDMCUNCj4gPg0KPiA3QyU3QyU3QyZzZGF0YT1ZQUR3SlRyelA4ZmhVUjF6YWNCeUIxaWk5Wmw4
TmxJU1BJTmhzMFdSbVFzJTNEJnJlDQo+IHNlcnZlZA0KPiA+ID0wDQo+IA0KPiBJcyB0aGVyZSB2
YWx1ZSBpbiBkb2luZyB0aGlzPyAgSXQgbG9va3MgbGlrZSBpdCBtaWdodCBiZSBtYWtpbmcgd29y
ayBmb3Igbm8NCj4gYmVuZWZpdC4NCj4gDQo+IENlcnRhaW5seSBmb3IgKm5ldyogZHJpdmVycyBh
bmQgRFRzLCB3ZSBzaG91bGQgcHV0IHJlc2V0cyBpbiB0aGUgUm9vdCBQb3J0Lg0KPiBCdXQgdGhp
cyBsb29rcyBsaWtlIHlvdSdyZSBtb3ZpbmcgdGhlbSBpbiBleGlzdGluZyBEVHMuICBJbiB0aGF0
IGNhc2UsIHlvdSBzdGlsbA0KPiBoYXZlIHRvIHN1cHBvcnQgdGhlIG9sZCBEVHMgd2hlcmUgdGhl
IHJlc2V0cyBhcmUgaW4gdGhlIGhvc3QgYnJpZGdlLg0KPiANCj4gSWYgeW91IGFyZSBhZGRpbmcg
c3VwcG9ydCBmb3IgaGFyZHdhcmUgdGhhdCBoYXMgbXVsdGlwbGUgUm9vdCBQb3J0cyB3aXRoDQo+
IHNlcGFyYXRlIHJlc2V0cyBmb3IgZWFjaCBSb290IFBvcnQsIHRoZW4gb2YgY291cnNlIHlvdSB3
b3VsZCBuZWVkIHRvIHB1dCB0aGUNCj4gcmVzZXQgaW5mbyBpbiBwZXItUm9vdCBQb3J0IHN0YW56
YXMgYW5kIG1ha2UgY2hhbmdlcyB0byBzdXBwb3J0IHRoYXQsIGJ1dCB0aGlzDQo+IHNlcmllcyBk
b2Vzbid0IG1lbnRpb24gYW55dGhpbmcgYWJvdXQgbXVsdGlwbGUgUm9vdCBQb3J0cy4NCg0KSGkg
Qmpvcm4sDQpUaGUgaW5pdGlhbCBpZGVhIGlzIHRvIGFkb3B0IHRoZSBNYW5pdmFubmFu4oCZcyBy
ZWNlbnQgUENJZSBNLjIgS2V54oCRRSBjb25uZWN0b3INCnN1cHBvcnQgcGF0Y2ggc2V0IFszXSBh
bmQgUENJIHBvd2VyIGNvbnRyb2wgZnJhbWV3b3JrIHBhdGNoZXMsIGFuZCBleHRlbmQgdGhlbQ0K
dG8gdGhlIHBjaWXigJFpbXg2IGRyaXZlci4gU2luY2UgdGhlIG5ldyBNLjIvcHdyY3RybCBtb2Rl
bCBpcyBpbXBsZW1lbnRlZCBiYXNlZA0Kb24gUm9vdCBQb3J0cyBhbmQgcmVxdWlyZXMgdGhlIHB3
cmN0cmwgZHJpdmVyIHRvIGJpbmQgdG8gYSBSb290IFBvcnQgZGV2aWNlLCB3ZQ0KbmVlZCB0byBp
bnRyb2R1Y2UgYSBSb290IFBvcnQgY2hpbGQgbm9kZSBvbiBpLk1YIGJvYXJkcyB0aGF0IHByb3Zp
ZGUgYW4gTS4yDQpjb25uZWN0b3IuDQoNClRvIGZvbGxvdyBhIG1vcmUgc3RhbmRhcmRpemVkIERU
IHN0cnVjdHVyZSwgSSBiZWxpZXZlIGl0IGFsc28gbWFrZXMgc2Vuc2UgdG8gbW92ZQ0KdGhlIHJl
c2V0LWdwaW9zIGFuZCB3YWtlLWdwaW9zIHByb3BlcnRpZXMgaW50byB0aGUgUm9vdCBQb3J0IG5v
ZGUuIFRoZXNlIHNpZ25hbHMNCmxvZ2ljYWxseSBiZWxvbmcgdG8gdGhlIFJvb3QgUG9ydCByYXRo
ZXIgdGhhbiB0aGUgaG9zdCBicmlkZ2UsIGFuZCBwbGFjaW5nIHRoZW0NCnRoZXJlIGFsaWducyB3
aXRoIHRoZSBuZXcgTS4yL3B3cmN0cmwgbW9kZWwuDQoNClJlZ2FyZGluZyBiYWNrd2FyZCBjb21w
YXRpYmlsaXR5LCBhcyBGcmFuayBzdWdnZXN0ZWQsIEkgd2lsbCBub3QgcmVtb3ZlIHRoZSBvbGQN
CnJlc2V0LWdwaW8gcHJvcGVydHkgZnJvbSBleGlzdGluZyBEVFMgZmlsZXMgdG8gYXZvaWQgZnVu
Y3Rpb24gYnJlYWsuIEFzIGZvcg0Kd2hldGhlciB3ZSBzaG91bGQgYmFja2ZpbGwgUm9vdCBQb3J0
IG5vZGVzIGZvciBvbGRlciBEVFMgZmlsZXMsIEkgZG9uJ3QgaGF2ZSBhDQpkZWZpbml0aXZlIG9w
aW5pb24geWV0LCBob3BlIHlvdXIgc3VnZ2VzdGlvbnMuDQoNCkZvciBuZXcgaS5NWCBwbGF0Zm9y
bXPigJRzdWNoIGFzIHRoZSB1cGNvbWluZyBpLk1YOTUy4oCUd2Ugd2lsbCBhZGQNCnZwY2llLXN1
cHBseSwgcmVzZXQtZ3Bpb3MsIGFuZCB3YWtlLWdwaW9zIGRpcmVjdGx5IHVuZGVyIHRoZSBSb290
IFBvcnQgbm9kZS4NClRoZXJlZm9yZSwgZHJpdmVyIHVwZGF0ZXMgYXJlIG5lZWRlZCB0byBzdXBw
b3J0IGJvdGggdGhlIGxlZ2FjeSBwcm9wZXJ0aWVzDQphbmQgdGhlIG5ldyBzdGFuZGFyZGl6ZWQg
Um9vdCBQb3J04oCRYmFzZWQgbGF5b3V0Lg0KDQpbM10gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGludXgtcGNpLzIwMjYwMTEyLXBjaS1tMi1lLXY0LTAtZWZmODRkMmM2ZDI2QG9zcy5xdWFsY29t
bS5jb20vDQoNCkJlc3QgUmVnYXJkcw0KU2hlcnJ5DQoNCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTog
U2hlcnJ5IFN1biA8c2hlcnJ5LnN1bkBueHAuY29tPg0KPiA+IC0tLQ0KPiA+IFNoZXJyeSBTdW4g
KDEwKToNCj4gPiAgIGR0LWJpbmRpbmdzOiBQQ0k6IGZzbCxpbXg2cS1wY2llOiBBZGQgcmVzZXQg
R1BJTyBpbiBSb290IFBvcnQgbm9kZQ0KPiA+ICAgUENJOiBpbXg2OiBBZGQgc3VwcG9ydCBmb3Ig
cGFyc2luZyB0aGUgcmVzZXQgcHJvcGVydHkgaW4gbmV3IFJvb3QgUG9ydA0KPiA+ICAgICBiaW5k
aW5nDQo+ID4gICBhcm06IGR0czogaW14NnFkbDogQWRkIFJvb3QgUG9ydCBub2RlIGFuZCBtb3Zl
IFBFUlNUIHByb3BlcnR5IHRvIFJvb3QNCj4gPiAgICAgUG9ydCBub2RlDQo+ID4gICBhcm06IGR0
czogaW14NnN4OiBBZGQgUm9vdCBQb3J0IG5vZGUgYW5kIG1vdmUgUEVSU1QgcHJvcGVydHkgdG8g
Um9vdA0KPiA+ICAgICBQb3J0IG5vZGUNCj4gPiAgIGFybTogZHRzOiBpbXg3ZDogQWRkIFJvb3Qg
UG9ydCBub2RlIGFuZCBtb3ZlIFBFUlNUIHByb3BlcnR5IHRvIFJvb3QNCj4gPiAgICAgUG9ydCBu
b2RlDQo+ID4gICBhcm02NDogZHRzOiBpbXg4bW06IEFkZCBSb290IFBvcnQgbm9kZSBhbmQgbW92
ZSBQRVJTVCBwcm9wZXJ0eSB0bw0KPiBSb290DQo+ID4gICAgIFBvcnQgbm9kZQ0KPiA+ICAgYXJt
NjQ6IGR0czogaW14OG1wOiBBZGQgUm9vdCBQb3J0IG5vZGUgYW5kIG1vdmUgUEVSU1QgcHJvcGVy
dHkgdG8NCj4gUm9vdA0KPiA+ICAgICBQb3J0IG5vZGUNCj4gPiAgIGFybTY0OiBkdHM6IGlteDht
cTogQWRkIFJvb3QgUG9ydCBub2RlcyBhbmQgbW92ZSBQRVJTVCBwcm9wZXJ0eSB0bw0KPiA+ICAg
ICBSb290IFBvcnQgbm9kZQ0KPiA+ICAgYXJtNjQ6IGR0czogaW14OGR4bC9xbS9xeHA6IEFkZCBS
b290IFBvcnQgbm9kZXMgYW5kIG1vdmUgUEVSU1QNCj4gPiAgICAgcHJvcGVydHkgdG8gUm9vdCBQ
b3J0IG5vZGUNCj4gPiAgIGFybTY0OiBkdHM6IGlteDk1OiBBZGQgUm9vdCBQb3J0IG5vZGVzIGFu
ZCBtb3ZlIFBFUlNUIHByb3BlcnR5IHRvIFJvb3QNCj4gPiAgICAgUG9ydCBub2RlDQo+ID4NCj4g
PiAgLi4uL2JpbmRpbmdzL3BjaS9mc2wsaW14NnEtcGNpZS55YW1sICAgICAgICAgIHwgIDI5ICsr
KysNCj4gPiAgLi4uL2FybS9ib290L2R0cy9ueHAvaW14L2lteDZxZGwtc2FicmVzZC5kdHNpIHwg
ICA1ICstDQo+ID4gIGFyY2gvYXJtL2Jvb3QvZHRzL254cC9pbXgvaW14NnFkbC5kdHNpICAgICAg
ICB8ICAxMSArKw0KPiA+ICAuLi4vYXJtL2Jvb3QvZHRzL254cC9pbXgvaW14NnFwLXNhYnJlYXV0
by5kdHMgfCAgIDUgKy0NCj4gPiAgYXJjaC9hcm0vYm9vdC9kdHMvbnhwL2lteC9pbXg2c3gtc2Ri
LmR0c2kgICAgIHwgICA1ICstDQo+ID4gIGFyY2gvYXJtL2Jvb3QvZHRzL254cC9pbXgvaW14NnN4
LmR0c2kgICAgICAgICB8ICAxMSArKw0KPiA+ICBhcmNoL2FybS9ib290L2R0cy9ueHAvaW14L2lt
eDdkLXNkYi5kdHMgICAgICAgfCAgIDUgKy0NCj4gPiAgYXJjaC9hcm0vYm9vdC9kdHMvbnhwL2lt
eC9pbXg3ZC5kdHNpICAgICAgICAgIHwgIDExICsrDQo+ID4gIC4uLi9ib290L2R0cy9mcmVlc2Nh
bGUvaW14OC1zcy1oc2lvLmR0c2kgICAgICB8ICAxMSArKw0KPiA+ICBhcmNoL2FybTY0L2Jvb3Qv
ZHRzL2ZyZWVzY2FsZS9pbXg4ZHhsLWV2ay5kdHMgfCAgIDUgKy0NCj4gPiAgYXJjaC9hcm02NC9i
b290L2R0cy9mcmVlc2NhbGUvaW14OG1tLWV2ay5kdHNpIHwgICA1ICstDQo+ID4gIGFyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS5kdHNpICAgICB8ICAxMSArKw0KPiA+ICBhcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtZXZrLmR0cyAgfCAgIDUgKy0NCj4gPiAg
YXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLmR0c2kgICAgIHwgIDExICsrDQo+
ID4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS1ldmsuZHRzICB8ICAxMCAr
LQ0KPiA+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEuZHRzaSAgICAgfCAg
MjIgKysrDQo+ID4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxbS1tZWsuZHRz
ICB8ICAxMCArLQ0KPiA+ICAuLi4vYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxbS1zcy1oc2lvLmR0
c2kgICAgfCAgMjIgKysrDQo+ID4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhx
eHAtbWVrLmR0cyB8ICAgNSArLQ0KPiA+ICAuLi4vYm9vdC9kdHMvZnJlZXNjYWxlL2lteDk1LTE1
eDE1LWV2ay5kdHMgICAgfCAgIDUgKy0NCj4gPiAgLi4uL2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg5
NS0xOXgxOS1ldmsuZHRzICAgIHwgIDEwICstDQo+ID4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2lteDk1LmR0c2kgICAgICB8ICAyMiArKysNCj4gPiAgZHJpdmVycy9wY2kvY29udHJv
bGxlci9kd2MvcGNpLWlteDYuYyAgICAgICAgIHwgMTI4ICsrKysrKysrKysrKysrKystLQ0KPiA+
ICAyMyBmaWxlcyBjaGFuZ2VkLCAzMzUgaW5zZXJ0aW9ucygrKSwgMjkgZGVsZXRpb25zKC0pDQo+
ID4NCj4gPiAtLQ0KPiA+IDIuMzcuMQ0KPiA+DQo=
