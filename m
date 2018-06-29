Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:41117 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932468AbeF2K1t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Jun 2018 06:27:49 -0400
Received: by mail-qt0-f196.google.com with SMTP id y20-v6so7325581qto.8
        for <linux-pci@vger.kernel.org>; Fri, 29 Jun 2018 03:27:49 -0700 (PDT)
From: Hari Vyas <hari.vyas@broadcom.com>
To: bhelgaas@google.com, benh@kernel.crashing.org
Cc: linux-pci@vger.kernel.org, ray.jui@broadcom.com,
        Hari Vyas <hari.vyas@broadcom.com>
Subject: [PATCH v2 0/3] PCI: Data corruption happening due to race condition
Date: Fri, 29 Jun 2018 15:57:38 +0530
Message-Id: <1530268061-17324-1-git-send-email-hari.vyas@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Changes in v2:
	To avoid race condition while updating is_added and is_busmaster
	bits, is_added is moved to a private flag variable.
	is_added updation is handled in atomic manner also.

Hari Vyas (3):
  PCI: Data corruption happening due to race condition
  PCI: use new pci function to get device addition state
  PCI: Hotplug: use new pci function to get device addition state

 arch/powerpc/kernel/pci-common.c          |  4 +++-
 arch/powerpc/platforms/powernv/pci-ioda.c |  3 ++-
 arch/powerpc/platforms/pseries/setup.c    |  3 ++-
 drivers/pci/bus.c                         |  6 +++---
 drivers/pci/hotplug/acpiphp_glue.c        |  2 +-
 drivers/pci/pci.c                         |  1 +
 drivers/pci/pci.h                         | 18 ++++++++++++++++++
 drivers/pci/probe.c                       |  4 ++--
 drivers/pci/remove.c                      |  5 +++--
 include/linux/pci.h                       |  1 -
 10 files changed, 35 insertions(+), 12 deletions(-)

-- 
1.9.1
