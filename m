Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011071.outbound.protection.outlook.com [52.101.65.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14FE4BEE43;
	Wed, 16 Sep 2026 04:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789531231; cv=fail; b=cPppomOspZ8tiGblS34/x/L/DnoTuwqK86ID2+uiNe/7fut6tqQFEt2cD74X5dwGhl+xK+q4/m4HTSgb1uyt8r0c+I2CS1CyyL9VbLHVM+Ey1UeYuI+zPmciN33F27jIvgEZrNWzEnVhu0mki1Y08ayRg5jiZYkhv7uI62eCqi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789531231; c=relaxed/simple;
	bh=Prk8szl4p1vTZJYHYzl1u+V+7k/Qr8LJfAvnWSJrOg4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cKREE7xTSwYwP3z3P8YKzs9BpxQsseeJkRLcYH9oF7xzy+8DwIFknMPvP+BMo2deQU5WxojK8fupCUqu+72fSeyI7EVmB+gcM24nbB/8bo1vZDgS+/tCtiI3O8aDJYrbzqdbC89MWGJkfxy16pwBLX3RshlYQTP8+tAapTFQS5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=j5ct4AeE; arc=fail smtp.client-ip=52.101.65.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="j5ct4AeE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1/SS+xv/KVa3CyyXqYp2LcoeKJZprjCPj49yuZwQn0Wx7B2Mwlg41jEvBflzIsWsaSIvH6myn1PWuRpGEiOSppalbHcc0wiC7SONyTKUKoP5b02utmb4S+EyS70Q4XO+oTpAysP8c1rRQMArtTAQ5TYelYS6aBB/dgSg8SB/k6esxZ3vNie07Lcqrt8QUSd1lXsk99eOz5A8a8IeP/E2q97EkdwuGL1KnJmK7Spq9nYFOm2m+py+HFZJtd3xBrjd+YP++Nt15dp+6vowIjiK5OLX9kD7f06eRM6KVipyWO0Aat6PMOTo0oqgLZTGh9XLsRb4OyMy67CYQnedxeb8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtML4bEzlcTEFhOqePX8lmeI5nvXZUQsQKK5vpX7beA=;
 b=j81nwPpzNRwT+xyfrSwfxHXsMbKY/oZB9c6+V+hJvjuiOg+F+vBORzQT8vAkDtws71R+1Ik9y6ae0Y8NFy9N/IdHAhI3XH895aZP8MzUNnNJkTvZYxR4aDTOno4eCSWWtfnnOf2GjQ5/NSbrLuLfWTToVzKn2Mq0XH0tac1HmbXnYwjLBMLh3rUxyWsyxO7+U17eJNBD55zT1wVuI7vlTwx3GT0zHvGQS+0hfem6q+C+ExpxhYSKO84E3xs37DNPS6yB/VKitBnM9/7d+ODBKrg34R4CEYwHxbor71g++sve+OktGQ6SPKF2TlzBdMvCb2rca3AIHINJmmlb1DEHIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtML4bEzlcTEFhOqePX8lmeI5nvXZUQsQKK5vpX7beA=;
 b=j5ct4AeEc0+0W+WP5Z5K4AyQuhhY028pF9LWtAFKy9NoBT7Ms1wA7kttS+NusxniomLh+qqYQIKfBJ2yONZWTkx7H6JGlbmQuu2fPlebSUmyZ7rabUSg1/RFu3BBnstYnXd7WKs/+GOl/FwOIoLIcN+OZUPlA3q7n6fiNSIigFSy0d0Ym9i+0JaLhBV+5Jakc9ApH2OtClSOKCVYgPLNn2EuKmLCkJ+CMpG0I1wrL71vJ2/1/CF7Fqy8Kx0e7qycag2Pqoh6O6EDffbbyhjZPze6psxBN8ME+KPYnVF4TE3oDI1e/YUmonXyZyW+P0rnAqoxTaRknQ/xbQY2PZs9Kg==
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by MA6PR04MB531623.eurprd04.prod.outlook.com
 (2603:10a6:250:55::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 04:00:25 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%3]) with mapi id 15.21.0382.012; Wed, 16 Sep 2026
 04:00:24 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>, "Hongxing Zhu (OSS)"
	<hongxing.zhu@oss.nxp.com>
