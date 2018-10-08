Return-Path: <SRS0=j7M/=MU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19451C6787E
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 03:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA6D02088F
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 03:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eKpJRJgb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA6D02088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbeJHKZK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Oct 2018 06:25:10 -0400
Received: from mail-eopbgr40067.outbound.protection.outlook.com ([40.107.4.67]:60976
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726295AbeJHKZJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Oct 2018 06:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgCgMiuQ7N8dfAyhn5L9tJgAfryH9KMpcNbAebn23bs=;
 b=eKpJRJgbdLP4EUKzXZ1kZd5FPccqJ3TwMXiworLuribO8tPs8RhjWn/mwHAmEcgH2X9xRxGpW484n51sflc8cjK+903/Vt4vjazMP8x/ZPAkPHCCd4NTfGR4uQj/IED7xjXbbtmgcgYb5c0AdEXYBVg/ACmaPiGOzZVMzVvYXIk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
Received: from mega.ap.freescale.net (119.31.174.73) by
 AM3PR04MB1220.eurprd04.prod.outlook.com (2a01:111:e400:586d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.28; Mon, 8 Oct
 2018 03:15:32 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, leoyang.li@nxp.com, shawnguo@kernel.org,
        mark.rutland@arm.com, bhelgaas@google.com, Mingkai.Hu@nxp.com,
        Minghuan.Lian@nxp.com
Cc:     Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCH 3/4] dts/arm/ls1021a: Clean PCIe controller compatible strings
Date:   Mon,  8 Oct 2018 11:14:27 +0800
Message-Id: <20181008031428.25293-4-Zhiqiang.Hou@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: ec321a73-52d3-40f5-60c7-08d62ccc5108
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1220;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1220;3:3mmaTZdI7egc38SAdPAncsAvodsOYd6uQNmrfGJmOcR1qkfXjxZcWXH16/F+xgUrZf4r74eG+EF397GAD/AB/4ojb/cN+D500b9iAkK11WERMwRdF3UL7QP9ummt0xPYueYo2037fHDBNgPg87I5/9kL8XSCDsqoJ3mLk2QjdA5gNOYh49bpAfPeZLdND0U2NwNirHD43xyI8Un64RmeDV8DG4TcRoOU0Yko86J4SEk+llC5r4k+2EyVPymvqw8z;25:UxU2QA2W8BBfID/EJzCZesBbNzHIacH0woqfVVWH1Nh82XTQc126XzD/3TebLVFeapyNOZR+YTVapsSuvIX1j/gpJT17nIvRF11JEe2GDss7icOUh9xsBOQxI0RwAoRIT7lR5+gJUFmQr5PG0Zq9vEiaVMI5dMQyGg0+CGuNYtNcuv3gPTiEzarDBnVWppY7br9/yNcmEA9mDHwE5YxUasCIdj9M+mhP4xG9rlG8tKyM7OeFgczD6TRoGMURXDEdlJu5Ld+9b/EpLo+t3Jo2qKL6p/76chNtJR9PCtT5ABeTSgoEgIX4dOjDDCWlo08ceWG0V0vhtqEjLh7o6d7oAQ==;31:3HwNfEwPn4f39KyEkjJlMyk3L2cxxgoormiBGt0yQo/gArKCEK4HmjnEmLant5C2T/1sPnNjQr5o4cntFz+e9/k/Q61hyr2AP/mb9zyBownzpyJubAWrbfS20NSAdxZ1QEcbfPdz83vEyutOg0tLzrrQNErqrz70N93/V2jV8502MtyvqVld+Z60rYKWKsLkPFRHaaJklDfhep7WorSIt4tqS69DcO5mNVplnKJAAxU=
X-MS-TrafficTypeDiagnostic: AM3PR04MB1220:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1220;20:9WQnk8e+W2gpCo52Adws7Vms21CtfV9aVK+nYMpokIoVELy3V20g+sni7zFmkgIG6ULLALSoo7GBpHHnl5ItHy2w3T2WK/Z3PWKVs8UilHEbyTSp/LKVWHjVRBCdBi0xOlkpR4topmE9sDjrzmK8b5kNLCrcEkTVxPmtaZQwi9+e/r3AtXYtEQz+oBUkXkJjCdSZ7nEFaZFM0aWUJzAqpuuphbkLlK+MjP8wTtAUzFm59QPLhODoHR4z0dFhYbeOT4tcxjcXKHWp40YDAnNyu/IfzMC+AIjGSC1XlQKf0wJcq/ZvcTBCgm8GDySsa46wC0bgWcuEYLYRqxZ6iCQIfeT7zDWcDGl92YA5m+1DvTyZpa8sUj3LvEQzyv6pj8NuFc0eYK75rMIp4tB15pFsFV3PqwXfjidsU7pGVvjv3cKrkQjGK4M38MRp8VDHeDsudlh6ro+rL+wrO7FpVFdHjyOJGSZ07nZA66t/ydL4xjILQWdxhl45f5o1J/zXKr+I;4:/wZ9remSCVidESiNSh3GpSInyw22z2xyPQzwPS1xLND/W48BZA3owzHBuTC1pFXl5Dr/oYKKp68A60i5zq4IqaygrHPVVYDC5QsnB21lsJ6DLfJvQFu8weJ8HcHtajUPEETVFOl2oK6Tq5Lha2dqMDeabmA1ICEAZKfaW7YprXVMG0vGoPd3jJ8H63lvzcczsf2gchywwsvRsnALEKkVUnj2+ohoB3v4c+XzFtlDN4K0liafJkjDds35uIpamZJa6nCBfx0lqvjnV5KqS/y7ttG2zV8X9+JEd035I3QyQfucfjllV5Je9j3DPCRDBEXB
X-Microsoft-Antispam-PRVS: <AM3PR04MB1220518E1E8396C02CBF0D6A84E60@AM3PR04MB1220.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991055);SRVR:AM3PR04MB1220;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1220;
X-Forefront-PRVS: 081904387B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(366004)(136003)(199004)(189003)(25786009)(16586007)(4326008)(446003)(316002)(2616005)(956004)(52116002)(51416003)(476003)(86362001)(48376002)(575784001)(53936002)(6512007)(486006)(2906002)(68736007)(1076002)(305945005)(7736002)(50466002)(5660300001)(76176011)(11346002)(6506007)(36756003)(386003)(50226002)(3846002)(6116002)(97736004)(8936002)(478600001)(66066001)(186003)(6486002)(6666003)(16526019)(6636002)(81156014)(106356001)(81166006)(105586002)(8676002)(47776003)(26005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1220;H:mega.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB1220;23:ur6icxJRNHonqQ5I1n8aiWBLKbE8xt08cVF/8yKYz?=
 =?us-ascii?Q?3mppCykRycQN449zcURHy8dLcIsvtMo13kN51fMHd+p+2PKQm+j7vL9HVRL8?=
 =?us-ascii?Q?VIEegab6YF8z2lMofjsfe3Gikeepz+6fPb2MTo3C5WgiR9Ebun/NsNkFKx6D?=
 =?us-ascii?Q?GPY3UrsJfTd0N4cWhHnB9Q60T4B4Pdf41mqVeq6lvYaGEGwxAc2xg05Mpb61?=
 =?us-ascii?Q?ccLfZgq4XSh9YsANBvNK6PUQmlr6OdKzaoL8AwstXZ/zK2wCaJogUsXf9qlS?=
 =?us-ascii?Q?xhOrAKUI1fxIPmS17Z7mPRrN7PkE2mKlSKJ1chSRkHgyl8q0JgbD4iTsgv9G?=
 =?us-ascii?Q?mRWu2rZLOY4Ui20WVB299ezW/HyjryD0mZkkwfJ7a8U1/wZ/V8mdlV5xBszp?=
 =?us-ascii?Q?bFa/Dxfsw/7x8zN7Uz+YB+m2tj3hCB2ostyWR/ePPl34CUTH8sRb2xkuJBqJ?=
 =?us-ascii?Q?6qMmnpJyFuzNfz7Qj83oUKH9nbSuPiG7g8d58zi9G8+ZqdPfelq8FC4x16Xo?=
 =?us-ascii?Q?MdzhAfFPcQxAI7A4IKmG+/oeSuPcGefArm7JauB7QNriv9TRNa/Qqp6KvCqR?=
 =?us-ascii?Q?RJm9x0G/570zrm5zBzVO//YeeIXinc4dFVnPWpPgn8hsYoN2jlDhVi4K7iu9?=
 =?us-ascii?Q?HDTBA95FPHiJW9VMhjrJ9YHtWByc576GM6uMY8DH0axelN1ZxySX3Co+AMps?=
 =?us-ascii?Q?evBEhCgFsmoQQ3LIGLMJBwbRJhcYnEjzKGEx9qU5V4rOpOeoMIARZPrdwr8h?=
 =?us-ascii?Q?tNkaOujOIJGZP/OLAXRxbIBX9XDlrnyxGBQG/wAqVupnb6HEUCf2WMMSzpDL?=
 =?us-ascii?Q?n8+b7FYpoe48bN7WspkfUzyDHLct0ecx6CT4j2j7xCn5ZT3NUC3UOCdf6r9o?=
 =?us-ascii?Q?Oq2e7P2SQBWWIj9ciE3RwgbpbaMlhjhcYsJJsV6Jt/DqvtHzm+t4UWUTi760?=
 =?us-ascii?Q?LXTZ25IOYXC/Mglv+WvU/Ivw34YCPQW21UTaLAPuoxwtBMZwceU6pzMxP8dn?=
 =?us-ascii?Q?G88vB+UbxS8KxFMuh8freqWVCAXeqIklHcsRNBKNjuVoCisHZxyRfSu4WLTM?=
 =?us-ascii?Q?LzXTimZYWkXh1nU4W75iw8RBF72H/TLR8Ull9GRH1ekeu8QQmnLMPfbkh+xE?=
 =?us-ascii?Q?KNa1VQfQh8f/QqW3avEvqw2dECGDi6vZ7RklgXaHZP9dZdl5tylZsaKTDpS6?=
 =?us-ascii?Q?3no20R6xpp7VNsWT29FUPVhP69ONeWPuR9HJbinQgICW2HUx6ZNSvlQ0rKtC?=
 =?us-ascii?Q?xdvXNxQKMZtA0cS95E=3D?=
X-Microsoft-Antispam-Message-Info: 4QM8a/uMqt3d8C5qI9wvyNZcc5LCz0/wsyBPH787C8Bd33bIzAZP9HsPUsFmukGL+djKs8DEqaORlrgsw0R9Z5PZpghOSMQxEEWwu0V6521T9JjLCafmOZIKPGKurI0FhVE6p7swthfK1Op5k3S2sK8cRD0s9ZdhlqzwBN/IP6yyo7XbwF806R2cBghqpj9PVNtFnxSB56B4dy09gi1VHeRfFdVx7SQ25R/A6nVflMxDTzY1DudJVaUZaLsbHAAOWZaZJbxzmRzxaEzKS5JVgm2yOgd1fXGFW/gOY6hlfbByTzFSRw8oMeBocypI4gd7a5shaPn7L13iFx8bJ0dWMn7qjMp7q29EjSpCYnA9kfg=
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1220;6:BQwj/mNR3w7k7VpfmyVZh7C67r4H4+3MK9J6JPdH1aDcG77yu8HzpePYEgWP0XGkS18uUYX+VdhEeG+uGcRpaqB/0NYSzPr7jUiTbWo9jp+usxl+qcm62da4kn1afXbopbsR72sap6w+WpcPNn3DpD6ke7lnEH9IiVCxTECwqR38hrYK/eFIfpYFxVsBvFsbHVonld8wrQBxAoj+j3Ro5ClmwJhbjcWWtJSTrDE5/ewGZsslWB2FtDWvxcAs8cVFTnKVV1EIxTD2Fe4xvFlfGsCR3atgVv8vqRFtY9FNJ5EL20Jv59Gve8sth8juBy2muk9/AiqkQxKyUgde8t4iaiL0MH/Gvp1L6E2qp//refTaB6NNuiyNSFYG1NE0/Lt1Lzt/NGdefpp1/Ds2g2lA76L5dC8jqIEA3zYVlk4JZ9Pfln01RCEq+aK/8DSqq9OrzvSFx5qUTfICaiOv6Lg3bA==;5:SL66+CFXXGu65jZ5anvGw+PiTHYw5mJRKGBtdQZFJpm621CfROp6G8dEp9aegLarAkSyvKTrn18+0IEwzot6TACvjrIZvDbRPYsfCiFMR5GQ1Xmh/TWf3nQQFp1cQ9tATOLJypMCuFeWYZRfWgdOUEZZVppo1bd89pYM2O98BtQ=;7:TLedm3JSM1yaefa00dXZxfCc1s0c1oHvth7M5cbBY8zUubBp4Xz/UOYn8w1Eup8XPsO9L6sVcNduUSdMpLf5cbpNWOxxaKnEtSUu49fuAkO/qzGXYnnK4QMgKa9qfjFYR43VB9735FOVgGSmmhCavqXHSnfghmf+veWvpVmIAmgN0/FWLXPH0qKYcEF7lK4Oy4yt5InIwXPDYDqXZTLoayWBe6q0RpMZjVzs0Gm/trKoTCb00nT/WMHkpqTn0mVS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2018 03:15:32.5556
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec321a73-52d3-40f5-60c7-08d62ccc5108
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
 arch/arm/boot/dts/ls1021a.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index f70025c2ab0f..13e91d577a26 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -716,7 +716,7 @@
 		};
 
 		pcie@3400000 {
-			compatible = "fsl,ls1021a-pcie", "snps,dw-pcie";
+			compatible = "fsl,ls1021a-pcie";
 			reg = <0x00 0x03400000 0x0 0x00010000   /* controller registers */
 			       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
@@ -739,7 +739,7 @@
 		};
 
 		pcie@3500000 {
-			compatible = "fsl,ls1021a-pcie", "snps,dw-pcie";
+			compatible = "fsl,ls1021a-pcie";
 			reg = <0x00 0x03500000 0x0 0x00010000   /* controller registers */
 			       0x48 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
-- 
2.17.1

