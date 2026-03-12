Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021114.outbound.protection.outlook.com [40.93.194.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA720846A;
	Thu, 12 Mar 2026 01:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773277408; cv=fail; b=jNzOWKAAljJv1IcNx9FOcN5d92RFn1vRAf+TWDS+9e9lV3K3psh2dCE8kbRL0IdYP48hwcT9Yuj18JYVQoVSsXeRIj7mULQ5L4NHu3VYtSG+dEHOqdECwFSOFxFih/OoPBM0W0iIflrlWCuLSFeqPrmbAj2wp7IT4mHtndRybkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773277408; c=relaxed/simple;
	bh=CN5TbR/Bv/iIO9AA+i3Jr+igBPv1ZWgDxcyJZ5NNlbE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=llvEvlZVxyPNudYq/xVqtP7ol4DzI91lYunfP0S6TDOswkoApR2tLOiUtIlBVDHlPaWr1If9Hcky6/AXA5vkQcik+P+BZafON6G42NhK0riF5pQlKeIOgC/0LX84T1Gg2QIhdw/31rdc81wSk378DV+3W2zXqhfU8i1HC8bn2hM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=asteralabs.com; spf=pass smtp.mailfrom=asteralabs.com; dkim=pass (1024-bit key) header.d=asteralabs.com header.i=@asteralabs.com header.b=JEiXmUzL; arc=fail smtp.client-ip=40.93.194.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=asteralabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asteralabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=asteralabs.com header.i=@asteralabs.com header.b="JEiXmUzL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ejw85FhHmUKv9xsuJsWJ8AYV9Jxn8t9fmWrAOwv2QDxU2TD/2oiI/jMIw93/J5AuQ8XQQ5aWvzX/tkzlhuahCupW0xn8txNtSIxabtj5dBGlALVXvpz4gvUzXTP/10Jt0qU2xptoAHaKHN4dtt7KljjOtsRTAXCJtOdsoWqV3weRz7qJYr+9FyJrWdOK4mB53zksBL2oHCquePxz2Ri1LLbJ3yPCqJtjtrhj1uHJT6kAno2UmowRltWBZ33y6vlDeGXf6APpozTuA6k5nkUykv4vZtSl2n6wL+vXBlIoXKYBFDZ+LiTxkjXh0t44uCIk0h3qGYNYPTLf/fuXcYCYWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=viwA1/zysL0IOmtDG8t6RimnLpV4E9jdg3ztGBx355E=;
 b=YQwQ7/1+8XXO5yecD5gbGJ+Lf64pkOXqSA4vDi92W2y06XiFQnR5ZsJf8fh6088kH5IzqNDjD1ln5Y2RFQxG6FNL9mnxEiyOwj0OVa61IkXQiR12Q8NGL8Kov5EV45GjNqw+mzBOh15KIHM1ovkBjHVwG4Qu0mWK5smzhLwZ2zQRTQeRN/D7rP5KXpUi5cgwJftfzWVZ+FIGPYmluKJ9M8g8Dpnte2Mm8cQ/yLQbQgSMcnfjrdZnAEAc2TAElbEPUMIwwon6EJO+82mje9DYd4WItU8Dj1N73iGoGNq2+QiwlgBCmcR/zaoQzrOOixeQpCAwYH89klOxRRREGg2wuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=asteralabs.com; dmarc=pass action=none
 header.from=asteralabs.com; dkim=pass header.d=asteralabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asteralabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=viwA1/zysL0IOmtDG8t6RimnLpV4E9jdg3ztGBx355E=;
 b=JEiXmUzLcXpfXZ4NcYGieWkBRBy9eZ+zDaCdxU71AFiEptOe/OwaHnkYt51NeYvdLekKs9kWQzdLXMICTG4vMOQLKR+9woGbKx733oRoKl6bixkLFnMW1dXyWMQ3dsms7QEukE834r5qKT3uoRerFyPOjBS/GwiffKidTm95ORg=
Received: from LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:232::17)
 by PH3PPF12FA9AFC9.NAMP221.PROD.OUTLOOK.COM (2603:10b6:518:1::58b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 01:03:23 +0000
Received: from LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM
 ([fe80::b063:29f1:a2f5:e3fb]) by LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM
 ([fe80::b063:29f1:a2f5:e3fb%4]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 01:03:23 +0000
From: Shawn Jin <shawn.jin@asteralabs.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, =?iso-8859-1?Q?Ilpo_J=E4rvinen?=
	<ilpo.jarvinen@linux.intel.com>
Subject: Re: [BUG] PCIe bridge resource allocation creates invalid limit
 addresses after Secondary Bus Reset recovery
Thread-Topic: [BUG] PCIe bridge resource allocation creates invalid limit
 addresses after Secondary Bus Reset recovery
Thread-Index: AQHcsZ3eHE22fwsOREepAuj/YABaYbWp99mAgAALDviAABAm9g==
Date: Thu, 12 Mar 2026 01:03:22 +0000
Message-ID:
 <LV8P221MB14726A1B6959675557ED1AC29944A@LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM>
References:
 <LV8P221MB1472A24B9975F7C8E8D6BF929947A@LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM>
 <20260311231943.GA1086074@bhelgaas>
 <LV8P221MB147241DCED82480888F8D73D9947A@LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM>
In-Reply-To:
 <LV8P221MB147241DCED82480888F8D73D9947A@LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_864d6687-5155-4a0e-a628-49dd428607fb_Enabled=True;MSIP_Label_864d6687-5155-4a0e-a628-49dd428607fb_SiteId=f47c88fd-08a9-4016-b488-3f361c03ff2e;MSIP_Label_864d6687-5155-4a0e-a628-49dd428607fb_SetDate=2026-03-12T01:03:22.375Z;MSIP_Label_864d6687-5155-4a0e-a628-49dd428607fb_Name=Internal;MSIP_Label_864d6687-5155-4a0e-a628-49dd428607fb_ContentBits=1;MSIP_Label_864d6687-5155-4a0e-a628-49dd428607fb_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=asteralabs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8P221MB1472:EE_|PH3PPF12FA9AFC9:EE_
x-ms-office365-filtering-correlation-id: 1e7becee-7ba6-4e46-270b-08de7fd328a1
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|55112099003|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 FESn0oE4N1EDbUKfrn6FXmiPR3Zrgio15Pl2u/D8yTPNmRuvshPqTGNv8v03CyK+R1PkUDkz/yDC9h9fv+azwyFA9BUNp2PuhZNwMLAs1RTwznAb6e8+yEWblL4CGJyy3/cNMFjxPe7o/WxzmrRRFzN6ZagwPqxgWmBXOv0VfejGjsqkBE4pd7qqgqdMXTp6opa9miynNLZoDF/MAGpfvQJ7opG9+VJtalbdXd+cojeFsXRvH5zJyVAeWgM8DTxnmMp1D065g6Nwy/ZhyfGFNg5wF5E5Yv3BwD5CtJ1XY59KaGKyXzA/gYMK/mv+tmGwto0FEyo6Plk08UFvo2tLy7mnbcO/7bqrmTUvXIehWiDSRlwezxa6z3QTvQjNQgAv4sqSyKFhY/i0H0V4EaBPBRvqnh4pawT8kBG/MC4lnHUy6AzmMvCJPs0PNUubLXmQFwSlfUrUThmqd0yr3stWqr9jixj/85FnpK2oI8nif4FpdY0C7bwQYmvI2G8R/5Fzo9N6BlSJZ5NhisKuzeqAfFNfVXFM7RJ42AukUDfSJPvVmBIRMMGDJvEvQEMsJ+8AyLLFtupbpgMxLBjWD9CbAMd+Lfe2KSJ5VKKRuMHAI40u5PjARrzFrMjXzFMNBdc6nsvXiGJdzMwZ9FBLZhCL3bwfeEex+IvQqbUtrMD6O3vSCF0C0yXzMWA+yQqLg57eVvRx8XouXVZumtZUmLYV7TRqAPoJb70IB9wPvjyL1xNbQJEGaWoZQGVzeQi4JVACaN9TNjb96R0UG6rBxC97lUFcscmyJj2Hi8GnnjUSZFs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(55112099003)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?bI3+w6FibbslC4khjiTsbSfP96b+ZzTMSwYWyDwMIAodhTHuW0MnBTv8nm?=
 =?iso-8859-1?Q?XrZj8vkmALNDa6eO1/tfMO6rPathNCtrFM70GjKOzuX0c+j/Ub9BxwcSJT?=
 =?iso-8859-1?Q?tUklmoGSZU+UbDObp178T88zW5xb7ZTAvbLedavyJf0MuutovFVvCP/qfK?=
 =?iso-8859-1?Q?nLio6X4sGIrjrd8PywBYCnt3fIXOPpaUVrtJUpPxwSaDPS9aH2QFhyhhGl?=
 =?iso-8859-1?Q?q7XmoSgRnzJ5KKex8BSg+DqcXZDWTlgISUeJm0EleZnl7DKsTO6KIeHxbz?=
 =?iso-8859-1?Q?BTupm+TNsh/V2vFNXOjqt29WNnz70O/aaZX2BH9gqtlBhBb/I6/4l9Bhg9?=
 =?iso-8859-1?Q?EV4qqrm6dm0vUjlfKl1CSyZZqU3q8FzSTdDvlu8eCjaevw+YQ42ElmUaHn?=
 =?iso-8859-1?Q?s77axwILPeF3t7O4XbJU3VIaXde950W/BcGMQFq2TMQBvq2PrdvCiir98z?=
 =?iso-8859-1?Q?iAYsdQTYue5c0m/82vqZoeqCBwnTqdPCJNcBWz0z3PlCw8GyGq8cd12xDu?=
 =?iso-8859-1?Q?ArLJwTX+aDZdgnOPpXH3Hyj5HqPK6zeJpGuPvZPlO1UmRU++Sh0qUl82HA?=
 =?iso-8859-1?Q?ZKg+DvQ9m0lhfTVo6vMgUt+XP9fm/gSEl4RotRSIqdRJ4YXcldFr2JRW1y?=
 =?iso-8859-1?Q?ItduIbSyKpAs5Ob9HoKAwlMUHja8o2VzFlqY877X88FpE7jBywWILKURmS?=
 =?iso-8859-1?Q?il/hcCWg63YioouGfi2dEw2t/rSSUiwwHb2Mo0jmQaGcn7B/YoBucUaT+w?=
 =?iso-8859-1?Q?qp9uEDOpiRKqsgM7BEr9NM7gJZz4N3KZjxUk8w94AD5jP/iI5ssnXA+GIx?=
 =?iso-8859-1?Q?ksMLpCeUa7QoM0ZP915ZnJP3j4hMCeMI7Oj11AyRPL7MIXRyUsyCNbzuMr?=
 =?iso-8859-1?Q?4B/POWVvqEfJvZSOiBo8c2JDgoyuRBq8hVnqg52k+0FJfEFgxYz5mXZQpX?=
 =?iso-8859-1?Q?ZYFcdvxq8Q+3726a5RlJZcSlE4uG8mx/aPKVUdQvW+RpVHt7LJrcWLsOBk?=
 =?iso-8859-1?Q?DAUVxiJ9NmBxiQVgEhw2v3K1CuSTKRZasmRoLeKLa/PWTuL1y6MaidcWNo?=
 =?iso-8859-1?Q?VAew7yFO1Yr+I59f06aYeFDL/Pr36r0z5IVSMod785jWxNWe+iCrbIt7MQ?=
 =?iso-8859-1?Q?szYNm7VQJ/24tQ9IIv3thUtGobpSueAm8HUJUDz7pCXxEZ3BJczoiwyzvP?=
 =?iso-8859-1?Q?oPN0nj0sMkI+MKzO23z63vZu+xnFFKM5B1fPN3+8qLAiTMF9JwyYJLf+gZ?=
 =?iso-8859-1?Q?b2KRBp8KzuG+mlPIcqpwTsST94lmQUGAylDj/HBGDaIpmT1D3i2lHMM0A8?=
 =?iso-8859-1?Q?HtK0lWBs9WPgC6IjzKJO3QYZI5yQNsI6w2HcEXWVRSunjKKSIsMODs0TUa?=
 =?iso-8859-1?Q?QVy4Ff/zeb7G8gs8O/8JOyu5q9WDlTOfBlkD8Qp+IpauzWN3d9OxNRBGUQ?=
 =?iso-8859-1?Q?yr8biEOp/0kYeaHzJgwTijzq1MyN7u16XG/J7lHPqz33+ykUavle1LDWAb?=
 =?iso-8859-1?Q?BfNarhiv7Dpy4ZP/NJgNpo0vARATsO2UenkRjDZiA/nNwAdWxrt/mrM0o2?=
 =?iso-8859-1?Q?mA2M/HP5XTB2LhFbS0JqcNVd9hHD+fl6EH7xaxcV2ag/TF1IGVqm25Qq0t?=
 =?iso-8859-1?Q?mZ6ewGfk8ZVAT5I2BkcuylNtDr10t/CYfcNmWJVnM+fijUyE+kAPEL1VaJ?=
 =?iso-8859-1?Q?2NUPYlDxACGSM4M2nunk7lvLjsVKSCEFRubs83F0syfz1NGS0A7dkB6n78?=
 =?iso-8859-1?Q?HxWLnHEzQa9F70mVl/Q9CVdn65NcDbEWZJf2f7HIenpeEQfkQFuGwe2Mbv?=
 =?iso-8859-1?Q?h+MlxxQfXg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7becee-7ba6-4e46-270b-08de7fd328a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 01:03:22.9559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f47c88fd-08a9-4016-b488-3f361c03ff2e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hRB6mLn3L9lMjogDoMvZE5bGOsjN0VPqzeBs414DmL1y56x45D468xnwF4BUZGr2ZQZEUcTiJjDxMIj6sbuSV8kzrD9Qm7QsQn+L/yMMFcA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF12FA9AFC9

After enabling more debugging messages for PCI subsystem, it shows the pref=
 bridge window was shrunken by 1 at [  796.604883].=0A=
=0A=
Again, this is the kernel 6.8. I'll test 6.19 later using openSUSE Tumblewe=
ed. This time the realloc was on.=0A=
=0A=
[  796.604869] pcieport 0000:96:01.0: distributing available resources=0A=
[  796.604872] pci 0000:98:00.0: bridge window [mem 0x00100000-0x001fffff] =
extended by 0x0000000000100000=0A=
[  796.604876] pci 0000:99:00.0: bridge window [??? 0x00000000 flags 0x0] e=
xtended by 0x0000000000055555=0A=
[  796.604880] pci 0000:99:01.0: bridge window [mem 0x00100000-0x001fffff] =
shrunken by 0x00000000000aaaac=0A=
[  796.604883] pci 0000:99:01.0: bridge window [mem 0x800000000-0xfffffffff=
 64bit pref] shrunken by 0x0000000000000001=0A=
[  796.604886] pci 0000:99:02.0: bridge window [??? 0x00000000 flags 0x0] e=
xtended by 0x0000000000055555=0A=
=0A=
[  796.607244] PCI: No. 2 try to assign unassigned res=0A=
[  796.607246] pci 0000:99:01.0: resource 15 [mem 0x134000000000-0x1347ffff=
fffe 64bit pref] released=0A=
[  796.607247] pci 0000:99:01.0: PCI bridge to [bus 9b]=0A=
[  796.607599] pcieport 0000:96:01.0: bridge window [io  0x1000-0x0fff] to =
[bus 98-9c] add_size 1000=0A=
[  796.607600] pcieport 0000:96:01.0: distributing available resources=0A=
[  796.607602] pci 0000:99:01.0: bridge window [mem 0x800000000-0xfffffffff=
 64bit pref] shrunken by 0x0000000000000001=0A=
[  796.607603] pci 0000:99:02.0: bridge window [mem 0x00100000-0x001fffff] =
shrunken by 0x0000000000055554=0A=
[  796.607605] pcieport 0000:96:01.0: bridge window [io  size 0x1000]: can'=
t assign; no space=0A=
[  796.607606] pcieport 0000:96:01.0: bridge window [io  size 0x1000]: fail=
ed to assign=0A=
[  796.607607] pcieport 0000:96:01.0: bridge window [io  size 0x1000]: can'=
t assign; no space=0A=
[  796.607607] pcieport 0000:96:01.0: bridge window [io  size 0x1000]: fail=
ed to assign=0A=
[  796.607609] pci 0000:99:01.0: bridge window [mem 0x134000000000-0x1347ff=
fffffe 64bit pref]: assigned=0A=
[  796.607610] pci 0000:99:00.0: bridge window [mem 0xe1b00000-0xe1bfffff]:=
 assigned=0A=
[  796.607611] pci 0000:99:02.0: bridge window [mem size 0x000aaaac]: can't=
 assign; no space=0A=
[  796.607613] pci 0000:99:02.0: bridge window [mem size 0x000aaaac]: faile=
d to assign=0A=
[  796.607614] pci 0000:99:00.0: PCI bridge to [bus 9a]=0A=
[  796.607832] pci 0000:99:00.0:   bridge window [mem 0xe1b00000-0xe1bfffff=
]=0A=
[  796.608262] pci 0000:9b:00.0: BAR 0 [mem size 0x800000000 64bit pref]: c=
an't assign; no space=0A=
[  796.608264] pci 0000:9b:00.0: BAR 0 [mem size 0x800000000 64bit pref]: f=
ailed to assign=0A=
[  796.608265] pci 0000:99:01.0: PCI bridge to [bus 9b]=0A=
[  796.608473] pci 0000:99:01.0:   bridge window [mem 0xe1a00000-0xe1a55553=
]=0A=
[  796.608615] pci 0000:99:01.0:   bridge window [mem 0x134000000000-0x1347=
fffffffe 64bit pref]=0A=
=0A=
Thanks,=0A=
Shawn.=0A=
________________________________________=0A=
From:=A0Shawn Jin <shawn.jin@asteralabs.com>=0A=
Sent:=A0Wednesday, March 11, 2026 5:02 PM=0A=
To:=A0Bjorn Helgaas <helgaas@kernel.org>=0A=
Cc:=A0Bjorn Helgaas <bhelgaas@google.com>; linux-kernel@vger.kernel.org <li=
nux-kernel@vger.kernel.org>; linux-pci@vger.kernel.org <linux-pci@vger.kern=
el.org>; Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>=0A=
Subject:=A0Re: [BUG] PCIe bridge resource allocation creates invalid limit =
addresses after Secondary Bus Reset recovery=0A=
=A0=0A=
Hi Bjorn,=0A=
=0A=
Thanks for the quick response.=0A=
=0A=
[+cc Ilpo]=0A=
=0A=
On Wed, Mar 11, 2026 at 10:00:39PM +0000, Shawn Jin wrote:=0A=
> Hello,=0A=
>=0A=
> I'm reporting a potential critical bug in the Linux kernel's PCIe=0A=
> resource allocation code that creates invalid bridge window limit=0A=
> addresses during hotplug re-enumeration after Secondary Bus Reset=0A=
> (SBR) recovery.=0A=
=0A=
Thanks for the report and the repro and debugging information!=0A=
=0A=
> ## AFFECTED KERNEL VERSIONS=0A=
> - Confirmed: 5.15.0, 6.8.0 (Ubuntu 6.8.0-88-generic, 6.8.0-90-generic)=0A=
> - Likely affected: All recent kernels including 6.19=0A=
=0A=
Do you know of any kernels that are *not* affected?=A0 If you do, we=0A=
could bisect.=0A=
=0A=
<SJ> I haven't tried the latest kernel 6.19 yet. I'm planning to install th=
e openSUSE Tumbleweed with kernel 6.19.=0A=
=0A=
Thanks,=0A=
Shawn.=
