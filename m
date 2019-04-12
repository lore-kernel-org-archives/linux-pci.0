Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D078AC10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 18:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90ED220869
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 18:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dEZCRa5b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfDLSU6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 14:20:58 -0400
Received: from mail-eopbgr70057.outbound.protection.outlook.com ([40.107.7.57]:10213
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726765AbfDLSU6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Apr 2019 14:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IwXMDL/v2rjxfyGVwbjQt8L/juAtaeI1o3xiuI8l0jA=;
 b=dEZCRa5bvnBKmQoS28TJbcQ3VoDBxEL2UEyXHPqzqKG0oQ3OVRl1X8gyBZZ4avz0bR3sa2xQLt5BkOrIRGmmW0cJUDx68WCBFBE/ADKsgdK1G6EVhQBV2dPgqgt3miwUKaswOjNWS3wrxcV8eC7AHy84taYOFd5rIi7z5T5kbUo=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB5839.eurprd04.prod.outlook.com (20.178.204.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.17; Fri, 12 Apr 2019 18:20:53 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::cca7:43cf:dc13:a822]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::cca7:43cf:dc13:a822%4]) with mapi id 15.20.1792.016; Fri, 12 Apr 2019
 18:20:53 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Trent Piepho <tpiepho@impinj.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
CC:     "stefan@agner.ch" <stefan@agner.ch>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] PCI: imx6: Simplify Kconfig depends on
Thread-Topic: [PATCH] PCI: imx6: Simplify Kconfig depends on
Thread-Index: AQHU8Vx2x5ac/K/O0EWf8lPLC3060g==
Date:   Fri, 12 Apr 2019 18:20:53 +0000
Message-ID: <VI1PR04MB55338F78DED082D13A78585BEE280@VI1PR04MB5533.eurprd04.prod.outlook.com>
References: <e3fd8e88a22468be8bd8fce85dafcc14f2e6a618.1552330407.git.leonard.crestez@nxp.com>
 <20190326181912.GB12093@e107981-ln.cambridge.arm.com>
 <VI1PR04MB5533A64718D373F9F8357BCDEE280@VI1PR04MB5533.eurprd04.prod.outlook.com>
 <1555092208.2142.50.camel@impinj.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c37f2e34-09b3-4aa2-e665-08d6bf739936
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5839;
x-ms-traffictypediagnostic: VI1PR04MB5839:
x-microsoft-antispam-prvs: <VI1PR04MB58399D9238C9A99E7581AC05EE280@VI1PR04MB5839.eurprd04.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(346002)(396003)(136003)(189003)(199004)(54906003)(8676002)(86362001)(102836004)(76176011)(446003)(256004)(14444005)(6116002)(8936002)(81166006)(7736002)(106356001)(3846002)(6436002)(71200400001)(74316002)(186003)(476003)(66066001)(2906002)(81156014)(26005)(44832011)(93886005)(486006)(105586002)(55016002)(9686003)(478600001)(25786009)(33656002)(7696005)(305945005)(71190400001)(52536014)(97736004)(316002)(6246003)(6506007)(99286004)(14454004)(53546011)(68736007)(53936002)(229853002)(4326008)(5660300002)(110136005)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5839;H:VI1PR04MB5533.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iHzQwHXRgtfWa0D1ijxBttZXqiikcN0fqUwFahc2c/exRXSFudkMB3G7t/AdMLjHEoDOkSjWdTfryAKflM8wEVDGsAIySmSD3Y/9jI+k2FIXGONguOP/UDk9WPaffJXOMbJLh4tFMS8OWjZoKqyGoQzspeUishlzi5hnMlmKbok+IMuBMjeG6CRQxV1JHCmTmkkRW+IXlmWMnybn5c0CG26OAPAtPRjXjzd1pPM/6804cqIClKvsSdeLK0ZERBd+dtZMqY1xzfop5MJVfs86Mre1rUpYj+QnwLtHBkY/dNj5X6Y07KVbSyAxkXvMmKHztmtZBzByX8NRe0smMbwWdFMoHs7PfdbYT4ZgsIJYhUWvYnXbtiHRquMQly7nNaM3GkPaJ3/ZAlxlHx73Hz8sKOeD9Ke/MR6BLYicrbwRwBA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c37f2e34-09b3-4aa2-e665-08d6bf739936
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 18:20:53.1079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5839
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/12/2019 9:03 PM, Trent Piepho wrote:=0A=
> On Fri, 2019-04-12 at 17:56 +0000, Leonard Crestez wrote:=0A=
>> On 3/26/19 8:19 PM, Lorenzo Pieralisi wrote:=0A=
>>> On Mon, Mar 11, 2019 at 06:59:28PM +0000, Leonard Crestez wrote:=0A=
>>>> In theory this driver can be used on imx6sx without enabling support f=
or=0A=
>>>> imx6q or imx7d but the "depends on" condition doesn't allow that.=0A=
>>>>=0A=
>>>> Instead of making the condition even longer just make it depend on=0A=
>>>> "ARCH_MXC || COMPILE_TEST" instead.=0A=
>>>>=0A=
>>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
>>>> ---=0A=
>>>>    drivers/pci/controller/dwc/Kconfig | 2 +-=0A=
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)=0A=
>>>>=0A=
>>>> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controll=
er/dwc/Kconfig=0A=
>>>> index 6ea74b1c0d94..21747fd0e799 100644=0A=
>>>> --- a/drivers/pci/controller/dwc/Kconfig=0A=
>>>> +++ b/drivers/pci/controller/dwc/Kconfig=0A=
>>>> @@ -88,11 +88,11 @@ config PCI_EXYNOS=0A=
>>>>            depends on PCI_MSI_IRQ_DOMAIN=0A=
>>>>            select PCIE_DW_HOST=0A=
>>>>=0A=
>>>>    config PCI_IMX6=0A=
>>>>            bool "Freescale i.MX6/7/8 PCIe controller"=0A=
>>>> - depends on SOC_IMX6Q || SOC_IMX7D || (ARM64 && ARCH_MXC) || COMPILE_=
TEST=0A=
>>>> + depends on ARCH_MXC || COMPILE_TEST=0A=
>>>>            depends on PCI_MSI_IRQ_DOMAIN=0A=
>>>>            select PCIE_DW_HOST=0A=
>>>=0A=
>>> If Lucas does not spot any problem with this patch I would request his=
=0A=
>>> ACK to merge it, thanks.=0A=
>>=0A=
>> Lucas: Can you please ack this? It's a bit old but applies cleanly and=
=0A=
>> resend shouldn't be required.=0A=
> =0A=
> The IMX7s does not have a PCI-e controller.  The IMX7d does have one,=0A=
> but not the "s".=0A=
> =0A=
> Enabling the controller driver on an IMX SoC that doesn't have it is=0A=
> not exactly the end of the world and having to keep adding new IMX SOCs=
=0A=
> to the list here is annoying.  So IMHO, it's ok to make this change=0A=
> even if the controller is allowed on a superset of the SoCs that have=0A=
> it.=0A=
=0A=
There is no separate config option for IMX7S and I don't think it will =0A=
be ever added. There is however a CONFIG_SOC_IMX6SX.=0A=
=0A=
There were attempts to add "depends on"/"selected by" IMX8MQ to various =0A=
drivers but arm64 maintainers disagreed. This is why this patch fixes =0A=
the "depends on" list for 6sx pcie by dropping per-SOC logic on 32-bit =0A=
arm as well.=0A=
=0A=
People who want very small kernels for their boards will likely fiddle =0A=
with their specific defconfig anyway so maybe complex logic in Kconfig =0A=
is not very helpful.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
