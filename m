Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <1452269236.31901.46.camel@redhat.com>
Subject: Re: [PATCH V2 22/23] pci, acpi: Match PCI config space accessors
 against platfrom specific quirks.
From: Mark Salter <msalter@redhat.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linaro-acpi@lists.linaro.org, linux-pci@vger.kernel.org,
	will.deacon@arm.com, okaya@codeaurora.org, wangyijing@huawei.com,
	Lorenzo.Pieralisi@arm.com, Tomasz Nowicki <tn@semihalf.com>,
	ddaney@caviumnetworks.com, linux-acpi@vger.kernel.org,
	robert.richter@caviumnetworks.com,
	linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	arnd@arndb.de, Stefano.Stabellini@eu.citrix.com,
	Liviu.Dudau@arm.com, bhelgaas@google.com, tglx@linutronix.de,
	mw@semihalf.com, jcm@redhat.com, jchandra@broadcom.com,
	rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
	hanjun.guo@linaro.org, Suravee.Suthikulpanit@amd.com,
	jiang.liu@linux.intel.com
Date: Fri, 08 Jan 2016 11:07:16 -0500
In-Reply-To: <20160108151216.GJ3097@leverpostej>
References: <1450278993-12664-1-git-send-email-tn@semihalf.com>
	 <1450278993-12664-23-git-send-email-tn@semihalf.com>
	 <1452262581.31901.26.camel@redhat.com> <20160108150137.GH3097@leverpostej>
	 <20160108151216.GJ3097@leverpostej>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2016-01-08 at 15:12 +0000, Mark Rutland wrote:
> On Fri, Jan 08, 2016 at 03:01:37PM +0000, Mark Rutland wrote:
> > On Fri, Jan 08, 2016 at 09:16:21AM -0500, Mark Salter wrote:
> > > On Wed, 2015-12-16 at 16:16 +0100, Tomasz Nowicki wrote:
> > > > Some platforms may not be fully compliant with generic set of PCI config
> > > > accessors. For these cases we implement the way to overwrite accessors
> > > > set before PCI buses enumeration. Algorithm that overwrite accessors
> > > > matches against platform ID (DMI), domain and bus number, hopefully
> > > > enough for all cases. All quirks can be defined using:
> > > > DECLARE_ACPI_MCFG_FIXUP() and keep self contained.
> > > > 
> > > > example:
> > > > 
> > > > static const struct dmi_system_id yyy[] = {
> > > >         {
> > > >                 .ident = "<Platform ident string>",
> > > >                 .callback = <handler>,
> > > >                 .matches = {
> > > >                         DMI_MATCH(DMI_SYS_VENDOR, "<system vendor>"),
> > > >                         DMI_MATCH(DMI_PRODUCT_NAME, "<product name>"),
> > > >                         DMI_MATCH(DMI_PRODUCT_VERSION, "product version"),
> > > >                 },
> > > >         },
> > > >         { }
> > > > };
> > > > 
> > > 
> > > This seems awkward to me in the case where the quirk is SoC-based and there
> > > may be multiple platforms affected. Needing a DECLARE_ACPI_MCFG_FIXUP for
> > > each platform using such a SoC (i.e. Mustang and Moonshot) doesn't seem
> > > right. In that case, I think it'd be better to check CPUID and possibly
> > > some SoC register to cover all platforms affected.
> > 
> > CPUs get reused across SoCs, so as you've implicitly noted, the CPUID
> > alone is insufficient.
> > 
> > Given that IP blocks get moved around between SoC variants, I don't
> > think you can check "some SoC register" based on the CPU ID -- you can
> > end up bringing the board down at that point.
> > 
> > If the CPU ID alone is insufficient to tell you about a component, it
> > cannot give you enough information about a component you can use to
> > query more information from.
> > 
> > If your platform requires a quirk, it's always going to be painful (and
> > to some extent, rightfulyl so). We should aim for correctness here with
> > explicit matching.
> 
> Further, if there is going to be an ever-expanding set of platforms
> requring quirks, then we need a standard mechanism in ACPI to enable the
> platform to tell us explicitly either which specific PCI implementation
> is used, or which common quirk is necessary.
> 

No, an ever-expanding set is exactly what we don't want. I think you've convinced
me that I'm taking a wrong view of the problem. Putting something in the ACPI
standard would be going too far and I think a hard sell to the standards folk.
There really is no foolproof way to match a plug and play ACPI PCIe root to
specific hardware without considering the exact platform and/or BIOS info. So
yeah, it should be painful in order to give incentive to the silicon vendors to
get it right.


