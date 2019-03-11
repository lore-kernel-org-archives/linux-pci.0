Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3FBC43381
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 718162084D
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hFcXS1l5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfCKJbX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:31:23 -0400
Received: from mail-eopbgr70073.outbound.protection.outlook.com ([40.107.7.73]:62976
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727195AbfCKJbV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Mar 2019 05:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJ1q3GbR4n8QaufXG6OpX4LbKDQTbtgJA7yjeAiVFB4=;
 b=hFcXS1l5UXKZw5VZ1tCH5EWpLe5mrfUqoBnXM9rUi0pQ7iNOl/vuL7r6eOx9fmf+YFf/+eiaSgAOKroTamnmSCEH/Ur+ck9J2ExCoSBEsk9cX83PuT6cKnhnGzV70vwK+kEEOzUSu2NLQszmUv9+vL+yuNBMJX3HKjyd7Gm/+Qs=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB6566.eurprd04.prod.outlook.com (20.179.246.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.16; Mon, 11 Mar 2019 09:30:35 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7%2]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 09:30:35 +0000
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
Subject: [PATCHv4 05/28] PCI: mobiveil: correct PCI base address in MEM/IO
 outbound windows
Thread-Topic: [PATCHv4 05/28] PCI: mobiveil: correct PCI base address in
 MEM/IO outbound windows
Thread-Index: AQHU1+0UhvVjXnV0a0msw3SU+FqU/Q==
Date:   Mon, 11 Mar 2019 09:30:35 +0000
Message-ID: <20190311093130.7209-6-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: 705a598e-b6e5-4c70-947b-08d6a60436bf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB6566;
x-ms-traffictypediagnostic: AM6PR04MB6566:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR04MB6566;23:2t+pDpXVcOPimXRfzj2wvoa6X60OD7wCdl/TDj+?=
 =?iso-8859-1?Q?33bAqIdUP34woQ1vYQUNLbfZN6/uLAKk5Jom0x0hnw4n/6O4m/B4oufs+F?=
 =?iso-8859-1?Q?Y3g3JcGeCT6gI+y80dQtO013MbG6egkNOP9xNTedJtlXGn5Dc2JjsNn/BQ?=
 =?iso-8859-1?Q?wTgJgZcFphTe8TMIxpPy0R8vaAmGffw2P7HTduTTDwv58QnbLdKLCCswiD?=
 =?iso-8859-1?Q?SpCUR42W1ueCsVXjw1VHeuU4ts/I+nDijLDgZ11H7CV3dpq+f970F46OU9?=
 =?iso-8859-1?Q?yXWm20LSMbgFb6asUnSkBuQIbiF17IKvkkTOlwKMzeDVRChsnWk3CGt70M?=
 =?iso-8859-1?Q?IHxvPEjycxTLNEO96/SJgx002rPlKTMLmcJv21TejO4wbRRkGNs1z+dXUE?=
 =?iso-8859-1?Q?BcOCRog/q1j/VKZ/YTp6Te7Lf1QSE/QNb46HOcOAQUpSViReQzvTxTPV6P?=
 =?iso-8859-1?Q?qB+b/3oH8JI1dLC8P5IlD5Dvv3AEPlnzQ3JgV+mEo2JvCtTxYSMMAgm491?=
 =?iso-8859-1?Q?9Q74Bn3CvfLgDs56UwsBhSbl58xXPhk4F5SkqFjCqfx16n+2e3FfelahpZ?=
 =?iso-8859-1?Q?UZDF5mHHd6z0WeBnc86ES/5xkBZ0wbw5Rsv7Io8RP9dQ2o5MiekSDnEoHx?=
 =?iso-8859-1?Q?a7lemIoBFfv/TmGI34+cHYH9EodS5SKMN/cFXDpMiUNSFcemosFRsDVO50?=
 =?iso-8859-1?Q?+k/1fRynn3w6kFIsWs5U7Bi/7vw7FK1iLATrjSR9aggrh0NG1T01Q46oZZ?=
 =?iso-8859-1?Q?il6tu9udbI8bHQ03szkDIZ8pSSe4yraN72hMXDl4FMF+OOiKfa3yNapEtN?=
 =?iso-8859-1?Q?Qpy2DYXxEuLrvYWs4MHKWhPMo10Tgr1VFX5x1ylTwqoTzA/wfQ0AVzeJ55?=
 =?iso-8859-1?Q?lVDE84UbKFQEUVa/JpK3lNFIrgyj8My1dUL8oqgU/+Uw6I3CGN+RIyxftf?=
 =?iso-8859-1?Q?EVcdATG3XoTcOR0q+o4tdBgiLw7vziOYdTLn2h/Y4wsde7/lm3A0yC6JMY?=
 =?iso-8859-1?Q?eWs/XM5ABVdRjAvtO6BS0odyjrok9IaKG1vm98giQ3pb8zKmVo8NU/DebD?=
 =?iso-8859-1?Q?QuSRgygjBs8yUaSIEalmxrX7o5ZLiLoaQOVc915/pQwDLduQnHc8Iok19B?=
 =?iso-8859-1?Q?HqKOaf13aqjga/g7hSsdBqcExZDc5r2sx1Hgzv/7g6+IUG5fESdh1e4W0E?=
 =?iso-8859-1?Q?L+hi4JUZg1CrT7udqx0z5eEhMTEUcyzwIONgHWun9/xhg5GU15YCfSbxku?=
 =?iso-8859-1?Q?iJN5rj+i1SjLu62fIpxIqkB85S92fiiZej5GLIrWyevb/OuEfpky9qrbtf?=
 =?iso-8859-1?Q?I1qbmnE4U+ZzUOxA4KQ5y+w374n7kuBlSe75OpKvqxdTQ=3D=3D?=
x-microsoft-antispam-prvs: <AM6PR04MB6566FF6B99521A1AD318CCE084480@AM6PR04MB6566.eurprd04.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(346002)(376002)(136003)(199004)(189003)(6436002)(478600001)(25786009)(99286004)(11346002)(2616005)(476003)(76176011)(3846002)(6116002)(81166006)(81156014)(486006)(71190400001)(71200400001)(2906002)(8676002)(2201001)(5660300002)(97736004)(6486002)(446003)(7416002)(2501003)(86362001)(256004)(14454004)(316002)(68736007)(26005)(8936002)(6512007)(53936002)(1076003)(66066001)(386003)(54906003)(50226002)(110136005)(102836004)(6506007)(36756003)(105586002)(4326008)(106356001)(186003)(305945005)(52116002)(7736002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6566;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GDIM1JN2MSBNmOQKseEJjhA/zN+Zw5I026PRKIRIu4HL8aXu9tGMDtA2BjUyJn48OAfC05aivYxHvQ5nFee1r/HOoY6vhRPx8Y4IhzOtxsULEG/2d7y0P0Ous4wJSRzrHYO3BtdZIP34uheFMyPCiuB9SNs7JNtt1oHn7YrB7llQ/aFdT0qOraBOVb5pHBVZq6uZmR0zxSWjMGYhTrRW/UqJyt7Xyt6ZF5MALRtCqpqg6eih+A7necKYxjIzKZ8E44OJZAMbi8TWNI+uG+9RTmLGDzyn6ndrotPoc7vUmVkwwJRpPeR8cAZRWlsqPmciBML1lIb+RmJe2mpZlh0IYfC7Q+9kWlRiit2dvH7UTVbPzS1n8sy4Nz4HtwCpc3S5UhbbaHXRcgj9AdFkoo97KQdM5AAZF5QVyeK0gKV2BMo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 705a598e-b6e5-4c70-947b-08d6a60436bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 09:30:35.2692
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

It should get PCI base address from the DT node property 'ranges'
to setup MEM/IO outbound windows instead of always zero.

Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge
IP driver")
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
---
V4:
 - no change

 drivers/pci/controller/pcie-mobiveil.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controlle=
r/pcie-mobiveil.c
index a0dd337c6214..8ff873023b5f 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -630,8 +630,9 @@ static int mobiveil_host_init(struct mobiveil_pcie *pci=
e)
=20
 		/* configure outbound translation window */
 		program_ob_windows(pcie, pcie->ob_wins_configured,
-				   win->res->start, 0, type,
-				   resource_size(win->res));
+				   win->res->start,
+				   win->res->start - win->offset,
+				   type, resource_size(win->res));
 	}
=20
 	/* setup MSI hardware registers */
--=20
2.17.1

