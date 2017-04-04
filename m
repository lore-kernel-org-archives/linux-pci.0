Return-Path: <SRS0=iBhS=3M=semihalf.com=tn@kernel.org>
Return-Path: <SRS0=iBhS=3M=semihalf.com=tn@kernel.org>
Subject: Re: [PATCH 1/1] PCI: Fix for PEM-specific resource reservation for
 legacy firmware case
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1490972804-25830-1-git-send-email-tn@semihalf.com>
 <20170403201814.GA13232@bhelgaas-glaptop.roam.corp.google.com>
Cc: Lorenzo.Pieralisi@arm.com, robert.richter@caviumnetworks.com,
 ddaney@caviumnetworks.com, Vadim.Lomovtsev@caviumnetworks.com,
 rafael@kernel.org, Sunil.Goutham@cavium.com, geethasowjanya.akula@gmail.com,
 linu.cherian@cavium.com, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <4aece958-583e-ad86-7923-87d501a4c1c7@semihalf.com>
Date: Tue, 4 Apr 2017 07:12:06 +0200
MIME-Version: 1.0
In-Reply-To: <20170403201814.GA13232@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 03.04.2017 22:18, Bjorn Helgaas wrote:
> On Fri, Mar 31, 2017 at 05:06:44PM +0200, Tomasz Nowicki wrote:
>> SZ_16M PEM resource size includes PEM-specific register and its children
>> resources. Reservation of the whole SZ_16M range leads to child device
>> driver failure when pcieport driver is requesting resources:
>> pcieport 0004:1f:00.0: can't enable device: BAR 0 [mem 0x87e0c0f00000-0x87e0c0ffffff 64bit] not claimed
>> So we cannot reserve full 16M here and instead we want to reserve
>> PEM-specific register only which is SZ_64K.
>>
>> At the end increase PEM resource to SZ_16M since this is what
>> thunder_pem_init() call expects for proper initialization.
>>
>> Fixes: 9abb27c7594a ("PCI: thunder-pem: Add legacy firmware support for Cavium ThunderX host controller")
>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>> CC: stable@vger.kernel.org	# v4.10+
>
> Applied to for-linus for v4.11, thanks!

Thanks Bjorn.

Tomasz

>
>> ---
>>  drivers/pci/host/pci-thunder-pem.c | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/host/pci-thunder-pem.c b/drivers/pci/host/pci-thunder-pem.c
>> index b89c373..6e031b5 100644
>> --- a/drivers/pci/host/pci-thunder-pem.c
>> +++ b/drivers/pci/host/pci-thunder-pem.c
>> @@ -375,7 +375,6 @@ static void thunder_pem_legacy_fw(struct acpi_pci_root *root,
>>  	index -= node * PEM_MAX_DOM_IN_NODE;
>>  	res_pem->start = PEM_RES_BASE | FIELD_PREP(PEM_NODE_MASK, node) |
>>  					FIELD_PREP(PEM_INDX_MASK, index);
>> -	res_pem->end = res_pem->start + SZ_16M - 1;
>>  	res_pem->flags = IORESOURCE_MEM;
>>  }
>>
>> @@ -399,8 +398,15 @@ static int thunder_pem_acpi_init(struct pci_config_window *cfg)
>>  	 */
>>  	if (ret) {
>>  		thunder_pem_legacy_fw(root, res_pem);
>> -		/* Reserve PEM-specific resources and PCI configuration space */
>> +		/*
>> +		 * Reserve 64K size PEM specific resources. The full 16M range
>> +		 * size is required for thunder_pem_init() call.
>> +		 */
>> +		res_pem->end = res_pem->start + SZ_64K - 1;
>>  		thunder_pem_reserve_range(dev, root->segment, res_pem);
>> +		res_pem->end = res_pem->start + SZ_16M - 1;
>> +
>> +		/* Reserve PCI configuration space as well. */
>>  		thunder_pem_reserve_range(dev, root->segment, &cfg->res);
>>  	}
>>
>> --
>> 2.7.4
>>
