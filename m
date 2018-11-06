Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D26C32789
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 13:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F582085B
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 13:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oc8yRIiq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F582085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388524AbeKFWqW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:46:22 -0500
Received: from mail-he1eur01on0079.outbound.protection.outlook.com ([104.47.0.79]:43456
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388225AbeKFWqV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Nov 2018 17:46:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWry7gCZSzWVlS4ahhb1go/W/PQXURJtjoF7yBzmDFU=;
 b=oc8yRIiqdC0earhhWIvifUCR4blyPz1BEsi+7OwKG8kcYNc3ILjyuvPUWKWfzSemcGXWLcc7crd2DnSdJ3GZzP95wazO5Dj24ADPV+yF8o0m2ojO2I7eEl3/EKGIiitoeE43NZ8K0LOMq54GYlA38+c32MPr9VyVNwOU1lSBAbA=
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com (10.162.155.27) by
 DB5PR04MB1414.eurprd04.prod.outlook.com (10.162.221.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Tue, 6 Nov 2018 13:21:06 +0000
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb]) by DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb%2]) with mapi id 15.20.1273.035; Tue, 6 Nov 2018
 13:21:06 +0000
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
Subject: [PATCH 19/23] PCI: mobiveil: add Byte and Half-Word width register
 accessors
Thread-Topic: [PATCH 19/23] PCI: mobiveil: add Byte and Half-Word width
 register accessors
Thread-Index: AQHUddOSJtO93UKerUSO5oBANnJx3A==
Date:   Tue, 6 Nov 2018 13:21:06 +0000
Message-ID: <20181106131807.29951-20-Zhiqiang.Hou@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;DB5PR04MB1414;6:0ih/73KH9iFglZu4Rr+DkvKGrZeSuWYR3CcOr+olJHbau0x8i67tNSwNTr1FtJWrdCm590A+/u+eMfDruIOlZqrhX/TQzvOOTkH3Xtlp0UFhvP+SLLg9Qbt+h7CN25LFJdaHaFdbjmJSmGW0WhPGdEJBX8SjyYjDTD/IKlPUVEbvZhP/8pUORyN5/HK9E1dvkhoKrRtw+yypRqn3kM0zGlcipYQJ9rSWEqvqOOWXxhHoskXULfUyv1LLv7uef0uDMefUkVx78koVXWOzXUggDkGu3Y7XB9Uck8jgh5fnahRglGWDpq0Tf9H7gtk3XgdGT6vQV/aRBP+3TjpxNOgkoDfUASnC857Z2twQrKTH1yEyV5+wxMm+CNUQLoeT03J8WtMIZsmfwdecw/5eFHEd/PcYAODfXQOFb46QOuXrkKyFQq0jf5HvVmxzRZpJfjZGWpKWqgqWejVckC0041sLsw==;5:B+coAuih0gaJdIB3cDxOCLlh+SIXZrUzHNRhbzzb7xbqIF0WKNu55YpuhS2wum3LrGahPXopsaFTOEJ4lHLvJHFDGWiPLW/v312kJCB0HPjAGlc0qZaThpPkg/SocNRMKv/CizRPk7+4NcU8FZSEC97ZOvF0WFJ8vk9BsMcHQVw=;7:Ju5KL9+K4Q+Hs2ltRAyJYHgu+0g32xA90I7Gb3koHTbb3qPvM97S12ISuMYn7jhTp3E9jAC5D+61jC/q21lPMWLyMRfwYYBl4BSvSVIc8ylCf3WMqeRgs9/6oMifBZC+KYdl8/YLDkJSQp3i1prDGA==
x-ms-office365-filtering-correlation-id: beba9873-d6f7-4aea-6283-08d643eab502
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1414;
x-ms-traffictypediagnostic: DB5PR04MB1414:
x-microsoft-antispam-prvs: <DB5PR04MB1414A38909340AED2C48E8C884CB0@DB5PR04MB1414.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB5PR04MB1414;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1414;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(97736004)(66066001)(8936002)(81156014)(81166006)(7416002)(8676002)(5660300001)(71200400001)(71190400001)(478600001)(6486002)(6116002)(2900100001)(1076002)(53936002)(6436002)(6512007)(305945005)(4326008)(25786009)(7736002)(105586002)(106356001)(68736007)(2906002)(3846002)(256004)(26005)(486006)(2501003)(14454004)(99286004)(52116002)(76176011)(36756003)(110136005)(386003)(6506007)(102836004)(54906003)(86362001)(186003)(446003)(11346002)(316002)(2616005)(476003)(2201001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1414;H:DB5PR04MB1221.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WDnPafxHbyx/3pdSt7BbkmXCy1cCAY2p8pO9f/ReVjNAqLFojuyKAqQcZ+yewrEeRGAWvuuwTdxn5MV5GsmRcZkgrrrT8K/hUgXqcgpwtJxgLo3HJPUz99hplevGcSx8oaTysLkhHFVX6z/mZD0Q5jZhq0y5F76rREnpKbEIKavAVOm0/XgjALJO11a3vPFuJ4GzXYtRlZoDf+OqEvh06WpeB65nDL1a58zqJykQMloJD3Gl4dvNzAbhjmZ/t0sm0QgkYRywL2WNvgDjVM6ccELb+44+RnRr4o5LZH+rp5f0+VtLnJSLSHlBYGSejDcPB8vXmwgonM96nenpv4Vxz7jaX6BFm6KfwEX/le7csvg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beba9873-d6f7-4aea-6283-08d643eab502
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 13:21:06.4419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1414
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

