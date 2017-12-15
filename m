Return-Path: <SRS0=qAcQ=DL=gmail.com=jingoohan1@kernel.org>
Return-Path: <SRS0=qAcQ=DL=gmail.com=jingoohan1@kernel.org>
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Bjorn Helgaas'" <helgaas@kernel.org>,
	"'Joao Pinto'" <Joao.Pinto@synopsys.com>,
	"'Ley Foon Tan'" <lftan@altera.com>,
	"'Shawn Lin'" <shawn.lin@rock-chips.com>,
	"'Michal Simek'" <michal.simek@xilinx.com>
Cc: "'Jim Quinlan'" <jim2101024@gmail.com>,
	"'Lorenzo Pieralisi'" <lorenzo.pieralisi@arm.com>,
	<linux-pci@vger.kernel.org>,
	<rfi@lists.rocketboards.org>,
	<linux-rockchip@lists.infradead.org>
References: <20171214225821.GN30595@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20171214225821.GN30595@bhelgaas-glaptop.roam.corp.google.com>
Subject: Re: Why do we check for "link-up" in *_pcie_valid_device()?
Date: Fri, 15 Dec 2017 13:39:50 -0500
Message-ID: <000f01d375d4$17e9c830$47bd5890$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Thursday, December 14, 2017 5:58 PM, Bjorn Helgaas wrote:
> 
> Hi all,
> 
> In the PCI config access path, the *_pcie_valid_device() functions in
> the dwc, altera, rockchip, and xilinx drivers all check whether the
> link is up.
> 
> I think this is racy because the link may go down after we check but
> before we perform the config access.
> 
> What would blow up if we removed the *_pcie_link_up() checks?

The original intention is to avoid config access before link up.

Also, I did not find any racy condition as you mentioned.
However, if you think that we need to prevent the racy condition,
someone can send a patch or add comments.

Best regards,
Jingoo Han

> 
> I'd like to either remove the checks or add comments about why the
> race is acceptable.  If we've covered this before, I apologize.
> Adding a comment will keep me from pestering you about this again in
> the future.
> 
> Bjorn
