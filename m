Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout2.hostsharing.net ([83.223.90.240]:36293 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754784AbeALLD0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Jan 2018 06:03:26 -0500
Date: Fri, 12 Jan 2018 12:03:24 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Michael Jamet <michael.jamet@intel.com>,
        linux-pci@vger.kernel.org
Subject: Re: Regression (sort of): PCI/portdrv: Turn off PCIe services during
 shutdown
Message-ID: <20180112110324.GB10599@wunner.de>
References: <20180112104929.GA10599@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180112104929.GA10599@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 12, 2018 at 11:49:29AM +0100, Lukas Wunner wrote:
> I'm not sure which Thunderbolt controllers fake the ability to send
> CC interrupts but my old Light Ridge is definitely affected and I recall
> seeing logs of newer Cactus Ridge and Falcon Ridge (Thunderbolt 2)
> controllers which also had this issue.  I'm cc'ing Intel folks in the
> hope that they may know the details.  I believe Mika has a MacBookPro13,3
> with Alpine Ridge (Thunderbolt 3) and could verify if that also has
> this issue. These MacBook Pros have two Thunderbolt controllers,
> so if affected, the commit would delay reboot by 16 seconds.

I managed to dig up lspci output for a MacBookPro13,3 and Alpine Ridge
has 1b in the No Command Completed Support field of the Slot Capabilities
register, so no delay is observed at all and these newer machines are not
affected.

Question is, do the older controllers likewise not need a delay?

Lukas
