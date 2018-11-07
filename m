Return-Path: <SRS0=4zPb=NS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D4FC0044C
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 10:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B12F320827
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 10:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="N/wU5tyW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B12F320827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbeKGTis (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Nov 2018 14:38:48 -0500
Received: from mail-eopbgr80050.outbound.protection.outlook.com ([40.107.8.50]:33632
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726363AbeKGTir (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Nov 2018 14:38:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PO6aXvTx9PEDBl3j8yMQvs7T2dGXFUiPS3YOtAwTqgA=;
 b=N/wU5tyWq8/awsbQpH8YfJRurncpkHBxmnv35aIMRy9RJ51vucWPGeKb8ch8XKVh0iFy6sbddb5Y6SzjV3bGAb3LLI5khC7GdRxp1YswGuOtNmV+/hVnsvxLZKVRCjcehRDxBvZljDCxW+Z04bwSHjW6oa6TY4rXcJeNwzDtNi4=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB5224.eurprd04.prod.outlook.com (20.177.35.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Wed, 7 Nov 2018 10:09:04 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::7d93:8053:57fd:1a00]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::7d93:8053:57fd:1a00%3]) with mapi id 15.20.1273.035; Wed, 7 Nov 2018
 10:09:04 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
CC:     Roy Zang <roy.zang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCHv2 1/4] PCI: dwc: fix potential memory leak
Thread-Topic: [PATCHv2 1/4] PCI: dwc: fix potential memory leak
Thread-Index: AQHUdoHpGzf55QFgZUifBzAS9plOMQ==
Date:   Wed, 7 Nov 2018 10:09:04 +0000
Message-ID: <20181107100854.28389-2-Zhiqiang.Hou@nxp.com>
References: <20181107100854.28389-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181107100854.28389-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR04CA0023.apcprd04.prod.outlook.com
 (2603:1096:203:36::35) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:aa::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5224;6:gGlRdu6jMGubMw8rT9eCGmGsmi6Ql6lSg+TwElppVRZOpeEa6cy0AEPefbptf2NQ/HU41Y4L89P5u0lHqEWlBRdbn6zq3V1b23TXdDUol6uCy1kHNv6NrRHl7hvGVWChKvntsNAH4I4Ejw+B2+k5wxL4kbjjriPQ/g5sI0lJFykp7axVpw04ITUp+oJ770ib1QgtdoOqC9VI9HFeweAuabaMsQ6IoAaoyP7eU5c5QG7Z7Z4J11lK0eCEk9LXgCIV3gYrjYcIkL78mT8xMgSR4orlmiQP6+qxP7mDPifhVfsGNyEr/pu24HtCTLlckHETQ8c2b2G1F1C5zYjg6BKGQjdo0bFHmzwh/G1rFBbcgivScmP7vRXfunAY0rppVPoCAYGQuxz4CsQEE1oj1X8R6OAfHqFRLNTrhCdT3Il+LNMPnmU7lixu/ThG+VBt0Im4Ey4sHA+ytWF7AD+CcLLfAQ==;5:yaKlNwhahdUl5SsbJyUiW/jCKj8GYZBGa59nzO/IDYr6+dtGVYlmOblkE0cJVrkAHFW9xgpOKZZ6WBUdr1rKhqhdQrZVj5M7Q7beVRJbW3jvlGiY8HXdv0UdjW9L1D0sL6K0jFSsr7AjWXicsfL5zsoyqE6/rEs6w7IRVaGDASs=;7:BxDioFn7z5LTYoXUyTHAGpu8MQuxEFQwuRpzsNTkkMYIHKtp85YB8ZWAuoopT/z41UR07ybt16gdb7xBIqyhzM5X0E2JjIgb6J8kqdDqAL1ZgAL7J7OVoYramZQpIPr1On76+RMRrGAOTb7F1Ub0DA==
x-ms-office365-filtering-correlation-id: d56a41e8-6eaf-4cff-802b-08d644990ba6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5224;
x-ms-traffictypediagnostic: AM6PR04MB5224:
x-microsoft-antispam-prvs: <AM6PR04MB52246FD60CA71601035ED65A84C40@AM6PR04MB5224.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5224;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5224;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(39860400002)(376002)(346002)(189003)(199004)(71200400001)(71190400001)(39060400002)(5660300001)(305945005)(2501003)(25786009)(386003)(6506007)(6116002)(3846002)(102836004)(1076002)(8936002)(68736007)(81166006)(97736004)(81156014)(256004)(14444005)(2906002)(99286004)(186003)(66066001)(76176011)(52116002)(26005)(86362001)(54906003)(2201001)(6436002)(316002)(2900100001)(8676002)(446003)(53936002)(2616005)(486006)(11346002)(105586002)(478600001)(36756003)(106356001)(476003)(14454004)(7736002)(6512007)(110136005)(4326008)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5224;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ihuIUNGHQiavdTlLu96K7jUzB9K8C1E1VvWUFhHDCBVN9z5fTElZue2jGaK2RUv87f7uLAZTC+lr4ByMvnZ/OEZWAOkQUS7OkTip/ZeGsSDAjxa6MulE3azO1r2pU3hpg3SSRNRPEKYzbm6JC5MEnTvwA9sT8lbY562t83U8F4iI9wMFts5pmYBEEZxqyeHWxeqaGuoXaqii7RX5kgdbI83xflWV33fOybVqTgS1Yko2gq+npFIpmPdcxEn5kD0dKYDimI9Gl0MBZkAI6bNt0YHgNPUl4NQvFPqUSAnufLdQCn7mZi5EqGtkIemqZHO6J0+82/Xz9PLN0gTWj1byfQlKwUA76NQbjOPWrNxrsUw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d56a41e8-6eaf-4cff-802b-08d644990ba6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 10:09:04.6157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5224
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Free the allocated pci_host_bridge struct when failed to get
host bridge resources, and free the resource windows before
free the bridge.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
V2:
 - Reworded the subject.

 drivers/pci/controller/dwc/pcie-designware-host.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pc=
i/controller/dwc/pcie-designware-host.c
index 29a05759a294..ecacce016489 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -353,7 +353,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	ret =3D devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
 					&bridge->windows, &pp->io_base);
 	if (ret)
-		return ret;
+		goto error;
=20
 	ret =3D devm_request_pci_bus_resources(dev, &bridge->windows);
 	if (ret)
@@ -502,6 +502,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	return 0;
=20
 error:
+	pci_free_resource_list(&bridge->windows);
 	pci_free_host_bridge(bridge);
 	return ret;
 }
--=20
2.17.1

