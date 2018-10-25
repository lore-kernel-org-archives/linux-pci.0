Return-Path: <SRS0=18Ni=NF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6964C46475
	for <linux-pci@archiver.kernel.org>; Thu, 25 Oct 2018 09:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0DA2082E
	for <linux-pci@archiver.kernel.org>; Thu, 25 Oct 2018 09:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q3Yl+c0b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA0DA2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbeJYRyc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Oct 2018 13:54:32 -0400
Received: from mail-eopbgr30078.outbound.protection.outlook.com ([40.107.3.78]:10483
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726785AbeJYRyb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Oct 2018 13:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ie25hpAqX9ySS3l7uae86c4vfPDa5RBfALtQqz40X5U=;
 b=Q3Yl+c0b1TUWU3+6Uk4F34X8weOgXTz+9RZ9J/q+qKO4B1PwWlDaD8T6LpkXTmMK04zIm7akgFPZSslT8msFRa5fMbFHyskk4PNg0+xbQfzz7302/OkX5TRSSgnJQMxemZRj3lLHI9t1LpGd+Vl6OtCtQhjYKk8iX+0/uk2G0Jc=
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com (10.162.155.27) by
 DB5PR04MB0952.eurprd04.prod.outlook.com (10.161.195.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Thu, 25 Oct 2018 09:22:36 +0000
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb]) by DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb%2]) with mapi id 15.20.1250.028; Thu, 25 Oct 2018
 09:22:36 +0000
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
Subject: [PATCH 1/4] PCI/dwc: fix potential memory leak
Thread-Topic: [PATCH 1/4] PCI/dwc: fix potential memory leak
Thread-Index: AQHUbEREQvuwyxv4sEeimaudU2OseQ==
Date:   Thu, 25 Oct 2018 09:22:35 +0000
Message-ID: <20181025092229.28413-2-Zhiqiang.Hou@nxp.com>
References: <20181025092229.28413-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181025092229.28413-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0P153CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::22) To DB5PR04MB1221.eurprd04.prod.outlook.com
 (2a01:111:e400:51c2::27)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB5PR04MB0952;6:ylp+qWsSOrYbYrK47SHgRb2l+SG0W1Spv3bpLWie7uu9klneCDBsYTVNexhTEh/2FcuSy/OugGnoMULTlljkkgVrTOxzL0Jyv8DIzvNfa7qQ3fXbvKFtR9G17qA6wC4O69pZUzyyB+zpUN+4lH7BC17zX+IqCelHwRjm9XJvqBhRq60+CY4k16bnON9tGIvukKAk8+V7OHZZVILogAlfjFqdCbN6noiZLFV2s2lLxjJ25TdYOSVuQtpvR+UGPIY2jYoBhHIWFsWbe3XF66W3LXuboVCNEU0Se7VpzYGaoAc0ix5WQv/A9HqduWiGUBeDkZjUxPg8Op2yHzhzksgta1WXpCOQ/tzFDygXKRq3a3L5xqXasfwmgsTbCdhZJ2w5T5T01P+8S3naWHoLas6ANkZrrqxgPVDrHG8udtHEw1hOz6lBb3jSxUZBw0q7Rcu/+wXJJlbKL+hNoTHXdySgFw==;5:2iSnQ4w8L3NmhBdrGpnN5+QTZhQxUxeB447TflDBDYqxiUxTnsC2SkkvssNc8vz3dl2hTXDZn1SobwYSqemf0V389M+CEioNVVXznZimRzrXBrqFhjkuhExcBv720iA88ECQnal66b+tHc9APq/IVj+3P43GKvlruT+8zzud9+0=;7:oQBHTzMRGmGnFjjLIrVydt8SV2gLCfGz2XMoU9L/WS5yBk00XeVfDkoK+y6n/KA8u75XsGbiMilsY8tBCnbFAsrm59zBbcznjBhEI8IooX+g1S9mfiDu79+XEs48RdUezkNzx+UfflhmOFDXvTP59DfjYjOrm7ro743+CnDyk4eSVBuNFav6I3+c10Ct+CY/H/jYve+PnpT3eNBrvxsexCsZ+YLVJYbwPdX7JKYevCqF4rpYAeL+GtbgttBXxOrD
x-ms-office365-filtering-correlation-id: 1aaa4840-1fae-4fb8-ae0a-08d63a5b6664
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB0952;
x-ms-traffictypediagnostic: DB5PR04MB0952:
x-microsoft-antispam-prvs: <DB5PR04MB095291003EFE656E5C77C7E684F70@DB5PR04MB0952.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB5PR04MB0952;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB0952;
x-forefront-prvs: 083691450C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(346002)(136003)(376002)(199004)(189003)(6512007)(6436002)(97736004)(6486002)(39060400002)(99286004)(81166006)(4326008)(81156014)(53936002)(106356001)(25786009)(105586002)(2900100001)(102836004)(11346002)(7736002)(8936002)(446003)(2616005)(14444005)(256004)(305945005)(476003)(186003)(478600001)(86362001)(8676002)(26005)(68736007)(2201001)(6346003)(486006)(6116002)(3846002)(386003)(6506007)(76176011)(66066001)(2906002)(5660300001)(36756003)(1076002)(14454004)(316002)(54906003)(110136005)(71200400001)(71190400001)(52116002)(2501003)(5250100002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB0952;H:DB5PR04MB1221.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-microsoft-antispam-message-info: UWd3NPj7GTJ8fJ2RPOuyg1W9AU7drqEhhNpvZGX1ajuFYYBOoxU+GqC23UgaqJgBO7jLjqA1ZAczEasOAEm9ldQFj6PY38wVuV+8w9gIKVZCWLbMkz6wh34X6CxnHvcKTTcl1iORZE/jQFwUY3eZqgLlV1NNfc1sOHrgbwQLLAu7TzmLdCHEVvWb5MFDjWye1swsvsgafqASMR+R+T8jVYfzsyQGxdNCeTwal6xDB3i2aoR4piCwASsmMy3uldjz/fXAd277GZrsUhA6wxZH82ACAOXeeic08S6AS4WwBtHbe+R8Ser5jot4STJOU3Vzend8/HosGeKJ/r5LFV26R9uvk+ie20JYOdgXm2/sp3U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aaa4840-1fae-4fb8-ae0a-08d63a5b6664
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2018 09:22:35.9282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB0952
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Free the allocated pci_host_bridge struct when failed to get
host bridge resources, and free the resource windows before
free the bridge.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pc=
i/controller/dwc/pcie-designware-host.c
index 29a05759a294..ecacce016489 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -353,7 +353,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	ret =3D devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
 					&bridge->windows, &pp->io_base);
 	if (ret)
-		return ret;
+		goto error;
=20
 	ret =3D devm_request_pci_bus_resources(dev, &bridge->windows);
 	if (ret)
@@ -502,6 +502,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	return 0;
=20
 error:
+	pci_free_resource_list(&bridge->windows);
 	pci_free_host_bridge(bridge);
 	return ret;
 }
--=20
2.17.1

