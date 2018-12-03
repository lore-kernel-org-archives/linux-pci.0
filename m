Return-Path: <SRS0=SeHV=OM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97429C04EBF
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 10:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D0DE20850
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 10:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GoCfN8D9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D0DE20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbeLCKk4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:40:56 -0500
Received: from mail-eopbgr130080.outbound.protection.outlook.com ([40.107.13.80]:15628
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725888AbeLCKk4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Dec 2018 05:40:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3bFZp1cjtvg8JwBn8enxh544i9drd6jeiUu1WlsNdI=;
 b=GoCfN8D9ZPPmikYqaJMBiel7d/1cNluiZQJ4qK9ZzPZzlRu8usO1+VY/TVVjI1a0onQ3IPA2qTpaf+lUrrEsMTtPsbZAIQJNoMMOh/53azL0/eyA//ee3qN3t5kl21On0e01mOd5ZxGBDjrwGkzFhHxyt4z8SblYRKjmo7INPn8=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB4503.eurprd04.prod.outlook.com (20.176.242.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Mon, 3 Dec 2018 10:39:41 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c%5]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 10:39:41 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>
CC:     Leo Li <leoyang.li@nxp.com>, "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCHv2 2/2] PCI: mobiveil: ls_pcie_g4: add Workaround for A-011451
Thread-Topic: [PATCHv2 2/2] PCI: mobiveil: ls_pcie_g4: add Workaround for
 A-011451
Thread-Index: AQHUivR/TjmMN6nXjUmnfPY7jG6+Lg==
Date:   Mon, 3 Dec 2018 10:39:41 +0000
Message-ID: <20181203104000.48626-3-Zhiqiang.Hou@nxp.com>
References: <20181203104000.48626-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181203104000.48626-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR02CA0167.apcprd02.prod.outlook.com
 (2603:1096:201:1f::27) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:aa::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4503;6:6WQN1anaqpuXNkunGBgNjiipc1brxadGrv5OykjuA+cfOUppTkEUQfpB03+vmypmW5j0qzubPcBohVXDAfUWRiI2lqUx83yyqTrkMGhgS5vEQIm8PWfjP6vCP6Qqz/GBWDIK3doDnakvMrwNWKdx7QsDEkxF1zJUsGjk5r1AsMgsPl1YsEAdvQ7WU8GnvceTD5DpaH+KzvctNpxQ4TSq5nGwsq+5yl8rcjxVacWQSKWEkhawzTSFG1+o68RFvXtZtBl18Fq3t05SAeCEBEyZG8M8VZpXXZLziu3U2fah9dH/2y88H6IUehQp1J/j+eGpZANqLQAwMWRC89MWKKtkilJnmKNc7MoytOVQ01SrdJM9uZg58OxPHJYzWCaRDiOKdhO5adqsKxZuo2mSKiQUcJ88IxxNmaz86qCommVISvqAHO6gq5GK7wmn632mwK6mmgb+/YVIg1ztZA0ibrm9LQ==;5:nf7DHETXawLhc47qF8MB5fTnaJMYSAQiz3Dyn0DCpKekG576PtBz5eDkKf1x91FGF2yqQ3xrR5gloobsYRhRKuFr7iSQCJAISPud4giME1K1j9QEF1N3j0gtVm9Q2/5dj79RklSSqVB2oWDQlB1CuwCphvBHhWPV1a3HllWJzPQ=;7:/Kg4S9b6MiB0/Gs6wfGcvs/TmQWolmivbu0Fzxkx/y/9ulQVg5Sp+JI/WNrqagm6GMqGhsjsRWuL25cCwRY6VAvUxZXbD/fDXDpCLdFNSB1Upl4NswfayChGPL+/lor6kU2c0ZqhsIfJfQqOFD0WAA==
x-ms-office365-filtering-correlation-id: 2dc2a007-6b24-44f5-21b3-08d6590ba197
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4503;
x-ms-traffictypediagnostic: AM6PR04MB4503:
x-microsoft-antispam-prvs: <AM6PR04MB4503F35987CFD2432E4AF64E84AE0@AM6PR04MB4503.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231455)(999002)(944501493)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB4503;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4503;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(376002)(346002)(39860400002)(199004)(189003)(3846002)(2501003)(478600001)(97736004)(6116002)(53936002)(4326008)(25786009)(6512007)(5660300001)(575784001)(86362001)(1076002)(7736002)(14454004)(386003)(6506007)(186003)(26005)(256004)(486006)(102836004)(76176011)(8936002)(6486002)(8676002)(446003)(2201001)(81166006)(81156014)(36756003)(99286004)(52116002)(68736007)(54906003)(14444005)(316002)(110136005)(105586002)(2906002)(106356001)(71190400001)(476003)(2616005)(11346002)(6436002)(66066001)(305945005)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4503;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FOg9hMzIQOD5Hn2+nSbqp6SuhH/3GtxdKmBw3KgFtSH3SmNZNRs70BihM753c4vqU2KC/cqb+KR+m8IMNnMwCGqpUk+i/ha/glhKZ6VobwIYBT/QnzprL5hUIwcw3CIeL4m3423VwvmF8WUPhLPb5OyVTGop6hyFecVpObNYeOxnAR0Bxg3Vyt2VeNJPIVeTqRuXGrS5pjaTRi8AmwaLqmS0uKnW3FaonYOXtGg/b6l1auokAwR/rzfMSvKBfFPx5FsuUf80REQlVQNcDJi63bsmPJMruVSrV9R/X0E7nYCw8r1WF5W32taL8Bbb26L+x000D14fNBUHYxd19GE1jnUov7QC9CQ/bUEry9FY9HY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc2a007-6b24-44f5-21b3-08d6590ba197
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 10:39:41.2254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4503
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

