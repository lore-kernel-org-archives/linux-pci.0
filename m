Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout1.hostsharing.net ([83.223.95.100]:49215 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbeG2ODM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 29 Jul 2018 10:03:12 -0400
Date: Sun, 29 Jul 2018 14:32:51 +0200
From: Lukas Wunner <lukas@wunner.de>
To: poza@codeaurora.org
Cc: okaya@codeaurora.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 3/3] PCI: Mask and unmask hotplug interrupts during
 reset
Message-ID: <20180729123251.GB4364@wunner.de>
References: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
 <1530571967-19099-4-git-send-email-okaya@codeaurora.org>
 <20180703083447.GA2689@wunner.de>
 <8b6ce0f415858463d1c0588c29e30415@codeaurora.org>
 <9e871cc3978fbdca12ccf8a91f34ad07@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e871cc3978fbdca12ccf8a91f34ad07@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 03, 2018 at 06:41:33PM +0530, poza@codeaurora.org wrote:
> pciehp_unconfigure_device doing little more than enumeration to quiescence
> the bus.
> 
>		/*
> 		 * Ensure that no new Requests will be generated from
> 		 * the device.
> 		 */
> 		if (presence) {
> 			pci_read_config_word(dev, PCI_COMMAND, &command);
> 			command &= ~(PCI_COMMAND_MASTER | PCI_COMMAND_SERR);
> 			command |= PCI_COMMAND_INTX_DISABLE;
> 			pci_write_config_word(dev, PCI_COMMAND, command);
> 		}

That piece of code is supposed to be executed on safe removal via sysfs
or an Attention Button press:  The card remains in the slot, even though
the slot is brought down.  So the card is quiesced.

However IIUC, on fatal error the link goes down and for pciehp, that's
essentially a surprise removal.  In that case, the above code is not
intended to be executed, rather the devices below the hotplug bridge
are marked disconnected.  See this patch I posted yesterday:
https://www.spinics.net/lists/linux-pci/msg74763.html

Thanks,

Lukas
