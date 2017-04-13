Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:30912 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755085AbdDMTyA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Apr 2017 15:54:00 -0400
Date: Thu, 13 Apr 2017 16:02:55 -0400
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] nvme/pci: switch to pci_request_irq
Message-ID: <20170413200255.GB22775@localhost.localdomain>
References: <20170413070643.32165-1-hch@lst.de>
 <20170413070643.32165-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170413070643.32165-5-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 13, 2017 at 12:06:43AM -0700, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This is great. As an added bonus, more of struct nvme_queue's hot values
are in the same cache line!

Reviewed-by: Keith Busch <keith.busch@intel.com>
