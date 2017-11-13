Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
Date: Tue, 14 Nov 2017 04:56:30 +0530
From: poza@codeaurora.org
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [3/4] PCI/portdrv: Implement interface to query the registered
 service
In-Reply-To: <73379e2c-b0c3-885c-bb5d-b981863b6042@codeaurora.org>
References: <1510260399-14886-4-git-send-email-poza@codeaurora.org>
 <73379e2c-b0c3-885c-bb5d-b981863b6042@codeaurora.org>
Message-ID: <b98f5b7e1b64f9d5ce1ff7e52fa0887d@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>, linux-pci@vger.kernel.org,
 timur@codeaurora.org, linux-arm-kernel@lists.infradead.org,
 Dongdong Liu <liudongdong3@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 2017-11-14 02:22, Sinan Kaya wrote:
> Some nits only.
> 
>>  /**
>> + * pcie_port_service_query - query if particula port service is 
>> enabled.
>> + * dev: pcie device
>> + * @port service: PCI express port service
>> + */
>> +int pcie_port_query_service(struct pci_dev *dev, u32 port_service)
>> +{
>> +	struct pcie_device *pdev;
>> +	struct pci_dev *parent, *this = dev;
>> +
>> +	do {
> 
> While I understand the motivation why this function is searching for 
> DPC capable
> parent until the root port, the name of the function does not represent 
> this.
> 

Will change it to more relevant one.

> It might make sense to split this into two where the first function 
> just queries
> the capabilities of the immediate device (the list_for_each_section).
> 
>> +		list_for_each_entry(pdev, &this->service_list, slist) {
>> +			if (pdev->service == port_service)
>> +				return 1;
>> +		}
> 
> Another function to query all parents until you reach the root port.
> 
>> +		parent = pci_upstream_bridge(this);
>> +		this = parent;
>> +	} while (parent && pci_is_pcie(parent));
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(pcie_port_query_service);
>> +

yes that makes sense; will split the function as you are suggesting.

Regards,
Oza.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
