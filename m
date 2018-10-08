Return-Path: <SRS0=j7M/=MU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C087C65C20
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 18:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C8552145D
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 18:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KUGcksuR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C8552145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbeJIBTY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:19:24 -0400
Received: from mail-he1eur01on0075.outbound.protection.outlook.com ([104.47.0.75]:22699
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726291AbeJIBTX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Oct 2018 21:19:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OICJA84Kpbp+o5PF0RBF+mWQIjpD7go7k+ONlnEhH0=;
 b=KUGcksuRY1hyLEY1uggWiU5bYALp5MHJg1Uc7r99KVsB0lzxEN97ePf+KpzL41E1fPb2OTOyI7fjS0WScVYNM9cPgwrtbkPzmupPLCei3oFh+CtxVvQ5Y82TzIYM1Lhh3klZGFfo6L00kFMUtXX0Ipoq9yiYNVjVws7WoxB8Qj0=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB5172.eurprd04.prod.outlook.com (20.177.42.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.22; Mon, 8 Oct 2018 18:06:20 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef%3]) with mapi id 15.20.1207.024; Mon, 8 Oct 2018
 18:06:20 +0000
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
Subject: [PATCH v2 2/4] dt-bindings: imx6q-pcie: Add multi-pd bindings for
 imx6sx
Thread-Topic: [PATCH v2 2/4] dt-bindings: imx6q-pcie: Add multi-pd bindings
 for imx6sx
Thread-Index: AQHUXzGdQHtjla47r0y4gaeEfNFd9Q==
Date:   Mon, 8 Oct 2018 18:06:20 +0000
Message-ID: <fb622df91d2e4aa339e8831fb8bcde03327f5bda.1539020938.git.leonard.crestez@nxp.com>
References: <cover.1539020938.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1539020938.git.leonard.crestez@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5172;6:HZcWNLa5NjBEn8RZkC4PYqYTUoDXFn5vUgh+JAec8GWwl2/OBrmWCj/47+GCXgxRejDY8o2Ua1yoVyI5lvrw4fQT2IX4uK4k1t5lr0x2JSqYq7WhS2OjQAuBtf021WMxL5kJU9fe4os1zds4bpEoeaO0OI0k6sHmuwQdos4qQkPcOCLp5zOkvekUPUBBZyFhnKPCs7WOaKnCtNNbCuuEcttmce2CWxFOkCMsyMkh8UrFO4eD6zO59NMuDzoBtDVazQ5rRsKEk5O0nAeQG6AaSxc3eF7TKgnelQBkf5IG47set+E0KpHKOdDICrqC8vuQXZlhsVNiL/qtgSMqoojp2TZVqnYPdBl7NCxo7dj1UIJ7EYZXXYhN8AAREy7eJKlJ8hqryky6WI8OLI20HneOHJhqraoopXlGsjR7zVu3Hp1lBpboid4quWcSsZc8uyHhH3viW67TQouGj/p3TChWtA==;5:0rCpUs2Neq6pIXCgKt6hC+PD71O1hr2mJMUH1fzRbvgSYOa3bLaSKO20lQniwsR4hg5B7owSxNsl+JAi5ZJ4lB57Bpx5mItIuv0bKYVilF1m0fHvk30iIuGtKFenKbscLLkYo3sJy02eN20KIwBv49WPo0a+4AfJ+Yh9A/AmvqU=;7:+2F07jSqlZT+CjUzzecJEilYDobZhOwb1RvB6/UOQxY/8mqb3/hw3fGKKbtdA5DtkGcs5Tak3j3fS2Ty3uildTXB/bly4wTAEPuTe8pRAGo3Oi3pUZzYOk+no1qhkjb5HMHKt4dEEijpY4a1uvneZ9hCYU+RgkG0QfJKxfh+3U9nC7lmKozztOsPT60VQaa7QG1nTRHLgrI7wANhJPyDyAgPKULl/OfFBsnt272lMiBDx3C/BoxBSOFJTJ52oH81
x-ms-office365-filtering-correlation-id: ab408df0-1080-46d0-2590-08d62d48c016
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5172;
x-ms-traffictypediagnostic: AM0PR04MB5172:
x-microsoft-antispam-prvs: <AM0PR04MB517221365F3C2A4F752EB4D8EEE60@AM0PR04MB5172.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:AM0PR04MB5172;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5172;
x-forefront-prvs: 081904387B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(136003)(376002)(366004)(199004)(189003)(2906002)(54906003)(25786009)(2900100001)(186003)(14454004)(66066001)(110136005)(53936002)(6512007)(6436002)(36756003)(97736004)(71190400001)(26005)(102836004)(76176011)(6116002)(6486002)(3846002)(4326008)(86362001)(256004)(14444005)(71200400001)(5250100002)(316002)(7736002)(446003)(105586002)(68736007)(7416002)(8936002)(118296001)(8676002)(81156014)(106356001)(478600001)(6636002)(5660300001)(44832011)(2616005)(476003)(486006)(305945005)(52116002)(6506007)(386003)(11346002)(81166006)(50226002)(99286004)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5172;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GDeeGYqkqGnhEaNxoexXU9Dx/wvWMiCQJBa/K9Uf89z+npOa1bd8hL0oWMinuntfmERC7WU1taP5E3yDAjiRytXDNWIlzWhFRJhMgUXMf9yrNBdaVSKU3K1EBQw5XY6JoDwXfKaqgREudiZZh9RcWI51LhB/pDhfDSw00KNTP5a7SCis/7ZOeOOkcQL/1xKrDXXuIBPyzuPxiqIi9yMBINiCGbi1SIYlYOEBnrSy+tlX4gwzvyU4L1yr6fQHUfxtotjUzpjg0phM5zVmSQ2KgA4U++pR4hW4vgzI0xo55d0TVq7+yiWl1MakdOOEO4TA/oj00menzC3nT5I2Targ64FIKlQz9N9uh42IoYSf3/M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab408df0-1080-46d0-2590-08d62d48c016
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 18:06:20.6228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5172
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCIE and PCIE_PHY blocks are in different power domains on imx6sx
and this needs to be described using multi-pd bindings.

This was not required until now because the power-domain of the PCIE
block (DISPLAY) was always on.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Doc=
umentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index f37494d5a7be..d514c1f2365f 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -39,11 +39,13 @@ Optional properties:
   host.
=20
 Additional required properties for imx6sx-pcie:
 - clock names: Must include the following additional entries:
 	- "pcie_inbound_axi"
-- power-domains: Must be set to a phandle pointing to the PCIE_PHY power d=
omain
+- power-domains: Must be set to phandles pointing to the DISPLAY and
+  PCIE_PHY power domains
+- power-domain-names: Must be "pcie", "pcie_phy"
=20
 Additional required properties for imx7d-pcie:
 - power-domains: Must be set to a phandle pointing to PCIE_PHY power domai=
n
 - resets: Must contain phandles to PCIe-related reset lines exposed by SRC
   IP block
--=20
2.17.1

