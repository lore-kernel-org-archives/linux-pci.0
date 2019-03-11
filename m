Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA66C4360F
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1501E20850
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DyzpigMq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfCKJcw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:32:52 -0400
Received: from mail-eopbgr70071.outbound.protection.outlook.com ([40.107.7.71]:26944
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727213AbfCKJcv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Mar 2019 05:32:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djRJedX0YnGMR+kxBuz6xh14Gf7Z72o/ke4jkc9v3Cw=;
 b=DyzpigMqijpiqAvoKkgqsQF/oxGGmfUYiGs5Jf7Yn/YuYYHGvutYjB9twFJgPcevURnzvLAE0x1rcGkh1Iw5CGp90547uJfjWDG0tjVSd/SErmrN8EL+NJgUxPkTAGUr3daxnSwZc/5J/Y/2q0KFIJx6Jg/v+4eeVz6egjT/9To=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB6566.eurprd04.prod.outlook.com (20.179.246.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.16; Mon, 11 Mar 2019 09:32:41 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7%2]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 09:32:40 +0000
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
Subject: [PATCHv4 20/28] PCI: mobiveil: disabled IB and OB windows set by
 bootloader
Thread-Topic: [PATCHv4 20/28] PCI: mobiveil: disabled IB and OB windows set by
 bootloader
Thread-Index: AQHU1+1fWHXqD4bHmUakTFM3fhqbXg==
Date:   Mon, 11 Mar 2019 09:32:40 +0000
Message-ID: <20190311093130.7209-21-Zhiqiang.Hou@nxp.com>
References: <20190311093130.7209-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190311093130.7209-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0015.apcprd03.prod.outlook.com
 (2603:1096:203:2e::27) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:ad::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5fbdb15-257a-48b1-6f2e-08d6a60480eb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB6566;
x-ms-traffictypediagnostic: AM6PR04MB6566:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR04MB6566;23:kZOQMGleawVldBPA40VGBqc7m6H1+Z7xrUbr5m9?=
 =?iso-8859-1?Q?QbdoQVVAQXwdzKR3ECibK170FG37QEV3Gey4Qgvb0XIuZhr3T3b5ZFl+no?=
 =?iso-8859-1?Q?D/UvTs9yItBV1LxPs9zlgE8eUGo8YIZzkVlA0yJIwfNQnMkKmaP24ci3R7?=
 =?iso-8859-1?Q?2pLlg0LXQlWv4//1q/aCELfbU9aeLf11dKdQIdEofhtevVYBqsG175a5n9?=
 =?iso-8859-1?Q?0Sks+QAiQrBM2CD89sL3/514RcxRVNia5Z0VCe8DLYylBbi/2BMCPht79u?=
 =?iso-8859-1?Q?lcY33AkC4TeYMIEme6xFUME4V2lkL7MNCz43ttYEpY09emtPYB2HPkNr8M?=
 =?iso-8859-1?Q?U94+FxDCaXA1uWYyDlnh3oRaypKXKa3UhTlyCSBo/nGpbynVzGeHdixpYf?=
 =?iso-8859-1?Q?+KHba8chp/1LJVdt1uiWeLPYdA2XPvSFkm7VX93UzYQlTNJTI81p6//xXV?=
 =?iso-8859-1?Q?JF9iIn1Tc1yqLN36eVzQSp9bf5t4rCz7seH+ufCNya9zXyhk015u2wGkds?=
 =?iso-8859-1?Q?JMaHQO7fCLYWpLebv3vlpamcxYLyheaodQHZdoOV8jxWZ3SfDmnVlTadbz?=
 =?iso-8859-1?Q?T+DsZo5Q4cdoAIFul/mbcb7dm72AxCsgxh3O9AlptgG6Fd+EK3dTinUs0A?=
 =?iso-8859-1?Q?IA4ATwqANYd821vYDF3IOZyClZfLqp1fEQ11hYS80r2qwHPeBw+Wgt+sJm?=
 =?iso-8859-1?Q?luN0iuarjHVUjj6E9ardYN9/BDx8yhrnRyTB6fcHPQapznyKc3SIDew5GX?=
 =?iso-8859-1?Q?n3MFmLMOzzr4HVJThm0OSuDTb57B7yF3CAIYsR9Qacr3gmEwD2ThQ5ZMnw?=
 =?iso-8859-1?Q?uqL3GztDi8x31qzuQO1Ux45s1pKQnC+VUnvDndUqyWrJdDuJdm0zoBccGF?=
 =?iso-8859-1?Q?BuNfinQ7ipv8crSPSYP9X5/HBElpHgqb1h7vy1iLO3LhW4ERXTPemqY4zH?=
 =?iso-8859-1?Q?9OdHR2sHjSjSJG5S1TMHfobwZ59OqY+j9m9IriWq8aovAKFf8Yhj1y142W?=
 =?iso-8859-1?Q?O4hBWnenOdwnPC9xYQl6t0k1TGkwoY32N232riHKL05qCnrPxHvyPoxMoU?=
 =?iso-8859-1?Q?Xt5fs0Y47kCbGG/oHembJWgmV4ZyEPvjJ15w+cwV4FUAk+TgdL642Y6LpZ?=
 =?iso-8859-1?Q?BLtTffULkn4IXaWAswzjDTYeONj8ofW57/iEucXoy0JQc3o6mH8bNuv2Lg?=
 =?iso-8859-1?Q?k2ZsE3I6N79g/zpmWjtUzRadWAD1nERz6sSdmG3QNWHpZW/3iq1ieEpv0B?=
 =?iso-8859-1?Q?HkxKrWXVOFAj1KuBoGmUY0ble6mpptgxn1jXJNUDk0qIfPEapK9o4oNpHo?=
 =?iso-8859-1?Q?d9mGMMvVjCLvPk9roAxu1I7wPdWrhcNarJ8goOMCPR2LHDyYwpG4HpMi8V?=
 =?iso-8859-1?Q?inlR1oN4=3D?=
x-microsoft-antispam-prvs: <AM6PR04MB6566F6E527B5B39A90CF6EEE84480@AM6PR04MB6566.eurprd04.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(39860400002)(366004)(396003)(189003)(199004)(6512007)(8936002)(26005)(68736007)(53936002)(1076003)(316002)(14444005)(256004)(14454004)(186003)(305945005)(105586002)(4326008)(106356001)(7736002)(52116002)(386003)(66066001)(54906003)(50226002)(6506007)(36756003)(110136005)(102836004)(6116002)(76176011)(3846002)(486006)(81166006)(81156014)(478600001)(6436002)(25786009)(476003)(2616005)(11346002)(99286004)(97736004)(446003)(6486002)(2501003)(86362001)(7416002)(2906002)(71190400001)(71200400001)(2201001)(5660300002)(8676002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6566;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VQR7s65k6XKP9vgc8+qRuJy08gPUUKos9KcnjajPfC5WUChq9nIrRE7J8v/g+mVgPXseQ47+gPJaq/GhluPIUuuqksQUwwxf8NuILDm6xgPJBRXzGhAjKR6/ezcGUUc21aH3t9XvnOJUq0zZc46kTiI6ceWveq1GHMsHt5dYX7HzXRlmEKC2ua6F81tV5/bEm0rIrfpiDAkosQOshJSrljvO9iIjznuVD7H5wLEOTWEOgD2E5OGMbx9x9LEfN+JbkdsHW3k8QHbt+llyw8r55kSTBUfZpv9MmlCjSzS6AKZ4T4yXtXLkDn4AhUB0MuCpDWVT1LUXRDMQc/boEvA/EzV4yJ545UlvSZWJgm+xJx+xmHgTuAQD4YX9WNg1ARNIdANXRpkDBqI0d3D0XnHVvQ0m2tyndrau4xoWbGk1oNQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5fbdb15-257a-48b1-6f2e-08d6a60480eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 09:32:40.5316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6566
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Disabled all inbound and outbound windows before set up the windows
in kernel, in case transactions match the window set by bootloader.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
---
V4:
 - no change

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

