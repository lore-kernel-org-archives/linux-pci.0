Return-Path: <SRS0=lbet=NL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8A9ECDE44
	for <linux-pci@archiver.kernel.org>; Wed, 31 Oct 2018 12:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 171A22081B
	for <linux-pci@archiver.kernel.org>; Wed, 31 Oct 2018 12:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HbO/O98i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 171A22081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbeJaVPm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 31 Oct 2018 17:15:42 -0400
Received: from mail-eopbgr80071.outbound.protection.outlook.com ([40.107.8.71]:57270
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726025AbeJaVPm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 31 Oct 2018 17:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHMWNPBNf5QT4MNUqxee8rCZvtgKFcCMA0irUAcGvGs=;
 b=HbO/O98iZUNT6xolGCO7V/J22toUA+TwJK0OWD/6K/Jrf3VGffK9ufdnucCJYjMRiJk3yYljB5lixtqOVZXfQvwuRY8QOth8XEcM0lUOOyPJzY5wMqepPue+Xw185yxubMXOj1oVcUkmwfm2gN3IHOrhoA6jNEdmPf9EtA+r3G0=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4449.eurprd04.prod.outlook.com (52.135.148.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.19; Wed, 31 Oct 2018 12:17:51 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::989c:6296:ecdc:89ff]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::989c:6296:ecdc:89ff%2]) with mapi id 15.20.1273.027; Wed, 31 Oct 2018
 12:17:51 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Richard Zhu <hongxing.zhu@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stefan Agner <stefan@agner.ch>, Marek Vasut <marex@denx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] ARM: dts: imx6sx: Add DISPLAY power domain support
Thread-Topic: [PATCH v2 4/4] ARM: dts: imx6sx: Add DISPLAY power domain
 support
