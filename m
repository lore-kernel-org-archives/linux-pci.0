Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Burton <paul.burton@imgtec.com>
Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	Michal Simek <michals@xilinx.com>,
	"lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
	"yinghai@kernel.org" <yinghai@kernel.org>,
	"wangyijing@huawei.com" <wangyijing@huawei.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"russell.joyce@york.ac.uk" <russell.joyce@york.ac.uk>,
	Soren Brinkmann <sorenb@xilinx.com>,
	"jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>,
	"pawel.moll@arm.com" <pawel.moll@arm.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"galak@codeaurora.org" <galak@codeaurora.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: Re: [PATCH V3 3/5] PCI: xilinx: Modifying AXI PCIe Host Bridge driver to work on both  Zynq and Microblaze
Date: Wed, 10 Feb 2016 21:40:11 +0100
Message-ID: <2818168.2fmZIs86hN@wuerfel>
In-Reply-To: <20160210172707.GA29590@NP-P-BURTON>
References: <1455014518-8708-1-git-send-email-bharatku@xilinx.com> <8520D5D51A55D047800579B09414719825881780@XAP-PVEXMBX01.xlnx.xilinx.com> <20160210172707.GA29590@NP-P-BURTON>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 10 February 2016 09:27:07 Paul Burton wrote:
> On Wed, Feb 10, 2016 at 05:55:51AM +0000, Bharat Kumar Gogada wrote:
> > > On Tue, Feb 09, 2016 at 04:11:56PM +0530, Bharat Kumar Gogada wrote:
> > > > Modifying Xilinx AXI PCIe Host Bridge Soft IP driver to work on both
> > > > Zynq and Microblaze Architectures.
> > > > With these modifications drivers/pci/host/pcie-xilinx.c, will work on
> > > > both Zynq and Microblaze Architectures.
> > > >
> > > > Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> > > > Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>
> > > > ---
> > > > Changes:
> > > > Removed unneccessary architecture dependent number of MSI's.
> > > > Added #ifdef to pci_fixup_irqs which is ARM specific API.
> > > 
> > > Hi Bharat,
> > > 
> > > Why do you say pci_fixup_irqs is ARM-specific? It's declared in
> > > include/linux/pci.h, defined in drivers/pci/setup-irq.c & used by multiple
> > > architectures (alpha, arm, m68k, mips, sh, sparc, tile,
> > > unicore32 from a quick grep).
> > > 
> > > Will you not break INTX-style interrupts by removing this?
> > > 
> > I meant to say ARM specific w.r.t Microblaze architecture, which is
> > what this patch series are for. This has been already discussed in my
> > previous patch by  Arnd Bergmann and Lorenzo Pieralisi .
> > (https://lkml.org/lkml/2016/1/12/707)
> 
> Hi Bharat,
> 
> Ok, so you don't need it for microblaze but do need it for zynq/ARM. We
> also need it for MIPS, where my recent patches enable this driver. So if
> #ifdef'ing this is the current way forwards could you please invert the
> condition to #ifndef CONFIG_MICROBLAZE?

I think we are getting to the point where we should try much harder
to make sure nobody needs that hack and it all works out of the box.

	Arnd
