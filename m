Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:40088 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729717AbeGQLEm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Jul 2018 07:04:42 -0400
Subject: Re: [PATCH v12 10/12] pci_endpoint_test: Add 2 ioctl commands
From: Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "joao.pinto@synopsys.com" <joao.pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "adouglas@cadence.com" <adouglas@cadence.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1531818979.git.gustavo.pimentel@synopsys.com>
 <0dc487515e28a6cd790888cb98f84fb7ea3a412e.1531818979.git.gustavo.pimentel@synopsys.com>
 <f1745187-d3a1-b0c1-4792-350b57908533@ti.com>
 <1405bc2e-bb0e-1cd9-4fad-73bc7c24f95e@synopsys.com>
Message-ID: <27e947e5-73df-eb0c-8ca3-b9022197c5df@synopsys.com>
Date: Tue, 17 Jul 2018 11:30:28 +0100
MIME-Version: 1.0
In-Reply-To: <1405bc2e-bb0e-1cd9-4fad-73bc7c24f95e@synopsys.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Kishon,

On 17/07/2018 11:27, Gustavo Pimentel wrote:
> Hi Kishon,
> 
> On 17/07/2018 10:44, Kishon Vijay Abraham I wrote:
>> Hi Gustavo,
>>
>> On Tuesday 17 July 2018 03:01 PM, Gustavo Pimentel wrote:
>>> Add MSI-X support and update driver documentation accordingly.
>>>
>>> Add 2 new IOCTL commands:
>>>  - Allow to reconfigure driver IRQ type in runtime.
>>>  - Allow to retrieve current driver IRQ type configured.
>>>
>>> Add IRQ type validation before executing the READ/WRITE/COPY tests.
>>>
>>> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>>> ---
>>> Change v2->v3:
>>>  - New patch file created base on the previous patch
>>> "misc: pci_endpoint_test: Add MSI-X support" patch file following
>>> Kishon's suggestion.
>>> Change v3->v4:
>>>  - Rebased to Lorenzo's master branch v4.18-rc1.
>>> Change v4->v5:
>>>  - Nothing changed, just to follow the patch set version.
>>> Change v5->v6:
>>>  - Moved PCITEST_SET_IRQTYPE and PCITEST_GET_IRQTYPE ioctl entries
>>> from patch #10 to here.
>>>  - Increased ioctl parameters range associated to
>>> drivers/misc/pci_endpoint_test.c driver.
>>> Change v6->v7:
>>>  - irq_type variable update just before returning the function.
>>> Change v7->v8:
>>>  - Re-sending the patch series.
>>> Change v8->v9:
>>>  - Added a extra parameter to pci_endpoint_test_alloc_irq_vectors,
>>> that specifies which irq type should be allocated.
>>> Change v9->v10:
>>>  - Fixed bug, report available: https://urldefense.proofpoint.com/v2/url?u=https-3A__lkml.org_lkml_2018_7_16_11&d=DwIC-g&c=DPL6_X_6JkXFx7AXWqB0tg&r=bkWxpLoW-f-E3EdiDCCa0_h0PicsViasSlvIpzZvPxs&m=CuSUiOT8Ny_VHh-nsPb5V9qUNsCkC1DqnFimo4gyxqw&s=WuOeonvYSQmS2aJmd0TSo4MVySk4EzOofReUF8CHwCY&e=
>>>  - Added IRQ type validation before executing the READ/WRITE/COPY
>>> tests.
>>> Change v11->v12:
>>>  - Exchange pci_endpoint_test_release_irq() and
>>> pci_endpoint_test_free_irq_vectors() content.
>>>  - Refactor all previous calls to those functions.
>>>
>>>  Documentation/ioctl/ioctl-number.txt             |   2 +-
>>>  Documentation/misc-devices/pci-endpoint-test.txt |   3 +
>>>  drivers/misc/pci_endpoint_test.c                 | 192 +++++++++++++++++------
>>>  include/uapi/linux/pcitest.h                     |   2 +
>>>  4 files changed, 152 insertions(+), 47 deletions(-)
>>>
>>> diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/ioctl-number.txt
>>> index 65259d4..c15c4f3 100644
>>> --- a/Documentation/ioctl/ioctl-number.txt
>>> +++ b/Documentation/ioctl/ioctl-number.txt
>>> @@ -166,7 +166,7 @@ Code  Seq#(hex)	Include File		Comments
>>>  'P'	all	linux/soundcard.h	conflict!
>>>  'P'	60-6F	sound/sscape_ioctl.h	conflict!
>>>  'P'	00-0F	drivers/usb/class/usblp.c	conflict!
>>> -'P'	01-07	drivers/misc/pci_endpoint_test.c	conflict!
>>> +'P'	01-09	drivers/misc/pci_endpoint_test.c	conflict!
>>>  'Q'	all	linux/soundcard.h
>>>  'R'	00-1F	linux/random.h		conflict!
>>>  'R'	01	linux/rfkill.h		conflict!
>>> diff --git a/Documentation/misc-devices/pci-endpoint-test.txt b/Documentation/misc-devices/pci-endpoint-test.txt
>>> index fdfa0f6..58ccca4 100644
>>> --- a/Documentation/misc-devices/pci-endpoint-test.txt
>>> +++ b/Documentation/misc-devices/pci-endpoint-test.txt
>>> @@ -28,6 +28,9 @@ ioctl
>>>  	      to be tested should be passed as argument.
>>>   PCITEST_MSIX: Tests message signalled interrupts. The MSI-X number
>>>  	      to be tested should be passed as argument.
>>> + PCITEST_SET_IRQTYPE: Changes driver IRQ type configuration. The IRQ type
>>> +	      should be passed as argument (0: Legacy, 1:MSI, 2:MSI-X).
>>> + PCITEST_GET_IRQTYPE: Gets driver IRQ type configuration.
>>>   PCITEST_WRITE: Perform write tests. The size of the buffer should be passed
>>>  		as argument.
>>>   PCITEST_READ: Perform read tests. The size of the buffer should be passed
>>> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
>>> index f4fef10..d909ca5 100644
>>> --- a/drivers/misc/pci_endpoint_test.c
>>> +++ b/drivers/misc/pci_endpoint_test.c
>>> @@ -37,6 +37,7 @@
>>>  
>>>  #define DRV_MODULE_NAME				"pci-endpoint-test"
>>>  
>>> +#define IRQ_TYPE_UNDEFINED			-1
>>>  #define IRQ_TYPE_LEGACY				0
>>>  #define IRQ_TYPE_MSI				1
>>>  #define IRQ_TYPE_MSIX				2
>>> @@ -157,6 +158,88 @@ static irqreturn_t pci_endpoint_test_irqhandler(int irq, void *dev_id)
>>>  	return IRQ_HANDLED;
>>>  }
>>>  
>>> +static void pci_endpoint_test_free_irq_vectors(struct pci_endpoint_test *test)
>>> +{
>>> +	int i;
>>> +	struct pci_dev *pdev = test->pdev;
>>> +	struct device *dev = &pdev->dev;
>>> +
>>> +	for (i = 0; i < test->num_irqs; i++)
>>> +		devm_free_irq(dev, pci_irq_vector(pdev, i), test);
>>
>> The contents looks the same as in v11,
> 
> My fault, I changed the patches files unintentionally.
> 
> I sent now the version 12.

Once again, sorry. Version 13, I mean.

Gustavo

> Thanks.
> 
> Gustavo
> 
>>
>> Thanks
>> Kishon
>>
>>> +
>>> +	test->num_irqs = 0;
>>> +}
>>> +
>>> +static bool pci_endpoint_test_alloc_irq_vectors(struct pci_endpoint_test *test,
>>> +						int type)
>>> +{
>>> +	int irq = -1;
>>> +	struct pci_dev *pdev = test->pdev;
>>> +	struct device *dev = &pdev->dev;
>>> +	bool res = true;
>>> +
>>> +	switch (type) {
>>> +	case IRQ_TYPE_LEGACY:
>>> +		irq = 0;
>>> +		break;
>>> +	case IRQ_TYPE_MSI:
>>> +		irq = pci_alloc_irq_vectors(pdev, 1, 32, PCI_IRQ_MSI);
>>> +		if (irq < 0)
>>> +			dev_err(dev, "Failed to get MSI interrupts\n");
>>> +		break;
>>> +	case IRQ_TYPE_MSIX:
>>> +		irq = pci_alloc_irq_vectors(pdev, 1, 2048, PCI_IRQ_MSIX);
>>> +		if (irq < 0)
>>> +			dev_err(dev, "Failed to get MSI-X interrupts\n");
>>> +		break;
>>> +	default:
>>> +		dev_err(dev, "Invalid IRQ type selected\n");
>>> +	}
>>> +
>>> +	if (irq < 0) {
>>> +		irq = 0;
>>> +		res = false;
>>> +	}
>>> +	test->num_irqs = irq;
>>> +
>>> +	return res;
>>> +}
>>> +
>>> +static void pci_endpoint_test_release_irq(struct pci_endpoint_test *test)
>>> +{
>>> +	struct pci_dev *pdev = test->pdev;
>>> +
>>> +	pci_disable_msi(pdev);
>>> +	pci_disable_msix(pdev);
>>> +}
>>> +
>>> +static bool pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
>>> +{
>>> +	int i;
>>> +	int err;
>>> +	struct pci_dev *pdev = test->pdev;
>>> +	struct device *dev = &pdev->dev;
>>> +
>>> +	err = devm_request_irq(dev, pdev->irq, pci_endpoint_test_irqhandler,
>>> +			       IRQF_SHARED, DRV_MODULE_NAME, test);
>>> +	if (err) {
>>> +		dev_err(dev, "Failed to request IRQ %d\n", pdev->irq);
>>> +		return false;
>>> +	}
>>> +
>>> +	for (i = 1; i < test->num_irqs; i++) {
>>> +		err = devm_request_irq(dev, pci_irq_vector(pdev, i),
>>> +				       pci_endpoint_test_irqhandler,
>>> +				       IRQF_SHARED, DRV_MODULE_NAME, test);
>>> +		if (err)
>>> +			dev_err(dev, "Failed to request IRQ %d for MSI%s %d\n",
>>> +				pci_irq_vector(pdev, i),
>>> +				irq_type == IRQ_TYPE_MSIX ? "-X" : "", i + 1);
>>> +	}
>>> +
>>> +	return true;
>>> +}
>>> +
>>>  static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
>>>  				  enum pci_barno barno)
>>>  {
>>> @@ -247,6 +330,11 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test, size_t size)
>>>  	if (size > SIZE_MAX - alignment)
>>>  		goto err;
>>>  
>>> +	if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
>>> +		dev_err(dev, "Invalid IRQ type option\n");
>>> +		goto err;
>>> +	}
>>> +
>>>  	orig_src_addr = dma_alloc_coherent(dev, size + alignment,
>>>  					   &orig_src_phys_addr, GFP_KERNEL);
>>>  	if (!orig_src_addr) {
>>> @@ -337,6 +425,11 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test, size_t size)
>>>  	if (size > SIZE_MAX - alignment)
>>>  		goto err;
>>>  
>>> +	if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
>>> +		dev_err(dev, "Invalid IRQ type option\n");
>>> +		goto err;
>>> +	}
>>> +
>>>  	orig_addr = dma_alloc_coherent(dev, size + alignment, &orig_phys_addr,
>>>  				       GFP_KERNEL);
>>>  	if (!orig_addr) {
>>> @@ -400,6 +493,11 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test, size_t size)
>>>  	if (size > SIZE_MAX - alignment)
>>>  		goto err;
>>>  
>>> +	if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
>>> +		dev_err(dev, "Invalid IRQ type option\n");
>>> +		goto err;
>>> +	}
>>> +
>>>  	orig_addr = dma_alloc_coherent(dev, size + alignment, &orig_phys_addr,
>>>  				       GFP_KERNEL);
>>>  	if (!orig_addr) {
>>> @@ -440,6 +538,38 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test, size_t size)
>>>  	return ret;
>>>  }
>>>  
>>> +static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
>>> +				      int req_irq_type)
>>> +{
>>> +	struct pci_dev *pdev = test->pdev;
>>> +	struct device *dev = &pdev->dev;
>>> +
>>> +	if (req_irq_type < IRQ_TYPE_LEGACY || req_irq_type > IRQ_TYPE_MSIX) {
>>> +		dev_err(dev, "Invalid IRQ type option\n");
>>> +		return false;
>>> +	}
>>> +
>>> +	if (irq_type == req_irq_type)
>>> +		return true;
>>> +
>>> +	pci_endpoint_test_free_irq_vectors(test);
>>> +	pci_endpoint_test_release_irq(test);
>>> +
>>> +	if (!pci_endpoint_test_alloc_irq_vectors(test, req_irq_type))
>>> +		goto err;
>>> +
>>> +	if (!pci_endpoint_test_request_irq(test))
>>> +		goto err;
>>> +
>>> +	irq_type = req_irq_type;
>>> +	return true;
>>> +
>>> +err:
>>> +	pci_endpoint_test_release_irq(test);
>>> +	irq_type = IRQ_TYPE_UNDEFINED;
>>> +	return false;
>>> +}
>>> +
>>>  static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
>>>  				    unsigned long arg)
>>>  {
>>> @@ -471,6 +601,12 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
>>>  	case PCITEST_COPY:
>>>  		ret = pci_endpoint_test_copy(test, arg);
>>>  		break;
>>> +	case PCITEST_SET_IRQTYPE:
>>> +		ret = pci_endpoint_test_set_irq(test, arg);
>>> +		break;
>>> +	case PCITEST_GET_IRQTYPE:
>>> +		ret = irq_type;
>>> +		break;
>>>  	}
>>>  
>>>  ret:
>>> @@ -486,9 +622,7 @@ static const struct file_operations pci_endpoint_test_fops = {
>>>  static int pci_endpoint_test_probe(struct pci_dev *pdev,
>>>  				   const struct pci_device_id *ent)
>>>  {
>>> -	int i;
>>>  	int err;
>>> -	int irq = 0;
>>>  	int id;
>>>  	char name[20];
>>>  	enum pci_barno bar;
>>> @@ -537,41 +671,11 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>>>  
>>>  	pci_set_master(pdev);
>>>  
>>> -	switch (irq_type) {
>>> -	case IRQ_TYPE_LEGACY:
>>> -		break;
>>> -	case IRQ_TYPE_MSI:
>>> -		irq = pci_alloc_irq_vectors(pdev, 1, 32, PCI_IRQ_MSI);
>>> -		if (irq < 0)
>>> -			dev_err(dev, "Failed to get MSI interrupts\n");
>>> -		test->num_irqs = irq;
>>> -		break;
>>> -	case IRQ_TYPE_MSIX:
>>> -		irq = pci_alloc_irq_vectors(pdev, 1, 2048, PCI_IRQ_MSIX);
>>> -		if (irq < 0)
>>> -			dev_err(dev, "Failed to get MSI-X interrupts\n");
>>> -		test->num_irqs = irq;
>>> -		break;
>>> -	default:
>>> -		dev_err(dev, "Invalid IRQ type selected\n");
>>> -	}
>>> -
>>> -	err = devm_request_irq(dev, pdev->irq, pci_endpoint_test_irqhandler,
>>> -			       IRQF_SHARED, DRV_MODULE_NAME, test);
>>> -	if (err) {
>>> -		dev_err(dev, "Failed to request IRQ %d\n", pdev->irq);
>>> -		goto err_disable_msi;
>>> -	}
>>> +	if (!pci_endpoint_test_alloc_irq_vectors(test, irq_type))
>>> +		goto err_disable_irq;
>>>  
>>> -	for (i = 1; i < irq; i++) {
>>> -		err = devm_request_irq(dev, pci_irq_vector(pdev, i),
>>> -				       pci_endpoint_test_irqhandler,
>>> -				       IRQF_SHARED, DRV_MODULE_NAME, test);
>>> -		if (err)
>>> -			dev_err(dev, "Failed to request IRQ %d for MSI%s %d\n",
>>> -				pci_irq_vector(pdev, i),
>>> -				irq_type == IRQ_TYPE_MSIX ? "-X" : "", i + 1);
>>> -	}
>>> +	if (!pci_endpoint_test_request_irq(test))
>>> +		goto err_disable_irq;
>>>  
>>>  	for (bar = BAR_0; bar <= BAR_5; bar++) {
>>>  		if (pci_resource_flags(pdev, bar) & IORESOURCE_MEM) {
>>> @@ -631,12 +735,10 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>>>  			pci_iounmap(pdev, test->bar[bar]);
>>>  	}
>>>  
>>> -	for (i = 0; i < irq; i++)
>>> -		devm_free_irq(&pdev->dev, pci_irq_vector(pdev, i), test);
>>> +	pci_endpoint_test_free_irq_vectors(test);
>>>  
>>> -err_disable_msi:
>>> -	pci_disable_msi(pdev);
>>> -	pci_disable_msix(pdev);
>>> +err_disable_irq:
>>> +	pci_endpoint_test_release_irq(test);
>>>  	pci_release_regions(pdev);
>>>  
>>>  err_disable_pdev:
>>> @@ -648,7 +750,6 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>>>  static void pci_endpoint_test_remove(struct pci_dev *pdev)
>>>  {
>>>  	int id;
>>> -	int i;
>>>  	enum pci_barno bar;
>>>  	struct pci_endpoint_test *test = pci_get_drvdata(pdev);
>>>  	struct miscdevice *misc_device = &test->miscdev;
>>> @@ -665,10 +766,9 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
>>>  		if (test->bar[bar])
>>>  			pci_iounmap(pdev, test->bar[bar]);
>>>  	}
>>> -	for (i = 0; i < test->num_irqs; i++)
>>> -		devm_free_irq(&pdev->dev, pci_irq_vector(pdev, i), test);
>>> -	pci_disable_msi(pdev);
>>> -	pci_disable_msix(pdev);
>>> +	pci_endpoint_test_free_irq_vectors(test);
>>> +
>>> +	pci_endpoint_test_release_irq(test);
>>>  	pci_release_regions(pdev);
>>>  	pci_disable_device(pdev);
>>>  }
>>> diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
>>> index d746fb1..cbf422e 100644
>>> --- a/include/uapi/linux/pcitest.h
>>> +++ b/include/uapi/linux/pcitest.h
>>> @@ -17,5 +17,7 @@
>>>  #define PCITEST_READ		_IOW('P', 0x5, unsigned long)
>>>  #define PCITEST_COPY		_IOW('P', 0x6, unsigned long)
>>>  #define PCITEST_MSIX		_IOW('P', 0x7, int)
>>> +#define PCITEST_SET_IRQTYPE	_IOW('P', 0x8, int)
>>> +#define PCITEST_GET_IRQTYPE	_IO('P', 0x9)
>>>  
>>>  #endif /* __UAPI_LINUX_PCITEST_H */
>>>
> 
