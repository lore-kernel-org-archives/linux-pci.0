Return-Path: <SRS0=4zPb=NS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F64C0044C
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 10:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9C120827
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 10:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gStQ8yh3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD9C120827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730744AbeKGTjg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Nov 2018 14:39:36 -0500
Received: from mail-eopbgr80075.outbound.protection.outlook.com ([40.107.8.75]:13776
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726363AbeKGTjf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Nov 2018 14:39:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jh9q8ArwnTVY+6n9Iz6EqdBrKSSzih8Z1nryTiD9d/Y=;
 b=gStQ8yh3GK5CjT48lBGr4RFc0xSVp81tWocVAMKD4W6rX602rEYRS4/IRiddXFGdGJY5BgkVC5q9q8IE8NuQi8/CpoN3cR5ceiU+KX/90VcGpuiF0wCZrF6b/v6fJXMiuKDQcQivOoLca1m7ByuTLXBBXJUSlf1uxL3AJYEMDPI=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB5224.eurprd04.prod.outlook.com (20.177.35.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Wed, 7 Nov 2018 10:09:10 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::7d93:8053:57fd:1a00]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::7d93:8053:57fd:1a00%3]) with mapi id 15.20.1273.035; Wed, 7 Nov 2018
 10:09:10 +0000
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
Subject: [PATCHv2 2/4] PCI: dwc: fix 4GiB outbound window size truncated to
 zero issue
Thread-Topic: [PATCHv2 2/4] PCI: dwc: fix 4GiB outbound window size truncated
 to zero issue
Thread-Index: AQHUdoHtyqLmhpxOWkOjGGaxpD7Vzw==
Date:   Wed, 7 Nov 2018 10:09:10 +0000
Message-ID: <20181107100854.28389-3-Zhiqiang.Hou@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5224;6:wP7AxXsraYyWPG3kPhOzZUOd28FNckdSDzW6PclzZmTNpVTGPViNvNeMRe7FYRIwWfx6CHOPifEO4STcgCpHAk7sZPBXzmxtivJIt5cW/+szKMtSet/vgV8q7UwIdPcjY1PfYYOsmZz+wDMOd+obuSCjJRyC6T+2u/lspEB5KmvcYEO1KEtHoObkx9cP+4G3LKLE/CzoXOilkOmsoy0emtnSOxJE4Lb/Y8ePVQALxyZ6oZrHdySKb3XpV8C8AcyA9Rn5KmKBN/+wALx4CqE8yCG0y1oDV8BSiFGOJ+4twQIyFwyVvB+51+SV01n2MlZ4oRWBTzBHt+p5bzxJ834Le0hHZXISygYWqj9rJ/BjHZuD+QwURWPzovnIWhk52dZP62fCTdSfzXiOg3v4HfQ/dmUNDl6pw/5Fp2nUKo95O6FHEmHxpg/FMZs4cbmGYEOIOTRCISA1s4uybaz8FBVK9A==;5:9RjN7nmN4wI19Uji1H3/81+KGZrCjXuk29N4ImOz0UQm0FJSEtSGd7vVMMvJ6NP6RB5E/FdKnXbBMIBoPAsBrFz3b3O8IaQc1qFMvIqNRzO3Th7CScaDZak2mPbaLDIJaicL5KVyMsv3tI/eTZdphqHDXFT8U3ZjTI4x1TwQuLI=;7:NuK9QRzlXKhdXb7TmuPpuqzDwuGeJoSK+47CnmNHzn2AoQGoi71uOeLrphB21cwIP2W7nS9uGEvAm8RaaOioK3wLkDxo5X5wrDIePhQx1w/GFaYcsXray2QLaImUWBkuFjKvDuMPcwa6Z4bIicnydg==
x-ms-office365-filtering-correlation-id: c356716a-96c8-4b01-7f20-08d644990f87
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5224;
x-ms-traffictypediagnostic: AM6PR04MB5224:
x-microsoft-antispam-prvs: <AM6PR04MB5224EDF95E08D2DC082EA99D84C40@AM6PR04MB5224.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5224;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5224;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(39860400002)(376002)(346002)(189003)(199004)(71200400001)(71190400001)(39060400002)(5660300001)(305945005)(2501003)(25786009)(386003)(6506007)(6116002)(3846002)(102836004)(1076002)(8936002)(68736007)(81166006)(97736004)(81156014)(256004)(2906002)(99286004)(575784001)(186003)(66066001)(76176011)(52116002)(26005)(86362001)(54906003)(2201001)(6436002)(316002)(2900100001)(8676002)(446003)(53936002)(2616005)(486006)(11346002)(105586002)(478600001)(36756003)(106356001)(476003)(14454004)(7736002)(6512007)(110136005)(4326008)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5224;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wpN/7T+YsiCgFVuMlRbJsbC5esst9Vt1+i3jcyha9eiYcfS0GjYoejNBIsSOpt/4OKIu8GPAXF6EhQiqiFnZ+tIZUaDOlA1hUp5N1AXOazFtQIG1NVyIgcwX6/9bJJn/2qDs5tcM8AQ+C+pL/2dVumzmshXFR3e1qzaTEtkW6PEDMqMKfipbVLmjT5E2/F4pMNP6deuYikO1DCQyYHCzzNk5u0sz2g/KSgHa0lUBDLhPuHSEvXngeeqIylZtr4pwOVO7vvQDxilbs+ElFZmAc1Vc/lPnZ5QZ/sh2Y2LXp94tNOkbmK7ehUXDjdg+neIZtFFXTXdQfHws6wxUmzZwsitGjdOE3WKNTk0p8oyMyQA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c356716a-96c8-4b01-7f20-08d644990f87
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 10:09:10.3639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5224
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The current type of mem_size is 'u32', so when resource_size()
return 4G it will be truncated to zero. This patch fix it by
changing its type to 'u64'.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
V2:
 - Reworded the subject.

 drivers/pci/controller/dwc/pcie-designware.c | 4 ++--
 drivers/pci/controller/dwc/pcie-designware.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/con=
troller/dwc/pcie-designware.c
index 2153956a0b20..7ac5989c23ef 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -106,7 +106,7 @@ static void dw_pcie_writel_ob_unroll(struct dw_pcie *pc=
i, u32 index, u32 reg,
=20
 static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, int inde=
x,
 					     int type, u64 cpu_addr,
-					     u64 pci_addr, u32 size)
+					     u64 pci_addr, u64 size)
 {
 	u32 retries, val;
=20
@@ -141,7 +141,7 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_=
pcie *pci, int index,
 }
=20
 void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
-			       u64 cpu_addr, u64 pci_addr, u32 size)
+			       u64 cpu_addr, u64 pci_addr, u64 size)
 {
 	u32 retries, val;
=20
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/con=
troller/dwc/pcie-designware.h
index 9f1a5e399b70..a438c3879aa9 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -153,7 +153,7 @@ struct pcie_port {
 	u32			io_size;
 	u64			mem_base;
 	phys_addr_t		mem_bus_addr;
-	u32			mem_size;
+	u64			mem_size;
 	struct resource		*cfg;
 	struct resource		*io;
 	struct resource		*mem;
@@ -238,7 +238,7 @@ int dw_pcie_link_up(struct dw_pcie *pci);
 int dw_pcie_wait_for_link(struct dw_pcie *pci);
 void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
 			       int type, u64 cpu_addr, u64 pci_addr,
-			       u32 size);
+			       u64 size);
 int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int bar,
 			     u64 cpu_addr, enum dw_pcie_as_type as_type);
 void dw_pcie_disable_atu(struct dw_pcie *pci, int index,
--=20
2.17.1

