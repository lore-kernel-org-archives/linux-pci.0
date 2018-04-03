Return-Path: <SRS0=VSG7=GY=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=VSG7=GY=intel.com=keith.busch@kernel.org>
Date: Tue, 3 Apr 2018 08:37:50 -0600
From: Keith Busch <keith.busch@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Oza Pawandeep <poza@codeaurora.org>,
	Sinan Kaya <okaya@codeaurora.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCHv2 1/7] PCI/DPC: Enable ERR_COR
Message-ID: <20180403143750.GB4485@localhost.localdomain>
References: <20180402162203.3370-1-keith.busch@intel.com>
 <20180402162203.3370-2-keith.busch@intel.com>
 <20180402212302.GN9322@bhelgaas-glaptop.roam.corp.google.com>
 <20180402230949.GA4485@localhost.localdomain>
 <20180403141646.GC60020@bhelgaas-glaptop.roam.corp.google.com>
 <CAJZ5v0gpgJQSvkBX-PcXrPZ2bx_CCSAsfvpGz_zE-thqBF3X0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJZ5v0gpgJQSvkBX-PcXrPZ2bx_CCSAsfvpGz_zE-thqBF3X0w@mail.gmail.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 03, 2018 at 04:31:15PM +0200, Rafael J. Wysocki wrote:
> On Tue, Apr 3, 2018 at 4:16 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > This picture doesn't make sense to me yet.  Per the PCI Firmware spec,
> > r3.2, sec 4.5.2, we use _OSC to negotiate control over AER (and now
> > DPC).  I think _OSC is only allowed directly under a host bridge
> > device (PNP0A08 or PNP0A03), and it applies to the entire hierarchy
> > under the host bridge.
> >
> > I don't know how firmware could claim to own AER on a root port, but
> > not on switches (external or otherwise) below that root port.
> >
> > If _OSC says firmware owns AER, we won't touch AER on the root port,
> > but we also won't touch DPC on switches below the root port.  So I
> > don't see how this change will help.
> 
> This matches my understanding of that part of the spec.

Thanks, guys. It seems this patch doesn't accomplish anything.
