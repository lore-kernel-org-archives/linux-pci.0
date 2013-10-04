Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:11391 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751126Ab3JDXb1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 4 Oct 2013 19:31:27 -0400
From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>
CC: <james.hogan@imgtec.com>, <Qais.Yousef@imgtec.com>,
	Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
Subject: [PATCH v2 0/4] PCI/quirks: PIIX4 ACPI bugfix and cleanups
Date: Fri, 4 Oct 2013 16:30:49 -0700
Message-ID: <1380929453-15428-1-git-send-email-dengcheng.zhu@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Fix the PIIX4 ACPI memory base and size mask, perform cleanups.

CHANGES:
----------
v2 - v1:
o Split renaming, refactoring and macros into 3 patches.
----------

Deng-Cheng Zhu (4):
  PCI/quirks: Fix PIIX4 memory base and size mask
  PCI/quirks: Rename piix4_[io|mem]_quirk to add acpi
  PCI/quirks: Extract the size detection logic of PIIX4 ACPI io and mem
  PCI/quirks: Convert hard-coded values to macros for PIIX4 ACPI quirks

 drivers/pci/quirks.c |  116 ++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 84 insertions(+), 32 deletions(-)


