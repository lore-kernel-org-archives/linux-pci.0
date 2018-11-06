Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBB3C32789
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 13:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE072085B
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 13:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z0YgfWAX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE072085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388323AbeKFWpC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:45:02 -0500
Received: from mail-ve1eur01on0054.outbound.protection.outlook.com ([104.47.1.54]:27020
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388254AbeKFWpC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Nov 2018 17:45:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITN65Tw7kmahmu2x6f3Sa+TQdaCKzjrriWUPO8T6uzo=;
 b=Z0YgfWAXLaUCvN6AiPRg7S1b7d1rJpWS0Tiplbz1nhe40Xg0ilg7NU7LCduDYVzFy1MLSg8SjvLSmRVfIgWqtxr/yAeU/5he6VXUyosAefDCr7F7qmJtwo2ANSqjcrjlxojYNuhY2JWDTVtQas2ddNdNwseF88GERI7Ltdupxx0=
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com (10.162.155.27) by
 DB5PR04MB0984.eurprd04.prod.outlook.com (10.161.196.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Tue, 6 Nov 2018 13:19:45 +0000
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb]) by DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb%2]) with mapi id 15.20.1273.035; Tue, 6 Nov 2018
 13:19:45 +0000
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
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCH 06/23] PCI: mobiveil: replace the resource list iteration
 function
Thread-Topic: [PATCH 06/23] PCI: mobiveil: replace the resource list iteration
 function
Thread-Index: AQHUddNiS0TfUu12MkCKemU5AZPRtA==
Date:   Tue, 6 Nov 2018 13:19:45 +0000
Message-ID: <20181106131807.29951-7-Zhiqiang.Hou@nxp.com>
References: <20181106131807.29951-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181106131807.29951-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0008.apcprd03.prod.outlook.com
 (2603:1096:203:2e::20) To DB5PR04MB1221.eurprd04.prod.outlook.com
 (2a01:111:e400:51c2::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB5PR04MB0984;6:wGoSfKClWftm0958WpCUj4o8+E4PNjCqLWwvxBtfeLEKel+YFxaFdQvzqVlqACVaRMTIKyl00SJ4a5F18O0RCrbtVUlJj3w1xKxGNNvqzRFfCriI9rWsxhznaoKwitpSzqO3A1Fp9Lho5pcLoKAND7ihRpycOKcuPoDqmQ18J7lb4JF6G4uK416VZ7ikinWqQN1WKTkoxQ8sShp7w3/NAubhJz0bw5Qn/kAlqSV3nMVcy8KK1WLNfdO1ldxRjGqTu8QaDDNoJcCJqFZM/7H1sZtJlVTBQqOzagZ6NElMKzk43wmTaxflsdrW7viAq6siV/veqhncSW84qn+Rt6QNqI2oeWp/JYoyRXRkedkwbtjsQ6j6EcPhzgmSjOfcgSu4DfwFII/JsSOcQXAbAy6CPyNYllwVhoyOGUn/8Gj27ojeUmP2WfBiWTW7wHZ+6tpumCU1GC+ofptWU4R5wmMrhg==;5:RLLCFMK0RcvGVRHe275Y9NpcErdix8o9Gl1sw5PnBkICuUAIhwe8PBmtgWoLBVbuC+qvlz6N0VHxeRIWS9J56qZ7sJugbSv2WuQ6F5au7TA6FdILDXwl0mQ1P78r8clh67rFyJRqw75mxrFsKbwYjKQAILVfSAT4BjA2MLYQTAY=;7:ez+Nnfcz/mMqs/FcNpKISQ2cVXZikTmo0HJtDuJ5i9NTdB1a6SmXugacwnSdp3R8vJqIdrWbd99hqj3AKOtBm2gxTVcZ8oRxEBqgEXxIkjyV1rM1GvMih7aKrQPodOr/lFsrm9ft5NBh0x71LjiZVg==
x-ms-office365-filtering-correlation-id: 8519397a-8d7a-4b5b-2fad-08d643ea84a8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB0984;
x-ms-traffictypediagnostic: DB5PR04MB0984:
x-microsoft-antispam-prvs: <DB5PR04MB0984A17EB9A85217A377980584CB0@DB5PR04MB0984.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB5PR04MB0984;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB0984;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(366004)(136003)(396003)(199004)(189003)(68736007)(486006)(386003)(8936002)(3846002)(99286004)(71190400001)(81156014)(71200400001)(81166006)(53936002)(8676002)(105586002)(110136005)(54906003)(5660300001)(2616005)(446003)(11346002)(66066001)(97736004)(305945005)(7416002)(476003)(2900100001)(7736002)(106356001)(14444005)(2201001)(4326008)(2501003)(25786009)(1076002)(186003)(6486002)(26005)(2906002)(256004)(6512007)(36756003)(6116002)(6436002)(316002)(102836004)(52116002)(6506007)(86362001)(14454004)(76176011)(478600001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB0984;H:DB5PR04MB1221.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hLKPzKQoD9N3fRwLNFyZt3RMIC8/mE9U2W4vRTi5N6rdGntFWllQIwMuvIenrwwOzzEjApQlteYd8QUHJDvPkeg8/7X0VY183zDO6WQV5UElHwDvD90c1+SJWGEp7lswZlwB+N/DJO+9mX7qyQfH7WYfE3IR/zDZmGkpaJcyvD7W7Z32McHx1wQxC+fB8QLFbbQPiECSsLdGJatm1DbELt+aY5VJjOwHH3PEAnbGBRV5gYthN8hhc83FB8uuqicruv+Sjip8jOURd/VDiSEe+W714pfRi3FXDUpXLNOGwf5/NpuvfFRgxK8GKpFYUd8NenyNc6uqO+ehpjexH6aHvs/v9QWjb0R9mAcUqaTj0mI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8519397a-8d7a-4b5b-2fad-08d643ea84a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 13:19:45.2271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB0984
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

As it won't delete any node in this iteration, replaced
the function resource_list_for_each_entry_safe() with
the resource_list_for_each_entry().

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 drivers/pci/controller/pcie-mobiveil.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controlle=
r/pcie-mobiveil.c
index 8ff873023b5f..b2cc9c097fc9 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -569,7 +569,7 @@ static int mobiveil_host_init(struct mobiveil_pcie *pci=
e)
 {
 	u32 value, pab_ctrl, type;
 	int err;
-	struct resource_entry *win, *tmp;
+	struct resource_entry *win;
=20
 	err =3D mobiveil_bringup_link(pcie);
 	if (err) {
@@ -620,7 +620,7 @@ static int mobiveil_host_init(struct mobiveil_pcie *pci=
e)
 	program_ib_windows(pcie, WIN_NUM_1, 0, MEM_WINDOW_TYPE, IB_WIN_SIZE);
=20
 	/* Get the I/O and memory ranges from DT */
-	resource_list_for_each_entry_safe(win, tmp, &pcie->resources) {
+	resource_list_for_each_entry(win, &pcie->resources) {
 		if (resource_type(win->res) =3D=3D IORESOURCE_MEM)
 			type =3D MEM_WINDOW_TYPE;
 		else if (resource_type(win->res) =3D=3D IORESOURCE_IO)
--=20
2.17.1

