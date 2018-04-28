Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:51700 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750775AbeD1R7c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 28 Apr 2018 13:59:32 -0400
Date: Sat, 28 Apr 2018 10:59:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/9] PCI: Add pci_alloc_intx_irqd() for allocating IRQ
 domain
Message-ID: <20180428175925.GA17528@infradead.org>
References: <1524880102-100856-1-git-send-email-shawn.lin@rock-chips.com>
 <1524880132-100904-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1524880132-100904-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Apr 28, 2018 at 09:48:52AM +0800, Shawn Lin wrote:
> It seems host drivers which allocate IRQ domain for INTx
> and the related code block looks highly similar to each other.
> Add a new helper, pci_alloc_intx_irqd(), to avoid code duplication
> as much as possible.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Maybe add a _host to the name as in pci_host_alloc_intx_irqdomain,
and potentially move it to a different file than irq.c, as that contains
helpers for drivers.
