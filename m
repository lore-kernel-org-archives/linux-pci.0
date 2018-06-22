Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:41258 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751266AbeFVOHA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Jun 2018 10:07:00 -0400
Date: Fri, 22 Jun 2018 08:10:14 -0600
From: Keith Busch <keith.busch@intel.com>
To: poza@codeaurora.org
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH 5/7] PCI/DPC: Print AER status in DPC event handling
Message-ID: <20180622141013.GB27589@localhost.localdomain>
References: <20180620213833.25072-1-keith.busch@intel.com>
 <20180620213833.25072-5-keith.busch@intel.com>
 <9cc1594055f03c0e4b4d1b50384107e8@codeaurora.org>
 <20180621140525.GB26623@localhost.localdomain>
 <f25c5f839166d0f94fc8a1b6def2fe14@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f25c5f839166d0f94fc8a1b6def2fe14@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 22, 2018 at 03:41:50PM +0530, poza@codeaurora.org wrote:
> was thinking that current code
> pcie_do_fatal_recovery already does call
> 
> if ((service == PCIE_PORT_SERVICE_AER) &&
> 	    (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)) {
> 		/*
> 		 * If the error is reported by a bridge, we think this error
> 		 * is related to the downstream link of the bridge, so we
> 		 * do error recovery on all subordinates of the bridge instead
> 		 * of the bridge and clear the error status of the bridge.
> 		 */
> 		pci_cleanup_aer_uncorrect_error_status(dev);
> 	}
> 
> 
> instead of calling it here in dpc driver, can we make use of that existing
> call ?
> probably we just might need to remove
> if ((service == PCIE_PORT_SERVICE_AER) condition

That's really only desirable when DPC error status is 0. It should be
harmless, though, so your update is fine with me.
