Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751126AbeD0R6w (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Apr 2018 13:58:52 -0400
Date: Fri, 27 Apr 2018 12:58:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frederick Lawler <fred@fredlawl.com>
Cc: bhelgaas@google.com, mike.marciniszyn@intel.com,
        dennis.dalessandro@intel.com, dledford@redhat.com,
        jgg@mellanox.com, linux-pci@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v3 0/2] IB/hfi1: Cleanup PCIe link configuration
Message-ID: <20180427175850.GC8199@bhelgaas-glaptop.roam.corp.google.com>
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
> 
> V3: 
> 	* PCI: Add PCI_EXP_LNKCTL2_TLS_* macros
> 	* Drop patch to use extract_speed() in do_pcie_gen3_transition()
> V2:
> 	* s/LINK/LNK
> 
> Frederick Lawler (2):
>   PCI: Add PCI_EXP_LNKCTL2_TLS* macros
>   IB/hfi1: Replace custom hfi1 macros with PCIe macros
> 
>  drivers/infiniband/hw/hfi1/pcie.c | 24 ++++++++----------------
>  include/uapi/linux/pci_regs.h     |  5 +++++
>  2 files changed, 13 insertions(+), 16 deletions(-)

I applied these, with Michael's reviewed-by on the second, to
pci/misc for v4.18, thanks!

Ideally we could pull some of this link speed management code into the
PCI core someday, but I think these patches are useful as-is.

Oh, I did s/PCI_EXP_LNKCTL2_TLS_2_5GB/PCI_EXP_LNKCTL2_TLS_2_5GT/
because the link speeds are actually defined in terms of GT/s, not
GB/s.
