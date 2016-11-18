Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20161117175938.17465.45820.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20161117175938.17465.45820.stgit@bhelgaas-glaptop.roam.corp.google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 19 Nov 2016 00:02:24 +0100
Message-ID: <CAJZ5v0h3ax4+UCm57VYqV3SVzOZ3A5Ajykks10J49rj1O4VkvQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: Add information about describing PCI in ACPI
To: Bjorn Helgaas <bhelgaas@google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
 "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 17, 2016 at 6:59 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Add a writeup about how PCI host bridges should be described in ACPI
> using PNP0A03/PNP0A08 devices, PNP0C02 devices, and the MCFG table.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Looks great overall, but I have a few comments (below).

> ---
>  Documentation/PCI/00-INDEX      |    2 +
>  Documentation/PCI/acpi-info.txt |  136 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 138 insertions(+)
>  create mode 100644 Documentation/PCI/acpi-info.txt
>
> diff --git a/Documentation/PCI/00-INDEX b/Documentation/PCI/00-INDEX
> index 147231f..0780280 100644
> --- a/Documentation/PCI/00-INDEX
> +++ b/Documentation/PCI/00-INDEX
> @@ -1,5 +1,7 @@
>  00-INDEX
>         - this file
> +acpi-info.txt
> +       - info on how PCI host bridges are represented in ACPI
>  MSI-HOWTO.txt
>         - the Message Signaled Interrupts (MSI) Driver Guide HOWTO and FAQ.
>  PCIEBUS-HOWTO.txt
> diff --git a/Documentation/PCI/acpi-info.txt b/Documentation/PCI/acpi-info.txt
> new file mode 100644
> index 0000000..ccbcfda
> --- /dev/null
> +++ b/Documentation/PCI/acpi-info.txt
> @@ -0,0 +1,136 @@
> +           ACPI considerations for PCI host bridges
> +
> +The basic requirement is that the ACPI namespace should describe
> +*everything* that consumes address space unless there's another
> +standard way for the OS to find it [1, 2].  For example, windows that
> +are forwarded to PCI by a PCI host bridge should be described via ACPI
> +devices, since the OS can't locate the host bridge by itself.  PCI
> +devices *below* the host bridge do not need to be described via ACPI,
> +because the resources they consume are inside the host bridge windows,
> +and the OS can discover them via the standard PCI enumeration
> +mechanism (using config accesses to read and size the BARs).
> +
> +This ACPI resource description is done via _CRS methods of devices in

To be painfully precise, those need not be methods.  They may be
static objects too.

> +the ACPI namespace [2].   _CRS methods are like generalized PCI BARs:
> +the OS can read _CRS and figure out what resource is being consumed
> +even if it doesn't have a driver for the device [3].  That's important
> +because it means an old OS can work correctly even on a system with
> +new devices unknown to the OS.  The new devices won't do anything, but
> +the OS can at least make sure no resources conflict with them.
> +
> +Static tables like MCFG, HPET, ECDT, etc., are *not* mechanisms for
> +reserving address space!  The static tables are for things the OS
> +needs to know early in boot, before it can parse the ACPI namespace.
> +If a new table is defined, an old OS needs to operate correctly even
> +though it ignores the table.  _CRS allows that because it is generic
> +and understood by the old OS; a static table does not.
> +
> +If the OS is expected to manage an ACPI device, that device will have

I'm not very keen on using the term "ACPI device" in documentation as
it is not particularly well defined.  As a rule, I prefer to talk
about "non-discoverable devices described via ACPI" or similar.

Accordingly, I'd change the above line to something like "If the OS is
expected to manage a non-discoverable device described via ACPI, that
device will have".

> +a specific _HID/_CID that tells the OS what driver to bind to it, and
> +the _CRS tells the OS and the driver where the device's registers are.
> +
> +PNP0C02 "motherboard" devices are basically a catch-all.  There's no
> +programming model for them other than "don't use these resources for
> +anything else."  So any address space that is (1) not claimed by some
> +other ACPI device and (2) should not be assigned by the OS to

Here I'd say "any address space that is (1) not claimed by _CRS under
any other device object in the ACPI namespace and (2) ...".

> +something else, should be claimed by a PNP0C02 _CRS method.

Thanks,
Rafael

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
