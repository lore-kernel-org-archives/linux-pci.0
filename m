Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F071CC43381
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C53920657
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NW2LyKvB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfCKJaV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:30:21 -0400
Received: from mail-eopbgr70072.outbound.protection.outlook.com ([40.107.7.72]:19328
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727023AbfCKJaV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Mar 2019 05:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cezUt4WeCfbYhipGj2NEot4mc4h1ZS+wGxlICJH4nhw=;
 b=NW2LyKvBtcrEDC4h87du3xu3Sunp2z3Yt/C+tcsMZSQS57nzEWq3h2H6TjMRdcfo/obXRxEeiy+pZsiMCojfw5PwZwIyEwajkUwqkm/WE2eqynFPI2hwM8nGIZJWswdIseb9UY94a9SZkb8mXS6s09+vOsfWo6OA8OS8UjZU+uE=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5592.eurprd04.prod.outlook.com (20.178.87.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Mon, 11 Mar 2019 09:30:12 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7%2]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 09:30:12 +0000
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
Subject: [PATCHv4 02/28] PCI: mobiveil: format the code without function
 change
Thread-Topic: [PATCHv4 02/28] PCI: mobiveil: format the code without function
 change
Thread-Index: AQHU1+0GtNDXcg9tSEi+CjVKim1H0Q==
Date:   Mon, 11 Mar 2019 09:30:12 +0000
Message-ID: <20190311093130.7209-3-Zhiqiang.Hou@nxp.com>
References: <20190311093130.7209-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190311093130.7209-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0015.apcprd03.prod.outlook.com
 (2603:1096:203:2e::27) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:ad::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: feaaea6d-ba08-481a-fac8-08d6a604276d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5592;
x-ms-traffictypediagnostic: AM6PR04MB5592:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR04MB5592;23:t+BH8e9V5HiMFmu4qKsWVMJsZ7VRcWEetyp84ti?=
 =?iso-8859-1?Q?XUiOB5dvDbdp/d6x2uODF1/enOMHjk+oEBQa7GWmQoRNb8LGnOFQ+Ref26?=
 =?iso-8859-1?Q?P/WERA8JrFe5rcTogzpapNr3A7/N+hVf/h6fQalrGfHlSeQkZF158blzVl?=
 =?iso-8859-1?Q?Je4oE5JPIB/FEUmnJSTrdmMOKxgjBcbIeT4IxhHK/rbzArzia5T2Va3ijn?=
 =?iso-8859-1?Q?99/EUzCBC1v/pZ1ONMYeGnTwRhikbUSAvexnjgWwMY6TbDdPIyYfR3k4Fc?=
 =?iso-8859-1?Q?w7f/GGBKCUjt+/VeiA0bPZ97X5ROPsbFumPvmyLUqV+82bTOmE0v3GAtPF?=
 =?iso-8859-1?Q?m+jwPiHxwrKbphXZcfQczcKQmvViO+wDHuN0saZ7GVlPY/akj3241ZGFLe?=
 =?iso-8859-1?Q?jrE3LTl+vBi3bKkAi0hmdOtoSKpqDf5R5YLsXiCRtZPRVGe2A5K/iA/hdR?=
 =?iso-8859-1?Q?0o/omSyMNCmm0MwDju1hxaBfkzyrBS3O4OkAYynR07DZJ4E62Wa7Vj+7tC?=
 =?iso-8859-1?Q?27szeIFnasmrmkAvDVUjzEeeGBERogQRAOI89ZvfE02dmDMyOHicNa5mLv?=
 =?iso-8859-1?Q?GntxngylOG/aiCxzlhjcQ0nLkPRJzI5WeT5/wIYFsLs3U+aID9+Au6HSVl?=
 =?iso-8859-1?Q?9CIhZqDvWX7Unt8plwk8i3ydKfrawgg/E0V9UYL/W4vaoTJsJNw08JHrNQ?=
 =?iso-8859-1?Q?t/UnDrvV8o3+0gSfFlt+uLH1xiTW68GhhXkJHKebRCVEXV7DE7X94cGQTw?=
 =?iso-8859-1?Q?iGE6JYsJ6SwwpwA3aLojR1HxoOJYDLsFxlZjW7rOKcQNjkLoUtgZOjaa/D?=
 =?iso-8859-1?Q?AIuasWtyKqVx6tS0qO+Pkbd7U7CRBTPiAQtkGebNuHUgFkg2CScgSucj7A?=
 =?iso-8859-1?Q?tOCgCiI24fbN07txklTYcMzlm8zmyEVIKyoZKWn088T3QhI5S7hxHKIo6k?=
 =?iso-8859-1?Q?m3V5TrqUOIVBzvh6Ksd169wkWKGvqUiW2+n7AvuQWF6dneFEBexpIxkELy?=
 =?iso-8859-1?Q?Fh9pzN071Ciolm1/BzUyJ1QQeSrwjaCg34MixhmnRvC6TGumT9eCBXjhpd?=
 =?iso-8859-1?Q?jvIAC5jp8miA8MMk1lPzPx9keu03c7IYSnAmONCN2GVaOFxpKcQ7eQxIU9?=
 =?iso-8859-1?Q?bfK6etESNsey6ewzYNYQd9OcY6Jnu1BtUySbWrC2/5u+Xlp5aDGHITW8g3?=
 =?iso-8859-1?Q?Iy4cDLxiffdp43+vWsffLtUjCEFe7Lrko//yLqLRYSeIQZL8U35muRHedf?=
 =?iso-8859-1?Q?ap9yInbyTF7ac08o1IDEbW5bUGnRnIXZ2mIlCWwAyAfE5Oa65POjOnNoiN?=
 =?iso-8859-1?Q?Tv1rbCTmpvyqn/NeAgQU4w/QrV+cTQaNFp0eRQXv1rUTQk/CYB73V1uw5v?=
 =?iso-8859-1?Q?ANGn+ClM/fVwbkSbW/BW4JaSVCcaDhOlXP/xJ/dbMQb1ygazfaNfD5qfkE?=
 =?iso-8859-1?Q?fvu/SkpdziaAGo=3D?=
x-microsoft-antispam-prvs: <AM6PR04MB55924646CC9BF22FBD824C9E84480@AM6PR04MB5592.eurprd04.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(376002)(136003)(39860400002)(199004)(189003)(5660300002)(30864003)(4326008)(2201001)(8676002)(478600001)(81166006)(81156014)(14454004)(86362001)(8936002)(50226002)(7416002)(14444005)(256004)(1076003)(71200400001)(71190400001)(2616005)(476003)(486006)(11346002)(446003)(186003)(305945005)(7736002)(97736004)(68736007)(66066001)(36756003)(6486002)(105586002)(53946003)(106356001)(6436002)(6512007)(110136005)(76176011)(54906003)(52116002)(99286004)(26005)(386003)(6506007)(3846002)(316002)(6116002)(102836004)(6346003)(25786009)(53936002)(2906002)(2501003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5592;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9Y5QrI+BPC3laxZF9uXHiCHTGr+FDtljSYKK2ItIK+dWuxMzbvBfGzFV9o0lrhWC3hcptxy5BL+tpXtUHrQz40to1033FtcFxHxS24knVzq73qZDJq1IQXYTG6NqS7B4Hzu28AoEYHQVEmD+sfx2PMr/W/0k3wZJ+jo7UHUmp7m2KAzzV4SMQOSF4tkux4bN0/qujJ5P6FCtgCBih6d1wNLjTekQDA+ZSFu0I5gBfoVPIKlqKnGDoq6tuzeVJKZqAvRvcHLEvFWWb3maEY3GovqGAFZ+3X4Ud8pEKP+FNXR72+yQGCWIo1d5QwIqQ6wKNIj962pzsvDk+IwWK2CTC08/itFTiNNYPHu7UuWcnySAL1O5/2gnJlzdDRAUMZnsPEG9bHl0xMeJCqMNDYvAwza7VJiHIZnhQPEpnuuCjO8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feaaea6d-ba08-481a-fac8-08d6a604276d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 09:30:12.3006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5592
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Just format the code without functionality change.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
---
V4:
 - no change

 drivers/pci/controller/pcie-mobiveil.c | 261 +++++++++++++------------
 1 file changed, 137 insertions(+), 124 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controlle=
r/pcie-mobiveil.c
index d55c7e780c6e..b87471f08a40 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -31,38 +31,40 @@
  * translation tables are grouped into windows, each window registers are
  * grouped into blocks of 4 or 16 registers each
  */
-#define PAB_REG_BLOCK_SIZE	16
-#define PAB_EXT_REG_BLOCK_SIZE	4
+#define PAB_REG_BLOCK_SIZE		16
+#define PAB_EXT_REG_BLOCK_SIZE		4
=20
-#define PAB_REG_ADDR(offset, win) (offset + (win * PAB_REG_BLOCK_SIZE))
-#define PAB_EXT_REG_ADDR(offset, win) (offset + (win * PAB_EXT_REG_BLOCK_S=
IZE))
+#define PAB_REG_ADDR(offset, win)	\
+	(offset + (win * PAB_REG_BLOCK_SIZE))
+#define PAB_EXT_REG_ADDR(offset, win)	\
+	(offset + (win * PAB_EXT_REG_BLOCK_SIZE))
=20
-#define LTSSM_STATUS		0x0404
-#define  LTSSM_STATUS_L0_MASK	0x3f
-#define  LTSSM_STATUS_L0	0x2d
+#define LTSSM_STATUS			0x0404
+#define  LTSSM_STATUS_L0_MASK		0x3f
+#define  LTSSM_STATUS_L0		0x2d
=20
-#define PAB_CTRL		0x0808
-#define  AMBA_PIO_ENABLE_SHIFT	0
-#define  PEX_PIO_ENABLE_SHIFT	1
-#define  PAGE_SEL_SHIFT	13
-#define  PAGE_SEL_MASK		0x3f
-#define  PAGE_LO_MASK		0x3ff
-#define  PAGE_SEL_OFFSET_SHIFT	10
+#define PAB_CTRL			0x0808
+#define  AMBA_PIO_ENABLE_SHIFT		0
+#define  PEX_PIO_ENABLE_SHIFT		1
+#define  PAGE_SEL_SHIFT			13
+#define  PAGE_SEL_MASK			0x3f
+#define  PAGE_LO_MASK			0x3ff
+#define  PAGE_SEL_OFFSET_SHIFT		10
=20
-#define PAB_AXI_PIO_CTRL	0x0840
-#define  APIO_EN_MASK		0xf
+#define PAB_AXI_PIO_CTRL		0x0840
+#define  APIO_EN_MASK			0xf
=20
-#define PAB_PEX_PIO_CTRL	0x08c0
-#define  PIO_ENABLE_SHIFT	0
+#define PAB_PEX_PIO_CTRL		0x08c0
+#define  PIO_ENABLE_SHIFT		0
=20
 #define PAB_INTP_AMBA_MISC_ENB		0x0b0c