CC: Frank Li <frank.li@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] PCI: dwc: Add suspend_poweroff flag for platforms with
 RC power loss
Thread-Topic: [PATCH v2] PCI: dwc: Add suspend_poweroff flag for platforms
 with RC power loss
Thread-Index: AQHdH6nG8t4d/+36IkayVsl6C+RRu7bQ0XDQ
Date: Wed, 16 Sep 2026 04:00:24 +0000
Message-ID:
 <GV2PR04MB120193844E13EAAF122C426448CB92@GV2PR04MB12019.eurprd04.prod.outlook.com>
References: <20260717074121.3214222-1-hongxing.zhu@oss.nxp.com>
 <20260729222946.GA1466768@bhelgaas>
In-Reply-To: <20260729222946.GA1466768@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12019:EE_|MA6PR04MB531623:EE_
x-ms-office365-filtering-correlation-id: d1e44241-77e2-4af3-c20a-08df13a70958
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|19092799006|56012099006|5023799004|11063799006|10067099003|38070700021|4143699003|6133799003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 f38QgZJJ2GzoMzG1bTuzVH0Qpw1Fk+sfdkuc/TsCVfxWXRrDYVMj5dS9ihPLFThoUzeVn+ncUuCL82OcDF7P5qaarWhefJObJ9SDnMF2zs+jQR2hODWn5E6Mrxeunsr4Fan/1T2mIX/tqU/rSsbrQodZJnQ0uL36J8oR8JMs1eREQo+h04MMAxJJ5FcredQATYdllVWpCSFEs6EST4xDUbiLB+RUYQnfg0hoZNP1M7Km9P3GwINFFOl/x7UQIgQmfHpjMXfB4csU+4GZqL8Q+wWICjmaaNOtXpXTt6vMNXt9eVQGSFJ4u0+pBoHZL2dq6VI8HSnGknyroj6MgWXewHda3/ft6kfECsWJEkKU2GecGyp5LdZMxZHqpdmwrxe4dsByliF5Z3xR+xbu+8WrCah9KLwwvNehU7HwTKwMV5btwcakfpbDfQvaSXFhMOQdpIRFyFQZqmBmWA6mdXqSI0ngmK8Daje4zVEGM7DPi+FlkjbZ0bKeEZk8BJCCkYyn87nfKjzePOyW+Sr7tm/1JoS4V/6WK35Tfskortqcd/ZdsyJIY3wTabPDRGrtHoET152/w3p2y7UiINt2+KK/xsKmhrFAM2APDmrkbhV0FRGdsD7ZBZXUepXsNkXx30pgJpCNmPRwQj+VXUYg9TfxoAqKRZ5iRN/6RygPUghoUezv94MdRLulU1VyKFrMbogmbTHrGlPupGW1KeChM88a9lE8bDEdBndRPAlAHYHhOlM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(19092799006)(56012099006)(5023799004)(11063799006)(10067099003)(38070700021)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?H5JSDAf/msYq0UPNyA8olB6X56N1t/G6fVxh9AaKhqPyCejBlE7XUeGTWf5n?=
 =?us-ascii?Q?P+VeGHol3bcs0qy98sXeTsrG+XVf6P+Ut7huvmiBji1McSPCSVVn/unEVM8J?=
 =?us-ascii?Q?WMnCMmh/QBZrZvNCP9Yg39Sy5Sa/zSVoZdZ/AX1/tWZFTddEoHqNK4t4Yd0i?=
 =?us-ascii?Q?KIplNOhZ7y0XaRyXKp4a59t4MRsvE1D1xCjVajpIAc1i4Uuoj7hGvfg5sDS4?=
 =?us-ascii?Q?q72F59G1ZqU+Mlw0QC3A/U9E3H4NZFvZhYXOGWdSFEXKHrSI03i7dX+rVtnM?=
 =?us-ascii?Q?L2gxH6qxKIuTUsn63Z6zB6j0md3dr+QYo5mTHhlHBK6vFk1CM9clAjr8p4Jj?=
 =?us-ascii?Q?YN0FR9atWwali1b5v7A4KM5aJW+dXUoy+vqmVdRKUNGc4bzz7u0HFJybiCE7?=
 =?us-ascii?Q?T+oN/Bog3CRx6RQIpUS6GqRpnBpZV+QivgJV/qUoPUu/A5FehHHWoXEccPU4?=
 =?us-ascii?Q?wGbIfsSSI1VBSond4ZpjwD602iokXNyL4uEbQ5FumWY7BbYKYDGvw6hcI2TD?=
 =?us-ascii?Q?8LUOgMPxv34JnbAJhSUZUF13m1Bj+vl+24OI7CDC1JjKM5HAoZUjyZNBSbrm?=
 =?us-ascii?Q?C4ZwDdhNHxfglwjY+rZFYe9ED2evF8yz3+Z9vgmVmJQa3WoYgbEYEmMG9lRK?=
 =?us-ascii?Q?hYBOfsZnV5tlfVaY9rDuqBI7RLE+YVeI9eK2dPUDh6Ur3x6udccd1m2vYnmn?=
 =?us-ascii?Q?M8wuDum3pXFdP9GyN45vZe1IrD4D6VdNfcSlLWujCh4jgDDzz1oHS5ZGWsB2?=
 =?us-ascii?Q?b/6bVctl7vHacxCBZfmRC9W2eT/Wn2dAycSmbgx2HI8HKvwrBwgWMwqV8PO2?=
 =?us-ascii?Q?dhTMjV1vCS01M81wu2dTqCmMf/p1uFKrjP43hxwm6Oi0DyLCskXPqaf1j4qJ?=
 =?us-ascii?Q?MV6Zn/RHb0377XSt/VVWGYD0sYPs5MaEZECXWwn1qKJiVT6ZkdWnrFV/sV5H?=
 =?us-ascii?Q?OQeQutq8DIehXY2UloyRmaMgMKljsemsHNjE5r5JMx2zJiHGgRXauTec+XQe?=
 =?us-ascii?Q?6UO8d2PTEpLsGFLsRucuoDN/isCz0Mek13mz0bgzXcJOvk3a04rFK8jLZ7T4?=
 =?us-ascii?Q?w1KxgfqZIFfnD4sfbXRGrB9o21RlLFEoBNHR992GDlJlWlXPQd3XXmD9HvX9?=
 =?us-ascii?Q?EEuY/KSmX3T0l9zrBAVxznR7+tgmdNDQAxjDhFrcmkwliu6mYdez3xCNIZg7?=
 =?us-ascii?Q?Fo/T0AdVHR5uEA4D6jpxGH65/TiRk/vOlfC7H3oiKz1Z9RvPyuhvVDi6g3ut?=
 =?us-ascii?Q?RrSWn/YK1KxgWUg0mAIGCrt7tpUw9jvt3nTVqvV8476opHjp17joOCaENKnJ?=
 =?us-ascii?Q?Rm9P/BA0awt2UuZB/0+Nt6DPGpKKcUhdvPGEhj1AF8KkgjBY/Y/BJyJzEZD6?=
 =?us-ascii?Q?Py49cdLqScK5SmlpKnjC64vC3jlj/9nd3z7+/SP+njFuVF0JYjGNeOqpYF5E?=
 =?us-ascii?Q?jskIvtICo1jD8rbRG2FHVGClnGtjoMoRg+nqF7NWf+Yx0hhgIlKdUzSIOV2g?=
 =?us-ascii?Q?EiIWFkcnuMhebXMbrIamUuO7GUJBU1TGD1AmAxqhx/yfEE/4Tip1/pELEEuv?=
 =?us-ascii?Q?2b759KEPAW7r4b3twytRbFNW9SVq0Ye0q311yx75EsKHjpBTlHDRuI6L5sC0?=
 =?us-ascii?Q?L1cqydZzrwCHCD5OsGu/EOPXq3xbDvlec5UoNbg+uBgLYLzVprszP98C0t+p?=
 =?us-ascii?Q?/163TIMb7++7puQ8p1gF8shLyE0wiDp8VM64jJSTwKEDebZt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12019.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e44241-77e2-4af3-c20a-08df13a70958
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 04:00:24.7075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LWfnGgOlUoLyaq5WtQAm07QsArAL4VK2ogkRHaudMxpfy/nWACIgdL2JthU53wyAsIWMKe/sEqfLoCu1gtTNug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA6PR04MB531623

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Thursday, July 30, 2026 6:30 AM
> To: Hongxing Zhu (OSS) <hongxing.zhu@oss.nxp.com>
> Cc: Frank Li <frank.li@nxp.com>; l.stach@pengutronix.de;
> lpieralisi@kernel.org; kwilczynski@kernel.org; mani@kernel.org;
> robh@kernel.org; bhelgaas@google.com; s.hauer@pengutronix.de;
> kernel@pengutronix.de; festevam@gmail.com; linux-pci@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; imx@lists.linux.dev; linux-
> kernel@vger.kernel.org; Hongxing Zhu <hongxing.zhu@nxp.com>
> Subject: Re: [PATCH v2] PCI: dwc: Add suspend_poweroff flag for platforms
> with RC power loss
>=20
> On Fri, Jul 17, 2026 at 03:41:21PM +0800, hongxing.zhu@oss.nxp.com wrote:
> > From: Richard Zhu <hongxing.zhu@nxp.com>
> >
> > Some platforms like i.MX power off their PCIe RC controllers during
> > system suspend, requiring full re-initialization on resume. These
> > platforms need to enter L2 state to properly notify endpoints before
> > power loss.
> >
> > According to PCIe base spec r7.0, sec 5.2, the system software should
> > transition the device into D3Hot before broadcasting the PME_Turn_Off
> > message to initiate L2 entry. However, some endpoint devices fail the
> > D3cold capability check in pci_host_common_d3cold_possible(), which
> > would normally prevent L2 entry.
>=20
> Wakeup devices that don't support PME from D3cold will fail the D3cold
> capability check, but I don't think those are the problem you're solving.
>=20
> This appears to handle devices that are not in D3hot, and that's not a
> property of the endpoint; it's a property of its driver.  Is the problem =
here
> that some driver didn't put its device in D3hot?
>=20
> > For platforms where the RC loses power during suspend, L2 entry is
> > essential regardless of D3cold support, as the link will be lost anyway=
.
> > Add a suspend_poweroff flag to force L2 entry in such cases, and
> > enable it for i.MX PCIe controllers.
> >
> > Note: This violates the spec requirement that devices be in D3Hot
> > before PME_Turn_Off, but is necessary for proper operation on
> > platforms with RC power loss during suspend.
>=20
> If the device isn't in D3hot, it may still be active, and I think the
> PME_Turn_Off will abort any DMAs in progress, which doesn't sound like
> proper operation of the endpoint.
Hi Bjorn,