When LX2 PCIe controller is sending multiple split completions and
ACK latency expires indicating that ACK should be send at priority.
But because of large number of split completions and FC update DLLP,
the controller does not give priority to ACK transmission. This
results into ACK latency timer timeout error at the link partner and
the pending TLPs are replayed by the link partner again.

Workaround:
1. Reduce the ACK latency timeout value to a very small value.
2. Restrict the number of completions from the LX2 PCIe controller
   to 1, by changing the Max Read Request Size (MRRS) of link partner
   to the same value as Max Packet size (MPS).

This patch implemented part 1, the part 2 can be set by kernel parameter
'pci=3Dpcie_bus_perf'

This ERRATA is only for LX2160A Rev1.0, and it will be fixed
in Rev2.0.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V2:
 - Only apply the workaround for Rev1.0.

 .../pci/controller/mobiveil/pci-layerscape-gen4.c | 15 +++++++++++++++
 drivers/pci/controller/mobiveil/pcie-mobiveil.h   |  4 ++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/pci/controller/mobiveil/pci-layerscape-gen4.c b/driver=
s/pci/controller/mobiveil/pci-layerscape-gen4.c
index d2c5dbbd5e3c..20ce146788ca 100644
--- a/drivers/pci/controller/mobiveil/pci-layerscape-gen4.c
+++ b/drivers/pci/controller/mobiveil/pci-layerscape-gen4.c
@@ -82,12 +82,27 @@ static bool ls_pcie_g4_is_bridge(struct ls_pcie_g4 *pci=
e)
 	return header_type =3D=3D PCI_HEADER_TYPE_BRIDGE;
 }
=20
+static void workaround_A011451(struct ls_pcie_g4 *pcie)
+{
+	struct mobiveil_pcie *mv_pci =3D pcie->pci;
+	u32 val;
+
+	/* Set ACK latency timeout */
+	val =3D csr_readl(mv_pci, GPEX_ACK_REPLAY_TO);
+	val &=3D ~(ACK_LAT_TO_VAL_MASK << ACK_LAT_TO_VAL_SHIFT);
+	val |=3D (4 << ACK_LAT_TO_VAL_SHIFT);
+	csr_writel(mv_pci, val, GPEX_ACK_REPLAY_TO);
+}
+
 static int ls_pcie_g4_host_init(struct mobiveil_pcie *pci)
 {
 	struct ls_pcie_g4 *pcie =3D to_ls_pcie_g4(pci);
=20
 	pcie->rev =3D csr_readb(pci, PCI_REVISION_ID);
=20
+	if (pcie->rev =3D=3D REV_1_0)
+		workaround_A011451(pcie);
+
 	return 0;
 }
=20
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/=
controller/mobiveil/pcie-mobiveil.h
index ab43de5e4b2b..f0e2e4ae09b5 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
@@ -85,6 +85,10 @@
 #define PAB_AXI_AMAP_PEX_WIN_H(win)	PAB_REG_ADDR(0x0bac, win)
 #define PAB_INTP_AXI_PIO_CLASS		0x474
=20
+#define GPEX_ACK_REPLAY_TO		0x438
+#define  ACK_LAT_TO_VAL_MASK		0x1fff
+#define  ACK_LAT_TO_VAL_SHIFT		0
+
 #define PAB_PEX_AMAP_CTRL(win)		PAB_REG_ADDR(0x4ba0, win)
 #define  AMAP_CTRL_EN_SHIFT		0
 #define  AMAP_CTRL_TYPE_SHIFT		1
--=20
2.17.1

