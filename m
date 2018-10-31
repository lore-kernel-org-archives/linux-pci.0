Return-Path: <SRS0=lbet=NL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06430C0044C
	for <linux-pci@archiver.kernel.org>; Wed, 31 Oct 2018 19:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BBA320664
	for <linux-pci@archiver.kernel.org>; Wed, 31 Oct 2018 19:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="ZguKEo/c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BBA320664
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725736AbeKAEuS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 1 Nov 2018 00:50:18 -0400
Received: from mail-by2nam03on0108.outbound.protection.outlook.com ([104.47.42.108]:17536
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725732AbeKAEuS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Nov 2018 00:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zO0hM3l8BOX+2qU7c7K8rDXvD3G0QX5jFLlh4u812XU=;
 b=ZguKEo/c22fRnnJxsQ2ONBfzZyTu6zJC2rCn+DMIu5a6KRo4ARihlvQgEi5Y9LieMMOBFkefv04A76i29YPH7vAFJ/jV4Px4517VGhIbc2H55R7M+O1HQ/0XuYQLx4QTPwvmwRCp133ITZFx50bUZE1SmbEMPq2iGKRhYlS/O14=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3626.namprd06.prod.outlook.com (10.167.236.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.27; Wed, 31 Oct 2018 19:49:59 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9%3]) with mapi id 15.20.1273.027; Wed, 31 Oct 2018
 19:49:59 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     Trent Piepho <tpiepho@impinj.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH v2] PCI: imx6: Check for link training status in link up check
Thread-Topic: [PATCH v2] PCI: imx6: Check for link training status in link up
 check
Thread-Index: AQHUcVLn2SF+98WimEGV8p2vodBEpg==
Date:   Wed, 31 Oct 2018 19:49:59 +0000
Message-ID: <20181031194944.19233-1-tpiepho@impinj.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1201CA0021.namprd12.prod.outlook.com
 (2603:10b6:301:4a::31) To MWHPR0601MB3708.namprd06.prod.outlook.com
 (2603:10b6:301:7c::38)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3626;6:ro9u2iEk/iOAeFOzFNv/Ch2Nh7RFMtjSoK8J6SpIwBTs8deAEQYpFBxHlvG5C0xwFBBTFZfdqN9eHlowGu1BGWp9j0LJuxkloku8A3kCKV7eYLWKtNNYAufdpaDOTl7zcsGKKx9Tm0+fK3z0XpZkCSOvgDR3Le5b18s8nEFS8ifCDDYHRD7SjyiZrUnfCTueLhJ6BtJEmxtm5XbxQ7xIyzw+dkaJOCeJtW8Qs9Tsxaau6cxuI/7bq8V5uTxflYru8Fe9fsJa8PJ0fWiN6aWIt3A9yICDD9Eh+hHVY3Be7Mt2sZSRdGIs99mElGsetT7Nm8FzOQ55+1NYv0uMyS0nqcda7+kPJ07bbtC/ZIXE3IHNECUjCcn8xhWt2G6pyGdXbWex8jdKmcgYwanlrLc0aZUsofQ4AFUr7qcUcSYEiMjW1o/lNt0xNsY41JJI3qjLTizYnkK+fZZYb8YxJStb2A==;5:Yaw265rzj0VHGLSwvG8v3TuViX7fAjU4pSiFQIrT02t62CX9xn+fn1MXk6RS5bBMJU1TIw79Yvmd+3WO6vPo2QmQSXC3z23MU+8wDb5wqWGlNnYiJ354N/mSv5UhmptFcOAlmIqg7sVSkOkC7YN167zIiF0JeXY5tLK5224IfmM=;7:/CM0qf4t5WRp5e7iSR90rEdRLBXo61S7bvEB1iCWVbvgit+zWKqLIO7S1k4/h7PLvodRP4lnJDlnxXhfl4oQsG4xLW95DLBFjH6soQX+29GN7d6uICAlxWAbN33j47Z7V6RABIRiNwfcBkljDz8DdQ==
