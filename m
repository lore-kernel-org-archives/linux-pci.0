Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AC2C282C7
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 08:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D1421841
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 08:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FLKTYini"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfA2IK2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:10:28 -0500
Received: from mail-eopbgr130050.outbound.protection.outlook.com ([40.107.13.50]:6700
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727944AbfA2IK0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 03:10:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+tnkm0JpQRZ3iG5X2dYBgnyFYIjtyW90C35s/VTYPQ=;
 b=FLKTYinigm00iT7VRjSCVK9SCtjWw0IjTIosGCpd2yT2oDrode4RXCxy/LHGjot2P3DdzH4yl5mfWC4/FKwJ3lru5N/Wd4UA1V2yykLTAA560MJRZVMbb5YFEuYQDkSveMml3IRlLSuahNVBf/pLcosStc8IQ+6y2XrsADE/5GI=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5127.eurprd04.prod.outlook.com (20.177.34.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.23; Tue, 29 Jan 2019 08:10:18 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504%3]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 08:10:18 +0000
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
Subject: [PATCHv3 17/27] PCI: mobiveil: fix the checking of valid device
Thread-Topic: [PATCHv3 17/27] PCI: mobiveil: fix the checking of valid device
Thread-Index: AQHUt6oS419VgGFb5EOSmkHnfUrSZg==
Date:   Tue, 29 Jan 2019 08:10:17 +0000
Message-ID: <20190129080926.36773-18-Zhiqiang.Hou@nxp.com>
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:203:36::20) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:ad::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5127;6:o6Zntg9XVgJTXD5inO182Igzmfaf1066rJA0s39EaE1BhKwmaR6NvUrMlZHDP5QxIj+/t235kEIgWaKr8pQpahHU9d68QEZyc8xLeus6hV7Mon2Av4xw0YODGj9mHemgh2u06/ws2Z5KSvu+fMTvoeTg/kyaTCaVWJNLfwbkgTiumF60kd5ynBQv8J/5mdC6tKe0nQpMTbdI87FtF1YXBEKrlFWG7GWWWPduV95V0U5TNCQq82Yz1DmlPDab97IygAz6jaq5Nvxa9YyMgVXAzhcDWYtZTLSt0Z73BvTV2rGDi9N349gXIdrTfYXloC/Ga702UdCzCeaT+QZ+PhvalV+8P0CcmF9IPQO1kxZP1g9U3maWPoE28TN6LkfBk8LpIh8EzUdNTR+UY3FfGtPQlxxXCTG8iIhTOmaIF4tpjbpLpLC0Z+5FTHvoSukEbsw7PUg7lhG1eKz2ABGXeBh75w==;5:/MXUBOEalw6teUXoanm7J/rCDOhc0uTq7b7LCRUmpvDeC5cVKLOgLzzyMZPO36WHxTHLhKYSDLoqNZp25RE+asbB1FLAz4zYoyseA39iUM7djmyvc6ZCzyirMIrWOtvRkXLa+ZT49KBnc/HAPYqILZb/6qsvbHy67q8hKHL5wV+u35xxJHekYIMAqy/ZKD05KM98lGSYEIsbClz7+ogxgQ==;7:DU+fYyCxqWGF/Vz2+6Ltlf34AObB309AeJD/uuSFqAZzPIML0XthdC4s+q+EtqCxC1biNxjK0BHtqMlYJhvAYDDAEEzWI7e4Dd9xe7NGmKVY4WurXmbIKIldin7JYekec39CIuK0S89UYRwwqclBmw==
x-ms-office365-filtering-correlation-id: a75fd53f-5baa-4c50-73fa-08d685c13472
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5127;
x-ms-traffictypediagnostic: AM6PR04MB5127:
x-microsoft-antispam-prvs: <AM6PR04MB5127D6E3BA9E4E6C0D40E92C84970@AM6PR04MB5127.eurprd04.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(346002)(366004)(39860400002)(189003)(199004)(6512007)(8936002)(26005)(81166006)(99286004)(4326008)(486006)(52116002)(2501003)(186003)(97736004)(76176011)(105586002)(14454004)(478600001)(106356001)(6486002)(305945005)(54906003)(53936002)(50226002)(81156014)(6436002)(110136005)(8676002)(68736007)(476003)(71190400001)(36756003)(71200400001)(316002)(7416002)(256004)(386003)(2906002)(6506007)(446003)(11346002)(102836004)(66066001)(86362001)(5024004)(14444005)(1076003)(25786009)(7736002)(6116002)(3846002)(2201001)(2616005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5127;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /BVj3CLcnGkk/ju45vEo90gmE+crwfVcDfBObadyIaRODXYWcHd9H00C/qw8ZQsXsBPK4CW43QftKujtY8J/5ds+K37Cc8a9rs7+Wxps0iDvYj56mrC1PWCn5K38zlmoZfE0OoLRddSakIGCKWEcz84Zlht38l8eeZQGbyrSs9p3mWOashlbradFit3RayemKtx+6KNe5bgH8G/9n+RGnSooheiBAacKgmBjUT/dVUOSTJZonk3hVWWH358l5KyOEF2QGOT62bXWR+2R6PDyddtW69ljNKZ+HDacSrNDioLn4WMdqFTGP04ZlOKsOur2oNjfN4EdNi3hwq3Bx76Qt9aUkH7/s8XjBD4onhO58jP0gP62GgAoSrd1jBsk2MI/PjLaEGJLLjlpzXckUPXdDbZt/4kPTUQKNCrnwWB/YkQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a75fd53f-5baa-4c50-73fa-08d685c13472
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 08:10:11.7257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5127
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Avoid to issue CFG transactions to link partner when the PCIe
link is not up. And allow CFG transactions to all functions of
Endpoint implemented multiple functions.

Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host
Bridge IP driver")
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
---
V3:
 - No change

 drivers/pci/controller/mobiveil/pcie-mobiveil-host.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers=
/pci/controller/mobiveil/pcie-mobiveil-host.c
index dc5324d94466..1ae82e790562 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -29,6 +29,10 @@ static bool mobiveil_pcie_valid_device(struct pci_bus *b=
us, unsigned int devfn)
 {
 	struct mobiveil_pcie *pcie =3D bus->sysdata;
=20
+	/* If there is no link, then there is no device */
+	if (bus->number > pcie->rp.root_bus_nr && !mobiveil_pcie_link_up(pcie))
+		return false;
+
 	/* Only one device down on each root port */
 	if ((bus->number =3D=3D pcie->rp.root_bus_nr) && (devfn > 0))
 		return false;
@@ -37,7 +41,7 @@ static bool mobiveil_pcie_valid_device(struct pci_bus *bu=
s, unsigned int devfn)
 	 * Do not read more than one device on the bus directly
 	 * attached to RC
 	 */
-	if ((bus->primary =3D=3D pcie->rp.root_bus_nr) && (devfn > 0))
+	if ((bus->primary =3D=3D pcie->rp.root_bus_nr) && (PCI_SLOT(devfn) > 0))
 		return false;
=20
 	return true;
--=20
2.17.1

