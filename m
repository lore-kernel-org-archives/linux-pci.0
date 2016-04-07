Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 7 Apr 2016 16:34:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] pci: Added flag to pci_host_bridge to hint not to use
 acpi
Message-ID: <20160407213429.GA24492@localhost>
References: <1458770518-10203-1-git-send-email-jonathan.derrick@intel.com>
 <20160324164159.GB25518@localhost.localdomain>
 <20160407174224.GE8780@localhost>
 <20160407201216.GA9986@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160407201216.GA9986@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 07, 2016 at 02:12:16PM -0600, Jon Derrick wrote:
> Hi Bjorn,
> 
> First, thanks for the review
> 
> > The spec (PCI Firmware spec 3.0, sec 4.5) says _OSC is a child of an
> > ACPI device and applies to that device.  In your case, I think there
> > is no ACPI PNP0A0x device for the VMD host bridge, and hence there is
> > no _OSC method for it.  There's no ACPI handle for the VMD bridge, so
> > I think pcie_port_acpi_setup() returns -EINVAL, which causes
> > get_port_device_capability() to give up and decide that the port
> > can't support *any* PCIe services.
> > 
> > I think that's the real problem: the fact that there's no ACPI device
> > corresponding to the bridge should not be an error.  It should just
> > mean the platform doesn't have an opportunity to limit what services
> > the kernel can manage.  I think pcie_port_acpi_setup() should return 0
> > in all cases.  Can you try that and see if it fixes the problem?
> > 
> 
> I believe what you are suggesting is:
> 
> 
>         handle = acpi_find_root_bridge_handle(port);
>         if (!handle)
> -               return -EINVAL;
> +               return 0;
> 
>         root = acpi_pci_find_root(handle);
>         if (!root)
> -               return -ENODEV;
> +               return 0;

Yes, that's what I think we should do.

Bjorn
