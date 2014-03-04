Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:42526 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757534AbaCDUwq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 4 Mar 2014 15:52:46 -0500
Received: by mail-ie0-f169.google.com with SMTP id to1so97860ieb.0
        for <linux-pci@vger.kernel.org>; Tue, 04 Mar 2014 12:52:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20140226190306.9616.30567.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140226190306.9616.30567.stgit@bhelgaas-glaptop.roam.corp.google.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 4 Mar 2014 13:52:25 -0700
Message-ID: <CAErSpo7LOQevxDdSqiTPVJEVHLGNYSs4bC_g20Ak6ZizTdjtYg@mail.gmail.com>
Subject: Re: [PATCH 0/4] i2o: Use pci_bus_alloc_resource()
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: Markus Lidel <Markus.Lidel@shadowconnect.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 26, 2014 at 12:08 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> i20 currently uses pci_find_parent_resource() followed by
> allocate_resource() to allocate PCI space.  The problem is that this won't
> work reliably because before we allocate the space, we don't know its
> address, and therefore we can't find the parent resource.  Even if we know
> the *type* of space we want, in some cases there are multiple possibilities
> (root buses with multiple apertures to them, prefetchable or
> non-prefetchable apertures, etc.)
>
> This changes it to use pci_bus_alloc_resource(), which takes care of those
> details.
>
> This also fixes some things that look like copy/paste errors, e.g., trying
> to allocate an I/O space with 1MB alignment.
>
> I don't have hardware to test these changes, but I don't think these
> allocation paths actually worked before, this shouldn't be any worse than
> what we have today.
>
> ---
>
> Bjorn Helgaas (4):
>       i2o: Fix I/O space allocation copy/paste error
>       i2o: Fix I/O space alignment requirement
>       i2o: Refactor i2o_iop_systab_set() PCI space allocation
>       i2o: Use pci_bus_alloc_resource(), not allocate_resource() directly
>
>
>  drivers/message/i2o/iop.c |   85 ++++++++++++++++++++++-----------------------
>  1 file changed, 42 insertions(+), 43 deletions(-)

I applied these to pci/resource for v3.15.
