Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A218DC169C4
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 08:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689A6217F5
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 08:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kWo7mVpG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfA2IJS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:09:18 -0500
Received: from mail-eopbgr60062.outbound.protection.outlook.com ([40.107.6.62]:22304
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726797AbfA2IJR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 03:09:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5BAdkEhrJMH8+dv8iY2cFT6nVwZnqdMYoU4MGgc9QE=;
 b=kWo7mVpGgjIcKatGv3ulejT2Lggxwno45mPbksRXnJsqVLrnwrRXJgnPl7Gsh/DKXHho9p4Fuhpws85fyUoP1AbQ/M9VoXL/QA9Zhrs4GK+bSwGqCF7cRg9PcRpBbl5Ss3B70cFAMrmfWBWQHj6lHmxw9Alo+k6E6s9Ub0UozrY=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5784.eurprd04.prod.outlook.com (20.179.2.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.17; Tue, 29 Jan 2019 08:09:13 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504%3]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 08:09:13 +0000
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
Subject: [PATCHv3 07/27] PCI: mobiveil: use WIN_NUM_0 explicitly for CFG
 outbound window
Thread-Topic: [PATCHv3 07/27] PCI: mobiveil: use WIN_NUM_0 explicitly for CFG
 outbound window
Thread-Index: AQHUt6nrKxupMxkXJUiatcGFBiTdig==
Date:   Tue, 29 Jan 2019 08:09:12 +0000
Message-ID: <20190129080926.36773-8-Zhiqiang.Hou@nxp.com>
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:203:36::20) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:ad::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5784;6:euk6gOArvVPiaE9GrBUqKpEsw2E85739cEmV23jNgrmKRJ8DErI5dpNF6SQ9HnueTWGUoCthbJPu1c9Y/q7BZ3nn8QFHgOSLLsMm6D54cLq0eWLdIVYdzq7gvqsFefpRdN0Xa9Q0dDuDatlTGbLesOvAIu9FYD7O2aaSguHreNVO/FS6liNP2rluEYOraShT+IuC//TsVFaKR8UyfwtwcperGHAHsFQmDlvhU+uaAtafdwC8DvbOCFfYRSfsgemB0cC5//RPf0EUW4wKnxPiiJX+Kgq6xTeg3/y3c2ZUG+YzIOZIPvCc9bP4ScUubNOQzK/41WMxvnO61L57/y7+AZAMv3eF+G60SKCMxALAtICPF2jJoG3cn38WT16qCSfyYYGDa8U4CXA5PZTSabTxZMx9o5uyJRcOX+OzF1vxXZMbg7ckLeDKpUQ+peUXsiZu4FcV5/q3WaLrilPgBF2xdw==;5:zl0WcdeZ6BmyBsXCBCw2MiZuY/2o/gJFpDDhCp6YBD21fznFTW5JTGuAPc54bs9CPD6TbyHyDGXaShPyBDlaan6Z8H5yLrlVqdb4B9NmTOJKhqtdwRTzl7XvNf6LNYq+0Tbemt3wkaeM1Y939tJ8wuvQgMpSsYtLMX/X34EnQF2NXrg7e716khndisDltDUncAcMy1bzAN5D1Ev/DS9KjA==;7:x8WSSiA+Y7irQUXxE+mO3BeU7sAglk30o8Q16buhQnM/yz5z35hVK4AdTyU25ODax9wC0S7ZQDTYJRaAOiev8Pr4MPsfaIZ3/XLSoFihYDibM/nlQZy9XIWFSx0f/g2OKdCNLTQlzg6ep9AdzUFkqw==
x-ms-office365-filtering-correlation-id: 3bedcdf9-7bee-491f-a347-08d685c10dbd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5784;
x-ms-traffictypediagnostic: AM6PR04MB5784:
x-microsoft-antispam-prvs: <AM6PR04MB5784466B51C2C246BC5B546984970@AM6PR04MB5784.eurprd04.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(366004)(396003)(39860400002)(189003)(199004)(3846002)(105586002)(6506007)(386003)(71200400001)(71190400001)(26005)(305945005)(66066001)(7736002)(106356001)(4326008)(102836004)(68736007)(6116002)(2501003)(25786009)(8936002)(8676002)(81166006)(81156014)(50226002)(97736004)(486006)(256004)(476003)(99286004)(6436002)(186003)(6486002)(7416002)(2906002)(14454004)(110136005)(1076003)(2201001)(316002)(478600001)(86362001)(53936002)(446003)(36756003)(6512007)(54906003)(76176011)(2616005)(11346002)(52116002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5784;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TudSq1fPlSYq7EKL3IZLoSulGtzf60RtfHdVypPb02ZLW3QFYe5Q4iHcZWBcXkJbCr8kwTnHfA1onT5HLz62ZJUCyFZkihBUS6RLhZrgqwdwxr0w/S1w8XqcXe+C6W54cACS0ZmlKG+1t7eT4WPXwc75l3xEj7b+M3hOVUoKXR5JHw6xg1UeJrtNjC1Civwjm9pEwrcXxSk/gLNRlAwYORXmVIoS7qOg8vOK1i2t+uz8SFsMl7mcQiU57+/DfH5BPYxfv7bej7GJ9RuMK5GY3FQJZwuEeaXUhY5w+k7keV5PAPZU22qO2BWsnFYb2mophGJ8dRuysnd1xb+Hy6v70kzcLWDvYd5nwDc95WhyvLQL5GKIC+ptTZ/txxIxoB/Wr33uIYCPhhdy84CPIBJ82wdcuD0Nt+vYkfw1gY2pYcY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bedcdf9-7bee-491f-a347-08d685c10dbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 08:09:06.9123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5784
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
---
V3:
 - No change

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

