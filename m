Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:7384 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750744AbdHLHwa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Aug 2017 03:52:30 -0400
Date: Sat, 12 Aug 2017 09:52:28 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Christoph Hellwig <hch@infradead.org>
cc: linux-scsi@vger.kernel.org, bhumirks@gmail.com,
        kernel-janitors@vger.kernel.org, MPT-FusionLinux.pdl@broadcom.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/6] constify pci_error_handlers structures
In-Reply-To: <20170812074451.GA3589@infradead.org>
Message-ID: <alpine.DEB.2.20.1708120946590.2001@hadrien>
References: <1502516674-8918-1-git-send-email-Julia.Lawall@lip6.fr> <20170812074451.GA3589@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Sat, 12 Aug 2017, Christoph Hellwig wrote:

> On Sat, Aug 12, 2017 at 07:44:28AM +0200, Julia Lawall wrote:
> > These pci_error_handlers structures are only stored in the err_handler
> > field of a pci_driver structure, and this field is declared as const.  Thus
> > the pci_error_handlers structures can be const too.
> >
> > Done with the help of Coccinelle.
>
> If you're doing a scripted conversion of the pci_error_handlers
> structured I'd much rather see that structure killed off and folded
> into the pci_driver one.

OK, sure.  So to be precise, you want the fields error_detected,
mmio_enabled, etc to be added as new fields to the pci_driver structure?

They both have a resume field, though.  What should the pci_error_handlers
resume function be renamed to?  Would resume_after_error be too much?

julia
