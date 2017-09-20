Return-Path: <SRS0=Gr4L=AV=axis.com=niklas.cassel@kernel.org>
Return-Path: <SRS0=Gr4L=AV=axis.com=niklas.cassel@kernel.org>
Subject: Re: Re: [PATCH] PCI: endpoint: use correct "end of test" interrupt
To: Bjorn Helgaas <helgaas@kernel.org>, John Keeping <john@metanate.com>
CC: Kishon Vijay Abraham I <kishon@ti.com>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>
References: <20170906135524.12548-1-john@metanate.com>
 <20170919192546.GC22312@bhelgaas-glaptop.roam.corp.google.com>
From: Niklas Cassel <niklas.cassel@axis.com>
Message-ID: <4ee1e759-ab9b-fd84-3e1f-2ceff782a6fc@axis.com>
Date: Wed, 20 Sep 2017 16:21:44 +0200
MIME-Version: 1.0
In-Reply-To: <20170919192546.GC22312@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-pci.vger.kernel.org>

On 09/19/2017 09:25 PM, Bjorn Helgaas wrote:
> On Wed, Sep 06, 2017 at 02:55:24PM +0100, John Keeping wrote:
>> pci_epf_test_raise_irq() reads the interrupt to use for the response
>> from reg->command, but this has been cleared at the beginning of the
>> command handler so the value is always zero at this point.
>>
>> Instead, extract the interrupt index before handling the command and
>> then pass the requested interrupt into pci_epf_test_raise_irq().  This
>> allows us to remove the specific code to extract the interrupt for
>> COMMAND_RAISE_MSI_IRQ since it is now handled in common code.
>>
>> Signed-off-by: John Keeping <john@metanate.com>
> 
> Applied with Kishon's ack to pci/endpoint for v4.15, thanks!

Hello PCI hackers!

I actually think that this patch should be applied to v4.14,
since it actually fixes a regression introduced by commit
3ecf3232c54c ("PCI: endpoint: Do not reset *command* inadvertently")
which is included in v4.14-rc1.

It would have been nice if this patch actually had a fixes-tag.

(I cannot do any read/write/copy tests if I include 3ecf3232c54c,
but if I include 3ecf3232c54c + this patch, all tests work again.)

Regards,
Niklas

> 
>> ---
>>  drivers/pci/endpoint/functions/pci-epf-test.c | 13 ++++++-------
>>  1 file changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
>> index 4ddc6e8f9fe7..f9308c2f22e6 100644
>> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
>> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
>> @@ -251,9 +251,8 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
>>  	return ret;
>>  }
>>  
>> -static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test)
>> +static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test, u8 irq)
>>  {
>> -	u8 irq;
>>  	u8 msi_count;
>>  	struct pci_epf *epf = epf_test->epf;
>>  	struct pci_epc *epc = epf->epc;
>> @@ -262,7 +261,6 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test)
>>  
>>  	reg->status |= STATUS_IRQ_RAISED;
>>  	msi_count = pci_epc_get_msi(epc);
>> -	irq = (reg->command & MSI_NUMBER_MASK) >> MSI_NUMBER_SHIFT;
>>  	if (irq > msi_count || msi_count <= 0)
>>  		pci_epc_raise_irq(epc, PCI_EPC_IRQ_LEGACY, 0);
>>  	else
>> @@ -289,6 +287,8 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>>  	reg->command = 0;
>>  	reg->status = 0;
>>  
>> +	irq = (command & MSI_NUMBER_MASK) >> MSI_NUMBER_SHIFT;
>> +
>>  	if (command & COMMAND_RAISE_LEGACY_IRQ) {
>>  		reg->status = STATUS_IRQ_RAISED;
>>  		pci_epc_raise_irq(epc, PCI_EPC_IRQ_LEGACY, 0);
>> @@ -301,7 +301,7 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>>  			reg->status |= STATUS_WRITE_FAIL;
>>  		else
>>  			reg->status |= STATUS_WRITE_SUCCESS;
>> -		pci_epf_test_raise_irq(epf_test);
>> +		pci_epf_test_raise_irq(epf_test, irq);
>>  		goto reset_handler;
>>  	}
>>  
>> @@ -311,7 +311,7 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>>  			reg->status |= STATUS_READ_SUCCESS;
>>  		else
>>  			reg->status |= STATUS_READ_FAIL;
>> -		pci_epf_test_raise_irq(epf_test);
>> +		pci_epf_test_raise_irq(epf_test, irq);
>>  		goto reset_handler;
>>  	}
>>  
>> @@ -321,13 +321,12 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>>  			reg->status |= STATUS_COPY_SUCCESS;
>>  		else
>>  			reg->status |= STATUS_COPY_FAIL;
>> -		pci_epf_test_raise_irq(epf_test);
>> +		pci_epf_test_raise_irq(epf_test, irq);
>>  		goto reset_handler;
>>  	}
>>  
>>  	if (command & COMMAND_RAISE_MSI_IRQ) {
>>  		msi_count = pci_epc_get_msi(epc);
>> -		irq = (command & MSI_NUMBER_MASK) >> MSI_NUMBER_SHIFT;
>>  		if (irq > msi_count || msi_count <= 0)
>>  			goto reset_handler;
>>  		reg->status = STATUS_IRQ_RAISED;
>> -- 
>> 2.14.1
>>
