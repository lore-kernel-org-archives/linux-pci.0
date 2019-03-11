Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753C8C43381
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 323942084D
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SGsUcs3/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfCKJdD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:33:03 -0400
Received: from mail-eopbgr150044.outbound.protection.outlook.com ([40.107.15.44]:37276
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727470AbfCKJdD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Mar 2019 05:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mwq4DogXXuQC1jDXHppEhLMKOvQm4SLl8Dw1Ilx4cnw=;
 b=SGsUcs3//zRPwTdHZi7d5pvdSXI4KX8Cz4NabZl1/OMLMYJevZoFlUp4E4wxaAP6semOAbYnrj6J1d1auJKkVsDgOsNMaIBP9XOIKvEnCZ4h/hoYXNUEIgiLUr0MAF2KA/LPt96YAMH8JOLFNgCv6gPYk8roOYH3O8MWD7npo9I=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB4168.eurprd04.prod.outlook.com (52.135.168.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.20; Mon, 11 Mar 2019 09:32:57 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7%2]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 09:32:57 +0000
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
Subject: [PATCHv4 22/28] PCI: mobiveil: make mobiveil_host_init can be used to
 re-init host
Thread-Topic: [PATCHv4 22/28] PCI: mobiveil: make mobiveil_host_init can be
 used to re-init host
Thread-Index: AQHU1+1pcpzAuc+rfEi+Yu/+RO94xQ==
Date:   Mon, 11 Mar 2019 09:32:57 +0000
Message-ID: <20190311093130.7209-23-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: d36aeac5-ae63-40f1-fb12-08d6a6048b4c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4168;
x-ms-traffictypediagnostic: AM6PR04MB4168:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR04MB4168;23:NO3AY5qwEkKSLM67ciI+Cd7CVesTrb345npIvLe?=
 =?iso-8859-1?Q?5/QfnIK0bQtw0t/pdlNgfun7deG0xtBiLYT0ifDz56jvALGpalc1Lq5zqd?=
 =?iso-8859-1?Q?qbakCHabiL9/8S7Ayyrjt2rECFvXA3xY7PeJ15vQPghBZvLuEa0o7alhmu?=
 =?iso-8859-1?Q?X8er2bEOO5Xvba+3+rz8gNEPZsYT0M1KZWgzxJlogn0g9IYI/erRF2cdcl?=
 =?iso-8859-1?Q?GnBT09TjMe2YBcvZZzD5Me8KOUl+lvY5K3JTyhHhaQIu35m6CitiM5MwxS?=
 =?iso-8859-1?Q?qMC/PF7t+F4wNw9Jr8Q/Uxy/3ui8eZ4wSp4Xrm0HJnRqwgEftcF0NeaISh?=
 =?iso-8859-1?Q?JPY3Til6dzSA2co1jk2j2MyaHOVm4gt31GmJZ6e2X7CgvJH1eRTYGe4391?=
 =?iso-8859-1?Q?47aps9hnqZP0OXzUcZQAiYBnSVJJt9BLMApZWHd90Gg7pA6MJi0A7K8VKJ?=
 =?iso-8859-1?Q?o/q+pFU9WW/5Xsh5eg+j9vztRDpBXmwVxA9jjZsqEXhUb7vrD4H8SkJAMH?=
 =?iso-8859-1?Q?afUFO6ZlsN3uOGqAURTj8zzXZzKYIG+Yp7yE5Q0D4tZ7DI54HwYBytoTI5?=
 =?iso-8859-1?Q?uELwtGA91dicCuvl3F9QFsKDqIFrqVkz9Xy/3xPaDnZftvKmnSxP+/tV1J?=
 =?iso-8859-1?Q?8ZBRkvPeuR2/57lxA59nOHnieYChq9M0ZPjfq5yFmFAy/vZHa0BALmuTwR?=
 =?iso-8859-1?Q?2KGDM0Wrf5+wiopvZiek/hObtSyrRw/zzltXribBbLbnOEOXjWi+U9CZeX?=
 =?iso-8859-1?Q?lH4lU8e5VbYbveH7Wvfjsj8n68BeCpYfr2I/7+9B1utbbhQ7EJxXFGQYxX?=
 =?iso-8859-1?Q?V7ACBm6PismcRM58jJuWvNimGxDhiJxL6rez67AIl6x0/592O+hNatMV9v?=
 =?iso-8859-1?Q?ugonLlCYpqXmRdvr+Tx+l4CniU2TAD3wxUxYKuQhymdxf+U2soVqZnNJrX?=
 =?iso-8859-1?Q?UQyIsPIMrxjc0U0EGwYY3/CnVs+ThK4xGXs9CvGImFD/pMJoe8KrSfoFeF?=
 =?iso-8859-1?Q?Zr81CQxa4cs5JhvfTGM0aTXV+qqLxLXdyjJj4Ejq3mJ2PsG+N9R2iJushO?=
 =?iso-8859-1?Q?g5z44IGcKii3fzgK3wQ2S1E2k6heYkY1VW3Slj15BxqQnWLxEQvZWJqHtb?=
 =?iso-8859-1?Q?xggImiiXSfVFtbgsnxwyfRbi5M2jidzrt1bB3NhCNgBX7ho7LsJK8zXYBy?=
 =?iso-8859-1?Q?6kAYUWGy++an0LODMxW0METYCUIafb0CLkcIUSd5u2kKSQTpSE5UThzXWc?=
 =?iso-8859-1?Q?ggaXpcJwcuPmYkWw83BawqzrPu/0Ama48dJa/ez6/25Y4Or4zEySwISmxY?=
 =?iso-8859-1?Q?s0Z/DaSrlJx6cVclAbyKfpeqf9AHXjR6o+nQdlRVJm73MuiOHUSxuO7dDU?=
 =?iso-8859-1?Q?wDsZTxbQ=3D?=
x-microsoft-antispam-prvs: <AM6PR04MB4168495C9021D4C43B52A3E684480@AM6PR04MB4168.eurprd04.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(376002)(366004)(346002)(189003)(199004)(106356001)(476003)(446003)(6512007)(105586002)(7736002)(486006)(11346002)(14444005)(305945005)(256004)(6486002)(2906002)(25786009)(54906003)(6116002)(110136005)(3846002)(71200400001)(2616005)(2201001)(86362001)(4326008)(71190400001)(68736007)(102836004)(5660300002)(81156014)(36756003)(2501003)(7416002)(6506007)(386003)(6436002)(97736004)(53936002)(316002)(186003)(26005)(76176011)(14454004)(8676002)(8936002)(52116002)(478600001)(1076003)(99286004)(50226002)(66066001)(81166006)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4168;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lFvATVmRb6mqGgUfKPRWeu55SauS7avvIueEYqWLLEbTuVAHaxhN/HLHv3jEHBHVFYr0n/5F9T3B+MfamlRIiT/R8ToziW/82HwLUjSRdqC62OpC90JVqoJZJx56ql1QKxvrkpYhajGNy8f8D4Fox/8r0+bDC29Qn5F2k0LAwgDkGDE4btr17+W2YiHgsBDe7Gb/3Kmu+PoPLu5BMPqlcujC86ftFF/qqtKbJzDBP9+MFDwGnNQAaW9pGAkvb2e6K36RHTelrS3xOMc+ZgI74jsLMHrUAIq91zz7OBcWs7BCdKWEjAW6dXblzAbitwqJ7CY7MzQ6p1VZvRd1YpaE4ocJ5/E3ADtwLBmVaoI0ntzhCNlA7w1KQiPj9xSawsO2JP9sxSBADTz6Shdu/QDKe258RPwr7wvt3IAFJX+NpCY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d36aeac5-ae63-40f1-fb12-08d6a6048b4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 09:32:57.1045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4168
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Make the mobiveil_host_init function can be used to re-init
host controller's PAB and GPEX CSR register block, as NXP
integrated Mobiveil IP has to reset and then re-init the PAB
and GPEX CSR registers upon Hot-reset.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
---
V4:
 - no change

 .../controller/mobiveil/pcie-mobiveil-host.c  | 41 ++++++++++---------
 .../pci/controller/mobiveil/pcie-mobiveil.h   |  3 +-
 2 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers=
/pci/controller/mobiveil/pcie-mobiveil-host.c
index d028cdf31d0e..e8d0c4989013 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -217,7 +217,7 @@ static void mobiveil_pcie_enable_msi(struct mobiveil_pc=
ie *pcie)
 	writel_relaxed(1, pcie->apb_csr_base + MSI_ENABLE_OFFSET);
 }
