Return-Path: <SRS0=oPzr=6Q=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=oPzr=6Q=huawei.com=liudongdong3@kernel.org>
Subject: Re: PCI/DPC: Add eDPC support
To: Sinan Kaya <okaya@codeaurora.org>, <helgaas@kernel.org>
References: <1498295066-87895-1-git-send-email-liudongdong3@huawei.com>
 <c718120c-c8ec-0866-db6f-7ac0ac3af5ac@codeaurora.org>
CC: <linux-pci@vger.kernel.org>, <gabriele.paoloni@huawei.com>,
        <charles.chenxin@huawei.com>, <linuxarm@huawei.com>
From: Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <75f291f2-f820-82d5-2249-440009939a4f@huawei.com>
Date: Thu, 13 Jul 2017 20:20:39 +0800
MIME-Version: 1.0
In-Reply-To: <c718120c-c8ec-0866-db6f-7ac0ac3af5ac@codeaurora.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Sinan

Many thanks for your reveiw.

在 2017/7/13 4:52, Sinan Kaya 写道:
> On 6/24/2017 5:04 AM, Dongdong Liu wrote:
>> This code is to add eDPC support. Get and print the RP PIO error
>> information when the trigger condition is RP PIO error.
>>
>> For more information on eDPC, view the PCI-SIG eDPC ECN here:
>> https://pcisig.com/sites/default/files/specification_documents/ECN_Enhanced_DPC_2012-11-19_final.pdf
>>
>> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
>> ---
>>  drivers/pci/pcie/pcie-dpc.c   | 161 ++++++++++++++++++++++++++++++++++++++++++
>>  include/uapi/linux/pci_regs.h |  10 +++
>>  2 files changed, 171 insertions(+)
>>
>> diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
>> index 77d2ca9..00fdf87 100644
>> --- a/drivers/pci/pcie/pcie-dpc.c
>> +++ b/drivers/pci/pcie/pcie-dpc.c
>> @@ -16,11 +16,55 @@
>>  #include <linux/pcieport_if.h>
>>  #include "../pci.h">
>
> <snip>
>
>> +static void dpc_rp_pio_get_info(struct dpc_dev *dpc)
>> +{
>> +	struct pci_dev *pdev = dpc->dev->port;
>> +	struct dpc_rp_pio_regs *rp_pio = dpc->rp_pio;
>> +	int i;
>> +	u16 cap;
>> +	u16 status;
>> +
>> +	pci_read_config_dword(pdev, dpc->cap_pos + PCI_EXP_DPC_RP_PIO_STATUS,
>> +			      &rp_pio->status);
>> +	pci_read_config_dword(pdev, dpc->cap_pos + PCI_EXP_DPC_RP_PIO_MASK,
>> +			      &rp_pio->mask);
>> +
>> +	pci_read_config_dword(pdev, dpc->cap_pos + PCI_EXP_DPC_RP_PIO_SEVERITY,
>> +			      &rp_pio->severity);
>> +	pci_read_config_dword(pdev, dpc->cap_pos + PCI_EXP_DPC_RP_PIO_SYSERROR,
>> +			      &rp_pio->syserror);
>> +	pci_read_config_dword(pdev, dpc->cap_pos + PCI_EXP_DPC_RP_PIO_EXCEPTION,
>> +			      &rp_pio->exception);
>> +
>> +	/* Get First Error Pointer */
>> +	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_STATUS, &status);
>> +	rp_pio->first_error = (status & 0x1f00) >> 8;
>> +
>> +	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CAP, &cap);
>> +	rp_pio->log_size = (cap & PCI_EXP_DPC_RP_PIO_LOG_SIZE) >> 8;
>> +	if (rp_pio->log_size < 4 || rp_pio->log_size > 9) {
>> +		dev_err(&pdev->dev, "RP PIO log size %u is invaild\n",
>> +			rp_pio->log_size);
>> +		return;
>> +	}
>> +
>> +	pci_read_config_dword(pdev,
>> +			      dpc->cap_pos + PCI_EXP_DPC_RP_PIO_HEADER_LOG,
>> +			      &rp_pio->header_log.dw0);
>> +	pci_read_config_dword(pdev,
>> +			      dpc->cap_pos + PCI_EXP_DPC_RP_PIO_HEADER_LOG + 4,
>> +			      &rp_pio->header_log.dw1);
>> +	pci_read_config_dword(pdev,
>> +			      dpc->cap_pos + PCI_EXP_DPC_RP_PIO_HEADER_LOG + 8,
>> +			      &rp_pio->header_log.dw2);
>> +	pci_read_config_dword(pdev,
>> +			      dpc->cap_pos + PCI_EXP_DPC_RP_PIO_HEADER_LOG + 12,
>> +			      &rp_pio->header_log.dw3);
>> +	if (rp_pio->log_size == 4)
>> +		return;
>> +
>> +	pci_read_config_dword(pdev,
>> +			      dpc->cap_pos + PCI_EXP_DPC_RP_PIO_IMPSPEC_LOG,
>> +			      &rp_pio->impspec_log);
>> +	for (i = 0; i < rp_pio->log_size - 5; i++)
>> +		pci_read_config_dword(pdev,
>> +			dpc->cap_pos + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG,
>> +			&rp_pio->tlp_prefix_log[i]);
>> +}
>> +
>> +static void dpc_precess_rp_pio_error(struct dpc_dev *dpc)
>> +{
>
> Why not have a stack local variable where you collect the information
> on the first function and print it on the second function.
>
> What benefit the allocated memory brings?

will be fixed as below.

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index 9addc76..77fe097 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -42,7 +42,7 @@ struct dpc_dev {
         struct work_struct      work;
         int                     cap_pos;
         bool                    rp;
-   struct dpc_rp_pio_regs  *rp_pio;
+ u32                         rp_pio_status;
  };

  static const char * const rp_pio_error_string[] = {
@@ -123,10 +123,10 @@ static void interrupt_event_handler(struct work_struct *work)
         dpc_wait_link_inactive(pdev);
         if (dpc->rp && dpc_wait_rp_inactive(dpc))
                 return;
-   if (dpc->rp && dpc->rp_pio->status)
+ if (dpc->rp && dpc->rp_pio_status)
                 pci_write_config_dword(pdev,
                                       dpc->cap_pos + PCI_EXP_DPC_RP_PIO_STATUS,
-                                 dpc->rp_pio->status);
+                               dpc->rp_pio_status);

         pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_STATUS,
                 PCI_EXP_DPC_STATUS_TRIGGER | PCI_EXP_DPC_STATUS_INTERRUPT);
