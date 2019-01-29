Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BEDC169C4
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 08:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C2D2177E
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 08:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ibDx0sv7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbfA2IKe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:10:34 -0500
Received: from mail-eopbgr150081.outbound.protection.outlook.com ([40.107.15.81]:23072
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728112AbfA2IKe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 03:10:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mUr8WhHuhuWfWzRAVh6UgjwpT1snWE8Z3FHm0RcrTw=;
 b=ibDx0sv7oLd8T8ACH4dF9mivV7UdmPstpa0mAWHDrUNUYZba1mmXqTBIl75SKso9M4jWknwRT6K6kC3V+h/kE9KZ0WonQCluKd8Q3SanCYV9IQuYXcBM0Ivxr4vPyWobiogd7vN+rdm3gRnZt4UJG+CGLWdGKy+yDV7hOJi3qFw=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5127.eurprd04.prod.outlook.com (20.177.34.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.23; Tue, 29 Jan 2019 08:10:30 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504%3]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 08:10:30 +0000
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
Subject: [PATCHv3 19/27] PCI: mobiveil: disabled IB and OB windows set by
 bootloader
Thread-Topic: [PATCHv3 19/27] PCI: mobiveil: disabled IB and OB windows set by
 bootloader
Thread-Index: AQHUt6oZm7GLZpFkmE+7jMuMKnstaw==
Date:   Tue, 29 Jan 2019 08:10:30 +0000
Message-ID: <20190129080926.36773-20-Zhiqiang.Hou@nxp.com>
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:203:36::20) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:ad::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5127;6:WmPOt7ykKDaE6dbAD6Zbu9F5YqIsOJWdfq0Qkboz0A5hNphURu+OHtY7sR7WD1NxAG8xBx/x74TMm1AxTRCOts4cuHnG/yt7EQ+hznTLpNuG2mrTA/GZNEQaJBOW+ZTFK+qbV/gQciWo/72u7ecU59ZmeOa6xI7IAaqJM8qAxvcrZue/w8H0Qlq7VUyMgRKoLrD9b2o+XyJuM1v7iuD2b9k47MGxkL3+3Y6kZoLzc9JKN2Y7NrPotaVb0penKAJGukkQsoXPdg3L02x0sEiB8Xbka/D9YhXFnpY/BRrtuPctprwW23j/Jwv9ErFqAAEitzQyIBBjYiZMPVU8kTcK3kdu/ac8cTPEsaLCnbgfu+QWPsqvzqId9Lq9EN2gRArD4mAchsI/l1bw3t1utl2pxr7KW3PSabw5ofMjO6VgFnLU5iP2McHHNWOqrDooMseJM3UDRM2tpUycWf16wrkevQ==;5:v4aTay5BvgkooX6pFDYFX4P4Ek2NM06QgOl6Vc6l+5TF736cV6vqtnERVdn8TyxrcA4wcZnAanLL40jG9lMwIifTPgnijJ+fhSZEEKmVz814caZdRWiUe7Kh9pRHJyFnCRDN5zm34lHnCAQCvvjXlUvO49zy5EDtVEoS4hUDb3/hftj2g4quYYuNxJ98PhgmwjDMs3BiaygHkL30TUaQnw==;7:40GpGbZ/YfbAxGA6nvXAEarCyldLjUbpT2INTD0QEs9dtADO6XkYkutYdYzGu64M5Xp2PJDkABXPx3nFjpLMXe8l3SPcbg6aD3SJ5bu/zhtZr6RhsXtHjjhNENb8MUIPeYUF3Jpmhcg5Bihco4yhRQ==
x-ms-office365-filtering-correlation-id: b744d3c3-26d6-404d-71e0-08d685c13be3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5127;
x-ms-traffictypediagnostic: AM6PR04MB5127:
x-microsoft-antispam-prvs: <AM6PR04MB5127516AB63F94D0F4BD8BA884970@AM6PR04MB5127.eurprd04.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(346002)(366004)(39860400002)(189003)(199004)(6512007)(8936002)(26005)(81166006)(99286004)(4326008)(486006)(52116002)(2501003)(186003)(97736004)(76176011)(105586002)(14454004)(478600001)(106356001)(6486002)(305945005)(54906003)(53936002)(50226002)(81156014)(6436002)(110136005)(8676002)(68736007)(476003)(71190400001)(36756003)(71200400001)(316002)(7416002)(256004)(386003)(2906002)(6506007)(446003)(11346002)(102836004)(66066001)(86362001)(14444005)(1076003)(25786009)(7736002)(6116002)(3846002)(2201001)(2616005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5127;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TBPLj8AW6+2D+Oahr/Nj4Ij/LZLX+w6tIIKtqhG3HeiVjd3W9EgifdCyoARCI9/JJeW7dodi5TZzD+M+HXGXyCLXGpPJHlk+7vRGoXFUAAI0oy3r/S+nqplxjpEh3sXUo+yzo65LCjP2izOoQtHt8h8qSphkgRK1wH81uTIHMOj/pCodg7H3ELYaNlWg14CKNa9I1mkMgyHKHRtyiI4cEz7ZVDTLjYpfjYELRefzYKX/0nsA60HCH+3K0ZZU3uHAZ3XPuJQDrkPxGJWv7rjzyMwc4DACjPXkPznxE+VMi22fsww9MR6ZhMFbDyMfs1pR5wAV0blKtLeCsyXYrnPjXnRGah0Qr+yxQUTKCB9kG2+AX24QpMWcw8W+Q2nc78yNwOVJpaU3Me7BawUvKjLt/hVmUYPPdeY8z0QZ0GpCcAg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b744d3c3-26d6-404d-71e0-08d685c13be3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 08:10:24.3353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5127
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Disabled all inbound and outbound windows before set up the windows
in kernel, in case transactions match the window set by bootloader.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
---
V3:
 - No change

 .../controller/mobiveil/pcie-mobiveil-host.c   |  7 +++++++
 .../pci/controller/mobiveil/pcie-mobiveil.c    | 18 ++++++++++++++++++
 .../pci/controller/mobiveil/pcie-mobiveil.h    |  2 ++
 3 files changed, 27 insertions(+)

diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers=
/pci/controller/mobiveil/pcie-mobiveil-host.c
index d1765d572f44..d028cdf31d0e 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -221,6 +221,13 @@ static int mobiveil_host_init(struct mobiveil_pcie *pc=
ie)
 {
 	u32 value, pab_ctrl, type;
 	struct resource_entry *win;
+	int i;
+
+	/* Disable all inbound/outbound windows */
+	for (i =3D 0; i < pcie->apio_wins; i++)
+		mobiveil_pcie_disable_ob_win(pcie, i);
+	for (i =3D 0; i < pcie->ppio_wins; i++)
+		mobiveil_pcie_disable_ib_win(pcie, i);
=20
 	/* setup bus numbers */
 	value =3D csr_readl(pcie, PCI_PRIMARY_BUS);
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.c b/drivers/pci/=
controller/mobiveil/pcie-mobiveil.c
index 370658d6546d..49d471b75925 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
@@ -226,3 +226,21 @@ int mobiveil_bringup_link(struct mobiveil_pcie *pcie)
=20
 	return -ETIMEDOUT;
 }
+
+void mobiveil_pcie_disable_ib_win(struct mobiveil_pcie *pci, int win_num)
+{
+	u32 val;
+
+	val =3D csr_readl(pci, PAB_PEX_AMAP_CTRL(win_num));
+	val &=3D ~(1 << AMAP_CTRL_EN_SHIFT);
+	csr_writel(pci, val, PAB_PEX_AMAP_CTRL(win_num));
+}
+
+void mobiveil_pcie_disable_ob_win(struct mobiveil_pcie *pci, int win_num)
+{
+	u32 val;
+
+	val =3D csr_readl(pci, PAB_AXI_AMAP_CTRL(win_num));
+	val &=3D ~(1 << WIN_ENABLE_SHIFT);
+	csr_writel(pci, val, PAB_AXI_AMAP_CTRL(win_num));
+}
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/=
controller/mobiveil/pcie-mobiveil.h
index eb4cb61291a8..81685840b378 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
@@ -171,6 +171,8 @@ void program_ob_windows(struct mobiveil_pcie *pcie, int=
 win_num, u64 cpu_addr,
 			u64 pci_addr, u32 type, u64 size);
 void program_ib_windows(struct mobiveil_pcie *pcie, int win_num, u64 cpu_a=
ddr,
 			u64 pci_addr, u32 type, u64 size);
+void mobiveil_pcie_disable_ob_win(struct mobiveil_pcie *pci, int win_num);
+void mobiveil_pcie_disable_ib_win(struct mobiveil_pcie *pci, int win_num);
 u32 csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size);
 void csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off, size_t size);
=20
--=20
2.17.1

