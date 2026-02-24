Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010060.outbound.protection.outlook.com [52.101.84.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0402405E1;
	Tue, 24 Feb 2026 10:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771929263; cv=fail; b=iwTY0pUjflwmZGbjiclgWOR1hvzpezUxHo4lay3Zm3t1X16ntPo2i44Pm4YdZ5l8If8LuS32iDs0rJczRLjfYX6mdDWmnWTHI4Xqz91pC8r/AXKB2+zHVago+o19818bIHGA48jZuleawAIageAFu77oivRSe7Gmkz2acKbqRjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771929263; c=relaxed/simple;
	bh=PN1gGc1gGwUSPZfs3DSud3VmXJ/m0AeZ74Om9BZAgAQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JfWnjz+IfO2VMu0L3xiGSIOMJYrt7y7hsrA64wMRSrFxeW025q29Ozdd3rc/SyYbcWONiSpqkGm7+kYdrCyNfsWJ7vEtjVcGTqqdplrw5ZhIEfWYu/BHUW+HfvDTQhKuhaqAzqLGu5HzQ2SRshQw5lVYumPQHkCy5Cy9I6zu3WM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FoDZciRW; arc=fail smtp.client-ip=52.101.84.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FoDZciRW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dc8Q+D95yjeUVqvZepa8ndsPrYEbaZXA4iJr9e75ClZgeIAIWbMHEpveE35XFGqqE/l6tTYRlqvQNZYMejHs+UvK1gzqD95uM4cmlbVHDWKYLqnoZ0QhSlHUjVh5FPEyn9hghsa9uQHp498KEkTeCWcNDUN57PhYHnDt3IkOZcNmy+GeqrKzhuJ4MTAX6yU6VXYx5JPNQUyQ9Nj/240Pn8YalU3XZOMMS7cM0guhmpdCgcrHU+CS4OmKfJCcMD4VWXX7OihZJQt+25Zphb2UnBSt+NEYKSjTdAy41xh7LbvnCp7gL93C5ERALJpMcFP8BbUxPjmv4qZkBMhBv0C9Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PN1gGc1gGwUSPZfs3DSud3VmXJ/m0AeZ74Om9BZAgAQ=;
 b=xnBjJfpKFoVbSXInWEYWm3kVY8+W34CASYfLq+F7cTb/6XKRaFrrMsMda5zOvuRp22bWgXQqF3uSAaUxlvSOMMXsRCP7hRkyYpxlGnKJVGYokcQbvU2H/zvfQKxNwbP9X9CL0BkZAryJQ+RQXFWi9oZfruPAWP4Ch/TIB/9ht2JF9uSfUuz0ELDftOgPz7Umzq1aQfQ3V6Dvw1NZLGIxH8ypEqMHTV/KAGU0cbSX5qnx4UK2IeaBgHVY2rQ/kvXDQXqT0Cr868qKIz5zpW4mSfjM7ZVlMupcXqm6Bu8c1h5G+7PnmpXsg5k6R0xjbl2l4iUmMPlDIxzBcqjHSjryHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PN1gGc1gGwUSPZfs3DSud3VmXJ/m0AeZ74Om9BZAgAQ=;
 b=FoDZciRW+scn5gkEMgFcBkPFMh3Fz06tQFi8cLmd9MUYDnp4vVM9PFuap3X7nYVLS8zkyYqPOVVL9JePV22qlm7ZKU4sOGnzm7s1g2CmNZtLCu0BMIsY+FkftljADeVF8Zm7/DHpvIR9fz2X1pbCynQFeCDzsPFduwN0RwyBYd17sAFMv/VOqNCj7xDZeqCx3ehxFRktiTSeg9G8saZEDoyLldNygrSmRA09M5MO4IgQ2cKt5BZOdOYrB8qJoFAlSQGPTo6n4a1xX7cZdL4CKbXR6XBam6acZCSIIpASjDlS5LVlm2tC0QWx3RbiGYha/uoF7niCmQwg3KlWD/yVjw==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AM0PR04MB12076.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 10:34:18 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 10:34:18 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Frank Li <frank.li@nxp.com>
CC: Hongxing Zhu <hongxing.zhu@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V5 03/12] PCI: dwc: Allow external allocation of
 pci_host_bridge
