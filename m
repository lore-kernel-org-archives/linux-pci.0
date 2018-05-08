Return-Path: <SRS0=DTHM=H3=molgen.mpg.de=pmenzel@kernel.org>
Return-Path: <SRS0=DTHM=H3=molgen.mpg.de=pmenzel@kernel.org>
Subject: Re: pciehp 0000:00:1c.0:pcie004: Timeout on hotplug command 0x1038
 (issued 65284 msec ago)
To: Bjorn Helgaas <helgaas@kernel.org>, okaya@codeaurora.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
References: <8770820b-85a0-172b-7230-3a44524e6c9f@molgen.mpg.de>
 <20180427192207.GG8199@bhelgaas-glaptop.roam.corp.google.com>
 <43b8ab4a-f8ee-dc96-40ec-e6fdfedd8309@molgen.mpg.de>
 <20180504024527.GE15790@bhelgaas-glaptop.roam.corp.google.com>
 <aa72d3ba089c76449600c22b58a2cafe@codeaurora.org>
 <20180504133327.GF15790@bhelgaas-glaptop.roam.corp.google.com>
 <20180507213344.GA133147@bhelgaas-glaptop.roam.corp.google.com>
From: Paul Menzel <pmenzel+linux-pci@molgen.mpg.de>
Message-ID: <903e7c20-fdd7-9cbf-debb-a90e70240c7c@molgen.mpg.de>
Date: Tue, 8 May 2018 08:59:34 +0200
MIME-Version: 1.0
In-Reply-To: <20180507213344.GA133147@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Dear Bjorn,


Am 07.05.2018 um 23:33 schrieb Bjorn Helgaas:
> On Fri, May 04, 2018 at 08:33:27AM -0500, Bjorn Helgaas wrote:
>> commit b0d6f2230e12c85ae3b65a854a53c67c7c1f6406
>> Author: Bjorn Helgaas <bhelgaas@google.com>
>> Date:   Thu May 3 18:39:38 2018 -0500
>>
>>      PCI: pciehp: Add quirk for Intel Command Completed erratum
>>      
>>      The Intel CF118 erratum means the controller does not set the Command
>>      Completed bit unless writes to the Slot Command register change "Control"
>>      bits.  Command Completed is never set for writes that only change software
>>      notification "Enable" bits.  This results in timeouts like this:
>>      
>>        pciehp 0000:00:1c.0:pcie004: Timeout on hotplug command 0x1038 (issued 65284 msec ago)
>>      
>>      When this erratum is present, avoid these timeouts by marking commands
>>      "completed" immediately unless they change the "Control" bits.
>>      
>>      Here's the text of the erratum from the Intel document:
>>      
>>        CF118        PCIe Slot Status Register Command Completed bit not always
>>                     updated on any configuration write to the Slot Control
>>                     Register
>>      
>>        Problem:     For PCIe root ports (devices 0 - 10) supporting hot-plug,
>>                     the Slot Status Register (offset AAh) Command Completed
>>                     (bit[4]) status is updated under the following condition:
>>                     IOH will set Command Completed bit after delivering the new
>>                     commands written in the Slot Controller register (offset
>>                     A8h) to VPP. The IOH detects new commands written in Slot
>>                     Control register by checking the change of value for Power
>>                     Controller Control (bit[10]), Power Indicator Control
>>                     (bits[9:8]), Attention Indicator Control (bits[7:6]), or
>>                     Electromechanical Interlock Control (bit[11]) fields. Any
>>                     other configuration writes to the Slot Control register
>>                     without changing the values of these fields will not cause
>>                     Command Completed bit to be set.
>>      
>>                     The PCIe Base Specification Revision 2.0 or later describes
>>                     the “Slot Control Register” in section 7.8.10, as follows
>>                     (Reference section 7.8.10, Slot Control Register, Offset
>>                     18h). In hot-plug capable Downstream Ports, a write to the
>>                     Slot Control register must cause a hot-plug command to be
>>                     generated (see Section 6.7.3.2 for details on hot-plug
>>                     commands). A write to the Slot Control register in a
>>                     Downstream Port that is not hotplug capable must not cause a
>>                     hot-plug command to be executed.
>>      
>>                     The PCIe Spec intended that every write to the Slot Control
>>                     Register is a command and expected a command complete status
>>                     to abstract the VPP implementation specific nuances from the
>>                     OS software. IOH PCIe Slot Control Register implementation
>>                     is not fully conforming to the PCIe Specification in this
>>                     respect.
>>      
>>        Implication: Software checking on the Command Completed status after
>>                     writing to the Slot Control register may time out.
>>      
>>        Workaround:  Software can read the Slot Control register and compare the
>>                     existing and new values to determine if it should check the
>>                     Command Completed status after writing to the Slot Control
>>                     register.
>>      
>>      Link: http://www.intel.com/content/www/us/en/processors/xeon/xeon-e7-v2-spec-update.html
>>      Link: https://lkml.kernel.org/r/8770820b-85a0-172b-7230-3a44524e6c9f@molgen.mpg.de
>>      Reported-by: Paul Menzel <pmenzel+linux-pci@molgen.mpg.de>
>>      Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> I applied this with Paul's tested-by on pci/hotplug for v4.18.

Thank you very much. Will this also be picked up by the stable Linux 
kernel series?

[…]


Kind regards,

Paul
