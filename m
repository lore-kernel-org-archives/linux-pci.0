Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020073.outbound.protection.outlook.com [52.101.193.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E903947A6;
	Fri, 13 Mar 2026 16:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773420509; cv=fail; b=cU9YmIKYa2uGx+Gv0eouGm4NWiVEk9hUT+KLXqq6vCbSJWsSxjAJtvSPhOpOwpa0WPFreO0ivdRsGlcEJ4VshxzsXLX1Hv9SQOrcnAv9vu815kXa+gjL/b7+QCbwN4DLrlLf9eH/xaVVRkV/XMjWrKg4RIrD7Lo95a6P8cIN4vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773420509; c=relaxed/simple;
	bh=CHc9F+cGiEagHAeRBYTKcr0YIZ7xmmP9g5X9SO3PJ/s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rNOfI7p19M80QZUyQfyCyEnd4x/XZGbwzyPA2ioqAzx9cMqFerru+iOPsnrQvNXyHmBl3cHgqt7XqgTgV6IuX10B6F9b13KUr/jdCob3wQmJL9tsqH2uuAAWNIxqV/XO/VNjGqHZVTWWOzC8EelpwFgdGi2s4LzFbPCDwunwCzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=asteralabs.com; spf=pass smtp.mailfrom=asteralabs.com; dkim=pass (1024-bit key) header.d=asteralabs.com header.i=@asteralabs.com header.b=ONzpMU7H; arc=fail smtp.client-ip=52.101.193.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=asteralabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asteralabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=asteralabs.com header.i=@asteralabs.com header.b="ONzpMU7H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+Yajuq4g2ry6WW9d4z+xZK/2uyWsumEpCnOKWtivPuMP3V+tBNzngPQP+9rp7yGbFezntFbpGoewqub9XJrREwpOqcanLR/O1UBJuwWPeZ4n2JcPMiCQbzJKBRPba+BHL9NBKlBA+KlnSfo+e4H4AcfcRB6ewaiYx+agsvn3OCDFn3gsAi8eQSzXW5GiVvH0YaUEEGqK9GnZZoFTraIx90bV6sEHYmm9ZXHr1kPRROYaJZI9jDVF9bQ2N8kkRSbRPYeeBXu5fJC70Wi9V1ONzHLcROtNJTiDUnJGc/gI4TvSCDj+93YKkYzRweuNx2CYGIkj5yqcFXW7enM/+fSsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4diDjN6BmTyjTdMIPJ87QfGpDgyfCzE+BVgQnoHb76w=;
 b=FUMVKrVIH2AB0mgXNHcFVKd34jrq7ncLR6Qg+6nDN6ECckdOIUsCyHO3zFnIjo9nR9FCQlxKFUcJqJjvhzDusnFXhBwvNXJ7HBluSWzPf8Zi8pqBPMBjl7SR7pPhjsN+FiX0UCKM8HrcRrcyFTyyJcry/61bDxuKHk8l+DTREFkNrK3P+XJ3Vxb7jtQzNybqhsIuk7lilSyAzsTMv5CzCwdyEqzvAFxBmBjHsROV+rPvKkqI1ZT+x189qpmt7imGKX5JiKNcenbmv6+rNJvouNxcbEPqgILJkeQpSTbl1VJvHfbBxAXUY9P/cDu7KrkezB/+sCarsVc3BmIZzbCUkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=asteralabs.com; dmarc=pass action=none
 header.from=asteralabs.com; dkim=pass header.d=asteralabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asteralabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4diDjN6BmTyjTdMIPJ87QfGpDgyfCzE+BVgQnoHb76w=;
 b=ONzpMU7He9zv0jJlN0uVnsBbEzsu/Hd9S8xtzwVehiNZRVXcE7VBlvwCrREzBjYhvVArLhS7JWbUNVJJP037yb8+nNDjMaSgooOmDIFy+xspBLvwG0V5ZFx8joMRJFhzay9FVCdSoeEA/6rBoyrtz6N1Sor7agCeO0ESc0dSYRk=
Received: from LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:232::17)
 by LV9P221MB2218.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:2f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.17; Fri, 13 Mar
 2026 16:48:24 +0000
