Return-Path: <SRS0=18Ni=NF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2906ECDE46
	for <linux-pci@archiver.kernel.org>; Thu, 25 Oct 2018 09:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 997BE2064C
	for <linux-pci@archiver.kernel.org>; Thu, 25 Oct 2018 09:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jGlY3EOd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 997BE2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbeJYSVh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Oct 2018 14:21:37 -0400
Received: from mail-eopbgr00044.outbound.protection.outlook.com ([40.107.0.44]:37222
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727202AbeJYSVh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Oct 2018 14:21:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HWFT8/F7QfozdSh6O2E1i5i0JfTHtpZfR552U835KI=;
 b=jGlY3EOdUiI1jr0foYwZ4O9BpDaF77EYCfvwoeQV+8/GWD53Q+NycASSEp6ddGPr+R7nonoM48RvxsUJlOGayqI0u/BPhnIZUlR/WppId6HbE2NsOOEPmOcxF6WBXfTHCn11ekbuieTy/9NOxvHyvPW7DBklRkEN6lr/Cy4Icvk=
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com (10.162.155.27) by
 DB5PR04MB1208.eurprd04.prod.outlook.com (10.162.155.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Thu, 25 Oct 2018 09:49:34 +0000
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb]) by DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb%2]) with mapi id 15.20.1250.028; Thu, 25 Oct 2018
 09:49:34 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>
CC:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCH v2 1/4] dt-bindings: pci: layerscape-pci: add compatible
 strings "fsl,ls1043a-pcie"
Thread-Topic: [PATCH v2 1/4] dt-bindings: pci: layerscape-pci: add compatible
 strings "fsl,ls1043a-pcie"
Thread-Index: AQHUbEgIvp/tpcIpjU+vqwYYD02j6g==
Date:   Thu, 25 Oct 2018 09:49:34 +0000
Message-ID: <20181025094929.29481-2-Zhiqiang.Hou@nxp.com>
References: <20181025094929.29481-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181025094929.29481-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0051.apcprd03.prod.outlook.com
 (2603:1096:203:52::15) To DB5PR04MB1221.eurprd04.prod.outlook.com
 (2a01:111:e400:51c2::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB5PR04MB1208;6:naAknVL2+8mp+VC0raFuAWz5aWF2XQIHvjHlV8BUlRdyVsG1I3WDZ6adAfWUGGPL5OMRJG3ydPi16AoyDy49WcrHKcL+KRHqMBeX5+VkI45OiUMXvtFWwFg7BdC+502qORXbY1zGrmJ2K4U+P8+0yTf/x28CDlo92+jCn+uo86MufSpQQqS6tf/7tDozUZMMi0ZZDmPqEzfrv+SDwvD846IV/1WVe6blwXZpfoBswnS+021sq1KxzFwhRw2X+uYE7aqzF+yyHBn6UgNbCnzc9oA69GQRy6UjdgKXEb0DUMf5Y7/49yEHzVJYrqks94Nz/xhyDEEy4fGy3SgmSVHAk3IKETT0Aj11/+lN68gOp4KF1Vx8NRHvsk5JG6PilZ4JGLhW+63/kxQGxQV6f21Ho4tzwyMwOKP16/EAdrCCJPsEm9L1F6r0XFufOWuD8xk/bx09HNkqvswHXTPMnlI2Uw==;5:NrRezYwNkXb/WqKt368ZJjNziYY8k2J6nLtg/gBFNoEwYRrgP5TpxdyXV2vaP1wGErDi1zSTPFJSQseeBL5n0+nrkbjRrPUxbDkBvtojYwX4GR6U6NW3j2Yc4mkx49fbo0yw9zytsl0hFoqvm7LxCvpfT33Yjl5V0Z9Tf3Gxpu8=;7:GxqSZGecFuXBxkqLgObXEsF7cmlU61bXkEQ6uXxYRfoTAG3WbUeRuPr7hiAT8l2rhqNsR67/d5c2ySGAfgmkx/AhovLRBwu10LianJXAvvi8Rx74pKo/0auRpmyYtcpctkGyK5M/ffDDK563q62B1prIpetUbojjuipdQvn9Ncvo59pO7VBGmhPlHCFo1ogVs0QbXP//8qxFEJbY3zC69kGLk81hHkkfjqeBQ4QO1JIMfBERu6mkvWxedZc6nI+h
x-ms-office365-filtering-correlation-id: 97279770-df1d-41ee-e26f-08d63a5f2ae1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1208;
x-ms-traffictypediagnostic: DB5PR04MB1208:
x-microsoft-antispam-prvs: <DB5PR04MB120864CC8CAA7FBD7A18783F84F70@DB5PR04MB1208.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB5PR04MB1208;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1208;
x-forefront-prvs: 083691450C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(396003)(136003)(39860400002)(199004)(189003)(446003)(486006)(6116002)(3846002)(102836004)(5660300001)(6636002)(6506007)(386003)(575784001)(256004)(99286004)(6486002)(1076002)(76176011)(86362001)(110136005)(7736002)(305945005)(52116002)(2501003)(5250100002)(2201001)(26005)(71200400001)(71190400001)(316002)(478600001)(2900100001)(4326008)(25786009)(68736007)(97736004)(81156014)(53936002)(6512007)(8936002)(81166006)(6436002)(14454004)(105586002)(186003)(8676002)(2616005)(11346002)(476003)(36756003)(66066001)(106356001)(2906002)(921003)(142933001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1208;H:DB5PR04MB1221.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KgduA1Kbq67z/nqOmAUz0b5Te0/O8BUBlEjOwT6sw8oLtL3LkVPhtmi0HwWKZD/UAlPj/0lsitukPN0jTd5s3Lo7bCwiGxnkt1Mx3NRgGzy9GfwCUmTohNzgsqDc2TxvKjSaOCy2/JdUetcn/50NBnk+qwl/xvpsdLkNuczm/FIQ+tXpW8CqAVapWzs0CIvf1wdpKUfBBXY0zahmXj/B6Po4LLpZvMrAxlxpQpx323dRMZlsk0TMuJsp6kmB+v185Qn7fJbAYKqlwCdfOgseA3dKA7ScCQPhOi7Jx5JWyGfqylaTto33z7A2/wE0/lF50tmd9d+tWuE7sKPD/bc57muZcADvYRxPXjix7L+1yo8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97279770-df1d-41ee-e26f-08d63a5f2ae1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2018 09:49:34.0879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1208
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The PCIe compatible string for LS1043A was lost, so add it.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V2:
 - Improved the subject and corrected 'PCIe' casing.

 Documentation/devicetree/bindings/pci/layerscape-pci.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Doc=
umentation/devicetree/bindings/pci/layerscape-pci.txt
index 66df1e81e0b8..5eb1c202932f 100644
--- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
+++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
@@ -18,6 +18,7 @@ Required properties:
         "fsl,ls2088a-pcie"
         "fsl,ls1088a-pcie"
         "fsl,ls1046a-pcie"
+        "fsl,ls1043a-pcie"
         "fsl,ls1012a-pcie"
 - reg: base addresses and lengths of the PCIe controller register blocks.
 - interrupts: A list of interrupt outputs of the controller. Must contain =
an
--=20
2.17.1

