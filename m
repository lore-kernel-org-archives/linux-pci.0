Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v13 4/6] PCI/DPC: Unify and plumb error handling into DPC
To: Keith Busch <keith.busch@intel.com>,
        Oza Pawandeep <poza@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Wei Zhang <wzhang@fb.com>, Timur Tabi <timur@codeaurora.org>
References: <1523284914-2037-1-git-send-email-poza@codeaurora.org>
 <1523284914-2037-5-git-send-email-poza@codeaurora.org>
 <20180409232957.GF6283@localhost.localdomain>
 <2c00f25e-9dac-7d75-8138-026ad4bcc7fa@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <632afd61-0013-64bd-0d19-fcd6f901804c@codeaurora.org>
Date: Mon, 9 Apr 2018 20:05:00 -0400
MIME-Version: 1.0
In-Reply-To: <2c00f25e-9dac-7d75-8138-026ad4bcc7fa@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 4/9/2018 7:51 PM, Sinan Kaya wrote:
> On 4/9/2018 7:29 PM, Keith Busch wrote:
>> On Mon, Apr 09, 2018 at 10:41:52AM -0400, Oza Pawandeep wrote:
>>> +static int find_dpc_dev_iter(struct device *device, void *data)
>>> +{
>>> +	struct pcie_port_service_driver *service_driver;
>>> +	struct device **dev;
>>> +
>>> +	dev = (struct device **) data;
>>> +
>>> +	if (device->bus == &pcie_port_bus_type && device->driver) {
>>> +		service_driver = to_service_driver(device->driver);
>>> +		if (service_driver->service == PCIE_PORT_SERVICE_DPC) {
>>> +			*dev = device;
>>> +			return 1;
>>> +		}
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static struct device *pci_find_dpc_dev(struct pci_dev *pdev)
>>> +{
>>> +	struct device *dev = NULL;
>>> +
>>> +	device_for_each_child(&pdev->dev, &dev, find_dpc_dev_iter);
>>> +
>>> +	return dev;
>>> +}
>>
>> The only caller of this doesn't seem to care to use struct device. This
>> should probably just extract struct dpc_dev directly from in here.
>>
> 
> Bjorn wants to kill the port service driver infrastructure but that is a much
> bigger task. 
> 
> How do we obtain the DPC object from the parent object directly? Each port
> service driver object is a children.
> 

How about implementing pcie_port_find_service_dev() as a follow up patch
to "PCI/PORTDRV: Implement generic find service" similar to what was done for
pcie_port_find_service()?

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
