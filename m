Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AE6C32789
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 13:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36ED2085B
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 13:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YuwGC9Y4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B36ED2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730620AbeKFWpu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:45:50 -0500
Received: from mail-eopbgr20059.outbound.protection.outlook.com ([40.107.2.59]:61568
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730570AbeKFWpt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Nov 2018 17:45:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAUFvYhjmTM46xau+yCPPWh2H2TGKQRiw9bL+RiVHL4=;
 b=YuwGC9Y4kj77+JnvZO9djzWaYfhl7Oijf/T+aX2qFcAWanDG83ZZ3H86DCGEQVZJTF+MpAkfMVXkzKftA6Nqti1xu1zINDgwuLu5Ox4sIOLj5G5o2w8k1woyxs+/0jmaCPKhb8zXqUXq/q/toKGZ6OKU+A68Wf/WWfi8n/+0H5Y=
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com (10.162.155.27) by
 DB5PR04MB1414.eurprd04.prod.outlook.com (10.162.221.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Tue, 6 Nov 2018 13:20:35 +0000
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb]) by DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb%2]) with mapi id 15.20.1273.035; Tue, 6 Nov 2018
 13:20:35 +0000
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
Subject: [PATCH 14/23] PCI: mobiveil: initialize Primary/Secondary/Subordinate
 bus number
Thread-Topic: [PATCH 14/23] PCI: mobiveil: initialize
 Primary/Secondary/Subordinate bus number
Thread-Index: AQHUddOAOpjrJxdoLEW1ke5psCHyLA==
Date:   Tue, 6 Nov 2018 13:20:35 +0000
Message-ID: <20181106131807.29951-15-Zhiqiang.Hou@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;DB5PR04MB1414;6:2Ru1+Bq4n0ok02zcRoXayJD4p5fZugs2lh0GG9+kY6Qk0lXsyU8yaCb157Ok7uu9ca8zOPeI5JKWtn6XKrGo1AAK5HN62QIWYg8OBgCDoSHTFTOOG8X6kG2qlqMbNBKTksRVUp+WbkgwMY/aZzwqYRQFffo1EYBewafvOgCFpqNdk4Y7/batTCistTG6ewvsppPmpSuf7m5U+35akIhnzWRxSnaNNaRdvRS5ltf6b37/kzbd8wlO9vKx3ngyE3uR81XSD5mV1HC/DPXgQkd6+ZH+U3f/BaqYCi5cCOtoiYmFfKOoDCyABQn2Qs0C+eMuiwoM+qQ9S/1tw4UkmEzgvwmJGhusJRtSk16+c3Kyak+CeFLXpB8+ukFmaQJ6nZL7N0W0HySS21DTQIu5eMsrgjNb2kxVtuSAXoxUbfd5zrgNfjlxSHldSdyiBuWQdo1OTCek+fCbpG/+3v1ycNcAug==;5:xfgto8n9BeSkyGKWBuJ9BMZt3a7QaECGIslq/zyYsedmd/wi/MvGoV/n3KzIsggzlkK0EUrSsvM8oemyaGmUvZ2qKJYxlC/7rwRIGf3WvDCXDYBLcjCMXjN8t1GnYTo9alkoqXrVzHsCSeMskhprhIXLh1d8MeX014rki1DGIzk=;7:USPqfnoL+OJWw5NZQLCXG1MLeEQZ8MHkFuYLa17g9xq1ofyr8eF+xDew6XRiVpAQfm0MpIB1LSd2P1054V2T9rqCURWJUFGNiqHlkclwRa9ilAmkn71Yb8MrCl8svRSkwYWYEis8XymNldhGW4OG/w==
x-ms-office365-filtering-correlation-id: c2fbdc9f-b473-44a6-cf9d-08d643eaa2be
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1414;
x-ms-traffictypediagnostic: DB5PR04MB1414:
x-microsoft-antispam-prvs: <DB5PR04MB14140E75020FA006FE14B15684CB0@DB5PR04MB1414.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB5PR04MB1414;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1414;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(97736004)(66066001)(8936002)(81156014)(81166006)(7416002)(8676002)(5660300001)(71200400001)(71190400001)(478600001)(6486002)(6116002)(2900100001)(1076002)(53936002)(6436002)(6512007)(305945005)(4326008)(25786009)(7736002)(105586002)(106356001)(68736007)(2906002)(3846002)(256004)(26005)(486006)(2501003)(14454004)(99286004)(52116002)(76176011)(36756003)(110136005)(386003)(6506007)(102836004)(54906003)(86362001)(186003)(446003)(11346002)(316002)(2616005)(476003)(2201001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1414;H:DB5PR04MB1221.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ADfJiFj4c08S++/5lqfKgEB6Veo65TZI2npmb86Nk8l0resNCmU45ZTxlcwLaKzMy2reVTV6YKkr83cVDefZBdnK60TW0ZRaErphwrMUVX1xsGTQ51zSGdBrP19/wJpa0+OWhtcA41Wp3IVG4kKHhr7FviQCqXtG6fCTv5kdFuXRFhGLq1OHr8nMSZOLd1Mew/fBFOuLnTJwvX5taez4Dw3qjS27DIyBevsUm4ZGqFTI0qdiGK2NTLw+KhpwD9qVBK91wMe+J3a3wrfu+i0OhV+2X2bLIpg3Vmb0GVnosrYZx2N1xOm/jvAeM4l1L9JpSwPRvOtg+HWI/CtNEBNabtRUIYAHHXfbcNjennoye9c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2fbdc9f-b473-44a6-cf9d-08d643eaa2be
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 13:20:35.6670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1414
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The reset value is all zero, so set a workable value for Primary,
Secondary and Subordinate bus numbers.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 drivers/pci/controller/pcie-mobiveil.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controlle=
r/pcie-mobiveil.c
index 3da924bb6b3c..8d6a1e98f655 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -581,6 +581,12 @@ static int mobiveil_host_init(struct mobiveil_pcie *pc=
ie)
 	u32 value, pab_ctrl, type;
 	struct resource_entry *win;
=20
+	/* setup bus numbers */
+	value =3D csr_readl(pcie, PCI_PRIMARY_BUS);
+	value &=3D 0xff000000;
+	value |=3D 0x00ff0100;
+	csr_writel(pcie, value, PCI_PRIMARY_BUS);
+
 	/*
 	 * program Bus Master Enable Bit in Command Register in PAB Config
 	 * Space
--=20
2.17.1

