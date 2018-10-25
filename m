Return-Path: <SRS0=18Ni=NF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871F5ECDE46
	for <linux-pci@archiver.kernel.org>; Thu, 25 Oct 2018 09:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ECEA20834
	for <linux-pci@archiver.kernel.org>; Thu, 25 Oct 2018 09:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m47cjoRa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ECEA20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbeJYRym (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Oct 2018 13:54:42 -0400
Received: from mail-eopbgr30072.outbound.protection.outlook.com ([40.107.3.72]:36992
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726785AbeJYRyl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Oct 2018 13:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwqeRYWI2ZrTiXz3DtAf7xwrHwMC/HTBR7Bjdhkay5k=;
 b=m47cjoRaQstkJ4g+S4iFUV5pwj2ltwAwND+z99niyrroiXLuIo4jMWRtXQNb32LPdJz/PkqUc6tCLSdkoFNWA6HfJ7E7DH1eP1U7wTaqT5PWBiXZUgmv/oLw6mxKWas2yFJKnck7SeastQt51/CEYM/rVY6eGJ+4BkPFsqJAYVw=
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com (10.162.155.27) by
 DB5PR04MB0952.eurprd04.prod.outlook.com (10.161.195.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Thu, 25 Oct 2018 09:22:45 +0000
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb]) by DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb%2]) with mapi id 15.20.1250.028; Thu, 25 Oct 2018
 09:22:45 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
CC:     Roy Zang <roy.zang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCH 3/4] PCI/layerscape: initialize the number of viewport
Thread-Topic: [PATCH 3/4] PCI/layerscape: initialize the number of viewport
Thread-Index: AQHUbERKdFptZfo9y06n6wAEdcBBgA==
Date:   Thu, 25 Oct 2018 09:22:45 +0000
Message-ID: <20181025092229.28413-4-Zhiqiang.Hou@nxp.com>
References: <20181025092229.28413-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181025092229.28413-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0P153CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::22) To DB5PR04MB1221.eurprd04.prod.outlook.com
 (2a01:111:e400:51c2::27)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB5PR04MB0952;6:oNhuikFHMw1NE+je8+n3f8KDxXPC680wSlO3HjlWFKQc2FunrZaRs86hTesf+b9VAJ7i2fQOLCUXr8KOYfYowlusPaE+CFqh2LXdOdxBZM5fHa+gxRIudOBolZg2+PQKPzoszOueoSpxM53ZT1ZQktNXT66/mmWThc82XGn678/Hwa/cTX656sx73PL6Fkc0Ot+Dh6KBCcSXQjp9Knv0GK0hhr/IlVSfNRFDm2H1mlGcN3rqRw1b6qav1o+zZUvU+Tr64sxhhWuCZ4FGzydFD+iKj224NwVEDX7HC/FBDJ6acrJ/427E6gUdubrVnV2oIKu9pxVqgTWtgRrChfrPC1R/QBBWtPciFi7wpFvmDlcfkL2owhAUn/2fv+zqmr4an9xp8x2CooYwv9PXeYqzy9zJC0VJ1BstnOO01RKbP7xWTyLboODVLr80QsMUMMSJifplzh3azUpg9Q5z5y9hvg==;5:iHsKebvizAqNKYhZFqEAYHGJNFpFnjVipPR9qQo9F1Y/KYWJE4X2ioFJoD28NV/1sgau+WW4gvvlKM9qNAuztRZp9qYZ5QAphGqUOE6XuASfLvojUVNNlpYb+Igtc5ua9lpyF+/aqx30DuwbyaW+hAlszf9J+btlpqQCN/j/eL0=;7:cgIQxSN93keykmEFNJ/Dp7rV7VvTh7D6lzbU3lwiEI6k7+ocJ7wfZVlm/Dh1NlFdFQU1RvbuZmGlFtQqZQn9GesdwHijhRsYX2CfvPxfjKllLUH8hRpOBQs3BolU0uW2Jp612LamFR+fU5g4aQp7TANChA/gRVCd865eNq+ANvdr6F5nuPlfIwoOPUna8t6T1qPMZVGpCYTXxwLc2oUQNITzAPaobhMib5/PYKdr+oD8mh44N3BJrMp0bUsrAwJh
x-ms-office365-filtering-correlation-id: 6079341c-f9cb-44a1-2f4e-08d63a5b6c45
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB0952;
x-ms-traffictypediagnostic: DB5PR04MB0952:
x-microsoft-antispam-prvs: <DB5PR04MB0952C58E9B7DE06582E86EDB84F70@DB5PR04MB0952.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB5PR04MB0952;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB0952;
x-forefront-prvs: 083691450C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(346002)(136003)(376002)(199004)(189003)(6512007)(6436002)(97736004)(6486002)(39060400002)(99286004)(81166006)(4326008)(81156014)(53936002)(106356001)(25786009)(105586002)(2900100001)(102836004)(11346002)(7736002)(8936002)(446003)(2616005)(256004)(305945005)(476003)(186003)(478600001)(86362001)(8676002)(26005)(68736007)(2201001)(6346003)(486006)(6116002)(3846002)(386003)(6506007)(76176011)(66066001)(2906002)(5660300001)(36756003)(1076002)(14454004)(316002)(54906003)(110136005)(71200400001)(71190400001)(52116002)(2501003)(5250100002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB0952;H:DB5PR04MB1221.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-microsoft-antispam-message-info: 1uoEmt0U8ObnqBT6mlHrb9+MH8B0dtV7p1Aemw72wxdNT8qp6+WHoSuFEkCdN+dMcl2Ykq7F3nWhexAsHu0pxwA53PWxF1s6+Z55S5vq/iAG/Dfwnvfr8EH9kX3FHtldefQCvqpsw0eajGJUajbyisrw3GFUhkklx9S2601tCXPcIApA9uUfepLuq2VKRLoXlsvbwz3nih3tHDR4uQTLd+insEmfeedd0ubmXR0UXYgNt4tcB+Df90S8IjwmVNjs5zjyQ4l02p7HAI16wjdC4wbEhvxeVVEyS7nsp4rCfh4WqRnzUVF02Enw/8gpJ8eS3S0pOL3rWa39ZoNvRT9I6P3fvAhr8qXyIdZStiMtQWM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6079341c-f9cb-44a1-2f4e-08d63a5b6c45
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2018 09:22:45.7881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB0952
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

FSL implements 6 viewports on Layerscape series SoCs.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 drivers/pci/controller/dwc/pci-layerscape.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/cont=
roller/dwc/pci-layerscape.c
index 3724d3ef7008..69f3f1a5a782 100644
--- a/drivers/pci/controller/dwc/pci-layerscape.c
+++ b/drivers/pci/controller/dwc/pci-layerscape.c
@@ -280,6 +280,9 @@ static int __init ls_add_pcie_port(struct ls_pcie *pcie=
)
=20
 	pp->ops =3D pcie->drvdata->ops;
=20
+	/* FSL implements 6 windows */
+	pci->num_viewport =3D 6;
+
 	ret =3D dw_pcie_host_init(pp);
 	if (ret) {
 		dev_err(dev, "failed to initialize host\n");
--=20
2.17.1

