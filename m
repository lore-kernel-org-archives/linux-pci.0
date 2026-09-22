Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011053.outbound.protection.outlook.com [52.101.52.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899903B7B7F;
	Tue, 22 Sep 2026 17:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790096628; cv=fail; b=iTQUJzkR9+GQ3iA3mj5QKLshAUxpDB0KnC8Fi6i+8+KJdCFl07+fTPEq+5fT0lF0j3vsoJ+xKWSEPIIY0kIc/YUl8ctutSHlImkpYs/5LWkzL07am/76BS3bjwLqdB5bQxci5uQB+S8yjZEmPmAgMB2tL4PLW2io6jWnpVu/rdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790096628; c=relaxed/simple;
	bh=GiXRm9pezEY2satTAzCk3klcbFwZzX9+obEreEPaNxg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wid6k7r+/UsEMyQsSfpEK3DtZe4graWDldJPXyttHZFyn8p3K30bzdBtRoRIbgk/Cc4M6rGjyZ1TQpKVMFWdtuv7/gqqIjNbwhXUNgux40wzFON5GifbnkqfZz//ti/MS1j8Z1SrGJFWmQUKUp/RE03Rj+trVRUSyhpxRtHpPtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Z0KhGOIP; arc=fail smtp.client-ip=52.101.52.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Z0KhGOIP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yOmmKdSHgTCEHlBEgJ9ucLG7wvjFcaMWE+gTGNUDN5wYy+t3TR8XPFnhBHYATC6wTfRFLoZqoAttYcff52dRySsJ0iytMZwlxigi71de3+O76PFQOy6bH/Q97pyzVsuNE3HrK1UFXrZv5MaDuyt5llGXJBAqsD/r2YwxEZoOECAhPD8n+aXceJrXh+SoI2Q5aRVjc9nfGWIdDgvcg6d4+0/JsP5OsaOcsOgXSl8ObX4iamHeBkHRXuASx9TqdWF5ePuYkrO8RKpzXLGFvb6JSGCqK+NzlbtQpmf59ggtbodRRw5q1E9CzQKd1IJ2gKp4ggGi7QCr5mHavJVnpJwLZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdtjewlMm65QN53RDIMufeyYqr1xHeEFTSG3YOOXFNs=;
 b=KpR6wG7RjbAoj+VK+rTw4Kag9hPJbeo9G1giUV6QSZEejThTy1eI4sRFJmX9z/INrpExd1sFiE/4/VBrSlFsfQnYgYIBte8UAwBtAIdlMsGEOoDMmhh7IlPcnQeeYySah3ThicjTr3Pgp9EuuBBNnQ4Sl7LdG5GdVhTXrlBZJC7+0dlhHvy9DVCgkXugnbbFL/PHQ6SyGIdtxu1JnbbPFQGffWb9sMmpEeoMY2QDUDVCrH6cD/+pGlgyAd6yjqjZ+4/KVJngVcCfQiT/0ttpXPZljy1ndEMLeCpIRa8MBLV5GXgDueLQwWqbWoiGsIWfpb3aclZa4u5BzkafWM1Kmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdtjewlMm65QN53RDIMufeyYqr1xHeEFTSG3YOOXFNs=;
 b=Z0KhGOIPjsDW/Yna+6U6hZVbf1mWpWf4pMqIzVjnFBvzeKt0yZ797oXVyU/ap0l+jGIJpOOldywakeMPg/RSVaWwnlffWFilUP+7zhaKPuas5MCPQTUyBV/Y+NxzmoUX/fwWihD6c2IQuaVhQYE+qGq5jabNpSZxHOOWVFcTfRA=
Received: from BL4PR12MB9533.namprd12.prod.outlook.com (2603:10b6:208:58f::21)
 by BY5PR12MB4098.namprd12.prod.outlook.com (2603:10b6:a03:205::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 17:03:41 +0000
Received: from BL4PR12MB9533.namprd12.prod.outlook.com
 ([fe80::d6cc:9c7e:12b9:a418]) by BL4PR12MB9533.namprd12.prod.outlook.com
 ([fe80::d6cc:9c7e:12b9:a418%6]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 17:03:40 +0000
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
	<Basavaraj.Natikar@amd.com>
Subject: RE: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents
 JHL9480 downstream enumeration
Thread-Topic: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents
 JHL9480 downstream enumeration
Thread-Index: AQHdSd1c593zF2yuc0efXEtk9KFFoLbazowAgAAFwVCAAAB1YA==
Date: Tue, 22 Sep 2026 17:03:40 +0000
Message-ID:
 <BL4PR12MB9533F4CBAB4CB4135352E23E9C832@BL4PR12MB9533.namprd12.prod.outlook.com>
References:
 <TYCPR01MB1092795BE7AB51121BBAB292496862@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <20260921050450.GM106095@black.igk.intel.com>
 <f8b929da-b4ae-48ae-9667-3eb93aa0a4bd@amd.com>
 <TYCPR01MB10927E6DC71CDC3B39C26F35196832@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <BL4PR12MB9533DE7B38357377187023B59C832@BL4PR12MB9533.namprd12.prod.outlook.com>
In-Reply-To:
 <BL4PR12MB9533DE7B38357377187023B59C832@BL4PR12MB9533.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-22T17:01:31.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL4PR12MB9533:EE_|BY5PR12MB4098:EE_
x-ms-office365-filtering-correlation-id: ec509d0d-82f8-4cb7-00b0-08df18cb73b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|10067099003|56012099006|6133799003|18002099003|22082099003|4143699003|5023799004|11063799006|38070700021;
x-microsoft-antispam-message-info:
 pB48GEseKWf94PAnZkhLCT3y+S0RYg/9DSnSvuMU/b3yXz7nPbH6ZNG8QzxUnhMcqd5IVZKjg4kMZrIErp5jO8jAEN+q/sUM3hKnBs62g/LqlbG51JpymlLkLAup8NA/aO0gLOXLcY0iuFebXZ8BYR12TGk1SQJ3gvfwcEqcrLeKdNAOQ13USvE0djjWtroqoDDLnyzUO6ZZKz4906/1zh3tg82URuBDnzgOrDks5ryI9DtGruIa/xrYETNQOUZJrBLhE1FqOpyowlpLoFbIKlg/JE4V52DDOFYKaTrON/bu8JgAiNqqizMiHXl5P7L70Jb3Pzu9HaTINUiVozeOccInfeOBs/YLq8V98qwN7shlrOZH7uU7RTWiCMVUlSjmdHnBSYeynhTCj24tHdrMXLA3S+kgMIwdVtZ7VcL2yys2cCtjmBndFJUKnlGqlwuOXNXdsv2V3CLJpEUqQub2FeKOYO3qyrl0jX9T6pt6/3WHYb1XV0v+bOzN0B3wEypu+QT7o1/dHbshdGOskRBtc3PId7qBBASWFRa9ZNFOnGTnwN7KiEMQKJ4EWD/2hc/mR0mEMHTODJR9ulQDij1U3HTa3BQX/bDhapzIvhv/3dhlX7yR9ESlkUzaNV4tOw93lF7GmlMwgPZwst9HfdPpc8AIkelAGe7j9QKSOFSunWDnkv9n1W/Cv7ZdDPvy0X1Fk4dzU2bGRG+av1ZRjVENw2F9H8UYXXKd847b7dI5Qps=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9533.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(4143699003)(5023799004)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?s+MzZDT94xIe3hYJxMb5OhTBqGoIeqq48Y5oOWVlzbnPR1FVZ2HgoZqeJj?=
 =?iso-8859-1?Q?GqKihZrJQhTP56LBF+7fn61RsHJrjJH2/56mLTRo0ThFBKDBavhq+funp5?=
 =?iso-8859-1?Q?KtLS0gMMiKFIf9OEW4OsduuvNKyosjsl1OUufQgNIT+2ba1Jc+wPlbGQys?=
 =?iso-8859-1?Q?Ws4Z/0pq+tedvFiAXxxAhbovYbg6B5PkCEJMWIrLA7strkomk4g0d/JO37?=
 =?iso-8859-1?Q?GwqgHidGIf02cFsur4qj8jqWepU+L94z85qQwKts+s4STcnCizMP3tO71A?=
 =?iso-8859-1?Q?RA7dHw+uIkzPjdJue0aImljZnSw7DvqpkHZPmX845N2YOTJlYhNdBjvvDf?=
 =?iso-8859-1?Q?AM1HJGXCWe7zFB6OlFIr6qaxpr/rvO7KBxCLlklBsxwAh9jHq4Np148dfl?=
 =?iso-8859-1?Q?ZPQvAQITFp8yhGvsOEhew1LgYNJksK36V9qckAl3KEPZqMr9EunM+w/v0A?=
 =?iso-8859-1?Q?IgQFCyDuyrXojgNXuUfOOsQcYaezJB6XTDjPIt3LBusTwBong/7LB2e646?=
 =?iso-8859-1?Q?FVKcyNE06khbyMvM4KbSRJe4XrVQBdhhYk7Woex5MiRo4wkMt/RzQvSxfX?=
 =?iso-8859-1?Q?eaCTgGF/RxEBOZeObYb0foLQqwGVQHhqcisFiFO0nA1+932GBVsUQ7WowG?=
 =?iso-8859-1?Q?IjsHILEBGyUuH0XPpj15wTD2rx+nRavsN/KEIm2QVmRNZfwtO+fvxYijtV?=
 =?iso-8859-1?Q?ye2sIqdcnsiI2b0xH+LLi4+lZqECxiu2PUke/Pl53YPZERbe6qjoxEFVY5?=
 =?iso-8859-1?Q?t/rBEjUrtY/Y8Lxof2NLPtBXKvwjQSNpdEnWjIMiCnhRM2EtoAmpGQl8N1?=
 =?iso-8859-1?Q?j6HhTSkPz5a2OXhM2MPKq/FI6R4nN594Maywmnz520m+CR8TXfsYENauex?=
 =?iso-8859-1?Q?mHZrE6uG0YaExBIhUtUwP8OMc/WRYIRyITJSOACrtun/wisV/Bnjl43z5C?=
 =?iso-8859-1?Q?blAPzpblhkvkByRYXmJr6xiJrTGnpfr2RVhoHIxIknu7q88dpSCjuBGEe2?=
 =?iso-8859-1?Q?9gZiwObJhEs4B2EdrcVtFqKwJfb71oH8etIGM1HJu6vp71THA/tP7vxtWM?=
 =?iso-8859-1?Q?cqJSEr07mzA17clGjAVas27zDCHcDVblQ9pYTeVC75giiIy4ytRU5HSoQ9?=
 =?iso-8859-1?Q?g93066IfGdxe+/P2RMXCLTihivCF4mia3Saq+wYtJ3SrgBfgbB0XtvrQIL?=
 =?iso-8859-1?Q?QLzbOo07yVOw1nGPXBGwTr2gZ2J9Ud3W49HtSx2YLhC1IROKycVsD6vka1?=
 =?iso-8859-1?Q?21f0YGsLTiEHjhnF4gLD5QcCwhP4tP+21jDCeoYFVnO/DnqIryClRlg1BC?=
 =?iso-8859-1?Q?PJ7snPYZynr1qu4Rgrj9sI4a5Jqh1qa7euY/K4A4yIbD+ooia/SvVW1V9Q?=
 =?iso-8859-1?Q?0Ey8IVgIz4uBogSS88W4KdjIt4jFBUa40r/XrmI+kCbLeYSh4LR73fOOrd?=
 =?iso-8859-1?Q?5TRqu8aQaBnO396vaVVQnBbVomD/w7+YeXxECqevfeYW6uhtpqWu3j6dRt?=
 =?iso-8859-1?Q?BSxyDmYMb9AZcDhXY03gZMLomfAwXL26ieLb0riVsXRwN6Q+cWo9r7nHME?=
 =?iso-8859-1?Q?VAGd7vb48KmUJuwS4Em73cq4P6+XL9WAja/Bx9nP42/4tVulXW1TfvNpe0?=
 =?iso-8859-1?Q?RqCLLLexJr+Il5EoBUhTG/hfyoLu10DLcbjFNp+onhzX1TaUediRo66cvv?=
 =?iso-8859-1?Q?7b4bY6Q7Pbl+4t6+BUGQhmVT1f5xDXOTFZR4W4HZQbSEuHZVVob66zXwDX?=
 =?iso-8859-1?Q?ZLrQxpqusYPr0oDevzNGldY+o2r63w/X6EsGYTQROiaCPI?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ec509d0d-82f8-4cb7-00b0-08df18cb73b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 17:03:40.8231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bbjSiarTlFKKy2IAa5Ne6WQTzzQDHGmhTVlEGr07A8z3omhkl+AJ9oyIpuo4WBjQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4098

AMD General

Skip my previous message, a formatting issue on my system....

Replied or Forwarded By:
Alex Kovacs
845-625-4422
akovacs@amd.com

-----Original Message-----
From: Kovacs, Alexander
Sent: Tuesday, September 22, 2026 12:03 PM
To: 'Freeman Z' <SHD-ISAC@outlook.com>; Limonciello, Mario <Mario.Limonciel=
lo@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org; linux-usb@vger.kernel.org; bhelgaas@google.c=
om; westeri@kernel.org; andreas.noever@gmail.com; YehezkelShB@gmail.com; ra=
fael@kernel.org; linux-pm@vger.kernel.org; S, Sanath <Sanath.S@amd.com>; Na=
tikar, Basavaraj <Basavaraj.Natikar@amd.com>
Subject: RE: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration

Freeman Z,

I didn't see the complete attached dmesg, only the snippets?

Replied or Forwarded By:
Alex Kovacs
845-625-4422
akovacs@amd.com

-----Original Message-----
From: Freeman Z <SHD-ISAC@outlook.com>
Sent: Tuesday, September 22, 2026 11:41 AM
To: Limonciello, Mario <Mario.Limonciello@amd.com>; Mika Westerberg <mika.w=
esterberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org; linux-usb@vger.kernel.org; bhelgaas@google.c=
om; westeri@kernel.org; andreas.noever@gmail.com; YehezkelShB@gmail.com; ra=
fael@kernel.org; linux-pm@vger.kernel.org; S, Sanath <Sanath.S@amd.com>; Na=
tikar, Basavaraj <Basavaraj.Natikar@amd.com>; Kovacs, Alexander <Alexander.=
Kovacs@amd.com>
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration

[You don't often get email from shd-isac@outlook.com. Learn why this is imp=
ortant at https://aka.ms/LearnAboutSenderIdentification ]

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


Hi Mika, Mario,

I reproduced the failure following the requested sequence on my installed C=
achyOS system with kernel 7.2.6-1-cachyos and thunderbolt.dyndbg=3D+p.

For this trace the dock was physically disconnected at boot. I did not run =
lspci before or during the reproduction.

Before plugging the dock:

    0000:00:04.1
      power/control        =3D auto
      power/runtime_status =3D suspended
      power_state          =3D D3cold

    0000:6b:00.6
      power/control        =3D auto
      power/runtime_status =3D suspended
      power_state          =3D D3cold

After plugging the Kensington SD5000T5 and waiting about 15 seconds:

    0000:00:04.1
      power/control        =3D auto
      power/runtime_status =3D suspended
      power_state          =3D D3cold

    0000:09:00.0
      missing

    0000:6b:00.6
      power/control        =3D auto
      power/runtime_status =3D active
      power_state          =3D D0

The Thunderbolt dynamic debug log shows the NHI/control channel waking and =
the USB4 fabric being configured. In particular:

    thunderbolt 0000:6b:00.6: control channel starting...
    thunderbolt 0000:6b:00.6: 0: resuming switch
    thunderbolt 0000:6b:00.6: 0:2: is connected, link is up (state: 2)
    thunderbolt 0-2: Kensington SD5000T5 EQ Thunderbolt 5 Dock
    thunderbolt 0000:6b:00.6: 0:5 <-> 2:9 (PCI): activating
    thunderbolt 0000:6b:00.6: PCIe Down path activation complete
    thunderbolt 0000:6b:00.6: PCIe Up path activation complete

However, I do not see a PME message corresponding to the dock insertion.
The PME messages in the full dmesg are the early-boot
"PME: Signaling with IRQ ..." initialization messages.

So in this reproduction, the NHI at 0000:6b:00.6 wakes from D3cold to D0 an=
d the Thunderbolt driver successfully programs the PCIe tunnel in the
USB4 fabric, but the AMD 1022:14ef PCIe root port/tunnel at 0000:00:04.1 re=
mains in D3cold and the downstream 0000:09:00.0 hierarchy never appears.

I attached the full dmesg captured after the dock plug, plus the small befo=
re/after state files. I redacted only unrelated local network identifiers, =
the hostname, and filesystem/LUKS UUIDs; the Thunderbolt debug data and dev=
ice UIDs are otherwise unchanged.

This particular dynamic-debug trace was collected on CachyOS rather than th=
e Arch stock kernel used for my earlier reproduction.

Thanks,
Freeman

________________________________________
From: Mario Limonciello <mario.limonciello@amd.com>
Sent: Monday, September 21, 2026 23:24
To: Mika Westerberg <mika.westerberg@linux.intel.com>; Freeman Z <SHD-ISAC@=
outlook.com>
Cc: linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>; linux-usb@vger.k=
ernel.org <linux-usb@vger.kernel.org>; bhelgaas@google.com <bhelgaas@google=
.com>; westeri@kernel.org <westeri@kernel.org>; andreas.noever@gmail.com <a=
ndreas.noever@gmail.com>; YehezkelShB@gmail.com <yehezkelshb@gmail.com>; ra=
fael@kernel.org <rafael@kernel.org>; linux-pm@vger.kernel.org <linux-pm@vge=
r.kernel.org>; Sanath S <Sanath.S@amd.com>; Basavaraj Natikar <Basavaraj.Na=
tikar@amd.com>; Kovacs, Alexander <Alexander.Kovacs@amd.com>
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration

+Alex K

On 9/21/26 00:04, Mika Westerberg wrote:
> Hi,
>
> Adding AMD folks in case this is known issue.
>
> On Sat, Sep 19, 2026 at 12:39:37PM +0000, Freeman Z wrote:
>> Hello,
>>
>> I am seeing a reproducible USB4/PCIe runtime-PM problem on an ASUS
>> ROG Flow X13 GV302XV (Ryzen 9 7940HS / Phoenix) with a Kensington
>> SD5000T5 EQ Thunderbolt 5 dock connected to the laptop's USB4 host port.
>>
>> The failure is reproducible with the official Arch Linux Live ISO
>> using Arch's stock `linux` kernel:
>>
>>      7.2.2-arch1-1
>>
>> I have not yet tested a self-built kernel.org mainline/vanilla kernel.
>> I can test patches, or collect additional traces if requested.
>
> Can you provide full dmesg with "thunderbolt.dyndbg=3D+p" in the kernel
> command line?
>
> With the below steps (following your description):
>
> 0. Drop all non-standard command line options except the above.
> 1. Boot the system up, nothing connected.
> 2. Once up let the TB and the related PCIe root ports enter D3cold
>(don't
>     run lspci it will wake them up but you can look at the runtime
>status that
>     they are all suspended).
> 3. Plug in the dock.
>
> We should see in the dmesg the PME if it works as expected. If not
> then it may be that there is something wrong with the wakeup path.

There was something like this that was reported in the past, but it was a r=
ace condition of some sort.  It ended up being fixed by a non-obvious optim=
ization (I forget the specific commit).

But it was definitely older than 7.2, so it sounds like it might have regre=
ssed again.
