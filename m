Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA674C4360F
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AACD20657
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YMsp2PGj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfCKJcT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:32:19 -0400
Received: from mail-eopbgr80085.outbound.protection.outlook.com ([40.107.8.85]:48938
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727260AbfCKJcR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Mar 2019 05:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BMcqpDgTrc8M2YPv+PL29hYMDyvskZ4hrkMnMjLAqE=;
 b=YMsp2PGjsP1kO+lD7OpZcsjeBpGkLywXpme/k9S75A5KbaujfNNWynXdFI3g9yGkBEbQ4w3pY23FuU1Osi5L5J7sjSk8BVYv9VwC5X2X5c+KtQ3ktjlaJ02CU5UR6ObT7XV+UG4bZVrBIB9M7RAh1CHf+fJoPBHYK+AxJozwJuI=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB6566.eurprd04.prod.outlook.com (20.179.246.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.16; Mon, 11 Mar 2019 09:31:48 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7%2]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 09:31:48 +0000
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
Subject: [PATCHv4 14/28] PCI: mobiveil: initialize
 Primary/Secondary/Subordinate bus number
Thread-Topic: [PATCHv4 14/28] PCI: mobiveil: initialize
 Primary/Secondary/Subordinate bus number
Thread-Index: AQHU1+1AtGOoAU+YtEiiEyC+O3ktCA==
Date:   Mon, 11 Mar 2019 09:31:48 +0000
Message-ID: <20190311093130.7209-15-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: 6414e1d7-6e2f-4080-8d60-08d6a6046260
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB6566;
x-ms-traffictypediagnostic: AM6PR04MB6566:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR04MB6566;23:2nyWhzU/u3C9d3uUunmmxohN6ssX76Bta/GZzl4?=
 =?iso-8859-1?Q?2LdEThMKC44fQ82xbBPEPM8wwaI/yXhX/lrNbyqe5Pqt0poN+/yA8ZCQRm?=
 =?iso-8859-1?Q?goExoSngWJfIiwX+iNvRQCpRiW8az370thxqy0X8p0abt5Hc77Fz0aICrD?=
 =?iso-8859-1?Q?GPnjVudQH07OISyFSXFM7yuJS/9vOFv52nVw2dLTMGwI5q8/9GUqXtPSkX?=
 =?iso-8859-1?Q?MTAoISn4PSSty700UU45P7Fb6XMKbQpqaxTcZ6DN1SwSVdA97ICon1252/?=
 =?iso-8859-1?Q?39qScU/p08h43/75pjBUr6MXtv0ZDjDJ8KRMqnD8DDrBM5N7JWLdUoo0gl?=
 =?iso-8859-1?Q?OFAOdPbi5uLykSYzVraWO6PUfYj5yA8iLwGGaMYUW0OPxLjU05GV1wmM8q?=
 =?iso-8859-1?Q?QnQqtEgLckg51G26FGT90kz/eI0Qg/N3ENXUpOXhGfl9SdrlNM/YuJTIgD?=
 =?iso-8859-1?Q?PuObUwg/Wmzxz71Owg6AOM9byxhOE5uTxzPMTyujR8urSbMYPjhQ1rlmMv?=
 =?iso-8859-1?Q?fbGkWOpaAkEWO59CNTZ2m4qnc7vI9EZYxXViM4LgDCB8n7iljWT9AKMqBO?=
 =?iso-8859-1?Q?rPry43AgWErudx+mxLZGdQUoUye/XaIxeXmdMyJHt+GZrlaA83+eMfYrPv?=
 =?iso-8859-1?Q?oE0PTxg6w0UPsFDkiO5ropXoFIIHbn0UJ1pEIMGgXLnN7yV06Tl7E/m2Sz?=
 =?iso-8859-1?Q?OsnqokbmlRa3xkzV0ecXIPYAyMxfaPS9iawA0DNj9bw9W20v8dHUC/dl/H?=
 =?iso-8859-1?Q?OiDRJp4X3BG3By3DU+e/es7Kem26yMcAor8MQvITI99GG8ZV1KJgGEuAkn?=
 =?iso-8859-1?Q?+57YsGX/Wf4GWXB2ksC+7ZQF6fU27cCNQ+a0OCUwxRIdtiZUnuX/FPUYwu?=
 =?iso-8859-1?Q?RmcxLAdne3y3j0Wsz8iNI21l0UfsVhfy2sUymcJU8sk8nTyFj+EYVZoNPE?=
 =?iso-8859-1?Q?5WsxmCXIidCWsvEb1jP1V83EpHk6z06YrpJznV2D1Nv+WjF1YbjM635V4u?=
 =?iso-8859-1?Q?PYIsn8RycyA89UCW2HY3KDu6E2WrmpU7dXUDeu80ZVOa5mK1+IR5QMLqVj?=
 =?iso-8859-1?Q?Mehed152zWVmbfOqiB2+PTFr/5lefWZIv4ZpK1DFftHexpOzmye51BIHad?=
 =?iso-8859-1?Q?rU2QytymtlB6hMVefAkvgVx5tCynP1IeRqz4PUaLCrPIuojoLZKLVgPnxp?=
 =?iso-8859-1?Q?yiYJXk+DpOqScmf7XjdWQ+OvjWNNjW6oRpNWoKH2uTAnxogkt9cYuKUBPz?=
 =?iso-8859-1?Q?jI/ld6vIEYk9J/Y9wz0H4uAJubOeWKnkil04Yh6PtFr8H/3VRB7dG5tv/5?=
 =?iso-8859-1?Q?oCy1o6TYovYh95r6rY8WV0NIyioejH+Vbc7eT1h82XtwE24fAtQSUhPi4U?=
 =?iso-8859-1?Q?2RXP3u+I=3D?=
x-microsoft-antispam-prvs: <AM6PR04MB6566C252FEDE0F61848C687A84480@AM6PR04MB6566.eurprd04.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(346002)(376002)(136003)(199004)(189003)(6436002)(478600001)(25786009)(99286004)(11346002)(2616005)(476003)(76176011)(3846002)(6116002)(81166006)(81156014)(486006)(71190400001)(71200400001)(2906002)(8676002)(2201001)(5660300002)(97736004)(6486002)(446003)(7416002)(4744005)(2501003)(86362001)(256004)(14454004)(316002)(68736007)(26005)(8936002)(6512007)(53936002)(1076003)(66066001)(386003)(54906003)(50226002)(110136005)(102836004)(6506007)(36756003)(105586002)(4326008)(106356001)(186003)(305945005)(52116002)(7736002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6566;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZOG5AiK+viOkVXE2H2LgmFb1AB3q/Hdn5Y8vJL2fFc7O+UqiFJbUnxvqxdsx4+uE0FBK25pRnq2LmoNi0RoNpHnXScbwLP9DbdCDYuTnPcC40Z9wBdRK6TblG5nz9IXPSBX8dcsLMbkhzv9RkDeXyozcd2E0TLl68g+2jmyDbaB6PT7mkiomBE+rNEck7yl9/LhkGZ+NqRg9DPkXL8tQbKi8IgQBtIkY0xWWA8onvDW1MuTkiPzubu9h5j00ZWJHcUbD5bdfB3SQbM/tgH0IykjjNgxnkD37sUDiVNp19EpMg1u7qwuOU3YnUAKYt1XNo/GsFzy4LCAi0Q9GLOG7Tph55W2p4R4yxxel+E7e3632eeYeio3t/AciG9OfGHjkVPQSdM3u/VXK1X1trk3sqIyDoxW4qLmBDvKoXpBsfDg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6414e1d7-6e2f-4080-8d60-08d6a6046260
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 09:31:48.4531
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

The reset value is all zero, so set a workable value for Primary,
Secondary and Subordinate bus numbers.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
---
V4:
 - no change

 drivers/pci/controller/pcie-mobiveil.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controlle=
r/pcie-mobiveil.c
index db7ecb021c63..9210165fe8c0 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -582,6 +582,12 @@ static int mobiveil_host_init(struct mobiveil_pcie *pc=
ie)
 	u32 value, pab_ctrl, type;
 	struct resource_entry *win;
=20
+	/* setup bus numbers */
+	value =3D csr_readl(pcie, PCI_PRIMARY_BUS);
+	value &=3D 0xff000000;
+	value |=3D 0x00ff0100;
+	csr_writel(pcie, value, PCI_PRIMARY_BUS);
+
 	/*
 	 * program Bus Master Enable Bit in Command Register in PAB Config
 	 * Space
--=20
2.17.1

