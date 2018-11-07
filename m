Return-Path: <SRS0=4zPb=NS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F47C0044C
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 10:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE27820827
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 10:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iz6/Cibc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE27820827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbeKGTin (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Nov 2018 14:38:43 -0500
Received: from mail-eopbgr80074.outbound.protection.outlook.com ([40.107.8.74]:34944
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726218AbeKGTim (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Nov 2018 14:38:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/ZjaFRubpvK5ZYRs5HA3ijLPAdP4zcF88DTNLcybTI=;
 b=iz6/Cibc32DSMbtz2VgNjQX0MIFlSJVPOj/bDqRo3T2f7poEvyft+6tFMArQMNNCCeWAa726udPz8m3HoxGaRwBTdxfLdNz6ZqOADD6mAC3mgYswoyWOThCxo7yuKIZEpUces2te9CVPULVmoODo1wvX5y+5mmL4fwq5KPxDWac=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB5224.eurprd04.prod.outlook.com (20.177.35.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Wed, 7 Nov 2018 10:08:59 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::7d93:8053:57fd:1a00]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::7d93:8053:57fd:1a00%3]) with mapi id 15.20.1273.035; Wed, 7 Nov 2018
 10:08:59 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
CC:     Roy Zang <roy.zang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCHv2 0/4] PCI: dwc: add prefetchable memory range support
Thread-Topic: [PATCHv2 0/4] PCI: dwc: add prefetchable memory range support
Thread-Index: AQHUdoHmQxmNJOC8h0+ezaw7e6/ytw==
Date:   Wed, 7 Nov 2018 10:08:59 +0000
Message-ID: <20181107100854.28389-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR04CA0023.apcprd04.prod.outlook.com
 (2603:1096:203:36::35) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:aa::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5224;6:GA2me68s/tMs/qvvlsbxzjCP0+vXCCOwkZ++cZQUyQTJMFmc2xBZuzjT+GiByJ18J/ZKqEu8iqUVM0WxXFvYLJ0FaUM/SeZfCuATYoi1mBfhm2ENLtMGoJpywnv3S4byf1PMKBobj2qEPvJ3eeJFu6aCUahlaMEGAvuOgmEMseEGrenvaA5PFbYOukT9FIXUx9AVrfhsHrrK4Kaz8/BfxcFkHVTs7dZr9lIXOdmZBQ0nK1jaMA7CvSvHLUYL2j6XWG8jRjcfMCghrcP/7jD3DkQNdOQE5UKHTH+CnvVFvtTWcJ+IF7arD3CCdXSsf+MMRxBDPdR31IEO8XBISM/CQqRZsEHpvyvuiQ9a26t0acB6KtD4MshboS+XUeHiNuG3D4tT7xpXKZMBJOlqzz3tYGPhRm+C7KWkP+XJ7bIh2a1xCNpG/4YiztP3HpRJXllr444DJus/1g0UF/agWxa4YA==;5:hEf2VCxHESWnu0hYES3zSKAMKTd2bDRqL35OfqdaD4h/pWjTSKhHd3XZJooxfzQFgP8tIZ70ffOt1sgwiY0MAHdr5unHDZO6tAuqB6pFBp4RKAHHslX6WtLbg/llyO1aTMq/Z18JtYCHIFkdG4EhJ1dnoQoSNSk3QSMUfrMNtFc=;7:wqONl6bcP1SRjwsWQ3Kh1tjQi9J11di2rrfNBdFaVm/j/YLPD64wjuhSZPN6aQKGZmbzckR/UT69A6R/jWvn+wwa8t1g9/7Ht1oP5Y6Adao8CeRf1rgIP90LzpH5qLvbu7KUnEf36aGtjNZ7Q7xsdg==
x-ms-office365-filtering-correlation-id: 9aa0fce0-6f44-4813-258a-08d6449908ff
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5224;
x-ms-traffictypediagnostic: AM6PR04MB5224:
x-microsoft-antispam-prvs: <AM6PR04MB52248B8125D9FD5EBAA1DACA84C40@AM6PR04MB5224.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5224;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5224;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(39860400002)(376002)(346002)(189003)(199004)(71200400001)(71190400001)(39060400002)(5660300001)(305945005)(2501003)(25786009)(386003)(6506007)(6116002)(3846002)(102836004)(1076002)(8936002)(68736007)(81166006)(97736004)(81156014)(256004)(2906002)(99286004)(186003)(66066001)(52116002)(26005)(86362001)(54906003)(2201001)(6436002)(316002)(2900100001)(8676002)(53936002)(2616005)(486006)(105586002)(478600001)(36756003)(106356001)(476003)(14454004)(7736002)(6512007)(110136005)(4326008)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5224;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WvNxlDea7zMUgvYyppnz+JmJmgS/wpALaGixx7Ynh8lHmqISkGJOQtgc3xqDJVNltoop8HJACT8mrnSNDUURf1spJUHE6X1cmfYaF9M0GBkMJIaAJEg6NqlgMexG0ze1BYER6QqX4MjDfUAlVgeDK0lPPLxK1MXtdDBkrrYhcoYV7VMg8ocmYm02ZdKOEcjmMmtdDVKdKdg+WqlRRefWum4vOivZL3qXdIy6b3gVboCl6sSBTt68uIKqfOAZF7eLi7g/pHMnw3GL9WgBsC6NkuC6yW1k2sMsKSCpUO1Ihj5oyLwvD8Q/jRt9FIlhHgVXyzIT8sG/WMKKTdCBplSlYJKGe7sVxqPgtvGLy9rYOPM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa0fce0-6f44-4813-258a-08d6449908ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 10:08:59.7772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5224
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

This patch set is to add prefetchable memory range support, patch 4/4.
Patch 3/4 is to initialize the number of viewport for layerscape PCIe.
BTW, fix 2 bugs, see patch 1/4 and 2/4.

Hou Zhiqiang (4):
  PCI: dwc: fix potential memory leak
  PCI: dwc: fix 4GiB outbound window size truncated to zero issue
  PCI: layerscape: initialize the number of viewport
  PCI: dwc: add prefetchable memory range support

 drivers/pci/controller/dwc/pci-layerscape.c   |   3 +
 .../pci/controller/dwc/pcie-designware-host.c | 110 ++++++++++++++----
 drivers/pci/controller/dwc/pcie-designware.c  |   4 +-
 drivers/pci/controller/dwc/pcie-designware.h  |  11 +-
 4 files changed, 104 insertions(+), 24 deletions(-)

--=20
2.17.1

