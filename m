Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752798AbcJJRRg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Oct 2016 13:17:36 -0400
Date: Mon, 10 Oct 2016 12:17:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/8] PCI: armada: Name private struct pointer "armada8k"
 consistently
Message-ID: <20161010171731.GB12748@localhost>
References: <20161007163118.24582.12385.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20161007221717.72f45013@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161007221717.72f45013@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 07, 2016 at 10:17:17PM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> On Fri, 07 Oct 2016 11:31:18 -0500, Bjorn Helgaas wrote:
> > Use a device-specific name, "armada8k", for struct armada8k_pcie pointers
> > to hint that this is device-specific information.  No functional change
> > intended.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  drivers/pci/host/pcie-armada8k.c |   37 ++++++++++++++++++-------------------
> >  1 file changed, 18 insertions(+), 19 deletions(-)
> 
> For the entire series:
> 
> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> 
> However, I don't have access to HW right now to test. I can give some
> testing when I get back to the office.

I made tweaks similar to the aardvark ones to this branch.
