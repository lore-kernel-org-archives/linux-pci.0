Return-Path: <SRS0=/qR3=MN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6DBC43143
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 19:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43CDF2146D
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 19:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aNhN9qh2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43CDF2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbeJBCdl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Oct 2018 22:33:41 -0400
Received: from mail-eopbgr80058.outbound.protection.outlook.com ([40.107.8.58]:27854
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726204AbeJBCdk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Oct 2018 22:33:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKgxpJZAq0IxOt1s0jrqbaO7p7YwGpaqcmHREvCvth8=;
 b=aNhN9qh2m+AtAim1qrVmO9oPjvQIOLoJfrfitQ8pYqF+H13yTqMwyOiUPzRhLce7qBFW8p1e+dxGdNwEyp2CRqLGyV3+JiHN3oVUOn/K/gr5Jg627ZA+Zt9uIupXzXsjSy0SxatL1JJCADyGXv9vMngg7aIQhRPMtSQFJqu03BA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM6PR04MB4293.eurprd04.prod.outlook.com (2603:10a6:209:4f::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.22; Mon, 1 Oct 2018 19:54:09 +0000
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
Subject: [PATCH 2/4] dt-bindings: imx6q-pcie: Add turnoff reset for imx7d
Date:   Mon,  1 Oct 2018 22:53:46 +0300
Message-Id: <d9b7504094ebda9300495be3409bff3accc26f60.1538423063.git.leonard.crestez@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b6a7baab-95a4-4b8f-dac0-08d627d7a7d1
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4293;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;3:Nk6mJsVDCIzvqGDoU+tDnG3Jocl9VAhmaKTmP4/2ibVZ1sLTyaks/ih5XCWJDoCCBLSNnlhy51BK08P/pKCaKdHC27nPG7T3LiwHTfgRUshHF6T0f8DSnzjzrnf40ACK++V+CU4wHolxUwA6gj6E8CtX+jX3xKdv4i2Dp4dR3oNlkWHk5VWC30MCnP+Z0Kx1/PGLTcLSfbia0KGC8SGoXgvPv5OvhV7WFNSdW6I8lUjgBNL4VaS+b7g4dHdH0HH1;25:x0k1mDmTyt2co8eXBKKAis+15c4p8c8Guzom+pJcP8TmuE0wSc5BiRjy23ZJ9rqoZweTHednKDKJ7daym8E6cefMoLPn9DflSxXGnv1MAYI3yKLM3poxyzOkVA3fmKV07uA21CejJ4eKQB97aT1WkbYHV8n1v1UYInGR+gmaiHZX3jHuaz9wCD90boFrhDB21S05ApAYeFYe7CHWiJjBbqpvqUxCmnSpbPNZy90eDPpbfj0duG4YVrOLIi64Xe6YSdqS1cAdH0PoZxTPuOXkytb/dgse+3PeYHhz+Vv+5xY0xZAIMN+m79hCxAhmsVMAF6rIE0q1gZsGSU08+qfhyw==;31:owJqj3CiB067PXAoPbUtiLV08XttQMu3ZfQUg8Y/q5IyA1qJxYmslFD4gOY1ziRkkTyvtZW5c79xw0x1gV0UtfB/9WAuY+C3J3unRCFIu8jiUcdf+l9cybAVB1tno0X1hcXds8910C1Yns0c3YgqHQE30aZGSE9XrtP4vBXTz7VqjkMYgBVPnWSH9ZKLWuwg40b1ZlatTp6FeNLFZzTDrhxki50NZ0aI0pSgjLVXqGk=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4293:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;20:3t015tIk6xhbCZKyg+g/Jv1q7dZH7u3zWkVEK3l6Db0EiFFR89YDRJRl1jmqAZuaSxoUgR3kkTxT+o7f8gHJbKIE8gR4Pk1enpR/ZvDEqpMEw4jwJY9An5EiJCHu4vJpKTaq6vIFqa4wEoIbwlKCpm8WRsQ1fSpNCkhh+/lZJXE1lUe04VkUa+KR8Dcmps2iZwbIEozi9hxu0dbfrpSEQf58T8cm3+7cWWrPeIhTMfymmOX5iYy8DcvBCuT575nNR1LahRPfjuOEFwkDY6EQ1IAowM8qDZhYYKgZAApM7/Fgj9Pbse5+LSNkUogkzI+ectwKrsateAq42oSa3NmDwHc26YSvMT6iMxfn5krNu3t48R2sN2A4ZtI7KdsW+w4j+qc1qROlJhrYHdFgcIJIXBeKW206SywksMRgfs4kbGuOZkm6vhGuqSNJQfesYQLtwUioXHq6AHCpfEiBiKZkFb7jEJX/5d1mzMxXY5oofs6JCGxMgYVRWdOMbczDRiRR;4:I+nRKQQOAMCbiLcRfKp/3g061qVE/OdmIHHyMX3Y5K3o9tgbKiIPh4wyW4iC8rPLx5btLRhRY4e1gpBnP2YxazESoUGnwBnyNt48Y4pZ6RhjepTEwNQOsqrNh0ySXAgiGS4r1LWhscQXLE5P4vBvO64d0wjYaINvwNP7tzx6ytRsJnhL5vCye3iAMzVf2mHAo0KS8SCKo3p6lTY6wiY9tbwYGJEnKw+JVNs7R6+oCe/xDIRHyJxpOkrZuOxUJXGSIex3TXc/98C+rEDqZhX8wL1yaFV0wVj4iu5jg7gYlvZG6FNQFcSkdkvKewRtXUCP
X-Microsoft-Antispam-PRVS: <AM6PR04MB42934F8CC18CCC6481892990EEEF0@AM6PR04MB4293.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:AM6PR04MB4293;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4293;
X-Forefront-PRVS: 0812095267
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(366004)(346002)(396003)(136003)(376002)(189003)(199004)(6486002)(7416002)(110136005)(54906003)(118296001)(6116002)(53936002)(6506007)(386003)(3846002)(11346002)(478600001)(105586002)(16586007)(7736002)(50466002)(6512007)(66066001)(47776003)(25786009)(956004)(486006)(305945005)(476003)(48376002)(26005)(2616005)(51416003)(52116002)(106356001)(6666003)(2906002)(39060400002)(97736004)(16526019)(186003)(76176011)(446003)(44832011)(86362001)(5660300001)(50226002)(68736007)(69590400006)(8936002)(81166006)(81156014)(36756003)(8676002)(4326008)(316002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4293;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR04MB4293;23:aAGjzXhmt59Zc8bidT22PsAXxvQXS+pNPMb0sKceJ?=
 =?us-ascii?Q?zkKv9aiR4LStUxXDWbigb/iut683NsCL3/9loFRJdvDuQB/GYPhmuO9nbYzI?=
 =?us-ascii?Q?n4hREB/Jn0aLmpOVP7FXnO/+j7B2iQyrqfrp6jtejr9T4Xvl9CCkk+Wbpsy2?=
 =?us-ascii?Q?LTo37S59v6O4gY9Jo1ENtT8R3pcdfC5IbHozFf9rbRIJLoHyzjRSPwGFqhWh?=
 =?us-ascii?Q?cJJ8Ur5xyLD70w5YJv3GX0TzAQMylZCnjLG6qDMP78MGi7bcrPU3gADfnuez?=
 =?us-ascii?Q?8qSzBWgfBDjT9qTik+D5kgTPJ/h7eowDk6aLbFRvoYXmJNY4wg7FcL4VokOo?=
 =?us-ascii?Q?va2AF16ZGYbwI2JsmrLd4A/YpDgGqnDPe0WPDXdvXYRO91iQZ9VtpzphO+eH?=
 =?us-ascii?Q?xWotcz69Up0GpkNmwoIYAAZJ0poY7MzxNQnFJdQlv0KV6rtByLPhzF/jzVxM?=
 =?us-ascii?Q?emqpxCzsGIN3dtKeybQhHvwUaVB0fP4rmQwhZ1bM2pN7joCHIKCcInt7q/98?=
 =?us-ascii?Q?SsdxGKMndd3vKS7huYDN/9k0NMdJradwCAEemOVr2LKcpyXfN827lW6iKlSQ?=
 =?us-ascii?Q?G3CTQrdk2oRACTH9jtFCYpjM2Hkyo5cp/AbpPb1JmtlM0+gPZ71wNSSS0x0a?=
 =?us-ascii?Q?Tws+EvnfZUdc5TTMoUL7hSyXNB6zqwEfy+Xhlkioyuefk1SF4uBq9mODbjuG?=
 =?us-ascii?Q?yAjUUwLNqSBhV+4akr6VmWeWh5kdCepX8ettiu+C5/qADkBhncq8bmbcK/af?=
 =?us-ascii?Q?WDXVnn0Dr/qaGrdaDl0WLPcoYix25iyXXPJbKLWy+dIItvt0hm+zYA4ahPkT?=
 =?us-ascii?Q?hzJQUUhCneNxuubaHU63Ko/x97xJIqWz7/dXRN5/EsUT3C0JHNKDkYV2EXA9?=
 =?us-ascii?Q?YkjnGXDHQUhyW9ufmA24jPTOZjau7hG9FPqi7DmIPL8nBmVHqAuEX/04oCtN?=
 =?us-ascii?Q?kpVV6v77ap1h953MsuEw75sG+br2BFRjwX3Z0rUEvf9NUhNLePsNnY5zKhQP?=
 =?us-ascii?Q?9gLLwHuLd1kEixYsDqLn/WkesClJhjsZofckZrSVXm5N+c/F+WPoRNORe0PS?=
 =?us-ascii?Q?vElRHe+wibBVTpAjGHDcZTwp4i+JUMUU9z3IShf4UtLl3XBIbiT/vqe98BDf?=
 =?us-ascii?Q?LlAVX9vZvlPvqJphakzeOW8LcBD7QYwV7xM5z9dOFNSE0CfzwZkpBYyPnfJm?=
 =?us-ascii?Q?5IO6n0Y/Uj6AmdU8TLp4FplepOz/tEbWhS8bCNuG6eGP2dMJyNQCYDwfi7Bt?=
 =?us-ascii?Q?Sslowa+phlr9MjRSB8uS2yI9W7m3VVbNqGaHaTN+5s9KiHb6J1aqWd5OVQ1Z?=
 =?us-ascii?Q?qEKS8KkerkdNxNfBoeiyT/+0EeXTk9VVfkoF3gPBRIYVu+1cqvHIyUusXzgP?=
 =?us-ascii?Q?oogpg=3D=3D?=
X-Microsoft-Antispam-Message-Info: n6VJvNsqc7jSajXBr28I6ePXHN4qsRL2AeVZPgptOQAuRJzTo6Dmi4UDarQpeubZhS1vFEK+vfvYs1oQoZgbsH6Yrwb15RxDo8moDNWp5b6p7On0LDPTm6SaG16jljAOhySsH8y4vlRgLxMhNYubFep5uBYadBpMG7aDOEsJFvgPi1jSB8M4gBUTaM4Lmr3MGOwxv65OU3d9FjUDz6ABVKHbSRvScTjDlqVllQYYqVvvi8iyLCU/GAW/7X8lwbA9BkVAHm0i9YSLVJerZEr88CGrFCN7UkGg+IxXPEofZtyKpOM4Evrd18lEhk9Nq5IFzoMewQ8zjF4ej5bNC5rMhm0wydYvLbMfBczbyMiqC/E=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;6:ZN2Bs8B+AchBPBX18Zw1ys2U9nDPAvusSVGXDAbKOHPByIjpqOE5mTMnVlCKJOqbHtt1+CE3UgT6pfBq8WMZUvcBUFapXPJTq79gMU+SxRl/V1tsTBREQ3E9wW1D/whSfWZ0E48JLjz4SO4oCCUkV4gWZlcOl2h4PffI0SThjUt0taXghb2nn1hkdfmhhA3uHViaHOMPhcIAwgWDlpbVvnOkrjs/WYsf4fOx7s8H3PEXweqBLdcxabSGvGPrUFLgGIkwdY56q08+VlBY0NcY2UnmMRs1HpVrJ+kEegLCNmArZR+TukCdq2+p4Oj1Krl/5+Y3sSVa8PEsrdnbUrc2rpuBA/Q4HqeEqcFicT4AhwcPsx9Bs1fHwZdys4oBpSXr3veamn8cejFaRgz4H/L2vZfk77LoN06gr1UKLkHLYJxRJAWmlJNBUeTdWAV3JCNeKHQoGqFgfNpqx1zLR/j6Tw==;5:1wcqxFeScaFpJeYPGqigaWA+SJDxsY40fyEgV509C4NYl1rJ+MucESkCwCrSKDjKjU0LPvWpPzcYtQFnBKWNBfs0Q+1F1s/923vv1vclSno6O8q8vGUWJTIiUzLYrAWG7MBrqa814vhlh022XrC4epIQAPohP9MgEYmsCia1cRA=;7:VVSRUv7REyzf2ukYZy9E7aOpCRMczyytpbe2Ji6jwECPTm7Zft33kO8jTk1IPT/Ycp+9OHy3uxtVNfoLb0p9dzZnRcMJmVHFozBP10SS2gzWGEFLHL++MacyBA/kkG+NY9CqtwnQMEnuHi/+0Za5UqT5jTnGfw5SNJhnmANzazlahVxcZjynGGwD/ljeZcJA6iemv6TwULbhATYcsgZozaS1Rv6VlL5XXejgCe1ZRCQ4zjPmp6Q0D3fuZroxZmvN
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2018 19:54:09.7597
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a7baab-95a4-4b8f-dac0-08d627d7a7d1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4293
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is documented as "required" but won't be present in old dtbs.

These resets are also present on other imx chips but right now only
imx7d implements them through the reset controller subsystem.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index cb33421184a0..f37494d5a7be 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -48,10 +48,11 @@ Additional required properties for imx7d-pcie:
 - resets: Must contain phandles to PCIe-related reset lines exposed by SRC
   IP block
 - reset-names: Must contain the following entires:
 	       - "pciephy"
 	       - "apps"
+	       - "turnoff"
 
 Example:
 
 	pcie@01000000 {
 		compatible = "fsl,imx6q-pcie", "snps,dw-pcie";
-- 
2.17.1

