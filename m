Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011017.outbound.protection.outlook.com [40.93.194.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B0233DEC2;
	Tue, 22 Sep 2026 17:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790096562; cv=fail; b=VMYbGmFpx82GeGj3TGjreIdLSB9SkkgNu0z05q9HCmKNwjYv6lKQXILx0AjFqiBA44mhEgreqZAoHf/ukxhWd4rFvr/wgoZk4x9nQSnbxIMY0/QCMJkB+5m9EEzwsiy2yS6f+MEdkOCBlw4bOMHfRC+TLqNW3PHKXt/x0aGBWAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790096562; c=relaxed/simple;
	bh=liwDRadqQDSUVx2kRqEbAbB5ctbMk/WNA7TKfa7S+YQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mRnz0cIJ1l9kHum4lzIzRU55PPbKAhLo8YBJTWuIX76IJ2l7e4X03q+eM0GX5x5G2UByd8rlvUQZ68N2xVjxA8Fb5ot31X2XkxgtfNgZSH1XS+KF1cafVa4o/dI/KLpBcIz+Ar6BEXjNSXbn0SrYvq69jd0dNnBSVb4k5+AqKDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XT/+PXNA; arc=fail smtp.client-ip=40.93.194.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XT/+PXNA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SMyPIV7umCH07ACFEa4wItHRkeO0B3vgdosBu6S+1VV99Yk8H/TJ/UlHQ6TBVhNtn84NrbhQz7Pa1dO7pC57Nj0xM99GrWZXugGrn+dufkS7cufvo01kguOecwyUeQbzh7eqqHwnCrrlW+F/PUxlncGr5Zv5CxRV5WQwxQNSvpiJXcNJl9Nn0/F7b15cHkb0uUkUmu1/rJG54hSSXjUD8b0o2KFsu3NgyqwlY7KCubH9wTYRcx7oYS1JZllsmnoVzAbshwkmmIZvjk0t4G+8r58X3XCS1uufE6jgwXJ/Xb+oA3BKyr46x7DOlnfglXIYIXBPgHU+PwIRgtr30AKkjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3EiuIP5IAklG91neNgfDk6P/HDPhY3VRb9kUzPxPNx0=;
 b=dBV93LNqvRJL/YQmEyHTYz4bvHpCxn2wt04gOe7A+iPrEmwIm52nb1lgbl80QrdQVRPXrSNerznRmhYPNVbJW6kpH2qeRaFBjSQXM3GI67Q3om/h7vMvOnKNS9XyL2XsKoQoBz4mGDieSXiPTrQTimLZuW5JWsZWFLE0s2pCpkaueLZGVGEF1bWL7b8YT00Z7xsf5xTc6gU6MtBgp4U6d/eIb8DjjlhShc5KVpqm6JtmBWXM5K++D4vEMyDOBZzllndGaLdHn5QDoZDDAwdYdK878ZdmwaIpgaUc7N4t3UVrLanX7Czh+3uz/OG7I9Z9CB1sb7EVnWi7k+834UAjsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EiuIP5IAklG91neNgfDk6P/HDPhY3VRb9kUzPxPNx0=;
 b=XT/+PXNAeJc2IjqKJEZ5EtVuuBEh9yYnq/rSGXCGOYtQiaY9On9UeNyZ4aGD6NqU05yom4UIOqaFZOxvRDwmyEB5eNbzFQGzz54N+92O8UGhotrNbmXyMBcJCQg/kM3lPho81aieXI6w+LZWczl/33SuC58v+M2AVGCDd/kse00=
Received: from BL4PR12MB9533.namprd12.prod.outlook.com (2603:10b6:208:58f::21)
 by BY5PR12MB4098.namprd12.prod.outlook.com (2603:10b6:a03:205::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 17:02:37 +0000
Received: from BL4PR12MB9533.namprd12.prod.outlook.com
 ([fe80::d6cc:9c7e:12b9:a418]) by BL4PR12MB9533.namprd12.prod.outlook.com
 ([fe80::d6cc:9c7e:12b9:a418%6]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 17:02:37 +0000
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
Thread-Index: AQHdSd1c593zF2yuc0efXEtk9KFFoLbazowAgAAFwVA=
Date: Tue, 22 Sep 2026 17:02:36 +0000
Message-ID:
 <BL4PR12MB9533DE7B38357377187023B59C832@BL4PR12MB9533.namprd12.prod.outlook.com>
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
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-22T17:01:31.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL4PR12MB9533:EE_|BY5PR12MB4098:EE_
x-ms-office365-filtering-correlation-id: bfaaba43-549d-4df6-bea8-08df18cb4da6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|10067099003|56012099006|6133799003|18002099003|22082099003|4143699003|5023799004|11063799006|38070700021;
x-microsoft-antispam-message-info:
 1Q4lvHvyGplrx8P3kWy/WleMMIctfdnizwlLq2ZpJioJmbFjs11R/dByBg/UdMvn2gA5sU/iXKccvv5SrAW6FnqN/JGI3tLX84bbV4YCbte40zzA3eBW5Iir9cysPnvhxFF+FBIGl2qpZSWOzmkeyqY1Y3LW5UTn3KP8X3rSKO86r/2n6UU6uyRj/+lqVHR2sVEvi6cGX88kifca5CiFH52S9wKkCUsOHJcIcLb5jJ8+vSVno+nd9pJq7XybEd8RU7bYQfzUBLxz5WaQ7bJxgVJEnHpgfweAz3/8eQ1EtULtKquVVo3XqnUGNUkVwrpiVtUIuCIenHK6SWeXRpu7slqMkNSOIzCqCXCYJz2RvEog5nzjabM2J+44hDivT6jijdf+wymqymkmtQDjHz28akuAKQcn2Ubn/Y/k5DBpMuznCLRo/Yu0uEaBFZP1NNXlU8dHTO2KAOFZfzR8XNmOQs+ocdqVHum+82vbLw6BOt9y+QDdODv4/vJr4F0P5eAEr+YOm8bcfhaQeImqj5tHUaRDGY1Z6UhmHqFKd6Ol7OtRGKvLaEpeCXypkniZQULdiSlE3a8Uy/fbHWm0+vDnUNaADJCGi9V3rXbvkFlN5VlVDI5Uo5mOAmjOvBRgF/i50un/Hs4ZVdAEWK1c4UzX7ouUVpa5PqwGxauS6Hq3JOVzJjn+ERihJbNBg/tje4EioYZGYcqOXRf1E29EKrH0ktxKp/j73z53zl2FYcKxnPk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9533.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(4143699003)(5023799004)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?wVaGRhsb8NZvVn1++QfH6ysRx7KeqBN8HM+HSGbiI3fdkOonwAoa/isX+s?=
 =?iso-8859-1?Q?bsdjjALPs35eYmUj6buw9aIHoHi/8LLKRCEfzkZg8F0bAxTOdPLjRB6fDI?=
 =?iso-8859-1?Q?n+BuuK/mVHTKq2tb+ikTSorQQS813xDS7moqs5RDY3Z4PnXVnH1sndFO2n?=
 =?iso-8859-1?Q?gczWCXqihziYIggDNhuM5JVjuP+n0CtRrRmdLXkOyL+9zuSEBuDDCVuaKX?=
 =?iso-8859-1?Q?1MKljsij9tcmW9E7wqb7R2RIwKz4PBGfZk0eeatd3qw0rf9waXZZF/7kPZ?=
 =?iso-8859-1?Q?x3T4HjPnIcj9HZ4PRFv+GzFzf5pjjIHhP6rq7lBr8TrBowjuS7X4gXPuF9?=
 =?iso-8859-1?Q?NlAXoAvSAIW7vxuKtBOZq/hO1rMi8ZM6dC1z+dQTXkuHR8tff6mTk1S3sA?=
 =?iso-8859-1?Q?Rmk6431DGaX3Fup+iB+4JDIX0sqq3yDLCxkoajLnqsUQcHYU+/YvS/U6qs?=
 =?iso-8859-1?Q?5hv/LtUxtLEMQBZyrBmlMRluGRe+sWvbMo6D6GqbtkzMBKzSX7w2SKyQKS?=
 =?iso-8859-1?Q?0Y16fKio99E6+Ql2juoj4Uxjn7pUctLkPNNIk60KD/HIrBPUuuX5ZvAB7j?=
 =?iso-8859-1?Q?G2jNVcMc4q5KV3N7OJifoOabYCGL4DU1XODV17s8cN/qruE6BITeV/RimH?=
 =?iso-8859-1?Q?RHvLFgNP0rWaZne7IWBLT/LvKzqYTbpYNn0DD4UtY4tXwMPbqBwnlkEQzA?=
 =?iso-8859-1?Q?WEKWf3BGRou8W48NSVseyZR6C+iBMeiJgY8bBQwVZt4IoK+l6chXTctDbV?=
 =?iso-8859-1?Q?6vEDW7C35HaE4anSaml5d2urJ/gwJPifpg0Q7f2+lGmBu71P3i4M5gF/Js?=
 =?iso-8859-1?Q?5BLwiEDJlEymgsRCkH4zNfgPh+om3QzpZq4g9r+aMgELWX7p2BelrdOBCC?=
 =?iso-8859-1?Q?yniKSF8oMF1H2wv5hP+LncbUc6y+pMQesIQdPTLqZUO1QSzERem/MnA2K9?=
 =?iso-8859-1?Q?5+lA3Hr0Tm+v3mmpTzYVzLemmHCLB5uH4I/jktnPTnF1HKY9+JupO+NW7A?=
 =?iso-8859-1?Q?rGMsMijkzDg5oTIKrb2kgw8yEpysxzAeDhYyLNWmZ6TvK/WpTi/g5WqSEy?=
 =?iso-8859-1?Q?cS0XDYj0d0V1imPmQNflDR1+iK1781wQdSZz8C4S3JbEbJ572/EzTjewON?=
 =?iso-8859-1?Q?y2AlysK5036QRUaSDyeoSZl/R2re7NBtYvDbChxWDwbkFHqsclACzoLUM8?=
 =?iso-8859-1?Q?6RxbV40Movd1gOxN9hDbGMs8nUFYR/IaJWJaqm9yFIZwhjuievzbUhJLzx?=
 =?iso-8859-1?Q?kRsJmqIAUL7nemkyX75DfMT4lJYqmnj9erd+4nNg2YuoghnEwXN1uKrw2Z?=
 =?iso-8859-1?Q?+zjdr3pTf4lPIdH8E6YsVacKCL0XM4byO6MyZBmpg/ZvWqEf+h2mdqtLJn?=
 =?iso-8859-1?Q?HViUDEQRexk+fcf3YC4qVLY4BcNnfvJ5cIHFn+pKQ5eV9LVRjZag98dloJ?=
 =?iso-8859-1?Q?bHDwGbaT28ctqNPPCxhkLMPGSj0NHBujiP6r/7CuYcJjMrSxqUFUdlCAYc?=
 =?iso-8859-1?Q?56Yi8hkZyus7ImV/Si+1U2uxd339oPUlEDq0bVFIZp8fvHJBnuci+pisvc?=
 =?iso-8859-1?Q?6+lbgl+x2k448pCSK/E1Lz5hPydTmgGOVE3WzzzQWPQNof/4z8Xr/4QcAE?=
 =?iso-8859-1?Q?ED5cL0YjOo/VP5XQ7eqmzT0sDJsW6AuhPTAGTwN0VmT94XlE44ZQG2E5T9?=
 =?iso-8859-1?Q?T89vyE2l0DFxlu6bboQqhgVO/qiwEa+eGB/2aGw6900XpXLHO/9ISEHfzt?=
 =?iso-8859-1?Q?lQkdILAqV/d8XHlouaACU2lEuzVw/E2sF7lVDTo5bpjMvk?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bfaaba43-549d-4df6-bea8-08df18cb4da6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 17:02:36.9865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BJYFAjl1DUQjSbpvKFnXi43S3uQ1Ce2OhogCcOtfqeu3UoEvOnTxGyQbnDBLLFsc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4098

AMD General

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
