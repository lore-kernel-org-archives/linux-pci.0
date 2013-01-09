Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-fa0-f74.google.com ([209.85.161.74]:39836 "EHLO
	mail-fa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932217Ab3AIRww (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Jan 2013 12:52:52 -0500
Received: by mail-fa0-f74.google.com with SMTP id t1so133382fae.1
        for <linux-pci@vger.kernel.org>; Wed, 09 Jan 2013 09:52:51 -0800 (PST)
Subject: [PATCH 0/5] PCI trivial cleanups
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Howells <dhowells@redhat.com>,
	Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
	x86@kernel.org
Date: Wed, 09 Jan 2013 10:52:49 -0700
Message-ID: <20130109175151.13904.84252.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

These are trivial cleanups headed for v3.9.

---

Bjorn Helgaas (5):
      x86/PCI: Remove unused pci_root_bus
      frv/PCI: Remove unused pci_root_bus
      mn10300/PCI: Remove unused pci_root_bus
      PCI: Use "unsigned long" for __pci_enable_device_flags to match ioport.h
      PCI: Drop "__" prefix on __pci_enable_device_flags()


 arch/frv/mb93090-mb00/pci-frv.h         |    1 -
 arch/frv/mb93090-mb00/pci-vdk.c         |    4 +---
 arch/mn10300/unit-asb2305/pci-asb2305.h |    1 -
 arch/mn10300/unit-asb2305/pci.c         |    4 +---
 arch/x86/include/asm/pci_x86.h          |    1 -
 arch/x86/pci/common.c                   |    1 -
 arch/x86/pci/legacy.c                   |    2 +-
 arch/x86/pci/numaq_32.c                 |    2 +-
 drivers/pci/pci.c                       |    9 ++++-----
 9 files changed, 8 insertions(+), 17 deletions(-)
