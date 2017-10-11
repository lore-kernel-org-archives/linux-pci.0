Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752580AbdJKUHL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Oct 2017 16:07:11 -0400
Date: Wed, 11 Oct 2017 15:07:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, seroyer@linux.vnet.ibm.com,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 0/2] Prepartion for SR-IOV PowerVM Enablement
Message-ID: <20171011200709.GS25517@bhelgaas-glaptop.roam.corp.google.com>
References: <20170922141928.49141-1-bryantly@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170922141928.49141-1-bryantly@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 22, 2017 at 09:19:26AM -0500, Bryant G. Ly wrote:
> This patch series is to prepare for enabling SR-IOV
> on pseries. It separates the calls to be machine dependent
> and does not change any current functionality.
> 
> The patch linked below which is currently in review is a dependency:
> https://patchwork.kernel.org/patch/9882915/
> 
> v1 - Initial patch
> v2 - Addressed Bjorn's comment on creating a highly platform
>      dependent global exported symbol.
> v3 - Based patch off linux-ppc/master
> 
> Bryant G. Ly (2):
>   powerpc/kernel: Separate SR-IOV Calls
>   pseries/eeh: Add Pseries pcibios_bus_add_device
> 
>  arch/powerpc/include/asm/machdep.h           |  7 ++++++
>  arch/powerpc/include/asm/pci-bridge.h        |  4 +---
>  arch/powerpc/kernel/eeh_driver.c             |  4 ++--
>  arch/powerpc/kernel/pci-common.c             | 23 +++++++++++++++++++
>  arch/powerpc/kernel/pci_dn.c                 |  6 -----
>  arch/powerpc/platforms/powernv/eeh-powernv.c | 33 ++++++++++++++--------------
>  arch/powerpc/platforms/powernv/pci-ioda.c    |  6 +++--
>  arch/powerpc/platforms/pseries/eeh_pseries.c | 24 ++++++++++++++++++++
>  8 files changed, 78 insertions(+), 29 deletions(-)

I assume this will go via a powerpc tree, since it doesn't touch
anything in drivers/pci or any PCI core interfaces.
