Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753852AbeE3QuR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 May 2018 12:50:17 -0400
Date: Wed, 30 May 2018 11:50:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] MIPS: PCI: Use dev_printk()
Message-ID: <20180530165015.GL39853@bhelgaas-glaptop.roam.corp.google.com>
References: <152699466671.162686.1029992586935534102.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <152699466671.162686.1029992586935534102.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 22, 2018 at 08:11:36AM -0500, Bjorn Helgaas wrote:
> Use dev_printk() to follow style of other arches.
> 
> I'll merge via the PCI tree unless there are objections.
> 
> ---
> 
> Bjorn Helgaas (1):
>       MIPS: PCI: Use dev_printk() when possible
> 
> 
>  arch/mips/pci/pci-legacy.c |    7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Applied with James' ack to pci/misc for v4.18.
