Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Alan Douglas <adouglas@cadence.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "niklas.cassel@axis.com" <niklas.cassel@axis.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC 06/10] misc: pci_endpoint_test: Add MSI-X support
Date: Tue, 24 Apr 2018 06:59:51 +0000
Message-ID: <SN6PR07MB45121288F5ACECF3AB3A6D0AD8880@SN6PR07MB4512.namprd07.prod.outlook.com>
References: <cover.1523379766.git.gustavo.pimentel@synopsys.com>
 <8b88f8c2b766f36c71659deb0fce635154b2b39f.1523379766.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <8b88f8c2b766f36c71659deb0fce635154b2b39f.1523379766.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Gustavo,

On 10 April 2018 18:15 Gustavo Pimentel wrote:
>=20
> Adds the MSI-X support and updates driver documentation accordingly.
>=20
> Changes the driver parameter in order to allow the interruption type
> selection.
>=20
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
>  Documentation/misc-devices/pci-endpoint-test.txt |   3 +
>  drivers/misc/pci_endpoint_test.c                 | 102 +++++++++++++++++=
------
>  2 files changed, 79 insertions(+), 26 deletions(-)
>=20
> diff --git a/Documentation/misc-devices/pci-endpoint-test.txt
> b/Documentation/misc-devices/pci-endpoint-test.txt
> index 4ebc359..fdfa0f6 100644
> --- a/Documentation/misc-devices/pci-endpoint-test.txt
> +++ b/Documentation/misc-devices/pci-endpoint-test.txt
> @@ -10,6 +10,7 @@ The PCI driver for the test device performs the
> following tests
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
>   PCITEST_WRITE: Perform write tests. The size of the buffer should be pa=
ssed
>  		as argument.
>   PCITEST_READ: Perform read tests. The size of the buffer should be pass=
ed
> diff --git a/drivers/misc/pci_endpoint_test.c
> b/drivers/misc/pci_endpoint_test.c
> index 37db0fc..a7d9354 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -42,11 +42,16 @@
>  #define PCI_ENDPOINT_TEST_COMMAND	0x4
>  #define COMMAND_RAISE_LEGACY_IRQ	BIT(0)
>  #define COMMAND_RAISE_MSI_IRQ		BIT(1)
> -#define MSI_NUMBER_SHIFT		2
> -/* 6 bits for MSI number */
> -#define COMMAND_READ                    BIT(8)
> -#define COMMAND_WRITE                   BIT(9)
> -#define COMMAND_COPY                    BIT(10)
> +#define COMMAND_RAISE_MSIX_IRQ		BIT(2)
> +#define IRQ_TYPE_SHIFT			3
> +#define IRQ_TYPE_LEGACY			0
> +#define IRQ_TYPE_MSI			1
> +#define IRQ_TYPE_MSIX			2
> +#define MSI_NUMBER_SHIFT		5
> +/* 12 bits for MSI number */
> +#define COMMAND_READ                    BIT(17)
> +#define COMMAND_WRITE                   BIT(18)
> +#define COMMAND_COPY                    BIT(19)
>=20
>  #define PCI_ENDPOINT_TEST_STATUS	0x8
>  #define STATUS_READ_SUCCESS             BIT(0)
> @@ -73,9 +78,9 @@ static DEFINE_IDA(pci_endpoint_test_ida);
>  #define to_endpoint_test(priv) container_of((priv), struct pci_endpoint_=
test,
> \
>  					    miscdev)
>=20
> -static bool no_msi;
> -module_param(no_msi, bool, 0444);
> -MODULE_PARM_DESC(no_msi, "Disable MSI interrupt in
> pci_endpoint_test");
> +static int irq_type =3D IRQ_TYPE_MSIX;
> +module_param(irq_type, int, 0444);
> +MODULE_PARM_DESC(irq_type, "IRQ mode selection in pci_endpoint_test
> (0
> +- Legacy, 1 - MSI, 2 - MSI-X)");
>=20
>  enum pci_barno {
>  	BAR_0,
> @@ -103,7 +108,7 @@ struct pci_endpoint_test {  struct
> pci_endpoint_test_data {
>  	enum pci_barno test_reg_bar;
>  	size_t alignment;
> -	bool no_msi;
> +	int irq_type;
>  };
>=20
>  static inline u32 pci_endpoint_test_readl(struct pci_endpoint_test *test=
,
> @@ -177,10 +182,10 @@ static bool pci_endpoint_test_bar(struct
> pci_endpoint_test *test,
>=20
>  static bool pci_endpoint_test_legacy_irq(struct pci_endpoint_test *test)=
  {
> -	u32 val;
> +	u32 val =3D COMMAND_RAISE_LEGACY_IRQ;
>=20
> -	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
> -				 COMMAND_RAISE_LEGACY_IRQ);
> +	val |=3D (IRQ_TYPE_LEGACY << IRQ_TYPE_SHIFT);
> +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND, val);
>  	val =3D wait_for_completion_timeout(&test->irq_raised,
>  					  msecs_to_jiffies(1000));
>  	if (!val)
> @@ -192,12 +197,12 @@ static bool pci_endpoint_test_legacy_irq(struct
> pci_endpoint_test *test)  static bool pci_endpoint_test_msi_irq(struct
> pci_endpoint_test *test,
>  				      u8 msi_num)
>  {
> -	u32 val;
> +	u32 val =3D COMMAND_RAISE_MSI_IRQ;
>  	struct pci_dev *pdev =3D test->pdev;
>=20
> -	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
> -				 msi_num << MSI_NUMBER_SHIFT |
> -				 COMMAND_RAISE_MSI_IRQ);
> +	val |=3D (msi_num << MSI_NUMBER_SHIFT);
> +	val |=3D (IRQ_TYPE_MSI << IRQ_TYPE_SHIFT);
> +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND, val);
>  	val =3D wait_for_completion_timeout(&test->irq_raised,
>  					  msecs_to_jiffies(1000));
>  	if (!val)
> @@ -209,6 +214,26 @@ static bool pci_endpoint_test_msi_irq(struct
> pci_endpoint_test *test,
>  	return false;
>  }
>=20
> +static bool pci_endpoint_test_msix_irq(struct pci_endpoint_test *test,
> +				       u16 msix_num)
> +{
> +	u32 val =3D COMMAND_RAISE_MSIX_IRQ;
> +	struct pci_dev *pdev =3D test->pdev;
> +
> +	val |=3D (msix_num << MSI_NUMBER_SHIFT);
> +	val |=3D (IRQ_TYPE_MSIX << IRQ_TYPE_SHIFT);
> +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND, val);
> +	val =3D wait_for_completion_timeout(&test->irq_raised,
> +					  msecs_to_jiffies(1000));
> +	if (!val)
> +		return false;
> +
> +	if (test->last_irq - pdev->irq =3D=3D msix_num - 1)
> +		return true;
I think we should use pci_irq_vector() to convert from device vector to Lin=
ux IRQ.
It can be done in pci_endpoint_test_irqhandler()
(With MSI, pdev->irq will be updated during MSI init, but it is not for MSI=
-X.)

pci_irq_vector()  should also be used for devm_request_irq() and devm_free_=
irq()
so some changes required in probe and remove.

Regards,
Alan
