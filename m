Return-Path: <SRS0=18Ni=NF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8F7C46475
	for <linux-pci@archiver.kernel.org>; Thu, 25 Oct 2018 09:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A2CA2082E
	for <linux-pci@archiver.kernel.org>; Thu, 25 Oct 2018 09:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kdFkYe/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A2CA2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbeJYRyh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Oct 2018 13:54:37 -0400
Received: from mail-eopbgr30077.outbound.protection.outlook.com ([40.107.3.77]:6528
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726785AbeJYRyh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Oct 2018 13:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEzhvuS08m2N7aN8G/jU2BHrEOFPUwHANjFoyGLA6FY=;
 b=kdFkYe/fCJ+Fw77NmNiuHm8ebpllu+5O2BvhGSXj/DcsTzkmK+1TXmLl11uzr9nmeZs78mFoCaqbSZ6jbUqUJ998ur9YzFZL3wTOaY0nvk2WlZzjVMGRC358vHaBTV4LtrE7ylqQHInw8ke3zJVzhnM+Sjl8jSvtT38HmLgIckQ=
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com (10.162.155.27) by
 DB5PR04MB0952.eurprd04.prod.outlook.com (10.161.195.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Thu, 25 Oct 2018 09:22:40 +0000
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb]) by DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb%2]) with mapi id 15.20.1250.028; Thu, 25 Oct 2018
 09:22:40 +0000
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
Subject: [PATCH 2/4] PCI/dwc: Fix the 4GiB outbound window size truncated to
 zero issue
Thread-Topic: [PATCH 2/4] PCI/dwc: Fix the 4GiB outbound window size truncated
 to zero issue
Thread-Index: AQHUbERGs7x7LmcHLUS70YvdVhCN2A==
Date:   Thu, 25 Oct 2018 09:22:40 +0000
Message-ID: <20181025092229.28413-3-Zhiqiang.Hou@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;DB5PR04MB0952;6:2PwRNPt/EuatCjmad/+t8bp9NS0xk1QMG/EncYBIWHNN2XnUTGufkIaZdYWPAIsE31tDLJghv5tsUBDwjglnNmlpsaeLWPV8dBe7/uInbB6cX9QAKVyLAdWvtNXdX+b4s3iC+DdjO5jY1mmfN9oRh2TOb4aTwdGi7qaV5krmJfe/EIMFS7AH6rV8WOPeHOhjEr8281Vn6B/5p0Z+ZXA2zL5d6zhflyw6/gmNtUKKQDTgQgzoq0Kohpx83SipaqhfF6p1Gv7YlrgKxtaHZq/UPxaHw3dZTzbCDuyGtwUBydnaTcPhSINjCoOH2svUgrSBgNxxOOwbmCKevNpOnBcZnBxDRF6C5ChfGsH2bqcHzf9s6sRk+EXdlsIAB5uTb+ZbQzQ5FSHhLLfzpICtca94uRHst/lEWKKvMpNDKN5u0UYesfv8nr0upF0W3p5cK1AOhTYNRD4xXTRFQypvSc8aaA==;5:ghADDvHPdHhFvGwfmFRJiUG4MZURREVPk1AKv+fdiJJ6BieZLZQDM4r9i+Ecm5gFouzUBx6FO2+YwfhkRW9AxRLCJdHHBIkjMWOxTgiCFbpkVdXor+ly5nJ32iw+OJpG8b1W2fiyJH90iA3hMhDptKCz2Q+9A/rQkVU533wf+Ic=;7:aM40D/upNNfldo30fF/bVUy7LIqSsFjEJQ7sUkAEwm6Gz+/qHPLaZ5Pbqr3NMjy/KX0eG4Kj5pVsW+ZKaopdwzleHsnUj6uTpXHiTjOGN3Mp/bOFm85yV0PXq5KGRiPWHtj7nyyKRXixjwPib35Fmivb3OEljkzlmQQB5TPYgIaDce5ZEE+V7Xddd+TqfUQeYcZMIa9kNcc+2UlUuV5JhkmkPen2rfESCRqOF7QJGCNvzV8UkJo58WBDBjpfv3vl
x-ms-office365-filtering-correlation-id: 44b9222c-1626-41c1-aa6c-08d63a5b6940
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB0952;
x-ms-traffictypediagnostic: DB5PR04MB0952:
x-microsoft-antispam-prvs: <DB5PR04MB0952825532FC0ECBB62DD9DB84F70@DB5PR04MB0952.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB5PR04MB0952;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB0952;
x-forefront-prvs: 083691450C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(346002)(136003)(376002)(199004)(189003)(6512007)(6436002)(97736004)(6486002)(39060400002)(99286004)(81166006)(4326008)(81156014)(53936002)(106356001)(25786009)(105586002)(2900100001)(102836004)(11346002)(7736002)(8936002)(446003)(2616005)(256004)(305945005)(476003)(186003)(478600001)(86362001)(8676002)(26005)(68736007)(2201001)(6346003)(486006)(575784001)(6116002)(3846002)(386003)(6506007)(76176011)(66066001)(2906002)(5660300001)(36756003)(1076002)(14454004)(316002)(54906003)(110136005)(71200400001)(71190400001)(52116002)(2501003)(5250100002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB0952;H:DB5PR04MB1221.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-microsoft-antispam-message-info: icCp2+frD40EDW67CJZtDximquG6chqhNgkFytByUqxnEKiYVN9tYb9GzFWWmasFWPtCaxcH/zvN1EqoKsEPx05EUSvN19RSXckJlpMtxCEvNu7TsDFbIez/PnI+Ry9jKcoUTqaHkRq3Y70Z0nZXUlFA2/NZxSH5fzjq3crJa4gdHWaw9gh1GrFzgPaKQPZVrwNfkmn2VoxCcu2v85wKc7kIhJGmA+6ah7hYSarSvBGEVD4DDlcMedZImCgVGHbhl8c0oOgLphmfuKJcCDnvlpQ/Ga3ZQ2kHVYU6KnloOIkzmTf+4MFWTpruLFu1Sa5FfemDAybsQpw7KDOxZ1/s2nofdv+5XLzg6xYKaB+6p6k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b9222c-1626-41c1-aa6c-08d63a5b6940
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2018 09:22:40.5065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB0952
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The current type of mem_size is 'u32', so when resource_size()
return 4G it will be truncated to zero. This patch fix it by
changing its type to 'u64'.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
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

