Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2925C43600
	for <linux-pci@archiver.kernel.org>; Tue,  6 Apr 2021 12:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94550613A7
	for <linux-pci@archiver.kernel.org>; Tue,  6 Apr 2021 12:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344202AbhDFMsr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Apr 2021 08:48:47 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:15920 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243230AbhDFMsr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Apr 2021 08:48:47 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FF6jP0wzCzkhqX;
        Tue,  6 Apr 2021 20:46:49 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Tue, 6 Apr 2021 20:48:27 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <alexander.shishkin@linux.intel.com>, <helgaas@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <gregkh@linuxfoundation.org>,
        <jonathan.cameron@huawei.com>, <song.bao.hua@hisilicon.com>,
        <prime.zeng@huawei.com>, <yangyicong@hisilicon.com>,
        <linux-doc@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH 0/4] Add support for HiSilicon PCIe Tune and Trace device
Date:   Tue, 6 Apr 2021 20:45:50 +0800
Message-ID: <1617713154-35533-1-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

HiSilicon PCIe tune and trace device(PTT) is a PCIe Root Complex
integrated Endpoint(RCiEP) device, providing the capability
to dynamically monitor and tune the PCIe traffic(tune),
and trace the TLP headers(trace). The driver exposes the user
interface through debugfs, so no need for extra user space tools.
The usage is described in the document.

Yicong Yang (4):
  hwtracing: Add trace function support for HiSilicon PCIe Tune and
    Trace device
  hwtracing: Add tune function support for HiSilicon PCIe Tune and Trace
    device
  docs: Add documentation for HiSilicon PTT device driver
  MAINTAINERS: Add maintainer for HiSilicon PTT driver

 Documentation/trace/hisi-ptt.rst       |  316 ++++++
 MAINTAINERS                            |    7 +
 drivers/Makefile                       |    1 +
 drivers/hwtracing/Kconfig              |    2 +
 drivers/hwtracing/hisilicon/Kconfig    |    8 +
 drivers/hwtracing/hisilicon/Makefile   |    2 +
 drivers/hwtracing/hisilicon/hisi_ptt.c | 1636 ++++++++++++++++++++++++++++++++
 7 files changed, 1972 insertions(+)
 create mode 100644 Documentation/trace/hisi-ptt.rst
 create mode 100644 drivers/hwtracing/hisilicon/Kconfig
 create mode 100644 drivers/hwtracing/hisilicon/Makefile
 create mode 100644 drivers/hwtracing/hisilicon/hisi_ptt.c

-- 
2.8.1

