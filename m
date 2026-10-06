Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010004.outbound.protection.outlook.com [52.103.43.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BA97260D;
	Tue,  6 Oct 2026 19:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791315222; cv=fail; b=HY82kSGBKn+8yoSryB2/GCjluPi5OXJUiJ0SS5CG8g5+2hwF1n2fQnhN+0LPiGPZ9BaUG69x1pd+Zj4kbUqEoSzsGHv8mC6lFb7wFE1u8aJS6RSYmXefnWjYwM/9bnnIfvgzQQY1BVfj1IXmdpT/artoUQDdNyszTgSjzMTFlPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791315222; c=relaxed/simple;
	bh=FQbksokOaFVcABdTkyshWW/LWmZLkGFsiPTIdBkammQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RlMAIz/hCTX27hQo0jzymlydmWNT4v/CxINM7uSoqsu5wjel1A0OrsC4z/t/AD56FO+GIjf5EDxpgqAwaTQ55ZeL/wSMe0LiL8RH07zE33GbatRa2+7VjmqVdxRl2sKNCHb/WJHHPUYDq6tJblyRcwnz7YBArbHvfbe66qedU3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=I+J9qtRA; arc=fail smtp.client-ip=52.103.43.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="I+J9qtRA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZkaXyxoaEULG10liurJ6S/XK1UWR1BTVdG9A/RWZ2+aPBZ6K1I5gre4vctoB6q6FAzaYLwoZ4GIVucm4ZDKA1IgP19jaRbj8W6PO2xwfsKTwsLuAqEBesprSgrY9dgfD3Clhf+ANf4k7uxMaBjhlQdeMmGrH6DN8vL3HGgQooRRnG/9RdJaBR1cUaTdn1hAqeI9kt+Xr/ygaHAa6ynqeShKmc/8TO4j3fwB6Em1MZ2preOGt1j7G5Hcyvf/NFwKTo5jpWDrclfVaw5Fz0+Lx0IZwik+oItUi3aTQvPv1bil/6PU+6ncNNmdKrRoz5JlFTVqGaSU6Uunz72K7HsnIeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NDyB34u9xQ5FbaLHJdcTaCYUpq/IndAwPK1iUbOLcg=;
 b=QWMbybvnmMggMu6Iuhcqds3/RWdoyLXAJZcpvNw9ARMGtqJmXmGIjkDaSbudqa16wsXD/jzruSxefX7AyCBIUoIbWNLl/d8nzK/peBoDA51WFU5JpfTNySDkJpHADZG7qk1MkdPvzYACW0Wk6r92TId+zhkrqzYOZQHL/FxGjwmxksyhbiHlrCTZfhkd3nNsVc+HSwQWZtr/XyrIQuZZSgttlhe3iwl86mRBFjs1uszICEnO7Bc3H+DOp7O5Xu679Yf9OyF1BldnDrSiu4lIriu2zWa5yvi97yxyI+DKNKJW9KCdh7lrDDc5YWmUXvoVdfpcmoDYVRV6HBcijLCU+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NDyB34u9xQ5FbaLHJdcTaCYUpq/IndAwPK1iUbOLcg=;
 b=I+J9qtRADtfIrzeQ4VjFjVJAoocqrm1rPuk67Z5jUHjphrzP5E6H/j7duDHXFA9cL/6MLrDdDtuK4GpBNymwqALbX+A1+JnXT145VqU615CHBPQ904A59yEFiMoZcqtSbZfmJkSoaBnd4YlrYO9BB6T0tjdWbqaNh0A8EVVJaYf0OQ2GbMzfyufUsm2P8ElxEjEHb9r1oC6i0WfbTf0zHPfhI1z9anwBzqjWS8ttsbYBfx0RcZZUljAQcBc0BWVK5gxU9s0DIKQ7m9BSJImb8XCTHEKKnvnX03xm0PcHApxHHjdERYJ2yjyAe381FqIAI6ul6UX3Q+tJlFntpi/a/A==
Received: from TYCPR01MB10927.jpnprd01.prod.outlook.com
 (2603:1096:400:3aa::13) by OSCPR01MB14580.jpnprd01.prod.outlook.com
 (2603:1096:604:3a4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 19:33:34 +0000
Received: from TYCPR01MB10927.jpnprd01.prod.outlook.com
 ([fe80::c225:1d5a:1a78:c5c7]) by TYCPR01MB10927.jpnprd01.prod.outlook.com
 ([fe80::c225:1d5a:1a78:c5c7%4]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 19:33:34 +0000
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
 AQHdSDNPea4qqw1tcEOkT/edQjHT9rbYfQ8AgACtPACAAaXMFIAAN8+AgAABpQCAAPzaBYAAjxGAgAC1UD2AAYHugIAAQ8E/gAAe2FyAAAh6gIAAJxUAgAAPH8SAAAVwgIAABbk/gAlgAYCAADo/D4AGCcGAgAAQnVOAABhFgIAAAdCwgAFnD4CAAAEXgIAAGv3dgAAQU4CAABZsJ4AADMmAgAABdR8=
Date: Tue, 6 Oct 2026 19:33:33 +0000
Message-ID:
 <TYCPR01MB10927E246D8E1308B9AF36C1996952@TYCPR01MB10927.jpnprd01.prod.outlook.com>
References: <f8b929da-b4ae-48ae-9667-3eb93aa0a4bd@amd.com>
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
 <TYCPR01MB10927C563CDDD5216CDFCD4D696962@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <DS7PR12MB9550E85CCAED9C8C0D19DCA79C952@DS7PR12MB9550.namprd12.prod.outlook.com>
 <051b667e-eaa9-4ad8-86ce-1a326a612284@amd.com>
 <TYCPR01MB109273BCB71161ABE3AD85A8696952@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <DS7PR12MB95503B5244149768A62590099C952@DS7PR12MB9550.namprd12.prod.outlook.com>
 <TYCPR01MB109272C6ADB253EBABEEB30AC96952@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <DS7PR12MB9550496ABBB70227D5B2B0679C952@DS7PR12MB9550.namprd12.prod.outlook.com>
In-Reply-To:
 <DS7PR12MB9550496ABBB70227D5B2B0679C952@DS7PR12MB9550.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-06T16:59:54.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10927:EE_|OSCPR01MB14580:EE_
x-ms-office365-filtering-correlation-id: ecc089d1-7cb2-4b49-9f98-08df23e0b5ca
x-microsoft-antispam:
 BCL:0;ARA:14566002|25010399006|24021099003|31061999003|19110799012|12121999013|8060799015|8062599012|41001999006|13031999006|15080799012|15030799006|260826193500599007|51005399006|40105399003|18061999006|2607281247196008|102099032|3412199025|26104999009|440099028;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?TbNhos0BEjuD+nRqgZIWjgUs6BS2wjNqH/ezOwKrXpm+7jjak28Yj43b9Q?=
 =?iso-8859-1?Q?3g6ba4X9PqkOjIxOtCqmklmy2Bp3kBhsn9D5da/C02JQj6zXKyr2sFhQAQ?=
 =?iso-8859-1?Q?NPazCDX8aIl+vte3Pi7OQbd2iTkYfatfPX2VarJzaZ2rmQ2cmj95UGWN8t?=
 =?iso-8859-1?Q?yDe+gMSWlSySaPyrtfQ+iuROS74edTR1XSjrX86fm2jpM1ctG2NvxhBNVy?=
 =?iso-8859-1?Q?CTdIYo6RV+oJphgnlbKqTavTWYjmSvzjyiQvxAD48+QnERpNbQaj4JELV2?=
 =?iso-8859-1?Q?CtJhv6IVqKL4dyi5v1UH6GwIXHSK1c4ymbLtIKfWcwC9FjsnkK7k3m1FzQ?=
 =?iso-8859-1?Q?gD6HScYOyzrJNAuK2/2ujhtMZCtFWzb9AyETtZp3fMds0LfUsOOSPtkdW5?=
 =?iso-8859-1?Q?ZWh7PtJW/JFyry3AFIYYblIy5/Oip3YpKRz9jNzmHboP2aHS6Isym0kdI5?=
 =?iso-8859-1?Q?gi2J6wHIT14giR4Sxscm+Ba0oAV3VuSP9MuChwEMhCLm5RlkskgaaS975e?=
 =?iso-8859-1?Q?3v8Uc27f2aKfCa4tSZq53CskSQP23tizqFwJmQubMxQGQu9uzrY7heORNk?=
 =?iso-8859-1?Q?tfoXLhCEzfXQGKhdv8b/EdIkliaCFDhz+W5oOaAqq2Ah5n5oRg8JeiAlSQ?=
 =?iso-8859-1?Q?Kt3kITklelRSIX4EPpOWmGzri1e4mgwReqRaGDtiMbH9G2XyPNXNSriBeV?=
 =?iso-8859-1?Q?GgtICPvicePmkOTkNJR+ivmDmTwI79TFguVCGW+NimOoSJB+pRAfuJ1qbF?=
 =?iso-8859-1?Q?+A7DFTwJc/wIJevYFo52IpDu4XEBC9zbejuajc+Z+oe2tHB/Saqh/PQpXW?=
 =?iso-8859-1?Q?ygqD/drHILTESFpGscC68WvNQ+5U/ad2CiSqVXWnLNDW3AWHTwlFmwkDWs?=
 =?iso-8859-1?Q?G2XStt+FVUa5gEcM51Ems42sZ7BoM75NWMy7g9QwD+ZxzHqWkm/iwmwHJH?=
 =?iso-8859-1?Q?RhU4zuDzqrjzKlONAf53lhqfuQwqg8h156Ma/WmldpIrP5K7yLI/ckAFFs?=
 =?iso-8859-1?Q?1V7z2uIHrOwdGCv9S+kgzP/v0ddZlVxchJZNOmdm0C+mmT+JPrLP2k/nWQ?=
 =?iso-8859-1?Q?tkIN+D27ySdwohv69IZyiFz93yYwYyTwW//cjZ+v2/kmauUnBUPVqucTq9?=
 =?iso-8859-1?Q?EpmGR2hseWJX9QP5es16lxErfgnyNxQ97GrOZVONSz8mxU/qyvAU0gRT/g?=
 =?iso-8859-1?Q?82eRyYNk3FcL5g=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?D7HVZPz66p7s9TX6ZPtxtaiSr5JIvu9HbwRjh3nqByiLlhtefgyW4z6R76?=
 =?iso-8859-1?Q?e4ZQlUMQj1lig8vNmrBJnMt5qfCYvn9r6ZgglhwBQbK5AEdrJB8PE+Giku?=
 =?iso-8859-1?Q?+t8yIzEsSo58UPBi+vB7lTEfom6vA68C1ywqY8vTWGgMwKnAXyZfk4IlKY?=
 =?iso-8859-1?Q?Z4WNs5M22BtJrj+O+W5Q/p+M9C2uccmFDNqy1LMLrevdvdVtTSzGyrmPOD?=
 =?iso-8859-1?Q?MtYHwLG90Yrvq5tVLv9ByJV25Nznb1+JAwo+pOtPvvsO92jxCTmusmrl/9?=
 =?iso-8859-1?Q?QmwqHSrs46Yh3PUyAjrB+pA858wwYWYqafBg+SuE8fVas1HzEJErtMQF0/?=
 =?iso-8859-1?Q?XUbxjabWDeziszjz0fbURYou3bwhoPFjAQTiiQvHsdRph/xBQVDnMb2in8?=
 =?iso-8859-1?Q?1KscotkUtEt/AvmOxge5cPjv/ZLZPcspD55dUMnWpTQp6Ajx6RWHIlw4mp?=
 =?iso-8859-1?Q?wGUVmRWBNbXsBQe4lhvRdRXFxIUJabJ7CHDYYVnT4BQhRQaM5X5S9JnbTE?=
 =?iso-8859-1?Q?OUzksKFR/AWgz164aRf9ZFnAfaJpdscGdBRBjND+/ndGcRalXd79FPvfUO?=
 =?iso-8859-1?Q?4+HYKxRd1jMKmJJimEx4iY4wVWA/EohZN9oUl29H9yyxlNkAfQjAUvPPo4?=
 =?iso-8859-1?Q?fmM0+imcTHhh8sqVxGydbQekzT470k+OAPd3mhZgCavwSXGgtLlvmA2eKb?=
 =?iso-8859-1?Q?IMzdJAVINPWM8+DdeZmAIAxuL9zWaJoSFzZEprhGgKOg5y3/uoP/el/PTK?=
 =?iso-8859-1?Q?jH3zKs9w9D39ADuYoc1SqVY2SH3LaHnJ4zfha9INXpPXXdcdYPZ3H271tP?=
 =?iso-8859-1?Q?bQm8OELoiLY6CalY92FtHKmH7pwLZwMxgL9/Q/GaouMTH9l7aO/orKS6++?=
 =?iso-8859-1?Q?RmQfATDLiGBmXE+mT6uu0iagXeQoMZATYzCG6TKVgP/DarfLsjWA+ZDpUT?=
 =?iso-8859-1?Q?UkZ76yu9ZSbd+Bc0WxBxraIPq45JQPaWa/hqMYqHIovLNY6sAOsvVxzgqW?=
 =?iso-8859-1?Q?Oie4Yd3rFPlReHrNW338/yST3EKOuISS/wUOfbgD+CRZ5rBHeR5HFRp5b7?=
 =?iso-8859-1?Q?CiFDavHxuinLvdniD7axnJfteQHCDDyPwfrvnBG9EacfFm4btBN/g2c7hG?=
 =?iso-8859-1?Q?p2jf6M2nc59inez4dhbhFLT69Xhhx4V9FZQ8KsUUKkaTeMDTlw2LlUd1lM?=
 =?iso-8859-1?Q?SdF80spsa68gKuJlk2gO9URYDKLOBm9aQQZwdTmUU0pHkRBx4M1IZ5oM7R?=
 =?iso-8859-1?Q?ysgibTjFUVE1EwRHaUgBadtz4NGHcvPuFbBzmbRl5qcCVOxWTG5M8JAQTV?=
 =?iso-8859-1?Q?GinEun09KhlXBWV5hQ7NZ6A3miYmQWtA7ZGkcM1lhwfxkC9SPeD6BNl7Ps?=
 =?iso-8859-1?Q?xoTLPr7G92MepN0PMNsBeRILk3eljT/V0j9jM+WSfAE5yO4Y4QNF5EBUKb?=
 =?iso-8859-1?Q?M5yDW/HNDs9ESS3m4hp3D/1QV52N9f8hK5/+zJsFQ1aM25PgyukSE0GnZW?=
 =?iso-8859-1?Q?s=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc089d1-7cb2-4b49-9f98-08df23e0b5ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 19:33:33.9405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14580

Hi Alex,=0A=
=0A=
Sorry for the confusion.=0A=
=0A=
gpe10 had not incremented at the first observable hot-plug event.=0A=
=0A=
In recent run 2 (gpe10-hotplug-20261007-015343), sampled every ~200 ms:=0A=
=0A=
  01:54:50.903  gpe10=3D27  NHI=3Dsuspended/D3cold  00:04.1=3Dsuspended/D3c=
old=0A=
  01:54:51.116  gpe10=3D27  NHI=3Dactive/D0         00:04.1=3Dsuspended/D3c=
old=0A=
                ^ first observable hot-plug effect=0A=
=0A=
  01:54:54.083  gpe10=3D29  00:04.1=3Dsuspended/D3cold=0A=
  01:54:55.152  gpe10=3D31  00:04.1=3Dsuspended/D3cold=0A=
=0A=
  01:55:33.648  gpe10=3D31  00:04.1=3Dsuspended/D3cold=0A=
                09:00.0 still absent=0A=
=0A=
gpe10 increased by 4 total, in two +2 steps, starting about 3 seconds=0A=
after the first observable hot-plug effect. 00:04.1 never woke up.=0A=
=0A=
In run 1 (the earlier full capture, d3cold-capture-20261006-232936),=0A=
gpe10 stayed at 27 before the hot-plug, about 37 seconds after it,=0A=
and after the targeted recovery. It did not increment at all in that run.=
=0A=
=0A=
The two runs differ: run 1 had no gpe10 activity, while run 2 had=0A=
delayed gpe10 activity a few seconds after the hot-plug.=0A=
=0A=
Best regards,=0A=
Freeman=0A=
=0A=
________________________________________=0A=
From: Kovacs, Alexander <Alexander.Kovacs@amd.com>=0A=
Sent: Wednesday, October 7, 2026 3:18=0A=
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
I'm confused, did /sys/firmware/acpi/interrupts/gpe10 increment on plug ?=
=0A=
=0A=
Replied or Forwarded By:=0A=
Alex Kovacs=0A=
845-625-4422=0A=
akovacs@amd.com=0A=
=0A=
-----Original Message-----=0A=
From: Freeman Z <SHD-ISAC@outlook.com>=0A=
Sent: Tuesday, October 6, 2026 1:46 PM=0A=
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
I reran the test with both 00:04.1 and the NHI in D3cold, polling the ACPI =
counters and device states every ~200 ms.=0A=
=0A=
I pressed Enter late, so the manual "DOCK PLUGGED" marker should be ignored=
 for timing. The first observable hot-plug effect was:=0A=
=0A=
=A0 01:54:51.116=0A=
=A0=A0=A0 NHI:=A0=A0=A0=A0=A0 D3cold -> D0=0A=
=A0=A0=A0 sci_not:=A0 8 -> 9=0A=
=A0=A0=A0 gpe10:=A0=A0=A0 unchanged at 27=0A=
=0A=
Then:=0A=
=0A=
=A0 01:54:54.083=A0 gpe10/gpe_all/sci: 27 -> 29=0A=
=A0 01:54:55.152=A0 gpe10/gpe_all/sci: 29 -> 31=0A=
=0A=
Despite those GPE10 events, 00:04.1 remained suspended/D3cold and=0A=
09:00.0 remained absent through the end of the capture. IRQ 35 for=0A=
00:04.1 also remained at zero.=0A=
=0A=
I went back through the ACPI tables and noticed that GPE 0x1A and GPE 0x10 =
appear to be two distinct wake paths for GP12.=0A=
=0A=
In SSDT17, GP12._PRW returns:=0A=
=0A=
=A0 { 0x1A, 0x04 }=0A=
=0A=
and _GPE._L1A sends Device Wake notifications to GP12 and GP12.SWUS (as wel=
l as the associated GP19/NHI devices) without checking PCIe Root Status.=0A=
=0A=
GPE 0x10 is different. In SSDT16, _GPE._E10 is the GPP PME dispatcher.=0A=
For GP12 it does:=0A=
=0A=
=A0 If (\_GPE.ET12 !=3D 0xFF)=0A=
=A0 {=0A=
=A0=A0=A0=A0=A0 \_GPE.ET12 =3D=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 (M017 (Zero, 0x04, One, 0x78, Zero, 0x18) >> 0x=
10)=0A=
=0A=
=A0=A0=A0=A0=A0 if ET12 is 1 or 3:=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Notify (\_SB.PCI0.GP12, 0x02)=0A=
=A0 }=0A=
=0A=
For 00:04.1, offset 0x78 is the PCIe Root Status register (PCIe capability =
at 0x58 + 0x20).=0A=
=0A=
A GPE10 increment only shows that _E10 ran; it does not by itself show that=
 the GP12 branch saw PME Status set or that GP12 received the Device Wake n=
otification.=0A=
=0A=
In the earlier full capture, GPE 0x1A remained at zero in all three=0A=
snapshots: before the plug, after the failed hot-plug, and after the target=
ed config-space read. 00:04.1 remained in D3cold until that targeted read, =
which immediately caused GP12 to transition to D0 and the downstream hierar=
chy to enumerate.=0A=
=0A=
GP12's _DSD also has HotPlugSupportInD3 =3D 1 and associates the port with =
GP19.NHI1 / USB4 port 2.=0A=
=0A=
Best regards,=0A=
Freeman=0A=
=0A=
________________________________________=0A=
From: Kovacs, Alexander <Alexander.Kovacs@amd.com>=0A=
Sent: Wednesday, October 7, 2026 1:12=0A=
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
=0A=
Great, thanks for the confirmation...=0A=
=0A=
Can you try:=0A=
=0A=
get the 00:04.1 into a suspended state=0A=
Run:=0A=
sudo watch -n1 cat /sys/firmware/acpi/interrupts/gpe10=0A=
Perform hotplug of dock=0A=
=A0 If gpe10 does not increment when the dock is plugged into the suspended=
 port, that's proof the wake never fired - and it's likely the GPE-0x10 _E1=
0 path. If it does tick but nothing enumerates, the miss is likely downstre=
am (native/pciehp=0A=
=A0 side).=0A=
=0A=
Replied or Forwarded By:=0A=
Alex Kovacs=0A=
845-625-4422=0A=
akovacs@amd.com=0A=
=0A=
-----Original Message-----=0A=
From: Freeman Z <SHD-ISAC@outlook.com>=0A=
Sent: Tuesday, October 6, 2026 11:33 AM=0A=
To: Limonciello, Mario <Mario.Limonciello@amd.com>; Kovacs, Alexander <Alex=
ander.Kovacs@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>=0A=
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
Thanks for checking the tables, and Mario, thanks for the explanation of th=
e _DSD -> XDSD rename.=0A=
=0A=
That is consistent with the suggestion that the XDSD rename may be an inten=
tional way to keep an unused reference-code path disabled. This GV302XV exp=
oses only the 00:04.1 / NHI1 USB4 path, so the NHI0 XDSD issue appears like=
ly to be separate from the enumeration failure.=0A=
=0A=
Since you haven't been able to reproduce the failure, these are the conditi=
ons that seem to matter on my system:=0A=
=0A=
=A0 1. Cold boot with the dock disconnected.=0A=
=0A=
=A0 2. 00:04.1 power/control =3D auto, with both 00:04.1 and the NHI=0A=
=A0=A0=A0=A0 (6b:00.6) runtime-suspended in D3cold before the dock is plugg=
ed in.=0A=
=0A=
=A0 3. No PCI config-space access to the root port before the hot-plug.=0A=
=A0=A0=A0=A0 A config-space access wakes 00:04.1; both the targeted 4-byte =
config=0A=
=A0=A0=A0=A0 read in this capture and plain lspci in earlier tests caused=
=0A=
=A0=A0=A0=A0 enumeration to proceed normally.=0A=
=0A=
I captured a failing hot-plug under these conditions using:=0A=
=0A=
=A0 kernel: 7.2.9-1-cachyos=0A=
=A0 BIOS:=A0=A0 319=0A=
=0A=
The capture includes runtime-PM and PCI hotplug/link tracepoints, pciehp / =
ACPI device-PM / Thunderbolt dynamic debug, and ACPI GPE and /proc/interrup=
ts snapshots before the plug, after the plug, and after recovery.=0A=
=0A=
A redacted archive is attached.=0A=
=0A=
SHA256:=0A=
=A0 4d4d7f64aeb4a2bbd8e68cf221de2002ad427d3456fc8354c06f3d3760dad065=0A=
=0A=
The relevant timeline from kernel.log is:=0A=
=0A=
=A0 98.774=0A=
=A0=A0=A0 First observable hot-plug effect. The NHI begins resuming from=0A=
=A0=A0=A0 D3cold. IRQ 38 (00:08.3, PCIe PME / bwctrl) increased by one=0A=
=A0=A0=A0 between the snapshots, which is consistent with a PME wake throug=
h=0A=
=A0=A0=A0 the bridge hosting the NHI.=0A=
=0A=
=A0 101.015 - 101.017=0A=
=A0=A0=A0 Thunderbolt PCIe Down and Up tunnel paths are activated.=0A=
=0A=
=A0 101.017 - 135.664=0A=
=A0=A0=A0 00:04.1 remains suspended / D3cold.=0A=
=A0=A0=A0 The NHI remains active / D0.=0A=
=A0=A0=A0 09:00.0 remains absent.=0A=
=0A=
=A0=A0=A0 No runtime-PM activity is recorded for 00:04.1.=0A=
=A0=A0=A0 IRQ 35 (00:04.1 PME/AER/pciehp) remains at zero.=0A=
=A0=A0=A0 None of the counted ACPI GPEs change.=0A=
=0A=
=A0 135.664=0A=
=A0=A0=A0 The script performs only a 4-byte read from:=0A=
=0A=
=A0=A0=A0=A0=A0 /sys/bus/pci/devices/0000:00:04.1/config=0A=
=0A=
=A0 135.668=0A=
=A0=A0=A0 GP12 transitions from D3cold to D0.=0A=
=0A=
=A0 135.681=0A=
=A0=A0=A0 pciehp reports:=0A=
=0A=
=A0=A0=A0=A0=A0 Card present=0A=
=A0=A0=A0=A0=A0 Link Up=0A=
=0A=
=A0=A0=A0 Its first link check after resume reports:=0A=
=0A=
=A0=A0=A0=A0=A0 lnk_status =3D 0x3011=0A=
=0A=
=A0=A0=A0 This has DLL Link Active set and no Link Training bit set.=0A=
=0A=
=A0 135.808=0A=
=A0=A0=A0 09:00.0 [8086:5786] begins enumerating.=0A=
=0A=
A full lspci scan was not needed.=0A=
=0A=
So the PCIe tunnel is established while 00:04.1 remains in D3cold, and a ta=
rgeted config-space read of 00:04.1 alone resumes the port. pciehp then imm=
ediately finds an active link and enumerates the downstream hierarchy.=0A=
=0A=
No wake of 00:04.1 was observed during the hot-plug window.=0A=
=0A=
The kernel also logs:=0A=
=0A=
=A0 Wakeup disabled by ACPI=0A=
=0A=
for 00:04.1 on resume, so GP12 is ACPI wake-capable via _PRW.=0A=
=0A=
There are two observations I cannot explain yet:=0A=
=0A=
=A0 1. sci_not increased from 6 to 7 while gpe10, gpe_all, and sci=0A=
=A0=A0=A0=A0 remained unchanged. The snapshots do not timestamp that increm=
ent,=0A=
=A0=A0=A0=A0 so it cannot yet be tied to the dock insertion.=0A=
=0A=
=A0 2. The final Root Status of 00:04.1, read after recovery, shows:=0A=
=0A=
=A0=A0=A0=A0=A0=A0 PME ReqID 0021, PMEStatus+ PMEPending+=0A=
=0A=
=A0=A0=A0=A0 0021 decodes to 00:04.1.=0A=
=0A=
=A0=A0=A0=A0 IRQ 35 was zero in all three interrupt snapshots. Since Root S=
tatus=0A=
=A0=A0=A0=A0 was read only after recovery, I do not know when these PME bit=
s=0A=
=A0=A0=A0=A0 became set.=0A=
=0A=
Best regards,=0A=
Freeman=0A=
=0A=
________________________________________=0A=
From: Mario Limonciello <mario.limonciello@amd.com>=0A=
Sent: Tuesday, October 6, 2026 22:37=0A=
To: Kovacs, Alexander <Alexander.Kovacs@amd.com>; Freeman Z <SHD-ISAC@outlo=
ok.com>; Mika Westerberg <mika.westerberg@linux.intel.com>=0A=
Cc: linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>; linux-usb@vger.k=
ernel.org <linux-usb@vger.kernel.org>; bhelgaas@google.com <bhelgaas@google=
.com>; westeri@kernel.org <westeri@kernel.org>; andreas.noever@gmail.com <a=
ndreas.noever@gmail.com>; YehezkelShB@gmail.com <yehezkelshb@gmail.com>; ra=
fael@kernel.org <rafael@kernel.org>; linux-pm@vger.kernel.org <linux-pm@vge=
r.kernel.org>; S, Sanath <Sanath.S@amd.com>; Natikar, Basavaraj <Basavaraj.=
Natikar@amd.com>; Martinez, Juan <Juan.Martinez@amd.com>; Chia-Lin Kao (Ace=
Lan) <acelan.kao@canonical.com>=0A=
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration=0A=
=0A=
On 10/6/26 09:33, Kovacs, Alexander wrote:=0A=
> AMD General=0A=
>=0A=
> Freeman,=0A=
>=0A=
> Ok, regarding the 00:03.1 device, I am seeing that it is misnamed in the =
tables.=0A=
>=0A=
> BIOS Bug Report: Thunderbolt/USB4 tunnel port `_DSD` misnamed `XDSD`=0A=
> (00:03.1 / NHI0 path)=0A=
>=0A=
> But that more than like does not have any bearing on the root dock enumer=
ation issue...=0A=
>=0A=
> I am unable to create a case where I can replicate your fail on my test s=
ystem yet.=0A=
>=0A=
_DSD -> XDSD is a strategy I've seen employed when someone wants to pick up=
 reference code but has a difference in their design (for example they don'=
t have a retimer connected to the second USB4 router and disabled the IP.=
=0A=
=0A=
I don't know for sure; but my guess this is a strategy to avoid technical d=
ebt and mistakes when merging future reference code versions.=
