Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020119.outbound.protection.outlook.com [52.101.85.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28FD3EF64E;
	Thu, 12 Mar 2026 17:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773335647; cv=fail; b=pYnWnhOhzKyt9lB9ms+vd/LLa4dzprhZ7OWBjvYuSiPTwtMoxvMVOCrqnlPOjd3aHH7xF86wZoSwMGxhrygZc8qFuucY32DhSOuDvaArC3D3pJuZXSudjWr5TmTIjiHYHsftAZoseLigh/uppAhk26yzeBdqPQadYmCFRAPC0a8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773335647; c=relaxed/simple;
	bh=OzDcPAkFfK0s+NMqqFA4ldAwV3RH8ZtnCf4Gt+UrV9k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n6OnD6IrcnO7IRiZjHWqGW8R8Y6hTVxWjJVtEK4cSUG9fJI1+GxsAVFG+VKZrP6w2BC6yhCH4K3/YiVXm/aIj6s1GoGcwc7l50b/OoPX8BSBnB9xJ2ROi0cQh+Rt8gtmSsozFy6dR8NIAqGP9Hxs/Zx1/f7C3k+Sqj+PPysww9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=asteralabs.com; spf=pass smtp.mailfrom=asteralabs.com; dkim=pass (1024-bit key) header.d=asteralabs.com header.i=@asteralabs.com header.b=XDkotQmI; arc=fail smtp.client-ip=52.101.85.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=asteralabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asteralabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=asteralabs.com header.i=@asteralabs.com header.b="XDkotQmI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Om4SNlE6yrq5SXBcAPA8O0OA1/epnQfHdQXSk3YJjHVyPPd+OGCFnCwZmhmuFDs+FW8TnbJnbqBecsIzgl7v1I6BlAC9C6DD8oixP2xPm/MVPKvbGI1sqNZqGREgtEjMysNs+wSktbe2bvf6uqMjEfcYyLWIp1iTDyekpKoRoIPR/oZG4ZfcuDxPiaqAvrdZW9mIA78luRjeSVw7NcES4sUwEzC6k67JAJ6ifGblMQNWV9Q2muWj5MUaiLgGmv4X4A+p4BfYgyGTAky5PBjuI8R8qQE7XOJibew3zARhtjiTTJZXUXEbETZnKcLgPB28q74Ng4UXre5cIQu2cohOVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+HucCNSuBqXer7NNfNg0L2ub8sO7DRSnJ4YkHww3Too=;
 b=IMRzJGXRJxl80NyflQQOvKx3P6FAkRqvR5zQ9Csij3Y8y4VWdhq0AyNyLGxPk1w0cEHDifIBSpZZoY0yINTezh2v3WO++piYIdcVImkLvuVOdPFt5sqLNTyTNMYuJNwBgJEvomYvTDyJHZ3rc3gSVQjk0rYEss9ILJbLShJ759tHf2oodX24cHMs3URlG+FWCvKorPRXW/Ken7kXGweDkkLGu/k5rh2+aKUYWaZcZRLdwrriVIEgC2EGi+2xnHDvnvCNPQJz2eVj82/wZMJRbLl3MRIAHbRCBg/PPPd1XFFSqgjbCkWSULr2V2iNh9jxxPwNlxUGA4AYIpcR65PZyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=asteralabs.com; dmarc=pass action=none
 header.from=asteralabs.com; dkim=pass header.d=asteralabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asteralabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HucCNSuBqXer7NNfNg0L2ub8sO7DRSnJ4YkHww3Too=;
 b=XDkotQmIzlEC7Tijm8L/BT9vG7K72iU+LQ+9HvCDAHzAaAjbz3evZGtid/NgQvW6YbjGflS49jHykjpCBfhYaOJz2VoW7qRCuRC74RnRC8OuZLDE+E9pXSX3HZVzQtMvY3KtzCmTBR42O07y6jK5CInZ0hKAurF8I/H010rwiKY=
Received: from LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:232::17)
 by SJ2P221MB1180.NAMP221.PROD.OUTLOOK.COM (2603:10b6:a03:53f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 12 Mar
 2026 17:14:00 +0000
Received: from LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM
 ([fe80::b063:29f1:a2f5:e3fb]) by LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM
 ([fe80::b063:29f1:a2f5:e3fb%4]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 17:14:00 +0000
From: Shawn Jin <shawn.jin@asteralabs.com>
To: =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [BUG] PCIe bridge resource allocation creates invalid limit
 addresses after Secondary Bus Reset recovery
Thread-Topic: [BUG] PCIe bridge resource allocation creates invalid limit
 addresses after Secondary Bus Reset recovery
Thread-Index: AQHcsZ3eHE22fwsOREepAuj/YABaYbWp99mAgAALDviAABAm9oAA0NIAgAA+csE=
Date: Thu, 12 Mar 2026 17:14:00 +0000
Message-ID:
 <LV8P221MB14722013ED06CFDD3AFF161E9944A@LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM>
References:
 <LV8P221MB1472A24B9975F7C8E8D6BF929947A@LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM>
 <20260311231943.GA1086074@bhelgaas>
 <LV8P221MB147241DCED82480888F8D73D9947A@LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM>
 <LV8P221MB14726A1B6959675557ED1AC29944A@LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM>
 <a128f2d6-4311-a9a3-5e10-267f46db709e@linux.intel.com>
In-Reply-To: <a128f2d6-4311-a9a3-5e10-267f46db709e@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_864d6687-5155-4a0e-a628-49dd428607fb_Enabled=True;MSIP_Label_864d6687-5155-4a0e-a628-49dd428607fb_SiteId=f47c88fd-08a9-4016-b488-3f361c03ff2e;MSIP_Label_864d6687-5155-4a0e-a628-49dd428607fb_SetDate=2026-03-12T17:13:59.325Z;MSIP_Label_864d6687-5155-4a0e-a628-49dd428607fb_Name=Internal;MSIP_Label_864d6687-5155-4a0e-a628-49dd428607fb_ContentBits=1;MSIP_Label_864d6687-5155-4a0e-a628-49dd428607fb_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=asteralabs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8P221MB1472:EE_|SJ2P221MB1180:EE_
x-ms-office365-filtering-correlation-id: 7c974520-83ea-4dfe-27b2-08de805ac0b5
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|55112099003|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 UqUVnacf4ypBHjWTBcLNN9Xk8WqB4uCbXOehqTZ2CQ4AvUib6I2WWSILM6ffSK2uJ+2bG+ZUXa0/Tw3d954GKg5JrVPeOQat+f5ds7YTS/XzzSa8hh12anENKUY/kyyUnRyT+1gAvh//6O6Og/d/XN+pf7UhY0ZprbtWhmgHOqTc9nsiIQGvu9DSs3rvEyjD5vuSXJ+uE9bHpTjeUYcbjJTVk1Y6hJ78Zn83oOSK4GV0en30sZ2TjFI/mpsEmXRfCJGJlIGU+8wf3lst8WVxPODzYIn0wxIN62KSF624r8cUNsjVQzxAinik6pW8gBPpd7pXAO4bIyZeWlbJ+Ku5MnatF8+3rHp/r+ny+ODd6flkKBf1s9yps3wYZlSYaCtE8Y0EobDznckmkYvvj2NVj8VX+ABblrXYLus+/KhNseP+rvXI4qcD0T/UzFAgSar3fq5sNYq+ShMVNTx0btccLePsqrlrMi8b1VrJ+QPx0DgoRLTM2UEmgvFi2vsv+vxN5SAI9XSTCFoCNZYL2GkTY92H7DqlD1IclUE+RFeyFs0yU7E0/CgBZVLJ+82GG/2/nu0MESV29FkSZgxIHEM7Q5FQ6vOIwMtzkgPl7/Wrd5m+43I9U7SgX770DCD6rVT9LbWALj5B35TnGcVxbp3PE5sB3S8ed3UktOBZsG6LWlblIsgXBkxrKcc87PJMcoIFKPsXH3Eb/s57imVrIcIuO5lkfTgADbo282vzsEhsHqU30Uec8nBmRNXxNfi03p16w+x3gPSXvbfUoVmERalGoW8pq/37sFbBw3Qx71ev7zY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(55112099003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?SJk7hGNhwUgozQjk4/ciH8f+LyRSxknfKy4Og6LQFa1vy5oiKatXT5dXXT?=
 =?iso-8859-1?Q?LU9GzRW/uR67EJiWyUeSJ/wmdzTHSHtDqdAU8/z4jZZIKrOomrSzlDTUzK?=
 =?iso-8859-1?Q?NKdVHqD6ZUX+ZRYFX3lyEkgVQzRhI0g6GE74SZzrXDri+jbzrSrfNYu75J?=
 =?iso-8859-1?Q?Ym44mBCw5GT2u9oRuQuYrGifEVpYBx+1j0LNeeg32PeqMo4oVyY1JT0pQF?=
 =?iso-8859-1?Q?V03N7uQD2Z6h/9KxBBFKVcGe3hLbaRWy0ZuA+rDDhYeEhOgkQPsf94Mhze?=
 =?iso-8859-1?Q?rIOBeK6Hbo/LqBhF0aF39yLSIWSxPcTjPGOyDV/xMqcrtngXwveuqpL50+?=
 =?iso-8859-1?Q?gmKEzxsC8fT0ijEy0jXqaFHfwDTBJmk/able9eWkpkCPAxtK5UMQAI+eyl?=
 =?iso-8859-1?Q?8tmwzLwRbhK2nypakvmWc33p5EV1Ft9aWmObY/dwBK15OW+nIaDwIOA6MY?=
 =?iso-8859-1?Q?c5ihxHc8zXIYd64O2GrzUq7ohVygMfJI+DxoIPn6TGFavRBq8wg6HLBJGu?=
 =?iso-8859-1?Q?j1qhVVBZmZALwtcCWjauquKAj7oI8HgzJYz4Ddl70rBow8pbHwpJeHnUlb?=
 =?iso-8859-1?Q?p9lDMOH4ABRnDqWQN+SIQrqA9UIxMss55QsReBNUQXij/HxVWpHj7EJML2?=
 =?iso-8859-1?Q?Z+1tW5e3e13JSRA6lMqsoUSp8gj5wjILEuo2fXd5Jg0RcE/lv3VsIlauRJ?=
 =?iso-8859-1?Q?/GF+1HerKbPkUhsRYe1eLTFClnAMDTI3DiLlwKRveMNpOL53hR+E0s0w5T?=
 =?iso-8859-1?Q?HDpUFi5QMy+w0r0xCvor9OBy/3B+pmTdi1yxGXp6C+vTm0gF+PWI6BxX6D?=
 =?iso-8859-1?Q?MhC2bLP1OD5C3VAPk2/lPvJF5cm+5uI+zYDNjvP0Ms0Gd5kuZUVIJIFYtm?=
 =?iso-8859-1?Q?XOVIglrns7QTmyqozyGmeegC3QBfxxg+bgZfRdUlvUAmIK2+jhwqz+EeYY?=
 =?iso-8859-1?Q?MUPpEu6iFG7zga+W3kZeSetIUIapUVttzeML/AlMpi9zTMG6bSJLuJeOX+?=
 =?iso-8859-1?Q?9yo/WxhFTgKLEcWUOHSAK6nBoQqTdm3Cw4FfCaJ6+EBMfXgJlI/Mq7+Nc+?=
 =?iso-8859-1?Q?JjwIElSRDPjJW1bzepibREArZlLm9eqCUWVNHsBSUzEE4UptV1oGoaVntF?=
 =?iso-8859-1?Q?TLzbuvzC7qNOojndpLE0afTrhO1mT2pHTQOwklE6H91znKpOEnsu+mOZsY?=
 =?iso-8859-1?Q?tw3MC1TGICWyzOu/30OA3gPs4uUGA1afQpxhbTEbrXbjFeUyfDMf7iHrzV?=
 =?iso-8859-1?Q?Sv2exGMXo2EcouoXohk4oScgPDltyVT9fG5pEg2XuvtxJrbrtAGGQLj5O8?=
 =?iso-8859-1?Q?H1SUMV+dd8G9FHt36GXwY4UPWousJjxNAVl8M/Ce1Vm74jp4Lhnk6L0Uoz?=
 =?iso-8859-1?Q?8FXJiuDWOeVX23P/kU7OYW4U5GYLD69lUalYX1dplMpgeQrwBlm6QKjdWk?=
 =?iso-8859-1?Q?d7uCTWE81WHvDt1bTYaNTp9AJLQBezobcOa6V4/4oNjcDtq4D6bc9FadeJ?=
 =?iso-8859-1?Q?HyjY6iNY7xDc38UH0ZXGbcivfUxDYed37g1Jr1MU1nWLYee7Hnxm/V+MiM?=
 =?iso-8859-1?Q?gcwHuvpnvFlXhFvbvO0yUAuY5cuz1gYh86C2Yfnukgis05lzI0S7VWNYf2?=
 =?iso-8859-1?Q?l6F/uNiCB7UdPYBcZ9YHCLwUHluaIuT/fnkPvaj/FduuuX11bQAHkYzHda?=
 =?iso-8859-1?Q?2ECGxd62D7vLiMTQa66gcym7Pf+tYbP0KlPlkDhTuMaGpy3CPj6pseT7vj?=
 =?iso-8859-1?Q?i3YU07c2eZpIua/FBpX6p4mFi4YqVqj6i3hvTosC+ASDRJXm8Y/o+pg6y0?=
 =?iso-8859-1?Q?FKJC05GmoQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c974520-83ea-4dfe-27b2-08de805ac0b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 17:14:00.1587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f47c88fd-08a9-4016-b488-3f361c03ff2e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pHB4t47i5NOhksiK0auHcm7I3rfsPKHV/pcmhhhrrNjjNGlfIZqX8WroyxIP1p2lZ8fRrLkI0tgwu3yhrWwZQip6CITz7/QQ3ZcnETnhM9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2P221MB1180

Hi Ilpo,

Thanks for looking into the issue. Just a quick question. So the patch you =
linked and the patch you attached is for the latest kernel, not 6.8. Right?=
 I'll try to install the latest kernel first and rerun my test and keep you=
 updated.

Thanks,
Shawn.

________________________________________
From: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
Sent: Thursday, March 12, 2026 6:24 AM
To: Shawn Jin <shawn.jin@asteralabs.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>; Bjorn Helgaas <bhelgaas@google.com>=
; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-pci@vg=
er.kernel.org <linux-pci@vger.kernel.org>
Subject: Re: [BUG] PCIe bridge resource allocation creates invalid limit ad=
dresses after Secondary Bus Reset recovery

[EXTERNAL EMAIL]

Hi,
First of all, many of the changes related to this additional resource
distribution do not really make sense to me.

There's one fix that tries to rectify to most gross wrongness in the
adjustment itself because it caused a regression (not yet applied):

https://lore.kernel.org/linux-pci/20260219153951.68869-1-ilpo.jarvinen@linu=
x.intel.com/

It probably doesn't address the bug you see here though it may hide it.

> [  796.604869] pcieport 0000:96:01.0: distributing available resources
> [  796.604872] pci 0000:98:00.0: bridge window [mem 0x00100000-0x001fffff=
] extended by 0x0000000000100000
> [  796.604876] pci 0000:99:00.0: bridge window [??? 0x00000000 flags 0x0]=
 extended by 0x0000000000055555
> [  796.604880] pci 0000:99:01.0: bridge window [mem 0x00100000-0x001fffff=
] shrunken by 0x00000000000aaaac
> [  796.604883] pci 0000:99:01.0: bridge window [mem 0x800000000-0xfffffff=
ff 64bit pref] shrunken by 0x0000000000000001
> [  796.604886] pci 0000:99:02.0: bridge window [??? 0x00000000 flags 0x0]=
 extended by 0x0000000000055555

Note how it's not just -1 that seems wrong, the other numbers too seem
non-round (to 1M) as well.

There seems to be a number of problems with this entire algorithm.
I think the -1 comes from remove_dev_resource() that is called for a
resource which does have !res->flags (+ res->start=3Dres->end=3D0 ->
resource_size(res) =3D=3D 1).

So could you please try the patch below.

Not that the fix makes everything okay IMO but perhaps it addresses this
particular case. It's not even clear to me how some of the cases with not
valid bridge windows should be dealt with while distributing the
additional memory between the bridges.

The 55555 cases probably come from align =3D=3D 0 which makes
ALIGN_DOWN_IF_NONZERO() to produce non-aligning sizes. The fix patch below
might address it.

I don't (yet) understand how that aaaac came to be, I suppose it somehow
relates to this doing something unexpected so if you want to check that
out, it would be helpful:
                align =3D pci_resource_alignment(bridge, res);
                if (!resource_assigned(res) && align)
                        available[i].start =3D min(ALIGN(available[i].start=
, align),
                                                 available[i].end + 1);

Another option is remove_dev_resource() doing something that leads to it.

It might be worth adding debug traps for available[i] getting non-1M
aligned but it's not very clear to me how and where.

From: =3D?UTF-8?q?Ilpo=3D20J=3DC3=3DA4rvinen?=3D <ilpo.jarvinen@linux.intel=
.com>
Date: Thu, 12 Mar 2026 14:59:43 +0200
Subject: [PATCH 1/1] PCI: Skip not valid bridge windows while distributing
 resources
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

pci_bus_distribute_available_resources() distributes available
resources between downstream bridges, however, it does not take
into account cases where a bridge window is not valid.

Skip touching bridge windows that are not valid.

Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 7 +++++++
 1 file changed, 7 insertions(+)
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 61f769aaa2f6..4fcb5e0c44b4 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1868,6 +1868,9 @@ static void remove_dev_resource(struct resource *avai=
l, struct pci_dev *dev,
 {
        resource_size_t size, align, tmp;

+       if (!res->flags)
+               return;
+
        size =3D resource_size(res);
        if (!size)
                return;
@@ -1922,6 +1925,8 @@ static void pci_bus_distribute_available_resources(st=
ruct pci_bus *bus,
                available[i] =3D available_in[i];
+               if (!res->flags)
+                       continue;
                /*
                 * The alignment of this bridge is yet to be considered,
                 * hence it must be done now before extending its bridge
@@ -1993,6 +1998,8 @@ static void pci_bus_distribute_available_resources(st=
ruct pci_bus *bus,
                for (i =3D 0; i < PCI_P2P_BRIDGE_RESOURCE_NUM; i++) {
                        res =3D pci_resource_n(dev, PCI_BRIDGE_RESOURCES + =
i);

+                       if (!res->flags)
+                               continue;
                        /*
                         * Make sure the split resource space is properly
                         * aligned for bridge windows (align it down to
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
--
2.39.5

