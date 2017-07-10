Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34166 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752276AbdGJKyx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Jul 2017 06:54:53 -0400
Date: Mon, 10 Jul 2017 11:56:30 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bharat Kumar Gogada <bharatku@xilinx.com>,
        Ravi Kiran Gummaluri <rgummal@xilinx.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] microblaze/PCI: Remove pcibios_setup_bus_{self/devices}
 dead code
Message-ID: <20170710105630.GA20788@red-moon>
References: <20170620130844.11109-1-lorenzo.pieralisi@arm.com>
 <ba524747-7866-7388-53f2-e1ec34341c78@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ba524747-7866-7388-53f2-e1ec34341c78@xilinx.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Michal,

On Tue, Jun 20, 2017 at 04:32:41PM +0200, Michal Simek wrote:
> Hi,
> 
> On 20.6.2017 15:08, Lorenzo Pieralisi wrote:
> > commit 01cf9d524ff0 ("microblaze/PCI: Support generic Xilinx AXI PCIe Host
> > Bridge IP driver") removed pcibios calls to:
> > 
> > pcibios_setup_bus_self()
> > pcibios_setup_bus_devices()
> > 
> > Given that pcibios_fixup_bus() was the only caller of those functions
> > they have now become dead code (along with the functions they were
> > calling in turn) so they can be removed.
> > 
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Bharat Kumar Gogada <bharatku@xilinx.com>
> > Cc: Ravi Kiran Gummaluri <rgummal@xilinx.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Michal Simek <michal.simek@xilinx.com>
> > ---
> > Bjorn, Michal,
> > 
> > spotted this while reading microblaze code that parses legacy IRQs,
> > I am not familiar with microblaze code but as things stand those
> > pcibios calls are just unused IIUC.
> 
> TBH this code should never go to the tree. I even don't have any pci
> platform I can use for testing.
> I am happy to add this patch via microblaze tree.
> If you want to take it via pci tree here is my
> Acked-by: Michal Simek <michal.simek@xilinx.com>

Either way is fine by me as long as we merge it, I do not see it
in the mainline please let me know how you prefer handling it.

Thanks,
Lorenzo
