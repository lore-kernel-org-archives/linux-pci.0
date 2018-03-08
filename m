Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:46700 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751865AbeCHH4D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Mar 2018 02:56:03 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Thu, 08 Mar 2018 13:26:02 +0530
From: poza@codeaurora.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v12 3/6] PCI/PORTDRV: Implement generic find service
In-Reply-To: <ac53deae-8fad-b896-805f-36343253a34b@codeaurora.org>
References: <1519837457-3596-1-git-send-email-poza@codeaurora.org>
 <1519837457-3596-4-git-send-email-poza@codeaurora.org>
 <ac53deae-8fad-b896-805f-36343253a34b@codeaurora.org>
Message-ID: <73d083f125a11dbc6779dae6c0ffa6e3@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-03-06 19:32, Sinan Kaya wrote:
> On 2/28/2018 12:04 PM, Oza Pawandeep wrote:
>> +struct pcie_port_service_driver *pcie_port_find_service(struct 
>> pci_dev *dev,
>> +							u32 service)
>> +{
>> +	struct pcie_port_service_driver *drv = NULL;
> 
> Remove initialization
> 
>> +	struct portdrv_service_data pdrvs;
>> +
>> +	pdrvs.service = service;
> 
> initialize pdrvs.drv = NULL here.
> 
good point, will take care of this. [along with other comments if any]

>> +	device_for_each_child(&dev->dev, &pdrvs, find_service_iter);
>> +
>> +	drv = pdrvs.drv;
>> +	return drv;
>> +}
