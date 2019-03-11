Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBC5C43381
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 991C420657
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BtB3hBH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfCKJbm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:31:42 -0400
Received: from mail-eopbgr80044.outbound.protection.outlook.com ([40.107.8.44]:11104
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727026AbfCKJbY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Mar 2019 05:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJcuDyglLGprdVl2BE3RD+8Wv6VKcmTEEz+VNHfZ1Ik=;
 b=BtB3hBH+vTkqonbfIzgvRia6BeowzBdhB7q2fmVAQEs8BbITcZbkDJPZxMeQalz1RbdcRyJ0RWjgkoliBmuwF7aL1L12Fefclv/5GOhtQ3J4E3X2gYL831BGVGOTR1GRygL9vu1bIRJ2QPOuLdoXVO8+MOAHA4QFZRoXXzE2ODo=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB6566.eurprd04.prod.outlook.com (20.179.246.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.16; Mon, 11 Mar 2019 09:30:44 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7%2]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 09:30:44 +0000
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
Subject: [PATCHv4 06/28] PCI: mobiveil: replace the resource list iteration
 function
Thread-Topic: [PATCHv4 06/28] PCI: mobiveil: replace the resource list
 iteration function
Thread-Index: AQHU1+0ZNWwo8d+7skK9jlHtPc859Q==
Date:   Mon, 11 Mar 2019 09:30:44 +0000
Message-ID: <20190311093130.7209-7-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: 19b17bd7-4da7-494f-2cb5-08d6a6043c32
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB6566;
x-ms-traffictypediagnostic: AM6PR04MB6566:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR04MB6566;23:jS7vc8CzumKPfuTpSzI+H5gghYX3n3r01vBfaoa?=
 =?iso-8859-1?Q?Va4SkUIBv1xU+ZcMzPmugTxKSv/6qcPpIJ2h50y98YdwSYkux/nsLApukY?=
 =?iso-8859-1?Q?MKaFHBpFSJaLuRoj2pC7aYA+Z3/x263WzrGx51ZlaoJecVoDkykX/XrxE7?=
 =?iso-8859-1?Q?DZHS3roI9txOB/iyWPmHTyOpOYinPkVorUv90xkf4vdkL15WK6hQAsWVLv?=
 =?iso-8859-1?Q?t8t2WEbjm6zBl0M9Jshanlz4aYAVLTpnfPEDu/iUrzeCl4crtO44E1hpIr?=
 =?iso-8859-1?Q?3eJaqBN1W3nVmhiGDeDZlFiEkPrZyivaL21BR08swnBONtgesu3yxZfn2y?=
 =?iso-8859-1?Q?XiNjUJWDnjDbF8L1LDdXPfSOgj8MXx9YVNRwvtRVi/T8xxwp+VDJeGCecD?=
 =?iso-8859-1?Q?f4T+CiqTsMAzruHGSnz1uUcOjOa0H2y4GR3ROSyWR2NOOIo+W2kt97OV/J?=
 =?iso-8859-1?Q?tC/59TZLSWD0fFHeh+P2VNCCF+e2bkVckEM+exRGiGB1XOOA47jj9VKUos?=
 =?iso-8859-1?Q?g7DhhIoQb7VQRxS4tpf9jTYQ05o0qG/1VenQtPTwx0j03ky0bfdjksfnD+?=
 =?iso-8859-1?Q?YrqxyHbVl+Y+4vT2TSCB98QrNihAa8+wt8A7WYryLZIwIzEI7WxjZ6VrT5?=
 =?iso-8859-1?Q?djyO3Cqb6J0BaJB+8VWhZBdPSMEKjOEHrJRR8R0voPY00bma0MzJY5mubG?=
 =?iso-8859-1?Q?ZWn03Am9Egy+DE9BDG5G5vfXtqOsGYJtEa35ahRbXHkMu6TrgFthenUw8y?=
 =?iso-8859-1?Q?noHcTtxtsfW3S1lMh4nxMM3VE3GpRn4xL4a6hFvezlt0z982aLLEtMKKVQ?=
 =?iso-8859-1?Q?Gmcj5N3ozo/9HgQ+QqXjC5C9KsQkgA6/4LeCRtF8PyklVTzYbEUgbq6gCH?=
 =?iso-8859-1?Q?4u/XTUcOG31HlLFqw4lJQQaAwf8lJuu2sEc5WRCywdb6LMB/vqVGYUKGiJ?=
 =?iso-8859-1?Q?M8355SauwSoUHZmQiybkMVGfm01FMZ0DAAmskxug7j6YDFu4Lr9gYSmu4y?=
 =?iso-8859-1?Q?Hfda/ax8YcN1hUG74Bi0KeziavRSemkIv7VaOPKNrTSfBuUMoooLja537d?=
 =?iso-8859-1?Q?nhFSDK/vviPh0rd3vd86mufsn2jlktddISqzbnCLOe5qB1/uRRUdONtvoS?=
 =?iso-8859-1?Q?Z2OL9ANjU0dA0FKGyQoHPU9UD7RXod4+U+Kqfa21e/uENaOxUzb3Daxyln?=
 =?iso-8859-1?Q?E+0OYNciVWYke42zk/SwB5QvE1hEqA94HbsWKxXBRGLtbaqrUXcL1be/Yw?=
 =?iso-8859-1?Q?IiwE42B/cx6ES/SjkZ5AlG5o8bF/BDRLdf0kU6N5ZTm5uCc6+klmcJYu1Q?=
 =?iso-8859-1?Q?mFEY1LGyVSFz6rFh9JUUfZivYp8Om1oseJNa5Y9HJnSdDIJBU7Gb8HtbOv?=
 =?iso-8859-1?Q?UL6Vbapw=3D?=
x-microsoft-antispam-prvs: <AM6PR04MB65667D8ACE897735049F994984480@AM6PR04MB6566.eurprd04.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(346002)(376002)(136003)(199004)(189003)(6436002)(478600001)(25786009)(99286004)(11346002)(2616005)(476003)(76176011)(3846002)(6116002)(81166006)(81156014)(486006)(71190400001)(71200400001)(2906002)(8676002)(2201001)(5660300002)(97736004)(6486002)(446003)(7416002)(2501003)(86362001)(14444005)(256004)(14454004)(316002)(68736007)(26005)(8936002)(6512007)(53936002)(1076003)(66066001)(386003)(54906003)(50226002)(110136005)(102836004)(6506007)(36756003)(105586002)(4326008)(106356001)(186003)(305945005)(52116002)(7736002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6566;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: u5hQq8uzlu/3rzDabQ6ZtdTZ+OcDKeptbsWyn97gFWQUem6CKoy6eADOn8XPZMQiQijYujKXidHvCQ4p7RVo9RKv/rXaTb/T3nP+NXUFa93qMY0yCnGFCFDNzJyBGfIHcFEzUFHM9xJHKXOAOPelj4wHdm5QXtM7rgTizGVgKJfHCEv5d8l6gBgIS4jdFZEylAa0yZlZpUbc6M+cDm39UBOxFmvoAkzp+hK8RxGYCHMUnyU6s7/XyfwsG1G61/ecM3q9OhrNhQT4oEiDGSeEMlegRFQtw1VNxMiW2/U7rfMz9d5B1svFcrgf+WXMt19hPhE2uVwkiTs0CMj7bT6CCLj+waZJrmspjCd5JX+sF8TT0XUDFt41MwnzXEe3R5OvpY8aflf8nI4Rvo7stXxo8U98IsLnKfEcCLZd2UEefPI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b17bd7-4da7-494f-2cb5-08d6a6043c32
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 09:30:44.2136
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

As it won't delete any node in this iteration, replaced
the function resource_list_for_each_entry_safe() with
the resource_list_for_each_entry().

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
---
V4:
 - no change

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

