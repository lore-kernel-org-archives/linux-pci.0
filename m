Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay6.synopsys.com ([198.182.37.59]:52251 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755056AbeD3QiA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Apr 2018 12:38:00 -0400
Subject: Re: [PATCH v8 3/9] PCI: endpoint: functions/pci-epf-test: Add second
 entry
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
References: <cover.1524829928.git.gustavo.pimentel@synopsys.com>
 <c2b6cb8de2502e1b5352be3b6d687b1cb4b7033a.1524829928.git.gustavo.pimentel@synopsys.com>
 <20180430142213.GC32033@e107981-ln.cambridge.arm.com>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <425dfb4f-b249-8496-aa9f-d2a48d0b64b9@synopsys.com>
Date: Mon, 30 Apr 2018 17:36:42 +0100
MIME-Version: 1.0
In-Reply-To: <20180430142213.GC32033@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

On 30/04/2018 15:22, Lorenzo Pieralisi wrote:
> On Fri, Apr 27, 2018 at 12:59:58PM +0100, Gustavo Pimentel wrote:
>> Add a seconds entry on the pci_epf_test_ids structure that disables the
> 
> "Add a second entry..."

Fixed, sorry for letting it slip...

> 
>> linkup_notifier parameter on driver for the DesignWare EP.
>>
>> Allow DesignWare EPs that doesn't have linkup notification signal to work
>> with pcitest.
>>
>> Update the binding documentation accordingly.
>>
>> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>> Change v2->v3:
>>  - Added second entry in pci_epf_test_ids structure.
>>  - Remove test_reg_bar field assignment on second entry.
>> Changes v3->v4:
>>  - Nothing changed, just to follow the patch set version.
>> Changes v4->v5:
>>  - Changed pci_epf_test_cfg2 to pci_epf_test_designware.
>> Changes v5->v6:
>>  - Changed name field from pci_epf_test_designware to pci_epf_test_dw.
>> Changes v6->v7:
>>  - Changed variable name from data_cfg2 to data_linkup_notifier_disabled.
>> Changes v7->v8:
>>  - Patch description rework for an imperative verbal mode.
>>
>>  Documentation/PCI/endpoint/function/binding/pci-test.txt | 2 ++
>>  drivers/pci/endpoint/functions/pci-epf-test.c            | 8 ++++++++
>>  2 files changed, 10 insertions(+)
>>
>> diff --git a/Documentation/PCI/endpoint/function/binding/pci-test.txt b/Documentation/PCI/endpoint/function/binding/pci-test.txt
>> index 3b68b95..dc39f47 100644
>> --- a/Documentation/PCI/endpoint/function/binding/pci-test.txt
>> +++ b/Documentation/PCI/endpoint/function/binding/pci-test.txt
>> @@ -1,6 +1,8 @@
>>  PCI TEST ENDPOINT FUNCTION
>>  
>>  name: Should be "pci_epf_test" to bind to the pci_epf_test driver.
>> +name: Should be "pci_epf_test_dw" to bind to the pci_epf_test driver
>> +      with a custom configuration for the designware EP.
>>  
>>  Configurable Fields:
>>  vendorid	 : should be 0x104c
>> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
>> index 7cef851..4ab463b 100644
>> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
>> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
>> @@ -459,10 +459,18 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>>  	return 0;
>>  }
>>  
>> +static const struct pci_epf_test_data data_linkup_notifier_disabled = {
>> +	.linkup_notifier = false
>> +};
>> +
>>  static const struct pci_epf_device_id pci_epf_test_ids[] = {
>>  	{
>>  		.name = "pci_epf_test",
>>  	},
>> +	{
>> +		.name = "pci_epf_test_dw",
>> +		.driver_data = (kernel_ulong_t)&data_linkup_notifier_disabled,
> 
> You have not answered my question on this though:
> 
> https://urldefense.proofpoint.com/v2/url?u=https-3A__marc.info_-3Fl-3Dlinux-2Dpci-26m-3D152476180723047-26w-3D2&d=DwIBAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=bkWxpLoW-f-E3EdiDCCa0_h0PicsViasSlvIpzZvPxs&m=KsCYNT_jNohKd03qgHN_Q73bRDsN78isEgeuYF8SypU&s=N1gpsLtS4or3TlSamRxP49rYAJv6gjEq7apuhN7paLs&e=

I did not see those questions, sorry. I will respond on top of that email.

Regards,
Gustavo

> 
>> +	},
>>  	{},
>>  };
>>  
>> -- 
>> 2.7.4
>>
>>
> 
