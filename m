Return-Path: <SRS0=6KXC=OT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDBBC65BAF
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 02:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6712720874
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 02:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6712720874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbeLJCoc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 9 Dec 2018 21:44:32 -0500
Received: from mail-eopbgr680071.outbound.protection.outlook.com ([40.107.68.71]:47084
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726284AbeLJCob (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 9 Dec 2018 21:44:31 -0500
Received: from BN6PR19CA0054.namprd19.prod.outlook.com (2603:10b6:404:e3::16)
 by SN6PR1901MB2016.namprd19.prod.outlook.com (2603:10b6:805:11::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1404.18; Mon, 10 Dec
 2018 02:44:28 +0000
Received: from BY2FFO11FD020.protection.gbl (2a01:111:f400:7c0c::103) by
 BN6PR19CA0054.outlook.office365.com (2603:10b6:404:e3::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1404.17 via Frontend Transport; Mon, 10 Dec 2018 02:44:28 +0000
Authentication-Results: spf=softfail (sender IP is 208.19.99.221)
 smtp.mailfrom=microchip.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 microchip.com discourages use of 208.19.99.221 as permitted sender)
Received: from AUSMBX1.microsemi.net (208.19.99.221) by
 BY2FFO11FD020.mail.protection.outlook.com (10.1.14.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.1404.13 via Frontend Transport; Mon, 10 Dec 2018 02:44:28 +0000
Received: from AUSMBX3.microsemi.net (10.201.34.33) by AUSMBX1.microsemi.net
 (10.201.34.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Sun, 9 Dec 2018
 20:14:21 -0600
Received: from server1.microsemi.net (10.188.116.209) by ausmbx3.microsemi.net
 (10.201.34.33) with Microsoft SMTP Server id 15.1.1531.3 via Frontend
 Transport; Sun, 9 Dec 2018 20:14:19 -0600
From:   Wesley Sheng <wesley.sheng@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <logang@deltatee.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <wesleyshenggit@sina.com>, <wesley.sheng@microchip.com>
Subject: [PATCH 1/5] switchtec: Remove immediate status check after submit a MRPC command
Date:   Mon, 10 Dec 2018 17:12:20 +0800
Message-ID: <1544433144-7563-2-git-send-email-wesley.sheng@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544433144-7563-1-git-send-email-wesley.sheng@microchip.com>
References: <1544433144-7563-1-git-send-email-wesley.sheng@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131888834682309863;(5a93feec-e11d-4f7b-166a-08d09f1f276b);()
X-Forefront-Antispam-Report: CIP:208.19.99.221;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(39850400004)(396003)(2980300002)(189003)(199004)(69596002)(76176011)(305945005)(5660300001)(51416003)(107886003)(50226002)(2906002)(336012)(68736007)(81156014)(8936002)(81166006)(8676002)(486006)(2201001)(26005)(77096007)(86362001)(44832011)(110136005)(316002)(11346002)(54906003)(2616005)(36756003)(450100002)(356004)(476003)(6666004)(498600001)(48376002)(16586007)(446003)(126002)(53936002)(105596002)(47776003)(4326008)(50466002)(97736004)(53416004)(106466001)(14773001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR1901MB2016;H:AUSMBX1.microsemi.net;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD020;1:ZD16LKa+hp7ZgcQSJv9b9huaM1mBNwcvydvRuPJYo0io7m6uMbamUCkUKHT6ONtN379jR5+M/lNC/gbrj92JnvJq4Ii50GOa937G2/sHtBb3VVZtsCEQHZzi5apBvr+9
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 925d99e5-3882-4f30-c381-08d65e496781
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(5600074)(711020)(2017052603328);SRVR:SN6PR1901MB2016;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR1901MB2016;3:+Td5rZbThtixw4BFUo9MxR9sRVj0ewuCG6sQ4yxCg7DCosLaQ2JsPLaAYHIkOR2jK5ooVT1H62qYexxaS9g1QtpXOOuTpiRy5NuLqkv8C2sR9mnHX2UlS78v5li/nTkMKudK6UWEzJA2B794GVnytfDyWVEmHGHZkqLpwCEFyzCON8ZmtJlLY/4DYj+JWsmFyqwegAaUzkEmwK6EAHUMHAGrD4wRhy4fsM8qfbsrHT+PzTq9xCv+IjvA7yfzT4qAH+b9Eng605Dtass0pky0eVOjjscwN2JoDiCUZvavgg4dRt1AwpcauHdEJ0wqVJRBiYgMxNEplWxJaKKMbbwWs/P0bmHFb6ZZ+nV7qXO5BYQ=;25:AkofHADtJ4sFLJIQSluemNI3ybCvzVn+Hi5tGvSsg7Y4497VpzbCx5uHZCzqR1bPaVFubd/aig4B9gJAXdx/Uzm8iHoqfXvoRgvk0/FG8FZjeVOCcoIgMOlVUkjsFLCUQ7/fcfS2aX5e/HMyvlPL1wdBHlAH9eUJRN8MmbQ7UEaPDbkPPjt+eQE6cJxF+AJp4vCPyzZDjZRACCjKCwU27Jbol2/Hspv2bjgTSAbbvCcnmCID5SFUvBKDOfNdhW4MBxpLIxW+08TpEhBpxakstgY6nGZzz4bEws/byeyu/N/hL8QmFTyEnxm9axFYsIFw83lCsA199YbNTSuij7uRzA==
X-MS-TrafficTypeDiagnostic: SN6PR1901MB2016:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR1901MB2016;31:wDRdI2FDv3AmpBlMLV43hAu22ZdN6Xr3gbsE0e9Pz8oddFOJJLDKHF+RHaNW5oXwXQdp62Ndzd2uQFZvQ9Pf+EBi12zcJooTIZBDtCrEblbXR6+roiT88q0rtqAZu/Xlp3R60xzLz7W+gkV0sZDAZy/OYy12YrsUcR2v5tBSggsQLN3Xr27U/gP9nkcSPkXRg2YpQUWLuE/BbMXVJBULK65jYVbYuyN1nmmORearD6Y=;4:amoPtgEyQvt+0U5uFCzssn6pvZ/ajRN82qRQ6X9GhquAdcsP5O+D82KNKkzgHzEQniwx5MhC9ujw9kqRtdElAOlVwgPO7tlxdC+dwn/pfoIbA7mc4zxf0K76zyGALyKClmHBI4WsuN25Ym96ERtRP3KSrQVqOzdox7l9zXHyT6Be5kxGJ4pZPMBGUFj+uQOszVjzgG5GgRdX2yLYloXxHlMTS5ap8Kua0lld7yg4sRKeCJrcim/V6ieSmNQveA9FNz49OwLq+tIa+tNLXK+NNw==
X-Microsoft-Antispam-PRVS: <SN6PR1901MB2016594E42F87736F5C7C07595A50@SN6PR1901MB2016.namprd19.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(3231455)(999002)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(6055026)(148016)(6096035)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123556025)(20161123563025)(20161123559100)(20161123565025)(20161123561025)(201708071742011)(7699051)(76991095);SRVR:SN6PR1901MB2016;BCL:0;PCL:0;RULEID:(400006);SRVR:SN6PR1901MB2016;
X-Forefront-PRVS: 08828D20BC
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR1901MB2016;23:uTKnJ+gkVekRN83YBzIAQYj/MlJ33VFGEE6nxPr?=
 =?us-ascii?Q?2l6mzvkVKXwpWpdEXXk5Y58SrBAS7conPmMEyCCcINaj4vWMybq72gXLZ0XW?=
 =?us-ascii?Q?xBUBYsKSLn4zsdVbNaz31wWcCBTl3AdpgrngYaul+bF5fdYJJU/pg2c/hqGn?=
 =?us-ascii?Q?O/nn/2cmvy7kbSOmzAwNAFtCP/KwH2jD/PRLHXl4Vd6nj+n277oIA8+1ZOp3?=
 =?us-ascii?Q?RG7Ghsxn1Qd+U2+A6eRUwo4vj5toG18RmT7dziV3r0liN8MHTF2IkPo2G4uc?=
 =?us-ascii?Q?1N9nu4ZK/osTdieaPAvC2rX64TTDqQJbuBW5S3NdG+23lFIyS27tQr7UPxkQ?=
 =?us-ascii?Q?uolZ/seHd/0wvRHhzo1GSyh7rHgPA119WyYzFhtoFXxwnWFHmfE0dRgTuz+w?=
 =?us-ascii?Q?iP+DIOc/T48sGsY0ugQfYW3IVrCczaE5mIqaoKWKHvsefhEkyfl7wO/bpynF?=
 =?us-ascii?Q?9tkeR9WjgrpKvWUSzZvDjRUddWKOoUT1BsVs2nFp5XECL4jr18LalVVaNWFc?=
 =?us-ascii?Q?X3GMP0Z9vhqbuCm10PNTMlbWPrpinz8W632o1qTTq2+fSXaHtR2IeNJU8TKq?=
 =?us-ascii?Q?vk4P7/adh6BTwTH9trlSOxfbnv1Oj4yTISXq7cESOCafPxHBeKIpIiOSNnXA?=
 =?us-ascii?Q?XSronO3gvPopTGpb2h8YsCI+8SHxfWO5qupnA1dtYrDLu91gY/Viw/26BllT?=
 =?us-ascii?Q?ub9qic3HCwba4nJIvsX1YFwJPHEbmIjWpLscQhZe8KE4bJXwKJGQcbaQQuYa?=
 =?us-ascii?Q?tSOV15pdjZMKjghVf4i56iRauHP8bRXE2RplikadJ+lAoYw8v0o5BGgZ/wys?=
 =?us-ascii?Q?oACKSA2zOBOOs8NmLL/HdvR/sODNWMeXHKT7XhdrVMPp+IfbzHHCli4rcFkK?=
 =?us-ascii?Q?KL1SUmAKw26db0RzEoheMKqTbpnU9BFrn/PRSshZquxol8FBiGqcvZehXEHZ?=
 =?us-ascii?Q?JLU3FkXMfo7lmCKjk+q8HJjOWyyWJP413rUSslgnpVPpQjXxrj3lvfb75cxS?=
 =?us-ascii?Q?LzGGfbU9XOBzNicsRASbxx2coju+vyOR2Z6vWhULeVPaKImU2ATlMP07akwQ?=
 =?us-ascii?Q?GqxP0F5+EpdmpK2WxkFt9FYEgyo8s0S8CaOAfdT2WT68S3rfryqQHBluSODx?=
 =?us-ascii?Q?55eKQ5+XHlaG3PqBsEEq8O+Ny/cKQqaRcMMWb7xdUapTDz5soIcU3xQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: zN/5K1ROPiaGmtFDj17ye4hOvmQJ0bgczljafSa66fw4gTxzgYlmB//BI2YBfyX3gp5EIW8yE565pUmTQ6D0QQu9vKmRJ4CUtukzRCPbMK/zsHX4LSmt8MqePMaIrlDnxT4FdzfsngjGR83YGmHc1SWHAAbxS3lL/TB1cbbiEsdkhsa/z0EmNdUbiwZyp3d4+Oig2Ndh/nGg7Khb8nWwe5jkPfVM9ErHdF/8IxgOvcAsB0qRrZvyXH/rA6cWBu90SWY5K1xS93fygZMquxEHhF40/5TkLf919IIIZRYtzfHrnZXYt8AF8vocybc2/8HZ
X-Microsoft-Exchange-Diagnostics: 1;SN6PR1901MB2016;6:57ksR1DsKACfCRrYv6w3d7GwTRhph0zmt0ul2Dcgv+ajJqj4c/G2X+XPXwUZqz9LLSLPFv6101oaomfBtaZCBwTLv3nyC+eicFouzC+7VHSb0ghyHwmSuoZ08sA6HuHeFE/fvSOmQ1N2FpQ50xapwiRA2ExSrkdB96IUes8litPUng0q76wakW1fMOzhgnpNo3rAv9vc+rE1ZnC+Y+3Pieh3CmovzGOojnKcLzZy4FjUBECuiju50Weg9NkCvDFkzn/ZbFTPZZfZ9IWU27Ssc3aouI7vHSjBsCCRi7k2PxPMgSyBfGMNuI3+TGbxi6lGUVk0bSxE0Pc5LIfZe+0R70okdL3sli39fpkiaytLElQFwoG+mUKgTtuXV9O6a7H27Pjc4yITh1mGMcmUKlckIvoY0GUhl8n84MlB4+7yGszcb+xo8Oo40lmbWlLGw1+M/hLP44C5GIcaA8cSsTOnYQ==;5:Zs8nMyND4EOy96imMUk9DoIjbvfcA+/H+yC6a3sLYTI2BZ9EOgIOVvTN1hEOBtU1gMCZ1QHovTTOCt4M281uUcQfq3HDz6Wy2haDYJBZXAqX7eFWvMduPLD+CkVKb2+gnkoR6yJASYrTeDIUIrYxN5qe8tLpmeeIZqk91Kkw/Ag=;7:0DXZd1VJSelmkRlGVtBb56nijSUsj592OkYbmfnSL1APWHo2RaJhPTN00OJIj8xmXAEdZea7/s33/y5q8wgqDUXO2A/VjDYwdkxvw7EccCLhhIk+sFoSj7RIFr795x1S1RZAnVwc9FKrggVlgW9XNg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2018 02:44:28.0278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 925d99e5-3882-4f30-c381-08d65e496781
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[208.19.99.221];Helo=[AUSMBX1.microsemi.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1901MB2016
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kelvin Cao <kelvin.cao@microchip.com>

After submitting a Firmware Download MRPC command, Switchtec firmware will
delay Management EP BAR MemRd TLP responses by more than 10ms. This is a
firmware limitation. Delayed MemRd completions are problem for systems with
a low Completion Timeout (CTO).

The current driver checks the MRPC status immediately after submitting an
MRPC command, which results in the MemRd TLP that's affected by the above
limitation.

Remove the immediate status check and rely on the check after receiving an
interrupt or timing out.

This is only a software workaround to the READ issue and a proper fix of
this should be done in firmware.

Fixes: 080b47def5e5 ("MicroSemi Switchtec management interface driver")
Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/switch/switchtec.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 54a8b30..d2bca2d 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -134,10 +134,6 @@ static void mrpc_cmd_submit(struct switchtec_dev *stdev)
 		    stuser->data, stuser->data_len);
 	iowrite32(stuser->cmd, &stdev->mmio_mrpc->cmd);
 
-	stuser->status = ioread32(&stdev->mmio_mrpc->status);
-	if (stuser->status != SWITCHTEC_MRPC_STATUS_INPROGRESS)
-		mrpc_complete_cmd(stdev);
-
 	schedule_delayed_work(&stdev->mrpc_timeout,
 			      msecs_to_jiffies(500));
 }
-- 
2.7.4

