Return-Path: <SRS0=TzPi=FY=linaro.org=shawn.guo@kernel.org>
Return-Path: <SRS0=TzPi=FY=linaro.org=shawn.guo@kernel.org>
Date: Fri, 2 Mar 2018 08:43:04 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Jianguo Sun <sunjianguo1@huawei.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	Jiancheng Xue <xuejiancheng@hisilicon.com>
Subject: Re: [PATCH v2 0/2] Add power control for pcie-histb driver
Message-ID: <20180302004301.GB28619@dragon>
References: <1516722337-1533-1-git-send-email-shawn.guo@linaro.org>
 <20180301012241.GA28619@dragon>
 <20180301150822.GA13722@bhelgaas-glaptop.roam.corp.google.com>
 <20180301181119.GA5674@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180301181119.GA5674@e107981-ln.cambridge.arm.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 01, 2018 at 06:11:19PM +0000, Lorenzo Pieralisi wrote:
> On Thu, Mar 01, 2018 at 09:08:22AM -0600, Bjorn Helgaas wrote:
> > [+cc Lorenzo]
> > 
> > On Thu, Mar 01, 2018 at 09:22:46AM +0800, Shawn Guo wrote:
> > > On Tue, Jan 23, 2018 at 11:45:35PM +0800, Shawn Guo wrote:
> > > > The first patch is a small fix which is useful for the second one.
> > > > This version basically follows Fabio's suggestion to reimplement the
> > > > first version patch, using a regulator that can be backed by GPIO to
> > > > control the power to PCIe port.
> > > > 
> > > > Shawn Guo (2):
> > > >   PCI: histb: fix error path of histb_pcie_host_enable()
> > > >   PCI: histb: add an optional regulator for PCIe port power control
> > > > 
> > > >  .../bindings/pci/hisilicon-histb-pcie.txt          |  1 +
> > > >  drivers/pci/dwc/pcie-histb.c                       | 28 ++++++++++++++++++----
> > > >  2 files changed, 25 insertions(+), 4 deletions(-)
> > > 
> > > Hi Bjorn,
> > > 
> > > Did you get a chance to look at the series?
> > 
> > I cc'd Lorenzo, who is now taking care of this area.
> > 
> > If/when you repost this, please incorporate Rob's ack and capitalize
> > the first word of your summary ("Fix", "Add") to match the drivers/pci
> > convention.
> > 
> > Also, the original post used "PCI: hisi:", but here you use
> > "PCI: histb:".  It probably does make sense to distinguish
> > "hisi" from "histb", but I want it to be a conscious choice
> > so future patches can be consistent with it.
> 
> I suspect that using histb makes more sense but I will wait Shawn's
> feedback on this,

Yes, we want to distinguish the driver pcie-histb.c from pcie-hisi.c,
and will consistently use "PCI: histb:" for this driver.

> this series was on my radar anyway but thanks
> for the flag up.

Cool.  I will keep you posted on v3.

Thanks, Bjorn, Lorenzo.

Shawn
