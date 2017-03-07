Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756233AbdCGVKP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Mar 2017 16:10:15 -0500
Date: Tue, 7 Mar 2017 15:08:51 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Madhani, Himanshu" <Himanshu.Madhani@cavium.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] PCI/MSI: Only disable affinity settings if pre and post
 vector count is equal to max_vecs and not min_vecs
Message-ID: <20170307210851.GA638@bhelgaas-glaptop.roam.corp.google.com>
References: <20170301233158.1035-1-himanshu.madhani@cavium.com>
 <20170301234904.GA22814@lst.de>
 <E66CD5F3-B14D-4CD5-AE66-624AC2A18B01@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E66CD5F3-B14D-4CD5-AE66-624AC2A18B01@cavium.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 07, 2017 at 07:00:20PM +0000, Madhani, Himanshu wrote:
> Hi Bjorn, 
> 	
> Can we get this patch included in next branch. This patch has been reviewed by Christoph. 

No worries, it's still in patchwork
(https://patchwork.ozlabs.org/project/linux-pci/list/) so I'll get to it
soon.

> On 3/1/17, 3:49 PM, "Christoph Hellwig" <hch@lst.de> wrote:
> 
>     Looks good,
>     
>     Reviewed-by: Christoph Hellwig <hch@lst.de>
>     
> 
