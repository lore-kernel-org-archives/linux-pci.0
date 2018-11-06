Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BE0C32789
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 13:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC002085B
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 13:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="N8d+9wkO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FC002085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388514AbeKFWqR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:46:17 -0500
Received: from mail-he1eur01on0083.outbound.protection.outlook.com ([104.47.0.83]:64240
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388497AbeKFWqP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Nov 2018 17:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sc5uKHbf3v0qCGYcXW6quzgbwBxS23iSrW0yDURxXNI=;
 b=N8d+9wkOjaawnZpwmINsGFhXVoJ/LlBkCXlwvV3PSZyhNFKdFMsROqK5FgKR17HVKmGMImGU3I9eVd41f47YPyHhMnn4usMBfmYuNlLb0+nBt1qpHOOhZkxQpsqLLmvPz5Dy+aEobjw0O/GPl12Wx3C1rgWHUimOkDc3vql/RZw=
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com (10.162.155.27) by
 DB5PR04MB1414.eurprd04.prod.outlook.com (10.162.221.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Tue, 6 Nov 2018 13:21:00 +0000
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb]) by DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb%2]) with mapi id 15.20.1273.035; Tue, 6 Nov 2018
 13:21:00 +0000
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
Subject: [PATCH 18/23] PCI: mobiveil: disabled IB and OB windows set by
 bootloader
Thread-Topic: [PATCH 18/23] PCI: mobiveil: disabled IB and OB windows set by
 bootloader
Thread-Index: AQHUddOP9u/TlMIhSUSgJ6+th1klBQ==
Date:   Tue, 6 Nov 2018 13:21:00 +0000
Message-ID: <20181106131807.29951-19-Zhiqiang.Hou@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;DB5PR04MB1414;6:FT3m/CyJzk43NDHKn9yh9+hTv4DHr4VUSs+BKGs6T6AQIj1rf1zpuS4zih7RLzHPXu5i/DNd6PTPcfhKyRkOBdUQMh2b3GGu8pOPU1MBeYRvsxX6bfnYY6T2iteZGmqxAZ2dpuZD1bMiwmCzzSko8Ux3Tc5cr7vOHy+G5Va9lqL50JhAhNzaz052A01wBUEqWhGAtIlDO8q6dy6LzihnJaOSMPA8raWmdA1grYHvnyoj1GJZL4TKSl5sfAlHqSnTCbsur230Z3QpiCqHY1RA69DcyIs3BfbGmW7nw+c3P0832H5eJTgXhpGRIZRYpXG1IM9wai+1DMQNGC6MEQmk94fGlWLoq1gug1Kn7xikM5oWrkq3KAklkbV0mttrkPKX9/PParmZABzlFQT0A4ewuzmd3dLrEAG1OUNVsWqz//8kIT7xcftuu5ZVDz6+Ghf6VWeFYNZXl75U8Df/Rasshw==;5:ggE/GtkItCqNTunVGnCKwBKrGsCUEz67C4dPk9/oIl7syI+pqBLJwC0gSvYQTMRPOPiBY1FL6wJUd8M/+j67qkIWHDM065ryncOrLZVsVmZr5chs6xoMflxpXzNeQZsPd5j5v4JW06uvNLC1RmFiFDlvRka1ZuHiors7+uOzX78=;7:smQNiI1bshWtHAsvJ6rlVyCNDXIL4Ksu9Vt5ZUh/Adi7717OUGleGOo5/7XlZM/2aAnCBkdjwPeFoXSSDpWYCW8dIQO69Xo+Gy8gNZWaFVJWn7MHo9MKaF0Nn+HiQ9njo9NxLtBrs1joP7JKGO9qsw==
x-ms-office365-filtering-correlation-id: fee4da17-a9a8-414a-10c9-08d643eab17f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1414;
x-ms-traffictypediagnostic: DB5PR04MB1414:
x-microsoft-antispam-prvs: <DB5PR04MB1414668A1CC5ED3A72011FA684CB0@DB5PR04MB1414.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB5PR04MB1414;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1414;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(97736004)(66066001)(8936002)(81156014)(81166006)(7416002)(8676002)(5660300001)(71200400001)(71190400001)(478600001)(6486002)(6116002)(2900100001)(1076002)(53936002)(6436002)(6512007)(305945005)(4326008)(25786009)(7736002)(105586002)(106356001)(68736007)(2906002)(3846002)(256004)(26005)(14444005)(486006)(2501003)(14454004)(99286004)(52116002)(76176011)(36756003)(110136005)(386003)(6506007)(102836004)(54906003)(86362001)(186003)(446003)(11346002)(316002)(2616005)(476003)(2201001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1414;H:DB5PR04MB1221.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5dGcm1parw0Sqc6syt8omU3BdxROGcIdO+s2QDq92VIXBvk1Mx3/ln2MGCiXkp4f18JKmTt8LS7B9EYAQyX96zAjgo+DCC75Rn58FFGu+akr07alNDrQqVFO+kJfX/fRxnbCtkBWtnUfc0bDGRBerka30CRycutZF0wW/tbB1+DClGYVBKeqAOo2w7ebQAn/e/sAb7cOzcOH2DU+cQhbCJeUdUCyyZMWl6yt4j1mu/ic+L9jdMbPreleRJV2vgohmYqcgfakd1mdthH9SWsA33JR3RmYj4q9DdonCgE1PCVtFji3zcyndvNVkznMa7eE4b0CLq22+GSaoqFtsA+SikshmULcFm4lUcDSz01S73w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fee4da17-a9a8-414a-10c9-08d643eab17f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 13:21:00.2659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1414
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Disabled all inbound and outbound windows before set up the windows
in kernel, in case transactions match the window set by bootloader.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 .../controller/mobiveil/pcie-mobiveil-host.c   |  7 +++++++
 .../pci/controller/mobiveil/pcie-mobiveil.c    | 18 ++++++++++++++++++
 .../pci/controller/mobiveil/pcie-mobiveil.h    |  2 ++
 3 files changed, 27 insertions(+)

diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers=
/pci/controller/mobiveil/pcie-mobiveil-host.c
index 4419179f64bc..de24fedcb92d 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -217,6 +217,13 @@ static int mobiveil_host_init(struct mobiveil_pcie *pc=
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
index 71389ebbf229..cd2a7b9a7a2f 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
@@ -225,3 +225,21 @@ int mobiveil_bringup_link(struct mobiveil_pcie *pcie)
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

