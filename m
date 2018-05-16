Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751213AbeEPVES (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 May 2018 17:04:18 -0400
Date: Wed, 16 May 2018 16:04:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Timur Tabi <timur@codeaurora.org>
Cc: Keith Busch <keith.busch@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCHv2 2/7] PCI/DPC: Fix PCI legacy interrupt acknowledgement
Message-ID: <20180516210415.GA19955@bhelgaas-glaptop.roam.corp.google.com>
References: <20180402162203.3370-1-keith.busch@intel.com>
 <20180402162203.3370-3-keith.busch@intel.com>
 <20180403203847.GO9322@bhelgaas-glaptop.roam.corp.google.com>
 <CAOZdJXXQCGUu+r_hWBt+gAvVbYu0h4KxpUXOMKR3p7y92wxq-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOZdJXXQCGUu+r_hWBt+gAvVbYu0h4KxpUXOMKR3p7y92wxq-w@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 16, 2018 at 10:16:15AM -0500, Timur Tabi wrote:
> On Tue, Apr 3, 2018 at 3:38 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > Bottom line, I think this patch is fine and I applied it with the
> > following changelog:
> >
> >   PCI/DPC: Clear interrupt status in interrupt handler top half
> 
> Bjorn,
> 
> I can't find this patch (with either subject line) anywhere on
> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/ or
> linux-next.  I see you pulled in Oza's other patch set, but this patch
> is still MIA.

I blew it, sorry.  I think I was hoping to clarify the question of
using threaded interrupts, but that never happened.

I applied this to pci/dpc for v4.18 and pushed it.

Bjorn
