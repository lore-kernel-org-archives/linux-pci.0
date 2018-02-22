Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751283AbeBVXpa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Feb 2018 18:45:30 -0500
Date: Thu, 22 Feb 2018 17:45:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frederick Lawler <fred@fredlawl.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/1] PCI: Replace pci_find_ext_capability() calls with
 pci_dev aer_cap
Message-ID: <20180222234503.GE14632@bhelgaas-glaptop.roam.corp.google.com>
References: <1517453625-13110-1-git-send-email-fred@fredlawl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1517453625-13110-1-git-send-email-fred@fredlawl.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 31, 2018 at 08:53:44PM -0600, Frederick Lawler wrote:
> Hello,
> 
> I replaced certain pci_find_ext_capability(..., PCI_EXT_CAP_ID_ERR) calls
> with pci_dev's aer_cap.
> 
> Since I do not have a computer with a PCIe device with the Advanced Error
> Reporting capability, these changes have not been tested with
> CONFIG_PCIEAER=y set on a machine that has a capable device.
> 
> V2:
> * Reset program_hpp_type2() in probe.c back to its original state
> 
> Frederick Lawler (1):
>   PCI: Replace pci_find_ext_capability() calls with pci_dev aer_cap
> 
>  drivers/pci/pcie/aer/aer_inject.c |  4 ++--
>  drivers/pci/pcie/aer/ecrc.c       |  4 ++--
>  drivers/pci/pcie/portdrv_core.c   | 15 +++++++++++----
>  3 files changed, 15 insertions(+), 8 deletions(-)

Applied to pci/aer for v4.17, thanks!
