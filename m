Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 14 Mar 2018 14:07:15 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI/DPC: Do not enable DPC if AER control is not
 allowed by the BIOS
Message-ID: <20180314120715.GC2703@lahna.fi.intel.com>
References: <20180314114125.71132-1-mika.westerberg@linux.intel.com>
 <20180314114125.71132-2-mika.westerberg@linux.intel.com>
 <CAJZ5v0gNLi==C+_ZYiHSvbFUfTmp1nxX_bEVggrRXpUpPhptzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJZ5v0gNLi==C+_ZYiHSvbFUfTmp1nxX_bEVggrRXpUpPhptzA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 14, 2018 at 12:50:28PM +0100, Rafael J. Wysocki wrote:
> On Wed, Mar 14, 2018 at 12:41 PM, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > Commit eed85ff4c0da ("PCI/DPC: Enable DPC only if AER is available")
> > made DPC control dependent whether AER is enabled in the OS. However, it
> > does not take into account situations where BIOS has not given OS
> > control of AER:
> >
> >   acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
> >   acpi PNP0A08:00: _OSC: platform does not support [AER]
> >   acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
> >
> > I think here it is better not to enable DPC even if the capability is
> > available because then it would be against what "Determination of DPC
> > Control" note in PCIe 4.0 sec 6.1.10 recommends.
> >
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> This may clash with the recent PCIe ports initialization rework from
> Bjorn, please double check.

You are right. I did not notice those changes. I'll rebase this on top
of Bjorn's pci/portdrv branch.
