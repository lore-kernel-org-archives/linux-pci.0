Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013061.outbound.protection.outlook.com [40.107.162.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB3E13959D;
	Mon, 22 Jun 2026 03:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782100322; cv=fail; b=qA6Tcr1EvGrQg3SFVZeLfSZlWPGIfqrm5d0Lzq1tpDO00F59tvyCNxQRM4YvVReo/471+9yq9DQIjKe/BCYgux0Et2E4Aiof/JzKcCwvvmhw0YNlXuqUKo2HsWrwgwKSq9sIpBkXU4Tsc2jzkPDlTir926QQygQHWOOnyz772Ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782100322; c=relaxed/simple;
	bh=NhZjiB7vYSvakycBYYDs/Zxu+n9+ogt0Zyp1jYjTOYU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VTtUNQf1lqQWVQi5YGulVD/WOyTJWLPzzEB4DGonHAZMztZyqNcgg2vPS7Jl66HrkoVpgc70uK0lsSHDjqRgarn14hHON2vGj9xEGhHvi+Ilp3IRzeUByOgNqHNoPBAPDVm6ALWMsb8cxXxvu3YlyyZsdUHd9Rjkx7TWI/BvyGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eJKcEjAM; arc=fail smtp.client-ip=40.107.162.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eJKcEjAM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Efa7mp21QgdbmYNK7dWlLhFlJqy1R9205AQA3UovJ9F9OObM64CiUaa/XUNDR7CspuvN8+Xk7LTyXZG3dK4dHhSww0JVgmkoJbtNAEsvZMRlhPt5bc8p0qsWR5h0MO7H5lUVNaAxS/1gbjdUYENhRln0uQgCzgfGBDP5FPx4aHA+ZQq6Udq1PTyLumx09nt5HBLS2xac3q+38oXesaPG7xVVJRZMZdIbaKC4swBPylzkidp/sIyi2bjlZP58DDaRepVxLFFPH5JCrj0LLtae4x/15PSa+soMYx5cUx9kzlGWq3heZ1mOB0sVvkxzi3txeI3gS6IJbtFde+QzlmbjaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YONSfQg8/VHx+wMt+17iFUZO0Gpsc1iHKxjmqzEyVTk=;
 b=bUsNpUPQ7pY+0AdJN4j30Fdn1eJVdK7WcgrjmVQV3iaRSD/LhKramfT9ZiziymehqFp9N2m/Ij8C/2Kb7JremNmXp7FDlEUXb7L9asSlgQzlj2e4vSYnGePTk/qO8gVvCO8Zz7XJ+0p00bq4Bu3E2rtm6DJgSYFP0frQmMwwbvLaBA3YrZmKxKKAgxt+K+15fdmDlhHh5Ug6L3Vvn8meCJbmgVA9xJ1fvVnMBX1P79A9W/ts0hvlWMMKlxCjSHq2Yc0xXSMqbyPvaKUG2m0xiG3fAecppRWfiIXwg4uluz+/6yYqG8lq4iQ+OKXQvvkvO75quRPVqhmZFas7tvfMsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YONSfQg8/VHx+wMt+17iFUZO0Gpsc1iHKxjmqzEyVTk=;
 b=eJKcEjAMCxXpSiEsgN3aEpEh8iDuc1ocpqrZiQw8CnwOyEbZQa/dsUr1ChQ7YSQg5r66xCPADpR7/Y2f0os/L1WOVnTWF/jryIiVREA12AHToLZfcc+kv0lN8g7nq0XpnX69arDejuO8rq7mKkhhMI+z8k7ybaUiFo0Jf2ZQ1ZrVGXLHS3h+nZi8qACBCHNgWO7OZFKedRCa6RrXWpXyUtlnWDNXCcqP7R+bn7hQWQG+AL2gnQwnsM405uRzfRuXY+KGc/R60/FbfQpnQp0wIJdzPTiTNm/fMvuY6k+T6wJ/4zoaua4uNI8Hotconblr8+QcFViSvDzJIjFmKa7Zdw==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by GV4PR04MB11751.eurprd04.prod.outlook.com
 (2603:10a6:150:2d8::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Mon, 22 Jun
 2026 03:51:54 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.21.0139.009; Mon, 22 Jun 2026
 03:51:54 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: "Frank Li (OSS)" <frank.li@oss.nxp.com>, "Sherry Sun (OSS)"
	<sherry.sun@oss.nxp.com>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Frank Li
	<frank.li@nxp.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, Amitkumar Karwar <amitkumar.karwar@nxp.com>, Neeraj
 Sanjay Kale <neeraj.sanjaykale@nxp.com>, "marcel@holtmann.org"
	<marcel@holtmann.org>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
	Hongxing Zhu <hongxing.zhu@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"brgl@kernel.org" <brgl@kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
Subject: RE: [PATCH 3/8] Bluetooth: btnxpuart: Add M.2 Bluetooth device
 support using pwrseq
Thread-Topic: [PATCH 3/8] Bluetooth: btnxpuart: Add M.2 Bluetooth device
 support using pwrseq
Thread-Index: AQHc/wqF6j9CS1xPUkaamLsLC0p+KrZEojoAgAVUbKA=
Date: Mon, 22 Jun 2026 03:51:54 +0000
Message-ID:
 <VI0PR04MB121141C8A15758C0244AA351F92EF2@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260618101047.4185497-1-sherry.sun@oss.nxp.com>
 <20260618101047.4185497-4-sherry.sun@oss.nxp.com>
 <ajQ4oBUNGOrhcPX5@SMW015318>
In-Reply-To: <ajQ4oBUNGOrhcPX5@SMW015318>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|GV4PR04MB11751:EE_
x-ms-office365-filtering-correlation-id: 96e37632-3ca9-4b62-fe1d-08ded01199a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|23010399003|7416014|376014|366016|38070700021|22082099003|18002099003|11063799006|4143699003|6133799003|56012099006;
x-microsoft-antispam-message-info:
 opra3rn5aQGUMwwB7r3tPKA7EcI8+BEyd0qQgwsu6QRyndd3e+DTC0Nry3gq/ZyEPFSHc1PUKS06k1qhGeoDhAG8lH3qtBLSFGVmWubRLq5wReb3mXF3flV2O4w1t71NJuQA8CzuHIYzEMk1Y1tosbyO901E35i9/MqeUf+K3TKAtfpexqgZSdUPPw0JciL9rCHqAQu+36rTu78grRu3Mf+93l6+in8DsaKJxq845m6FTozix4a+JaChfpcFPGC9IrwbX5L4IQERnEloRZz3nWT+sQ27A1KakfshGmQ2io/RbPlRFaYoqIXbsBHP3JayosUVu8zzOczSkgpchD+hTtYgstk343b67Lr9/lJv4PaqZkkOjQmwGywLJcfJjJzzY/6xV3tsCURtRLSpUU42T7LmRz+kiy4yWxDxXLBa6JRO+WgO9DKKWGPNfKDbpC95wsRDLjXMggm+cOm2ZcJQiq2atKqEkavmHBMKiyUlMR9ByGfESTTMTtddxBiwfyWpajS9JjoFiP41g4Hcuy7JzX+65XKHVuiqHisLjkQcBZM9ZJgTidNELZni3el5piT/iKgSkMwjT+Ou6EN/V8LEnv4mdhktKKDW41w+3noAZnwIpoaJ/1IH3aj2QxXMMP2HdrJsPhRklLN6Kt5kjUf5hurD84qPvekKC71RdZ/eeaY9lD9tb4bRvUbR7zBTIGqFhnY+6VijatEbFPog32FX7/zmHED/wYTFcRRyWVoDetY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(23010399003)(7416014)(376014)(366016)(38070700021)(22082099003)(18002099003)(11063799006)(4143699003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?oH7Go0Rk26CqbtvdUaAW5St81J54rLD6RFPgHBhQuwZLHzBI4v0mro1e9YSI?=
 =?us-ascii?Q?3uHf2kl+AZJSzGz5VBfeLtNcJ7kWtmEnWQzshOBf116fPTg32jkfi+pSYjEV?=
 =?us-ascii?Q?OlNZUJBsdUQaKr9FEN71tC7h4+aZjMsx0xnNGp/8oYGKtpQgbWV2pB//XEuO?=
 =?us-ascii?Q?2Hz4DwEoqgGeJmzbWclbLetw0v6CN4tr2fOpertGiis6gmNbSv1Nv9OY2boa?=
 =?us-ascii?Q?XkT9cPBXWjQWs5bkdtbkEwv1MZDa+5BNh1d1LLldAyndlR8mbpNbixRb9OfG?=
 =?us-ascii?Q?hPB7uZei0t82PcHw5WTgGb9b1dqvPjsgz8XzBRJ2JFV6BmpD5QMiuWYI215l?=
 =?us-ascii?Q?CIl07MHgVZFKEpHu7pn7fwRQSj4oXI2TPZ4rWaIcINe0BgdqXUWoCCTUZp6t?=
 =?us-ascii?Q?zYJT3eGqcKAumSDXgIASifoXx0AJiQTbNAMdQGe33+OdRAk7NHLfDSCNNfVb?=
 =?us-ascii?Q?Wq+rU7qf4FJUQRqplQtH4HXlW0N/t2EIgJNeNsVyt+eghmitZCQI4eGOZTxJ?=
 =?us-ascii?Q?kXQPSFuoAEbkoEy7jM8oYSg0oO1LDGa9nOj+nLNooW24vk1UcqaPd1tZYqV0?=
 =?us-ascii?Q?3Di+xRgA5hMcMR72G90O59En2rH7LKdoQTwe3VmZr8DmmKlLxkXT86ut/0QC?=
 =?us-ascii?Q?FR4o1jh9O2ZDiKEWIr6p7efeHHED9hcMDD3Wi4jgjho4cAYv17ZhqFwC7LFe?=
 =?us-ascii?Q?PmJxe9wizfy6CzNEW75lLFlB+BlZF1CGH2YCokV7+TZBfqV97WWDsGEAIUcD?=
 =?us-ascii?Q?b7RwGG12hQrLrzypihaYFq/AyzfyMwSZVt7WSqCijvjfbbL/fZicZMeapkqd?=
 =?us-ascii?Q?n+eI+aMDmGJb4HDmIF/DMFC02kRqZXiJerGwH2ZDBS6Y71ArGEoZzmxmUZqY?=
 =?us-ascii?Q?jDPXri8vZhzl2DP44EcA0jul2xSeLvaDnawyKLIXIGrdLwPXd6H+BYl6pq2b?=
 =?us-ascii?Q?hdH2I3px7iAysjrjXMUWBAaIh9WD8GxKKyay4YZ5a5Wbb59kUR8R0obOoCQd?=
 =?us-ascii?Q?kI87tNZ2A2HHUcYAlweoV2AtsIs3bpxQV18ljq1p3HjgUVLwU7Z1p6vp/fT+?=
 =?us-ascii?Q?HNKd4kc4M1jLtJekQA0n5X6I09p1TQEwRiCZVnoA/4v5sXQfNu/iHgkHrTda?=
 =?us-ascii?Q?c3++sGGTuwhmm8zwgLHqFiyEcMKmQ4jh5P7dAZD2JthTtEdxmsq2e0K3xPzB?=
 =?us-ascii?Q?wlEW3KsP9VR8imitNc+2TTM6Uf1QdCMoNKpNMdT8byczGOOUEj4YlmGNDd1b?=
 =?us-ascii?Q?stFKSfVTfi8nGhu9TVpCOrTy9ffh5CcVQnBa/22GWTUSOIIc2G/LyTPgf4YD?=
 =?us-ascii?Q?ytzG/pxpFXI27Gh6ceq6n3dQ3Q7SEjqcx5Wym1GOPOYzAXyFy90skxYfFdq6?=
 =?us-ascii?Q?8U2fyrZAwqc/DMbw5S1PSKkUAIooB/maVOVpY5IN8fty0JATyFmLgBM0cEei?=
 =?us-ascii?Q?IpNmEDYBLiGdL1Ts4Gh+GZ+WXxuI0+U0Va/5SRWcEZRSQPjQC08nEdUgg6IE?=
 =?us-ascii?Q?9QuUQRyVL9in4akkxk5TG4FrBUDw81oAz9K+fDe9s0gGeFhmvc1yvRyk6mGT?=
 =?us-ascii?Q?Fz8ObUURqtaJB22+nE3HudH+SqD2QN0XmcB6c5W3E7J57GOxyEf2X5JozFmq?=
 =?us-ascii?Q?mczPyDwd1NIZoLlIDLwiVsqX/1eVAJLvRQ2ibMaXFu2ihLIRHLC9L7QF2ihV?=
 =?us-ascii?Q?CQx4ebw4F2zr9BKXtY+hXntHd3DbTs5BSBXGGBep4rcfQfXn?=
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
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e37632-3ca9-4b62-fe1d-08ded01199a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2026 03:51:54.3589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dIgcm/1Fc/G0TmwiYJtkgfju9fz9s0TkbdJiMUU36POazd6n07jUSDwWIpelXWQ0xHu1DdFtio+s/JPUnTvTWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11751

> On Thu, Jun 18, 2026 at 06:10:42PM +0800, Sherry Sun (OSS) wrote:
> > From: Sherry Sun <sherry.sun@nxp.com>
> >
> > Power supply to the M.2 Bluetooth device attached to the host using
> > M.2 connector is controlled using the 'uart' pwrseq device. So add
> > support for getting the pwrseq device if the OF graph link is present.
> > Once obtained, the existing pwrseq APIs can be used to control the
> > power supplies of the
> > M.2 card.
> >
> > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > ---
> >  drivers/bluetooth/btnxpuart.c | 33 ++++++++++++++++++++++++++++++---
> >  1 file changed, 30 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/bluetooth/btnxpuart.c
> > b/drivers/bluetooth/btnxpuart.c index e7036a48ce48..1aa8972f0dab
> > 100644
> > --- a/drivers/bluetooth/btnxpuart.c
> > +++ b/drivers/bluetooth/btnxpuart.c
> > @@ -9,6 +9,8 @@
> >
> >  #include <linux/serdev.h>
> >  #include <linux/of.h>
> > +#include <linux/of_graph.h>
> > +#include <linux/pwrseq/consumer.h>
> >  #include <linux/skbuff.h>
> >  #include <linux/unaligned.h>
> >  #include <linux/firmware.h>
> > @@ -211,6 +213,7 @@ struct btnxpuart_dev {
> >
> >  	struct ps_data psdata;
> >  	struct btnxpuart_data *nxp_data;
> > +	struct pwrseq_desc *pwrseq;
> >  	struct reset_control *pdn;
> >  	struct hci_uart hu;
> >  };
> > @@ -1866,11 +1869,27 @@ static int nxp_serdev_probe(struct
> serdev_device *serdev)
> >  		return err;
> >  	}
> >
> > +	if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev))) {
> > +		struct pwrseq_desc *pwrseq;
> > +
> > +		pwrseq =3D devm_pwrseq_get(&serdev->ctrl->dev, "uart");
> > +		if (IS_ERR(pwrseq))
> > +			return PTR_ERR(pwrseq);
> > +
> > +		nxpdev->pwrseq =3D pwrseq;
> > +		err =3D pwrseq_power_on(pwrseq);
> > +		if (err) {
> > +			dev_err(&serdev->dev, "Failed to power on
> pwrseq\n");
> > +			return err;
> > +		}
>=20
> Can you provide helper function like devm clk get and enabled?
> like devm_pwrsq_get_on()
>=20
> So simple below error handle.

Ok, will try.

Best Regards
Sherry

>=20
> > +	}
> > +
> >  	/* Initialize and register HCI device */
> >  	hdev =3D hci_alloc_dev();
> >  	if (!hdev) {
> >  		dev_err(&serdev->dev, "Can't allocate HCI device\n");
> > -		return -ENOMEM;
> > +		err =3D -ENOMEM;
> > +		goto err_pwrseq_power_off;
> >  	}
> >
> >  	reset_control_deassert(nxpdev->pdn);
> > @@ -1903,11 +1922,14 @@ static int nxp_serdev_probe(struct
> > serdev_device *serdev)
> >
> >  	if (hci_register_dev(hdev) < 0) {
> >  		dev_err(&serdev->dev, "Can't register HCI device\n");
> > +		err =3D -ENODEV;
> >  		goto probe_fail;
> >  	}
> >
> > -	if (ps_setup(hdev))
> > +	if (ps_setup(hdev)) {
> > +		err =3D -ENODEV;
> >  		goto probe_fail;
> > +	}
> >
> >  	hci_devcd_register(hdev, nxp_coredump, nxp_coredump_hdr,
> >  			   nxp_coredump_notify);
> > @@ -1917,7 +1939,10 @@ static int nxp_serdev_probe(struct
> > serdev_device *serdev)
> >  probe_fail:
> >  	reset_control_assert(nxpdev->pdn);
> >  	hci_free_dev(hdev);
> > -	return -ENODEV;
> > +err_pwrseq_power_off:
> > +	if (nxpdev->pwrseq)
> > +		pwrseq_power_off(nxpdev->pwrseq);
> > +	return err;
> >  }
> >
> >  static void nxp_serdev_remove(struct serdev_device *serdev) @@
> > -1944,6 +1969,8 @@ static void nxp_serdev_remove(struct serdev_device
> *serdev)
> >  	ps_cleanup(nxpdev);
> >  	hci_unregister_dev(hdev);
> >  	reset_control_assert(nxpdev->pdn);
> > +	if (nxpdev->pwrseq)
> > +		pwrseq_power_off(nxpdev->pwrseq);
> >  	hci_free_dev(hdev);
> >  }
> >
> > --
> > 2.50.1
> >
> >
