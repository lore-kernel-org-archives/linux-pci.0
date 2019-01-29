Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833C7C169C4
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 08:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46C33214DA
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 08:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lgsh2r26"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbfA2IKv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:10:51 -0500
Received: from mail-eopbgr50044.outbound.protection.outlook.com ([40.107.5.44]:30528
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727555AbfA2IKu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 03:10:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yswwHhxY3CmA5odLLO+DpwEYMpJo6mlvclSAye3x2g0=;
 b=lgsh2r26WnDzk8ABe+1mSf4TyQkJSoWSkquWsZjDfQUuonvdfw9JCaEilo2m9afdPf8MXISsRHTyy9rwZ41kWITBVtk6SKh6dPyD5qx3ZzPkNwZrYvHhAnj+Jql+ypLMJ9hEaPxmwEr2oDLaO57lZoJImheXsYfIPx5MocCSkoo=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB4728.eurprd04.prod.outlook.com (20.177.32.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Tue, 29 Jan 2019 08:10:43 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504%3]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 08:10:43 +0000
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
Subject: [PATCHv3 21/27] PCI: mobiveil: make mobiveil_host_init can be used to
 re-init host
Thread-Topic: [PATCHv3 21/27] PCI: mobiveil: make mobiveil_host_init can be
 used to re-init host
Thread-Index: AQHUt6ohojgx1Yze4UypyOz4JWt69w==
Date:   Tue, 29 Jan 2019 08:10:42 +0000
Message-ID: <20190129080926.36773-22-Zhiqiang.Hou@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4728;6:ahBt7z8yvQIj0BxqwfhxnLeFSB2yf7md9Ra/0F0hNCkvxXyEklm6i4zZ9/FXm6XCBd+u9HiJw3LbUn5wUlZ0074nPP99MRPFW3gESkq5DOJaxvVhVXQT5fjLdI+2/JdLIImtf+dJlrzsycIDDo2vU02dT1wGWfEZjrgAancgmrYNZpJ0nHXj/cQYOAUUs4XYexFonKsoq55vlBi9ORW+9dMMgUvpVJE4MtRF2ZJe6y6eTCCPOn9q8dAcpRMEmgEpMtOmHPCZ0dLFbdH874XsDskdokk4m7jrU6lvBif2OhqNDBpLKx4S+M7NwuvAAGLBn3dYeunOpAApAKgfCYPPFfG6H5nZfEodVHxrNDtNOXKw9eMUbQFOzFDNOaM9IqKbkb8BPdtzcK4upevhRxs1KVcq5jpkhvY4AgEAovL0l97HSxvVXVOggWwfnASYPHth3Zc1sgh9DJrjPSjFNBTmag==;5:nH57VSL0RO7qwMnelXiVMhT6ClqjdqfNW8bRT6v0N6bSHjpQ52YSrBtjhnDNLKBMDnbrLsrXfhkf2UdNEA5r0Zb60pkt5nWUVIzXw9ANmdFL6Ed54Ayj/v3YB6UfK0mxo6Zno79O6LkuSZTsnYs2bXQQNOzMf8XzCh2UyKu4Wx3pzS8XumYCMqBXZvH6x4+s1xMTAUpVd2Z/Eb0Pfkm4Lg==;7:JaX0rahzDq5b3NaUdlvxfXLIscpI0FSUT4yibCQy4XQvGVyj5/nT/6afCW+ZRFxCnEOp6oSi4cIZbfHT+Ca+aDOI9W+hLJHQohELRV21uFdNEwJX1RuJsHSlxfe2Q3CYnuZCUwUC/BS7lu6Byo+Aog==
x-ms-office365-filtering-correlation-id: 270c9557-7076-4b62-343f-08d685c14359
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4728;
x-ms-traffictypediagnostic: AM6PR04MB4728:
x-microsoft-antispam-prvs: <AM6PR04MB47286772F45E7052F831F67B84970@AM6PR04MB4728.eurprd04.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(39860400002)(346002)(376002)(189003)(199004)(3846002)(7416002)(71190400001)(71200400001)(2201001)(36756003)(4326008)(316002)(6512007)(105586002)(53936002)(6116002)(6436002)(106356001)(6486002)(86362001)(1076003)(97736004)(81166006)(81156014)(476003)(2616005)(486006)(256004)(52116002)(446003)(68736007)(50226002)(478600001)(2501003)(14444005)(8936002)(8676002)(66066001)(6506007)(386003)(2906002)(11346002)(102836004)(110136005)(26005)(54906003)(76176011)(305945005)(186003)(7736002)(99286004)(25786009)(14454004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4728;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HzNbQtwRanj6ULymwgzmb9sxenkKldORt08448TJ0GmAnYzo6oqK+KGrWwSnXoscKjgG0td/maxPLJQiZV39P1Dxx7dJXqIvZXFfEgkW6PKdaBU3d9J6OPMubsu2RLZINPz7hFPZY/gVl8hhK3DfWx7D3/+a6xGChQ3CKAPMUt9yElCS4jtARdKoZ9lV0TRBHmIajhXcGWMh8d28m/KELu/CcrjTmDdmupxtNfD7eqmqGyEW/Nti+NdGXQpnqk2ZgogT4JQhCIcuYSr4mAXvl31QkD7JVg+CycsySmR84b/Y48ywSfUXIFLdQdjRrfLcnLk3gocMnfcnv9nMSqXg6nwcqPZiiKV6YTFLzTjXUqu+5BxoNjJcdjvVJ0kqKyAarbvdKFeu+7wpa97f1LrYK0vxpBEBnKoNTiTKMjvMHoU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 270c9557-7076-4b62-343f-08d685c14359
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 08:10:36.8511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4728
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
---
V3:
 - Removed the duplicated free opteration of pcie->resources.

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

