Return-Path: <SRS0=j7M/=MU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE35C677D4
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 18:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B61E2145D
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 18:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wDJanayW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B61E2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbeJIBTS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:19:18 -0400
Received: from mail-he1eur01on0075.outbound.protection.outlook.com ([104.47.0.75]:22699
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726291AbeJIBTS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Oct 2018 21:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIY3YV7S65GLGcoQrJ63vxLzGJ1c1sFn2DTAWr3QDUo=;
 b=wDJanayWTS4TROpQB4Myskttt1C09XslvW80bjlQan0219/oMql1ZcnXSo0vwhB4aDkJnDm8vMPxYgZ1A+nCoOQFQdC9JUeIuonAHCX+Ucy4t1EI/YV1OcSyMOryy75uag5QoPzWiY1eILPHmwnm8Blr7SjGTU9LjW965HZM8K0=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB5172.eurprd04.prod.outlook.com (20.177.42.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.22; Mon, 8 Oct 2018 18:06:18 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef%3]) with mapi id 15.20.1207.024; Mon, 8 Oct 2018
 18:06:18 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stefan Agner <stefan@agner.ch>, Marek Vasut <marex@denx.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/4] ARM: dts: imx6sx: Add DISPLAY power domain support
Thread-Topic: [PATCH v2 0/4] ARM: dts: imx6sx: Add DISPLAY power domain
 support
