Return-Path: <SRS0=6KXC=OT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C46C65BAF
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 02:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC8A2082F
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 02:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC8A2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbeLJCoc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 9 Dec 2018 21:44:32 -0500
Received: from mail-eopbgr690063.outbound.protection.outlook.com ([40.107.69.63]:31866
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726314AbeLJCoc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 9 Dec 2018 21:44:32 -0500
Received: from BL2PR19CA0002.namprd19.prod.outlook.com (2603:10b6:201:f::12)
 by BY2PR19MB0231.namprd19.prod.outlook.com (2a01:111:e400:58b1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1404.17; Mon, 10 Dec
 2018 02:44:26 +0000
Received: from BY2FFO11FD027.protection.gbl (2a01:111:f400:7c0c::115) by
 BL2PR19CA0002.outlook.office365.com (2603:10b6:201:f::12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1404.17 via Frontend Transport; Mon, 10 Dec 2018 02:44:25 +0000
Authentication-Results: spf=softfail (sender IP is 208.19.99.221)
 smtp.mailfrom=microchip.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 microchip.com discourages use of 208.19.99.221 as permitted sender)
Received: from AUSMBX1.microsemi.net (208.19.99.221) by
 BY2FFO11FD027.mail.protection.outlook.com (10.1.15.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.1404.13 via Frontend Transport; Mon, 10 Dec 2018 02:44:25 +0000
Received: from AUSMBX3.microsemi.net (10.201.34.33) by AUSMBX1.microsemi.net
 (10.201.34.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Sun, 9 Dec 2018
 20:14:18 -0600
Received: from server1.microsemi.net (10.188.116.209) by ausmbx3.microsemi.net
 (10.201.34.33) with Microsoft SMTP Server id 15.1.1531.3 via Frontend
 Transport; Sun, 9 Dec 2018 20:14:16 -0600
From:   Wesley Sheng <wesley.sheng@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <logang@deltatee.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <wesleyshenggit@sina.com>, <wesley.sheng@microchip.com>
Subject: [PATCH 0/5] Switchtec MRPC DMA mode support
Date:   Mon, 10 Dec 2018 17:12:19 +0800
Message-ID: <1544433144-7563-1-git-send-email-wesley.sheng@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131888834652692579;(5a93feec-e11d-4f7b-166a-08d09f1f276b);()
X-Forefront-Antispam-Report: CIP:208.19.99.221;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(376002)(346002)(2980300002)(199004)(189003)(68736007)(105596002)(126002)(36756003)(107886003)(486006)(2616005)(476003)(86362001)(50226002)(2201001)(81156014)(8936002)(81166006)(2906002)(26005)(47776003)(48376002)(51416003)(50466002)(77096007)(8676002)(336012)(16586007)(5660300001)(110136005)(54906003)(498600001)(316002)(450100002)(4326008)(305945005)(14444005)(69596002)(53416004)(217873002)(356004)(53936002)(97736004)(44832011)(106466001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR19MB0231;H:AUSMBX1.microsemi.net;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD027;1:2QVKQjaKJuVyaG6jOMMS4AnBIyzrkOBAZ9320QgvdfECkJu3IqgmbEtJ+XR0ZPdugDvJiaktO2OBoG2PeekYocT0jp56/Rb8DzzazcscLQjYHuDcxamHKAcSqg3Vwizn
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1f2aa0d-6d95-4016-d5ad-08d65e4965bd
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(5600074)(711020)(2017052603328);SRVR:BY2PR19MB0231;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR19MB0231;3:IAKq77omGX1QC4q+qXT6wKHPx6GWj45qtWhzxSrZlVq57inf7nLC2H/YFylBT92uO/KkbYLUSYcbCQ9WKzSSBsLoSRZeMKDe9btiBnkTaSNVQGG+L7aVeAJ/GnlRR9K/gwx7Q50GigZG5301PzjzLYuCDN3VQUeSB3ovCSR0xclDjU+4/R9Q0YrMB+c+4whuwi+xoF3jQ1CICWhRO5P3YuzkXO40I+bvbjAoXky9KNkm/0hO6J3SNiIuMmQK8W0Un317EZDnaPwL9RwBdAjQ5TsjcxLwsuP3L6BN7gSFpNsTOeutqAGMbnnrjTwABnQxO0YgVHBeDhfQH/4O0khcqj1N2qy9x3Osm5ZoXMu7GwE=;25:kavyoGk6mv+oFfCRhDrx/En+M4zEkEGOefmGLBBUGq6LApA8pSFk+W8k+hPR9lPwNntsT9ndxLPZ8wZji/8uYXE79JyqxLQ6YJAfWuo/+EWAz8/ojZQzUPCItumGIrqmlbsiB7DJGcoDW5XWnqMioHGthXJicbrsg1gIokr8znubmXXTBNHpK+FPqVefARRpBr8hH/z/ZNKSUSvu9A4CvUOM2GcDkZ34r3jioS1UBwKOi2CBwcjQWLcLpfoKcsFzx+0ciLHOAlk0BUz4HnmmSWDnll47KhgFw61quveVg/Je7l49cE+mHNqcEidL5xaEiJ7LDXEjhiNe+t4aJvmKUC3ENhE5VIoV6vnEn2hgdTc=
X-MS-TrafficTypeDiagnostic: BY2PR19MB0231:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR19MB0231;31:dQOQVinWPl8aBcumMGbaLA0ZpAbTQwwbnes5vFpI98LNxPzLovZMpeX7HLJ9sVoZTWyfCX0npWb2msutrmtqsWBv1Dr7x8ykGuGwaRoV4EipJuT31WGmGbcoWh9eGslav2wcRTBBtU0nI8+SC5o1k4QSnlsQ8MtmtckwiDMeWZ+98t2B5J/ZID4IyfgM7NVCeXt+CHTA4zQjgUBcC55ohchBZ2E6GZfZk1c2gvgHiAA=;4:ry9nmIpQRyMCFFcUH+cQnyWwHzJtcWQl8O40XgemuNEOUKB9yGT0THIB+QshpxIAvgmbMfyCTAgXX/vEVoyPYzHxPpth49DTwzfmyu4TBjTfRMKHxPwFfxSwJfqBJPPnmBBoiXlMZjLFpbftFurV0ZbZSb3yFvu2nxQeSI7/lIQlluTSkIdPrkqk1+R5dtwf02ZNVqDbl9cuAT/AtiyF2Az+CsqXWHgaERG6eH9IyzgqrmeO6QBfHE6j62zmyOVsWLRKHuYX/yMrq1s/72uZnA==
X-Microsoft-Antispam-PRVS: <BY2PR19MB0231F04F9E75C738ACFE08A395A50@BY2PR19MB0231.namprd19.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(6096035)(20161123556025)(20161123561025)(20161123563025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123559100)(20161123565025)(201708071742011)(7699051)(76991095);SRVR:BY2PR19MB0231;BCL:0;PCL:0;RULEID:(400006);SRVR:BY2PR19MB0231;
X-Forefront-PRVS: 08828D20BC
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR19MB0231;23:TuwTk5t8OXrdHrSrIdsDavgon7DYkdyb6BjcARkAf?=
 =?us-ascii?Q?kQTacJH9pl8x8ESHStYIcDII+zkRAoe/1F2U9dD9nuOK8fRSPAzwEYIBWN6w?=
 =?us-ascii?Q?vpAaVTyGa5eNxtm58tKHy8Q6lw+YJWXoPr1InCna0cCtyWdngU5NRIZy2JYZ?=
 =?us-ascii?Q?JrJNlMKSvtABHAZHb89mmNz9/LvUpl7hRt9QowBc1O3REnZhrsPr23CnIpaR?=
 =?us-ascii?Q?45YtAS/ceiOtLEqR6ezGugsAnPJwSdnQID3r3C9aG7Mo7uBDzb4jyQTvL09S?=
 =?us-ascii?Q?ueY9+hTy1aM8czD4DWmRCHGtY+MU8ArIMbdBuKVN32Ypxct52gpy9n0rRnKj?=
 =?us-ascii?Q?rt2GGeNEd+YMHzyYLwKycYrVA1US6XupPLFv7GtnIvfQTyKqcm9Cbkvwgj7t?=
 =?us-ascii?Q?ccNh/jUrFnc+Ez6f+656NdKgjLQmYN/R0fHd1BsAKql93mnAyR4DHu+XEpV9?=
 =?us-ascii?Q?GV887QhOkFZFO7H9TVztqV5c/YhCXF9IKlk1bvs5Fh6PM0XwSb6RpTvF47PB?=
 =?us-ascii?Q?6jbZVmEWIDGm2K4VvMvxloVpFqnHz414Pc21jX0YfUKJUrCJIAm4NRm2YFJ8?=
 =?us-ascii?Q?WRLq9Oanjk/o7A7dDsqu126wQVxy3GWDGw+zjKYpQFO1nsNtQz8/vI8sFoSf?=
 =?us-ascii?Q?QnUDr6kg03bkKun7Dn+LqqtmFKTDW3S6kcnPKxEFX2G/H0FOmwJd0X9JkGhe?=
 =?us-ascii?Q?14sF5jTzMdtweIYnB/iZwGzTsTKiTzI7rHs2T5TLVpceq2fMUAqTJ1tClnk2?=
 =?us-ascii?Q?736Ik5ZN9hZn4HnPpeLjooN9q9eCZTvm05K87JGCQCPigx3CF0dXfUuA1pJ+?=
 =?us-ascii?Q?o7w3QWR8UMkgvlim/r5SyEm00gwkMLHMgTNWUkoFRxlyqAn3MmuYhfiRFLJ8?=
 =?us-ascii?Q?lAYcAyXJGViOVVtCf5xZLsFlJbsUM5Jpwkv2WelHjDsztxSGrpK3OXTfF8Zz?=
 =?us-ascii?Q?VwYruqsZKqJ9sBVyFs/7Xi/7HT/wz7an/NweDZcan9hVCKcnhq9q9guXqrun?=
 =?us-ascii?Q?SM2dl1v5ahSgzcYctH3WUpA1FdHolpX5BXreYQEMO1HXITWcsA0TYbeeBu2x?=
 =?us-ascii?Q?nq/SXdEbGCXOkmvgoMlHVkhO9CBkIpSb78Z9P3aGy229YeMKko5UlNqRgtQi?=
 =?us-ascii?Q?mVOVX1F0PA=3D?=
X-Microsoft-Antispam-Message-Info: EKUTrqV9ZQV+/mgf8WSfIltjzU950nGfEHOz6f2hYGoYk5mdUSC4HoMpEixbEbQtiDMPElUqdGzthT5+ke03Vkp+NbRkQstLoEu3SEj+8tKW1MOS/tExmo1191z9cZI0fCc5TmdMXtp5Rdd+19mmXvH19uY4sMDI6v+fpEo+FpNmSeulNeSNprz2y33pdNfMQCUumxypkR7GVyahYl7L1yhrhP5FvSN3lUBE2YAEcT0uDS1V4rF3Ebr4MCvb2LQJpx79MJlLMVfjYK9Y0cSyoBczpjTEN6+zbvnm2az5KfwxjG97R4cFbNJ6NDc7JuPl
X-Microsoft-Exchange-Diagnostics: 1;BY2PR19MB0231;6:RztK9NQpmuUQkVYOU4LitQdpODdfzhByYmhb5w06vGH/dLkEiHY0u9gE1G6DVLt/PF9MryXSdoSO1AOgvIWBX+UAMsgezRu92iRhurDK05+kT/DYt34Xr55U4LxYyHeAfHfiBAb9pJy4k9R9Z62Elt/OFqw0C02f7T8T3/9oLA0TncsgKjmgzb/+AnmrtYoq/hp9p4F29zxWUg1pA0vkCpVLE87BL0wjs7USQOuMz3wp5SLKVl7DMcBrra6hRHQKropcDpGcFEye7JVBe5mmB7Koew6QTauEG6IlKzOsYL+7uGcufLDWmk0AqQLwVH/l8It225yxm0SXi5Ae0mQntnarXjM2YaMDsrt9AAD0pviAPx4Z3lnC2hW5q3iu+6YhYiFcOKyZi/87e+T11YlhNqTPuufkkJGhI/+WCj1rDV5uKrN9u67ZNeGGMVKFyVKPNFyXwBrQiikmZ37MbbKzBA==;5:L0nWK+7s8IBn65aEBIjr9y6JfNBkasNGnfXzEMNENMvJqUQTEPA+ZSFUDaMkZJe/436mI/EJ8SpLxLfu7PdsZo1aCmOBoB7UunzKdlfplmOSJX2p1+Ej5DwapWRZ7kMzqK9o0w7chL/2s3gFgE1s6BrIXQrKFubGeAMuIqewB+E=;7:I6U8II5ABEMFGXslHKwWYh3Lq7pG5UfNACjx7B7cU/EcXjinVUMsSrBhcvpHmQJYC4FDgRg1BFn+CG60Z4/I6UK60cYSo/7kQkAYEo2gbzPpfTg3euwasvOUAujZooW2f1cRLdzgcpxo246YDDFDlw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2018 02:44:25.0817
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f2aa0d-6d95-4016-d5ad-08d65e4965bd
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[208.19.99.221];Helo=[AUSMBX1.microsemi.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR19MB0231
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Everyone,

This patch series adds support for the Switchtec MRPC DMA mode.

Switchtec switches supports 2 MRPC interaction modes: MRPC normal mode and
MRPC DMA mode, a new feature in the latest firmware versions. MRPC normal 
mode requires the host to read the MRPC command status and output data. 
In MRPC DMA mode the command status and output data are pushed directly to
host memory and issues an interrupt upon completion. The advantage of MRPC
DMA mode is avoiding potential high latency response from the Memory Read
TLP. 

Additionally, we've made the following changes:

* Improve the efficiency of filling MRPC Input buffer by enabling write 
  combining on MRPC region of BAR
* Software workaround for delay responded Memory READ TLPs that access 
  the BAR
* And several bug fixes

Regards,
Wesley

--

Changed since v1:
  - It's a resend of v1

--


Boris Glimcher (1):
  switchtec: Set DMA coherent mask in Switchtec driver

Joey Zhang (1):
  switchtec: A temporary variable should be used for the flags of
    switchtec_ioctl_event_ctl

Kelvin Cao (2):
  switchtec: Remove immediate status check after submit a MRPC command
  switchtec: Improve MRPC efficiency by leveraging write combining

Wesley Sheng (1):
  switchtec: MRPC DMA mode implementation

 drivers/pci/switch/switchtec.c | 154 ++++++++++++++++++++++++++++++++++++-----
 include/linux/switchtec.h      |  16 +++++
 2 files changed, 153 insertions(+), 17 deletions(-)

-- 
2.7.4

