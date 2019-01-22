Return-Path: <SRS0=s1t5=P6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73631C282C4
	for <linux-pci@archiver.kernel.org>; Tue, 22 Jan 2019 09:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394B52085A
	for <linux-pci@archiver.kernel.org>; Tue, 22 Jan 2019 09:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="tjP1ObPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfAVJRd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:17:33 -0500
Received: from mail-eopbgr00079.outbound.protection.outlook.com ([40.107.0.79]:8028
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727318AbfAVJRb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Jan 2019 04:17:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2gEnXpuSaxVieE6UjZz4Fp5+aDJ6SM0GE/M8H5jFhI=;
 b=tjP1ObPTsgy4psKujFFWkvt0elx/sa6XDRXkl9X1Z2V3QnelOrhXFhcQZtZxVDV53LODqw1eR1fd4KiB4kAc8HDpNcBrNVRGaHHSkOY277LDnSIgRk2UuoQb7yDeKeM7SR9tdCtvCkG14Njo8nObxEQVfCTwnSFCGWkDX7XM7SU=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB4767.eurprd04.prod.outlook.com (20.177.48.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.31; Tue, 22 Jan 2019 09:17:23 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::92d:bf44:9c1d:b907]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::92d:bf44:9c1d:b907%6]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 09:17:23 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Lukas F . Hartmann" <lukas@mntmn.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH 1/2] PCI: imx: Fix probe failure without power domain
