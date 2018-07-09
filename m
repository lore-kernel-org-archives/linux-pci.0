Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-eopbgr700088.outbound.protection.outlook.com ([40.107.70.88]:45056
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932898AbeGIPXB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Jul 2018 11:23:01 -0400
From: Alan Douglas <adouglas@cadence.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v8 09/11] pci_endpoint_test: Add 2 ioctl commands
Date: Mon, 9 Jul 2018 15:22:58 +0000
Message-ID: <MWHPR07MB350246B23FF90D27B60CF0B2D8440@MWHPR07MB3502.namprd07.prod.outlook.com>
References: <cover.1530891871.git.gustavo.pimentel@synopsys.com>
 <93f542ee1ec24d3a24150d8909074614536d6ce9.1530891871.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <93f542ee1ec24d3a24150d8909074614536d6ce9.1530891871.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Gustavo,

On  06 July 2018 16:52 Gustavo Pimentel <gustavo.pimentel@synopsys.com> wro=
te:
> Add MSI-X support and update driver documentation accordingly.
>=20
> Add 2 new IOCTL commands:
>  - Allow to reconfigure driver IRQ type in runtime.
>  - Allow to retrieve current driver IRQ type configured.
>=20
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
>  - Moved PCITEST_SET_IRQTYPE and PCITEST_GET_IRQTYPE ioctl entries
> from patch #10 to here.
>  - Increased ioctl parameters range associated to
> drivers/misc/pci_endpoint_test.c driver.
> Change v6->v7:
>  - irq_type variable update just before returning the function.
> Change v7->v8:
>  - Re-sending the patch series.
>=20
>  Documentation/ioctl/ioctl-number.txt             |   2 +-
>  Documentation/misc-devices/pci-endpoint-test.txt |   3 +
>  drivers/misc/pci_endpoint_test.c                 | 175 +++++++++++++++++=
------
>  include/uapi/linux/pcitest.h                     |   2 +
>  4 files changed, 135 insertions(+), 47 deletions(-)
>=20
> diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/i=
octl-number.txt
> index 65259d4..c15c4f3 100644
> --- a/Documentation/ioctl/ioctl-number.txt
> +++ b/Documentation/ioctl/ioctl-number.txt
> @@ -166,7 +166,7 @@ Code  Seq#(hex)	Include File		Comments
>  'P'	all	linux/soundcard.h	conflict!
>  'P'	60-6F	sound/sscape_ioctl.h	conflict!
>  'P'	00-0F	drivers/usb/class/usblp.c	conflict!
> -'P'	01-07	drivers/misc/pci_endpoint_test.c	conflict!
> +'P'	01-09	drivers/misc/pci_endpoint_test.c	conflict!
>  'Q'	all	linux/soundcard.h
>  'R'	00-1F	linux/random.h		conflict!
>  'R'	01	linux/rfkill.h		conflict!
> diff --git a/Documentation/misc-devices/pci-endpoint-test.txt b/Documenta=
tion/misc-devices/pci-endpoint-test.txt
> index fdfa0f6..58ccca4 100644
> --- a/Documentation/misc-devices/pci-endpoint-test.txt
> +++ b/Documentation/misc-devices/pci-endpoint-test.txt
> @@ -28,6 +28,9 @@ ioctl
>  	      to be tested should be passed as argument.
>   PCITEST_MSIX: Tests message signalled interrupts. The MSI-X number
>  	      to be tested should be passed as argument.
> + PCITEST_SET_IRQTYPE: Changes driver IRQ type configuration. The IRQ typ=
e
> +	      should be passed as argument (0: Legacy, 1:MSI, 2:MSI-X).
> + PCITEST_GET_IRQTYPE: Gets driver IRQ type configuration.
>   PCITEST_WRITE: Perform write tests. The size of the buffer should be pa=
ssed
>  		as argument.
>   PCITEST_READ: Perform read tests. The size of the buffer should be pass=
ed
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint=
_test.c
> index f4fef10..97082e3 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -157,6 +157,87 @@ static irqreturn_t pci_endpoint_test_irqhandler(int =
irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>=20
> +static void pci_endpoint_test_free_irq_vectors(struct pci_endpoint_test =
*test)
> +{
> +	int i;
> +	struct pci_dev *pdev =3D test->pdev;
> +	struct device *dev =3D &pdev->dev;
> +
> +	for (i =3D 0; i < test->num_irqs; i++)
> +		devm_free_irq(dev, pci_irq_vector(pdev, i), test);
> +
> +	test->num_irqs =3D 0;
> +}
> +
> +static bool pci_endpoint_test_alloc_irq_vectors(struct pci_endpoint_test=
 *test)
> +{
> +	int irq =3D -1;
> +	struct pci_dev *pdev =3D test->pdev;
> +	struct device *dev =3D &pdev->dev;
> +	bool res =3D true;
> +
> +	switch (irq_type) {
> +	case IRQ_TYPE_LEGACY:
> +		irq =3D 0;
> +		break;
> +	case IRQ_TYPE_MSI:
> +		irq =3D pci_alloc_irq_vectors(pdev, 1, 32, PCI_IRQ_MSI);
> +		if (irq < 0)
> +			dev_err(dev, "Failed to get MSI interrupts\n");
> +		break;
> +	case IRQ_TYPE_MSIX:
> +		irq =3D pci_alloc_irq_vectors(pdev, 1, 2048, PCI_IRQ_MSIX);
> +		if (irq < 0)
> +			dev_err(dev, "Failed to get MSI-X interrupts\n");
> +		break;
> +	default:
> +		dev_err(dev, "Invalid IRQ type selected\n");
> +	}
> +
> +	if (irq < 0) {
> +		irq =3D 0;
> +		res =3D false;
> +	}
> +	test->num_irqs =3D irq;
> +
> +	return res;
> +}
> +
> +static void pci_endpoint_test_release_irq(struct pci_endpoint_test *test=
)
> +{
> +	struct pci_dev *pdev =3D test->pdev;
> +
> +	pci_disable_msi(pdev);
> +	pci_disable_msix(pdev);
> +}
> +
> +static bool pci_endpoint_test_request_irq(struct pci_endpoint_test *test=
)
> +{
> +	int i;
> +	int err;
> +	struct pci_dev *pdev =3D test->pdev;
> +	struct device *dev =3D &pdev->dev;
> +
> +	err =3D devm_request_irq(dev, pdev->irq, pci_endpoint_test_irqhandler,
> +			       IRQF_SHARED, DRV_MODULE_NAME, test);
> +	if (err) {
> +		dev_err(dev, "Failed to request IRQ %d\n", pdev->irq);
> +		return false;
> +	}
> +
> +	for (i =3D 1; i < test->num_irqs; i++) {
> +		err =3D devm_request_irq(dev, pci_irq_vector(pdev, i),
> +				       pci_endpoint_test_irqhandler,
> +				       IRQF_SHARED, DRV_MODULE_NAME, test);
> +		if (err)
> +			dev_err(dev, "Failed to request IRQ %d for MSI%s %d\n",
> +				pci_irq_vector(pdev, i),
> +				irq_type =3D=3D IRQ_TYPE_MSIX ? "-X" : "", i + 1);
> +	}
> +
> +	return true;
> +}
> +
>  static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
>  				  enum pci_barno barno)
>  {
> @@ -440,6 +521,38 @@ static bool pci_endpoint_test_read(struct pci_endpoi=
nt_test *test, size_t size)
>  	return ret;
>  }
>=20
> +static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
> +				      int req_irq_type)
> +{
> +	struct pci_dev *pdev =3D test->pdev;
> +	struct device *dev =3D &pdev->dev;
> +
> +	if (req_irq_type < IRQ_TYPE_LEGACY || req_irq_type > IRQ_TYPE_MSIX) {
> +		dev_err(dev, "Invalid IRQ type option\n");
> +		return false;
> +	}
> +
> +	if (irq_type =3D=3D req_irq_type)
> +		return true;
> +
> +	pci_endpoint_test_free_irq_vectors(test);
> +	pci_endpoint_test_release_irq(test);
> +
> +	if (!pci_endpoint_test_alloc_irq_vectors(test)) {
> +		pci_endpoint_test_release_irq(test);
> +		return false;
> +	}
I am testing the latest patch set with the cadence driver, and find this st=
ep is not working correctly.
pci_endpoint_test_alloc_irq_vectors relies on the value of static irq_type =
to request the appropriate IRQ.
However, you don't set this value until a few lines later, so the first att=
empt to set the IRQ type fails.  (A
second attempt to set it will succeed however.)  I suggest setting irq_type=
 before the call, or even adding
a parameter to pci_endpoint_test_alloc_irq_vectors() with the requested IRQ=
 type to avoid having to set it
back again after a failed call.
> +
> +	if (!pci_endpoint_test_request_irq(test)) {
> +		pci_endpoint_test_release_irq(test);
> +		return false;
> +	}

> +
> +	irq_type =3D req_irq_type;
> +
> +	return true;
> +}
