Return-Path: <SRS0=SeHV=OM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11498C04EB9
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 10:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C21BB20850
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 10:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OPsWPqJg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C21BB20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbeLCKkF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:40:05 -0500
Received: from mail-eopbgr130059.outbound.protection.outlook.com ([40.107.13.59]:64000
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725888AbeLCKkF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Dec 2018 05:40:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iza7EY/YdE6rH9Q99IhKXkPwdKUJgILZA70+rBpRQP8=;
 b=OPsWPqJgW+tSAjcmwYolCCqyz9HsZnEe1ALypQFrziqH2Qg0BoegEBTOpzK7exGUKV94SesU/uROj++sXu1HV7Rrs6BYR+3q6wQJNlgkNXy8Dt5NFqih2hWMVBlENqHIIZXGiojnYbjh02K+we6nAT1vqUvFuRYy4btP1Bd8QB0=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB4503.eurprd04.prod.outlook.com (20.176.242.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Mon, 3 Dec 2018 10:39:33 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c%5]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 10:39:33 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>
CC:     Leo Li <leoyang.li@nxp.com>, "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCHv2 0/2] PCI: ls_pcie_g4: add 2 workarounds
Thread-Topic: [PATCHv2 0/2] PCI: ls_pcie_g4: add 2 workarounds
Thread-Index: AQHUivR6IMiPKGn5wE6sdRg0Ft7iRQ==
Date:   Mon, 3 Dec 2018 10:39:33 +0000
Message-ID: <20181203104000.48626-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR02CA0167.apcprd02.prod.outlook.com
 (2603:1096:201:1f::27) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:aa::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4503;6:Ws35877RU7KSnZan9s8o7zIxbyc6OpYEHe+0ocK82h0t6uzmT6zMhVozC2849ZMcybTgWZXJ3vMI+ZiiZO8ur1+ZmoPuMHBDKnu2bxOYf/MQ6UbqOXZb1CJ8V9qVvtzT9MUUiPHeeMJQxCw88+28rL8I/sThv9Cqkgz2mHbs3DdUT1BXiPps43SPKkQZ/2EDyuk3pI6fEQJPgGhsD2GnTnIfx3cTjFcsajiSEFi4ABaZjQ+81pZeBZWPW6RfmIDVFM6TBJvJyOA+yjS6pex9LDpcQ8LxCW6YKzYMydfbo3cMKuS50mAmHDLhubc08DcUE+Jsr7LlrKrd86+eml6XkERxonYU89Jnd7Os6npq+BPMeMPnTeCvbkHtCpnegubbODTaqWyKm6CD/p2n3iANgC5AxnaP4k1iVyOz7F4VW9rmhcGbzmohRycJdLB5igi7H6wYYiBneMPkZ0D7GE7/Gg==;5:7VSHD2N7SWqi77xh0th5hQgps8fBBz+LBj23PXphDdD7S0s5Hk2309VXcNdpDwrWYd14pqLSh5CDdTQglrtQD5NdOc3uHLlTYOaY3fHhSKOxNNWASMfhSu8f9cDMtmmpslbfgAWVOvFKf2tu6J1qbFWPreNpPwGxscyVkDd+wtg=;7:i4xRYaC/xtF+ftbLvhFZEd+2YDfAr72qGibMWGU1eN3NsW+1oylB6P+ohgvXwrABHLojzXpdjKypVK0r6UC4zIPEmLk2ogt76hPQO7i+7JMUEAx1ahLTl1fRgiBu3vpKvNCAnlzYKza+TY5I+D/ehQ==
x-ms-office365-filtering-correlation-id: 65b24655-91cc-40f6-824c-08d6590b9c85
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4503;
x-ms-traffictypediagnostic: AM6PR04MB4503:
x-microsoft-antispam-prvs: <AM6PR04MB450368404983202DD034A94584AE0@AM6PR04MB4503.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231455)(999002)(944501493)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB4503;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4503;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(376002)(346002)(39860400002)(199004)(189003)(3846002)(2501003)(478600001)(97736004)(6116002)(53936002)(966005)(4326008)(25786009)(6512007)(5660300001)(86362001)(1076002)(7736002)(14454004)(6306002)(386003)(6506007)(186003)(26005)(256004)(486006)(102836004)(8936002)(6486002)(8676002)(2201001)(81166006)(81156014)(36756003)(99286004)(52116002)(68736007)(54906003)(14444005)(316002)(110136005)(105586002)(2906002)(106356001)(71190400001)(476003)(2616005)(6436002)(66066001)(305945005)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4503;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ppdB2Ezd6JM4VUydViK3kcw7DJ0lzL1FvkODeeGlj0onMUL2GgHeSl2uxfN5rvVWaCqYhZbMTO15yizGkGPYOEOS7ZzL1T3MlrRtkRJ0l2e1Hj9dDNGxUkQDoSYNs1LGhhrE7CNSBBsYZJHJy93gJJ6j4yVh/q5l5JcN0LmtBG397ZiAaGyb5XwiO/eIMTEMOcs5jKTVlWOkIwk1WlBbku+rUSLxJlNXasLe460DlGZrbUbnnsRbLnbAXcJS2OpiPNcuAiB/DfGWB83yUbCIdSqIo6HzSGrui/sGMxMPtm2mM5Ob6F/Q793PdcEi3aL0C8nFq/FIGCpVfV8Gecnvga/8pfKf21yS5Ab6AGRxn1M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b24655-91cc-40f6-824c-08d6590b9c85
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 10:39:33.0715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4503
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

This patchset adds 2 workarounds for NXP Layerscape Gen4 PCIe controller
driver.

Hou Zhiqiang (2):
  PCI: mobiveil: ls_pcie_g4: add Workaround for A-011577
  PCI: mobiveil: ls_pcie_g4: add Workaround for A-011451

depends on patchset:
 https://patchwork.ozlabs.org/project/linux-pci/list/?series=3D76942

 .../controller/mobiveil/pci-layerscape-gen4.c | 52 +++++++++++++++++++
 .../controller/mobiveil/pcie-mobiveil-host.c  | 17 +++++-
 .../pci/controller/mobiveil/pcie-mobiveil.h   |  7 +++
 3 files changed, 75 insertions(+), 1 deletion(-)

--=20
2.17.1

