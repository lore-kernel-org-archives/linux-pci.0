Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:31482 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752410AbeDCK46 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Apr 2018 06:56:58 -0400
Subject: Re: [PATCH 4/8] misc: pci_endpoint_test: Add designware EP entry
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
References: <cover.1522235224.git.gustavo.pimentel@synopsys.com>
 <1bc09dfd205d0721366267e023550c4a5a4a84db.1522235224.git.gustavo.pimentel@synopsys.com>
 <76c6e35c-5659-7313-a1b4-aa93e323ef79@ti.com>
 <77999353-fd50-b90f-ab00-b2cd29048257@synopsys.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <90dce42c-f128-3135-be9a-77c9aec9482e@ti.com>
Date: Tue, 3 Apr 2018 16:26:48 +0530
MIME-Version: 1.0
In-Reply-To: <77999353-fd50-b90f-ab00-b2cd29048257@synopsys.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Tuesday 03 April 2018 03:41 PM, Gustavo Pimentel wrote:
> Hi Kishon,
> 
> On 02/04/2018 06:36, Kishon Vijay Abraham I wrote:
>> Hi,
>>
>> On Wednesday 28 March 2018 05:08 PM, Gustavo Pimentel wrote:
>>> Adds the designware EP device ID entry to pci_endpoint_test driver table
>>> to allow this device to be recognize and handle by the pci_endpoint_test
>>> driver.
>>>
>>> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>>> ---
>>>  drivers/misc/pci_endpoint_test.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
>>> index 320276f..e80c533 100644
>>> --- a/drivers/misc/pci_endpoint_test.c
>>> +++ b/drivers/misc/pci_endpoint_test.c
>>> @@ -632,6 +632,7 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
>>>  static const struct pci_device_id pci_endpoint_test_tbl[] = {
>>>  	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA74x) },
>>>  	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA72x) },
>>> +	{ PCI_DEVICE(PCI_VENDOR_ID_SYNOPSYS, 0xedda) },
>>
>> Add device ids to include/linux/pci_ids.h and use the macro here.
> 
> Add device id request sent, as soon as I get a positive confirmation from them
> I'll change for the macro. It works for you?

IMO only confirmed device ID's should be used.

Thanks
Kishon
