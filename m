Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF47C282C7
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 08:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E41C9214DA
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 08:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NoLK8VB/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfA2IJF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:09:05 -0500
Received: from mail-eopbgr50047.outbound.protection.outlook.com ([40.107.5.47]:37312
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726371AbfA2IJF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 03:09:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGcJiyVkc3xxEnGyqK/MS/MGr3H6w3ZHihv4C2Mz1Qo=;
 b=NoLK8VB/Xsauo3431ct880ww5EaxWanoxmsnwc5zDKxZSQ1wz78icxyea3k/sBdIn5CvFSBd9pwwiPdqZVlpVxchvl1BK7OLjAbku27kYZTL3AOXzKArRtgLGYgq/1AZrQcS1WUD7ohlXA9c+txzz2VmdJpvKhRGaV0qx+Lv1cs=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5784.eurprd04.prod.outlook.com (20.179.2.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.17; Tue, 29 Jan 2019 08:09:00 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504%3]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 08:09:00 +0000
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
Subject: [PATCHv3 05/27] PCI: mobiveil: correct PCI base address in MEM/IO
 outbound windows
Thread-Topic: [PATCHv3 05/27] PCI: mobiveil: correct PCI base address in
 MEM/IO outbound windows
Thread-Index: AQHUt6njo/8dIEzJNUSJECMwf1ce9Q==
Date:   Tue, 29 Jan 2019 08:09:00 +0000
Message-ID: <20190129080926.36773-6-Zhiqiang.Hou@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5784;6:yplWEejb9LvGCg51xkvlMe8I0apa9DDn2v5nyg+BNKzwQmY0eRJe3o6S7dBNRq0IS5rO34ZVvWmkL0E3gz0zqXr5688uo99Mmv5grXpMpeOPIww2M4VFhkKnJiA4KEPnWt1SjO3D4d/E+EkiKZRxS2SuM+GxJSHKb0rvny+JYFHcp7QSJuiYtu1++BR0LNzGSwbNdJ1QI35zAO7jyR5oKKJIJ49+Bp4XhvlHi1mSm6VFOMPvHIGczlqeuN2LmWz4hlAQR43dKMAnkj0PWQUMCKJL1mn5/evGa5i8EHRWGPralKm29WhOujVyzy0bmTVaPVpZA3bQePsA+T3PlSn1wYwfxnrOtCv9tuS3k5eSzwQPOBcEVnkdkTzHE0uw4lzi/1/zHgJJjWEATHJKwV7A6P4ogpzJzAk5/u3ehM3pcZx2W03ImiXY57Pz0oUI4neNjprpaSZBXdSrxJb7ecsMPw==;5:IcDbxKu06bejDSm/+YenY+4JxIFLSdQGpoW8ty8fb7qezKXArza1HF7lg8L8tDwPY52TVMY1JdJwdW4cjTd6yB7oi3cPr68gAMCoEX2hjKailO+2SkvPnMifdFjffo+qaVMpg2LuPnopvz9r1T3mvPx1GDCGYScnRlb66xYPEK9Eh15AvAkadubMlatt5EUuAUhwhQVSdsZnq0W2aWXWTQ==;7:yBefuARMfYPAbv5QWfF/yySUcZorp3kb1hTVLBlmmFy7ocluNn3omK2liiuPQ8yymrR6pbxCOgvixmXj7Lv/PiA8IO1DfGGbwlB71oYR7tr9pUXaRWki7OyGjo1AZrIHgesH1dnaI+tmKiU3D9vBLw==
x-ms-office365-filtering-correlation-id: 8c992026-b464-42bd-45a3-08d685c1060c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5784;
x-ms-traffictypediagnostic: AM6PR04MB5784:
x-microsoft-antispam-prvs: <AM6PR04MB5784761420097FF096B582A184970@AM6PR04MB5784.eurprd04.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(366004)(396003)(39860400002)(189003)(199004)(3846002)(105586002)(6506007)(386003)(71200400001)(71190400001)(26005)(305945005)(66066001)(7736002)(106356001)(4326008)(102836004)(4744005)(68736007)(6116002)(2501003)(25786009)(8936002)(8676002)(81166006)(81156014)(50226002)(97736004)(486006)(256004)(476003)(99286004)(6436002)(186003)(6486002)(7416002)(2906002)(14454004)(110136005)(1076003)(2201001)(316002)(478600001)(86362001)(53936002)(446003)(36756003)(6512007)(54906003)(76176011)(2616005)(11346002)(52116002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5784;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3NuoO/u1QSb4VMWUxzBD0ZxjrGJ5ONQSs2g2NZLGuryYWbDzNSlCp2+EUxh/mbZVirtP3mYJOwvuzy39WuwXF8lRA7MZjN3xPZ3svaMAANU9Gol5GMDKfLYd/YpB9JBG4ZX9BQqMdflDEe1pR2hIzvrCrW9cfaZhx1f9tX1koK6JC3JLUvyKbSJTaYjoqhgUpc1jWDYOGtpVe8d3F94ADuai7ysTj+TKgntucEeLHQ+8+rRIZNMEkMSqYQPkojlGFNUwvxWFLjVb9ZYNX5SMMwblhwmFOufKsJk9mJq70w9EaLuENFFqnbAiOUWX4V1/2NwgS/JZI+NnupXP0GavQLtjJF93qKTmkV1yNEoK0ODEwP0MIw5bbh563U6zxqBEwHhGYPoTeCAMHIMzh+CAfdi+ZcO6nGpz/EshAP9s7ME=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c992026-b464-42bd-45a3-08d685c1060c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 08:08:54.0059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5784
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
---
V3:
 - No change

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

