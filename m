Return-Path: <SRS0=4zPb=NS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4B8C0044C
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 10:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A7AC2086C
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 10:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FMTguQ72"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A7AC2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbeKGTjf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Nov 2018 14:39:35 -0500
Received: from mail-eopbgr80071.outbound.protection.outlook.com ([40.107.8.71]:4671
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726225AbeKGTje (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Nov 2018 14:39:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kT5Ao4oUD2UohVRBAQrFLHPZqrPUd8f5tBMkVUCFNFE=;
 b=FMTguQ72cbEpzEHP5MGwi6S6rzCMTc5y5Jy9erOGUT2gdhfhcg/OXyxAXcLSZ/BUW/CB09tUoubi7Inmh/isKOlguJNKrpwn2M8ya5phfUZQmFpSdyRBrUXmiMuX3Ns64F88jQr9tGuryR1af13p1U4X1NvqOUQbkXuVFkBxzXc=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB5224.eurprd04.prod.outlook.com (20.177.35.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Wed, 7 Nov 2018 10:09:17 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::7d93:8053:57fd:1a00]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::7d93:8053:57fd:1a00%3]) with mapi id 15.20.1273.035; Wed, 7 Nov 2018
 10:09:17 +0000
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
Subject: [PATCHv2 3/4] PCI: layerscape: initialize the number of viewport
Thread-Topic: [PATCHv2 3/4] PCI: layerscape: initialize the number of viewport
Thread-Index: AQHUdoHwwQtALiNKOkSV/HKwxAJl5g==
Date:   Wed, 7 Nov 2018 10:09:16 +0000
Message-ID: <20181107100854.28389-4-Zhiqiang.Hou@nxp.com>
References: <20181107100854.28389-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181107100854.28389-1-Zhiqiang.Hou@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5224;6:RAmOVCrS7XVngyuK5jFsWObpM0zIuCygAd4LnZmptyiy2fpqKNF3FJ1/OUpF13O+p/aRQEE4ohaQWtksU71AGym/7yG47wfm7tZ1gs+D+5IXLsYucqlBSVlTMY0VJ+6dfGZaNe4lX75wgUwG1x8Bl/WLQ7nJ8gJ3DUXnfouX1BgYRFc4vunZg+4MPSfsxarOBcR0bL67xG8BK3VICqQh6JrqJGla122W0ZFSUBnU2J8DUEwx/O6rao5YiQdNEe5xH61S5AN16ImyU4vm1/MqX2zwREBW99tlwQF/vtLeECqw5qUhmcFfvkge5bcr9/5sgHpbLVQe/ke9JguuU4ee9j0FHZVPdxgpprA130YYS5SsOmh/PSviuBXG9/QLTX1T7qP0+QX8pumweuxo3RJ0bkcPD1PVOv67fOeMzcgOc5SOGXUNm37xJXYL0ZqGq20CPwJw5nky+R6tQY9CBpTGfg==;5:CW7diaGnEP/dypWM8Nz3S4jHamHeJb6Bwe1C/ch5uSh/tZjCtSSPLHJwFMRcACUJSJcluzqyf+SfFPOgtv/XXPuhLl/nM0kE4HPpOG5cU7Iat//timzyCYrlmIJaX1ooD/o3z7Maeb1Bxb+eAUzCXrEWb407WGNS86Lor3p/DEs=;7:ehODYLQu1T9+gweXNeHxt2WAJfds/KowRSZ5zdammpJscPZo8EQSlKi+vM+NdIybHuNLY8Bmd95HHedWQFgNq1vIJopmlZfQlNxbmc+gF6kpy5F9sra8hyc5rVm4TqMBQ6GKst+P6QlSMxJocovmQA==
x-ms-office365-filtering-correlation-id: 87494380-dec4-46d5-2dd4-08d644991203
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5224;
x-ms-traffictypediagnostic: AM6PR04MB5224:
x-microsoft-antispam-prvs: <AM6PR04MB5224245D603BA7B0C8027E0884C40@AM6PR04MB5224.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5224;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5224;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(39860400002)(376002)(346002)(189003)(199004)(71200400001)(71190400001)(39060400002)(5660300001)(305945005)(2501003)(25786009)(386003)(6506007)(6116002)(3846002)(102836004)(1076002)(8936002)(68736007)(81166006)(97736004)(81156014)(256004)(2906002)(99286004)(186003)(66066001)(76176011)(52116002)(26005)(86362001)(54906003)(2201001)(6436002)(316002)(2900100001)(8676002)(446003)(53936002)(2616005)(486006)(11346002)(105586002)(478600001)(36756003)(106356001)(476003)(14454004)(7736002)(6512007)(110136005)(4326008)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5224;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zYY51Pj1soZPnxg/iZnwcJb024Gp51uOtBtYA4mZvE5dzZD+bshji6nGVI+KkeX7hD5ub1K0rvVwZLN5P/Tb+jBlqVC4GWJpzqbSC37qtcNVHKXRQSpq9/9Uxu0sn0j8lR1dlHaoHKXJeYMWOBlpt+qgU773VOmJh1HaVKS2d5AyHPSlknFYiU22T5KN4yJ2/1kGogosdmP1/T2/n1b41X7c0R4I7DE/udrPHcZywhVeS5e0xHDyN9UYu1M6gNAbkdYBKvFndAfYUJfipD5aZBJgF17t/r2S3RgSHu/9cDPoMDM2RNzIf7y0Dp7d58k48qRUEIVnqxJI+gQKLgkkT4BgItrJbSrECd0gSyadfVA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87494380-dec4-46d5-2dd4-08d644991203
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 10:09:16.9326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5224
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

FSL implements 6 viewports on Layerscape series SoCs PCIe
controllers.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V2:
 - Reworded the subject and commit description.

 drivers/pci/controller/dwc/pci-layerscape.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/cont=
roller/dwc/pci-layerscape.c
index 3724d3ef7008..69f3f1a5a782 100644
--- a/drivers/pci/controller/dwc/pci-layerscape.c
+++ b/drivers/pci/controller/dwc/pci-layerscape.c
@@ -280,6 +280,9 @@ static int __init ls_add_pcie_port(struct ls_pcie *pcie=
)
=20
 	pp->ops =3D pcie->drvdata->ops;
=20
+	/* FSL implements 6 windows */
+	pci->num_viewport =3D 6;
+
 	ret =3D dw_pcie_host_init(pp);
 	if (ret) {
 		dev_err(dev, "failed to initialize host\n");
--=20
2.17.1

