Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC54C43381
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A6A2084D
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lAThMnGZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfCKJbX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:31:23 -0400
Received: from mail-eopbgr130051.outbound.protection.outlook.com ([40.107.13.51]:7691
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727233AbfCKJbV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Mar 2019 05:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xv4ENgxk7YVVshpRVP6XCpicqcTCUNEYDTGrxfW4F30=;
 b=lAThMnGZvXFutN43AowTqE1k2u1kvtSZ0rDbID6jbrlgAR06LkPw/SBzt2i0V3NY2VYrokMD+G9yT0St5+5lmdR1Jrdck8l/8A+7Pq33pgR4rMUWHPmqEY99o+ULgjoskdlVYOcE2JcoPv9QXXtXpw/jmD649XZw5vmEZwXlnnU=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5592.eurprd04.prod.outlook.com (20.178.87.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Mon, 11 Mar 2019 09:31:16 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7%2]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 09:31:16 +0000
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
Subject: [PATCHv4 10/28] PCI: mobiveil: fix the INTx process error
Thread-Topic: [PATCHv4 10/28] PCI: mobiveil: fix the INTx process error
Thread-Index: AQHU1+0si14PzdOFlUat22euDKg75Q==
Date:   Mon, 11 Mar 2019 09:31:16 +0000
Message-ID: <20190311093130.7209-11-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: 61f90912-1997-48d7-0fdd-08d6a6044f34
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5592;
x-ms-traffictypediagnostic: AM6PR04MB5592:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR04MB5592;23:Z7wOhZmKXkJ6x9yTnQvV7LuFc0CdJf/m5u5FYcX?=
 =?iso-8859-1?Q?0RTKYQolbkFGsYKrbgDAszk/SjLlUWv8NN3XbP9NH/Y4NWpvWdaGgawvWU?=
 =?iso-8859-1?Q?F1w/p1nMnTgLj94H1XunTzgTz7/QtUSr01K8S5ctpAaQhNlWqRS85zuNYL?=
 =?iso-8859-1?Q?w/APn7ZLDG+NyEDIA+51/1Kkrj0UD7gzgxh1VTdZhEdKlXEvyXf4rExynu?=
 =?iso-8859-1?Q?fewCKSe/yepDoTsjurWd9nmJz9GxyaI3yf04Q7uGPVMKBIzws292hIwVSr?=
 =?iso-8859-1?Q?JHWqJ58VkFTo1eaUaF4x6EmHzLn8pcXrPyMVM1j2jrkF4o6xEF/YAihKBw?=
 =?iso-8859-1?Q?u1uIcl4O6qcAsmZkkOlmhGZzh7H0yO+xpW/bw81EiKWc7kL24ZsmmwPF/y?=
 =?iso-8859-1?Q?wRja3kzosP8xy7NilGBwQTADbVZoSW3AICDRgzSOe0ELpg1sywBfkd5F9d?=
 =?iso-8859-1?Q?Tft2thhoWUKidfJeWeF6zJq9yKzaAPDT5nPcEC6JkYA87Zuxhk/SDa/Yqv?=
 =?iso-8859-1?Q?BL759R7W0QF/0G9zmxtvyjeCAAdfFg6lrq46hmT1p5pA+OiaW4R9w9PcPS?=
 =?iso-8859-1?Q?8MrkIogO3fLQzkGEJkzjWpU2HSsFX6d5Mvglyi2A2bzee8Tf8LJrh7Nitb?=
 =?iso-8859-1?Q?SeFmcaYf9wayBx4U6/f5NIiBNLZ/ZraH7SxMmzskDRlGiP5di0F/88aHQ3?=
 =?iso-8859-1?Q?sSzZTzhfWcksMQDcL63uuDL8UbkJqp0oKUUm4eNPApM0gPVP2ntKQQqfxB?=
 =?iso-8859-1?Q?u/YAG18ZkFs4OnN5ZIbnzVY3ugM8whNRhRG6n+IzlwgLBZLt+ybhkir1Bv?=
 =?iso-8859-1?Q?r8fst9QpZVWZrGSwNmoDQ6pLC61HmaFckvXI+c4JH2vozR1Eh0Z8tNY4PR?=
 =?iso-8859-1?Q?VHzN6Mjzx+n+ICB++4aePMvrt0lTAgjT/B+39HaeKtO+2TLdfTGR4tz7LN?=
 =?iso-8859-1?Q?RSyVvRjw0bQ6jTLeGYpSKw/uJwLMGUTpMLVjmlTQFtyTIJtsAIaR1c4JEe?=
 =?iso-8859-1?Q?GejJJcT8p35CNgTiaicql7HvY3+RHRqoxwbroQq0lXAaqRPXJT4aq/w5ve?=
 =?iso-8859-1?Q?tmAWqoyF/SpigeE39DnCxp9UbUjfnwhaLQZiRhuYn+D9E35XvH6ElCOpOF?=
 =?iso-8859-1?Q?CkAs9v0P4DNptyryte0M+/Gv9DK37n6gm0Uooz/bv3dhfG4mFEQ7WopWOA?=
 =?iso-8859-1?Q?HszKS7lWsEozKy0oYKmmeYuzLBh74CdrbjGu6v6x12m0qMg//XDWmoes7/?=
 =?iso-8859-1?Q?hLqNhk/MOBcnE8hVrs5VgX9Tvjx0Gp8RAASQVwMZ+9IGYYf9DwoE3ObVB/?=
 =?iso-8859-1?Q?PRLxmMXPgjwrwmLkNcivWFxShYx8B/lJe9sFAj6inVjf7jWCGcnDiOjyvF?=
 =?iso-8859-1?Q?lzNsD5Ro=3D?=
x-microsoft-antispam-prvs: <AM6PR04MB5592EDDBAEDF8470C05538FF84480@AM6PR04MB5592.eurprd04.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(376002)(136003)(39860400002)(199004)(189003)(5660300002)(4326008)(2201001)(8676002)(478600001)(81166006)(81156014)(14454004)(86362001)(8936002)(50226002)(7416002)(256004)(1076003)(71200400001)(71190400001)(2616005)(476003)(486006)(11346002)(446003)(186003)(305945005)(7736002)(97736004)(68736007)(66066001)(36756003)(6486002)(105586002)(106356001)(6436002)(6512007)(110136005)(76176011)(54906003)(52116002)(99286004)(26005)(386003)(6506007)(3846002)(316002)(6116002)(102836004)(6346003)(25786009)(53936002)(2906002)(2501003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5592;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BVggsVBP610u5rsiv3Gn9LIMMJ8rI6szoUKmaG8UF+5pAAb3QkS5hfko2VKpGH62QzOpJNVWcB+Jvp/NJsZroi/91pNJadLK5f4Kpj8FfWbXWUQ6zzTcbilZJKQEe0KCorrxef2aryCm8Zk8U94xKRmqLglhHh5wTJlUB+Y6qgVlyk0/61wMh45rXDL764VsUuPxmwU9vkGBmewDPEHElVcUACtLG9Wx43YS2Qf9E7pur0lihrZiGXu+eG9pHL50+FHXgMDT3R+VzfgIElLpRoTIQOzdAN7p4XGrLC1WRvVydZ7t4uesYXlZTEb2TPJ3aqxcppoX+UvFm3uVX4CyqGrreDSeqkrjweJDY2a8Y4ZR0ScE4sl0T5GW/tmI8HmORJAJydg0NB6p7KGYr0sF7ryAGw1tiH+grJ4dnmORP0k=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f90912-1997-48d7-0fdd-08d6a6044f34
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 09:31:16.1307
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

In the loop block, there is not code change the loop key,
this patch updated the loop key by re-read the INTx status
register.

This patch also change to clear the handled INTx status.

Note: Need MV to test this fix.

Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host
Bridge IP driver")
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
---
V4:
 - no change

 drivers/pci/controller/pcie-mobiveil.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controlle=
r/pcie-mobiveil.c
index 4ba458474e42..78e575e71f4d 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -361,6 +361,7 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
 	/* Handle INTx */
 	if (intr_status & PAB_INTP_INTX_MASK) {
 		shifted_status =3D csr_readl(pcie, PAB_INTP_AMBA_MISC_STAT);
+		shifted_status &=3D PAB_INTP_INTX_MASK;
 		shifted_status >>=3D PAB_INTX_START;
 		do {
 			for_each_set_bit(bit, &shifted_status, PCI_NUM_INTX) {
@@ -372,12 +373,16 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
 					dev_err_ratelimited(dev, "unexpected IRQ, INT%d\n",
 							    bit);
=20
-				/* clear interrupt */
-				csr_writel(pcie,
-					   shifted_status << PAB_INTX_START,
+				/* clear interrupt handled */
+				csr_writel(pcie, 1 << (PAB_INTX_START + bit),
 					   PAB_INTP_AMBA_MISC_STAT);
 			}
-		} while ((shifted_status >> PAB_INTX_START) !=3D 0);
+
+			shifted_status =3D csr_readl(pcie,
+						   PAB_INTP_AMBA_MISC_STAT);
+			shifted_status &=3D PAB_INTP_INTX_MASK;
+			shifted_status >>=3D PAB_INTX_START;
+		} while (shifted_status !=3D 0);
 	}
=20
 	/* read extra MSI status register */
--=20
2.17.1

