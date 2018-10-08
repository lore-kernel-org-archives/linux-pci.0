Return-Path: <SRS0=j7M/=MU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F51C6787E
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 03:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA1F2087D
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 03:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="x60iOHAh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEA1F2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbeJHKZB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Oct 2018 06:25:01 -0400
Received: from mail-eopbgr40053.outbound.protection.outlook.com ([40.107.4.53]:4512
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726295AbeJHKZB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Oct 2018 06:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FqxWfzgYOVD9PduFViDhWRV7qRjB4fBc/B1N0qyJLo=;
 b=x60iOHAhRVZ1knTJFOvuAYp6fXsXqkE1iQA6JNMGN83M5YxKSQbU4h3AuVBbVHQumI6G0ZEvLVb2e3+iYpbJJtMWlVPbV3sAZcJncPHDHCQ+YCGZm36ZiaOKE5nADQ83WsEcz0QNjhiF0z0WKVd3ScJA4ruI9NStA4YhBsrzIiQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
Received: from mega.ap.freescale.net (119.31.174.73) by
 AM3PR04MB1220.eurprd04.prod.outlook.com (2a01:111:e400:586d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.28; Mon, 8 Oct
 2018 03:15:23 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, leoyang.li@nxp.com, shawnguo@kernel.org,
        mark.rutland@arm.com, bhelgaas@google.com, Mingkai.Hu@nxp.com,
        Minghuan.Lian@nxp.com
Cc:     Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCH 1/4] doc/layerscape-pci: update the PCIe compatible strings
Date:   Mon,  8 Oct 2018 11:14:25 +0800
Message-Id: <20181008031428.25293-2-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008031428.25293-1-Zhiqiang.Hou@nxp.com>
References: <20181008031428.25293-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.73]
X-ClientProxiedBy: HK0PR03CA0085.apcprd03.prod.outlook.com
 (2603:1096:203:72::25) To AM3PR04MB1220.eurprd04.prod.outlook.com
 (2a01:111:e400:586d::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b5a5571-07c5-4cc6-53e8-08d62ccc4bb4
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1220;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1220;3:g/o7bImX8Pe6/GVGF1/DagYHWzvzFXJG8SpPsDuVzV9sGtuv6do0meXEX7FD7QPkXcr+xucGSp+acE4jRjWcmLNtfsDl2jHY+Em/xp2GwjGkkGI7hgfgDwGHztCo0wmSb01ZsvICEk0fF9nV6vqevUy9aGBCl8EYPTWwF8uSm5cOLyxu/FGsS0RF+GTYrcSSnLcNfPGCnQTdZOwzo6EKoNEPz6Dh4AYOOZiGYO19418prAJ6A5em6kCIFd3QhLL7;25:qftZrmZrQ1sqCRNoh9PBqXGH95A7GqGVDEr1zpmMvaTidJU4Rlkk05NsbhvBt60ZPOz2FDUap6nwllmjovkMne9Kta1l4ecQCFPvWqoillD9bBrc0MY3yngY3HHsTBLKRIHEfJnkBomAwFtthsI4DDivpPWmTm4Lpn1Cbd7H8AdCGe5emiicOvTfVXlf2iDvXSJHZ2B5ie89PiqnPzFE8k2mCB/g4/x9NaVxwkk0IxJE3p6TwvQtBt61PFzpc4L+w3mFpc7+n5MKEPHPHb1w9swiKlerEGFlFQDtwWBpj8G4M9RGyd5cxQov+PXpBlMyWLWeco5IF8gycJv3Ik4JrQ==;31:dHtUviOVuHHHXQfnApCKJ2Pqw7yUn4fNbXHV8Co5C8oOEyvgRskliPv4kY+l0FF1a67O/z01c6EIZuOAVYF5eqR0TSXBnFr/PXpJJrilXSLdg+2vIKIpjE8MyDIef+2vy2JdOdTjcwOUThZu+Tigl4kiGKzewlL4nLobE5TEu7qxExyGVaW1/Y0+7RGRq9l3UwZBuZzs7QT+X5CK1izMOb/31I7oihpsKcB3wIDkx4A=
X-MS-TrafficTypeDiagnostic: AM3PR04MB1220:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1220;20:pUlET+7Q29RP42ugVZl7B/SxtffzgtMnlV5NuktcsVnIya7QU1wYJVzxpBq4XuG1FXjIefrW3XStTQKQRHegh67DQZCzcE3WSgleHO7mtkV6+ugv2Jq7cWC4q44PRV1XM17cv3o/fJ9YrYLVLZU6eCb4iEy/1aCLJ0WrgLVtvU7FzGqGnPJcromyJ2/FrNaWCXb6ANPgTPQrHvI7Ye/tRTeYMaUR4eG3VuYiIR/DSDtklAjxacLsg5anD1/NBOxsO8f+bw3oGuzWlMWnlQ2mebBnyTsi0r7iXUalM9Uz+yXRNXja2d0RMUkp8f9jks0MV1HmhH87mADdC6HtDaJK8gBys5bF1m56fdYtUIw1tJUD4u4gYpLinLLTozRuOYBOUaFDRiONTofrAV6Qa3GTizaDZHo3DWId6escjH1NJ1vP07FakX5UnSktAS2Pey4T4jVuRejc3+WehYl0TsMipcoCBj1B2W5+kPCKoDU634j2bDN6Jn7udUBgVsMMQLzq;4:/AkbHqNapcu9o9ppcSrfPPi4hJAmxNr178qmdI8nFBt18gaqHiuUwNZTp/+oOuHOpxjt4FLmCV7i+QDGRKHPfXqdMJFQr9mtwvSFar3AQACJLoehH4gLI993teh7DC3+zbu8iwDwPnOULoZPj2UcFyGpPMIH5uoIwyPuFqQ227+Uv95jS4/NpxkwDe1+QOBEnSCgDFrVKIpBbPMNFvtKmX1V2/NbXzcTPKyCfEQhwIDAST2M99Bh25QWcwQARj6SYn5O+Z1LU3x6H+tmTqBNDXwWqqLUZxzcSxRO6SeBN6702Pt0oR2OhMihUilV47xl
X-Microsoft-Antispam-PRVS: <AM3PR04MB12209C8B67F4EF1F06EB803084E60@AM3PR04MB1220.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991055);SRVR:AM3PR04MB1220;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1220;
X-Forefront-PRVS: 081904387B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(366004)(136003)(199004)(189003)(25786009)(16586007)(4326008)(446003)(316002)(2616005)(956004)(52116002)(51416003)(476003)(86362001)(48376002)(575784001)(53936002)(6512007)(486006)(2906002)(68736007)(1076002)(305945005)(7736002)(50466002)(5660300001)(76176011)(11346002)(6506007)(36756003)(386003)(50226002)(3846002)(6116002)(97736004)(8936002)(478600001)(66066001)(186003)(6486002)(16526019)(6636002)(81156014)(106356001)(81166006)(105586002)(8676002)(47776003)(26005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1220;H:mega.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB1220;23:fI+1Ksg7/gYnGwp6pexCXTFDCZPOyDW/8xIhwoqyI?=
 =?us-ascii?Q?AytbHxW7q/lULZz8LdUGd0kJZh3bZv+P4/KaNKypAxCLZrlMZoykV55ODN8p?=
 =?us-ascii?Q?qqIlSE+mcAwEa0yePiQzDeCJpVsPKrNssXYbgxHh56aQ5mmaJErlJEFrbElh?=
 =?us-ascii?Q?Ka7EPFgwYVYI6RUUrVC7hjhCMY9gdXSqKNpmx4aZ0kQpei7ricmpgN3kV/09?=
 =?us-ascii?Q?xEO/QKo+w+Rk2P5ATydoYj+s3B8HAYZIEoXF98MeLxwFlbTlY1cJBsJaHrw/?=
 =?us-ascii?Q?fy05AwEl+bMzPk1VGs7NHEe7KplFJ8axeNP+YPbPqxyEC7bbvSxQZSGULebF?=
 =?us-ascii?Q?p0v/VfRZ9xGbKwhgqITd+MRJdx8FOfFuEe8hmP8ydynY1DPTW7AiCfFqFrWN?=
 =?us-ascii?Q?vgUTSOkxC6eOpjPaS9ghfVhR8aso/yKqTlgnmt1VMniA5sEirsB0Xp7y2cjy?=
 =?us-ascii?Q?jkW2NMZz3T+T1mnPdNNxDLMkKsVg7TGCraN+PrC0f8nrSHNhHpmmlAu5IOVt?=
 =?us-ascii?Q?Lt6aZ+fZuXl1S0YzIXp7fZHKaIM+mA0CRwgIVQEjbQLklPZuBHqWXTAkrjcc?=
 =?us-ascii?Q?d6ALptDZS2bGaQLo9PlR1OarxCF0Fe1sTpYnc/6Zh+EnYnKiUz7UmtFh6Wzo?=
 =?us-ascii?Q?rg08DplhH68lP9tRKeTINiYtSX8gh2dY/UAOkqEknm0d3cNMO4oet7D5UJ8J?=
 =?us-ascii?Q?LHjRbKCvwWIFSwpQ9/rNupEEx4AMnSH0BD1kFB6P187tYZYeL6ksO7FUngGD?=
 =?us-ascii?Q?lh8Wq4OEaI6K9b7EAtnS9D921/1/wcdoA2Cx40tRuaPy8eg5juEtG96cB9BI?=
 =?us-ascii?Q?MsJ4ChifySZ2VYqWxb+zi5sK09b+34hrjvLZGNj8PQlcKzRDgwNTISdUPmUU?=
 =?us-ascii?Q?tSJ3sRWS40c+QwEVwbwXPh7q97xvqcaEaFH9US+4L5qz/uW43sMWGtewZ3bQ?=
 =?us-ascii?Q?7vD81UII5MnMIstGmMZ9WGJ32ZujqBYPhXodDcrMBPTxvjAv5Fvq0BDhWft3?=
 =?us-ascii?Q?421qI4ZpksnvFZI/hxUODbj467MIQCQcUBXXuNxQrBXOw11sdQzEXXzrCZKd?=
 =?us-ascii?Q?8Su7S93CYHxgDtgcwUL2SzefVba3Oi/GirvNgDGZRvApYjPJcmioY23vydw7?=
 =?us-ascii?Q?aE69vcArDGMc7jlqXbDEC3pxE+wrsACE24ahEnKjuOF0+Wul7ayAslEB747O?=
 =?us-ascii?Q?bcT19965raX3jZ2+3kvqXwBToPUIJaTb5orJuBiWTOlwLPxgZ+sdRYNyA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: +YbYu98eZec1PIWCydn/naTN+/WmKQ9n6JbwFD+j/1kn0SW94s/2qJaqDI/oRg4Myt2v2qczsR+7Azk0ikAXqY5unqgVn8eqeT9Gv5vaJQZKNg8cL8Kmrl68aAxhD/kou3O7hzdsizZ1IIZQdvPQvFx7OKzbBKT3/ZoUwoqCIpotYFOhwTw5eRAh/tzb3I9HJKlxs8na5kmKBiwHY1DWg7mjno1TN4oL96mEL/XjnNTrnF7j2ca57DG3kPuitKCbqILhiA4mtE2D1mzzm+Iqx7xTt/H6jeQSeOM9OnUk7NS5mjTgqrA8MWYy+6Cc8QORL19AcFu2kz2qJgSG2R7P2VwW918fp37CpmjkP9+uuY8=
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1220;6:zkpDJO2iNJSznSWl3jC0l7+jz7g7rGLyYIMU6+qgpgknG60NAgexUsF/0xsUaWwLM+0Xm9jqeGW13X0ca1eCiavdyRUldAVqVO5MyrleHGsek1yVtmo+rV4momkf1z0gvzBd37LAevb8p9xxInkkOMeT1IxNNTcW1rKAB55s4v9c/mtKt+MJDmxQ1zBQLGiCI7ig1QV5q2Io5UA4KrN4DMvm/Y8qnHQIZTUQuRtxDovybZ7aM070Z3xpTCz+rlhsrJNk2Wfl0BdruzWVBYLzd5XYIGBbMRiylFaiFnBCsBWq+hhAxSv5BMiImQ7tI4OpK9xTSQ49zxpQ5x9TnjhjO87MxQN3V3Qc5yhfDHt3qPPVUhG6FR1gZhga+HaBuyYQ0rI0kwpdh1gjPTgD35Ggyanszt/E9FzMRE/vYXUD1iyijMmX7lCg9xsQL0JEvLm60+r7O5jNWahRyQ60FVvI+w==;5:8+xW4Y/RU2bqe8ZzT0p57y4Ak3p3MuzUKM4G40BsVSL3PndcbWqTI6tTdo8OCKayaE8EKCAUv3McR97SjreuM/NeCU4N0iNBtDgRb3TKudGDAN0R/mEA0WuTqsrkJcB8VfW5jSxlqpDKyuX5fNE/eUnLw44x12+l+wvcBt9DcgA=;7:Okb6OMYLvKuADwNRrDmnkmUyDX4OBgGDlMxPJ0Purypam1rLtfttcX+wvi1eCdhYEyLbG6aidSWcN7vup1aNzIqpY8/jl+lDhP4TZ9+WtUF68tKYF1ZuOdxe6t3Q8sosAYXXFJZkyD910qYGgXD8uQyCJwBNe6MWiyMiuIzyHxpggtH9PS+elPpXmT/z8cHCcw0R6VeU/w2AWVDMvf/k3Ia7z1EXQFIOLCHuT70M4N9LfpI11FNaGxncbTMrBFwA
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2018 03:15:23.6221
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b5a5571-07c5-4cc6-53e8-08d62ccc4bb4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1220
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The pcie compatible string for LS1043A was lost, so add it.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 Documentation/devicetree/bindings/pci/layerscape-pci.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
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
 - interrupts: A list of interrupt outputs of the controller. Must contain an
-- 
2.17.1