-#define PAB_INTP_AMBA_MISC_STAT	0x0b1c
+#define PAB_INTP_AMBA_MISC_STAT		0x0b1c
 #define  PAB_INTP_INTX_MASK		0x01e0
 #define  PAB_INTP_MSI_MASK		0x8
=20
-#define PAB_AXI_AMAP_CTRL(win)	PAB_REG_ADDR(0x0ba0, win)
-#define  WIN_ENABLE_SHIFT	0
-#define  WIN_TYPE_SHIFT	1
+#define PAB_AXI_AMAP_CTRL(win)		PAB_REG_ADDR(0x0ba0, win)
+#define  WIN_ENABLE_SHIFT		0
+#define  WIN_TYPE_SHIFT			1
=20
 #define PAB_EXT_AXI_AMAP_SIZE(win)	PAB_EXT_REG_ADDR(0xbaf0, win)
=20
@@ -70,16 +72,16 @@
 #define  AXI_WINDOW_ALIGN_MASK		3
=20
 #define PAB_AXI_AMAP_PEX_WIN_L(win)	PAB_REG_ADDR(0x0ba8, win)
-#define  PAB_BUS_SHIFT		24
-#define  PAB_DEVICE_SHIFT	19
-#define  PAB_FUNCTION_SHIFT	16
+#define  PAB_BUS_SHIFT			24
+#define  PAB_DEVICE_SHIFT		19
+#define  PAB_FUNCTION_SHIFT		16
=20
 #define PAB_AXI_AMAP_PEX_WIN_H(win)	PAB_REG_ADDR(0x0bac, win)
 #define PAB_INTP_AXI_PIO_CLASS		0x474
