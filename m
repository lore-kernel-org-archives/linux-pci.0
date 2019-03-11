Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC57FC43381
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14F72084D
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="q1wv3SQW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfCKJab (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:30:31 -0400
Received: from mail-eopbgr70077.outbound.protection.outlook.com ([40.107.7.77]:10560
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727195AbfCKJab (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Mar 2019 05:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11vMYtPjZFN2gkhgcCGW4FDZdYGpU4nuJcyKk/dfgqg=;
 b=q1wv3SQWyGTs0Cu/9SqbnizLDJaG8vRp6A5iCkQ16cZJ6Q8IUROkXNuLlpUBSwTgjhxYAnyHz7AtlJrk9Kjq9W1dywohXe7p4VqLRdFN0p7RTrUmThtpvoYtMY4bjXCXRWtKUaXEIihb1+bwR8LlfqcvnY+XGB3jv/OsnNn3/34=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5592.eurprd04.prod.outlook.com (20.178.87.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Mon, 11 Mar 2019 09:30:27 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7%2]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 09:30:27 +0000
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
Subject: [PATCHv4 04/28] PCI: mobiveil: remove flag MSI_FLAG_MULTI_PCI_MSI
Thread-Topic: [PATCHv4 04/28] PCI: mobiveil: remove flag
 MSI_FLAG_MULTI_PCI_MSI
Thread-Index: AQHU1+0Ppa3nAagG1EaLvH5ZY14VkQ==
Date:   Mon, 11 Mar 2019 09:30:27 +0000
Message-ID: <20190311093130.7209-5-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: 2ae83433-1db3-4f39-67fa-08d6a6043200
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5592;
x-ms-traffictypediagnostic: AM6PR04MB5592:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR04MB5592;23:b3TRoWyNDX4nhctorJUa2XLNqzOWYY9sRjxS1W/?=
 =?iso-8859-1?Q?O20Qz7zOJXzh1lomzK3TtrPhcLpwDHyDcPBmIYmEK9LmsnGj85OlZUkg2d?=
 =?iso-8859-1?Q?kyOjucMtZmB9kc7LfkgGRWSg8n8kFlp2lXfvEFjLQGEdS/wRPjlNVGIcXC?=
 =?iso-8859-1?Q?qCH3ng1n13Bu7XkluDdgjgJEZfbUkaSOPbTX8NxRPPNegQmOyfpYbvtH4B?=
 =?iso-8859-1?Q?nkLdd+6KbTPxsZGL4Wkqe5GIlcAli+hDac2V1D6bRdcFYVY0mmat4znVXM?=
 =?iso-8859-1?Q?+0hnJcUIL1Nb54bdj+LH5BQKqi6qCGix9eezyU04jEDvtwtABbMmDIPLp1?=
 =?iso-8859-1?Q?8y0VEmPPBtNcvCj6+qD3Md/DLO/4jXRQDbyr0moLTNPganmBDXYSOX3uzS?=
 =?iso-8859-1?Q?DtELCGQB9GLwVXTFAFWPKTwFbxU9f+FzpzqzLE8rczWW0PRT9NZKQUZz1b?=
 =?iso-8859-1?Q?Z/6A7DNpMwqFRbbAqe+G/q8Ydk/0ZZOddRDPzNIc2ELdhB6MAdTfEQa/9E?=
 =?iso-8859-1?Q?ybzoSlQy1lxkz9lGbK/Vz21BR2sytVmMsocEGW3LngtljbUQKhuimH5Vw/?=
 =?iso-8859-1?Q?uBmBbptaSYjbiy+o3yX2Cu1xsz7UMks+R77iBgeqxfdYa0ypLbwOhYruYS?=
 =?iso-8859-1?Q?QkNsbdASO8EHDFotVW18tFZEDdWaesc8/rUs5H7OPTp32ozx4tfRM2dWNb?=
 =?iso-8859-1?Q?/ot8zl0CVl+nc5bsyb61LIqwJxgEyFPqBuT633ESycr3byIK9ypf47iQlO?=
 =?iso-8859-1?Q?WWAyHs1PSoolJuJIhYpZ4kaIUpTb1gx/DqN8QMeiajFe2Glwc8p9W7Nc1F?=
 =?iso-8859-1?Q?d1MesLRCYmkOe2R8wpQLTQwc7o2uZleccO9OtyLCo/JmEbArV3cFniCr4c?=
 =?iso-8859-1?Q?ZpKD3vfuI3/E+OL7tinvUHIcPm6MWuA6d0/f3QOUmtQBUKIQgQIzMR5mJI?=
 =?iso-8859-1?Q?ugn70l+v8obe8kJ3vC7UlKfNqVoWdSS9mlC57uXLrgFJwWXC2e20LnYhz8?=
 =?iso-8859-1?Q?8wy2j9xeM4DOsGRtYxoTC5zAHotlZF+DcsE5BP4zmNy2sWlQig3xb6Js3Y?=
 =?iso-8859-1?Q?nS2wnWX2b5o3bjmFi+OJLlBwU5mVpzNJDd6EIkaqieFAD68S2vr5lGIM++?=
 =?iso-8859-1?Q?TsLdLdE+xAy+Gmm8/Oc3cub1lfzmcfh0iolUBxd9+A3tQKta4nw7SxWQL4?=
 =?iso-8859-1?Q?RTVlWo6lt71H0ImJEDictkdixw9zM5b8Zipz8UM0fIJ/6sEVhP/pZK3cnF?=
 =?iso-8859-1?Q?vOvI3RBveLpPXurVsmmGrPxuud62jdB0VskQ1yyivyLBVABVTF1ICritNe?=
 =?iso-8859-1?Q?aTpg0U+Iw9A9ygl3WM+i+BTIyfG7Tt7xzzidj1RyA0+B8qfIQ7askUL+Us?=
 =?iso-8859-1?Q?owZEpl1L83TKOwhueHfAhX+r+3TnEwbvIUaViQE2NTJicJBFf8w=3D=3D?=
x-microsoft-antispam-prvs: <AM6PR04MB5592D42E903BAF0D48B2911A84480@AM6PR04MB5592.eurprd04.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(376002)(136003)(39860400002)(199004)(189003)(4744005)(5660300002)(4326008)(2201001)(8676002)(478600001)(81166006)(81156014)(14454004)(86362001)(8936002)(50226002)(7416002)(14444005)(256004)(1076003)(71200400001)(71190400001)(2616005)(476003)(486006)(11346002)(446003)(186003)(305945005)(7736002)(97736004)(68736007)(66066001)(36756003)(6486002)(105586002)(106356001)(6436002)(6512007)(110136005)(76176011)(54906003)(52116002)(99286004)(26005)(386003)(6506007)(3846002)(316002)(6116002)(102836004)(6346003)(25786009)(53936002)(2906002)(2501003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5592;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: F/FykdM32qe8JtnBXEKHuNH94BDvb9RxlqQ9/yR6WIZhFZN7637mlcsghnROks0ouram8oZ+l11dBivcQMEwcIELg/1xRWt6m6/ZhgUvfq1GvTA/8Rhq1roLMqFSTgNOsEdpkIETtCEX1ZAVuvM4PhiV3RkRJSWbw3rwqhs1auZHsLjqhk7Y7mLnjAlOyF0nSulqdYDfjHg4S4/KiNtxpyrqSHbrTZKtRRdIezqrxJNo6q7+opw2TsyPKsze/kDSyJ/an07oVRv5doCMS3tuYZ59hMLaY10OI/WRUriUyMZNNUKIdZuO/l8YcXBr52wUc+w0jadPX2vAI/ujG1rC/XtAHgE9N/S3tsJ1q+QCvbi3G9W3y7GduHQCE9X/Za73rBgFtcoBMS2Stnh3J/3+0y3xIHbaEt6cwr6ZKmO1JOQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae83433-1db3-4f39-67fa-08d6a6043200
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 09:30:27.3354
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

The current code does not support multiple MSIs, so remove
the corresponding flag from the msi_domain_info structure.

Fixes: 1e913e58335f ("PCI: mobiveil: Add MSI support")
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
---
V4:
 - no change

 drivers/pci/controller/pcie-mobiveil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controlle=
r/pcie-mobiveil.c
index 563210e731d3..a0dd337c6214 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -703,7 +703,7 @@ static struct irq_chip mobiveil_msi_irq_chip =3D {
=20
 static struct msi_domain_info mobiveil_msi_domain_info =3D {
 	.flags	=3D (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		   MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX),
+		   MSI_FLAG_PCI_MSIX),
 	.chip	=3D &mobiveil_msi_irq_chip,
 };
=20
--=20
2.17.1

