Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51805C18DF5
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 09:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 110B32075B
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 09:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LHpg8pCT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 110B32075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbeKTTyT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:54:19 -0500
Received: from mail-eopbgr70087.outbound.protection.outlook.com ([40.107.7.87]:4817
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727547AbeKTTyS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 14:54:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAD3kxHDvjp1OmBu2cBMgN2QuND/G0T1GuVoIwyVdu8=;
 b=LHpg8pCTxI4ZBDyA0+xtdQDg24vRyfq9Onrba+b891yyFXGKXUWiw3tfZz05Ou9MmErD9gS1nvWTlNeyC3+DO4UvUeOncI4RyijNrlHpW7icHJs11E3qwBbMuQjpRENrE2RdhjQnEnLoHHVTd1tFre5COj7UqZ865KFq3nZ9mdg=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB4775.eurprd04.prod.outlook.com (20.177.32.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.21; Tue, 20 Nov 2018 09:26:06 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c%4]) with mapi id 15.20.1339.026; Tue, 20 Nov 2018
 09:26:06 +0000
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
Subject: [PATCHv2 05/25] PCI: mobiveil: correct PCI base address in MEM/IO
 outbound windows
Thread-Topic: [PATCHv2 05/25] PCI: mobiveil: correct PCI base address in
 MEM/IO outbound windows
Thread-Index: AQHUgLMQmG1Z3R34uUiTxXvVV6ligg==
Date:   Tue, 20 Nov 2018 09:26:06 +0000
Message-ID: <20181120092615.11680-6-Zhiqiang.Hou@nxp.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR03CA0050.apcprd03.prod.outlook.com
 (2603:1096:202:17::20) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:aa::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4775;6:MzXS5UcYDQrLmD5LwQTF4OYLzB8SqIF40CepbVfXwd8HScy6OGJ3gIOodEmyiCDJc1x0MTwjffbOl+nESjMbkZPannAgcWneL2pqUwSmqxipLF7QcOM3wKRNQtKl16qyOcVFpT2k9qonGw+WlGifzHT++VQu0wn+/v/Wp+PS3u9Gpe2aZ3hooIp3gZjZbnHGx6vHnl2v1rs/dieDT813hc4lTLpaTO9AcU1OQLCFM7A3qLzMpCMR50z3Iki/aWUmU9sQkIAENrMRojxZd5gwoubyvKAn/ZcFdzomYe4c8cNxK6xc+xi/D6wgCOo/epCBNcUpBLGTNsXW+ThkNG0t9i5y6/ILlg58Gw9h82UDqSOPQUBuuabQINXMygC2ZhpeFEdm9tuXKBS6dQOTS+4rE+i7rL7WRZIwH2rmZisbjlB70p4RExh8vVgusNvjsG9lpMeEM1ZpTIqkgpBOT+qZcg==;5:NIoYgAsc/MuvRO2ulAvp7aVR4/2MkPYLNT0SxF+8U/v1TNr2Eozd+uPa8k5iKQiYLIj1yZZvOV7n6MenBtLQqbv1nsSnrx4AMteR6uFayNkrwbpCcmDh/vG4fEvmfG123ZSWppa6PV4F/6LDTUbtU0Xp3fQU+rZ7XPkPyJFAKJo=;7:ctokFemqnnFTU3Fr2rU4u5pQYcDFOKEX0KiW+J8Afr9iX3XMIVioyQkDG9GHQal5SgBP8+a2svNE0bBRnDYSfgBaw6wMayhN/69LJnvriYy8Z6kZgjnRXBMt5eAT+2rPGMYWArwvwGeaXRxy/R41WA==
x-ms-office365-filtering-correlation-id: 8f528068-d404-4643-49ca-08d64eca32d0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4775;
x-ms-traffictypediagnostic: AM6PR04MB4775:
x-microsoft-antispam-prvs: <AM6PR04MB47751E74219385DCE7C293F884D90@AM6PR04MB4775.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231442)(944501410)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB4775;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4775;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(376002)(396003)(346002)(189003)(199004)(66066001)(1076002)(2900100001)(68736007)(8676002)(6486002)(5660300001)(8936002)(6116002)(3846002)(2501003)(97736004)(81166006)(26005)(186003)(81156014)(105586002)(7416002)(102836004)(2906002)(386003)(6506007)(7736002)(305945005)(106356001)(6512007)(76176011)(36756003)(4326008)(99286004)(52116002)(25786009)(575784001)(110136005)(54906003)(2616005)(86362001)(53936002)(446003)(11346002)(256004)(2201001)(6436002)(486006)(71190400001)(71200400001)(478600001)(316002)(476003)(14454004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4775;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: gyK0PvXxtmIGhY8aL3bK8Ubdo3JlRQ6bztAdHm0eR+plqIhiZQnPChKvy2sVI+rQmw/o3EaZSXQT7IQ42DfF8q9GXhQ9+raKL5nW7Km7hwn3cuWGnQzlhtnAGXC5aa9jXhnlWKHZK8d6HOh9qi0nFZROsLGNh4E7MezIRmXJnoUDZ8/8oeKbqHbvq7UbMcoOJpe1apcJLwpvMFdpHWMFpZ+gOo+ApZneulK4Vx2YsckDTEUAfrUJraDo7h66MJg/Djo8+PBajwq6eCqB+RKfiZs9OQPPUiDpwPDVR1UlPDTMAnENj3TwhQfXZQFlafUzOpsl8OW1K2wip8unFF9vqH19Cl9tSVw0lsl9eIvqpjM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f528068-d404-4643-49ca-08d64eca32d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 09:26:06.6594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4775
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

It should get PCI base address from the DT node property 'ranges'
to setup MEM/IO outbound windows instead of always zero.

Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge
IP driver")
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V2:
 - Added fixes entry.

 drivers/pci/controller/pcie-mobiveil.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controlle=
r/pcie-mobiveil.c
index a0dd337c6214..8ff873023b5f 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -630,8 +630,9 @@ static int mobiveil_host_init(struct mobiveil_pcie *pci=
e)
=20
 		/* configure outbound translation window */
 		program_ob_windows(pcie, pcie->ob_wins_configured,
-				   win->res->start, 0, type,
-				   resource_size(win->res));
+				   win->res->start,
+				   win->res->start - win->offset,
+				   type, resource_size(win->res));
 	}
=20
 	/* setup MSI hardware registers */
--=20
2.17.1

