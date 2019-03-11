Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B4AC43381
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885D72084D
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iWQENo4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfCKJaz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:30:55 -0400
Received: from mail-eopbgr130043.outbound.protection.outlook.com ([40.107.13.43]:6723
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727103AbfCKJaz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Mar 2019 05:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRVbxaOVpCHN4G6WjFD5HlukrFig/GTSuHoq4pwU7DA=;
 b=iWQENo4tsOBsVNBWUEq0KLvK1u6SgkCF48Zf5jdaKWCBrtz926BGNUHbfQAG8BWOu+GMKd7+OgNnXY3fAOYoOET/oJgSzjSIMAjBg0gn6u1WaMuqsQ1L1iyE9hMWFTjNJb/jREDwtBYjiK+IjLDF3eochzGcG72OAUYIjk5mv6M=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5592.eurprd04.prod.outlook.com (20.178.87.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Mon, 11 Mar 2019 09:30:51 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7%2]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 09:30:51 +0000
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
Subject: [PATCHv4 07/28] PCI: mobiveil: use WIN_NUM_0 explicitly for CFG
 outbound window
Thread-Topic: [PATCHv4 07/28] PCI: mobiveil: use WIN_NUM_0 explicitly for CFG
 outbound window
Thread-Index: AQHU1+0doYLeE65/10mqwvkZc/8Elw==
Date:   Mon, 11 Mar 2019 09:30:51 +0000
Message-ID: <20190311093130.7209-8-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: a0998542-8984-4c35-65bf-08d6a6044028
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5592;
x-ms-traffictypediagnostic: AM6PR04MB5592:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR04MB5592;23:x9z+cPiQ0PraFUNlaCxlhaapZXF3IxFETnMlmpq?=
 =?iso-8859-1?Q?NuODYL05pnFxXO+/gV7NlZDoYDAA/GZf+HSzDvqzauj27MWmk0vT1/JD52?=
 =?iso-8859-1?Q?sfRuX8WlkF08uxm06Db0D5kzyKKb2+QbKtBf/o7HZ4vm+LSdOWixiMnJ7G?=
 =?iso-8859-1?Q?ovRKEdht8aN7IiYtUsxkUHF16sfX9tgAmZ4rsZR8B1FqY6CAP56EobfSpn?=
 =?iso-8859-1?Q?f5zWcxQmrhhRy8xyVmpPLX9+OhEw9GgtNlxDPlAJNuMgl5WfLIpdrrNA1q?=
 =?iso-8859-1?Q?MSFOXVnYkyqRRlQZunsJ60ZNGFK+jgI4t/JgTfa8yDTMjYb66+ad5ipesb?=
 =?iso-8859-1?Q?Z36zmko/kUpZE7yzXIz9gQea/GAbw4PtDIRCvQItdJCsAnneVIAS1yxNSU?=
 =?iso-8859-1?Q?X7FxfZ9U47YzOViqYGMw6pmehJQiK1Tmen0OIOfSWqDYJJKdiOGLdKAX97?=
 =?iso-8859-1?Q?3Q/qGDq/Pm2m5RqrlLTHJ88wHeyj7xmY82iY3Fx0Xyd40eO8iLRhklEts6?=
 =?iso-8859-1?Q?QVTLPqlEqcSJCz1A7W+6Ts3m65gq2HYCpC2wASf8fz+eaaM/tZGKOsEOPS?=
 =?iso-8859-1?Q?wSrEIcojX31HPbzYDqrOJsusN6yrGAja5ahvYo+RlzG7ZnnIo5yQ/rI2fZ?=
 =?iso-8859-1?Q?reBN/Hx5OnxgJA6eFr3D55COEihvyE75fvbT5iGdLIIpDy+QkiUxN56CNi?=
 =?iso-8859-1?Q?qHKhmtgjBehsGy9nzgBw8V89YgdO9Tdbw3N8DhDe0CPTuZIEzVv32TCSuW?=
 =?iso-8859-1?Q?uEzod3odeRISvIp21AEDlfpX44f+Vq/60KnbOqEwAmZ/Dhg8R5xe/KsUxQ?=
 =?iso-8859-1?Q?oKW3B6eU+Ej21gD5O92equNyXLI3Njer4oQSf7qPZVov1kXUBbbs4q4OTY?=
 =?iso-8859-1?Q?rxGmhyIhRhOLECQj29GAtAjjs6bYUxMFYwe7GyoD9UtVDkU0DiB3KyvSqw?=
 =?iso-8859-1?Q?8CaNpeEkdhMcRFrt/EOCtj9fw1wU02wPsyPPEucgMp3ZRTSzI8wGeu/hSB?=
 =?iso-8859-1?Q?OvxLfyIDPzGbRp8etrYDlC3hnVBliULvbXgweC7eD5vL/O5n7zUf8xkvMi?=
 =?iso-8859-1?Q?JOnNSRzmvoa2go1L5OXTQRfnNcvAQLDMHSw3Qh4tsL2vFcHqTXyQWaDfC4?=
 =?iso-8859-1?Q?SdyP+G/I1ASrNHUj7ae4gGD4ElqrK8zbVJBFJ7cpt4li6boZEVyS3V37MK?=
 =?iso-8859-1?Q?41YyGhfDgzh9s/JaWZUpy40zCK0NvxcKX05K9raEInoEuzy2ICgPKRWLf6?=
 =?iso-8859-1?Q?83vy/S/fcI9c2qYEqdZ6shTpcy+3/qiXc6mwgFdQwqOdnuZGEPqV27D4pq?=
 =?iso-8859-1?Q?a+yL72kc/93oA7UmJM+azTQY00Oepd6YPDUmyiAjy5SQzpCyB7o565RqKT?=
 =?iso-8859-1?Q?2Yj4fOGY=3D?=
x-microsoft-antispam-prvs: <AM6PR04MB55922E5F48239A818636F25684480@AM6PR04MB5592.eurprd04.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(376002)(136003)(39860400002)(199004)(189003)(5660300002)(4326008)(2201001)(8676002)(478600001)(81166006)(81156014)(14454004)(86362001)(8936002)(50226002)(7416002)(256004)(1076003)(71200400001)(71190400001)(2616005)(476003)(486006)(11346002)(446003)(186003)(305945005)(7736002)(97736004)(68736007)(66066001)(36756003)(6486002)(105586002)(106356001)(6436002)(6512007)(110136005)(76176011)(54906003)(52116002)(99286004)(26005)(386003)(6506007)(3846002)(316002)(6116002)(102836004)(6346003)(25786009)(53936002)(2906002)(2501003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5592;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nQVkiW3DgIS65rjkpjn/5q36oNu6QdIsBFFicXS0GmcoJKVI7+szcvSL56CVsp4kiJIrEru8tiMQxLsVt4XLcjtlHl8XTkq83mwCRcsJYf7yiNay0yojtKUxpUcHRk2eTZoqMuA4tN1AJOAMK9MMfdqXTjouToSGBbztRU7Fu7jFwA221EpP2FZnF0GuAmxz4k39WmlkYleTm/sSQ6dc2TN8JiXHEfhv9kjwiBv717DXFRNQy4ZWgsctQvdyYrRzr5fLhIqpaS55RD3cAl0uk6yeohBenCAd+h5aHQcAhAeln7uAudBXULRF/f0OTghPDDb0ZuKcIjHs26NIf6O54GH45RjivRKeR23U/w2tJsjUfA7i3+YKm3a5S9WovHVPUiQunKmnYl8qw0EwF0LxPT37dok+ymy+B9ycOc3AYJM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0998542-8984-4c35-65bf-08d6a6044028
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 09:30:51.0276
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

As the .map_bus() use the WIN_NUM_0 for CFG transactions,
it's better passing WIN_NUM_0 explicitly when initialize
the CFG outbound window.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
---
V4:
 - no change

 drivers/pci/controller/pcie-mobiveil.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controlle=
r/pcie-mobiveil.c
index b2cc9c097fc9..df71c11b4810 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -612,9 +612,8 @@ static int mobiveil_host_init(struct mobiveil_pcie *pci=
e)
 	 */
=20
 	/* config outbound translation window */
-	program_ob_windows(pcie, pcie->ob_wins_configured,
-			   pcie->ob_io_res->start, 0, CFG_WINDOW_TYPE,
-			   resource_size(pcie->ob_io_res));
+	program_ob_windows(pcie, WIN_NUM_0, pcie->ob_io_res->start, 0,
+			   CFG_WINDOW_TYPE, resource_size(pcie->ob_io_res));
=20
 	/* memory inbound translation window */
 	program_ib_windows(pcie, WIN_NUM_1, 0, MEM_WINDOW_TYPE, IB_WIN_SIZE);
--=20
2.17.1

