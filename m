Return-Path: <SRS0=j7M/=MU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6541FC6787E
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 03:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D98F2087D
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 03:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ISHKDL/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D98F2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbeJHKZ2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Oct 2018 06:25:28 -0400
Received: from mail-eopbgr40042.outbound.protection.outlook.com ([40.107.4.42]:52992
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726295AbeJHKZ1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Oct 2018 06:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4FV8Q/5BHF7COg4vkegGZ1/lZXYxycle/KVwZiq4LE=;
 b=ISHKDL/EHz68J3fFwA1CblnPw5wrw5NZfhHa3migWmk4wzte0t2B6RzbbXz5pd7gQITEZcF9zfWndzuBw+6T4Cx0HTEuYLoTUL9MYrrqUcvPM4cW2DWLp1MGRy8OUYpHCxruQFe4awVvvPPXHzfkDtIZL81O1hMRNhl8gNJAPz0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
Received: from mega.ap.freescale.net (119.31.174.73) by
 AM3PR04MB1220.eurprd04.prod.outlook.com (2a01:111:e400:586d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.28; Mon, 8 Oct
 2018 03:15:37 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, leoyang.li@nxp.com, shawnguo@kernel.org,
        mark.rutland@arm.com, bhelgaas@google.com, Mingkai.Hu@nxp.com,
        Minghuan.Lian@nxp.com
Cc:     Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCH 4/4] dts/arm64/layerscape: Clean PCIe controller compatible strings
Date:   Mon,  8 Oct 2018 11:14:28 +0800
Message-Id: <20181008031428.25293-5-Zhiqiang.Hou@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 115e1f5f-cee9-4e84-dee6-08d62ccc53bb
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1220;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1220;3:5wBBlVTSU36S4tEnGEFg7qLUcxDF6otrrP2qMihBboOTA1gVkskLhvSUEiZucUM9LV9zrb+e1PCkKsDhU9Ouz67vOEP/OyK5zr9LYFcFq8QrOzqNoBqmxb1W0aZGjVaUiopNvOx4HgC8I/522CvMaV+ha07nEYJKtWRxh9KBsy/atgnTBkQgUxucorE+bjMVaeDZ4Nf2TXH/JV3JZgioQyRvCh8xeG9uDldXSezmsTSa7kkHT0i2zHcfOrbywDG4;25:7JWPX95aNHn2gbd27Du5Jl77WoXQ9PQALjhFS/vv3Gl6+1JEYNmyn6pnMDtywL47rRFf84wKPdvLT4X/BY4uS8c6ySJWMyysF/7deJ2r284GlPxoddUcR+FCDYOblbUxDYifu5R0VKes5ae3pLdXISiFU1Ro/VYHmk+IDlJEO1BBw0vgoOQlse/u6BbX7gSeyzG+GO/E/6eNlxLVSLdI5PRLoNpAs3AC1rv+vS4ndSGCrGzsD9w06ipPGRPNeIlv771h8EIGLqAQeO+GDhJ/csobu1OTASG/gS6DgiR7yGbAa8asifFBPZ4/CtS2dwFeWjVZiO8VGdLMTniEilrNkg==;31:Y2lN4VF1Xv/85APeUthY141thd7DyHTZN5W6OwkfXZeJbjFh0TUgpiH2Wj06IHpvhqFKNej/rblcZrr75frc26fCi0IX53YrJaGbcatCUoy+/1JWIJIpdbCQ8Iid72zXtcdf+laR1qI+2so869xtKmHkMHFmlPOtUF7Llfl4E2CTX2x5PbLU3ixR2WLIMNGRdhAUQHhuCQOXRr0RzFa+CKXJaX8APSIPXXFSjTZlaxc=
X-MS-TrafficTypeDiagnostic: AM3PR04MB1220:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1220;20:m1Wq4/NzPmYRNayvnMdKHMiCvy25oBgOkH5IJzVubYilz/ZsScSyAyRvkFzgpwmzEJwg5nFb80hKE8K6RmfFPa1rAbVXB2VbUOor3oJVjJCSa0HfdLzOlb5tNlcl/rYsfkhjN1izq3hs1VM1fWrlJ6LdlZuRFcVHELm+XwiRTHoKHpn9SdLZPgKIjik8pi8ke05/IkeWbBQ9GEaual+X/2rqOEsDJbzfxqt6EN6SHanfpIEpK9IUAUtqnBRSRxu6dACVf+aNmYHYDbTJ46Tj4zohvh1qfXfUvt93jgF8LqPIuISOVjyloNJySO9Ked0H2CpRY59f+S9Wg4YFzon2qvhq3YFA7qQfN4SB54J8Kuw4XVAQRE2/UNkaL2v3EMgoMGBk+2E2f4iewruw7Ed+0sEe8+DKHVbqasWtlGxdlLuA2W+zLdn1z1VI5cSKkZbYkAI0YxOQDbRDOCaMoFHXvs9PNDB0nmUdcBT9El+/k6aFugEP8RoGwSv4DVkq30qd;4:9l9/Jg1JkeLHfiYQA/RnwDeQcR71v7aUvnx2jRvAJVFB8dIpEsImSNrF/KUjukq1GdeU/d2k+aUx+JopOS0AlQ8jRKlA3JpLWuI8FvFT5EUWlUJEFOB+gzhRbT2DEgtAnHMV0WWfg7qkozNg7xA7JJDdl98XOfrD6woCpkk0+mkGwYKDFasvvEuXz0qDJbCmnTSUamODNjjJ08OEXPyIzsYCMUXLQuEw1CbXNMCptbZou9Kwz6dFX/JBeC4M8OOKpjgyAQYyr5fjeJ9VtHfjKwVe8LxWnPU9eQ+GBzXZDRyslsMVHY3MwAqQ6nxO7x8g
X-Microsoft-Antispam-PRVS: <AM3PR04MB12206433FD4E5C6589D843B284E60@AM3PR04MB1220.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991055);SRVR:AM3PR04MB1220;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1220;
X-Forefront-PRVS: 081904387B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(366004)(136003)(199004)(189003)(25786009)(16586007)(4326008)(446003)(316002)(2616005)(956004)(52116002)(51416003)(476003)(86362001)(48376002)(53936002)(6512007)(486006)(2906002)(68736007)(1076002)(305945005)(7736002)(50466002)(5660300001)(76176011)(11346002)(6506007)(36756003)(386003)(50226002)(3846002)(6116002)(97736004)(8936002)(478600001)(66066001)(186003)(6486002)(6666003)(16526019)(6636002)(81156014)(106356001)(81166006)(105586002)(8676002)(47776003)(26005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1220;H:mega.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB1220;23:hL3dHJXyUwIoAw4sUhAkWqZG1r4A6tQAkwoz06FbH?=
 =?us-ascii?Q?0n6/xYaxyx7Y0mmnMct7xwMP2Vax4AOTh/bL0SUbFQgC63IngHotvwLBGumi?=
 =?us-ascii?Q?mukdky0hoqgKtrpsiUKIuhLIx1/DmUkGoZEcTPTvlh27oA4PVstHL5n5Tgy5?=
 =?us-ascii?Q?9MG8B+Hm6zC2QGeMaYya6oFRQ0FdkVHFsJg9ksUD8s8TVlcbvxGQQFaQHgpW?=
 =?us-ascii?Q?DQqqk5ZA7jPbPN9WcUV5pTwWEsWI3wa/6Cgj9aD5dVASuobfR0/6fSOw+M6r?=
 =?us-ascii?Q?GQWfZzK9/03ZjxPwlwJ58QkvG1utRIriSysUNqDNxDKC/yD2D7VV5Odsy1gO?=
 =?us-ascii?Q?Q/eknC/t58kGXB/8bJQfrvyX3ndxFQGaChn6kmgH6PhB2V+kBbEtfad2ct9q?=
 =?us-ascii?Q?y3Xs2d19Em6/5H5Jh8iV29w4VPZuxvUCZQV5K09B7kbO+vow0HGHV401f+hP?=
 =?us-ascii?Q?9O4N+wW1t3qzS+mnhL9h3qMcUR647UvmHvyQ7UY0Mbid+15NzGKbjWVG9lR+?=
 =?us-ascii?Q?HLup4q1NZNQ0EEoy6l0d7ZP9bqlvyysMRgNOrh1+bxUc7e6clVHY/yp76kyB?=
 =?us-ascii?Q?enQOpcj9DHGLwA94yUUxgP96WpL3K42HxTGGSuubH1siXE+tk+/YzNugrOKS?=
 =?us-ascii?Q?HyEnKSPGYaV62y0YvvVlQMw31isXVggtHJ9bGZoFfR0RfVN/LsyF/mSJe1lP?=
 =?us-ascii?Q?BLf44QsSjR/zmHqJW6xrkyigsxi/v8IcKUjqJi9VEjGuNMTXaMZrQ33B8T5n?=
 =?us-ascii?Q?CPezk8BUPCM5PDxsQ5MuT4BlY0pQkuxtnPW5/djz8jm7UgPmBi9AxLvegEE6?=
 =?us-ascii?Q?wONNLR8O3sNsHuhNeJj3ixjPighLrAZbHkXO3SiNrB7SZir2ChQ04igYIHiK?=
 =?us-ascii?Q?jHNQ4hAgPOYmpbH0g8Eh5jRNiy9o/g+SrQ4gVymBv5Yx15XT6XjRgG0C9YeY?=
 =?us-ascii?Q?dhpfSCJnOtzU2QJjL33vWLtm5hdbEASpAH/QJWl+0zaYjcGloyC6kMT4aeMG?=
 =?us-ascii?Q?Z2CBTzAf/1HH5Zyx5fBus3stDjfc1bEFyHcqFSBno+0KIXfb+iA0D8Kibjl2?=
 =?us-ascii?Q?ISvUZOs1fm40HqMr1gpR4Okha2KXKHpYDg4MFNovyY/Eb4FPG8AQYC88Bmw9?=
 =?us-ascii?Q?zJbhWbJsiZLuTsyMDV2+6Dz/FT4r8jdNZj8RK31YF1REeO6XDVDEfHkSRdO6?=
 =?us-ascii?Q?Bl/vEa09UhzE0+j2rCABIFqwZEo+wRLH9AglwL/+O6UcSZ36L0WJmwVWg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: BTKZVpIHJTG0STYx82I2BR1/H+YRTK+2uYLPe19WQ74UakNmCjHn1WKkJN+PBKmQR06t6JhFNzWdmPbreRf9jgFBwvysSD2+KhJEdInAfteEaJmA/8VbACN1+sAtSRjEVr8N7J5x9TB01/sAnAgt038l0+aJ1Im2HMZCANXFoveZ0lFsmPHcwJw3phgMAzbecjchc5i2JWg0iyi/EPHg2TTJYg5B3fK8gn/rs4MCx6L2kKgF2wnegGRnPLCsiCecRgL5G7jd7XHgzXDGDmn/J+0IJ36d+9+AVI6wZEoAJbEr5sPt9AjuriEjU2DKcB8vrDgJJbBpE6aSnGudthj5W6emPWc74UIFBFgvsV6NVbI=
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1220;6:+5T5KauB0YStjFP0GVeRvTjRjgfgXSlipc4lhZnzm3jS6iuuf0ViuX43AyEeIzBoEx66MNy8DWpf//9PpXJIqfaTnuqcuzWCbpSBpmhPdjpWbk/hfjSB4gqXu/ylr9/3pLZtbflJUblTSJkdWbBz8BCfWZQ39NpFXMENtErmAwRfLQ9+UiBeLgcLDV8cothl8/d5IiSJuO7SwQMM4WswLT1Vg7na8hB1MX3A7GqaM+hbGdpnbQKDC+GmOscLfGBUaYya5wqXBNEb/eeD9k5uVYxHgnEQUjm9+wIaPFFTVcV3B83faZnYciB1s2kH9bob2J45FrBQU4YyzqIBMpfurKNaG2YhZvLTb3j2kVwRfYVgbagDDVF8EGC7ZK4OQ6BlEbCSKPfHiaw5ua58mOS9u4gbJRe6vlMPvbenKZDAhk0wuAK/h3foML2h4mqBOrGRE6A2d++krXuiE/GhGkjtAQ==;5:uDqlPZG2akdntvmhbzseCrLeYYhHCMSJAQ7iFKaXM6wJV7Zp6wRwcmGykY5crNOSr0JKFGKFr/8fXvZugtw9pTa0AAAAi3Ste9MUwmf/a6ts3vBdWVRVbL5bxYAX50yJdjNbDa3+/7qEFqchc3SEi7L64l2pjfi3tXb1lGHOQpY=;7:x/qMEJ4JNwuSwcJIsW6/junK7F7bor7TtVhIgr+lNB7V05MB8nsHSC08A3ip67hNQ3OYBOYlSk2kW1EsurVaL9gNFeOc6RkXh0LZHa63oDaFsUzUGxDw/UderB9Ey3mej9haAk3oNx0GSnSYmCntkFihw6UVihqX9hFa9Z7p3peplOmT7KGCGlu4vh7IpXLFr3aJdGMOexo1WtTQ+CiYeThnLr5Pkx+WHMMu2neEfkk3mAvQmeUKmw6sa65pw/BY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2018 03:15:37.0953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 115e1f5f-cee9-4e84-dee6-08d62ccc53bb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1220
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Removed the wrong compatible string "snps,dw-pcie", in case
match incorrect driver.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi |  2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi |  6 +++---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi |  6 +++---
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi |  6 +++---
 arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi |  8 ++++----
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 12 ++++--------
 6 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index 68ac78c4564d..d3fe0771d3a0 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -475,7 +475,7 @@
 		};
 
 		pcie@3400000 {
-			compatible = "fsl,ls1012a-pcie", "snps,dw-pcie";
+			compatible = "fsl,ls1012a-pcie";
 			reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
 			       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 6cc4c87614b6..1b61782df73e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -661,7 +661,7 @@
 		};
 
 		pcie@3400000 {
-			compatible = "fsl,ls1043a-pcie", "snps,dw-pcie";
+			compatible = "fsl,ls1043a-pcie";
 			reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
 			       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
@@ -686,7 +686,7 @@
 		};
 
 		pcie@3500000 {
-			compatible = "fsl,ls1043a-pcie", "snps,dw-pcie";
+			compatible = "fsl,ls1043a-pcie";
 			reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
 			       0x48 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
@@ -711,7 +711,7 @@
 		};
 
 		pcie@3600000 {
-			compatible = "fsl,ls1043a-pcie", "snps,dw-pcie";
+			compatible = "fsl,ls1043a-pcie";
 			reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
 			       0x50 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 3a2a14a8e187..71585aefe1ef 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -630,7 +630,7 @@
 		};
 
 		pcie@3400000 {
-			compatible = "fsl,ls1046a-pcie", "snps,dw-pcie";
+			compatible = "fsl,ls1046a-pcie";
 			reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
 			       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
@@ -655,7 +655,7 @@
 		};
 
 		pcie@3500000 {
-			compatible = "fsl,ls1046a-pcie", "snps,dw-pcie";
+			compatible = "fsl,ls1046a-pcie";
 			reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
 			       0x48 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
@@ -680,7 +680,7 @@
 		};
 
 		pcie@3600000 {
-			compatible = "fsl,ls1046a-pcie", "snps,dw-pcie";
+			compatible = "fsl,ls1046a-pcie";
 			reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
 			       0x50 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index a07f612ab56b..10b253c88a16 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -512,7 +512,7 @@
 		};
 
 		pcie@3400000 {
-			compatible = "fsl,ls1088a-pcie", "snps,dw-pcie";
+			compatible = "fsl,ls1088a-pcie";
 			reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
 			       0x20 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
@@ -536,7 +536,7 @@
 		};
 
 		pcie@3500000 {
-			compatible = "fsl,ls1088a-pcie", "snps,dw-pcie";
+			compatible = "fsl,ls1088a-pcie";
 			reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
 			       0x28 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
@@ -560,7 +560,7 @@
 		};
 
 		pcie@3600000 {
-			compatible = "fsl,ls1088a-pcie", "snps,dw-pcie";
+			compatible = "fsl,ls1088a-pcie";
 			reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
 			       0x30 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
index 7c882da3f6b0..a5f668d786b8 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
@@ -119,7 +119,7 @@
 };
 
 &pcie1 {
-	compatible = "fsl,ls2088a-pcie", "snps,dw-pcie";
+	compatible = "fsl,ls2088a-pcie";
 	reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
 	       0x20 0x00000000 0x0 0x00002000>; /* configuration space */
 
@@ -128,7 +128,7 @@
 };
 
 &pcie2 {
-	compatible = "fsl,ls2088a-pcie", "snps,dw-pcie";
+	compatible = "fsl,ls2088a-pcie";
 	reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
 	       0x28 0x00000000 0x0 0x00002000>; /* configuration space */
 
@@ -137,7 +137,7 @@
 };
 
 &pcie3 {
-	compatible = "fsl,ls2088a-pcie", "snps,dw-pcie";
+	compatible = "fsl,ls2088a-pcie";
 	reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
 	       0x30 0x00000000 0x0 0x00002000>; /* configuration space */
 
@@ -146,7 +146,7 @@
 };
 
 &pcie4 {
-	compatible = "fsl,ls2088a-pcie", "snps,dw-pcie";
+	compatible = "fsl,ls2088a-pcie";
 	reg = <0x00 0x03700000 0x0 0x00100000   /* controller registers */
 	       0x38 0x00000000 0x0 0x00002000>; /* configuration space */
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 547a86ec7cd2..d5dd4e7f1099 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -625,8 +625,7 @@
 		};
 
 		pcie1: pcie@3400000 {
-			compatible = "fsl,ls2080a-pcie", "fsl,ls2085a-pcie",
-				     "snps,dw-pcie";
+			compatible = "fsl,ls2080a-pcie", "fsl,ls2085a-pcie";
 			reg-names = "regs", "config";
 			interrupts = <0 108 0x4>; /* Level high type */
 			interrupt-names = "intr";
@@ -646,8 +645,7 @@
 		};
 
 		pcie2: pcie@3500000 {
-			compatible = "fsl,ls2080a-pcie", "fsl,ls2085a-pcie",
-				     "snps,dw-pcie";
+			compatible = "fsl,ls2080a-pcie", "fsl,ls2085a-pcie";
 			reg-names = "regs", "config";
 			interrupts = <0 113 0x4>; /* Level high type */
 			interrupt-names = "intr";
@@ -667,8 +665,7 @@
 		};
 
 		pcie3: pcie@3600000 {
-			compatible = "fsl,ls2080a-pcie", "fsl,ls2085a-pcie",
-				     "snps,dw-pcie";
+			compatible = "fsl,ls2080a-pcie", "fsl,ls2085a-pcie";
 			reg-names = "regs", "config";
 			interrupts = <0 118 0x4>; /* Level high type */
 			interrupt-names = "intr";
@@ -688,8 +685,7 @@
 		};
 
 		pcie4: pcie@3700000 {
-			compatible = "fsl,ls2080a-pcie", "fsl,ls2085a-pcie",
-				     "snps,dw-pcie";
+			compatible = "fsl,ls2080a-pcie", "fsl,ls2085a-pcie";
 			reg-names = "regs", "config";
 			interrupts = <0 123 0x4>; /* Level high type */
 			interrupt-names = "intr";
-- 
2.17.1

