Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26567C43610
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 09:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6AC42075B
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 09:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bPkLHfoh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6AC42075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeKTTzk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:55:40 -0500
Received: from mail-eopbgr70054.outbound.protection.outlook.com ([40.107.7.54]:22608
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727619AbeKTTzj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 14:55:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YoA/AjZZM10D7utpJ22+WJNHEtNZ6Oqk3ZBm1m/xwIg=;
 b=bPkLHfohSOCeCO4r4RbLBlPxvuRNSeYnYlJqcbsxBOaUf5oq4seXUQgo9Rro+BsindyZI+kpGrOvAEKCmHky2/tD45gSUjHj22q8mKaSo/ekb+Ijwi/L8X+Hn5MM/l2GBHYpUS2/cEVw461x5LmP4DKBDwp3NiulVqroy21n+dQ=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB5269.eurprd04.prod.outlook.com (20.177.35.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.21; Tue, 20 Nov 2018 09:27:27 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c%4]) with mapi id 15.20.1339.026; Tue, 20 Nov 2018
 09:27:27 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>
CC:     Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCHv2 18/25] PCI: mobiveil: continue to initialize the host upon
 no PCIe link
Thread-Topic: [PATCHv2 18/25] PCI: mobiveil: continue to initialize the host
 upon no PCIe link
Thread-Index: AQHUgLNAYjS1Cnpgq0ebuFei+bnlwA==
Date:   Tue, 20 Nov 2018 09:27:27 +0000
Message-ID: <20181120092615.11680-19-Zhiqiang.Hou@nxp.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR03CA0050.apcprd03.prod.outlook.com
 (2603:1096:202:17::20) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:aa::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5269;6:S3birnnWbAGQzE2QICPiXbS1qAalb4WdNZofL7aVfXGJWnofSxgID0YxE31NIuAItRvtiLfAnLzc9YinxLtnZ2Mv2qHu1egiqbQ5g1foSCttvAyUCMSbnMoADeS3Fu4XvtYJqKivErdzgpuGGs+80BLLYjXXwTkMibgV/KkUDZl6Y9HioLTfG65uUek7UWUm7AmXIfDUo3XW9jERJBkWIFjc7hnw/jwH42+dKwc7EEdtuHxdrF/b1kw7kjIrNcFvy7HIxLTuC5EBPPRNRlSSxX50SrHvZ37LqHPOwFPeunn0/LNk/jcnHE44njbeC1mIrdjItSYRxkXR6liN1dhwvDwLMKUHTNFug3TSyFwBBke5WeQnM0YKuF3OysvgqzA9zUEIjUUwqWi/R20dvQjWb6mJ5J9cSg1ngS1yPd2otsZRPc5PQYXUOeSbv9bBF57JNszD9QUGP+/JvoxDepENFQ==;5:UN2o2hCVFQ1sgbIj+1ZfB9f7QS+aUhL9fLfQdEF/rCU2DdFlOpMWQ2zEBmm3+y+GF1yb5cWUTOT/XPELwDKD+ts9jCqTnn6ibYj0Q3Bh4vi+I1dIMSS9LJSqVlz9RrrWki2ggIdKmnsSHHG0aNNzvXwCEP3yzUCaGqEDaXblVVs=;7:q98zfKsnFuUQrr7s6ZWuZyf1QUJbL72M8ttE1PnUYiIpOvNt3B7dllgw6CbTbO+uDQAEMHU316gMfCT4uxl1U4HX8e3oWcbHtm4rF0/bs13DFvE5QEICTXp1DfOmYsZeTeR2qG8JrtM8javdla+huA==
x-ms-office365-filtering-correlation-id: 70739860-93e6-4c80-bb33-08d64eca6309
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5269;
x-ms-traffictypediagnostic: AM6PR04MB5269:
x-microsoft-antispam-prvs: <AM6PR04MB5269902648DC6A99EB1FE57084D90@AM6PR04MB5269.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5269;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5269;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(366004)(39860400002)(189003)(199004)(305945005)(7736002)(36756003)(5660300001)(7416002)(68736007)(2906002)(4326008)(8936002)(14454004)(256004)(54906003)(53936002)(6436002)(71200400001)(110136005)(71190400001)(6512007)(316002)(2616005)(476003)(446003)(11346002)(486006)(25786009)(2501003)(2201001)(86362001)(52116002)(76176011)(6506007)(102836004)(386003)(186003)(106356001)(26005)(2900100001)(81156014)(81166006)(105586002)(6486002)(8676002)(99286004)(66066001)(6116002)(3846002)(1076002)(478600001)(97736004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5269;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9HTjv+z2bYw/wa6pqkV2O2iSJptTBF8dqQixbJX9YB/RJu6l3j3hkOjYtGRt7y6rw0XKrFJY8K1AFZYR+vHZ4V3/3NZ3MfBNA9KFn3Za+wToOVJtw8DfvqzDJ+JUsAXsQbiBkTATc4uFmwsuxDoh19KWUJ6RGlor/1p1EqylegbdyLaBbR0qvDYK3V5yy7BrpqU6BDnxhsx+0C2+M36wrRS2L4k4AVfkbl0R5u8wfdxqzM/W5m9ZQkBD1KWGvwJaW4AR4KIuLpS+CDwqkNLOPFVjltokq8vrdY5jgB0mWovVKtrj2mc2RQzgOAK2QPm/QeeD734Gwo0PIn3eUXWVCB/yN+M6tFnFCpGdQgq3LK0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70739860-93e6-4c80-bb33-08d64eca6309
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 09:27:27.4102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5269
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Sometimes there is not a PCIe Endpoint in the PCIe slot, so do
not exit when the PCIe link is not up. And degrade the print
level of link up info.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V2:
 - no change

 drivers/pci/controller/mobiveil/pcie-mobiveil-host.c | 1 -
 drivers/pci/controller/mobiveil/pcie-mobiveil.c      | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers=
/pci/controller/mobiveil/pcie-mobiveil-host.c
index 1ae82e790562..d1765d572f44 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -596,7 +596,6 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie=
)
 	ret =3D mobiveil_bringup_link(pcie);
 	if (ret) {
 		dev_info(dev, "link bring-up failed\n");
-		goto error;
 	}
=20
 	/* setup the kernel resources for the newly added PCIe root bus */
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.c b/drivers/pci/=
controller/mobiveil/pcie-mobiveil.c
index ee678a60825d..370658d6546d 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
@@ -222,7 +222,7 @@ int mobiveil_bringup_link(struct mobiveil_pcie *pcie)
 		usleep_range(LINK_WAIT_MIN, LINK_WAIT_MAX);
 	}
=20
-	dev_err(&pcie->pdev->dev, "link never came up\n");
+	dev_info(&pcie->pdev->dev, "link never came up\n");
=20
 	return -ETIMEDOUT;
 }
--=20
2.17.1

