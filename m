Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v4 06/10] pci-epf-test/pci_endpoint_test: Cleanup
 PCI_ENDPOINT_TEST memspace
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "adouglas@cadence.com" <adouglas@cadence.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1529329262.git.gustavo.pimentel@synopsys.com>
 <13077810f3630c01835041e41b338dd85fa91953.1529329262.git.gustavo.pimentel@synopsys.com>
 <eea616bd-a5dd-f8bb-22b3-319401c70cc6@ti.com>
From: Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Message-ID: <83b41df3-22eb-e4ba-4b45-840c23051f1d@synopsys.com>
Date: Wed, 20 Jun 2018 15:18:27 +0100
MIME-Version: 1.0
In-Reply-To: <eea616bd-a5dd-f8bb-22b3-319401c70cc6@ti.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On 20/06/2018 08:53, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Monday 18 June 2018 08:30 PM, Gustavo Pimentel wrote:
>> Cleanup PCI_ENDPOINT_TEST memspace (by moving the interrupt number away
>> from command section).
>>
>> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>> ---
>> Change v2->v3:
>>  - New patch file created base on the previous patch
>> "misc: pci_endpoint_test: Add MSI-X support" patch file following
>> Kishon's suggestion.
>> Change v3->v4:
>>  - Rebased to Lorenzo's master branch v4.18-rc1.
>>
>>  drivers/misc/pci_endpoint_test.c              | 84 ++++++++++++++++-----------
>>  drivers/pci/endpoint/functions/pci-epf-test.c | 60 ++++++++++++-------
>>  2 files changed, 91 insertions(+), 53 deletions(-)
>>
>> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
>> index 7b37046..56be808 100644
>> --- a/drivers/misc/pci_endpoint_test.c
>> +++ b/drivers/misc/pci_endpoint_test.c
>> @@ -35,38 +35,42 @@
>>  
>>  #include <uapi/linux/pcitest.h>
>>  
>> -#define DRV_MODULE_NAME			"pci-endpoint-test"
>> -
>> -#define PCI_ENDPOINT_TEST_MAGIC		0x0
>> -
>> -#define PCI_ENDPOINT_TEST_COMMAND	0x4
>> -#define COMMAND_RAISE_LEGACY_IRQ	BIT(0)
>> -#define COMMAND_RAISE_MSI_IRQ		BIT(1)
>> -#define MSI_NUMBER_SHIFT		2
>> -/* 6 bits for MSI number */
>> -#define COMMAND_READ                    BIT(8)
>> -#define COMMAND_WRITE                   BIT(9)
>> -#define COMMAND_COPY                    BIT(10)
>> -
>> -#define PCI_ENDPOINT_TEST_STATUS	0x8
>> -#define STATUS_READ_SUCCESS             BIT(0)
>> -#define STATUS_READ_FAIL                BIT(1)
>> -#define STATUS_WRITE_SUCCESS            BIT(2)
>> -#define STATUS_WRITE_FAIL               BIT(3)
>> -#define STATUS_COPY_SUCCESS             BIT(4)
>> -#define STATUS_COPY_FAIL                BIT(5)
>> -#define STATUS_IRQ_RAISED               BIT(6)
>> -#define STATUS_SRC_ADDR_INVALID         BIT(7)
>> -#define STATUS_DST_ADDR_INVALID         BIT(8)
>> -
>> -#define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0xc
>> +#define DRV_MODULE_NAME				"pci-endpoint-test"
>> +
>> +#define IRQ_TYPE_LEGACY				0
>> +#define IRQ_TYPE_MSI				1
>> +
>> +#define PCI_ENDPOINT_TEST_MAGIC			0x0
>> +
>> +#define PCI_ENDPOINT_TEST_COMMAND		0x4
>> +#define COMMAND_RAISE_LEGACY_IRQ		BIT(0)
>> +#define COMMAND_RAISE_MSI_IRQ			BIT(1)
> 
> Maybe you can add a comment here that BIT(2) is reserved for MSIX support

Sure.

>> +#define COMMAND_READ				BIT(3)
>> +#define COMMAND_WRITE				BIT(4)
>> +#define COMMAND_COPY				BIT(5)
>> +
>> +#define PCI_ENDPOINT_TEST_STATUS		0x8
>> +#define STATUS_READ_SUCCESS			BIT(0)
>> +#define STATUS_READ_FAIL			BIT(1)
>> +#define STATUS_WRITE_SUCCESS			BIT(2)
>> +#define STATUS_WRITE_FAIL			BIT(3)
>> +#define STATUS_COPY_SUCCESS			BIT(4)
>> +#define STATUS_COPY_FAIL			BIT(5)
>> +#define STATUS_IRQ_RAISED			BIT(6)
>> +#define STATUS_SRC_ADDR_INVALID			BIT(7)
>> +#define STATUS_DST_ADDR_INVALID			BIT(8)
>> +
>> +#define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0x0c
>>  #define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR	0x10
>>  
>>  #define PCI_ENDPOINT_TEST_LOWER_DST_ADDR	0x14
>>  #define PCI_ENDPOINT_TEST_UPPER_DST_ADDR	0x18
>>  
>> -#define PCI_ENDPOINT_TEST_SIZE		0x1c
>> -#define PCI_ENDPOINT_TEST_CHECKSUM	0x20
>> +#define PCI_ENDPOINT_TEST_SIZE			0x1c
>> +#define PCI_ENDPOINT_TEST_CHECKSUM		0x20
>> +
>> +#define PCI_ENDPOINT_TEST_IRQ_TYPE		0x24
> 
> Is this not redundant? COMMAND_RAISE_LEGACY_IRQ, COMMAND_RAISE_MSI_IRQ already
> indicates the irq type to be used.

In previous implementation the distinction between interrupt types was simpler,
basically legacy *number* always set as zero and the MSI *number* always
non-zero. However by introducing the MSI-X this simple mechanism is no longer
valid, because the MSI-X *number* is also always non-zero like as MSI.
Therefore is necessary to distinguish which interrupt type was been triggered
(MSI or MSI-X) especially for the Write/Read/Copy tests.


>> +#define PCI_ENDPOINT_TEST_IRQ_NUMBER		0x28
>>  
>>  static DEFINE_IDA(pci_endpoint_test_ida);
>>  
>> @@ -179,6 +183,9 @@ static bool pci_endpoint_test_legacy_irq(struct pci_endpoint_test *test)
>>  {
>>  	u32 val;
>>  
>> +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE,
>> +				 IRQ_TYPE_LEGACY);
>> +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 0);
> 
> Not sure if the above writes are really required.

Is not required, but I added those write for keeping the code coherency between
pci_endpoint_test_legacy_irq() and pci_endpoint_test_msi_irq(), basically both
functions write on the same registers. I think it doesn't cause any harm.

>>  	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
>>  				 COMMAND_RAISE_LEGACY_IRQ);
>>  	val = wait_for_completion_timeout(&test->irq_raised,
>> @@ -190,20 +197,22 @@ static bool pci_endpoint_test_legacy_irq(struct pci_endpoint_test *test)
>>  }
>>  
>>  static bool pci_endpoint_test_msi_irq(struct pci_endpoint_test *test,
>> -				      u8 msi_num)
>> +				      u8 irq_num)
> 
> why do you want to rename this?

Initially this patch file contained the changes related to MSI-X support and by
that time I had changed the name of this variable so that its name had a broader
meaning that contemplated these two types. Now that I see this, I think the
original name may also be valid, I will revert this name change.

Regards,
Gustavo

> 
> Thanks
> Kishon
> 