=20
-#define PAB_PEX_AMAP_CTRL(win)	PAB_REG_ADDR(0x4ba0, win)
-#define  AMAP_CTRL_EN_SHIFT	0
-#define  AMAP_CTRL_TYPE_SHIFT	1
+#define PAB_PEX_AMAP_CTRL(win)		PAB_REG_ADDR(0x4ba0, win)
+#define  AMAP_CTRL_EN_SHIFT		0
+#define  AMAP_CTRL_TYPE_SHIFT		1
=20
 #define PAB_EXT_PEX_AMAP_SIZEN(win)	PAB_EXT_REG_ADDR(0xbef0, win)
 #define PAB_PEX_AMAP_AXI_WIN(win)	PAB_REG_ADDR(0x4ba4, win)
@@ -87,39 +89,39 @@
 #define PAB_PEX_AMAP_PEX_WIN_H(win)	PAB_REG_ADDR(0x4bac, win)
=20
 /* starting offset of INTX bits in status register */
-#define PAB_INTX_START	5
+#define PAB_INTX_START			5
=20
 /* supported number of MSI interrupts */
-#define PCI_NUM_MSI	16
+#define PCI_NUM_MSI			16
=20
 /* MSI registers */
-#define MSI_BASE_LO_OFFSET	0x04
-#define MSI_BASE_HI_OFFSET	0x08
-#define MSI_SIZE_OFFSET	0x0c
-#define MSI_ENABLE_OFFSET	0x14
-#define MSI_STATUS_OFFSET	0x18
-#define MSI_DATA_OFFSET	0x20
-#define MSI_ADDR_L_OFFSET	0x24
-#define MSI_ADDR_H_OFFSET	0x28
+#define MSI_BASE_LO_OFFSET		0x04
+#define MSI_BASE_HI_OFFSET		0x08
+#define MSI_SIZE_OFFSET			0x0c
+#define MSI_ENABLE_OFFSET		0x14
+#define MSI_STATUS_OFFSET		0x18
+#define MSI_DATA_OFFSET			0x20
+#define MSI_ADDR_L_OFFSET		0x24
+#define MSI_ADDR_H_OFFSET		0x28
=20
 /* outbound and inbound window definitions */