Thread-Topic: [PATCH V5 03/12] PCI: dwc: Allow external allocation of
 pci_host_bridge
Thread-Index: AQHcnJ5bAwgIcfkwe0yQnfXfxWbFh7WAwcUAgATGuQCADDAUQA==
Date: Tue, 24 Feb 2026 10:34:18 +0000
Message-ID:
 <VI0PR04MB12114B469DAF930025414FA5E9274A@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260213040852.3340547-1-sherry.sun@nxp.com>
 <20260213040852.3340547-4-sherry.sun@nxp.com>
 <aY9DSPaTCMhcR8GC@lizhi-Precision-Tower-5810>
 <ojqdb7ysx2ktosahpb2mm4uog3oijc7ni7xnz63xjjvy2fdcyg@upmxt7oxv6sr>
In-Reply-To: <ojqdb7ysx2ktosahpb2mm4uog3oijc7ni7xnz63xjjvy2fdcyg@upmxt7oxv6sr>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|AM0PR04MB12076:EE_
x-ms-office365-filtering-correlation-id: 0ae8c91a-65bf-4e4b-0fa1-08de73904417
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Yk5LbVJrUUdwUnROdUhCdXBwUkJFb3JucDY5WTl1L0JGNEV4ck53Q2w5TGhl?=
 =?utf-8?B?Sk1yVExPZGp1eFZTd3hjMm5xdm5xVnVLZUxhZG5mSTVDakpyMTlVQ0VBRWR3?=
 =?utf-8?B?czF5NysrVkRRaTUzY2FtSEF5anF0b1RmcElqU1FHOHd1RmcvejlYamloSFNH?=
 =?utf-8?B?bU9pREVCd29GeHdveDJieWFCeVBmUXk3aXNNVjJrc09hVXcxMXdOSmJVVUpl?=
 =?utf-8?B?bWRONmZ2SGZ1TUpTYzRmNjV1M1RMTGhycm9ZclA3TWYrczZBN08raTJWUUs0?=
 =?utf-8?B?ektPVXhSdUdHdHFIQnJUR0EvRFZXL2ZjUzVOellrdjJ0SVpTc2xUUmF0YlFZ?=
 =?utf-8?B?TUVacDRDelFJUDJMTlh3bnVTQllnaVFwTm9pUlJrSU54UnpNQlpGRjJ2Wlg1?=
 =?utf-8?B?eWdCczM2d3hMOVBVc2tyVlhwdGZrL3J4WXlZSjRONllDVHRrNFFDRkUwRk95?=
 =?utf-8?B?MmY1aHNKRVR0OVgwMU51OTZBWmxCMWVIV0lMaC9HV1pRb2JQM2lsUzkyNGRz?=
 =?utf-8?B?M2JJdWFYMUtlcVBaT1BvZGlBTXdGbE9mRGdxRldETkkxekVNQTNBMWFqNUZB?=
 =?utf-8?B?M0pyWnFBNzB4RWh5ZzAyaThzK2F2eThoNHRGTlJiUnN0ZlpIREVaZC9mYlpX?=
 =?utf-8?B?UjYyN1NHNU9hUjJYQWNMNnQ3UDIvdlpjUTM5d1pmdDhZdmdsNGpUQU1KbzhR?=
 =?utf-8?B?N0ZHUy9zdFZHSDQxQllXM3gvZHVFS1ZOdXBieWFtWUV3aGJKK3dKd0ZGSHp1?=
 =?utf-8?B?ZmhNbHRabzZkbDZTeWxCMG15MG1rSTJMa2lVY0k2Q2QwL0FjazI2YVZvU2hn?=
 =?utf-8?B?MFE1MEttclRXclZaY0MzMUxweVF4cy9XTVRWbUduL0NYT0V4Y0EyRlNwS2lP?=
 =?utf-8?B?MENKaWRseXB3UWVuWDVmSlZHOE16RUJicE5FMFBORUpaSTZHejRuQnpsbkps?=
 =?utf-8?B?bEpPbzFFNUd3TWo5cjU4WE5UUU9iTVpDLzc4d3daellsWFNUTDYzanc2ME9z?=
 =?utf-8?B?UTg3WkNDNkdZNFVrektZRDlIUElTZEVGcTZHL1dnOEVIcUZ5aUsxVEdVTnpa?=
 =?utf-8?B?MlJqdTEvUHNTbjhsZEJPSnM5WEE1UjhrWURVQmZOUkhsY0tzSCtiRmh2TXd6?=
 =?utf-8?B?TndVY2Q2eW1zOExacmptK2FpWWd1ZWZRNDAyekE4WXFwc0U2ejFrRnp5UHZB?=
 =?utf-8?B?dnFDdTRmU1RGVndqMENOMDd5ZmF5eHZKU1RmQjFvb2xBZlZMOUZxNXV5TFlM?=
 =?utf-8?B?aFhkczRqNHpTM2Q0K05zeHgzTnlvVkRaVWNyWG0wclNCN2RoeER4ZFFFOXBE?=
 =?utf-8?B?bmovYVpFd0hGUmpqSEtSY3NySndPYit5cFpSOTgvbUZyRnJLR3Z3TDNEUnU1?=
 =?utf-8?B?K2FzOWZHdUgxQXN4SFVhdWt3cm5HVFNVNUFtVGpOU2pLN3dIVVREV0oyT0U3?=
 =?utf-8?B?SGJHemRYcnRyS1lmaVRJNzRPc2ZxaW5acDV6NmxLbXdIUEJmdzF4eFg4MlR0?=
 =?utf-8?B?SzI5b3FYa1pramNWMEU3TExZN2hjRVVBSkRkRC9Mdkd1S2E3a1NFc3puV1JS?=
 =?utf-8?B?Q1FDcnQxQzUrZTRKazJ2a0o5d2JiYndlRDd5YmNMMWZsTDYxeElPS1Fnc0l2?=
 =?utf-8?B?cmFwK3RWZTN6RmtlK1JyaXZSVjdDdDEwdVZKeDRuVXBkcTcvZGdVQWxpdEFr?=
 =?utf-8?B?WjhaclJqa05pVTVlSytyUEVMV21QVmF6U0I0TnpMcGFObmtucTZ2TmpVQlRO?=
 =?utf-8?B?WXNsRjMzaHVicVZwMGYzVkhXWWdlNzd2WFNDZG40TU9rL0oxRExSNVdEdHBn?=
 =?utf-8?B?VXJZMUJOYUt1QW96RkVvR2JCR3ZLN2Z4YUZjd3NiajIyUzlpQ2M1VEhtMFJp?=
 =?utf-8?B?WC8zTHlubEc4U2ZabmtESWU5NlZGMWFZdnZGZ21pVlhyOXVMQ1RaR0RQVVRT?=
 =?utf-8?B?ME1MeHRKeHgydTEyMTFXSmllMXpabktjTnBCc0ttY3lob1hvUUorUHRFeG9t?=
 =?utf-8?B?blBsTmFuc3NQL3ptbjRIcTFlU1lNUnZMNDlwTEwyYXZSaWpwcElaQnJxNEk5?=
 =?utf-8?B?NnBReEIwNUREN1R5bkMvR0YyODBicFJsM29GcGtYNnh3Q3hza3cxRmtDRW5P?=
 =?utf-8?B?RjRwYmRCbHFSQU1NT1NnemFoR09NdWRXT2FCRWszMjFoakpDdEt3Rlg5VU5m?=
 =?utf-8?Q?S1M3MzoKvLT9FITW8i1BxU0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QlY3dmNEVVlCQ2FvQUVsckJDUjJqS2s3TUUzQ1JYelNvT1R2dE94eFkxcEN6?=
 =?utf-8?B?bmR0YTNweEFIWTVxK2RnakJZQlhjYk51WGk1dEhzQ2FPc1hLWk5xdHJQSThJ?=
 =?utf-8?B?QjV5K2pXb1NhV0l4YW9VU2x1MCtCRlQyZTJMb0xYUTVWUUtkTTIrUXByd0V5?=
 =?utf-8?B?ZGdnQzBVUnczcy9wc2p1NGVtY0NWUFpPOEVxVjB1dzIrck1ONkdHM2hMbkky?=
 =?utf-8?B?REs0eUxzZ3gvM0tsL2Iwc0xKVGUrR0VaaFBzdTdvK3R0R3NjQ1BXcHJQT28z?=
 =?utf-8?B?YnEveVd1ZnBXVWp2Y2hZN2Noa1Q1THh4M2QycmNyY3YyTzJYQ0dYVC9UR0s5?=
 =?utf-8?B?MkxCbHhOcXU0TVR1VWpkZEJGeWNFUVN4UVNhckFQVkwwdGljV09POHhoNnVL?=
 =?utf-8?B?UGpvUVpqaDZmWWc2TStpc3ZnNVhGbkZpNUcyQVovR0dSYndwa3pja3RlT05P?=
 =?utf-8?B?azF5WGlqenl6TVpyV2ltREhOeW9UUERqVE10bm9tejhZYmhwNVUyYWhpV1By?=
 =?utf-8?B?cXMrWkY4TGZkRGUwMjdTbjlMZEdpU3RIdi9ndG4rM29xMDdGbm5YU1FzVnlI?=
 =?utf-8?B?akNGMloxV1BQbTFtbk5QRE1kWGswMWwyL09kVkNBMEtPeXJHNW11T3IyM3NG?=
 =?utf-8?B?RnJWemhBUUJiWm1IK0xaakJlTk41eWIwcC9UY0FTNmtjOStQbTdlWTVxZVpN?=
 =?utf-8?B?aTZCQnp3T0wyV1FldUdsS1lDSnVEYmtZTk1CK21iYjl0dEkwNmNGWG9iNW1R?=
 =?utf-8?B?WURFdTdkYVg2amNlSXQvOW50dlR3ZHhoa2t5RVdheVQxSzVqUTdmVk9OTXZy?=
 =?utf-8?B?WlBUYWNRd1d4b09QRFI5cVRRUlF4WEVwM2Z5UFowK0I3cG9RRzZnT2MzTHE3?=
 =?utf-8?B?Vko1TGIxT3BFRnRoWmJnRU5pSWtOQ2ZvWGRFK0tZWU5sb2gxc0ZJbjVjaVJP?=
 =?utf-8?B?VG5BSlVSS1N4M1hlY3Y5SXJycjVIU0JmTDdwb09vVTJQQlpxVERCSUl0VE1F?=
 =?utf-8?B?QkwyU2doYXVLR0w4RDc4dUNZTU5nczB6NFJpckdBMk91czFPWmJUMHM0VFFJ?=
 =?utf-8?B?L21hMkh5MkkxVnp5TDdFOVR2YUJ0THZLV21ud0hhVTliRkVoelRqbHA0dUZy?=
 =?utf-8?B?MmpVTzNQNGU5RERPOVpld1phWklrK2JIQTV0M29yUlE3Y21wNTZqZEJlMW5w?=
 =?utf-8?B?QWl4dkhyM3pPNWpNTGdOV25uemZqZ0wvYWlXUDNzNm11US9BZHNwVGdMemsy?=
 =?utf-8?B?aHZCcDZFZDBwc1AyeDBZR3pkTnVZNzAydHl3WmFhaWxWM0dWS3QrYXlpZzNB?=
 =?utf-8?B?L1JPM2hYQ1RId1ZBZkkxTFFORWExRTNrRU1EVXVQcXlwTWRBYzRnTG1lSmpX?=
 =?utf-8?B?MFAwd3ZXNHZHMmVHQTM1cisvY2ZCYU5xd1dobXR0VG8zY080TThpRTZ2YlZN?=
 =?utf-8?B?YWdNY25HMm5HT05DNGJzd2VGUFpOYklON3hkSERHenZLU0Mvd1ZoOWJ6VGZs?=
 =?utf-8?B?MEc1VVdTYnhPR2N3YVI1K3NHTXp4eDYwR0JZcGVIZ1BhMUh2bW90U2F4K1Bk?=
 =?utf-8?B?YmNob2dKaVhRaUhWenVXVDVWOXVvVlMvUWYrSW5EQ1p4R243cS96cStJWlF3?=
 =?utf-8?B?REZzZ2EvSVJkMFg3OUhMOEpDeCs2M2NqMC95d1ZtSVFpT2hjY21kcTR3aG5V?=
 =?utf-8?B?d05wME1Ld1FHaUd4andFSWo0YkphZ2JhamZXTWllNmU1SVE2SUVsRE1XNnM4?=
 =?utf-8?B?YklOTFh2TlRQRXFhRVVhcDJkNFJnM0dJa3Q0NDBXcTZTZnFxc3hwLzIvTkpB?=
 =?utf-8?B?cVNNN2VRTS85R0F2ZTJHNHBVVXZrbWF6MitaTmRLVm8rU2hEencwcnkzcWhH?=
 =?utf-8?B?TkZyZ2NkamdaRnBOV1gxTERCZDJQR0RqczEzT0lvMnFZQzkyYnJHbFlZN1g1?=
 =?utf-8?B?dWJveGxJYm5JVG55bnJWU1NESmtkSjZHWXNJKzR6TlZIcllYOE01MjE2VHY3?=
 =?utf-8?B?TmdacS9meHB1RGFoMmdvN1daUFNzV2ZsKzdlakdiT0pMVW9xOHZCV3QwdUlG?=
 =?utf-8?B?eVNxYjU5U204d1R5VGVCNWcwN05ZSWJId2Q3emVKdEdvV0hGSTBYR1FTOW1i?=
 =?utf-8?B?WkV6OWlkQmZjK0tqTXN0S2xGcVA0WElxS09EY1hFdGM0c2FQczJzMTdRSVVW?=
 =?utf-8?B?cHVhUjNGR2JBeVQ5ZWZPNnZrakNybGtZOGNqZ3hPdTAwbEh2NkZCNUg5MXRJ?=
 =?utf-8?B?MEZ0amprL0ppS1BLREk0U0UvMGh0eDdJTW5mMCtJMzJyT3d2YmpaaW02SjhR?=
 =?utf-8?Q?AAj9noWd0xaS3XDPQP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae8c91a-65bf-4e4b-0fa1-08de73904417
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 10:34:18.7516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lvzPX5R+kzXTsVDOkFU1402ABiPI6oAqsz2uwJLtXhSuB2smqU0yLFOa1vW96JnfU9HfJArLR2A9/1RWoWDmBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12076

