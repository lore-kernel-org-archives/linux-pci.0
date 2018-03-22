Return-Path: <SRS0=N6jm=GM=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=N6jm=GM=arm.com=lorenzo.pieralisi@kernel.org>
Date: Thu, 22 Mar 2018 11:30:00 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 1/6] PCI: rockchip: Create individual folder for
 rockchip drivers
Message-ID: <20180322113000.GA24976@e107981-ln.cambridge.arm.com>
References: <1520304173-231081-1-git-send-email-shawn.lin@rock-chips.com>
 <1520304202-232891-1-git-send-email-shawn.lin@rock-chips.com>
 <20180320174633.GA137590@bhelgaas-glaptop.roam.corp.google.com>
 <879a4862-d0d5-21fd-6c47-029c795fe78e@rock-chips.com>
 <20180321181940.GA9760@e107981-ln.cambridge.arm.com>
 <7275bd77-016a-2729-482d-2855703d9b56@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7275bd77-016a-2729-482d-2855703d9b56@rock-chips.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 22, 2018 at 09:03:58AM +0800, Shawn Lin wrote:

[...]

> How about renaming drivers/pci/host to drivers/pci/controller,
> and then put all pcie-rockchip* files in there, then we don't
> need add seperate directory containning trivial Kconfig, Makefile.

Yes we can do that but not at -rc6 tail end.

> >>Certainly, I could do that beased on your suggestion, but I would like
> >>to know if this's the final agreement both you and Lorenzo reached. :)
> >
> >Or we can add all EP drivers into drivers/pci/endpoint but then the problem
> >is how to share code between host and endpoint directories and it starts
> >feeling like we are going round in circles.
> 
> I would prefer to rename it to endpoint-framwrok or whatever to clearly
> states it is for framework but not the drivers. All the drivers
> whichever for host or endpoint should be in controller directory.
> 
> >
> >I can merge this series as-is as long as we will rework the directory
> >structure according to this discussion (given that's already late -rc6
> >so directory moves/renames can be disrupting - if feasible at all).
> 
> This sounds super great to me to make this series into -next for some
> days before hitting into v4.17. Then we could simultaneously head up to
> see how we could move forward with this.

Send a last version asap and I will try to merge it for this cycle,
keeping in mind that what we discussed above must be implemented as
soon as a new cycle starts.

Thanks,
Lorenzo