@@ -139,10 +139,9 @@ static void dpc_rp_pio_print_tlp_header(struct pci_dev *dev,
                 t->dw0, t->dw1, t->dw2, t->dw3);
  }

-static void dpc_rp_pio_print_error(struct dpc_dev *dpc)
+static void dpc_rp_pio_print_error(struct dpc_dev *dpc, struct dpc_rp_pio_regs *rp_pio)
  {
         struct pci_dev *pdev = dpc->dev->port;
-   struct dpc_rp_pio_regs *rp_pio = dpc->rp_pio;
         int i;
         u32 status;

@@ -172,10 +171,9 @@ static void dpc_rp_pio_print_error(struct dpc_dev *dpc)
                         rp_pio->tlp_prefix_log[i]);
  }

-static void dpc_rp_pio_get_info(struct dpc_dev *dpc)
+static void dpc_rp_pio_get_info(struct dpc_dev *dpc, struct dpc_rp_pio_regs *rp_pio)
  {
         struct pci_dev *pdev = dpc->dev->port;
-   struct dpc_rp_pio_regs *rp_pio = dpc->rp_pio;
         int i;
         u16 cap;
         u16 status;
@@ -230,8 +228,12 @@ static void dpc_rp_pio_get_info(struct dpc_dev *dpc)

  static void dpc_precess_rp_pio_error(struct dpc_dev *dpc)
  {
-   dpc_rp_pio_get_info(dpc);
-   dpc_rp_pio_print_error(dpc);
+ struct dpc_rp_pio_regs rp_pio_regs;
+
+ dpc_rp_pio_get_info(dpc, &rp_pio_regs);
+ dpc_rp_pio_print_error(dpc, &rp_pio_regs);
+
+ dpc->rp_pio_status = rp_pio_regs.status;
  }

  static irqreturn_t dpc_irq(int irq, void *context)
@@ -299,12 +301,6 @@ static int dpc_probe(struct pcie_device *dev)

         dpc->rp = (cap & PCI_EXP_DPC_CAP_RP_EXT);

-   if (dpc->rp) {
-           dpc->rp_pio = devm_kzalloc(&pdev->dev, sizeof(*dpc->rp_pio),
-                                      GFP_KERNEL);
-           if (!dpc->rp_pio)
-                   return -ENOMEM;
-   }

Thanks
Dongdong
>
>> +	dpc_rp_pio_get_info(dpc);
>> +	dpc_rp_pio_print_error(dpc);
>> +}
>> +
>
>> @@ -144,6 +299,12 @@ static int dpc_probe(struct pcie_device *dev)
>>
>>  	dpc->rp = (cap & PCI_EXP_DPC_CAP_RP_EXT);
>>
>> +	if (dpc->rp) {
>> +		dpc->rp_pio = devm_kzalloc(&pdev->dev, sizeof(*dpc->rp_pio),
>> +					   GFP_KERNEL);
>> +		if (!dpc->rp_pio)
>> +			return -ENOMEM;
>> +	}
>>  	ctl |= PCI_EXP_DPC_CTL_EN_NONFATAL | PCI_EXP_DPC_CTL_INT_EN;
>>  	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, ctl);
>>
>
