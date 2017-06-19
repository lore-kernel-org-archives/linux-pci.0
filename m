Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:40292 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751919AbdFSPGD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jun 2017 11:06:03 -0400
Date: Mon, 19 Jun 2017 08:05:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-pci@vger.kernel.org
Subject: Re: PCI endpoint API question
Message-ID: <20170619150547.GA22227@infradead.org>
References: <20170618140530.GA22519@infradead.org>
 <f7596eb9-cb96-7b82-699a-c8a1f7e85b6e@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f7596eb9-cb96-7b82-699a-c8a1f7e85b6e@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 19, 2017 at 03:20:29PM +0530, Kishon Vijay Abraham I wrote:
> > for writes to BARs - is this and intentional omission?  It seems
> > like the only current option is to poll for changes.
> 
> You mean write to the address that's mapped to BAR in the EP side?
> 
> PCI doesn't allow hosts to interrupt the EP (AFAIK), so we have to poll for any
> writes by the host to EP memory.

At least out on the bus each MMIO access translates to PCIe Memory
Read/Write TLPs, so the EP itself for sure gets a notification.  I don't
really know enough about existing programmable endpoint IP to know
how that could be forwarded to software, though.
