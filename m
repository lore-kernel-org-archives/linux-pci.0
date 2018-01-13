Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:52198 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbeAMUtX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 13 Jan 2018 15:49:23 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Sat, 13 Jan 2018 15:49:22 -0500
From: okaya@codeaurora.org
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Michael Jamet <michael.jamet@intel.com>,
        linux-pci@vger.kernel.org
Subject: Re: Regression (sort of): PCI/portdrv: Turn off PCIe services during
 shutdown
In-Reply-To: <20180113193931.GA3585@wunner.de>
References: <20180112104929.GA10599@wunner.de>
 <ece49947-e75a-baff-9c4a-6f47bd154642@codeaurora.org>
 <20180112151206.GA18736@wunner.de>
 <f7c48320-fe01-2c02-8639-269b81b1cc7d@codeaurora.org>
 <20180113073218.GB14854@wunner.de>
 <0134d7603402079fd4f3a7b15406bd26@codeaurora.org>
 <20180113193931.GA3585@wunner.de>
Message-ID: <6c512cea0c089427958b8768e6296bb3@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-01-13 14:39, Lukas Wunner wrote:
> On Sat, Jan 13, 2018 at 12:58:53PM -0500, okaya@codeaurora.org wrote:
>> I waa thinking of using nowait variant of write function in 
>> notification
>> disable function in order to not introduce new behavior for existing
>> silicon.
> 
> After writing to the Slot Control register to turn off IRQ 
> notification,
> we free the IRQ with pciehp_free_irq().  If we don't wait for the 
> command
> to complete, we risk getting an interrupt after the IRQ was freed.
> 

Yeah, that is true.
