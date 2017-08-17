Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <59953510.8000509@rock-chips.com>
Date: Thu, 17 Aug 2017 14:17:52 +0800
From: jeffy <jeffy.chen@rock-chips.com>
MIME-Version: 1.0
To: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [RFC PATCH 2/3] dt-bindings: PCI: rockchip: Add support for pcie
 wake irq
References: <20170816075224.31734-1-jeffy.chen@rock-chips.com>
 <20170816075224.31734-3-jeffy.chen@rock-chips.com>
 <35487e90-74f2-3a66-70d3-d0780b0b6e26@rock-chips.com>
In-Reply-To: <35487e90-74f2-3a66-70d3-d0780b0b6e26@rock-chips.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
 briannorris@chromium.org, linux-kernel@vger.kernel.org, dianders@chromium.org,
 linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
 bhelgaas@google.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Shawn,

On 08/16/2017 04:35 PM, Shawn Lin wrote:
> Hi Jeffy
>
> On 2017/8/16 15:52, Jeffy Chen wrote:
>> Add an optional interrupt for PCIE_WAKE pin.
>>
>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>> ---
>>
>>   Documentation/devicetree/bindings/pci/rockchip-pcie.txt | 11
>> +++++++----
>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
>> b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
>> index 1453a734c2f5..6ef9903567db 100644
>> --- a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
>> +++ b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
>> @@ -22,10 +22,13 @@ Required properties:
>>   - phys: From PHY bindings: Phandle for the Generic PHY for PCIe.
>>   - phy-names:  MUST be "pcie-phy".
>>   - interrupts: Three interrupt entries must be specified.
>> -- interrupt-names: Must include the following names
>> -    - "sys"
>> -    - "legacy"
>> -    - "client"
>> +- interrupt-names: Include the following names
>> +    Required:
>> +        - "sys"
>> +        - "legacy"
>> +        - "client"
>> +    Optional:
>> +        - "wake"
>
> It would be better to introduce interrupts-extended and show a example
> here. :)
ok, will add it in next version
>
>>   - resets: Must contain seven entries for each entry in reset-names.
>>          See ../reset/reset.txt for details.
>>   - reset-names: Must include the following names
>>
>
>
>



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
