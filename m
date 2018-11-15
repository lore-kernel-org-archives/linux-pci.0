Return-Path: <SRS0=ulVR=N2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AD4C43441
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 03:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B892D214F1
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 03:16:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B892D214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbeKONWM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Nov 2018 08:22:12 -0500
Received: from mail-eopbgr790052.outbound.protection.outlook.com ([40.107.79.52]:31187
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726892AbeKONWM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Nov 2018 08:22:12 -0500
Received: from MWHPR19CA0050.namprd19.prod.outlook.com (2603:10b6:300:94::12)
 by DM3PR19MB0795.namprd19.prod.outlook.com (2603:10b6:0:1a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.30; Thu, 15 Nov
 2018 03:16:09 +0000
Received: from BN1BFFO11FD025.protection.gbl (2a01:111:f400:7c10::1:188) by
 MWHPR19CA0050.outlook.office365.com (2603:10b6:300:94::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1339.21 via Frontend Transport; Thu, 15 Nov 2018 03:16:08 +0000
Authentication-Results: spf=softfail (sender IP is 208.19.100.21)
 smtp.mailfrom=microchip.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 microchip.com discourages use of 208.19.100.21 as permitted sender)
Received: from AVMBX1.microsemi.net (208.19.100.21) by
 BN1BFFO11FD025.mail.protection.outlook.com (10.58.144.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.1339.12 via Frontend Transport; Thu, 15 Nov 2018 03:16:08 +0000
Received: from AVMBX3.microsemi.net (10.100.34.33) by AVMBX1.microsemi.net
 (10.100.34.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Wed, 14 Nov
 2018 18:46:03 -0800
Received: from server1.microsemi.net (10.188.116.185) by avmbx3.microsemi.net
 (10.100.34.33) with Microsoft SMTP Server id 15.1.1531.3 via Frontend
 Transport; Wed, 14 Nov 2018 18:46:01 -0800
From:   Wesley Sheng <wesley.sheng@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <logang@deltatee.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <wesleyshenggit@sina.com>, <wesley.sheng@microchip.com>
Subject: [PATCH 0/5] Switchtec MRPC DMA mode support
Date:   Thu, 15 Nov 2018 17:43:59 +0800
Message-ID: <1542275044-10970-1-git-send-email-wesley.sheng@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131867253686450817;(5a93feec-e11d-4f7b-166a-08d09f1f276b);()
X-Forefront-Antispam-Report: CIP:208.19.100.21;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(136003)(396003)(2980300002)(199004)(189003)(48376002)(51416003)(498600001)(105596002)(77096007)(26005)(106466001)(450100002)(53416004)(53936002)(305945005)(107886003)(69596002)(97736004)(54906003)(68736007)(16586007)(316002)(5660300001)(4326008)(36756003)(50466002)(110136005)(14444005)(126002)(476003)(2616005)(2201001)(47776003)(2906002)(44832011)(81166006)(356004)(81156014)(8676002)(217873002)(50226002)(8936002)(336012)(486006)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM3PR19MB0795;H:AVMBX1.microsemi.net;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD025;1:mz7MA8VyjqUHwcpgMzFX8tXIsIcNYC7wdLqD2rME9tCJG2lthjB/pcyxiIuq4wDz5YKx4EzZKCicibSSgY6vtZPXJLMp2tgoskfhb1F2kSwHDCSMOt94/R0O/STKO++Y
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ec4056e-738c-4003-0a45-08d64aa8afe3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(5600074)(711020)(2017052603328);SRVR:DM3PR19MB0795;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR19MB0795;3:I2ovSnkgrLUMArjqJRYg+Svgss2IN0uHJtmoqS/0+aOc7lY2GzklCipwvgzKMEYx5gdk0CE3xICXL3NGB86HmEffh09UVeCM+cXUkLiZ3w7UYDYsOjS/6iGA1u6/7ma0CqKXxFlAB0JxJ9unmVk7I1HQr6Cs9tskQqBarAmFyfjVmTWLDldK4WnnV4do7REy/LR8tzMep8wuaZmy5IU/X3RTQuA4G/+mRHxuUM1ton3LPS/IvMs8CZRmsJAlys+1zNYfy62TfQyeTtEY2h0on9GTSuMHSpvV/2ojkXdnIC0kowLrjoqwCyiTP6BwBN7k3Jactfji0V+BL27BIddbcUYEgADms4Y5YZAutn6brtM=;25:WqXyjuhVQfbwlhCnPmvTvUG1p5tABQHpY6g7FY8/b1jctX7oF/yu2n9421gXdx/owlopPao1+Xanm+RCLTiop0hY1SPiw/PYeclyRRLJjnWx6ThwR4unjpBFOV7lbnqtdrz1miR0GkJNnDKIP9e6xfw7IGThTdTncwM0qQY6vMF8jzBYCxBVHfWuqHzKlcSxqLjOvj6KaURJk6qebZBqhw4Y5hvRqyaS8E7JDDMtd93S9bJNYNa3er26YczQTjVjLrYsnU9ZBti0eSqx4pDSLH9mZMKGA6w19dXksPABZGKkrWvSc8SUvW3DPlByA+qRd0YJwtmsuyW7b3dMrGo/ag==
X-MS-TrafficTypeDiagnostic: DM3PR19MB0795:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR19MB0795;31:10rVsRxHUzQt4jPWLvHDD46n6LJKa2kUejwoM4Gx8m+SFMPC9qUC2aLc3N4zZTXInLGAX52moULXyNu4b35MpKtUJnw8Q7LOk8TNxSriBl80Tljbj60BPPOwMRsm3x5xF1bwaRIXQ3fyCB4Yn/AbrjTlVDS/slliQrcgZFJ/52RjELBfWchBRRpIR3zDJZG4Z7Cq6amy7cJE9JoNMUJBfRHcHgCRznbyPzUyIMqyUS8=;4:l3hzHglYwNYc4Y8Ps3sLmUMSM2rNW5uH97Mg3tPVlI2mhSKhgBMLH15hXM1R4Qgx/SSdbekZgekh7Jj2rbxphhDjs5Oac+rIjlpoxE7qJNg3ZtZudJa456pPEVGdFHB6G9hcgrg75cMwf/u19/6OeYw1pJxxV5OtqV7PwzpxH7McuZAASdazqUfLvj04uLYmkmOVvMCdBL7vtK4Zh9y3NsbXve8mtuNUHG/ZDqD7YzsaSXok4SuumfmLrOyp0VTldtum7L05e3cXZAF6twNnEw==
X-Microsoft-Antispam-PRVS: <DM3PR19MB07952E8DC958148CF2FC7B7395DC0@DM3PR19MB0795.namprd19.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(3231415)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(6096035)(20161123565025)(20161123559100)(20161123556025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123561025)(20161123563025)(201708071742011)(7699051)(76991095);SRVR:DM3PR19MB0795;BCL:0;PCL:0;RULEID:(400006);SRVR:DM3PR19MB0795;
X-Forefront-PRVS: 08572BD77F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM3PR19MB0795;23:W5N3fhnGnKpTs5Y7g/NUMuzL30BGRZGkAk8OSIkh2?=
 =?us-ascii?Q?2iQTPTORbrYOmFcA6S4oHJfzfkhqNclJScwBj4Gay6NJsjm2N2yDNjjFxFZx?=
 =?us-ascii?Q?raNxmKfIoYuJbkzatzN7j7zWH3uX7vWTCcdhNEbacmWZRTzsDyaD3SmawhK2?=
 =?us-ascii?Q?b85jV3LWmsbz+AqG/OGPn7nzAxQJFM0k/5ngI/tTmaYCSjJmdgb+67lJJZM8?=
 =?us-ascii?Q?kAd5gkPgffSwbjNf+WTLnZI0iKpPdKPMkCOF8GHSaDiVKcjhurzcUhJ4LgP9?=
 =?us-ascii?Q?W72wloFCIf2lEBCSRdgYdCiKQt/KeqVjN7y0DiaJL10P8BdCknHGLiTDg1EO?=
 =?us-ascii?Q?ptjs4Km8khZ6Oa8V+sGTCl/x5ZZ5yUThDT//ub9C5TU9ta8ZgGL1LaAkRVCa?=
 =?us-ascii?Q?gUiZmwvtQPzP2gIXg7P+m70Q6OUkF4jQDcV4gfn6DoFYwaSq94qH26OHa6JJ?=
 =?us-ascii?Q?Iajn8VEhR4I4THjC9GubuLck03RMizKd0+Ynfxiszebhi9o80FUNzZb49QJd?=
 =?us-ascii?Q?WjDvsYC28n9brtkp9hcTocTPRncpDGp0IrYrexsPlxhZBMFX1jSTnrEr+cCH?=
 =?us-ascii?Q?hpOOsPL8HIwMJY93U0enaykY4GKOZasMOQrY1PQvEne08spFVjkwdEXaRpBB?=
 =?us-ascii?Q?WvdL1SVNeZsFbVFvPVAJf6aVZcbgG3HHyZWo72AdIKnTR4BoO/gLfnOxou2x?=
 =?us-ascii?Q?SRqyBbZgsCm8Tb3k5Yrv3jbdwDyseTJHbm7L6INQL+0KpKkPGSgBnd5Yi12z?=
 =?us-ascii?Q?P5EHp8KWRiYe3QwqBr6BIuOevbIvNYOgYrG9wCRpN0NFoP7r+h/DzwyFMPV6?=
 =?us-ascii?Q?XdMAO05BFgkFYV+0PVq3G8Sp/FXP7akt3gfvAnLDVme9WnZkapeDt4ZzxGbw?=
 =?us-ascii?Q?Q6wEGu4D3MJR7GZt3Wl0kSUgOTDgm8H5645waYEXnd0L7c/xTkiJUXffssYd?=
 =?us-ascii?Q?e5/2DWic8WlghB7d10axpYMVR3xDmQkuGJRW6oQcMXwltaMr2I0390OMnjhP?=
 =?us-ascii?Q?7NSSL3PXJvmssHoIk9WymzJ/0XwMVjf9SK1eMXKQn/mQkhN2SHwS/8oIM1K6?=
 =?us-ascii?Q?ezEZw1wQKZV0YIEdIHtPgyFDf1jJ81H8AUe/In4NjTqAgHFwfEzS+TsDKh3Y?=
 =?us-ascii?Q?GOKEp5vtK8=3D?=
X-Microsoft-Antispam-Message-Info: X/8m0R/3sGwGRae2GyrSjZlC5cto6kLuci88/uKidvEB5NuJ5EyQMwgc9iQUM+OTFezbzbH+Cn8UdsOvDV7/CMknY1RJ+IcjQfek7kGKC8KuBM+IvZfBtGWu8fIlMZkU3BzjdMJXux1jh88WflBBtooh67rIhvq7ie43OfV3M8R/o4NMb+O6c92aG9VGnA9r2wcX7/eIA9pbGA3y5HSDKSniXORvup88HJp1g75o7pMC9jKUoYCF9fF8y8VP17zQqhoOA0ZlCakqpjMg3XKlbZ9sLLzZ96IKtwMv703CRH2YujrHVKGeb5V0W65W38FR0cRkSpkRG5KGNQa0Evis/amZrsjT4+gqOFEZMyoBRcU=
X-Microsoft-Exchange-Diagnostics: 1;DM3PR19MB0795;6:6qkMzk9DT7QyN5lGQCBJBn7r/NWQ45pa8oRef/hS1Bxh8d0wvUD4O7fi/hSz503bXjwBN92OaiK+RXpQixA8ck1ogVbEH00jiJhgiLL9tsK9FvxckD8o08/jeQ7ym8zzf0od4S5BBg+lsWMYjkAdeJLZO2W0ZsIXKsuQEjc+gzRzhlNUZ+8XjNOSJaGbDG4TDcUZLHdCdx9u55KgrfGWI3cC2C/tiEVYcmwt83f0OAVT03tqg6iowcObtFmfQu0eIEo8voK6NE+biO3P2B4AlbLAmdeNoEEE4qRdKeEVk4pysRwOcCV2rTBxta0Wujj7fTxBQqQpZ1sSSdDDWdCJZ0tGSit6UTKQl2mdD35o2T18VFU9yaGOAeqAmv6EovmuaJhv3Jf2UGlgSYLqCygBHUuDViJxButPCY7jvRRRjKZK81beBaQRCrnY5YyB6vQ4cfliBytdnohxQ7HFcra3Xw==;5:kwfcAf7+0kuPAkRJ2Br3J4HsUwrBWDMdxQOEw6ctFNNdL4k+iZOB7hDbZQN6ORPTmmRtqJ8SIcddscxc94lu7fwq+/R5pPs6ZeWMpn/hqFOdEZXwtFPXjMrFXvryvwisJTeawhJ8LzcdR4VLnXECYTpCV91KrMukSMF/Ngl0QNQ=;7:wzJ68Mpajq3mFuxoZ+Dqld5cEs3vDOxNL01kSwCz3WpwCTDL5LsI0ByI78SZVefO0QwSoRJ9TVYbB85r3+FVlBbzHqcKU/1/0ZSRBMOMwz4vdMo03CmI1eAeHx/4J2h/Kd98ASacbhF8smOY1vz0Yg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2018 03:16:08.3951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec4056e-738c-4003-0a45-08d64aa8afe3
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[208.19.100.21];Helo=[AVMBX1.microsemi.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR19MB0795
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

