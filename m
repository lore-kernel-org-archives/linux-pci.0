Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v5 09/11] pci_endpoint_test: Add 2 ioctl commands
To: Randy Dunlap <rdunlap@infradead.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "adouglas@cadence.com" <adouglas@cadence.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1529507416.git.gustavo.pimentel@synopsys.com>
 <8695864db0191b2e85ed81e97a8990baea3468fa.1529507416.git.gustavo.pimentel@synopsys.com>
 <dd75ced1-e4c3-8c94-3bab-200e2ecdd8b8@infradead.org>
From: Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Message-ID: <f16f99f4-0749-3273-7c5a-7c38503c27a9@synopsys.com>
Date: Thu, 21 Jun 2018 11:23:28 +0100
MIME-Version: 1.0
In-Reply-To: <dd75ced1-e4c3-8c94-3bab-200e2ecdd8b8@infradead.org>
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 20/06/2018 19:12, Randy Dunlap wrote:
> On 06/20/2018 09:28 AM, Gustavo Pimentel wrote:
>> Add MSI-X support and update driver documentation accordingly.
>>
>> Add 2 new IOCTL commands:
>>  - Allow to reconfigure driver IRQ type in runtime.
>>  - Allow to retrieve current driver IRQ type configured.
>>
>> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>> ---
>> Change v2->v3:                                                                              |  --------------------------------------------------------------------------------------------
>>  - New patch file created base on the previous patch                                        |  --------------------------------------------------------------------------------------------
>> "misc: pci_endpoint_test: Add MSI-X support" patch file following                           |  --------------------------------------------------------------------------------------------
>> Kishon's suggestion.                                                                        |  --------------------------------------------------------------------------------------------
>> Change v3->v4:                                                                              |  --------------------------------------------------------------------------------------------
>>  - Rebased to Lorenzo's master branch v4.18-rc1.
>> Change v4->v5:
>>  - Nothing changed, just to follow the patch set version.
>>
>>  Documentation/misc-devices/pci-endpoint-test.txt |   3 +
>>  drivers/misc/pci_endpoint_test.c                 | 177 +++++++++++++++++------
>>  2 files changed, 132 insertions(+), 48 deletions(-)
>>
>> diff --git a/Documentation/misc-devices/pci-endpoint-test.txt b/Documentation/misc-devices/pci-endpoint-test.txt
>> index fdfa0f6..58ccca4 100644
>> --- a/Documentation/misc-devices/pci-endpoint-test.txt
>> +++ b/Documentation/misc-devices/pci-endpoint-test.txt
>> @@ -28,6 +28,9 @@ ioctl
>>  	      to be tested should be passed as argument.
>>   PCITEST_MSIX: Tests message signalled interrupts. The MSI-X number
>>  	      to be tested should be passed as argument.
>> + PCITEST_SET_IRQTYPE: Changes driver IRQ type configuration. The IRQ type
>> +	      should be passed as argument (0: Legacy, 1:MSI, 2:MSI-X).
>> + PCITEST_GET_IRQTYPE: Gets driver IRQ type configuration.
>>   PCITEST_WRITE: Perform write tests. The size of the buffer should be passed
>>  		as argument.
>>   PCITEST_READ: Perform read tests. The size of the buffer should be passed
>> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
>> index 2b58887..82fa0c2 100644
>> --- a/drivers/misc/pci_endpoint_test.c
>> +++ b/drivers/misc/pci_endpoint_test.c
> 
> Hi,
> 
> The ioctl "type" (as "type" is used in <uapi/asm-generic/ioctl.h>),
> value of 'P' in this case, should be documented in
> Documentation/ioctl/ioctl-number.txt.

Hi Randy,

I wasn't aware of this file. Adding the entry bellow would be suitable?

'P'    01-09   drivers/misc/pci_endpoint_test.c        conflict!

Regards,
Gustavo

> 
> thanks,
> 
