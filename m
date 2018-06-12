Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 11 Jun 2018 17:55:20 -0700
In-Reply-To: <522816f9-c33f-ee58-619e-84ee86dba418@broadcom.com>
References: <1527631130-20045-1-git-send-email-ray.jui@broadcom.com>
 <1527631130-20045-4-git-send-email-ray.jui@broadcom.com>
 <f5aa804e-3174-affd-1117-31b0a5b59fc5@gmail.com>
 <522816f9-c33f-ee58-619e-84ee86dba418@broadcom.com>
MIME-Version: 1.0
Subject: Re: [PATCH 3/6] arm: dts: Change PCIe INTx mapping for Cygnus
To: Ray Jui <ray.jui@broadcom.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <D95617BA-7C31-4737-9514-BA3F7B09DCE2@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On June 11, 2018 5:27:20 PM PDT, Ray Jui <ray.jui@broadcom.com> wrote:
>
>
>On 6/11/2018 3:36 PM, Florian Fainelli wrote:
>> On 05/29/2018 02:58 PM, Ray Jui wrote:
>>> Change the PCIe INTx mapping to model the 4 INTx interrupts in the
>>> IRQ domain of the iProc PCIe controller itself
>>>
>>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>>> ---
>>>   arch/arm/boot/dts/bcm-cygnus.dtsi | 18 ++++++++++++++----
>>>   1 file changed, 14 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi
>b/arch/arm/boot/dts/bcm-cygnus.dtsi
>>> index 699fdf9..6de21ef 100644
>>> --- a/arch/arm/boot/dts/bcm-cygnus.dtsi
>>> +++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
>>> @@ -254,9 +254,14 @@
>>>   			compatible = "brcm,iproc-pcie";
>>>   			reg = <0x18012000 0x1000>;
>>>   
>>> +			interrupt-controller;
>>>   			#interrupt-cells = <1>;
>>> -			interrupt-map-mask = <0 0 0 0>;
>>> -			interrupt-map = <0 0 0 0 &gic GIC_SPI 100 IRQ_TYPE_NONE>;
>>> +			interrupt-map-mask = <0 0 0 7>;
>>> +			interrupt-map = <0 0 0 1 &pcie0 1>,
>>> +					<0 0 0 2 &pcie0 2>,
>>> +					<0 0 0 3 &pcie0 3>,
>>> +					<0 0 0 4 &pcie0 4>;
>>> +			interrupts = <GIC_SPI 100 IRQ_TYPE_NONE>;
>> 
>> You would want to fix those IRQ_TYPE_NONE values as well because
>since
>> commit 83a86fbb5b56b5eed8a476cc3fe214077d7c4f49 ("irqchip/gic: Loudly
>> complain about the use of IRQ_TYPE_NONE") this is going to create
>some
>> nice warnings on boot.
>> 
>> I am about to send fixes for NSP and HR2 since that's what I have
>access
>> to at the moment, but it would be good if you could send updates to
>the
>> Cygnus and NS2 DTS files?
>> 
>> Thanks
>> 
>
>Okay. Thanks for letting me know. How do you want this to be done for 
>Cygnus and NS2?
>
>I guess I should have the fix patches to DTS done and sent out first, 
>and then rebase this INTx patch series against the patches with the
>fix.
>
>Does that make sense to you?

Yes it does. As soon as v4.18-rc1 is tagged I will send the Device Tree fixes pull request, if I can have yours for Cygnus and NS2 in the next few days I could lump those together. Then we can either base your changes off v4.18-rc2 or a later tag that already has the DTS fixes.

-- 
Florian

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
