Return-Path: <SRS0=6KXC=OT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6C5C65BAF
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 02:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE4C020989
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 02:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE4C020989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbeLJCoh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 9 Dec 2018 21:44:37 -0500
Received: from mail-eopbgr820048.outbound.protection.outlook.com ([40.107.82.48]:17536
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726461AbeLJCoh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 9 Dec 2018 21:44:37 -0500
Received: from CY4PR19CA0031.namprd19.prod.outlook.com (2603:10b6:903:103::17)
 by DM5PR1901MB2007.namprd19.prod.outlook.com (2603:10b6:4:a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1404.21; Mon, 10 Dec
 2018 02:44:35 +0000
Received: from BY2FFO11FD024.protection.gbl (2a01:111:f400:7c0c::150) by
 CY4PR19CA0031.outlook.office365.com (2603:10b6:903:103::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1404.17 via Frontend Transport; Mon, 10 Dec 2018 02:44:35 +0000
Authentication-Results: spf=softfail (sender IP is 208.19.99.221)
 smtp.mailfrom=microchip.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 microchip.com discourages use of 208.19.99.221 as permitted sender)
Received: from AUSMBX1.microsemi.net (208.19.99.221) by
 BY2FFO11FD024.mail.protection.outlook.com (10.1.15.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.1404.13 via Frontend Transport; Mon, 10 Dec 2018 02:44:35 +0000
Received: from AUSMBX3.microsemi.net (10.201.34.33) by AUSMBX1.microsemi.net
 (10.201.34.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Sun, 9 Dec 2018
 20:14:28 -0600
Received: from server1.microsemi.net (10.188.116.209) by ausmbx3.microsemi.net
 (10.201.34.33) with Microsoft SMTP Server id 15.1.1531.3 via Frontend
 Transport; Sun, 9 Dec 2018 20:14:26 -0600
From:   Wesley Sheng <wesley.sheng@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <logang@deltatee.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <wesleyshenggit@sina.com>, <wesley.sheng@microchip.com>
Subject: [PATCH 3/5] switchtec: A temporary variable should be used for the flags of switchtec_ioctl_event_ctl
Date:   Mon, 10 Dec 2018 17:12:22 +0800
Message-ID: <1544433144-7563-4-git-send-email-wesley.sheng@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544433144-7563-1-git-send-email-wesley.sheng@microchip.com>
References: <1544433144-7563-1-git-send-email-wesley.sheng@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131888834751526049;(5a93feec-e11d-4f7b-166a-08d09f1f276b);()
X-Forefront-Antispam-Report: CIP:208.19.99.221;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(396003)(346002)(2980300002)(189003)(199004)(69596002)(26005)(476003)(486006)(450100002)(126002)(305945005)(81156014)(81166006)(14444005)(8676002)(50466002)(44832011)(50226002)(11346002)(86362001)(5660300001)(8936002)(36756003)(77096007)(48376002)(2616005)(2201001)(446003)(16586007)(51416003)(316002)(54906003)(110136005)(356004)(105596002)(106466001)(53936002)(68736007)(76176011)(2906002)(107886003)(47776003)(6666004)(97736004)(336012)(4326008)(53416004)(498600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR1901MB2007;H:AUSMBX1.microsemi.net;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD024;1:mP5+Kc4ulRgyM7vvowmvtxVUTFwl01AgSsh42CU5wC0o4YzQpO8z4amj6T0L0j4qlYUERoSrGC/NKSluYwauSm25o5LUcSs0xcGqM3pBjU4i1NYMHUsmoBopYS6s4YD8
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6b81e1a-15b2-48ee-11db-08d65e496ba9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(5600074)(711020)(2017052603328);SRVR:DM5PR1901MB2007;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1901MB2007;3:CXa+9AQpJCHvSkaCnKd7tMwQ46vUzfx9XMn4+l7cWLsxEr2Qd01xR1NnCfQauuaKdcBP2c+cVcW0XUAJZUOBkrXYckNzeYsmBlKtsOFCHNpXK4LyQo76QL4NVCBNbDzGhC9K992417mzNjWYlc5CUyzCvshbjWYNjPuRRn6PQ7SPf5IeDCFl8LEewcVz3Gk8YZntyQi0+UnGhVbAtfuypFUdhrUaXFnLAl5VXPFIZtjFbXLMcQ699glcmG+ea2U6g+Wn1fGClC5U11cFmD70jqPX7T9OXMIyDkqS1fWiZz07QwaOmo7PmcwtfLlXy4jZeyrDKdvEYH/sbRyCNV+du1Kz+1WfJ9kGC+WZpgjX8sY=;25:Cj2dUT4OyGjWL1mHZ3cnZeOB/XS9P7anq8JpbcPWeafUg2STTLByQxq6zyheMaSSD2ljgVFyHNbysMVojKIS7UQfo5oON5p4+t6kEA2VnsTFPnYvr0qLngBhvMZzEuWPV5jRGFT0jk1lugk4nV4IM9QVBqCyzUY6ZvAby6YxpBEdCbcnlGOKF0OyFJtDUCM+3BPa4rPTyUqbB89LQgxy9C8ZevsJ/GCAEQwy8Hzt7chtriBWcBoPG1bVuE3dG9A/n7jjYmrnBIzkWC8KNkIwaWk/kF+tt7L/ouDSnvLVs9Wi+Ce6eb90O3/JMfCQVHBKvze43tKt29BjkacBAo/kMg==
X-MS-TrafficTypeDiagnostic: DM5PR1901MB2007:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1901MB2007;31:71WCnLKn7DakJsqpSxl/r/kvW10UW+BUX0zXljENYEdDt4WhTrMHjsarioceC1tpKoM3nj5GyUUr/kDXPUeIPihALmAVLtrKwwED5DNm0PcezVN6aHb//vm3yHQi7T573buCsjJqwR9Mim/03feXCkfZlWlhXvgYVgADIf/G1VvUrQAYO50BKsmRcw9GjDru5QFLzrTUMLlnkun3s2iCIDZmW5oYpq6w7OjQDmlPnAI=;4:3gZwIqs1ThaVawlUi7XJeU7aMRJx4R+Fep9OqUWbFZp6GMR1lJx5ieagcEb+K35Dz6D74OIxDZngvleifbU54dbce2OaqeOQBeAAE2NErz/wlzv6pA630lzq8tjzNxQNBhqXlTVAVmb7WFwFTqItrMbixrRHw0zcBnYntfnHHPnHca3APTdzK9RtJVHyMzlrKekgAR73uZsIpX7D/adFT7jEkrwoAfIabda32qTexGyHvYosyb1+80L3ViWDRY9OE44PjzJf4A4DgkkvPtxo7g==
X-Microsoft-Antispam-PRVS: <DM5PR1901MB2007CA0F9766A66092B1F9FF95A50@DM5PR1901MB2007.namprd19.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(3230017)(999002)(6095135)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231472)(944501520)(52105112)(6055026)(148016)(6096035)(20161123556025)(20161123565025)(20161123563025)(20161123559100)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123561025)(201708071742011)(7699051)(76991095);SRVR:DM5PR1901MB2007;BCL:0;PCL:0;RULEID:(400006);SRVR:DM5PR1901MB2007;
X-Forefront-PRVS: 08828D20BC
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR1901MB2007;23:bzsHsQNKTA5hqXPQNehR5E+gmsUfNlSQIQB6EE/?=
 =?us-ascii?Q?N2LK/gvsjPfotv87ARnNnPrq++rA580p9CGphrd+/Uj6f143dOiZqQO6vCyL?=
 =?us-ascii?Q?OJ1d/DO9HQ+o1UMg9NlTX6uVNQWK6IjM8eNwei9FB9Xwsm3M8aTCgsWrjRDY?=
 =?us-ascii?Q?/KsEuxIp6voQfocx6am9djLAxH6hY/o2ObH0tkEGVmDEnbBzQ+ztFBbglYz4?=
 =?us-ascii?Q?4cMzHrIDh5wXrRM1vmYvIeK0+bjNhfKeHqCCKQj2r2VJHZCbXsvNSYugoqp5?=
 =?us-ascii?Q?TgjAkl0wyp8hWDPuPFWo3Jm/cepvsmjzBb2EGkZu0ftZ4NOHmXR7AxoAORrC?=
 =?us-ascii?Q?7ELhPdTd53OpmFnQye76Tj1ibtfkHfRBcUkoRY6HUKCtHG30/LEg+R7f0uqc?=
 =?us-ascii?Q?qXoq2Z4P/nWoUR9YX6w/9pnOnV550CHYUxSNbutOcZJL9QWjLP+RW/XtaZFs?=
 =?us-ascii?Q?TORmws8nMLR9xKLHJoJRPaXKtbRZUSbjjdxJGCDtPd0EmdgtytKM16G8NsZ7?=
 =?us-ascii?Q?f5YZoqrs/7OYVj1chsLkll19xGTk0RBdXRQDagrcDB7e/MrWiOQLEHX32Zdr?=
 =?us-ascii?Q?iDU9xsA7dNZGF/h9vnNvjRi9kvj408c5cwR1FIx068mUjQ8u9a/AVdqlC5a4?=
 =?us-ascii?Q?7af4ai/rie8OUbUYAwcKxxdTt8L5BVq2jydiWAWzxGeNJPyvAXDvvGaREiDl?=
 =?us-ascii?Q?3lZPkX1seNzr4Pl7bh8BkfHsfKFSm7z2oqu60MrE0G7VRCLh5sgcrAxgZkDz?=
 =?us-ascii?Q?5hPeDyOVvFGJZlX2ieGl/rtCmF2jbh0j6HrhpFT+R7kM8PxoJ09l1RgMjBMr?=
 =?us-ascii?Q?R0MNOCvPck4zkg5/JTXMZcSbEcoylL64QmZBIkILdRD+F7YYtcfrY2ujPVxk?=
 =?us-ascii?Q?974mRi0EOXePb/dYN6Qxdrfpz5RTWgOHq3Rz3rM4kc3DCP2sI/2B8hU9CwK6?=
 =?us-ascii?Q?TRhAZkAUM30i670M2Zd3SAVCLcDquAdzkLepVa30WmVW7dVbEEWCWPqOOtEf?=
 =?us-ascii?Q?DE4BxHAXxfV6ytGZh0wUst3EPH8xz08TwoKlWk+BJ95swLSfMHqfrtmPANHv?=
 =?us-ascii?Q?u68sNlS8mE623wZmD+Rm/VA4v6DNIa6emvaXgWcajGFGnKNr1In6VdIvXDDI?=
 =?us-ascii?Q?Chp+32ggoXuKiUiiF6yYUpIxmkzb1v0GtUz6bWcCupM3xIR2ERh556A=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: 8DRQStJqWtP290ChEERjWmPaJxWXYC52I51Ym32ZjnDG5sDD2A/Ry2AAciIQH7RP+YFA+M21nA2kZy93jt9RBUdq1cgCFdqrJ9WajP4I2fvpVul/0SnjQq+/F6390UOEIKUN3RReIUxH3bs8Seto+nLVzV+/HlKxNfA47PhjgIAtjDJq2dErc0i3XliV2/wV+5+R8gvIrKXgZ2yIGRnCb6Kv8AlOUNpoALHaLUxfzSgG0Rebb0TMlfRgWgz3mpnBYtCrbwlN6B0RtyXRxSRKzt/C8C8QEY3TMGbZLakuCNRUSht5Rv8l4tta7QvxVsxk
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1901MB2007;6:ITMIVW3WlTb9hNvcPX85hPlVxT0lN+wqSHMTG9F/MZg0iepj1N4TtOEWnJQXQFEfDxQuhKRlgGygrd1FJadE/3Eyr6j5W4UGm8XhzE2oAvcG6rUBoVUiyQki6iLmhRDJRKeDntTt1+thiA8e4WHaE89s0LdE+Hw2KnPS/dRJo3AZ8rZ/QjFwedfMjhc8q+3oYrHvCo/iD6n+TsT6+jDPXE6eQbrPKcY7Eb/P+lM8dzbfd3JFtjl+ClTnQvDt9rodjpTkwjrf5eaD/lSXZPvqr7USYuBfOmKfb8CUzhcZ5D5d1w9TYGAUpLm+78nrjl0/w1+ocMLYDSjycTxD1Bpfb4PPAMmHBiAgSL9HDjG5qaapU51vWqZU/Fql9lVf6KOcgKbtBnihxeQzVCsWHgV/6ai25UcH9ZzAUPDaj/iQQQHl+o31OYFhOn7KW3g+wgEcqOeAF+5liV25h1zBznL0UQ==;5:VOymrfHEmwJNNkq4LlhUcr2W1xpZR06DBjqQ86UBN4L4VSZbU0mjubKrthpkDCwmifzSGAZ1bjvEoYsyPQfx27MTJ1dexpkbLKUhgGCX4JTRsdEWffbykZqQXKTnAm/QJWtkKeD6AYYf/CIalocJaUlITf+kTyNhWlpJCQI7oJg=;7:rSoHgDMnDxZdRy0nfDJlq85xRL+/gDwnYatG6gXPQ0eEZcBbs86jnpBc6yJJnFX8TevZeY+hIpCx2fLj5X0SMRZQYcQuzOc9vcfqVWikqgd5QHrH4aV3R9lOgdMRjZIuToBmoMrymTDWZbNLH6WUQA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2018 02:44:35.0275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b81e1a-15b2-48ee-11db-08d65e496ba9
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[208.19.99.221];Helo=[AUSMBX1.microsemi.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1901MB2007
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Joey Zhang <joey.zhang@microchip.com>

For nr_idxs is larger than 1 switchtec_ioctl_event_ctl event flags will be
used by each event indexes. In current implementation the event flags are
overwritten by first call of the function event_ctl().

Preserve the event flag value with a temporary variable.

Fixes: 52eabba5bcdb ("switchtec: Add IOCTLs to the Switchtec driver")
Signed-off-by: Joey Zhang <joey.zhang@microchip.com>
Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/switch/switchtec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 480107e..a908670 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -796,6 +796,7 @@ static int ioctl_event_ctl(struct switchtec_dev *stdev,
 {
 	int ret;
 	int nr_idxs;
+	unsigned int event_flags;
 	struct switchtec_ioctl_event_ctl ctl;
 
 	if (copy_from_user(&ctl, uctl, sizeof(ctl)))
@@ -817,7 +818,9 @@ static int ioctl_event_ctl(struct switchtec_dev *stdev,
 		else
 			return -EINVAL;
 
+		event_flags = ctl.flags;
 		for (ctl.index = 0; ctl.index < nr_idxs; ctl.index++) {
+			ctl.flags = event_flags;
 			ret = event_ctl(stdev, &ctl);
 			if (ret < 0)
 				return ret;
-- 
2.7.4

