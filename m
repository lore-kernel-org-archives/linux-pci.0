Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011030.outbound.protection.outlook.com [52.103.43.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79B14DA9DC;
	Fri,  9 Oct 2026 13:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791550964; cv=fail; b=s64TwfvhB43ZwKcaSTxy0O8e2mfCvh+dX2trH3JPJxBB5anVpNs03trTuOEtNPlI9k7jywVnY9EzBmIhlapxy6OGryFW5SwWunmx5NH0ozn6oh+6FpRD7lFX23CdvUs0TptGtZFyBMK2oYEE4jBVnSxiZ/ZPy+xuAq+UqPpcEpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791550964; c=relaxed/simple;
	bh=5GQ9Ni2EBL1ZPqxNeuDPB4pJ5K/xOlpg3TVb+XrSOa0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HOFsvuqXiKRGD7SMPVUp6gIVmcrbOD5wHTgyMNIRiGte22Iphl7kIlMDmHAB5Wwp3i4M3136/skA3bhBbSWwJcCei4FaY7YwDHH/S74lDQKKxmtDjgsQOV24iSonuYxqLJmBBagfaibm8jSPcXMQ5+/Ghn2n4CHf8/CQQHwL5nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=EUYZQ4Lu; arc=fail smtp.client-ip=52.103.43.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="EUYZQ4Lu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JdSu7V+EUbkFl2ZhomjoS6ELR2MVXa+Bi9V6v7LZUexcNYZ1EWsE0DhY5zKufdLF28X4ii4dQGwLRcurtbOLZUf1LEsC18/fJKVg6NKtBICf8kNvV5orl7iSwwgcoHCYURaodd1uqfGUChCNUmJknDDW/+NxuRTGwCmTOXFWvDABtzqFj8i3czkjqChwmSwuDlTxmnCQO/CRmiMKua8D/XWTNVMEcBxWuc7ujfx9Hhw019bXXpgK+wjuI8Slz3ZrtQs6pjKuwzT6aWL4xexQFCSHENt5FM3tZqQVh8E1v/wDPj1zj8UV8W6qVmVGezQjDPlNDt57HfvCGKlAFuTkiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GQ9Ni2EBL1ZPqxNeuDPB4pJ5K/xOlpg3TVb+XrSOa0=;
 b=C/+W/3ggtqTpJ8ccxDEfwg8ddJgRQSN4NktBiIW0c5Jx5b4pMwK1THgKV1a/++7KSuZbauvUM5h3gaEkMks/L1xmDTVKCnX+WexkQlZz+s13bnp2i2irhUb7jElXXJKakVx1Jy06HQLHeoaZV4kRTuWzL2kzWR6ZtzsLjsFZWb96NwjZCn27zzrpuBT/FZZDeO04eQzFgG9svOjF1lcxsUmoPyitvnZ4HeYPVr5/g9zf90f4bFGk1aZYO6NHl27pDUp+knbAAhAk6B6fOdTpX3cR7U49kB5C88YH8BdYW3HtYz3H+uwXqFWVGOj1rITMN6G7lYQOi8nyXQLNbFjvxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GQ9Ni2EBL1ZPqxNeuDPB4pJ5K/xOlpg3TVb+XrSOa0=;
 b=EUYZQ4LujUx4ZCKczncqM1YY5+WUJGZlQMAZ1STR5WrohA426i75WiZf9pdSqCbM9fTBw6unzk9yl61i7MGrUdommY2dvvfc2uJwbm0nL64pdxUCTc3Y9NhWEjmkaaY2nGuVxqFwS/OHUcETlNKdT8S4tuQpjFrKmAWYhJEeHx1fasUftdHxWyZOeiPcrroUK873KCrI6C3geZttziGgjink1SNLPqn/S4a2QH4rEubxQsZhsRlXHbCvPyjD58nw7Xu8w+sOQnf++EpGBE+0vRsmxL+1VRwgTy1qEnrSfe2OqytLTbKOAZAWvD98uyJe3JhJOBIy4AlroqIQSOWvew==
Received: from TYCPR01MB10927.jpnprd01.prod.outlook.com
 (2603:1096:400:3aa::13) by TYRPR01MB12334.jpnprd01.prod.outlook.com
 (2603:1096:405:104::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 13:02:35 +0000
Received: from TYCPR01MB10927.jpnprd01.prod.outlook.com
 ([fe80::c225:1d5a:1a78:c5c7]) by TYCPR01MB10927.jpnprd01.prod.outlook.com
 ([fe80::c225:1d5a:1a78:c5c7%4]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 13:02:35 +0000
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
 AQHdSDNPea4qqw1tcEOkT/edQjHT9rbYfQ8AgACtPACAAaXMFIAAN8+AgAABpQCAAPzaBYAAjxGAgAC1UD2AAYHugIAAQ8E/gAAe2FyAAAh6gIAAJxUAgAAPH8SAAAVwgIAABbk/gAlgAYCAADo/D4AGCcGAgAAQnVOAABhFgIAAAdCwgAFnD4CAAAEXgIAAGv3dgAAQU4CAABZsJ4AADMmAgAAJ34CAAA64ZoAEMSwAgAADgPc=
Date: Fri, 9 Oct 2026 13:02:35 +0000
Message-ID:
 <TYCPR01MB10927E84328D5CB5D9278D98096922@TYCPR01MB10927.jpnprd01.prod.outlook.com>
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
 <DS7PR12MB955053FCD5A303347E165D429C952@DS7PR12MB9550.namprd12.prod.outlook.com>
 <TYCPR01MB1092781DD2EE8EC1EEAD4A52C96952@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <DS7PR12MB95504FE60773F44B1950FEF49C922@DS7PR12MB9550.namprd12.prod.outlook.com>
In-Reply-To:
 <DS7PR12MB95504FE60773F44B1950FEF49C922@DS7PR12MB9550.namprd12.prod.outlook.com>
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
x-ms-traffictypediagnostic: TYCPR01MB10927:EE_|TYRPR01MB12334:EE_
x-ms-office365-filtering-correlation-id: ff81fbd1-c53c-42e7-6ca5-08df2605967e
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|12121999013|41001999006|31061999003|8060799015|25010399006|8062599012|13031999006|24021099003|260826193500599007|15080799012|51005399006|15030799006|40105399003|18061999006|2607281247196008|102099032|26104999009|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?YVqRaknfYbVSn+m6AGHj/H75kj/xirOzfPRahh7cOGv6XJteBsFXRtK6i7?=
 =?iso-8859-1?Q?ImtDXqOX22BNBpAgthGhCTQ1mbrarn/xjdMiO091Diq+zoX5uIS21By2hn?=
 =?iso-8859-1?Q?0ESf567g7vUCbKLseyGziypQZ1Sfa/BtieDuAgy3UTyH4QYZzMwS9MRQ7q?=
 =?iso-8859-1?Q?C9ayQJLrcQXqbMbKwXI/hQLlKqwrsKN6Auj+vqCAIygZbdhljPY20YkcP6?=
 =?iso-8859-1?Q?PsIfiQaBDjXLrmv3+rrlsXdRr0CTVKABsRFRFgHFSI2NLVg2IFCAEGuEQw?=
 =?iso-8859-1?Q?AbWt9hCqghnJQcr7lO7Pzv/LrI3rsI3zsyGJONMnSUFEtr7g5d5zb19Sx1?=
 =?iso-8859-1?Q?po+Vk4YfliG1UGjRvqOm+lFNnXkZN2I9SEnITo3ychichXCukQWLpcbXPs?=
 =?iso-8859-1?Q?qOuemXkK2uu8Xksd2U+fbrmduZGI/H9gnSRAi6yLxc2uvC7mHMShfJk7RO?=
 =?iso-8859-1?Q?R47DCSVnfWzfEwXDWPp1BdLaibqADxW14TNrbmzt8cp7zEQCPuRAVdVb6v?=
 =?iso-8859-1?Q?bcaXFC7Wp/TYOuIrueVa3blTfXiiBsL9S1UsG8g7dhC3OdqbIuhz9FslWD?=
 =?iso-8859-1?Q?FXIVbJtA8me4toGY8NQGczy2a/ylna3dZHCdKTYfZddKjv/XP5EO8hLgZh?=
 =?iso-8859-1?Q?8L/x5wB8/qpXjinodG0lZJ3SHHq1WqWr3J5uy8BkoECQVnv1wrOUC+mXsG?=
 =?iso-8859-1?Q?5NQdygMWvEruFibH3dyrOxPLkX/+9tYQCSsQXJBONteBQXhc2xEA5HWsc0?=
 =?iso-8859-1?Q?NclzJ815qHoGE69mh6Z2/yC8W6ffkCL6WlelP6thIT1s8nJqzFLgSBY1KV?=
 =?iso-8859-1?Q?85uWA58+8NgShnrwMUwKdPLh8UfmF7gcUnzXoKpqcuo4wMjPDGxUU2/A5K?=
 =?iso-8859-1?Q?F/9VxjXVSTPaFqMr0YUY/dBeAUfQ8veIK5PMeCNdS2XLZ+BM8ml3mAo987?=
 =?iso-8859-1?Q?OAHIFKcooaPWVrZU1p/QZju4Zix5qr9a+DY9P50xtHfOHBvNAD4zPLhQR9?=
 =?iso-8859-1?Q?MpKoVC9TwRWkBzh2Z9vUyhlY7Sh4mh5mGJxfcqkrAUkfPmeV7+FSK7xAf7?=
 =?iso-8859-1?Q?tbnA7rZZ6cjqgKbnyDKGLBBm7NPlcL5LwmomI/KfUFllQX61PbxxPOtnuY?=
 =?iso-8859-1?Q?4e0lgsuIkqN2gZzKc808nQ6un/vlQhM21hm6ASrTXwODWPWEvM029DbEp4?=
 =?iso-8859-1?Q?E6VCTtvYWYpDvQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?GVLGzrUA0nZxnH3kA5m88AkiXQl7hDnn7zylIB70+oZgIcXQE7XqOOF//e?=
 =?iso-8859-1?Q?G8/uW5gOUerWW46JGlUJ2ua6PegiI4dvju32p+PMIVOFHMkf39sPlwyifn?=
 =?iso-8859-1?Q?vv+V+NaBGklvFmzNa7We9NQ7GezmHrGQdxbeeoRTaLDKxSp0uwRdFRAxvQ?=
 =?iso-8859-1?Q?3JnI5fB0GeGtoWSdM5yhX+KYksylgMO4F5AaLAgIb5kuu2TDDUgdDSfLZC?=
 =?iso-8859-1?Q?V0x04fRPuLeWyLFu5tYAThjURYPzqgHhRtTtZryoD27tLXaqBc4NeGLQ8/?=
 =?iso-8859-1?Q?HMvEIKmEqUem8xnmqVTEjFuo5H+IB/1yQ2YpN2xe8u/xjgm9dfvGKDJc6k?=
 =?iso-8859-1?Q?aoMevfDCPdDEeJnhoWVzg0OSnGPgTSee5DWevC/r2IRgiCLOuTEL6Y4m0Y?=
 =?iso-8859-1?Q?GTcgKaXq3X+fsg0FgOCzw7GPsxphVDpilZEOt+//NE4xST9urOJLa0/xHJ?=
 =?iso-8859-1?Q?FUUHBahWhAb8si5hcZ+XoLAVi1FpWtIqJBESDG4++8bQFJ/KbItT94iwR/?=
 =?iso-8859-1?Q?iNmTHYL8v8zVtkG7z5IJfuEYWA5zc2F/lJ6bIZ03K/He/OMJBr7o5AW9Gj?=
 =?iso-8859-1?Q?4MHcjBnmcqXPO2FAm4Vz07kXXcEuhl7qO3MSBCvolcsMvfpxK/eLuWcWB/?=
 =?iso-8859-1?Q?lXvU7mLKKlmuUzLXfYdXVnxWENFvw990r3bG3Cphaxm0VXlMm9bIn5nGME?=
 =?iso-8859-1?Q?1WV6rhsk54DWHP7E9JX50M7rWi3X05ibX8vlakHSJbEjFbpeCwLNd4A9mt?=
 =?iso-8859-1?Q?bDjtQBGnJodGVT4ogFhr1qjAB5xJCSTfv1xnbyj5Ubcj89WKjK/k3wgFGW?=
 =?iso-8859-1?Q?ezM6GuEMVAa3wbuuwaIuvwpGVsgf/OP3Oc5ppqAuvf++Wd5eTteNjLtH8m?=
 =?iso-8859-1?Q?TTTSUMcVbazD2QfmeHk7zDayMgt7NNKXuiOVI/REmdEYaeF+wm8p/Er8/x?=
 =?iso-8859-1?Q?nnBsHABl22NOm4mJmG6pjyJEq9SxWC3b3/pXr5qJIFIux2/MaLq8UMvFxy?=
 =?iso-8859-1?Q?9vgj4OgBf/aW5cNZSadjPAbgbO2BiPUrOO1bIajRREdC1QWzBEuM4+w54G?=
 =?iso-8859-1?Q?s2Eb7wr/vOFJIc4n3Wjg/gM7a17Iz/P9Q7LF12KRGUkOEH/k2zwSiINaU3?=
 =?iso-8859-1?Q?+iMcpXN4jiAIiFxyP0mzykeHqm/qT0ZGyJ5P/3CBQyPvCa+lCzSbTjAXP0?=
 =?iso-8859-1?Q?o9tGkVW/2j+43Q6682UMoYD0b/H0p3wUHMS6zKC5gkvlB0hsMKfJexn6+Z?=
 =?iso-8859-1?Q?mXRNuu1OIldMBsH0GvdEZ7o8a2j841Lu81U19DQUY0Uv5P0I8t2Yyj5HmB?=
 =?iso-8859-1?Q?Hf8cRB5BlhjxpCQ/LqC4/Ahb3Vq5hEr8es/HdoiMX+ojK4n8VAnarVrPv7?=
 =?iso-8859-1?Q?8KoRMzBeGV/pKT9jI8yStLzjKMByPI1Tj+OzVtVbfdO8Y1sJ85eWxUAVum?=
 =?iso-8859-1?Q?qLPzMNQDrLKSQ/BljWdtQLMV0tX3R+bDZuFuOHpdVSD45ron3i1qPpyPmX?=
 =?iso-8859-1?Q?g=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ff81fbd1-c53c-42e7-6ca5-08df2605967e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 13:02:35.1248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12334

Hi Alex,=0A=
=0A=
Yes, both tests were performed on CachyOS.=0A=
=0A=
Best regards,=0A=
Freeman=0A=
=0A=
________________________________________=0A=
From: Kovacs, Alexander <Alexander.Kovacs@amd.com>=0A=
Sent: Friday, October 9, 2026 20:47=0A=
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
For clarity, the D3Cold Allowed set to 0 and 1 tests were on the Catchy OS =
?=0A=
=0A=
Replied or Forwarded By:=0A=
Alex Kovacs=0A=
845-625-4422=0A=
akovacs@amd.com=0A=
=0A=
-----Original Message-----=0A=
From: Freeman Z <SHD-ISAC@outlook.com>=0A=
Sent: Tuesday, October 6, 2026 4:04 PM=0A=
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
Yes, with d3cold_allowed=3D0 the dock enumerates without lspci.=0A=
Logs for both cases are attached. Each was taken in its own cold boot with =
the dock unplugged at boot and the workaround disabled.=0A=
=0A=
=A0 d3cold_allowed=3D0:=0A=
=A0=A0=A0 before hot-plug:=0A=
=A0=A0=A0=A0=A0 00:04.1 =3D suspended/D3hot=0A=
=A0=A0=A0=A0=A0 NHI=A0=A0=A0=A0=A0 =3D suspended/D3cold=0A=
=A0=A0=A0=A0=A0 09:00.0=A0 =3D absent=0A=
=0A=
=A0=A0=A0 result:=0A=
=A0=A0=A0=A0=A0 PASS - 09:00.0 enumerated naturally=0A=
=0A=
=A0 d3cold_allowed=3D1:=0A=
=A0=A0=A0 before hot-plug:=0A=
=A0=A0=A0=A0=A0 00:04.1 =3D suspended/D3cold=0A=
=A0=A0=A0=A0=A0 NHI=A0=A0=A0=A0=A0 =3D suspended/D3cold=0A=
=A0=A0=A0=A0=A0 09:00.0=A0 =3D absent=0A=
=0A=
=A0=A0=A0 result:=0A=
=A0=A0=A0=A0=A0 FAIL - 00:04.1 remained suspended/D3cold and=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 09:00.0 never appeared=0A=
=0A=
With d3cold_allowed=3D0:=0A=
=0A=
=A0 gpe10: 27 -> 29 -> 31=0A=
=A0 gpe1A: remained 0=0A=
=0A=
With d3cold_allowed=3D1:=0A=
=0A=
=A0 gpe10: 23 -> 25 -> 27=0A=
=A0 gpe1A: remained 0=0A=
=0A=
GPE10 incremented by four in both cases.=0A=
=0A=
In the d3cold_allowed=3D0 run, the trace shows 00:04.1 receiving an runtime=
-resume request shortly afterwards. It reaches D0, pciehp immediately repor=
ts Card present / Link Up, and 09:00.0 then enumerates.=0A=
=0A=
In the d3cold_allowed=3D1 run, GPE10 also increments, but there is no runti=
me-resume event for 00:04.1 after the hot-plug. It remains in D3cold for th=
e rest of the capture and 09:00.0 remains absent.=0A=
=0A=
IRQ 35 for 00:04.1 remained at zero in /proc/interrupts in both runs.=0A=
=0A=
SHA256:=0A=
=0A=
=A0 d3cold-allowed-0-20261007-041520.tar.gz=0A=
=A0 5e0af29245592916fb1682cc0bd3bedfcd75a1863d2d1bab0c2ab72bb14bc292=0A=
=0A=
=A0 d3cold-allowed-1-20261007-041802.tar.gz=0A=
=A0 3f6e00600e65faf5fb5fd43f6d753c3900e6247500fe5f3297b6d23e25a0a8c4=0A=
=0A=
Best regards,=0A=
Freeman=0A=
=0A=
________________________________________=0A=
From: Kovacs, Alexander <Alexander.Kovacs@amd.com>=0A=
Sent: Wednesday, October 7, 2026 3:53=0A=
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
Thanks for the update. BTW can you try:=0A=
=0A=
BEFORE plugging the dock=0A=
=0A=
echo 0 > /sys/bus/pci/devices/0000:00:04.1/d3cold_allowed=0A=
=0A=
to see if the devices enumerate properly without the lspci. If they do can =
I get a log of the fail with echo 1 > /sys/bus/pci/devices/0000:00:04.1/d3c=
old_allowed=0A=
and the pass with echo 0 > /sys/bus/pci/devices/0000:00:04.1/d3cold_allowed=
=A0=A0 ?=0A=
=0A=
thanks!=0A=
=0A=
Replied or Forwarded By:=0A=
Alex Kovacs=0A=
845-625-4422=0A=
akovacs@amd.com=0A=
=0A=
-----Original Message-----=0A=
From: Kovacs, Alexander=0A=
Sent: Tuesday, October 6, 2026 2:18 PM=0A=
To: 'Freeman Z' <SHD-ISAC@outlook.com>; Limonciello, Mario <Mario.Limonciel=
lo@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>=0A=
Cc: linux-pci@vger.kernel.org; linux-usb@vger.kernel.org; bhelgaas@google.c=
om; westeri@kernel.org; andreas.noever@gmail.com; YehezkelShB@gmail.com; ra=
fael@kernel.org; linux-pm@vger.kernel.org; S, Sanath <Sanath.S@amd.com>; Na=
tikar, Basavaraj <Basavaraj.Natikar@amd.com>; Martinez, Juan <Juan.Martinez=
@amd.com>; Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>=0A=
Subject: RE: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration=0A=
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
