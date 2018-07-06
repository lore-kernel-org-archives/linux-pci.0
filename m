Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51824 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751659AbeGFJbk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Jul 2018 05:31:40 -0400
Subject: Re: [PATCH v6 10/11] tools: PCI: Add MSI-X support
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <Joao.Pinto@synopsys.com>, <jingoohan1@gmail.com>,
        <adouglas@cadence.com>, <jesper.nilsson@axis.com>,
        <shawn.lin@rock-chips.com>
References: <cover.1529595907.git.gustavo.pimentel@synopsys.com>
 <67e6549e9d872b53406aeec86bdd78d6d29e036d.1529595907.git.gustavo.pimentel@synopsys.com>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <c3f06ed5-f118-bd21-29a4-9f585d6007a2@ti.com>
Date: Fri, 6 Jul 2018 15:01:22 +0530
MIME-Version: 1.0
In-Reply-To: <67e6549e9d872b53406aeec86bdd78d6d29e036d.1529595907.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


On Thursday 21 June 2018 09:31 PM, Gustavo Pimentel wrote:
> Add MSI-X support to pcitest tool.
> 
> Modify pcitest.sh script to accommodate MSI-X interrupt tests.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> Change v1->v2:
>  - Allow IRQ type driver reconfiguring in runtime, follwing Kishon's
> suggestion.
> Change v2->v3:
>  - Nothing changed, just to follow the patch set version.
> Change v3->v4:
>  - Rebased to Lorenzo's master branch v4.18-rc1.
> Change v4->v5:
>  - Nothing changed, just to follow the patch set version.
> Change v5->v6:
>  - Moved PCITEST_MSIX ioctl entry to patch #8.
>  - Moved PCITEST_SET_IRQTYPE and PCITEST_GET_IRQTYPE ioctl entries
> to patch #9.
> 
>  tools/pci/pcitest.c  | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  tools/pci/pcitest.sh | 15 +++++++++++++++
>  2 files changed, 65 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
> index 9074b47..af146bb 100644
> --- a/tools/pci/pcitest.c
> +++ b/tools/pci/pcitest.c
> @@ -31,12 +31,17 @@
>  #define BILLION 1E9
>  
>  static char *result[] = { "NOT OKAY", "OKAY" };
> +static char *irq[] = { "LEGACY", "MSI", "MSI-X" };
>  
>  struct pci_test {
>  	char		*device;
>  	char		barnum;
>  	bool		legacyirq;
>  	unsigned int	msinum;
> +	unsigned int	msixnum;
> +	int		irqtype;
> +	bool		set_irqtype;
> +	bool		get_irqtype;
>  	bool		read;
>  	bool		write;
>  	bool		copy;
> @@ -65,6 +70,24 @@ static int run_test(struct pci_test *test)
>  			fprintf(stdout, "%s\n", result[ret]);
>  	}
>  
> +	if (test->set_irqtype) {
> +		ret = ioctl(fd, PCITEST_SET_IRQTYPE, test->irqtype);
> +		fprintf(stdout, "SET IRQ TYPE TO %s:\t\t", irq[test->irqtype]);
> +		if (ret < 0)
> +			fprintf(stdout, "FAILED\n");
> +		else
> +			fprintf(stdout, "%s\n", result[ret]);
> +	}
> +
> +	if (test->get_irqtype) {
> +		ret = ioctl(fd, PCITEST_GET_IRQTYPE);
> +		fprintf(stdout, "GET IRQ TYPE:\t\t");
> +		if (ret < 0)
> +			fprintf(stdout, "FAILED\n");
> +		else
> +			fprintf(stdout, "%s\n", irq[ret]);
> +	}
> +
>  	if (test->legacyirq) {
>  		ret = ioctl(fd, PCITEST_LEGACY_IRQ, 0);
>  		fprintf(stdout, "LEGACY IRQ:\t");
> @@ -83,6 +106,15 @@ static int run_test(struct pci_test *test)
>  			fprintf(stdout, "%s\n", result[ret]);
>  	}
>  
> +	if (test->msixnum > 0 && test->msixnum <= 2048) {
> +		ret = ioctl(fd, PCITEST_MSIX, test->msixnum);
> +		fprintf(stdout, "MSI-X%d:\t\t", test->msixnum);
> +		if (ret < 0)
> +			fprintf(stdout, "TEST FAILED\n");
> +		else
> +			fprintf(stdout, "%s\n", result[ret]);
> +	}
> +
>  	if (test->write) {
>  		ret = ioctl(fd, PCITEST_WRITE, test->size);
>  		fprintf(stdout, "WRITE (%7ld bytes):\t\t", test->size);
> @@ -133,7 +165,7 @@ int main(int argc, char **argv)
>  	/* set default endpoint device */
>  	test->device = "/dev/pci-endpoint-test.0";
>  
> -	while ((c = getopt(argc, argv, "D:b:m:lrwcs:")) != EOF)
> +	while ((c = getopt(argc, argv, "D:b:m:x:i:Ilrwcs:")) != EOF)
>  	switch (c) {
>  	case 'D':
>  		test->device = optarg;
> @@ -151,6 +183,20 @@ int main(int argc, char **argv)
>  		if (test->msinum < 1 || test->msinum > 32)
>  			goto usage;
>  		continue;
> +	case 'x':
> +		test->msixnum = atoi(optarg);
> +		if (test->msixnum < 1 || test->msixnum > 2048)
> +			goto usage;
> +		continue;
> +	case 'i':
> +		test->irqtype = atoi(optarg);
> +		if (test->irqtype < 0 || test->irqtype > 2)
> +			goto usage;
> +		test->set_irqtype = true;
> +		continue;
> +	case 'I':
> +		test->get_irqtype = true;
> +		continue;
>  	case 'r':
>  		test->read = true;
>  		continue;
> @@ -173,6 +219,9 @@ int main(int argc, char **argv)
>  			"\t-D <dev>		PCI endpoint test device {default: /dev/pci-endpoint-test.0}\n"
>  			"\t-b <bar num>		BAR test (bar number between 0..5)\n"
>  			"\t-m <msi num>		MSI test (msi number between 1..32)\n"
> +			"\t-x <msix num>	\tMSI-X test (msix number between 1..2048)\n"
> +			"\t-i <irq type>	\tSet IRQ type (0 - Legacy, 1 - MSI, 2 - MSI-X)\n"
> +			"\t-I			Get current IRQ type configured\n"
>  			"\t-l			Legacy IRQ test\n"
>  			"\t-r			Read buffer test\n"
>  			"\t-w			Write buffer test\n"
> diff --git a/tools/pci/pcitest.sh b/tools/pci/pcitest.sh
> index 77e8c85..75ed48f 100644
> --- a/tools/pci/pcitest.sh
> +++ b/tools/pci/pcitest.sh
> @@ -16,7 +16,10 @@ echo
>  echo "Interrupt tests"
>  echo
>  
> +pcitest -i 0
>  pcitest -l
> +
> +pcitest -i 1
>  msi=1
>  
>  while [ $msi -lt 33 ]
> @@ -26,9 +29,21 @@ do
>  done
>  echo
>  
> +pcitest -i 2
> +msix=1
> +
> +while [ $msix -lt 2049 ]
> +do
> +        pcitest -x $msix
> +        msix=`expr $msix + 1`
> +done
> +echo
> +
>  echo "Read Tests"
>  echo
>  
> +pcitest -i 1
> +
>  pcitest -r -s 1
>  pcitest -r -s 1024
>  pcitest -r -s 1025
> 
