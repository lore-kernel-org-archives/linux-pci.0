Return-Path: <SRS0=PSII=GX=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=PSII=GX=intel.com=keith.busch@kernel.org>
Date: Mon, 2 Apr 2018 17:09:49 -0600
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Oza Pawandeep <poza@codeaurora.org>,
	Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCHv2 1/7] PCI/DPC: Enable ERR_COR
Message-ID: <20180402230949.GA4485@localhost.localdomain>
References: <20180402162203.3370-1-keith.busch@intel.com>
 <20180402162203.3370-2-keith.busch@intel.com>
 <20180402212302.GN9322@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180402212302.GN9322@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 02, 2018 at 04:23:02PM -0500, Bjorn Helgaas wrote:
> On Mon, Apr 02, 2018 at 10:21:57AM -0600, Keith Busch wrote:
> > A DPC port may be configured to send ERR_COR message when the
> > triggered. This patch enables this feature so additional notification
> > of the event is possible.
> 
> Who is the intended consumer of the ERR_COR message?  I guess if the
> root port supports AER, we'll see AER logging when we didn't before?
> Is that what you mean by "additional notification"?
> 
> Or, since the DPC ERR_COR implementation note (sec 6.2.10.2) suggests
> that ERR_COR is primarily intended for use by platform firmware, does
> this change enable notification via the firmware?  If so, how does
> that work?  Does it require the platform to retain control of AER so
> it can see these events?  But if the platform retains AER control, I
> don't think we'd be enabling DPC in Linux.  I'm confused.
> 
> The similar implementation note in 6.2.10.5 suggests that
> DL_ACTIVE_ERR_COR is also intended for use by the platform.  Should we
> be setting that for the same reason we're setting
> PCI_EXP_DPC_CTL_ERR_COR?

I think there are various ways this could play out. I added this to
the series per a request for future use, but I actually don't have an
environment where I could test as intended. As I understand, it was
for platform firmware that may own the root port, but not switches in
an external enclosure, so the OS would own the DPC control. The ERR_COR
is to notify firmware so it may note an event in a platform log.

I think you bring up a good point on DL_Active.

This should be harmless even if there are no consumers for the message,
or if the OS owns the root port AER control. But I'm totally fine
with dropping this one in the series, and it's not related to the rest
anyway. I think I at least need to circle back with platform makers and
really test the feature on capable hardware.
