Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011054.outbound.protection.outlook.com [52.101.62.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1033238330A;
	Wed, 23 Sep 2026 12:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790166418; cv=fail; b=IwrpcSEhhkftcfN1HH7enu7dZAzDP5Df5ZiV7ywijgc+6ODGlkZAvddtfp7evFFhVBWf3Q3iSmwAtv4xkTkfvpIIaukypGMWLPnkF7cUrCrgaiIhTt6nw9xOzzkcPvLo6RJnMkLi7x3F5NrccyX6z/fljd9vX0ut4Kmo4YgQNLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790166418; c=relaxed/simple;
	bh=fRwflVgcEIa2Ptj9uH/5DN2XqttmDd80WjChHRyE8HU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IfhM7cwJCcV7fjmTc+pP9KE+Sfx12kfQRxYFzAHOu5gNgzeSbiFEtABHIzlZCfVmjcGUKa3QZvoQpH3Zpzdcd2RMKjtZJgQClzO0H1mqUn9JF12x/h+U8wvVqRAtJSFxxLWV4u2WmRdaqWDYDfHlwbTPbnTBmSAaICq2XMWC0gM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=23tJIb2H; arc=fail smtp.client-ip=52.101.62.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="23tJIb2H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=feCrQB+gjIXHI44i6358GAf50jyaLY9d8/wOC7mOaCfIgB6fNQB9vkY/BErbTMoMDLlI9YwQDke0JJS5mXOwgdfPaG4ElZVkMvcgVYvC1rmKJQteX1bKmCbuCcbC2rh7GYm9eg/XKwFAJ1d2LiApbilBcN34f0/kSJx3IYDv/lyT+nLYCF/6gb6V30eF0wQG63CEvhFE43NvkU20XJTG2bx3HqQ2rGy6llAMVH1hreH5ecQXm4/31xCoiSE9wT4ocVCB8rinEYJwyAdc/g6eaGjn4XfQIP6HT7GDUjxsxfKGXN+xCzFzHPPm/CvFQUivQiAjZAXkhOH6dWzqgH5xYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ORT4Ag8WjUCDuUP349pep/8fYhB+W+8A6tenl3Lv5o=;
 b=LjshAn4ZkYtbTF4FhdUAwZHmF3rQD9D0/5eNa+clSskZOellzVN520VD5VzzDewKxwD+zQAFM3P0JP/tKi00a/5PUNjWrbOIT3Q3gUbyz6X+6dKWkh83vkNWBzxLUUMnmnw8gAV6JUCxHl7yLaQ5f5wswxwAgGuvfuxzzKPUIYI/AsMC6fK5wp7eh23V26AWtwWugg+CG3NCA+QSJrp9azbqAFdQ2a8wv8YwjqOco0dL39bIGV3gsx6ZabfFbgP9URq6MHTaO0KjEtetalpUJQGxO0is2yWgJ8m+SwdUsIM85t68QIu6fn2RyQHbOJm7SfQf7uFlsy2OyKzc3er8KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ORT4Ag8WjUCDuUP349pep/8fYhB+W+8A6tenl3Lv5o=;
 b=23tJIb2H5Ruph/cP8CNhNJuo0ohM0W7zLC8m0BwICYpJYwytHSj3USNOxrvRW67psId4tbdNBvZQJ1wHXNs34bcApN/pCihcFgxH6M8tRLwVHocldHEuTdMrwXhw1roX+zKQjGrO6VbIxNbbg/a5ViFn37HiO0WGqehiSw9eM7k=
Received: from DS7PR12MB9550.namprd12.prod.outlook.com (2603:10b6:8:24e::16)
 by DM4PR12MB5796.namprd12.prod.outlook.com (2603:10b6:8:63::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Wed, 23 Sep
 2026 12:26:19 +0000
Received: from DS7PR12MB9550.namprd12.prod.outlook.com
 ([fe80::e465:1aca:4c9a:6fb5]) by DS7PR12MB9550.namprd12.prod.outlook.com
 ([fe80::e465:1aca:4c9a:6fb5%2]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 12:26:19 +0000
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
Thread-Index: AQHdSd1c593zF2yuc0efXEtk9KFFoLbazowAgAA18BCAAAG7AIABCdYAgAAJSpA=
Date: Wed, 23 Sep 2026 12:26:19 +0000
Message-ID:
 <DS7PR12MB9550448CDBB308D04842601B9C822@DS7PR12MB9550.namprd12.prod.outlook.com>
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
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-23T12:24:52.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB9550:EE_|DM4PR12MB5796:EE_
x-ms-office365-filtering-correlation-id: 153fe35e-3bbb-47a0-f39b-08df196ddf18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|38070700021|11063799006|3023799007|6133799003|10067099003|5023799004|4143699003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 He0clDj34wmYipNNifciy4wEosT5sX3wi9egpbfK/XcFrT/iuLwElie1fbfOA8AUN+aqSYZUleZ3qYoB5rp6wARl4ZYpSWC9Sgy/Dcoxu9hatx8f0DPfBXLq55kJzbrvzgV3c3p9vgNicXw6B2Q2NhxmRNS/i5/Wy3FEDmWYhUfmZY9PTk5qIXsb7D1pv9n7IYTfO4CsHx8u/OnsyurwURYC38bjByahR0HOzDv1C/5ULM35tQLqqPCBgQLUNJ4m7drseqnP9PuPE7x2W01nMREglO9UangXCxZXSOenfyA3ow9SKbwGvlTy6jLBwfIdO1acittwvcs4opr5U7Z01aLz8YJXcT0g8DTveWVfN0igy+mfMCXzThbF8PYmride4M3a2174oSh+k5dCgxEZp/6Sj9Rx/zimVIB79WkxwN7wetR0ubMARw0wdV0XfoChBP/5mDYI1pP69Lj4E6GETBWd0oHMfc16g0QUVWY930rIkh01y8+RbJ/OL1EO9/TOa8tvNhEfuvqOO7odCyyo/r2EANCIf/GebWYs97CcFmvvDw/1emb5WvmJXVr2H6FXB/IRZq2znPoEr71LCG10XEy7Dr2vPu4teoDd9TrYx70ZnaBjxeSscBExPN1Ii2LQoAn7PHgtYcMYmbJAVw7PINyLuiH9/1AvGKRFCb1fAnF8p02hWt1XCrO5Xf+gCer19v8xHS7DGP+p5q+5yklO5IDyVtuNzwQJCo4utYHAhJk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9550.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(38070700021)(11063799006)(3023799007)(6133799003)(10067099003)(5023799004)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Gio8aX57Hx/2xfYi8PReWLllddiuaZgn4B+EA7sdGjJ8U3ydwxlekLF1sD?=
 =?iso-8859-1?Q?P63Rko7s53Se86PUXDedR+nt9xymbSBV1x91yKv/tjTH1Pv49ilp9epy65?=
 =?iso-8859-1?Q?giB6/C14PZrjsdIug/PF82WRIEUKpAjTq2n1/CpvlOXENDvz+iYE9TEzaQ?=
 =?iso-8859-1?Q?CjReARb35WXHqc6NlLGj5reEA0wB8ehgsO8bx/3MSU+OVWUqI5yJhDZgD6?=
 =?iso-8859-1?Q?JsaCe6DRiWcFMngOuF6NtVWc1imudkY659t3BRRghrIubKbvkNC7cnelPj?=
 =?iso-8859-1?Q?vrdYtED5uR5jdZe6nTO2jbMDnBipJXVcNZAjZw2l3QxdJN/roJBQnBO/Jp?=
 =?iso-8859-1?Q?h3hswOD5I2u1gyFHUtOPe9Lm6wU04BhqLZBU7U0yKjagFbH3h9EHZRH/cZ?=
 =?iso-8859-1?Q?OER3piI5usaKBbjQedaspcvlog35xloCZ1aD/ccOCetNxzvmGf7JTRDYYB?=
 =?iso-8859-1?Q?83BWCsDyZ702yslP5VLFGyiiP8mP6+/GRijJBPZdnE8BE0gXJlFQsgjw3r?=
 =?iso-8859-1?Q?E1mEZlxDWQFZOyzBv3uIh02j8XzO5eS+mCIEZYsfJEJNfifksGsQaGoXGk?=
 =?iso-8859-1?Q?sF5L5MA5HTG/IAngEEEYzPU+vO5C+DoxDom1Fo6kIXjqbSpM+YYq7S2/AQ?=
 =?iso-8859-1?Q?j09mMS2J82Dhz6zu44IWKytQYEFszU0sQDhXuDrN3fG2DIwjETvxuqV3QR?=
 =?iso-8859-1?Q?vHx3CC+UIVg92A53Rb2SM+LOpeZcUiJxIshNhPhqS/FPJ3ikLM3yF9TXyj?=
 =?iso-8859-1?Q?AG2kRKnwSMOvbD2j9/MMZqhirRs6yotRLbo71w0IKwSmI5NsCB69ED+XSJ?=
 =?iso-8859-1?Q?T0fSIy5VENNVxhsepaWA15SU3X1fRrhUKclP7ZRFh1E88LsvNypcFv9V4r?=
 =?iso-8859-1?Q?kjdeCPhCIZ9GCpgVwjfu0PL8ttIwEYRHhBkJ4rE2egOSJ/Szwx6mX4KCiF?=
 =?iso-8859-1?Q?NmLk9i2Rjraahoviw3K6G8GoJp10QS9+K9oe+fJJC2vZ62WwszZJlVTW4S?=
 =?iso-8859-1?Q?LxBI6+cAYzkosi1hMZkmldlA/B/DAVOLOBGEzyiHmTZQqd89DzxwiFbIB9?=
 =?iso-8859-1?Q?GwxBuoxOsgRWHpp224KOXQfqDq7UotHUIBeAnztyLm/KCGBM8O9A7HfG+j?=
 =?iso-8859-1?Q?7RUETAT2DoLAgcM8y5cokih7flPnSOIZNiPwadcvQB5PCPvoQGYdrgul/I?=
 =?iso-8859-1?Q?h2jNdeOvzs5HMO46a4S8l5B/aAvxfGGtED6rCT8ao9QiIdvTK8O1YiLC34?=
 =?iso-8859-1?Q?46DhFYX5p5t0PZOwsdzSqGbWyvw3K2aqaQ+TOUC+lGOwttgYWM1yIxTQEe?=
 =?iso-8859-1?Q?8e1mQBkojQcuoRK272ovfqC04USnqrywfVFg24RhP0MCUJJeZumPyowqwL?=
 =?iso-8859-1?Q?bLof6ucdXAG+GT+QZ4YvbfgJdDOMcvcg9kxyU8EYxk1GTEbavv0JV2tD73?=
 =?iso-8859-1?Q?7UF03zmmiFr9A46sKzqbdwJ6NsbThKI7cMSHE5M1wSmrX7qOthj9NYMEES?=
 =?iso-8859-1?Q?f6co2igIGhb7WQ/rmVAAVPtWah+auq92aep6kkTMBGGke8ivAV/83ok0Vj?=
 =?iso-8859-1?Q?LHQIaZYW/UYEmlX8pm6z/8EIMnAYREJ1sEKFwmg0p4rcTHCBHxL7VzrJVl?=
 =?iso-8859-1?Q?iDuqSX/eQti75DEtoI+1ZGcK+UIIiocOvTLOE+QawBn9KA1liUyE4CLaYa?=
 =?iso-8859-1?Q?mKoyCNYObVWfHf65K6tjAIKO/SNbQ1jSx9pC+S7lE1IiAPQhQZGEYQNlia?=
 =?iso-8859-1?Q?Pr1/INvN5gYKmmkuU9uGOeONRchI++7iyXgbpHwltVcFIj?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 153fe35e-3bbb-47a0-f39b-08df196ddf18
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 12:26:19.4906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hhhFaO/tAyE8dAcJwXQog6ogVlcrH317zhSgD+u7c5sKOncAvL5YBbH4Ut2ulDSC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5796

AMD General

Freeman Z,

And this same setup still exhibits the failed behavior with a mainline 7.2 =
kernel?

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
