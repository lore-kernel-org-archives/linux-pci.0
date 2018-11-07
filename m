Return-Path: <SRS0=4zPb=NS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58EEC0044C
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 05:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DAF820862
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 05:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XrZMNtew"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DAF820862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbeKGOpj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Nov 2018 09:45:39 -0500
Received: from mail-eopbgr10076.outbound.protection.outlook.com ([40.107.1.76]:60128
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729816AbeKGOpj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Nov 2018 09:45:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1zKHXMnDgtSECbjHXX8dCStYSy8peO20PyXM5naIsE=;
 b=XrZMNtew3CQNr9IHO9c3Q67Ek78oq9NrceBmpxwz+VHOcYtCzF7YrdwaifouHmk9tbIB8ujwOpm2S4JFHMkY+gjsKzw2+eEkn6iX9/w1tHY5Z93mEawtSCPoNiw5nY2VNXOaiNIpuOFx/X9bb7XSdRg6DwpOICwBJdpTG5ojy/4=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB3973.eurprd04.prod.outlook.com (52.135.160.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.20; Wed, 7 Nov 2018 05:16:50 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::7d93:8053:57fd:1a00]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::7d93:8053:57fd:1a00%3]) with mapi id 15.20.1273.035; Wed, 7 Nov 2018
 05:16:49 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     Roy Zang <roy.zang@nxp.com>, "M.h. Lian" <minghuan.lian@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCHv2] PCI/Layerscape: fix wrongly invoking of outbound window
 disable accessor
Thread-Topic: [PATCHv2] PCI/Layerscape: fix wrongly invoking of outbound
 window disable accessor
Thread-Index: AQHUdlkWDR7SdoKvBk2auCyGdas4rQ==
Date:   Wed, 7 Nov 2018 05:16:49 +0000
Message-ID: <20181107051647.12242-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0021.apcprd03.prod.outlook.com
 (2603:1096:203:2e::33) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:aa::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB3973;6:dyUxbCoAf53azRbeBpDBNAUr7igz5bLjjHLSeCYEeSQFIkEvLxVKo3Qxg/uSdOHaHtBx1UmIA/VPOAVSCkdaLmGCFphpxKgeMcT8Z7/8qsBdf1m4B8RtsUVDnuzd89sR6WUo3c5q7hJehywu1eGe4Kl6lu0QsNtTH+Wh2JsA5MXnSEZrhP0zVcK4V0YGNAHpmit8EGTRHRgUYbgxWLrdmXS/vhh/rBHe+Vy4rpvIDsiBBPvyGyA1NJKkkCBzaGHKxdpS/4+xU8DbcHzhwN1HNj+Tvzek3rLVl6ibqwFjwct+qNBA/Bc19E0HoPtfEz+z5P/oltHr+jhYfwcRGVT7hRZjPowt+MhE72uiBHHo4YkdOOv/1i3/4IB6rMThkyOkn7gmIWprNVzoZ77NuY4k28j2dRj0kKCGNqGsKLeeHh+x/h+Nr0bDCo9Xed/aZdlIIm1mRwh6/j0S+6u6OX5vMQ==;5:d2Rp66csFFFzxYbfzCwNw5pdOmlFmy3tkRo3mr0fnR8JdvKuGQ/CEV1fy8f6Ne0n2McgMBXUqtjUHza+tADCRME8wgUiAPqFMnqdW900NM3X2s11FGpqDnL3laCq7W4nwwPrNsSbjSkN10vn+r5MhsMNTlfdtTGbPb/A+cKvh50=;7:DEJXStXc6/YyrVC9EsGKVzKUQ3ioNFAWoxCkrQuTJqWqJDva8qylYaCzl/4APtFohwlUErFBEnRF+M6IJloKeyOzN9sSY1CRyeJrwFmgR9qpETlQXRZ1qdCfVX9cLbTqrh+l0RnFd5oTmHRmhdD2ZA==
x-ms-office365-filtering-correlation-id: 74976380-457d-48fc-91d9-08d64470386d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB3973;
x-ms-traffictypediagnostic: AM6PR04MB3973:
x-microsoft-antispam-prvs: <AM6PR04MB3973B1144DBAB9D41BC96CC384C40@AM6PR04MB3973.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB3973;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB3973;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(136003)(366004)(346002)(189003)(199004)(110136005)(54906003)(1076002)(71200400001)(2201001)(53936002)(71190400001)(186003)(2501003)(2906002)(102836004)(316002)(86362001)(6512007)(14454004)(6116002)(476003)(99286004)(2616005)(1857600001)(3846002)(6436002)(97736004)(14444005)(8936002)(36756003)(68736007)(81156014)(81166006)(26005)(106356001)(105586002)(486006)(8676002)(256004)(6486002)(7736002)(2900100001)(305945005)(4326008)(66066001)(386003)(5660300001)(25786009)(6506007)(52116002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB3973;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 49c30XUqcJ7kzS/8QBS4bbd7DBFkn7ZiVFsc+lP16GK38y8aOKe5tFE8vFQY/+QbnGP+oYmm4kc6dtMbYQ+jbEZTK6f4Y1oHbq2NAvh4oBhmBilRuSVgqgzJFLdj5R6xB6+najDVCkZ5GxVG3y/xJ5UlsrVD7R1oBrobM+3pMmohmwZCwbmdVaRm2fDbXeudw2rzvWXrtbP6iptG+HFmlRW5NiixhrFqpZVwLU6lF0PG0leWNxpq0wWHHFvW2iegvc+65oiVe1Qb/WMU59zEsdQyU1HCkUeM1e+mr2TuzcwvkeQzYRbe7TCWa0EbDw05+cj7t7/uQL0r/vBbejgv0iBHtar4+WaEjv2OIHa2JmQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74976380-457d-48fc-91d9-08d64470386d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 05:16:49.8168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB3973
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The order of parameters is not correct when invoking the outbound
window disable routine.

Fixes: commit 4a2745d760fac ("PCI: layerscape: Disable outbound
windows configured by bootloader").

Cc: stable@vger.kernel.org
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V2:
 - Tagged this patch for stable.
 - Reworded the commit description.

 drivers/pci/controller/dwc/pci-layerscape.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/cont=
roller/dwc/pci-layerscape.c
index 3724d3ef7008..7aa9a82b7ebd 100644
--- a/drivers/pci/controller/dwc/pci-layerscape.c
+++ b/drivers/pci/controller/dwc/pci-layerscape.c
@@ -88,7 +88,7 @@ static void ls_pcie_disable_outbound_atus(struct ls_pcie =
*pcie)
 	int i;
=20
 	for (i =3D 0; i < PCIE_IATU_NUM; i++)
-		dw_pcie_disable_atu(pcie->pci, DW_PCIE_REGION_OUTBOUND, i);
+		dw_pcie_disable_atu(pcie->pci, i, DW_PCIE_REGION_OUTBOUND);
 }
=20
 static int ls1021_pcie_link_up(struct dw_pcie *pci)
--=20
2.17.1