x-ms-office365-filtering-correlation-id: 212c4faf-3cef-4bff-d300-08d63f6a09e9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3626;
x-ms-traffictypediagnostic: MWHPR0601MB3626:
x-microsoft-antispam-prvs: <MWHPR0601MB3626166CB3FB427A7101F93DD3CD0@MWHPR0601MB3626.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193)(211936372134217)(153496737603132);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:MWHPR0601MB3626;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3626;
x-forefront-prvs: 084285FC5C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(366004)(136003)(396003)(376002)(346002)(189003)(199004)(6116002)(305945005)(6916009)(14454004)(105586002)(26005)(186003)(8936002)(8676002)(36756003)(25786009)(316002)(5660300001)(106356001)(7736002)(1076002)(5640700003)(3846002)(6436002)(6512007)(2351001)(53936002)(2616005)(68736007)(486006)(99286004)(54906003)(256004)(476003)(6486002)(52116002)(71190400001)(478600001)(2900100001)(5250100002)(575784001)(86362001)(97736004)(2501003)(66066001)(6506007)(386003)(81166006)(4326008)(81156014)(2906002)(71200400001)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3626;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9mfA0XBGxytTyTpFmbLt7Sy6b2yVyEoXVi3w4VIjpKtHwGN9rkMpzf8dlc7gjYWMlv3/zhsxta+sJZ6hTHhBpYTv5KLO1Ag5tjPEvWiCM+5nuZjPCVdXDjdGmYIviAubnoQcGam5//ZlLzmwEY+alLLVwG7EdzgrRAG/OosvxQsCdbK9b+qPXEv77euXlrc6MzcmiccO3oDrOKiZ8YJW1gDgjDvUkRVrfeOE5+scuNmsf1J1niz5XGo8VLCmGQpxDM2/v7GzWAXHu+7VPUeKW942IvoUvEcF6SpSH6kcrGg5Nwys9KzrDIHUAPqDkZ6QeLsSbj3SeUbGv/hhtW2OXASrecf2BM56o4LuOfVpVCY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 212c4faf-3cef-4bff-d300-08d63f6a09e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2018 19:49:59.0389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3626
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This fixes a regression introduced in merge 562df5c8521e.

Prior to this the link up check done by imx6_pcie_wait_for_link()
consisted of a polling loop on imx6_pcie_link_up() (via the former
calling dw_pcie_link_up() which called the latter as callback), and
imx6_pcie_link_up() polled the link status register checking for link
up *and link not still training*.

This was a polling loop inside another polling loop.  And the outermost
loop was duplicated with minor variations in a number of other dwc based
host drivers.

This was addressed in two commits.  Commit 4d107d3b5a68 ("PCI: imx6: Move
link up check into imx6_pcie_wait_for_link()"), changed
imx6_pcie_wait_for_link() to poll the link status register directly,
checking for link up and not training, and made imx6_pcie_link_up() only
check the link up bit (once, not a polling loop).

While commit commit 886bc5ceb5cc ("PCI: designware: Add generic
dw_pcie_wait_for_link()"), replaced the loop in imx6_pcie_wait_for_link()
with a call to a new dwc core function, which polled imx6_pcie_link_up(),
which still checked both link up and not training in a loop.

When these two commits were merged, the version of
imx6_pcie_wait_for_link() from '886 was kept, which eliminated the link
training check placed there by '4d1.  But the version of
imx6_pcie_link_up() from '4d1 was kept, which eliminated the link training
check that had been there and was moved to imx6_pcie_wait_for_link().

There result is no link training check.

Then commit dac29e6c5460 ("PCI: designware: Add default link up check if
sub-driver doesn't override") added a default check into
dw_pcie_link_up(), which could have been used by imx6, but wasn't.  Then
commit 01c076732e82 ("PCI: designware: Check LTSSM training bit before
deciding link is up") added a link training check to the default from
'dac, but this code was still not used by imx6.

This commit eliminates imx6_pcie_link_up() so that the default
dw_pcie_link_up() is used.  The default has the correct code and is what
the imx6 driver used to do.

Fixes: 562df5c8521e1371f3cbd0b7b868034da376d714
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Trent Piepho <tpiepho@impinj.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller=
/dwc/pci-imx6.c
index 4a9a673b4777..975050a69494 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -80,8 +80,6 @@ struct imx6_pcie {
 #define PCIE_PL_PFLR_FORCE_LINK			(1 << 15)
 #define PCIE_PHY_DEBUG_R0 (PL_OFFSET + 0x28)
 #define PCIE_PHY_DEBUG_R1 (PL_OFFSET + 0x2c)
-#define PCIE_PHY_DEBUG_R1_XMLH_LINK_IN_TRAINING	(1 << 29)
-#define PCIE_PHY_DEBUG_R1_XMLH_LINK_UP		(1 << 4)
=20
 #define PCIE_PHY_CTRL (PL_OFFSET + 0x114)
 #define PCIE_PHY_CTRL_DATA_LOC 0
@@ -641,12 +639,6 @@ static int imx6_pcie_host_init(struct pcie_port *pp)
 	return 0;
 }
=20
-static int imx6_pcie_link_up(struct dw_pcie *pci)
-{
-	return dw_pcie_readl_dbi(pci, PCIE_PHY_DEBUG_R1) &
-			PCIE_PHY_DEBUG_R1_XMLH_LINK_UP;
-}
-
 static const struct dw_pcie_host_ops imx6_pcie_host_ops =3D {
 	.host_init =3D imx6_pcie_host_init,
 };
@@ -679,7 +671,7 @@ static int imx6_add_pcie_port(struct imx6_pcie *imx6_pc=
ie,
 }
=20
 static const struct dw_pcie_ops dw_pcie_ops =3D {
-	.link_up =3D imx6_pcie_link_up,
+	/* No special ops needed, but pcie-designware still expects this struct *=
/
 };
=20
 static int imx6_pcie_probe(struct platform_device *pdev)
--=20
2.14.4