I apologize for not addressing your concerns promptly. Let me clarify the
issue after reviewing this more carefully.

The problem I'm addressing:

L2 entry is being blocked for wakeup-capable devices that fail the D3cold
capability check in `pci_host_common_d3cold_possible()`, even when the devi=
ce
is already in D3hot state.

Specifically:
- The endpoint device is in D3hot (the driver has done its job correctly)
- However, because it's a wakeup device that doesn't support PME from D3col=
d,
  it fails the D3cold capability check
- This failure currently prevents L2 entry, even though the device is alrea=
dy
  in the required D3hot state as per the spec
- For platforms like i.MX that power off the RC during suspend, we need L2
  entry to properly notify the endpoint before power loss and complete
  reinitialization successfully on resume.

So, the issue isn't about forcing devices into D3hot or handling devices th=
at
aren't in D3hot - it's about allowing L2 entry for devices that are already
in D3hot but happen to fail the D3cold capability check due to wakeup
requirements.

Regarding your concern about the commit message:

> "If the device isn't in D3hot, it may still be active, and I think the
> PME_Turn_Off will abort any DMAs in progress, which doesn't sound like
> proper operation of the endpoint."

You're right. The commit message note about "violating the spec
requirement" is misleading and incorrect. The endpoint device is in D3hot (=
the
driver has done its job correctly), so it's compliant with the spec
requirement. I should remove or reword that note in the next version.

