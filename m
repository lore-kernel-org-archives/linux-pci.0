Return-Path: <SRS0=9du3=D5=rock-chips.com=shawn.lin@kernel.org>
Return-Path: <SRS0=9du3=D5=rock-chips.com=shawn.lin@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 Ley Foon Tan <lftan@altera.com>, Michal Simek <michal.simek@xilinx.com>,
 shawn.lin@rock-chips.com, Jim Quinlan <jim2101024@gmail.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pci@vger.kernel.org,
 rfi@lists.rocketboards.org
Subject: Re: Why do we check for "link-up" in *_pcie_valid_device()?
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20171214225821.GN30595@bhelgaas-glaptop.roam.corp.google.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <bfb3a1e1-73a7-8b84-b1b6-c4a00d04be47@rock-chips.com>
Date: Tue, 2 Jan 2018 20:24:50 +0800
MIME-Version: 1.0
In-Reply-To: <20171214225821.GN30595@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=gbk; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 2017/12/15 6:58, Bjorn Helgaas wrote:
> Hi all,
> 
> In the PCI config access path, the *_pcie_valid_device() functions in
> the dwc, altera, rockchip, and xilinx drivers all check whether the
> link is up.
> 
> I think this is racy because the link may go down after we check but
> before we perform the config access.
> 

The link could be broken at any time, so the check if bogus. And we
have accessors for performing the config access but we don't have these
for performing memory access, so again the racy is always there.


> What would blow up if we removed the *_pcie_link_up() checks?

What Rockchip needs(probably for all arm64 system) is something
like this patchset[1]. And for arm32, we could refer to
imx6q_pcie_abort_handler in drivers/pci/dwc/pci-imx6.c

Note that ATF(ARM trust firmware) could help capture these
(a)synchronous, so we actually don't even need to resort to patchset[1],
and handle these abort in the firmware.


[1]https://lkml.org/lkml/2017/11/10/236


> 
> I'd like to either remove the checks or add comments about why the

Remove it makes sense to me.

> race is acceptable.  If we've covered this before, I apologize.
> Adding a comment will keep me from pestering you about this again in
> the future.
> 
> Bjorn
> 
> 
> 
