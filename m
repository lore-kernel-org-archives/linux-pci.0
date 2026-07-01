Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012025.outbound.protection.outlook.com [52.101.66.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6FD31813A;
	Wed,  1 Jul 2026 02:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782872481; cv=fail; b=GgIcU6E0L4HKVUYXR+PsVMlg3tcYa1pjCHDEWcSALzniVbLuRgJImZhRgnnlD2PZz3UaBXK6MeBk7PH2ztZU3xHeMrd1XsTjINlAywQBicBYGBewp+PAmpY7bk11KlUpINPTAsyhoRp4zb1APom7j8mxXmo6y1Ixe5oyJpsmPAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782872481; c=relaxed/simple;
	bh=3weEyibvYb+laROSH9539GolVkZu1qqnRHYCkTPB7lc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PaUUJuvL8WXRnu04r73Sy2xmjIFciGrn2ATlbtyzzYfcx4IFhcU5DOzNmRumBvgqxfnHWATZkI2iXgEtILlavZWe0RmQCLYvZzP+KgkIfIwgsxzchdmHkN4ONNOAWQ/qj7dHhgrwD0/RNaA0ixqRafXinaGtuWlm9yxfCw2XP1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ENOqmLO4; arc=fail smtp.client-ip=52.101.66.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ENOqmLO4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=skTTzGlqO5uWJgGe8DI2q2RULtiIwZ4d1TdAK3hDCWwlVJ8B8auo72Xt2VseE5NXrqvWAHViMf7Ee/tuE1aQcG25bk7ef24zClfAzwh5hnWtzHowRxMYNBKvdKY/65cpAnop3gDlOqq4z0mejATkGqtSctj26nohkCoZOLASij/7cnZv9j8AE5FHegMUlBJx9PBU2cHVvIGv6BDPI/0eBfMTIhBqm6zhVxERzywF0LwuJqgVbf7ssrs/dogbZiCbyfIcP+HMUxchfo2Jbc9uJL0aFlEx/EXUqm5i+0cUnLmj84TvCPGTR9h9MnjlJpWvakQkrkaJzV1L+5aZKfdLHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVpx3D2dTt3gY5Di+me3oJwpEzAIa9twzHrPwHK2adY=;
 b=N0IDifGW5/bv29BWPsm21tBuWhOtHkjA+FX/ry5gZnR8hKvB01G872hB0y80ewURrJcEG9cmhihNLuD5SeKX5TVO1rAc1fXsUvec+rpP0vHuID+fskjE51fcCNSeWqqXxCXybAyHkOzosyHNbnbFo2oGdSfiEvwTh39rnwThhbstI3JiCi6JB0m3oIfDjOEX59Dxoc/vEHb0C4gYwfQtlmFFQIvSEaiMczMhBxZ/mmho9+vckqKjMC1+m1PFdkso4D4agl8Fw7iyiIzEMuyevEzc/wvT98xHNNbrzNlWuH8tuGu/s+SOxn8rGlg5FYMWIWVNwrGuKndJi69bcXoLcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVpx3D2dTt3gY5Di+me3oJwpEzAIa9twzHrPwHK2adY=;
 b=ENOqmLO4RPASFidJzfCFsvZlYEh2LkYgJoeeEmAHq0gW6bpLqOhic/y2jN7/MTyE4BWNNbS2cG2ajSGzXsTPqrE22fjXhSYIZOkPjAA/4Pxb2B5G/lrMjWnmhTbbAFGX6RmB+NqiOSaIqwd0++Dfa/2TKab0LNozPTUAt2C3FlePYHPYN1EebcJYIGFHMVL9DFSsPwS7F6/76LKrN+Givqg4gu2CwmGCUeJHE+2i1+F9YYfTJ9+k/vwnYDL8ad4RuHx+1Fa+E4wGCkvp7F5DLpbVW9g7Q8QjsPIf/wuTMMyVD5R9Xo0UNne9AufaJItSKMSzW/46yIGQKJ+p44Fdlw==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by GV1PR04MB10249.eurprd04.prod.outlook.com
 (2603:10a6:150:1a4::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 02:21:16 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.21.0159.015; Wed, 1 Jul 2026
 02:21:16 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>, "Sherry Sun (OSS)"
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
	<linux-pm@vger.kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
Subject: RE: [PATCH V4 2/8] PCI: imx6: Add skip_pwrctrl_off flag support
Thread-Topic: [PATCH V4 2/8] PCI: imx6: Add skip_pwrctrl_off flag support
Thread-Index: AQHdCHt7ZtufP9paOka/NN6tH1jSBbZXXuUAgACNUMA=
Date: Wed, 1 Jul 2026 02:21:16 +0000
Message-ID:
 <VI0PR04MB121141AC93FED7F245122F9AA92F62@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260630103139.3823329-3-sherry.sun@oss.nxp.com>
 <20260630174316.GA162203@bhelgaas>
In-Reply-To: <20260630174316.GA162203@bhelgaas>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|GV1PR04MB10249:EE_
x-ms-office365-filtering-correlation-id: 2559b76d-dee6-42ab-5861-08ded7176df2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|23010399003|7416014|376014|366016|1800799024|38070700021|4143699003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 LWKoV+tuPkr34VlX9uB2MhBx+MUEJHF9Ssd8JXBDvb4TpvCo8z1qvY+ycUmTTGY942IZM7PHmgriwaRx3TQndQ/Ljd084bvz8L8Z0kxGrGItEfTC/5OY24vKeGuXmKulfAyzLdLlRP2U6fViG9Ck+6V1Vo2C2KVruof/naz0UwylYskykv2sL5d2L4tyExYUZU/e7VmIPfFUdJ9Eb5BTuxtOsKhjCgqRg3oho/u04AN78b+JtlWJu9uHz/ZM8cBsu/qryV9/kKsb/UCGJY0135XQjCV+aGcNJd8yFXtq0hvmyDT5wwFB7iA36kWBEp/Q2muWWy0NZb7qXIwWaOQmDKy4CcBaEm9pZ+LEcRlllsfE1LDOpIrSClGTwvNDufPAPJjd5ub106P1q3ABpCevqAoiomTaort3VlrthvPgFo0tf4ueTCawB3jIR1OIWXb5Zzn6qdheQpIkUibD4aFvmsEe4gkOEwz9DViDAMFqPUzJNif/VxYDZW5j+CbTacs1oqSuZvk0SrNkAKrvOwL4cR+7lfSox7cb+8VuXMKzUi1U/o+7MjK/hp/2NrQn93KXnTPLQl6gZzagaBB9cnpgT6x82nY6dZRDOhNdANHoztjX4bCrvvOQSUK18r4OPiwa4yIxEpAtVHSnTWepB0sOjSUNGGsf3LJTy062CT59WaiXDNfb95Ip0uvN9+TAoYLJrLXz3dz3NYsUNqkDaQHy5mv4bCjj2wK1K1RY3y/wXyM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(366016)(1800799024)(38070700021)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?slF+iUfc3VjSAXthN9Mujid7qzfJ1tNUkA/3WyHnbYNBBBs3ZUpZalERTA9C?=
 =?us-ascii?Q?f4E1bueFq4c5LEiZxvwxHyB6tEnOdi1aER0S1ouc9UTT2Jzf99uU9B/nioU5?=
 =?us-ascii?Q?zn2HztkBVRqdrpD42qSDPGQbeieX11u2UF1wSxpz4F+UXcwsFA+T9vqnWb8v?=
 =?us-ascii?Q?2kR0Hq1aSeo21lI++NJRjmwU6iYch8LBNCahUWSZnH5LXGIDQ2h6kXNXocdG?=
 =?us-ascii?Q?b281QweDXj20FmHFiD80r76k+P15I5N1eQKTRJVCpwPMv1JDzN41Z8Sap6cd?=
 =?us-ascii?Q?l1JDhWuiSL4s4Q45UyNt8tUnwh6pUNwv2q7kL9/zpkIBwi9ejk3awpmkXsPW?=
 =?us-ascii?Q?6B4lCmMCOzq1GwpxISAPgjdpl9NoDMvcrw0OLi4p5NgaZv91KXIcLs0vflyw?=
 =?us-ascii?Q?JaHZUqhI0ttSrRYotP8jM94MKMdOfXp93m63JOGV/XuTIp52D8VdvkYONiXq?=
 =?us-ascii?Q?C/sN44Qe41/ReBoLli7kYIu+X40YlB8woN4Ji7mCJuZEeuI6pHfCmeg7fHMi?=
 =?us-ascii?Q?6Oo78CPJZMfzKcZynUJ/C8nGFjHQtg5irFBqa4kHND4LqoQM8RTYWw61qrer?=
 =?us-ascii?Q?wwC1jL/OlxGVd6BejLLbd6OJHyIMaZQvflqvGwOOPwnZFZD4+zFJd6I/t7ZO?=
 =?us-ascii?Q?bhYqasskpGYC1C/sfBiBfekTraNt2LOKNt/PVLWBcwN6qZ2RbJftpdVABRNG?=
 =?us-ascii?Q?RjHkos4bG/3tLVwORbEQSOIeD5MkBaJGm+vQgDtc/B9qjT4/OuR3tB5Gl13H?=
 =?us-ascii?Q?PLAh6q2gxh4yLeSLr7PRAVtF8LiE/6p0H1LSpL7QiAw85wcms9tus2NyIBBl?=
 =?us-ascii?Q?4eKxXrPU7YWfgyphB3xKqcEq8wOdgUpjnf+A4PdWyjjYqk7wO5VwQeAxmpg7?=
 =?us-ascii?Q?sELuUge56CBoyTqICJKYQ1N8eRBGWAF3vHT8A97f7uKoV/yHB1XySqPzn7Wx?=
 =?us-ascii?Q?ckUhTwyfd2uzCk8uLmW3fl6Ae0NOJwW5gd5sONpOmlPJ/H4DmZpBoYWjuejD?=
 =?us-ascii?Q?2d9qgfmR/5hJyfi6jOi2Z2GEF0zR3lsSY3yz4yP9lGkRqtj9MWN7Fgqk61I+?=
 =?us-ascii?Q?78FWSACW0FkSW5L5AUBYXhw/4IdB/1zaX5nEVJjTSnwDoryeOaLStojzS++9?=
 =?us-ascii?Q?SwOtjYIOBgAzqva1CseLDj+5jqqHVDtbJuw04+iV5Q4L2n2fT7FQ/EqzELbZ?=
 =?us-ascii?Q?Zu6JkRt5vOTndD5DjUh9MeNnG9DLgNxqOwdksmqSFXtby8RZkK2BUj0p9+kk?=
 =?us-ascii?Q?Ms8qmV64lqOEs4HXQgripL3Fvm7Qt1D/phiX/DBIiHia2APOJEKoUEiF/9wU?=
 =?us-ascii?Q?bUYOK3UbCnhuialb5smIuYiRj8a5OwXsgbTbp7E077RAf8oUAq7PDu4CIpLx?=
 =?us-ascii?Q?iiad6jS8smZ8ZqXW0sIpwKtW2CRLEingBf4XGYJZKgUZ33gHSnlAlBTbQMdG?=
 =?us-ascii?Q?Ln04wPnY4HunMGMsgD4C1KiOlVaFY/CDtrUZGJ0oZqozAuJY7c6YUgpy9FFn?=
 =?us-ascii?Q?v+xiIxyUvN2q6gZgwpgd+hNIopE1X7YxkFRhHxe4Rp8iveYFv7QA3qoz4IJ8?=
 =?us-ascii?Q?x/k457anlO/SiM1iUgk9cO+yHMtQs2wXDTOTgKToTQpUeEiCW1isNjm4wznE?=
 =?us-ascii?Q?03oGveBvYroQkVYXng2nSYeTLV5mZt/VYIALAHrDMP53/UatqghtO8BFvQQX?=
 =?us-ascii?Q?8w47aRn2jdBPGHb9S6GugOCB+JAokyjz7j1yAQmWoQ9LqMgr?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2559b76d-dee6-42ab-5861-08ded7176df2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2026 02:21:16.1416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YgYBljh8EuRWFZ9MNqnyb74WS6FxbIR560FfpGSA6cmtAt+VXQYc/czgu3Y9SQ3/7pmzPO7bhIku1XhxFdnDPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10249

> Subject: Re: [PATCH V4 2/8] PCI: imx6: Add skip_pwrctrl_off flag support
>=20
> [+cc Mediatek folks]
>=20
> On Tue, Jun 30, 2026 at 06:31:33PM +0800, Sherry Sun (OSS) wrote:
> > From: Sherry Sun <sherry.sun@nxp.com>
> >
> > Use dw_pcie_rp::skip_pwrctrl_off to avoid powering off devices during
> > suspend to preserve wakeup capability of the devices and also not to
> > power on the devices in the init path.
>=20
> Only pci-imx6.c, pcie-qcom.c, and pcie-mediatek-gen3.c use pci-pwrctrl.  =
pcie-
> qcom.c already has similar skip_pwrctrl_off checks, but pcie-mediatek-gen=
3.c
> does not.  Does it need them?

I think that's depends on if the controller have the usercases such as M.2 =
keyE
connector without auxiliary power and required to support PCIe L2 link stat=
e
and wake-up mechanisms.

Best Regards
Sherry
