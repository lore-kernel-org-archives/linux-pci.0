Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:55362 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751147AbeDQGxr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Apr 2018 02:53:47 -0400
Date: Mon, 16 Apr 2018 23:53:43 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Frederick Lawler <fred@fredlawl.com>
Cc: bhelgaas@google.com, mike.marciniszyn@intel.com,
        dennis.dalessandro@intel.com, dledford@redhat.com,
        jgg@mellanox.com, linux-pci@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v3 0/2] IB/hfi1: Cleanup PCIe link configuration
Message-ID: <20180417065343.GA29193@infradead.org>
References: <20180417002825.2737-1-fred@fredlawl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180417002825.2737-1-fred@fredlawl.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 16, 2018 at 07:28:23PM -0500, Frederick Lawler wrote:
> The IB/hfi1 driver uses custom macros to configure the target link speed. Some 
> macros were previously replaced, but not fully. This patch series addresses the
> configuration inconsistencies by adding PCI_EXP_LNKCTL2_TLS* macros to PCI,
> and then use them in the following IB/hfi1 patch.

Btw, why is the driver configuring the PCIe link speed?  Isn't this
something we should be handling in the PCI core?
