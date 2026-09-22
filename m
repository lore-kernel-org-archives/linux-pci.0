Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010000.outbound.protection.outlook.com [52.101.193.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA46B45D5E7;
	Tue, 22 Sep 2026 19:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106870; cv=fail; b=Y9QdG4FmiRCpImA/pHdqvBOuwUYDmsRH/MZ0zgFhm9O/wXctIFVCQudzn/DmNDA2E/rYy9Lq14pd92fu79TFHGrEsA1RCLFv0y8spKQ0QMKywA4Yf2XrTiiOD1TQWRfo635Q5u2PA7mCSsVOyPtvJqdZMsjBKBN1fTT+qwbBLsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106870; c=relaxed/simple;
	bh=DntOTyiehTYLE/ecSj68RfJvncCmRDLPsD8e/ZTDRs8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QuUWVKHRUFsuN1PNRjM5prZTdVxwPHvXNbsR5asGv/A1Ei2UgXYXPGCJ0+a/c7zNYaLyuzRihElbQpGb4LbuVYWPhjp2w89W5/Voocv7E9/NKn0dXkuw04QcKPAd9WQzsD+/zBKWI5yNa+NAAWqQ4h0T9TvrwiD2ymiT4PD7XOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TQuftjtg; arc=fail smtp.client-ip=52.101.193.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TQuftjtg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uj0AguIikl3vp5+DlhQgTFdDWszZCVW7npK4/gY4gf2GW7lOdDt6zS63zkc3tK89xo2b8eP32t2FPTL6R5jPzHtfIoEZXC0bZXJ77s9KitUuBgIVGtF0qF/Dvry6uUm0qwF9lhP9GvpQ7nIQdJEuPmGKl3uiG0qwOQNyDt1++URea/gg7hf9EsGBfMYTOFtaHlcNLKAkCkEoMRD7mXWcSxT+Pt2snF0WC51uwcMs/bDH68vZoO8KyHDDfnY07ILeq/MMF3dI8rczO988JV/SyPtB30/8CJGjeNYRGB6010AwV8CGBG0z8z1iZVxREI2LduiCHnX5x7AlNDU/vT5SEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLVnx364MwIiqrNO5GzKIfgM07nDj2xdFyOqvCpheno=;
 b=wKBjgJvH5Yoq5thkjSPqeLTHWDU4n9m2zfY4vA1eTNaQ6tDS1sl9BgTwiLqn9iWaMPrJMX4fb/3q8eBEUl2X0eqwKFFP2l+GJq/GN7VU3lOZaqTf7h+JF8HzlKXhyDmIDp9nxZySlzKKe7hxziGNterpFwrE3FC2vOeu9OuD0mDFcWG1RDFCHVZJHH4NgFteBRmatpdALzQjO9MPm2sTlLnocha6GYqaHBAk2jBfOhxBVW91WdQJS4+QVSG9uyjpEszcefr2E/29ZYAAGiJXNv3JgolPc4fb3FtbtUMJwlI9iWmaAmvQb6iUT7J+nLQE4xXIK4ksSAvYJT/PoJtsAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLVnx364MwIiqrNO5GzKIfgM07nDj2xdFyOqvCpheno=;
 b=TQuftjtgDHzdE+bqlRbk64ygUy5BSKlW0lXmzkzQgmNG18ynV17DvrYlgrABHFcke9Ir7UQSODpV8HsBBB8bnr+fqBwQj02+nMqtBjWwSlzrmDlPqHXD11KDveU+KwinvzKtE0oa1fAbLy4rzo/Ang3Ho4mrLTc9Jh/HUH/ihG8=
Received: from BL4PR12MB9533.namprd12.prod.outlook.com (2603:10b6:208:58f::21)
 by DS4PR12MB9611.namprd12.prod.outlook.com (2603:10b6:8:277::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 19:54:17 +0000
Received: from BL4PR12MB9533.namprd12.prod.outlook.com
 ([fe80::d6cc:9c7e:12b9:a418]) by BL4PR12MB9533.namprd12.prod.outlook.com
 ([fe80::d6cc:9c7e:12b9:a418%6]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 19:54:17 +0000
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
	<Basavaraj.Natikar@amd.com>, "Martinez, Juan" <Juan.Martinez@amd.com>
Subject: RE: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents
 JHL9480 downstream enumeration
Thread-Topic: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents
 JHL9480 downstream enumeration
Thread-Index: AQHdSd1c593zF2yuc0efXEtk9KFFoLbazowAgAA18BA=
Date: Tue, 22 Sep 2026 19:54:17 +0000
Message-ID:
 <BL4PR12MB9533BF5ABF7035E6DF151C0A9C832@BL4PR12MB9533.namprd12.prod.outlook.com>
References:
 <TYCPR01MB1092795BE7AB51121BBAB292496862@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <20260921050450.GM106095@black.igk.intel.com>
 <f8b929da-b4ae-48ae-9667-3eb93aa0a4bd@amd.com>
 <TYCPR01MB10927E6DC71CDC3B39C26F35196832@TYCPR01MB10927.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TYCPR01MB10927E6DC71CDC3B39C26F35196832@TYCPR01MB10927.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-22T19:53:58.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL4PR12MB9533:EE_|DS4PR12MB9611:EE_
x-ms-office365-filtering-correlation-id: c822f807-d630-4890-5d6a-08df18e3492b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|38070700021|4143699003|56012099006|5023799004|11063799006|10067099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info:
 SeVYP3Hw0FBj+BFQ4bFvZQKrBpinG171+PsAEPY68m2D3PAkYyEZv8zmU83ValzKgD9h/BwdV2zbMY87wsJ5/2jaf1oncLabSt956G8a9oVh3OpPkee2/27ym8rOjtg7k8Kz/C/ZbNjZdNrKfe3O8qSizjvJkxuBTLARXssxRbbP7YeNoDgXBsQ19bjmZ0WjtFgeNFgGE8+KJ2mM/J/4lSEY+bYIQ7VpnHbC83Iy7wiGgWBFv4ikYzHDSqY0NLwUEAzXrHe7hLUsopjMTCFMnPVmvMzcJRyYGrWXZbWMXj4b5MVGS7xD2iQsVOg5rzOAAn5Do2RadA7PiGo66nAQ9jWXG47TOTUIS/U4fdOMGUkPW9MjAtkA48B1594XGIgSnUXRP2HUqv0Aou01g0RpPbNu+oQkS4N1r7/JH0bIANSrj7pM+CS2e8cwnuptkM58+CWPZptiexfGtGo27pIr3iZdjsdmHo+J5+gyApRprOQbEmsngmGDd2mZwfSumsqi/eU1HCNesFsYSQi998wuKpY/zShVoB4Yh1YGUAyvlnYFE+Ja+sz7kpwGBIzZhpmqnhNo/4cUQ28Mlm6rE6hV3GjnHeR5DKAnt7+c12T1TKWtvgR4tsih0ppPY2neGrBjXgjF3tfAkgymTEFHw5xO+m+fSJXEKv5G662K5B2fZL+h16h6QIyM/feLEuq5l+wBpkfnElqGz+KBV4sICETOIAxaGWSd9ifoGQpA4Vmtwgc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9533.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(38070700021)(4143699003)(56012099006)(5023799004)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?jOjEv3IxPeiCChwQEre2VvwlXC1xJi7Ah+juJa7/yF2S38EdVZR4AA1CId?=
 =?iso-8859-1?Q?8nS2sRBZA9XPF4yUhfnEX859yr+u3MmIEX3r+oBr+O/zjT1NTEtYyyc3Q3?=
 =?iso-8859-1?Q?BcrilNCwM0MlHEaLZICGhDRf9kmS37AIZrHTtarASTANdYpXwCVdvRCTKV?=
 =?iso-8859-1?Q?R/mSXOHEjDqhqFriPG66fea4lPjBoo9rZlt55jEjgejF4QVp8GCmS3jvli?=
 =?iso-8859-1?Q?flC6eUAWKmw/qvOSPaKuzbO0Hb1oqbVR4mjXniBt1L799m3u1wAdZPlN1S?=
 =?iso-8859-1?Q?O5g6RbhdrrG3ySIo0R/77JiL5O/7rYFDpZwPUir4SXv2xrGEvzhe3FRe81?=
 =?iso-8859-1?Q?1+eVoof0nDF3cSUaplxjMxlGIwBODtVY3rsluekToawgHREfuEkHXebHjj?=
 =?iso-8859-1?Q?GVWFSEvg+qjmzs28cSjocs8XWORthw9ji3lPR3c7v4eLHdjsNmEctKMivg?=
 =?iso-8859-1?Q?Se3O9Tbe/TNUmOTblM+OlRBcPTvKkACinQZqSJeA8Zr+HI2aMgIgYmPVb3?=
 =?iso-8859-1?Q?dyCI7BvQTaVUualr3ZRciLp/i/Jc/PyEY+4TOzq/U5avQ/OiMHq+gJHvef?=
 =?iso-8859-1?Q?jEsoPbuK+I+Pcv8yLwIco1Y2MzdX/X5zv4LNciOMx5X1uaslNqZBZjohVi?=
 =?iso-8859-1?Q?4vsuHkjovA3HdZNe51zES8Wl+SMJZORgvFpjt59N++5qdhUAEaZ3Az+fDK?=
 =?iso-8859-1?Q?mzoG4aZwotrWQUGg4MqpUKzxzaBOkV0xv+VA8o9mNeeZ/Wy1oLrkqvXPV1?=
 =?iso-8859-1?Q?lcxy6C7yGjcnhUm475aVbVUgzt711IQqeXkx5XitYoWQdc4cvjCHawzRGK?=
 =?iso-8859-1?Q?NB/E5EuYoAJ9MlUvWvrK1Hef4+wbcaqW6oe1ESW7ez3Fxf/PUTsWMQRrX6?=
 =?iso-8859-1?Q?LLOQ4WYYK93ALMo7Jfs+YWETrfPssS8ZaT6qS7CBa/zPaFOrC7Gz8QZ3Ah?=
 =?iso-8859-1?Q?MJTmmCxcpwK1C7hwl9Vzv+eWmDZRV4oB+cLU4BTYb25QgabEUd6iFNHMiH?=
 =?iso-8859-1?Q?UWLxq0LmpQS9Lq5bbk+UF0lWjdA0yMa81z9u1qzhefmpS6UiyW7Z/SuEkq?=
 =?iso-8859-1?Q?EORYhoqxHxmS6rM5CL+Lc5/UjvrrIIByuuml0s3lpPnWtDuwLKrQYB1HIv?=
 =?iso-8859-1?Q?BOhmJWgBqlm2Ylmchn+4CHrveG7gPiqiH8sz68E80368pDfaOH57Agnmog?=
 =?iso-8859-1?Q?1xYCMbr70E+K4nGAz/vhr8T2PvmDQHC951qAn9RIttZNII3mh7bV7hfLQL?=
 =?iso-8859-1?Q?5PjB51A7oKUCW+uGim4G7WvzQKzl6eXbl+BXwN785AXH1KB15RCGKgEe0i?=
 =?iso-8859-1?Q?NTeaJOKOGID7tN53tc5mMVdxLD3FYnmGe3xElA9ltxqjlLclpVB6vybkH/?=
 =?iso-8859-1?Q?/PSRJ91K90gaAJ+CR9GlcpsGz3fhYEmx0Czp2yDXFDu9urlQRlTsDKcTWb?=
 =?iso-8859-1?Q?6gS1KTgCeYg2KChWQiVD7CBWqXGXjeIV05MqlK4B836PiyCRtMBAUAV0Eo?=
 =?iso-8859-1?Q?9JD0I9vNgd7dzyIKF9P3BPxsW+k+LMThP0mSCccmsuM3bD+vwr6pGnTavj?=
 =?iso-8859-1?Q?IvHDViAOBADyYOEKX5jNIEHFALNfkoocpT6gkU0pa9fjjYy9eNlcrJ6B/9?=
 =?iso-8859-1?Q?nl82H/v/VVIGtl6pBVHYRHJTsC6p6GlF1RBbtuKONv9htVi8mcUlQl+bqC?=
 =?iso-8859-1?Q?ACqhdaBqK+o0al9kIZzkVJkbb4Ee0mLlJMOlYI5a5JS17v4S99cKfnhJai?=
 =?iso-8859-1?Q?KMuNBrHUni+TdZBMp7xzh5QTFxA89A20SPxrYlmeQx+gCQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c822f807-d630-4890-5d6a-08df18e3492b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 19:54:17.4035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CEtHRDJoN7HUO0G1gXbUgVuPC9VXDw82YxmEGPI0/+J5q5oCbE/BZXY58mr9FBRr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9611

AMD General

+Juan

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
