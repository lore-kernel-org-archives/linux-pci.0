Return-Path: <SRS0=lbet=NL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0064C0044C
	for <linux-pci@archiver.kernel.org>; Wed, 31 Oct 2018 11:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5505820657
	for <linux-pci@archiver.kernel.org>; Wed, 31 Oct 2018 11:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FEttTL2B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5505820657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbeJaUAB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 31 Oct 2018 16:00:01 -0400
Received: from mail-eopbgr50064.outbound.protection.outlook.com ([40.107.5.64]:7026
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727534AbeJaUAB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 31 Oct 2018 16:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5p5VXQFaq9/bGgzKDf/R7ze20rodIXHec3ZioQfBVE=;
 b=FEttTL2BMWGEN94aj4TbvUQh4Zaz8qm1SKa5yvq5MpbcP32LgZgBZBJlSd3qdQLDzdZeV5lcgufyNCl6qWpsa8B5AoRCcBVIyz0lPzSuWmnAnz4/Nbq+9SNaA1mQ4YzgvHxODFOR4Q0Og7C5cOpPQrp65iH89zVjZL8jkvTMWfg=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4019.eurprd04.prod.outlook.com (52.134.90.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.25; Wed, 31 Oct 2018 11:02:04 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::989c:6296:ecdc:89ff]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::989c:6296:ecdc:89ff%2]) with mapi id 15.20.1273.027; Wed, 31 Oct 2018
 11:02:04 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Richard Zhu <hongxing.zhu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH] PCI: imx: Add imx6sx suspend/resume support
