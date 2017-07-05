Return-Path: <SRS0=I8Y1=6I=sigmadesigns.com=marc_gonzalez@kernel.org>
Return-Path: <SRS0=I8Y1=6I=sigmadesigns.com=marc_gonzalez@kernel.org>
Subject: Re: [PATCH v5 2/3] PCI: Add tango PCIe host bridge support
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, Lorenzo Pieralisi
	<lorenzo.pieralisi@arm.com>, Mason <slash.tmp@free.fr>, Marc Zyngier
	<marc.zyngier@arm.com>, linux-pci <linux-pci@vger.kernel.org>, Thibaud Cornic
	<thibaud_cornic@sigmadesigns.com>, Liviu Dudau <liviu.dudau@arm.com>, LKML
	<linux-kernel@vger.kernel.org>, David Laight <david.laight@aculab.com>,
	Thomas Gleixner <tglx@linutronix.de>, Phuong Nguyen
	<phuong_nguyen@sigmadesigns.com>, Robin Murphy <robin.murphy@arm.com>,
	"Linux ARM" <linux-arm-kernel@lists.infradead.org>
References: <741766e5-cff2-db5f-d40b-6866e08fd966@sigmadesigns.com>
 <1802aae0-f97b-c437-c00e-5fa7c867286d@sigmadesigns.com>
 <CAKv+Gu_VBrbra0GZ9gziVh+pcjO34f28t5WHoBTrfYCNAKfnAg@mail.gmail.com>
From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Message-ID: <1be733d5-0193-f5a4-37fc-2d04fa0df990@sigmadesigns.com>
Date: Wed, 5 Jul 2017 14:18:22 +0200
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu_VBrbra0GZ9gziVh+pcjO34f28t5WHoBTrfYCNAKfnAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On 05/07/2017 11:36, Ard Biesheuvel wrote:

> On 31 May 2017 at 13:33, Marc Gonzalez wrote:
>
>> This driver is required to work around several hardware bugs
>> in the PCIe controller.
>>
>> NB: Revision 1 does not support legacy interrupts, or IO space.
>>
>> +       /*
>> +        * QUIRK #1
>> +        * Reads in configuration space outside devfn 0 return garbage.
>> +        */
>> +       if (devfn !=3D 0)
>> +               return PCIBIOS_FUNC_NOT_SUPPORTED;
>> +
>=20
> Does this mean multi-function devices are not supported? E.g., on my
> system I have
>=20
> -[0000:00]-+-00.0  Advanced Micro Devices, Inc. [AMD] Device 1a00
>            +-02.0  Advanced Micro Devices, Inc. [AMD] Device 1a01
>            +-02.1-[01]----00.0  Renesas Technology Corp. uPD720201 USB 3.=
0
>            \-02.2-[02]--+-00.0  NVIDIA Corporation GT218 [GeForce 210]
>                         \-00.1  NVIDIA Corporation HD Audio Controller
>=20
> where the HDMI audio is on devfn 00.1 on bus 2

Thanks for having a look. Here's the situation.

# lspci -v
00:00.0 PCI bridge: Sigma Designs, Inc. Device 0024 (rev 01) (prog-if 00 [N=
ormal decode])
        Flags: bus master, fast devsel, latency 0, IRQ 31
        Memory at <ignored> (64-bit, non-prefetchable)
        Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D=
0
        I/O behind bridge: 00000000-00000fff
        Memory behind bridge: 00400000-004fffff
        Prefetchable memory behind bridge: 00000000-000fffff
        Capabilities: [50] MSI: Enable+ Count=3D1/4 Maskable- 64bit+
        Capabilities: [78] Power Management version 3
        Capabilities: [80] Express Root Port (Slot-), MSI 03
        Capabilities: [100] Virtual Channel
        Capabilities: [800] Advanced Error Reporting
        Kernel driver in use: pcieport

01:00.0 USB controller: Renesas Technology Corp. uPD720201 USB 3.0 Host Con=
troller (rev 03) (prog-if 30 [XHCI])
        Flags: bus master, fast devsel, latency 0, IRQ 21
        Memory at 50400000 (64-bit, non-prefetchable) [size=3D8K]
        Capabilities: [50] Power Management version 3
        Capabilities: [70] MSI: Enable- Count=3D1/8 Maskable- 64bit+
        Capabilities: [90] MSI-X: Enable+ Count=3D8 Masked-
        Capabilities: [a0] Express Endpoint, MSI 00
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [150] Latency Tolerance Reporting
        Kernel driver in use: xhci_hcd


IIUC, bus 0 will always be the PCIe host bridge.
On bus 0, reads outside of devfn 0 return garbage.
I think (?) this is not an issue, because the host bridge
is not multi-function.

There is a /separate/ erratum for bus 1. The HW returns
garbage when enumerating non-existent devfn.
IIUC, there is an OOB SoC-specific error-reporting mechanism,
so it might be possible to check for an error after every read,
and replace the garbage with -1u on error.

The errata list does not mention buses > 1 but I would assume
they are, at a minimum, affected by the "bus 1" errata --
such setups were not tested at all. (It would require some
kind of PCIe switch, I suppose.)

As a first-order approximation, I just conflated the two
errata, and ignored multi-function EPs.

NB: the "typical" use-case for the PCIe slot is adding a validated
WiFi card, because the SoC doesn't support WiFi natively.
Some customers also consider using a USB3 card, instead of the
native USB2 Chipidea controller.

Regards.
