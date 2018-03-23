Return-Path: <SRS0=+Q5Y=GN=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=+Q5Y=GN=linux.intel.com=mika.westerberg@kernel.org>
Date: Fri, 23 Mar 2018 13:18:56 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>, Keith Busch <keith.busch@intel.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 1/2] PCI/DPC: Disable interrupt generation during suspend
Message-ID: <20180323111856.GO2703@lahna.fi.intel.com>
References: <20180314114125.71132-1-mika.westerberg@linux.intel.com>
 <CAJZ5v0gOrQhXzLHDnABEYHxGbHVY89Nij9uQzqx-oyYmFwzuSg@mail.gmail.com>
 <20180314120547.GB2703@lahna.fi.intel.com>
 <20180314123332.GC19651@wunner.de>
 <20180320104508.GF2703@lahna.fi.intel.com>
 <20180320113556.GA24197@wunner.de>
 <20180322104517.GA20389@wunner.de>
 <20180322165317.GI2703@lahna.fi.intel.com>
 <20180322173903.GA15503@wunner.de>
 <20180322193630.GB252023@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180322193630.GB252023@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 22, 2018 at 02:36:30PM -0500, Bjorn Helgaas wrote:
> I hope we can avoid adding suspend_late/resume_early callbacks in
> struct pcie_port_service_driver, and I also hope we can avoid adding
> device links.  Those both sound pretty complicated.
> 
> Can you do something like the patch below, which does something
> similar for PME?

AFAICT the core PCI PM code follows the same ordering than what PM core
does so it may be possible that not all service drivers get
resumed/suspended before other children (PCI buses). Basically this
would be the same than just using core PM ops in DPC driver (in which
case DPC specific things are still kept in DPC driver not in PCI core).

If we do not care about that then I think both options are pretty
straighforward to implement.