=20
-static int mobiveil_host_init(struct mobiveil_pcie *pcie)
+int mobiveil_host_init(struct mobiveil_pcie *pcie, bool reinit)
 {
 	u32 value, pab_ctrl, type;
 	struct resource_entry *win;
@@ -229,11 +229,16 @@ static int mobiveil_host_init(struct mobiveil_pcie *p=
cie)
 	for (i =3D 0; i < pcie->ppio_wins; i++)
 		mobiveil_pcie_disable_ib_win(pcie, i);
=20
-	/* setup bus numbers */
-	value =3D csr_readl(pcie, PCI_PRIMARY_BUS);
-	value &=3D 0xff000000;
-	value |=3D 0x00ff0100;
-	csr_writel(pcie, value, PCI_PRIMARY_BUS);
+	pcie->ib_wins_configured =3D 0;
+	pcie->ob_wins_configured =3D 0;
+
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
@@ -279,7 +284,7 @@ static int mobiveil_host_init(struct mobiveil_pcie *pci=
e)
 	program_ib_windows(pcie, WIN_NUM_0, 0, 0, MEM_WINDOW_TYPE, IB_WIN_SIZE);
=20
 	/* Get the I/O and memory ranges from DT */
-	resource_list_for_each_entry(win, &pcie->resources) {
+	resource_list_for_each_entry(win, pcie->resources) {
 		if (resource_type(win->res) =3D=3D IORESOURCE_MEM) {
 			type =3D MEM_WINDOW_TYPE;
 		} else if (resource_type(win->res) =3D=3D IORESOURCE_IO) {
@@ -550,8 +555,6 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie=
)
 	resource_size_t iobase;
 	int ret;
=20
-	INIT_LIST_HEAD(&pcie->resources);
-
 	ret =3D mobiveil_pcie_parse_dt(pcie);
 	if (ret) {
 		dev_err(dev, "Parsing DT failed, ret: %x\n", ret);
@@ -565,34 +568,35 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie *pc=
ie)
=20
 	/* parse the host bridge base addresses from the device tree file */
 	ret =3D devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
-						    &pcie->resources, &iobase);
+						    &bridge->windows, &iobase);
 	if (ret) {
 		dev_err(dev, "Getting bridge resources failed\n");
 		return ret;
 	}
=20
+	pcie->resources =3D &bridge->windows;
+
 	/*
 	 * configure all inbound and outbound windows and prepare the RC for
 	 * config access
 	 */
-	ret =3D mobiveil_host_init(pcie);
+	ret =3D mobiveil_host_init(pcie, false);
 	if (ret) {
 		dev_err(dev, "Failed to initialize host\n");
-		goto error;
+		return ret;
 	}
=20
 	ret =3D mobiveil_pcie_interrupt_init(pcie);
 	if (ret) {
 		dev_err(dev, "Interrupt init failed\n");
-		goto error;
+		return ret;
 	}
=20
-	ret =3D devm_request_pci_bus_resources(dev, &pcie->resources);
+	ret =3D devm_request_pci_bus_resources(dev, pcie->resources);
 	if (ret)
-		goto error;
+		return ret;
=20
 	/* Initialize bridge */
-	list_splice_init(&pcie->resources, &bridge->windows);
 	bridge->dev.parent =3D dev;
 	bridge->sysdata =3D pcie;
 	bridge->busnr =3D pcie->rp.root_bus_nr;
@@ -608,7 +612,7 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie=
)
 	/* setup the kernel resources for the newly added PCIe root bus */
 	ret =3D pci_scan_root_bus_bridge(bridge);
 	if (ret)
-		goto error;
+		return ret;
=20
 	bus =3D bridge->bus;
=20
@@ -618,7 +622,4 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie=
)
 	pci_bus_add_devices(bus);
=20
 	return 0;
-error:
-	pci_free_resource_list(&pcie->resources);
-	return ret;
 }
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/=
controller/mobiveil/pcie-mobiveil.h
index 933c2f34bc52..0f5303962e88 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
@@ -152,7 +152,7 @@ struct mobiveil_pab_ops {
=20
 struct mobiveil_pcie {
 	struct platform_device *pdev;
-	struct list_head resources;
+	struct list_head *resources;
 	void __iomem *csr_axi_slave_base;	/* PAB registers base */
 	phys_addr_t pcie_reg_base;	/* Physical PCIe Controller Base */
 	void __iomem *apb_csr_base;	/* MSI register base */
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

