Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50120 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753535AbeCFOCb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Mar 2018 09:02:31 -0500
Subject: Re: [PATCH v12 3/6] PCI/PORTDRV: Implement generic find service
To: Oza Pawandeep <poza@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Timur Tabi <timur@codeaurora.org>
References: <1519837457-3596-1-git-send-email-poza@codeaurora.org>
 <1519837457-3596-4-git-send-email-poza@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <ac53deae-8fad-b896-805f-36343253a34b@codeaurora.org>
Date: Tue, 6 Mar 2018 09:02:26 -0500
MIME-Version: 1.0
In-Reply-To: <1519837457-3596-4-git-send-email-poza@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2/28/2018 12:04 PM, Oza Pawandeep wrote:
> +struct pcie_port_service_driver *pcie_port_find_service(struct pci_dev *dev,
> +							u32 service)
> +{
> +	struct pcie_port_service_driver *drv = NULL;

Remove initialization

> +	struct portdrv_service_data pdrvs;
> +
> +	pdrvs.service = service;

initialize pdrvs.drv = NULL here.

> +	device_for_each_child(&dev->dev, &pdrvs, find_service_iter);
> +
> +	drv = pdrvs.drv;
> +	return drv;
> +}


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
