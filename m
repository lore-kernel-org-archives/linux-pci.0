Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-dm3nam03on0074.outbound.protection.outlook.com ([104.47.41.74]:21728
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751974AbdFTOcx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Jun 2017 10:32:53 -0400
Subject: Re: [PATCH] microblaze/PCI: Remove pcibios_setup_bus_{self/devices}
 dead code
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>,
        Bharat Kumar Gogada <bharatku@xilinx.com>,
        Ravi Kiran Gummaluri <rgummal@xilinx.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>
References: <20170620130844.11109-1-lorenzo.pieralisi@arm.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <ba524747-7866-7388-53f2-e1ec34341c78@xilinx.com>
Date: Tue, 20 Jun 2017 16:32:41 +0200
MIME-Version: 1.0
In-Reply-To: <20170620130844.11109-1-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On 20.6.2017 15:08, Lorenzo Pieralisi wrote:
> commit 01cf9d524ff0 ("microblaze/PCI: Support generic Xilinx AXI PCIe Host
> Bridge IP driver") removed pcibios calls to:
> 
> pcibios_setup_bus_self()
> pcibios_setup_bus_devices()
> 
> Given that pcibios_fixup_bus() was the only caller of those functions
> they have now become dead code (along with the functions they were
> calling in turn) so they can be removed.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bharat Kumar Gogada <bharatku@xilinx.com>
> Cc: Ravi Kiran Gummaluri <rgummal@xilinx.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> ---
> Bjorn, Michal,
> 
> spotted this while reading microblaze code that parses legacy IRQs,
> I am not familiar with microblaze code but as things stand those
> pcibios calls are just unused IIUC.

TBH this code should never go to the tree. I even don't have any pci
platform I can use for testing.
I am happy to add this patch via microblaze tree.
If you want to take it via pci tree here is my
Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
