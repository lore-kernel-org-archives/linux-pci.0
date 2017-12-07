Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 7 Dec 2017 08:45:15 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Chen, Kenji" <kenji.chen@intel.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        David Daney <david.daney@cavium.com>,
        Krishna Kishore <kthota@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vidya Sagar <vidyas@nvidia.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Patrick Georgi <pgeorgi@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        Yinghai Lu <yinghai@kernel.org>,
        Stefan Reinauer <stefan.reinauer@coreboot.org>,
        Duncan Laurie <dlaurie@chromium.org>
Subject: Re: [PATCH v1 0/2] PCI/ASPM: Refine L1 PM Substates support
Message-ID: <20171207144515.GA11788@bhelgaas-glaptop.roam.corp.google.com>
References: <20171202211833.23146.5744.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20171205194050.GD23510@bhelgaas-glaptop.roam.corp.google.com>
 <A7A4B3ECFA40144E98B82E71E29693557CA5516C@PGSMSX102.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A7A4B3ECFA40144E98B82E71E29693557CA5516C@PGSMSX102.gar.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 06, 2017 at 01:55:37AM +0000, Chen, Kenji wrote:
> https://pcisig.com/sites/default/files/specification_documents/ECN_L1_PM_Substates_with_CLKREQ_31_May_2013_Rev10a.pdf

With all due respect, this doesn't seem to add any new information.
For example, the L1 PM Substates Control 1 register description from
the above is basically identical to the published PCIe r3.1, sec
7.33.3.

So it doesn't answer the questions of:

  1) Why coreboot sets the L1.2 threshold to a fixed value, and

  2) How "(1 << 21) | (1 << 23) | (1 << 30)" relates to the Control 1
     register

> Pls also check My Intel Doc# 545845 for the bits fields description.

I don't have access to this document.  The Linux code I'm proposing is
based on the PCIe spec and is intended to work on all hardware that
conforms to that spec.  I'm not very familiar with coreboot, but maybe
the L1 Substates code there is only intended to work on certain Intel
chipsets and doesn't need to work on other hardware?

Bjorn

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org] 
> Sent: Wednesday, December 6, 2017 3:41 AM
> To: linux-pci@vger.kernel.org
> Cc: Chen, Kenji <kenji.chen@intel.com>; Thierry Reding <treding@nvidia.com>; Manikanta Maddireddy <mmaddireddy@nvidia.com>; David Daney <david.daney@cavium.com>; Krishna Kishore <kthota@nvidia.com>; linux-kernel@vger.kernel.org; Vidya Sagar <vidyas@nvidia.com>; Julia Lawall <Julia.Lawall@lip6.fr>; linux-tegra@vger.kernel.org; Patrick Georgi <pgeorgi@chromium.org>; Rajat Jain <rajatja@google.com>; Yinghai Lu <yinghai@kernel.org>; Stefan Reinauer <stefan.reinauer@coreboot.org>; Duncan Laurie <dlaurie@chromium.org>
> Subject: Re: [PATCH v1 0/2] PCI/ASPM: Refine L1 PM Substates support
> 
> On Sat, Dec 02, 2017 at 03:45:38PM -0600, Bjorn Helgaas wrote:
> > The PCIe active link power state is L0.  ASPM defines two low-power
> > states: L0s and L1.  The L1 PM Substates feature defines two 
> > additional low-power states: L1.1 and L2.2.
> > 
> > The L1.2 state may have substantial entry/exit latency.  Downstream 
> > devices can use the Latency Tolerance Reporting (LTR) feature to 
> > report how much latency they can tolerate.  The L1 PM Substates 
> > capability includes a programmable L1.2 threshold register.  If the 
> > downstream devices can tolerate the latency indicated by the 
> > threshold, L1.2 may be used.
> > 
> > If LTR is not enabled, the L1.2 threshold is ignored and L1.2 can be 
> > used whenever it is enabled and CLKREQ# is de-asserted.  Linux 
> > currently never enables LTR, but firmware may have done so.
> > 
> > The current L1 PM substates support in Linux sets the L1.2 threshold 
> > to a fixed value (163.84us) copied from coreboot [1].  I don't know 
> > where that value came from, and it is incorrect for some platforms, 
> > e.g., Tegra [2].
> > 
> > These patches change that so we calculate the L1.2 threshold based on 
> > values reported by the hardware, and we enable LTR whenever possible.
> > 
> > This is all just my understanding from reading the spec.  I'd be glad 
> > to be corrected if I'm going wrong.
> > 
> > I'm particularly puzzled about the coreboot code in
> > pciexp_L1_substate_commit() that sets LTR_L1.2_THRESHOLD:
> > 
> > +	pcie_update_cfg(root, root_cap + 0x08, ~0xe3ff0000,
> > +		(1 << 21) | (1 << 23) | (1 << 30));
> > 
> > This is writing the L1 PM Substates Control 1 register, but the shifts 
> > don't match up with any of the fields in the register, so this is an 
> > awfully funny way to write the threshold.
> > 
> > [1] 
> > https://mail.coreboot.org/pipermail/coreboot-gerrit/2015-March/021134.
> > html [2] 
> > https://lkml.kernel.org/r/1510492674-12786-1-git-send-email-vidyas@nvi
> > dia.com
> > 
> > ---
> > 
> > Bjorn Helgaas (2):
> >       PCI/ASPM: Calculate LTR_L1.2_THRESHOLD from device characteristics
> >       PCI/ASPM: Enable Latency Tolerance Reporting when supported
> > 
> > 
> >  drivers/pci/pcie/aspm.c |   71 +++++++++++++++++++++++++++++++----------------
> >  drivers/pci/probe.c     |   33 ++++++++++++++++++++++
> >  include/linux/pci.h     |    2 +
> >  3 files changed, 82 insertions(+), 24 deletions(-)
> 
> I applied these with Vidya's Reviewed-by to pci/aspm for v4.16.
> 
> I'd still really like to hear from the coreboot folks about the rationale for the current coreboot code.  You folks are in a much better position to actually understand the hardware details.
> 
> Bjorn
