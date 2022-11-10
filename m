Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25E7C433FE
	for <linux-pci@archiver.kernel.org>; Thu, 10 Nov 2022 08:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiKJIwD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 10 Nov 2022 03:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbiKJIwA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 03:52:00 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781672ED7A;
        Thu, 10 Nov 2022 00:51:58 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N7Fv30nZKz15MZW;
        Thu, 10 Nov 2022 16:51:43 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 16:51:56 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>, <liuqi6124@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <jonathan.cameron@huawei.com>, <bagasdotme@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linuxarm@huawei.com>, <f.fangjian@huawei.com>,
        <prime.zeng@huawei.com>, <shenyang39@huawei.com>
Subject: [PATCH v2 0/4] Add TLP filter support and some fixes for HiSilicon PCIe PMU
Date:   Thu, 10 Nov 2022 16:51:05 +0800
Message-ID: <20221110085109.45227-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

HiSilicon PCIe PMU support count the bandwidth of TLP headers, TLP payloads
or both. Add support for it. User can set this through perf tool's
'len_mode' like:

  $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,len_mode=0x1/ sleep 5

Also includes 2 fixes of both driver and documentation in this series.

Change since v1:
- Refine the documentation per Jonathan and Bagas
- Collect tags from Jonathan. Thanks.
Link: https://lore.kernel.org/lkml/20221025113242.58271-1-yangyicong@huawei.com/

Bagas Sanjaya (1):
  Documentation: perf: Indent filter options list of hisi-pcie-pmu

Yicong Yang (3):
  drivers/perf: hisi: Fix some event id for hisi-pcie-pmu
  docs: perf: Fix PMU instance name of hisi-pcie-pmu
  drivers/perf: hisi: Add TLP filter support

 .../admin-guide/perf/hisi-pcie-pmu.rst        | 112 +++++++++++-------
 drivers/perf/hisilicon/hisi_pcie_pmu.c        |  22 +++-
 2 files changed, 85 insertions(+), 49 deletions(-)

-- 
2.24.0

