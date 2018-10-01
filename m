Return-Path: <SRS0=/qR3=MN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F12C43143
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 20:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA992089A
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 20:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hGz2fy55"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FA992089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbeJBDgY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Oct 2018 23:36:24 -0400
Received: from mail-eopbgr40072.outbound.protection.outlook.com ([40.107.4.72]:43648
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726192AbeJBDgX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Oct 2018 23:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yKB5JTuGIe1TdTbAFcxXbYK7jDi9HONS4Qjp6QPcbY=;
 b=hGz2fy55G2g9iozw8bFdfyjsPSf0CkZqmSW19eUSIbmY59b7yGUhilUX6G3VqBqCPibYFdyf5+2trd5SXzCE/1qaZtxkGDL/MLnUf4YF/P1Dge1HfGOtVKaj2evo9arcvV3IWhYb8MXCmEGIAt6fsIh5poJIWWB2Q70Oy0vDYUg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 VI1PR04MB4303.eurprd04.prod.outlook.com (2603:10a6:803:3f::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.25; Mon, 1 Oct 2018 20:56:36 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Stefan Agner <stefan@agner.ch>, Marek Vasut <marex@denx.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de
Subject: [PATCH 1/3] soc: imx: gpc: Increase GPC_CLK_MAX to 7
Date:   Mon,  1 Oct 2018 23:56:16 +0300
Message-Id: <f224bad2c4bf8d09faded5fe557463e313e368de.1538426534.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1538426534.git.leonard.crestez@nxp.com>
References: <cover.1538426534.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: HE1P190CA0058.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::47)
 To VI1PR04MB4303.eurprd04.prod.outlook.com (2603:10a6:803:3f::30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcbc27ae-d593-4f8e-7dc8-08d627e06128
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4303;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4303;3:Bx0UFvcVKfpdKOhPfVXFKOeKs3Z1C84lyDX/gUmzMfswIVpdKIRo5s+nuQ0a9RjxZWvACHb23DHXNpZqPCl1YQK24Y9cqAA873VkjqVRYkJmXdW/FF8B4oqKA6l9vdwlE/hcyxyozwA2X0Drs4y7DXLqG80Y9JsRb0Jk4kG207mOwsC9rhkz0jqOyxZhJTRMkTEgrEK6R9m7fljztYu+MiAjRKSS4kz0kSekm2iWaE6ei4e1jlu5mADVmtHXI8eH;25:klEWq5lGIGGdmehO/mnSa9vSdNJVT92fgrHEbG1IGQgZNtBLsnW4dmdbWviraYGrzwj3Czi6ctsN3ZaCvAIARdMiHbfZHHnhcLxWyEn4JPI0hx81+YTi74vSEDkgaenlpcvZKpx0kR/Efj3JkhndoDjMzDNGZbM2Se4jiyUZZuEilUTMbu8mYCmr/7kTzf5VcipK/xkYLalL0Rh+rly7VwdzFLESMOp0bFJYNBhZoMVc1OToDvhFu7M+21T3gres+lOjGeio0UM3ZfmLSi3AiYSTezqQYekeadbRzEqt5i6+hIi64/TPEaHBuQVqMadGyb9+g1FUqxJ+I8hvPKQNwg==;31:Gxvvs0qzmqYV5zBvIxGZAsv3/14yUenOYQYFul7UxSB/5WZ/48MS3FLXzYuMymCOhsONMI+HzKFTjO0EQWV01Hz/ld/np0g8wAA1fIzWVZN2rybqKU2AMZSS2gFTG4SzypiLqOtsmgliWRuRebkgP4QT6RB5jd5OA9NIWT1LuYhvppysllsqZBX6r+xe8mPZq1/EMwHy2hF+ai4XlbENAgStBi/pIpZh2FpMFOlBU5I=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4303:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4303;20:aCgZEJA41WykM7UkTENddUPnFNoDKPWKaMyzhjFLBL2q6WaFgkzPs3bBx5Os46ObhWpKYD6iylQ9atyfATyO/CWo2lpO0hom8zCFvCPYIuN5A81FEdJPBwN3+vPoWZWsjq8RORKtHOs1acbvkpAyVftbkeVyxl432nPCl21L2OuKU5CRCR3WlqRyNmSFLkb2nh880wyjM5eCIVdPNxLshfef2+4AGHQOioG7USvI0ZB8+s1zRTn6xtXiKpCnJhIpkEUfxI3DS8J4biH9tLOh9KfvG27o+a+QBrKWLHMuTRCI7NaT9/esv0UvgAX/en9d6+WfbFgZacvGjtZ1IZkAuah066D+696UN4S5NFt7r4AigUYPHpxO70hnHXO8+CfSsDNUDimtDR7Ri57nPPMpTbyiOu+/rAUAIznyIJfzOTDHDC2oAuVaVWz7jN/kL6V1zpfTYb5FJnx5VY26Ul4gKr0fdjEppS1C+4bihtnJd9CA/EIRRF4pZDZraHnDs7JP;4:kw8GFIxbbToirpthfsZ0XG9XQRT/41G04YyyCfyeUyrSJOw7sNWtjCYZMJGhZ/TRaE1aRB+tuPf0T65m5sus0woGz5vunmK15mOopWRFHwzTKSqQpkpPG4/fHeNt5NWYgz5poaTw4Wd+gyi9wJG91wUOTYXESuBqXiGAS2BzQwYCsn2HKb3/dWeYjI9MNiNbEXKfOPn+Uu6pUoeZzRIt7WYDCcO5rgK70uXyW6CI7Sd/eiVSbkElqmNTkLQ01Q2SSFTqod/zsXNhPEHYBD7iWr2Gv7DR1+aakrbyzHuS7ooOXQ4+//LKcsya/FIaUnhiz60Fi6F4rpQtVBf7Ju06IyDy5+VUloc3vrRnXicSdlo=
X-Microsoft-Antispam-PRVS: <VI1PR04MB43034F505A1A89EAE0D54C9AEEEF0@VI1PR04MB4303.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(269456686620040)(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699051);SRVR:VI1PR04MB4303;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4303;
X-Forefront-PRVS: 0812095267
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(136003)(366004)(376002)(346002)(396003)(199004)(189003)(5660300001)(6506007)(386003)(316002)(3846002)(16586007)(6512007)(36756003)(6116002)(53936002)(54906003)(110136005)(575784001)(86362001)(52116002)(51416003)(76176011)(6486002)(44832011)(11346002)(476003)(118296001)(2616005)(6666003)(956004)(2906002)(50226002)(68736007)(8936002)(81156014)(446003)(81166006)(8676002)(486006)(97736004)(105586002)(106356001)(478600001)(25786009)(48376002)(4326008)(16526019)(186003)(69590400006)(26005)(7416002)(305945005)(14444005)(7736002)(47776003)(50466002)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4303;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB4303;23:R6c19x1CMBMWF47ryzTJk4PQ3l3aB/PmvXsh/h+da?=
 =?us-ascii?Q?DduZQbPSwMhax99JERg7kUcbA4PD4RcvXH635WrqX61LJEQnv3Q4lOWYtmXO?=
 =?us-ascii?Q?2ab7PrnVfvPth9F2gKlfkdr4qRk4Lk+fb7Se0tgFVKm8l99hkdcX6L4kPAd8?=
 =?us-ascii?Q?H9LuWVwm+BR+6SxlGNrZJmo1jq8ZUpUAWFhnzqLQt/l92BTeayYkEh6WJ/aC?=
 =?us-ascii?Q?wUqdnTrA4HsUhNpD+ii3XwuLhVFVMMndqOtfBcrJwRz2JgJW3PVxb1FDbKtt?=
 =?us-ascii?Q?ihtWWZN+38c/HTHI2thkGD8KD015cfylcZUAb3e0sZnBVwVrLFpThy/apeAA?=
 =?us-ascii?Q?+guHDTEAfjt8cUuIPZoFJHH0pdWsYL/l8pIV9w7m1mr3XUQL9O2DFjhWH2Ol?=
 =?us-ascii?Q?7zLbSJABIBcp37sBK8WnCciC/rZzttDw/jC2Tf8+cIl3z235gB0+CRHMs3z7?=
 =?us-ascii?Q?TsNpSc0xX5g14j8joUp1aFIHoNCb2V8cjk+VhQzLjkuLdhResjN0iw8LmfB2?=
 =?us-ascii?Q?qdjP3yoWzXZTyXV5irXWDAxU9oCOo78KQIF3M/W4YTSd9q9uTHqGac80aTFg?=
 =?us-ascii?Q?MNLCDALWJtoOlS4ollgtMB4GWLN6Xwg32L7Nv0fgnvZkNQnsIhIYsVonp7hH?=
 =?us-ascii?Q?qxP4216A4d28cGGFDwA8jr9Fa5AFBUgRQr8ge3Ui6raRbzn9n/lg+CMzoUmV?=
 =?us-ascii?Q?WfK00zUvJYEenrFE/oSQu7woafroBQhMZtdgU+x0FVH20LmpO+cccXTAmjPs?=
 =?us-ascii?Q?IcM1pNqEDHsJPr19slGhYq/vRFam+WtNLj12sGmIpcuKyfkRW3snIoYh4MxM?=
 =?us-ascii?Q?irC271dV2vuAFQLUSKKjCTeqsOI+8Ec+ORWjqJ5XHExkQlVhgKILlHbqBOZ1?=
 =?us-ascii?Q?lGRDl9uV0OSCDPhDVRxRT0eLm93caefuzOpPLBpK+awRfq3EfwXgHpbxhyp7?=
 =?us-ascii?Q?j+m6BUFI4xCl+c/fISlz22YIsCK/V3Va9/PSLzYZXMPiMv47OamDRnQx06dN?=
 =?us-ascii?Q?wYFHtDfCAebeOKIQs9zRvJFMO3t3gCGOhFNZeBUVqj5ypkWal0qa298zKwEX?=
 =?us-ascii?Q?IpSc2vJIZdEmVjestTZIXZ+guMhhGBpsRlRYTfyfrqmpeAtXCgkuOO2nM94g?=
 =?us-ascii?Q?Ge785tzYEOeP055nHTYfhtYGGUzHZriFDLL4kaLk6NAA/W1LQRg1zR7kMCba?=
 =?us-ascii?Q?6ya/wSpGO9xunnKZVq2282Y0PtafrjJ0dtzNIhdRZ952iEZV6JieVwcXQX2a?=
 =?us-ascii?Q?kN7NqkUIIWp11WA5KAtwmJAeyB9FlSI7PJJHlYeIdGSxspQFFsaBiiChohle?=
 =?us-ascii?Q?pFpkP8WzDinVcWJP61CfNUQNlA5Zo26fl4m8qDfIPVuc5bLbb3uhAJ4GhMSg?=
 =?us-ascii?Q?8XYyA=3D=3D?=
X-Microsoft-Antispam-Message-Info: SPuaVJuKLXihxa5FvvKWPjOVlMWKjL0eCgAEUonjrtzCuEvTI0w3GI2QKYrvORmqYiKRhE7atiIxYnl0RI35vDJ/8l+3mWKuGl+vY/TgYY3YJf3mLN7mwkz5IATZzG+RXLksSzbPswzcKJisiKOH2Cphob0mHv+A1AAbqjclaeeB+0JqNq5SY6TivLJAsJhRWOFWuFzN3yFsK+a0sFtJyJU1c4kkHmzhOthzqwbYcusw44TTLRb7407SmgaLL8gwZcjLPH1aSD20gHYULaPECGDyM3OM9VNed74WW0fqAeVOL14PMV1l3xOY/cIjzFMbAWwffFOtHKivLRTA1SBMiWWyytJlr7RSsQ1ZQE4q92U=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4303;6:t1mECsZdsf7UjAVN6Eb54wN7bzegLXxbUhDfRzvMmBQZy9E1zi5VfbBSCVVKZ9PrPCZ6QaEyov+86WqdA0ydmuddb5LNjE9MiplK1J10bqUSAV17FK7gX7g7RhPbFssfCA6G/GDM8Lzhc2GeKMgebG0P0Hp6Z7cz6PfazfdJbvT/0VS2ww7/M39m0eE3OYt83neQa+indL7nWL6G2YhZnWt6FP/JpZXm5hQMAWZ5l9J7YgL1CJvEFjctEZxY9KMRffu1kLC9yw0ajYu2BMvdL4GCBilVONlhQXZ/YaJSqHoNv/+j+XxtLiqR6JchZLqr05vYoz3BV6u8/cQ0tTerVDe9JOCyqDP7GiPwWht3tOyfs3ZXVQKbphEsFrrz7jVqjhBS0ebgJlCfLnhWbcmnrJzKGKv96Uv2co/hdZZP+/R81Fbc0yocgKBaXJdkEu/TI/uljPPtOz9ooWVL9o/2RQ==;5:kscfWbXT8nNonZ87sN0P+y7NZJEbod1oCy0mvodnQNxAa+jVJGv9/0rotgAbM5BFN+IrYSSGmwNuLllBFh1RJTUl6cms2LGR9h5FSgk7K1ZcykEHmS7cMabc1oyE6gvPifc8S38+owkhFoy0MI6c5n2P/r/WtVsxpH8EfFMB1ik=;7:vWoXbvIvCmMeMQdoTdOCpSyLwLLv7JvrFsgWn8njiYVdCiHMmDcRIj11fA8fQ2IpNC/Ukyh+Zp2XU1S+zzxN7bD5yJySgMXMb+iXe7Sg3Qng+MJ6+mOdumalYW7zfFskfDH4xFqobzkIXO4RmVU5kgdgJjJtA6kE2fysS3XwpWHIEoLwbqNo6h0ZKw8S55etxbRRJGN6N4gJS96YMjkEZe2v8znpFAnEVFrEW2wNgAJ6iaKd3+G/i48CvSTgB/qQ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2018 20:56:36.0236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcbc27ae-d593-4f8e-7dc8-08d627e06128
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4303
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
index c1d0ffdac6dd..51cbfe63ec12 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -39,11 +39,11 @@
 #define GPC_PGC_DISP_SR		0x24c
 
 #define GPU_VPU_PUP_REQ		BIT(1)
 #define GPU_VPU_PDN_REQ		BIT(0)
 
-#define GPC_CLK_MAX		6
+#define GPC_CLK_MAX		7
 
 #define PGC_DOMAIN_FLAG_NO_PD		BIT(0)
 
 struct imx_pm_domain {
 	struct generic_pm_domain base;
-- 
2.17.1

