Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout3.hostsharing.net ([176.9.242.62]:53473 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932471AbeGCIeu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jul 2018 04:34:50 -0400
Date: Tue, 3 Jul 2018 10:34:47 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 3/3] PCI: Mask and unmask hotplug interrupts during
 reset
Message-ID: <20180703083447.GA2689@wunner.de>
References: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
 <1530571967-19099-4-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1530571967-19099-4-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 02, 2018 at 06:52:47PM -0400, Sinan Kaya wrote:
> If a bridge supports hotplug and observes a PCIe fatal error, the following
> events happen:
> 
> 1. AER driver removes the devices from PCI tree on fatal error
> 2. AER driver brings down the link by issuing a secondary bus reset waits
> for the link to come up.
> 3. Hotplug driver observes a link down interrupt
> 4. Hotplug driver tries to remove the devices waiting for the rescan lock
> but devices are already removed by the AER driver and AER driver is waiting
> for the link to come back up.
> 5. AER driver tries to re-enumerate devices after polling for the link
> state to go up.
> 6. Hotplug driver obtains the lock and tries to remove the devices again.
> 
> If a bridge is a hotplug capable bridge, mask hotplug interrupts before the
> reset and unmask afterwards.

Would it work for you if you just amended the AER driver to skip
removal and re-enumeration of devices if the port is a hotplug bridge?
Just check for is_hotplug_bridge in struct pci_dev.

That would seem like a much simpler solution, given that it is known
that the link will flap on reset, causing the hotplug driver to remove
and re-enumerate devices.  That would also cover cases where hotplug is
handled by a different driver than pciehp, or by the platform firmware.

Thanks,

Lukas