-#define WIN_NUM_0		0
-#define WIN_NUM_1		1
-#define CFG_WINDOW_TYPE	0
-#define IO_WINDOW_TYPE		1
-#define MEM_WINDOW_TYPE	2
-#define IB_WIN_SIZE		((u64)256 * 1024 * 1024 * 1024)
-#define MAX_PIO_WINDOWS	8
+#define WIN_NUM_0			0
+#define WIN_NUM_1			1
+#define CFG_WINDOW_TYPE			0
+#define IO_WINDOW_TYPE			1
+#define MEM_WINDOW_TYPE			2
+#define IB_WIN_SIZE			((u64)256 * 1024 * 1024 * 1024)
+#define MAX_PIO_WINDOWS			8
=20
 /* Parameters for the waiting for link up routine */
-#define LINK_WAIT_MAX_RETRIES	10
-#define LINK_WAIT_MIN	90000
-#define LINK_WAIT_MAX	100000
+#define LINK_WAIT_MAX_RETRIES		10
+#define LINK_WAIT_MIN			90000
+#define LINK_WAIT_MAX			100000
=20
-#define PAGED_ADDR_BNDRY			0xc00
-#define OFFSET_TO_PAGE_ADDR(off)		\
+#define PAGED_ADDR_BNDRY		0xc00
+#define OFFSET_TO_PAGE_ADDR(off)	\
 	((off & PAGE_LO_MASK) | PAGED_ADDR_BNDRY)
-#define OFFSET_TO_PAGE_IDX(off)			\
+#define OFFSET_TO_PAGE_IDX(off)		\
 	((off >> PAGE_SEL_OFFSET_SHIFT) & PAGE_SEL_MASK)
=20
 struct mobiveil_msi {			/* MSI information */
@@ -297,14 +299,14 @@ static void __iomem *mobiveil_pcie_map_bus(struct pci=
_bus *bus,
 					unsigned int devfn, int where)
 {
 	struct mobiveil_pcie *pcie =3D bus->sysdata;
+	u32 value;
=20
 	if (!mobiveil_pcie_valid_device(bus, devfn))
 		return NULL;
=20
-	if (bus->number =3D=3D pcie->root_bus_nr) {
-		/* RC config access */
+	/* RC config access */
+	if (bus->number =3D=3D pcie->root_bus_nr)
 		return pcie->csr_axi_slave_base + where;
-	}
=20
 	/*
 	 * EP config access (in Config/APIO space)
@@ -312,10 +314,12 @@ static void __iomem *mobiveil_pcie_map_bus(struct pci=
_bus *bus,
 	 * (BDF) in PAB_AXI_AMAP_PEX_WIN_L0 Register.
 	 * Relies on pci_lock serialization
 	 */
-	csr_writel(pcie, bus->number << PAB_BUS_SHIFT |
-			PCI_SLOT(devfn) << PAB_DEVICE_SHIFT |
-			PCI_FUNC(devfn) << PAB_FUNCTION_SHIFT,
-			PAB_AXI_AMAP_PEX_WIN_L(WIN_NUM_0));
+	value =3D bus->number << PAB_BUS_SHIFT |
+		PCI_SLOT(devfn) << PAB_DEVICE_SHIFT |
+		PCI_FUNC(devfn) << PAB_FUNCTION_SHIFT;
+
+	csr_writel(pcie, value, PAB_AXI_AMAP_PEX_WIN_L(WIN_NUM_0));
+
 	return pcie->config_axi_slave_base + where;
 }
=20
@@ -350,22 +354,22 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
=20
 	/* Handle INTx */
 	if (intr_status & PAB_INTP_INTX_MASK) {
-		shifted_status =3D csr_readl(pcie, PAB_INTP_AMBA_MISC_STAT) >>
-			PAB_INTX_START;
+		shifted_status =3D csr_readl(pcie, PAB_INTP_AMBA_MISC_STAT);
+		shifted_status >>=3D PAB_INTX_START;
 		do {
 			for_each_set_bit(bit, &shifted_status, PCI_NUM_INTX) {
 				virq =3D irq_find_mapping(pcie->intx_domain,
-						bit + 1);
+							bit + 1);
 				if (virq)
 					generic_handle_irq(virq);
 				else
-					dev_err_ratelimited(dev,
-						"unexpected IRQ, INT%d\n", bit);
+					dev_err_ratelimited(dev, "unexpected IRQ, INT%d\n",
+							    bit);
=20
 				/* clear interrupt */
 				csr_writel(pcie,
-					shifted_status << PAB_INTX_START,
-					PAB_INTP_AMBA_MISC_STAT);
+					   shifted_status << PAB_INTX_START,
+					   PAB_INTP_AMBA_MISC_STAT);
 			}
 		} while ((shifted_status >> PAB_INTX_START) !=3D 0);
 	}
