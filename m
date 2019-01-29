Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49B5C282C7
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 08:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675AA214DA
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 08:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="If737FFE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfA2IJL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:09:11 -0500
Received: from mail-eopbgr00074.outbound.protection.outlook.com ([40.107.0.74]:15418
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726371AbfA2IJK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 03:09:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWRF3y+yIg0qh/YwJ94M3l2NqInYWwQg2bIkHthvH8s=;
 b=If737FFEWxwSRImCF78MBJUGLAzXFXolse9cJThSQLmhg9xrSUc6UmGEAGDNOSwF5Nwh5xw1BvQ8J5WXM/oOZUQD4dwIcunzDVpn7TTZYyzjIEQLSv9YuECida4Eq9w+YpBG47XVwIt8CNQsz2/jRmXyEEARFvTipPL7IZTPTkI=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB4774.eurprd04.prod.outlook.com (20.177.32.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Tue, 29 Jan 2019 08:09:06 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504%3]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 08:09:06 +0000
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
Subject: [PATCHv3 06/27] PCI: mobiveil: replace the resource list iteration
 function
Thread-Topic: [PATCHv3 06/27] PCI: mobiveil: replace the resource list
 iteration function
Thread-Index: AQHUt6nndQPORYGGqUOoSJ3IZh1Uiw==
Date:   Tue, 29 Jan 2019 08:09:06 +0000
Message-ID: <20190129080926.36773-7-Zhiqiang.Hou@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4774;6:wptA+bDFKAyyXgd3diLKvznTn3lDwqQP4MD2cVegccD05lDD9v58VU668LzybWdBjQTSHGORtMKgwPnIXpXKyat9WU+6bwyJAqu56cSLrmLRo2QtWqPj/RvZgTyBkvQ/NqWV2SLq9QjLDGnUr2iAx7wtvZ/6xeecgYWEBi5UH/OnNa+fJUxuwvQ/f+TV+ldAshMDAhxxjSUJsKxoECWWz5MpNQn3GeLI/uanpL05yj9UvA+BJTofyLGffMjVEiLGdEm9RbYOavCG0bqIWbm2cURJHUhWMsNlSa2/16xykZstGJYqZRrKv3sKCAOPYNC6rxXniryuWOAdhCJGMWgkDBjFay/QVveZkzor+NwPwDxz9/DdlTZKD/gFypPfI4n852uFRKvlEa7ICDKNE11qlvZFPC0vXuY/RAve2t5n7AVx2shI7M4U6UG/XfvwY6zCoh7SA4jZn6YcOiYBNAahVw==;5:vzvrK2zrftHv3uKk4j2pTu9OOlOrBc/MGNITRCNRBzR9KYCF9Ygfzn6bE6CLhLo5hLce8BTCpiRdl1GWfNLl7esp2I64hKfsiJxg3zRxYdIr0hmp9+ENFJmNucYwbpU6UCFaFuX7pl3LeBz1J+UCA9VzuG5/Ywg/1mVpDDeg86l+X1UgesPJ5gct+apn1L2NfLSCYlxga51dtmStOFSHvg==;7:2BXEJu7fwDYNLRLrRFbkanzbEEMSl6X0e9nNmIU+6VvEZarZp9mkLwpK+vE1+LhS1rFlxbx8LBluc8+ytwBr59Z/zHfRmVHoP1+EIiJ9JuaZPEGPJ6xZMWMd2TWFtv8gOrX/q2BOpvMKnn2/O7mVzQ==
x-ms-office365-filtering-correlation-id: 1c16e84e-76bb-495f-f456-08d685c109e4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4774;
x-ms-traffictypediagnostic: AM6PR04MB4774:
x-microsoft-antispam-prvs: <AM6PR04MB47748CA9B04E3CB55E7C4EEA84970@AM6PR04MB4774.eurprd04.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(396003)(136003)(39860400002)(189003)(199004)(86362001)(2201001)(102836004)(4326008)(305945005)(186003)(478600001)(26005)(7736002)(386003)(14444005)(76176011)(71200400001)(14454004)(25786009)(6506007)(446003)(53936002)(71190400001)(52116002)(1076003)(256004)(11346002)(7416002)(68736007)(81166006)(81156014)(8936002)(316002)(486006)(6436002)(2616005)(8676002)(110136005)(54906003)(3846002)(2501003)(6116002)(99286004)(2906002)(476003)(105586002)(97736004)(36756003)(50226002)(66066001)(6512007)(106356001)(6486002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4774;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jJT7kXXkQJy10OmSkkGd+ZNb/Ih53KDn1/HuXwKdScwGZKiNtxrrwackMfeCdbCNmzrkRmMmozhtiHFN+wXJtfboJkvh47SZYCTUCydPziZnpLuz5lcW1vYkDn/nyWYXBx0Yrcp3e/09b+TY66wdDH2eO3eRHSoYogQ6h5dPs7kfcMHmBLCs6Bs82o7oR5ZFTFOaaTu1dPwHoObSyaqZSiTewUH0KK090fe7OCaRdEr+w32JIuGJ1wyHaH7vKsI9csL+2J4XB0ggwWagTIZa1WFR198au6bRrTZcOgfWCMLoPcOmm1TamYO6FqXMEXkDTWhY81W6hrR/2chUJ8RIv3e5a5zWCx2Hv/m+60jGofj19QtO9rikfsuiv8+eqx2JYQSPCU+gJaZIlnQZ409vk8XgXmAagn50SbGN8kvt4E8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c16e84e-76bb-495f-f456-08d685c109e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 08:09:00.4747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4774
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
---
V3:
 - No change

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

