Return-Path: <SRS0=vhAr=RQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A840C43381
	for <linux-pci@archiver.kernel.org>; Wed, 13 Mar 2019 09:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B1D2171F
	for <linux-pci@archiver.kernel.org>; Wed, 13 Mar 2019 09:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dQbx5G+9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfCMJPe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Mar 2019 05:15:34 -0400
Received: from mail-eopbgr00087.outbound.protection.outlook.com ([40.107.0.87]:17153
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726130AbfCMJPe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Mar 2019 05:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ACY8UKxThHLtfB2LecMNjUfa6IcTVkrwTsBY81hlqk=;
 b=dQbx5G+9tvFAXyv4rYZN0ntk3KGL2SHhURwMlT0OhO4uMcm/tkLcnrc7kSLvo9q8SKPcY0l1H8bAXTuGIb9uWrDVlU57AZqX4kRiEKRc8KQQaXHTr3sHVEqN1Ob1G17t48dRRhhDIBnS6L72APKMDMH+h4TQLO2pVM2n7gjL+7A=
Received: from AM0PR0402MB3570.eurprd04.prod.outlook.com (52.133.46.11) by
 AM0PR0402MB3732.eurprd04.prod.outlook.com (52.133.38.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Wed, 13 Mar 2019 09:15:28 +0000
Received: from AM0PR0402MB3570.eurprd04.prod.outlook.com
 ([fe80::c9e:21a8:3eae:bdeb]) by AM0PR0402MB3570.eurprd04.prod.outlook.com
 ([fe80::c9e:21a8:3eae:bdeb%3]) with mapi id 15.20.1709.011; Wed, 13 Mar 2019
 09:15:28 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>
Subject: [RFC 1/2] dt-bindings: imx6q-pcie: Add support for i.MX8QM/QXP PCIe
Thread-Topic: [RFC 1/2] dt-bindings: imx6q-pcie: Add support for i.MX8QM/QXP
 PCIe
Thread-Index: AQHU2X1M51QS3U2KCE+Hs+Chb2Dsbg==
Date:   Wed, 13 Mar 2019 09:15:28 +0000
Message-ID: <1552467452-538-1-git-send-email-hongxing.zhu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0302CA0004.apcprd03.prod.outlook.com
 (2603:1096:202::14) To AM0PR0402MB3570.eurprd04.prod.outlook.com
 (2603:10a6:208:1c::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hongxing.zhu@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8756f89c-6403-442a-08f8-08d6a7946edc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3732;
x-ms-traffictypediagnostic: AM0PR0402MB3732:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM0PR0402MB3732;23:cChCSknjkp9p9LrVYjyIbNo9U1fZIqufnKa3u?=
 =?iso-8859-1?Q?Yx1W5LkqBLM77YUhNLl23Vdvxfw6hH0d7gVKK55m8iixbFuxh6e/Xau9l2?=
 =?iso-8859-1?Q?blF3SqXFs4t6m3wtWZW/C+8vxMJ7Z8eezeit8BWb62bH00FLmzHzV7kqCZ?=
 =?iso-8859-1?Q?MHgdQXsLMwAJ7DEpRzG3yIcI7y1CGVGIfAl3Xqb5uSwhlPKIVEq1kRruHv?=
 =?iso-8859-1?Q?LSAMiSEi4VDT5zap6bP2mmni3CZZuxQY5NzawHFACb5ssLJPl3vs17+poh?=
 =?iso-8859-1?Q?6i+6Ms9dkVjFDmMMwaVza5vxhgFDc2/B7yKI5ChPqAu9xIPSnAz7Fw0hJH?=
 =?iso-8859-1?Q?kBnECvC9WtyL4doNwpri6BEMAHkE/GDW1mFEil1mkZi7u3+TZNadA3aXt6?=
 =?iso-8859-1?Q?jKjqPGARlwaXKnDuLktv5ccMr3P5ysk56c4iojGiMxV28Fj7ANicft04BU?=
 =?iso-8859-1?Q?8F3cAjoFWNZG2ATbCRXUZ0Y+r2gBU+vBEpWaEKKuc8iC62VDI46RMCHkts?=
 =?iso-8859-1?Q?V6rMMLtDGaumYm5ECFf0GU26807evFQmAnPcrzwLaPGSC0hRVhhQNEkeYu?=
 =?iso-8859-1?Q?wKCF+SCPZ9GPrwBth9W2K9s9vxXEgvyGhKjdDPGvZAyVq7nuC2/v9LV+Ar?=
 =?iso-8859-1?Q?y0ao/YsQx4fyNAZdv/OYdVpjZqLoDfoUtBjBD+9HeS8/owvdd/yKhkWzGS?=
 =?iso-8859-1?Q?Fk3zbU07IXjECrNbZnga2RlkpWKKS55jZONLxuR406q9Xs8ZAypBq1NwoV?=
 =?iso-8859-1?Q?COVyM78He2eACZLsjOHMSor/1zE9QTVWtg7rYx1f6E/P5fos8qh2+mXJq6?=
 =?iso-8859-1?Q?djjtZ/1rkaIBqDyv2ThJ9HDDLxgSVrKOLWS4IzSfFn7VpmQExfEjyfBGD2?=
 =?iso-8859-1?Q?nRIQEs0h1WH5kwSkCQvquBsgiLDTP1zD+IQpPMFz2x91VFiX3AfmbOOLqA?=
 =?iso-8859-1?Q?a3+MbfHuKjjCGWCbCRN/6CNe2lbrEoCloVPhRLSChEDkTrG35arpuVXs7e?=
 =?iso-8859-1?Q?8Oqv7bm9CowMwlBAdVZQd11XASwluEMLY5D9HrDUpwypPGzoZ01SCvj2sf?=
 =?iso-8859-1?Q?xSQ+XSzbr8AI+BwYym4WVdRp3ROKRCfD2Dz8WAg3j4/J4mdajBqr07+lFb?=
 =?iso-8859-1?Q?MV3ba/WBN6U1LtTm/fJ1gtrImd5SWaStetPGq7A0ogReSMmn4+vB0BuxPD?=
 =?iso-8859-1?Q?jfkYSL6KsfymiTLXB6jySym9C/+YQ2vQvTt0rTjOuolXIGDOeQaSH8Vtx8?=
 =?iso-8859-1?Q?dVNimYnbIUJRPkQkqXX?=
x-microsoft-antispam-prvs: <AM0PR0402MB37320E540B39FA2565444B8D8C4A0@AM0PR0402MB3732.eurprd04.prod.outlook.com>
x-forefront-prvs: 09752BC779
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(366004)(346002)(199004)(189003)(5660300002)(52116002)(102836004)(110136005)(4326008)(81166006)(81156014)(2201001)(8936002)(316002)(54906003)(86362001)(53936002)(25786009)(6512007)(68736007)(6506007)(2501003)(3846002)(14454004)(6116002)(8676002)(386003)(478600001)(99286004)(97736004)(2616005)(26005)(6436002)(186003)(71190400001)(476003)(6486002)(71200400001)(2906002)(106356001)(14444005)(305945005)(36756003)(256004)(7736002)(66066001)(105586002)(486006)(50226002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3732;H:AM0PR0402MB3570.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: X8FXy6o6Uq4IQIzORYkaE4KiYLOggAwt4JySoVpoLZGBniZ7D9ndklH0KbyYjA7TmNAy6AIktGxchteLmMvcdDupim3jvlY8gP3rUk9PyNls1z1HpVNyhkHt1E7fqJHxgX50iunouuKxFu4z6JuMgg7asu9o+X9TtGYCzXokSEjscs+OioGoSEtSsXMqbsECQcWRT3PcTtAvDTt/MjyWNJgMumK0Eck78o+8VU2xsKwUaMHdXOmUgowDVWU7WoeCuWDurfz8I73YPQb1H7fcDYHXk9jZ9pRH0IXIP/xy047d8FXcSMXng8GbNY/nIbC8jDr1O4STcwpfPopNB0eN0IUwjwAotL7RNettazrPHE9NabPifiFRiRQBxLQD0a/PmED8VJh8gawwCskkfHaYHxR57WQh4F0cVnpazO2GLio=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8756f89c-6403-442a-08f8-08d6a7946edc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2019 09:15:28.1549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3732
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add codes needed to support i.MX8QM/QXP PCIe.
- HSIO(High Speed IO) subsystem is new defined on i.MX8QM/QXP.
  The PCIe and SATA modules are contained in the HSIO subsystem. There
  are two PCIe, one SATA controllers and three mixed lane PHYs on
  i.MX8QM. There are three use cases of the HSIO subsystem on i.MX8QM.
  1. PCIea 2 lanes and one SATA AHCI port.
  2. PCIea 1 lane, PCIeb 1 lane and one SATA AHCI port.
  3. PCIea 2 lanes, PCIeb 1 lane.
  i.MX8QXP only has PCIeb controller and one lane PHY.
  Use the hsio-cfg property to specify the different modes.
- The HSIO address map as viewed from system level is as shown below.
  address [31:24]    Local address    Target    Address Size
  5F                 0                HSIO      16MB
  60-6F              40-4F            HSIO      256MB
  70-7F              80-8F            HSIO      256MB
  The property local-addr is required to specify it.
- Both external OSC and internal PLL can be used as PCIe reference
  clock, use the ext_osc property to distinguish them.
- clock request GPIO for controlling the PCI reference clock request
  signal. And should be configure OD when L1SS maybe enabled later.
- One more power domain HSIO_GPIO and clock PCIE_PER are required by
  i.MX8QM/QXP PCIe.
  Add these specific properties to enable i.MX8QM/QXP PCIe.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt      | 21 +++++++++++++++++=
++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Doc=
umentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index a7f5f5a..f7586c9 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -10,6 +10,8 @@ Required properties:
 	- "fsl,imx6qp-pcie"
 	- "fsl,imx7d-pcie"
 	- "fsl,imx8mq-pcie"
+	- "fsl,imx8qm-pcie"
+	- "fsl,imx8qxp-pcie"
 - reg: base address and length of the PCIe controller
 - interrupts: A list of interrupt outputs of the controller. Must contain =
an
   entry for each entry in the interrupt-names property.
@@ -38,6 +40,10 @@ Optional properties:
   The regulator will be enabled when initializing the PCIe host and
   disabled either as part of the init process or when shutting down the
   host.
+- clkreq-gpio: Should specify the GPIO for controlling the PCI reference c=
lock
+  request signal.
+- ext_osc: External OSC is used as PCIe reference clock or not. 0: Interna=
l
+  PLL. 1: External OSC.
=20
 Additional required properties for imx6sx-pcie:
 - clock names: Must include the following additional entries:
@@ -60,6 +66,21 @@ Additional required properties for imx8mq-pcie:
 - clock-names: Must include the following additional entries:
 	- "pcie_aux"
=20
+Additional required properties for imx8qm/qxp pcie:
+- power-domains: Must be set to a phandle pointing to PCIE, PCIE_PHY power=
 and
+  HSIO_GPIO domains
+- power-domain-names: Must be "pcie", "pcie_phy", "hsio_gpio"
+- clock-names: Must include the following additional entries:
+	- "pcie_per"
+- hsio-cfg: hsio configration mode when the pcie node is supported.
+  1: pciea 2 lanes and one sata ahci port.
+  2: pciea 1 lane, pcieb 1 lane and one sata ahci port.
+  3: pciea 2 lanes, pcieb 1 lane.
+- local-addr: the local address used in hsio module on i.MX8QM/QXP.
+	Example:
+		hsio-cfg =3D <2>;
+		local-addr =3D <0x80000000>;
+
 Example:
=20
 	pcie@01000000 {
--=20
2.7.4

