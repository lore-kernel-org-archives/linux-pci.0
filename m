Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:37218 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754339AbeASXgK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Jan 2018 18:36:10 -0500
Date: Sat, 20 Jan 2018 00:36:06 +0100
From: Ladislav Michl <ladis@linux-mips.org>
To: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/2] Fix double mem region release
Message-ID: <20180119233606.GA18837@lenoch>
References: <20180119180310.GA31540@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180119180310.GA31540@lenoch>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 19, 2018 at 07:03:10PM +0100, Ladislav Michl wrote:
> Two one-liners for the same issue, second bug occurrence is just
> a copy&pasted mistake from 2011...
> 
> Ladislav Michl (2):
>   devres: Fix double mem region release in devm_ioremap_resource()
>   PCI: Fix double mem region release in devm_pci_remap_cfg_resource()

Hmm, that is really shame :-/ My test setup triggered "Trying to free
nonexistent resource" warning, but dissasembly of lib/devres.o shows
no call to devres_destroy, which seems that WARN_ON in
__devm_release_region() is optimized out. Strange. So far sorry
for the noise, I'll try figure out what broke after weekend.

>  drivers/pci/pci.c | 1 -
>  lib/devres.c      | 1 -
>  2 files changed, 2 deletions(-)
> 
> -- 
> 2.15.1
> 
