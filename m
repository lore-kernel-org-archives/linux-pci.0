Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.37.59]:52008 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752838AbeFTOak (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jun 2018 10:30:40 -0400
Subject: Re: [PATCH v4 09/10] pci_endpoint_test: Add 2 ioctl commands
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
 <b10530671bdcda8b9d2bb25048ad9048f814c608.1529329262.git.gustavo.pimentel@synopsys.com>
 <327bcbd0-b2a0-d1eb-5471-e6e63169fc8d@ti.com>
From: Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Message-ID: <f6335b77-186e-9df9-bcc6-bbc9a31c87b9@synopsys.com>
Date: Wed, 20 Jun 2018 15:28:33 +0100
MIME-Version: 1.0
In-Reply-To: <327bcbd0-b2a0-d1eb-5471-e6e63169fc8d@ti.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On 20/06/2018 08:58, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Monday 18 June 2018 08:30 PM, Gustavo Pimentel wrote:
>> Add MSI-X support and update driver documentation accordingly.
>>
>> Add 2 new IOCTL commands:
>>  - Allow to reconfigure driver IRQ type in runtime.
>>  - Allow to retrieve current driver IRQ type configured.
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
>> index 8d15dbe..df2017f 100644
>> --- a/drivers/misc/pci_endpoint_test.c
>> +++ b/drivers/misc/pci_endpoint_test.c
>> @@ -157,6 +157,87 @@ static irqreturn_t pci_endpoint_test_irqhandler(int irq, void *dev_id)
>>  	return IRQ_HANDLED;
>>  }
>>  
>> +static void pci_endpoint_test_free_irq_vectors(struct pci_endpoint_test *test)
>> +{
>> +	int i;
>> +	struct pci_dev *pdev = test->pdev;
>> +	struct device *dev = &pdev->dev;
>> +
>> +	for (i = 0; i < test->num_irqs; i++)
>> +		devm_free_irq(dev, pci_irq_vector(pdev, i), test);
>> +
>> +	test->num_irqs = 0;
>> +}
>> +
>> +static bool pci_endpoint_test_alloc_irq_vectors(struct pci_endpoint_test *test)
>> +{
>> +	int irq = -1;
>> +	struct pci_dev *pdev = test->pdev;
>> +	struct device *dev = &pdev->dev;
>> +	bool res = true;
>> +
>> +	switch (irq_type) {
>> +	case IRQ_TYPE_LEGACY:
>> +		irq = 0;
>> +		break;
>> +	case IRQ_TYPE_MSI:
>> +		irq = pci_alloc_irq_vectors(pdev, 1, 32, PCI_IRQ_MSI);
>> +		if (irq < 0)
>> +			dev_err(dev, "Failed to get MSI interrupts\n");
>> +		break;
>> +	case IRQ_TYPE_MSIX:
>> +		irq = pci_alloc_irq_vectors(pdev, 1, 2048, PCI_IRQ_MSIX);
>> +		if (irq < 0)
>> +			dev_err(dev, "Failed to get MSI-X interrupts\n");
>> +		break;
>> +	default:
>> +		dev_err(dev, "Invalid IRQ type selected\n");
>> +	}
>> +
>> +	if (irq < 0) {
>> +		irq = 0;
>> +		res = false;
>> +	}
>> +	test->num_irqs = irq;
>> +
>> +	return res;
>> +}
>> +
>> +static void pci_endpoint_test_release_irq(struct pci_endpoint_test *test)
>> +{
>> +	struct pci_dev *pdev = test->pdev;
>> +
>> +	pci_disable_msi(pdev);
>> +	pci_disable_msix(pdev);
>> +}
>> +
>> +static bool pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
>> +{
>> +	int i;
>> +	int err;
>> +	struct pci_dev *pdev = test->pdev;
>> +	struct device *dev = &pdev->dev;
>> +
>> +	err = devm_request_irq(dev, pdev->irq, pci_endpoint_test_irqhandler,
>> +			       IRQF_SHARED, DRV_MODULE_NAME, test);
>> +	if (err) {
>> +		dev_err(dev, "Failed to request IRQ %d\n", pdev->irq);
>> +		return false;
>> +	}
>> +
>> +	for (i = 1; i < test->num_irqs; i++) {
>> +		err = devm_request_irq(dev, pci_irq_vector(pdev, i),
>> +				       pci_endpoint_test_irqhandler,
>> +				       IRQF_SHARED, DRV_MODULE_NAME, test);
>> +		if (err)
>> +			dev_err(dev, "Failed to request IRQ %d for MSI%s %d\n",
>> +				pci_irq_vector(pdev, i),
>> +				irq_type == IRQ_TYPE_MSIX ? "-X" : "", i + 1);
>> +	}
>> +
>> +	return true;
>> +}
>> +
>>  static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
>>  				  enum pci_barno barno)
>>  {
>> @@ -440,6 +521,38 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test, size_t size)
>>  	return ret;
>>  }
>>  
>> +static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
>> +				      int req_irq_type)
>> +{
>> +	struct pci_dev *pdev = test->pdev;
>> +	struct device *dev = &pdev->dev;
>> +
>> +	if (req_irq_type < IRQ_TYPE_LEGACY || req_irq_type > IRQ_TYPE_MSIX) {
>> +		dev_err(dev, "Invalid IRQ type option\n");
>> +		return false;
>> +	}
>> +
>> +	if (irq_type == req_irq_type)
>> +		return true;
>> +
>> +	irq_type = req_irq_type;
>> +
>> +	pci_endpoint_test_free_irq_vectors(test);
>> +	pci_endpoint_test_release_irq(test);
>> +
>> +	if (!pci_endpoint_test_alloc_irq_vectors(test)) {
>> +		pci_endpoint_test_release_irq(test);
>> +		return false;
>> +	}
>> +
>> +	if (!pci_endpoint_test_request_irq(test)) {
>> +		pci_endpoint_test_release_irq(test);
>> +		return false;
>> +	}
>> +
>> +	return true;
>> +}
>> +
>>  static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
>>  				    unsigned long arg)
>>  {
>> @@ -471,6 +584,12 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
>>  	case PCITEST_COPY:
>>  		ret = pci_endpoint_test_copy(test, arg);
>>  		break;
>> +	case PCITEST_SET_IRQTYPE:
>> +		ret = pci_endpoint_test_set_irq(test, arg);
>> +		break;
>> +	case PCITEST_GET_IRQTYPE:
>> +		ret = irq_type;
> 
> Can't the set_irq be done as part of raise irq itself?

That could work for the legacy/MSI/MSI-X tests, but not for the Write/Read/Copy
tests... From what I saw, it was possible to perform Write/Read/Copy tests with
either legacy or MSI on the previous version. I'm assuming that you don't wanna
to lose that functionalities, right?

Regards,
Gustavo

> 
> Thanks
> Kishon
> 
