Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43D2C282D0
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 08:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86CD02177E
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 08:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eWzXcfzt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbfA2IKl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:10:41 -0500
Received: from mail-eopbgr130079.outbound.protection.outlook.com ([40.107.13.79]:51008
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727555AbfA2IKk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 03:10:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wa6VnPE/whJ973L4lALZYSCLltLY6qSv8g2wTEOGLlU=;
 b=eWzXcfztSOu+OsrdkSHkQ8PicKjfSPiO0dw+cu5eJ325rrAxT0p73mza6IfTrnp6AgbYG8/Eo+RXFd4n7hF/pAb13ERUSNRWacoaattqvM4Mj88134XNd1o/pd3sw5zfSn+MM6jbbV+3iAQ3mA6QFQiCN9Ayjgxc69W/yjfLT8s=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5127.eurprd04.prod.outlook.com (20.177.34.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.23; Tue, 29 Jan 2019 08:10:36 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504%3]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 08:10:36 +0000
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
Subject: [PATCHv3 20/27] PCI: mobiveil: add Byte and Half-Word width register
 accessors
Thread-Topic: [PATCHv3 20/27] PCI: mobiveil: add Byte and Half-Word width
 register accessors
Thread-Index: AQHUt6odOw0MOSvMekmxd5JY38DqwA==
Date:   Tue, 29 Jan 2019 08:10:36 +0000
Message-ID: <20190129080926.36773-21-Zhiqiang.Hou@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5127;6:qCgmmuvegDsaMvmrWZIMZv+9U/NeksgpzzqxPAthPgQILqpntiC164CKtjajZdv14vymZdf0WW2FIPL07E0zDJY7V/IEIylj8B2C52Mn/LL7AbYMTA5oJHLwT+/ZtvLXD2Nkw5z4tDfGUTkC+SV/nbDeWrBuri6DZ2j1aMfDEt5tgJJTq7uxfkvMSm+/ArA1jle1cKMNd2kRZiINk7OsXyDGAIB4//+NJpUbQceWbWV53/4vemmwKJe18Ef1EAPHSX8mCf7ZvCGWYX86kmelgHmEDK7I1yOig765QYCjgSSTZIvZNml+iljV+nxrdUKOiJdEZaBbxJdP6/y5QxRClBqERFJwMTV01pBdF3KL5y4o0OQ0xJYAimLxG7oGG7LjjLel7etlF2AmtnvSTA4ubY+o+4cQfsgFMOfHS5NgrYLEVFRklrZDfhKkrKIY1RjRqVKR149GWB2buES3BcPB1A==;5:e3QVhYwlYXZUwoDJXCHx9SAswxZk7DC9eVgWjXJhROf8MR3WQTRi1h6t1aEi+yKl+Y8GRtxxV2muBWkKTJuA2BU3TObRAqe+2Urj7qp0sgsDOk2iWyTrnEDh9wwsE+KurzFNCVqWD/jY95Ei44LUejk3cgqovCnni1j2EIvFUQIxwx880WstDUJF3uS0EUi8w+lAO2TEB84mOlCNzVP75g==;7:ELn1J61eLECVBPOGHITQCYByYLCXS9h5xnlptKxPTBzHaDvE86pche4TkA0d4kDyZhrQnn9eeFjBsZWdYCNMFTM5z9YdG7bvbD5zVAn7m+cbfaF7+e2+Yz5F8qssZWhtbzqQmL2XLYZRoXHYVBhhIg==
x-ms-office365-filtering-correlation-id: dbba98e5-8396-455d-e69c-08d685c13fa1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5127;
x-ms-traffictypediagnostic: AM6PR04MB5127:
x-microsoft-antispam-prvs: <AM6PR04MB5127B15FD987D47262DFA91A84970@AM6PR04MB5127.eurprd04.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(346002)(366004)(39860400002)(189003)(199004)(6512007)(8936002)(26005)(81166006)(99286004)(4326008)(486006)(52116002)(2501003)(186003)(97736004)(76176011)(105586002)(14454004)(478600001)(106356001)(6486002)(305945005)(54906003)(53936002)(50226002)(81156014)(6436002)(110136005)(8676002)(68736007)(476003)(71190400001)(36756003)(71200400001)(316002)(7416002)(256004)(386003)(2906002)(6506007)(446003)(11346002)(102836004)(66066001)(86362001)(1076003)(25786009)(7736002)(6116002)(3846002)(2201001)(2616005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5127;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pzlG77XcQb/IT+LvjX9SmWnvXkaTOFrmsbVPlZhDQis6PQdIVNonZ5hEnooMKZYiM+vWMRIyPplEcqCuL8P9oZZxrsyAL1T0kZxW4DPJdzK6vu8NQFdhKP6Xz8zrm9HB2H7uNbvEMcdgaE5FhZi8J35n+p9liF93CKTEww1PVquxwYOo8adTik5CG8z+NVg5ZJfrOlRGrFSNfuJgGJx/iIf6hxIaXjnGMspBbEdUfNle4Jbq1zjKY3A4JKLArIUEc1Rj25riU0XA7r2fvOWoSnJmK5/Ug4cLfTWMzZOoF4Yzn76MBKdMa99H/VOB+IQbI+pRTmycvaoWJhBoNnKaz6G2sjiFoAWFs9XOxTXUj62I07jYpBMXZ4zim84HUc3gEFEuDZLJgAXwYD+kkMLE9mErQ2VmAtct9bBitUO4pNg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbba98e5-8396-455d-e69c-08d685c13fa1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 08:10:30.6010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5127
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

As there are some Byte and Half-Work width registers in PCIe
configuration space, add Byte and Half-Word width register
accessors.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
---
V3:
 - No change

 .../pci/controller/mobiveil/pcie-mobiveil.h   | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/=
controller/mobiveil/pcie-mobiveil.h
index 81685840b378..933c2f34bc52 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
@@ -181,9 +181,29 @@ static inline u32 csr_readl(struct mobiveil_pcie *pcie=
, u32 off)
 	return csr_read(pcie, off, 0x4);
 }
=20
+static inline u32 csr_readw(struct mobiveil_pcie *pcie, u32 off)
+{
+	return csr_read(pcie, off, 0x2);
+}
+
+static inline u32 csr_readb(struct mobiveil_pcie *pcie, u32 off)
+{
+	return csr_read(pcie, off, 0x1);
+}
+
 static inline void csr_writel(struct mobiveil_pcie *pcie, u32 val, u32 off=
)
 {
 	csr_write(pcie, val, off, 0x4);
 }
=20
+static inline void csr_writew(struct mobiveil_pcie *pcie, u32 val, u32 off=
)
+{
+	csr_write(pcie, val, off, 0x2);
+}
+
+static inline void csr_writeb(struct mobiveil_pcie *pcie, u32 val, u32 off=
)
+{
+	csr_write(pcie, val, off, 0x1);
+}
+
 #endif /* _PCIE_MOBIVEIL_H */
--=20
2.17.1

