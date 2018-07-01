Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Sun, 01 Jul 2018 13:24:28 -0400
From: okaya@codeaurora.org
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4 7/7] PCI: Handle link reset via hotplug if supported
In-Reply-To: <20180701171443.GA28249@wunner.de>
References: <1530214274-21139-1-git-send-email-okaya@codeaurora.org>
 <1530214274-21139-7-git-send-email-okaya@codeaurora.org>
 <20180701171443.GA28249@wunner.de>
Message-ID: <7d0180b065e4a06a644ee754fb34b702@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-07-01 13:14, Lukas Wunner wrote:
> On Thu, Jun 28, 2018 at 03:31:05PM -0400, Sinan Kaya wrote:
>> +static pci_ers_result_t pciehp_reset_link(struct pci_dev *pdev)
>> +{
>> +	struct pcie_device *pciedev;
>> +	struct controller *ctrl;
>> +	struct device *devhp;
>> +	struct slot *slot;
>> +	int rc;
>> +
>> +	devhp = pcie_port_find_device(pdev, PCIE_PORT_SERVICE_HP);
>> +	pciedev = to_pcie_device(devhp);
>> +	ctrl = get_service_data(pciedev);
>> +	slot = ctrl->slot;
>> +
>> +	rc = reset_slot(slot->hotplug_slot, 0);
>> +
>> +	return !rc ? PCI_ERS_RESULT_RECOVERED : PCI_ERS_RESULT_DISCONNECT;
>> +}
> 
> This looks like a bit of a detour.  There's a "struct pci_slot *slot"
> pointer in struct pci_dev.  Any reason not to simply call:
> 
> 	rc = reset_slot(pdev->slot->hotplug_slot)

pdev here is the bridge. Slot pointers are only valid for children 
objects.


> 
> Lukas
