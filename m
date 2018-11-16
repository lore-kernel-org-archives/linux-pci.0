Return-Path: <SRS0=UeAH=N3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059E8C43441
	for <linux-pci@archiver.kernel.org>; Fri, 16 Nov 2018 00:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA9032146D
	for <linux-pci@archiver.kernel.org>; Fri, 16 Nov 2018 00:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="JTkJ/J8b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA9032146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbeKPKSl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 16 Nov 2018 05:18:41 -0500
Received: from mail-eopbgr680136.outbound.protection.outlook.com ([40.107.68.136]:53504
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726271AbeKPKSl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Nov 2018 05:18:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFzZQbGqBzsew26mtXhiDXjVuxf7XB/oh2BJE3lBf6I=;
 b=JTkJ/J8b+oTMH1eMqX56bO3ekKdo3y6T6A3xhQlNz5/81ON8NlZPeSch93iZEZX1C3onAIb1+xlixRj9LsGwTOyXO4Qu1id3WEuAOXB2mWxjA1RVSx1G1QB5XSFhmkHSQb9tSWf7SZQHOHaWf0VegNcK3RRjsALYqy77XJdtzFY=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3642.namprd06.prod.outlook.com (10.167.236.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.20; Fri, 16 Nov 2018 00:08:34 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9%3]) with mapi id 15.20.1294.045; Fri, 16 Nov 2018
 00:08:34 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Trent Piepho <tpiepho@impinj.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH v2] PCI: dwc: Adjust Kconfig to allow IMX6 PCIe host on IMX7
Thread-Topic: [PATCH v2] PCI: dwc: Adjust Kconfig to allow IMX6 PCIe host on
 IMX7
Thread-Index: AQHUfUCDRa6/ov2/w0OqBXIeNHRK4Q==
Date:   Fri, 16 Nov 2018 00:08:33 +0000
Message-ID: <20181116000803.5880-1-tpiepho@impinj.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0176.namprd04.prod.outlook.com
 (2603:10b6:104:4::30) To MWHPR0601MB3708.namprd06.prod.outlook.com
 (2603:10b6:301:7c::38)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3642;6:SCACotLrhMwYz9C4lPERKnip/LFYcuUnkBqq0DUpcjLlf/xvWGQfRdscfwdrjMzTBqHotu0tYrhFpgkQ56ri3fnRGVARThNBE1QTdxuNEbRYlKEN6LsUizPK6o4tp2BCs0L5CJ9Oh92YXoYjSPani8gkG9teQB7QlHQFPD+Xo1onruv4+V4b/FPNO3NqqY5YrxyKeyzPzorwMY21VxU+2KXQyTqCUuQdI0bBs1qZ5V4djctsj0UuGRnpOODL5JgHvyLoTCGEIrDgqChIlc9SU9oeE56EcxbJqYqbyurVB4mFiTxOQDBLpJcgmY5ZUQBlqoaj5CKZLhdwXhdRw2pUqvHAK5cTHKBuIlSOBDZ94wlyB7X9XnNnhrhK/Boxa/t0LwC4qzH3W3CmxoIjcJ5OA8J8wceRlW612XFd28FBD9w94d5ANzNDB3ZkUGicLoV3gaMebI0wNwULPBbRThYz1g==;5:7jaCUnXZP+HlfJljtNyHxWtnltwrwEICmsC+Y7j//i628ihBnCJ7+AtE7DV8V/83Rv5LUOBCy+mtvxwHyQFq/0fQqn6N+ztnmgZ+Ug9fOtQfOdbQVX8MDVuJbEDOylvZlJZjt0Sgud8Kgxvzmj+FXKeevfbeFbToh4Zj49ZJKZQ=;7:6YY3Z4DrYyJ6aIXPMvSVS8UF76ud5EZBXSw6eTHBEvol9xaTACQpKjR0CHJn5XLGw7AYGJkcJ+s6EFsDrZcZIKaiZx2Cz+8xStjJzX5QaiSoN5ur/awhbhMaQttbdy/SeHDRuypNNxgkiEAzpJypEQ==
x-ms-office365-filtering-correlation-id: 34bb0b46-816f-48f2-2634-08d64b57a5c5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3642;
x-ms-traffictypediagnostic: MWHPR0601MB3642:
x-microsoft-antispam-prvs: <MWHPR0601MB36422FA990033B7DAE2AED57D3DD0@MWHPR0601MB3642.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231415)(944501410)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:MWHPR0601MB3642;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3642;
x-forefront-prvs: 0858FF8026
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39850400004)(366004)(346002)(396003)(376002)(189003)(199004)(36756003)(2501003)(99286004)(6436002)(52116002)(53936002)(102836004)(6512007)(186003)(1076002)(7736002)(6116002)(3846002)(305945005)(5660300001)(66066001)(71190400001)(476003)(105586002)(6486002)(97736004)(478600001)(2906002)(8936002)(4326008)(26005)(256004)(25786009)(68736007)(110136005)(6506007)(54906003)(39060400002)(71200400001)(486006)(14454004)(2900100001)(386003)(2616005)(8676002)(86362001)(81166006)(81156014)(316002)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3642;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7aF6JGbdSVs95GGt1KthnkKVvOgoWPh/3PDL+mQ6kKYIpDa7+bpjKNNczPSM1u7Pp2+aJpKBi2LAzAo2ZIpheHkdKnBhwFkxjjOfpv1zDTA8gl/cOgCuLZ0KkEBMHfKcUf1xdASBGpYVS0DF6lM/MOmTgYl+1vpithK+4VIVZTwOJluX3mMnUmsZ0a7zlh49ral9cllpE7W6z7AmOulc8pI6mmpSnLAllpQeGnkFCzELJxEH7SzQY5UEbVylRUNPf8B5NBp7ss9DP/T8yyuvYsNlwgYgYb5GgKLKHuAG66MxY5cdU0iNm2qZc6sioWiFaz6gzUHbN1L4ZB2awrleA+FdpoTxbuYcAnemaqgo1Tc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34bb0b46-816f-48f2-2634-08d64b57a5c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2018 00:08:33.9496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3642
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The IMX6 PCI-e host drier also supports the IMX7d.  However, the
Kconfig dependencies of the driver prevented it from being enabled
unless the kernel was built with both IMX6 and IMX7 support.  It works
fine to build with only IMX7 support enabled.

Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Trent Piepho <tpiepho@impinj.com>
---
Changes from v1:
  Ported to current kernel

 drivers/pci/controller/dwc/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dw=
c/Kconfig
index 91b0194240a5..6aafec3fad00 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -89,8 +89,8 @@ config PCI_EXYNOS
 	select PCIE_DW_HOST
=20
 config PCI_IMX6
-	bool "Freescale i.MX6 PCIe controller"
-	depends on SOC_IMX6Q || (ARM && COMPILE_TEST)
+	bool "Freescale i.MX6/7 PCIe controller"
+	depends on SOC_IMX6Q || SOC_IMX7D || (ARM && COMPILE_TEST)
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
=20
--=20
2.14.4

