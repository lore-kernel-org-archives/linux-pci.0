Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012048.outbound.protection.outlook.com [40.107.209.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDCE4AC16D;
	Mon,  5 Oct 2026 14:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791210952; cv=fail; b=Upg2dV8kcXzxF96bU3AlWWwUn3cdMw1YwoVBxGW19kZAfZkNmCSP1I24vpR3hq0ScEkwI2c0sg2Oqjd6snuH1SlRHa2DRkhbLV7b22OlNG8WSpNpgH1L3PekHvKgYnIg2jN+QsmMCSCQoaKJnZh7FjRnBqQTsxZcKT5EX14E4y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791210952; c=relaxed/simple;
	bh=2DJprmxbVGcOZNJXNZ6s2pI4zmFVilBpPCRLS4aW5m8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yscn0bzKT0TmhDGSm2BEkjDimvbF1HcTQon0L05Q3IP61q2yJaFzoYlQML6pA+yEaqRjIgiR4/sAT8YwrTdgx/3PrLcxPg/dBHKtAG4T+ha73dYYXHRf3N+t+/Cp97f3uIGwaNKFZG1hR1owAHva5TkMCGyl3bA9IDHuaUgtPhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cHunslqM; arc=fail smtp.client-ip=40.107.209.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cHunslqM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ilZ0s7wDOcEL2zpEuXY3zJX1h2av5xaSLNLAvFhpY+d0ZXh5dt9zsgJ/CN1yvbgjEeISE1nv1h+cHEPxwwF72xPsfPgpg5fBYb6bgtHo48pfeMrWID4E827ROdidrrpQctNbaM0wdWE/taY43DhNql6urUMFlGjbciSGRzi+bclH7ZlwB11Glmn7NwUo1aRAIp7DuCKCMfM38sGRv/Yu1jAcXNnlFtHw4cNyHbcI0iLN/VwPSR2uJxJyLmdX7o/ONWD5G1FJSw+LnjCoP55fLCPYQH6wa9ZXDUOLUu8YMhXIrjP2+EVkgcwd04lkDtdL+oZKN1Mm6ooGBPqESLTvkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBAMZ3rDSBqHjVy2feG4i3w+3r97x5vyvTU+tLWHIm4=;
 b=oCKsPkmiG3MoAveRzuwdsKGVyR6P2EmC/GefFHnhXtWNS1eANKGdVj9DtpTpwI5Qmy2LO6lRh7ZS++h/Bz0ABeWN6wICuTz3RSVgDFxVd9IaZzXsHl17yi7ufd6U+lrhL4rTvtiSVTBdq0+5fKBlweTBDBmU4e2TfLiG76YivlCGoFlMTYk9wqsL9CO7YT/GEg8L6k/ttbDGEdiLKxR2phu3S0mHAMmqIydEbU+yJ1zBdpcS0pyEjAH6iBwvdZFVNyMih8qyfHmzVOxlDrLVfhjR0oT/VEdAVSUYhtY8dUuumNTSqnQ7H741grv5H1PuLnflKCOkv+zGF66wVEffIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBAMZ3rDSBqHjVy2feG4i3w+3r97x5vyvTU+tLWHIm4=;
 b=cHunslqMC8Jf/paIubVmAbMagONZYEF94xWtiXeh2f8Tk1YtdwUueXpBvxC1/y1tJURa/e1+rwMTPRQGZZiHxU2R/8RpJBIVC3rqYoL8aDx0MLcufYq91kQqTUPXH662LQMeHJNKdDNVEaOqOUh7UWdP9cbPJhosk1Gm38aCVEs=
Received: from BL4PR12MB9533.namprd12.prod.outlook.com (2603:10b6:208:58f::21)
 by SJ2PR12MB8009.namprd12.prod.outlook.com (2603:10b6:a03:4c7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Mon, 5 Oct
 2026 14:35:31 +0000
Received: from BL4PR12MB9533.namprd12.prod.outlook.com
 ([fe80::d6cc:9c7e:12b9:a418]) by BL4PR12MB9533.namprd12.prod.outlook.com
 ([fe80::d6cc:9c7e:12b9:a418%6]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 14:35:31 +0000
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
 AQHdSd1c593zF2yuc0efXEtk9KFFoLbazowAgAA18BCAAAG7AIABCdYAgACB41CAAMQiAIABc02AgABGIACAAB+1gIAABT6AgAAnFgCAABFJAIAAA0aAgAAG3ACACVy6oIAAPdKAgAYEaGA=
Date: Mon, 5 Oct 2026 14:35:31 +0000
Message-ID:
 <BL4PR12MB953383C9C73C9715FB9C5A339C962@BL4PR12MB9533.namprd12.prod.outlook.com>
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
In-Reply-To:
 <TYCPR01MB109276162440B6A8CC34DEC73968A2@TYCPR01MB10927.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-01T14:46:55.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL4PR12MB9533:EE_|SJ2PR12MB8009:EE_
x-ms-office365-filtering-correlation-id: 1e2038e1-a230-47e4-0a38-08df22ede88b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|23010399003|22082099003|18002099003|38070700021|4143699003|6133799003|10067099003|260925021311599003|260925022911599003|260925021911599003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 RFbdK4GdeVbqxVPgZgGeNg97cFqsg3dCcu997IbXSFDpMqQCh3DexrSS9Fe3eruW9rMirk+I1Bwv/9N6dOwOTpih4of+UQlrfE2Z/FcQqWpN8Pkcdb81LK8c31zxrqsHZswTHnULhLCaeC7y+yrEaz/Po20t17ah5rOWj+Y5WrXiZyVTs1I4aJdU35mLw3UcZsV1tgXJa8KnBQP21wvQUK9o+6rwm4nSiYOEqgEYhqdMNSOM/qU7BPYkh9glj6J+Y2kHVkQK2z4N7Y2EjPd/s3gpaLorV5hiRLiXmYJ9p8YW9AUT8wl2sBW5eKlpTGi+gsn7ygcypMxzspF6hKvPh7l8vfrrZ648Wu0rz4nGo8kSBuihNrkfas0H71zo+Tt7xNvK+ObARMbk1/imAkzIfU8NtqcKHq5++X8x6Bt4jGZNsM/JIfvzlxPjJ9LNI3SAoadDHDccDVwW8VzWFFMfyLSWX+5wzwW0M3nxhcWDcg9bCPL5vb3bzFyMfx9xDdcu14pDUGwBJl4Z3BRViaWUsfzjMuLTasEP9G1kRHpLFO9WueOEWZ2W4LJwvh3qCeOsZUehkGiuO5tNIX6GlkoNqhI9dXkdZyN7OcoDtDbF9W39OIEeFhRY4rTB61vbM2OLxI0uQUhb7n0sId8t9VkH/qV0lxbzMRO76CqXUwGThuQD0cBzw+O5wSoJSzvsp9P0iTVYMlbgIvq7j4xZCeibZPZtqf7fQ60LHvuAga6Bj9k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9533.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(38070700021)(4143699003)(6133799003)(10067099003)(260925021311599003)(260925022911599003)(260925021911599003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NrJReZq+t0ZaHbxS28a9F8aWMEmVBZGVkkkn6NEu3OeatcywdGzjbT/iYog9?=
 =?us-ascii?Q?Q6wJ4bGJ8RwWV1NeWv4T85pXtYJ7gmEFnNcCbEXcvhjRHoyNMV7bxdmzCnGl?=
 =?us-ascii?Q?0kiUREiW4E5FbjPI9G2uE7lq3MjlMldrpyp2aYUrSbHXlb9mfGZvzOXW1bUG?=
 =?us-ascii?Q?ddQpFshpxrc6kxExEJLSn/x9IroD2iLhzfBpWReD2rvttKvLRgws2ZhUNnih?=
 =?us-ascii?Q?4zny6RJpqgUAHgodhlcBqJRA5EhWYw5VLu5ERkLjp0ipxF5mZXgoIoLbXwec?=
 =?us-ascii?Q?Dk4c+BpRRXKRpQgfUi9R1My3P9nipGKWlfM4D21RxB1G/XNQYeAL2ouKbwl7?=
 =?us-ascii?Q?fBp/1NKbyenA4FJXjw+T33tzBBtTK8jvT7OZrR/uijNixMytB2hO6qBeWO8I?=
 =?us-ascii?Q?8wuf3J09hIlPUNlHnyYiN6LyDBpvjIFoZuqnCZXYtGNHXsMKOZRiXXL0FbTd?=
 =?us-ascii?Q?qgrVpJ+WPiK2YNJctbqWkkMOe4O4jJwf/LxvRMEnVkBEqirBOxvS8D5/GRSE?=
 =?us-ascii?Q?Fou0yJCfwVNv3oZmDXpQwNzsrenSj4wt7b3B9Ms8eaT5BnM4BOcu8nERkRcd?=
 =?us-ascii?Q?bNKnLMEnz8YyJqOCkoXbeJCRHbefTnlFkmhkZTkYXzSw705+fECsDIBSgzoY?=
 =?us-ascii?Q?znxSQiYgfjLLaUzxBKk5p6l8h8ZhS94SuaC/ES46J+vwf0892NTIdUIITorC?=
 =?us-ascii?Q?kOlQnKn1IBm4yFhml3QcaZ+K47p5t16+WOxr+cgsDYH/G8PpvEDSj0xnszjW?=
 =?us-ascii?Q?f29XLBNDwFl16FL3/y54h9qhAcv/VWU0JSFwdDomwee7diAcisTrpRC8QqyJ?=
 =?us-ascii?Q?0lO3vqtratsd84TNCan16p5GRGdBp+V1AMl3Gl6qZzwV/PCMFv7Rv84JL3BW?=
 =?us-ascii?Q?SuRJ525yxUVq+tfmuhC1x6GWZRrUabCqammHsS2BB9xtWjGCMiYBGEUev1n5?=
 =?us-ascii?Q?37IBB1rJMpa1dSlN9mgR6cNVrykMEKoZb4KiuxUq3ZZeTCnPBwmex2noOjsz?=
 =?us-ascii?Q?/ZiZxMTDH6HE+MCnrFWzPvdzC6FCu5rBxhkcH9iW5l5tnmzclq25CMZMF02f?=
 =?us-ascii?Q?6qqSW78mXfj9HDXUfor/RR9aMhFu63qJz3Gxc6RZmELKOT6MTe0e5AijmIhe?=
 =?us-ascii?Q?S6eKz9Q2DOTfyQix2uTAMhU/AtxEGVPOP9kxs9rn91DgvefzGdRjIsVJ6VFb?=
 =?us-ascii?Q?Qdmb4Kb10rLwWMr6mXx80eRCHxYrNf2aU7dgqYfvYNuscfJikRGLtzFB5sRB?=
 =?us-ascii?Q?ugVdC/947beHrCICD/l6wr5Od+s52CrGrG7jyboARqAiKzcq/xOqZXJS04MF?=
 =?us-ascii?Q?Wl4190to1VdaAGFNfUu1Cd3Rvkiay65v08FA3/6no9MXzJf3s0xl+oONEjkM?=
 =?us-ascii?Q?gGCQQTTM0IXqfwnSPyUzBBSnIrlNIlTu7PlzQFlZZ28SF4jmE9jdO7HMY5dK?=
 =?us-ascii?Q?K2QDsB8phGMXSvncshp6JioAmY3FFTBEaVVQxRdgQYIqdaeeQbTgXEDijPcK?=
 =?us-ascii?Q?XQQz8snkyfqdRHvbH8iW2wdxRcSofrZcD9LYgW5H+sxbFMJ8bZPxe0os4tMn?=
 =?us-ascii?Q?pJq+w3jEx2s2NdEeXbAp8VpCQsfgFKnQ8kKRyjaZPoHhgAwkdSfQA7qi1Csb?=
 =?us-ascii?Q?ElKW+aUkLUEHd0ZxR5FmIUgu5LKwVZwwzMMY5W+Mixkaj+zo2MPRiYZ1opCN?=
 =?us-ascii?Q?QflwAa9CFNxjCIZFDIAYnFX+sivbLL4dHc7wpV4eWVeDsg+6?=
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
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9533.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e2038e1-a230-47e4-0a38-08df22ede88b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 14:35:31.3741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eOC20QdEfXBk0fkmyoAowTTmHkdwbctMDXo5NzSNlTXiOMO2oWfiKOLKuToHnuYU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8009

AMD General

Hi Freeman,

I have applied a patch to stop the toggling between suspended and active of=
 the 00:04.1 (AMD TB Tunnel Port Hub) and the Barlow Ridge device on my tes=
t system. Just to better understand why you are not seeing that issue and I=
 am,
can I get a zip of:
sudo cp /sys/firmware/acpi/tables/DSDT /sys/firmware/acpi/tables/SSDT* /<tm=
p-dir>/
iasl -d /<tmp-dir>/DSDT /<tmp-dir>/SSDT*          # decompile together so c=
ross-refs resolve

The ASL may give us an idea of your original issue with the dock suspending=
 and not recovering sub-devices...

Replied or Forwarded By:
Alex Kovacs
845-625-4422
akovacs@amd.com

-----Original Message-----
From: Freeman Z <SHD-ISAC@outlook.com>
Sent: Thursday, October 1, 2026 1:28 PM
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

I tested this with my original workaround disabled and after a reboot.

The Kensington SD5000T5 was connected the entire time, and
0000:00:04.1 had power/control=3Dauto.

I first monitored the sysfs runtime PM state directly. On my system,
0000:00:04.1 stayed consistently suspended rather than rapidly toggling bet=
ween active and suspended.

I then traced the kernel runtime-PM events for 3 minutes, filtering for
0000:00:04.1 and 0000:6b:00.6. I enabled:

    rpm:rpm_status
    rpm:rpm_suspend
    rpm:rpm_resume
    rpm:rpm_idle
    rpm:rpm_usage
    rpm:rpm_return_int

There were no events for either device during the 3-minute trace.

At the end of the test, the states were:

    0000:00:04.1
        runtime_status =3D suspended
        power_state    =3D D3cold

    0000:6b:00.6
        runtime_status =3D active
        power_state    =3D D0

I am not seeing the active/suspended toggling on 0000:00:04.1 that you are =
seeing on your test system, at least under this configuration.

Thanks,
Freeman

________________________________________
From: Kovacs, Alexander <Alexander.Kovacs@amd.com>
Sent: Thursday, October 1, 2026 22:54
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
Do you see any toggling between suspended and active (mostly shows in sysfs=
 as active but quickly and randomly toggles to different states) on the AMD=
 HOST Bridge Tunnel (maybe 00:04.1)? It seems the Barlow Ridge controller i=
s the cause of the toggling on my test system. I have tried this with 2 doc=
ks utilizing this controller and see that the Kensington SD5000T5 dock uses=
 it also.

Replied or Forwarded By:
Alex Kovacs
845-625-4422
akovacs@amd.com

-----Original Message-----
From: Freeman Z <SHD-ISAC@outlook.com>
Sent: Friday, September 25, 2026 10:49 AM
To: Limonciello, Mario <Mario.Limonciello@amd.com>; Mika Westerberg <mika.w=
esterberg@linux.intel.com>
Cc: Kovacs, Alexander <Alexander.Kovacs@amd.com>; linux-pci@vger.kernel.org=
; linux-usb@vger.kernel.org; bhelgaas@google.com; westeri@kernel.org; andre=
as.noever@gmail.com; YehezkelShB@gmail.com; rafael@kernel.org; linux-pm@vge=
r.kernel.org; S, Sanath <Sanath.S@amd.com>; Natikar, Basavaraj <Basavaraj.N=
atikar@amd.com>; Martinez, Juan <Juan.Martinez@amd.com>; Chia-Lin Kao (AceL=
an) <acelan.kao@canonical.com>
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


Hi Mario,

Yes. The laptop is already running BIOS 319, and I do not see a newer BIOS =
available from ASUS for this model.

BIOS 319 has also been installed on this laptop for over 1 year, the reprod=
uctions I reported were all done with this BIOS version.

Thanks,
Freeman

________________________________________
From: Mario Limonciello <mario.limonciello@amd.com>
Sent: Friday, September 25, 2026 23:24
To: Freeman Z <SHD-ISAC@outlook.com>; Mika Westerberg <mika.westerberg@linu=
x.intel.com>
Cc: Kovacs, Alexander <Alexander.Kovacs@amd.com>; linux-pci@vger.kernel.org=
 <linux-pci@vger.kernel.org>; linux-usb@vger.kernel.org <linux-usb@vger.ker=
nel.org>; bhelgaas@google.com <bhelgaas@google.com>; westeri@kernel.org <we=
steri@kernel.org>; andreas.noever@gmail.com <andreas.noever@gmail.com>; Yeh=
ezkelShB@gmail.com <yehezkelshb@gmail.com>; rafael@kernel.org <rafael@kerne=
l.org>; linux-pm@vger.kernel.org <linux-pm@vger.kernel.org>; S, Sanath <San=
ath.S@amd.com>; Natikar, Basavaraj <Basavaraj.Natikar@amd.com>; Martinez, J=
uan <Juan.Martinez@amd.com>; Chia-Lin Kao (AceLan) <acelan.kao@canonical.co=
m>
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration

On 9/25/26 10:12, Freeman Z wrote:> Hi Mario, Alex and Mika,
>
> Sure. Attached is the exact .config used for my unmodified Linus
> v7.3-rc4 test that reproduces the failure.
>
> SHA256:
>      488899cc5a0b5f2de69466df2639e39769d40d90682f51690400399a549309c2
>
> This is the final .config used after make olddefconfig for the v7.3-rc4 t=
est.
>
> The v7.3-rc4 delayed-rescan test that succeeded used the same configurati=
on base.
> The patched kernel was distinguished with a different LOCALVERSION.
>
> Please let me know if there are any other platform or configuration
> details that would help align the reference-board setup.
>
Thanks.  Can you also look for a BIOS update on your side from the vendor i=
n case it ends up being something unique to their BIOS?
