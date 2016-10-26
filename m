Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lekensteyn.nl ([178.21.112.251]:50423 "EHLO lekensteyn.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933434AbcJZXdJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Oct 2016 19:33:09 -0400
Date: Thu, 27 Oct 2016 00:56:41 +0200
From: Peter Wu <peter@lekensteyn.nl>
To: linux-acpi@vger.kernel.org
Cc: nouveau@lists.freedesktop.org, rick.2889@gmail.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: Acer Aspire V7-582PG (Haswell, GTX 750M) fails to power off GPU via
 Power Resources
Message-ID: <20161026225641.GA27017@al>
References: <bug-98398-8800@http.bugs.freedesktop.org/>
 <bug-98398-8800-66oU1nuK0R@http.bugs.freedesktop.org/>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bug-98398-8800-66oU1nuK0R@http.bugs.freedesktop.org/>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi PCI/ACPI PM experts,

Since Linux 4.8, nouveau switched to rely on the PCIe port driver to
transition to D3cold. This however does not happen for an Acer Aspire
V7-582PG (Haswell, NVIDIA GTX 750M) from Rick.

Any idea why? acpidump, lspci, dmesg and other details can be found in
the linked bug below.

Kind regards,
Peter

On Wed, Oct 26, 2016 at 10:42:07PM +0000, bugzilla-daemon@freedesktop.org wrote:
> https://bugs.freedesktop.org/show_bug.cgi?id=98398
> 
> --- Comment #11 from Peter Wu <peter@lekensteyn.nl> ---
> So 4.7 and before used the "DSM" method on runtime-suspend:
> - \_SB.PCI0.RP05.PEGP._DSM would be invoked to enable Optimus
> - \_SB.PCI0.RP05.PEGP._PS3 is then invoked which would enter D3cold
> (note, this method is still used in 4.8 on older laptops or with the
> pcie_pm_port=off kernel option)
> 
> Since 4.8, _DSM is not called anymore by nouveau (when support from the PCI
> core is detected) and this sequence should instead happen:
> - \_SB.PCI0.RP05.PEGP._PS3 (does nothing besides updating _STA)
> - PCIe core removes power for the PCIe port since all its children are in
>   D3 and are willing to transition to D3cold. It does so by invoking
>   \NVP3._OFF (where \NVP3 is the power resource from \_SB.PCI0.RP05._PR3)
> 
> That is how I think it should work in theory, but on Ricks laptop running
> 4.8.4,
> /sys/bus/devices/0000:1c.4/firmware_node/ does not have power_resources_D0
> devices (which I do have on my own laptop for 0000:01:0).
> 
> The SSDT1 of Rick's Acer laptop shows this structure:
> 
>     If (\_OSI ("Windows 2013"))
>     {
>         Scope (\_SB.PCI0.RP05)
>         {
>         //...
>             Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
>             {
>                 NVP3
>             })
>             Name (_PR2, Package (0x01)  // _PR2: Power Resources for D2
>             {
>                 NVP2
>             })
>             Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
>             {
>                 NVP3
>             })
>             // ...
>             Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
>             {
>             }
> 
>             Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
>             {
>             }
>         }
> 
>         Name (MSD3, Zero)
>         PowerResource (NVP3, 0x00, 0x0000)
>         {
>             Name (_STA, One)  // _STA: Status
>             // ...
> 
>             Method (_ON, 0, NotSerialized)  // _ON_: Power On
>             {
>                 // ...
>             }
> 
>             Method (_OFF, 0, NotSerialized)  // _OFF: Power Off
>             {
>                 // ...
>             }
>         }
> 
> The dmesg does show "ACPI: Power Resource [NVP3] (on)", so I guess that the
> methods are found. It is a mystery to me why the "power_resources_Dx" files are
> not created, possibly breaking PM.
