Return-Path: <SRS0=tpkN=6Q=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=tpkN=6Q=intel.com=keith.busch@kernel.org>
Date: Thu, 13 Jul 2017 12:03:45 -0400
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-pci@vger.kernel.org,
	timur@codeaurora.org, alex.williamson@redhat.com,
	vikrams@codeaurora.org, Lorenzo.Pieralisi@arm.com,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V4] PCI: handle CRS returned by device after FLR
Message-ID: <20170713160345.GG8388@localhost.localdomain>
References: <1499375234-23928-1-git-send-email-okaya@codeaurora.org>
 <20170713121758.GL4486@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170713121758.GL4486@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 13, 2017 at 07:17:58AM -0500, Bjorn Helgaas wrote:
> On Thu, Jul 06, 2017 at 05:07:14PM -0400, Sinan Kaya wrote:
> > An endpoint is allowed to issue Configuration Request Retry Status (CRS)
> > following a Function Level Reset (FLR) request to indicate that it is not
> > ready to accept new requests.
> > 
> > Seen a timeout message with Intel 750 NVMe drive and FLR reset.
> > 
> > Kernel enables CRS visibility in pci_enable_crs() function for each bridge
> > it discovers. The OS observes a special vendor ID read value of 0xFFFF0001
> > in this case. We need to keep polling until this special read value
> > disappears. pci_bus_read_dev_vendor_id() takes care of CRS handling for a
> > given vendor id read request under the covers.
> > 
> > Adding a vendor ID read if this is a physical function before attempting
> > to read any other registers on the endpoint. A CRS indication will only
> > be given if the address to be read is vendor ID register.
> > 
> > Note that virtual functions report their vendor ID through another
> > mechanism.
> > 
> > The spec is calling to wait up to 1 seconds if the device is sending CRS.
> > The NVMe device seems to be requiring more. Relax this up to 60 seconds.
> 
> Can you add a pointer to the "1 second" requirement in the spec here?
> We use 60 seconds in pci_scan_device() and acpiphp_add_context().  Is
> there a basis in the spec for the 60 second timeout?

I also don't see anywhere that says CRS is limited to only 1 second. It
looks to me that the spec allows a device to return CRS for as long as it
takes to complete initialization.

>From PCIe Base Spec, Section 2.3.1 CRS Implementation note:

  A device in receipt of a Configuration Request following a valid reset
  condition may respond with a CRS Completion Status to terminate the
  Request, and thus effectively stall the Configuration Request until
  such time that the subsystem has completed local initialization and
  is ready to communicate with the host.

No time limit specified here, or anywhere else for that matter AFAICT.
Where is 1 second requirement coming from?
