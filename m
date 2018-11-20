Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA0DC43610
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 09:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D29A20851
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 09:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jSJch3rV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D29A20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbeKTTzx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:55:53 -0500
Received: from mail-eopbgr30040.outbound.protection.outlook.com ([40.107.3.40]:36159
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727453AbeKTTzu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 14:55:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7RFA8zuQdtBM4WyBZkYqo4kXC2Ymw2uQIGPx4o3Kkk=;
 b=jSJch3rVHHQX+CqnE1/qbyg6I9QEUn/MHZ0JPteprKFa6t3inYLfO+r0XECUJCnV8lDQfruTN/iyzBlfpgcYzNWRgKxJp8nU3UNltBxOHBYLWOruDyQUuUqf8IQIZ1VumRO+LAvVCkmlLUnGeg99Yuh1ApiWpNnyE/F00DfXg9c=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB4775.eurprd04.prod.outlook.com (20.177.32.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.21; Tue, 20 Nov 2018 09:27:39 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c%4]) with mapi id 15.20.1339.026; Tue, 20 Nov 2018
 09:27:39 +0000
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
Subject: [PATCHv2 20/25] PCI: mobiveil: add Byte and Half-Word width register
 accessors
Thread-Topic: [PATCHv2 20/25] PCI: mobiveil: add Byte and Half-Word width
 register accessors
Thread-Index: AQHUgLNHzqe5uulTrkKuclVdC+mE8w==
Date:   Tue, 20 Nov 2018 09:27:39 +0000
Message-ID: <20181120092615.11680-21-Zhiqiang.Hou@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4775;6:AmZySUidA3z2jtHLn5BeNNLETl+MQEXG+Um2mAPxAd2kBGwPxTwIKoome4oOSN2V1IV/TyFDKOH48Lxhzv079HuHvqXWWOjRayOglhaW8Zhi5LVGYqzrnO5m9TboAfOsR73xhCGCeFZGLARTBWqfdaRQLogB8Y5F/1b4jA00A7pX/cgsWiQ7K3JfQAAMNbDSRXesIztUo2bbmpzW2Y9BFbPZEvQxoT/gIAi9Nk7bxrtP8+JpwrdwPVlbupMztcG0MYeaKY93RLxe7pKs7xcMTPLVDryCxojfKP80XHC+ZNI8PJhCTzkoB1ZogPRpfG/AWMy5m4LrjoiNHfDnv1iNQIiNQfiAAnROhGUuVxJUNGPv475HMGp18LEZHIiuTJWPDt3XjVt7ESOsT/tVed2f/IeyiVNm6U3OTBrQY5BqDF9UUi5p1v51DhGONOoNqtp32B4VFBhq3dNgaebCC8y5YQ==;5:yr27SlgQ8/ycbkp+UdyJQVDtdaID1YSCtRe8Sb7I8YR/bTAPEvU+9dIpyetxrNdbNxIaFtpPoL7bm2A7KJoCLxKvD1w3oBpfF4/oyY776zSgmern9FqSbrNZZX1+ecX1AI4hbB9m64LCpDgB1AxCPPHnGGIo1w7ucU7EhmuRhbk=;7:RFMaA6yqrVGfW0MCT1J0GDJvAf92BrVT7cunQe/AfOpQePq7rIGlVmsCTTrL6SbPp8CoMop2ErV3fHx5ezezYuNu+eT4y85Z8a+65GvLON6FnlFzQVKYphr/Vr11gaYKHEJ8sARXJP4r7nXs1d/Fog==
x-ms-office365-filtering-correlation-id: 61c683ec-23b3-41cf-e0dc-08d64eca6a43
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4775;
x-ms-traffictypediagnostic: AM6PR04MB4775:
x-microsoft-antispam-prvs: <AM6PR04MB47755A1071F3F8934C5D1ADD84D90@AM6PR04MB4775.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231442)(944501410)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB4775;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4775;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(376002)(396003)(346002)(189003)(199004)(66066001)(1076002)(2900100001)(68736007)(8676002)(6486002)(5660300001)(8936002)(6116002)(3846002)(2501003)(97736004)(81166006)(26005)(186003)(81156014)(105586002)(7416002)(102836004)(2906002)(386003)(6506007)(7736002)(305945005)(106356001)(6512007)(76176011)(36756003)(4326008)(99286004)(52116002)(25786009)(110136005)(54906003)(2616005)(86362001)(53936002)(446003)(11346002)(256004)(2201001)(6436002)(486006)(71190400001)(71200400001)(478600001)(316002)(476003)(14454004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4775;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KxAbea4+YS65QY0wrgWkYzJQmqhCNLbDfkZ6UNGfSc6jZJWu9agsmvgt/J9fghSZEfywum9VQ76v//z2NonWgMEL4qlq3H0tA7CB7SS1/YVJ+oxpU8SYNyreUBoGHKiU3EW6YLQGiQbff6tyA0X/vjXXAQJdNaOOv7eGXRArYRYHrjwmvhqymTHKtT8Iu7poGPI9oSYsak0UazC7+g0G20maaBkhvxqAS3mDvsgqpyGjmQ8WeP7HqJsCD1PrOPjBi3hbaZ9UvREtCvl0BCirfDF+Sy7ZtaWjAoRguhm3I5hfFMx9SZ5+i23Uc5fVo9YXkI/72sl8uGRZRalVhhm5OLzyioZFUBTBdZIVOUoTfZ4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c683ec-23b3-41cf-e0dc-08d64eca6a43
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 09:27:39.5353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4775
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

As there are some Byte and Half-Work width registers in PCIe
configuration space, add Byte and Half-Word width register
accessors.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V2:
 - no change

 .../pci/controller/mobiveil/pcie-mobiveil.h   | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/=
controller/mobiveil/pcie-mobiveil.h
index 81685840b378..933c2f34bc52 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
@@ -181,9 +181,29 @@ static inline u32 csr_readl(struct mobiveil_pcie *pcie=
, u32 off)
 	return csr_read(pcie, off, 0x4);
 }
=20
+static inline u32 csr_readw(struct mobiveil_pcie *pcie, u32 off)
+{
+	return csr_read(pcie, off, 0x2);
+}
+
+static inline u32 csr_readb(struct mobiveil_pcie *pcie, u32 off)
+{
+	return csr_read(pcie, off, 0x1);
+}
+
 static inline void csr_writel(struct mobiveil_pcie *pcie, u32 val, u32 off=
)
 {
 	csr_write(pcie, val, off, 0x4);
 }
=20
+static inline void csr_writew(struct mobiveil_pcie *pcie, u32 val, u32 off=
)
+{
+	csr_write(pcie, val, off, 0x2);
+}
+
+static inline void csr_writeb(struct mobiveil_pcie *pcie, u32 val, u32 off=
)
+{
+	csr_write(pcie, val, off, 0x1);
+}
+
 #endif /* _PCIE_MOBIVEIL_H */
--=20
2.17.1

