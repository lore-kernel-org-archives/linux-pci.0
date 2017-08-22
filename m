Return-Path: <SRS0=TwQd=7Y=redhat.com=alex.williamson@kernel.org>
Return-Path: <SRS0=TwQd=7Y=redhat.com=alex.williamson@kernel.org>
Date: Tue, 22 Aug 2017 16:43:12 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, eric.auger@redhat.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix and amend express capability sizes
Message-ID: <20170822164312.302874c6@w520.home>
In-Reply-To: <20170822210501.GI6948@bhelgaas-glaptop.roam.corp.google.com>
References: <20170810165403.2968.49940.stgit@gimli.home>
	<20170822210501.GI6948@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Tue, 22 Aug 2017 16:05:01 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Thu, Aug 10, 2017 at 10:54:31AM -0600, Alex Williamson wrote:
> > PCI_CAP_EXP_ENDPOINT_SIZEOF_V1 defines the size of the PCIe express
> > capability structure for v1 devices with link, but we also have a need
> > in the vfio code for sizing the capability for devices without link,
> > such as root complex endpoints.  Create a separate define for this
> > ending the structure before the link fields.
> > 
> > Additionally, this reveals that PCI_CAP_EXP_ENDPOINT_SIZEOF_V2 is
> > currently incorrect, ending the capability length before the v2 link
> > fields.  Rename this to specify an RC endpoint (no link) capability
> > length and move PCI_CAP_EXP_ENDPOINT_SIZEOF_V2 to include the link
> > fields as we have for the v1 version.
> > 
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>  
> 
> Applied with Eric's reviewed-by to pci/misc for v4.14, thanks!
> 
> I think there was an underscore missing here:
> 
> > -#define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	44	/* v2 endpoints end here */
> > +#define PCI_CAP_EXP_RC ENDPOINT_SIZEOF_V2	44	/* v2 endpoints without link end here */  

Urgh, not sure how that happened.  Thanks for the fixup!

Alex
