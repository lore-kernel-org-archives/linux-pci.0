Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013066.outbound.protection.outlook.com [40.107.159.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797C91DB92C;
	Fri, 10 Jul 2026 02:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783649801; cv=fail; b=BgpuyWBN1UmNBHLYpEqFgq6c6jkMU7U9YcYlKVHhsxnCEr+MbH7b7veIFM1gYvCCcAhkeXTaRP53SpsuShJHnXEXlSRTehMFIv4D6BANBhUcvzj0npPbwV2YxS7byl8T/thoXk78AIvp2o6def3cWeI0X9XkRRL+kVj6iXsOWx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783649801; c=relaxed/simple;
	bh=E8z+qpXmx2fQbTOr26br2PSoUtzrBM/d8N+rI2Gsz9M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W/f9ChD5+V6UcyxuQ+PxZAhJb7MBei0AL2TA6WHz4J1cVjkqvw0DGz82OVwMMAGxh/CcqoFr/B/IWfzTdPymO8VLXTp8+Q3zSXnUt2vLRHchfJnt+t+DJjyvFfd+SUJkGqfr+52S8IXFq+olMHnMEgxKVvPGxtBYlYEwmNY645M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=h3IEK8vD; arc=fail smtp.client-ip=40.107.159.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="h3IEK8vD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=prFbypYXp3xFsX8mTURR4YSRL8QSM4rDJCdXmzxVY35QG66tEm731C7OKTJLhq10ESW7c27uboavS4SHKCUXLo4Ghw+SlTp+lhW0HzNt5kbOIG9ZWw0O5oHVNv7u9hFcbtK2lxHwwCwM/sLPzF0sG5Sct/8pKjafTfU01I8Z8/fL0IEbMuU3wvQ6oRLOm0yI/wmKGe2cVQmAwL5CDXdK9yquHtO+qdomTzn4e2nRR1EizWpgDWs3vccDB8gesKoR3GvZU+BpxCdOEtLEbwn1DplWOldsnUd6Isj9+X2JYjxdP4pi/Fa0Uc+4bfG/MTKBGoEMflYgVwvdwSchulB3FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQ2XQJJpEbG8LgVhOYRov9PedDbL7AzaPPHgDBxSjGc=;
 b=Bu0+rWu10L8mB54EXh5M1nxONuF2YYnk1nW2gTEFZ2HQEa5rHojZbetT6ArPxPcR9LsPolOed9Aj7ZSk+NdRk7x3e74ZGuSv8wTNDUooLj0cyiHFyKRZtV/K9JINsh+hQ9B1SNUjAQMD7jUQaBZTwK94JCVkRFv1SEToQJ77FztWSww7vPpASXK7RD99FHewOyt5vGAcqlibhCU/vmlchIAEXYyS+J2UYIKdT2D0qOvgdu6/qZw1N8EUC3ikkhiqSTrAgSvlkBcF32pSRJm+uqjy4yBXnEVCr97DXRBUm7+jk6KMR1H9vRDwPgWQn00WEZoUsoGjqN1k8iGw1vvYIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQ2XQJJpEbG8LgVhOYRov9PedDbL7AzaPPHgDBxSjGc=;
 b=h3IEK8vDUyLMNreCw8yEf8D3n9Mbep7JPxc8AiKfjucaovmXgqtKznkRWc2hJTzsfaAlVnZDDi984uK7kPOLvcvggIkqYSG/ngifjKRZxiVDepbED1CynaETXwH/abOxUTE3g5MPFUi5WZbuNhguFTKUnr4GwmPfx8n2yZmDk7Wgjzeo+zap1qanZijBOXxzugtuRWVXc6a6+J7d4Z5HMLX989vrP9OAgscyT2utiLfsss1gMcEn392s/K4eLrF/nntje8UrLzni/g7ZMUWM43lnTApIrOZUnjHnyGzxL1fn+/s6HyonaEdVNYeGXGDjzYl4wOwOC0wiPu03+MbQlA==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AMCPR04MB12669.eurprd04.prod.outlook.com
 (2603:10a6:20b:76f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 10 Jul
 2026 02:16:36 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.21.0181.009; Fri, 10 Jul 2026
 02:16:35 +0000
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
	<linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH V5 2/4] PCI: imx6: Add skip_pwrctrl_off flag support
Thread-Topic: [PATCH V5 2/4] PCI: imx6: Add skip_pwrctrl_off flag support
Thread-Index: AQHdD4ujVRVB+PtT7EGhgJZURkmGHLZlRnKAgAC5bGA=
Date: Fri, 10 Jul 2026 02:16:35 +0000
Message-ID:
 <VI0PR04MB12114FB4F1C79ADFA5F3F215092FD2@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260709101555.3034853-1-sherry.sun@oss.nxp.com>
 <20260709101555.3034853-3-sherry.sun@oss.nxp.com>
 <ak-2BQEUMg8Ewjz9@SMW015318>
In-Reply-To: <ak-2BQEUMg8Ewjz9@SMW015318>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|AMCPR04MB12669:EE_
x-ms-office365-filtering-correlation-id: 7ae9bebe-f584-4d1f-eee6-08dede294481
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|7416014|23010399003|1800799024|376014|366016|18002099003|22082099003|4143699003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info:
 hkbmZ2N+vfpkNmtnDcbnxFqMwhE1eGg73stt+yljn4wikbWufOcIvbrj2KxXj79CQ6PTjnTzoqKT4KutfQiYBUWf01kkvme3kErX/UorjAwpRrtlJV7Jgwi5kL7hZp6Tl/IDk03ZImvhCzgdkpmsBKhQwth58euZBXrGFCr0iR3mwFPWjXh3tMXRQ64wMrlfhPTemWfZGMoxDrTsf/lqA1pRUVRzbsiSyrDXHIZgXijMbhfwD3HWxEa3K/c/ZvbCyfWkmdi0Yqsg+Cx+DrjYnNPITq1SgSq22xduwKbruhzwkOewhGrl9F/26zZX2E44kV7l5ls7BqIOfaMbGcvv9VcvSyNCRcCnM3taONS8D3OeR/CoKaO9NNOq3tQVa0IeMU0c7UJVbIZvbCo9AlRwcQvZ6hYQa5WYYXFl5GjXjGso2033Z6u+9L6uoyws2SY/TRDbgUBhf+4sN0qwUyasa25KUPGwKeCBkqcDcm06pSZjwcnjfTgY0J31GQRaSt7m2tJgBD7aw2huIQyuEzl5Gq6+M3nCwoHOzRIqJSa4iT+o4DCMLwXz6h1h1JyQ2NuE8VaEb0hUJgd7oEBxNzBb62SbjfKsgt4IOvIs17DIFMNexO/tPkQKagxmzbcUJlzrV7bhPg6lxmfG1y1zv1E/4c9q3Z31WwBWESmvqjnqVFlYvL2iPu2uGTEShyZCCAs5vKPZCSPE8wZnuwPBWMhFTWg5jZi5BoHhrg8cJMqK8Tk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(23010399003)(1800799024)(376014)(366016)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EUJdiA0FqUOMQuIxrePlXDyjeBRPzSuvJ00Rr1JDFuA/hXcGUNY9OSVLwUmg?=
 =?us-ascii?Q?c9K1fdlOqA664RlEWmUZkToDLLd8/mJy6EFWNm1gLJIW8rTdoaDHeTbmuubA?=
 =?us-ascii?Q?oOY2rTRNB7EaOfZ6WplzpS2ql7//Ny3jcujcG+MgaFH/3EqdkHH3Ne3R5vKI?=
 =?us-ascii?Q?595dAUmASFIQZLIMQVaQrUGTDSKa3Z5Wv/c0D+Yu3jetE3xNsgHvGhdHUQYL?=
 =?us-ascii?Q?sIKx85t9Rl6eicn2IW5g0mzkfpFjR41q+GKFgzPlTCk2LYvTJi7NFp9Qjld+?=
 =?us-ascii?Q?+JmNLiRG3/0N3kuwXsT2rg3rzxn2i+ZUX7B8mw2EB1Ui4FIuq9Nlnd4Cb5WE?=
 =?us-ascii?Q?Hbgqa3kbUF1zPpPeLlRTCjngXC27IbnZFikNl+mDaWf2eySpRk+SPP+6V8yP?=
 =?us-ascii?Q?qq6HS3wl00iKCHYKWoQgzcnwIUdS0Di5DCwpEsJSw2wFToR0jKercFcuH0Dy?=
 =?us-ascii?Q?RKpwha5w1rJLcW+Wx9guaZjCLjC2OvVDyJgJWNDecOsx19+6uN/2U5qJuwA5?=
 =?us-ascii?Q?R5eusxTQha+LW1P8kFmd4cJiFzmkiav1Uv5mEibtuHYfyLo+h1Ig9JAce2Qj?=
 =?us-ascii?Q?dlwtX1OTZuolnovB308Jq9NXMFpMci7JiFk/5t31SNapCbIlr/HxG2Auc2aF?=
 =?us-ascii?Q?EmbYZecsmVmN1ZouSHiHqDhcAQbhR1XIKoL9hxx5mF//MmOj9Sk/2hrWESGy?=
 =?us-ascii?Q?XQiivtOwZqXZLXkUIfhoKRWSrtBc266Ay+BXH9wwOPqivJM5RGbnmIoV70NG?=
 =?us-ascii?Q?UpflIi6qC2S08qm3kGkNsZ1ql8qhVZFhwrYAs785jI5i/zF2A2xPXNBmy2mt?=
 =?us-ascii?Q?2op0EVbFzRc2hc0S6oIOqt5Gon7ADHzgdS/d2Fz/T6//s30YwjCQJC6hLK7S?=
 =?us-ascii?Q?IcoXpKiEVeUOgpYi2lClt9A/87Y2uMd8w7Nw+hRJ7Hc6tnzMiXC1huZt2i0s?=
 =?us-ascii?Q?wcoYLBy2kooP36LMzSaLOGCqX/9j2Ni1y/6RFDRVzXp2uw8AGyNzSQYfpgkE?=
 =?us-ascii?Q?I1d3WqIhWjYcTxbqTc2emIFtvy0yU9fYDYel+B2aoNXRBz0KrJNZ5A9zrfDL?=
 =?us-ascii?Q?ZUYlpGq8l7q9bmaqyuj6Jiu+A4VK5GmRE+7JXek1G/XFi+yEtVPKe+FWjIPC?=
 =?us-ascii?Q?0oIlDEXrtmfp1x4YqRGPpRW7Anf4hAzN5ENQH/jXYyLGQpa2gTUN/ZzdGyo+?=
 =?us-ascii?Q?j+Sr+ni0ZasLgFvFAKpRPnhWoh+LGCz1PxiYmVWAt67v3gB68o1sU8swndki?=
 =?us-ascii?Q?zLn5BJRWxOh+SpYSfK6Hnhdk4/RyfjrZjOcJAHWHm3DvZZ3+Mog9UJNFe8YR?=
 =?us-ascii?Q?NTPNifL+aYinm20+q+1l7nMaT3/LRCC8PBtJzrDLJZ3VoC6bqI2CXbkcsl5n?=
 =?us-ascii?Q?87k9LvC5GKp2PQOB4H06olaqdPbWl6kpU5SwoM/Ls4DP2JqQkpdGE6UNFczn?=
 =?us-ascii?Q?XXjodG12GrjfpChdSGhBk42heyPrBGECYaZepemxnaf4Qss9WTjgrNUurNdJ?=
 =?us-ascii?Q?O2rFRDLeVUIM5WQNjsGjEh0KsBniOD50/tuY+r3wu3g9x8V34ND3EyzLUcb2?=
 =?us-ascii?Q?KfdsJ9mwxVZZCugrMETD8HAJ58mtTWdx0b5R2QbdjIJJmu7+CcP0ENZH7/sa?=
 =?us-ascii?Q?yRl9yHJc8frmib4hNxhoh/4vUuTcVipFgZ7p1vCtmdFfNvENXn/+kGVRUQYN?=
 =?us-ascii?Q?M0n4wILkfz7WzIE1P+wiuxsNHT0JgCTRqFRKhPjvx26CwXO1?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae9bebe-f584-4d1f-eee6-08dede294481
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2026 02:16:35.7026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R0q5HGzvMd5koOpedF7dFMtkimtkCvz/frfbaa1NOVaJkFxQS9s/NyCJoaSwp7nOe3FQrzJu61/8kFukuKqldA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMCPR04MB12669

> Subject: Re: [PATCH V5 2/4] PCI: imx6: Add skip_pwrctrl_off flag support
>=20
> On Thu, Jul 09, 2026 at 06:15:53PM +0800, Sherry Sun (OSS) wrote:
> > From: Sherry Sun <sherry.sun@nxp.com>
> >
> > Use dw_pcie_rp::skip_pwrctrl_off to avoid powering off devices during
> > suspend to preserve wakeup capability of the devices and also not to
> > power on the devices in the init path.
> >
> > This allows controller power-off to be skipped when some devices (e.g.
> > M.2 Key E cards without auxiliary power) need to support PCIe L2 link
> > state and wake-up mechanisms.
> >
> > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > b/drivers/pci/controller/dwc/pci-imx6.c
> > index 92f8e4a299e8..afcf3b6bf3cd 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -1382,10 +1382,12 @@ static int imx_pcie_host_init(struct dw_pcie_rp
> *pp)
> >  		}
> >  	}
> >
> > -	ret =3D pci_pwrctrl_power_on_devices(dev);
> > -	if (ret) {
> > -		dev_err(dev, "failed to power on pwrctrl devices\n");
> > -		goto err_reg_disable;
> > +	if (!pp->skip_pwrctrl_off) {
>=20
> if pci_pwrctrl_power_on_devices is true, where call
> pci_pwrctrl_power_on_devices()

Hi Frank,
The skip_pwrctrl_off flag defaults to false during the pcie bus probing pha=
se,
so the pci_pwrctrl_power_on_devices() is called at least once to ensure all
regulators are enabled.
The value of skip_pwrctrl_off is only changed in dw_pcie_suspend_noirq(),
and is refreshed by calling the pci_host_common_d3cold_possible() each
time a suspend occurs.
This is why we use this flag at runtime to avoid powering off devices durin=
g
suspend to preserve wakeup capability of the devices.

>=20
> > +		ret =3D pci_pwrctrl_power_on_devices(dev);
> > +		if (ret) {
> > +			dev_err(dev, "failed to power on pwrctrl devices\n");
> > +			goto err_reg_disable;
> > +		}
> >  	}
> >
> >  	ret =3D imx_pcie_clk_enable(imx_pcie); @@ -1454,7 +1456,8 @@ static
> > int imx_pcie_host_init(struct dw_pcie_rp *pp)
> >  err_clk_disable:
> >  	imx_pcie_clk_disable(imx_pcie);
> >  err_pwrctrl_power_off:
> > -	pci_pwrctrl_power_off_devices(dev);
> > +	if (!pp->skip_pwrctrl_off)
> > +		pci_pwrctrl_power_off_devices(dev);
> >  err_reg_disable:
> >  	if (imx_pcie->vpcie)
> >  		regulator_disable(imx_pcie->vpcie);
> > @@ -1473,7 +1476,8 @@ static void imx_pcie_host_exit(struct dw_pcie_rp
> *pp)
> >  	}
> >  	imx_pcie_clk_disable(imx_pcie);
> >
> > -	pci_pwrctrl_power_off_devices(pci->dev);
> > +	if (!pci->pp.skip_pwrctrl_off)
> > +		pci_pwrctrl_power_off_devices(pci->dev);
>=20
> Not sure if there are counter in side power_(on|off) function, if not, ju=
st skip
> power_off is enough.

It depends on the pwrctrl drivers implementation, for the generic pwrctrl, =
it will
call regulator_bulk_enable/disable() to handle this, so has enable/use coun=
ter.

As mentioned above, the value of skip_pwrctrl_off is refreshed in
dw_pcie_suspend_noirq() for each suspend/resume, so we need this runtime
check to avoid powering off some specific devices during suspend.

Best Regards
Sherry
