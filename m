Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C261C169C4
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 08:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 276F5214DA
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 08:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="djPYXVoI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfA2IJA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:09:00 -0500
Received: from mail-eopbgr50081.outbound.protection.outlook.com ([40.107.5.81]:48576
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727502AbfA2II7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 03:08:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHqR/FXj0HKqNCbtsS5N9hT6szJRQA3lf7JEfN9PluA=;
 b=djPYXVoInQRQ9MesSmaDDYrUTurjG30gI4lZ/Xrr1IK7fDrb5e86E9AL+e5gGqAkpqVnwSbsccIjtg4nx1Uyh70ZiRd3iWml18+NI4FXlWO1rld3YIM2gZkmZZs7nqERJ+nvY3mayerQCansZ3yF02AYkGVrIwKQ+ycHxMxSk80=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5784.eurprd04.prod.outlook.com (20.179.2.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.17; Tue, 29 Jan 2019 08:08:53 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504%3]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 08:08:53 +0000
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
Subject: [PATCHv3 04/27] PCI: mobiveil: remove flag MSI_FLAG_MULTI_PCI_MSI
Thread-Topic: [PATCHv3 04/27] PCI: mobiveil: remove flag
 MSI_FLAG_MULTI_PCI_MSI
Thread-Index: AQHUt6nfsD9iNbAFAUaq30Vq7P8rlA==
Date:   Tue, 29 Jan 2019 08:08:53 +0000
Message-ID: <20190129080926.36773-5-Zhiqiang.Hou@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5784;6:3TYroxuSysEb7S9mvRge5Q1tJdiEqxXQYbNKgS/tt+4YZgc4cjGCtMo6sc09T50G6dGpXGhHe+WGs/FHGD/tiZtKRwtyZc9RcHuu9Bo1OLbunSxWfMFucom2TBt8Xe9N1RIYhrF2Efnbr7grcChFmI25toq3R3BHT9yJ5CZ7n4vN3XgPWjbbaGrLPMVYI5VRg0qi5fSNsIF47+7abUPoAxa6yTQeu4mFKfm6IRkn3+Zs/4+xEINMwonnBbAJC6qnlpMRJAMXxWDyMBjg/Bz3i+ud1nM95fgd9nWZyrEAWnVYxnb+mam/rEqSEGCMVatLmYDuktwsEpIRNsAEKCtD4ipRqv8CE4i6CX7YZUM1Nf4vZzEciJErna7IW+JSkAZDbdmVyLwFFF1MAoag2ty881I6foZO+8X0f6LQD+9ztdH4ToNLwLQgzMJhBQD8rsSlKKWFTnDPlEg3/jlnpbEdYQ==;5:Y5+1rHSk7sZ/5DfI4NzrtbNceeAoxlr4CQpmgvCGpjpGBA4H3jR/6DbZdD+5ckXlUcvvLZbEDZ6PBbiewcMxcldOSK3atRTL15NCJyY+RoFRiAJvr9E6fCvUxumzH8g1M1GHnZ+eFd0N3WbBa68CFH8RZR8QIZ5z2HosOMCLzJGbVO9u55zGXAPhDrsQYUn7LtEaUVvR1H45EykvmxOrEw==;7:be0x2ghZsxb6RLd6gTTMZtz/odIZ3ucQlwtfwkF2E/Z5aRG3HzAebnqIxsqkW7jzv00sAkKPSk6LUFPowUyHSStUs5I/Rvd2pmn6InsNOsDivKlHBFgnqAOGriVcoo9/2LOKPakSprOH8zPtVSodSg==
x-ms-office365-filtering-correlation-id: 4c207ecc-d8a1-41cc-ab29-08d685c10227
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5784;
x-ms-traffictypediagnostic: AM6PR04MB5784:
x-microsoft-antispam-prvs: <AM6PR04MB5784E026954BFFE86135C62184970@AM6PR04MB5784.eurprd04.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(366004)(396003)(39860400002)(189003)(199004)(3846002)(105586002)(6506007)(386003)(71200400001)(71190400001)(26005)(305945005)(66066001)(7736002)(106356001)(4326008)(102836004)(4744005)(68736007)(6116002)(2501003)(25786009)(8936002)(8676002)(81166006)(81156014)(50226002)(97736004)(486006)(14444005)(256004)(476003)(99286004)(6436002)(186003)(6486002)(7416002)(2906002)(14454004)(110136005)(1076003)(2201001)(316002)(478600001)(86362001)(53936002)(446003)(36756003)(6512007)(54906003)(76176011)(2616005)(11346002)(52116002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5784;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5AdkIXrqf8/MTRRCWs53CB8RF8Z7O+esyu4rtnSFRFQnbonH29oQXcF2AE4RD4wyUvmSDznsyaQ1tkWa+YL2OYddd0UGBitpy0Ap/0CN9CHBkGjUks3OoJRMpvB0k5YQHDW+KigLc9+nYQVIp6/41ZmBKxVHD1fevSYVFZiH4FitA09kmrZqJ8ZLARSxSdJ1xcr8M8dTRLaPPAt5A2WyghIW3IX5Gbr8x8rW//C1/siAXW3xtkJAaqNtkzFhpSDXwWvaO1DRvZKljkMVJW9Pp76gwe4pnwVCShLh4oY/4Ahl8FfnbqXjTrI+A0vhKBJTEnnVwr/JQkV5v9IJueFUsAPgMbkScQOxKuCeKk9dLQqTiVGcd95wvoCesLqjHekoAV0slb7C9+mw3FjO0CBIgRCYOFEFiRXr7VVLLvxAX8Q=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c207ecc-d8a1-41cc-ab29-08d685c10227
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 08:08:47.4277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5784
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The current code does not support multiple MSIs, so remove
the corresponding flag from the msi_domain_info structure.

Fixes: 1e913e58335f ("PCI: mobiveil: Add MSI support")
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
---
V3:
 - No change

 drivers/pci/controller/pcie-mobiveil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controlle=
r/pcie-mobiveil.c
index 563210e731d3..a0dd337c6214 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -703,7 +703,7 @@ static struct irq_chip mobiveil_msi_irq_chip =3D {
=20
 static struct msi_domain_info mobiveil_msi_domain_info =3D {
 	.flags	=3D (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		   MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX),
+		   MSI_FLAG_PCI_MSIX),
 	.chip	=3D &mobiveil_msi_irq_chip,
 };
=20
--=20
2.17.1

