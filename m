Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAA4C32789
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 13:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B112085B
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 13:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fryNB+Yn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B112085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388409AbeKFWpZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:45:25 -0500
Received: from mail-eopbgr20042.outbound.protection.outlook.com ([40.107.2.42]:4545
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387913AbeKFWpZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Nov 2018 17:45:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVB+Q3p2TSvssytRdo1ioIXIUh9auspubyHuck3Lfqc=;
 b=fryNB+YnFa2EC2sdXZjjq8wa1nS40q2UGK06XNUQ9t18TssAyXLCW+YtzAoHSf0oZ1Th6BWOdGgP+YWrmLRdFaznod5wwomb/QlmLFr0kJvmvAFBvurtlHjr73kMOofUm/ofiyXzSXBUlxbHQzEpR7ZMMW6B73rj75Cus4Ihtxs=
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com (10.162.155.27) by
 DB5PR04MB1414.eurprd04.prod.outlook.com (10.162.221.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Tue, 6 Nov 2018 13:20:10 +0000
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb]) by DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb%2]) with mapi id 15.20.1273.035; Tue, 6 Nov 2018
 13:20:10 +0000
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
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCH 10/23] PCI: mobiveil: fix the INTx process error
Thread-Topic: [PATCH 10/23] PCI: mobiveil: fix the INTx process error
Thread-Index: AQHUddNxtNgB2s9yF0+e35QgaH10Fw==
Date:   Tue, 6 Nov 2018 13:20:10 +0000
Message-ID: <20181106131807.29951-11-Zhiqiang.Hou@nxp.com>
References: <20181106131807.29951-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181106131807.29951-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0008.apcprd03.prod.outlook.com
 (2603:1096:203:2e::20) To DB5PR04MB1221.eurprd04.prod.outlook.com
 (2a01:111:e400:51c2::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB5PR04MB1414;6:d08o9ZVklfQwu+oTAMmRn/9YziXgE1YANy66qM7g612HYi8O2DmUCeNYPhwqKcsCl/h61OYt+rhf7eXqz+3BzlLho6hvoLW+9vlv3OX3UQO/w2CIFX+xrdWt60zBGWgEp0aqKXh4tow3xazsP7Q4gKjRV4sCzcdY56OWOVGqFljvSPV4EBefTGXi+olVMVWqjGpzJX66qvCLaIGyMW3DRJ+LLoB19s4JwxY5hRvkm3b9vmABFSZtuV/ZWgbQzajRsjjrbQNMTF0fwM9bV2uu+qi8cNdqMm2x+xdNs8p/6BU1lidAuEfX0LO3JeCEordn+QVJUS0dHscY/knrRxAOVvoU1i0GiozQ25F5mUU+ii1fCHUcI90QF4OvfZxTg6PNLtXHMpqiYMEWSFySSlLz3JKIMIwJewEic9RhPkWHMT+Wo0HSj6qhE1vxu3dkPPElcA3GKLXtPdxzdqndMiLISA==;5:o8KxXnzkeI02o0nVd3i0Q1haNwb+hNHcVUx8Mn/Pk4I++uOkPZraOjElvW/BkxBUWU++5SOlVrHLDLDitB3eFcOQ7R/wqYESJBX7W/Zh5NLbu/uLGOVFGGhln+b8yLdOrD9sKHHY1oKvVLnW+A5FMSYcT0+FxLvrnxnvRJIiYcM=;7:lnvLsATFXbSE96y+anN1Tk+roFBaY4/y9MANxfMH/n3NkcBJ29kLKcey2pk0KGRr5UqRrN2Y/zUEYSJXLtP2bxACo0S4/uHZDLKQivtqA0I087EWkezZNshiWrkmkWq6Oi/IOOK47CY1Jjok2zxnbQ==
x-ms-office365-filtering-correlation-id: dbcc4256-4f20-4e1e-2442-08d643ea93ba
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1414;
x-ms-traffictypediagnostic: DB5PR04MB1414:
x-microsoft-antispam-prvs: <DB5PR04MB1414B1381AD1B387CA9859D584CB0@DB5PR04MB1414.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB5PR04MB1414;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1414;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(97736004)(66066001)(8936002)(81156014)(81166006)(7416002)(8676002)(5660300001)(71200400001)(71190400001)(478600001)(6486002)(6116002)(2900100001)(1076002)(53936002)(6436002)(6512007)(305945005)(4326008)(25786009)(7736002)(105586002)(106356001)(68736007)(2906002)(3846002)(256004)(26005)(486006)(2501003)(14454004)(99286004)(52116002)(76176011)(36756003)(110136005)(386003)(6506007)(102836004)(54906003)(86362001)(186003)(446003)(11346002)(316002)(2616005)(476003)(2201001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1414;H:DB5PR04MB1221.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cnwPQLha4W3N5kWd35YpjtlcA6kOFOaV3IlWuALKXoDyhA3cYjhgIinfj1cNxEqHLFUQ0shAE4N/2g3788XjhWrfCYL6rR9/BPWLGvDl656hqb8aMZv9IIzdpvSs4KuZpybHOwxw83cpxLJ/h4i4CtIliyvcZACSDa4sHPFdxGGZI16Y1sQa5bD9cfgxqZrYaxtdXmsrgWj4bq1vdbOTyXRqiZMHnHUKYKF3AP2w/WqThWsAS71q79g06k6nwWwEh0A3aiTrRXelYVmFXzrQO+h6pFBBZE+P/NwS3H4ZPzyCgvR7dRMmMtgpiuKGSUXcxMK49S+0gp28ObB7/M2LS6cMMglDqjt1ftG9pe40qwA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbcc4256-4f20-4e1e-2442-08d643ea93ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 13:20:10.2694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1414
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

In the loop block, there is not code change the loop key,
this patch updated the loop key by re-read the INTx status
register.

This patch also change to clear the handled INTx status.

Note: Need MV to test this change.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 drivers/pci/controller/pcie-mobiveil.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controlle=
r/pcie-mobiveil.c
index d03392940944..884c9f95374d 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -361,6 +361,7 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
 	/* Handle INTx */
 	if (intr_status & PAB_INTP_INTX_MASK) {
 		shifted_status =3D csr_readl(pcie, PAB_INTP_AMBA_MISC_STAT);
+		shifted_status &=3D PAB_INTP_INTX_MASK;
 		shifted_status >>=3D PAB_INTX_START;
 		do {
 			for_each_set_bit(bit, &shifted_status, PCI_NUM_INTX) {
@@ -372,12 +373,16 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
 					dev_err_ratelimited(dev, "unexpected IRQ, INT%d\n",
 							    bit);
=20
-				/* clear interrupt */
-				csr_writel(pcie,
-					   shifted_status << PAB_INTX_START,
+				/* clear interrupt handled */
+				csr_writel(pcie, 1 << (PAB_INTX_START + bit),
 					   PAB_INTP_AMBA_MISC_STAT);
 			}
-		} while ((shifted_status >> PAB_INTX_START) !=3D 0);
+
+			shifted_status =3D csr_readl(pcie,
+						   PAB_INTP_AMBA_MISC_STAT);
+			shifted_status &=3D PAB_INTP_INTX_MASK;
+			shifted_status >>=3D PAB_INTX_START;
+		} while (shifted_status !=3D 0);
 	}
=20
 	/* read extra MSI status register */
--=20
2.17.1

