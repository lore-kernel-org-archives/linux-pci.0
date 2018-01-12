Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:46443 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933917AbeALPMI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Jan 2018 10:12:08 -0500
Date: Fri, 12 Jan 2018 16:12:06 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Michael Jamet <michael.jamet@intel.com>,
        linux-pci@vger.kernel.org
Subject: Re: Regression (sort of): PCI/portdrv: Turn off PCIe services during
 shutdown
Message-ID: <20180112151206.GA18736@wunner.de>
References: <20180112104929.GA10599@wunner.de>
 <ece49947-e75a-baff-9c4a-6f47bd154642@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ece49947-e75a-baff-9c4a-6f47bd154642@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 12, 2018 at 09:26:48AM -0500, Sinan Kaya wrote:
> On 1/12/2018 5:49 AM, Lukas Wunner wrote:
> I wonder if we can separate remove from shutdown and just disable the IRQs
> in shutdown case rather than turning off the slot power etc.

But don't we risk "IRQ xx: nobody cared" splats if we do that?

Not sure if just disabling the IRQ without telling the hotplug port
not to send interrupts is safe.

The issue that Command Complete events are falsely claimed to be
supported needs to be adressed regardless because whenever a
Thunderbolt device is unplugged, the same 2 second delay occurs.
So if you unplug a daisy chain of, say 6 devices, it takes 12
seconds until they're all removed from the system.

By now I've found out that Falcon Ridge (Thunderbolt 2) is not affected,
I'm not yet sure if Redwood Ridge is, but it seems the issue is contrained
to Thunderbolt 1 controllers only, probably an erratum.

Thanks,

Lukas
