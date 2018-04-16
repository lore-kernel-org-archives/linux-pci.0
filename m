Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752609AbeDPDR3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 15 Apr 2018 23:17:29 -0400
Date: Sun, 15 Apr 2018 22:17:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Keith Busch <keith.busch@intel.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Wei Zhang <wzhang@fb.com>, Timur Tabi <timur@codeaurora.org>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v13 6/6] PCI/DPC: Do not do recovery for hotplug enabled
 system
Message-ID: <20180416031726.GB158153@bhelgaas-glaptop.roam.corp.google.com>
References: <20180410210349.GG54986@bhelgaas-glaptop.roam.corp.google.com>
 <13efe2e8-74c8-acb4-ec58-f79b14a1f182@codeaurora.org>
 <20180412140648.GD145698@bhelgaas-glaptop.roam.corp.google.com>
 <ca7e5285-2e88-e130-6402-a271bb92a81e@codeaurora.org>
 <20180412143954.GB4810@localhost.localdomain>
 <20180412150231.GD4810@localhost.localdomain>
 <ea977780-6f90-af5a-442f-575536038307@codeaurora.org>
 <20180412170911.GA6424@localhost.localdomain>
 <fa167b21-f70d-a220-5671-5ad66a0f72c0@codeaurora.org>
 <cced24b5-c0bd-138a-0304-c87cac2ec226@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cced24b5-c0bd-138a-0304-c87cac2ec226@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Apr 14, 2018 at 11:53:17AM -0400, Sinan Kaya wrote:

> You indicated that you want to unify the AER and DPC behavior. Let's
> settle on what we want to do one more time. We have been going forth
> and back on the direction.

My thinking is that as much as possible, similar events should be
handled similarly, whether the mechanism is AER, DPC, EEH, etc.
Ideally, drivers shouldn't have to be aware of which mechanism is in
use.

Error recovery includes conventional PCI as well, but right now I
think we're only concerned with PCIe.  The following error types are
from PCIe r4.0, sec 6.2.2:

  ERR_COR
    Corrected by hardware with no software intervention.  Software
    involved for logging only.

    Handled by AER via pci_error_handlers; DPC is never involved.

    Link is unaffected.

  ERR_NONFATAL
    A transaction is unreliable but the link is fully functional.

    If DPC is not supported, handled by AER via pci_error_handlers and
    the link is unaffected.

    If DPC supported, handled by DPC (because we set
    PCI_EXP_DPC_CTL_EN_NONFATAL) via remove/re-enumerate.

  ERR_FATAL
    The link is unreliable.

    If DPC is not supported, handled by AER via pci_error_handlers and
    the link is reset.

    If DPC supported, handled by DPC via remove/re-enumerate.

It doesn't seem right to me that we handle both ERR_NONFATAL and
ERR_FATAL events differently if we happen to have DPC support in a
switch.

Maybe we should consider triggering DPC only on ERR_FATAL?  That would
keep DPC out of the ERR_NONFATAL cases.

For ERR_FATAL, maybe we should bite the bullet and use
remove/re-enumerate for AER as well as for DPC.  That would be painful
for higher-level software, but if we're willing to accept that pain
for new systems that support DPC, maybe life would be better overall
if it worked the same way on systems without DPC?

Bjorn
