Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v4 14/23] PCI: dwc: dra7xx: Workaround for errata id i870
To: Rob Herring <robh@kernel.org>
References: <20170313142259.25397-1-kishon@ti.com>
 <20170313142259.25397-15-kishon@ti.com>
 <20170320214819.5azzdbgncfemhujo@rob-hp-laptop>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <387a82a1-a534-efe1-e9eb-aa78809566a4@ti.com>
Date: Wed, 22 Mar 2017 20:09:24 +0530
MIME-Version: 1.0
In-Reply-To: <20170320214819.5azzdbgncfemhujo@rob-hp-laptop>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Joao Pinto <Joao.Pinto@synopsys.com>,
 linux-doc@vger.kernel.org, linux-pci@vger.kernel.org, nsekhar@ti.com,
 linux-kernel@vger.kernel.org, hch@infradead.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>



On Tuesday 21 March 2017 03:18 AM, Rob Herring wrote:
> On Mon, Mar 13, 2017 at 07:52:50PM +0530, Kishon Vijay Abraham I wrote:
>> According to errata i870, access to the PCIe slave port
>> that are not 32-bit aligned will result in incorrect mapping
>> to TLP Address and Byte enable fields.
>>
>> Accessing non 32-bit aligned data causes incorrect data in the target
>> buffer if memcpy is used. Implement the workaround for this
>> errata here.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/pci/dwc/pci-dra7xx.c | 53 ++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 53 insertions(+)
>>
>> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
>> index 35c18534469c..147d37a7fe58 100644
>> --- a/drivers/pci/dwc/pci-dra7xx.c
>> +++ b/drivers/pci/dwc/pci-dra7xx.c
>> @@ -26,6 +26,8 @@
>>  #include <linux/pm_runtime.h>
>>  #include <linux/resource.h>
>>  #include <linux/types.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/regmap.h>
>>  
>>  #include "pcie-designware.h"
>>  
>> @@ -528,6 +530,51 @@ static const struct of_device_id of_dra7xx_pcie_match[] = {
>>  	{},
>>  };
>>  
>> +/*
>> + * dra7xx_pcie_ep_unaligned_memaccess: workaround for AM572x/AM571x Errata i870
>> + * @dra7xx: the dra7xx device where the workaround should be applied
>> + *
>> + * Access to the PCIe slave port that are not 32-bit aligned will result
>> + * in incorrect mapping to TLP Address and Byte enable fields. Therefore,
>> + * byte and half-word accesses are not possible to byte offset 0x1, 0x2, or
>> + * 0x3.
>> + *
>> + * To avoid this issue set PCIE_SS1_AXI2OCP_LEGACY_MODE_ENABLE to 1.
>> + */
>> +static int dra7xx_pcie_ep_unaligned_memaccess(struct device *dev)
>> +{
>> +	int ret;
>> +	struct device_node *np = dev->of_node;
>> +	struct regmap *regmap;
>> +	unsigned int reg;
>> +	unsigned int field;
>> +
>> +	regmap = syscon_regmap_lookup_by_phandle(np,
>> +						 "ti,syscon-unaligned-access");
>> +	if (IS_ERR(regmap)) {
>> +		dev_dbg(dev, "can't get ti,syscon-unaligned-access\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (of_property_read_u32_index(np, "ti,syscon-unaligned-access", 1,
>> +				       &reg)) {
>> +		dev_err(dev, "couldn't get legacy mode register offset\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (of_property_read_u32_index(np, "ti,syscon-unaligned-access", 2,
>> +				       &field)) {
>> +		dev_err(dev, "can't get bit field for setting legacy mode\n");
>> +		return -EINVAL;
>> +	}
> 
> If this remains, it's screaming for a helper function. 
> of_parse_phandle_with_args already exists, but maybe a syscon specific 
> function is in order.

hmm, I guess for now I can use of_parse_phandle_with_args. The number of args
might vary for different platforms/scenarios?

Thanks
Kishon

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
