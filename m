Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 30/37] dt-bindings: PCI: dra7xx: Add dt bindings to enable
 legacy mode
To: Rob Herring <robh@kernel.org>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
 <1484216786-17292-31-git-send-email-kishon@ti.com>
 <20170118214603.qnewy3sm6sgw7lbg@rob-hp-laptop>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <58A563F5.5040504@ti.com>
Date: Thu, 16 Feb 2017 14:03:57 +0530
MIME-Version: 1.0
In-Reply-To: <20170118214603.qnewy3sm6sgw7lbg@rob-hp-laptop>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Joao Pinto <Joao.Pinto@synopsys.com>,
 Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
 Jingoo Han <jingoohan1@gmail.com>, linux-arm-msm@vger.kernel.org,
 nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com,
 linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Thursday 19 January 2017 03:16 AM, Rob Herring wrote:
> On Thu, Jan 12, 2017 at 03:56:19PM +0530, Kishon Vijay Abraham I wrote:
>> Update device tree binding documentation of TI's dra7xx PCI
>> controller to include property for enabling legacy mode.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  Documentation/devicetree/bindings/pci/ti-pci.txt |    4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt b/Documentation/devicetree/bindings/pci/ti-pci.txt
>> index 62f5f59..ed85e8e 100644
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
> What's legacy mode?

It's the name of the bit-field defined in TRM used to add workaround for errata
id i870 (See [PATCH 29/37] PCI: dwc: dra7xx: Workaround for errata id i870 of
this series). I'm not sure what it does internally.

Thanks
Kishon

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
