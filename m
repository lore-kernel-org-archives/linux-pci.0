Return-Path: <kishon@ti.com>
Return-Path: <kishon@ti.com>
Subject: Re: [PATCH 3/4] PCI: dra7xx: Add support to force RC to work in GEN1
 mode
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1476190715-16884-1-git-send-email-kishon@ti.com>
 <1476190715-16884-4-git-send-email-kishon@ti.com>
 <20161111211528.GF9868@bhelgaas-glaptop.roam.corp.google.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nsekhar@ti.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <8ecc1325-365d-bdec-d435-729e0ea49d20@ti.com>
Date: Sat, 12 Nov 2016 12:40:10 +0530
MIME-Version: 1.0
In-Reply-To: <20161111211528.GF9868@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Saturday 12 November 2016 02:45 AM, Bjorn Helgaas wrote:
> Hi Kishon,
> 
> On Tue, Oct 11, 2016 at 06:28:34PM +0530, Kishon Vijay Abraham I wrote:
>> PCIe in AM57x/DRA7x devices is by default
>> configured to work in GEN2 mode.  However there
>> may be situations when working in GEN1 mode is
>> desired. One example is limitation i925 (PCIe GEN2
>> mode not supported at junction temperatures < 0C).
>>
>> Add support to force Root Complex to work in GEN1
>> mode if so desired, but don't force GEN1 mode on
>> any board just yet.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>> ---
>>  Documentation/devicetree/bindings/pci/ti-pci.txt |    1 +
>>  drivers/pci/host/pci-dra7xx.c                    |   27 ++++++++++++++++++++++
>>  2 files changed, 28 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt b/Documentation/devicetree/bindings/pci/ti-pci.txt
>> index 60e2516..a3d6ca3 100644
>> --- a/Documentation/devicetree/bindings/pci/ti-pci.txt
>> +++ b/Documentation/devicetree/bindings/pci/ti-pci.txt
>> @@ -25,6 +25,7 @@ PCIe Designware Controller
>>  
>>  Optional Property:
>>   - gpios : Should be added if a gpio line is required to drive PERST# line
>> + - ti,pcie-is-gen1 : Force the PCIe controller to work in GEN1 (2.5 GT/s).
> 
> Can we use "max-link-speed" so it's similar to imx6?

yeah, maybe we should make it a generic PCI property?

Thanks
Kishon
