Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35985 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbbLKCaW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Dec 2015 21:30:22 -0500
Received: by pfbu66 with SMTP id u66so13989778pfb.3
        for <linux-pci@vger.kernel.org>; Thu, 10 Dec 2015 18:30:22 -0800 (PST)
From: Simon Horman <simon.horman@netronome.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Simon Horman <simon.horman@netronome.com>
Subject: [PATCH 0/2] PCI: Limit config space size for Netronome NFP4000
Date: Fri, 11 Dec 2015 11:30:10 +0900
Message-Id: <1449801012-10432-1-git-send-email-simon.horman@netronome.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Like the NFP6000 the NFP4000 as an erratum where reading/writing to PCI
config space addresses above 0x600 can cause the NFP to generate PCIe
completion timeouts.

This short series extends usage quirk_nfp6000, which handles the above
problem by limiting config space size to 0x600 bytes, to the NFP4000.

Compile tested on top of the pci/misc branch.

Simon Horman (2):
  PCI: Add Netronome NFP4000 device ID
  PCI: Limit config space size for Netronome NFP4000

 drivers/pci/quirks.c    | 1 +
 include/linux/pci_ids.h | 1 +
 2 files changed, 2 insertions(+)

-- 
2.1.4

