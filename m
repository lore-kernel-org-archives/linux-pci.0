Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 8 Jan 2016 15:01:37 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Mark Salter <msalter@redhat.com>
Cc: Tomasz Nowicki <tn@semihalf.com>, bhelgaas@google.com,
	arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com,
	rjw@rjwysocki.net, hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, Stefano.Stabellini@eu.citrix.com,
	jchandra@broadcom.com, linaro-acpi@lists.linaro.org,
	linux-pci@vger.kernel.org, Liviu.Dudau@arm.com,
	ddaney@caviumnetworks.com, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, robert.richter@caviumnetworks.com,
	Suravee.Suthikulpanit@amd.com, jcm@redhat.com,
	wangyijing@huawei.com, tglx@linutronix.de, mw@semihalf.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2 22/23] pci, acpi: Match PCI config space accessors
 against platfrom specific quirks.
Message-ID: <20160108150137.GH3097@leverpostej>
References: <1450278993-12664-1-git-send-email-tn@semihalf.com>
 <1450278993-12664-23-git-send-email-tn@semihalf.com>
 <1452262581.31901.26.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1452262581.31901.26.camel@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 08, 2016 at 09:16:21AM -0500, Mark Salter wrote:
> On Wed, 2015-12-16 at 16:16 +0100, Tomasz Nowicki wrote:
> > Some platforms may not be fully compliant with generic set of PCI config
> > accessors. For these cases we implement the way to overwrite accessors
> > set before PCI buses enumeration. Algorithm that overwrite accessors
> > matches against platform ID (DMI), domain and bus number, hopefully
> > enough for all cases. All quirks can be defined using:
> > DECLARE_ACPI_MCFG_FIXUP() and keep self contained.
> > 
> > example:
> > 
> > static const struct dmi_system_id yyy[] = {
> >         {
> >                 .ident = "<Platform ident string>",
> >                 .callback = <handler>,
> >                 .matches = {
> >                         DMI_MATCH(DMI_SYS_VENDOR, "<system vendor>"),
> >                         DMI_MATCH(DMI_PRODUCT_NAME, "<product name>"),
> >                         DMI_MATCH(DMI_PRODUCT_VERSION, "product version"),
> >                 },
> >         },
> >         { }
> > };
> > 
> 
> This seems awkward to me in the case where the quirk is SoC-based and there
> may be multiple platforms affected. Needing a DECLARE_ACPI_MCFG_FIXUP for
> each platform using such a SoC (i.e. Mustang and Moonshot) doesn't seem
> right. In that case, I think it'd be better to check CPUID and possibly
> some SoC register to cover all platforms affected.

CPUs get reused across SoCs, so as you've implicitly noted, the CPUID
alone is insufficient.

Given that IP blocks get moved around between SoC variants, I don't
think you can check "some SoC register" based on the CPU ID -- you can
end up bringing the board down at that point.

If the CPU ID alone is insufficient to tell you about a component, it
cannot give you enough information about a component you can use to
query more information from.

If your platform requires a quirk, it's always going to be painful (and
to some extent, rightfulyl so). We should aim for correctness here with
explicit matching.

Thanks,
Mark.