@@ -375,8 +379,7 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
=20
 	/* handle MSI interrupts */
 	while (msi_status & 1) {
-		msi_data =3D readl_relaxed(pcie->apb_csr_base
-				+ MSI_DATA_OFFSET);
+		msi_data =3D readl_relaxed(pcie->apb_csr_base + MSI_DATA_OFFSET);
=20
 		/*
 		 * MSI_STATUS_OFFSET register gets updated to zero
@@ -385,18 +388,18 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
 		 * two dummy reads.
 		 */
 		msi_addr_lo =3D readl_relaxed(pcie->apb_csr_base +
-				MSI_ADDR_L_OFFSET);
+					    MSI_ADDR_L_OFFSET);
 		msi_addr_hi =3D readl_relaxed(pcie->apb_csr_base +
-				MSI_ADDR_H_OFFSET);
+					    MSI_ADDR_H_OFFSET);
 		dev_dbg(dev, "MSI registers, data: %08x, addr: %08x:%08x\n",
-				msi_data, msi_addr_hi, msi_addr_lo);
+			msi_data, msi_addr_hi, msi_addr_lo);
=20
 		virq =3D irq_find_mapping(msi->dev_domain, msi_data);
 		if (virq)
 			generic_handle_irq(virq);
=20
 		msi_status =3D readl_relaxed(pcie->apb_csr_base +
-				MSI_STATUS_OFFSET);
+					   MSI_STATUS_OFFSET);
 	}
=20
 	/* Clear the interrupt status */
@@ -413,7 +416,7 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie =
*pcie)
=20
 	/* map config resource */
 	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
-			"config_axi_slave");
+					   "config_axi_slave");
 	pcie->config_axi_slave_base =3D devm_pci_remap_cfg_resource(dev, res);
 	if (IS_ERR(pcie->config_axi_slave_base))
 		return PTR_ERR(pcie->config_axi_slave_base);
@@ -421,7 +424,7 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie =
*pcie)
=20
 	/* map csr resource */
 	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
-			"csr_axi_slave");
+					   "csr_axi_slave");
 	pcie->csr_axi_slave_base =3D devm_pci_remap_cfg_resource(dev, res);
 	if (IS_ERR(pcie->csr_axi_slave_base))
 		return PTR_ERR(pcie->csr_axi_slave_base);
@@ -452,7 +455,7 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie =
*pcie)
 }
=20
 static void program_ib_windows(struct mobiveil_pcie *pcie, int win_num,
-		int pci_addr, u32 type, u64 size)
+			       int pci_addr, u32 type, u64 size)
 {
 	int pio_ctrl_val;
 	int amap_ctrl_dw;
@@ -465,19 +468,20 @@ static void program_ib_windows(struct mobiveil_pcie *=
pcie, int win_num,
 	}
=20
 	pio_ctrl_val =3D csr_readl(pcie, PAB_PEX_PIO_CTRL);
-	csr_writel(pcie,
-		pio_ctrl_val | (1 << PIO_ENABLE_SHIFT), PAB_PEX_PIO_CTRL);
-	amap_ctrl_dw =3D csr_readl(pcie, PAB_PEX_AMAP_CTRL(win_num));
-	amap_ctrl_dw =3D (amap_ctrl_dw | (type << AMAP_CTRL_TYPE_SHIFT));
-	amap_ctrl_dw =3D (amap_ctrl_dw | (1 << AMAP_CTRL_EN_SHIFT));
+	pio_ctrl_val |=3D 1 << PIO_ENABLE_SHIFT;
+	csr_writel(pcie, pio_ctrl_val, PAB_PEX_PIO_CTRL);
=20
-	csr_writel(pcie, amap_ctrl_dw | lower_32_bits(size64),
-		   PAB_PEX_AMAP_CTRL(win_num));
+	amap_ctrl_dw =3D csr_readl(pcie, PAB_PEX_AMAP_CTRL(win_num));
+	amap_ctrl_dw |=3D (type << AMAP_CTRL_TYPE_SHIFT) |
+			(1 << AMAP_CTRL_EN_SHIFT) |
+			lower_32_bits(size64);
+	csr_writel(pcie, amap_ctrl_dw, PAB_PEX_AMAP_CTRL(win_num));
=20
 	csr_writel(pcie, upper_32_bits(size64),
 		   PAB_EXT_PEX_AMAP_SIZEN(win_num));
=20
 	csr_writel(pcie, pci_addr, PAB_PEX_AMAP_AXI_WIN(win_num));
+
 	csr_writel(pcie, pci_addr, PAB_PEX_AMAP_PEX_WIN_L(win_num));
 	csr_writel(pcie, 0, PAB_PEX_AMAP_PEX_WIN_H(win_num));
 }
