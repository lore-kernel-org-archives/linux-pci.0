Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011024.outbound.protection.outlook.com [52.103.43.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCF94CC62E;
	Mon,  5 Oct 2026 17:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791220236; cv=fail; b=m3MPiWoexgTPvpNMhd7f+FGdKmVvrmYkcFyC1pMXtcDjWxBPhTf+Sl+KGt0OU9HLQe7Zf5Xf4A02rSJQ+bnNeaUuTlFbLRVAh2FcdMT5RxBu0ABrxcJd/HY4yvq8YHa/WD5o4kQPpGkm1EPUEYxY0tO+Dz7x4LF1vBVg6K33r7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791220236; c=relaxed/simple;
	bh=8qQZ4ITQrR2v9xvHpPNj7Ha5s5sXXrvKdMSUkW2a95Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RaEoOwQrE8i5y9QtZnXZ3dB4Kpn/RkbwwOkxkflqTwK3yGt88SwimrDFwrj7x634OlrZ02MDUHJ5gBcRSD1r3ePTUbnfZzwykQYhUVvHTNMMpatpdyoCWa/5T/wUHFx/uvHSSo5g0kCUDxFT6uU/+tnwOUO13EeaohRbOG5phIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=M1tiZZXH; arc=fail smtp.client-ip=52.103.43.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="M1tiZZXH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZRF4xCJ429xETIBKynAVGzKAxKX6D7vnlm5smeMZTAp+Tk6vTi1FsJ1gh5UM221AGiYSXayuPXK1rmYuSMwo7uVw6frJgcemxrtc+nEwHwzb45pgV9FEHj1q8e1IV1sXiFR7lRwKtI4vMsoiXdpNrkFbDZi4DYgrNVkslzpTkfrDh+FX70a4xDDdLOBxf9xazkoss9k8BA0sjivQIhNPLi5X/RR1El1p/ukb8/bJD5cbOgKCMjiD4XAnGbjZo5U6qqzYZoWiAS06TtPxMKmAX/cD2cj0Y+UdODaW9rq9w5TQsKxsmAgAr7Aqn8jt8DJC3L+SN9DIHu+HFsVKJzJ7cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0850uEpKjeegaxmhsA6nUvPC8ET1ut4fbM+M9c1D/w=;
 b=Vy3o9EXTFF2EvnuQtaLAx56qZ+gCnMQ/vZlhweafMgSx06YemjNubpm6d0ArvSYlXSkG7C9syAxwDTy4xcjTWEAUtIrz11HMqBAQolKT3MpiH9XZojDxz9gX3rbZ640xU1DBiGu1Zxjr3/c8Pus0IdnlOfA1wyd6LMQ3DOckfZWv3N/+8A2g9DaTx0/KbqiCOVK5LjmHGrglGO7IunSeCM6JvREzeOQQNY27DsVePEt1B+BOGLr/M0bOC4C0bxUi4yyKelPTRRbrTXyY9580m/0JSmvX4hYGyr4DkpttFlEgcYFY7ZJNK5qN3pjs6wyl6ycdnM2nke4Nn6nv4FBMHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0850uEpKjeegaxmhsA6nUvPC8ET1ut4fbM+M9c1D/w=;
 b=M1tiZZXHKOx45M1vpW+jF8QuKEYqBehc3XxC8tiInBdu5c2QuAkAEL3Zjwf9DisbFYI9pP8zyoQDEjxolxjJBn5t/eADJ7AYsx86ay2fNILurIwD5gvMTcXXhzMi2Xq8+48FLphY7reCC0pOMnzOk8g/RlQhvtRDqiKUrYBDt4Zjgmkk1kMzk5WbO9q8UJx4W7pMbm0auw81GgD0MeRYAM9u0CBmI6sbIfm4BPZ2aneRoeCcj7K87Kc88qYtxQj4Iu42+DPgqgd3vZJ8w9c/qPX0NUrTR6ziTowBMfIvA2kejE2P8Cjs+hL8DsfA2T+U/5jcQWv4Nn/4At64LoCVZg==
Received: from TYCPR01MB10927.jpnprd01.prod.outlook.com
 (2603:1096:400:3aa::13) by TYCPR01MB10763.jpnprd01.prod.outlook.com
 (2603:1096:400:297::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 17:10:28 +0000
Received: from TYCPR01MB10927.jpnprd01.prod.outlook.com
 ([fe80::c225:1d5a:1a78:c5c7]) by TYCPR01MB10927.jpnprd01.prod.outlook.com
 ([fe80::c225:1d5a:1a78:c5c7%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 17:10:27 +0000
From: Freeman Z <SHD-ISAC@outlook.com>
To: "Kovacs, Alexander" <Alexander.Kovacs@amd.com>, "Limonciello, Mario"
	<Mario.Limonciello@amd.com>, Mika Westerberg
	<mika.westerberg@linux.intel.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "westeri@kernel.org"
	<westeri@kernel.org>, "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
	"YehezkelShB@gmail.com" <yehezkelshb@gmail.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"S, Sanath" <Sanath.S@amd.com>, "Natikar, Basavaraj"
	<Basavaraj.Natikar@amd.com>, "Martinez, Juan" <Juan.Martinez@amd.com>,
	"Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents
 JHL9480 downstream enumeration
Thread-Topic: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents
 JHL9480 downstream enumeration
Thread-Index:
 AQHdSDNPea4qqw1tcEOkT/edQjHT9rbYfQ8AgACtPACAAaXMFIAAN8+AgAABpQCAAPzaBYAAjxGAgAC1UD2AAYHugIAAQ8E/gAAe2FyAAAh6gIAAJxUAgAAPH8SAAAVwgIAABbk/gAlgAYCAADo/D4AGCcGAgAAQnVOAABhFgIAAAdCw
Date: Mon, 5 Oct 2026 17:10:27 +0000
Message-ID:
 <TYCPR01MB10927C563CDDD5216CDFCD4D696962@TYCPR01MB10927.jpnprd01.prod.outlook.com>
References: <f8b929da-b4ae-48ae-9667-3eb93aa0a4bd@amd.com>
 <TYCPR01MB10927E6DC71CDC3B39C26F35196832@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <BL4PR12MB9533BF5ABF7035E6DF151C0A9C832@BL4PR12MB9533.namprd12.prod.outlook.com>
 <eaaf891b-7b0b-4eea-b104-de2c0db7cb42@amd.com>
 <TYCPR01MB1092762E3E179C4A43874BBE696822@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <DS7PR12MB9550558C737D92A5762C3AAC9C822@DS7PR12MB9550.namprd12.prod.outlook.com>
 <TYCPR01MB109271EBFCFBEA8A8855D600496812@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <20260925052727.GV106095@black.igk.intel.com>
 <TYCPR01MB10927DEE310195FA62C67E9D296802@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <TYCPR01MB1092798A529672215ACC586BA96802@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <20260925115041.GX106095@black.igk.intel.com>
 <5d065dcb-a4b9-4e9d-aeee-8a9bd1d875d7@amd.com>
 <TYCPR01MB10927F1B586DACDC97FFB606A96802@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <7822cb02-f32b-4f02-ba65-4b90ebc42ce8@amd.com>
 <TYCPR01MB109279CDE9AAF47B40FD1770996802@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <DS7PR12MB9550D1A8CB397E8C7FF0C7D69C8A2@DS7PR12MB9550.namprd12.prod.outlook.com>
 <TYCPR01MB109276162440B6A8CC34DEC73968A2@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <BL4PR12MB953383C9C73C9715FB9C5A339C962@BL4PR12MB9533.namprd12.prod.outlook.com>
 <TYCPR01MB1092779F2FA9CE76D5A76E4C396962@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <BL4PR12MB9533056AD6DE8C89370D6F6E9C962@BL4PR12MB9533.namprd12.prod.outlook.com>
In-Reply-To:
 <BL4PR12MB9533056AD6DE8C89370D6F6E9C962@BL4PR12MB9533.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-01T14:46:55.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10927:EE_|TYCPR01MB10763:EE_
x-ms-office365-filtering-correlation-id: 88d069ba-86bf-4bab-adb9-08df23038d93
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|8062599012|8060799015|31061999003|19110799012|25010399006|41001999006|260826193500599007|24021099003|15030799006|15080799012|40105399003|2607281247196008|102099032|440099028|26104999009|3412199025;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?mAliopCzJeUYnOA9bCRiTcoNd+/PCqkWA7xagk/wwRn76U39U7wfn/8R03?=
 =?iso-8859-1?Q?g9iqnTejUB/S9Irfan/kXlLB5COXIs+uD8dV68+5Y3hmgvGA0vMgxve9Ou?=
 =?iso-8859-1?Q?ggx7tjjVfRy3Z8X2hFpv8vhvb1GCr5czRJTBV5CfHS6H7BNgVPIiXU3dwz?=
 =?iso-8859-1?Q?P4g6ZXzWQB3Fj4sc1wHqZziHeKOP3Eu1qfXlyFiP7elK1C6CCzmK1WzV8W?=
 =?iso-8859-1?Q?vnMMR7GmlLih6q4SerjJtNhUQ6sHD/f9a3vfKIYUOzbtrm553lourPTTQz?=
 =?iso-8859-1?Q?dU3guS8rBQ+ri2tPeR8XaYUYDBUsyIrNvAkJ8v2rx9YD/dLNKJApCaKQpY?=
 =?iso-8859-1?Q?HDbRvsBcbRv7vOAU2IaFkgroNb3Fg1Oxa0D2MFkeUxA2CsseXywWwQXn/L?=
 =?iso-8859-1?Q?szKHST7tQSo2MqcGTEvALcHdPaRnmNA6cSfVUPGgRs3SN5L3CLo5K0BDtE?=
 =?iso-8859-1?Q?Gf7+zVi6GiczRfhiBperiFloGZMs1WYvnH2xMd4nBOVHaIwIrb8/R46j+q?=
 =?iso-8859-1?Q?4qNl8GD/6J4UqcDsxAKp0mwnVDA/ZG0eJc4gh8XbRea2ZVbjiTy9KVNVG4?=
 =?iso-8859-1?Q?RaN92D8LBd8K9Ziub4egbBrljdnfKd10Epx1/hb8hvLwfdFatq1kEAT0RD?=
 =?iso-8859-1?Q?2+XHkOjSBfqPAJn1HB516gmCWBD3O6//bcQ7yxpEyFIFcELUntbiXb2RcI?=
 =?iso-8859-1?Q?1olX028wFCum/MnO4jMHCYM08JhqPqnRcWQSSHq312pdQGAqLVl9oOOfWf?=
 =?iso-8859-1?Q?ta4qrYBqX3My22ID3v8btA/0uvJOOx+lr/m1nICwA1EpKrmK1nttFgMEyQ?=
 =?iso-8859-1?Q?v+sSf9JOrXNuUNVYNH0JaUsM/35uN/iONiQEmVHJHWSnbcCMmS5FPa0Um3?=
 =?iso-8859-1?Q?obyedYijpBqInbTFe1GQDId5mL/iIWhy5dAno15+JjxYoXTjkCqek5jRzj?=
 =?iso-8859-1?Q?sC4uuKOX3y6y0qJk0hgRaLOsqrXAIbYUowe5VPPM0VP9aQxSb2uGnYRXnZ?=
 =?iso-8859-1?Q?PdEHQ9t3J0uou1EPssQjp0yLBDDQMd8rbS8y8RobzQYYALYy/mGYVvQljZ?=
 =?iso-8859-1?Q?dWkiA8oMevol1DqXMFeJ9SN0KE2rtDCTIEWrp3sfl04h?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?NLZLXsZjAXbeny355F0wXws4mH76RKedXsL0P2mRu+CWmr0xfY78DuCNTp?=
 =?iso-8859-1?Q?2ho/k8QYYjTMWybdgBXl43tH9iyBPPc/1fVP9QDBs1R1lG2D5Ur+rcrWKG?=
 =?iso-8859-1?Q?a5hhmYV8DzbTlKRovI2mwDD2fMSsO0Ou7Dby5l7ym2iC2aGaTNrYrUGYDi?=
 =?iso-8859-1?Q?8sZnntDsFZOdjc/86RATAHTm+BFFGkDM2AodCkP3PN9/xsO2Z2ZbOZMaOO?=
 =?iso-8859-1?Q?A8x/awSvqsnqLhnPghrZspw8PPDju88lCajl5ZgX8woLvss6gJs8baj2OG?=
 =?iso-8859-1?Q?B1lwdfgYuYqLjFwsASuK7dBe96qhl8v9cqlg2mtdM3S7VEicnvBlom2Cuf?=
 =?iso-8859-1?Q?ijS1Dyc2IooywfsHYCbvHM4RkNx/uHABQI+PE4me2bosqAGdjpLkKWz/DP?=
 =?iso-8859-1?Q?i/xA8hJG7yXfKLn0RHXh59II2y+s9QiS8Wj6qPBHxYFsxcW4zsv9yy1y+5?=
 =?iso-8859-1?Q?7DXzzoXTUzEqJ74N15o3gML06vRO9TuTKX6I+gPZo5F3WLtYPEQNj3eQIw?=
 =?iso-8859-1?Q?phdA/jj9OJ9IcP408wwnzSBdffoazW7xXio2B/zEqUj5WvU1bdwclJt1nV?=
 =?iso-8859-1?Q?OToScsnWtQ0F3CPGLwDsz6jj5upH0B81ZykgClXDL6qmFoSJjD20Hfd60P?=
 =?iso-8859-1?Q?BnPE6TyKaSv5YxTJKMY8OAeqZIg7d+8IzWmzUtFLTLv3DkNEXGQvlW8iFG?=
 =?iso-8859-1?Q?Jo6XFTAdK1yyexIJG8WCq10SfhEZs6PRkRVBDxyeP6EAxoTf/5rmVeoTbX?=
 =?iso-8859-1?Q?UYLx6YgtV5Fen5r3up61pEys1U4OqtvCNY0sN0QL9EpE5rmKJ/G3Woqv0/?=
 =?iso-8859-1?Q?MGD+pLuE+3zJ1DoY7NJG79eeeOkNpLrGwUhNs2GUJDAxAeKrKxjWLtlCTr?=
 =?iso-8859-1?Q?Oveg1OsP9sSoSPCKxghAJxd1omR1AjA5g32xITW09Otw/J1B5/8Q2zMbHe?=
 =?iso-8859-1?Q?+CcB1IaMBHEEQMecC1blI2ZxOiJvgQJq45AQdr/02tqn5wcx/UVtRXViLv?=
 =?iso-8859-1?Q?qYcWVr+cf/R2nt5wVUxx/U18jNBR8zmpqX3P70ss3xV0neReV6v/8Edhha?=
 =?iso-8859-1?Q?uneeVxf8FH04Kvs8QiGmpQTkGAk1Ev+sITA6myGnCwkfS7jN2uBO3A51MN?=
 =?iso-8859-1?Q?RI/KgYMvUoexMd70LBHwHvQ/3W/Y3aPNN+kCEsi0vdbx7lPiItq30OZ3LR?=
 =?iso-8859-1?Q?9Xga5XaG6EZ3aMdUZWY2oXA8b6MznYVHgJotbqK5c2WpJjyQOEFpiTZuq/?=
 =?iso-8859-1?Q?45eKLgfSuvDm/L1DpwbhBGuXmEQBe+TB/LO0b7PRdHucW6ea/eSA4whQz1?=
 =?iso-8859-1?Q?l4TCHZYKOqh9X9FuoiUSrd45uXnl9uv4aZpBNmaDGk9vW4mcH/Jw73YNrR?=
 =?iso-8859-1?Q?qqVu1axC/8h7oZz6oRUg/fe1G3xCPkjVlYt2BXdGT5oP0moqegQuQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10927.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d069ba-86bf-4bab-adb9-08df23038d93
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 17:10:27.6698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10763

Hi Alex,=0A=
=0A=
I checked the PCI topology on this system.=0A=
=0A=
This laptop has only one physical USB4-capable port, and I do not appear to=
 have a 0000:00:03.1 device at all.=0A=
=0A=
`lspci -nn -s 00:03.1` returns no device, and `/sys/bus/pci/devices/0000:00=
:03.1/` does not exist.=0A=
=0A=
The relevant part of the PCI topology is:=0A=
=0A=
    00:03.0=0A=
    00:04.0=0A=
    00:04.1-[09-68]----00.0-[0a-68]--...=0A=
=0A=
And 00:04.1 is reported as:=0A=
=0A=
    00:04.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD]=0A=
    Family 19h USB4/Thunderbolt PCIe tunnel [1022:14ef]=0A=
=0A=
All of my reproductions with the Kensington SD5000T5 have therefore been th=
rough the 00:04.1 path.=0A=
=0A=
I do not currently have a second 00:03.1 path that I can test.=0A=
=0A=
Thanks,=0A=
Freeman=0A=
=0A=
________________________________________=0A=
From: Kovacs, Alexander <Alexander.Kovacs@amd.com>=0A=
Sent: Tuesday, October 6, 2026 1:01=0A=
To: Freeman Z <SHD-ISAC@outlook.com>; Limonciello, Mario <Mario.Limonciello=
@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>=0A=
Cc: linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>; linux-usb@vger.k=
ernel.org <linux-usb@vger.kernel.org>; bhelgaas@google.com <bhelgaas@google=
.com>; westeri@kernel.org <westeri@kernel.org>; andreas.noever@gmail.com <a=
ndreas.noever@gmail.com>; YehezkelShB@gmail.com <yehezkelshb@gmail.com>; ra=
fael@kernel.org <rafael@kernel.org>; linux-pm@vger.kernel.org <linux-pm@vge=
r.kernel.org>; S, Sanath <Sanath.S@amd.com>; Natikar, Basavaraj <Basavaraj.=
Natikar@amd.com>; Martinez, Juan <Juan.Martinez@amd.com>; Chia-Lin Kao (Ace=
Lan) <acelan.kao@canonical.com>=0A=
Subject: RE: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration=0A=
=A0=0A=
AMD General=0A=
=0A=
Freeman,=0A=
=0A=
Sorry if this is a repeat question, this (non-returning sub-devices) happen=
s if the dock is plugged on both the=A0 00:03.1 & 00:04.1 path, correct?=0A=
=0A=
Replied or Forwarded By:=0A=
Alex Kovacs=0A=
845-625-4422=0A=
akovacs@amd.com=0A=
=0A=
-----Original Message-----=0A=
From: Freeman Z <SHD-ISAC@outlook.com>=0A=
Sent: Monday, October 5, 2026 10:39 AM=0A=
To: Kovacs, Alexander <Alexander.Kovacs@amd.com>; Limonciello, Mario <Mario=
.Limonciello@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>=0A=
Cc: linux-pci@vger.kernel.org; linux-usb@vger.kernel.org; bhelgaas@google.c=
om; westeri@kernel.org; andreas.noever@gmail.com; YehezkelShB@gmail.com; ra=
fael@kernel.org; linux-pm@vger.kernel.org; S, Sanath <Sanath.S@amd.com>; Na=
tikar, Basavaraj <Basavaraj.Natikar@amd.com>; Martinez, Juan <Juan.Martinez=
@amd.com>; Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>=0A=
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration=0A=
=0A=
Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.=0A=
=0A=
=0A=
Hi Alex,=0A=
=0A=
Sure. Attached is the ACPI dump from my ASUS ROG Flow X13 GV302XV running B=
IOS 319.=0A=
=0A=
I copied the DSDT and all SSDTs from `/sys/firmware/acpi/tables/` and decom=
piled them together with `iasl -d DSDT SSDT*` as requested.=0A=
The archive contains both the original AML tables and the resulting DSL fil=
es, along with the iasl output log.=0A=
=0A=
SHA256:=0A=
9c2664d8927f2550d171860867f00fbebe161c18017cf58fb84445475c392469=0A=
=0A=
One potentially relevant detail I noticed is that `0000:00:04.1` maps to `\=
_SB.PCI0.GP12` (`_ADR =3D 0x00040001`).=0A=
Its `_DSD` advertises `HotPlugSupportInD3 =3D 1` and associates it with `\_=
SB.PCI0.GP19.NHI1` as USB4 port 2.=0A=
The NHI1 power-down path also references GP12 and appears to contain explic=
it handling for PCIe `[0:4:1]`.=0A=
=0A=
Please let me know if you would like any additional traces captured while r=
eproducing the failure.=0A=
=0A=
Thanks,=0A=
Freeman=0A=
________________________________________=0A=
From: Kovacs, Alexander <Alexander.Kovacs@amd.com>=0A=
Sent: Monday, October 5, 2026 22:35=0A=
To: Freeman Z <SHD-ISAC@outlook.com>; Limonciello, Mario <Mario.Limonciello=
@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>=0A=
Cc: linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>; linux-usb@vger.k=
ernel.org <linux-usb@vger.kernel.org>; bhelgaas@google.com <bhelgaas@google=
.com>; westeri@kernel.org <westeri@kernel.org>; andreas.noever@gmail.com <a=
ndreas.noever@gmail.com>; YehezkelShB@gmail.com <yehezkelshb@gmail.com>; ra=
fael@kernel.org <rafael@kernel.org>; linux-pm@vger.kernel.org <linux-pm@vge=
r.kernel.org>; S, Sanath <Sanath.S@amd.com>; Natikar, Basavaraj <Basavaraj.=
Natikar@amd.com>; Martinez, Juan <Juan.Martinez@amd.com>; Chia-Lin Kao (Ace=
Lan) <acelan.kao@canonical.com>=0A=
Subject: RE: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration=0A=
=0A=
AMD General=0A=
=0A=
Hi Freeman,=0A=
=0A=
I have applied a patch to stop the toggling between suspended and active of=
 the 00:04.1 (AMD TB Tunnel Port Hub) and the Barlow Ridge device on my tes=
t system. Just to better understand why you are not seeing that issue and I=
 am, can I get a zip of:=0A=
sudo cp /sys/firmware/acpi/tables/DSDT /sys/firmware/acpi/tables/SSDT* /<tm=
p-dir>/=0A=
iasl -d /<tmp-dir>/DSDT /<tmp-dir>/SSDT*=A0=A0=A0=A0=A0=A0=A0=A0=A0 # decom=
pile together so cross-refs resolve=0A=
=0A=
The ASL may give us an idea of your original issue with the dock suspending=
 and not recovering sub-devices...=0A=
=0A=
Replied or Forwarded By:=0A=
Alex Kovacs=0A=
845-625-4422=0A=
akovacs@amd.com=0A=
=0A=
-----Original Message-----=0A=
From: Freeman Z <SHD-ISAC@outlook.com>=0A=
Sent: Thursday, October 1, 2026 1:28 PM=0A=
To: Kovacs, Alexander <Alexander.Kovacs@amd.com>; Limonciello, Mario <Mario=
.Limonciello@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>=0A=
Cc: linux-pci@vger.kernel.org; linux-usb@vger.kernel.org; bhelgaas@google.c=
om; westeri@kernel.org; andreas.noever@gmail.com; YehezkelShB@gmail.com; ra=
fael@kernel.org; linux-pm@vger.kernel.org; S, Sanath <Sanath.S@amd.com>; Na=
tikar, Basavaraj <Basavaraj.Natikar@amd.com>; Martinez, Juan <Juan.Martinez=
@amd.com>; Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>=0A=
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration=0A=
=0A=
Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.=0A=
=0A=
=0A=
Hi Alex,=0A=
=0A=
I tested this with my original workaround disabled and after a reboot.=0A=
=0A=
The Kensington SD5000T5 was connected the entire time, and=0A=
0000:00:04.1 had power/control=3Dauto.=0A=
=0A=
I first monitored the sysfs runtime PM state directly. On my system,=0A=
0000:00:04.1 stayed consistently suspended rather than rapidly toggling bet=
ween active and suspended.=0A=
=0A=
I then traced the kernel runtime-PM events for 3 minutes, filtering for=0A=
0000:00:04.1 and 0000:6b:00.6. I enabled:=0A=
=0A=
=A0=A0=A0 rpm:rpm_status=0A=
=A0=A0=A0 rpm:rpm_suspend=0A=
=A0=A0=A0 rpm:rpm_resume=0A=
=A0=A0=A0 rpm:rpm_idle=0A=
=A0=A0=A0 rpm:rpm_usage=0A=
=A0=A0=A0 rpm:rpm_return_int=0A=
=0A=
There were no events for either device during the 3-minute trace.=0A=
=0A=
At the end of the test, the states were:=0A=
=0A=
=A0=A0=A0 0000:00:04.1=0A=
=A0=A0=A0=A0=A0=A0=A0 runtime_status =3D suspended=0A=
=A0=A0=A0=A0=A0=A0=A0 power_state=A0=A0=A0 =3D D3cold=0A=
=0A=
=A0=A0=A0 0000:6b:00.6=0A=
=A0=A0=A0=A0=A0=A0=A0 runtime_status =3D active=0A=
=A0=A0=A0=A0=A0=A0=A0 power_state=A0=A0=A0 =3D D0=0A=
=0A=
I am not seeing the active/suspended toggling on 0000:00:04.1 that you are =
seeing on your test system, at least under this configuration.=0A=
=0A=
Thanks,=0A=
Freeman=0A=
=0A=
________________________________________=0A=
From: Kovacs, Alexander <Alexander.Kovacs@amd.com>=0A=
Sent: Thursday, October 1, 2026 22:54=0A=
To: Freeman Z <SHD-ISAC@outlook.com>; Limonciello, Mario <Mario.Limonciello=
@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>=0A=
Cc: linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>; linux-usb@vger.k=
ernel.org <linux-usb@vger.kernel.org>; bhelgaas@google.com <bhelgaas@google=
.com>; westeri@kernel.org <westeri@kernel.org>; andreas.noever@gmail.com <a=
ndreas.noever@gmail.com>; YehezkelShB@gmail.com <yehezkelshb@gmail.com>; ra=
fael@kernel.org <rafael@kernel.org>; linux-pm@vger.kernel.org <linux-pm@vge=
r.kernel.org>; S, Sanath <Sanath.S@amd.com>; Natikar, Basavaraj <Basavaraj.=
Natikar@amd.com>; Martinez, Juan <Juan.Martinez@amd.com>; Chia-Lin Kao (Ace=
Lan) <acelan.kao@canonical.com>=0A=
Subject: RE: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration=0A=
=0A=
AMD General=0A=
=0A=
Freeman,=0A=
Do you see any toggling between suspended and active (mostly shows in sysfs=
 as active but quickly and randomly toggles to different states) on the AMD=
 HOST Bridge Tunnel (maybe 00:04.1)? It seems the Barlow Ridge controller i=
s the cause of the toggling on my test system. I have tried this with 2 doc=
ks utilizing this controller and see that the Kensington SD5000T5 dock uses=
 it also.=0A=
=0A=
Replied or Forwarded By:=0A=
Alex Kovacs=0A=
845-625-4422=0A=
akovacs@amd.com=0A=
=0A=
-----Original Message-----=0A=
From: Freeman Z <SHD-ISAC@outlook.com>=0A=
Sent: Friday, September 25, 2026 10:49 AM=0A=
To: Limonciello, Mario <Mario.Limonciello@amd.com>; Mika Westerberg <mika.w=
esterberg@linux.intel.com>=0A=
Cc: Kovacs, Alexander <Alexander.Kovacs@amd.com>; linux-pci@vger.kernel.org=
; linux-usb@vger.kernel.org; bhelgaas@google.com; westeri@kernel.org; andre=
as.noever@gmail.com; YehezkelShB@gmail.com; rafael@kernel.org; linux-pm@vge=
r.kernel.org; S, Sanath <Sanath.S@amd.com>; Natikar, Basavaraj <Basavaraj.N=
atikar@amd.com>; Martinez, Juan <Juan.Martinez@amd.com>; Chia-Lin Kao (AceL=
an) <acelan.kao@canonical.com>=0A=
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration=0A=
=0A=
Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.=0A=
=0A=
=0A=
Hi Mario,=0A=
=0A=
Yes. The laptop is already running BIOS 319, and I do not see a newer BIOS =
available from ASUS for this model.=0A=
=0A=
BIOS 319 has also been installed on this laptop for over 1 year, the reprod=
uctions I reported were all done with this BIOS version.=0A=
=0A=
Thanks,=0A=
Freeman=0A=
=0A=
________________________________________=0A=
From: Mario Limonciello <mario.limonciello@amd.com>=0A=
Sent: Friday, September 25, 2026 23:24=0A=
To: Freeman Z <SHD-ISAC@outlook.com>; Mika Westerberg <mika.westerberg@linu=
x.intel.com>=0A=
Cc: Kovacs, Alexander <Alexander.Kovacs@amd.com>; linux-pci@vger.kernel.org=
 <linux-pci@vger.kernel.org>; linux-usb@vger.kernel.org <linux-usb@vger.ker=
nel.org>; bhelgaas@google.com <bhelgaas@google.com>; westeri@kernel.org <we=
steri@kernel.org>; andreas.noever@gmail.com <andreas.noever@gmail.com>; Yeh=
ezkelShB@gmail.com <yehezkelshb@gmail.com>; rafael@kernel.org <rafael@kerne=
l.org>; linux-pm@vger.kernel.org <linux-pm@vger.kernel.org>; S, Sanath <San=
ath.S@amd.com>; Natikar, Basavaraj <Basavaraj.Natikar@amd.com>; Martinez, J=
uan <Juan.Martinez@amd.com>; Chia-Lin Kao (AceLan) <acelan.kao@canonical.co=
m>=0A=
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration=0A=
=0A=
On 9/25/26 10:12, Freeman Z wrote:> Hi Mario, Alex and Mika,=0A=
>=0A=
> Sure. Attached is the exact .config used for my unmodified Linus=0A=
> v7.3-rc4 test that reproduces the failure.=0A=
>=0A=
> SHA256:=0A=
>=A0=A0=A0=A0=A0 488899cc5a0b5f2de69466df2639e39769d40d90682f51690400399a54=
9309c2=0A=
>=0A=
> This is the final .config used after make olddefconfig for the v7.3-rc4 t=
est.=0A=
>=0A=
> The v7.3-rc4 delayed-rescan test that succeeded used the same configurati=
on base.=0A=
> The patched kernel was distinguished with a different LOCALVERSION.=0A=
>=0A=
> Please let me know if there are any other platform or configuration=0A=
> details that would help align the reference-board setup.=0A=
>=0A=
Thanks.=A0 Can you also look for a BIOS update on your side from the vendor=
 in case it ends up being something unique to their BIOS?=