Received: from LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM
 ([fe80::b063:29f1:a2f5:e3fb]) by LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM
 ([fe80::b063:29f1:a2f5:e3fb%4]) with mapi id 15.20.9700.010; Fri, 13 Mar 2026
 16:48:23 +0000
From: Shawn Jin <shawn.jin@asteralabs.com>
To: =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [BUG] PCIe bridge resource allocation creates invalid limit
 addresses after Secondary Bus Reset recovery
Thread-Topic: [BUG] PCIe bridge resource allocation creates invalid limit
 addresses after Secondary Bus Reset recovery
Thread-Index:
 AQHcsZ3eHE22fwsOREepAuj/YABaYbWp99mAgAALDviAABAm9oAA0NIAgAA+csGAAAtQAIABfByp
Date: Fri, 13 Mar 2026 16:48:23 +0000
Message-ID:
 <LV8P221MB147282D317C952564A739B369945A@LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM>
References:
 <LV8P221MB1472A24B9975F7C8E8D6BF929947A@LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM>
 <20260311231943.GA1086074@bhelgaas>
 <LV8P221MB147241DCED82480888F8D73D9947A@LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM>
 <LV8P221MB14726A1B6959675557ED1AC29944A@LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM>
 <a128f2d6-4311-a9a3-5e10-267f46db709e@linux.intel.com>
 <LV8P221MB14722013ED06CFDD3AFF161E9944A@LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM>
 <885ad11d-cf87-d926-41c1-65ad16968bc8@linux.intel.com>
