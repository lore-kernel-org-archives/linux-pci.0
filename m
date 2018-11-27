Return-Path: <SRS0=/WWX=OG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FAEC43441
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 08:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C82220989
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 08:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fK6BJjM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C82220989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbeK0Tnp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 27 Nov 2018 14:43:45 -0500
Received: from mail-eopbgr40062.outbound.protection.outlook.com ([40.107.4.62]:56160
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728882AbeK0Tno (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Nov 2018 14:43:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozH8T2oUtKR9CuTkvOxEDqr41xlBAP4sYJszAZloRDA=;
 b=fK6BJjM+ovzhWyEpszkgbSXClP8Zjj/5AJmOze2Qs4omoXNb6bk22bRDdPOYmREafCN5CWNnUVfkxow/dUem2/viBMnWGB0BoSaBpKlRLsJnxEJtWXFiMY2RTOAlGHUAlk7ZwEeGgTP+6KmREBSg25sBZQziMmAKNTseVlfQzqU=
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com (20.177.49.14) by
 VI1PR04MB1454.eurprd04.prod.outlook.com (10.163.166.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Tue, 27 Nov 2018 08:46:33 +0000
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::21f7:a45b:3d8f:d16a]) by VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::21f7:a45b:3d8f:d16a%2]) with mapi id 15.20.1339.032; Tue, 27 Nov 2018
 08:46:33 +0000
From:   Bharat Bhushan <bharat.bhushan@nxp.com>
To:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "bharatb.yadav@gmail.com" <bharatb.yadav@gmail.com>,
        Bharat Bhushan <bharat.bhushan@nxp.com>
Subject: [PATCH] PCI: Mark NXP LS1088 to avoid bus reset bus
Thread-Topic: [PATCH] PCI: Mark NXP LS1088 to avoid bus reset bus
Thread-Index: AQHUhi2yh4+Qm28J50ixacdSn4eZIg==
Date:   Tue, 27 Nov 2018 08:46:33 +0000
Message-ID: <20181127083454.26560-1-Bharat.Bhushan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.19.1
x-clientproxiedby: PN1PR0101CA0032.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:c::18) To VI1PR04MB4845.eurprd04.prod.outlook.com
 (2603:10a6:803:54::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharat.bhushan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1454;6:plY3jUE282DD2R3nPE6isVXi7SlZL+M4Kd5xmu6w/ERTjWqCvE5ZHPqmjg7ndaUjCWHcRI78C4alwvVgLWtZslrovGr9x6tRRWC8WB8aF3tf5Dwo6LehS7fCirQDiUsiQ+KkrRXpM2B7Pew57zUTPNS4mEeaE684Ye+gwHN+bmSK0gbqHNzjV3tOz+kr2DX36qkvQtWq07Q7VIXKXp+2ELWREkRbN6p2v6ZntgoRB3BzriPOo6iZhaUgYm9gMmjUhTbmZYuh9JOjFKTxBD/vJCQsgVCbekTxzIVoHtiqHzxEk4N+sD0tDl139TMx4GV87nHqGYQc0yVSPYM6JchjwcOWZzXqZcocyrdBoT3UU9IcUvAPyuDTKSONPSpoJp8ehtnVOjAhb0Ql0yTF4JIz7lxZGRvn38TByuBExSuXUACsKWsK4mwrfHAiown9yrq+6aFFPGDmksxHkrBHTk+hMw==;5:YZcy9Sf2qilf7/xwO0kb5D8Yk1xmCtKysnXVu3zr5NMov0KsLQB2VK5i3xR1D301XagnTBfz10Glqi/ox+PzkC4/uc8yFeLHR+QGP9sfzSkcY1CAP4GI8MbgQw3yaGzsDtUgHLzE5B3T2fDEgtDNTFyBRISzIaQYGvdZomAFZMU=;7:I1fC+TgiaNWGbi/7ZPga884by33UReDYCjhb700jRFHyqMdmgn9J737qBFs5XVbxdWBK07N8kgKmcziBMq1z12DA5TLaDimOCr2K+8Ia6WRGFdq6oUq2+gbW5deyKI2RJbuYbPYAnnTCCLS75gRbkg==
x-ms-office365-filtering-correlation-id: a72cea3e-057a-4a74-76ce-08d65444d4e5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1454;
x-ms-traffictypediagnostic: VI1PR04MB1454:
x-microsoft-antispam-prvs: <VI1PR04MB1454A044BDCAF584822115FC9AD00@VI1PR04MB1454.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231443)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB1454;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1454;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(376002)(396003)(346002)(199004)(189003)(6436002)(5660300001)(66066001)(105586002)(256004)(478600001)(68736007)(6486002)(106356001)(52116002)(86362001)(99286004)(2906002)(81156014)(81166006)(102836004)(55236004)(8936002)(8676002)(36756003)(25786009)(386003)(6506007)(4326008)(39060400002)(7736002)(14454004)(6512007)(2201001)(305945005)(53936002)(476003)(2616005)(1857600001)(486006)(26005)(6116002)(97736004)(50226002)(3846002)(1076002)(2501003)(71190400001)(71200400001)(110136005)(54906003)(186003)(78486014)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1454;H:VI1PR04MB4845.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: P83iaMoYiKmhkp48nlItzCCDtBnDlmBcqLsrGpQaQdt9BUNvDmg/bBvyHFrW/qHLnBfAFN/Y/IgbdVlMr//o2gVd4xq1ycu0GjIkwSbARjDizLjkHiAC7/xvGRn543vKZ2RtYzdrdV56LO0Q0UA5SJ+EMs4XdP4mDxdm1zv7XaKwvZCH0iHuAt7CwaQkG3n4PN6fzHcq8QWZ1d72k5scUin4daFm0slXboAIVAs+T4g4vVCn3GPC9ch4XHUKUyJlsFBc5mP8MNgVlBqb9LAXxSHLKRA2mrauRSP2rWF3lfTwXY5Xd13QHfbpxRPIDCNwLrmSR3w1huPABw7Uzaje6eX/snh1ovHS/oZ4UITnOKY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a72cea3e-057a-4a74-76ce-08d65444d4e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 08:46:33.1602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1454
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

NXP (Freescale Vendor ID) LS1088 chips do not behave correctly after
bus reset with e1000e. Link state of device does not comes UP and so
config space never accessible again.

Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
---
 drivers/pci/quirks.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 4700d24e5d55..b9ae4e9f101a 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3391,6 +3391,13 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x00=
33, quirk_no_bus_reset);
  */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CAVIUM, 0xa100, quirk_no_bus_reset)=
;
=20
+/*
+ * NXP (Freescale Vendor ID) LS1088 chips do not behave correctly after
+ * bus reset. Link state of device does not comes UP and so config space
+ * never accessible again.
+ */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, 0x80c0, quirk_no_bus_res=
et);
+
 static void quirk_no_pm_reset(struct pci_dev *dev)
 {
 	/*
--=20
2.19.1

