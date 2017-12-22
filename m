Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756079AbdLVR2S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Dec 2017 12:28:18 -0500
Date: Fri, 22 Dec 2017 11:28:15 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bharat Kumar Gogada <bharatku@xilinx.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
        "joao.pinto@synopsys.com" <joao.pinto@synopsys.com>,
        Ley Foon Tan <lftan@altera.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "rfi@lists.rocketboards.org" <rfi@lists.rocketboards.org>,
        "linux-rockchip@lists.infradead.org"
        <linux-rockchip@lists.infradead.org>
Subject: Re: Why do we check for "link-up" in *_pcie_valid_device()?
Message-ID: <20171222172815.GA55396@bhelgaas-glaptop.roam.corp.google.com>
References: <20171214225821.GN30595@bhelgaas-glaptop.roam.corp.google.com>
 <BLUPR0201MB1505F95E1BE417834E847EE6A5020@BLUPR0201MB1505.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BLUPR0201MB1505F95E1BE417834E847EE6A5020@BLUPR0201MB1505.namprd02.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 22, 2017 at 01:02:28PM +0000, Bharat Kumar Gogada wrote:
> Bjorn wrote:
>> In the PCI config access path, the *_pcie_valid_device() functions
>> in the dwc, altera, rockchip, and xilinx drivers all check whether
>> the link is up.
>> 
>> I think this is racy because the link may go down after we check but
>> before we perform the config access.
>> 
>> What would blow up if we removed the *_pcie_link_up() checks?
>> 
>> I'd like to either remove the checks or add comments about why the
>> race is acceptable.  If we've covered this before, I apologize.
>> Adding a comment will keep me from pestering you about this again in
>> the future.

> In both Xilinx driver cases when link is down, hardware responds by
> AXI DECERR/SLVERR status which causes an exception, synchronous
> external abort to CPU.  This causes system to hang, so we need this
> check for both of our drivers.  We will add comments. 

This is a problem, and checking whether the link is up is a workaround
but not a real solution.  That means your system may hang if the link
happens to go down at the wrong time.

A real solution would be to handle the synchronous external abort
so it doesn't cause a system hang.

Bjorn
