Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:16215 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752476AbcJYWFf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Oct 2016 18:05:35 -0400
Date: Tue, 25 Oct 2016 18:16:13 -0400
From: Keith Busch <keith.busch@intel.com>
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-pci@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        David Arcari <darcari@redhat.com>,
        Myron Stowe <mstowe@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFE PATCH] pci: Do not enable intx on MSI-capable devices on
 shutdown
Message-ID: <20161025221613.GA32365@localhost.localdomain>
References: <1477052083-13815-1-git-send-email-prarit@redhat.com>
 <20161025180858.GA22422@localhost.localdomain>
 <580FADC6.1020407@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <580FADC6.1020407@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 25, 2016 at 03:08:54PM -0400, Prarit Bhargava wrote:
> When pci_disable_msi() is currently called the result is that device is
> switched back to intx and then the MSI IRQs are free'd.  This patch would
> modify that behavior, and intx would not be reenabled when pci_disable_msix()
> was called during runtime.  With the system_state patch we're only affecting
> shutdown, which is seen as less risky than doing

My proposal isn't really modifying exisiting behavior since if it does,
the currently in place expectations are being violated: if anyone calls
"pci_disable_msi" with actions on the irqs being disabled, they're
already screwed since they will hit the BUG_ON in free_msi_irqs.
