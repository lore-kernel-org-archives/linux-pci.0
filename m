Return-Path: <SRS0=5qum=5V=suse.de=jroedel@kernel.org>
Return-Path: <SRS0=5qum=5V=suse.de=jroedel@kernel.org>
Date: Fri, 16 Jun 2017 18:29:23 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Daniel Drake <drake@endlessm.com>,
	Alexander Deucher <Alexander.Deucher@amd.com>,
	Samuel Sieb <samuel@sieb.net>,
	David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v2] PCI: Add ATS-disable quirk for AMD Stoney GPUs
Message-ID: <20170616162923.GE25710@suse.de>
References: <1491575538-22694-1-git-send-email-joro@8bytes.org>
 <20170615140421.GB25710@suse.de>
 <20170615191545.GB12735@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170615191545.GB12735@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Thu, Jun 15, 2017 at 02:15:45PM -0500, Bjorn Helgaas wrote:
> It was marked "superseded" in patchwork and thus off my radar.  I
> don't remember if I did that or why.  I changed it back to "New" so I
> won't forget about it.

Great!

> You mention (May 24) the original bug report.  Can you include the URL
> for that?

I think there were multiple reports, here is one I could still find:

	https://lists.linuxfoundation.org/pipermail/iommu/2017-March/020836.html

> I admit I just don't have warm fuzzies that the problem is well
> understood.

The current understanding (without my ability to debug the hardware
involved) is that the GPU in the Stoney systems gets into a weird state
when ATS invalidations are sent too fast and stops responding to the
iommu.

The iommu then can't complete the invalidation commands and the driver
throws completion-wait loop timeout messages out.



	Joerg
