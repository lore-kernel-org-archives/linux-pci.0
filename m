Return-Path: <SRS0=Q3uD=3E=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C82FC33CB1
	for <linux-pci@archiver.kernel.org>; Wed, 15 Jan 2020 11:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE6E24679
	for <linux-pci@archiver.kernel.org>; Wed, 15 Jan 2020 11:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbgAOLCL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 15 Jan 2020 06:02:11 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8726 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726165AbgAOLCL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jan 2020 06:02:11 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D4EDF2861C121A2EABE1;
        Wed, 15 Jan 2020 19:02:08 +0800 (CST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.202.226.55) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Wed, 15 Jan 2020 19:02:00 +0800
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>, <bp@alien8.de>, <james.morse@arm.com>,
        <tony.luck@intel.com>, <gregkh@linuxfoundation.org>,
        <zhangliguang@linux.alibaba.com>, <tglx@linutronix.de>
CC:     <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
        <tanxiaofei@huawei.com>, <yangyicong@hisilicon.com>,
        Shiju Jose <shiju.jose@huawei.com>
Subject: [RFC PATCH 0/2] ACPI: APEI: Add support to notify the vendor specific HW errors
Date:   Wed, 15 Jan 2020 11:01:38 +0000
Message-ID: <20200115110141.12300-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.19.2.windows.1
In-Reply-To: <Shiju Jose>
References: <Shiju Jose>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.202.226.55]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Presently the vendor drivers are unable to do the recovery for the vendor
specific HW errors, reported to the APEI driver in the vendor defined sections,
because APEI driver does not support reporting the same to the vendor drivers.

This patch set
1. add an interface to the APEI driver to enable the vendor
drivers to register the event handling functions for the corresponding
vendor specific HW errors.

2. add driver to handle HiSilicon hip08 PCIe controller's errors
   which is an application of the above interface.

Changes from the previous version
1. Fix comments from James Morse.

2. add driver to handle HiSilicon hip08 PCIe controller's errors,
   which is an example of the above interface.

Shiju Jose (1):
  ACPI: APEI: Add support to notify the vendor specific HW errors

Yicong Yang (1):
  PCI:hip08:Add driver to handle HiSilicon hip08 PCIe controller's
    errors

 drivers/acpi/apei/ghes.c                       | 110 ++++++++-
 drivers/pci/controller/Kconfig                 |   8 +
 drivers/pci/controller/Makefile                |   1 +
 drivers/pci/controller/pcie-hisi-hip08-error.c | 323 +++++++++++++++++++++++++
 include/acpi/ghes.h                            |  49 ++++
 5 files changed, 486 insertions(+), 5 deletions(-)
 create mode 100644 drivers/pci/controller/pcie-hisi-hip08-error.c

-- 
1.9.1


