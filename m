Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38630 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751459AbdLNJ5b (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Dec 2017 04:57:31 -0500
Date: Thu, 14 Dec 2017 09:57:24 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: thierry.reding@gmail.com, bhelgaas@google.com,
        jonathanh@nvidia.com, vidyas@nvidia.com, mperttunen@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        kthota@nvidia.com
Subject: Re: [PATCH V3 01/12] PCI: tegra: Start LTSSM after programming root
 port
Message-ID: <20171214095724.GA697@e107981-ln.cambridge.arm.com>
References: <1509371843-22931-1-git-send-email-mmaddireddy@nvidia.com>
 <1509371843-22931-2-git-send-email-mmaddireddy@nvidia.com>
 <20171212113248.GA30799@e107981-ln.cambridge.arm.com>
 <7d3396dc-b133-5645-24da-a20fd9db6286@nvidia.com>
 <20171213140848.GA1736@red-moon>
 <b72dda91-5307-f024-9810-d6abadf7f337@nvidia.com>
 <20171213183417.GD4060@red-moon>
 <a9bc0f46-69e1-d7ca-8cd3-e54259c4a92d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a9bc0f46-69e1-d7ca-8cd3-e54259c4a92d@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 14, 2017 at 12:57:28AM +0530, Manikanta Maddireddy wrote:
> 
> 
> On 14-Dec-17 12:04 AM, Lorenzo Pieralisi wrote:
> > On Wed, Dec 13, 2017 at 10:02:02PM +0530, Manikanta Maddireddy wrote:
> >>
> >>
> >> On 13-Dec-17 7:38 PM, Lorenzo Pieralisi wrote:
> >>> On Wed, Dec 13, 2017 at 05:20:39PM +0530, Manikanta Maddireddy wrote:
> >>>>
> >>>>
> >>>> On 12-Dec-17 5:02 PM, Lorenzo Pieralisi wrote:
> >>>>> On Mon, Oct 30, 2017 at 07:27:12PM +0530, Manikanta Maddireddy wrote:
> >>>>>> This patch ensures that LTSSM is started (by deasserting pcie_xrst) only
> >>>>>> after all the required root port register programming is completed.
> >>>>>>
> >>>>>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> >>>>>> ---
> >>>>>> V3:
> >>>>>> * no change in this patch
> >>>>>> V2:
> >>>>>> * no change in this patch
> >>>>>>
> >>>>>>  drivers/pci/host/pci-tegra.c | 9 +++++----
> >>>>>>  1 file changed, 5 insertions(+), 4 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> >>>>>> index 96e8038c3019..b41c60c7414c 100644
> >>>>>> --- a/drivers/pci/host/pci-tegra.c
> >>>>>> +++ b/drivers/pci/host/pci-tegra.c
> >>>>>> @@ -1024,9 +1024,6 @@ static int tegra_pcie_enable_controller(struct tegra_pcie *pcie)
> >>>>>>  		}
> >>>>>>  	}
> >>>>>>  
> >>>>>> -	/* take the PCIe interface module out of reset */
> >>>>>> -	reset_control_deassert(pcie->pcie_xrst);
> >>>>>> -
> >>>>>>  	/* finally enable PCIe */
> >>>>>>  	value = afi_readl(pcie, AFI_CONFIGURATION);
> >>>>>>  	value |= AFI_CONFIGURATION_EN_FPCI;
> >>>>>> @@ -1065,7 +1062,6 @@ static void tegra_pcie_power_off(struct tegra_pcie *pcie)
> >>>>>>  			dev_err(dev, "failed to power off PHY(s): %d\n", err);
> >>>>>>  	}
> >>>>>>  
> >>>>>> -	reset_control_assert(pcie->pcie_xrst);
> >>>>>
> >>>>> This does not look like it is part of the reset de-assertion code move.
> >>>>>
> >>>>> tegra_pcie_enable_controller() -> tegra_pcie_enable_ports()
> >>>>>
> >>>>> in other words, why are you removing it ?
> >>>>>
> >>>>> Lorenzo
> >>>>
> >>>> Hi Lorenzo,
> >>>>
> >>>> Host driver should start LTSSM after programming all controller registers.
> >>>> In tegra_pcie_enable_controller() bunch of AFI module programming is done and
> >>>> I am adding PCIe register programming in this series.
> >>>> So I moved deasserting of pcie_xrst(which starts LTSSM) to tegra_pcie_enable_ports(),
> >>>> which is right after sending RST pulse(tegra_pcie_port_reset()) to endpoint.
> >>>
> >>> I asked why you removed the reset assertion in tegra_pcie_power_off(),
> >>> it is not clear to me. You still call tegra_pcie_power_off() in
> >>> the tegra_pcie_probe() error path and I see no reason why the reset
> >>> assertion - called through:
> >>>
> >>> tegra_pcie_put_resources()
> >>> 	-> tegra_pcie_power_of()
> >>> 	
> >>> is removed, if it was needed previously.
> >>>
> >>> Lorenzo
> >>>
> >>
> >> New sequence with this patch will be
> >> tegra_pcie_enable_controller() -> tegra_pcie_request_resources() -> tegra_pcie_enable_ports()
> >>                                    ->goto put_resources on fail        -> reset_control_deassert(pcie->pcie_xrst);
> >>
> >> Since pcie_xrst deassert happens after tegra_pcie_request_resources(), there is no need to assert pcie_xrst on put_resource failure.
> > 
> > I do not understand you, sorry for being blunt.
> > 
> > What has tegra_pcie_request_resources() to do with the reset
> > assertion/deassertion ?
> > 
> > This patch moves:
> > 
> > reset_control_deassert(pcie->pcie_xrst);
> > 
> > from:
> > 
> > tegra_pcie_enable_controller()
> > 
> > to
> > 
> > tegra_pcie_enable_ports()
> > 
> > if:
> > 
> > reset_control_assert(pcie->pcie_xrst);
> > 
> > was needed before this patch in tegra_pcie_power_off()
> > 
> > why it is not needed there after this patch is applied ?
> > 
> > Lorenzo
> > 
> Opposite of tegra_pcie_enable_ports() is missing on disable_msi
> failure in current driver. So I took care of assert pcie_xrst
> in https://patchwork.ozlabs.org/patch/846043/ along with other
> resources.

Which is in another series. This patch has to be self-contained with a
single logical change that is applicable on its own. Even if we end up
merging the series above every patch has to make sense on its own. This
does not.

So I would start with re-posting this series as a self contained one,
addressing all review comments; we will get to other series later when
this is sorted.

Thanks,
Lorenzo
