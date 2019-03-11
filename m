Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2985BC43381
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E43392084D
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="I14Sxy26"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfCKJcY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:32:24 -0400
Received: from mail-eopbgr80085.outbound.protection.outlook.com ([40.107.8.85]:48938
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727008AbfCKJcX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Mar 2019 05:32:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwQmuOG1mZDjPwBK/BZ1hEmqeje416sikwB+xbTSKZM=;
 b=I14Sxy26vp+AqplOiTtruqF87X8+vBBUBuzRT2bBBL0EKl3KqOiNvYJFKkUd4MtsIkpzQ8wOlx/K9pqC+Yp9uH0MZ+V5Jh6XCKq8eSGmOScAWrjDA/V67K99jag/oqma7rNgysSltsZaZKqrEIhn0b7mJ0K9vQz0L55RWe6FW6w=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB6566.eurprd04.prod.outlook.com (20.179.246.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.16; Mon, 11 Mar 2019 09:31:55 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7%2]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 09:31:55 +0000
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
Subject: [PATCHv4 15/28] dt-bindings: pci: mobiveil: change gpio_slave and
 apb_csr to optional
Thread-Topic: [PATCHv4 15/28] dt-bindings: pci: mobiveil: change gpio_slave
 and apb_csr to optional
Thread-Index: AQHU1+1Eh+uOewU500u0mr9dSGaHtQ==
Date:   Mon, 11 Mar 2019 09:31:54 +0000
Message-ID: <20190311093130.7209-16-Zhiqiang.Hou@nxp.com>
References: <20190311093130.7209-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190311093130.7209-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0015.apcprd03.prod.outlook.com
 (2603:1096:203:2e::27) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:ad::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aae8e711-33f7-4bcf-b7b2-08d6a604663f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB6566;
x-ms-traffictypediagnostic: AM6PR04MB6566:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR04MB6566;23:OsF4Ey4/7FW24eXF7PPRHeZpP93nIgCyhgPx+Ng?=
 =?iso-8859-1?Q?akXTI27mH3qTxbo7TBNGsibZmCSHLFqDYN3x9jNH2XHEBIbioL9ikhNpkU?=
 =?iso-8859-1?Q?XrLbEyQTXCfIZrL+tjwHOppce8JOSCQtKGMBvfzY/enwqvx5UiB7BZA2Hs?=
 =?iso-8859-1?Q?IRHd+yLsinqVHLRMFo2r/Z3VhgejE/1hsY05lqWevufivl0Cc0K1q0ZPvj?=
 =?iso-8859-1?Q?GMlZqn+vbEklrD76cfATIRoAC7tzVqQCjC81oDjpmvoVSx07QBj9IlX8dm?=
 =?iso-8859-1?Q?AkvDPufL18qEcKDAF/Ym53VKzdxyKlYx3Q4aTLBtCI1LrtqmahqO1Vaftx?=
 =?iso-8859-1?Q?hmYPuNstNH8WfUdit4HM6OOjkWGfGXyUcr7SI73hep+cwXlrvVQSDqdGdJ?=
 =?iso-8859-1?Q?5b4pIIKbIK/RfhmPKM42qkm7VgKFwDE/rwf7XKtClx7EMLaY5r/60ZlHw4?=
 =?iso-8859-1?Q?fw/rLPGJMqvN9FBhkwSgmgA03y5J69hYcaVQXI3V4ZWR0MRvD2YSt2BXXv?=
 =?iso-8859-1?Q?p0Ia5n+fwPiQ2fUGSh7kJt5x0qW3X+ijEM17zhYHY2BTZuz36OQ6AccBy7?=
 =?iso-8859-1?Q?xWRma017mnzy8HmX0+5+CVC5vIbFsAbc2VepiP41J5hxjTaJ+mNKgUm43X?=
 =?iso-8859-1?Q?UKRUtekcHsAroZ+49DI2MabE7HutZAX1Ujvdqq3gWHpD04lPVy7e/yPf38?=
 =?iso-8859-1?Q?VLkoogKNe0Knsynki8a/Aw40M6ECCWqL2bOEtAuwCcUkd9yRsgVuwMKfxK?=
 =?iso-8859-1?Q?QsIqP7M7IVAyvaWmzuOMbuU5jaZkIFHVg96k2PvRduvFZ9WjGsgMzGzKDr?=
 =?iso-8859-1?Q?0Qh765Vpz7J7I9xTEOwdFKDq5ge2hOuFPSrc74xEPJ6t5hvBiAefVrKDTN?=
 =?iso-8859-1?Q?SYc9Y7ALUsksXyxAF5HBzQdtuCKmGZUljUgbZnfbfXRwZ/jRl1N3Kp2tIl?=
 =?iso-8859-1?Q?OjI+JAq14ca1lLMafM7PyuK/vs932TbBhCdUrkWPIJVwzlNqZ136OoiNa8?=
 =?iso-8859-1?Q?GNBfstEdauYCK1+8TSE10rm1gJXlgcARdYxiv9r6oavmdkwEyA1Bodxzb7?=
 =?iso-8859-1?Q?Zd2QZ0RS9ZnS6Iwi7OUdLg0M22KjwwBoy9IQQ4jqDKTp8vKkZ5RrM+NITu?=
 =?iso-8859-1?Q?M2WOID0iVI5MCAdIwy2woCkRfTxfNqMAljDnrE3Woe6h09lDZ7iEEW+lZE?=
 =?iso-8859-1?Q?bzUgTUDaJMwzydfD05rWMYADmHNa/GudPQpYlc+DwCeJdJ8ywS40dqv59n?=
 =?iso-8859-1?Q?VOFJmHJb8cEkY7eJBEd0lfjFpJdIIK8BjyDsZSOUbflp07RBJwyfXdDuvw?=
 =?iso-8859-1?Q?EWS6MXR9ii2dvjmOP6ZMRCeVdS1emxsC1pWWazERtc02w=3D=3D?=
x-microsoft-antispam-prvs: <AM6PR04MB65664DAA445F5F8D7BBDFCA084480@AM6PR04MB6566.eurprd04.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(346002)(376002)(136003)(199004)(189003)(6436002)(478600001)(25786009)(99286004)(11346002)(2616005)(476003)(76176011)(3846002)(6116002)(81166006)(81156014)(486006)(71190400001)(71200400001)(2906002)(8676002)(2201001)(5660300002)(97736004)(6486002)(446003)(7416002)(2501003)(86362001)(256004)(14454004)(316002)(68736007)(26005)(8936002)(6512007)(53936002)(1076003)(66066001)(386003)(54906003)(50226002)(110136005)(102836004)(6506007)(36756003)(105586002)(4326008)(106356001)(186003)(305945005)(52116002)(7736002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6566;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: A5VUvjamFratLulhhIws1fJrgKiySSPopYwFXEhnw5MDSpqtmbfc2SyukLkSJJqvQEh3WWHszj9M5WWhhH3Qyx4+8x2w/wfRhq4ich2CSb+x5MgNGMsdtp+xVj8N4oRBu3dLTzS/0ogW9DOqLCBfnXh1oC6ZVjydKYQy129Se/aRAzMAJYoWfsKv4z6D+ewzwxP+1NgaKhsX/D0YPQDfHcO3T1qZgvnHs/0JiYYtjq+IW1EllmoY2PwlJC54S5xtAFmAj+ZXJ0EY7hsaJZt8Cd7OQulJ+EVC+YP7H1jzU7V40S2LvM6vHqR8bIEW4hXfcO4Tc8PvuZ0MRYF5IOSi12qXH7GyE6zcP1t3rc3RJDCcCLX0xl0cCRcdLpjB3pCli+ftzdNcjn/KrexgSBTgCDKeQzGPEnEcfjrJ8fJnvRo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aae8e711-33f7-4bcf-b7b2-08d6a604663f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 09:31:54.9729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6566
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Change the "gpio_slave" and "apb_csr" to optional, the "gpio_slave"
is not used in current code, and "apb_csr" is not used by some
platforms.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Acked-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
---
V4:
 - no change

 Documentation/devicetree/bindings/pci/mobiveil-pcie.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt b/Docu=
mentation/devicetree/bindings/pci/mobiveil-pcie.txt
index a618d4787dd7..64156993e052 100644
--- a/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
@@ -10,8 +10,10 @@ Required properties:
 	interrupt source. The value must be 1.
 - compatible: Should contain "mbvl,gpex40-pcie"
 - reg: Should contain PCIe registers location and length
+	Mandatory:
 	"config_axi_slave": PCIe controller registers
 	"csr_axi_slave"	  : Bridge config registers
+	Optional:
 	"gpio_slave"	  : GPIO registers to control slot power
 	"apb_csr"	  : MSI registers
=20
--=20
2.17.1

