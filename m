Return-Path: <SRS0=medT=MW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8E6C43441
	for <linux-pci@archiver.kernel.org>; Wed, 10 Oct 2018 08:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F353121502
	for <linux-pci@archiver.kernel.org>; Wed, 10 Oct 2018 08:46:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F353121502
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbeJJQHb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Oct 2018 12:07:31 -0400
Received: from mail-eopbgr730046.outbound.protection.outlook.com ([40.107.73.46]:48528
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726788AbeJJQHb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Oct 2018 12:07:31 -0400
Received: from BN6PR19CA0053.namprd19.prod.outlook.com (2603:10b6:404:e3::15)
 by SN1PR19MB0398.namprd19.prod.outlook.com (2a01:111:e400:5964::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.23; Wed, 10 Oct
 2018 08:46:19 +0000
Received: from BN1BFFO11FD003.protection.gbl (2a01:111:f400:7c10::1:131) by
 BN6PR19CA0053.outlook.office365.com (2603:10b6:404:e3::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1228.23 via Frontend Transport; Wed, 10 Oct 2018 08:46:19 +0000
Authentication-Results: spf=softfail (sender IP is 208.19.100.21)
 smtp.mailfrom=microchip.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 microchip.com discourages use of 208.19.100.21 as permitted sender)
Received: from AVMBX1.microsemi.net (208.19.100.21) by
 BN1BFFO11FD003.mail.protection.outlook.com (10.58.144.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.20.1228.17 via Frontend Transport; Wed, 10 Oct 2018 08:46:17 +0000
Received: from AVMBX2.microsemi.net (10.100.34.32) by AVMBX1.microsemi.net
 (10.100.34.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Wed, 10 Oct
 2018 00:45:43 -0700
Received: from server1.microsemi.net (10.188.117.51) by avmbx2.microsemi.net
 (10.100.34.32) with Microsoft SMTP Server id 15.1.1531.3 via Frontend
 Transport; Wed, 10 Oct 2018 00:45:40 -0700
From:   Wesley Sheng <wesley.sheng@microchip.com>
To:     <bhelgaas@google.com>, <corbet@lwn.net>, <logang@deltatee.com>,
        <kurt.schwemmer@microsemi.com>
CC:     <linux-ntb@googlegroups.com>, <linux-pci@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Wesley Yung <wesley.yung@microchip.com>,
        Kelvin Cao <kelvin.cao@microchip.com>,
        "Wesley Sheng" <wesley.sheng@microchip.com>
Subject: [PATCH v3] NTB: switchtec_ntb: Update switchtec documentation with pre-requisites for NTB
Date:   Wed, 10 Oct 2018 22:42:55 +0800
Message-ID: <1539182575-26851-1-git-send-email-wesley.sheng@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131836347790239803;(5a93feec-e11d-4f7b-166a-08d09f1f276b);()
X-Forefront-Antispam-Report: CIP:208.19.100.21;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(376002)(136003)(2980300002)(189003)(199004)(77096007)(107886003)(5660300001)(8936002)(81156014)(106466001)(50466002)(81166006)(26005)(356003)(105596002)(6666003)(48376002)(97736004)(2201001)(450100002)(4326008)(86362001)(36756003)(336012)(316002)(54906003)(486006)(53936002)(498600001)(2616005)(110136005)(16586007)(305945005)(8676002)(2906002)(126002)(44832011)(14444005)(53416004)(476003)(51416003)(47776003)(68736007)(50226002)(69596002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR19MB0398;H:AVMBX1.microsemi.net;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD003;1:4sVgexfFS/0n91+I135sUj6VrMxozqJg/GK94vOF7y/CmQV0fAtCCm8M3KrXcjY1H0X3CHMqcqH6RLRXH4RDO9Y0BE9Ua+1/cR7JBqfq1jQxiJzllIT09PKrTwFqUHN+
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bba9119d-bab9-4f6b-9555-08d62e8cd8e9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(5600074)(711020)(2017052603328);SRVR:SN1PR19MB0398;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR19MB0398;3:yL/haTm9zDLQAUzpv6MFcdb35GLS7uxZ7FYpx2gT5xC/OP2R1YmACcFVkmQes8KZQ1ftj8VuBEPd1kbwR2cpyaEqqjA8h7m8/zV3vT89H3jTN04niJDExEpgAaw4ma563QRRXhvKMARQkHPByA4cr022D/3eq1raSKGsjdQ569ntF6o2cTUG/dsGeOWM5VUHrB6wwsUU83I5VKd7nxGJkf1ofqETKZmmrV+Fsp7eOXuaqaD7SvHi1P/jrQnMI7uSyjhDRfa5B0LNAZYAVfj4bupp71IKAzlHIE7GjfsYYqR4F3x28kWikndV2dQ47sCzOgaBjKiirZCNUfVWxKHJJB3SNPuhkiSgKUpXQHP0SEM=;25:0HPrnlyOcYtMDESBK//ULUy4aQGSKipn6yEy36kmC8xUiQpGRIglSVGCSSA2xTxsuRRkSbZT97t1w71mftADVZYsza/qQiEO9lixJ98L7AbVlc2Teu1okEaJFRXGNy3gnAWNiB/qrOXPuzLLOb6FMUJgUfzbRSW2wVZPNKUKeZmYcCYpZqWESQG9f8U/U4Mp9GpdFIglVwbiYucf7a2TnyLD8rYgczcK0liT0P45XNGE+zlycnRRvvwiGkkW9W97KHy/+0MIbTtBNNjVhWiEVyxM0GqTKOtKkGceISBj7tPLVpXmPlccVi5l7II2qUx63oPNi7rYP4/sz/DtNfYDSg==
X-MS-TrafficTypeDiagnostic: SN1PR19MB0398:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR19MB0398;31:+MErSXnx//m5nRUWUM7wC4zWZumMYXO/qkR+/hgnb6HzV7/kO0pHy37zqayqFfndwjoLX9nkfJqjM7KOW9jHjJUE/b5gp8kTjwwdimh7prItXLSCdys9/uLKD1rgaT27IVwKdosY9o6BvqFwsBrB/xw+lOUX/iyGjKQvJ/X5ubOedsTMQtEIpduIICjrvGBQZKaAbzQNegN/ErSpvOuxdQL5oXpLVmhpy/hNBCr7x6w=;4:6sVx7XhSulI2deB0dzaXfp5isOD3byy3yaOzJfCr+QGZquSE1vmmtvM3YPQL8nLPpWgAapVuwGRciqbHzBI0YFZrt+hQgqPFyXRkBURuPxDro1nMB9KS4AAriI/jlElkK0di7YwvYeJwwhNmbyTEWzixDJVxNuUHgXh5JelP3Zb08roCy+mnB3YmKYnjgevBDBOH88sjIh5toPSKy2RbXn+SPGWXjmZW4laDgmDhOYMwbkL0AJWxZR52MmbbC1uFiCbe99F2d6rjJiEXUfGSDbBspnscBBWCEQZ7SnMqPx6nk36q53kF0s6ZmByw04YC
X-Microsoft-Antispam-PRVS: <SN1PR19MB03985B6E0901F4ABD3F9B4D795E00@SN1PR19MB0398.namprd19.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(278428928389397);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(6055026)(6096035)(20161123563025)(20161123561025)(20161123559100)(20161123565025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123556025)(201708071742011)(7699051);SRVR:SN1PR19MB0398;BCL:0;PCL:0;RULEID:(400006);SRVR:SN1PR19MB0398;
X-Forefront-PRVS: 08213D42D3
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR19MB0398;23:qvOFI+NLUoHw1vTURpkCoftoYIMQHXgWkxrcKNyz/?=
 =?us-ascii?Q?wDYgqEG7x5u0182Mj2c+ZVg1YiSC7dgdJWhlatqwrhvRlNA89GTeobBOk7A2?=
 =?us-ascii?Q?Gr2chq7T5sXyoHqE2+zThjZaHqCFQcXkOjDbk+bXzl4X05PncBqsZhUxaoec?=
 =?us-ascii?Q?mqHHjd8o/cf/L45MRLCJWKSlSnlMV7WiP9244yQcSE++Hs74UTo61oGEIs5w?=
 =?us-ascii?Q?N2lBaXkmvKVRSe9hK3f3SD5YdEmWx1SwzjksTb1Fjc2wvs7EAwsd3d8mnN2v?=
 =?us-ascii?Q?PZHEbFoVe+CTsEGLAGJmrZ5W7Hx+p/lGhhmzbY1XCGc5BP8TKaU/qq5G1ko/?=
 =?us-ascii?Q?9uga7IeD38+rq3fXqTMFJiDHlCIgJGN6u+T4sHRHqww1g98t3oWFm82k5g5y?=
 =?us-ascii?Q?EyGqjnviKRd7GegMk54MyBvw9qv8Gh/q9Zav5pUagDQBPey+/CbUtdUzbfxW?=
 =?us-ascii?Q?hgJe3YH4yst3Hu/cXka+8I7BH4ZGRJKbSmBhgzrngJFay3a4rBn2Sw2gSSbA?=
 =?us-ascii?Q?AK5+9dl0yEpLbo/nCmmM8KX6IjQNbftU9Do/U75sr8F5N+afPeV2m4Ng5pJc?=
 =?us-ascii?Q?Gk0c0IF0gFofk5fLHZcOGhfX2RJtU/tU4MLfOLcuReJRfsdAasRuOBscJrFk?=
 =?us-ascii?Q?QdBqz1foK/jPooJ1PuqhF9GK4szOZwvAt701crcOadHgipOdeldym148xEYP?=
 =?us-ascii?Q?WPvU9KT1bQ79opcqsKB8Z+/9IfPZyKovN9tNzz3IEeosPXRga+rL7YXEBSdY?=
 =?us-ascii?Q?LJQyrYiM7GFIe4a0+xpxlwDLN/GpztNzB7l9aCU2k5to7OKReUBpSscNKxtA?=
 =?us-ascii?Q?JqiteAjniZLso6sZnAImaYSq5AJaXDFHvh3PkO67duSy+G1go2PI2ILNrBcH?=
 =?us-ascii?Q?vBIZ2OzuoLmlfEGFbD1xuGF+iyBxUQD/qZ2nXdaOqySl/kIeaejy4mUsxCP5?=
 =?us-ascii?Q?6ZPRePGF8NnG1yUS5Pe3+R5AS0NF4ViFMdKur9vW3EIy+swY+obrlNT85pBX?=
 =?us-ascii?Q?sestP/3iJ644LHQo1WLqgzZYNhdzTOH95km8RyFm7X648QPaa1Idd2HDN4C+?=
 =?us-ascii?Q?cvNgTB668nyJFM4STOqtITVBWiZs2piBXydV2pEyGLZTGVvWRFf7PNw1xvPV?=
 =?us-ascii?Q?1JEtuNtlNU=3D?=
X-Microsoft-Antispam-Message-Info: EpgKH+JrM1wU/IrxKy5GCrAPhRpUuWFeyShBB/2KCX2pS/x6bRGarND2vjs2Nlo2PHhQ7nN2Sulet0ED89On4SKmRXpyNnkDy36c6PfR5WKwL7Z2jYYwyzMZI9HkFABSzrO7vhf+3CH0sEtqa7s6FzgeGsRpotmkeCAg5+zx89VM3tfG/HfOFFO6J5/cKjKE3Nte1ZQf/5yq8B5FrLh9ZBqnzi23VkhYBM0MhydkVyG1fgu8eCtY0HZYmxb275cVg6M2txm7l6r1lJ1pJcXjMgU/gLToeuEMO+znC06AHa0nuSq92etdtgn5xNvaQgM4IzBg+HE3hrwR0fJQyqz8We+GqQk0iKpDG+99XC/NvcM=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR19MB0398;6:ESqfYImtTRLE4d2K847EF2ojEfj0BiEZCyJB1waXr2/e91+73mLRH0VBFgWYmwdRoRw8Nuf88ITCQnaSR1cT/Y3YvH2+64Qzf1eMCS/YyZQQpVlPk/rPfTDdYHPYQOsmhKaWrPjCNn9F34XvlecGv5AiygmfDMfCmxqtd1Yv9UMIpO3UB+Iaf4t7nkmZWo7k5IDqmtizuoJFai8ziuIWJ5CJbsiEOe8ya9/sXYYY1MZx1vtJQh0i9mPimDTA6PItv+gcBf+P5K5lSFRKXvixTW6uNhLN2Oo2ipWQR/iDbIq0HhC2wc/+WDtFUAH+0EMO5g0jAGB74muWn9SsJVPPkUnUIvIwUHp5IkJAsUG3Zw/AkXSGPk42M6jae1CgnTMEOyhBaxbOcHIF3Xd/37zALyH6SiEOze8+zA9WxFOcln8i74ny6eI+05rsx0nhjAeCbiaztqKSgrPtxYsMY3z3ug==;5:iQ3VwJIJOY1sC6XrVU122lL1JouuXQee2OTiCjsRkYV2ISaKsQ2yK/JgjkBFe4txIPq7xRjSICeRdKEHKsv1+oERMH4OJPoGUfxlyThOZAd+kvLZmXAafbnxHBG26x+fhmNdW3ywhjms+xhRuuj+fvJuNnLMDRyd20qjFW6pCFY=;7:9WfslajheDvQqGtUJn8ML1uc0npzvVKE9Oy9AHU7qiQT6UCSzTWSxMDjyL5vWLp3p5s9r3k59XRYqLB+y36kJ3dAVQ35XbWnDVrm0fsUFYUu1W/NV2oLMJfbB7uGb9hyuB4K1g90KU1DLQr8upN43uojh5gfGNyefeO1vgipxBG16DUqddmTNM3AUuaPKWzyjSjR2xYxrP1cYI24400vRJTs5pkMsqxytBB3DzMzLszIx4b1ajDeoru4Aw8LIeD/
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2018 08:46:17.6802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bba9119d-bab9-4f6b-9555-08d62e8cd8e9
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[208.19.100.21];Helo=[AVMBX1.microsemi.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR19MB0398
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Wesley Yung <wesley.yung@microchip.com>

The ntb_hw_switchtec driver has requirements on kernel configuration
so we add these notes to the documentation and also clean up a few 
other sentences in the documentation.

Signed-off-by: Wesley Yung <wesley.yung@microchip.com>
Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
---
 Documentation/switchtec.txt | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/Documentation/switchtec.txt b/Documentation/switchtec.txt
index f788264..d6f04dcc 100644
--- a/Documentation/switchtec.txt
+++ b/Documentation/switchtec.txt
@@ -23,7 +23,7 @@ The primary means of communicating with the Switchtec management firmware is
 through the Memory-mapped Remote Procedure Call (MRPC) interface.
 Commands are submitted to the interface with a 4-byte command
 identifier and up to 1KB of command specific data. The firmware will
-respond with a 4 bytes return code and up to 1KB of command specific
+respond with a 4-byte return code and up to 1KB of command specific
 data. The interface only processes a single command at a time.
 
 
@@ -36,8 +36,8 @@ device: /dev/switchtec#, one for each management endpoint in the system.
 The char device has the following semantics:
 
 * A write must consist of at least 4 bytes and no more than 1028 bytes.
-  The first four bytes will be interpreted as the command to run and
-  the remainder will be used as the input data. A write will send the
+  The first 4 bytes will be interpreted as the Command ID and the
+  remainder will be used as the input data. A write will send the
   command to the firmware to begin processing.
 
 * Each write must be followed by exactly one read. Any double write will
@@ -45,9 +45,9 @@ The char device has the following semantics:
   produce an error.
 
 * A read will block until the firmware completes the command and return
-  the four bytes of status plus up to 1024 bytes of output data. (The
-  length will be specified by the size parameter of the read call --
-  reading less than 4 bytes will produce an error.
+  the 4-byte Command Return Value plus up to 1024 bytes of output
+  data. (The length will be specified by the size parameter of the read
+  call -- reading less than 4 bytes will produce an error.)
 
 * The poll call will also be supported for userspace applications that
   need to do other things while waiting for the command to complete.
@@ -83,10 +83,20 @@ The following IOCTLs are also supported by the device:
 Non-Transparent Bridge (NTB) Driver
 ===================================
 
-An NTB driver is provided for the switchtec hardware in switchtec_ntb.
-Currently, it only supports switches configured with exactly 2
-partitions. It also requires the following configuration settings:
+An NTB hardware driver is provided for the Switchtec hardware in
+ntb_hw_switchtec. Currently, it only supports switches configured with
+exactly 2 NT partitions and zero or more non-NT partitions. It also requires
+the following configuration settings:
 
-* Both partitions must be able to access each other's GAS spaces.
+* Both NT partitions must be able to access each other's GAS spaces.
   Thus, the bits in the GAS Access Vector under Management Settings
   must be set to support this.
+* Kernel configuration MUST include support for NTB (CONFIG_NTB needs
+  to be set)
+
+NT EP BAR 2 will be dynamically configured as a Direct Window, and
+the configuration file does not need to configure it explicitly.
+
+Please refer to Documentation/ntb.txt in Linux source tree for an overall
+understanding of the Linux NTB stack. ntb_hw_switchtec works as an NTB
+Hardware Driver in this stack.
-- 
2.7.4

