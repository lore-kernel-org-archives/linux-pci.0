Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C174CC433DB
	for <linux-pci@archiver.kernel.org>; Sat, 27 Mar 2021 06:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FBC261A02
	for <linux-pci@archiver.kernel.org>; Sat, 27 Mar 2021 06:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhC0GoR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 27 Mar 2021 02:44:17 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:14919 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbhC0Gnr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Mar 2021 02:43:47 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F6q571DhNzkmX6;
        Sat, 27 Mar 2021 14:42:03 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Mar 2021 14:43:34 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>, <rui.zhang@intel.com>,
        <bhelgaas@google.com>
CC:     Xiaofei Tan <tanxiaofei@huawei.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH 00/15] acpi: fix some coding style issues
Date:   Sat, 27 Mar 2021 14:40:41 +0800
Message-ID: <1616827256-51840-1-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix some coding style issues reported by checkpatch.pl.

Xiaofei Tan (15):
  ACPI: APD: fix a block comment align issue
  ACPI: processor: fix some coding style issues
  ACPI: acpi_dbg: fix some coding style issues
  ACPI: acpi_fpdt: replace __attribute__((packed)) by __packed
  remove useless return statement for void function
  ACPI: acpi_lpss: fix some coding style issues
  ACPI: acpi_memhotplug: fix a coding style issue
  ACPI: acpi_pad: fix a coding style issue
  ACPI: battery: fix some coding style issues
  ACPI: button: fix some coding style issues
  ACPI: cppc_acpi: fix some coding style issues
  ACPI: custom_method: fix a coding style issue
  ACPI: device_pm: fix some coding style issues
  ACPI: device_sysfs: fix some coding style issues
  ACPI: dock: fix some coding style issues

 drivers/acpi/acpi_apd.c        |  8 ++---
 drivers/acpi/acpi_dbg.c        | 40 +++++++++++-------------
 drivers/acpi/acpi_fpdt.c       |  6 ++--
 drivers/acpi/acpi_ipmi.c       |  1 -
 drivers/acpi/acpi_lpss.c       |  4 ++-
 drivers/acpi/acpi_memhotplug.c |  2 +-
 drivers/acpi/acpi_pad.c        |  4 +++
 drivers/acpi/acpi_processor.c  | 18 +++--------
 drivers/acpi/battery.c         | 64 +++++++++++++++++++++----------------
 drivers/acpi/button.c          | 10 +++---
 drivers/acpi/cppc_acpi.c       | 71 +++++++++++++++++++++---------------------
 drivers/acpi/custom_method.c   |  2 +-
 drivers/acpi/device_pm.c       |  3 ++
 drivers/acpi/device_sysfs.c    | 15 ++++++---
 drivers/acpi/dock.c            |  7 +++--
 15 files changed, 138 insertions(+), 117 deletions(-)

-- 
2.8.1

