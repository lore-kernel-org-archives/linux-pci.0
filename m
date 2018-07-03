Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f172.google.com ([209.85.216.172]:38372 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932388AbeGCJFq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jul 2018 05:05:46 -0400
Received: by mail-qt0-f172.google.com with SMTP id c5-v6so903654qth.5
        for <linux-pci@vger.kernel.org>; Tue, 03 Jul 2018 02:05:46 -0700 (PDT)
From: Hari Vyas <hari.vyas@broadcom.com>
To: bhelgaas@google.com, benh@kernel.crashing.org
Cc: linux-pci@vger.kernel.org, ray.jui@broadcom.com,
        Hari Vyas <hari.vyas@broadcom.com>
Subject: [PATCH v3] PCI: Data corruption happening due to race condition
Date: Tue,  3 Jul 2018 14:35:40 +0530
Message-Id: <1530608741-30664-1-git-send-email-hari.vyas@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Changes in v3:
	As per review comments from Lukas Wunner <lukas@wunner.de>,
	squashed 3 commits to single commit. Without this build breaks.
	Also clubbed set and clear function for is_added bits to a
	single assign function. This optimizes code and reduce LoC.
	Removed one wrongly added blank line in pci.c
	 
Changes in v2:
        To avoid race condition while updating is_added and is_busmaster
        bits, is_added is moved to a private flag variable.
        is_added updation is handled in atomic manner also.

Hari Vyas (1):
  PCI: Data corruption happening due to race condition

 arch/powerpc/kernel/pci-common.c          |  4 +++-
 arch/powerpc/platforms/powernv/pci-ioda.c |  3 ++-
 arch/powerpc/platforms/pseries/setup.c    |  3 ++-
 drivers/pci/bus.c                         |  6 +++---
 drivers/pci/hotplug/acpiphp_glue.c        |  2 +-
 drivers/pci/pci.h                         | 11 +++++++++++
 drivers/pci/probe.c                       |  4 ++--
 drivers/pci/remove.c                      |  5 +++--
 include/linux/pci.h                       |  1 -
 9 files changed, 27 insertions(+), 12 deletions(-)

-- 
1.9.1