@@ -486,7 +490,8 @@ static void program_ib_windows(struct mobiveil_pcie *pc=
ie, int win_num,
  * routine to program the outbound windows
  */
 static void program_ob_windows(struct mobiveil_pcie *pcie, int win_num,
-		u64 cpu_addr, u64 pci_addr, u32 config_io_bit, u64 size)
+			       u64 cpu_addr, u64 pci_addr,
+			       u32 config_io_bit, u64 size)
 {
=20
 	u32 value, type;
@@ -505,7 +510,7 @@ static void program_ob_windows(struct mobiveil_pcie *pc=
ie, int win_num,
 	type =3D config_io_bit;
 	value =3D csr_readl(pcie, PAB_AXI_AMAP_CTRL(win_num));
 	csr_writel(pcie, 1 << WIN_ENABLE_SHIFT | type << WIN_TYPE_SHIFT |
-			lower_32_bits(size64), PAB_AXI_AMAP_CTRL(win_num));
+		   lower_32_bits(size64), PAB_AXI_AMAP_CTRL(win_num));
=20
 	csr_writel(pcie, upper_32_bits(size64), PAB_EXT_AXI_AMAP_SIZE(win_num));
=20
@@ -515,14 +520,14 @@ static void program_ob_windows(struct mobiveil_pcie *=
pcie, int win_num,
 	 */
 	value =3D csr_readl(pcie, PAB_AXI_AMAP_AXI_WIN(win_num));
 	csr_writel(pcie, cpu_addr & (~AXI_WINDOW_ALIGN_MASK),
-			PAB_AXI_AMAP_AXI_WIN(win_num));
+		   PAB_AXI_AMAP_AXI_WIN(win_num));
=20
 	value =3D csr_readl(pcie, PAB_AXI_AMAP_PEX_WIN_H(win_num));
=20
 	csr_writel(pcie, lower_32_bits(pci_addr),
-			PAB_AXI_AMAP_PEX_WIN_L(win_num));
+		   PAB_AXI_AMAP_PEX_WIN_L(win_num));
 	csr_writel(pcie, upper_32_bits(pci_addr),
-			PAB_AXI_AMAP_PEX_WIN_H(win_num));
+		   PAB_AXI_AMAP_PEX_WIN_H(win_num));
=20
 	pcie->ob_wins_configured++;
 }
@@ -538,7 +543,9 @@ static int mobiveil_bringup_link(struct mobiveil_pcie *=
pcie)
=20
 		usleep_range(LINK_WAIT_MIN, LINK_WAIT_MAX);
 	}
+
 	dev_err(&pcie->pdev->dev, "link never came up\n");
+
 	return -ETIMEDOUT;
 }
=20
@@ -551,16 +558,16 @@ static void mobiveil_pcie_enable_msi(struct mobiveil_=
pcie *pcie)
 	msi->msi_pages_phys =3D (phys_addr_t)msg_addr;
=20
 	writel_relaxed(lower_32_bits(msg_addr),
-		pcie->apb_csr_base + MSI_BASE_LO_OFFSET);
+		       pcie->apb_csr_base + MSI_BASE_LO_OFFSET);
 	writel_relaxed(upper_32_bits(msg_addr),
-		pcie->apb_csr_base + MSI_BASE_HI_OFFSET);
+		       pcie->apb_csr_base + MSI_BASE_HI_OFFSET);
 	writel_relaxed(4096, pcie->apb_csr_base + MSI_SIZE_OFFSET);
 	writel_relaxed(1, pcie->apb_csr_base + MSI_ENABLE_OFFSET);
 }
