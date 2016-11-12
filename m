Return-Path: <kishon@ti.com>
Return-Path: <kishon@ti.com>
Subject: Re: [PATCH -next] PCI: dra7xx: Add missing of_node_put() in
 dra7xx_pcie_init_irq_domain()
To: Bjorn Helgaas <helgaas@kernel.org>, Wei Yongjun <weiyj.lk@gmail.com>
References: <1476716077-30379-1-git-send-email-weiyj.lk@gmail.com>
 <20161111213806.GI9868@bhelgaas-glaptop.roam.corp.google.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <1d95b915-ddc0-b48f-270b-fffb60ecfe5e@ti.com>
Date: Sat, 12 Nov 2016 12:39:01 +0530
MIME-Version: 1.0
In-Reply-To: <20161111213806.GI9868@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Saturday 12 November 2016 03:08 AM, Bjorn Helgaas wrote:
> On Mon, Oct 17, 2016 at 02:54:37PM +0000, Wei Yongjun wrote:
>> From: Wei Yongjun <weiyongjun1@huawei.com>
>>
>> This node pointer is returned by of_get_next_child() with refcount
>> incremented in this function. of_node_put() on it before exitting
>> this function on error.
>>
>> This is detected by Coccinelle semantic patch.
>>
>> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Kishon, this looks correct to me, so I applied it to pci/host-dra7xx for
> v4.10.  Let me know if you have any issue with it.
> 
>> ---
>>  drivers/pci/host/pci-dra7xx.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
>> index 9595fad..79297e9 100644
>> --- a/drivers/pci/host/pci-dra7xx.c
>> +++ b/drivers/pci/host/pci-dra7xx.c
>> @@ -177,6 +177,7 @@ static int dra7xx_pcie_init_irq_domain(struct pcie_port *pp)
>>  					       &intx_domain_ops, pp);
>>  	if (!pp->irq_domain) {
>>  		dev_err(dev, "Failed to get a INTx IRQ domain\n");
>> +		of_node_put(pcie_intc_node);

I think of_node_put should be used for both the error case and non-error case.

Thanks
Kishon
