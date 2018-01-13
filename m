Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout1.hostsharing.net ([83.223.95.100]:59219 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750951AbeAMTjd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 13 Jan 2018 14:39:33 -0500
Date: Sat, 13 Jan 2018 20:39:31 +0100
From: Lukas Wunner <lukas@wunner.de>
To: okaya@codeaurora.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Michael Jamet <michael.jamet@intel.com>,
        linux-pci@vger.kernel.org
Subject: Re: Regression (sort of): PCI/portdrv: Turn off PCIe services during
 shutdown
Message-ID: <20180113193931.GA3585@wunner.de>
References: <20180112104929.GA10599@wunner.de>
 <ece49947-e75a-baff-9c4a-6f47bd154642@codeaurora.org>
 <20180112151206.GA18736@wunner.de>
 <f7c48320-fe01-2c02-8639-269b81b1cc7d@codeaurora.org>
 <20180113073218.GB14854@wunner.de>
 <0134d7603402079fd4f3a7b15406bd26@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0134d7603402079fd4f3a7b15406bd26@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jan 13, 2018 at 12:58:53PM -0500, okaya@codeaurora.org wrote:
> I waa thinking of using nowait variant of write function in notification
> disable function in order to not introduce new behavior for existing
> silicon.

After writing to the Slot Control register to turn off IRQ notification,
we free the IRQ with pciehp_free_irq().  If we don't wait for the command
to complete, we risk getting an interrupt after the IRQ was freed.

Kind regards,

Lukas
