Return-Path: <SRS0=ulVR=N2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C793C43441
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 03:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F026B214F1
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 03:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F026B214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbeKONWZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Nov 2018 08:22:25 -0500
Received: from mail-eopbgr720066.outbound.protection.outlook.com ([40.107.72.66]:13344
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726892AbeKONWY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Nov 2018 08:22:24 -0500
Received: from CY4PR19CA0042.namprd19.prod.outlook.com (2603:10b6:903:103::28)
 by CO1PR19MB0728.namprd19.prod.outlook.com (2a01:111:e400:7b6d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1339.20; Thu, 15 Nov
 2018 03:16:20 +0000
Received: from BL2FFO11FD013.protection.gbl (2a01:111:f400:7c09::107) by
 CY4PR19CA0042.outlook.office365.com (2603:10b6:903:103::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1339.21 via Frontend Transport; Thu, 15 Nov 2018 03:16:20 +0000
Authentication-Results: spf=softfail (sender IP is 208.19.100.22)
 smtp.mailfrom=microchip.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 microchip.com discourages use of 208.19.100.22 as permitted sender)
Received: from AVMBX2.microsemi.net (208.19.100.22) by
 BL2FFO11FD013.mail.protection.outlook.com (10.173.160.221) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.1339.12 via Frontend Transport; Thu, 15 Nov 2018 03:16:20 +0000
Received: from AVMBX3.microsemi.net (10.100.34.33) by AVMBX2.microsemi.net
 (10.100.34.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Wed, 14 Nov
 2018 18:46:08 -0800
Received: from server1.microsemi.net (10.188.116.185) by avmbx3.microsemi.net
 (10.100.34.33) with Microsoft SMTP Server id 15.1.1531.3 via Frontend
 Transport; Wed, 14 Nov 2018 18:46:07 -0800
From:   Wesley Sheng <wesley.sheng@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <logang@deltatee.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <wesleyshenggit@sina.com>, <wesley.sheng@microchip.com>
Subject: [PATCH 2/5] switchtec: Set DMA coherent mask in Switchtec driver
Date:   Thu, 15 Nov 2018 17:44:01 +0800
Message-ID: <1542275044-10970-3-git-send-email-wesley.sheng@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542275044-10970-1-git-send-email-wesley.sheng@microchip.com>
References: <1542275044-10970-1-git-send-email-wesley.sheng@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131867253806051843;(5a93feec-e11d-4f7b-166a-08d09f1f276b);()
X-Forefront-Antispam-Report: CIP:208.19.100.22;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(136003)(346002)(396003)(376002)(39860400002)(2980300002)(199004)(189003)(450100002)(4326008)(68736007)(53416004)(5660300001)(305945005)(50466002)(97736004)(105596002)(69596002)(2906002)(76176011)(81166006)(81156014)(51416003)(48376002)(106466001)(26005)(77096007)(107886003)(8676002)(53936002)(50226002)(498600001)(54906003)(110136005)(2201001)(36756003)(86362001)(486006)(356004)(47776003)(6666004)(44832011)(8936002)(316002)(16586007)(336012)(476003)(126002)(2616005)(446003)(11346002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:CO1PR19MB0728;H:AVMBX2.microsemi.net;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD013;1:zUCnw582eV9wkN8PtbbtPyYIY2eUDUEqDKM0w7g9SsR77ws3JGnLCI6lgupGDcUJwzcHEBrsGA5srXWoN+sAAovqJjLYFlsZFW2VtpE7ctUjh+s97xBSWcLWnp0HXctH
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e846f9d-8af5-48b8-c609-08d64aa8b708
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(5600074)(711020)(2017052603328);SRVR:CO1PR19MB0728;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR19MB0728;3:pk20Ybys/+NjUhzpUfK6drZbcMmlA/pwYRjxlBcHaJm/G2lAK2DJPLoU57B30+f2qmGoBE9bPZQQGibDABmvsKmBTnlbMPzYy5FI5BS0Bq0dHtqmFFIVuaTA8GAMjDDTn59qkzlswl9XVtPTTonFkuWinMplNT9IEAeu2MN0XvvlJ3xx+uesg+mH6awTTG3VkqJXlrdDt2Gc/1CC1C+zI+ZTuTFhJOysirC6j8J46Nw+wFm8XKmzg+WbcnDiriXrjgV7bGpJfo02ENunoOSJE0WFpI7T/vpdIeWNVG+dkKXhvAKaxm1l/Gw9wlr5ls+12D/5JK6ElVfsuaqRtLJxNuB/Lh5HDCLTOlc8TfbW5gY=;25:p+1p5aeJ36kY+2+Ut214TenqH0oX9askLorZWZOzuVjtjl/7vA9qxwzoR6/hoe/vDWfO6umj4RdIiI2RsOTLHicqECUwU9Nx8tKhQBLAgYL+8NEUNdk49PECNo+3YS/kCc1SO0ofSK4MTIUC6kLbE6ZL7pUH5qQfR3ad2yzjfFabIg8Mav3ogiThmFDXjLwMIF+kgAI7OvYNwOjHJw0ggXrnVujUJnDzsfWVz36nD2lx/YaNSAAspRt4/26QBqQT75rWQGNPkWLxsqfMDEb8Ag4vktQNRV+0Bu5x0KIjiw3Mbi3irJHKeHMDvKL5OeVtkHF8GK3sTDO2StQNsRXA/Q==
X-MS-TrafficTypeDiagnostic: CO1PR19MB0728:
X-Microsoft-Exchange-Diagnostics: 1;CO1PR19MB0728;31:qzwxOlpSgmlXASVLi6P71QWxyGx1rk7gMqAducEfWdwx45QYU6FeMAu1Kgsc/RrcksvV6xZLrSmlXeOagJuJG6AXPs6FrjvsYyUrcgmy0HJ/JN7xsCxSHnN8g5mze+LRw+TGaHDs6/GfZSnkLbNWzP+peeJ2TqHTDRqIJ2ttklVsi4J9ZFgGkNGp1bjD11m7WoHMQGDiMOeus5UdQbPC4nICZKqalUhMunbvJPkVSro=;4:u/wuVY8WqsV8eo+mnL+DbKCt1DrCARsHfAEqs6DIKZwcaI9kbW8nnwQqGuPDrC2MkirfLFo2Mj48tSLR1kUqaYaoxVT8t45t15bH+PIXkb2yOQpqFOEsRC/1bmWsGvWOwL1PT906C4fKRvLnCDC028u3XILl1kr734CI4bh4tyPgnmp3b8FjWRGwPq5OaNhcjtcKOSHumxASmHwmDwCr8JGVy3yyu1iV6SI3oiqjthqd/+xrQdbEJfsoE9DD1tKdNvUHDekH841xUj9TkkdyLg==
X-Microsoft-Antispam-PRVS: <CO1PR19MB0728349018D102347685D73D95DC0@CO1PR19MB0728.namprd19.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231415)(944501410)(52105112)(6055026)(148016)(6096035)(20161123563025)(201703131430075)(201703131433075)(201703131448075)(201703151042153)(20161123561025)(20161123559100)(20161123565025)(20161123556025)(201708071742011)(7699051)(76991095);SRVR:CO1PR19MB0728;BCL:0;PCL:0;RULEID:(400006);SRVR:CO1PR19MB0728;
X-Forefront-PRVS: 08572BD77F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO1PR19MB0728;23:P71ZxHs7aORj/kHBYmG1S+6JHmIGDBlwubRUx8PhK?=
 =?us-ascii?Q?ITfn/ceLern3oOVIxfP9sVC+d4ow68P4UsOO+1SPe4Q2HTuuau7cBzncBYM1?=
 =?us-ascii?Q?9eWWBsEm6nUFnFWLguaL7Yyn1UMG3r/cpVCfaHKnIdPT719oD3wxX+1mdSST?=
 =?us-ascii?Q?+LIujduFWxGwbkO+pdJrDdcANSm/2X1xhoWPSaaIsfQsghp+fYaUKPEYg+WR?=
 =?us-ascii?Q?9bRsu5jYBO3kJJ8b/JCmITJkWGcyYDMWKPq3OrQud+Vrai5qA+PLo/DIZOtq?=
 =?us-ascii?Q?TsiNzF8gFCPRVt7ADVabsw9R5Wnt8jOm0MBOK6UBdxnBMeTL8XJFa12D+Myi?=
 =?us-ascii?Q?rnuNvVdvjp8e2ST+KhYBiCDGbsOiQnWGm0nrKl4aRFvWEm0yu6lrH2pFq7lD?=
 =?us-ascii?Q?hxnGJs853G+0MbY/wgE8sITHSa0x/AwINky7BGkcYq29Udy+n5hZ+vliMgQN?=
 =?us-ascii?Q?87Btp3fYe/JjRooDwp5GvbILmQU3RrpgvC2svO2zBtkzQikaZUAf6RGL203j?=
 =?us-ascii?Q?25rG04FmytmvMooxAh1H0EhkfX6CEhSWK5hkLHSVAS7BLFbV0f2bEc4DDzW8?=
 =?us-ascii?Q?UF0FLCjpeU7/qe8KuBI7Kp1arQu4zSVmu2hoQO/NlIfn3LSbWmlzji19kuKE?=
 =?us-ascii?Q?RG0ukSZnuaHZiSQQ6KX3r/ttnjSmiTNbLBQKi37xW86xdloKHuPGsdkcSmDp?=
 =?us-ascii?Q?1MM4r+fYaUkroTFKaPtdbKEqqINBe11EI1b8xB76oCnwiSemScMfGJIlNDPZ?=
 =?us-ascii?Q?kTOO+UfXv+HiY9x5kR0XpkAEJDfez41TnD+w+M0342yhiVhzuTwq9zkSBdtd?=
 =?us-ascii?Q?lpibB5q42zwNxCippeyPMs9xzN43CORgmBjt7la+n9RVyVXayFv+M+WSoNoI?=
 =?us-ascii?Q?jMGpGHmFWbxMS82wAilOeHcTHgKod1qSXYxoygrOL5o0NAHaWP3nqI9/5GGU?=
 =?us-ascii?Q?nhdxta90xQcTuFolkN6Vep25I4v6BX4a7kNnC8LinalkacJ+WFKsUOovPZs0?=
 =?us-ascii?Q?MC6dZnnyb341kPy+4sF2msbhKvk0QdVIiyqzm2OKYX9GNFgVmSJxONPQTogr?=
 =?us-ascii?Q?RKPvE5jaXQBVsRhYhKckbGoogOPg98NK03u+lt9vH5AD+PzkkVJ4rhEV97Je?=
 =?us-ascii?Q?oOOzBgUJ7cHC4duYXrzWxSueTOuD7v6rxRUCoL86EXMsivpc1k2bSYOFzjvC?=
 =?us-ascii?Q?d8KqgmDxGz0kuxLslOhkj7nRA7U/l9kP+zLZ88EK+Q5L79YQQuS8AFft2Rwi?=
 =?us-ascii?Q?Fb4b1T84davpbu1h8w=3D?=
X-Microsoft-Antispam-Message-Info: 3jyryzN1Ot0Of/4MHS0uOnzUl6pUerRtbU2TUuPBLT9PAVjD+D9KAvu8dEMdc1gv4BUERG3lF1XOstN0IaaEi0H51NZzTCNwujeQTHRJUFMPfNOeA8OChRXdv1qvoct0nr2XUXo+VepOIrmbeHBoG1RBCf8cnpLD3rcPR6KM2Jh9vCfeXeVD0YQknPAm1jAAgBWvrNk+Tf/rndlPFTlChUBcWVFdDQjnVKJLBCke77YFd7bXzTUpXliRKLDF9ze+YybpbwPKU72BrSMfuQI6xYcKedy3cARuVaEykLMtNXvzmYFs1d/aUkYhRMgioWZUSgmgF7wZ6N6n8Iqe6qJkNs1vwUwujDRZ5PsKE6MUaW8=
X-Microsoft-Exchange-Diagnostics: 1;CO1PR19MB0728;6:WVWEMhXpZ2nKJlRtDcz/ysSpIp4EpMZDNU4kJSsIO5IYjOt/9HYqXBFDGyJmtFJasrQX678Edppu+x+85lgWtjuI6cchRJFt+S5+iJOOOGx+fP8H7vtLO90IqIf1VYytHQu/vQryROTqEBJtWLX+Ja77zlwvLhWHeKxYja1sqKxSydTBAR/CopuP2rPXKezyCumFohKUcmpgkhghAka2ZMOAn3Emr6SuzaXiJHsXliahRtZI3U9wuuZL7Kg/+P3RwSKj0Y7SM4e78sgorrWq2dSyQYDvU+AMwT9SEydMrVBtcB1BJKV3KTKmoK4Z6pBGkXWU8Ba1WpWmgXTpdAIeICUMPE2sHnwrgmjSEKBjWJUVyjKfTOouisCjLFg6qs5mFbhoeQjYkp/X1ynMZ3i8D0u54sgxQatflPL47DJRrKT3GhG32jpvha7k4p5qw53BGt1ckywU0qdKL+oVkiH8RQ==;5:PqFfOeVvWYPvNmiemsTWRNVebssiTqNVvAKUL5Fgy4AA8wy9S6evBhaypreds3ILwsTjtsWUqqf0B24amLMTJBxbmxxgDMNML1w17qUe0rwW/I+zQHs1YmWsBAQcX7XhZU7ESpmnz/sBECiFm0J1F8h3wVQbgA1kTHFRsJkOlf0=;7:ITRRFxLkOjYB3N8ROkUZCSiREwACBXCeZA7T77t+9G11aR4pe5tJ+gdiVsnzZpPg25WAgsbOq+N9YNGhN1ICpTvz55TaLPDb965VC3MW7BP7WeEDwE6YZDALsXP2PkuNxf70xb3ZBYDeCP32wuIqdQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2018 03:16:20.3864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e846f9d-8af5-48b8-c609-08d64aa8b708
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[208.19.100.22];Helo=[AVMBX2.microsemi.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR19MB0728
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Boris Glimcher <Boris.Glimcher@emc.com>

Switchtec hardware supports 64-bit DMA, set the correct DMA mask.
This allows the CMA to allocate larger buffers for memory windows.

Signed-off-by: Boris Glimcher <Boris.Glimcher@emc.com>
Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
---
 drivers/pci/switch/switchtec.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index d2bca2d..480107e 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1237,6 +1237,10 @@ static int switchtec_init_pci(struct switchtec_dev *stdev,
 	if (rc)
 		return rc;
 
+	rc = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
+	if (rc)
+		return rc;
+
 	pci_set_master(pdev);
 
 	stdev->mmio = pcim_iomap_table(pdev)[0];
-- 
2.7.4

