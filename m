Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180314114125.71132-2-mika.westerberg@linux.intel.com>
References: <20180314114125.71132-1-mika.westerberg@linux.intel.com> <20180314114125.71132-2-mika.westerberg@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 14 Mar 2018 12:50:28 +0100
Message-ID: <CAJZ5v0gNLi==C+_ZYiHSvbFUfTmp1nxX_bEVggrRXpUpPhptzA@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI/DPC: Do not enable DPC if AER control is not
 allowed by the BIOS
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 14, 2018 at 12:41 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> Commit eed85ff4c0da ("PCI/DPC: Enable DPC only if AER is available")
> made DPC control dependent whether AER is enabled in the OS. However, it
> does not take into account situations where BIOS has not given OS
> control of AER:
>
>   acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
>   acpi PNP0A08:00: _OSC: platform does not support [AER]
>   acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
>
> I think here it is better not to enable DPC even if the capability is
> available because then it would be against what "Determination of DPC
> Control" note in PCIe 4.0 sec 6.1.10 recommends.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

This may clash with the recent PCIe ports initialization rework from
Bjorn, please double check.
