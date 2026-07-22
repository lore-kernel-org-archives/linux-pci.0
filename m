Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013051.outbound.protection.outlook.com [52.101.83.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE22943990E
	for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 09:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784714323; cv=fail; b=J52vdCY3oUNyrV8NtKgn2oMQQuvFpfvEORbQhMEC+BFiEapmlMz1KzucNhOuw9bVgVgVvLkOIr/+LQ+Nh+JdaHgn3FfB3kl5K+3KO4DC1WATMXZM3+pioErGBpGA53Sf08S6PEAlPAT4oo0kw4EF6mciWOhIBPyQE618aAosxLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784714323; c=relaxed/simple;
	bh=eEkbcKXlKYh1GpX8rYLWRfQPuOOXuNJVqlJg/vyU9GI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i4g+44ODpStm7CK7jdS7e2hQDccmbw1XD6Z1bzdKVRa+BNm1PfWX7q0gZYDKjl4/wT8FiisVbgUnu3Z1gEAQM5Mgm33BrMLgHjLUjE2TMqSFTyw3u0/77AyOWW7VXUN2e9LiF5dU92xv3oy5EhUFl333cnT+E73YincOND7A2fU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=qhML+/jC; arc=fail smtp.client-ip=52.101.83.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="qhML+/jC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mFG2Bq5hglssQZNOGZkvbJtQyww4NUWZdsZ5tBnXjm0lc81g3rb4sE7DHaVAfq8qj9fDwuve7OCWYABaKF6NV+DqHC3QJslMZPqtdH0+FGI7Kb6w2eHzTgZWZRmQ9tFypE5CGaTCXWZhwhA0BM6x6p55khelicbDzSWGXF3ewNSCb4FBsENtio5uel4XoVAzhL46PY26YHSoTGdbwfLomzCVO7vgkte8tAPZ+gFYvxBbb3wsAzaN6NrkjSHBAs0vdnxIox5gPNN7xkaIkm4D+4HvesqECxp2rbTZXV8Zg0GQH3vWsp48Zj25avkfAjY8JSAvM+maUR7lHlpsAWLWZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1tJvYZsUNZeX9HUwpiYmQK9kLw3aOZyqcOQVzSaW/sM=;
 b=ZLN9IQaedm73RkOfULVA+UhBNCemqEz+HQqY8kOBX5hWY6+00QmxiMlUBQFcZMBsUb+rQIw3PbcZGO3+0VtNEeasIaNedKC36DoWITZG3agJcshccYjNIDa4Da4b7zK/a33KdvEZpp1Vj8CiSWQWY/B46sWANrP7tvhCtPbz2M9EwtJOT9UsheR0jDMwkTOsg2LJ53CVkI+LUaebaJeKnfVeWdhYUty8d2SaTpkMARJ36QGAON7TFgOcfXqSOU8Vz1Fynky277gZ8InpgGATtZjvxbdUhbU9Oed9bV6H1oB2pvId56vuwuJedMUpCy1RtZfQvHTfXVUVZzQzpPjdhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tJvYZsUNZeX9HUwpiYmQK9kLw3aOZyqcOQVzSaW/sM=;
 b=qhML+/jCAfJ/S1+Nw4DfZrAu5F88LfxZBhCPfmQ9csowijGhd/06xthISfJKXnCLI7k5vjj5uHZ2vYDow2nFy/INuiNhNiKciHxX+Qkb/eCRlSB56UZH7/oGDsjf6ueeEzIF2huzqLDVObtXFrn1Q4kpagf2S+Er5d7AkG7ueEx464iD+AGB3jQjIJMYdSoum0dM5vpIGGl70Gjl4V0Nc9Zsx+gqkxCt6/ubmWGSu9bVLHGjAyiZeJRqPIe++lFVjMPv0PXbm/zSXvOUQyp5fQpXXhAzKIfy+naYjzkJlvZZuPI0FngNsAjwyw7UIazKClXfmNTeiRHdBgBLFV7jUQ==
Received: from AS4PR07MB8508.eurprd07.prod.outlook.com (2603:10a6:20b:4e8::10)
 by DB9PR07MB7307.eurprd07.prod.outlook.com (2603:10a6:10:216::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 09:58:37 +0000
Received: from AS4PR07MB8508.eurprd07.prod.outlook.com
 ([fe80::b9c5:4dbe:525b:4722]) by AS4PR07MB8508.eurprd07.prod.outlook.com
 ([fe80::b9c5:4dbe:525b:4722%4]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 09:58:37 +0000
From: "Jozef Matejcik (Nokia)" <jozef.matejcik@nokia.com>
To: Lukas Wunner <lukas@wunner.de>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "Peter Sys
 (Nokia)" <peter.sys@nokia.com>
Subject: RE: PCI driver - hotplug of multiple devices
Thread-Topic: PCI driver - hotplug of multiple devices
Thread-Index: Ad0ZqS8kL9B8s/EbRg+HUpj9A4DxGwAC/BkAAAJxmaA=
Date: Wed, 22 Jul 2026 09:58:37 +0000
Message-ID:
 <AS4PR07MB8508FD358D4669862667511693C12@AS4PR07MB8508.eurprd07.prod.outlook.com>
References:
 <AS4PR07MB85083609845930FF12F5C79593C12@AS4PR07MB8508.eurprd07.prod.outlook.com>
 <amCA8AHMNorjWDli@wunner.de>
In-Reply-To: <amCA8AHMNorjWDli@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR07MB8508:EE_|DB9PR07MB7307:EE_
x-ms-office365-filtering-correlation-id: 3387ba23-4e7e-4f01-72a1-08dee7d7ccdf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|4143699003|56012099006|11063799006|38070700021|10067099003|6133799003;
x-microsoft-antispam-message-info:
 Sj+NzialtYTX91flOd04NHLDat62yW0a1YdrmQKOBT1i3mU7QTDo92gteW8+8xGd/DKDsMGaBTi/NbQpyLaLTTtVS/4sx67dlMxMf9BF3Ygsm4jiXAKeDcYstGG1CVWPGDk6Fm7D7EYq9BxbG3h7jkYQ3RMTjiQ9mTw7eLqr4w9x4878Qrij9iZiEyTZasu7V51oqPWbAHZjHDUziAxXMOwYfzvwwvuzYBOyGBDmh0uBRN5fM8lLYUWu6Jp76WDGM7/XpVlYG0q7LME9+R+JPUlV+CHYlZoMlJQ39daPE9x+YFdVK/1zgiJKMyUodhbsPhKbRdZXSa1AVlqEQkigzNem9PGVQaupSkJn6HG7swt2yovm1+iVwNCoqvn7ROZSesIk9IpA3wvs/W+qq5J/wz6cSf31Vb6t8aPOq+Mxn6Iq/ZvUMlXqhDFEBMKtYEbja7XmXBhc81pHGiV9pRzNbFlXt+lH3tc/Os6SLbDbMJezDP9mccDTsSKQfI8ZWo2yjwD6+WZHZA4w17Iv9EbCW9axEsW+7KLo4iVkvWtiQ9uaYUeaR6HQpN/+Fe0ngKlD0rRB9vkg2NV/jUOBHXAhu17LwpQfTQHyu6PcbztFCj8B4WqPNuUD1g5wNZC6VCzohQXIVqhdFLcaz6oSZSwcbUkaux/Wj3wlluaVYuQNddcSyOGqSGFXzH89nh3pW8kXkUEb/sM2CGYusJBF8ODJoOssM2+vKDe/Eu+erUr6KrA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR07MB8508.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(38070700021)(10067099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3BIrfeKvc/Dvoxj+LC4gSF/BCk6ZV0gBgDTmBcAG2lFAYwVo+TzHVTYiQ/v9?=
 =?us-ascii?Q?nHNWgXCNJGX4zOKCBGYSy+QLjVQrlSwQHMcCD8FgLHc2ddkxXKAqbT6GaOQ0?=
 =?us-ascii?Q?ggFt3jNRikN3KjPREGxp3eI5owFVIJkha+lhICAYnPtLQbZMAEkwG620TQmh?=
 =?us-ascii?Q?z/g4+Z0QWNKU5DXYZhVZSyRgQcFXkaI04YxvnSZnhSc++KLHQNFKp0J3/0Dl?=
 =?us-ascii?Q?V5OUwGf6TgTDNTp3gdVCaceSLnaYWh+8KMM/g7aj2x/jH2U1CodyUq82zIKi?=
 =?us-ascii?Q?ljCV/eKXWWcEAih2HvwPZDvcg6caBR9RekmPswK+aDAjkOEVNk4wWlETivWo?=
 =?us-ascii?Q?ITQWy7WGwkmpIg4Hq0B7B7XUl2py0Puq6MHwkSH1bt1/ntL1LuhydyeDSElz?=
 =?us-ascii?Q?YEfEw6o2MhXz1+x2MzbLKhkbzVnUtlyzAhepNOUDErAy5k+gziwa5yRH6ukT?=
 =?us-ascii?Q?iNzVCY2/+u0psfjYX75Qq8VUDGcJdskFH3JpqlcTeBpIOkEG7y2FOPuwfWb4?=
 =?us-ascii?Q?fp3VzYE+6d0XP8onHcpC7YJB5YO6R24PsR/OnHGoVlDDYArwacl4F+SVr4jL?=
 =?us-ascii?Q?kVaEZhe+wSQ6pTdNGTwivf4/GGqqlfNGFZoJDxS/Dzm4VxJHG40+eWKQu9TU?=
 =?us-ascii?Q?lJDw3AidKbnRgFzCDIj7U/U8blBKDIAngnn0nZh+2EYao9r1z5+l+FoB/SBy?=
 =?us-ascii?Q?0tiVPHfg6DwUCigdh9VyXWFcwb4JIOel5EJ86hFbLiCSqjchopzKZDrrZJY6?=
 =?us-ascii?Q?rLE2NL9R8W3o6XKpliATFiYj2VkhzV67X7qvURTsW2uRDppJhCHTPcvvqOP4?=
 =?us-ascii?Q?V6oJ+WQpHGg5uKBoslb8d1hIe4AyJtIjlO35ZQhylyyYeG0JcFAv/OP70F/g?=
 =?us-ascii?Q?Xj3wWgOehTo5i3Srj2TLHqsqVLF4yfSeDmKdinKW/TQ70FUbWzg1AvN/s96R?=
 =?us-ascii?Q?a/rV7/5AIIFSziL6XhGsjbS8sSHDfg85G+VwLiW9OHszAmm/IEZof3Hj9Ex8?=
 =?us-ascii?Q?rGA+fyxdCTpY9DdjjEZ6Y2no735jDS+jbB2GzYS0/TTnfUUhm8nJqjudq7xt?=
 =?us-ascii?Q?/gZ1Q025wBPUyNa0IYYmv5UBerls15u9yvSO5sfmVIAYWqYBXRE0f0ByR7iR?=
 =?us-ascii?Q?5BlaO+vtTFZW+x33ltTcjCFP4HzXahhkOr80iCuS9YJj1kYcSVjezfIFU8Y8?=
 =?us-ascii?Q?Fr7CQNc3OVXYMpvUr306S8OCjogJdYfaEne8Yyn0Q/zB7qOY2lK90ifgJOkw?=
 =?us-ascii?Q?08w0PO/dcAZRILnHm3zfl204Z2h7rwSXRmOiefCNXw5cJ7ukUGGJMxZ2ODzv?=
 =?us-ascii?Q?CfIeLf+nB07X9LeJuadKJBMSc6c1xPJNhevQwIFpBhTxdQE8ttLnodUsAd7O?=
 =?us-ascii?Q?YjpOz+HMK+b/sFjUOnWqjZmsJ22Yv//plYkmq7Hfyn+U1iw1Ws2wJEKWPCnT?=
 =?us-ascii?Q?T2pzrMZhgA39/0eUwvfB/h6w8d9gGCw1j1Wgu5d2GN0m01G+HBZsSjAhZzZz?=
 =?us-ascii?Q?GsJj4AR9Z7AdOY/HuXUfBqOxnieyCrzkuQKR/pcKvRQ+zu6QMMhwpRA60i2v?=
 =?us-ascii?Q?Vrx51oF4nUuQU02rRPKCtcGxfAZAxH0qPv+D7z5S3Ij93C+0036z7GDDcg+k?=
 =?us-ascii?Q?VQmd1Fu6/SrQemB7cm3fjVttVgAPhWYVs3AzU6/puvM5xG7iIK+Y5Y6zSZel?=
 =?us-ascii?Q?Omo/eX3CMfDTw5m/x83mWcah00tWJdMJnDy4Y/zTqKNe08i+bcwqXgycioj+?=
 =?us-ascii?Q?b+4usRMKrg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR07MB8508.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3387ba23-4e7e-4f01-72a1-08dee7d7ccdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2026 09:58:37.4160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OkmX9aiuAYSeboz/3ApZNr2cmhSZpa/rVh15w+0OuG4ckmabqGkkUcslN9cjJtI1Bd7AjyikUJ0rzqAX/Dz+YbDRXuZ1imtEfJCQOZVGAPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7307

Hi Lukas,

Thanks for the answer.

> We'd need logs to say anything about it.

The code path taken in faulty case is the same as the one in successful cas=
e. However, we do see that some PCI reads failed:

 Good one:
[  294.400338] linux-kernel-bde (187): iproc version =3D 0x14 dma_hi_bits =
=3D 0x0 [1]
[  294.400341] linux-kernel-bde (187): iProc version: 0x00000014 (20)      =
   [2]
[  294.400348] linux-kernel-bde (187): subwin: 0x02840000 (42205184)
[  294.400353] linux-kernel-bde (187): subwin: 0x00000000 (0)
[  294.400358] linux-kernel-bde (187): subwin: 0x0292c000 (43171840)
[  294.400362] linux-kernel-bde (187): subwin: 0x00000000 (0)
[  294.400367] linux-kernel-bde (187): subwin: 0x00000000 (0)
[  294.400371] linux-kernel-bde (187): subwin: 0x00000000 (0)
[  294.400375] linux-kernel-bde (187): subwin: 0x0292d000 (43175936)
[  294.400379] linux-kernel-bde (187): subwin: 0x02017000 (33648640)
[  294.400385] linux-kernel-bde (187): PCI resource len 8MB =20

Bad one:
[   56.335260] linux-kernel-bde (187): iproc version =3D 0x14 dma_hi_bits =
=3D 0x0 [1]
[   56.335263] linux-kernel-bde (187): iProc version: 0x00000014 (20)      =
   [2]
[   56.335271] linux-kernel-bde (5538): subwin: 0xfffff000 (-4096)
[   56.543324] linux-kernel-bde (5538): subwin: 0xfffff000 (-4096)
[   56.751375] linux-kernel-bde (5538): subwin: 0xfffff000 (-4096)
[   56.959441] linux-kernel-bde (5538): subwin: 0xfffff000 (-4096)
[   57.167681] linux-kernel-bde (5538): subwin: 0xfffff000 (-4096)
Freeze here.

> Or maybe the reset puts the device in a state which is unexpected by the =
driver.
Maybe, but this happens once between 15 and 90 chip resets, according to ou=
r observation. So most of the time driver/HW handle it as expected.

> E.g. a global data structure in the driver needs to be properly locked if=
 accessed concurrently by the probe function for separate devices.
We are aware that there is existing race condition in this driver, which wa=
s causing different issues in the past. Vendor played dead bug here.

All this summarized, we need to go back to vendor's support.

Thanks again,
Jozef

-----Original Message-----
From: Lukas Wunner <lukas@wunner.de>=20
Sent: Wednesday, July 22, 2026 10:36 AM
To: Jozef Matejcik (Nokia) <jozef.matejcik@nokia.com>
Cc: linux-pci@vger.kernel.org; Peter Sys (Nokia) <peter.sys@nokia.com>
Subject: Re: PCI driver - hotplug of multiple devices


CAUTION: This is an external email. Please be very careful when clicking li=
nks or opening attachments. See the URL nok.it/ext for additional informati=
on.



On Wed, Jul 22, 2026 at 07:12:24AM +0000, Jozef Matejcik (Nokia) wrote:
> The driver is Broadcom's linux-kernel-bde.

This seems to be an out-of-tree driver, i.e. not something that is part of =
the mainline kernel.  The upstream community can only provide very limited =
support for such drivers.  The vendor needs to upstream the driver into the=
 mainline kernel, otherwise there's only so much we can do.

> The issue:
>  - kernel module is inserted
>  - we de-assert reset of these PCI devices (previously in reset, i.e.
>    effectively powered down)
>  - sometimes, very infrequently, the box freezes for 1-3 minutes and
>    the HW triggers reboot

We'd need logs to say anything about it.

> When we removed the module before de-asserting the resets and then=20
> inserted it later, the issue did not occur. So we suspect that the=20
> kernel driver is accessing the device during probe too early and this=20
> is causing HW freeze.

Or maybe the reset puts the device in a state which is unexpected by the dr=
iver.

> Are PCI drivers expected to handle hotplug events of any number of=20
> their devices simultaneously?

Yes.  E.g. a global data structure in the driver needs to be properly locke=
d if accessed concurrently by the probe function for separate devices.

> Can the issue I described above be considered a bug in vendor's=20
> implementation?

Sounds like it.  Usually out-of-tree drivers haven't gone through the rigor=
ous review process by the community and quality may thus be subpar.  The re=
commendation is to ask vendors whether driver support is in mainline alread=
y when selecting components for your products.

Thanks,

Lukas
