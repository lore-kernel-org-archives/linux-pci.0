Return-Path: <SRS0=D3qI=XU=apm.com=dhdang@kernel.org>
Return-Path: <SRS0=D3qI=XU=apm.com=dhdang@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20161205215318.GB22455@bhelgaas-glaptop.roam.corp.google.com>
References: <1480549373-2123-1-git-send-email-dhdang@apm.com>
 <20161201183350.GF30746@bhelgaas-glaptop.roam.corp.google.com>
 <CADaLNDm6fPQ6ekQa85fveAamJtF3+HGeOvprmgGJ4gLnMhF2_w@mail.gmail.com> <20161205215318.GB22455@bhelgaas-glaptop.roam.corp.google.com>
From: Duc Dang <dhdang@apm.com>
Date: Mon, 5 Dec 2016 14:09:12 -0800
Message-ID: <CADaLND=wqO+dWJWgqqy5Wqd4zO1yRptpeq+6p_TEjSpb_7gMQQ@mail.gmail.com>
Subject: Re: [PATCH v3] PCI/ACPI: xgene: Add ECAM quirk for X-Gene PCIe controller
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Rafael Wysocki <rafael@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, Mark Salter <msalter@redhat.com>, linux-pci@vger.kernel.org,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jon Masters <jcm@redhat.com>,
	Tomasz Nowicki <tn@semihalf.com>, patches <patches@apm.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 5, 2016 at 1:53 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Thu, Dec 01, 2016 at 06:52:23PM -0800, Duc Dang wrote:
>> On Thu, Dec 1, 2016 at 10:33 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
>> I made similar changes in v4 patch. The ECAM quirk will be built when
>> ACPI and PCI_QUIRKS are enabled.
>>
>> When building for DT only, the ECAM quirk won't be compiled.
>
> Perfect.
>
>> >>  #define XGENE_PCIE_IP_VER_UNKN               0
>> >>  #define XGENE_PCIE_IP_VER_1          1
>> >> +#define XGENE_PCIE_IP_VER_2          2
>> >
>> > This isn't used anywhere, which makes me wonder whether it's worth
>> > keeping it.
>>
>> V2 controller will use this XGENE_PCIE_IP_VER_2 (port->version =
>> XGENE_PCIE_IP_VER_2). This will be used to indicate that the
>> controller is V2, and to enable configuration request retry status
>> feature (by not disable it like V1 controller).
>
> OK, I see.  You don't actually need XGENE_PCIE_IP_VER_2, you just need
> port->version to be something other than XGENE_PCIE_IP_VER_1.  So this
> is fine as it is.
>
>> >>  static void __iomem *xgene_pcie_get_cfg_base(struct pci_bus *bus)
>> >>  {
>> >> -     struct xgene_pcie_port *port = bus->sysdata;
>> >> +     struct pci_config_window *cfg;
>> >> +     struct xgene_pcie_port *port;
>> >> +
>> >> +     if (acpi_disabled)
>> >> +             port = bus->sysdata;
>> >> +     else {
>> >> +             cfg = bus->sysdata;
>> >> +             port = cfg->priv;
>> >> +     }
>> >
>> > I would really, really like to figure out a way to get rid of these
>> > "if (acpi_disabled)" checks sprinkled through here.  Is there any way
>> > we can set up bus->sysdata to be the same, regardless of whether we're
>> > using this as a platform driver or an ACPI quirk?
>>
>> Right now, I created a inline function to extract xgene_pcie_port from
>> pci_bus. In order to get rid of acpi_disabled, I will need to make
>> sysdata in DT case also point to pci_config_window structure, which
>> means I will need to convert and test the DT driver to use ecam ops.
>> It is a separate patch itself. So I think I should do it at later time
>> (after this ECAM quirk patch). I hope you are ok with this.
>
> OK.  I did the simple-minded version of leaving the DT ops the same
> but making sysdata point to a dummy pci_config_window.  Your proposal
> of using ECAM for DT would be much better.
>
> It's interesting that you actually already use the same accessors
> except that DT uses the 32-bit pci_generic_config_write32() and ACPI
> uses the regular pci_generic_config_write(). I guess that means the
> hardware actually *does* support sub-32 bit writes?

Yes, the hardware does support sub-32 bit writes (and reads). This is
another item in my TODO list for DT (which does not seem quite urgent
now): switch to use pci_generic_config_write for DT. But, well, I will
need to do that for read as well (for both ACPI and DT).

>
>> I need to define the function (xgene_get_csr_resource()) inside
>> pci-xgene.c to duplicate the code of acpi_get_rc_addr. The reason is
>> X-Gene firmware does not have a dedicate PNP0C02 node to declare the
>> resource, and if I use acpi_get_rc_resources() with "PNP0A08", I got
>> error due to acpi_bus_get_device() returns error.
>
> Looks good.
>
>> > All these init functions are almost identical.  Can we factor this out
>> > by having wrappers that do nothing more than pass in the table and
>> > version, and put the kzalloc and ioremap in a shared back-end?
>>
>> I refactor-ed these .init functions. And as a result, there are only 2
>> ecam ops left: xgene_v1_pcie_ecam_ops and xgene_v2_pcie_ecam_ops.
>
> Looks good.
>
> Bjorn
Regards,
Duc Dang.
