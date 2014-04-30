Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:51069 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677AbaD3A7k (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Apr 2014 20:59:40 -0400
Received: by mail-ig0-f179.google.com with SMTP id hl10so1122700igb.12
        for <linux-pci@vger.kernel.org>; Tue, 29 Apr 2014 17:59:40 -0700 (PDT)
Subject: [PATCH 0/7] PCI: BAR sizing fixes
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org
Date: Tue, 29 Apr 2014 18:59:38 -0600
Message-ID: <20140430005642.13138.99577.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

These are intended to fix some corner-case BAR sizing issues: cases where
resource_size_t or dma_addr_t is too small to handle a BAR larger than 4GB
or one placed above 4GB.  There's also a message clarification in the
resource sanity check and a subtractive bridge window fix.

Comments welcome.

---

Bjorn Helgaas (7):
      PCI: Fail safely if we can't handle BARs larger than 4GB
      PCI: Reject BAR above 4GB if dma_addr_t is too small
      PCI: Don't convert BAR address to resource if dma_addr_t is too small
      PCI: Don't set BAR to zero if dma_addr_t is too small
      PCI: Don't print anything while decoding is disabled
      resources: Clarify sanity check message
      PCI: Don't add disabled subtractive decode bus resources


 drivers/pci/probe.c |   48 +++++++++++++++++++++++++++++-------------------
 kernel/resource.c   |    7 ++-----
 2 files changed, 31 insertions(+), 24 deletions(-)
