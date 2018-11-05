Return-Path: <SRS0=Hm5h=NQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A56C46475
	for <linux-pci@archiver.kernel.org>; Mon,  5 Nov 2018 18:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B952255D
	for <linux-pci@archiver.kernel.org>; Mon,  5 Nov 2018 18:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="h2LVBufO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B952255D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387658AbeKFDdL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 5 Nov 2018 22:33:11 -0500
Received: from mail-co1nam03on0092.outbound.protection.outlook.com ([104.47.40.92]:65456
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387595AbeKFDdL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Nov 2018 22:33:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mbf/yl2pvv0LzwX9BrBppMo9xpywyCz75bAesw5rLXc=;
 b=h2LVBufOeEvgAT4jqO8lLgWciifxTDEpk2yuSf3Nz7SyPyFbJYU9cSTkwyc+Y/dH/UYC0nLmaiplArRu5yslKsjq9EJB3mGZptf+sozWadD20jQU4Yc4h0i90Y55wNaUvafljT2YFodjn29Z+mHPIBcFZh6nxFvEVfSjDdfFbAA=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3755.namprd06.prod.outlook.com (10.167.236.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.20; Mon, 5 Nov 2018 18:11:37 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9%3]) with mapi id 15.20.1294.028; Mon, 5 Nov 2018
 18:11:37 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Trent Piepho <tpiepho@impinj.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v3] PCI: imx6: Check for link training status in link up check
Thread-Topic: [PATCH v3] PCI: imx6: Check for link training status in link up
 check
Thread-Index: AQHUdTL91W3lyQ/o7U6vC5FlfPYIwg==
Date:   Mon, 5 Nov 2018 18:11:36 +0000
Message-ID: <20181105181117.23230-1-tpiepho@impinj.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR01CA0041.prod.exchangelabs.com (2603:10b6:300:101::27)
 To MWHPR0601MB3708.namprd06.prod.outlook.com (2603:10b6:301:7c::38)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3755;6:82XSRBf4KPtZ9PcRpvZxKJmLzfg1XaqS3LMSWasLdktks4GxdeEiMuJjWQyOWbbLKnhM8MKrYVUFdZhbeJJEyIlksuIorf+al0zU0nnlMVR0WaB04cdHIDyyYITnXlhTfeowwjWji5ccK647IaBG5oPHimq8SSl0p6DQV6JX3BidsNAigmAQfjsdydebRQo2mwIQzsbZ8IBtx/ARfqwrze/ei/HLWUo227fnpeLcRJpBHTSfMB6f7kAlgyj6kHE39JHovn8c7M1lG/2nBKGhaTvwpgnucCWMRBYJmdSdyqJ6AI6slq+m/OdmCp3spidGHSJ6uwpCyAU1XHLYk2yULBTPgZ5bns88CViMGkAyVkb8lAba1k9a9CUMuTCzd2mSSs105UQTE5/J3q8ANLLuEZ55Zb59ygmu4F1tuC+mkJaLfRjWnINFbhBv2xJH/5lR5hCTCVCuDV36u1uVgjjXhA==;5:mNE0Ky+fQ7bq5kOlwt21U09oNYW/0a+/psFP4hHVEVJ7hIm98awRkbsdpTTv1Cx4Zv27diqnHHGBugYz972JOLosV7YrgEeZHk0oldwIwNsp7XGhOCJ6PvXKeHTIWQS+zONMUFXYcmg6w9vtBAoVB6ml4AQ8lR9Ix7aHI6LAWhk=;7:aWiWJj/pS688JBJ2ZW5toMpiixS7CorLlAStCTv+fStY6yCslrRQeuLOoczuF6Mj6IqG++iJSewsIjz7ItGxdOCldtT3t8K1sxxkMfgjqV6k/Yx3IgWpOoyjV1n/oJoi3HnO0+9LwyFKSw3Z2YqeEA==
x-ms-office365-filtering-correlation-id: ab50c71e-c012-48f1-7cb9-08d6434a200e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3755;
x-ms-traffictypediagnostic: MWHPR0601MB3755:
x-microsoft-antispam-prvs: <MWHPR0601MB3755566572811D228ADE8460D3CA0@MWHPR0601MB3755.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(211936372134217)(153496737603132)(180628864354917)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR0601MB3755;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3755;
x-forefront-prvs: 08476BC6EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(366004)(39840400004)(376002)(396003)(189003)(199004)(3846002)(86362001)(2906002)(6486002)(6116002)(6512007)(6436002)(97736004)(316002)(1076002)(36756003)(305945005)(52116002)(2616005)(386003)(6506007)(5660300001)(26005)(7736002)(102836004)(186003)(486006)(476003)(81156014)(81166006)(8936002)(8676002)(25786009)(71200400001)(54906003)(110136005)(256004)(2900100001)(2501003)(99286004)(71190400001)(106356001)(14454004)(4326008)(66066001)(478600001)(68736007)(53936002)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3755;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ThD8rO7Mzks/SGUPKKX8wIyxPVETBfXGbUCSV2K9krV+N9fNbCDPvmfM2itYk/SlXdcFYQ7ZyW6T57sy7FRhTubf4tDxwE3kxIm0TFKyTlDAfBOJ+zSAAbyCYDd4HoEodrr6I/IQxm98AUKZjJWcMJTwe539907FD3yWaEs9PSpHFH9o6cDPGtloMylqu6zLPXv7VJik5KXz3fT+kLRYfxZUHVY41nEScqKR5p1sR+a6VsDQEyGldG/whyKFmz5+nHWsoAJQ+/4K1Jba5PJEB9g4VRIJYTym16nn7YGuI16saT6uLsxZm2wf0pi2RllItb36xggSPShFX3ReYXMLT3rl42RDZjGa9807G6dAfXI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab50c71e-c012-48f1-7cb9-08d6434a200e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2018 18:11:36.8728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3755
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Eliminate imx6_pcie_link_up() so that the default handler,
dw_pcie_link_up(), is used instead.  The default handler has the correct
code, which checks for link up and also not still training.

This bug was fixed some time ago, but the fix was lost in the merge
commit 562df5c8521e ("Merge branch 'pci/host-designware' into next").

This was due to the interaction for two commits on either branch of the
merge.  Commit 4d107d3b5a68 ("PCI: imx6: Move link up check into
imx6_pcie_wait_for_link()"), changed imx6_pcie_wait_for_link() to poll
the link status register directly, checking for link up and not
training, and made imx6_pcie_link_up() only check the link up bit (once,
not a polling loop).

While commit commit 886bc5ceb5cc ("PCI: designware: Add generic
dw_pcie_wait_for_link()"), replaced the loop in
imx6_pcie_wait_for_link() with a call to a new dwc core function, which
polled imx6_pcie_link_up(), which still checked both link up and not
training in a loop.

When these two commits were merged, the version of
imx6_pcie_wait_for_link() from '886 was kept, which eliminated the link
training check placed there by '4d1.  But the version of
imx6_pcie_link_up() from '4d1 was kept, which eliminated the link
training check that had been there and was moved to
imx6_pcie_wait_for_link().

And the result was the link training check got lost for the imx6 driver.

Fixes: 562df5c8521e ("Merge branch 'pci/host-designware' into next")
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
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

