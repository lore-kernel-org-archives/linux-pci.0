Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932393AbcIMU5u (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Sep 2016 16:57:50 -0400
Date: Tue, 13 Sep 2016 15:57:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: keith.busch@intel.com, linux-pci@vger.kernel.org
Subject: Re: [RFCv2 0/3] vmd irq list shortening, map allocation
Message-ID: <20160913205745.GF4138@localhost>
References: <1472838786-3441-1-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1472838786-3441-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 02, 2016 at 11:53:03AM -0600, Jon Derrick wrote:
> V2:
> Added a map for vmd irqs to attempt to allocate all vmd irqs within an
> irq list into a single page. Once we start getting many devices
> sharing the irq in an irq list, this may help the list traversal latency.
> 
> V1:
> Couple of RFC patches here. I don't really notice a positive benefit but
> it does reduce the struct size of vmd_irq_list and hopefully we gain some
> cache benefits from that.
> 
> Both are based on:
> https://patchwork.kernel.org/patch/9304179/
> https://patchwork.kernel.org/patch/9304181/
> 
> Jon Derrick (3):
>   vmd: eliminate vmd_vector member from list type
>   vmd: eliminate index member from irq list
>   pci/vmd: Create irq map for irq nodes
> 
>  arch/x86/pci/vmd.c | 94 ++++++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 73 insertions(+), 21 deletions(-)

These look OK to me, so if Keith acks them I'll merge them.
