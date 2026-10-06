Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012033.outbound.protection.outlook.com [52.101.53.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F24226CE32;
	Tue,  6 Oct 2026 19:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791314309; cv=fail; b=WU+0mc0lY7D/Ia3KjXHm2IEXRSuTEToowVY37sQxsCAHYnorN8aciwr1Le2QSr9iXhX8yCmgi8NrwzOZDcAUwOTdd/uUWMDZJ3pASfp327/+zsJxOw1gkUCBNuXt8zVqDw4wIFRzbJ92utvut/ArG/MKN3eXVtopv3wZ1ejE990=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791314309; c=relaxed/simple;
	bh=fp3o88Y62VwyaV8ZYJBpD4YTJevRZGJ+Na6YLHfvf/8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QHbiQNE5tNwQU29eAXWea3QSphiPmK6K2NqKxzA2vHuFyA8QhwZDYRAtzbNvsfo5MX+8Mu2A7bG9D4PlzzdHrZIX5B8zNxGLD9eJ3MifGHWhqzVNnQ/a/Ywuu3uahh6F2chLNG6h+Vo/QmS7lVSQ9fSrk6OEQ5AVqNoJO/vowWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0VP9gzbq; arc=fail smtp.client-ip=52.101.53.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0VP9gzbq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=calodBvLY7gG+LX10NR1YukPrmxpg6+5k48aXxi2fNO4YXWqFiFLPaQo1dOa1fZC2Wi7H1m9oKGHbM/rGKypY8ckEPJAqq5gOf0sqTJC0H9X19fhvWNH4wttxWGpWGJXkhmfk1byCQXlbPf+m6s18SMp+IqUMpMfC6OkGwk0jrauA7/wWmjaDMRJQSipmqQqPBYXGlVimb0D9ihGev6CXuR9IGyl6arFGSgoAmqqJkeXtKFB5DDN4QKVwFzEmoOYIiW0mmZTBkgCXiURy2MNB1acqjCK79Sk91yf4aIn363LPbEwcm9mbcmHoCUFCusab8kcwYIDFEUBXpglq0HYfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8AMerAT/u2JlZ2IsKq7t6AMKRM46UFOhcqCGzBeWHg=;
 b=ntPkrepEFzct5SO+yUAzgN3CIGpM1i+DuvXFowuD/NwW0EufWkxIwJILtWu791EVogAVAdfT6qPVWutQLT48NhEe8oE8gZcoUXEE3m26ybtwakzOsZNSC/d3hdgDgEBA9vlOxz1KCIvwy8B/mzlceNZyYDgi1K9xG1cROsJG3qNyn+xWcdwBT3opkoxxppP73nV+WpGwBYg+CgCmWGwT+8mXBONKUPgd/ILkaPYUHw6z9XqdNqPeCeymqdF9GToyT5jxOKIxSjXApmW5oObqemHZfzsg84dw16CqUwx8OKeycM1v6DGtMpOdLxZHiYL4mdvyLbP5Zz6l2ekffLFAOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8AMerAT/u2JlZ2IsKq7t6AMKRM46UFOhcqCGzBeWHg=;
 b=0VP9gzbqmrC8Vu41CUu5y8Qb132CLMyZwJWAWikvj63UjAVvZ4Y29Bz/RAXKiaM6BG3HuqrtVTkij2TP08KrmNEocLNXsvtmO7RusyjPy1G6h8tJPvriW33/AGsRy4tL5JxSy9LjTy2hVgFzmNvRf/aRlrgOtsyJgyBkwgVrORo=
Received: from DS7PR12MB9550.namprd12.prod.outlook.com (2603:10b6:8:24e::16)
 by LVXPR12MB999195.namprd12.prod.outlook.com (2603:10b6:408:3dc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 6 Oct
 2026 19:18:23 +0000
Received: from DS7PR12MB9550.namprd12.prod.outlook.com
 ([fe80::e465:1aca:4c9a:6fb5]) by DS7PR12MB9550.namprd12.prod.outlook.com
 ([fe80::e465:1aca:4c9a:6fb5%2]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 19:18:23 +0000
From: "Kovacs, Alexander" <Alexander.Kovacs@amd.com>
To: Freeman Z <SHD-ISAC@outlook.com>, "Limonciello, Mario"
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
Subject: RE: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents
 JHL9480 downstream enumeration
Thread-Topic: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents
 JHL9480 downstream enumeration
Thread-Index:
 AQHdSd1c593zF2yuc0efXEtk9KFFoLbazowAgAA18BCAAAG7AIABCdYAgACB41CAAMQiAIABc02AgABGIACAAB+1gIAABT6AgAAnFgCAABFJAIAAA0aAgAAG3ACACVy6oIAAPdKAgAYEaGCAABWugIAAFm+AgAADFoCAAWNLMIAABEOAgAAgUoCAAAeDEIAAHYuAgAAI8kA=
Date: Tue, 6 Oct 2026 19:18:23 +0000
Message-ID:
 <DS7PR12MB9550496ABBB70227D5B2B0679C952@DS7PR12MB9550.namprd12.prod.outlook.com>
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
In-Reply-To:
 <TYCPR01MB109272C6ADB253EBABEEB30AC96952@TYCPR01MB10927.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-06T16:59:54.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB9550:EE_|LVXPR12MB999195:EE_
x-ms-office365-filtering-correlation-id: 224475f7-6b0e-47bd-b9a9-08df23de972c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|10067099003|56012099006|260925021911599003|260925021311599003|3023799007|11063799006|6133799003|5023799004|38070700021|260925022911599003|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 5udEBg6En1Q3N1iHDLXlXuIPRwR3AAzFwvnggSjaPoeKaSkFvr8+QwzAcOTqrZiNHqUEcPCi7LxhLlri5E7TUnCqdE6m1Af7b/pdQim03mvZupexm6cXoTid3QiHGl6lcUhIzneTBO4d9kSoE22WD4p7ExQd0Ky2eqSI5mIpFLmFlMZY+i3CLKKkkZ2KQUwMhoa2rOQh+j/H+nNIqdtE9j/WVofvYcmJSzKAvrNPRj9KIzwkJO9LljY9cxMLh7GdEQ7FQBoBFK49uOvMSa23OLAhhmPia2SZIyGhXbyrspv8losr+kRIAU9dmn/4uT5vj/c6TfhjwSByyOfLqqJqGee0/naNAKzy9RZusGMQD+Al1sfVRmfuHZjAGD80byeZBc6wpm4A0el/OqZEvh/h40j0D7obvJu0h6fDdK38ukbl4mySEsjg2Rv4edUP/nbLyglex2aBycGJqeddZ0zZpTUUcqEMxbuHUseYJ3ozormGmBmuvwJFWIZyvCMR7hzQ18pR4tVV/0hoRahIXD7AuWBXNn6HWTNehAfu24fWAgmrD5olWH0fUjB0J+IHOPvXceZhyMY1aNRV1Zfm0i5v0pNWzeMt9at/P+a9uwgGPhdPYe7TwUe8ZJorCgi6yegx0t9xylWmiPdD3SDbUFSQlzufszMsin2fAvDFdFEmRWmVE3DV0qEVF1eq50lVuWTZpFyelNmpN1ZXhoCzQ9X3SsVLvD5zgDdmuzEC3x5QquY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9550.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(10067099003)(56012099006)(260925021911599003)(260925021311599003)(3023799007)(11063799006)(6133799003)(5023799004)(38070700021)(260925022911599003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fEVUGHx9rxuWNhsa1hD0xe2FzhJu/LwLghd9IV1ZnmRPylnARYN8k1CqUua4?=
 =?us-ascii?Q?tirs0azOh4mVflF4Z2wt4oRnSyVyRqZMeD1dOiOh1FAB+FwqMgXCyZiyu7HR?=
 =?us-ascii?Q?xp0uoKU0KNBh5JkUdlFrTLejSdn59vjv8Iz8EEAKfxmfna2K74Bzi29fE74r?=
 =?us-ascii?Q?do5IcYmthwqhpVsN0Rddm7jdi7Trksoz3VlTAfQK4TQePnqqgbsMk3yfuTrr?=
 =?us-ascii?Q?FzSt+gD8j5s5AZP9XZy9Y9kdmSPkY1JLHdTwv3w+rSZ/G1FPnRB1SMvQe9uZ?=
 =?us-ascii?Q?K00scVtduhM60btfqU0fqwFbaAcwmF7fAGxYD2HuifO/sVrielEaCw+T+RYo?=
 =?us-ascii?Q?ypiiWRb19HYjOpVUHo9/rH6KAWqo6iZiD28ohtlz233aMC4uI7ySwAOpuT1Q?=
 =?us-ascii?Q?dL+pB66ryS+vyYJdZhm7brTR/xEYEIywXTrlnS5x3ufkaC2fI+vzyvI2n9PH?=
 =?us-ascii?Q?cNACqgWB75yWE/a/Fss6SOoO0X5LxCV13D8o483xWUEu3zL9ddYYiOHye63n?=
 =?us-ascii?Q?kQKek7t9IP0/7WbuDo6ZWWWkMxKXl9PCP1zuFLuvqdy1RjB1D646nHPL2FZc?=
 =?us-ascii?Q?pUGTCM5PPpFScSmc4AvCoZlPuLIi2GSgNUFNGdCT8onjXeKH9wSh4zUcOMBC?=
 =?us-ascii?Q?Toha44LjW2dfGrv6bwYAAt9lkGRpqG3kk4DEl7lDKh7T0naZrHIECtaoWyXr?=
 =?us-ascii?Q?Qrgq/81Pa4coWr4sYrsckXy2hT0MtU056GCvkwjobI5HgS8wpQ0JyLswA3+l?=
 =?us-ascii?Q?SnegHvCMIet749FTF+L0IR5u4m6uvvowYuO6Dci4Ro2mMCnVMOt85vmu/s9Z?=
 =?us-ascii?Q?+uvVDzeZdxYEvAbzKywLJTvbu5w4fvGbwfaTQFZlNLTlOV08cBlj7jiv72LD?=
 =?us-ascii?Q?VVKEYMGaVHjsZsWPVaGt04x3wLy+OtjzT/OMDD6DWB95pEj+ZCyO/IeULF7B?=
 =?us-ascii?Q?EetMB2AZS83biglpKmMqlGyxYp+DG8zewj8WJXTomO62loX8WiN6A5Hdi4i5?=
 =?us-ascii?Q?tOCqgAjCPwrPfr5IOu040Xlv4K04+4TpyW2tDaRtn8zdZMMxfxfnLaH3OeXM?=
 =?us-ascii?Q?KuRj7mVRPt8IFlND8YLXXus8yjiRGpUtfq//o0L2yV+Yb7H3/hYO+bJOjCnV?=
 =?us-ascii?Q?N/IEeEw6D95IzjE2iYIBvLLVM3GwclOPyrZ19F6NMWAMEY0kNao1tIefNrYJ?=
 =?us-ascii?Q?EfqC0Pkf8pG0uiUZK3/2nDXFVh6idTVHwwk7kDDTjr/TRzPnNBIM40wTc8pL?=
 =?us-ascii?Q?mELx/8S3h8FormhGHdKtf6si8LZa4yQr3Z1BbSU+rV6TIZcPGbSJBbMgsMz6?=
 =?us-ascii?Q?JdgvKgtTiU+OmDE/l23X3fx9hkdQSJbs1wJOVVQ8cOycVFcSrWOej2tJr8zM?=
 =?us-ascii?Q?EiWogV/fuISAg97g8C7iKgukfKracSkvc5UB24wx8VCGZnKrjdmJNoqB9evm?=
 =?us-ascii?Q?JmSdpT64W+v0Qog/+aU4wyUWHxnbrWEVJRHt0a8CpRgAGGnm1bMWLiPskp0l?=
 =?us-ascii?Q?kN0nkxz6s4xCdzrcal/u0ROKvky/Ezwh3G/1+NOkVbZkAVVFLPoKINbQNFeX?=
 =?us-ascii?Q?VIbs6I1xscpgxShB3PfBpVIunAdaM6V/WMIePBOT/gqDwuksYwZfVI/gOA/h?=
 =?us-ascii?Q?yFP6Ma4MFs4BuATO2vQUua8FsAwCKIscNirdzw4TR3OXStWvm12FTinTg3pa?=
 =?us-ascii?Q?YOPdIuPtqRlhYeq8inpJIZl0BOQO86M3ZukV8ud9JkobFmb4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9550.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 224475f7-6b0e-47bd-b9a9-08df23de972c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 19:18:23.5621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e+GH2spxgcmvpD8HD6zyaR15Dx5ej1OOAtTZ6jLSnw6E3U2ckmm4wm7RMZz5YKYK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR12MB999195

AMD General

Freeman,

I'm confused, did /sys/firmware/acpi/interrupts/gpe10 increment on plug ?

Replied or Forwarded By:
Alex Kovacs
845-625-4422
akovacs@amd.com

-----Original Message-----
From: Freeman Z <SHD-ISAC@outlook.com>
Sent: Tuesday, October 6, 2026 1:46 PM
To: Kovacs, Alexander <Alexander.Kovacs@amd.com>; Limonciello, Mario <Mario=
.Limonciello@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org; linux-usb@vger.kernel.org; bhelgaas@google.c=
om; westeri@kernel.org; andreas.noever@gmail.com; YehezkelShB@gmail.com; ra=
fael@kernel.org; linux-pm@vger.kernel.org; S, Sanath <Sanath.S@amd.com>; Na=
tikar, Basavaraj <Basavaraj.Natikar@amd.com>; Martinez, Juan <Juan.Martinez=
@amd.com>; Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


Hi Alex,

I reran the test with both 00:04.1 and the NHI in D3cold, polling the ACPI =
counters and device states every ~200 ms.

I pressed Enter late, so the manual "DOCK PLUGGED" marker should be ignored=
 for timing. The first observable hot-plug effect was:

  01:54:51.116
    NHI:      D3cold -> D0
    sci_not:  8 -> 9
    gpe10:    unchanged at 27

Then:

  01:54:54.083  gpe10/gpe_all/sci: 27 -> 29
  01:54:55.152  gpe10/gpe_all/sci: 29 -> 31

Despite those GPE10 events, 00:04.1 remained suspended/D3cold and
09:00.0 remained absent through the end of the capture. IRQ 35 for
00:04.1 also remained at zero.

I went back through the ACPI tables and noticed that GPE 0x1A and GPE 0x10 =
appear to be two distinct wake paths for GP12.

In SSDT17, GP12._PRW returns:

  { 0x1A, 0x04 }

and _GPE._L1A sends Device Wake notifications to GP12 and GP12.SWUS (as wel=
l as the associated GP19/NHI devices) without checking PCIe Root Status.

GPE 0x10 is different. In SSDT16, _GPE._E10 is the GPP PME dispatcher.
For GP12 it does:

  If (\_GPE.ET12 !=3D 0xFF)
  {
      \_GPE.ET12 =3D
          (M017 (Zero, 0x04, One, 0x78, Zero, 0x18) >> 0x10)

      if ET12 is 1 or 3:
          Notify (\_SB.PCI0.GP12, 0x02)
  }

For 00:04.1, offset 0x78 is the PCIe Root Status register (PCIe capability =
at 0x58 + 0x20).

A GPE10 increment only shows that _E10 ran; it does not by itself show that=
 the GP12 branch saw PME Status set or that GP12 received the Device Wake n=
otification.

In the earlier full capture, GPE 0x1A remained at zero in all three
snapshots: before the plug, after the failed hot-plug, and after the target=
ed config-space read. 00:04.1 remained in D3cold until that targeted read, =
which immediately caused GP12 to transition to D0 and the downstream hierar=
chy to enumerate.

GP12's _DSD also has HotPlugSupportInD3 =3D 1 and associates the port with =
GP19.NHI1 / USB4 port 2.

Best regards,
Freeman

________________________________________
From: Kovacs, Alexander <Alexander.Kovacs@amd.com>
Sent: Wednesday, October 7, 2026 1:12
To: Freeman Z <SHD-ISAC@outlook.com>; Limonciello, Mario <Mario.Limonciello=
@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>; linux-usb@vger.k=
ernel.org <linux-usb@vger.kernel.org>; bhelgaas@google.com <bhelgaas@google=
.com>; westeri@kernel.org <westeri@kernel.org>; andreas.noever@gmail.com <a=
ndreas.noever@gmail.com>; YehezkelShB@gmail.com <yehezkelshb@gmail.com>; ra=
fael@kernel.org <rafael@kernel.org>; linux-pm@vger.kernel.org <linux-pm@vge=
r.kernel.org>; S, Sanath <Sanath.S@amd.com>; Natikar, Basavaraj <Basavaraj.=
Natikar@amd.com>; Martinez, Juan <Juan.Martinez@amd.com>; Chia-Lin Kao (Ace=
Lan) <acelan.kao@canonical.com>
Subject: RE: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration

AMD General

Freeman,

Great, thanks for the confirmation...

Can you try:

get the 00:04.1 into a suspended state
Run:
sudo watch -n1 cat /sys/firmware/acpi/interrupts/gpe10
Perform hotplug of dock
  If gpe10 does not increment when the dock is plugged into the suspended p=
ort, that's proof the wake never fired - and it's likely the GPE-0x10 _E10 =
path. If it does tick but nothing enumerates, the miss is likely downstream=
 (native/pciehp
  side).

Replied or Forwarded By:
Alex Kovacs
845-625-4422
akovacs@amd.com

-----Original Message-----
From: Freeman Z <SHD-ISAC@outlook.com>
Sent: Tuesday, October 6, 2026 11:33 AM
To: Limonciello, Mario <Mario.Limonciello@amd.com>; Kovacs, Alexander <Alex=
ander.Kovacs@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org; linux-usb@vger.kernel.org; bhelgaas@google.c=
om; westeri@kernel.org; andreas.noever@gmail.com; YehezkelShB@gmail.com; ra=
fael@kernel.org; linux-pm@vger.kernel.org; S, Sanath <Sanath.S@amd.com>; Na=
tikar, Basavaraj <Basavaraj.Natikar@amd.com>; Martinez, Juan <Juan.Martinez=
@amd.com>; Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


Hi Alex,

Thanks for checking the tables, and Mario, thanks for the explanation of th=
e _DSD -> XDSD rename.

That is consistent with the suggestion that the XDSD rename may be an inten=
tional way to keep an unused reference-code path disabled. This GV302XV exp=
oses only the 00:04.1 / NHI1 USB4 path, so the NHI0 XDSD issue appears like=
ly to be separate from the enumeration failure.

Since you haven't been able to reproduce the failure, these are the conditi=
ons that seem to matter on my system:

  1. Cold boot with the dock disconnected.

  2. 00:04.1 power/control =3D auto, with both 00:04.1 and the NHI
     (6b:00.6) runtime-suspended in D3cold before the dock is plugged in.

  3. No PCI config-space access to the root port before the hot-plug.
     A config-space access wakes 00:04.1; both the targeted 4-byte config
     read in this capture and plain lspci in earlier tests caused
     enumeration to proceed normally.

I captured a failing hot-plug under these conditions using:

  kernel: 7.2.9-1-cachyos
  BIOS:   319

The capture includes runtime-PM and PCI hotplug/link tracepoints, pciehp / =
ACPI device-PM / Thunderbolt dynamic debug, and ACPI GPE and /proc/interrup=
ts snapshots before the plug, after the plug, and after recovery.

A redacted archive is attached.

SHA256:
  4d4d7f64aeb4a2bbd8e68cf221de2002ad427d3456fc8354c06f3d3760dad065

The relevant timeline from kernel.log is:

  98.774
    First observable hot-plug effect. The NHI begins resuming from
    D3cold. IRQ 38 (00:08.3, PCIe PME / bwctrl) increased by one
    between the snapshots, which is consistent with a PME wake through
    the bridge hosting the NHI.

  101.015 - 101.017
    Thunderbolt PCIe Down and Up tunnel paths are activated.

  101.017 - 135.664
    00:04.1 remains suspended / D3cold.
    The NHI remains active / D0.
    09:00.0 remains absent.

    No runtime-PM activity is recorded for 00:04.1.
    IRQ 35 (00:04.1 PME/AER/pciehp) remains at zero.
    None of the counted ACPI GPEs change.

  135.664
    The script performs only a 4-byte read from:

      /sys/bus/pci/devices/0000:00:04.1/config

  135.668
    GP12 transitions from D3cold to D0.

  135.681
    pciehp reports:

      Card present
      Link Up

    Its first link check after resume reports:

      lnk_status =3D 0x3011

    This has DLL Link Active set and no Link Training bit set.

  135.808
    09:00.0 [8086:5786] begins enumerating.

A full lspci scan was not needed.

So the PCIe tunnel is established while 00:04.1 remains in D3cold, and a ta=
rgeted config-space read of 00:04.1 alone resumes the port. pciehp then imm=
ediately finds an active link and enumerates the downstream hierarchy.

No wake of 00:04.1 was observed during the hot-plug window.

The kernel also logs:

  Wakeup disabled by ACPI

for 00:04.1 on resume, so GP12 is ACPI wake-capable via _PRW.

There are two observations I cannot explain yet:

  1. sci_not increased from 6 to 7 while gpe10, gpe_all, and sci
     remained unchanged. The snapshots do not timestamp that increment,
     so it cannot yet be tied to the dock insertion.

  2. The final Root Status of 00:04.1, read after recovery, shows:

       PME ReqID 0021, PMEStatus+ PMEPending+

     0021 decodes to 00:04.1.

     IRQ 35 was zero in all three interrupt snapshots. Since Root Status
     was read only after recovery, I do not know when these PME bits
     became set.

Best regards,
Freeman

________________________________________
From: Mario Limonciello <mario.limonciello@amd.com>
Sent: Tuesday, October 6, 2026 22:37
To: Kovacs, Alexander <Alexander.Kovacs@amd.com>; Freeman Z <SHD-ISAC@outlo=
ok.com>; Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>; linux-usb@vger.k=
ernel.org <linux-usb@vger.kernel.org>; bhelgaas@google.com <bhelgaas@google=
.com>; westeri@kernel.org <westeri@kernel.org>; andreas.noever@gmail.com <a=
ndreas.noever@gmail.com>; YehezkelShB@gmail.com <yehezkelshb@gmail.com>; ra=
fael@kernel.org <rafael@kernel.org>; linux-pm@vger.kernel.org <linux-pm@vge=
r.kernel.org>; S, Sanath <Sanath.S@amd.com>; Natikar, Basavaraj <Basavaraj.=
Natikar@amd.com>; Martinez, Juan <Juan.Martinez@amd.com>; Chia-Lin Kao (Ace=
Lan) <acelan.kao@canonical.com>
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration

On 10/6/26 09:33, Kovacs, Alexander wrote:
> AMD General
>
> Freeman,
>
> Ok, regarding the 00:03.1 device, I am seeing that it is misnamed in the =
tables.
>
> BIOS Bug Report: Thunderbolt/USB4 tunnel port `_DSD` misnamed `XDSD`
> (00:03.1 / NHI0 path)
>
> But that more than like does not have any bearing on the root dock enumer=
ation issue...
>
> I am unable to create a case where I can replicate your fail on my test s=
ystem yet.
>
_DSD -> XDSD is a strategy I've seen employed when someone wants to pick up=
 reference code but has a difference in their design (for example they don'=
t have a retimer connected to the second USB4 router and disabled the IP.

I don't know for sure; but my guess this is a strategy to avoid technical d=
ebt and mistakes when merging future reference code versions.
