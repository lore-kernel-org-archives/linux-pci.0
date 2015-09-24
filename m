Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49098 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755563AbbIXQ7X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 24 Sep 2015 12:59:23 -0400
Date: Thu, 24 Sep 2015 11:59:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, marc.zyngier@arm.com,
	tglx@linutronix.de, linux-kernel@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] PCI/MSI: Fix MSI IRQ domains for SR-IOV
Message-ID: <20150924165920.GA3648@localhost>
References: <20150918210648.19363.35694.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150918210648.19363.35694.stgit@gimli.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Joerg]

On Fri, Sep 18, 2015 at 03:08:54PM -0600, Alex Williamson wrote:
> SR-IOV creates a virtual bus where bus->self is NULL.  This results
> in a segfault as VFs are added and we scan for an MSI domain without
> taking that into account.  Detect this and scan up to the parent bus
> until we find a real bridge.
> 
> Fixes: 44aa0c657e3e ("PCI/MSI: Add hooks to populate the msi_domain field")
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Applied to for-linus with changelog below for v4.3, thanks!

    PCI/MSI: Fix MSI IRQ domains for VFs on virtual buses
    
    SR-IOV creates a virtual bus where bus->self is NULL.  When we add VFs and
    scan for an MSI domain, pci_set_bus_msi_domain() dereferences bus->self,
    which causes a kernel NULL pointer dereference oops.
    
    Scan up to the parent bus until we find a real bridge where we can get the
    MSI domain.
    
    [bhelgaas: changelog]
    Fixes: 44aa0c657e3e ("PCI/MSI: Add hooks to populate the msi_domain field")
    Tested-by: Joerg Roedel <joro@8bytes.org>
    Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
    Signed-off-by: Bjorn Helgaas <helgaas@kernel.org>
    Acked-by: Marc Zyngier <marc.zyngier@arm.com>
