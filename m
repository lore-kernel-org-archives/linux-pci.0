Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:33057 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750742AbdIGF7T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Sep 2017 01:59:19 -0400
Subject: Re: [PATCH] PCI: endpoint: use correct "end of test" interrupt
To: John Keeping <john@metanate.com>
References: <20170906135524.12548-1-john@metanate.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <fee983c5-1fb9-85c0-f2cd-ce282dad7df3@ti.com>
Date: Thu, 7 Sep 2017 11:28:31 +0530
MIME-Version: 1.0
In-Reply-To: <20170906135524.12548-1-john@metanate.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Wednesday 06 September 2017 07:25 PM, John Keeping wrote:
> pci_epf_test_raise_irq() reads the interrupt to use for the response
> from reg->command, but this has been cleared at the beginning of the
> command handler so the value is always zero at this point.
> 
> Instead, extract the interrupt index before handling the command and
> then pass the requested interrupt into pci_epf_test_raise_irq().  This
> allows us to remove the specific code to extract the interrupt for
> COMMAND_RAISE_MSI_IRQ since it is now handled in common code.

Nice!
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
> Signed-off-by: John Keeping <john@metanate.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 4ddc6e8f9fe7..f9308c2f22e6 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -251,9 +251,8 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
>  	return ret;
>  }
>  
> -static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test)
> +static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test, u8 irq)
>  {
> -	u8 irq;
>  	u8 msi_count;
>  	struct pci_epf *epf = epf_test->epf;
>  	struct pci_epc *epc = epf->epc;
> @@ -262,7 +261,6 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test)
>  
>  	reg->status |= STATUS_IRQ_RAISED;
>  	msi_count = pci_epc_get_msi(epc);
> -	irq = (reg->command & MSI_NUMBER_MASK) >> MSI_NUMBER_SHIFT;
>  	if (irq > msi_count || msi_count <= 0)
>  		pci_epc_raise_irq(epc, PCI_EPC_IRQ_LEGACY, 0);
>  	else
> @@ -289,6 +287,8 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>  	reg->command = 0;
>  	reg->status = 0;
>  
> +	irq = (command & MSI_NUMBER_MASK) >> MSI_NUMBER_SHIFT;
> +
>  	if (command & COMMAND_RAISE_LEGACY_IRQ) {
>  		reg->status = STATUS_IRQ_RAISED;
>  		pci_epc_raise_irq(epc, PCI_EPC_IRQ_LEGACY, 0);
> @@ -301,7 +301,7 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>  			reg->status |= STATUS_WRITE_FAIL;
>  		else
>  			reg->status |= STATUS_WRITE_SUCCESS;
> -		pci_epf_test_raise_irq(epf_test);
> +		pci_epf_test_raise_irq(epf_test, irq);
>  		goto reset_handler;
>  	}
>  
> @@ -311,7 +311,7 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>  			reg->status |= STATUS_READ_SUCCESS;
>  		else
>  			reg->status |= STATUS_READ_FAIL;
> -		pci_epf_test_raise_irq(epf_test);
> +		pci_epf_test_raise_irq(epf_test, irq);
>  		goto reset_handler;
>  	}
>  
> @@ -321,13 +321,12 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>  			reg->status |= STATUS_COPY_SUCCESS;
>  		else
>  			reg->status |= STATUS_COPY_FAIL;
> -		pci_epf_test_raise_irq(epf_test);
> +		pci_epf_test_raise_irq(epf_test, irq);
>  		goto reset_handler;
>  	}
>  
>  	if (command & COMMAND_RAISE_MSI_IRQ) {
>  		msi_count = pci_epc_get_msi(epc);
> -		irq = (command & MSI_NUMBER_MASK) >> MSI_NUMBER_SHIFT;
>  		if (irq > msi_count || msi_count <= 0)
>  			goto reset_handler;
>  		reg->status = STATUS_IRQ_RAISED;
> 
