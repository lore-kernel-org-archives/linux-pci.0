Return-Path: <SRS0=ZPBx=RJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A407AC43381
	for <linux-pci@archiver.kernel.org>; Wed,  6 Mar 2019 06:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B5E20652
	for <linux-pci@archiver.kernel.org>; Wed,  6 Mar 2019 06:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xre9OwfV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfCFGJv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 6 Mar 2019 01:09:51 -0500
Received: from mail-eopbgr130040.outbound.protection.outlook.com ([40.107.13.40]:28089
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726210AbfCFGJv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Mar 2019 01:09:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLeyWLeFV7DZLkwCUhKFxFm/gdIQJniJMpyvwO3OhCQ=;
 b=Xre9OwfVurmi4jgnHJt1C7xCMSUSwvFrgIRmrV2YS61W+xv2odYBCEejhEUYG1zmAh6yQDUjAmS/aRYz262vaH9g9SXJR44QY5Le43ey7O2ZelqJbuoMRCA21wsPApGdZJaz+vmv3VOHT8KnQwz7nuxtKU0hyPdyRpLHoaRnFiA=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5320.eurprd04.prod.outlook.com (20.177.36.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Wed, 6 Mar 2019 06:09:46 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7%2]) with mapi id 15.20.1665.020; Wed, 6 Mar 2019
 06:09:46 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "keith.busch@intel.com" <keith.busch@intel.com>
CC:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCH] PCI: reword the description of kconfig symbol PCIEPORTBUS
Thread-Topic: [PATCH] PCI: reword the description of kconfig symbol
 PCIEPORTBUS
Thread-Index: AQHU0+MyOGOftpdVDkCGWdaM/o+RXw==
Date:   Wed, 6 Mar 2019 06:09:46 +0000
Message-ID: <20190306061026.25938-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR02CA0221.apcprd02.prod.outlook.com
 (2603:1096:201:20::33) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:ad::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e867c39f-e277-4a48-421f-08d6a1fa54d2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5320;
x-ms-traffictypediagnostic: AM6PR04MB5320:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR04MB5320;23:iQlw4Xwfq/7rQqY8gV5/I2iIcyiF1XCmmr3dnn0?=
 =?iso-8859-1?Q?Rppa3fttui18z1TgE5hGRJI/On0vO9d4w6zqENn/dXOU+qa8c0wgH63sd7?=
 =?iso-8859-1?Q?16U+kilLMuI1bSCLG8AtKs7Gz0aSTmBgJ31+l+80eWVdHbPAdQPeKtnuoq?=
 =?iso-8859-1?Q?NbxSH547UNKzx8X/nKhqwGvR/8Gh67nem3Zs4/iOtKdIabGoeeRULtN6+d?=
 =?iso-8859-1?Q?fuQG+UYOmaG3fLKUGQn3PpKambo5gKEb6ec8MmCJxcmeNNrJfpVpRngeQ2?=
 =?iso-8859-1?Q?IWYQ6lWBxYS7UP7vp6eSmudm14U3imn5PdtxOSrpgnq3KGePL9X7JtrPbi?=
 =?iso-8859-1?Q?9d5Z2HFqqxP9fhGNryeTMPzaRSX2Gbo/6uMldiSNTwRsv/LGGvjzEUYl8q?=
 =?iso-8859-1?Q?FEzMXqL3ShbTRXNZtCknJUSbipNGZgoFUM2phCedd3VFV/OVoR7BRyZDnZ?=
 =?iso-8859-1?Q?kwtXm5Rfc9pLcgPxqtFEtCd8xeHTK8OMkF5Gb31G8egZk88hq5RqIJb4oA?=
 =?iso-8859-1?Q?e28UbYffFzMquMkVBlHDZxyYexsKGCnBbFdI7xgurhdrbTRrUwA2qQw3DY?=
 =?iso-8859-1?Q?+AZlJ9JDB5LqJbxo+XjlvV/R7E7SjMTcliSZ/1Xpy80xBjlsf5QtGtrE/7?=
 =?iso-8859-1?Q?7Kwkhl4Q5YqPAMpQCf//1kNEDAyt5jE5Uh3VeNns5AVB171PJdggbA1eSZ?=
 =?iso-8859-1?Q?p2Qamma9t6WwJHl9goOgDcXp+A+PmuHOr8v9f6+mfdJxeopsAXg93fXBc6?=
 =?iso-8859-1?Q?8E4dmO71T33OmL93+BoZ4LtGDWX0wYCEw+gqabTTECVQaBSiyUrx/E4ixz?=
 =?iso-8859-1?Q?EmWhBMOJ/jEemShJ6LlqygdQ8lQEVxwnBh1IoZe3v/UCaqkOxY2sRwvwkb?=
 =?iso-8859-1?Q?RAwhjk6uqRkvZTFmFmWfH4IQJTXNCjL1rC3RyYNeCz5fPOQdJjqK8beTNr?=
 =?iso-8859-1?Q?bG9iSFu7MtiOVaMMGxskTpmB+fcj8j5IIUrJDoexkaDtKcNchAMGQ7Gpwy?=
 =?iso-8859-1?Q?MUzP5kCgBPRwrmjIQqVi3NTH3lteAG/KKA7VXvvhd54GBPIEOp8AuFr0om?=
 =?iso-8859-1?Q?FhAaFZLoWTQlZWaSjwYXbK7Gx7VuuWSWGTAJq+7Od3XXgKWkxqE0KBxbw2?=
 =?iso-8859-1?Q?YgTpXVbrff48ysmnHOjQdrE0RAesUwyvcyi+8awG4A3B8nMjCxmgvcXH2r?=
 =?iso-8859-1?Q?LdLsPtlS1e3N15ZVc47WaJf1clHBoXPtt4uZ1okLzv+UXNHL5KfEOWKZnJ?=
 =?iso-8859-1?Q?4AO985kc3+Skloph5?=
