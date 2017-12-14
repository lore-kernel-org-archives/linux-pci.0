Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754069AbdLNW60 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Dec 2017 17:58:26 -0500
Date: Thu, 14 Dec 2017 16:58:21 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Ley Foon Tan <lftan@altera.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc: Jim Quinlan <jim2101024@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, rfi@lists.rocketboards.org,
        linux-rockchip@lists.infradead.org
Subject: Why do we check for "link-up" in *_pcie_valid_device()?
Message-ID: <20171214225821.GN30595@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,

In the PCI config access path, the *_pcie_valid_device() functions in
the dwc, altera, rockchip, and xilinx drivers all check whether the
link is up.

I think this is racy because the link may go down after we check but
before we perform the config access.

What would blow up if we removed the *_pcie_link_up() checks?

I'd like to either remove the checks or add comments about why the
race is acceptable.  If we've covered this before, I apologize.
Adding a comment will keep me from pestering you about this again in
the future.

Bjorn
