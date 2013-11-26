Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:41961 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752879Ab3KZSik (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Nov 2013 13:38:40 -0500
Received: by mail-ie0-f171.google.com with SMTP id ar20so9969029iec.16
        for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2013 10:38:39 -0800 (PST)
Date: Tue, 26 Nov 2013 11:38:34 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jason Cooper <jason@lakedaemon.net>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: mvebu - The bridge secondary status register should
 be 0
Message-ID: <20131126183834.GA12152@google.com>
References: <1385488975-27694-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <20131126182328.GP2879@titan.lakedaemon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131126182328.GP2879@titan.lakedaemon.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 26, 2013 at 01:23:28PM -0500, Jason Cooper wrote:
> On Tue, Nov 26, 2013 at 11:02:52AM -0700, Jason Gunthorpe wrote:
> > There are no writable bits in the secondary status register, only
> > write 1 to clear bits. The driver never sets any of the write 1 to
> > clear bits so the status register should always be 0, just remove
> > the set from the write path.
> > 
> > Someday the write 1 to clear bits should be copied/cleared directly
> > from registers in the HW.
> > 
> > Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> > ---
> >  drivers/pci/host/pci-mvebu.c | 1 -
> >  1 file changed, 1 deletion(-)
> 
> Whole series
> 
> Acked-by: Jason Cooper <jason@lakedaemon.net>

Thanks, I applied the Interrupt Line/Pin change to for-linus for v3.13, and
the others to pci/host-mvebu for v3.14.

Bjorn
