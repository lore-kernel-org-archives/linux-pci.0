Return-Path: <Joao.Pinto@synopsys.com>
Return-Path: <Joao.Pinto@synopsys.com>
Subject: Re: [PATCH 1/2] pci: pcie-designware: Change Maintenance
To: Bjorn Helgaas <helgaas@kernel.org>, Joao Pinto <Joao.Pinto@synopsys.com>
References: <c4b8fcc50069ce8ea2091100e52a68dcc30e1021.1479224720.git.jpinto@synopsys.com>
 <20161116221825.GA16042@bhelgaas-glaptop.roam.corp.google.com>
CC: <bhelgaas@google.com>, <pratyush.anand@gmail.com>,
	<CARLOS.PALMINHA@synopsys.com>, <Jose.Abreu@synopsys.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <cf4c9a18-1f3f-e9b1-fe2f-b774c6090321@synopsys.com>
Date: Thu, 17 Nov 2016 14:58:08 +0000
MIME-Version: 1.0
In-Reply-To: <20161116221825.GA16042@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-pci.vger.kernel.org>

On 16-11-2016 22:18, Bjorn Helgaas wrote:
> On Tue, Nov 15, 2016 at 04:10:46PM +0000, Joao Pinto wrote:
>> I accepted the invitation from Pratyush to replace him in the
>> pcie-designware maintenance. This patch makes the maintainer replacement
>> and symplifies a bit the pcie-designware* maintenance structure.
>>
>> Signed-off-by: Joao Pinto <jpinto@synopsys.com>
>> Cc: Pratyush Anand <pratyush.anand@gmail.com>
>> Cc: Jose Abreu <Jose.Abreu@synopsys.com>
> 
> I applied both of these to for-linus for v4.9, thanks, Joao!

Great! Thanks.

> 
>> ---
>>  MAINTAINERS | 10 ++--------
>>  1 file changed, 2 insertions(+), 8 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index aefa6bf..2c64d7c 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -9293,17 +9293,11 @@ F:	drivers/pci/host/pci-exynos.c
>>  
>>  PCI DRIVER FOR SYNOPSIS DESIGNWARE
>>  M:	Jingoo Han <jingoohan1@gmail.com>
>> -M:	Pratyush Anand <pratyush.anand@gmail.com>
>> -L:	linux-pci@vger.kernel.org
>> -S:	Maintained
>> -F:	drivers/pci/host/*designware*
>> -
>> -PCI DRIVER FOR SYNOPSYS PROTOTYPING DEVICE
>> -M:	Jose Abreu <Jose.Abreu@synopsys.com>
>> +M:	Joao Pinto <Joao.Pinto@synopsys.com>
>>  L:	linux-pci@vger.kernel.org
>>  S:	Maintained
>>  F:	Documentation/devicetree/bindings/pci/designware-pcie.txt
>> -F:	drivers/pci/host/pcie-designware-plat.c
>> +F:	drivers/pci/host/*designware*
>>  
>>  PCI DRIVER FOR GENERIC OF HOSTS
>>  M:	Will Deacon <will.deacon@arm.com>
>> -- 
>> 1.8.3.1
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
