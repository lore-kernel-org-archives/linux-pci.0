Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751588AbdHPQV3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Aug 2017 12:21:29 -0400
Date: Wed, 16 Aug 2017 11:21:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: linux-pci@vger.kernel.org, gabriele.paoloni@huawei.com,
        charles.chenxin@huawei.com, linuxarm@huawei.com,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH V2] PCI/DPC: Add eDPC support
Message-ID: <20170816162127.GA28977@bhelgaas-glaptop.roam.corp.google.com>
References: <1500716399-85612-1-git-send-email-liudongdong3@huawei.com>
 <20170814201649.GC32525@bhelgaas-glaptop.roam.corp.google.com>
 <c55dc155-f17b-3598-b962-f32c1c909a7b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <c55dc155-f17b-3598-b962-f32c1c909a7b@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 16, 2017 at 03:22:58PM +0800, Dongdong Liu wrote:
> 在 2017/8/15 4:16, Bjorn Helgaas 写道:

> >The existing code (before this patch) sometimes uses &pdev->dev and
> >sometimes &dpc->dev->device.  I'm not sure why the difference and I
> >wish they were all consistent.
> 
> I investigate current port service drivers.
> AER and PME driver xxx_probe() use &dev->port->dev (&pdev->dev)
> But DPC and HP xxx_probe() use &dev->device (&dpc->dev->device)
> So should we need to modify them to keep consistent?
> It is better to write a seperate patch if need.

My first complaint is that even within DPC we aren't consistent.  We
should fix that first.  And yes, this should be a separate patch.  

It'd be nice if AER/PME/DPC/HP were also all consistent, but we can
defer that.

> >Is there value in defining the struct dpc_rp_pio_regs, reading all the
> >info into it with one function, then having a second function to print
> >the info?
> Yes, that is the function do.
> 
> >It seems like you could have a single function that prints the info as
> >it reads it, without having to define a new struct.
> 
> It seems to have too many lines if having a single function,
> and struct dpc_rp_pio_regs rp_pio_regs is a stack local variable.
> So I think current code is ok.

OK.

Bjorn
