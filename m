Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9416DC43610
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 09:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E1C20851
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 09:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UI4Js3nf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52E1C20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbeKTTy5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:54:57 -0500
Received: from mail-eopbgr70045.outbound.protection.outlook.com ([40.107.7.45]:16489
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727477AbeKTTy5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 14:54:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCGh70nXCKmtSPXoh9FE7myom0psJbNczh4S1/7vMso=;
 b=UI4Js3nf1LJO0LLTMa6Jg9E+9X1oKzDzfrswSHVyW4cFJKGEGJb3/v8lJz7srP5yuv3qvqkmFnjsQVez87+uJyqi8e9w+L7Tr97icY6rLlfNpYHQpD7LD7CjBKbdD64TjgCtxplCP/2/cYy4WdPnjkrgHFP28M3nYhwq/GFPPkg=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB5269.eurprd04.prod.outlook.com (20.177.35.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.21; Tue, 20 Nov 2018 09:26:44 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c%4]) with mapi id 15.20.1339.026; Tue, 20 Nov 2018
 09:26:44 +0000
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
Subject: [PATCHv2 11/25] PCI: mobiveil: only fix up the Class Code field
Thread-Topic: [PATCHv2 11/25] PCI: mobiveil: only fix up the Class Code field
Thread-Index: AQHUgLMmM+e4UAw2tUizP6EGfGXfLA==
Date:   Tue, 20 Nov 2018 09:26:44 +0000
Message-ID: <20181120092615.11680-12-Zhiqiang.Hou@nxp.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR03CA0050.apcprd03.prod.outlook.com
 (2603:1096:202:17::20) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:aa::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5269;6:S7ZveHlWPmiJODZfx/EGQBWrx5L7lkAo9O3Y15n9si916rfis/N1xiWEymasiP0oE1RweLbpbhrSDm/RrlZ8qPuLBw1ZFVD3FwhtucjUSMrRmfQM2CHl+QTP0Mr+u+LWXo7l42ap/4ZZ+wRpCk2Gs8Z6O9xGI+ZdPhazoKHRcZNY5jpW1PytQi9Nfvb5eUcmmC3H7jd5F8OwbmkyMqvt/5xbn7nBo+ZWkKVEIY3geBLZDMv/kAiOto1N0j34k0Y8ML1HzCP/Ezt7v3BIVgN2IiHOJE4pOLY5I2v7gD2l3Q3D7ZEaMNqv31WxQbCNYjo07SmBiYCIaL0AyA2KB0c0LV8tODU1Ai49fCx4nQ+PbnANja/nkikTsjGELMvDd4qPELVs5bcsMTA7OnftQiSqmLq0tZhTU7xXNYrjI++XxmfUmOoiCBs9wbUKf5tq3E8Pv26atiIbvYzEZO2hQ6bBCw==;5:GgwQ5mcn4R7pWey8OTGg0xGlWsWtBaLEckdXJTf4G+s6xawZxBqK6S1XqHM1olZpkExeWMvR6S59czr73q2ymfljFWMQ/4RtdEObLIX7O4cZGpZ6H3IQc5b39vGZr8RyaQtd1z62CidrbSaNAZYNFDVoogymksdVlscaop1knHc=;7:aUMxZ6fE6eLN1D3hyy5J2jLoAY7GbfCnrtxX9+7Fb0KCeX/jIYOTypY4FkmqIutbJ6YASVt+DgiJ2TjEnupIbtAcr9tgmHPm/D33TaQgtZM1UNWGrUy/YRRg70WHgYv4p16ERrNZNs/IDoGchyO3LA==
x-ms-office365-filtering-correlation-id: f905b938-8619-4e43-db5c-08d64eca4920
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5269;
x-ms-traffictypediagnostic: AM6PR04MB5269:
x-microsoft-antispam-prvs: <AM6PR04MB5269C8043CDE7CA857F3304184D90@AM6PR04MB5269.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5269;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5269;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(366004)(39860400002)(189003)(199004)(305945005)(7736002)(36756003)(5660300001)(7416002)(68736007)(2906002)(4326008)(8936002)(14454004)(256004)(54906003)(53936002)(6436002)(71200400001)(110136005)(71190400001)(6512007)(316002)(2616005)(476003)(446003)(11346002)(486006)(25786009)(2501003)(2201001)(86362001)(52116002)(76176011)(6506007)(102836004)(386003)(186003)(106356001)(26005)(2900100001)(81156014)(81166006)(105586002)(6486002)(8676002)(99286004)(66066001)(6116002)(3846002)(1076002)(478600001)(97736004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5269;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Vnir+2ZcgJ4B/4bq0bXcwJGRHW6L27VQ3MEOCYZXiaO2gYBN5bVnH1QxVu+OgFy7a846zn4RYkkModRheUeV5pdA8jTjKpNgyDhxvar82qW0H/vbMM4lM9pnEtg/hHiiKqexThQbesjWWdQjw7FjPWeaMDUizobq+AtfKrVnQv5Yg76/U7r2smSTGa4/BtuM6SS2SXN70exeH++0Xb+6OWicNBoPPPF8pj6JJW1PSHritFdPVvBHwTtDFbIdKJHFqdT/kMRLE4J3PdLeQ2Q91aCqd1ONrBGrBfdPfXaBWyMrEYwF4tX/AwsGOKPlcb8PHhdo89GlupduxuZ2KiIJEDhDHG+qUvkTdNUt0MwkyPY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f905b938-8619-4e43-db5c-08d64eca4920
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 09:26:44.1754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5269
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Fix up the Class Code to PCI bridge, do not change the Revision ID.
And move the fixup to mobiveil_host_init function.

Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge
IP driver")
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V2:
 - Added fixes entry.

 drivers/pci/controller/pcie-mobiveil.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controlle=
r/pcie-mobiveil.c
index 78e575e71f4d..8eee1ab7ee24 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -653,6 +653,12 @@ static int mobiveil_host_init(struct mobiveil_pcie *pc=
ie)
 				   type, resource_size(win->res));
 	}
=20
+	/* fixup for PCIe class register */
+	value =3D csr_readl(pcie, PAB_INTP_AXI_PIO_CLASS);
+	value &=3D 0xff;
+	value |=3D (PCI_CLASS_BRIDGE_PCI << 16);
+	csr_writel(pcie, value, PAB_INTP_AXI_PIO_CLASS);
+
 	/* setup MSI hardware registers */
 	mobiveil_pcie_enable_msi(pcie);
=20
@@ -896,9 +902,6 @@ static int mobiveil_pcie_probe(struct platform_device *=
pdev)
 		goto error;
 	}
=20
-	/* fixup for PCIe class register */
-	csr_writel(pcie, 0x060402ab, PAB_INTP_AXI_PIO_CLASS);
-
 	/* initialize the IRQ domains */
 	ret =3D mobiveil_pcie_init_irq_domain(pcie);
 	if (ret) {
--=20
2.17.1

