Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136D4C32789
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 13:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C67BC20869
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 13:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="da7WQ3/k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C67BC20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388225AbeKFWq2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:46:28 -0500
Received: from mail-he1eur01on0051.outbound.protection.outlook.com ([104.47.0.51]:61568
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388220AbeKFWq2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Nov 2018 17:46:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jaUMxiIt9moPZuvoSi/gXt0X2GuntRQRYRH/ENAvZ+0=;
 b=da7WQ3/kJr6AF4C2MNT5PFoikC0fD/mzhkkva9qIrktFr85kI+ABXKoJ+Uv+Jy0z/Q7Jj99zrBrlQ+kNNwBiD8jSiI7+D5MKUAcTlpU8CtKvDrGXOjQKAHJrDDmeW7ThvqcB7i1h3joHtq/80dnIaq6A3w7YpkZ9Sf4Xp6H35Wk=
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com (10.162.155.27) by
 DB5PR04MB1414.eurprd04.prod.outlook.com (10.162.221.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Tue, 6 Nov 2018 13:21:12 +0000
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb]) by DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb%2]) with mapi id 15.20.1273.035; Tue, 6 Nov 2018
 13:21:12 +0000
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
Subject: [PATCH 20/23] PCI: mobiveil: change prototype of function
 mobiveil_host_init
Thread-Topic: [PATCH 20/23] PCI: mobiveil: change prototype of function
 mobiveil_host_init
Thread-Index: AQHUddOWzQcefL0KukGVWvbBBU/BLA==
Date:   Tue, 6 Nov 2018 13:21:12 +0000
Message-ID: <20181106131807.29951-21-Zhiqiang.Hou@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;DB5PR04MB1414;6:zdy1Je5SNs96dLwMcumxq/k57WAY+aPySkXkuasD+bIgVBA1eJnOK1Y1+lIFe5UNeQIwzFkNMH82h61ItFZH8bjk93ggGzLfVpWeDrvYkkiTbBghh9UKm6UDbm+P8tXG/zaJPlru3QS99u1U4pIkbDbabs4DJ05O4Y+ScNBsUc+FMjFFTm39EfX43xZMJj63A6SiGgwHMFHOjg5gzLHcj63T0KOck1fXiMkngkLJ7ypJ38gUPyTDT4RDJFf5CDEnPg/9mxy6U8f43bLZD4d1k9bgvSCQCIlqPTu8PjZRHMM8ewu2OYO4Rt5qLyiths7fkB8WOFDQGx5CvQXkdZO4664iAIPghR/yCdxLS1YVigQHB7kDZHGsVvzXyBRB1MvZS2X6oGC8UtUVG19my6ClsCBY4nlyFd0aYgKFDDxtmwEzRX9io1GBmx03zkOu9lYxcxIO0Pt5XXRXEyxmZIxQ1w==;5:1bf1XCeEcM+SEeW/D4EQ4l4DQFQf1ksPVi+ZfskPk1TYgIbAJtrSGO1G3kO4ZsJ9D/zougv3GA59fPzpu7CN+YIkM2rOW8aQJ1K0nO/zcBJbIcLlfvykN54ocArDqPrXJW2PkANePv/VwWn5wVCBiqud1dNk/9kpKoPWTpc/JdE=;7:peNzPUTDdEnBf8R682/ZdQhteCQ7DZjEs6ypsXkG1vKRA2BJKUufsoe2iKVi58I2OnI6PlrCouvi2vb4hmLwKlzGluEix3GZFG1Y8xM+sxBIm/RtBzqznw9R8Q+eAaTY1jWJV6Y6wWsPc96rvj5xNw==
x-ms-office365-filtering-correlation-id: a9379a8c-0716-4b26-8fc7-08d643eab8ad
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1414;
x-ms-traffictypediagnostic: DB5PR04MB1414:
x-microsoft-antispam-prvs: <DB5PR04MB1414E125EED37F29B58B8FFB84CB0@DB5PR04MB1414.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB5PR04MB1414;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1414;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(97736004)(66066001)(8936002)(81156014)(81166006)(7416002)(8676002)(5660300001)(71200400001)(71190400001)(478600001)(6486002)(6116002)(2900100001)(1076002)(53936002)(6436002)(6512007)(305945005)(4326008)(25786009)(7736002)(105586002)(106356001)(68736007)(2906002)(3846002)(256004)(26005)(14444005)(486006)(2501003)(14454004)(99286004)(52116002)(76176011)(36756003)(110136005)(386003)(6506007)(102836004)(54906003)(86362001)(186003)(446003)(11346002)(316002)(2616005)(476003)(2201001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1414;H:DB5PR04MB1221.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: gahF5gYBiejRAEJgmaYIGAAjXUL+PyfE0awzRMRmYx8FTYrejyAe8pVmGGwOj3J60n1ut+lYaSE7p0WiWliYFqrKKUTugCbwOjtKJfLjiCBXshXGwSPAOzAyCYIpPMhRxVYL0hE1NQXoaOC118o4bTTZm3Wp1MwTr77cHQzvAcgwDnKcJKUHBl5vPB3T4nSFGlyJYwVgD5OHaz44HRrg8HB7ed6w96T/9qdTfwZnJI+VvonkG3rJbp9a0+bi3Jtw9PL8hT3cyvEQRfwJUJU9ZyLFzbCRVU14QOb/rUtb99cfVAakq4EUZvdLjwXXp3uOuQhtjJRFeEbcV/7idJOlwzcpPXvmF3lCXBBn2KSI6H0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9379a8c-0716-4b26-8fc7-08d643eab8ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 13:21:12.5099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1414
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add a parameter 'bool reinit' to identify re-initializing the
host controller, and export it.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 .../pci/controller/mobiveil/pcie-mobiveil-host.c | 16 +++++++++-------
 drivers/pci/controller/mobiveil/pcie-mobiveil.h  |  1 +
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers=
/pci/controller/mobiveil/pcie-mobiveil-host.c
index de24fedcb92d..b1d67a697ecc 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -213,7 +213,7 @@ static void mobiveil_pcie_enable_msi(struct mobiveil_pc=
ie *pcie)
 	writel_relaxed(1, pcie->apb_csr_base + MSI_ENABLE_OFFSET);
 }