Thread-Topic: [PATCH 1/2] PCI: imx: Fix probe failure without power domain
Thread-Index: AQHUsdumnhpLtdU11UCqN+1L30Gg6Q==
Date:   Tue, 22 Jan 2019 09:17:22 +0000
Message-ID: <VI1PR04MB5533DE236150B01461555A5BEE980@VI1PR04MB5533.eurprd04.prod.outlook.com>
References: <cover.1548110502.git.leonard.crestez@nxp.com>
 <375a852ae9170a5f8f53fdd364a7fb7ea642e89c.1548110502.git.leonard.crestez@nxp.com>
 <20190122071251.tgdwnunxksa45n5q@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4767;6:yc2e1vqzP9e5UVUwvOwnjTo/WKXJnfqGi7jU0qcLPvbA7IUgC8RPbCfSiOBa7wl8RELTFw65pFqQGgQGfbrlHculVjYf46gGZo7vA/kV8GeaNSUeW906WjTQPeY4cFnzYRlRlPcp3kN8Cz+ufLRWmFkxsrezrsYU7QuEUEpYT7jxQ+nlC6HS+BX8BH9b6HgmSbRCiCKe+wHrU9tt+3T5fdOl0p4919eyAt8VIv/urzA2+VOjZMR65uxNZYkyVmLshXAD0CRAjw/UJWNfTqsTPLF+AXPL5RaVLdhVLPk4puu2/jmdIYY+zp1dTgWyLPmIfGmcbWL4MZiQ+VdUN0WyY7JIK+rCG8V1s+NmrL88e3XwZpvlFHRhaYz2AMk81+vD7fLJqt9K+x271+xgTFTOeDhUTUULuPd/EQUTVaaS2DwRKaTX3SwDLsk4IAtzva7gHP8IhQqDkn2qodbUIVz3FQ==;5:QeCIyRJMsjTNqOOilcXuDtLHGZf/V4a4buqE9KsFO7rIQNL+fNBr/jC0gDpsoBXsXH6IAUNzdtttUzldbatLY6OGPqGTi5qEDTlQXK3xYFKTWeQAF9h32kCHEM33p/JnJm+422ccth5Whz5WDK3fnKjMZAI4o7V0PpOd1UPuqNeFd1V4lif7EASWGLiBmnAcJjL1rygk61oG5hpkdW+EJw==;7:2cBkwZ5i/Y673Zdc/vNzHctT/DvbUirgxdUh5uFVlddC0L3kvYJFmMWfIpm3OAU2OW1H8frvvGtJHiex6UlhzN3/e8cpgdJ1eHFwagXkiopZp3tS+uhUEXPI9MrXrtpdE0NnNpa3WhHDuMmQhMI6jg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e528650c-d66b-4c8f-fb44-08d6804a6b06
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4767;
x-ms-traffictypediagnostic: VI1PR04MB4767:
x-microsoft-antispam-prvs: <VI1PR04MB4767A846CDA63EA3B17ACF3FEE980@VI1PR04MB4767.eurprd04.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(136003)(376002)(396003)(189003)(199004)(14454004)(81166006)(2906002)(110136005)(102836004)(316002)(68736007)(81156014)(53546011)(305945005)(105586002)(6506007)(54906003)(86362001)(8676002)(55016002)(99286004)(6436002)(229853002)(7736002)(25786009)(14444005)(256004)(5024004)(7696005)(966005)(76176011)(8936002)(66574012)(3846002)(44832011)(4326008)(26005)(6116002)(9686003)(66066001)(476003)(6306002)(97736004)(478600001)(106356001)(74316002)(71190400001)(71200400001)(6246003)(446003)(7416002)(53936002)(486006)(186003)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4767;H:VI1PR04MB5533.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sQ6CajqnPJ44ICfHlYkijwl/xA3209Kef7br7wmNz8DqqYIVzjUvQdWpe9/LxkqUrEUZWAGRk3lmIaFLyoJAUmkioCuBCj3/0dO5M/OL8wEMkSS1w/27CbCa6uASF4H23i/h1cXiTc7BtxzgYRXIUI2gbVayXU3TnKWXR4mtonHkF0Zu0iHHwbPZtO/C8p0nFKCtaZ9A15IdsEg5BH40aMvZduEQY1CYkCqUkkl5Q2eox3PK72PRl5TP4i0RNSMifxY9dgGVRpPzh0SKrN3DBcl0Dkcf2ZHuR7x1Tt+uxA4jjjMlHRLn7S1IkYUBcks7pbr8wI97DzwQXcBefEvViw/1LuzKP2q3Ti6SWJnIz6tVMEfdBytzBSaQZmNck/ZxSfaQrLN2Nl/F/1vbTwqR3dTo2v5lGWB4lRywcQNT/EI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e528650c-d66b-4c8f-fb44-08d6804a6b06
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 09:17:22.9207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4767
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/22/2019 9:12 AM, Uwe Kleine-K=F6nig wrote:=0A=
> On Mon, Jan 21, 2019 at 10:50:04PM +0000, Leonard Crestez wrote:=0A=
>> On chips without a separate power domain for PCI (such as 6q/6qp) the=0A=
>> imx6_pcie_attach_pd function incorrectly returns an error.=0A=
>>=0A=
>> Fix by returning 0 if dev_pm_domain_attach_by_name doesn't find=0A=
>> anything.=0A=
>>=0A=
>> Fixes: 3f7cceeab895 ("PCI: imx: Add multi-pd support")=0A=
>>=0A=
>> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/control=
ler/dwc/pci-imx6.c=0A=
>> @@ -308,10 +308,13 @@ static int imx6_pcie_attach_pd(struct device *dev)=
=0A=
>>   		return 0;=0A=
>>   =0A=
>>   	imx6_pcie->pd_pcie =3D dev_pm_domain_attach_by_name(dev, "pcie");=0A=
>>   	if (IS_ERR(imx6_pcie->pd_pcie))=0A=
>>   		return PTR_ERR(imx6_pcie->pd_pcie);=0A=
>> +	/* Do nothing when power domain missing */=0A=
>> +	if (!imx6_pcie->pd_pcie)=0A=
>> +		return 0;=0A=
> =0A=
> As I said in the mail that proposed this patch for testing: I think it=0A=
> would be better to change dev_pm_domain_attach_by_name to not return an=
=0A=
> error indication by returning NULL or an ERR_PTR value. (Or change=0A=
> device_link_add to accept NULL if NULL is a dummy value.)=0A=
> =0A=
> Just repeating it here to have it near the actual patch.=0A=
=0A=
Link to that previous discussion: =0A=
http://lists.infradead.org/pipermail/linux-arm-kernel/2019-January/626859.h=
tml=0A=
=0A=
I'm not sure what you mean. Should dev_pm_domain_attach_by_name return =0A=
ERR_PTR(-ENOENT) for name not found? It would still require special =0A=
handling for callers.=0A=
=0A=
The device_link_add function already returns NULL if the consumer or =0A=
supplier is NULL but that's also the only way it signals failure. Maybe =0A=
that function should be adjusted to return ERR_PTR instead?=0A=
=0A=
Changing core API for a driver bug seems inappropriate.=0A=
=0A=
The current imx6_pcie_attach_pd code is complicated because it tries to =0A=
distinguish between "multi pd" and "no pd / single pd". I wish there was =
=0A=
a way for these PM_RUNTIME device_links to be setup automatically in =0A=
core and have multi-PD behave the same as a single PD.=0A=
=0A=
There aren't many multi-PD users but commit 6494a9ad86de ("usb: xhci: =0A=
tegra: Add genpd support") seems to do pretty much the same thing.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
