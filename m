Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2 6/9] PCI: dwc: Define maximum number of vectors
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <cover.1523266508.git.gustavo.pimentel@synopsys.com>
 <bf7062c863f33b2951acc586b1f22d3497ee2f10.1523266508.git.gustavo.pimentel@synopsys.com>
 <20180409160356.GA14533@e107981-ln.cambridge.arm.com>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <a75bab38-55b7-b788-5ab4-b777fad2b7ff@synopsys.com>
Date: Tue, 10 Apr 2018 08:59:30 +0100
MIME-Version: 1.0
In-Reply-To: <20180409160356.GA14533@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

On 09/04/2018 17:03, Lorenzo Pieralisi wrote:
> On Mon, Apr 09, 2018 at 10:41:15AM +0100, Gustavo Pimentel wrote:
>> Adds a callback that defines the maximum number of vectors that can be use
>> by the Root Complex.
>>
>> Since this is a parameter associated to each SoC IP setting, makes sense to
>> be configurable and easily visible to future modifications.
>>
>> The designware IP supports a maximum of 256 vectors.
> 
> I think that a DT property instead of a callback would have made more
> sense - I struggle to see the point in defining a callback to initialize
> a variable, this can be done in the generic dwc code (and a DT binding).

The addition of this callback was done in MSI-X patch series before I take over
the PCIe Designware driver responsibility. However I remember a thread in which
this subject was discussed (see [1]), maybe this could bring some light about
the motive why is was done like this. If you don't agree I can do patch after
this series only focusing on this topic in order to do like to suggested.

[1] -> https://www.spinics.net/lists/linux-pci/msg61835.html
> 
> Lorenzo
> 
>> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>> ---
>> Change v1->v2:
>> - Nothing changed, just to follow the patch set version.
>>
>>  drivers/pci/dwc/pcie-designware-plat.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/pci/dwc/pcie-designware-plat.c b/drivers/pci/dwc/pcie-designware-plat.c
>> index 5382a7a..94da252 100644
>> --- a/drivers/pci/dwc/pcie-designware-plat.c
>> +++ b/drivers/pci/dwc/pcie-designware-plat.c
>> @@ -48,8 +48,14 @@ static int dw_plat_pcie_host_init(struct pcie_port *pp)
>>  	return 0;
>>  }
>>  
>> +static void dw_plat_set_num_vectors(struct pcie_port *pp)
>> +{
>> +	pp->num_vectors = MAX_MSI_IRQS;
>> +}
>> +
>>  static const struct dw_pcie_host_ops dw_plat_pcie_host_ops = {
>>  	.host_init = dw_plat_pcie_host_init,
>> +	.set_num_vectors = dw_plat_set_num_vectors,
>>  };
>>  
>>  static int dw_plat_pcie_establish_link(struct dw_pcie *pci)
>> -- 
>> 2.7.4
>>
>>

Regards,
Gustavo