PiBTdWJqZWN0OiBSZTogW1BBVENIIFY1IDAzLzEyXSBQQ0k6IGR3YzogQWxsb3cgZXh0ZXJuYWwg
YWxsb2NhdGlvbiBvZg0KPiBwY2lfaG9zdF9icmlkZ2UNCj4gDQo+IE9uIEZyaSwgRmViIDEzLCAy
MDI2IGF0IDEwOjI5OjEyQU0gLTA1MDAsIEZyYW5rIExpIHdyb3RlOg0KPiA+IE9uIEZyaSwgRmVi
IDEzLCAyMDI2IGF0IDEyOjA4OjQzUE0gKzA4MDAsIFNoZXJyeSBTdW4gd3JvdGU6DQo+ID4gPiBD
dXJyZW50bHksIGR3X3BjaWVfaG9zdF9pbml0KCkgYWx3YXlzIGFsbG9jYXRlcyBhIG5ldw0KPiA+
ID4gcGNpX2hvc3RfYnJpZGdlIHN0cnVjdHVyZSBpbnRlcm5hbGx5IHVzaW5nDQo+ID4gPiBkZXZt
X3BjaV9hbGxvY19ob3N0X2JyaWRnZSgpLiBUaGlzIHByZXZlbnRzIGRyaXZlcnMgZnJvbSBwcmUt
YWxsb2NhdGluZw0KPiB0aGUgYnJpZGdlIHN0cnVjdHVyZSB3aGVuIG5lZWRlZC4NCj4gPiA+DQo+
ID4gPiBNb2RpZnkgZHdfcGNpZV9ob3N0X2luaXQoKSB0byBjaGVjayBpZiBwcC0+YnJpZGdlIGlz
IGFscmVhZHkgc2V0LiBJZg0KPiA+ID4gc2V0LCB1c2UgdGhlIHByZS1hbGxvY2F0ZWQgYnJpZGdl
IGluc3RlYWQgb2YgYWxsb2NhdGluZyBhIG5ldyBvbmUuDQo+ID4gPiBUaGlzIG1haW50YWlucyBi
YWNrd2FyZCBjb21wYXRpYmlsaXR5IHdpdGggZXhpc3RpbmcgZHJpdmVycyB0aGF0DQo+ID4gPiBk
b24ndCBzZXQNCj4gPiA+IHBwLT5icmlkZ2UsIHdoaWxlIGFsbG93aW5nIG5ldyBkcml2ZXJzIHRv
IHByZS1hbGxvY2F0ZSB3aGVuIG5lZWRlZC4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBT
aGVycnkgU3VuIDxzaGVycnkuc3VuQG54cC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJz
L3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jIHwgMTIgKysrKysrKyst
LS0tDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMo
LSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpZS1kZXNpZ253YXJlLWhvc3QuYw0KPiA+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3
Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jDQo+ID4gPiBpbmRleCA2YWU2MTg5ZTliOGEuLmMyZGU5
ODMwZTFlOSAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aWUtZGVzaWdud2FyZS1ob3N0LmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0LmMNCj4gPiA+IEBAIC01NzUsMTEgKzU3NSwxNSBAQCBp
bnQgZHdfcGNpZV9ob3N0X2luaXQoc3RydWN0IGR3X3BjaWVfcnAgKnBwKQ0KPiA+ID4NCj4gPiA+
ICAJcmF3X3NwaW5fbG9ja19pbml0KCZwcC0+bG9jayk7DQo+ID4gPg0KPiA+ID4gLQlicmlkZ2Ug
PSBkZXZtX3BjaV9hbGxvY19ob3N0X2JyaWRnZShkZXYsIDApOw0KPiA+ID4gLQlpZiAoIWJyaWRn
ZSkNCj4gPiA+IC0JCXJldHVybiAtRU5PTUVNOw0KPiA+ID4gKwlpZiAoIXBwLT5icmlkZ2UpIHsN
Cj4gPiA+ICsJCWJyaWRnZSA9IGRldm1fcGNpX2FsbG9jX2hvc3RfYnJpZGdlKGRldiwgMCk7DQo+
ID4NCj4gPiBJdCdkIGJldHRlciBjYWxsIHBhcnNlIHBvcnQgaGVyZSwgb3IgaW4gZGV2bV9wY2lf
YWxsb2NfaG9zdF9icmlkZ2UoKS4NCj4gPg0KPiANCj4gQWdyZWUuIFdlIHNob3VsZCB0cnkgdG8g
YXZvaWQgY2FsbGluZyBkZXZtX3BjaV9hbGxvY19ob3N0X2JyaWRnZSgpIGZyb20gZ2x1ZQ0KPiBk
cml2ZXJzLg0KPiANCj4gLSBNYW5pDQo+IA0KPiA+IElmIHRoYXQsIG5lZWRuJ3QgY2hlY2sgcHAt
PmJyaWRnZS4NCj4gPg0KDQpPaywgdGhhbmtzIEZyYW5rIGFuZCBNYW5pIGZvciB0aGUgc3VnZ2Vz
dGlvbiBoZXJlLCB3aWxsIGltcHJvdmUgaXQgaW4gbmV4dCB2ZXJzaW9uLg0KDQpCZXN0IFJlZ2Fy
ZHMNClNoZXJyeQ0KDQo+ID4gRnJhbmsNCj4gPiA+ICsJCWlmICghYnJpZGdlKQ0KPiA+ID4gKwkJ
CXJldHVybiAtRU5PTUVNOw0KPiA+ID4NCj4gPiA+IC0JcHAtPmJyaWRnZSA9IGJyaWRnZTsNCj4g
PiA+ICsJCXBwLT5icmlkZ2UgPSBicmlkZ2U7DQo+ID4gPiArCX0gZWxzZSB7DQo+ID4gPiArCQli
cmlkZ2UgPSBwcC0+YnJpZGdlOw0KPiA+ID4gKwl9DQo+ID4gPg0KPiA+ID4gIAlyZXQgPSBkd19w
Y2llX2hvc3RfZ2V0X3Jlc291cmNlcyhwcCk7DQo+ID4gPiAgCWlmIChyZXQpDQo+ID4gPiAtLQ0K
PiA+ID4gMi4zNy4xDQo+ID4gPg0KPiANCj4gLS0NCj4g4K6u4K6j4K6/4K614K6j4K+N4K6j4K6p
4K+NIOCumuCupOCuvuCumuCuv+CuteCuruCvjQ0K