Thread-Topic: [PATCH] PCI: imx: Add imx6sx suspend/resume support
Thread-Index: AQHUXy28c0CMdC4ep0yd8bBw3iPcCA==
Date:   Wed, 31 Oct 2018 11:02:04 +0000
Message-ID: <AM0PR04MB42907F7BFDBF9648381DED49EECD0@AM0PR04MB4290.eurprd04.prod.outlook.com>
References: <e57884e2dbc429918db81662ddbafe22c472385c.1539019758.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4019;6:0FYRtIbNcgP6rS9iPuTjIf2+u/QGhBzfifW9wnKb3zc8L7FfXMeAqDyeSYl6EtI5MQpj7BhVTeX937UwBTAsMM2xI5g0DB6S6bfySBizpAxU8qqTS3uoM5vrg7y4t6vPsA3FX3TaRnUCBbXSxMMZMUP8Anfr8kaZJ6GUpu/MIAXyRHp/O+rYRWxQJYVh8UHcryrPw4rIBQo8cCpkNTeMbZhjR8ZdtJZaLISCIX/a4BAKfL00eNRCU4oyt2p60knjvSAccrNFhyI3nk/UgzXup4OWtSqCbgcxhyo1F/4soXdEpRoQ8x52h3Uu4/6BQotp2gZIdYUsDFYJ6wuqmQ9uX+qXVQZyd8REKDYXiNj47SOSuOkQU0l3XPFwZJ9PPTVxsghGYW0LJc5/vOLKmCI+Ba/kzIn7J60MLHeR/NAxMmsMP8RoQOh2pZxw3kgFQqiXqgwvcgfFnh5KzeULWtcDZQ==;5:TVOzxXZi2bOSokI6BD5zNdQxnE1Q+kiE4KPlUwvFR1b0ihvf4i+6Ta4zGI+WmvtNO3KgYs4GzZpk7kqw+0BZRqd7d90UYNrtzu12/hu5idPKxHCYApWpSjcUjVW747DpbZnb18HBDa6wNH8GabaZYS7xiVXPtr8RPBqHaSN51g4=;7:poxAm0Ud+CcGTvMNNyzWUvgjDnkmIw5sqOzTn/ehoIobygszf+HtdcpzYjzsge5/UaTuwWc9gRWhcKSlwy5nymqKbmuIE3+VjwrUEt39OKARR+xiQWZJ/lu+g3ckkeDADOfGF1QFQ892tTjC/zg09g==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 46ee8030-c333-490d-a579-08d63f204ab4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4019;
x-ms-traffictypediagnostic: AM0PR04MB4019:
x-microsoft-antispam-prvs: <AM0PR04MB40191D5F501C7367E86491A8EECD0@AM0PR04MB4019.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(84791874153150)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB4019;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4019;
x-forefront-prvs: 084285FC5C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(39860400002)(366004)(396003)(189003)(199004)(5250100002)(81166006)(305945005)(14454004)(8676002)(2900100001)(25786009)(186003)(14444005)(26005)(33656002)(256004)(5660300001)(446003)(44832011)(74316002)(7736002)(81156014)(476003)(486006)(6116002)(3846002)(71200400001)(71190400001)(15650500001)(6246003)(76176011)(110136005)(53936002)(66066001)(54906003)(68736007)(316002)(6306002)(7696005)(39060400002)(99286004)(102836004)(2906002)(7416002)(8936002)(97736004)(6436002)(9686003)(4326008)(55016002)(229853002)(478600001)(86362001)(105586002)(966005)(6506007)(53546011)(106356001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4019;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: V2i+bag8hx0yeW7nyMupEnw2e2B8Bd0iX18ZuGW8ffYd6WreX4qC0Bh19LuvI8n3ZAhs93jbLuOqeXEufcn60gX6bhvoUP5eP02/PquK3bUwuoZVSltDdxTb2VYa+GUaSiCdqMDzSy0XV1EEQOok9xNbUmsY8lRrqFBk0HtULRDPNO6TglWQptUqPsVP9hiXrz0Tj2kx98Cdq+JGYN7dJsdZ42uONYy1sT3VN/B1AQNhk2zc0W0TdcA4zcPiI33hyL+btYbfd3h1EiItikeunwOysTmmI3qxiLqyaIGR9B3piW05dRz7Qs6RbLOnGKzT6IrG1PnjVG4CJe+skTCMRLRDoox2t1OMwK2qCg2x+fg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ee8030-c333-490d-a579-08d63f204ab4
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2018 11:02:04.3578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4019
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/8/2018 8:38 PM, Leonard Crestez wrote:=0A=
> Enable PCI suspend/resume support on imx6sx socs. This is similar to=0A=
> imx7d with a few differences:=0A=
> =0A=
> * The PM_Turn_Off bit is exposed through an IOMUX GPR, like all other=0A=
> pcie control bits on 6sx.=0A=
> * The pcie_inbound_axi clk needs to be turned off in suspend. On resume=
=0A=
> it is restored via resume -> deassert_core_reset -> enable_ref_clk.=0A=
> =0A=
> Most of the resume logic is shared with the initial reset after probe.=0A=
> =0A=
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
=0A=
This is a gentle reminder that this patch was posted ~3 weeks ago and =0A=
there is yet no reply. It's a mostly straight-forward extension of imx7d =
=0A=
pci suspend/resume support to a different SOC.=0A=
=0A=
Lucas/Philipp: can you please take a brief look?=0A=
=0A=
> ---=0A=
>   drivers/pci/controller/dwc/pci-imx6.c       | 40 ++++++++++++++++++---=
=0A=
>   include/linux/mfd/syscon/imx6q-iomuxc-gpr.h |  1 +=0A=
>   2 files changed, 36 insertions(+), 5 deletions(-)=0A=
> =0A=
> Patch is again linux-next, meant to apply here:=0A=
>   https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/log/=
?h=3Dpci/dwc=0A=
> =0A=
> This is quite an old patch, mostly did it to prove that imx7d suspend=0A=
> support is indeed generic.=0A=
> =0A=
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controll=
er/dwc/pci-imx6.c=0A=
> index 2cbef2d7c207..6171171db1fc 100644=0A=
> --- a/drivers/pci/controller/dwc/pci-imx6.c=0A=
> +++ b/drivers/pci/controller/dwc/pci-imx6.c=0A=
> @@ -771,12 +771,29 @@ static void imx6_pcie_ltssm_disable(struct device *=
dev)=0A=
>   	}=0A=
>   }=0A=
>   =0A=
>   static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)=0A=
>   {=0A=
> -	reset_control_assert(imx6_pcie->turnoff_reset);=0A=
> -	reset_control_deassert(imx6_pcie->turnoff_reset);=0A=
> +	struct device *dev =3D imx6_pcie->pci->dev;=0A=
> +=0A=
> +	/*=0A=
> +	 * Some variants have a turnoff reset in DT while=0A=
> +	 * others poke at iomuxc registers.=0A=
> +	 */=0A=
> +	if (imx6_pcie->turnoff_reset) {=0A=
> +		reset_control_assert(imx6_pcie->turnoff_reset);=0A=
> +		reset_control_deassert(imx6_pcie->turnoff_reset);=0A=
> +	} else if (imx6_pcie->variant =3D=3D IMX6SX) {=0A=
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,=0A=
> +				IMX6SX_GPR12_PCIE_PM_TURN_OFF,=0A=
> +				IMX6SX_GPR12_PCIE_PM_TURN_OFF);=0A=
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,=0A=
> +				IMX6SX_GPR12_PCIE_PM_TURN_OFF, 0);=0A=
> +	} else {=0A=
> +		dev_err(dev, "PME_Turn_Off not implemented\n");=0A=
> +		return;=0A=
> +	}=0A=
>   =0A=
>   	/*=0A=
>   	 * Components with an upstream port must respond to=0A=
>   	 * PME_Turn_Off with PME_TO_Ack but we can't check.=0A=
>   	 *=0A=
> @@ -790,22 +807,35 @@ static void imx6_pcie_clk_disable(struct imx6_pcie =
*imx6_pcie)=0A=
>   {=0A=
>   	clk_disable_unprepare(imx6_pcie->pcie);=0A=
>   	clk_disable_unprepare(imx6_pcie->pcie_phy);=0A=
>   	clk_disable_unprepare(imx6_pcie->pcie_bus);=0A=
>   =0A=
> -	if (imx6_pcie->variant =3D=3D IMX7D) {=0A=
> +	switch (imx6_pcie->variant) {=0A=
> +	case IMX6SX:=0A=
> +		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);=0A=
> +		break;=0A=
> +	case IMX7D:=0A=
>   		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,=0A=
>   				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,=0A=
>   				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);=0A=
> +		break;=0A=
> +	default:=0A=
> +		break;=0A=
>   	}=0A=
>   }=0A=
>   =0A=
> +static inline bool imx6_pcie_supports_suspend(struct imx6_pcie *imx6_pci=
e)=0A=
> +{=0A=
> +	return (imx6_pcie->variant =3D=3D IMX7D ||=0A=
> +		imx6_pcie->variant =3D=3D IMX6SX);=0A=
> +}=0A=
> +=0A=
>   static int imx6_pcie_suspend_noirq(struct device *dev)=0A=
>   {=0A=
>   	struct imx6_pcie *imx6_pcie =3D dev_get_drvdata(dev);=0A=
>   =0A=
> -	if (imx6_pcie->variant !=3D IMX7D)=0A=
> +	if (!imx6_pcie_supports_suspend(imx6_pcie))=0A=
>   		return 0;=0A=
>   =0A=
>   	imx6_pcie_pm_turnoff(imx6_pcie);=0A=
>   	imx6_pcie_clk_disable(imx6_pcie);=0A=
>   	imx6_pcie_ltssm_disable(dev);=0A=
> @@ -817,11 +847,11 @@ static int imx6_pcie_resume_noirq(struct device *de=
v)=0A=
>   {=0A=
>   	int ret;=0A=
>   	struct imx6_pcie *imx6_pcie =3D dev_get_drvdata(dev);=0A=
>   	struct pcie_port *pp =3D &imx6_pcie->pci->pp;=0A=
>   =0A=
> -	if (imx6_pcie->variant !=3D IMX7D)=0A=
> +	if (!imx6_pcie_supports_suspend(imx6_pcie))=0A=
>   		return 0;=0A=
>   =0A=
>   	imx6_pcie_assert_core_reset(imx6_pcie);=0A=
>   	imx6_pcie_init_phy(imx6_pcie);=0A=
>   	imx6_pcie_deassert_core_reset(imx6_pcie);=0A=
> diff --git a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h b/include/linux/=
mfd/syscon/imx6q-iomuxc-gpr.h=0A=
> index 6c1ad160ed87..c1b25f5e386d 100644=0A=
> --- a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h=0A=
> +++ b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h=0A=
> @@ -438,10 +438,11 @@=0A=
>   #define IMX6SX_GPR5_DISP_MUX_DCIC1_LCDIF1		(0x0 << 1)=0A=
>   #define IMX6SX_GPR5_DISP_MUX_DCIC1_LVDS			(0x1 << 1)=0A=
>   #define IMX6SX_GPR5_DISP_MUX_DCIC1_MASK			(0x1 << 1)=0A=
>   =0A=
>   #define IMX6SX_GPR12_PCIE_TEST_POWERDOWN		BIT(30)=0A=
> +#define IMX6SX_GPR12_PCIE_PM_TURN_OFF			BIT(16)=0A=
>   #define IMX6SX_GPR12_PCIE_RX_EQ_MASK			(0x7 << 0)=0A=
>   #define IMX6SX_GPR12_PCIE_RX_EQ_2			(0x2 << 0)=0A=
>   =0A=
>   /* For imx6ul iomux gpr register field define */=0A=
>   #define IMX6UL_GPR1_ENET1_CLK_DIR		(0x1 << 17)=0A=
> =0A=
=0A=
