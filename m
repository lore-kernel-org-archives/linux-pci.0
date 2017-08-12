Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:42335 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbdHLH4R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Aug 2017 03:56:17 -0400
Date: Sat, 12 Aug 2017 00:56:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Christoph Hellwig <hch@infradead.org>, linux-scsi@vger.kernel.org,
        bhumirks@gmail.com, kernel-janitors@vger.kernel.org,
        MPT-FusionLinux.pdl@broadcom.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/6] constify pci_error_handlers structures
Message-ID: <20170812075616.GA14976@infradead.org>
References: <1502516674-8918-1-git-send-email-Julia.Lawall@lip6.fr>
 <20170812074451.GA3589@infradead.org>
 <alpine.DEB.2.20.1708120946590.2001@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.20.1708120946590.2001@hadrien>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Aug 12, 2017 at 09:52:28AM +0200, Julia Lawall wrote:
> OK, sure.  So to be precise, you want the fields error_detected,
> mmio_enabled, etc to be added as new fields to the pci_driver structure?

Yes.

> They both have a resume field, though.  What should the pci_error_handlers
> resume function be renamed to?  Would resume_after_error be too much?

error_resume maybe?

FYI, I already killed it for the PCIe port drivers a while ago:

https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/aer&id=c5dc3c69f17a7e77359f10c342d1816390bc8846
