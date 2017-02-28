Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v2 14/22] dt-bindings: PCI: dra7xx: Add dt bindings to
 enable legacy mode
To: Rob Herring <robh@kernel.org>
References: <1487325042-28227-1-git-send-email-kishon@ti.com>
 <1487325042-28227-15-git-send-email-kishon@ti.com>
 <20170227164054.xcubjpaf2qx3pxol@rob-hp-laptop>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <58B4EE69.6030004@ti.com>
Date: Tue, 28 Feb 2017 08:58:41 +0530
MIME-Version: 1.0
In-Reply-To: <20170227164054.xcubjpaf2qx3pxol@rob-hp-laptop>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Joao Pinto <Joao.Pinto@synopsys.com>,
 linux-doc@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>, nsekhar@ti.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>



On Monday 27 February 2017 10:10 PM, Rob Herring wrote:
> On Fri, Feb 17, 2017 at 03:20:34PM +0530, Kishon Vijay Abraham I wrote:
>> Update device tree binding documentation of TI's dra7xx PCI
>> controller to include property for enabling legacy mode.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  Documentation/devicetree/bindings/pci/ti-pci.txt |    4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt b/Documentation/devicetree/bindings/pci/ti-pci.txt
>> index 190828a..72ebe2b 100644
>> --- a/Documentation/devicetree/bindings/pci/ti-pci.txt
>> +++ b/Documentation/devicetree/bindings/pci/ti-pci.txt
>> @@ -39,6 +39,10 @@ DEVICE MODE
>>   - interrupts : one interrupt entries must be specified for main interrupt.
>>   - num-ib-windows : number of inbound address translation windows
>>   - num-ob-windows : number of outbound address translation windows
>> + - syscon-legacy-mode: phandle to the syscon dt node. The 1st argument should
>> +		       contain the register offset within syscon and the 2nd
>> +		       argument should contain the bit field for setting the
>> +		       legacy mode
> 
> Vendor prefix needed and what does "legacy mode" mean? Perhaps name this 
> around what the mode is/does, not that it is legacy.

All right, thanks!

-Kishon

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
