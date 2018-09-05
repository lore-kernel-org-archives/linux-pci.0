Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34428 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727462AbeIEIlR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Sep 2018 04:41:17 -0400
Date: Tue, 4 Sep 2018 22:13:02 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Sinan Kaya <okaya@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: RFC on PCI Device Lock
Message-ID: <20180904221302.3031f952@t450s.home>
In-Reply-To: <7087eeca-e004-1b15-0ea6-103722399fd0@kernel.org>
References: <87682473-6ffe-f7df-e8f8-3d00e8247621@kernel.org>
        <20180904165202.4e5bb59d@t450s.home>
        <17720f56-2caa-2d2e-b655-867debf55934@kernel.org>
        <20180904204649.415491f8@t450s.home>
        <571b8341-f6fd-d92a-7091-f4fb02a2aadf@kernel.org>
        <7087eeca-e004-1b15-0ea6-103722399fd0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 4 Sep 2018 20:41:20 -0700
Sinan Kaya <okaya@kernel.org> wrote:

> On 9/4/2018 8:09 PM, Sinan Kaya wrote:
> > On 9/4/2018 7:46 PM, Alex Williamson wrote:  
> >> #define PCI_RESET_DEV_SPECIFIC    (1 << 0)
> >> #define PCI_RESET_FLR        (1 << 1)
> >> #define PCI_RESET_PM        (1 << 2)
> >> #define PCI_RESET_SLOT        (1 << 3)
> >> #define PCI_RESET_BUS        (1 << 4)
> >>
> >> #define PCI_RESET_ANY        (~0)
> >> #define PCI_RESET_FUNC        (PCI_RESET_DEV_SPECIFIC | \
> >>                  PCI_RESET_FLR | PCI_RESET_PM)
> >> #define PCI_RESET_LINK        (PCI_RESET_SLOT | PCI_RESET_BUS)  
> > 
> > I should be able to put something together using __pci_reset_function_locked()
> > shortly.
> > 
> > This is not that difficult to implement.
> >   
> 
> I posted these
> 
> https://bugzilla.kernel.org/attachment.cgi?id=278297
> https://bugzilla.kernel.org/attachment.cgi?id=278299
> 
> Let me know if I misunderstood you. I'll again wait for test feedback first.

Yep, that's essentially it.  I assume we'd want to trickle this through
other interfaces and the hfi1 folks can look at whether they want to
drop their custom config save/restore in favor of using
pci_reset_function_locked(), which would do that for them.
pci_reset_bus() should also allow the caller to set a mask so vfio
doesn't worry about defaults changing in the core.  Thanks,

Alex
