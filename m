Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C49C32789
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 13:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2BBF2086A
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 13:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z3Xu/sa4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2BBF2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388257AbeKFWou (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:44:50 -0500
Received: from mail-ve1eur01on0044.outbound.protection.outlook.com ([104.47.1.44]:4455
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388116AbeKFWou (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Nov 2018 17:44:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qb0/iYVXl5Bpc+MJ4m43iRbJvao/IFvoOxipmC6V64=;
 b=Z3Xu/sa4Frm/2mraKn+9YDRuKnHvq3w1DzegoDJTfY2Q34I/VvwhF210/dfvZbyH3ICk/rQWJwV7PCaHPv52B+SpnuShO+hyItR89+LK4aQ6721c7mSb7bnBm54YNxcViZsJpzjJOrJ0etZM61jYuu/SMFf534JHKXi6k6Oebow=
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com (10.162.155.27) by
 DB5PR04MB0984.eurprd04.prod.outlook.com (10.161.196.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Tue, 6 Nov 2018 13:19:32 +0000
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb]) by DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb%2]) with mapi id 15.20.1273.035; Tue, 6 Nov 2018
 13:19:32 +0000
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
Subject: [PATCH 04/23] PCI: mobiveil: remove flag MSI_FLAG_MULTI_PCI_MSI
Thread-Topic: [PATCH 04/23] PCI: mobiveil: remove flag MSI_FLAG_MULTI_PCI_MSI
Thread-Index: AQHUddNaKsP++nomakmKhf5vdiC8Ig==
Date:   Tue, 6 Nov 2018 13:19:32 +0000
Message-ID: <20181106131807.29951-5-Zhiqiang.Hou@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;DB5PR04MB0984;6:u0e4s4CbGqPsIrzvv8JB9qhm7I1uiSC6R++EFkkeQ8Zm8QhAqFnERkEiKxty6JUbyO0NO7TUvr/JY+Meeg2/hzPIieLA0spCfpGEqEhPthhYJObV0lzQqOCkKVaQM0R02Pm9mgixsinZnZY+z9L5wxlQFefQguQBsDTpI7thPFiAxLo4AD/SRLpnOv2c78rP9/yVyzTfXlQ/hQVQGcGoHp9wHGoVdAlFqZJySx0VSxoy36qvl2aUEJPVGsGk+VlzjiAaOlVYNq2YocSjMGKX0QF0p5DTg4jBqrRNNKUmUrHczOKwylzZlD3d2BCKCtsPeMjAGkv5qz76ocZ4L0LScxY0Xr8AZluBDD9jL/hr9NbrF8ON5/QLewGKef8N/zWcUBjRlQ+iQGBTeAnJ8aUj3yqEnRi8HMv3C6SGNzYbxd+H9S3shwfcUrK5kFpSjhPoYUwg7xRg3u1JbGd6KuoGoA==;5:jSztkSawfRlVI37TQLld+pm5YtnKF1xtMW3Y5zCTrhB4/uPx3VbAsNGeeMFu66zmiy18XW0BdmAgzv8fuP9iwy1oqs5sXwf3xHmx5/WH1/LdF8YA3t8OD0HLb/Lj+EAgoxAnF9VBr2yFrYjP2HPcgvgeT2b+6LHA05hM/L1CraQ=;7:HOlD9ae3YHTp4erk1YMfKvJKyIDjoFeg4ydQP6e3exixF9QUXhRhJ7QRpXqecNR3yYbqN+SwMcRyZbmJEBKV9vbCAmTDNLwyZT0UdPGTQpiWOMNUi+RVLVMfm20GON4RUVkrBo/TJWfQvmuL0bOv0Q==
x-ms-office365-filtering-correlation-id: 6f3a157a-0475-450d-1513-08d643ea7cf2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB0984;
x-ms-traffictypediagnostic: DB5PR04MB0984:
x-microsoft-antispam-prvs: <DB5PR04MB0984FD1428A297C31963FC2984CB0@DB5PR04MB0984.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB5PR04MB0984;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB0984;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(366004)(136003)(396003)(199004)(189003)(68736007)(486006)(386003)(8936002)(3846002)(99286004)(71190400001)(81156014)(71200400001)(81166006)(53936002)(8676002)(105586002)(110136005)(54906003)(5660300001)(2616005)(446003)(11346002)(66066001)(97736004)(305945005)(7416002)(476003)(2900100001)(7736002)(106356001)(14444005)(2201001)(4326008)(2501003)(25786009)(1076002)(186003)(6486002)(26005)(2906002)(256004)(6512007)(575784001)(36756003)(6116002)(6436002)(316002)(102836004)(52116002)(6506007)(86362001)(14454004)(76176011)(478600001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB0984;H:DB5PR04MB1221.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ONDjVfDOWvJTtqmFcIZrF3V56ob4CUoI3K1ExNS2Gm+j6qQ1hiY4Y9nAe4GD8Bc93LkunPBnDGh1dL6i/8t/d/mYaE7konBY4SdEnntnFd3N+QAdy7ynvCPBjrkr9ovEMx4M6rJnljCsviFN/RO9JELOg14F64heBe3HGa8WO93NB0fj/8Q2Gyg/KXWkia9krCn0YTgIMAIbWJQe6+zQD7SYlb84vpCKklkZZ0ddpgOpnFkc64gX6vs76fw3msy5BkZtOv3sDXOCGl5IbmeqTquNaQ7oK6AMKzy6KvUPRzIvFmY1AiWYm+6+Jk9TwdeFY6EG251+UL3tiq9T6zzVE4xBfmppdgyHMUvWivMdris=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f3a157a-0475-450d-1513-08d643ea7cf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 13:19:32.4227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB0984
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The current code does not support multiple MSIs, so remove
the corresponding flag from the msi_domain_info structure.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 drivers/pci/controller/pcie-mobiveil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controlle=
r/pcie-mobiveil.c
index 563210e731d3..a0dd337c6214 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -703,7 +703,7 @@ static struct irq_chip mobiveil_msi_irq_chip =3D {
=20
 static struct msi_domain_info mobiveil_msi_domain_info =3D {
 	.flags	=3D (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		   MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX),
+		   MSI_FLAG_PCI_MSIX),
 	.chip	=3D &mobiveil_msi_irq_chip,
 };
=20
--=20
2.17.1

