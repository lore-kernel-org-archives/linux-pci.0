Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:34549 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754760AbbGUPrt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jul 2015 11:47:49 -0400
Received: by igvi1 with SMTP id i1so106114614igv.1
        for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2015 08:47:48 -0700 (PDT)
Date: Tue, 21 Jul 2015 10:47:44 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Alexander Duyck <alexander.h.duyck@redhat.com>
Cc: linux-pci@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>,
	Allen Kay <allen.m.kay@intel.com>,
	Chris Wright <chris@sous-sol.org>
Subject: Re: [PATCH] pcie: Restore ACS configuration as part of
 pci_restore_state
Message-ID: <20150721154744.GB21967@google.com>
References: <20150707192434.8444.74316.stgit@ahduyck-server>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150707192434.8444.74316.stgit@ahduyck-server>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 07, 2015 at 12:24:35PM -0700, Alexander Duyck wrote:
> This change is meant to address the fact that ACS state was not being
> restored as a part of the PCI configuration restoration following a PCIe
> reset.  Without this patch it is not possible to reassign interfaces behind
> ACS enabled switches following a system suspend as all of the ACS
> functionality is disabled due to the D0->D3->D0 state transition cycle
> clearing the configuration state and the fact that the ACS logic was only
> initialized in probe.
> 
> Cc: Allen Kay <allen.m.kay@intel.com>
> Cc: Chris Wright <chris@sous-sol.org>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@redhat.com>

Applied to pci/virtualization for v4.3 with changelog as follows, thanks!

commit ccbc175aad819e1d4b6af6246b12d55b13d97815
Author: Alexander Duyck <alexander.h.duyck@redhat.com>
Date:   Tue Jul 7 12:24:35 2015 -0700

    PCI: Restore ACS configuration as part of pci_restore_state()
    
    Previously we did not restore ACS state after a PCIe reset.  This meant
    that we could not reassign interfaces after a system suspend because the
    D0->D3 transition disabled ACS, and we didn't restore it when going back to
    D0.
    
    Restore ACS configuration in pci_restore_state().
    
    [bhelgaas: changelog]
    Signed-off-by: Alexander Duyck <alexander.h.duyck@redhat.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    CC: Allen Kay <allen.m.kay@intel.com>
    CC: Chris Wright <chris@sous-sol.org>
    CC: Alex Williamson <alex.williamson@redhat.com>

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 0008c95..9bd9526f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1092,6 +1092,9 @@ void pci_restore_state(struct pci_dev *dev)
 
 	pci_restore_pcix_state(dev);
 	pci_restore_msi_state(dev);
+
+	/* Restore ACS and IOV configuration state */
+	pci_enable_acs(dev);
 	pci_restore_iov_state(dev);
 
 	dev->state_saved = false;
