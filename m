Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9114C32789
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 13:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94FF72085B
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 13:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="t3batCTk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94FF72085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388350AbeKFWpM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:45:12 -0500
Received: from mail-db5eur01on0042.outbound.protection.outlook.com ([104.47.2.42]:33016
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388346AbeKFWpM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Nov 2018 17:45:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyBCotOB/4UBwLRak7AHF0ZaJZcy4ZO/gV3QOKviEd0=;
 b=t3batCTkmNXYjgemRl1LYAewSKEjEs1LhYPwAslLrHlpZ7MKEH39cFLvliqBvdezhv4O5Agojj2rN4WKGo0DvMs4rWuqMxH9PFaYSSRVmxKb1lbF7no2xfBG8+yy4eiNkPtyFeBz2d8T5Jvf+pk7bSLqTjF6pCSMkAWSqOgQT+I=
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com (10.162.155.27) by
 DB5PR04MB2119.eurprd04.prod.outlook.com (10.166.172.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.28; Tue, 6 Nov 2018 13:19:57 +0000
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb]) by DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb%2]) with mapi id 15.20.1273.035; Tue, 6 Nov 2018
 13:19:57 +0000
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
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCH 08/23] PCI: mobiveil: use the 1st inbound window for MEM
 inbound transactions
Thread-Topic: [PATCH 08/23] PCI: mobiveil: use the 1st inbound window for MEM
 inbound transactions
Thread-Index: AQHUddNpdXj5L9iawkiutXzPzwWf9A==
Date:   Tue, 6 Nov 2018 13:19:57 +0000
Message-ID: <20181106131807.29951-9-Zhiqiang.Hou@nxp.com>
References: <20181106131807.29951-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181106131807.29951-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0008.apcprd03.prod.outlook.com
 (2603:1096:203:2e::20) To DB5PR04MB1221.eurprd04.prod.outlook.com
 (2a01:111:e400:51c2::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB5PR04MB2119;6:zAlVBRVBJiJ3EJ3y7SX2nqdOJne8LEP0gsuDfeglcf1+yE+DuT3kn6pgqzZ0xBoghqQal464kEVoOY2AkIdS7pR4ZNy7HUEUOfOvny1tW+TLVf1O9zzl1rOFMC8R4QCEJWK5ZIU5ly/xoB5W61e28Ds6qaS9so+y1bP4SZoZqiteoMFGMyZKfCM+rJcDDyFduCdIGidHWCIS9wzTgPV3aklZzC6BEcWkR/m7onQfUg1rPZarsYW5oNadWMpqJOR0MOw5YBku24w4KLGtyO9+e9KRtFQULCZM1KGjvMjsWx5l5VmD4qGaVl27YG0cPlFYmvWmc1oezS2nKU/p1wGqPA+ZXBKXFH5Xjr/VnBGNQ/s+zDVnlVkZ54zZzdbsYRr6wQo/rIzPrnp1p09icQg0MqhhGBmIswze3HS6hxFsa93gR8CDDqNCJJTuDEH9UXhVdG3DBWzqzGVEYEey+tmK7A==;5:L9I4PeE+uLIjufaGxO48gWCPlegreotOpP+MUdGTKhnnktIJwAMTLhaHQzBGfQ0JyZAKf4g5B1OGz9zBEvZZcbaSpJuyDDiyihuy7VWrcAj+sEvu84Qw1atvFrod1yrYcB9XNoRpYMVUQ4SmjdAdBFMOl1ASpzxCoLEUch19laY=;7:HyRLDW6026r1MhcIItLiJOkAH7KZeVP06kMWCfEcwGBqau1jaTTP0ODwrIfU3/USmr28jOclxf2BytQcO0gjqrdvKvQWJ2plksWc2HwMRlhEf/4JpN8w3IRKlRdtokXX9zYqF3OZ7CfEt9sdhJRHHg==
x-ms-office365-filtering-correlation-id: c696d1ab-4eef-40fb-1ef0-08d643ea8be4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB2119;
x-ms-traffictypediagnostic: DB5PR04MB2119:
x-microsoft-antispam-prvs: <DB5PR04MB2119106C272CF378B53E5FC084CB0@DB5PR04MB2119.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231382)(944501410)(52105095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB5PR04MB2119;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB2119;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(39860400002)(366004)(189003)(199004)(81156014)(99286004)(2201001)(8936002)(86362001)(6486002)(68736007)(6436002)(5660300001)(478600001)(53936002)(6512007)(4326008)(25786009)(36756003)(14454004)(54906003)(186003)(316002)(110136005)(2906002)(2900100001)(1076002)(3846002)(6116002)(81166006)(8676002)(7416002)(256004)(14444005)(446003)(11346002)(486006)(476003)(2616005)(7736002)(305945005)(71190400001)(71200400001)(66066001)(97736004)(76176011)(52116002)(102836004)(106356001)(26005)(2501003)(105586002)(386003)(6506007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB2119;H:DB5PR04MB1221.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: o3ny4DSrn8DdYN0DVyY2QGtrbXAvVc9FzUvtRXdEZVXCxw9IcAPJh0m2VnVYqpNScp9hW0Xl+cbXHXRCa3ISBBsoOF//86F2z9V+LMokF9oxXJLw1YYao8XNBloM7AGj4qD1O7uItbgA3TFS37ZMOsv/Nt+760EX028wwQVxhetdvM0rR7QDturfkrByZt+fOYLu3OgWm5i1T89biGAAvXUw76rcol7Tcx9XNQqXgoQGn4BUPgew+jh5rg/bNNLFMB50PsOFKW5lPtzXrPoQh1MPOEkmGP27guQXCFref+NpE+noQx2B4uecmrldPfSyDPL/H3qEFVtPSlD3VAs5jJ+5c4poN0GKVKbT0SpBqx4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c696d1ab-4eef-40fb-1ef0-08d643ea8be4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 13:19:57.3629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB2119
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The inbound windows have different register set with outbound windows.
This patch change the MEM inbound window to the first one.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 drivers/pci/controller/pcie-mobiveil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controlle=
r/pcie-mobiveil.c
index df71c11b4810..e88afc792a5c 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -616,7 +616,7 @@ static int mobiveil_host_init(struct mobiveil_pcie *pci=
e)
 			   CFG_WINDOW_TYPE, resource_size(pcie->ob_io_res));
=20
 	/* memory inbound translation window */
-	program_ib_windows(pcie, WIN_NUM_1, 0, MEM_WINDOW_TYPE, IB_WIN_SIZE);
+	program_ib_windows(pcie, WIN_NUM_0, 0, MEM_WINDOW_TYPE, IB_WIN_SIZE);
=20
 	/* Get the I/O and memory ranges from DT */
 	resource_list_for_each_entry(win, &pcie->resources) {
--=20
2.17.1