Would you mind if I resubmitted the patch and used clearer submission
information to accurately describe this situation?

Thank you for your patience and guidance!

Best Regards,
Richard Zhu
>=20
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > ---
> > Changes in v2:
> > - Rename the new added flag.
> > - Update commit description and comments.
> >
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c             | 11 +++++++++++
> >  drivers/pci/controller/dwc/pcie-designware-host.c | 10 ++++++++--
> >  drivers/pci/controller/dwc/pcie-designware.h      |  8 ++++++++
> >  3 files changed, 27 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > b/drivers/pci/controller/dwc/pci-imx6.c
> > index 98e1db751132a..5a43bf396521b 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -1957,6 +1957,17 @@ static int imx_pcie_probe(struct platform_device
> *pdev)
> >  		 */
> >  		imx_pcie_add_lut_by_rid(imx_pcie, 0);
> >  	} else {
> > +		/*
> > +		 * i.MX RC is powered off during suspend, requiring L2 entry
> > +		 * to notify endpoints before power loss. Some endpoints fail
> > +		 * the D3cold capability check, which would normally prevent
> > +		 * L2 entry. Force L2 entry anyway since the link will be lost
> > +		 * when RC powers off.
> > +		 *
> > +		 * Note: Per PCIe spec r7.0 sec 5.2, devices should be in
> D3Hot
> > +		 * before PME_Turn_Off. This may not be guaranteed here.
> > +		 */
> > +		pci->pp.suspend_poweroff =3D true;
> >  		if (imx_check_flag(imx_pcie,
> IMX_PCIE_FLAG_SKIP_L23_READY))
> >  			pci->pp.skip_l23_ready =3D true;
> >  		if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_KEEP_MSI_CAP))
> diff
> > --git a/drivers/pci/controller/dwc/pcie-designware-host.c
> > b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 06722259d2e37..95a31d65e1ca9 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -1222,14 +1222,20 @@ static int dw_pcie_pme_turn_off(struct
> dw_pcie
> > *pci)
> >
> >  int dw_pcie_suspend_noirq(struct dw_pcie *pci)  {
> > -	bool pme_capable =3D false;
> > +	bool d3cold, pme_capable =3D false;
> >  	int ret =3D 0;
> >  	u32 val;
> >
> >  	if (!dw_pcie_link_up(pci))
> >  		goto stop_link;
> >
> > -	if (!pci_host_common_d3cold_possible(pci->pp.bridge,
> &pme_capable))
> > +	d3cold =3D pci_host_common_d3cold_possible(pci->pp.bridge,
> &pme_capable);
> > +	/*
> > +	 * Enter L2 if D3cold is possible, or if the platform loses RC power
> > +	 * during suspend (in which case L2 entry is required to notify
> > +	 * endpoints before power loss, regardless of D3cold support).
> > +	 */
> > +	if (!d3cold && !pci->pp.suspend_poweroff)
> >  		return 0;
> >
> >  	if (pci->pp.ops->pme_turn_off) {
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h
> > b/drivers/pci/controller/dwc/pcie-designware.h
> > index de4b245b1758c..3ce7d30d9a4d5 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -471,6 +471,14 @@ struct dw_pcie_rp {
> >  	bool			native_ecam;
> >  	bool                    skip_l23_ready;
> >  	bool			skip_pwrctrl_off;
> > +	/*
> > +	 * suspend_poweroff: Force L2 entry during suspend even when
> D3cold
> > +	 * capability check fails. Used on platforms where RC loses power
> > +	 * during suspend and must notify endpoints via L2 entry before
> > +	 * power loss. May not meet PCIe spec requirement for devices to be
> > +	 * in D3Hot before PME_Turn_Off.
> > +	 */
> > +	bool                    suspend_poweroff;
> >  };
> >
> >  struct dw_pcie_ep_ops {
> > --
> > 2.34.1
> >
