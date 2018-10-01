Return-Path: <SRS0=/qR3=MN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4256C43143
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 19:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 748D021470
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 19:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Tu+rBay4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 748D021470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbeJBCdj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Oct 2018 22:33:39 -0400
Received: from mail-eopbgr80058.outbound.protection.outlook.com ([40.107.8.58]:27854
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726378AbeJBCdi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Oct 2018 22:33:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcHpQx1osWYA89qBg1TuwzlD5kf9CA2IoNUDjxNrET0=;
 b=Tu+rBay44u2oB3GXmmWuDjwkNpz8u7iy1XnRV/u9e2+rnQIi3kuMp9PHZk3PNvlW2pJMrXtJOaJ8kRCVIVVYLOeB1bifIFu6Ld2I3xWASERtDRrBuyib8s+kCgulQRH26yaRGc7qUzt3DGkhoVRXo/ejRqWs38+pxaca3Mh+RHk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM6PR04MB4293.eurprd04.prod.outlook.com (2603:10a6:209:4f::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.22; Mon, 1 Oct 2018 19:54:08 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] reset: imx7: Add PCIE_CTRL_APPS_TURNOFF
Date:   Mon,  1 Oct 2018 22:53:45 +0300
Message-Id: <b58b47a2ebc60cbdd954121366b7a6e6324075c6.1538423063.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1538423063.git.leonard.crestez@nxp.com>
References: <cover.1538423063.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: VI1P194CA0013.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:800:be::23) To AM6PR04MB4293.eurprd04.prod.outlook.com
 (2603:10a6:209:4f::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72ca1475-4ca9-4169-a7b7-08d627d7a71c
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4293;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;3:VNrwkIgC5cUJsGE/59i3LnMqLfxyHXpiRQ1aeBxXPdSGfZoMYTNDwvBlIJx/A5c5ZTuFc0MkUF1YouEWrf8akexV6zRlTui58FQ0thTxS5+vJnNCs75BTYXU5WioTDlI0RNT3poZ2maQXqQ3RGvxEviDFe4i0Q+QTvOf6thtGTobySIUYjVJ7gZkklfNQwVrtax+H/p5TBNG5BkKKZIH+i4I7vHkPhfcqYkplGH3GFbpVkfGjk7a/ldsNTezRo19;25:FP1AWg3BxWWZ1WgrousQniN7wuhwSDdzg19kQCRIGXNhy1ynG2pZSt9Ixnd3UisrIeuFGX8RAVn06fWV2Gxl38ocn6ZQSEvy+fuzNcja41uI7OCgdrzgwxJx8a9A6BoTNeyhizCdEbjIJcTXU7BSyK9cLma1NYJ6XW++V00cvmtBYBDEfTm9BYNmC8Y6QlfYxvZBMTsa6YtjCRTgnvsnLs64reB1wuAt5J+ekdGrWKSqMXWoNe8vwXX3WHSYNiVMe79W7jKIaT0XU3bbamA4YIfJdmQKKiL1cSA0tuLk8pHoeBCtG50KSuN5JYv7uIaIEoC2VTw6PtXPCneRf5NN1Q==;31:3FVeaSsizxkNRdCHV9rQa105Aexz+uaqSZ6fjZLJj760InUpX6W087vq6oNyYtWyJNPsGPvAoNorTt51okJKEbksQrg1w20tRBzLtL4LeNJDVyy00kcT+I78yXoMcGfnEdDpWbU+SLKG5xE+C78BKfhxi4FWLqhfT6pX4zfKkribDMC5uRShrNLDpz6mAqRdCXfFc9COD2Yod3FI+xRmItHn1NmyqwSlAxc82QS2tnc=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4293:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;20:/JurrHsLww60cKcDJE7uBWv8GsihZon8FAS6HNpqfF5Vu1ilyELVMLpXWYTp/iWSLY8W/7pQqNnHpb9Ka6wH+QvPN+h3jnD/z0hA1OiV+DLnh5s3dDofoRJ1m3957Nhgs7szDYz6DudrK/naK75jr7TwqL0P2twjLYvJY4PBtDXTnlaSik+s33QjufncR4zkl9VIYdSDT932VVt8UhJUJ0UGr7T3kdnCO58PMLx5O8g3gEi0smfBdUbFM+jWo7CW8jwxfvw2Mmrh/cFnbVsRryD26qWtZgfdOgVAdy3sadtnNRaNWvPFh2SbGbE1sf+5hLjX0wRPYQTDwAHfKcxky1uHrskMKuAkkfaj1OireM0LZ+wHHHmWxJHprssdlTaMqqBX+pHrZvTlFkSLD1B9WafH5aaKYkrrh46UFlU/qcZo+IE8U8jxrZ6SCJhT5iykSRwlzeGP3LpkOOFjV+RJETCd81UlEZS/XuNhM5kqIoNzDtLgXZrlWZFYnZp4sSH2;4:Cn6lXqQmlqVqK21qyj8NecrmzDKEeFELHQgzR57LuJ7iQYFGWUxa2I5Gyri075d2woRvTNvxYCF6xP47FKdvRQnK6Ml/sJik6oYQ0kX1xJWKPJUIe5DVxTlSfVP+Ah2hvj6YOoClrmwe2zwnOHvQLktwuRG0uWLBe0GhVzKhsGD5uTA+3m75nMiSwv75MiQ4sgQP7a5MLi9gJp2VpqOCij/oQvXAs/qauMshGCyVEWf5fUDvA58ymxsZYTLzktUN7qyaBv2lbH519XRXURhol3QoFUYdK8OhNekkw2sZxzw6kTWNAnhM27cNtfJfCMwi
X-Microsoft-Antispam-PRVS: <AM6PR04MB42939B9530D83A72E61B5F7CEEEF0@AM6PR04MB4293.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:AM6PR04MB4293;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4293;
X-Forefront-PRVS: 0812095267
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(366004)(346002)(396003)(136003)(376002)(189003)(199004)(6486002)(7416002)(110136005)(54906003)(118296001)(6116002)(53936002)(6506007)(386003)(3846002)(11346002)(478600001)(105586002)(16586007)(7736002)(50466002)(6512007)(66066001)(47776003)(25786009)(956004)(486006)(305945005)(476003)(48376002)(26005)(2616005)(51416003)(52116002)(106356001)(6666003)(2906002)(39060400002)(97736004)(16526019)(186003)(14444005)(76176011)(446003)(44832011)(86362001)(5660300001)(50226002)(68736007)(69590400006)(8936002)(81166006)(81156014)(36756003)(8676002)(4326008)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4293;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR04MB4293;23:ceUQWfxQVmePjKE1e5QkGEtsDfOpcmHe716M4V106?=
 =?us-ascii?Q?Ar4Xhorz4i9G94BrlcN1BfE6RWdo2MP8IVnKvHjOztlkjKEKqru3hAVSW8Eu?=
 =?us-ascii?Q?MVYO9UaCnhD5eL+VeLKX09Ho8kxg4i3zQDg11Hk7Y5JPH11AFd0PfPtKEbRP?=
 =?us-ascii?Q?7POSjH8N7XHuNhkEOGHEAKa7XdRYj3kHhfPMrWhG0nWwJjOESJhd2+JYnQxz?=
 =?us-ascii?Q?5/7n869HS97d58ORFqtTF3ar0V6V1gJmW78DFH2rrWqv6A9LqnNaoXEHb5YV?=
 =?us-ascii?Q?qvPC6zL3VdSOZqqBzi47sN0cEdksP+u/c2RVf6xsCkTYoeWRiGtMBQ6P1MYR?=
 =?us-ascii?Q?a1v4iqjl42I9spVp4PWUAod6Ax+9Ud5I6wMofKpSPtSmRceBnLYFCqMd9gBN?=
 =?us-ascii?Q?WzRufsvjsUhEBTKsmB3FYLrZED0/7hDdgw+vYgmFIDTkORf3fVLRcWedwz0f?=
 =?us-ascii?Q?HMUFzJ6KTtrtAqTjtY6Ic4BIL9sA9gdf/39ymbSvQXV4kXAb2eTwevcpx7tr?=
 =?us-ascii?Q?8TXLLmUyqe7gkWuwqvEEgY/VgIlVrot3XFTrzyHC2YlW9bo7ZGyFaIXzWesS?=
 =?us-ascii?Q?se9/QWEsJU3QjQRtCo9aFYTzWMpDFDc5iQ/njLYVmWqaR5GFr+0IBZJ/WQd/?=
 =?us-ascii?Q?9VKIuASR4KJmI2UCTJtd1WZmTYDQoOCeYOvsU9kYUcMi7forwntmzxK+hTT4?=
 =?us-ascii?Q?6ctsYSKMyjTTArnt4lJXtObtfP0yAdouXVIg/yXVnv+OtbWHRfv4SqlKOXOZ?=
 =?us-ascii?Q?laUKDsUjbMeCgkWT9YKcOzNTC7J/Nt+uIoh56NfIkxAUiMTATOP6NrtTk3Iy?=
 =?us-ascii?Q?L+aJXXygyzDiGiWJ002Axz/rdLnclynUdbWBPxS6TzesCMA8qla6YsVPfjbN?=
 =?us-ascii?Q?EnS3mcqoQ5Mqy8bWDiZHFUqZ4WwnidpWDLzU/Vb76wj3ZYgSAsBNLeWFV4y2?=
 =?us-ascii?Q?OpVxkTlRKy1uA/1gs45707g36taQTlkgdOK1DBCjx/letgtJ8gDWIk5hhqTj?=
 =?us-ascii?Q?xn+B03t1xum/7Xl/uHPZEogG5eCf9IQvARngjG4L+CRrw3BJNHqqOR4sU9iP?=
 =?us-ascii?Q?5M9vG3BqZbx5OaQsoZeCOHKkhNIVBxoPWLaTy8nqiL+U3V6tQOyFLMluIX+l?=
 =?us-ascii?Q?T5JnvfGPEIcIUliRBC917Nk5JJNHa6pdCRewugR62wBpgcYyU7esH2QL1DO9?=
 =?us-ascii?Q?eTAb3G1LvhRf14d7HeY4kctNJMNe7bzm42EcqyMhokCo/DliLYhRU5AQASe2?=
 =?us-ascii?Q?a3H75XD7SC9+Q5A4gG0pa5V09UvzVIyMcMfGFomAOh4OBHIeyJgpNES4Pfdo?=
 =?us-ascii?Q?R39NANmioA6d1ruSp/HImZ47Tz2U+j2EbhjRubhSZ3cQP0RIE1Rdgh/bLbK4?=
 =?us-ascii?Q?WXrgQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: KFhRiSFnAfr/u9FW8TelhQlRgjAyOvDbHqzT22K0UxdudQe7aHAJw45OE3wTkP8j8EWZUyk5GJRABjgK9/P/C3lBFynRPTmYQbaAWFTfgn6L3No2vNHImvtP0AQC7ZakPXerA3k4QvHD39x+TtaoChDan7KPNSuzU479OICo/Yn59KzIxRZgzeCs9V6lhfCwhb/e8ax45Ztf7maNOFmnTtKhVzqE1Kxaqv1TltXvHDOwk/qi+Aw4L4OQGg7xWLKyRqj1lBUf7heHoutHQkXf5DKNpL6JE4Pk2OihYeFbzs0elCMphPT5S3jimNZdsz5oGr64a1pXueEp80wOJIqiVmI9GjBE448EUyuAE8vxYTU=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;6:5s5u9UuDIE/Q3xFfKviGi9yz4GolDSCeYix9s7ioGbDlPra4Y0ESI5tTG7hLTPeahbkZXPklPzMhfbAd6LleVXbPMZosFcxrNirGN88v5ZXX1dEdYtL6MHHxuEFsfVB63qZfnRXwL5tQZUkDRTPns/KrYtL2AM3PNjJ4fjrILB/4L3zz7kXpc70EckD/jfG0Ix+zuMNbM0nG0YoVqHWVAvIy0nWG8IJkPdl8KN/To8gYRVoNaii0xfz5KO7cQaZt5FO7Lqz0udA1CwSLpTsda/hNBiUBB8iWniMV9RNPwTqXjQtM77pL4xvIBW+RCuDAXvhIg2dc4xvravMgGmahZQOHR+69gk9BoN+2ADKfT6bBnJ548XYIljGSqcH+bFElst4yFYUlVn6WJnZFtWRV6AoUUq0dRzp0cLxhk0vMuvWxNfPYgR1JUoz/mlHRjZAiK6nNqA0cFbWTpp/lfvfOJw==;5:z6e/dh4zEqIowemuCu6V3K9BhJIWkoTFg4ObWOrid5ZeTSKUJ3wVn7zIIuyyqsGzHCxCKjF2pDLpPUcdgSTz1obCChOUJVAva0MmEKK07Z+wSudHOSVc/9CBd/9VH6scamIYm1/SeaI1gzNIinxiRS+okitJuHVX6YfQYrS9+xU=;7:OZgsTn0M56wH/SnsbKmhurTaBzZMp4OSPqfk+G+3HW7xrvPQfcNeNby143HawfM9P9bPoRTuiDWlRP+lWKhqcXH3G/zPOoVQgFtjWv4GiDo1nzsHmPzT00GV0r9Ko+G1pRyXTDWTpIS8edE1gfXoHnoPtcQk8eIDGO6v2qNW0MipVzLh6QXyL0RftwobYUYdgH6L5/edxnpAiSqseUmDxavaxVzdS43LpT0J6vjNxoz1jPklCLFNusX7r6iJRQEp
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2018 19:54:08.5722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ca1475-4ca9-4169-a7b7-08d627d7a71c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4293
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is required for the imx pci driver to send the PME_Turn_Off TLP.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 drivers/reset/reset-imx7.c             | 1 +
 include/dt-bindings/reset/imx7-reset.h | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
index 97d9f08271c5..77911fa8f31d 100644
--- a/drivers/reset/reset-imx7.c
+++ b/drivers/reset/reset-imx7.c
@@ -65,10 +65,11 @@ static const struct imx7_src_signal imx7_src_signals[IMX7_RESET_NUM] = {
 	[IMX7_RESET_MIPI_PHY_MRST]	= { SRC_MIPIPHY_RCR, BIT(1) },
 	[IMX7_RESET_MIPI_PHY_SRST]	= { SRC_MIPIPHY_RCR, BIT(2) },
 	[IMX7_RESET_PCIEPHY]		= { SRC_PCIEPHY_RCR, BIT(2) | BIT(1) },
 	[IMX7_RESET_PCIEPHY_PERST]	= { SRC_PCIEPHY_RCR, BIT(3) },
 	[IMX7_RESET_PCIE_CTRL_APPS_EN]	= { SRC_PCIEPHY_RCR, BIT(6) },
+	[IMX7_RESET_PCIE_CTRL_APPS_TURNOFF] = { SRC_PCIEPHY_RCR, BIT(11) },
 	[IMX7_RESET_DDRC_PRST]		= { SRC_DDRC_RCR, BIT(0) },
 	[IMX7_RESET_DDRC_CORE_RST]	= { SRC_DDRC_RCR, BIT(1) },
 };
 
 static struct imx7_src *to_imx7_src(struct reset_controller_dev *rcdev)
diff --git a/include/dt-bindings/reset/imx7-reset.h b/include/dt-bindings/reset/imx7-reset.h
index 63948170c7b2..31b3f87dde9a 100644
--- a/include/dt-bindings/reset/imx7-reset.h
+++ b/include/dt-bindings/reset/imx7-reset.h
@@ -54,9 +54,11 @@
  */
 #define IMX7_RESET_PCIE_CTRL_APPS_EN	22
 #define IMX7_RESET_DDRC_PRST		23
 #define IMX7_RESET_DDRC_CORE_RST	24
 
-#define IMX7_RESET_NUM			25
+#define IMX7_RESET_PCIE_CTRL_APPS_TURNOFF 25
+
+#define IMX7_RESET_NUM			26
 
 #endif
 
-- 
2.17.1

