Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5832C32789
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 13:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9460420869
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 13:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Mm91Heii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9460420869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388481AbeKFWqJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:46:09 -0500
Received: from mail-he1eur01on0070.outbound.protection.outlook.com ([104.47.0.70]:42149
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388257AbeKFWqJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Nov 2018 17:46:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lb2IMZBFlQIytfd9EOGRKi3YEAR8o4+NIFs8xDjcSss=;
 b=Mm91HeiipkYgNULF/YVjt7FHUvXc49MUHOAr1u7O05mPKw1t2knmYqEC8i4MfbURNLlOWi8o/VvMjHS+BRbf9Kwf0ijdzEnQQE+RkZLCe7cz/5wFmylGXL0dgswUXGjByLHRf8Adq2W9QYS1xgQ1SkN9o5oyU1i7X0QxJenK6sc=
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com (10.162.155.27) by
 DB5PR04MB1414.eurprd04.prod.outlook.com (10.162.221.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Tue, 6 Nov 2018 13:20:54 +0000
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb]) by DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb%2]) with mapi id 15.20.1273.035; Tue, 6 Nov 2018
 13:20:54 +0000
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
Subject: [PATCH 17/23] PCI: mobiveil: continue to initialize the host upon no
 PCIe link
Thread-Topic: [PATCH 17/23] PCI: mobiveil: continue to initialize the host
 upon no PCIe link
Thread-Index: AQHUddOLMi7Bc9hStkiEwUyEZdwaYQ==
Date:   Tue, 6 Nov 2018 13:20:54 +0000
Message-ID: <20181106131807.29951-18-Zhiqiang.Hou@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;DB5PR04MB1414;6:GA5uPTqjIGv6+vOHQKhWS11ffQsH6v8BslFYzQ51lDabpHX5R8sC1NXG1skCjdo4YYviwfneP4NQvHmgVt63hGq7Vu2c7tl2FLy+zEcb4j3GRC2PL0XlaJu86KyppzVRCq+t/J06aq14PegLQlLOk6zvNmQukV/LV/R9HlC42UNKUiGUEeb4iR0kCthDcGXNRQjgxEoJ4ojrWz16T4NPTxG64ts2FiGfMvmYwGxMTMjtWAPaBIaoUyM04z9XXOIz4Klm+x15azhfD4iQdZEpl9GXMumCuZ87uAjz30BzCKVVOlmBA40t2Okq2DhqLZioP0jNPssuy6BE66pGLVw6gAWWkwyyUmrZQw4MTRClvSdw4TtbtyhrPP9mI5bQD1wMBb2aPdrJqc4Vt0+oug54EI2N0wdeV7ySlGWqc7CBrqgJuB6RTcgm4Olbr0pwvhCLFlWdHpUpGxiC27Dudal3jw==;5:nx90jrA51+8oJXSr8jEWOKipAY77+G+G05A3FxU5+ahcwf87SzFOUts0tEZjzE1iUkIV1hzMv07V09Q8Jbjv9PAn7voHkkijd63kmbKQrPQPPak7r/Z7B8e6DkCYtJFpXf4F0K03/yetYep1PzxuECQJjH6Yb1hIZx5HltuyOkE=;7:pXVT6ZNd65St6AzpapWiqYgfubx2zKUjqSa12JHo9Vph6OBdx8Inc/6/TKnZPRdCsA5gkkNEXQy0f6Vi4+a0wjYNlJFhegxbGgH0tVQcbFLibI/0CHu8TNGFLsRJ3hNG15bhu9LQ1rAlMOprs4tdNA==
x-ms-office365-filtering-correlation-id: 23e6ed78-0b4a-4c62-00c0-08d643eaae0d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1414;
x-ms-traffictypediagnostic: DB5PR04MB1414:
x-microsoft-antispam-prvs: <DB5PR04MB14142CD4E80E06E30A9C71DA84CB0@DB5PR04MB1414.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB5PR04MB1414;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1414;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(97736004)(66066001)(8936002)(81156014)(81166006)(7416002)(8676002)(5660300001)(71200400001)(71190400001)(478600001)(6486002)(6116002)(2900100001)(1076002)(53936002)(6436002)(6512007)(305945005)(4326008)(25786009)(7736002)(105586002)(106356001)(68736007)(2906002)(3846002)(256004)(26005)(486006)(2501003)(14454004)(99286004)(52116002)(76176011)(36756003)(110136005)(386003)(6506007)(102836004)(54906003)(86362001)(186003)(446003)(11346002)(316002)(2616005)(476003)(2201001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1414;H:DB5PR04MB1221.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: exWZlm7pys8MTz4IQxWEEGpoRjm/00XEYgYuEJAnmagq+R2iOmhIiEkOaFE6+X2XBJUFAgAIzpNcY51mWLJzJEIfuLOVgvbkm+ASUZjZGYBPrE0ClyVqGGIYLU6lx8sEsxFMm8JmiEczYZzqGh7Gg8ipb2oJfuzGmMMnn6X+JNVu1iERd4J3o0KxQJtq4nfKvHJntWphHJU+d9BcZ67tJ20hcD+4oloGWbhCw/gtnvsvjO/rZIy2LhmMZlRae8mBN1Iv/XHDtgljwMpx3s2BszoPCx4XWRdarxkNWG3SdbyP13ZpYPpKT5dSPXNVmI9vSiMBLt3y4/pGxVk12Cx9VmloHnPNblFvcJSdVymtn40=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e6ed78-0b4a-4c62-00c0-08d643eaae0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 13:20:54.3792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1414
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
 drivers/pci/controller/mobiveil/pcie-mobiveil-host.c | 1 -
 drivers/pci/controller/mobiveil/pcie-mobiveil.c      | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers=
/pci/controller/mobiveil/pcie-mobiveil-host.c
index 383b2f3947a5..4419179f64bc 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -591,7 +591,6 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie=
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
index a25ebdd23592..71389ebbf229 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
@@ -221,7 +221,7 @@ int mobiveil_bringup_link(struct mobiveil_pcie *pcie)
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

