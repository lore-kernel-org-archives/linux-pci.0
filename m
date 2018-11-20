Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012AAC43610
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 09:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A0F20851
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 09:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ThtbnWEx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5A0F20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbeKTTzJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:55:09 -0500
Received: from mail-eopbgr00077.outbound.protection.outlook.com ([40.107.0.77]:37792
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727166AbeKTTzI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 14:55:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHrphN+K8xYQ7GQ8b/pdf5d/iDyYtsAdae/rfUzCQOM=;
 b=ThtbnWExzj8Ug4PLoG38BUgXRLWcNt8StcroEmTr/AEpP0zD/fikK1Acmqk0bc7wemFKXabADlw6UdjbZEwQgYyLn7vqhlKEUDxRmwmSBbXkahQrec9Zdf7PqutJ8WRa+BA8A+V0kUvt9BlhsH1El+dww4PnYwpSsMYJQf+biro=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB5269.eurprd04.prod.outlook.com (20.177.35.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.21; Tue, 20 Nov 2018 09:26:56 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c%4]) with mapi id 15.20.1339.026; Tue, 20 Nov 2018
 09:26:56 +0000
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
Subject: [PATCHv2 13/25] PCI: mobiveil: move irq chained handler setup out of
 DT parse
Thread-Topic: [PATCHv2 13/25] PCI: mobiveil: move irq chained handler setup
 out of DT parse
Thread-Index: AQHUgLMux9U/dwM62kiiFtDOow1Ukg==
Date:   Tue, 20 Nov 2018 09:26:56 +0000
Message-ID: <20181120092615.11680-14-Zhiqiang.Hou@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5269;6:wDcIPEI+BvrfCnRubcXXDFqzYxJqHPw+g4yNFYaDUcSnGV1SKXQlgSY1pkBIVPrWVs1BxKJVSSWtI7jpZeI3vt5iSsALNRjnln/VLLwvCDWF2mllOFBUx4jmVRl3P4BpdscmXDBi0ExMXgkX+6PLDuuEs0KgkbhLynfmRgU3iCunQTUFTcMaahRt32+EZzufds3q4BJ6UPm82e3ymn6E0N5nnJyhBkG33agYnSyyZMMQ+HnisfvKaopZmapYOB+5PqOGNlBpqXLKVLHtwa+NNXVJfIOlKuGa5o4+ERzXmL0J5U8z5DdMcdi/soaGlDMKtvoxS6c6n76Id08aN4yDThYQNln0RS504kQiVKFjsCa7ovOkaXYvOq97a+8Fw5mRC3lanoLa4mkTtULMjbmwWW/kTViAniXYqhU1fqmaTdan0FrqY2q/ya76i1GQRpX6oKPD/Hs2qF7n16xpM9ZYng==;5:NrJRMOdBRH66cD9H5syOgA5WN1/xr9A0qCf3+1xpfkrRE5zCZr/ScearuNp9LduWSllIToa0/28tqIVjCmsZnDjhX3f+37GqBN+lPjiPpe/9Sb5i7+WZTv6Jq9x4MJKnvIH5cP4voso4vUMq7JiOlRk+xnWkMsKfo0x7fm7U5f8=;7:m/RsDQjdddVWocmUFZ0VW/DvoxFtXmG7TvZnEmwdl6VGFHyoz3OEAob1b679NoyyMco0jRklJqk7roJkxBMOuY31O9xrzmvXhyl2DPY+LpebXLAUBYJuUULodnug4whaxAKMCN5hEcXnD2tm/J2+vg==
x-ms-office365-filtering-correlation-id: 7659cf1c-7627-4218-26ba-08d64eca5081
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5269;
x-ms-traffictypediagnostic: AM6PR04MB5269:
x-microsoft-antispam-prvs: <AM6PR04MB526993ED6F37C8F9E44A116384D90@AM6PR04MB5269.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5269;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5269;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(366004)(39860400002)(189003)(199004)(305945005)(7736002)(36756003)(5660300001)(7416002)(68736007)(2906002)(4326008)(8936002)(14454004)(256004)(54906003)(14444005)(53936002)(6436002)(71200400001)(110136005)(71190400001)(6512007)(316002)(2616005)(476003)(446003)(11346002)(486006)(25786009)(2501003)(2201001)(86362001)(52116002)(76176011)(6506007)(102836004)(386003)(186003)(106356001)(26005)(2900100001)(81156014)(81166006)(105586002)(6486002)(8676002)(99286004)(66066001)(6116002)(3846002)(1076002)(478600001)(97736004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5269;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RpgzmGALt1n/vkzOwwCZLig75k4L2+bnmif/Mi2Fsa0I2sR86qVjqhugZtPlAb40fiU3M1uaDZcQBgSx6OwieLT4uGv6czliVAZwpQe4tzaIsupqsvnoZSPmvHhui6zQW/VjaQKXH9kcvcNPcw+r0I6Ey2z4+5+L6Nu+9+6tARuTxP5tzZhukp//SUigirrEG7TNgjDNNAm24L0pwmKzp26rl6YfZlEYYGOep9ye2s7CupOWoO7NJML5uaGkb7o+NjAIlB9ahGFPLkX1caYKS5MmNDj/6LQ89Y3KU0LhzVW1AQSg7sWVixhKcG35KfSCFUSuW5rRrNB/0YiKK3DXIFdCwZQxFMhx+5wAjEyS8Ks=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7659cf1c-7627-4218-26ba-08d64eca5081
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 09:26:56.4880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5269
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Move irq_set_chained_handler_and_data() out of DT parse function.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V2:
 - no change

 drivers/pci/controller/pcie-mobiveil.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controlle=
r/pcie-mobiveil.c
index c2848c22b466..db7ecb021c63 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -460,8 +460,6 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie =
*pcie)
 		return -ENODEV;
 	}
=20
-	irq_set_chained_handler_and_data(pcie->irq, mobiveil_pcie_isr, pcie);
-
 	return 0;
 }
=20
@@ -902,6 +900,8 @@ static int mobiveil_pcie_probe(struct platform_device *=
pdev)
 		goto error;
 	}
=20
+	irq_set_chained_handler_and_data(pcie->irq, mobiveil_pcie_isr, pcie);
+
 	ret =3D devm_request_pci_bus_resources(dev, &pcie->resources);
 	if (ret)
 		goto error;
--=20
2.17.1

