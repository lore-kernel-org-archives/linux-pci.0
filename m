Return-Path: <SRS0=k5ZW=7F=synopsys.com=CARLOS.PALMINHA@kernel.org>
Return-Path: <SRS0=k5ZW=7F=synopsys.com=CARLOS.PALMINHA@kernel.org>
Subject: Re: [PATCH] PCI: dwc: designware: make dw_pcie_prog_*_atu_unroll()
 static
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20170717131334.1761-1-palminha@synopsys.com>
 <20170802215011.GN20308@bhelgaas-glaptop.roam.corp.google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bhelgaas@google.com>, <jingoohan1@gmail.com>, <Joao.Pinto@synopsys.com>
From: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Message-ID: <2f93b254-2702-07b2-f5eb-26df4fa8abe0@synopsys.com>
Date: Thu, 3 Aug 2017 09:51:30 +0100
MIME-Version: 1.0
In-Reply-To: <20170802215011.GN20308@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-pci.vger.kernel.org>

thanks

On 02-08-2017 22:50, Bjorn Helgaas wrote:
> On Mon, Jul 17, 2017 at 02:13:34PM +0100, Carlos Palminha wrote:
>> Helper functions dw_pcie_prog_*_atu_unroll don't need to be in global scope,
>> so make it static.
>>
>> Cleans up sparse warnings:
>> - symbol 'dw_pcie_prog_outbound_atu_unroll' was not declared. Should it be static?
>> - symbol 'dw_pcie_prog_inbound_atu_unroll' was not declared. Should it be static?
>>
>> Signed-off-by: Carlos Palminha <palminha@synopsys.com>
> 
> Applied with acks from Joao and Jingoo to pci/host-designware for v4.14,
> thanks!
> 
> I rewrapped these so they still fit in 80 columns, like the rest of the
> file.
> 
>> ---
>> Patch made against linux-next tree, tag next-20170714
>>
>>  drivers/pci/dwc/pcie-designware.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-designware.c
>> index 0e03af279259..48d6d0712ea8 100644
>> --- a/drivers/pci/dwc/pcie-designware.c
>> +++ b/drivers/pci/dwc/pcie-designware.c
>> @@ -107,7 +107,7 @@ static void dw_pcie_writel_ob_unroll(struct dw_pcie *pci, u32 index, u32 reg,
>>  	dw_pcie_writel_dbi(pci, offset + reg, val);
>>  }
>>
>> -void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, int index, int type,
>> +static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, int index, int type,
>>  				      u64 cpu_addr, u64 pci_addr, u32 size)
>>  {
>>  	u32 retries, val;
>> @@ -200,7 +200,7 @@ static void dw_pcie_writel_ib_unroll(struct dw_pcie *pci, u32 index, u32 reg,
>>  	dw_pcie_writel_dbi(pci, offset + reg, val);
>>  }
>>
>> -int dw_pcie_prog_inbound_atu_unroll(struct dw_pcie *pci, int index, int bar,
>> +static int dw_pcie_prog_inbound_atu_unroll(struct dw_pcie *pci, int index, int bar,
>>  				    u64 cpu_addr, enum dw_pcie_as_type as_type)
>>  {
>>  	int type;
>> --
>> 2.11.0
>>