x-microsoft-antispam-prvs: <AM6PR04MB5320DDCDD2D1AAD92FBCB14B84730@AM6PR04MB5320.eurprd04.prod.outlook.com>
x-forefront-prvs: 0968D37274
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(39860400002)(346002)(376002)(189003)(199004)(256004)(97736004)(486006)(2201001)(68736007)(66066001)(316002)(86362001)(478600001)(102836004)(106356001)(2616005)(25786009)(5660300002)(105586002)(8936002)(50226002)(476003)(186003)(81156014)(81166006)(8676002)(6116002)(99286004)(2501003)(1076003)(110136005)(4744005)(6512007)(2906002)(53936002)(6486002)(7736002)(3846002)(14454004)(71200400001)(71190400001)(26005)(4326008)(305945005)(36756003)(386003)(6436002)(52116002)(6506007)(126953001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5320;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NrzC68bKjfx6Y+lNYlUaBo+Nr7ANUS6LJ7UbU4m8v/ki6Br1UGGw9aabT+JtWwbxxe0REmNYXn2uecBhFqr25+dVIl/kv5mIh66lFBLiLJCnBSiJKr2s6WVAaSMN68Eyavvk3nVQLade5NhM8wxgww5YpigKm59iXSmgzciscu/0Izc9xOyXoyjqw1KXDtZ6CY4vjDHJBdS4ta1WVJDa9n5wzSRmp8BA5kqiwmEfU5PdkfnxT9Qby01janLpyvjR302D+YISi0xhd2ahDl764DcTR6++Enqd3cbw8Cm7DNEkh84sX3d7+FZ9iQuIQdY5MFVNDSkCgaiOVVbdDtkDc4tqPdEWuonjUB2uG2PIcSvj8DQNa3qM+Kix2rZCPoKe49lsRsHrqhV3QVh1vVnlgxea/Cil5ilFe5lfknaedRo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e867c39f-e277-4a48-421f-08d6a1fa54d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2019 06:09:46.6793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5320
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The Virtual Channel service has been removed and Downstream
Port Containment service has been added, so reword the symbol
description to consist with the current code.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 drivers/pci/pcie/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 44742b2e1126..3b7c6124147e 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -8,8 +8,8 @@ config PCIEPORTBUS
 	help
 	  This automatically enables PCI Express Port Bus support. Users can
 	  choose Native Hot-Plug support, Advanced Error Reporting support,
-	  Power Management Event support and Virtual Channel support to run
-	  on PCI Express Ports (Root or Switch).
+	  Power Management Event support and Downstream Port Containment
+	  support to run on PCI Express Ports (Root or Switch).
=20
 #
 # Include service Kconfig here
--=20
2.17.1

