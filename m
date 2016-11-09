Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 9 Nov 2016 14:06:35 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christopher Covington <cov@codeaurora.org>
Cc: Sinan Kaya <okaya@codeaurora.org>,
        Tomasz Nowicki <tn@semihalf.com>, will.deacon@arm.com,
        catalin.marinas@arm.com, rafael@kernel.org,
        Lorenzo.Pieralisi@arm.com, arnd@arndb.de, hanjun.guo@linaro.org,
        jchandra@broadcom.com, dhdang@apm.com, ard.biesheuvel@linaro.org,
        robert.richter@caviumnetworks.com, mw@semihalf.com,
        Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
        wangyijing@huawei.com, msalter@redhat.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linaro-acpi@lists.linaro.org, jcm@redhat.com,
        andrea.gallo@linaro.org, jeremy.linton@arm.com,
        liudongdong3@huawei.com, gabriele.paoloni@huawei.com,
        jhugo@codeaurora.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] PCI: QDF2432 32 bit config space accessors
Message-ID: <20161109200635.GM14322@bhelgaas-glaptop.roam.corp.google.com>
References: <20160921173129.GA20006@localhost>
 <20160921223805.21652-1-cov@codeaurora.org>
 <20161031214833.GB14603@bhelgaas-glaptop.roam.corp.google.com>
 <dbf40b73baa71155f39e13d6e51073aa@codeaurora.org>
 <20161102160820.GA6568@bhelgaas-glaptop.roam.corp.google.com>
 <aa37ca67-9909-e8f2-1a3e-b724cdb46c7b@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <aa37ca67-9909-e8f2-1a3e-b724cdb46c7b@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 09, 2016 at 02:25:56PM -0500, Christopher Covington wrote:
> Hi Bjorn,
> 
> On 11/02/2016 12:08 PM, Bjorn Helgaas wrote:
> > On Tue, Nov 01, 2016 at 07:06:31AM -0600, cov@codeaurora.org wrote:
> >> Hi Bjorn,
> >>
> >> On 2016-10-31 15:48, Bjorn Helgaas wrote:
> >>> On Wed, Sep 21, 2016 at 06:38:05PM -0400, Christopher Covington wrote:
> >>>> The Qualcomm Technologies QDF2432 SoC does not support accesses
> >>>> smaller
> >>>> than 32 bits to the PCI configuration space. Register the appropriate
> >>>> quirk.
> >>>>
> >>>> Signed-off-by: Christopher Covington <cov@codeaurora.org>
> >>>
> >>> Hi Christopher,
> >>>
> >>> Can you rebase this against v4.9-rc1?  It no longer applies to my tree.
> >>
> >> I apologize for not being clearer. This patch depends on:
> >>
> >> PCI/ACPI: Extend pci_mcfg_lookup() responsibilities
> >> PCI/ACPI: Check platform-specific ECAM quirks
> >>
> >> These patches from Tomasz Nowicki were previously in your pci/ecam-v6
> >> branch, but that seems to have come and gone. How would you like to
> >> proceed?
> > 
> > Oh yes, that's right, I forgot that connection.  I'm afraid I kind of
> > dropped the ball on that thread, so I went back and read through it
> > again.
> > 
> > I *think* the current state is:
> > 
> >   - I'm OK with the first two patches that add the quirk
> >     infrastructure.
> > 
> >   - My issue with the last three patches that add ThunderX quirks is
> >     that there's no generic description of the ECAM address space.
> > 
> > So if I understand correctly, your Qualcomm patch depends only on the
> > first two patches.
> > 
> > Then the question is how the Qualcomm ECAM address space is described.
> > Your quirk overrides the default pci_generic_ecam_ops with the
> > &pci_32b_ops, but it doesn't touch the address space part, so I assume
> > the bus ranges and corresponding address space in your MCFG is
> > correct.  So far, so good.
> > 
> > Is there also an ACPI device that contains that space in _CRS?  I
> > think we concluded that the standard solution is to describe this with
> > a PNP0C02 device.
> > 
> > Would you mind opening a bugzilla at bugzilla.kernel.org and attaching
> > the dmesg log, /proc/iomem, and maybe a DSDT dump?  I'd like to have
> > something to point at to say "if you need an MCFG quirk, you need the
> > MCFG bit and *also* these other related ACPI device bits, and here's
> > how it should be done."
> 
> We're working to add the PNP0C02 resource to future firmware, but it's
> not in the current firmware. Are dmesg and /proc/iomem from the
> current firmware interesting or should we wait for the update to file?

Note that the ECAM space is not the only thing that should be
described via these PNP0C02 devices.  *All* non-enumerable resources
should be described by the _CRS method of some ACPI device.  Here's a
sample from my laptop:

  PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
  system 00:01: [io  0x1800-0x189f] could not be reserved
  system 00:01: [io  0x0800-0x087f] has been reserved
  system 00:01: [io  0x0880-0x08ff] has been reserved
  system 00:01: [io  0x0900-0x097f] has been reserved
  system 00:01: [io  0x0980-0x09ff] has been reserved
  system 00:01: [io  0x0a00-0x0a7f] has been reserved
  system 00:01: [io  0x0a80-0x0aff] has been reserved
  system 00:01: [io  0x0b00-0x0b7f] has been reserved
  system 00:01: [io  0x0b80-0x0bff] has been reserved
  system 00:01: [io  0x15e0-0x15ef] has been reserved
  system 00:01: [io  0x1600-0x167f] has been reserved
  system 00:01: [io  0x1640-0x165f] has been reserved
  system 00:01: [mem 0xf8000000-0xfbffffff] could not be reserved
  system 00:01: [mem 0xfed10000-0xfed13fff] has been reserved
  system 00:01: [mem 0xfed18000-0xfed18fff] has been reserved
  system 00:01: [mem 0xfed19000-0xfed19fff] has been reserved
  system 00:01: [mem 0xfeb00000-0xfebfffff] has been reserved
  system 00:01: [mem 0xfed20000-0xfed3ffff] has been reserved
  system 00:01: [mem 0xfed90000-0xfed93fff] has been reserved
  system 00:01: [mem 0xf7fe0000-0xf7ffffff] has been reserved
  system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)

Do you have firmware in the field that may not get updated?  If so,
I'd like to see the whole solution for that firmware, including the
MCFG quirk (which tells the PCI core where the ECAM region is) and
whatever PNP0C02 quirk you figure out to actually reserve the region.

I proposed a PNP0C02 quirk to Duc along these lines of the below.  I
don't actually know if it's feasible, but it didn't look as bad as I
expected, so I'd kind of like somebody to try it out.  I think you
would have to call this via a DMI hook (do you have DMI on arm64?),
maybe from pnp_init() or similar.

  struct pnp_protocol pnpquirk_protocol = {
    .name = "Plug and Play Quirks",
  };

  void quirk()
  {
    struct pnp_dev *dev;
    struct resource res;

    ret = pnp_register_protocol(&pnpquirk_protocol);
    if (ret)
      return;

    dev = pnp_alloc_dev(&pnpquirk_protocol, 0, "PNP0C02");
    if (!dev)
      return;

    res.start = XX;          /* ECAM start */
    res.end = YY;            /* ECAM end */
    res.flags = IORESOURCE_MEM;
    pnp_add_resource(dev, &res);

    dev->active = 1;
    pnp_add_device(dev);

    dev_info(&dev->dev, "fabricated device to reserve ECAM space %pR\n", &res);
  }

Bjorn
