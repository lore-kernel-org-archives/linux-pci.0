Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19011014.outbound.protection.outlook.com [52.103.66.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10B3455194;
	Tue,  6 Oct 2026 16:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791304396; cv=fail; b=KTu0F6DPHf0n2vAg90Oo/8N1AI53mWTaijyY5zpsS9meE4fbeMm8xe0ZCq1ixbbY3dljbOHFg0Fr1NUtvpLz00czeul7m0jwHJe7/rWX4g/XuA94XLmLMlIw6Qk3Iouh52EVC2Edu8Bjtii9rcDUCnjPAH7+cctnwwj8PdqcSVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791304396; c=relaxed/simple;
	bh=yWOwNXc68PXu/u/hx60N8I26aAZTau2BPIV/UBeAd20=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KmJOys10tfQoV3rAt+i15oL90Y5QZMSqEPdp1PL1I2LLmmQ70mLUF296LcW0IkssLLuUKRdh5W95RuxBxiYSqw0EhLgqxeeybp37il9ECn128XarZD71L9fYZN/0FTJyZbeMEg/NGhyVBFWsYoL8ZmNLVx+ZI2XiyXWfQCkw3D0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ceT5HgmW; arc=fail smtp.client-ip=52.103.66.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ceT5HgmW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nQZHBWcWrJaYotSFeRjGNUfttKIBpc1UcECiysSPp9/628oj32ysI3ETU2pPb5oyhu9hUnR3DYqOZEn2OkuDk+tqZHT0tjjNqavPBl8z9ekW3rageO78eH+/e9mz7aucecNZ2bCBAbjRMwy36W1y/bumfDembfeL3q8/HM7qlTGkrFxP/+wintiyc8r/OiLPDs1YJpw1BFDS4txPBrZ9t3RI5xnUtixWQMK3n7LDmDKNdIwCdDcVXtyaMqYW5kaYa2Bg/w5j5evekdfmgXNhbBiAiSthbRtGsnwXKEzvaJE/pS4rM1AhtG1ZWBCF3ov09kycG3453DjPmpw6iEgt+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41Z/Jv2Gp9Py+g5lyAE8MeLENfRVRUmgPLQukzhdplU=;
 b=Jgy49HHn4ehEqAbVW6YaYvZKLj9z0BrE2jtRQVnDfTk6K9shpFdQTyMXn++ipc+oTk1lsd6od6q/uU1lSUMAHoe31P88oeF1pvHYstc0o1naY8qzGqAXM6SeH7wXcy0FHeVxEDO82sRZx/5YrkV54zPOv3e5yott2Iru77KhFS3ccebW5f9f3r9lHMtIXQalrqU3gDgDeF5g6izArFi1/zCPr2pOEtFwehaac+tQB42y1sHqkCX8TzGANPvl3rTQWX+38/3ASf+Y3pWdPj7fBU/nU1/80MQ/qoRkO+MTT9MaZQ0uUpeDlWCSqaUrKYje3NjaEeNzxjofwvDhiS5LRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41Z/Jv2Gp9Py+g5lyAE8MeLENfRVRUmgPLQukzhdplU=;
 b=ceT5HgmWdMqI4TZLrEfRJLRSUKQTEB0Q3jtrDg1todZ9m36UI3uHahmmVawKliAZ7q7hEnsjtjCf9636VUGcYjq3nOJM5RTpolkv70vnlQURr6Cg2o0VYNZXK8knP35AWDrxsopxD83alk3Hef1zQRSF66/K2sY9rnsjgB0piksM0RLsekRFJP+XcHyV21qD+53qYV0NEMrV4SBdeQxeEmu3gAnZZ8UY5xzgBZqm9xprcL88vXTWU/008Zm9Dx9/NWqt3IgUIQj4t939sJXGU/qZ0Ohsn+vHshbBo6YsCmG2Q4b+QucWwDMXReT3rn+6+tmM5d4HVnoNG6yuMrpPPQ==
Received: from TYCPR01MB10927.jpnprd01.prod.outlook.com
 (2603:1096:400:3aa::13) by TYWPR01MB11284.jpnprd01.prod.outlook.com
 (2603:1096:400:3f0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 16:33:01 +0000
Received: from TYCPR01MB10927.jpnprd01.prod.outlook.com
 ([fe80::c225:1d5a:1a78:c5c7]) by TYCPR01MB10927.jpnprd01.prod.outlook.com
 ([fe80::c225:1d5a:1a78:c5c7%4]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 16:33:01 +0000
From: Freeman Z <SHD-ISAC@outlook.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Kovacs, Alexander"
	<Alexander.Kovacs@amd.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
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
 AQHdSDNPea4qqw1tcEOkT/edQjHT9rbYfQ8AgACtPACAAaXMFIAAN8+AgAABpQCAAPzaBYAAjxGAgAC1UD2AAYHugIAAQ8E/gAAe2FyAAAh6gIAAJxUAgAAPH8SAAAVwgIAABbk/gAlgAYCAADo/D4AGCcGAgAAQnVOAABhFgIAAAdCwgAFnD4CAAAEXgIAAGv3d
Date: Tue, 6 Oct 2026 16:33:01 +0000
Message-ID:
 <TYCPR01MB109273BCB71161ABE3AD85A8696952@TYCPR01MB10927.jpnprd01.prod.outlook.com>
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
In-Reply-To: <051b667e-eaa9-4ad8-86ce-1a326a612284@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10927:EE_|TYWPR01MB11284:EE_
x-ms-office365-filtering-correlation-id: c80d9985-e0b3-484e-9fc0-08df23c77d30
x-microsoft-antispam:
 BCL:0;ARA:14566002|24021099003|51005399006|31061999003|25010399006|8062599012|19110799012|12121999013|8060799015|15080799012|15030799006|6092099016|40105399003|18061999006|2607281247196008|102099032|3412199025|440099028|26104999009;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?QsTv+IhNXVeF4VDayOcYBzUZK1u+cr3oIxPxSVk/E/WCWnLZ/opTnU36ii?=
 =?iso-8859-1?Q?dUsTmBiJq8T8FG57bU1xwVRviHx2tetzxqw+SI5ugivvihg4I0ho9B4tar?=
 =?iso-8859-1?Q?IflwtxHOA2BvoWM0TXR8Oya7uTJFXs7Gvf6mIkl3M3ppJJ19h0wezV5S8E?=
 =?iso-8859-1?Q?8Zy8RwT4Aui57XpRpUF41dKnHyg0cGEfxIa+P6THrhDm2r+6AuBBUPkWfS?=
 =?iso-8859-1?Q?Q3f/oLIauSwTFTCn36BcXMA8CG/H38W8uXbdhlIGmld8NjY2atXEir1YIR?=
 =?iso-8859-1?Q?JYscHUg7k2JQ8RSHqTe3dunZdG33lAC7U0yo6x4fLvhM6dExe4eknqnNLq?=
 =?iso-8859-1?Q?NxzlxzP8sUtp0BtNfC1fnFK/ZSAPj0OsIU//pHDplgUZUTiZ678sGeh9o0?=
 =?iso-8859-1?Q?ZW5GR2gFbf27C98OlZjUrsynVFwJX3Y+0j6vOimLfTpsF4ZSvihFlqTDBo?=
 =?iso-8859-1?Q?ZA8YpBvRsxW8wIuUweD34VTaNKfNywykcxF5/LeAuvcEZQV1xBz4FI+tTd?=
 =?iso-8859-1?Q?HQSGx6utabzQLA+bKlmQitqmACKuwx5WZ1P51pK00fH/So+/NVKoYhoVTf?=
 =?iso-8859-1?Q?WI6ZHA+J3x3ODUxs6pDJlw+NMWb/XY+xf3EJqDcudoy2fx33WGGi18OnsW?=
 =?iso-8859-1?Q?9Nm//BOGmngFK645W64+azkVu9A7CiN13HUQnnwvxR/P80VDdWaGP08pzB?=
 =?iso-8859-1?Q?54y4SwIaS1m54gJnBjRB1u34T9YNxT1fkWWsqRBeNeleCrMdoI/gK8rZV3?=
 =?iso-8859-1?Q?cUsN8Rd12sEEQW5EySf3ObiAzm/tvbO0M6yVaB1LGunImJDZ+Dxht833RO?=
 =?iso-8859-1?Q?KPMED3EooQAroU8BnLpVIRy98nwd6g5nLucVLQWOzOekCHFnkdxQKQqsbq?=
 =?iso-8859-1?Q?5kuVfwSI2vqOrW9oEVjogPjMMZwsw0yzvl0uj4n2qGFopKh+smhSlMeS9p?=
 =?iso-8859-1?Q?3A6aPA/EaiSJXi1MtnJKN50lGeddBPM3gp/oqD4qtgkWwNf6VuSk11Y4N3?=
 =?iso-8859-1?Q?gPzsEk1Dlt7+YSBTDX1GJbwLHp67RnpSOfc0QE?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?EvDuwoAPoHEhWLZ28I30k+WrnUig4Owz1PnW+UalYIaOkGn8Cv7iQhoAIp?=
 =?iso-8859-1?Q?IYxHBg9lA0d62KXFA7q4Ob6+cOB4w3mSgc6LPFCLKJ7+VJQGyFxkgZ+jgv?=
 =?iso-8859-1?Q?1ST4nEdThwoWetK+yiUCd/7Asb7x2j+5hU5aMl0f3I0Rzg9FaKqqaZ07nR?=
 =?iso-8859-1?Q?HN4aGVKFDZLi/NmPY1rLbnwUH6Z7GQUpbjtV+/fUTfmlaB7sbhIEjJ1sTB?=
 =?iso-8859-1?Q?pdkgsUKMd5MZWR4jhnK94V2rL8lYRix92jt6w19SerzVq/VNXDt65NOAEX?=
 =?iso-8859-1?Q?Ih2Wznmz/ftfQkmR6L4B7q6sA7HOvsQTDhtE+L0BTZoGR3TX04dig6AHkh?=
 =?iso-8859-1?Q?yxVLerzTVlcAaqgJeY6r6GtCTJFpse8ge4T5HbWax3O9Dxi8SZL/hngn7W?=
 =?iso-8859-1?Q?3yf8McRJ2X054gkoHOBDuYbMZ7bTP/WCwDzhW0OP2Fi4NGfyWZSHUWZOgG?=
 =?iso-8859-1?Q?PX/eU/zZP2gw7Y5SA3CmBzTmdQIWtHvqdkVLWkLKjL+a8Lpd7r8T2A6I+2?=
 =?iso-8859-1?Q?SKjQWrsFhmp+PSDHXwJd/Fkerkh8URB80LO34ruYynRBFjRQ72L5ok3L3s?=
 =?iso-8859-1?Q?u5JJiHxEx/O585CaeUh5D+IYJCewkx+1YwSNsWxc3QD1q1gbVzoax1ZtC2?=
 =?iso-8859-1?Q?cuM+vCMl0NDUE8wneIJym62ykMLB12RvnkaWNEdV8cNrDH5FfyIIjIGmA9?=
 =?iso-8859-1?Q?9sQyFZvabcptJL7icwcnswtOZ2qIBi4ORZpMRVAkgZIc4Sc+v9eQEdHu0F?=
 =?iso-8859-1?Q?l6nEXfVWTASXC3BPozuN5zag7DrjzrLHqR4b6vQB24YhY3KxiMcjHQGnhx?=
 =?iso-8859-1?Q?AM9GukHqyaZMOYCd7nKVkfH3q994toUxbjylVIogpKtngOUjLIgeQf4FbZ?=
 =?iso-8859-1?Q?1u5s5aOxFz7eC2eWalTCCRJ9fYphESye1NcxVI/rmIzvR3oYXrGtNa1+Pf?=
 =?iso-8859-1?Q?rStoQoBB597UJ9EJpJ4d8AvUDmRoDTqvFLjVlcLRP31y9kWwiyAzH4H01d?=
 =?iso-8859-1?Q?H9ZFFuyXU/pt+512/GTi1Cw4oo6g7F4At1YU5GIIYDUCeKncXljjkWEHQk?=
 =?iso-8859-1?Q?rh3pzo7l5MhDhJC0ID+udcByfnGpMKwkvIqpDGlKzWPFJDekIOhNOHrRUE?=
 =?iso-8859-1?Q?iRqhJXml1XzmWUsBk2JlJrGHj9ShO3rSZrQOO6rllsZxFTYUawhby+cOuG?=
 =?iso-8859-1?Q?zIgt4UEX7LBllJu+WLixIaa08zUuH5V36dahQPzRucgFIKB6JV6tp77Y0k?=
 =?iso-8859-1?Q?izkrdQT7Ebo5yzTdaXoGw2dTVR06jUEEXBCxsaJfcuIeOwW0yEwUbebNGw?=
 =?iso-8859-1?Q?s9NeWYThcbJSrB/Vf3LHm8ED8lMUPxNMv0I16Fch29OpF7Y4fasr2RlhsX?=
 =?iso-8859-1?Q?8xetfX/fltjOeuxO29ApbpPt5ZaGagZk3qXsJrrv5lsbF2nOp3L7pkaNl7?=
 =?iso-8859-1?Q?FjwbPJ52MowqGC9ob/URuDwkSgrglVcuHajRPW/7Ue+nlOXnag6l721hcs?=
 =?iso-8859-1?Q?o=3D?=
Content-Type: multipart/mixed;
	boundary="_002_TYCPR01MB109273BCB71161ABE3AD85A8696952TYCPR01MB10927jp_"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c80d9985-e0b3-484e-9fc0-08df23c77d30
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 16:33:01.5405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11284

--_002_TYCPR01MB109273BCB71161ABE3AD85A8696952TYCPR01MB10927jp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Alex,=0A=
=0A=
Thanks for checking the tables, and Mario, thanks for the explanation of=0A=
the _DSD -> XDSD rename.=0A=
=0A=
That is consistent with the suggestion that the XDSD rename may be an=0A=
intentional way to keep an unused reference-code path disabled. This=0A=
GV302XV exposes only the 00:04.1 / NHI1 USB4 path, so the NHI0 XDSD issue=
=0A=
appears likely to be separate from the enumeration failure.=0A=
=0A=
Since you haven't been able to reproduce the failure, these are the=0A=
conditions that seem to matter on my system:=0A=
=0A=
  1. Cold boot with the dock disconnected.=0A=
=0A=
  2. 00:04.1 power/control =3D auto, with both 00:04.1 and the NHI=0A=
     (6b:00.6) runtime-suspended in D3cold before the dock is plugged in.=
=0A=
=0A=
  3. No PCI config-space access to the root port before the hot-plug.=0A=
     A config-space access wakes 00:04.1; both the targeted 4-byte config=
=0A=
     read in this capture and plain lspci in earlier tests caused=0A=
     enumeration to proceed normally.=0A=
=0A=
I captured a failing hot-plug under these conditions using:=0A=
=0A=
  kernel: 7.2.9-1-cachyos=0A=
  BIOS:   319=0A=
=0A=
The capture includes runtime-PM and PCI hotplug/link tracepoints,=0A=
pciehp / ACPI device-PM / Thunderbolt dynamic debug, and ACPI GPE and=0A=
/proc/interrupts snapshots before the plug, after the plug, and after=0A=
recovery.=0A=
=0A=
A redacted archive is attached.=0A=
=0A=
SHA256:=0A=
  4d4d7f64aeb4a2bbd8e68cf221de2002ad427d3456fc8354c06f3d3760dad065=0A=
=0A=
The relevant timeline from kernel.log is:=0A=
=0A=
  98.774=0A=
    First observable hot-plug effect. The NHI begins resuming from=0A=
    D3cold. IRQ 38 (00:08.3, PCIe PME / bwctrl) increased by one=0A=
    between the snapshots, which is consistent with a PME wake through=0A=
    the bridge hosting the NHI.=0A=
=0A=
  101.015 - 101.017=0A=
    Thunderbolt PCIe Down and Up tunnel paths are activated.=0A=
=0A=
  101.017 - 135.664=0A=
    00:04.1 remains suspended / D3cold.=0A=
    The NHI remains active / D0.=0A=
    09:00.0 remains absent.=0A=
=0A=
    No runtime-PM activity is recorded for 00:04.1.=0A=
    IRQ 35 (00:04.1 PME/AER/pciehp) remains at zero.=0A=
    None of the counted ACPI GPEs change.=0A=
=0A=
  135.664=0A=
    The script performs only a 4-byte read from:=0A=
=0A=
      /sys/bus/pci/devices/0000:00:04.1/config=0A=
=0A=
  135.668=0A=
    GP12 transitions from D3cold to D0.=0A=
=0A=
  135.681=0A=
    pciehp reports:=0A=
=0A=
      Card present=0A=
      Link Up=0A=
=0A=
    Its first link check after resume reports:=0A=
=0A=
      lnk_status =3D 0x3011=0A=
=0A=
    This has DLL Link Active set and no Link Training bit set.=0A=
=0A=
  135.808=0A=
    09:00.0 [8086:5786] begins enumerating.=0A=
=0A=
A full lspci scan was not needed.=0A=
=0A=
So the PCIe tunnel is established while 00:04.1 remains in D3cold, and=0A=
a targeted config-space read of 00:04.1 alone resumes the port. pciehp=0A=
then immediately finds an active link and enumerates the downstream=0A=
hierarchy.=0A=
=0A=
No wake of 00:04.1 was observed during the hot-plug window.=0A=
=0A=
The kernel also logs:=0A=
=0A=
  Wakeup disabled by ACPI=0A=
=0A=
for 00:04.1 on resume, so GP12 is ACPI wake-capable via _PRW.=0A=
=0A=
There are two observations I cannot explain yet:=0A=
=0A=
  1. sci_not increased from 6 to 7 while gpe10, gpe_all, and sci=0A=
     remained unchanged. The snapshots do not timestamp that increment,=0A=
     so it cannot yet be tied to the dock insertion.=0A=
=0A=
  2. The final Root Status of 00:04.1, read after recovery, shows:=0A=
=0A=
       PME ReqID 0021, PMEStatus+ PMEPending+=0A=
=0A=
     0021 decodes to 00:04.1.=0A=
=0A=
     IRQ 35 was zero in all three interrupt snapshots. Since Root Status=0A=
     was read only after recovery, I do not know when these PME bits=0A=
     became set.=0A=
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
=A0=0A=
On 10/6/26 09:33, Kovacs, Alexander wrote:=0A=
> AMD General=0A=
>=0A=
> Freeman,=0A=
>=0A=
> Ok, regarding the 00:03.1 device, I am seeing that it is misnamed in the =
tables.=0A=
>=0A=
> BIOS Bug Report: Thunderbolt/USB4 tunnel port `_DSD` misnamed `XDSD` (00:=
03.1 / NHI0 path)=0A=
>=0A=
> But that more than like does not have any bearing on the root dock enumer=
ation issue...=0A=
>=0A=
> I am unable to create a case where I can replicate your fail on my test s=
ystem yet.=0A=
>=0A=
_DSD -> XDSD is a strategy I've seen employed when someone wants to pick=0A=
up reference code but has a difference in their design (for example they=0A=
don't have a retimer connected to the second USB4 router and disabled=0A=
the IP.=0A=
=0A=
I don't know for sure; but my guess this is a strategy to avoid=0A=
technical debt and mistakes when merging future reference code versions.=

--_002_TYCPR01MB109273BCB71161ABE3AD85A8696952TYCPR01MB10927jp_
Content-Type: application/gzip;
	name="GV302XV-SD5000T5-d3cold-capture-20261006-redacted.tar.gz"
Content-Description: GV302XV-SD5000T5-d3cold-capture-20261006-redacted.tar.gz
Content-Disposition: attachment;
	filename="GV302XV-SD5000T5-d3cold-capture-20261006-redacted.tar.gz";
	size=33194; creation-date="Tue, 06 Oct 2026 16:14:55 GMT";
	modification-date="Tue, 06 Oct 2026 16:14:55 GMT"
Content-Transfer-Encoding: base64

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
z/bZPttn+/x7P/8HBV7mHgDAAwA=

--_002_TYCPR01MB109273BCB71161ABE3AD85A8696952TYCPR01MB10927jp_--
