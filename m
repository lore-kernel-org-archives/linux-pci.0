Return-Path: <SRS0=ZQO4=QM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C61C282CC
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 00:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D18420821
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 00:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="VXle8e/V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbfBEARm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 4 Feb 2019 19:17:42 -0500
Received: from mail-eopbgr730126.outbound.protection.outlook.com ([40.107.73.126]:2560
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725917AbfBEARl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Feb 2019 19:17:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7h3EZ0HmYkXJjdIuCaxWqT43OnGBdb65kFXsTiikS8=;
 b=VXle8e/V3mWbWk3ZQslVrY5Sr8H5LX2fs2Y+G+C1uDp2NmEZBMrQ+B9AOilgQk0rxUHt+3Nlc2/pWyNtUKT+07JoxCSrpi6aSCYbs1Dz0bEirBDsi7GRKTpmjsV7Yi0eMH73zw6WRrzp8hf0HHEWGXQZEE0gNMQKRZ2SyrcLNAg=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3722.namprd06.prod.outlook.com (10.167.236.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Tue, 5 Feb 2019 00:17:39 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85%5]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 00:17:39 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Trent Piepho <tpiepho@impinj.com>
Subject: [PATCH v2 1/3] dt-bindings: imx6q-pcie: Add description of imx7d pcie
 phy
Thread-Topic: [PATCH v2 1/3] dt-bindings: imx6q-pcie: Add description of imx7d
 pcie phy
Thread-Index: AQHUvOg0yfKeVdvB5EO36YCp85y+3Q==
Date:   Tue, 5 Feb 2019 00:17:39 +0000
Message-ID: <20190205001721.18639-2-tpiepho@impinj.com>
References: <20190205001721.18639-1-tpiepho@impinj.com>
In-Reply-To: <20190205001721.18639-1-tpiepho@impinj.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0078.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::19) To MWHPR0601MB3708.namprd06.prod.outlook.com
 (2603:10b6:301:7c::38)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.14.4
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3722;6:n0U5M84G1nIa6rj2tsch7B91B6T1pT3Vz9gbTK/Tx2MrZpCGyX5YN+uyJMDlm9sN3IveOdzsY1plJqnIR24QrE+9uDUbAwdB3GcaZSe5i9Wm+Y+g90nzezIYj6MnhMhUOvoEVhBiYM70uLfiGXnHrSbeEYfQDjXL382iA04prJ9BuQ6npUEeTLvm1Je72gCFoWKbky7/JquYxF4bJ8qYPHZtBh82B/4mawFawoh8areklSyMmy2KA+pGbb7N3CkqTsQGC/pe+zgfhjSBzo+q0usmykd4W0uMqvUt1P7d4I6ve6smU7+ePKzjpUurF/bfN8iOLFx81+kxrtDcSAy0ZjT19i1tv6JFKI+QFx/mXob8YuD/ggFrsWv2r35ihLkv6rR9SYngyIMM/YvMRNv2l6s3E9S7WBaPS8D8RBsWtqtko98vejgN0NBMqb3aFPY5upXWB3AoPbw/vmf3J2bXDw==;5:Q4ZQgqRXH1agH+SKiRmsweW+rqwXQcBAjELNpbeI7+NdZUfyh0h+wXBDmZH7sKh5A1LYL8/Tz6BwKG7FqmU4Um63PnzN/Ed0ofaHyAmbGqk3zUUU48gtG1hZqgaFFYuONo61cPsLruAUtBOFxJQWRzi1eJGyjASs19kwGblDxuOjr+Dasw419fuVqpCLN0A/C2Pz+4572pEfbpfNlVBpIA==;7:1CC+MLHpuA08nK/Srxu3e4JrXC0/AMTStSS7c7PDC4haHCRgHBNPczhtvG7Fv/4lkvaHdMelfXi3OmJYl5h0nNervgFneJPl4FH9So63OTLpU/U0LCOpUF1p//j1vIczHUgKkQRRFHd4W6HRuY4xEw==
x-ms-office365-filtering-correlation-id: 598336be-130b-49d1-b2f7-08d68aff567b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3722;
x-ms-traffictypediagnostic: MWHPR0601MB3722:
x-microsoft-antispam-prvs: <MWHPR0601MB372230D178F0812DFB36FB68D36E0@MWHPR0601MB3722.namprd06.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(396003)(39850400004)(366004)(199004)(189003)(2616005)(476003)(105586002)(25786009)(305945005)(7736002)(2906002)(6116002)(107886003)(3846002)(11346002)(66066001)(486006)(86362001)(4326008)(97736004)(186003)(2351001)(446003)(1076003)(71190400001)(71200400001)(256004)(6486002)(102836004)(6436002)(26005)(50226002)(386003)(6506007)(53936002)(14454004)(6916009)(5640700003)(316002)(8936002)(478600001)(6512007)(76176011)(2501003)(99286004)(81166006)(81156014)(68736007)(52116002)(54906003)(36756003)(106356001)(8676002)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3722;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: L0Rwfd8xS3SAtKJysLGXBzpJBYvxSmm+hhu+2hcB+6bfP1f322ZKYXNSdraW1Zp8PRs5NB2SZtil/nyHLycIhwc5Us/9C8hb+rHBPhX0Sayy4nF9YIiT97h/6rg8vo7H/jexcnQEiRQ360VlXvib/17TM/JMPgq6uALKw1FBXGgoWWCgwSCsVL24/pksY7zbh2zoCJQ69Oyx4KuMDr13EV793U4WFT2Aw3m6nbpLQuU79WYmrkNwxzmEu/3eRYm1mkflmJkX69SEufSWO7dM2fTn5FycvLSG14pcCBe5yIayndHrdAp/P0X5KTQGY576775TzdVwMH9lO5WjvzEqeoWQS1uMNin2G3V2m0upLqhZp3KoId6WojDJdiyjfjsaTdHZUPZ7odwG4oalGtqQ5Rp1uD4Nt5tJB7lOQ2UaYc0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 598336be-130b-49d1-b2f7-08d68aff567b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 00:17:38.7831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3722
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There is a separate PHY device with its own registers on imx7d.  It's
currently unused, but a PCIe erratum on imx7d will require it for the
workaround.

Signed-off-by: Trent Piepho <tpiepho@impinj.com>
---
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Doc=
umentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index d514c1f2365f..f4933c8951bc 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -53,6 +53,7 @@ Additional required properties for imx7d-pcie:
 	       - "pciephy"
 	       - "apps"
 	       - "turnoff"
+- fsl,imx7d-pcie-phy: A phandle to an fsl,imx7d-pcie-phy node.
=20
 Example:
=20
@@ -79,3 +80,13 @@ Example:
 		clocks =3D <&clks 144>, <&clks 206>, <&clks 189>;
 		clock-names =3D "pcie", "pcie_bus", "pcie_phy";
 	};
+
+* Freescale i.MX7d PCIe PHY
+
+This is the PHY associated with the IMX7d PCIe controller.  It's used by t=
he
+PCI-e controller via the fsl,imx7d-pcie-phy phandle.
+
+Required properties:
+- compatible:
+	- "fsl,imx7d-pcie-phy"
+- reg: base address and length of the PCIe PHY controller
--=20
2.14.4

