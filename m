Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDEBC43381
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25FAB20850
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xUJHXxRb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfCKJcP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:32:15 -0400
Received: from mail-eopbgr80085.outbound.protection.outlook.com ([40.107.8.85]:48938
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727124AbfCKJcP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Mar 2019 05:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/a8qAlxeqJzSchfITzvJwR/7Avj4N4SKqgqIBpuQrE=;
 b=xUJHXxRbUcq/WXK5bOsZagJhPY0x9PGmcX6wxx37tHgv4h27ZdAOiNOk/iFNCNFclTF9YVTkrU7bzv1zahaI45juwAkSaJmlxSpYUZqBV8WS8CBSw9TRanjyn/vLGnO7nPoPNEbeyMh2/+3ngCHOXSn/XZnEFcoBVfz7MeG30zw=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB6566.eurprd04.prod.outlook.com (20.179.246.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.16; Mon, 11 Mar 2019 09:31:31 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7%2]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 09:31:31 +0000
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
Subject: [PATCHv4 12/28] PCI: mobiveil: move out the link up waiting from
 mobiveil_host_init
Thread-Topic: [PATCHv4 12/28] PCI: mobiveil: move out the link up waiting from
 mobiveil_host_init
Thread-Index: AQHU1+01OAPqrzT7sUuzybX31Yd4fw==
Date:   Mon, 11 Mar 2019 09:31:31 +0000
Message-ID: <20190311093130.7209-13-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: b552853a-3d70-4c14-8f56-08d6a604584c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB6566;
x-ms-traffictypediagnostic: AM6PR04MB6566:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR04MB6566;23:60oAHf54hxehkY0pxln2hx8EpStpSmFlGhumKGU?=
 =?iso-8859-1?Q?v8lxQagAbjVraZbEMAVe0f3cNvBye64V/4L1MGEPO2Z9bgosAapFOsVl74?=
 =?iso-8859-1?Q?S0WLzNtE/R3n8mZZgnvRWyWRu+Y7wxVqrC0VCQ1h9FpKz1bPFpYHW6yGrJ?=
 =?iso-8859-1?Q?tiS4rRp9LqYn1pGp653mznB83dlN6LnesKm+5CeIGsRnyFHYV7Dis86Vrf?=
 =?iso-8859-1?Q?OIJZSeCk+8QhKewWePjEaCY9ThTXGIkl2GMzY6Ihk4d4n+ZLBMN4awVNkE?=
 =?iso-8859-1?Q?gr4/rrHMiPbUO0MRWl515n1FNXxYjggHNpDrMhelDHzm+Z/2LX5e73fmGY?=
 =?iso-8859-1?Q?YQahoRAn8tEupEqKeXXzig8db2jThAN+bnDI41eQ7igUc0IU2V2ffwAuyu?=
 =?iso-8859-1?Q?Q7Go6dDiJGZ8cGj4lvSOGRjV6BuwTUp1nsoCX3dqoXf4sLBEtu/td36Go8?=
 =?iso-8859-1?Q?XfFCtHoAZm8JF5plqM2x/P8zIgrvZamIe0UokavKWnYisnZik8ix74LKsl?=
 =?iso-8859-1?Q?pIQUIE86Hx/ZBTWDy4rCo1s7eEtFQJBXlGtFpLa9gpFNJaCUSiVfFzFgPi?=
 =?iso-8859-1?Q?NL6HpUqQJ91V02A7mw2pQsmrk5A7t1j0O1Hz2ISABuMOKmEcSmDjRVod58?=
 =?iso-8859-1?Q?nX63jmLX2WXElrkjKjn06IOSfJsQXmbsIlFCsCgXbUNeE/A3sI7q52AlOa?=
 =?iso-8859-1?Q?zmwfKCC//nLUL/5/i+tpGSTh0VPdGNNsOrzOUUqbicWe9lMbJLaQZFkykK?=
 =?iso-8859-1?Q?D+i5eVZ76VxVqLCI3RaGqSw4SyDJZfCqK8CDMEUjItOpKV8NxcoR8/SFR5?=
 =?iso-8859-1?Q?f/aOBbCFvD7tSjD4nwp8bm/wzwFeNsKlxBiXxxhApeVuDueBcsMhefrG95?=
 =?iso-8859-1?Q?A+AMObZ8vsB3OF3xkYPZAIC+L9VR4UhIrNBL94KrXqReV3lp4gGX3QICtx?=
 =?iso-8859-1?Q?UKqJAfn2svoAW95MtiB8A8sGwIdNRkYuLowoiIpAmkbYELqfzDAw6dID5E?=
 =?iso-8859-1?Q?F+cGexh6/kvSwvYDaCMDPd3zZDSxw8V8lG+KSQzxT6Hon+knL0t3gi5UqJ?=
 =?iso-8859-1?Q?RB1CPUwpOS4rBLLkVlghUxoeZu8BCqCuRrvv0nclU23GXi26175/AF0SSY?=
 =?iso-8859-1?Q?+5jnvWkvNpXwWveoKGjNXGi6VOw/zqBo5bmA5IO3zrUbxD9M6o16mPuNVD?=
 =?iso-8859-1?Q?eP21muQBkUJdo14+wF5VRxdMoB2guvQ0FueDbb0v9UQpVBKkNrmxQFnzFV?=
 =?iso-8859-1?Q?xamNSeyKBgwSWlhczzuBs+JmthSGAHkhvAHsVVs4CdMFu0TATbjzSFK0bT?=
 =?iso-8859-1?Q?SUgW5cOYG07wVFz0rXixsyl3681PXQ7nexofzRE4dLTrEiIMdXacdvT6Cj?=
 =?iso-8859-1?Q?r8NxALK1NwFiqY3tDcI0yVFqeMV9mWlxX9PAxKvFAsx4YlhirGrl/0NDHg?=
 =?iso-8859-1?Q?PtptAaXjLeA4kaHfFv9KrTY1BmY2+y0h5oK?=
x-microsoft-antispam-prvs: <AM6PR04MB656656CC0B5309F36BFDB0E084480@AM6PR04MB6566.eurprd04.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(396003)(366004)(39860400002)(346002)(376002)(136003)(199004)(189003)(6436002)(478600001)(25786009)(99286004)(11346002)(2616005)(476003)(76176011)(3846002)(6116002)(81166006)(81156014)(486006)(71190400001)(71200400001)(2906002)(8676002)(2201001)(5660300002)(97736004)(6486002)(446003)(7416002)(2501003)(86362001)(256004)(14454004)(316002)(68736007)(26005)(8936002)(6512007)(53936002)(1076003)(66066001)(386003)(54906003)(50226002)(110136005)(102836004)(6506007)(36756003)(105586002)(4326008)(106356001)(186003)(305945005)(52116002)(7736002)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6566;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 65107GJjDvV2B7D6cFCLRZo4NlHsdBJ4RWxIoaVDlGzpOIcc30M68pVV9YNTPorHGqQ7mAzJviUZAtrQE7/am+37lCCItczF+oT2sZNCE6cyod82tTUtgZo0oD7x0toIje7LdClRDVMwsB28NvqWfrXnyOTnB8LKOP+RBzEP0n/W0x+URm6uprEx0VZawFaVWP0NykmJlVx8PyKQDDB40wncjHngQhpjZTBQDPr6e+MFDZRYJcIXdPWqiH23UbZoqbweCRR088laDcwlchMzRRwBofErRrN9Qg8C7LTxleWOrnivzCZ09kQJXemV8CpWx3KxhNTQUNw4BPFKvmYWe5PQKOIlCK6VMfaEjdDORCMYB0h66cGnwSOkg6O7SnGM8Ehcp5YbL0mLptbcdQVKk9FELhFk30QNak6E574leJ4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b552853a-3d70-4c14-8f56-08d6a604584c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 09:31:31.3328
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

Host initial sequence does not depend on PCIe link up, so move it
to the place just before the enumeration.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
---
V4:
 - no change

 drivers/pci/controller/pcie-mobiveil.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controlle=
r/pcie-mobiveil.c
index 8eee1ab7ee24..c2848c22b466 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -582,15 +582,8 @@ static void mobiveil_pcie_enable_msi(struct mobiveil_p=
cie *pcie)
 static int mobiveil_host_init(struct mobiveil_pcie *pcie)
 {
 	u32 value, pab_ctrl, type;
-	int err;
 	struct resource_entry *win;
=20
-	err =3D mobiveil_bringup_link(pcie);
-	if (err) {
-		dev_info(&pcie->pdev->dev, "link bring-up failed\n");
-		return err;
-	}
-
 	/*
 	 * program Bus Master Enable Bit in Command Register in PAB Config
 	 * Space
@@ -662,7 +655,7 @@ static int mobiveil_host_init(struct mobiveil_pcie *pci=
e)
 	/* setup MSI hardware registers */
 	mobiveil_pcie_enable_msi(pcie);
=20
-	return err;
+	return 0;
 }
=20
 static void mobiveil_mask_intx_irq(struct irq_data *data)
@@ -922,6 +915,12 @@ static int mobiveil_pcie_probe(struct platform_device =
*pdev)
 	bridge->map_irq =3D of_irq_parse_and_map_pci;
 	bridge->swizzle_irq =3D pci_common_swizzle;
=20
+	ret =3D mobiveil_bringup_link(pcie);
+	if (ret) {
+		dev_info(dev, "link bring-up failed\n");
+		goto error;
+	}
+
 	/* setup the kernel resources for the newly added PCIe root bus */
 	ret =3D pci_scan_root_bus_bridge(bridge);
 	if (ret)
--=20
2.17.1

