Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout3.hostsharing.net ([176.9.242.62]:58415 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932219AbeGCN76 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jul 2018 09:59:58 -0400
Date: Tue, 3 Jul 2018 15:59:56 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: poza@codeaurora.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 3/3] PCI: Mask and unmask hotplug interrupts during
 reset
Message-ID: <20180703135956.GA18639@wunner.de>
References: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
 <1530571967-19099-4-git-send-email-okaya@codeaurora.org>
 <20180703083447.GA2689@wunner.de>
 <8b6ce0f415858463d1c0588c29e30415@codeaurora.org>
 <9e871cc3978fbdca12ccf8a91f34ad07@codeaurora.org>
 <2640af5e-f00f-d814-425d-78ac57714f6d@codeaurora.org>
 <bd04c9d1-6dfe-3071-69f9-beb0d649b6c0@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bd04c9d1-6dfe-3071-69f9-beb0d649b6c0@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 03, 2018 at 09:31:24AM -0400, Sinan Kaya wrote:
> Issue is observing hotplug link down event in the middle of AER recovery
> as in my previous reply.
> 
> If we mask hotplug interrupts before secondary bus reset via my patch,
> then hotplug driver will not observe both link up and link down interrupts.
> 
> If we don't mask hotplug interrupts, we have a race condition.

I assume that a bus reset not only causes a link and presence event but
also clears the Presence Detect State bit in the Slot Status register
and the Data Link Layer Link Active bit in the Link Status register
momentarily.

pciehp may access those two bits concurrently to the AER driver
performing a slot reset.  So it may not be sufficient to mask
the interrupt.

I've posted this patch to address the issue:
https://patchwork.ozlabs.org/patch/930391/

Thanks,

Lukas
