Return-Path: <SRS0=mLR+=OX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFECC6786C
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 13:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E8F42146E
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 13:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E8F42146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729861AbeLNNLb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:11:31 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:52337 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729792AbeLNNLa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Dec 2018 08:11:30 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5070771964F49;
        Fri, 14 Dec 2018 21:11:27 +0800 (CST)
Received: from FRA1000014316.huawei.com (100.126.230.97) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Fri, 14 Dec 2018 21:11:21 +0800
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-pci@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        "Zhou Wang" <wangzhou1@hisilicon.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 0/2] Support HiSilicon PCIe Transport Layer PMU
Date:   Fri, 14 Dec 2018 21:10:53 +0800
Message-ID: <20181214131055.52253-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [100.126.230.97]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a perf PMU driver to expose the hardware events for a HiSilicon
PCIe root port.

There are several reasons this is an RFC:

1. The binding to the PCIe port
2. There aren't any existing PCI Performance Monitoring Units (PMU),
   drivers that I can find, so new ground to break.

Taking these in turn.

Binding to the PCIe port
------------------------

The original PCIe port driver had a concept of vendor defined sub drivers but
that has been removed due to lack of users (it was still in the documentation
last time I checked).  This 'could' be used to support PMUs, and seems to
be a relatively elegant approach, representing that these are fundamentally
part of the PCIe port.

There are several ways the hardware interface for a PMU for a PCIe port
could have been implemented.
1) In PCIe config space (DVSEC) of root port.
2) As a 'platform device' on the host that has some known associate with
   the port.  This is the case we have here.

Note the current interface is a hack to illustrate the point.

The alternative is just to have this as an uncore PMU and perhaps use naming
to identify that it is associated with the PCIe port.  To my mind this is
an ugly solution and doesn't work if hardware using config space (option 1)
come along shortly.

It is worth noting that we can only make the association here because
the ACPI provide the resources to the PCIe device in DSDT.

A related question is where the driver should actualy go?

PCI Performance Monitoring Units
--------------------------------
There is no standard for performance monitoring of PCI transport layer
(or any other for that matter).  However, a lot of things being counted
are likely to be fairly consistent across different implementations.

To that end, it would be good to define naming of the events to be 'standard'
if possible!


Jonathan Cameron (2):
  pci/portdrv: Allow for vendor defined performance monitoring units.
  PCI/portdrv Hisilicon PCIe transport layer Port PMU driver.

 drivers/pci/pcie/Kconfig         |   9 +
 drivers/pci/pcie/Makefile        |   2 +
 drivers/pci/pcie/hisi_pcie_pmu.c | 528 +++++++++++++++++++++++++++++++
 drivers/pci/pcie/portdrv.h       |   4 +-
 drivers/pci/pcie/portdrv_core.c  |   2 +
 include/linux/cpuhotplug.h       |   1 +
 6 files changed, 545 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/pcie/hisi_pcie_pmu.c

-- 
2.19.1

