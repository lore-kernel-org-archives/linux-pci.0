Return-Path: <SRS0=/qR3=MN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D5FC00449
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 19:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D952146D
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 19:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="js0MICKI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9D952146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbeJBCdo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Oct 2018 22:33:44 -0400
Received: from mail-eopbgr80058.outbound.protection.outlook.com ([40.107.8.58]:27854
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726565AbeJBCdm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Oct 2018 22:33:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLws/9GWcFqaaUiIhkrcOrQVtykwhJda4Gl+m1r+D4w=;
 b=js0MICKI8CdhKPWnfqYDnhChC8EYe8VZ4sbdgPdsWzRPjvNKtVcs/cGMHeeg+fWUxJVgPAvOyLQ9d3KhhsR6c+le3FzvfiTkuV3elBAotMT1YWc1+9gMZyVmHik/dVjCE43Ek+Xa49wV8+PsvAwAE/gTxMDhkxd659KQp2SiUhE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM6PR04MB4293.eurprd04.prod.outlook.com (2603:10a6:209:4f::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.22; Mon, 1 Oct 2018 19:54:10 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] ARM: dts: imx7d: Add turnoff reset
Date:   Mon,  1 Oct 2018 22:53:47 +0300
Message-Id: <50b195c5fb2001a8e4b2d49cd8c473fabb5f3555.1538423063.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1538423063.git.leonard.crestez@nxp.com>
References: <cover.1538423063.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: VI1P194CA0013.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:800:be::23) To AM6PR04MB4293.eurprd04.prod.outlook.com
 (2603:10a6:209:4f::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed432979-257f-4d9a-703b-08d627d7a889
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4293;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;3:GQQXz0ZzZykEoxuDjAZY70m7djgxRedtt4WttLW05X88roYZ3GFAGpTdLgJ+0H8jqyLPfi4gL3yR8pMi64ilft66IUQRagRiYICXkDHEWB2jpkMXn3CJprJgvzG1l8s5sAy+3Afkb5FrFL+5IrG5VUPOG5mGMZarW1vTSxuR238csu7Dn8uOggFHZzCmR//1loxnlX4n6f+A3LolRj178tVRgdQ2PAfUCiIekrjfziRbab0Gvfgjsj2L6SPIY0HD;25:QeOc3QQ0v5ZIlPKBUjiurY0xCvORDILV+jMElqYbQbxSWxlwezg9hG11OrCtpVr/jxRmDwWjvU2Y5Jslh+27LaHhshIs8BwrZ3CvryaWBK2cF8aUzJSJvKuJr+Oy4HiXSIo6M7lmw94s9QE9cDsEgiP9JjvOCuEIzwfzAyn44RfqCF1ZrWFmCPYEbDOQA/bz/zFDuuSzCvlP/xtltVwuMVPrdHcEJ7BonRltWOVwjKGRdMq+c5wn4yPQStGA+mzMOPes6lnnleo3rW8qeSTfdxJjD1nbVdRalkT/ope94JOGGF3BuESXUiz9lrSeduX/vlD5FSp6S7PNbhF0vLsuKA==;31:PRQ0xYLR+lMy4FrwUKfR5VZSYQh3KX/TV7U3KmHpEfoEZm7HmiB762xhzivIXR1DAWnmOfR009e1dwFvp2THpb5aJ2MMba362kv/YQkjYDIF1V6dr0nIdA1TC4yt2AUapmzC8NU1/98zL8ROcF51wPP9Pk9Aka6LxLEEVQPF5wcKAmMLQbpo+d/gkM1YZH5B+Dkf+uVDJdOB3yc/vBgbscWEp0/E/+HtfCZhie+YOvw=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4293:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;20:eWxMtSfp0W8U9m5yALig9mm0F6bnQRKDgNZQuTsq9+Q9zi9iivByAOMC5VlP0FMvG9YorunHjzJgObcqBv9NBoShz80ZX1IcOhBJ8fsKeQ1b5rjZrjjLr0GiJrL7S0uByf7/7eqesNH5vntQFE/jv8P8QrqdxVlKZ9TtvZo9jrdv0DH0lLdV0EMpnk4Ag09mFis26rtJl5MbWl+AEKUMJnUNK/BjQiWZ1f5m9V/xApuUWrFzORMXF5xqhXJbn93zq7nwATTOPRJ6nekXm1ubWxaJstgS/0+s1syq5u/UJ22ap9hYoAH/BsN6hePEq05vV3zQokCMSqFnEqLs/Qu+goL437Wh3/vX2YEHbsWXUYcPYu4AZMINYhyrzubAFZFosR99Rs9GZQsCwnIwokaLpkXZkqE2cKc026gAafZdDoUOAn0b7WKRH0cGgTN8HYOY2WS/w8n+Cn1pxKI/xN5MyoDJGbk7LzCfMo9vWGQRqhLob10aRpjOvD08bhF+Lebk;4:WfqEpkt+TfHlew0S9zjQZwrjF+e61sQPEeRYfErR4wPK/6CkrE5t/f0n89GZhwRJ9IX7M2ijUtkPNCnYJEV17XkJ4/d6PJXH3UDDrsVEG8P9qMjr1qX4LTDiKldVvqJQRsO/7NzIRjFaG1gEjh7z7pcwwm84WWc4vEI4hsQjN6UnPQltAqfS1Gv8CkLRcXFjeZpsNWanLlsZhI8zA+8wpOxn1tmvILjGNOMy2RYlt8It2R2eGc7048w1XqJSFLn+RJNaxE45AMHUab2cPtkvol1+j8fpost8lDzd5Y02tycYagiziG0vpj57ixBEcf7g
X-Microsoft-Antispam-PRVS: <AM6PR04MB42932F105D421E12B3862244EEEF0@AM6PR04MB4293.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:AM6PR04MB4293;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4293;
X-Forefront-PRVS: 0812095267
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(366004)(346002)(396003)(136003)(376002)(189003)(199004)(6486002)(7416002)(110136005)(54906003)(118296001)(6116002)(53936002)(6506007)(386003)(3846002)(11346002)(478600001)(105586002)(16586007)(7736002)(50466002)(6512007)(66066001)(47776003)(25786009)(956004)(486006)(305945005)(476003)(48376002)(26005)(2616005)(51416003)(52116002)(106356001)(6666003)(2906002)(39060400002)(97736004)(16526019)(186003)(14444005)(76176011)(446003)(44832011)(86362001)(5660300001)(50226002)(68736007)(69590400006)(8936002)(81166006)(81156014)(36756003)(8676002)(4326008)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4293;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR04MB4293;23:+jvqkvrg1wvk8DmjgAPVijlUoDryoPVOUWrDu/l7h?=
 =?us-ascii?Q?Z874X4LIkmDI7eirEZ2MK958ONCLfYjQHOviSsHflTcjmBLKv842P19YatWc?=
 =?us-ascii?Q?gqInvvbHHDA9QkPSiDgFC0lpCxl48FAZ9XgXBoMujiD9wdZApFS9RyVSvEqp?=
 =?us-ascii?Q?R+Cuh7BRDUhQyBbpuxi9FDeKA0BnGLsaeXmGQxtanDY39mCRk64rsab2bmJy?=
 =?us-ascii?Q?ZmBPdoY2qAVMzeijvI0g0fiHsm31UrNMV1hQddXMHyGC9eOnVYEFEdGo8PSt?=
 =?us-ascii?Q?ZYKKYKrJSSNXRj0AuEBVjI37a/BjVPCqh/Lsw/fsB9YDOcF/oLvLk6LUf0tm?=
 =?us-ascii?Q?OBdmZpQfI1nAsy+O4TkU0VfDaYcgGCDDpcBntK6fZZMEsFvfeLL0JI8go0UG?=
 =?us-ascii?Q?9NamwBQYCqHifAJx0taZMJMNsvcNLUGnOZg+I1MHDx/56BW85jMoD5CA1rRH?=
 =?us-ascii?Q?DPuRTvCOcWuCoBdx64mQMnTTHJKpkoCzVkISoHrfPpLgGw3sjFOO9FFjepef?=
 =?us-ascii?Q?moTPiUL+Xb+n40ZIrl7ztNJHgRSpGFpJ3mp3Ji2lnb6adgJsZmWkGMda5D52?=
 =?us-ascii?Q?fOKpqK+J5l7+FlSFMm55O9gH/tjo9NPrcTB6mfJ1dRb/tdjX8UH63tTDu8sW?=
 =?us-ascii?Q?JS4fRnLk4pwqIWpRCFgnDoZ+pm6ybyEqD/lzKfuxNgwWTF3B0dQ7ogJFqe3f?=
 =?us-ascii?Q?Re24Vtij6l6Xl1DsW6utqy63wZcCNjqRLwNU9iJUkhTyQuS6ew15KpMHRfPz?=
 =?us-ascii?Q?tNRsnR5gLaYnuaq4MnNtiM1piT4V5zirfRpgexJg4SXXBxZXLm8aRqZ0T2rC?=
 =?us-ascii?Q?Qjp+SXNCZt1cdTycmqCAL+tuIrZLaYEvOEnTnitqACdG0lc7MQlK70qHb9J5?=
 =?us-ascii?Q?pEh+joPdrQafWLCy73HwM6FCuTrYa5G3lKntnARAqsvrBjVBUGnadMiN/q/q?=
 =?us-ascii?Q?QBrVT0BNRRAoXpsOCaesaZG0WVPrJjpfHKLr9Vjb9tGxyMA6WFtBsKfaagrO?=
 =?us-ascii?Q?82EPgtKSmyKv+mrd3CQgSZaPGVyKRC83/xjCXByQea74OOs4xph807ExhQqM?=
 =?us-ascii?Q?ogSyl/a6v8IYAlrLdwjKU37Fa73HNxcVnk9iVKv4ZFH95TGiaxWnvQzhlXac?=
 =?us-ascii?Q?Dw+yZ64M3u7ITdIJ5gct08MkcaCI/sl1CKvfLXPn4cF/ki7TUn1anB47PZVS?=
 =?us-ascii?Q?m186M1KJIomZGCgeqtWJUyWZn9x/HgFZ8VGmRT5dVYV1XmMbNDCMMAuaERRb?=
 =?us-ascii?Q?kohJ+z/4Jg1Mw6hcpw+bxx2WWkSf+4p+Yd8EGUNZDGUwaz6PJQOJkDLax3PF?=
 =?us-ascii?Q?NVOZ4njVfKXqk+Joogs+72bcRPsssngfSot1WfAZ8/r6b2BCz+9IbCnnllRc?=
 =?us-ascii?Q?zIYCw=3D=3D?=
X-Microsoft-Antispam-Message-Info: Vtb87XhLTPB9/DbPxww2EkbHen/pv2Q0T4/3Al8PVVCd16hXfj+N8aCqmfNoPBooVO9MJ+98qE297cFT/iklWigpbzBaFjE0lAOO+IZ2k1XL+AJUM+2QaRSW2XyMykaQZVAHYm9w3LtPaHcP1aGC6qDw7MT9s0rGR3EGnFWdDTSVdj+wQ+ICC2qxxxN+Bn8hYymIpKJEAKB/+0PRzbOzeoQbE2W5N/kb74Z/645M3kXhwkSCngNHpI8GVm/xl5m4JBYO670zMJ6vTe1zgDqRgzKMYZkGbW5/ncvyWZVnaIrqFCTImxw7IsXoFDGiuvyQ3Xf+AK20uvFqiM5za6o/kRDQNbhPim3ll7RgQVIFDiY=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;6:urZqc20OKton7O6x94IC2CtXUdKFhViAsMbzzLKlsE4CJEAuuo35+sh6treIMDJGO7mKeswmfVQCldEmyirPwAd5TqJcV9cDtnkg7DZKPtvr5NZGX9dX0fdFd9BdKo6SqDs8LwoQHQQ4p6wpd0bHIywVf74MzvAiuG3fa0UffNl1D9JO6HI1PX2gnivOVVq8y4JtK6Jp5ICXiic58V4CFnOiUdOR1EeUIAFbjUmw8A2OyvFsUXM2b3KrE5L2wbo+CuKvAZODr0T7CANVHxaV5kFR0tNxljY1evMeiN3FVzo5nKRGx3S3ZAN5tJhXrKVVtXQrMZmpTVxV4qKzd3mvs9ckCa8wL/O2QoZvj88aKZxD6PTU05WzzGtLLSPb0A3UG+rdf1YYtS25VlZ/he7lKldHiXjmjcDsNcqapkWHe++dC5DRJRuXh38MCvRN91TNy4z7XSa4v5EXbruW6dmSgA==;5:2ebupHkeuGuRsDzRHufbv5Wp8sxXhmV3cTBZ5hls+YYn5vPzxfR3qs/klHr4xZDJZw0RKwRva/aG/aiQmAtpyD5p08R2n99IEzKCmb6Q0aNI0lmkNWHMLXhlJGRoBWSf26rghxJGt1jAGnU00NNj0zdQ4olXZGbhd9J+qVAaCwU=;7:BDiQVkh1AmKjpQOnupsmhVCbiTE5WZj56m22L1nixA7dFzgrWCou5tk7Cyec94sfSgWOJHgKd8nc0Q1p5DAjohTTVh4rx2Ri2B/M5tzcHerWlXwSOY/uYeaND2s73beU1tRPqEKHGdnOUS7x5bjqgSPKxeP7KK4wBsHYB6b7/8vV1+aUJxku7IJWzPep8d8ynJZetR1Qs2TDqIk8MOJMNauAiCffAXuGfvgaVXxKxMheiderMizuJMBThGD4Yl5P
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2018 19:54:10.9316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed432979-257f-4d9a-703b-08d627d7a889
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4293
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is required for the imx pci driver to send the PME_Turn_Off TLP.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Acked-by: Shawn Guo <shawnguo@kernel.org>
---
 arch/arm/boot/dts/imx7d.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index fa675b8d84e9..a6b2932634f5 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -145,12 +145,13 @@
 					 <&clks IMX7D_PLL_ENET_MAIN_100M_CLK>;
 
 		fsl,max-link-speed = <2>;
 		power-domains = <&pgc_pcie_phy>;
 		resets = <&src IMX7_RESET_PCIEPHY>,
-			 <&src IMX7_RESET_PCIE_CTRL_APPS_EN>;
-		reset-names = "pciephy", "apps";
+			 <&src IMX7_RESET_PCIE_CTRL_APPS_EN>,
+			 <&src IMX7_RESET_PCIE_CTRL_APPS_TURNOFF>;
+		reset-names = "pciephy", "apps", "turnoff";
 		status = "disabled";
 	};
 };
 
 &ca_funnel_ports {
-- 
2.17.1

