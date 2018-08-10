Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42880 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbeHJMf6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Aug 2018 08:35:58 -0400
From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v3 0/4] pci-dra7xx: Enable errata i870 workaround for RC
 mode
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Tony Lindgren <tony@atomide.com>,
        KISHON VIJAY ABRAHAM <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180724173150.2701-1-vigneshr@ti.com>
 <20180808165700.GB486@e107981-ln.cambridge.arm.com>
Message-ID: <ba428a15-77bf-e09c-3bd7-b5a0eae7ee13@ti.com>
Date: Fri, 10 Aug 2018 15:37:28 +0530
MIME-Version: 1.0
In-Reply-To: <20180808165700.GB486@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Wednesday 08 August 2018 10:27 PM, Lorenzo Pieralisi wrote:
> On Tue, Jul 24, 2018 at 11:01:46PM +0530, Vignesh R wrote:
>> Make workaround for errata i870 applicable in Host mode as
>> well(previously it was enabled only for EP mode) as per errata
>> documentation: http://www.ti.com/lit/er/sprz450/sprz450.pdf
>>
>> Tested on DRA72 EVM
>>
>> Tony,
>>
>> If you are okay with the series, could you pick this via omap tree?
>> All ACKs are in place and Lorenzo is okay with PCIe bits to go along with
>> rest of DTS changes.
> 
> I think we have missed the v4.19 merge window by now - 

Right. I didn't get any response from Tony.

> please let me know if I can drop this series from the PCI patch queue.
> 

Ok, I will resend the patch after 4.19-rc. Thanks!

Regards
Vignesh


> Thanks,
> Lorenzo
> 
>> Regards
>> Vignesh
>>
>>
>> Changes since v2:
>> Reorder patch 2 to appear at the last.
>> Collect all the ACKs
>>
>> Changes since v1:
>> Drop IRQ handling rework (will be sent out separately)
>>
>> v2: https://patchwork.ozlabs.org/cover/935454/
>> v1: https://lkml.org/lkml/2017/12/1/59
>>
>>
>> Vignesh R (4):
>>   dt-bindings: PCI: dra7xx: Add bindings for unaligned access in host
>>     mode
>>   ARM: dts: dra7: Enable workaround for errata i870 in PCIe host mode
>>   ARM: dts: dra7: Fix up unaligned access setting for PCIe EP
>>   pci: dwc: pci-dra7xx: Enable errata i870 for both EP and RC mode
>>
>>  Documentation/devicetree/bindings/pci/ti-pci.txt |  5 +++++
>>  arch/arm/boot/dts/dra7.dtsi                      |  4 +++-
>>  drivers/pci/controller/dwc/pci-dra7xx.c          | 12 ++++++------
>>  3 files changed, 14 insertions(+), 7 deletions(-)
>>
>> -- 
>> 2.18.0
>>
