Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52090 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbeGIEtD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jul 2018 00:49:03 -0400
Subject: Re: [PATCH v8 08/11] pci-epf-test/pci_endpoint_test: Add MSI-X
 support
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <Joao.Pinto@synopsys.com>, <jingoohan1@gmail.com>,
        <adouglas@cadence.com>, <jesper.nilsson@axis.com>,
        <shawn.lin@rock-chips.com>
References: <cover.1530891871.git.gustavo.pimentel@synopsys.com>
 <bbee5395f02f728be88797bb450b999725ffbbc3.1530891871.git.gustavo.pimentel@synopsys.com>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <d670712a-d436-69eb-1daf-c66b717a36e6@ti.com>
Date: Mon, 9 Jul 2018 10:18:42 +0530
MIME-Version: 1.0
In-Reply-To: <bbee5395f02f728be88797bb450b999725ffbbc3.1530891871.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Friday 06 July 2018 09:21 PM, Gustavo Pimentel wrote:
> Add MSI-X support and update driver documentation accordingly.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
> Change v2->v3:
>  - New patch file created base on the previous patch
> "misc: pci_endpoint_test: Add MSI-X support" patch file following
> Kishon's suggestion.
> Change v3->v4:
>  - Rebased to Lorenzo's master branch v4.18-rc1.
> Change v4->v5:
>  - Nothing changed, just to follow the patch set version.
> Change v5->v6:
>  - Moved PCITEST_MSIX ioctl entry from patch #10 to here.
>  - Documented ioctl parameter type associated to
> drivers/misc/pci_endpoint_test.c driver.
> Change v6->v7:
>  - Updated documentation.
>  - Added flag that enables or not the MSI-X on the EP features. 
> Change v7->v8:
>  - Re-sending the patch series.
> 
>  Documentation/PCI/endpoint/pci-test-function.txt |  2 +-
>  Documentation/ioctl/ioctl-number.txt             |  1 +
>  Documentation/misc-devices/pci-endpoint-test.txt |  3 +++
>  drivers/misc/pci_endpoint_test.c                 | 29 +++++++++++++++++-------
>  drivers/pci/controller/dwc/pcie-designware-ep.c  |  1 +
>  drivers/pci/endpoint/functions/pci-epf-test.c    | 29 ++++++++++++++++++++++--
>  include/linux/pci-epc.h                          |  1 +
>  include/uapi/linux/pcitest.h                     |  1 +
>  8 files changed, 56 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/PCI/endpoint/pci-test-function.txt b/Documentation/PCI/endpoint/pci-test-function.txt
> index 7ee2361..b1cbff3 100644
> --- a/Documentation/PCI/endpoint/pci-test-function.txt
> +++ b/Documentation/PCI/endpoint/pci-test-function.txt
> @@ -34,7 +34,7 @@ that the endpoint device must perform.
>  Bitfield Description:
>    Bit 0		: raise legacy IRQ
>    Bit 1		: raise MSI IRQ
> -  Bit 2		: raise MSI-X IRQ (reserved for future implementation)
> +  Bit 2		: raise MSI-X IRQ
>    Bit 3		: read command (read data from RC buffer)
>    Bit 4		: write command (write data to RC buffer)
>    Bit 5		: copy command (copy data from one RC buffer to another
> diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/ioctl-number.txt
> index 480c860..65259d4 100644
> --- a/Documentation/ioctl/ioctl-number.txt
> +++ b/Documentation/ioctl/ioctl-number.txt
> @@ -166,6 +166,7 @@ Code  Seq#(hex)	Include File		Comments
>  'P'	all	linux/soundcard.h	conflict!
>  'P'	60-6F	sound/sscape_ioctl.h	conflict!
>  'P'	00-0F	drivers/usb/class/usblp.c	conflict!
> +'P'	01-07	drivers/misc/pci_endpoint_test.c	conflict!
>  'Q'	all	linux/soundcard.h
>  'R'	00-1F	linux/random.h		conflict!
>  'R'	01	linux/rfkill.h		conflict!
> diff --git a/Documentation/misc-devices/pci-endpoint-test.txt b/Documentation/misc-devices/pci-endpoint-test.txt
> index 4ebc359..fdfa0f6 100644
> --- a/Documentation/misc-devices/pci-endpoint-test.txt
> +++ b/Documentation/misc-devices/pci-endpoint-test.txt
> @@ -10,6 +10,7 @@ The PCI driver for the test device performs the following tests
>  	*) verifying addresses programmed in BAR
>  	*) raise legacy IRQ
>  	*) raise MSI IRQ
> +	*) raise MSI-X IRQ
>  	*) read data
>  	*) write data
>  	*) copy data
> @@ -25,6 +26,8 @@ ioctl
>   PCITEST_LEGACY_IRQ: Tests legacy IRQ
>   PCITEST_MSI: Tests message signalled interrupts. The MSI number
>  	      to be tested should be passed as argument.
> + PCITEST_MSIX: Tests message signalled interrupts. The MSI-X number
> +	      to be tested should be passed as argument.
>   PCITEST_WRITE: Perform write tests. The size of the buffer should be passed
>  		as argument.
>   PCITEST_READ: Perform read tests. The size of the buffer should be passed
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 349794c..f4fef10 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -39,13 +39,14 @@
>  
>  #define IRQ_TYPE_LEGACY				0
>  #define IRQ_TYPE_MSI				1
> +#define IRQ_TYPE_MSIX				2
>  
>  #define PCI_ENDPOINT_TEST_MAGIC			0x0
>  
>  #define PCI_ENDPOINT_TEST_COMMAND		0x4
>  #define COMMAND_RAISE_LEGACY_IRQ		BIT(0)
>  #define COMMAND_RAISE_MSI_IRQ			BIT(1)
> -/* BIT(2) is reserved for raising MSI-X IRQ command */
> +#define COMMAND_RAISE_MSIX_IRQ			BIT(2)
>  #define COMMAND_READ				BIT(3)
>  #define COMMAND_WRITE				BIT(4)
>  #define COMMAND_COPY				BIT(5)
> @@ -84,7 +85,7 @@ MODULE_PARM_DESC(no_msi, "Disable MSI interrupt in pci_endpoint_test");
>  
>  static int irq_type = IRQ_TYPE_MSI;
>  module_param(irq_type, int, 0444);
> -MODULE_PARM_DESC(irq_type, "IRQ mode selection in pci_endpoint_test (0 - Legacy, 1 - MSI)");
> +MODULE_PARM_DESC(irq_type, "IRQ mode selection in pci_endpoint_test (0 - Legacy, 1 - MSI, 2 - MSI-X)");
>  
>  enum pci_barno {
>  	BAR_0,
> @@ -202,16 +203,18 @@ static bool pci_endpoint_test_legacy_irq(struct pci_endpoint_test *test)
>  }
>  
>  static bool pci_endpoint_test_msi_irq(struct pci_endpoint_test *test,
> -				      u8 msi_num)
> +				       u16 msi_num, bool msix)
>  {
>  	u32 val;
>  	struct pci_dev *pdev = test->pdev;
>  
>  	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE,
> -				 IRQ_TYPE_MSI);
> +				 msix == false ? IRQ_TYPE_MSI :
> +				 IRQ_TYPE_MSIX);
>  	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, msi_num);
>  	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
> -				 COMMAND_RAISE_MSI_IRQ);
> +				 msix == false ? COMMAND_RAISE_MSI_IRQ :
> +				 COMMAND_RAISE_MSIX_IRQ);
>  	val = wait_for_completion_timeout(&test->irq_raised,
>  					  msecs_to_jiffies(1000));
>  	if (!val)
> @@ -456,7 +459,8 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
>  		ret = pci_endpoint_test_legacy_irq(test);
>  		break;
>  	case PCITEST_MSI:
> -		ret = pci_endpoint_test_msi_irq(test, arg);
> +	case PCITEST_MSIX:
> +		ret = pci_endpoint_test_msi_irq(test, arg, cmd == PCITEST_MSIX);
>  		break;
>  	case PCITEST_WRITE:
>  		ret = pci_endpoint_test_write(test, arg);
> @@ -542,6 +546,12 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  			dev_err(dev, "Failed to get MSI interrupts\n");
>  		test->num_irqs = irq;
>  		break;
> +	case IRQ_TYPE_MSIX:
> +		irq = pci_alloc_irq_vectors(pdev, 1, 2048, PCI_IRQ_MSIX);
> +		if (irq < 0)
> +			dev_err(dev, "Failed to get MSI-X interrupts\n");
> +		test->num_irqs = irq;
> +		break;
>  	default:
>  		dev_err(dev, "Invalid IRQ type selected\n");
>  	}
> @@ -558,8 +568,9 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  				       pci_endpoint_test_irqhandler,
>  				       IRQF_SHARED, DRV_MODULE_NAME, test);
>  		if (err)
> -			dev_err(dev, "failed to request IRQ %d for MSI %d\n",
> -				pci_irq_vector(pdev, i), i + 1);
> +			dev_err(dev, "Failed to request IRQ %d for MSI%s %d\n",
> +				pci_irq_vector(pdev, i),
> +				irq_type == IRQ_TYPE_MSIX ? "-X" : "", i + 1);
>  	}
>  
>  	for (bar = BAR_0; bar <= BAR_5; bar++) {
> @@ -625,6 +636,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  
>  err_disable_msi:
>  	pci_disable_msi(pdev);
> +	pci_disable_msix(pdev);
>  	pci_release_regions(pdev);
>  
>  err_disable_pdev:
> @@ -656,6 +668,7 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
>  	for (i = 0; i < test->num_irqs; i++)
>  		devm_free_irq(&pdev->dev, pci_irq_vector(pdev, i), test);
>  	pci_disable_msi(pdev);
> +	pci_disable_msix(pdev);
>  	pci_release_regions(pdev);
>  	pci_disable_device(pdev);
>  }
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 70d0688..36d83d1 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -585,6 +585,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  	ep->msix_cap = dw_pcie_ep_find_capability(pci, PCI_CAP_ID_MSIX);
>  
>  	epc->features = EPC_FEATURE_NO_LINKUP_NOTIFIER;
> +	epc->features |= EPC_FEATURE_MSIX_AVAILABLE;

This indicates all vendors of designware has MSIX enabled which is not true.
We'll need more logic than that.

Thanks
Kishon
