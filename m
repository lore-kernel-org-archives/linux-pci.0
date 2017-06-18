Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:49160 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753365AbdFROFf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 18 Jun 2017 10:05:35 -0400
Date: Sun, 18 Jun 2017 07:05:30 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-pci@vger.kernel.org
Subject: PCI endpoint API question
Message-ID: <20170618140530.GA22519@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Kishon,

I've been looking at porting some code to the current incarnation
of your PCI endpoint API.  Once thing that I'm missing is a notification
for writes to BARs - is this and intentional omission?  It seems
like the only current option is to poll for changes.
