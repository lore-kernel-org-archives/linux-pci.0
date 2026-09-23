Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011013.outbound.protection.outlook.com [52.101.52.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DBF56B866;
	Wed, 23 Sep 2026 19:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790192241; cv=fail; b=Me7A3tHnsCdfBKYv7dZZ1jV+5qf1Rf2sIOuIO6zR1E1U6Ol6G2UmyaXjrMHyhNINrvlWyvTjUvXoDnhdAKbxBhhEA3MgtN8Ck6gcM498jHPmvk7TzaG/iGbGeshcrmTDyFDC6nTSdsSyHJWPuudMfFdE9BQIX+jWpHJZj3HNDHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790192241; c=relaxed/simple;
	bh=PipUTEbyt3tDqh3UWv1wTBBseYJUQkcEXm2G3J+Xt6A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NiQyQDrf/rTkiyAF62pkh1392BdMWQBd11/AGXSeP8kHDJ4vGNUkpj1huFASKPZ1/oQGcd98ml5SnXo4KYydj1D+FSZ94z/HnDdrwfsgUB8LG87MUyBLt8HOmfyHidDWqGIUsGzU88YIc+nM0pVCZ9Qy52iDyZeL6tJ7e5c4esE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SoVGxfAh; arc=fail smtp.client-ip=52.101.52.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SoVGxfAh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMMUsgpatYjvu7qzyKm1EgiVf0Ip7UZppZrWOIMQqEarCtgEoYvAFoIXmUIssuBnsyKegjAP/o3LHl13envHdt16NM6IP8jUkrU/Nh8FljOz4DXYUvKyIe6NtvkhuLuQ4b6r40nsxMLOjlRQgJy+C8ieYhsCxXQZBjPAalmUCP6LdrpcQsZfiC2E2AnmCD4I/hIa04fCBVv0zF1xljXNQwFEr99W+ebQRrIR+CcUBGuXNIIBhsunhBKJB9oC8vxZU+RQ/0wWbb3nJ1qC6r7TXb5Y6HNT/WBEYfullcFQdJZeLvYQBXwQvVGZTGbvCS1dsTkPqUdg/vy8lfycgydEUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nm/uECqQEnMVUuk9UAAoYZXYgp0AcBuyPjSawxNZb0=;
 b=Ri4CKbgYouFr+GRA0t1+qeydKNLzaXpP/9rdze5RtO3gvw1CdW32fqmPNYY0IafYTA4zv2IOiauLgepLhOg9+VgKw60Zugt/T3t4jzz+CGQhnKzEevmGbcNvmq/UZnX16SSheCLdYnxQscWW1zw0CYxyLPgx8q4c1SsiyKiQtKIVllAL+v5gvx5GLiCz4Agbu8920Q3uKKsLDwVv1Icch6G7u0BZGaVWfau0yupsdGBU7p9ZEjHUYmFdcv4rkBTzaVttlFLIlqt7Bf4aSWfv9KqjFGvcftU/xkJLZ+uWD/Sj4bQ+tf3wIXLGM96hd2nhbsDRtDcWPyFvOgvapeP7vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nm/uECqQEnMVUuk9UAAoYZXYgp0AcBuyPjSawxNZb0=;
 b=SoVGxfAhya6FfLQ4HmC48mAFgsgjn6V1RLpElNYkrISylF8qdA6pj9cfT/6w9HGi+XqJELRLXa0PulBP5Y4G4W5+NlZu2tyKDNHMGnXZ3NDnFW4dSLHTwKSCb2/7MFyWqyLD34y7Kv8jnndExLNLid/zWDtM4e7ij0gvamwop4o=
Received: from DS7PR12MB9550.namprd12.prod.outlook.com (2603:10b6:8:24e::16)
 by SJ2PR12MB8781.namprd12.prod.outlook.com (2603:10b6:a03:4d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 19:37:13 +0000
Received: from DS7PR12MB9550.namprd12.prod.outlook.com
 ([fe80::e465:1aca:4c9a:6fb5]) by DS7PR12MB9550.namprd12.prod.outlook.com
 ([fe80::e465:1aca:4c9a:6fb5%2]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 19:37:13 +0000
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
Thread-Index: AQHdSd1c593zF2yuc0efXEtk9KFFoLbazowAgAA18BCAAAG7AIABCdYAgACB41A=
Date: Wed, 23 Sep 2026 19:37:13 +0000
Message-ID:
 <DS7PR12MB9550558C737D92A5762C3AAC9C822@DS7PR12MB9550.namprd12.prod.outlook.com>
References:
 <TYCPR01MB1092795BE7AB51121BBAB292496862@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <20260921050450.GM106095@black.igk.intel.com>
 <f8b929da-b4ae-48ae-9667-3eb93aa0a4bd@amd.com>
 <TYCPR01MB10927E6DC71CDC3B39C26F35196832@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <BL4PR12MB9533BF5ABF7035E6DF151C0A9C832@BL4PR12MB9533.namprd12.prod.outlook.com>
 <eaaf891b-7b0b-4eea-b104-de2c0db7cb42@amd.com>
 <TYCPR01MB1092762E3E179C4A43874BBE696822@TYCPR01MB10927.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TYCPR01MB1092762E3E179C4A43874BBE696822@TYCPR01MB10927.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-23T19:36:31.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB9550:EE_|SJ2PR12MB8781:EE_
x-ms-office365-filtering-correlation-id: a4ee23cb-5a62-405e-98f6-08df19aa1156
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|38070700021|3023799007|6133799003|10067099003|5023799004|11063799006|56012099006|4143699003|22082099003|18002099003|20046099003;
x-microsoft-antispam-message-info:
 1Uh1NBhZZX0Xw3+3QGEdRFsR8lKhg9HuAzIH+CpDjWiCybZL6lt9DrrczaLi/JMQ+057/fOKZ4GpJa0v2Jwr/1EM48sqrNH5tacBxELeHw/0EVnWWECHjXxvfBE2L+UQSzz9SSg8WMR3nDhNta2rgAqQ11I/40AS8U6NFjzoIdfoH/rT0dZ8VzaIgAFRxFO6/8w0dEzdsMLlG491kc7A46R/gKnUhsRnl+cbcUya8BnSqhNDiHVeHbArZV82+G4S4yTQHjzhvaOVNxuhmPgZ80MXKhoLdmfZemb7GaqH7xrlFx/gTDmAtEW+4NUvtCNL3ot+iGiV1pfWKxyc9T50vPpDRygjY4z3ROdjEvMMIZRRcJKQiR1gNaXFgI2Wbf52RErDz0WqKWVTT9KZzkodUsIIMOlXUFCn5ICss0UFTwmcyLEUmoKDSGKYseKlNDLwUO0tSpiflOm9DIJEJI5Gb3iBuhHGobhj8BUTii4qyvkFVz/7bcFo46xJA+gSVk1iJjYiADpS5hzOBTbxPP+uXLrqucg9pCBwitr/IW8i85RbjDjy1LCMeR0szFa/mWzovrseVtlyx59TXg34tjF9TnV1swiCaLN1uzuFhMLvQ2VjdvjF+dlVFmNu8j97iLcRErH8pZGTSs/yliRR512ij/vfn+rxgwk3Tpy+sRb7NueF1pNkw1e3ZMLVTDAAb6kyJ9Ucf0PlAMhE/CTccrgA1nD23AGyIaIP6jiYJFfzhJQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9550.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(38070700021)(3023799007)(6133799003)(10067099003)(5023799004)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003)(20046099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?+of+mXfCbQKx+Zef0fX6ZsW0nREuS8QHOxfMoT8UF4VDJKsosCRTZ5HF8n?=
 =?iso-8859-1?Q?y/Z5zYVFgMk5jWH8ocTqwNRLZuioGp5C6w+UAYykeZ0qotG1O//P7/dyG+?=
 =?iso-8859-1?Q?fV9Oj41GtG4qhCgrt9PEczZgCVvfl7q+1QumpoRv3gbcqusdgnGctZOj2T?=
 =?iso-8859-1?Q?ru6BancxkD7qDbO2m3fJZYNv9f8Sl7aGsDlU0wUpDEl8CsawKaqG7pqRyx?=
 =?iso-8859-1?Q?uhRb+JgkneZ0QzcTRyHPBMlFM29ZnVseUY1FFfH/iEq18qe9HSRz/46LqB?=
 =?iso-8859-1?Q?U9GcAVA7IzGhg/T3gBoD08TYOWdiJ8vvySM+9CafYVbfZoQ8E9eXdDb5Uu?=
 =?iso-8859-1?Q?gr9u2nsLn1k26+JFjd3JJsv9Mq5XtY8DIXYsCUV7EaEO1CcYCfVDLCeCG4?=
 =?iso-8859-1?Q?EXfwrnWVm9Ix/hsI2o4lpzKdAwrykmWWEp+DJx7yW4sCg0uau61wxKpx9r?=
 =?iso-8859-1?Q?OtBOhI61AZBVURyi6ecoQPAd/CIXQoBca9w/ukWLZRw4uqO2SlsZy8hQZN?=
 =?iso-8859-1?Q?Pl7VuRDq/WTVX7Li/x/nISOxdtBv4einx7ioGnA4vgfZmeQvWf9Gh8K4Vp?=
 =?iso-8859-1?Q?ywXQU5Q1+yUjufuimmq5e3TCUYzvQxSl9k1NJ9uQz6iUmwH5BYTmo1Odar?=
 =?iso-8859-1?Q?jrqjO24wXuNSYp/lvohU2/7Y0dt0oZpsuMcOpZQQTj1moUh2MDQyZG7JRc?=
 =?iso-8859-1?Q?jtFzHYXarkFOusmOMhyS1C3k0F4VRi83506vz+wL7i0Few+rvERGeHVZfD?=
 =?iso-8859-1?Q?a09IV4v199HP2rl+wCbHBhXSUP0CjSMKkXUXZWKUQWYQH8mAQcpokBDMm6?=
 =?iso-8859-1?Q?wuBRwwIIh4HbMdSdlFFlNm7MAWKpGDPj4uDkrWUd5FfrH5uNyO3OAfHNc1?=
 =?iso-8859-1?Q?Xv4kV/DmQ/EAM8WiUChztjbUwzKNqRPG88MNfWb+kxZ1diBL8czhVZGufq?=
 =?iso-8859-1?Q?L7t/mWWL9V4K+I2G4CXRTkrN7Wbvw+yvivnUWT4Ewr92Al3m2djwrUxaeS?=
 =?iso-8859-1?Q?VIvK2XpXAgSotvqIdxZqQTgAjjug00Hd6HfVkQyjxwrEj79UtA68J2odM1?=
 =?iso-8859-1?Q?kTwVB4vg4aEksaDmxH9wjrWM7zY3P5bCeGsT7XD81Bu+nAr8O0QsZH85fS?=
 =?iso-8859-1?Q?+3pUHOyeGwxSb0a62jMpo9/szcN9/1IRHniJGL3wbW8YLBrkbcne0unE6M?=
 =?iso-8859-1?Q?KHYpz243/WtQ+AWxogJCTrYkwFydOVuOPZJr1Js3NJGBoHeS6GUiV7M7ve?=
 =?iso-8859-1?Q?/0ynCFUGncDIIRBcFCojZXt3lQGPxDSdFjPATTi2dEcaMpg3P0jryvrt4p?=
 =?iso-8859-1?Q?2Hw0/1CiLiSGtzfCOxzWEglJLUrQhI3+c/xx1cBkvQXd5ZKvEPjFY7lPKR?=
 =?iso-8859-1?Q?F25sE7SmWHEAZL5mrEXC54PGkVCirFqtf9eL0UU4hyvZKlk+NBigoPYNF9?=
 =?iso-8859-1?Q?m+j91L6Huu/YAyDyRTtf7b2PSs2hRNGhLhq1ZSaxGCjMuVh8UiIMwtzjXL?=
 =?iso-8859-1?Q?gza6vk+6tHaViOuGFRyM1KH9y8tpc9SpjMPqPlctcInObh3w51WY4c9UV9?=
 =?iso-8859-1?Q?0f9y+bL+0t2w8vZ8q2RFpCzhjvLdcjwYpdP/5MdtYezch2y1x+xBFcMjnW?=
 =?iso-8859-1?Q?FyLgwKwTkD3PpPnYelBRbe32rqsLcqb3P8XVqROEUikYpV2XugFvg7BEh1?=
 =?iso-8859-1?Q?STDyua6dmg6pSKqStWfwv9bdGQVMh9Rt+5uOu8E2jXFKQGxMbJgJa5iiae?=
 =?iso-8859-1?Q?RoaRcffaRF5t1MJVD7MPS0MIUYQ+Keoe8zHE4pQLZBp7ox?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9550.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ee23cb-5a62-405e-98f6-08df19aa1156
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 19:37:13.5776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gQKHN8gugLuqD+3b+NuvfBUD+zMsYi4dkzHzKrTdgXcwZxMo9hB734eaJwA/2WU2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8781

AMD General

Also, is the external monitor hooked directly to the system or through the =
dock?

Replied or Forwarded By:
Alex Kovacs
845-625-4422
akovacs@amd.com

-----Original Message-----
From: Freeman Z <SHD-ISAC@outlook.com>
Sent: Wednesday, September 23, 2026 6:52 AM
To: Limonciello, Mario <Mario.Limonciello@amd.com>; Kovacs, Alexander <Alex=
ander.Kovacs@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org; linux-usb@vger.kernel.org; bhelgaas@google.c=
om; westeri@kernel.org; andreas.noever@gmail.com; YehezkelShB@gmail.com; ra=
fael@kernel.org; linux-pm@vger.kernel.org; S, Sanath <Sanath.S@amd.com>; Na=
tikar, Basavaraj <Basavaraj.Natikar@amd.com>; Martinez, Juan <Juan.Martinez=
@amd.com>
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


Hi Mario, Mika and Alex,

I tested the Kensington SD5000T5 dock again by using Ubuntu 26.04.1 Live wi=
th kernel 7.0.0-30-generic and thunderbolt.dyndbg=3D+p. The dock was discon=
nected at boot, and I did not run lspci before the hotplug log and power st=
ates had been saved.

In this Ubuntu run the PCIe/USB enumeration worked without any workaround:

  426.716: USB4 dock connection detected (host port 0:2, link up)
  426.753: Kensington SD5000T5 discovered
  428.410: PCIe Down path activation complete
  428.411: PCIe Up path activation complete
  429.025: pcieport 0000:00:04.1 reports Card present / Link Up
  429.026: downstream 0000:09:00.0 (8086:5786) enumerated

After the dock had connected, but *before* running lspci, the sysfs states =
were:

  0000:00:04.1  power/control=3Dauto; runtime_status=3Dactive; power_state=
=3DD0
  0000:09:00.0  present
  0000:6b:00.6  runtime_status=3Dactive; power_state=3DD0

The downstream USB devices and dock Ethernet also enumerated. I then ran ls=
pci once: 0000:00:04.1 remained active/D0, 0000:09:00.0 remained present. T=
hus this run cannot show an lspci-triggered wakeup or a resulting PME event=
: it was already working.
In my previous failing CachyOS runs, invoking lspci could wake 00:04.1 and =
make 09:00.0 appear. I do not see an explicit PME delivery message at hotpl=
ug in the Ubuntu dmesg.

The external display did still flicker. The Ubuntu log includes one DP tunn=
el DPRX read timeout at ~431.188s, followed by a completed capability read =
at ~431.239s, I do not know if it's related.

Attached are the full Ubuntu dmesg after/before hotplug and the state files=
.
Unrelated USB serial numbers and network interface MAC addresses are redact=
ed.

Thanks,
Freeman

________________________________________
From: Mario Limonciello <mario.limonciello@amd.com>
Sent: Wednesday, September 23, 2026 4:00
To: Kovacs, Alexander <Alexander.Kovacs@amd.com>; Freeman Z <SHD-ISAC@outlo=
ok.com>; Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>; linux-usb@vger.k=
ernel.org <linux-usb@vger.kernel.org>; bhelgaas@google.com <bhelgaas@google=
.com>; westeri@kernel.org <westeri@kernel.org>; andreas.noever@gmail.com <a=
ndreas.noever@gmail.com>; YehezkelShB@gmail.com <yehezkelshb@gmail.com>; ra=
fael@kernel.org <rafael@kernel.org>; linux-pm@vger.kernel.org <linux-pm@vge=
r.kernel.org>; S, Sanath <Sanath.S@amd.com>; Natikar, Basavaraj <Basavaraj.=
Natikar@amd.com>; Martinez, Juan <Juan.Martinez@amd.com>
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration

> -----Original Message-----
> From: Freeman Z <SHD-ISAC@outlook.com>
> Sent: Tuesday, September 22, 2026 11:41 AM
> To: Limonciello, Mario <Mario.Limonciello@amd.com>; Mika Westerberg
> <mika.westerberg@linux.intel.com>
> Cc: linux-pci@vger.kernel.org; linux-usb@vger.kernel.org;
> bhelgaas@google.com; westeri@kernel.org; andreas.noever@gmail.com;
> YehezkelShB@gmail.com; rafael@kernel.org; linux-pm@vger.kernel.org; S,
> Sanath <Sanath.S@amd.com>; Natikar, Basavaraj
> <Basavaraj.Natikar@amd.com>; Kovacs, Alexander
> <Alexander.Kovacs@amd.com>
> Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend
> prevents JHL9480 downstream enumeration
>
> [You don't often get email from shd-isac@outlook.com. Learn why this
> is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Caution: This message originated from an External Source. Use proper caut=
ion when opening attachments, clicking links, or responding.
>
>
> Hi Mika, Mario,
>
> I reproduced the failure following the requested sequence on my installed=
 CachyOS system with kernel 7.2.6-1-cachyos and thunderbolt.dyndbg=3D+p.
>
> For this trace the dock was physically disconnected at boot. I did not ru=
n lspci before or during the reproduction.
>
> Before plugging the dock:
>
>      0000:00:04.1
>        power/control        =3D auto
>        power/runtime_status =3D suspended
>        power_state          =3D D3cold
>
>      0000:6b:00.6
>        power/control        =3D auto
>        power/runtime_status =3D suspended
>        power_state          =3D D3cold
>
> After plugging the Kensington SD5000T5 and waiting about 15 seconds:
>
>      0000:00:04.1
>        power/control        =3D auto
>        power/runtime_status =3D suspended
>        power_state          =3D D3cold
>
>      0000:09:00.0
>        missing
>
>      0000:6b:00.6
>        power/control        =3D auto
>        power/runtime_status =3D active
>        power_state          =3D D0
>
> The Thunderbolt dynamic debug log shows the NHI/control channel waking an=
d the USB4 fabric being configured. In particular:
>
>      thunderbolt 0000:6b:00.6: control channel starting...
>      thunderbolt 0000:6b:00.6: 0: resuming switch
>      thunderbolt 0000:6b:00.6: 0:2: is connected, link is up (state:
>2)
>      thunderbolt 0-2: Kensington SD5000T5 EQ Thunderbolt 5 Dock
>      thunderbolt 0000:6b:00.6: 0:5 <-> 2:9 (PCI): activating
>      thunderbolt 0000:6b:00.6: PCIe Down path activation complete
>      thunderbolt 0000:6b:00.6: PCIe Up path activation complete
>
> However, I do not see a PME message corresponding to the dock insertion.
> The PME messages in the full dmesg are the early-boot
> "PME: Signaling with IRQ ..." initialization messages.
>
> So in this reproduction, the NHI at 0000:6b:00.6 wakes from D3cold to
> D0 and the Thunderbolt driver successfully programs the PCIe tunnel in
> the
> USB4 fabric, but the AMD 1022:14ef PCIe root port/tunnel at 0000:00:04.1 =
remains in D3cold and the downstream 0000:09:00.0 hierarchy never appears.
>
> I attached the full dmesg captured after the dock plug, plus the small be=
fore/after state files. I redacted only unrelated local network identifiers=
, the hostname, and filesystem/LUKS UUIDs; the Thunderbolt debug data and d=
evice UIDs are otherwise unchanged.
>
> This particular dynamic-debug trace was collected on CachyOS rather than =
the Arch stock kernel used for my earlier reproduction.
>
It sure sounds like a PME doesn't deliver properly for some reason.

I suppose that while in this state - if you ran lspci the root port at
0000:00:04.1 exits D3cold and 0000:09:00.0 shows up, right?

Does the PME show up in the logs after you've done this?

Any chance you can easily check Ubuntu 26.04.1 live media?  There is a
7.0 based kernel there, and I would like to know if this regressed from tha=
t.
