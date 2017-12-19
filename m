Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36306 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935074AbdLSMj5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Dec 2017 07:39:57 -0500
Date: Tue, 19 Dec 2017 12:40:41 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Manikanta Maddireddy <mmaddireddy@nvidia.com>, bhelgaas@google.com,
        jonathanh@nvidia.com, vidyas@nvidia.com, mperttunen@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        kthota@nvidia.com
Subject: Re: [PATCH V3 02/12] PCI: tegra: Move REFCLK pad settings out of
 phy_power_on()
Message-ID: <20171219124041.GC19911@red-moon>
References: <1509371843-22931-1-git-send-email-mmaddireddy@nvidia.com>
 <1509371843-22931-3-git-send-email-mmaddireddy@nvidia.com>
 <20171214151452.GD13733@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171214151452.GD13733@ulmo>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 14, 2017 at 04:14:52PM +0100, Thierry Reding wrote:
> On Mon, Oct 30, 2017 at 07:27:13PM +0530, Manikanta Maddireddy wrote:
> > In Tegra186 PHY programming is done by BPMP-FW, so PHY calls are skipped
> > in driver. REFCLK pad settings are independent of PHY and should be
> > programmed by driver. So move REFCLK pad settings out of phy_power_on().
> > These pad settings improve REFCLK peak to peak amplitude.
> > 
> > Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> > ---
> > V3:
> > * Corrected commit log
> > V2:
> > * no change in this patch
> > 
> >  drivers/pci/host/pci-tegra.c | 20 +++++++++++++-------
> >  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> As far as I can tell, this is a bugfix that can and should be applied
> independently of the rest of the series.
> 
> Acked-by: Thierry Reding <treding@nvidia.com>

Ok, I will apply - I would add a Fixes: tag though.

Is:

Fixes: cf5d31801278 ("PCI: tegra: Program PADS_REFCLK_CFG* always, not
just on legacy SoCs")

the correct commit ?

Thanks,
Lorenzo
