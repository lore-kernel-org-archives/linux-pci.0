Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:38091 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbdBCQ1K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2017 11:27:10 -0500
From: Christoph Hellwig <hch@lst.de>
To: tglx@linutronix.de, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: two small PCI MSI cleanups
Date: Fri,  3 Feb 2017 17:27:03 +0100
Message-Id: <20170203162705.5182-1-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Remove an entirely dead function, and two small wrappers that are not
useful except for making the callchain in the MSI setup code even harder
to follow.
