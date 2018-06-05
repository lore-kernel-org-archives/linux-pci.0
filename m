Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 1/6] PCI: iproc: Update iProc PCI binding for INTx support
To: Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
References: <1527631130-20045-1-git-send-email-ray.jui@broadcom.com>
 <1527631130-20045-2-git-send-email-ray.jui@broadcom.com>
 <CAL_Jsq+ac6dmHKS6m0h5N3bv=VseKVL8XLU5K7j1Rn=mgFNLsA@mail.gmail.com>
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <808cc0bd-3ff2-a601-9c2d-09705fd36e51@broadcom.com>
Date: Mon, 4 Jun 2018 18:17:04 -0700
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+ac6dmHKS6m0h5N3bv=VseKVL8XLU5K7j1Rn=mgFNLsA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pci@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>, Bjorn Helgaas <bhelgaas@google.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Rob/Arnd,

On 6/4/2018 7:17 AM, Rob Herring wrote:
> +Arnd
> 
> On Tue, May 29, 2018 at 4:58 PM, Ray Jui <ray.jui@broadcom.com> wrote:
>> Update the iProc PCIe binding document for better modeling of the legacy
>> interrupt (INTx) support
>>
>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>> ---
>>   .../devicetree/bindings/pci/brcm,iproc-pcie.txt    | 31 +++++++++++++++++-----
>>   1 file changed, 24 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
>> index b8e48b4..7ea24dc 100644
>> --- a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
>> +++ b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
>> @@ -13,9 +13,6 @@ controller, used in Stingray
>>     PAXB-based root complex is used for external endpoint devices. PAXC-based
>>   root complex is connected to emulated endpoint devices internal to the ASIC
>>   - reg: base address and length of the PCIe controller I/O register space
>> -- #interrupt-cells: set to <1>
>> -- interrupt-map-mask and interrupt-map, standard PCI properties to define the
>> -  mapping of the PCIe interface to interrupt numbers
>>   - linux,pci-domain: PCI domain ID. Should be unique for each host controller
>>   - bus-range: PCI bus numbers covered
>>   - #address-cells: set to <3>
>> @@ -41,6 +38,16 @@ Required:
>>   - brcm,pcie-ob-axi-offset: The offset from the AXI address to the internal
>>   address used by the iProc PCIe core (not the PCIe address)
>>
>> +Legacy interrupt (INTx) support (optional):
>> +
>> +Note INTx is for PAXB only.
>> +
>> +- interrupt-controller: claims itself as an interrupt controller for INTx
>> +- #interrupt-cells: set to <1>
>> +- interrupt-map-mask and interrupt-map, standard PCI properties to define
>> +the mapping of the PCIe interface to interrupt numbers
>> +- interrupts: interrupt line wired to the generic GIC for INTx support
>> +
>>   MSI support (optional):
>>
>>   For older platforms without MSI integrated in the GIC, iProc PCIe core provides
>> @@ -77,9 +84,14 @@ Example:
>>                  compatible = "brcm,iproc-pcie";
>>                  reg = <0x18012000 0x1000>;
>>
>> +               interrupt-controller;
>>                  #interrupt-cells = <1>;
>> -               interrupt-map-mask = <0 0 0 0>;
>> -               interrupt-map = <0 0 0 0 &gic GIC_SPI 100 IRQ_TYPE_NONE>;
>> +               interrupt-map-mask = <0 0 0 7>;
>> +               interrupt-map = <0 0 0 1 &pcie0 1>,
> 
> Are you sure this works? The irq parsing code will ignore
> interrupt-map if interrupt-controller is found. In other words, you
> should have one or the other, but not both.

Yes, it does work. I tested this by using an Intel E1000E PCIe NIC card 
installed in our system and have it fall back to INTx.

> 
> Maybe it happens to work because "pcie0" is this node and your irq
> numbers are the same.

Perhaps it works because we are claiming "pcie0" as an interrupt 
controller by itself and the INTx is modeled under that.

> 
> Arnd, any thoughts on this?
> 

Please let me know if the above model makes sense or not.

Thanks,

Ray

>> +                               <0 0 0 2 &pcie0 2>,
>> +                               <0 0 0 3 &pcie0 3>,
>> +                               <0 0 0 4 &pcie0 4>;
>> +               interrupts = <GIC_SPI 100 IRQ_TYPE_NONE>;
>>
>>                  linux,pci-domain = <0>;
>>
>> @@ -115,9 +127,14 @@ Example:
>>                  compatible = "brcm,iproc-pcie";
>>                  reg = <0x18013000 0x1000>;
>>
>> +               interrupt-controller;
>>                  #interrupt-cells = <1>;
>> -               interrupt-map-mask = <0 0 0 0>;
>> -               interrupt-map = <0 0 0 0 &gic GIC_SPI 106 IRQ_TYPE_NONE>;
>> +               interrupt-map-mask = <0 0 0 7>;
>> +               interrupt-map = <0 0 0 1 &pcie1 1>,
>> +                               <0 0 0 2 &pcie1 2>,
>> +                               <0 0 0 3 &pcie1 3>,
>> +                               <0 0 0 4 &pcie1 4>;
>> +               interrupts = <GIC_SPI 106 IRQ_TYPE_NONE>;
>>
>>                  linux,pci-domain = <1>;
>>
>> --
>> 2.1.4
>>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
