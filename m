Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:14320 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752082AbeDQJVT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Apr 2018 05:21:19 -0400
Subject: Re: [PATCH v4 03/10] PCI: endpoint: functions/pci-epf-test: Add
 second entry
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <Joao.Pinto@synopsys.com>, <jingoohan1@gmail.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
References: <cover.1523881182.git.gustavo.pimentel@synopsys.com>
 <d025236bb2646eb3b4d4de9f2e745cab5d7ef2b9.1523881182.git.gustavo.pimentel@synopsys.com>
 <56bdafe6-1725-6e55-68a4-38667f114e5c@ti.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <4336d1a4-e2d0-ebdb-93cd-1f741ff3d19c@ti.com>
Date: Tue, 17 Apr 2018 14:51:08 +0530
MIME-Version: 1.0
In-Reply-To: <56bdafe6-1725-6e55-68a4-38667f114e5c@ti.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Tuesday 17 April 2018 02:49 PM, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Monday 16 April 2018 08:07 PM, Gustavo Pimentel wrote:
>> Adds a seconds entry on the pci_epf_test_ids structure that disables the
>> linkup_notifier parameter on driver.
>>
>> This allows EPs that doesn't have linkup notification signal to work
>> with pcitest.
>>
>> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>> ---
>> Change v2->v3:
>>  - Added second entry in pci_epf_test_ids structure.
>>  - Remove test_reg_bar field assignment on second entry.
>> Changes v3->v4:
>> - Nothing changed, just to follow the patch set version.
>>
>>  drivers/pci/endpoint/functions/pci-epf-test.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
>> index 7cef851..63dca44 100644
>> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
>> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
>> @@ -459,10 +459,18 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>>  	return 0;
>>  }
>>  
>> +static const struct pci_epf_test_data data_cfg2 = {
>> +	.linkup_notifier = false
>> +};
>> +
>>  static const struct pci_epf_device_id pci_epf_test_ids[] = {
>>  	{
>>  		.name = "pci_epf_test",
>>  	},
>> +	{
>> +		.name = "pci_epf_test_cfg2",
> 
> I'd prefer this to be named pci_epf_test_designware so that configfs entry is
> self explanatory.

Please document the new epf binding in
Documentation/PCI/endpoint/function/binding/pci-test.txt

Thanks
Kishon
