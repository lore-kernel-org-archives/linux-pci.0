Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41001C10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 17:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 123892086D
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 17:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="x5A6COR/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfDLR40 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 13:56:26 -0400
Received: from mail-eopbgr80084.outbound.protection.outlook.com ([40.107.8.84]:1701
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726808AbfDLR40 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Apr 2019 13:56:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTNzLzQyMgDUHiIoyVThVf5aZdTBwzbg6ttnZyw79hQ=;
 b=x5A6COR/bf8pB7OWZHwsD80fDqJuQWNUl5XQREOMfMs8v+snJ+9LlOdfXUn1HrVQqNHxPoN4n81HBokFhEoMlWJRMr0clOespvH59F2BpSboPVpPIniaVHwSsQ8jiOfAMfBC0b4a5KMRCF4p5V1oMWlpvUsitmRFHbuwpWwPm30=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB4271.eurprd04.prod.outlook.com (52.134.31.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.17; Fri, 12 Apr 2019 17:56:22 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::cca7:43cf:dc13:a822]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::cca7:43cf:dc13:a822%4]) with mapi id 15.20.1792.016; Fri, 12 Apr 2019
 17:56:22 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Trent Piepho <tpiepho@impinj.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: imx6: Simplify Kconfig depends on
Thread-Topic: [PATCH] PCI: imx6: Simplify Kconfig depends on
Thread-Index: AQHU2DyNuTuwA21czUeOVRo2YY20PA==
Date:   Fri, 12 Apr 2019 17:56:22 +0000
Message-ID: <VI1PR04MB5533A64718D373F9F8357BCDEE280@VI1PR04MB5533.eurprd04.prod.outlook.com>
References: <e3fd8e88a22468be8bd8fce85dafcc14f2e6a618.1552330407.git.leonard.crestez@nxp.com>
 <20190326181912.GB12093@e107981-ln.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4cd16ee0-a494-4ec8-05cf-08d6bf702cb2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4271;
x-ms-traffictypediagnostic: VI1PR04MB4271:
x-microsoft-antispam-prvs: <VI1PR04MB42717D2CC1863C7165472772EE280@VI1PR04MB4271.eurprd04.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(346002)(136003)(366004)(199004)(189003)(33656002)(8676002)(81166006)(8936002)(52536014)(68736007)(81156014)(186003)(2906002)(446003)(486006)(26005)(6506007)(53546011)(44832011)(66066001)(97736004)(102836004)(4326008)(478600001)(14454004)(5660300002)(476003)(55016002)(99286004)(9686003)(7696005)(76176011)(53936002)(6246003)(54906003)(6116002)(3846002)(14444005)(105586002)(106356001)(7736002)(25786009)(305945005)(74316002)(316002)(86362001)(71190400001)(71200400001)(256004)(229853002)(6916009)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4271;H:VI1PR04MB5533.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: En7kn27BFo/j8gmIfNUwNo1XSJ97iJ7w2h7FF+HG28/ri/ebSc4OOCioI9I32cXt5KE18Y3Q+f3QroyLyKYCdQCB61Oa6ciHSO31mitYI0GApRtPf00qyqe7cxdiyJUnzUsuUIi21r3qlGnDb8kk0hTjSEbWF9oYn4llaLct9BS5BfN1/e+kx/qYPAYRKzAC4ULxANquuJ+AwXR7QlYxMeZCfT9nR4OziCx5HwBx2892EDs839l1F1VSY5nDHcJ4wcmB/MJkJDC9PSl8JIXPXom4ILBoPk1rn2HpOYGswhoOn0Up4xwxjpzNeAIYmyTrh8kNLjo2BVGDk1CRJb8z3UkOi7knEH7HSxFpBsodUPjGWXjwMUMwk2r5QqNOECqvwPzgki6zvf2eLF1LkrVEBhNftYx7o6Pf8SiRxxIZVw4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd16ee0-a494-4ec8-05cf-08d6bf702cb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 17:56:22.5459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4271
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/26/19 8:19 PM, Lorenzo Pieralisi wrote:=0A=
> On Mon, Mar 11, 2019 at 06:59:28PM +0000, Leonard Crestez wrote:=0A=
>> In theory this driver can be used on imx6sx without enabling support for=
=0A=
>> imx6q or imx7d but the "depends on" condition doesn't allow that.=0A=
>>=0A=
>> Instead of making the condition even longer just make it depend on=0A=
>> "ARCH_MXC || COMPILE_TEST" instead.=0A=
>>=0A=
>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
>> ---=0A=
>>   drivers/pci/controller/dwc/Kconfig | 2 +-=0A=
>>   1 file changed, 1 insertion(+), 1 deletion(-)=0A=
>>=0A=
>> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller=
/dwc/Kconfig=0A=
>> index 6ea74b1c0d94..21747fd0e799 100644=0A=
>> --- a/drivers/pci/controller/dwc/Kconfig=0A=
>> +++ b/drivers/pci/controller/dwc/Kconfig=0A=
>> @@ -88,11 +88,11 @@ config PCI_EXYNOS=0A=
>>   	depends on PCI_MSI_IRQ_DOMAIN=0A=
>>   	select PCIE_DW_HOST=0A=
>>   =0A=
>>   config PCI_IMX6=0A=
>>   	bool "Freescale i.MX6/7/8 PCIe controller"=0A=
>> -	depends on SOC_IMX6Q || SOC_IMX7D || (ARM64 && ARCH_MXC) || COMPILE_TE=
ST=0A=
>> +	depends on ARCH_MXC || COMPILE_TEST=0A=
>>   	depends on PCI_MSI_IRQ_DOMAIN=0A=
>>   	select PCIE_DW_HOST=0A=
> =0A=
> If Lucas does not spot any problem with this patch I would request his=0A=
> ACK to merge it, thanks.=0A=
=0A=
Lucas: Can you please ack this? It's a bit old but applies cleanly and =0A=
resend shouldn't be required.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
