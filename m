Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713A1C43381
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37AAD20657
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UCYfdr0p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfCKJdy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:33:54 -0400
Received: from mail-eopbgr20074.outbound.protection.outlook.com ([40.107.2.74]:40239
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727091AbfCKJdx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Mar 2019 05:33:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzsl5id2rqcEfxnP4104xXTqJNWv/ApEvJWcFG3HxCg=;
 b=UCYfdr0p2V+ytMgfHe0pJpmlYBPEh9BOHFOhrNH2fec69P7C2U3l0n0f9kZuN3DzBNHbE9uwlsvOIalVzhWTREtC/OZT2sXE4dUkrOKigXKRNdlx/AQv/Z4rwCm8RP/JgHKYQmJOLMraxKh6rHBnHDWWDLJ21Z+QqIwD5CT/iN8=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB6150.eurprd04.prod.outlook.com (20.179.6.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Mon, 11 Mar 2019 09:33:49 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7%2]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 09:33:48 +0000
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
Subject: [PATCHv4 28/28] arm64: defconfig: Enable CONFIG_PCI_LAYERSCAPE_GEN4
Thread-Topic: [PATCHv4 28/28] arm64: defconfig: Enable
 CONFIG_PCI_LAYERSCAPE_GEN4
Thread-Index: AQHU1+2HcERJ2aEe3kK7WSp8MTRCMA==
Date:   Mon, 11 Mar 2019 09:33:48 +0000
Message-ID: <20190311093130.7209-29-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: 2b40309c-861a-42e0-4c43-08d6a604aa0d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB6150;
x-ms-traffictypediagnostic: AM6PR04MB6150:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR04MB6150;23:Vzw2uYodh1uP8mWNXii7jj2m+XFIYGACgmnpPYB?=
 =?iso-8859-1?Q?wzsd3w7osu1kMpc7dcVEmAURCyreb5ItEyt++S1C7PftNuF+V4uJd5oMTU?=
 =?iso-8859-1?Q?hFZo2JrhXKbFMemRI+XUSIVvmOwiNDTxWV5TEBKZEpoENbtXfmXM1zek3w?=
 =?iso-8859-1?Q?VL+w6TfA5BrU+YQRtPOWD3tjAcr2FNYj0DBCR5dWKfOhaDd9t+lxSvOJFw?=
 =?iso-8859-1?Q?3slsNqP+5gf2oObSeJDrZVx0tBsSZNh2SBav7bmO3CG/omtPtfBHDShGQ8?=
 =?iso-8859-1?Q?/yDBJx85nB3bAIFacVLI/gTnNTzZPIab7Hmps18oqV1dN2+7W3D5fPBF5D?=
 =?iso-8859-1?Q?YTpolYXJ84UBoNDhNaxX5WZPC0wVuutXnrpyJbNDWXbFgPA0ZEppYe31Xq?=
 =?iso-8859-1?Q?/M2zeQzO4aPdKWqCRThAkWuX5zPJKH/KKcAGE8KB47/BoL4h8lA4dVukpr?=
 =?iso-8859-1?Q?eAyK0WdFGJuwOtuU6Uht2G6ANdFCzdFB7kTzlQJXewElWiJ4KZBihaZF6F?=
 =?iso-8859-1?Q?b4lQHxEsKzeK7FYQQgAtzMGTeeryXeu1QZno+RjdNjXyjlhlM5N8D+ishF?=
 =?iso-8859-1?Q?GMsgESnzm4ZrG443BiBPZaiL5cMy7anrDuMLHoeU1LApUaAPux7E+lk68W?=
 =?iso-8859-1?Q?UXit6CKm65AHwWEqs4SkdANV3JpINuMSwpwvEqwpwDTpXEHKLpZtW2Ih8C?=
 =?iso-8859-1?Q?MBl6f4crA4OmUkn2zz8NX7obE0aD9/GNaARKWAfzgT6pwu7VbIP2dhKVq4?=
 =?iso-8859-1?Q?9+q7h5rSfpTT/4LLGYEe/8mXBhkWacAHGZ2XF3V9MEm6/cz4JGyUEnrBoF?=
 =?iso-8859-1?Q?Wd+88ZJHKvVB7D9wwsQcsnBbI5WlDEhCc6dYKlTmo38YCgjtc9dqT2/WDl?=
 =?iso-8859-1?Q?T9i6wCgD4JPMay0Lxe5iaxh3DXmXDFAShWu1DExqwh+EjuFyNSM1xVu/NX?=
 =?iso-8859-1?Q?3RZFH2B9ly6TSXgFru0Xbmhy1FdaULwqoSe6ly7Ei4f7i4sUyfvI+UpglA?=
 =?iso-8859-1?Q?XmT860Ec20WvqlP3iRbc69IdxzQaJ/pKdP9Zx70+4wn3ReG/R8AgLm67yv?=
 =?iso-8859-1?Q?daaCZ8UDzz4pGnPvxtasjvRXQvnccM0Owt9L00SKBgyNkfQiWW4KtL23ir?=
 =?iso-8859-1?Q?il+tvo1+DqKZBqP3zTK5K+cy73U2BTGdO841v0VJNbMRLGuWkZdXTZVG+w?=
 =?iso-8859-1?Q?SvnI5+gEI8Md/Ys8V9eCoKbO2DZyuA4dxA8yS9Le8EoEehCcPvSX8uEdFP?=
 =?iso-8859-1?Q?yktp4+bCqWRW2PDGztwnENLZSZgweKWXAuZYqRf3Xpy1bmgGnlUKOJtnZp?=
 =?iso-8859-1?Q?XYagoctFHiM71muOdnFkhUcGSxqbxILIC/sXuK7grtHZXGxhvNRlkS4aFe?=
 =?iso-8859-1?Q?03zjU7ws=3D?=
x-microsoft-antispam-prvs: <AM6PR04MB6150E658A37E2EA6C406320284480@AM6PR04MB6150.eurprd04.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(346002)(396003)(366004)(199004)(189003)(86362001)(54906003)(110136005)(6506007)(386003)(52116002)(99286004)(102836004)(316002)(4326008)(2201001)(50226002)(2501003)(97736004)(2906002)(66066001)(186003)(26005)(5660300002)(11346002)(76176011)(446003)(6486002)(36756003)(6436002)(25786009)(81166006)(81156014)(8676002)(478600001)(476003)(4744005)(1076003)(7416002)(105586002)(305945005)(2616005)(71190400001)(71200400001)(3846002)(68736007)(6512007)(6116002)(8936002)(53936002)(7736002)(486006)(14454004)(256004)(106356001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6150;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Shq1jW+LHY/rKn2ooU4pTffJn/j+Q2uWgUoHKItT+lDyIL7btS5t7KdRfUz2V1gpVKIwux5omaUlz4Pu79D22qEGciDFlk2EQ4IuVebFQrx4dP9yl7yrt0DeZ0Cvdlsxaf4Hya8CTHOy4p/Kb28I1LVUoRGweLSSyJPRFa4XU4YaNm6YEj1dPVsKZh5Hl3o4RtXnQu2al95y17aMUEK9kvBeizikVydboLhlQxiekz9Iz7WT5STIVzr7/Bo2hnMyilNeNdBMlyQtVb9c0WMR25Z9lSZNc8lE2FUX3emHbGxyYs0y26/zcxmJs+0IeRzwAEHr1CtANK+vyADgV5Qny/u5lEI3QwUJe/0jI5s37c4jyDlKvdJqcQMyWZtrq9aUJkPfCI+LZ/oMp+G9QoELlc3uUqPe0N1Wnny26xqOcT0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b40309c-861a-42e0-4c43-08d6a604aa0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 09:33:48.9346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6150
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Enable the PCIe Gen4 controller driver for Layerscape SoCs.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
---
V4:
 - no change

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2d9c39033c1a..e294978aad5d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -82,6 +82,7 @@ CONFIG_PCI_HOST_THUNDER_PEM=3Dy
 CONFIG_PCI_HOST_THUNDER_ECAM=3Dy
 CONFIG_PCIE_ROCKCHIP_HOST=3Dm
 CONFIG_PCI_LAYERSCAPE=3Dy
+CONFIG_PCI_LAYERSCAPE_GEN4=3Dy
 CONFIG_PCI_HISI=3Dy
 CONFIG_PCIE_QCOM=3Dy
 CONFIG_PCIE_ARMADA_8K=3Dy
--=20
2.17.1

