Return-Path: <SRS0=j7M/=MU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E61C6787E
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 03:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A7322088F
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 03:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Zub95hOz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A7322088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbeJHKZF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Oct 2018 06:25:05 -0400
Received: from mail-eopbgr40075.outbound.protection.outlook.com ([40.107.4.75]:32637
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726295AbeJHKZF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Oct 2018 06:25:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKImFC8psHteWaaADErTRKBwwT/kUGMzR8esUIAF7gk=;
 b=Zub95hOz//sxHcE8U5M0Ga8QueP4WCiIsCyFKTxFJ7FYVRLtfjxLiEi4d5xLkpTpmvOxzni+DUz+KhIoWOiJxXt9sXrfKAVRmxxXtvOS+quv7vpM321qBasahv2soF2wsRXIcFYC7PkC+omE2nOMtI9lg5NEyduGNG82goxbuYw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
Received: from mega.ap.freescale.net (119.31.174.73) by
 AM3PR04MB1220.eurprd04.prod.outlook.com (2a01:111:e400:586d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.28; Mon, 8 Oct
 2018 03:15:28 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, leoyang.li@nxp.com, shawnguo@kernel.org,
        mark.rutland@arm.com, bhelgaas@google.com, Mingkai.Hu@nxp.com,
        Minghuan.Lian@nxp.com
Cc:     Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCH 2/4] doc/layerscape-pci: removed unsuitable compatible string
Date:   Mon,  8 Oct 2018 11:14:26 +0800
Message-Id: <20181008031428.25293-3-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008031428.25293-1-Zhiqiang.Hou@nxp.com>
References: <20181008031428.25293-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.73]
X-ClientProxiedBy: HK0PR03CA0085.apcprd03.prod.outlook.com
 (2603:1096:203:72::25) To AM3PR04MB1220.eurprd04.prod.outlook.com
 (2a01:111:e400:586d::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f3edec1-9cda-4fc0-2e7c-08d62ccc4e6b
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1220;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1220;3:uZ0rEBJFNjBCJHBzYuMsnkrJmTM+Sw5ahViYqs7kHCCPgHz5kdVoUSuacNJrYwElcAratDCn5oCjP7R8Cc8ePd1nPxhaafENe+Ia/5rsfMBpGmDYqvb49glCnf1++9Zb9muuInXWStd0c3GcNwWBeeAWW4A+3KWTe9HAZQQgN1t5ylq5seZeBCHrDpcQBeJ3dB73dBdq2r1ZNbhyVCKFb9AXtoXo9QAGk7gI+UYNuAXC7v/xmUS4NLkytMrxHhN8;25:8RSKeA76qxxcMUMZO7k55nPR+5CT2HvgzXfjuhCrpcqoJeJeNsVhs1EtcnspQeNAFBRF3LTef6GvIGfp1pUvlZZpDXH2BZQucdk+eZyqCody4c8y6tZZ40Jn5ZomFSoFRpBM/2NBsyAoOYojrUgxpcQBwkQ9XTsQXry5gea18KSZ7/1SeYXXeiXPpuh2tsz2/sRjOIg0b6EHOlHouLZzEIhLCVKWQckGWqjs90mGejWUfPsmtpkEcMaz7Xx71+cZpeT3fVjGfL8bnld0RqgoX12che+ld503BHA/qWlA5ly+J9svPygUwjBwa7rssVv21auQKsx35tBHWi34F6yUlA==;31:AsEL6+SwPiBprnpHw+eNmECxY2qgARIQzM9eaUIXs5cGsRe+Pgh18pPqporl87QF6CO69Cz7drCK+G5+pTRDo7m1PybX4dunXQezzLcMsStJRuEwlVZBwCotHMm8G/oyNCMgdcbRA5EGdKCH6ECu0oILntW7NkrO0C9Z0PurGxzxr5T7X/XCMb4lfFR03ybFt5OPTlLnX/O/PVr/OeECBHLtswUZoL/q5a1eWDbbisc=
X-MS-TrafficTypeDiagnostic: AM3PR04MB1220:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1220;20:ds/nF1T7l4HXf7H6XT2EBKleJXX9dTvFvvCGzSPPZyQA/s0yL7iitx1vbAkDXl28bM5dSI8YJnf+K9xzlCVi3E51JcgLQaY/Bxn6MJ2jDTWm4+Rx/K2lHBZJwnF3qvS2/P+5A9Y/4Pz6Jie69BFcp00wjZ1nRxI04+ApLfhxgVeR18YzOi32EnVRF2302762/w7ghZ7Xj3kRyoDAtHaL0UzKggPnH7RuDydY9dyoyvTdBkddfNiMlsfSVAzYbecrghOD9vMYruV/8690qzsfhbwCtoIEvoo8D25CxRFEOjMgUCYI7m/BSUpJOgWlBJDFG5NU6nyr6kPRCQKfeBmkGTX4fEOiKN/y6W2ubEhNUUS+5NhNsR+Xgz+Wx2pIQFbSZ4OObZ6TK2D8DtC2TQL9x3IdBAzVvJ/ae9hXzaJJlR9XUbv5XHuAqXu2Bqu4D2DKataRnNRnone4xAC86w37OdZNe46qFPnn/Zi1ApHPD8BDeCVGDgoA5p5nTczn4DPn;4:IQwpHfsp4HKaBBavGTfAvhtBQt2a13bomflo74uyNQWQRn2BwgxzGZjQARgVTyj215xKrNHGeWQTFolPQ6TZGh4/D/bKnGZ4ZtyhSEY11HuarO5ALDThy6X0gHltTBosrWRRcKAYwpT+POfzWrid8i9oqF1aSD/kiZ+yx7akZFG7DLIBHqvDQKJBBmb/d/H/9LmyaV14NkmWmRYh0iWqOjrSxQWTWxniQcv+x4HxyCpWODj98O5JtStv7xecMutdGmSP9ZtZR7k+aCvqAIWKqPEyqUrcQagBSsuQywomqCCKYIAXSjmMle+icYxT5OV0
X-Microsoft-Antispam-PRVS: <AM3PR04MB122069B25BE0809E6DC3BFD784E60@AM3PR04MB1220.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991055);SRVR:AM3PR04MB1220;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1220;
X-Forefront-PRVS: 081904387B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(366004)(136003)(199004)(189003)(25786009)(16586007)(4326008)(446003)(316002)(2616005)(956004)(52116002)(51416003)(476003)(86362001)(48376002)(53936002)(6512007)(486006)(2906002)(68736007)(1076002)(305945005)(7736002)(50466002)(5660300001)(76176011)(11346002)(6506007)(36756003)(386003)(50226002)(3846002)(6116002)(97736004)(8936002)(478600001)(66066001)(186003)(6486002)(16526019)(6636002)(81156014)(106356001)(81166006)(105586002)(8676002)(47776003)(26005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1220;H:mega.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB1220;23:CWj3E7llhmy9Slht6Q7/PfQHZ0XJ7wcEh0wQ6vr1g?=
 =?us-ascii?Q?l7XpSYwfel9Fl72dSPjNWWyBU8sZKmvjT4i71eBrX899usJwIY0y504rbVoT?=
 =?us-ascii?Q?Mjvv90G1lHwkXPUuxUViNEAzw/25JwgB+Mdab7lHR2eeDd1zrsCiSMmk4ZoN?=
 =?us-ascii?Q?L35QOPttTExl8ijz5MLJPZBjOJ6auhzxHy7CDzLwlbdOZB98q4hjm44HMaos?=
 =?us-ascii?Q?jwWxVuwzD2RLxD7UQKd9DPUfovuKwxWL8NBQFYYkSIdPQNx2z6AwXZWoQbmO?=
 =?us-ascii?Q?HgUVylV3vErsM3NmzM78Y8caFSFokXiFXroQwIcW9y9E4ac7JvcRjUkDiBzd?=
 =?us-ascii?Q?XQAtSgwXlVSyc9/vU+3FhZSy+0swNtMPOetx0vcJFuPl7rHErCdp4+MJBZdK?=
 =?us-ascii?Q?Wnwv2OTDrip9HgkH38Y1uzdtj1tanSHN7jPLPUsv9El+mPjqJqwCOW6GndlV?=
 =?us-ascii?Q?z5YtZOxQtmXqhQNdnMkImATXaCGgc5aTdNWrnPHtRN1gO3T2rWn/DMF2wLak?=
 =?us-ascii?Q?229HoqUNJVKQ7Zwyl0vZVUgq0KRuocxfr30g3b76g6ucUA7FPTVTVR9soCkb?=
 =?us-ascii?Q?OK63pSz7lEbXrMBIeHs5rPg7Mq7O81Q6wwC4LZa0xsJdt97JnznTvPmZlzsJ?=
 =?us-ascii?Q?zYu5sn7/+JXQBxtA1AyK5d0U4PFbF47sxaL826EFEpfTfZkxThGyfe+GrInT?=
 =?us-ascii?Q?dEhmfypNKjZ5fBg5drq79Rfx/WhBbJ+p1bD1zUAfFd/zU4yOzEbUMh+IKSNl?=
 =?us-ascii?Q?XXgUkqUFiehcmq4RVeSwySXwCRIaoe9Y9/H52H3hxXGa9W/mGi8RRsdwwWJ0?=
 =?us-ascii?Q?xSP7LsII5nhcDh3h3wvU0Cn5tRVAWuBrbwa3kPx3J37Dk827ZSuMDqWDQfU1?=
 =?us-ascii?Q?UKwKZZvd1hdHqPanoIDfwdZu0xzEB2vSeWhe/WLQK7DccigC9s471SpTLwvz?=
 =?us-ascii?Q?iW0fR5mtPayN6RtjztDkOM/Hk5j2ywK5/gd1TNOft1vczfQaZcDq+RWU+7TK?=
 =?us-ascii?Q?qJwTtzY8eyjjGErOduBNbxwvig9G0+wFVWGd/liYKLKD1NQYcnuQrEGRXwrs?=
 =?us-ascii?Q?FYXKsQewpkQac66KSWsnurkzgsc592e84c1LXy1oBSkrpcnamvQ8bbs43B9O?=
 =?us-ascii?Q?c274PBT1bgDxxMkiu7rInTKq/ufnruSAjvriP+Ej+7Gel37LHMZvJHDpgOGx?=
 =?us-ascii?Q?1WTr+KVp+7UY0Sp9Y1mH/b3jiTS+Xk2NaHW?=
X-Microsoft-Antispam-Message-Info: pFziAbEaT5MsjV9ZFn3ykEj7m2RFqCP/duJZArW+BKUJ/LwCxxEhAQZKrtYDNev4Z+miB4lnZkKpdRjoT7t/U41NXtBIeUrkxiI3Q6RLuNT/2nfSxvZAB/nkHO0YF2kLI00RF86sl9c5lpVormG7sp1utCOCFHih+oDOvbRDcYQJF0b3ijSmHWmzL1/9PkMVJEkBBTkaYUc8Ie17qmEBoKJd/CJWvSGdrZqB3bn4yjdPBA9M+ZMpXt9mkNZmXXJ17jCOGPOswUYEIRfIWLa7ywqhQzMXG46FvMbW0/D9RuDD8XL/0yuKNoabRxTeNsAoZV1Woi+duGpp6SrGImYtvsDtBSNHIEB63Z2xBd5hf7E=
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1220;6:QHsWPuEwuMKldQF//VJNYXNtxxHbxzfn2udAZ0Vx9sWFvuynM5ByKx+LJ+KE7rjil2pYG9IePsYHzbAdifr24RVur/Xfx11x1rVgGflYzAcd72Cpo+kg19s+DXjx2Sq8+aWiN7UPX7R63ZtnruEcPf2HyHkY+ZyFPoE+/WjZ2wPV5q6Lw3J6/r0LY62B7N7ZpXx4YtmHql28S1X+QsX9hCvmMHQQ9b0FYzpYTu8UxuNHMvsp1MZ2adpKKy2BUA/5/y1+yUQj8aYYEIk59hytRvAUqqmVP1XR3/c/1YjTxZQvUb7jVcHACU+R3XEGrnjhyniUDKrxIznDuNsatuusRdxz9D5CNFC5nR4bdvI4LK3nzYWHzyuzZoTlppqHrbi4x1c6KFcjzahCg9JZbdSYUnr0owNrXF2jWDn5CePd9889JWH7sqqqZNpbZiFKtdLvEN1ELCJW3JJ/V7ZW2rPT+w==;5:eJ7d7Q++tUCN6BARm8yAPwTv2Ni0Tc4A3E3EMt60jm/x5aoB0AbAI+vDW96vABrmGaNKOiJReC/wxcq65ySGQquc5ssMNax3U8zxqP+Mbh8LaXFvlbWb8jEfbmP8OK4bLuS6ZduZS96eXbfICuwNrh10SXcTGkHbojRd46bSEVA=;7:BkBegh5ZjRpwF023rU9tITVYW+TLfrbNSv4DA40rQVRUmW9vBSTU0NB/DuDNacNevzrWGvaZgvZtB0p//y6i3Tc/B8oFDF/Lpz+IPJTjJZtQUXMfh5n+sw1iI4xT+NbscU5emwdLaObjODDNLW+UnssTVsIogto0mxJ76O2DtfZ2Zt8XD7PpUQLkbgI8QCpE49EzwS9PAp+IGxTbbqMR7fi+K+fv3zfvwmT+vL8H+bXKFAy6p9gZNADKtkghze6r
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2018 03:15:28.1749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f3edec1-9cda-4fc0-2e7c-08d62ccc4e6b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1220
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Removed the compatible string "snps,dw-pcie", it is for the reference
platform driver for PCI RC IP Protoyping Kits based on the ARC SDP,
so it is not suitable for all platform with designware PCIe controller,
and platform vendors have themselves' drivers.

The compatible string "snsp,dw-pcie" was added by mistake and it's not
matched that time, but it is matched because pcie drivers has been
collected recently.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 Documentation/devicetree/bindings/pci/layerscape-pci.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
index 5eb1c202932f..9b2b8d66d1f4 100644
--- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
+++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
@@ -13,8 +13,8 @@ information.
 
 Required properties:
 - compatible: should contain the platform identifier such as:
-        "fsl,ls1021a-pcie", "snps,dw-pcie"
-        "fsl,ls2080a-pcie", "fsl,ls2085a-pcie", "snps,dw-pcie"
+        "fsl,ls1021a-pcie"
+        "fsl,ls2080a-pcie", "fsl,ls2085a-pcie"
         "fsl,ls2088a-pcie"
         "fsl,ls1088a-pcie"
         "fsl,ls1046a-pcie"
@@ -36,7 +36,7 @@ Required properties:
 Example:
 
 	pcie@3400000 {
-		compatible = "fsl,ls1021a-pcie", "snps,dw-pcie";
+		compatible = "fsl,ls1021a-pcie";
 		reg = <0x00 0x03400000 0x0 0x00010000   /* controller registers */
 		       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
 		reg-names = "regs", "config";
-- 
2.17.1

