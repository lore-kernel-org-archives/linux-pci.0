Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay6.synopsys.com ([198.182.37.59]:60028 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754462AbeDZPiZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Apr 2018 11:38:25 -0400
Subject: Re: [RFC 06/10] misc: pci_endpoint_test: Add MSI-X support
To: Kishon Vijay Abraham I <kishon@ti.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "adouglas@cadence.com" <adouglas@cadence.com>,
        "niklas.cassel@axis.com" <niklas.cassel@axis.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1523379766.git.gustavo.pimentel@synopsys.com>
 <8b88f8c2b766f36c71659deb0fce635154b2b39f.1523379766.git.gustavo.pimentel@synopsys.com>
 <b25dcfb1-e770-e302-d9aa-7c35f6c58fa5@ti.com>
 <c6d1d492-38a0-6a03-7e61-b8b50226734b@synopsys.com>
 <a982ca92-d34c-12ea-30bf-9a9b1661d50d@ti.com>
 <2bd77bf2-1d64-6043-422a-6a96c1a3d3a4@synopsys.com>
 <aa1c6446-bcf4-1cdb-d900-22e5d6fa4cab@ti.com>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <ac362508-8322-e4f0-fb70-d0b76198c7bc@synopsys.com>
Date: Thu, 26 Apr 2018 16:36:42 +0100
MIME-Version: 1.0
In-Reply-To: <aa1c6446-bcf4-1cdb-d900-22e5d6fa4cab@ti.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Kishon,

On 24/04/2018 12:43, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Tuesday 24 April 2018 04:27 PM, Gustavo Pimentel wrote:
>> Hi Kishon,
>>
>> On 24/04/2018 08:19, Kishon Vijay Abraham I wrote:
>>> Hi,
>>>
>>> On Tuesday 17 April 2018 11:08 PM, Gustavo Pimentel wrote:
>>>> Hi Kishon,
>>>>
>>>> On 17/04/2018 11:33, Kishon Vijay Abraham I wrote:
>>>>> Hi,
>>>>>
>>>>> On Tuesday 10 April 2018 10:44 PM, Gustavo Pimentel wrote:
>>>>>> Adds the MSI-X support and updates driver documentation accordingly.
>>>>>>
>>>>>> Changes the driver parameter in order to allow the interruption type
>>>>>> selection.
>>>>>>
>>>>>> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>>>>>> ---
>>>>>>  Documentation/misc-devices/pci-endpoint-test.txt |   3 +
>>>>>>  drivers/misc/pci_endpoint_test.c                 | 102 +++++++++++++++++------
>>>>>>  2 files changed, 79 insertions(+), 26 deletions(-)
>>>>>>
>>>>>> diff --git a/Documentation/misc-devices/pci-endpoint-test.txt b/Documentation/misc-devices/pci-endpoint-test.txt
>>>>>> index 4ebc359..fdfa0f6 100644
>>>>>> --- a/Documentation/misc-devices/pci-endpoint-test.txt
>>>>>> +++ b/Documentation/misc-devices/pci-endpoint-test.txt
>>>>>> @@ -10,6 +10,7 @@ The PCI driver for the test device performs the following tests
>>>>>>  	*) verifying addresses programmed in BAR
>>>>>>  	*) raise legacy IRQ
>>>>>>  	*) raise MSI IRQ
>>>>>> +	*) raise MSI-X IRQ
>>>>>>  	*) read data
>>>>>>  	*) write data
>>>>>>  	*) copy data
>>>>>> @@ -25,6 +26,8 @@ ioctl
>>>>>>   PCITEST_LEGACY_IRQ: Tests legacy IRQ
>>>>>>   PCITEST_MSI: Tests message signalled interrupts. The MSI number
>>>>>>  	      to be tested should be passed as argument.
>>>>>> + PCITEST_MSIX: Tests message signalled interrupts. The MSI-X number
>>>>>> +	      to be tested should be passed as argument.
>>>>>>   PCITEST_WRITE: Perform write tests. The size of the buffer should be passed
>>>>>>  		as argument.
>>>>>>   PCITEST_READ: Perform read tests. The size of the buffer should be passed
>>>>>> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
>>>>>> index 37db0fc..a7d9354 100644
>>>>>> --- a/drivers/misc/pci_endpoint_test.c
>>>>>> +++ b/drivers/misc/pci_endpoint_test.c
>>>>>> @@ -42,11 +42,16 @@
>>>>>>  #define PCI_ENDPOINT_TEST_COMMAND	0x4
>>>>>>  #define COMMAND_RAISE_LEGACY_IRQ	BIT(0)
>>>>>>  #define COMMAND_RAISE_MSI_IRQ		BIT(1)
>>>>>> -#define MSI_NUMBER_SHIFT		2
>>>>>> -/* 6 bits for MSI number */
>>>>>> -#define COMMAND_READ                    BIT(8)
>>>>>> -#define COMMAND_WRITE                   BIT(9)
>>>>>> -#define COMMAND_COPY                    BIT(10)
>>>>>> +#define COMMAND_RAISE_MSIX_IRQ		BIT(2)
>>>>>> +#define IRQ_TYPE_SHIFT			3
>>>>>> +#define IRQ_TYPE_LEGACY			0
>>>>>> +#define IRQ_TYPE_MSI			1
>>>>>> +#define IRQ_TYPE_MSIX			2
>>>>>> +#define MSI_NUMBER_SHIFT		5
>>>>>
>>>>> Now that you are anyways fixing this, add a new register entry for MSI numbers.
>>>>> Let's not keep COMMAND and MSI's together.
>>>>
>>>> What you suggest?
>>>
>>> #define PCI_ENDPOINT_TEST_COMMAND	0x4
>>> #define COMMAND_RAISE_LEGACY_IRQ	BIT(0)
>>> #define COMMAND_RAISE_MSI_IRQ		BIT(1)
>>> #define COMMAND_RAISE_MSIX_IRQ		BIT(2)
>>> #define COMMAND_READ                    BIT(3)
>>> #define COMMAND_WRITE                   BIT(4)
>>> #define COMMAND_COPY                    BIT(5)
>>>
>>> #define PCI_ENDPOINT_TEST_STATUS	0x8
>>> #define STATUS_READ_SUCCESS             BIT(0)
>>> #define STATUS_READ_FAIL                BIT(1)
>>> #define STATUS_WRITE_SUCCESS            BIT(2)
>>> #define STATUS_WRITE_FAIL               BIT(3)
>>> #define STATUS_COPY_SUCCESS             BIT(4)
>>> #define STATUS_COPY_FAIL                BIT(5)
>>> #define STATUS_IRQ_RAISED               BIT(6)
>>> #define STATUS_SRC_ADDR_INVALID         BIT(7)
>>> #define STATUS_DST_ADDR_INVALID         BIT(8)
>>>
>>> #define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0xc
>>> #define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR	0x10
>>>
>>> #define PCI_ENDPOINT_TEST_LOWER_DST_ADDR	0x14
>>> #define PCI_ENDPOINT_TEST_UPPER_DST_ADDR	0x18
>>>
>>> #define PCI_ENDPOINT_TEST_SIZE		0x1c
>>> #define PCI_ENDPOINT_TEST_CHECKSUM	0x20
>>>
>>> #define PCI_ENDPOINT_TEST_MSI_NUMBER	0x24
>>
>> Ok. I will do it.
>>
>>>
>>> We should try not to modify either the existing register offsets or the bit
>>> fields within these registers in the future as EP and RC will be running on
>>> different systems and it is possible one of them might not have the updated
>>> kernel.
>>
>> I totally agree.
>>
>>>>
>>>>>> +/* 12 bits for MSI number */
>>>>>> +#define COMMAND_READ                    BIT(17)
>>>>>> +#define COMMAND_WRITE                   BIT(18)
>>>>>> +#define COMMAND_COPY                    BIT(19)
>>>>>
>>>>> This change should be done along with the pci-epf-test in a single patch.
>>>>
>>>> To be clear, you're saying is this patch should be just be squashed into the
>>>> patch number 8 [1], because there is a lot of dependencies namely the defines,
>>>> that is used on the alter functions.
>>>>
>>>> [1] -> https://urldefense.proofpoint.com/v2/url?u=https-3A__patchwork.ozlabs.org_patch_896841_&d=DwIC-g&c=DPL6_X_6JkXFx7AXWqB0tg&r=bkWxpLoW-f-E3EdiDCCa0_h0PicsViasSlvIpzZvPxs&m=8urVwHCybXa1XMxsEbwHZAzzaEI_HJGXqmWgXpXb9TY&s=MRVr2YPY2Bk_WNFOxBfU4FGrFReTKdPhfzNDLiVxDbs&e=
>>>
>>> yeah. We have to make sure git bisect doesn't break functionality.
>>
>> Ok, it'll be squashed.
>>
>>>>
>>>>>>  
>>>>>>  #define PCI_ENDPOINT_TEST_STATUS	0x8
>>>>>>  #define STATUS_READ_SUCCESS             BIT(0)
>>>>>> @@ -73,9 +78,9 @@ static DEFINE_IDA(pci_endpoint_test_ida);
>>>>>>  #define to_endpoint_test(priv) container_of((priv), struct pci_endpoint_test, \
>>>>>>  					    miscdev)
>>>>>>  
>>>>>> -static bool no_msi;
>>>>>> -module_param(no_msi, bool, 0444);
>>>>>> -MODULE_PARM_DESC(no_msi, "Disable MSI interrupt in pci_endpoint_test");
>>>>>
>>>>> Let's not remove this just to make sure existing users doesn't get affected.
>>>>
>>>> Hum, by making an internal conversion? Like this
>>>> no_msi = false <=> irq_type = 1
>>>> no_msi = true <=> irq_type = 0
>>>
>> Disregard previous comment, it doesn't make sense. I don't know where my head was.
>>
>> It will be like this on probe:
>>
>> if (no_msi)
>> 	irq_type = IRQ_TYPE_LEGACY;
>>
>> However since we are breaking the compatibility on terms of MSI/MSI-X
>> bits/registers (discussion on the top), it makes sense to keep the compatibility
>> on this parameter?
> 
> This is userspace compatibility, so lets not break it.
> Btw can we have a sysfs entry per device for defining irq_type. Having a sysfs
> entry might be helpful instead of insmod/rmmod with different irq_type values?

Can you explain it? An sysfs entry where, on RC side? How this will work with
the irq allocation/deallocation in runtime?

> It will also help if a system has enumerated multiple PCI_ENDPOINT_TEST EP devices.

Can you elaborate more this idea?

> 
> Thanks
> Kishon
> 

Regards,
Gustavo
