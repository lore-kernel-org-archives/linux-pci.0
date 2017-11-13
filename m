Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [3/4] PCI/portdrv: Implement interface to query the registered
 service
To: Pawandeep Oza <poza@codeaurora.org>, linux-pci@vger.kernel.org,
 timur@codeaurora.org
References: <1510260399-14886-4-git-send-email-poza@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <73379e2c-b0c3-885c-bb5d-b981863b6042@codeaurora.org>
Date: Mon, 13 Nov 2017 15:52:27 -0500
MIME-Version: 1.0
In-Reply-To: <1510260399-14886-4-git-send-email-poza@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dongdong Liu <liudongdong3@huawei.com>, linux-arm-msm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Some nits only.

>  /**
> + * pcie_port_service_query - query if particula port service is enabled.
> + * dev: pcie device
> + * @port service: PCI express port service
> + */
> +int pcie_port_query_service(struct pci_dev *dev, u32 port_service)
> +{
> +	struct pcie_device *pdev;
> +	struct pci_dev *parent, *this = dev;
> +
> +	do {

While I understand the motivation why this function is searching for DPC capable
parent until the root port, the name of the function does not represent this. 

It might make sense to split this into two where the first function just queries
the capabilities of the immediate device (the list_for_each_section).

> +		list_for_each_entry(pdev, &this->service_list, slist) {
> +			if (pdev->service == port_service)
> +				return 1;
> +		}

Another function to query all parents until you reach the root port.

> +		parent = pci_upstream_bridge(this);
> +		this = parent;
> +	} while (parent && pci_is_pcie(parent));
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(pcie_port_query_service);
> +





-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
