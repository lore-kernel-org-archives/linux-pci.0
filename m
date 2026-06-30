Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011022.outbound.protection.outlook.com [52.101.70.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283B23E6394;
	Tue, 30 Jun 2026 07:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782805820; cv=fail; b=jlbImMExS/ESM+jDBbIQjSroZpxJOSTO7/GVZhq4WZEK1E0A1sWnv68KBPQUH8oXS2ewNClSI90khQIY7BBo8HQQyHGi7hvhkdqH/Z3YBhEGxIBuGbY1L39aHjxee9NqXHHfon9hdryA8HqmyXVRZ5bR8Csh8RPlp9Md0n+XQe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782805820; c=relaxed/simple;
	bh=w6hZqglnsS6GjMvFJm4DhKS4qg4YBXn2fx5PUR5mHB0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EUXN6yLwOFSm6LSbu05ClhAIDkxni4uVMWK2734TSB6iPw/XhlMn8UWF0q0e/8XAtcrtAZ1YwiS2WoMf1ruL9OB5VuS+sUfLFB5sKu6Tw1fq0rQaj+nRSF7Yt+9v10zWVmxmJaYS8QFQLHJSGQ8oyMk8mH6s/AFtHy3zevsjiDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=k3p6B6Um; arc=fail smtp.client-ip=52.101.70.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="k3p6B6Um"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VAz0nvrX8YOgwZCe9A/8TTQ5J4itfeAj6tyQbzOkkzg24eMsTl/EmmH6M3IWwpgGL/P5UY40OaQ008x/AIAyBrHCYtxhWjHQWy0N4g4fppj86dYchKuz6J1TDZ2onqD/TI4h2Xfa2+b0saWIicZepudbs8avTfDUAgJNWud6qPQKfjq7nlY0UQmu6JN0SrbYR8doyFV/u2VeUz91Y7gkBeFpHC2Hev8a6exWeouM5qZR5ZTYw/X/lc3qklhoL+teLPRLnh0W+b1lw2U5083JGe0Vxy2ST0YsWZEp7sjULZ/J8NtCbaJXyyGpZxEJWfOiAgUwxbK2VhMLCjm1hfDylg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6hZqglnsS6GjMvFJm4DhKS4qg4YBXn2fx5PUR5mHB0=;
 b=Vwul31dDc8ar0zNXAPLTwzjjMyAwwPSUIUQkPeaitCTxIn7K5fFELWXKdghY8poK1YZ+JUdZ6FmA4+o3+hUBU5mitTfFrOovsi8datv4co0VFcIm0BQUw/aHC5/67N9fdKP2spV9GD89mUbIGeGmVqEmyG+Nny0ScZrBt5L7C9SPfMra5SiA86bdg4ByN36NXoKGjyOQIXPakkEnhwxicVTcbnQtb8Cr6Ewu9BmQU6PqyzyKoCAHpt5RNpyYiEK5zK0I43xrqOb4r+4jpJhgKmhjCIWl1iS9d27v/R3+WqgUtaDOVxxdXvaxHAHXEQdJhfsBZHpBtOIsEE6zZ8xU+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6hZqglnsS6GjMvFJm4DhKS4qg4YBXn2fx5PUR5mHB0=;
 b=k3p6B6UmL0/+OqWdvMn7C8bwOrg0CzzbRennp22V70GIVBwbhVohfipoCUIsY1zSVONcYnGIcX+QMOlcdNxHHtq5RHWf3tSGy6q9bZTEr8NEuGScKsEPndN5iCI759okjpecr016aFYQnk5e41fQMllOfU9AP7ek8yLqqLkHhpHR4jE+1ZyJIdSUvAeZ3q3lcsR3pshaWvhPpVRsNE/2zHdHVElCXpbfpfnRZjQYzRHvkT+ltyuQA1eMDnhufzHRshHhVWfTbT7NtMyJeee0TZyTSJLgQnSDqB9c8F+6C1HE7Px20pIgYdD7rHjoE3wle0/BZpGyjNpj1KJmzT9WGg==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AS8PR04MB7701.eurprd04.prod.outlook.com
 (2603:10a6:20b:293::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 07:50:16 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.21.0159.015; Tue, 30 Jun 2026
 07:50:15 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Manivannan Sadhasivam
	<manivannan.sadhasivam@oss.qualcomm.com>
CC: Hongxing Zhu <hongxing.zhu@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, Frank Li <frank.li@nxp.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "will@kernel.org" <will@kernel.org>, "Sherry Sun (OSS)"
	<sherry.sun@oss.nxp.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 0/2] PCI: imx6: Improve PERST# fallback logic
Thread-Topic: [PATCH V2 0/2] PCI: imx6: Improve PERST# fallback logic
Thread-Index: AQHc7BMKFOTGzILnyUGrqarSljpmMLZW6aEAgAABGoCAAAcBMA==
Date: Tue, 30 Jun 2026 07:50:14 +0000
Message-ID:
 <VI0PR04MB12114AA4916834C5875D74DFE92F72@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260525065443.2338629-1-sherry.sun@oss.nxp.com>
 <178280401285.286395.10401291228239552702.b4-ty@b4>
 <wj7dtqwadw4mletyq2s2an3g74acpmvvnkbogsdztgb27s2lul@i6ogmrnbd6to>
In-Reply-To: <wj7dtqwadw4mletyq2s2an3g74acpmvvnkbogsdztgb27s2lul@i6ogmrnbd6to>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|AS8PR04MB7701:EE_
x-ms-office365-filtering-correlation-id: 8042689b-75b5-4f4c-302c-08ded67c38d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|23010399003|376014|38070700021|4143699003|11063799006|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info:
 a4EWuYrU1kI/t3DPBxL88a/oaXDvthUCjBJKIp5MfBeXGXppea8tExw5hRtn0omIT0KREkWJPg30qafFp6xVVoYch60E6DWWMgvHEZyyUSX44fw0BdWfrxV3zU2VIa9668KQG8HcGniIeQhSDgl39f/cWtdlkNen75z+J/0Cp0irN4hoD1l8n1QibmdlaQab5nJPRFlAMzYGcZQsWUHoYZUSfQa7V1c8ornd7ew/JpVXrtcpgKySVltTmD0P/gwBpVBucQmeeq/U61RJRadBJjSb9cilA8iqLvM4iskFi92F0/oNPZ8SGzdWkIelvZRE1mqi0FvNJOhozLE2h6NJBHz85Ty/jcP3ShA7UDIuEvjz/9UoWKoqPcOKoPFaBZeJpMchxmpySi+Lx+TI0E3toq/QSAYPKjdit6uJTZlJJu2lcYDNUY9re/CcjXWW9FBOWX+8wSxOgUDmzZYeabtjlLViY52wEab8SyeLtN0pGKdaDfpsFpp1JEfAkHxZT72txs8DYR3l38s6+Ew04l8uBKMcUHTY1UkbsChr3Qpns+tQh4ARvXZ/452ryoMvb324gTb/yZbFfx+UJ57tEGJzKFzfe1smOd8KPFELisyf4zfy/nYtW95rSwGfFzNG2UT3pT5CPd+yev38UBFFIj94jJFBCMz6SW6ikGoLy/7a1AOMjWV0uyveooE6C5NWQkZatZBb3bXIcLXKWGVKExZrALCAFdfxKJvy9p0XGvsmFj0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(23010399003)(376014)(38070700021)(4143699003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZWUzbk0xaGFUMDVyRFNUMkFVMldtTzJNS1FyQTBxNCtGQmJvT0hkQVlKQWRL?=
 =?utf-8?B?bUNqeUNhN2UvSWZWM21BeU8zUmdZWHJpQkhkcXhNZC8veGNpWUM3T3ArSG5l?=
 =?utf-8?B?T0JVRkxmWHRzWlJjaFRlZmN2Q0RGM1BkRGxsY2ZHRmdGWFcra2VqdVJGNHZx?=
 =?utf-8?B?MDJMWWEzZkx0UVh4Ym5IaFAxVTJ5SFlPcm5qUnNvOWpuTmxDK1Arci9MVHJo?=
 =?utf-8?B?bU8ra3NaOWpWSmhPNHRiUzg2RVg4c0RSMmlyVHA3VC9KRm9lVGpqMDlYMElN?=
 =?utf-8?B?OXFCVkNhWmxUNms2b294em92bzByZkwxaVBWMXloaXBlSVdFMG9tMThQaFRz?=
 =?utf-8?B?M0Vabk10ZTl1N2RJb2FtM2pDSGlzRjdwNGtkV2hXUDlHak1NZDhua3Fuckg1?=
 =?utf-8?B?VWlONTVjMlFsNzkxM091dmdzQlpuVmZvb1hwSkEvYnpnS1IyTm41RERlMXY2?=
 =?utf-8?B?bVpabVFMajlKQXA4ZStEL01KblI3ODR5Vk1sczRFV2Fwc0JhYWJqa01pMVJi?=
 =?utf-8?B?cC8yZlhrVTBjUHBWSzlqUXhCMURZZUhkay9sTVhFNTVMTzJ0NDZjWmFZeUpS?=
 =?utf-8?B?RDhDdHFuQ1pIaGZadERJM1BkMGNqeFYwdklLTWkrSFZON2lxN3NpeCtERExF?=
 =?utf-8?B?SzVTQ0xjbkROQmNNelZnUTBNTm5LNDA2TmI2Q3lNRnJ2UTh4Y092NzNhNnlX?=
 =?utf-8?B?UDNudCtrZXZ2WVMrRzBnaGtvcHNLL0I2SzF3N1V6RnJ4dXVhdHRMOUlNb0xi?=
 =?utf-8?B?NzlWWnZMWVhVcTQ0dVYwVUJ3UzJ0Ly9xN2k5RGUraUpyK3JKblE2d0YzMWdI?=
 =?utf-8?B?eDREQkxPbnNaaHZxbEpmd3hXM0ZSV3RXTFVCbjF2ZFFocVhBZ1I4MENrWXVi?=
 =?utf-8?B?NnBxV2EreGZoTE1NeERCcS9CTUJieldZaUNqbndaeE53V3ZlV1NoamV3V2Qw?=
 =?utf-8?B?MlUyQ0JLUmRuaXVvUFlWeVhQd2RnNlMwa0JyM2NDRFlGM2pCSnJOeWgydVFa?=
 =?utf-8?B?Yk81TjFrNGp0SEE3K01ydE83RWRIblFYMk4wREtibGRqZGNxWnAxRS9ka2lv?=
 =?utf-8?B?RGxhbkU3Y3RVRFBTQ1VvWVEyRUtvQ3dlZEw0aHhDcE5OaEVreXJtR0tEenNM?=
 =?utf-8?B?TDVjclZVa29HT1RPTlFxZ1lXRFA1ekJxdFp3eVZhWWhUa284T1krWkNSaWNk?=
 =?utf-8?B?WHB6V0dJTXpZc05HSHErdmkyNHlVYlkxa1c4RDk4a0pGMzBsSXEyQ29pdE5C?=
 =?utf-8?B?Vm1EUTVmNXhzWVhrdFoxcUR6MTJ5RnlkYmZJSDI1RThDMHdFR0FiWUZOdkRU?=
 =?utf-8?B?Y28vLzNCNzhZOC9hYTdhMEs2MEkwa1VLMlV0ZHRrUEh3UmxpcmpoSWk0T1Iy?=
 =?utf-8?B?enhpUVFPV0hCM01OazR5bk1NU2xIb3FEYjdsK3JjbG5pVUN3OTlhTjUvWDhG?=
 =?utf-8?B?NDgwcE13Z3FWeStCV1hWZTY4cFdTQzNKRXF6UjYralB5OUEyNDcxdUl4MEp1?=
 =?utf-8?B?VEN3OTRVZFVRdDdXOTk5VXpVQUxkQUY4L2pGUWRqSzhZRENFa3RvWklWbFlN?=
 =?utf-8?B?VDRCdDh2UmRMN2VKNFNMaSs0eFAxTHc4WU1xdFltMnZlaHFjM0w3a3p5YUV4?=
 =?utf-8?B?Y2taVy9oR3d4MkF2cjRVemJ5Vm1EL3JvY29OekJZTHI4b04wMC9pQTJBMnFz?=
 =?utf-8?B?RG4ramxKQWpKYi8yN1NFRUxjWXBQUVFPcVhFdlJrRTc5TEM1b0Q0R0hScWJR?=
 =?utf-8?B?ekpUc1E1TTBoMVNBT3ZCSjZrRFFUT1FiSDg0a1FMMVVQbk12dWJ0bi9QY3gr?=
 =?utf-8?B?K2NoV2thdFFtTjA2TFh2d3VMK3ozUFlJU0dKLzJSTE9OZVhJcitLVHFkczZW?=
 =?utf-8?B?R0JWT0RqMkZSY1NOYnZqZjluTG5xWnZ4Q3ZFcDd6Ti9LbjlvN2RlcDFjOUdH?=
 =?utf-8?B?WjJJM1lrUm4yOEpSZFZPUXk3QmFDb1JuWklmR1RHbXhMMVpCVUhSMUppVWpm?=
 =?utf-8?B?cTlmaGhwZWpDanl6OWlQL0FucURDUVFNMkxlVkh2aGd2TTdXcmZWSWU4OWZE?=
 =?utf-8?B?OUpMMys3N01jVSthVzYyempsUTBLdXVqMDJoVmVPODNUUlZrbDJ6VlczczJF?=
 =?utf-8?B?eHJ3cGtMVDFvVlNaRFc2aFVJNWFrSktDbnROVWhwZ1NrTDNhbmMyZlhYd3hZ?=
 =?utf-8?B?RDZuVlZDdkRib0dDV1pnTTRmejhMTENqd3ZsckdPOGRRU0EzVVVBVXdwYXhN?=
 =?utf-8?B?TS92UjYrZnRsbTZHSnJXVnR1OTlXNVp1Rjlod3VZVU9zdDFOeHdta0VUYUFQ?=
 =?utf-8?Q?JZdqdZ55L+Ml0xY8tY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8042689b-75b5-4f4c-302c-08ded67c38d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2026 07:50:14.9758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Jcxlbq7HgYdSuekxc3vHJqjhn3sV67S90iQboH8yWJbc/VZY3kRlyYc6O4h/UZGzelvoqEz1+jiDLQvV61W6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7701

PiBTdWJqZWN0OiBSZTogW1BBVENIIFYyIDAvMl0gUENJOiBpbXg2OiBJbXByb3ZlIFBFUlNUIyBm
YWxsYmFjayBsb2dpYw0KPiANCj4gT24gVHVlLCBKdW4gMzAsIDIwMjYgYXQgMDk6MjA6MTJBTSAr
MDIwMCwgTWFuaXZhbm5hbiBTYWRoYXNpdmFtIHdyb3RlOg0KPiA+DQo+ID4gT24gTW9uLCAyNSBN
YXkgMjAyNiAxNDo1NDo0MSArMDgwMCwgU2hlcnJ5IFN1biAoT1NTKSB3cm90ZToNCj4gPiA+IEZy
b206IFNoZXJyeSBTdW4gPHNoZXJyeS5zdW5AbnhwLmNvbT4NCj4gPiA+DQo+ID4gPiBUaGUgcGNp
X2hvc3RfY29tbW9uX3BhcnNlX3BvcnQoKSBzaG91bGRuJ3QgZGVjaWRlIHdoZXRoZXIgdG8gZmFs
bA0KPiA+ID4gYmFjayB0byB0aGUgbGVnYWN5IFJDLWxldmVsIGJpbmRpbmcgYnkgY2hlY2tpbmcg
Zm9yICJyZXNldC1ncGlvcy9yZXNldC0NCj4gZ3BpbyINCj4gPiA+IHByb3BlcnRpZXMgb24gdGhl
IFJDIG5vZGUgYW5kIHJldHVybmluZyAtRU5PREVWLiBUaGF0J3MgYSBwb2xpY3kNCj4gPiA+IGRl
Y2lzaW9uIGJlbG9uZ3MgdG8gdGhlIGNhbGxlciwgbm90IHRoaXMgY29tbW9uIGhlbHBlci4NCj4g
PiA+DQo+ID4gPiBbLi4uXQ0KPiA+DQo+ID4gQXBwbGllZCwgdGhhbmtzIQ0KPiA+DQo+ID4gWzEv
Ml0gUENJOiBob3N0LWdlbmVyaWM6IFNpbXBsaWZ5IHJldHVybiB2YWx1ZSBoYW5kbGluZyBpbg0K
PiBwY2lfaG9zdF9jb21tb25fcGFyc2VfcG9ydChzKQ0KPiA+ICAgICAgIGNvbW1pdDogNGI1MjM1
NDQwMDhhYTcwY2RhNGIzNGMwNTg5YmJlNDcxNzJjMjYzNw0KPiA+IFsyLzJdIFBDSTogaW14Njog
QWRkIGlteF9wY2llX3BlcnN0X2ZvdW5kKCkgdG8gaW5zcGVjdCB0aGUgcGFyc2VkIHJlc3VsdA0K
PiA+ICAgICAgIChubyBjb21taXQgaW5mbykNCj4gPg0KPiANCj4gSSd2ZSBzcXVhc2hlZCBwYXRj
aCAyIHdpdGggMSB0byBhdm9pZCBiaXNlY3RhYmlsaXR5IGlzc3VlIHBvaW50ZWQgb3V0IGJ5DQo+
IFNhc2hpa28gYW5kIHJld3JvdGUgdGhlIHN1YmplY3QvZGVzY3JpcHRpb24gYXMgd2VsbC4NCj4g
DQoNClN1cmUsIHRoYW5rcyENCg0KQmVzdCBSZWdhcmRzDQpTaGVycnkNCg==
