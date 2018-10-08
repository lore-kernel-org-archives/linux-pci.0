Return-Path: <SRS0=j7M/=MU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703BBC677D4
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 18:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3065C2145D
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 18:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dKpkc4Au"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3065C2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbeJIBTV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:19:21 -0400
Received: from mail-he1eur01on0075.outbound.protection.outlook.com ([104.47.0.75]:22699
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726458AbeJIBTV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Oct 2018 21:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTAQxeK72dH2BB+VvpRxlviTntU5UH4iTQNVCXJfbiA=;
 b=dKpkc4AuQ5PTLsa/eNFN4y1OB+0N7k9eejppwX5Vmbdasl0tpW9tXXOZE9DOuc5M6J/l7BAWRtanfKxuqgirBalUzQr/UDb8Ii7iZtq4VIBmz9WdNptvtT8QRFw93FDlQH87bVP56BGizZcVHJnZfSe/ffGMQ6aGpBuWMAiDH1c=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB5172.eurprd04.prod.outlook.com (20.177.42.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.22; Mon, 8 Oct 2018 18:06:19 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef%3]) with mapi id 15.20.1207.024; Mon, 8 Oct 2018
 18:06:19 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stefan Agner <stefan@agner.ch>, Marek Vasut <marex@denx.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/4] soc: imx: gpc: Increase GPC_CLK_MAX to 7
Thread-Topic: [PATCH v2 1/4] soc: imx: gpc: Increase GPC_CLK_MAX to 7
Thread-Index: AQHUXzGdTEA4i3oy80C5E2NGCyQNsg==
Date:   Mon, 8 Oct 2018 18:06:19 +0000
Message-ID: <be94b872b63e6e0ac6f65ea41a69322d958f4a93.1539020938.git.leonard.crestez@nxp.com>
References: <cover.1539020938.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1539020938.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [95.76.156.53]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: AM6PR0102CA0011.eurprd01.prod.exchangelabs.com
 (2603:10a6:209:14::24) To AM0PR04MB4290.eurprd04.prod.outlook.com
 (2603:10a6:208:67::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5172;6:IVG61SGEvEcKd7JIB7jADN3axd/amaHumNwuCUMspyeroVvT+JS5TuplTCmMausyryUYKdL6/Q1h2x5ODaGwvVI0pREuYMOYW95W1MTRAWS4GcHlTh6z161ZHg9G8fSqp7YUWSFpphRQo0J6kIxnMZ24rQJOomaX/CI3mud+nCVgnhTfm1gPcz8GR8DVSrQx6Fc/WZ6R1hvaZkPYf1dK2A8lCH3enMIH3AemLyv9oFmG5QJRSMnHfa+8mUy3Tj8qcHBtb0h7eEldWMZYO/BaqZkICMS6x1Xy1NInBZ5C62ClVZ6WjuV/uFMskvZ3YNFTG2LFB8ufzFC1PmouM0o8Anglw9aIKqiVflFW1YlETpds3Rg7BChmpTBcoezbMJbmQJfrpG24yO8NUDYl6109xm40wYL5TrFh6TiGBdMwuF4c4u6fVadwlkzeqZJ6u/tldHaMrzt7tityuSiP/Kq7Ig==;5:bSKEUza1JyHR9ENieV80AI740w7EyEW3WcAZCl/OcguUd6mpJABJaXlEkUq63pRxCyKjFn0SIu0s7QZWDr+XwOK5U6n4FoFBC2u4sZJdKl05TRplilNMKQfLz1MpQiwFYAIC9bfyGP3EK9QbxjY0jrE44+SBRqmNC4wLRwJG3XQ=;7:vQ6VW82/4dpTGtiHVGpFyb2x9evx4XeLkpKW+4kdGHSZrUEqevUh2lQ3E3KrtZRAlcxtW5PLhCDdhWSESaaO3vXl+Zgz0b5IdiwIAtzlBc2t9WNwyeOpOESB2szCi0idwHEC1DpfdSGVZ85axlxH7gFrV1ATGs+VcWhIYCRnPNIgb9EHYXex1ueO5WmKjqbJpeg+y3cd69Fb/enOmMlw1+BtRbszhxUZeGTOGYB0yU9Gl18s/RPDvYf5/8qRrVQV
x-ms-office365-filtering-correlation-id: ec6e9b39-4356-466b-3bdf-08d62d48bf5d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5172;
x-ms-traffictypediagnostic: AM0PR04MB5172:
x-microsoft-antispam-prvs: <AM0PR04MB51728B1111CF90B73B47A083EEE60@AM0PR04MB5172.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:AM0PR04MB5172;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5172;
x-forefront-prvs: 081904387B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(136003)(376002)(366004)(199004)(189003)(2906002)(54906003)(25786009)(2900100001)(186003)(575784001)(14454004)(66066001)(110136005)(53936002)(6512007)(6436002)(36756003)(97736004)(71190400001)(26005)(102836004)(76176011)(6116002)(6486002)(3846002)(4326008)(86362001)(256004)(14444005)(71200400001)(5250100002)(316002)(7736002)(446003)(105586002)(68736007)(7416002)(8936002)(118296001)(8676002)(81156014)(106356001)(478600001)(6636002)(5660300001)(44832011)(2616005)(476003)(486006)(305945005)(52116002)(6506007)(386003)(11346002)(81166006)(50226002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5172;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8QhPDdNnbWeWRWeApe/3q+JYY482KB8aGTDkhZVwq6cSnZGL1w4AeClkKkhZQqaWJbLqmxjT70B8ktdc+s4iLXBcItK2hscPCaCGGrYyYKL7a25Chg6+7MP/vVHeUwq+9PEe64T0k2BxFfLBnyM/4Y2i/mONuDCLQw7ZXrt2d+vl82kZr6JVh2LLHDlVZrYJvTpcyKC9ZsETAyD0fHeT0MxhTrCAjv6g0otHYc/fO5XA+EKjM36luPr/AGfSf2ihIdDztgBJakcpvDKgUobY7XlR0fJWw8PARB8uIMY+3OQXDvqA1hNZsbes91xnQIFjXyGf3lIHMpfcoIIO112Y9jcxAFG80+hpm6h7bdSnqfY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec6e9b39-4356-466b-3bdf-08d62d48bf5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 18:06:19.4459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5172
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The DISPLAY power domain on imx6sx has 7 clocks.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/soc/imx/gpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index aa3729ecaa9e..7d14a4b4e82a 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -33,11 +33,11 @@
 #define GPC_PGC_DISP_SR		0x24c
=20
 #define GPU_VPU_PUP_REQ		BIT(1)
 #define GPU_VPU_PDN_REQ		BIT(0)
=20
-#define GPC_CLK_MAX		6
+#define GPC_CLK_MAX		7
=20
 #define PGC_DOMAIN_FLAG_NO_PD		BIT(0)
=20
 struct imx_pm_domain {
 	struct generic_pm_domain base;
--=20
2.17.1

