Return-Path: <lukas@wunner.de>
Return-Path: <lukas@wunner.de>
Date: Mon, 28 Nov 2016 11:22:08 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Wei Zhang <wzhang@fb.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Keith Busch <keith.busch@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCHv4 next 0/3] Limiting pci access
Message-ID: <20161128102208.GA4072@wunner.de>
References: <1477695497-6207-1-git-send-email-keith.busch@intel.com>
 <20161118232544.GI28386@localhost.localdomain>
 <20161123160906.GB16033@bhelgaas-glaptop.roam.corp.google.com>
 <CB060C5F-26CB-40E8-91BB-B891B5704746@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CB060C5F-26CB-40E8-91BB-B891B5704746@fb.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 28, 2016 at 09:14:39AM +0000, Wei Zhang wrote:
> The series of changes made by Keith are to support the PCIe hot plug
> testing on our Lightning platform (Thanks Keith!).  Lightning is a
> "Just of Bunch of Flash", or JBOF, storage platform that has a PCIe
> switch connecting to 15 NVMe SSDs.

Are the hotplug ports on this switch capable of D3hot?  There's a
series queued up for 4.10 which will suspend hotplug ports to D3hot
when nothing is connected.  I cc'ed Keith when I posted it, but I
forgot to cc you:

https://www.spinics.net/lists/linux-pci/msg55564.html

If you haven't tested this series so far, now would be a good time
to do so, as it would allow fixing regressions (if any) before 4.10
is out.  Note that this series might save you quite a bit of power
if you have lots of unused ports.

You can fetch the patches from:

https://github.com/l1k/linux/commits/pcie_port_pm_v2

Thanks,

Lukas
