Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 3 Nov 2016 09:00:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: cov@codeaurora.org, Tomasz Nowicki <tn@semihalf.com>,
        will.deacon@arm.com, catalin.marinas@arm.com, rafael@kernel.org,
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
Message-ID: <20161103140058.GA31142@bhelgaas-glaptop.roam.corp.google.com>
References: <20160921173129.GA20006@localhost>
 <20160921223805.21652-1-cov@codeaurora.org>
 <20161031214833.GB14603@bhelgaas-glaptop.roam.corp.google.com>
 <dbf40b73baa71155f39e13d6e51073aa@codeaurora.org>
 <20161102160820.GA6568@bhelgaas-glaptop.roam.corp.google.com>
 <3fd26a0d-a5c2-c385-866e-b957dffb7dda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3fd26a0d-a5c2-c385-866e-b957dffb7dda@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 02, 2016 at 12:36:16PM -0400, Sinan Kaya wrote:
> Hi Bjorn,
> 
> On 11/2/2016 12:08 PM, Bjorn Helgaas wrote:
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
> 
> Qualcomm ECAM space includes both the root port and the endpoint address
> space with a single contiguous 256 MB address space described in MCFG table.
> There is no need to describe additional resources like PNP0C02.

This is the crucial point I have failed to communicate clearly: the
PNP0C02 resource is *always* required, even if the MCFG is correct.

The reason is that MCFG is a PCI-specific table, and it should be
possible to boot a kernel with no PCI support.  That kernel will not
look at the MCFG.  The PCI hardware will still be present and will
still consume the ECAM space, so the OS must be able to discover that
the ECAM space is not available for other devices.

The usual way to for the OS to discover that would be via the _CRS of
a PNP0A03 or PNP0A08 host bridge device.  _CRS is what I mean by a
"generic" way to describe this address space, because the ACPI core
can interpret _CRS for all ACPI devices, even if the kernel doesn't
contain drivers for all of those devices.

It turns out that we can't use the _CRS of host bridges because of the
Producer/Consumer bit screwup [1].  So the fallback is to include the
ECAM space in the _CRS of a PNP0C02 device.  This is what the PCI
Firmware spec r3.0, Table 4-2, footnote 2 is talking about.

Bjorn

[1] The original ACPI spec intent was that Consumer resources would be
space like ECAM that is consumed directly by the bridge, and Producer
resources would be the windows forwarded down to PCI.  But BIOSes
didn't use the Producer/Consumer bit consistently, so we have to
assume that all resources in host bridge _CRS are windows, which
leaves us no way to describe the Consumer resources.
