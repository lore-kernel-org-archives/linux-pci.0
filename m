Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <1452262581.31901.26.camel@redhat.com>
Subject: Re: [PATCH V2 22/23] pci, acpi: Match PCI config space accessors
 against platfrom specific quirks.
From: Mark Salter <msalter@redhat.com>
To: Tomasz Nowicki <tn@semihalf.com>, bhelgaas@google.com,
	arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com,
	rjw@rjwysocki.net, hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, Stefano.Stabellini@eu.citrix.com
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linaro-acpi@lists.linaro.org, jchandra@broadcom.com, jcm@redhat.com
Date: Fri, 08 Jan 2016 09:16:21 -0500
In-Reply-To: <1450278993-12664-23-git-send-email-tn@semihalf.com>
References: <1450278993-12664-1-git-send-email-tn@semihalf.com>
	 <1450278993-12664-23-git-send-email-tn@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2015-12-16 at 16:16 +0100, Tomasz Nowicki wrote:
> Some platforms may not be fully compliant with generic set of PCI config
> accessors. For these cases we implement the way to overwrite accessors
> set before PCI buses enumeration. Algorithm that overwrite accessors
> matches against platform ID (DMI), domain and bus number, hopefully
> enough for all cases. All quirks can be defined using:
> DECLARE_ACPI_MCFG_FIXUP() and keep self contained.
> 
> example:
> 
> static const struct dmi_system_id yyy[] = {
>         {
>                 .ident = "<Platform ident string>",
>                 .callback = <handler>,
>                 .matches = {
>                         DMI_MATCH(DMI_SYS_VENDOR, "<system vendor>"),
>                         DMI_MATCH(DMI_PRODUCT_NAME, "<product name>"),
>                         DMI_MATCH(DMI_PRODUCT_VERSION, "product version"),
>                 },
>         },
>         { }
> };
> 

This seems awkward to me in the case where the quirk is SoC-based and there
may be multiple platforms affected. Needing a DECLARE_ACPI_MCFG_FIXUP for
each platform using such a SoC (i.e. Mustang and Moonshot) doesn't seem
right. In that case, I think it'd be better to check CPUID and possibly
some SoC register to cover all platforms affected.

Also, there doesn't seem to be a way to connect a given quirk check to the
MCFG/device requesting the ops. So if there is a platform with multiple PCIE
roots and not all of them have quirks, how does one no whether to override the
default ecam ops?

