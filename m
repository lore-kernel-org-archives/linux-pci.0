Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:42650 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755949AbeASSDk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Jan 2018 13:03:40 -0500
Date: Fri, 19 Jan 2018 19:03:10 +0100
From: Ladislav Michl <ladis@linux-mips.org>
To: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Wolfram Sang <w.sang@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 0/2] Fix double mem region release
Message-ID: <20180119180310.GA31540@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Two one-liners for the same issue, second bug occurrence is just
a copy&pasted mistake from 2011...

Ladislav Michl (2):
  devres: Fix double mem region release in devm_ioremap_resource()
  PCI: Fix double mem region release in devm_pci_remap_cfg_resource()

 drivers/pci/pci.c | 1 -
 lib/devres.c      | 1 -
 2 files changed, 2 deletions(-)

-- 
2.15.1
