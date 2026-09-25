Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010018.outbound.protection.outlook.com [52.103.43.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744F14D8DA0;
	Fri, 25 Sep 2026 15:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790351336; cv=fail; b=qibEN7JW07RLJefzadlkTgsuLInXAXVEu9XKFcvJwYLgcI01/YvL/ALu3KxCFZa1ytej8+Z2CwmmaISHL0xrtwLvxeVESR9uSthoYBXIYouOEH4m4MeYNNQMm6ls29/nNBkx5b0o5vqn9V3MqD8J5wjJxNGPkcEbC7kaBBmGn7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790351336; c=relaxed/simple;
	bh=uScpuFFXqw5QJjfihCcZI6rvhyBYRW0+5tZ3HFf7SCk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IoZU9/RHyFVAE+e909i1tzbC6K1L5DLt5A4vxpj8eyycMc/K5wnwTnPqC5/CszkvCWoZJ9Pi/SxiHEfYQITugeZHp4iKBcsPqNOH4AhnSD+eYir8ChCZedhjC+RLnmHNc7gJqQ0teN0vuknFA8AvCjR8qn0zgmxAOfj9RnUDGig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=n+tR2TrO; arc=fail smtp.client-ip=52.103.43.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="n+tR2TrO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rsNEtsUP7Mw2pk40MpdCN34M7UNNK2iVfWo3KkrLpjh035waLoc2mXH3RzNo2CSXQU88lI0NFblKZ41ikhS3d3wDc8FxmG5kskWeSnuttf1bWey7j6XS6xFhuKh+Rmz+esv/RJYojbd92A+PSkZFfh/f7uFwAp2m06NXYh9uIZ2QEDKDB+i0mpXGQhVSbcqi97wM9tVTvTqBeZpHWXmSRDJZVtQw9JrTyqaJZCVXl5mfctyJwEpmFdlnQSc+dVDCRDPkOHUAomfbM1XcPGQibjI//i7hC2G4wHAdb8VIFDtyo7X7TxoooNwyahEZSuGJWhTvRWs+k+xdiFc61olTrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uScpuFFXqw5QJjfihCcZI6rvhyBYRW0+5tZ3HFf7SCk=;
 b=XWHuby6bllyhyM3E9O2S7N0/B8oySx1+o8Q6znBC1SMnoRNel+/7fG25E7kUuERJ3CIwoMTYf3KkZ0/GGd8wxDobK+P4TQUA3L2T38gWsnUC6IOdLU6ykeb+UOpIKmEK7WLSaq+/7ATF93VUjBg9H0EBRvdP0MAJqa7GJYdw6Qb4wu5hf6b8zXqlWyimaPPcgj8avbXSAoRY09hcwN4b75SY2cacbjYzctBdaKuVt0VpDUhrHzZWeu1gOgUAHCoPOaDyB7+K2DmAyAuaDOxSDzukIpr20QTLr7yQGEaSG8Rk8ZnJ7CR15ybaiA1L8dZJFBm5jetOZvtvdl9HgPGIuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uScpuFFXqw5QJjfihCcZI6rvhyBYRW0+5tZ3HFf7SCk=;
 b=n+tR2TrOBNI9eLzqAARCMfjVUj2+lQvJV/D6yfbJ8xpEMw2DpJAlYtCmNeu+VwVREkCmB/RwWkf43sKT3Fv6RoA13qxMVW8E7T+g+y79BkgyDUpoT4cZ3YnRH1hEneiwVsKBa3yHJzkCYORrz2f+fT4fuEiMHIPWsIaFY+tMNIVr8t6cnSgryUcYWZPKbStWrac66kqcY5N/MwZHvITt8y1V737enyUFZQZyRFuBYYT2Q1PAR042tiMTcN+exGcg21KXWJhpft01+tZxPXaHbNiriiEICbyKMRDOHCcLWJ5wCXUodPPB1ztgzyegLpD7QzxhVqYJkCOgTt8PwCPF6g==
Received: from TYCPR01MB10927.jpnprd01.prod.outlook.com
 (2603:1096:400:3aa::13) by OS9PR01MB14142.jpnprd01.prod.outlook.com
 (2603:1096:604:360::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Fri, 25 Sep
 2026 15:48:42 +0000
Received: from TYCPR01MB10927.jpnprd01.prod.outlook.com
 ([fe80::c225:1d5a:1a78:c5c7]) by TYCPR01MB10927.jpnprd01.prod.outlook.com
 ([fe80::c225:1d5a:1a78:c5c7%4]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 15:48:42 +0000
From: Freeman Z <SHD-ISAC@outlook.com>
To: Mario Limonciello <mario.limonciello@amd.com>, Mika Westerberg
	<mika.westerberg@linux.intel.com>
CC: "Kovacs, Alexander" <Alexander.Kovacs@amd.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
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
 AQHdSDNPea4qqw1tcEOkT/edQjHT9rbYfQ8AgACtPACAAaXMFIAAN8+AgAABpQCAAPzaBYAAjxGAgAC1UD2AAYHugIAAQ8E/gAAe2FyAAAh6gIAAJxUAgAAPH8SAAAVwgIAABbk/
Date: Fri, 25 Sep 2026 15:48:42 +0000
Message-ID:
 <TYCPR01MB109279CDE9AAF47B40FD1770996802@TYCPR01MB10927.jpnprd01.prod.outlook.com>
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
In-Reply-To: <7822cb02-f32b-4f02-ba65-4b90ebc42ce8@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10927:EE_|OS9PR01MB14142:EE_
x-ms-office365-filtering-correlation-id: e8cf60ad-5d30-481c-50a3-08df1b1c79e2
x-ms-exchange-slblob-mailprops:
 qdrM8TqeFBvhuFgLLe5qs4jWk9CHdv0AIlX9X84YAsUCD8Js/BT4S+LlygFOhD8c6RCGqK80fWowN5sb0W79yyOkfAbmuXoac7wFMeMBwSoGs6APvlsFxV5zsgYv424pJHFNqUVddTrTDyprpu4v9FfK/RdPUbgK2oqlzpibcmkTwsKe43SdpSlLfCdwIJAD2Gwcgnsns/w0K8moEy23C0NE6tvMOUaC20g5rEQ+lCIE0st7+tPmnHlWHpLKMplOOPM1ya6a78P5OOlzun2UcXgRmg1TBknqv2IizkX4pGBdPmgDqSeOWKE5HRtl8r3rlHg+AdsWcpUMpcNJ6zcA4F/W+zd3c76vHyb92ukruMM5UuzAtJBjMGImQxMSwKhFsDq+G2u1iMtJekAn+btG3RxTlHqoW70XfzmEpVDni0UEAhHQ1PByVRc9SuMEdDIolmrSJE2/GATzYvue6SJyK6rgi5+En9rPyezXsZ7u7bfAm3piGYUGkaIlqbcaOkSH9Hixe55ZTWZ0KClUqulajCpxygGC2GQ97S4PC14iBgvxwKb3bIE4HxDkKaIa3M/C2ly2mZl22ftJlfW4vwgOtasUPsIWpslbOKjRHkYNMGgCrdxHI+/Hl87QkKeJy3ko/LqzGr8YOc3VwR1S6zY9WzxWX6+2pZmHyElD9xtje2Tc+F6oyX7DdF3KRalZGcpalwu13mCerApkrPsiEFSDOgxbimeajgu5whYY9ftzyvjTLumcHsOb89Po7Ca2G3KVBTmJL3l/C5YcEaVLd3gI+5kC1s/fw9hH
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|15030799006|51005399006|15080799012|25010399006|8062599012|19110799012|31061999003|24021099003|3412199025|440099028|26104999009|102099032|40105399003|2607281247196008;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?PjCC7rwA0eNpG33fqfH20lmghhijFRX33onwakDJcpBgo7Y8P1UUr3mk1Q?=
 =?iso-8859-1?Q?SH0BGok32jOh84z5CqsloGKgMFU2vTZaRVqxMEX2DUgotH1Yuau2MCgXR4?=
 =?iso-8859-1?Q?XxaKMup8er3svKw3s9oNUnmJ0h4Wghfv8FLBFfx+P0VeuDwQkPayrnUJ6Q?=
 =?iso-8859-1?Q?8OLS6Fz9MotHutj4PDaUA/UWv/rTVXLn57R5VSwc2vEyUYXKKu2Cu/5tx3?=
 =?iso-8859-1?Q?orKfluMTEXfOm6NEw7QUgMcQafCVT1KUn8W1N8FJ70YvHln1lWDAoP6BNG?=
 =?iso-8859-1?Q?MgNddKQu8kCw5JEHROToBKguHic/iba1pZ1hchDDUmnJT2pjhcf1A2rBvw?=
 =?iso-8859-1?Q?T1RGsOHKJ5/m7kn5XZPfaxZWuj7U0gK3XE0PiCMa33HTg3P8KGkNCivHdW?=
 =?iso-8859-1?Q?LIMWRmMyr+vzZfvHKPkdCVI1Jthn/NNFJp734xtmqt09HYx3UGAA+5/9Uh?=
 =?iso-8859-1?Q?r+3GnZsfOpuYW0et48+oKrwrXQwChpvmQxpWGrpipuKBHkdug2anNArRAl?=
 =?iso-8859-1?Q?rkobGHrpXsQa4Tg/s4er/V9y6dBLCJvhtqejq+6zVoDqNtIo7EuFDr6qef?=
 =?iso-8859-1?Q?VQtbkKC1e/as8uv7JSNUMlmKqCSSAbgvDtpFbQCOPNuKbEPpNW+D6AT12j?=
 =?iso-8859-1?Q?0OgNVh1IAExx/P4yHkmS/R6qKt0r/4aaKKzM4QyYDsJiPZyle2FRPU7XDJ?=
 =?iso-8859-1?Q?ZLis2+YmaISqJMZhL1Zv6A4+E/CRLlNXaHU24cmq6cxV/xar5Pm8NhPftq?=
 =?iso-8859-1?Q?HWebEpouEqke8ytfa9rqTqKIRszVtID+TtPTNlwCbwFdQhLKJEXcCMqaQk?=
 =?iso-8859-1?Q?dlH16d6731Fx4F2L8bhz/mmeR9JqsD5FZKNlEq/xlKKYsKAh9z4Vmz37dH?=
 =?iso-8859-1?Q?Mr8zknXxe8B8rGCcMyK3c7BEhEfMcLPL07QXnfYMj58lY3b1RS/o6tlL3P?=
 =?iso-8859-1?Q?HYZsyKEbmKlAF0v+gV5j7IhojxqAJYIBTvQbPd0J+BVnJbMBNgXT77zHfN?=
 =?iso-8859-1?Q?HRY4wsqbQ08mfeA7k=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?1LUegSzzphi8iFLbBFd0WN+QUzMUmJVFIPH/7mbJOUYSUHsrj8k60fw4H2?=
 =?iso-8859-1?Q?T3MAaGtNTKxoQKZaIsrxlPNuglSXjYV3fqCCZy5vPn0LW6AetyK+BNkr/u?=
 =?iso-8859-1?Q?HA0ry3uH9k9ak6hcak4Ponq4sT1ZOq4MhQx3/tBITAX/lpEHe4NUNwKgyW?=
 =?iso-8859-1?Q?uETYCF9OTkhEKFfUjOFwd5b/vj57t3CSdAkoUtBGYOqtsy6kJx/Ni0AIOj?=
 =?iso-8859-1?Q?F+Ncy+MWub3oa/YzV0e4itgCC9Tagefh1JhCchAlFHODT+HoXSiGCsurOX?=
 =?iso-8859-1?Q?g0V5HmBM+LZGypB8fU5dmDpQX20YK7hz7+FLjQpz79sNWckGLbJzBD6ki9?=
 =?iso-8859-1?Q?iLuqwqAVTOoNwohNDPE+HPPD02tt+6xiN/tRmv+iTieiO6aE9nwST11m5K?=
 =?iso-8859-1?Q?3qSu2fvk34p9LpYe2mcT0sjaV1FMk67zGVyvjh4YX085qdc/ZqgaumHMrV?=
 =?iso-8859-1?Q?xmbhaHbeYyI091qZjRnPaW8x7Mg9k21AAkD2Di80hhSmfwNvIBWbUAfy6w?=
 =?iso-8859-1?Q?Xs+5G/og0sgYih6jmQzwF1iXZ998Qd9roZvNKKkJJRC15eu6VNmeMczr3B?=
 =?iso-8859-1?Q?4nkmWd17O9Q83TAcSFJ1UJfwUQLh4UpvpphnGKqjseXRy0F1kWfj5dQXAx?=
 =?iso-8859-1?Q?Q6AL2Cewt+IrNszZ/LVueT5CHJD1NeoKGkIBjmwAXR4xykeu22ZvoGlwy7?=
 =?iso-8859-1?Q?NJAcck7smzjIEUsRk5Umj18HTX31I4TTieR0BU+FkyudiKpDKZ+4Wuuj3g?=
 =?iso-8859-1?Q?RBln5hqjzQXpaSQotUJZyKCT6M3g/zGx46+2y433iUW+MCQ65RKsB0Ir7H?=
 =?iso-8859-1?Q?JpG90OUwsZgmOWP+GbdlkekC5dHWFpLT1CAOax0EP2wFsA5DnT6CkCW+B4?=
 =?iso-8859-1?Q?YhTaZzdHZOhkPsg1dX42D2bnb5Syvswgm3T7FSdMBdXfWC7JGbIh/FDje9?=
 =?iso-8859-1?Q?+txEgMThahX5hxWxqq033fTxeUV9pZ+JHORMgbOoRJ7O5ArbDoUpSxMPM2?=
 =?iso-8859-1?Q?i4FNDdZWHk5AVSuiYwV9Cx+boB4oFnAeNtngBaqHYtSHqa3CtZAu79WA5l?=
 =?iso-8859-1?Q?yE0PHPz4TW3O7doqgLP2KGYpSl2JYS1xsieBqekp1a/hjuLqo9AXVdCrV3?=
 =?iso-8859-1?Q?2JSitHyBn/5dLycXLbv18YEXZx2D3ZF8Qr83UjxKbX6y9fP01eo3CGt6bv?=
 =?iso-8859-1?Q?f/ricNwu2aIeW8C6Qk7h1u6Xsl8ULpptwvIiXHm+S2X1nVscVvPncz0NCr?=
 =?iso-8859-1?Q?2Kdzg0eV2kHHwhlT1EP1xTmCvJM52c8dZv/cfCz/uEja03E/MWxkvZNBBE?=
 =?iso-8859-1?Q?ZC8AD331l+m3cuWJRWgsr14/kmajGeE+zS3nXQPAqdaNfYEw+RAlVCcYba?=
 =?iso-8859-1?Q?8WSJe0ioWjb/IoLuYVBiFzrtJVFFdr4cdZrmJw6t2caILEjsb/P8VYJqdV?=
 =?iso-8859-1?Q?tO2AS30w7eUfRKXcXxPn+D4aEaQbnBYgVI3b4Q=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e8cf60ad-5d30-481c-50a3-08df1b1c79e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2026 15:48:42.6862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14142

Hi Mario,=0A=
=0A=
Yes. The laptop is already running BIOS 319, and I do not see a=0A=
newer BIOS available from ASUS for this model.=0A=
=0A=
BIOS 319 has also been installed on this laptop for over 1 year, =0A=
the reproductions I reported were all done with this BIOS version.=0A=
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
=A0=0A=
On 9/25/26 10:12, Freeman Z wrote:> Hi Mario, Alex and Mika,=0A=
>=0A=
> Sure. Attached is the exact .config used for my unmodified Linus v7.3-rc4=
 test=0A=
> that reproduces the failure.=0A=
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
> Please let me know if there are any other platform or configuration detai=
ls that=0A=
> would help align the reference-board setup.=0A=
>=0A=
Thanks.=A0 Can you also look for a BIOS update on your side from the=0A=
vendor in case it ends up being something unique to their BIOS?=
