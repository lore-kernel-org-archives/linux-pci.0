Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C1AC43381
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CA632086A
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rIKJ8GFX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfCKJcT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:32:19 -0400
Received: from mail-eopbgr70071.outbound.protection.outlook.com ([40.107.7.71]:26944
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727124AbfCKJcT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Mar 2019 05:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h98GqNjPia0Xp1b4knoYmw7wXmiPPTfaTDiNOdqSt84=;
 b=rIKJ8GFXovpkVwEAObHqb2a1CRmyTsryhbIgqyoUCJbeqqS8NUsFV+BMyx70o3iaVjh8OFSzSO+skQUaLrUNBv3A+BMr8d17moLqHBh2v041t30Mnx1pw+L7HpvRfGEQzEWinakrdX8F0yr9busSkZ2fScm4PdkcbFuVtGSgGVQ=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB6566.eurprd04.prod.outlook.com (20.179.246.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.16; Mon, 11 Mar 2019 09:31:39 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7%2]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 09:31:39 +0000
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
Subject: [PATCHv4 13/28] PCI: mobiveil: move irq chained handler setup out of
 DT parse
Thread-Topic: [PATCHv4 13/28] PCI: mobiveil: move irq chained handler setup
 out of DT parse
Thread-Index: AQHU1+06/RSu/VKYqEqSsuWhKkfXmg==
Date:   Mon, 11 Mar 2019 09:31:39 +0000
Message-ID: <20190311093130.7209-14-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: 50d783ff-2ff3-4f15-a954-08d6a6045cf6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB6566;
x-ms-traffictypediagnostic: AM6PR04MB6566:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR04MB6566;23:vVC961mp7jwWISXcHyi3VCVMgHJjlVu5Mk0lVvJ?=
 =?iso-8859-1?Q?ZhwZhu1Q9rqf/IE5dGMnQ2OdE/rZQ9q+PVcAOhdOIaT+7C1DXpiLbzGbFJ?=
 =?iso-8859-1?Q?Ol2ENkBVfgIrtOd5jSW58IId09zS4qUhRi3X3P0KU98Z1hA1E03/mOyVKA?=
 =?iso-8859-1?Q?oyGZBapvG2ChU3+mdd64wKg8K3ax+xUEUg3Jq0jJ/0E/frMJjdoBNousuN?=
 =?iso-8859-1?Q?fj0oATGfz5i2uYbTvrgte1yKwT8iV7O26qaO164tiFVZoFCA8BeLDPIUSd?=
 =?iso-8859-1?Q?F29w9/V/1adOeKDAoNw4QXoWACbv2RX5QxllwIOAjsklQOA1IOfPjVBwgw?=
 =?iso-8859-1?Q?E61JGuzQyuBaCYlguZl9aLtcoY/smwYso5ZKerNp2nb2zeriXh5T8rKFvz?=
 =?iso-8859-1?Q?pSM4AOfmXR3cZax1P5J/BBY117Ag1TjbTwJOEh0hel1FYo7yo1XDVXIc3U?=
 =?iso-8859-1?Q?2Wq/HSUdI4tXyHDlcupYwFTuUhd+Tg/FQtFDIl8HANo4F7Fl8Z9vbcAfn0?=
 =?iso-8859-1?Q?J5SmFoRAh++d7YAuFlOWzADZJ+tNm4r5ksgVpXksb8mbNNx290ZPSeQ0Nd?=
 =?iso-8859-1?Q?B6L9S8pFE+PKz+Dev5LM4Ta86XQfsMR1Zrl5yH8i7Xu47tOCpxW9gDiBi8?=
 =?iso-8859-1?Q?jSJ4DBoMLytj7O1g6RAWUxwx4M/JBVF0hRYDCuryPXUeZPDWcAXXqwfGt1?=
 =?iso-8859-1?Q?elAW+uAb5RCWVKvAeqy5u1Y7/Pgh/zWHbDiIiWfNOkwkMgXQ65TCoKGFcE?=
 =?iso-8859-1?Q?sL5W742o2IvaoiUtz75RG5kizuhCVr+EHuHHc8gqOxmnKGantviIlQOtCh?=
 =?iso-8859-1?Q?F8SGfrNM8LbF09vdILIoiQKA0AeMc3Z+Q6KFfgZqWJ+0DYPQ4l7Am0GVpd?=
 =?iso-8859-1?Q?FPPTZdU6XZWcVEVf+6v1lM6tFqrfP/SAHbT9m2mAeNq7Cq3/zeMlD9pOJE?=
 =?iso-8859-1?Q?Mmt29KCU9gnw2pN3kveU7UNnPkp3SZvycSF/ESm7FXEqRZnKCJ1CCl4KZ6?=
 =?iso-8859-1?Q?nyKmAEmO80kod/6A28KzYjzc0MUU/vVZcVLcgLuTVB1q9gImrb6Ad9L3Yr?=
 =?iso-8859-1?Q?HnFduzWJJBOLWkFgO4H6CjGxDURfZCa29GrvpW/xF4KIFUG852C/GGt/go?=
 =?iso-8859-1?Q?p/NjawlYWuabCkPapLgXKfw7O1XWCSR8Qn0FpiIAcSsmOYCrBBXumGkU7N?=
 =?iso-8859-1?Q?jKreccMhZbiZpht89ZR9Vj9pFN/DxlYt7QP2WDmunZv83LtutG5/yJt4+K?=
 =?iso-8859-1?Q?rP9sG0H9Izqwi3LU2w6V0Nle9iqXT/+lOj1RsOxZOl+CEJ8AeuSkkROnB2?=
 =?iso-8859-1?Q?1OlQd69hlYgxX14+W3mdK0yq/m3OKfMa9USd/RqNQ33rLXZnih7VLhH5Jn?=
 =?iso-8859-1?Q?guVNfpx2tuhgKGkxb5KfjO/KXFLxt?=
x-microsoft-antispam-prvs: <AM6PR04MB6566F63629AB8B5F5EEB41CB84480@AM6PR04MB6566.eurprd04.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(346002)(376002)(136003)(199004)(189003)(6436002)(478600001)(25786009)(99286004)(11346002)(2616005)(476003)(76176011)(3846002)(6116002)(81166006)(81156014)(486006)(71190400001)(71200400001)(2906002)(8676002)(2201001)(5660300002)(97736004)(6486002)(446003)(7416002)(4744005)(2501003)(86362001)(14444005)(256004)(14454004)(316002)(68736007)(26005)(8936002)(6512007)(53936002)(1076003)(66066001)(386003)(54906003)(50226002)(110136005)(102836004)(6506007)(36756003)(105586002)(4326008)(106356001)(186003)(305945005)(52116002)(7736002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6566;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Sa2KSAo4d5AZznuPv8V9PwBEdGH3paJinapbshFRL8msw5dwsk3VKQSuzKb5g2qF2k/TKMmJa8eR5Fcg0Y+vTKro9u0fgumdz6eUHGsTVomU6ec4aCpGVOkfq+tASECdmLNAN0nz6Ufi4w1lOSKCkyW6jiQ85XZlDduoj8ZUKulA9BxYKjO8QssL4ae4oEfAfbyl5voU6s+v2Bdnz7ED3lBRYgGCLM/XLwWyRfTSRoiHw68vxa2yAlzc4pm+ihM1OYCItd5owdmugTEVpBXRtUXJiT6HRgMNrqxISVkGyvVWywBdgrERMLrr5hZQznD8+qXha4ZAylL+PMxf3Gj2QLCTiKsR1H0jt8yGuAqjYmK2+YtmZfifH+HGXG3wiH0u+RZOPSWhX1dmZRRh6/OscXE9pqCqYLlbqsgJDuCb8l0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d783ff-2ff3-4f15-a954-08d6a6045cf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 09:31:39.3846
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

Move irq_set_chained_handler_and_data() out of DT parse function.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
---
V4:
 - no change

 drivers/pci/controller/pcie-mobiveil.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controlle=
r/pcie-mobiveil.c
index c2848c22b466..db7ecb021c63 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -460,8 +460,6 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie =
*pcie)
 		return -ENODEV;
 	}
=20
-	irq_set_chained_handler_and_data(pcie->irq, mobiveil_pcie_isr, pcie);
-
 	return 0;
 }
=20
@@ -902,6 +900,8 @@ static int mobiveil_pcie_probe(struct platform_device *=
pdev)
 		goto error;
 	}
=20
+	irq_set_chained_handler_and_data(pcie->irq, mobiveil_pcie_isr, pcie);
+
 	ret =3D devm_request_pci_bus_resources(dev, &pcie->resources);
 	if (ret)
 		goto error;
--=20
2.17.1