Thread-Index: AQHUXzGcloJI0rQQ30eZCWcrc0Xveg==
Date:   Mon, 8 Oct 2018 18:06:18 +0000
Message-ID: <cover.1539020938.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [95.76.156.53]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: AM6PR0102CA0011.eurprd01.prod.exchangelabs.com
 (2603:10a6:209:14::24) To AM0PR04MB4290.eurprd04.prod.outlook.com
 (2603:10a6:208:67::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5172;6:z07B0kNNgwtKq2Z266vCSWbbyOr3+l6TgaS5SYSLTIsNMP7EE1CLWm1dS2pLTs4ZoxtfM/O2Zsps3/8XKPAF8tA5WOvKRMd6gi4MeA42ZwCgXiXqAjBfNLkVGkHmbGxQS2Aj/J+QdpZm8Z5Mny5Cw1ILvBcbkQaSlJhd3sVfa7ORLibzsE7FLpQh67heS7VikSe0JYZYoCO+QmekKmyN3MU0hOXmdSU7v2aDKUg9xp0Mauh0FpRtDuR8iCL/JcQBvObFFfRSWKq5H7676diUNOxlk+MukEwyFCIlQR5J/gJfJiMKVX0wRazGRNUedeZDUO6tc0/eGtj3/vN6NiLbGvFhyjtBpfS4Dt4Z/iZsEydfh7kPMoHvE9cp/V4OrsVC2Amd+q0iw6h4FwU06krN3RD/YTxjarIP6xG2xZF+2FdeCPvV2gMHkuTghrP6MSUHzhTOqRA71Na85SaYtGwYRQ==;5:qGU9fWSG/PkUqpes0urPuqGBtx+kmNF4W3XCE6PGlJ8o7/KIRiPpLxdQvhuwnZIvKPWYtmaTIbi0j8Qy5uJtvm8Pj4n1hPVmvQBrcr+4xhAbKHfQSqFtnmxwBHwTRtLbzER3EpmonI1BM4g5ruAF0N35YQ7r1c3JNIEuIC9L1rU=;7:sayAPoeC/0XA5/8brFJYX8seTYCq74mDwzk8RD49bZ6E0yGsvdGuSqbZLH1UocinZZTgRKDc6toR4vYX8dgwoBK//cc0y4ekR+BIs3l5/yksQna5uNjmwUf29N67USvH2m4Fe4fzG7n4GgS94eLmMx4ILRYZmpY0kBXA6MWf0bDO8hMBOjois0kXVAw2gRbuA4KOBgZliwNgZODZpHUHQilOVDoKPTcKwfmEocFbLb4dYlKYu+do5fv/DrpFf4oa
x-ms-office365-filtering-correlation-id: 356940de-6d42-4040-e6d6-08d62d48bea8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5172;
x-ms-traffictypediagnostic: AM0PR04MB5172:
x-microsoft-antispam-prvs: <AM0PR04MB517240C301B65F1AAE5414EAEEE60@AM0PR04MB5172.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:AM0PR04MB5172;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5172;
x-forefront-prvs: 081904387B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(136003)(376002)(366004)(199004)(189003)(2906002)(54906003)(25786009)(2900100001)(6306002)(186003)(14454004)(66066001)(110136005)(53936002)(6512007)(6436002)(36756003)(97736004)(71190400001)(26005)(102836004)(6116002)(6486002)(3846002)(4326008)(86362001)(256004)(14444005)(71200400001)(5250100002)(316002)(7736002)(105586002)(68736007)(7416002)(8936002)(8676002)(81156014)(106356001)(478600001)(966005)(6636002)(5660300001)(44832011)(2616005)(476003)(486006)(305945005)(52116002)(6506007)(386003)(81166006)(50226002)(99286004)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5172;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: nJg+G77inAc6ipAuK4PM7QIT843x8DD/fRceqPkelKm5PmetE7Yxq1eUgVxWjDvwmk5LP7x4JqgAAwoMceeJ2RvLMtg1HyjmLuWGDJrZsnDU9ivqrcOg9f8fLjQ+wHbw7ulISkgNphsghxGvSQh8bHrtka3s4z5Xg6ZHllfIl+SVH+PgkDch/Y7BrMYMDbpZB/H114/zdA/knJKv1V1D7UN0BVDy8MUc+fG01fa2KipqgRUiy9LdEplgROocgbxH9N/mdz5AK5dhUgs1mzuowDP1InXawMwCyT9WaoRRV6lFfNf6HZl8zQSQRg61q15jQrjjUeqRyqp84vIm5tCPvi87I3BnLP5w9YKpesIRPzc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 356940de-6d42-4040-e6d6-08d62d48bea8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 18:06:18.2341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5172
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that mxsfb has functional runtime_pm support we can enable power
gating for the DISPLAY power domain on imx6sx.

Since pci-imx doesn't support runtime power gating this is still
always-on unless PCI is disabled/unused. But it's reasonable for an imx
board to not have PCI.

The current pd_pcie is actually only for PCIE_PHY, the PCIE ip block is
actually inside the DISPLAY domain. This is handled by adding the pcie
node in both power domains, using multi-pd support.

Series is against linux-next. The last patch needs runtime PM in all
drivers or it will cause hangs. This means Shawn should hold back on it
until the PCI and mxsfb dependencies get merged (both might take a long
time). So you can just review that patch and I will resend it later,
perhaps in another cycle.

---

Changes since v1:
* Document multi-pd in imx6q-pcie bindings and add DT list
* Don't refer to "DISPLAY" as "DISPMIX" because the Reference Manual
doesn't do that.
* Link to v1: https://lore.kernel.org/patchwork/cover/994092/

This is independent of other imx6-pci PM patches such as this one:
* https://lore.kernel.org/patchwork/patch/996806/
Device links are quite nice!

Link to mxsfb thread: https://lkml.org/lkml/2018/9/26/1185

Leonard Crestez (4):
  soc: imx: gpc: Increase GPC_CLK_MAX to 7
  dt-bindings: imx6q-pcie: Add multi-pd bindings for imx6sx
  PCI: imx: Add multi-pd support
  ARM: dts: imx6sx: Add DISPLAY power domain support

 .../bindings/pci/fsl,imx6q-pcie.txt           |  4 +-
 arch/arm/boot/dts/imx6sx.dtsi                 | 19 +++++++-
 drivers/pci/controller/dwc/pci-imx6.c         | 48 +++++++++++++++++++
 drivers/soc/imx/gpc.c                         |  2 +-
 4 files changed, 70 insertions(+), 3 deletions(-)

--=20
2.17.1

