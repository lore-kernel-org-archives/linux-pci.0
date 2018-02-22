Return-Path: <SRS0=iNvw=FQ=rjwysocki.net=rjw@kernel.org>
Return-Path: <SRS0=iNvw=FQ=rjwysocki.net=rjw@kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: George Cherian <gcherian@caviumnetworks.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, Jayachandran.Nair@cavium.com, Robert.Richter@cavium.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH] PCI: Add quirk for Cavium Thunder-X2 PCIe erratum #173
Date: Thu, 22 Feb 2018 11:19:12 +0100
Message-ID: <1606177.uAVMQdvpea@aspire.rjw.lan>
In-Reply-To: <20180222083543.GA14945@wunner.de>
References: <1517554846-16703-1-git-send-email-george.cherian@cavium.com> <20180221232040.GA52685@bhelgaas-glaptop.roam.corp.google.com> <20180222083543.GA14945@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Thursday, February 22, 2018 9:35:43 AM CET Lukas Wunner wrote:
> On Wed, Feb 21, 2018 at 05:20:40PM -0600, Bjorn Helgaas wrote:
> > On Wed, Feb 21, 2018 at 04:25:08PM +0530, George Cherian wrote:
> > > I have found another configuration where this fails.
> > > Following is the configuration
> > > 1) Connected a PCIe Intel i40 card under the root port.
> > > 2) unbind the i40 driver and bind with vfio-pci driver.
> > > 3) Run lspci in a loop. "lspci -s xx:xx.xx -vvv"
> > > 
> > > I get the same synchronous external abort.
> > > In this case the vfio-pci driver probe it moves the device (i40) to
> > > D3hot provided disable_idle_d3 is not set. lspci tries to do
> > > the config_access which fails with synchronous external abort when
> > > the root port transitions to D3hot.
> > 
> > It *looks* like rpm_resume() should resume parent devices, i.e., the
> > root port, but I don't know that code at all.
> 
> It does that unless the ignore_children flag is set, which only few
> drivers do.

Right.

And the PCIe port driver doesn't do that in particular, so PCIe ports
should be resumed by the resume of devices below them.

Thanks,
Rafael
