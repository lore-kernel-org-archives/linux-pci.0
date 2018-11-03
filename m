Return-Path: <SRS0=Gu+H=NO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6008BC0044C
	for <linux-pci@archiver.kernel.org>; Sat,  3 Nov 2018 15:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB9120833
	for <linux-pci@archiver.kernel.org>; Sat,  3 Nov 2018 15:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GBjCA9/h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB9120833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeKDBF7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 3 Nov 2018 21:05:59 -0400
Received: from mail-eopbgr80050.outbound.protection.outlook.com ([40.107.8.50]:63040
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726888AbeKDBF7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 3 Nov 2018 21:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jydSesig+zZ0C6BSXpetq9CrscdX3u604O3Gf19ehes=;
 b=GBjCA9/hzJl1ENU2k+fDw5fnxmkNlLyFSB1hkFhC2PkzL5DxgeAXG/Jwfjk/e//ZYpvX5p9jK1RlwyMqbQ3607Sgdfxu7c7djGgSr0rE7Umq1Md3YYlmZJzQfgyWPJ6q5piuurBegC3jN+GlTifwwgjhpYexOeqfHboblh2nlAE=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4066.eurprd04.prod.outlook.com (52.134.125.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Sat, 3 Nov 2018 15:54:13 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::a059:70be:9c00:a3c4]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::a059:70be:9c00:a3c4%2]) with mapi id 15.20.1294.028; Sat, 3 Nov 2018
 15:54:13 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>
CC:     Lucas Stach <l.stach@pengutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
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
Date:   Sat, 3 Nov 2018 15:54:13 +0000
Message-ID: <AM0PR04MB42908FA25B4F44FE0C0FC243EEC80@AM0PR04MB4290.eurprd04.prod.outlook.com>
References: <cover.1539020938.git.leonard.crestez@nxp.com>
 <a3265a84052a7c11ae96e61e39adc988ca980d66.1539020938.git.leonard.crestez@nxp.com>
 <20181031061134.GB10386@tiger>
 <AM0PR04MB4290F31234D75AC7029F066FEECD0@AM0PR04MB4290.eurprd04.prod.outlook.com>
 <20181031150559.GA20437@e107981-ln.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4066;6:qsHJObmQ0YCRWnFmJeN5tnxkGhAlVL2vAivZd5hBUSywXch50YTN99exy9wSRrqUeLuSIGeiDSEUlLP3MPVjFO+KKAOE3J21SXvcOOF6oqwmrpywYPXhHW6146z6uaM4l9S9/Xh004MpRgsWbBSn3HOG/1KIhr/Nn187prbNgtddiuRRQMTKF+ogGV1s9cvwPYewL7yqfeGOWfvQDxvNAu330KUKevC4DKP4pOqAw2mU8mG4QYP6OOdz9DKJMbsE+mO6tUjJc17BT1QXum9s3wcCowl8DMMO5+hwBrVdOsxscdAoOVL6YhnX8dRwtqbfT5CKKP8HgUEDp1dtRV62pdUwurixoZCZBxIVBQ6r+BnYSPI3GsgwmqPew8iotupt/DDJl9UkBW8T/yMgoDPn8gytOgeni+ue95YLyh6L3qSmdqg/8A1CsNgCLwTQhEVbUMcROXd1KrenL+IIkknAKQ==;5:kiIwU9vLXf+M5mBGZ6jx9zOK5RKNnGHBy4dkRM/OJ0ahnrWm0qwU4IjsWpuFnJPXDHpOMJXZZLafXXNR34p0R+/g/OCQdUQvFaV/7lf1+7iZDZXZ9LcsVf8xBJ8Gcm+QF40DayS9aOQf3kR7YQaVt21CYWz6CnJDIOUgzwNW36k=;7:dCoUiWMvVeCeoqhsc7YbkVRqLKt+Ca4nR6VQHnCVY1GSrRrNrdxd86dy6+JSfVX/uMPas8cT2BDC13NodykqEpIGspuNYJ5mw1b5QHBQ/a8zrnfabYTBxCD0JkicAs2tRlOpGW7HTUfHBOQWLkstQQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7a89304e-d003-4047-f30e-08d641a49a2d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4066;
x-ms-traffictypediagnostic: AM0PR04MB4066:
x-microsoft-antispam-prvs: <AM0PR04MB40663DF10FF333E53FA2D7C0EEC80@AM0PR04MB4066.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040)(17755550239193)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB4066;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4066;
x-forefront-prvs: 08457955C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(366004)(39860400002)(396003)(189003)(199004)(446003)(74316002)(7736002)(305945005)(229853002)(99286004)(7696005)(186003)(71190400001)(5660300001)(81156014)(8676002)(76176011)(97736004)(71200400001)(81166006)(33656002)(478600001)(8936002)(53936002)(4326008)(14454004)(6246003)(25786009)(106356001)(486006)(105586002)(55016002)(6436002)(9686003)(7416002)(6636002)(2906002)(66066001)(102836004)(2900100001)(68736007)(93886005)(54906003)(110136005)(476003)(26005)(3846002)(256004)(14444005)(316002)(6506007)(6116002)(86362001)(44832011)(53546011)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4066;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: B3CmYR202Fey4zqz72Ntwppx09xpvysOgl3fN4GjKY9Ij3v5uQfXjodS1UJQDXMwWUjhyq3VZjNxP6xsLWIx1zo/jwBi2EXxbBMj3N+BDWskr6lcA+Ygzd8wsXzpoeIaoJsnPQ409Z+tdU2GcAPx7OugHiv3aYkMATulA+4MW1D3dl1bI90pMx55zdYQI4Wv0g67HmZTk3Mq+Vyji5IX0roFmTSmCxwAY3BRRNyLTecRdEEiTT2MgN7Q9+P3fugVaxW1NbPoINGjuKbx5RBJFWQrmCh5Cs4NCuKYOA8SqxPsFEg6oRbg/3Y4SflKzH00x9qL+/400CGwGEPAHecx0KQP8sXL7kHquKvbca8UdJc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a89304e-d003-4047-f30e-08d641a49a2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2018 15:54:13.5710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4066
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/31/2018 5:06 PM, Lorenzo Pieralisi wrote:=0A=
> On Wed, Oct 31, 2018 at 12:17:50PM +0000, Leonard Crestez wrote:=0A=
>> On 10/31/2018 8:12 AM, Shawn Guo wrote:=0A=
>>> On Mon, Oct 08, 2018 at 06:06:23PM +0000, Leonard Crestez wrote:=0A=
>>>> This was implemented in the driver but not actually defined and=0A=
>>>> referenced in dts. This makes it always on.=0A=
>>>>=0A=
>>>>   From reference manual in section "10.4.1.4.1 Power Distribution":=0A=
>>>>=0A=
>>>> "Display domain - The DISPLAY domain contains GIS, CSI, PXP, LCDIF,=0A=
>>>> PCIe, DCIC, and LDB. It is supplied by internal regulator."=0A=
>>>>=0A=
>>>> The current pd_pcie is actually only for PCIE_PHY, the PCIE ip block i=
s=0A=
>>>> actually inside the DISPLAY domain. Handle this by adding the pcie nod=
e=0A=
>>>> in both power domains.=0A=
>>>>=0A=
>>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
>>>=0A=
>>> Applied, thanks.=0A=
>>=0A=
>> As mentioned in the cover letter this requires multi-PD support in=0A=
>> imx-pci to be implemented, specifically PATCH 3/4 of this series:=0A=
>>=0A=
>> Unless that also gets merged soon via pci I expect issues in linux-next.=
=0A=
> =0A=
> I do not know what you mean by "issues in linux-next" (I assume you mean=
=0A=
> when Shawn sends the patches to linux-next in preparation for v4.21); we=
=0A=
> have not planned any other PCI pull request for v4.20-rc1 material.=0A=
=0A=
Yes my concern is linux-next for 4.21=0A=
=0A=
>> The patch already has reviewed-by tags so "merging it soon" is not=0A=
>> unreasonable.=0A=
> =0A=
> I can ACK it if Shawn wants to pull it, it may take a while to see it=0A=
> in -next if it has to go through the PCI tree, I think it is better=0A=
> to queue the series without splitting the patches across multiple=0A=
> channels though.=0A=
=0A=
This sounds great to me, merging the whole series through Shawn's imx =0A=
tree would prevent issues in linux-next or possible bisect failures in 4.21=
.=0A=