=20
-static int mobiveil_host_init(struct mobiveil_pcie *pcie)
+int mobiveil_host_init(struct mobiveil_pcie *pcie, bool reinit)
 {
 	u32 value, pab_ctrl, type;
 	struct resource_entry *win;
@@ -225,11 +225,13 @@ static int mobiveil_host_init(struct mobiveil_pcie *p=
cie)
 	for (i =3D 0; i < pcie->ppio_wins; i++)
 		mobiveil_pcie_disable_ib_win(pcie, i);
=20
-	/* setup bus numbers */
-	value =3D csr_readl(pcie, PCI_PRIMARY_BUS);
-	value &=3D 0xff000000;
-	value |=3D 0x00ff0100;
-	csr_writel(pcie, value, PCI_PRIMARY_BUS);
+	if (!reinit) {
+		/* setup bus numbers */
+		value =3D csr_readl(pcie, PCI_PRIMARY_BUS);
+		value &=3D 0xff000000;
+		value |=3D 0x00ff0100;
+		csr_writel(pcie, value, PCI_PRIMARY_BUS);
+	}
=20
 	/*
 	 * program Bus Master Enable Bit in Command Register in PAB Config
@@ -570,7 +572,7 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie=
)
 	 * configure all inbound and outbound windows and prepare the RC for
 	 * config access
 	 */
-	ret =3D mobiveil_host_init(pcie);
+	ret =3D mobiveil_host_init(pcie, false);
 	if (ret) {
 		dev_err(dev, "Failed to initialize host\n");
 		goto error;
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/=
controller/mobiveil/pcie-mobiveil.h
index 933c2f34bc52..51195db09347 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
@@ -165,6 +165,7 @@ struct mobiveil_pcie {
 };
=20
 int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie);
+int mobiveil_host_init(struct mobiveil_pcie *pcie, bool reinit);
 bool mobiveil_pcie_link_up(struct mobiveil_pcie *pcie);
 int mobiveil_bringup_link(struct mobiveil_pcie *pcie);
 void program_ob_windows(struct mobiveil_pcie *pcie, int win_num, u64 cpu_a=
ddr,
--=20
2.17.1

