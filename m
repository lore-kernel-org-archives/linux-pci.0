Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB935C43381
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C1620883
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="uOnGJeo8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfCKJcu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:32:50 -0400
Received: from mail-eopbgr70071.outbound.protection.outlook.com ([40.107.7.71]:26944
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727148AbfCKJcs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Mar 2019 05:32:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmHknRHL5Tu1K34Eox5Xkx+5cF3U4coO6Rlxd/TOVIk=;
 b=uOnGJeo8WYqndGfpINX1FFjwC02XtFDBo/uD4LlVopl2PvP2s2Bkn5YtSlA/SYjMaKSYRCFtKcaiK56cnhgQlXBMqeS3RMpmxhcB7lqSCGA5jYnlE3XsrzseabrN2LCrlL9V8BHeWziaAvbBDM5pV/rUywAvmgNINRCNfg2AlSA=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB6566.eurprd04.prod.outlook.com (20.179.246.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.16; Mon, 11 Mar 2019 09:32:33 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7%2]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 09:32:32 +0000
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
Subject: [PATCHv4 19/28] PCI: mobiveil: continue to initialize the host upon
 no PCIe link
Thread-Topic: [PATCHv4 19/28] PCI: mobiveil: continue to initialize the host
 upon no PCIe link
Thread-Index: AQHU1+1aTfTjlfwXvUuheVZYtTxEvg==
Date:   Mon, 11 Mar 2019 09:32:32 +0000
Message-ID: <20190311093130.7209-20-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: 73c04ad0-8c1c-4314-ceb6-08d6a6047c4a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB6566;
x-ms-traffictypediagnostic: AM6PR04MB6566:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR04MB6566;23:1bVwLqC3/94HUEDQeXwmn9uogQOE19evhZzjwhA?=
 =?iso-8859-1?Q?D7WA6+KLx/IMPRbsXHCzuN2NsuxB1EpnCZPX/fN/jhSFT4Fdqg8JbqYHFp?=
 =?iso-8859-1?Q?mOYbgSFcMXbsll9GSk9uhPX95zEUUskaf1X2vJMkj6eGHDHIoNVvMfPAKG?=
 =?iso-8859-1?Q?+5pm7MAH9pWKAUNds+M/Be2juvA8e7o9EXeDs7FpP5PYiGGNKu+s5MRzen?=
 =?iso-8859-1?Q?LX6lAEEdjPSoWFGan13mDRsl/TiXTEO5GIJFvOLn6DgWTBonXg2CsEaaM7?=
 =?iso-8859-1?Q?o/dMagkKBeiXyRLmVJj+4r14u/3loj7+tQS4/3lQc1uqRZx73TQen3NJU4?=
 =?iso-8859-1?Q?z2QV2dAK6zSBT94vaPNVSODDkB+tUKEFK5jTRgYWMR7kZV7sttES1T3UHg?=
 =?iso-8859-1?Q?fDsMe1U3zrBbUOIGLCvJLbDkbQQK2uh/HQijxbr8OL0L8NvEQ/XzqN4HY2?=
 =?iso-8859-1?Q?Zj4Jz/AmDNycIQ5UJotB8S+JEJ5MiRbSaoDOruA15AZRFKMrGMeNUFJ/U5?=
 =?iso-8859-1?Q?OqmLyaFmTgW8QfN/thgop4jO8OeU0+Tv730ZpmfOd//+2634pL/PnTZS+/?=
 =?iso-8859-1?Q?jJ5eORzmEC5DUGs/ZlEXvu+rclvejdd1YY8Q+B5BAeLh8krDRxu9dZff8o?=
 =?iso-8859-1?Q?Iuty3kUU6vXiYsWUtSQ76qt9HNCwhkS5eHDgLGWqqDZLi7zPvKTYVKZXtu?=
 =?iso-8859-1?Q?yGA2lY8WCQKQuAj9THDFOjSspHPFWOX+f+c6Ou7jvVze5fHwcVLePojs1R?=
 =?iso-8859-1?Q?P3p/Zg+/DvgQpUgBpw6e3kTODl8v+FVYEKmyEJGqa5z49oW0gG8T8ODXuZ?=
 =?iso-8859-1?Q?DurcK0QEBAtE8wGCLOJQAwt0yqZt2/hMJqgD6pIOisxB/8Fmj0ZXgABhaD?=
 =?iso-8859-1?Q?Pa1TOY1IMynQoytKpqJwoDrkYfCYIKjRlpjqbbcX2LJTacXB83D6jVSu6q?=
 =?iso-8859-1?Q?f3anItxSr9Db8XeJae9yuVA+dNmAN97YyaMJ2kHoKV7HxmRgTJ5ALjIwUN?=
 =?iso-8859-1?Q?GCDqxG3RWzvm/LpYe/Q4hq8b2PNo4BsF+ATEqrTO/sv8jEUw1i/hnMP3Vl?=
 =?iso-8859-1?Q?jk9FHiNrwcQI8FlUerP4KAMZJuIFWDJfw4UnKM76aP9FOaaOMO42YvX0bE?=
 =?iso-8859-1?Q?az5+8EUi4kATJ4yrPq2Ih/jshQK6s++LyVhLdghG6gsNdzsa0PlQxZ5sVQ?=
 =?iso-8859-1?Q?GP61bcnho56z3m10kMr3RKi3q4e5kI4uiwWGHxZ8PPhgrIjCk13ysO9cRb?=
 =?iso-8859-1?Q?+jNYc3Fo+XOhwV1tkltS4B7n4BhS9e/07Z0hHED2ecwg4vafT3+w4XDYOW?=
 =?iso-8859-1?Q?zqDfFD4qVPqsn6Y8qfMQqtKN00fSR18JNjk5tekZEe4GA=3D=3D?=
x-microsoft-antispam-prvs: <AM6PR04MB6566C6EA4FCC21119473C4EB84480@AM6PR04MB6566.eurprd04.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(39860400002)(366004)(396003)(189003)(199004)(6512007)(8936002)(26005)(68736007)(53936002)(1076003)(316002)(256004)(14454004)(186003)(305945005)(105586002)(4326008)(106356001)(7736002)(52116002)(386003)(66066001)(54906003)(50226002)(6506007)(36756003)(110136005)(102836004)(6116002)(76176011)(3846002)(486006)(81166006)(81156014)(478600001)(6436002)(25786009)(476003)(2616005)(11346002)(99286004)(97736004)(446003)(6486002)(2501003)(86362001)(7416002)(2906002)(71190400001)(71200400001)(2201001)(5660300002)(8676002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6566;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: E9KaClX+37ZmzVG2l7Egy/40AYmlbMjqb9yiDCscgjwwrFVy40eXY9hAppFugCuC9txto7B+O1jsAgQY9J3P0CQUFRCAoe7Vkqqjlw2F2mLvtoa71kz5Xs578UX6nNij44ZW+abSkIIrD93aDsGq2rYBlr7uYI8jRM2oYrD5Qm59z7mJnK8/b/rW0njnxlYuqePburaCsADPPeoEb06af+t2ltGeApnm4x7VOa4aaD7mVed7QQFkVZSOB7ElkHpxHpsPTLEWk7iagOeKqtV1Wfd6T2Zu8qxWwN/tdrWNWUL7GFLeVK5/IiJeyabM1EgmanI8B6jvq1DAmPp3u4apJHK4kAD0AW2RDF18eQIF5bRAt9Yt6TvQhIK0ab07x7jOdc9kp8V9Z/HBF9g+vqrsbqEzIwBSsMe0eyHLGbEW8uI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c04ad0-8c1c-4314-ceb6-08d6a6047c4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 09:32:32.9081
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

Sometimes there is not a PCIe Endpoint in the PCIe slot, so do
not exit when the PCIe link is not up. And degrade the print
level of link up info.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
---
V4:
 - no change

 drivers/pci/controller/mobiveil/pcie-mobiveil-host.c | 1 -
 drivers/pci/controller/mobiveil/pcie-mobiveil.c      | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers=
/pci/controller/mobiveil/pcie-mobiveil-host.c
index 1ae82e790562..d1765d572f44 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -596,7 +596,6 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie=
)
 	ret =3D mobiveil_bringup_link(pcie);
 	if (ret) {
 		dev_info(dev, "link bring-up failed\n");
-		goto error;
 	}
=20
 	/* setup the kernel resources for the newly added PCIe root bus */
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.c b/drivers/pci/=
controller/mobiveil/pcie-mobiveil.c
index ee678a60825d..370658d6546d 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
@@ -222,7 +222,7 @@ int mobiveil_bringup_link(struct mobiveil_pcie *pcie)
 		usleep_range(LINK_WAIT_MIN, LINK_WAIT_MAX);
 	}
=20
-	dev_err(&pcie->pdev->dev, "link never came up\n");
+	dev_info(&pcie->pdev->dev, "link never came up\n");
=20
 	return -ETIMEDOUT;
 }
--=20
2.17.1

