Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010051.outbound.protection.outlook.com [40.93.198.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ED63563EB;
	Fri, 25 Sep 2026 14:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790344999; cv=fail; b=AbhLCtLxP5OZvotSYVaDq55dmrbJWL64EMLAGzHHHvT2Dn7QYXqH9KqcOcKE45IIKMBlwxg1nE8tZ67/ZLWM7AiWCtuc3t04Maiikm/E6KNlHuxPiyFwiBgXM1X34zckBuzdqIrWA43IdQaoiEbjVzDAw2vpvJaMoO38XDmVosI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790344999; c=relaxed/simple;
	bh=YkE9wiq/D2ZyDYRfkTxcSP4rv5SYgZ1v9cMFO8I/R1M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TOqYFUdw4wPS2+Hdnyno6hFc+nTZScufPAErKIWEusGUpDEksnbAcRYmyg0eo0HNOpuiib/lRZyMuaiOIwhEgBi1jocPq+1b7xYluxJ2Vv83pH8UPl/xvF/xjYvJ9/LE0QFOM7a8CDgetmfEEfTNXOARCzG6MoMHKIy0nYe+Yr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1xdupHXm; arc=fail smtp.client-ip=40.93.198.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1xdupHXm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m3WnV9nX5PGPUPNElGG+Dr+rmwetaTnhq/vwOio0YFk1OefPrJdwE+iJER1c1cATFIExgnx9c7fWYikX+4BjAml4p6A0ew2MhjEllDiCRw+CzTX3fbcfrmZRoWNTHYCmMC5EtO/wuqQ2DOmYyeWEQTghls6QYVyyI8sPfzrhYGFMBPy7WBRrPHsdyh0WxcgJ6yZiZ095J7/Jr2P0OmdYqmdggl/GGM/U59mc8FknC8wmmCHTgrmBiqcWN3NGDDDIqL50rcjqEGAODZ0aAaRPZIqg5ldQAB8/WSbMPa6pr4pxWlgCFF442yIjqfo33WJfYBdZDcBAB8uatY61gDj0uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHIAzm6DQRE3gJ8QqC7ERKzeLU/G6JlpMMMNrPsI9ss=;
 b=NRatwqRF/LYY/tr9EohaYK4DSxkD7bnyVAVQXyRnEDzCSRDdX8l9ZDf+7Rg5YvVz0Rb1jc2q91wdKeZrVTKHyU1whcGa+87sqm7FfkUwoveHrZMbyML3P27WRhk36IGfrsxMUYmG7qeC7cXVg40uBUMJYTeBVDq1oWFxPYGOU5zEq0/W6m6Lf38C6zBEKw51pCD4XudIHP0nZzLjdC5CtUrAykbvSJt45QGpNsqSqhFykCspWAlf6jPYbVE0/hLlDGXQ5nsInZo7916jCXDLrNH3NEeMK6v5/YB4PMdTL7N/uOn8zrIxqelYi5C+sbIkF9miprvuHMoHhdB6Zya5pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHIAzm6DQRE3gJ8QqC7ERKzeLU/G6JlpMMMNrPsI9ss=;
 b=1xdupHXmv4ySdcwMwJvVbVKEQOsbPGqUxzVs3a72DZygF9k9nLvYD2KmheS7SaX1gpW1wklIN2ie0Bj0Df0rRpsHGKcBomX1OyjjEtSqRf8x5viaIDQ9uD7eQOSfKDQRHZjpP97HJABNUVstIGfwXKkTxTet+wLlnfSVBgUz6O0=
Received: from BL4PR12MB9533.namprd12.prod.outlook.com (2603:10b6:208:58f::21)
 by SA3PR12MB9108.namprd12.prod.outlook.com (2603:10b6:806:37d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Fri, 25 Sep
 2026 14:03:12 +0000
Received: from BL4PR12MB9533.namprd12.prod.outlook.com
 ([fe80::d6cc:9c7e:12b9:a418]) by BL4PR12MB9533.namprd12.prod.outlook.com
 ([fe80::d6cc:9c7e:12b9:a418%6]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 14:03:11 +0000
From: "Kovacs, Alexander" <Alexander.Kovacs@amd.com>
To: Freeman Z <SHD-ISAC@outlook.com>, Mika Westerberg
	<mika.westerberg@linux.intel.com>
CC: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "westeri@kernel.org"
	<westeri@kernel.org>, "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
	"YehezkelShB@gmail.com" <yehezkelshb@gmail.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"S, Sanath" <Sanath.S@amd.com>, "Natikar, Basavaraj"
	<Basavaraj.Natikar@amd.com>, "Martinez, Juan" <Juan.Martinez@amd.com>
Subject: RE: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents
 JHL9480 downstream enumeration
Thread-Topic: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents
 JHL9480 downstream enumeration
Thread-Index:
 AQHdSd1c593zF2yuc0efXEtk9KFFoLbazowAgAA18BCAAAG7AIABCdYAgACB41CAAMQiAIABc02AgABGIACAAB+1gIAAHW6w
Date: Fri, 25 Sep 2026 14:03:11 +0000
Message-ID:
 <BL4PR12MB95337F4EC54FA89D3600C92E9C802@BL4PR12MB9533.namprd12.prod.outlook.com>
References:
 <TYCPR01MB1092795BE7AB51121BBAB292496862@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <20260921050450.GM106095@black.igk.intel.com>
 <f8b929da-b4ae-48ae-9667-3eb93aa0a4bd@amd.com>
 <TYCPR01MB10927E6DC71CDC3B39C26F35196832@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <BL4PR12MB9533BF5ABF7035E6DF151C0A9C832@BL4PR12MB9533.namprd12.prod.outlook.com>
 <eaaf891b-7b0b-4eea-b104-de2c0db7cb42@amd.com>
 <TYCPR01MB1092762E3E179C4A43874BBE696822@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <DS7PR12MB9550558C737D92A5762C3AAC9C822@DS7PR12MB9550.namprd12.prod.outlook.com>
 <TYCPR01MB109271EBFCFBEA8A8855D600496812@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <20260925052727.GV106095@black.igk.intel.com>
 <TYCPR01MB10927DEE310195FA62C67E9D296802@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <TYCPR01MB1092798A529672215ACC586BA96802@TYCPR01MB10927.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TYCPR01MB1092798A529672215ACC586BA96802@TYCPR01MB10927.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-25T13:17:14.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL4PR12MB9533:EE_|SA3PR12MB9108:EE_
x-ms-office365-filtering-correlation-id: e183803d-6d4a-4795-cb44-08df1b0dbc5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|23010399003|260925021311599003|260925021911599003|38070700021|18096099006|3023799007|6133799003|10067099003|56012099006|4143699003|5023799004|11063799006|18002099003|22082099003|260925022911599003|20046099003;
x-microsoft-antispam-message-info:
 idFTgM3raz2bh3Kgbs/HeJrTHGkY0iuDwsMgtiYFLJtRmznGy5cDbn4KrU+fvTnxiqQscrEEC5DPPcrYpAWmR7rgLChgSndRKOS8cegavI8GB4PvchIxd0prJsAqj/Ks5dYqnq+dIPgvXHCdCS23SeixhJ2lRMFSIp4jn/BL+Suc1/AMTHstT7h+C/fjw5Kru5iv0+lMK7JcZykNgL0EESS6NarzFCbYH/HWqWsedQ71droKoRm23GZvDNHHZ5CpXJLafCVNRJ46iERLlQ0eBMHee98DLjweMjTSAWbYsvLh/Y01R/i/2ZWGBfqgWaUrrx8UiIJ3K7FZR4KHvjspsAGqzYPwdnRrcpOniOYM+p+wWazXYqEELhvnj2dI3or9TsydAKx22JlNXCecWE2SvCy4bvZRPMeg+oVitEQHXqvU50JaTNFmA5g9SqcSww3qHKc3MKfubsjeFoeetdpV545dZ0vdUSzOcmC5Xr1dxMjFLfHUH1i1ONmhap1r6NYQyzwE1q6p8KDxKUJYIxgIqgUv0mfAyzXgdOEJPamkJYGOUT3VYZUITewZ4CE7T/FBFH+E7QCoSEax4IkR/C9s7SM/PJwVxgwpSnk30fn9Ul/MxesZmt7bJtC0Y0NAvPIliUllifHDQhAo9MvDkr/LmuPNUgvfPzCE+RPAFTGK2Nk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9533.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(23010399003)(260925021311599003)(260925021911599003)(38070700021)(18096099006)(3023799007)(6133799003)(10067099003)(56012099006)(4143699003)(5023799004)(11063799006)(18002099003)(22082099003)(260925022911599003)(20046099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?zjz5Sk2cYGEr5b7hTJyxIpZrOAWPzMLhYsdRhlJyg9LPPhYU4U9vIAKL8i?=
 =?iso-8859-1?Q?ZuDZ16D16cYwroAF9ldOMGcm4byJQioQTjP2Ods3mXfzqVfoRzT7wjq8oC?=
 =?iso-8859-1?Q?DYyxunuPBhH6iMfQbHvd6p0ebAhvgLceKBSpObKfWKEbtAt2TQ0gMpcnY1?=
 =?iso-8859-1?Q?2ifFhzG6nrlALjG5LWGbiCIYZczD6nG5M/YWO5DjjeCwbhP8sJmUo37YPp?=
 =?iso-8859-1?Q?1iEcSUDlD6mOQriutmz6X+KQTNn1qukoenKufozHnkJJdWs0PYFZ4NdiE+?=
 =?iso-8859-1?Q?WIjs4N6q/pO1eKV/Q9xmTH8qY/E88gXqjmYM2COwBUGlec1Dx2tA6fNP1/?=
 =?iso-8859-1?Q?rg97PJrnSlpN2ESodGghkLrVIKtGbfohyCunKRnZ2KTT0roS1oOYWzlZFw?=
 =?iso-8859-1?Q?YpK2JcVtj1fBWc+9XI1cFGyp2xE52CEpOT+KvNSCwyfLodvhDnzzYMrwz7?=
 =?iso-8859-1?Q?rg/sO6tGlFdeTP5vvKMFuQd7piunpKGE8JXWyYM1akTiXQKXwxk421ldcv?=
 =?iso-8859-1?Q?12Ur14tA6MQy13QusdfZ5+fBKzv0KaBNHnpx3Rsrx2qGbwIh5N+kQvy2Nd?=
 =?iso-8859-1?Q?zwAwN3kbxhwtDZ59rmM4cr6c6RM5YHgtHRov1YzwQaw6m0hmrfgl8ld6xf?=
 =?iso-8859-1?Q?VxIpk8BH7xvHCrTXrW6i997JTts2MJvgoB0HuVTb7O/65kqPXiGnjUtpLa?=
 =?iso-8859-1?Q?mWOoAV3MrZPG7m924PdHDRMz2gNNWPlSkrqJ+r7roSO65XcthWmkJqnqWd?=
 =?iso-8859-1?Q?uoEZyKiJ1e1uG4U68srY1WBFxkRBBMjKxSuvoUo4jBS56Wc0ES7dEM8/Oi?=
 =?iso-8859-1?Q?8yKLs5aPRhsasy0ou1eEZSFRSQ6WBdNKIghz9MvHLYQP7xxEm1Sh5oYwMM?=
 =?iso-8859-1?Q?3OIfwk1S91qGdRIu3xAGEDxM9RYXzH16v9vpPcJb4NdNBZhxk8wUE640fU?=
 =?iso-8859-1?Q?eMNSbXTifLTUvYRl82GvCw+f8affuiSdFAELaXRtBpuH9K/F6Qb8wDj3Jb?=
 =?iso-8859-1?Q?3iNgHvQ5JQw9KV+vnOnth4Bz85rdnG+f/re7IIPS6RSKeCUqkuILpR8swR?=
 =?iso-8859-1?Q?mw7olg2Sr6jt9d+Hp0BeVnzECESe2C6SQ67HObYbURuanaLb3oQcCznPSx?=
 =?iso-8859-1?Q?gZlzvYuXrcJbr7sc+iZZWYXZUQbB4Lfo5hZ8EPzpniC7xn20h/qo5DXLIH?=
 =?iso-8859-1?Q?0Fz8s9hIaLQ6frx827SjcXeagbBA4mfxpLhtmlkfWjHoAnK7tZYRbUg9sz?=
 =?iso-8859-1?Q?Kg35J152om/MVvp93ldY8hLkdxMujLArrLcwez8a7ceIl5YoGLVe2AsMMH?=
 =?iso-8859-1?Q?s5alSFf8hoMF9LbsT3ZfphJneXCHRJDyLMQjapNjD5v9UCy5TFZH6A48U2?=
 =?iso-8859-1?Q?mwMbdcfo6q0+0PzJfRsa+gxqHEE2BhGvcnT52ueSa1aSxSuL+hol9e3cXk?=
 =?iso-8859-1?Q?GQQFg4dL6qUANHoBpoKkxbUDUk/fziq0bZ/EWgEP4vtdeRDPLfcrB+ZeOn?=
 =?iso-8859-1?Q?g9hAtZn7KQomkr6XgbN/3AWOImgQ9U4DV4u0vPT3WqzSMDWp+F3PHVyJqf?=
 =?iso-8859-1?Q?BezpKqeRhoLwzmGMZwDdjTx6LbZcfKkU4ap7AR0GxQ27XTWQADyshoX4va?=
 =?iso-8859-1?Q?UF5wN+YG69uCQOpqm7pxXPntuZ02Pweoic85zuXswr/pv7ZHUOqpkbtyrZ?=
 =?iso-8859-1?Q?1OJx8Gy7a5ddOwsg6BbjmqU5twvxRPp4uBbMIhEAQ7lFSsoSapzhn1mqDD?=
 =?iso-8859-1?Q?DQ+IPBZecnwxFgXxvUo9tVYGjcla1z5mBuA6T86EikuyLF?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e183803d-6d4a-4795-cb44-08df1b0dbc5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2026 14:03:11.8595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u2MLoYiR5qmF46M3Wx01/FvpHWeImOhzTTwmAyz+d+jE0mWLzL1n87QlW4O6QIb/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9108

AMD General

Freeman, et al.,

So far, I have been unable to repro this on 2 of our customer reference boa=
rds. I am using Ubuntu 26.04 and I have tried 7.0.0 and 7.2.2 generic kerne=
ls and 7.3-rc1 mainline kernel. Also, I have back leveled the BIOS AGESA to=
 what is reported in Freeman's logs. I am using a TB 5 (Startech brand) doc=
k with a generic monitor plugged into the HDMI port and an OWC TB 4 hub plu=
gged into a TB (usb-c) port on the dock. I have tried plugging into the com=
puter management and a different port on the dock with the OWC hub.
If I boot without the dock and wait until I see the PCI Bridge "suspended" =
the dock and hub are both enumerated.
If I boot with the dock, both it and the hub are enumerated correctly.
If I then unplug the dock and wait for the PCI Bridge to suspend, then re-p=
lug, both the dock and hub are enumerated correctly.

Any suggestions to help replicate.


Replied or Forwarded By:
Alex Kovacs
845-625-4422
akovacs@amd.com

-----Original Message-----
From: Freeman Z <SHD-ISAC@outlook.com>
Sent: Friday, September 25, 2026 6:32 AM
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Kovacs, Alexander <Alexander.Kovacs@amd.com>; Limonciello, Mario <Mario=
.Limonciello@amd.com>; linux-pci@vger.kernel.org; linux-usb@vger.kernel.org=
; bhelgaas@google.com; westeri@kernel.org; andreas.noever@gmail.com; Yehezk=
elShB@gmail.com; rafael@kernel.org; linux-pm@vger.kernel.org; S, Sanath <Sa=
nath.S@amd.com>; Natikar, Basavaraj <Basavaraj.Natikar@amd.com>; Martinez, =
Juan <Juan.Martinez@amd.com>
Subject: RE: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


Hi Mika, Alex and Mario,

I tested v7.3-rc4 with the following Ubuntu SAUCE patch from Chia-Lin Kao (=
AceLan) at Canonical:

    thunderbolt: Fix PCIe device enumeration with delayed rescan

Ubuntu SRU posting:
    https://lists.ubuntu.com/archives/kernel-team/2026-April/166926.html

Launchpad:
    https://bugs.launchpad.net/bugs/2139572

The Ubuntu posting says this was cherry-picked from the corresponding upstr=
eam submission:

    https://lore.kernel.org/lkml/20260121060857.237777-1-acelan.kao@canonic=
al.com/T/#u

The patch schedules a delayed pci_rescan_bus() 300 ms after the Thunderbolt=
 PCIe tunnel has been activated, to recover devices that pciehp did not enu=
merate.

The patch as posted was written against an older Thunderbolt NHI API and re=
fers to:

    tb->nhi->pdev

In v7.3-rc4, struct tb_nhi instead contains struct device *dev.
I therefore made only the API adaptation needed to build the same logic on =
v7.3-rc4:

    if (tb->nhi && tb->nhi->dev && dev_is_pci(tb->nhi->dev)) {
        struct pci_dev *pdev =3D to_pci_dev(tb->nhi->dev);
        struct pci_bus *bus =3D pdev->bus;

The delayed-rescan behavior itself is otherwise unchanged, including the 30=
0 ms delay and pci_rescan_bus() call.

With this patched v7.3-rc4 kernel, the same hotplug test succeeds.
I did not run lspci before checking the result.

So the current A/B result, using the same v7.3-rc4 base and test procedure,=
 is:

    Linus v7.3-rc4
        -> hotplug fails

    Linus v7.3-rc4 + the above Ubuntu delayed-rescan patch
        (with only the v7.3 NHI API adaptation described above)
        -> hotplug succeeds

This may also explain why the Ubuntu 26.04.1 7.0-based kernel worked in my =
earlier test while both Linus v7.0 and stable 7.0.12 fail.

The delayed rescan may simply recover enumeration after the PCIe tunnel has=
 been established even though the normal pciehp/wake path did not complete =
as expected.

I can collect a full dynamic-debug/state trace from the patched
v7.3-rc4 kernel as well if that would be useful.

Thanks,
Freeman
________________________________________
From: Freeman Z <SHD-ISAC@outlook.com>
Sent: Friday, 25 September 2026 09:38:26
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Kovacs, Alexander <Alexander.Kovacs@amd.com>; Limonciello, Mario <Mario=
.Limonciello@amd.com>; linux-pci@vger.kernel.org <linux-pci@vger.kernel.org=
>; linux-usb@vger.kernel.org <linux-usb@vger.kernel.org>; bhelgaas@google.c=
om <bhelgaas@google.com>; westeri@kernel.org <westeri@kernel.org>; andreas.=
noever@gmail.com <andreas.noever@gmail.com>; YehezkelShB@gmail.com <yehezke=
lshb@gmail.com>; rafael@kernel.org <rafael@kernel.org>; linux-pm@vger.kerne=
l.org <linux-pm@vger.kernel.org>; S, Sanath <Sanath.S@amd.com>; Natikar, Ba=
savaraj <Basavaraj.Natikar@amd.com>; Martinez, Juan <Juan.Martinez@amd.com>
Subject: RE: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration

Hi Mika, Alex and Mario,

I tested both requested points from Linus' mainline tree using the same rep=
roduction procedure.

v7.3.0-rc4: bad
v7.0.0:     bad

For both tests, the dock was disconnected at boot. I hot-plugged the dock w=
ithout running lspci after boot.

In both cases, after hotplug:

    0000:00:04.1 remained suspended / D3cold
    0000:6b:00.6 resumed to active / D0
    0000:09:00.0 was missing

Thanks,
Freeman
________________________________________
From: Mika Westerberg <mika.westerberg@linux.intel.com>
Sent: Friday, 25 September 2026 05:27:27
To: Freeman Z <SHD-ISAC@outlook.com>
Cc: Kovacs, Alexander <Alexander.Kovacs@amd.com>; Limonciello, Mario <Mario=
.Limonciello@amd.com>; linux-pci@vger.kernel.org <linux-pci@vger.kernel.org=
>; linux-usb@vger.kernel.org <linux-usb@vger.kernel.org>; bhelgaas@google.c=
om <bhelgaas@google.com>; westeri@kernel.org <westeri@kernel.org>; andreas.=
noever@gmail.com <andreas.noever@gmail.com>; YehezkelShB@gmail.com <yehezke=
lshb@gmail.com>; rafael@kernel.org <rafael@kernel.org>; linux-pm@vger.kerne=
l.org <linux-pm@vger.kernel.org>; S, Sanath <Sanath.S@amd.com>; Natikar, Ba=
savaraj <Basavaraj.Natikar@amd.com>; Martinez, Juan <Juan.Martinez@amd.com>
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration

Hi,

I wonder if you could try the vanilla mainline kernel (not the stable trees=
), this one:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/

Take for example v7.3-rc4 and see if the problem happens. If it does, take =
say v7.0 or whatever is the closest the stable tree that has it working and=
 see if that works. If that works then we have the two points needed to bis=
ect the issue on the mainlne.

On Thu, Sep 24, 2026 at 07:18:30AM +0000, Freeman Z wrote:
> Hi Alex, Mario and Mika,
>
> Yes. I have now tested self-built vanilla kernel.org Linux 7.0.12 and
> 7.2.6 on the same machine, with thunderbolt.dyndbg=3D+p.
>
> The external monitor is connected through the Kensington SD5000T5
> dock.
>
> For both vanilla 7.0.12 and 7.2.6, I see the following behavior:
>
>   - Cold or warm boot with the dock already attached:
>     enumeration works normally in my tests.
>
>   - Boot/reboot with the dock disconnected, wait until
>     0000:00:04.1 and 0000:6b:00.6 are runtime-suspended in D3cold,
>     then hot-plug the dock:
>     the failure reproduces before running lspci.
>
> In the failing runs on both vanilla kernels:
>
> Before hotplug:
>
>     0000:00:04.1
>       power/control        =3D auto
>       power/runtime_status =3D suspended
>       power_state          =3D D3cold
>
>     0000:6b:00.6
>       power/control        =3D auto
>       power/runtime_status =3D suspended
>       power_state          =3D D3cold
>
> After hotplug, before lspci:
>
>     0000:00:04.1
>       power/control        =3D auto
>       power/runtime_status =3D suspended
>       power_state          =3D D3cold
>
>     0000:6b:00.6
>       power/control        =3D auto
>       power/runtime_status =3D active
>       power_state          =3D D0
>
>     0000:09:00.0
>       missing
>
> Thunderbolt dynamic debug reports both:
>
>     PCIe Down path activation complete
>     PCIe Up path activation complete
>
> Only after running:
>
>     lspci >/dev/null
>
> does the root port wake and PCIe hotplug proceed. I then see:
>
>     0000:00:04.1
>       power/runtime_status =3D active
>       power_state          =3D D0
>
>     pcieport 0000:00:04.1: pciehp: Slot(0-1): Card present
>     pcieport 0000:00:04.1: pciehp: Slot(0-1): Link Up
>
>     0000:09:00.0
>       present
>
> This does not appear to be a 7.0 -> 7.2 upstream regression:
> vanilla 7.0.12 and vanilla 7.2.6 show the same D3cold/hotplug failure.
>
> The Ubuntu 26.04.1's 7.0-based 7.0.0-30-generic kernel successfully
> enumerated the same hotplug in my previous test, whereas vanilla
> upstream 7.0.12 does not.
>
> There is one additional difference in my testing:
>
>   - Vanilla 7.0.12 / 7.2.6:
>     dock already attached at boot -> works so far.
>
>   - CachyOS 7.2.6:
>     I have also reproduced the failure with the dock already attached
>     at boot.
>
> The D3cold hotplug failure is reproducible on vanilla upstream, while
> CachyOS may have an additional boot-time difference on top of that.
>
> Regarding the display, it is connected through the dock. Both vanilla
> 7.0.12 and 7.2.6 also log DP DPRX read timeout(s), followed by
> successful capability reads during dock setup.
>
> I attached a sanitized archive containing the complete before-hotplug,
> after-hotplug-before-lspci, and after-lspci dmesg/state captures for
> both vanilla kernels.
>
> Thanks,
> Freeman
> ________________________________________
> From: Kovacs, Alexander <Alexander.Kovacs@amd.com>
> Sent: Wednesday, 23 September 2026 19:37:13
> To: Freeman Z <SHD-ISAC@outlook.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Mika Westerberg
> <mika.westerberg@linux.intel.com>
> Cc: linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>;
> linux-usb@vger.kernel.org <linux-usb@vger.kernel.org>;
> bhelgaas@google.com <bhelgaas@google.com>; westeri@kernel.org
> <westeri@kernel.org>; andreas.noever@gmail.com
> <andreas.noever@gmail.com>; YehezkelShB@gmail.com
> <yehezkelshb@gmail.com>; rafael@kernel.org <rafael@kernel.org>;
> linux-pm@vger.kernel.org <linux-pm@vger.kernel.org>; S, Sanath
> <Sanath.S@amd.com>; Natikar, Basavaraj <Basavaraj.Natikar@amd.com>;
> Martinez, Juan <Juan.Martinez@amd.com>
> Subject: RE: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend
> prevents JHL9480 downstream enumeration
>
> AMD General
>
> Also, is the external monitor hooked directly to the system or through th=
e dock?
>
> Replied or Forwarded By:
> Alex Kovacs
> 845-625-4422
> akovacs@amd.com
>
> -----Original Message-----
> From: Freeman Z <SHD-ISAC@outlook.com>
> Sent: Wednesday, September 23, 2026 6:52 AM
> To: Limonciello, Mario <Mario.Limonciello@amd.com>; Kovacs, Alexander
> <Alexander.Kovacs@amd.com>; Mika Westerberg
> <mika.westerberg@linux.intel.com>
> Cc: linux-pci@vger.kernel.org; linux-usb@vger.kernel.org;
> bhelgaas@google.com; westeri@kernel.org; andreas.noever@gmail.com;
> YehezkelShB@gmail.com; rafael@kernel.org; linux-pm@vger.kernel.org; S,
> Sanath <Sanath.S@amd.com>; Natikar, Basavaraj
> <Basavaraj.Natikar@amd.com>; Martinez, Juan <Juan.Martinez@amd.com>
> Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend
> prevents JHL9480 downstream enumeration
>
> Caution: This message originated from an External Source. Use proper caut=
ion when opening attachments, clicking links, or responding.
>
>
> Hi Mario, Mika and Alex,
>
> I tested the Kensington SD5000T5 dock again by using Ubuntu 26.04.1 Live =
with kernel 7.0.0-30-generic and thunderbolt.dyndbg=3D+p. The dock was disc=
onnected at boot, and I did not run lspci before the hotplug log and power =
states had been saved.
>
> In this Ubuntu run the PCIe/USB enumeration worked without any workaround=
:
>
>  426.716: USB4 dock connection detected (host port 0:2, link up)
>  426.753: Kensington SD5000T5 discovered
>  428.410: PCIe Down path activation complete
>  428.411: PCIe Up path activation complete
>  429.025: pcieport 0000:00:04.1 reports Card present / Link Up
>  429.026: downstream 0000:09:00.0 (8086:5786) enumerated
>
> After the dock had connected, but *before* running lspci, the sysfs state=
s were:
>
>  0000:00:04.1  power/control=3Dauto; runtime_status=3Dactive;
> power_state=3DD0
>  0000:09:00.0  present
>  0000:6b:00.6  runtime_status=3Dactive; power_state=3DD0
>
> The downstream USB devices and dock Ethernet also enumerated. I then ran =
lspci once: 0000:00:04.1 remained active/D0, 0000:09:00.0 remained present.=
 Thus this run cannot show an lspci-triggered wakeup or a resulting PME eve=
nt: it was already working.
> In my previous failing CachyOS runs, invoking lspci could wake 00:04.1 an=
d make 09:00.0 appear. I do not see an explicit PME delivery message at hot=
plug in the Ubuntu dmesg.
>
> The external display did still flicker. The Ubuntu log includes one DP tu=
nnel DPRX read timeout at ~431.188s, followed by a completed capability rea=
d at ~431.239s, I do not know if it's related.
>
> Attached are the full Ubuntu dmesg after/before hotplug and the state fil=
es.
> Unrelated USB serial numbers and network interface MAC addresses are reda=
cted.
>
> Thanks,
> Freeman
>
> ________________________________________
> From: Mario Limonciello <mario.limonciello@amd.com>
> Sent: Wednesday, September 23, 2026 4:00
> To: Kovacs, Alexander <Alexander.Kovacs@amd.com>; Freeman Z
> <SHD-ISAC@outlook.com>; Mika Westerberg
> <mika.westerberg@linux.intel.com>
> Cc: linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>;
> linux-usb@vger.kernel.org <linux-usb@vger.kernel.org>;
> bhelgaas@google.com <bhelgaas@google.com>; westeri@kernel.org
> <westeri@kernel.org>; andreas.noever@gmail.com
> <andreas.noever@gmail.com>; YehezkelShB@gmail.com
> <yehezkelshb@gmail.com>; rafael@kernel.org <rafael@kernel.org>;
> linux-pm@vger.kernel.org <linux-pm@vger.kernel.org>; S, Sanath
> <Sanath.S@amd.com>; Natikar, Basavaraj <Basavaraj.Natikar@amd.com>;
> Martinez, Juan <Juan.Martinez@amd.com>
> Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend
> prevents JHL9480 downstream enumeration
>
> > -----Original Message-----
> > From: Freeman Z <SHD-ISAC@outlook.com>
> > Sent: Tuesday, September 22, 2026 11:41 AM
> > To: Limonciello, Mario <Mario.Limonciello@amd.com>; Mika Westerberg
> > <mika.westerberg@linux.intel.com>
> > Cc: linux-pci@vger.kernel.org; linux-usb@vger.kernel.org;
> > bhelgaas@google.com; westeri@kernel.org; andreas.noever@gmail.com;
> > YehezkelShB@gmail.com; rafael@kernel.org; linux-pm@vger.kernel.org;
> > S, Sanath <Sanath.S@amd.com>; Natikar, Basavaraj
> > <Basavaraj.Natikar@amd.com>; Kovacs, Alexander
> > <Alexander.Kovacs@amd.com>
> > Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend
> > prevents JHL9480 downstream enumeration
> >
> > [You don't often get email from shd-isac@outlook.com. Learn why this
> > is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > Caution: This message originated from an External Source. Use proper ca=
ution when opening attachments, clicking links, or responding.
> >
> >
> > Hi Mika, Mario,
> >
> > I reproduced the failure following the requested sequence on my install=
ed CachyOS system with kernel 7.2.6-1-cachyos and thunderbolt.dyndbg=3D+p.
> >
> > For this trace the dock was physically disconnected at boot. I did not =
run lspci before or during the reproduction.
> >
> > Before plugging the dock:
> >
> >      0000:00:04.1
> >        power/control        =3D auto
> >        power/runtime_status =3D suspended
> >        power_state          =3D D3cold
> >
> >      0000:6b:00.6
> >        power/control        =3D auto
> >        power/runtime_status =3D suspended
> >        power_state          =3D D3cold
> >
> > After plugging the Kensington SD5000T5 and waiting about 15 seconds:
> >
> >      0000:00:04.1
> >        power/control        =3D auto
> >        power/runtime_status =3D suspended
> >        power_state          =3D D3cold
> >
> >      0000:09:00.0
> >        missing
> >
> >      0000:6b:00.6
> >        power/control        =3D auto
> >        power/runtime_status =3D active
> >        power_state          =3D D0
> >
> > The Thunderbolt dynamic debug log shows the NHI/control channel waking =
and the USB4 fabric being configured. In particular:
> >
> >      thunderbolt 0000:6b:00.6: control channel starting...
> >      thunderbolt 0000:6b:00.6: 0: resuming switch
> >      thunderbolt 0000:6b:00.6: 0:2: is connected, link is up (state:
> >2)
> >      thunderbolt 0-2: Kensington SD5000T5 EQ Thunderbolt 5 Dock
> >      thunderbolt 0000:6b:00.6: 0:5 <-> 2:9 (PCI): activating
> >      thunderbolt 0000:6b:00.6: PCIe Down path activation complete
> >      thunderbolt 0000:6b:00.6: PCIe Up path activation complete
> >
> > However, I do not see a PME message corresponding to the dock insertion=
.
> > The PME messages in the full dmesg are the early-boot
> > "PME: Signaling with IRQ ..." initialization messages.
> >
> > So in this reproduction, the NHI at 0000:6b:00.6 wakes from D3cold
> > to
> > D0 and the Thunderbolt driver successfully programs the PCIe tunnel
> > in the
> > USB4 fabric, but the AMD 1022:14ef PCIe root port/tunnel at 0000:00:04.=
1 remains in D3cold and the downstream 0000:09:00.0 hierarchy never appears=
.
> >
> > I attached the full dmesg captured after the dock plug, plus the small =
before/after state files. I redacted only unrelated local network identifie=
rs, the hostname, and filesystem/LUKS UUIDs; the Thunderbolt debug data and=
 device UIDs are otherwise unchanged.
> >
> > This particular dynamic-debug trace was collected on CachyOS rather tha=
n the Arch stock kernel used for my earlier reproduction.
> >
> It sure sounds like a PME doesn't deliver properly for some reason.
>
> I suppose that while in this state - if you ran lspci the root port at
> 0000:00:04.1 exits D3cold and 0000:09:00.0 shows up, right?
>
> Does the PME show up in the logs after you've done this?
>
> Any chance you can easily check Ubuntu 26.04.1 live media?  There is a
> 7.0 based kernel there, and I would like to know if this regressed from t=
hat.
