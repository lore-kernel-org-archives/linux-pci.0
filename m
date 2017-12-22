Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-cys01nam02on0062.outbound.protection.outlook.com ([104.47.37.62]:11136
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751465AbdLVNCc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Dec 2017 08:02:32 -0500
From: Bharat Kumar Gogada <bharatku@xilinx.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        "joao.pinto@synopsys.com" <joao.pinto@synopsys.com>,
        Ley Foon Tan <lftan@altera.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Michal Simek <michal.simek@xilinx.com>
CC: Jim Quinlan <jim2101024@gmail.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "rfi@lists.rocketboards.org" <rfi@lists.rocketboards.org>,
        "linux-rockchip@lists.infradead.org"
        <linux-rockchip@lists.infradead.org>
Subject: RE: Why do we check for "link-up" in *_pcie_valid_device()?
Date: Fri, 22 Dec 2017 13:02:28 +0000
Message-ID: <BLUPR0201MB1505F95E1BE417834E847EE6A5020@BLUPR0201MB1505.namprd02.prod.outlook.com>
References: <20171214225821.GN30595@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20171214225821.GN30595@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,

In the PCI config access path, the *_pcie_valid_device() functions in the d=
wc, altera, rockchip, and xilinx drivers all check whether the link is up.

I think this is racy because the link may go down after we check but before=
 we perform the config access.

What would blow up if we removed the *_pcie_link_up() checks?

I'd like to either remove the checks or add comments about why the race is =
acceptable.  If we've covered this before, I apologize.
Adding a comment will keep me from pestering you about this again in the fu=
ture.

Hi Bjorn,

In both Xilinx driver cases when link is down, hardware responds by AXI DEC=
ERR/SLVERR status which=20
causes an exception, synchronous external abort to CPU.=20
This causes system to hang, so we need this check for both of our drivers.
We will add comments.=20

We have shutdown, Please expect delay in response till 1st Jan, 2018.

Regards,
Bharat
