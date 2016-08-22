Return-Path: <Paul.Gortmaker@windriver.com>
Return-Path: <Paul.Gortmaker@windriver.com>
Date: Mon, 22 Aug 2016 18:12:56 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Keith Busch <keith.busch@intel.com>, <linux-kernel@vger.kernel.org>,
        Bjorn
 Helgaas <bhelgaas@google.com>,
        Mika Westerberg
	<mika.westerberg@linux.intel.com>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH -next] PCI/PCIe: make DPC explicitly non-modular
Message-ID: <20160822221256.GA6006@windriver.com>
References: <20160728193303.12945-1-paul.gortmaker@windriver.com>
 <20160728202859.GA2420@localhost.localdomain>
 <20160728212801.GY11410@windriver.com>
 <20160822194427.GM18628@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20160822194427.GM18628@localhost>
List-ID: <linux-pci.vger.kernel.org>

[Re: [PATCH -next] PCI/PCIe: make DPC explicitly non-modular] On 22/08/2016 (Mon 14:44) Bjorn Helgaas wrote:

> Hi Paul,
> 
> On Thu, Jul 28, 2016 at 05:28:02PM -0400, Paul Gortmaker wrote:

[...]

> > 
> > Yep, not to worry, I've still got the following patches pending for-4.9:
> > 
> > $ grep PCI series 
> > # PCI
> > PCI-aerdrv-make-it-explicitly-non-modular.patch
> > PCI-altera-make-it-explicitly-non-modular.patch
> > PCI-dra7xx-make-it-explicitly-non-modular.patch
> > PCI-imx6-make-it-explicitly-non-modular.patch
> > PCI-pme-make-it-explicitly-non-modular.patch
> > PCI-qcom-make-it-explicitly-non-modular.patch
> > PCI-spear13xx-make-it-explicitly-non-modular.patch
> > PCI-xilinx-make-it-explicitly-non-modular.patch
> > PCI-xilinx-nwl-make-it-eplicitly-non-modular.patch
> > PCI-portdrv-make-it-explicitly-non-modular.patch
> > PCI-PCIe-make-dpc-explicitly-non-modular.patch
> > PCI-generic-make-host-common-explicitly-non-modular.patch
> > PCI-hotplug_core-make-it-explicitly-non-modular.patch
> > PCI-hotplug-make-core-code-explicitly-non-modular.patch
> 
> Were you planning to post the patches above?  If so, I'll bundle them
> all up along with this DPC one.

Ha, too funny; I'd just split the remaining patches into two lots and
sent lot #1 (the binary equivalent ones) before seeing this.

The DPC one got put in lot #2 since it had __exit and/or .remove
functions, so the change isn't strictly binary equivalent anymore.

I'll send along lot #2 once you've had a chance to digest lot #1.
So feel free to ignore the earlier copy of the DPC one.

Thanks,
Paul.
--

> 
> Bjorn
