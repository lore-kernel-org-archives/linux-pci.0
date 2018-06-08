Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752756AbeFHUei (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Jun 2018 16:34:38 -0400
Date: Fri, 8 Jun 2018 15:34:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Oza Pawandeep <poza@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 09/13] PCI/AER: Move aer_irq() declaration to portdrv.h
Message-ID: <20180608203437.GA17897@bhelgaas-glaptop.roam.corp.google.com>
References: <152848785553.11888.12243539903985770441.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152848834128.11888.12263280185471104825.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180608201713.GA24554@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180608201713.GA24554@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 08, 2018 at 02:17:13PM -0600, Keith Busch wrote:
> On Fri, Jun 08, 2018 at 03:05:41PM -0500, Bjorn Helgaas wrote:
> > The aer_irq() declaration is the only thing needed by aer_inject.c.  Move
> > it to portdrv.h so we eventually get rid of aerdrv.h completely.  No
> > functional change intended.
> 
> Nothing against what you're doing here, but it does seem odd that aer_irq
> is required to be exported just for the error injection to directly call
> it. I feel like aer-inject should route it through the irq subsystem,
> like with generic_handle_irq. ?

I totally agree, that's ugly, but I don't have a good idea for how to
fix it yet.

(And I don't want to do anything more than the simplest possible code
moves at this stage, since I think restructuring like this would have
to be done at the end of the merge window to avoid major disruption to
people working on this code.)

Thanks for taking a look over it!

Bjorn
