Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAD6G_RSCQ+CzifpofiXg9yFB3HpEqynF-3giEowRgR9E-qvX1Q@mail.gmail.com>
References: <CAD6G_RSCQ+CzifpofiXg9yFB3HpEqynF-3giEowRgR9E-qvX1Q@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 25 Jun 2014 11:03:21 -0600
Message-ID: <CAErSpo5DXHH-jBmqxGfahbJKXdya01OqgMn3H+iiVFM1w12izg@mail.gmail.com>
Subject: Re: PCIe current resource settings
To: Jagan Teki <jagannadh.teki@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-acpi]

On Wed, Jun 25, 2014 at 4:23 AM, Jagan Teki <jagannadh.teki@gmail.com> wrote:
> Hi,
>
> I think CRS feature is all ready available in Linux [1]

Yes, but _CRS is an ACPI feature, and the actual connection of _CRS
information to the PCI core is currently done by arch-specific code
for x86 and ia64.  There is no corresponding support for ARM.

The x86 and ia64 support is in arch-specific functions called
probe_pci_root_info().  These are actually generic in principle, and I
would love it if this functionality could be moved into
acpi_pci_root_add() somehow.

> I'm guessing the respective root complex driver need to enable and use
> this feature.
> I'm using PCIe bridge which is operating in ARM, how can I enable or
> is there RC driver which uses this feature already?
>
> [1] http://lwn.net/Articles/373551/
>
> thanks!
> --
> Jagan.
