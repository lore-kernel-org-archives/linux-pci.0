Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EA5EB64DD
	for <linux-pci@archiver.kernel.org>; Wed,  9 Aug 2023 08:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjHIIUm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 9 Aug 2023 04:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjHIIUl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2023 04:20:41 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07762E7D;
        Wed,  9 Aug 2023 01:20:41 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RLNFd6BL7zcdFT;
        Wed,  9 Aug 2023 16:17:09 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 16:20:38 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     <jonathan.cameron@huawei.com>, <suzuki.poulose@arm.com>,
        <mathieu.poirier@linaro.org>, <linux-kernel@vger.kernel.org>
CC:     <alexander.shishkin@linux.intel.com>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <prime.zeng@hisilicon.com>,
        <linuxarm@huawei.com>, <yangyicong@hisilicon.com>,
        <hejunhao3@huawei.com>
Subject: [PATCH 0/5] Several updates for PTT driver
Date:   Wed, 9 Aug 2023 16:18:20 +0800
Message-ID: <20230809081825.11518-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

This series contains several updates for PTT driver:
- Disable interrupt when trace stops, reverse to what we do in trace start
- Always handle the interrupt in hardirq context
- Optimize the AUX buffer handling to make consumer have more time to process
  the data
- Since we're a uncore PMU so block any task attach operation
- Add a dummy pmu::read() callback since the perf core may use

Junhao He (1):
  hwtracing: hisi_ptt: Add dummy callback pmu::read()

Yicong Yang (4):
  hwtracing: hisi_ptt: Disable interrupt after trace end
  hwtracing: hisi_ptt: Handle the interrupt in hardirq context
  hwtracing: hisi_ptt: Optimize the trace data committing
  hwtracing: hisi_ptt: Don't try to attach a task

 drivers/hwtracing/ptt/hisi_ptt.c | 33 +++++++++++++++++++++-----------
 drivers/hwtracing/ptt/hisi_ptt.h |  1 +
 2 files changed, 23 insertions(+), 11 deletions(-)

-- 
2.24.0