=20
 static int mobiveil_host_init(struct mobiveil_pcie *pcie)
 {
-	u32 value, pab_ctrl, type =3D 0;
+	u32 value, pab_ctrl, type;
 	int err;
 	struct resource_entry *win, *tmp;
=20
@@ -575,26 +582,27 @@ static int mobiveil_host_init(struct mobiveil_pcie *p=
cie)
 	 * Space
 	 */
 	value =3D csr_readl(pcie, PCI_COMMAND);
-	csr_writel(pcie, value | PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
-		PCI_COMMAND_MASTER, PCI_COMMAND);
+	value |=3D PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER;
+	csr_writel(pcie, value, PCI_COMMAND);
=20
 	/*
 	 * program PIO Enable Bit to 1 (and PEX PIO Enable to 1) in PAB_CTRL
 	 * register
 	 */
 	pab_ctrl =3D csr_readl(pcie, PAB_CTRL);
-	csr_writel(pcie, pab_ctrl | (1 << AMBA_PIO_ENABLE_SHIFT) |
-		(1 << PEX_PIO_ENABLE_SHIFT), PAB_CTRL);
+	pab_ctrl |=3D (1 << AMBA_PIO_ENABLE_SHIFT) | (1 << PEX_PIO_ENABLE_SHIFT);
+	csr_writel(pcie, pab_ctrl, PAB_CTRL);
=20
 	csr_writel(pcie, (PAB_INTP_INTX_MASK | PAB_INTP_MSI_MASK),
-		PAB_INTP_AMBA_MISC_ENB);
+		   PAB_INTP_AMBA_MISC_ENB);
=20
 	/*
 	 * program PIO Enable Bit to 1 and Config Window Enable Bit to 1 in
 	 * PAB_AXI_PIO_CTRL Register
 	 */
 	value =3D csr_readl(pcie, PAB_AXI_PIO_CTRL);
-	csr_writel(pcie, value | APIO_EN_MASK, PAB_AXI_PIO_CTRL);
+	value |=3D APIO_EN_MASK;
+	csr_writel(pcie, value, PAB_AXI_PIO_CTRL);
=20
 	/*
 	 * we'll program one outbound window for config reads and
@@ -605,25 +613,25 @@ static int mobiveil_host_init(struct mobiveil_pcie *p=
cie)
=20
 	/* config outbound translation window */
 	program_ob_windows(pcie, pcie->ob_wins_configured,
-			pcie->ob_io_res->start, 0, CFG_WINDOW_TYPE,
-			resource_size(pcie->ob_io_res));
+			   pcie->ob_io_res->start, 0, CFG_WINDOW_TYPE,
+			   resource_size(pcie->ob_io_res));
=20
 	/* memory inbound translation window */
 	program_ib_windows(pcie, WIN_NUM_1, 0, MEM_WINDOW_TYPE, IB_WIN_SIZE);
=20
 	/* Get the I/O and memory ranges from DT */
 	resource_list_for_each_entry_safe(win, tmp, &pcie->resources) {
-		type =3D 0;
 		if (resource_type(win->res) =3D=3D IORESOURCE_MEM)
 			type =3D MEM_WINDOW_TYPE;
-		if (resource_type(win->res) =3D=3D IORESOURCE_IO)
+		else if (resource_type(win->res) =3D=3D IORESOURCE_IO)
 			type =3D IO_WINDOW_TYPE;
-		if (type) {
-			/* configure outbound translation window */
-			program_ob_windows(pcie, pcie->ob_wins_configured,
-				win->res->start, 0, type,
-				resource_size(win->res));
-		}
+		else
+			continue;
+
+		/* configure outbound translation window */
+		program_ob_windows(pcie, pcie->ob_wins_configured,
+				   win->res->start, 0, type,
+				   resource_size(win->res));
 	}
=20
 	/* setup MSI hardware registers */
@@ -643,7 +651,8 @@ static void mobiveil_mask_intx_irq(struct irq_data *dat=
a)
 	mask =3D 1 << ((data->hwirq + PAB_INTX_START) - 1);
 	raw_spin_lock_irqsave(&pcie->intx_mask_lock, flags);
 	shifted_val =3D csr_readl(pcie, PAB_INTP_AMBA_MISC_ENB);
-	csr_writel(pcie, (shifted_val & (~mask)), PAB_INTP_AMBA_MISC_ENB);
+	shifted_val &=3D ~mask;
+	csr_writel(pcie, shifted_val, PAB_INTP_AMBA_MISC_ENB);
 	raw_spin_unlock_irqrestore(&pcie->intx_mask_lock, flags);
 }
=20
@@ -658,7 +667,8 @@ static void mobiveil_unmask_intx_irq(struct irq_data *d=
ata)
 	mask =3D 1 << ((data->hwirq + PAB_INTX_START) - 1);
 	raw_spin_lock_irqsave(&pcie->intx_mask_lock, flags);
 	shifted_val =3D csr_readl(pcie, PAB_INTP_AMBA_MISC_ENB);
-	csr_writel(pcie, (shifted_val | mask), PAB_INTP_AMBA_MISC_ENB);
+	shifted_val |=3D mask;
+	csr_writel(pcie, shifted_val, PAB_INTP_AMBA_MISC_ENB);
 	raw_spin_unlock_irqrestore(&pcie->intx_mask_lock, flags);
 }
=20
@@ -672,10 +682,11 @@ static struct irq_chip intx_irq_chip =3D {
=20
 /* routine to setup the INTx related data */
 static int mobiveil_pcie_intx_map(struct irq_domain *domain, unsigned int =
irq,
-		irq_hw_number_t hwirq)
+				  irq_hw_number_t hwirq)
 {
 	irq_set_chip_and_handler(irq, &intx_irq_chip, handle_level_irq);
 	irq_set_chip_data(irq, domain->host_data);
+
 	return 0;
 }
