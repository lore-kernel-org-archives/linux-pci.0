Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AF8C43381
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78ED620657
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YtIUtzBY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfCKJba (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:31:30 -0400
Received: from mail-eopbgr80044.outbound.protection.outlook.com ([40.107.8.44]:11104
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727320AbfCKJb2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Mar 2019 05:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ioURpHbldQu1ga2fdu1nut9D4Rk/cA214SnJc+EcAus=;
 b=YtIUtzBYKVs9FV8vMHYwMAP/Sx93EmjQzBepNz1ei40d+dMEdEGNoheBWmwhFN28FpVlVSHCaJHY+MpZ+3IFgU3fMt9XKA80UXZgGMQtTm9lQfdzsBX/lufSIPL5p4m1vi4JM2dPavpo0RMQTiS5UlzXRl8ukfujZ7nrUbB0zsA=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB6566.eurprd04.prod.outlook.com (20.179.246.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.16; Mon, 11 Mar 2019 09:31:23 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7%2]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 09:31:23 +0000
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
Subject: [PATCHv4 11/28] PCI: mobiveil: only fix up the Class Code field
Thread-Topic: [PATCHv4 11/28] PCI: mobiveil: only fix up the Class Code field
Thread-Index: AQHU1+0xoaV/Y9GqOUGCpK8QyE26hg==
Date:   Mon, 11 Mar 2019 09:31:23 +0000
Message-ID: <20190311093130.7209-12-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: ec21b41d-9e08-48d9-6d2a-08d6a60453c5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB6566;
x-ms-traffictypediagnostic: AM6PR04MB6566:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR04MB6566;23:O2ykTF/dLD89ixjTqdMatg+bXuvZRGsSShvEKHQ?=
 =?iso-8859-1?Q?QNohpZAFjZ1i/18pBSrYgnzk2Vp9QNwi5DmrY8xKKXemSbia3lQE38fv1Z?=
 =?iso-8859-1?Q?Ha4ngYc0Df88r7/9Oebj6PpPofdChrVWOH2SKvGLFAyRwLLThgtqofgsd0?=
 =?iso-8859-1?Q?1VpKNOHQAdIMu38mVoGHeBuPULgvVj6Gh904xJ4/TRCDnFsUBSqYR4nLmt?=
 =?iso-8859-1?Q?qHUQV7yD/ePd+fATilGD1OFp5o2OdNP66zCx3oFim0aKnfWy7OVcHcLl4C?=
 =?iso-8859-1?Q?q/LqbcBTO4e/Zy/3rX0VJCBZS0ClYTvJxpIoTyh3wWHLGGbwaORWQWF2JH?=
 =?iso-8859-1?Q?h8fKEd1QkPEe8juFVuLti+MymZM+RrrGuVAnqzfqlDUhssax4CU6an7hEH?=
 =?iso-8859-1?Q?my2xwe12tjukTfElh0GF7kdtzdB74oBgRHMTQKwXV9tsJAIFk1Jqh+q5DM?=
 =?iso-8859-1?Q?ZpA2nldTnHalisI9f+aKdljKmt8o8nZjaO2r1XNJaIMU7TmYuekwYuHz7s?=
 =?iso-8859-1?Q?seOj+b9+okw9+RttHPeetZnM8OGL/XzMOhMcWEIENIVp2rY0O66Vd2tmvd?=
 =?iso-8859-1?Q?HNKm3zvJHjdZCXcFMYyPVfvDqSeeuRlqEjt4NUZ9U6wAzuy/o2f6aJRbVS?=
 =?iso-8859-1?Q?gpBA+UT99UoiA6aAz7Nzo+q7CLFq6XZVOlE33Ifv7CiJOaL8U6umYCxh3h?=
 =?iso-8859-1?Q?vqIiK7To9lEC91QnjcPu8O2odVkCVWuIiXlAISXc5hJeVwF8yzarnqX7ZX?=
 =?iso-8859-1?Q?heeiTotVXxd3gEZICiTuQvs3+RJfE0i1oPa9MS+pMBeuYlMS0HcVs3A1R2?=
 =?iso-8859-1?Q?xngg8db7j6WVeuOYf6Plkjx5LAyPgQihVKhavHYtMO/nPkj4+7H8uhC2sq?=
 =?iso-8859-1?Q?qJy/5iWc65G5wQrMmfPjhSrutD/53wm6O9Fz/tQjN0DGSen7N1ZUJsJ6rY?=
 =?iso-8859-1?Q?p2DyOb8Nfs1PGl1IP4/PSX8rE2cwmEsNbN8IeHC/I7Es0/vtI2xCRDCE74?=
 =?iso-8859-1?Q?AiYtiq/1zFJvQTh8NFU7Id3ORSz0/kPx/LP7QmiyWSr2DHYO0EMJeemeW+?=
 =?iso-8859-1?Q?DGK/5ekY09ErE/H2rcLJarTYznrkJlZIK1soKQJESgkCvvhld1axy8FiGo?=
 =?iso-8859-1?Q?iTGWkBIc1dcPcymnqTk4Mo7he1m/JcAnCYAjALFJQniCccV5btNOY/qSNZ?=
 =?iso-8859-1?Q?D6+ca6gptaQ7nkg3IvCQpf6uLB/ztjMtx58bBChsC/Foa1jC/NzD6En7Jy?=
 =?iso-8859-1?Q?EAbwVMpx6zd6zluL7qBzfcMayYGjp40U2Jmejl0YPJ/ugbbvdRQ7atf4ID?=
 =?iso-8859-1?Q?vWGnaWnRMOD4mxpDxXW9K0VTbaQ21ZMsOZHWPrEDfl9pw=3D=3D?=
x-microsoft-antispam-prvs: <AM6PR04MB6566CF65C7DE9C555E1DB4DB84480@AM6PR04MB6566.eurprd04.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(346002)(376002)(136003)(199004)(189003)(6436002)(478600001)(25786009)(99286004)(11346002)(2616005)(476003)(76176011)(3846002)(6116002)(81166006)(81156014)(486006)(71190400001)(71200400001)(2906002)(8676002)(2201001)(5660300002)(97736004)(6486002)(446003)(7416002)(2501003)(86362001)(256004)(14454004)(316002)(68736007)(26005)(8936002)(6512007)(53936002)(1076003)(66066001)(386003)(54906003)(50226002)(110136005)(102836004)(6506007)(36756003)(105586002)(4326008)(106356001)(186003)(305945005)(52116002)(7736002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6566;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: THh689YRWj/TDFnfuALOViBkWft0f3RUKmA7t7+CQ0P/2x/6rvUcdWvecCvsPbkNqriCjY8Eb711Dc/G8eGg88EYtdObwWtU5eF6b+uUb1ixIWgJcginYTb4yJWIrnOAn5mJyUmfUjoIiT3lZDOyQHDbLdsTkBPGWTMN+whblD5PGRUP4RnhLUOx87RLqa6RPziAaEL0KQlONVydsE6hucImKeEJ+Q5NeRFLX+DVd1TfG2+6VqJecC9LFCdacZoiddiobQX32vYRf8Dy016/LwattEVv2vqeqfgLJ4r+6OjHLxUTuWwawYS1x+deX4yT6PklMLVZL6Cg5wav8q40Z8NUIlNFOjGz2Ih9fsqkM/CiIq0kfWkH7Zip8h64EUuF0W26bnMjk/V/VyUSGGR+HNW6iEf0iJgNQforMnhL8E0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec21b41d-9e08-48d9-6d2a-08d6a60453c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 09:31:23.7883
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

Fix up the Class Code to PCI bridge, do not change the Revision ID.
And move the fixup to mobiveil_host_init function.

Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge
IP driver")
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
---
V4:
 - no change

 drivers/pci/controller/pcie-mobiveil.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controlle=
r/pcie-mobiveil.c
index 78e575e71f4d..8eee1ab7ee24 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -653,6 +653,12 @@ static int mobiveil_host_init(struct mobiveil_pcie *pc=
ie)
 				   type, resource_size(win->res));
 	}
=20
+	/* fixup for PCIe class register */
+	value =3D csr_readl(pcie, PAB_INTP_AXI_PIO_CLASS);
+	value &=3D 0xff;
+	value |=3D (PCI_CLASS_BRIDGE_PCI << 16);
+	csr_writel(pcie, value, PAB_INTP_AXI_PIO_CLASS);
+
 	/* setup MSI hardware registers */
 	mobiveil_pcie_enable_msi(pcie);
=20
@@ -896,9 +902,6 @@ static int mobiveil_pcie_probe(struct platform_device *=
pdev)
 		goto error;
 	}
=20
-	/* fixup for PCIe class register */
-	csr_writel(pcie, 0x060402ab, PAB_INTP_AXI_PIO_CLASS);
-
 	/* initialize the IRQ domains */
 	ret =3D mobiveil_pcie_init_irq_domain(pcie);
 	if (ret) {
--=20
2.17.1

