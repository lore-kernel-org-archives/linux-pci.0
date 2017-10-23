Return-Path: <shawnguo@kernel.org>
Return-Path: <shawnguo@kernel.org>
Date: Mon, 23 Oct 2017 11:04:38 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, Jianguo Sun <sunjianguo1@huawei.com>,
	Rob Herring <robh+dt@kernel.org>,
	Jiancheng Xue <xuejiancheng@hisilicon.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: hisi: add PCIe driver support for HiSilicon STB SoCs
Message-ID: <20171023030437.GH8700@dragon>
References: <1508043971-23216-1-git-send-email-shawnguo@kernel.org>
 <20171020225248.GV6332@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171020225248.GV6332@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Thanks for taking time to look at the patch.

On Fri, Oct 20, 2017 at 05:52:48PM -0500, Bjorn Helgaas wrote:
> On Sun, Oct 15, 2017 at 01:06:11PM +0800, Shawn Guo wrote:
> > From: Jianguo Sun <sunjianguo1@huawei.com>
> > 
> > Add PCIe controller driver for HiSilicon STB SoCs,
> > the controller is based on the DesignWare's PCIe core.
> 
> s/DesignWare's/DesignWare/
> 
> > Signed-off-by: Jianguo Sun <sunjianguo1@huawei.com>
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  .../bindings/pci/hisilicon-histb-pcie.txt          |  66 +++
> >  drivers/pci/dwc/Kconfig                            |  10 +
> >  drivers/pci/dwc/Makefile                           |   1 +
> >  drivers/pci/dwc/pcie-histb.c                       | 469 +++++++++++++++++++++
> >  4 files changed, 546 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt
> >  create mode 100644 drivers/pci/dwc/pcie-histb.c
> 
> Looks beautiful overall!
> 
> This needs a MAINTAINERS update so "./scripts/get_maintainer.pl -f" prints
> something useful.

Okay, I will add a MAINTAINERS entry for this driver.

> A few minor nits below that I would fix myself, but since you need to
> supply the MAINTAINERS update anyway, I'll let you do it :)

Thanks for all the suggestions.  We fixed them all, and the code does
look nicer.

Shawn
