Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B080C43381
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A6A2084D
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jL2mSp/j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfCKJc1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:32:27 -0400
Received: from mail-eopbgr150051.outbound.protection.outlook.com ([40.107.15.51]:31294
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727124AbfCKJc1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Mar 2019 05:32:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IA7rcNmSSO5v+RL22C14TRn1KSNSUYVtFa/zfBl5cVU=;
 b=jL2mSp/jjJlaws/r44tkyT9pqv41pBm2tv/iFJIt0gzzv0JSFVsi01wthBtxFaE0o5gwiK2HnvGCw+Wfe9SI+d2LIxbhoMR29uZXTaTwpPbLjVEkfzDezooGl/eUVfZpIg9I013+4hWm0iIkNRZqCrcPtzKnYDVf0Z7mZhthu1E=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB4168.eurprd04.prod.outlook.com (52.135.168.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.20; Mon, 11 Mar 2019 09:32:22 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7%2]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 09:32:22 +0000
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
Subject: [PATCHv4 18/28] PCI: mobiveil: add link up condition check
Thread-Topic: [PATCHv4 18/28] PCI: mobiveil: add link up condition check
Thread-Index: AQHU1+1UyHtNENDYwUWe6uvqq5FW7w==
Date:   Mon, 11 Mar 2019 09:32:22 +0000
Message-ID: <20190311093130.7209-19-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: 919d5b8d-0311-4904-f456-08d6a604742f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4168;
x-ms-traffictypediagnostic: AM6PR04MB4168:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR04MB4168;23:7+/6dGO6dxmzi4X2oaUBWeHDxZ2aJuAL0pthg5M?=
 =?iso-8859-1?Q?r6tDjQLZK/wEtTptoTdGFyxbqTe50TZpqR3sGdfy420vYgbyoiev20Ww3X?=
 =?iso-8859-1?Q?58S4aI2qgqZB2Fpqu0dMK8FGVdLRvYZj2yiP7acxdEyP2zWJLs/J3c2+xC?=
 =?iso-8859-1?Q?DCvw7Ibhn4oISklEY3WW7RVViKa/DzCpCSEzQrb5bmMasQrTL7FVqGYLqE?=
 =?iso-8859-1?Q?llk3rhavJsdbY8RVOVZcQBFyf0VfGQZGBaP6qtwW2Q6uYUB3CzRYxL8gXM?=
 =?iso-8859-1?Q?rY0pMj6N6LQhmVfcYWOzOIsSw1QsDEelhvSPucW9bLKknbyIYwa65udc7L?=
 =?iso-8859-1?Q?fXc3ZJPwb9ipDI7QkT0Cx7iKoxp6MpUSXyuoiIcVntRsQJQPeBdhP7WLcP?=
 =?iso-8859-1?Q?7I7TN5y/9rNB/9Mjcjxz7I7lsKTD6HjNQ5eIVeiwI5sm8SyUG+fQ9RArDi?=
 =?iso-8859-1?Q?/xtG38iPfD1Zi0j/Am56caS3JkQoqaazKLOeBV0NM6MpUloA+YxW/nMa9I?=
 =?iso-8859-1?Q?RoGkUWPSCydEodDqYiXb2FcbJPXo/K4HJsSl34ZK/rnQLXdIebheJO8ssB?=
 =?iso-8859-1?Q?buAEjfZf7ZzOfJp89cLDzaEQP1t/I149wjiXswVC/rdW5T2aoqk/ye0dzS?=
 =?iso-8859-1?Q?Sis8rRIjv8SniBh/wuhM4DEWzFw7dBZejv21w3JqItwmfYWEGe2IY4gUoU?=
 =?iso-8859-1?Q?PRxXu5QmeCBMNEa/D+sDdEXYC0NJXiXyoih2ngqJxEpyWFqI5Fbbp86GE6?=
 =?iso-8859-1?Q?2o47ur4JRFAMyPBnBSGkY9bq1IbS/na6N3068j0aynhHEsF3RmZDMsh+fv?=
 =?iso-8859-1?Q?m32b3xVsq3Jm/z6ZrhscL9oJVE3tUTVgOz2CyArcHg3fYEJhR8vrzOr0Hi?=
 =?iso-8859-1?Q?6coXTB0afPkYaNmRPs/dXX6GWYgK1i+773o3K1j+ZanooRRoC+/bQF9tEe?=
 =?iso-8859-1?Q?HrxHtDyNGOZKX7NrvRhDNo/HkyJgK8cJBg2V6DPD337FVE6ulDBfsR3VtG?=
 =?iso-8859-1?Q?W9OvHhWb2/r7TGBxmnIZWxj+MO15r8VjXJ5qxJCkMuaRcZUi+IUVkFPV1g?=
 =?iso-8859-1?Q?WZRRmeKJuKn7qxQW84jslokkA068e4sLGX45W4rtb0BwhV0ZmOu9/mcgRW?=
 =?iso-8859-1?Q?2dsnrg44+UCpbtJOVoi/v3g/kCUoN3O6SrVQ1OPYoh29rtWJnFine2yZ1o?=
 =?iso-8859-1?Q?FnjV3+ravQ92w6LrGNPgUtZPjgTsSFOp7tlaI50hw4K9eDXac+ifKC5MRQ?=
 =?iso-8859-1?Q?OO3M5qm6NAPgtoNe36inkaOwg9r0ESLqt/DdqSDCuQPIDuxdq7Gm+qYxoE?=
 =?iso-8859-1?Q?1hyi8sQ0MJ6cYU58WqRxtEdtAL0TCdzRK+enqx0rcoO0ZcvbQ64X7u+mOA?=
 =?iso-8859-1?Q?rOGuxJRI=3D?=
x-microsoft-antispam-prvs: <AM6PR04MB4168578A3D5ECBA244BE205A84480@AM6PR04MB4168.eurprd04.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(376002)(366004)(346002)(189003)(199004)(106356001)(476003)(446003)(6512007)(105586002)(7736002)(486006)(11346002)(305945005)(256004)(6486002)(2906002)(25786009)(54906003)(6116002)(110136005)(3846002)(71200400001)(2616005)(2201001)(86362001)(4326008)(71190400001)(68736007)(102836004)(5660300002)(81156014)(36756003)(4744005)(2501003)(7416002)(6506007)(386003)(6436002)(97736004)(53936002)(316002)(186003)(26005)(76176011)(14454004)(8676002)(8936002)(52116002)(478600001)(1076003)(99286004)(50226002)(66066001)(81166006)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4168;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NUDGBw78AjQT5PDEUP9QVkWmdRWLWUnkPe61OyJUu+KqnUk9iYnWDop5aD3DqU+hPfsPtG/ew90SOl2l9/m5SfQOx109hk2OUgJaiXaaSCRQcHxeu8efQqhYDGuLZb1bm3zNttJy/znn486P3nHkAJntujr/nyKeiZnGkfE1j5QrvfsCgABYVUxTaPmFPusM4AdzMUR+YvLb+NPHIYPdMqInhxMnkT73iuy36n5nRKlgah+9ICqbkiuwkU4tZvooSFNrfEwojM9spfy7FVpwLsWIYdkV56hzsJJTXYj3kyh6e5wDepN9wL9lAGehJNhify4DDgB5p1Ny33orc+5MgeAvS5DeQeH+UyAwmYMKkNXg9u+v87dVCjPbS05bLZoQO3FyjSNkWcXHYbNPa7QPauMbTqbsh2q6W0gPVpo2bQY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 919d5b8d-0311-4904-f456-08d6a604742f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 09:32:22.8509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4168
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Avoid to issue CFG transactions to link partner when the PCIe
link is not up.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V4:
 - Splited from the 17th patch

 drivers/pci/controller/mobiveil/pcie-mobiveil-host.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers=
/pci/controller/mobiveil/pcie-mobiveil-host.c
index 74a14f05115e..1ae82e790562 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -29,6 +29,10 @@ static bool mobiveil_pcie_valid_device(struct pci_bus *b=
us, unsigned int devfn)
 {
 	struct mobiveil_pcie *pcie =3D bus->sysdata;
=20
+	/* If there is no link, then there is no device */
+	if (bus->number > pcie->rp.root_bus_nr && !mobiveil_pcie_link_up(pcie))
+		return false;
+
 	/* Only one device down on each root port */
 	if ((bus->number =3D=3D pcie->rp.root_bus_nr) && (devfn > 0))
 		return false;
--=20
2.17.1

