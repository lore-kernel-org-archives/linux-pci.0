Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:35915 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753533AbdBHRSd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Feb 2017 12:18:33 -0500
From: Christoph Hellwig <hch@lst.de>
To: tglx@linutronix.de, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: two small PCI MSI cleanups V2
Date: Wed,  8 Feb 2017 18:17:42 +0100
Message-Id: <20170208171744.17100-1-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now with even more dead code removal thanks to the review from Thomas!