Thread-Index: AQHUXzGf8guh/Nb5iEavRi81Wh8wzA==
Date:   Wed, 31 Oct 2018 12:17:50 +0000
Message-ID: <AM0PR04MB4290F31234D75AC7029F066FEECD0@AM0PR04MB4290.eurprd04.prod.outlook.com>
References: <cover.1539020938.git.leonard.crestez@nxp.com>
 <a3265a84052a7c11ae96e61e39adc988ca980d66.1539020938.git.leonard.crestez@nxp.com>
 <20181031061134.GB10386@tiger>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4449;6:iORXm8ybeRiseFJ/w5iRmtbXrz5Ne7RawUayb01Bg+vgRt2QJZ9kbtX+l0367Es/0IWNf5RzMmuIMuTyAoSiGzg3mczvg3ecHtfjzAAOGa8TmlyTtVkza1zrVElL/tbl/v/lvPJT3umqod1BTHDAsjjbzGMmDpXSgQiol+pmNvXVoBmBn1Xk9vJ0aXzmkRBcEVCV4aMK/Xu+RKJlk9dNwMeJ0CMNnjaX2FlUtYlug4yanBKVfiqVmHDxxCnkHV8lUMXYlhNon3HQKPTkmvBsOzcqkifAOQPJDM7hqRX800x1vOg74or2Lyhph3B4TouITfFH4acKiM6ZFEqnM7g83cEJLbo+4i4TnH/YcgelP2eIK5rOM/dVd7Jx6nd5qJp0Zyy5L/Da3qogk1CraUnUHLPhCfS+KxumK/3kKdSG2IVdKEcCZqPwVTiDyShgt0bNlnFNvZHHuzO1BSaPOZ9iyg==;5:Wn2BYIPiNy3a/1atKZ/7MglPDjrlhlOGWSoDSSRkqE8H+RyC6Tb3THmLTw3gK8XDSHHCCaACZnBY5w4qV+7ygMADLPkLs/M73x2gJk4XCVlqhUM7S/8/Xc74CfB2aQXpq/VmhAZSPTKQSB6qj/Z9JcWYBW+K+8sQmOm97ezarZ4=;7:5QJ84E2jimxeIitEOZ0xSFNWtChmwgM+oSRH3U3qMGRE0nxuMDvWB5RrXTMDjXFnqoLiU2NaKpmLagW//TBAJS9qg9sHE6MIvA9eC5GR8xXCgPYnStBKsj3mn8fQSkBqIFu7PU6tpT7RxzbJS+JTjg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3573be15-894c-46b3-cdf8-08d63f2ae0ba
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4449;
x-ms-traffictypediagnostic: AM0PR04MB4449:
x-microsoft-antispam-prvs: <AM0PR04MB44492DF7F78E9D05BB0D28DFEECD0@AM0PR04MB4449.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040)(17755550239193)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB4449;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4449;
x-forefront-prvs: 084285FC5C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(366004)(376002)(346002)(189003)(199004)(6246003)(2906002)(6436002)(76176011)(966005)(6306002)(74316002)(446003)(8676002)(9686003)(478600001)(97736004)(68736007)(53546011)(14454004)(6506007)(476003)(5250100002)(55016002)(33656002)(2900100001)(66066001)(5660300001)(8936002)(99286004)(106356001)(86362001)(53936002)(256004)(44832011)(3846002)(229853002)(7696005)(102836004)(81156014)(25786009)(6116002)(105586002)(316002)(81166006)(486006)(110136005)(7416002)(305945005)(186003)(71200400001)(71190400001)(4326008)(54906003)(7736002)(26005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4449;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Vdo+P4T7XzfCwScQguvvmR5LmMsJvfqv2faXsVJwan3zjnTUqH04c0uD+ukWc5Blb6JJM+B/iMClZdHH/1t+xJSxE5mpVmKfpcpdMLY0XoiOz9XNfPSHkdkwG2NOUihuaetM8CKpmw+4jj6DfEp2mzpwkruEp1qDc4VEvmvalt4X+ntt79pSymodss+xSmzUxplq/d/i7rYTKDnEI2LrMo4Q1NOnBbX71DGz3B6BAwoXd3au6f39DhQYSwxap2k8MzkRWobi2RwqYtDNgGVVHT6itEgKALgEOKHV+agC8z7O7FLYptH2WJaDTxFfxS4u3zWGLKAW+yKGush5m5yvHzj9M12yL8ySwAP3jLfF8Xk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3573be15-894c-46b3-cdf8-08d63f2ae0ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2018 12:17:51.0081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4449
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/31/2018 8:12 AM, Shawn Guo wrote:=0A=
> On Mon, Oct 08, 2018 at 06:06:23PM +0000, Leonard Crestez wrote:=0A=
>> This was implemented in the driver but not actually defined and=0A=
>> referenced in dts. This makes it always on.=0A=
>>=0A=
>>  From reference manual in section "10.4.1.4.1 Power Distribution":=0A=
>>=0A=
>> "Display domain - The DISPLAY domain contains GIS, CSI, PXP, LCDIF,=0A=
>> PCIe, DCIC, and LDB. It is supplied by internal regulator."=0A=
>>=0A=
>> The current pd_pcie is actually only for PCIE_PHY, the PCIE ip block is=
=0A=
>> actually inside the DISPLAY domain. Handle this by adding the pcie node=
=0A=
>> in both power domains.=0A=
>>=0A=
>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
> =0A=
> Applied, thanks.=0A=
=0A=
As mentioned in the cover letter this requires multi-PD support in =0A=
imx-pci to be implemented, specifically PATCH 3/4 of this series:=0A=
=0A=
	https://lore.kernel.org/patchwork/patch/996810/=0A=
=0A=
Unless that also gets merged soon via pci I expect issues in linux-next. =
=0A=
The patch already has reviewed-by tags so "merging it soon" is not =0A=
unreasonable.=0A=
=0A=
Link to cover: https://lore.kernel.org/patchwork/cover/996807/=0A=
=0A=
There is also an mxsfb dependency but that's already merged in =0A=
torvalds/master.=0A=
