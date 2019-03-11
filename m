Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCE8C43381
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7019920857
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jcp/n/Ez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfCKJaZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:30:25 -0400
Received: from mail-eopbgr70072.outbound.protection.outlook.com ([40.107.7.72]:19328
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727195AbfCKJaY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Mar 2019 05:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNCN4livbs1wo+1uLQfsBQB2e+/P+52q+z6t6VPGPtc=;
 b=Jcp/n/EzRaghXYfrZLxVTTvgiVbi/sT64BNNDLoaJo6tUViuoweyoc5I/dC+4aR+EwoOhxQvhjZVeAzkc5V6wVXcHl5mb2gQoiEtYqDQ9CPc3S0E/po8veV0rig+DHESoQ5J59cATwbYXKp1YLdh+n1HH0DUoQXNG4qC2vZrZfs=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5592.eurprd04.prod.outlook.com (20.178.87.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Mon, 11 Mar 2019 09:30:20 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7%2]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 09:30:20 +0000
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
Subject: [PATCHv4 03/28] PCI: mobiveil: correct the returned error number
Thread-Topic: [PATCHv4 03/28] PCI: mobiveil: correct the returned error number
Thread-Index: AQHU1+0LmAHw3KdU9kO+wVi9R8LChg==
Date:   Mon, 11 Mar 2019 09:30:20 +0000
Message-ID: <20190311093130.7209-4-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: 35201a16-ed14-4bb7-99df-08d6a6042dd2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5592;
x-ms-traffictypediagnostic: AM6PR04MB5592:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR04MB5592;23:ypj/CEkDDPDp/Yw8d2s72DM8FNHrvNO2X1uH+yH?=
 =?iso-8859-1?Q?xweAf+QATyV8xIi+TGdCu5qn+Q8Cn53w6mLalXhWGMu9CkitAa0cAQCTtW?=
 =?iso-8859-1?Q?bsjViO9pHuMT5Fl5xykCvn3Pg6uC07qxLyKWFm3zMi3rYLC8cSfH/5aQCF?=
 =?iso-8859-1?Q?xx+EgcWpBMJDeu4kbeafe8rGl6lgJYKatdEjs9/CFBiieS4M+YJdeIkhlC?=
 =?iso-8859-1?Q?t16Bn+aPLpHd/wAUQ6Uj6pRtxzSpWzhygKIBrnoAr6brlQnfDZRb7EpCzR?=
 =?iso-8859-1?Q?RJrjYSYTvY7cHfJFDekZ+YBhGQOgLDX+hShqJfhbSI8BSAsK+PurEFur87?=
 =?iso-8859-1?Q?JkrRHKLWOjCHm6yWdZXVo+/BOxaCNwhDjpMPCjfcqIKwVzgzZ/0AE5+yNq?=
 =?iso-8859-1?Q?N3BJPd6vmxAvkcnC7sFGSg6yLbcu4KrEk/UWRlPp6/bQoptUAobYDdBP9N?=
 =?iso-8859-1?Q?N7s3iIdhix/flsRc5eFDrScjEtsD1styWBrF5EoJqTeF4P1UGD0XXucRWW?=
 =?iso-8859-1?Q?oR5UH2B7LUBEx2C0BjwZ0OO6JdA6+9muUCpRcCRFYNWqu9fiGvu8fd5Mz6?=
 =?iso-8859-1?Q?TEk1McK0ShRzjWDwyT0PxGGNIcRfoXmv/i+VsP/kvpCSIjjckC4e0gQPO+?=
 =?iso-8859-1?Q?d13VR2W6z84Ypwr75Vl2fiyFp9+syYvq+iO00+574fXSkwTeIQRPvKcUnw?=
 =?iso-8859-1?Q?eok/yP908O3bGTgYvHGspz9bO8JYgYD66Pw90afv/y3YiuhZgT8wBbtf7B?=
 =?iso-8859-1?Q?+9yKtnoPYjUejOmPQyGscDPmmgFOAJmbmYkFjYF77J+cQkGyabDnavvLXc?=
 =?iso-8859-1?Q?bznImEq21ebN8g+6d+9jSjZjm5tqxU7bdLwfscm0q+hcVndn8PnMb8EzFo?=
 =?iso-8859-1?Q?tcfgguNKscnmPGRKP+7HkJKFYHhwgiPizbDRwaMBIkRKeXtIUdkEE0xDBH?=
 =?iso-8859-1?Q?4XFA2kE7iDddxrcKbu0YMpu3x3729s7BURE3tri7wql/ZFuVholQx03stV?=
 =?iso-8859-1?Q?VunjTrEouuLLLiiF+K9EdTsj8LGLVvobLjNzf5AsToCJb7lvgKH1S4x/WS?=
 =?iso-8859-1?Q?tYQx9oobkNjcDgdDa2SbtIy8BT9evL1QXQPb8qw61MFEJ5E/MfuA3BW+J7?=
 =?iso-8859-1?Q?bBRqoyB4RBiiotS/IkCudCD6nAk3oXdLGX4Z6E8rKI+NoUDy9Cx3ohpact?=
 =?iso-8859-1?Q?bQASSpMeJdhxcZsWjlgsHut7Moj2Ap+sVLupcBwOChNBJM192JUv1eajml?=
 =?iso-8859-1?Q?m9MuenkgzRT0YlCTdU1RglzqUmZETy3LjGufm3KoqoGC+AdTPZF2fSBbrv?=
 =?iso-8859-1?Q?ichEMeKZY5k8OlSwXVgBpX6qutKQcjuT3vCv6lnm3HNJzjJJWfofXvQ4Y0?=
 =?iso-8859-1?Q?bQJmj+lIZaeGAKDZOBM2U/sAp7LC5?=
x-microsoft-antispam-prvs: <AM6PR04MB559222DFE3C3961998A16D4984480@AM6PR04MB5592.eurprd04.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(376002)(136003)(39860400002)(199004)(189003)(5660300002)(4326008)(2201001)(8676002)(478600001)(81166006)(81156014)(14454004)(86362001)(8936002)(50226002)(7416002)(14444005)(256004)(1076003)(71200400001)(71190400001)(2616005)(476003)(486006)(11346002)(446003)(186003)(305945005)(7736002)(97736004)(68736007)(66066001)(36756003)(6486002)(105586002)(106356001)(6436002)(6512007)(110136005)(76176011)(54906003)(52116002)(99286004)(26005)(386003)(6506007)(3846002)(316002)(6116002)(102836004)(6346003)(25786009)(53936002)(2906002)(2501003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5592;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0Ixj8ln1ybbHp9zth2qAdTJ9Xd8HjnET8gIgiabTl26yhqW7gCJsT2vqXq1SmCGHLhKqNiO49pz8SbkmIzHxD0WaiHOOfYpnIFoMQCEwiWoNxdx83zIzNM1/wIhWquGp3qYuwOi5Py6EBFT5icbUvnRL9wM0/ns86TCJqlcibTwZxzfiEp4n4QcgwCkJ56rLkaMbkdqXR8xeC2U54zMzHRDMv6qzMf3t6ePYLl7WXWDBhGqey5iBSKfpG+FfCYpUWmbmUSP/kjKaR7rymPiZW5myHiyJSuUSBjozHyKwXznWhnbA0MEhkqO8pzOTCmQo8E7rFJUlN4kstF/pNNKAzdy0IOFDT/d9jFTqZ2U9+mgFRrX/N/pgx5rQ/OqapIB+blKXJ2Of5iKQ7K9iDQpxcWi8AzGwqAMV4+z9LsQq82Q=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35201a16-ed14-4bb7-99df-08d6a6042dd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 09:30:20.1332
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

This patch corrected the returned error number by convention,
and removed a unnecessary error check.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
---
V4:
 - no change

 drivers/pci/controller/pcie-mobiveil.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controlle=
r/pcie-mobiveil.c
index b87471f08a40..563210e731d3 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -819,7 +819,7 @@ static int mobiveil_pcie_init_irq_domain(struct mobivei=
l_pcie *pcie)
=20
 	if (!pcie->intx_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
-		return -ENODEV;
+		return -ENOMEM;
 	}
=20
 	raw_spin_lock_init(&pcie->intx_mask_lock);
@@ -845,11 +845,9 @@ static int mobiveil_pcie_probe(struct platform_device =
*pdev)
 	/* allocate the PCIe port */
 	bridge =3D devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
 	if (!bridge)
-		return -ENODEV;
+		return -ENOMEM;
=20
 	pcie =3D pci_host_bridge_priv(bridge);
-	if (!pcie)
-		return -ENOMEM;
=20
 	pcie->pdev =3D pdev;
=20
@@ -866,7 +864,7 @@ static int mobiveil_pcie_probe(struct platform_device *=
pdev)
 						    &pcie->resources, &iobase);
 	if (ret) {
 		dev_err(dev, "Getting bridge resources failed\n");
-		return -ENOMEM;
+		return ret;
 	}
=20
 	/*
--=20
2.17.1