In-Reply-To: <885ad11d-cf87-d926-41c1-65ad16968bc8@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_864d6687-5155-4a0e-a628-49dd428607fb_Enabled=True;MSIP_Label_864d6687-5155-4a0e-a628-49dd428607fb_SiteId=f47c88fd-08a9-4016-b488-3f361c03ff2e;MSIP_Label_864d6687-5155-4a0e-a628-49dd428607fb_SetDate=2026-03-13T16:48:22.247Z;MSIP_Label_864d6687-5155-4a0e-a628-49dd428607fb_Name=Internal;MSIP_Label_864d6687-5155-4a0e-a628-49dd428607fb_ContentBits=1;MSIP_Label_864d6687-5155-4a0e-a628-49dd428607fb_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=asteralabs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8P221MB1472:EE_|LV9P221MB2218:EE_
x-ms-office365-filtering-correlation-id: a0282de3-7cce-4e90-0794-08de81205723
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|18002099003|22082099003|56012099003|55112099003;
x-microsoft-antispam-message-info:
 HrcTW3/PJADXiVR8J3ku0fh5faQbI5WuEKC+clyS/H+9TDuUsviWqjtQeeeHUOJw5n1SH2TdlDHIQDEF4cOSrr+E7lh4xYObBYJaAfa/U8XD3dtzh2SAp+ZjQP4DsVPBMWz/Y9S4i5MIS/+w+S4iJRnYv5DwWT8qi5r3rAknZncqqQrkOWyWwNG4RnV+122qvBKtJBj6Ej/p3VaAvMHxdpU2V+40wpaJNp1hnYqfI+5prXlqQs/LPovjrsCe30PG0XuUiJUoJovCv9gpeL1K3oEpgyPhcBWk5BmLewU63WfwpNsOujUmurqIjqlV7pNOVlwIovqE5wCIdWxSIC1ppRlE7I4oSyKzp31DYaSMYl1tg4YCWeUhnN9Ds1VvGXIlnIZcm104kdTgA5ZjFBQggzybfpoDFyg5zwNGIpyDj/14uBBash/5FUut7/rwq+QTqtLcdDEO50kvRQqw+i8eb6bch8T9RLJK5ZG8wywUGmjtQJzUCe7/aK+ML3N0cDS2WV6EwZ2vTELHPGsxHFqAjBAVXNsrZGtNClk7ey2FltCQWwzQOSmY5fGa3i89mD58SkEjkAhPpDBGHicLjNMaCOrvCWMZGFx3b13vrsB/oEK3dankbZrMwne/ujPUksvwo+PFpyRfS2ZUt9krP/yeRiMVjCfLCU0luBGKVoX57Ol5yEnuyRaspUkKw8Muv5StjyQ+trdlAHwVXKjCYmaUEW6HniLI8nxJ0OCGUIKYIhgS5euVudr0djlW8CEbMo2MRQL1xBn1w0Ux1HCeYX3/+SqGnPCFobvFbxdHwmJBp7c=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(18002099003)(22082099003)(56012099003)(55112099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?igHYBEF9Mxnbes6wSeIRO14AomvnF/xVOTv72RiyML/MFjuHTk14spq89X?=
 =?iso-8859-1?Q?FqEgBCMBMw0UPYcq+jvqvSdjOz4qtX3oxDMAzostn2BY8tXMmOGFJk9pBX?=
 =?iso-8859-1?Q?6A+I9pM45+v3wfeZbORBjH+JtWTv4PN2WY47t+Jg6P2M4rOPD3lIQVpVc6?=
 =?iso-8859-1?Q?QmMdAeupsYX1lbxyO1xxnKX760YdPilQN/USlwg3X7TqhqLg7coCsHn7OE?=
 =?iso-8859-1?Q?YAmZIb93gGg+Xl7VLPKLmcaNVj7ug6xkI3dKhCMJ77jFrbvutkJnKmDR3J?=
 =?iso-8859-1?Q?EmUkjgVs2gyiBL/S2DtBXqBe5Xa5rqn3Sbg8mk7UOGfW9eQV0V8h382AA3?=
 =?iso-8859-1?Q?lPbohqMrB2jqAc4PsD0wN7fAGH3filwGNskKSQk2ACS6ybO0Q6Nsp82mhB?=
 =?iso-8859-1?Q?2wpQ4Kc/HgRdN7nQFouxobtYnS96WrkOpv7Im7sC4hrBZ82xUcRAlSsc/P?=
 =?iso-8859-1?Q?bAAonHbU8vlMcIghlNsqsR2fyaK2WJuONu5TrGi3H3cBv10/wSK6PTVEnU?=
 =?iso-8859-1?Q?Nj3DSs6SLRfiBks5kO2QQenDqHD69Q+G5Dw69NSUMQu2dHVgFu2N49QFap?=
 =?iso-8859-1?Q?s4OysKxrapJ1CfYRDhtZzgzT/5QjYGWWwnrOVm+4aQw0o/ulQB7pTy1kmB?=
 =?iso-8859-1?Q?vV1fWPn7ulvE7kHazDjTu5pUkT//D1gpRbqJp7oJUaBqJzK0DPj/j2zr96?=
 =?iso-8859-1?Q?xdOA9ql9VZ1L8JNAMoZwvEM7muJal7EkiJKeeCuIelYvbtGONDPxiz5puj?=
 =?iso-8859-1?Q?hp/kifvOsaPE8bUwGI7cDkRHm/JisjJM+TR0vInovoEeeLScQV0pP7JT5p?=
 =?iso-8859-1?Q?jFkA0e9llRbTIzMWg+MaHn9QflovxbPq8z10qQkhc4U4gNn/iGFtvhnUun?=
 =?iso-8859-1?Q?ETYTqS/RK8jJ+yFxUvu2NyZLP7sFLA3VvlW0UgZn66G51nckFb2X1dZN6G?=
 =?iso-8859-1?Q?wN9g7tdPVTH36v3YsO4bAwGJzbc5IvTsUSRKCGT/SIeLJWRwfDhXvzYuao?=
 =?iso-8859-1?Q?xo79Zuj8WksR7998WYRDz9I2k+ffrjPHMkpjGMgiRe2AMdnsSu26Pt6bfx?=
 =?iso-8859-1?Q?PRif5FOdisHKtjmcfVuNqc1qC08x2B/Z/0BgzbRqj38Q55QJaNG1oI3RGH?=
 =?iso-8859-1?Q?Fak6rjT1IBydaMtchZks9tWZcpoMxJ8n1CMU6fAXK0P96UvIu0M450uJzN?=
 =?iso-8859-1?Q?ILm35DzRah2G6szV2pg5yxYon33Vel8HefrDPhPMTy5iwNQP2ifAaNV1oO?=
 =?iso-8859-1?Q?BYm+D0pqZuCil6ZytIL6uQO5II8tE8qt3A4/PvNxvNkScJjhv9X/mfQnQP?=
 =?iso-8859-1?Q?jP7eFlFK4I3Ix9AOJ8K30Q/E+V2t9+ZpTuMvj3jJkWg4V/15e9p9qr3cbo?=
 =?iso-8859-1?Q?py0pbPF9jzOsUImUoHF+CQWGs2tqJq0dJApPYMjACsB06frsUJwDDYWhIY?=
 =?iso-8859-1?Q?vst/OAe6r2Ik5HGdILv3AjDYTNXYq7CGn4VhkP/CBoP1Yx+kM1ayovOB+r?=
 =?iso-8859-1?Q?muG8YzFHA8SEXKngOjhYwfzE1so9PYL+Td5T5TI1B6r8WXJrZQGhxIMi5l?=
 =?iso-8859-1?Q?5BTmsT3x75h7Et8rNMKatQ1tUhHmG4e6qaN6w3Gbn1JdfqLkPww691w8SD?=
 =?iso-8859-1?Q?XnMQCh95VZhZUGDgMQnsN+IuGJTQ0Ytc6cBTas0q5U82mG2C1Z6V33POb0?=
 =?iso-8859-1?Q?IsBN+uZjXVnRmlrMRdT3FHfqv8Kb6adQJETSuHR2vphOC1tSmtH3ZGVkYY?=
 =?iso-8859-1?Q?hpoFJVIBqoyQcAmxl0JUYaGeW8WI1CLvGP876WpjUepaAV56BPzX6AQa12?=
 =?iso-8859-1?Q?qALTNK9OtQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: asteralabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a0282de3-7cce-4e90-0794-08de81205723
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 16:48:23.3397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f47c88fd-08a9-4016-b488-3f361c03ff2e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /OT+0Uu8QvwzaQdRLvfq1yGN4v3DRLVr6R44aN7tyNPBASR0vmsgWARSH/gtPrhAu6kdldU7i4xEli2aD4607vfiw8YBhIC8ASpZPgMJ+6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9P221MB2218

Hi Ilpo and Bjorn,

A quick update on the test result with the kernel 6.19.6-1-default in openS=
USE Tumbleweed.

Summary:
1. With PCI realloc off, the bridge windows were reassigned as before, the =
ending addresses look normal, all ending with 0xffff.
2. With PCI realloc on, the non-pref window ending address is still incorre=
ct: 0xe1a55554. But the pref window looks right.
[  482.943430] [   T1435] pci 0000:99:01.0: bridge window [mem 0x1340000000=
00-0x1347ffffffff 64bit pref]: assigned
[  482.943431] [   T1435] pci 0000:99:01.0: bridge window [mem 0xe1a00000-0=
xe1a55554]: assigned

Details:
Focused topology:
-[0000:94]---01.0-[95-9e]----00.0-[96-9e]----01.0-[98-9c]----00.0-[99-9c]--=
+-00.0-[9a]--
                                                                           =
+-01.0-[9b]----00.0  Device 1e3e:0002
                                                                           =
\-02.0-[9c]--
Test 1: realloc OFF
// Cold boot
[    2.132565] [      T1] pci 0000:99:00.0: PCI bridge to [bus 9a]
[    2.133202] [      T1] pci 0000:99:01.0: PCI bridge to [bus 9b]
[    2.133413] [      T1] pci 0000:99:01.0:   bridge window [mem 0xe9600000=
-0xe96fffff]
[    2.133555] [      T1] pci 0000:99:01.0:   bridge window [mem 0x13b00000=
0000-0x13b7ffffffff 64bit pref]
[    2.133827] [      T1] pci 0000:99:02.0: PCI bridge to [bus 9c]
[    2.134453] [      T1] pci 0000:98:00.0: PCI bridge to [bus 99-9c]
[    2.134565] [      T1] pci 0000:98:00.0:   bridge window [mem 0xe9600000=
-0xe96fffff]
[    2.134647] [      T1] pci 0000:98:00.0:   bridge window [mem 0x13b00000=
0000-0x13b7ffffffff 64bit pref]
[    2.134809] [      T1] pci 0000:96:01.0: PCI bridge to [bus 98-9c]
[    2.134830] [      T1] pci 0000:96:01.0:   bridge window [mem 0xe9600000=
-0xe96fffff]
[    2.134845] [      T1] pci 0000:96:01.0:   bridge window [mem 0x13b00000=
0000-0x13b7ffffffff 64bit pref]
// after SBR
[  202.341320] [   T1430] pci 0000:99:01.0: PCI bridge to [bus 9b]
[  202.341539] [   T1430] pci 0000:99:01.0:   bridge window [mem 0xe9600000=
-0xe96fffff]
[  202.341680] [   T1430] pci 0000:99:01.0:   bridge window [mem 0x13b00000=
0000-0x13b7ffffffff 64bit pref]
[  202.341950] [   T1430] pci 0000:99:02.0: PCI bridge to [bus 9c]
[  202.342573] [   T1430] pci 0000:98:00.0: PCI bridge to [bus 99-9c]
[  202.342685] [   T1430] pci 0000:98:00.0:   bridge window [mem 0xe9600000=
-0xe96fffff]
[  202.342766] [   T1430] pci 0000:98:00.0:   bridge window [mem 0x13b00000=
0000-0x13b7ffffffff 64bit pref]
[  202.342929] [   T1430] pcieport 0000:96:01.0: PCI bridge to [bus 98-9c]
[  202.342951] [   T1430] pcieport 0000:96:01.0:   bridge window [mem 0xe96=
00000-0xe96fffff]
[  202.342964] [   T1430] pcieport 0000:96:01.0:   bridge window [mem 0x13b=
000000000-0x13b7ffffffff 64bit pref]

// although the bridges don't have IO windows, the dbg message showing the =
window extension may be a bit worrisome.
[  202.340536] [   T1430] pci 0000:99:00.0: bridge window [io  size 0x0000 =
disabled] extended by 0x0000000000000555
[  202.340538] [   T1430] pci 0000:99:01.0: bridge window [io  size 0x0000 =
disabled] extended by 0x0000000000000555
[  202.340538] [   T1430] pci 0000:99:02.0: bridge window [io  size 0x0000 =
disabled] extended by 0x0000000000000555

Test 2: realloc ON
// code boot
[    2.146003] [      T1] pci_bus 0000:96: resource 1 [mem 0xe1800000-0xe1d=
fffff]
[    2.146004] [      T1] pci_bus 0000:96: resource 2 [mem 0x134000000000-0=
x1348004fffff 64bit pref]
[    2.146007] [      T1] pci_bus 0000:98: resource 0 [io  size 0x1000]
[    2.146008] [      T1] pci_bus 0000:98: resource 1 [mem 0xe1a00000-0xe1b=
fffff]
[    2.146009] [      T1] pci_bus 0000:98: resource 2 [mem 0x134000000000-0=
x1347ffffffff 64bit pref]
[    2.146010] [      T1] pci_bus 0000:99: resource 1 [mem 0xe1a00000-0xe1a=
fffff]
[    2.146011] [      T1] pci_bus 0000:99: resource 2 [mem 0x134000000000-0=
x1347ffffffff 64bit pref]
[    2.146012] [      T1] pci_bus 0000:9b: resource 1 [mem 0xe1a00000-0xe1a=
fffff]
[    2.146013] [      T1] pci_bus 0000:9b: resource 2 [mem 0x134000000000-0=
x1347ffffffff 64bit pref]

// after SBR
// USP 98:00.0's windows still look correct
[  482.943427] [   T1435] pci 0000:98:00.0: bridge window [mem 0x1340000000=
00-0x1347ffffffff 64bit pref]: assigned
[  482.943429] [   T1435] pci 0000:98:00.0: bridge window [mem 0xe1a00000-0=
xe1bfffff]: assigned
// DSP 99:01.0 pref window is good
[  482.943430] [   T1435] pci 0000:99:01.0: bridge window [mem 0x1340000000=
00-0x1347ffffffff 64bit pref]: assigned
// DSP 99:01.0 non-pref window ending addr is wrong: 0xe1a55554
[  482.943431] [   T1435] pci 0000:99:01.0: bridge window [mem 0xe1a00000-0=
xe1a55554]: assigned
[  482.943432] [   T1435] pci 0000:99:00.0: PCI bridge to [bus 9a]
[  482.944063] [   T1435] pci 0000:9b:00.0: BAR 0 [mem 0x134000000000-0x134=
7ffffffff 64bit pref]: assigned
[  482.944164] [   T1435] pci 0000:9b:00.0: BAR 2 [mem 0xe1a00000-0xe1a3fff=
f]: assigned
[  482.944202] [   T1435] pci 0000:99:01.0: PCI bridge to [bus 9b]
[  482.944424] [   T1435] pci 0000:99:01.0:   bridge window [mem 0xe1a00000=
-0xe1a55554]
[  482.944565] [   T1435] pci 0000:99:01.0:   bridge window [mem 0x13400000=
0000-0x1347ffffffff 64bit pref]
[  482.944837] [   T1435] pci 0000:99:02.0: PCI bridge to [bus 9c]
[  482.945463] [   T1435] pci 0000:98:00.0: PCI bridge to [bus 99-9c]
[  482.945575] [   T1435] pci 0000:98:00.0:   bridge window [mem 0xe1a00000=
-0xe1bfffff]
[  482.945657] [   T1435] pci 0000:98:00.0:   bridge window [mem 0x13400000=
0000-0x1347ffffffff 64bit pref]
[  482.945820] [   T1435] pcieport 0000:96:01.0: PCI bridge to [bus 98-9c]
[  482.945842] [   T1435] pcieport 0000:96:01.0:   bridge window [mem 0xe1a=
00000-0xe1bfffff]
[  482.945856] [   T1435] pcieport 0000:96:01.0:   bridge window [mem 0x134=
000000000-0x1347ffffffff 64bit pref]
[  482.945883] [   T1435] PCI: No. 2 try to assign unassigned res
[  482.945885] [   T1435] pci 0000:99:00.0: disabling bridge window [mem si=
ze 0x00000000 64bit pref disabled] to [bus 9a] (unused)
// DSP 99:00.0 doesn't have any EP attached. But the mem size 0x55555 looks=
 very suspicious.
[  482.945886] [   T1435] pci 0000:99:00.0: disabling bridge window [mem si=
ze 0x00055555 disabled] to [bus 9a] (unused)
[  482.945887] [   T1435] pci 0000:99:02.0: disabling bridge window [mem si=
ze 0x00000000 64bit pref disabled] to [bus 9c] (unused)
// Same for DSP 99:02.0
[  482.945888] [   T1435] pci 0000:99:02.0: disabling bridge window [mem si=
ze 0x00055555 disabled] to [bus 9c] (unused)

Hope the above info gives you some hints.

Thanks,
Shawn.
________________________________________
From: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
Sent: Thursday, March 12, 2026 10:48 AM
To: Shawn Jin <shawn.jin@asteralabs.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>; Bjorn Helgaas <bhelgaas@google.com>=
; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-pci@vg=
er.kernel.org <linux-pci@vger.kernel.org>
Subject: Re: [BUG] PCIe bridge resource allocation creates invalid limit ad=
dresses after Secondary Bus Reset recovery

[EXTERNAL EMAIL]

On Thu, 12 Mar 2026, Shawn Jin wrote:

> Hi Ilpo,
>
> Thanks for looking into the issue. Just a quick question. So the patch
> you linked and the patch you attached is for the latest kernel, not 6.8.
> Right? I'll try to install the latest kernel first and rerun my test and
> keep you updated.

Yes, they are for the latest trees but I can look into backporting them if
needed.

--
 i.

> ________________________________________
> From: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Sent: Thursday, March 12, 2026 6:24 AM
> To: Shawn Jin <shawn.jin@asteralabs.com>
> Cc: Bjorn Helgaas <helgaas@kernel.org>; Bjorn Helgaas <bhelgaas@google.co=
m>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-pci@=
vger.kernel.org <linux-pci@vger.kernel.org>
> Subject: Re: [BUG] PCIe bridge resource allocation creates invalid limit =
addresses after Secondary Bus Reset recovery
>
> [EXTERNAL EMAIL]
>
> Hi,
> First of all, many of the changes related to this additional resource
> distribution do not really make sense to me.
>
> There's one fix that tries to rectify to most gross wrongness in the
> adjustment itself because it caused a regression (not yet applied):
>
> https://lore.kernel.org/linux-pci/20260219153951.68869-1-ilpo.jarvinen@li=
nux.intel.com/
>
> It probably doesn't address the bug you see here though it may hide it.
>
> > [  796.604869] pcieport 0000:96:01.0: distributing available resources
> > [  796.604872] pci 0000:98:00.0: bridge window [mem 0x00100000-0x001fff=
ff] extended by 0x0000000000100000
> > [  796.604876] pci 0000:99:00.0: bridge window [??? 0x00000000 flags 0x=
0] extended by 0x0000000000055555
> > [  796.604880] pci 0000:99:01.0: bridge window [mem 0x00100000-0x001fff=
ff] shrunken by 0x00000000000aaaac
> > [  796.604883] pci 0000:99:01.0: bridge window [mem 0x800000000-0xfffff=
ffff 64bit pref] shrunken by 0x0000000000000001
> > [  796.604886] pci 0000:99:02.0: bridge window [??? 0x00000000 flags 0x=
0] extended by 0x0000000000055555
>
> Note how it's not just -1 that seems wrong, the other numbers too seem
> non-round (to 1M) as well.
>
> There seems to be a number of problems with this entire algorithm.
> I think the -1 comes from remove_dev_resource() that is called for a
> resource which does have !res->flags (+ res->start=3Dres->end=3D0 ->
> resource_size(res) =3D=3D 1).
>
> So could you please try the patch below.
>
> Not that the fix makes everything okay IMO but perhaps it addresses this
> particular case. It's not even clear to me how some of the cases with not
> valid bridge windows should be dealt with while distributing the
> additional memory between the bridges.
>
> The 55555 cases probably come from align =3D=3D 0 which makes
> ALIGN_DOWN_IF_NONZERO() to produce non-aligning sizes. The fix patch belo=
w
> might address it.
>
> I don't (yet) understand how that aaaac came to be, I suppose it somehow
> relates to this doing something unexpected so if you want to check that
> out, it would be helpful:
>                 align =3D pci_resource_alignment(bridge, res);
>                 if (!resource_assigned(res) && align)
>                         available[i].start =3D min(ALIGN(available[i].sta=
rt, align),
>                                                  available[i].end + 1);
>
> Another option is remove_dev_resource() doing something that leads to it.
>
> It might be worth adding debug traps for available[i] getting non-1M
> aligned but it's not very clear to me how and where.
>
> From: =3D?UTF-8?q?Ilpo=3D20J=3DC3=3DA4rvinen?=3D <ilpo.jarvinen@linux.int=
el.com>
> Date: Thu, 12 Mar 2026 14:59:43 +0200
> Subject: [PATCH 1/1] PCI: Skip not valid bridge windows while distributin=
g
>  resources
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> pci_bus_distribute_available_resources() distributes available
> resources between downstream bridges, however, it does not take
> into account cases where a bridge window is not valid.
>
> Skip touching bridge windows that are not valid.
>
> Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/pci/setup-bus.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 61f769aaa2f6..4fcb5e0c44b4 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1868,6 +1868,9 @@ static void remove_dev_resource(struct resource *av=
ail, struct pci_dev *dev,
>  {
>         resource_size_t size, align, tmp;
>
> +       if (!res->flags)
> +               return;
> +
>         size =3D resource_size(res);
>         if (!size)
>                 return;
> @@ -1922,6 +1925,8 @@ static void pci_bus_distribute_available_resources(=
struct pci_bus *bus,
>                 available[i] =3D available_in[i];
> +               if (!res->flags)
> +                       continue;
>                 /*
>                  * The alignment of this bridge is yet to be considered,
>                  * hence it must be done now before extending its bridge
> @@ -1993,6 +1998,8 @@ static void pci_bus_distribute_available_resources(=
struct pci_bus *bus,
>                 for (i =3D 0; i < PCI_P2P_BRIDGE_RESOURCE_NUM; i++) {
>                         res =3D pci_resource_n(dev, PCI_BRIDGE_RESOURCES =
+ i);
>
> +                       if (!res->flags)
> +                               continue;
>                         /*
>                          * Make sure the split resource space is properly
>                          * aligned for bridge windows (align it down to
> base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> --
> 2.39.5
>