=20
@@ -692,7 +703,7 @@ static struct irq_chip mobiveil_msi_irq_chip =3D {
=20
 static struct msi_domain_info mobiveil_msi_domain_info =3D {
 	.flags	=3D (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX),
+		   MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX),
 	.chip	=3D &mobiveil_msi_irq_chip,
 };
=20
@@ -710,7 +721,7 @@ static void mobiveil_compose_msi_msg(struct irq_data *d=
ata, struct msi_msg *msg)
 }
=20
 static int mobiveil_msi_set_affinity(struct irq_data *irq_data,
-		const struct cpumask *mask, bool force)
+				     const struct cpumask *mask, bool force)
 {
 	return -EINVAL;
 }
@@ -722,7 +733,8 @@ static struct irq_chip mobiveil_msi_bottom_irq_chip =3D=
 {
 };
=20
 static int mobiveil_irq_msi_domain_alloc(struct irq_domain *domain,
-		unsigned int virq, unsigned int nr_irqs, void *args)
+					 unsigned int virq,
+					 unsigned int nr_irqs, void *args)
 {
 	struct mobiveil_pcie *pcie =3D domain->host_data;
 	struct mobiveil_msi *msi =3D &pcie->msi;
@@ -742,13 +754,13 @@ static int mobiveil_irq_msi_domain_alloc(struct irq_d=
omain *domain,
 	mutex_unlock(&msi->lock);
=20
 	irq_domain_set_info(domain, virq, bit, &mobiveil_msi_bottom_irq_chip,
-				domain->host_data, handle_level_irq,
-				NULL, NULL);
+			    domain->host_data, handle_level_irq, NULL, NULL);
 	return 0;
 }
=20
 static void mobiveil_irq_msi_domain_free(struct irq_domain *domain,
-		unsigned int virq, unsigned int nr_irqs)
+					 unsigned int virq,
+					 unsigned int nr_irqs)
 {
 	struct irq_data *d =3D irq_domain_get_irq_data(domain, virq);
 	struct mobiveil_pcie *pcie =3D irq_data_get_irq_chip_data(d);
@@ -756,12 +768,11 @@ static void mobiveil_irq_msi_domain_free(struct irq_d=
omain *domain,
=20
 	mutex_lock(&msi->lock);
=20
-	if (!test_bit(d->hwirq, msi->msi_irq_in_use)) {
+	if (!test_bit(d->hwirq, msi->msi_irq_in_use))
 		dev_err(&pcie->pdev->dev, "trying to free unused MSI#%lu\n",
 			d->hwirq);
-	} else {
+	else
 		__clear_bit(d->hwirq, msi->msi_irq_in_use);
-	}
=20
 	mutex_unlock(&msi->lock);
 }
@@ -785,12 +796,14 @@ static int mobiveil_allocate_msi_domains(struct mobiv=
eil_pcie *pcie)
 	}
=20
 	msi->msi_domain =3D pci_msi_create_irq_domain(fwnode,
-				&mobiveil_msi_domain_info, msi->dev_domain);
+						    &mobiveil_msi_domain_info,
+						    msi->dev_domain);
 	if (!msi->msi_domain) {
 		dev_err(dev, "failed to create MSI domain\n");
 		irq_domain_remove(msi->dev_domain);
 		return -ENOMEM;
 	}
+
 	return 0;
 }
=20
@@ -801,8 +814,8 @@ static int mobiveil_pcie_init_irq_domain(struct mobivei=
l_pcie *pcie)
 	int ret;
=20
 	/* setup INTx */
-	pcie->intx_domain =3D irq_domain_add_linear(node,
-				PCI_NUM_INTX, &intx_domain_ops, pcie);
+	pcie->intx_domain =3D irq_domain_add_linear(node, PCI_NUM_INTX,
+						  &intx_domain_ops, pcie);
=20
 	if (!pcie->intx_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
@@ -917,10 +930,10 @@ MODULE_DEVICE_TABLE(of, mobiveil_pcie_of_match);
 static struct platform_driver mobiveil_pcie_driver =3D {
 	.probe =3D mobiveil_pcie_probe,
 	.driver =3D {
-			.name =3D "mobiveil-pcie",
-			.of_match_table =3D mobiveil_pcie_of_match,
-			.suppress_bind_attrs =3D true,
-		},
+		.name =3D "mobiveil-pcie",
+		.of_match_table =3D mobiveil_pcie_of_match,
+		.suppress_bind_attrs =3D true,
+	},
 };
=20
 builtin_platform_driver(mobiveil_pcie_driver);
--=20
2.17.1

